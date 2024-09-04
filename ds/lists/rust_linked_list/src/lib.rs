use std::{cell::RefCell, rc::Rc};

type NodeRef<T> = Option<Rc<RefCell<Node<T>>>>;

type Result<T> = std::result::Result<T, IndexOutOfBoundError>;

struct IndexOutOfBoundError;

struct Node<T> {
    el: T,
    next: NodeRef<T>,
}

impl<T> Node<T> {
    fn new(el: T) -> Node<T> {
        Node { el, next: None }
    }

    fn new_node_ref(el: T) -> NodeRef<T> {
        Some(Rc::new(RefCell::new(Node::new(el))))
    }
}

struct SinglyLinkedList<T> {
    node: NodeRef<T>,
}

impl<'a, T> SinglyLinkedList<T> {
    fn new(el: T) -> SinglyLinkedList<T> {
        SinglyLinkedList {
            node: Some(Rc::new(RefCell::new(Node::new(el)))),
        }
    }

    fn iter(&mut self) -> NodeIter<T> {
        NodeIter {
            next: self.node.clone(),
        }
    }

    fn get_nth_node(&mut self, nth: usize) -> NodeRef<T> {
        self.iter().nth(nth)
    }

    fn get_nth_value(&mut self, nth: usize) -> Option<T>
    where
        T: Copy,
    {
        self.iter().nth(nth).map(|node| node.borrow().el.clone())
    }

    fn set_nth(&mut self, nth: usize, el: T) {
        self.iter().nth(nth).map(|node| {
            node.borrow_mut().el = el;
        });
    }

    fn length(&mut self) -> usize {
        self.iter().count()
    }

    fn contains(&mut self, el: &T) -> bool
    where
        T: PartialEq,
    {
        self.iter().any(|node| &node.borrow().el == el)
    }

    fn append(&mut self, el: T) {
        self.iter().last().map(|node| {
            let new_node = Node::new_node_ref(el);
            node.borrow_mut().next = new_node;
        });
    }

    fn insert_at_nth(&mut self, nth: usize, el: T) -> Result<()> {
        let prev_node = self.get_nth_node(nth - 1);
        let nth_node = self.get_nth_node(nth);
        let new_node = Node::new_node_ref(el);

        if let Some(prev_node) = prev_node {
            new_node
                .as_ref()
                .expect("node just created, should always exist")
                .clone()
                .borrow_mut()
                .next = nth_node.clone();

            prev_node.clone().borrow_mut().next = new_node;

            Ok(())
        } else {
            Err(IndexOutOfBoundError)
        }
    }

    fn pop(&mut self) -> Option<T>
    where
        T: Copy,
    {
        let last_el = self
            .iter()
            .last()
            .take()
            .map(|node| node.borrow().el.clone());

        let length = self.length();

        let second_last_node = self.get_nth_node(length - 2);
        second_last_node.map(|node| {
            node.borrow_mut().next = None;
        });

        last_el
    }
}

struct NodeIter<T> {
    next: NodeRef<T>,
}

impl<T> Iterator for NodeIter<T> {
    type Item = Rc<RefCell<Node<T>>>;

    fn next(&mut self) -> Option<Self::Item> {
        let next = self.next.take();
        next.as_ref().map(|node| {
            self.next = node.borrow().next.clone();
            Rc::clone(node)
        })
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_new() {
        let mut list = SinglyLinkedList::new(1);
        assert_eq!(list.length(), 1);
    }

    #[test]
    fn test_append() {
        let mut list = SinglyLinkedList::new(1);
        list.append(2);
        assert_eq!(list.length(), 2);
    }

    #[test]
    fn test_get_nth_node() {
        let mut list = SinglyLinkedList::new(1);
        list.append(2);
        list.append(3);
        assert_eq!(list.get_nth_value(1), Some(2));
        assert_eq!(list.get_nth_value(2), Some(3));
    }

    #[test]
    fn test_set_nth() {
        let mut list = SinglyLinkedList::new(1);
        list.append(2);
        list.append(3);
        list.set_nth(1, 4);
        assert_eq!(list.get_nth_value(1), Some(4));
        assert_eq!(list.get_nth_value(2), Some(3));
    }

    #[test]
    fn test_contains() {
        let mut list = SinglyLinkedList::new(1);
        list.append(2);
        list.append(3);
        assert_eq!(list.contains(&2), true);
        assert_eq!(list.contains(&4), false);
    }

    #[test]
    fn test_insert_at_nth() {
        let mut list = SinglyLinkedList::new(1);
        list.append(2);
        list.append(3);
        _ = list.insert_at_nth(1, 4);
        assert_eq!(list.get_nth_value(0), Some(1));
        assert_eq!(list.get_nth_value(1), Some(4));
        assert_eq!(list.get_nth_value(2), Some(2));
        assert_eq!(list.get_nth_value(3), Some(3));
    }

    #[test]
    fn test_pop() {
        let mut list = SinglyLinkedList::new(1);
        list.append(2);
        list.append(3);
        let popped = list.pop();
        assert_eq!(popped, Some(3));
        assert_eq!(list.length(), 2);
    }
}

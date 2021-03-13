# 3. State Management - Bloc

Date: 2021-03-13

## Status

Accepted

## Context

https://bloclibrary.dev/#/whybloc

## Decision

Introduce a flutter-specific, event-based state management tool for avoiding stateful widgets and segregating business logic across multiple components

## Consequences

Enforcing a single way to change state throughout an entire application.

Build components with `StatelessWidget` wherever possible. Encourage keeping state and business logic contained within the BloC pattern implementation, and detached from the presentation layer.

https://bloclibrary.dev/#/architecture




# 2. Firebase

Date: 2021-03-13

## Status

Accepted

## Context

This project is based on the Typescript implementation of Keepscore, that is using Firebase as a backend as a service platform for authentication/data access/file storage, etc.

## Decision

Use Firebase for authentication / database / file storage / analytics, etc.

## Consequences

This has an effect on the state management choices that will be made in the future, as they need to be compatible/a good match for firebase data flows

Firebase will bring real-time data functionality to the app

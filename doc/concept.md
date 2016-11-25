# Concept

## role Serializable

### method serialize : turns attribute "payload" into a byte array

---

## class Field

### attr $ name
### attr $ size
### attr $ value
### attr $ endian

Provides field name and value

---

## class Protocol

### attr @ fields  : an ordered array of fields
### attr $ payload : can be any object that does Serializable

### method makeClass

Different instances shares same fields because they are fixed.
Question: how to implement? meta-programming?

---

## class 



;; @xform export "foo" (anyref_owned)

(module
  (import "__wbindgen_anyref_xform__" "__wbindgen_anyref_table_grow"
    (func $grow (param i32) (result i32)))
  (func $foo (export "foo") (param i32)
    i32.const 0
    call $grow
    drop)
  (func $alloc (export "__anyref_table_alloc") (result i32)
    i32.const 0)
  (func $dealloc (export "__anyref_table_dealloc") (param i32))
)

(; CHECK-ALL:
(module
  (type (;0;) (func (result i32)))
  (type (;1;) (func (param i32)))
  (type (;2;) (func (param anyref)))
  (func $foo anyref shim (type 2) (param anyref)
    (local i32)
    call $alloc
    local.tee 1
    local.get 0
    table.set 0
    local.get 1
    call $foo)
  (func $foo (type 1) (param i32)
    ref.null
    i32.const 0
    table.grow 0
    drop)
  (func $alloc (type 0) (result i32)
    i32.const 0)
  (table (;0;) 32 anyref)
  (export "foo" (func $foo anyref shim)))
;)
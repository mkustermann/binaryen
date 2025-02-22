;; NOTE: Assertions have been generated by update_lit_checks.py --all-items and should not be edited.

;; RUN: wasm-as %s -all -g -o %t.wasm
;; RUN: wasm-dis %t.wasm -all -o %t.wast
;; RUN: wasm-as %s -all -o %t.nodebug.wasm
;; RUN: wasm-dis %t.nodebug.wasm -all -o %t.nodebug.wast
;; RUN: wasm-opt %t.wast -all -o %t.text.wast -g -S
;; RUN: cat %t.wast | filecheck %s --check-prefix=CHECK-BINARY
;; RUN: cat %t.nodebug.wast | filecheck %s --check-prefix=CHECK-NODEBUG
;; RUN: cat %t.text.wast | filecheck %s --check-prefix=CHECK-TEXT

(module
  ;; CHECK-BINARY:      (type $none_=>_none (func))

  ;; CHECK-BINARY:      (type $none_=>_i32 (func (result i32)))

  ;; CHECK-BINARY:      (type $i32_=>_i32 (func (param i32) (result i32)))

  ;; CHECK-BINARY:      (table $table-1 1 1 funcref)
  ;; CHECK-TEXT:      (type $none_=>_none (func))

  ;; CHECK-TEXT:      (type $none_=>_i32 (func (result i32)))

  ;; CHECK-TEXT:      (type $i32_=>_i32 (func (param i32) (result i32)))

  ;; CHECK-TEXT:      (table $table-1 1 1 funcref)
  (table $table-1 funcref
    (elem $foo)
  )

  ;; CHECK-BINARY:      (table $table-2 3 3 funcref)
  ;; CHECK-TEXT:      (table $table-2 3 3 funcref)
  (table $table-2 funcref
    (elem $bar $bar $bar)
  )

  ;; CHECK-BINARY:      (elem $0 (table $table-1) (i32.const 0) func $foo)

  ;; CHECK-BINARY:      (elem $1 (table $table-2) (i32.const 0) func $bar $bar $bar)

  ;; CHECK-BINARY:      (func $foo
  ;; CHECK-BINARY-NEXT:  (nop)
  ;; CHECK-BINARY-NEXT: )
  ;; CHECK-TEXT:      (elem $0 (table $table-1) (i32.const 0) func $foo)

  ;; CHECK-TEXT:      (elem $1 (table $table-2) (i32.const 0) func $bar $bar $bar)

  ;; CHECK-TEXT:      (func $foo
  ;; CHECK-TEXT-NEXT:  (nop)
  ;; CHECK-TEXT-NEXT: )
  (func $foo
    (nop)
  )
  ;; CHECK-BINARY:      (func $bar
  ;; CHECK-BINARY-NEXT:  (drop
  ;; CHECK-BINARY-NEXT:   (table.get $table-1
  ;; CHECK-BINARY-NEXT:    (i32.const 0)
  ;; CHECK-BINARY-NEXT:   )
  ;; CHECK-BINARY-NEXT:  )
  ;; CHECK-BINARY-NEXT:  (drop
  ;; CHECK-BINARY-NEXT:   (table.get $table-2
  ;; CHECK-BINARY-NEXT:    (i32.const 100)
  ;; CHECK-BINARY-NEXT:   )
  ;; CHECK-BINARY-NEXT:  )
  ;; CHECK-BINARY-NEXT: )
  ;; CHECK-TEXT:      (func $bar
  ;; CHECK-TEXT-NEXT:  (drop
  ;; CHECK-TEXT-NEXT:   (table.get $table-1
  ;; CHECK-TEXT-NEXT:    (i32.const 0)
  ;; CHECK-TEXT-NEXT:   )
  ;; CHECK-TEXT-NEXT:  )
  ;; CHECK-TEXT-NEXT:  (drop
  ;; CHECK-TEXT-NEXT:   (table.get $table-2
  ;; CHECK-TEXT-NEXT:    (i32.const 100)
  ;; CHECK-TEXT-NEXT:   )
  ;; CHECK-TEXT-NEXT:  )
  ;; CHECK-TEXT-NEXT: )
  (func $bar
    (drop
      (table.get $table-1
        (i32.const 0)
      )
    )
    (drop
      (table.get $table-2
        (i32.const 100)
      )
    )
  )

  ;; CHECK-BINARY:      (func $set-get
  ;; CHECK-BINARY-NEXT:  (table.set $table-1
  ;; CHECK-BINARY-NEXT:   (i32.const 0)
  ;; CHECK-BINARY-NEXT:   (ref.func $foo)
  ;; CHECK-BINARY-NEXT:  )
  ;; CHECK-BINARY-NEXT:  (drop
  ;; CHECK-BINARY-NEXT:   (table.get $table-1
  ;; CHECK-BINARY-NEXT:    (i32.const 0)
  ;; CHECK-BINARY-NEXT:   )
  ;; CHECK-BINARY-NEXT:  )
  ;; CHECK-BINARY-NEXT: )
  ;; CHECK-TEXT:      (func $set-get
  ;; CHECK-TEXT-NEXT:  (table.set $table-1
  ;; CHECK-TEXT-NEXT:   (i32.const 0)
  ;; CHECK-TEXT-NEXT:   (ref.func $foo)
  ;; CHECK-TEXT-NEXT:  )
  ;; CHECK-TEXT-NEXT:  (drop
  ;; CHECK-TEXT-NEXT:   (table.get $table-1
  ;; CHECK-TEXT-NEXT:    (i32.const 0)
  ;; CHECK-TEXT-NEXT:   )
  ;; CHECK-TEXT-NEXT:  )
  ;; CHECK-TEXT-NEXT: )
  (func $set-get
    (table.set $table-1
      (i32.const 0)
      (ref.func $foo)
    )
    (drop
      (table.get $table-1
        (i32.const 0)
      )
    )
  )

  ;; CHECK-BINARY:      (func $get-table-size (result i32)
  ;; CHECK-BINARY-NEXT:  (table.size $table-1)
  ;; CHECK-BINARY-NEXT: )
  ;; CHECK-TEXT:      (func $get-table-size (result i32)
  ;; CHECK-TEXT-NEXT:  (table.size $table-1)
  ;; CHECK-TEXT-NEXT: )
  (func $get-table-size (result i32)
    (table.size $table-1)
  )

  ;; CHECK-BINARY:      (func $table-grow (param $sz i32) (result i32)
  ;; CHECK-BINARY-NEXT:  (table.grow $table-1
  ;; CHECK-BINARY-NEXT:   (ref.null nofunc)
  ;; CHECK-BINARY-NEXT:   (local.get $sz)
  ;; CHECK-BINARY-NEXT:  )
  ;; CHECK-BINARY-NEXT: )
  ;; CHECK-TEXT:      (func $table-grow (param $sz i32) (result i32)
  ;; CHECK-TEXT-NEXT:  (table.grow $table-1
  ;; CHECK-TEXT-NEXT:   (ref.null nofunc)
  ;; CHECK-TEXT-NEXT:   (local.get $sz)
  ;; CHECK-TEXT-NEXT:  )
  ;; CHECK-TEXT-NEXT: )
  (func $table-grow (param $sz i32) (result i32)
    (table.grow $table-1 (ref.null func) (local.get $sz))
  )
)
;; CHECK-NODEBUG:      (type $none_=>_none (func))

;; CHECK-NODEBUG:      (type $none_=>_i32 (func (result i32)))

;; CHECK-NODEBUG:      (type $i32_=>_i32 (func (param i32) (result i32)))

;; CHECK-NODEBUG:      (table $0 1 1 funcref)

;; CHECK-NODEBUG:      (table $1 3 3 funcref)

;; CHECK-NODEBUG:      (elem $0 (table $0) (i32.const 0) func $0)

;; CHECK-NODEBUG:      (elem $1 (table $1) (i32.const 0) func $1 $1 $1)

;; CHECK-NODEBUG:      (func $0
;; CHECK-NODEBUG-NEXT:  (nop)
;; CHECK-NODEBUG-NEXT: )

;; CHECK-NODEBUG:      (func $1
;; CHECK-NODEBUG-NEXT:  (drop
;; CHECK-NODEBUG-NEXT:   (table.get $0
;; CHECK-NODEBUG-NEXT:    (i32.const 0)
;; CHECK-NODEBUG-NEXT:   )
;; CHECK-NODEBUG-NEXT:  )
;; CHECK-NODEBUG-NEXT:  (drop
;; CHECK-NODEBUG-NEXT:   (table.get $1
;; CHECK-NODEBUG-NEXT:    (i32.const 100)
;; CHECK-NODEBUG-NEXT:   )
;; CHECK-NODEBUG-NEXT:  )
;; CHECK-NODEBUG-NEXT: )

;; CHECK-NODEBUG:      (func $2
;; CHECK-NODEBUG-NEXT:  (table.set $0
;; CHECK-NODEBUG-NEXT:   (i32.const 0)
;; CHECK-NODEBUG-NEXT:   (ref.func $0)
;; CHECK-NODEBUG-NEXT:  )
;; CHECK-NODEBUG-NEXT:  (drop
;; CHECK-NODEBUG-NEXT:   (table.get $0
;; CHECK-NODEBUG-NEXT:    (i32.const 0)
;; CHECK-NODEBUG-NEXT:   )
;; CHECK-NODEBUG-NEXT:  )
;; CHECK-NODEBUG-NEXT: )

;; CHECK-NODEBUG:      (func $3 (result i32)
;; CHECK-NODEBUG-NEXT:  (table.size $0)
;; CHECK-NODEBUG-NEXT: )

;; CHECK-NODEBUG:      (func $4 (param $0 i32) (result i32)
;; CHECK-NODEBUG-NEXT:  (table.grow $0
;; CHECK-NODEBUG-NEXT:   (ref.null nofunc)
;; CHECK-NODEBUG-NEXT:   (local.get $0)
;; CHECK-NODEBUG-NEXT:  )
;; CHECK-NODEBUG-NEXT: )

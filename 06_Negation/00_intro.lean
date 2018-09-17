/-


* proposition built using ¬ 
* the formal meaning of ¬ 
* proofs of inequalities, ¬a=b
* disjointness of constructors
* strategy: proof by negation
* inference rule: modus tollens
* principle: non-contradiction
* rule: negation elimination
* axiom: excluded middle
* classical vs constructive logic
* double-negation elimination
* proof by contradiction
* proof by contrapositive 
-/

/-   **********************
     *** ¬ Introduction ***
     **********************
-/

/-
In constructive logic, if we can 
construct a proof of a proposition,
P, then we can judge it to be true. 

What does it mean in constructive
logic for a proposition, P, to be 
false?

It means that there is a proof that
there can be no proof of P. The way
we express this is that from a proof
of P we could derive a contradiction:
a proof of false. Because there can
be no such thing, there must be no
proof of P. In other words, to show
that ¬ P is true we prove P → false. 
Indeed, the proposition ¬ P is just
defined as the proposition P → false. 

A proof of P → false, as with any 
proof of an implication, will be 
given as a function: one that 
takes a proof of P as an argument
and derives a proof of false. As
there is no proof of false, such
an argument cannot exist. From 
the existence of the function we
conclude the non-existence of any
proof of P: that is, ¬ P.

From now on, when working in 
constructive logic, when you see 
a proof of a proposition, ¬ P, it
is worthwhile viewing it as a value
of type P → false, which is to say
as a function taking proofs of P
and returning proofs of false.  
-/

/-
Check it: ¬ P is the same as P → false
-/
variable P : Prop -- assume P is some Prop
-- now show ¬ P = P → false from (using) rfl.
theorem same : (¬ P) = (P → false) := rfl


/-
In previous chapters we've worked with
many equality propositions. What about
inequality propositions? By x ≠ y, we
mean simply ¬ x = y. As an example, 
0 ≠ 1 is just different notation for
¬ 0 = 1. Note that in Lean, = binds 
more tightly (has a higher precedence) 
than ¬, so ¬ 0 = 1 means ¬ (0 = 1), 
rather than (¬ 0) = 1.
-/


/-
Now in turn we understand ¬ 0 = 1 to 
mean 0 = 1 → false. How can we prove 
such an implication? We already know it
will be with a function that derives a
proof of false from a proof of 0 = 1. 
-/

/-
The short, satisfying, but ultimately
unenlightening answer is that Lean 
just knows that it's true. We write 
the proposition, then write a period, 
and Lean does the rest! Here it is.
-/

theorem zneqo : 0 ≠ 1. -- note period
#check zneqo

/-
Note that the types, 0 ≠ 1, ¬ 0 = 1,
and 0 = 1 → false, look different but
in fact they are just different ways
of expressing the same type.
-/

/-
We' now explain in a little more
detail what's going on. How does
"Lean know" there's a proof and
how to construct it? We present
the following elaborated proof,
and then explain it after the
code. They thing to focus on is
that nat.no_confusion construct.
It in turn is using what we call
"disjointness of constructors" to
construct a proof of false.

Let's start by just looking at
the actual proof of 0 ≠ 1, which
we write here as 0 = 1 → false to
make it clear that 0 ≠ 1 is really
a proposition in the form of an
implication.
-/

theorem zneqo' : 0 = 1 → false := 
    λ h : (0 = 1), 
        nat.no_confusion h
#check zneqo'


/-
You can see that the proof, being
a proof of an implication, is in
form of a function, as expected.

The function takes an argument,
h (a proof of 0 = 1). It then
constructs and returns a proof 
of false. It constructs this
proof by applying nat.no_confusion 
to h. 

The nat.no_confusion function, in
turn, was generated by Lean when 
the nat type was defined. It was 
generated precisely to enable us
to reason about inequalities of 
terms of type nat.
-/

/-
So, one major mystery remains here.
What is nat.no_confusion really doing? 
The key to understanding is in a 
principle we haven't discussed yet. 
Let's look ahead just a little to
see what it is.
-/

/-
Values of a type can be built by
different "constructors" of that
type. In particular, 0 and 1 are 
built by different constructors
of the nat type. The nat type has
two constructors: 0 is a nat, and
if n is any nat, then succ n is a
nat. In particular, 1 is actually
just succ 0 (which we can read as
"the successor of, one more than,
 0".)

The principle that nat.no_confusion
uses is that values of a type that
are built by different constructors 
are, by definition, never equal. We
say that "constructors are disjoint"
as a shorthand for saying that the
sets of values generated by different
constructors are disjoint, which is
to say they have no values in common. 

Lean can thus tell immediately
that it's impossible for 0 = 1
because the terms 0 and 1 were 
built by different constructors. 


The nat.no_confusion function
is defined to return false if 
it could ever be given a proof 
of such an impossibility. Our 
proof of our theorem uses the
no_confusion rule/principle 
that Lean provides, following
from the definition of the nat
type. From a proof of 0 = 1 we 
use nat.no_confusion to derive 
a proof of false, showing that
0 = 1 → false, thus ¬ 0 = 1, 
and thus 0 ≠ 1.  
-/


/-
The Assume-Show-From proof pattern
-/

/-
Here's a equivalent tactic script
for generating the same proof of 
0 ≠ 1.
-/

theorem zneqo'' : ¬ 0 = 1 := 
    begin
        assume h : (0 = 1),
        show false,
        from nat.no_confusion h
    end

/-
This example introduces what we will
call the "assume, show, from" proof 
pattern. The assume h corresponds to 
h being an argument of the function 
we are defining to prove ¬ 0 = 1. The 
show false states what is to be proved 
(the "return type"). And the from then
provides the function body, the code
that actually constructs the proof,
using what has been assumed. Be sure
to open the Messages View in VSCode,
click through the script line by line,
and watch how the tactic state changes.
-/


/- Translation to an informal proof. -/

/-
An English language rendition of this
proof would go like this. We prove 
that 0 ≠ 1 by assuming 0 = 1 and by
showing that this assumption leads to
a contradiction. As that is impossible,
there must be no such proof of 0 = 1.
That proves ¬ 0 = 1, i.e., 0 ≠ 1.  
-/



/-
Disjointness of Constructors in General
-/

/-
Proofs of inequalities for values of 
types other than nat can be produced 
using the no_confusion principles of
the respective other types. Here's a
proof that tt ≠ ff using the principle
for the bool type. 
-/

theorem ttneqff' : ¬ tt = ff := 
    begin
        assume h : (tt = ff),
        show false,
        from bool.no_confusion h
    end

/-
We're thankful we can use the period
(dot) notation here as well.
-/

theorem ttneqff : tt ≠ ff.

/-
EXERCISE: Is it true that 
"Hello, Lean!" ≠ "Hello Lean!"? 
Prove it. (How'd it do that?)

EXERCISE: What about 2 ≠ 1?
-/


/-  ***************************
     *** Proof by Negation ***
    ***************************
-/

/-
We've thus got our introduction rule for ¬.
To derive ¬ P, show that from an assumption
of (a proof of P) some kind of contraction
that cannot occur, and thus a proof of false,
would follow, leading to the conclusion that 
there must be no proof of P, that it isn't
true, and that ¬ P there is true. This is
called "proof by negation."
-/

/-
What are some of the consequence of the
the understanding of negation that we've
developed so far?

Perhaps of the most important concept
at this point is that we have a strategy
for proving propositions of the form, ¬ P. 
Again, we call it "proof by negation." To 
use this strategy to prove ¬ P, we first
assume that we P is true (we have a proof) 
and we show this leads to a contradiction 
(we can build a proof of false). That then
justifies the conclusion that P is cannot
be true, thus ¬ P.

Negation introduction, or proof by negation,
starts by assuming  P, derives a contradiction, 
and concludes with ¬ P. 

Here's the principle in the form of a simple 
theorem that simply restates that from a 
proof of P → false we can derive ¬ P. Give 
the  lambda expression a careful reading: 
it says, if you assume P is a proposition,
and p is a proof of (P → false) then you
can produce a proof of ¬ P, and it's just
p itself. A value (function) of type 
P → false *is* a proof of ¬ P. This is the
simple inference rule for ¬ introduction,
and the "strategy" of proof by negation.
-/

theorem proof_by_negation : ∀ P : Prop,
    (P → false) → ¬ P :=
        λ P p, p

/-
To show ¬ P, show that assuming P leads
to a contradiction. That's just what we
just did. Here's a more concrete example.
-/

lemma zneqo''': ¬ (0 = 1) :=
begin
    apply proof_by_negation,
    assume h: (0 = 1),
    show false,
    from (nat.no_confusion h)
    end

/-
A classic example of a proof by negation
is a proof that the square root of two is
irrational. You have to analyze the English
a little. This is really a proposition, P =
"the square root of two is NOT rational,
or ¬ (rational (sqrt 2)).

To prove it "by negation", assume that the 
square root of two IS rational. From that, 
derive a contradiction. From that, conclude
that the square root of two is not rational.
And now you have proved it is irrational.
-/

/- *********************
   *** Modus Tollens ***
   *********************
-/

/-
Aristotle's reasoning
principle, modus tollens, allows one
to deduce ¬ Q → ¬ P from P → Q. Here's
an example: if you know that "if it's
raining then the streets are wet" then
you can deduce that "if the streets are 
not wet, it is not raining.
-/

/-
We first validate this rule by writing it
as a function that takes a proof of P → Q
and then it takes a proof of ¬ Q, and from
it, it derives a proof of ¬ P. This shows
that (P → Q) → (¬ Q → ¬ P).
-/

theorem  modus_tollens' { P Q : Prop }
    (pfPtoQ : P → Q) (pfnQ : ¬ Q) : ¬ P:=
        λ (pfP : P), pfnQ (pfPtoQ pfP)


/-
EXERCISE: present this same construction using
a lambda expression. This presentation style
makes the proposition, modus tollens, explicit: 
for all P and Q : Prop, (P → Q) → (¬ Q → ¬ P).
Fill in the blank.
-/

theorem modus_tollens: 
     ∀ { P Q: Prop }, (P → Q) → ¬ Q → ¬ P :=
        λ P Q pfPQ pfnQ pfP, 
            sorry


/-
There are two ways to view the modus 
tollens rule.

The first view is that the aim is to
produce a proof of ¬ Q → ¬ P and the
way it is done is to prove P → Q. 

The other view is that the aim is to
produce a proof of ¬ P, and the way 
to do it is by proving both a proof 
of P → Q and a proof of ¬ Q.  
-/

/-
Let's use this strategy to prove ...

EXAMPLE
-/



/- ***************************
   **** Non-contradiction ****
   ***************************
-/

/-
The principle of non-contradiction says that 
a proof of any proposition, Q, and also of its 
negation, ¬ Q, gives rise to a contradiction,
i.e., to a proof of false. Therefore such a
contradiction cannot arise. That is, for any 
proposition Q, it's the case that ¬ (Q ∧ ¬ Q).
-/

theorem no_contra : 
∀ Q: Prop, ¬ (Q ∧ ¬ Q) :=
    λ (Q : Prop) (pf : Q ∧ ¬ Q), 
        (and.elim_right pf) (and.elim_left pf)

#check no_contra

variables a b : nat

theorem ncab : ¬ ((a = b) ∧ (a ≠ b)) :=
begin
  apply no_contra
end

/-
What happens when we apply no_contra here
is that Lean matches up ((a = b) ∧ (a ≠ b))
with Q ∧ ¬ Q by matching up Q with (a = b),
and then deriving false from the result to
polish off the proof (false is a get out of
jail free card). 
-/

/-
A longer, less clear version that does
the same thing.
-/
theorem ncab' : ¬ ((a = b) ∧ (a ≠ b)) :=
begin
  assume c : ((a = b) ∧ (a ≠ b)),
  have l := c.1,    -- short for left elim
  have r := c.2,    -- same for right elim
  have f := r l,    -- now a proof of false
  assumption        -- and that proves it
end

/-
The assumption tactic tells lean that the
goal to be proved is already proved by an
assumption in the context, so just go find
it. Watch how the tactic state changes as
you move through the proof script steps.
-/

/-  ********************************
     *** NEGATION ELIMINATION ***
    ********************************
-/

/-
What about negation elimination? Negation
elimination works in a closely related way.
Rather than deriving a contradiction from
a proof of P and concluding ¬ P, you show
that assuming ¬ P leads to a contraction,
thus to the conclusion that ¬ P is false,
there can be no proof it, thus ¬ ¬ P; and
then, by the principle of double negation
elimination one deduces that P must be true.

This is called proving P by contradiction.

Proof by contradiction is not accepted as
a valid principle in constructive logic,
because it relies on ¬ ¬ P → P. This issue
is that this rule is not constructive. To
see the problem, expand the ¬ signs into
their corresponding arrow notations. Then
¬ ¬ P, ¬ (¬ P), is ((P → false) → false).

What this says is that from a function 
that converts assumed proofs of P into
proofs of false, one can derive a proof
of false: there can be no function of
this kind. But no where buried in any of
this is an actual proof of P to be found! 
There's  no way to convert a function of 
type ((P → false) → false) into a proof 
of P, so there is no proof of ¬ ¬ P → P. 

That is, double negation elimination is
not a valid inference rule in constructive
logic. Because proofs by contradiction 
rely on double negation elimination, they
are not valid or available either in a
constructive logic, such as Lean's.

Lean can be extended by a single axiom, 
however, to make it classical, rather
than constructive. One simple asserts
the law of the excluded middle.

P : Prop
--------
P ∨ ¬ P

axiom excluded_middle: ∀ P : Prop, P ∨ ¬ P
-/


/-  *******************************
    ** Classical Excluded Middle **
    *******************************
-/

/-
In constructive logic, a proof of ¬ P is 
a proof of P → false, which we interpret
as a proof that there can be no proof of P. 
A proof of ¬ ¬ P is thus a proof that there
is no proof of ¬ P. In a constructive logic,
however, knowing that there no proof of ¬ P 
is not the same as having a proof of P. In
symbolic terms, from the assumption that
(P → false) → false (in one view a proof
that there can be no program that converts
proofs of P into proofs of false), you can't 
derive a proof of P. 
-/
axiom excluded_middle : ∀ P, P ∨ ¬ P

axiom excluded_middle' (P : Prop) : P ∨ ¬ P

/-
The axiom of the excluded middle is thus 
added to the other rules of the constructive
logic of Lean, making the logic classical.
We gain an ability to prove more theorems,
at the cost of a loss of constructivness.
(We don't need a proof of either P or of
not P to derive a proof of P ∨ ¬ P. Thus
no proof of either P or of ¬ P can be 
obtained from a proof of P ∨ ¬ P. In our
constructive logic, as we will see soon,
in our constructive logic a proof of P ∨
¬ P has to contain either a proof of P or
a proof of ¬ P. The elimination rule gets
us back to these proofs in a certain way.
-/

/-  *********************************
    ** Double Negation Elimination **
    *********************************
-/

/-
What the axiom of the excluded middle
let's you assume is that there are only
two possibilities: either P or ¬ P, so
because ¬ ¬ P is clearly not ¬ P, the
only remaining possibility is that it 
is P, so it must be P. Thus ¬ ¬ P is P.
-/

theorem double_neg_elim: ∀ { P }, ¬ ¬ P → P := 
begin
assume P : Prop,
assume pfNotNotP : ¬ ¬ P,
cases excluded_middle P,
show P, from h,
have f: false := pfNotNotP h,
exact false.elim f
end

/-
THe proof uses a technique that we haven't
discussed yet: by case analysis. For now it
is enough to see that the principle can be
proved, at least if one accepts excluded 
middle.
-/

variable notNotP : ¬ ¬ P -- assume ¬ ¬ P
-- derive P by double negation elimination
theorem pfP : P := double_neg_elim notNotP

/-
Note: the expression  double_neg_elim notNotP
takes advantage of the type inference that we
asked for by surrounding { P } with the curly
braces in the statement of the theorem.
-/

/-  ******************************
    *** Proof By Contradiction ***
    ******************************
-/

/-
We thus have the fundamental classical
logical "strategy" of proof by contradiction.
Read the proposition. If assuming ¬ P leads
to a contradiction, then P must be true. 
The reliance on double elimination is clear. 
The term ¬ P → false is the same as ¬ ¬ P. 

The natural reasoning is like this: if ¬
P leads to a contraction then it must be
true that ¬ P is not true, so ¬ ¬ P must
be. But this, by classical double negation 
elimination, is just P, so P must be true.

This is negation elimination in the sense
that one starts with an assumption of ¬ P
and concludes with P, albeit by way of 
¬ ¬ P. A proof by contradiction aims to 
prove P.
-/
theorem proof_by_contradiction : ∀ P : Prop,
    (¬ P → false) → P := 
        @double_neg_elim

/-
The @ here turns off type inferencing for 
this one reference to double_neg_elim. It
is a detail here. We'll discuss @ later. 
The point is that proof by contradiction
relies on double negation elimination.
-/

/-
Proving in Lean that these laws are valid
might seem unmotivated at first. But once
we have these rules, we can use them as our
own higher-level inference rules. Here's a
proof by contradiction of 0 = 0. The goal
to start is a proof of 0 = 0. By applying
our proof_by_contradiction theorem to effect
backwards (through the theorem) reasoning,
we convert the goal of showing 0 = 0 into
the goal of showing that ¬ 0 = 0 → false.
This is exactly the strategy of a proof by
contradiction. The rest of our script does
the construction of false from the assumed
proof of 0 = 0 → false. We just use eq.refl
0 to produce a proof of 0 = 0, to which we
then apply this function, yielding a false.
-/

theorem zeqz : 0 = 0 :=
begin
    apply proof_by_contradiction,
    assume pf: 0 = 0 → false,
    show false,
    from pf (eq.refl 0)
end

/-
The standard method for introducing
the law of the excluded middle, so as
to enable classical reasoning, in Lean,
is to use the "open classical" command
to make various classical axioms and
derived theorems available for use.
-/
open classical 

/-
The example keyword lets us write a
theorem without giving it a name. It
is useful for giving examples!
-/
example
    { P Q : Prop } 
    (pf: ¬ P → (Q ∧ ¬ Q)) 
    : P :=
    begin
        apply proof_by_contradiction,
        assume notP: ¬ P,
        have contra := (pf notP),
        show false,
        from no_contra Q contra
    end

/-
Remember: To use proof by contradiction 
we have to use the axiom (or the so-called 
"law") of the excluded middle. Clearly it's
optional as a "law", as constructive logic
does without it. We thus generally call it
the *axiom* of the excluded middle. Take it
if you're classicist; leave it if you're 
constructivist.
-/



/-  *****************************
    ** Proof By Contrapositive **
    *****************************
-/

/-
The aim in a proof by contraspositive 
is to show P ∧ Q from an assumption of 
¬ P ∧ ¬ Q, i.e., (¬ Q → ¬ P) → (P → Q).

Another way to view this rule is that
it aims to show Q from, first, a proof
of ¬ Q → ¬ P, and, second, a proof of P.

The way to think about this latter view
is that it says, if Q being false implies
that P is false, and if we know that P is
true, then Q must not be false and so (by
the axiom of the excluded middle) Q must
be true.
-/

theorem proof_by_contrapositive: 
    ∀ P Q : Prop, (¬ Q → ¬ P) → (P → Q) :=
    begin
        assume P Q: Prop,
        assume nqnp: (¬ Q → ¬ P),
        assume p : P,
        have nqf : ¬ Q → false :=
          λ nq : ¬ Q, 
            no_contra P (and.intro p (nqnp nq)),
        have nnq : ¬ ¬ Q := nqf,
        show Q,
        from double_neg_elim nnq
    end

/-
http://zimmer.csufresno.edu/~larryc/proofs/proofs.contrapositive.html
-/

theorem zeqz' : 0 = 0 → true :=
begin
    apply proof_by_contrapositive,
    assume nt : ¬true,
    have pff := nt true.intro,
    show ¬ 0 = 0,
    from false.elim pff
end

/-
Compare what by_contrapositive does to goal
with what by_contradiction does to the goal.
-/

theorem zeqz'' : 0 = 0 → true :=
begin
    apply proof_by_contradiction (0 = 0 → true),
    sorry
end
/-
EXERCISE: Does it appear that one needs 
to use proof by contradiction (and thus
classical, non-constructive, reasoning) 
to prove that the square root of two is 
irrational?
-/
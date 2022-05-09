From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Mon, 9 May 2022 13:39:21 -0300
Subject: [PATCH 24/30] panic: Refactor the panic path
In-Reply-To: <TYAPR01MB6507D01F5694BC33628BB7DB95C69@TYAPR01MB6507.jpnprd01.prod.outlook.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-25-gpiccoli@igalia.com>
 <TYAPR01MB6507D01F5694BC33628BB7DB95C69@TYAPR01MB6507.jpnprd01.prod.outlook.com>
Message-ID: <92e03ebf-6a64-69dc-bf16-9552b9fedad8@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hey Hatayma, thanks for your great analysis and no need for apologies!

I'll comment/respond properly inline below, just noticing here that I've
CCed Mark and Marc (from the ARM64 perspective), Michael (Hyper-V
perspective) and Hari (PowerPC perspective), besides the usual suspects
as Petr, Baoquan, etc.

On 09/05/2022 12:16, d.hatayama at fujitsu.com wrote:
> Sorry for the delayed response. Unfortunately, I had 10 days holidays
> until yesterday...
> [...] 
>> +                       We currently have 4 lists of panic notifiers; based
>> +                       on the functionality and risk (for panic success) the
>> +                       callbacks are added in a given list. The lists are:
>> +                       - hypervisor/FW notification list (low risk);
>> +                       - informational list (low/medium risk);
>> +                       - pre_reboot list (higher risk);
>> +                       - post_reboot list (only run late in panic and after
>> +                       kdump, not configurable for now).
>> +                       This parameter defines the ordering of the first 3
>> +                       lists with regards to kdump; the levels determine
>> +                       which set of notifiers execute before kdump. The
>> +                       accepted levels are:
>> +                       0: kdump is the first thing to run, NO list is
>> +                       executed before kdump.
>> +                       1: only the hypervisor list is executed before kdump.
>> +                       2 (default level): the hypervisor list and (*if*
> 
> Hmmm, why are you trying to change default setting?
> 
> Based on the current design of kdump, it's natural to put what the
> handlers for these level 1 and level 2 handlers do in
> machine_crash_shutdown(), as these are necessary by default, right?
> 
> Or have you already tried that and figured out it's difficult in some
> reason and reached the current design? If so, why is that difficult?
> Could you point to if there is already such discussion online?
> 
> kdump is designed to perform as little things as possible before
> transferring the execution to the 2nd kernel in order to increase
> reliability. Just detour to panic() increases risks of kdump failure
> in the sense of increasing the executed codes in the abnormal
> situation, which is very the note in the explanation of
> crash_kexec_post_notifiers.
> 
> Also, the current implementation of crash_kexec_post_notifiers uses
> the panic notifier, but this is not from the technical
> reason. Ideally, it should have been implemented in the context of
> crash_kexec() independently of panic().
> 
> That is, it looks to me that, in addition to changing design of panic
> notifier, you are trying to integrate shutdown code of the crash kexec
> and the panic paths. If so, this is a big design change for kdump.
> I'm concerned about increase of reliability. I'd like you to discuss
> them carefully.

From my understanding (specially based on both these threads [0] and
[1]), 3 facts are clear and quite complex in nature:

(a) Currently, the panic notifier list is a "no man's land" - it's a
mess, all sort of callbacks are added there, some of them are extremely
risk for breaking kdump, others are quite safe (like setting a
variable). Petr's details in thread [0] are really clear and express in
great way how confusing and conflicting the panic notifiers goals are.

(b) In order to "address" problems in the antagonistic goals of
notifiers (see point (a) above and thread [0]), we have this
quirk/workaround called "crash_kexec_post_notifiers". This is useful,
but (almost as for attesting how this is working as band-aid over
complex and fundamental issues) see the following commits:

a11589563e96 ("x86/Hyper-V: Report crash register data or kmsg before
running crash kernel")

06e629c25daa ("powerpc/fadump: Fix inaccurate CPU state info in vmcore
generated with panic")

They hardcode such workaround, because they *need* some notifiers'
callbacks. But notice they *don't need all of them*, only some important
ones (that usually are good considering the risk, it's a good
cost/benefit). Since we currently have an all-or-nothing behavior for
the panic notifiers, both PowerPC and Hyper-V end-up bringing all of
them to run before kdump due to the lack of flexibility, increasing a
lot the risk of failure for kdump.

(c) To add on top of all such complexity, we don't have a custom
machine_crash_shutdown() handler for some architectures like ARM64, and
the feeling is that's not right to add a bunch of callbacks / complexity
in such architecture code, specially since we have the notifiers
infrastructure in the kernel. I've recently started a discussion about
that with ARM64 community, please take a look in [1].

With that said, we can use (a) + (b) + (c) to justify our argument here:
the panic notifiers should be refactored! We need to try to encompass
the antagonistic goals of kdump (wants to be the first thing to run,
early as possible) VS. the notifiers that are necessary, even before
kdump (like Hyper-V / PowerPC fadump ones, but there are more of these,
the FW/hypervisors notifiers).

I guarantee to you we cannot make 100% of people happy - the
panic-related areas like kdump, etc are full of trade-offs. We improve
something, other stuff breaks. This series attempts to clearly
distribute the notifiers in 3 buckets, and introduces a level setting
that tunes such buckets to run before or after the kdump in a highly
flexible way, trying to make the most users happy and capable of tuning
their systems.

I understand that likely setting the notifiers to 0 would make kdump
maintainers happy, because we'd keep the same behavior as before.
But..then we make PPC / Hyper-V and some other users unsatisfied. Level
2 seems to me a good compromise. I'm willing to add a KConfig option to
allow distros to hard set their defaults - that might make sense to
legacy distros as older RHEL / CentOS or server-only distros.

Finally, you mention about integrating the crash shutdown and the panic
paths - I'm not officially doing that, but I see that they are very
related and all cases I've ever seen in the last 3-4 years I've been
working with kdump, it was triggered from panic, from settings "panic_on_X".

I understand we have the regular kexec path (!kdump), some notifiers
might make sense in both paths, and in this case we could duplicate them
(one callback, 2 notifier lists) and control against double execution. I
tried doing that in patch 16 of this series (Hyper-V stuff), but due to
the lack of ARM64 custom crash shutdown handler, I couldn't. We can
think in some alternatives, and improve these (naturally)
connected/related paths, but this is not the goal of this specific
series. I'm hereby trying to improve/clarify the panic (and kdump) path,
not the pure kexec path.

Let me know if I can clarify more specific points you have or if there
are flaws in my logic - I appreciate the discussions/reviews.
Cheers,


Guilherme



[0] "notifier/panic: Introduce panic_notifier_filter" -
https://lore.kernel.org/lkml/YfPxvzSzDLjO5ldp at alley/

[1] "Should arm64 have a custom crash shutdown handler?" -
https://lore.kernel.org/lkml/427a8277-49f0-4317-d6c3-4a15d7070e55 at igalia.com/


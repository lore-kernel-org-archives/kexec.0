From: Evan Green <evgreen@chromium.org>
Date: Mon, 16 May 2022 09:02:10 -0700
Subject: [PATCH 19/30] panic: Add the panic hypervisor notifier list
In-Reply-To: <ad082ce7-db50-13bb-3dbb-9b595dfa78be@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-20-gpiccoli@igalia.com>
 <YoJZVZl/MH0KiE/J@alley> <ad082ce7-db50-13bb-3dbb-9b595dfa78be@igalia.com>
Message-ID: <CAE=gft7ds+dHfEkRz8rnSH1EbTpGTpKbi5Wxj9DW0Jr5mX_j4w@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Mon, May 16, 2022 at 8:07 AM Guilherme G. Piccoli
<gpiccoli@igalia.com> wrote:
>
> Thanks for the review!
>
> I agree with the blinking stuff, I can rework and add all LED/blinking
> stuff into the loop list, it does make sense. I'll comment a bit in the
> others below...
>
> On 16/05/2022 11:01, Petr Mladek wrote:
> > [...]
> >> --- a/arch/mips/sgi-ip22/ip22-reset.c
> >> +++ b/arch/mips/sgi-ip22/ip22-reset.c
> >> @@ -195,7 +195,7 @@ static int __init reboot_setup(void)
> >>      }
> >>
> >>      timer_setup(&blink_timer, blink_timeout, 0);
> >> -    atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
> >> +    atomic_notifier_chain_register(&panic_hypervisor_list, &panic_block);
> >
> > This notifier enables blinking. It is not much safe. It calls
> > mod_timer() that takes a lock internally.
> >
> > This kind of functionality should go into the last list called
> > before panic() enters the infinite loop. IMHO, all the blinking
> > stuff should go there.
> > [...]
> >> --- a/arch/mips/sgi-ip32/ip32-reset.c
> >> +++ b/arch/mips/sgi-ip32/ip32-reset.c
> >> @@ -145,7 +144,7 @@ static __init int ip32_reboot_setup(void)
> >>      pm_power_off = ip32_machine_halt;
> >>
> >>      timer_setup(&blink_timer, blink_timeout, 0);
> >> -    atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
> >> +    atomic_notifier_chain_register(&panic_hypervisor_list, &panic_block);
> >
> > Same here. Should be done only before the "loop".
> > [...]
>
> Ack.
>
>
> >> --- a/drivers/firmware/google/gsmi.c
> >> +++ b/drivers/firmware/google/gsmi.c
> >> @@ -1034,7 +1034,7 @@ static __init int gsmi_init(void)
> >>
> >>      register_reboot_notifier(&gsmi_reboot_notifier);
> >>      register_die_notifier(&gsmi_die_notifier);
> >> -    atomic_notifier_chain_register(&panic_notifier_list,
> >> +    atomic_notifier_chain_register(&panic_hypervisor_list,
> >>                                     &gsmi_panic_notifier);
> >
> > I am not sure about this one. It looks like some logging or
> > pre_reboot stuff.
> >
>
> Disagree here. I'm looping Google maintainers, so they can comment.
> (CCed Evan, David, Julius)
>
> This notifier is clearly a hypervisor notification mechanism. I've fixed
> a locking stuff there (in previous patch), I feel it's low-risk but even
> if it's mid-risk, the class of such callback remains a perfect fit with
> the hypervisor list IMHO.

This logs a panic to our "eventlog", a tiny logging area in SPI flash
for critical and power-related events. In some cases this ends up
being the only clue we get in a Chromebook feedback report that a
panic occurred, so from my perspective moving it to the front of the
line seems like a good idea.

-Evan


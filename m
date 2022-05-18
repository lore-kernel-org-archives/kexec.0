From: Petr Mladek <pmladek@suse.com>
Date: Wed, 18 May 2022 09:38:52 +0200
Subject: [PATCH 19/30] panic: Add the panic hypervisor notifier list
In-Reply-To: <d72b9aab-675c-ac89-b73a-b1de4a0b722d@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-20-gpiccoli@igalia.com>
 <YoJZVZl/MH0KiE/J@alley>
 <ad082ce7-db50-13bb-3dbb-9b595dfa78be@igalia.com>
 <YoOpyW1+q+Z5as78@alley>
 <d72b9aab-675c-ac89-b73a-b1de4a0b722d@igalia.com>
Message-ID: <YoSijKwuwbY9uHxG@alley>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Tue 2022-05-17 13:42:06, Guilherme G. Piccoli wrote:
> On 17/05/2022 10:57, Petr Mladek wrote:
> >> Disagree here, I'm CCing Florian for information.
> >>
> >> This notifier preserves RAM so it's *very interesting* if we have
> >> kmsg_dump() for example, but maybe might be also relevant in case kdump
> >> kernel is configured to store something in a persistent RAM (then,
> >> without this notifier, after kdump reboots the system data would be lost).
> > 
> > I see. It is actually similar problem as with
> > drivers/firmware/google/gsmi.c.
> > 
> > I does similar things like kmsg_dump() so it should be called in
> > the same location (after info notifier list and before kdump).
> > 
> > A solution might be to put it at these notifiers at the very
> > end of the "info" list or make extra "dump" notifier list.
> 
> Here I still disagree. I've commented in the other response thread
> (about Google gsmi) about the semantics of the hypervisor list, but
> again: this list should contain callbacks that
> 
> (a) Should run early, _by default_ before a kdump;
> (b) Communicate with the firmware/hypervisor in a "low-risk" way;
> 
> Imagine a scenario where users configure kdump kernel to save something
> in a persistent form in DRAM - it'd be like a late pstore, in the next
> kernel. This callback enables that, it's meant to inform FW "hey, panic
> happened, please from now on don't clear the RAM in the next FW-reboot".
> I don't see a reason to postpone that - let's see if the maintainers
> have an opinion.

I have answered this in more detail in the other reply, see
https://lore.kernel.org/r/YoShZVYNAdvvjb7z at alley

I agree that both notifiers in

    drivers/soc/bcm/brcmstb/pm/pm-arm.c
    drivers/firmware/google/gsmi.c

better fit into the hypervisor list after all.

Best Regards,
Petr


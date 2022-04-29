From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Fri, 29 Apr 2022 19:35:09 -0300
Subject: [PATCH 16/30] drivers/hv/vmbus, video/hyperv_fb: Untangle and
 refactor Hyper-V panic notifiers
In-Reply-To: <PH0PR21MB30250C9246FFF36AFB1DFDECD7FC9@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-17-gpiccoli@igalia.com>
 <PH0PR21MB30250C9246FFF36AFB1DFDECD7FC9@PH0PR21MB3025.namprd21.prod.outlook.com>
Message-ID: <2787b476-6366-1c83-db80-0393da417497@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Michael, first of all thanks for the great review, much appreciated.
Some comments inline below:

On 29/04/2022 14:16, Michael Kelley (LINUX) wrote:
> [...]
>> hypervisor I/O completion), so we postpone that to run late. But more
>> relevant: this *same* vmbus unloading happens in the crash_shutdown()
>> handler, so if kdump is set, we can safely skip this panic notifier and
>> defer such clean-up to the kexec crash handler.
> 
> While the last sentence is true for Hyper-V on x86/x64, it's not true for
> Hyper-V on ARM64.  x86/x64 has the 'machine_ops' data structure
> with the ability to provide a custom crash_shutdown() function, which
> Hyper-V does in the form of hv_machine_crash_shutdown().  But ARM64
> has no mechanism to provide such a custom function that will eventually
> do the needed vmbus_initiate_unload() before running kdump.
> 
> I'm not immediately sure what the best solution is for ARM64.  At this
> point, I'm just pointing out the problem and will think about the tradeoffs
> for various possible solutions.  Please do the same yourself. :-)
> 

Oh, you're totally right! I just assumed ARM64 would the the same, my
bad. Just to propose some alternatives, so you/others can also discuss
here and we can reach a consensus about the trade-offs:

(a) We could forget about this change, and always do the clean-up here,
not relying in machine_crash_shutdown().
Pro: really simple, behaves the same as it is doing currently.
Con: less elegant/concise, doesn't allow arm64 customization.

(b) Add a way to allow ARM64 customization of shutdown crash handler.
Pro: matches x86, more customizable, improves arm64 arch code.
Con: A tad more complex.

Also, a question that came-up: if ARM64 has no way of calling special
crash shutdown handler, how can you execute hv_stimer_cleanup() and
hv_synic_disable_regs() there? Or are they not required in ARM64?


>>
>> (c) There is also a Hyper-V framebuffer panic notifier, which relies in
>> doing a vmbus operation that demands a valid connection. So, we must
>> order this notifier with the panic notifier from vmbus_drv.c, in order to
>> guarantee that the framebuffer code executes before the vmbus connection
>> is unloaded.
> 
> Patch 21 of this set puts the Hyper-V FB panic notifier on the pre_reboot
> notifier list, which means it won't execute before the VMbus connection
> unload in the case of kdump.   This notifier is making sure that Hyper-V
> is notified about the last updates made to the frame buffer before the
> panic, so maybe it needs to be put on the hypervisor notifier list.  It
> sends a message to Hyper-V over its existing VMbus channel, but it
> does not wait for a reply.  It does, however, obtain a spin lock on the
> ring buffer used to communicate with Hyper-V.   Unless someone has
> a better suggestion, I'm inclined to take the risk of blocking on that
> spin lock.

The logic behind that was: when kdump is set, we'd skip the vmbus
disconnect on notifiers, deferring that to crash_shutdown(), logic this
one refuted in the above discussion on ARM64 (one more Pro argument to
the idea of refactoring aarch64 code to allow a custom crash shutdown
handler heh). But you're right, for the default level 2, we skip the
pre_reboot notifiers on kdump, effectively skipping this notifier.

Some ideas of what we can do here:

I) we could change the framebuffer notifier to rely on trylocks, instead
of risking a lockup scenario, and with that, we can execute it before
the vmbus disconnect in the hypervisor list;

II) we ignore the hypervisor notifier in case of kdump _by default_, and
if the users don't want that, they can always set the panic notifier
level to 4 and run all notifiers prior to kdump; would that be terrible
you think? Kdump users might don't care about the framebuffer...

III) we go with approach (b) above and refactor arm64 code to allow the
custom crash handler on kdump time, then [with point (I) above] the
logic proposed in this series is still valid - seems more and more the
most correct/complete solution.

In any case, I guess we should avoid workarounds if possible and do the
things the best way we can, to encompass all (or almost all) the
possible scenarios and don't force things on users (like enforcing panic
notifier level 4 for Hyper-V or something like this...)

More feedback from you / Hyper-V folks is pretty welcome about this.


> 
>> [...]
> The "Fixes:" tags imply that these changes should be backported to older
> longterm kernel versions, which I don't think is the case.  There is a
> dependency on Patch 14 of your series where PANIC_NOTIFIER is
> introduced.
> 

Oh, this was more related with archeology of the kernel. When I'm
investigating stuff, I really want to understand why code was added and
that usually require some time git blaming stuff, so having that pronto
in the commit message is a bonus.

But of course we don't need to use the Fixes tag for that, easy to only
mention it in the text. A secondary benefit by using this tag is to
indicate this is a _real fix_ to some code, and not an improvement, but
as you say, I agree we shouldn't backport it to previous releases having
or not the Fixes tag (AFAIK it's not mandatory to backport stuff with
Fixes tag).


>> [...]
>> + * intrincated is the relation of this notifier with Hyper-V framebuffer
> 
> s/intrincated/intricate/

Thanks, fixed in V2!


>
>> [...]
>> +static int hv_panic_vmbus_unload(struct notifier_block *nb, unsigned long val,
>>  			      void *args)
>> +{
>> +	if (!kexec_crash_loaded())
> 
> I'm not clear on the purpose of this condition.  I think it means
> we will skip the vmbus_initiate_unload() if a panic occurs in the
> kdump kernel.  Is there a reason a panic in the kdump kernel
> should be treated differently?  Or am I misunderstanding?

This is really related with the point discussed in the top of this
response - I assumed both ARM64/x86_64 would behave the same and
disconnect the vmbus through the custom crash handler when kdump is set,
so worth skipping it here in the notifier. But that's not true for ARM64
as you pointed, so this guard against kexec is really part of the
decision/discussion on what to do with ARM64 heh

Cheers!


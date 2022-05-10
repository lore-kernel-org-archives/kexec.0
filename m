From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Tue, 10 May 2022 17:11:08 -0300
Subject: [PATCH 01/30] x86/crash,reboot: Avoid re-disabling VMX in all
 CPUs on crash/restart
In-Reply-To: <Ynk40U/KA+hLBZRC@google.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-2-gpiccoli@igalia.com> <Ynk40U/KA+hLBZRC@google.com>
Message-ID: <24a56892-adb3-809c-8c35-b5b5f001c283@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 09/05/2022 12:52, Sean Christopherson wrote:
> I find the shortlog to be very confusing, the bug has nothing to do with disabling
> VMX and I distinctly remember wrapping VMXOFF with exception fixup to prevent doom
> if VMX is already disabled :-).  The issue is really that nmi_shootdown_cpus() doesn't
> play nice with being called twice.
> 

Hey Sean, OK - I agree with you, the issue is really about the double
list addition.

> [...]
> 
> Call stacks for the two callers would be very, very helpful.
> [...]

> This feels like were just adding more duct tape to the mess.  nmi_shootdown() is
> still unsafe for more than one caller, and it takes a _lot_ of staring and searching
> to understand that crash_smp_send_stop() is invoked iff CONFIG_KEXEC_CORE=y, i.e.
> that it will call smp_ops.crash_stop_other_cpus() and not just smp_send_stop().
> 
> Rather than shared a flag between two relatively unrelated functions, what if we
> instead disabling virtualization in crash_nmi_callback() and then turn the reboot
> call into a nop if an NMI shootdown has already occurred?  That will also add a
> bit of documentation about multiple shootdowns not working.
> 
> And I believe there's also a lurking bug in native_machine_emergency_restart() that
> can be fixed with cleanup.  SVM can also block INIT and so should be disabled during
> an emergency reboot.
> 
> The attached patches are compile tested only.  If they seem sane, I'll post an
> official mini series.

Thanks Sean, it makes sense - my patch is more a "band-aid" whereas
yours fixes it in a more generic way. Confess I found the logic of your
patch complex, but as you said, it requires a *lot* of code analysis to
understand these multiple shutdown patches, the problem is complicated
by nature heh

I've tested your patch 0001 and it works well for all cases [0], so go
ahead and submit the miniseries, feel free to add:

Reported-and-tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>


I've read patch 0002 and it makes sense to me as well, a good proactive
bug fix =)

With that said, I'll of course drop this one from V2 of this series.
Cheers,


Guilherme




[0]
A summary of my tests and the code paths that the panic shutdown take
depending on some conditions:

New function that disables VMX/SVM: cpu_crash_disable_virtualization()
[should be executed in every online CPU on shutdown)

The panic path triggers the following call stacks depending on kdump and
post_notifiers:


(1) kexec/kdump + !crash_kexec_post_notifiers
->machine_crash_shutdown()
----.crash_shutdown() <custom handler>
------native_machine_crash_shutdown() [all custom handlers except Xen PV
call the native generic function]
--------crash_smp_send_stop()
----------kdump_nmi_shootdown_cpus()
------------nmi_shootdown_cpus(kdump_nmi_callback)
--------------crash_nmi_callback()
----------------kdump_nmi_callback()
------------------cpu_crash_disable_virtualization()


(2) kexec/kdump + crash_kexec_post_notifiers
->crash_smp_send_stop()
----kdump_nmi_shootdown_cpus()
------nmi_shootdown_cpus(kdump_nmi_callback)
--------crash_nmi_callback()
----------kdump_nmi_callback()
------------cpu_crash_disable_virtualization()

After this path, will execute machine_crash_shutdown() but
crash_smp_send_stop()
is guarded against double execution. Also, emergency restart calls
emergency_vmx_disable_all() .


(3) !kexec/kdump + crash_kexec_post_notifiers

Same as (2)


(4) !kexec/kdump + !crash_kexec_post_notifiers
-> smp_send_stop()
----native_stop_other_cpus()
------apic_send_IPI_allbutself(REBOOT_VECTOR)
--------sysvec_reboot
----------cpu_emergency_vmxoff() <if the IPI approach succeeded, CPU
stopped here>

If not:
------register_stop_handler()
--------apic_send_IPI_allbutself(NMI_VECTOR)
----------smp_stop_nmi_callback()
------------cpu_emergency_vmxoff()

After that, emergency_vmx_disable_all() gets called in the emergency
restart path as well.


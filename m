Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Td2Mt-0007LR-1m
 for kexec@lists.infradead.org; Mon, 26 Nov 2012 17:21:16 +0000
Date: Mon, 26 Nov 2012 19:20:54 +0200
From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH v8 1/2] x86/kexec: add a new atomic notifier list for kdump
Message-ID: <20121126172054.GF12969@redhat.com>
References: <50ADE0C2.1000106@cn.fujitsu.com> <50ADE11A.401@cn.fujitsu.com>
 <87ip8sxuyh.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87ip8sxuyh.fsf@xmission.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

On Mon, Nov 26, 2012 at 09:08:54AM -0600, Eric W. Biederman wrote:
> Zhang Yanfei <zhangyanfei@cn.fujitsu.com> writes:
> 
> > This patch adds an atomic notifier list named crash_notifier_list.
> > Currently, when loading kvm-intel module, a notifier will be registered
> > in the list to enable vmcss loaded on all cpus to be VMCLEAR'd if
> > needed.
> 
> crash_notifier_list ick gag please no.  Effectively this makes the kexec
> on panic code path undebuggable.
> 
> Instead we need to use direct function calls to whatever you are doing.
> 
The code walks linked list in kvm-intel module and calls vmclear on
whatever it finds there. Since the function have to resides in kvm-intel
module it cannot be called directly. Is callback pointer that is set
by kvm-intel more acceptable?

> If a direct function call is too complex then the piece of code you want
> to call is almost certainly too complex to be calling on a code path
> like this.
> 
> Eric
> 
> > Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> > ---
> >  arch/x86/include/asm/kexec.h |    2 ++
> >  arch/x86/kernel/crash.c      |    9 +++++++++
> >  2 files changed, 11 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> > index 317ff17..5e22b00 100644
> > --- a/arch/x86/include/asm/kexec.h
> > +++ b/arch/x86/include/asm/kexec.h
> > @@ -163,6 +163,8 @@ struct kimage_arch {
> >  };
> >  #endif
> >  
> > +extern struct atomic_notifier_head crash_notifier_list;
> > +
> >  #endif /* __ASSEMBLY__ */
> >  
> >  #endif /* _ASM_X86_KEXEC_H */
> > diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> > index 13ad899..c5b2f70 100644
> > --- a/arch/x86/kernel/crash.c
> > +++ b/arch/x86/kernel/crash.c
> > @@ -16,6 +16,8 @@
> >  #include <linux/delay.h>
> >  #include <linux/elf.h>
> >  #include <linux/elfcore.h>
> > +#include <linux/module.h>
> > +#include <linux/notifier.h>
> >  
> >  #include <asm/processor.h>
> >  #include <asm/hardirq.h>
> > @@ -30,6 +32,9 @@
> >  
> >  int in_crash_kexec;
> >  
> > +ATOMIC_NOTIFIER_HEAD(crash_notifier_list);
> > +EXPORT_SYMBOL_GPL(crash_notifier_list);
> > +
> >  #if defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)
> >  
> >  static void kdump_nmi_callback(int cpu, struct pt_regs *regs)
> > @@ -46,6 +51,8 @@ static void kdump_nmi_callback(int cpu, struct pt_regs *regs)
> >  #endif
> >  	crash_save_cpu(regs, cpu);
> >  
> > +	atomic_notifier_call_chain(&crash_notifier_list, 0, NULL);
> > +
> >  	/* Disable VMX or SVM if needed.
> >  	 *
> >  	 * We need to disable virtualization on all CPUs.
> > @@ -88,6 +95,8 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
> >  
> >  	kdump_nmi_shootdown_cpus();
> >  
> > +	atomic_notifier_call_chain(&crash_notifier_list, 0, NULL);
> > +
> >  	/* Booting kdump kernel with VMX or SVM enabled won't work,
> >  	 * because (among other limitations) we can't disable paging
> >  	 * with the virt flags.

--
			Gleb.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

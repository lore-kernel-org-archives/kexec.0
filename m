Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bMtiP-0006LM-1u
 for kexec@lists.infradead.org; Tue, 12 Jul 2016 09:10:54 +0000
From: "Wei, Jiangang" <weijg.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v2] kexec: Fix kdump failure with notsc
Date: Tue, 12 Jul 2016 09:10:29 +0000
Message-ID: <1468314496.15074.67.camel@localhost>
References: <1467886646-2638-1-git-send-email-weijg.fnst@cn.fujitsu.com>
 <578493AD.3000403@redhat.com> <20160712082150.GC3524@x1.redhat.com>
In-Reply-To: <20160712082150.GC3524@x1.redhat.com>
Content-Language: en-US
Content-ID: <D6D2BAADDEC2244F9A0BF6DCC41F9EFD@fujitsu.local>
MIME-Version: 1.0
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "bhe@redhat.com" <bhe@redhat.com>
Cc: "fenghua.yu@intel.com" <fenghua.yu@intel.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "x86@kernel.org" <x86@kernel.org>, "xlpang@redhat.com" <xlpang@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>

On Tue, 2016-07-12 at 16:21 +0800, Baoquan He wrote:
> On 07/12/16 at 02:52pm, Xunlei Pang wrote:
> > On 2016/07/07 at 18:17, Wei Jiangang wrote:
> > > Signed-off-by: Wei Jiangang <weijg.fnst@cn.fujitsu.com>
> > > ---
> > > +/* Local APIC is disabled by the kernel for crash or reboot path */
> > > +static int disabled_local_apic;
> > > +
> > >  /*
> > >   * Knob to control our willingness to enable the local APIC.
> > >   *
> > > @@ -1097,10 +1100,16 @@ void lapic_shutdown(void)
> > >  #endif
> > >  		disable_local_APIC();
> > >  
> > > +	disabled_local_apic = 1;
> > >  
> > >  	local_irq_restore(flags);
> > >  }
> > >  
> > > +int lapic_disabled(void)
> > > +{
> > > +	return disabled_local_apic;
> > > +}
> > > +
> > >  /**
> > >   * sync_Arb_IDs - synchronize APIC bus arbitration IDs
> > >   */
> > > diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
> > > index 469b23d6acc2..c934a7868e6b 100644
> > > --- a/arch/x86/kernel/machine_kexec_32.c
> > > +++ b/arch/x86/kernel/machine_kexec_32.c
> > > @@ -202,14 +202,13 @@ void machine_kexec(struct kimage *image)
> > >  	local_irq_disable();
> > >  	hw_breakpoint_disable();
> > >  
> > > -	if (image->preserve_context) {
> > > +	if (image->preserve_context || lapic_disabled()) {
> > >  #ifdef CONFIG_X86_IO_APIC
> > >  		/*
> > >  		 * We need to put APICs in legacy mode so that we can
> > >  		 * get timer interrupts in second kernel. kexec/kdump
> > >  		 * paths already have calls to disable_IO_APIC() in
> > > -		 * one form or other. kexec jump path also need
> > > -		 * one.
> > > +		 * one form or other. kexec jump path also need one.
> > >  		 */
> > >  		disable_IO_APIC();
> > 
> > Hi Wei,
> > 
> > As the comment says, kexec/kdump paths already have disable_IO_APIC(), why again here?
> 
> I also have this question. I guess Jiangang didn't post his modification
> correctly. He should remove calling of disable_IO_APIC in
> native_machine_crash_shutdown(). Assume his test was done on correct
> code change. 
Hi he,
Thanks for your suggestion firstly.

In fact, Eric had suggested me to do that last week
(https://lkml.org/lkml/2016/7/8/14).
And i had a try to remove the calling of disable_IO_APIC in
native_machine_crash_shutdown().
But it doesn't work for kdump with notsc.

Thanks,
wei
> 
> > 
> > Regards,
> > Xunlei
> > 
> > >  #endif
> > > diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> > > index 5a294e48b185..d3598cdd6437 100644
> > > --- a/arch/x86/kernel/machine_kexec_64.c
> > > +++ b/arch/x86/kernel/machine_kexec_64.c
> > > @@ -23,6 +23,7 @@
> > >  #include <asm/pgtable.h>
> > >  #include <asm/tlbflush.h>
> > >  #include <asm/mmu_context.h>
> > > +#include <asm/apic.h>
> > >  #include <asm/io_apic.h>
> > >  #include <asm/debugreg.h>
> > >  #include <asm/kexec-bzimage64.h>
> > > @@ -269,14 +270,13 @@ void machine_kexec(struct kimage *image)
> > >  	local_irq_disable();
> > >  	hw_breakpoint_disable();
> > >  
> > > -	if (image->preserve_context) {
> > > +	if (image->preserve_context || lapic_disabled()) {
> > >  #ifdef CONFIG_X86_IO_APIC
> > >  		/*
> > >  		 * We need to put APICs in legacy mode so that we can
> > >  		 * get timer interrupts in second kernel. kexec/kdump
> > >  		 * paths already have calls to disable_IO_APIC() in
> > > -		 * one form or other. kexec jump path also need
> > > -		 * one.
> > > +		 * one form or other. kexec jump path also need one.
> > >  		 */
> > >  		disable_IO_APIC();
> > >  #endif
> > 
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> 
> 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

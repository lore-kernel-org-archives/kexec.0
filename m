Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bMu0M-0005uo-O6
 for kexec@lists.infradead.org; Tue, 12 Jul 2016 09:29:27 +0000
Date: Tue, 12 Jul 2016 17:29:01 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2] kexec: Fix kdump failure with notsc
Message-ID: <20160712092901.GD3524@x1.redhat.com>
References: <1467886646-2638-1-git-send-email-weijg.fnst@cn.fujitsu.com>
 <578493AD.3000403@redhat.com> <1468314444.15074.65.camel@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1468314444.15074.65.camel@localhost>
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
To: "Wei, Jiangang" <weijg.fnst@cn.fujitsu.com>, ying.huang@intel.com
Cc: "fenghua.yu@intel.com" <fenghua.yu@intel.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "x86@kernel.org" <x86@kernel.org>, "xlpang@redhat.com" <xlpang@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>

On 07/12/16 at 09:09am, Wei, Jiangang wrote:
> On Tue, 2016-07-12 at 14:52 +0800, Xunlei Pang wrote:
> > On 2016/07/07 at 18:17, Wei Jiangang wrote:

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
> Frankly, I am not very clear about it as well...
> 
> Originally the codes and comment added by Huang Ying
> <ying.huang@intel.com>
> There may be some special reason...

Check code again, it might be native_disable_io_apic() is called in
disable_IO_APIC(). See the code comments at the beginning of
native_disable_io_apic(), ioapic_i8259 is used to record the pin of
ioapic which connect to 8259. Here ioapic is configured to virtual wire
mode to pass through interrupt to cpu. That might be why Huang Ying
said it can put it into legacy irq mode with calling with
disable_IO_APIC.

void native_disable_io_apic(void)
{
        /*
         * If the i8259 is routed through an IOAPIC
         * Put that IOAPIC in virtual wire mode
         * so legacy interrupts can be delivered.
         */
...
}

Now question is why disable_IO_APIC need be called twice to make ioapic
to be virtual wire mode.

Add Huang Ying to this thread, don't know if he can help explain.

> 
> The comment also said that it's used to put APICs in legacy mode so that
> we can get timer interrupts in second kernel. and we also need it in
> kexec jump path.
> 
> In fact, the jiffies calibration needs timer interrupts in second
> kernel. and the lapic and timer are not ready when second kernel waits
> them to update the jiffies value.
> 
> so I just want to reuse them and enable legacy mode (PIT timer) for
> notsc case.
> kernel.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

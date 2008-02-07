Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JMuna-0003tG-Q7
	for kexec@lists.infradead.org; Thu, 07 Feb 2008 00:39:38 +0000
Date: Thu, 7 Feb 2008 01:39:18 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH], issue EOI to APIC prior to calling crash_kexec in
	die_nmi path
Message-ID: <20080207003918.GA29943@elte.hu>
References: <20080206192555.GA24910@hmsendeavour.rdu.redhat.com>
	<20080206220001.GA15155@elte.hu>
	<20080206224805.GD11886@redhat.com>
	<47AA3B16.7000507@zytor.com> <20080206233657.GB12393@elte.hu>
	<m1r6fpd2uo.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1r6fpd2uo.fsf@ebiederm.dsl.xmission.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, "H. Peter Anvin" <hpa@zytor.com>, tglx@linutronix.de, Vivek Goyal <vgoyal@redhat.com>


* Eric W. Biederman <ebiederm@xmission.com> wrote:

> Looking at the patch the local_irq_enable() is totally bogus.  As soon 
> was we hit machine_crash_shutdown the first thing we do is disable 
> irqs.

yeah.

> I'm wondering if someone was using the switch cpus on crash patch that 
> was floating around.  That would require the ipis to work.
> 
> I don't know if nmi_exit makes sense.  There are enough layers of 
> abstraction in that piece of code I can't quickly spot the part that 
> is banging the hardware.
> 
> The location of nmi_exit in the patch is clearly wrong.  crash_kexec 
> is a noop if we don't have a crash kernel loaded (and if we are not 
> the first cpu into it), so if we don't execute the crash code 
> something weird may happen.  Further the code is just more 
> maintainable if that kind of code lives in machine_crash_shutdown.

nmi_exit() has no hw effects - it's just our own bookeeping.

the hw knows that we finished the NMI when we do an iret. Perhaps that's 
the bug or side-effect that made the difference: via enabling irqs we 
get an irq entry, and that does an iret and clears the NMI nested state 
- allowing the kexec context to proceed? I suspect kexec() will do an 
iret eventually (at minimum in the booted up kernel's context) - all 
NMIs are blocked up to that point and maybe the APIC doesnt really like 
being frobbed in that state? In any case, the local_irq_enable() is just 
wrong - it's the worst thing a crashing kernel can do. Perhaps doing an 
intentional iret with a prepared stack-let that just restores to 
still-irqs-off state and jumps to the next instruction could 'exit' the 
NMI context without really having to exit it in the kernel code flow?

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JMt3u-0002CL-AE
	for kexec@lists.infradead.org; Wed, 06 Feb 2008 22:48:20 +0000
Date: Wed, 6 Feb 2008 17:48:05 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH], issue EOI to APIC prior to calling crash_kexec in
	die_nmi path
Message-ID: <20080206224805.GD11886@redhat.com>
References: <20080206192555.GA24910@hmsendeavour.rdu.redhat.com>
	<20080206220001.GA15155@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080206220001.GA15155@elte.hu>
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
To: Ingo Molnar <mingo@elte.hu>
Cc: Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de

On Wed, Feb 06, 2008 at 11:00:01PM +0100, Ingo Molnar wrote:
> 
> * Neil Horman <nhorman@tuxdriver.com> wrote:
> 
> >  	if (!user_mode_vm(regs)) {
> > +		nmi_exit();
> > +		local_irq_enable();
> >  		current->thread.trap_no = 2;
> >  		crash_kexec(regs);
> 
> looks good to me, but please move the local_irq_enable() to within 
> crash_kexec() instead - probably inside the "got the kexec lock" 
> section. That makes crash_kexec() use generally safer too i guess: right 
> it seems that die() too can call crash_kexec() with irqs disabled - and 
> can thus hang in smp_send_stop() [or wherever it hung before].
> 

In general, I think we should not be servicing interrupts once the system
has crashed and crash_kexec() has been invoked. 

In fact, right now machine_crash_shutdown() explicity disables interrupt
before sending NMIs to other cpus to stop these cpus and which makes sense to
me.

I am wondering if interrupts are disabled on crashing cpu or if crashing
cpu is inside die_nmi(), how would it stop/prevent delivery of NMI IPI to
other cpus.

Am I missing something obivious?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

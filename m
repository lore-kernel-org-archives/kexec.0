Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JNWMR-0003SM-VZ
	for kexec@lists.infradead.org; Fri, 08 Feb 2008 16:46:06 +0000
Date: Fri, 8 Feb 2008 11:45:44 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH], issue EOI to APIC prior to calling crash_kexec in
	die_nmi path
Message-ID: <20080208164544.GA23772@redhat.com>
References: <20080206192555.GA24910@hmsendeavour.rdu.redhat.com>
	<20080206220001.GA15155@elte.hu>
	<20080206224805.GD11886@redhat.com>
	<47AA3B16.7000507@zytor.com> <20080206233657.GB12393@elte.hu>
	<m1r6fpd2uo.fsf@ebiederm.dsl.xmission.com>
	<20080207121719.GA29279@hmsreliant.think-freely.org>
	<20080207122404.GA8195@elte.hu>
	<20080208161422.GA32204@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080208161422.GA32204@hmsreliant.think-freely.org>
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
To: Neil Horman <nhorman@tuxdriver.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de

On Fri, Feb 08, 2008 at 11:14:22AM -0500, Neil Horman wrote:
> On Thu, Feb 07, 2008 at 01:24:04PM +0100, Ingo Molnar wrote:
> > 
> > * Neil Horman <nhorman@tuxdriver.com> wrote:
> > 
> > > Ingo noted a few posts down the nmi_exit doesn't actually write to the 
> > > APIC EOI register, so yeah, I agree, its bogus (and I apologize, I 
> > > should have checked that more carefully).  Nevertheless, this patch 
> > > consistently allowed a hangning machine to boot through an Nmi lockup.  
> > > So I'm forced to wonder whats going on then that this patch helps 
> > > with.  perhaps its a just a very fragile timing issue, I'll need to 
> > > look more closely.
> > 
> > try a dummy iret, something like:
> > 
> >   asm volatile ("pushf; push $1f; iret; 1: \n");
> > 
> > to get the CPU out of its 'nested NMI' state. (totally untested)
> > 
> > the idea is to push down an iret frame to the kernel stack that will 
> > just jump to the next instruction and gets it out of the NMI nesting. 
> > Note: interrupts will/must still be disabled, despite the iret. (the 
> > ordering of the pushes might be wrong, we might need more than that for 
> > a valid iret, etc. etc.)
> > 
> > 	Ingo
> 
> Just tried this experiment and it met with success.  Executing a dummy iret
> instruction got us to boot the kdump kernel successfully.  
> 

Interesting. So that means there is some operation we can't perform when
we are in NMI handler (Or nested NMIs, I don't know if this is nested NMI
case ).

Even if we initiated crash dump in NMI handler, next kernel should unlock
that state as soon as we enable interrupts in next kernel (iret will be
called).

So the only issue here will be if need to put the explicit logic to unlock
the NMI earlier (Either in crashing kernel after clearing IDT or in
purgatory code). Anything earlier then that, will be dangerous though, handling
another NMI while we are already crashed and doing final preparations to jump
to the new kernel.

Neil, is it possible to do some serial console debugging to find out
where exactly we are hanging? Beats me, what's that operation which can
not be executed while being in NMI handler and makes system to hang. I am
also curious to know if it is nested NMI case.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

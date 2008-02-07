Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ra.tuxdriver.com ([70.61.120.52])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JN5i9-0007Z1-85
	for kexec@lists.infradead.org; Thu, 07 Feb 2008 12:18:44 +0000
Date: Thu, 7 Feb 2008 07:17:19 -0500
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH], issue EOI to APIC prior to calling crash_kexec in
	die_nmi path
Message-ID: <20080207121719.GA29279@hmsreliant.think-freely.org>
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
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de, Vivek Goyal <vgoyal@redhat.com>

On Wed, Feb 06, 2008 at 05:31:11PM -0700, Eric W. Biederman wrote:
> Ingo Molnar <mingo@elte.hu> writes:
> 
> > * H. Peter Anvin <hpa@zytor.com> wrote:
> >
> >>> I am wondering if interrupts are disabled on crashing cpu or if 
> >>> crashing cpu is inside die_nmi(), how would it stop/prevent delivery 
> >>> of NMI IPI to other cpus.
> >>
> >> I don't see how it would.
> >
> > cross-CPU IPIs are a bit fragile on some PC platforms. So if the kexec 
> > code relies on getting IPIs to all other CPUs, it might not be able to 
> > do it reliably. There might be limitations on how many APIC irqs there 
> > can be queued at a time, and if those slots are used up and the CPU is 
> > not servicing irqs then stuff gets retried. This might even affect NMIs 
> > sent via APIC messages - not sure about that.
> 
> 
> 
> The design was as follows:
> - Doing anything in the crashing kernel is unreliable.
> - We do not have the information to do anything useful in the recovery/target
>   kernel.
> - Having the other cpus stopped is very nice as it reduces the amount of
>   weirdness happening.  We do not share the same text or data addresses
>   so stopping the other cpus is not mandatory.  On some other architectures
>   there are cpu tables that must live at a fixed address but this is not
>   the case on x86.
> - Having the location the other cpus were running at is potentially very
>   interesting debugging information.
> 
> Therefore the intent of the code is to send an NMI to each other cpu.  With
> a timeout of a second or so.  So that if the NMI do not get sent we continue
> on.
> 
> There is certainly still room for improving the robustness by not shutting
> down the ioapics and using less general infrastructure code on that path.
> That said I would be a little surprised if that is what is biting us.
> 
> Looking at the patch the local_irq_enable() is totally bogus.  As soon
> was we hit machine_crash_shutdown the first thing we do is disable irqs.
> 

Ingo noted a few posts down the nmi_exit doesn't actually write to the APIC EOI
register, so yeah, I agree, its bogus (and I apologize, I should have checked
that more carefully).  Nevertheless, this patch consistently allowed a hangning
machine to boot through an Nmi lockup.  So I'm forced to wonder whats going on
then that this patch helps with.  perhaps its a just a very fragile timing
issue, I'll need to look more closely.

> I'm wondering if someone was using the switch cpus on crash patch that was
> floating around.  That would require the ipis to work.
> 
Definately not the case, I did a clean build from a cvs tree to test this and
can verify that the switch cpu patch was not in place.

> I don't know if nmi_exit makes sense.  There are enough layers of abstraction
> in that piece of code I can't quickly spot the part that is banging the hardware.
> 
As ingo mentioned this does seem to be bogus.

> The location of nmi_exit in the patch is clearly wrong.  crash_kexec is a noop
> if we don't have a crash kernel loaded (and if we are not the first cpu into it),
> so if we don't execute the crash code something weird may happen.  Further the
> code is just more maintainable if that kind of code lives in machine_crash_shutdown.
> 
> 
> 
> Eric

-- 
/****************************************************
 * Neil Horman <nhorman@tuxdriver.com>
 * Software Engineer, Red Hat
 ****************************************************/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Ix0Gc-0005xn-Q4
	for kexec@lists.infradead.org; Tue, 27 Nov 2007 13:14:29 +0000
Date: Tue, 27 Nov 2007 08:13:55 -0500
From: Neil Horman <nhorman@redhat.com>
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on boot
	cpu
Message-ID: <20071127131355.GA14887@hmsendeavour.rdu.redhat.com>
References: <20071127014740.GA28622@hmsreliant.think-freely.org>
	<m1d4twmimu.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1d4twmimu.fsf@ebiederm.dsl.xmission.com>
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
Cc: Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, ak@suse.de, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, vgoyal@in.ibm.com

On Mon, Nov 26, 2007 at 09:12:25PM -0700, Eric W. Biederman wrote:
> Neil Horman <nhorman@tuxdriver.com> writes:
> 
> > Hey all-
> > 	I've been working on an issue lately involving multi socket x86_64
> > systems connected via hypertransport bridges.  It appears that some systems,
> > disable the hypertransport connections during a kdump operation when all but the
> > crashing processor gets halted in machine_crash_shutdown.  This becomes a
> > problem when the ioapic attempts to route interrupts to the only remaining
> > processor.  Even though the active processor is targeted for interrupt
> > reception, the fact that the hypertransport connections are inactive result in
> > interrupts not getting delivered.  The effective result is that timer interrupts
> > are not delivered to the running cpu, and the system hangs on reboot into the
> > kdump kernel during calibrate_delay.  I've found that I've been able to avoid
> > this hang, by forcing a transition to the bios defined boot cpu during the
> > crashing kernel shutdown.  This patch accomplished that.  Tested by myself and
> > the origional reporter with successful results.
> 
> If you can get to calibrate_delay hypertransport is still routing traffic.
> Your diagnosis of the problem is wrong.  Most likely it is just an ioapic
> programming error in restoring the system to PIC mode.
> 
What makes you say this?  I don't see any need for interrupts prior to
calibrate_delay()

> I agree that there is a problem.
> 
> The reliable fix is to totally skip the PIC interrupt mode and go directly
> to apic mode.
> 
> To make the code kexec on panic code path reliable we need to remove code
> not add it.
> 
> Frankly I think switching cpus is one of the least reliable things that
> we can do in general.
> 
I understand the sentiment here, but its not like we're adding additional
functionality with this patch.  We're already sending an IPI to all the
processors to halt them, we're just adding logic here so that we can detect the
boot cpu and use it to jump to the kexec image instead of halting.  I don't
think this is any less reliable that what we have currently.

Regards
Neil

> Eric
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

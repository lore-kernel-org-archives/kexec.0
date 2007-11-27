Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1IwsOw-0006wk-FZ
	for kexec@lists.infradead.org; Tue, 27 Nov 2007 04:50:26 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on boot
	cpu
References: <20071127014740.GA28622@hmsreliant.think-freely.org>
Date: Mon, 26 Nov 2007 21:12:25 -0700
In-Reply-To: <20071127014740.GA28622@hmsreliant.think-freely.org> (Neil
	Horman's message of "Mon, 26 Nov 2007 20:47:40 -0500")
Message-ID: <m1d4twmimu.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
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
Cc: hbabu@us.ibm.com, vgoyal@in.ibm.com, kexec@lists.infradead.org, ak@suse.de, linux-kernel@vger.kernel.org

Neil Horman <nhorman@tuxdriver.com> writes:

> Hey all-
> 	I've been working on an issue lately involving multi socket x86_64
> systems connected via hypertransport bridges.  It appears that some systems,
> disable the hypertransport connections during a kdump operation when all but the
> crashing processor gets halted in machine_crash_shutdown.  This becomes a
> problem when the ioapic attempts to route interrupts to the only remaining
> processor.  Even though the active processor is targeted for interrupt
> reception, the fact that the hypertransport connections are inactive result in
> interrupts not getting delivered.  The effective result is that timer interrupts
> are not delivered to the running cpu, and the system hangs on reboot into the
> kdump kernel during calibrate_delay.  I've found that I've been able to avoid
> this hang, by forcing a transition to the bios defined boot cpu during the
> crashing kernel shutdown.  This patch accomplished that.  Tested by myself and
> the origional reporter with successful results.

If you can get to calibrate_delay hypertransport is still routing traffic.
Your diagnosis of the problem is wrong.  Most likely it is just an ioapic
programming error in restoring the system to PIC mode.

I agree that there is a problem.

The reliable fix is to totally skip the PIC interrupt mode and go directly
to apic mode.

To make the code kexec on panic code path reliable we need to remove code
not add it.

Frankly I think switching cpus is one of the least reliable things that
we can do in general.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

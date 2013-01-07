Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 7 Jan 2013 14:25:54 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] ARM: call disable_nonboot_cpus() from machine_shutdown()
Message-ID: <20130107142554.GG13542@mudshark.cambridge.arm.com>
References: <1357160861-26282-1-git-send-email-swarren@wwwdotorg.org>
 <50E4C9C6.20609@codeaurora.org>
 <20130103120259.GB5193@mudshark.cambridge.arm.com>
 <20130103122100.GN2631@n2100.arm.linux.org.uk>
 <50E5E967.3020805@wwwdotorg.org>
 <20130106162200.GC11025@mudshark.cambridge.arm.com>
 <20130106164033.GA3222@n2100.arm.linux.org.uk>
 <87ehhxahd1.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87ehhxahd1.fsf@xmission.com>
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
Cc: Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Stephen Boyd <sboyd@codeaurora.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Eric,

On Mon, Jan 07, 2013 at 01:53:30AM +0000, Eric W. Biederman wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> > The problem is... on ARM we're yet again shot in the foot through the
> > unwillingness to architect certain aspects of the system: there is no
> > architecturally known way to place CPUs into a reset state once they've
> > been started up.  In other words, once a CPU starts executing kernel
> > code, it needs to always execute kernel code or there must be some kind
> > of platform specific hook to disable it.
> >
> > Maybe that's the answer here: have machine_shutdown() call out to some
> > platform specific function to do the forced-takedown of secondary CPUs,
> > and if there's no such specific function, then we use our present CPU
> > stopping method of making them spin in a WFI loop with IRQs disabled.
> 
> Yes.  On x86 we have had the generic equivalent of disable_nonboot_cpus
> in the machine_shutdown for a long time.

Ok, we can do that that on ARM too, but we currently call machine_shutdown
from machine_{power_off, halt, restart} so we just need to fix that and we
will be doing functionally the same thing as x86.

> Please note the only code path that generically calls machine_shutdown()
> is kernel_kexec() so if you wish you can avoid duplication by
> refactoring you architecture specific code.

Exactly, that sounds like the right way forward to me. Thanks.

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

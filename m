Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga14.intel.com ([143.182.124.37])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JwrqG-0005Ly-FV
	for kexec@lists.infradead.org; Fri, 16 May 2008 04:46:52 +0000
Subject: Re: [PATCH] kexec based hibernation: a prototype of kexec
	multi-stage load
From: "Huang, Ying" <ying.huang@intel.com>
In-Reply-To: <m1tzgzez4f.fsf@frodo.ebiederm.org>
References: <1210574441.30365.8.camel@caritas-dev.intel.com>
	<20080513053408.GA5870@redhat.com>
	<1210730266.23707.50.camel@caritas-dev.intel.com>
	<20080514025607.GA19944@redhat.com>
	<1210736275.23707.62.camel@caritas-dev.intel.com>
	<m1lk2c4l4i.fsf@frodo.ebiederm.org>
	<1210827473.23707.133.camel@caritas-dev.intel.com>
	<20080516020043.GC6926@redhat.com>
	<1210904374.23707.178.camel@caritas-dev.intel.com>
	<m1tzgzez4f.fsf@frodo.ebiederm.org>
Date: Fri, 16 May 2008 12:52:48 +0800
Message-ID: <1210913568.23707.230.camel@caritas-dev.intel.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

On Thu, 2008-05-15 at 19:55 -0700, Eric W. Biederman wrote:
> "Huang, Ying" <ying.huang@intel.com> writes:
> 
> > The disadvantage of this solution is that kernel B must know it is
> > original kernel (A) or kexeced kernel (B). Different code should be used
> > by kernel A and kernel B. And after jump from A to B, jump from B to A,
> > when jump from A to B again, kernel A must use different code from the
> > first time.
> 
> I don't know what the case is for keeping two kernels in memory and switching
> between them.

This can be used to save the memory image of kernel B and accelerate the
hibernation. The real boot of kernel B is only needed first time.

> I suspect a small piece of trampoline code between the two kernels could
> handle the case. (i.e. purgatory pays attention).
> 
> That is a fundamental aspect of the design.  A general purpose infrastructure
> with trampoline code to adapt it to whatever situation comes up.

It is possible to use purgatory to deal with this problem.

Jump from kernel A to kernel B
    Jump to entry of purgatory (purgatory_entry)
    purgatory save the return address (kexec_jump_back_entry_A)
    Purgatory set kexec_jump_back_entry for kernel B to a code
        segment in purgatory, say kexec_jump_back_entry_A_for_B
    Purgatory jump to entry point of kernel B
Jump from kernel B to kernel A
    Jump to purgatory (kexec_jump_back_entry_A_for_B)
    Purgatory save the return address (kexec_jump_back_entry_B)
    Purgatory return to kernel A (kexec_jump_back_entry_A)
Jump from kernel A to kernel B again
    Jump to entry of purgatory (purgatory_entry)
    Purgatory save the return address (kexec_jump_back_entry_A)
    Purgatory jump to kexec_jump_back_entry_B

The disadvantage of this solution is that some information is saved in
purgatory (kexec_jump_back_entry_A, kexec_jump_back_entry_B). So,
purgatory must be saved too when save the memory image of kernel A or
kernel B. Purgatory can be seen as a part of kernel B. But it is a
little tricky to think it as a part of kernel A too.

Best Regards,
Huang Ying

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

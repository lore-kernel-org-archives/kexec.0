Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jwq1m-0007QB-SQ
	for kexec@lists.infradead.org; Fri, 16 May 2008 02:50:39 +0000
Subject: Re: [PATCH] kexec based hibernation: a prototype of kexec
	multi-stage load
From: "Huang, Ying" <ying.huang@intel.com>
In-Reply-To: <m14p8zgf43.fsf@frodo.ebiederm.org>
References: <1210574441.30365.8.camel@caritas-dev.intel.com>
	<20080513053408.GA5870@redhat.com>
	<1210730266.23707.50.camel@caritas-dev.intel.com>
	<20080514025607.GA19944@redhat.com>
	<1210736275.23707.62.camel@caritas-dev.intel.com>
	<m1lk2c4l4i.fsf@frodo.ebiederm.org>
	<1210827473.23707.133.camel@caritas-dev.intel.com>
	<m1lk2bs970.fsf@frodo.ebiederm.org>
	<1210902114.23707.156.camel@caritas-dev.intel.com>
	<m14p8zgf43.fsf@frodo.ebiederm.org>
Date: Fri, 16 May 2008 10:56:15 +0800
Message-ID: <1210906575.23707.189.camel@caritas-dev.intel.com>
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

On Thu, 2008-05-15 at 19:25 -0700, Eric W. Biederman wrote:
> "Huang, Ying" <ying.huang@intel.com> writes:
> 
> > On Thu, 2008-05-15 at 11:39 -0700, Eric W. Biederman wrote:
> > [...]
> >> 2) After we figure out our address read the stack pointer from
> >>    a fixed location and simply set it.  (This is my preference)
> >
> > Just for confirmation (My English is poor).
> >
> > Do you mean that kernel A just read the stack top as re-entry point,
> > regardless of whether it is return address or argument 1?
> 
> What I was thinking was:
> 
> In kernel A()
> 
> relocate_new_kernel:
> 
>         ...
> 
>         call	*%eax
> 
> kexec_jump_back_entry:
>         /* This code should be PIC so figure out where we are */
>         call	1f
> 1:
>         popl	%edi
>         subl	$(1b - relocate_kernel), %edi
> 
>         /* Setup a safe stack */
>         leal    PAGE_SIZE(%edi), %esp
>         ...
> 
> 
> Then in purgatory we can read the address of kexec_jump_back_entry
> by examining 0(%esp) and export it in whatever fashion is sane.
> 
> However we reach kexec_jump_back_entry we should be fine.

I think it is reasonable to enable jumping back and forth more than one
time. So the following should be possible:

1. Jump from A to B (actually jump to purgatory, trigger the boot of B)
2. Jump from B to A
3. Jump from A to B again (jump to the kexec_jump_back_entry of B)
4. Jump from B to A
...

So it should be possible to get the re-entry point of kernel B in
kexec_jump_back_entry of kernel A too. So I think in
kexec_jump_back_entry, the caller's stack should be checked to get
re-entry point of peer. And the stack state is different depend on where
come from, from relocate_new_kernel() or return.

Best Regards,
Huang Ying


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jwqc7-0006xe-FH
	for kexec@lists.infradead.org; Fri, 16 May 2008 03:28:11 +0000
Date: Thu, 15 May 2008 23:27:58 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] kexec based hibernation: a prototype of kexec
	multi-stage load
Message-ID: <20080516032758.GD6926@redhat.com>
References: <20080513053408.GA5870@redhat.com>
	<1210730266.23707.50.camel@caritas-dev.intel.com>
	<20080514025607.GA19944@redhat.com>
	<1210736275.23707.62.camel@caritas-dev.intel.com>
	<m1lk2c4l4i.fsf@frodo.ebiederm.org>
	<1210827473.23707.133.camel@caritas-dev.intel.com>
	<m1lk2bs970.fsf@frodo.ebiederm.org>
	<1210902114.23707.156.camel@caritas-dev.intel.com>
	<m14p8zgf43.fsf@frodo.ebiederm.org>
	<1210906575.23707.189.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1210906575.23707.189.camel@caritas-dev.intel.com>
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
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>

On Fri, May 16, 2008 at 10:56:15AM +0800, Huang, Ying wrote:
> On Thu, 2008-05-15 at 19:25 -0700, Eric W. Biederman wrote:
> > "Huang, Ying" <ying.huang@intel.com> writes:
> > 
> > > On Thu, 2008-05-15 at 11:39 -0700, Eric W. Biederman wrote:
> > > [...]
> > >> 2) After we figure out our address read the stack pointer from
> > >>    a fixed location and simply set it.  (This is my preference)
> > >
> > > Just for confirmation (My English is poor).
> > >
> > > Do you mean that kernel A just read the stack top as re-entry point,
> > > regardless of whether it is return address or argument 1?
> > 
> > What I was thinking was:
> > 
> > In kernel A()
> > 
> > relocate_new_kernel:
> > 
> >         ...
> > 
> >         call	*%eax
> > 
> > kexec_jump_back_entry:
> >         /* This code should be PIC so figure out where we are */
> >         call	1f
> > 1:
> >         popl	%edi
> >         subl	$(1b - relocate_kernel), %edi
> > 
> >         /* Setup a safe stack */
> >         leal    PAGE_SIZE(%edi), %esp
> >         ...
> > 
> > 
> > Then in purgatory we can read the address of kexec_jump_back_entry
> > by examining 0(%esp) and export it in whatever fashion is sane.
> > 
> > However we reach kexec_jump_back_entry we should be fine.
> 

Huang is making use of purgatory only for booting kernel B for the first
time. Once the kernel B is booted, all the trasitions (A-->B and B<--A)
happen without using purgatory. Just keep on jumping back and forth
to "kexec_jump_back_entry".

Probably not using purgatory for later transitions is justified as long as
kernel code is simple and small. Otherwise we will shall have to teach
purgatory also of special case of resuming kernel B or booting kernel B.

> I think it is reasonable to enable jumping back and forth more than one
> time. So the following should be possible:
> 
> 1. Jump from A to B (actually jump to purgatory, trigger the boot of B)
> 2. Jump from B to A
> 3. Jump from A to B again (jump to the kexec_jump_back_entry of B)
> 4. Jump from B to A
> ...
> 
> So it should be possible to get the re-entry point of kernel B in
> kexec_jump_back_entry of kernel A too. So I think in
> kexec_jump_back_entry, the caller's stack should be checked to get
> re-entry point of peer. And the stack state is different depend on where
> come from, from relocate_new_kernel() or return.
> 

To me this idea also looks good. So control flow will look something
as follows?

relocate_new kernel:
	
	if (!preserve_context)
		set registers to known state.
		jump to purgatory.
	else
		goto jump-back-setup:

jump-back-setup:
- Color the stack.
  move $0xffffffff 0(%esp)

- call %edx

kexec_jump_back_entry:

- If 0 (%esp) is not -1
	image->start = 0(%esp)  //Re entry point of kernel B. Store it.
  else
	We returned from BIOS call. Re-entry point has not changed
        Do nothing.

- Continue to resume kernel A

Thanks
Vivek
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

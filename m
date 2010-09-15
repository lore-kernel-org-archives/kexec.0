Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OvwNG-0002Vs-Oe
	for kexec@lists.infradead.org; Wed, 15 Sep 2010 18:06:30 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <A0628CD0-7A34-488D-A8C8-D8C12C6E8141@freescale.com>
Date: Wed, 15 Sep 2010 11:05:39 -0700
In-Reply-To: <A0628CD0-7A34-488D-A8C8-D8C12C6E8141@freescale.com> (Matthew
	McClintock's message of "Thu, 9 Sep 2010 16:25:53 -0500")
Message-ID: <m1tylq7uh8.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: Optimizations for purgatory
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
To: Matthew McClintock <msm@freescale.com>
Cc: kexec@lists.infradead.org

Matthew McClintock <msm@freescale.com> writes:

> Hello all,
>
> I've been compiling kexec-tools natively for ppc32 and everything has been working fine. However, I recently had to start cross compiling on an x86_64 box and I ran into an issue with the code generation in purgatory. I can eliminate the my issue by stepping down to (or up?) to -O2 -fno-reorder-blocks. Somehow -freorder-blocks is causing a problem even though according to the gcc documentation -Os disables this flag [1]. If I had to make a guess, I would think that purgatory elf relocatable generated with my compiler is not being properly updated by kexec-tools before being passed to the kernel.
>
> So my question is two-fold...
>
> 1) Is there any reason we don't just use -O0 instead of -0s? This
> would provide a consistent set of compiler optimization flags across
> all versions of gcc and we don't have to worry about a flag being
> added or removed across versions. Or perhaps explicitly list all
> desired flags?

So -O0 should do no optimization.  Last I looked the trick with the
purgatory code was to compile it cleanly enough that we had support of
the different relocation types needed in order to relocate the code
at link time.  Usually this winds up being a small subset of the
linking types of what the architecture supports.

> 2) Has anyone else experienced issue with purgatory code not being
> generated correctly? Specifically looking at a disassebly it looks
> like -freorder-blocks is changed how functions return. On ppc for
> example it appears that the functions are not returning using the link
> register and instead are just branching.

The only problem I have previously seen is having an unsupported
relocation type.  Can you confirm that isn't happening.  Ultimately
if your gcc isn't compiling the code correctly unless we understand
exactly why that doesn't work we can't make a sensible judgement
on a good work around.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jopor-0002ZB-4u
	for kexec@lists.infradead.org; Thu, 24 Apr 2008 01:00:13 +0000
Date: Thu, 24 Apr 2008 11:00:03 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/9] kexec userspace and purgatory cleanups
Message-ID: <20080424010000.GA7278@verge.net.au>
References: <1208906472-18465-1-git-send-email-jamey@thetovacompany.com>
	<m1bq40oesg.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1bq40oesg.fsf@frodo.ebiederm.org>
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
Cc: kexec@lists.infradead.org, Jamey Sharp <jamey@thetovacompany.com>

On Wed, Apr 23, 2008 at 06:56:47AM -0700, Eric W. Biederman wrote:
> Jamey Sharp <jamey@thetovacompany.com> writes:
> 
> > GIT: Please enter your email below.
> > GIT: Lines beginning in "GIT: " will be removed.
> > GIT: Consider including an overall diffstat or table of contents
> > GIT: for the patch you are writing.
> >
> > This patch series fixes issues I encountered while porting kexec to run
> > on Windows. (I'll be happy to say more about that insane, but
> > surprisingly successful, plan on another occasion.) 
> 
> Sounds fun.  I like the idea of /sbin/kexec running on other operating
> systems, as long as it isn't too much maintenance overhead.
> 
> Portability tends to reveal all kinds of things, and increase
> the user/developer base.
> 
> Now if we only had the code to boot windows...
> 
> > These patches,
> > however, are only the ones that affect the kexec userspace tools on
> > Linux. They fall into three categories.
> 
> I just took a quick skim through the patches and they generally
> look good.

I have done likewise and they seem fine to me.
I am going to go ahead and merge them.

> > Bug fixes, primarily in the i386 purgatory source:
> > - [1/9] Fix undefined symbol errors on readw/writew.
> > - [2/9] Fix copy-paste bug: entry16 does not start at entry16_debug.
> > - [3/9] Conform more closely to Documentation/i386/boot.txt.
> > - [9/9] Die on early EOF in slurp_file, instead of infinite-looping.
> >
> > Compiler and assembler warning fixes:
> > - [4/9] Fix "Warning: indirect jmp without `*'".
> > - [5/9] Fix all gcc warnings for ARCH=i386 builds.

Thanks, I've had less successful attempts at that myself.

> > Cleanups or simplifications:
> > - [6/9] <sys/mman.h> is not needed by any i386 kexec/ source.

I have been able to confrim that its not needed by other arches either -
well, more specifically I've confirmed that if you take it out all
the architectures still compile. I'll post a patch that removes
<sys/mman.h> for non-i386 to complete your work here.

> > - [7/9] Replace weak definitions with source filename overriding.
>   The other benefit of this is that it slightly reduces the binary
>   size which is advantageous for embedded development.
> 
> > - [8/9] Simplify initialization of argument list for `shutdown`.
> 
> I lifted this out sysvinit where that structure is needed because
> processing of optional processing of the -t <when> option.  Since
> we aren't doing that your structure is better.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

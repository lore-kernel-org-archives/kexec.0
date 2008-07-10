Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KH5FX-000274-81
	for kexec@lists.infradead.org; Thu, 10 Jul 2008 23:08:31 +0000
Date: Fri, 11 Jul 2008 09:08:28 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: Future of kexec-tools-testing
Message-ID: <20080710230827.GC11227@verge.net.au>
References: <20080710112912.21641167@halley.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080710112912.21641167@halley.suse.de>
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
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org

On Thu, Jul 10, 2008 at 11:29:12AM +0200, Bernhard Walle wrote:
> Hi,
> 
> SUSE uses now kexec-tools-testing releases since about one year and
> we never had severe problems (compared to other software). It's well
> maintained (thanks Simon!), gets frequent releases, patches are
> accepted, so:
> 
>  - I would suggest that kexec-tools-testing could be renamed to
>    kexec-tools somewhere in the future since kexec-tools is not
>    maintained any more by Eric. It only causes confusion since
>    some distributions still use kexec-tools (the original ones)
>    with lots of patches.

I agree.

Perhaps we could make the next release kexec-tools 2.0.0, perhaps
after a few beta releases?

I can rename my git tree to coincide with this move.

>    I think current IA64 versions even do not work with kexec-tools
>    since there were some incompatible changes related to the
>    position of ELF core headers.

Yes, I think you are right.

>  - I would suggest that kexec-tools gets normal release numbers.
>    The date releases are quite bad for package managers since it's
>    not possible to go back (in terms of a clean update path)
>    from something like 20080101 to 1.5 since 2008 is always greater.
> 
>    Currently SUSE ships still the old 1.101 version and the real
>    release is only visible in the changelog. Of course it's possible to
>    do something like 1.101+20080101, but it's nasty.

That is fine by me. But we may as well rename the package to kexec-tools
at the same time.

> If I could help out doing some work to help to get that done, then just
> tell me.

You're already helping a lot.

Perhaps the best thing to do now would be to hash out a release roadmap.
Fortunately the code is pretty small, so it shouldn't be a very long road.

Do you think there is anything currently missing from the tree?
If not, I can make a beta release early next week (I have to leave
my desk for an extended weekend shortly).

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

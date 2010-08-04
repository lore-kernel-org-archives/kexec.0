Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Ogd5V-0000jY-I1
	for kexec@lists.infradead.org; Wed, 04 Aug 2010 12:28:50 +0000
Date: Wed, 4 Aug 2010 08:26:00 -0400
From: Neil Horman <nhorman@redhat.com>
Subject: Re: [rfc] Merge kexec-tools into the kernel tree
Message-ID: <20100804122600.GC14270@hmsreliant.think-freely.org>
References: <20100804070647.GB24064@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100804070647.GB24064@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Neuling <mikey@neuling.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>

On Wed, Aug 04, 2010 at 04:06:48PM +0900, Simon Horman wrote:
> Hi,
> 
> After all the excitement of relocating kexec-tools from
> one location on kernel.org to another last week it was
> suggested to me by Michael Neuling that the merging
> kexec-tools into the kernel tree would be a good idea.
> 
> Given that there have been a bunch of issues with kexec
> on power that this would resolve. and there is precedence
> for tools in the kernel tree, this sounds entirely reasonable to me.
> So with my kexec-tools maintainer hat on, I would like to start
> a conversation about this.
> 
> In order to move the conversation along I have prepared a tree -
> a recent clone of Linus's tree + kexec tools.
> 
> http://git.kernel.org/?p=linux/kernel/git/horms/kexec-tools-in-kernel-tree.git
> 
> I think that a good next step would be to get this tree into linux-next.
> And then if all goes well, as Linus to pull the change some time in the future.
> 
> 
> 
> 
> 
> For reference the steps taken to make the tree above were roughly as follows.
> Thanks to Michael for assistance with this.
> 
> git clone
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> git clone git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> 
> cd linux-2.6
> 
> git remote add -f kexec ../kexec-tools
> git merge -s ours --no-commit kexec/master
> git read-tree --prefix=tools/kexec/ -u kexec/master
> git commit -m "Merge kexec-tools into subdirectory tools/kexec"
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


It seems to me that this change isn't overly usefull in solving the problems
that kexec-tools seems to chronically encounter.  The biggest kexec/kernel
problem that I seem to encounter during maintence of the package in RHEL isn't
ABI compatibility between any kexec/kernel version pair (which can often be
mitigated/controlled by merging the source trees), but rather by lack of testing
of changes.  All to often kernel code authors assume that if something they
write or modify works in the kernel during a normal boot, it can be assumed to
work just fine in the kdump kernel.  That _should_ be the case, bur rarely is
it.  And unfortunately, that won't be mitigated by tying a kexec and kernel
version together.

What I think we need is a shorter path from upstream commit to regression/bug
detection.  Something that would allow someone to validate that kexec works
properly after they have made a commit to hardware that they have in hand.
Perhaps something in the scripts directory that allows a developer to
immediately execute a kexec -e reboot and a kexec -l; sysrq-c crash reboot to
validate that their changes are working properly.  Perhaps if we added a step to
the submission checklist including the running of said script, we'd see less
hardware specific regressions.

My $0.02
Neil


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

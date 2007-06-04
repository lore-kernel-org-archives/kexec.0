Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hv94u-0000Z3-Bl
	for kexec@lists.infradead.org; Mon, 04 Jun 2007 05:42:22 -0400
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] kexec ppc64: fix misaligned cmdline 
In-reply-to: <8f5d8a214e9042b0c556ac7256928a52@bga.com> 
References: <25445.1180941825@neuling.org>
	<8f5d8a214e9042b0c556ac7256928a52@bga.com>
Date: Mon, 04 Jun 2007 19:42:16 +1000
Message-ID: <26608.1180950136@neuling.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Milton Miller <miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, horms@verge.net.au, kexec@lists.infradead.org, Santhosh Rao <sonny@burdell.org>

> While this appears to fix the stated problem, did you explore my
> suggestion of deleting and creating the property like we do for
> the initrd base and size?

Yeah, but it didn't seem "hapazard" enough for kexec. :-)

> Deleting and recreating should also handle the case of no boot-args in
> the original /chosen sub-tree (when the bootloader didn't (need to)
> supply a command line).

Yeah, we're screwed when the first boot has no bootargs.

Let me get the policy right.  We blow away the old command line except
for the "root=blah" item.  Correct?

Mikey

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

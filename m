Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Ksmyl-0000YG-D9
	for kexec@lists.infradead.org; Wed, 22 Oct 2008 23:19:04 +0000
Date: Thu, 23 Oct 2008 10:18:56 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/3] powerpc: kexec exit should not use magic numbers
Message-ID: <20081022231854.GB5247@verge.net.au>
References: <f90d4d7306443a720ca31adf513faf25@bga.com> <kexec-kern-1@bga.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <kexec-kern-1@bga.com>
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
To: Milton Miller <miltonm@bga.com>
Cc: Ben Herrenschmidt <benh@kernel.crashing.org>, kexec@lists.infradead.org, Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@ozlabs.org, Mohan Kumar M <mohan@in.ibm.com>, Paul Mackerras <paulus@samba.org>

[ Added Mohan Kumar to CC list ]

On Wed, Oct 22, 2008 at 03:39:18PM -0500, Milton Miller wrote:
> The relocatable kernel kdump patch (54622f10a6aabb8bb2bdacf3dd070046f03dc246)
> added a magic flag value in a register to tell purgatory that it should
> be a panic kernel.  This part is wrong and is reverted by this patch.
> 
> The kernel gets a list of memory blocks and a entry point from user space.
> Its job is to copy the blocks into place and then branch to the designated
> entry point (after turning "off" the mmu).
> 
> The user space tool inserts a trampoline, called purgatory, that runs
> before the user supplied code.   Its job is to establish the entry
> environment for the new kernel or other application based on the contents
> of memory.  The purgatory code is compiled and embedded in the tool,
> where it is later patched using the elf symbol table using elf symbols.
> 
> Since the tool knows it is creating a purgatory that will run after a
> kernel crash, it should just patch purgatory (or the kernel directly)
> if something needs to happen.

Hi Milton,

All of these patches look fine to me.

On the kernel side:
Acked-by: Simon Horman <horms@verge.net.au>

On the kexec-tools side:
I'd rather wait until the kernel changes get merged before merging
the kexec-tools portion. Please ping me at that point.


I'd like to note that these changes really ought to go into the same kernel
(and kexec-tools) release that the relocateable kdump patches as they will
introduce incompatibility. For example, crash-dump kernels with only the
relocatable kdump changes will not be usable if the first-kernel includes
these changes. I think that means that this needs to go into 2.6.28 -
assuming that Linus accepts the pull request than Ben Herrenschmidt sent
recently.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

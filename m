Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1OCZtZ-0000N9-Q4
	for kexec@lists.infradead.org; Thu, 13 May 2010 15:01:10 +0000
Date: Fri, 14 May 2010 00:00:10 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 2/2] powerpc new toolchains fix (crt.S)
Message-ID: <20100513150008.GC10534@verge.net.au>
References: <20100512070841.9572.78661.stgit@muvarov>
	<20100512070849.9572.84728.stgit@muvarov>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100512070849.9572.84728.stgit@muvarov>
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
To: Maxim Uvarov <muvarov@gmail.com>
Cc: lists@nerdbynature.de, kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, cbouatmailru@gmail.com

On Wed, May 12, 2010 at 11:08:49AM +0400, Maxim Uvarov wrote:
> 
> Hello everybody,
> 
>       Changes from previous version:
>       - removed bogus hyphen from the patch;
>       - move ifdefs to crt.S instead of Makefile
> 
> 
>       Please find here patch for user land kexec-tools application. Following
>       patch makes kexec-tools work for both kexec and kdump. I tested it with 
>       git kernel (linus-tree) and Freescale/Logic MPC8360ERDK board with 
>       mpc83xx_defconfig kernel config.
> 
>       kexec:
>       kexec -l vmlinux --command-line="console= ... etc"
>       kexec -e
> 
>       kdump:
>       kexec -p vmlinux_dump --command-line="console=... etc"
>       echo c > /proc/sysrq-trigger
> 
>       I also think that is is reasonable:
>       - put GAME_CUBE specific code to separate files;
>       - combine  ppc and ppc64 to powerpc directory (I'm planning to do it.
> 	And that why in some places my patch have ifdefs for PPC64);
> 
> Best regards,
> Maxim Uvarov.

Thanks,

I'm assuming that the silence that this patch set received,
in contrast to the first revision where there was some quick discussion,
means that everyone is ok with these changes. So I've gone ahead and pushed
them into the tree.

> From: Maxim Uvarov <muvarov@gmail.com>
> 
> Linker does not provide some vital functions when building freestanding
> applications with a new toolchain, so we have to provide our own CRT.
> 
> p.s.
> Without the CRT we won't see any build errors (since the purgatory is
> linked with --no-undefined), but the purgatory code won't work,
> 'kexec -e' will just hang the board.
> 
> 
> I added option to configure to keep code buildable for old toolchais.
> But there should be way to do this automatically.

I seem to have an old toolchain :-)

> Author: Anton Vorontsov <avorontsov@ru.mvista.com>
> Signed-off-by: Maxim Uvarov <muvarov@gmail.com>
> Signed-off-by: Maxim Uvarov <muvarov@gmail.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

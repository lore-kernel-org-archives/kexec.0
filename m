Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K6yqB-0007OU-Ok
	for kexec@lists.infradead.org; Fri, 13 Jun 2008 02:16:36 +0000
Date: Fri, 13 Jun 2008 12:16:30 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Fix wrong remove_parameter() calls
Message-ID: <20080613021629.GE12174@verge.net.au>
References: <20080612021935.GG22358@verge.net.au>
	<1213287025-5443-1-git-send-email-bwalle@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1213287025-5443-1-git-send-email-bwalle@suse.de>
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

On Thu, Jun 12, 2008 at 06:10:25PM +0200, Bernhard Walle wrote:
> When --reuse-cmdline is specified, kexec automatically removes some command
> line parameter that are *known* to break the kexec'd target. That patch
> corrects that behaviour:
> 
>  1. BOOT_IMAGE should be removed always when --reuse-cmdline is specified since
>     it's likely that the kernel is not the same as the running kernel. As only
>     lilo-like bootloaders (i.e. not GRUB) adds that parameter, there's no need
>     to add a BOOT_IMAGE here.
> 
>  2. crashkernel should be only removed when 'kexec -p' is called. For the
>     normal kexec, the crashkernel parameter can be passed as in the
>     running kernel.
> 
> The mistake has been introduced by commit 3c5bb06948881b3e31c783c19edef74275794280
> by myself.

Thans Bernhard, applied.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

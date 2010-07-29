Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OeOYT-0005cL-7F
	for kexec@lists.infradead.org; Thu, 29 Jul 2010 08:33:29 +0000
Date: Thu, 29 Jul 2010 17:33:25 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 5/7] Add support for ramdisk on ppc32 for uImage-ppc
	and Elf-ppc
Message-ID: <20100729083324.GC10021@verge.net.au>
References: <1279656900-27458-1-git-send-email-msm@freescale.com>
	<1279656900-27458-2-git-send-email-msm@freescale.com>
	<1279656900-27458-3-git-send-email-msm@freescale.com>
	<1279656900-27458-4-git-send-email-msm@freescale.com>
	<1279656900-27458-5-git-send-email-msm@freescale.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1279656900-27458-5-git-send-email-msm@freescale.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org

On Tue, Jul 20, 2010 at 03:14:58PM -0500, Matthew McClintock wrote:
> This fixes --reuseinitrd and --ramdisk option for ppc32 on
> uImage-ppc and Elf. It works for normal kexec as well as for
> kdump.
> 
> When using --reuseinitrd you need to specifify retain_initrd
> on the command line. Also, if you are doing kdump you need to make
> sure your initrd lives in the crashdump region otherwise the
> kdump kernel will not be able to access it. The --ramdisk option
> should always work.

Thanks, I have applied this change.
I had to do a minor merge on the Makefile,
could you verify that the result is correct?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

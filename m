Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OZEnk-0003wA-9O
	for kexec@lists.infradead.org; Thu, 15 Jul 2010 03:07:58 +0000
Date: Thu, 15 Jul 2010 12:07:48 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Fix case where phys_addr_t != unsigned long when
	reading proc entries
Message-ID: <20100715030748.GA11508@verge.net.au>
References: <1279121556-8069-1-git-send-email-msm@freescale.com>
	<1279121958.13098.1.camel@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1279121958.13098.1.camel@localhost>
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

On Wed, Jul 14, 2010 at 10:39:18AM -0500, Matthew McClintock wrote:
> On Wed, 2010-07-14 at 10:32 -0500, Matthew McClintock wrote:
> > On some actitectures the physical memory can be 64 bits, therefore
> > the code that reads proc entries needs to take into account it could
> > read either a 32 bit or 64bit value for the physical addresses.
> > 
> 
> These patches did not get numbered, shall I resubmit with numbered
> patches?

The list below is sufficient, but could you cc the patches to
linuxppc-dev@lists.ozlabs.org?

> 0001-Fix-case-where-phys_addr_t-unsigned-long-when-rea.patch
> 0002-Update-uImage-to-support-crash-kernel-and-misc-fixes.patch
> 0003-Update-Elf-ppc-to-support-crash-kernel-and-misc-fixe.patch
> 0004-Add-support-for-ramdisk-on-ppc32-for-uImage-ppc-and.patch
> 0005-Add-support-for-reworking-flat-device-tree-support.patch

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

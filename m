Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]
	helo=VA3EHSOBE009.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OZ438-0000Eo-Gs
	for kexec@lists.infradead.org; Wed, 14 Jul 2010 15:39:11 +0000
Received: from mail142-va3 (localhost.localdomain [127.0.0.1])	by
	mail142-va3-R.bigfish.com (Postfix) with ESMTP id 13CE2A58540	for
	<kexec@lists.infradead.org>; Wed, 14 Jul 2010 15:39:05 +0000 (UTC)
Received: from VA3EHSMHS003.bigfish.com (unknown [10.7.14.246])	by
	mail142-va3.bigfish.com (Postfix) with ESMTP id 51DD5104005B	for
	<kexec@lists.infradead.org>; Wed, 14 Jul 2010 15:39:03 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o6EFd0hC014550	for <kexec@lists.infradead.org>;
	Wed, 14 Jul 2010 08:39:00 -0700 (MST)
Subject: Re: [PATCH] Fix case where phys_addr_t != unsigned long when
	reading proc entries
From: Matthew McClintock <msm@freescale.com>
In-Reply-To: <1279121556-8069-1-git-send-email-msm@freescale.com>
References: <1279121556-8069-1-git-send-email-msm@freescale.com>
Date: Wed, 14 Jul 2010 10:39:18 -0500
Message-ID: <1279121958.13098.1.camel@localhost>
MIME-Version: 1.0
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
To: kexec@lists.infradead.org

On Wed, 2010-07-14 at 10:32 -0500, Matthew McClintock wrote:
> On some actitectures the physical memory can be 64 bits, therefore
> the code that reads proc entries needs to take into account it could
> read either a 32 bit or 64bit value for the physical addresses.
> 

These patches did not get numbered, shall I resubmit with numbered
patches?

0001-Fix-case-where-phys_addr_t-unsigned-long-when-rea.patch
0002-Update-uImage-to-support-crash-kernel-and-misc-fixes.patch
0003-Update-Elf-ppc-to-support-crash-kernel-and-misc-fixe.patch
0004-Add-support-for-ramdisk-on-ppc32-for-uImage-ppc-and.patch
0005-Add-support-for-reworking-flat-device-tree-support.patch

-M



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

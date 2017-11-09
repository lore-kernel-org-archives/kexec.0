Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1eCbgP-0004vE-1N
 for kexec@lists.infradead.org; Thu, 09 Nov 2017 01:31:06 +0000
Received: from penelope.horms.nl (unknown [121.135.231.159])
 by kirsty.vergenet.net (Postfix) with ESMTPA id C8B1A25B76C
 for <kexec@lists.infradead.org>; Thu,  9 Nov 2017 12:30:43 +1100 (AEDT)
Date: Thu, 9 Nov 2017 10:30:26 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [ANNOUNCE] kexec-tools 2.0.16-rc1
Message-ID: <20171109013025.wp2g2wqs5fdddum6@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hi all,

I am happy to announce the release of kexec-tools 2.0.16-rc1.

This is an incremental feature pre-release.

So long as no serious problems arise I intend to release kexec-tools 2.0.16
in a weeks time. Testing of 2.0.16-rc1 would be greatly appreciated.

I do not have any outstanding changes for 2.0.16 at this time.
And I would like to only accept bug fixes at this time and take take
features patches once 2.0.16 has been released.

The pre-release can be downloaded from kernel.org:

	https://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.16-rc1.tar.xz
	https://kernel.org/pub/linux/utils/kernel/kexec/

I have also tagged it in git:

	https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Thanks to everyone who has contributed to kexec.


For reference the changes since v2.0.15 are:

b047ace53677 kexec-tools 2.0.16-rc1
e08d26b3b7f1 vmcore-dmesg: avoid allocating large memory chunk for log buf
9004e19ca2e7 ARM: read kernel size from zImage
34bf700f981a ARM: cleanup initrd and dtb handing
c06753313db7 kexec-tools: mips: Use proper page_offset for OCTEON CPUs.
77e769bd1d1f kexec-tools: mips: Merge adjacent memory ranges.
508c7d45e270 kexec-tools: mips: Try to include bss in kernel vmcore file.
552bfbfc00ee kexec-tools: mips: Don't set lowmem_limit to 2G for 64-bit systems.
69431282f075 kexec-tools: ppc64: fix leak while checking for coherent device memory
aec4d0f7a250 kexec-tools: ppc64: avoid adding coherent memory regions to crash memory ranges
21eb397a5fc9 kexec-tools: powerpc: fix command line overflow error
47478ea66d43 kexec-tools: ppc64: fix how RMA top is deduced
161dd0f4f8a8 kexec-tools 2.0.15.git

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

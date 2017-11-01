Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1e9o4l-0001Bt-AS
 for kexec@lists.infradead.org; Wed, 01 Nov 2017 08:08:41 +0000
Received: from penelope.horms.nl (unknown [217.111.208.18])
 by kirsty.vergenet.net (Postfix) with ESMTPA id CB45B25B76F
 for <kexec@lists.infradead.org>; Wed,  1 Nov 2017 19:08:11 +1100 (AEDT)
Date: Wed, 1 Nov 2017 09:08:09 +0100
From: Simon Horman <horms@verge.net.au>
Subject: [ANNOUNCE] kexec-tools v2.0.16 preparation
Message-ID: <20171101080809.qidfwrtzvbzavbqj@verge.net.au>
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

I am planning to release kexec-tools v2.0.16 in the next two weeks.

The normal cadence would have seen it released around the time of the v4.13
kernel. I apologise that once again things have slipped and the plan is no
to release around the time of the v4.14 kernel.

I would like to ask interested parties to send any patches they would like
included in v2.0.16 within one week so that I can make an rc release.

For reference the patches queued up since v2.0.15 are as follows:

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

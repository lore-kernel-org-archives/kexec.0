Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-by2nam01on0060.outbound.protection.outlook.com
 ([104.47.34.60] helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1e2kd5-0002wx-MS
 for kexec@lists.infradead.org; Thu, 12 Oct 2017 21:02:57 +0000
From: David Daney <david.daney@cavium.com>
Subject: [PATCH 0/4] kexec-tools: mips: Fixes for 64-bit and OCTEON
Date: Thu, 12 Oct 2017 14:02:24 -0700
Message-Id: <20171012210228.7353-1-david.daney@cavium.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>
Cc: linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>

Here are a few improvements to the kexec-tools needed to get usable
core dumps out of 64-bit kernels running on Cavium's OCTEON
processors.  Patch 3/4 is OCTEON specific, the rest are needed for
good results on MIPS64 in general.

David Daney (4):
  kexec-tools: mips: Merge adjacent memory ranges.
  kexec-tools: mips: Don't set lowmem_limit to 2G for 64-bit systems.
  kexec-tools: mips: Use proper page_offset for OCTEON CPUs.
  kexec-tools: mips: Try to include bss in kernel vmcore file.

 kexec/arch/mips/crashdump-mips.c | 36 +++++++++++++++++++++++++++++++++---
 kexec/arch/mips/crashdump-mips.h |  3 ++-
 kexec/arch/mips/kexec-mips.c     | 14 ++++++++++----
 3 files changed, 45 insertions(+), 8 deletions(-)

-- 
2.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

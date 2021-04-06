Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.xenproject.org ([104.130.215.37])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lTmR4-002o3L-8Y
 for kexec@lists.infradead.org; Tue, 06 Apr 2021 14:12:08 +0000
From: Hongyan Xia <hx242@xen.org>
Subject: [PATCH 0/2] Fix early boot OOM issues for some platforms
Date: Tue,  6 Apr 2021 15:11:51 +0100
Message-Id: <cover.1617716819.git.hongyxia@amazon.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au, raphning@amazon.com, jgrall@amazon.com, hx242@xen.org

From: Hongyan Xia <hongyxia@amazon.com>

We have observed a couple of cases where after a successful kexec, the
crash kernel loaded in the 2nd kernel will run out of memory and
crash. We narrowed down to two issues:

1. when preparing the memory map, kexec excludes the Interrupt Vector
   Table. However, the end address of IVT is incorrect.
2. The wrong end address of IVT is not 1KiB aligned. When preparing the
   crashkernel, the memory map will reject unaligned memory chunks. On
   many x86 platforms this means the entire bottom 1MiB range is
   excluded from the crashkernel memory map, resulting in OOM when the
   crashkernel boots.

Patch 1 fixes 1 which is actually enough to eliminate the issue but we
feel that such issue may happen again (e.g., with a weird BIOS that has
unaligned e820 map), so we also have patch 2 to improve the handling of
unaligned memory.

Hongyan Xia (2):
  Fix where the real mode interrupt vector ends
  Shrink segments to fit alignment instead of throwing them away

 kexec/arch/i386/crashdump-x86.c    | 15 ++++++++++++---
 kexec/arch/i386/kexec-x86-common.c | 10 ++++++++--
 2 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.23.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

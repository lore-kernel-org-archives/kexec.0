Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1coSP1-0007kH-Dm
 for kexec@lists.infradead.org; Thu, 16 Mar 2017 10:13:05 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH] crashdump: Remove stray get_crashkernel_region() declaration
Date: Thu, 16 Mar 2017 11:12:24 +0100
Message-Id: <1489659144-14545-1-git-send-email-daniel.kiper@oracle.com>
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
Cc: horms@verge.net.au

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 kexec/crashdump.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/kexec/crashdump.h b/kexec/crashdump.h
index 96219a8..86e1ef2 100644
--- a/kexec/crashdump.h
+++ b/kexec/crashdump.h
@@ -1,7 +1,6 @@
 #ifndef CRASHDUMP_H
 #define CRASHDUMP_H
 
-int get_crashkernel_region(uint64_t *start, uint64_t *end);
 extern int get_crash_notes_per_cpu(int cpu, uint64_t *addr, uint64_t *len);
 extern int get_kernel_vmcoreinfo(uint64_t *addr, uint64_t *len);
 extern int get_xen_vmcoreinfo(uint64_t *addr, uint64_t *len);
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

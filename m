Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cr0iR-0006rs-Cn
 for kexec@lists.infradead.org; Thu, 23 Mar 2017 11:15:40 +0000
From: Xunlei Pang <xlpang@redhat.com>
Subject: [PATCH] x86: Support large number of memory ranges
Date: Thu, 23 Mar 2017 19:16:59 +0800
Message-Id: <1490267819-13606-1-git-send-email-xlpang@redhat.com>
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
Cc: Xunlei Pang <xlpang@redhat.com>, Dave Young <dyoung@redhat.com>, Frank Ramsay <frank.ramsay@hpe.com>

We got a problem on one SGI 64TB machine, the current kexec-tools
failed to work due to the insufficient ranges(MAX_MEMORY_RANGES)
allowed which is defined as 1024(less than the ranges on the machine).
The kcore header is insufficient due to the same reason as well.

To solve this, this patch simply doubles "MAX_MEMORY_RANGES" and
"KCORE_ELF_HEADERS_SIZE".

Cc: Frank Ramsay <frank.ramsay@hpe.com>
Signed-off-by: Xunlei Pang <xlpang@redhat.com>
---
 kexec/arch/i386/kexec-x86.h | 2 +-
 kexec/crashdump.h           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/i386/kexec-x86.h b/kexec/arch/i386/kexec-x86.h
index 33df352..51855f8 100644
--- a/kexec/arch/i386/kexec-x86.h
+++ b/kexec/arch/i386/kexec-x86.h
@@ -1,7 +1,7 @@
 #ifndef KEXEC_X86_H
 #define KEXEC_X86_H
 
-#define MAX_MEMORY_RANGES 1024
+#define MAX_MEMORY_RANGES 2048
 
 enum coretype {
 	CORE_TYPE_UNDEF = 0,
diff --git a/kexec/crashdump.h b/kexec/crashdump.h
index 86e1ef2..18bd691 100644
--- a/kexec/crashdump.h
+++ b/kexec/crashdump.h
@@ -7,8 +7,8 @@ extern int get_xen_vmcoreinfo(uint64_t *addr, uint64_t *len);
 
 /* Need to find a better way to determine per cpu notes section size. */
 #define MAX_NOTE_BYTES		1024
-/* Expecting ELF headers to fit in 32K. Increase it if you need more. */
-#define KCORE_ELF_HEADERS_SIZE  32768
+/* Expecting ELF headers to fit in 64K. Increase it if you need more. */
+#define KCORE_ELF_HEADERS_SIZE  65536
 /* The address of the ELF header is passed to the secondary kernel
  * using the kernel command line option memmap=nnn.
  * The smallest unit the kernel accepts is in kilobytes,
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

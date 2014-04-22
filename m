Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WcQtp-0001XY-B2
 for kexec@lists.infradead.org; Tue, 22 Apr 2014 02:57:33 +0000
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH v7 5/9] x86, cleanup: increase CRASH_MAX_MEMMAP_NR up to 1024
Date: Tue, 22 Apr 2014 10:56:43 +0800
Message-Id: <1398135407-30142-6-git-send-email-chaowang@redhat.com>
In-Reply-To: <1398135407-30142-1-git-send-email-chaowang@redhat.com>
References: <1398135407-30142-1-git-send-email-chaowang@redhat.com>
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
To: horms@verge.net.au, dyoung@redhat.com, linn@hp.com, vgoyal@redhat.com, hpa@zytor.com, trenn@suse.de
Cc: kexec@lists.infradead.org

CRASH_MAX_MEMMAP_NR is used as the upper boundary of memmap_p.
Originally memmap_p was used to store RANGE_RAM only. But now we changed
it to store all the types of memory ranges for 2nd kernel, which
includes RANGE_RAM, RANGE_ACPI, RANGE_ACPI_NVS (and RANGE_RESERVED in
the future).

Currently CRASH_MAX_MEMMAP_NR is defined (KEXEC_MAX_SEGMENTS + 2), which
is not enough for memmap_p. It must be increased to a much higher value.

I think 1024 is good enough for storing all memory ranges for 2nd
kernel. So this patch increases CRASH_MAX_MEMMAP_NR to 1024.

Signed-off-by: WANG Chao <chaowang@redhat.com>
Acked-by: Dave Young <dyoung@redhat.com>
Tested-by: Linn Crosetto <linn@hp.com>
---
 kexec/arch/i386/crashdump-x86.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/i386/crashdump-x86.h b/kexec/arch/i386/crashdump-x86.h
index b61cf0a..ddee19f 100644
--- a/kexec/arch/i386/crashdump-x86.h
+++ b/kexec/arch/i386/crashdump-x86.h
@@ -20,7 +20,7 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
 /* Kernel text size */
 #define X86_64_KERNEL_TEXT_SIZE  (512UL*1024*1024)
 
-#define CRASH_MAX_MEMMAP_NR	(KEXEC_MAX_SEGMENTS + 1)
+#define CRASH_MAX_MEMMAP_NR	1024
 #define CRASH_MAX_MEMORY_RANGES	(MAX_MEMORY_RANGES + 2)
 
 /* Backup Region, First 640K of System RAM. */
-- 
1.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

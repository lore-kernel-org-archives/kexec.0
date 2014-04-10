Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WYB3X-0007lR-WB
 for kexec@lists.infradead.org; Thu, 10 Apr 2014 09:14:00 +0000
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH v5 06/10] x86,
 cleanup: increase CRASH_MAX_MEMMAP_NR up to CRASH_MAX_MEMORY_RANGES
Date: Thu, 10 Apr 2014 17:12:59 +0800
Message-Id: <1397121186-9353-7-git-send-email-chaowang@redhat.com>
In-Reply-To: <1397121186-9353-1-git-send-email-chaowang@redhat.com>
References: <1397121186-9353-1-git-send-email-chaowang@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: horms@verge.net.au, vgoyal@redhat.com, ebiederm@xmission.com, hpa@zytor.com, trenn@suse.de, dyoung@redhat.com, linn@hp.com
Cc: kexec@lists.infradead.org

CRASH_MAX_MEMMAP_NR now is defined (KEXEC_MAX_SEGMENTS + 2) which is way
lower than the memmap we can pass to 2nd kernel.

Signed-off-by: WANG Chao <chaowang@redhat.com>
---
 kexec/arch/i386/crashdump-x86.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/i386/crashdump-x86.h b/kexec/arch/i386/crashdump-x86.h
index b61cf0a..0edeb27 100644
--- a/kexec/arch/i386/crashdump-x86.h
+++ b/kexec/arch/i386/crashdump-x86.h
@@ -20,8 +20,8 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
 /* Kernel text size */
 #define X86_64_KERNEL_TEXT_SIZE  (512UL*1024*1024)
 
-#define CRASH_MAX_MEMMAP_NR	(KEXEC_MAX_SEGMENTS + 1)
 #define CRASH_MAX_MEMORY_RANGES	(MAX_MEMORY_RANGES + 2)
+#define CRASH_MAX_MEMMAP_NR	CRASH_MAX_MEMORY_RANGES
 
 /* Backup Region, First 640K of System RAM. */
 #define BACKUP_SRC_START	0x00000000
-- 
1.8.5.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

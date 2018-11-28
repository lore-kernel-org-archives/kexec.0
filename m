Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from nwk-aaemail-lapp01.apple.com ([17.151.62.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gRoPg-0004EJ-Qh
 for kexec@lists.infradead.org; Wed, 28 Nov 2018 01:13:14 +0000
MIME-version: 1.0
Date: Tue, 27 Nov 2018 17:12:55 -0800
Subject: [PATCH] x86_64, Fix for kexec not finding kernel text area
From: Vishnu Rangayyan <vrangayyan@apple.com>
Message-id: <D993A918-B8D9-4BD5-AB6F-86CC5FCE4178@apple.com>
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
Cc: horms@verge.net.au

Saw this issue on x86 with kexec not loading the 4.14+ kdump kernel correctly using the old mechanism:
Can't find kernel text map area from kcore
Cannot load /boot/vmlinuz

Traced it and saw that the X86_64_KERNEL_TEXT_SIZE is larger in the kernel than in kexec.
Syncing upstream kernel change to arch/x86/include/asm/page_64_types.h in commit e8581e3 in git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

Signed-off-by: Vishnu Rangayyan <vrangayyan@apple.com>
---
 kexec/arch/i386/crashdump-x86.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/i386/crashdump-x86.h b/kexec/arch/i386/crashdump-x86.h
index ddee19f..e1e8043 100644
--- a/kexec/arch/i386/crashdump-x86.h
+++ b/kexec/arch/i386/crashdump-x86.h
@@ -18,7 +18,7 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
 #define X86_64_MAXMEM                  0x3fffffffffffUL
 
 /* Kernel text size */
-#define X86_64_KERNEL_TEXT_SIZE  (512UL*1024*1024)
+#define X86_64_KERNEL_TEXT_SIZE  (1024UL*1024*1024)
 
 #define CRASH_MAX_MEMMAP_NR    1024
 #define CRASH_MAX_MEMORY_RANGES        (MAX_MEMORY_RANGES + 2)
-- 
2.17.2



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

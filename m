Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hYEj1-00012n-Ns
 for kexec@lists.infradead.org; Tue, 04 Jun 2019 19:04:01 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: [PATCH] makedumpfile/arm64: fix get_kaslr_offset_arm64() to return
 kaslr_offset correctly
Date: Tue, 4 Jun 2019 19:00:15 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03577879@BPXM09GP.gisp.nec.co.jp>
Content-Language: en-US
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: Bhupesh Sharma <bhsharma@redhat.com>

Currently, the get_kaslr_offset_arm64() function has the following
condition to return info->kaslr_offset, but kernel text mapping is
placed in another range on arm64 by default, so it returns 0 for
kernel text addresses.

    if (vaddr >= __START_KERNEL_map &&
                    vaddr < __START_KERNEL_map + info->kaslr_offset)

Consequently, kernel text symbols in erase config are resolved wrongly
with KASLR enabled vmcore, and makedumpfile erases unintended data.

Since the return value of get_kaslr_offset_arm64() is used in
resolve_config_entry() only, and in that case, we must have a vmlinux,
so get the addresses of _text and _end from vmlinux and use them.

Signed-off-by: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
---
 arch/arm64.c   | 24 ++++++++++++++++++++++--
 makedumpfile.h |  1 -
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/arm64.c b/arch/arm64.c
index 5fcf59d..a61d96f 100644
--- a/arch/arm64.c
+++ b/arch/arm64.c
@@ -215,6 +215,8 @@ get_kaslr_offset_arm64(unsigned long vaddr)
 {
 	unsigned int i;
 	char buf[BUFSIZE_FGETS], *endp;
+	static unsigned long _text = NOT_FOUND_SYMBOL;
+	static unsigned long _end = NOT_FOUND_SYMBOL;
 
 	if (!info->kaslr_offset && info->file_vmcoreinfo) {
 		if (fseek(info->file_vmcoreinfo, 0, SEEK_SET) < 0) {
@@ -237,9 +239,27 @@ get_kaslr_offset_arm64(unsigned long vaddr)
 			}
 		}
 	}
+	if (!info->kaslr_offset)
+		return 0;
+
+	if (_text == NOT_FOUND_SYMBOL) {
+		/*
+		 * Currently, the return value of this function is used in
+		 * resolve_config_entry() only, and in that case, we must
+		 * have a vmlinux.
+		 */
+		if (info->name_vmlinux) {
+			_text = get_symbol_addr("_text");
+			_end = get_symbol_addr("_end");
+		}
+		DEBUG_MSG("_text: %lx, _end: %lx\n", _text, _end);
+		if (_text == NOT_FOUND_SYMBOL || _end == NOT_FOUND_SYMBOL) {
+			ERRMSG("Cannot determine _text and _end address\n");
+			return FALSE;
+		}
+	}
 
-	if (vaddr >= __START_KERNEL_map &&
-			vaddr < __START_KERNEL_map + info->kaslr_offset) {
+	if (_text <= vaddr && vaddr <= _end) {
 		DEBUG_MSG("info->kaslr_offset: %lx\n", info->kaslr_offset);
 		return info->kaslr_offset;
 	} else {
diff --git a/makedumpfile.h b/makedumpfile.h
index b1176b7..bd60acc 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -542,7 +542,6 @@ do { \
 #ifdef __aarch64__
 unsigned long get_kvbase_arm64(void);
 #define KVBASE			get_kvbase_arm64()
-#define __START_KERNEL_map	(0xffffffff80000000UL)
 
 #endif /* aarch64 */
 
-- 
2.18.1



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

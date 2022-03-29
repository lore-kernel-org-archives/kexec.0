From: Baoquan He <bhe@redhat.com>
Date: Tue, 29 Mar 2022 18:01:55 +0800
Subject: [PATCH] purgatory: do not enable vectorization automatically for
 purgatory compiling
Message-ID: <20220329100155.328474-1-bhe@redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Redhat CKI reported kdump kernel will hang a while very early after crash
triggered, then reset to firmware to reboot.

This failure can only be observed with kdump or kexec reboot via
kexec_load system call. With kexec_file_load interface, both kdump and
kexec reboot work very well. And further investigation shows that gcc
version 11 doesn't have this issue, while gcc version 12 does.

After checking the release notes of the latest gcc, Dave found out it's
because gcc 12 enables auto-vectorization for -O2 optimization level.
Please see below link for more information:

  https://www.phoronix.com/scan.php?page=news_item&px=GCC-12-Auto-Vec-O2

Adding -fno-tree-vectorize to Makefile of purgatory can fix the issue.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 purgatory/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/purgatory/Makefile b/purgatory/Makefile
index 49ce80a638b2..9e04a5b0ef93 100644
--- a/purgatory/Makefile
+++ b/purgatory/Makefile
@@ -49,7 +49,7 @@ $(PURGATORY): CFLAGS+=$(PURGATORY_EXTRA_CFLAGS) \
 		      $($(ARCH)_PURGATORY_EXTRA_CFLAGS) \
 		      -Os -fno-builtin -ffreestanding \
 		      -fno-zero-initialized-in-bss \
-		      -fno-PIC -fno-PIE -fno-stack-protector
+		      -fno-PIC -fno-PIE -fno-stack-protector -fno-tree-vectorize
 
 $(PURGATORY): CPPFLAGS=$($(ARCH)_PURGATORY_EXTRA_CFLAGS) \
 			-I$(srcdir)/purgatory/include \
-- 
2.34.1



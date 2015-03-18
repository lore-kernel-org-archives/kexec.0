Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <35b08b12a3b4cbb9ee03c97274a032289b208b8d.1426719370.git.geoff@infradead.org>
In-Reply-To: <cover.1426719370.git.geoff@infradead.org>
References: <cover.1426719370.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 1/4] purgatory: Add no-zero-initialized-in-bss flag
Date: Wed, 18 Mar 2015 23:04:03 +0000
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

It seems some toolchains will put zero-initialized variables like purgatory's
sha256_regions into the BSS section.  These symbols cannot be processed by
machine_apply_elf_rel() and lead to build errors.  To avoid this problem add
the compiler flag no-zero-initialized-in-bss to the purgatory CFLAGS.

Fixes build errors like these:

  Symbol: sha256_regions is in a bss section cannot set

Reported here:

  http://lists.infradead.org/pipermail/kexec/2014-November/013052.html

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 purgatory/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/purgatory/Makefile b/purgatory/Makefile
index 1945702..1c7d2c0 100644
--- a/purgatory/Makefile
+++ b/purgatory/Makefile
@@ -47,7 +47,8 @@ purgatory/sha256.o: $(srcdir)/util_lib/sha256.c
 $(PURGATORY): CC=$(TARGET_CC)
 $(PURGATORY): CFLAGS+=$(PURGATORY_EXTRA_CFLAGS) \
 		      $($(ARCH)_PURGATORY_EXTRA_CFLAGS) \
-		      -Os -fno-builtin -ffreestanding
+		      -Os -fno-builtin -ffreestanding \
+		      -fno-zero-initialized-in-bss
 
 $(PURGATORY): CPPFLAGS=$($(ARCH)_PURGATORY_EXTRA_CFLAGS) \
 			-I$(srcdir)/purgatory/include \
-- 
2.1.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

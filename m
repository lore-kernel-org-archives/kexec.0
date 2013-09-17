Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from jacques.telenet-ops.be ([195.130.132.50])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VLqnD-00076y-Rg
 for kexec@lists.infradead.org; Tue, 17 Sep 2013 08:37:57 +0000
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/4] kexec: Fix cris/superh comment mixups
Date: Tue, 17 Sep 2013 10:37:09 +0200
Message-Id: <1379407031-5466-2-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1379407031-5466-1-git-send-email-geert@linux-m68k.org>
References: <1379407031-5466-1-git-send-email-geert@linux-m68k.org>
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
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, kexec@lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 kexec/arch/cris/kexec-cris.c         |    4 ++--
 kexec/arch/sh/include/arch/options.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/cris/kexec-cris.c b/kexec/arch/cris/kexec-cris.c
index 38876f6..67fd156 100644
--- a/kexec/arch/cris/kexec-cris.c
+++ b/kexec/arch/cris/kexec-cris.c
@@ -83,7 +83,7 @@ unsigned long virt_to_phys(unsigned long addr)
 }
 
 /*
- * add_segment() should convert base to a physical address on superh,
+ * add_segment() should convert base to a physical address on cris,
  * while the default is just to work with base as is */
 void add_segment(struct kexec_info *info, const void *buf, size_t bufsz,
                  unsigned long base, size_t memsz)
@@ -92,7 +92,7 @@ void add_segment(struct kexec_info *info, const void *buf, size_t bufsz,
 }
 
 /*
- * add_buffer() should convert base to a physical address on superh,
+ * add_buffer() should convert base to a physical address on cris,
  * while the default is just to work with base as is */
 unsigned long add_buffer(struct kexec_info *info, const void *buf,
                          unsigned long bufsz, unsigned long memsz,
diff --git a/kexec/arch/sh/include/arch/options.h b/kexec/arch/sh/include/arch/options.h
index 571b271..f923eb4 100644
--- a/kexec/arch/sh/include/arch/options.h
+++ b/kexec/arch/sh/include/arch/options.h
@@ -15,7 +15,7 @@
         {"empty-zero",     1, 0, OPT_APPEND}, \
         {"howto",          1, 0, OPT_NBSD_HOWTO}, \
         {"miniroot",       1, 0, OPT_NBSD_MROOT},
-/* These options seem to be loader-specific rather than cris-specific, so
+/* These options seem to be loader-specific rather than superh-specific, so
  * ought to be moved to KEXEC_ALL_OPTIONS below and parsed in the relevant
  * loader, e.g. kexec-netbsd-sh.c
  */
-- 
1.7.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

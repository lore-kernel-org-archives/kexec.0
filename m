Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp1.irit.fr ([141.115.24.2])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mTodh-00FAFX-HC
 for kexec@lists.infradead.org; Fri, 24 Sep 2021 17:05:35 +0000
From: dinhngoc.tu@irit.fr
Subject: [PATCH] kexec-tools: multiboot2: Correct BASIC_MEMINFO memory units
Date: Fri, 24 Sep 2021 19:03:27 +0200
Message-Id: <20210924170327.6775-1-dinhngoc.tu@irit.fr>
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
Cc: Tu Dinh <dinhngoc.tu@irit.fr>

From: Tu Dinh <dinhngoc.tu@irit.fr>

mem_lower and mem_upper are measured in kilobytes.
---
 kexec/arch/i386/kexec-mb2-x86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/i386/kexec-mb2-x86.c b/kexec/arch/i386/kexec-mb2-x86.c
index 36fef20..0d2e93b 100644
--- a/kexec/arch/i386/kexec-mb2-x86.c
+++ b/kexec/arch/i386/kexec-mb2-x86.c
@@ -256,8 +256,8 @@ static uint64_t multiboot2_make_mbi(struct kexec_info *info, char *cmdline, int
 
 		tag->type = MULTIBOOT_TAG_TYPE_BASIC_MEMINFO;
 		tag->size = sizeof (struct multiboot_tag_basic_meminfo);
-		tag->mem_lower = mem_lower;
-		tag->mem_upper = mem_upper;
+		tag->mem_lower = mem_lower >> 10;
+		tag->mem_upper = mem_upper >> 10;
 		ptrorig += ALIGN_UP (tag->size, MULTIBOOT_TAG_ALIGN) / sizeof (*ptrorig);
 	}
 
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

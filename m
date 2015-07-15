Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZFRH6-0008Gf-KG
 for kexec@lists.infradead.org; Wed, 15 Jul 2015 18:19:21 +0000
Received: by wibud3 with SMTP id ud3so9739609wib.1
 for <kexec@lists.infradead.org>; Wed, 15 Jul 2015 11:18:57 -0700 (PDT)
From: Adrien Schildknecht <adrien+dev@schischi.me>
Subject: [PATCH] kexec, x86: add missing newlines
Date: Wed, 15 Jul 2015 20:18:24 +0200
Message-Id: <1436984304-13518-1-git-send-email-adrien+dev@schischi.me>
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
Cc: Adrien Schildknecht <adrien+dev@schischi.me>, horms@verge.net.eu

A newline was missing at the end of the ramdisk error_msg in both x86
and x86_64 files.

Signed-off-by: Adrien Schildknecht <adrien+dev@schischi.me>
---
 kexec/arch/i386/kexec-elf-x86.c      | 2 +-
 kexec/arch/x86_64/kexec-elf-x86_64.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/i386/kexec-elf-x86.c b/kexec/arch/i386/kexec-elf-x86.c
index de00dcb..70b8a2f 100644
--- a/kexec/arch/i386/kexec-elf-x86.c
+++ b/kexec/arch/i386/kexec-elf-x86.c
@@ -218,7 +218,7 @@ int elf_x86_load(int argc, char **argv, const char *buf, off_t len,
 		elf_rel_set_symbol(&info->rhdr, "entry32_regs", &regs, sizeof(regs));
 
 		if (ramdisk) {
-			error_msg = "Ramdisks not supported with generic elf arguments";
+			error_msg = "Ramdisks not supported with generic elf arguments\n";
 			goto out;
 		}
 	}
diff --git a/kexec/arch/x86_64/kexec-elf-x86_64.c b/kexec/arch/x86_64/kexec-elf-x86_64.c
index ae65692..a5f5d22 100644
--- a/kexec/arch/x86_64/kexec-elf-x86_64.c
+++ b/kexec/arch/x86_64/kexec-elf-x86_64.c
@@ -207,7 +207,7 @@ int elf_x86_64_load(int argc, char **argv, const char *buf, off_t len,
 		elf_rel_set_symbol(&info->rhdr, "entry64_regs", &regs, sizeof(regs));
 
 		if (ramdisk) {
-			error_msg = "Ramdisks not supported with generic elf arguments";
+			error_msg = "Ramdisks not supported with generic elf arguments\n";
 			goto out;
 		}
 	}
-- 
2.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

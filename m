Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.gentoo.org ([140.211.166.183])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YnPLc-0008Ub-SH
 for kexec@lists.infradead.org; Wed, 29 Apr 2015 10:36:09 +0000
From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] x86_64: fill out reloc list
Date: Wed, 29 Apr 2015 06:35:40 -0400
Message-Id: <1430303740-17823-1-git-send-email-vapier@gentoo.org>
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
Cc: Mike Frysinger <vapier@chromium.org>

From: Mike Frysinger <vapier@chromium.org>

This makes it easy to understand failures w/invalid relocs.

Signed-off-by: Mike Frysinger <vapier@chromium.org>
---
 kexec/arch/x86_64/kexec-elf-rel-x86_64.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kexec/arch/x86_64/kexec-elf-rel-x86_64.c b/kexec/arch/x86_64/kexec-elf-rel-x86_64.c
index 06db7f0..5a9854f 100644
--- a/kexec/arch/x86_64/kexec-elf-rel-x86_64.c
+++ b/kexec/arch/x86_64/kexec-elf-rel-x86_64.c
@@ -48,6 +48,21 @@ static const char *reloc_name(unsigned long r_type)
 	"R_X86_64_DTPOFF32",
 	"R_X86_64_GOTTPOFF",
 	"R_X86_64_TPOFF32",
+	"R_X86_64_PC64",
+	"R_X86_64_GOTOFF64",
+	"R_X86_64_GOTPC32",
+	"R_X86_64_GOT64",
+	"R_X86_64_GOTPCREL64",
+	"R_X86_64_GOTPC64",
+	"R_X86_64_GOTPLT64",
+	"R_X86_64_PLTOFF64",
+	"R_X86_64_SIZE32",
+	"R_X86_64_SIZE64",
+	"R_X86_64_GOTPC32_TLSDESC",
+	"R_X86_64_TLSDESC_CALL",
+	"R_X86_64_TLSDESC",
+	"R_X86_64_IRELATIVE",
+	"R_X86_64_RELATIVE64",
 	};
 	static char buf[100];
 	const char *name;
-- 
2.3.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

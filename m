Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x235.google.com ([2607:f8b0:400e:c03::235])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YLAIR-0003xP-QI
 for kexec@lists.infradead.org; Tue, 10 Feb 2015 12:52:08 +0000
Received: by mail-pa0-f53.google.com with SMTP id lf10so33577997pab.12
 for <kexec@lists.infradead.org>; Tue, 10 Feb 2015 04:51:46 -0800 (PST)
From: Yousong Zhou <yszhou4tech@gmail.com>
Subject: [PATCH 4/4] mips: fix warning about implicit type conversion.
Date: Tue, 10 Feb 2015 20:46:14 +0800
Message-Id: <1423572374-20841-4-git-send-email-yszhou4tech@gmail.com>
In-Reply-To: <1423572374-20841-1-git-send-email-yszhou4tech@gmail.com>
References: <1423572374-20841-1-git-send-email-yszhou4tech@gmail.com>
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
Cc: Yousong Zhou <yszhou4tech@gmail.com>, horms@verge.net.au

Fixes the following warning.

	kexec/arch/mips/kexec-elf-mips.c:161:16: warning: assignment makes integer from pointer without a cast [enabled by default]

Signed-off-by: Yousong Zhou <yszhou4tech@gmail.com>
---
 kexec/arch/mips/kexec-elf-mips.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/mips/kexec-elf-mips.c b/kexec/arch/mips/kexec-elf-mips.c
index a27d986..8a6419a 100644
--- a/kexec/arch/mips/kexec-elf-mips.c
+++ b/kexec/arch/mips/kexec-elf-mips.c
@@ -158,7 +158,7 @@ int elf_mips_load(int argc, char **argv, const char *buf, off_t len,
 	if (info->kexec_flags & KEXEC_ON_CRASH)
 		/* In case of crashdump segment[0] is kernel.
 		 * Put cmdline just after it. */
-		cmdline_addr = info->segment[0].mem +
+		cmdline_addr = (unsigned long)info->segment[0].mem +
 				info->segment[0].memsz;
 	else
 		cmdline_addr = 0;
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

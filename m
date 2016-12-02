Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailapp01.imgtec.com ([195.59.15.196])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cCkTa-0000vW-O9
 for kexec@lists.infradead.org; Fri, 02 Dec 2016 09:49:57 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
 by Forcepoint Email with ESMTPS id 001295BAAEF58
 for <kexec@lists.infradead.org>; Fri,  2 Dec 2016 09:49:26 +0000 (GMT)
From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Subject: [PATCH 1/6] mips: remove incorrect arch_usage string
Date: Fri, 2 Dec 2016 10:49:06 +0100
Message-ID: <1480672151-18503-2-git-send-email-marcin.nowakowski@imgtec.com>
In-Reply-To: <1480672151-18503-1-git-send-email-marcin.nowakowski@imgtec.com>
References: <1480672151-18503-1-git-send-email-marcin.nowakowski@imgtec.com>
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
To: kexec@lists.infradead.org

arch_usage shows '--elf32-core-headers' as an option, but this is not
implemented.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 kexec/arch/mips/kexec-mips.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kexec/arch/mips/kexec-mips.c b/kexec/arch/mips/kexec-mips.c
index fe0c945..ebc3d9a 100644
--- a/kexec/arch/mips/kexec-mips.c
+++ b/kexec/arch/mips/kexec-mips.c
@@ -74,10 +74,6 @@ int file_types = sizeof(file_type) / sizeof(file_type[0]);
 
 void arch_usage(void)
 {
-#ifdef __mips64
-	fprintf(stderr, "     --elf32-core-headers Prepare core headers in "
-			"ELF32 format\n");
-#endif
 }
 
 #ifdef __mips64
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

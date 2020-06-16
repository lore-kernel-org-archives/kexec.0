Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail1.windriver.com ([147.11.146.13])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jl2Lp-0000ab-LA
 for kexec@lists.infradead.org; Tue, 16 Jun 2020 03:33:30 +0000
From: Xulin Sun <xulin.sun@windriver.com>
Subject: [PATCH] arm64: continue loading even if kaslr-seed is not wiped to
 zero
Date: Tue, 16 Jun 2020 11:33:20 +0800
Message-ID: <20200616033320.2553-1-xulin.sun@windriver.com>
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
To: kexec@lists.infradead.org, horms@verge.net.au
Cc: xulin.sun@windriver.com, xulinsun@gmail.com

The commit c3f043241a866a (arm64: Add support to supply 'kaslr-seed' to secondary kernel)
add kaslr-seed support. And consider the primary kernel reads the 'kaslr-seed'
and wipes it to 0. But in the situation, 'CONFIG_RANDOMIZE_BASE' was not set to
y in the primary kernel and ATF firmware has set the 'kaslr-seed' dtb property
with non-zero, Thus will return error.

So in the above case, continue loading the segments with no kaslr
supported situation.

Signed-off-by: Xulin Sun <xulin.sun@windriver.com>
---
 kexec/arch/arm64/kexec-arm64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 2992bce..540f4d7 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -506,8 +506,7 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
 		if (kaslr_seed != 0) {
 			dbgprintf("%s: kaslr-seed is not wiped to 0.\n",
 					__func__);
-			result = -EINVAL;
-			goto on_error;
+			goto unable_kaslr;
 		}
 
 		/*
@@ -550,6 +549,7 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
 		}
 	}
 
+unable_kaslr:
 	if (on_crash) {
 		/* add linux,elfcorehdr */
 		nodeoffset = fdt_path_offset(new_buf, "/chosen");
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

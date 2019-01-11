Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghrQk-0003kE-4L
 for kexec@lists.infradead.org; Fri, 11 Jan 2019 07:40:39 +0000
Received: by mail-yw1-xc41.google.com with SMTP id h32so5471673ywk.2
 for <kexec@lists.infradead.org>; Thu, 10 Jan 2019 23:40:36 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH] arm64: kexec_file: return successfully even if kaslr-seed
 doesn't exist
Date: Fri, 11 Jan 2019 16:40:21 +0900
Message-Id: <20190111074021.23639-1-takahiro.akashi@linaro.org>
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
To: catalin.marinas@arm.com, will.deacon@arm.com
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

In kexec_file_load, kaslr-seed property of the current dtb will be deleted
any way before setting a new value if possible. It doesn't matter whether
it exists in the current dtb.

So "ret" should be reset to 0 here.

Fixes: commit 884143f60c89 ("arm64: kexec_file: add kaslr support")
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/machine_kexec_file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 10e33860e47a..f2c211a6229b 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -87,7 +87,9 @@ static int setup_dtb(struct kimage *image,
 
 	/* add kaslr-seed */
 	ret = fdt_delprop(dtb, off, FDT_PROP_KASLR_SEED);
-	if (ret && (ret != -FDT_ERR_NOTFOUND))
+	if  (ret == -FDT_ERR_NOTFOUND)
+		ret = 0;
+	else if (ret)
 		goto out;
 
 	if (rng_is_initialized()) {
-- 
2.19.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

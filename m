Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a5Fjl-0002ca-B2
 for kexec@lists.infradead.org; Sat, 05 Dec 2015 16:31:06 +0000
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH 2/4] arm64: Decide VA Bits on the basis of _stext symbol value
Date: Sat,  5 Dec 2015 22:00:01 +0530
Message-Id: <ffaf76d4b5454156a3edded62dcfbfe72bb7a96a.1449332470.git.panand@redhat.com>
In-Reply-To: <cover.1449332470.git.panand@redhat.com>
References: <cover.1449332470.git.panand@redhat.com>
In-Reply-To: <cover.1449332470.git.panand@redhat.com>
References: <cover.1449332470.git.panand@redhat.com>
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
To: ats-kumagai@wm.jp.nec.com
Cc: Pratyush Anand <panand@redhat.com>, timur@codeaurora.org, asamson@codeaurora.org, kexec@lists.infradead.org, rruigrok@codeaurora.org, sgoel@codeaurora.org, dyoung@redhat.com

Currently we assume that there are only two possible configuration
supported by kernel.
1) Page Table Level:2, Page Size 64K and VA Bits 42
1) Page Table Level:3, Page Size 4K and VA Bits 39
Ideally, we should have some mechanism to decide these from kernel
symbols, but we have limited symbols in vmcore,  and we can not do much.
So until some one comes with a better way, we use _stext symbol value
for VA bits determination.
We also assume that when VA Bits are 39, Page table level will be 3 and
Page size will be 4K, while when VA Bits are 42, Page table level will
be 2 an Page size will be 64K.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/arch/arm64.c b/arch/arm64.c
index 643c21f8feb1..4d50012529c3 100644
--- a/arch/arm64.c
+++ b/arch/arm64.c
@@ -115,16 +115,36 @@ get_page_shift_arm64(void)
 	return page_shift;
 }
 
+#define PAGE_OFFSET_39 (0xffffffffffffffffUL << 39)
+#define PAGE_OFFSET_42 (0xffffffffffffffffUL << 42)
 static int calculate_plat_config(void)
 {
-	/*
-	 * TODO: Keep it fixed for page level 2, size 64K and VA bits as
-	 * 42, as of now. Will calculate them from symbol address values
-	 * latter.
+	unsigned long long stext;
+
+	/* Currently we assume that there are only two possible
+	 * configuration supported by kernel.
+	 * 1) Page Table Level:2, Page Size 64K and VA Bits 42
+	 * 1) Page Table Level:3, Page Size 4K and VA Bits 39
+	 * Ideally, we should have some mechanism to decide these values
+	 * from kernel symbols, but we have limited symbols in vmcore,
+	 * and we can not do much. So until some one comes with a better
+	 * way, we use following.
 	 */
-	pgtable_level = 2;
-	va_bits = 42;
-	page_shift = 16;
+	stext = SYMBOL(_stext);
+
+	/* condition for minimum VA bits must be checked first and so on */
+	if ((stext & PAGE_OFFSET_39) == PAGE_OFFSET_39) {
+		pgtable_level = 3;
+		va_bits = 39;
+		page_shift = 12;
+	} else if ((stext & PAGE_OFFSET_42) == PAGE_OFFSET_42) {
+		pgtable_level = 2;
+		va_bits = 42;
+		page_shift = 16;
+	} else {
+		ERRMSG("Kernel Configuration not supported\n");
+		return FALSE;
+	}
 
 	return TRUE;
 }
-- 
2.5.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

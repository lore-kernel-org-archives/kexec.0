Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA86CCF9F8
	for <kexec@archiver.kernel.org>; Thu, 30 Oct 2025 07:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6v0GgTsDPbg5Ft7pBqWr5VriOn8lCrOnSTV90S12ALE=; b=J93HQHeCThyyGpwJjE0LAVLSwL
	AOuBpcIhWLdSWKT08gy8z9OoCETjNVWMsCvU6sF3x3FypZvFc+rYlcW+hjthPUl6++jaXvJ4+RQ3c
	ncgaN/8GMLroDQVv4hAtIZ2hCIne2exDT1T/t7qrAsoYT/M0zhOjYpGbTEhFcCPOYQEkMsxhkw5OA
	2EoExyR5/MAl3YqulbGGxGc12CAWsHPwekD0U6tyFe3uROMA+NFyEMwbyezp0z3bkwNwCKHh8WX3R
	j3OgPo1MVz0NeBNfCYr7bcXWXT3WoiKzRa8Ai21SZYHdxJXBTbLdTfk1+ME+id6L2Gpa/K+KEmLGZ
	XXttaUCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vENAo-00000003dNb-0DQ4;
	Thu, 30 Oct 2025 07:34:18 +0000
Received: from smtpbgbr2.qq.com ([54.207.22.56])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vENAk-00000003dMK-0fLV
	for kexec@lists.infradead.org;
	Thu, 30 Oct 2025 07:34:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1761809623;
	bh=6v0GgTsDPbg5Ft7pBqWr5VriOn8lCrOnSTV90S12ALE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=gEbq6GJIIyCRbHytIg/VuSBsozT8JzF5+asdRFsFqtys1EHcMI61fB0jGv5ORm0kX
	 TiiaMmGR6YjaWFu9aH6lW+BM33Wnp+6gblI+Zf5pWeGQ8NkAStZprWTZsxG899DyWE
	 M/Kx/JUi72vaS72zzMr1qzOtX6GGuc55Y3NMYcx0=
X-QQ-mid: zesmtpgz3t1761809619ta354b536
X-QQ-Originating-IP: cFJ8/T5GrKLGulu8zN6eCVBh57gQEM563HyVYtPi2ws=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Oct 2025 15:33:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11120989038432586530
EX-QQ-RecipientCnt: 5
From: Qiang Ma <maqianga@uniontech.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH] kexec: print out debugging message if required for kexec_load
Date: Thu, 30 Oct 2025 15:33:16 +0800
Message-Id: <20251030073316.529106-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: OJDnEMHxZvCkKHl8gRBALqstZaSEEHDFbfGEWdtffhbvv/PzWfkHcZLe
	TKRoliBbZAoaEfccPD9qpHvbryBFSL7qENRbRUC0kT23ADrloZfLmw/tDw+H2Y/Ctspoy/F
	LYX13UTGSz+QbCc1+VFlPnAWhLhyZvxOw/axZ5LYulO+rEQwYPEcE9m+YDTq/daf+pfRCDX
	MTFzTyDZF7XMfbUmIKtl+FAJ9JgYP5hkZymwUiLPyfRYt75pGLhZ7FgqJIvf3rvEhyGxshj
	dFdbrtjgxP0r0X0x0GlbxL65CAFbbmJaGc6OrruyR7eM7Tzk1K0tevIuYGElsmB3Wq2VqdW
	2RR3DGC/eGcel3Hqocpsptmxu54Pp4R4kHnLU8jyBSjFfNw1aUluwdkjaS1HfhAZbM4i67v
	1KD36t34zs3hx4LcO+V6EWiaWMeWOnZWAPnBGiYRaErEoTHoCMUxQJCQGwa0DP5SB8hAwSb
	g9tonfPFijhJxQSg507nmfn3KHRdCDao1cPH+ZAaO438q1h3xmn/+rx+6u1WABlmIgf1Saa
	56CoML+PRpMauGrmJWNMxGQLAIW7AMBQOAWR2+2E+y2RZ95S1olMB6Lb+7/xebyJZeK/aog
	GjPA+KrtdOx3vg0M31YTFbx5rQnZ+6WzCXg4oHe+MUfq9X/7vn7OzNPxaxFc90Iaqsj3RHq
	d1bKn939SHr7X92NNLcDZI43V5sNUPDsq6oq3ZEZji77iarXHLj9YzuR7KX3JLldRBKGNom
	2vL9jnH5ohCMeLS5Wb1MWg5DrlGkN9E/CqkwvvdL5P9+yzKhMiJNjfOR/miO6do+SGWKxWs
	XHnLxzQWOvCMUeJWaHDpqZGPoQCnDQn1iID2cVkaPHljPNQb1slz7X4Cpgu3py9w9yfG19V
	UyeK4w78MdrG/669eTAQkF/cNTQwZ3Sipo3tmXP95w72gCf2JKpZaZ0F3rFfHkARY4k5bj/
	ccZw2WOeiXky95orUsvTehccealA1GsBUxvSURffYXNJjQVJBTx8JGuSmLt/iahRPVxwKYV
	bSPXRAH3mK+rc0R0eu
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251030_003415_327008_1669E486 
X-CRM114-Status: GOOD (  13.38  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The commit a85ee18c7900 ("kexec_file: print out debugging message
if required") has added general code printing in kexec_file_load(),
but not in kexec_load().

Especially in the RISC-V architecture, kexec_image_info() has been
removed(commit eb7622d908a0 ("kexec_file, riscv: print out debugging
message if required")). As a result, when using '-d' for the kexec_load
interface, print nothing in the kernel space. This might be helpful for
verifying the accuracy of the data passed to the kernel. Therefore, refer to
this commit a85ee18c7900 ("kexec_file: print out debugging message
if required"), debug print information has been added.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 kernel/kexec.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 28008e3d462e..02845a7499e9 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -151,7 +151,15 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	if (ret)
 		goto out;
 
+	kexec_dprintk("nr_segments = %lu\n", image->nr_segments);
 	for (i = 0; i < nr_segments; i++) {
+		struct kexec_segment *ksegment;
+
+		ksegment = &image->segment[i];
+		kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
+			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
+			      ksegment->memsz);
+
 		ret = kimage_load_segment(image, i);
 		if (ret)
 			goto out;
@@ -163,6 +171,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	if (ret)
 		goto out;
 
+	kexec_dprintk("kexec_file_load: type:%u, start:0x%lx head:0x%lx flags:0x%lx\n",
+		      image->type, image->start, image->head, flags);
+
 	/* Install the new kernel and uninstall the old */
 	image = xchg(dest_image, image);
 
-- 
2.20.1



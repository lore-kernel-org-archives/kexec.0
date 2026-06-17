Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03723CD98E2
	for <kexec@archiver.kernel.org>; Wed, 17 Jun 2026 13:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/0WbWUM0YqRig6pLzRsihGyxNEeNAVR9TczamDwMF/4=; b=gAnmUDW9ULiTStejYs361thzSf
	ikDv7N2z8FBlF5UGyfMdJAw9bD7PK6QLS7u62T9g2clLAW91eEgDHDYLrz0mrfpUIblux7eNJ40MX
	ZdyZpBpJx5rOtVg1xjjc1YGGRxVGfDdmhBiWDHMoAiu7/mzM0xPKDp4E4n+evx+C8+xwv1UJp7uEL
	eE53psbPnJOkqnMIFCVVkz4JorMrwQpCoEmKsFhd3ZH6QnjTC2Rj6aPAJzIYDXJtFBQdDsxkZtu15
	erSc1egaHeRd0s3Ls3yhHztFYVkexMXOctIbb83GJ7DbRkn5j+AzbhfoP/PFvZxKDfNuvxKMiCvyH
	bC7tDR2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZqPI-0000000HQ6N-3xVm;
	Wed, 17 Jun 2026 13:34:16 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZqPH-0000000HQ4E-0EMc
	for kexec@lists.infradead.org;
	Wed, 17 Jun 2026 13:34:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=/0WbWUM0YqRig6pLzRsihGyxNEeNAVR9TczamDwMF/4=; b=N5eefuhLpBajkaaJT+OSbqc0iY
	FGiQA+H2djSY6ZSYwleP88Pnp/zWXFUqA9uPPlN8bFYoIOgy7T+yP8kP5usWgViz2P9NBQpheOMHz
	5fq2j0wPRSyqq3eWw8lduMrADGY64KocjwBIdVOM1QGxzHkdoeQITkdY+4SvmO5yUpC4F9zhgDAW1
	HHvsFOks2nkksVP2qyZZQgw6ODo8ayLTjwfm7ZzKdQqrVkUW1JvajqDMO89g5jvIdkN1+FpuCJ0yT
	b1FR3SEFZISFKb3tu4z7XxfFJ2X3RqbVdtKnGJ+CfuaqWTK3sR89rg1c2x8U4NZMsMzQWwe0+b330
	TW3pZDTg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wZqOf-00EeVC-0g;
	Wed, 17 Jun 2026 13:33:37 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 17 Jun 2026 06:32:47 -0700
Subject: [PATCH 1/2] ACPI: APEI: GHES: fix severity namespace in
 ghes_log_hwerr()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-hwerr-v1-1-ff131cd6203c@debian.org>
References: <20260617-hwerr-v1-0-ff131cd6203c@debian.org>
In-Reply-To: <20260617-hwerr-v1-0-ff131cd6203c@debian.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
 Hanjun Guo <guohanjun@huawei.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 riel@surriel.com, caggio@meta.com, kexec@lists.infradead.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116; i=leitao@debian.org;
 h=from:subject:message-id; bh=IMYiUdETKsd9vslxX1nGBukt/xidhhV6uxKeG22G+Dg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqMqIkNxoJNOROjiYczzba3ljNP3lHQN4V+VJtB
 2jP68tv2fWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCajKiJAAKCRA1o5Of/Hh3
 bebPD/0eyRiXYwI/eZz4VMGjbfYJbyIgQN4p41SffpyWjB2Uy9Uug7GKQyxzLWDaoERwM2IqYCz
 IbOnZ8ELzd32K0SFa+0D8MJt9h310hHlI3xn2ZftujlO9/z2AO6Akj5WQeZ9h0c7wrk0k1XCkfX
 ESjJUwpTzSSiiJlC3HbEf8wE+hu3qPN1IxtN4neHzj2axlajMq5518d56OoDruWAkV1G0Z5OUPK
 bbhy05BQevI+/Ob9pdZxcu4cvcrJl1GeSVfVorF7nzKRSVDP16/BSaK+3Dh0OrZTYIr2AufGM2j
 XdyoWwJA9CLkX70o50v9C21cXGzK/o3hrcSTfALh50MOcefeUM2/uPHFZtPCZBlPuWVXa1vmC2Y
 zAM/1NdYWwwsBCT8+nwe0vG/2Yms3lbF0yc6JQA9xgPL4iA+1tfeUZC82UuvR7EhV271dcEorx6
 GZDoT5F9dLPv3vf1/gFJ45wIbp0dcT7sP1Bgb4Mqc0sZaddjeukuEOrFcNXlreSj1buOYg3v/6E
 CKevbY7m90llzDduAa0yUeF2Aa5EP9QA1ZsG5NX/gmoEfeCLovyfLNyOitIjGKkTk2pz5KrCZ/Z
 YKS+gV0f+kI/sJas1cDCGsSOJuxHq6EAIBumbcw3K2rW7L8ZL7NlscjL1XoZCykATpxN2W2AjV7
 hXCI+yJlyoA4xow==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260617_063415_107714_AC3E3839 
X-CRM114-Status: GOOD (  10.01  )
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

ghes_log_hwerr() receives a GHES_SEV_* value from ghes_severity() but
tests it against CPER_SEV_RECOVERABLE.  GHES_SEV_RECOVERABLE is 2 while
CPER_SEV_RECOVERABLE is 0, so every recoverable error is dropped and
only GHES_SEV_NO slips through; nothing useful is recorded through the
APEI/GHES path, which is the only one arm64 has.

Compare against GHES_SEV_RECOVERABLE so recoverable hardware errors are
tracked as intended.

Fixes: 918e1507cff9 ("vmcoreinfo: track and log recoverable hardware errors")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/acpi/apei/ghes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3236a3ce79d6b..f0f9f1529e7aa 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -877,7 +877,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_cper_kfifo_get, "CXL");
 
 static void ghes_log_hwerr(int sev, guid_t *sec_type)
 {
-	if (sev != CPER_SEV_RECOVERABLE)
+	if (sev != GHES_SEV_RECOVERABLE)
 		return;
 
 	if (guid_equal(sec_type, &CPER_SEC_PROC_ARM) ||

-- 
2.53.0-Meta



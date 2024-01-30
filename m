Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57299C47DDF
	for <kexec@archiver.kernel.org>; Tue, 30 Jan 2024 10:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=JXgsFyri7osqHEdeYPZx2BtFw0oiR6GZ6Iw6rQD7f38=; b=UoFfwLwkwyTegW
	HFpRsrLvQYu5YkfYjvugkuHCUuMQAolNeVit6g0GcIsrDoexTBcAslTsCCQ0ZMbIeSGzeV/fNsWmM
	bQ4RwI9sPLfUlSPsqJzcacwKTYJgnmj86UPss1O3P1JuAXK8uX5GSKQC5MmlXReeSxFbfK/fqj9dU
	t/Miq9s6SjVXRvEMBoYzbXvlYjKiV3O11rnhOinMYAVwFdrqcKfp8bodWmnyG2wBWtKW8jCT5Oryi
	kEZ9DxQbrjgSIpNXVFWh0xukKqh+cmiR5JDypQCfva/1QZyERUrwqL0Ma2nM9OLKuhSnSuuIjlAM6
	ARzF9k3J10A/FmVcgOzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUlCM-0000000G9EK-3FIt;
	Tue, 30 Jan 2024 10:18:34 +0000
Received: from m16.mail.163.com ([220.197.31.4])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUlCJ-0000000G9DK-2K30
	for kexec@lists.infradead.org;
	Tue, 30 Jan 2024 10:18:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=e2FiQ
	hU+RTDN+Ko8jTvok8WomqOu6UE1H2nRRf9t1x4=; b=KeMGWHIh8XxfVLcfvhOtc
	dOT6iWXTPXY23QTiiYUHoMVuxl9IslvBFGHrG1y92xB1WbzkThSRe4CBI0BzWo0a
	yip+SLLv21ScuCn5WfpmqNg1zAwYzmxK1TDaf7s/rpMVIfy9EspYkkrvpaD1ejxh
	3BniyVxneyJVa+VNXHErlk=
Received: from yangzhang2020.localdomain (unknown [60.24.209.222])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wDXL2jmzLhlyCwHBg--.29538S2;
	Tue, 30 Jan 2024 18:18:20 +0800 (CST)
From: "yang.zhang" <gaoshanliukou@163.com>
To: ebiederm@xmission.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"yang.zhang" <yang.zhang@hexintek.com>
Subject: [PATCH] kexec: should use uchunk for user buffer increasing
Date: Tue, 30 Jan 2024 18:18:02 +0800
Message-Id: <20240130101802.23850-1-gaoshanliukou@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CM-TRANSID: _____wDXL2jmzLhlyCwHBg--.29538S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw18ZFWrWr1DGr4xGFy3urg_yoWDtFb_Jw
	1Iyw4DWr4UZw43Jw4DZrWIgry2yw4Uur4S9r1I9FW7Ar9Yyrs0grZ3trnagr4fGrZ3W3yx
	tF97J3WSvr1jqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnVbyJUUUUU==
X-Originating-IP: [60.24.209.222]
X-CM-SenderInfo: pjdr2x5dqox3xnrxqiywtou0bp/1tbiRAF18mVOBPed+QABs-
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_021832_058964_DA0745EC 
X-CRM114-Status: UNSURE (   9.07  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: "yang.zhang" <yang.zhang@hexintek.com>

Because of alignment requirement in kexec-tools, there is
no problem for user buffer increasing when loading segments.
But when coping, the step is uchunk, so we should use uchunk
not mchunk.

Signed-off-by: yang.zhang <yang.zhang@hexintek.com>
---
 kernel/kexec_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index d08fc7b5db97..2b8354313c85 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -813,9 +813,9 @@ static int kimage_load_normal_segment(struct kimage *image,
 		ubytes -= uchunk;
 		maddr  += mchunk;
 		if (image->file_mode)
-			kbuf += mchunk;
+			kbuf += uchunk;
 		else
-			buf += mchunk;
+			buf += uchunk;
 		mbytes -= mchunk;
 
 		cond_resched();
@@ -881,9 +881,9 @@ static int kimage_load_crash_segment(struct kimage *image,
 		ubytes -= uchunk;
 		maddr  += mchunk;
 		if (image->file_mode)
-			kbuf += mchunk;
+			kbuf += uchunk;
 		else
-			buf += mchunk;
+			buf += uchunk;
 		mbytes -= mchunk;
 
 		cond_resched();
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

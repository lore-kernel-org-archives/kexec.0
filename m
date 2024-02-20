Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12593C48BC3
	for <kexec@archiver.kernel.org>; Tue, 20 Feb 2024 02:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=EcYb1RFEKi4HMMzaxlt33uCMZqc83mmFhCjSEo/EFP8=; b=e7gmDrv/TbE7Xp
	vmN6srPuea4hYZ8gpZ7LAIBysAaovtEVxa14ibvEvwvUI/WyYjo/9YaXtMej8E8ZA/GaRrwM+C/ET
	rjXarwwhU0kw7SDgC3TMjZ1ddsuPL5rtgU8kJKzPV4ISL5PtRrRmp+TeLRvsqmIw49FjJEMty5K3Z
	vwPwbDML2ihG3HmC5YZoOZzIG3ttCn43YsoXywjWXImz2i4RWd3+OjEI2lCwOgq9PKK1ccRMRpsAJ
	nvSpxcJQMMxnXANftzkPGpHVRPN7cF6qYPPLqyjxNnJEWqmeA4fRVXPrgTnbJ/OkoPe8C6VWCgWUv
	UgDTJJQ78G3oGfYs/MzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcFbs-0000000CpYu-2FgR;
	Tue, 20 Feb 2024 02:11:52 +0000
Received: from m16.mail.163.com ([220.197.31.3])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcFbn-0000000CpY2-3BdQ
	for kexec@lists.infradead.org;
	Tue, 20 Feb 2024 02:11:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hfqV3
	prgl2YOJl/pulYljFe3VTVS7nYpmcsCfsx02Kg=; b=hk9ERh2Bu9lud3FFYD15Y
	2yRLx2UcqL6yNR6bKtcs0gIA9xbROdx4gadQeaTff2PwcpVPlDZnOMyDmA+1sLKg
	yVAeIasTI+9SRJJPk5D/qmqgJUFiiKmbMrLShH5Lazs16kHRYnJjNjGo+7ZONsKf
	Gk8RfZnEuFxNHV0eyxpw8Y=
Received: from yangzhang2020.localdomain (unknown [60.24.209.108])
	by gzga-smtp-mta-g1-2 (Coremail) with SMTP id _____wDn9_o7CtRlEnztDA--.4655S2;
	Tue, 20 Feb 2024 10:11:08 +0800 (CST)
From: "yang.zhang" <gaoshanliukou@163.com>
To: ebiederm@xmission.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bhe@redhat.com,
	akpm@linux-foundation.org,
	"yang.zhang" <yang.zhang@hexintek.com>
Subject: [PATCH v2] kexec: copy only happens before uchunk goes to zero
Date: Tue, 20 Feb 2024 10:11:06 +0800
Message-Id: <20240220021106.694-1-gaoshanliukou@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CM-TRANSID: _____wDn9_o7CtRlEnztDA--.4655S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur4xtr4UArykCw17GF1DAwb_yoW8KFWDp3
	9xGr10grWrJr9rXrn7tF98C3yfJ3s7GrWru3yUCF95KrnI93Wvq34F93Wj93yUKryFkrn5
	Jw4qkFyaga4UX37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jv1v3UUUUU=
X-Originating-IP: [60.24.209.108]
X-CM-SenderInfo: pjdr2x5dqox3xnrxqiywtou0bp/xtbBZRyK8mV4H46InwAAsa
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240219_181148_254725_D369C51E 
X-CRM114-Status: UNSURE (   8.87  )
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

When load segments, all of the copying and the rest
only happens before uchunk goes to zero.

Signed-off-by: yang.zhang <yang.zhang@hexintek.com>

---
v1 -> v2:
- Only copy before uchunk goes to zero

V1: https://lore.kernel.org/lkml/20240130101802.23850-1-gaoshanliukou@163.com/
---
 kernel/kexec_core.c | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index d08fc7b5db97..2fc3d0e3715a 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -800,22 +800,24 @@ static int kimage_load_normal_segment(struct kimage *image,
 				PAGE_SIZE - (maddr & ~PAGE_MASK));
 		uchunk = min(ubytes, mchunk);
 
-		/* For file based kexec, source pages are in kernel memory */
-		if (image->file_mode)
-			memcpy(ptr, kbuf, uchunk);
-		else
-			result = copy_from_user(ptr, buf, uchunk);
+		if (uchunk) {
+			/* For file based kexec, source pages are in kernel memory */
+			if (image->file_mode)
+				memcpy(ptr, kbuf, uchunk);
+			else
+				result = copy_from_user(ptr, buf, uchunk);
+			ubytes -= uchunk;
+			if (image->file_mode)
+				kbuf += uchunk;
+			else
+				buf += uchunk;
+		}
 		kunmap_local(ptr);
 		if (result) {
 			result = -EFAULT;
 			goto out;
 		}
-		ubytes -= uchunk;
 		maddr  += mchunk;
-		if (image->file_mode)
-			kbuf += mchunk;
-		else
-			buf += mchunk;
 		mbytes -= mchunk;
 
 		cond_resched();
@@ -866,11 +868,18 @@ static int kimage_load_crash_segment(struct kimage *image,
 			memset(ptr + uchunk, 0, mchunk - uchunk);
 		}
 
-		/* For file based kexec, source pages are in kernel memory */
-		if (image->file_mode)
-			memcpy(ptr, kbuf, uchunk);
-		else
-			result = copy_from_user(ptr, buf, uchunk);
+		if (uchunk) {
+			/* For file based kexec, source pages are in kernel memory */
+			if (image->file_mode)
+				memcpy(ptr, kbuf, uchunk);
+			else
+				result = copy_from_user(ptr, buf, uchunk);
+			ubytes -= uchunk;
+			if (image->file_mode)
+				kbuf += uchunk;
+			else
+				buf += uchunk;
+		}
 		kexec_flush_icache_page(page);
 		kunmap_local(ptr);
 		arch_kexec_pre_free_pages(page_address(page), 1);
@@ -878,12 +887,7 @@ static int kimage_load_crash_segment(struct kimage *image,
 			result = -EFAULT;
 			goto out;
 		}
-		ubytes -= uchunk;
 		maddr  += mchunk;
-		if (image->file_mode)
-			kbuf += mchunk;
-		else
-			buf += mchunk;
 		mbytes -= mchunk;
 
 		cond_resched();
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

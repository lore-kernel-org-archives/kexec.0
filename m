Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F2CC3ABAA
	for <kexec@archiver.kernel.org>; Fri,  2 May 2025 20:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yvSliSI2VZ4OzZP8MlHEp1O9A0cHnM6zmQWdWeMUSvc=; b=DORnoU5exGGnKUahSz00L1pqNa
	sWHKDWb7AK7I8B8rVdRktP4nyVg3jQyF3lg0aW6+XD4gStBxsOB478/K7qVj2SiZE1CjGd0f5YLBi
	dyga6GILKcSwFw/xjiIdkS4g3NYhQXdKIKto91Pkn64TZiNCnDFn3OXOTix9OskUooM0kWySdXVXD
	ollDlVsJjdYfSSTT6BBMCQ/mGFJjQqlKZxjpA+nM+rCbTD3F3VBxNuBiAszIt2KzQxCMXiuHQCdzp
	M+7P75uV65UHZ8ls9yRoIZ5luj/BY7HA/FGEUt8Piiv2xW0Nc8aPNi83lcKxQHWJPmaYVe/IWy2gs
	FqfK+xnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAwc5-00000002vik-0Wk2;
	Fri, 02 May 2025 20:04:01 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAwby-00000002vhm-3gzg
	for kexec@lists.infradead.org;
	Fri, 02 May 2025 20:03:59 +0000
Received: from DESKTOP-VOT081N.hsd1.ga.comcast.net (unknown [172.200.70.89])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4F9692111577;
	Fri,  2 May 2025 13:03:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4F9692111577
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746216227;
	bh=yvSliSI2VZ4OzZP8MlHEp1O9A0cHnM6zmQWdWeMUSvc=;
	h=From:To:Cc:Subject:Date:From;
	b=ojCOdjA6mzHKD+heQAekRu3faXQRlBVcJh5gN9NltIRxJHUDbRLOc9HdKzyBSI7pq
	 LBVB0N+4tuX4QfLUw9PkiZLk/h2p8out2g5olB+vvDJobPx4lp7dAVyDFVP0O1hj1w
	 M6URGqfwFA4JPKoK6409Ke+jHJLa8hAnPAs9zJik=
From: steven chen <chenste@linux.microsoft.com>
To: zohar@linux.ibm.com,
	stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com,
	roberto.sassu@huawei.com,
	eric.snowberg@oracle.com,
	ebiederm@xmission.com,
	paul@paul-moore.com,
	code@tyhicks.com,
	bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com,
	nramas@linux.microsoft.com,
	James.Bottomley@HansenPartnership.com,
	bhe@redhat.com
Subject: [PATCH] ima: Kdump kernel doesn't need IMA to do integrity measurement
Date: Fri,  2 May 2025 13:03:37 -0700
Message-ID: <20250502200337.6293-1-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250502_130354_948168_049A9866 
X-CRM114-Status: UNSURE (   9.54  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Steven Chen <chenste@linux.microsoft.com>

Kdump kernel doesn't need IMA to do integrity measurement.
Hence the measurement list in 1st kernel doesn't need to be copied to
kdump kenrel.

Here skip allocating buffer for measurement list copying if loading
kdump kernel. Then there won't be the later handling related to
ima_kexec_buffer.

Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
---
 security/integrity/ima/ima_kexec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 38cb2500f4c3..7362f68f2d8b 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -146,6 +146,9 @@ void ima_add_kexec_buffer(struct kimage *image)
 	void *kexec_buffer = NULL;
 	int ret;
 
+	if (image->type == KEXEC_TYPE_CRASH)
+		return;
+
 	/*
 	 * Reserve extra memory for measurements added during kexec.
 	 */
-- 
2.43.0



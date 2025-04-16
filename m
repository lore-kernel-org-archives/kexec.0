Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8269FC369C9
	for <kexec@archiver.kernel.org>; Wed, 16 Apr 2025 02:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6xgOBYzerQDrucaQC/lEMeygmGpDLxyAasYBprqw4mk=; b=K8i+NsEG46+9SvPbAC5T6i0eQq
	BB0d5D/fqC5SbfB/jOhW/+fZsz0z4zLWOSwnAZJ4b4WqElajQieDm44srUbpmuNqrlYgSSSjrugJ9
	e6XYWsek6GEFbOxsb/B3Ex8e+wox2lI8hZH8duSsxlujiusRT9G9JsTU50NL/ca0quy5cCOd+LHaN
	kBa3ZP3mt8fpfQIORkLk3j//Gn0eP9qcePEMcLCCmw5l9peaZZ1Ml9Ae/1WQU0G5Oo9wPFSJPrAVD
	a2tufuhkOMwpgTvSZoGlmvdqD6xBaeBT5I6gVUKstT/z3qR9107A1be5Yo/6s2yRkqg76RVika3H8
	kXdggazg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4sH3-00000007uM1-0vlM;
	Wed, 16 Apr 2025 02:13:13 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4sEz-00000007tqB-1jp7
	for kexec@lists.infradead.org;
	Wed, 16 Apr 2025 02:11:06 +0000
Received: from DESKTOP-VOT081N.hsd1.ga.comcast.net (unknown [172.200.70.13])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2C96E210C453;
	Tue, 15 Apr 2025 19:11:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2C96E210C453
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744769464;
	bh=6xgOBYzerQDrucaQC/lEMeygmGpDLxyAasYBprqw4mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ad7rB5dm89SYDtjRH6L1G+DqFNyHVb1FLhdlv6ucB5wqHx4QFCbB9APsfsVYnldtl
	 ofg3dunWmQLqeR92Gl3pA/MRaypR70q9CB9iauRaPHEedfEWUkTW0dWXNOEOi6MUGW
	 7rzFG2pCRMMFIju5/NnGPtfwfxUQfeSQpVR+FKHQ=
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
	bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com
Subject: [PATCH v12 7/9] ima: verify if the segment size has changed
Date: Tue, 15 Apr 2025 19:10:25 -0700
Message-ID: <20250416021028.1403-8-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250416021028.1403-1-chenste@linux.microsoft.com>
References: <20250416021028.1403-1-chenste@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_191105_477727_54DE6BE8 
X-CRM114-Status: UNSURE (   9.96  )
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

kexec 'load' may be called multiple times. Free and realloc the buffer
only if the segment_size is changed from the previous kexec 'load' call.

Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
Acked-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_kexec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 5c3b3e0b2186..ed867734ee70 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -33,6 +33,14 @@ static void ima_free_kexec_file_buf(struct seq_file *sf)
 
 static int ima_alloc_kexec_file_buf(size_t segment_size)
 {
+	/*
+	 * kexec 'load' may be called multiple times.
+	 * Free and realloc the buffer only if the segment_size is
+	 * changed from the previous kexec 'load' call.
+	 */
+	if (ima_kexec_file.buf && ima_kexec_file.size == segment_size)
+		goto out;
+
 	ima_free_kexec_file_buf(&ima_kexec_file);
 
 	/* segment size can't change between kexec load and execute */
@@ -41,6 +49,8 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
 		return -ENOMEM;
 
 	ima_kexec_file.size = segment_size;
+
+out:
 	ima_kexec_file.read_pos = 0;
 	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
 
-- 
2.43.0



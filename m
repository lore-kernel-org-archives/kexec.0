Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51557C369DC
	for <kexec@archiver.kernel.org>; Mon, 21 Apr 2025 22:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6xgOBYzerQDrucaQC/lEMeygmGpDLxyAasYBprqw4mk=; b=XLfn5eaYmzvvrXoYDIpN7xjW94
	wk1cdDssSwuI+KLs4GzwW3Na2n3GNDfOM2oWNCceGGQd/AzlD6UXgKd4ICH/aEOoxbx0XPVa3ugZM
	rveHq1d/RE+ZwWjRVq59L+1BsIk6d4DpuXoNu6d8EJFjUc5FaEzxU2uHgMa4yVcPhLopaEsXkzBpv
	ZCzK4tmAt2qmclmBqcbcub9FyoqFcFNHLsdyfdRVLFqgpd3Zfm2uLvynOsJE8jI2bVv9p0mk8VB2f
	Qc0RF8iBzdAVcl4QHG7sWGmpVh8tPEbjMSMAF+lytN+d/U/mdl1NfwA3Y9O5z0RaBJFbK9hrAaI8R
	xANnRJkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6zku-00000005Lni-08e7;
	Mon, 21 Apr 2025 22:36:48 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6zaG-00000005K9O-03nh
	for kexec@lists.infradead.org;
	Mon, 21 Apr 2025 22:25:49 +0000
Received: from DESKTOP-VOT081N.hsd1.ga.comcast.net (unknown [20.110.218.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4ECFE203B875;
	Mon, 21 Apr 2025 15:25:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4ECFE203B875
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745274347;
	bh=6xgOBYzerQDrucaQC/lEMeygmGpDLxyAasYBprqw4mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3nC6b3Hi7IbCLuLtwW+3lh+1WXvmj68ZrT/fw8ahWDKC88opIExvLYFzI8HSRUqK
	 de3Bt2rmlJzSzacdZccAIvEIYxt4EY55PwlwMtVjtd8yBdqKMoCM5F/YG9ndpYTMPh
	 mbOczUN4dfQ93Ql9HFhdQKSHJ83nRKYDMGOzp4PA=
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
Subject: [PATCH v13 7/9] ima: verify if the segment size has changed
Date: Mon, 21 Apr 2025 15:25:13 -0700
Message-ID: <20250421222516.9830-8-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250421222516.9830-1-chenste@linux.microsoft.com>
References: <20250421222516.9830-1-chenste@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250421_152548_075052_C6540300 
X-CRM114-Status: GOOD (  10.21  )
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



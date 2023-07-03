Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5120DC0015E
	for <kexec@archiver.kernel.org>; Mon,  3 Jul 2023 21:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=luCaPv29RmeXPS91j5XjxgJ7eVwhSjMVAFTVF+LpW4g=; b=aVSD5VYvz/JKny
	IpSjs5kouiyhoGTqbr/lE2lQ3QnbDt/XFSrInWrCmf8JjWmM6DadTpnwFrwMzBfvicN5b0xVhhN4x
	YD6lnskWtYo0tFWWsI8QURvPs+NDg2mPPMd/hMKkEoxcyM1vcv1TbKQTN4XjLdNAZJYHylIw82Sfk
	AHrJ1HHCTUAmmTCtmaC+/krb3/OCZg6v73e69dlqXLVGaAaFJ1itkgZe6sEzjDgY/au/lLp8mApjZ
	eVHMy65odc+emtM6J2OCMyvOklgZ8gLN1a/+2RNrlICDg0ZTxnCqP3ExhBpGYRkHEOzJ1S/F+43q5
	cZWxqEeGLFzm1Kaf0GdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGRXv-00BVvw-2o;
	Mon, 03 Jul 2023 21:57:23 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGRXs-00BVsR-05
	for kexec@lists.infradead.org;
	Mon, 03 Jul 2023 21:57:21 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id BB30520AECBD;
	Mon,  3 Jul 2023 14:57:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BB30520AECBD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1688421437;
	bh=eQiDdiGszFkOMDk1+HM/N9CWYJ7B5kMdxIp/HrxE+hU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HkEH6GqHefQ3IMcFxi9qEcIzWzVymw0R8WlJWcRaLzDQrMAjoC4b12i7FO/gs3Nzr
	 tza0yGt9YBhhvrbxELq/kXt4VgnxfcI8HX3H1pLpDPSoBRClFRIMtpfgOgv9Xywlh0
	 rTaUj84l6vax9yjdp1eGP5a8jYR2XwaWm7FworH8=
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
To: zohar@linux.ibm.com,
	noodles@fb.com,
	bauermann@kolabnow.com,
	kexec@lists.infradead.org,
	linux-integrity@vger.kernel.org
Cc: code@tyhicks.com,
	nramas@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH 01/10] ima: implement function to allocate buffer at kexec load
Date: Mon,  3 Jul 2023 14:57:00 -0700
Message-Id: <20230703215709.1195644-2-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_145720_102878_011D9E4D 
X-CRM114-Status: GOOD (  12.98  )
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

IMA does not provide a mechanism to allocate memory for IMA log storage
during kexec operation.  The function should handle the scenario where
the kexec load is called multiple times. 

Implement a function to allocate buffer of size kexec_segment_size at
kexec load.  If the buffer was already allocated, free that buffer and
reallocate.  Finally, initialize ima_khdr struct. 

The patch operates under the assumption that the segment size does not
change between kexec load and execute.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima_kexec.c | 47 ++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 419dc405c831..48a683874044 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -15,6 +15,53 @@
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
+struct seq_file ima_kexec_file;
+struct ima_kexec_hdr ima_khdr;
+static size_t kexec_segment_size;
+
+void ima_clear_kexec_file(void)
+{
+	vfree(ima_kexec_file.buf);
+	ima_kexec_file.buf = NULL;
+	ima_kexec_file.size = 0;
+	ima_kexec_file.read_pos = 0;
+	ima_kexec_file.count = 0;
+}
+
+static int ima_allocate_buf_at_kexec_load(void)
+{
+	if ((kexec_segment_size == 0) ||
+	    (kexec_segment_size == ULONG_MAX) ||
+	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
+		pr_err("%s: Invalid segment size for kexec: %zu\n",
+			__func__, kexec_segment_size);
+		return -EINVAL;
+	}
+
+	/* if kexec load was called before, clear the existing buffer
+	 *  before allocating a new one
+	 */
+	if (ima_kexec_file.buf)
+		ima_clear_kexec_file();
+
+	/* segment size can't change between kexec load and execute */
+	ima_kexec_file.buf = vmalloc(kexec_segment_size);
+	if (!ima_kexec_file.buf) {
+		pr_err("%s: No memory for ima kexec measurement buffer\n",
+			__func__);
+		return -ENOMEM;
+	}
+
+	ima_kexec_file.size = kexec_segment_size;
+	ima_kexec_file.read_pos = 0;
+	ima_kexec_file.count = sizeof(ima_khdr);	/* reserved space */
+
+	memset(&ima_khdr, 0, sizeof(ima_khdr));
+	ima_khdr.version = 1;
+
+	return 0;
+}
+
 static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 				     unsigned long segment_size)
 {
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

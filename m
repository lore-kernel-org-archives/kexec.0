Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A63C3601A
	for <kexec@archiver.kernel.org>; Wed,  2 Apr 2025 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c/RS/PAb2CclZX+321SCa66PSDIvCelNRFFOQ2o7wf8=; b=2u9Ptx6RRc2xkollP1xwKZTcGI
	D6IRxm9v91DSRHtbs54jDp1bVHWx5h5qlJSvZ7T8elEP0/ZUQCPKCWWcHw4PPvlB67p/rQIYoISNO
	itbPtLbLYm+05qvJh3BDTelZ/OeLmfwXnMv4AOhmmmbZHEK+ygUReieDKla0JmLBVVHS2+ViLC6+s
	47vgpX5UB1dGT+PTU3p2Tft6vWbsMq2qujni5JKx2RFa+3dl+r/3lQ5skqoiZ/xmSed9VumZRSl+B
	uRbpGdxXVvV2wFQJZ0aotH/R42SPGDmOcmugKja86rtxyH4pHjGCXrMVblgPVbXwDMyLy6Q5Gmm5G
	eXezOsMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzxZE-0000000691L-1VZ4;
	Wed, 02 Apr 2025 12:51:40 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzxVN-0000000687z-3fnM
	for kexec@lists.infradead.org;
	Wed, 02 Apr 2025 12:47:43 +0000
Received: from DESKTOP-VOT081N.hsd1.ga.comcast.net (unknown [20.114.144.49])
	by linux.microsoft.com (Postfix) with ESMTPSA id DC82A2041310;
	Wed,  2 Apr 2025 05:47:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DC82A2041310
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743598060;
	bh=c/RS/PAb2CclZX+321SCa66PSDIvCelNRFFOQ2o7wf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GBp977W2a8y50FQq8iP0ZPDfbqsoMIp55WRJGHcKH9M/umzkVgUBH/FizQPCXl3xf
	 j8etCR89uA+7HKmwJBubkR4vGp+xe1bqwKqmwiYvto8LwzQM0pNLF4e56xmn/LXxes
	 LcV0T0O0+B3gyXnLjvS2XgZJG3/oRu38Ii4RIY9Y=
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
Subject: [PATCH v11 2/9] ima: define and call ima_alloc_kexec_file_buf()
Date: Wed,  2 Apr 2025 05:47:15 -0700
Message-ID: <20250402124725.5601-3-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250402124725.5601-1-chenste@linux.microsoft.com>
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_054742_002966_4E85B280 
X-CRM114-Status: GOOD (  18.48  )
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

In the current implementation, the ima_dump_measurement_list() API is 
called during the kexec "load" phase, where a buffer is allocated and 
the measurement records are copied. Due to this, new events added after
kexec load but before kexec execute are not carried over to the new kernel
during kexec operation

To allow the buffer allocation and population to be separated into distinct
steps, make the function local seq_file "ima_kexec_file" to a file variable.

Carrying the IMA measurement list across kexec requires allocating a
buffer and copying the measurement records.  Separate allocating the
buffer and copying the measurement records into separate functions in
order to allocate the buffer at kexec 'load' and copy the measurements
at kexec 'execute'.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
---
 security/integrity/ima/ima_kexec.c | 46 +++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 650beb74346c..b12ac3619b8f 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -15,26 +15,46 @@
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
+static struct seq_file ima_kexec_file;
+
+static void ima_free_kexec_file_buf(struct seq_file *sf)
+{
+	vfree(sf->buf);
+	sf->buf = NULL;
+	sf->size = 0;
+	sf->read_pos = 0;
+	sf->count = 0;
+}
+
+static int ima_alloc_kexec_file_buf(size_t segment_size)
+{
+	ima_free_kexec_file_buf(&ima_kexec_file);
+
+	/* segment size can't change between kexec load and execute */
+	ima_kexec_file.buf = vmalloc(segment_size);
+	if (!ima_kexec_file.buf)
+		return -ENOMEM;
+
+	ima_kexec_file.size = segment_size;
+	ima_kexec_file.read_pos = 0;
+	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
+
+	return 0;
+}
+
 static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 				     unsigned long segment_size)
 {
-	struct seq_file ima_kexec_file;
 	struct ima_queue_entry *qe;
 	struct ima_kexec_hdr khdr;
 	int ret = 0;
 
 	/* segment size can't change between kexec load and execute */
-	ima_kexec_file.buf = vmalloc(segment_size);
 	if (!ima_kexec_file.buf) {
-		ret = -ENOMEM;
-		goto out;
+		pr_err("Kexec file buf not allocated\n");
+		return -EINVAL;
 	}
 
-	ima_kexec_file.file = NULL;
-	ima_kexec_file.size = segment_size;
-	ima_kexec_file.read_pos = 0;
-	ima_kexec_file.count = sizeof(khdr);	/* reserved space */
-
 	memset(&khdr, 0, sizeof(khdr));
 	khdr.version = 1;
 	/* This is an append-only list, no need to hold the RCU read lock */
@@ -71,8 +91,6 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 	*buffer_size = ima_kexec_file.count;
 	*buffer = ima_kexec_file.buf;
 out:
-	if (ret == -EINVAL)
-		vfree(ima_kexec_file.buf);
 	return ret;
 }
 
@@ -111,6 +129,12 @@ void ima_add_kexec_buffer(struct kimage *image)
 		return;
 	}
 
+	ret = ima_alloc_kexec_file_buf(kexec_segment_size);
+	if (ret < 0) {
+		pr_err("Not enough memory for the kexec measurement buffer.\n");
+		return;
+	}
+
 	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
 				  kexec_segment_size);
 	if (!kexec_buffer) {
-- 
2.25.1



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C71BC48285
	for <kexec@archiver.kernel.org>; Mon, 22 Jan 2024 18:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Trho7StKy+z8sujQP6Nsl+Lhgms0Ggpm2Ejyn8nBeWE=; b=FX7gWKZYEacMTz
	97ZGnK7jhLV9hYeBflupp+6DG70d2mso4AIMLIXeQTeXY8PYP2bqU/a9ecddBrngHwcuqgF/Y5kPj
	klnvxhfrXIUbaGEUrC+jCnpUJ2YUgT1aCoktIWdykEZ4Mqe81QRGicPyXeQ0Gyx/VKaGSLUoXE8I3
	cSNrGFCO6pcVMPwmA1wLtwRfsqtVPhsEZcGbfNrIBYdQPvetegThvnDovc975p9i6QlEywEzZIIhn
	/e08rqu0UA4HMxu9Sj3FHThghn4MzCwehz0Poz+IBqMC8h05CZs6b3mS26ld/fiyEZ+MDjv7ac+lu
	Bu8f1Ekvs7uQ6cECAF7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRzBk-00DYfA-0r;
	Mon, 22 Jan 2024 18:38:28 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRzBe-00DYbm-04
	for kexec@lists.infradead.org;
	Mon, 22 Jan 2024 18:38:24 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5ECEE20E2C2D;
	Mon, 22 Jan 2024 10:38:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5ECEE20E2C2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1705948697;
	bh=5BIJyIqOWqL1PpqhjQ9R7fLK9sgsyoZbpX8td5qK1ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i6bZdDnOIAkXP/YVHYOVijxEWyMpuiKNZGcrV4nQgSHoDzDLAEEFjASjVM+/TtNao
	 I8jH2mM41aTPrIAF1Arf+sKUUjlLr2qfzsBRQ8KlrUNUrWG/zKuPnOUuN+Euj1P8Sp
	 0tu8a2epnV4WJ6K4gdbWkEl78ESP1/Mqws4VRSZw=
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
To: zohar@linux.ibm.com,
	roberto.sassu@huaweicloud.com,
	roberto.sassu@huawei.com,
	eric.snowberg@oracle.com,
	stefanb@linux.ibm.com,
	ebiederm@xmission.com,
	noodles@fb.com,
	bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org,
	kexec@lists.infradead.org
Cc: code@tyhicks.com,
	nramas@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH v4 7/7] ima: measure kexec load and exec events as critical data
Date: Mon, 22 Jan 2024 10:38:04 -0800
Message-Id: <20240122183804.3293904-8-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
References: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_103822_230447_A5CC8BDC 
X-CRM114-Status: GOOD (  15.99  )
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

There could be a potential mismatch between IMA measurements and TPM PCR
quotes caused by the indeterminate interval between kexec 'load' and
'execute'.  The extra memory allocated at kexec 'load' for IMA log buffer
may run out.  It can lead to missing events in the IMA log after a soft
reboot to the new Kernel, resulting in TPM PCR quotes mismatch and remote
attestation failures.

Define two new IMA events, 'kexec_load' and 'kexec_execute', to be 
measured as critical data at kexec 'load' and 'execute' respectively.
Report the allocated kexec segment size, IMA binary log size and the
runtime measurements count as part of those events.

These events, and the values reported through them, serve as markers in
the IMA log to verify the IMA events are captured during kexec soft
reboot.  The presence of a 'kexec_load' event in between the last two
'boot_aggregate' events in the IMA log implies this is a kexec soft
reboot, and not a cold-boot. And the absence of 'kexec_execute' event
after kexec soft reboot implies missing events in that window which
results in inconsistency with TPM PCR quotes, necessitating a cold boot
for a successful remote attestation.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima_kexec.c | 34 +++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index c126aa6494e9..1f8b697f4ed0 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -17,6 +17,8 @@
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
+#define IMA_KEXEC_EVENT_LEN 128
+
 static struct seq_file ima_kexec_file;
 static void *ima_kexec_buffer;
 static size_t kexec_segment_size;
@@ -33,6 +35,10 @@ static void ima_free_kexec_file_buf(struct seq_file *sf)
 
 static int ima_alloc_kexec_file_buf(size_t segment_size)
 {
+	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
+	size_t buf_size;
+	long len;
+
 	/*
 	 * kexec 'load' may be called multiple times.
 	 * Free and realloc the buffer only if the segment_size is
@@ -42,7 +48,7 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
 	    ima_kexec_file.size == segment_size &&
 	    ima_kexec_file.read_pos == 0 &&
 	    ima_kexec_file.count == sizeof(struct ima_kexec_hdr))
-		return 0;
+		goto out;
 
 	ima_free_kexec_file_buf(&ima_kexec_file);
 
@@ -55,6 +61,18 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
 	ima_kexec_file.read_pos = 0;
 	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
 
+out:
+	buf_size = ima_get_binary_runtime_size();
+	len = atomic_long_read(&ima_htable.len);
+
+	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
+		  "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
+		  "ima_runtime_measurements_count=%ld;",
+		  segment_size, buf_size, len);
+
+	ima_measure_critical_data("ima_kexec", "kexec_load", ima_kexec_event,
+				  strlen(ima_kexec_event), false, NULL, 0);
+
 	return 0;
 }
 
@@ -181,10 +199,12 @@ void ima_add_kexec_buffer(struct kimage *image)
 static int ima_update_kexec_buffer(struct notifier_block *self,
 				   unsigned long action, void *data)
 {
+	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
 	void *buf = NULL;
 	size_t buf_size;
 	int ret = NOTIFY_OK;
 	bool resume = false;
+	long len;
 
 	if (!kexec_in_progress) {
 		pr_info("%s: No kexec in progress.\n", __func__);
@@ -196,6 +216,18 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
 		return ret;
 	}
 
+	buf_size = ima_get_binary_runtime_size();
+	len = atomic_long_read(&ima_htable.len);
+
+	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
+		  "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
+		  "ima_runtime_measurements_count=%ld;",
+		  kexec_segment_size, buf_size, len);
+
+	ima_measure_critical_data("ima_kexec", "kexec_execute",
+				  ima_kexec_event, strlen(ima_kexec_event),
+				  false, NULL, 0);
+
 	ima_measurements_suspend();
 
 	ret = ima_dump_measurement_list(&buf_size, &buf,
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CF1C4332F
	for <kexec@archiver.kernel.org>; Sat, 16 Dec 2023 01:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8zPaK6HsDfJt5HYPzWilb0GEm3k6PAesocbCa8BhDho=; b=PBUiS7EBcNAXo9
	czQfn9I5oSWH6bl0LG5OQnKwOKkvjKvgrrI4VNPn+KA3rbtLhPblOzLHe+zrODizgtvEiI3P88OG0
	Bn2A8w6Axu9sX3o8wWgXN5/zHH0EMTLv9XA7XElXileJfdeTMEI1AdkRpUXVx2DjzzVF+/2bQAsfR
	HdOJ0riLmd9/xERvag/Gi7lmRmO9RgmA4Nrueb08OV00p4T68zGdr6vWdODUK8406Sk5w6PdP4JiY
	IfyONgnlt/lAcD7DCTn40QuqFvw4kx1m1HGLm/oQILyNwFrPwfAQVWbz7LEtdYzKwfWWNRC4wct9g
	hvC4EuRetuhwJZxOVWng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rEJ9j-005472-0V;
	Sat, 16 Dec 2023 01:07:51 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rEJ9e-00544x-2I
	for kexec@lists.infradead.org;
	Sat, 16 Dec 2023 01:07:48 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id A6C6B20B3CC5;
	Fri, 15 Dec 2023 17:07:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A6C6B20B3CC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1702688861;
	bh=VKCDyBNAtLzbD9bEYAgMrB8Tn92NT5hA4Th4n1dFxBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cdQR0bvDJq65Ivx9V//Qq2WtnEIs6ohMgKh94PMilADBuAeUy8PdApbWOxODqIRFo
	 rhD1z0Bd0D+qw2p+F7h9BB41F02JRpNm0mWcKJXPHUtJjFLFxAoC6VG/huAG1qQw7K
	 /m+G5NRuwatrFtPtcDMeAskde90Y2UfxIBPkwNjM=
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
Subject: [PATCH v3 7/7] ima: measure kexec load and exec events as critical data
Date: Fri, 15 Dec 2023 17:07:29 -0800
Message-Id: <20231216010729.2904751-8-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_170746_791487_94474724 
X-CRM114-Status: GOOD (  14.39  )
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
'execute'.  Memory allocated at kexec 'load' for IMA log buffer may run
out. It can lead to missing events in the IMA log after a soft reboot to
the new Kernel, resulting in TPM PCR quotes mismatch and remote
attestation failures.

Define two new IMA events, 'kexec_load' and 'kexec_execute', to be 
measured as critical data at kexec 'load' and 'execute' respectively.

These events serve as markers in the IMA log to verify the IMA events are
captured between kexec 'load' and 'execute' window.  The presence of a
'kexec_load' event in between the last two 'boot_aggregate' events in the
IMA log implies this is a kexec soft reboot, and not a cold-boot. And the
absence of 'kexec_execute' event after kexec soft reboot implies missing
events in that window which results in inconsistency with TPM PCR quotes,
necessitating a cold boot for further successful remote attestation.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima_kexec.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 063da9c834a0..47da41a66dcc 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -17,6 +17,8 @@
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
+#define IMA_KEXEC_EVENT_LEN 128
+
 struct seq_file ima_kexec_file;
 static void *ima_kexec_buffer;
 static size_t kexec_segment_size;
@@ -33,6 +35,8 @@ void ima_free_kexec_file_buf(struct seq_file *sf)
 
 static int ima_alloc_kexec_file_buf(size_t segment_size)
 {
+	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
+
 	/*
 	 * kexec 'load' may be called multiple times.
 	 * Free and realloc the buffer only if the segment_size is
@@ -42,7 +46,7 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
 	    ima_kexec_file.size == segment_size &&
 	    ima_kexec_file.read_pos == 0 &&
 	    ima_kexec_file.count == sizeof(struct ima_kexec_hdr))
-		return 0;
+		goto out;
 
 	ima_free_kexec_file_buf(&ima_kexec_file);
 
@@ -55,6 +59,13 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
 	ima_kexec_file.read_pos = 0;
 	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
 
+out:
+	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
+		  "kexec_segment_size=%lu;", segment_size);
+
+	ima_measure_critical_data("ima_kexec", "kexec_load", ima_kexec_event,
+				  strlen(ima_kexec_event), false, NULL, 0);
+
 	return 0;
 }
 
@@ -179,6 +190,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 static int ima_update_kexec_buffer(struct notifier_block *self,
 				   unsigned long action, void *data)
 {
+	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
 	void *buf = NULL;
 	size_t buf_size;
 	bool resume = false;
@@ -194,6 +206,15 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
 		return ret;
 	}
 
+	buf_size = ima_get_binary_runtime_size();
+	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
+		  "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;",
+		  kexec_segment_size, buf_size);
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

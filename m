Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBDDC36017
	for <kexec@archiver.kernel.org>; Wed,  2 Apr 2025 12:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c7xlCRrPrh0uSEOIDsBq+I5m+1pDMPQECAnp8rbF0oQ=; b=1uUyIl0OqNknEFBMI6/K/KXSqi
	z+qhP+z5YEo39jITbLghJzacUmjhv91uSw18aAgxyk32vW5HgD3lTcN/UZriPjy311mNSpYscZoWm
	BzQjowc+1i9BamoPlbJ8kiphYnRkLZV0nKlTAvw66oRDCf/URsC0m2Rn6relyUmIn7GxCIc7AxgxM
	PJ/YIlY/oUexS+IyXT9JJ3k2rp8PMQs3g9dJ5b/4cosGQtNLWZxj0Xch5UwSNFEOg9KJTVdVpvMm6
	q8ywVdR6yorqe+wMwutar9+atEAxRbN7kzgMyIFcTW5odzC1V7XeI2Kh1oS5z+sHedgSytIqHzxUn
	hhEYKWHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzxZF-00000006936-3Tps;
	Wed, 02 Apr 2025 12:51:41 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzxVU-000000068Ab-3qu1
	for kexec@lists.infradead.org;
	Wed, 02 Apr 2025 12:47:50 +0000
Received: from DESKTOP-VOT081N.hsd1.ga.comcast.net (unknown [20.114.144.49])
	by linux.microsoft.com (Postfix) with ESMTPSA id 52A4B2041315;
	Wed,  2 Apr 2025 05:47:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 52A4B2041315
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743598068;
	bh=c7xlCRrPrh0uSEOIDsBq+I5m+1pDMPQECAnp8rbF0oQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P5T2QWeJRhqYxLPKlnx5GmyWPp1wX7x9pWcSJBteHGJestyj/PjJimXt+rwAnyEgJ
	 XUsoXOkWgrCzG8b+Lavk7cqtnpzu0QiJuXdWyevgdzYeNF/hEoo84rG90F1YS6mSm/
	 WQZExhNNptEGi8pirH5PbuJM2sI8Jt857nBESSL0=
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
Subject: [PATCH v11 5/9] ima: kexec: define functions to copy IMA log at soft boot
Date: Wed,  2 Apr 2025 05:47:18 -0700
Message-ID: <20250402124725.5601-6-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250402124725.5601-1-chenste@linux.microsoft.com>
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_054749_060969_537C7AF6 
X-CRM114-Status: GOOD (  16.35  )
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

The IMA log is currently copied to the new kernel during kexec 'load' 
using ima_dump_measurement_list(). However, the log copied at kexec 
'load' may result in loss of IMA measurements that only occurred after
kexec "load'. Therefore, the log needs to be copied during kexec 
'execute'. Setup the needed infrastructure to move the IMA log copy from
kexec 'load' to 'execute'.

Define a new IMA hook ima_update_kexec_buffer() as a stub function.
It will be used to call ima_dump_measurement_list() during kexec 'execute'.

Implement ima_kexec_post_load() function to be invoked after the new 
Kernel image has been loaded for kexec. ima_kexec_post_load() maps the 
IMA buffer to a segment in the newly loaded Kernel.  It also registers 
the reboot notifier_block to trigger ima_update_kexec_buffer() at 
kexec 'execute'.

Set the priority of register_reboot_notifier to INT_MIN to ensure that the
IMA log copy operation will happen at the end of the operation chain, which
is crucial for maintaining the integrity of the logs

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com> 
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/ima.h                |  3 ++
 security/integrity/ima/ima_kexec.c | 47 ++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 0bae61a15b60..8e29cb4e6a01 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -32,6 +32,9 @@ static inline void ima_appraise_parse_cmdline(void) {}
 
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
+extern void ima_kexec_post_load(struct kimage *image);
+#else
+static inline void ima_kexec_post_load(struct kimage *image) {}
 #endif
 
 #else
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 7e0a19c3483f..e79f6caf895b 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -12,10 +12,14 @@
 #include <linux/kexec.h>
 #include <linux/of.h>
 #include <linux/ima.h>
+#include <linux/reboot.h>
+#include <asm/page.h>
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
+static bool ima_kexec_update_registered;
 static struct seq_file ima_kexec_file;
+static void *ima_kexec_buffer;
 
 static void ima_free_kexec_file_buf(struct seq_file *sf)
 {
@@ -162,6 +166,49 @@ void ima_add_kexec_buffer(struct kimage *image)
 	kexec_dprintk("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
 		      kbuf.mem);
 }
+
+/*
+ * Called during kexec execute so that IMA can update the measurement list.
+ */
+static int ima_update_kexec_buffer(struct notifier_block *self,
+				   unsigned long action, void *data)
+{
+	return NOTIFY_OK;
+}
+
+static struct notifier_block update_buffer_nb = {
+	.notifier_call = ima_update_kexec_buffer,
+	.priority = INT_MIN
+};
+
+/*
+ * Create a mapping for the source pages that contain the IMA buffer
+ * so we can update it later.
+ */
+void ima_kexec_post_load(struct kimage *image)
+{
+	if (ima_kexec_buffer) {
+		kimage_unmap_segment(ima_kexec_buffer);
+		ima_kexec_buffer = NULL;
+	}
+
+	if (!image->ima_buffer_addr)
+		return;
+
+	ima_kexec_buffer = kimage_map_segment(image,
+					      image->ima_buffer_addr,
+					      image->ima_buffer_size);
+	if (!ima_kexec_buffer) {
+		pr_err("Could not map measurements buffer.\n");
+		return;
+	}
+
+	if (!ima_kexec_update_registered) {
+		register_reboot_notifier(&update_buffer_nb);
+		ima_kexec_update_registered = true;
+	}
+}
+
 #endif /* IMA_KEXEC */
 
 /*
-- 
2.25.1



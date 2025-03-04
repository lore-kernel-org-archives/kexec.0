Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2D5C282D9
	for <kexec@archiver.kernel.org>; Tue,  4 Mar 2025 19:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=55oilYOb/o5X5igsf+VHhahT6DeIeNK9q6z0NvNx3Vo=; b=1COT8+smNw+m9vQ6r9UmR0unJf
	bq4veC83A13tkyWJet1xZIGvM6u0tC/jBZM+gGtbtuYNJ44DSj5SAOQnShFHgedhRcBD3+OGEPQVm
	wYRU4mwHX0ujK6o0MDBZmRCHZo4OaJPAYStaohOZuBzki2j58/xZLcKQSmsfesxmt7JuL1cTGdbdY
	nLc0xmuAx+xJnXxjvmhBE+EvV1LXXXvbVRQUvoEXj0e0drMGVNhSFyIF9dMGw1TSLmZfYRo8TaHfv
	Wlx4GNaZPI8LuFCpmCodYl/OnzNGcG6q07DkoIdzwqMYgdrRFy9Ani0oKU4RhXLC09HU1b+F4cFOj
	4mFyegwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpYH0-000000066BE-3r3p;
	Tue, 04 Mar 2025 19:49:50 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpXYd-00000005wvU-0LSX
	for kexec@lists.infradead.org;
	Tue, 04 Mar 2025 19:04:01 +0000
Received: from localhost.localdomain (unknown [167.220.59.4])
	by linux.microsoft.com (Postfix) with ESMTPSA id 51A4E210EAF7;
	Tue,  4 Mar 2025 11:03:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 51A4E210EAF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741115038;
	bh=55oilYOb/o5X5igsf+VHhahT6DeIeNK9q6z0NvNx3Vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hzOJfNKRXf9WZr29HaD8vqFuq7rMgkOe+gPGHmUnDR/hLsN/en6QpzoJyRAPbGVl5
	 Nwyi2Z3d7L11aCGnY5lhypWw0chrQc8JY9uY3V88yL3pV5ZL4HaqJ2yd/sgZqNQ9oH
	 Q7xCtw+7geDx10RmqdmsKkhRTNxrGSNJ8QpNIlvA=
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
Subject: [PATCH v9 4/7] ima: kexec: define functions to copy IMA log at soft boot
Date: Tue,  4 Mar 2025 11:03:48 -0800
Message-Id: <20250304190351.96975-5-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250304190351.96975-1-chenste@linux.microsoft.com>
References: <20250304190351.96975-1-chenste@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250304_110359_216961_E002730B 
X-CRM114-Status: GOOD (  15.03  )
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
using ima_dump_measurement_list().  However, the log copied at kexec 
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
index 0465beca8867..074848dcd30f 100644
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
 static struct seq_file ima_kexec_file;
+static void *ima_kexec_buffer;
+static bool ima_kexec_update_registered;
 
 static void ima_reset_kexec_file(struct seq_file *sf)
 {
@@ -192,6 +196,49 @@ void ima_add_kexec_buffer(struct kimage *image)
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
+struct notifier_block update_buffer_nb = {
+	.notifier_call = ima_update_kexec_buffer,
+	.priority = 1,
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



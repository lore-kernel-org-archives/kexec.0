Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10611C48BC1
	for <kexec@archiver.kernel.org>; Wed, 14 Feb 2024 15:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=doTXTkmIr3LZk8zy1lfehwwhC3NFgRfHsyloUTlfBeU=; b=EKcRB4fc7CJrYU
	yU4kjWwaHL6F7+bXT+QdEDFKMHpomrTctSYYgs18H/bP6WzyuE0DKtn4HbVm3GqkYVPHvyytjhii7
	77rJZ4nzuv7CQKOcN4a7EpbMc2OpYLkReCM4INsLwS8lw+TuGF1aXy6CvMnCtiIcUI/Y6XzwryCUA
	279sYp2zvxhOF8sFD0PnWc66ov31KcPDUautDMGjBN5mISfmmhdDuiZKpMq6vjYjzgDY4ehZh7kc0
	hRUjboGf8cVqDYebrRNuU1vYWIRKDkIdHaXI9nTh6XOfVHJMbBCNxKAYikkC+XEJcDW9cIFzS9BiB
	xqrGPFDmGYrulX4wf+Qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raHLP-0000000DLta-30rw;
	Wed, 14 Feb 2024 15:38:43 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raHLJ-0000000DLpr-2mlW
	for kexec@lists.infradead.org;
	Wed, 14 Feb 2024 15:38:40 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 86AAF20B2004;
	Wed, 14 Feb 2024 07:38:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 86AAF20B2004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1707925115;
	bh=sDdfGVOWH8CiNXECHZEt8PdafbEcCfqmlR/LFkbkEQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PG5wG3U+GogNtZZnl3J6SLq0IwmIJ6bg77pmcFeZVkO+zBz8FfXVJRxmRUpj2mS8C
	 RX44MoXorvTMidy81kT5mtnWtdgRd0wuJZByojKiobNjiq5MuuCu1bw85IOtj47BNa
	 dnxHOBZTtLaYuwL5b1TdalCmXL7weURSXLKOpsrw=
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
Subject: [PATCH v5 4/8] ima: kexec: define functions to copy IMA log at soft boot
Date: Wed, 14 Feb 2024 07:38:23 -0800
Message-Id: <20240214153827.1087657-5-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240214_073837_937621_3057BA99 
X-CRM114-Status: GOOD (  14.43  )
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

IMA log is copied to the new Kernel during kexec 'load' using 
ima_dump_measurement_list().  The log copy at kexec 'load' may result in
loss of IMA measurements during kexec soft reboot.  It needs to be copied
over during kexec 'execute'.  Setup the needed infrastructure to move the
IMA log copy from kexec 'load' to 'execute'. 

Define a new IMA hook ima_update_kexec_buffer() as a stub function.
It will be used to call ima_dump_measurement_list() during kexec 
'execute'.   

Implement kimage_file_post_load() and ima_kexec_post_load() functions
to be invoked after the new Kernel image has been loaded for kexec.
ima_kexec_post_load() maps the IMA buffer to a segment in the newly
loaded Kernel.  It also registers the reboot notifier_block to trigger
ima_update_kexec_buffer() at exec 'execute'.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 include/linux/ima.h                |  3 ++
 kernel/kexec_file.c                |  5 ++++
 security/integrity/ima/ima_kexec.c | 46 ++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 86b57757c7b1..006db20f852d 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -49,6 +49,9 @@ static inline void ima_appraise_parse_cmdline(void) {}
 
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
+extern void ima_kexec_post_load(struct kimage *image);
+#else
+static inline void ima_kexec_post_load(struct kimage *image) {}
 #endif
 
 #else
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 0e3689bfb0bb..fe59cb7c179d 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -186,6 +186,11 @@ kimage_validate_signature(struct kimage *image)
 }
 #endif
 
+void kimage_file_post_load(struct kimage *image)
+{
+	ima_kexec_post_load(image);
+}
+
 /*
  * In file mode list of segments is prepared by kernel. Copy relevant
  * data from user space, do error checking, prepare segment list
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index ccb072617c2d..1d4d6c122d82 100644
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
@@ -184,6 +188,48 @@ void ima_add_kexec_buffer(struct kimage *image)
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
+		pr_err("%s: Could not map measurements buffer.\n", __func__);
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


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

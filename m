Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4033C001DD
	for <kexec@archiver.kernel.org>; Mon,  3 Jul 2023 21:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f0cPD/wyXltIFm91GEktkiVM9tzcpdq906okg/5/Qcs=; b=hkQBs42+GW08Z2
	Zes9HZr8eh8+XsdhnLivwdib6QEbNaeVfMQkRhL5x7TFCObHBvysA2bADar8NVyXtYvce2z5GzO9y
	//ljHwMJWRcvWMYJadVTwruPZyVEguVD0ag/V16b6/5F45KrsInNXgkvDnVuOVEJQ4ECDxx24zFvu
	wgLwvTWbhStdp2PVajCj99/bYKt31iXybyhHfTgZHKaBc7Eem5J0KK76OCyDe8euOf0zcY3GBX+mh
	iBXGuZ+lf/H+RF1MTNHjsuEWTdabhZCcPg995+NqVMFp65k+XY4TfynPSozZh0TOoXkGZPDJ/Z8sQ
	uidBxZi/LO22YegqdyAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGRXy-00BVxA-33;
	Mon, 03 Jul 2023 21:57:26 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGRXu-00BVu6-0B
	for kexec@lists.infradead.org;
	Mon, 03 Jul 2023 21:57:23 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2E33320C0900;
	Mon,  3 Jul 2023 14:57:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2E33320C0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1688421440;
	bh=jZlpyLIYjpWzttcfW8imXFANOTtzePBpV7z2w9ly2cQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E4ET/YXnwrZx/o2zwb9WVbHnUdn87s3v7wBVX1I4GI2yGxfzfGu27/Qcx2h9bZ58S
	 LUhgYEaI0/x9n4hf0sISkKDkLwUCr+w2deOIKfDcfpdheYuW0KrfEfJWUTPTxyMIDv
	 too7lIzFyrO4Oh7y1MBFrJoyBx2yKoDc/D8zXIwI=
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
To: zohar@linux.ibm.com,
	noodles@fb.com,
	bauermann@kolabnow.com,
	kexec@lists.infradead.org,
	linux-integrity@vger.kernel.org
Cc: code@tyhicks.com,
	nramas@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH 08/10] ima: implement and register a reboot notifier function to update kexec buffer
Date: Mon,  3 Jul 2023 14:57:07 -0700
Message-Id: <20230703215709.1195644-9-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_145722_138772_1B662757 
X-CRM114-Status: GOOD (  16.97  )
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

The IMA subsystem needs to ensure that the measurement list is up to date
during a kexec operation, i.e., when the kernel is rebooted without going
through the full system reboot process. Currently, there is no mechanism
to update the measurement list when the system is soft booted using kexec.

Add a notifier function ima_update_kexec_buffer that is called during a
kexec soft reboot.  Implement ima_kexec_post_load, which maps the IMA
buffer after a kexec load and registers the reboot notifier.

Define a new notifier block update_buffer_nb, with ima_update_kexec_buffer
as its notifier function.  Register the notifier function in
ima_kexec_post_load if it hasn't been already, indicated by the
ima_kexec_update_registered flag.

When a kexec soft reboot is triggered, ima_update_kexec_buffer will be
executed to update the IMA buffer.  This ensures that the events between
kexec 'load' and 'execute' are captured and integrity of measurements
remains intact across kexec reboots.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 include/linux/ima.h                |  3 +++
 security/integrity/ima/ima_kexec.c | 35 ++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

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
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 424930085c18..363c107dc4a5 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -12,6 +12,8 @@
 #include <linux/kexec.h>
 #include <linux/of.h>
 #include <linux/ima.h>
+#include <linux/reboot.h>
+#include <asm/page.h>
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
@@ -19,6 +21,7 @@ struct seq_file ima_kexec_file;
 struct ima_kexec_hdr ima_khdr;
 static size_t kexec_segment_size;
 static void *ima_kexec_buffer;
+static bool ima_kexec_update_registered;
 
 void ima_clear_kexec_file(void)
 {
@@ -222,6 +225,38 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
 	return NOTIFY_OK;
 }
 
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

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A2CC47DDC
	for <kexec@archiver.kernel.org>; Mon, 22 Jan 2024 18:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WHI7UwZ/EUKbTowruKkdtcdBQbeg0vkEyBPHl2N2iOw=; b=R5V8qlqi2R8ASs
	UbYwGxnaKwd3+pcgFLTkbplLXThwXzT+wwywHb8k4kP2XDV57LmfCAeA++JT5MH8wJi3CXdhbzg6n
	jAUTB/9jeJDb7BCHsthgbQtzpeDb3gWDD+sakaQWa8ON1Q0pTH5YzCrUAQsXeOtVFHgLLboxj5zN/
	ClvtCgkyPngx2GRi2sLBUht/OVq44Ne4Ve/Jr1zEsWGB6gsI+QGhsFhSC10rBkURQe5wi0MCiBAZM
	mv0sHaz/EIDwqRZigOIzYAG2MDapLwO2jhl+1bUTUdeqd9xS5Wla3Scc8aVDEtnSUU7Mv9dMsptgN
	s/g2z9ocUZg1mtIQcJ5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRzBk-00DYfI-2D;
	Mon, 22 Jan 2024 18:38:28 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRzBe-00DYbn-09
	for kexec@lists.infradead.org;
	Mon, 22 Jan 2024 18:38:24 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7DB9A20E2C23;
	Mon, 22 Jan 2024 10:38:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7DB9A20E2C23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1705948696;
	bh=OrBlj8d920TOWK01B2VDtnxiB7Uu+7TUArXhXB9LNGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3VcWS6yUWlRnjQuwObIpI7/TXFMUQN4ERhOE0qyDlARWTZEHRZRgWdbS8XtvGGwk
	 6ulCgUC77e0Gw5JMHtzxGjP/IhGxzSMx/uO7QLMzLSbMy84DJ0TksHKUwLj6aBZRMx
	 cX9+N1KJlAjCDJ65z0YZw/+sU+rwjW0fFrcslAcA=
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
Subject: [PATCH v4 5/7] ima: suspend measurements during buffer copy at kexec execute
Date: Mon, 22 Jan 2024 10:38:02 -0800
Message-Id: <20240122183804.3293904-6-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
References: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_103822_255119_2204751C 
X-CRM114-Status: GOOD (  18.68  )
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

New measurements added to the IMA log while the log is being copied
during the kexec 'execute' may not get copied over.  This can cause the
measurement log to be out of sync with the IMA TPM PCR, which could
result in breaking the integrity of the measurements after kexec soft
reboot.

Implement and call the functions ima_measurements_suspend() and 
ima_measurements_resume() from ima_update_kexec_buffer().

Add a check in the ima_add_template_entry() function not to measure
events when 'suspend_ima_measurements' flag is set.

This ensures the integrity of the IMA log while it is being copied over
to the new Kernel during kexec 'execute'.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima.h       |  2 ++
 security/integrity/ima/ima_kexec.c |  7 +++++++
 security/integrity/ima/ima_queue.c | 32 ++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c29db699c996..49a6047dd8eb 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -161,6 +161,8 @@ bool ima_template_has_modsig(const struct ima_template_desc *ima_template);
 int ima_restore_measurement_entry(struct ima_template_entry *entry);
 int ima_restore_measurement_list(loff_t bufsize, void *buf);
 int ima_measurements_show(struct seq_file *m, void *v);
+void ima_measurements_suspend(void);
+void ima_measurements_resume(void);
 unsigned long ima_get_binary_runtime_size(void);
 int ima_init_template(void);
 void ima_init_template_list(void);
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 25150bfc7129..f26b5b342d84 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -179,6 +179,7 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
 	void *buf = NULL;
 	size_t buf_size;
 	int ret = NOTIFY_OK;
+	bool resume = false;
 
 	if (!kexec_in_progress) {
 		pr_info("%s: No kexec in progress.\n", __func__);
@@ -190,12 +191,15 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
 		return ret;
 	}
 
+	ima_measurements_suspend();
+
 	ret = ima_dump_measurement_list(&buf_size, &buf,
 					kexec_segment_size);
 
 	if (!buf) {
 		pr_err("%s: Dump measurements failed. Error:%d\n",
 		       __func__, ret);
+		resume = true;
 		goto out;
 	}
 	memcpy(ima_kexec_buffer, buf, buf_size);
@@ -203,6 +207,9 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
 	kimage_unmap_segment(ima_kexec_buffer);
 	ima_kexec_buffer = NULL;
 
+	if (resume)
+		ima_measurements_resume();
+
 	return ret;
 }
 
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 532da87ce519..5946a26a2849 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -44,6 +44,11 @@ struct ima_h_table ima_htable = {
  */
 static DEFINE_MUTEX(ima_extend_list_mutex);
 
+/*
+ * Used internally by the kernel to suspend-resume ima measurements.
+ */
+static atomic_t suspend_ima_measurements;
+
 /* lookup up the digest value in the hash table, and return the entry */
 static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
 						       int pcr)
@@ -148,6 +153,20 @@ static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
 	return result;
 }
 
+void ima_measurements_suspend(void)
+{
+	mutex_lock(&ima_extend_list_mutex);
+	atomic_set(&suspend_ima_measurements, 1);
+	mutex_unlock(&ima_extend_list_mutex);
+}
+
+void ima_measurements_resume(void)
+{
+	mutex_lock(&ima_extend_list_mutex);
+	atomic_set(&suspend_ima_measurements, 0);
+	mutex_unlock(&ima_extend_list_mutex);
+}
+
 /*
  * Add template entry to the measurement list and hash table, and
  * extend the pcr.
@@ -176,6 +195,19 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 		}
 	}
 
+	/*
+	 * suspend_ima_measurements will be set if the system is
+	 * undergoing kexec soft boot to a new kernel.
+	 * suspending measurements in this short window ensures the
+	 * consistency of the IMA measurement list during copying
+	 * of the kexec buffer.
+	 */
+	if (atomic_read(&suspend_ima_measurements)) {
+		audit_cause = "measurements_suspended";
+		audit_info = 0;
+		goto out;
+	}
+
 	result = ima_add_digest_entry(entry,
 				      !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE));
 	if (result < 0) {
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

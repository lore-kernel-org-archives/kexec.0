Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE15C48BC3
	for <kexec@archiver.kernel.org>; Wed, 14 Feb 2024 15:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tpJoA8l21d2JbfoRuXD3JY2ywS+2cdYem07OxF4Q/dg=; b=w+uaD79wJvrgvK
	QzC6Ooh9+SlLn8pxlGSDNxbJ9HnyeiNztOhP0yqbLRKpxfB3qU0mxgLVcNzg4C6w0DmRN0gr7KL9K
	zinDZNCnkgJJRMIVB+NXWVZiETWt4TlAt9P4IaBIpPO9kvZbfddwYv7DOPjwgucisdpQvOYd/gFET
	qGajNbcZhbmz960mKXv4ry4Tggdsd3DrQPwlggv39UO1mgdKdeRvjTLerK8FvGifd6BTA+++ElLjv
	voly8LHQfyku1U+b7uVmxOXZTdmF7lifJD2DEx0oTBzAAdRcT0xrdWGUpqd4ymq4EzgDUOju/HPrP
	1yHOVf+l6CkrNgZdZ3bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raHLQ-0000000DLuZ-44Ss;
	Wed, 14 Feb 2024 15:38:44 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raHLL-0000000DLrM-3Lxe
	for kexec@lists.infradead.org;
	Wed, 14 Feb 2024 15:38:41 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 03D1A20B2006;
	Wed, 14 Feb 2024 07:38:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 03D1A20B2006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1707925116;
	bh=nv8cVzvekpqI1MThlLDGdnsjUpyj1mzzoaYEfh3bbqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Se9qOXVfkBNkCkLEVMaWKuVYz0npEpoYTgPdPGBLvZAVYE2D94cUzsfGfUTqKmu8e
	 kaLZoxKGkLDmz3fjrriIIVjr2H2VsweKvJu1qoW53r2ocIiQdhbMPb/qzI9e2hOOOi
	 KXYG6HLfpJQam/aDf5BdBbEyrkqXKsz7EZ2SQISI=
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
Subject: [PATCH v5 6/8] ima: suspend measurements during buffer copy at kexec execute
Date: Wed, 14 Feb 2024 07:38:25 -0800
Message-Id: <20240214153827.1087657-7-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240214_073840_047875_2D484C36 
X-CRM114-Status: GOOD (  18.03  )
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
measurement log to be out of sync with the TPM PCRs that IMA extends,
which could result in breaking the integrity of the measurements after
kexec soft reboot.

Implement and call the functions ima_measurements_suspend() and 
ima_measurements_resume() from ima_update_kexec_buffer().

Add a check in the ima_add_template_entry() function not to measure
events when 'suspend_ima_measurements' flag is set.

This ensures the integrity of the IMA log while it is being copied over
to the new Kernel during kexec 'execute'.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
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
index 98fc9b9782a2..dbeeb7f1355e 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -184,6 +184,7 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
 	void *buf = NULL;
 	size_t buf_size;
 	int ret = NOTIFY_OK;
+	bool resume = false;
 
 	if (!kexec_in_progress) {
 		pr_info("%s: No kexec in progress.\n", __func__);
@@ -195,12 +196,15 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
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
@@ -208,6 +212,9 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
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

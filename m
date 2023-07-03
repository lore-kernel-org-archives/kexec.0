Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69D4C001DB
	for <kexec@archiver.kernel.org>; Mon,  3 Jul 2023 21:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QALo6N3CPynUnBk0BwNE5a4sZWAXCdo+sniha64PSu8=; b=TaKVwE30knAMoS
	vQHVUBFxuW7qfAk/PuND5gXVhrH/d+f6ZwqlVhgF9UCXwvZXKaRFMEizHsnfUP3ORemUaNdNe4HGk
	kX3M7neTAVYB/+zXe9PU5QTiCDaRo4D1UnRowJtQDYwOvhq4BntiyaXQF7+UooP9NeKqmWdpgu4vW
	JiNO7zTozXmNe8dOkMjdv7IMsfxuTmhhmFPqF04vjVeccslX4lDuRtF8Hy13Z5HX9ysiNjKBKjQJA
	ZrmJDk6xyuTvM+AElZzFULfrgTvfwd2fY+Kzbf3t3AJh9WaeWsL7fN8Ft/kKDPEVemVn7DOYbKvSY
	vMpooc+eCC2ZrnXn97Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGRXy-00BVwz-1Z;
	Mon, 03 Jul 2023 21:57:26 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGRXs-00BVsZ-0Q
	for kexec@lists.infradead.org;
	Mon, 03 Jul 2023 21:57:22 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id CAB5220C08E8;
	Mon,  3 Jul 2023 14:57:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CAB5220C08E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1688421439;
	bh=dY4aFxIDs6EY00F0s6UDoHjuv7HPfWOrldANuBkGFWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EUeufRn/WOcR0527Xs7EmfGHRPuXdmUeyzABRAmpyU/Cn5BjjQ3ciTrKQyapp9t0S
	 oexM5A/c9kw7UxVncX5t39AsRe26OL5vitK/cjy0SFR6+pNB6JpwVZU7l2UIWGbyNG
	 u7/6Y7l+nL3Prp+IPlcyJoiaxnA29fz83dpICOiE=
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
To: zohar@linux.ibm.com,
	noodles@fb.com,
	bauermann@kolabnow.com,
	kexec@lists.infradead.org,
	linux-integrity@vger.kernel.org
Cc: code@tyhicks.com,
	nramas@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH 04/10] ima: implement functions to suspend and resume measurements
Date: Mon,  3 Jul 2023 14:57:03 -0700
Message-Id: <20230703215709.1195644-5-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_145720_231522_FABC4721 
X-CRM114-Status: GOOD (  11.28  )
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

The IMA subsystem needs to provide a mechanism to suspend or resume
measurements.  This functionality is needed to temporarily halt the
recording of IMA measurements during certain system operations.

Add functions ima_measurements_suspend() and ima_measurements_resume()
functions to set and reset the suspend_ima_measurements variable,
respectively, to suspend/resume IMA measurements.  Use
ima_extend_list_mutex to ensure that the operations are thread-safe.

Note: Use ima_measurements_suspend() and ima_measurements_resume() in
pairs to avoid indefinitely suspending IMA measurements.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima.h       |  2 ++
 security/integrity/ima/ima_queue.c | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 2ffda9449b9b..7127c5cf1909 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -163,6 +163,8 @@ bool ima_template_has_modsig(const struct ima_template_desc *ima_template);
 int ima_restore_measurement_entry(struct ima_template_entry *entry);
 int ima_restore_measurement_list(loff_t bufsize, void *buf);
 int ima_measurements_show(struct seq_file *m, void *v);
+void ima_measurements_suspend(void);
+void ima_measurements_resume(void);
 unsigned long ima_get_binary_runtime_size(void);
 int ima_init_template(void);
 void ima_init_template_list(void);
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 532da87ce519..cb9abc02a304 100644
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
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

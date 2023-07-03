Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE4DC001DE
	for <kexec@archiver.kernel.org>; Mon,  3 Jul 2023 21:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WE2b2QRXwBQA7QTaQIfgXoLoJxSAKa6GXtcs16wwI2I=; b=dIwzXLtIacRwC2
	FMltwMhuWpP/+tAEGeACHpk7XLds0yTQUujrVPQZnoWvsAPlfdAC0OYTx71dbys0zhUejCvqqqDys
	5rslpvoMykNcbJX2dd/H6CkFQe5n9Ndk/ieh84kLtt0Qe8Yg6H2OhkVzQHv5G6ug1V7kfHQdEkrgT
	HeWHA8KbucZlnXYcTDx10mD6T9Hy23nCkFJMasqknb3aRLoo3bhDgs1psJ+RptUlJo8dAvway/Y4t
	yrXeuVNmoxaG7bF+RrBR6UjDH9b/qXVj23nXr629YRe6GQbvNsBJXZ0u/W7AcBe4tO+MEG1M8Tu26
	tvMeUMNPU+qAZ6hfAqVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGRXz-00BVxh-31;
	Mon, 03 Jul 2023 21:57:27 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGRXu-00BVuL-11
	for kexec@lists.infradead.org;
	Mon, 03 Jul 2023 21:57:24 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7CA1D20C08FA;
	Mon,  3 Jul 2023 14:57:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7CA1D20C08FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1688421439;
	bh=s53o5tStuuzSkUcgt//18WizvpReGbqU0p1e6vxSELk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FKUiDnfO8rTW9XniYBxK6bcBKeUB7OG4DIMTLeqWsCfgpxo6RMHKMPK3pWy5Ggpdn
	 bPVR4XczWaRXt1vP99+fAVRj1whR62d8PeYpjATVYJ8sW7C3i3H0ow4UTQICKeacxa
	 MuVvIxxVmLgBEOSKeOZJAzTMmQCESWcd0FC/yMqw=
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
To: zohar@linux.ibm.com,
	noodles@fb.com,
	bauermann@kolabnow.com,
	kexec@lists.infradead.org,
	linux-integrity@vger.kernel.org
Cc: code@tyhicks.com,
	nramas@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH 06/10] ima: update buffer at kexec execute with ima measurements
Date: Mon,  3 Jul 2023 14:57:05 -0700
Message-Id: <20230703215709.1195644-7-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_145722_399329_CDC2A4F2 
X-CRM114-Status: GOOD (  19.22  )
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

In the current implementation, the measurement list is not updated in the
buffer during the window between kexec load and execute.  This leads to
measurement loss in the buffer when transitioning from the old to the new
kernel.  This patch provides a way to update the measurement list in the
buffer during a kexec execution.  Suspending the measurements during the
buffer update ensures the buffer doesn't get corrupted, or goes out of
sync with TPM PCRs. Thus it ensures the integrity of measurements is
maintained across kernel transitions during a kexec.

Introduce a new variable ima_kexec_buffer that is used to hold the address
of the IMA kexec buffer.

Implement a function ima_update_kexec_buffer() that is called during
kexec execute, allowing the IMA to update the measurement list with the
events between kexec load and execute.  First check if a kexec is in
progress and if the IMA kexec buffer is initialized.  If these conditions
are met, suspend IMA measurements and check if the new buffer size obtained
from ima_get_binary_runtime_size() is larger than the current buffer size.
If the new buffer size is too large, output an error message, and resume
the measurements.

If the new buffer size fits, populate the new buffer with the current
measurements using ima_populate_buf_at_kexec_execute() and copy it into
ima_kexec_buffer.

Unmap ima_kexec_buffer segment from the image.  Resuming the measurements
is not needed in case of successful measurements since the control is being
passed to the new kernel anyways through kexec execute.  However, the
measurements should be resumed if there are any errors flagged in the
function.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima_kexec.c | 50 ++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 7deb8df31485..224d88ccfe85 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -18,6 +18,7 @@
 struct seq_file ima_kexec_file;
 struct ima_kexec_hdr ima_khdr;
 static size_t kexec_segment_size;
+static void *ima_kexec_buffer;
 
 void ima_clear_kexec_file(void)
 {
@@ -230,6 +231,55 @@ void ima_add_kexec_buffer(struct kimage *image)
 	pr_debug("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
 		 kbuf.mem);
 }
+
+/*
+ * Called during kexec execute so that IMA can update the measurement list.
+ */
+static int ima_update_kexec_buffer(struct notifier_block *self,
+				   unsigned long action, void *data)
+{
+	void *new_buffer = NULL;
+	size_t new_buffer_size, cur_buffer_size;
+	bool resume = false;
+
+	if (!kexec_in_progress) {
+		pr_info("%s: No kexec in progress.\n", __func__);
+		return NOTIFY_OK;
+	}
+
+	if (!ima_kexec_buffer) {
+		pr_err("%s: Kexec buffer not set.\n", __func__);
+		return NOTIFY_OK;
+	}
+
+	ima_measurements_suspend();
+
+	cur_buffer_size = kexec_segment_size - sizeof(struct ima_kexec_hdr);
+	new_buffer_size = ima_get_binary_runtime_size();
+	if (new_buffer_size > cur_buffer_size) {
+		pr_err("%s: Measurement list grew too large.\n", __func__);
+		resume = true;
+		goto out;
+	}
+
+	ima_populate_buf_at_kexec_execute(&new_buffer_size, &new_buffer);
+
+	if (!new_buffer) {
+		pr_err("%s: Dump measurements failed.\n", __func__);
+		resume = true;
+		goto out;
+	}
+	memcpy(ima_kexec_buffer, new_buffer, new_buffer_size);
+out:
+	kimage_unmap_segment(ima_kexec_buffer);
+	ima_kexec_buffer = NULL;
+
+	if (resume)
+		ima_measurements_resume();
+
+	return NOTIFY_OK;
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

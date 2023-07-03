Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F10C0015E
	for <kexec@archiver.kernel.org>; Mon,  3 Jul 2023 21:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZT0iAo7DEA3Y1ocv5MYWSX+8DeEVCOwHk0bi+s49dWQ=; b=uptN5txJHnuag5
	RcPKyg6fUNjk8i1m1KcVKaOcETuJo4uKwJo32u/Fn5xLmvXAyhAnmDGmo7OW8V8ENiCEZNGCFppxc
	982Qqct+CfjdqWtMG5yRXeCce3ZCGQGFFwIA/NiWQFj0RZ7VX9MnFjz8wkMD88Y74MmpUp6l9pHdQ
	q1YRwhLGlKAza7xpjF6zZKfGcBEF9eGufhRnx09er0/Ms3wvgEkciKow1lHQ/883BZw2WaBEx0wjr
	zGgod23ROZFjsAiUxTjgSA22awweX+gPrJlqmVK+bAaBLVasrtowICohlwvSA492s0qazsNRmG0AD
	nLNYXKoj9V3qitMLf0Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGRY1-00BVzJ-2y;
	Mon, 03 Jul 2023 21:57:29 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGRXv-00BVvH-0S
	for kexec@lists.infradead.org;
	Mon, 03 Jul 2023 21:57:24 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 80FE920C091F;
	Mon,  3 Jul 2023 14:57:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 80FE920C091F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1688421440;
	bh=gnWZBlqyn9Og/TXFeYVjeHamDdASDQOleIS25w3NzJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BP7uwA9Z4rK9VvYzQq/a+oZbqsOSr96N5eD6OztrEuWAGoJF73lvv03v3otvWdi6J
	 a/ZcVxEWbMTH8QmHKkaxVKNC5VATJGF3EEgrxGhKni2SM6bhCfKxi/DPZEhLzA+RpE
	 CxMBNbGoeEZH0ggjkoRK6QcZwnYEKWCCcuTtutXw=
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
To: zohar@linux.ibm.com,
	noodles@fb.com,
	bauermann@kolabnow.com,
	kexec@lists.infradead.org,
	linux-integrity@vger.kernel.org
Cc: code@tyhicks.com,
	nramas@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH 09/10] ima: suspend measurements while the kexec buffer is being copied
Date: Mon,  3 Jul 2023 14:57:08 -0700
Message-Id: <20230703215709.1195644-10-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_145723_206113_4D3D3669 
X-CRM114-Status: GOOD (  15.78  )
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

If the new measurements are added to the list while the kexec buffer is
being copied during kexec execute, the buffer may get corrupted, or it can
go out of sync with TPM PCRs.  This could potentially lead to breaking the
integrity of the measurements after the kexec soft reboot to the new
kernel.

Introduce a check in the ima_add_template_entry function not to measure
events and return from the function early when the suspend_ima_measurements
flag is set.

This ensures the consistency of the IMA measurement list during the copying
of the kexec buffer.  When the suspend_ima_measurements flag is set, any
new measurements will be ignored until the flag is unset.  This allows the
buffer to be safely copied without worrying about concurrent modifications
to the measurement list.  This is crucial for maintaining the integrity of
the measurements during a kexec soft reboot.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima_queue.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index cb9abc02a304..5946a26a2849 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -195,6 +195,19 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
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

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08FFE92726
	for <kexec@archiver.kernel.org>; Thu,  5 Oct 2023 18:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LoYebxQqqYuk1d6qaT+Kx0NWwhXO6kYUaN+2xU+gFUo=; b=PmFx6KgBRkv35Y
	WmnTiWIZnCR5mlbQappmDReR9kJ1DsPeWOHmztczxgQzg5yWgeFQJn4egr1UvX6u6cO2q6CZhn2hG
	PfKI+2pbA7VIAmdP78+XPOcjZF4LxYzpHdqlST6CJTE08cgxUJQY3Ogp4k/fm9GR60IZS8FS8SK9e
	I0Ej2+Q7jrJo27ydiGKy6i6gYeYgNnWqX29Msre6vydnZRQ3gJ1oYXfCg83sR2+ijC9JeskU6UK7Z
	hSOM9/suqhWcR4atAD95Upwv3EUqsHLdJUE/tMfcCOzf4uX8LClUbq72V5+iUQz5uj+760+IFY2H7
	9CFPR93BpvO6Q5enxr7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoT3G-004HTu-01;
	Thu, 05 Oct 2023 18:26:22 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoT3A-004HRX-0m
	for kexec@lists.infradead.org;
	Thu, 05 Oct 2023 18:26:18 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8025220B74C6;
	Thu,  5 Oct 2023 11:26:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8025220B74C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1696530373;
	bh=VHNJbkXP2Wry2HZE8GFrjvOrwKghhTsyMpLWbzjkl+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=go0HoJpMCMDS37lqZY/AWEAnteVK7SZ8Pu5nQ+9OUg2hBmxs6KzaThIisRqotOFis
	 RgsehbUgEef832IKkBFEMaGEHRUc1jjwNvC6cawb2MJulGBFhV2tKUamXv7PfMrpQZ
	 SyjCfFxscPStx+asUk7fVKQFrpf+9cEOHgBHDeDs=
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
To: zohar@linux.ibm.com,
	ebiederm@xmission.com,
	noodles@fb.com,
	bauermann@kolabnow.com,
	kexec@lists.infradead.org,
	linux-integrity@vger.kernel.org
Cc: code@tyhicks.com,
	nramas@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH v2 5/7] ima: suspend measurements while the buffer is being copied during kexec reboot
Date: Thu,  5 Oct 2023 11:26:00 -0700
Message-Id: <20231005182602.634615-6-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231005_112616_323463_530A4FF4 
X-CRM114-Status: GOOD (  17.55  )
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

If the new measurements are added to the IMA log while it is being 
being copied to the kexec buffer during kexec 'execute', it can miss
copying those new measurements to the kexec buffer, and the buffer can go
out of sync with TPM PCRs.  This could result in breaking the integrity
of the measurements after the kexec soft reboot to the new Kernel.

Add a check in the ima_add_template_entry() function not to measure
events and return from the function early when 'suspend_ima_measurements'
flag is set.

This ensures the consistency of the IMA measurement list while copying 
them to the kexec buffer.  When the 'suspend_ima_measurements' flag is
set, any new measurements will be ignored until the flag is unset.  This
allows the buffer to be safely copied without worrying about concurrent
modifications to the measurement list.  This is crucial for maintaining
the integrity of the measurements during a kexec soft reboot.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima_queue.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 9e7d1196006e..498b6b92f3f0 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -194,6 +194,19 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
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

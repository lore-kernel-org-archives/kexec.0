Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AF7C46CD3
	for <kexec@archiver.kernel.org>; Sat, 16 Dec 2023 01:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HyBUpCa40upK1Wap74zImk8YbmdXNEskTUMW/HLR6bE=; b=BX3zGyrbQ0pBDp
	df8cPEDu6xZTF2S/NAOQjatoo3iq1Kf10aSzke/AFD3jfgSDwTNtDiQOBXwVOzAADDxlMFyHpnupg
	xNYKIX/8Er01AvNiVDPU+PraQkVKeHmtYOxg7X3FTtc0OoPIPGHMiyY/p1NcPM1FKVt0AqPwisvXi
	Evm/vAQtKSM2ixRSQRSc8CiPLaiYjr2J60N3dn3W6eZf2RTOTC2HxY9A8uHmk2iwx6x7S46nNINj8
	oT+ZpoieVsvNg4f8it3MInuYVzSlk9mPauG88irv47Ct5gTnSCe5Fel83janDm98jCpd2DSVHmGVi
	ymNvNytWi42zTn/8gCsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rEJ9i-00546n-2A;
	Sat, 16 Dec 2023 01:07:50 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rEJ9e-00544h-0q
	for kexec@lists.infradead.org;
	Sat, 16 Dec 2023 01:07:47 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 30F9C20B3CC2;
	Fri, 15 Dec 2023 17:07:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 30F9C20B3CC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1702688860;
	bh=2IOw2XXOJ/lRQNX6HMUntrseQX7ML13OzSk1lyP6kFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V3FEDbdTk51T+KVYtJxwjl13Kg8iXAPKVPl3td9AhQHoPc/OE4TEWuzeLyvMEHQOz
	 PhqkdxOePFRhhx466L0EOOEhMU+5aNfgfXcQWxk68Q9fGhunFEwqVr4Iw27NefnU9T
	 Ue/UZEnfo15HpXR2GvKuE5bECHHxBeraTWqNMjn0=
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
Subject: [PATCH v3 5/7] ima: suspend measurements during buffer copy at kexec execute
Date: Fri, 15 Dec 2023 17:07:27 -0800
Message-Id: <20231216010729.2904751-6-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_170746_319774_A88B8EC9 
X-CRM114-Status: GOOD (  16.04  )
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

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F90CC04FE0
	for <kexec@archiver.kernel.org>; Tue,  1 Aug 2023 18:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C60FI0yyZAgGsBJL5h8FubSKc1SLHRUi5UMkXpyglzg=; b=y1RgAVMbCKfuDf
	5COTDwZcLVbWW2k6LMZ4YS3U9SKMEV7XMhrR5qc7pfDy/ENE/NwHwhveyVla8gngdcsu1sDEtJ0Lw
	UM1t7VIN65o6p0YNjkc6W4pptNepv9kDQCkLW7giggZ411ZhR7dYriR7B1iuSmy1I7M/7403HIzKZ
	aSL9kAP2RIb841KNKnb3OXR+AueerXm3y7WCVicnD5VwwQ6tm/vYXLMNUbErzQj2FCjBy+R0YG0jq
	H+NwYwvF5khBwOtgaijA5J4Nqr46+hcLVVahI5xx2LKEl39qApc2P/x/YslZocGqsHtyDVkVahIkD
	rcYWD75k8vhOHhl0djJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQty2-0030ns-1t;
	Tue, 01 Aug 2023 18:19:34 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQtxy-0030mJ-1w
	for kexec@lists.infradead.org;
	Tue, 01 Aug 2023 18:19:31 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id A88C7238AEA6;
	Tue,  1 Aug 2023 11:19:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A88C7238AEA6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1690913969;
	bh=UMsa/6D6amNcXhqqKgULTQeVgWNbTSj6Vc9o3LqSmOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=egYnxmFXUmAUrYzaMvhqMd5SZj4sz+H5N9yFX1xKDQkZxON3lo0KA07sHiGzJXMUM
	 xJaFYoGEKAw36wRXfIQnm3yIIuNViqGHzFkt0DWFWpq0ZI6fJd+3jXCb4ubf/lUyma
	 vAEhPC0vytGW551wjUAsccwqN44SHlAvINfeKrtc=
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
To: zohar@linux.ibm.com,
	noodles@fb.com,
	bauermann@kolabnow.com,
	ebiederm@xmission.com,
	bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	kexec@lists.infradead.org,
	linux-integrity@vger.kernel.org
Cc: code@tyhicks.com,
	nramas@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH 5/6] ima: measure TPM update counter at ima_init
Date: Tue,  1 Aug 2023 11:19:16 -0700
Message-Id: <20230801181917.8535-6-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230801_111930_659376_888675DE 
X-CRM114-Status: GOOD (  10.58  )
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

IMA log entries can be lost due to a variety of causes, such as code bugs
or error conditions, leading to a mismatch between TPM PCRs and
the IMA log.  Measuring TPM PCR update counter during ima_init would
provide a baseline counter for the number of times the TPM PCRs are
updated.  The remote attestation service can compare this baseline
counter with a subsequent measured one (e.g., post-kexec soft-boot) to
identify if there are any lost IMA log events.

Measure the TPM update counter at ima init.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima_init.c | 3 +++
 security/integrity/ima/ima_main.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 63979aefc95f..9bb18d6c2fd6 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -154,5 +154,8 @@ int __init ima_init(void)
 				  UTS_RELEASE, strlen(UTS_RELEASE), false,
 				  NULL, 0);
 
+	/* Measures TPM update counter at ima_init */
+	ima_measure_update_counter("ima_init_tpm_update_counter");
+
 	return rc;
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 1bcd45cc5a6a..93357c245e82 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1035,6 +1035,7 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 				   buf, size, "kexec-cmdline", KEXEC_CMDLINE, 0,
 				   NULL, false, NULL, 0);
 	fdput(f);
+
 }
 
 /**
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5881C02192
	for <kexec@archiver.kernel.org>; Mon,  3 Feb 2025 19:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0df9k6YmLXTRB5Kdzk0atr6aQfh11G9ejUhwNmP0edM=; b=qtWYhc5sA71GUYXCNmVrEjlChk
	aW5BgND6HdMNQj9seDK5XRajOFrMRBT3L7oKoHiRQtxAgesoKLvdCLjqOSHEvah6jKJLA4Eae+G1T
	LdKbUEi2a8yAkXW6Bc7xiloV7bFDR4uPxSYek/57YSBEM7/Frcr5SJPcMI271yOVHge0nYemylVrW
	Hi+AZqiWx0FKNmAZvEj5MWniL3nKeve5/OGqmdRPqpPEvOzoYjtG9E+mkrZ/bQJjlnHamEd8KvC2N
	ok20fUeiKTnXbFmDyXCiC0vNrncsvVv85vGI3N1PHHIBqUHHLfvE1ky6ewirMgmgKRhKVn+OuiRoy
	42uq2nug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tf1gH-0000000GMmK-1eqi;
	Mon, 03 Feb 2025 19:00:25 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tf1SZ-0000000GJgW-2Ckz
	for kexec@bombadil.infradead.org;
	Mon, 03 Feb 2025 18:46:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=0df9k6YmLXTRB5Kdzk0atr6aQfh11G9ejUhwNmP0edM=; b=mn6kvOGfMBaD9wEkyumCX0ND9T
	muzCQMR/R7kApv8LI3WVt6ifKy4oSf5JErptCOg2Z40u4pYTlvEsUOa9DG9UHHwHlXgDdVTGl81Fe
	SBxMElSFJKze5xz51E6dPiuciFm0Uq0zetcwSi0VEPWpYVG0pUOl/I1FbfZ6L8TaqSXx4ZmGvd3hU
	vEmxp6FMTM3whg5LvCrBh9ebIxOkE4h3hmAEdy494H887hnyKp4eUhASxZCKCS5gWT/wvntQkeY2b
	BhQLLziOjkb3dzo3fBf8bb/uEGSavztE1VoQ1SRQFy6GyIqjohSeQf4D/9N2aix2tCAnFw7Nu6FHz
	U5+Kev+w==;
Received: from linux.microsoft.com ([13.77.154.182])
	by desiato.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tf1SV-0000000G83R-2xdk
	for kexec@lists.infradead.org;
	Mon, 03 Feb 2025 18:46:14 +0000
Received: from localhost.localdomain (unknown [167.220.59.4])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7D0F3206AB71;
	Mon,  3 Feb 2025 10:46:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7D0F3206AB71
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738608366;
	bh=0df9k6YmLXTRB5Kdzk0atr6aQfh11G9ejUhwNmP0edM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=koy1D7J/Ezr+ZcS1IHBzVz/LIm8M///+rS0OT40MVyYJH4uxtP//4DNWQcBTIoK+n
	 Q6WN7Bs8Gkff08p9L3UDGzt1HHpv0+QVqUSd3JAjxLvmXa9FjzjKFS2Fg+BL5PmFFX
	 jaP0muZ4HAPi3sShAAxT6sAcVT6jLbME9Z0Ugw5o=
From: steven chen <chenste@linux.microsoft.com>
To: zohar@linux.ibm.com,
	stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com,
	roberto.sassu@huawei.com,
	eric.snowberg@oracle.com,
	ebiederm@xmission.com,
	paul@paul-moore.com,
	code@tyhicks.com,
	bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenste@linux.microsoft.com
Cc: madvenka@linux.microsoft.com,
	nramas@linux.microsoft.com,
	James.Bottomley@HansenPartnership.com
Subject: [PATCH v7 7/7] ima: measure kexec load and exec events as critical data
Date: Mon,  3 Feb 2025 10:45:58 -0800
Message-Id: <20250203184558.61367-8-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250203184558.61367-1-chenste@linux.microsoft.com>
References: <20250203184558.61367-1-chenste@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_184612_223244_1F3DB541 
X-CRM114-Status: GOOD (  12.06  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The amount of memory allocated at kexec load, even with the extra memory
allocated, might not be large enough for the entire measurement list.  The
indeterminate interval between kexec 'load' and 'execute' could exacerbate
this problem.

Define two new IMA events, 'kexec_load' and 'kexec_execute', to be 
measured as critical data at kexec 'load' and 'execute' respectively.
Report the allocated kexec segment size, IMA binary log size and the
runtime measurements count as part of those events.

These events, and the values reported through them, serve as markers in
the IMA log to verify the IMA events are captured during kexec soft
reboot.  The presence of a 'kexec_load' event in between the last two
'boot_aggregate' events in the IMA log implies this is a kexec soft
reboot, and not a cold-boot. And the absence of 'kexec_execute' event
after kexec soft reboot implies missing events in that window which
results in inconsistency with TPM PCR quotes, necessitating a cold boot
for a successful remote attestation.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
---
 security/integrity/ima/ima_kexec.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index c9c916f69ca7..0342ddfa9342 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -17,6 +17,8 @@
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
+#define IMA_KEXEC_EVENT_LEN 256
+
 static struct seq_file ima_kexec_file;
 static void *ima_kexec_buffer;
 static size_t kexec_segment_size;
@@ -36,6 +38,24 @@ static void ima_free_kexec_file_buf(struct seq_file *sf)
 	ima_reset_kexec_file(sf);
 }
 
+static void ima_measure_kexec_event(const char *event_name)
+{
+	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
+	size_t buf_size = 0;
+	long len;
+
+	buf_size = ima_get_binary_runtime_size();
+	len = atomic_long_read(&ima_htable.len);
+
+	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
+			"kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
+			"ima_runtime_measurements_count=%ld;",
+				kexec_segment_size, buf_size, len);
+
+	ima_measure_critical_data("ima_kexec", event_name, ima_kexec_event,
+					strlen(ima_kexec_event), false, NULL, 0);
+}
+
 static int ima_alloc_kexec_file_buf(size_t segment_size)
 {
 	/*
@@ -60,6 +80,7 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
 out:
 	ima_kexec_file.read_pos = 0;
 	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
+	ima_measure_kexec_event("kexec_load");
 
 	return 0;
 }
@@ -201,6 +222,8 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
 		return ret;
 	}
 
+	ima_measure_kexec_event("kexec_execute");
+
 	ret = ima_dump_measurement_list(&buf_size, &buf,
 					kexec_segment_size);
 
-- 
2.25.1



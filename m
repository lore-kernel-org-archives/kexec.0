Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08718E92729
	for <kexec@archiver.kernel.org>; Thu,  5 Oct 2023 18:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sqEz7nM1HSecgLk+SjPRdJ43kqBxNNvGRoVz1WwtUvc=; b=D46W81hdkAPNIa
	lkYU+elj/BNmkPZp5ZQgd9EZ5LJC9UN+nLPDIC9/1MyyWKOzpa8VVKPYu1jHKgEUKbEDrJPRTkEOE
	LrRxPljXA4qGvgcVzRmSU1OdfJuvefB0F18Qp+5qEeHpKuxdlmx7K0RKq4lyAciiQfGsYlToadzI3
	Vo4yHrSYy8vXztZUrAORZ/LgwFeF7Pg6npyzEkCEVF1q65pg11LCXr+u+oI1wDcEmsMHLEkHqdNr+
	CAZf7V/G+TW0y46y4kR9YbfW522cX+/16KyEXzzUShJ4S6gz9m0pQvT/juPY+R86pR7rcB8ieSK6C
	+UQGqc/g8dMiqHKQg/mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoT3G-004HUD-1o;
	Thu, 05 Oct 2023 18:26:22 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoT3A-004HRH-0L
	for kexec@lists.infradead.org;
	Thu, 05 Oct 2023 18:26:18 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 56F0320B74C8;
	Thu,  5 Oct 2023 11:26:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 56F0320B74C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1696530374;
	bh=ONPFQaah0h6Qnqt+reZDLhqeK6cEMyobvmiL4JTQPwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g+RGV187kcOPOb2HX1ww0wYPY37J26ztVbuioeuEk33iG+u0PvGcUg5Wrr+U6DFai
	 b1TXW8XvGSpWFEC6BDw1LzfeWeJOU/rTi8vNryDYwCv3D1QOLkpPUnbnsQG4nZfUUN
	 ijrhjYLOd/u0/gKSOjVCFkCzJSIULCxbjyrlPyoM=
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
Subject: [PATCH v2 7/7] ima: record log size at kexec load and execute
Date: Thu,  5 Oct 2023 11:26:02 -0700
Message-Id: <20231005182602.634615-8-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231005_112616_191454_5B5D46D2 
X-CRM114-Status: GOOD (  22.06  )
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

The window between kexec 'load' and 'execute' could be arbitrarily long.
Even with the large chunk of memory allocated at kexec 'load', it may
run out which would result in missing events in IMA log after the system
soft reboots to the new Kernel.  This would result in IMA measurements
getting out of sync with the TPM PCR quotes which would result in remote
attestation failing for that system.  There is currently no way for the
new Kernel to know if the IMA log TPM PCR quote out of sync problem is
because of the missing measurements during kexec.

Define two new IMA events, 'kexec_load' and 'kexec_execute', to be 
measured at kexec 'load' and 'execute' respectively.

IMA measures 'boot_aggregate' as the first event when the system boots - 
either cold boot or kexec soft boot.  In case when the system goes
through multiple soft reboots, the number of 'boot_aggregate' events in
IMA log corresponds to total number of boots (cold boot plus multiple
kexec soft reboots).  With this change, there would be additional 
'kexec_load' and 'kexec_execute' events in between the two 
'boot_aggregate' events.  In rare cases, when the system runs out of
memory during kexec soft reboot, 'kexec_execute' won't be copied since
its one of the very last event measured just before kexec soft reboot.
The absence of the event 'kexec_execute' in between the two 
boot_aggregate' events would signal the attestation service that the IMA
log on the system is out of sync with TPM PCR quotes and the system needs
to be cold booted for the remote attestation to succeed again.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima_kexec.c | 35 +++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 6cd5f46a7208..0f9c424fe808 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -17,6 +17,8 @@
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
+#define IMA_KEXEC_EVENT_LEN 128
+
 struct seq_file ima_kexec_file;
 struct ima_kexec_hdr ima_khdr;
 static void *ima_kexec_buffer;
@@ -34,6 +36,8 @@ void ima_clear_kexec_file(void)
 
 static int ima_alloc_kexec_buf(size_t kexec_segment_size)
 {
+	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
+
 	if ((kexec_segment_size == 0) ||
 	    (kexec_segment_size == ULONG_MAX) ||
 	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
@@ -64,6 +68,12 @@ static int ima_alloc_kexec_buf(size_t kexec_segment_size)
 	memset(&ima_khdr, 0, sizeof(ima_khdr));
 	ima_khdr.version = 1;
 
+	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
+		  "kexec_segment_size=%lu;", kexec_segment_size);
+
+	ima_measure_critical_data("ima_kexec", "kexec_load", ima_kexec_event,
+				  strlen(ima_kexec_event), false, NULL, 0);
+
 	return 0;
 }
 
@@ -198,6 +208,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 static int ima_update_kexec_buffer(struct notifier_block *self,
 				   unsigned long action, void *data)
 {
+	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
 	void *buf = NULL;
 	size_t buf_size;
 	bool resume = false;
@@ -213,9 +224,31 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
 		return NOTIFY_OK;
 	}
 
+	buf_size = ima_get_binary_runtime_size();
+	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
+		  "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;",
+		  kexec_segment_size, buf_size);
+
+	/*
+	 * This is one of the very last events measured by IMA before kexec
+	 * soft rebooting into the new Kernal.
+	 * This event can be used as a marker after the system soft reboots
+	 * to the new Kernel to check if there was sufficient memory allocated
+	 * at kexec 'load' to capture the events measured between the window
+	 * of kexec 'load' and 'execute'.
+	 * This event needs to be present in the IMA log, in between the two
+	 * 'boot_aggregate' events that are logged for the previous boot and
+	 * the current soft reboot. If it is not present after the system soft
+	 * reboots into the new Kernel, it would mean the IMA log is not
+	 * consistent with the TPM PCR quotes, and the system needs to be
+	 * cold-booted for the attestation to succeed again.
+	 */
+	ima_measure_critical_data("ima_kexec", "kexec_execute",
+				  ima_kexec_event, strlen(ima_kexec_event),
+				  false, NULL, 0);
+
 	ima_measurements_suspend();
 
-	buf_size = ima_get_binary_runtime_size();
 	ret = ima_dump_measurement_list(&buf_size, &buf,
 					kexec_segment_size);
 
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

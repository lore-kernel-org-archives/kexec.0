Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873E2C28B21
	for <kexec@archiver.kernel.org>; Tue,  4 Mar 2025 19:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7bpzaKJMyV3E8E00HZMPQxpAdeDwOCI+jQV79Yt99/0=; b=40p9yxJP4AqcDl4FmWzLvjU6UL
	ma6g5OUOo3AxoDZMXzZVSOsxFMpP/0iCoE01hqNMvLB8Hz1PTqdQa5bKjmEjoGRYtpd8ozilsyRsK
	OKPNgXNLY9Zz48hYn4Mu5oddvnSQz4yz6oXIwaOIHD0C9RPZ+lSicoDIgqDwoLjlGDnj5wMMl/ozy
	Iu5320Dwg7aTzZn2q3lfSRppk+2KnoU7wUFYBfgKjvrflibJCzYQXTffMAodXGQC9WZ4EOb572/mg
	eMkI6OdI5mkIv57/gY+fRSDP3A+7AP+qkN2Ffgv5821bA3lHMRW0LMcJP/+iQ5b7nExorzdGX/5+t
	ltQW5EPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpYH2-000000066Cw-16YX;
	Tue, 04 Mar 2025 19:49:52 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpXYe-00000005wx0-3R3k
	for kexec@lists.infradead.org;
	Tue, 04 Mar 2025 19:04:02 +0000
Received: from localhost.localdomain (unknown [167.220.59.4])
	by linux.microsoft.com (Postfix) with ESMTPSA id EE7E9210EAFB;
	Tue,  4 Mar 2025 11:03:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EE7E9210EAFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741115039;
	bh=7bpzaKJMyV3E8E00HZMPQxpAdeDwOCI+jQV79Yt99/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T7HQWhU3oXeIve/XuPEpI9rVt6c4VCA0J5gVMNjF5zkIri2rqUHhNsOqrqPZ6qke+
	 z5Dagl0YGKTiyXy0EG3B/B7uYI7v1nsQgcgnI5LQSi4TcSWbjqbdlYJChjdzXpNZg7
	 UD1WWd3Rit7W/1KNg6nq0FoV0buVSnfiH0koAUFw=
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
	linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com,
	nramas@linux.microsoft.com,
	James.Bottomley@HansenPartnership.com,
	bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com
Subject: [PATCH v9 7/7] ima: measure kexec load and exec events as critical data
Date: Tue,  4 Mar 2025 11:03:51 -0800
Message-Id: <20250304190351.96975-8-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250304190351.96975-1-chenste@linux.microsoft.com>
References: <20250304190351.96975-1-chenste@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250304_110400_904636_29C3FDA2 
X-CRM114-Status: GOOD (  15.74  )
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

These critical data events are displayed as hex encoded ascii in the
ascii_runtime_measurement_list.  Verifying the critical data hash requires 
calculating the hash of the decoded ascii string.  

For example, to verify the 'kexec_load' data hash:

sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements 
| grep  kexec_load | cut -d' ' -f 6 | xxd -r -p | sha256sum


To verify the 'kexec_execute' data hash:

sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements 
| grep kexec_execute | cut -d' ' -f 6 | xxd -r -p | sha256sum

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/ima/ima.h       |  6 ++++++
 security/integrity/ima/ima_kexec.c | 20 ++++++++++++++++++++
 security/integrity/ima/ima_queue.c |  5 +++++
 3 files changed, 31 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 4428fcf42167..1452c98242a4 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -240,6 +240,12 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 				   unsigned long flags, bool create);
 #endif
 
+#ifdef CONFIG_IMA_KEXEC
+void ima_measure_kexec_event(const char *event_name);
+#else
+static inline void ima_measure_kexec_event(const char *event_name) {}
+#endif
+
 /*
  * The default binary_runtime_measurements list format is defined as the
  * platform native format.  The canonical format is defined as little-endian.
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 9fb1bf5a592a..e40c6da4504c 100644
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
@@ -36,6 +38,23 @@ static void ima_free_kexec_file_buf(struct seq_file *sf)
 	ima_reset_kexec_file(sf);
 }
 
+void ima_measure_kexec_event(const char *event_name)
+{
+	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
+	size_t buf_size = 0;
+	long len;
+
+	buf_size = ima_get_binary_runtime_size();
+	len = atomic_long_read(&ima_htable.len);
+
+	int n = scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
+					"kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
+					"ima_runtime_measurements_count=%ld;",
+					kexec_segment_size, buf_size, len);
+
+	ima_measure_critical_data("ima_kexec", event_name, ima_kexec_event, n, false, NULL, 0);
+}
+
 static int ima_alloc_kexec_file_buf(size_t segment_size)
 {
 	/*
@@ -58,6 +77,7 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
 out:
 	ima_kexec_file.read_pos = 0;
 	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
+	ima_measure_kexec_event("kexec_load");
 
 	return 0;
 }
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 3dfd178d4292..6afb46989cf6 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -241,6 +241,11 @@ static int ima_reboot_notifier(struct notifier_block *nb,
 			       unsigned long action,
 			       void *data)
 {
+#ifdef CONFIG_IMA_KEXEC
+	if (action == SYS_RESTART && data && !strcmp(data, "kexec reboot"))
+		ima_measure_kexec_event("kexec_execute");
+#endif
+
 	ima_measurements_suspend();
 
 	return NOTIFY_DONE;
-- 
2.25.1



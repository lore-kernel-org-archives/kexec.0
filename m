Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624D2C3DA4A
	for <kexec@archiver.kernel.org>; Tue, 18 Mar 2025 01:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=evLBIs6rtcFkt9DDIKHTl8Kl84ENTBx9wiB3QZH+KPo=; b=fCtxmuiYHH2mgEzN4PI13ULujX
	IOpqxcjQdXk5wp9ZH08syrDQUNXMIZBKa9/cjbFuCn0BLE9tQ9+hr7f4ds3OyCVvG0KpEZwl32LQ6
	KnkGNzGgPbt6YSYUJkIdilm3Qy4hp6Jacp2NlOqOtkysEHLZCJLaEWEmRXVkzSxPLiyUnDC0oXQ8t
	ikUo+x188cFtMlQZ20i53p4ILluu7hTa65gVPK3W1z5exIB3M8IPQuZWjfX/JdmSm97GL8nOUyVrB
	3NbKAl4tiNiwRr/IDbFbqVGLTtXVWwaFs4GLDCcb5b3bGF1L3Xh3Va+90XNcRGUc1N6wcpRKQB1HQ
	4t3jEBCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuLOP-00000004JMn-42GO;
	Tue, 18 Mar 2025 01:05:17 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuLOO-00000004JLM-0ACD
	for kexec@lists.infradead.org;
	Tue, 18 Mar 2025 01:05:17 +0000
Received: from localhost.localdomain (unknown [131.107.147.236])
	by linux.microsoft.com (Postfix) with ESMTPSA id 292F3204601D;
	Mon, 17 Mar 2025 18:05:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 292F3204601D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742259915;
	bh=evLBIs6rtcFkt9DDIKHTl8Kl84ENTBx9wiB3QZH+KPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I416MuSYf98m6Mywzw+uyr272H+ws5gOQd6A2ClSeIuk+rS84SseHRlP6EVy/I0a4
	 JNUlZo7LMZb28z2E/CJhiRa3mTTNYPfEJGyTuTqSK0VPcJz+y6YCIAwBzxiUnOaHKZ
	 tMFBtEmWR+UdyVnnnrAeNZjTSvmcmNT6+36/PGR8=
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
Subject: [PATCH v10 1/8] ima: rename variable the ser_file "file" to "ima_kexec_file"
Date: Mon, 17 Mar 2025 18:04:39 -0700
Message-ID: <20250318010448.954-2-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318010448.954-1-chenste@linux.microsoft.com>
References: <20250318010448.954-1-chenste@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250317_180516_163429_02F7D2C2 
X-CRM114-Status: GOOD (  16.93  )
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

The name of the local variable "file" of type seq_file defined in the
ima_dump_measurement_list function is too generic. To better reflect the
purpose of the variable, rename it to "ima_kexec_file". This change will 
help improve code readability and maintainability by making the variable's
role more explicit.

The variable ima_kexec_file is indeed the memory allocated for copying IMA
measurement records. The ima_dump_measurement_list function calculates the 
actual memory occupied by the IMA logs and compares it with the allocated 
memory. If there is enough memory, it copies all IMA measurement records; 
otherwise, it does not copy any records, which would result in a failure
of remote attestation.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
---
 security/integrity/ima/ima_kexec.c | 39 ++++++++++++++++++------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 9d45f4d26f73..8567619889d1 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -15,33 +15,41 @@
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
+/*
+ * Copy the measurement list to the allocated memory
+ * compare the size of IMA measurement list with the size of the allocated memory
+ *    if the size of the allocated memory is not less than the size of IMA measurement list
+ *        copy the measurement list to the allocated memory.
+ *    else
+ *        return error
+ */
 static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 				     unsigned long segment_size)
 {
+	struct seq_file ima_kexec_file;
 	struct ima_queue_entry *qe;
-	struct seq_file file;
 	struct ima_kexec_hdr khdr;
 	int ret = 0;
 
 	/* segment size can't change between kexec load and execute */
-	file.buf = vmalloc(segment_size);
-	if (!file.buf) {
+	ima_kexec_file.buf = vmalloc(segment_size);
+	if (!ima_kexec_file.buf) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	file.file = NULL;
-	file.size = segment_size;
-	file.read_pos = 0;
-	file.count = sizeof(khdr);	/* reserved space */
+	ima_kexec_file.file = NULL;
+	ima_kexec_file.size = segment_size;
+	ima_kexec_file.read_pos = 0;
+	ima_kexec_file.count = sizeof(khdr);	/* reserved space */
 
 	memset(&khdr, 0, sizeof(khdr));
 	khdr.version = 1;
 	/* This is an append-only list, no need to hold the RCU read lock */
 	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
-		if (file.count < file.size) {
+		if (ima_kexec_file.count < ima_kexec_file.size) {
 			khdr.count++;
-			ima_measurements_show(&file, qe);
+			ima_measurements_show(&ima_kexec_file, qe);
 		} else {
 			ret = -EINVAL;
 			break;
@@ -55,23 +63,24 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 	 * fill in reserved space with some buffer details
 	 * (eg. version, buffer size, number of measurements)
 	 */
-	khdr.buffer_size = file.count;
+	khdr.buffer_size = ima_kexec_file.count;
 	if (ima_canonical_fmt) {
 		khdr.version = cpu_to_le16(khdr.version);
 		khdr.count = cpu_to_le64(khdr.count);
 		khdr.buffer_size = cpu_to_le64(khdr.buffer_size);
 	}
-	memcpy(file.buf, &khdr, sizeof(khdr));
+	memcpy(ima_kexec_file.buf, &khdr, sizeof(khdr));
 
 	print_hex_dump_debug("ima dump: ", DUMP_PREFIX_NONE, 16, 1,
-			     file.buf, file.count < 100 ? file.count : 100,
+			     ima_kexec_file.buf, ima_kexec_file.count < 100 ?
+			     ima_kexec_file.count : 100,
 			     true);
 
-	*buffer_size = file.count;
-	*buffer = file.buf;
+	*buffer_size = ima_kexec_file.count;
+	*buffer = ima_kexec_file.buf;
 out:
 	if (ret == -EINVAL)
-		vfree(file.buf);
+		vfree(ima_kexec_file.buf);
 	return ret;
 }
 
-- 
2.25.1



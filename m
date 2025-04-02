Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93C5C3601B
	for <kexec@archiver.kernel.org>; Wed,  2 Apr 2025 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h/cpgKcbrvyKJYGjsn7+e/Tvw7I5+jxPdp1ilsIXavc=; b=kS147HwuWSuXtH5ZZVqDBBoDk3
	e5Ztu4w4R/JaFmIa7QcDLt7pOFAMZ/pq0xk+EcPzdzh147Cpump//7E16+iDEBuzZ/+cJiphCitLx
	rWd4kzjQQuo14ukeBzrT0nZCYF0/0yWoKvi4/k3IGG0RaqBGr5AGnt7ofk5mYD8Z2mcVCaD3lvF7q
	oaGfBWNQ5jLZ8fHirqNgVkxTUE2cp458axt+58SClv0shi9IcPJ5Q2zG3R2FpmyhhfpjwRkI3NiJ+
	n4dduo5NvQn/scmicVoK2r6Ku45NTajeJ9QJw8h9E3CjiPU5lDAXMsjmKK4DE1jZah0K8e2L3ayoK
	skpMukJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzxZD-00000006917-3Vfv;
	Wed, 02 Apr 2025 12:51:39 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzxVL-0000000686u-00aL
	for kexec@lists.infradead.org;
	Wed, 02 Apr 2025 12:47:40 +0000
Received: from DESKTOP-VOT081N.hsd1.ga.comcast.net (unknown [20.114.144.49])
	by linux.microsoft.com (Postfix) with ESMTPSA id 219FD2025659;
	Wed,  2 Apr 2025 05:47:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 219FD2025659
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743598058;
	bh=h/cpgKcbrvyKJYGjsn7+e/Tvw7I5+jxPdp1ilsIXavc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jAILEI5pItipCfyuKGVNeMXN1b9ysS7Iw139vrqnCCH1ygchjkRpoJP5O7C1+cH4N
	 4kqeT2Zu5SngVoo3Rb8/ijhtnav0K3bO+MU6yAKnFh9jYlnLFGRFRTY19Cm2ezgHCa
	 HgUTgeLPcymBB01YjkL7CRb0OZMNCKPSHZUkyjfU=
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
Subject: [PATCH v11 1/9] ima: rename variable the set_file "file" to "ima_kexec_file"
Date: Wed,  2 Apr 2025 05:47:14 -0700
Message-ID: <20250402124725.5601-2-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250402124725.5601-1-chenste@linux.microsoft.com>
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_054739_087044_B85C3056 
X-CRM114-Status: GOOD (  16.52  )
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

The current kernel behavior is IMA measurements snapshot is taken at
kexec 'load' and not at kexec 'execute'. IMA log is then carried
over to the new kernel after kexec 'execute'. However, the time gap
between kexec load and kexec reboot can be very long. During this
time window, new events extended into TPM PCRs miss the chance
to be carried over to the second kernel.
 
To address the above, the following approach is proposed:
  - Allocate the necessary buffer during the kexec load phase.
  - Populate this buffer with the IMA measurements during
    the kexec execute phase.

In the current implementation, a local variable "file" of type seq_file
is used in the API ima_dump_measurement_list() to store the IMA measurements
to be carried over across kexec system call. To make this buffer accessible
at kexec 'execute' time, rename it to "ima_kexec_file" before making it
a file variable to better reflect its purpose.

Renaming the local variable "file" of type seq_file defined in the 
ima_dump_measurement_list function to "ima_kexec_file" will improve code
readability and maintainability by making the variable's role more explicit.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/ima/ima_kexec.c | 31 +++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 9d45f4d26f73..650beb74346c 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -18,30 +18,30 @@
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
@@ -55,23 +55,24 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
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



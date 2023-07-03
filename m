Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5E1C001B3
	for <kexec@archiver.kernel.org>; Mon,  3 Jul 2023 21:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5d2Qx1Iniz0ilEDrJaHyyisWkdu3nsnwidsqwjWfW84=; b=IU/G0NMaw3Qk0C
	uj2cWXyAIgl4le+uPEEEV5EblZexjzHoUG1nEu7u4CRKqnjxn5qi8Lzdif1v1uzm8wTe+7N6sriJc
	9/+szbRHCrsaRO2z74TV5FSo542UmBkDN5/5Kcnyzh0zv07aJCrTIMA5bGWxyXJ2BcrJGV5OIHvSW
	rOgSxv1BfyOlLtUQzByuyxLjEB8K92oZwVoH0p1vSy8TeQlkWSsEkFZJdi3NQiO0YozEpUAFI20cb
	u4BdyBpj2AxbqZlXtea/+oqGUW8LqpXQVTB/pQKbUfr9/zYE9WXflerBJ4YFoyfLeudo6d6z2esDF
	lsJe3g2OZSHO+QmwqyPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGRXz-00BVxV-1R;
	Mon, 03 Jul 2023 21:57:27 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGRXu-00BVuK-0v
	for kexec@lists.infradead.org;
	Mon, 03 Jul 2023 21:57:23 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id D099320C08FE;
	Mon,  3 Jul 2023 14:57:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D099320C08FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1688421440;
	bh=qcx5Aa65d/0M8PqhuBesEv2N4gHSQORRxOZKyGZ74F8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r5u2DuzGdZuk9Iw/VerUCmS8YLz6jLTt7JRHgqgwVLYLILLT6VB/MUzKb5f+tNL/o
	 gaVYhG6pyaoUi/Puv79U/15cRH6AWLj6sATN4hVZxSdgboEezHP2xRMLb8zfceyZvH
	 NxyMyU//JHEwsjnGRh8KbT7jEkt1bhpCcffqM6OA=
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
To: zohar@linux.ibm.com,
	noodles@fb.com,
	bauermann@kolabnow.com,
	kexec@lists.infradead.org,
	linux-integrity@vger.kernel.org
Cc: code@tyhicks.com,
	nramas@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH 07/10] ima: remove function ima_dump_measurement_list
Date: Mon,  3 Jul 2023 14:57:06 -0700
Message-Id: <20230703215709.1195644-8-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_145722_345049_5DA5A7B7 
X-CRM114-Status: GOOD (  14.11  )
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

The ima_dump_measurement_list function was designed to iterate over the
IMA measurement list and store each entry into a buffer.  The buffer,
along with its size, would be returned to the caller.  However, the
function is no longer required in the IMA subsystem.  It previously served
to dump the measurement list during the kexec 'load' operation, but this
functionality has been replaced by an alternative approach in this patch
series.

Remove the unused ima_dump_measurement_list function from the IMA
subsystem, to ensure a cleaner and more maintainable code.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima_kexec.c | 58 ------------------------------
 1 file changed, 58 deletions(-)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 224d88ccfe85..424930085c18 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -115,64 +115,6 @@ static int ima_populate_buf_at_kexec_execute(unsigned long *buffer_size, void **
 }
 
 
-static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
-				     unsigned long segment_size)
-{
-	struct ima_queue_entry *qe;
-	struct seq_file file;
-	struct ima_kexec_hdr khdr;
-	int ret = 0;
-
-	/* segment size can't change between kexec load and execute */
-	file.buf = vmalloc(segment_size);
-	if (!file.buf) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	file.size = segment_size;
-	file.read_pos = 0;
-	file.count = sizeof(khdr);	/* reserved space */
-
-	memset(&khdr, 0, sizeof(khdr));
-	khdr.version = 1;
-	list_for_each_entry_rcu(qe, &ima_measurements, later) {
-		if (file.count < file.size) {
-			khdr.count++;
-			ima_measurements_show(&file, qe);
-		} else {
-			ret = -EINVAL;
-			break;
-		}
-	}
-
-	if (ret < 0)
-		goto out;
-
-	/*
-	 * fill in reserved space with some buffer details
-	 * (eg. version, buffer size, number of measurements)
-	 */
-	khdr.buffer_size = file.count;
-	if (ima_canonical_fmt) {
-		khdr.version = cpu_to_le16(khdr.version);
-		khdr.count = cpu_to_le64(khdr.count);
-		khdr.buffer_size = cpu_to_le64(khdr.buffer_size);
-	}
-	memcpy(file.buf, &khdr, sizeof(khdr));
-
-	print_hex_dump_debug("ima dump: ", DUMP_PREFIX_NONE, 16, 1,
-			     file.buf, file.count < 100 ? file.count : 100,
-			     true);
-
-	*buffer_size = file.count;
-	*buffer = file.buf;
-out:
-	if (ret == -EINVAL)
-		vfree(file.buf);
-	return ret;
-}
-
 /*
  * Called during kexec_file_load so that IMA can add a segment to the kexec
  * image for the measurement list for the next kernel.
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

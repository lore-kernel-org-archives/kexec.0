Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCE5EB64DC
	for <kexec@archiver.kernel.org>; Mon,  3 Jul 2023 21:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S4B4Y4tBlm7w/ooitECDLT7bdJG7ZGuu3D7bhmRHomc=; b=x+y5MGHDc/Ooaj
	W8VqXqXpd+JB3rjbVZ9vMcE3BTiFtnU/CX5W4tXGqJS30gfq7xncwiPwTw5NCIB5QBky3v8ALbwuS
	ZwXZj+Kr8PyFVwUv5sVDB7CJzksqmZu1V16j2J6HNYrT9wCY24W1+pJfaba5fVHjcL2wDVKl8Z/5e
	d94ngllNB9ijeFi5G2v9WMU5xC7Vi8uqK3h7YAtat2sJ9knClB2+aNHGGlLbHb1xAz4Xp0B6GR6ND
	vqzPwjvD2ZNIVWDTv2BcE4vt0+J8rDt7TS5R2uCKF1bRla9q6x21SpNcU6A1xHh+zHfFW0rpKFeJO
	12neg/GwWJA14A6kuWXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGRXx-00BVwd-1Y;
	Mon, 03 Jul 2023 21:57:25 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGRXs-00BVsT-0E
	for kexec@lists.infradead.org;
	Mon, 03 Jul 2023 21:57:22 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 17AD920C08E6;
	Mon,  3 Jul 2023 14:57:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 17AD920C08E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1688421438;
	bh=QSvlPzRxeFbeULzyjZwN/RPvVC6e2A3pn0e54sScUOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TBh2Sg92sT83le5olP6H2y5ygM6Vg6+PyI6OxTsBV0YLUk+L2zOPcZZdKHqlORane
	 W19FFtESmi88heWz0c0dtaXJDq8J/+rg4Pwv9avmAcKEe2GqqcTXOm0fnW3tYcomhU
	 edSdZsYhiTK7eiIBB3wE8dVxKHSx2FkeJOeWBWGM=
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
To: zohar@linux.ibm.com,
	noodles@fb.com,
	bauermann@kolabnow.com,
	kexec@lists.infradead.org,
	linux-integrity@vger.kernel.org
Cc: code@tyhicks.com,
	nramas@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH 02/10] ima: implement function to populate buffer at kexec execute
Date: Mon,  3 Jul 2023 14:57:01 -0700
Message-Id: <20230703215709.1195644-3-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_145720_149780_32D246BA 
X-CRM114-Status: GOOD (  12.90  )
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

There is no existing IMA functionality to just populate the buffer at
kexec execute with IMA measurements.

Implement a function to iterate over ima_measurements and populate the
ima_kexec_file buffer.  After the loop, populate ima_khdr with buffer
details (version, buffer size, number of measurements).  Copy the ima_khdr
data into ima_kexec_file.buf and update buffer_size and buffer.

The patch assumes that the ima_kexec_file.size is sufficient to hold all
the measurements.  It returns an error and does not handle scenarios where
additional space might be needed.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima_kexec.c | 52 ++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 48a683874044..858b67689701 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -62,6 +62,58 @@ static int ima_allocate_buf_at_kexec_load(void)
 	return 0;
 }
 
+static int ima_populate_buf_at_kexec_execute(unsigned long *buffer_size, void **buffer)
+{
+	struct ima_queue_entry *qe;
+	int ret = 0;
+
+	/*
+	 * Ensure the kexec buffer is large enough to hold ima_khdr
+	 */
+	if (ima_kexec_file.size < sizeof(ima_khdr)) {
+		pr_err("%s: Kexec buffer size too low to hold ima_khdr\n",
+			__func__);
+		ima_clear_kexec_file();
+		return -ENOMEM;
+	}
+
+	list_for_each_entry_rcu(qe, &ima_measurements, later) {
+		if (ima_kexec_file.count < ima_kexec_file.size) {
+			ima_khdr.count++;
+			ima_measurements_show(&ima_kexec_file, qe);
+		} else {
+			ret = -ENOMEM;
+			pr_err("%s: Kexec ima_measurements buffer too small\n",
+				__func__);
+			break;
+		}
+	}
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * fill in reserved space with some buffer details
+	 * (eg. version, buffer size, number of measurements)
+	 */
+	ima_khdr.buffer_size = ima_kexec_file.count;
+	if (ima_canonical_fmt) {
+		ima_khdr.version = cpu_to_le16(ima_khdr.version);
+		ima_khdr.count = cpu_to_le64(ima_khdr.count);
+		ima_khdr.buffer_size = cpu_to_le64(ima_khdr.buffer_size);
+	}
+
+	memcpy(ima_kexec_file.buf, &ima_khdr, sizeof(ima_khdr));
+	*buffer_size = ima_kexec_file.count;
+	*buffer = ima_kexec_file.buf;
+
+out:
+	if (ret < 0)
+		ima_clear_kexec_file();
+
+	return ret;
+}
+
+
 static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 				     unsigned long segment_size)
 {
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

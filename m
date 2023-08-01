Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65692C04FE2
	for <kexec@archiver.kernel.org>; Tue,  1 Aug 2023 18:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sQzrFFfzNmW32WawHSgvNlijwF/Hu77sS800jHFK5VA=; b=4/aeuzRWYyxu2U
	bcSC0//KoDVhgxE5tTTsWbN8yYL92iIIATcFVX13NVzGBqZkAH76UuTyC2fsI/0nfzuPlGqHIS73a
	5QQGCxBWx8mFxs18HGyGyj7g3j3C3NHXP1Es90ZLLVt6W72bEQ7vwcsOXLmuFX93ylMYL0sOGvoto
	KFwDG9uiUYYKL/TlBZPMi8J5K3jV/sEzaFu+vPs8090ScIcREyfEbNwn2z5NySiN8bP8DEnFQD/1J
	fH8AFjmPXdjBOcBE//IFuQ+dSe0AV7K/cZBPq/V/5jdB+Uw2sjpbUDmXdVswWFyNZkwUxKZwJ279U
	4JAzdPq57nJKskucm4sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQtxz-0030mt-2T;
	Tue, 01 Aug 2023 18:19:31 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQtxw-0030kd-16
	for kexec@lists.infradead.org;
	Tue, 01 Aug 2023 18:19:30 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 99EEE238AE9C;
	Tue,  1 Aug 2023 11:19:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 99EEE238AE9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1690913966;
	bh=8ydQCAOPOcf0m6nyFkBYLJu31rgHvyoufSpVxcSoJOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nTQs58MKcYI5m8cZi/KfepiNoc+9Qzhe8vHJiHCzwb1zY3l/8Lg/Jrs1O68GhFuAX
	 LAyY8YhGdjR3djBs0Ot+of/N6uUFngUguWtamjN0HGQ05U7AAXOGi29drdHbumARAp
	 FmLnw54tQJmRZEShydnAXu3RUCi6cIsbTLMXHINU=
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
Subject: [PATCH 1/6] tpm: implement TPM2 function to get update counter
Date: Tue,  1 Aug 2023 11:19:12 -0700
Message-Id: <20230801181917.8535-2-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230801_111928_449362_BFA92131 
X-CRM114-Status: GOOD (  15.66  )
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

The TPM2_PCR_Read command returns TPM2_PCR_Read Response struct[1].  It
contains pcrUpdateCounter member which contains the current value of TPM
PCR update counter.  The update counter provides the number of times the
PCRs are updated, which is essential for tracking changes and verifying
system integrity.  Thus, subsystems (like IMA) should measure
pcrUpdateCounter value.  Although tpm2_pcr_read_out struct is returned
by tpm2_pcr_read(), it is not used by it's caller function tpm_pcr_read().
Further, TPM2_PCR_Read Response struct and pcrUpdateCounter is not
available in tpm1_pcr_read().

PcrUpdateCounter is only needed in a specific case (IMA for measurements).
Changing tpm_pcr_read() and tpm2_pcr_read() function signature to return
tpm2_pcr_read_out struct would be a more disruptive change, since these
functions are used elsewhere too.  Creating separate functions to get
pcrUpdateCounter when needed would be a cleaner approach.

Add a function, 'tpm2_pcr_get_update_counter()' to retrieve
the update counter for a given PCR index and algorithm ID on a TPM2 chip.

This function complements existing TPM functionalities such as reading
and extending PCRs, and enhances the ability to monitor PCR status
in the Linux Kernel. 

[1] https://trustedcomputinggroup.org/wp-content/uploads/TCG_TPM2_r1p59_Part3_Commands_pub.pdf
Section 22.4.2, Page 206.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 drivers/char/tpm/tpm.h      |  3 +++
 drivers/char/tpm/tpm2-cmd.c | 48 +++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 830014a26609..60489f21d3bd 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -288,6 +288,9 @@ static inline void tpm_add_ppi(struct tpm_chip *chip)
 int tpm2_get_timeouts(struct tpm_chip *chip);
 int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 		  struct tpm_digest *digest, u16 *digest_size_ptr);
+int tpm2_pcr_get_update_counter(struct tpm_chip *chip,
+				u32 pcr_idx, u16 alg_id,
+				u32 *update_counter);
 int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		    struct tpm_digest *digests);
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 93545be190a5..55f4e102289a 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -216,6 +216,54 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 	return rc;
 }
 
+/**
+ * tpm2_pcr_get_update_counter() - gets an update counter value for a PCR bank
+ * @chip: TPM chip to use
+ * @pcr_idx: PCR index used to retrieve the update counter
+ * @alg_id:	alg id used to retrieve the update counter
+ * @update_counter: output update counter value
+ *
+ * Return: Same as with tpm_transmit_cmd.
+ */
+int tpm2_pcr_get_update_counter(struct tpm_chip *chip,
+				u32 pcr_idx, u16 alg_id, u32 *update_counter)
+{
+	int rc;
+	struct tpm_buf buf;
+	struct tpm2_pcr_read_out *read_out;
+	u8 pcr_select[TPM2_PCR_SELECT_MIN] = {0};
+
+	if (pcr_idx >= TPM2_PLATFORM_PCR)
+		return -EINVAL;
+
+	if (!update_counter)
+		return -EINVAL;
+
+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_PCR_READ);
+	if (rc)
+		return rc;
+
+	pcr_select[pcr_idx >> 3] = 1 << (pcr_idx & 0x7);
+
+	tpm_buf_append_u32(&buf, 1);
+	tpm_buf_append_u16(&buf, alg_id);
+	tpm_buf_append_u8(&buf, TPM2_PCR_SELECT_MIN);
+	tpm_buf_append(&buf, (const unsigned char *)pcr_select,
+		       sizeof(pcr_select));
+
+	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to read a pcr value");
+	if (rc)
+		goto out;
+
+	read_out = (struct tpm2_pcr_read_out *)&buf.data[TPM_HEADER_SIZE];
+
+	*update_counter = be32_to_cpu(read_out->update_cnt);
+
+out:
+	tpm_buf_destroy(&buf);
+	return rc;
+}
+
 struct tpm2_null_auth_area {
 	__be32  handle;
 	__be16  nonce_size;
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A71BC48BF0
	for <kexec@archiver.kernel.org>; Wed, 14 Feb 2024 22:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MoFuwNDFxvy+NOWen4uCWR8n23z514akKFDWNfaJVEk=; b=RPnC2lK728rNnx
	BohBoY9JP5QDqZDxHhn/2arrvtseHJECbhNgsATbL56AeRo6CfJVvou6xcCxP+4my605+U9JMhmZy
	1jpfBNOfDhOajt7sZP6bBR+3dYVARCajkjLhZEI5w7dF7nyN+tKtfpMT+Wl5M6xPex/tpE9rlsuVH
	fc4+GBGYtymnjDrAnyNJaac951POEtdDxCrqG4njnU7mF9l3dIzAm1IKAnBodXwTON9zWz8Yfkear
	p/Ng0qupHoqFeXRdsPRK+eC6mYHvcvs8dz4c2U2+j7EV6c/BNbwNHQXBJur/dkvwe9RlZAOS9D3MQ
	VZl34a0aFBwNVXMBkvpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raNro-0000000ERmj-3IIw;
	Wed, 14 Feb 2024 22:36:36 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raNrn-0000000ERl9-2APo
	for kexec@bombadil.infradead.org;
	Wed, 14 Feb 2024 22:36:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=b4oJ7O5uXtHdoQDNZitFBZAfxacBiAtRwCnCravNnwU=; b=wBaLiT/EmjzCNjqEqD3d2v6kKQ
	HD714lpYUDPUdFyluuSZRRZixqIG0G0Qf2pZ/S/eDRxYOSmmeLPZX8Jb+VzBMNGclbCtCcTTDNzMi
	jNs1mkjxM7FkNUaCxkgyphoRvhexa4wUVMcqTujYk7n3vT2OH6amoKRNzrOUF48qvGrnOwCnvL0yg
	iZ6Ol9YUZ0E/whXxwtO4qKj1RaKg9P9AJaRB+UpD9l59I8Y5NZeIiBwjfYZT1NX+cFldlUbSAo3TF
	sDtOE8Bc4T0dtprfvn+NY8nDNceKxJCPjYCy/E/dsYFcRCjDgZi046iQqYz8bQDfcO97vyH87khCY
	UcLiKleA==;
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by casper.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raNri-00000000BNj-2sZo
	for kexec@lists.infradead.org;
	Wed, 14 Feb 2024 22:36:34 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41ELibl8028692;
	Wed, 14 Feb 2024 22:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=b4oJ7O5uXtHdoQDNZitFBZAfxacBiAtRwCnCravNnwU=;
 b=X95W3c9SM1DlouEOCXta15LZI489m/283wE5mRGW5HADODGoiqwBtIHabYBMiLoJ6eTq
 1mIFbMwol4ipetdqI6lWeLrrY/J1J6hKFI/Q7xbO5X6yzTPq1tRijPQHAD2vyClJAv0O
 b8J3WqyxoB2BdcHxIcfpmN5IuLBrvVoI4nGURUb0/s1wc3H1yzyRmDsr5fWjJYjRAPz3
 ZisO/IvVUZ/EghzBz6br5af5LqWuKne9U6cJ2z5DTrWv4XhGj0n3tOHHxWHnricNutWN
 OS6RtpIxJwceBcY08PXwtJ44dKuCoyXnPZT8YizjDmArNCnIqvrBoYWchphWi9scAQxO bA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w91f00sry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 22:31:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41ELexle000607;
	Wed, 14 Feb 2024 22:31:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk9n7ew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 14 Feb 2024 22:31:44 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41EMVTVI004281;
	Wed, 14 Feb 2024 22:31:43 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk9n72r-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 14 Feb 2024 22:31:43 +0000
From: Ross Philipson <ross.philipson@oracle.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org
Cc: ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v8 12/15] tpm: Add ability to set the preferred locality the TPM chip uses
Date: Wed, 14 Feb 2024 14:18:44 -0800
Message-Id: <20240214221847.2066632-13-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240214221847.2066632-1-ross.philipson@oracle.com>
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_14,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402140170
X-Proofpoint-ORIG-GUID: 6u0qho0pdR5oLqVesCM1T1HwwPG9_4kP
X-Proofpoint-GUID: 6u0qho0pdR5oLqVesCM1T1HwwPG9_4kP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240214_223632_496681_2C48972E 
X-CRM114-Status: GOOD (  21.96  )
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

Curently the locality is hard coded to 0 but for DRTM support, access
is needed to localities 1 through 4.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 drivers/char/tpm/tpm-chip.c      | 24 +++++++++++++++++++++++-
 drivers/char/tpm/tpm-interface.c | 15 +++++++++++++++
 drivers/char/tpm/tpm.h           |  1 +
 include/linux/tpm.h              | 10 ++++++++++
 4 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 42b1062e33cd..e4d591e8857b 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -44,7 +44,7 @@ static int tpm_request_locality(struct tpm_chip *chip)
 	if (!chip->ops->request_locality)
 		return 0;
 
-	rc = chip->ops->request_locality(chip, 0);
+	rc = chip->ops->request_locality(chip, chip->pref_locality);
 	if (rc < 0)
 		return rc;
 
@@ -143,6 +143,27 @@ void tpm_chip_stop(struct tpm_chip *chip)
 }
 EXPORT_SYMBOL_GPL(tpm_chip_stop);
 
+/**
+ * tpm_chip_preferred_locality() - set the TPM chip preferred locality to open
+ * @chip:	a TPM chip to use
+ * @locality:   the preferred locality
+ *
+ * Return:
+ * * true      - Preferred locality set
+ * * false     - Invalid locality specified
+ */
+bool tpm_chip_preferred_locality(struct tpm_chip *chip, int locality)
+{
+	if (locality < 0 || locality >=TPM_MAX_LOCALITY)
+		return false;
+
+	mutex_lock(&chip->tpm_mutex);
+	chip->pref_locality = locality;
+	mutex_unlock(&chip->tpm_mutex);
+	return true;
+}
+EXPORT_SYMBOL_GPL(tpm_chip_preferred_locality);
+
 /**
  * tpm_try_get_ops() - Get a ref to the tpm_chip
  * @chip: Chip to ref
@@ -368,6 +389,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
 	}
 
 	chip->locality = -1;
+	chip->pref_locality = 0;
 	return chip;
 
 out:
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 66b16d26eecc..7a758c6d6d09 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -273,6 +273,21 @@ int tpm_is_tpm2(struct tpm_chip *chip)
 }
 EXPORT_SYMBOL_GPL(tpm_is_tpm2);
 
+/**
+ * tpm_preferred_locality() - set the TPM chip preferred locality to open
+ * @chip:	a TPM chip to use
+ * @locality:   the preferred locality
+ *
+ * Return:
+ * * true      - Preferred locality set
+ * * false     - Invalid locality specified
+ */
+bool tpm_preferred_locality(struct tpm_chip *chip, int locality)
+{
+	return tpm_chip_preferred_locality(chip, locality);
+}
+EXPORT_SYMBOL_GPL(tpm_preferred_locality);
+
 /**
  * tpm_pcr_read - read a PCR value from SHA1 bank
  * @chip:	a &struct tpm_chip instance, %NULL for the default chip
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 61445f1dc46d..389b117e68c2 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -267,6 +267,7 @@ static inline void tpm_msleep(unsigned int delay_msec)
 int tpm_chip_bootstrap(struct tpm_chip *chip);
 int tpm_chip_start(struct tpm_chip *chip);
 void tpm_chip_stop(struct tpm_chip *chip);
+bool tpm_chip_preferred_locality(struct tpm_chip *chip, int locality);
 struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
 
 struct tpm_chip *tpm_chip_alloc(struct device *dev,
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 4ee9d13749ad..a61d4e5e4b2d 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -116,6 +116,12 @@ struct tpm_chip_seqops {
 	const struct seq_operations *seqops;
 };
 
+/*
+ * The maximum locality (0 - 4) for a TPM, as defined in section 3.2 of the
+ * Client Platform Profile Specification.
+ */
+#define TPM_MAX_LOCALITY		4
+
 struct tpm_chip {
 	struct device dev;
 	struct device devs;
@@ -170,6 +176,9 @@ struct tpm_chip {
 
 	/* active locality */
 	int locality;
+
+	/* preferred locality - default 0 */
+	int pref_locality;
 };
 
 #define TPM_HEADER_SIZE		10
@@ -421,6 +430,7 @@ static inline u32 tpm2_rc_value(u32 rc)
 #if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
 
 extern int tpm_is_tpm2(struct tpm_chip *chip);
+extern bool tpm_preferred_locality(struct tpm_chip *chip, int locality);
 extern __must_check int tpm_try_get_ops(struct tpm_chip *chip);
 extern void tpm_put_ops(struct tpm_chip *chip);
 extern ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
-- 
2.39.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1579CC25B76
	for <kexec@archiver.kernel.org>; Fri, 31 May 2024 01:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6aT7bPoDioxQnOcvD0X2d9KHwcONJH03F82+MqO049o=; b=sbRRfFglaAGqtd
	KQBD5MKZ6nPVUAjBIguV/kt9bPxkWLaiIaDZKhdFkYIbw1rE5oOf0ueRbXs2aPlbq+k9w0Gwpf3td
	YUvnA4fEWzRjj7P0Mf/B1l/iuIy+C/JBbTIUmKRt0lJ5hB1AqUpRFaZu8BI8CIsA1Ua17QWIRZSaB
	F4eMlLDKAeMDCSXgjTwwPJCjOsJGSAKdmpJuf1NtDuKL7Z9lpwG10VeqSbLAVId4UhtQB8WluSHPy
	ldps4ynVsrQRVVlttW1Osmis89mQZE1lK5X0zn6e3OTADhAv05dqgXv7HEGPyo/XHhl/0NbRbWA9w
	dg0kB/DBp3FuBPTLwTvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCr8y-00000008usG-14zt;
	Fri, 31 May 2024 01:33:20 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCr8v-00000008upt-2gU4
	for kexec@bombadil.infradead.org;
	Fri, 31 May 2024 01:33:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=2YvT0TILGIfIbg/Mf8bVNNnQ5vMJnrTusgpdhYObAJ4=; b=WTq/6ZhJkNRKSJFfEEFY+yEnC5
	sRkUaOGx55q79OAlgy16V+JK47Ndak38Q106AWz8pa+fJ/P9puJWFlQi99YdvlJUf3EVIEBuEd67g
	QUZoqA7mnRKRVSjXIrHNhl4Awzb4z98E9WB38BR3i12V38vQBA9FNF5/+8+vNNpKS8CSW3ow+1Vvl
	mgncag7A/1W8uEe+T+YKnmG9xPMmm7WmPJ2LerCNKmvAUgKAdldn4Wvj30gYmPGAB/XBOtRnNEhiL
	PthL5DxuFI4vn0NCVIjmW3lwLKcBYInEk94h1JlxGHuIDG4zFrTHzs7vBCLSKM1hZUbRaktpumMRT
	kEaw0o6g==;
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCr8a-0000000EiDr-0vRO
	for kexec@lists.infradead.org;
	Fri, 31 May 2024 01:33:00 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44UFPhcS001872;
	Fri, 31 May 2024 01:31:31 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:date:from:in-reply-to:message-i?=
 =?UTF-8?Q?d:mime-version:references:subject:to;_s=3Dcorp-2023-11-20;_bh?=
 =?UTF-8?Q?=3D2YvT0TILGIfIbg/Mf8bVNNnQ5vMJnrTusgpdhYObAJ4=3D;_b=3DozGbctp7?=
 =?UTF-8?Q?ABh+yFfWv5WX5p+9FxCPWbX1WzI38JxlRIzgBaP6FRB3DLXtq9RuKqkMKPjk_P2?=
 =?UTF-8?Q?+u9e21YjLv0vhyDWsNmynrofwAG1EFyEUfbja0ssXNYQWuFXuHza1RxFc8t8piz?=
 =?UTF-8?Q?oNF_zt9D5STGNmCcUoBWpwC0fVtzO/cEv+VgDBLXGHt2FAL0xKzl3PJ2RuaOyZ8?=
 =?UTF-8?Q?aSM5OPjrb_daN5x8qbKgM3wSmbL8QmKrrdl5iNr4smo7E5pBaagecbPFMXDVKuu?=
 =?UTF-8?Q?iapwXkd6CrX3L1Y_z9kJ4Nam2iF1WbObr349GKdQD+0BTLzFtiAzdyYwdvpFtqi?=
 =?UTF-8?Q?O0/OzQQqNHgoTdS7+TmmQ_XQ=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8kba8ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 01:31:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44UMcDTD016417;
	Fri, 31 May 2024 01:31:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50t9835-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 31 May 2024 01:31:30 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44V1SKNk027418;
	Fri, 31 May 2024 01:31:29 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50t96yw-17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 31 May 2024 01:31:28 +0000
From: Ross Philipson <ross.philipson@oracle.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v9 16/19] tpm: Add ability to set the preferred locality the TPM chip uses
Date: Thu, 30 May 2024 18:03:28 -0700
Message-Id: <20240531010331.134441-17-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240531010331.134441-1-ross.philipson@oracle.com>
References: <20240531010331.134441-1-ross.philipson@oracle.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_21,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405310010
X-Proofpoint-GUID: 3G2bErp5r6fTv5bFh_s6Nm51x6S2juAM
X-Proofpoint-ORIG-GUID: 3G2bErp5r6fTv5bFh_s6Nm51x6S2juAM
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_023258_858434_7A2C323B 
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

Curently the locality is hard coded to 0 but for DRTM support, access
is needed to localities 1 through 4.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 drivers/char/tpm/tpm-chip.c      | 24 +++++++++++++++++++++++-
 drivers/char/tpm/tpm-interface.c | 15 +++++++++++++++
 drivers/char/tpm/tpm.h           |  1 +
 include/linux/tpm.h              |  4 ++++
 4 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 854546000c92..73eac54d61fb 100644
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
@@ -374,6 +395,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
 	}
 
 	chip->locality = -1;
+	chip->pref_locality = 0;
 	return chip;
 
 out:
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 5da134f12c9a..35f14ccecf0e 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -274,6 +274,21 @@ int tpm_is_tpm2(struct tpm_chip *chip)
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
index 6b8b9956ba69..be465422d3fa 100644
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
index 363f7078c3a9..935a3457d7c8 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -219,6 +219,9 @@ struct tpm_chip {
 	u8 null_ec_key_y[EC_PT_SZ];
 	struct tpm2_auth *auth;
 #endif
+
+	/* preferred locality - default 0 */
+	int pref_locality;
 };
 
 #define TPM_HEADER_SIZE		10
@@ -461,6 +464,7 @@ static inline u32 tpm2_rc_value(u32 rc)
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

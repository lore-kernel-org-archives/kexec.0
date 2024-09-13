Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC051FC6174
	for <kexec@archiver.kernel.org>; Fri, 13 Sep 2024 20:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CLdz5NL07XXnM8GWX1NsHTNBMvxX3r9h2yGSEd+EdX0=; b=KNVSfXXHWkN5lW
	oJowkdJ/Lmbn0SpmgnJwQ1Bg8U1Fak2ZVaX3Hx2l1Jpx5bK3ydtttOCTqXu4O9xwSj8P19yOInX1i
	8+FN/V6BLjl5C39HIgcm2eKHhL6RmG2aov5H1y5jmtucMCWSTngnO/emLNWqEzV/Z//8VOPF2yya4
	nfs/S8l6pUa36/6OoAKzqQ7fyrWFBI0cWwm9Kc4Bkpzc71A8e7ZY0Y6yfWKRayEAbazOFBg0wCR4E
	xrtufs7Qf0/akKFdlfZWs6SSJk0FOu7piNJoTC6vV1dDLGU+ZjB9GBLQy0JnccIvUTQfwqz84NURG
	Zdqxwf/50F6Hpio1x3yQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1spCfq-0000000H1hp-0VMM;
	Fri, 13 Sep 2024 20:13:46 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1spCfn-0000000H1gM-0mCs
	for kexec@bombadil.infradead.org;
	Fri, 13 Sep 2024 20:13:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=CBwVi+IOsZakjKwBef0tUPxe+z4b+8YEf5WOjhPKBpE=; b=DTpF6bGHWX9e9wQNdyb+EtgkP5
	hzCmhNe5PdP8f+6prBYEdIn57e2tLaLubfthSXs2NQKAapyg7MIxWVlJcGTR9csujCMy6MINJsFjE
	t8utbXnwZ9Tk8pVCU9RFf86hQPBCz5rIshRJq56QRsp4SbnSmS5hrZU//9TGkOdAYFaLoLAeQKtc/
	5miC9QyXCxVkI/fihOx6vgV15aBJTjAEP1SJCX/U4AEgH+iQ0wmdwp8plIX+xPG3vHoKKlMocI6M3
	pdTMhEKJCOu5HCOTt2xUI3fhDMI7Z6/WCnUIdYYcHgFxqNxaqJU3t6n7x9X7AVwZc3jjnlwRA53XJ
	+X5Sz6NA==;
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1spCfi-00000000iXn-1xck
	for kexec@lists.infradead.org;
	Fri, 13 Sep 2024 20:13:41 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DJ0YBb008515;
	Fri, 13 Sep 2024 20:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=C
	BwVi+IOsZakjKwBef0tUPxe+z4b+8YEf5WOjhPKBpE=; b=A8kN+lzKJozUHAulB
	/AkIP5AH3IdzRIGkInalHtBzO3E5yeG2TfltJq/edNgd9u8V1LjWBHqS3t9XrRpk
	AMvmdJJHK3z0IxWTu3KDvrKX2JPzSp/wMsFmOM17Jk0IHGcW5ApXHnSfgwICyh/y
	tT1mofk7OcymSqHWf4bVO7QylwsU07twhit+zmroZP8EDbDxZ1M/zaIJkuKEeHHM
	M629d2+u7NdXrMQYhU8SgTqkH2sWcoAJNpYbQXSxKDT91WbbH0B2H8Ut45De7MYt
	iJHfPpdknUYYplsy+sJ05ZeOT7PeeSUJEmbZ/zA1JauixXaQjst75UrAu7OyXKQb
	n3LCw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gdrbegyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 20:13:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48DJdHWh033569;
	Fri, 13 Sep 2024 20:13:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9d3pkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 13 Sep 2024 20:13:00 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48DK89wV014063;
	Fri, 13 Sep 2024 20:12:59 GMT
Received: from localhost.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9d3phc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 13 Sep 2024 20:12:59 +0000
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
Subject: [PATCH v11 18/20] tpm: Add sysfs interface to allow setting and querying the default locality
Date: Fri, 13 Sep 2024 13:05:15 -0700
Message-Id: <20240913200517.3085794-19-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240913200517.3085794-1-ross.philipson@oracle.com>
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409130143
X-Proofpoint-ORIG-GUID: UeAmSk6ezsrPwNpW8Vf7p4qYLbs0iKRK
X-Proofpoint-GUID: UeAmSk6ezsrPwNpW8Vf7p4qYLbs0iKRK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_211339_952458_3B174585 
X-CRM114-Status: GOOD (  13.31  )
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

Expose a sysfs interface to allow user mode to set and query the default
locality set for the TPM chip.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 drivers/char/tpm/tpm-sysfs.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 94231f052ea7..185a2f57d4cb 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -324,6 +324,34 @@ static ssize_t null_name_show(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR_RO(null_name);
 #endif
 
+static ssize_t default_locality_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct tpm_chip *chip = to_tpm_chip(dev);
+
+	return sprintf(buf, "%d\n", chip->default_locality);
+}
+
+static ssize_t default_locality_store(struct device *dev, struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct tpm_chip *chip = to_tpm_chip(dev);
+	unsigned int locality;
+
+	if (kstrtouint(buf, 0, &locality))
+		return -ERANGE;
+
+	if (locality >= TPM_MAX_LOCALITY)
+		return -ERANGE;
+
+	if (tpm_chip_set_default_locality(chip, (int)locality))
+		return count;
+	else
+		return 0;
+}
+
+static DEVICE_ATTR_RW(default_locality);
+
 static struct attribute *tpm1_dev_attrs[] = {
 	&dev_attr_pubek.attr,
 	&dev_attr_pcrs.attr,
@@ -336,6 +364,7 @@ static struct attribute *tpm1_dev_attrs[] = {
 	&dev_attr_durations.attr,
 	&dev_attr_timeouts.attr,
 	&dev_attr_tpm_version_major.attr,
+	&dev_attr_default_locality.attr,
 	NULL,
 };
 
@@ -344,6 +373,7 @@ static struct attribute *tpm2_dev_attrs[] = {
 #ifdef CONFIG_TCG_TPM2_HMAC
 	&dev_attr_null_name.attr,
 #endif
+	&dev_attr_default_locality.attr,
 	NULL
 };
 
-- 
2.39.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

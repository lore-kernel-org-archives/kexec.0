Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5336C48BEB
	for <kexec@archiver.kernel.org>; Wed, 14 Feb 2024 22:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ktOryNHc04Ni+hpa1TEgTYdDmjqyRqh8UGYB8NZRhN8=; b=OSAdzfZ114xhjs
	JAUWmmj/9hMjVQ52Po+Tz8iDlmU+QRLSo5mX4iwuUXgW5hv+3haGTPZ9Wr/MPjGFr01/W5qjaRWYT
	5uZLELJq0FdRGYbMDt0WRfBHRO6IAnBhTDqRGSwrwYQEVCRCp3Zzd4L4OzK6pof16Yojs82Sbkl7U
	n57zSXhMg/77s7i0jVu2ce2wG/QEpzXU+CGPNesSQZzeSE6kAXSXBwn9EO53KImdK6ejgEVCtm+/z
	q32cRb+ZWI+L7z4dK9iw/aCRKHdgUiEJLXpVrZWBCLGedvrYMI2wE4dfQfC/c6k+3FJOkh4pQ01tE
	75Tp5xVoP8r9bvTytizA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raNry-0000000ERtG-2Uxa;
	Wed, 14 Feb 2024 22:36:46 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raNrx-0000000ERs0-05lg
	for kexec@bombadil.infradead.org;
	Wed, 14 Feb 2024 22:36:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=beF73PhQOvafRvxMrE9SGfQcxB3UIdpTP6nEGkw+3vc=; b=UzuIFZrTJjEDUkJGLCJQXxl+Zl
	cmHtIDSzPc5Fh1DROk9B/ner3bCakl04Tfmgqyv348Yeb/7y5HefGwsiq7pvynjwx91L7mS1S4cyB
	z5O5eNMhudJVLUXvF6TIgvo66oBSKOJwCrz0FFdK3QiobKksnwzmalogJtlmX3j/KhcU66ciSCKnA
	mU/AgjaVKfgDcqJ87Nq7YMbY9vHMmqAK3hfUNG5mO9Ai/fajXWPLXgV+PM9lsrvH16jnYpyz0bbJ/
	UvDa4uLq5r41djtIDb4RBpZttGyeuTDkuedkolL/0y9FuvTRl1m72rUPVNu9SuDMTGPYegbi0oh6V
	9zWnWdGQ==;
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by casper.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raNrs-00000000BNh-1r9A
	for kexec@lists.infradead.org;
	Wed, 14 Feb 2024 22:36:44 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41ELiWL1022704;
	Wed, 14 Feb 2024 22:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=beF73PhQOvafRvxMrE9SGfQcxB3UIdpTP6nEGkw+3vc=;
 b=CSM/NBTh3VceRVKHqcI17YhS46VV9GwoWB+I6DTJIkkGTxP+cjuP84HeG0F10IwfYrUY
 9xF1eBonh+nhFmrcYvMVHwWgXZkONcLPc32kXIFd/NOpxhXB9KFlzF3P7+dFatZYdAai
 gF8ro+Y7ZvhXs2V/APYGFRSDQrmdADRuicJJ8yp3d+hjOEE7WE17wDOMpVnoHI+kbM9B
 IzZwgdrdkylbRK/+efZWyYG4QeSckHFg6RceBEJqwjW55ZAFI67RQ0H291zBHsEVx+zq
 b8EIrorETHx8I8XybbwRrps6hHNmLylR5yxf2FIlkWWCPxHhjUhLcfUpHUidG4JCgp/J nQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92ppghka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 22:31:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41EM9iB8000639;
	Wed, 14 Feb 2024 22:31:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk9n7ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 14 Feb 2024 22:31:45 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41EMVTVK004281;
	Wed, 14 Feb 2024 22:31:44 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk9n72r-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 14 Feb 2024 22:31:44 +0000
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
Subject: [PATCH v8 13/15] tpm: Add sysfs interface to allow setting and querying the preferred locality
Date: Wed, 14 Feb 2024 14:18:45 -0800
Message-Id: <20240214221847.2066632-14-ross.philipson@oracle.com>
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
X-Proofpoint-ORIG-GUID: tT6BUrEPGTkbAvCJEEglQruin3qInev6
X-Proofpoint-GUID: tT6BUrEPGTkbAvCJEEglQruin3qInev6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240214_223642_178322_BCA452F8 
X-CRM114-Status: GOOD (  17.05  )
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

Expose a sysfs interface to allow user mode to set and query the preferred
locality for the TPM chip.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 drivers/char/tpm/tpm-sysfs.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 54c71473aa29..c43630d0996e 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -309,6 +309,34 @@ static ssize_t tpm_version_major_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(tpm_version_major);
 
+static ssize_t preferred_locality_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct tpm_chip *chip = to_tpm_chip(dev);
+
+	return sprintf(buf, "%d\n", chip->pref_locality);
+}
+
+static ssize_t preferred_locality_store(struct device *dev, struct device_attribute *attr,
+					const char *buf, size_t count)
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
+	if (tpm_chip_preferred_locality(chip, (int)locality))
+		return count;
+	else
+		return 0;
+}
+
+static DEVICE_ATTR_RW(preferred_locality);
+
 static struct attribute *tpm1_dev_attrs[] = {
 	&dev_attr_pubek.attr,
 	&dev_attr_pcrs.attr,
@@ -321,11 +349,13 @@ static struct attribute *tpm1_dev_attrs[] = {
 	&dev_attr_durations.attr,
 	&dev_attr_timeouts.attr,
 	&dev_attr_tpm_version_major.attr,
+	&dev_attr_preferred_locality.attr,
 	NULL,
 };
 
 static struct attribute *tpm2_dev_attrs[] = {
 	&dev_attr_tpm_version_major.attr,
+	&dev_attr_preferred_locality.attr,
 	NULL
 };
 
-- 
2.39.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D74FC6175
	for <kexec@archiver.kernel.org>; Fri, 13 Sep 2024 20:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HIE7VN27RLVXXTsj5hHo3z/47Y4rAgqvD7sK53Yvm84=; b=qRuU5DLmZhEZpM
	9yAxXTTY4jb1zPLuWehWIBNhIEjgmCmPPqR7d97o3lawNOKXQQl+6SAgGpQF0WqkZeYg1tylxnthr
	cGkX4moaiYu1xjQWrwubFG9XBRMubJ3fW3/3Z4km2E1zA+mJx7wP+LyyGu6+vmWaD85kbcUICRsAC
	6EH/aC32yCdmOy64Z9w4CtLnfPVeJOShFQ5y/NmSTCrpcOlthgJOIjXmae53lSHp71tnxazOhQb0z
	R4lGdkWeH8dowoQvzJQvf0GaT4QVMDCQxqhPlj/Qr+NK908Y0vT+zWDariOxZLeITvDB7BT9wlvL2
	f3EsYM4ZS/S+WdvT2/nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1spCf0-0000000H16d-2HS2;
	Fri, 13 Sep 2024 20:12:54 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1spCdf-0000000H0aQ-1QOu
	for kexec@lists.infradead.org;
	Fri, 13 Sep 2024 20:11:32 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DJ0WDF015544;
	Fri, 13 Sep 2024 20:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=v
	r2ns18yTEELZ4QHgKstSA61qLwA6Ph8/LFZIUzTaG8=; b=J+aMdBcF0EvcNhP93
	Vwu6dq1S13jZfo8nQ4f66SsNU6xQIbG+13PEVV4U0213LvT3uG+dmtt8dJt2RE/Y
	SMwNQRLaxmIY378UvQQ7dllyr4AWJQzwMmNIBoWtx8i+MljZ69xPdmqtqDb81YQT
	75GUTFP1jPCG87nTLWQmUcyFCe8FroVNDjkInuyqpTn8ZSWaRvwamXimFHM/OKBX
	8tMgsRjdCTM1JxmQsWsg3Q1HndoH7ai+gDhVn5C9GAr4WZbcjTfYBLU8FUMoOb1I
	Hce6ncmTz4pJa2H65RaOabBZMjXFEwbFRLMfmJWzoHpJQ3pB4Rasov65isyOQiWe
	onQng==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gde0ejv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 20:11:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48DItFOu033599;
	Fri, 13 Sep 2024 20:11:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9d3n0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 13 Sep 2024 20:11:11 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48DKBATJ022847;
	Fri, 13 Sep 2024 20:11:10 GMT
Received: from localhost.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9d3mxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 13 Sep 2024 20:11:10 +0000
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
Subject: [PATCH v11 06/20] x86: Add early SHA-256 support for Secure Launch early measurements
Date: Fri, 13 Sep 2024 13:05:03 -0700
Message-Id: <20240913200517.3085794-7-ross.philipson@oracle.com>
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
X-Proofpoint-ORIG-GUID: M6qmhx3l5Ay94VyBZHOX5bRuNC88a5Cy
X-Proofpoint-GUID: M6qmhx3l5Ay94VyBZHOX5bRuNC88a5Cy
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_131131_400448_ED2DF174 
X-CRM114-Status: GOOD (  14.32  )
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

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

The SHA-256 algorithm is necessary to measure configuration information into
the TPM as early as possible before using the values. This implementation
uses the established approach of #including the SHA-256 libraries directly in
the code since the compressed kernel is not uncompressed at this point.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/boot/compressed/Makefile | 2 +-
 arch/x86/boot/compressed/sha256.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/boot/compressed/sha256.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 7eb03afb841b..40dc0b9babd5 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -107,7 +107,7 @@ vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
 vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 
-vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/sha1.o
+vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/sha1.o $(obj)/sha256.o
 
 $(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
 	$(call if_changed,ld)
diff --git a/arch/x86/boot/compressed/sha256.c b/arch/x86/boot/compressed/sha256.c
new file mode 100644
index 000000000000..293742a90ddc
--- /dev/null
+++ b/arch/x86/boot/compressed/sha256.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 Apertus Solutions, LLC
+ */
+
+#include "../../../../lib/crypto/sha256.c"
-- 
2.39.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF06BC25B76
	for <kexec@archiver.kernel.org>; Fri, 31 May 2024 01:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KqmMvRsSZOXSOhyaRlWk8HrK/cxIOudv2fncJ95S6+M=; b=AgAwYc7t2N08TP
	CfyMEVgALuyrDENIn5CAiLt2iufE+Wc0WAyXaGVsLkwfVdjS/hzrq3mZIxeuhviNxC9CfTmUB7UE4
	1SIjcjHv7x28L8m+JykFuLgQ4YmYAOmk9oFIvQ0Ji0GZ5j2E0JQd7xhlAFWNw9C50uUYgWqCJ1XQ8
	6tTvAUxUFMnmsWhQpqWyDz/B/ZKGxT5Q60XSmwhhmZHNt7oi66cQwNA4dIxwvatwb2jbC11dubd8F
	kdQZbncIokYp0yiLyb6MRGS8F3IytkbIUKWu3gZrNVLGhrVT8YcL+TfFgW7so70J+SyK1BYiewOue
	z1Xlm32Vi0X6TMabSsyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCr8G-00000008uNw-2Lib;
	Fri, 31 May 2024 01:32:36 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCr81-00000008uEG-21NQ
	for kexec@lists.infradead.org;
	Fri, 31 May 2024 01:32:30 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44V15j7P018494;
	Fri, 31 May 2024 01:30:57 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:date:from:in-reply-to:message-i?=
 =?UTF-8?Q?d:mime-version:references:subject:to;_s=3Dcorp-2023-11-20;_bh?=
 =?UTF-8?Q?=3DBV7tLiS6TBCu4gY09MERe8V7NMSo+x6GNPEXwjNAE80=3D;_b=3Dh1r3nF89?=
 =?UTF-8?Q?15Rv4zAwtnG/wbR1MlOmnvm56B511Bxl/M/ue1SYPSbbKUVoq/grj1MM+g7X_Xx?=
 =?UTF-8?Q?z1P/8Bb1vHIp+M1i3U4zUxUDpgFhu5xYkzYdFMc6fF+Tkjc9QomTOQ7esDE0yOL?=
 =?UTF-8?Q?h8c_Rev56N1rKFsK1Wbzj6e3jGZLVKIi5pVZC+4U/BP1fYMLCR0gQZDwwq0Aav9?=
 =?UTF-8?Q?N0LUBI1+T_dhAmFl4RTOIzZtyPW7Mkuj9mbO3jVOK4Bp808BCiGIvykTUR5Vl3n?=
 =?UTF-8?Q?oCCMgKX978yS5AK_S7zyM/WlHNb3pQrQW2lt/yb1pD/2yNO1px/c3/MH4q3sUKo?=
 =?UTF-8?Q?ZbfsxTLkiYsdqru36+FYZ_eQ=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8j8a3du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 01:30:57 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44V10lSD016306;
	Fri, 31 May 2024 01:30:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50t97rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 31 May 2024 01:30:56 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44V1SKNS027418;
	Fri, 31 May 2024 01:30:55 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50t96yw-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 31 May 2024 01:30:54 +0000
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
Subject: [PATCH v9 07/19] x86: Add early SHA-256 support for Secure Launch early measurements
Date: Thu, 30 May 2024 18:03:19 -0700
Message-Id: <20240531010331.134441-8-ross.philipson@oracle.com>
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
X-Proofpoint-ORIG-GUID: rkRNN0twpbRo_W7f5R2GhnoeX12G9z35
X-Proofpoint-GUID: rkRNN0twpbRo_W7f5R2GhnoeX12G9z35
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_183228_124971_8ACF71E8 
X-CRM114-Status: GOOD (  13.44  )
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
 arch/x86/boot/compressed/Makefile       | 2 +-
 arch/x86/boot/compressed/early_sha256.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/boot/compressed/early_sha256.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 3307ebef4e1b..9189a0e28686 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -118,7 +118,7 @@ vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
 vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 
-vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o
+vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o $(obj)/early_sha256.o
 
 $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
 	$(call if_changed,ld)
diff --git a/arch/x86/boot/compressed/early_sha256.c b/arch/x86/boot/compressed/early_sha256.c
new file mode 100644
index 000000000000..293742a90ddc
--- /dev/null
+++ b/arch/x86/boot/compressed/early_sha256.c
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

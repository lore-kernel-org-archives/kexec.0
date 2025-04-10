Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E958C3601E
	for <kexec@archiver.kernel.org>; Thu, 10 Apr 2025 20:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8RzvD9yt1H96MQwyUq/armOs73ZqRgyKFJ7loqXAKPY=; b=N/XoAsjXEkWNK8Nja1HR2crjN2
	skaqPd7lmIxO9uKQ+c4FSM2drsQXbSErsE7s3lo14i+6MWWKy0QrFqY2blhyh5R7rrWlwtgVX2L9Z
	CQHGn6m/pNXOOXfwvp2tydmyYmh8CSFXpvy1umR1I/0OGHvukk7A8c1MeAJdI0Kd7vwIJCplpc/1c
	Mcb/0HlmhIe7zqATc/b8uWHwqjfemVCse+Qdb+us/Wi6VlSC6tK1vcigYLaVJSYlr6ILR/x6hlND4
	v4ErFX1lTlJcJHHIlxH4mXbhTVje7dPlArMX9XUH6u+1AqwI28Ih1NroqropxrQA4dSleOMau90Uj
	IU3rijZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2yot-0000000BoqE-341V;
	Thu, 10 Apr 2025 20:48:19 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2yoq-0000000BooW-3pg5
	for kexec@lists.infradead.org;
	Thu, 10 Apr 2025 20:48:18 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AKg7Nw005141;
	Thu, 10 Apr 2025 20:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=8RzvD
	9yt1H96MQwyUq/armOs73ZqRgyKFJ7loqXAKPY=; b=S7DAA+77/GM7EEK5UFIRK
	0pSw6Lw/n25kRyU+/oQNXbC4uoEQUVMXJna0/8x0TFiLkKPp03rxqymLloQHh44s
	K3MqSfeaeMX75Lq5imMDq6xgeLKLJOLhJT0YCheJvcDNbSyNqyYZNGn/69xwBeeO
	kzgKa10sjNSAX3Vb7EWIIPvdJBT53DbqExeX/ITXfH39druRjR/JRUPmQpCy8Oge
	LBdGw6DvtALjzgBAUparRItShgYIvtlR7WMhMKrifWAhP6tZL3zsWGPn5teT31GU
	2QQPpsCOKznIXz6vgq/STQN/fi/SaUg1Xz9q2DFLXwMbxgv6tgbAWhiom8VS3Feo
	w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45xn8fr0nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 20:48:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53AK6cUx013867;
	Thu, 10 Apr 2025 20:48:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyk4q0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 10 Apr 2025 20:48:00 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53AKlxiG030426;
	Thu, 10 Apr 2025 20:47:59 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyk4pys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 10 Apr 2025 20:47:59 +0000
From: Ross Philipson <ross.philipson@oracle.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux.dev
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
Subject: [PATCH v13 08/19] x86/boot: Place TXT MLE header in the kernel_info section
Date: Thu, 10 Apr 2025 13:41:38 -0700
Message-Id: <20250410204149.2576104-9-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250410204149.2576104-1-ross.philipson@oracle.com>
References: <20250410204149.2576104-1-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504100150
X-Proofpoint-GUID: w3BYcKs4K0kvg8zHFfs1VgraOuinBSd7
X-Proofpoint-ORIG-GUID: w3BYcKs4K0kvg8zHFfs1VgraOuinBSd7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_134817_064077_9F0E2969 
X-CRM114-Status: GOOD (  22.42  )
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

The Measured Launch Environment (MLE) header must be locatable by the
boot loader and Intel TXT must be setup to do a launch with this header's
location. While the offset to the kernel_info structure does not need
to be at a fixed offset, the offsets in the header must be relative
offsets from the start of the setup kernel. Note that from the viewpoint
of the prelaunch phase and TXT, the setup kernel image as loaded into
memory is the MLE image.

The changes to the linker file achieve this by making available the
offset values which are updated in the MLE header structure. The following
are the needed offsets from the beginning of the setup kernel image:

- kernel_info_offset: Offset of the main kernel_info structure.
- mle_header_offset: Offset of the MLE header structure.
- sl_stub_entry_offset: Offset of the Secure Launch initial entry point.
- _edata_offset: Offset of the _edata label used as the end of the MLE image.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/kernel_info.S | 50 +++++++++++++++++++++++---
 arch/x86/boot/compressed/vmlinux.lds.S |  7 ++++
 2 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/kernel_info.S b/arch/x86/boot/compressed/kernel_info.S
index f818ee8fba38..2765b1786368 100644
--- a/arch/x86/boot/compressed/kernel_info.S
+++ b/arch/x86/boot/compressed/kernel_info.S
@@ -1,12 +1,20 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
+#include <linux/linkage.h>
 #include <asm/bootparam.h>
 
-	.section ".rodata.kernel_info", "a"
+/*
+ * The kernel_info structure is not placed at a fixed offest in the
+ * kernel image. So this macro and the support in the linker file
+ * allow the relative offsets for the MLE header within the kernel
+ * image to be configured at build time.
+ */
+#define roffset(X) ((X) - kernel_info)
 
-	.global kernel_info
+	.section ".rodata.kernel_info", "a"
 
-kernel_info:
+	.balign	16
+SYM_DATA_START(kernel_info)
 	/* Header, Linux top (structure). */
 	.ascii	"LToP"
 	/* Size. */
@@ -17,6 +25,40 @@ kernel_info:
 	/* Maximal allowed type for setup_data and setup_indirect structs. */
 	.long	SETUP_TYPE_MAX
 
+	/* Offset to the MLE header structure */
+#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
+	.long	roffset(mle_header_offset)
+#else
+	.long	0
+#endif
+
 kernel_info_var_len_data:
 	/* Empty for time being... */
-kernel_info_end:
+SYM_DATA_END_LABEL(kernel_info, SYM_L_LOCAL, kernel_info_end)
+
+#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
+	/*
+	 * The MLE Header per the TXT Specification, section 2.1
+	 * MLE capabilities, see table 4. Capabilities set:
+	 * bit 0: Support for GETSEC[WAKEUP] for RLP wakeup
+	 * bit 1: Support for RLP wakeup using MONITOR address
+	 * bit 2: The ECX register will contain the pointer to the MLE page table
+	 * bit 5: TPM 1.2 family: Details/authorities PCR usage support
+	 * bit 9: Supported format of TPM 2.0 event log - TCG compliant
+	 */
+SYM_DATA_START(mle_header)
+	.long	0x9082ac5a			/* UUID0 */
+	.long	0x74a7476f			/* UUID1 */
+	.long	0xa2555c0f			/* UUID2 */
+	.long	0x42b651cb			/* UUID3 */
+	.long	0x00000034			/* MLE header size */
+	.long	0x00020002			/* MLE version 2.2 */
+	.long	roffset(sl_stub_entry_offset)	/* Linear entry point of MLE (virt. address) */
+	.long	0x00000000			/* First valid page of MLE */
+	.long	0x00000000			/* Offset within binary of first byte of MLE */
+	.long	roffset(_edata_offset)		/* Offset within binary of last byte + 1 of MLE */
+	.long	0x00000227			/* Bit vector of MLE-supported capabilities */
+	.long	0x00000000			/* Starting linear address of command line (unused) */
+	.long	0x00000000			/* Ending linear address of command line (unused) */
+SYM_DATA_END(mle_header)
+#endif
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 3b2bc61c9408..eae9745f5a0b 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -118,3 +118,10 @@ SECTIONS
 	}
 	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
 }
+
+#ifdef CONFIG_SECURE_LAUNCH
+PROVIDE(kernel_info_offset      = ABSOLUTE(kernel_info - startup_32));
+PROVIDE(mle_header_offset       = kernel_info_offset + ABSOLUTE(mle_header - startup_32));
+PROVIDE(sl_stub_entry_offset    = kernel_info_offset + ABSOLUTE(sl_stub_entry - startup_32));
+PROVIDE(_edata_offset           = kernel_info_offset + ABSOLUTE(_edata - startup_32));
+#endif
-- 
2.39.3



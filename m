Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5ECE7718F
	for <kexec@archiver.kernel.org>; Thu, 19 Dec 2024 19:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4tXZ+0Nsfxg0v9dxCmt558jUx/Sa3ysdkwfYdW/6Hgo=; b=U60wail1EbzjsNUxfRrOpSrYPI
	GLrNx0QaFCDStAbULsVKrlNSK7+aOufn8oFzedIK/z0XeqDKKA9GgzeP0SotH/FkdSnL/EPNJ+vF9
	8nxe3tARmMHEZfURaAzL+alsJ9hgF0uCYTdLnidN8C+rMs8BUoCBiZNlMusHmScD9WteknR+67sgE
	SpUeqPjKRKyxMzA9rRDSCqKFfVROF7bmYss32j+G9q96v8GgjFB8d0rkymbdxWayDqWTNJ7nrSue6
	xl87pYvbHEkLrAmLpzDgYbN6NbyzFopWtotZwKSURZVQD6S+GDxBDIE5PVeSBghc8V84qUxIRT4Ti
	8IaC0zjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOMfP-00000002vo6-2590;
	Thu, 19 Dec 2024 19:58:39 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOMcz-00000002us6-2grL
	for kexec@lists.infradead.org;
	Thu, 19 Dec 2024 19:56:10 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJIMiOT031417;
	Thu, 19 Dec 2024 19:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=4tXZ+
	0Nsfxg0v9dxCmt558jUx/Sa3ysdkwfYdW/6Hgo=; b=L1wqa4Jnk7ai8pYk2HQyk
	BZWVyoMKzSmgfz4UyEJDyA9zn6hT6rk/PULqaFs13Pb7gyodxCHANGKA39BVVGGt
	2p2kNMpilhQeBEGZOM4M8aReLYMS2Qir09+K7psQH4OcmDonAMn3ivccLoW0tkkd
	cM99IbrTZgRSP7ANbtVGBzRKEiX7ahiDFAoWzF12ZZMlLeqGjaYgVyvTXZ/zQei8
	HkBROPekn2M6lo5g4UJcX3VWYYi8eP7mOciQMt6Q1slA1u7jqY6p1xBPfbignEHq
	honUd/T62vCakhHTiC+UP/Y7DxrjBs4AxrlqAeqlmxviTXM8F2Z4GtMzefPHla/8
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43jaj5hkb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 19:54:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJI0Ntx000589;
	Thu, 19 Dec 2024 19:54:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fbs35n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 19 Dec 2024 19:54:46 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BJJsjIT004050;
	Thu, 19 Dec 2024 19:54:45 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fbs33j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 19 Dec 2024 19:54:45 +0000
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
Subject: [PATCH v12 05/19] x86: Add early SHA-1 support for Secure Launch early measurements
Date: Thu, 19 Dec 2024 11:42:02 -0800
Message-Id: <20241219194216.152839-6-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241219194216.152839-1-ross.philipson@oracle.com>
References: <20241219194216.152839-1-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-19_09,2024-12-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412190158
X-Proofpoint-GUID: 3yK52mBWn8F--Hd72BJAKcODxbAYm-bE
X-Proofpoint-ORIG-GUID: 3yK52mBWn8F--Hd72BJAKcODxbAYm-bE
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241219_115609_792909_C17A0CA5 
X-CRM114-Status: GOOD (  25.12  )
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

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

Secure Launch is written to be compliant with the Intel TXT Measured Launch
Developer's Guide. The MLE Guide dictates that the system can be configured to
use both the SHA-1 and SHA-2 hashing algorithms.

Regardless of the preference towards SHA-2, if the firmware elected to start
with the SHA-1 and SHA-2 banks active and the dynamic launch was configured to
include SHA-1, Secure Launch is obligated to record measurements for all
algorithms requested in the launch configuration.

The user environment or the integrity management does not desire to use SHA-1,
it is free to just ignore the SHA-1 bank in any integrity operation with the
TPM. If there is a larger concern about the SHA-1 bank being active, it is free
to deliberately cap the SHA-1 PCRs, recording the event in the D-RTM log.

The SHA-1 code here has its origins in the code from the main kernel:

commit c4d5b9f ("crypto: sha1 - implement base layer for SHA-1")

A modified version of this code was introduced to the lib/crypto/sha1.c to bring
it in line with the SHA-256 code and allow it to be pulled into the setup kernel
in the same manner as SHA-256 is.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/boot/compressed/Makefile |  2 +
 arch/x86/boot/compressed/sha1.c   |  6 +++
 include/crypto/sha1.h             |  1 +
 lib/crypto/sha1.c                 | 81 +++++++++++++++++++++++++++++++
 4 files changed, 90 insertions(+)
 create mode 100644 arch/x86/boot/compressed/sha1.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index f2051644de94..7eb03afb841b 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -107,6 +107,8 @@ vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
 vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 
+vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/sha1.o
+
 $(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
 	$(call if_changed,ld)
 
diff --git a/arch/x86/boot/compressed/sha1.c b/arch/x86/boot/compressed/sha1.c
new file mode 100644
index 000000000000..d754489941ac
--- /dev/null
+++ b/arch/x86/boot/compressed/sha1.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 Apertus Solutions, LLC.
+ */
+
+#include "../../../../lib/crypto/sha1.c"
diff --git a/include/crypto/sha1.h b/include/crypto/sha1.h
index 044ecea60ac8..d715dd5332e1 100644
--- a/include/crypto/sha1.h
+++ b/include/crypto/sha1.h
@@ -42,5 +42,6 @@ extern int crypto_sha1_finup(struct shash_desc *desc, const u8 *data,
 #define SHA1_WORKSPACE_WORDS	16
 void sha1_init(__u32 *buf);
 void sha1_transform(__u32 *digest, const char *data, __u32 *W);
+void sha1(const u8 *data, unsigned int len, u8 *out);
 
 #endif /* _CRYPTO_SHA1_H */
diff --git a/lib/crypto/sha1.c b/lib/crypto/sha1.c
index ebb60519ae93..0bd32df31743 100644
--- a/lib/crypto/sha1.c
+++ b/lib/crypto/sha1.c
@@ -137,5 +137,86 @@ void sha1_init(__u32 *buf)
 }
 EXPORT_SYMBOL(sha1_init);
 
+static void __sha1_transform(u32 *digest, const char *data)
+{
+	u32 ws[SHA1_WORKSPACE_WORDS];
+
+	sha1_transform(digest, data, ws);
+
+	/* Ensure local data for generating digest is cleared in all cases */
+	memzero_explicit(ws, sizeof(ws));
+}
+
+static void sha1_update(struct sha1_state *sctx, const u8 *data, unsigned int len)
+{
+	unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
+	int blocks;
+
+	sctx->count += len;
+
+	if (unlikely((partial + len) < SHA1_BLOCK_SIZE))
+		goto out;
+
+	if (partial) {
+		int p = SHA1_BLOCK_SIZE - partial;
+
+		memcpy(sctx->buffer + partial, data, p);
+		data += p;
+		len -= p;
+
+		__sha1_transform(sctx->state, sctx->buffer);
+	}
+
+	blocks = len / SHA1_BLOCK_SIZE;
+	len %= SHA1_BLOCK_SIZE;
+
+	if (blocks) {
+		while (blocks--) {
+			__sha1_transform(sctx->state, data);
+			data += SHA1_BLOCK_SIZE;
+		}
+	}
+	partial = 0;
+
+out:
+	memcpy(sctx->buffer + partial, data, len);
+}
+
+static void sha1_final(struct sha1_state *sctx, u8 *out)
+{
+	const int bit_offset = SHA1_BLOCK_SIZE - sizeof(__be64);
+	unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
+	__be64 *bits = (__be64 *)(sctx->buffer + bit_offset);
+	__be32 *digest = (__be32 *)out;
+	int i;
+
+	sctx->buffer[partial++] = 0x80;
+	if (partial > bit_offset) {
+		memset(sctx->buffer + partial, 0x0, SHA1_BLOCK_SIZE - partial);
+		partial = 0;
+
+		__sha1_transform(sctx->state, sctx->buffer);
+	}
+
+	memset(sctx->buffer + partial, 0x0, bit_offset - partial);
+	*bits = cpu_to_be64(sctx->count << 3);
+	__sha1_transform(sctx->state, sctx->buffer);
+
+	for (i = 0; i < SHA1_DIGEST_SIZE / sizeof(__be32); i++)
+		put_unaligned_be32(sctx->state[i], digest++);
+
+	*sctx = (struct sha1_state){};
+}
+
+void sha1(const u8 *data, unsigned int len, u8 *out)
+{
+	struct sha1_state sctx = {0};
+
+	sha1_init(sctx.state);
+	sha1_update(&sctx, data, len);
+	sha1_final(&sctx, out);
+}
+EXPORT_SYMBOL(sha1);
+
 MODULE_DESCRIPTION("SHA-1 Algorithm");
 MODULE_LICENSE("GPL");
-- 
2.39.3



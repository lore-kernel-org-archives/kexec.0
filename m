Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084DCD5B874
	for <kexec@archiver.kernel.org>; Mon, 15 Dec 2025 23:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wjxps0VaNBMrYBw1aGtzj/DPg+gj5nTir2UVoYbveZM=; b=BMsxNzd4NyV00mcrnLA3ocBrQd
	Kbayxjb8JWb8K7h6z7hTmwku+DzF564WDcBSVeGWFLe/9AphDFPJrcNZ4eFjVQ/mhaFl8XU7o+2eE
	qhV5SLtsDsbBN0+wtMWY0p8ihKXgWF5jhJFhIORPavx3qUCfupjgbAz7clVqf3ZInkY6fYcFLW1tx
	K1e8E8KQX/rCIwt/vyWZrqVDspNt4KVDv69WCc2fkaKOQ8eQ/14wPdR8uM/3v0pCABbTy9WZnNOGd
	ErBgqa5yIZZhg9rp1OMNtxBGpMbw87oozeJ+xWVNlLHXwHvvI/9+n04wPnjpZLX9pOBvY1whnAUyB
	cBhlWv/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVICY-00000004Q3X-49uk;
	Mon, 15 Dec 2025 23:42:02 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVICV-00000004Q0o-3GqW
	for kexec@lists.infradead.org;
	Mon, 15 Dec 2025 23:42:01 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFJCK6i2854678;
	Mon, 15 Dec 2025 23:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Wjxps
	0VaNBMrYBw1aGtzj/DPg+gj5nTir2UVoYbveZM=; b=Wn4mIjudXrWkHpssmx5ii
	hnFertiCrDUEkWe+WmKUrlsFgf4klxC2wKsu+ISiw10H80bpVTPlTty6zcH6ANJ6
	hvcL2a3SZ5CWmofPXd+Pp+qCU1KZpfheaauhwWxLMFn9xJVXHTiP1dYdbgfrw2eb
	4vBcnultlSxMQhHVvMDp1lZVaijIdN3TK8Xj9CKxvvXpS7pnsGm2WrTWajM0/oBw
	zve+I6dW80Kejife8sTXt9y4/Z3OTm93v3RaGynLfugyE0g9VyIo/BkeTUo/0J86
	zaCBFDduOX5AjcoANvAEp16Ff4A3pYR24+h0IdTmfOaLVQ8vLJJ485KV9gsQet2K
	w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0y28b34f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 23:41:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFNFfj8006042;
	Mon, 15 Dec 2025 23:41:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkck9r1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:41:11 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BFNfB62026078;
	Mon, 15 Dec 2025 23:41:11 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkck9qj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:41:11 +0000
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
Subject: [PATCH v15 20/28] x86/msr: Add variable MTRR base/mask and x2apic ID registers
Date: Mon, 15 Dec 2025 15:33:08 -0800
Message-ID: <20251215233316.1076248-21-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251215233316.1076248-1-ross.philipson@oracle.com>
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_05,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150204
X-Proofpoint-GUID: 8GFX33kh3LbllHKKPAwpayGghqJU_fyv
X-Proofpoint-ORIG-GUID: 8GFX33kh3LbllHKKPAwpayGghqJU_fyv
X-Authority-Analysis: v=2.4 cv=fOQ0HJae c=1 sm=1 tr=0 ts=69409c99 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=UN5060LkAAAA:8 a=yPCof4ZbAAAA:8
 a=2bHeDvDOTcPBgUZVjGoA:9 a=E6eXv-vVeS7VqOnxGRGn:22 cc=ntf awl=host:12109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDIwNCBTYWx0ZWRfXxS0IQyCUcry+
 ncGFE6G3L8WO4ZzVN0kHeSPjqKV1YWCCaHQUGJkMIOzrqsQQ96UBvHYmvSeqmOpOh6ONjTKsX5f
 jonXAtB2LfVLPL1Swiohm0ct9ZT8w6Bh/JIFbnv56SsdfgFlfvF/9IdtcIlnnwDl11wAxxB15ES
 FFZjNBF39oq4SDpNUdFch50qV3i7uwtJPaZYE2u2AHibuv/LGP+t4vO+df+BG/h5QBTiKYSv5Y4
 sgLwcR2R8QAhhKDqKUCFZdhU3eX0Tl9LzlsIw+5Note9twS3Cj+XKwRd9sezP47BvbaA2o9jqXj
 dq6WXg5Qnk9w2IYV/hb0aWo7EUULNsgyBJR1k+OOU2/zCDd2rBOXD3scMeQZzS83AYgwfd/dFwu
 y+Sjb2PBZmD2KzM2WJ25K0I2o5mB8NQ3TnE1liH2jrX3Gg6LDLs=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251215_154159_832646_D9152AF7 
X-CRM114-Status: UNSURE (   8.70  )
X-CRM114-Notice: Please train this message.
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

Add the MSR values required by Secure Launch to locate particular CPU cores
during application processor (AP) startup, and restore the MTRR state after
an Intel TXT launch.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/include/asm/msr-index.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 9e1720d73244..ae620e609101 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -379,6 +379,9 @@
 #define MSR_IA32_RTIT_OUTPUT_BASE	0x00000560
 #define MSR_IA32_RTIT_OUTPUT_MASK	0x00000561
 
+#define MSR_MTRRphysBase0		0x00000200
+#define MSR_MTRRphysMask0		0x00000201
+
 #define MSR_MTRRfix64K_00000		0x00000250
 #define MSR_MTRRfix16K_80000		0x00000258
 #define MSR_MTRRfix16K_A0000		0x00000259
@@ -928,6 +931,8 @@
 #define MSR_IA32_APICBASE_ENABLE	(1<<11)
 #define MSR_IA32_APICBASE_BASE		(0xfffff<<12)
 
+#define MSR_IA32_X2APIC_APICID		0x00000802
+
 #define MSR_IA32_UCODE_WRITE		0x00000079
 #define MSR_IA32_UCODE_REV		0x0000008b
 
-- 
2.43.7



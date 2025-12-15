Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3C9D5B874
	for <kexec@archiver.kernel.org>; Mon, 15 Dec 2025 23:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=meX1M+kdakNqcbpqJnT6mnAgHOX0RxoLtLovWFxT6Kc=; b=KuQQA493hgLvU0SwxhoTlPVlLX
	pQNMw/rAP8/q7DFoAMwSKFQPK7ToKcPRC8LHB+0oOrUT9h8FDhPR83YMqfpPqIXMe0AYB46N73tbQ
	AGUc93dljbZ1c2lat3xwxHxne4FqcYWppepbFie5FYShAEGz0+EN82dYur+Yx6bkhODI//7P4kGtF
	4/66jRKxPaDV6x9IZr6BVdIjzFqVqLTomWVIBTqBkw7j5OqnltTwnZt+EDmZqy88GKeQljeaTsiEB
	WFhM9Y3xmlsUMLWKXY7gMs1r19+UiXybxS3WCDxNkRc6s5g1LHbqJljU29s+Unec1RbSzZIeCxnAn
	5mY6+iFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVIC7-00000004PkY-3XK6;
	Mon, 15 Dec 2025 23:41:35 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVIC3-00000004Piv-3RYW
	for kexec@lists.infradead.org;
	Mon, 15 Dec 2025 23:41:35 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFJCYn22721828;
	Mon, 15 Dec 2025 23:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=meX1M
	+kdakNqcbpqJnT6mnAgHOX0RxoLtLovWFxT6Kc=; b=aY0CzUJKs4zGjYo+jhkY3
	tCHovohKEBhu3hG6NjUrle4AUblQAyvksFrnrMBTLVlFtsMLmsAW8ySGpR1sD+tX
	0iqK+tAjwrujUxmkZqdS/Gkxds0hybLH3djuOEncz9qM+QyvH9KsVLM3fsXGmPwx
	bxdksgGTnXiEu/dBpeXpUoGuAeoVy/G3SMcHY1qtLWAeUVIPEzzkgqgi+pYYasxm
	0BGwlbCG6WMz2XjmbmntxJsBBH4t8mYvz0S1N2rkF8/WB4IvuPJG9IxLGh5Adjdp
	OYdZ0Ef4eUjJqqB0BgqkjXiOi3d+Ug5Q7Ug1lqNdk7/CG1esY5Yjw3VrC6fli/7m
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0xqxu429-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 23:41:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFMuunX022539;
	Mon, 15 Dec 2025 23:41:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkjkcev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:41:03 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BFNf2D4011005;
	Mon, 15 Dec 2025 23:41:02 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkjkce5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:41:02 +0000
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
Subject: [PATCH v15 18/28] x86: Add early SHA-256 support for Secure Launch early measurements
Date: Mon, 15 Dec 2025 15:33:06 -0800
Message-ID: <20251215233316.1076248-19-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251215233316.1076248-1-ross.philipson@oracle.com>
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_05,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150204
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDIwNCBTYWx0ZWRfXwQonRUQ6g85E
 opSINGdG70XSHXdq8qk8TtGSRM7xh9JRf2uNKHs7qrgUNjC/wLqGIupxRiO/Kb/Im6LX5BZ2b8J
 4ZCOBJGMIRaBVIFj2SCyc5s8siTKOi7qLgy2+wSW8Gh5eqZVWe7TskAv3rmPB9xpClwoXcK6eS4
 9DpkbDouG75fnqxQ4gnilUs+OgSPG61bto2LDtgwHjnaSNrn+xd7W6SN6ilu/eEnihO4Q7Zj7Oe
 V4v6JGiAlDzX2rAi3kNzAuHHnWmyzNiAW8xYZYQ6+uMbFZBJEuvGOzXg2T0tFqAUw/H5kD+EKC9
 pfjySnoTEtm6UosMb1t2lJQJqFRL6r0CReZ7ZFFMGFKGr4nOvgJC2I0Gv6RYSuV9c20MBv/mcrQ
 xIAwF5lZp336jQMyxK7Cek2PfZJcawsFHntKO2Kvjk9JYjoI13A=
X-Proofpoint-GUID: 48lxa0XfujKRu7g25Cxaq_7v_0Q2em1O
X-Proofpoint-ORIG-GUID: 48lxa0XfujKRu7g25Cxaq_7v_0Q2em1O
X-Authority-Analysis: v=2.4 cv=BYDVE7t2 c=1 sm=1 tr=0 ts=69409c91 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=UN5060LkAAAA:8 a=yPCof4ZbAAAA:8
 a=E3ObfN1v1ytJGMqOQf8A:9 a=E6eXv-vVeS7VqOnxGRGn:22 cc=ntf awl=host:13654
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251215_154134_099538_260A131D 
X-CRM114-Status: GOOD (  13.56  )
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

The SHA-256 algorithm is necessary to measure configuration information into
the TPM as early as possible before using the values. This implementation
uses the established approach of #including the SHA-256 libraries directly in
the code since the compressed kernel is not uncompressed at this point.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/boot/compressed/Makefile | 1 +
 arch/x86/boot/compressed/sha256.c | 6 ++++++
 2 files changed, 7 insertions(+)
 create mode 100644 arch/x86/boot/compressed/sha256.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 69592146ced7..0ea8a11ec271 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -113,6 +113,7 @@ $(obj)/sbat.o: $(CONFIG_EFI_SBAT_FILE)
 endif
 
 slaunch-objs += $(obj)/sha1.o
+slaunch-objs += $(obj)/sha256.o
 
 vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(slaunch-objs)
 
diff --git a/arch/x86/boot/compressed/sha256.c b/arch/x86/boot/compressed/sha256.c
new file mode 100644
index 000000000000..7795926e7e1d
--- /dev/null
+++ b/arch/x86/boot/compressed/sha256.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Apertus Solutions, LLC
+ */
+
+#include "../../../../lib/crypto/sha256.c"
-- 
2.43.7



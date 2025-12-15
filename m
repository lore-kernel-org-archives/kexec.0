Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857E3D5B87A
	for <kexec@archiver.kernel.org>; Mon, 15 Dec 2025 23:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A4g+vaEEda+sZ8z/Dq4C7vjQtFuXINAU0BeZuoAm3Lk=; b=CzKTHLb5ZYI+fSmWq9OFAtZ+mb
	2RHfi2HLngjTSQvw7UNrx44X3eSUIJTptnXWE79r/4gRQnXF6jCmdbXMZzmpIVHYwUJ0jiD3Sf20M
	spzUdbzNV3+DLMxlsXNnNW0kOjeAMnfjCVaPSj9QEPKtj0fl6hrV4PERXEYTQGi1mpsd8eLlMP7cg
	W/yxGcJBxeQsIBpyGR2XQZ5L5bwjiKnIxI7rNcwTfHAselajSbMmhwAEYVaAI9SY3DMCWTRCyzNMw
	J7gvHB4UmKqqBR9lTgNc/QHSe9hQNemNd/Q1rxZDKezggH53/poU9ImJEQCsS1JQiJSgbSYldyfDJ
	5L1zh9nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVIBU-00000004PTl-3D5Y;
	Mon, 15 Dec 2025 23:40:56 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVIBN-00000004PPu-31CH
	for kexec@lists.infradead.org;
	Mon, 15 Dec 2025 23:40:52 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFJCOt22789071;
	Mon, 15 Dec 2025 23:40:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=A4g+v
	aEEda+sZ8z/Dq4C7vjQtFuXINAU0BeZuoAm3Lk=; b=LUFA9YVPfw/2jZektGkao
	4vWr/y0hk2orNuqWCqSKrDEMJsqc5KptRG3mQfPttTkHjEZF1sLAj2e0MMhPqKUB
	yJeKrGho8dA/6N1X/RiOg1l7SKe3l3jc1oboKJdQIVkUALH2IO1pgsOr2xtUtqOQ
	+ZxVlM3qHuaPze06d+o8+5G9OSLGEpm4Dz+aEcrrcrWtcyHUZ/jn7IihWH98Hb//
	yvsV4x1d11mcVoeopuqcCxIvD/Mp9VDSgl1coWZW4h1nRllFICpQsm1cCSWj5qx6
	Q9Qw8lusI03KV+/kcstB90cwx6vxRwMb1fHl0m0hsqmbSWMZ2u8VDJ8l1h6b1HWs
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b10prk13s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 23:40:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFLGPMS024732;
	Mon, 15 Dec 2025 23:40:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk9j7hy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:40:20 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BFNeJB9003819;
	Mon, 15 Dec 2025 23:40:20 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk9j7g7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:40:19 +0000
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
Subject: [PATCH v15 07/28] tpm: Remove main TPM header from TPM event log header
Date: Mon, 15 Dec 2025 15:32:55 -0800
Message-ID: <20251215233316.1076248-8-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251215233316.1076248-1-ross.philipson@oracle.com>
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_05,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150204
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDIwNCBTYWx0ZWRfX1P1xeqnGPj4q
 GkxGmw/LH91mcw5eR07tqKVvEp1aYrQsWstTda/myA88icP9oFIeV0p3mzzlpJkJYK3XTXDiyMc
 6YN8ah8CYa5Iyb/Mox4htmA6a+i0nvB9QltaUIC6Cn/MZioERZbIE8xdytuKDSoD0b0G/WL4Mmb
 N+dvhj00GMacF2U+p2vbgt9bSDi0slO07/WKv1wKobCyIVeK5kVwqlJRh0y0DIGibKXVVaghxfT
 orHI/5otTf3/S+YcJpwc0Wprbny+ANjWGFZQEhNVge49NcqbA1MxiaVW7V45mO/NhcWPcaAAjvs
 feQDJK+z22y7Stv6rN790qwLs/npSnW7s93XPSX5dKGojKY2Z77D3UodA8uZcCqByc/IaTFgSXL
 pxgnW9d5r/G/24nXCAaLORbEGlz1bw==
X-Proofpoint-GUID: 6zX9FlYrB761x7jK09ohBUPquyAoFWvN
X-Proofpoint-ORIG-GUID: 6zX9FlYrB761x7jK09ohBUPquyAoFWvN
X-Authority-Analysis: v=2.4 cv=dParWeZb c=1 sm=1 tr=0 ts=69409c66 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=UN5060LkAAAA:8
 a=sZUTwzopkfpzz9SvmBYA:9 a=E6eXv-vVeS7VqOnxGRGn:22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251215_154050_011892_477A7C4E 
X-CRM114-Status: GOOD (  10.75  )
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

From: Alec Brown <alec.r.brown@oracle.com>

To allow TPM event log functionality to be used withouth including
the main TPM driver definitions, the main TPM driver header was
removed and replaced by only the required TPM headers.

Signed-off-by: Alec Brown <alec.r.brown@oracle.com>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 include/linux/tpm_eventlog.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index 891368e82558..cdf54b7a45c2 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -3,7 +3,9 @@
 #ifndef __LINUX_TPM_EVENTLOG_H__
 #define __LINUX_TPM_EVENTLOG_H__
 
-#include <linux/tpm.h>
+#include <crypto/sha1.h>
+#include <crypto/sha2.h>
+#include <linux/tpm_common.h>
 
 #define TCG_EVENT_NAME_LEN_MAX	255
 #define MAX_TEXT_EVENT		1000	/* Max event string length */
-- 
2.43.7



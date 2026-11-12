Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A0560A5BC7
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 11:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=43EPv11I;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OFYGakim
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=1+2KHa7ACUmbX0+tQhLkJI1u2cP6skCIz1PWkoUFcqI=; b=43EPv11IKIZ/G8
	kfwsiYIHSkVxYuoJ+VwOPN8YijggXWf95uYR0/CruEtybOTCvgS8Rd5VKNxWvQPPJROvWY7qpxniv
	8W2g9Ff3GPIhxS4/grUXas6h3TYu3497cHjymRW51s9RjIPzqX9KaJAD5twvIWroI43JRz4DQqjbQ
	otWJ8OK0i6pfDPJPS6iJAr9WpsI+a+LUa7n6ptCzFWZ39Go9YDONhIwQUWhoeI6uR2wJywdqy/ZDD
	i/9FjOMjFhHUiqDCiBZ/zAPkuHd3XhTrSaLmo8AF50Mi780hLvTaEArMBS2tXS0vqeMrLXlDwAuSR
	OQMrl0nBhRUrW+H45TLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRSrz-00000009feV-0KBE;
	Thu, 12 Nov 2026 11:21:31 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRSrq-00000009fUr-0wAS
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 11:21:27 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2iNmY1637027;
	Thu, 12 Nov 2026 11:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1+2KHa7ACUmbX0+tQ
	hLkJI1u2cP6skCIz1PWkoUFcqI=; b=OFYGakimfbuBjs7ks6MWS+II/ckkCNqNa
	eNvlXy2UWeG0qOj2ZxQFLd5ltrgz3BHuHPrh9KORLg7sHTTSJ96r+tUNZQccanPr
	MaL3vbaKDGQ7t7sZkWRhXBC4uNpMiKc1Rqyhbksy5TekMffOoEpYaO84xqazD0NY
	DGzTDWsHjsfefpDYr+MiJ7lRbSHpZdFgOVeMdLXDYp0VYfDGd8kH1FRPFCWDKWhl
	EuuAbeI9O1l6i3X8D9ap0whFUosRSyN+jTraE120bDP9c+Vs0QrNJ1T3W0gZ2fWs
	gvH7Su4W6tpK+v2BnYSK4s0IVJDpwS+9ojEbyIdh629eUpPKC5Xwg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdge45r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 11:21:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC8FInI016795;
	Thu, 12 Nov 2026 11:21:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hv3328hhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 11:21:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ACBL74O46465450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 11:21:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 100A220043;
	Thu, 12 Nov 2026 11:21:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8CAA2004B;
	Thu, 12 Nov 2026 11:21:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 11:21:06 +0000 (GMT)
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Dave Young <ruirui.yang@linux.dev>, Jiri Bohac <jbohac@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>, Usama Arif <usama.arif@linux.dev>,
        linux-s390@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 8/8] Documentation: kdump: Add s390 to crashkernel CMA
Date: Thu, 12 Nov 2026 12:21:05 +0100
Message-ID: <20261112112105.1169118-9-zaslonko@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112112105.1169118-1-zaslonko@linux.ibm.com>
References: <20261112112105.1169118-1-zaslonko@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af5a127 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=J1kqa5-BvVu_GhhgGX8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0NCBTYWx0ZWRfX08sTHnmXAIaA
 XqFyzF+JqUyra4FgtHl521CyGQHNqZU7EKbOybFsJX3rIlvugpHUD5tru87KXachmlJIWUDP7mm
 405iDxKXoVl4crbDx4E9UfHcM35LW2w1XVWZtg78YKihe7/SEpBYmmwk9piMDzBH2A73o2PAxe5
 TDFC2pcnh8k5lPUZCVNsRNpV8s5aL/MlXwju7vmVF6VJyBKfx7TIJJQmu3HLJgtNCcHd9DIfyd5
 2WpkMiOGjdAw+rxo53MRCxo/xeyILJw5TnPJoW/a8GtusTomHarfj6/gffjxpf05VwhSnil0BfP
 tiEpuVPRX6d3hml5oAnUqBScs95ZpvUFcjuUKGTVApw3sEDivvjdB6JyemQP/GsLvSlW0BAszOY
 G6f0L+s2axiP7yejuRFqEA23suNOvWRjd97+wATPDmI78maceKBersBDI2tfm1wyUWEiJf2ARjW
 Vwht/1s66MyCafbxkBA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0NCBTYWx0ZWRfXwU7zeY+VnSVX
 IPcZthku+OTyULjJkaE2GrJpukKo3+GVwk6bGYwWqp16uWIohdNpBlAJFSxgU+7QODaLjZKwAKp
 r0kMr3WxwhGP7nLfa6UsZuyPrDyErPI=
X-Proofpoint-GUID: bw5flxxGaWQGkkB2SV769r1DJ_C7OsxH
X-Proofpoint-ORIG-GUID: bw5flxxGaWQGkkB2SV769r1DJ_C7OsxH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120044
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_032122_437798_7DD3493E 
X-CRM114-Status: GOOD (  17.75  )
X-Spam-Score: -2.6 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add s390 to the architectures supporting crashkernel=size,cma and
mention that on s390 only kexec_file_load() passes the CMA memory on to
the kdump kernel.

Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
---
 Documentation/admin-guide/kdump/kdump.rst       | 3 +++
 Documentation/admin-guide/kernel-parameters.txt | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 7587caadbae1..7952e8aca67a 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -332,6 +332,9 @@ crashkernel syntax
 	less reliable and possibly incomplete kdump is preferable to no kdump at
 	all.
 
+	On s390 the CMA memory is passed on only to a crash kernel loaded with
+	kexec_file_load(), e.g. with "kexec -s -p".
+
 Boot into System Kernel
 -----------------------
 1) Update the boot loader (such as grub, yaboot, or lilo) configuration
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd9..1627c934324c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1099,8 +1099,8 @@ Kernel parameters
 			It will be ignored when crashkernel=X,high is not used
 			or memory reserved is below 4G.
 	crashkernel=size[KMG],cma
-			[KNL, X86, ARM64, RISCV, PPC] Reserve additional crash
-			kernel memory from CMA. This reservation is usable by
+			[KNL, X86, ARM64, RISCV, PPC, S390] Reserve additional
+			crash kernel memory from CMA. This reservation is usable by
 			the first system's userspace memory and kernel movable
 			allocations (memory balloon, zswap). Pages allocated
 			from this memory range will not be included in the vmcore
-- 
2.55.0



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34891CED624
	for <kexec@archiver.kernel.org>; Tue, 18 Nov 2025 11:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1LYnpw7BQsBxhdrG/PnVMrZd5dQ4MlcXe04BUtniivM=; b=W5cOOOu1p9S/tTaFcduy4q+phF
	Xkzq7kIpwS4EMcSn4NwzO2KxdT3pYPphFaPyg6WwxPv4MQZm7FEQH4OMza71DuyEZHPmkf7wJNDfi
	4o4GwZ58CLG6HNA8EZLWr2Sc2pmnPF8J2TFqJPRsjrmLhgWqN5bYlsE6AAQudXMbouIwi5YtuMnvo
	wzYb9MtMQoavImgL95mGxHTrqC0H26XLUlmNbKf1ng0OPSXb2+uqNpDkJ1nEtgaYg+XHPjrQUu5cr
	ZE7KUpLlXJkirH+EvOc50d0yr6f/XNudtr7anyNoXbEnYZXhflOFdj4JbM2PEPedYjaDmapx2VO4u
	8CCivzrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLK9M-00000000Lsv-0Yaf;
	Tue, 18 Nov 2025 11:45:32 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLK9H-00000000Lrr-1RfG
	for kexec@lists.infradead.org;
	Tue, 18 Nov 2025 11:45:29 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI105BC003015;
	Tue, 18 Nov 2025 11:45:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=1LYnpw7BQsBxhdrG/PnVMrZd5dQ4MlcXe04BUtnii
	vM=; b=E/H1KOMfYQCANcB9pYaIJnhnXJguY4Ita3mdnv3v6bECdXeVx3X9qi707
	7uGobpBUzz73ZCuSdy86/oov+thYrMqBcyfFsyWBwB0hAVUMSrptnxwLnU89qSoF
	gS4ZcIXu87qmIhKVUIv7BkY5vt2br8zG6b8enx7BMtRaszDLmBCgMZCXbM7BP/+B
	x32kByJ3UKMTNqNWqz69gMWN7Xgt9EB0b8oF1CSfI/jpC74BUGwTO9v3L162/SW5
	qCiJr9NCbkNrlfbk6nwOt4CbYT2+NdAnCNQD/+EJv8eSHIVDTcnsCYA9MU7HWZKx
	OjWw7S7AgusYEbomeOqFxeTi4+GEA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjw2k06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 11:45:25 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AIBjOXM017596;
	Tue, 18 Nov 2025 11:45:24 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjw2k04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 11:45:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AIBZ5Qo022434;
	Tue, 18 Nov 2025 11:45:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af4umtuhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 11:45:23 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AIBjJdd49480080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 11:45:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EDDC20043;
	Tue, 18 Nov 2025 11:45:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9282C20040;
	Tue, 18 Nov 2025 11:45:15 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.39.25.190])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Nov 2025 11:45:15 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan he <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>,
        Jiri Bohac <jbohac@suse.cz>, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Pingfan Liu <piliu@redhat.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Vivek Goyal <vgoyal@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        kexec@lists.infradead.org
Subject: [PATCH v6 0/3] kexec: reorganize kexec and kdump sysfs
Date: Tue, 18 Nov 2025 17:15:04 +0530
Message-ID: <20251118114507.1769455-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BanVE7t2 c=1 sm=1 tr=0 ts=691c5c55 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=voM4FWlXAAAA:8
 a=JfrnYn6hAAAA:8 a=ySsn6G4rmpzxBGPr9pgA:9 a=HkZW87K1Qel5hWWM3VKY:22
 a=IC2XNlieTeVoXbcui8wp:22 a=1CNFftbPRP8L7MoqJWF3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX2eyMoiZpzWKn
 8Ym/lXNPqe8y3VlDnSV3S8wPhOPj7E+3TVjFu66vY0iUKHk/sFoviFvnJLrR9LBeJ3parymYXvI
 Xxl5cspHwoH9rjjvybeRtJz4Gy3/3rGHyTY5vQJnZpkanJRxm0jtbDFDY03tkrM1tShGGaHCfxY
 3XE2ZecaS9S0bFA9cRdxtDwnJj2xPGcq4ZUf6KE9gAf8HSNaABuLnJoHhkJ5N5JyV38E6YCeOxa
 /4L9liHsFeS41AMBzeKWlOB9EqOoRFvW7iYo+iykAjzgtq539yXVRwQcH650lAfbg9yrX5oWOC5
 KxaEyIyOHU2l/wGeiGO5pLL8nWMO3tECPVlnQnvYCffSWJ3+UMSkYU5qm19/wG9oT72VXU3uUx6
 Eok9SSsPL5dvZY0FSQ9Sl8AY/Qvhvw==
X-Proofpoint-GUID: _MjYGZukH7LGBnnSOSWkY_C6rgEmreeq
X-Proofpoint-ORIG-GUID: SRrtRBWNnJ1LoTN24vTLy0NU7O8FerCy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251118_034527_733637_06AA4D10 
X-CRM114-Status: GOOD (  13.59  )
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

All existing kexec and kdump sysfs entries are moved to a new location,
/sys/kernel/kexec, to keep /sys/kernel/ clean and better organized.
Symlinks are created at the old locations for backward compatibility and
can be removed in the future [01/03].

While doing this cleanup, the old kexec and kdump sysfs entries are
marked as deprecated in the existing ABI documentation [02/03]. This
makes it clear that these older interfaces should no longer be used.
New ABI documentation is added to describe the reorganized interfaces
[03/03], so users and tools can rely on the updated sysfs interfaces
going forward.

Changlog:
---------

v4 -> v5:
 https://lore.kernel.org/all/20251114152550.ac2dd5e23542f09c62defec7@linux-foundation.org/
 - Splitted patch series from the above patch series

v5 -> v6:
 - Move /sys/kernel/kexec_crash_cma_ranges also to new /sys/kernel/kexec node
 - Update commit messages

Note:
This patch series is dependent on the patches:
https://lore.kernel.org/all/20251117035153.1199665-1-sourabhjain@linux.ibm.com/
https://lore.kernel.org/all/20251118071023.1673329-1-sourabhjain@linux.ibm.com/

Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan he <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Jiri Bohac <jbohac@suse.cz>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Pingfan Liu <piliu@redhat.com>
Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: kexec@lists.infradead.org

Sourabh Jain (3):
  kexec: move sysfs entries to /sys/kernel/kexec
  Documentation/ABI: mark old kexec sysfs deprecated
  Documentation/ABI: new kexec and kdump sysfs interface

 .../ABI/obsolete/sysfs-kernel-kexec-kdump     |  71 +++++++++
 .../ABI/testing/sysfs-kernel-kexec-kdump      |  26 ++--
 kernel/kexec_core.c                           | 141 ++++++++++++++++++
 kernel/ksysfs.c                               |  89 +----------
 4 files changed, 230 insertions(+), 97 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-kernel-kexec-kdump

-- 
2.51.1



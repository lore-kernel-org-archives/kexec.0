Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E9FC30653
	for <kexec@archiver.kernel.org>; Sun,  7 Jul 2024 15:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=/vxuB7kdUrMGGScm5TTAyfXR5rq6d438v6uJdVSuzUQ=; b=RIXZach6R8Crh8
	WHIAdMc0GEFKUVezW7iXM0eieUTos81AhUs7fCkqZgvvKrKo12LL1VVU87AWdkiNugaw1LUvZ79Px
	p7LY9ZJ6GzeY4m1ox9S9flJ281EFMeNd7dURsKYlL+wO4pEbq2o2dS8SUvyL9PMKfcLH/5txWx0sv
	usdrytB7XifRWRKehXY/EECEKoyNIdlpHDMz3bNR+JhEOI1+xiWwciC0uzekHqYV10+cZasL6gdiX
	WkCuTKe6MC8xoHcoohrSRYn/2e0fAv6+nMfgG1HaJkURgmSf1LUVqf+FGFRboQRe+vBx7V+NiCWU2
	mn7Mx16HY6Ecpr4KCqcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQTlQ-00000001w4X-0F5E;
	Sun, 07 Jul 2024 15:25:20 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQTlL-00000001w46-1WP2
	for kexec@lists.infradead.org;
	Sun, 07 Jul 2024 15:25:17 +0000
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 467FFEJG028450;
	Sun, 7 Jul 2024 15:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=/PHXTZUsugdDvA6sEx947c+iUpDdrDpO66qEKZp
	V95Y=; b=EGev4Z0bXwPgjZAwCl7ELph8XYCZ35PA+gthdZ0RWXeTLXjzENN6vNM
	9g7nzurlXIr9m2zZgz0Ed3AnKgoPqguj6Ua4lGqRqLIkf7q5Jp38o1PToF1EjcOV
	CKDip1HNf7TJ0dpKKcnzw4ekvJAlwe26hUgz1eKP2jf1TOKxHy3EFdSCX5Nkr5dO
	D3twmhYIV2J8t1xmfk6/T+ccpl4rKKo59IHGtQcN8+9ehNi1Ru1kxdRy0qXb0x13
	poWWnZwG2pYcXZoI36/Qos44Hr7INQgSUvOIN3WquckxRyP8cDUn/aPtk6PWW0kj
	9Q9bci3ZgKHkRWk+edH//LyF8lra08Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 407u23r8c4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 15:25:10 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 467FP9IY009539;
	Sun, 7 Jul 2024 15:25:09 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 407u23r8c2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 15:25:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 467ES4aB013901;
	Sun, 7 Jul 2024 15:25:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407gn0asyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 15:25:08 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 467FP2dx52101578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Jul 2024 15:25:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B186220063;
	Sun,  7 Jul 2024 15:25:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5B0820040;
	Sun,  7 Jul 2024 15:24:59 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.10.232])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  7 Jul 2024 15:24:59 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: kexec@lists.infradead.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
        Coiby Xu <coxu@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Simon Horman <horms@kernel.org>
Subject: [PATCH v3 0/3] Enable crash hotplug support on powerpc
Date: Sun,  7 Jul 2024 20:54:53 +0530
Message-ID: <20240707152456.87899-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qhkpJw-O6ZAgxR2OBupNqtG7cRYJAFdt
X-Proofpoint-ORIG-GUID: uJldsYyqIkH7bKHQid2yJL9sIhd_YvPO
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-07_06,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=514 mlxscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0 clxscore=1015
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2407070126
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240707_082515_541678_22CB7067 
X-CRM114-Status: GOOD (  18.31  )
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

The primary goal of this patch series is to enable crash hotplug on
powerpc architecture for the `kexec_load` system call.

The first patch in the series introduces a new kexec flag added in the
kernel to generalize crash hotplug support. The second patch enables
crash hotplug support on PowerPC for `kexec_load` system call. The third
patch updates the documentation about crash hotplug support.

Changes log:

v4:
  - Do not remove the KEXEC_UPDATE_ELFCOREHDR kexec flag. It is needed to
    maintain backward compatibility on x86. 1/3
  - Send the KEXEC_UPDATE_ELFCOREHDR kexec flag for x86, and for the rest
    of the architectures, send KEXEC_CRASH_HOTPLUG_SUPPORT to enable
    crash hotplug support kexec_load system call. 1/3
  - Since there is a significant change in 1/3, hence Hari's Acked-by
    is removed form only first patch. 1/3
  - Rename and reorder the function arch_do_exclude_segment() parameters
    as suggested. 1/3
  - Keep the implementation of arch_do_exclude_segment() function same
    for x86_64 and i386. 1/3

v3:
  https://lists.infradead.org/pipermail/kexec/2024-July/030361.html
  - Updated --hotplug option description 3/3

v2:
  https://lists.infradead.org/pipermail/kexec/2024-June/030309.html
  - Find CPUs in the system using the /sys/devices/system/cpu/present sysfs
    instead of traversing all nodes under /proc/device-tree/cpus. 2/3
  - Added a new function to find present CPUs in the system. 2/3
  - Removed unnecessary NULL check on seg_ptr from arch_do_exclude_segment(). 2/3
  - Updated --hotplug option description 3/3

v1:
  https://lists.infradead.org/pipermail/kexec/2024-May/030051.html


Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Coiby Xu <coxu@redhat.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>

Sourabh Jain (3):
  kexec_load: Use new kexec flag for hotplug support
  powerpc/kexec_load: add hotplug support
  doc/hotplug: update man and --help

 kexec/arch/arm/kexec-arm.c             |   5 +
 kexec/arch/arm64/kexec-arm64.c         |   5 +
 kexec/arch/cris/kexec-cris.c           |   4 +
 kexec/arch/hppa/kexec-hppa.c           |   5 +
 kexec/arch/i386/kexec-x86.c            |   8 +
 kexec/arch/ia64/kexec-ia64.c           |   4 +
 kexec/arch/loongarch/kexec-loongarch.c |   5 +
 kexec/arch/m68k/kexec-m68k.c           |   5 +
 kexec/arch/mips/kexec-mips.c           |   4 +
 kexec/arch/ppc/kexec-ppc.c             |   4 +
 kexec/arch/ppc64/crashdump-ppc64.c     |  16 +-
 kexec/arch/ppc64/fdt.c                 | 236 ++++++++++++++++++++++++-
 kexec/arch/ppc64/include/arch/fdt.h    |   2 +-
 kexec/arch/ppc64/kexec-elf-ppc64.c     |   2 +-
 kexec/arch/ppc64/kexec-ppc64.c         |  12 ++
 kexec/arch/s390/kexec-s390.c           |   5 +
 kexec/arch/sh/kexec-sh.c               |   5 +
 kexec/arch/x86_64/kexec-x86_64.c       |   8 +
 kexec/kexec-syscall.h                  |   1 +
 kexec/kexec.8                          |   8 +-
 kexec/kexec.c                          |  44 ++++-
 kexec/kexec.h                          |   2 +
 22 files changed, 373 insertions(+), 17 deletions(-)

-- 
2.45.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

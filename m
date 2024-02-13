Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A1FC4829A
	for <kexec@archiver.kernel.org>; Tue, 13 Feb 2024 11:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=JQ7wFdwxJQjpygkTPphyLHTSAG0vQj88PkkGZDeR1vs=; b=ecl58I/l14Y6sw
	mi2NKTNnUwpJy5DlSv0HkBB1HqFFCKQJz3ABBULHpeWhCK7TK+zcnHIhytMjRdkwdx3h9QoYlvUQw
	wQRjVmiVSJnXFAOQ0Kvm7FSFcYpBhATTJ8bjy0pdXsBV8m5iMWDLE+wjXUMfVr9G1IK36a2JjovGx
	yIo+4SxtzRD0rusFs50usO8htDnqrfohlf4J05eA9j5ohdmHoWQySs/RfF3tx9l4aT9PiiTdDXNcg
	YMTYdOVTsNQUupGpoSpGcZCiiDoO3rQfYK0NbQ5Mfut4dBFvj/0lMdBfqw+2bHQ/5sHD/h0PQ+/4m
	S27W+v/gQGtuKUtPsEsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZr1H-000000091jx-10lB;
	Tue, 13 Feb 2024 11:32:11 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZr1E-000000091iF-1o0p
	for kexec@lists.infradead.org;
	Tue, 13 Feb 2024 11:32:09 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DAChBR021621;
	Tue, 13 Feb 2024 11:32:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=v5eOYAD3vQP8tXuNI25ANhkOk62PwdiviuqOYCZc6mQ=;
 b=Lj4/MCUvuhNWcOPh0pIi4/RCRMxPR5LstQKK1Xk7lsOpna/V76PklQsOBN/fAOKH6GCT
 ZTITRv/OyoCBurvMgsrvbCPSF8MylqcUStPEDsmpYfAmoqPweFuizGp2P1P9WxjzbZjD
 uPjz5tIZ6t5TyQ/e3NXz0RMkiOn3e+XIYgVsb4vrQWsH+FgvCBM7uFFnou8AQGKY/iVL
 TwL9SKy2EM/g2U2T01pUKQOGFuTZCYyQpGXJzvfOr6t7caXDAvBtF+mrjpGg1ieHXNTF
 gi1J1WIrc+uw3mWNbm+JQMcwPDolYj351Djagf+rdfy3skCw+zUUXtVxaYGw+EJAoDxc 2A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w86fk2692-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 11:32:00 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41DACunT022210;
	Tue, 13 Feb 2024 11:32:00 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w86fk268m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 11:31:59 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41D8GO13024908;
	Tue, 13 Feb 2024 11:31:59 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mfp70wt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 11:31:59 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41DBVs1X50528648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 11:31:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDD002004F;
	Tue, 13 Feb 2024 11:31:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 595B920040;
	Tue, 13 Feb 2024 11:31:51 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.in.ibm.com (unknown [9.203.115.195])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Feb 2024 11:31:51 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Kexec-ml <kexec@lists.infradead.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH linux-next 0/3] powerpc/kexec: split CONFIG_CRASH_DUMP out from CONFIG_KEXEC_CORE
Date: Tue, 13 Feb 2024 17:01:46 +0530
Message-ID: <20240213113150.1148276-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: P542-OlHxRQZS5TxbV4z1B4EOhaNplWn
X-Proofpoint-GUID: vmkQYWnnC_uZN7NssJOsJjBR1KcZDomN
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_06,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=921
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0
 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130091
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240213_033208_606130_AA35506F 
X-CRM114-Status: GOOD (  14.56  )
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

This patch series is a follow-up to [1] based on discussions at [2]
about additional work needed to get it working on powerpc.

The first patch in the series makes struct crash_mem available with or
without CONFIG_CRASH_DUMP enabled. The next patch moves kdump specific
code for kexec_file_load syscall under CONFIG_CRASH_DUMP and the last
patch splits other kdump specific code under CONFIG_CRASH_DUMP and
removes dependency with CONFIG_CRASH_DUMP for CONFIG_KEXEC_CORE.

[1] https://lore.kernel.org/all/20240124051254.67105-1-bhe@redhat.com/
[2] https://lore.kernel.org/all/9101bb07-70f1-476c-bec9-ec67e9899744@linux.ibm.com/


Hari Bathini (3):
  kexec/kdump: make struct crash_mem available without CONFIG_CRASH_DUMP
  powerpc/kexec: split CONFIG_KEXEC_FILE and CONFIG_CRASH_DUMP
  powerpc/kdump: Split KEXEC_CORE and CRASH_DUMP dependency

 arch/powerpc/Kconfig               |   9 +-
 arch/powerpc/include/asm/kexec.h   |  98 +++++------
 arch/powerpc/kernel/prom.c         |   2 +-
 arch/powerpc/kernel/setup-common.c |   2 +-
 arch/powerpc/kernel/smp.c          |   4 +-
 arch/powerpc/kexec/Makefile        |   3 +-
 arch/powerpc/kexec/core.c          |   4 +
 arch/powerpc/kexec/elf_64.c        |   4 +-
 arch/powerpc/kexec/file_load_64.c  | 269 +++++++++++++++--------------
 include/linux/crash_core.h         |  12 +-
 10 files changed, 208 insertions(+), 199 deletions(-)

-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

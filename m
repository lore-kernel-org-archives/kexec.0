Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 964A8EE4997
	for <kexec@archiver.kernel.org>; Wed, 11 Sep 2024 11:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=twyJyJK0IO8JtnnVmHM50GbdCDEX8T/8Fs0drzjsG0I=; b=DC3I7HAtyDUx7i
	SeLNDsiuIicA4u2ZXqpBDxqpdFmojXUt4kraZkoX9h7BK9Lnq9dt6T+25T3R5ojjmmBUgnG0RvQE0
	ra4ekLgUcRW6SjW9HmGQpbzApRzJXABmXsCUGpFWmlOKQOtG9121fl71qO9Dt4LYXrwiLz08rGhIW
	oxQOO6yylpmIbuN4wleMlfSKHXU4fIHhZYpTbFmisHNcXBASYmDAKQnop/ZHZJyFVJbZ9i18MBh/u
	CGgLsy7+jpLs0SeVr16ozYKvSzi/LRXeZE8K2/lR/ZnK31tGEoxErc3CAQjMcoaBKIBYjtDbwnFnw
	1pzFEVsKeqAsrezgSBUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soLQO-00000009H8D-0mTA;
	Wed, 11 Sep 2024 11:22:16 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soLPZ-00000009H1o-3NWL
	for kexec@lists.infradead.org;
	Wed, 11 Sep 2024 11:21:27 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48B4tC8W017485;
	Wed, 11 Sep 2024 11:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=nBF5sI29Rox57tDf+dFBWrQ9inWyIhlzi9IfNsS
	nFRU=; b=oFtZMlkXigY4rAgSoR6KVg3y7WuNKQnQsHm6B2uLhUIsuKt9lYQahMS
	KcmnGMDojPmi/JAsestRyHwr6nXy23uTV/Z2ZgwKuXV8+0Ufyf8q8qUYJiQ7qpFs
	kvzUmyabBahTp6RDxj6zBSknSIfLwkEjrk8Hc4lIwKu6wgdG3nJrbcOL8C2/khKq
	wVbTx8Wx/WU/hmWUaIFeh//hJ7f6POxYx10qSWsG7ehX+cqfaHPUmvqXkzjYLSj4
	Q7YDiq6Y0W4aU220jL6orHXqgBphZbU8/1rxIEmFrytbMy4oF2V716+DAqm8udXD
	q6RsZcvS8VqtoQOi8lnlvuzQDLKA2BQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gejanbch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 11:21:20 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48BBIUAY002556;
	Wed, 11 Sep 2024 11:21:19 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gejanbc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 11:21:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48B9qfRh032415;
	Wed, 11 Sep 2024 11:21:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h1j0s8qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 11:21:18 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48BBLGWW50463098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 11:21:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29C8E20049;
	Wed, 11 Sep 2024 11:21:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B57620040;
	Wed, 11 Sep 2024 11:21:13 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.116.75])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Sep 2024 11:21:12 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: bhe@redhat.com
Cc: Hari Bathini <hbathini@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
Subject: [PATCH RESEND v2] kexec/crash: no crash update when kexec in progress
Date: Wed, 11 Sep 2024 16:51:11 +0530
Message-ID: <20240911112111.108056-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5LbiWJagaFGoMF1stH_GnUIYrKVP5C8F
X-Proofpoint-GUID: oec8U_PFtdv40NkCfJS3AG_OrhMxS7PD
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409110082
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_042125_873086_AE2DC7A6 
X-CRM114-Status: GOOD (  19.11  )
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

The following errors are observed when kexec is done with SMT=off on
powerpc.

[  358.458385] Removing IBM Power 842 compression device
[  374.795734] kexec_core: Starting new kernel
[  374.795748] kexec: Waking offline cpu 1.
[  374.875695] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
[  374.935833] kexec: Waking offline cpu 2.
[  375.015664] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
snip..
[  375.515823] kexec: Waking offline cpu 6.
[  375.635667] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
[  375.695836] kexec: Waking offline cpu 7.

To avoid kexec kernel boot failure on PowerPC, all the present CPUs that
are offline are brought online during kexec. For more information, refer
to commit e8e5c2155b00 ("powerpc/kexec: Fix orphaned offline CPUs across
kexec"). Bringing the CPUs online triggers the crash hotplug handler,
crash_handle_hotplug_event(), to update the kdump image. Since the
system is on the kexec kernel boot path and the kexec lock is held, the
crash_handle_hotplug_event() function fails to acquire the same lock to
update the kdump image, resulting in the error messages mentioned above.

To fix this, return from crash_handle_hotplug_event() without printing
the error message if kexec is in progress.

The same applies to the crash_check_hotplug_support() function. Return
0 if kexec is in progress because kernel is not in a position to update
the kdump image.

Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: kexec@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Cc: x86@kernel.org
Reported-by: Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
Changelog:

Since v1:
 - Keep the kexec_in_progress check within kexec_trylock() - Baoquan He
 - Include the reason why PowerPC brings offline CPUs online
   during the kexec kernel boot path - Baoquan He
 - Rebased on top of #next-20240910 to avoid conflict with the patch below
   https://lore.kernel.org/all/20240812041651.703156-1-sourabhjain@linux.ibm.com/T/#u

V2 RESEND:
 - Update linuxppc-dev mailing list address
---
 kernel/crash_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index c1048893f4b6..078fe5bc5a74 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -505,7 +505,8 @@ int crash_check_hotplug_support(void)
 	crash_hotplug_lock();
 	/* Obtain lock while reading crash information */
 	if (!kexec_trylock()) {
-		pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
+		if (!kexec_in_progress)
+			pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
 		crash_hotplug_unlock();
 		return 0;
 	}
@@ -547,7 +548,8 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
 	crash_hotplug_lock();
 	/* Obtain lock while changing crash information */
 	if (!kexec_trylock()) {
-		pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
+		if (!kexec_in_progress)
+			pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
 		crash_hotplug_unlock();
 		return;
 	}
-- 
2.46.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

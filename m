Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C638CC3DA78
	for <kexec@archiver.kernel.org>; Sun, 15 Jan 2023 15:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gSKv/OAeyYDxsxsCHIqt4jKUvEDb7zuC+4xQwteC2Go=; b=ntF4STecPoB8Ew
	fnP+kDuQECanWnE2W7d7hh7irDwarZ3gRay92vou703u4wBZUZ4QO8FNxkIJJJg/XJM0RUQ7Cw+0Z
	iJkJ8E0ZoT4tj1W2I0ge+JXdFNLcDQcrIqo49tVt6PbavRKUVt7+XyvRMeMur43FcHVG0ScKDU3uc
	Xl9tQsgTdgVh0Y1729PvPOnhx8invKS9zBIlHCKazihFkv9Pxf6LX8pNXKxknpvL+aBY/hQ60lwcM
	H0a3j9AY4YmCNb8HZJm9UCEqFG6pXw6YfoZ8PKonmk+tFDGr0oO0goRYKhuDKq1gBOqnkZsl6Bi7f
	mJvkr3Oj/k8fHjxWQY0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pH4Wr-007Wwe-V9; Sun, 15 Jan 2023 15:02:37 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5] helo=mx0a-001b2d01.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pH4Wo-007WvF-LX
	for kexec@lists.infradead.org; Sun, 15 Jan 2023 15:02:36 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30F9iSfB022040;
	Sun, 15 Jan 2023 15:02:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=x1TSs41BXU6g82kRoXK+gar3paqNQWmWJ9Ct9kzMEBA=;
 b=OJxeHch+GHLoQlRFP76H6sCCNIi8P8dF0t+nX2I7Ur0XUvBAxw6a/DQnT+z9MpA4c3EQ
 fU7htEFpNh1YqjYnGUBpr6rarUNyuc+i0gO68WojN2lYx6dXHwJ47cLC7w/ilNN8yLFH
 pz3PGjNF4GuZfg6kgQYEn1S5ErdjyuusJcVd7w5MTSZCKBR9/wmPWNJbv1KA5eNiHD9s
 rVAU6fw2p3nJH468AjVaxo8PacZpEjWUU9aDKEGMU0Ho9eSlbZ3unVL7LjFnHRrMjwEp
 hvu/tB+hbtaS9yeGHWrupw9kJ+d2pnMuDBAsm5uTmvrGsgj1z/bz0eoLEpcNHX2x4ijb +A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n4f463jdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Jan 2023 15:02:31 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30FF08Po015153;
	Sun, 15 Jan 2023 15:02:30 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n4f463jd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Jan 2023 15:02:30 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
	by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30F1tHkg009485;
	Sun, 15 Jan 2023 15:02:28 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n3knfhcw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Jan 2023 15:02:28 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30FF2Pvg21889660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Jan 2023 15:02:25 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D45C20040;
	Sun, 15 Jan 2023 15:02:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CC8620043;
	Sun, 15 Jan 2023 15:02:22 +0000 (GMT)
Received: from sjain014.ibmuc.com (unknown [9.43.71.156])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 15 Jan 2023 15:02:21 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v7 4/8] crash: add phdr for possible CPUs in elfcorehdr
Date: Sun, 15 Jan 2023 20:32:02 +0530
Message-Id: <20230115150206.431528-5-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230115150206.431528-1-sourabhjain@linux.ibm.com>
References: <20230115150206.431528-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zaF3s52WwYB1ys_5dt6TnLCwhfpJFrBl
X-Proofpoint-ORIG-GUID: 2Bn0gJgcRx1bQ8PC2GIjwG7WxPYARb9F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-15_09,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301150112
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230115_070234_842129_4D7A9A53 
X-CRM114-Status: GOOD (  19.03  )
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
Cc: eric.devolder@oracle.com, bhe@redhat.com, kexec@lists.infradead.org, ldufour@linux.ibm.com, hbathini@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On architectures like PowerPC the crash notes are available for all
possible CPUs. So let's populate the elfcorehdr for all possible
CPUs having crash notes to avoid updating elfcorehdr during in-kernel
crash update on CPU hotplug events.

The similar technique is used in kexec-tool for kexec_load case.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 kernel/crash_core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 910d377ea317e..19f987b3851e8 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -364,8 +364,8 @@ int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
 	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
 	ehdr->e_phentsize = sizeof(Elf64_Phdr);
 
-	/* Prepare one phdr of type PT_NOTE for each present CPU */
-	for_each_present_cpu(cpu) {
+	/* Prepare one phdr of type PT_NOTE for possible CPU with crash note. */
+	for_each_possible_cpu(cpu) {
 #ifdef CONFIG_CRASH_HOTPLUG
 		if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
 			/* Skip the soon-to-be offlined cpu */
@@ -373,8 +373,11 @@ int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
 				continue;
 		}
 #endif
-		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
+		if (!notes_addr)
+			continue;
+
+		phdr->p_type = PT_NOTE;
 		phdr->p_offset = phdr->p_paddr = notes_addr;
 		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
 		(ehdr->e_phnum)++;
-- 
2.39.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

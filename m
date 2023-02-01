Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A08C38142
	for <kexec@archiver.kernel.org>; Wed,  1 Feb 2023 06:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oDl1Zib3Vu890f7zTNTWOxswSAHm8EoDDs8wYsD46rA=; b=HcKSRMn2L7bvns
	h0OIsfHne+wUCej3guBm6WyFo25vFEp3EeDN70GecL/Aj3U0JZWzGxR+nVIqw/fy9EqmROLI7YcQl
	UM5+E0THbwm2oVzPEGYygfrotQwtfCWtrXuhZ5pxqO7+jXaJDuf8C+e9VjaF4HeqJO5Ti/YIne/TC
	vqcpJ76eI/14wnd7uNuG8hW5c70quCcgaS1dFmaTAl9NGOQAXo2kbkxHNBmXGXPYtXx/IZ2wXwCB+
	HCIodS0B/swsbazlCT5Bv25G12J0L9Yul8sk+HeRPhNg3sYLZSgSqeCSx3qx3TRKR1qzrYU4U2lTO
	7a/SM4TfgNtO+CMIUehQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pN6lv-00AUAx-Is; Wed, 01 Feb 2023 06:39:07 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5] helo=mx0a-001b2d01.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pN6lp-00AU7x-Uj
	for kexec@lists.infradead.org; Wed, 01 Feb 2023 06:39:04 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3116W1Xn011706;
	Wed, 1 Feb 2023 06:38:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=MWrrAhNQnf5rNd5GpBWkPYS6Z/b/2OekecHK+zL225I=;
 b=Ejxb4BsuPTbbGCOJZYiX/qFvoT+XrOjNIfZD7BICkdme91KhCNLncl9CD8Pg7Eb7b0j6
 1qeyGbdbAkp413sK3OlnqaAIE8tuuDRqPue7Ie0bT12Kb/O1LFw+ZepNt+loFQd7RzO+
 ScDPaRQc+cvhj6uq6GoWlv6tSsf1cNdk+KS+rf1/clH0jND20/kstSK8z3ClkmlsphIP
 sNnmHcA2+9boDKn3N0xicN8HYtECe98DSnFqh+GoLRw90k3/noukfCvVRSKMw9HAqgBv
 Vuz9M3V+32k05WAITrAFzoK6D2qtycpM03lFN+R9LjJMWej6UENKQl/LQGuy18VyOH31 qg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nfjw7g5nn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Feb 2023 06:38:58 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3116anXG028951;
	Wed, 1 Feb 2023 06:38:58 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nfjw7g5kc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Feb 2023 06:38:57 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
	by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3115nufh007694;
	Wed, 1 Feb 2023 06:38:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3ncvugk5np-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Feb 2023 06:38:56 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3116cqkM47972862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Feb 2023 06:38:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C90E2004B;
	Wed,  1 Feb 2023 06:38:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 889DA20040;
	Wed,  1 Feb 2023 06:38:50 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.109.52])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Feb 2023 06:38:50 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v8 4/8] crash: add phdr for possible CPUs in elfcorehdr
Date: Wed,  1 Feb 2023 12:08:37 +0530
Message-Id: <20230201063841.965316-5-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201063841.965316-1-sourabhjain@linux.ibm.com>
References: <20230201063841.965316-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: s3tro_3Ufzmk34olfJMr8rwECy6idqel
X-Proofpoint-GUID: tS8vlvwT7G-DBJrhSqYx-3URYuo1EJsu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_02,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302010056
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230131_223902_128539_7C16256F 
X-CRM114-Status: GOOD (  19.41  )
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
index 37c594858fd51..898d8d2fe2e2e 100644
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
2.39.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

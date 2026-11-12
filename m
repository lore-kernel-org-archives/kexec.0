Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA11606B36F
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PUiE4H53;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=q331z1jE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=zwgDmO4ND7xhOm/QXMaaI73mXpHEQ07IXAPk0c8/tSc=; b=PUiE4H53PbGyiI
	w2HLvVJMBlVCNvt/C4CSCgg83MSjVGRbhohn0cjyM3fd0pVLZ0kSxwMwn5IhFNRjBVbTysy03p4NS
	DfQF4zwQu+5DktBywreG41zjqghC1EdF0tNIX+wpdlk1ieOONq0aUTF1M6595ol08rTFw0brVKs91
	yCki3TI0hnkDl1hd0gRDO5UX8XsdMK5aYXng0JQLn+pEAZGC/sVOEwmP2Flyv+TUAlnjto9TTD6+u
	uiCb9+8j5n/AXbjs28Mjpk1W79TtsCP0FMjAnlOUWKnVGkl3yg7EnWxFsAueqc87uIc9/yghCWSOL
	n59bqQAmmsR7V4gEVe2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRSs7-00000009flJ-3NQV;
	Thu, 12 Nov 2026 11:21:39 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRSrp-00000009fUu-3ZWk
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 11:21:28 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2ib543054262;
	Thu, 12 Nov 2026 11:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zwgDmO4ND7xhOm/QX
	MaaI73mXpHEQ07IXAPk0c8/tSc=; b=q331z1jEBQLVDDvplcTsay5oHBSZN/egP
	6ouaU8JbqHht2mlzuowDshSOvac3G70GckGw22fGWlwC6u3Xg/3y+GZvHG396YI/
	tAH+P4mCGSUgIz6CRm0W/2h7ktn+wqkFcboGjo2mTT4dXsSI9NHiSga9GnhIHoPa
	H1yFf9KCI0r7BpVUJkmFvyw75bDDU/BW0LxSDk6UEAhevJ7wA1z7tFSM2rmRGxMn
	fKZXdAJjLPNAfvhjo68qPX7l9N7/KjcsabJXqUm+wsFkyF+4EmP8vQfsZHY10ORF
	B1DcSuHMQW443w+1fv+7a+AtAjSjlNisofbZD9+XkGhiwc17NRuvw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug6f60y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 11:21:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC89b53016811;
	Thu, 12 Nov 2026 11:21:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hv3328hhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 11:21:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ACBL6Fn29294980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 11:21:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5B7F2004B;
	Thu, 12 Nov 2026 11:21:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78F1D20043;
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
Subject: [PATCH v1 6/8] s390/kdump: Use crashkernel CMA memory in the kdump kernel
Date: Thu, 12 Nov 2026 12:21:03 +0100
Message-ID: <20261112112105.1169118-7-zaslonko@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112112105.1169118-1-zaslonko@linux.ibm.com>
References: <20261112112105.1169118-1-zaslonko@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: V0U5VPR0yCT_JJ2H8BK6VDA5fHpRYPT6
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af5a127 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=1GaGBeEFQyhiT5z3ZTwA:9
X-Proofpoint-GUID: V0U5VPR0yCT_JJ2H8BK6VDA5fHpRYPT6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0NCBTYWx0ZWRfX8sLw6kaEGwCH
 xoS/hhrTF19WYk9W3fpqHbzPn7AsuHbP03FmltnKNuNS+QkkBxUkkoQxj2U72UdvKDcF1Bo2mCd
 ynqw3HIjxK3Ku8MMp/dtjw8xPS84u6+v1VBO+/w7zBrp/AYphXfwvdQ8m376Sim4iVlYvTGO1G3
 fxEYRFzjCTbtK7DoR5Mu6957dVMXQyw7BovLXCmluvqVSTIWMznhShfAyktqDD9Pa01A1Vsb5rY
 PuZOdPCMzsbIa2ct+9wjghMXtp7l01MjXyLepgMGCO5gzY9YZiYWaJPNA9Bt5WCYPVIcC9odvIz
 HZCEDEVOwkHW4noivrO8vhzl588vXW7k/QM5Fk9UCOdW4QixnZDHuRklAXZLpafT2x3ZKm1EHuu
 4xF/8j5X9DHB2NzP18PEYZuHdSWeBIDIg/PjmnMVjxxC3EU24fltxUr+Bkrd/qNXYz4VfgjslU8
 01DMubLp/XBvaie/Ibw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0NCBTYWx0ZWRfX/xYW/IpbtBar
 whVaY0bRWLpZmv0VqL82mmE13gOSxSNLnaZTAsmrgKvwm1Pt5NKyDhh3DrFfXzZ0Uy/Kz4+jUN/
 Gp1Na0Nq90ss5tzEX4fptlxDEDuUibY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120044
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_032121_918213_E9B6B7E5 
X-CRM114-Status: GOOD (  23.43  )
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

A kdump kernel limits ident_map_size to the crashkernel size, so it
can't use the crashkernel CMA memory above it.

Don't limit ident_map_size when CMA ranges are passed. Instead, add the
crashkernel memory and the CMA ranges as usable memory ranges. All
other memory is treated as a memory hole.

The CMA memory is then mapped, added to memblock and freed to the buddy
allocator like any other memory. As the boot allocator starts at
ident_map_size, decompressor allocations such as page tables, the KASAN
shadow and the initrd moved by rescue_initrd() come from the CMA memory
first.

Like oldmem_base and oldmem_size, the ranges are used as passed by the
crashed kernel.

Co-developed-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
---
 arch/s390/boot/startup.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
index 111b146a3332..dba1dfc0ee49 100644
--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -197,6 +197,22 @@ static void deploy_kernel(void *output)
 }
 #endif
 
+static void setup_usable_memory(void)
+{
+	unsigned long start;
+	int i;
+
+	if (!IS_ENABLED(CONFIG_CRASH_DUMP) || !oldmem_data.start) {
+		physmem_add_usable_range(0, ident_map_size);
+		return;
+	}
+	physmem_add_usable_range(0, oldmem_data.size);
+	for (i = 0; i < ARRAY_SIZE(oldmem_data.crashk_cma) && oldmem_data.crashk_cma[i].size; i++) {
+		start = oldmem_data.crashk_cma[i].start;
+		physmem_add_usable_range(start, start + oldmem_data.crashk_cma[i].size);
+	}
+}
+
 static void rescue_initrd(unsigned long min, unsigned long max)
 {
 	unsigned long old_addr, addr, size;
@@ -270,8 +286,9 @@ static void kaslr_adjust_got(unsigned long offset)
  * 2. CONFIG_MAX_PHYSMEM_BITS - the maximum size of physical memory the
  *    kernel is able to support.
  * 3. "mem=" kernel command line option which limits physical memory usage.
- * 4. OLDMEM_BASE which is a kdump memory limit when the kernel is executed as
- *    crash kernel.
+ * 4. OLDMEM_SIZE limits the identity map to primary crashkernel memory
+ *    when OLDMEM_BASE is set and no crashkernel CMA ranges are passed.
+ *    With CMA ranges, setup_usable_memory() selects the usable ranges.
  * 5. "hsa" size which is a memory limit when the kernel is executed during
  *    zfcp/nvme dump.
  */
@@ -287,7 +304,9 @@ static void setup_ident_map_size(unsigned long max_physmem_end)
 #ifdef CONFIG_CRASH_DUMP
 	if (oldmem_data.start) {
 		__kaslr_enabled = 0;
-		ident_map_size = min(ident_map_size, oldmem_data.size);
+		/* no CMA ranges handed over to the crashkernel */
+		if (!oldmem_data.crashk_cma[0].size)
+			ident_map_size = min(ident_map_size, oldmem_data.size);
 		boot_debug("kdump memory limit:  0x%016lx\n", oldmem_data.size);
 	} else if (ipl_block_valid && is_ipl_block_dump()) {
 		__kaslr_enabled = 0;
@@ -545,8 +564,7 @@ void startup_kernel(void)
 	setup_ident_map_size(max_physmem_end);
 	setup_vmalloc_size();
 	asce_limit = setup_kernel_memory_layout(kernel_size);
-	/* got final ident_map_size, physmem allocations could be performed now */
-	physmem_add_usable_range(0, ident_map_size);
+	setup_usable_memory();
 	physmem_set_alloc_limit(ident_map_size);
 	detect_physmem_online_ranges(max_physmem_end);
 	save_ipl_cert_comp_list();
-- 
2.55.0



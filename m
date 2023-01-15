Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F91C67871
	for <kexec@archiver.kernel.org>; Sun, 15 Jan 2023 15:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kJYZ2GVksWGJCOwZzuEA10anJc8ZWyTRFmncklMM0n0=; b=hOyejJ7KS1F9Hu
	adDkfJQPxNT5j72IQn9YBeqvTiYkqQi6RmE+UV7Kg+yHy3bFo579OeEgYm5/vs7AKylN1Lo3E1Lg5
	y9YjkQX4lW6tq4XAr4f/qNa6mKbZP4LLA5YQJJTmACfJ5mzvHfaMdXHKVpX8JqPQk1KxzccCvbgAg
	gwiduB5XanNPd78Xjx1Bclwo4uoc2+PX1YmEvPbcV61wMMfoPZBhRmOMWRGGZfyRK5hKOLkbEMBps
	xzRixc+qz1aaSeckcuF0ookpoLs/ipEPQWM04cufun8v5rQmS6akF8h1OKoQNiQ4QDzYXCH27weor
	UJAf4VssTUVCjssiHOVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pH4Wo-007WvQ-QK; Sun, 15 Jan 2023 15:02:34 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pH4Wk-007WuQ-Em
	for kexec@lists.infradead.org; Sun, 15 Jan 2023 15:02:31 +0000
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30FDNJus008147;
	Sun, 15 Jan 2023 15:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=se/AbKxEAzPGIT8b7kYc0WK57vD4QgbFQND1jbMcWVU=;
 b=m3x3qRGZLnblb6OopdO+jnMDpt3XGlnSH2yqh+IOYeTF1e+fBardjrq9IKMn09ud/u17
 X+jbz42KkekhCF0ftKORpVTvedOo6/3dOvobezLrdWehzf0jylyrZ10sVWKsv1paXE7C
 u/s3z6sm++C90KxnmQo5N8L+uOK4u5PphZKcVZ3iKUivvI3FGfFIyPzv1UezPKbcxaQG
 65v7UcBvoezkUB4CJFMKPSMQbaq+SYtQj4dPVHLR4Oyvqa+GbvD7MpVt+HLYlrh3gX3T
 YwgAmw2dSTa1R8Pgoel3mk6i4jGYd4H2d8/3lB0SH4q4RehdRmaOZURWslLCL2YXn1iM XQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n4cvw5k0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Jan 2023 15:02:28 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30FF0Olg000770;
	Sun, 15 Jan 2023 15:02:27 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n4cvw5k00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Jan 2023 15:02:27 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
	by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30F1lAgn006229;
	Sun, 15 Jan 2023 15:02:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n3knfhcvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Jan 2023 15:02:25 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30FF2LBn40894956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Jan 2023 15:02:21 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B8D92004B;
	Sun, 15 Jan 2023 15:02:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB9AF20040;
	Sun, 15 Jan 2023 15:02:18 +0000 (GMT)
Received: from sjain014.ibmuc.com (unknown [9.43.71.156])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 15 Jan 2023 15:02:18 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v7 3/8] powerpc/crash: update kimage_arch struct
Date: Sun, 15 Jan 2023 20:32:01 +0530
Message-Id: <20230115150206.431528-4-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230115150206.431528-1-sourabhjain@linux.ibm.com>
References: <20230115150206.431528-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: k3FhR-SJjy1pGfRBPviQy0fBGsFU3cPl
X-Proofpoint-GUID: UKiRXUiOpl6GxEnJhd1gQkvWTRdvDLj5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-15_09,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301150116
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230115_070230_517244_EDB1CDCE 
X-CRM114-Status: GOOD (  20.24  )
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

Add a new member "fdt_index" to kimage_arch struct to hold the index of
the FDT (Flattened Device Tree) segment in the kexec segment array.

Having direct access to FDT segment will help arch crash hotplug handler
to avoid looping kexec segment array to identify the FDT segment index
for every FDT update on hotplug events.

The fdt_index is initialized during the kexec load for both kexec_load and
kexec_file_load system call.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/include/asm/kexec.h  |  7 +++++++
 arch/powerpc/kexec/core_64.c      | 27 +++++++++++++++++++++++++++
 arch/powerpc/kexec/elf_64.c       |  6 ++++++
 arch/powerpc/kexec/file_load_64.c |  5 +++++
 4 files changed, 45 insertions(+)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 8090ad7d97d9d..5a322c1737661 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -103,6 +103,10 @@ void kexec_copy_flush(struct kimage *image);
 struct crash_mem;
 int update_cpus_node(void *fdt);
 int get_crash_memory_ranges(struct crash_mem **mem_ranges);
+#if defined(CONFIG_CRASH_HOTPLUG)
+int machine_kexec_post_load(struct kimage *image);
+#define machine_kexec_post_load machine_kexec_post_load
+#endif
 #endif
 
 #if defined(CONFIG_CRASH_DUMP) && defined(CONFIG_PPC_RTAS)
@@ -118,6 +122,9 @@ extern const struct kexec_file_ops kexec_elf64_ops;
 struct kimage_arch {
 	struct crash_mem *exclude_ranges;
 
+#if defined(CONFIG_CRASH_HOTPLUG)
+	int fdt_index;
+#endif
 	unsigned long backup_start;
 	void *backup_buf;
 	void *fdt;
diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
index 0b292f93a74cc..3d4fe1aa6f761 100644
--- a/arch/powerpc/kexec/core_64.c
+++ b/arch/powerpc/kexec/core_64.c
@@ -77,6 +77,33 @@ int machine_kexec_prepare(struct kimage *image)
 	return 0;
 }
 
+#if defined(CONFIG_CRASH_HOTPLUG)
+int machine_kexec_post_load(struct kimage *kimage)
+{
+	int i;
+	void *ptr;
+	unsigned long mem;
+
+	/* Mark fdt_index invalid */
+	kimage->arch.fdt_index = -1;
+
+	if (kimage->type != KEXEC_TYPE_CRASH)
+		return 0;
+
+	for (i = 0; i < kimage->nr_segments; i++) {
+		mem = kimage->segment[i].mem;
+		ptr = __va(mem);
+
+		if (ptr && fdt_magic(ptr) == FDT_MAGIC) {
+			kimage->arch.fdt_index = i;
+			break;
+		}
+	}
+
+	return 0;
+}
+#endif
+
 /* Called during kexec sequence with MMU off */
 static notrace void copy_segments(unsigned long ind)
 {
diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
index eeb258002d1e0..2a17f171661f1 100644
--- a/arch/powerpc/kexec/elf_64.c
+++ b/arch/powerpc/kexec/elf_64.c
@@ -123,6 +123,12 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 	kbuf.buf_align = PAGE_SIZE;
 	kbuf.top_down = true;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+
+#if defined(CONFIG_CRASH_HOTPLUG)
+	image->arch.fdt_index = image->nr_segments;
+#endif
+	kbuf.memsz = fdt_totalsize(fdt);
+
 	ret = kexec_add_buffer(&kbuf);
 	if (ret)
 		goto out_free_fdt;
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index 9bc70b4d8eafc..725f74d1b928c 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -1153,6 +1153,11 @@ int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
 		return ret;
 	}
 
+#if defined(CONFIG_CRASH_HOTPLUG)
+	/* Mark fdt_index invalid */
+	image->arch.fdt_index = -1;
+#endif
+
 	return kexec_image_probe_default(image, buf, buf_len);
 }
 
-- 
2.39.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

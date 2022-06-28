Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34ECC433EF
	for <kexec@archiver.kernel.org>; Tue, 28 Jun 2022 15:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=QpXg4D/ANo0eyr/EtMlHhvr17MZtVxm65vF0/V7FKyk=; b=w1zd+60EE7nJ1S
	QXgelMhnNS1UeokAu/5JrybDVbTRrAGt+sG0Bt/1tdxvs10eN689PcHrPNyUOog1oEt8bW22tyDst
	HyuqPabqFqVYwmOctmJFBWwUdyYdtCT7gYZpe5iYAt52x5KdMRFubw8Rsr5dCpaJJfXoEXkyt8edb
	w5z8w2FMV2P+A6ZUhWVJUPnX1adWW0fKwf6nG4IHL2jVr6J0WB9u666VJEOoa5aja1hBSQy++zokg
	xMsJ/bphQ/44/aJUYZiYhP6A1cw8+BGXqPQdoyoQKJRVagJ9NTotkkm7FCvtCstdPfpKHpwOCN4xC
	YRZgRwGSpxyNLTq7lviA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6DNk-00716Q-SE; Tue, 28 Jun 2022 15:44:04 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6DNh-007152-Hh
	for kexec@lists.infradead.org; Tue, 28 Jun 2022 15:44:03 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25SFhMwL008302;
	Tue, 28 Jun 2022 15:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=jhHNPTOGV8YFp2rt4yx5OjxclG5ryctYia2mNsVtOIE=;
 b=p8bWQJeaeuk9642kVAaO+9SXfTnwwVqwD/uztjo4HKH6w9JuTWLBwOVeUIjYUk/ob5PZ
 bbpteZYnoPooQkMbBqYboPQWWwzzbdjuRPU3cuaSBzYJ6VWpKHo/h1yz0nVhDmD6kqE8
 xxTDqE7N8spasdq9u3HmQrBIPc6W+ti3CWk3UhvcH7sLB0rhsFK6Gjf5JlPfAfnvEZZU
 BHFJNTeEJjZKzqCTj+lPOimvINUfmqpuIuOMlJ1WtwU8qqRQYzeJwjyWicQhSt4QooBL
 TvXkKwUwHdqEJZGayZkO4vs1GdS2GpujfMEr76NL3g1k3Abpkvq8XQJVWVevN9kWDFMY wg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h04hh00n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jun 2022 15:43:57 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
	by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25SFcGTH024244;
	Tue, 28 Jun 2022 15:43:54 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by ppma03fra.de.ibm.com with ESMTP id 3gwt08ut43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jun 2022 15:43:54 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25SFhqa021758348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jun 2022 15:43:52 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2552B5204E;
	Tue, 28 Jun 2022 15:43:52 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.54.243])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E940B52051;
	Tue, 28 Jun 2022 15:43:49 +0000 (GMT)
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Greg KH <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        kexec@lists.infradead.org, Michael Ellerman <mpe@ellerman.id.au>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5.4] kexec_file: drop weak attribute from arch_kexec_apply_relocations[_add]
Date: Tue, 28 Jun 2022 21:12:49 +0530
Message-Id: <20220628154249.204911-4-naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7l8CfJ41She0JTa67nlMYtuIlwbqEwwl
X-Proofpoint-GUID: 7l8CfJ41She0JTa67nlMYtuIlwbqEwwl
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-28_09,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 phishscore=0 mlxlogscore=958 impostorscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206280063
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220628_084401_614969_523E5379 
X-CRM114-Status: GOOD (  22.29  )
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

commit 3e35142ef99fe6b4fe5d834ad43ee13cca10a2dc upstream.

Since commit d1bcae833b32f1 ("ELF: Don't generate unused section
symbols") [1], binutils (v2.36+) started dropping section symbols that
it thought were unused.  This isn't an issue in general, but with
kexec_file.c, gcc is placing kexec_arch_apply_relocations[_add] into a
separate .text.unlikely section and the section symbol ".text.unlikely"
is being dropped. Due to this, recordmcount is unable to find a non-weak
symbol in .text.unlikely to generate a relocation record against.

Address this by dropping the weak attribute from these functions.
Instead, follow the existing pattern of having architectures #define the
name of the function they want to override in their headers.

[1] https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=d1bcae833b32f1

[akpm@linux-foundation.org: arch/s390/include/asm/kexec.h needs linux/module.h]
Link: https://lkml.kernel.org/r/20220519091237.676736-1-naveen.n.rao@linux.vnet.ibm.com
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 arch/s390/include/asm/kexec.h | 10 ++++++++
 arch/x86/include/asm/kexec.h  |  9 +++++++
 include/linux/kexec.h         | 46 +++++++++++++++++++++++++++++------
 kernel/kexec_file.c           | 34 --------------------------
 4 files changed, 57 insertions(+), 42 deletions(-)

diff --git a/arch/s390/include/asm/kexec.h b/arch/s390/include/asm/kexec.h
index 7f3c9ac34bd8d1..63098df81c9f2a 100644
--- a/arch/s390/include/asm/kexec.h
+++ b/arch/s390/include/asm/kexec.h
@@ -9,6 +9,8 @@
 #ifndef _S390_KEXEC_H
 #define _S390_KEXEC_H
 
+#include <linux/module.h>
+
 #include <asm/processor.h>
 #include <asm/page.h>
 #include <asm/setup.h>
@@ -83,4 +85,12 @@ struct kimage_arch {
 extern const struct kexec_file_ops s390_kexec_image_ops;
 extern const struct kexec_file_ops s390_kexec_elf_ops;
 
+#ifdef CONFIG_KEXEC_FILE
+struct purgatory_info;
+int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
+				     Elf_Shdr *section,
+				     const Elf_Shdr *relsec,
+				     const Elf_Shdr *symtab);
+#define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_add
+#endif
 #endif /*_S390_KEXEC_H */
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 5e7d6b46de97d6..367da081f7d9d9 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -22,6 +22,7 @@
 
 #include <linux/string.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 
 #include <asm/page.h>
 #include <asm/ptrace.h>
@@ -201,6 +202,14 @@ extern int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages,
 extern void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages);
 #define arch_kexec_pre_free_pages arch_kexec_pre_free_pages
 
+#ifdef CONFIG_KEXEC_FILE
+struct purgatory_info;
+int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
+				     Elf_Shdr *section,
+				     const Elf_Shdr *relsec,
+				     const Elf_Shdr *symtab);
+#define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_add
+#endif
 #endif
 
 typedef void crash_vmclear_fn(void);
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index a1cffce3de8cd7..64f23bab6255da 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -186,14 +186,6 @@ void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name);
 int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
 					 unsigned long buf_len);
 void * __weak arch_kexec_kernel_image_load(struct kimage *image);
-int __weak arch_kexec_apply_relocations_add(struct purgatory_info *pi,
-					    Elf_Shdr *section,
-					    const Elf_Shdr *relsec,
-					    const Elf_Shdr *symtab);
-int __weak arch_kexec_apply_relocations(struct purgatory_info *pi,
-					Elf_Shdr *section,
-					const Elf_Shdr *relsec,
-					const Elf_Shdr *symtab);
 
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
 int kexec_locate_mem_hole(struct kexec_buf *kbuf);
@@ -216,6 +208,44 @@ extern int crash_exclude_mem_range(struct crash_mem *mem,
 				   unsigned long long mend);
 extern int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
 				       void **addr, unsigned long *sz);
+
+#ifndef arch_kexec_apply_relocations_add
+/*
+ * arch_kexec_apply_relocations_add - apply relocations of type RELA
+ * @pi:		Purgatory to be relocated.
+ * @section:	Section relocations applying to.
+ * @relsec:	Section containing RELAs.
+ * @symtab:	Corresponding symtab.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+static inline int
+arch_kexec_apply_relocations_add(struct purgatory_info *pi, Elf_Shdr *section,
+				 const Elf_Shdr *relsec, const Elf_Shdr *symtab)
+{
+	pr_err("RELA relocation unsupported.\n");
+	return -ENOEXEC;
+}
+#endif
+
+#ifndef arch_kexec_apply_relocations
+/*
+ * arch_kexec_apply_relocations - apply relocations of type REL
+ * @pi:		Purgatory to be relocated.
+ * @section:	Section relocations applying to.
+ * @relsec:	Section containing RELs.
+ * @symtab:	Corresponding symtab.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+static inline int
+arch_kexec_apply_relocations(struct purgatory_info *pi, Elf_Shdr *section,
+			     const Elf_Shdr *relsec, const Elf_Shdr *symtab)
+{
+	pr_err("REL relocation unsupported.\n");
+	return -ENOEXEC;
+}
+#endif
 #endif /* CONFIG_KEXEC_FILE */
 
 #ifdef CONFIG_KEXEC_ELF
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index b17998fa03f125..5b58149bcd900b 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -107,40 +107,6 @@ int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
 }
 #endif
 
-/*
- * arch_kexec_apply_relocations_add - apply relocations of type RELA
- * @pi:		Purgatory to be relocated.
- * @section:	Section relocations applying to.
- * @relsec:	Section containing RELAs.
- * @symtab:	Corresponding symtab.
- *
- * Return: 0 on success, negative errno on error.
- */
-int __weak
-arch_kexec_apply_relocations_add(struct purgatory_info *pi, Elf_Shdr *section,
-				 const Elf_Shdr *relsec, const Elf_Shdr *symtab)
-{
-	pr_err("RELA relocation unsupported.\n");
-	return -ENOEXEC;
-}
-
-/*
- * arch_kexec_apply_relocations - apply relocations of type REL
- * @pi:		Purgatory to be relocated.
- * @section:	Section relocations applying to.
- * @relsec:	Section containing RELs.
- * @symtab:	Corresponding symtab.
- *
- * Return: 0 on success, negative errno on error.
- */
-int __weak
-arch_kexec_apply_relocations(struct purgatory_info *pi, Elf_Shdr *section,
-			     const Elf_Shdr *relsec, const Elf_Shdr *symtab)
-{
-	pr_err("REL relocation unsupported.\n");
-	return -ENOEXEC;
-}
-
 /*
  * Free up memory used by kernel, initrd, and command line. This is temporary
  * memory allocation which is not needed any more after these buffers have

base-commit: 23db944f754e99abf814a79a2273b0191d35e4ff
-- 
2.36.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

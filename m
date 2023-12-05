Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F846C4167B
	for <kexec@archiver.kernel.org>; Tue,  5 Dec 2023 15:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tYuwJuBHwQR1vcDKjYxHRwbZZj9R9eueXA2HbDnXSyw=; b=dz/DuM5KTrOHvM
	6AocEDWkm58dVkTXy4hrc7zSH8Ebjho1fybodDsrLiqUm+55+uLGa/3kCgBIo8phnCG2SxV3i8put
	jk25fCCc1zpDRgUQbooJO1PHm6dNv12je5OiEEtvFAvOj8FvmQVgXTe0FA0LA25BRzg3FkQHTbqsu
	WZKoOwlK3PaqzBjHUfZDfHb9otYyu4PydczORyOuzFdg1Iqo7WNRQCaW5JOLOSyNPoXywmsQtioWi
	ND484AbDOJxzByUFkDqsQqy8VQIOmoME0stjVfpphiuGjT7Etfug6Fmu+MKa1V5wQIvktJGUBydDP
	2KbjNUIOqipHnWogagKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAWw1-007fYE-2l;
	Tue, 05 Dec 2023 15:02:05 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAWvy-007fXH-1p
	for kexec@lists.infradead.org;
	Tue, 05 Dec 2023 15:02:04 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5EvakY003145;
	Tue, 5 Dec 2023 15:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=t1yFYwGf0hjA8WDuE2Oh/iKLf1fRv1wqoeaD0WUKGew=;
 b=h/V/BHbONfFUsfYYyCS4A37rnQmc8yO3jvTb6sGJOIL8Z4n6XqOWcvvBV0kPJDzB4TwR
 rGZ2BrkcCzOCMpWX4NjxR8fd2qUxvqPbBU5eGyVwpFGclgIUNeFRuAuEVi/KIwWGiD+9
 0XveYGKoAYYAvEVS7/EF4bJbOW5MtVfV8CXsG+ICUTYeCgaED4kcNT+8BGuvCe9rd9Lx
 dXHXc9hQlZFfg8Ic+WE2VzqtPrZC5zCY2vSUpnEXHtiDcbmHDpkV22pHuKThjAkQby73
 aEy3KuPRHKaNgFVEujKn0BbXaNmFQ6NdK/Cy7PlzDS649YFxZpwd/V54nNu361+sv30H Qw== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ut62w85bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Dec 2023 15:01:56 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5E5FsS009150;
	Tue, 5 Dec 2023 15:01:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3urgdky73n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Dec 2023 15:01:54 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B5F1qWZ39584206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Dec 2023 15:01:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2FD320043;
	Tue,  5 Dec 2023 15:01:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB69B20040;
	Tue,  5 Dec 2023 15:01:52 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  5 Dec 2023 15:01:52 +0000 (GMT)
Date: Tue, 5 Dec 2023 16:01:51 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: HAGIO =?utf-8?B?S0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= <k-hagio-ab@nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: [PATCH v2 2/2] s390x: uncouple virtual and physical address spaces
Message-ID: <ZW87X1IbgcGQ96fS@tuxmaker.boeblingen.de.ibm.com>
References: <cover.1701261329.git.agordeev@linux.ibm.com>
 <173fd99d06d8fd09c0b370d3a33555b9bf11a8d9.1701261329.git.agordeev@linux.ibm.com>
 <e0a46583-7f61-82fa-1698-d5255830eb72@nec.com>
 <ZW87OaGBdXtCUnyC@tuxmaker.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZW87OaGBdXtCUnyC@tuxmaker.boeblingen.de.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XFfjGCZHacF7JFeaz2OdBmAokp_eHNxF
X-Proofpoint-ORIG-GUID: XFfjGCZHacF7JFeaz2OdBmAokp_eHNxF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_10,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312050118
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231205_070202_632877_73722FFC 
X-CRM114-Status: GOOD (  20.91  )
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

Rework vaddr_to_paddr() and paddr_to_vaddr() macros to reflect
the future uncoupling of physical and virtual address spaces in
kernel. Existing versions are not affected.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390x.c   | 134 ++++++++++++++++++++++++++++++++++++++++++++++++-
 makedumpfile.h |  11 +++-
 2 files changed, 142 insertions(+), 3 deletions(-)

diff --git a/arch/s390x.c b/arch/s390x.c
index a01f164..4a993be 100644
--- a/arch/s390x.c
+++ b/arch/s390x.c
@@ -59,6 +59,69 @@
 #define rsg_offset(x, y)	(rsg_index( x, y) * sizeof(unsigned long))
 #define pte_offset(x)		(pte_index(x) * sizeof(unsigned long))
 
+#define LOWCORE_SIZE		0x2000
+
+#define OS_INFO_VERSION_MAJOR	1
+#define OS_INFO_VERSION_MINOR	1
+
+#define OS_INFO_VMCOREINFO	0
+#define OS_INFO_REIPL_BLOCK	1
+#define OS_INFO_FLAGS_ENTRY	2
+#define OS_INFO_RESERVED	3
+#define OS_INFO_IDENTITY_BASE	4
+#define OS_INFO_KASLR_OFFSET	5
+#define OS_INFO_KASLR_OFF_PHYS	6
+#define OS_INFO_VMEMMAP		7
+#define OS_INFO_AMODE31_START	8
+#define OS_INFO_AMODE31_END	9
+
+struct os_info_entry {
+	union {
+		uint64_t	addr;
+		uint64_t	val;
+	};
+	uint64_t		size;
+	uint32_t		csum;
+} __attribute__((packed));
+
+struct os_info {
+	uint64_t		magic;
+	uint32_t		csum;
+	uint16_t		version_major;
+	uint16_t		version_minor;
+	uint64_t		crashkernel_addr;
+	uint64_t		crashkernel_size;
+	struct	os_info_entry	entry[10];
+	uint8_t			reserved[3864];
+} __attribute__((packed));
+
+#define S390X_LC_OS_INFO	0x0e18
+
+struct s390_ops {
+	unsigned long long	(*virt_to_phys)(unsigned long vaddr);
+	unsigned long		(*phys_to_virt)(unsigned long long paddr);
+};
+
+static unsigned long long vaddr_to_paddr_s390x_legacy(unsigned long vaddr);
+static unsigned long long vaddr_to_paddr_s390x_vr(unsigned long vaddr);
+static unsigned long paddr_to_vaddr_s390x_legacy(unsigned long long paddr);
+static unsigned long paddr_to_vaddr_s390x_vr(unsigned long long paddr);
+
+struct s390_ops s390_ops = {
+	.virt_to_phys = vaddr_to_paddr_s390x_legacy,
+	.phys_to_virt = paddr_to_vaddr_s390x_legacy,
+};
+
+unsigned long long vaddr_to_paddr_s390x(unsigned long vaddr)
+{
+	return s390_ops.virt_to_phys(vaddr);
+}
+
+unsigned long paddr_to_vaddr_s390x(unsigned long long paddr)
+{
+	return s390_ops.phys_to_virt(paddr);
+}
+
 int
 set_s390x_max_physmem_bits(void)
 {
@@ -88,12 +151,53 @@ set_s390x_max_physmem_bits(void)
 	return FALSE;
 }
 
+static int s390x_init_vm(void)
+{
+	struct os_info os_info;
+	ulong addr;
+
+	if (!readmem(PADDR, S390X_LC_OS_INFO, &addr,
+			sizeof(addr)) || !addr) {
+		ERRMSG("Can't get s390x os_info ptr.\n");
+		return FALSE;
+	}
+
+	if (addr == 0)
+		return TRUE;
+
+	if (!readmem(PADDR, addr, &os_info, offsetof(struct os_info, reserved))) {
+		ERRMSG("Can't get os_info header.\n");
+		return FALSE;
+	}
+
+	if (!os_info.entry[OS_INFO_KASLR_OFFSET].val)
+		return TRUE;
+
+	MSG("The -vr kernel detected.\n");
+
+	info->identity_map_base   = os_info.entry[OS_INFO_IDENTITY_BASE].val;
+	info->kvbase              = os_info.entry[OS_INFO_KASLR_OFFSET].val;
+	info->__kaslr_offset_phys = os_info.entry[OS_INFO_KASLR_OFF_PHYS].val;
+	info->vmemmap_start       = os_info.entry[OS_INFO_VMEMMAP].val;
+	info->amode31_start       = os_info.entry[OS_INFO_AMODE31_START].val;
+	info->amode31_end         = os_info.entry[OS_INFO_AMODE31_END].val;
+
+	s390_ops.virt_to_phys	= vaddr_to_paddr_s390x_vr;
+	s390_ops.phys_to_virt	= paddr_to_vaddr_s390x_vr;
+
+	return TRUE;
+}
+
+
 int
 get_machdep_info_s390x(void)
 {
 	unsigned long vmalloc_start;
 	char *term_str = getenv("TERM");
 
+	if (!s390x_init_vm())
+		return FALSE;
+
 	if (term_str && strcmp(term_str, "dumb") == 0)
 		/* '\r' control character is ignored on "dumb" terminal. */
 		flag_ignore_r_char = 1;
@@ -295,8 +399,8 @@ vtop_s390x(unsigned long vaddr)
 	return paddr;
 }
 
-unsigned long long
-vaddr_to_paddr_s390x(unsigned long vaddr)
+static unsigned long long
+vaddr_to_paddr_s390x_legacy(unsigned long vaddr)
 {
 	unsigned long long paddr;
 
@@ -320,6 +424,32 @@ vaddr_to_paddr_s390x(unsigned long vaddr)
 	return paddr;
 }
 
+static unsigned long long
+vaddr_to_paddr_s390x_vr(unsigned long vaddr)
+{
+	if (vaddr < LOWCORE_SIZE)
+		return vaddr;
+	if ((vaddr < info->amode31_end) && (vaddr >= info->amode31_start))
+		return vaddr;
+	if (vaddr < info->vmemmap_start)
+		return vaddr - info->identity_map_base;
+	if (vaddr >= info->kvbase)
+		return vaddr - info->kvbase + info->__kaslr_offset_phys;
+	return vtop_s390x(vaddr);
+}
+
+unsigned long
+paddr_to_vaddr_s390x_legacy(unsigned long long paddr)
+{
+	return (unsigned long)paddr_to_vaddr_general(paddr);
+}
+
+unsigned long
+paddr_to_vaddr_s390x_vr(unsigned long long paddr)
+{
+	return info->identity_map_base + (unsigned long)paddr;
+}
+
 struct addr_check {
 	unsigned long addr;
 	int found;
diff --git a/makedumpfile.h b/makedumpfile.h
index 59a809c..f1619c5 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1235,6 +1235,7 @@ unsigned long long vaddr_to_paddr_ppc(unsigned long vaddr);
 #ifdef __s390x__ /* s390x */
 int get_machdep_info_s390x(void);
 unsigned long long vaddr_to_paddr_s390x(unsigned long vaddr);
+unsigned long paddr_to_vaddr_s390x(unsigned long long paddr);
 int is_iomem_phys_addr_s390x(unsigned long addr);
 #define find_vmemmap()		stub_false()
 #define get_phys_base()		stub_true()
@@ -1242,7 +1243,7 @@ int is_iomem_phys_addr_s390x(unsigned long addr);
 #define get_versiondep_info()	stub_true()
 #define get_kaslr_offset(X)	get_kaslr_offset_general(X)
 #define vaddr_to_paddr(X)	vaddr_to_paddr_s390x(X)
-#define paddr_to_vaddr(X)	paddr_to_vaddr_general(X)
+#define paddr_to_vaddr(X)	paddr_to_vaddr_s390x(X)
 #define is_phys_addr(X)		is_iomem_phys_addr_s390x(X)
 #define arch_crashkernel_mem_size()	stub_false()
 #endif          /* s390x */
@@ -1760,6 +1761,14 @@ struct DumpInfo {
 	pthread_mutex_t current_pfn_mutex;
 	pthread_mutex_t page_data_mutex;
 	pthread_mutex_t filter_mutex;
+
+#ifdef __s390x__ /* s390x */
+	unsigned long identity_map_base;
+	unsigned long kvbase;
+	unsigned long __kaslr_offset_phys;
+	unsigned long amode31_start;
+	unsigned long amode31_end;
+#endif
 };
 extern struct DumpInfo		*info;
 
-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

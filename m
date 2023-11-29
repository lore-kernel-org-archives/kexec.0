Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD230C07CB1
	for <kexec@archiver.kernel.org>; Wed, 29 Nov 2023 12:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YP74ea7pzI6s0Od/tLOQubJRZkpJZa4m19suwixc46o=; b=Qlq57KtZUbzDdu
	oLCx39EhEnY0dGYnAEWh1GBJudrS2J5Yp6c0ttrEfRvor2FBt40PKuc3W5d/XNBNPL9SE+OoLf7S6
	KFBX0gjMHBJL2tlKV0Vojq+uMns/ZhZF1rsrqGKnzInDRX41TUSFeJIhWuGOAkA5FfJlCaSxzoGwJ
	mAkBmSFIal790YmmPDU2d0hfu8U2Sran+41uGcfqbHoNTwpw0ARU5aUyzcOq2MM25ZP7GPouUrcXr
	r2R4MtJWlrODVBZ3g2giGYGmjoGDTqJfbPzTMnpali4tn0Vp0hs1ejmcYZRWJW1fqXMow9ShTCTe0
	YTKonevaCAj7YPr1icxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8K1K-008Ny6-1z;
	Wed, 29 Nov 2023 12:50:26 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8K1E-008NwX-0l
	for kexec@lists.infradead.org;
	Wed, 29 Nov 2023 12:50:24 +0000
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATChbiW031673
	for <kexec@lists.infradead.org>; Wed, 29 Nov 2023 12:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=MYg0LYsKWyVaV2w4c5TU3/lIaJ0yj1+b/o82Rn/gClI=;
 b=NvVilOvTWNLXJqDV3NddLQKCqekOiwUT1u5VN9kfT2rNinEmWE10luUS+YSoR9OV2Xbp
 H0vpKMrhEnVocn+RUE1/8En9DSUAAXvEqiEtHiau3muF7BrvUoNoHd0f0cGiIf+8GEP/
 i+hoT0V3YsM/VrMvMaxNUBpamYVBY+UUTUZCm5/ROtG4plep4oej4/qMs+WQHTXqfiyP
 vU1qfauLW8uEJKY/BdudofQTzxKWxy4lgnHtqDit9HKdkwyI/HoaVMiXV5vjyIHw6P/7
 w6sX4mKEa+b+iqnFyopxwEqDoJtOkD7f5XlHY5SoUO0+AoKSGHkp6ldFvyU9fY8G8icw Hw== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3up5j389jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Wed, 29 Nov 2023 12:50:17 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATB3vr1001578
	for <kexec@lists.infradead.org>; Wed, 29 Nov 2023 12:50:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukvrkq32g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Wed, 29 Nov 2023 12:50:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ATCoCo939912168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Nov 2023 12:50:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AE1C20049;
	Wed, 29 Nov 2023 12:50:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5062220040;
	Wed, 29 Nov 2023 12:50:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Nov 2023 12:50:12 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 214C5E0C14; Wed, 29 Nov 2023 13:50:12 +0100 (CET)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: kexec@lists.infradead.org
Subject: [PATCH 2/2] s390x: uncouple virtual and physical address spaces
Date: Wed, 29 Nov 2023 13:50:12 +0100
Message-Id: <173fd99d06d8fd09c0b370d3a33555b9bf11a8d9.1701261329.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1701261329.git.agordeev@linux.ibm.com>
References: <cover.1701261329.git.agordeev@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lYItlmc8R0r_FAf7gPMlcSZ53gi_qcZT
X-Proofpoint-GUID: lYItlmc8R0r_FAf7gPMlcSZ53gi_qcZT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_09,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=979
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290096
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231129_045020_513156_138A153B 
X-CRM114-Status: GOOD (  22.75  )
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
 makedumpfile.c |   2 +
 makedumpfile.h |  12 ++++-
 3 files changed, 145 insertions(+), 3 deletions(-)

diff --git a/arch/s390x.c b/arch/s390x.c
index a01f164..8ba2267 100644
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
+		__u64	addr;
+		__u64	val;
+	};
+	__u64	size;
+	__u32	csum;
+} __attribute__((packed));
+
+struct os_info {
+	__u64	magic;
+	__u32	csum;
+	__u16	version_major;
+	__u16	version_minor;
+	__u64	crashkernel_addr;
+	__u64	crashkernel_size;
+	struct	os_info_entry entry[10];
+	__u8	reserved[3864];
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
diff --git a/makedumpfile.c b/makedumpfile.c
index a6ec9d4..568889b 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1654,6 +1654,7 @@ get_symbol_info(void)
 	SYMBOL_INIT(max_pfn, "max_pfn");
 	SYMBOL_INIT(modules, "modules");
 	SYMBOL_INIT(high_memory, "high_memory");
+	SYMBOL_INIT(__kernel_base, "__kernel_base");
 	SYMBOL_INIT(linux_banner, "linux_banner");
 	SYMBOL_INIT(bios_cpu_apicid, "bios_cpu_apicid");
 	SYMBOL_INIT(x86_bios_cpu_apicid, "x86_bios_cpu_apicid");
@@ -2819,6 +2820,7 @@ read_vmcoreinfo(void)
 	READ_SYMBOL("log_next_idx", log_next_idx);
 	READ_SYMBOL("max_pfn", max_pfn);
 	READ_SYMBOL("high_memory", high_memory);
+	READ_SYMBOL("__kernel_base", __kernel_base);
 	READ_SYMBOL("node_remap_start_vaddr", node_remap_start_vaddr);
 	READ_SYMBOL("node_remap_end_vaddr", node_remap_end_vaddr);
 	READ_SYMBOL("node_remap_start_pfn", node_remap_start_pfn);
diff --git a/makedumpfile.h b/makedumpfile.h
index 59a809c..81e2daf 100644
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
 
@@ -1869,6 +1878,7 @@ struct symbol_table {
 	 * vmalloc_start address on s390x arch
 	 */
 	unsigned long long	high_memory;
+	unsigned long long	__kernel_base;
 
 	/*
 	 * for sadump
-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

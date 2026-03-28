Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEBFD39420
	for <kexec@archiver.kernel.org>; Thu,  2 Apr 2026 12:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T0HTdTsJ+BRaIWohYMOarISe4cVfTmplkqDtATfGkBY=; b=pClRPdGWUNMAymewV3DKNcl6uy
	rslS9PF/diE7/Qua8dT7H6jUhnVP1sbBDEbmfzLo7s3C0QE4VncKotXNRAcn977y+Pve87cvW7xfn
	qqLxpfflLnPUltENb9EWvnJ+PdvXy+3+hShNUc4I/tbmPucUvWTPhi4YgceW439CEM0Z2CQK6ayKd
	QxtDxT9rO3tM2Lbgu5bzgGFvk9Ap1cDRdaZo9VEGWK2OHFJ8HZQ94eZH4iW2y+vm8wYVk2/7/fsfe
	HNOEqSHO29LkHgxEj5Dw8zeajS3ucNbEanT55m3//86baYrsB2Tyal/ChorncqjoNdDmcQT40ef1l
	rfY8QnBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8HG7-000000004ba-2Pcl;
	Thu, 02 Apr 2026 12:34:51 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6OJ0-00000008gz0-1XxM;
	Sat, 28 Mar 2026 07:42:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=T0HTdTsJ+BRaIWohYMOarISe4cVfTmplkqDtATfGkBY=; b=EEJrHK+ITYvbUj/4S7qDR5BX7F
	ohXtozxjd915hfhC+XQDY6hBU5r791V0z+Vg0TfLwvDe/vw2VOrW3k/D+xlrUWCG4eRq2HannLKLs
	zd8V0bdiMpOQqPJRKqlBodtu/BK4jg6Boz+R44eOGDlpYtx1ZOjRqDpxZXAwbV16TGsWWoReYupUJ
	SPf6yeidlH+HMWVx/qv80A1X3j0cDTBCKe8dvghz/j5BZIL9xjmTZdgOwzdgdA4DQoBP+mJMxPZKJ
	xvAzogl+l/qeLamZSD9M54rWaMUCPqoGXvKS0+vwzehUn/XFwWqSasYE29X1Q6UZttP0Z3hjK6rCu
	04/YX7RA==;
Received: from canpmsgout06.his.huawei.com ([113.46.200.221])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6OIw-0000000BjFD-3f6s;
	Sat, 28 Mar 2026 07:42:01 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=T0HTdTsJ+BRaIWohYMOarISe4cVfTmplkqDtATfGkBY=;
	b=ODuxTM6rNDcxKL1IWVWcxiwFKTYgYF7HTYnYTpH580zh0m3kpH7EHNFSvZudPJPoMd/ugO47l
	FIchmYINX0OEzfNWdBy21PVgkoD7dDhvj3wt31XGUJ+2Dimxi3jc0bCwMwALPzcier/FEOTcv3P
	KO9JG/TfHGdLVtAbtqInrbg=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fjTnm2QSgzRhQc;
	Sat, 28 Mar 2026 15:35:40 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id A925140575;
	Sat, 28 Mar 2026 15:41:47 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 28 Mar
 2026 15:41:44 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <bhe@redhat.com>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>, <rdunlap@infradead.org>, <peterz@infradead.org>,
	<feng.tang@linux.alibaba.com>, <pawan.kumar.gupta@linux.intel.com>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<paulmck@kernel.org>, <lirongqing@baidu.com>, <rppt@kernel.org>,
	<leitao@debian.org>, <ardb@kernel.org>, <cfsworks@gmail.com>,
	<osandov@fb.com>, <jbohac@suse.cz>, <tangyouling@kylinos.cn>,
	<sourabhjain@linux.ibm.com>, <ritesh.list@gmail.com>,
	<eajames@linux.ibm.com>, <songshuaishuai@tinylab.org>,
	<kevin.brodsky@arm.com>, <vishal.moola@gmail.com>,
	<junhui.liu@pigmoral.tech>, <coxu@redhat.com>, <fuqiang.wang@easystack.cn>,
	<liaoyuanhong@vivo.com>, <guoren@kernel.org>, <chenjiahao16@huawei.com>,
	<hbathini@linux.ibm.com>, <takahiro.akashi@linaro.org>,
	<james.morse@arm.com>, <lizhengyu3@huawei.com>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v11 11/11] riscv: kexec: Add support for crashkernel CMA reservation
Date: Sat, 28 Mar 2026 15:40:13 +0800
Message-ID: <20260328074013.3589544-12-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260328074013.3589544-1-ruanjinjie@huawei.com>
References: <20260328074013.3589544-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260328_074159_613074_EA421FEA 
X-CRM114-Status: GOOD (  20.29  )
X-Mailman-Approved-At: Thu, 02 Apr 2026 05:34:24 -0700
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Commit 35c18f2933c5 ("Add a new optional ",cma" suffix to the
crashkernel= command line option") and commit ab475510e042 ("kdump:
implement reserve_crashkernel_cma") added CMA support for kdump
crashkernel reservation. This allows the kernel to dynamically allocate
contiguous memory for crash dumping when needed, rather than permanently
reserving a fixed region at boot time.

So extend crashkernel CMA reservation support to riscv. The following
changes are made to enable CMA reservation:

- Parse and obtain the CMA reservation size along with other crashkernel
  parameters.
- Call reserve_crashkernel_cma() to allocate the CMA region for kdump.
- Include the CMA-reserved ranges for kdump kernel to use, which was
  already done in of_kexec_alloc_and_setup_fdt().
- Exclude the CMA-reserved ranges from the crash kernel memory to
  prevent them from being exported through /proc/vmcore, which was
  already done in the crash core.

Update kernel-parameters.txt to document CMA support for crashkernel on
riscv architecture.

Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Paul Walmsley <pjw@kernel.org> # arch/riscv
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 16 ++++++++--------
 arch/riscv/kernel/machine_kexec_file.c          |  2 +-
 arch/riscv/mm/init.c                            |  5 +++--
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a7055cead40f..13ced9ea42f4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1122,14 +1122,14 @@ Kernel parameters
 			It will be ignored when crashkernel=X,high is not used
 			or memory reserved is below 4G.
 	crashkernel=size[KMG],cma
-			[KNL, X86, ARM64, PPC] Reserve additional crash kernel memory from
-			CMA. This reservation is usable by the first system's
-			userspace memory and kernel movable allocations (memory
-			balloon, zswap). Pages allocated from this memory range
-			will not be included in the vmcore so this should not
-			be used if dumping of userspace memory is intended and
-			it has to be expected that some movable kernel pages
-			may be missing from the dump.
+			[KNL, X86, ARM64, RISCV, PPC] Reserve additional crash
+			kernel memory from CMA. This reservation is usable by
+			the first system's userspace memory and kernel movable
+			allocations (memory balloon, zswap). Pages allocated
+			from this memory range will not be included in the vmcore
+			so this should not be used if dumping of userspace memory
+			is intended and it has to be expected that some movable
+			kernel pages may be missing from the dump.
 
 			A standard crashkernel reservation, as described above,
 			is still needed to hold the crash kernel and initrd.
diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
index bea818f75dd6..c79cd86d5713 100644
--- a/arch/riscv/kernel/machine_kexec_file.c
+++ b/arch/riscv/kernel/machine_kexec_file.c
@@ -46,7 +46,7 @@ static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
 
 unsigned int arch_get_system_nr_ranges(void)
 {
-	unsigned int nr_ranges = 2; /* For exclusion of crashkernel region */
+	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* For exclusion of crashkernel region */
 
 	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 811e03786c56..4cd49afa9077 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1398,7 +1398,7 @@ static inline void setup_vm_final(void)
  */
 static void __init arch_reserve_crashkernel(void)
 {
-	unsigned long long low_size = 0;
+	unsigned long long low_size = 0, cma_size = 0;
 	unsigned long long crash_base, crash_size;
 	bool high = false;
 	int ret;
@@ -1408,11 +1408,12 @@ static void __init arch_reserve_crashkernel(void)
 
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 				&crash_size, &crash_base,
-				&low_size, NULL, &high);
+				&low_size, &cma_size, &high);
 	if (ret)
 		return;
 
 	reserve_crashkernel_generic(crash_size, crash_base, low_size, high);
+	reserve_crashkernel_cma(cma_size);
 }
 
 void __init paging_init(void)
-- 
2.34.1



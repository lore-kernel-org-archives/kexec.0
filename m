Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90B9C3DA4A
	for <kexec@archiver.kernel.org>; Thu,  1 Aug 2024 19:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Lu9+JurtFvzlK3gLus0LQ0Qhr8iX/D1VMvSN2EVL0DE=; b=CEhpNwU6TvUlOz
	ZfF0ZP9eLH1lGJ4OWAzadWKFxvxtTNHesHuyHohtSs51LXo2Wzls3AA3akzIcUliV52/hg8Ii0iH5
	1GfbnKBqUyNyHU9Z3/TJAS0BTHyxoCTq1jIB+zIzHsUIEgbI3whS6KeCuIqy/i9zeldlEQ+6TXpo0
	Iryncuair/32AHOd94XOKaVYaSzqxzXqIekx1zF4RUirwLvEAnZFZ7zqGzZoR6KsAd/Igfh/0y1Je
	X+CjizsGo/mfV5p0Z48du7LcTOtSIFzjEZlGyh68lHXnY7nuPwvOtkWS3YYSh6kzC3rVZ1ZnGfOAN
	SVXMSDfLEt9mQDRt7PUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZbGg-00000006Ve3-1RCj;
	Thu, 01 Aug 2024 19:15:18 +0000
Received: from mail-dm6nam12on20600.outbound.protection.outlook.com ([2a01:111:f403:2417::600] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZbGU-00000006VY9-1323
	for kexec@lists.infradead.org;
	Thu, 01 Aug 2024 19:15:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tN2MbK1OKiXRhBm/OTICZQwJ/8kciII3mfou29JXR2hwlMMQ2QviF4rdaBjrESSxe6tBLeSaFNpDJfJippvJOSE4FKbddgSL6/2l7x9MgvWSkiwLUM+N4rpJ2bxE3qrscH30mlo93RK1pUqZbwYJKmf4GvFN+uA5/W0/T378IhWGaF4L5GQdLISHjHHDn+QVPZmk35uL6Zgceq9/3lmh7ueZP4lUANz68EQDz+81OrEcyI5ogdCStFbUA+7B7Z10/gKqTmsaLOa28xF3y2LjVNMwOlirk2SN4weu/llEipQuXrg6ncVkf8/3CmsyDckAXh3YhctZ2UqWrFJz/7QNuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLP0FomrHtsGSnSJn8eiIg+JCCUERRnJezuYuuOYxIY=;
 b=UPNR+fgyF5bSHlxmhjiuclTLJ+TZ2wnL8qYPg2PbT9FAW9Si6nVv0OK046KEphA6yXCHIvAC1w4lM7fxZQu0lG/qTbtL0rpJrLZ1E6XgWxh6suNwIwI4Vq6a8qXONmM/r2Xe8TZhGIRML5M84Im+nWGD8/g0+7sN3udlNqXQ9MjLLk+yvLL+Wtnn10Ur5lDKpaQjryUfDVH5vP+FcnU7KBl93bNOAJJpU8hKKxIDF8O0t7IaRT3DASrlbOoRlfQxdozMGo+t3OKkJPSIorg6vmtFJLeKPdIBG1fUC+HYe1QGqyOLhEPFyMLJcv3+jPgZxxtOCoqC0Ub9iliwoo3pGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLP0FomrHtsGSnSJn8eiIg+JCCUERRnJezuYuuOYxIY=;
 b=vCVEhehw5s4WTzY5oKxGjCPRSM1QZ7UmHng3R06ZR18swW8m3mCVYXjTpw3z+ScbiCj24J22ytJMILBOVfuWXmXsyTkZTO2jdxgXAWBtsJyYSZX4U6JDqkQ6MEd3ME2HUXf6BeS/hjDWYozHOuFEl2UTi0FCp/+6P5cDQB0Sq3A=
Received: from BYAPR08CA0007.namprd08.prod.outlook.com (2603:10b6:a03:100::20)
 by IA1PR12MB6282.namprd12.prod.outlook.com (2603:10b6:208:3e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Thu, 1 Aug
 2024 19:15:02 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:100:cafe::60) by BYAPR08CA0007.outlook.office365.com
 (2603:10b6:a03:100::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22 via Frontend
 Transport; Thu, 1 Aug 2024 19:15:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 19:15:01 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 14:14:59 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <dave.hansen@linux.intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <x86@kernel.org>
CC: <hpa@zytor.com>, <rafael@kernel.org>, <peterz@infradead.org>,
	<adrian.hunter@intel.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<jun.nakajima@intel.com>, <kirill.shutemov@linux.intel.com>,
	<rick.p.edgecombe@intel.com>, <linux-kernel@vger.kernel.org>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <seanjc@google.com>,
	<kai.huang@intel.com>, <bhe@redhat.com>, <bdas@redhat.com>,
	<vkuznets@redhat.com>, <dionnaglaze@google.com>, <anisinha@redhat.com>,
	<ardb@kernel.org>, <dyoung@redhat.com>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <jroedel@suse.de>
Subject: [PATCH v13 3/3] x86/snp: Convert shared memory back to private on kexec
Date: Thu, 1 Aug 2024 19:14:50 +0000
Message-ID: <05a8c15fb665dbb062b04a8cb3d592a63f235937.1722520012.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722520012.git.ashish.kalra@amd.com>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com> <cover.1722520012.git.ashish.kalra@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|IA1PR12MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: b0bdc6d0-5368-4d95-44e3-08dcb25e3e0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KDXgRAGcEm4LFIrTAv7lwej7uypwgMQU43UJMQIiSYA7w3czvqNgV3JRJPAF?=
 =?us-ascii?Q?mpSWPazvTzqbz/XZIZdFfcWr8yuHoRZqd8z+tPdlq0D7cexWe7W/jQt9mdjV?=
 =?us-ascii?Q?2QD1ifodppfF8VX7Tzl/GfBrzjtgzBx0hSpuPy42HKQKSP9K3lbszyYLCkcv?=
 =?us-ascii?Q?eJ8U7LqFVmeVbDSO8Mc58Ne01olOGVnYEHX0W6fHtQs3KdSUsZPXjy2AUKmr?=
 =?us-ascii?Q?RAn30TcnVz10pS7tZeM9omExQNY/2MyJFjm4KEE8Jae9qP+M9xsHFPW4MJG3?=
 =?us-ascii?Q?tyQZ0Xlbr/7jl7I5bxvuY4pgB7eTo0gEUDu7JC4P3jfC36AamP7dH511Zcoj?=
 =?us-ascii?Q?EOTv/9aeGqyOsBAQ8Pga/Kgd1aWCVsC4yGYJPJqALnLzFBn//xtpOJd2Qq0h?=
 =?us-ascii?Q?iMPYuf1tPARAq3kXYqbAvzWRgpsu5zTl6oz6JuH2itG9BpwVeLP2nm26JbaL?=
 =?us-ascii?Q?6g6fHlfRMty/Ho9BaHKXRSgW6lSq0hafZOBs4L17oRMlQN9Ye26/Y4KA/bzC?=
 =?us-ascii?Q?G9vc76qQ7nLlQhHzYS/pcym44A+Pp2j3k1uGOB3I519BmYf65gNWMbtirWF8?=
 =?us-ascii?Q?CbJ49XIxqAx/lHRzzuYBE4yxLPQykmVy1toPew+fFPQu+4Reda1Zz6nomHKU?=
 =?us-ascii?Q?ZkXvZxPhDUGz6GrrIHoVSRrEMxfoU83sySxg5jiK6yjJHBq/i2x266ZdzTno?=
 =?us-ascii?Q?MFou25DxBZLmFi2yKvUjjXWYdq8ifXd5pNLuW3BraQjshWwdVrTc5Kz9nVt+?=
 =?us-ascii?Q?CCmqA0c2g7NmSRLbVfi+QftnwtMasUlBzyVRbHGdk4+wm1rgdc8EGyDQ/C/v?=
 =?us-ascii?Q?3rVNB0tVWrtJ7DKEVJq7kypYswVK54hxQ+x9tC1XfMlAHQND+SKTVi+/42in?=
 =?us-ascii?Q?TsBhrlf/vBe9g/mWm/7x7jAn2lUvfvNl4KeIzhii/nmpuH3YDzEXkjkMhUkJ?=
 =?us-ascii?Q?peSDc9KTxP3shJ1R/QAMUafgo9UCkk70rXZ53wE1we39qKAWB2pHDL8MZiUm?=
 =?us-ascii?Q?r1jXJFX0WdFSsYJrp4Gf9qXZsRMJxH3dLaQ2+pSXGxD5j6WUUtAKXiG1n+n5?=
 =?us-ascii?Q?vxgTYbGyCfoulTz8FYMpv3Y5S3OMrUyBkrkNebzJ3LaPZopGVzRNmRPWgypF?=
 =?us-ascii?Q?LfKxVrzzemZkrXKJes5p/YPHBbnGHXLzOPPNOlnDXajWK8tLCmLkEj08qRmL?=
 =?us-ascii?Q?tAvukvJu3kzUxjHzBftwGZPkI6R/mDH2lNVKWYLX6KMlzuBg6DU8H5as2zMx?=
 =?us-ascii?Q?SxPEuonH26cBe6CPIszd2XUKb/evX/G1JqFvTYsQJaz0BEnSImrRFfJ8cnhl?=
 =?us-ascii?Q?Aed7x56JnuMypSGMXdV1RU1AuCivG575RgUB4GlqZP1Q3qjF21jWcEn3D0aw?=
 =?us-ascii?Q?ZySpDqtF7G3UtVaIccPXoqAOn2qIE+FZlyBZK4zMxtG8lKrffktHDKc6CIT/?=
 =?us-ascii?Q?1sU1gOUv0URS4+P0LiX2hBflTiIODEWa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 19:15:01.6400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0bdc6d0-5368-4d95-44e3-08dcb25e3e0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6282
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240801_121506_332266_B2055E86 
X-CRM114-Status: GOOD (  23.23  )
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

From: Ashish Kalra <ashish.kalra@amd.com>

SNP guests allocate shared buffers to perform I/O. It is done by
allocating pages normally from the buddy allocator and converting them
to shared with set_memory_decrypted().

The second, kexec-ed, kernel has no idea what memory is converted this way.
It only sees E820_TYPE_RAM.

Accessing shared memory via private mapping will cause unrecoverable RMP
page-faults.

On kexec walk direct mapping and convert all shared memory back to
private. It makes all RAM private again and second kernel may use it
normally. Additionally for SNP guests convert all bss decrypted section
pages back to private.

The conversion occurs in two steps: stopping new conversions and
unsharing all memory. In the case of normal kexec, the stopping of
conversions takes place while scheduling is still functioning. This
allows for waiting until any ongoing conversions are finished. The
second step is carried out when all CPUs except one are inactive and
interrupts are disabled. This prevents any conflicts with code that may
access shared memory.

Co-developed-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/coco/sev/core.c      | 132 ++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/sev.h    |   4 ++
 arch/x86/mm/mem_encrypt_amd.c |   2 +
 3 files changed, 138 insertions(+)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index de1df0cb45da..4278cdbee3a5 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1010,6 +1010,138 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
 }
 
+static void set_pte_enc(pte_t *kpte, int level, void *va)
+{
+	struct pte_enc_desc d = {
+		.kpte	   = kpte,
+		.pte_level = level,
+		.va	   = va,
+		.encrypt   = true
+	};
+
+	prepare_pte_enc(&d);
+	set_pte_enc_mask(kpte, d.pfn, d.new_pgprot);
+}
+
+static void unshare_all_memory(void)
+{
+	unsigned long addr, end, size, ghcb;
+	struct sev_es_runtime_data *data;
+	unsigned int npages, level;
+	bool skipped_addr;
+	pte_t *pte;
+	int cpu;
+
+	/* Unshare the direct mapping. */
+	addr = PAGE_OFFSET;
+	end  = PAGE_OFFSET + get_max_mapped();
+
+	while (addr < end) {
+		pte = lookup_address(addr, &level);
+		size = page_level_size(level);
+		npages = size / PAGE_SIZE;
+		skipped_addr = false;
+
+		if (!pte || !pte_decrypted(*pte) || pte_none(*pte)) {
+			addr += size;
+			continue;
+		}
+
+		/*
+		 * Ensure that all the per-cpu GHCBs are made private at the
+		 * end of unsharing loop so that the switch to the slower MSR
+		 * protocol happens last.
+		 */
+		for_each_possible_cpu(cpu) {
+			data = per_cpu(runtime_data, cpu);
+			ghcb = (unsigned long)&data->ghcb_page;
+
+			if (addr <= ghcb && ghcb <= addr + size) {
+				skipped_addr = true;
+				break;
+			}
+		}
+
+		if (!skipped_addr) {
+			set_pte_enc(pte, level, (void *)addr);
+			snp_set_memory_private(addr, npages);
+		}
+		addr += size;
+	}
+
+	/* Unshare all bss decrypted memory. */
+	addr = (unsigned long)__start_bss_decrypted;
+	end  = (unsigned long)__start_bss_decrypted_unused;
+	npages = (end - addr) >> PAGE_SHIFT;
+
+	for (; addr < end; addr += PAGE_SIZE) {
+		pte = lookup_address(addr, &level);
+		if (!pte || !pte_decrypted(*pte) || pte_none(*pte))
+			continue;
+
+		set_pte_enc(pte, level, (void *)addr);
+	}
+	addr = (unsigned long)__start_bss_decrypted;
+	snp_set_memory_private(addr, npages);
+
+	__flush_tlb_all();
+}
+
+/* Stop new private<->shared conversions */
+void snp_kexec_begin(void)
+{
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return;
+
+	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
+		return;
+
+	/*
+	 * Crash kernel ends up here with interrupts disabled: can't wait for
+	 * conversions to finish.
+	 *
+	 * If race happened, just report and proceed.
+	 */
+	if (!set_memory_enc_stop_conversion())
+		pr_warn("Failed to stop shared<->private conversions\n");
+}
+
+void snp_kexec_finish(void)
+{
+	struct sev_es_runtime_data *data;
+	unsigned int level, cpu;
+	unsigned long size;
+	struct ghcb *ghcb;
+	pte_t *pte;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return;
+
+	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
+		return;
+
+	unshare_all_memory();
+
+	/*
+	 * Switch to using the MSR protocol to change per-cpu
+	 * GHCBs to private.
+	 * All the per-cpu GHCBs have been switched back to private,
+	 * so can't do any more GHCB calls to the hypervisor beyond
+	 * this point till the kexec kernel starts running.
+	 */
+	boot_ghcb = NULL;
+	sev_cfg.ghcbs_initialized = false;
+
+	for_each_possible_cpu(cpu) {
+		data = per_cpu(runtime_data, cpu);
+		ghcb = &data->ghcb_page;
+		pte = lookup_address((unsigned long)ghcb, &level);
+		size = page_level_size(level);
+		set_pte_enc(pte, level, (void *)ghcb);
+		snp_set_memory_private((unsigned long)ghcb, (size / PAGE_SIZE));
+	}
+}
+
 static int snp_set_vmsa(void *va, void *caa, int apic_id, bool make_vmsa)
 {
 	int ret;
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 61684d0a64c0..733448e72a9b 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -417,6 +417,8 @@ void sev_show_status(void);
 void snp_update_svsm_ca(void);
 int prepare_pte_enc(struct pte_enc_desc *d);
 void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t new_prot);
+void snp_kexec_finish(void);
+void snp_kexec_begin(void);
 
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
@@ -455,6 +457,8 @@ static inline void sev_show_status(void) { }
 static inline void snp_update_svsm_ca(void) { }
 static inline int prepare_pte_enc(struct pte_enc_desc *d) { return 0; }
 static inline void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t new_prot) { }
+static inline void snp_kexec_finish(void) { }
+static inline void snp_kexec_begin(void) { }
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index f4be81db72ee..774f9677458f 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -490,6 +490,8 @@ void __init sme_early_init(void)
 	x86_platform.guest.enc_status_change_finish  = amd_enc_status_change_finish;
 	x86_platform.guest.enc_tlb_flush_required    = amd_enc_tlb_flush_required;
 	x86_platform.guest.enc_cache_flush_required  = amd_enc_cache_flush_required;
+	x86_platform.guest.enc_kexec_begin	     = snp_kexec_begin;
+	x86_platform.guest.enc_kexec_finish	     = snp_kexec_finish;
 
 	/*
 	 * AMD-SEV-ES intercepts the RDMSR to read the X2APIC ID in the
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

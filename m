Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DCCC67861
	for <kexec@archiver.kernel.org>; Tue,  9 Apr 2024 20:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wobfcGnNYy8bomCaTEigaFDMA0N6TzXZyFPbPjM6H+E=; b=3GIy7kPaCE8ZOw
	vxLsdaGfptbocD75VP3qyEw+7FS7ALsYXC9fxmENmMoEKdscoxVKrELsfMpaWgldRABv0/C8GWrdt
	wq/oRYCWWjjqsgIal5jbeCZ5KcnKxekFJEMDrpTwUeX6GxDy4LChQ1YZ/gD6ZWPTzJxQqKdhqiQAy
	nAqGCIKomkCFrYWUhdDD7p/MUg3OoIj4Kz4b3uaIxr8bJb0LFyr80MEY8SHxIdByH1hR189HHUYcD
	DK03EsqwNQKYG2nertNRQhpujYPi2fd9zpYBRQvDcQhfTHPxpBr39+bpxv0AZe+dtks02490mgIxn
	wppwl3Yyonlpo/SheaJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruIJK-00000003mDh-32uB;
	Tue, 09 Apr 2024 20:43:18 +0000
Received: from mail-bn8nam04on20600.outbound.protection.outlook.com ([2a01:111:f403:2408::600] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruIJH-00000003mAt-16Cn
	for kexec@lists.infradead.org;
	Tue, 09 Apr 2024 20:43:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVcm6RzzgXiV+lGFsfVr1he6JxMxCMAFqheXPukAYOzdF+1sEk6NRlOyY++Ub9tZ0XKCK/436rrseZjArH5m7O4rIgGH6F2mSklsRQmUsT4YzAnYmATO6ypzD09gxGz4jujzTOT+eLY4KqOCE5XpAV+l+y1b2kdXBFWtFoK2wLAHJRqEJKlHwg8KSvL1BseoVCigUuRb87inoKeTnn0MDTrUp5xLM9jQeWhwmyl8a++jb411CVd7AdKU5uS22Kj1igXLFKdd6pNcJIHYOgREykgyZJPy1NCK6KGxQeIu7ByTR+98uNHBh0LoieorsNziB9jRn5Yc2FLYPWuCZVuZYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PELSJenkUMgeqWvNCdjkpMx5JK7Rlf/5sCsFjgBJcM4=;
 b=cMjFjvt7C+HQH1lBQRjzEe4EYkeqKS7mdB8mFnUYluxbVzT08Oo6BAcogThnXH5vDyjPi+J3b9hynVP7iBB05MCqTiqXawnQVZ+BR4+f4dkMMwQ9yNLJyMjPqNllUF4pdO/LGKoew3dyT1SUrt3N541bOoVsfF7muIRLIvc3Dq2KEUIU7EVdXwaDKxbMEM6xGY984UCXj/RJAW0/bbQTslKC2dtkUnRvHmMSLuX62VdhB8CukYZ0r2vGjNqF229RfIYSJ1CdOAGrnzcjfzY+yTNRSZTDerzovgjAvgbVyTtLOuI4A+DH/DlbvshGEt9kOuzbylhX+uNun4p4W6Hxjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PELSJenkUMgeqWvNCdjkpMx5JK7Rlf/5sCsFjgBJcM4=;
 b=v6hqMewF4eC+ivP/XQpmSE8MlQGz6rIi6V+5WLoPMqTz8PB2nS/PoZjdL5g42IWP0kx18vu7a//J1XiuNSkTerq9EeOu+4SNqsLkjo9TdgQgHah3ZrQcgZ11s0xbRkIa1bTdgEhWLkpdZUzWbI9KSi56YOikmFRPzFeKbfbzEjk=
Received: from DM6PR07CA0075.namprd07.prod.outlook.com (2603:10b6:5:337::8) by
 LV3PR12MB9438.namprd12.prod.outlook.com (2603:10b6:408:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 20:43:09 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::14) by DM6PR07CA0075.outlook.office365.com
 (2603:10b6:5:337::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Tue, 9 Apr 2024 20:42:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 20:42:34 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 9 Apr
 2024 15:42:32 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: <rafael@kernel.org>, <peterz@infradead.org>, <adrian.hunter@intel.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <jun.nakajima@intel.com>,
	<rick.p.edgecombe@intel.com>, <thomas.lendacky@amd.com>,
	<michael.roth@amd.com>, <seanjc@google.com>, <kai.huang@intel.com>,
	<bhe@redhat.com>, <kirill.shutemov@linux.intel.com>, <bdas@redhat.com>,
	<vkuznets@redhat.com>, <dionnaglaze@google.com>, <anisinha@redhat.com>,
	<jroedel@suse.de>, <ardb@kernel.org>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/4] efi/x86: skip efi_arch_mem_reserve() in case of kexec.
Date: Tue, 9 Apr 2024 20:42:23 +0000
Message-ID: <e399107dbe1b13db3af7ab702400a5dfe0a1e9a3.1712694667.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712694667.git.ashish.kalra@amd.com>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com> <cover.1712694667.git.ashish.kalra@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|LV3PR12MB9438:EE_
X-MS-Office365-Filtering-Correlation-Id: 964e84c9-ceed-4950-14de-08dc58d595ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9lqH2+4EuCAEa4DORRaHa026UEHf+f4V3Y0BC2wEY/Iw7WOLRck9/H2qhgT7291FStdMER0UyFSdXEd1UrsWoVwlIHUcfgRb/z4t43g2HRJ/Pe1PMFOxukjL4RBxkZ82TdxDW08mNQtXNnAxp41O/xRAC3GzJZCpDC+PUMeXXC8xyiqee7SNehjJ/IdWMXfNf6D0JUDJTy203SJ+8iBvyUN+PpV9fRYwC45hkFB8siKZt1XL+V+pyvdY4wMaRwH2n5VGJDM+btBcY0qF/ieKQz8WWm3Ui/xhdW/fQ26CJMYqLONmiS5cmjusfb3/JmhPCFHGHx6AYw/KcumjjgI8H5Cc8BidsPjHyTWF0S8ofGM5nXCinb9hC1klxZKDilknA0bwtPphkv6Nv9YsGHcor6dEEztlErEiOAwy3DUixOAe6uTPwQP3TpjzwXMa0qdfT4Se49jy6A662GLyLL+uvUnYAd+pksGEhUfydmVVV5eEIhzkF/6BG6WyxNH+xZAWDX0qCNkUecNbNYrLMsreeAQtodJHXIy4VTHiIPXmbX+88gwb6SFeIrB1pdHy4rLpYCTLGcm5mT3WJS2s5WiIZJYJ2lS3MFtRrkl4Uy8BwfJGzR+vg578N3RkCdT1cIQBCP+BF63QcVkR4oNAuLUTMyFSeOPxNd0iInRka1LYzGppMj7ZN7nnpv0r8ywT9MXx+VBfgb1CHAOxyRACgLL0iTxUQ+gLRntZPJa1neS0qFTxqL7iIEa6Lr8gK8s7FyDS
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 20:42:34.2325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 964e84c9-ceed-4950-14de-08dc58d595ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9438
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_134315_331735_2AEDADF4 
X-CRM114-Status: GOOD (  14.35  )
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

For kexec use case, need to use and stick to the EFI memmap passed
from the first kernel via boot-params/setup data, hence,
skip efi_arch_mem_reserve() during kexec.

Additionally during SNP guest kexec testing discovered that EFI memmap
is corrupted during chained kexec. kexec_enter_virtual_mode() during
late init will remap the efi_memmap physical pages allocated in
efi_arch_mem_reserve() via memblock & then subsequently cause random
EFI memmap corruption once memblock is freed/teared-down.

Suggested-by: Dave Young <dyoung@redhat.com>
[Dave Young: checking the md attribute instead of checking the efi_setup]
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/platform/efi/quirks.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index f0cc00032751..982f5e50a4b3 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -258,12 +258,28 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 	int num_entries;
 	void *new;
 
-	if (efi_mem_desc_lookup(addr, &md) ||
-	    md.type != EFI_BOOT_SERVICES_DATA) {
+	/*
+	 * For kexec use case, we need to use the EFI memmap passed from the first
+	 * kernel via setup data, so we need to skip this.
+	 * Additionally kexec_enter_virtual_mode() during late init will remap
+	 * the efi_memmap physical pages allocated here via memboot & then
+	 * subsequently cause random EFI memmap corruption once memblock is freed.
+	 */
+
+	if (efi_mem_desc_lookup(addr, &md)) {
 		pr_err("Failed to lookup EFI memory descriptor for %pa\n", &addr);
 		return;
 	}
 
+	if (md.type != EFI_BOOT_SERVICES_DATA) {
+		pr_err("Skip reserving non EFI Boot Service Data memory for %pa\n", &addr);
+		return;
+	}
+
+	/* Kexec copied the efi memmap from the first kernel, thus skip the case */
+	if (md.attribute & EFI_MEMORY_RUNTIME)
+		return;
+
 	if (addr + size > md.phys_addr + (md.num_pages << EFI_PAGE_SHIFT)) {
 		pr_err("Region spans EFI memory descriptors, %pa\n", &addr);
 		return;
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7F0C4345F
	for <kexec@archiver.kernel.org>; Mon, 15 Apr 2024 23:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wobfcGnNYy8bomCaTEigaFDMA0N6TzXZyFPbPjM6H+E=; b=vqnF1Vcz+zq5QJ
	hLqoHTwuTML9W9Pmp+eCMS5RxsYDc9hr63gqu2VZ4QewgZoho1ZcgAj7UB9xYx7s0FulZfBzmM8Of
	8xNbLpSGxBs8jQKmmeJTS4zfB9nXi4uDyGSm8g4O3pQpMn91OC3kJ2u4P1tpPvRj7DYQ8LRvIGrRX
	p8ZIgCCJCWiSnZJs3cvtqPT1kRjcUeh+bSVcI4GzE6cIs15LjFQl83TFyhDXuTsEOGIMd+abrt/p/
	oemKSoxOpr/f2nR6kf585GvogGid5x+3qR9mL/Cbhx2hriWrMHyH6pJcHv6ME14PGi1BbYJdlCeDa
	FjUV01teU+3WrXmwWJsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwVfa-0000000AAQ0-1krw;
	Mon, 15 Apr 2024 23:23:26 +0000
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com ([2a01:111:f403:2414::600] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwVfY-0000000AAPF-1rYG
	for kexec@lists.infradead.org;
	Mon, 15 Apr 2024 23:23:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haNDZYdk7eJLWYzlSJcbgCpIWWC5h3Po53T0ijpf4x0eQBmBmJi4DXDAva4It/1DMrJcQtHkabL81YVw52wpgu+jvnCeJLHJrQVvsRllH+L1JWdut3tavMmq2i3zyQzFjNtQF9oDU01kzoNhMyE58+fhM+AtPal4cjOxXI9TgfjSETl9Qn7LDhGVXysBXFMq9lrLu1emrt7Tl6qm9CAge7gx+6+RyV8Rkr2NMmJyYTeyfWAwIeoP/BRDm2wmanpxWxPqCAY6D+sWz5BjezPJY2wCTkUyvitzTbO9S7eaL/U+WVoLiFfI0SsmGA0yWgrV4xllu6Cziv5EeJV9NY7auQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PELSJenkUMgeqWvNCdjkpMx5JK7Rlf/5sCsFjgBJcM4=;
 b=B6HNZaX1yWgjHiKtKhHlK9bxa1RRXWhp2ToF2Cx+RBXqDO1gFOUZcUOXyFuQGwQ4/AK+T2IUBC0/gdmaWa3BqVFIengM3q0jWgLrKwtuYBO3i4HhylxUDaLT8CU2Z18ehNNHluomBJJzNSBWj8207LD0Ey4nyw5xaddnx0x98ZM6RrVmzCfd5ei5uG18xru55QPIg6HJLLabAOo2MB53niZHONvkwHhCJIFPOKh4BrmQcbSpa5J5GGoq9neDlUwkeRFTgFn1iEugv67cwStHR8JlXqJG8g8ido2UXZwHxNxkCTtkHAXqBb8GtoyZjDANmShyxV98KkoxPhbIyCUiHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PELSJenkUMgeqWvNCdjkpMx5JK7Rlf/5sCsFjgBJcM4=;
 b=Qn68Oz5HcM1RH4WDCyl9Ov7q3cw7fO37TKzIoGMnQd+nXMO3wKmgYekUGs4bxiFFraK2V0k2zRcxA86OjL0FQ1jst6Kl7bGyB7hKiiF/8ijQCsARzcfDAvbRXopUq0PCDBOZ6Y8RAoYyF5x5wOQoLtRBD8dQvjZZmXoMrmBc4O8=
Received: from BL0PR03CA0031.namprd03.prod.outlook.com (2603:10b6:208:2d::44)
 by DS7PR12MB8082.namprd12.prod.outlook.com (2603:10b6:8:e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 23:23:08 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:208:2d:cafe::60) by BL0PR03CA0031.outlook.office365.com
 (2603:10b6:208:2d::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 23:23:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 23:23:07 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 15 Apr
 2024 18:23:07 -0500
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
Subject: [PATCH v5 1/3] efi/x86: skip efi_arch_mem_reserve() in case of kexec.
Date: Mon, 15 Apr 2024 23:22:58 +0000
Message-ID: <a3032e4b7a5406c26aeb66e9380043c410d07e3d.1713222642.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713222642.git.ashish.kalra@amd.com>
References: <cover.1712694667.git.ashish.kalra@amd.com> <cover.1713222642.git.ashish.kalra@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|DS7PR12MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f951751-a4f1-44c5-d6c8-08dc5da30251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i13mXz6TOcRSGo6bCjvnRIVsXsAWiFwMu2kZgIxfXGY9YIZeD1lJnny0QprkRGOQotDf4386OlB/FWSOHAwM2qL2g3KFeyYfMg5jcUxGR1BMvh3hinzkvX9sYjZTReBgxkVjTMhWx0YXzM5ptS+4R/TMMN0W0mfHcHU0xDbHi4Hc8WgloqC/afpLrnPqSreTR29DdTI8j8/8i8l/f4iL3/5JEEEje6VwSVETxKQjdiQZ+7EiAdUC91NitzxSFnpRGmzzqBfxitAxU205sNYTZP0WTx26u4ZWJMNXzXP5NJQrLa4HhIHYe6U7ElTZsMww66lze9kUvqbEYgFcD1c3Hh5TxiLRYInw/0ey42OuFTsqroZbfs5sk23+BrDdzfGb1YJxEIeMgmTyb66EMvRhqI6fQMCoJxsDgAKnxYYlYkxC3Nkvm/xhSz83jxyNf++tSkGcS8VzvQ22tX9YQoOsvRvNN7BucfLADHGQqRV4cRW4YIw/bJxi624PqE2zXSZDCNad9akoofmRbCMMbvUZ68MJCNncxyjUF1vH+u6bjlryH4bxd2wFdWzKbYTz34x4YKZypYu0oWYKpR4AOZvShUjCjHJK387o8b87m7ZCqve3hXfPRzMRwBg69DdQwakhFVVJuqqFGBEnqlBP4TCeaylp8iRdI8gmLychUwzuHYiYxYiwyFbEW3kKPFG0rfZtrxejO3VBP7iR/MEWt8bkOLJOwGpRBbNDYA+vHRG+Isxq9dTZDtiAkhY4wuVyCWMj
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(1800799015)(7416005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 23:23:07.9113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f951751-a4f1-44c5-d6c8-08dc5da30251
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8082
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240415_162324_512391_7A847D0C 
X-CRM114-Status: GOOD (  13.93  )
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

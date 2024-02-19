Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA3CC48BF8
	for <kexec@archiver.kernel.org>; Mon, 19 Feb 2024 21:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=mmOfHZQRqLt+zYrX2KPCihpWhTtu8tY5zw1XCGyDZmU=; b=ZoG4xmdrPOnLCd
	NZFjZrebzwdVaez/gDaLqZElKg/+dsBJCjDi8SyAC/WfDoSjreLG3LZcmG75JxsZWngCAce/Vr9tb
	Z+Awx1ZQ3ADcOjA++6xabTGqHVO+Ite5jWFykON4l9ipTCYTmY+f9JAJBen4RvD8g9QndDT9gnn62
	oJ2bKrNduzmbSzQI9W8RahiZfZ5WHA6iViAHnAXkr1bTPGoI8dkxMYadWpAH54b2OPomp4j8jWnz+
	GH76w3Q08HqLQh53YSdVUF8DqDYoHjbWEkfezkQ1ljlIXwdLKg2r14q59e5LP80oqozoRMuyoEVgO
	apnunFIaifTZm+ZLyu8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcAw5-0000000CBqZ-25H8;
	Mon, 19 Feb 2024 21:12:25 +0000
Received: from mail-dm6nam12on20600.outbound.protection.outlook.com ([2a01:111:f403:2417::600] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcAw3-0000000CBpO-1uSc
	for kexec@lists.infradead.org;
	Mon, 19 Feb 2024 21:12:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGXR/RFgHIwl55y2sSHxH5H7WZICoZh1sdRsVuZCjLIWvC5TUOu0VNz85wENCL1GUajwUXc0yXqUhloZUt28kzqRproM7Zt+g7P1dH7z9Z59Nidirm/EhMvoCuCyvwceI9ff+bydvQUKTKUdjxiW20WHlryIIy92DSrqT7Z1t2NTFlGncL+t/Y1hPKEcQeVJ2lShMugs19GFxRvvESBRp50u+BZSAM+feS+NuG5Upkx9YU/L3vc0GF6rT0eqQCBGPlBsLjfvKUz/0i/WCnO1HHF2zGOQ68nqXuDtzgjz6TsmJMqAq2YAJK9d7Wff8Gb+Jsqzll5uPVeSyWGD3obiEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6PG7rDVf4cEk4RqzZVKG6iYnAzchQ1zPvQVV5Q2L+4=;
 b=Qr8R4pxaY1LxSb5a7EGqFOd+up6aYX99Gn5p2sMZuuB4u+B4fkwc61Aa3+I70cnconaNf4LJya3yxyWeym8c2TNDaBrIudCfrfP7zmGoAhjVV2iRfH1f5Jpv/UfFLojPPvb4AvjtdhzDnjSF9TQ6CJYul6rKzHD/dM0hcMRazWSsWlq5ZzeTFglR8PQZEy+Su9iKSUu7AX1qGwrAa1TYHriA2fcb5T3T4dZEW6FddZbKn/CtOQ1XO/UzQ8BNXvSok7tDQialRjZxTmKMRLOcVmbr/q+QW1VaOyxU9ByS2fJkTdNn2PZG7F3TV/vfL/WLvBEY9dgqfpZYne5YZAZZ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6PG7rDVf4cEk4RqzZVKG6iYnAzchQ1zPvQVV5Q2L+4=;
 b=HwD0a/z7KGyd6k8usNyKZg+PWsjCFcXWXXqPjvds5Lh2x/gz/cgQJd9MX4UofgfyuyZWN1gkDXrB4/DFPbmGnn9Q4OOjae9IB2wjz+UOfS/aKcuu6EbAqQuCDpR00qXGfMOWKvqtxDe4fu1Z8AfkaK+Vuoe+WkJV6WBO1hvk4CU=
Received: from BN6PR17CA0054.namprd17.prod.outlook.com (2603:10b6:405:75::43)
 by PH7PR12MB7233.namprd12.prod.outlook.com (2603:10b6:510:204::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.16; Mon, 19 Feb
 2024 21:12:09 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:405:75:cafe::d0) by BN6PR17CA0054.outlook.office365.com
 (2603:10b6:405:75::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Mon, 19 Feb 2024 21:12:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 19 Feb 2024 21:12:09 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 15:12:08 -0600
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: <ardb@kernel.org>, <hpa@zytor.com>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <rafael@kernel.org>, <peterz@infradead.org>,
	<adrian.hunter@intel.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<elena.reshetova@intel.com>, <jun.nakajima@intel.com>,
	<rick.p.edgecombe@intel.com>, <thomas.lendacky@amd.com>, <seanjc@google.com>,
	<kai.huang@intel.com>, <bhe@redhat.com>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <kirill.shutemov@linux.intel.com>,
	<anisinha@redhat.com>, <michael.roth@amd.com>, <bdas@redhat.com>,
	<vkuznets@redhat.com>
Subject: [PATCH] efi/x86: skip efi_arch_mem_reserve() in case of kexec.
Date: Mon, 19 Feb 2024 21:11:58 +0000
Message-ID: <20240219211158.768523-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|PH7PR12MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 9593f61e-3912-4aea-ae6e-08dc318f6f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zv5+Wj+QPkgmwV77lGpy67xlucjkDzmfuaeb/L6kP1ZRU8RFIhev9Eg0Z0mFZlBUrxbGW2daC1Mn3+3yge4VNwhklL6DDyqL3isZ9HbryqoHGeLSJKr73Pq/pYjK4icHc8lZAe06un0fm+5hFkGQRW32HES0w/F50HAfRQ8YGnRDaQRJU+qkG8OOIXQYx6fDz3N3Ob5uL3UCbM66bQiU/z+D4Hnso/NrxmRi2IsPSh2LbMUbnALhN6gfuNlIocZsVm1lxavWWOojuYDqfl9SUGyHL2SCNCqfuBUFgMDm7ZYSS4QcIO2BeK94TlmR735zbVZvdEEblA2Al31sTLa9xSSqV7N0JzSw1VRxkTAFICBppC+TGMruB02Sel/o/cTCZUP6I8LHaf2LNvSNEmaWBL32VlYhMHw05x0cfJgSL07BMXcvrmWzqbSTBqTSW6PU3ff6LBAjT5ZQ2+LknyR6wKlKyi1NHc5PcrngL1c8i7l8BN9zCuGHPvIOtrxT6PyMpIC5hr5Hy87+d4wjxN2ZOP7TLa+PtRtzMPj/oUE1BkjatZ+eVqpTFM3/cBgqpgVWhZG29Gd9ZClKf/0H0O5vuy4sKyL30C/P2djd3+tiGdzu6JjNJ4WnMMPKFFnlDD68+bm1iDHqTY1tpTfvRU/JI4uxmi5HVPlP9K/TaxGPjfY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 21:12:09.1830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9593f61e-3912-4aea-ae6e-08dc318f6f02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7233
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240219_131223_503441_18ABB88D 
X-CRM114-Status: UNSURE (   9.90  )
X-CRM114-Notice: Please train this message.
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
efi_arch_mem_reserve() via memboot & then subsequently cause random
EFI memmap corruption once memblock is freed/teared-down.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/platform/efi/quirks.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index f0cc00032751..d4562d074371 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -258,6 +258,16 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 	int num_entries;
 	void *new;
 
+	/*
+	 * For kexec use case, need to use the EFI memmap passed from the first
+	 * kernel via boot-params/setup data and need to skip this.
+	 * Additionally kexec_enter_virtual_mode() during late init will remap
+	 * the efi_memmap physical pages allocated here via memboot & then
+	 * subsequently cause random EFI memmap corruption once memblock is freed.
+	 */
+	if (efi_setup)
+		return;
+
 	if (efi_mem_desc_lookup(addr, &md) ||
 	    md.type != EFI_BOOT_SERVICES_DATA) {
 		pr_err("Failed to lookup EFI memory descriptor for %pa\n", &addr);
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

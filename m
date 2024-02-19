Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A65C48BC3
	for <kexec@archiver.kernel.org>; Mon, 19 Feb 2024 22:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=XQ3Db5ilW0zKC8XHPWIRY5GLo8Qg99pITEuxfSkXkSs=; b=Tx15jCjAjYATFq
	MunXqHCh9cvR4gBafPWAXGDVbPEkkUqNySSxPE9kDkUsE/llSGYIaSZ49M5dpc3Grxl1j+Z0SxK2E
	Vsqfjbz3pESIWpAm+v0GatvTYFomqbCAbjYJpTl7QQhw0CFvMAvs3zve/qnym7v78par0C6dGYTRL
	V+NvangVJIaYIcH1FizZjCTYF/mf+QanFhoZi2ndv3tYE/mYdwYgQ6Po+GyIE4OErUKh0ArUcgeB9
	nojGMH3Sw01zZeorqU+iXbP18QnRJs8aQG5D6Y2q2sarbF2yDO30aOZyyIB9wIqwcE5dys8HLsIDF
	Wa4u50jyiVE4NgGKPr1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcCXc-0000000CVGJ-3cA9;
	Mon, 19 Feb 2024 22:55:16 +0000
Received: from mail-co1nam11on20600.outbound.protection.outlook.com ([2a01:111:f403:2416::600] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcCXZ-0000000CVEz-3RWq
	for kexec@lists.infradead.org;
	Mon, 19 Feb 2024 22:55:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njBr592sd/Jcgjy33+k114RxaCm97CHUXBzAJdGWlaom2T2MxQbNFpR5IQO9S+UTVHAWAxyQxNtGg7rEcZgcSoHjvvaSFLFBCwFUh51I9G09K97zo9rpKVsjTaAZKtiAl81PrpBNELrcUQkK8igult9xKNuualXzqkkrtPyX6u8r3SgUnK1SztneIIhv/GHhaAcmNcZ70Coxabm4eubpVTtIIpSj5rsxLsCHtm2jNkrJO+IbTx5AyAASHz/aOWAOP362T90DcdanXg82xgCJveJoAVw/Qf4ru64KZ5VyTOMyLQD1RJjaiUp8UBbFWsWwgW9rOJD2Aoz69mp4nf0tPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7krmcbrX6fJrYRXKqedy70aof1EtOi279EOdlJzQ08U=;
 b=mTfLfeVlWkBqU/ZR6peIWVVm6B5l4AilM7M+cmdK5qpnWXX0gX8QDRku634y0RSHzLDU9zv8xop5orIel/xTqihUg7nb7MFWoK7dnGNfJKFEJvIZo7X7vwzD/dkaQ+Lzd9Jsqs62CRaGvjhzd+f9NTQUh+mLAVVfQfQo71WHOpmkPdf3fjj1/QBBZz/jnS3+iMG5gkDlorLADRPotApmewJs5wPPP1H0IRh/MrTthCAIpQ+NzKquDR/vUofvQMGwULChpR646AZ5AFhLQWq3aiAH9uHQ0/b/8+5DWCVx0TWzccht/nC7JQVLiHYMWdHfGOj5k2PwqEp6FR8Ql50ZXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7krmcbrX6fJrYRXKqedy70aof1EtOi279EOdlJzQ08U=;
 b=iBW7/Aw8MgiS0twKl1mcK8FtlfaUq+jJFm9PXs36ffyJGms19YP7Ibrd6MckOOPf2bT8t2Kjn3d8ra0oXIMvEjMUWFqa+5yQMEJTUoU7hmooOuUCuVc0AJzLzv2FH1ysQBG706eWQiI+Fw2NHrBgrhnvFuP66K2cSB22uV1mXXw=
Received: from BN0PR03CA0045.namprd03.prod.outlook.com (2603:10b6:408:e7::20)
 by PH0PR12MB8149.namprd12.prod.outlook.com (2603:10b6:510:297::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 22:55:03 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:e7:cafe::2c) by BN0PR03CA0045.outlook.office365.com
 (2603:10b6:408:e7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38 via Frontend
 Transport; Mon, 19 Feb 2024 22:55:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7339.0 via Frontend Transport; Mon, 19 Feb 2024 22:55:02 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 16:55:00 -0600
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
Subject: [PATCH v2] efi/x86: skip efi_arch_mem_reserve() in case of kexec.
Date: Mon, 19 Feb 2024 22:54:51 +0000
Message-ID: <20240219225451.787816-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|PH0PR12MB8149:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc7059e-eb5a-427c-37f7-08dc319dceab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: irKuAdDcW6m7ves3rSRgiQxmzr/l0WJQlVeWt/BJ4cex4vB9Pbno1v6fbKwTeVqNw2etE866KLgpcf46mHBkyWHQOrnRD1s/ABJXCMCR9kZ7mp/G/P5pQKQR5rNRFbOeVivsWMbydZ3JTBqw11ypP0W+p6VioELHC6H2OKcK8sFsnWefKQhmRsN31SuaNJU7ypPPfK4HL3KXqhxaiVUJVxtx9ZXiQJMxBMWj6X3TJKku7UykX00ZpdrHyemT5751O0vph0P3l5Pbb/ueBHmVF2XzpN7/g6Bvio5q3mgJ3rZGkSkO544oSBsRlSp8HfftQqw/5XqgrLwBbgRiRJw04b75YAyHnDhRwqXGt8BjSZ70zzsjxANNZ9UiZQ+MEs/peYLWUWP+zKzxNlicfd2AEQCmYLBwof6wSLradVwhoUOafLXMSHBW+2PEHCrw4alTZSZNa9BxVFMs3v31D9Idq6Aw1zTLQ7voXpKU1/96c6AHy7XgFlIXt+zvKdWFYqtoAade+4YemjTB4GuUr6jb1YF3+7gylDfZ3tkOo8dXOOw1LmVlZrKDnf7QoiYsQD/hsFrtk7jEfoVgVFeEVBKhM4mfSZxfsYnjs6Esid/GNEWfpHwr90bsPT8ZkRZPEuY2U1RKI4FpqHRyflJP56GTd+exer649teTLFbsHaxGvJE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 22:55:02.6252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc7059e-eb5a-427c-37f7-08dc319dceab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8149
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240219_145513_871442_C00E6866 
X-CRM114-Status: UNSURE (   9.91  )
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
efi_arch_mem_reserve() via memblock & then subsequently cause random
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
+	 * the efi_memmap physical pages allocated here via memblock & then
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

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A057BC369DC
	for <kexec@archiver.kernel.org>; Wed, 30 Apr 2025 23:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kelfFKDop0PpNl47F+xPin6yc14dyK6qkvxJB7sy5hQ=; b=ZD61bJCtKo/9WiuiXhEcvFLrJ4
	w7tVbh7C/NtTIQelcS9qon+FqmEQCKbIla1qjW/y9e3KFaI4cdjERZfBGT2d2tAIMhWOQJ6OMXFgj
	AtD1F2NZff8XjpW2MtS7HW/m6cfyn8JoJM8RJmbuLmQrD9mSpK9+zY56gMTEib8cYoPURSvEefE51
	BNoCQfwKuPoSZNFldIxTNMnBFZs8av3AIbktzVyuhv/c7dH/uPnB3CY7KbsI0Jk8DkDzN0FTe1v/B
	bgpu6JBDXcbWjUTb3GTUkCIccUXaeJVv7w2kbUqz4il7Z6NMcCeGPMm6myf/jpBWjRyvncsJXz7yS
	kis/zj3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAGiU-0000000EF2F-0Z2A;
	Wed, 30 Apr 2025 23:19:50 +0000
Received: from mail-mw2nam12on20602.outbound.protection.outlook.com ([2a01:111:f403:200a::602] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAGgn-0000000EEt4-3FfK
	for kexec@lists.infradead.org;
	Wed, 30 Apr 2025 23:18:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7rLuZtfR9YewY6GToK+OB0aX+16HuT3nTpGQxTsLWBfM3Ed47j5v/zoWP8PAbTtUOsD3UlBsjZXFmcHZZxoMkItiliIYee/8w5EqzTbEmmEZ8tomJ+qUrPCUnxiLMij5zJEV0LU+Av5zN+c0qBsKV2H35EdqF1SrAZI3Sxcj0LlCFWS8hk6dzmJvgP7nAZWudSmeKQNfLfM1o1Voa5ihRsGz3UJkvaQGXOgJy0oCLJJU7I1o2Oc0dQEsU1aAHDdmKEx24+8nUFMzXkqMAZDPWokJYbtnGpHNLT7xrv1DBTTuCgTdAi8QCdLcD8vPYsbJh/KmODxMkrHiTXcgloJYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kelfFKDop0PpNl47F+xPin6yc14dyK6qkvxJB7sy5hQ=;
 b=aFLM8OJTUdgyeW2jaLx2XxuGxHkrqI1qK9yAeUXPdQcgPD1Ng2wLI9dbZ3Xor/r0lnwrxLKKVBfbHR9fI+pC0B/fIVr7yHbHcEcWUEhwFcGd3VZO+t+rnNKbjfi6D9MJG4lvjx50ZIe9KnKvKGt0yORlbgzoJTeUJv6rmaYTLV/AnmKBW/RZG1ofwJ70B4QqVylluuZK410tZ+0A8Xaq78NHc1alJmIiSHPcSVopKwWrbwwi07yDU82V0m3g90BSDh7uD38ZpyRZhdzxaiQJoVjS8YqJXtWdAKs5nAYf5CGdi1XsBDxt8QdoIVMAJWUdhMnbOfhPZs/z7cZkOQCXNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kelfFKDop0PpNl47F+xPin6yc14dyK6qkvxJB7sy5hQ=;
 b=nL4YzCktOCaLxs1VUgYf15+qIVDNUQuozG39fc5VDGa1zmFYQ1m4/+l4u3xjw3Y9/Hk3Sthgb8X/3EK5EZW6oA5yKufqWjB7P5ehTYUF5favbb1Vxo9Y4YrRxCdBxXC/zRQ3IqG9Qo175smuVGl2hl2Kz+vk3Vc0MLcF0Aokrek=
Received: from CH0P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::16)
 by DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.34; Wed, 30 Apr 2025 23:17:51 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::4b) by CH0P220CA0024.outlook.office365.com
 (2603:10b6:610:ef::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Wed,
 30 Apr 2025 23:17:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 23:17:50 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 18:17:49 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <bp@alien8.de>, <thomas.lendacky@amd.com>, <hpa@zytor.com>
CC: <michael.roth@amd.com>, <nikunj@amd.com>, <seanjc@google.com>,
	<ardb@kernel.org>, <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kexec@lists.infradead.org>, <linux-coco@lists.linux.dev>
Subject: [PATCH v3] x86/sev: Fix making shared pages private during kdump
Date: Wed, 30 Apr 2025 23:17:38 +0000
Message-ID: <20250430231738.370328-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: aed5e39a-7c78-4849-7c08-08dd883d3a42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700013|7416014|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?upjaPhgbdvlkpuSXUT/eEk8KRZDjOw/KIrJ0fs/cf0rlUxgoJ1pC8DdH//WI?=
 =?us-ascii?Q?NoxZaJepyNXrS1Jdx7eF1Tuchbs/RaYLZBuJodZ3/DOSQX2W5R4ZzZaj54t4?=
 =?us-ascii?Q?vSItcKnewRN3+tYsJAIcX8pQdosBLRLLruEFT4SLtkpKjHrkayV/w7i95Ht9?=
 =?us-ascii?Q?sQVR1Wr2oEHkz7KHhfUODHrguNf4VZEGR2AKGXe5Wx0v/YvG+IO43tqrTJFn?=
 =?us-ascii?Q?OwF0s5M7D0SrIgYBchrTmOyn9403exiIBApWBTeEcvIx2PamiUmv7+sSsY8c?=
 =?us-ascii?Q?rW/8q9n9ufciyEY/DfaVJjq2bNpWX4X0YCxT//G0cLsPX+gj2a9IjVNOP5df?=
 =?us-ascii?Q?mKjd8FL7h+x10EIFN1IfIwvFCtqOEs7MDEQKNqsqjr18q0cYeoeGEI4pk9JU?=
 =?us-ascii?Q?8WMSY6CDWUkxmrL1N59lJGimAqenh3dURVtQHmbHCpFH4sDfdMs5lp3dEhoa?=
 =?us-ascii?Q?7OSwIKye1X0ss+5kY8kMUKETRAAun8M4sqqitzmMn+fRsWdjo5zibHB8vHN7?=
 =?us-ascii?Q?IdekjxYLWUfDdDIffFerp10YHeD6YTmKvt0LEZb4/nF/+mYwGOATdTafb/BK?=
 =?us-ascii?Q?88v9n1Rkg73Ra3kpEPDXHgA9M4fZFcxNZcc2qoVszYFwFEtAckqHYxMDkFS7?=
 =?us-ascii?Q?oMH9fdYg0cMfmcXPGK/TDObVKRZCFX58wDpK7cZVfZdM3s1dTytzvcvyB4O9?=
 =?us-ascii?Q?PK08DrJjDUszxuMM6y3RxuMlgHjVbPsTmHYiheffRebPRRqa7imU0Y8KmYMU?=
 =?us-ascii?Q?ZmPx/giHPaFDm0LvFWkJy2c9Oe/ZVlgNWJk7Z5Mqs7H2s69O6BmRlgx1J2uY?=
 =?us-ascii?Q?Afcw8xkSEQ/g8YgobIbAT/DVyKYJYusjDiHUwLiZWN5MLEAaBAoFcK1e9nU2?=
 =?us-ascii?Q?DVXQolFt5HADPlQbBc5QuLBdYmTywqTq6lAASgxcT/bu3yyJOOPqF0pVYAKT?=
 =?us-ascii?Q?NzT57z1fbVXkGbzNuymUPDgVD8lpIJn8+Zbnvh0JYjIEttDQYrAMxYSP/PkK?=
 =?us-ascii?Q?+7aIaX4egTrJbLGHDK46FCpxyTGQXvb5S3VrwKcwMFFLxg984Z/DUO2Wrdpl?=
 =?us-ascii?Q?XKr5jBprpHX3CfJWsuDfGSgQUPrKmB4vgGvZP9wsi6V/sL1O5xx+TwRFhrIp?=
 =?us-ascii?Q?5bZh1szjRjjs2tqCLHDaiW4zeG2RveIwsS4REofhEplBDlYkqu47uy/rNiXk?=
 =?us-ascii?Q?2dNQREjKbVwyN5S+Uuf9Bg3CxrNtymwJw/t7ySPRS5EYkDGJ58waDaVyUto+?=
 =?us-ascii?Q?0T9V6LnKh4DFfldTLfRKuAIC5t4CZvEQnJpwhZI3c9OM0q87t6wJ6rMZdsCp?=
 =?us-ascii?Q?9s+ccss5zqStMKlw+9a0ntTiEL1VCnijajM5FIADY5RfcD8jGqwTXeHx8dE2?=
 =?us-ascii?Q?Myl+ZT5Ov/67iIdwHVGnweEFBtEBSWzTnmCFPh1AF55oD1Eq9hm2NHMM239R?=
 =?us-ascii?Q?FQ9q9iWFH/Wo9V465gZWb6UpEJvVomqUq95RCz2fJP3AgS2pMAwxRc92h21z?=
 =?us-ascii?Q?mttXyTYcHGBH6fdNBG4qom8LTVBv6C7qlMUg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 23:17:50.7585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aed5e39a-7c78-4849-7c08-08dd883d3a42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_161805_808358_0B8C2867 
X-CRM114-Status: GOOD (  16.30  )
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

From: Ashish Kalra <ashish.kalra@amd.com>

When the shared pages are being made private during kdump preparation
there are additional checks to handle shared GHCB pages.

These additional checks include handling the case of GHCB page being
contained within a huge page.

While handling the case of GHCB page contained within a huge page
any shared page just below the GHCB page gets skipped from being
transitioned back to private during kdump preparation.

This subsequently causes a 0x404 #VC exception when this skipped
shared page is accessed later while dumping guest memory during
vmcore generation via kdump.

Split the initial check for skipping the GHCB page into the page
being skipped fully containing the GHCB and GHCB being contained 
within a huge page. Also ensure that the skipped huge page
containing the GHCB page is transitioned back to private later
when changing GHCBs to private at end of kdump preparation.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: stable@vger.kernel.org
Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/coco/sev/core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index d35fec7b164a..1f53383bd1fa 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1019,7 +1019,13 @@ static void unshare_all_memory(void)
 			data = per_cpu(runtime_data, cpu);
 			ghcb = (unsigned long)&data->ghcb_page;
 
-			if (addr <= ghcb && ghcb <= addr + size) {
+			/* Handle the case of a huge page containing the GHCB page */
+			if (level == PG_LEVEL_4K && addr == ghcb) {
+				skipped_addr = true;
+				break;
+			}
+			if (level > PG_LEVEL_4K && addr <= ghcb &&
+			    ghcb < addr + size) {
 				skipped_addr = true;
 				break;
 			}
@@ -1131,8 +1137,8 @@ static void shutdown_all_aps(void)
 void snp_kexec_finish(void)
 {
 	struct sev_es_runtime_data *data;
+	unsigned long size, mask;
 	unsigned int level, cpu;
-	unsigned long size;
 	struct ghcb *ghcb;
 	pte_t *pte;
 
@@ -1160,6 +1166,10 @@ void snp_kexec_finish(void)
 		ghcb = &data->ghcb_page;
 		pte = lookup_address((unsigned long)ghcb, &level);
 		size = page_level_size(level);
+		mask = page_level_mask(level);
+		/* Handle the case of a huge page containing the GHCB page */
+		if (level > PG_LEVEL_4K)
+			ghcb = (struct ghcb *)((unsigned long)ghcb & mask);
 		set_pte_enc(pte, level, (void *)ghcb);
 		snp_set_memory_private((unsigned long)ghcb, (size / PAGE_SIZE));
 	}
-- 
2.34.1



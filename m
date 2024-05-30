Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017DBC25B76
	for <kexec@archiver.kernel.org>; Thu, 30 May 2024 23:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vCzeowyUXeUM4wdOCssnu1cGyOvyg5fDRxAhk8AAnVw=; b=u5YWWhyhRGQ+8X
	I3HNDqXBu45R3n9bbS4mzZWoePXaO5EsqC0MMsAmCvfo6YBP+ynegeIWwM2oGDuNvSa4dsGJiuNs3
	mReSJ1d9h3g1Vr2xQ9mPBFHPI2Itqxewer0V6Cm2n9hp1an7S5a240Q0C9YBJ1WtoMHhrNxfzzJP0
	FXRFmx5Ps1ywwroTheAxTdFJN30c0BSaOCy/uqth4KWtfncm0wtE06B7iYs6Mg7sqrNwom10ru5E2
	2VsKLp+gTa4h8DeuHeQwHRkVGSTKh5l0PWgrlVRrYf3+Qj1n4RSD8mpIrwbsYsUQTt+NKE/teu8V0
	Hya+eox8JLt31glGdPtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCpL4-00000008hsT-2T3a;
	Thu, 30 May 2024 23:37:42 +0000
Received: from mail-bn7nam10on20600.outbound.protection.outlook.com ([2a01:111:f403:2009::600] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCpL1-00000008hqM-3mEz
	for kexec@lists.infradead.org;
	Thu, 30 May 2024 23:37:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXInuiGoP6VMpfyO2PVAWX5DGUfwU9/HBTMAbKtkDIQYgAxIUE09uFfxRo793EC3zPCafP4vtyYh0iq878mKwPDaex+98s14UVmVMsM3hw7TgOBOQmfmkt42X5XHfFsHk4jis5iQkqLwVDzvKvz+NBPbBjGX3/CyIWOKeLfHipk0/hRHWG/3wGZ7hjKtE546UV5x/J57o/us+vmSzBtU82TMWmdQ63T4Pb9qf51OVqY+LNbz9yqUnPWNpvpv7noA4AJVSEA/MEF4OYRkTDDEEKZtFyogM/8VW93MHSimGCzZpR4bHlEwrokgziJtkfnkc4Ip4CcOmRnG0bhB5pf6+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8In1wj4zpxqXng+/MvpIStRWhMMfirb2tsJpUKGbnWE=;
 b=nkcF3OmxsvsV6Ks+jVLP5n/LsYEgTvxgabQj+DNofBKHVGN8W0yr5sqKur/S4QXQ4TaWpq/8cdocGt9FSxOekFK+v3glQSQv18K8b+RieApkyYp1xCTPT4EXQQ5t0L5OeaPQgWZorTQQiAmxsanQ8ofS72TWYy23Cx8qAQTCdDyfog1ypeZtIW7CPxQksGs4C/hl8Rt+w2SZg2C2gG53Uh1QyuLhawQvSllnpy3Z9t5e6DiL5so7meBqipHHoa2k9ow4YZFnXihuibRIFYkEmMGghlGTuDiIIVCeIdW/7BJtijSpuT2E3UHqfzcWqpUIsJbMf0FOUBlKHlRIDK+jEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8In1wj4zpxqXng+/MvpIStRWhMMfirb2tsJpUKGbnWE=;
 b=J66/BjmUJ6tSH+6Tr4Iyob7Kf1gMHsh9rMEYnxSQfwa+SQo1zXnoiw5x3b5+gEaGPgxIfxbH/ueLzuDgL5vvTgsgeEEoFGhexSgaFyQE4Gao8N/X0VZxrAPVPu35XAmiQoHL5Sv0zdn4HeZ8gDe7g2ESieMmNbmIhp3Bf6ezh5U=
Received: from BL0PR0102CA0005.prod.exchangelabs.com (2603:10b6:207:18::18) by
 LV3PR12MB9332.namprd12.prod.outlook.com (2603:10b6:408:20f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.38; Thu, 30 May
 2024 23:37:27 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::65) by BL0PR0102CA0005.outlook.office365.com
 (2603:10b6:207:18::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Thu, 30 May 2024 23:37:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 23:37:27 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 18:37:26 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: <rafael@kernel.org>, <hpa@zytor.com>, <peterz@infradead.org>,
	<adrian.hunter@intel.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<jun.nakajima@intel.com>, <rick.p.edgecombe@intel.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <seanjc@google.com>,
	<kai.huang@intel.com>, <bhe@redhat.com>, <kirill.shutemov@linux.intel.com>,
	<bdas@redhat.com>, <vkuznets@redhat.com>, <dionnaglaze@google.com>,
	<anisinha@redhat.com>, <jroedel@suse.de>, <ardb@kernel.org>,
	<kexec@lists.infradead.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v7 2/3] x86/boot/compressed: Skip Video Memory access in Decompressor for SEV-ES/SNP.
Date: Thu, 30 May 2024 23:37:14 +0000
Message-ID: <75a313a44bfaf3f97027393665d625be2f881e66.1717111180.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1717111180.git.ashish.kalra@amd.com>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com> <cover.1717111180.git.ashish.kalra@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|LV3PR12MB9332:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a7a83fc-105f-447c-6044-08dc81017770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AUdZ1Xezcu9v+OEx3/vAii+JZUNuDZie1z3cy5dEAGSwQl1Pndm3hS3N+feo?=
 =?us-ascii?Q?3mMe3NUshV14nAILOVKLHCD8J/BCzohWiNPqy/rwznSflBPhXJnbigB59ACM?=
 =?us-ascii?Q?j7r0mydfiQawQnLzdRM7aL0HTQXF1OqqVtl26CukDR05noHi2lJ2RpvU2LMf?=
 =?us-ascii?Q?/Nzm9VTxcxMe3ggHCk/0qY6lPalHaOwGMkpkrltsR2YAry+1ZJh671aT0+zJ?=
 =?us-ascii?Q?cnpEWfQxygHA+yNZKCbtogkiC59Mlmd2mn6B68XRciIgp6d+iGx+7miLBzXu?=
 =?us-ascii?Q?1jyR3k+f8hsKP2H0PAFYZP3RirMzvDWtQlPEmwkuakxC3gP9stI0fmVlWZBP?=
 =?us-ascii?Q?iVgcxj5hfNj8M3z+ggdnaxQqF1BvRytw1EkSdNjevVDeg0L102sfPX+VHSDN?=
 =?us-ascii?Q?FhUpf2qJQWuDcr1shZlN4J38KXex1Q7DxSpp/ZlLOGh1ogQMBbiMkxAxi3JL?=
 =?us-ascii?Q?L+z2SHlnBxH0D7w+4h4GKvlQiS1tVRd+nYsx7YTdYHSJ3dU1aoDi+3iFSskH?=
 =?us-ascii?Q?H+7kOmVTL1JX3RaPNYm5B7zNsuc4pjtk/OhRRs5eADgbDTKRPRbsLbayM6iy?=
 =?us-ascii?Q?hzyBh6RlRCZfqykc4wb8S3YGv6do1R0n6yvt/WJQ+ctGmKl7laZssXVKYPYS?=
 =?us-ascii?Q?WjSaKyfliT1DAucCuajNA5VKbXFq+68ypSadCbwvxsTM4hoJL3QeGOpwm/g8?=
 =?us-ascii?Q?6uxzoJCQj2I2g+3XHI2a6ECq3XgOMIl+uoC9Xy0JCxFrwiT/+5BxNwS1s73I?=
 =?us-ascii?Q?1fL3tqxFjtea8cy7RyqFBBwXHG+6kIO7RtKPeerT7OhI3vcy8XJmRFSPsYsD?=
 =?us-ascii?Q?1Ye8qYoGpI8DPTjZ1Caj6dXjR/kxY6PZp5wuY7MTEBjLFp8VHKzmwcwgh5eq?=
 =?us-ascii?Q?RNcSxzoYObbj9CXl1iag9GkF+4sC0jcF2Xq1EW6fVOcAHZs+z5yxY671Sxw3?=
 =?us-ascii?Q?vSVCk0cCN+UBt9QbV4Dblnc9fWBYMFf18svpRzmXrCt3LJrNANieDzMAgfAZ?=
 =?us-ascii?Q?DQQa/41fSX5/l/OcHmhV+AOx358du3E+S6A2u5O97cT+0wFSAw9Uw5wakDgh?=
 =?us-ascii?Q?Bsebh+NEbLlxVGlAlSy2azLnynZnsS1KuiqkNP46kYTvdrq6PrMR7B4TuQZu?=
 =?us-ascii?Q?DE/wDmFYesgKA5IHj8K/UWJDXvFw/5737iA9MUfzkayHH005iZQ11jNDedgt?=
 =?us-ascii?Q?2aEfJBs2V/8k7Qqt9oTKVcWUGHYoNDsQsKwJY4i2nYjbGaAEER1luD6NvIx5?=
 =?us-ascii?Q?vV6W23prP4PW8PtsqqMtGrl1YzWSOENlSAVoZk5qrQd2mLJvQvIr3MYDabry?=
 =?us-ascii?Q?NWAemVnH6uYRALavghh4h4Ht8OShF1f1QuwfEFBAu3UMy+DoNlgKdObki08r?=
 =?us-ascii?Q?eGqlBZwOfC+7IZP7IuKwEd+SNTGX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 23:37:27.8102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7a83fc-105f-447c-6044-08dc81017770
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9332
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_163739_963986_3F817709 
X-CRM114-Status: GOOD (  12.51  )
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

Accessing guest video memory/RAM during kernel decompressor
causes guest termination as boot stage2 #VC handler for
SEV-ES/SNP systems does not support MMIO handling.

This issue is observed with SEV-ES/SNP guest kexec as
kexec -c adds screen_info to the boot parameters
passed to the kexec kernel, which causes console output to
be dumped to both video and serial.

As the decompressor output gets cleared really fast, it is
preferable to get the console output only on serial, hence,
skip accessing video RAM during decompressor stage to
prevent guest termination.

Serial console output during decompressor stage works as
boot stage2 #VC handler already supports handling port I/O.

Suggested-by: Thomas Lendacy <thomas.lendacky@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/boot/compressed/misc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index b70e4a21c15f..3b9f96b3dbcc 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -427,8 +427,10 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 		vidport = 0x3d4;
 	}
 
-	lines = boot_params_ptr->screen_info.orig_video_lines;
-	cols = boot_params_ptr->screen_info.orig_video_cols;
+	if (!(sev_status & MSR_AMD64_SEV_ES_ENABLED)) {
+		lines = boot_params_ptr->screen_info.orig_video_lines;
+		cols = boot_params_ptr->screen_info.orig_video_cols;
+	}
 
 	init_default_io_ops();
 
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

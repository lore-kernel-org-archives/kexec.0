Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E623BC3DA64
	for <kexec@archiver.kernel.org>; Thu,  1 Aug 2024 19:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=07iTsFwufDw3BFZNZ7Xi1OpsyK9CQC9ePG1N0EgQCt8=; b=2ezqYkJ2lIBshQ
	swAZsPmZH1PQVUboEh+N3EpACdtYVIdB/nYoHIDjfsGwpmkuK26dtWjF8yRSRBivXxBtgQpEGmSCX
	DFphXIiOo1Rdg/4r7lix9WBNmW/nUnayOS0M03mVf8sopqvT9yyQMuR2rIakMry2DvQfnUnV27Chj
	ERs85XxY4zmu5CVhajb13/1SrmctZq0QStxvL2xuS38Zog+mvK1yMAPVV6vYlYf1oYAZN23huDuj+
	eGgu0wiBPeWOxqP0rF/brOI6249K/A8xFg4ioMk4tAj9FAc5nUjB1Af5vyYHATAqhf87zKYxCzZKk
	uJL1LlPiao+kx9zJNJjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZbG7-00000006VO5-1Gtx;
	Thu, 01 Aug 2024 19:14:43 +0000
Received: from mail-co1nam11on20600.outbound.protection.outlook.com ([2a01:111:f403:2416::600] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZbG5-00000006VMF-1EKy
	for kexec@lists.infradead.org;
	Thu, 01 Aug 2024 19:14:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNqZpPrrPCBBEtyN+pyAGQ0eB8OWfWnhjVgIrQcKGeMFXq3jAyetCfQymN6UYI9yMMAocE9GkiU11GuofcEiHoBd3SD3IaiPkJx5yiFm9Wl18Lyi3y6oEsq/Xjn5lLsWt7ppTul9rQdyUoKMSsDsnvG1zSxBGfRIzV8ssM5dlTMlWCmExFVFBRL5KLToioYSmYrDrNNAt84mKlRhZVPo6WE9QSQXXP10Rl7aoubhC8dBea4iTpD60I2Nn2XTZe7nWoDIn9dv95u1k/q2FYwoM0cJRSKy7AvmlOjW6aec5xWOFqMQwU7xeO8i6Hg6LuN0hwjuWEv7KFCQUJEDbxDPyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAW6P1BTBJSfNIUvVl8FqTOvvJPB1XAot5xkWOzWcuA=;
 b=bYVAXrtjeGMpPHxLAE/9XeV8BxoImXElvSJpZnsaZVmzrj3+V4ssuskYcYTjqHtfCJWxgmGkvIRM26DtfZWxGhcNHVInSqJwF4BGx82zO1rWIoTYDL4uGGdWASI0J8fbVHot1Al8Uzjq40lZ9V2hqexvTWRyWU2Ra9UwjD+ymXRa/cFB0szPa765ac7ELq2ev+2dpWTb4flh/wY8Ar+IkIK5bSKXLSiqnZ5Q2uo+J7I7C9HizYajsPHdj3c7GHaKOYSzVJxU7izAdgBgMTl/ZJwQLqkl7fBzHxPefe/fbyQhtnlVTlMJWyOcYRtzItoosoyFuRZ9/y2RuWiIthqExg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAW6P1BTBJSfNIUvVl8FqTOvvJPB1XAot5xkWOzWcuA=;
 b=DbhSVUAA5iZVPExsbW9GCZ/b3k5wqZ49zcOycJOQhev86axozgNpeCWzqRuf8sSYGJN3rgpigQWGMW1X/2Y4mmmRsyNCoNScZPPNlVOYXbiNMMVX42DsNGfwv0ZBNEtSdW63gv6BqzgPhHTPp7GvBI8lXKJEXLSrUeysdkEUK1Q=
Received: from PH8PR07CA0022.namprd07.prod.outlook.com (2603:10b6:510:2cd::21)
 by SA1PR12MB8742.namprd12.prod.outlook.com (2603:10b6:806:373::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 19:14:29 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:510:2cd:cafe::d7) by PH8PR07CA0022.outlook.office365.com
 (2603:10b6:510:2cd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.32 via Frontend
 Transport; Thu, 1 Aug 2024 19:14:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 19:14:28 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 14:14:27 -0500
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
Subject: [PATCH v13 1/3] x86/boot: Skip video memory access in the decompressor for SEV-ES/SNP
Date: Thu, 1 Aug 2024 19:14:17 +0000
Message-ID: <8a55ea86524c686e575d273311acbe57ce8cee23.1722520012.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722520012.git.ashish.kalra@amd.com>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com> <cover.1722520012.git.ashish.kalra@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|SA1PR12MB8742:EE_
X-MS-Office365-Filtering-Correlation-Id: ea02eb2f-4ce4-4f09-63e1-08dcb25e2a89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D8mwtMPTj1EnLMMRYv5Or3ZBVbrkTl7/oYo4Aqg7ddFSls+9U7l3dnTlSRhJ?=
 =?us-ascii?Q?hdTZAaqWf5mIKYWdSVYyZA8P+ulArBHopjP7eKFSj1atJwguowGlyQ8ySlqv?=
 =?us-ascii?Q?hiQE9soFQWyhDr+mFY5IEVT1FppxzI1yJHCCVXoP8xrqTggcwJUo3BChCxED?=
 =?us-ascii?Q?HFfDtvbdNf5IEClAuInCSDfKcRb04ZmUYPUz8YEx5YmCMcjcXgGVsdXqnsqi?=
 =?us-ascii?Q?IoyVZetsNhtEHYEnd3RLzHMergU6xkQtxLlZgQQg+dkhZTOEOA6DVYAKbJ7Z?=
 =?us-ascii?Q?63p60IoBiabMzoNoIYvTWne6zzkF1guVmfxjoLVG7KuXFnUwOHARL4qmRdVV?=
 =?us-ascii?Q?n56NkoqGYH93lCgysLAiaiPzvdCrqtYsFJxd5N65Knsw4/6UfjhXMcJMbi7+?=
 =?us-ascii?Q?YDF77EzfAfJfe4o7GwExXGdFy6oIxPxD6WXc2CghleXWVvArBwHf4OEgciTY?=
 =?us-ascii?Q?dYkQh0vJWvySkuIWCAVB+DZUWVyGgP+iZjHir5962M6x2O53JKAj6WFNTC82?=
 =?us-ascii?Q?dKs0Dh80n0i+ov2EKJeFd/m8DfFWkSbGbJDy8PFIdlsE82Tv4GqvEWpENTM5?=
 =?us-ascii?Q?Z7W0AymOGY4H6my//zxDwJWaSQT/XXL10du6xetpWaCHjFFAanZ1yxzl60Y6?=
 =?us-ascii?Q?9qxQCdD3LU6ZL2lv+QG1gBYtXIcneKRq9X1dgJb9Y+EK9jQRuv7pvNsUZDRG?=
 =?us-ascii?Q?N3nzdsKxg72W75r31ctuTcXZWgRC32DFBd0eYwkKnjjijhClx8s3t7OrjJm5?=
 =?us-ascii?Q?NMZb/BKdSnTD7Si9vIeQcXRLF8ArqiaLgVMVtXCFTapa9MszdM/kmLKEAVaC?=
 =?us-ascii?Q?gB1qR0gGpkPGGdyFOXJyBjhxleb/LXOJ2A+Y2pdABkV/vqbQnTuWyq0d6me2?=
 =?us-ascii?Q?TuYUGkY+gajxTNg6fPj/zAkjzgjJh9jXQs2Vcb22iE+oJJfIb4oJiCHDX1fl?=
 =?us-ascii?Q?7UsZdm+PP6/Sh5F+bcf/jPNFJ3eXYphatjYbtRTwSdHal3cG+ISssmEf0WPr?=
 =?us-ascii?Q?/S4ln9Q6i8qWP93TLVw6ffCyOg++JFzZHPucNquQcqFe3fm5BuHLWdaaMJ0b?=
 =?us-ascii?Q?qzfYRDOyO6DpFBNlTRhy7TixFDwLnGnvEhZIBz+5sChFueYZgTPxvShanamx?=
 =?us-ascii?Q?B6kn+D+PYIySrqw3bWfd/HBsrIESgByTbR70FO59YvyIGqNfLYVM1esXGq18?=
 =?us-ascii?Q?cMqWKP9zDQYaK/YRMv6UK8oLdntqo8hkRZDryHCDUkQX/n4gg3Z0bzUxwPAX?=
 =?us-ascii?Q?2zs+agyeF0ruZrXntAvK6tPyJy8sizon3CBUnLZ4wBZqNOHSUwvvrNXzhDd2?=
 =?us-ascii?Q?5fdXoRse6T9nWn14HVH9Xh+Ls6Qt3IoSdPfl4HwJ7nWDRFojrmCc7WERSZA5?=
 =?us-ascii?Q?GsQIyPn6eiAgZ17Q0UqM8n9BR+tRZkinbMuDA7ryjE7A1zaKNues20Hq+Fwy?=
 =?us-ascii?Q?P2kvOC6AnnXfoaybt4XQB1oaSHcYCBNR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 19:14:28.8991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea02eb2f-4ce4-4f09-63e1-08dcb25e2a89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8742
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240801_121441_473634_6FDD3D7A 
X-CRM114-Status: GOOD (  14.20  )
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

Accessing guest video memory/RAM in the decompressor causes guest
termination as the boot stage2 #VC handler for SEV-ES/SNP systems does
not support MMIO handling.

This issue is observed during a SEV-ES/SNP guest kexec as kexec -c adds
screen_info to the boot parameters passed to the second kernel, which
causes console output to be dumped to both video and serial.

As the decompressor output gets cleared really fast, it is preferable to
get the console output only on serial, hence, skip accessing the video
RAM during decompressor stage to prevent guest termination.

Serial console output during decompressor stage works as boot stage2 #VC
handler already supports handling port I/O.

  [ bp: Massage. ]

Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
Suggested-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/boot/compressed/misc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 944454306ef4..826b4d5cb1f0 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -385,6 +385,19 @@ static void parse_mem_encrypt(struct setup_header *hdr)
 		hdr->xloadflags |= XLF_MEM_ENCRYPTION;
 }
 
+static void early_sev_detect(void)
+{
+	/*
+	 * Accessing video memory causes guest termination because
+	 * the boot stage2 #VC handler of SEV-ES/SNP guests does not
+	 * support MMIO handling and kexec -c adds screen_info to the
+	 * boot parameters passed to the kexec kernel, which causes
+	 * console output to be dumped to both video and serial.
+	 */
+	if (sev_status & MSR_AMD64_SEV_ES_ENABLED)
+		lines = cols = 0;
+}
+
 /*
  * The compressed kernel image (ZO), has been moved so that its position
  * is against the end of the buffer used to hold the uncompressed kernel
@@ -440,6 +453,8 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 	 */
 	early_tdx_detect();
 
+	early_sev_detect();
+
 	console_init();
 
 	/*
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

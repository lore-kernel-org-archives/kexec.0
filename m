Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2540C3DA49
	for <kexec@archiver.kernel.org>; Tue, 30 Jul 2024 19:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=07iTsFwufDw3BFZNZ7Xi1OpsyK9CQC9ePG1N0EgQCt8=; b=LgERA38i6+KQ9V
	s+Y0xIIvjuWwFF5i6tTHupr+z3hNkS2EX/QCGHC3v27hPZs5KUB0fwL1Il4+9e945PFdbkmyi/G4C
	DSEee88Ft4bLHHaASq3FPO0hOpcxl6WM1Z9CNTfz5qbdmZkytTi3DodUuyqXY78ov+pEAmrTGlysu
	CZUcZefG+XukwYoWt5madoQ3FxUPxP8xalfo6EZ2ywAoYPxbpJCnJzW20iWBPB16FuLgP1t49VQGs
	vAYJn6wF+ZL1XAY1zKr1o/suFzAXxRHTcEsN/nxHP4fKoQoDvxG4bTmieGlyima5G00pHh6wzXl5a
	nItUVrY6sz7QH5jHgAbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYsPq-0000000GG7H-1rIW;
	Tue, 30 Jul 2024 19:21:46 +0000
Received: from mail-dm6nam12on20601.outbound.protection.outlook.com ([2a01:111:f403:2417::601] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYsPo-0000000GG6R-1RrZ
	for kexec@lists.infradead.org;
	Tue, 30 Jul 2024 19:21:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIecIjZF3Pzvtk0bleucNm6aKHvmPcPQ9Bfd6CQ1/t/Yl+oFxQsLpboQa40xPv4sY4R/QaNF6YaLmG60cTHQn5D7BXtyoj/QZlXpCbRW8f3dLIo8DY0bg3n0GX56HDmzd65JkJZ7n9RR7LelhEjY6r4fNA/YM+3eFjTdKzGr59rjMv8lvasIxp8LSuoOB9pgRonX2E21lw+qL5ry/54rU/FQdAJaDTX2A6xGPRXtsqYu3fl/eKkdg18uHvWXTCddQUXdvl9qvFJjyzdNBs0UZ5Z4KZGUtE0vfux4zQQ23g5ZywjEE0tcZ7NX64qG2JBEiUx3zvkdr/eAlV2AdmCyUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAW6P1BTBJSfNIUvVl8FqTOvvJPB1XAot5xkWOzWcuA=;
 b=WCcopJ0RJfIJyjHv6oTwZmUMn+EGEuQOK6hpqXeFZKrYD9zbY6ianWHKmOIfa7ekcONIFpA8vhE6KkR/3R0yB0kq/s53tj305PROFtlB6EO/fg73ZgzzDB8EZKQKlNd7alziYPPnflsDoKtle5SNr+bWpv4BUNk6EaEUg6fpMDDwKg0n7fTyFR80nRRsTN2hKAvq/k5nyd8hHCh6D4mT7LGOxC8YNhQa+kt3IavScdrOTsVhvadyNijhvE+SA6YLbthsJljBfk2bjsUJwLOgIwKq+1TAG2CYRyxwmpL8c7/hC/mK0iVZgjAtGOxflgOPSIjNJ/wSxAuUXlqGuvljkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAW6P1BTBJSfNIUvVl8FqTOvvJPB1XAot5xkWOzWcuA=;
 b=0Lr5uLBBL0uQ5ihtcueWpMj+Hg48RFdQdb+kiJN+LS3D979V/lc55aoExgg+z8bGKFhwqDTTxpX27jfFJAPAjww3GDaD9/37PW9k+46zEwUq2EVE4UDKcukqC5f3Q2vRiAwo+8rqN9eHDvfn1XxnYR1wW5fbP+bRF5PMyAq3zQc=
Received: from BN1PR10CA0026.namprd10.prod.outlook.com (2603:10b6:408:e0::31)
 by DM6PR12MB4233.namprd12.prod.outlook.com (2603:10b6:5:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Tue, 30 Jul
 2024 19:21:39 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:e0:cafe::9f) by BN1PR10CA0026.outlook.office365.com
 (2603:10b6:408:e0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 19:21:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 19:21:37 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 14:21:31 -0500
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
Subject: [PATCH v12 1/3] x86/boot: Skip video memory access in the decompressor for SEV-ES/SNP
Date: Tue, 30 Jul 2024 19:21:22 +0000
Message-ID: <cce6dc40e78996fbd4814690a05a21babc761125.1722366144.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722366144.git.ashish.kalra@amd.com>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com> <cover.1722366144.git.ashish.kalra@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|DM6PR12MB4233:EE_
X-MS-Office365-Filtering-Correlation-Id: f913a7b2-3274-488a-a7e7-08dcb0ccd55f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GXvsiPJGeS23HD+wrg33C1I060edwWhbKXsuS33AYO0+qxZZYhZHqkFG23q0?=
 =?us-ascii?Q?5hH5nVwoaCjaPZIpbBxF2Uk7Y8BlfrprpONT0ivhVccYWeZKaDc0EaOETYPL?=
 =?us-ascii?Q?y/16gBppAyCKLobvA3huPliBtKCHZOwK0NnL5SsUYu3KafJhFk5gTwYPcms5?=
 =?us-ascii?Q?SySp106qG3K+96HWLmhpnI4ecCrVHrzLAqBlwpBXnM5qUbbibRZMoYQRgAPQ?=
 =?us-ascii?Q?weUCa6raICsuiwhbGmJToiifyy6iMJKhEfD9JwJBxVlLciBovkgm7cQN2FfX?=
 =?us-ascii?Q?f2A8Eqq6D58pIITa4M5D1M0C+P38CxUtwQc2qDxo6sV4RmQRUY8G2mb1UcWz?=
 =?us-ascii?Q?MA58/kPvnwVrGZbtUQG3NKkQ/jf34PNgvDDcDaDrd5oZioL6A4Nvf2poEQyz?=
 =?us-ascii?Q?rHwgeRueSDwyf5zCCheq0r9OuUKG9ouWq+sDI5Mz0nPFOzf/rOxzIfQ06cl6?=
 =?us-ascii?Q?RHPR5D2eVIqcL7W+tdH4aWgFhuRW2sk9Oa5hlGte/u01lBVQjupYMw12kxrl?=
 =?us-ascii?Q?gLB+TZ40n30Xhch9HmwIvDbk94ViAImMkMT/hjMBtYT+NTQk8g2g0ddEbPT1?=
 =?us-ascii?Q?PokUGSc/jG6wyd2bZMNvcSaeHRljarRvtzBzvneT19cYf/zBMlfo3WBMljcV?=
 =?us-ascii?Q?ONepSK41trjmEY2b+lQpc8gzTropnWbPK9F2c8uGP6bX2YKwrUpGMeQh8Bqb?=
 =?us-ascii?Q?aIHwlW0zZWyN+tLp8uaWIx/MNsKgWjg9tVwCTP2zrq1wWMZeR+S+3wjnvYeR?=
 =?us-ascii?Q?RBKid4oaupatcC1qYBeXbPf0U89jCVmHetNMA5cq3P58oRwPcHAYb/kDTNTP?=
 =?us-ascii?Q?b9gNciqSqLKVnTh3C2XKwJaiQD13AQguT1Zc76nc/0C4QfvMX9Kt/5ArfBNZ?=
 =?us-ascii?Q?csD4jTRmAgstKenzZVFK1O61qWRJ5bde8dXSJDGbSTu1+yXKoI8oOLYQipIV?=
 =?us-ascii?Q?KRP+YgCbKAi3aL2nLQqCyOai0hVc9P05TjkIyG3SnJuhsg4ICWDcCTfM8S8o?=
 =?us-ascii?Q?/IpzviYhJi+WkI/4pX49L4gNoKXLnclHGmcflTvhqu8VvL+jd7aC0Bq8T/O0?=
 =?us-ascii?Q?2/OmGOwDBo4KIUabk3W7QS2X/TrBIhTupkffySihJVCt8ylWggcUVB1qi/7N?=
 =?us-ascii?Q?8jm0eIT2XkcXY7u29TvJJ5XlvTX9TqmK11ibUnHCNSH2vgEkcb32PlLbeNQO?=
 =?us-ascii?Q?kZrXUVhbHo9G++ydExWC6yVdsm5Fx0o+YtSdQkI3Jkkn8TTVRjnfH4DO2MYS?=
 =?us-ascii?Q?s/uD/yhr/rPlSHfMLC4XA5t1Lb0dXhRW79Vt7PuZp3/8qNu4m0Co/mVPm1IS?=
 =?us-ascii?Q?1k1rv4cYfBayruVuNGocFwBlK7BRRrUkugGTO6k9psByx5p3CmKLabH933si?=
 =?us-ascii?Q?GjQXRf2A80ZV9k9b/HhkxPsTTJ4UkvtuHiY5kEX0sQvKKdIGgc6QGSloRinf?=
 =?us-ascii?Q?Z7nESksT/ozNwndmJK32/QGfa4GgPowP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 19:21:37.8775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f913a7b2-3274-488a-a7e7-08dcb0ccd55f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240730_122144_415840_20EC1F21 
X-CRM114-Status: GOOD (  13.73  )
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

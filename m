Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD14C48BF8
	for <kexec@archiver.kernel.org>; Tue, 20 Feb 2024 01:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fxjzNVdaZEiJi14VU7t08esyBRTS6V1zrLhuyjcaAxg=; b=C2PG0vcl5cNLfH
	s+weFr6gwwm9smpCzDiDC0yIve3BQYCpH33pWvGPAL0ML59jLerR8Aftb9hOv7+hs+S/IuDnzf6Q0
	/CWlg3CdnI/J+/TrrvjczRkghab1r9uPhyrF97Ecc6CsO9ZQxCtT2ZwDuV3c745apKsXuO1e+gYor
	95wlyY6vnhSliBFWzh3y0D0KblLtG7LzJE3rrmj3aoP2nt80J972BGVNu4E70j1wOpC0fooe4uHbV
	O3NxMqdSdcIs0r3Ey05bvyUmOxPD8kT7415ETQWDvesrMrrM1aMdpdJHwSLuuJa5jSCETMXfcfcQL
	mLrk+7c3Gf7GgWmSqgFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcEmg-0000000CjAM-0WD5;
	Tue, 20 Feb 2024 01:18:58 +0000
Received: from mail-dm6nam12on20600.outbound.protection.outlook.com ([2a01:111:f403:2417::600] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcEmd-0000000Cj9N-0vnX
	for kexec@lists.infradead.org;
	Tue, 20 Feb 2024 01:18:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TagMC2oVxinYpBDriv3Rs7kM5jXVhhHWsP2AZATQvBrVUIUiK3oM08/K20VdOpKvJlDmGHuRSeIQxGJSYR0+85WH8+j5ztxRO/X+1nTvwPMMODFsgum9ZV5kzAnk40e3H2STYPXwX1Qgrt5KX8zFKjDFtrJtZBidgCI9YojC+qjN34WbfzOJue1Y9UcAiPDOhysdDEXKFzpEl0SrYkwuZfr9B2TBMkZKQf6A5RBRRkGWiASaKk6GQ5jTXEHCmzyt/RB4YqO/CYzarhkyWIsrOYTAYNTd1rRRLqTQSPmBF0uzQ+ViInuShzZFypuQWeQHC8qucu2nxv+1F3bKroHP2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoZDrwnDUW5jtawmOFj0tbKMZ0eAN7JvbDqwdqAfZqk=;
 b=QUClg1cnM29HWujYzcf4m+sVlVP7gbVTJuT7v4pZ3G1+OKL/V2pnE1vitNZv61eRiCE6vZNqD4dJUHeRT5JPxwG6eyUJbmfJEeZVagLc5s2vyG+1nqZNhOlZa1U/50AHQ+ZccpM6lWxcPMAal+dFRR3F5fIAJAZU467KKHcoDMDontZv3+HcLj9qnmw4pzxJ9I/TLu2hyFTV7ubB8V+21S8UDGIAzksphRSt0kzKQzVLH1eeKf4ZW7CE9wchCAGBY78CWGfxFBjqWgeQzrXgP9hELyAE+SlrKssrcNM4kLNjlRvTv6jm/guSam0Sofn6baphotjh+n5F/+gxTNCL2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoZDrwnDUW5jtawmOFj0tbKMZ0eAN7JvbDqwdqAfZqk=;
 b=R6TqtmIbHOYviINMut6IwItbtkR0kOMB3uqruogJT3xCw36voHOpnKe9IGSoCnMyZkwJ0LIZkl8Zh/v2z7EVyeY0uKRHWAFrTQohrg/ZKqOnmWjfLFG4PBaDLKHQTR8CC6jGwmIRuCTXLIb8aRyhfSkGeY9EAlp8IJ+ur0SqeS4=
Received: from MW4PR04CA0240.namprd04.prod.outlook.com (2603:10b6:303:87::35)
 by DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Tue, 20 Feb
 2024 01:18:43 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:87:cafe::86) by MW4PR04CA0240.outlook.office365.com
 (2603:10b6:303:87::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Tue, 20 Feb 2024 01:18:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7339.0 via Frontend Transport; Tue, 20 Feb 2024 01:18:43 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 19:18:41 -0600
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <luto@kernel.org>, <x86@kernel.org>
CC: <ardb@kernel.org>, <hpa@zytor.com>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <rafael@kernel.org>, <peterz@infradead.org>,
	<adrian.hunter@intel.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<elena.reshetova@intel.com>, <jun.nakajima@intel.com>,
	<rick.p.edgecombe@intel.com>, <thomas.lendacky@amd.com>, <seanjc@google.com>,
	<kai.huang@intel.com>, <bhe@redhat.com>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <kirill.shutemov@linux.intel.com>,
	<anisinha@redhat.com>, <michael.roth@amd.com>, <bdas@redhat.com>,
	<vkuznets@redhat.com>, <dionnaglaze@google.com>, <jroedel@suse.de>,
	<ashwin.kamat@broadcom.com>
Subject: [PATCH 1/2] x86/mm: Do not zap PMD entry mapping unaccepted memory table during kdump.
Date: Tue, 20 Feb 2024 01:18:29 +0000
Message-ID: <a0bf771e1472eb1a6a241acd2e16c98ab8ac9253.1708390906.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1708390906.git.ashish.kalra@amd.com>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com> <cover.1708390906.git.ashish.kalra@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|DM6PR12MB4106:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a8e54e-1055-4a18-4aad-08dc31b1e0f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xlAvNBQoY0bSnx8aPKaBrserGAkVoQtjmS5wHlNy0PZ++nvcAtgWbIRiNx4EyPBa0hBhRo4Qo3cdu7nTu55eb1xcJs22s0PkJJzfEyeKMw0JaD597YBNFTo9PwNp3pqcUe2rtF66sJrfyo1TOQYfMkJCHRwlyOosZIpMw5e5xwekR1KzsvDTdHxxL0+MgyXQ/MLjDS1C+dajxNd0wQk2f08JGR7iOWjEUaeTK+qww4ia29TBglllS5BlHFGNef3Q5zFOoOWiSOuMrBHlo+5+SEaDrjSlR5P3Pkhmoq92XlW9hPf+jJeWXW/qD15VFEmDvk/eyiHbKlSBVzrfvleo+wlHwHjfRJslNjU30j5pyIN0oEsC0TBBffTFdVMxmp3RTn9fhGY5uetUfrrTxUJwds2k/ZiRPd7ZOCSRjN9sLnaj8xNtYTwJyjJbWrbAAo4kjjB+taZxGLxsCTWJVZ9RwyasxDnedTPNq73Qv4y/mfj/B879h0HMxjOZQZHdQiE8Pob9g2Qxu/k5O7StlyQN3vgbm0GaM6j4R+49WXCOhJHvHgHHxgMv3VHR49gbo9mNXaGF+kOTpUuxnAsy+SGvirFlMVPtTbClVerxIkOSgDqdzACyLTTjbmO1XlsNu6zdjlVDLFBuNbFb8BBY+FpawMoMGVNebRnSofZFtg4dtj8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 01:18:43.0996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a8e54e-1055-4a18-4aad-08dc31b1e0f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240219_171855_268989_1F0E99E8 
X-CRM114-Status: GOOD (  11.35  )
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

During crashkernel boot only pre-allocated crash memory is presented as
E820_TYPE_RAM. This can cause PMD entry mapping unaccepted memory table
to be zapped during phys_pmd_init() as SNP/TDX guest use E820_TYPE_ACPI
to store the unaccepted memory table and pass it between the kernels on
kexec/kdump.

E820_TYPE_ACPI covers not only ACPI data, but also EFI tables and might
be required by kernel to function properly.

The problem was discovered during debugging kdump for SNP guest. The
unaccepted memory table stored with E820_TYPE_ACPI and passed between
the kernels on kdump was getting zapped as the PMD entry mapping this
is above the E820_TYPE_RAM range for the reserved crashkernel memory.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/mm/init_64.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index a0dffaca6d2b..207c6dddde0c 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -524,7 +524,9 @@ phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
 			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
 					     E820_TYPE_RAM) &&
 			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
-					     E820_TYPE_RESERVED_KERN))
+					     E820_TYPE_RESERVED_KERN) &&
+			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
+					     E820_TYPE_ACPI))
 				set_pmd_init(pmd, __pmd(0), init);
 			continue;
 		}
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

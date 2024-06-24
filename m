Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E8AC2BD09
	for <kexec@archiver.kernel.org>; Mon, 24 Jun 2024 18:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8P1vTOvvdLOvgPTbj2KHLyMsiS5WHVzRjETpkyS4KE0=; b=etJxn2mKrAHs9O
	9tRti+InUGnX3Tpd0wqwx/K3z4cuX7bylTRx1D4ExFq0MifTqAV65VzjRdshh/x1O/W5s7Dwn4ok/
	2TysdScUjMm+C3Du+2Wme4tevuPHTvyzlx462vQfckAGSoIpDnPuvA1kbvgIDeWC+KrJus+gLq/JU
	y3LnFDPQce0xXiIuP9H6L9huo12V0PS7ofenSxcolztqN76Tp3AYyBdwoHHR4s185rFd/Ko/HHLob
	6B8lqdiKpja1SHxRNvLtHJXGx4LajWVFuK+nMtCBaMP2l3ww9hNjAeolusq7H1TeM/4cQ/Uehw/UG
	Ky3Pla/SgGssu5j+/Xvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLoKI-00000000GmI-0EoP;
	Mon, 24 Jun 2024 18:22:02 +0000
Received: from mail-dm6nam04on20601.outbound.protection.outlook.com ([2a01:111:f403:2409::601] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLoKF-00000000Gki-1Yr1
	for kexec@lists.infradead.org;
	Mon, 24 Jun 2024 18:22:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gS3HubFjnc1uIU6l0aGe9qgtT5GsBQtTZ2+kQxWLey9IgprxJ7MJIUJBNqddsByoqiSm6i1FZ8cP7WzcDzf4/LJH7giVOgdPqc5SZ4JPNokb9izTeBompk7hqgPBgiNwqHLmANHGyZaaB/b1gaKzpeWhOQRgAFjy/LxxMbtQHYHgnmpn5bBx2yC5yZMu5N+mGqq+7EQJ5xwdnXr4o04866CxkUbX0BAPLSefLXeAFjSzg5A0O7rEU5AzmSo+MfV5DFb3dvxbMrKOc1qwRTF2hXSev4LMgQui9v3+0G0KT9MgfPRfQMdN87QDgPj4ZvUW228JCU6V4OWzkZP9FSeOQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lT2zjvaPwjmzCIBi+yL1MjNyh8yNkE8AcMIWGbgIQKk=;
 b=oX9F21Fz4fkfE4LSIfJxcNqxN6so2tuaFQXw61WTi6sTluva6oRAqPe00WOWvmcIgbY8DNuNC2CUxby+oiqKzOOVlHRKBsWZAAkLHYJtSe6jGc5P/s1HDJfSuN2wms8ZiXqmATmMa6QLvN3VSnjxxCQS1OYo3w+iwhUBLjtLwvA7P0mbKqlUfjH8xkIbfzLQvdT17d8uVtM51YQsLs7pN/xu4a0u2G9VOYVDVpZI1vaulnGUrRs67Ch28kQ5+EIXO3qXZu6+1Sg1kKiXq/2K3JGqJn9zLrftc2V2UumWnvXCkq5nv6jfnz1/hSZXmuC59XLBD7iaukXb3gkShwqSpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lT2zjvaPwjmzCIBi+yL1MjNyh8yNkE8AcMIWGbgIQKk=;
 b=XznHPGNUh5isBUBOL043fCuv2jb+shs0N4Yv5Es1V9ZGgsN6S/OeVkHubghG1AkZXdBMyK5U3ftoH2QfRupnX35Twe+5Ryr9CI+XfWx/70DhOfc1/2dh1VK+TEr3IOy/Mex3faVtS+9rL6qFn29Ky7bGf6zjn1Hz0VaTdjedKUg=
Received: from SA1PR05CA0016.namprd05.prod.outlook.com (2603:10b6:806:2d2::25)
 by DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 18:21:42 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:2d2:cafe::9d) by SA1PR05CA0016.outlook.office365.com
 (2603:10b6:806:2d2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.19 via Frontend
 Transport; Mon, 24 Jun 2024 18:21:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 18:21:41 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 13:21:39 -0500
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
	<dyoung@redhat.com>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 0/2] x86/snp: Add kexec support
Date: Mon, 24 Jun 2024 18:21:29 +0000
Message-ID: <cover.1719251730.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|DM4PR12MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: eb10d912-ffbf-47f4-179f-08dc947a7ec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|376011|1800799021|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q5Qh0571FReHCtIG3CLID/e0Rv6k1ydgDpAx1PMDMDglX5hbGbuq9luyc6W/?=
 =?us-ascii?Q?sHYGju/QxlBu4Yj+R9NXFftT7tQyj1aIX1KgPISQiVBETYrOp4IZkVcxxJtP?=
 =?us-ascii?Q?okFW5VAOKe7B1WysG3ejVVHxI9EMsGwgmg61L097hl1S5pcmSWVibEKNYLI7?=
 =?us-ascii?Q?/sKzDDaUsLzJE7auB17Ue+Gjde7UbLqmOofF2cgetpRC3v29qm0JX1Pn8jmV?=
 =?us-ascii?Q?jqPrG6mz7untGT5wk0e0+3V/7PtT8oocLK2aWfo14lTTxHgY7eYlWVSDY8fD?=
 =?us-ascii?Q?+nehpK+jPqq/ROSGQHQ4aDPMqIz+Nhuihf/+Hhhnb7ZFr18CMK+fnNVOkcsE?=
 =?us-ascii?Q?3JRmFNWijpd8ph0AIrt5IPksDl8wOxvl8balR+fQQ/9osrNU+BJdbxhx0WJx?=
 =?us-ascii?Q?zBJuB5OCPwm7WuZEulVapRdIJZquR4rBYfMG7hQhP7tpg12JN1/OI+ZsjPGe?=
 =?us-ascii?Q?8486+yBc4JCjIJGCbiKlnXipP3RML/g/ZRuph2NEUFLpFiQ+Ev5BUIP3PH61?=
 =?us-ascii?Q?DtCmC65qEv3fVjrPRDQL9ve/kyxSupCOBQwyucNNZAnAMDYXqP9unhhnXqoo?=
 =?us-ascii?Q?5oA9mGG96GAq8p6Dsm+KLhS5SHWLdrkrtHt53NFfLKY6DVjtlGTQLvuGNA4/?=
 =?us-ascii?Q?0JVPY0AFOIcMfinIQ7Lycn85KCloOuYzEVUI5Z/DphPOomThd6/aCGoU7m22?=
 =?us-ascii?Q?StM3ywft5Va5+TOuSI2fHgc9ADzdc/8W4twk32re/Jwivp2Ad24sIhloF0JO?=
 =?us-ascii?Q?NufZipKrHLPA6nUeleksRRtmqVXhSqgTzXKkco582puCmHbuGj4W9djCeEvB?=
 =?us-ascii?Q?3a8YoSsxCUux5Suz+RISwpobgv2yRSsr+m+DghjW3jQKnnuIz+GTJ+VYIYG/?=
 =?us-ascii?Q?oT2uSDQkMU5sg/QWapFJWQdCGxHt8bQHqlWegDS9lQTdzdhUuBHFyrfjIvHU?=
 =?us-ascii?Q?qO1JiFfnWGS3t8VMZLvA7tZdGI0amBVVkkQ/VzgY0B71SSSraYdzAdzTzOWe?=
 =?us-ascii?Q?bpGkCfs9icylbIhaL5xc4yH2v1WkPcQJ2OoXQj49VBG+WgVtSQn9T8zARfCF?=
 =?us-ascii?Q?Nut1wvGUjqj/Q9Ro00XUmWsDh/znT7paLMs4jt1bNi0S6QrgC4xHuSfH4DnD?=
 =?us-ascii?Q?KE+Mk1T9Txc00bZJgJhBrHPqx1nyJbiaEjR+harpns6nk3SvlXBNYWxoZs9/?=
 =?us-ascii?Q?WAa0GoQRChz+iQrEM5/I5R160GUs3uIspYOC3HDw05ljGeZSTXXRs7B0b0zD?=
 =?us-ascii?Q?VtsLhMIlv1QaVkncCdlURDJge6PUeyGLNDvX6hWDw+sT0n9WfswYVU9clDLX?=
 =?us-ascii?Q?blHCMFvlvQK4LTmSdiHknhnVF0eD5tJBTRx3nGysxo2U8lYoptKwX2ip9uxb?=
 =?us-ascii?Q?cxDWwdQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 18:21:41.2581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb10d912-ffbf-47f4-179f-08dc947a7ec0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_112159_428793_B919E3C2 
X-CRM114-Status: GOOD (  20.17  )
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

The patchset adds bits and pieces to get kexec (and crashkernel) work on
SNP guest.

This patchset requires the following fix for preventing EFI memory map
corruption while doing SNP guest kexec:
  https://lore.kernel.org/all/16131a10-b473-41cc-a96e-d71a4d930353@amd.com/T/#m77f2f33f5521d1369b0e8d461802b99005b4ffd6

The series is based off and tested against tree:
  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git

----

v10:
- Removed pr_debug() calls as per upstream review feedback.
- Add review tags.

v9:
- Rebased onto current tip/master;
- Rebased on top of [PATCH] x86/sev: Move SEV compilation units 
  and uses the coco directory hierarchy for SEV guest kexec patches.
- Includes the above mentioned patch as part of this patch-set to
  fix any kernel test robot/build issues.
- Includes the massaged version of patch 2/3 as per upstream
  review/feedback.

v8:
- removed fix EFI memory map corruption with kexec patch as this
  is a use-after-free bug that is not specific to SNP/TDX or kexec
  and a generic fix for the same has been posted. 
- Add new early_sev_detect() and move detection of SEV-ES/SNP guest
  and skip accessing video RAM during decompressor stage into
  this function as per feedback from upstream review.

v7:
- Rebased onto current tip/master;
- Moved back to checking the md attribute instead of checking the
  efi_setup for detecting if running under kexec kernel as 
  suggested in upstream review feedback.

v6:
- Updated and restructured the commit message for patch 1/3 to
  explain the issue in detail.
- Updated inline comments in patch 1/3 to explain the issue in 
  detail.
- Moved back to checking efi_setup for detecting if running
  under kexec kernel.

v5:
- Removed sev_es_enabled() function and using sev_status directly to
  check for SEV-ES/SEV-SNP guest.
- used --base option to generate patches to specify Kirill's TDX guest
  kexec patches as prerequisite patches to fix kernel test robot
  build errors.

v4:
- Rebased to current tip/master.
- Reviewed-bys from Sathya.
- Remove snp_kexec_unprep_rom_memory() as it is not needed any more as 
  SEV-SNP code is not validating the ROM range in probe_roms() anymore.
- Fix kernel test robot build error/warnings.

v3:
- Rebased;
- moved Keep page tables that maps E820_TYPE_ACPI patch to Kirill's tdx
  guest kexec patch series.
- checking the md attribute instead of checking the efi_setup for
  detecting if running under kexec kernel.
- added new sev_es_enabled() function.
- skip video memory access in decompressor for SEV-ES/SNP systems to 
  prevent guest termination as boot stage2 #VC handler does not handle
  MMIO.

v2:
- address zeroing of unaccepted memory table mappings at all page table levels
  adding phys_pte_init(), phys_pud_init() and phys_p4d_init().
- include skip efi_arch_mem_reserve() in case of kexec as part of this 
  patch set.
- rename last_address_shd_kexec to a more appropriate 
  kexec_last_address_to_make_private.
- remove duplicate code shared with TDX and use common interfaces
  defined for SNP and TDX for kexec/kdump.
- remove set_pte_enc() dependency on pg_level_to_pfn() and make the 
  function simpler.
- rename unshare_pte() to make_pte_private().
- clarify and make the comment for using kexec_last_address_to_make_private  
  more understandable.
- general cleanup. 

Ashish Kalra (2):
  x86/boot: Skip video memory access in the decompressor for SEV-ES/SNP
  Subject: [PATCH v9 3/3] x86/snp: Convert shared memory back to private
    on  kexec

 arch/x86/boot/compressed/misc.c |  15 +++
 arch/x86/coco/sev/core.c        | 166 ++++++++++++++++++++++++++++++++
 arch/x86/include/asm/sev.h      |   4 +
 arch/x86/mm/mem_encrypt_amd.c   |   2 +
 4 files changed, 187 insertions(+)

-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

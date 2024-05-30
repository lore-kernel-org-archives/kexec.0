Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E787C25B74
	for <kexec@archiver.kernel.org>; Thu, 30 May 2024 23:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gKAe4IuaaE8zy/JlOwgSz+gqFIQPFVUGsM54pYUZPl8=; b=f2TILGSuXZ+S2I
	a1Oqh0TTYmrUO2Bng6mWhOXb/tDy9n6a+RcyN3a8tfNEYh1SAbyVRGecezRMER3a3JSPSKWYHhwhK
	My3dh8spoFnCUW2oLkfMvTSlIskUb3beIwrOLoRvYEh++B4IVmnkU7+BzhDWIOhBZb6E+SX8iX4mG
	/ingaMriCY54jaSnMJxgpWGLxWTwLnOnRZAIvKBZADCTazYbYaAnqwDSkNrsUgJHyG7cAX4naLqbb
	ebRwpvRYmnnK1YtRUgh+MppdQ6gRVjf4PxmZFSf+LfLJHBW8yO4tu5MKZTQuzvVDQmWdyTnPxCScE
	staG390yQH+PGF60cYsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCpYd-00000008k32-2xio;
	Thu, 30 May 2024 23:51:43 +0000
Received: from mail-dm6nam11on20600.outbound.protection.outlook.com ([2a01:111:f403:2415::600] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCpYb-00000008k2W-0VvC
	for kexec@lists.infradead.org;
	Thu, 30 May 2024 23:51:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VELKVmIAa6WhnC63oHOCm2H4YWMCyXf2udRIek5bFzow+6yZ9SCS6rvWk32jsy0Toea1jclucFf5YpbqnUujGg9pmsimPfKH9+pur7cpCVlJiq1DkTwZKDe4o1m72ezODo0yAqdsJru1R746HenjX0VcZEIXvQkkopDRQj/KDpm+OZwkbY7G8QDnHYVmUADtgVOGLtTDYSTvRq/3VeLCAH7PV+iZa26uB8KkQ7FqbLLmMVZ34QxwNByTt0LzlKM426tFV2WjYHoAS5oVZpMLicHYFZrElN2JBDOKBg0Pkl4F6/6WdV60w5K75XBr3kQkl3ijVbFSaG9yI2LAPHl9pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAFBKpuEILgsLaCQWludpulSP3HmRGHrZRvwmYKTar4=;
 b=XsVrwqIZX3vxScB9YG86CXw729DQiRLoJqObGRNn+z1PdL4m16cujJ0bH8b+o/EX1+RbJ//MHJ+doIMfjfJdd1j40ev7fA6Hj9Wc3xH7RKCEO9geartGhzku8sFn1m/T2InWw8L0m60JtzO8i1844eUtW88zxEMGr5sGUMUIlCrGi2li89Uy9w4EYqrVW4IWTaUpgbQ9aZExe3VWpOkaUWC8mX28GpNzboc1SP9DjBWFddSF2zDP/AIHPEJkBauU3FjOSB7XtzdfEKV32Uvy8p8rpkBuP4nSJQqg3j1Yiokiso9UZyE7Btd59UiGjb2Ge6qV5Dq0dcOjinYrvEwyTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAFBKpuEILgsLaCQWludpulSP3HmRGHrZRvwmYKTar4=;
 b=qZLLF66XoAg4ViPOlB2pzweYr0/RYAOf0E2l42L+/e0dt4P1vUAb6KcMd26/zCGc3G02xB6GBhXraTfH9tVwHfqNik7f5Spt3/AvoF5JzAeB+abD803se5SZkmsmK8FGWV91W4304+DTU2rioXbAAhDuB4OYe/7pUOrbfWTAZns=
Received: from BL0PR0102CA0020.prod.exchangelabs.com (2603:10b6:207:18::33) by
 CY5PR12MB6153.namprd12.prod.outlook.com (2603:10b6:930:27::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.19; Thu, 30 May 2024 23:36:51 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::a5) by BL0PR0102CA0020.outlook.office365.com
 (2603:10b6:207:18::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19 via Frontend
 Transport; Thu, 30 May 2024 23:36:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 23:36:51 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 18:36:50 -0500
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
Subject: [PATCH v7 0/3] x86/snp: Add kexec support
Date: Thu, 30 May 2024 23:36:37 +0000
Message-ID: <cover.1717111180.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|CY5PR12MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 76e12ec7-fdee-46d9-875c-08dc8101618d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|82310400017|7416005|36860700004|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oeM8wVNEtZ6YgMnh+Yq1xXIrpLeM/XVTYIZSpmi2qogGTh6ogFt8vm1hJbO1?=
 =?us-ascii?Q?q18nN8zrWAEcAGdh6bF0mCSMgvEOHcNZsYZHtJEwcyk40fuWXA1cu4NuRz96?=
 =?us-ascii?Q?Dcnexefd/nOyM8oyaItR8GhuxW6otC3n1KTAls4Wj9KSsGdbjHMjVb9fXmL0?=
 =?us-ascii?Q?g2uLfVsW/ozjTKXfnW44HnSZu/y9OaDpxaFN54iedzI/8cyJ12AKfjG7gyV7?=
 =?us-ascii?Q?E3EVlg37fi93I4KIQCrrkX6n2dLANfsIhQ9jjUzjBRXst8e4xBQsdyj6nyli?=
 =?us-ascii?Q?cY/lNhIEbyOWqvc1oX43WRq1b7BJ/od0s1mr6iU+pyfigsTHYzk9l3YBmoQx?=
 =?us-ascii?Q?K+0LI9C9dd3YDDjmTRGK23JtUHJ2RLZCyDd3xB4VYOkN5WpW5RKP2YaQvxkL?=
 =?us-ascii?Q?/2pddhtY7H3KEKultoo/Pxk/AaPDB/4OTf6dtK9X0fgMIymtG6zPpenYb4Li?=
 =?us-ascii?Q?wyrOXG0xGjZJSMRb8R/RW6Nz3N3WTyYBUIVUbGwuAIwn7nX/ORK7ICI6hZAE?=
 =?us-ascii?Q?KLuiduYP4tUlAUfsfY4W8+t5NRYvJJnIFbqhWawv7TPaXrUAAjad75t7SOGs?=
 =?us-ascii?Q?CrU0ag7fmQgYtjIV4LZJ5q9mqvAweq8i/TVsnjgV0V2XjM9BdFnrBnF1mnLN?=
 =?us-ascii?Q?WFhe4TphGvKZy+oIZ58AqfeYiD8oK550Qg9fDiO2ycPYUmUcbeUrXjYCPZHX?=
 =?us-ascii?Q?glOaL7lUlHRo1S6383/3y/B9gEDIbLCbgDibtssEgagpvf/2EGNDg/u4d2vB?=
 =?us-ascii?Q?vijXTrR6xJIMSDhPSBD5gMMmRVqUm+Jp7toV97Q9q7ywFmpM6no8L4Bj5+d0?=
 =?us-ascii?Q?poktV73uI/CO864+j2nCucNRlKod03LUlLXRyOpkDgup3hrGXTvXygrRuzEv?=
 =?us-ascii?Q?6Az6PO8IQ8BJEU734fkxCkP4O9B1YnriqVMPxyGdiFaN9iNu7dr6G3OIwb+l?=
 =?us-ascii?Q?UIkl2txaiELn8wbSRBFldPwoRQj77y7H+bja5KKKTR9rRzbJmzp450OE1i0A?=
 =?us-ascii?Q?l/U+gDx7Y6egfO65tWowEUm3jwD81Lxqb42KRbC/Z+oxdTYC8wUlZuZDZiy8?=
 =?us-ascii?Q?fZPMM44jWwy6XWPVjCk7TgbIqpr5+wMH5iwYUeWx8ZxJjomq+cMavgiZKmeG?=
 =?us-ascii?Q?APTrdBqKy03cGz3EW0kwG4qO8kFC0IrXnnZUhzoEax7OWfz5tPaqqe2fqWkO?=
 =?us-ascii?Q?PbT4PhhDTar7X/2hiGwpQZzaGwIOrfK37PdfgSIQTBR1X0pFY6tmoJePIt6v?=
 =?us-ascii?Q?Of6jHkNGIkWyVMc7YCxu85rt/mA9zpTG9ohnAvCYbfIbmQ+WuAEZV58vApn9?=
 =?us-ascii?Q?YM13tENR+8mnBIZcZ7Tb9lWG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(7416005)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 23:36:51.0914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e12ec7-fdee-46d9-875c-08dc8101618d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6153
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_165141_283607_391F4DD1 
X-CRM114-Status: GOOD (  17.24  )
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

The series is based off of and tested against Kirill Shutemov's tree:
  https://github.com/intel/tdx.git guest-kexec

----

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

Ashish Kalra (3):
  efi/x86: Fix EFI memory map corruption with kexec
  x86/boot/compressed: Skip Video Memory access in Decompressor for
    SEV-ES/SNP.
  x86/snp: Convert shared memory back to private on kexec

 arch/x86/boot/compressed/misc.c |   6 +-
 arch/x86/include/asm/sev.h      |   4 +
 arch/x86/kernel/sev.c           | 162 ++++++++++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt_amd.c   |   3 +
 arch/x86/platform/efi/quirks.c  |  30 +++++-
 5 files changed, 200 insertions(+), 5 deletions(-)


base-commit: f8441cd55885e43eb0d4e8eedc6c5ab15d2dabf1
prerequisite-patch-id: a911f230c2524bd791c47f62f17f0a93cbf726b6
prerequisite-patch-id: bfe2fa046349978ac1825275eb205acecfbc22f3
prerequisite-patch-id: 5e60d292457c7cd98fd3e45c23127e9463b56a69
prerequisite-patch-id: 1f97d0a2edb7509dd58276f628d1a4bda62c154c
prerequisite-patch-id: 6e07f4d4ac95ad1d2c7750ebd3e87483fb9fd48f
prerequisite-patch-id: 24ec385d6a89cf2c8553c6d29515cc513643a68a
prerequisite-patch-id: 6a8bda2b3cf9bfab8177acdcfc8dd0408ed129fa
prerequisite-patch-id: 99382c42348b9a076ba930eca0dfc9d000ec951d
prerequisite-patch-id: 469a0a3c78b0eca82527cd85e2205fb8fb89d645
prerequisite-patch-id: 2be870cdf58bdc6a10ca3c18bf874e5c6cfb7e42
prerequisite-patch-id: 7fc62697fb6bdade0bab66ba2b45a19759008f9e
prerequisite-patch-id: 95356474298029468750a9c1bc2224fb09a86eed
prerequisite-patch-id: d4966ae63e86d24b0bf578da4dae871cd9002b12
prerequisite-patch-id: fccde6f1fa385b5af0195f81fcb95acd71822428
prerequisite-patch-id: 16048ee15e392b0b9217b8923939b0059311abd2
prerequisite-patch-id: 5c9ae9aa294f72f63ae2c3551507dfbd92525803
prerequisite-patch-id: 758bdb686290c018cbd5b7d005354019f9d15248
prerequisite-patch-id: c85fd0bb6d183a40da73720eaa607481b1d51daf
prerequisite-patch-id: 60760e0c98ab7ccd2ca22ae3e9f20ff5a94c6e91
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

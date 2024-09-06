Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9272CE7B11
	for <kexec@archiver.kernel.org>; Fri,  6 Sep 2024 20:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mGQgewu2fz1LgIeTZ7RprlZU8XasAgH0C/vPlKoqZDE=; b=oKPPNc1RgvGEsY
	2DU+w9dUPmndl95Jxv275lhH2j6Lq4cutKecmzqdM89orfIakq0Zha2O/OuB9jQ6979sn/D/tvhSk
	c9MLCJYaEdoOQTZKP84auv3CfpdiBzbfO97A5vwabHjDi69Zhafr5GxOaHeNWMUXzVDrMgX7mYDCO
	3v17tM3zWe+ppE8mKFo0nf17gN/3q/ISdiu81OImIbJRDYOHheRk5AVQ/ae/LoV90u9HJKCPvp0iq
	g3Q9OKKTyNhRf13DyLpaY8VqRzPI1GE7lmw4+3LX1lstDN1K+q0ah5+mZoBjtCPKzUILPm9kTNpJK
	R8fDzFQ1n5FjHxYTConA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smfZD-0000000DXzT-3Utl;
	Fri, 06 Sep 2024 20:28:27 +0000
Received: from mail-mw2nam12on20622.outbound.protection.outlook.com ([2a01:111:f403:200a::622] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smfZA-0000000DXx4-2pLx
	for kexec@lists.infradead.org;
	Fri, 06 Sep 2024 20:28:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUo1O4Ep244N50vsl3lmyZbTFpqyJ4cPgkh7I//Lrz1brelZxN0LOHQU12eWcAc+uJvEDHEcxiG0TmbwsW7eNdhlwj48iy0bTDWyI7pJQBKCoYyzdJ0EzdciRF6vtkHP9mJs8tCA3WtZbvWUZjFiBS4M2mciq9LLCl71oymcStNc6kIF51tmD52hl+zS+fNJvoTJzgBcvl6eFSXtLv8NpOn9VmdGXdLoK9QK4/M0pxaYtf4/s/0Sk0O+NoFhywsRk4ATEteYhoEsoPgmUNtwHWTJIoz1BcFIuwQsbuyPoGrOejqdp8soj+NiXSb3Vx3Cl6dIR9YGwwpcHaDsMMpXTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbUFsRTJ8oz/SNKqBr6073R+hrqlLoy1d5P3uL8IVrM=;
 b=wdm+xO1fwqV5bieyG+oMLA3qiFXRw0TkeBmTT6z0gIRrmZ/JMhozKQmuMYS+K0HkbMMkDIzBygLsNwIbnhSpvpILdjz1l/9zzKEDks5gRDZJrI1cL37jfFVRZUccqlchOopHHWb+1sI85YSwI/tt6YYZOh9+3tpqpK63F83oWdMwLv3msTroDcY4htPfTMg6FUpss4JHqyUeo0pzE7GPGTEOg6RRxGBdJXwQBSqXQuJGZvyz2yFkBd/wAiroVhLRWISc31i8uE+DOVygxvl+ORm+DOp0PmOkQKws7c4sJIhW9Lvpv9f0mqSnVZD3vFgSfDI0UIxZ7GAtrfioZ+r1lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbUFsRTJ8oz/SNKqBr6073R+hrqlLoy1d5P3uL8IVrM=;
 b=wGEBxofrmZx1VBgXJLHkaxPRQzeLA/aWE58ypM/Tx2wiFSIXdfKHQx2DDmtJk3L622qaKTZwvoKewQ2GXY3yAcMJ06+ij+lsO1liT+GToK+tQfosIi4s0m0qIUm8smVChjrTGqtr59epGE4GQ+IywI/InV7Eo4dxmarHe55wucA=
Received: from MW4PR03CA0262.namprd03.prod.outlook.com (2603:10b6:303:b4::27)
 by MN0PR12MB5884.namprd12.prod.outlook.com (2603:10b6:208:37c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 20:28:10 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:303:b4:cafe::10) by MW4PR03CA0262.outlook.office365.com
 (2603:10b6:303:b4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25 via Frontend
 Transport; Fri, 6 Sep 2024 20:28:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 20:28:09 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 15:28:07 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <seanjc@google.com>
CC: <ashish.kalra@amd.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <kexec@lists.infradead.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<michael.roth@amd.com>, <mingo@redhat.com>, <pbonzini@redhat.com>,
	<peterz@infradead.org>, <tglx@linutronix.de>, <thomas.lendacky@amd.com>,
	<x86@kernel.org>
Subject: Re: [PATCH v2] x86/sev: Fix host kdump support for SNP
Date: Fri, 6 Sep 2024 20:27:57 +0000
Message-ID: <20240906202757.5258-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZtjdxNTBJymcx2Lq@google.com>
References: <ZtjdxNTBJymcx2Lq@google.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|MN0PR12MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: 1acde7ff-97d2-4e63-0089-08dcceb26c7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KLPuGAkU/CcyvDvEpNY1YmQBRFRAQdrGxX1O0+e60wVVbzJEBRI74OpHDkf1?=
 =?us-ascii?Q?00AGOqfV+8S7fEGb6A36ZreO+vELt4Of5bbfnLAPTaGOnmUCbi2KjCrNLp03?=
 =?us-ascii?Q?YXKCTNUQUGR6+s4Hny032/gq1aHP21uZ5CD1cs+fkZFobCeoKe61dxxQdO99?=
 =?us-ascii?Q?/ZlXFHFB/7wQ4h2e3BHX02sGNEYNmXqcMGgzu8HzZfeDHOKWDdArflwqenkY?=
 =?us-ascii?Q?heU/mI6LBAjwRod2g8g0yhjQd5vvr46ON9MCCkyup8BKM2GFA3rEuMOGgx4c?=
 =?us-ascii?Q?TzP/ZJEvX58WRD9cjiPKQiZ6wROHft51GHhnAYaewTirunmWvrNbMtVvWA7A?=
 =?us-ascii?Q?oIE2nmueDf/SfKTbKzpo9WTFgz8Ut85a0CURwN1EIL6cmsHTvJVSD9Muk+kL?=
 =?us-ascii?Q?x3KkPjZD0svrXSXUSSkqoKiQG3pey/UvCztAW6wRCBij2wnx7VnnoJT74+Wt?=
 =?us-ascii?Q?dJyvCQ3hAdOvdzVNk1QS/b5vG/Cy/Cn/6edSTTPpVJseEGtYWgArtdSLWgWu?=
 =?us-ascii?Q?kEYM4pk/Ie/sTE36eUmPaHwySmbhQNGAVJMaBZyYbiXKLiPtydNUuZYiUZNJ?=
 =?us-ascii?Q?/ymSQkuW5pCsZ4qRkvtMbV7yXfJgDf6sB9n3hVk71Lx6rcug/JjrJSiBQfdl?=
 =?us-ascii?Q?m3vfl+dEEp9T3h2QmsG6G4sRNwcA+fR/Mvnq6O8gO0JdYsfr4jDqowh3C0Ym?=
 =?us-ascii?Q?3oFLwLeXiPuqNVMsTQxJkfYVnYd8zSYpZDnWeUQ1ES6oVlAvfW0rWBVj2N+I?=
 =?us-ascii?Q?ZVqi+YaEiN0zWRcfJUbIumRS+nJp1JtjKd5wEAHPmeJW8J9SiK5gTmNhfe6X?=
 =?us-ascii?Q?ktoBo2oS2OMCQbgkxo6nWkXs+bW4yd1zUJ6G9EBDs3uODqBzIxdDzUUIVyCU?=
 =?us-ascii?Q?tbjzjXGjwR3NcSCe0TlrY23jGZcEHc7wpefeeKj6TXjUMDRIotyL0l0kVhUg?=
 =?us-ascii?Q?l2zko8slqzt2aqoRL1bWaF78j5zKgVjqRtF8Un679fEHk2xSR+5Xe3MIQ6Vu?=
 =?us-ascii?Q?0if8suhMcNLaxdTSIk9ArGk0CEPqbMZwUDhesCRjK1X8+AGbORz4H0h6K/fs?=
 =?us-ascii?Q?H2l3lscqoe1Ia/HN0X396OwjaSCZmKaer4QXmFvos8KghcEaNwUEm0uFRJlD?=
 =?us-ascii?Q?x5EpnPLlxBPRxbDakRdMfa1dtyPIWcOJ/bzteW0qUeN2b02YL7vlkzExoH4F?=
 =?us-ascii?Q?Z7wtYd4VCeFvgVfDlfPxBkXU03c0PILhvgJUgGtNKO6THa8aB0tS/Rtynod9?=
 =?us-ascii?Q?itFqcktOMiSgjagsoKSC3Z2WEUMlvfsynZKImNWWYSalAYDWtg7o0oKYh/39?=
 =?us-ascii?Q?zc690qUJwUByycTqEkZYzmbn0/xsiPlOj3rEWBxndtodBOd23s4jiqKupwZ9?=
 =?us-ascii?Q?FWUgZjpz+WZIGo1IImP4Q5o4OTAJvcIUMBYJtA5wMqCnyTFqEPRUDDW+/CkT?=
 =?us-ascii?Q?x/BMUfi6KULEs5XzDi/lFJrqiHROlppt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 20:28:09.7682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1acde7ff-97d2-4e63-0089-08dcceb26c7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5884
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240906_132824_751321_D92C1FB2 
X-CRM114-Status: GOOD (  26.99  )
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

Hello Sean,

On 9/4/2024 5:23 PM, Sean Christopherson wrote:
> On Wed, Sep 04, 2024, Ashish Kalra wrote:
>> On 9/4/2024 2:54 PM, Michael Roth wrote:
>>>   - Sean inquired about making the target kdump kernel more agnostic to
>>>     whether or not SNP_SHUTDOWN was done properly, since that might
>>>     allow for capturing state even for edge cases where we can't go
>>>     through the normal cleanup path. I mentioned we'd tried this to some
>>>     degree but hit issues with the IOMMU, and when working around that
>>>     there was another issue but I don't quite recall the specifics.
>>>     Can you post a quick recap of what the issues are with that approach
>>>     so we can determine whether or not this is still an option?
>>
>> Yes, i believe without SNP_SHUTDOWN, early_enable_iommus() configure the
>> IOMMUs into an IRQ remapping configuration causing the crash in
>> io_apic.c::check_timer().
>>
>> It looks like in this case, we enable IRQ remapping configuration *earlier*
>> than when it needs to be enabled and which causes the panic as indicated:
>>
>> EMERGENCY [    1.376701] Kernel panic - not syncing: timer doesn't work
>> through Interrupt-remapped IO-APIC
>
> I assume the problem is that IOMMU setup fails in the kdump kernel, not that it
> does the setup earlier.  That's that part I want to understand.

Here is a deeper understanding of this issue:

It looks like this is happening: when we do SNP_SHUTDOWN without IOMMU_SNP_SHUTDOWN during panic, kdump boot runs with iommu snp 
enforcement still enabled and IOMMU completion wait buffers (cwb) still locked and exclusivity still setup on those, and then in 
kdump boot, we allocate new iommu completion wait buffers and try to use them, but we get a iommu command completion wait time-out,
due to the locked in (prev) completion wait buffers, the newly allocated completion wait buffers are not getting used for iommu 
command execution and completion indication :

[    1.711588] AMD-Vi: early_amd_iommu_init: irq remaping enabled
[    1.718972] AMD-Vi: in early_enable_iommus
[    1.723543] AMD-Vi: Translation is already enabled - trying to copy translation structures
[    1.733333] AMD-Vi: Copied DEV table from previous kernel.
[    1.739566] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.11.0-rc6-next-20240903-snp-host-f2a41ff576cc+ #78
[    1.750920] Hardware name: AMD Corporation ETHANOL_X/ETHANOL_X, BIOS RXM100AB 10/17/2022
[    1.759950] Call Trace:
[    1.762677]  <TASK>
[    1.765018]  dump_stack_lvl+0x70/0x90
[    1.769109]  dump_stack+0x14/0x20
[    1.772809]  iommu_completion_wait.part.0.isra.0+0x38/0x140
[    1.779035]  amd_iommu_flush_all_caches+0xa3/0x240
[    1.784383]  ? memcpy_toio+0x25/0xc0
[    1.788372]  early_enable_iommus+0x151/0x880
[    1.793140]  state_next+0xe67/0x22b0
[    1.797130]  ? __raw_callee_save___native_queued_spin_unlock+0x19/0x30
[    1.804421]  amd_iommu_enable+0x24/0x60
[    1.808702]  irq_remapping_enable+0x1f/0x50
[    1.813371]  enable_IR_x2apic+0x155/0x260
[    1.817848]  x86_64_probe_apic+0x13/0x70
[    1.822226]  apic_intr_mode_init+0x39/0xf0
[    1.826799]  x86_late_time_init+0x28/0x40
[    1.831266]  start_kernel+0x6ad/0xb50
[    1.835436]  x86_64_start_reservations+0x1c/0x30
[    1.840591]  x86_64_start_kernel+0xbf/0x110
[    1.845256]  ? setup_ghcb+0x12/0x130
[    1.849247]  common_startup_64+0x13e/0x141
[    1.853821]  </TASK>
[    2.077901] AMD-Vi: Completion-Wait loop timed out
...

And because of this the iommu command, in this case which is for enabling irq remapping does not succeed and that eventually causes 
timer to fail without irq remapping support enabled.

Once IOMMU SNP support is enabled, to enforce RMP enforcement the IOMMU completion wait buffers are setup as read-only and 
exclusivity set on these and additionally the IOMMU registers used to mark the exclusivity on the store addresses associated with 
these CWB is also locked. This enforcement of SNP in the IOMMU is only disabled with the IOMMU_SNP_SHUTDOWN parameter with 
SNP_SHUTDOWN_EX command.

From the AMD IOMMU specifications:

2.12.2.2 SEV-SNP COMPLETION_WAIT Store Restrictions On systems that are SNP-enabled, the store address associated with any host 
COMPLETION_WAIT command (s=1) is restricted. The Store Address must fall within the address range specified by the Completion Store 
Base and Completion Store Limit registers. When the system is SNP-enabled, the memory within this range will be marked in the RMP 
using a special immutable state by the PSP. This memory region will be readable by the CPU but not writable.

2.12.2.3 SEV-SNP Exclusion Range Restrictions The exclusion range feature is not supported on systems that are SNP-enabled. 
Additionally, the Exclusion Base and Exclusion Range Limit registers are re-purposed to act as the Completion Store Base and Limit 
registers.

Therefore, we need to disable IOMMU SNP enforcement with SNP_SHUTDOWN_EX command before the kdump kernel starts booting as we can't 
setup IOMMU CWB again in kdump as SEV-SNP exclusion base and range limit registers are locked as IOMMU SNP support is still enabled.

I tried to use the previous kernel's CWB (cmd_sem) as below: 

static int __init alloc_cwwb_sem(struct amd_iommu *iommu)
{
        if (!is_kdump_kernel())
                iommu->cmd_sem = iommu_alloc_4k_pages(iommu, GFP_KERNEL, 1);
        else {
                if (check_feature(FEATURE_SNP)) {
                        u64 cwwb_sem_paddr;

                        cwwb_sem_paddr = readq(iommu->mmio_base + MMIO_EXCL_BASE_OFFSET);
                        iommu->cmd_sem = iommu_phys_to_virt(cwwb_sem_paddr);
        		return iommu->cmd_sem ? 0 : -ENOMEM;
                }
        }

        return iommu->cmd_sem ? 0 : -ENOMEM;
}

I tried this, but this fails as i believe the kdump kernel will not have these previous kernel's allocated IOMMU CWB in the kernel 
direct map : 

[    1.708959] AMD-Vi: in alloc_cwwb_sem kdump kernel
[    1.714327] AMD-Vi: in alloc_cwwb_sem SNP feature enabled, cmd_sem_paddr 0x100805000, cmd_sem_vaddr 0xffff9f5340805000
[    1.726309] AMD-Vi: in alloc_cwwb_sem kdump kernel
[    1.731676] AMD-Vi: in alloc_cwwb_sem SNP feature enabled, cmd_sem_paddr 0x1050051000, cmd_sem_vaddr 0xffff9f6290051000
[    1.743742] AMD-Vi: in alloc_cwwb_sem kdump kernel
[    1.749109] AMD-Vi: in alloc_cwwb_sem SNP feature enabled, cmd_sem_paddr 0x1050052000, cmd_sem_vaddr 0xffff9f6290052000
[    1.761177] AMD-Vi: in alloc_cwwb_sem kdump kernel
[    1.766542] AMD-Vi: in alloc_cwwb_sem SNP feature enabled, cmd_sem_paddr 0x100808000, cmd_sem_vaddr 0xffff9f5340808000
[    1.778509] AMD-Vi: in alloc_cwwb_sem kdump kernel
[    1.783877] AMD-Vi: in alloc_cwwb_sem SNP feature enabled, cmd_sem_paddr 0x1050053000, cmd_sem_vaddr 0xffff9f6290053000
[    1.795942] AMD-Vi: in alloc_cwwb_sem kdump kernel
[    1.801300] AMD-Vi: in alloc_cwwb_sem SNP feature enabled, cmd_sem_paddr 0x100809000, cmd_sem_vaddr 0xffff9f5340809000
[    1.813268] AMD-Vi: in alloc_cwwb_sem kdump kernel
[    1.818636] AMD-Vi: in alloc_cwwb_sem SNP feature enabled, cmd_sem_paddr 0x1050054000, cmd_sem_vaddr 0xffff9f6290054000
[    1.830701] AMD-Vi: in alloc_cwwb_sem kdump kernel
[    1.836069] AMD-Vi: in alloc_cwwb_sem SNP feature enabled, cmd_sem_paddr 0x10080a000, cmd_sem_vaddr 0xffff9f534080a000
[    1.848039] AMD-Vi: early_amd_iommu_init: irq remaping enabled
[    1.855431] AMD-Vi: in early_enable_iommus
[    1.860032] AMD-Vi: Translation is already enabled - trying to copy translation structures
[    1.869812] AMD-Vi: Copied DEV table from previous kernel.
[    1.875958] AMD-Vi: in build_completion_wait, paddr = 0x100805000
[    1.882766] BUG: unable to handle page fault for address: ffff9f5340805000
[    1.890441] #PF: supervisor read access in kernel mode
[    1.896177] #PF: error_code(0x0000) - not-present page

....

I think that memremap(..,..,MEMREMAP_WB) will also fail for the same reason as memremap(.., MEMREMAP_WB) for the RAM region will 
again use the kernel directmap.

So it looks like we need to support IOMMU_SNP_SHUTDOWN with SNP_SHUTDOWN_EX command before kdump kernel starts booting.

Thanks,
Ashish

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

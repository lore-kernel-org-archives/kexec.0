Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A9CC021AA
	for <kexec@archiver.kernel.org>; Thu, 20 Feb 2025 02:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6J+ACsJxusHPqsT2+IFsZTggg4psydIQWoZ0Dl19M+M=; b=cm4OAU3I2owwyql6wBR9BCbanv
	iWBEQZf7PH6dAUlJQZhBNQQmrrzp+m1DdwTDRgbIyuUnPYx3FrlcZFzSyKoJNdi4EYoXe2nxx7uHo
	SFBJoZsgisvst1VZ0apKXkAhTGbglewnN6L1sOZmCE6By3kjZyzSpsOSBeYTg90/XsmZptBR+lPgz
	YZ5i+iUCDlIjczby+kmNZtR6SwHU2/HgssAw79LlAFfU6fIjm+YdRB3zZYzPEcStMFZVfg31ELFKQ
	nyyDYpA2Z7jFHpB4l+0bQZhbuPBgPvMJZK4e/xY5nG7flpsAZ72chfxreIBF2BK8KlqcRtdBL96wv
	hJTpafuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkwIf-0000000GKtV-0FTm;
	Thu, 20 Feb 2025 02:28:29 +0000
Received: from mail-bn8nam04on2060e.outbound.protection.outlook.com ([2a01:111:f403:2408::60e] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkwIc-0000000GKs8-128o
	for kexec@lists.infradead.org;
	Thu, 20 Feb 2025 02:28:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rrn7LltVJTEkJeDB4Fgm0eEvPTD7L/sefd7FQ9J2R2K4RegFf3NhTBEnjoZCyOarY6hTqVgvfsdgjC9ycWJF3h326rdATrgKphcslbt07dk7D0aKFhseKvysr/8a253eFMGkjGQTWVVfc9I3SEQ9bA/TLkhQpkWyo8cTbmpaDpgqhC94pbWX/ZXqjONySFbVRNy34btLpFK7YAdn47l8onQPgcF4w5Yw6ybuTOk4n8k7uyegmnlV2eNtpDLt+sq5SDOXnwVTEDWuWd6MCkLm4Ob3+FYvuOt90r8e+HtI3N7Cj79sCXhO0Qy+p0328X/vgYL87KZ18xRK9ogiIZyD4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6J+ACsJxusHPqsT2+IFsZTggg4psydIQWoZ0Dl19M+M=;
 b=hbgnoY9l6uMGsuEqMC8FxM1/JRbGAXPWz5Ru4Ca7JhEV20YmBOFUfzJMO1pLuvmm9ibiBfmNMvduRB3eys0mpWogIwx1gJLrtNuXRDVsH8YS+tzuB13wsu/atKVKRZZ8e1vudbm8/OrM+Z+Jggxi85D78S2Ou3qgROY/U3qbRr+gsx5SbT2cvL5HX7bj+EKCMySa1NevqPWZRMyCAWkk/JfbbAAbFtMNhBq3JvKDddMfIuGMYcD7R3p7nngVTbo+93+zeGLVjMDlhcYtF6t8TtMReHyLf6wwbdFl3DhhITDdi2n9gIyrd6fUYAI5jf/418i1EHwktjPzggK01ITeoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6J+ACsJxusHPqsT2+IFsZTggg4psydIQWoZ0Dl19M+M=;
 b=C3Zyuu1EI/+og0r0h/hs+DfyekGhw7TbCP/QaE5CXEsNXA6Xa+m2UxPv+cZ7yqJtjS3MATC8yT7KF2jl+lgMrbu8d/oSXv8MCzzlOJFaZXI94PNyPjc7eBOVPsUdsfc1Kewh0tMhK9EHXipIM8J4KcOxIVaNSRG0127yHHgHbwE=
Received: from BL1PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:256::12)
 by SA5PPF9BB0D8619.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 02:28:12 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:256:cafe::d4) by BL1PR13CA0007.outlook.office365.com
 (2603:10b6:208:256::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 02:28:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 02:28:11 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Feb
 2025 20:27:49 -0600
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <kirill.shutemov@linux.intel.com>
CC: <akpm@linux-foundation.org>, <bhe@redhat.com>, <dave.hansen@intel.com>,
	<ebiederm@xmission.com>, <kexec@lists.infradead.org>, <kirill@shutemov.name>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<rick.p.edgecombe@intel.com>, <security@kernel.org>, <x86@kernel.org>,
	<yan.y.zhao@intel.com>, <thomas.lendacky@amd.com>, <michael.roth@amd.com>
Subject: Re: [PATCH v2 0/1] Accept unaccepted kexec segments' destination addresses
Date: Thu, 20 Feb 2025 02:27:29 +0000
Message-ID: <20250220022729.5722-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <fslhdizolr4twqm4ixevzj6ai5l5qg6mxky25jasn3yctsnvt4@hpwphlmfs5cp>
References: <fslhdizolr4twqm4ixevzj6ai5l5qg6mxky25jasn3yctsnvt4@hpwphlmfs5cp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|SA5PPF9BB0D8619:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c96fdc9-ac9b-46a0-a1b5-08dd5156386e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700013|7416014|1800799024|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1vXyG/RTSRQmF/YXKUemX+39+c044KxrTOfpfLjYJnhsypYbru8zz9y9JjSR?=
 =?us-ascii?Q?R1OzAoSbfxRD9+YjkpuYld21mpTHOpofco64L2cqXkmRengsLY7oIh/hEyOS?=
 =?us-ascii?Q?Evgc9EQPZVCN8qM6zH4W9JCpkestfc3N/FKYFh7qSO5mjv2f8yPryhqB4RzN?=
 =?us-ascii?Q?RU1/bOoBt5CeKQKrXSyYYTCHj2qJY10GfPS7UEywbzqrpe8zudN4Oq29217U?=
 =?us-ascii?Q?p/Fr433T9cZ8T4VDaCnfFiawxeSuJbzE0d20YbQ/24BC5fXnSsa1WlvF2180?=
 =?us-ascii?Q?G/Tr/t2MP4mN7fwGt/2VuWOlR65vzqpWmP+5I/HYZ4AMSTmwKS4axA8HYjLP?=
 =?us-ascii?Q?iR21UscAZuhW17j0EcCcOUhiDR6B9qGtQ7T09H4z++eCmll1ECBZXQUCyXbU?=
 =?us-ascii?Q?2v518sw6GaktPbcGB0PrNgOjFcRK1kwUbWkfm/pFYoI7RyGXcenP5WhptX66?=
 =?us-ascii?Q?xMwI/BbYmzbdEQRxQLf0mxCBiM7EoH5IWtIJ+SI6fQE96140m2h8RE2+hxgp?=
 =?us-ascii?Q?KRMrAfFlcGfLgM1it7vNo0fyZdNT4rXmTggwvWokJ/Mz/EsHLNPOm1z+kTBa?=
 =?us-ascii?Q?MCD6RzMY+l1ctkuaxp1uVy5KSpyW0a0uu2eE4hx+xe2Cgg45zM9tvKNv/o2u?=
 =?us-ascii?Q?cyxwqxsck1s3lVI9ayVdVmq0Bs5kW74R1ju1uQoKPGN8Kmjee0SM6lny9NPc?=
 =?us-ascii?Q?VO1FwXKIRSemyd7QKhiTLF+iFwxsdta5reqP55XYOt7pOQMjLuOPfgG7iAUy?=
 =?us-ascii?Q?1TqmJRwf4LYS2koIxWgaDcZVRzbdF3Ca3ZcDikBlhwysaEIotwRPgjrkT+av?=
 =?us-ascii?Q?h/darqIi29UK2k3ef7ANmJOktzKwRaumYHJTRHMmDdkC9krPzKiBjE+CmmXk?=
 =?us-ascii?Q?QUZBjXGejTJYbea2Vs/O59xXw6F28opNrprg6U38eULIA0vUC9s4KQo+G/y6?=
 =?us-ascii?Q?kOcfEHJWZmAZjyNto1+oz7EOg1EbvYz3xajpZSPZ9BWC95jsPsFoEm0Gps6Q?=
 =?us-ascii?Q?golObDVYUQX+1AGOEsM5g6Cpkav3FU60A4JGpWnZcTQs7Hayjc/+bIZ/IvRq?=
 =?us-ascii?Q?1evTRjtKzIfPWv+OjyoxmOcmSOViRVIE+cpYo1jiY3xjsGdv9TwcdK27+kK0?=
 =?us-ascii?Q?TcaVQa3d5JE6WIcTRHj9HTNWZ3BOBsyMxNJbaHeb+zFvM5cANtLC6t1sYZJo?=
 =?us-ascii?Q?Ifp8ECflTXvbHYVDrMBY9Z1HFagwJJrkTw5YRvdbRb0NAEEdC8QiICM+lsVw?=
 =?us-ascii?Q?ZD0Px4EoMiD5tU3EO5SYD8MovneGVAzYITzdos941Wg1BIC+uc+W/wWY1K7q?=
 =?us-ascii?Q?uWX5jKh1B3vBFzFPx/dlikPJwD5bKTPbcCusYZzV2Shlpk3WlMczkj/YSMYH?=
 =?us-ascii?Q?LCyzPjrsrqllftH3AXsSSG5EqRa9LdgItglap3sgs0aS/mRCbV9CNyfgtNqD?=
 =?us-ascii?Q?3Gplmx8a0RIDooNHxiWU6UlQsa9pAW84?=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 02:28:11.1977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c96fdc9-ac9b-46a0-a1b5-08dd5156386e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9BB0D8619
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250219_182826_279719_CB5384A4 
X-CRM114-Status: GOOD (  34.18  )
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

> On Thu, Feb 13, 2025 at 07:55:15AM -0800, Dave Hansen wrote:
>> On 1/13/25 06:59, Eric W. Biederman wrote:
>> ...
>> > I have a new objection.  I believe ``unaccepted memory'' and especially
>> > lazily initialized ``unaccepted memory'' is an information leak that
>> > could defeat the purpose of encrypted memory.  For that reason I have
>> > Cc'd the security list.  I don't know who to CC to get expertise on this
>> > issue, and the security list folks should.
>> > 
>> > Unless I am misunderstanding things the big idea with encrypted
>> > memory is that the hypervisor won't be able to figure out what you
>> > are doing, because it can't read your memory.
>> 
>> At a super high level, you are right. Accepting memory tells the
>> hypervisor that the guest is _allocating_ memory. It even tells the host
>> what the guest physical address of the memory is. But that's far below
>> the standard we've usually exercised in the kernel for rejecting on
>> security concerns.
>> 
>> Did anyone on the security list raise any issues here? I've asked them
>> about a few things in the past and usually I've thought that no news is
>> good news.
>> 
>> > My concern is that by making the ``acceptance'' of memory lazy, that
>> > there is a fairly strong indication of the function of different parts
>> > of memory.  I expect that signal is strong enough to defeat whatever
>> > elements of memory address randomization that we implement in the
>> > kernel.
>> 
>> In the end, the information that the hypervisor gets is that the guest
>> allocated _some_ page within a 4MB physical region and the time. It gets
>> that signal once per boot for each region. It will mostly see a pattern
>> of acceptance going top-down from high to low physical addresses.
>> 
>> The hypervisor never learns anything about KASLR. The fact that the
>> physical allocation patterns are predictable (with or without memory
>> acceptance) is one of the reasons KASLR is in place.
>> 
>> I don't think memory acceptance has any real impact on "memory address
>> randomization". This is especially true because it's a once-per-boot
>> signal, not a continuous thing that can be leveraged. 4MB is also
>> awfully coarse.
>> 
>> > So not only does it appear to me that implementation of ``accepting''
>> > memory has a stupidly slow implementation, somewhat enshrined by a bad
>> > page at a time ACPI standard, but it appears to me that lazily
>> > ``accepting'' that memory probably defeats the purpose of having
>> > encrypted memory.
>> 
>> Memory acceptance is pitifully slow. But it's slow because it
>> fundamentally requires getting guest memory into a known state before
>> guest use. You either have slow memory acceptance as a thing or you have
>> slow guest boot.
>> 
>> Are there any other CoCo systems that don't have to zero memory like TDX
>> does? On the x86 side, we have SGX the various flavors of SEV. They all,
>> as far as I know, require some kind of slow "conversion" process when
>> pages change security domains.
>>
>> > I think the actual solution is to remove all code except for the
>> > "accept_memory=eager" code paths.  AKA delete the "accept_memory=lazy"
>> > code.  At that point there are no more changes that need to be made to
>> > kexec.
>> 
>> That was my first instinct too: lazy acceptance is too complicated to
>> live and must die.
>> 
>> It sounds like you're advocating for the "slow guest boot" option.
>> Kirill, can you remind us how fast a guest boots to the shell for
>> modestly-sized (say 256GB) memory with "accept_memory=eager" versus
>> "accept_memory=lazy"? IIRC, it was a pretty remarkable difference.

>I only have 128GB machine readily available and posted some number on
>other thread[1]:

>  On single vCPU it takes about a minute to accept 90GiB of memory.

>  It improves a bit with number of vCPUs. It is 40 seconds with 4 vCPU, but
>  it doesn't scale past that in my setup.

>I've mentioned it before in other thread:

>[1] https://lore.kernel.org/all/ihzvi5pwn5hrn4ky2ehjqztjxoixaiaby4igmeihqfehy2vrii@tsg6j5qvmyrm

We essentially rely on lazy acceptance support for reducing SNP guest boot time.

Here are some performance numbers for SNP guests which i have here after discussing with
Michael Roth (who is also CCed here): 

Just did quick boot of a 128GB SNP guest with accept_memory=lazy guest kernel parameter
and that took 22s to boot, and with accept_memory=eager it takes 3 minutes and 47s, so it 
is a remarkable difference.

Thanks,
Ashish

>-- 
>  Kiryl Shutsemau / Kirill A. Shutemov


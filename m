Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CDDCD1292
	for <kexec@archiver.kernel.org>; Thu,  4 Apr 2024 18:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YVtlbK6PbbeIaoYNeO8bHFzFcU4TtW7Lu2XNRDUdOWo=; b=JabAaMwywVdbO+WLcZy+0yMBFk
	CSBbliLwLJ/nCOCuj/lLuBMt9cd8wxCVflP4GN7LjboX2qWQWWVUi+/TEfRD9tSeCMC+HiGQff/Pw
	VJAq5XYvO+NcMYd3JPZUT8eeMKD1D289yhL35ttEKpz5ncp5NSDvAFnf0YuZL9peSBAqDvouQqO34
	DxgfPpk2MR54HfGE6zt4nxLrp4XWqloIEtg6dDADMpIID0qIC4VIaW7u8GpnsRAvjQUpVZYF+ix0t
	ddS+GW+O233naF0i084sy08AXi1fNiC7z8ZGRrucWwmH0KKyixwGA5UpBpl929VyMVoiXooW6vb0/
	LuVBz38g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsS3q-00000003tYw-0Qrg;
	Thu, 04 Apr 2024 18:43:42 +0000
Received: from mail-dm6nam12on20701.outbound.protection.outlook.com ([2a01:111:f403:2417::701] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsS3k-00000003tWT-2SMG
	for kexec@lists.infradead.org;
	Thu, 04 Apr 2024 18:43:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wen71DAfotUrAqv+VmC1sVDfZ9TrgQM4TUI3PJZixzp31IBnZHKUQhsZmBBS6O2iJKExTv95l5LZMZieLK0Tp7zXpFSA74aCdhUnbjbD46qfpnFUQNaAMMMzLxJrpWmbciT+A2UyoWxJAmzm6clO/LpHWHRlYhvURQFpS4AMP1/XpGcDGjocyTaYwRtixhZSsI+SdQM2QzWwxHCrbz223WH5BueG1TT624gX40WYlMScs1qE0/Jarf+d2abfcjok41373QGMQMNb4q0R7ZoA5YO3SQceOdqRD7Eg+QDBXjd/ycdWs/J5VWZ1i1wUUuAw8jPJ6MIqAfd0QMlpm/3x+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IblKtkvj/arGfeMUgGJe8MU+MrENnTAPN/WALzNli8=;
 b=X6kqlto2gON3vXbOuDCpPy0dOgjg5cw+aykfQDCWymb86MT/tY2zNG6r53hGMhSMhod1vGvMNYU2y1EFb3LFpZhF6rS9f+LBp+ycYuUNK4oMOpmdSgJ2J5dinFsmDDt6KnFp6lJ7QNWkEufN4R2D0hPWGtDLwVh7E3sS2ndE0hUZdcNJHs9wQol+xOCWlq05jt3Sz/d06ze7AsqJcXLlsyA6aCh9Azo52AInMcw/CB/TRu/f9yh4RiubARZDTV8QU9ZLLkqbnLdiJCelAm+jikkG9cGnJoCfuTyTCyyCV/7KLh248/DcCrk6s/xsf+L7WvWs4cMPBXMaSTncrHypzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IblKtkvj/arGfeMUgGJe8MU+MrENnTAPN/WALzNli8=;
 b=HU8ewiGIQElnzptcup5mxU+XPjfnr/j9hAUnCaKwbXsulmZsD0ktB+fDqhe1qGiO6BBLMLcUeyWg5QWmgZXDGZcaSfcbv9aZ6HT0fXhLpc7DYW6nALF67L/mIDSA8K3U8mBNT4WwJlN7jwXRijlDL6Pjy2kidNbvP0vje/G/hug=
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SN7PR12MB6887.namprd12.prod.outlook.com (2603:10b6:806:261::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 18:27:50 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26%7]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 18:27:50 +0000
Message-ID: <bdeda1f9-b7d2-4bc3-ad20-342478be464b@amd.com>
Date: Thu, 4 Apr 2024 13:27:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv9 00/17] x86/tdx: Add kexec support
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>,
 Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
X-ClientProxiedBy: SN7PR04CA0089.namprd04.prod.outlook.com
 (2603:10b6:806:121::34) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|SN7PR12MB6887:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: au8YtzuSBmn5RiBXr6d5qpPT8AtT+K9Xsr/OL/k73i6rFMyBfPBK4vOIK1uQGc6syqxioBYhimnFjtnM/5bQZPJ2liR7Wf/Wx6JYgsg353UOL12rmHEFEI+IziEQJowuPsYFFAf+q79avNRr7UkwAsdKhxukOUY3NkJs5KocdzWy5wGthQc+v9JIPn51yZEn3VC83EDUVhN5Z92dZkovjFiPf2kDXO7rNSaIsH+C3itLtqa/NufP+dGQygUZhpxdPL6KtMYtsCSIoax4J4mMKuiZy/DrbzttSF5mLLRz/lJBvnCyefl8GPiPNTl6vzDBDM2mZkWEO/a4tujgtdbUFTY8lliqvUItLJrNydBW1xiWretiDwatSurQ/C8IWhTOHj3pYpNJITHJl8NjZwHfzh78mZhJ3zx1hs7PpyvZmRoN2pXpLc0i8J5+8YIlRjZ6HeIwZJ1QdDXj0AxbBRgsu8nh/cvFw7K0QnZURHFa6B/jS1lJeVyN0U155HDgKb7LKCqJbQCAeoPb9YPW7rvwarU15okOCetdS2IAs4E/snpqsPM3tPgzN9xGXCddvHPvR2MzSU4hFfiTX/7IwzgT2QLeB7eieByJuYDIu37oQEk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wldnc0tEdzBRb2ZNSW5ra0hzYzBmUTdJY0xZUTdSSjE5di8rS3VWOXJMVlJ5?=
 =?utf-8?B?ODJocmk5cXdlSG4xTVdEZ242SVJ6VVFNRng0bktjZlZmTFJBUFZGcjNza2NC?=
 =?utf-8?B?UlF1TWllYUQ1eExiT3RSeTFoUEtiY2NiVHZGY1JqVk9NNGs3aEwvbFhmUTFs?=
 =?utf-8?B?SmJBd1FDWDRUbDJDaVNOSFdKNE9OZVNJWnJYaWF2b212blFWcnk4VUlseEM1?=
 =?utf-8?B?c3Qxc0hVTFpUeEthZloyblQ1RXUyZ05HMWU5aW55emxDVkhXcWhWWmUxOWxv?=
 =?utf-8?B?WXYxVFZ1VFJsZGZyZS8rZ3FvYXpDK2kwVlgrWkpoeGVqUU4yc2xsajhySGox?=
 =?utf-8?B?Mm96cjhlaEJvY1ZFSklqR2lOWGxNWTU1b25UUzN1TFZZenYvUUpxeGg4cmda?=
 =?utf-8?B?TnVCemNJU1lYaFFsamdoZ1NTOGUyZ243T2xLNWtSdVowVXZOWHNDU1ZPTHZQ?=
 =?utf-8?B?b1Z1SklZaHF0aWJPOWo3dXdJN3hEeHpwTG1MQnZaU2JVYjVDR29LUkFqVHd6?=
 =?utf-8?B?dnROYko1ZndOaHlTbzQxWEE0VG1VQnVDQnNZNU5VZGl0ZnQyRjRFbysxaGFJ?=
 =?utf-8?B?V2N0Q05Qa0R6SEF0T0JVM29CRG56RHVzcGJMeFc2R1l0U2MwK2JONGxITkZ4?=
 =?utf-8?B?Tm5mQlZQaFF6di83TXZMWnRsNXUzQ1NSUDRCTkVTWnRoaFhCN0xDd0xERWpW?=
 =?utf-8?B?OU1GUW80ckxvOW8reDFxdUNrUHZTbzhMaDZzTzZQMW9ZejZrWjVWam9oZWpD?=
 =?utf-8?B?dzFJeGFpZjIwWW81ZWJDRzVUeWxXeGpoK2xSMC91ek9mTm1YNWxSSkhrVHU5?=
 =?utf-8?B?dkxReVdEY0ErOXdTNUd2VTUzcHlwWkNOYWQ4a0FUT2Y5NXlMVEpIRjFJTlJ6?=
 =?utf-8?B?ajk0NGRIWkE3eVFYZzZVME5MVXRtMm5kdklQSUtibjdrb1kvNzkwUFZUTUdB?=
 =?utf-8?B?U050T1VFdnNMajNZZHNzYWtLT2MzOFVGd2dCYjJDVWRWNGd4SldoajJNYzVv?=
 =?utf-8?B?RDUxTXorOVlSdmJEOURxQ29ZQ08wWmpPV01VbEVabHIyN0hjc2ZHRG8rTmlO?=
 =?utf-8?B?YkxRSG96L0d4UHBOM1NucWhjY1FGNSs4ZHljdHNpb1ptcElld204Szk2anlP?=
 =?utf-8?B?eXNGMFhEWUNoQ29Ja3hCeDkyZ2s0V2p1d0VjWEZqekxtWWNTWE9URnA1THQv?=
 =?utf-8?B?bVE4M1FBSi9iNjRBbFdJT3dPdXREWlhiZDRtcXhNTm9WR2J5MEs5QkNtemE4?=
 =?utf-8?B?blZFRFpLcUU0cXVHamtqYTN6dldjMGY0RldTdEF5YTRnK1J6eGpHWDhkR2FJ?=
 =?utf-8?B?TEUzT2J0bk9rMGR3YVFWQkFWMWFzeEpRWUczOFNqNnJuT1VidTZ3WUluaWwv?=
 =?utf-8?B?MGdxL2xOL2RhVGlBVWpydVFBUW1FbUp5dVJyQ1d5Z0dLZkxlYll2SnE3SENw?=
 =?utf-8?B?djZWWTYxWUhjaE5uME1rYUs1VHlDWnFFZ3BKb0wrQW1aREhGUlBtUFFzUHdp?=
 =?utf-8?B?VVFCalE5aDVJaGpGZHp5OW1TalE5R3pMSXhsQWxLbGhCc292RFVpYXRyUVR2?=
 =?utf-8?B?dTJQQlFweXJ0L203QXovS2hpZkoyYjBGVCs0T2NLYWJGdkREdDJ6VHpZVmNT?=
 =?utf-8?B?Wk9ScGpYbi9uaHFtcHAzcjBlajdqa0N2S0NZNDdvemE5WXFuZVg4V0JZakFR?=
 =?utf-8?B?VENRVENyQmRVdHNkdkFleGtTS005UWI0elV0NVMydzNFanlWV2JQVFFPbDZ6?=
 =?utf-8?B?M3I5REpiV3RZUjY2dFcxUlh0NXV6dWZnRCt2Wk5YSXRDT0dvd2thRld3RHpm?=
 =?utf-8?B?UTRtL1RqV1p0Q1FXc1dwMlI3WFVTalRnNGhzSGpBaUZMeWFhV1htV2U5RkZU?=
 =?utf-8?B?TENTaFByMFRETzhnejFFNkZ2QUNBWnI2L21PN2RPTjdrWXhnVzRVNiszUSs1?=
 =?utf-8?B?NDZ0bUtYWEJNWUtGSjVhRW4vM3VMVmRGZzFEN3ZkYVRNN01nRHhwRVdqVzBQ?=
 =?utf-8?B?VmxVYzcrb1dLamhobndJaC9WTlhVNlQxQzhuVzFEV1phdE9vdkdpaENFNXFL?=
 =?utf-8?B?dUtzd09rMEhGLzdDeCtRcHZ4eXpXQ1RVWDhTMjRDUWpQMXFUNmc0K2ZwTUxJ?=
 =?utf-8?Q?t28MUpPkg5VtFhUBL/YxD7drN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1ec640-0bbf-4cf8-6f5b-08dc54d4ef69
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 18:27:50.7992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifx+Gy3Orh4OGYri39iU9D0ZlagN8rIrBkjKFPsKnjkpmeoJR3bIuFI7ACCus2UKoSVcul46TIpLSWyZA8t5og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6887
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_114336_717905_60CDC811 
X-CRM114-Status: GOOD (  24.22  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Kirill,

On 3/25/2024 5:38 AM, Kirill A. Shutemov wrote:
> The patchset adds bits and pieces to get kexec (and crashkernel) work on
> TDX guest.
>
> The last patch implements CPU offlining according to the approved ACPI
> spec change poposal[1]. It unlocks kexec with all CPUs visible in the target
> kernel. It requires BIOS-side enabling. If it missing we fallback to booting
> 2nd kernel with single CPU.
>
> Please review. I would be glad for any feedback.
>
> [1] https://lore.kernel.org/all/13356251.uLZWGnKmhe@kreacher
>
> v9:
>    - Rebased;
>    - Keep page tables that maps E820_TYPE_ACPI (Ashish);
>    - Ack/Reviewed/Tested-bys from Sathya, Kai, Tao;
>    - Minor printk() message adjustments;
> v8:
>    - Rework serialization of around conversion memory back to private;
>    - Print ACPI_MADT_TYPE_MULTIPROC_WAKEUP in acpi_table_print_madt_entry();
>    - Drop debugfs interface to dump info on shared memory;
>    - Adjust comments and commit messages;
>    - Reviewed-bys by Baoquan, Dave and Thomas;
> v7:
>    - Call enc_kexec_stop_conversion() and enc_kexec_unshare_mem() after shutting
>      down IO-APIC, lapic and hpet. It meets AMD requirements.
>    - Minor style changes;
>    - Add Acked/Reviewed-bys;
> v6:
>    - Rebased to v6.8-rc1;
>    - Provide default noop callbacks from .enc_kexec_stop_conversion and
>      .enc_kexec_unshare_mem;
>    - Split off patch that introduces .enc_kexec_* callbacks;
>    - asm_acpi_mp_play_dead(): program CR3 directly from RSI, no MOV to RAX
>      required;
>    - Restructure how smp_ops.stop_this_cpu() hooked up in crash_nmi_callback();
>    - kvmclock patch got merged via KVM tree;
> v5:
>    - Rename smp_ops.crash_play_dead to smp_ops.stop_this_cpu and use it in
>      stop_this_cpu();
>    - Split off enc_kexec_stop_conversion() from enc_kexec_unshare_mem();
>    - Introduce kernel_ident_mapping_free();
>    - Add explicit include for alternatives and stringify.
>    - Add barrier() after setting conversion_allowed to false;
>    - Mark cpu_hotplug_offline_disabled __ro_after_init;
>    - Print error if failed to hand over CPU to BIOS;
>    - Update comments and commit messages;
> v4:
>    - Fix build for !KEXEC_CORE;
>    - Cleaner ATLERNATIVE use;
>    - Update commit messages and comments;
>    - Add Reviewed-bys;
> v3:
>    - Rework acpi_mp_crash_stop_other_cpus() to avoid invoking hotplug state
>      machine;
>    - Free page tables if reset vector setup failed;
>    - Change asm_acpi_mp_play_dead() to pass reset vector and PGD as arguments;
>    - Mark acpi_mp_* variables as static and __ro_after_init;
>    - Use u32 for apicid;
>    - Disable CPU offlining if reset vector setup failed;
>    - Rename madt.S -> madt_playdead.S;
>    - Mark tdx_kexec_unshare_mem() as static;
>    - Rebase onto up-to-date tip/master;
>    - Whitespace fixes;
>    - Reorder patches;
>    - Add Reviewed-bys;
>    - Update comments and commit messages;
> v2:
>    - Rework how unsharing hook ups into kexec codepath;
>    - Rework kvmclock_disable() fix based on Sean's;
>    - s/cpu_hotplug_not_supported()/cpu_hotplug_disable_offlining()/;
>    - use play_dead_common() to implement acpi_mp_play_dead();
>    - cond_resched() in tdx_shared_memory_show();
>    - s/target kernel/second kernel/;
>    - Update commit messages and comments;
>
> Kirill A. Shutemov (17):
>    x86/acpi: Extract ACPI MADT wakeup code into a separate file
>    x86/apic: Mark acpi_mp_wake_* variables as __ro_after_init
>    cpu/hotplug: Add support for declaring CPU offlining not supported
>    cpu/hotplug, x86/acpi: Disable CPU offlining for ACPI MADT wakeup
>    x86/kexec: Keep CR4.MCE set during kexec for TDX guest
>    x86/mm: Make x86_platform.guest.enc_status_change_*() return errno
>    x86/mm: Return correct level from lookup_address() if pte is none
>    x86/tdx: Account shared memory
>    x86/mm: Adding callbacks to prepare encrypted memory for kexec
>    x86/tdx: Convert shared memory back to private on kexec
>    x86/mm: Make e820_end_ram_pfn() cover E820_TYPE_ACPI ranges
>    x86/acpi: Rename fields in acpi_madt_multiproc_wakeup structure
>    x86/acpi: Do not attempt to bring up secondary CPUs in kexec case
>    x86/smp: Add smp_ops.stop_this_cpu() callback
>    x86/mm: Introduce kernel_ident_mapping_free()
>    x86/acpi: Add support for CPU offlining for ACPI MADT wakeup method
>    ACPI: tables: Print MULTIPROC_WAKEUP when MADT is parsed
>
>   arch/x86/Kconfig                     |   7 +
>   arch/x86/coco/core.c                 |   1 -
>   arch/x86/coco/tdx/tdx.c              |  99 ++++++++-
>   arch/x86/hyperv/ivm.c                |   9 +-
>   arch/x86/include/asm/acpi.h          |   7 +
>   arch/x86/include/asm/init.h          |   3 +
>   arch/x86/include/asm/pgtable.h       |   5 +
>   arch/x86/include/asm/pgtable_types.h |   1 +
>   arch/x86/include/asm/set_memory.h    |   3 +
>   arch/x86/include/asm/smp.h           |   1 +
>   arch/x86/include/asm/x86_init.h      |   6 +-
>   arch/x86/kernel/acpi/Makefile        |  11 +-
>   arch/x86/kernel/acpi/boot.c          |  86 +-------
>   arch/x86/kernel/acpi/madt_playdead.S |  28 +++
>   arch/x86/kernel/acpi/madt_wakeup.c   | 292 +++++++++++++++++++++++++++
>   arch/x86/kernel/crash.c              |   6 +
>   arch/x86/kernel/e820.c               |   9 +-
>   arch/x86/kernel/process.c            |   7 +
>   arch/x86/kernel/reboot.c             |  18 ++
>   arch/x86/kernel/relocate_kernel_64.S |   5 +
>   arch/x86/kernel/x86_init.c           |   8 +-
>   arch/x86/mm/ident_map.c              |  73 +++++++
>   arch/x86/mm/mem_encrypt_amd.c        |   8 +-
>   arch/x86/mm/pat/set_memory.c         |  59 ++++--
>   drivers/acpi/tables.c                |  14 ++
>   include/acpi/actbl2.h                |  19 +-
>   include/linux/cc_platform.h          |  10 -
>   include/linux/cpu.h                  |   2 +
>   kernel/cpu.c                         |  12 +-
>   29 files changed, 663 insertions(+), 146 deletions(-)
>   create mode 100644 arch/x86/kernel/acpi/madt_playdead.S
>   create mode 100644 arch/x86/kernel/acpi/madt_wakeup.c

The cover letter mention the inclusion of the following patch - Keep 
page tables that maps E820_TYPE_ACPI (Ashish)

But i don't this patch included in your patch-set.

Thanks, Ashish


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

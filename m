Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAECC3ABAA
	for <kexec@archiver.kernel.org>; Fri,  2 May 2025 19:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qkbDE6i71z+Yjx7tZYMryfuggtrL7du/TuBpRXcI3tA=; b=zZHb5y2Supxy5alpMvggnM/Co3
	JqywGnkZzUAW9x4yUlDX4lHM7VdlnZZLMwuFUfIHW9dGWZC6vAcDpxYdFvs8BOObjqy2cm3Yp119g
	vJVD0oQCDlsMUq5ahFTmG8UGpe0R+GBFUgIKByryMgNIgFkK8Q8/yC8xxBxmDKmvryThflfCMmp5s
	b89ZAo5sxNRdRiWXAkb8nUYsAC79qOh1EZT1ir25i57OrkvaKlu78wN1V10XNcQ8yVWNkWxS+REZl
	3PX58md6DhXiz9h50in5DToYcdF4TYz1EaEEXC8ePO8f3mYxz8SGIuripb1EVG7iBoGuQf0obu8TL
	hd5mO3xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAwFX-00000002twD-0ivV;
	Fri, 02 May 2025 19:40:43 +0000
Received: from mail-bn8nam04on20615.outbound.protection.outlook.com ([2a01:111:f403:2408::615] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAwFU-00000002tvZ-3szm
	for kexec@lists.infradead.org;
	Fri, 02 May 2025 19:40:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJli6Bs35z00IhMZMWQtcEWvfbT97ZbvUHIV3+sGVNQFZ3HylsdK7yP11f+Y1pWFHkv/bW9XbV/Otp153uEB9I8/D2jbi2GOkYVwacp0f9f2BJ/NZ5Afyd9w4GLuFm49qelN+la9zpNmq0ZK0+wH57N7+S3TXCNgK13os7aZB3uvL5Up7r2RBzfglCeu1VggjSr89TNT7E6ipx4VvWP9cf0Fqa3Y9oxLHoXduCmylOSQZfaHctQ7pVBG/uPFCxtadzQ6487AGDmlcn/FE8WYeHRIY2k4UW1k+c/Tz94FVM+M/UEGcvThfhf4mrE6as2HmoqGaO5e/aJzaYu/VQri4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkbDE6i71z+Yjx7tZYMryfuggtrL7du/TuBpRXcI3tA=;
 b=RXEpB9MSIHuQRIOgqajtA1o8lzS2+ytMY16by7l+oSjr1fUiGVK7kZUo+9o3gXsaMmjrYG6uKsZkvFqEv5qTJVeg9qIl3CeQkNaHfZSPOm+0ciNn1oteKIZiU31J5L4FCGqWNmeZMYWEaJ2mxbrSGUIL8eC8Gtcmjfl++zduasXJdXgIH4jWnBm/g6kNRc750kgk2LytgnToAuOeMJ1RdPrVQ8JDDtFJnLwS7gjwowkcpz6mXMknVpW7L8Ki3Me9brvB3NnUUMaYuN/Oe7yuJlRzFuRNePe5HdPfZ+V/CstdKCFQhK37Rbd3i2o59yVmFkWtJk1yvKcD42VbfwnvkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkbDE6i71z+Yjx7tZYMryfuggtrL7du/TuBpRXcI3tA=;
 b=OuNmIU/kdkj1TXh3qJcvOPaqvCJO8o6xtmzEK5WA+J4L1239gafOVACMu/HdpcJjQ/rxm1O1Z+iZctA+nGs6VIhJoXXTceTGDT51Qsm87Z3ocnn7NPpJbjyFvFsDO7xzhSBVTGS/iEiARX20imTW5t9aspii3FJ6so6QiGhqOMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CY8PR12MB7729.namprd12.prod.outlook.com (2603:10b6:930:84::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 2 May
 2025 19:40:35 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 19:40:35 +0000
Message-ID: <18d4f1d7-0b40-06eb-f328-fbe198a2832d@amd.com>
Date: Fri, 2 May 2025 14:40:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] x86/sev: Fix making shared pages private during kdump
Content-Language: en-US
To: "Kalra, Ashish" <ashish.kalra@amd.com>, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, bp@alien8.de,
 hpa@zytor.com
Cc: michael.roth@amd.com, nikunj@amd.com, seanjc@google.com, ardb@kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev
References: <20250430231738.370328-1-Ashish.Kalra@amd.com>
 <633b73ac-8983-fe38-dcdc-0b6a08388f5d@amd.com>
 <dd0cfca0-44a1-436b-a115-44ad02369850@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <dd0cfca0-44a1-436b-a115-44ad02369850@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0150.namprd11.prod.outlook.com
 (2603:10b6:806:131::35) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CY8PR12MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: b1e35219-213b-4c53-f531-08dd89b13472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWNJamF1L3NqVFhjZUs0N0xrMEc0ZnRucVNLWnhFM3JpUFVGVWlCV2FlVGVN?=
 =?utf-8?B?dENJTU9TYW04cXU5TDZOSk1nbC9TYnRzQWZnMURJZW42VytGTUtYZEVSd1py?=
 =?utf-8?B?MVhJSld4WDVIUmNlSC96N1ljMU1ycWVlTEZkQmxpVStyeHlLcllYUlkxdWl2?=
 =?utf-8?B?UFBCNUdLWmtaL0lkOWwyYW1QdC9lZkZ5NnhwUll4NFYwMkhES056d2F0Titx?=
 =?utf-8?B?ZGdqVmNZSWhRZXBFSlpZQXBSeDlJRGxLZzJyejJLMUUxRGliMEpnL21QVHRz?=
 =?utf-8?B?R2d1MXZJRU1VTjlFSktML080NmFaYU41QSt0bUo5cWNXb3JjMmVKT2ZVTnpo?=
 =?utf-8?B?a1pYQjFyRzBJMDhabStmRU82MCtRdlJFUm1RV2l0TkVjU0hydlMxM0FoQWlR?=
 =?utf-8?B?M3huU2h2YVBLdTdibDVGaThjQko3TDhnQnBORE14bVRxN0xNY2pzWEZPR25w?=
 =?utf-8?B?RHgzR09nYUZDZHJLL1N4MjYwYURiWEhGZHNITVRHV294dmhRWDVkZ3NIWTE0?=
 =?utf-8?B?V1JsK1BjL3BiNGhWc0JYeU1VbWlCZUV0Nm0vZlFZNkduK1BtL0VRN0FSeUxR?=
 =?utf-8?B?aFNSZGVCOFJMTmw5UitTQ0dFc01HNkVuQ1A1T0ZtdURadlpCV1dhSzUzTHRO?=
 =?utf-8?B?MGUvMjF2aGpvd0hneGNJazhvMVhqc2tvQWZ2NzZ6UFB6YVlMRURWTm5ORXJM?=
 =?utf-8?B?Wm1JRXNxN0hiMzFYQythRDBQZTU3ZVFBVXN0b2htWDFsU0FmTzJUeUUwNUpD?=
 =?utf-8?B?L0l4WlhDNFFLWkpiNVNpR3hUSzYxYWlqQUt6d2s5bk9BODFFUG1Fa0xEakpE?=
 =?utf-8?B?V0dSZThITWhtWVFJb0NpalAvbHIwS0RaM3RZL0pMSUtpTHVqQmswYWIwUzU1?=
 =?utf-8?B?N251RFJxS0lWY1dWa0hVZnFXWmRkZ2ZHR0FXd2RYUFFVc1krekdyTVcvd0xh?=
 =?utf-8?B?akErOHNvQnVYU2JyZWhGNmZQbHNzVlhaQ2xsaXREVjZ0NnJ5UXF1M0Y0eGhV?=
 =?utf-8?B?a1dGU25xOWJlLzFFQjVzYThhb3Y5bFpIWStBSHMyYkhDMUhCRzN1eFBVTVBh?=
 =?utf-8?B?T1d2Z1RqN210dDRtbVZzOFVHVGg4UlM3QVprNmtTdGl2aTBXVEluZjR6blBr?=
 =?utf-8?B?eG4xa3gySGt2RnhUUG4yMHIrcFFHdmM4YmpXVHE2amNzb2pKcmkyNkxJQ0JT?=
 =?utf-8?B?L2tUbm1neSt4NjYzSUhKb2dKV2RGNG9pZzU4WVlacHdaKzZsMUU0M1lab2pt?=
 =?utf-8?B?WkVyWUF4RTc3Zkk4ZGc1NmJCTTY4Ujg2eWNVWTNWZHVsSzhDSGUvcDhVN253?=
 =?utf-8?B?dUV1UExzb2FLRzloR1ZpNFpDQ2NJSTY5K0ZqZ0VGOC9nRUhON3ozb0hqWnB5?=
 =?utf-8?B?U0l4QjJUNUVxUERzT0dMelp1a1RXRjI1M3E0QmxPbzdZSFU2OXp1aExKZTBs?=
 =?utf-8?B?QVN6czVTREZtRldYWUFoTVJKWDQ2TEVpOVpmYVNGS0tMOXJRRHoxc1dPdlNB?=
 =?utf-8?B?ZzZmK1BtTVBUTW5iZCs2WFZ0ejhDd1k1aXlmRlIzbkNrVmhZUnNKRGVJNmxj?=
 =?utf-8?B?NHhVcDVlcS9LM3B6aWdKU0M1enptdVBQeGV1RzByWktaTDlzYWdEZmhwVHFn?=
 =?utf-8?B?ZlBwWStlMmREdXIwd2szRCt4bHRnMTBaM3FKdGJZN3ViMjR2K2Z2N0EwQ09v?=
 =?utf-8?B?azEvWTdUd1A1ZC9vRmpYU0QzTFdSQ3ptWkp2VDM5N1FoZGdrRTRDaFF6QzFO?=
 =?utf-8?B?TkM5WVRETlNjZXY5bTZsUGR3elNKWjdIL2ZqZVBJYjlXUFJEVXlRY0ExUWNq?=
 =?utf-8?B?SjdocVRKVjR6MDhQN2VnYVRNYmIvdDgxVTczZEg3d3dLMXZhdlI0MDFtb0lI?=
 =?utf-8?B?TXVzQk5ubTNEd00zajBBN2R3N3NMQUQxRllaalhJRGlBWm00ZzlqZ2MvN1lj?=
 =?utf-8?Q?xVYsth6epe4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFBpNk82dndOZmpoNVZRWjN6eGRvU0VCVFdlejFtclVtSFU4dlVrV1pvZUJh?=
 =?utf-8?B?cTVrc2RhZU5qQ3dHN3V2MytjaGtDc0hGUXlhbkx2aXhHUkhQak41Zm1DbXpY?=
 =?utf-8?B?YzVYS3JXdTJyNzUzNktUcmdnLzJBZ1NvTkZmZG9pZWxkNlpwYWEyOC8rRGlr?=
 =?utf-8?B?NXg3N3lWS3JZVk4yN3FyK1FkUWU2WDRrNFY3ZGJhci9WM1V4Qmh2VU9XVThu?=
 =?utf-8?B?WFcwVlpWdTZ4WXhSYUd2TUxCaG4rV05yRnVCSVcxSnlJZDdteUcxN1NDY3lQ?=
 =?utf-8?B?eW0xVVEwRjN6Qkl5ZHBhMlBRc1lvMWxyVGxUdFNqVjIrUk51SUtVMzIzWVZp?=
 =?utf-8?B?ZHhyNG51K3AxUHNVMGhzRTJxamt4NEorazJzYWpudjNJQ0NWSC9OajBuZVJu?=
 =?utf-8?B?dHlwRzdyWU5Kekw5VmFkRXIvUlYvQUZIRWtoc2JQdGE0Z2svUGQwaDNaZFR5?=
 =?utf-8?B?Yyt1VDgxWnhCUE8rZlFaUldPU2kyVERpbFh6d3VET3dkQnVZUVYvdjhhTjUw?=
 =?utf-8?B?bE5ZR3FQTC9XVTJHRWY2WlhUNHBVR005ZFVYVlNJLzQ0Sm1MWmh4bmN2WnYy?=
 =?utf-8?B?SlllU05GZ25hWHRMU0VaRWZwZks0TW9tWWNYZ2s3STIra3FPemg1dkxnOGN2?=
 =?utf-8?B?bXJvU1RIZ0VtQjRnclgyNmpFR3ZXZllLK1pGSTBROEczVW9nam5tQlRIeHdI?=
 =?utf-8?B?dzJnbCtpYTI0Q3Q1eEw5VkxFajFYbVlUaTd1T2VWMmc1dmo2YWNkcVRGS2Jh?=
 =?utf-8?B?ZTVmSUFsM1lmSjhRSEl5VXVDQkZEZVZDaERXMWtGTGVsNkQwSGRjU3ZCZ3ht?=
 =?utf-8?B?MXVxVXhSZG9GVUM3OEl1Q050QzE0QWZFZVpmREthK3Avci90bTBLUWdWSG80?=
 =?utf-8?B?OFQzUGFlVkp2ME5Yeko4Snp0TW5ubWR1dCs4QnNDWWxlL1liRFIxc3A4bStE?=
 =?utf-8?B?N0VsTWYwM3dtbE9tODJjaW0rU05ZV2pNNFBocG84dDBmZWdkMFBTZzdQcThi?=
 =?utf-8?B?OXMyd2RiT0NwR3JBNlZSQ0ovNXYwSkI5TDlCZ0h5QkFwMDRNVjlIOTd0dGtt?=
 =?utf-8?B?eDZMZGZlTWgrcVg0dkNFSDNUOWtVbHo5OXZrcGFWakRPWWt0T0NiMGxaRjJ0?=
 =?utf-8?B?NDVScXd1ZVovcit1c09rNlM0cmxDNVFNeGc5cVpHOVREcjFYNW5zbXVwYnpK?=
 =?utf-8?B?NW5Dbi9GYW42cnBCL0JrMSt2dUFmZVF6SExCMDJwYTN1T3BCUU1xN2s5OTk3?=
 =?utf-8?B?NHowMHpiQ3IzbTdhRDJ1bjd0TFF3cmh6V1hYOGRiRmJJenpkN2Q1K2VCdU1U?=
 =?utf-8?B?QUJuNmFQbnE2cTU2QnB1QVFhU2RoNlZvcGl5eTV5bWx3STVUaHFJMkJKRjdr?=
 =?utf-8?B?ajY2Rmp3bEh1Q0N0dkZiUllLNGJIUzZwZlBNWTVBblZuaUVybm9LRkJBMGdt?=
 =?utf-8?B?MG9MUzMvTE9vWlYreGlnN3ZDaFBsdjNRc3lmYWxBR3VGeTFVbTY1b0N5UklK?=
 =?utf-8?B?RVNMRWI3V0lJUVlEKzZLdWVVWDExcEZ4RjREYXRYNmdDMndFajE0OUQrbnQv?=
 =?utf-8?B?cEQyMFpjRkw4bC9CN0VtcklpbDcvbitKRW9QVy9LRHJqaERVcGtxd3BERVE5?=
 =?utf-8?B?ODZlZURGcGZwdkRCbnh0Nkwrc2ovNkxpYTQ4UzBiSTVrWXRrTkJNMHNaZjVM?=
 =?utf-8?B?ZzVqSlZwaFFXdnR4M1pkOSs4K0dDdkhBKzhuWGFGMGZTR2c2emdiWWdPUC9j?=
 =?utf-8?B?N09PNUJ5elVaRis3OWVnYUtlNWZuTFNMbkRPS3c0d1FpZzJhQ3phQXozWjlD?=
 =?utf-8?B?Vk5KM1FDaU0rU05teTFnYnB1R2VpQVFOVEYrcW9SNCs5WUhoRzNwMnNqUHd2?=
 =?utf-8?B?NUsxZ1RNNEtKYXp6dCtwUm9DeE10S3B2R3FSUU5Wb1kvWENmMXlWTmg2V2xZ?=
 =?utf-8?B?dzUxdk9Cc2hoZmhpdzRMN3VXN0dLd3NsZzJ3S3U0ZFJwenJxSGhQam5vVzk0?=
 =?utf-8?B?YzVvcGgzMUluS3VxcXZQMXI5VTdEbXNsUVM0a3U3a2FqNUFDUXJyQ2xDT2Rx?=
 =?utf-8?B?OE56c0wxd2tWTVRuWnNpVG1NOW16YkVTKzl1T1J5S1JsZGJycWFqc0VTbWth?=
 =?utf-8?Q?ZDA6TuZV7pWVZgxsHFqwzwcwQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e35219-213b-4c53-f531-08dd89b13472
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 19:40:35.2009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJTH8zU4jnJHhm9bgsi+qQsu6A4joX2+86npBPzAqKV98GNowVvTbIRyE4fQrKXO1vweQqykS85n3xCrgdeB+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7729
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250502_124040_970434_D00C3C01 
X-CRM114-Status: UNSURE (   9.63  )
X-CRM114-Notice: Please train this message.
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

On 5/2/25 14:32, Kalra, Ashish wrote:
> Hello Tom,
> 
> On 5/1/2025 8:56 AM, Tom Lendacky wrote:
>> On 4/30/25 18:17, Ashish Kalra wrote:
>>> From: Ashish Kalra <ashish.kalra@amd.com>

> 
> I agree, i really don't need the check as i can simply apply the mask as
> the mask is based on page level/size.
> 
> mask = page_level_mask(level);
> ghcb = (struct ghcb *)((unsigned long)ghcb & mask);

There's also a lot of casting back and forth with the ghcb variable. It
might be better to define it as an unsigned long and reduce all that.

Thanks,
Tom

> 


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CE2C25B76
	for <kexec@archiver.kernel.org>; Mon,  3 Jun 2024 17:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M6K5oqUhx2thayOKyIWZKvXX9asYK5BFhOvwqyRJBec=; b=xkM0JgzGHc0X42VHdPA98WgJJX
	ydNhPNWnR+T2vK7CFanexwbPmN1S6sfqy8G052HP24bfkt0NEiZcCLcT55mZ1y5mzNy8qUw+TL2Ow
	3wSeW8z14DLoBNdtUZS/x+15RL2gA8vNwpbv/7vmmPTfnR0EA8aKvCErmMJQ476iQVW4R7csv2Y4l
	s2WGoQr63xGhdu0Z2ULcYt7np3By4D5fblU6A+9VlvBui+yCcKpGncViIzvRFEZJkB3FynTDwvanT
	GsC6iowV4wRamof6bpVOBeo1SNKppBqpPi08oTwZQbFWH1UMkr4SS04nhHPYWPe64WzxLn0aPkYC7
	oRg7kqNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEBB8-0000000HSje-276C;
	Mon, 03 Jun 2024 17:09:02 +0000
Received: from mail-co1nam11on20600.outbound.protection.outlook.com ([2a01:111:f403:2416::600] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEBB5-0000000HSiD-1oNp
	for kexec@lists.infradead.org;
	Mon, 03 Jun 2024 17:09:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbALelLQyJnVCZmLSF5k2J4bj/PSDwCBeXFBLz2HhkJR0zLJ7OK2QxXKmYvXAIXUpZnnSehXxNTXqCEbsf8SB+Vj2tKy6gzY7H8+RMHaTkzJ06CQnD/Ep/7MmQGysriOjwRcDxeluFVkSQeAAcFZbSm8yooOhaFYht5Ap/OH4urL4SSOyYHxbLIgP2MlJWcDW6gQ2H7XyygnTY7DDa+VEtNy3x3AUX0F7ZchBhDblSkq/j0CAX9rw73iq549LdQb32HpO3NV8s64QVUEI9iUN8LWyeN3i0aDvIQZkfsjzom6t7AVIYRShN2bYRM3Y6Q7Va+DuWZScD/c7uc59AeF0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtrVm5yCPzIR60/m0QEKpgkKFYZkAsA1vNGkgvvhQjU=;
 b=as79mYrlFkwfb5yUizbD2Q9WEXgrn9bKEhKAfmCNsxbK/3c93Y3wttAxu92wqUksSGsd5scrgX9Gs48CRvgwc48rU1E5ItZPDCXjL5bq5+yQigPfxlTjRL+W/xpNy73JaHayAykZsCUg/SKJQiWdImw/6cHtjWi/r5fKiX7FGdN0cCE1QYWovMXviF2WFwABuZ/jlQGyXaF2N6MeO2jVL8FxS5VW+0dQckK73wJbUf925nYXUNStIfKhwDYb2MalsvIC4nBj6LIKH6VuUuQJPM/QAjqzGTnzMkpdrvQLiSq5ThztGbVESVTF0YKssj2IdTn7LzwdguuDLjTTEmrtYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtrVm5yCPzIR60/m0QEKpgkKFYZkAsA1vNGkgvvhQjU=;
 b=ZGjIkvLDN0Heiojk4Lg4WAE3iUXC3WfIscrI2gEDbXWxNRw7Q92dVw2V2ItkOcpfK9Wxj8GG7oJYLAkSbw7b+beHEziRthSHMvwwTxMfHlqwiUJcWW8hJaHUZFva2h61aNesZJoI+0kJpcO3++gfh7VyKPmEMwVyNdpAFucK76g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 17:08:52 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 17:08:51 +0000
Message-ID: <2343889c-887a-49ce-86df-343737d70d37@amd.com>
Date: Mon, 3 Jun 2024 12:08:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: Mike Rapoport <rppt@kernel.org>, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, rafael@kernel.org,
 hpa@zytor.com, peterz@infradead.org, adrian.hunter@intel.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
 rick.p.edgecombe@intel.com, thomas.lendacky@amd.com, michael.roth@amd.com,
 seanjc@google.com, kai.huang@intel.com, bhe@redhat.com,
 kirill.shutemov@linux.intel.com, bdas@redhat.com, vkuznets@redhat.com,
 dionnaglaze@google.com, anisinha@redhat.com, jroedel@suse.de,
 ardb@kernel.org, kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <cover.1717111180.git.ashish.kalra@amd.com>
 <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local>
 <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com> <Zl3HfiQ6oHdTdOdA@kernel.org>
 <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local>
 <Zl3hwYL2GDiyUfGo@kernel.org> <7eb4ca99-679c-4f23-9562-a39b966c28a0@amd.com>
 <20240603165747.GGZl32C9yrmXJ4nhPT@fat_crate.local>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20240603165747.GGZl32C9yrmXJ4nhPT@fat_crate.local>
X-ClientProxiedBy: SA0PR11CA0122.namprd11.prod.outlook.com
 (2603:10b6:806:131::7) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|DS0PR12MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: 71040401-c488-4b66-a909-08dc83efd761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0NUQmVPcmh1a01zOXhEOGJaNkQvUzExSmwyTVFkK1pQUUxocTV4R0Q4UWJF?=
 =?utf-8?B?Q0ZYTzdHcUl2WVcrSmxVYlo1VU9ESURiaFRTYmYzblMxUlRNNEVKY3h2bmtQ?=
 =?utf-8?B?RGpYbEQ2QzRMaWgxY0F1ODJQeVdtSFYvK0Zqb1NKQXB5K1VhT1JrbkRvK2Vy?=
 =?utf-8?B?TDdFaVNpSjg4Ulg5aE5zeUFrbDhlQSs1ck94OXFKVHZ0NCt3eE9pOTIvZm9P?=
 =?utf-8?B?cTN6bkc4RXlUdzdwdE5SQ3daOHNyZTA5bGUwY3RmZk0yOWo4L0s2bXRwR0Nw?=
 =?utf-8?B?ZEwzZ0x1VmdFMm55Z3B2ZWpiaE1jdlM5U0tLKzNoYjBFNXZnOS9TY3VOeklk?=
 =?utf-8?B?WXVTdVlSb2hYUjBBR09mSWJ2ZHViRXpvRzY3ZWU0cklLamVPbWthQW85MzUv?=
 =?utf-8?B?eXRBekFjUlFyTXhkUUgrcTZKeTRoT1JERTBnZ2Z4L2h3UlFObnVVbU1nYUVF?=
 =?utf-8?B?RTY1ZkpRak4yTExHM3lCb2wwZzV1dFprcy9rcXptT0d6QS9ESDBlOEN3L1lS?=
 =?utf-8?B?anFFc1E2NTNaLzBvODQrU3RFM2hHMUJpb0lJZ1EvQmd2UUtYaUJ2UkpEVTky?=
 =?utf-8?B?QisyU2FNVmVBMWZxaWhoZzNWSStHN3JvdlZDVEJramZnd3d4Q2pmVzEwaWNI?=
 =?utf-8?B?dnFDMmx1YU45RWRvNkdDQnBWSnVqQU1GU1h4TThQc2NhZFJZOFJ6cmNwZlh4?=
 =?utf-8?B?blhFTWZBNms1ek94ZGIzWHZ3N1RVQk5naGxMWElZODZqb3czSEs2TkkxME4x?=
 =?utf-8?B?bkJBaHlqR1dtVTdIYXl1MmJuNUlhSnM0OGpvZFdrQ0ZxcmpIK2JzZ3hSVll6?=
 =?utf-8?B?Zk9iMENQdjFPL1M3Sklja0pFeTNtSVI3d0ZLUlB3d2E1MEFSSjdWblhFd1RL?=
 =?utf-8?B?Z0lRVU5FZXpFN0tPSzdxT2ppK1Bhc2NTeFBZNllSaFJ6enl6MFhGME16dkI4?=
 =?utf-8?B?SjFuSlhjWGlWcWhXZDJLbnYzc1c2T015dEF1N2lQKzVWYWptYlJHUXRaWUh1?=
 =?utf-8?B?aXIzejY5dFJZNzhTd21JMGZJZ2RoSnFvWm1NKy9PTUkvVXZQTTZ1ZXZiZ3Ev?=
 =?utf-8?B?ZmxrL2l6aEZEVmVmd3NlQ0pGM2pwdXVrdk9YaDhud1BzZ0JhTUc1MjZRVUZu?=
 =?utf-8?B?T205Qkp1a0hlc3FSZDJJNjFKeWh2WmZqNEZScVhRUHVZaVRjMktNUlVERity?=
 =?utf-8?B?OW80bFZsWkcvSkovVXdGcTRGUCtZZ3ZIcU03RTBiMEVrQ0V1Q2dDcWh5VUZ6?=
 =?utf-8?B?Qlp3RkN4SEJ2UlFGUGM2MWR2V1VHK0M4TU5OSlVaYklHSldjZklLWDBpRVRG?=
 =?utf-8?B?MEpIcmxud2cxOEY0SVFYemtVM0dKeXlsRmpoMlREbVJIeDEyRFpaYWxPSElD?=
 =?utf-8?B?WVhTazRpL3d0d0h6a1FnYlBKTWlNU0d2K0hLYTZZRXJsdDZGcTkvaDJ6Z3JK?=
 =?utf-8?B?aEJpeDFYMzVtdjBucnVFNzVKbHMxOElmRjJKV2ZqTUJCYU5YQ1FaM01mMVVz?=
 =?utf-8?B?NjFCQUxhem1YRFNkWlF4K3FlWTdwR0lVbnFHT3crRlhDZFk3RHNGMWd1VEEz?=
 =?utf-8?B?NWZRcFk3MTlqTzJNcEYrRWFvQUxmMm02U1FnalAwMDFpUHl3Q0dJbzkyV2Ja?=
 =?utf-8?B?bEdHUVZBNEhQVXk0Rm9RbGtweGJaSDVQc28rb2ZkakM4Y2ZycjA3dWFZVDlH?=
 =?utf-8?B?bXFINW9KN1dWazE3YUlkYjZOUEhhRkhQbE9XL3ZaZFRDRHcxVmRhTmpRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3pGTnAyZ1R5SVppT1IzL3pRcjVtWmM5WTVjeUloclRUcHVjZDRMd0xZWllJ?=
 =?utf-8?B?YlZlLzZMaTdpV3lkTnRncjdIOWV6aFl3ZjFQbWpJRllaTW8rVFNhL2Q1M2Zi?=
 =?utf-8?B?ZENQWHlUTlNvcmRyekdiWUZvM0pBRno0Y0lzMFcrUElFa2JLSzB1UmVDTjlK?=
 =?utf-8?B?UHI0TEtLa1VSNnUrQ2pJSWdSUHpCOVB2VGd0KzQ5TnB3Rm1US0FqY3lkYlhU?=
 =?utf-8?B?UCsvRCtWYnZpcnd1bEhEa011MmpXMnJ6RHRMZFo1Y3NzRFBxSEZQMDJNWjZn?=
 =?utf-8?B?bk4vRlkrOSt3VG9xMEZRMVZ3MkdMVzljMVROWldYT1N4d2I5WVRzSW9ybzYx?=
 =?utf-8?B?czhURFdvYU9hSlJxNUZ2bUorY2JXanY2WWd2b01sejlMQklLdzQrdFZDWXFH?=
 =?utf-8?B?d29CQnJMejJUWnNjcVYvbEI2aklnRjVMQnZ4UVlSUUlJVU9zTWxCQnZTL3Rx?=
 =?utf-8?B?NGdFa1E3bjE0ckpMeFlwME1aTzl5RnZFVmRxQ2JabUwrRUtta2lzRnVNQlA1?=
 =?utf-8?B?L1Z3UG1KbjNGbjdFa3NnTVVISUc4S1F1MDNmeTV4bkJJdXdhSnZoejhFQUty?=
 =?utf-8?B?dVVyK1NvelFUaXpZb1hqbnN5Mm9LVXBmNkZ4ditnNlRVMUUyU0FFaWVYWERO?=
 =?utf-8?B?a25BeExjS1gzWlhIQUp4LzFuR3grUjExc1pjMjZSU0lPNnJzZ2dUVlhNRDB6?=
 =?utf-8?B?aDJ4R2lKOUF3Q3Y1UjBYdVZlUXlqRzFPTm9RTFVzaVZpbTJRbFZQcnVraXhW?=
 =?utf-8?B?UktrSWNuQTVDclJKaVJvem9icldqMHFYSmpYM2RDK3ljRkN2bk5ldDNUdlVq?=
 =?utf-8?B?WlhUbGRmWmtkQTRBQWYyVDlQSUNodG1aT3JCcjNMU29GRG15NkM1cEhDS3Yv?=
 =?utf-8?B?dFBKM2RDRE5QRlkxejdWK0Q1NHlsd1RWVXE3OGRFdmc4YXAwb3ZNdzB4RHZM?=
 =?utf-8?B?WnVBZERCbjRlb1ZlSWIzUGhxSmQ5TG1FV1puYkVoeFNvTXdpK2FrdUczQTlw?=
 =?utf-8?B?QVhTQjduak1WcmtobDU1ZGZPMmw0MU5zbWlNenRoQkNTNjdSYnVnTzFwRFg1?=
 =?utf-8?B?ZGhXZktqSmRVSEFjVHorZWQxZUlDeTFxNld5WWVGNUx5cG03R2Y4cVR4M1FI?=
 =?utf-8?B?cVdIZUhnOGRZWDVVbDN3WlZONnE4aVVYU0N0bmNUQmxnMVUwZnZpQk90d1dJ?=
 =?utf-8?B?dFgySTdwRzgwYUNGRnFZK3JiMllYRGE5MTQxMjBkckkycG1oZ1ZLdmVoT0d0?=
 =?utf-8?B?OTh1c0oxMFBaOFVuc2lYYUxQYmFVUjdTOTI3UngyWjIrc2g1V2tvWXFQY3Ry?=
 =?utf-8?B?UWFhMGVqR0hhRkJ6K0VzNENoUktWcHdHOE5kb3FMMTBBTUpDWEovVDQ4bHBL?=
 =?utf-8?B?NmtSMjhSL2Z3Lzk3OHVZL2ptaFhDZ0U3RWhnajVzQXlISGx2bUZPS3hpL0pG?=
 =?utf-8?B?aXkzMFpiUW5iWmp4QlRhUmt1b2tMdHhBL3J5ZjV5YmJUUmJLOThsNzl6eHpj?=
 =?utf-8?B?Ykl1cHhDamVtamhIbU9McTVySjVpVm85dWtpWktGenlYMTZXZDBiU29iM0d5?=
 =?utf-8?B?WEZuNE1LT1UyZXp4OTNlTGs3Y2loVEpaeEFRdVRiVzBYcmM1S2grQmZVWVlN?=
 =?utf-8?B?eWFEQm9aQlpZL21OOEo2V0w4aDYyS2xNZjloZCs0YUNxUGVUeG40dHVnQ3dq?=
 =?utf-8?B?NkhmYVhnYUthSTB0c0VmOWp3ZStOTTlrQUFwSk5WVUo5MVdzU24rMGhtZjJX?=
 =?utf-8?B?MjRBNW02UGhUMjJpbmJucnh0ZlBhUlJnTEpWT3ppOVppNElpRUhvVngxYnFy?=
 =?utf-8?B?eVRXektqQlNiU2w5OGQzWGVZVkdXUWlNTFd6TUxUMC9KemkxcmlWUTJLWURE?=
 =?utf-8?B?aXM3cldRQjdpcmh5QzRkbHV4a2JsbkgzNzQxM0NrSVFRT2pmc0RWejI2c0xO?=
 =?utf-8?B?dUR3SXdTRmFCTmNad09aaHJDcnRPUmxabTF2emxTRGFGWmdJQ3BseDRwTkp5?=
 =?utf-8?B?a3VXeWgwOFZoa3dyQWxIcmNTa24yR1VsNGk2SGljUEdaanlPOFlRd0dWdnRx?=
 =?utf-8?B?MnIydmVIN2k4MngwZ2hZL1o3cFV5NU9qTTYzU000NFFTSjExUHRtYmU2ZFlP?=
 =?utf-8?Q?cszAxbO9UQLzXXiJCyhn+bGcj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71040401-c488-4b66-a909-08dc83efd761
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 17:08:51.4622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXzkd9/qcbFTpX6Pi0B4J7ppG6WYtvH2vigsRxmixAP5iI5z/8YctNtEarKccAmtIaq54voiJQp/j3ZXbPsQhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6413
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_100859_485617_E432ECCC 
X-CRM114-Status: UNSURE (   7.41  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 6/3/2024 11:57 AM, Borislav Petkov wrote:

> On Mon, Jun 03, 2024 at 11:48:03AM -0500, Kalra, Ashish wrote:
>> Yes, something similar as above, as efi_mem_reserve() is used to reserve
>> boot service memory and is not necessary for kexec boot.
>>
>> So, Dave Young (dyoung@redhat.com) had suggested that we skip
>> efi_arch_mem_reserve() for kexec by checking the set EFI_MEMORY_RUNTIME
>> attribute as below:a
> efi_arch_mem_reserve() or efi_mem_reserve() altogether?

efi_arch_mem_reserve().

Thanks, Ashish

>
> Btw, that below got really gibberished by your mail client. Snipped.
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

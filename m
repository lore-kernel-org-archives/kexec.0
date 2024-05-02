Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A865FC4345F
	for <kexec@archiver.kernel.org>; Thu,  2 May 2024 21:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nwbPl5K0E/dVeZs+1as3Cj3L2XfGSrtvkQ1CyRzmjBw=; b=ghEVdHiIhW4HUHwBRPfqVU88GU
	ZvWv5L3MPwNOl9pXfuHNDLs0YNgrUUzEuvLIGVk0WTKJyRBNLKB5zCeUXrVBZeVFA6nd0r6OB28GV
	fKGDYHEMqk5qiWqrEELhFZWID4gCgkcLmasKyYj4yG+7Pse5YzCrezHt9VqrDfWM1J2pqgy3Hudxg
	cj7/Gs3bdOtkVoJOIqSUMVlAoAm9UG+rKUOVZhz2iEdPwFDwrGsG0FckTXwSVzvTM0eJG1sKh2u1T
	0d91XPBXY6lVNEyE2rahf/LLVV789XvSqsae8JJZOPTCSrIvpSK95GJnUPCFd9v/dNfdVf1+kkHv/
	d7raUbrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2eOT-0000000E3F9-3icB;
	Thu, 02 May 2024 21:55:09 +0000
Received: from mail-co1nam11on20600.outbound.protection.outlook.com ([2a01:111:f403:2416::600] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2eOR-0000000E3BK-18z0
	for kexec@lists.infradead.org;
	Thu, 02 May 2024 21:55:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEWProBIlq33E1r5U5LeC1zNyvyYClA1BVRePywF5yP6zWtzfI+zoMRkpLBPhQzp1qxNXcu/KPs4RGO/3bIWiAQPoG5b+VX0sVuDYNsLHapfs6aUVkS48pjR212AEQobyxZG73vNysWchvDzjNVxGGbA4SfsXWPqA/J9/BasDsuoRTwiq3Sd6zQDzayJQ7vzQs5i+a0XizaR6UmqafG8o4od5NCVPKxIi9HvGg3TH/p6ItdYxZNvI2smHfrUCCIIXkBhg/lnEzkkV2oDgUaGVptI/dvjp8hDt5c2uNzGv3qOamN7htjU9KBcjUVx2BfWjfAC3CVy80L1z5i+dpB6Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8h2Epx1OjdpJIdtoXxETevKhZ88CI7qtYJdOdoGsgo=;
 b=lu7CAdXGA/Bpfdcs470IqpchP/RUQIo+BrVzeniD0NpjYZgDCAhRfpcDuLB9WOkMOZS8R+Lds72ZJ8SUZn9h7USRbUdmV6Cz0r6UJtTmWid4q/2yhGL79RnZv3N2Tu6jLOEPWQS2izLSRVbETuGk+TvSmH0CGMQO/ZCXxaHeCehLknvSss8xODvs5/4gCfb/fErYzswMZ/hoq6N+CUZrVWSyw+VMCzg/jmFdxct4unPVHeY8eXO+UzMVd5A1pzZHax+3aPdEM6NTK76GqZgnj18bvHI79xZ4O09DIevbyVn/5JJZ5QC9Cr1Wcr7cjCBCMS9x+ZQAr/mddFwgAD0OLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8h2Epx1OjdpJIdtoXxETevKhZ88CI7qtYJdOdoGsgo=;
 b=JzNv7MjoPbfRSDFtpSFAWRhiNUMCtIG2X8N5kpG2SzGHRB2rVsCs4Q90jKl9EUYqi9uJ5U76m7pBccfLiIxTMrGGEVohlIq9j2aWHa7DDIZeaWkC03SR2Kau/WyTCAa2TuYKu0CL2Z/v527E6ViuVNOdNcIhCXLnCkxxSTDfut4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.26; Thu, 2 May
 2024 21:54:44 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26%7]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 21:54:44 +0000
Message-ID: <a1aaf894-02cb-4018-8a65-525f6f8f918a@amd.com>
Date: Thu, 2 May 2024 16:54:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] x86/snp: Add kexec support
Content-Language: en-US
To: Alexander Graf <graf@amazon.com>, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org
Cc: rafael@kernel.org, peterz@infradead.org, adrian.hunter@intel.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
 rick.p.edgecombe@intel.com, thomas.lendacky@amd.com, michael.roth@amd.com,
 seanjc@google.com, kai.huang@intel.com, bhe@redhat.com,
 kirill.shutemov@linux.intel.com, bdas@redhat.com, vkuznets@redhat.com,
 dionnaglaze@google.com, anisinha@redhat.com, jroedel@suse.de,
 ardb@kernel.org, kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <cover.1712694667.git.ashish.kalra@amd.com>
 <26b3b3b5-548d-4ebd-9d21-19580a41e799@amazon.com>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <26b3b3b5-548d-4ebd-9d21-19580a41e799@amazon.com>
X-ClientProxiedBy: SA1P222CA0079.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::16) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|LV2PR12MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: 96562c17-f518-487c-0154-08dc6af279e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHBVbTE2Y3V1K3cvZ1FLMFgyVVFsK21aTFBrSG1HNGtlcW1FOGhucDRLUkVp?=
 =?utf-8?B?RmJJVzVjRWh3bjlBU013NURDcWxsUS9qTTVEVXNYSlJZeUNFVDBXM2lNOG9S?=
 =?utf-8?B?UEMxeVpTUGpFNVQ3S0lVR3g2M2ZOSTNJcTkrM1k5Zy9YVFBPc3JxRXRsVExS?=
 =?utf-8?B?YndRSGUzT0lUdXlLVW5kbW9ZWG5vQlAvblMwSTNBUXlRaHlxRThMVlNyb0lx?=
 =?utf-8?B?QzhhM3NZOTRRb3dQTGdnSFQrMXVIMlFzb3NSZFJRd0o3aklXQ0tZQU5scGp6?=
 =?utf-8?B?UWxDL1YyZnU4VS95VUdlejdqM1JDUnZxU3BmWGJXN3hkK01ZOWRUbFlEa0RZ?=
 =?utf-8?B?T21uanVjYS9Fcm5GVzdoc1FjNHVQMkYxUGdrYzRBdzNRYjMrVEdMMTNrTFpw?=
 =?utf-8?B?YXVGeFFkS2dNSmI3Q3hPSWtJamhqR0gyTWlTWUp4dlVLNEtCMkN3b1o1cWxT?=
 =?utf-8?B?T2owZHFtdnZPWGNLYkNPd3hIZTdWRWVSUVU3RUJNVEJNUEh2MmhPWkRPVmdS?=
 =?utf-8?B?UmdhUGNjZ05rNDRpbjNJVXV1WWJFWHh4bEhzOURHT1NnT01vRmJlbE1pQzNV?=
 =?utf-8?B?bmJYV0pWcS82SHlBVTF5S1RsVlRJSktLVW1obDFucG96bmZzVGlyQWdJcngz?=
 =?utf-8?B?YkxMQ2dGaEF3TG5PL2s0QVNYbWROd3RnQ0c4cjF3UHJZVmJscHpiVURBYWRP?=
 =?utf-8?B?dmc3SnNJdEpWYXlET3lmcDViaFVXd3RuK042MWR0UlJVK1kyTzAzb1pwTUpJ?=
 =?utf-8?B?ZktEdEcrT2o3Z1pSTEFWZ0lKTm1Wbk5OeEFPNVVUUW5aeCttTjdWVUJnMzk5?=
 =?utf-8?B?anBIekZBQURnMnVtMFpHbzdEeWhPTlhKbjZXYmZRTlEzaGVnendiWDdHdTZG?=
 =?utf-8?B?akRKcWRjcTRLbnlWTm9FcXdxN0RyQVJ3ZjN3LzBrVUo3UkpsNFllaWM1NDBK?=
 =?utf-8?B?aHAzS1hEV2JJeDhuNmI2bUZtUlB5U3dDREQvQUVJbDBodEU3aFY0cURBeDA3?=
 =?utf-8?B?MTd5U2RKT0xWYUVhMnFtQ0pheS83R2JVdGk2NXBEZnZ2ei9Cdjd5c1VtUk9x?=
 =?utf-8?B?WFZMdDQyd0gzUWorWkcrelY0bFRpMGY5NTlER1V0QTNEZmtEUVJJcldjU0Ja?=
 =?utf-8?B?RHBjdDlQQk5OUCtvdlo5SWtJUmJhN0gyZUdoc3hXWHRRdGF4RW1uRXZRTkw3?=
 =?utf-8?B?MWptUHNBT002SWViVktOeWRmM2FndkFxSmN1Qm5YZWJ2ZEltcENmSW1YWlBT?=
 =?utf-8?B?dTVadG9VL0dSWTVjRnNEMkd3VlJ1cjBNcFlSTmsvQ0xnenNkRUpDbkFkYVVy?=
 =?utf-8?B?UHRmK2NQcXBXRURteURPc0c2MTdrc205ZmtxV3hmbWgyRC9kWndzY3pFeVpW?=
 =?utf-8?B?NGlQaFhwTy94U0d6cVNFbVNvTmlGUDRNTG55RkY3bnVPayttdkdFeEJZQlZB?=
 =?utf-8?B?VWpiK1laRFJaMlZ0UkVmeHBSSVExN29MNlg1OWJjb2NmeHdkczdsVzNIaWhK?=
 =?utf-8?B?WTdoaE5DK1Mrc1VQblZuTkJvTHJsc0Ezd1N5ajNvSGtXaVhrNlV0aFhaRDJP?=
 =?utf-8?B?bzlSYWZ1dDFEUDRvWTFUbHRzRnZVb3VnY0E1cE92RkhMUG9Nekp3eVNiazh3?=
 =?utf-8?B?TGNYeU0rckg2WG5WWHNYS3d1bVozdmFZdzNiSjFnb2wzS1U5WFNYK1QvaE15?=
 =?utf-8?B?djduTzZZaFh1QXlQbkI2L2trMXZBWmRiRXI3L3dJb1Awd2dJTlVGd1dRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEtXaGI0NXd3RDEzdEdUaFY5NDVpR2RrNmVGZXYzU1BhNzd1c21YcnJMNGFw?=
 =?utf-8?B?MVNYbFZpRStzV3lldjJtMVFDQVNnTUJiY2ZPdjV2SVVtd1NxT0V5emloTzF0?=
 =?utf-8?B?K2ZKc3RTZG82dUlDRUhweVJ5UEdWdTBWdlNzdUZVRFpUNnZrQ1JzSkU5VXYx?=
 =?utf-8?B?RHl0Y0lhWUphT0lSUEhCdzVIWS96ZjdNZU04aUpaanA5dDFUZ3ZvYWRFdlZX?=
 =?utf-8?B?a2xZYlkyQ2tPMk9XRjhWTUZnR29INmtnZVVpZ3BBR2M1K3l2SUZSK0s5QUhU?=
 =?utf-8?B?cnhRUDdJWk9mYjFXVWZZRFZKTGtMTVo2SEl4WTMvTFJjWUkrSnFncDlwMjBM?=
 =?utf-8?B?cFRFb0owSE1mSnBPdnhGdVFyYWxIS0JXS1JWektkaVZ4L3F4RHR2OGFESU5j?=
 =?utf-8?B?ZTgrcDlHV1ZrR0pCZjVwOWp2OGZzMDkybC9jYnlxZ25RL3VoOGpuMC9xS0hU?=
 =?utf-8?B?ZVdDU2F5WHM5YUhVaXlIU0hkcGZFMGNtRFJma2JqYlJ6T2hWSGZhMG53VWhn?=
 =?utf-8?B?N2tMTTkrL09IWndKTEo3SUdzWUhZd1hjQ0FiaUdrTm0rNlFFT2REQjllU29S?=
 =?utf-8?B?WTFIVlBFaWEzSmR6blVpS2dnZlR6UWtXSWwvQWpBaklmWW5HQzVVQ0JtMzdk?=
 =?utf-8?B?V3h6RzRrRTlGdVhZQ1dObVZVeGltNkFmTk1sK0V4bjhTVGtUMUtMV2VPWE5m?=
 =?utf-8?B?RDUrODB1QWxPK3Nob3VMRmJyRnh4bjAyaEt2VTV2NGtPU050TldCd0JQQjBj?=
 =?utf-8?B?WEhVQjUyRFNyNHd1bmtxbkk5TExENm1ZUElka2tqbFpFeS9yRHJTbkJUaGll?=
 =?utf-8?B?YWlwTWJZTkNQNWl2cDdlOVBOOXJWSzVrYnBwOHROblYxMEt5Sml6aEFJT3dC?=
 =?utf-8?B?VWEyZWpzMEQ4NlNrWjVNZUpiNjgxemlUSEFiTDUxQ0VZdGR3b0I1QUVzV1BR?=
 =?utf-8?B?KzZXWG9HcU1PVFptSzgxdzJvZEJJelRQTVltMGJxZGp6eWlXVTQ3bVQwbVUv?=
 =?utf-8?B?eDJjSWdDZjhZdGtpMUhySGkzclo5NHllZ00vWlhzckV6SW9HSitJNDRpeStW?=
 =?utf-8?B?aTJ5bmNYR3FwYWNMb2NlblpvQnNoNUJCeVFUSnQxdUJ5WERsbFluYURJZDNt?=
 =?utf-8?B?eFRFd2dhcmdQcXJjMzZMUjFZTW5FVWlLQWRvWVNLaVRLN3pGendnZk9xQ1dw?=
 =?utf-8?B?OW50eTFmSTdWS3h1THJXNHBqMWxmdjRFcng0eE5PNGtoV3QzTmdVck1KbkZS?=
 =?utf-8?B?OHM3UjNhNXJVbGlJUzRCekhKSkFFS2E0bXhsVnFFTHYxTm1TT2g5b0JYSmNs?=
 =?utf-8?B?R2dxVUYreEdhL3BTZlNyVkpCc3dSVXIvcFU5WER0d2dKVTd0UmtIUjNBVlFm?=
 =?utf-8?B?LzlZK2xiZUNlQ3RvaVdrYTdmUTVUZUp0T09tZHJzQWNtbFl3NUU2V0NjN1F3?=
 =?utf-8?B?ZnhEeXVJRnJaU29Yb21NbCt5OEVmNlVzTzRnclV6RzdmRXFkOGpKSmpUU1RU?=
 =?utf-8?B?dkVKUFdPVkM0eEhNRmRpaGRVZ2lXZEFubTVQTGxDQW1Tcy9ta2pOVVBmS295?=
 =?utf-8?B?eWNQVG9CWUlWSkhrdWlwZXp2NFNIR0QvS05VQkVLUnNDS3NSdGZidjdHc1Yv?=
 =?utf-8?B?OCtvdnZmLzhBVzlOYnB5WFlUQzduZmJaalpyaG5tK05zNWNjYUl3V25ubS9x?=
 =?utf-8?B?emhJQVZyd2dhenRtZVcrSGlkZEpKdG44UjJhZnpnQzgzT2NGeXIrK1Bjb3Ey?=
 =?utf-8?B?cWVMWExYS0FMODhrdkZna3BlUlpoSXlIZTJ2ZHd2TWk0aUIxWlB3d1JUKzlp?=
 =?utf-8?B?U3hMb2VZQkRqeFh1QjBmYkkvaVNHajNKajhCY01Kclk4YXpGODUzelFvcVFE?=
 =?utf-8?B?aVA1dnJYMGg0cVFuWEFWMDMvTU5VS040RnFwb2FhZjhuMGZoWGJpaXBMVXBD?=
 =?utf-8?B?NzZ6TzhhMDluZWE0Y1JlR2hML1hJbzJ0QzV0ZzVPQU5wQ1h6WXYwRkNZUHAr?=
 =?utf-8?B?TnIxa0hzQlM4V1EwdzFZdHMzZm11WWNLUzBVS2ZzZTFhQ240N045ZGwvRlhI?=
 =?utf-8?B?YnpPcXRDMFNSbXNORy9UZ1g0amo3S0IzK3VaWHdROHRZSk4rQ1QwUzB1M2d4?=
 =?utf-8?Q?M7T5MkPa9scGlVp0zy2rsXdxz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96562c17-f518-487c-0154-08dc6af279e7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 21:54:44.1245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q6LrGcqBm2JzpoESdIqFZO1VObL3IZRlihEROaT5CW7iUXcl++979KbDJIktBRc3LgiFughE9BTR8fpAIqOB/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240502_145507_325032_75BAFAAC 
X-CRM114-Status: GOOD (  23.53  )
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

Hello Alexander,

On 5/2/2024 7:01 AM, Alexander Graf wrote:
> Hey Ashish,
>
> On 09.04.24 22:42, Ashish Kalra wrote:
>> From: Ashish Kalra <ashish.kalra@amd.com>
>>
>> The patchset adds bits and pieces to get kexec (and crashkernel) work on
>> SNP guest.
>
>
> With this patch set (and similar for the TDX one), you enable the 
> typical kdump case, which is great!
>
> However, if a user is running with direct kernel boot - which is very 
> typical in SEV-SNP setup, especially for Kata Containers and similar - 
> the initial launch measurement is a natural indicator of the target 
> environment. Kexec basically allows them to completely bypass that: 
> You would be able to run a completely different environment than the 
> one you measure through the launch digest. I'm not sure it's a good 
> idea to even allow that by default in CoCo environments - at least not 
> if the kernel is locked down.
>
I thought that kexec is disabled if kernel is in locked-down mode.

Or is it that KEXEC_LOAD syscall is not supported/disabled in kernel 
locked-down mode and KEXEC_FILE_LOAD syscall is supported ?

> Do you have any plans to build a CoCo native kexec where you allow a 
> VM to create a new VM context with a guest provided seed? The new 
> context could rerun all of the attestation and so enable users to 
> generate a new launch digest. If you then atomically swap into the new 
> context, it would in turn enable them to natively "kexec" into a 
> completely new VM context including measurements.

No, currently i don't think there any any such plans.

Thanks, Ashish

>
> I understand that an SVSM + TPM implementation may help to some extent 
> here by integrating with IMA and adding the new kernel into the IMA 
> log. But that quickly becomes very convoluted (hence difficult to 
> assess correctness for) and the same measurement question arises just 
> one level up then: How do you update your SVSM while maintaining a 
> full measurement and trust chain?
>
>
> Thanks,
>
> Alex
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

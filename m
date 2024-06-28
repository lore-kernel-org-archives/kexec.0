Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E692C2BD09
	for <kexec@archiver.kernel.org>; Fri, 28 Jun 2024 20:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:
	References:Cc:To:Subject:Date:Message-ID:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=tvfrdEDk6drX3cMG8WG5bI8sFNLVu0dws+r0ahIOZi0=; b=D+CvR8omy/G9cKc/qR264TzO/T
	CyZZymevbp2mK0N5GcC0kJQq3whQUqIYcvukxvEDHqo7Yub8AhyHjbiqreoMCJKxKyB+J4UB4r57q
	bf2jxYQGXW11x2TSpeC7iMGOhZshfcRfEhBBHsBWutACnkVkR/5zmD+zBmCxAHfNMec/tDguBqql7
	/ISgx5jofS0flLvScjQehhydqD0FyyATsgtbrWBgA2263R71krVrcZpUBsM6MkWHSzKxJhzMwrZCx
	UAX5SRwZu/acU9kboAoTCWoC2pfxaeZyKTx+nTXjmdU/sV8HB8iRM3+XOH5q9KRXr2uyrh/ua8pQp
	nsOLvmAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNIW8-0000000EuJz-1pcN;
	Fri, 28 Jun 2024 20:48:24 +0000
Received: from mail-mw2nam10on2060f.outbound.protection.outlook.com ([2a01:111:f403:2412::60f] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNIW6-0000000EuJV-0Gy3
	for kexec@lists.infradead.org;
	Fri, 28 Jun 2024 20:48:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWPgyOAL15D4qrOfOaSxLdERF8i1WigfQRMBSyGS5VdehBGYeLaGcZLqZ3LYhj14WUeHj+Q/obVqOJhTpnaNI8dD4kQNnNpZ5fPJv860XrRNd3tnZVrj0+5AgBFIqSFNz+xewifGpHlRcf4Qil8aPK0NhMRjsuokVZAKZto/COih0Fu/m0vXUvWLqiNr6NFNd1+CDb4T1MRXVnTaH1iTOhyTY2V4c0e8bkaYc8IeoFJmJ2SX38XkHQKCk66EkbKR3dB8VwThfY3/Rb0ZKT8J05mKZ1hIr0AkJpA3VJIUVshL/jMrSzI8QDGV1udqPCbZdweJyn3E34+WjrZ07io6nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqmhU8XdYjltvG73pHPt6SU3F1N/9qSHziWkajfo1D4=;
 b=ocw7Q1fRL3S4p6bvqMp8u29qTveQVZZd6BgFOmnG56r2eEBMoY/k1+8jBJzUIbzT+OW/Q3VVz/+VKkAZxPI7f+5N/CK7rODQGOFYSSDRCsr0Cvz0DZuC8ni46r++jFhisnyevNDTITVDKQqP+JFJCjJH4NEne9SJ4j80z6FWhx5Yeajxkbst4qPJK+xDpo0lTaqwA2YFtbi0BLvkMP/+6IMZwFsXUGDc77VdZZm8T+K3q+CqnPSryIQhGrkf8WbRYZL+bTLuq4RKpsjFc2XiKyLdSmggGmPo2puei5yDW3/N1lt9ch2DBwrNuXHu+YZiG3hw14OoQj6Wt1O/nNl6Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqmhU8XdYjltvG73pHPt6SU3F1N/9qSHziWkajfo1D4=;
 b=UUDFEiBY+Ir0w9xu3aaMrzxYzLdQsf/cRnq379DE0HDegyTAclykdA2H3rZMqhfxK6okBZcqeXubUsOt2n153OYI7NfCZSLrcOeyWiFdZHBgky5mQhUZ1jMgj+chtR4aJZfg4NP/34gklIHj9/7ETJRR2qmL2c82fap5QTLAqHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by PH8PR12MB6868.namprd12.prod.outlook.com (2603:10b6:510:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Fri, 28 Jun
 2024 20:33:03 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7%4]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 20:33:03 +0000
Message-ID: <a1a7f007-8552-45a1-bab3-8ebd0677ed54@amd.com>
Date: Fri, 28 Jun 2024 15:33:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/3] x86/snp: Convert shared memory back to private on
 kexec
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, rafael@kernel.org, hpa@zytor.com, peterz@infradead.org,
 adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 jun.nakajima@intel.com, rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
 bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
 vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
 jroedel@suse.de, ardb@kernel.org, dyoung@redhat.com,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
 <cover.1718920799.git.ashish.kalra@amd.com>
 <f6c0ddfd15579674bc234d6e1b84e92768531050.1718920799.git.ashish.kalra@amd.com>
 <20240624182615.GLZnm6R4hLvnlF16aP@fat_crate.local>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20240624182615.GLZnm6R4hLvnlF16aP@fat_crate.local>
X-ClientProxiedBy: SA1PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::14) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|PH8PR12MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: d13ae86c-f1b9-4ddc-011d-08dc97b18225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tytia3REZEZjZ0szd0l3RmwrRkZ3Q0JSR29lY3pFbkFuRUdsNktnMHk0Nkk3?=
 =?utf-8?B?eDBaN0FGYWhMZURCU3AyeXdLS2tTRjB4dDR1bUtMTEZJb01HM0ptOENpbTkx?=
 =?utf-8?B?TGo3MjNaKzNCY0pORmZKN0JBT3lYcGp4dUUxbDJEWFQxSEdPcHVrbzU4QmFZ?=
 =?utf-8?B?ck9WOWM0UmxKcWVSZ3RjWHcwOXFMVnlwLzM4c2lncWRJc3J3bHJiS3lHVTBK?=
 =?utf-8?B?bVNLZXZjdnJEUWozRUpIQU9JT2lUYlZRQVNpeS84bXlXWWNaK0t2RFFtWWZy?=
 =?utf-8?B?ZEVYRmI2S1VKNDZNUjg4VEVLVzdUMlZLcXY3YUZadXppZ2NpVk56cmhzWXZC?=
 =?utf-8?B?MmV5TmJKWVprWjNLUUlzeGlSc0tLK09GTVlUVE85eXZyeHpkc2JSUGJseXV1?=
 =?utf-8?B?Ti9SMEVPVDFyYktocGJkQS80bURpT2k5K2dyWnVRVGs5L1BJVjc1ejlTNnc4?=
 =?utf-8?B?Z1pvaytmM2Q3a3NtaWVaUFY0M2h4VmRtR2g4dkp5aDJSY2tZQk85UXRrZEZu?=
 =?utf-8?B?ZzJuajJBRXVycmZqYjMwM1lDM2p3MUFrNXpmcDR6amtRdWpHZzFNRDEzRzFX?=
 =?utf-8?B?MEkvSzg3ZlBoSW91dmlTY1luTEc2QmI3WHZUQ1lGMVpSNloza0dRZ3ltd3Nw?=
 =?utf-8?B?MGkxQVNvVW51SFlHc1hNUUxDV1o4dXpSN2ZzZkFaTEJDWmtYbDdrSWYvUmxV?=
 =?utf-8?B?V0RHQmR0czF3YzZpVWp1MDczWDFJQ0I5VDJCMC9UVktEaENLb2VSdWtTV3ZQ?=
 =?utf-8?B?V1dqQkptd3RkVU8wY0tyeTZoZXFKelVmdmp5Y1NNUlVxQjZ1RVlhMjdrbytG?=
 =?utf-8?B?ZnVCNE53ZFRuSDVLN1NTeXBaNU9YRjlSY2Y1U2tybDcva1RKZjF5VTVNWjhx?=
 =?utf-8?B?Y0hBS0V2eGVMZDlMN0Y4RDFvblF2bUxwTjlmNFQyM1hleStVb0piSUpHSFJE?=
 =?utf-8?B?SkswMlZaTUhHL1Q0WnNhY3ZaeExudW5RN0RGVEVkWGZ2UUprNWIzc2QzZHJn?=
 =?utf-8?B?MCt3aHlycXlVbDMwNCtaZyszZGJSS2FYamlLbG1Scnk4R0ZjZTNubkhVT1No?=
 =?utf-8?B?aG03Y0F0bFZHZzlLMzg5UDY1TXZvZnFGRDRpazhjZ1l6SjhKeEZVSEROSDgw?=
 =?utf-8?B?K1lEKzdyajVMV3o0aE9yaGVLOCtNeDd5cExrQWd2QjcwVHFmdWdPVkxrS1ZB?=
 =?utf-8?B?VWQwblB4eTFZaHN1UUpEVzMwbE1UYys5OUlCVVJ0UHV3WnlMSkFXTXorckVk?=
 =?utf-8?B?QjhPbFdrS0UvSTd4eERJTmRYUzZaTk1HakJ2b05UcGxpekxLRVlJSENsRS9I?=
 =?utf-8?B?ZU52WVpKSEpIZlBjUS9tRTEwcTR3K2l4UkdWRThQQWt5L3VXYU5TZzdZYmFr?=
 =?utf-8?B?VTJXUEFxVXJYTTIrWkJ3dE5wdEwyaWh2Nkc3U1hoYjREUUFPcDc1M3A3WnJm?=
 =?utf-8?B?QzQwUWVsL3JtWTZ5UWJrMjZjU0s4UURaZ2JFZ2ZFZ2hCZmNPMXRPUGdwMVhk?=
 =?utf-8?B?NnFYUkwrM3lHaERoSC9sN3FHM2RFM3hlSGpzL3ptV2EwbEJUK2Z1MS9lb3g5?=
 =?utf-8?B?c2xsQTlBVTRQTURkUmRkYXJ6OVBzczZIcWVVNCszTjY0SVRmcDlPbVZoNFh5?=
 =?utf-8?B?TnQ3c3paWng3c0J5aWpZaFQ1RDFlTDdnOVcvQ0o5dTdNcG8vaGxTVVVWODdM?=
 =?utf-8?B?cUlmemhUcnJ3QVlnQ1hWVXQzNXViTHRSNDM3RXdKdDYzbGRTa0JQcWtzcFQv?=
 =?utf-8?B?Mmt3SUkyZFhlZm5ralkrOFhBNG9aT2lCK2NUYzRWczRxU3lTTS9JT2hiaEc2?=
 =?utf-8?B?dkE5VnhMSjJkU25vakE4QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk9iYWdqNUN4V0UwdHJlVFFJM3hDbXdVK285ZVJTclFWcVM2WFExWlh2eSsx?=
 =?utf-8?B?VzlyajkyVEZVSXdFVXRpdERiUFgwMDRRYlhBZ1BjamtFY1RSVEFVRHhPcExt?=
 =?utf-8?B?VFBCVzNKa2l5ekNxVXBabUNtVXpGdHhOR1J6c3U2Z0JEMmVrQ2NDOGI0dDZO?=
 =?utf-8?B?V2N0TllqTllmYkZ4ODFyODN2cWJUSkN5M2FUaFNRbVArSVd0ZVNvOGZ0Q001?=
 =?utf-8?B?VE1WaG85WThkaXVzYkVGTzlFWEtZeTVEU2dpcG5QZUpYUGprZUJGWDVkYmZ2?=
 =?utf-8?B?aGtxR0EvUFh5MXZsYklRUVMwZW5DeWFXeDR2WTdWenBKSHdXejM3MkZzQnRS?=
 =?utf-8?B?N3ViUmJ0WC9WNExnblFFYnZFVXcvWG0yeGRnVjlhNGVqUE0yWlBnVWFjQy8v?=
 =?utf-8?B?Y05MckM2Mm5Xb25nRXJPdE5nQi9OK2tFWHdPN1BwRW9RSEFueHN5U1dnQ1Ew?=
 =?utf-8?B?a1BjVGl2eCs5dmlBVzJ1bjdCamxic09TRFVCbkg2ekhZeVZJWHg0UlJSLzFR?=
 =?utf-8?B?VllZelZ4dTVKZ2craGZETm9pa3B6Q2p2c3NyZDQzUWp5eHp1Vi8xWHNidXZS?=
 =?utf-8?B?OE5Zb3pJNlZZcmV3UVNBN2U1dnZyZm95VGdTQzhzOU5tRXRmS3B5alRWK21O?=
 =?utf-8?B?azM3UE1wcUc3TFd0S0lnVXN5RC9tRFZBYjljZ3ZGbDVGNndza09SenFzaFoz?=
 =?utf-8?B?SENvMTBtZzRpOGxqb3loQmN0L1A0bGNXZUlSTXp0RnlHRFRrUnkrWDE1YXhV?=
 =?utf-8?B?Y282ZU8yVFkvTGpsOU5pRlcvSFNxeU84S2draGEzNzIrTHVNZHBMbGVKN3M2?=
 =?utf-8?B?aTM4WmlGdnNUbTFNc0dQeUF1blNJYklOYyt0RGtCeG1RcEVSZStkZFFTOElr?=
 =?utf-8?B?VU5ZNG1zcjc1QlpQNzFidWY5WTV6OG1rMGdpdUtZUmJCTWRrTzBVWG5CZGgy?=
 =?utf-8?B?ajJtaWdtejMyT0FhN2s2V0RQT0dmalBBcHdDcjFJUlhrQVJpL2ZhYWZwME5z?=
 =?utf-8?B?THJGdVdtRTBpc1UwMGJycUpEOE94eUFBT1c0UnVURmloK1RaTmErOWg0MTdZ?=
 =?utf-8?B?aDYvM3M0aEV3dnZuSHpsaXRsYlVjZUdYVGk0WngwNm1wWWtRRkxtRjVtdURP?=
 =?utf-8?B?MlZPRXNWbEV4aGgyRWpieENWM2I3ODNxVW55bXd5VERvekdFV1JuVkF0NGh3?=
 =?utf-8?B?YkVobjVqcHZ6RThSYkVNWlR4OEVuTnhSamdCU05vWWdMR0JzY01FOGV1SmNz?=
 =?utf-8?B?RXFUcGxUUThDbXZWcmtBdGk0TlpKd2prNmJGa20zTmRIWWRsYlZ4R2tMTlJj?=
 =?utf-8?B?aWRwT1NNczJQK0d6T0MyVnFjbnFPdjBDeTgwc3BVcWdOU29XaE9CZUp2M2hY?=
 =?utf-8?B?TUdrYXJ4bmxObHh2dHZpUzlaNGw0N3FjTFFxNEdxanZ6TThRWFF6UEY3S3c0?=
 =?utf-8?B?WlpubHVPcURRQVVBeDBnYlZoRi93MG5uWWNXeWtHSE8zMXBkSzhjN3ErV0E2?=
 =?utf-8?B?Q0RUdTR3emcrZWZsSEFNY3VhSnVFUEV4WlNmU24wRXpxOEVkM1NaMkVSVHNJ?=
 =?utf-8?B?M2h0TFJrVTdBQzFab093QVo3YWtxNXUxV1BtcjRKRlhWcXVYalZ6dFJRSGxK?=
 =?utf-8?B?eXRscVNORUFjbW5CU0NwWkJ4WDNYZ0l0SnlzSWt2N2pnZSt1K2d0c2tGK0Zu?=
 =?utf-8?B?YlhaNGJRck0wM2RDbVV6bzNPM3NGT011b05DWTROR2hGSXVxM2VITm42bTBV?=
 =?utf-8?B?TnRWRStrTnlCVlZKNGxSRW1sUUlNL0R5ekZmSjFoMm5EWHFsZzdSM2Zha3Jx?=
 =?utf-8?B?L0JwTjFQNUFxRisxaVFLNWhPN0YzaHVXeXdrNTZ6Z08wUTJJZ3RWU0o4ek5x?=
 =?utf-8?B?RFpBaVkzT0p5SmV2UUZEV040UjFlQ2tXU05wUVo3eW1qNW9aMHRMUWdLclQ5?=
 =?utf-8?B?QktISDQ1SnNHYjJMQlJ2N3lWTEVJYUdmSEZRTUtBcUt2Q3ovdmtaaWZlN0Nu?=
 =?utf-8?B?TTQ1TTl1MXh3TTlFcjRKMjlJVE9oS1FlY1hBb1NlV2lXcTlCQk0yU3Y2SHh6?=
 =?utf-8?B?NTRGMlNEbDJGVE11L1hXYUpkVlFqUGR5MERjRklMVnVwdVE0TXVRdHZrWEhu?=
 =?utf-8?Q?XZeYAOKWqXCAVGX8YuRkMJIk4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13ae86c-f1b9-4ddc-011d-08dc97b18225
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 20:33:02.9446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFq7Fdxx4E/Ql0gRq7qaiVP3xl4fHiAHa/Datgc0fL8mDoRkAcin7QtIwmErVbGdMhjeUnfmS2WZD9OFGBijtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6868
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240628_134822_117712_4755C723 
X-CRM114-Status: GOOD (  11.03  )
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


On 6/24/2024 1:26 PM, Borislav Petkov wrote:
>> +	 */
>> +
>> +	addr = PAGE_OFFSET;
>> +	end  = PAGE_OFFSET + get_max_mapped();
>> +
>> +	while (addr < end) {
>> +		unsigned long size;
>> +		unsigned int level;
>> +		pte_t *pte;
>> +
>> +		pte = lookup_address(addr, &level);
>> +		size = page_level_size(level);
>> +
>> +		/*
>> +		 * pte_none() check is required to skip physical memory holes in direct mapped.
> This sentence needs to be written for humans. And come to think of it, you can
> simply drop it. lookup_address() can return NULL so you simply need to check
> its retval.
I had to additionally add check for pte_none() here to handle physical memory holes in direct mapping.

Looking at lookup_address_in_pgd_attr(), at pte level it is simply returning pte_offset_kernel() and there does not seem to be a check for returning NULL if pte_none() ?

Probably need to fix lookup_address_in_pgd_attr(), to add check for pte_none() after pte_offset_kernel() and return NULL if it is true.

Thanks, Ashish

>> +		 */
>> +		if (pte && pte_decrypted(*pte) && !pte_none(*pte)) {
>> +			int pages = size / PAGE_SIZE;
>>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

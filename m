Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BF4C4345F
	for <kexec@archiver.kernel.org>; Fri, 26 Apr 2024 14:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OQa8JO9x/voyRk8Dbymit4UmNBShbx536ttkIqJHZg4=; b=acp2nyPwSUjdorI+FrWb5XuKP5
	PtXG8kU2DHqZ1HE38iYDheP1WAEtUAij0EdmmwnQHbMINNAFKMxUNo48nhimxxOKJ8OBazurhP4uY
	jZlRh3q7GPnljRXc4YSBuMqmUJL1ePJ+CutQLZwb2A+is9UR2yEJ+QjuKXgjF20kcexT9W03mN2rQ
	hObkGBrisoaRA/y5gw7c2rJ2cXhJh6xCiUDEhll7IdTfJ8J4/GpuKN1cpnEhgNOnMqy35qb0X1NZE
	Rew8ZiazkGprSLbr3z7daDuP6nOQYPFJqTQsqHspKvtrO21AM8MP5HEmmgFTogfH8ngFG7uhgYkVE
	yca69iGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0Mr6-0000000Ctdr-1khP;
	Fri, 26 Apr 2024 14:47:16 +0000
Received: from mail-dm6nam12on20601.outbound.protection.outlook.com ([2a01:111:f403:2417::601] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0Mr3-0000000Ctcv-2aKo
	for kexec@lists.infradead.org;
	Fri, 26 Apr 2024 14:47:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmMqJUEHSWK/bNp8E9Mgok6/4e46vfvQrOndYoN+dSPYc34RKp6eG6Qdsl9eOc1wjBL3IKLSlp3MsPmhNVuyYgN7/VRVMMK2+W6MCqmT5VIbXA6Shcc7dmrR0jG7lCcr0h+YhpLmHcK+RYUBG6/3lZMgIfkOFjbQo/phlYQ3sJ1jzgjyyovPHDphVCkNPQ+HWTjYwwDB8IxzqswhjJQgWK9V7dtH/MVRMQTExPQ4uzFQDCsxJe04eb7+fwpj0tV6zIHft6PnC2Kka9hzHT8ZE9vhzR+UA4t0+OBC8CMQsJ7tNoMbZ9cNAP6MtJgVqwH2lf9uc+HFfC6dZa6keGh5eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVwVyAU/DxT/r7v+e+54gf91ibUJTNMEjFeafCuO74M=;
 b=NWLrPtqdNRgpuRKgoismnaYWMTAvj14nYfNO/lN+qby9RpNw1ahtQj3xB+ZGK5+QHgUcLYouhPEFvyT3ombk0GvCbDqSSUpx0TU93q0LUXM/RO2WJgFdLOk07ca3mZ3ErXJ74lLH8kc0Ma1lJywDBU7y6xR7/9LIYFLaurccw91vVi4vigo6pfnH7c0S2861MqnbTxDrOPSF8QzIvSz0RuVC5/w6w0c6boFkQkHh3xhithAdZr9ccM9i7nVHYATw+VeQ1L3qJk2gA5SEw37V/Evqx9c+dbomm5wU+ELsSw2R2ydsrfSdyTYQubvC7/nMeSblF0Z1dIW+yA/3vwdfKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVwVyAU/DxT/r7v+e+54gf91ibUJTNMEjFeafCuO74M=;
 b=o8osqmmL5m7cRjMhaiVkiGwNI3sKySKBQ054bcW1Z87T+F5I20Kt/Xc2u5eu6Eq1YhqyIAbaoM9xhN1htMFvEApJ3GxR2ARr9FcIXwwFHc3XVeL9pHq49PqDBSagvWr4STxu8xAildMi6HA6atNYRWhAwyLoeNPmvz5BHVCf/dw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by IA0PR12MB8714.namprd12.prod.outlook.com (2603:10b6:208:488::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 14:47:05 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26%7]) with mapi id 15.20.7472.044; Fri, 26 Apr 2024
 14:47:05 +0000
Message-ID: <a1d80cce-28d1-48e8-bc38-8960d8c90774@amd.com>
Date: Fri, 26 Apr 2024 09:47:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] efi/x86: skip efi_arch_mem_reserve() in case of
 kexec.
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, rafael@kernel.org, peterz@infradead.org,
 adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 jun.nakajima@intel.com, rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
 bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
 vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
 jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1712694667.git.ashish.kalra@amd.com>
 <cover.1713222642.git.ashish.kalra@amd.com>
 <a3032e4b7a5406c26aeb66e9380043c410d07e3d.1713222642.git.ashish.kalra@amd.com>
 <20240424144807.GEZikbp0NjFP5AM_ms@fat_crate.local>
 <16b34494-7e5f-4feb-8a21-58e7b8fa97e2@amd.com>
 <20240426142119.GEZiu4X8VPK5He4zH1@fat_crate.local>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20240426142119.GEZiu4X8VPK5He4zH1@fat_crate.local>
X-ClientProxiedBy: SN7PR18CA0023.namprd18.prod.outlook.com
 (2603:10b6:806:f3::16) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|IA0PR12MB8714:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd1ff02-525e-4a9e-7f7c-08dc65ffbd91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2FNQ0N0UGNPVHFtekRKWWJuRkZnZ2RhbWNpWU5EUzVWNmpEZGNlMTRzMUVJ?=
 =?utf-8?B?Ri9BOFBCcDNveUd4ZkV0ZERyNEg0TUZGYUVDZVNMZGJYSFErLzErTUVvSy8w?=
 =?utf-8?B?aFB4UEJ6U25DSE5jSW9UUEhiN1dlU2xxWGlHOWVOUDdORi9ML0UrL3hiM0dm?=
 =?utf-8?B?ZkxXMFpSRmVpTGp1Q3FUdFZiOGMzZ0NiZnIyQ09RYjVwZ2NoZm8yVFFJWHZr?=
 =?utf-8?B?VnFpQ2pWR3V5cnBNUG4vS0EyT2hMajVoNHR6U1lUdDVjRGpUMzJPNG14cmEx?=
 =?utf-8?B?ZVk5bU1nbklRQit2NTg4VFh6b0U4NzF3dTh2dk9YQjR2NnlEdW81Y2dWSkFM?=
 =?utf-8?B?bHVEYTNkQ2hRcGtRMGxuU0JWVWV4QkNSNVkyNCtlOFIybEIrUDV3ZXlVWlBH?=
 =?utf-8?B?cWovM3FRRWhuUTVwWWtxZloyK3FMMjN2MVdHVmMvVUVpMHhhSE80RXcrTkdt?=
 =?utf-8?B?UTVveTM5ZFQ5QktMYlNhd3U3amRuSXRHM2dEMWdoYURJM2R2eUdxVU1NVDN0?=
 =?utf-8?B?dzQrcjRsSmV3Z1hCUnZLYlMwalp3b1k2cFRiMERITmlOcDluVnhTSlkrcTQ4?=
 =?utf-8?B?czlMdzdMaVNwS29QZG1JZXoyalc1K2l4TEJ4YjUxTXFXbytrY0JvZDFrL3Ry?=
 =?utf-8?B?K3JhZVRUemhiQWN0ZzZBelJVV2dEQVdaNGRBb1hnQzBJeGdmVXA0UzRrSmF0?=
 =?utf-8?B?dEw4VlpoUWV4MXVzR1JDY1R2SXA3Z3lydkxUaG5VT0F1RzlmSER6ZTRmNW9N?=
 =?utf-8?B?Skc3RGdscFZNbm9JbTdTTDA5aDM0SDlTR2dkaEg5T0xLOTVaTVhJekIxYktK?=
 =?utf-8?B?Nlo5ejJKdGhDbWJsbGt2S09WN1hKK2QxSVA2ck5WMUFXVFpSYkhzejNXR2hh?=
 =?utf-8?B?OGRkcklxZ3JGR2ZIa3VGU2ptY3FYRTY3RDNmdkRPeHNTQmNyMkZwbFpmdFBU?=
 =?utf-8?B?akRiVllOekVWYm5iNTJOcGFrcTlubnpKMGRKN1JRcmg0ODhJY0JqYWwzeGM0?=
 =?utf-8?B?RkxXWUU3bStnYnhLZXRFNndVMDZieThCL0orT0FIODNkOWJsK05aWEt0a1pH?=
 =?utf-8?B?b0FiWUZQL3YvOWp1L3psY3lYUXJvNzY1QlAvYlBBSjhsUWxiRVp4cG82K0Zp?=
 =?utf-8?B?STN1a24rWXJkMVZ5UVVtYU13K1JZNUllYmdPRnJ4UGp0S2VnNjRLR3dNVmo4?=
 =?utf-8?B?YndyTmcxLzkvaXFpTzlKUVRFbWZiMUhBdE05VHBrVXBvM0htb2dKczRCMTNB?=
 =?utf-8?B?V0tPb3ZaQWluREdmV0pwWG1MOHFrN2xFcVNXTE9HWFdJcmpmVnBiQ0ZpTHZu?=
 =?utf-8?B?RDd5dm5Hd2dHb0VScVZtd0xMbmlUQmxqNmxOVVFOSEt5TGVIMTdaUURjK2ZY?=
 =?utf-8?B?N2FuLzVUQlhYdGloS0ZZb29teFR3amZCQ2N2VHdrTkowN1BVWHlvdzFTekx5?=
 =?utf-8?B?M3hJZkVhb1lPMWp2R2ZyWHVMTjBwYnNBNXpIeEE4TTVobjJIU2cyc2RjNndh?=
 =?utf-8?B?WU9scFpJand6RzdQZFd4TFZPL29QeVhITTNCRUU3MEJuejNDTTRuYUtNQW93?=
 =?utf-8?B?VnFsTXdTSVc3OUFYYUkzb0dQYzBXcDg0L2ZreHBGekZhUzVkOGdaZlBjR1lo?=
 =?utf-8?B?UHZ4b0M2WDdoT2NMWE1LNmgxZkczR0xsL0tmcjdpRjlRMm1GRjgrZ2JidHpT?=
 =?utf-8?B?eEJxOXlNU2NSQ3pTZUZFVUpZQk81Wlc2SnR3WjJ6V1RiZndWMFF4YjhRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmVmc0ZjQXY5dWRzYkNZejdOejBtNEdZSWlyNkIrektGM3g1bnptNG9IQjN5?=
 =?utf-8?B?ck9PYlpINzdVOS9zTDJqbzRuTFZ5MzNBZDhTaWpsbUVOMUdVVURCa3pyQTQ0?=
 =?utf-8?B?LzZrR01iTFJDTmEwMnpmN2pjUmpMT1o5NldHTmpxZldsWFNUM2ZjTnZ6bGFG?=
 =?utf-8?B?OGVmRW1CclN4M01PdGszUXNhSXJqVUtTNjRDRG9POU9lSzVZaTk5VUlIbVlN?=
 =?utf-8?B?cCtpc2tESm14aWc1N3ZpRUpWTnVkenp0cjVvZnJKaEtRUXd2WDVQUTJaczFL?=
 =?utf-8?B?TVdKSWpEdWw2Yk1BRjRVRTdNbVhyVkpzenhldEt0alBXaXBqYlhHVEpic1hi?=
 =?utf-8?B?MnJpVEF3OFNob0NGcXEvTit3NWpJdWNLM2FQOUpsMHVXV1N0ZktuMlgwNHhE?=
 =?utf-8?B?VFRDU0VvQW1IMUptVlI0Q3BJdlNxRTBFVVN0M0tPbFVlWTZISmdwSzRnOWRF?=
 =?utf-8?B?UWxiTXAyc2xJcElqczRmSGpNNExlamtVSWZBQXlMbEtKaldMVlFyU0VKOG1F?=
 =?utf-8?B?MjBiNDhKejNkSVl0TFBqRTk3NjcwSXROaVZOTU1BbndiY2FKRVBwMzZDV0Nm?=
 =?utf-8?B?emM3OFNUMzMxSzYwM3RNY004Ni9XeHNPeGt5UEJxUVZNUG4wS1VndkY3aU05?=
 =?utf-8?B?V1N2azYyM3p6elgxNGZnNnl3SG84NU9LMkMxZHZwVkV5WC9QSThUUHRmdGxR?=
 =?utf-8?B?Qmt1L05OZE5ZcjdmVDNHUUw5aW8rVVZjK0g2T3Y3bVB3Zm03QndVR21xSGxl?=
 =?utf-8?B?akVQcVl0MzJjVWdjTXJRdU4ydDVYdFhJczR0Qk5RcGV1OEgxVitEcU1NaGxO?=
 =?utf-8?B?MzRqUm9KSURuYm9PbkxEdXF5czRwbEFUSE96RC9yRjZiOTNtRUtTbndRenVy?=
 =?utf-8?B?dmN5bTVJWlY2UHBZaFhhN1pNWHNTZDRrWnhDcmRuZW85d2Q0bWwyVnk0dFhZ?=
 =?utf-8?B?cjBMaVVVejZmQzUwL3VjVmQ3M01tK1F2ZGE1MXQwMUNPRUp3ZXpzdVh5WW91?=
 =?utf-8?B?YUVQZ3FCM3FMUENvR3orWVhBOHZMckE1NENSQjl0Ums0UU1uOURzK21mQmNy?=
 =?utf-8?B?NzBVdnJxbXFUY3p4YTFVM3Q3WHVtUWtHWkp0MW9WZzAydEFqaEpRbm0xd0RT?=
 =?utf-8?B?NXFHRlV1aGI2WlB0bjVYdDVlSWdVVTVaUk53aVU4dU5OUldPaUxNajhYenNa?=
 =?utf-8?B?Q29EM3RacTRlTnAyWlhqaTlTMjAwOFF5V0hGS3kydHVLMUJEandPOE9yVDdm?=
 =?utf-8?B?VDltVHdWbHplRC84T05tWXhLM3pYdThDRVdpZWNBOVJUbUZmTnc4TXVOa3N0?=
 =?utf-8?B?eGIyR1ZNVGdvYlE2U215Y0tYN0xoUG10LytBOTdhSWNZNTBaNFNoZWtsSTRr?=
 =?utf-8?B?RDZDbkZycXV0RHNGaHJJb0pyRi9Za0JOUGIzaFMraTB3aSs4RzhaWVcyYlZk?=
 =?utf-8?B?TEN3S1MvSlp2REJ6c2RjeWw4N1dtc1FqTnhzZE1jOHpHK09WMmNpc0dnSkNw?=
 =?utf-8?B?UmNLaWU0TUkvcVpTaWVIWTFxd0Y3YnV4WEdQVHM0YWtocVdURStLYnZmZ3oy?=
 =?utf-8?B?RWpPUXJsR1VDcmZSOTVUNm5EUjV0V1F0S0NGanRFa2habVJNa2tGL0dTeGsv?=
 =?utf-8?B?dndJMXBDUG9QQkthVVVKK3JGVlJRbklKbHMxNUp0bDRFUU9YMnVBZkNlTWk1?=
 =?utf-8?B?VlU4YlNvUTNXaXRXRkJTaFZsTHZhbVAwVCtCS2VZMGpKbWRydHkxa09CN1lL?=
 =?utf-8?B?dG9NUUtEK2ZqZjJVdm5uVUh4SENRNm0wSXluRUl2a3JHYWh1QkVWWGRyUEVr?=
 =?utf-8?B?eFdSVUJSaGFVWEc2dEpHRnFVT2NiT0thQTJRV0pNd0o2Nmx3QXBDbFJjaVFL?=
 =?utf-8?B?NGpJajdsMVhLaHFHN1FhL1BwRkhYcll4N0FSSk51NXRaVkxMTVR5NVIxUHR0?=
 =?utf-8?B?dlErQ2h1Ynpza1kzMGIvd1d5RU1pOEtoNUg0N01ZYi9BSElGVktjOHJBbUVx?=
 =?utf-8?B?eTA2UGkxNXhEUjg1S2RMbDYzWkFlcGxMZHVoaWcvWDFPRmM1SWhJMi9OYkhj?=
 =?utf-8?B?emxId3R5R01LNndubVZCNlVlZXFWd0dCSDMrSDB3bHhldG9IdGVqQTNUd0lo?=
 =?utf-8?Q?NctJJRDHXZJPz4JjmJqAtbRzR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd1ff02-525e-4a9e-7f7c-08dc65ffbd91
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 14:47:05.2754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PCcHPIhIf99nm6Y7jsLxwe8BA8wD6og91oUrfC9rfj0cjae9YYAxOqpIXTuoFkC8xsVAmUaz3nxxyO7esUTznw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8714
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240426_074713_670186_70BFCB6E 
X-CRM114-Status: UNSURE (   7.68  )
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

On 4/26/2024 9:21 AM, Borislav Petkov wrote:

> On Wed, Apr 24, 2024 at 04:17:09PM -0500, Kalra, Ashish wrote:
>> With SNP guest kexec and during nested guest kexec, observe the following
>> efi memmap corruption :
> Before we delve any deeper here, lemme make sure I understand this
> correctly:
>
> * You're in a SNP guest and you're kexec-ing into a new kernel?

Yes this is the case, where i am in a SNP guest and kexec-ing into a new 
kernel.

I should have mentioned *chained* guest kexec above instead of nested 
guest kexec.

Thanks, Ashish


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

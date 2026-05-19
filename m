Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DBECD4851
	for <kexec@archiver.kernel.org>; Tue, 19 May 2026 03:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uKeCz0xZgbAJ2xS2UESSR+0rI6RswAdNRa80Mk+ni94=; b=ftLIk8HzDCi8SECBFwmO1++h4m
	UaXxC+LUfh7BWQ9HYLp7kO30JeWHXDg1Oymun9/WjmyA3lWrw63GdbbCGSVda4/+ZG8j4dWVbbXCf
	zKCd3NTXbccPK54L+hPIzOyuCehs+BppqZaHr5KrjohBEJelEuvCPIKqnnd5/VaFKbK+NSoqmnZXK
	Dn1VPoO1e85uPBOm1/b7HRwLWY9vrT4krSGO2bsc7aeCrxXS33rDyrHbAtBteWMRXV2JoG/wgxwbg
	fQQ8wTwQ/2Xq/o3jVPu48uo3HEBihK2A2CrNw4PpBjUoidchkhBisqpwQ15plmWELqhDcQ3Hnp+RP
	eV4K7aqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPB0L-0000000HYYl-04dd;
	Tue, 19 May 2026 03:20:25 +0000
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPB0C-0000000HYXj-3oph
	for kexec@lists.infradead.org;
	Tue, 19 May 2026 03:20:23 +0000
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J2X5oP2726387;
	Tue, 19 May 2026 03:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=uKeCz0xZg
	bAJ2xS2UESSR+0rI6RswAdNRa80Mk+ni94=; b=Ds4sTax1GCTqwZJfq8cFT5AHe
	d/ZPXOVCAoxte2mJxu4o15tUiUD2bIUcCjQmosK6/Vv4kJ2qBxvV6+AVkWpOCNTg
	pzy2ycPFJMyOOjdZlB2jPNiRcj15UvogyUA/Q7dduMaPrUf8MCp40IcZVH2Nn5PF
	DQeqgKkVcBnenRGSfnmiW2/zGtU3HV7fMosv7eBl5sLnOX/u3i+LvwG0V/FFH/KX
	LyG+2DFKFLlJFW+7j3g5BopuPin/pg8UQ4ghIAQWambiRwApCBpNqqRKJPHxf+Qm
	skl129XbvUGBLXd1KJaAOMr4FNknKuzeIVJukemuGTpbv8AuI90DImzVTvwAA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011024.outbound.protection.outlook.com [40.93.194.24])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e6fj3tymm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 03:20:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hce6SYmr9AAKs4yjfSNOd+mj42Ay4wxVMaiYUnlZRhVGQjcZx1nsW0lTUQDNBe8iTweKPAVn7+sAV6wFmeZd0KvHtUHMe90PW1kXZjtXGpF+a+EAJIvk/nqAPHTDbJNLc8HE3KusDe5DFJUJc4AvfgG5cdZ8SFnvV6Crzmt95awQPYCQmkS6CFx1t+tlX+gGe2f5D8HfdmIezr0/yeY5PnqFA/1Wpjf4OvMecgwdA4n9KRrY8+MRa4lIsEEOc0dsol9/7oNOTfG4r0Hbr1iIrQVbDEy+2KkcHyCzms3+NWzs6ma7VDJLykxs4BrTwtQ9Ba1XPmM1HG4SvqCeM53iUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKeCz0xZgbAJ2xS2UESSR+0rI6RswAdNRa80Mk+ni94=;
 b=aCEZzLvBNcbFx/2cg8eyBHgip2bP/ueZ2+l6RK+48p237y4rsVJgAtWM7Xnm0eWgMhC4Pnz2tlg9/isLl05MFeQsRV/vldtJIdPB9T0DB0Ih9paqPL37CwpTdbWyggonRzD2IOpp33XXBO4KlfhTsWJqe7FLb1JSFf3onqZ+g8i1qeA9NfbiP5rzvMBXyBBmMRLLTBJGbvwKX0W4zE3b/Dg0FrtlZZx4dZsbR1yGyPNI/bwy/It0nIv4KfDWxnX5VMcQlVrJdbhcKwcowL6eflrfCmAmh2gbDsHOq6ZrWFud8bGXD1oot5lEp1UYBKn/Jf37RWJl99RO47ODLdmJKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN7PR11MB7017.namprd11.prod.outlook.com (2603:10b6:806:2ac::17)
 by IA1PR11MB9469.namprd11.prod.outlook.com (2603:10b6:208:5b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 03:17:40 +0000
Received: from SN7PR11MB7017.namprd11.prod.outlook.com
 ([fe80::44b9:5767:8577:dee8]) by SN7PR11MB7017.namprd11.prod.outlook.com
 ([fe80::44b9:5767:8577:dee8%6]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 03:17:40 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: k-hagio-ab@nec.com, yamazaki-msmt@nec.com, bhe@redhat.com,
        kexec@lists.infradead.org
Cc: Xiaolei.Wang@windriver.com
Subject: [PATCH] arm64: Add 5-level page table support for 4K pages with 52-bit VA
Date: Tue, 19 May 2026 11:17:06 +0800
Message-ID: <20260519031706.3511081-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0011.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:9::6)
 To SN7PR11MB7017.namprd11.prod.outlook.com (2603:10b6:806:2ac::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7017:EE_|IA1PR11MB9469:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ebdacd-0888-4c8c-7a0d-08deb5552f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|52116014|1800799024|366016|11063799003|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: CAWZZHjefqukiqgn5x9el9lmSy1m5/pm01PxCh4//8ZLS3COPKq751pel7YdSJvKR+MeN+t+K5xn4tt46XdW5fPJxwcfvXuG8+eEP3jnEY8mQBSUIHEz+5QGFqpyjtH07M9aH+SEnp4KWaV3zAzIkYX9BhaSfXKTvykvm6elew6ZCP6GddSHd1Xf91Yke9wb56SXrSV9+QQ7P+S0NrTJmIegyM5xT+daKjtxbmEXsxiSFEaZG+EbbIzKK0gSJFylWiZ8RMJZpd5B5LxBLuWCkdd22GGzOKP+6XZlyylN0krxsZCwK0g+GtrSuLwLGIjXBDE9QSEbt4zJPkDX2pN0Ygwvg51QgS/lhD7ee3lS6arfbtAbTcP52OjqT14/qHigBJvvhzEhcz9m4v6nj+S2vE6HrNUYTnRm+gpmB8mgz73v3aekHrd69uHAWzMFcrhRmL22Y7uhdkJOyYd9uQCOKieFDWQx1m494eLCGIWftl7LWYkIrfVASdmzGYQcghox7ekXy6j52Q5FWZTXaXBpOfageQeoRlAO7AAtIa2pF3RJ34prHFAqXTMNNGS394q/svq24Dro1ARq9d0ZdibbzJBJt1SewnsAHI/vUrOTjBQb49HSuAURV6w2B4rNSSx85trWU8eE9nZeBAqCOtKyOeBT3dkdY9q8BdVF4DZtmj1D6l2WY4z94OcNIVm3KxWt93xATioBcZQPUCw25Y67z++9gbxf7uGBXXLvxOEABpOW3ildiS2PMftCNvBmKZfb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7017.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(11063799003)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWttMHdhVzlsbTIwT0ZWZGFPTy9TcUJxWlRjb2VxclJQL2FyV3NqWnBoL0hI?=
 =?utf-8?B?aFp6ZkJELzRqUGtEbVVtUDJZRjRrMDJTU3RFQUZMRGdiTEh5YnRKNkNGa25m?=
 =?utf-8?B?RDRZVnMyTEUvSWRvSSttSEJvZDR3MzAvZFh4OHA1MzdZcmgwRmxYalplOXh2?=
 =?utf-8?B?RGprZTk2QWpHR0V2aWQ5ZzAwbmhwOGNNdDAzOUFsL0l2WjE3ZGVCaTBiYXlH?=
 =?utf-8?B?VXdQUW4rUE9KK2tlbklXTTRPRmhQUDB3aE92ZldncFkvSEc5WFp3azBGL3JO?=
 =?utf-8?B?SHNsdzV6SVY0dEtJWlRjNjFhYXNJZ3ZJd3NKWGtxU3BoUWNTc2RVYWVmckh6?=
 =?utf-8?B?blhYdllQM2Faa3J0L1hUdzY1bURDRnA2dU1EdUhuNHhROVkvdnIrOE1uQklS?=
 =?utf-8?B?NThnRndEMHRkS0xYU2k0SDh5RFJWaU81dTJ6OUZZcGdYN3QybjdKYTh6UDU3?=
 =?utf-8?B?TjIyU21EM2FadzdxUGVNeDZBaTRGTFcvWFgweUZGeWxqaG85OThRVHFYRnNk?=
 =?utf-8?B?NFNjSzZLbmpzTkRhWnJycW5lRnFYRVZncU5ITFlMblRVZHoxeWNkcmhiMHFW?=
 =?utf-8?B?M3J6ZzRKKzBSZWpvRVNnZGkraUZqNWdVVGJRWndZMkZyVTdscktHZVJsbm1W?=
 =?utf-8?B?aHRkeHNMWkkreGFDWTluaHpEU2RpeEkvOWt4RnBWT1k0aDNWN3RCTlFUK1Y1?=
 =?utf-8?B?c2FLUHBmVFFVSFBkelFwNlhZcEYrQ1crZkVNUVR0YTR1aHVJNHJaSFF6QU5J?=
 =?utf-8?B?eStSMWNKQXVDMU5rZE5uQ2FTZ0FNT1hlUmdzOHF6ZWVrOTRVOTJMZnNNYUZ0?=
 =?utf-8?B?enVqSXJuZDltUFJiWTlheDlQcmhwYzRtRkx3NG9PSExCTmJhSUJVRWYrczBE?=
 =?utf-8?B?VUJBOVFkSm52eks1elByR0xxclBSVm81b0FDdERHNkNvekYxVzhFVWdnTU54?=
 =?utf-8?B?THl4bmtHSnd2U3ZmL2dSOHpXOWdEa1JSRkY2NVBmQjNmTHdHZk1pVktHZTBF?=
 =?utf-8?B?VVk0eGtaRCtnYWV4UmgwbXVNVjVSc1hyQTI1VnRmdG9QalM4TzRaZ2VHZm9Y?=
 =?utf-8?B?SW1pUjV0bHplc3dJdllKaG1LVVIzQnR2VC84NmtHZEoydXk4N0xySGVya1J4?=
 =?utf-8?B?VVZoVWRnMXBxZFRlcE5lM0ZNUlF2WGpkT1hEamtuZXQvdzlaNTNiVW9TR09S?=
 =?utf-8?B?K0dRRWUwQm9nQnhUcEk2ZGlIb0FveXVKNnRkT3hUOUMwcnJnMXpPemdCQTNG?=
 =?utf-8?B?ZUMvdi9ZbjMra04xcjAwK3NpYXcwMlcxZkt4dWxYRFJWekpMUlFKM2V5ampJ?=
 =?utf-8?B?RUxiVFFFaWp2a0VhVUZrVUw3clhWd2w5SVRzbDBqN1ZYQW1oZmtveTBpbEla?=
 =?utf-8?B?MnMxdzl1QzVIZm9BdHU5cDBYeFlPNWlqWEtMMVkxeVpyZmNlUVd0OEgrcXh4?=
 =?utf-8?B?c0dXRzF2R2pET1ZRZXhzN0FwV1NQTE1rT3hkV2dYOXNjV0hsR055cVB3eEZu?=
 =?utf-8?B?TmpDSXNJZGNwQTNuM0VOVjg0TzlxSFp1Vmx3VldkQW5KSFRFblFldzZXekhF?=
 =?utf-8?B?Qm55aDhJWUhoRVltbVI0VWIvTHhySzBvTnBMR25teEN6YlBwd2prc2VRT3M5?=
 =?utf-8?B?L2J4dmkvdkgwV2dkT3hWdWRkL2F2Nmh1MlZEUkVOaXFwUm95aTQyeU9pMGww?=
 =?utf-8?B?THp1YUhPOW5KMzNRT3pmbnp4Q2t0SUNsdjdUVmNqdUdzYlQzZkdhYmRYUHdp?=
 =?utf-8?B?V04rUGZrRmpKVUIxekJCaWNDRVdVWnZTbE12OTVJK0wrVk44djNYUlA1OWdt?=
 =?utf-8?B?b2xFbXJzNnBONWJMTk9yNDRPWU9nbllaZ2dZV2hldTFobG1vd1o1RGk0Q25u?=
 =?utf-8?B?VStTR3h2S1JOU0tiYWZNVlQ4cTRUanNDMCtxSGl0dndDWWlBN0IrdnRlc2E5?=
 =?utf-8?B?MHQxRXVaQVdRbS9Fa0FQVXpjQmVsUWhXT3J5dWFsbGp2eDU5b1FRNGNxNmRH?=
 =?utf-8?B?ZngveHY4b1RQSzFRcG5oUGZEWVR4WTd2bWwvcFpaOEVPNE15TVdlZDYvR0pk?=
 =?utf-8?B?eTFEQ3RNQzNVVUFKQ2puTmUxY1dPMzRxVlFWM1VRSGFXNHNXSXphS0VQS1BP?=
 =?utf-8?B?NDBJSjBDajY0Z2pvcmlycllSVkw0dUs2cVUxaEZTRjFxTXZLUVJDdFJRRVI1?=
 =?utf-8?B?cHhxakt6SXpNcytQQ25EMWlOdUoyTVVXcng5V251dzh4MDBhOGwrZmk0NVQ0?=
 =?utf-8?B?WVRUNHRoMlNBbnBRcE1jeEpBN2VvMUd6ZU9Vb0JHQVdXN1hNV0JNZ2hSR0RN?=
 =?utf-8?B?RS9WN0NoZHZLY0JDVnkvMFQ5TzBWUVRya3BBWlpPTHRzNCtyRzBPMjdSY0wx?=
 =?utf-8?Q?vTTDydk3iLau7Vf0=3D?=
X-Exchange-RoutingPolicyChecked: HGEH+aGO4Ht7AKCkyw+BcWckEEs0lA7iLgJEa/8oKrdAWOXqB0k9YYD30SCGBIKoQGu0xWinaBB5qXNciYZnZJKVn72Ixa2xAHBxd3QzcKWKsFx0xuZo9hiLwu2WAVIpQTXkZHtRfOmkuwfFiSk5+TdE08R/msWXWsxMn74eNMyly66x816sYGTUH3vlArwv/GdWRv0hWrgg47YkTqiOvqwDhUej0qfiO0eKpVBCmCp/VxxV8XY2A6ZA2s5mp61L1L9Cy9hEwT4Si8Js0ApXN91sXEmj7pm9TiwWK6wBHAfKgPm+kVcnAOhg1ZETftrDy5t4Q3q9QEM/5KKUTWsmWg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ebdacd-0888-4c8c-7a0d-08deb5552f12
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7017.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 03:17:40.2357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2gm6yUtnS0YA+xQVqavuDAXzO2A+/x9TDooMcLuQ9xqISAGHvdSo+HJO3M8ltOqdhcGdSJmrGK8YfqAnQeTJ6cLNuFFCLNCVw4sF//SwgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB9469
X-Proofpoint-GUID: qj5p3HiHtNgjlw2PCOWANvWVr9VHSrSv
X-Proofpoint-ORIG-GUID: qj5p3HiHtNgjlw2PCOWANvWVr9VHSrSv
X-Authority-Analysis: v=2.4 cv=VssTxe2n c=1 sm=1 tr=0 ts=6a0bd6ee cx=c_pps
 a=msEVGK6UkFBbvU8JCjtEeQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22
 a=NEAV23lmAAAA:8 a=t7CeM3EgAAAA:8 a=OTys4zslBkZrtpy6fE4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDAzMCBTYWx0ZWRfXxmxND7Ke6jQl
 Jfpohx2CGMuwPUIv7q7hTNgbgHZPWv+afYirpP6WRDfkRWiDeSgLvuea2z9LiH3FmL2WeLU3oHx
 Q9X7cznP4yydgeBke2A8Jw1o/hs8XnhOB5oiYp7jnwg4zm8NezhSJZcvdiaTC+LN9Wfk4xGdWfg
 EOku2YmW2tL1Pd0oFurCaJySX8uGoQDF8LfXJt6ocOFA0C1BVtO23AXv7ZTDdKWyz8ZGYmmdG+Q
 CbTGYghhvuSCkzJqI5qXxxJBpzoSSf/9cdu2qFJulKJna3hpmGI8MvWhjlpgb+KS92ZWlxsy/Yt
 JYlvOYXld1AYB4vYbMZ2yi34gsHcW+lnfG75EDSxS1/jkTOKIu1/xhjWaCPhiCXiVwsXLP3UwqX
 krM974IrUVrNnWIe/6SWQY5miFBNyn+uOJjCpMdFqq7ilIxFifR9hWI01HkHH+3vgkCKJfDxPLs
 /8ScmCxZIUnbuOCj59A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190030
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_202018_015547_2C20D849 
X-CRM114-Status: GOOD (  16.76  )
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

From: Xiaolei wang <xiaolei.wang@windriver.com>

makedumpfile fails with "PAGE SIZE 0x1000 and VA Bits 52 not supported"
on ARM64 systems configured with CONFIG_ARM64_VA_BITS_52=y and 4KB page
size. This combination requires 5-level page tables, which makedumpfile
does not currently support.

Add support for 5-level page tables on ARM64 by:
- Adding the P4D page table level definitions and helpers
- Updating pud_t to contain p4d_t (reflecting the correct hierarchy)
- Extending calculate_plat_config() to recognize 4K + 52-bit VA as
  pgtable_level=5, and 16K + 52-bit VA as pgtable_level=4
- Adding p4d_offset() to handle the additional translation level
- Updating vaddr_to_paddr_arm64() to walk through PGD->P4D->PUD->PMD->PTE
- Using vabits_actual instead of va_bits in calculate_plat_config() and
  PTRS_PER_PGD to correctly handle the case where the kernel is compiled
  with VA_BITS=52 but the hardware only supports 48-bit VA (runtime
  fallback to 4-level)

The pgtable_level assignments follow arch/arm64/Kconfig:
- 4K  + 52-bit VA → 5-level (the only 5-level configuration)
- 16K + 52-bit VA → 4-level
- 4K  + 48-bit VA → 4-level
- 16K + 48-bit VA → 4-level

Fixes: https://github.com/makedumpfile/makedumpfile/issues/18
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 arch/arm64.c | 89 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 74 insertions(+), 15 deletions(-)

diff --git a/arch/arm64.c b/arch/arm64.c
index 1072178..f3f33e4 100644
--- a/arch/arm64.c
+++ b/arch/arm64.c
@@ -29,6 +29,10 @@ typedef struct {
 
 typedef struct {
 	pgd_t pgd;
+} p4d_t;
+
+typedef struct {
+	p4d_t p4d;
 } pud_t;
 
 typedef struct {
@@ -42,6 +46,7 @@ typedef struct {
 #define __pte(x)	((pte_t) { (x) } )
 #define __pmd(x)	((pmd_t) { (x) } )
 #define __pud(x)	((pud_t) { (x) } )
+#define __p4d(x)	((p4d_t) { (x) } )
 #define __pgd(x)	((pgd_t) { (x) } )
 
 static int lpa_52_bit_support_available;
@@ -62,7 +67,8 @@ static unsigned long kimage_voffset;
 #define PAGE_OFFSET_48		((0xffffffffffffffffUL) << 48)
 
 #define pgd_val(x)		((x).pgd)
-#define pud_val(x)		(pgd_val((x).pgd))
+#define p4d_val(x)		(pgd_val((x).pgd))
+#define pud_val(x)		(p4d_val((x).p4d))
 #define pmd_val(x)		(pud_val((x).pud))
 #define pte_val(x)		((x).pte)
 
@@ -75,6 +81,7 @@ static unsigned long kimage_voffset;
 typedef unsigned long pteval_t;
 typedef unsigned long pmdval_t;
 typedef unsigned long pudval_t;
+typedef unsigned long p4dval_t;
 typedef unsigned long pgdval_t;
 
 #define PAGE_SHIFT	PAGESHIFT()
@@ -101,6 +108,14 @@ typedef unsigned long pgdval_t;
 #define PUD_MASK		(~(PUD_SIZE-1))
 #define PTRS_PER_PUD		PTRS_PER_PTE
 
+/*
+ * P4D_SHIFT determines the size a level 0 page table entry can map.
+ */
+#define P4D_SHIFT		ARM64_HW_PGTABLE_LEVEL_SHIFT(0)
+#define P4D_SIZE		(_AC(1, UL) << P4D_SHIFT)
+#define P4D_MASK		(~(P4D_SIZE-1))
+#define PTRS_PER_P4D		PTRS_PER_PTE
+
 /*
  * PGDIR_SHIFT determines the size a top-level page table entry can map
  * (depending on the configuration, this level can be 0, 1 or 2).
@@ -108,7 +123,7 @@ typedef unsigned long pgdval_t;
 #define PGDIR_SHIFT		ARM64_HW_PGTABLE_LEVEL_SHIFT(4 - (pgtable_level))
 #define PGDIR_SIZE		(_AC(1, UL) << PGDIR_SHIFT)
 #define PGDIR_MASK		(~(PGDIR_SIZE-1))
-#define PTRS_PER_PGD		(1 << ((va_bits) - PGDIR_SHIFT))
+#define PTRS_PER_PGD		(1 << ((vabits_actual) - PGDIR_SHIFT))
 
 /*
  * Section address mask and size definitions.
@@ -178,6 +193,22 @@ pgd_pte(pgd_t pgd)
 #define __pgd_to_phys(pgd)		__pte_to_phys(pgd_pte(pgd))
 #define pgd_offset(pgd, vaddr)		((pgd_t *)(pgd) + pgd_index(vaddr))
 
+/* P4D */
+#define p4d_index(vaddr)		(((vaddr) >> P4D_SHIFT) & (PTRS_PER_P4D - 1))
+
+static inline pte_t p4d_pte(p4d_t p4d)
+{
+	return __pte(p4d_val(p4d));
+}
+
+#define __p4d_to_phys(p4d)		__pte_to_phys(p4d_pte(p4d))
+
+static inline unsigned long
+p4d_page_paddr(p4d_t p4d)
+{
+	return __p4d_to_phys(p4d);
+}
+
 static inline pte_t pud_pte(pud_t pud)
 {
 	return __pte(pud_val(pud));
@@ -237,13 +268,22 @@ __pa(unsigned long vaddr)
 		return (vaddr - kimage_voffset);
 }
 
+static p4d_t *
+p4d_offset(pgd_t *pgda, pgd_t *pgdv, unsigned long vaddr)
+{
+	if (pgtable_level > 4)
+		return (p4d_t *)(pgd_page_paddr(*pgdv) + p4d_index(vaddr) * sizeof(p4d_t));
+	else
+		return (p4d_t *)(pgda);
+}
+
 static pud_t *
-pud_offset(pgd_t *pgda, pgd_t *pgdv, unsigned long vaddr)
+pud_offset(p4d_t *p4da, p4d_t *p4dv, unsigned long vaddr)
 {
 	if (pgtable_level > 3)
-		return (pud_t *)(pgd_page_paddr(*pgdv) + pud_index(vaddr) * sizeof(pud_t));
+		return (pud_t *)(p4d_page_paddr(*p4dv) + pud_index(vaddr) * sizeof(pud_t));
 	else
-		return (pud_t *)(pgda);
+		return (pud_t *)(p4da);
 }
 
 static pmd_t *
@@ -257,20 +297,32 @@ pmd_offset(pud_t *puda, pud_t *pudv, unsigned long vaddr)
 
 static int calculate_plat_config(void)
 {
-	/* derive pgtable_level as per arch/arm64/Kconfig */
-	if ((PAGESIZE() == SZ_16K && va_bits == 36) ||
-			(PAGESIZE() == SZ_64K && va_bits == 42)) {
+	/*
+	 * Derive pgtable_level as per arch/arm64/Kconfig.
+	 * Use vabits_actual (runtime VA size) rather than va_bits (compile-time)
+	 * because the kernel may reduce the VA space at boot if the hardware
+	 * does not support 52-bit VA (LVA). In that case va_bits=52 but
+	 * vabits_actual=48, and the page tables are 4-level, not 5-level.
+	 */
+	int va = vabits_actual;
+
+	if ((PAGESIZE() == SZ_16K && va == 36) ||
+			(PAGESIZE() == SZ_64K && va == 42)) {
 		pgtable_level = 2;
-	} else if ((PAGESIZE() == SZ_64K && va_bits == 48) ||
-			(PAGESIZE() == SZ_64K && va_bits == 52) ||
-			(PAGESIZE() == SZ_4K && va_bits == 39) ||
-			(PAGESIZE() == SZ_16K && va_bits == 47)) {
+	} else if ((PAGESIZE() == SZ_64K && va == 48) ||
+			(PAGESIZE() == SZ_64K && va == 52) ||
+			(PAGESIZE() == SZ_4K && va == 39) ||
+			(PAGESIZE() == SZ_16K && va == 47)) {
 		pgtable_level = 3;
-	} else if ((PAGESIZE() != SZ_64K && va_bits == 48)) {
+	} else if ((PAGESIZE() == SZ_4K && va == 48) ||
+			(PAGESIZE() == SZ_16K && va == 48) ||
+			(PAGESIZE() == SZ_16K && va == 52)) {
 		pgtable_level = 4;
+	} else if (PAGESIZE() == SZ_4K && va == 52) {
+		pgtable_level = 5;
 	} else {
 		ERRMSG("PAGE SIZE %#lx and VA Bits %d not supported\n",
-				PAGESIZE(), va_bits);
+				PAGESIZE(), va);
 		return FALSE;
 	}
 	DEBUG_MSG("pgtable_level: %d\n", pgtable_level);
@@ -548,6 +600,7 @@ vaddr_to_paddr_arm64(unsigned long vaddr)
 	unsigned long long paddr = NOT_PADDR;
 	unsigned long long swapper_phys;
 	pgd_t	*pgda, pgdv;
+	p4d_t	*p4da, p4dv;
 	pud_t	*puda, pudv;
 	pmd_t	*pmda, pmdv;
 	pte_t 	*ptea, ptev;
@@ -565,7 +618,13 @@ vaddr_to_paddr_arm64(unsigned long vaddr)
 		return NOT_PADDR;
 	}
 
-	puda = pud_offset(pgda, &pgdv, vaddr);
+	p4da = p4d_offset(pgda, &pgdv, vaddr);
+	if (!readmem(PADDR, (unsigned long long)p4da, &p4dv, sizeof(p4dv))) {
+		ERRMSG("Can't read p4d\n");
+		return NOT_PADDR;
+	}
+
+	puda = pud_offset(p4da, &p4dv, vaddr);
 	if (!readmem(PADDR, (unsigned long long)puda, &pudv, sizeof(pudv))) {
 		ERRMSG("Can't read pud\n");
 		return NOT_PADDR;
-- 
2.43.0



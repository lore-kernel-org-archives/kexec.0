Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45865CD8CAD
	for <kexec@archiver.kernel.org>; Tue,  9 Jun 2026 05:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:Subject
	:Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SKLzd99bi2DlBGXjGXo8xbYGzdFmEqjkpIZZgc0LbLo=; b=bnKrohgT5uPpcyucIQCqmQd9Z+
	nj2sG4VJDahI7N/VY+hIKzWDalUrIb/z9/+PhhwwAzOfwR6vlWytImcUiD6o7Xb9BLFny4MqW7Mmx
	oYERgSkS7/l0mhtC39dJ4nS9Wgb0VPM/wq+5BWiuKddna10swYzqiONkRXcmlISntQys7usW5KpWz
	SHFoR3wtg1im1jCeM9YQUpuvWVbB4JZYcvok9bUAsQTO4EGQLAhfowN6oGL8TWxzTs/gKpS+fy1SO
	Ns43JmI155Uh48B0mVBa00exZ/FA2zUl1mE0vj939jPDTO1xDkg7Hg6+/tDQZ8sfz3BIRlxdxIKWm
	U+RuNomw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWp7A-00000004lCG-358I;
	Tue, 09 Jun 2026 05:35:04 +0000
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWp72-00000004lBL-0Zaw
	for kexec@lists.infradead.org;
	Tue, 09 Jun 2026 05:35:03 +0000
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6594slvU1958966;
	Tue, 9 Jun 2026 05:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=SKLzd99bi2DlBGXjGXo8xbYGzdFmEqjkpIZZgc0LbLo=; b=gjBYid3sR6op
	6zl06Y7WjcbSORGPCn2rih0Vf6cGwPOel/6vZUR6kDCgm2yvBB8Rul5fRvGt0u4+
	MOP2AkDP5cbIR4PwINAlF9w+ed7hi56lZVO9BNPRtWxm1CP6lY2G+KO1UtDFy/EP
	mMUOOyft7kcQuD/xOjduLusm3Mjy8hOODoU0lHYbqk77lQassfX5lXM5vjJE0md8
	e+E5z7jznKe4rEBfxy5/OEak6BaegYyDxUTVmnEluixT2ryIxvByKT1FVG3e7fQ2
	bRS5JY5G/pujhiGFzY+gH7zn8QIZxYU6pKygUV+TuSzyb/+7jpxbZVhV6aNZuoBM
	Mwn25Vn3iQ==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010040.outbound.protection.outlook.com [52.101.46.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4em8rxm457-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 05:34:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vk8r7gU+Xm7GeYEaoY74Aw8oOW8WSuolGnSYflky4YauIMtU+adwgBuwkvoJOZD3gzXXmd5Rt7wxSR1dGMCcPV1V3AmFV4hourwgpXELAG+vRDsE3JSjzcjzphR5G6SU8isJFleA8ABkPII17LgdQwXSESFxHHaQYCiBt2dpTDOFewuQjIjCsx1vyof9SmLAMZ71yqukQKqnFtuDkVv6dEhSTcDv3xQCfX8SEskXeCKyJnLSA6H015WBDQVCnzoRfdwEKicN5QJXUDyTq4GhysZiT9aYottV/L1M1GF5/GAEVYD7KRtuCNW2H51bDHPDeLiesMN1/BGxZc9XfAPciQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKLzd99bi2DlBGXjGXo8xbYGzdFmEqjkpIZZgc0LbLo=;
 b=EYVgOyyxBLf2FcZ3pRU7eajp+YxwyBuSMkR6khLZhtCMm36yc6JZVixLvfykqzCmnytZ8B/GtXyotvZHykIJH6z3YybZZJIaHRxc45F5NL9Yqui7z+2m5Zt2UcK3jKKC8tYIh4U1Drk9F8jfO8oNf9ivJRGzv4dkyrwrCFryA9qDwN6T/mi5oCA5xhwopWv6bM9vTlQNCj0jZ95xzrflhNuLp/SFP4NGGDOJytQcrGM/+TOnjUnjLJlKpBgPDLOn2dSjCd/qxQZxrEVwELQjADi5VmA5QF7dtjdR5TawV7HR0gUh0YuO8XAgymsd5H7G1cMiIOVGgJeg/ygYo+7GIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN7PR11MB7017.namprd11.prod.outlook.com (2603:10b6:806:2ac::17)
 by DS0PR11MB6544.namprd11.prod.outlook.com (2603:10b6:8:d0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.13; Tue, 9 Jun 2026 05:34:50 +0000
Received: from SN7PR11MB7017.namprd11.prod.outlook.com
 ([fe80::44b9:5767:8577:dee8]) by SN7PR11MB7017.namprd11.prod.outlook.com
 ([fe80::44b9:5767:8577:dee8%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 05:34:50 +0000
Message-ID: <e1611077-48de-441f-b86c-4b4e221fbd27@windriver.com>
Date: Tue, 9 Jun 2026 13:34:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: Add 5-level page table support for 4K pages with
 52-bit VA
To: k-hagio-ab@nec.com, yamazaki-msmt@nec.com, bhe@redhat.com,
        kexec@lists.infradead.org, xiaoleiwangxiaolei@gmail.com
References: <20260519031706.3511081-1-xiaolei.wang@windriver.com>
Content-Language: en-US
From: Xiaolei Wang <xiaolei.wang@windriver.com>
In-Reply-To: <20260519031706.3511081-1-xiaolei.wang@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::31) To SN7PR11MB7017.namprd11.prod.outlook.com
 (2603:10b6:806:2ac::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7017:EE_|DS0PR11MB6544:EE_
X-MS-Office365-Filtering-Correlation-Id: b5d8b9c8-e467-42ff-15d4-08dec5e8d34a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 6DbN/nvudGsDK20M/vgUx5m6IcTYlj/ElH2/dmCuQspftamdJlJxRnXwk+kWmrSvbM7x+ruHme+mo97wNnBHuVP5KAdZ8xqD9teR0yQTjbWbcsuTT6VPkEjFv25W/A6qVyhoHzw+5YmsTQst57iXgc0ikp1jhXLmBCE1ZGsVU0c1KQhDlgprR4bhRuzS2eShL3j+gGuvrYolJYt9d9Fl7nT/y3iVIBW+CEode5h4gHdw5my16BC2HU2b3HdOlcSqfjSOOpsnq5NRR/S/5EujiggvokHYn6L4Y3iJ4uekKVNrSa6kSZPvj7T+TuLEe2lyLQBMvYryUkjq0Zt4TpQqAaCZst5E2+NewpP+/c5QEBoVWu/6vtUMAnaPmPfyVm3SNrWFMiAASXSualSVtJvG0uUwb2/Jb9RB46dFJW7cOwMRMaeuAZ96RUwTFwqJf1eH4RwzKbgASpcnB62CgwwjD2Uyv0xULruiDxP6DwPhVzoh22ixSAWQexO/ROMgGviL8L7ojdebMsnyI+wN0j1qXZR5l6NZLuC06YdSU7wqGd49U+qYwXmZhqvTAu9JVMNtPqb6G8siu+C1NPZal6lhArTb2xkendWnqmPYwE6DbwgXrqzhWoBszk6QRvCh7GVNRmDBLPDpmwyYJsR7cOJTIxhpPOgd3UewoMI+vx47mxgKvuUbBilVf7UPwiaTjQym
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7017.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym1oMTJCV1FRbm5hSjF1VjNQODVCSCswTndJdFRkZ1dnZEFBbkRGQndlb3h2?=
 =?utf-8?B?TGhVU0hzUWNRWm1mc2FDUzdTeXZ6OC9UUlg0blg1dk0rbjNjWDVNT3lVSkdR?=
 =?utf-8?B?SG5lYS9sYXA5WnJyaXdTVUZFamJMV2lKNTRDYlNNamtSZnRyN29xUnlpcXdr?=
 =?utf-8?B?ZmZaRGFmNkhHc3lxbk1PVnRzY05JaHNRWkdlc002aS9DSGxQdTA5WkhuNFJT?=
 =?utf-8?B?UWNidTVpTkZLa1FMZVN4ZHZEVC9aWFpyRm9wUHcvbkJmeHUvUFc1bWh3ZDhx?=
 =?utf-8?B?WE5hbHdRUTRYRXBFUHdnZVNEam9YOEJJbG9pbXBpR2Y4RDZUWlQrSyt5cU5l?=
 =?utf-8?B?K2hDc3E1bUIrcFhwSkF1MkhjQlBaMFdtTVZDYUpjMWdyRCtES2pVSldSRUlZ?=
 =?utf-8?B?U01xeGFja25WakJZWFJqL0xjTFB5cVJaakZIVFBFMHkyU2d3VDJPZ3g3L3JX?=
 =?utf-8?B?VEtic3hKcnlwY3FwdmgvNGc4UitieWt5S2JvakZTM2ZUN1FxaU5WNi9XY1BN?=
 =?utf-8?B?RXpUOGtHaEZlUnpsN0NwakZlS2hrRDNXN1d6bVUvOEdwTEJNeE5NeXcxbzZR?=
 =?utf-8?B?Q2RNRjVqSDRWMmR6QXB0aHI0UU9hZENndUVmbUNUVyttYVZXbmVWazRpWHlw?=
 =?utf-8?B?ejgxQmZGUlZsM3V3bmhsRGJmZGlvV3NzSzhTanhMRFFGemV5Z1FkNVU2c1dv?=
 =?utf-8?B?b3FWM2dyZTVaUEQ3RDBZYndsQURNZXVqRGVGT3NYT1RKWnU3eHozM3ZmZHFm?=
 =?utf-8?B?ektQWWc4aktmdE5DVXVBNWQyUk1YOVFQN01ySGFCMjZZSWdSKzZyb2FTb1Jz?=
 =?utf-8?B?bEw2ckhJRWc0V0p0ZnZGWTl1dkdoREpDQlhzNTdRSndVVDQ0MVFrZlIxaU5p?=
 =?utf-8?B?Y0JxUW1XNGd6aG91Qkh6ZmxvM2tpNWF1TnQwZzhzQ0RGRUVCS3hkeFpoQzBR?=
 =?utf-8?B?bEZvOU83OGZYM2ZkSEM3RGtxSFRaM2Q0YngzcE5jcGhDaU1WWm9pbWQvZDNh?=
 =?utf-8?B?cGt1UzFUemp1VStQdE4xbHJtTlMrRm5RblF4WHpxQTdtMkRJdEdMMFB2VDhC?=
 =?utf-8?B?OFhEZ0M0TUtuaDdqamhnUEw2eVJ1YnJnK2hPZ1ZMQTdpdERGck1ubzdua0ds?=
 =?utf-8?B?b0VtY2FJd2RSWTFyR3ErdFVIUFpiK1Y4Vm5lSXBTdFFwcmFkcXpHaGM1WDRK?=
 =?utf-8?B?TWF0SldxZXArdG9JR28zdVBHb2IwMUpSalR4dzV1cXhjLzBjc05LRXpaSzNx?=
 =?utf-8?B?Z0VFQXV3Q0F5Qzk4K2lYWGRKRng5aVRZeW9VUlk5L2Z4ZFcrN2JFdm45SFpi?=
 =?utf-8?B?UGNoTGpHaDBPNjN1U3B5TGtGNzRoVjJSa0EvN0VWOTZnTFg3TEhQOGFPR0tn?=
 =?utf-8?B?RnpZNiswN0FRZ0RRTHNwUHJYUlVMS213M1NyeXFVaGdMYkROWmFvbXBrWUl0?=
 =?utf-8?B?TG0waFExcjhkRUpZcEl6OFlEVWk1N1lkSjNZdXYxeFI1RitOTXAvaUl0Mm1z?=
 =?utf-8?B?ZXRveCsyUzVPSHdrWndXUG5RbEJYTnhKWjhGbkw4cDFlS2RrdkV1YWhxZldr?=
 =?utf-8?B?VEVkd3lxVStleGg1TFp4V3grcWtaQ1JWY1hxR21ZK2YvSTkyNlBHcUlHb1Vk?=
 =?utf-8?B?ZlhmK3hWTXQ5WHpSZEdJR09IYlZYKzZzVk9BbnJSVHE1WXB2b2dkZWY4U3p0?=
 =?utf-8?B?WWloR3QydE1TMG5pSyt6OURHRDlUVE1PVEgwWGMxVWpPdHF0OFd4NEJNTlRM?=
 =?utf-8?B?dnpYdGlLOU9DMmk5bVdWay9CaVJ4QXFSVFBKTENsS2RyZlZ6QUM4cTNtZVFm?=
 =?utf-8?B?THQ4d0lQRWxTWmR4cjNxRC9Ub1lrSWdZNzBrWTA3Ym1GNVdpM2JibXJ4UUpL?=
 =?utf-8?B?V1VOK1NTQzZpM2wveGcySFZMeWxiNUI2QXREc1NvbTRyNm0yV3VkNWc1RkY2?=
 =?utf-8?B?UEpyTTY5aWtpd2dqTHVCTURsZjl2UGhVTnkyT3pzVGR5OG81a2hzRXhCUUR3?=
 =?utf-8?B?b2ROQ2g1Sm41eFBYVy8vdFhaWUxVYm9EMXduZnl5UzVibGlYbDFQK1JlMnlm?=
 =?utf-8?B?ZmEwWWpVeWdiM2tnUlZwTk9Dc0N4aTU4SUxaT1JYNTNhbnhMMWlncHRseHBy?=
 =?utf-8?B?MFFDMlJpaWNNWTRnRkxGeThLSldJL3lMYmcxbk5ESUdsNEFTQnBkT0VabnJP?=
 =?utf-8?B?Y2lLOGRJcXk1aDh0SEljOGJtTXpHa3pvczF4cE9BY0d3UFVIajl6aG1UMS92?=
 =?utf-8?B?UFFrdVkxMms1Y0lFemd3bXNMSkN3K1BCVWFrNFlvb2x0My9PRExyR0h1Wk9o?=
 =?utf-8?B?ZmhiWGdhbHk4OEJFRnNJc0N3bUFKNTB6L2ttTCtReDBtRjJZSmZBVDltTmgy?=
 =?utf-8?Q?YO29lsNxyALt4yNM=3D?=
X-Exchange-RoutingPolicyChecked: etb5zDYwsWC64AV/CbKd+ZSseOGZcbzeNiyvbXv0NAh/xQmv8eoAwVWyBo4xAJ7kjQc6/j09L0xk3QSDiiPRpUjWCxWnwTXwkR5t2Vxsc8or4OE+G0aVnqvTM4kkDrgnhe5n/LBUK9TcadBEX33A4Eo8dQewb8fTg8DQumazxyiD4cyoYtH+ZLE9+6A1N1pB7M5We0mVOo6aD97vxWtyr0SqRGE6BeX5bSlgMlvMNsYSc2GSlQ7iJ7B4kYVae/1EkwZYpDWZ9P81pU06jNpyQw/Uc6ETHcPAoilnW2/tfx/f/hc4tv3kzMu0IloDxSGlilu0H2aEc9zj62ol30j4Ew==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d8b9c8-e467-42ff-15d4-08dec5e8d34a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7017.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 05:34:50.2797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/bgmKrCeA0wEloXpDflrkPrXdpFPGydBugLJwJnZJM0Gm/MvX9dhlRku4gW7XIP2QT7mtIqGtuwnujjFBPyMbaB3/pEp/wsjFF0idHVL7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6544
X-Proofpoint-ORIG-GUID: 7a2TxOLmnoxvOVYWBK9vTPsMpHniV_KV
X-Authority-Analysis: v=2.4 cv=FP8rAeos c=1 sm=1 tr=0 ts=6a27a5fd cx=c_pps
 a=AQ8jqBFaYtg5UXnSSWtk/A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22
 a=NEAV23lmAAAA:8 a=t7CeM3EgAAAA:8 a=9Vi1xW84-B2eYb-JEWoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 7a2TxOLmnoxvOVYWBK9vTPsMpHniV_KV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA0OSBTYWx0ZWRfXwr+tDNMGmOqi
 ngG3xWfIMt1CJOMbPdHNsrkmYWjtAnjCFy8YTbumVLuqRp07OqBBIaQldqBqPVXlyKOS3kboosh
 TQ2wRtoWQGYivSr/UnSa+O0KoA8XZXQADnATP0QbzCZnwlPk8qaoXO17B7ZebDoSX8Ab+iC6jB8
 8MpSVVIdVzBRWnz8nBslxAhRnoAG4mgwl53779j3qTnC1T6XvnaYmFL0+W3pJiNmuh5sOS2Heu2
 z+aZbDdp15uxGi0Dd0LPLmlg+M4Qvu8WUVVk3m+cNOESnN+NTP7g+I0eZ5b4HaMQe7SVQQaOaJi
 f5tYbw/5+n+7V597hcGruOFKzAYZFLldIsycLqQ7dYoBNrVXoWUlpjxDB7OFlb6NRkbY0jg8fEe
 CaOQcWwvPY58xjlzw4AddpFc3RWa3xjFW7X+JhPXAmndi2EmOSDS0ujDmloidvGAEAWD/US+Vu6
 m9lV1LN238Y0uGLJ6jA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1011
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090049
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260608_223457_979951_934E79DF 
X-CRM114-Status: GOOD (  25.73  )
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

Humble ping...

Can anyone help review this patch?

thanks

xiaolei

On 5/19/26 11:17, Xiaolei Wang wrote:
> From: Xiaolei wang <xiaolei.wang@windriver.com>
>
> makedumpfile fails with "PAGE SIZE 0x1000 and VA Bits 52 not supported"
> on ARM64 systems configured with CONFIG_ARM64_VA_BITS_52=y and 4KB page
> size. This combination requires 5-level page tables, which makedumpfile
> does not currently support.
>
> Add support for 5-level page tables on ARM64 by:
> - Adding the P4D page table level definitions and helpers
> - Updating pud_t to contain p4d_t (reflecting the correct hierarchy)
> - Extending calculate_plat_config() to recognize 4K + 52-bit VA as
>    pgtable_level=5, and 16K + 52-bit VA as pgtable_level=4
> - Adding p4d_offset() to handle the additional translation level
> - Updating vaddr_to_paddr_arm64() to walk through PGD->P4D->PUD->PMD->PTE
> - Using vabits_actual instead of va_bits in calculate_plat_config() and
>    PTRS_PER_PGD to correctly handle the case where the kernel is compiled
>    with VA_BITS=52 but the hardware only supports 48-bit VA (runtime
>    fallback to 4-level)
>
> The pgtable_level assignments follow arch/arm64/Kconfig:
> - 4K  + 52-bit VA → 5-level (the only 5-level configuration)
> - 16K + 52-bit VA → 4-level
> - 4K  + 48-bit VA → 4-level
> - 16K + 48-bit VA → 4-level
>
> Fixes: https://github.com/makedumpfile/makedumpfile/issues/18
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
>   arch/arm64.c | 89 +++++++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 74 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm64.c b/arch/arm64.c
> index 1072178..f3f33e4 100644
> --- a/arch/arm64.c
> +++ b/arch/arm64.c
> @@ -29,6 +29,10 @@ typedef struct {
>   
>   typedef struct {
>   	pgd_t pgd;
> +} p4d_t;
> +
> +typedef struct {
> +	p4d_t p4d;
>   } pud_t;
>   
>   typedef struct {
> @@ -42,6 +46,7 @@ typedef struct {
>   #define __pte(x)	((pte_t) { (x) } )
>   #define __pmd(x)	((pmd_t) { (x) } )
>   #define __pud(x)	((pud_t) { (x) } )
> +#define __p4d(x)	((p4d_t) { (x) } )
>   #define __pgd(x)	((pgd_t) { (x) } )
>   
>   static int lpa_52_bit_support_available;
> @@ -62,7 +67,8 @@ static unsigned long kimage_voffset;
>   #define PAGE_OFFSET_48		((0xffffffffffffffffUL) << 48)
>   
>   #define pgd_val(x)		((x).pgd)
> -#define pud_val(x)		(pgd_val((x).pgd))
> +#define p4d_val(x)		(pgd_val((x).pgd))
> +#define pud_val(x)		(p4d_val((x).p4d))
>   #define pmd_val(x)		(pud_val((x).pud))
>   #define pte_val(x)		((x).pte)
>   
> @@ -75,6 +81,7 @@ static unsigned long kimage_voffset;
>   typedef unsigned long pteval_t;
>   typedef unsigned long pmdval_t;
>   typedef unsigned long pudval_t;
> +typedef unsigned long p4dval_t;
>   typedef unsigned long pgdval_t;
>   
>   #define PAGE_SHIFT	PAGESHIFT()
> @@ -101,6 +108,14 @@ typedef unsigned long pgdval_t;
>   #define PUD_MASK		(~(PUD_SIZE-1))
>   #define PTRS_PER_PUD		PTRS_PER_PTE
>   
> +/*
> + * P4D_SHIFT determines the size a level 0 page table entry can map.
> + */
> +#define P4D_SHIFT		ARM64_HW_PGTABLE_LEVEL_SHIFT(0)
> +#define P4D_SIZE		(_AC(1, UL) << P4D_SHIFT)
> +#define P4D_MASK		(~(P4D_SIZE-1))
> +#define PTRS_PER_P4D		PTRS_PER_PTE
> +
>   /*
>    * PGDIR_SHIFT determines the size a top-level page table entry can map
>    * (depending on the configuration, this level can be 0, 1 or 2).
> @@ -108,7 +123,7 @@ typedef unsigned long pgdval_t;
>   #define PGDIR_SHIFT		ARM64_HW_PGTABLE_LEVEL_SHIFT(4 - (pgtable_level))
>   #define PGDIR_SIZE		(_AC(1, UL) << PGDIR_SHIFT)
>   #define PGDIR_MASK		(~(PGDIR_SIZE-1))
> -#define PTRS_PER_PGD		(1 << ((va_bits) - PGDIR_SHIFT))
> +#define PTRS_PER_PGD		(1 << ((vabits_actual) - PGDIR_SHIFT))
>   
>   /*
>    * Section address mask and size definitions.
> @@ -178,6 +193,22 @@ pgd_pte(pgd_t pgd)
>   #define __pgd_to_phys(pgd)		__pte_to_phys(pgd_pte(pgd))
>   #define pgd_offset(pgd, vaddr)		((pgd_t *)(pgd) + pgd_index(vaddr))
>   
> +/* P4D */
> +#define p4d_index(vaddr)		(((vaddr) >> P4D_SHIFT) & (PTRS_PER_P4D - 1))
> +
> +static inline pte_t p4d_pte(p4d_t p4d)
> +{
> +	return __pte(p4d_val(p4d));
> +}
> +
> +#define __p4d_to_phys(p4d)		__pte_to_phys(p4d_pte(p4d))
> +
> +static inline unsigned long
> +p4d_page_paddr(p4d_t p4d)
> +{
> +	return __p4d_to_phys(p4d);
> +}
> +
>   static inline pte_t pud_pte(pud_t pud)
>   {
>   	return __pte(pud_val(pud));
> @@ -237,13 +268,22 @@ __pa(unsigned long vaddr)
>   		return (vaddr - kimage_voffset);
>   }
>   
> +static p4d_t *
> +p4d_offset(pgd_t *pgda, pgd_t *pgdv, unsigned long vaddr)
> +{
> +	if (pgtable_level > 4)
> +		return (p4d_t *)(pgd_page_paddr(*pgdv) + p4d_index(vaddr) * sizeof(p4d_t));
> +	else
> +		return (p4d_t *)(pgda);
> +}
> +
>   static pud_t *
> -pud_offset(pgd_t *pgda, pgd_t *pgdv, unsigned long vaddr)
> +pud_offset(p4d_t *p4da, p4d_t *p4dv, unsigned long vaddr)
>   {
>   	if (pgtable_level > 3)
> -		return (pud_t *)(pgd_page_paddr(*pgdv) + pud_index(vaddr) * sizeof(pud_t));
> +		return (pud_t *)(p4d_page_paddr(*p4dv) + pud_index(vaddr) * sizeof(pud_t));
>   	else
> -		return (pud_t *)(pgda);
> +		return (pud_t *)(p4da);
>   }
>   
>   static pmd_t *
> @@ -257,20 +297,32 @@ pmd_offset(pud_t *puda, pud_t *pudv, unsigned long vaddr)
>   
>   static int calculate_plat_config(void)
>   {
> -	/* derive pgtable_level as per arch/arm64/Kconfig */
> -	if ((PAGESIZE() == SZ_16K && va_bits == 36) ||
> -			(PAGESIZE() == SZ_64K && va_bits == 42)) {
> +	/*
> +	 * Derive pgtable_level as per arch/arm64/Kconfig.
> +	 * Use vabits_actual (runtime VA size) rather than va_bits (compile-time)
> +	 * because the kernel may reduce the VA space at boot if the hardware
> +	 * does not support 52-bit VA (LVA). In that case va_bits=52 but
> +	 * vabits_actual=48, and the page tables are 4-level, not 5-level.
> +	 */
> +	int va = vabits_actual;
> +
> +	if ((PAGESIZE() == SZ_16K && va == 36) ||
> +			(PAGESIZE() == SZ_64K && va == 42)) {
>   		pgtable_level = 2;
> -	} else if ((PAGESIZE() == SZ_64K && va_bits == 48) ||
> -			(PAGESIZE() == SZ_64K && va_bits == 52) ||
> -			(PAGESIZE() == SZ_4K && va_bits == 39) ||
> -			(PAGESIZE() == SZ_16K && va_bits == 47)) {
> +	} else if ((PAGESIZE() == SZ_64K && va == 48) ||
> +			(PAGESIZE() == SZ_64K && va == 52) ||
> +			(PAGESIZE() == SZ_4K && va == 39) ||
> +			(PAGESIZE() == SZ_16K && va == 47)) {
>   		pgtable_level = 3;
> -	} else if ((PAGESIZE() != SZ_64K && va_bits == 48)) {
> +	} else if ((PAGESIZE() == SZ_4K && va == 48) ||
> +			(PAGESIZE() == SZ_16K && va == 48) ||
> +			(PAGESIZE() == SZ_16K && va == 52)) {
>   		pgtable_level = 4;
> +	} else if (PAGESIZE() == SZ_4K && va == 52) {
> +		pgtable_level = 5;
>   	} else {
>   		ERRMSG("PAGE SIZE %#lx and VA Bits %d not supported\n",
> -				PAGESIZE(), va_bits);
> +				PAGESIZE(), va);
>   		return FALSE;
>   	}
>   	DEBUG_MSG("pgtable_level: %d\n", pgtable_level);
> @@ -548,6 +600,7 @@ vaddr_to_paddr_arm64(unsigned long vaddr)
>   	unsigned long long paddr = NOT_PADDR;
>   	unsigned long long swapper_phys;
>   	pgd_t	*pgda, pgdv;
> +	p4d_t	*p4da, p4dv;
>   	pud_t	*puda, pudv;
>   	pmd_t	*pmda, pmdv;
>   	pte_t 	*ptea, ptev;
> @@ -565,7 +618,13 @@ vaddr_to_paddr_arm64(unsigned long vaddr)
>   		return NOT_PADDR;
>   	}
>   
> -	puda = pud_offset(pgda, &pgdv, vaddr);
> +	p4da = p4d_offset(pgda, &pgdv, vaddr);
> +	if (!readmem(PADDR, (unsigned long long)p4da, &p4dv, sizeof(p4dv))) {
> +		ERRMSG("Can't read p4d\n");
> +		return NOT_PADDR;
> +	}
> +
> +	puda = pud_offset(p4da, &p4dv, vaddr);
>   	if (!readmem(PADDR, (unsigned long long)puda, &pudv, sizeof(pudv))) {
>   		ERRMSG("Can't read pud\n");
>   		return NOT_PADDR;


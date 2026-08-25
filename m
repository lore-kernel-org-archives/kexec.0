Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251F2C61DBC
	for <kexec@archiver.kernel.org>; Tue, 25 Aug 2026 07:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Bn78Eef2lRoV+gkI1Sh37DK3GuYnpzjBHY9NPDgDB3g=; b=ZowtYzTIJ2PnAR9U1OoP2J9wnF
	lIGsfRHVi6Mc9fPwqWiqqUdJs4wj3scXDkw9EZA/kwav8/z9JDzO5dnC7ZiZTwOSBKOsogXmVM5Id
	FIr5W6n4Jn3yXjN5UTgz+vAJ9l/d6KV7HmUZSQ1rW71ZnpvW9/eOKhh1Z55/hKEhPBLmE0hTuSQDq
	dEexb36UQ5KjwT1kB2R8Nr6dnmD69bpqO55Uq4x2qkG7wgurqCRQiqO5ZCQXMeqw6WkXZbDDb5DXX
	jXW4U/qM62fiAu7i69M/Zv/QWcKfmhEOWUlegRGug4ZR5/Ba9A56mz+ixllgOIx96+oOl3dZr+OkI
	wZklLC/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wylwx-00000000Jxz-0iAr;
	Tue, 25 Aug 2026 07:52:03 +0000
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wylwq-00000000Jwr-48jJ
	for kexec@lists.infradead.org;
	Tue, 25 Aug 2026 07:52:02 +0000
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P5fZv9538280;
	Tue, 25 Aug 2026 00:51:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=Bn78Eef2l
	RoV+gkI1Sh37DK3GuYnpzjBHY9NPDgDB3g=; b=S4CIOYAbMxtxVKheJDN4mIFvT
	9U6XDLEicE9k8ug4+w7f6kmqphMSJFn+b0Qdsr2C1e8bFO8tsmRU4tI+dxX/elRz
	fZYAh2fPBFRuNtu3zrrhG7e6WlWdYZSTlSlYvrjT93SjeRz2QmggfJFkepFDKDzp
	CNVIR8mec7gBWH0lGrV2q/hSy5hkxNcN5I/Ibzy1QfQdPwOqCMV7S6vwntePAFts
	kN83QDvZs6ZaNMss4qeKu0p9wDEGz/YPLyJTUsLeNPHNhsnNKBw9nfmCJNBKnFbU
	kL1QVkTWHJc5m17064M88BEWxVHTyvu2s+B1SaHH/uyZgOXnlnlF48g1muzrA==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020134.outbound.protection.outlook.com [52.101.46.134])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4g7721m3x0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 00:51:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfLyndpANCYrhLISwmI5d4rbUtA7o6GC0bfvlNGc+SBoBpaSK+CVsmsj+EwTzgv1d8Vp4etJ0ded0YGFzmK10gCo6vB66ff7wgPMwy3F+KhGwTduUn70HQGKL9b3X2bobekyJwFNmnLoWE+fW91jovWNCFCNO/oBiqbvwDlNbrLPz0Wvo74ZP4NCjHhTp4KO9C1oK5nceYosiAeOtR8xLqesy4ZgxO68S0Uqx/svacEmkgBZfKCm7s0xMLe39RTTgsPSxDCkv7gzoIW9rPCZ9wE3fwCNe9fTcFbYpXVy6IzNI9cjzd6LISQ/AKtA6d+kfHq6E3iqXFF2CahjUBN4SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bn78Eef2lRoV+gkI1Sh37DK3GuYnpzjBHY9NPDgDB3g=;
 b=fms2NH/vp8sY+++jpKWZ/kJkByRCplpUINZFOX/bFOy446ZPyhK43D2iuODD05mWSFvSyT/Sc//ivcFuRRySWw+NqLtXcCFJzCh/KAcNkOgOUXjooQHn7DwscBdslrpZ7Ah/rvy6ncSzmhwc4EqUB8+e6z8IyV0pnVD8iP4yPe9GkijMb0t14m/JQsRKq04OY//xRYc3B9jRZz9ii/TlRFGISXo/Sl+a2v4Y79duy8JVaHJiRB01Bv1UQ61LxN23bXcVGTzBYSNWTskjAhcF0fofW+Ybx6P+nScjSgELg7E/iyP0Xly8YIo5boMXOUbPsBU+cG8Tb1azm469gIeuGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by CH3PR11MB8441.namprd11.prod.outlook.com (2603:10b6:610:1bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 07:51:00 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%3]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 07:50:59 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: x86@kernel.org, kexec@lists.infradead.org
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org,
        baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com,
        pratyush@kernel.org, ruirui.yang@linux.dev, eric.devolder@oracle.com,
        hbathini@linux.ibm.com, sourabhjain@linux.ibm.com,
        ruanjinjie@huawei.com, include@grrlz.net, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] x86/crash: fix kexec_file_load(2) -EINVAL on machines with many possible CPUs
Date: Tue, 25 Aug 2026 10:50:41 +0300
Message-ID: <20260825075043.42041-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0014.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::20) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|CH3PR11MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a7e63d7-9813-42a6-563f-08df027d9a76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|52116014|376014|10070799003|23010399003|1800799024|366016|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 9zzIZKayHHIImPI2J8g8950hZfBkOX2p+snFphPXfZj97qwh05eEBBy8JsGcDmsQA7c/O+s2fLjX4p0eD661z87Tpo/HQxm1Ws7ABydnG9Q5sZxkjNIRul+5b8Ta+r+7AZAzruSs5w+zvmKX0mZYHHyCELn7HQlKLZq1K6n7P2HuUulLADQBem8gSazq7JYTEHcNGmhLXhkPGDJ3QfOiktHbvBpzv5MFaAPTpzVM/kDWsYABbkW9g39JoOW59lixr3aMlqTuvVczd2NBTsu0+Rxb3UiDeziDE2JsC0wLD5DJYYmTUcjy9PKoFB/+jDWboQm8RHW0dTNmkvL8DBl2C/f0XY4G7xktLsW1XAtGr0iOzux25x2NizbPJ4dJGdXtk+MvL3JJvfDhPoXkjV5WtRB6T0XYIVxmO1Tv9dDTIPt/mS/StmsJhpRak4ASwttt/G7v145EIQQHyjWsPJsb9G3doGX+H441Rcg1zgOLuHbwYZt4X8AKhoxmJIrNj6i6foW78lwqF4MNwPBAsJ/IVzAImBvM9vtAQeoiH6Tj1qH0iek9zgCeDOBBavDIKqydyqYBPOFFgOkFrPZmFFe2gFFTALzTTz0w88ibCv6sLztvYUHbLqTq/0Tsy1l7I7BbTu2t289maHMHxTCKSrI80scbP/HtqUH0DlnFlQRT+ME=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(10070799003)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nYCMh6M8KzSGrRXSm8mtIToLV/1Tl88xTtJh/0e4k8ZzA7CQojh8nywi8u5y?=
 =?us-ascii?Q?xXSv9W0Yyxx8ynu7cu7oajT8J+X+BKL6B+dSZMiDzHxsNFa8G9be5TAShlGv?=
 =?us-ascii?Q?trwnSQEjXah63vRk4Hof3nahRlOd0LWe0SjsPD29TCNH6AHhfeBtmifqx5KM?=
 =?us-ascii?Q?K1KBudpHk8vKBzJyZ2f63xKEofYEt9PgAw3sRpkB9gS5ZxZlJrkNIOxuQwoI?=
 =?us-ascii?Q?n1hnF3DUHM52KLOhCiwz//WJ5sXReXLLO3RGyCazkxdcBd8OYWjXqQUW5FGZ?=
 =?us-ascii?Q?msQVvANo4eMwrTWDYx0g5stS7BhVkSYbhy7Jrp7xVQMaLQlLLK+/VXgpM2Cv?=
 =?us-ascii?Q?GBkikFcP53VfFR91nHGtuolaXft+cA0ChvHw2RO1Ww24X4icpM8C9LwubcbS?=
 =?us-ascii?Q?x4tv+rYX55vzBYxFwIb39GuOvRT8uIsHW7q8N8j38DKpbJdk7G+VrAkIvYlB?=
 =?us-ascii?Q?K+0FKlJnyh425LPhrNOFpragQpnXXbxhNwaVWXt8WxfiMWdb8zx5C8mdXbMT?=
 =?us-ascii?Q?d6xutoOU8GsohWWkO4M1pofSdNRxrDo4QbHIl1kYvnaT7Wmyd36XhyqeQ38P?=
 =?us-ascii?Q?jEK50sjcY9WJu1q8uo0k2wVuHhvLIYqY9T0uhnaajhtLC87M3SYSc59Na0IH?=
 =?us-ascii?Q?Ejl6JpMVrSB/fP83GqN2NIzqcTypSE7xdULcKWAu+PbOo/15w3/HHhs59wTb?=
 =?us-ascii?Q?jjNH047mKGWjSFkSbv9sQmK0Ik1V4XUb16g5Kjp/mvRcUjj+YcQ36pT4aUxG?=
 =?us-ascii?Q?bhGwd6Mu0F3tt77afv0zTu3ahVLgy+6i0EzxEJr49ZT9X+qn+87Y/MrTEvHl?=
 =?us-ascii?Q?0bf7DLGSagftPnM5UoYMEn6HVI1W++9hTqUVgwsCZnQwT+KEtyLauBBsDfSx?=
 =?us-ascii?Q?lSrK/IQHolwXL8+Gntw61T4W9S8T/R84YIb84Dunov+EwVZzobJ8HgFGVRp/?=
 =?us-ascii?Q?2BNjRYhzMP9AaJ5X1bYZK+HNUHaP1HU1T3zGqzaK1EUnXwwa/Dlsfk5JMQzN?=
 =?us-ascii?Q?e8ejQeD+gXiT1V28m1qTvekp/FrKjt9KGE2CIe/Op33WcFQVES/URqUGslqx?=
 =?us-ascii?Q?QRgEBc4UNgj+zOfU5W9aj7Lu8X37cfgwM0cPrlh6w6bJ5LL6SUrHg9JIgsvv?=
 =?us-ascii?Q?pJZduK6WFvuBSOtir97PABkvK7yvzbqL5KmNRbJ3RQ70cpdy1X+6VLucaOIp?=
 =?us-ascii?Q?QFp/V2EkvQ4RjGQNsSyiV+RUWSYUTiwlL/7dGKk8F3MQTiDnxBacp4xMvKB1?=
 =?us-ascii?Q?wt2WdeDDaxON/lwKkRH1S/hvUF9uQTPoY83c5K67B0u0hlbhrc7+2Ph0juTC?=
 =?us-ascii?Q?5x9w0PiaYp+HlzN/Z3SV1znRnFwiqu3fyymCbp+p1GLt+9vi21+ysna4Dq7o?=
 =?us-ascii?Q?y61h+jxLiotPEDmfVdgOadN0YRA+iDSyBwGxW2kYBq3gpLptlxFlEC1sndRG?=
 =?us-ascii?Q?Qh1/RrfxxTL4iBg90Y/G+gI60SfwBAt1dL4GPmgpjQFW8VvqmGz0jgEKiAcp?=
 =?us-ascii?Q?I+t6YF8eOBtYq9ic8MyDFaHfzFziwK52CiMDQuPAsIEiFKbv7M23Meme6DxG?=
 =?us-ascii?Q?IoAi9d5yZ5I3tT/AieaRSB1m1QingEe8yWVkssrAK1bfglFeNB3qJGjLR4hm?=
 =?us-ascii?Q?VdUJJcozKmVLpRAKz3+NtKTZDOtOEpHFPf/LnV1FDY5IXt22665AuzEas/xE?=
 =?us-ascii?Q?GSjwvlf0NKFedEuTKc6m1IsUVCY1s5Qewyk2iZamGhp/xJtzhYYcsIOFoz0Q?=
 =?us-ascii?Q?suJY7OoH778aaiN+3zOt1pKaCGefu4vnzbIJfLkwo/a4Oy1kkd/oo4EWTqod?=
X-MS-Exchange-AntiSpam-MessageData-1: PRcNo9g9V9VWxIWf0V65Dfn+TNgIX0x2hXc=
X-Exchange-RoutingPolicyChecked: h4QiqUZpe5YuSVP3yEVjKuRnoFKcWYyz4fW7r5v0IaZ09PTpKvF7YEbQD8VlaBysgCw0ekdr5ascQAjhotVgZbKSWVF2n8pNj6qc70hbGcx7KvG0I5Sv8PaqrYnEd6g/gcoGjcagikLn6EfA0OkL56RFqxD7JDOrqjf7/f4zEPlY0r44W94Bbiq3PdLfEnwVO0VzjaASLdeo0t2HtvOMalTKtJQyW4dF+/KJkO41fcnT2yIdNAQhwo9L/9qH4cm7ICzlSiPKSJV1D52fvWcUl+5hgxDRegMFvaFaBwGwg4cZ5fgjZ8SwznSTl/jh8F70BYEZJ7k0rfZDc4To3TD+mA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7e63d7-9813-42a6-563f-08df027d9a76
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 07:50:59.7583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjj5mo5H8OW9PtvYN0Rx7z0/eMzCGjq2ixj+iFIDuh9/CAy5hLhCFw25aOR0unTIUDdHXpDtTRcvLgsgofl2v5fTAP8xVuSIuRzCSWs380g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8441
X-Authority-Analysis: v=2.4 cv=d8vFDxjE c=1 sm=1 tr=0 ts=6a8d4969 cx=c_pps
 a=1nHe0GVLCxVa2bATzrft2Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=mVmBt1QLOPhGqFDPXwUA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: EGx32EB6omKJydeV4Z05Ka9jKnC_-A9D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA2NSBTYWx0ZWRfX0S8pVV5L6VEC
 VNgP9fKyjzQXeN9pgiENUDAF3pyzPYVvvH/veSrUzcFIrmwPnOPLj5e69QahZVAiLM7g41o9ZUX
 4ZWtr2yJNsMcvFDmyYh6bJUg961+1gpfDceUGqwstHK6y31gELra5LizFM3Nn5t7ILjeFRYbqeq
 +ilKvnOXxSeallRAhLsR26Il+5iDYJQINRlry5P0vGrxRRt2yweTGnnYRWJoL8cyTes1UZpLe/I
 /veztfB9QuvT2yfJ76KFi9ZimjONNq3O5RAKr1Quxhe+vh+aRlrGnDrzliV1n8b0p5uBoo0jP/9
 vs+005GZ+RD5dIy4T1y/dDHvr4lxNSSAB4sX56KLYeEb6n+JFdtIjLtFuUYKga/cmVOREuN32Ge
 wlLzaM79SIidJdXo3WtbZ2T3QBTAZfo+YjqSakDlWxK2FudtikJMZhKl+vknHSSbc+0E0pJJceW
 VM5ci2ZWyBSf6h7Lg7g==
X-Proofpoint-GUID: EGx32EB6omKJydeV4Z05Ka9jKnC_-A9D
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA2NSBTYWx0ZWRfX2Wv8IJr29ccQ
 K+otwi8rrI3H1ctnojUBdVjGUilTWUGtJ/re8pkZ5uoDYOOa0q36GEW05zNpSt/ucnrbizrjGl8
 f0JaCLuZcCHC2P8f/UTcQRsDnGfmbaAJeMRz6RiWkXDMyJmbpsKG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250065
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260825_005157_031905_BA758C92 
X-CRM114-Status: GOOD (  22.20  )
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

From: Ionut Nechita <ionut.nechita@windriver.com>

Hi,

On x86 with CONFIG_CRASH_HOTPLUG=y and CONFIG_MEMORY_HOTPLUG=n, the
crash elfcorehdr segment is reserved for

    nr_mem_ranges + 2 + CONFIG_NR_CPUS_DEFAULT

program headers, while the header that crash_prepare_elf64_headers()
actually builds carries

    nr_mem_ranges + 2 + num_possible_cpus()

of them.  num_possible_cpus() is bounded by CONFIG_NR_CPUS, not by
CONFIG_NR_CPUS_DEFAULT, so on configs that raise CONFIG_NR_CPUS above
the arch default without MAXSMP the header outgrows its reservation once
the excess exceeds the page padding, and kexec_file_load(2) is rejected
by sanity_check_segment_list() with -EINVAL.  The classic kexec_load(2)
path is unaffected because user space builds the elfcorehdr without the
hotplug over-allocation.

Patch 1 reserves the elfcorehdr for CONFIG_NR_CPUS, the compile-time
upper bound of num_possible_cpus(), so the reservation always covers the
header that is actually generated.

Patch 2 is a documentation-only follow-up requested during v1 review: it
updates the two remaining places that still name NR_CPUS_DEFAULT when
describing the elfcorehdr sizing (the comment above
crash_handle_hotplug_event() and the CRASH_MAX_MEMORY_RANGES help text).

Based on linux-next (next-20260824, base-commit 4b18edbd8e70f).

Verified on a single-socket Xeon 6776P running a PREEMPT_RT kernel with:

    # CONFIG_MAXSMP is not set
    # CONFIG_MEMORY_HOTPLUG is not set
    CONFIG_NR_CPUS_RANGE_BEGIN=2
    CONFIG_NR_CPUS_RANGE_END=512
    CONFIG_NR_CPUS_DEFAULT=64
    CONFIG_NR_CPUS=256
    CONFIG_CRASH_MAX_MEMORY_RANGES=8192

- 144 possible CPUs: excess is (144 - 64) * 56 = 4480 bytes, more than
  the 4096 bytes of page padding, so 'kexec -p -s' fails with
  "kexec_file_load failed: Invalid argument"
- 72 possible CPUs (reduced via firmware): excess is (72 - 64) * 56 =
  448 bytes, still absorbed by the page rounding, and the load succeeds

Changes since v1:
- Patch 1/2: the changelog has been substantially rewritten.  v1
  described the reservation as "2 + CONFIG_NR_CPUS_DEFAULT" and did not
  explain where the CPU term goes missing.  The actual mechanism is that
  the @pnum the reservation builds on is crash_prepare_headers()'s
  @nr_mem_ranges out parameter - a memory range count, not a phdr count
  - so the CONFIG_NR_CPUS_DEFAULT term is the entire CPU allowance, and
  it is exceeded as soon as num_possible_cpus() > CONFIG_NR_CPUS_DEFAULT
  (modulo the page rounding on both sides).  The changelog now spells
  this out, including why the CONFIG_MEMORY_HOTPLUG=y path does not fail
  in practice with the default CONFIG_CRASH_MAX_MEMORY_RANGES=8192.
- Patch 1/2: the Fixes: tag was wrong in v1.  The two lines being
  changed were introduced by ea53ad9cf73b ("x86/crash: add x86 crash
  hotplug support"), not by a72bbec70da2 ("crash: hotplug support for
  kexec_load()") - which is the kexec_load(2) commit, i.e. the path this
  patch does not touch.  Corrected.
- Patch 1/2: added a paragraph on memory impact, and the reproducer now
  states CONFIG_MEMORY_HOTPLUG and CONFIG_CRASH_MAX_MEMORY_RANGES, which
  v1 omitted and which are needed to reproduce.
- Added patch 2/2 updating the stale NR_CPUS_DEFAULT references in the
  crash_handle_hotplug_event() comment (Jinjie Ruan) and in the
  CRASH_MAX_MEMORY_RANGES Kconfig help text (Bradley Morgan).
- Rebased from next-20260811 onto next-20260824.

Jinjie, Bradley: the code in patch 1/2 is byte-identical to v1, so I
carried your Reviewed-by tags, but given how much the changelog and the
Fixes: tag changed please re-check that you are still happy with them
and I will drop them if not.

On the num_possible_cpus() alternative raised by Jinjie in v1: it would
give a tighter reservation and powerpc's arch_crash_get_elfcorehdr_size()
already does exactly that.  I kept CONFIG_NR_CPUS here because it is the
minimal, easy-to-backport fix - it just swaps the wrong compile-time
constant for the correct compile-time upper bound, and keeps both
branches of the expression homogeneous alongside the equally
compile-time CONFIG_CRASH_MAX_MEMORY_RANGES term.  I am happy to respin
with num_possible_cpus() if maintainers prefer that.

v1: https://lore.kernel.org/lkml/20260812170433.533845-1-ionut.nechita@windriver.com/

Ionut Nechita (2):
  x86/crash: reserve elfcorehdr for CONFIG_NR_CPUS, not
    CONFIG_NR_CPUS_DEFAULT
  crash: update stale NR_CPUS_DEFAULT references in elfcorehdr sizing
    docs

 arch/x86/kernel/crash.c | 6 +++---
 kernel/Kconfig.kexec    | 2 +-
 kernel/crash_core.c     | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)


base-commit: 4b18edbd8e70f7e6860d56370f13244896d0f95c
--
2.55.0



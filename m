Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B19C5B572
	for <kexec@archiver.kernel.org>; Mon, 17 Aug 2026 15:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:References:In-Reply-To
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r3k8ojFF7QABmVDWqjjfvNhi9eLmWZy/GAE2JybvrNc=; b=HnF8tykWUHTPzhTDxzeVZDvlcZ
	d9wJMMnw20wCXfqTRB1W4CfKgQ5sx7mfjeljPq4RiMvVio/Z5DCY2dG+QRrlaxZl3sGd/OBBZj/Lr
	cp4xRjTxxkuBFumxZRjApEBAERDVPAljNdlkKaXHLYzukuOmuuB2Vx6t6nO+vPrCToayUGCHxfLJa
	1paBRywzO/zm3+kULrHc4snE9b9Uhzm/LXbt0eRHfhOkMM9flWu1cBFnhmknnTzA5Gopu8R+jHjj0
	U3LpmnulPQl1cBEzOD0Y/AlEslRYH416mDhveSOAC2yjDrgRO4iRffYwpVjH+RYBM3QTt9AX49IXv
	o7QPSgIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvzFT-00000006Phq-0bUj;
	Mon, 17 Aug 2026 15:27:39 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvzFP-00000006PhK-01us
	for kexec@lists.infradead.org;
	Mon, 17 Aug 2026 15:27:36 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HEfq9n689956;
	Mon, 17 Aug 2026 15:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=r3k8ojFF7QABmVDWqjjfvNhi9eLmWZy/GAE2JybvrNc=; b=
	dchlfEdPiWCkWkdW0RQ3BI/OiqbmoEdO2pXewi+9VItziNoLJmtIZlY5LShMRfiM
	483SFeyDU6IyosgDqIysCr+w36eJWYszzn/r5pmG2siuC0cGvD7dVTd9yiH80uoj
	JufzyL0NTs5pzoQhhS5M9JcuMoIPg7H77gbKSzPBs8Lr7QO6GO5tJ1C30R3+Wqku
	+jJLoVjuvFimrKtelZMU2c0DTxTOZiFUdaE1btCZvLj0VesaDIwFFtZ7pt5O6Dht
	DQYLvNmSzsozOpG4fJU1z8jIXSPWKAZ+4cKBcr2u8HZrZgrgSSViU/cPQnNxe84j
	oAEH2dmueS1qHHTPSoQY2w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g2ew52m2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 15:27:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67HFFgIW026950;
	Mon, 17 Aug 2026 15:27:32 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011071.outbound.protection.outlook.com [52.101.62.71])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4g2ejphf36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Aug 2026 15:27:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fzz7/3GIiESMNUm1h3odAe8o4VxvnGXUsxjjDgFkb8CSMaXkxYnuZ6wq/ekmzCKrYwsGCnAc8Fj6k/l2S3jloNv8BeDDQmCmCTi7GxWh+b0bx83j9bFi5iXitqI7OHUnoJXsLC162fgbmRegSlpk4i7EkYs2Q8iY5Q1GG3hUiHWf5pkWmRTnrxIXJBc99RalZYoi1ybJPoGqRi42XPQ7v/spQAcw4OBiv05z/xOyD+DWVJtrK1JIBsVnATSmZtsWBYlZ2cfu5paW3ajvbDnXpuv4oAcb76tjE8r8o6pbwVyhmlhGG0Tt4ynat3PyqaNLEJCGB7AW5xPoBTcxsSZFUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3k8ojFF7QABmVDWqjjfvNhi9eLmWZy/GAE2JybvrNc=;
 b=KvBSkwuN7DBpkav1PWwXZVz5UzZHU+NOuRHpjaYFqDbj+S8uwHzrNZOyAw7h/SdPZWgA4HywQbwA00UEULhfVeyrFpK3jaymvGwE7lcfQESD8G5S1NvaXBLJ+ig5QKB2T6zP2TP3uM6Nuuft3dVZiiWM8P4Bi1zdm5M00kr7JJg6/Ov4StggGAnFldL8OgMC7GADlcpGrVNb1SgLtoiVTufsAPON505S0ZttvtYy7QDYVTpWSj5+DSWxcPW25i1oPxCaZtWGg0knEPX0g8fYM2Ccq+opqRgjAsB9rkNdrkjR+W0OZ6bbbQh/6JRm/Cf4BNGEBNuiCzanSmm178dmcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3k8ojFF7QABmVDWqjjfvNhi9eLmWZy/GAE2JybvrNc=;
 b=QjzUCGaus6FRBDaOr0c+cjOAFRnmmcdew405WEQTOFi0+Ay1hXXH6v4WnPEYGlETaWA6kEc9Z+7Xv7b1n5yY0CuPnnpA5cozc/8rnLW936SUpGTnyKzM5p236z02LU2ns8onUoz3qZFdtBJ9oHnwGu7ldtkXNOEHvCqzRrK+WZI=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by PH0PR10MB5846.namprd10.prod.outlook.com (2603:10b6:510:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 15:27:23 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 15:27:23 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Tao Liu <ltao@redhat.com>
Cc: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org
Subject: Re: [PATCH makedumpfile 3/9] Share page information with extension
 callbacks
In-Reply-To: <CAO7dBbU6tfVHLO6LW5ZQXbApqychfo=hAtXd8pD+Z7MXFF7fgg@mail.gmail.com>
References: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
 <20260714004550.3698175-4-stephen.s.brennan@oracle.com>
 <CAO7dBbU6tfVHLO6LW5ZQXbApqychfo=hAtXd8pD+Z7MXFF7fgg@mail.gmail.com>
Date: Mon, 17 Aug 2026 08:27:21 -0700
Message-ID: <87ecfwdaxy.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PH7PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:510:174::20) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|PH0PR10MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: 1227dac5-adb4-4109-226f-08defc740951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|56012099006|4143699003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: vIOnbLtr4AETH54NqQrNvKCjYVFyApmHbEAfD9BL/Gm7bFZPsRHx9PS3/4YS06r3KKXsb/o8Byr3RB9olEEIGR2+ZhRUXmi/oJANfrelKb7s5GUdMY5LcLAOJkvw0UnuPmME92mHMzXS8VVatZTIYNdmnQisTH5l23YByH4tjj6mR58v9VJmPSo+aSAdc6OrStRhHhrZQjJDXROtXuhojYBJwiSBzmH5u28iSAZhkSU+m88GqohaaTU7VL8SYG0YsVvEUFzJoUZzul6c58aa5iYcZpGxoBAMI3K4QM7LF6UoFY9r1gtDC7YnvqPb5UMRBxNEDDaRRy+PrHfUjDEyOmJQ0q2iaRdeE9gGUL6M/nSYsq/ZEKZrBCTfxQ47oOQY8YQ4kos4P/BkbgWbbx/Mwv77qwC+3yGwspG9YZK1nVl/XmaoLH+mQnABWTGojJtMxG1ckZF1dzYDlpHo33pcpUg2PgtQMbLiUXOUbbpOJd8ZadgCIh/uPX5SHIt/lHDBiumD/FGf8zHC1GFqxRGwHivoIA32xVshVWicbOneK7dKaetaJbAoHIPpgcu/VsPRWcXhSuEEp8umgZGAK7Tmu1BSQTy3UcUTtG0LZd9hsEJOlSznC/2zk/BQEJGfGE7+KkoTncHzEX0owGPPGkE4xx/hWiUA5I/f0YOqQ1IE/Z8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHRudnlHYXZsK20vczBkdTZUUXVTWWd1ano3WTZLNlRLaXQrSzhHbmNlUmh5?=
 =?utf-8?B?ZkRldEh2RWtRUXViV2tXWHovcDU1bWM0a3lHeTlNTjVHWC92S1ZIelRnWGhQ?=
 =?utf-8?B?eG96eWpkNDRMcWFjN1NKd0krWlBkNHhCWStyYXpIbnQ4empQWTNmV2JSb3Vi?=
 =?utf-8?B?UXJPWis2SEJRSUVRb1laZXJJRkcxK1JZMDI1STYzckY3eE9UZm9SQ2hDYlpB?=
 =?utf-8?B?UU9EaGRDL1Uvb1EvVUVIZnlkN0N5QzFCblJ1STRZK1poN1VYdW5DTGxhU3dx?=
 =?utf-8?B?ZnBSWnFkZjBnT2l6V1NtN3JabUVLT0szMnMvb21VcGI4eVZlQWwrL0F0b1F6?=
 =?utf-8?B?cjc2UTdkWW5LdnEvbHVhNDZDSmMydWgwL1hZWE1XeXNkMmNlNWluM05Dd1Jp?=
 =?utf-8?B?anpqSy9vTU4vQThjRnBTYWd1dDhBbEdLQ1ZYcStUTlloWndOeG5nTCtwZFFs?=
 =?utf-8?B?RnJlTDJwMlQ0R0lvT1JMSWh4bDdDY1dBd3FyOGIvMXBteUF0NENtQXZDK3hK?=
 =?utf-8?B?ekpTb3dqd0ZQUjVocWcrOFYveDlEVVJRUnFleHRGQTF6ak1MaitGTitLQUdE?=
 =?utf-8?B?dWRXSzNYV056QXdXYkJnR3NhWGd3SmVXc0ZJQ0NDTGlpcVkwQlFENUxJdXdX?=
 =?utf-8?B?L0t1K3ZUQ3JldUJJZ2lhR1JkZTBJdHlWSkhNRmtjRHJoK1BndGVURGVzWEJC?=
 =?utf-8?B?QUh3M2JiQitnL1lCQURnWEszWmJpZkhMNkVYN2t5Y1lhN2hEWWpuNkhXbXd2?=
 =?utf-8?B?K2d1YzZZcDltNU4xWVkyRVhtMm5oeXRHYVpWUlNYZXozbUdBVkxnOVNFRWtS?=
 =?utf-8?B?UkQyWHp3YjlrQkZ0MU5LQ1ZPdG5iSWQ0dTZQY3cyYUdhcVBFWmhGVlQzWXIv?=
 =?utf-8?B?KzEvRG9VZFBCZ25qUGZOMERaQ2JyRWxPMlZ5L0k3cTZOeUNwTjJvNGlXY2M0?=
 =?utf-8?B?T1dDZ0p6UGZEd0pNMGwyUEFXUkhuUUNQNktmUUVSbVRZSmpJQUsyY3h5YThE?=
 =?utf-8?B?MENMTFpJNlByVnd0LzVjWHV4d0EvckEybytqbkowem5nNDFBa3RHSXdpRk5D?=
 =?utf-8?B?Y1JhUHh3ME9oL1hFMlpXVjhndFVGSlpMNFI3NjcyKzkyZFpjZVo5cktNc0FW?=
 =?utf-8?B?Vmo5RHY0VGV0bFRSYlZMdUh3VWordTBvTjBQbUlOSmVjMVQ1WTRjOUNJemJ2?=
 =?utf-8?B?VFRsemlOWWVqYjNXZ2phMkVMWGl1cEtiZlFkN0JzMlJmNzBzb0dLazdVTW55?=
 =?utf-8?B?NHNXVzl1aGU2Zi9wbE81U0VaYXEwTFN0N1RyeTVoSDQ3blNwWjUwak5ldnpR?=
 =?utf-8?B?UngvYkNQczg1ZVQ2ZVUvdlJPVUoraThSdHc0czF2eDRUOS9TNHlpZGF2aUFC?=
 =?utf-8?B?cXRGekdpUUdhb2Iwa20zY3JpeUxOak9Kcks0MkVTSGJXbjF0SW9xK1hGU2hj?=
 =?utf-8?B?aEtTUks5TWZjL1NKdHpZR283UlNtd3RMWkh2aDZGYjFCSWVnbTZRaTczRkQ2?=
 =?utf-8?B?clJKZ0J6V1cwU2RKcUZGYkZHeFdmYWJTbnBxS1RHS2VsbEhGNHZsWlZqOEFU?=
 =?utf-8?B?OEUycmcxSVNNUG52M1JMNHFwM3Zac0FjNnV5Nkc5T3drd0JWVFJkV2R1ZVlE?=
 =?utf-8?B?TWlkWkZkYUYvY1BJQ0lteUpGOTFpajJJUDRPTVBwM21rSWYzdkZrT2FMdUEz?=
 =?utf-8?B?VzRSa0o5Q1dxd1UzVHpHdkgrWmdveGtTSTIrdlhvaU9IWWlnRXhNamYySWFv?=
 =?utf-8?B?QVY5QWlsbGs2SkZFdXI5UGpJYlcvNU1kNDArMnlYNEtNay9Ea05LUjdpOFI3?=
 =?utf-8?B?a1h3MHEzM0RhcW1YWnNJdlBqSUs4YXllSG5LTlowVnJFZEZFYUZCM3JHck94?=
 =?utf-8?B?MzNQWFluNWRJUWxjTzRzYlREOVRDbkdYYXI4NTEwaVFvWjMvYmg0Qi96SWUv?=
 =?utf-8?B?Z1dxY3ZSVmQ2RjZIZHJjeU1Mc2YvYVcvTG1IRDk5emlMcUMzVWZRQUhvMXVr?=
 =?utf-8?B?TTgvNTdubmI0V2NpZWhZNXZIVlBWaGZZRnQ3UGlzN04xbGRZRERwRnVlUm1o?=
 =?utf-8?B?Nm5rYWxLSk5tMis3REFpTlc2L0lFbG1vcnQwSDNoTnBQaHhoaC8vKzVIY2VL?=
 =?utf-8?B?VDRWc2x1RDI5VzNVcGRaWTZGd2pIbGxPRmsvOTFiU21CekVUUFJNWmExb1dv?=
 =?utf-8?B?WFk5YUNIYitzVlg4KzJydmpHTitYUTNiUDZYZTVpai9salhHNXJtQ091S2FB?=
 =?utf-8?B?OStCM096OGZPbVlvQnZmbWJNanY2S0hENkFublNRUUxTcFhUMjdNYU5TL1B0?=
 =?utf-8?B?dVZEdzhQU1VTWmFOazcrN1EyZkR5WnhhV3lGbDVkQ29QZEF5Sk9iQ2tKOEh1?=
 =?utf-8?Q?jg43QaCJSbVKvj1U=3D?=
X-Exchange-RoutingPolicyChecked: T9/NmruCxFt3tbwCiDfYraV+pfLKW8psb+K9eH92KH8x4ykgtWPUt43+O7qohqOIMLKiAYcMoSnuz0xX1jU//wlqRKFEcK4kyw+gzXtcJDuye4aSagQha/pivEF2mtB8W09HbYNspwKW4dxYFr5tYzZ+kfMpXAYstJol2Q2l2BFl/sh5kZIYBUxI9An+9kUVC5xJ3VkS/e+JExP90KJddzQYFqHGcdO5bVpgoFpuXuLpzmz9C7tdBJRhFQo33M39bsHAGw1PrmYwlzvY+6Bz/QP0oYbhtEPY2tR96Nk9rhsk/cRqPoBeyN/JahfxUXVCehZpwNhj7/PXfZRhF1UyvA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XvBzkveL+j/BxcFhBwIB6By0TZH0rLrHvGL8m/Z7AuiJ45aRhxEOOQ5i37IjwirfDvMboNvDeNqcrdgswWGpXXE0t65WTYJtGOuB3SfmURICLPjUiLbifsZJqX/7UdF/NAmt6E0FmWPFpdSpCdAzM+A6D9d0QpZla9hvd6WSTnaMesxLdgfscVajAUCO5Y8qgGyq1EfmYzMrEPK95tMKdPr1pooz4HXoioyZROu0p66BEhheTmjqklpPZS+G7CNALosxSIPcKjnoFxF+42JXSURG1uAs1kH6ubS5vOVBMGjqESCIJnuGCvPDpElTTSiFc7mWk+3Hb4OT9GtbCTNvgt6safH0MujsZAi7+ffpTVVbPWW0lOeoDVNKOmBsprLC0Q+yRRntu9TR2YMH6KhkrlunJk3JSRNCai5Le+T8Td/Zq1CieGsroVlPr5hRAugcxS8wiosOOuLMPVZCA4rF1Lve4RXwLpPsCM6QJe/FIL7WDS2ifpx+vnWGHtoI7+pTZ3Dah5y1zyv/UIo3Z8aPUTob4EIiA78Piuts8kM7JJ6KB4WK5erMtEumkfYhkoMqdYhbM4l25SH0tnTtRvLvc5BLSB9rs779uSGgOYAjv4c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1227dac5-adb4-4109-226f-08defc740951
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 15:27:23.8122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7seGu5UTtM+frq++hZ2UXy2VUPzFrm1eO/Ap7vjxKg2SjwiJUvQS/ReZVaUi3YaaZBkXEA0qJJWk8OCDyEulIfjWt4540SgCTtaZMxjlb2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608170117
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDExOCBTYWx0ZWRfX8P+8r2hfPOxO
 7AEgi29tQNDHUUECngxGsCOvUMZucJbO3AK6xlY6gxgGwMHOKX+C9EsE17wNNQ16yek0rjalUd8
 PrpkUik2sfUSXj7yffDG3hQEDV0Y1QSI+YXcNtFGjaPfOJvy8xOfvUXjgsey2h1I7EekxBOrkYB
 MjhqND/zeSjc5hFg5PpPRmxI/GBNfOJtdYOFUP+wNqDtByQc2SOR1ln4NmLGG+SzJrwhLtMv4PL
 HJblKOjaE0MpFtG01JN1a1FUAkFkmhCRJYIEAG5T1o7DaKJWW5V3zqL7KG4euji1df15Txhk7Lm
 NK+mu3A7Hfif9PI2YIGc5Di/+mUwTEJT/GUy6PkLwvh1Ut/Hm/MMZHtc/RWzn1GfMA1FvlqF2IK
 3HhkKTNorC/CX0iMbgHXitVhYFHODkyjbSkRIdgc4muEYqGc4u6e0MNc8bKEdw8dUmnHQUlIeCh
 gBlK2Ygmq1Kg2HAtX+Kdyzy8TAyLsSAhy1vmFjSE=
X-Proofpoint-GUID: vLQeh0PKz8Z6fhfvfuO8mZUt9kOBPPFu
X-Authority-Analysis: v=2.4 cv=cYbiaHDM c=1 sm=1 tr=0 ts=6a832864 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=uo4xf_1i7RLZikLM3HIA:9 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13509
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDExOCBTYWx0ZWRfX5JcI2CbhOSqu
 FRyv/1P5bSWPn6O4GMbtLSLF0AMV6e8AH0gAttUepoP3zt4jCy8V0E89B4bVI7S0SvyPoDtIA09
 QRPoRgpwQVkSynNFvl/JYAyIymGBY9duLmrY/J1QANPj0KuC1IAT
X-Proofpoint-ORIG-GUID: vLQeh0PKz8Z6fhfvfuO8mZUt9kOBPPFu
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_082735_171581_79D618AB 
X-CRM114-Status: GOOD (  22.29  )
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

Tao Liu <ltao@redhat.com> writes:
> Hi Stephen,
>
> On Tue, Jul 14, 2026 at 12:46=E2=80=AFPM Stephen Brennan
> <stephen.s.brennan@oracle.com> wrote:
>>
>> In __exclude_unnecessary_pages(), we extract several fields related
>> to the page. Some of these, like compound_order and compound_dtor, have
>> logic specific to the kernel version.
>>
>> Extensions can, of course, determine these values for themselves, but
>> it's extra work, and duplicates logic that may need to be updated
>> frequently with new kernel versions. What's more, if we put all the
>> values together in a single structure, helpers like isSlab() and others
>> can be implemented in terms of that structure and shared with the
>> extensions in order to further simplify their implementation.
>>
>> With that in mind, group the per-page variables into a structure and
>> share them with extension callbacks. This breaks the extension API,
>> but since a release hasn't yet happened, it seems reasonable to do so.
>>
>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>> ---
>>  extension.c    |  8 ++---
>>  extension.h    |  3 +-
>>  makedumpfile.c | 83 +++++++++++++++++++++++++-------------------------
>>  makedumpfile.h | 16 ++++++++++
>>  4 files changed, 64 insertions(+), 46 deletions(-)
>>
>> diff --git a/extension.c b/extension.c
>> index 5188c1f..9b29f0c 100644
>> --- a/extension.c
>> +++ b/extension.c
>> @@ -10,7 +10,7 @@
>>  #include "kallsyms.h"
>>  #include "btf_info.h"
>>
>> -typedef int (*callback_fn)(unsigned long, const void *);
>> +typedef int (*callback_fn)(unsigned long, const void *, const struct pg=
info *);
>>
> The function signature of callbacks are changed, it will be better to
> update them in extensions/sample.c as well:
>
> int extension_callback(unsigned long pfn, const void *pcache)
> {
> return PG_UNDECID;
> }
>
> Since it will serve as a reference for future extension authors.

Hi Tao,

Thanks for the catch, I will send a v2 with this and a few other fixes.

Thanks,
Stephen

> Thaks,
> Tao Liu
>
>>  struct extension_handle_cb {
>>         void *handle;
>> @@ -306,14 +306,14 @@ fail:
>>   * 1) Include the page if anyone says PG_INCLUDE, and
>>   * 2) Exclude the page if no one says PG_INCLUDE, but one or more say P=
G_EXCLUDE.
>>   */
>> -int run_extension_callback(unsigned long pfn, const void *pcache)
>> +int run_extension_callback(unsigned long pfn, const void *pcache, const=
 struct pginfo *inf)
>>  {
>>         int result;
>>         int ret =3D PG_UNDECID;
>>
>>         for (int i =3D 0; i < handle_cbs_len; i++) {
>>                 if (handle_cbs[i]->cb) {
>> -                       result =3D handle_cbs[i]->cb(pfn, pcache);
>> +                       result =3D handle_cbs[i]->cb(pfn, pcache, inf);
>>                         if (result =3D=3D PG_INCLUDE) {
>>                                 ret =3D result;
>>                                 goto out;
>> @@ -341,7 +341,7 @@ bool add_extension_opts(char *opt)
>>         return false;
>>  }
>>
>> -int run_extension_callback(unsigned long pfn, const void *pcache)
>> +int run_extension_callback(unsigned long pfn, const void *pcache, const=
 struct pginfo *i)
>>  {
>>         return PG_UNDECID;
>>  }
>> diff --git a/extension.h b/extension.h
>> index ba8d32a..22af9a6 100644
>> --- a/extension.h
>> +++ b/extension.h
>> @@ -2,12 +2,13 @@
>>  #define _EXTENSION_H
>>  #include <stdbool.h>
>>
>> +struct pginfo;
>>  enum {
>>         PG_INCLUDE,     // Exntesion will keep the page
>>         PG_EXCLUDE,     // Exntesion will discard the page
>>         PG_UNDECID,     // Exntesion makes no decision
>>  };
>> -int run_extension_callback(unsigned long pfn, const void *pcache);
>> +int run_extension_callback(unsigned long pfn, const void *pcache, const=
 struct pginfo *i);
>>  void init_extensions(void);
>>  void cleanup_extensions(void);
>>  bool add_extension_opts(char *opt);
>> diff --git a/makedumpfile.c b/makedumpfile.c
>> index e882b84..a4c9bbf 100644
>> --- a/makedumpfile.c
>> +++ b/makedumpfile.c
>> @@ -6466,12 +6466,13 @@ __exclude_unnecessary_pages(unsigned long mem_ma=
p,
>>         mdf_pfn_t pfn_read_start, pfn_read_end;
>>         unsigned char *page_cache;
>>         unsigned char *pcache;
>> -       unsigned int _count, _mapcount =3D 0, compound_order =3D 0;
>> +       struct pginfo i;
>>         unsigned int order_offset, dtor_offset;
>> -       unsigned long flags, mapping, private =3D 0;
>> -       unsigned long compound_dtor, compound_head =3D 0;
>>         int filter_pg;
>>
>> +       i._mapcount =3D i.compound_order =3D 0;
>> +       i.private =3D i.compound_dtor =3D i.compound_head =3D 0;
>> +
>>         /*
>>          * If a multi-page exclusion is pending, do it first
>>          */
>> @@ -6543,21 +6544,21 @@ __exclude_unnecessary_pages(unsigned long mem_ma=
p,
>>                         pfn_read_end   =3D pfn + pfn_mm - 1;
>>                 }
>>
>> -               flags   =3D ULONG(pcache + OFFSET(page.flags));
>> -               _count  =3D UINT(pcache + OFFSET(page._refcount));
>> -               mapping =3D ULONG(pcache + OFFSET(page.mapping));
>> +               i.flags   =3D ULONG(pcache + OFFSET(page.flags));
>> +               i._count  =3D UINT(pcache + OFFSET(page._refcount));
>> +               i.mapping =3D ULONG(pcache + OFFSET(page.mapping));
>>
>>                 if (OFFSET(page._mapcount) !=3D NOT_FOUND_STRUCTURE)
>> -                       _mapcount =3D UINT(pcache + OFFSET(page._mapcoun=
t));
>> +                       i._mapcount =3D UINT(pcache + OFFSET(page._mapco=
unt));
>>
>> -               compound_order =3D 0;
>> -               compound_dtor =3D 0;
>> +               i.compound_order =3D 0;
>> +               i.compound_dtor =3D 0;
>>                 /*
>>                  * The last pfn of the mem_map cache must not be compoun=
d head
>>                  * page since all compound pages are aligned to its page=
 order
>>                  * and PGMM_CACHED is a power of 2.
>>                  */
>> -               if ((index_pg < PGMM_CACHED - 1) && isCompoundHead(flags=
)) {
>> +               if ((index_pg < PGMM_CACHED - 1) && isCompoundHead(i.fla=
gs)) {
>>                         unsigned char *addr =3D pcache + SIZE(page);
>>
>>                         /*
>> @@ -6567,10 +6568,10 @@ __exclude_unnecessary_pages(unsigned long mem_ma=
p,
>>                         if (NUMBER(PAGE_HUGETLB_MAPCOUNT_VALUE) !=3D NOT=
_FOUND_NUMBER) {
>>                                 unsigned long _flags_1 =3D ULONG(addr + =
OFFSET(page.flags));
>>
>> -                               compound_order =3D _flags_1 & 0xff;
>> +                               i.compound_order =3D _flags_1 & 0xff;
>>
>> -                               if (_mapcount =3D=3D (int)NUMBER(PAGE_HU=
GETLB_MAPCOUNT_VALUE))
>> -                                       compound_dtor =3D IS_HUGETLB;
>> +                               if (i._mapcount =3D=3D (int)NUMBER(PAGE_=
HUGETLB_MAPCOUNT_VALUE))
>> +                                       i.compound_dtor =3D IS_HUGETLB;
>>
>>                                 goto check_order;
>>                         }
>> @@ -6582,19 +6583,19 @@ __exclude_unnecessary_pages(unsigned long mem_ma=
p,
>>                         if (NUMBER(PG_hugetlb) !=3D NOT_FOUND_NUMBER) {
>>                                 unsigned long _flags_1 =3D ULONG(addr + =
OFFSET(page.flags));
>>
>> -                               compound_order =3D _flags_1 & 0xff;
>> +                               i.compound_order =3D _flags_1 & 0xff;
>>
>>                                 if (_flags_1 & (1UL << NUMBER(PG_hugetlb=
)))
>> -                                       compound_dtor =3D IS_HUGETLB;
>> +                                       i.compound_dtor =3D IS_HUGETLB;
>>
>>                                 goto check_order;
>>                         }
>>
>>                         if (order_offset) {
>>                                 if (info->kernel_version >=3D KERNEL_VER=
SION(4, 16, 0))
>> -                                       compound_order =3D UCHAR(addr + =
order_offset);
>> +                                       i.compound_order =3D UCHAR(addr =
+ order_offset);
>>                                 else
>> -                                       compound_order =3D USHORT(addr +=
 order_offset);
>> +                                       i.compound_order =3D USHORT(addr=
 + order_offset);
>>                         }
>>
>>                         if (dtor_offset) {
>> @@ -6603,40 +6604,40 @@ __exclude_unnecessary_pages(unsigned long mem_ma=
p,
>>                                  * to the ID of it since linux-4.4.
>>                                  */
>>                                 if (info->kernel_version >=3D KERNEL_VER=
SION(4, 16, 0))
>> -                                       compound_dtor =3D UCHAR(addr + d=
tor_offset);
>> +                                       i.compound_dtor =3D UCHAR(addr +=
 dtor_offset);
>>                                 else if (info->kernel_version >=3D KERNE=
L_VERSION(4, 4, 0))
>> -                                       compound_dtor =3D USHORT(addr + =
dtor_offset);
>> +                                       i.compound_dtor =3D USHORT(addr =
+ dtor_offset);
>>                                 else
>> -                                       compound_dtor =3D ULONG(addr + d=
tor_offset);
>> +                                       i.compound_dtor =3D ULONG(addr +=
 dtor_offset);
>>                         }
>>  check_order:
>> -                       if ((compound_order >=3D sizeof(unsigned long) *=
 8)
>> -                           || ((pfn & ((1UL << compound_order) - 1)) !=
=3D 0)) {
>> +                       if ((i.compound_order >=3D sizeof(unsigned long)=
 * 8)
>> +                           || ((pfn & ((1UL << i.compound_order) - 1)) =
!=3D 0)) {
>>                                 /* Invalid order */
>> -                               compound_order =3D 0;
>> +                               i.compound_order =3D 0;
>>                         }
>>                 }
>>                 if (OFFSET(page.compound_head) !=3D NOT_FOUND_STRUCTURE)
>> -                       compound_head =3D ULONG(pcache + OFFSET(page.com=
pound_head));
>> +                       i.compound_head =3D ULONG(pcache + OFFSET(page.c=
ompound_head));
>>
>>                 if (OFFSET(page.private) !=3D NOT_FOUND_STRUCTURE)
>> -                       private =3D ULONG(pcache + OFFSET(page.private))=
;
>> +                       i.private =3D ULONG(pcache + OFFSET(page.private=
));
>>
>> -               nr_pages =3D 1 << compound_order;
>> +               nr_pages =3D 1 << i.compound_order;
>>                 pfn_counter =3D NULL;
>>
>>                 /*
>>                  * Excludable compound tail pages must have already been=
 excluded by
>>                  * exclude_range(), don't need to check them here.
>>                  */
>> -               if (compound_head & 1)
>> +               if (i.compound_head & 1)
>>                         continue;
>>
>>                 /*
>>                  * Include pages that specified by user via
>>                  * makedumpfile extensions
>>                  */
>> -               filter_pg =3D run_extension_callback(pfn, pcache);
>> +               filter_pg =3D run_extension_callback(pfn, pcache, &i);
>>                 if (filter_pg =3D=3D PG_INCLUDE)
>>                         continue;
>>
>> @@ -6646,14 +6647,14 @@ check_order:
>>                  */
>>                 if ((info->dump_level & DL_EXCLUDE_FREE)
>>                     && info->page_is_buddy
>> -                   && info->page_is_buddy(flags, _mapcount, private, _c=
ount)) {
>> +                   && info->page_is_buddy(i.flags, i._mapcount, i.priva=
te, i._count)) {
>>                         if ((ARRAY_LENGTH(zone.free_area) !=3D NOT_FOUND=
_STRUCTURE) &&
>> -                           (private >=3D ARRAY_LENGTH(zone.free_area)))=
 {
>> +                           (i.private >=3D ARRAY_LENGTH(zone.free_area)=
)) {
>>                                 MSG("WARNING: Invalid free page order: p=
fn=3D%llx, order=3D%lu, max order=3D%lu\n",
>> -                                   pfn, private, ARRAY_LENGTH(zone.free=
_area) - 1);
>> +                                   pfn, i.private, ARRAY_LENGTH(zone.fr=
ee_area) - 1);
>>                                 continue;
>>                         }
>> -                       nr_pages =3D 1 << private;
>> +                       nr_pages =3D 1 << i.private;
>>                         pfn_counter =3D &pfn_free;
>>                 }
>>                 /*
>> @@ -6663,7 +6664,7 @@ check_order:
>>                  * accepted immediately without being on the list.
>>                  */
>>                 else if ((info->dump_level & DL_EXCLUDE_FREE)
>> -                       && isUnaccepted(_mapcount)) {
>> +                       && isUnaccepted(i._mapcount)) {
>>                         nr_pages =3D 1 << (ARRAY_LENGTH(zone.free_area) =
- 1);
>>                         pfn_counter =3D &pfn_free;
>>                 }
>> @@ -6671,17 +6672,17 @@ check_order:
>>                  * Exclude the non-private cache page.
>>                  */
>>                 else if ((info->dump_level & DL_EXCLUDE_CACHE)
>> -                   && is_cache_page(flags)
>> -                   && !isPrivate(flags) && !isAnon(mapping, flags, _map=
count)) {
>> +                   && is_cache_page(i.flags)
>> +                   && !isPrivate(i.flags) && !isAnon(i.mapping, i.flags=
, i._mapcount)) {
>>                         pfn_counter =3D &pfn_cache;
>>                 }
>>                 /*
>>                  * Exclude the cache page whether private or non-private=
.
>>                  */
>>                 else if ((info->dump_level & DL_EXCLUDE_CACHE_PRI)
>> -                   && is_cache_page(flags)
>> -                   && !isAnon(mapping, flags, _mapcount)) {
>> -                       if (isPrivate(flags))
>> +                   && is_cache_page(i.flags)
>> +                   && !isAnon(i.mapping, i.flags, i._mapcount)) {
>> +                       if (isPrivate(i.flags))
>>                                 pfn_counter =3D &pfn_cache_private;
>>                         else
>>                                 pfn_counter =3D &pfn_cache;
>> @@ -6692,19 +6693,19 @@ check_order:
>>                  *  - hugetlbfs pages
>>                  */
>>                 else if ((info->dump_level & DL_EXCLUDE_USER_DATA)
>> -                        && (isAnon(mapping, flags, _mapcount) || isHuge=
tlb(compound_dtor))) {
>> +                        && (isAnon(i.mapping, i.flags, i._mapcount) || =
isHugetlb(i.compound_dtor))) {
>>                         pfn_counter =3D &pfn_user;
>>                 }
>>                 /*
>>                  * Exclude the hwpoison page.
>>                  */
>> -               else if (isHWPOISON(flags)) {
>> +               else if (isHWPOISON(i.flags)) {
>>                         pfn_counter =3D &pfn_hwpoison;
>>                 }
>>                 /*
>>                  * Exclude pages that are logically offline.
>>                  */
>> -               else if (isOffline(flags, _mapcount)) {
>> +               else if (isOffline(i.flags, i._mapcount)) {
>>                         pfn_counter =3D &pfn_offline;
>>                 }
>>                 /*
>> diff --git a/makedumpfile.h b/makedumpfile.h
>> index 4f707c7..87f973d 100644
>> --- a/makedumpfile.h
>> +++ b/makedumpfile.h
>> @@ -1507,6 +1507,22 @@ struct ppc64_vmemmap {
>>         unsigned long           virt;
>>  };
>>
>> +/* Per-page information determined during page filtering which may be u=
seful
>> + * to extensions making their decisions */
>> +struct pginfo {
>> +       unsigned long flags;
>> +       unsigned long mapping;
>> +       /* Present whenever OFFSET(page.private) !=3D NOT_FOUND_STRUCTUR=
E */
>> +       unsigned long private;
>> +       unsigned long compound_dtor;
>> +       /* Present whenever OFFSET(page.compound_head) !=3D NOT_FOUND_ST=
RUCTURE */
>> +       unsigned long compound_head;
>> +       unsigned int _count;
>> +       /* Present whenever OFFSET(page._mapcount) !=3D NOT_FOUND_STRUCT=
URE */
>> +       unsigned int _mapcount;
>> +       unsigned int compound_order;
>> +};
>> +
>>  struct DumpInfo {
>>         int32_t         kernel_version;      /* version of first kernel*=
/
>>         struct timeval  timestamp;
>> --
>> 2.47.3
>>


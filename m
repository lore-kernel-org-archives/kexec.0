Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FCFC61DB9
	for <kexec@archiver.kernel.org>; Thu, 27 Aug 2026 07:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yQj70NK/8iluOdZ7+C0cw0X3MPBb4oJAeL49qqjrW2A=; b=Abc6f3YLviWhAGhVNzetSLEb7I
	qiqJ7PcQqa+IRmsyQ4R2xoaoDhlcUDg51XxQFGaC/1wlyKnnMdq6CoVGy1NXsNgNXq6Fw374Dh+uY
	UYEd/0dbsUY4tYVHi6v76nV+hHIN1upZvRdtVMwFMQgApCH7XIyO1xT4Riww/d3QXMvVZO1kCxOy4
	Ou6J+fGaC2PRZT8sZuFKyBiN/OkKniSzkgbcbmI6Bjf/be82q8UByx/hi6x/4QJGt1He3BaQ/VKO2
	ariXIAxB84cjG0HDcgPWR85kPggPB8DmUCeEeQlvkEhpRZyy9IluzadljWOxAYxB/GEYhJLAcf2GZ
	tBuZMB8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzUJv-00000003XHS-0NOf;
	Thu, 27 Aug 2026 07:14:43 +0000
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzUJp-00000003XGS-2j1L
	for kexec@lists.infradead.org;
	Thu, 27 Aug 2026 07:14:41 +0000
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R6Ruch1756211;
	Thu, 27 Aug 2026 07:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=yQj70NK/8iluOdZ7+C0cw0X3MPBb4oJAeL49qqjrW2A=; b=
	gY/o/+k0sR6pgqR/Lt4BhlRN0U27bLG5vWtQu8rKJxKt6iOTvkKlJUv5c97NVMRI
	Rf9uu4ejdis055RKK6nfInhwgukvK1uD66U387DXrpBWqgO2iup/ruAFcMXuiaus
	A/wHH9a6NWPW8GNIz8MbiyWksF0dWZ2aAVVFK9VCPjCz5DCeKhdpn2DhrT2pMwUG
	CI2rt/4XucgHchR+YGsW7WoKNjztl8YjwgkpHaW9ZYJQ9QW/wXe+7iiiCaD1fS3c
	jwglApMgk3rVdtNhvocCwZUCrULoNKfjS2JDbiqhaht4v/nfw0M4ikKP44alJwcm
	p258R1IwC/qvdAMPGCHEvQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11022122.outbound.protection.outlook.com [40.107.200.122])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4gaasd0b31-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 07:08:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWW3ryZbEArsoV1OwR233yS1crmQkF+yrREySluQ0v0Ry/KTc+OrnP6O16SoVI6jsyars9qNCpqecaJ4ofriEFh/4Ck1mwbWFT5hUhEKL0plK0l2AQz2KHyBFlMhmchx9elV7l6iLHmDya5LIkJTPbxMRXRStayjbujo8mL/rCZ/fg9PcwxP7G8Zes3Wi3N/hZL/M2/qn+3PynzhJ+Zl5ZxbXwF51fYIyTWVxi6VXM1WxMRtAF3Pw5UenmnNDfjpWergjk5PIEtAk64rK9+5wXqYdu+kpBUbL+w7n1xJ20lrJiZWlXOzB3Oomrt/2ImUw43KnyKO+ba5WU9N7661jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQj70NK/8iluOdZ7+C0cw0X3MPBb4oJAeL49qqjrW2A=;
 b=tKHEUXhrcoCGPnE9W333eZ05ONmg8wxce1wWkZRR4nhI43zJARHUH4acDFXlWFYhv+MVa8XxPezD2NvTP+4hdDtuSMR0cFcmjLC/2WRALwFJAMVuNh4ePA2qnn00l5TGAQpb0AfI1wngdA6oIcCLEXSacr+4aPqQTSSLo+SVwiyBeyQCi01163AMQi9veP1zqhg06nf5mgplX67kdq+3ALOVycp+HxO7CKJZzHNmR+6C/QZW88oL3sfQR08oPxCg+L+4sr+SMsZcXK3J3MGBHm/xYuIMk7B3dlNcoMbwXj96u6uR4dOjlhbOwYUgYIWphN77txds4wbD12wrG5uSPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by DM3PPFF2E67D388.namprd11.prod.outlook.com (2603:10b6:f:fc00::f60) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Thu, 27 Aug
 2026 07:08:42 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%3]) with mapi id 15.21.0339.012; Thu, 27 Aug 2026
 07:08:42 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: x86@kernel.org, kexec@lists.infradead.org
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org,
        baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com,
        pratyush@kernel.org, ruirui.yang@linux.dev, eric.devolder@oracle.com,
        hbathini@linux.ibm.com, sourabhjain@linux.ibm.com,
        ruanjinjie@huawei.com, include@grrlz.net, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] x86/crash: reserve elfcorehdr for CONFIG_NR_CPUS, not CONFIG_NR_CPUS_DEFAULT
Date: Thu, 27 Aug 2026 10:08:21 +0300
Message-ID: <20260827070822.12651-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827070822.12651-1-ionut.nechita@windriver.com>
References: <20260827070822.12651-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0044.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::24) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|DM3PPFF2E67D388:EE_
X-MS-Office365-Filtering-Correlation-Id: ed5c4b19-efcc-44be-3ff1-08df040a0718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|7416014|376014|366016|10070799003|23010399003|1800799024|10067099003|56012099006|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: g3OhNdtP4P0JnulVqm3W44zC9JnPt2x7yXnUWL6d6UrcHUaLAIpryFQSqmNg8PnTUYwWYNlkesiiGBFSmISonaciAayMBu9glePQCg/qHBy2fVyAnQ6dOyz0BaGf6t6iT1I5m3TCznQbHHjX1rnXVt8Eqwaq2swPDEaSPXFAE2QSf+l0Fin+pdPUAwuwFpRaLCx/+bqCL0yOFEbGzg+YgYfG/q8ppEW8FmLnjs1oaXFplHqVGYoN7SbxHD8ICqGSSa+L5yOwrYiK7dYCyhtNMtksrfi8nsFLEsqGv/UIqdluxRj7Y7TbRLnxGyKDmZG4dw2syMBRzjospSvEAJsCQhIzmxjIz6nSZnrmSXQVGsg+AOyIGyy8QiP1vPtZGqWbHkfHWFDwCveDvMxLoXzXUzRLJL3HlfGQ76VmlnFUy7xDGRWAA8lEfg6z5GB8f25Xh/+3LnRiRiu5PHONuo+ejGBexuQXXrU+G82CC+4Y1hR/+mBTTqwltsrq+MlFZcpkL6Ae11IrsiyYGEeUhMwvkQ2SOUbFP9W7OTEq5zniAkJLuI/fowf5OujVhzykloXpX35XzT9Q0siEMydDXcIzlZwjxUW5eXBCiulPRp7NidLoYuUleHzZ6RGkCiIdh2o6x+3wk26NtfIsgeh+B0MkFqbIesjdYIBoJJp32JbsKdE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(10070799003)(23010399003)(1800799024)(10067099003)(56012099006)(6133799003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xtGP+rGKjovimeSp/cnd8WIrDZDx8QKpw+2wIXzTT+l1WWES2PLGTHoKgADD?=
 =?us-ascii?Q?E+XwSy7AaCrVpOzlq+gQXiI46Y+K9rM3d46fKS5cPeG6PTgckzZJDQuIhcwP?=
 =?us-ascii?Q?Qz7cNrIfRRHmm0ikOR2aFACOzoumQHG3hQDo7Qyy4MF2CA79DA6v+fUe3PEn?=
 =?us-ascii?Q?iycmkccG2HRvMj39NN7vv7Ys2jsqvxzwq1/orKbIhSJttgU/Yrx19vPvmnw+?=
 =?us-ascii?Q?sdSrp+FgtTK7beflXNHxH6g4k2NN0UZAd9QuFect/oTbZdZrJR++dIT1zQ/M?=
 =?us-ascii?Q?Rx/eJcv8hzCEulJaK2e/QP1YL7A8m677V0eTXz5k7Baz3BZpde8Dt53Zmt6F?=
 =?us-ascii?Q?lxlKwH+EmxrEIyw5A7r3LS7aUl81BdRfqMUz9z9Y7WM8HXEaDpKuVoRDn35V?=
 =?us-ascii?Q?5JYUe10qBMZPvf6079KWnMOemLQozY7CWV/8NQ2e20iJ5R57+P0AgvRPEKsQ?=
 =?us-ascii?Q?828OSa6GQMWDA1XnVPnYBf7SQkq/bCYfvqg/sbqjKAdSHvcor6LvN2Dj0BUk?=
 =?us-ascii?Q?niMbdcdJqOirqezrFPFLKIMeCLuqhN3yvqcORJiY2C3yTldPZerX4fTnUt6x?=
 =?us-ascii?Q?X6aL0yEP/lycykCH1bwU4d82jeRPps0Z3KAFyoxrD0iCLffXzXqvgFcAAK7P?=
 =?us-ascii?Q?u2lWgVVROk3KF4MNY0Q0n0yv4UPbbMoGJd6TH9b3l7QNvFjf9l31hKRQVdjV?=
 =?us-ascii?Q?ZZTlSGJ8tCkq5iRirSUH69oFASAH4NqVoD5pHCxuNMOBPVu6BM/3bslcr7o4?=
 =?us-ascii?Q?IexPHk3P+VKblFBqiih/4Cx0yR1kRB7Pprbn6p7RhGkpWmJxh6mYhGv0PP63?=
 =?us-ascii?Q?PiQ/UzYhU9FaL3I7a8HtD7u2VVqu94fs+YWl6tL5mExM7TofhJmkQg3EG/GT?=
 =?us-ascii?Q?9GEXvZjJXV9d6hTKicbgpKswIPpd4ye5b5DtDVpdpX4OrT5cli9oJFAWUKYc?=
 =?us-ascii?Q?uV0ipptB8WFItDh4z13fzsw7jDE1+qd8YAlxT3hIrIO1brtJhGqHD9u5dno2?=
 =?us-ascii?Q?8+cLDuk7IkfVglNDo9O2ZAHm5Xhod/sutTmV8K0I8AWIXtz1fuygcFTWJlOR?=
 =?us-ascii?Q?a1131aSWIu/ycCx3EgCVwp17r1WBEJLZBWBseh812GhfIbp+oubWIsTAGpLR?=
 =?us-ascii?Q?NsrlpQnWb3m7MaZO6k/4aCJy8n9GLqwDimtvTMLFiwTjQ15jV8RBwBKyzhYT?=
 =?us-ascii?Q?ISP3KakmxXgcuFDziuu61srOL5TeBf2c4z/LW4KXZkHiDOPhsU89rkLQx3z7?=
 =?us-ascii?Q?xD8C5FWt/iPCEVoEujyTqgjd7+t3lT1vFaAhT0t+1kTYwLjmKjK+hzeyk7WH?=
 =?us-ascii?Q?0YHjwsdsBblcrIHv87CYgCmfMs2r3X0yMS7i9jmw2qzzKXKDnlJRJKpdWKWp?=
 =?us-ascii?Q?k5y354NAf8usSmwuFt8y8cac2QT1jTH4mjgtLhMHlwp89Nspgwg/V+GKEuf9?=
 =?us-ascii?Q?hWe+lPnjE+of6Zu08MThmrBefyb/uTIQE4Ib6f4vUjFXMts6GP0VMzOQOMKh?=
 =?us-ascii?Q?Np3QYKiVrGdL11U3uSYOpkwWtKTMZjvKp9Bt/hgy6fxC3fnsv9CCETIv2Bd/?=
 =?us-ascii?Q?rlPaR+fb/hL92TsUqOaH6eM+yB0GxYV9i6aovILQ+zs2droyqrMATV5HC0Sb?=
 =?us-ascii?Q?d48EHSDZx94J2VjPuB5TgMVqs162ff4fZarimgotBfagk26eebyByehNxjQE?=
 =?us-ascii?Q?Dxo9rx1TVEvUPosCSyAUD9kILEh6zaQ6UGCL8kr7SFR/uw33LGsa2eXHSN4I?=
 =?us-ascii?Q?9JXKgbKUKF2ebwUVPduuQl/pltUe+XOBfh38gqe5cjM3m2zS6Xs01rrXZ2Nc?=
X-MS-Exchange-AntiSpam-MessageData-1: YYOTrY6ejezXccGnPULqJVlyZyry/YdFEIw=
X-Exchange-RoutingPolicyChecked: mbQiZ+Wg0+v/rQ1YpLasXnfvYwyklmo8QIHJW2Kj/HcEEYOiVNdEMnlGbHboCrqfQFUgsiwt0MlSr7QNHq+AaQ6WzgoxPIP+5Fp6n0lquTtn9rY5aoUNWePWS3YryFCIpykrOD7glGW0pk41HB31ttbW/xtXfmsY/5JeOwGropWwXf0zW3dpaBBkCK45dpR7TSBBnIQiVoAzyuXPCMaKgvL2yDz1eBsNoIGqWFZMgwVV39CjLcvqYUpJtryHLym+29/XQNembw9UVFVp8d1vyr++P1JT/aEhYwG/EgIZElcH0RZM43vBBNBlR4w1tNVSF/wkaFAREPtQr2zx6+YHVQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5c4b19-efcc-44be-3ff1-08df040a0718
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:08:42.7212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9J3pbynSNWx4DSoVTSIsL1eAOCTY3zM2qMggSn3K5YVygfCmVtQ5m2wzQJVrAoGuI5C5bvPIyfEcWoFRHdGNDUvQDEMeRCv0ABsdKT6aymM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFF2E67D388
X-Proofpoint-ORIG-GUID: VE2qtWAWh0J2UQWAgYeubMwNcp7PHkn6
X-Authority-Analysis: v=2.4 cv=eLEjSnp1 c=1 sm=1 tr=0 ts=6a8fe27d cx=c_pps
 a=jsJx5cRpnMcsqjM19+T+dw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=i0EeH86SAAAA:8 a=jcFIXsoQAAAA:8 a=VnNF1IyMAAAA:8 a=m8V-6NWbVX9GoHuZUvMA:9
 a=FdTzh2GWekK77mhwV6Dw:22 a=M1-Q_cRM6PFdmZSamPpU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA1NyBTYWx0ZWRfX7iyUIUv8Ugrm
 Gj6pl7wFmmgbtyIUN4Yu44S6TluVbesI7Scx9AIC48yMjiaLPF4Hd35BNq1/MhTmKqTJGN/gOmA
 VGIGN+86TzjnITYBDF4MbZg1MefRydtql34Q0+MYtmJasLYp/Y/8P+ZSgCF3xCd/BQTaFscVh2O
 es2eHKftw3aeS9dNqlimK9PZwmpOY99eD9snOsM0oINkcytLx11a9xBgL9XR6XOkoDfspuyPjD3
 cQEQpc3w/OMeXbh4OYGA5pTioQdSvjcBCm0vic2ivaaJueKroth4qEZReNZRKpL7LGmt6nBsMQm
 oJBM3vA29ukIhEsGjyMYPWbmSAT2I3pb/DfdQtxWhv/npCQpu8C4mybIpOsySjDw5TLt9wvrVE9
 mKcsu7/Rk8qww3sG4V3QKnJDxhxZiyb0wUuYsfveREXv+eQGL5bI/Cuid2uT/qaQN+brP8GpfJd
 t9u51nNwmAYBIwonjFg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA1NyBTYWx0ZWRfX9TausGgXK/sI
 n5K+9vK+5UyXBh2RGzYqyqGq6dAsFnatMn+6SQ4f7EkloDWyAcT4A7UqUcxVFPoPAMczZ/VhSS6
 KpXnay8hWwXa92jXnI574c0PYtlLJXIpeurXfWoP2IepkmwD4IwJ
X-Proofpoint-GUID: VE2qtWAWh0J2UQWAgYeubMwNcp7PHkn6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270057
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260827_001437_811697_C59965ED 
X-CRM114-Status: GOOD (  11.71  )
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

NR_CPUS_DEFAULT is purely a Kconfig thing.  Its entire purpose in life is
to start NR_CPUS at a sane value.  There is precisely one (buggy)
reference to it outside of Kconfig in the whole kernel: the x86 crash
code.

That code undersizes the elfcorehdr reservation whenever NR_CPUS exceeds
NR_CPUS_DEFAULT, because the header carries one phdr per possible CPU and
num_possible_cpus() is bounded by NR_CPUS.  kexec_file_load(2) then fails
with -EINVAL from sanity_check_segment_list(), and kexec_load(2) silently
truncates the elfcorehdr, which surfaces later as a bad or unusable dump.

Size the elfcorehdr reservation with NR_CPUS instead.

Fixes: ea53ad9cf73b ("x86/crash: add x86 crash hotplug support")
Assisted-by: LLM
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Bradley Morgan <include@grrlz.net>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Baoquan He <baoquan.he@linux.dev>
---
 arch/x86/kernel/crash.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index e681ec9cf1dc..e6f23933a6df 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -369,9 +369,9 @@ int crash_load_segments(struct kimage *image)
 	 * maximum CPUs and maximum memory ranges.
 	 */
 	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
-		pnum = 2 + CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES;
+		pnum = 2 + CONFIG_NR_CPUS + CONFIG_CRASH_MAX_MEMORY_RANGES;
 	else
-		pnum += 2 + CONFIG_NR_CPUS_DEFAULT;
+		pnum += 2 + CONFIG_NR_CPUS;
 
 	if (pnum < (unsigned long)PN_XNUM) {
 		kbuf.memsz = pnum * sizeof(Elf64_Phdr);
@@ -430,7 +430,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
 	unsigned int sz;
 
 	/* kernel_map, VMCOREINFO and maximum CPUs */
-	sz = 2 + CONFIG_NR_CPUS_DEFAULT;
+	sz = 2 + CONFIG_NR_CPUS;
 	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
 		sz += CONFIG_CRASH_MAX_MEMORY_RANGES;
 	sz *= sizeof(Elf64_Phdr);

base-commit: f82a5da2f04960df9fb57489992d03dd5e64ec6f
-- 
2.55.0



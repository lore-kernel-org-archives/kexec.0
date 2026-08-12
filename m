Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C82C5B572
	for <kexec@archiver.kernel.org>; Wed, 12 Aug 2026 17:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4+9oJsZPPqUh0deoN6FK+FTSLUaXI4kqjJvqUAM2IZU=; b=v0d9ECmEai8H9QCuks7VUHK8rh
	z9GcYUIiQTA36a7Y25Qjzxpvq8ndBrChY/iHzl7e4UhRJ+HO+YiwDWEqLytAIPVmqmy+K37+B0YxC
	WD12V8nsuvRKlG6g016XyJyXJrp93Uf6wrwoYDo/DjOIZ7KNsJhrsO7y/+L1t+1RxotI/T6BqJnaM
	aAO1Vv2tZqtGhxTZ6IDFoyp+VmUQkQLRRpjHCAhIfd1mT169YmCHSPVLGbGUw49n1mBQR9/7HEHxY
	2aurJ8Ne4zOfcCjrF/G798q5mmKdyC42JON82akdzMQ/xPsTxZO9dbsj6DLJm2zfAjVYH8mK5+JXN
	7W5+2Y7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuCOw-0000000Gdpb-2ndv;
	Wed, 12 Aug 2026 17:06:02 +0000
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuCOt-0000000GdpB-33Qd
	for kexec@lists.infradead.org;
	Wed, 12 Aug 2026 17:06:01 +0000
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CH2SB43201260;
	Wed, 12 Aug 2026 10:04:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=4+9oJsZPPqUh0deoN6FK+FTSLUaXI4kqjJvqUAM2IZU=; b=
	lazy6h8UDO2XiEruPuehlZQ/14ZxNNkx8Dg4+sCNvbGPCuoYgNzxavjbJj6EfN7i
	VQ3htJp721xnKqStjmJ6bPXMkLboS/udT34FQeyzS7BWRswGRYDR+Sh1ppae0Xrt
	DqrwNpIRT7arWl9AFz99hMDgk2fR/btMH7cZglkwUskPrbyoKINyRz9CDC1MOXxZ
	moLC8om/CSbIPKfljUo5P9L4MlFvQjA1TUKqIotTgpiEOsTsepKSOH9NqeLT3FV0
	Wb2OBIDu9V61kzk193mlhc7kSLqPNuHtiPQpYEMrmVyYk7ClYDXEG5D+7/Z9Kf+f
	eDR6+GVon65Y4eYQE6slsg==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020120.outbound.protection.outlook.com [52.101.46.120])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fysggbffe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 10:04:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/LPPPzMQJpI24HjDWM/1ULQ16Xsx3z9n1RCIGDqXw0bA0JZBtrqcZWyHVZrsaH6b04YnW2S6soQIQbdvQ7S6VgTvVa+5u6UNehgatgk1yr7qcc1BwZzO8m06vS5DO7r+NaV1NGIfoSqjh1bmFiP0kzaIVyqgYJZhbYin6ez7MelJ5cSxryhSQ8PEW0pVwXst+TL+WLvi1Y6WzbV4AYUOt9MugNcdjU2hYxt7bGAWR7VCc+fEIw/U4+sUQkihImf3pMtXYb8uUJX8FFWY9mZHbo9YB/WIWh/ttS8P8sHb/fSxsjTNyc4osrvkrWoTyO/Urv+k91AWmsvqDxIIqGoHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+9oJsZPPqUh0deoN6FK+FTSLUaXI4kqjJvqUAM2IZU=;
 b=mCglK+hohJfcaYLhGr/FZIzzJGSzl4iYhHoK2sBWGsBnQoVR/LdoACDeW07r8ThdVRz04rLB+qg4IOBN8GtYASrBDBMVAFwkw9Je6wXC/cPqscClFPug12+GWkN31Q5VMc+kADkaRf3powe12hB0dLGGaYh2tedoos9fSUH0VFRBpD8+S5S8IZQ0HTaYCVblGzrZAbiA9ZlbZSacNcibkQh5K3oehXbf9W289tKl0YuvEjdSr3AnB9sCqZnwtz4WsFgJExQOxg3hNtNPZxjxoCniqt7NknASngNFNptjWeAS2L8T3VYsYO1Gk3fhIphWgvwzq6VQyoFXCbfM280DUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by MW3PR11MB4667.namprd11.prod.outlook.com (2603:10b6:303:53::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 12 Aug
 2026 17:04:48 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%3]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 17:04:48 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: x86@kernel.org, kexec@lists.infradead.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, bhe@redhat.com,
        hbathini@linux.ibm.com, eric.devolder@oracle.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        ionut.nechita@windriver.com
Subject: [PATCH 1/1] x86/crash: reserve elfcorehdr for CONFIG_NR_CPUS, not CONFIG_NR_CPUS_DEFAULT
Date: Wed, 12 Aug 2026 20:04:33 +0300
Message-ID: <20260812170433.533845-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812170433.533845-1-ionut.nechita@windriver.com>
References: <20260812170433.533845-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0502CA0023.eurprd05.prod.outlook.com
 (2603:10a6:803:1::36) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|MW3PR11MB4667:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ef807f0-d45a-48db-f146-08def893d0d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|52116014|23010399003|18002099003|11063799006|22082099003|56012099006|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info: A0MLTSP7/YYcyXB6DLvy4OaZUWo4oyZ6RCcCesOJ2j97qpXEYzpJZW0I3rw25ITcgb/PAL2E9SQJTzgLAyHlptiRHaqcojehy+PdMc989hb8QoR6jqcR3EGg6KL6N0lumwGM32a+EGNBaidI8J4LrXAdT1XR1YeFEFSCiXqHMFAcF3AzCqNOxAdkxQTAUU0LIGXCd1lfqLV4dbBpXURMjIhj5m5pHTcwjBQf1nzRhlLY/tv3e4DNnfiPO5zC6QCD8dt9uWIX3Uy5yxS+0GxOxZIuUWGqna1rhr0IAmzIo+Wcn7IhCzqaxsfbpMIpLofSeH1usPwSjXzXn9/BFhZnNqi9+xlgwWvItaEEVdvKyxfHrvUjDTFBWqhglD9xItyVelIpM5q4pBVyaR4rIhXLvsCmdQGyiNLxgWRuopnC9CulQ8TPPMWx6jaS17vzykPiWfIPadhHajnYFZWaBSG+ynmYXi2N195e47vesavwZb2+MG/R+UpI4mTxkMRyd1AL6D8YdQMTtGHdDETbU3PPLH7pSNaUpsjMKRh2BXxo3SVh4q5nLVelk8yGKMUbeDMRjphai3Eqi3aOtekgIaKXalc9OGBPmdwhroJya1LLURPZXEE54xFSe8dvHzQXq+DC6dTdX5p8Dvfa0aFGbzDS4g1SVG2yS5J7X6SK8VaZnvR9dxTeEBN4IPz4eCZT8mB7wopwMZp9eZXPMdaWoklqw4DvNl8D1i0Qgdt3ZI9aqfE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(52116014)(23010399003)(18002099003)(11063799006)(22082099003)(56012099006)(10067099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GrtxJIXUPRXRro3PxMe6HYeeez4SDQ0cbpWsyxpUfa/9HPBzR6xLS5lxKeZp?=
 =?us-ascii?Q?F2m1hSR4Ybz494gTSMp/wC/IrkMryv2LLbXDfcSVReBAjinxdMZau4c5kG2p?=
 =?us-ascii?Q?/jfg2El1dPphtAiw+3XsF96tCbDbxtmJiWEo6qic/IN0MiifNTcnWV9uYY+n?=
 =?us-ascii?Q?RXqiVFHDncnnTrZdVUpGr6FTnudQ5hg71uGWr79rZoXp1C7O7DB86wDiLjFz?=
 =?us-ascii?Q?k4vxrRzDV4JhbH6FFH45OynmGKsk+ntS6hy5357dKkmnRco7sKsE/HXACDne?=
 =?us-ascii?Q?c+Jyw7R1nYyKxoC80TfzNHBFjkP2qinD+YVNHmDbKC9bqqA7MDFj2QCi+5/g?=
 =?us-ascii?Q?2XA8rB2LspCGtSLEtB7gFfuGNRvh8m5pQV6cFqiWbsb81zN7hH/ofMV8wfZE?=
 =?us-ascii?Q?gO0CTbVeXzoysW79N76Y6S2coVSAvlGL/s51b/UFmfQjPrxchlmsjJvCEiz5?=
 =?us-ascii?Q?QnFfsjkleAjQbfcmxsIgo+bIR9pcU1f2a6zXBF2DAaLFBn+AszqE2TLz3liQ?=
 =?us-ascii?Q?O/QmEDsdFOQDZj0IJMVY6Y+rUbweSiNPbn5hwH2mDw9oU6FWeFbvGpP6j9rM?=
 =?us-ascii?Q?u5w47gkMk/1M7oK3Xv1S3b1iw4Vn4zMrDR1kxAW2PX4TlKeDfsADSha8wlrZ?=
 =?us-ascii?Q?+zk83Khnm46rBqIwFrezDq3ofTccLHNj+fYU0k5g930IX7f+9WYoIiZQVuvl?=
 =?us-ascii?Q?qKKkRbws0jtdP63Kgh67btNQ8B156jWIC/Y9XckiElvBbjdevClxVsVb6woh?=
 =?us-ascii?Q?xYnipY4Aj5BE2GmDxOa5+oaPugYayPn4MfZo1gk3/IgRHuwiGVSlBJ573Wpj?=
 =?us-ascii?Q?mw1SbR6sEfCphqNzdw1lP8b5bWVTJS0ZmMtR50SXKjD2yrN6rND+LGuRYYjf?=
 =?us-ascii?Q?kc+DC1ZSo3QMWMbOrwJvS5Z4lMD7d95JECydQsG9Lp9tdmQzjpoPHWmXmkBj?=
 =?us-ascii?Q?R4pJG8kq0s9D+LW9CtxmxaYOSUZu3TIuSDQ583lONUTsF7wTK1/jVGAFQXzV?=
 =?us-ascii?Q?sNxj5o+1WrHdO368SZMq4OO5w8lB4coiw45SWH62UF4lezj5rvELhRZyVJm4?=
 =?us-ascii?Q?AXgPxxc7X/mKcKVeefk0rrWIW0Y8KUkUVWiMc4I1GsAA/jK8ChBZmBUEmYvE?=
 =?us-ascii?Q?IL8iLHdsDHUUMA4uN0XXlbf+GziOYpx6vrL/ThRGpXh0toO5AU/VyiAeCMn+?=
 =?us-ascii?Q?Q5Z97oBhxcomziU3vvXx7r/k1mCHPY3w41a9OcW64VMcF/+5RtQGrBx2JeSG?=
 =?us-ascii?Q?dMerTaH38GMmHu44uiZ/SrushggTNpc8OKs3NTbmqfpsIp6mvwo47hD/UIHi?=
 =?us-ascii?Q?ZDaWIbzx7n64BYLAtuNG9tVgfeafDkL8JywpE8eCV+/atlHBYMSAQx1SrmVV?=
 =?us-ascii?Q?skzelD3jNoJxbSi5NPw+2zdao0xh+Y3461uUSRWdbYx5kAdKB9tx+84QvnEh?=
 =?us-ascii?Q?aMlkofCrQhhZwC9nCch4N4ciyLhwVICnziq3rBiaJE5xP0tK5FVh3hc/WszR?=
 =?us-ascii?Q?tfbBH5ckdhKRpIvuvq3ZWopbk5pPWBuSNjfEnw6OHmsWo6oZRv2BsIcAu+IL?=
 =?us-ascii?Q?ZWB2GngzWH3TCduoAkhkeoDIfByrZdLdN6xWbyynEw5DGkR6RGi31YuZQG7D?=
 =?us-ascii?Q?yE4ZJE4nksDR0jEADyIOXVMycEPLioegNrK+rbeyFGqAnCYUDQ/5l4T8+8LQ?=
 =?us-ascii?Q?/cc4AbcrdvBX+wd34Q5IPrW/6CYBkk/OT2XL0Z7IGf9CM5tk65FgItiZHjTH?=
 =?us-ascii?Q?Sf6CusTnW7hDGa8Df7r+6u3cULx0ZGk=3D?=
X-Exchange-RoutingPolicyChecked: FvKR60eie/j6eNuAkuoHshc+Pv9nj6ZKmklE8MQgb9YjQywfp93MqXmP4UuWHJimX5RKxPW7HSZbbtlxB3Cz5uSgAA/uwWg9O7/DXiDHhBkM6Jl/AxMKpY18GSveGkkhz9VieOmv9r8yxAvOPUHDcLhChmQZapGw6XE5DDQ27gXbhUWWxN6jnTcQJkO1C62m4ww4+tDwyupRXnnEuAB5Ae0vfXJsb6MoTOf36ndGZcScn2eV0UnyT5tcic+4o0T0GElwCNm3bwktpNHjrI9hYAOj4/ik5WHGpaKVxnlpd4FJDVUQ20akO9lAjrm4/QPJcCavGJP+XijNfxS7H774Bg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef807f0-d45a-48db-f146-08def893d0d7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 17:04:48.3668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7XTs7UAR9QP1vla0WMQ9TWvpIaRdr2vGv4WXX0POwQroaR4/40+cJ5ewf8yT7xhFYNJEO+78Cz+xD4/rJTh2ScQKg41wj0+y5R3bDCBYnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4667
X-Proofpoint-GUID: ow3XKwUiq44jnpC1XPdQm1qzdR5Eb8AV
X-Authority-Analysis: v=2.4 cv=fr3sol4f c=1 sm=1 tr=0 ts=6a7ca7b2 cx=c_pps
 a=8oFNIrebv7KdPcC3sjE6Hg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=ljYmtYC2WD-oBuKAIt8A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX1IJo3PTUq0Zt
 WM9YHTJDC0YgQIOADrSlbdp4HQ/kNtDUXR0VFCvlPqhOjlyn974JfrjPvefAAJ/vsVGL0paRMT7
 L7AZcvIPh1hg3dU56ByY6xIOznH58lroKJ/5svJPNPnCaSewzG7vfN65Z6AOvfM9wuhjZwyu38C
 SEe8IBO7AnTazVMhXiFNHZrWLUIIS6KKGNCfCj3FRA7WKT1nbcH8VS3cNsnKOZt82Ykl18wP1c/
 b4/erWPfX7wAm0yOmYuoFtq1PRNay0cph+9F3ForMYHIOk52zjX0lFPJCMJNwaC2csuapchBNP1
 xPIr6eWYTwzhtPP3Pqp53PbfvBb5njHuJCyTTK78LOqAcXj0o9k9aBSKIUodonnwVaQal4TbD2N
 vtY2I20LcTzCCpEm13VcFQnEGNKiwnsLiWS+q7Yf9AxKUKPy4RDi5J55M6fN17uw1LYD17PUavx
 JaTXnfC8T++gaf+gnUQ==
X-Proofpoint-ORIG-GUID: ow3XKwUiq44jnpC1XPdQm1qzdR5Eb8AV
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX9mKQ9tPKFfNY
 /pEVuVwAu/yTymklxRFX7u5OcCw3A1C3YPoUNqBfcyZN7FrKdKhVwCd+qak3uhpOEjKGtYbeGYs
 eivp3bo8IvPel9pN0IngezxezYPsWHGTwdkLdNYoC3UP0BxLuMek
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120138
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_100559_803836_FEED402E 
X-CRM114-Status: GOOD (  17.51  )
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

kexec_file_load(2) fails with -EINVAL when loading a crash kernel on a
machine whose number of possible CPUs exceeds CONFIG_NR_CPUS_DEFAULT,
even though the classic kexec_load(2) path succeeds on the same machine.

With CONFIG_CRASH_HOTPLUG=y the elfcorehdr segment is over-allocated so
it can be updated in place on CPU/memory hotplug. crash_load_segments()
and arch_crash_get_elfcorehdr_size() compute that reservation from
CONFIG_NR_CPUS_DEFAULT:

	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
		pnum = 2 + CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES;
	else
		pnum += 2 + CONFIG_NR_CPUS_DEFAULT;

However the actual header produced by crash_prepare_elf64_headers()
contains one PT_NOTE per *possible* CPU, i.e. num_possible_cpus(), which
is bounded by CONFIG_NR_CPUS, not by CONFIG_NR_CPUS_DEFAULT.  On configs
that raise CONFIG_NR_CPUS above the arch default while leaving
CONFIG_NR_CPUS_DEFAULT untouched (e.g. CONFIG_NR_CPUS=256,
CONFIG_NR_CPUS_DEFAULT=64 on x86_64 without MAXSMP), a system with more
than ~CONFIG_NR_CPUS_DEFAULT possible CPUs builds a header whose bufsz
exceeds the reserved, page-aligned memsz.  sanity_check_segment_list()
then rejects the image:

	if (image->segment[i].bufsz > image->segment[i].memsz)
		return -EINVAL;

kexec_load(2) is unaffected because user space builds the elfcorehdr
without the hotplug over-allocation.

Observed on a single-socket Xeon 6776P (144 possible CPUs) running a
PREEMPT_RT kernel with:

	# CONFIG_MAXSMP is not set
	CONFIG_NR_CPUS_RANGE_BEGIN=2
	CONFIG_NR_CPUS_RANGE_END=512
	CONFIG_NR_CPUS_DEFAULT=64
	CONFIG_NR_CPUS=256

kexec -p -s fails with "kexec_file_load failed: Invalid argument".
Reducing the possible CPU count below the page-rounding threshold
(e.g. 72 via firmware) makes it succeed, confirming the reservation is
the limiting factor.

Reserve the elfcorehdr for CONFIG_NR_CPUS, the compile-time upper bound
of num_possible_cpus(), so the reservation always covers the header that
is actually generated.

Fixes: a72bbec70da2 ("crash: hotplug support for kexec_load()")
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 arch/x86/kernel/crash.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index e681ec9cf1dc8..e6f23933a6df2 100644
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
-- 
2.43.0



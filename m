Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F34D6AB18
	for <kexec@archiver.kernel.org>; Thu,  2 Apr 2026 23:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zi3B/EKVMNNI/x6nNLnYAHXot6y5hHSHpjtXbiaLALg=; b=HDFxBd9NdmG0lbrp5wRyswoCYR
	1TgUMQp6/rR0HQZ01OWVjcWwsVLVdp36rLvyYA07iWSlZOHYx5dZSej5ozVcuohCFbsdOhJ1NRwg5
	FXI2+8Zl9TGgXNaHZdVdzZBdlxdidP7+8Tx72MVR++Zu/K03mBQWdOI05XPxgI1ZI4zmxxyBolzaU
	HO+iHc1osJxb0+rTXxcopmb9Shlx27HNEHyL1G6dzqCBUVCPeUK+j4nmV6134qcv41/AwT/dYdIem
	DKWYYx+P1T9wa85msQoWbiPYnrQpcrO5strdhl50ucQHl7Cgnv+8TIlcLP4HseYy/ri59YihZFWa9
	V8i9jCig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8Rfc-00000000wvp-3Lyi;
	Thu, 02 Apr 2026 23:41:52 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8RfZ-00000000wv5-0AJ8
	for kexec@lists.infradead.org;
	Thu, 02 Apr 2026 23:41:51 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632FBpa62517675;
	Thu, 2 Apr 2026 23:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Zi3B/EKVMNNI/x6nNL
	nYAHXot6y5hHSHpjtXbiaLALg=; b=V2vAV1+w55RaK4SVQNfSSdMKJet7sb6FPi
	Oy9h+004Erke5cd51lwMTTJChe+Emo/gVq0Y8Rt11d1q3NsmDfQbtYZ+mjKZjBz5
	Yi2dEMWis8E62NMuQ56DButcQsyd+F7YX5JBtav2eJZvMIwtms1LY/rzX3dcBjjR
	xdmgDMjW1JzL6arShDk2fLpbbWwLeRG12FwxT2mnQKm2CbNe3t2PuhStcUF6bFuu
	nhmMAFPn8IkOpvnCUnucmpUlB0i00SjLP2dgXTy+0bmNQLQqrhZUdFq3C+W+46lS
	zBBan74awDI3UWxMfxz+RUttbBWqB7SDKkkjw0RGCEEkwgi5rxdA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d66kr1bvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Apr 2026 23:41:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 632LMgZO024480;
	Thu, 2 Apr 2026 23:41:45 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012014.outbound.protection.outlook.com [52.101.43.14])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d65edbt0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Apr 2026 23:41:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAJ3Bnw94NZJrh+r4m/Hxxb0dreSu+lh86kpBQ/jLJkVglwa+K+ZOz1HS9ea0m4pL3orGDceK/fd2YBXZrHkdFf+jMkbuZo3ABwbzyCio5l7cz7/iPWLo7H5gPdIZvfBjsyx7qKxK9YoeRmW1U+xoivn41UorJyJBfautATUKGsmnPDK9PCiYK6J/PAVOJsmN74DMUM8c8wkn0dEC/Co5x7A7DxVNGCb6ejP20SmDZ8dBaz9t4JT0kLMSeCFb6thYx/GRj15wo6e5RbMzCjZzqaxvDYsChubc8Rp48X3cf9yWJNVnk6YSorpq68/4AYGbI2uUx4c1TJfAkynqYY4PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zi3B/EKVMNNI/x6nNLnYAHXot6y5hHSHpjtXbiaLALg=;
 b=HBmoe/0yin2Xzk6kwaKWcJ/pgFad+eBIlNxpF5fFkGR6VaZeFBYoFBltDNRFs2ynmowqTc2FHNMouoYcZDzXGqu04OK3cCpY6UCzDBVNMnAchrcDzTPuifhqoeoSGC3cVJ2DSMe7xDOJ8YY9s+nwwVT9g80wh+aLM47/uzW8vb1r2405QNvvuX8rhMk1L/fLXwCNbPYswtBNxdwEs5byCPo4nHnjsyxw3jZny2Fe7Xplc1vNSgNme78jUcWYjyAtrMmv/rtIXseARirOjdLXs47I00hfFyJtaos4HuYaDwVWYSAAUQZjJaKs9KN/r40Yn1j+/IuVLh82r61tBG/xuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zi3B/EKVMNNI/x6nNLnYAHXot6y5hHSHpjtXbiaLALg=;
 b=SHrxPxxMApRiqfX+N1FNhN8G0y2XBBstCHqwSNNgnW6rauGl93BeYqokTOxrY4XjYB8zgW0ouOkcZVHi/s/XmqT9Ptw0oKbYxmC5FU8XIjcdmsK0M0iWqV/YN37bPqO4zHEXQH3Dljc24WwduY/gSG3KEK/HEs5NTdICc++pmTo=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by IA3PR10MB8516.namprd10.prod.outlook.com (2603:10b6:208:57d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 23:41:43 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 23:41:43 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Tao Liu <ltao@redhat.com>, yamazaki-msmt@nec.com, k-hagio-ab@nec.com,
        kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCH v4][makedumpfile 3/7] Implement kernel btf resolving
In-Reply-To: <20260317150743.69590-4-ltao@redhat.com>
References: <20260317150743.69590-1-ltao@redhat.com>
 <20260317150743.69590-4-ltao@redhat.com>
Date: Thu, 02 Apr 2026 16:41:41 -0700
Message-ID: <87zf3ldj62.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::25) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|IA3PR10MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: d1832427-655a-46ee-754d-08de91116500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 3p05eUNhbrZH0cD6LByN9dU6AAFkfIjlIPLm7aCTd9y1SvnOONghK89aKbC1947HhHjMDZmLHcAt275p1DFOpGp8fgA8KqdrcW/1R9xKLL4H/14sDxDztrwEH41xjEU+mU9jFy1vzE+3RtoF3Lg71lcEE9uT03ZURanXWyI6/KsHc7dbfhvMfs5WlApvRvfUwDGio8ztNtNdmsKy0ejnUF5pJRVb/ybsrEeXNjaop+SjE7CJ9ZtzH6xsfnNkOm2v8A/sWDSSQgPJQj/CWdIqcAt1PVq5fdgmRDeJ/KsYoQ4mH8bHU1wXo5qtsGMP0VCQiuKn00+YkStI6GuEGqHdAor3xDFHfEg4DSziK/wAq9cTo6sLVWoTr60IIqVL++oeqD3xvy+OAB2woUTXkstHrKW5vXw2oJd/DdrA4Ywuls0O4goZNGOyX3V8CdOsAMmItxw1g1p1YPGipgFqmptqippHZBYD2MiAOEFUQrRPvtT43DrXRcz9lKCQ+CpAiOMfJb3HLjbrXKJJ9rZW1eeihRogyF1zy39HFpFwZNSgBLnaaU4nTYYBXIpGAUJpQpUWbuTyXrqkBQVS7EJml/Dxb6RHpuXIhMa3kIWRlLgDTlPkE9VXZ8p8WLl3mQfGcgnecW/P5cnRDsUWbhjT5QEn5REbgyT/NE6laxaeMJa947bYtnH8cfTfdk6S0VQtmvr29VxTes+6zlNSE2B3EzSNtl0cFbedS3CdobPMBwLtbMs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Hdiz+P47gpitlvHsYcCB44X3CTwohWJoPB+/2Y7SiIW/SIa/1jLuGq4yuRy?=
 =?us-ascii?Q?Z0kbJamWNbGJT3j54jF9rn5qoWQzmNtXeHOAai5riDsw2edUPIkIeKTmT0js?=
 =?us-ascii?Q?+16Rs/ag49y6ENb2D2lDYfm3LYTxCPhBaARoohMAeQg80laDNWsXVNEOi8p0?=
 =?us-ascii?Q?QbvehAKaMZOPYFa0e38LaxioiigtANyOEAlKjBzM/5DU/OsXnxP+U9Cm1STg?=
 =?us-ascii?Q?PK1mc3MutpjFk+dNQfW+/koCgo9enNhiUU+9r/8OZVwDEBjLALFbuX+AtkRz?=
 =?us-ascii?Q?pM/kR7jY4rMgq8YeevNQHyF/sBbtp/88h7ESGmph1QaJV+Grfm119YUq5FWq?=
 =?us-ascii?Q?sp9Gr4uWojGQ8Kzcqo8cKIjuwx1bs92ALfIQ8AHf0BDfvtv4UW9zUC7a3e1X?=
 =?us-ascii?Q?3mjkPccLdwqhku9Kx10okmjFpC8JvdX1DkvARyq6XCIyHdnA0E/YFusUCx9H?=
 =?us-ascii?Q?V3d1+rSU4Pft+DYf8BWIdI8cedakuEL/TrWa5lwXMd2oE2hF8q9jpJppPbly?=
 =?us-ascii?Q?NyIpLvzozV88H9yzzVLRC7pfbDlqagUnxhr+a1Vz911IDOG2xR/2fLlKXWj1?=
 =?us-ascii?Q?3tpXZnkO6ZwUY1n2IvI7wR3TiXuc7UuowC2oFMRC4g2BDXGF256dy/vvp4dI?=
 =?us-ascii?Q?6Y/3tQxSvCdToNnlzqN+wlgUVFXVsitWbcgHpcWJL7THOcU54MzwGA8oMA4c?=
 =?us-ascii?Q?SkjzJkM+tkQOpDp9Uz21CNWsnpgD2AJZmThJW8hXui7ScSUZPVF46Tocjg8i?=
 =?us-ascii?Q?EeBmScpxBqPKpvt3puwNa7GKcYgoKcZ8ci795I0Wye+7P9awrPhTXjQbB0fH?=
 =?us-ascii?Q?x5VejiC9T1uqiAHS0OVGjPPbj/eTC6M5sTUsk/he3+qZZKnttDpJV5yHFUtB?=
 =?us-ascii?Q?n6EDcapvI+/Dy7z+l+FllG2W/Ju7IOTnkFQQDrcTQ3pyQ9h8iAwqVbdzH44g?=
 =?us-ascii?Q?hrZwW+SiYme9e+qFW/iO2MizNp/KR9qid9S5pIx6pQ8wd0O1hhRuCEhOnPdw?=
 =?us-ascii?Q?5E/jclUTT2YQeQtbKDnJngv1rqjjsDVjHrGyNc6skqGU/K5+zgzmgKUkoOwM?=
 =?us-ascii?Q?1qAf/KGCZwT9jYUNkK5efgGgFY44DGzs6l7vMrRtUAIEd7G/L15QH6lRpD6s?=
 =?us-ascii?Q?go2bcm6B3oL+Jc4BrUUMqm9bRWnVzb6VlPOAolHWqC9yNOY4GO7KdDUpFqUv?=
 =?us-ascii?Q?idLkXOJc1iJdEUGF8j5tk7bV86fG4HpbItnQ34LibeDkJPUkyzQ3bKCl2Gor?=
 =?us-ascii?Q?ickzPNKZUr72NiW0zjKBATHne/uJzXsXG5nP1nXmAawzy1wMWnF8vnIkN491?=
 =?us-ascii?Q?1dqCzXRJbMiqkAfo3lfGidhJohogDjTc46z0GhW+xahToYcq1UYLU7UUsOWQ?=
 =?us-ascii?Q?1sApBTWMzCrLpNC98LockQP9RxI1ufCVCq8gojtt4VLOLHJCpFz8aErwOgJl?=
 =?us-ascii?Q?E4CyWge2pDlvNEZ6a5zh+GWY8NpWvfwuLDMmwbZVGXCrFzJ7A0bo/YoXALYF?=
 =?us-ascii?Q?sYbLqNAD1mtChDuHyCCfp5FakVgx2QWDM6jE9vjvfGHV87+3OxNc1jEIqraa?=
 =?us-ascii?Q?BOgbcFdtbgP1AMALydLBJ9qYeCkLwlO66Or5JvQ+iprsOGrlEShFrYEWs/2r?=
 =?us-ascii?Q?MB5JlccplEVK82ax6PS7EJUug8FVo7pbJXfgLN1kEYObUnDLYros9WsXnhvB?=
 =?us-ascii?Q?0byDzo53B3JjCLlZNIejJwRVhlzmgSBz0s/SvvH0tsa3D0FaeR7d5zwriTfB?=
 =?us-ascii?Q?ZWUdSfAPIWcMbAkKZcpqRZQYm1OmneU=3D?=
X-Exchange-RoutingPolicyChecked: O4JDmWc/myfm85qaCYNuHhzwlg22b0aLIPsrcVvzYsu9jDPjCW0LPt73EPkwyMEggdGcesEFsKiqV7nEzK6Q/db9TIJKv+HOj47I/xzBOGUHFlXYzMEH0tmR6oeLwpf6vp+wgoH/45weMVD+yyHsak7UvCwv61891MAoFVxvsiX1LxSe02u8cwFD/De/l1TgUplC7qeqCO0muhDZXmaMDKkIllnpx8ol5gzxDD/aPH7N4Vh2/DhYTsN3p+AUjeOi0bXLbNpKvqxflSL4qb3HWfwX5IWaPeD906eXOMzvW2LEgPfIgJcW4a9IkebRC5pIcI7oMwgT2H/bFdVwE2QXoQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JzElWO8hUdngAtcILBlqJGKwsVMLdSA6lCbLx0dXL/o1svJ5U99LBd40PrbM0OHCD8tKdzE27HSw8q73SHeNOQ/KMX0spA8HAqi0nY4js43QpVagR1iLqZU525ZNQR7KnBbFKq94uJZY3UgY4j+/Pb34zYhpUK80rU52MjlrB7HBSyVlB/tY/5B61q5lyIRPLOM/izfNf1h/dUGWSkx1LMEt1sBEAp8z+6SRffyYg0CIWs3Wprk5t4Ep53b3KyFmJ6mhdlMTZPVq3AoCdsila2WxJiMeIdqHEL8GnwkbsfysbgQeEUWdGCg3lqitN5vXFrznAbOZsPMMfTLM5lcnTW+hjROGpjxCL5TyG2SF/ZVwVsrxqWZJUh1y6DgbDmcygZlL68PDHSeKbSLrue7A1f3ZyyMp9YS7ooHeGp0nuX62j2M3RCQEZLmbnV9ZJ1Z+Ajh8Ik6XV3m8QxVY/2eUHHUZxPMQo8HwwhfeD+zmTE1ROE41O1naj6bpAkMDC9UscaPN2ibPWLZvUawvGNvvIT6BXq25ogeBkaNaE7EE+W48mm8GfxUAMDYb9fUSncp/BRN4axm9zHpiWKp0g06CiRZpcuwweKf71pzYM1Q/EdQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1832427-655a-46ee-754d-08de91116500
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 23:41:43.0231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66TJMiKdoZ7s05Zw+sqzCAU0Jp4TcQ52n7lCJ+dzi1BpY/OqZKTI3AxvtbMrB63KntsOJuIgWebt0/LUnOnFtB9XBJvu0aiVrtzlV/lxuAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8516
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2604020211
X-Authority-Analysis: v=2.4 cv=PqaergM3 c=1 sm=1 tr=0 ts=69cefeba cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=znuxxhC2N-VR2dbgTAUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDIxMSBTYWx0ZWRfX/lilyaR8lSXf
 PljpiFxC9DqQ3PqtqbQbYArpzYSHTwgwbrtzPOXQSpGQ959InzI9To54zOJ3zBVjZnqIE/2mnKR
 1sVKel4rlLLwToCzM+jXRnDFnKLB19o1BtlN+OdeVYJUpXEKDm2bg1rpEriDv1SOK9tY0jXEdo5
 M9tHcqfarQFF1OFYL4Domxi1vuQR6HkwwHZGXM5BWJWD0dDrmeGFIh34yw6QM1oyhzXOUMgpALx
 IOs3rYkGF74+1HLPsfOhFo9DanOVhDvoetXwEVPSV2pXObYIWWnOQTtgxHRvkuhcmEHncspHriQ
 v6xh7Xa2YXzGlgWvuDfFblQye5zHWDwm7R0NL96JiL9zXjL8MS6N7bEwVJVYHI8Ljj25VoIk0Ne
 BZVputsJ6+sg4qIT5JwaoIg8WzdDmQwz3jhiMjKyFxoK7uIXD2C4HztPD9UzQIQCiztXDXAfsar
 1kUVaBTYPG3+MjEnPQA==
X-Proofpoint-ORIG-GUID: em9M9_C19z_R_pypLA1LhotoL_4JMHun
X-Proofpoint-GUID: em9M9_C19z_R_pypLA1LhotoL_4JMHun
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260402_164149_205281_2CEBC37F 
X-CRM114-Status: GOOD (  25.63  )
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
> This patch will parse kernel's btf data using libbpf. The kernel's
> btf data is located between __start_BTF and __stop_BTF symbols which
> are resolved by kallsyms of the previous patch. Same as the previous
> one, the .init_ktypes section of makedumpfile and the extensions will
> be iterated, and any types which belongs to vmlinux can be resolved
> at this time.
>
> Another primary function implemented in this patch, is recursively
> diving into anonymous struct/union when encountered any, to find a
> member by given its name.
>
> Suggested-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> Signed-off-by: Tao Liu <ltao@redhat.com>

Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>

> ---
>  Makefile   |   4 +-
>  btf_info.c | 233 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  btf_info.h |  90 +++++++++++++++++++++
>  3 files changed, 325 insertions(+), 2 deletions(-)
>  create mode 100644 btf_info.c
>  create mode 100644 btf_info.h
>
> diff --git a/Makefile b/Makefile
> index a57185e..320677d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -45,12 +45,12 @@ CFLAGS_ARCH += -m32
>  endif
>  
>  SRC_BASE = makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.h sadump_info.h
> -SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c
> +SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c btf_info.c
>  OBJ_PART=$(patsubst %.c,%.o,$(SRC_PART))
>  SRC_ARCH = arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64.c arch/loongarch64.c arch/riscv64.c
>  OBJ_ARCH=$(patsubst %.c,%.o,$(SRC_ARCH))
>  
> -LIBS = -ldw -lbz2 -ldl -lelf -lz
> +LIBS = -ldw -lbz2 -ldl -lelf -lz -lbpf
>  ifneq ($(LINKTYPE), dynamic)
>  LIBS := -static $(LIBS) -llzma
>  endif
> diff --git a/btf_info.c b/btf_info.c
> new file mode 100644
> index 0000000..1cb66e2
> --- /dev/null
> +++ b/btf_info.c
> @@ -0,0 +1,233 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <bpf/btf.h>
> +#include <bpf/libbpf_legacy.h>
> +#include "makedumpfile.h"
> +#include "kallsyms.h"
> +#include "btf_info.h"
> +
> +struct btf_arr_elem {
> +	struct btf *btf;
> +	char *module;
> +};
> +
> +static struct btf_arr_elem **btf_arr = NULL;
> +static int btf_arr_len = 0;
> +static int btf_arr_cap = 0;
> +
> +/* makedumpfile & extensions' .init_ktypes section range array */
> +static struct section_range **sr = NULL;
> +static int sr_len = 0;
> +static int sr_cap = 0;
> +
> +/* Which mod's btf should be inited? */
> +static char **mods = NULL;
> +static int mods_len = 0;
> +static int mods_cap = 0;
> +
> +static bool add_ktype_modname(char *modname)
> +{
> +	return push_uniq_str((void ***)&mods, &mods_len, &mods_cap, modname);
> +}
> +
> +bool check_ktypes_require_modname(char *modname, int *total)
> +{
> +	if (total)
> +		*total = mods_len;
> +	for (int i = 0; i < mods_len; i++) {
> +		if (!strcmp(modname, mods[i]))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static void cleanup_ktypes_modname(void)
> +{
> +	if (mods) {
> +		free(mods);
> +		mods = NULL;
> +	}
> +	mods_len = 0;
> +	mods_cap = 0;
> +}
> +
> +/*
> + * Used by makedumpfile and extensions, to register their .init_ktypes section,
> + * so btf_info can know which module/type should be inited.
> +*/
> +REGISTER_SECTION(ktype)
> +
> +static void cleanup_ktypes_section_range(void)
> +{
> +	for (int i = 0; i < sr_len; i++) {
> +		free(sr[i]);
> +	}
> +	if (sr) {
> +		free(sr);
> +		sr = NULL;
> +	}
> +	sr_len = 0;
> +	sr_cap = 0;
> +}
> +
> +static void find_member_recursive(struct btf *btf, int struct_typeid,
> +				  int base_offset, struct ktype_info *ki)
> +{
> +	const struct btf_type *st;
> +	struct btf_member *bm;
> +	int i, vlen;
> +
> +	struct_typeid = btf__resolve_type(btf, struct_typeid);
> +	st = btf__type_by_id(btf, struct_typeid);
> +
> +	if (!st)
> +		return;
> +
> +	if (BTF_INFO_KIND(st->info) != BTF_KIND_STRUCT &&
> +	    BTF_INFO_KIND(st->info) != BTF_KIND_UNION)
> +		return;
> +
> +	vlen = BTF_INFO_VLEN(st->info);
> +	bm = btf_members(st);
> +
> +	for (i = 0; i < vlen; i++, bm++) {
> +		const char *name = btf__name_by_offset(btf, bm->name_off);
> +		int member_bit_offset = btf_member_bit_offset(st, i) + base_offset;
> +		int member_typeid = btf__resolve_type(btf, bm->type);
> +		const struct btf_type *mt = btf__type_by_id(btf, member_typeid);
> +
> +		if (name && strcmp(name, ki->member_name) == 0) {
> +			ki->member_bit_offset = member_bit_offset;
> +			ki->member_bit_sz = btf_member_bitfield_size(st, i);
> +			ki->member_size = btf__resolve_size(btf, member_typeid);
> +			ki->index = i;
> +			return;
> +		}
> +
> +		if (!name || !name[0]) {
> +			if (BTF_INFO_KIND(mt->info) == BTF_KIND_STRUCT ||
> +			    BTF_INFO_KIND(mt->info) == BTF_KIND_UNION) {
> +				find_member_recursive(btf, member_typeid,
> +						      member_bit_offset, ki);
> +			}
> +		}
> +	}
> +}
> +
> +static void get_ktype_info(struct ktype_info *ki, char *mod_to_resolve)
> +{
> +	int i, j, start_id;
> +
> +	if (mod_to_resolve != NULL) {
> +		if (strcmp(ki->modname, mod_to_resolve) != 0)
> +			/* Exit safely */
> +			return;
> +	}
> +
> +	for (i = 0; i < btf_arr_len; i++) {
> +		if (strcmp(btf_arr[i]->module, ki->modname) != 0)
> +			continue;
> +		/*
> +		 * vmlinux(btf_arr[0])'s typeid is 1~vmlinux_type_cnt,
> +		 * modules(btf_arr[1...])'s typeid is vmlinux_type_cnt~btf__type_cnt
> +		 */
> +		start_id = (i == 0 ? 1 : btf__type_cnt(btf_arr[0]->btf));
> +
> +		for (j = start_id; j < btf__type_cnt(btf_arr[i]->btf); j++) {
> +			const struct btf_type *bt =
> +				btf__type_by_id(btf_arr[i]->btf, j);
> +			const char *name =
> +				btf__name_by_offset(btf_arr[i]->btf, bt->name_off);
> +
> +			if (name && strcmp(ki->struct_name, name) == 0) {
> +				if (ki->member_name != NULL) {
> +					/* Retrieve member info */
> +					find_member_recursive(btf_arr[i]->btf, j, 0, ki);
> +				} else {
> +					ki->index = j;
> +				}
> +				ki->struct_size = btf__resolve_size(btf_arr[i]->btf, j);
> +				return;
> +			}
> +		}
> +	}
> +}
> +
> +static bool add_to_btf_arr(struct btf *btf, char *module_name)
> +{
> +	struct btf_arr_elem *new_p;
> +
> +	new_p = malloc(sizeof(struct btf_arr_elem));
> +	if (!new_p)
> +		goto no_mem;
> +
> +	new_p->btf = btf;
> +	new_p->module = module_name;
> +
> +	return add_to_arr((void ***)&btf_arr, &btf_arr_len, &btf_arr_cap, new_p);
> +
> +no_mem:
> +	fprintf(stderr, "%s: Not enough memory!\n", __func__);
> +	return false;
> +}
> +
> +INIT_KERN_SYM(__start_BTF);
> +INIT_KERN_SYM(__stop_BTF);
> +
> +/*
> + * Makedumpfile's .init_ktypes section
> +*/
> +extern struct ktype_info *__start_init_ktypes[];
> +extern struct ktype_info *__stop_init_ktypes[];
> +
> +bool init_kernel_btf(void)
> +{
> +	uint64_t size;
> +	struct btf *btf;
> +	int i;
> +	struct ktype_info **p;
> +	char *buf = NULL;
> +	bool ret = false;
> +
> +	uint64_t start_btf = GET_KERN_SYM(__start_BTF);
> +	uint64_t stop_btf = GET_KERN_SYM(__stop_BTF);
> +	if (!KERN_SYM_EXIST(__start_BTF) ||
> +	    !KERN_SYM_EXIST(__stop_BTF)) {
> +		fprintf(stderr, "%s: symbol __start/stop_BTF not found!\n", __func__);
> +		goto out;
> +	}
> +
> +	if (!register_ktype_section((char *)__start_init_ktypes,
> +				    (char *)__stop_init_ktypes))
> +		return ret;
> +
> +	size = stop_btf - start_btf;
> +	buf = (char *)malloc(size);
> +	if (!buf) {
> +		fprintf(stderr, "%s: Not enough memory!\n", __func__);
> +		goto out;
> +	}
> +	readmem(VADDR, start_btf, buf, size);
> +	btf = btf__new(buf, size);
> +
> +	if (libbpf_get_error(btf) != 0 ||
> +	    add_to_btf_arr(btf, strdup("vmlinux")) == false) {	
> +		fprintf(stderr, "%s: init vmlinux btf fail\n", __func__);
> +		goto out;
> +	}
> +
> +	for (i = 0; i < sr_len; i++) {
> +		for (p = (struct ktype_info **)(sr[i]->start);
> +		     p < (struct ktype_info **)(sr[i]->stop);
> +		     p++) {
> +			get_ktype_info(*p, "vmlinux");
> +		}
> +	}
> +
> +	ret = true;
> +out:
> +	if (buf)
> +		free(buf);
> +	return ret;
> +}
> \ No newline at end of file
> diff --git a/btf_info.h b/btf_info.h
> new file mode 100644
> index 0000000..2cf6b07
> --- /dev/null
> +++ b/btf_info.h
> @@ -0,0 +1,90 @@
> +#ifndef _BTF_INFO_H
> +#define _BTF_INFO_H
> +#include <stdint.h>
> +#include <stdbool.h>
> +
> +struct ktype_info {
> +	/********in******/
> +	char *modname;		// Set to search within the module, in case
> +				// name conflict of different modules
> +	char *struct_name;	// Search by struct name
> +	char *member_name;	// Search by member name
> +	bool struct_required : 1;
> +	bool member_required : 1;
> +	/********out*****/
> +	uint32_t member_bit_offset;	// member offset in bits
> +	uint32_t member_bit_sz;	// member width in bits
> +	uint32_t member_size;	// member size in bytes
> +	uint32_t struct_size;	// struct size in bytes
> +	int index;		// -1 if type not found
> +};
> +
> +bool check_ktypes_require_modname(char *modname, int *total);
> +bool register_ktype_section(char *start, char *stop);
> +bool init_kernel_btf(void);
> +
> +#define QUATE(x) #x
> +#define INIT_MOD_STRUCT_MEMBER_RQD(MOD, S, M, R)			\
> +	struct ktype_info _##MOD##_##S##_##M = {			\
> +		QUATE(MOD), QUATE(S), QUATE(M), R, R, 0, 0, 0, 0, -1	\
> +	};								\
> +	__attribute__((section(".init_ktypes"), used))			\
> +	struct ktype_info * _ptr_##MOD##_##S##_##M = &_##MOD##_##S##_##M
> +
> +/*
> + * Required types will be checked automatically before extension running.
> + * Optinal types should be checked manually at extension runtime.
> + */
> +#define INIT_MOD_STRUCT_MEMBER(MOD, S, M) \
> +	INIT_MOD_STRUCT_MEMBER_RQD(MOD, S, M, 1)
> +#define INIT_OPT_MOD_STRUCT_MEMBER(MOD, S, M) \
> +	INIT_MOD_STRUCT_MEMBER_RQD(MOD, S, M, 0)
> +
> +#define DECLARE_MOD_STRUCT_MEMBER(MOD, S, M) \
> +	extern struct ktype_info _##MOD##_##S##_##M
> +
> +#define GET_MOD_STRUCT_MEMBER_MOFF(MOD, S, M)  (_##MOD##_##S##_##M.member_bit_offset)
> +#define GET_MOD_STRUCT_MEMBER_MSIZE(MOD, S, M) (_##MOD##_##S##_##M.member_size)
> +#define GET_MOD_STRUCT_MEMBER_SSIZE(MOD, S, M) (_##MOD##_##S##_##M.struct_size)
> +#define MOD_STRUCT_MEMBER_EXIST(MOD, S, M) (_##MOD##_##S##_##M.index >= 0)
> +#define TYPE_EXIST(p) ((p)->index >= 0)
> +
> +#define INIT_KERN_STRUCT_MEMBER(S, M) \
> +	INIT_MOD_STRUCT_MEMBER(vmlinux, S, M)
> +#define INIT_OPT_KERN_STRUCT_MEMBER(S, M) \
> +	INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, S, M)
> +
> +#define DECLARE_KERN_STRUCT_MEMBER(S, M) \
> +	DECLARE_MOD_STRUCT_MEMBER(vmlinux, S, M)
> +
> +#define GET_KERN_STRUCT_MEMBER_MOFF(S, M)  GET_MOD_STRUCT_MEMBER_MOFF(vmlinux, S, M)
> +#define GET_KERN_STRUCT_MEMBER_MSIZE(S, M) GET_MOD_STRUCT_MEMBER_MSIZE(vmlinux, S, M)
> +#define GET_KERN_STRUCT_MEMBER_SSIZE(S, M) GET_MOD_STRUCT_MEMBER_SSIZE(vmlinux, S, M)
> +#define KERN_STRUCT_MEMBER_EXIST(S, M) MOD_STRUCT_MEMBER_EXIST(vmlinux, S, M)
> +
> +#define INIT_MOD_STRUCT_RQD(MOD, S, R)				\
> +	struct ktype_info _##MOD##_##S = {			\
> +		QUATE(MOD), QUATE(S), 0, R, 0, 0, 0, 0, 0, -1	\
> +	};							\
> +	__attribute__((section(".init_ktypes"), used))		\
> +	struct ktype_info * _ptr_##MOD##_##S = &_##MOD##_##S
> +
> +#define INIT_MOD_STRUCT(MOD, S) INIT_MOD_STRUCT_RQD(MOD, S, 1)
> +#define INIT_OPT_MOD_STRUCT(MOD, S) INIT_MOD_STRUCT_RQD(MOD, S, 0)
> +
> +#define DECLARE_MOD_STRUCT(MOD, S) \
> +	extern struct ktype_info _##MOD##_##S;
> +
> +#define GET_MOD_STRUCT_SSIZE(MOD, S) (_##MOD##_##S.struct_size)
> +#define MOD_STRUCT_EXIST(MOD, S) (_##MOD##_##S.index >= 0)
> +
> +#define INIT_KERN_STRUCT(S) INIT_MOD_STRUCT(vmlinux, S)
> +#define INIT_OPT_KERN_STRUCT(S) INIT_OPT_MOD_STRUCT(vmlinux, S)
> +
> +#define DECLARE_KERN_STRUCT(S) \
> +	DECLARE_MOD_STRUCT(vmlinux, S)
> +
> +#define GET_KERN_STRUCT_SSIZE(S) GET_MOD_STRUCT_SSIZE(vmlinux, S)
> +#define KERN_STRUCT_EXIST(S) MOD_STRUCT_EXIST(vmlinux, S)
> +
> +#endif /* _BTF_INFO_H */
> \ No newline at end of file
> -- 
> 2.47.0


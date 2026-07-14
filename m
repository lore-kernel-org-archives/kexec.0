Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA89CC44501
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 00:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=baohKdwviOW9rpnJEKVXszxIr7m/MNWCGiXrRiO5dxI=; b=xGUgZK15ZYRdVTGwOS+zMLCznF
	nAO1cqyWM3/xOZUfMoS5hHIYNAFazYf8gsaQrKrTfSbHkMRYOloG/IflTxNlyxzdYYXWN8QdKJBNc
	D7cB9NpNEhTTu/1vySGHTR9nfWcY4mebzBd0fsxUgzmHOIncQgjXTnhdBZA1ncFd6HtVgPwUgLE2S
	YeUiMYMg1ZKqJ+8T1h0o1z+BBQafFaJoh9EqhYT58Lj2XWQ5oV8SJ4emzWik3Jh96S5fhul8W3L2X
	5TzVlrO+FEMTxS+jhnH0C0U6XeRWAiMsXiIpDchjJZOs7JFpYpUMGj2nPlXmJ7CTKMMFyKqepFodr
	CHMRH2hA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjRHn-0000000AcM5-3aUm;
	Tue, 14 Jul 2026 00:46:11 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjRHl-0000000AcJr-2Fzx
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 00:46:10 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DL3trH1377470;
	Tue, 14 Jul 2026 00:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=baohKdwviOW9rpnJEKVXszxIr7m/MNWCGiXrRiO5dxI=; b=
	bQCffq25pzktkM1dkeRT9SDVmPqYZHmOjKwTDPtEynZhZyIszj8rmxlf9ULi3rpp
	w6JAEuYpaFjyppt0SgatoMt1CpjqbVZRka5x2cDRoDktxgbQLC6q1mPO+rhLcajw
	98ymC+G4BewsBW2q1mlTjwve9o+0oOzTH8YJAGK9/bdkt0Xj+3TkzPWyCmHa2Xbp
	11f9uM3ENIi/ME5gthN0RHwKZfyWzcdmrCNSIqsQSEn6JsU62t8wXSoGjqeuovMr
	PDT+rtLQZFACmOAegMi+d2f0m8W9JtLLz3ERKtNMRTJ/5qH7DhtajCW1xsV/wekH
	x1hWjLskKvqv8XW3XukCiQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbed2ba7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 00:46:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66E0hZZD001414;
	Tue, 14 Jul 2026 00:46:07 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010029.outbound.protection.outlook.com [52.101.56.29])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9qv03w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Jul 2026 00:46:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/4+iVavQ3rM9Oe4KQp0Y7k7kEy9y39Jp5FPZD/nW/YvYqGnymbUMFe2qzFHQhYtgvdnPVut9JmNvJ4LEOOOm0W1A7iaoWFOmcCfPmxODbZpGwRHBfKS3WtjFoSk7WI6ZmS8zWGWPXkBuf7MsxLkJ8mY+0bXfgdXRqmJVI4Vk6TaWdYrH/gqMsbJwAZ4kPSWV3zK9gXtdf1e42aLyM5oyaEto/+weSz773y+E5NFA0w2IPU2rf/GdNmcT/uSuZD27Qj6h/uANOKV69S9nEZuYGPX2wQybR5zaONbC07mKoYZhOJgyGN1/t00cFPw55Ol1asFkobi8birFGtnRsQClw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=baohKdwviOW9rpnJEKVXszxIr7m/MNWCGiXrRiO5dxI=;
 b=VL901932udNrr/2Vv1z2BiQNCO/ZgCtU7I+adxZDFy9LS+zGOLluWCWPC9AMrPuN+fnU2PMFEWyMdZZPSrLZuSJ87h6ejWgD/VeB1CfX629lciIQIon3U66faQw9CwmW0Uf55IG1hjCHC91JQPSe9YuQgTMfpE81ybEO+sF3O4kb/FqsWXcdtBLNrtDRgRLgd+aemBx2qajXFGNkvH4tbMt1WAf3W/Dtf8IWNzYKLmKu83i+fJJKuXxTPrytK0fbzqn93Ak2Us4W31T3BNTHIGXbaCkQAD5swu+2XyNoQn1uwbFapXef3Xc9RbWF3znZBB+8BJq8twyKDHNGopExxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baohKdwviOW9rpnJEKVXszxIr7m/MNWCGiXrRiO5dxI=;
 b=aNutwQEnIrGK87745Q9BzL1qPfbCxfxM/30a97Q2p6KCjA416LEh5vBlzdLqjIDUIfSLZueKnnbg16F+HmUmtVGlLba4gHWxRLe6eV4Ls8JrL5+v1TGg+Mlba6fPBP9v9lJ7hqxwonrAzKo5eGk1YkTDehcCLMywi2YGz0VL6Wk=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by PH3PPF3CEC6235B.namprd10.prod.outlook.com (2603:10b6:518:1::796) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 00:46:04 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.21.0181.019; Tue, 14 Jul 2026
 00:46:04 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org
Cc: ltao@redhat.com, Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH makedumpfile 6/9] Simplify arguments for page checks
Date: Mon, 13 Jul 2026 17:45:39 -0700
Message-ID: <20260714004550.3698175-7-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
References: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0096.namprd07.prod.outlook.com
 (2603:10b6:510:4::11) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|PH3PPF3CEC6235B:EE_
X-MS-Office365-Filtering-Correlation-Id: 1109e71d-ead4-4d41-c10c-08dee1414870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: W8lcTW/RZueM/VAcARzQYq/JRtqy51iIFIWAqR0uL0N7VSTw35L1Yz0UNywVLfdsDEEXklbY1pDOAZv2FvtvBu2IcT7A/4HSRF5ezZUsC5Qsj5Bfz0RzWCvHHQXqe0Q1VxWd9cRWb/CR/ikN8P/UxIRlzSoeGLT2c/SwsOWKf6/u7ycQX4cEZr34KI6L9St6Yky49YcDV/oOqX+uW+wb1T82a73WTs+Qv1afcd/oB901e9VaRoraaLRjas4HehCTjHAPlqryyuWhFb9Nd4lrJOS5oda9Ojel3+AUjoXemRckW+u3qTQ0M5fJyjNf3GtGVdrSY8CsR+W+WGGUHsgdJ7yiNEJUl23lS4esd3e3aRMuRzZtLvRXhA9IbGy+o0bg37yp/13nu/hj0go4rgI/wLWL0QtdNOSpOFRvqZ0ZDME6KE24NCpVq8f3EQSln9Hmif8cjRUIJ+8xgPyU8YxlzRHP1/FfKng9gA7CBCjEEJDQuC0NuxXnoVDLmFwBCdAPjIb9Pel0gOFuzEN/A7oJex2Y4qAoY+3Pvk9lsFMEPpAnLCKvB+srmZqc6p08dwNl1MlCgWiE/pPx5jUu8kBnk7FTSNzBWpjO43ToUg7l8XcbLXtm1hhRcxQUcU9PEkgsnb0R+Y4tHsPDdn677hkXu1rdOphTWM5Mt0VKJhsSBIo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4GNjd1Xacrz8MdkelJTcpyIdcjJlZuL1eFHkWSrbNhr/ZR9VJAfgHJde8Ae1?=
 =?us-ascii?Q?+UzIHO/HD3XccTh8fA0Hcfn5QcaTNIhOwEz+891d0xXl/4WJq/rXuXgdXqBB?=
 =?us-ascii?Q?aS3sN+f/jc+Q/DCMJs4fwzeS+I4qtLNyzK31c9jCC8R5sGGGnIFOU7w0mGWI?=
 =?us-ascii?Q?tkmEnTWtunt3Q9h3U/9xhUeeejF5TvHwGN2v3NdXe2oHYdR2lasyqW3ylG6X?=
 =?us-ascii?Q?CwZJ4/ZxJNg4zBk5sHDwVsgIImNa0/gznhYyMrxPItQWs1GLr2V4Kk7ZRQJP?=
 =?us-ascii?Q?E2eQFzXp+U+C666JgS4q5YYPAAiHRts663r9ulLFPHLnJpU4sRAiiFxTHQ1k?=
 =?us-ascii?Q?LSYIbPh/xfeUPtFIXX1QzN8c9ICmM3VkS52y6vu+7sILwyH8tudS5BBilvMH?=
 =?us-ascii?Q?Aq5DD6Qq7vlVIzi9GVrUqu28sjoB3d5g4lGsbEir1+qEprH3dNmRBoISqYHT?=
 =?us-ascii?Q?VCSPt8EB6tVxcZfh5yoFZBHU3siAsUAChkUM15WHRF0jzNgHy2FMV2aQ3epi?=
 =?us-ascii?Q?kp4T+2v9tnMx6nZQcJIQjymmnDUArcfDZJhixFyBAecWhilGGcocj6PBMYvx?=
 =?us-ascii?Q?jh+3SoIYbc+42nDq+9LH3DrX+Fa2/YhNNzkz8/iKk5ANl01KpI59jFYJwFdy?=
 =?us-ascii?Q?GWPAXJdVtb8rnYu6Rd6RJW7PgQ54nnS+MVvcianpAYSCShwvqKXH/AWxyyU3?=
 =?us-ascii?Q?c5pe/pHIo6c3cOdWXWFFkVf6SSyXCQM5YrdisVjkXnScapNzjZM6XyLQCVBD?=
 =?us-ascii?Q?GdyYKcjBvkq8dxGzklVk0vePRHdDHZ7mdVIuJsmd94k7rXvSCVdtI88cakkD?=
 =?us-ascii?Q?TWm3nJJzfq5+49umzw3+LWS2UNQm5iuz7Yavds0nqhK68YhVx5qgL8AB1kAT?=
 =?us-ascii?Q?sLbDZi9fTVgARxcR+++Iz3CCEIZsYwONgJZj9GWqzeMdkWXiVN9ZmI+3zVty?=
 =?us-ascii?Q?Sk6OSrWUjAdpY09Nho1z7MZVzyuSVv774Kthqw3nfIcu9MV2kpiffqNWEQfb?=
 =?us-ascii?Q?bhC/BLVKXSqlBf+kkKFCZgJerKvF+Gq5UN6ZufcITLxfnxK8PMv+/lEOJBSu?=
 =?us-ascii?Q?ISF6lA61B+x6Jl3wFL7fQf2g2RGxtTYlchX4Mn80cxZ2KMXzzjcXkuILS1cl?=
 =?us-ascii?Q?JLWoU+Hi7wXIxoNex0ai/gD+t8+FRGmEofldlYdHiYrqSWp7OnPAD6lbkY1A?=
 =?us-ascii?Q?egA7iKbEqBphNdUvDTc2AP4e5YyZQCL8e8EHJx3gTs1DE8IjTVRq/EPoF4Ox?=
 =?us-ascii?Q?ogjV/6TtX6OKBEWI2LvQ0pzzVmw+1lF4cL84rUq/GgGsrRUnsFcrA5bVpj7K?=
 =?us-ascii?Q?dE0L5ujoC3KLIHx2OwwvbcvT1Kmr8ynxxdpl4tjJdmxswdEocVQ2EnyC4EAa?=
 =?us-ascii?Q?sFOlaaRMWQ27lsjCyn1p2P1uwVgHH8xIXEkz70XOf76zqS9ouiXgpPXIEzAf?=
 =?us-ascii?Q?fGCkRVraV4Ph0rRL8293yR+lveLK4DAd9wCvO3z0XYkBF9uqJnb6FsihLE2u?=
 =?us-ascii?Q?GLVtuY1dj1CJ9lnWOtOhkuIhyicRPMCno5F41e9NQ6T+7k9rydKwK7Efa9CB?=
 =?us-ascii?Q?waB/kcH124B5a9QnV8sjYdel1jXu19uttdpr9vYT7hScLp7DW8XBwMTlSSyy?=
 =?us-ascii?Q?345h6zM/w7CerO1g/7793hIQ67pPBg7EY1ICUE7cAH1UJfU4CNRD8uPH1tgh?=
 =?us-ascii?Q?vSrss4EfJ5iuyr1EVNsBqhJRN5/oQ2SWHDl7xnfOcsH41oFkgaAqqnIAyQ2d?=
 =?us-ascii?Q?GKXJPTv1aPX+vL1Kk5FKWwMD0/mI1bU=3D?=
X-Exchange-RoutingPolicyChecked: O1PXgiPHp2GEQ1b+pppZE/tLXLDiT7xjaD5cRQj603rnoBgjH0M/3wyw92lkY3tc11SaujKv8Svt4rZQkY1kHGazDX5e+eBL5LH4Dy7G1C9fDjPduLvVy1BTABW46CkmBzqQX4VGJBPTgikpye+nD/RkJ7+whSCp9zmY5qUAj5j/NUIr6pta5Dl9PAuIgV88De4tDlQ/b+5HugJnrcDJyWbMscqfKgdqEPIlzsEpkNsL1ixnCrn4/nGPaWT0rvQX1VjEbLfaJc9w1SB8ebhEMLpcfGw972h3J0s8r0UeRuu84X4wPi9+oYdv7BovQ2vfpe5TNVQuRofsqEwtx7/jHQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SZHj0Ko038I2jxSWhDKrFGhQvmj4FccffHYXPY0gSI12rWn6VffcjNrm840aVtiBNwf9BmQyClHdW/8iKTwsJFdCa7JgSe9xCUrZsDu1ZVijZZxLx5GQov9Sy4mdfGuyP9R4IELaU1+m7ymeOesW4/H8tH8OCnpnsNR0E12OUgARR9tdRbwCqZGdNfEJLDXHfTlolyTp93bl1U7wQT4csn+bR2P1KNXRQ4r7efkhRmovzjXaXBbMJ6nh3SMVGrLEuht28Vo40SZDVDCB9wYJ9NqwTC3LgrHykBotxYJptolsHveMvFD8KVXTm9+88dL3YYEixRMKZbJsMq5MeemXW1slA46tBILN/pxkv2Y8Swa9KV3Ja+M0ElEXStPZl7HwCE9lUaJqBOmSjWtrdY0y+lYx5bdc7nWAk2/iL95s0k8pL780Zng6058D27xLpjSA6SCQhkJr05oYdszJknm6AV+DUIfFmtUwR10gec57hWWC1PbDEH4fwx1z7uZlnkaawMFOPajYNUgKJeIhrqwhJqU9N/W0KRNa4Tr99/sOwooJnx9nH0x8iGhOEqcY5Wq95FH+aWZ/kESbHO3JQ87qRnMK0PGr/Xa31Nc3kaAEKY8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1109e71d-ead4-4d41-c10c-08dee1414870
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 00:46:03.9985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4C/Vp+ANOuKSPvy6hvxRN+qzHy29SbQ733wFxLxYrzc1n/oqayTv/Ovb07T7ymw5DiOkUsceD1AryOIFm5KQoxVoTyI77KpzU/mYsmWwmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF3CEC6235B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607140005
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAwNCBTYWx0ZWRfXxnNsUHnDcqtl
 DVJ5EmgkO75fb0bxWKas14RGR8DM/fgb4AZPHQ9Ztdn5OP6Uf+GbvEJQoD61fZeAzSw3vXEUEjY
 hKtG/P1eqG/g4U8AZG5oJWgWKMOKo02avs2vODDKyWjc4Y5Lt5T439g3a8p/DlybIcI/vPUfVW7
 0iYsfklPRuH0HRP2mmhMkiJvs7krqUjkPiwbiwGE/B2HlFrd6e+8gJ3KFen+pmueUQAzMmp2o0L
 sl023qyBfzTICp6R9ORZyWWeaEmqNGTGUrwYSci8idFBQkslxbaMegiQ5HUWaH6m2LLowpAC5CE
 qonCMslUtnxH1WikpeOwxdZEAtwIdsgJd8UgnWnMtcMqTAVDaFgf4SCJVS76yKk4joObGDnKio+
 cmJbe/e1kpD4mYdSmrlZGq54rmZ3g8/PCh9gtD+qv7S8mLu4rEs8FAb1pp6BeD2NOVXA5wqq12n
 TQAweXvmuWv4zzppAGCU9KYlqA0ScOIy9RWITV04=
X-Authority-Analysis: v=2.4 cv=GcknWwXL c=1 sm=1 tr=0 ts=6a5586d0 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=L3RHz6znq6SOOwo5v0YA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12222
X-Proofpoint-GUID: 6Qk-OkcvEV0ThPjqGXuwGyfp5ne0mMS-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAwNCBTYWx0ZWRfX6OP01cuYvm/D
 5CTs4pqcEhX16W5RhZdATtfOdhmtpt3n0Uy0ESTaSmPG817JJrFxjzGvMFTcSYHExLGkkkspIlW
 I9FmIkarl0PBNGohhy1wOepoTCl9oLu9QKIv4Ch4QSDy5eCxCCNK
X-Proofpoint-ORIG-GUID: 6Qk-OkcvEV0ThPjqGXuwGyfp5ne0mMS-
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_174609_590950_B9A3ED75 
X-CRM114-Status: GOOD (  17.65  )
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

Many isSomething() helpers need to use several fields in order to make a
determination (e.g. flags, _mapcount, private, _count). All of the info
we extract about a page's identity is now grouped together into struct
pginfo, so we can instead pass a pointer to that struct directly. This
makes it easier to read and write the code, and it also sets an easy
calling convention that extensions can use.

For helpers that require a single field, e.g. flags, still pass it
directly. The benefits of replacing that value with a structure pointer
aren't so obvious to me.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 makedumpfile.c | 22 ++++++++++------------
 makedumpfile.h | 21 +++++++++------------
 2 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 3da68fa..f277360 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -6008,10 +6008,9 @@ exclude_free_page(struct cycle *cycle)
  * For the kernel versions from v2.6.17 to v2.6.37.
  */
 static int
-page_is_buddy_v2(unsigned long flags, unsigned int _mapcount,
-			unsigned long private, unsigned int _count)
+page_is_buddy_v2(const struct pginfo *i)
 {
-	if (flags & (1UL << NUMBER(PG_buddy)))
+	if (i->flags & (1UL << NUMBER(PG_buddy)))
 		return TRUE;
 
 	return FALSE;
@@ -6021,13 +6020,12 @@ page_is_buddy_v2(unsigned long flags, unsigned int _mapcount,
  * For v2.6.38 and later kernel versions.
  */
 static int
-page_is_buddy_v3(unsigned long flags, unsigned int _mapcount,
-			unsigned long private, unsigned int _count)
+page_is_buddy_v3(const struct pginfo *i)
 {
-	if (isSlab(flags, _mapcount))
+	if (isSlab(i))
 		return FALSE;
 
-	if (_mapcount == (int)NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE))
+	if (i->_mapcount == (int)NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE))
 		return TRUE;
 
 	return FALSE;
@@ -6589,7 +6587,7 @@ check_order:
 		 */
 		if ((info->dump_level & DL_EXCLUDE_FREE)
 		    && info->page_is_buddy
-		    && info->page_is_buddy(i.flags, i._mapcount, i.private, i._count)) {
+		    && info->page_is_buddy(&i)) {
 			if ((ARRAY_LENGTH(zone.free_area) != NOT_FOUND_STRUCTURE) &&
 			    (i.private >= ARRAY_LENGTH(zone.free_area))) {
 				MSG("WARNING: Invalid free page order: pfn=%llx, order=%lu, max order=%lu\n",
@@ -6615,7 +6613,7 @@ check_order:
 		 */
 		else if ((info->dump_level & DL_EXCLUDE_CACHE)
 		    && is_cache_page(i.flags)
-		    && !isPrivate(i.flags) && !isAnon(i.mapping, i.flags, i._mapcount)) {
+		    && !isPrivate(i.flags) && !isAnon(&i)) {
 			pfn_counter = &pfn_cache;
 		}
 		/*
@@ -6623,7 +6621,7 @@ check_order:
 		 */
 		else if ((info->dump_level & DL_EXCLUDE_CACHE_PRI)
 		    && is_cache_page(i.flags)
-		    && !isAnon(i.mapping, i.flags, i._mapcount)) {
+		    && !isAnon(&i)) {
 			if (isPrivate(i.flags))
 				pfn_counter = &pfn_cache_private;
 			else
@@ -6635,7 +6633,7 @@ check_order:
 		 *  - hugetlbfs pages
 		 */
 		else if ((info->dump_level & DL_EXCLUDE_USER_DATA)
-			 && (isAnon(i.mapping, i.flags, i._mapcount) || isHugetlb(i.compound_dtor))) {
+			 && (isAnon(&i) || isHugetlb(i.compound_dtor))) {
 			pfn_counter = &pfn_user;
 		}
 		/*
@@ -6647,7 +6645,7 @@ check_order:
 		/*
 		 * Exclude pages that are logically offline.
 		 */
-		else if (isOffline(i.flags, i._mapcount)) {
+		else if (isOffline(&i)) {
 			pfn_counter = &pfn_offline;
 		}
 		/*
diff --git a/makedumpfile.h b/makedumpfile.h
index 3d64677..cf9d22b 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -161,8 +161,8 @@ test_bit(int nr, unsigned long addr)
 #define isSwapBacked(flags)	test_bit(NUMBER(PG_swapbacked), flags)
 #define isHWPOISON(flags)	(test_bit(NUMBER(PG_hwpoison), flags) \
 				&& (NUMBER(PG_hwpoison) != NOT_FOUND_NUMBER))
-#define isAnon(mapping, flags, _mapcount) \
-	(((unsigned long)mapping & PAGE_MAPPING_ANON) != 0 && !isSlab(flags, _mapcount))
+#define isAnon(i) \
+	(((unsigned long)(i)->mapping & PAGE_MAPPING_ANON) != 0 && !isSlab(i))
 #define isUnaccepted(_mapcount)	(_mapcount == (int)NUMBER(PAGE_UNACCEPTED_MAPCOUNT_VALUE) \
 				&& (NUMBER(PAGE_UNACCEPTED_MAPCOUNT_VALUE) != NOT_FOUND_NUMBER))
 
@@ -1763,8 +1763,7 @@ struct DumpInfo {
 	/*
 	 * for filtering free pages managed by buddy system:
 	 */
-	int (*page_is_buddy)(unsigned long flags, unsigned int _mapcount,
-			     unsigned long private, unsigned int _count);
+	int (*page_is_buddy)(const struct pginfo *);
 	/*
 	 * for cyclic_splitting mode, setup splitblock_size
 	 */
@@ -2657,28 +2656,26 @@ isHugetlb(unsigned long dtor)
 		   && (SYMBOL(free_huge_page) == dtor));
 }
 
-static inline int
-isSlab(unsigned long flags, unsigned int _mapcount)
+static inline int isSlab(const struct pginfo *i)
 {
 	/* Linux 6.10 and later */
 	if (NUMBER(PAGE_SLAB_MAPCOUNT_VALUE) != NOT_FOUND_NUMBER) {
-		if (_mapcount == (int)NUMBER(PAGE_SLAB_MAPCOUNT_VALUE))
+		if (i->_mapcount == (int)NUMBER(PAGE_SLAB_MAPCOUNT_VALUE))
 			return TRUE;
 	}
 
-	return flags & (1UL << NUMBER(PG_slab));
+	return i->flags & (1UL << NUMBER(PG_slab));
 }
 
-static inline int
-isOffline(unsigned long flags, unsigned int _mapcount)
+static inline int isOffline(const struct pginfo *i)
 {
 	if (NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE) == NOT_FOUND_NUMBER)
 		return FALSE;
 
-	if (isSlab(flags, _mapcount))
+	if (isSlab(i))
 		return FALSE;
 
-	if (_mapcount == (int)NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE))
+	if (i->_mapcount == (int)NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE))
 		return TRUE;
 
 	return FALSE;
-- 
2.47.3



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A9DD6AB10
	for <kexec@archiver.kernel.org>; Thu,  2 Apr 2026 23:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pV2+mbDI2LZv+0+19VXCnb+2GbRSHvRWhI/J57I5v/g=; b=b43jL4FJ4jnd7QmDnpqIkYJGTn
	591SaQbX7Gp8AcTFU2o0TjZCw2J8j/J3BfTr5o1wOMlDj8Er8QJV5weYykwsNeuwswkPMII3KVhb4
	QCVSJzl7yMmnguEDOEnQVss88+D+HquLMcp0Cet0RRfhHkG+nVqkRibqPIZLXCfjlyMopI77CnON7
	/Zcq1fDCTWLIeWBKGi0hMlso09Dqnyv1OZV5iW2lia3h/oBkXHH27q89J2ENgcyBgRTM66ACihZCK
	ITifNskUBKFu3+yEfPcqIsm79Seu9hU21igtSsufLA8Sz/oE64dwVFslgJ1/Py0aM37g1NaKpPoHN
	vS5z9GBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8RWV-00000000wVO-28h3;
	Thu, 02 Apr 2026 23:32:27 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8RWS-00000000wV4-3oFX
	for kexec@lists.infradead.org;
	Thu, 02 Apr 2026 23:32:26 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632FBnX5001795;
	Thu, 2 Apr 2026 23:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=pV2+mbDI2LZv+0+19V
	XCnb+2GbRSHvRWhI/J57I5v/g=; b=QQy9RoQJHeuvsSz2rpgbgVdCLqJNR/Hi+3
	0e1D+HbrN4NeFMx46b0EgI/bnBtnahFPlS7q598PoGQsyIs8xFi5rEU2diLqzUoZ
	3GcZnWt2/0Z668AHRvSbuSEg23YQgtTZMdSx45UGX9Wfxqj3i8t/oN3UKhlRAqzz
	a7DhXB3W1TXHdRqjOEZtlrYGhxvBQpMhPwIBNZQqfWYPPdmPWdCy2zfwhenxfwDU
	ArHxV1u8jJTq8hjyS45jUA8m1djCZRjyHLNFaNzT6yFM9iUlcFCfbfqL6edIt1t8
	7AlwEwgiJGv7UmcLyZl7Fjf7lOPqycfIz0ns+AOM0g2uSS86wqbg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d671b1eb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Apr 2026 23:32:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 632LHocJ021180;
	Thu, 2 Apr 2026 23:32:21 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011019.outbound.protection.outlook.com [40.107.208.19])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d65edjmkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Apr 2026 23:32:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIP8JLr16iGI+ljFLnrfbs98bkTXva8ijGnSJnTKyzOgHTTMbi59sBgZ6DgHN0LLhRi1yJ6hHUDc1yWoi/UqM1MBOAjGh9Wvm7d3wWDYvQmEYWI/46hWCpznb2zYrb6Q2IqCpUFLSXynDcC0ZU0mIjEA203yQBxEOEljT3JSgfFJBC3d1Np9p8csvAZ1+XTmuh8kKMZQ7eL2e5reeUThaMFBF/fSpTGJvmMQKsBAG7Ps+vfI5d3kHq20NAhbMo3Y1U9vDxQD8z2+AOY1jS9NPbXI3ABRD1msz9Imatir2Lz3pADyLPgfk302pk1F4aHNL+6LRwBbkZ8xeM4clH1dOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pV2+mbDI2LZv+0+19VXCnb+2GbRSHvRWhI/J57I5v/g=;
 b=PaCfOgaWwCei1kWSHNSwi+mAgXd/5zLGM9j6MgHSSZ5mzP0aA0F//CUq85/ULw4ToqjyNb5WwJKsjssyo0EUAjg9ggRrXF66SGvjEdZaIRGCkNUHN6SeDOvFh7doyqA0WaE/QD+n0XtDEYkeOcVJG3ZyiTT9b5aKVSfpFUCP6gr7BEt1BJxx2REep4PO4vxaYAPN3w+vP8tmBgJmk84tAWy1pS6vwI3b6CMs48N6VTdBkZMD/wUXgeiNt8R1IwespBx7EhdmtHS43hX1zVBUJvQVZl+hvF7sa/0eR4IUmRpGdBQwGVSKDlN19bqkwrg3hpAogzP4h9aIlPOXd2WNSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pV2+mbDI2LZv+0+19VXCnb+2GbRSHvRWhI/J57I5v/g=;
 b=nEeDvRM+tC3w9Ln0KmBnPVEGu9KPj+EhpJzy/Z1YuQAGrHhxcZc7+LQ7RnrzSxUAiNNkWygb9rlfg2e8E+MlI6pU+A2cSAn/ScAwBPf1b8OhGJyUJC2pyw0VDyRKChEN/QygO1yhMF+Wg5HMPrXOaplWSMGbrSp174ZFveeOveQ=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by IA3PR10MB8043.namprd10.prod.outlook.com (2603:10b6:208:511::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 23:32:19 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 23:32:19 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Tao Liu <ltao@redhat.com>, yamazaki-msmt@nec.com, k-hagio-ab@nec.com,
        kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCH v4][makedumpfile 2/7] Implement kernel kallsyms resolving
In-Reply-To: <20260317150743.69590-3-ltao@redhat.com>
References: <20260317150743.69590-1-ltao@redhat.com>
 <20260317150743.69590-3-ltao@redhat.com>
Date: Thu, 02 Apr 2026 16:32:17 -0700
Message-ID: <87341dey66.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0260.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::25) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|IA3PR10MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: 912a2346-1b92-4c43-fa23-08de911014de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: LFjz1dOWuqcZmAQlI9YnGNjVKE5A7Xg/UjyndEqLKkjFhjQhfyaRs6HM+GXqPOzcHFD6u1vFK/lcZdk11E0YUHyAGRxBYQyLobCISErmI+zyj3rhmwzXIVXGF9WPaD/Ysroj1OI3j4XOrUfvjOq63XQo7lhwdi+o6wGx5UIW2UJEX9eV+21RkF7gT+w8JK9xbk3LJSvjDeTS9K087gGwHysTSffuFbNqz7vP2frt4G8a9tVhVPREchjm+asG1oDfkfgpQLSPGTUkUmFp4N+sYBkRBpKPcJ+BgN+lsP9mCtJK7MIeTB/ssA/AHJ++1tqXzPBVOtlC3X56ifSD2rIHklOgt2/mVbHCvy04k7DEUTMJWcm8uSsVm9/R/DGYHHuHo2gIG32Uq7G52nPwljAJkRFH9GJYM2zTkwkd0k6eTt/BshpNhC+mWDLS4xwfsA3SmQFQs8y+Sd6SMri3KBJ3p2lp2rk5fDv+mQYYzq6XJ/PK23pmKIhRhlKxUH/hsnW3ftzX+Q6SiOq+9A+7AT5vnsmjsEONMs8FCH5OPMZIpeHf3wOye5w6a8Q83M3rkEM8qi24de+qmkdS7xejU+D2KagdGEjmah8ZMozg7U6PAE7n+9GN8lz/lQrpGosLWrdP3R5Om3FRtNVcjyndNWHI4P4xwAXOzLHj+lsgXsgh3i/ZQtsbbAixVkX41/2TReAz6CZfo2B9yy3Rag9GR7+838eIT0Iox3ruMfl0TkUqtL4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gw3sEtmK8jO9vF20/2jAfEQl88NZI4COat2Z48JJDl0EvCl2vB1ILvTHOijZ?=
 =?us-ascii?Q?T7aiRWKVjpxyTGxRLBfiJvVUSczi2Mnr6MN2o0iJvMa8di9ni2N4x5CVYRQi?=
 =?us-ascii?Q?PyEVczVzUicLy/YnIAwXI0jeu/8QAwUWq6E7s/8cyFjyWCq8yWAL6P4LxyWk?=
 =?us-ascii?Q?PMR0zXyn2f2oFlj70mqE3lLfg6IKiseUPpACA8EmNgaj27dY8AD/vAqC18W/?=
 =?us-ascii?Q?FY0EST53OWKqPQK0eTsjNv6U95mP+OACa2npdOmIud+RWhQt1yrH5huXvFo5?=
 =?us-ascii?Q?ff858IVykvFLUIB7wKYk0x5qik50x0FzH2yBHz/enibc5mCbWvQM9FwTPFPN?=
 =?us-ascii?Q?YnHIAcFJnUjaeKLTtWH7FFj/cAbSQKyx9ZITwLe1m0bj6TRfNbctejOPiDDZ?=
 =?us-ascii?Q?c4dinTAWHbNhGiww7s+bMRilZF1Al8NOuMhWcNX8xlVJHNcm6sPYIKhafnll?=
 =?us-ascii?Q?zFBgEkqj8ZK0ddnQ8rFsAUC+kW8ovwQAMc7o8s68Spm5YYXWNuYLlE4GBwJ3?=
 =?us-ascii?Q?4XmT1m+nVc+ByWKnE/SlclMePfY7Ndl1fwOioNk6znH3y9KBD/ySxwIewuBY?=
 =?us-ascii?Q?Ovk4JkBpCyM0SBYhJvA7EvNUJ2nBisDQzoR9vqTN+xxPE3axVy4qtsmr9fYW?=
 =?us-ascii?Q?h2uberzFFcDgKLGw/ygQt5B96DOHmuvRV4HyJVKdl9GQGV/qImPfxnUP4CYt?=
 =?us-ascii?Q?7IGjk8qWl03YvPDGV+ciATYkdEMa9+kRgiMjxoSp39TmcK5Lt4I8/FNQ/pot?=
 =?us-ascii?Q?acYXKOhR0ODGMNKXdraVTiA9AQS4nv8F7iBgAiKh26V0S/Gp+guSXw9JGwKK?=
 =?us-ascii?Q?kGrfrrS8eEKzsGT3wLjtzpK3H2JwSHzMAkq1LvdkVB/ntXHra+JHMl0ZfbzX?=
 =?us-ascii?Q?8dY37ahVqxc48iw8yWm26FWrX5G3VRkqit+b6xeGIznC/S/OjZlw5O/WYz26?=
 =?us-ascii?Q?rwEumy5/fqIecvL5W93INP219c7f5XEixa7uTwGIMnOJJh8LKxxIQZwWDQDa?=
 =?us-ascii?Q?1SrnwFBvL3iVdADbPElud+fWC69VJtPVAZ70TSPaojdEOhImT9VqrUPEItCo?=
 =?us-ascii?Q?ZxaSrI4BChCKG6SLUeeSkWX4ydriZZOPM5WgxxJD2JhhOfX61SLHcCYoT97u?=
 =?us-ascii?Q?MBdS+mzQC4aZu0dc786bNAamNdnVO/7XHhoRC/IxDetf1JMesEoYNh0K/tID?=
 =?us-ascii?Q?Oq8ECkd9xr4XZaC+49dr2eL+0vYQFN0Mu7aJ1M5c+KFTsuNEZvyGsGZj5iET?=
 =?us-ascii?Q?pI79lEyIt/LIKpQ73+fPCj5z3v3Sn0uycdMjLXawW+dUrBTZumTpLwua0270?=
 =?us-ascii?Q?hStojrwVGSLxi69sjvB+puA+W+Gronp2Ut0IXoYsu6Dr48ZCTQSpaxLB8FiG?=
 =?us-ascii?Q?+M2ZAJjQolUwmnr7u+BJXQZpYN/xFanBNcXAw8juSzdWOkkEirUVSoZrmInd?=
 =?us-ascii?Q?cqeZEvGQhrv+IP1QZqvLkmBzhSf/K17CiozNa3tpkXEuDEUOJp2rAoAbCdoc?=
 =?us-ascii?Q?macckDd4E9l0A2Zq75MNJtfIJcO8Nl2O4OJ7nxImCdsSsL05xdsGhw89Nu8K?=
 =?us-ascii?Q?xE+lD3ZkzI9RfrRof7Zas8i5p7bzmBO9OCByvTe1UbjcDzgZuD5DMXNpZW46?=
 =?us-ascii?Q?bwoJwpPi20dQl6Kpza/VDNOCJ+aJtNmSSz+67/REglR8dJCJ+4Yls+gjphnN?=
 =?us-ascii?Q?Lte41cp+pnexa8C/Sj0+yCm3v3RunvjgrXc3NroiI9eFJsTOwwWDcGBY2Kcx?=
 =?us-ascii?Q?Mf4vUMixuNFb298JABhdPEwHk7a02Gs=3D?=
X-Exchange-RoutingPolicyChecked: szMT6Nj9e/z9SsZxlupk38Lulxn+yWJSHN9Z+8pdSKOKeSpjKYDVQm2Ux3n1hRYvPoVOmBDRVBWl8y9SP62lZrYeojQpTUI36d9fF4MweBgC9fMkpApAM8jsXVGCf0U0RZdiyaVUEp7mT6gmM5a7D6NY+rDoKrT4IJIq6daMPRyeb6tPtzTcHZiGTgWFyuZ0WDAof8aXj/UhPkSr3CQGZxZHi6teHmHxdJDSuEcVWuwEakqWwPujZJ1FCAt6gg7y8Z/kmrqOzkfdCAMSZNuN0pKY7XjPCDnb5Xj8k4azPMAkiSfmlK6JSNxAi+8Jrf9HMXj1twupgRotlBGMsvDIWg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: R1E9sgZiiiAQlKPHrq9/csucM06wmQX5nJ6E4L81HJeB8+BczGMz198P5qiXAsZSeiF8wSQGZnLWehIrk10PgR68s2aAGwZX5RHCceEW8qdi8q1sKIoe0ZVCOFBQe9GOWTT796O+ZBRCyGe547qwSGsSZHPfWMX+J5gpaqsg/bsncza520dWwy/98I7xfbpk6x2XgPif0gWyeSGyokiHqRyxqCA3PIH3khNc6ynng9FK4ioAi7WK/CIWgVITv/AWRaTfdEMivYrFtlZt8cqZwv7sJifI0DvVpZwTRjT0QVcvFHMxAGQq19IxmmfKoz1/RBh6SvivUuhQxObF9d1Y0z0Ay8kBCGGP4uGV3IFuiiVpo5uerffg89OI9MbaPiBsUaqN1t0NZsZzZqF674X1ongZ5dQjqMLE6gndUd2slQpLGMNc+BROcgdFSfpjCziJ7K5lCcVlIi/WVVAM3R31yxZDvnLxDZJ5RAuPFIP2DeAb7pqVkuICjkdpNqDSGLRbpAgsDoVaWWTd4esKCG2fJE9O2tZmETkBR2NiWaEjcW9pwsDiFgSVDoPFnq7S+a4vxMRc3CwMh3RvAm8zoEmELpyRUhrTID3BbC1T5vLlz/I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912a2346-1b92-4c43-fa23-08de911014de
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 23:32:19.0692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWXkWTpd620dLcTSCQ22TCu0OaUBtuOm0RTAmXgnjiEwqHEx9ZoctonMuUPTAL+opKKZNXHH1FY5yI9Bjcrsq6txV53uAo6MaEP12M2flS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8043
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2604020210
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDIxMCBTYWx0ZWRfXxFrCx4asr4De
 7VOLJH8qNw4Nrn2alp2xp6S3KUsvHfj+j8woyPjSYjhikVz4xdRW0m1nfTZdkJrkN/+mxDcui62
 LhPMk4QkUHaCrHADi2ODp4T78EA9x62V3Xsn8dga+KmROEvDt6BoKGOTwgomebXdznCKIDSboIH
 E5aDAIyI96sA+tpolloD4i6/ej0xdHx5VkY9eC5uVhE0XjnryQG+VNs1RbPYEuHWX2c8VwSFZ90
 lGcER35QFnSxRMAMD3xSvyma4SetPmIUEnVhTJ8EROCHI+M69ie8vwWoMiGjJlaX6WQDA9Ke9cq
 mv1zPHbGhLcrqbhPe48oIO8D85lPK9CG+4n9zsExLohdDkCEqaDsfGYWCSmqY8bGQw5qT4kz2F4
 hMHR2GGeDbVK9BapD/wPgd/K/co8dUxutInNUhci6v7wRNunCsILjyGxiK/+BLhQO2yd4Lhgkfw
 mkxKbMGLUqd+plEPClQ==
X-Authority-Analysis: v=2.4 cv=PJkCOPqC c=1 sm=1 tr=0 ts=69cefc86 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=NEAV23lmAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=JOL0GLFN_-5g6QvhxHgA:9
X-Proofpoint-GUID: 0M4RZwuojs0ufT2tBcZkv0x2dvNtrrrz
X-Proofpoint-ORIG-GUID: 0M4RZwuojs0ufT2tBcZkv0x2dvNtrrrz
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260402_163225_080008_4A0251F4 
X-CRM114-Status: GOOD (  23.33  )
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
> This patch will parse kernel's kallsyms data. During the parsing
> process, the .init_ksyms sections of makedumpfile and the
> extensions will be iterated, so the kallsyms symbols which belongs
> to vmlinux can be resolved at this moment.
>
> Suggested-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> Signed-off-by: Tao Liu <ltao@redhat.com>

Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>

> ---
>  Makefile       |   2 +-
>  kallsyms.c     | 350 +++++++++++++++++++++++++++++++++++++++++++++++++
>  kallsyms.h     |  91 +++++++++++++
>  makedumpfile.c |   3 +
>  makedumpfile.h |  11 ++
>  5 files changed, 456 insertions(+), 1 deletion(-)
>  create mode 100644 kallsyms.c
>  create mode 100644 kallsyms.h
>
> diff --git a/Makefile b/Makefile
> index 15a4ba0..a57185e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -45,7 +45,7 @@ CFLAGS_ARCH += -m32
>  endif
>  
>  SRC_BASE = makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.h sadump_info.h
> -SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c tools.c printk.c detect_cycle.c
> +SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c
>  OBJ_PART=$(patsubst %.c,%.o,$(SRC_PART))
>  SRC_ARCH = arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64.c arch/loongarch64.c arch/riscv64.c
>  OBJ_ARCH=$(patsubst %.c,%.o,$(SRC_ARCH))
> diff --git a/kallsyms.c b/kallsyms.c
> new file mode 100644
> index 0000000..f7737cb
> --- /dev/null
> +++ b/kallsyms.c
> @@ -0,0 +1,350 @@
> +#include <stdint.h>
> +#include <stdbool.h>
> +#include <string.h>
> +#include "makedumpfile.h"
> +#include "kallsyms.h"
> +
> +static uint32_t *kallsyms_offsets = NULL;
> +static uint16_t *kallsyms_token_index = NULL;
> +static uint8_t  *kallsyms_token_table = NULL;
> +static uint8_t  *kallsyms_names = NULL;
> +static unsigned long kallsyms_relative_base = 0;
> +static unsigned int kallsyms_num_syms = 0;
> +
> +/* makedumpfile & extensions' .init_ksyms section range array */
> +static struct section_range **sr = NULL;
> +static int sr_len = 0;
> +static int sr_cap = 0;
> +
> +/* Which mod's kallsyms should be inited? */
> +static char **mods = NULL;
> +static int mods_len = 0;
> +static int mods_cap = 0;
> +
> +INIT_KERN_SYM(_stext);
> +
> +/*
> + * Utility: add elem to arr, which can auto extend its capacity.
> + * (*arr) is a pointer array, holding pointers of elem
> +*/
> +bool add_to_arr(void ***arr, int *arr_len, int *arr_cap, void *elem)
> +{
> +	void *tmp;
> +	int new_cap = 0;
> +
> +	if (*arr == NULL) {
> +		*arr_len = 0;
> +		new_cap = 4;
> +	} else if (*arr_len >= *arr_cap) {
> +		new_cap = (*arr_cap) + ((*arr_cap) >> 1);
> +	}
> +
> +	if (new_cap) {
> +		tmp = reallocarray(*arr, new_cap, sizeof(void *));
> +		if (!tmp)
> +			goto no_mem;
> +		*arr = tmp;
> +		*arr_cap = new_cap;
> +	}
> +
> +	(*arr)[(*arr_len)++] = elem;
> +	return true;
> +
> +no_mem:
> +	fprintf(stderr, "%s: Not enough memory!\n", __func__);
> +	return false;
> +}
> +
> +/*
> + * Utility: add uniq string to arr, which can auto extend its capacity.
> +*/
> +bool push_uniq_str(void ***arr, int *arr_len, int *arr_cap, char *str)
> +{
> +	for (int i = 0; i < (*arr_len); i++) {
> +		if (!strcmp((*arr)[i], str))
> +			/* String already exists, skip it */
> +			return true;
> +	}
> +	return add_to_arr(arr, arr_len, arr_cap, str);
> +}
> +
> +static bool add_ksym_modname(char *modname)
> +{
> +	return push_uniq_str((void ***)&mods, &mods_len, &mods_cap, modname);
> +}
> +
> +bool check_ksyms_require_modname(char *modname, int *total)
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
> +static void cleanup_ksyms_modname(void)
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
> + * Used by makedumpfile and extensions, to register their .init_ksyms section.
> + * so kallsyms can know which module/sym should be inited.
> +*/
> +REGISTER_SECTION(ksym)
> +
> +static void cleanup_ksyms_section_range(void)
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
> +static uint64_t absolute_percpu(uint64_t base, int32_t val)
> +{
> +	if (val >= 0)
> +		return (uint64_t)val;
> +	else
> +		return base - 1 - val;
> +}
> +
> +static uint64_t calc_addr_absolute_percpu(struct ksym_info *p)
> +{
> +	return absolute_percpu(kallsyms_relative_base, p->value);
> +}
> +
> +static uint64_t calc_addr_relative_base(struct ksym_info *p)
> +{
> +	return p->value + kallsyms_relative_base;
> +}
> +
> +static uint64_t calc_addr_place_relative(struct ksym_info *p)
> +{
> +	return SYMBOL(kallsyms_offsets) + p->index * sizeof(uint32_t) +
> +		(int32_t)kallsyms_offsets[p->index];
> +}
> +
> +#define BUFLEN 1024
> +static bool parse_kernel_kallsyms(void)
> +{
> +	char buf[BUFLEN];
> +	int index = 0, i, j;
> +	uint8_t *compressd_data;
> +	uint8_t *uncompressd_data;
> +	uint8_t len, len_old;
> +	struct ksym_info **p;
> +	uint64_t (*calc_addr)(struct ksym_info *);
> +	struct ksym_info *stext_p;
> +
> +	for (i = 0; i < kallsyms_num_syms; i++) {
> +		memset(buf, 0, BUFLEN);
> +		len = kallsyms_names[index];
> +		if (len & 0x80) {
> +			index++;
> +			len_old = len;
> +			len = kallsyms_names[index];
> +			if (len & 0x80) {
> +				fprintf(stderr, "%s: BUG! Unexpected 3-byte length,"
> +					" should be detected in init_kernel_kallsyms()\n",
> +					__func__);
> +				goto out;
> +			}
> +			len = (len_old & 0x7F) | (len << 7);
> +		}
> +		index++;
> +
> +		compressd_data = &kallsyms_names[index];
> +		index += len;
> +		while (len--) {
> +			uncompressd_data = &kallsyms_token_table[kallsyms_token_index[*compressd_data]];
> +			if (strlen(buf) + strlen((char *)uncompressd_data) >= BUFLEN) {
> +				goto next_symbol;
> +			}
> +			strcat(buf, (char *)uncompressd_data);
> +			compressd_data++;
> +		}
> +
> +		/* Now check if the symbol is we wanted */
> +		for (j = 0; j < sr_len; j++) {
> +			for (p = (struct ksym_info **)(sr[j]->start);
> +			     p < (struct ksym_info **)(sr[j]->stop);
> +			     p++) {
> +				if (!strcmp((*p)->modname, "vmlinux") &&
> +				    !strcmp((*p)->symname, &buf[1])) {
> +					(*p)->value = kallsyms_offsets[i];
> +					(*p)->index = i;
> +				}
> +			}
> +		}
> +next_symbol:
> +	}
> +
> +	/* Check the approach for calc absolute kallsyms address
> +	 *
> +	 * A complete comment of each approaches please refer to:
> +	 * https://github.com/osandov/drgn/commit/744f36ec3c3f64d7e1323a0037898158698585c4
> +	 */
> +	if (!KERN_SYM_EXIST(_stext)) {
> +		fprintf(stderr, "%s: symbol _stext not found!\n", __func__);
> +		goto out;
> +	}
> +
> +	stext_p = GET_KERN_SYM_PTR(_stext);
> +
> +	if (SYMBOL(_stext) == calc_addr_absolute_percpu(stext_p)) {
> +		calc_addr = calc_addr_absolute_percpu;
> +	} else if (SYMBOL(_stext) == calc_addr_relative_base(stext_p)) {
> +		calc_addr = calc_addr_relative_base;
> +	} else if (SYMBOL(_stext) == calc_addr_place_relative(stext_p)) {
> +		calc_addr = calc_addr_place_relative;
> +	} else {
> +		fprintf(stderr, "%s: Wrong calculate kallsyms symbol value!\n", __func__);
> +		goto out;
> +	}
> +
> +	/* Now do the calc */
> +	for (j = 0; j < sr_len; j++) {
> +		for (p = (struct ksym_info **)(sr[j]->start);
> +		     p < (struct ksym_info **)(sr[j]->stop);
> +		     p++) {
> +			if (!strcmp((*p)->modname, "vmlinux") &&
> +			    SYM_EXIST(*p)) {
> +				(*p)->value = calc_addr(*p);
> +			}
> +		}
> +	}
> +
> +	return true;
> +out:
> +	return false;
> +}
> +
> +static bool vmcore_info_ready = false;
> +
> +bool read_vmcoreinfo_kallsyms(void)
> +{
> +	READ_SYMBOL("kallsyms_names", kallsyms_names);
> +	READ_SYMBOL("kallsyms_num_syms", kallsyms_num_syms);
> +	READ_SYMBOL("kallsyms_token_table", kallsyms_token_table);
> +	READ_SYMBOL("kallsyms_token_index", kallsyms_token_index);
> +	READ_SYMBOL("kallsyms_offsets", kallsyms_offsets);
> +	READ_SYMBOL("kallsyms_relative_base", kallsyms_relative_base);
> +	vmcore_info_ready = true;
> +	return true;
> +}
> +
> +/*
> + * Makedumpfile's .init_ksyms section
> +*/
> +extern struct ksym_info *__start_init_ksyms[];
> +extern struct ksym_info *__stop_init_ksyms[];
> +
> +bool init_kernel_kallsyms(void)
> +{
> +	const int token_index_size = (UINT8_MAX + 1) * sizeof(uint16_t);
> +	uint64_t last_token, len;
> +	unsigned char data, data_old;
> +	int i;
> +	bool ret = false;
> +
> +	if (vmcore_info_ready == false) {
> +		fprintf(stderr, "%s: vmcoreinfo not ready for kallsyms!\n",
> +			__func__);
> +		return ret;
> +	}
> +
> +	if (!register_ksym_section((char *)__start_init_ksyms,
> +				   (char *)__stop_init_ksyms))
> +		return ret;
> +
> +	readmem(VADDR, SYMBOL(kallsyms_num_syms), &kallsyms_num_syms,
> +		sizeof(kallsyms_num_syms));
> +	if (SYMBOL(kallsyms_relative_base) != NOT_FOUND_SYMBOL)
> +		readmem(VADDR, SYMBOL(kallsyms_relative_base),
> +			&kallsyms_relative_base, sizeof(kallsyms_relative_base));
> +
> +	kallsyms_offsets = malloc(sizeof(uint32_t) * kallsyms_num_syms);
> +	if (!kallsyms_offsets)
> +		goto no_mem;
> +	readmem(VADDR, SYMBOL(kallsyms_offsets), kallsyms_offsets,
> +		kallsyms_num_syms * sizeof(uint32_t));
> +
> +	kallsyms_token_index = malloc(token_index_size);
> +	if (!kallsyms_token_index)
> +		goto no_mem;
> +	readmem(VADDR, SYMBOL(kallsyms_token_index), kallsyms_token_index,
> +		token_index_size);
> +
> +	last_token = SYMBOL(kallsyms_token_table) + kallsyms_token_index[UINT8_MAX];
> +	do {
> +		readmem(VADDR, last_token++, &data, 1);
> +	} while(data);
> +	len = last_token - SYMBOL(kallsyms_token_table);
> +	kallsyms_token_table = malloc(len);
> +	if (!kallsyms_token_table)
> +		goto no_mem;
> +	readmem(VADDR, SYMBOL(kallsyms_token_table), kallsyms_token_table, len);
> +
> +	for (len = 0, i = 0; i < kallsyms_num_syms; i++) {
> +		readmem(VADDR, SYMBOL(kallsyms_names) + len, &data, 1);
> +		/*
> +		 * The 2-byte representation was added in commit 73bbb94466fd3
> +		 * ("kallsyms: support "big" kernel symbols") in v6.1, thus for
> +		 * v6.1+, they indicate a long symbol, but for kernel versions
> +		 * prior to v6.1, they might be ambiguous.
> +		 */
> +		if (data & 0x80) {
> +			len += 1;
> +			data_old = data;
> +			readmem(VADDR, SYMBOL(kallsyms_names) + len, &data, 1);
> +			if (data & 0x80) {
> +				fprintf(stderr, "%s: BUG! Unexpected 3-byte length"
> +					" encoding in kallsyms names\n", __func__);
> +				goto out;
> +			}
> +			data = (data_old & 0x7F) | (data << 7);
> +		}
> +		len += data + 1;
> +	}
> +	kallsyms_names = malloc(len);
> +	if (!kallsyms_names)
> +		goto no_mem;
> +	readmem(VADDR, SYMBOL(kallsyms_names), kallsyms_names, len);
> +
> +	ret = parse_kernel_kallsyms();
> +	goto out;
> +
> +no_mem:
> +	fprintf(stderr, "%s: Not enough memory!\n", __func__);
> +out:
> +	if (kallsyms_offsets) {
> +		free(kallsyms_offsets);
> +		kallsyms_offsets = NULL;
> +	}
> +	if (kallsyms_token_index) {
> +		free(kallsyms_token_index);
> +		kallsyms_token_index = NULL;
> +	}
> +	if (kallsyms_token_table) {
> +		free(kallsyms_token_table);
> +		kallsyms_token_table = NULL;
> +	}
> +	if (kallsyms_names) {
> +		free(kallsyms_names);
> +		kallsyms_names = NULL;
> +	}
> +	return ret;
> +}
> \ No newline at end of file
> diff --git a/kallsyms.h b/kallsyms.h
> new file mode 100644
> index 0000000..3791284
> --- /dev/null
> +++ b/kallsyms.h
> @@ -0,0 +1,91 @@
> +#ifndef _KALLSYMS_H
> +#define _KALLSYMS_H
> +
> +#include <stdint.h>
> +#include <stdbool.h>
> +
> +struct ksym_info {
> +	/********in******/
> +	char *modname;
> +	char *symname;
> +	bool sym_required;
> +	/********out*****/
> +	uint64_t value;
> +	int index;	// -1 if sym not found
> +};
> +
> +#define QUATE(x) #x
> +#define INIT_MOD_SYM_RQD(MOD, SYM, R)			\
> +	struct ksym_info _##MOD##_##SYM = {		\
> +		QUATE(MOD), QUATE(SYM), R, 0, -1	\
> +	};						\
> +	__attribute__((section(".init_ksyms"), used))	\
> +	struct ksym_info * _ptr_##MOD##_##SYM = &_##MOD##_##SYM
> +
> +#define GET_MOD_SYM(MOD, SYM) (_##MOD##_##SYM.value)
> +#define GET_MOD_SYM_PTR(MOD, SYM) (&_##MOD##_##SYM)
> +#define MOD_SYM_EXIST(MOD, SYM) (_##MOD##_##SYM.index >= 0)
> +#define SYM_EXIST(p) ((p)->index >= 0)
> +
> +#define GET_KERN_SYM(SYM) GET_MOD_SYM(vmlinux, SYM)
> +#define GET_KERN_SYM_PTR(SYM) GET_MOD_SYM_PTR(vmlinux, SYM)
> +#define KERN_SYM_EXIST(SYM) MOD_SYM_EXIST(vmlinux, SYM)
> +
> +/*
> + * Required syms will be checked automatically before extension running.
> + * Optinal syms should be checked manually at extension runtime.
> + */
> +#define INIT_MOD_SYM(MOD, SYM) INIT_MOD_SYM_RQD(MOD, SYM, 1)
> +#define INIT_OPT_MOD_SYM(MOD, SYM) INIT_MOD_SYM_RQD(MOD, SYM, 0)
> +
> +#define INIT_KERN_SYM(SYM) INIT_MOD_SYM(vmlinux, SYM)
> +#define INIT_OPT_KERN_SYM(SYM) INIT_OPT_MOD_SYM(vmlinux, SYM)
> +
> +struct section_range {
> +	char *start;
> +	char *stop;
> +};
> +
> +#define REGISTER_SECTION(T)						\
> +bool register_##T##_section(char *start, char *stop)			\
> +{									\
> +	struct section_range *new_sr;					\
> +	struct T##_info **p;						\
> +	bool ret = false;						\
> +									\
> +	if (!start || !stop) {						\
> +		fprintf(stderr, "%s: Invalid section start/stop\n",	\
> +			__func__);					\
> +		goto out;						\
> +	}								\
> +									\
> +	for (p = (struct T##_info **)start;				\
> +	     p < (struct T##_info **)stop;				\
> +	     p++) {							\
> +		if (!add_##T##_modname((*p)->modname))			\
> +			goto out;					\
> +	}								\
> +									\
> +	new_sr = malloc(sizeof(struct section_range));			\
> +	if (!new_sr) {							\
> +		fprintf(stderr, "%s: Not enough memory!\n", __func__);	\
> +		goto out;						\
> +	}								\
> +	new_sr->start = start;						\
> +	new_sr->stop = stop;						\
> +	if (!add_to_arr((void ***)&sr, &sr_len, &sr_cap, new_sr)) {	\
> +		free(new_sr);						\
> +		goto out;						\
> +	}								\
> +	ret = true;							\
> +out:									\
> +	return ret;							\
> +}
> +
> +bool add_to_arr(void ***arr, int *arr_len, int *arr_cap, void *elem);
> +bool push_uniq_str(void ***arr, int *arr_len, int *arr_cap, char *str);
> +bool check_ksyms_require_modname(char *modname, int *total);
> +bool register_ksym_section(char *start, char *stop);
> +bool read_vmcoreinfo_kallsyms(void);
> +bool init_kernel_kallsyms(void);
> +#endif /* _KALLSYMS_H */
> \ No newline at end of file
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 12fb0d8..dba3628 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -27,6 +27,7 @@
>  #include <limits.h>
>  #include <assert.h>
>  #include <zlib.h>
> +#include "kallsyms.h"
>  
>  struct symbol_table	symbol_table;
>  struct size_table	size_table;
> @@ -3105,6 +3106,8 @@ read_vmcoreinfo_from_vmcore(off_t offset, unsigned long size, int flag_xen_hv)
>  		if (!read_vmcoreinfo())
>  			goto out;
>  	}
> +	read_vmcoreinfo_kallsyms();
> +
>  	close_vmcoreinfo();
>  
>  	ret = TRUE;
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 134eb7a..0f13743 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -259,6 +259,7 @@ static inline int string_exists(char *s) { return (s ? TRUE : FALSE); }
>  #define UINT(ADDR)	*((unsigned int *)(ADDR))
>  #define ULONG(ADDR)	*((unsigned long *)(ADDR))
>  #define ULONGLONG(ADDR)	*((unsigned long long *)(ADDR))
> +#define VOID_PTR(ADDR)	*((void **)(ADDR))
>  
>  
>  /*
> @@ -1919,6 +1920,16 @@ struct symbol_table {
>  	 * symbols on sparc64 arch
>  	 */
>  	unsigned long long		vmemmap_table;
> +
> +	/*
> +	 * kallsyms related
> +	 */
> +	unsigned long long		kallsyms_names;
> +	unsigned long long		kallsyms_num_syms;
> +	unsigned long long		kallsyms_token_table;
> +	unsigned long long		kallsyms_token_index;
> +	unsigned long long		kallsyms_offsets;
> +	unsigned long long		kallsyms_relative_base;
>  };
>  
>  struct size_table {
> -- 
> 2.47.0


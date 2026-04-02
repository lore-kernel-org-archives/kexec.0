Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF58DD6AB1F
	for <kexec@archiver.kernel.org>; Thu,  2 Apr 2026 23:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wq3iQduzDrytKfCqlwgKA+iGbPdZG48uOA4Y3JPK22w=; b=WiwlOWhTIf+ZUHqjp+18TnhIfs
	SAP/4A1FJ95Iv/+LVG+Q5xCpVqmx2lttLLF9mPJWXr5QecqzCaSReYfk/CB1kj0TNdAkK9OHfSrM6
	89spiHTzEGo7Du2Vzoi6CUMlxhc/2DWRNLf0wLZhFXeytErQ5izpTYt1S+mggyqRcFtVGnWGbCoOE
	Qoq5UbjiSnOpqovvRVQnF3XauS6J6zaTm3DbYRWix4CcrnE/nyMFeyBwLw3TEcp0KSYKoKJGAUjT7
	J19OClhY1cPAPP//l45omAyI9LGPasYDoCig6PnqxqV5jlGmhnDF92cZJPx4Al1Ed8ENIibRVNELs
	DABpHs8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8Rrs-00000000xLV-0B0C;
	Thu, 02 Apr 2026 23:54:32 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8Rro-00000000xL6-3k3e
	for kexec@lists.infradead.org;
	Thu, 02 Apr 2026 23:54:30 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632NQPmG2347200;
	Thu, 2 Apr 2026 23:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=wq3iQduzDrytKfCqlw
	gKA+iGbPdZG48uOA4Y3JPK22w=; b=FJpVYmmVj8vPBnvzMuJAEigacwNfxQSeM2
	Sun20L0ADJ4vwSOvPUwz1WX4/zN1srsA0CDm5sX4sIcW7tHhxpPCigbwmDcgFprD
	3n8sN8AWodzVCZdX9P90k9VIWuxbDNfBbZVeaDzRlPrQPylATWX18trIC9g8GipY
	fCaAtk5SOvSWwFucmPRAj3D5rqklEcd7FvtlAMe9ksnQpAgCDhaYU+lq+DLItrAN
	tdaOBMI+7R1SW9vYXQTIm4/JTnb+ZfZ06DR2pbWg9h0u/2rO6CWZZrYvq4/ifv3r
	vBFosyWbF/PqaXJGF1dZ+W3eamcKXE2b21eCC0itR530NTGYgRcw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d65jwhdne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Apr 2026 23:54:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 632NkcsR021452;
	Thu, 2 Apr 2026 23:54:26 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012062.outbound.protection.outlook.com [52.101.53.62])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d65edk0y0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Apr 2026 23:54:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gqi7zjpmTt5EaP9YHLkvUms9LM29+t3fe96Gse2GuuJmGHIXxYX1jO+Oei0L+FjYm8bjq7EP4B8lDlNKdbFbI1k+mqRFweWANG7+QGmYASmtjtBZojqrBp45wGWl7XxWcplNBJhcVAKpkzbcoohqG0S/ISE5cSUtzBQeWoLaVGHsQXU8A3cppGtVTehKJPsq10xPL9NXLA/WOuk0OnkP66tMUFsBvtgHnIUFT3RsitwbEHQ9rOpQWZlLMKNCWq3dbFWhvhXRE0H6vtVMFpyMzJddOu1Zg7Ld0dkdAIOi6+0GpYDvyS6s3nLjycXlcuxpg8AJflZEZM2bIgCILRrGHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wq3iQduzDrytKfCqlwgKA+iGbPdZG48uOA4Y3JPK22w=;
 b=zV1RHI+4HTFzpIuyvI3oAsD5fVlsO/xn9vHZs/3aSs+zUf4dFEkjdyjrlTX6gYqC7p+GLtcp17SWhVMEsLU76iibpTx+wO+O9BJth7hkTJbXM43HyZsFPRfHK3sTyMVXlgePsBGBJL195Lnunl/xyAOmzqtRHCUFCzsEFoMIxfQ/lXOqxqzVvDO9ty5KIRMKaaCExX2hGYewEJaGnieyVFmn+MP/GM+W4wt/fm9n1xEYORGKkyA/bRZBYfvfk1W3V2X2OsptcuAIU1O6xboLtb5C7oBiYgFZC12rbLNu9c4nRrCU39K1WICMGM0uz/yA3GSgZJgDnOAR+us01Nw1zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wq3iQduzDrytKfCqlwgKA+iGbPdZG48uOA4Y3JPK22w=;
 b=I9TWpiY4fgF2c34UtZMLblwDXN6o89wKV2+3w2KUuC7RsKCoM/2qoiwWYu7ZHYAsYSfCIISwiIwnAPwv7Lj991qJ1jXb1eIk2vqd82a1/vyB7eX/EeALl/Wd0VLQQSscm2by+29PTGQcEhj+A7d3oxwfyHDKeg7JQvbyTaU6XM4=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by SA1PR10MB6295.namprd10.prod.outlook.com (2603:10b6:806:252::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 23:54:22 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 23:54:22 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Tao Liu <ltao@redhat.com>, yamazaki-msmt@nec.com, k-hagio-ab@nec.com,
        kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCH v4][makedumpfile 4/7] Implement kernel module's kallsyms
 resolving
In-Reply-To: <20260317150743.69590-5-ltao@redhat.com>
References: <20260317150743.69590-1-ltao@redhat.com>
 <20260317150743.69590-5-ltao@redhat.com>
Date: Thu, 02 Apr 2026 16:54:20 -0700
Message-ID: <87wlyoex5f.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:a03:255::18) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|SA1PR10MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: 0002f4d7-ca55-4db5-9227-08de911329b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: HXd++hCi2ibhXBtTwrA3QEThWMRh7IbrpP9ctX7QirUhU2xBUReTLqNDmKFcEr2/1v3DOUiYxT/E2tw5zrsxgoXusN+/M85T6I8UBjwu9M7AV3I2UZEy9fCNaBQNaDusnSEUaA5OqBiKgUK+hGTcEL8mhRVW7gzC4HdTYYA7hspTijUZmeQe37I6ODpJbhH61fNa82P6qo9wj+71qqpwXJVPrYnzfjBwmK5aF2qjcd4PjAevHZZjRjphqshooYfto3C5KGVugQ6tcRu29AJ1EGzNZogjQfzNIl5nk9xfIIdoxY6VgSXIDNoXDb6n2cB6fWFUbQ6sV7Mz8ndefysshU0dOZMDGfgHXcpsbomc5QYo83JKXFKwaSbT+8lwummc6wgqFtr8RYc+lPR/dIZstZzeKxl1FkrlzHWHAbv/C1iqtlu0WfSxruL9HEAgqjWPjODS5aVdEz6Y0PALAGFV6oKLZLIz+EllismGCXH6mvyD14u4Xi/Rl1R6ZhHr4IrLqJ3c4ubNWH04IF/5gKqpbdo/r5ZlrsarmlT1fGsLMMuGNMDv3e/M8VOAPWY/zN3lqSvdUQ1oDmwFTtmN6VAhMf96bPMAXeIMNQdbuRb+9Hf0fcWL0TsOhQsbqr/wj7U5PQL9VwsNVFZ8LvDXs1SNwt5GRvEO53pZ2NJMOSnUK0gTcAfubGGdSx5SeXMgk6CT3j2eRVHpu6cwqX9B8PoA//v1oD8ZEBMJ3A8Kr660GVE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2JUPFpAtl2Wlusu9tYaSyfQfNyisdsuiLfk05KlNwnPstyHPT2T1PP/NZ8EK?=
 =?us-ascii?Q?jMXKGH+W40g7ZSO5TFUMVSqLMAvp7OKS0bD3pT89uIOIUqlSeppRvk4Tp+9r?=
 =?us-ascii?Q?kB0U1KU4xdeOSQpDhW3LNw18lgfjFVI308Lka9KjMp4oe7Wr39gInlgEcZFU?=
 =?us-ascii?Q?CijdBqFrD9foAtpYHezd3BR2smbMVaQ75a7x3FG7ZhYypl/eQVsYQyg0AGSs?=
 =?us-ascii?Q?OOnFECkX3MiJTdJ2gwukMjqwArue/snPeQjWRC6ljBr/wWsMbkuRtfpPYVQD?=
 =?us-ascii?Q?C21CbR8hueWRj9yOLjJXj0AYxnbDqwn1yTe1dDc8o5Ybvep+pJyaPVylIIzM?=
 =?us-ascii?Q?qkuDZB035ywSAf+KmUcZ9j5fE1f6ulqLm2i5c8wP6JLJpJmDtY1wW8Bvvqwy?=
 =?us-ascii?Q?f1D6WUHf5BgKfpbmG8kjGG2di9XN6loIcT2Gbsp55FqhZIts4K1ZZeIQsfnP?=
 =?us-ascii?Q?pmFDWQu4LuxKT0gQHu4NUSm5OE/yRNSqVM2/4GMMmXnHmqDEKZAalfy0m7YK?=
 =?us-ascii?Q?be79SL5azrj9LhIgQqTQI0lCK596SZiHlskWbKyX7nGzvQyxtML15spAmRAx?=
 =?us-ascii?Q?F2+JVCDRtyB1cXWqVNtOVc99TTSkGuqzDJ4MC3nVcoR3IowHeHK3L31rOCkI?=
 =?us-ascii?Q?tGIIZPm67LX28HUrxOFB4Z4c7j+7ejhKQaNLX68Wl5PjICs8oaugu6R7MzQ+?=
 =?us-ascii?Q?qVUdWR0ZHdpInzULBqAamfeQLT06IMAjA74zts39cFwF8w7wPEdtIhP/Snaa?=
 =?us-ascii?Q?FKsGos9kZG3oSTI13r2uTongsC+WziZvOVTnIUYL4IpdWr1aUJE7Om3qqhxi?=
 =?us-ascii?Q?a1eghviX4bzF/15bu9CSRTKNB2sqLvXr2PMWg/LLpM9zCXeq0/jXeOwWMwDx?=
 =?us-ascii?Q?XG8mSWf1Sto0/v7oC/3Ox1OwI5v7DZoRY6Bf6uc2va1yjN0UYE7YE51AO6Xz?=
 =?us-ascii?Q?81aIG7FEPe6H/e2OaJPOmcI4WKr4AiRB2wU/27TFcABwnxZy2Xv4+v9y25t+?=
 =?us-ascii?Q?aGF8CjNEO8rcDisWeH9BKkAfsFuKquVpY2khpKRqSSOvnB1fhE9BaU2S651T?=
 =?us-ascii?Q?jfsAlSmBKaE1qGDllzXTIC0uTiOPqxbCYn2cDOmxQe9t7UUWrY7tJkcFjWjA?=
 =?us-ascii?Q?NEULbNIUvi7jLcClBuS7o/GF0ICQLHdQ7lPn66DtZGQYPDqS8jtF+RG6WhE0?=
 =?us-ascii?Q?4r97gY+uJocYwoCxDWLcM7IYyncU+4X1B1N/E4hwG5GquxjzErqkdS3T91MX?=
 =?us-ascii?Q?4IxJKYlr81I70xU9JtpeGjqqD9FIhijByW2gWwcUHrZJFhU+9jeatf3/QaEc?=
 =?us-ascii?Q?xABBnaHc1svy8oBCJuqGAzcD/EoEggUnaZ00JTOjD1OwAzvfIdY4sr7hhPdn?=
 =?us-ascii?Q?V7D1zQ8W21dCaiMaWUITPlfH7WPoHdHnmXKd8AL049y3sIh7AU6lEPjJQKr3?=
 =?us-ascii?Q?ly/Nxq7UZpfp+P1G/U7tlCKZLaDTCDcAy4kgLyhGlzSsUn9ujMOFZuXpGgDF?=
 =?us-ascii?Q?2CUwCEetZcd70Y0Qh2qvCo1wi4MtQ3r2b95JusLzr2DKCnJqA2y0lQRCpetS?=
 =?us-ascii?Q?uN4oOHZD2fhVfZ8Dq8EgeMRgjsJqU2JN5d2py2Ev24VEAFYz6YweVmhuO9vG?=
 =?us-ascii?Q?EqJyyeTjvmvlSzcqgB7W5JYls4cD0DHAofQtmiUPvB1pBJg9B/c3wMSFhnur?=
 =?us-ascii?Q?EGxd/N4adVhOVvg/jBC9YeL5XXeMVvxalL7eXyXDKL6TNkt7H4PVkD9cpr5e?=
 =?us-ascii?Q?kQ768jNem8srXLam2qBEpzQRl0kTyck=3D?=
X-Exchange-RoutingPolicyChecked: hyNwVfZ+9cwlKAzKSAjCWI49Y/VWHMfnNCpxTBIC3uBBovxKB2GfPpoa7GUgMxdIUk4LEsuq/TrJtwhBRRt4HedS1S06m8cih/3WdIfzVz84bus0J74Hi+m4qLAPqPFmOmzSkuH5bRE04EbaCyJfMleRFHA78eFBO4EV2WIP7L99vJJyQeTvltAzJ4UYZqxEcVOqMfrjPirKStGlGSlo/uqIEG6ykKSCwdK2iJ7/ruKJAWActEndBD7X/S43vP8+OEa7S0YcrBZojYidW8X9gMPWq6ExnPlqJKcJYx5pkydiWdwbkSBIXCf3Zdl5Unu+oQna7pg0mW0/K918Xds4Ww==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AU5DIGWpiw4V8zTW1WthK2ut+2KB/92yFlaBnwmXRmKNEN7JtXHaXXC+ii8R4Ee+mL2TbcqxunyF2A1pyot5lC5AplH0Tj5mZVjLBmlrku/XzWsGldL/mjwBmfV9pipxYgatUIcij1xESHjVOQnXjNvFN9f5GM9OWLRmAt7HSf5WvUi71Key2AHSP0+WfI1P5W6+N/Jw60+OS4ZzmYUQsiKG0uK9Wn2woqdAA4JXrHSXPtsZa4+lVTc4kkOYhWrjk2gruCRS9ZHII3CdETGE5/yHtVuiQwGClJ+FZYL1jx8oIedEGiZXoBXcQYrsE5u9te9alXWqHgpCrRnLoTOB1RjrRskVEjAfoptlJcbkz037AfziX1d3RCaTldg1RfBw+kUbATMwPFr8CYRxvsQHVt8F8qEQFfyxcNIpBPyv00TkSAEKSmMHJ7OyfekmkrgPH3Vv7SeG70qhlrRYvb78YQ1dPzDOw8W1fABHY9hk7GN4Y1+zwMXJaEl556d5f5wzqEzu91a1GuAH5tx6VemrQAfrhARf/hIc3wGqtvFtR2E8AkRjF6TWC9HpFQXpOFRxRfIpmROizkWg+MIcpnBJtfexnZDiLFBOpzzXMf3i6kg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0002f4d7-ca55-4db5-9227-08de911329b3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 23:54:22.5788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WsuqPP53rFXPg/lfZAlWjQznu0QxPvStKQUFUiW2IPYgG9YUnNos57dVvRvv4ZfK1deJktwOuK57p6tHdfd3b8e8XJ+dGhuUN+Gwp5DeKYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6295
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2604020213
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDIxNCBTYWx0ZWRfXxiYQTuq5Jv42
 aRjU/eObZqSOcLcxuoULDrFEKlknkeEc7dMPo/zE8cfdratUcPlgWBg9aug7bgzO3vz6ll2Pn/J
 C9GV1cmZvcw7BaDABH1mjrTN+WI3CB+DqKOtsvke4x3Oc77Hvy1TkUMOSj+JVjfWigl3kOhF1kY
 jEJrQOxKszILF0jC9yeMA/hUZ/ezomFay7jW11VPXKfoeB+wr+VNhZUEK+2y4G8KMp2XIx3bHHO
 dfTQmKrGPRmMyZnj8NNEQWniEh4QOFJrYZxd+yvq0GxJ8DdhQiF4K4qoB666Sx7IJ9kTl8ELUfP
 7qiKIuek5CQ1N1ikwH/qsrEW5qCOIDKcJWcaiP+1J1WdK5SuRjsRUFha2QcSpKWa0vDWZcTYWk2
 F83hO8h4oJuO88JZ//nSftG5Q4Fl8ID3scoGsxWW4hj+QfZPll+VZLR6TM9OTNdcgLHZIeNz6i6
 T7BI/xUiWtvIsHGWoXA==
X-Authority-Analysis: v=2.4 cv=CJEnnBrD c=1 sm=1 tr=0 ts=69cf01b2 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=8gr9Dw5arFkjZd8zZfgA:9
X-Proofpoint-ORIG-GUID: mDTgTp7gyVHRgLTwtPJMCFLNbAjR6IYq
X-Proofpoint-GUID: mDTgTp7gyVHRgLTwtPJMCFLNbAjR6IYq
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260402_165428_939714_380F29A3 
X-CRM114-Status: GOOD (  21.02  )
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

> With kernel's kallsyms and btf ready, we can get any kernel types and
> symbol addresses. So we can iterate kernel modules' linked list, and
> parse each one of kernel module's structure to get its kallsyms data.
> At this time, kernel modules' kallsyms symbol defined within .init_ksyms
> section will be resolved.
>
> Suggested-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> Signed-off-by: Tao Liu <ltao@redhat.com>

Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>

> ---
>  kallsyms.c | 125 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  kallsyms.h |   3 ++
>  2 files changed, 127 insertions(+), 1 deletion(-)
>
> diff --git a/kallsyms.c b/kallsyms.c
> index f7737cb..f07b0ee 100644
> --- a/kallsyms.c
> +++ b/kallsyms.c
> @@ -3,6 +3,7 @@
>  #include <string.h>
>  #include "makedumpfile.h"
>  #include "kallsyms.h"
> +#include "btf_info.h"
>  
>  static uint32_t *kallsyms_offsets = NULL;
>  static uint16_t *kallsyms_token_index = NULL;
> @@ -347,4 +348,126 @@ out:
>  		kallsyms_names = NULL;
>  	}
>  	return ret;
> -}
> \ No newline at end of file
> +}
> +
> +INIT_KERN_SYM(modules);
> +
> +INIT_KERN_STRUCT_MEMBER(list_head, next);
> +INIT_KERN_STRUCT_MEMBER(module, list);
> +INIT_KERN_STRUCT_MEMBER(module, name);
> +INIT_KERN_STRUCT_MEMBER(module, core_kallsyms);
> +INIT_KERN_STRUCT_MEMBER(mod_kallsyms, symtab);
> +INIT_KERN_STRUCT_MEMBER(mod_kallsyms, num_symtab);
> +INIT_KERN_STRUCT_MEMBER(mod_kallsyms, strtab);
> +INIT_KERN_STRUCT_MEMBER(elf64_sym, st_name);
> +INIT_KERN_STRUCT_MEMBER(elf64_sym, st_value);
> +
> +#define MEMBER_OFF(S, M) \
> +	GET_KERN_STRUCT_MEMBER_MOFF(S, M) / 8
> +
> +uint64_t next_list(uint64_t list)
> +{
> +	uint64_t next = 0;
> +
> +	readmem(VADDR, list + MEMBER_OFF(list_head, next),
> +		&next, GET_KERN_STRUCT_MEMBER_MSIZE(list_head, next));
> +	return next;
> +}
> +
> +bool init_module_kallsyms(void)
> +{
> +	uint64_t modules, list, value = 0, symtab = 0, strtab = 0;
> +	uint32_t st_name = 0;
> +	int num_symtab, i, j;
> +	struct ksym_info **p;
> +	char symname[512], ch;
> +	char *modname = NULL;
> +	bool ret = false;
> +
> +	modules = GET_KERN_SYM(modules);
> +	if (!KERN_SYM_EXIST(modules)) {
> +		/* Not a failure if no module enabled */
> +		ret = true;
> +		goto out;
> +	}
> +
> +	if (!KERN_STRUCT_MEMBER_EXIST(list_head, next) ||
> +	    !KERN_STRUCT_MEMBER_EXIST(module, list) ||
> +	    !KERN_STRUCT_MEMBER_EXIST(module, name) ||
> +	    !KERN_STRUCT_MEMBER_EXIST(module, core_kallsyms) ||
> +	    !KERN_STRUCT_MEMBER_EXIST(mod_kallsyms, symtab) ||
> +	    !KERN_STRUCT_MEMBER_EXIST(mod_kallsyms, num_symtab) ||
> +	    !KERN_STRUCT_MEMBER_EXIST(mod_kallsyms, strtab) ||
> +	    !KERN_STRUCT_MEMBER_EXIST(elf64_sym, st_name) ||
> +	    !KERN_STRUCT_MEMBER_EXIST(elf64_sym, st_value)) {
> +		/* Fail when module enabled but any required types not found */
> +		fprintf(stderr, "%s: Missing required module syms/types!", __func__);
> +		goto out;
> +	}
> +
> +	modname = (char *)malloc(GET_KERN_STRUCT_MEMBER_MSIZE(module, name));
> +	if (!modname)
> +		goto no_mem;
> +
> +	for (list = next_list(modules); list != modules; list = next_list(list)) {
> +		readmem(VADDR, list - MEMBER_OFF(module, list) +
> +				MEMBER_OFF(module, name),
> +			modname, GET_KERN_STRUCT_MEMBER_MSIZE(module, name));
> +		if (!check_ksyms_require_modname(modname, NULL))
> +			continue;
> +		readmem(VADDR, list - MEMBER_OFF(module, list) +
> +				MEMBER_OFF(module, core_kallsyms) +
> +				MEMBER_OFF(mod_kallsyms, num_symtab),
> +			&num_symtab, GET_KERN_STRUCT_MEMBER_MSIZE(mod_kallsyms, num_symtab));
> +		readmem(VADDR, list - MEMBER_OFF(module, list) +
> +				MEMBER_OFF(module, core_kallsyms) +
> +				MEMBER_OFF(mod_kallsyms, symtab),
> +			&symtab, GET_KERN_STRUCT_MEMBER_MSIZE(mod_kallsyms, symtab));
> +		readmem(VADDR, list - MEMBER_OFF(module, list) +
> +				MEMBER_OFF(module, core_kallsyms) +
> +				MEMBER_OFF(mod_kallsyms, strtab),
> +			&strtab, GET_KERN_STRUCT_MEMBER_MSIZE(mod_kallsyms, strtab));
> +		for (i = 0; i < num_symtab; i++) {
> +			j = 0;
> +			readmem(VADDR, symtab + i * GET_KERN_STRUCT_MEMBER_SSIZE(elf64_sym, st_value) +
> +					MEMBER_OFF(elf64_sym, st_value),
> +				&value, GET_KERN_STRUCT_MEMBER_MSIZE(elf64_sym, st_value));
> +			readmem(VADDR, symtab + i * GET_KERN_STRUCT_MEMBER_SSIZE(elf64_sym, st_name) +
> +					MEMBER_OFF(elf64_sym, st_name),
> +				&st_name, GET_KERN_STRUCT_MEMBER_MSIZE(elf64_sym, st_name));
> +			do {
> +				readmem(VADDR, strtab + st_name + j++, &ch, 1);
> +			} while (ch != '\0');
> +			if (j == 1 || j > sizeof(symname))
> +				/* Skip empty or too long string */
> +				continue;
> +			readmem(VADDR, strtab + st_name, symname, j);
> +
> +			for (j = 0; j < sr_len; j++) {
> +				for (p = (struct ksym_info **)(sr[j]->start);
> +				     p < (struct ksym_info **)(sr[j]->stop);
> +				     p++) {
> +					if (!strcmp((*p)->modname, modname) &&
> +					    !strcmp((*p)->symname, symname)) {
> +						(*p)->value = value;
> +						(*p)->index = i;
> +					}
> +				}
> +			}
> +		}
> +	}
> +	ret = true;
> +	goto out;
> +no_mem:
> +	fprintf(stderr, "%s: Not enough memory!\n", __func__);
> +out:
> +	if (modname)
> +		free(modname);
> +	return ret;
> +}
> +
> +void cleanup_kallsyms(void)
> +{
> +	cleanup_ksyms_section_range();
> +	cleanup_ksyms_modname();
> +}
> diff --git a/kallsyms.h b/kallsyms.h
> index 3791284..897bcdd 100644
> --- a/kallsyms.h
> +++ b/kallsyms.h
> @@ -88,4 +88,7 @@ bool check_ksyms_require_modname(char *modname, int *total);
>  bool register_ksym_section(char *start, char *stop);
>  bool read_vmcoreinfo_kallsyms(void);
>  bool init_kernel_kallsyms(void);
> +uint64_t next_list(uint64_t list);
> +bool init_module_kallsyms(void);
> +void cleanup_kallsyms(void);
>  #endif /* _KALLSYMS_H */
> \ No newline at end of file
> -- 
> 2.47.0


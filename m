Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FE0C44501
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 00:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hj2C+FJ7GZRDb6uU516ECZhX+rt8D92PvvBsO5WXcKQ=; b=1S9tp/cOBkJqae9IXQALkx6izP
	5bX5mGTcGOwMxEOgNxG+AfXfFkmFR5SYjM4ejwKp4Ch8RoAnKsbIVC+lQ9hMTmuiDTBclaGwRQSQu
	Ektza50LffsnPlESicXMtdjBoPuHkgjlGBuCIbUFThpPl/0zRTcPxGAC+oG4xyKWe4k5v9jhN+2WR
	dEWgnYrCtIefKEPNloU2gnxH4fZLtNf+R+AMH6VKkqxCj4bNAifEXx1HEt+9W68vPEctNKUfx2wdr
	uF8T3NqTgwv4oJ+P/qMBArkASxGoDcRrWV9aMiNbbP0eeAolN7ktZWEUAS0SHTVctkWJEn6pRU158
	oEOugyqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjRHv-0000000AcUK-0uQZ;
	Tue, 14 Jul 2026 00:46:19 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjRHp-0000000AcOj-3ueM
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 00:46:17 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DLFN8Y1396304;
	Tue, 14 Jul 2026 00:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Hj2C+FJ7GZRDb6uU516ECZhX+rt8D92PvvBsO5WXcKQ=; b=
	EtKNe9mDyyDuaw1TTfg0u777mZOgzffXL0LeKj1E6YNQdcQskOrxnfpgOp9cw8F2
	6id2n7iGF+408Srj2XHdkxfZyxoMlMu/j0fETztPo37XdNDfVwdN4sHa3xqloB/n
	FRkdaWqZOnfdPylUzdvHY70RPX6PBVx8lnM5fUiGLNEMbYe1ulfncWkumN0y6IVc
	I4Zmo+b3BCqZuR/Bx/cqC8SPaEFc7upbdquwtCb8Rq3izd8XhZWnDYtjvvfJOV10
	Q44TefCJOcqA+BcRwC5Xw8UoLnZURx5+vyvIG7HayGKUiVqRCitvPo7ab/7qnRBJ
	w40IWDYosZ5MdGokDV6dsg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbef0u9ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 00:46:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66E0hWAq000843;
	Tue, 14 Jul 2026 00:46:12 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010010.outbound.protection.outlook.com [52.101.56.10])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9qv058-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Jul 2026 00:46:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfQfmV81ZIi6z91sSIIPFk+rzDzKu9UWhxFECbCEL562NHtzaYL7qS5sh1wBrWK0O+VytmeSfufZ14Y3F+40QIb/LlHAyH9ZEnjxXQqLMM/bYYw0+5E5u+0ckkA4l4MEowSWCgpLgj5gH6mZmtvAzeIS8xPdrgx/uTLP1veMgaTz88DcCM9lnOrq3xCisn1BCeBhffYCwQw7h8gcd/YsKELbiAwEX+ovNEmOT4qBdtOG8UWJsKyIqZk/FuMUkSyIkXIOsQp0+B5igQCX0bwsVAKMwwL02O1RrcnX39uvj5Ea2Hmfl7s0Hq/o6q/2z6wHeL+u/5wcJpibvpA6xMJMNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hj2C+FJ7GZRDb6uU516ECZhX+rt8D92PvvBsO5WXcKQ=;
 b=a3jq7D7Dg2LJh2f3fPQmknbN/oRv7MIwfNWXC7IwXY6T6r8y996TFr3pSmzFfIuBlbU0UkZSs0J1eN3P6Jz7jwpB6zkjqia0KUNABKtGQ2XNpuj3Bk5LT9JOOGWB8ZS38EYisAmzj1emSymkTUs8M4Gh8nRKFguGdzGwDA00U5mfbLC7Ukhpw8cOxdwrDLLcT+/fb+2NZSM0hc2E1ATFWCngA9hCp9TAOAeoFJj1s4QLwR+lbUFG86H4N2Tsmct2/+R9IbP3kLP8V+komDeIeEZckx4oNaHQDsavcV0iEPWKi6gEvXM2DcHKhxEwM+tPmi/H4iQVhDvRz70mB5q5fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hj2C+FJ7GZRDb6uU516ECZhX+rt8D92PvvBsO5WXcKQ=;
 b=Gw2Y5MxXcXHw87D1D6nDZS3yVhQxfHMUTGuVtdPSoDF++eeP7oZPK5FlodMf7nJcILnX6v2ICn8lub1AoRpHHHU8GWFH4qI+17S58Kz8jgAQBNLQAWCVwV4k5gSGcDh7yRqes/yVPnLTer8GRR7yR7bpO/cWBpRYo8eYKfsq+8k=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by PH3PPF3CEC6235B.namprd10.prod.outlook.com (2603:10b6:518:1::796) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 00:46:09 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.21.0181.019; Tue, 14 Jul 2026
 00:46:09 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org
Cc: ltao@redhat.com, Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH makedumpfile 9/9] Add elfheader extension
Date: Mon, 13 Jul 2026 17:45:42 -0700
Message-ID: <20260714004550.3698175-10-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
References: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0167.namprd05.prod.outlook.com
 (2603:10b6:a03:339::22) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|PH3PPF3CEC6235B:EE_
X-MS-Office365-Filtering-Correlation-Id: 4916f674-8d67-4b9b-48ca-08dee1414bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: C/GERbBdWicyoDkLQohhjf895laRkjZYx/WP8dNVRsgAICbbjkuhIHKf6nU7xDuuPnaLcM2kJlFXOERS7x71V8P4OyOjSfGRwL2vGdu+4nAFQLj0AOPTSVjnDJxbehz/Us0Uy1O+ZRd3XM798vSTAESLpo9AWYJJDSksGUD2+Nq63Dbter5UKLgjuXpZ2Ah6dfyiA00lNVm1jmF4Kgi9Q+JP1zQ/ZP5Iag2NAtVG1QqzihV50/6zyNql9XosEHaPFvonjpkYte6KyDg8sqYAh+2KbpqJuLI2JX5DDMW6npD9Nsi+wAZNtfgggdWASiT2FZypWRn4gRnnH4P13t38riOeCK3emgdIDjrqqFNOPkdRiTi79yA66LRCoBeM1QvghvUL8bnwuHU4fBnGu0G5b0VZ+lrBywDNroocTT5fZzpZncKOnI6IJQYnVMOyKnSSVLbfR2Y8JLvUs+gelfGFzhlCY6vQhPLkwTddzw2BcbpRpLFdsu1qZqDc3/LmLP+GAoXxvQ89hV3I64/BpEWt9BpAHRMFc5i0NYTGv7O6tPlv9ai9b4kmOqAEgBr2znA8Yqdw9WXLbK5XSOtJGGSvP8YmZHyYbA2x5sxYKEuQd7J7QZoaFLHnvmvnAZIBdKYyL1ixbmAZ0sdmUPbqqWKF5fL2jVQ1nay6/dK297IZOsQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CLT4oOQJfWyJmp+wkb5e6KmCt84yCqA9XWvvk0+OEUeqtsnsyv1Tbyk3TXhu?=
 =?us-ascii?Q?TMRR0TejHKb6G10CEMJZnYjVqq+JSUfsVkH5jR0t96fJCEf0awlDnk2DkNbQ?=
 =?us-ascii?Q?6EyGTDJndDl1LjP9LDyZyTzX0u38YmxPmOit4zQjPFOUnWpQr7gXDZYD453+?=
 =?us-ascii?Q?F848Mi9SF5/lf4Igi4aFbepj3OqsyBHRUcuGGC0/Hs7NKksRDfCd/F73D/2s?=
 =?us-ascii?Q?tmW1Awi08XfOhMlqRtY5y/qQvjIjTY3C98pfXUeIiTJpnzHCF5YAz12H7giu?=
 =?us-ascii?Q?2lYUiMx4hmwShY0WmtDJN7R46znOHycN6gX90myTtKFTmDk96wrUWBKnwNGS?=
 =?us-ascii?Q?qeGXV3OXuDyeXSnjdCpZFqB5zNrAC5Otya72L8pBEmxLyho7TKIjuXvRWd9m?=
 =?us-ascii?Q?wXe0ZNyjF3Oxw7xb/Eg/j5w+vVr7eXsHpPaITIUh4todds0XJBgGhHxeIsp2?=
 =?us-ascii?Q?Lf+DOR4i+y+xGIZflmiNmLX6HFPsx4NAmpEh0z9L9A33mcAFqdaieUJnCIgH?=
 =?us-ascii?Q?B5wlcLDtcNR2OipPjIXEywY6NM4bBq8pVtuup/wvgSqrq/ixyKU+5BVgbHg0?=
 =?us-ascii?Q?YZbkDidoeYs+XFnIW6nrKNb06v1VXb/Nq2HinFdgv/4+wnNraoXH47SQ0NSN?=
 =?us-ascii?Q?TfLUnc42AdkOMsk3IguIqVr+CbcV1cjvwUPha8NCPPF0Q/XQX2NOBL9/uysk?=
 =?us-ascii?Q?9eswyGduXvxj8wRU23zd2zM3ZIGBBeykUbXawuHOyPJEcnmaQf7ZTlCfNCyA?=
 =?us-ascii?Q?uvNVH5wguoeZLU6z2hmVqAxxoZkR42PFdby2R1YS12r/uW5/q+Bpi8WHtdqN?=
 =?us-ascii?Q?f3eT34xs1yUHhXq6Jdt/5P1jPI8/Nxnh/MujMCfFXym0tAUi30U+XaGQl2/9?=
 =?us-ascii?Q?azd1Q/LY+FW5odQ/3ZiQmzGl88rVDUOJ2gLpPnKlBShIOTExU0sdsQVJqFgL?=
 =?us-ascii?Q?0PcQuUytUEuN9ZfGfeKd/dXJ9ZCG0DILQMpYXAimU/C/NV5g0DZZ5spE4CkW?=
 =?us-ascii?Q?wqNQuqXlb+riY7Fhl1r3zoMA3xRl3w1k6EXUa+HsTZQgRL1R8itV2GovMPwH?=
 =?us-ascii?Q?uu4YVFtHRDoEEYAvggBuetWlROMfZk/ZA1SHfa90tMh3tHNX3MNY4JiW9H0g?=
 =?us-ascii?Q?LVqvCMw1sPj53OX1BL+Y//Sc7FCBDhDE+1Erx0KjahWEJaZSvbvNyU9NEieI?=
 =?us-ascii?Q?/4Is8Mm6XamJT9jU9BX2Am2cEz0+dIicbC3gixDJjVipz7XpZQ5JjQAR3/bX?=
 =?us-ascii?Q?5Rrirlt+Oucgso7uv/BWY46bmXSyIdp/iwiXh2N17O4KibfQyFDqpq9dgp/I?=
 =?us-ascii?Q?Ip8h1EAuRSancjZLd1Hxu5xIntVjEGHWCoglYUB9WXvArdKfOYzxkJJSFnTg?=
 =?us-ascii?Q?xGsQeQ2ufnIdVj14/b8U9TxglR3qM3QeKIiXOEzGDbcREVUYdTCcT1T9SGlQ?=
 =?us-ascii?Q?/MTeVEoKuxSjqI+fJxLrcqVqIreeKj0N8IPOuKoFQ66xAB1YkmNDX4FTBxRR?=
 =?us-ascii?Q?PUPOzrPXWc3xH14ZBGqps2gOJcuOOLrQ5IElk8hNBmf7xxbzI+brgCQrgcIQ?=
 =?us-ascii?Q?0Brv+qo6dDgU+srifOlzAtROFgZvPwk6Ye7LFet8z1XKD/LvHmSDSGOEKYth?=
 =?us-ascii?Q?OCdwRYqPhJ8E0CSR0+nqKEHmPtNw/voIyMKTzLIBGVSgoysC/BujgwmAirvx?=
 =?us-ascii?Q?PUplcNzoByc37/bCw8IOuO0anMC6uqLaLnw7ImhGAkYl5Cn4+0hx7cnhOkdb?=
 =?us-ascii?Q?WtuTHjk5ObgDdWkdYdDDGv6RHVH+qO8=3D?=
X-Exchange-RoutingPolicyChecked: CHHbT4uBVWcodraufWycc4KMWxQgWjSbWG7opazQuaXdg/MJ1w99Bz3YxYgppEkhEYKvYolOg8b5vV3z5dhcNQf2+AMeLdyzO0przV/pTPDdckKYUdC1IkkX9NxNUkKLqywR3LvXjtQtQ2r/c7mSLoVIz3H2s7m8i+nfO8ej+FHvYDkTMLgCdfBBFvqo4R8iUER9BLDU0sIaZwBMWRFbdouAn48JGsf9U8DRmfLTjSM4TPekia23I6LZLpGCiyCNhUZGPE96k5mmRI06bzK+KWTeWwop21J8aiYpEsigDt4nPBs+sX4ppG5YcH4zP5HG9Ei7vIhvbG0CP6Cax8TnYg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tNGoLR3KMzHCnuLRfqKAsxXenAU4y0x+/gCA9ukBe43LWX4/klHY1Pc5r0SQ1rWA2GnGl0ods9CRx5ouUuYstYjbESgFkbu8bpJUq9gt0QH/4CLEUJEY0jl35NFlpcVkbSxK+5to0vHNpFQPqAANCJfzhx5BaL5oSQv8uaZOoS7ry44Leo7PerfoUCThoUMvsRMVH4AXs8AIbbMtA9vVIIp6j7x/TcNx3YkNBBthCsNQ8YiyZq1USvMKw50FOd7qHAG7GZlaIrNPHcAmyZ5cDXIb4p7WjFE8+684Ta7KjAGqcTAaYAhmaoVeKPqr3vZb7f4+kGHSYFhEMW804wUY0SZzS8UohjDrMM7vnXxVd3yoI7O9xybJEWYBg6zGUU4ikDVYyFeu+UiNbOgxgLlpLra3upnUXxygMXjyu/NFPVJ5U0z4mNmpBdc2auQx1VivqyqL10g7WhXrkQ4zT0RO6MZ5J3wtRGtmPG7dz/zQTM2NYwZ1tpi9ZcNar775bfFZGl0aLNnSBdz4o3a1HlwetrC2YKrVd77O+fMCQjpF2KQYnQAN16Bx/iTho4BVdvLRFiAz4AZ60z9ZZTO63cjy1iE8joxiaKEBXDz9tWHIGrQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4916f674-8d67-4b9b-48ca-08dee1414bca
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 00:46:09.5224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMJtEmJqlh6v8dlahcOHj6Tu8Xs6J8e32GWpeicCCD2hKt5ocokr8dB3TFQPP3oucNCtOSk16i3NtcCSqTMlOLoDrVf0izH5taWN9Ip/GHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF3CEC6235B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607140005
X-Proofpoint-GUID: PS0zOyFT2dioJJss3kkfwspFLNG_gRBg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAwNCBTYWx0ZWRfXzr/pNs4IqT8c
 5Q7aM0xRcJwwt3gLOyiXOlOMCLRV2CZFwwNNMg4K03A5uztV2K8iDPDtl3k+PxbIC/tdfIoFlxz
 RzSpg6fm2AGBJChRXS5D4CVozw2hDKNbd7cujUL15J0iBWxVb8br
X-Authority-Analysis: v=2.4 cv=KJZqylFo c=1 sm=1 tr=0 ts=6a5586d5 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=baiSg9lI4TYJxSKu9S0A:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12222
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAwNCBTYWx0ZWRfX8/YKgjTDBEw7
 T3dW0tSXGdAEVGlgIBbDLrgKb9gfQ6HHhQ3uVgPq4N1EypmUWYfcqtZfgYKMk/cY2Hb0bgkpL4e
 rQAATq5NLEF++ZmUk0rKQ4Fbqo7ylDS4TnSqZtxaaEKqKyBYjPHlmt79qDVYMBeLjvZ2oxa6TCE
 4vu5xUcrKh3PPbdtQtgWnqFZLAnfupMOm2e/+ZvxEHQDLnOahUJ5ZDADfoJ1ZgdLqL6Gy6aXt16
 j0BE3RuckCbPdu+KSXFOTT57X+M6o+6Twl9KVGueWqjGk8FI9KLQPein13FVicYmYBZSP32A0AB
 mM+VO+Eu71Ib8VHrn7TioRkci2hi86QtYUJk9TmG/uscG9g+afhjLC7oHofFe7P1ubQI83VWNVq
 TBCPv/qXjBxniWEwOSiMJruY5uqEqbLsXkgOcmnp9+YUCg1MCTKGv4tyUctkmK4umG4ynm/DL5/
 SGEkWrXpol7NG55IoKHP2rkYjR5axbAHxkW4HJ80=
X-Proofpoint-ORIG-GUID: PS0zOyFT2dioJJss3kkfwspFLNG_gRBg
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_174613_983022_D872A279 
X-CRM114-Status: GOOD (  25.06  )
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

This extension preserves the resident ELF header pages from the page
cache, which are mapped by userspace processes. It significantly
increases the chances that an ELF file can be identified by its build ID
and thus a userspace stack trace could be extracted from a vmcore (used
in combination with the userstack.so extension).

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 extensions/Makefile    |  2 +-
 extensions/elfheader.c | 93 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 extensions/elfheader.c

diff --git a/extensions/Makefile b/extensions/Makefile
index e8c41d8..c7918c7 100644
--- a/extensions/Makefile
+++ b/extensions/Makefile
@@ -1,5 +1,5 @@
 CC ?= gcc
-CONTRIB_SO := sample.so erase_sample.so userstack.so
+CONTRIB_SO := sample.so erase_sample.so userstack.so elfheader.so
 
 all: $(CONTRIB_SO)
 
diff --git a/extensions/elfheader.c b/extensions/elfheader.c
new file mode 100644
index 0000000..ccb17fa
--- /dev/null
+++ b/extensions/elfheader.c
@@ -0,0 +1,93 @@
+/*
+ * elfheader.c: Preserve resident ELF header pages from page cache.
+ *
+ * In order to accurately unwind userspace stacks, user debuginfo may be
+ * necessary. At a minimum, it is needed to translate addresses to symbols or
+ * function names, but it may also be needed for unwinding when frame pointers
+ * are not in use. Normally, userspace core dumps will retain the first page of
+ * mapped executable files, since they usually contain the build ID necessary
+ * for identifying the executable and debuginfo. This extension takes
+ * inspiration from this approach, with modifications suitable for the kdump
+ * environment:
+ * - Include non-anonymous page cache pages corresponding to executable files
+ * - Only include the page at index 0
+ * - Only include pages which start with the ELF magic header
+ *
+ * None of this guarantees that all ELF headers will be included. They may not
+ * be resident in memory. And even if the first page is included, there's no
+ * guarantee that the build ID resides in the first page. However, the best
+ * effort is already good enough to make many userspace stacks intelligible with
+ * minimal extra dump time or space.
+ */
+#include <limits.h>
+#include <stdbool.h>
+#include <string.h>
+
+#include "../extension.h"
+#include "../makedumpfile.h"
+#include "../btf_info.h"
+
+INIT_MOD_STRUCT_MEMBER(vmlinux, page, index);
+INIT_MOD_STRUCT_MEMBER(vmlinux, address_space, host);
+INIT_MOD_STRUCT_MEMBER(vmlinux, inode, i_mode);
+
+#define MEMBER_OFF(S, M) \
+	(GET_MOD_STRUCT_MEMBER_MOFF(vmlinux, S, M) / 8)
+
+static int retained;
+static int checked;
+
+void extension_init(void)
+{
+}
+
+int extension_callback(unsigned long pfn, const void *pcache, const struct pginfo *i)
+{
+	unsigned long index;
+	unsigned long inode;
+	unsigned short mode;
+	char elfmag[SELFMAG];
+
+	/* Only consider non-anonymous file cache pages */
+	if (!(is_cache_page(i->flags) && !isAnon(i)))
+		return PG_UNDECID;
+
+	/* Only consider the first page in the file */
+	index = ULONG(pcache + MEMBER_OFF(page, index));
+	if (index != 0)
+		return PG_UNDECID;
+
+	/* Only retain pages which are actually mapped to userspace */
+	if (OFFSET(page._mapcount) != NOT_FOUND_STRUCTURE &&
+	    i->_mapcount == UINT_MAX)
+		return PG_UNDECID;
+
+	/* Only retain pages for executable inodes */
+	checked++;
+	if (!readmem(VADDR, i->mapping + MEMBER_OFF(address_space, host),
+		     &inode, sizeof(inode)) || !inode)
+		return PG_UNDECID;
+	if (!readmem(VADDR, inode + MEMBER_OFF(inode, i_mode),
+		     &mode, sizeof(mode)))
+		return PG_UNDECID;
+	if (!(mode & 0111))
+		return PG_UNDECID;
+
+	/* Only retain the page if its content looks like ELF */
+	if (!readmem(PADDR, pfn_to_paddr(pfn), elfmag, sizeof(elfmag)) ||
+	    memcmp(elfmag, ELFMAG, SELFMAG))
+		return PG_UNDECID;
+
+	retained++;
+	return PG_INCLUDE_HEAD;
+}
+
+__attribute__((destructor))
+static void elfheader_exit(void)
+{
+	if (checked || retained) {
+		REPORT_MSG("Extension elfheader:\n");
+		REPORT_MSG("  ELF headers retained: %d (candidates checked: %d)\n",
+			   retained, checked);
+	}
+}
-- 
2.47.3



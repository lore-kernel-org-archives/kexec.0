Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64992C5DF8C
	for <kexec@archiver.kernel.org>; Thu, 20 Aug 2026 23:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9ewm/Zj1+McwWJwnWbHQRYKguxrcpYLE6rYhL8/QkGo=; b=iPHMWcowswtUvfqWaVeoYwQrcd
	zRuS//7Zg6bDcVMd/VgOZuQnwyTH5CVlZbhoozLV839C8vXWRBwnbv6YXjiAfe2kFh3iIxJ8vDo66
	a0YL2jksbynHsJ4bzecSEaoUX6POVZ2jtM41dmEy494ihqjCCbN8r5hcG8Bss15c/RzcW3EXYW5E0
	mwcolggSOoKM12Lcdwsbv2SC6z7aC3b9bsU6s9WjTJf0B75KRhwY523ye4we4AEjN+5njhlQFz7n0
	A4jM4WFLWUQn8a5bsWKLrcfeE0+0h6AGmVKEpw98sMdfSqG2xGnkBtw0K8Jwy4uObLRFOOVxEkRjz
	AwLIulkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxCEK-0000000CLA1-1zuN;
	Thu, 20 Aug 2026 23:31:28 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxCEG-0000000CL98-48mD
	for kexec@lists.infradead.org;
	Thu, 20 Aug 2026 23:31:27 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KDOgwu009454;
	Thu, 20 Aug 2026 23:31:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=9ewm/Zj1+McwWJwn
	WbHQRYKguxrcpYLE6rYhL8/QkGo=; b=cv4FKahAGwi9NiSyjBJZzujHGix4DBqt
	ZgzLDadYTT+BRlPTtCgcSuIpkRiYGshD+mPTF6Zscyk4PRDnTWkRhfHwsYedwGYl
	xyTO4RGZ7JPLV+tzEVqgnXiE2sVXzgO3QyjiQkq79FgWaXE5I6NPRmNNBKsr8UNK
	aQyxtjiblNyWoMnBoPj36iLABSablzFYssjFjYsDj0n7H2q1y0ObJ9Kj2h+TCp09
	KkJ2zlMW2ROJp4aXcQrU0fe/pcpThL4c5xaJDgm2cPnxooNWy8DOrkap0axqZ4Gq
	qIZNnaKIGYZH+nbr/5kgkflpbX27+Ja1koD6fg67cVaG9XqWN7+p5Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g4yd9v8rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 23:31:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67KNKdmL007722;
	Thu, 20 Aug 2026 23:31:22 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010036.outbound.protection.outlook.com [52.101.85.36])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4g32htt6xu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Aug 2026 23:31:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLc4YsxnvOgatgwttiOYtYc+2yUMaLetq1TopoTjMztTwmz+Z29Ye/ZJNUBGMl2XOB7NBQOdb5F88H9fkkboHtoTBroqYsUbZYFqtKo7VtvPZDF7R7H+A7sU7BryMi0MsnnAsuh+y/ql1VVvzdEzn1RhcJc5GK7pxavnC33HrO7MaFakjcX38pUQX/NLWZRtWUjQCS5nAzqfSqinty6mvCHLRQl1A9WeLdof+2KoK87r3+t1pQTN3OD33xQqBN/l7fkBPZORzh/X5zJjrYLktcu1RLlKe3Sy+6KbyzcnXMc9yQsVNevYgTQdcgqQLPcJYFT8szLYxsr+DK5yiBc2Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ewm/Zj1+McwWJwnWbHQRYKguxrcpYLE6rYhL8/QkGo=;
 b=RQBrZg0xHIx+owPsBEC8dn5F/f+tHNYjHqpHH1Ev5zTiVRdJi/FkvNinWkQWdnVgajXN2qTjXUpwXsgsFcAC8I81YnGNIRdGjYLHOfSjYJ65PepBs8u9J6F4T58NWAXBZHSozxdiTW7J3IOJVeTmQiuhDvCC9qAWDY1r/wdEMWsVxKGaLy/EwICwxI1+y7Yc18f9Ra1Prr1i0LLCmmROhyrcp/jdMv5MJvSMh+d51QGSFnDpzNYC0ziQE/YMXiiPmPd8Vei6ifMeWUJhkifKQKELaWSXhYKDtCNaimwPlszwDFUfWTHefhDkeI0HYx2lh0Z+j9VZzV72I6ZBH91sVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ewm/Zj1+McwWJwnWbHQRYKguxrcpYLE6rYhL8/QkGo=;
 b=lGcQupcdgBA68R49+FrIERc1DprxZNcZFLPIMA+bOqqbpoiseHZU+4siYyRbHjls+lDQxDe6aCBSZOPhbSHCHkVI9K7jvXuuLDfn8LyUExFVbdVHD2kvrKN3rT1k7iyiZOdHYsMjqsIxquwaZdmm0w365Z61L4YSzv27uNbFJM0=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by DM3PPFEABD4EF1B.namprd10.prod.outlook.com (2603:10b6:f:fc00::c53) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Thu, 20 Aug
 2026 23:31:18 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 23:31:18 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: k-hagio-ab@nec.com, kexec@lists.infradead.org
Cc: stephen.s.brennan@oracle.com, ltao@redhat.com
Subject: [PATCH makedumpfile v2 0/9] Improvements to makedumpfile extensions, plus userspace stack tracing extension
Date: Thu, 20 Aug 2026 16:31:05 -0700
Message-ID: <20260820233116.3105747-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P220CA0036.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::16) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|DM3PPFEABD4EF1B:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fa00084-72a4-41ca-c4bf-08deff132276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|6133799003|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: DNVJBC2QRf95CgI371TRmTZs7pYYFTWttvsp/p+BwS4aR0NLtOSzLA6i7EJ2EdavfJVJYU4wq7Hrf9R8Q4UeFOf+Qkie8GmuFGmGGKvLDewzcZI3Bm66nwNJG1TA1KlC0p0RebbL5yJq8j9lTFNLk/eIXLTsnYx3dpxpjtgf26gEGEJ3Lv5htoj1xQv2IE8FIyEXC02hXcJwJerZHOcztGSLRnvNDHR+Xtl0SBT7ulb/XYzYmvVC7ZcJNWmWP/oWDHqM7GZCcoouunPaos9wXT6CuE3k52qToNmpE4QxX0eoIgWYNiQnhIfsCOia4A1Q0nfQ+5RenRo5aUw+nKwI2TNx8BU9+3Jj8J4syJ7hqsSTn8mVw8K5IeFG6RrqJRV6bcuI3CMfjJZ3MBpxjM03ZmIuV9oTgrlygzF6pe7Q3Iz+M3GY6yG4TH8lBVpBjvTqSJ2uK78qFrfXXE962k2qKgb9A59aqjRV4j0y9E2eS8O6EYp/EqOhyw5l2nv0fKpAxKXEQ363uw/7O36N2IveJweRipkswvJuwRaVTafKxP2ufDWdfJEzx8D5+BksW4FJzJdd02W+wVcrzsUC68eBDVIHN/MxhHIeVHRZXSo3CKJOj+VJvZYcf+/9YNshnXHdc7QabEDqpUJbdIhpEXyGxK2UBC1piFLVk9qTA/pBQSo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bfLkO03pvmjbn/6qKL5MjCEI/j6AZ07HbRDFYJDWhTChvawzkR8DT7U2ggW4?=
 =?us-ascii?Q?X9x7pXQZiSHV/9ys55+yOJo408hm7YZnbdutkfojI8KVTIpODUBdSEegBNi3?=
 =?us-ascii?Q?KjzkM34vNgriMPmI90Owmmng+U16vdWO0+RlOHzr3X5p4faTBguvlS5s2h9j?=
 =?us-ascii?Q?uNpXrtkMTstEqX0llErRFrYCqBIF2/vQCDBOGPQt6K2J+ZwbHCbsYS1ZbH/9?=
 =?us-ascii?Q?cXdGtn65n+1q/xfaWEGjQzt0EO64GET6lmLw55y0GNQThxZb2f4Q79V7FJIM?=
 =?us-ascii?Q?1jtNMIl5iPxfzewcqUqUpwU8W5HTflgJ4vRtBtqN00Xxx/d3iIMdCFQaEolT?=
 =?us-ascii?Q?7H7Hdt3mCKZTMaXNEwO6O0XSE5Mvi04iOn5vzBKbexjO/6rC7eUJaFSn8T8s?=
 =?us-ascii?Q?0ey13g96ZXlF3WesZBfi2khF+tkpq0dUp2qHGHeR/FAidWrksyy/Z9nSV0Tk?=
 =?us-ascii?Q?ATGSWS1NJmJgHqbZXoXSGhks1g1r8OkE646Xv+BxcGnhIiD16jj7jz6U4zS1?=
 =?us-ascii?Q?yvXPHcZy2O/MTvZftmG5X0VZfIuRgKKPAPNmVoLqGQtlwZVhw2ZirRXvoXru?=
 =?us-ascii?Q?kw0ptNq6FDMOvYQeBtbWpdRzygSBIqk5bU6JQ+VQztUvuzMJuAhHEiDDpfp0?=
 =?us-ascii?Q?LGM6nlk3UIampqGFo0y47xQslnuC6ui/excAG7us+mhIbbXb1hP3JmlEK8XJ?=
 =?us-ascii?Q?3ef5oiwd/xgNb3mYq4LXHUUmgwep5dh3JL67fXRA0qiL9jHa7m7WxsSrkCpp?=
 =?us-ascii?Q?5s7es27A+vjoBHtnPCwpRJw85FaYstTEQied2MIJ1MchVbURmwPe6uN3qNwH?=
 =?us-ascii?Q?6tVW2b2Q3l3f3uqY2FqCrzTUONqJMMAppC0n1Fih0LiyaaV9i5O/PNsEYlkN?=
 =?us-ascii?Q?IqQWMhkwsUb0K/qMrm0F3iz3HOcCUIvMUgBrObniLFW23olrVUyNe9uyhPj0?=
 =?us-ascii?Q?mqNz04oDy/xz1j4Y1TUTGFRHBKePLjjV+WSupVVVX6Tvape9O/aWzOFm+z1Z?=
 =?us-ascii?Q?Iki+DG3zQ2gzA2mGvCxkOS941xpMQp83YXxcIMaCMNSRYkaCuooBONkZSox2?=
 =?us-ascii?Q?3/EjfyzZ8FpfYNG06rDgBVpGpK9zbvnxBMU2npFiN3uMfgIK1v1JcOZv7Aib?=
 =?us-ascii?Q?ksAX4tew56F52vS5h7bj34Q8eEH2Hwb0VROU86Sn/Z8hCIcKSk98Ji7mR30A?=
 =?us-ascii?Q?Zkb6EbUv1x7IcgXaP0RCnS+623D1uukWc3OZJ6rxO/TW21PMa6X7E0/Csfaf?=
 =?us-ascii?Q?hStUYH9GedAcJbdPPuElE7x++rIr2jBESeNt2KVaDh8mzMR9kS+J96y8QT/t?=
 =?us-ascii?Q?v5ZHxS5nVBfLfkv27itihqypufZDSHsqriF/Bq3KXHTQ+cc9H27RBVAQryIF?=
 =?us-ascii?Q?WkPrAF1CGMEO+tz/qgywilVBFDAlTLEIqC3L8Y3uGfGC0C/AiN12zxVfLJaL?=
 =?us-ascii?Q?LGLrrH6Bxz36I87rAaELGla7vZ1Swx5uX5PunxDn2/JnumJaw/cVFx7fS1wu?=
 =?us-ascii?Q?3OjW1mMT7hNIJDfA9060M/7xY+7tklxDTyMDLgjEmB2eZUz6X3oOcE4JdOgh?=
 =?us-ascii?Q?X1OxO2C9a+LivEyYYoFGCy/IHVkVt8w0cvdW5BfQQ8jaIF41mRPRDyD35vUP?=
 =?us-ascii?Q?C5y/LRnzly+pXjDlHHJFG+VXESH9PZN40wynqDugjZflg7QmuP3eFCtQdty2?=
 =?us-ascii?Q?DGukvEymjAHlR589tq2YriYeIB/s8s+X3DrBniL31pcQzN3G1hPqnxwoiNZ1?=
 =?us-ascii?Q?Yli4YfrL/aq2k+rSOZCS8vjCgOjzbm4=3D?=
X-Exchange-RoutingPolicyChecked: NpvTvZjEzQ70ZCDI3eLIup1WEi6H5FUVj+8Ik9/g5WCPQocea6hrFr6KP75mrYuMrYA4wFGetPwTl1uVNODjOkXyRc7C0v8ItMK8iRtET/0cLsRwdqfyimrvhwB60BGP6AxhajC9u6Dj/NcwRhdi+2SrO46djXYGNPnbPYZHej3X4tXsHKVWmEUlJzR+x0/ak6a2DQ3xYjASzZh/K3b0+8v1c2xdsHKdk1slAKGDnZDTBXgZFyf2LP21spAfrL9RXRR44juWw4B67Me/I+HbjApVCiHJ037UPfvO3t8rlf7qIZ7rRA4DHSrJtZpROSIV/fTJVs6DDKHskDxV13Enyg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: svyFzlSTBPjKbnk4Q+9ZmkpVd6MKrZV7ofcGwrOOmV+XzqevYAVrI2xuyqgNcHByLyvOe4N1xTlljUAdGjfot7MKqa72YE8YNjscUDXhuXbjCk9E4TbzKJzOvM8e8TCfWJ9aMeNzCzAJoLNxjA8PBlIO8alon9quGbvVTl6V6+VXzop4KqKUmJG7LeI+HFzd0+1nKTOWBGrbhMuLsdOCLIzIFadA/upU45NkjpmqS7KXJa2Yia7QlFncfhqhzJUq0kiLpFmw+e41x07cxNKCpTP1xd/kG3xUH+FyGf5hRqZIQYML+eFB6itWGy90Ejmw0+mYTGNqNAxBFI2RJqNuajkRVUKppGHwO9Ba+ODQhFl2dpmMt07oC0t8AssPVztdj4pHbDB3aHr1D6FQMoIwuOB2GP66KwqGU73P4A50HuSbWtkWiVuMUL9Y/cB6DVJe099bf7Tx0YdXZtlc8i6aUaYYyxfY7IfW+5bmjno3Dud/Z21mADOIaMWbU/qIHvi0c3k/zJijpW2h1xmFxOkTESJ2A7X+1Ynh9e8/V+q3r+RBcCpVq7IT8tiC7G5/2SsiLPP5qB7UxgyyPsQfP8nHVe+eZyNgqk6IJl7UmcE67+Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa00084-72a4-41ca-c4bf-08deff132276
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 23:31:18.2220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5qWvYLmpJvw1YzGnkVS43/8cbjEKWp88RIn+EJmghGho6AYlKgAjMCGdEnr71/hEVhrp/DDdofIXacfh3c3w+216xfnnO0+XmjWvWF+bc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFEABD4EF1B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_03,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 suspectscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608200174
X-Authority-Analysis: v=2.4 cv=VNvtWdPX c=1 sm=1 tr=0 ts=6a878e4b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=C7mT_x_fQXqJ4l1vu10A:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12102
X-Proofpoint-ORIG-GUID: CsOPjGDuKEXcVtfoaqnkHmL6UkuxDFDX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE3NCBTYWx0ZWRfX1fbWnqlUcCA+
 ZPicoMUg6o2B+C56e6xMx+sCTHf5xF3/e0OKq3g9ZwuSPrfNQHsItU+WnHCRW34W+pGiRCIb3N9
 KHtXf6D56M7b8XZOaSM7Gc4L07JmDCC2E0qcFSOhcc5HyCYUbfH8oKTMVkQFTUpEK4UYTZMl5DP
 4aJ5edTSHdi4Z9o5s1gusV7Vta+yPEaoeknvd3MNdMpM5Tyo5MgOwue04yK31ypwg9I/AJZvrMZ
 +f2dF7FKbN9QpyVm8+KZ1PBLzH+SPzBh7LGdQdgwdkVfgwIrjzjKsYehV+XvmO4yOvc//XKKIs9
 ofzIbd2fu7qhbiYbyCiYzV7vlDRDyz9xpZz8KHPlkD+4lL989nXx2+rASDAd7mIiV2LFQcWVw1k
 XB2uduE9N208Pl0rUJzGrxnr47lGBa5NqS2ae/nLzwvL8oly0f8iKzWxiyPqTtltorEF2iaGdZx
 nBZe0xqUlAmrLRnvQ64xSDO9XwXju5CMpz7OFoNU=
X-Proofpoint-GUID: CsOPjGDuKEXcVtfoaqnkHmL6UkuxDFDX
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE3NCBTYWx0ZWRfX02daRPJ3VQKm
 qptOEna23T+0o6ftTzrDHH5j7Ay9soTzljc7ZjlqVu4bFQXu1HNCfa7Qwnd56bKgJvFvdlHvWv0
 2Eyhax5pxqnikRaPnwgShEopRXzNr03VlFsp0frLyw7dhledP427
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260820_163125_445756_917C1C0C 
X-CRM114-Status: GOOD (  21.36  )
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

Hello all,

This is v2 of my series of improvements for makedumpfile extensions.
v1 can be found here: https://lore.kernel.org/kexec/20260714004550.3698175-1-stephen.s.brennan@oracle.com/

There have only been a few changes from v1:
- Updated extension/sample.c to use the new API in patch 3.
- Reordered and reworded the extension retained pages statistic per Tao's
  suggestion, so that it is more clear.
- Included a more complete commit message in patch 7.
- In patch 1, removed the "nr_pages = 1" when extensions return PG_EXCLUDE.
- Significantly reworded patch 1's commit message to explain the different cases
  and the alternative approach.

Notable improvements in the "userstack.c" extension are:
- Leverage "detect_cycle.h" API to apply Brent's algorithm for cycle detection
  in linked list iteration, to avoid infinite loops while iterating tasks &
  threads on corrupt vmcores.
- Set a limit to the number of retained anon_vma entries, to avoid hitting OOM
  issues in case of a huge vmcore or a bug in the extension.

As discussed on v1, the final two patches containing the extensions are not to
be merged. I will publish them in a Github repository as soon as I can get it
arranged with my employer. They are more for demonstration of the API and
continued sharing until the repository is available.

The major discussion on v1 was on patch 4, dealing with how extensions are
called, between:

(a) Extensions are called for all base pages, and their decisions may conflict
with the head page decision.
(b) Extensions are not called for tail pages, and the head page decision is used
instead.

As I explained in my last reply, I believe that (b) is still the best way. It is
less complex than (a). It is also more efficient, because makedumpfile today
skips processing many excluded tail pages, which adds up for large systems with
many huge pages. We do not have any extension which requires any policy more
complex than PG_INCLUDE_HEAD.

- elfheader requires PG_INCLUDE_HEAD
- userstack only uses PG_INCLUDE. I could imagine potentially wanting to include
  just the sub-pages of compound pages that are actually used by the stack. But
  it hasn't been necessary so far.
- amdgpu buffers may be compound pages but if they are, then the entire page
  would be excluded.

I do have an implementation of (a) as I showed in the thread. If I'm wrong here,
I can always fall back to that.

Thank you,
Stephen


Stephen Brennan (9):
  Do not call extensions for tail pages
  Honor CFLAGS in extension/Makefile
  Share page information with extension callbacks
  Introduce a stat for pages retained by extension
  Move page checks into makedumpfile.h
  Simplify arguments for page checks
  Add PG_INCLUDE_HEAD extension return status
  Add userstack extension
  Add elfheader extension

 extension.c             |  10 +-
 extension.h             |  10 +-
 extensions/Makefile     |   8 +-
 extensions/elfheader.c  |  93 +++++++++++
 extensions/list.h       | 106 ++++++++++++
 extensions/sample.c     |   2 +-
 extensions/userstack.c  | 351 ++++++++++++++++++++++++++++++++++++++++
 extensions/vma_mtree.c  | 140 ++++++++++++++++
 extensions/vma_mtree.h  |   7 +
 extensions/vma_rbtree.c |  56 +++++++
 extensions/vma_rbtree.h |  12 ++
 makedumpfile.c          | 189 +++++++++-------------
 makedumpfile.h          |  78 ++++++++-
 13 files changed, 931 insertions(+), 131 deletions(-)
 create mode 100644 extensions/elfheader.c
 create mode 100644 extensions/list.h
 create mode 100644 extensions/userstack.c
 create mode 100644 extensions/vma_mtree.c
 create mode 100644 extensions/vma_mtree.h
 create mode 100644 extensions/vma_rbtree.c
 create mode 100644 extensions/vma_rbtree.h

-- 
2.52.0



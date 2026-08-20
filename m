Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81E2C5DF91
	for <kexec@archiver.kernel.org>; Thu, 20 Aug 2026 23:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UeZl9CcjUY2eLwJbQJhDPZOF4fgZY9vrgIpTWedLvH4=; b=nvzl0E9lR5j/G3ulGqOz/iLk8+
	gwFMZNXSTKyrU7BRwmv62c1gqkGVpl7i3tCQSa+TBZJpNSwEG4B4kRKbKwASF+/gNigKMaaXei1Au
	aZ47Apc/iL01nblzDAGFh9hWHw73oRTtnxUbuu0dboFeRP1zb49j3tbWU1P94eUsZ/NUaEsLQqYRI
	/Mc4RLahk+Q8YqEzP4+h5SldkpUwoDiZOduPmmUBMrMFJZ5rVFgOVWa/bHOpb/ABCvKMt9PQ/IArv
	gOrA5p8JIxo5N7tB0FcpWXhLECwrdmpWAFTEJafn/r5T/4qHyZd7+QUTeb4IBVrm1oA2HFmeVmEpb
	Q0SSWhLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxCEQ-0000000CLDe-3ZlZ;
	Thu, 20 Aug 2026 23:31:34 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxCEL-0000000CLA8-0dl3
	for kexec@lists.infradead.org;
	Thu, 20 Aug 2026 23:31:30 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KDT8Lc009654;
	Thu, 20 Aug 2026 23:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UeZl9CcjUY2eLwJbQJhDPZOF4fgZY9vrgIpTWedLvH4=; b=
	cmeufXm/Gqjq2H4ncD6OtdF9K/PLAVYex4BeP57JPmR50z5/3PJP+8UHO3PSClDg
	TlFbymAPfjQZegmokvDBqrP4hbUap4RYQ3Etd/PskXz/SmFriOKw9EnE6SEr4rYC
	EIz9n/jJo+Vj13l7su4pfUffE0SDeQuYfqlrkXOE+w9DT/OXgRar2diRnAlnW1kQ
	GYbMfHiWc6uAdCP5lvycKtZrgYPc4W5WcZPS+YhOhipayBnkYBOZ05h0HOsXLo1w
	B5b91fcu1GMda2GmV3YjXfCtoT0kDw7wqOQt4E9QtKNnOriV9R2Q9BMxATg3SCbk
	1dB/qJIPsxviI2tohLiiXg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g4yddc7tr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 23:31:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67KNUar2013684;
	Thu, 20 Aug 2026 23:31:27 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010002.outbound.protection.outlook.com [40.93.198.2])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4g2ejttyd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Aug 2026 23:31:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/idrV4J1x9PNNnZ2u7K59bBaPfKQOJ6q53Dqfk2WSEwxWbuvDQdaHy/V16hh1CyZpLvGV0QeBJXaiVDBq9QrYoaorO0m7URB0G8BKzqZSSuFvR+jg1kAQZyhr6O9BKpIuWeTYILpy63AmuS61h1NwzP/L2vKC2qk62KVOS7rvLoZkREp0piJPdKRyHg2sk4FSkS0Vi0S+M1mOaRNmz1nr/S6lTuXtAI7otucgFD97sPBHBm49tGv6N8SJwr/dbjOwQ7wZEhkBl7nah4rce8cGK8XF6cisUzvQaBxiVMDn05X5TRG++QK4H8bt7PgcllI7v2oVwu8+nXVuhiHSM+fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UeZl9CcjUY2eLwJbQJhDPZOF4fgZY9vrgIpTWedLvH4=;
 b=l/rN9hrLFktH3JJ0uYxx1V2gfu4ETEVY3Z91dNHlmodnyPUvzuxRJgD5+fWD3318PpjTyWjn8g+rc9irH7+A76/G9rxAIjSN0cBGsKYO6Ref+iJEMw8/3kjkMfyBg7/3ZDpoTXOnUeCzyxk89ynxx2sZgHZDyrbgidgWuguk2FYoC7zx8nvvo9Xk9x6vVsyIJ7t6Itzy00nUqKkwgfn1U07iCI83y282PE4Hi0rIldwIPHQ5MlQGOPUkroSQAJwl/I6wl+FTd8AHogaBZAwAOnALhas49DvSmYvfmKnHNour2GgWh11EgN7Cq2x6r90hEfqIL0f9y5nB+omRVAfIxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeZl9CcjUY2eLwJbQJhDPZOF4fgZY9vrgIpTWedLvH4=;
 b=O3jzZpcPX1D8Pa2iIz0M7ACEMyUYi/gKEnEYdbO8AhQJTRE7dvRn552TgE2N7GqhrtjJdYdNTpY9LPhl/Aa/jDIAOc0PtYlSCEx3IgaUlQMcteq/2uEJy7dm5Xez5QyyMCiwfU5MK4ZnwIHE+25cwN8VoIsn5K7nKhpRl6g57H8=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by DM3PPFEABD4EF1B.namprd10.prod.outlook.com (2603:10b6:f:fc00::c53) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Thu, 20 Aug
 2026 23:31:23 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 23:31:23 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: k-hagio-ab@nec.com, kexec@lists.infradead.org
Cc: stephen.s.brennan@oracle.com, ltao@redhat.com
Subject: [PATCH makedumpfile v2 3/9] Share page information with extension callbacks
Date: Thu, 20 Aug 2026 16:31:08 -0700
Message-ID: <20260820233116.3105747-4-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260820233116.3105747-1-stephen.s.brennan@oracle.com>
References: <20260820233116.3105747-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR15CA0010.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::6) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|DM3PPFEABD4EF1B:EE_
X-MS-Office365-Filtering-Correlation-Id: 758989bd-7036-4cba-f14c-08deff1325c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zUEUKcpYUJonesO08YoDs9MVStRDn8HW6d475lE4vK5ghQGRDA1+9p/tR+Fq4rM9TsOv5MEuxN/PGRcgO+ShVkYmXLnyOJkW6eLLAFRZGHgTAwJo0NHyR13xhOTMCf3XsxqfkVyeeniB7rq04JikLCQ548vti/y86cMDzApgpOe2wgFL5yIk+NEnUfYDzz0bWyFCzows66pmv8Vn5vYLNew8KXDJWHDgH/Jug84zsZM3AmIOgRVWDsyAGKMZRmPAv1/6AmGhBW3yY9A6Cj8j4xkwNyl8lT+DhgGUuhAfJPo4yPCKbKBc3+lRFh7uMqdMR2wNKN3oRLZHrRJPHgMAmn9im+A/OL3VGsRhy0FnPFpZSuKy6Wfoyr7yemKT7dsJGsxcEvOuN4uibyyX8q8l7RpkdMjHDKMoLgGkQBa5KIRDGeHnc8ZprJa12Qp2s00Iv0RPR/Kum7KtZ0y0bUOOTDneUPSUqhArEr5L6TZS3q62vjKWxK6KigUKN7IxU3YE2YmS5ZTH5l7nTfBth+D43zDDlRW5iZhz3vlcvdBaa0N1RJ+88eke4m5MsWn8GKvfe58a3xiCTVt+yiaAaepyHx+B7iGHSgb4dXJku5KLP7EiEXDF2/Ynf4dfVzW1DbR+9CZ1YPMWAxhWreDxDySD8UI8X4abOYfoXHRVOEuRSwk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a6a/mB7Kmd1HHmeEcRIiD+3reIyUU74FRwmxDvTtfA07pPc6UNmUc3i74FCJ?=
 =?us-ascii?Q?HCS3te3g7xN0I4a6e8UVb8ZQJWmyUqFN57dglYQpcZHeVZhOhcryD1Y9qsS+?=
 =?us-ascii?Q?/tNRuRbaNYLiE5xqANpbC2Zmha4koRJRf3IXVWqyXiWxDIbnp4OD5PhkDTps?=
 =?us-ascii?Q?Xby40fhb9koBwpqWcvJRcU+P6LHXpjCjqjsoprz0jZba0sxan1WVou92kIkJ?=
 =?us-ascii?Q?j8vN7KhZ8C2d4D0J65V3W38IDjwcuFPDJH703PQaSawcPcVrEay1UKPDPIUt?=
 =?us-ascii?Q?MHbq3Becjr8Hgf87KNCaaZ9YiFk75zf5f/LSRwGFseiJwFnrHY/NHq7z6oTb?=
 =?us-ascii?Q?kIgkT0uKORQQIUl9cOmJYO4FvO/XKV/fKxDpSP9MUCDnssFIuqkMXDxP/Ft4?=
 =?us-ascii?Q?+6F6qXCmMKUB7cZJyb7LVhw//amDDIl7GPqeJLUBTOTsNAm/AjSN5Q0tZ16N?=
 =?us-ascii?Q?EWn2UXsDpoSZnHQa6rMvD6jQlSJmOPIqeQSPVHzojT/oxDorKsw+ivsZl68E?=
 =?us-ascii?Q?gyg1eYbKOQiKzLYM+3Q7G223Zyplt//WBqRXCZBM5EO2Mtlz83J/m7ALFM9O?=
 =?us-ascii?Q?Ad4hLD/70wb9MpOpbEEk+s9dkH2gRMHNLsMPnLFPe7164Q5a8l9uW/Fj3mmp?=
 =?us-ascii?Q?8nMMEi/K8kuMFK7oVbAxIWgQ1qZlnV8eTHlayLl+T2q7iiHtC0zjCnuKQ+O7?=
 =?us-ascii?Q?3fgCDT5R2Ki76zch+C6aEyoETc8uqt6THZvORUKj89FVt6kcz3N9MLwEj4g3?=
 =?us-ascii?Q?mqCGLHekkYkWbUr3G7js1p+FRkx4Oudiy5KnWCvsM7GW5VwiyjOq67ZGsJol?=
 =?us-ascii?Q?ER87SdNH/3V7q0rgX7eDZFNIrPLPaH3oebx31UTKUAFGvoLeTUj/tKdi8PyP?=
 =?us-ascii?Q?9wly7Mu78GCMep60GznNThfZ+OtVhHawKECmxGTt3trpT6XpfLplmuxV1x7M?=
 =?us-ascii?Q?u9rNOHVhji8yiTNG9V7gAi3UUKnFyMWP4oP13tVLL0f4Kii2W6JTnqHs6nVx?=
 =?us-ascii?Q?pbBs76e9lqDlLocvx0IbWdJNvpV42ntvVytB+jJE00uvMwDaFEXUf23wzEvO?=
 =?us-ascii?Q?ppI7KGtmVxilteRStwCMk1a7zuAPMC1CqyVjo1xuSzCbZJyK6hZQ5qHHIZTt?=
 =?us-ascii?Q?KwCrAQBleaiF48q/ru1uzPvnRjXlWc3DEJ8r7BmVJP259ZjQ0pDTWIbwlAKQ?=
 =?us-ascii?Q?Lzs1M2bAAWFnaDe4JCjdgL0Str9copZk5nBlkHfqa5UIHf79++gYXf4xmnE2?=
 =?us-ascii?Q?xRLX13ASYh/46fjF6hLJtdqSfA160ec8mxOxou/KK88oHcsuQpw3fcv9JBi1?=
 =?us-ascii?Q?/LseoKfTMd4qGACPiZv4ANhi0SACepgDwOGVzkAMV+Zh5vhDNfG42MkZEPJr?=
 =?us-ascii?Q?xMLfSA+dTRtmbgYp0LWxlJ2iG7UrtGiYFpVhw4kXe3xijbuzXFvBY//bijgh?=
 =?us-ascii?Q?gJ2ignWGGV9LzGEwYZ+dyyOizqvlyw8imQ8jDgvmJ0QGpRj7y38hHrY0G8zt?=
 =?us-ascii?Q?nLJwkL1M7SbdhA511qz3MsQinWZdSwrSbFVZCupas2F8sxXpJCAAsD5RvbNk?=
 =?us-ascii?Q?pgRO4NzRq/R9IUdEQiGw6N7r0J/M3D4kYxtAdbiH9hNmVFh9G3nNNyzOYNmn?=
 =?us-ascii?Q?NuExyaFZjGQ/00/gh9rku15oH3s2s1A0Eq3rnlzDJoNbeFqCgLsg3Jywda6j?=
 =?us-ascii?Q?0iX1Hw7/RgTJTG4dTS0BdWU8NpPKMhYiORnzCVoVZ22JSswFhV4iSO94vUnS?=
 =?us-ascii?Q?TLNvRWQi9lxbhICVRNcjIB3XP4bgG8w=3D?=
X-Exchange-RoutingPolicyChecked: LHrBfvfC9SIwmSHmsb/zgOS+n8/1csTpi4wK/52OyoM6IEctmmfi+w0vqaCO7dl+EXtAspWeNBNNzNAM2Iyk/jJX49Idg6+L3AZyQA5e6SO8dYj6LkgWyCqLxIqyVtyah6JKB5+eqCp0xvcsY1FVCE/dysQn+PIC/9IoRWbSeW/rL86PiwWjAUkxItHqRkwViP0RXaHkAPUyy8bt/oOozNe6MVK2d38okwNL6Y/6aLmOK4QS0XlPq+LcPmCgJjz6HzMVs68m6JfwM4O3MCTNoGuML9h44PQSj7mOTs9bJrtUxu9+tUsHxmlqrV0IdnqJwGPnu0ka2me0LRImk4/t3w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LtgeOgJcO8tkiuKzXYoL2bVqgJ16VYtRx/OanN9ZiZKZruo84nylFH8va/KpWxENBKR7wv5qaKj4h3+6hpdMMbe87/d/GZCUuK1HlwKDirMtMLxQup8BDQXSeZF0NJBNsBDOy42osjHKVBWxoqOLLS6L0Abe82rZkWBOYod+OBycy5Xm8899hE6NXyFkta/nY+SyO3V3m+ITbuJ/T/BlFoIMkxnCNfQVp2WhLf4WYIpiHzNhhj2jl83MPQe3rxWAzKP2wu2o71dfFmnxkl565X6RBGHoKMJW9vOA0YfC/HAJo6t7jvHTvwYB82HxGAO4E34LH0Lo9Xni+Zl0cA3KufZHvxdmQKdFIAkcywPGO6lyJ0nXjgfH9bqqViElQ2mIbyVOPYIfPdOFQpsC6UsikiJWmnRtLXuct3KHFuUugltElhMFEcBcqwN0l56p2+3r88uFJe4TgZh6okTL3xi5ZZDIXzXtRySP6sBTVIiZkXlC8SwgUF1/avE1nAxq1QSKD1BbVymGiHmh7Q0wh1jCw8wqTFPuVwt9M0YsvlN2z5FfiSGDh4OhaBWpV0wNqUNHP1ZjN0LTTQj4fElzVVt07BfYGsIw7BMjqkQOR1wNjXs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 758989bd-7036-4cba-f14c-08deff1325c3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 23:31:23.7451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cnqSz+THltsk0M1aLfpj8/D8yTMDpqjlt2m1S1YulO6GsYm6dPuJubU3OycFATfJl40LnbUyglW2xDRCafbvTGaMG6Ue+YK0XEe5kxT6hwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFEABD4EF1B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_03,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608200175
X-Proofpoint-GUID: 7NxKFTXjPdqdUqMiCITarMdxriVISSFH
X-Proofpoint-ORIG-GUID: 7NxKFTXjPdqdUqMiCITarMdxriVISSFH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE3NCBTYWx0ZWRfX8x0kFNAzKcj0
 MqMM8CN+cZa8TY4j47DBUHg5s5D7tadXLDxI+IykhMDijTD5Rp/x7BS1USE3TgpV/3MTawJkwtE
 Lp7M0+1jonGegaOm+OkFqVvK6yF/TZ6WvCD0zjNhK+CZ9aHTvwTn
X-Authority-Analysis: v=2.4 cv=BdjoFLt2 c=1 sm=1 tr=0 ts=6a878e50 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=BRMCUliFZU4PxBN4gIEA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12101
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE3NCBTYWx0ZWRfX9b4+q9fsvOJk
 CRx3SPWp7N/mh59BI4f7f5/WP8tKJ14x1ijMfjd4X3Bbkm1dBWj+fMz+CdTj+aVZG5vJsUyayIk
 E2CiQZTQM9FE2KaO6BS7HT8GuW2ClyG9BjH55dA2GZCOasUnIkS9fdTSdnv/rzZKKjoE7ydJnjj
 HyojYCTpAP4F1muaUFuwAu2JPpOYWHE5vT2Aj/DQHIRsNd9MtvsHbPiUcId6b6RHdayIju7Ew0j
 MZJ4zjUgoM7r6tKAIquSEP7V+P/rDhOuXG/PWDnKbDS+68mmkVTGTcauLN/VhZdEhHCTf4IW/77
 TQ+cN4DBcxP8Sw5WKYSIKmMLpJ9tckYoMPyKu7Eh7tRHHoJ6dbn89nMp7PNDwzQ0OxjmA47jscf
 nQj9yjJqLUz1btM/nz4cFNM0FV+3ynQRaogaAAZWJ2AAcxekyVDCTtL0x2ehUpLC7kkJOY66rn0
 8+HGaqLAmWkAVDy8Minl7rpnQDTlbBA5HiJ4S0Mw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260820_163129_211035_EB038807 
X-CRM114-Status: GOOD (  17.82  )
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

In __exclude_unnecessary_pages(), we extract several fields related
to the page. Some of these, like compound_order and compound_dtor, have
logic specific to the kernel version.

Extensions can, of course, determine these values for themselves, but
it's extra work, and duplicates logic that may need to be updated
frequently with new kernel versions. What's more, if we put all the
values together in a single structure, helpers like isSlab() and others
can be implemented in terms of that structure and shared with the
extensions in order to further simplify their implementation.

With that in mind, group the per-page variables into a structure and
share them with extension callbacks. This breaks the extension API,
but since a release hasn't yet happened, it seems reasonable to do so.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 extension.c         |  8 ++---
 extension.h         |  3 +-
 extensions/sample.c |  2 +-
 makedumpfile.c      | 83 +++++++++++++++++++++++----------------------
 makedumpfile.h      | 16 +++++++++
 5 files changed, 65 insertions(+), 47 deletions(-)

diff --git a/extension.c b/extension.c
index 5188c1f..9b29f0c 100644
--- a/extension.c
+++ b/extension.c
@@ -10,7 +10,7 @@
 #include "kallsyms.h"
 #include "btf_info.h"
 
-typedef int (*callback_fn)(unsigned long, const void *);
+typedef int (*callback_fn)(unsigned long, const void *, const struct pginfo *);
 
 struct extension_handle_cb {
 	void *handle;
@@ -306,14 +306,14 @@ fail:
  * 1) Include the page if anyone says PG_INCLUDE, and
  * 2) Exclude the page if no one says PG_INCLUDE, but one or more say PG_EXCLUDE.
  */
-int run_extension_callback(unsigned long pfn, const void *pcache)
+int run_extension_callback(unsigned long pfn, const void *pcache, const struct pginfo *inf)
 {
 	int result;
 	int ret = PG_UNDECID;
 
 	for (int i = 0; i < handle_cbs_len; i++) {
 		if (handle_cbs[i]->cb) {
-			result = handle_cbs[i]->cb(pfn, pcache);
+			result = handle_cbs[i]->cb(pfn, pcache, inf);
 			if (result == PG_INCLUDE) {
 				ret = result;
 				goto out;
@@ -341,7 +341,7 @@ bool add_extension_opts(char *opt)
 	return false;
 }
 
-int run_extension_callback(unsigned long pfn, const void *pcache)
+int run_extension_callback(unsigned long pfn, const void *pcache, const struct pginfo *i)
 {
 	return PG_UNDECID;
 }
diff --git a/extension.h b/extension.h
index ba8d32a..22af9a6 100644
--- a/extension.h
+++ b/extension.h
@@ -2,12 +2,13 @@
 #define _EXTENSION_H
 #include <stdbool.h>
 
+struct pginfo;
 enum {
 	PG_INCLUDE,	// Exntesion will keep the page
 	PG_EXCLUDE,	// Exntesion will discard the page
 	PG_UNDECID,	// Exntesion makes no decision
 };
-int run_extension_callback(unsigned long pfn, const void *pcache);
+int run_extension_callback(unsigned long pfn, const void *pcache, const struct pginfo *i);
 void init_extensions(void);
 void cleanup_extensions(void);
 bool add_extension_opts(char *opt);
diff --git a/extensions/sample.c b/extensions/sample.c
index 4bc7f9e..a96898a 100644
--- a/extensions/sample.c
+++ b/extensions/sample.c
@@ -36,7 +36,7 @@ INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, mm_struct, mm_rb);
  * PG_UNDECID to let every page fallbacks to traditinal page-flags
  * check routine or let other extensions make the decision.
  */
-int extension_callback(unsigned long pfn, const void *pcache)
+int extension_callback(unsigned long pfn, const void *pcache, const struct pginfo *i)
 {
 	return PG_UNDECID;
 }
diff --git a/makedumpfile.c b/makedumpfile.c
index 1aafd4f..e3a4a6f 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -6466,12 +6466,13 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 	mdf_pfn_t pfn_read_start, pfn_read_end;
 	unsigned char *page_cache;
 	unsigned char *pcache;
-	unsigned int _count, _mapcount = 0, compound_order = 0;
+	struct pginfo i;
 	unsigned int order_offset, dtor_offset;
-	unsigned long flags, mapping, private = 0;
-	unsigned long compound_dtor, compound_head = 0;
 	int filter_pg;
 
+	i._mapcount = i.compound_order = 0;
+	i.private = i.compound_dtor = i.compound_head = 0;
+
 	/*
 	 * If a multi-page exclusion is pending, do it first
 	 */
@@ -6543,21 +6544,21 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 			pfn_read_end   = pfn + pfn_mm - 1;
 		}
 
-		flags   = ULONG(pcache + OFFSET(page.flags));
-		_count  = UINT(pcache + OFFSET(page._refcount));
-		mapping = ULONG(pcache + OFFSET(page.mapping));
+		i.flags   = ULONG(pcache + OFFSET(page.flags));
+		i._count  = UINT(pcache + OFFSET(page._refcount));
+		i.mapping = ULONG(pcache + OFFSET(page.mapping));
 
 		if (OFFSET(page._mapcount) != NOT_FOUND_STRUCTURE)
-			_mapcount = UINT(pcache + OFFSET(page._mapcount));
+			i._mapcount = UINT(pcache + OFFSET(page._mapcount));
 
-		compound_order = 0;
-		compound_dtor = 0;
+		i.compound_order = 0;
+		i.compound_dtor = 0;
 		/*
 		 * The last pfn of the mem_map cache must not be compound head
 		 * page since all compound pages are aligned to its page order
 		 * and PGMM_CACHED is a power of 2.
 		 */
-		if ((index_pg < PGMM_CACHED - 1) && isCompoundHead(flags)) {
+		if ((index_pg < PGMM_CACHED - 1) && isCompoundHead(i.flags)) {
 			unsigned char *addr = pcache + SIZE(page);
 
 			/*
@@ -6567,10 +6568,10 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 			if (NUMBER(PAGE_HUGETLB_MAPCOUNT_VALUE) != NOT_FOUND_NUMBER) {
 				unsigned long _flags_1 = ULONG(addr + OFFSET(page.flags));
 
-				compound_order = _flags_1 & 0xff;
+				i.compound_order = _flags_1 & 0xff;
 
-				if (_mapcount == (int)NUMBER(PAGE_HUGETLB_MAPCOUNT_VALUE))
-					compound_dtor = IS_HUGETLB;
+				if (i._mapcount == (int)NUMBER(PAGE_HUGETLB_MAPCOUNT_VALUE))
+					i.compound_dtor = IS_HUGETLB;
 
 				goto check_order;
 			}
@@ -6582,19 +6583,19 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 			if (NUMBER(PG_hugetlb) != NOT_FOUND_NUMBER) {
 				unsigned long _flags_1 = ULONG(addr + OFFSET(page.flags));
 
-				compound_order = _flags_1 & 0xff;
+				i.compound_order = _flags_1 & 0xff;
 
 				if (_flags_1 & (1UL << NUMBER(PG_hugetlb)))
-					compound_dtor = IS_HUGETLB;
+					i.compound_dtor = IS_HUGETLB;
 
 				goto check_order;
 			}
 
 			if (order_offset) {
 				if (info->kernel_version >= KERNEL_VERSION(4, 16, 0))
-					compound_order = UCHAR(addr + order_offset);
+					i.compound_order = UCHAR(addr + order_offset);
 				else
-					compound_order = USHORT(addr + order_offset);
+					i.compound_order = USHORT(addr + order_offset);
 			}
 
 			if (dtor_offset) {
@@ -6603,40 +6604,40 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 				 * to the ID of it since linux-4.4.
 				 */
 				if (info->kernel_version >= KERNEL_VERSION(4, 16, 0))
-					compound_dtor = UCHAR(addr + dtor_offset);
+					i.compound_dtor = UCHAR(addr + dtor_offset);
 				else if (info->kernel_version >= KERNEL_VERSION(4, 4, 0))
-					compound_dtor = USHORT(addr + dtor_offset);
+					i.compound_dtor = USHORT(addr + dtor_offset);
 				else
-					compound_dtor = ULONG(addr + dtor_offset);
+					i.compound_dtor = ULONG(addr + dtor_offset);
 			}
 check_order:
-			if ((compound_order >= sizeof(unsigned long) * 8)
-			    || ((pfn & ((1UL << compound_order) - 1)) != 0)) {
+			if ((i.compound_order >= sizeof(unsigned long) * 8)
+			    || ((pfn & ((1UL << i.compound_order) - 1)) != 0)) {
 				/* Invalid order */
-				compound_order = 0;
+				i.compound_order = 0;
 			}
 		}
 		if (OFFSET(page.compound_head) != NOT_FOUND_STRUCTURE)
-			compound_head = ULONG(pcache + OFFSET(page.compound_head));
+			i.compound_head = ULONG(pcache + OFFSET(page.compound_head));
 
 		if (OFFSET(page.private) != NOT_FOUND_STRUCTURE)
-			private = ULONG(pcache + OFFSET(page.private));
+			i.private = ULONG(pcache + OFFSET(page.private));
 
-		nr_pages = 1 << compound_order;
+		nr_pages = 1 << i.compound_order;
 		pfn_counter = NULL;
 
 		/*
 		 * Excludable compound tail pages must have already been excluded by
 		 * exclude_range(), don't need to check them here.
 		 */
-		if (compound_head & 1)
+		if (i.compound_head & 1)
 			continue;
 
 		/*
 		 * Include pages that specified by user via
 		 * makedumpfile extensions
 		 */
-		filter_pg = run_extension_callback(pfn, pcache);
+		filter_pg = run_extension_callback(pfn, pcache, &i);
 		if (filter_pg == PG_INCLUDE)
 			continue;
 
@@ -6646,14 +6647,14 @@ check_order:
 		 */
 		if ((info->dump_level & DL_EXCLUDE_FREE)
 		    && info->page_is_buddy
-		    && info->page_is_buddy(flags, _mapcount, private, _count)) {
+		    && info->page_is_buddy(i.flags, i._mapcount, i.private, i._count)) {
 			if ((ARRAY_LENGTH(zone.free_area) != NOT_FOUND_STRUCTURE) &&
-			    (private >= ARRAY_LENGTH(zone.free_area))) {
+			    (i.private >= ARRAY_LENGTH(zone.free_area))) {
 				MSG("WARNING: Invalid free page order: pfn=%llx, order=%lu, max order=%lu\n",
-				    pfn, private, ARRAY_LENGTH(zone.free_area) - 1);
+				    pfn, i.private, ARRAY_LENGTH(zone.free_area) - 1);
 				continue;
 			}
-			nr_pages = 1 << private;
+			nr_pages = 1 << i.private;
 			pfn_counter = &pfn_free;
 		}
 		/*
@@ -6663,7 +6664,7 @@ check_order:
 		 * accepted immediately without being on the list.
 		 */
 		else if ((info->dump_level & DL_EXCLUDE_FREE)
-			&& isUnaccepted(_mapcount)) {
+			&& isUnaccepted(i._mapcount)) {
 			nr_pages = 1 << (ARRAY_LENGTH(zone.free_area) - 1);
 			pfn_counter = &pfn_free;
 		}
@@ -6671,17 +6672,17 @@ check_order:
 		 * Exclude the non-private cache page.
 		 */
 		else if ((info->dump_level & DL_EXCLUDE_CACHE)
-		    && is_cache_page(flags)
-		    && !isPrivate(flags) && !isAnon(mapping, flags, _mapcount)) {
+		    && is_cache_page(i.flags)
+		    && !isPrivate(i.flags) && !isAnon(i.mapping, i.flags, i._mapcount)) {
 			pfn_counter = &pfn_cache;
 		}
 		/*
 		 * Exclude the cache page whether private or non-private.
 		 */
 		else if ((info->dump_level & DL_EXCLUDE_CACHE_PRI)
-		    && is_cache_page(flags)
-		    && !isAnon(mapping, flags, _mapcount)) {
-			if (isPrivate(flags))
+		    && is_cache_page(i.flags)
+		    && !isAnon(i.mapping, i.flags, i._mapcount)) {
+			if (isPrivate(i.flags))
 				pfn_counter = &pfn_cache_private;
 			else
 				pfn_counter = &pfn_cache;
@@ -6692,19 +6693,19 @@ check_order:
 		 *  - hugetlbfs pages
 		 */
 		else if ((info->dump_level & DL_EXCLUDE_USER_DATA)
-			 && (isAnon(mapping, flags, _mapcount) || isHugetlb(compound_dtor))) {
+			 && (isAnon(i.mapping, i.flags, i._mapcount) || isHugetlb(i.compound_dtor))) {
 			pfn_counter = &pfn_user;
 		}
 		/*
 		 * Exclude the hwpoison page.
 		 */
-		else if (isHWPOISON(flags)) {
+		else if (isHWPOISON(i.flags)) {
 			pfn_counter = &pfn_hwpoison;
 		}
 		/*
 		 * Exclude pages that are logically offline.
 		 */
-		else if (isOffline(flags, _mapcount)) {
+		else if (isOffline(i.flags, i._mapcount)) {
 			pfn_counter = &pfn_offline;
 		}
 		/*
diff --git a/makedumpfile.h b/makedumpfile.h
index 4f707c7..87f973d 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1507,6 +1507,22 @@ struct ppc64_vmemmap {
 	unsigned long		virt;
 };
 
+/* Per-page information determined during page filtering which may be useful
+ * to extensions making their decisions */
+struct pginfo {
+	unsigned long flags;
+	unsigned long mapping;
+	/* Present whenever OFFSET(page.private) != NOT_FOUND_STRUCTURE */
+	unsigned long private;
+	unsigned long compound_dtor;
+	/* Present whenever OFFSET(page.compound_head) != NOT_FOUND_STRUCTURE */
+	unsigned long compound_head;
+	unsigned int _count;
+	/* Present whenever OFFSET(page._mapcount) != NOT_FOUND_STRUCTURE */
+	unsigned int _mapcount;
+	unsigned int compound_order;
+};
+
 struct DumpInfo {
 	int32_t		kernel_version;      /* version of first kernel*/
 	struct timeval	timestamp;
-- 
2.52.0



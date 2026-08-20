Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC35C5DF87
	for <kexec@archiver.kernel.org>; Thu, 20 Aug 2026 23:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fjAmHZBrHwd1BbBXCKkwNQSKEg4EXTWljB1IKtXCKfQ=; b=w5Ulm3CnaTXQhi5qv8gdWCfQea
	iT8oeuKBSo8jBInRI+w1isVH7epOL8cHg2os0X9GypSMgH+0rxgk8Q6bl6FoUIN1pr2FMr1fmhpRy
	snJ3Q6aGyTzOSd6M/LNWOT7yML/1fmYgVUd6IO2ywD6vbL3Bu0A2JiH0cIeg7PpjkIiULkzhcSafY
	kP0QP1jkO3Yyy0mtBgEpDB1Sg+2ckjDlc2n4xrxKDiPCYtOQVXGJ97YwZImZBFeC3ikGd/30tB/72
	z6Uiavl6Va7x7+2T+5+b3WE3f63hfd8eA2sdRuSvAnA4WicVFaexMPtCNSl90N5enRsC20fK1c5Fq
	P9PSBtNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxCEQ-0000000CLDp-41Z3;
	Thu, 20 Aug 2026 23:31:34 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxCEM-0000000CLAg-2slO
	for kexec@lists.infradead.org;
	Thu, 20 Aug 2026 23:31:31 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KDSFn24119654;
	Thu, 20 Aug 2026 23:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fjAmHZBrHwd1BbBXCKkwNQSKEg4EXTWljB1IKtXCKfQ=; b=
	obZ8IfkJHl9hn4Yjh8jDAzI+xndnYmbeiOIv8xkgDOY/6P+tRmlDkkgrayr+Y3RO
	rfHBnWl19HFLkIOjvVNoZVkFkU0T80vLonIrSOYIs4I7+m0pF05GRffqOGW6Ei8D
	l8few4qWW+WoT/f4x/uEW726X1MSSClORQLl/ipv8yGlI33GBQAOTAAT5uFQTsAz
	nOzBRr46Iv0Qh4l4fRvqKoi7IL/dLu8dSRtfr9Dc1jp9U8M6qf4mYiscpMoSpyRa
	3/1Y7aaiKiDdLCteui5+uHVl63qJWDz2zkSy2PyAPs2FEZlzO+umZx+zPq9mH0S5
	yxhVXLRp+TdyasWxnt6r5w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g4yd9m7d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 23:31:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67KNKcK0007676;
	Thu, 20 Aug 2026 23:31:28 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013027.outbound.protection.outlook.com [40.93.201.27])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4g32htt71b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Aug 2026 23:31:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5ioLvZ9SW9cZPy7XfLwyqX5JFJrg+31h7qXiykreCNSkJ9AguCvx2eQCtNGi0Zsibj1v+qulwxwwz1jjpn5EzslMWL5PieWzOQj+VkhStHxHA6lH1exn3PKRbVYCJnH2Pm9/Tcu73/uKiffxISNKOMftKZnneQICZYsjuuUeDUPLUFJJBqp3ARXmFIls0iOV3f8scPX3yEr0nD9uXG4fKxbjGACd1DlQZkOJJYZ83JZGSYu6QiftM12zUo4sNtIuNq2AY6Kku17KhP6m8CQjDJNgdUIKcx1XQsBBD4ugflcU2lS1/F81JVvLJ1zwxwAgZN2Aa+bE+rJr4m5KlfN6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjAmHZBrHwd1BbBXCKkwNQSKEg4EXTWljB1IKtXCKfQ=;
 b=Sieprbt4ii0WHjcOJFfAcICzwMy468MRAiRrYmnecvt31XIP5VswVZh4jcbe05i+fC9W81T5UVjzRoaBGPpm6rg6566ZjQ5vHKkr5dh0OMiL+V21gBT8UGrfvfHa2uAl3638zp5b1Lj317lboXXr1QhkoEroP38NLULm2QH8u8garUVy8+28nEqWrYG6j5IP6eDrTNVSuobe5pNoBfb7Din1qUebLzmaxtgPo8fGqBS2wjb62h8GVPP8AoyaUn6HCapCmmEJVQkU+QowBGb87ApApXYmAi/FLfNCunEUmfwlS+GRen5A8Jnmm9L6JFBm0IdDK8g5cmtZX+pJAUk7ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjAmHZBrHwd1BbBXCKkwNQSKEg4EXTWljB1IKtXCKfQ=;
 b=te+ZbOGL0260/1/ZcBQ4J6iiIeOuMalgxkuN/qxjXp4tNud60RdTTh0KHDorBzKrKG9NFteUS1huX9uO+SOrYXpz6MtChIp9DnAWdCsmCHK9wENhRtKz5Pmuv2OhCIcZQlt+vTgcZHj2ILn/4gPzvZP6H2GNgnaa9x+47a32vhI=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by DM3PPFEABD4EF1B.namprd10.prod.outlook.com (2603:10b6:f:fc00::c53) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Thu, 20 Aug
 2026 23:31:25 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 23:31:25 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: k-hagio-ab@nec.com, kexec@lists.infradead.org
Cc: stephen.s.brennan@oracle.com, ltao@redhat.com
Subject: [PATCH makedumpfile v2 4/9] Introduce a stat for pages retained by extension
Date: Thu, 20 Aug 2026 16:31:09 -0700
Message-ID: <20260820233116.3105747-5-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260820233116.3105747-1-stephen.s.brennan@oracle.com>
References: <20260820233116.3105747-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH1PEPF00013309.namprd07.prod.outlook.com
 (2603:10b6:518:1::18) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|DM3PPFEABD4EF1B:EE_
X-MS-Office365-Filtering-Correlation-Id: 68b8af86-841f-49b2-e1a1-08deff1326bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: V9UIWp9EyDOBz9hEr1aOMfIqeCo/ZAhPYGwZneTvQMkO7WNjEkhpyFW/xEzMn4RjPYZkEV0hEYR4kTBfHEslj2agx6vAYWdDGvlI0YLmaJOXUKG9k/NiGZu/bMOpLkPNeQhaNk7IirCYoyZydHL5Oi7Yh0tzQt/JzwPxAGcnulN5SeA1EWV/5q5pg/XJhBLL/JmPjg4uk8ITfqIG3zgjRX1Dsg4kY4cT01nE1c+KWIJh7dGV1FyAvzT+EjJYYr8Yqt7CcWBOdeXpYeEGPZS3zx8b80vZOWG8oIx7DSr9Ibyg7Jk7vBis+UvxN33769qll+TBl99BqcjWLG2dvc+QyR4Ss8MeW8kzRurgM3xrAZGZ32naLmLKsNRz6LGp8aq9R3bT77e0AQ5pdxFJuRDpytYPvSYY0NnAqUzqru3LYX1JZHrXzUqOH/iAXGQ8/cft/Qu/UqQc5IvOZSS9oX/Dlx0+J0OOrAjWeI+CAGqvEVQtTN22vAJ5cpJIoMqFtXOJzYZp2cBMiKO13Ux25RlbGbd24hjtCg/DVrRAh8krEUbMb7M8AySbBoHClMG6/1VFEUutxY0kqB8cgnu94G5JuPgAaBaEG49HiJR9Gbo7vv4dhvzaGxw2OCGX4+td8+2Q4sOU3K3KTdJFv5IOAk5p7fExz/k0Bo75/wFgsnObegk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pCnKSH5AslI+RYCStFnYfBltggyJLQukJFhXrBI388959nLSo7Hrbd0ggxs8?=
 =?us-ascii?Q?dOMDLB3q2VaLcZOBZ+2YOulSxFRQEUNHYyRymlpTgMPJw8MCFc9U3Kof5sZM?=
 =?us-ascii?Q?+uP4XY9YmfBoUjhm8iAeWsUqFcIIucSX2akmDPoyBHgMczQ6rbCS+sXLH1nD?=
 =?us-ascii?Q?iCqAVwJ4K9WIsPFWgVUBUEQ2OrFY0QGyiWhc+Fqle2XTEdYu2eikw4KR8PWm?=
 =?us-ascii?Q?q5DBolh5mij38HEEc5yFzST+3uBDa8Tseb+Q03/6chbsM/0ikk4olZ+pUd6O?=
 =?us-ascii?Q?LcYLcE2aLSbLUv984A8aCbMEpXYvKrUO839S/J3AAkNhSx7pgdFwbIuW99u+?=
 =?us-ascii?Q?LJwXEmqO9dom3dURJNixLzRpcp7HyhQz77mZgpSleaTe93hZ+gtjxiVK+1E+?=
 =?us-ascii?Q?VMLldS/Qc4yvug0VsecBERiWlcA4RUWMmVzL20jTZtiTpWlmupwIYrpLVSYH?=
 =?us-ascii?Q?MGGQ8vgfsBK4wpiF/edHQnFZl7IiFrqEKil6R7ms6RUTzYpC3hXA4q4HDNg9?=
 =?us-ascii?Q?gE3mkReW+fFGRdNO6iaUst7zp3vOOdUI6Rs7v68mbwC/udrmvrhsr4U+AA0y?=
 =?us-ascii?Q?+vmrwgdbXYE+0Xu6YZt6raTtZ2X+wvxS4jk2RovObzinSwWL1L5erAuUOdCl?=
 =?us-ascii?Q?DAKPR6VDjHIve0i9Lnk41eIbzsqu9o5mlbLRwRKdBn+WUe+0dpw5Vbve5NMh?=
 =?us-ascii?Q?2lyv30CLprg8a1nTav8GvcsLaCv99m2TbQMo4PMrgrFhGFUtUBjX04ivC0uy?=
 =?us-ascii?Q?RfmxbebYrIrB44ulaMeMCKjNXIiEsyBtnQ5I9Gk+dJrMXeMk3xJY5Vw5vxj3?=
 =?us-ascii?Q?9HOnR6AJ5mHCqXO8hvpxOGO4O6ZzuWgHnk5fhmNlafD0XJ8X8UUgzsRi9dit?=
 =?us-ascii?Q?z7WiQ+ZGSUdoN93bR1ppqvJQr/Q4lOVdIzKXnmdmYUtKZcb+arfadzXvHgmF?=
 =?us-ascii?Q?5H1qSq5Jngj8fKs2nQHleYByUIV6N2drtQrboTaRqI89MeauDQmsDQQz8fJt?=
 =?us-ascii?Q?GPZk2s7Ew+oZPcR7VMCzegWaACkm0rFG/woKroNGeg2WsoYh9KzH2tqN3LET?=
 =?us-ascii?Q?tjLrODPaV32h16NXf7Je1fFFv6/TY0Z2fR6a1a3Ge92yIujRfr8HYkrXNwJN?=
 =?us-ascii?Q?qN9WdGUFSLCItJx5ff9qIshkrZnnWq467kGMuuesIKPRKduOraoQBVgZ28XW?=
 =?us-ascii?Q?CLCtM8zxA4jOycVrQ/fMwu4bGvHnEHxYZvUxgnFUUqPIYPxCUfgxXtSe/cCP?=
 =?us-ascii?Q?Db06CgQq+w7FdJ/oZ4t/4OdB+DnQ5X3Wwn4xoPxrXc6E+pQC/N6D/neXwQD6?=
 =?us-ascii?Q?odZbcKS2HLWrPLIWyc8ufTf+iwqZvfpZoeoRvj9VyyRrcvpqaZqTtFb26ms7?=
 =?us-ascii?Q?i5CA3fAanwfhet3fKOhFUcxdH5w7yTvFaWEK4K0v99FlTWgRQ0AFFQbLlqxB?=
 =?us-ascii?Q?1cs/PfQ1ulWL64YSBt2C4rfdL/D5et2zl5/6Wj5RSxFkrlh9iJeYJcBeTOJJ?=
 =?us-ascii?Q?vTFnE9/zbIR6wqKWN9cm/tdQBKO5Dg17VRTrz05DJ2qwPksnhwHN5jiknPfl?=
 =?us-ascii?Q?XbqWYSA4DQ+QH7AYKuLJKd++12VMdmihVIrRzVlivbDR7V7guN97AXhlsCOt?=
 =?us-ascii?Q?bcikfLcvJTcXC4E5ReDM8DF15Q/iUpN+hI6gqHCRAXgkJr7D6YXx4STgBb6l?=
 =?us-ascii?Q?mQGjhDiQOUcs74RVQjAAA/XbTq8aDpAMuGmG7eB99sA6hRaTEjzAaPvkvh+l?=
 =?us-ascii?Q?CkfEwAHsu5nA+/GJ5tHgpNTtgyO+OT4=3D?=
X-Exchange-RoutingPolicyChecked: Y8+poN1vfHaMtvzodPV/dpwgXgnJZMbZwzBsagaTQ6Wo1j1Pkm0AJxGx6xYKjbQ/ecoUeIt81C4Nko1piYKz/p+tRkrmN6OMMBF7Co9nBEMWGPHu47BT5jBZwyQ9PHGS1wtlbvjIpDbNA9Iva9uNHi2hf/4usYhkjJgIsqXy2GNCflReY8fPcMk7MBbsoZsDulqqSKx7aGI5yFn9ynhwnXVP7XkBUTnXkzKeKtjxbdKKcq12HgWAIEaq7H0+DclVAXht/LXm1PTHEy1yR13AwYDxVuMkmmi3ljvPcZrQboSdNoJ7IdHn6UmGdrboHakefqhx+gWx4HrXICdgFGrknA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FQVuvorLwUBEaVV9mz4P3ryOcsFc6VH+yBmHZecuWeLxDC+mWyAZdnejokInKOtPIT9vPsSY0WTLjQIDYAVHDoCKDZpgbE4wcVajnvPk6Vvt7Cqcz4CSBWSpnGbNFAiQdAPNN1hRAsvLv0ghSOPyPXSLd3GecAsSwpv+m+wIHn0JAvTrjyIKsrHPwisvbAYvt66sFYWL3hZwJ4zrEZmYbNePkarmcagq28UbbfZA6qiExRWPIIsDKOaPUZNCTiLWk9V/1TRCxWXW7wueMBJlkCLG6P1BlZV4rSSsHpNK5gvvemMpexggckEyKT2iT+IDO/hm+7VlxD8Ryc91mZ10bbvIAP23cfSFqVe1am5zJWM0JXOXhrlkFGrNmNHVQUxao+V2W4wg2H5YmuJjPzecouuag1024R3B6T0siZpdAs8TjIRBoAOCjlEP8uMMv9rlx2SrzOsyBlPHG9KMSGp6+7tk4SCWijJVqYBibz8DF1H9AlyVL7XACPBaqaI74edoykfPm+fuDbR59oukCyLshM/AICTzA9ZRWuqcGIsqdYg6W7y+ZLnvUG9mv/AlZrRTFe7Lc5X+jz6Y3LRc9NE+FhgiJzwLGvLyvYHwx04j62o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b8af86-841f-49b2-e1a1-08deff1326bd
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 23:31:25.4720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MgbIwzhDRyb1UXB9CkofuTtzGmBnkjEJc3Ji3rzJaeNKTRIq5DlU94h0Lx7Mg+gLDwVDn+BRnxNEwVGdmxvm/h4fO0pL/H8AzKBvtITd2WY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFEABD4EF1B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_03,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 suspectscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608200174
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE3NCBTYWx0ZWRfX6nnuDgQh544D
 wY+Uu8p2vCoV9vrg7lr/IAnQtwfHFxRziMfMkyLgSu27YmGhX5HblqEeGuztDHG0BmyAv43TECK
 ReAwnUAfZhRi27DkXGcmNICBfrIyI75CxKr4CqD76IngwPU28bvVchIDhdpmX6eeVoRilyufhLC
 SYPPUxCubOji9BuW9zU1+5MfXB2bULrB4h8C4cS9IK0HOvAqZDD8ni+kRO2y1/i4A7+GgTbCtmU
 ALquruLz413tWEvsMcVfuAWLNZOiMA8s69viauYSbDzyEf4vg4/YKJQi4o5f9RY8lWJCQ7+l7W9
 A8bxpkOPFNBY8rrF6dcDK9Xbg61uN28oa99jsp6m0bIWt3ihI5CexvFTGKhf0PI8hOIccmS6h31
 RtU3Uob86mPzSieIVJTJQG4TWj5yWL4Ejxx+barj3ZqgcvIO7BJU36cpt/TflJi80xCgkbDPLgX
 wxFfCATh3xfXP0zu32duQNkDTqaxICRrzzd0aXiw=
X-Authority-Analysis: v=2.4 cv=a7wAM0SF c=1 sm=1 tr=0 ts=6a878e52 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=NFN8SqXP0gmw7mKU_zEA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12102
X-Proofpoint-GUID: iKuid5GPJeeDaDSzh8AWSWw_xkIw7jqJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE3NCBTYWx0ZWRfX0VZH9yncFmZn
 iNL6bWyQ8g+viU+iQKzI8ZvBYO+XpAKeiuQZLDXVYBzG+q2h6yetL4YGjjJ7BaaMWBcPl2S92YI
 nnZokF/PRvdK0n5/gPszeAkpxbfTlYlWggsCv6tEVcbyTNZuoXKn
X-Proofpoint-ORIG-GUID: iKuid5GPJeeDaDSzh8AWSWw_xkIw7jqJ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260820_163130_789172_C9C89ED9 
X-CRM114-Status: GOOD (  17.94  )
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

Extensions can mark pages to be excluded, but those pages may already be
excluded due to the dump level. We have a statistic to count pages
excluded by extensions. It counts only pages which were excluded because
no other criteria excluded them.

Extensions can mark pages to be retained, but there is no statistic to
count them. Adding a counter to the code as-is would not give us the
value that we care about. Just as above, pages marked for inclusion may
have been included anyway due to the dump-level configuration. The most
useful statistic is the one that tells us how many pages were included
by the extension, which would not have been included otherwise.

Introduce a statistic that counts this amount.  To do so, we have to
skip the short-circuit evaluation when PG_INCLUDE is returned. This
seems like a worthwhile trade-off, since the dump-level checks are all
reasonably efficient.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 makedumpfile.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index e3a4a6f..fca42e1 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -106,6 +106,7 @@ mdf_pfn_t pfn_elf_excluded;
 mdf_pfn_t pfn_extension;
 
 mdf_pfn_t num_dumped;
+mdf_pfn_t num_extension_retained;
 
 int retcd = FAILED;	/* return code */
 
@@ -6638,8 +6639,6 @@ check_order:
 		 * makedumpfile extensions
 		 */
 		filter_pg = run_extension_callback(pfn, pcache, &i);
-		if (filter_pg == PG_INCLUDE)
-			continue;
 
 		/*
 		 * Exclude the free page managed by a buddy
@@ -6721,6 +6720,13 @@ check_order:
 		else
 			continue;
 
+		if (filter_pg == PG_INCLUDE) {
+			/* Account pages which would have been excluded, but were
+			 * retained by an extension. */
+			num_extension_retained += nr_pages;
+			continue;
+		}
+
 		/*
 		 * Execute exclusion
 		 */
@@ -8264,6 +8270,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 	if (info->flag_cyclic) {
 		pfn_zero = pfn_cache = pfn_cache_private = 0;
 		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = pfn_extension = 0;
+		num_extension_retained = 0;
 		pfn_memhole = info->max_mapnr;
 	}
 
@@ -9609,6 +9616,7 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 		 */
 		pfn_zero = pfn_cache = pfn_cache_private = 0;
 		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = pfn_extension = 0;
+		num_extension_retained = 0;
 		pfn_memhole = info->max_mapnr;
 
 		/*
@@ -10576,6 +10584,7 @@ print_report(void)
 	REPORT_MSG("    Extension filter pages  : 0x%016llx\n", pfn_extension);
 	REPORT_MSG("  Remaining pages  : 0x%016llx\n",
 	    pfn_original - pfn_excluded);
+	REPORT_MSG("    Extension retain pages  : 0x%016llx\n", num_extension_retained);
 
 	if (info->flag_elf_dumpfile) {
 		REPORT_MSG("     in ELF format : 0x%016llx\n",
-- 
2.52.0



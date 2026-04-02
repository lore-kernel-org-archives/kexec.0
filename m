Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD18D6AB1B
	for <kexec@archiver.kernel.org>; Thu,  2 Apr 2026 23:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pn2X97y+SUrxqfPN9Xl/2Y5j3N2z1+5e/BHCpZgfVJg=; b=C8L9l8xGewEHOV1bR6I/vw9FUJ
	6C+NF0SoBfYZjfV3xQXIMI7CsI/LlaLZc+KrSIYJmp4A5WgvvQpxfh3Ror0BsycwXQp1w6AGb8NEM
	nUz+vGwQWcXgkUI95HgJJz5GYPEyUhaDjAh1uOhlQYqR3WkQ7abRVtinCWwv4G/dnvdjZafGbCP94
	1Qu/puds/ZNP7r3DBV/XnME0rxUg9xkyIIRwIwpnqvshM5T9wzsJqJJt3EEw1zKsHwlnoK6WSykuC
	a9B6VyYkv/Cknb043T4BY8xd8ZFFnOSGqcUcy60BWWWOCFBqXDEIftCmoemlTmvzjxSW3uXLFiXM6
	X1XIeyaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8Rtp-00000000xRs-1Afx;
	Thu, 02 Apr 2026 23:56:33 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8Rtn-00000000xRS-033F
	for kexec@lists.infradead.org;
	Thu, 02 Apr 2026 23:56:32 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632MpWGZ3671364;
	Thu, 2 Apr 2026 23:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=pn2X97y+SUrxqfPN9X
	l/2Y5j3N2z1+5e/BHCpZgfVJg=; b=WOX/t5M1rC0QZJZbLzgUmeYutR8DmMSD8N
	O92IkaT3DgMMvJVtXZKV337YowBsC2iaslOPeRr6D0771lR9cQVVR1IiiIWHXk0N
	SO/kQbUKYshjRnSrqydm7IYbQM6y6CwdjHjmiAGMe3tNwbiRh2kU+vApudws+w64
	reo3eXmUhoWBdHY5oGEbknVFog3XM9R/R81vm+QWZyo+h7Heycnfs2gHpTX7r4yd
	RGIUveh/McWiWw4f1AvOZQnbHWcdJWXJLuuFuvcuJhysB0eXtcDr0PEmTtCSdolH
	7qAL2uTuxjsdZ6Jx1Ov/vm/uRMbNP4ZcmB3NaM02YTnVPkHX2EIg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d65s11dwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Apr 2026 23:56:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 632KonA3008483;
	Thu, 2 Apr 2026 23:56:28 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011000.outbound.protection.outlook.com [40.107.208.0])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d65ekn8hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Apr 2026 23:56:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUZzIZ+ajzIHmIZ3/Rg79VbFl/daiSqwjXMV0SU+MQx/UCOyIX5qi703T1zoyVhNy3ZHx5cxLkNPTbaIEoBrVGqSCaPle9zJ2nyAc03u8xJZXbY/ttCJCafwE+vjFCr1N8arN4nBXiMianpJ1bstyWie6O6A/RjnIhvf6VZwOKwqFw3vR18U6AI91jY5HvMrYjZPt/iFLLx6QNPHnfnZUMc3dA+YMgkz9WFgXWOGrWaz0FolWWnxBHFehovB0Rpo/UngAVdlDt3/T77I0O8VcIJ/eUb6m4qN8fnNsJUErp+CVn9e1mjM98ZsjXqxEksqMbjMd1OMYf8reUrznfGklQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pn2X97y+SUrxqfPN9Xl/2Y5j3N2z1+5e/BHCpZgfVJg=;
 b=Yss77QErl8sD82qnExRXxOoXLI0IjNu4WizXAGQJ52uRJWFikIP3DM2SYi6NAw6lWYeU7/8JqE3jMZc6QIfJ7dW61P9hYkU0EyBNMXqxEBD2Pcebk2SaQirBU3i6gkuYBUg9cu1rCqgW/1+BiqPNsQBr0P59ntpVHmZXAhy577co2g+lI3wq82qykrv7BVEaoSi6+w2aQ8KQgitDouapvzukuWbqeWHTQ5KS829fTLd05+XGO3f2ueJ5u8WFhbe+sJOLZlZwe3LGVw3jOOMvCKJy8SBGQdDClnxKBFzmuSmWK36V1dgUi9rW2JR4GyKkYNOY1abxNKCnwLyuwZNG+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pn2X97y+SUrxqfPN9Xl/2Y5j3N2z1+5e/BHCpZgfVJg=;
 b=W1L4u5TlR2KOX3BI3p+sIGeiKaFJGTSpA7o3y3ddCFlEM5qYibX+Fni22eqbFJ/82r+QYxsN3AneE9grs3Mm06673WzlZYDJT4Qfkq76E9LYEm/2t42pdQR7hcjyPxGYycAAjlvATsMXPJ2+onJ3tSAS5p6by/xV2r6TjiF48yU=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by SA1PR10MB6295.namprd10.prod.outlook.com (2603:10b6:806:252::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 23:56:22 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 23:56:22 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Tao Liu <ltao@redhat.com>, yamazaki-msmt@nec.com, k-hagio-ab@nec.com,
        kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCH v4][makedumpfile 5/7] Implement kernel module's btf
 resolving
In-Reply-To: <20260317150743.69590-6-ltao@redhat.com>
References: <20260317150743.69590-1-ltao@redhat.com>
 <20260317150743.69590-6-ltao@redhat.com>
Date: Thu, 02 Apr 2026 16:56:20 -0700
Message-ID: <87tstsex23.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0233.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::28) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|SA1PR10MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: aadb274c-a3d1-400b-8fc8-08de91137144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: uEslD5KUG0Pwf4bLZo35RPwdMjAT/5Rwl0siu74QkZ3m/tvoBXaArieyre693dsqV2iknGtZoZ9A8x1ok7gYjYY0bpHNdBPJ/1+c3nFkJk2wqLKaRQ1N6kIm6vNxrs3Db4o8Qb92fVxA9PuWs3mo5PCUdDkrIdvlsOOOvEtnFGiY/rUh9I3GaOnbuj/H2sBCasfaquf09zwuTCEX/XMIUj1BW/3WITHQmjdTFr6CC/GoTBgTtyyHL24u0WmunQOBNwPDaFd/JPF8lmABH625gTLqdPS7zqb8AZZmiQXiHyxqrZ7FZ/lPjVRZGMIC4Emt7Tvi1tZohZRNPZgPW402KSRycl/RBA4lih1aUrJacRprdUfyJy/BsB7UZlRnqEGnlgWuqTZ7wu7EV9pfVnyqPR9Afq5ISYC2ZoJT7dOnBUKuqlGiys2cyRRRCgZ91NC5659chkcoUtKVeV1R0M4gxVGk6Go/fhLMDHDxd/Nha7CLNSIbTyxe1Iq7B7QSgjgIkqki/TrGLABzONXbGneMNBdcu6HO6KRzGJjX0PDizQ1HDJZTyBUuPcm0QJEEgx1WMubexMGxkh47TwFPhXPmRlROC90qSYsGeNswIa+CfQ9MRD2gg3zAZuyIm99PF6yF/U2jV4S3NbOgi0PJAhGHzhx2Mrpi4aw+u8YWxYeasg7lvCqraw7jUl/xzSWIimRyOrGLUOUrlFgXps3m5NqpWkEcnYGZAa4HUBxDlsA9HDg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JYU+3Bh9e25sSRilbLCCC3P9H3+5VqpsJOpSoBq0hjTbR1GjgL7lYtCm2CeR?=
 =?us-ascii?Q?qF+oPK83ORPujTr1CfpZd9ffiG8v0ELdE/6wPLE/yguSzAnB7l3jQ2r99hLL?=
 =?us-ascii?Q?sSGstoC2FbqtK16H88SurmKR8lCNuhMsNisJeKldH43bPpRQh0uJHeCUiNS6?=
 =?us-ascii?Q?pkl3qMfAYuonGd+JMclF6IXIVUmWKh/oQaMh3a920O8hRE+7GjMsnoDtPO6x?=
 =?us-ascii?Q?MufmN0JVO910WrEaCKB71pKSxvg0w/wgsf3UMLxAzw/yQ8j48mItL0NlEWYb?=
 =?us-ascii?Q?c28gmRkqHhR/jBWzT/X6KhA7epnF0Jsl/KqwLkplxT+iD9z344eQ231RVO7p?=
 =?us-ascii?Q?+Ftzf2fMXtv4P6LbTILl91t29JUNEmhfToY30S5o/WCGg3EJXg2lFiJCv+UG?=
 =?us-ascii?Q?V+ZQenyhYEf8mY8SAnY8Cwy+W8oBaWd210bgNt9lM7swdKBQu4RjI+OXobUf?=
 =?us-ascii?Q?K0ShakDTeFqPZxrAy17qCmwUt8vMd8lOV+cukSmz5z9lIvdeNkdBGioHScFT?=
 =?us-ascii?Q?lbPpWWZX4LbfGFvj14lJ9zGH/EOTrCglKwcZBPYmhgwmUXYuJoA3uInIsnS0?=
 =?us-ascii?Q?zHvzkCDj8PSDJTjUyZvZeJ+HIp0XqFs7p3lAIJKIHEE8GfziJA8ShpvKf31L?=
 =?us-ascii?Q?NVzQvfVaFY/2+c4l7DMAWA8eedHp3H52ynXRKK4p3MGh4dA7w+H+6gKUFfBM?=
 =?us-ascii?Q?b2g/HMXkv73u25o9DkaungK0UKRgxN359+I4g2/jpqMezEXJjT/4aVGSvNuY?=
 =?us-ascii?Q?tR4DpInLJGx4sJFFVixefn/NOesHQ9QlyTvjKQ6b7S+Bc0i3I/lkSCr+t56F?=
 =?us-ascii?Q?UXu2eUpZtgx17DLxh//bZiTSJL1I+0iW82lFMGxZYoaquVq1/yFgA2ixS73h?=
 =?us-ascii?Q?AKf7WkgOV2uB5ExXWR0xZoNZ3R8c1jOFqxRpkiSzX0YqSeRG3sEsYnZjGV/h?=
 =?us-ascii?Q?2wmSIow3bQyuoek4tC7k9KHVrgn6d5DRibTO+2lWbffdjZClALQV0fQG314m?=
 =?us-ascii?Q?YG7hChhjdlH8/IXKjowHqlRJq4NA34Er3cid68G0o8r2nTYHRDgWUArB56eg?=
 =?us-ascii?Q?oHiod1M4OUHpGPjTfaxcInYEkdceU++mwxd1OXp/QVZsABnvk9WnrpVXhmh4?=
 =?us-ascii?Q?+/nt+GDqAl+n88bCZCgvout0lEYpP1Ir0Yz+k/+sbOtgxt58AKvDPqnZKikz?=
 =?us-ascii?Q?Uw1bZp2t9etzHtklaqPNl3JxzUWfiicZMCkK86z02uHq22bDcDxSvpbX3T6W?=
 =?us-ascii?Q?kkIG3zNpJ5JTD1pll3ps3VA7DBthL3L2UfaoFknyDCjcyh8/rAhIvPhIS6il?=
 =?us-ascii?Q?Q7oRqZn09mUQy0DZL9A7UO8juCB+HeqTvtwAQ8mI6hlUMGFBKeC/TiFmYCC4?=
 =?us-ascii?Q?U1dW890PM3yZy9XCvZd6ujyJx4ETH+BMyWjL5mI998Y1vHtWI6dMH5RRyCdX?=
 =?us-ascii?Q?wd9jtk6vBfxfiJiz6j201WIGGdu+KRuRUDGrtkz3BWGvnUK0S270dUOfyHy2?=
 =?us-ascii?Q?dK7NhAQCgO5kxvhV+vJIfSVtUm6cFtRsAt63ErNH7wCBbqV4R1lYRP4hRqtd?=
 =?us-ascii?Q?LlgkMnInW3mSsjenbY1NYZEzBn+XrH6OT2v707FDfTFR+gy+ZoAv3kdFWX4v?=
 =?us-ascii?Q?eRDOKi1771hevH6alBRPhIGjc4RKOHYoVQ/PD9Y9/bqnmugZaSUcMixoe/Nd?=
 =?us-ascii?Q?zdR50num46T+VTTHH/SZBGmzO5eejtdi3mRHYtN5AZq7jQejNypsKKvKRXi1?=
 =?us-ascii?Q?PmzlHUTJMfp7OSbZE5PrjqRAvvO4oQw=3D?=
X-Exchange-RoutingPolicyChecked: KxUV5d6okGBMXwtFniNTxmz7E41A5VAKizzgVDkTBcjIUJ6gJSYAHBinIra4kBwBUjeX4v/kTSxIFZrZkdPMUHlAwgBwTb7lqJqfcTjrZ+Tv0v22EGSCO9lp5V1KJgzcFxXPoCtCi0ZqeSLepquw47uu5FB4l/PvE4qrCBaK0r7w/3DGImy+zBkvoirz0m51qlwLgG9sRlqKHqGdNo2zlwYrrirX3s9Dk+ePiWJQyxqczNHkKva6XYkPQZNy578YcyEcFn7yMUt+XSTdEdYnW0N7ED4PXUohaESgutrXeGhXEugF1sGMDYjB0VKSR2GtEJhip+zC37/0j5fdNEvmKQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: um2aplBm5Wz1kYML52eQF68WYRwyW7Pztht/fk5OJULM2ZQJGR+opQ/mPpGjD3DpEELCzxqgsCNP9Cuj2NfsW+0olRR0JVnyTWnbsMOu10VgXfz7CzNxY3es9zwhnbQMMz/fuR2WB4eB6PO3zZOPyvj+czROEnnidZU/0khpxhCx4Fm3IcsvgIFcoQCl7pCOqFLxhb81eK6QDj/jR4qnCnVJUIA38R9Hu3wikix2TlrPYxXkYQPyWSKDjU6bselFEX4JQ3QNPEKw/eUtgrWEjJd/tyU+qp+ev/CJOeOYneG5v0s9p9MeOW7v1LmKagQ8CP9ECG1COjFIWI5XAMn1QJJM2T9/Nl9nkJSkb8frQ/7v7fFgBWBtNPh0pljuSPlHB0VizyTfBzAgSjjrypmuz0QQn1MhQHzKI6oBRRqmIUOW1Am6oahrZfQQjm52DiH6fvrdGeXyP0KhGR5TMe6BckFP8rLUdDUjRrYiUeReT1cHqRk/oTHG40hROYIjfK7BFbdV/H5l164PBjvbZ7DYBmGGjPTa3U1p3wjTkDmNvFoVLgwPlA/N67a6iCkN+ASlo/7YFvlNU2uz4KfLHU/6Gl5s2o9PftZTZQrDPEjD6hM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aadb274c-a3d1-400b-8fc8-08de91137144
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 23:56:22.5856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1IaLqVXtAsYzeWIR1jfg1Rt+hH3yBDfYlBq/mk2skGnnFG7v7OS2Mt785V2LZm0i/8wWrYwq9ocUJcH2LXs0xLhD8qzm7UubiRn2YAyhNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6295
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2604020213
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDIxNCBTYWx0ZWRfX8ynHyLya6pcr
 hSzgSSZ41vhAIA+IgcNFNOCDCSWYBUi0kFzHTt4LjrZaoChGm+vZ1uAYsiF9Po6qr3lighpOiVa
 nwiE5aRh7eI+ECfMzjCCBgsXfQgNxrqxpBd+F4TRTqPIsOeykOcuZbfYgMZnS5Fsm7nQ7uIcXC9
 KRKoAydmm+N3uWzYReDE9EfkS7361BQaxoRfCNy9SAxLbjFgQrUC5QQphDCEcDHSey+iDSpDcN1
 kZFrRMkLVxRtqTTEArRPmC+j80GlIbqMjQd5q4pvkz4BAJ7JKFON3G5MObxXexs0QioSjc+lI+9
 oZ8Q2ILdyZEErJ3FdUmd54rB237k+YAKcU2SkTtg5XrCh9GWdCPPX/9E1WohIwZ+zPfepdnUTXz
 R8Uo3cY6Cd7T5G3CpB09s5cA0cEcj/FI0+uWPiGqB0zujZtutZCgsjNZE3NtNIGbBEYiLfpelH7
 peeNCDzRg/XYAu/TJZlyzi/hbDLL8LEH3YmLW244=
X-Proofpoint-ORIG-GUID: ubdAX6AXPWsFLs1jkKFMWJFuRCMWliEr
X-Authority-Analysis: v=2.4 cv=BvOQAIX5 c=1 sm=1 tr=0 ts=69cf022c b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=kgFFi-R-R_NUZgvpW_kA:9 cc=ntf awl=host:12291
X-Proofpoint-GUID: ubdAX6AXPWsFLs1jkKFMWJFuRCMWliEr
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260402_165631_199652_1D8A99F4 
X-CRM114-Status: GOOD (  22.29  )
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

> Same as the previous patch, with kernel's kallsyms and btf ready,
> we can locate and iterate all kernel modules' btf data. So kernel
> modules' types specified within .init_ksyms section will be resolved.
>
> Suggested-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> Signed-off-by: Tao Liu <ltao@redhat.com>

Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>

> ---
>  btf_info.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  btf_info.h |   2 +
>  2 files changed, 115 insertions(+), 1 deletion(-)
>
> diff --git a/btf_info.c b/btf_info.c
> index 1cb66e2..7682a82 100644
> --- a/btf_info.c
> +++ b/btf_info.c
> @@ -230,4 +230,116 @@ out:
>  	if (buf)
>  		free(buf);
>  	return ret;
> -}
> \ No newline at end of file
> +}
> +
> +INIT_KERN_SYM(btf_modules);
> +
> +INIT_KERN_STRUCT_MEMBER(btf_module, list);
> +INIT_KERN_STRUCT_MEMBER(btf_module, btf);
> +INIT_KERN_STRUCT_MEMBER(btf_module, module);
> +DECLARE_KERN_STRUCT_MEMBER(module, name);
> +INIT_KERN_STRUCT_MEMBER(btf, data);
> +INIT_KERN_STRUCT_MEMBER(btf, data_size);
> +
> +#define MEMBER_OFF(S, M) \
> +	GET_KERN_STRUCT_MEMBER_MOFF(S, M) / 8
> +
> +bool init_module_btf(void)
> +{
> +	struct btf *btf_mod;
> +	uint64_t btf_modules, list;
> +	uint64_t btf = 0, data = 0, module = 0;
> +	int data_size = 0;
> +	bool ret = false;
> +	char *btf_buf = NULL;
> +	char *modname = NULL;
> +	struct ktype_info **p;
> +
> +	btf_modules = GET_KERN_SYM(btf_modules);
> +	if (!KERN_SYM_EXIST(btf_modules))
> +		/* Maybe module is not enabled, this is not an error */
> +		return true;
> +
> +	if (!KERN_STRUCT_MEMBER_EXIST(btf_module, list) ||
> +	    !KERN_STRUCT_MEMBER_EXIST(btf_module, btf) ||
> +	    !KERN_STRUCT_MEMBER_EXIST(btf_module, module) ||
> +	    !KERN_STRUCT_MEMBER_EXIST(btf, data) ||
> +	    !KERN_STRUCT_MEMBER_EXIST(btf, data_size)) {
> +		/* Fail when module enabled but any required types not found */
> +		fprintf(stderr, "%s: Missing required btf syms/types!", __func__);
> +		goto out;
> +	}
> +
> +	modname = (char *)malloc(GET_KERN_STRUCT_MEMBER_MSIZE(module, name));
> +	if (!modname)
> +		goto no_mem;
> +
> +	for (list = next_list(btf_modules); list != btf_modules; list = next_list(list)) {
> +		readmem(VADDR, list - MEMBER_OFF(btf_module, list) +
> +				MEMBER_OFF(btf_module, btf),
> +			&btf, GET_KERN_STRUCT_MEMBER_MSIZE(btf_module, btf));
> +		readmem(VADDR, list - MEMBER_OFF(btf_module, list) +
> +				MEMBER_OFF(btf_module, module),
> +			&module, GET_KERN_STRUCT_MEMBER_MSIZE(btf_module, module));
> +		readmem(VADDR, module + MEMBER_OFF(module, name),
> +			modname, GET_KERN_STRUCT_MEMBER_MSIZE(module, name));
> +		if (!check_ktypes_require_modname(modname, NULL)) {
> +			continue;
> +		}
> +		readmem(VADDR, btf + MEMBER_OFF(btf, data),
> +			&data, GET_KERN_STRUCT_MEMBER_MSIZE(btf, data));
> +		readmem(VADDR, btf + MEMBER_OFF(btf, data_size),
> +			&data_size, GET_KERN_STRUCT_MEMBER_MSIZE(btf, data_size));
> +		btf_buf = (char *)malloc(data_size);
> +		if (!btf_buf)
> +			goto no_mem;
> +		readmem(VADDR, data, btf_buf, data_size);
> +		btf_mod = btf__new_split(btf_buf, data_size, btf_arr[0]->btf);
> +		free(btf_buf);
> +		if (libbpf_get_error(btf_mod) != 0 ||
> +		    add_to_btf_arr(btf_mod, strdup(modname)) == false) {
> +			fprintf(stderr, "%s: init %s btf fail\n", __func__, modname);
> +			goto out;
> +		}
> +	}
> +
> +	/* OK, we have loaded all needed modules's btf, now resolve the types */
> +	for (int i = 0; i < sr_len; i++) {
> +		for (p = (struct ktype_info **)(sr[i]->start);
> +		     p < (struct ktype_info **)(sr[i]->stop);
> +		     p++)
> +			get_ktype_info(*p, NULL);
> +	}
> +
> +	ret = true;
> +	goto out;
> +
> +no_mem:
> +	fprintf(stderr, "%s: Not enough memory!\n", __func__);
> +out:
> +	if (modname)
> +		free(modname);
> +	return ret;
> +}
> +
> +static void cleanup_btf_arr(void)
> +{
> +	for (int i = 0; i < btf_arr_len; i++) {
> +		free(btf_arr[i]->module);
> +		btf__free(btf_arr[i]->btf);
> +		free(btf_arr[i]);
> +	}
> +	if (btf_arr) {
> +		free(btf_arr);
> +		btf_arr = NULL;
> +	}
> +	btf_arr_len = 0;
> +	btf_arr_cap = 0;
> +}
> +
> +void cleanup_btf(void)
> +{
> +	cleanup_btf_arr();
> +	cleanup_ktypes_section_range();
> +	cleanup_ktypes_modname();
> +}
> diff --git a/btf_info.h b/btf_info.h
> index 2cf6b07..b7f6810 100644
> --- a/btf_info.h
> +++ b/btf_info.h
> @@ -22,6 +22,8 @@ struct ktype_info {
>  bool check_ktypes_require_modname(char *modname, int *total);
>  bool register_ktype_section(char *start, char *stop);
>  bool init_kernel_btf(void);
> +bool init_module_btf(void);
> +void cleanup_btf(void);
>  
>  #define QUATE(x) #x
>  #define INIT_MOD_STRUCT_MEMBER_RQD(MOD, S, M, R)			\
> -- 
> 2.47.0


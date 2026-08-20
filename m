Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C69C5DF8C
	for <kexec@archiver.kernel.org>; Thu, 20 Aug 2026 23:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KS2lQGeXChOUwTdLfpOwBgoqWW3tJZkV77Z6SaagBv4=; b=4ld/moItiwml4uBSslRj4yzO6L
	mzWiOAw3zfCBpQfXjJY30WqfH1VS4PuZ66Ot0vSfh/Ipw3UbvL7nJkcjSCtP/psYsmUEAEDoGjHHm
	5IJloLhY2Rt7O8gtuVzZBIn4KmpIXFr7zOeh6W+zGYChgQBhV6/y8BwFtl6BN9aEwqOncXC5CcjOk
	lAz+3X/14rHIszQDspwYOKlKopKNdcX2GZbaFeCLQcFsc+BUXpf/aoDx53fzf+U4bnJ8maPSnSgt3
	JLXbqzppGF2ePd4u1Q8iuf25hSwpJF3qNo0wzPe3b0shIz0lZzu2aapTqbRDxnJCjC2MWKxtFcGvp
	OgP0XBvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxCES-0000000CLF9-0YCn;
	Thu, 20 Aug 2026 23:31:36 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxCEO-0000000CLBz-220O
	for kexec@lists.infradead.org;
	Thu, 20 Aug 2026 23:31:34 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KDUNfN512851;
	Thu, 20 Aug 2026 23:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KS2lQGeXChOUwTdLfpOwBgoqWW3tJZkV77Z6SaagBv4=; b=
	GVN0DBeTKZ8hvykyJvwbI05Qz/nkK1jE1Ud1wpaSILCx57fX9HlhSEPFnnpCok7p
	lNvU0xzY0vky8T5RA8UKcTS6ECVQbtV5bpz330u2VcJUcWOzUF35xjImhtAFmmHb
	T1R8VecDppAZw0xNpMvDpHyQjdGYoDyyQwEmspFrz77iutWcwL5zBk7wttFrhn20
	nBLQgCwwB59osEvU1wRiKkqzSykCtkgsQ/EDOw3mXj2w4VgEV/a/9qrKxLlUQ9HK
	plNTV1RDw3YkXZWQeNoQhqAskgeL/gaf53pIShcw9U9rtIP66HvMcZlwfvR6DwzG
	d7WBgmsBXtyy1tFccYxE/A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g4ydb48bs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 23:31:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67KNUa3b013648;
	Thu, 20 Aug 2026 23:31:30 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010066.outbound.protection.outlook.com [40.93.198.66])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4g2ejttyeb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Aug 2026 23:31:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSFpIPrQFuTyWzpoY2JjU9IHuGouT55smBIvM91eNit7prQYRqbrSTVx4VbEV8ervYv086SM3i/gXQit6HpKs4xrhhyxnJdzo+wT6NTfCQVC+plAEnVmU0wDhyJ2KOjc45sJ0o6hkq9tbFoFJz6oLnNJkbIZzIVF9UERlfFxpkvePK8SSRIFwhWTXpRcALlBNOho1hdmpSyuNE+K9s0b5x3k9OQ6JYHvZQ5/Ct/NZSkyTEKFkUAb5RjQpd1In451IrYJNlz7JkjpEKy68Xvdm6OL2+gA5PTv7xEB9vbv6aLjRH53muB03L5XrOWevME2Fpu3mgSbPrDWDk6ox7wI1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KS2lQGeXChOUwTdLfpOwBgoqWW3tJZkV77Z6SaagBv4=;
 b=NelWMa7CeybJFtfvLs2+nluqY8LLi8jDTAzddOgjhRLg8hTnV4Ln0pV0aw1jmb7HKFuLFvv4WlMKitOaHtk1LuNWpNUld7g26/HpCnUW0YBacgPgI7ofOlwfXBhPdR23AdC0yVeDNSKJlQHTQO4QydnKMkRwRSWvJJqpau6OakmFJhcf9+AJpUHBnGTqJtlWJcssffFBCosDsemibR/8YJ5TJ9KezsZBffiQBcarRClFFgm+zdgx6Ry064tbGkOjmCz1qU9T3loNBOE1cZ4KEUL4D1UShqEH2WwW76KrY9EYvR2yTOlG/a4Ut594+4b+pl8/mQV3ANJF5U8vmSBpQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KS2lQGeXChOUwTdLfpOwBgoqWW3tJZkV77Z6SaagBv4=;
 b=sHjzBZTk0HzRMRsIF4wlTodYa7A3BvYi8lTBmKKjPnmvkhTefp04DJlOIED6LzOnlXEZBy/qVtx6ijUnxiONQnkORM1CUtuPeXyRf/Nae6xoSPr3mfoOOqkA4wLn3TKza5YLdDtwbia7b60jOQxxq2SNQ1R/Uk9Vhu4W08SP6XU=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by DM3PPFEABD4EF1B.namprd10.prod.outlook.com (2603:10b6:f:fc00::c53) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Thu, 20 Aug
 2026 23:31:27 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 23:31:27 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: k-hagio-ab@nec.com, kexec@lists.infradead.org
Cc: stephen.s.brennan@oracle.com, ltao@redhat.com
Subject: [PATCH makedumpfile v2 5/9] Move page checks into makedumpfile.h
Date: Thu, 20 Aug 2026 16:31:10 -0700
Message-ID: <20260820233116.3105747-6-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260820233116.3105747-1-stephen.s.brennan@oracle.com>
References: <20260820233116.3105747-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:510:33d::9) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|DM3PPFEABD4EF1B:EE_
X-MS-Office365-Filtering-Correlation-Id: 47e81f43-da23-46c1-e17d-08deff1327d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TCQfrj19RxeXhLINeCrYs74TN3/8nhVWQhNe1dlmcnxXZZi2fhiib1/uXNblPpzycFelGdh+2ZgM52+u/HkBWsYr2BHL7E/3bIc1znaMOwTV02NQdKMJWQHnI2F8aA7fOoSZ87lQRMIlcY7+ZZP7Is0eg7Co5VYjzomXrVjHajv6DAxun5ETNXOIZkrKiRc9r/D8NiQEp5oCIS9n4j7mvgG2oQ3yVOP8kdCkY+Dt67jOPamyzjPSutSruXFJNGL7WNpQvYNwzAZsNLUDFdVwIDd2zLms38APaQDlHTOllZ0sR5k0m4lWEL/XXnJ2GA094Ggr/Ah5AZHQys4+0/vBNkxG0lTmvEaFMXJIahBdgR8Osd9PdLMcjYKFYRmKWYQaKXirLnaBI4jXAuhMNoPDQ309KzaBkDGw+qH/0l43qH+VXL6Rx4hvgBhZGeQTzxhxEs6F1Dj6cRD3PSMpQAFSj2yb09yavwOOa8bsQsdFiFxOJeo1dnOy+9V8olAEZa7vSdKMJxdI0naYslgUih3+8wuLdUisVLpMjyxu1LaV8fRpgxSmUFqmh0aw0N58LDq0j2HxJIczMFPYCLMjptAO/vThciWoz+fle6Rb+HpFZOhT7jEQmeD/aUEmPjCHmFSu/SamARDKWgrvkFgx7GRCzsaIwCOfeQP/Q83EHUFdFa4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wUybVW56/FEu3f3qoodtCxyXNq5Jj6x5FqQ0Ko66+eNLd/VCaft3UDjLt05b?=
 =?us-ascii?Q?rB9mdelD4ZRm2r9d3ugzmbvgyClgPTsEc8qcC6hW6vwemHjhApubZDp/z0WX?=
 =?us-ascii?Q?8k4F0Ij0JHtyLsPzyURa/WXlN8f8qMKC72znb5vnQpyaxf1FDpbH0ya/Jt1T?=
 =?us-ascii?Q?upCkAYXBCn0ygjsM+npStzxfGG2YH84W4HoEFr4nXuy1NDhKNKC3JQEcAvbz?=
 =?us-ascii?Q?fRmhD9N1rxcRLT7TPqv4lpLbBdw7C4UHi+c3xvlTDHnd0Tql+1+nfYbf5rNu?=
 =?us-ascii?Q?q+9HF+Xv2Gi5/3sFof+Z7TPHINwcCIHlDxJz23ccd9M+ISfH+BDDPR4O+o3I?=
 =?us-ascii?Q?b7L7Kyxvkd0Omt+gtmSLK7jyV8pgZNF6WUjcqwM0DaFE6RtwEPXrK/FAC490?=
 =?us-ascii?Q?uOGy9+DK6LwisZpvm4I9Xzmws3z2n6NhdxJGuG9KDmzOpueLw2LNT2zXK5ak?=
 =?us-ascii?Q?0nSCECv3aOoIitG9E9D3fWtk/S5na5aEQu0HFONZA7bwRqyascEx4bO19FyN?=
 =?us-ascii?Q?K7rD+DEWIDgrebjypsqOp5bUR9r9A4knM3DNTVYTxTWlPnLw9SSGpt5ie+7U?=
 =?us-ascii?Q?5feO9bwugMEGatsZO0UkGNEZ7KZ8d5flDX2noG2E9wy80gA4uOalMyVGWzg7?=
 =?us-ascii?Q?NSzfGdapMZRhS5V214SF9KGXTEnV0uVqZOZp5AMhWTR3I30LUuiyNa0STIpb?=
 =?us-ascii?Q?wXmondy8FOghPy2iQhteloVlsEPhI+8Q78RddrvJZiZgnoRj9vuRlrAlbJNf?=
 =?us-ascii?Q?H6LQuPDoXSwu5EGOFyOVU0LgJiMMEiWoEML00VECZBl/4QKQpao7GHc4q4SH?=
 =?us-ascii?Q?wAz/SyIkDvhc/UoONuJVXY/QMNQM793jvGU0Bb6wR54huM7p/uACpfJu9FBp?=
 =?us-ascii?Q?0vUh2hV1RdXiKCOHW3Rff71qz/4kstz+SdTN3AVAs2NQeitEfKPDZdjpCy4G?=
 =?us-ascii?Q?RErl3hgRvsYKDaH2Hn1y+l5YzfdxmOfMJnW6qiqnPYTm0O3aYodEx9juOY4r?=
 =?us-ascii?Q?EEUleIbIOkCDwYOCV75hjlwLiT+Dn/E01x61oPC5PvEjxbD860SKYc08bnmE?=
 =?us-ascii?Q?r+Ifg4YXXrSq52iZubi7MUsOUduok5xkdKIy7wLSLTCnNjs9dXO3JQ/5hMH0?=
 =?us-ascii?Q?MEJqGVFI3Z5+5Xh9RXx5pYy3QU+nBZO3b83iMy4aQPxZ3aoLMCIpG3XapH2+?=
 =?us-ascii?Q?R2X+AWCm1tqQ/3v597K/XfU8kOK35UdC8SDNwoLyWCZOnhFpDe0N7BeTSVcp?=
 =?us-ascii?Q?44tiQIOWSp68hs529qTpT6R+DZjiQlHzyFQUB9b1RQA8iedA765/QHqleTVq?=
 =?us-ascii?Q?qSFGI9jmg3+tOzK+zP/vTrN/4jp8HQPuTHi5py4CAyDfAS9L+KFzrWfM5Fae?=
 =?us-ascii?Q?8oDmJpAVwIr5krtu40vabrRSAqVZt0dIiOBsbHeX/aFfPc7BalBg1WdhFXZD?=
 =?us-ascii?Q?ezj8dh1bG/xBwOEwSG/mnzNPHgd/uOWZHggQKrMrvQhQ+H8FBd4sLMCOj1xy?=
 =?us-ascii?Q?g71rXIc2ofC1bi39HsCAEuM3LrvThf+FWNpXZtfkX8sCklkWt735aMBlX4Fk?=
 =?us-ascii?Q?zZPQ6xRCv8MDem+1SnMLfAV/GsRfVtwrtZiAvke7n+DmsMPtqJKi7p+fomqX?=
 =?us-ascii?Q?pWBsZMcRN5/5lmSns/bq/iAxtJOBnurGXcdCp246bEYzoXczu2F9/wQdWsDN?=
 =?us-ascii?Q?C0fdzMTzC4WB96ouJ1qnaIrpwN8/4b3s6VcHSz+LCn4v+EV/kKRykNGh1C0y?=
 =?us-ascii?Q?LqrsQvX2dK5T/OBAWsg775/aA1bT2E4=3D?=
X-Exchange-RoutingPolicyChecked: XS8GYAStX+UZBpUBknKCdDtS/eMWWHatsH5fmrYjtXfTETl4jsZlm5WavDz3+7p6on5QnGo95BEkaAZL20IVzYk6VuF+NXA2sryJyyzT/iXOCMsqe56cwgs9Q4jE2UFCRmbK3GE2UygvXrn28coB9gahfRKN924I8tYU99Px/j+xHqrA76laEtQYfCJo+Zb1WYPB+/OPnli8cpIq21u/m+zlGKr1lPHvHUkpoaiw/NOPTxJwU25yOQi/T3/AtOR+XdOUfscgEyM+gtDMu43XYdQbyCW1UBztvB798y3M2ZFxis4JFDQZ9eV+oyjUVEUoO/t9d+oy+K8Idi5MwRQGsg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bb7K/12m1BzXIBT4Eg4kJ2TBDaNdgyuAc8WYjqZ9Ba1HX7Vy2La6L0ZdaX8/6J2ZiVqU/IieI8FyJrcTUsD3DX8O8yLKq/zDjhQYzlXwHF1ObaMyuWiTjLrA2AQ5cLIjghq3IhsHk6F4imiCrIEthEskGMIHq+WdELG0sSCvaT8mFNuRRX0tMligl7flrwdJ07P6/58aDIHlSqw9iflBWbQCOaNaGtruz9F3KmvTORE34l2MtIlOA0hrpWt+dSsiiqSZMrsfqSkRgfxbZDLG152tUdsEB7s5+9N/sGyh17L6gIHW7cpbuizixJgXgeKkFYPg0ekOuKOK6Ub53ZJSzIZE4Y5vQ0qu9+emcC42kMsscCRFjMVJ6r8MalOSFMaQw2Wia+934RyxOuHKsadtDFyC2MkD0dOiVQgKDHK4VtRfhHOQ6u6ZcNneFnAIMC09i3WE77OYfHTRWCWb9skynftD1XDw3NT35/EK66LdFa+lwDSrYXtXLYRkLPgaYp1viNgXX/3kCaocFt3iCmVRPlGFK1+jZovDr1QS7RGes3E3bomHS8HCr0Z+upGrgqmCEdd4hUFkVqd1Ix+ev70udxw1XEuFQIQ9+V/A1OMdHVw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e81f43-da23-46c1-e17d-08deff1327d3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 23:31:27.2105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KyQibsgOj0+SAUKoyJ+WF/OM/z4dtvW9L1UymAP0lSUyUI7DNBS0WgCS9Fhremt1GOpi8MHN3VoclmZGIV/cATeB712SRk2SYz0Iu0xrZhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFEABD4EF1B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_03,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608200175
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE3NCBTYWx0ZWRfX1jk2AdHhLK71
 JeR5PMJ2JX1lW5fJwYFhiLovwfd6svA+l4U7HlCZRYOLm/BY5XnD2FtXnqPmuttOpIOy9OWymtd
 ZWp9uA2CwjbFIwmbZULH37A2+FwmQzLP6z37J86EESyJsehAlsto
X-Authority-Analysis: v=2.4 cv=Rrz16imK c=1 sm=1 tr=0 ts=6a878e54 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=lG1pkkmJGHYCaJaWIKUA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12101
X-Proofpoint-ORIG-GUID: dzMITeJp2SjWj5v08el6m4h7ojeO0iVF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE3NCBTYWx0ZWRfX7sJrIHhB0j5o
 BBDm5fQMmLzykYcTCj9tmucNHZn1BLelb2kQ7YlULQyjMHMKCax2qDna5lBwWsyrEfBavXEJy+E
 7SfTAatKTp7ZDIEG3taoiCv/mcx7HKSx7p7XdZgMJ/0/z7nOqdHqpqZZUy3jBTto2ei2AftUrrl
 +dqHbgSat1A4uhUxZZffRJpxo2Asn++Bu5CwFEDusr2nb7us6QpDxXq3JRFjXvPjT+jO0C/V/vm
 FQwK3UQ/5z2mtcL2jjfifH4S65rJ1fJdsjmU19kK7DzRLR3nPcTi3HiCBiZas44mxSwj4ZpJbYX
 E0kNBVdA5NgksQgb04MrzWpyASQLHmnxN6JvHMyGcROUkfjjLy/ll5kqYYuG2zR5QzL9tIvHjFF
 dan+8x/rb0L3Vh8yksHMR2KTESacSBH3Aa+bqxR6vGPp00BssFvuGjDQ1DJwhXGExY2276TAhCK
 b1MFkoTP6aqXa9ryon1d+/E+WlNBWH8FkskLtZx0=
X-Proofpoint-GUID: dzMITeJp2SjWj5v08el6m4h7ojeO0iVF
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260820_163133_180106_65F88348 
X-CRM114-Status: GOOD (  14.79  )
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

Most checks are already macros in makedumpfile.h, but some are simple
helper functions in makedumpfile.c. They are not accessible to
extensions as a result.

It's helpful to keep as much of this logic available to extensions as
possible, so that they do not need to re-implement more than necessary.
Move isHugetlb, isSlab, isOffline, and is_cache_page to the header.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 makedumpfile.c | 57 --------------------------------------------------
 makedumpfile.h | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index fca42e1..b04a1e3 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -266,63 +266,6 @@ is_in_same_page(unsigned long vaddr1, unsigned long vaddr2)
 	return FALSE;
 }
 
-/* For Linux 6.6 and later */
-#define IS_HUGETLB	((unsigned long)-1)
-
-static inline int
-isHugetlb(unsigned long dtor)
-{
-	return (dtor == IS_HUGETLB)
-		|| ((NUMBER(HUGETLB_PAGE_DTOR) != NOT_FOUND_NUMBER)
-		   && (NUMBER(HUGETLB_PAGE_DTOR) == dtor))
-		|| ((SYMBOL(free_huge_page) != NOT_FOUND_SYMBOL)
-		   && (SYMBOL(free_huge_page) == dtor));
-}
-
-static inline int
-isSlab(unsigned long flags, unsigned int _mapcount)
-{
-	/* Linux 6.10 and later */
-	if (NUMBER(PAGE_SLAB_MAPCOUNT_VALUE) != NOT_FOUND_NUMBER) {
-		if (_mapcount == (int)NUMBER(PAGE_SLAB_MAPCOUNT_VALUE))
-			return TRUE;
-	}
-
-	return flags & (1UL << NUMBER(PG_slab));
-}
-
-static int
-isOffline(unsigned long flags, unsigned int _mapcount)
-{
-	if (NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE) == NOT_FOUND_NUMBER)
-		return FALSE;
-
-	if (isSlab(flags, _mapcount))
-		return FALSE;
-
-	if (_mapcount == (int)NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE))
-		return TRUE;
-
-	return FALSE;
-}
-
-static int
-is_cache_page(unsigned long flags)
-{
-	if (isLRU(flags))
-		return TRUE;
-
-	/* PG_swapcache is valid only if:
-	 *   a. PG_swapbacked bit is set, or
-	 *   b. PG_swapbacked did not exist (kernels before 4.10-rc1).
-	 */
-	if ((NUMBER(PG_swapbacked) == NOT_FOUND_NUMBER || isSwapBacked(flags))
-	    && isSwapCache(flags))
-		return TRUE;
-
-	return FALSE;
-}
-
 static inline unsigned long
 calculate_len_buf_out(long page_size)
 {
diff --git a/makedumpfile.h b/makedumpfile.h
index 87f973d..3d64677 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -2644,6 +2644,63 @@ is_zero_page(unsigned char *buf, long page_size)
 	return TRUE;
 }
 
+/* For Linux 6.6 and later */
+#define IS_HUGETLB	((unsigned long)-1)
+
+static inline int
+isHugetlb(unsigned long dtor)
+{
+	return (dtor == IS_HUGETLB)
+		|| ((NUMBER(HUGETLB_PAGE_DTOR) != NOT_FOUND_NUMBER)
+		   && (NUMBER(HUGETLB_PAGE_DTOR) == dtor))
+		|| ((SYMBOL(free_huge_page) != NOT_FOUND_SYMBOL)
+		   && (SYMBOL(free_huge_page) == dtor));
+}
+
+static inline int
+isSlab(unsigned long flags, unsigned int _mapcount)
+{
+	/* Linux 6.10 and later */
+	if (NUMBER(PAGE_SLAB_MAPCOUNT_VALUE) != NOT_FOUND_NUMBER) {
+		if (_mapcount == (int)NUMBER(PAGE_SLAB_MAPCOUNT_VALUE))
+			return TRUE;
+	}
+
+	return flags & (1UL << NUMBER(PG_slab));
+}
+
+static inline int
+isOffline(unsigned long flags, unsigned int _mapcount)
+{
+	if (NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE) == NOT_FOUND_NUMBER)
+		return FALSE;
+
+	if (isSlab(flags, _mapcount))
+		return FALSE;
+
+	if (_mapcount == (int)NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE))
+		return TRUE;
+
+	return FALSE;
+}
+
+static inline int
+is_cache_page(unsigned long flags)
+{
+	if (isLRU(flags))
+		return TRUE;
+
+	/* PG_swapcache is valid only if:
+	 *   a. PG_swapbacked bit is set, or
+	 *   b. PG_swapbacked did not exist (kernels before 4.10-rc1).
+	 */
+	if ((NUMBER(PG_swapbacked) == NOT_FOUND_NUMBER || isSwapBacked(flags))
+	    && isSwapCache(flags))
+		return TRUE;
+
+	return FALSE;
+}
+
 void write_vmcoreinfo_data(void);
 int set_bit_on_1st_bitmap(mdf_pfn_t pfn, struct cycle *cycle);
 int clear_bit_on_1st_bitmap(mdf_pfn_t pfn, struct cycle *cycle);
-- 
2.52.0



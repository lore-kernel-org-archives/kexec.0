Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10619C7EE26
	for <kexec@archiver.kernel.org>; Wed,  3 May 2023 22:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lij24vKJQTUyH7QRYNGn7S+sdzemYxD2rqCLQLg73uk=; b=1xV97sF/t0Tdhc
	4v2jFM38y8J0cWv4TWPdksxAsgdz/qdGl8o7H56tHh2ZbMAs+ma/mnc+hPJS2FUohsPxCYM0bA0Ea
	Ywdz248WiP1WvBuy2XudgwMBBj4DQWxyMpMT+B1B9oKIBgMfvzi9KPZ5jWobqei7bfHLWSad8pjlX
	C8E1EQzEp7qSimyqJpJBt6JUdWIc+TTOmhpeDRyMOBgMFOW232SozDrhgdneM+z7igdPcUb+PwnOy
	jMKSGm+vuQ0tm33cM52NexGvhQ0tVVhjdJ7VUUcvDCZXlGiOcI3dTzYgUBFYOTnZVkiM/wKcILu9Y
	7bGd+JI9gBwMsmZD5Jfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puKm1-005xJe-34;
	Wed, 03 May 2023 22:16:33 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puKlz-005xIb-15
	for kexec@lists.infradead.org;
	Wed, 03 May 2023 22:16:32 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343HoZJh024266
	for <kexec@lists.infradead.org>; Wed, 3 May 2023 22:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=kFk+H3b++A0g0bLRhrZbi13hX92C4B7Im0EDxf8hA9M=;
 b=0xph9eyYqJsfLCSYUiKvwcPsB8vmTf2F5u84WXq08JBk0Y024Rhtt7uu8jcwTqAWoiVD
 JFR1CP87b33ljQAyQAcnJpdGbJ+QMK5Cp1/pv0ppbpZtT2/BUQzVIpcaumcsTwxmu3O/
 LJzgCu40z0Q2RBXRFfuLr/st+UMCcbSDgMi2EfZcdIyOQ2XdbgncTzz2PvwZmA811d0c
 ZUMZpMFvmW7N8PUy8YhmrF9TeO9COoSdImbS61Vz+RxUjn4F/IeVJ3/euqtYJVCCmlm0
 oHIqNbVVo51uvTxZphMqOAcXGP1wvHEJ9MEGcCYiPaEwOvEpfmjX+J1C7m8nZ7C8dOz3 qA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8su1rh7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Wed, 03 May 2023 22:16:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343KuvqL024864
	for <kexec@lists.infradead.org>; Wed, 3 May 2023 22:16:30 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp7xhbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Wed, 03 May 2023 22:16:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkeqlYAmCvzNl+uxkXLw35p1dRxZec/xf9Biax6iZy475jQHX3Sqi/g+fLl9b+MjU7zHynR3QJn27I71LoSKtMcRM1pC2B8ABkOWGkivL+Cq2CrIYL7AMfbuwrsyiR0ROikbvuJeqWriPrEslkVoRkNVnD9gdUcufo5bYHNfL5LWT2VTnTpRDxfJicQ+tEHJNcYQVvKUiTVMJgcgf/KtxzaUhUwX5dfQuznQmhaThDuYngDpZVTER907iZMvjQegAcgs4cy67RDQlP6DGo1H2bawgiFevqT3PtXneTN5d9Kd7nGywM3x/+tOxAso6lc4ITLK+M+FgW2QLi4ucyi1Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFk+H3b++A0g0bLRhrZbi13hX92C4B7Im0EDxf8hA9M=;
 b=Te8IDsqXck/Ht45/w+hi2tiG6nH5kXeZF6rNLDfM47qtsSKn8PU8WMy/fSmxxtMwTGaC7ACwlxlrIUwOjIZbUGfpSRBgBCUgVsQvMb/8dt9ek8gohmyeNPsVLMdmxxakupQ3MwVwD41vyPwKm8BJNpUFLvSAZ3gWNcgM8wfDgEmsdUYi70NhkLpdODEtF0Gbi643vjwCVAS5ZeyVcBz8VBi1dXvBOzFIyVlfOkuZw5tfVmwWNErOw5u0fgS8FnYnJk6IsPxIqrPwPcvD0Y/kYMtCsTiE7U+3cN467vdnSK/6rmsLcYKNVbhFJr9RJ5oUxaPPQuvYyDDe/JTwejx1Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFk+H3b++A0g0bLRhrZbi13hX92C4B7Im0EDxf8hA9M=;
 b=tRWzBqRI41RNjtyL9p3EDR4XqKpneDCFGrYcIb9Tf0D99KPUgLw/dEBcIIHWISbZyQexz9DNkBJGBDFmYMd1zgyWEDnLmiRsGEmeOYWDLaXzOS7hSBxpmozfnb95nl/rd9BpwkgxvbM8IvBj/AavqJ0h7DHsXAuPG9LeZu/G/lQ=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS0PR10MB6751.namprd10.prod.outlook.com (2603:10b6:8:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 22:16:28 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 22:16:28 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: kexec@lists.infradead.org
Cc: boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v2 4/6] crashdump: exclude elfcorehdr segment from digest for hotplug
Date: Wed,  3 May 2023 18:16:09 -0400
Message-Id: <20230503221611.2119-5-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230503221611.2119-1-eric.devolder@oracle.com>
References: <20230503221611.2119-1-eric.devolder@oracle.com>
X-ClientProxiedBy: SN6PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:805:de::28) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS0PR10MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 01f75640-d718-4521-e479-08db4c240a61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	GQekd2db3/VCTqfywVe9LGchCeBfH4SdgortI/DLnUK256KTdnVAQ5UPu4TbDeEpFbuUpV3c2kk5pcAoKWgm3LLH+1OWd3SBFFguX7bYFxuHvyqnmP2MrADq1CBndr7Kgb/HFrIdeVz0UljKOE8ohXXjZXlqrjWl7YimgUeqx4R+xG/iwXiK/pnX/at2/j/zVxtSgjF35vzcflUGSGCL0EmSeDnFWi9peQFjIZjwhFkD4dcowvJtB9XOoepauD7dSEZM5dvLFhMyQXki2FQMcalZ6LNm9KoVsSd+8qzhTiLFooWv5Yx0kEzII8yAsN3rhL8OgN5aVnMzu4svULLtSMxUESSTxKWNpCe5cI1k7cATE0Nnr1fTePWb2DjB8anicB1oJ9OR1xCROf68MEq3bLoqQ48eSkk76GvRoAb1+8qypSiYTzBo4ldv37dZLHWiGknFsLUVaRH7+9sxvdgnJq3o0HU+5xSQeJQY2uyj8TOR1a/1GZCagtd9FCGJDdSLuEIPQkYbuxW9IWCxnZSW56mE+AibKIE8jeAiQRDn1EeW3oU03aKEXCiJVgg5J8Vl
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199021)(2616005)(6506007)(1076003)(6512007)(107886003)(26005)(41300700001)(38100700002)(6666004)(83380400001)(186003)(6486002)(478600001)(66556008)(316002)(4326008)(5660300002)(66476007)(6916009)(66946007)(2906002)(8676002)(36756003)(86362001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?hCD6Xfpuq1xJAidq5L0kR3CF33NoN3j+IqIA2TBugSrzMrx5qQMCzM58A7k8?=
 =?us-ascii?Q?+JchtIOdoFeoClZJo1ObvhIlyeI3WuauR+4s6LfmqXX05ciyBbn6XGSONrUy?=
 =?us-ascii?Q?FjIHfYspq72Z84PMGYj9y7jLfcGaP1qz/nckCczPfF6iWkAJqMsydG0bycMS?=
 =?us-ascii?Q?LdtXi5ZpyQuf69suI0ENJj4G/6VryTaYEHY3RCWlPDMNNboa0fRsl0oJfzVE?=
 =?us-ascii?Q?w2EjV1wBiOQSycIAaTST2qRxEcGoXCr4+9ov1DoEkXfg3NKZgC1b8/IB/wSE?=
 =?us-ascii?Q?wKG+RB59WwPw8MeV7k6nY539O4khhjxPKHt9EY8L6Hl70X2xAwtVbG7mMyWJ?=
 =?us-ascii?Q?8u0dFInnXNGIMhOJqXzOjloyLPOHqZLFELNv2tvji7iJfrfOO149ILD5vBQ9?=
 =?us-ascii?Q?3Iw0OY+9RZ37sToSDgWC/T0GQ3po17Xkv0Bhp653vIXdfWoXW0gVyGrJoFk+?=
 =?us-ascii?Q?PgmwToRJNlS4YSV2GQteZ0mac/Fub+L/XM/m2ci20MInO3qv6v+vnXKI2JNj?=
 =?us-ascii?Q?zuMyOfJfpQ5kWSBwVJAo3xJ79wBVTdu7dgvh2vIrE7E3dfnKL91snqYNwn3P?=
 =?us-ascii?Q?37kR+gnuQFhmvqfp8QHrBcckdpgaXmEx/9E6G9wOjxed2E8ssuTbi73JtzyF?=
 =?us-ascii?Q?ZpS9RSNP0KXTN0rjpVczTw+x9HaRas8IgutMHRyCZ++DNqWkbQ/v4qiSoguw?=
 =?us-ascii?Q?ryjZkzkGJ3vTt+Bet1cEcGB+NHR5Nh3zLX9xVxeinpjvtqAud/VfvAXw7xW3?=
 =?us-ascii?Q?kQq6D0rhzrvRosyZdXBh739yqqIwLxzcW224ro/aIVvPXS5PtC7OPYxo5MYq?=
 =?us-ascii?Q?7AaOuH1xeGKi6635cpAAfFg/fRY0AUYO1RhsXKWJPFQIKa66V2Ma+RRtG2Wg?=
 =?us-ascii?Q?tcJ293CYs5SeFW7XPqklyEK1vaPtZPfGtuCZ3YweouX+iwoF54BJLOyiiRn1?=
 =?us-ascii?Q?vMeRJJTRNyCeDR3cMvqYJXQKvDvd0luReBhDWyoBbBj9td6mPF3CdvCSN/IQ?=
 =?us-ascii?Q?Jj5iAPfYO8lCIPWEBN2cRLeebcqE7vUTbJneA52UmxGn+r2P0O3Kw01AZxCz?=
 =?us-ascii?Q?w27nPsHQpSax2Or6yELDhwEAb7UmtfWFpg7UdGpQ7ZJ/RCCb3AEVXPMab1cS?=
 =?us-ascii?Q?PHoU7bRINE+yIzUUTSzSgV5WGOspZ9EBuQQ943Qf+svWpY/baQA7Hxmk9PGf?=
 =?us-ascii?Q?6sUwPOvXUMNZgseAJPow58uqRuNBVbqhI+FSkyOo1i9iUybBjAx5hSf7QvO3?=
 =?us-ascii?Q?g7BDilMITKQsEcDRdfOWRgKluibNH30Jp/oMcJujjmo6j/+5bfRtWwvxNFKB?=
 =?us-ascii?Q?emgorh6Ptm0KjU9sBub6E0yP0rmvbAt9jzvKw4yMsnYaQCxqwa33L7mYTYpQ?=
 =?us-ascii?Q?HtWBEk/esC1Z9G3diQNK05S56qYKH8XHB5nFqO09CQVaJczg9yvJji2iK1Cm?=
 =?us-ascii?Q?aFOgXtspcwRPbBuCOOr7yP4C4acVHiY2w4JAPLlm/336Sk/VBUMDWkU+FqiV?=
 =?us-ascii?Q?C6GpNkHZ2szb4RyHY/jOp6RJaRpvLhOBFZlp4nIkEuRw3hdLzKpZL9MUlwcf?=
 =?us-ascii?Q?xtYrkQXcKpL8w4jBpDYcXsUDDsXAQ5Fee2syvwTJQcV6X+YUMwM8KhvdfBf9?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	k7PoFx0WQQYFCEwltVWLZEzHWUFsqT0MfawhkV6urvgU4r1JHv7FZH3nG1Tre0iP4evfd5pFo2SFv+mtQw/RN1aqq39S9sZU35X1O3Wiqco/maz6VzMXMjGkonw8ynh92GlLew8V0RHQSz+xeqW4a0lo6tZ0lgYPsVi5eRe6XsfczSgC3yuT0EhJ0o8sZKvefDYFheSL16yeDyFtVt5FmrwPszBF0Oq4p2oNPs9qPDVSWjbGfbYllSpTJnmV+NuuJXaYpw0H7wEco7WbQLq49KPejnn8ie8uVbWjCAsIDpyDpHCVnYShJIVSa4v7Y4QckF9rGJ0EAzCcZ2qLT4NnFlAk/m69BUWoSdQp8Hv/U7nA7MA9bFR9tgpdHRENQqxUNNrYAsNrRMMaF794/XeiK98wglIajtGJYy9RZYXYBhOgSOHUwn4i1PM270SQ6QNPvpGbgdaTXN6HvqBrmSeoWFcoN0x2SrksOr4wOroABmxG9mb7rVHm2yTxKMFTdmrBtlKd9aC1/DZjaf0aoOdxbvqj1MlKv4cJgvpDMJ5NYnsSvQ6de2ehcCFgwlnHsGgnIZUrg2jsKE+kaH6+DDAYl4WY7y62h7f01Wf/frk7C5FJB41+5pXNsaLhXPvvm4dHcja0MuktoUfA7ROwPCOsitKlFBmTJW5XkiZ/OwtAeqDNZrTd9flC17Sjcv6pQjaDNUlhhH5YUgR7/hP9utPVWEfN4vHzOuhdmhaFfCUdsfttuIOnPzrziUD9q6lGYK1KA0/POwojKMQGNj85nvXwfg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f75640-d718-4521-e479-08db4c240a61
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 22:16:28.1236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3B0aweW6FHF3Z2Dph/S/E5UZc4ntJ8LNog1x+N9QBVkVWskupMha9eEs1PfoAeAx0p6tzRLCE72I0KzPZ4d/6x5VCzcemZljCHCO/UTfwmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6751
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_14,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030191
X-Proofpoint-GUID: eSuD4W8Mxj_YePpd3pmmWvHHMZdObnu5
X-Proofpoint-ORIG-GUID: eSuD4W8Mxj_YePpd3pmmWvHHMZdObnu5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_151631_383428_33A4CD50 
X-CRM114-Status: GOOD (  19.19  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

To allow direct modification of the elfcorehdr by the kernel, in
response to CPU and memory hot un/plug and/or online/offline events,
the buffer containing the elfcorehdr must be excluded from the
purgatory checksum/digest.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kexec/kexec.c | 8 ++++++++
 kexec/kexec.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index c59e795..9d0d6cb 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -674,6 +674,14 @@ static void update_purgatory(struct kexec_info *info)
 		if (info->segment[i].mem == (void *)info->rhdr.rel_addr) {
 			continue;
 		}
+
+		/* Don't include elfcorehdr in the checksum, if hotplug
+		 * support enabled.
+		 */
+		if (do_hotplug && (info->segment[i].mem == (void *)info->elfcorehdr)) {
+			continue;
+		}
+
 		sha256_update(&ctx, info->segment[i].buf,
 			      info->segment[i].bufsz);
 		nullsz = info->segment[i].memsz - info->segment[i].bufsz;
diff --git a/kexec/kexec.h b/kexec/kexec.h
index fc24b67..8acbdc1 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -169,6 +169,7 @@ struct kexec_info {
 	int command_line_len;
 
 	int skip_checks;
+	unsigned long elfcorehdr;
 };
 
 struct arch_map_entry {
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

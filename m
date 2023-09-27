Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EB3E82CBE
	for <kexec@archiver.kernel.org>; Wed, 27 Sep 2023 18:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sIyw7gHNoSfGNw87+uBu69uI75LdsZI0YBgsr+alLdY=; b=3JnFREF4mBqNnX
	dQefYdMcDn7p6FAQKVo8FY4KPaiAqkSoAny9uFsByDlId/Rka8KWSaEsBvJJdyN4iQiM9DvbK2qGn
	YsHeHMkWaqxaYvfPi1w9VCJJ+x3FeGicrj8NBtD/Meeg0E0WL4v3sXkvaYmjKbiGyfqMhZOVvqh08
	+IjDxTIp3Y6lVA0YRGzBdxtMm+YOOQZqI0KFJPDr4xfJxQy4pmQ985UGTsL6kYqWHYkIvOmZZqL1u
	pt8rl2CbCLracUH3lUvJq8lsanabxt3eXSn6OSM2xHK2gup8kI3BVgPd7yXDBHkbnEjFtah1Nk5+8
	qu0naY7cp0IaHnbQBn4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlZ1D-001YgP-2a;
	Wed, 27 Sep 2023 18:12:15 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlZ1A-001Yf3-04
	for kexec@lists.infradead.org;
	Wed, 27 Sep 2023 18:12:13 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RGxJL3002688
	for <kexec@lists.infradead.org>; Wed, 27 Sep 2023 18:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=xWyrfTezAt5DUZ26ZmLsnUj9ZoMT3WmNxl2BLiBRMMM=;
 b=wTqbkm/vt9rOla28/1Fat+hXnFlQu3kk6osnER4r0MJDb14Lp6uzOUnk7sWKynwh51I2
 ync18zDipv5ByOAvUIHgXyv1mx1GyKdUyZxRILeJCyuib8q4XAH4BFgPXctdVPUiteWm
 NG4RmPkYhUru+gPpoJeyTUTBlEyiavX5foMX06cbiHTOBgmNssxluWnmjUP9l/B8muDz
 yQwO8t6hY227e4rsM0jvgapaa59Q8TbxHyFuZFGFMBTuY2Q87YtfzmHHTPPRU8jg1uzJ
 mYAvhFr+ziZyMoN7kaS6bebPu0CVc82G3nK5sXGLxUswVJLxvrgezLR0iwEuGjmaGi6j Dw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pt3t9v4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Wed, 27 Sep 2023 18:12:11 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38RHXNTq030822
	for <kexec@lists.infradead.org>; Wed, 27 Sep 2023 18:12:10 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfeb47u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Wed, 27 Sep 2023 18:12:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtyerPqNLZzylhjf8eMPF53TnnXEu68t/1I79N6dA+LrzYAbz4s7upFTiOjE4vBd4GeU96qyK8VrkQ9KnIiZknKdv0DbOmindi+SVGkqnXj/mZnrjeo+XXfnIyXLSiVMVUNwZoiqNxl6H5tFL3wufB7WlFV14K0vBsIe1Sk9Q1cymUwoUxCUKzn8VjLkPz7XsydfWYrWax9kx3wpUbDbOk5Zt6jXTvWLBaQbjWaouE/P4w98lF9PU4qkSw7ZbYSJtBCvPrNqgArQx4kVxtiqNYGZL3XaNn/FghtP4S7eUaJLILWUbBUtgDPUMyXVkjmGrafL1CMpvM+0xqq/ME3YGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWyrfTezAt5DUZ26ZmLsnUj9ZoMT3WmNxl2BLiBRMMM=;
 b=mJ/UMO/cmduh+4UERuv0aW6+8vrOBxMrkH7tUS2i9gFkgG+3DYsnzVyDQmjorHkqmmkUs+Qg3DswXljI+2z/hShG/TNiyfxhd50na7ixEickrY6zKNBZpioaDqyRzf2cYMO/csrkE/PGZQ59/DPsTCZJK+Q55Sf9oYqOATzdFH3TbfWccUjeBJNYvY4Bqo4YRGh5PR/0QMLUhBvF+TDYlw4z28knjjRJMrMijlkbA5tLJGAcxvFuKP6WluZb45WfV+FXfY365VPEIlXcV+MWd/Zu7s+XJ1RZECWULd+7v385xOArpqmxglPirGlea9GVGwxfXVw6o3rrWJoAlrSvvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWyrfTezAt5DUZ26ZmLsnUj9ZoMT3WmNxl2BLiBRMMM=;
 b=VrCNO3V9cK1L5XvToal4emvi3+Z4lzbfArovwySlk1vita431pabc55JKCwNnnkK/8A2Ya9Ge2KUBhSPbpxu+d++mrRtgF7Xs0CtG3maBhLjIQ9gt2Ni1k3IOUDQ2fFeuPqv+lQuzFf0sYCoWBI+wn+QqGm7UM+qVqFv+oJC3eU=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BN0PR10MB5352.namprd10.prod.outlook.com (2603:10b6:408:114::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Wed, 27 Sep
 2023 18:12:08 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f083:4d6:5079:bf24]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f083:4d6:5079:bf24%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 18:12:07 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: kexec@lists.infradead.org
Cc: boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v3 6/6] crashdump/x86: set the elfcorehdr segment size for hotplug
Date: Wed, 27 Sep 2023 14:11:36 -0400
Message-Id: <20230927181136.2627-7-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230927181136.2627-1-eric.devolder@oracle.com>
References: <20230927181136.2627-1-eric.devolder@oracle.com>
X-ClientProxiedBy: DS7P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::33)
 To CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|BN0PR10MB5352:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f0bc92-fad3-4594-e244-08dbbf854220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pH8dig+mvwIEN1MiuqEzdjVvQAfKO9WrZFBxiyhDSebeRT92Ei/9KcVlNlFCVCCXP8a+TEcMfJWzIjoMcVMJn11zvMlCVHinXZn5NPFFsboGZTynDm7rrG+SB+jZ6QFcBvgwmiWJVLfL2HoY/rlMA99JKA/FydXjustJ0WJ2gXM/Dsn6OL1DhSEv4WL2Dq5QZaUCEVvs+h31zDfvAAfYVVMJ3T3QuVVYR6jGqfBkKyNz5GTVobNUbat+lt05V1lsnQp7nWjrIL/f/X0PUvqLSMxNDqHOQn2wiK7nROpLpJsI73kD2mG0aw+8MbEqZ2kfOxLDf5z7BN10jFWjDntxvm80epBM0AN3wKAoZgqSNpULPhMY8Xny0FjCWR85BawTLqiab3YnVHIcsKsgLaQTagioedS3b/FtBdup8IHQjQ3sJxjv2p97CJ0aYHk1NEiOnv3S/9ro0tK4voR9uc/rXgg+pYbAuDgf0CVil18WvN/7ZvEzcJjg6DZ3ehKS5L+h9UcVJcUI7tAZmelKAbaU0QqTTo1Ix8epj1BGBp3MnH5+AA/iT5MBZ281QAZdIkHx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(376002)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(2906002)(38100700002)(107886003)(1076003)(6506007)(86362001)(36756003)(6666004)(6512007)(2616005)(6486002)(478600001)(26005)(41300700001)(66476007)(8936002)(4326008)(8676002)(5660300002)(66556008)(6916009)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yXl5azMKA5u1e/iAVooK1u7drLaTFrhotGEpaRf4nQEZEMhaeZlx1WZBxFJ+?=
 =?us-ascii?Q?lAZOmw9eEz42HoOw/iFXa3V3ugNLZB84c+jvFQF9J3DbzM3H6Kz5dG3uim4F?=
 =?us-ascii?Q?DGPs0c/3txMDiTyXGr0MnnB0vG+K3yKsd8ErkaqW2lx/yfbQSd0/V2CdakJl?=
 =?us-ascii?Q?LN/KJeNM79OYpsgwyfgEP1VCujD2B06588XAbdpTmKtIKARsBXhFhOvCtc1X?=
 =?us-ascii?Q?1Qk8J7GY1rUv/NXSYGyAd7ObfxQvTabqLkh+hXESiTBpg2i0VPfSjxGT+riA?=
 =?us-ascii?Q?OEp8ZL62KCgc8msTXU9SDcrhYVYXo5j7Ud+uYVkA2CbfQSm4QPfahjbzj0xS?=
 =?us-ascii?Q?jHPuUhPlbSUk/g3woa1b6hOhZTckTb8Peun+sL6nH5u8gRlA43a8TZrPYyaC?=
 =?us-ascii?Q?vyOQKStAY8o/GzafFNS8iNuvYimMpTvIji6MWL2dwYUpvrKnmi767SMUpkSX?=
 =?us-ascii?Q?oZWPXNirAbdfETIDRfdofKj6T8SI/d57GeArlj4a0qdO6qqsvrel4TofPa6j?=
 =?us-ascii?Q?c+22EZ0edkRCiftltnhQFImQezAscfUGxS6LFZK4mYFd3n/Z1lbb73TzZJAm?=
 =?us-ascii?Q?z0PWPFjGwL4rvkkoqEPpAsGmku0caNNNVZvN9g+2DfB2INp+EHNo846sOrOV?=
 =?us-ascii?Q?7674/CDRQgvhBPVbP+kScr1j1mgYAfOu5yNqQMuQiMp4Ocr6kCpoSd4QcqXN?=
 =?us-ascii?Q?wp70rzwq1kHaUJy15I+JLSS/wCBJXIB/WcRI5cvxPI87MbYwDEddUpwwioSP?=
 =?us-ascii?Q?uJitCgJWmQA+asDALTrGQbPb9F13RlfeAAUwA5r/YV8OATRwXewlvJkTllB4?=
 =?us-ascii?Q?7IcB2DgPxnW72ic7LnHQowJ3APxboTOjomzMYoKnFCF514bc6xt+r6J+MDjU?=
 =?us-ascii?Q?+raFsQazr1agXfpTLRqwsjOGgcgg96SgG2we7kT9usDv7faBan9qan4ZLkHM?=
 =?us-ascii?Q?0PB0KwupBIdW6GqNjZZPadcng6vmBM/8fV9Sxo0o1edn9MMaPaFxgLX4rmm6?=
 =?us-ascii?Q?c6WaTJpp6D3ACW5365dr0hlYIl3cMiSM0Y0T+Xt8rg2qWBxzYTjVY3AYmIPB?=
 =?us-ascii?Q?vZ0tjv2NDx9PhtlYeOIn1NfayhFud8wvHHtxG2A46wUHLhZ3RavKlLKtFdA4?=
 =?us-ascii?Q?wOznUYMIxZo3hbcY8NTloMTGv8DcRmv/zCrdhHxdVs5cQSYSLBM7d2en/uhp?=
 =?us-ascii?Q?8ApxZwrj0ou0MPANa/frUQfebzCifJCWenoQtLcwnW6mL4fYNUvS4vTY83dI?=
 =?us-ascii?Q?PzTwJ+zglMb/cjewkfsIHhy3iPQ7pHV3VLbLd49eXCioyjNn2PEWfk3qOy7Y?=
 =?us-ascii?Q?Q6xgyA0223U/eIYVcLyFeVRcU8x5aQ8UTaa+0zb/WJrf2jc0Vb/QuFGOOVy6?=
 =?us-ascii?Q?sQXwD7DJTB20fd0bfpB3J4QMCXBvtD6FzNS7wM5p0XQ3xmZHor5Hw6xa1hlb?=
 =?us-ascii?Q?1x36HnFSpn9kIhmKYeXrnxVfKrF4WYAuzwJBV8A1WEBM+6eegkoND9E2byGl?=
 =?us-ascii?Q?+bFmigV75axGZtFmyaBDslm8vKlXBEd8mkR4ozA//nd0D9uuRhFV4ybnkbXb?=
 =?us-ascii?Q?j1paYjsV79mWqdt46SyEtljfHYoRl0ML6jqvn3sRMSwx8KnluQcZ1UW5UtW7?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: A0LVov0AB2V16IM8UK8DYJTs7e048gQiuiS5pQYzG0M7QaiDy498p6VenbYLSCDR4AXjeqRw2ew8yH8FnIBBsvc+zgeUFdfALtMyUUVSAi7gw1veWUo/jR63D+V/9N+hEHOqdBdidP8UcGoW9olVOEKBbyKFh1ye0NuAr4PjtK0HY4ad3P3MeQBga9b43CkTVhbJwbpdiSDy1ecrvnNzQbjc1M+37b+v9be+ZIxNIytH5ZpB6IdjSmQNgTGRE2WWjM5K/bA8Gs1w75pMhG2E4A/wyY1wEXR+zELIlau/jJptTM7EpryN99daG5E0FVEzKz5ObzBQV6wY81JRE31gaujF5urlb2J5023aI1rLowIDlf8ptsyUioddrPxIXRVT3Le9iOAPqQGOe+5Q+Zr5HLsfB9cJzJzuuYnn1wSn4cyyGF9/fJi1Y7ZrP/MBMeDtZDAXVMK91ytsKUOpVB21rV1O3ypJZQpS0nt9dorhnG4sVQuNEiVtQm9OKVhlrc95HilS3MfMGmlT+o3lOCMPgqejCH1RfL8nzWVZrVExYhMQUcpsYQETzsItPzcQPTk1KToWotcvMAn8CLPSUNZN1ebXROaNEZhMxf3Crvck5K2JsDAoL5i0E5FG3pJ/oZkDjUKaLe3QlKyERndSXgJqPC2cPDI1SmYx5ctJXSfmH5HTolbPPVvlqMv5eAvhOnuwyYcwyTb0sS0jHSwcBONO86+7YIj+BeHgFopR6uo3FD8f/RoGFqymUTeYvBacldiNR1A7hsN/dvSYwxzXqCp56w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f0bc92-fad3-4594-e244-08dbbf854220
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 18:12:06.4795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D2UjCzh67wb13twjFWBjgrmEWswJGt96ugk91ABzFK/VwQJ6Zg0SugFkbF6bkCffKsThc6qdAgCB3JgVi8T5WrRk7zTv68XzWbfh/N7nmcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5352
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_12,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309270153
X-Proofpoint-ORIG-GUID: Bo7s2OA5s2mngpgq7aWTzFEVe9BwGuRa
X-Proofpoint-GUID: Bo7s2OA5s2mngpgq7aWTzFEVe9BwGuRa
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_111212_175847_50A78FC1 
X-CRM114-Status: GOOD (  17.85  )
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

For hotplug, the elfcorehdr segment must be sized appropriately
to allow a growing number of CPUs or memory regions. Use the size
reported by the kernel via /sys/kernel/crash_elfcorehdr_sz.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kexec/arch/i386/crashdump-x86.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index cb86ca7..a01031e 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -957,6 +957,14 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 		memsz = bufsz;
 	}
 
+	/* For hotplug support, override the minimum necessary size just
+	 * computed with the value from /sys/kernel/crash_elfcorehdr_size.
+	 * Properly align the size as well.
+	 */
+	if (do_hotplug) {
+		memsz = _ALIGN(elfcorehdrsz, align);
+	}
+
 	/* Record the location of the elfcorehdr for hotplug handling */
 	info->elfcorehdr =
 	elfcorehdr = add_buffer(info, tmp, bufsz, memsz, align, min_base,
-- 
2.39.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

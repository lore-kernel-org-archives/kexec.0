Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177E8C44508
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 00:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jkUXEgBQBCWU9yRywTkSkMfRX/gqM5nzVh1ozJR1hys=; b=CVY8NBQ/3Tt87aa48DVXggP39X
	F/e127gebOUuIBVENbIz9aZbI5Kk42DBKGhE2lVoP/bXvuSlakgdCesKvvOUYLJbsIW/Y5p/nKY+F
	Q/YbQY8KcYNSsfCz8w4Lnz86t5FR9NnMdTzOlM0fm317n7hyGjoaGkoC1xA8xTL5+zY8MWaEkDeJ5
	95JiVOWOYr6pck8UT4xudT7xgB6/tlDE/cAjmgoYJLHb1IjIUoXuvyq/gzrCkXKxgkZ5MeuZu/YLu
	EJisr5VtA8Dq/Xz2L82y3x62j5L1sS4xn8XgqG3TGOJ4NlTGWdEmGW6gKMuVIe6m3vsC5FxDGxWCb
	lcAmf/HQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjRHf-0000000AcFV-3p8D;
	Tue, 14 Jul 2026 00:46:03 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjRHc-0000000AcEQ-3GOU
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 00:46:02 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DLEotA1379945;
	Tue, 14 Jul 2026 00:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jkUXEgBQBCWU9yRywTkSkMfRX/gqM5nzVh1ozJR1hys=; b=
	RCy/Og8q3Mhs0N1lETTvjNIeCMh+87+ocJZ/xWA8yHxpn5FiJIsLG9/E046kLnGm
	e+un4CtPYUCAAmzCcLYC5eMAB1LUJo4CXk2fNCHrwoq5Z/I7Q9vFcQJCyamfpHzT
	NuSOovtGePYn3VsCbKU/ofVQJvbo3wkPXe+D736wY3YMFALjZWrD0+rkrLU8IMeO
	oFoufyr/gmyIGynitDMfn6Wje9/FgsO1j4nI0oNgV75qFPrdqGeaASGtSP5y9YOi
	hFbh/+sciSh53q9cUGrC94K2xP6b0vU5UrLfCGkRPQmZ45Yk0qqkfa5SvZsfdkcx
	NRY3SZ8+by3nnSLij3be3A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbed839yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 00:45:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66E0NZRQ015260;
	Tue, 14 Jul 2026 00:45:58 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012008.outbound.protection.outlook.com [40.107.200.8])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9qk9j5-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 00:45:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHOruOAEaSx60l/Xgt/sBEObsoaOxoVW3gNqLHNTBMknNNJldfVqtBvPaDOfvNw2EprPwy0twte5S9s1/nnkVlETqzvKaMMPt7dCJtikXc3lEs8MP9+X0JmYdC4zOAXBbSThgH0M8FUjfoYrEaf9T1Hh//eaoTXtMyFzSri/l9xWg7UDAGQMw4N4QYQLW5n4LrLJ/QWuva+qhOeUlUz7yYT+0MbNyZWUgLAhUZLr/XSrGaTP8Kf38sUC7REvZTtuyhlJxGO0ZES+JN1+NQ/TILwsEZ0GkqrePkhelXR6+kE6Zia7fSrPc/RoYfQEFCBTUSh4Rr+XYX2+bAzSbAzoHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkUXEgBQBCWU9yRywTkSkMfRX/gqM5nzVh1ozJR1hys=;
 b=E3P1721/b1HwL6z07K5pG83aZyMjODVbxu6NPcKkiYnyqkYP1V+fw11rNesW+9Pbym1zSLxVOjoWT3e7EjfarQyrw+QrwcDtsPUt8YnyGld5ACfGSje99c/0NC8bS4YyyQoLCJaIm/dfofsd2/mtDFYeDm2q5uaGdhNCEl8LGitTLgTyDEfvpvJO19w4mNXi5L5FL/8UHOTR7RcptoqyQopkxnyRZ0GKikaddwdMUgecnIFhKHpR0MNM3G31QR0TBGO9kN+e8McVYJHIn/JPk9KFB2H2fNWSi56rfP5vtOdk8euMcrb7Nfav6bAe4X1pert2JzLVii8VTQCnId1Djg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkUXEgBQBCWU9yRywTkSkMfRX/gqM5nzVh1ozJR1hys=;
 b=altQtLn7qsDCuW/NC5Sz6yO5cg6Kv07eEQ4z+zfmBWIPjLNynC+YHDy+BZJBVbEEb074oXmMfXF5caaJM2mN4EhkalmpqmpmhXh8GWpS8ipJiwkSpZB6cr06ehKfZBKJpjQ0FqG8fPHdMZleZcz96rNq+VHC/HHEP8tmalEx/Vg=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by PH3PPF3CEC6235B.namprd10.prod.outlook.com (2603:10b6:518:1::796) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 00:45:56 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.21.0181.019; Tue, 14 Jul 2026
 00:45:56 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org
Cc: ltao@redhat.com, Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH makedumpfile 2/9] Honor CFLAGS in extension/Makefile
Date: Mon, 13 Jul 2026 17:45:35 -0700
Message-ID: <20260714004550.3698175-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
References: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0083.namprd07.prod.outlook.com
 (2603:10b6:510:f::28) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|PH3PPF3CEC6235B:EE_
X-MS-Office365-Filtering-Correlation-Id: 83da3c06-2658-48c9-a9d9-08dee14143bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: iMA+TIKdJhh0mpEt+fRiWgJ0+pEYY3JFByBkneQX4vOYbFb8f0m3Mp62UEHgq1eIw51cQlaOlB3pnvHdEv0SEw0HIsPbfpDlkNJox1n1R/SIWMKiWMexYyQmPLQ1ICI5rtFLvkJpnZS+TcjjPaomEMwgNGqVa82FYRAz1T0n0fcFd3V0iOkj0GivuI4Llkah6tQrGpR78sDh3my3eiv8EXU78mBLrE03kJtwE3+LlqSkKJJSKU9Kun+DzpS19dZAQu6VajoZKuM6rw1uPdCU7W7qq8RvF4vH8wzKXrSMFzKODIyOMuFxkZLyZzsct9NoN3Kny7GGA8FXMS5EHSVkU19KeEK8TTCczFYM+GkCS9TP4RK43BEN+TXgMnfqb/HeJ2MtkNTy4a19wOFZS1tNOI98tHNgTzx3ZEr+jKtyB7ZJMqif0yEicU+0/RtVYKOooZ3pHC0DAXj0rIGAYjBpuISqi7MMwsXoXHi+KsRvDLxsbc7Ufw3nQtxLq/yh3CuTk25fcBkCyn54XudFQhWEbBkjrk3GLDFjsVelH8GQ8dUxPfkV/HxPKgBu0E19dmFRJINmJHDUFBjCmrfSb+fG1reLmMPjb+I3hXY7OUPX7F6psc9IqzzZ/G+1TeG9E/1noTBCbmHUQi6UVSQTTmjwt9xTQSByMuuVH+Sl48z1AP0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aSrUJ8Bp1DJbjjyKPEIpR1Xr9xcGINLESLABRi+HMTOH8JacJNvh/D0e+NOi?=
 =?us-ascii?Q?AniqjNvGyQDs4z0UlzHtXJ4MO05lS7yzO4/PDcLTwQWZQZrkFmmlqmoGoUfM?=
 =?us-ascii?Q?uRpmgXpkIsq5LzYONvop/r8zh84NR5AA/gbrnfI7E3Kw+gmf1IepCJOaSCjl?=
 =?us-ascii?Q?bUL5iMnMJYufJzv8VPdk2nn/8S8Z6CM0i/3wfPtnkxCNEkwi39ks2/qD0bNg?=
 =?us-ascii?Q?3oYIVDYSIXfoEMMvghI2X8UR5143r62fYa3mE9strBZak89U/IncYumK/Dxz?=
 =?us-ascii?Q?T4PihH0T4CipyiwD5/nzZVHCPF11lcQzIlKGHfo7B7+f2tAKb+bWNBzj6ZSR?=
 =?us-ascii?Q?bLLXrw3144TKBO3eL1SupWHhGo42SWGsyD7qBTHqTOFi0e+3hYNpCUR0bBpW?=
 =?us-ascii?Q?58CBXf//EIqpWLvcHvdhwb+KimmArWWZeGESfLvsjJHotcG+XukAbyksto8e?=
 =?us-ascii?Q?NaFqKC1KbCG/riLrtO9Ayy1wJugKH2OLCywbapdQTz+NhDTxjrY5RBlymFU9?=
 =?us-ascii?Q?SlTDulJ8iHxYYg/CmEPthO9RHxD0w7w9nlHd9rciPVAZkXFV6VA0dHzhxyOC?=
 =?us-ascii?Q?kw+wW0LyAtSANNchulkdr3F/VNGMDcyyNbbW4lrDu+VZ9y7zLzxTwm2400oo?=
 =?us-ascii?Q?OxBkIgnVzcb+kcFnxeJs/GjoQnMLH1zjjHi1TsRoIW6pmF1n5gONUOzIo6R+?=
 =?us-ascii?Q?vJcf3TSWP6FkJ/0Xs2qauBZgfHxwHKSMZl1Lr5xRXZX6C++yjY6YWUL+6Ln7?=
 =?us-ascii?Q?BJ4/pRSo5hHsWMJt+UDZA3Rg6wLgugieeh7QxcXfaFQIFGNT6JfOrJg2hpCr?=
 =?us-ascii?Q?2r1WPKuCY1e716pl6E/yiix6kt9OP3aoc7eHwqHIV1O7JPdrk7Q5WFJW1ehl?=
 =?us-ascii?Q?E/JuEDXplkboB9AwnY9sXRPpZttT/kO43o3Tskh8h5QUERZF9poV/XlV04Bd?=
 =?us-ascii?Q?EtV7eNesAEL1ApkPTCh76e7NK8JfWYAGchT1Kle6v3/biVx1cW8oxG1R+k5V?=
 =?us-ascii?Q?Ypzp7yBvuZZTMKflH/ASXsLxJxdk1f3DPzeImXWhetgaZyqzYbV54R3yUXq1?=
 =?us-ascii?Q?dOsRH7Lu4pUcvtb1Ih9hzH7w2o1Ksrg0dkGfWEEto417J/Orjd9DTSbrm/0x?=
 =?us-ascii?Q?3K+dOMryxioobQOJyWA6mopbo9jxnOqpsrERLR+CPQM4xD86Xps+WqvQAbYi?=
 =?us-ascii?Q?B5lJS6RmyXjCsmauqmy8+0yFyMKo8qHMfO/COhAKeBtGnvvbIeEnuF6Zhpac?=
 =?us-ascii?Q?107rPXQblJwnKT39z/b0zfdNrIHd1dRV830Vr6Zy0IjXNrqC14DScCKsjgS8?=
 =?us-ascii?Q?6Eux4k2Sh2vIl+7FpQIGApUZIRr+qN/Y9LnW5XwRoID/TayVT13AZpxT8z/4?=
 =?us-ascii?Q?avAyovrBSuhwiYDq1HFAXTSz/Y5/SPVPOvZa9bWLK8GTP3I2IPDjP4xv/L7d?=
 =?us-ascii?Q?7DczPuFGDIcvE/Yyv9dgTBLXIX1MaGt17aa2vRAIiNMQcfIaea2LKelUxwb3?=
 =?us-ascii?Q?iITsd+ip64Au7YEtQudJK/+4dxvofvTU6UWSWt0aUt01D4SsYQs3GAJW8f2l?=
 =?us-ascii?Q?Nft2Dc8qnceut5G5XNAnZ5jVe7mRHG41QtP3GB1A/Lct5Sa3ItfmLJwnA6Uf?=
 =?us-ascii?Q?1T6/soF6Ok/CIkjxj59lkkluTozo8ZBPoM6TQvdPBSxUADIQMRhMUcsHEkRE?=
 =?us-ascii?Q?5HVJY/5gIVDs/LARHcbYDQl90yycZofL3mSo6UTq7/y5ex//7Or/ThPjBJ5N?=
 =?us-ascii?Q?O9bUcIZ1qCyT0CyJ557+EIWgJvYuo9s=3D?=
X-Exchange-RoutingPolicyChecked: Pby/pjRrHYFxIPLukLq6wGPv/+PyC6w+DWmnhkFCu73BWuMP5gO6QMllNm2IjcoHDANTQn8haFtCkh5xiEZvtB4HQCPXbMKRciTq+L8iA774yJlsikOCIJdXCGuVcky6dScAm3a2S5OVt2aSgsKns90VjOPFfdAbgb1M6+v4NvIxQJXMFXuqVd7Y5b6z1hqShTAiL1f8vji4V2YwZdB+VyPbslHZlwMVZ6Ch3nFtwMM2/4sfQgou1ul+LyaAsCqD9+6WGOQDh7hJExnRqqRgVN3CTaSKVPBeS7fUY73NvMTpKxEMhoDGDFZc/qqBCp3mJBzQiFroVUcG0tb9lZKF3A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oCgbhjP/NKokyC5hdqTmeisgh/MgaoE4mIVj+rD/mO61gAOkGERoBl0Cw18V3r78Jxtol51q7UHDExi87j0SXzuV7QNta7zcLwDufnX5wyXeX3ZWEHzEz77urPM0vtnj4hxWgr4A4clOu1t6pQYwy27VzuqzWyOjynqGgoWbaWsFCXa14b1c0LhMe3A//uhkbBAt5p92kbHYPdHnvGbAWK5khjrf25j4Z4yFGG5MiAOmhOL8zq+Bgn41UGVY3B83nGB7HrzjGvKhepqdW7qpub7VW0WUv0vHPv4jvcaGNJA8CtPjQ63LNFprMxXutwoQRkTwByofbZspRr9Yx1pGYjUOGcGZnJ7DlOLFgMk9fLVIXfHBtcnEvacqDH1BT7v/RN8tQzK4hoXWaO1xWSAxp7Yfn/1OT5zFOtK1T2kcEXzdCBCXE0rF5l+a7DioQb1gnpHrE6dYPL/ZH/ZXi0BIwfuEcHEmgrkbgKUeY4hLuPkHn8fK7rglgEV0kmWfKfGhZm3WbqOfHQovMRvCdlkNqSBRjkK9IpVJOaPg73m2yC6VhGfZ8SKubqTjkUSfARGaLa6e6F9g9dLA33I7Xp0Zdb+m6YdJkNCobEYCWWjePOw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83da3c06-2658-48c9-a9d9-08dee14143bc
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 00:45:56.0344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wj0SDd+OiHxZP60AdLEnHTO04IBwaKa4kFJE4tDSwcKP1soeuEgxoKOICdC8WDEv2XPFZ5WAjMV7DZiQSHgOEuDk/3MagaU6cfWHngiKtC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF3CEC6235B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0
 spamscore=0 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607140003
X-Proofpoint-GUID: wgUq2C7qXRp10UuyzPKqBWVIuntn2Tbg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAwNCBTYWx0ZWRfX5N9T0L0V8fd3
 SnezOYOyLcuSC+CmmRQbgDsDgOmTspXG9L7uvX7iw/nU16YOxa6fywsNt60fBWSxHoLOU5AqP2I
 MC+loBZQnTSmJWGI1h34eEhkEAQ0i+2ShghbDbkLSHTHxzHPoty5
X-Authority-Analysis: v=2.4 cv=JKALdcKb c=1 sm=1 tr=0 ts=6a5586c7 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=j6-wTD3PJutgIRfFCt4A:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13633
X-Proofpoint-ORIG-GUID: wgUq2C7qXRp10UuyzPKqBWVIuntn2Tbg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAwNCBTYWx0ZWRfXxuS0vfXG3f31
 9M8/yHoeqar3RvMIR8qmOLydTpGZBp+wHCSZLTyEy1LKaSKc03kqEjKT90I6m4Zhp8eqB6hksJU
 HC0YA0TCgnQVshgehTqC1B/Z9aiZjaulSmG06rLYdyKVlws8OJqLDDn5KmT6laOv21NEQuT3Wah
 4Vy5nalUkq2eES9ZniSrA0qdouye4v7N3KHAoj8DXBXBJH/CQD0abzACzWrM2n1JalMSA7g849b
 gpFXlVclLKn+WkTXXJjREIuNaRKNETnYFTHp3aL+8WVr+sk0lxOmlE2XLUTL3r5o5DAkfYFL/NJ
 9qB/MxkFW8NtH11VJPn19DvHBhUz5/tzWyKp8pW7YA21640ok/2bTlabD2f6+2dcaj38dpca4M9
 YP3HH1LD3i2B6NsK724wcmPrBIaxCwVC2QcXVTRyrD5mr18xkqRwDXMyMheGgADZBpUHY0eLiH7
 GTyl0GMRDbYFitNSxY706T1JfFUfmBbxvZ1R+rrM=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_174600_933635_E69C7600 
X-CRM114-Status: GOOD (  11.60  )
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

Currently CFLAGS are specified manually, so anything already provided in
the environment or from the calling make process is ignored.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 extensions/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/extensions/Makefile b/extensions/Makefile
index c112d56..25e0a07 100644
--- a/extensions/Makefile
+++ b/extensions/Makefile
@@ -3,8 +3,10 @@ CONTRIB_SO := sample.so erase_sample.so
 
 all: $(CONTRIB_SO)
 
+CFLAGS += -fPIC -shared -Wl,-T,../makedumpfile.ld
+
 $(CONTRIB_SO): %.so: %.c
-	$(CC) -O2 -g -fPIC -shared -Wl,-T,../makedumpfile.ld -o $@ $^
+	$(CC) $(CFLAGS) -o $@ $^
 
 clean:
 	rm -f $(CONTRIB_SO)
-- 
2.47.3



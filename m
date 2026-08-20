Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6013AC5DF81
	for <kexec@archiver.kernel.org>; Thu, 20 Aug 2026 23:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Thv1fju+kUfaMs9/fVatH5F8zAlJPL2PpzfGlNCjTQg=; b=y1/nbuVRRulrxJkCGsj9a2yOsD
	yXKhrEX25qGmh9eH3yX8aFytDzOjt7KEv64HgM+K+bqmP4J8f+XaFSpptTRuwJYib39L5EyEkkkKh
	QPlzBPfBvVnK+SUHD6QgS3KT69DQCtXCJxWo4yjn6DCLTjv7vSRde1RuAYRM6My4kUWb8WW5m0b4k
	LcLJNUgG8qG+YSt5bW7DDYcUxmIHv9NxVJaasUOEPgk7PdPCTzoBcPKXynwb+A1GrNXvnzEObJPk5
	RfMhc22pePQGfMsWbGEwS1HakVYvTZ6M8W1UZMEAUT46gFOPSzyrlClkItjSGxkYsHqeoAPS64caR
	zqIkqU7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxCEM-0000000CLAn-2xl6;
	Thu, 20 Aug 2026 23:31:30 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxCEI-0000000CL9N-12Ff
	for kexec@lists.infradead.org;
	Thu, 20 Aug 2026 23:31:29 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KNPwfM4191329;
	Thu, 20 Aug 2026 23:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Thv1fju+kUfaMs9/fVatH5F8zAlJPL2PpzfGlNCjTQg=; b=
	ZfLb+odSrMuHEWg2uc2/tDb9/ASwaCWQzc2k6NTx/l60rsq9Lg4EQC9e5r/Lq20C
	JX4qOQMeaMs3svskdcjyeqwS4cLtwqjOz/eZswAXJ1IQJGTAPSIYP47dMWouKO+7
	aPtVBE7GHDEpuGdXim5nPNu+tOBcA626EaMff4a/ur1/wSQ6RqHQ7eFdFjxuKJk/
	2NQsDaiVxmF5QZQq5Cflt2AhM6NHK4KkeRiEgpyT1oct56B2ILiTB86JFeECEb/R
	2w9UY85z5hROUtnBJjStqyTk6hqKGG0gBLz/68bdXy+3f+/Lt+lIHWiLhgaUdz3b
	1SRCy1PUFpotSCXRxsb6/Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g4ydem7nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 23:31:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67KNUboU020064;
	Thu, 20 Aug 2026 23:31:24 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010008.outbound.protection.outlook.com [40.93.198.8])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4g2ejttsum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Aug 2026 23:31:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytFoWL6rtTuIS1bY5x/dtWc8JgWutiEuq6fOmpIKyt//GksYUUJLsSkqac4Way4DeoFO7Pzcyq81/JOSNSCNmC3eqn5Is+gIGV41oj7rFE7FGt4deEj4R8x0H0N4Cf9tK4txGk1/lS9nI/uUk7M9ObWSRN4Whvl5MSgP3ppjygKhAbV2Q1wnhVDil9JJXNtR2X6QK8LOldTLtpqjgFLZzsA5Q92rbwbjcPbhMKpGej8rar3uV15H03TfIlKzGGBvb3Jlu6k6jaiMytJzRZYELJ7d1/WmxrFHbe0GiXJ5SkgbPmTdNfiORIE1xtJWL/aSlNKagbKRpExTSYBdVdKFZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Thv1fju+kUfaMs9/fVatH5F8zAlJPL2PpzfGlNCjTQg=;
 b=g0hvH2dOjIjAPCyJPsZglzLUfDPYS3z67EaXWCe5pzz1SMHRy1xUchyY1m2PG6MPRGdX3OpqrGcGfqwXOQ/Pnq1AeUMErVS4EG8GVxFbjI6pmD9IkcFoV17M/qYE1QEDASzZxqf8YaQ5grdMlKCVH7fcCq3NOxIbVPCrovltBvdw2kdBCqOICCgXEeaklRXgU3CvGbAAOWf7WBeDjF+SLfpYBNXVXI/uhXmzlaRpYWwedUsXHxmsTvkY/sTaD5wpukaREfFNp8OWN81OK5YDm1GK07FQSfNXld8FsfTa7ZtHS+KgLnnbBKJ12GAZ3Y3BXh/n2pIXwA+f309ddiVi5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Thv1fju+kUfaMs9/fVatH5F8zAlJPL2PpzfGlNCjTQg=;
 b=YmQnQrV6OyZNsoCUtyavlZzDiXzLSy5pi2YC/avqOFetigCWQNi9eDuMAeE9+T8AWKWAlHKx5Tf4Li4X0Tv5vDUyyAooEJJB8YCaEriFkVscYIW9pQ2P7SbpM1lTtu/crN0mVG2GFblYgtSTAFACBEI+VC1uYMpmrOrNwZ4oXKg=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by DM3PPFEABD4EF1B.namprd10.prod.outlook.com (2603:10b6:f:fc00::c53) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Thu, 20 Aug
 2026 23:31:20 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 23:31:20 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: k-hagio-ab@nec.com, kexec@lists.infradead.org
Cc: stephen.s.brennan@oracle.com, ltao@redhat.com
Subject: [PATCH makedumpfile v2 1/9] Do not call extensions for tail pages
Date: Thu, 20 Aug 2026 16:31:06 -0700
Message-ID: <20260820233116.3105747-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260820233116.3105747-1-stephen.s.brennan@oracle.com>
References: <20260820233116.3105747-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR15CA0018.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::11) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|DM3PPFEABD4EF1B:EE_
X-MS-Office365-Filtering-Correlation-Id: 6636e62b-7838-4205-54f5-08deff13237e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wU9Jlir0m8co061MibIfZhrSFi2k4H6GKqXIIDorrzYIa9dZIHIBoXGrNb9RFVLTNKHbybjxuoEWpMjl7e1oHnNyqTwjmo7cM87rNd0KZmeEtFx3JeFpOicLP33pzQ2zHPHDnmnXR7mfyxWcJSrl8SxkhR37gZfB7rAzO7Np/dbeWShSXWz3vttTrHbiyjgAHnDrV6o2pFcBS1enaZAwQROXEMHWrwdaoUGoVcS6flqFTPEUZy8FL5m2rJtQ9Qb79AdVG0Cu6Hj6jb+jJ9mzZs0lckt9cyPopeCWxn0sJaBTvb7KNWPc3k+mVUs8r3iwu9T06ZcV6Qqzq1TzFOND+OkTroPkkYxr0zayfsJAqFYEfowspXgvWxNf3f+wOhu222FC3EpomL7HhMxe9Y1RblOhK/MrZSvczDpLEtqUv0Hn8aw9Sfv+6vbpstLJdQ+mKugMKZpYXqjnYnwIz0nkxsrJbOegCtexZeVrtQhoac6n7iDbiM1hb0iQv5ujcUnsl54s+HztVOsRnCeXZK/q0yS5kGpwabRPT/9YZMRzYo9HWvFf28G0wFOsx+Spfns20WWMIr7SAgZ/DgCL7SK5rDWNH6+ukWLqQcZlUZHQcXLwEajwnzGgd/saNXCUeQ2zff6yrP1RUPa0nzugsc0/teHLt5dTyUfOpCVZgItyvxU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1G8k4L3NeAVgH7p8iZf80J3ndEQmf1DhABkh0UqV0QtrT6HLDMTsumdDUaFH?=
 =?us-ascii?Q?xYTUl6I3gkWHGNHBCWUtTvj196Kt57cnBf/4IkRolTq9sKl35TOV1Wnd3tfW?=
 =?us-ascii?Q?qJtE7U1jZ12LbYQ/BoW+yTgAS68tjx1QOcaiqVSp9Z0JjgUn0bkkLBANMc/4?=
 =?us-ascii?Q?ROMauJVIG+vRVpIMeGwaNjC/2WYD68wGscP+L9EeOaRWuo/oRcaGmL2iYExT?=
 =?us-ascii?Q?t5L0/njR/7GgepxdEbxd2P4UYfAhgKGY0dZoaDJTnB6nKvXDFBQBOIVpwSf6?=
 =?us-ascii?Q?4qs2C5HYsOXwGTt7zZY7Cq6faLuG7fSFMXDsueGMgZW9wnsrWq3Yq4z0ordZ?=
 =?us-ascii?Q?o0zlxejENH4QsUaKbUmr8HMn51gMCVSDnnj2te5WWpQk7cKRJNy2zM7c7e2w?=
 =?us-ascii?Q?Sb8+7ikqP8DokhWWdEXV7ot13eUPDBIYw4jvS0aZCi+Z71HdyGmnPVmGHVmV?=
 =?us-ascii?Q?uq84vRe5sRjt3SwZ8ByD2LrDF1yaRp8Vt0hbei+UJpz/PtrKPJ+D4zeBS1Gk?=
 =?us-ascii?Q?glLgUf6IQE0r9tAx+kQYR55s0aijhlRkZo6RdXL2wjAliOB2js7bj26TnVR6?=
 =?us-ascii?Q?IO0novDyh/RbfkuAZEkk1E08uun9n4zWjuxUrtQMqC4WrP36IavvrYjuPgEQ?=
 =?us-ascii?Q?4gl6td59Fs7bvORsKUxKq+dy4ONkftHO+KFk2biOWlSTicp/JpLvcGAIC2S4?=
 =?us-ascii?Q?QzkgfLDgB7J3o6mOO1jRtkNe5VLIW6ohKXWFEj7as8L78fnkp2ij+EbvEmNF?=
 =?us-ascii?Q?tuepD2TvkTcVE0zaYAOLpePHxp54JhpJ0rtmglPMrL2U7WeO3aY/3Jh0+svC?=
 =?us-ascii?Q?VZkkAmOp4+cR1DEbhObKfHqcn49znMd1AFu1zYYJWzXEFpK+WpxeBKcRYsBi?=
 =?us-ascii?Q?/9nZVaCWcItca7rhF3yeW9Hnw4tCBQX57iwvl8I23NyvztPJwfYhZfHeQ0l5?=
 =?us-ascii?Q?1o/M8zuly5qlT5II5qPrtVm9aaQDUbJ+0CmFUR7zp/RYM3RFMPbeOrTYk1Xh?=
 =?us-ascii?Q?07aqLSZOD0mikArxHXvYItnxS8eTIGV1z71ZHzxmsnLkZM+RdfaikrETOkbr?=
 =?us-ascii?Q?Hc4e9KXcbihGPMdWHgnaXOZHDyCdVCNHJmwhHo9jLXplMWOmEmYEvHpVIIeS?=
 =?us-ascii?Q?SlIydh0H1cxmqimEMH6SLBE6+mq5fZjPtJ/jZfPCRaypo75WpoyVv+6mC31q?=
 =?us-ascii?Q?OoaVlxEFJ5LRvT/o/g/rXo4Zs4lBrO6FTSm9BzfZGECygntp/OdIW8zULdVf?=
 =?us-ascii?Q?dgzoDExU3dckLILQSiWn9nSVAlLUsUv4zV537mDrZI8Yw0VVdQv2d7xkvO2T?=
 =?us-ascii?Q?qaiVcoHNnVFCERqjsXrS2cn9GisKFKaE9oShZbmybIrGSOikGm3RIPKdzyZe?=
 =?us-ascii?Q?AKutOz0Wgofpo1GZrwlftk7Gcp0KSpEKM5V4eaXg24uXnwCOddQlEFjl99KX?=
 =?us-ascii?Q?/lFhwBIfmvFd9JyXcZ1jI0ClaWGHqqGQQuCV5E8RFwQs0fLcrVpwvh0dBOTN?=
 =?us-ascii?Q?MQDJJ+qXEaR5BTow/bLN4mc2HnM/v9k1Lo98LuPQWijoFD34rM+JC1N4Okby?=
 =?us-ascii?Q?PnKVqag+sp6d1X0lsGTIDXOAnjvESsi2CrgGJNcXjlODKd7TcHPhaHDuo/9T?=
 =?us-ascii?Q?MzsaLSmR3N6FodSEULUl7gGD0jeXspQ/D2QcvNgG2wUdE5Vt9DyCN78gB6xe?=
 =?us-ascii?Q?nyF1gg5DgnlMtTdDsgIFiu3fMg1dyRVF8YtFP/BHsX4tLhcwwVRqiVAgFei4?=
 =?us-ascii?Q?6Vep4zA0Cjhsrv1D38urjyWFlG9ifTo=3D?=
X-Exchange-RoutingPolicyChecked: Txx6hI5u7D/7Ww/7SVKhH9x0aAMfM6cBNaW69m7S/zLQ8eEysegmw6mybTXtr534tcGNj8ESIOgPAGZvIW1TuanhtrbMSkblU7Av4pudF+19tzV+CasvxVJje0RbJUJYXbyC+XB1aWSd97SX62ldFeDjuhTJKD1Xuxk43QUQmU1T/Q7qRB2cxfBa3xmQX+SDTj+NrF6aMmaxsIBWn8QfoI+HA/nvV1ohH4OxJJd4gsu5reziEiX1rBNPmZd5jrSxiRI2XXS9OTcXmaRST3nmfxC6Vqwvuqx+NjAuqUOhRMI/VHUC/bOahtZa+uUscQ2I+1VkDxvGFwj0wZNR5okFSQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /++8RIYyZMU8wl7hzEr2Z7sw0o+W0ZfOoWIPT8hw63hQaDlilGMaK7E8lOBKun9WtC1HUNL4xsRYGgDsoCzWgpLG4ER8EeQenFNSx82eYgFLbLR+lw03T2xtXaX76FE2dVMR9sfSm67cq40AWMhcKRsHyQ5QACis4/qxgPUW5k4M4XA3bc6bWH8P/ZYeSaJiNC05QxrcY6/v51WozZivBoPOCVuPJUklgNonWv/FPF89MesQkr99Q8NVLrVDxMsZF+1pYPORH50SV6XOtUDHXi3jEyRxGJe8JRyu028Xv5405SceZ0O3zaWnSk3aA5yhDN4/ICbVBbgO5ADBIsqBj+DS/ldlE6X8Y2pt4iwDvFfuS6LBxb6TdBVr0sCvuYIMniF+N8tMI7lUKMnT1+jJH5hOu/02QC6HMC+GJcyIYP5i91hjaDkiPkPuT0KXFAx5lji4WG21w+iCqlenGurcytmh2PqDtm3Drtf3ACAgCHrIIySynaGCvjqyyq7qbdcGLrcwXEjOCOtyyI/yG8/Llph48Q1T3nMeV6UwkdabpPk8RwLHoBQNWA470YTYXuXSCVmlnUV1wXdl1w+qJSNoTza1E9x4PPEg5irlCqkrVuc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6636e62b-7838-4205-54f5-08deff13237e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 23:31:20.0363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XIzuguB4w3JkJ//uWuKaZDSinKFXqm9ILLizvmJP1C5bR9BEnPeUAxNxMnqCy3otvIrPHea74JXuIeHgVL6/HJjXWOW1iiRuXPKiH6JQdGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFEABD4EF1B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_03,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608200175
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE3NCBTYWx0ZWRfX8wZ7T6aXrFsm
 +idP77n79TfosOuW5tiJXpF5TYVYHApwOM96L0QQU69vb4Sx0VzRKk+7kNjQLGWgqsSEdi0WYGM
 5Ncjuz9wgRSVih0r60wGQC03DzwrrYzifKKl609c+H4IJ4ZAJ7wA
X-Proofpoint-GUID: xr3OVNmFmxolEx3fo9NJPdryvfrwwi3R
X-Proofpoint-ORIG-GUID: xr3OVNmFmxolEx3fo9NJPdryvfrwwi3R
X-Authority-Analysis: v=2.4 cv=WNBPmHsR c=1 sm=1 tr=0 ts=6a878e4c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=Sl38ZljblS23AXd7ABkA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE3NCBTYWx0ZWRfXzh7TmqTRTCMv
 94A7JZA5ZEEMQruoZUa8nxagz0sdO3Nbk0ifJJoUsyHvk+TAxCUhKVaZWH8yEBV4h/rZPIHrmf3
 3vgq3PMVKdQBVWu8s3787DTRkvK14mXzpfRwsZUUkqEMC207XICc+nA6OlE/Tw9jjc2aImamlns
 7qnb6Nm1xMiF9uF4/cW9vtGJJ81PaodNw9CjtcXq6B3goXfSBuUKBuKmU3BNicr41d7/7nM7TKe
 kDnqu1IZLggtXeKhjG4tzHSjxPeJGnQ+7o7QggxWn+cGgrirfjFvTHevZAH1oELglyrUGyPIKb6
 GpFIWhAkLcf7dcrskzQaxHaa4636fg1KrIEynHom6uc03DZm9iKZ9XTEHJTAp3vd8NKDNXkxz2n
 zOyQX08tPi9wGWJ3LWQim4Le+84LRnz7qw0cqsBCune/P6nzYY2M9cz5RxZcWvxfnm2RqUCGFpg
 M5lqHXA+b1vp5ZiQcDpDdbPcTv4gpcXOrHk/L3M8=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260820_163127_112510_755E8BDF 
X-CRM114-Status: GOOD (  22.30  )
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

Currently, extensions are called for every page which the loop does not
skip over. However, there is no case where the decision an extension
makes on a tail page will affect whether the tail page is included in
the dump:

  (1) If a compound head is excluded by the dump level (not an
  extension), we will create an exclusion in the 2nd bitmap and skip
  ahead in the loop, so we won't even call the extensions on tail pages.
  Even if we did not skip ahead, we have no consideration for removing
  the exclusion set by the compound head, so extensions would have no
  way to include specific sub-pages.

  (2) If a compound head is excluded by an extension returning
  PG_EXCLUDE, then we only exclude one page, and we do not skip forward
  in the loop. As a result, we will call extensions on each tail page,
  but regardless of the extension decision, the pages will be included,
  because we hit the "(compound_head & 1)" check before any exclusion
  can be done.

  (3) If a compound head is included by makedumpfile, we do not skip
  ahead in the loop, and so we do call extensions for each tail page.
  However, just as in (2), regardless of the decision of the extension
  we will include the tail page.

To sum up as succinctly as possible: while makedumpfile itself tries to
make filter decisions based on the head page, in some cases it calls
extensions on tail pages, and yet it disregards their decisions on them.
We can fix this in one of two ways:

  (a) Call extensions for every page and allow them to make any
  decision, including different decisions on head & tail pages.

  (b) Do not call extensions on tail pages at all; just apply the
  decision from the head page.

Since option (b) is the most similar to our existing behavior, it is the
simplest to implement. It is also more efficient, because it allows us
to skip compound tails, which is especially helpful for systems with
many excluded huge pages. Option (a) provides more flexibility for
extensions, but as of now there is no extension use case for allowing
arbitrary decisions on head & tail pages.

Thus, let's ensure we don't call extensions for any tail pages. Further,
let's treat PG_EXCLUDE as an exclusion of the entire compound page,
so that extension decisions have the same scope as any other filter
decision.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 makedumpfile.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 46d9ac7..1aafd4f 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -6543,14 +6543,6 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 			pfn_read_end   = pfn + pfn_mm - 1;
 		}
 
-		/*
-		 * Include pages that specified by user via
-		 * makedumpfile extensions
-		 */
-		filter_pg = run_extension_callback(pfn, pcache);
-		if (filter_pg == PG_INCLUDE)
-			continue;
-
 		flags   = ULONG(pcache + OFFSET(page.flags));
 		_count  = UINT(pcache + OFFSET(page._refcount));
 		mapping = ULONG(pcache + OFFSET(page.mapping));
@@ -6637,14 +6629,22 @@ check_order:
 		 * Excludable compound tail pages must have already been excluded by
 		 * exclude_range(), don't need to check them here.
 		 */
-		if (compound_head & 1) {
+		if (compound_head & 1)
 			continue;
-		}
+
+		/*
+		 * Include pages that specified by user via
+		 * makedumpfile extensions
+		 */
+		filter_pg = run_extension_callback(pfn, pcache);
+		if (filter_pg == PG_INCLUDE)
+			continue;
+
 		/*
 		 * Exclude the free page managed by a buddy
 		 * Use buddy identification of free pages whether cyclic or not.
 		 */
-		else if ((info->dump_level & DL_EXCLUDE_FREE)
+		if ((info->dump_level & DL_EXCLUDE_FREE)
 		    && info->page_is_buddy
 		    && info->page_is_buddy(flags, _mapcount, private, _count)) {
 			if ((ARRAY_LENGTH(zone.free_area) != NOT_FOUND_STRUCTURE) &&
@@ -6712,7 +6712,6 @@ check_order:
 		 * makedumpfile extensions
 		 */
 		else if (filter_pg == PG_EXCLUDE) {
-			nr_pages = 1;
 			pfn_counter = &pfn_extension;
 		}
 		/*
-- 
2.52.0



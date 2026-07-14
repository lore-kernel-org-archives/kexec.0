Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B3BC44507
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 00:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GmgJ4s8pJp63IduQE/niDkHijhGgeyQH00140rItuH8=; b=zkntsrfarwh9xC2YmSgkOcxDAn
	XOBuIpw+XM2EL4kCO6ADbUuG4+b1u08Z74hmTKd4tvWHLKrPvrmCeynXtXwzqBHef9NE13yBnERi/
	sT7p1wyih3cYy6J/I6AAPcntwiH9LXoseyqQkN/jzLTpVumQVV8jVL++dZzCCLlrl8GOVMFgYxiy3
	0bkMLPeEJ8+mdXlqNwAwIB7zuu9Y8ug8+mBtWtt8oM/hNGpPDumm3uT5egr0VyESQ6Ez6egxhzfal
	BphPf2uk9YbCNGmTwqikG2WGz1+spoHpmjsGDinLIAMDPQJpDR6cDq57pEr7XNyD/SvGD/Co4nmBK
	M4N8CZWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjRHi-0000000AcGS-0Yk8;
	Tue, 14 Jul 2026 00:46:06 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjRHc-0000000AcEO-2BkW
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 00:46:03 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DLE7wA1347606;
	Tue, 14 Jul 2026 00:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GmgJ4s8pJp63IduQE/niDkHijhGgeyQH00140rItuH8=; b=
	PIeyBI9xJKJ3ePY5AgzE8EYqmblK0FiDj4aTBYTihFQyQUbtO1NDKysTC3qD9uZT
	oCq+F0hzpQkvZQbJP6U+QyvLJXPU3Vsab7RiUEAsRMIEfcbzQK4/lOjF6cS9j+Ux
	Mx9nwcIMhmCPq3Oga7felku/8dmeFbBpg/8dXOVNdGlaeIhKuoY+nfIJtYOxZSQ2
	AvVdybGkGDqlSlF/CIvsD5vbfTx63dRaxcjpFgcReoE03T++AQWA0eFhfG2Y/VwY
	/LVBxb++GbM91l4yIY8/eMaHALqleHHE+fHEqJGOjz7W4I5JddahojRay4hsnj4n
	ZDjutb6BWiP0UNguNMUYwQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbep33ar3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 00:45:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66E0NZRP015260;
	Tue, 14 Jul 2026 00:45:58 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012008.outbound.protection.outlook.com [40.107.200.8])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9qk9j5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 00:45:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBKc9bFJ9vNpARHJYfNTp3FybOG+dBWEB9kIQcFILmAegj11XlPMQ9KTbU3UrHDdpAYgIbExvnSFll1QsV4aP4+wXkN760ZC89ZUGOTJ3cOZt7xr9yyOe7Q24GbsPK0RT/eBCAZ1cqFd/dXT3E4y/8/IyGTbg8OBRSYNS7ftT485NPQT6klfwnNSWz6NtrC5O8O35avmfz0hlZAa4qhu32xzB5Q6hyImeX2lngDDeaQ68ig3kp+niwfGYoxX1+7A6Rn0seGKek7enRkL7AhNFkXf/siAz2vGgjTSB75q+FGBprRxeBAB0QxSnU5JQ48my2Gto6v8FLeiYOf3r7QMiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmgJ4s8pJp63IduQE/niDkHijhGgeyQH00140rItuH8=;
 b=WsiS6B4owzJukJuvlRzVn0Wc2Czz8BOZCSCQwAs/wIMPgEENdRXZ5XNScGTbS3Bfmfm8E/Yh1kkem6EF2ZKI7qR9YtWcOLWac8Go+eo22aGtLjUo7s4m+7eI8AUSlMGln0VfGFcySfv7gbHtZIkURt2i1v5V+K1w1mLZDTv7h44f+10t81dXBVIiNL7HfvLfQz7qDm0pDg4am450Rd312kH87WlsIryVo0xgGw0Mi5rjCxol5s+hwEHVX09MfMj5kTPPCI5CU/xiOpzrIgbkf6HkvpUtq4XmEdION3vfcMdBaRT/lwA62ICvyFMY/TOMfrXt384eJ7o92tR5h8JgLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmgJ4s8pJp63IduQE/niDkHijhGgeyQH00140rItuH8=;
 b=Ht7ZzvKhedP7z5SVEVcBPVhI+6dGOLtuXI+i6imRoyexiw8aNPuG8zV5si3boUuOtVkyK9SWq4YlnZK7+JpnETqpGG8L3rHK3iLbqrtbqOMdKMVLw+bVVyYu/qnIp969INstBOgjZTb8RMHNeh1AZfDLFsNhu4qSwX8tcHMbS9o=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by PH3PPF3CEC6235B.namprd10.prod.outlook.com (2603:10b6:518:1::796) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 00:45:54 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.21.0181.019; Tue, 14 Jul 2026
 00:45:54 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org
Cc: ltao@redhat.com, Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH makedumpfile 1/9] Do not call extensions for tail pages
Date: Mon, 13 Jul 2026 17:45:34 -0700
Message-ID: <20260714004550.3698175-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
References: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::19) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|PH3PPF3CEC6235B:EE_
X-MS-Office365-Filtering-Correlation-Id: b5c867ba-c05e-44d3-b5bd-08dee141429f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: HBrF6+HY46DUraOjKsN0Q1EJnDa7zFepiWqTR9jKzbDFWfweaui0LpZBnjtYsTlSY/EggVq8VrdOc71h8T12KS7j2wAOWdVryR0IUmRzCD259eQvhBAJgel8mJcKn1UJQuimQaOKeg+vksPNlac420wMW0U1nemgHHkGFa/yuRVi+nfzsa9/7VD/JZP4De/RAotGjYLSlCq/FwQUp3ib/u/6qQ3v9zVWobzon0oLrKQjQwxp1qmqQCrqjwlY/+2J2OUbUXtQNX3jt+KLZfYiRAcokbDS1bOtqcH8dPQiH9l4gcqQC8NKz+BZuNqHbprEhF+8z85cQ4Ta07l+3wwjjgriONCJfvnj1VoyTrOcCK3W85nZpPF4mh4+vBNFcHnKA44idXUxyoDxiEDcWFdN1GMUgsZ3dc6vVn8fj9JwGLsWueRTX1U/+vXtpGcVRg7P1fVko0GJTZn6s+SClTJBF9a9FEmcPz3vB9eih/vH94JqLR6IPzFgXYPX8LjDGgKp3S4S0/EuFCY1LUA12VF18Ah8vPaXZRFVgcpCni00Y9HP4280Pg+wG8lFUMVSOIghrbaBHPmsPg2wTLWdgQMV0cPk4BPuQjiQqaBJ0tEJbv1Xd2SyDvLsHhuEyT/6MbORyJiwYnzHwsonxAYuNh8ZsRd6G3hiDOaLeMui3H8vxb4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9UXqNM3+2uzvN1aPE+wPdYzUiGopcDAhs42HNnoCtSnsyGVAALMAU2qGukBP?=
 =?us-ascii?Q?Zh+nmp88XJ5FdLsr9bQu8wCYdgSiJJZaiy8lcDIKwmFwwzXSS3A76iN1CdwT?=
 =?us-ascii?Q?6ID4SUIOUv0V8KtU0JiMPeelUREmkzCpdScTOpUVuymt6JqcSdGCE/Nb1I07?=
 =?us-ascii?Q?ZzFLLkac5N7bDb4Wb78yQ8VRMXwhvRg0rfAIFH/Xw3kNsWJw5vC+e+Gu1C0t?=
 =?us-ascii?Q?Pl7xMmG2tu62kZF8sK2Ilk6pj16eOxWgOKO0DYCHudoNRYywiQwLBF1C29oJ?=
 =?us-ascii?Q?z/gUJECjHkgsZHJXNeTXGyn+RsDMT+Xsu27kPOFhu+BV1DkEghyUTMxUo2Jr?=
 =?us-ascii?Q?ExPKB4moAzwHx9OK6czlJkuwub5Fxl4e7aUj1ABNZ98juXEHeCEFnrswBNz2?=
 =?us-ascii?Q?HOA/b3NcgXaPd2n31qhrTi9AT8Rb96h2jj6d9+WxdjDTWe+VBYhrlF8oE3aH?=
 =?us-ascii?Q?o/bUeKJMow5IpFmaSL1XggnKmnasoM1e18AUxRh82mDAPRBcOUav2aMQmY2E?=
 =?us-ascii?Q?8eDn7fJmeJNgjx0ySXXW0VQ0fcFpDTRd6SQzZHau4qotnyyzJalWkRrgWHb2?=
 =?us-ascii?Q?qamPSsKx7pQnyG/7GGOhPaf+0AjBFNJPsNEvGGHOtQ8nTQncr7VNezK3gmHX?=
 =?us-ascii?Q?8CMRiMA2NU2HQDWf2ScLxNSutksfx1x1j2T1wnrm4N5yds8wylVlCqmfSwxe?=
 =?us-ascii?Q?G6m8iyf0NxbSqgezPNSVIz94NHQIJUaDpUR0k4fffosYDJ5BkRo5dMjmbwT9?=
 =?us-ascii?Q?vIRISkPTNvaB0hMMN7Wgzyp9Sss4XSn7H4iGLW0Ttc5IpddGysU9v+2mhDHo?=
 =?us-ascii?Q?EDvx8uIg3yImwtVs5OWHWM+5qEPbdEmop2Z9z4NtCsCTEeeSY4ZjLGiCXppA?=
 =?us-ascii?Q?pPv5FEsUAyAWaaUQVOUOSAQ8NREinp4dv/Tee013hGGb+QkLLoNMzoKSD7Z+?=
 =?us-ascii?Q?n3gaElbNYbR2IVdfUMvqX5t9SvQpiUz9xXiV9KCi523XGeAdoR+8RUUklyYC?=
 =?us-ascii?Q?bIG8aSKoKjBWWCJSqOVLhNti3s8Q6JDcPve0tA+Fp1FQ7/OKhdiNkfjU9XST?=
 =?us-ascii?Q?7veHHzYPkVUL4Me3kcJ22gYVB4Y3wLWpv/A5iUWXPfkPkuUgbbTxlE4/tQ5Z?=
 =?us-ascii?Q?H3k4+hM4UpfKuYY5HlVBvdJHMGgOfWnZ59KoXG40i/lykr/jlUjtcSEq5JrB?=
 =?us-ascii?Q?D3ZOK+rppqpTslEWvv/8m48YxcOIbds4st380+jc4+lcP93olgyx9+p2JEDk?=
 =?us-ascii?Q?kWI4tvPq/hThg34iRjy8muXoAjoMm945y2dauHxW3P+RBSnvgIyu8F8m54Fn?=
 =?us-ascii?Q?JUeC1c2/E5IF7QgmBPRFD9hGHB9ChdN4bkzt+UQiD6Pp87fGUzEWbRLygQSl?=
 =?us-ascii?Q?FTCnx0digR5ebb7Iq7/yCDoPYTr2n8QShRlBsDuvWS08hm702a6mVN5OLmS3?=
 =?us-ascii?Q?JajFg0G3wiEkqNwfbjR8l923hxJzIAbxMozKEk1/3iQGuP2gblDhn4Z+w/ss?=
 =?us-ascii?Q?MAoL+FTK+BrzXa7ekJzRQDPPlalODqwPrpE0nvHm6a8UXhlpArswKpS13mk7?=
 =?us-ascii?Q?oSTWfAyYny39RFVNTzz+BeFoQ1OlkyPH3prLBAtwTfOlSzOuI+Z89R4XPDfb?=
 =?us-ascii?Q?NculuFMKKCzdiRlXO+xnFYEwy+VZx3vorRHJBnyJAMiICwMBsDo1sTs1K+Nj?=
 =?us-ascii?Q?NRzWedJseUB4MRaUU5dZXHYw50vnJRs0Fl67+2dWKn9N2vzvYpmMXDBI2A7i?=
 =?us-ascii?Q?ZkymFqtGlEnJymkD7o/TWnuvN3AzZa4=3D?=
X-Exchange-RoutingPolicyChecked: Jo7E69hQdhcAVW4YhMzb5a4Wy9GYbWs4lmYUwJs5qLXefoEANemZ7JNi2t1U/hZWXn8nDdSt7UGpMuPTa4sCJlvqiPvP5P0F+5C7oZb2Yv4JYFTwO1QwwzJZ03KiVyetmVm0j83fCwrrbu5BzpdeRuZsDOXvav574O67QZjrhHlkWF3/Lfy1OyRbSfidZoTPpfpDFWnaaQYHsLKO8l57mm/QTn8jRkJMDETkWNKaJQxlcKYDgwG3SOU/2H3O8doEnJTy770vBh9UAPUTuJur3sObZmLqoX/obqZGFaM+5jQ4+P1FFU2Leh6X3ahIYlcwaD66zblMyanAUMPP42aaQw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ewfNHHhjFgB+vhgzJCO35YkTuG1jr6BgLO8kFu2FyVCG7//AJ99xIRXYFWO+uS3abhqhWJAjwpq/dGo5mEmVFbZJxTfQGS4MWMfbqAYOPut4Mg1iKaO+Z25kV4TtXh0VOHNXaWskH3mQH8wgG7Py2KM/2iKea5K9egDeqUm3g7lrbQwoFg17FpyB9akZ3wIHwiMhdyRODBBaZbjW2JPEb7W9MKzLuVozFXF8SNp+Wr3is7q+TvQis/Je+1WaBwn1lAdd/ayEnUmMFMFVWTDAqXNP1O1zzxOUKHQQHsmFHyUVilEu2GCdWZGGLeHlpJkOrqnhDD8M2QoeSpBv/uXKH42WBVZ8IVFFU8fkZCKAKKkdmsSNpSX7Vif2XLLwP19GDUA3IrkkL4niaW799x0VNOmIXq6Vo4n2dPoeIsz4z5WPBE7nze8IZo7IHm9Cf/Z5yVUVZE82IMaVTppTHx6KdowMGlC244ocmctAxIqmZCMykbVuKbKNfOCeDuWSGiDmqT7N1TxlzjkVi+knvLfRAoGVJ3mvKR+QDFrb3fHC8f7zvwvkgZU+disJbQsirnMy552JfwoQ0B0Ugc4qW4izwUub5NPT/ilzHqCE+cVcpF8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c867ba-c05e-44d3-b5bd-08dee141429f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 00:45:54.1701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dIzRNHpfrZCagPicWRsbrCSm8QnTBTiKT++33lswRjuVlAcWZEbzWIGlH27jCqesFu5PrbkyJxTIkv4w/Sku0csWEXqxGBoIAv7JDbczDwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF3CEC6235B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0
 spamscore=0 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607140003
X-Proofpoint-GUID: aqaAOMA-TjINUnzVNjaJyB3426_3QJtK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAwNCBTYWx0ZWRfX9nZlRbm2lhva
 5e1RiErk1SCpGJc/p9g1HJfS/bpsWajvn5s0NshyexrpHlwpGgyI35dSsSHgvfGtvqtgjual9hn
 92faJHWpaNCMsNe/50N1ACclZe2bSZ6RW/DssPtcqZPxrxhZMdf0
X-Proofpoint-ORIG-GUID: aqaAOMA-TjINUnzVNjaJyB3426_3QJtK
X-Authority-Analysis: v=2.4 cv=dYawG3Xe c=1 sm=1 tr=0 ts=6a5586c7 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=s8pL1Iw6ciFnC1iDk1EA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13633
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAwNCBTYWx0ZWRfX/Y0L6Wg1RpqU
 g/czSQs64xp/asFGS7AnPjJJF7r7EeBJ8Uaw5VKOh4EVplLEzivURcfbxAGc5cWCxTuoUxCHQWS
 NLPiKD2vSP+zqg/BiGCdE73Hvb16caWpPSygd7dh06/nBGBwPaFNVZ4V5HqS0+KNEm0hYyvxljN
 RYWGsrQ2xLs8IyWoLMjuG7vXd6DV653TWCU+SWcQwFnHifUfMElk//wrQvnuHh0MQ5sJH8oWdrC
 eZPohLUqJgnRPt89RF9iNrjmp9NyTFXRyak2t8N67LsPyTMqb6BCcDjqQAs004l5xrXmXLdQcee
 ynZQzj7fPfScMk8J1QJrf9KILyFhP1ffvjBAsKqANQM8pst7tSztelXFxS9AaRtxom49FwDq7GV
 9DjbIU+dDt+954b/yBadwPixlGwuBy8c9xG54fooSha7JPGM62eKjK45L5tdt/BTZnXbjZnWA+M
 PfclL5PzjX3VYL35JDrQq5nZWflm0wD1tlkWkLqI=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_174600_934239_09B62BEA 
X-CRM114-Status: GOOD (  21.88  )
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

Currently, extensions are called for every page, including compound
tails. But as it is currently implemented, once a compound head is
excluded, makedumpfile will create an exclusion for the entire compound
page range. If an extension returns PG_INCLUDE for a tail page, the
bitmap is not amended, so the tail page may still be excluded. Thus, the
only time an extension's decision is respected is when it is processing
the head page. Similarly, if an extension return PG_EXCLUDE on an
included tail page, no exclusion will be created, since the
compound_head check will skip ahead.

We could fix this by overwriting the 2nd bitmap's bits for
a tail page when extensions return PG_INCLUDE or PG_EXCLUDE, thus
overriding the prior decision. However, that doesn't seem like the right
approach.

Even if an extension cares to partially include a compound page, it's
simpler to keep the decision making localized to the head page. This
makes it easier to account the pages which are included/excluded, and
ensures that we can persist any necessary state across cycles for cyclic
processing. The downside is that we may need to implement more specific
ways for the extension to include or exclude tail pages.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 makedumpfile.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 46d9ac7..e882b84 100644
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
-- 
2.47.3



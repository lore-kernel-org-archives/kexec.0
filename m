Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F36C5DF81
	for <kexec@archiver.kernel.org>; Thu, 20 Aug 2026 23:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OVQu32jCr2SLvMfHLs08lZH9ABaQJ/Dt0WR49huIUic=; b=Qr81nHdnZfHGehcKMjZ0mvn87Y
	jCcYCBgHoLpMYavO/bbOWLcyKr61YPj5EzBODJrQwrBysh6IiQnR1F5rIA/VsFWXxt8NKEC0gdceA
	lgCin4Q9b2Jm53CAONw9UXaHwQYMmbJxUibCWAnfy4vzSDHKg0CPJFIUW/73Er2llUBxsvSvaBs3s
	Hj1DMZtLXhIC2T1GNBLG5H4P0Hmj336sWlXKfoUnq3QWsmP/msrsrx2rMdib6PB38yS0veyy5UxnL
	YF4hijFpNLhWVnCNsgUcXKdASwdjNSCYUhvuBheLfpfa+rAl6IKvk/2Amr7flSiz7/dgCvZwqrHAk
	UR9gPHUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxCEU-0000000CLHU-1Cqj;
	Thu, 20 Aug 2026 23:31:38 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxCER-0000000CLEU-3Yt5
	for kexec@lists.infradead.org;
	Thu, 20 Aug 2026 23:31:37 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KDOYHr4191347;
	Thu, 20 Aug 2026 23:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OVQu32jCr2SLvMfHLs08lZH9ABaQJ/Dt0WR49huIUic=; b=
	JNeiDTiMOF8CCcy5BynSz+oCNJZfmLVW7xdzJMyC1kEXQP32lWlcnJSQpR5WoNaP
	iY+GYSYHigzIkaHZX8HHIltmLpYUBgbJxtO32hmvXfZ+qcFwGudi8t4jD46If94D
	tICx4BK41jC7VRBIehiOvqYfZr/rNFQenzmzchbl04tSalbVc2oqC4rdJSvE9HyX
	vpEwz0GhqwHI3VrkxvWpcgduRlyZeDqo24yJ4ycJHxgeimIUldoh4yKMT/xGH5t/
	IarPEFHtp6if6N1cpfyMIUiCUpmAmhZUYoQBQe0HaY0Bd2wSI3HVuTMcNI1+ZkKv
	l5N8g5tkTCE48zGI2/TfgQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g4ydem7nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 23:31:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67KNU9Td034346;
	Thu, 20 Aug 2026 23:31:33 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010036.outbound.protection.outlook.com [40.93.198.36])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4g2ejfr30f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Aug 2026 23:31:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5Pro8nU8jquWr6z0QzPBjdtT5KGsyNq6F7GDwvooflTV613Hc5Sv3VwDJmGyrt391Xl1zFUg9/4ShhohD+LEV+tgqs+PsZ/7eDAM4KNQTkehAOzQ08EOr4WW8LEdCDSOynlG/e5vqpiAtnd55Xr7ughw8Zlh/izq3/xxozESvAAzTgGME8OGNYUDEVa+/pMkr4AizUYclUw9+BHW70E2FuvIs6hFxqSf0TkXxfjxYpq1yMMNevNrVQS8VBPrvnBYX4hxK3uq0dPvDwcv4+Yth9IJoQ2pDA3JnhocEqXTnl1CCrzuiNAly67yCBRdVJb/rNejZW27eQr/c1/j9j8zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVQu32jCr2SLvMfHLs08lZH9ABaQJ/Dt0WR49huIUic=;
 b=eNATBbFfZMsutPKUDxO+wuLUdd+oSmtGGoJ2VZWIjA8Kw31FX2MgCENtqLWR8OHsn9d6nZptMwK34ORdoo3ut2B/K9de7VIaens4JNZzaJuswcoz8tK1f1sWb6C8eh1K0todJKs4yrc5DNIwhErByyfRz3qnqCGg+eoLSWhjItZI5NRUSvDuL6Xjc6dm3jCcW5STZeXRqjI229QNtSJjQ4B6tzGceV8opooCqhyll1snR/GEo/zTUGOr4rndWihMXujiTWUezne7vHv3XRORkouPd1g6JKn3raQ4UEOHdcSP1k2pYCI1s1YRWVK2U+PxIxG5q0fQGCoUTOiiOiDHeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVQu32jCr2SLvMfHLs08lZH9ABaQJ/Dt0WR49huIUic=;
 b=aXCTZuRLH55aXbSmHP3JrkrRurG0OvbCwAyFsv9nz/xFhkKkMvjG/Hum13MrNhxpnNKB9mpPTjjBgYFHmWz/YHwSv9argB4XbC23MoIdojEYhxZrzqTmrIHmuxPO+7P7wxySPiYqKEe7YyCBCAXn3hF2eW1VhHKd6hovn3K2ze8=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by DM3PPFEABD4EF1B.namprd10.prod.outlook.com (2603:10b6:f:fc00::c53) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Thu, 20 Aug
 2026 23:31:29 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 23:31:29 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: k-hagio-ab@nec.com, kexec@lists.infradead.org
Cc: stephen.s.brennan@oracle.com, ltao@redhat.com
Subject: [PATCH makedumpfile v2 6/9] Simplify arguments for page checks
Date: Thu, 20 Aug 2026 16:31:11 -0700
Message-ID: <20260820233116.3105747-7-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260820233116.3105747-1-stephen.s.brennan@oracle.com>
References: <20260820233116.3105747-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR15CA0023.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::22) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|DM3PPFEABD4EF1B:EE_
X-MS-Office365-Filtering-Correlation-Id: 7de7f299-9238-4502-fdd1-08deff1328ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1I7ZOut+Vl9LoWvp37HkbEooRwl6QPHvYwWw1Xv4GkkMUMtis9DgGZLoLQ1rGLn3+chLEg9wA7Kx1wVs5AjgGA+mC9s43cZXcqKTfI9wv3cDtKOE7E2jxzMzzGIUP9ol+g9QCh7aTHFBGZRFcCXgaTQnk5gikS+Lu3OBT+A+SST6zir8mWIbbu4Je/T0JOCIlJ2bzFJ46d0arIUiiVWDS97N7mq5RaETSNQx6e17Xg8W9TgMQjJi+Xzx7MNDWzsoEhUoNrez2Ht3pVu8o/IdHR2ieADb/G7fTsNAyrcTgJbJ1S7A4Z2dVxKZ/jYJ/62VL6ddJCrP1kWuMPVlbaJQ0vHWl+9ncnRY7sSqpAbWE31xqB70TE5tZKPOt8C+vQs4BVxcVU9aCU+/b/2ORzIcCw1y76xf78rd24m2lvgn3bUR4vkBwYu7bIH+zovEKJOBxZTIUmv1SE9vHVnWiSvqM1WNJ3wFC7jQbYvwgmjLBZwCLoTeDWsJHOviySjvJXjQU7xd3RL89UHTBJRNv4xqmBWVvh4QR11GZUsM1bDzTomRFpgZK/xqBKNKrmZTkOoKfJxRNDyQAHf8/pY6Puha/1iuWM/d34VAQutyvM54jvJTW9KiDwGgltG+kYb5/9veOp7/ouyysEBiFBhHyEl4+eFsF8RqMFC/cTVfW+jbGlU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b2jbLnBSBP/lciMetrghpVOBstKSqZdgp8zm/671cU2sfHXgg/7cx3LSbCaP?=
 =?us-ascii?Q?CflXddRad1GjYDGuAaKlKbRL42IULNKZRQf0L7x5rLgYQJ5/DvWKxAzAeIQn?=
 =?us-ascii?Q?u/9L2CcA9eJlFIyPlWlnIOWiS3jFXhNJb/laBV8P5PnxM9zb8LYMBKrRz8RC?=
 =?us-ascii?Q?vLDCDl0O7ochRgsWaKjuf6VCN6VGm8kVOH0sT7mYY2wwvt2dZAZDOy8wVtie?=
 =?us-ascii?Q?LHzGtd92O350FAnOCkMTOiMhQqYTuKm0R841o/l7wUZ3znpeaYzLTEQmd2l9?=
 =?us-ascii?Q?VYElm6DtMzJpJb6bvDxslyt3GtYHLXzexb29IaS9FzXj+H2v0s9T0lSYOoGH?=
 =?us-ascii?Q?0UOgXA8EmUdXSZof1J5PevOXsa8bWtL7hrgEQiOspet1ju1M+JCpzJ7gH6gD?=
 =?us-ascii?Q?m4CBScvwqnBRyUGHHRJi99UPRqPlpWC7dpOjvhtxyy8zFgSr8Jt8puuDQwSC?=
 =?us-ascii?Q?v0AmQLvdJg+qqUIf4FqcxO9Qz5jnKV8lutQTmfIJtwFHualhfH0NdE43pyto?=
 =?us-ascii?Q?bpYHUnxU+SnvtOkS8OyiHFjQGhkXEJ1Kb2TEZSZk961XYExqYdhVeuW8CZUD?=
 =?us-ascii?Q?s438aZs957VAI72GvJ05FdLF8YNyhwgmV8DcCkyQ5OjWKosoRLxfmjCjaB64?=
 =?us-ascii?Q?p584fav9Nn75AsbrAq0PjugKuleORXoGanqnl1tFuEheoXKSMZUClg3S17FO?=
 =?us-ascii?Q?femQGV6lIaEc8jzjVkvk7aGw5a+9OTWh47cJlR3+PZTnIpWDlNbl+WWnmZ30?=
 =?us-ascii?Q?HnC3YTpiZjwhI6/FwOWmwfz1+jhdVh0ywYmO/QeL8KJ+jXzP0czjWV4nYbQO?=
 =?us-ascii?Q?Cu+8IMXb6FTGU2RvCz8ewctS/HUkbNXFl9SVzg0uqjMpxIgmo8Cv/JDa30qT?=
 =?us-ascii?Q?0bDf99bxB2CENDPTKDXrCybO0uM75+xOjwRwIzc2TWBP/4tiTKiY0JTRv5WL?=
 =?us-ascii?Q?BLvr1IbMKAMjr4bed+IcvXr85nZ6xYHWcaQAFDIjOkBoloajfU/GxQQBcXX/?=
 =?us-ascii?Q?z2HbmAEoPz7EceAKgWLJfb4NeYFb0riSPjhk3+xyh4AF1vpCP2A4DL2yKkYR?=
 =?us-ascii?Q?hThFwqhvfqahKBeW4yoztMDVoka9Phbh1jP9WCfeAKRNQ/T2t2lmK9dRZDtq?=
 =?us-ascii?Q?8/su45ze5TAn/I3qt1yy1HcDLBIxLedZBKQ7PSMb0KrfMp/bqNODSoAtbMq5?=
 =?us-ascii?Q?2U4UuZl2gPr1YHmGfQat519crji/nxLugmhl5N/siTCEMJcYNCd21bR7/uqk?=
 =?us-ascii?Q?IrdCKYBCT3WlO6LapL7rg//jZEZJpoO2KQNVb3O9LWjvVjlmSLsC/EUmNdKx?=
 =?us-ascii?Q?hMWky5MFNBBa7DBN7GAkK/yGTTMme8dy5thk/y1z53Ndm3iNkbZE53Obicce?=
 =?us-ascii?Q?UD2fi2HDj/1spG13ttm9aQNUrU6/a1iGQajfTLqbuLwMpaiNN9AqBMezrxgY?=
 =?us-ascii?Q?4RwSyx29G/6wudyzfwZzY7oD3BSlAo84J2hy5Nnh8Ku9iszseA1ruSohTGqB?=
 =?us-ascii?Q?PlJKI6FTArpW6D8cDzGmcEkSFVog0c6z448Mr0iSyiO/5TkYiQ35HMhoAhZG?=
 =?us-ascii?Q?zk92VbQ6VeFKBzsl5U8Je/lkAfGl2h65DCaEznfqi0tosoy4J7/Oojb5toRn?=
 =?us-ascii?Q?BhWkehSWCRPQLeqszqt0OltRrINdYPan0mmgwr1jhPAog9tnDvvXsr8ydIGL?=
 =?us-ascii?Q?m/IRSH2qf0CgTh4efSnLitObCImjIsRdtMPnnOqGTdPTnvbsYna1W1Jd2JCX?=
 =?us-ascii?Q?PueQsdN8mqvQTLC2XGpAU5wfaeez4G0=3D?=
X-Exchange-RoutingPolicyChecked: BGI/nx0AK/fmmx/RtjH6+ocXDim9lW6lQu4FDaHvrjly+LDom1Zt31qvemO0Nr0kVvSCk8nBoxeCdSUqmRrOHlq9v5+uGv+64FSrJfq1AAXHhyB4iS7BUjXMffXCYMyGgEofFC8sVTT+8ehxl1o5DjxYLXPSyjOvagpdePrh8VHEo7rlIjuh8z1tWVf/MvKHA9FX6HP6qjjBrNOl2IKjNVlFLvrEPq3wxMJEHe/ruZN9R9KyOjL2u4brCPxp9B1DTvX3152BsP4LHSHSgPF2yTwyA6WAdTX6d9q0yyWnZxV6pNueUfVl9/0okOG/q0VEM6G9TF8/6iqJ885DXcjpdA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RFnuS4loB9LEA19jCQrKypL+iHoPFeUFphIDIH03c3K+Wka4ujUo3oMb1SpML2pAdgKAHF/6Ytoz598rcmop7Yff6ol2hyHrhDFTRK/R+BLrYAPb5rYQ4s2MfyPkH4LqpOw1+NLOotuqE8/Zur81cIvaCLd+GoaEgFCf/U2cY4AG18p3Xw2rTMOxBqLAR5SH7tcIesC54kgd1F71rULeW1pARSoPXvvE4Ln/ZqNiphUcMYbn3Pa9t9m4N2/jrmUGz4TXQFkmcXPNknglLEZGefJuTM1z94xuqt0zi69ehrPxpPbeIObos16G7szr1wzT0TRaMyg3zWqXr5jMZWC7gWrDWAfJxI5ywNQsPdXJiJsGGvFSQ+jocbGQRhGTFsqDs/djJRJanxogxMVSzuQB68VZdpLGvjhrNicWEeqUVj0VQ1on4GCehm6DUaesDK/xwuDGLJGD36SNriUau7cuKoWzxLRxdpRLYoI47tRjX054nNgAmnRXvuCBWB20BPT7Jl3VDXOP4OzVAlNsvKMeb/GAGFIF8EnTS/QdUKm7MvdiGLlEBEjStZP/eR3wStennanJfKntISDZk3gBtvSu985wsnj17HhYcR6vRk+PY1g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de7f299-9238-4502-fdd1-08deff1328ca
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 23:31:28.9390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+S/d6Cvrg2oKpp1Il5hXiPrqEzqD4jTuNrPdX2tzNhfdR/p7N8fRcQZRIw776PSspDrq1rAWCjMwfeBp8DXqFvGKLuV47QcazWcAKE1jyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFEABD4EF1B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_03,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608200175
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE3NCBTYWx0ZWRfX1Ljn+4dHhCaX
 1JARkXitO/4KyeTyWfEVKgbEkNO5AwV1HNiM/K+KHaqpFbiKcWdnUWTbkRVxLHdvwNlhfhapoRo
 fs3bOZtyIhx1LHvH763lNrousM0ILzM9SFe43Q4ANQaIHH2pWbiy
X-Proofpoint-GUID: w51cnWe_ntV37PbSZmYJSR0en67-O5dd
X-Proofpoint-ORIG-GUID: w51cnWe_ntV37PbSZmYJSR0en67-O5dd
X-Authority-Analysis: v=2.4 cv=WNBPmHsR c=1 sm=1 tr=0 ts=6a878e56 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=L3RHz6znq6SOOwo5v0YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE3NCBTYWx0ZWRfX327uC9hS/jBF
 Q5qRm5QwWW79mPw83jhv73GeQZ9u6dD9xxms0LL+MNivnnrQ1nQteaKpYhtw8ayJDKOboBs9Ywi
 yAMIahxxVxG31fvgQT4Lg8m1Jwxgmu4nlcXFZNaY/xPJKDs4SsppvpJWJaueCv78iv3UKmqzXgP
 WOD5py7YXYF/734DIU9lMJNMqhco6LxZlqm/9+pltaxRf2IZe1hRX00L/nLSX4mG8IwNiA/wW9i
 v5Mz26jp+Sh1yo5T/U1fnSZTOCtGjLnxMQS/814Fdrmqgwu/v1hTfWwSrrJA3v5vmOQBepGl9NE
 9ZzOMCAHQqxgvRPFhlBQd+p1p9kZEHCsNA3fO6O9j78kaCk5wGRbYDTLznxEGmShsW5XQvEmjPY
 IqsuQxyHRB9aGS5xy6Tbi66u2eXq9ODOgolXyZwffwrK8+ecLdhS/uvbBhrfHLBikfoUJ4ABgWS
 WnVaJblQH8A0YvQ02UQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260820_163136_014546_E0786A78 
X-CRM114-Status: GOOD (  17.42  )
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

Many isSomething() helpers need to use several fields in order to make a
determination (e.g. flags, _mapcount, private, _count). All of the info
we extract about a page's identity is now grouped together into struct
pginfo, so we can instead pass a pointer to that struct directly. This
makes it easier to read and write the code, and it also sets an easy
calling convention that extensions can use.

For helpers that require a single field, e.g. flags, still pass it
directly. The benefits of replacing that value with a structure pointer
aren't so obvious to me.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 makedumpfile.c | 22 ++++++++++------------
 makedumpfile.h | 21 +++++++++------------
 2 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index b04a1e3..6c62930 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -6008,10 +6008,9 @@ exclude_free_page(struct cycle *cycle)
  * For the kernel versions from v2.6.17 to v2.6.37.
  */
 static int
-page_is_buddy_v2(unsigned long flags, unsigned int _mapcount,
-			unsigned long private, unsigned int _count)
+page_is_buddy_v2(const struct pginfo *i)
 {
-	if (flags & (1UL << NUMBER(PG_buddy)))
+	if (i->flags & (1UL << NUMBER(PG_buddy)))
 		return TRUE;
 
 	return FALSE;
@@ -6021,13 +6020,12 @@ page_is_buddy_v2(unsigned long flags, unsigned int _mapcount,
  * For v2.6.38 and later kernel versions.
  */
 static int
-page_is_buddy_v3(unsigned long flags, unsigned int _mapcount,
-			unsigned long private, unsigned int _count)
+page_is_buddy_v3(const struct pginfo *i)
 {
-	if (isSlab(flags, _mapcount))
+	if (isSlab(i))
 		return FALSE;
 
-	if (_mapcount == (int)NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE))
+	if (i->_mapcount == (int)NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE))
 		return TRUE;
 
 	return FALSE;
@@ -6589,7 +6587,7 @@ check_order:
 		 */
 		if ((info->dump_level & DL_EXCLUDE_FREE)
 		    && info->page_is_buddy
-		    && info->page_is_buddy(i.flags, i._mapcount, i.private, i._count)) {
+		    && info->page_is_buddy(&i)) {
 			if ((ARRAY_LENGTH(zone.free_area) != NOT_FOUND_STRUCTURE) &&
 			    (i.private >= ARRAY_LENGTH(zone.free_area))) {
 				MSG("WARNING: Invalid free page order: pfn=%llx, order=%lu, max order=%lu\n",
@@ -6615,7 +6613,7 @@ check_order:
 		 */
 		else if ((info->dump_level & DL_EXCLUDE_CACHE)
 		    && is_cache_page(i.flags)
-		    && !isPrivate(i.flags) && !isAnon(i.mapping, i.flags, i._mapcount)) {
+		    && !isPrivate(i.flags) && !isAnon(&i)) {
 			pfn_counter = &pfn_cache;
 		}
 		/*
@@ -6623,7 +6621,7 @@ check_order:
 		 */
 		else if ((info->dump_level & DL_EXCLUDE_CACHE_PRI)
 		    && is_cache_page(i.flags)
-		    && !isAnon(i.mapping, i.flags, i._mapcount)) {
+		    && !isAnon(&i)) {
 			if (isPrivate(i.flags))
 				pfn_counter = &pfn_cache_private;
 			else
@@ -6635,7 +6633,7 @@ check_order:
 		 *  - hugetlbfs pages
 		 */
 		else if ((info->dump_level & DL_EXCLUDE_USER_DATA)
-			 && (isAnon(i.mapping, i.flags, i._mapcount) || isHugetlb(i.compound_dtor))) {
+			 && (isAnon(&i) || isHugetlb(i.compound_dtor))) {
 			pfn_counter = &pfn_user;
 		}
 		/*
@@ -6647,7 +6645,7 @@ check_order:
 		/*
 		 * Exclude pages that are logically offline.
 		 */
-		else if (isOffline(i.flags, i._mapcount)) {
+		else if (isOffline(&i)) {
 			pfn_counter = &pfn_offline;
 		}
 		/*
diff --git a/makedumpfile.h b/makedumpfile.h
index 3d64677..cf9d22b 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -161,8 +161,8 @@ test_bit(int nr, unsigned long addr)
 #define isSwapBacked(flags)	test_bit(NUMBER(PG_swapbacked), flags)
 #define isHWPOISON(flags)	(test_bit(NUMBER(PG_hwpoison), flags) \
 				&& (NUMBER(PG_hwpoison) != NOT_FOUND_NUMBER))
-#define isAnon(mapping, flags, _mapcount) \
-	(((unsigned long)mapping & PAGE_MAPPING_ANON) != 0 && !isSlab(flags, _mapcount))
+#define isAnon(i) \
+	(((unsigned long)(i)->mapping & PAGE_MAPPING_ANON) != 0 && !isSlab(i))
 #define isUnaccepted(_mapcount)	(_mapcount == (int)NUMBER(PAGE_UNACCEPTED_MAPCOUNT_VALUE) \
 				&& (NUMBER(PAGE_UNACCEPTED_MAPCOUNT_VALUE) != NOT_FOUND_NUMBER))
 
@@ -1763,8 +1763,7 @@ struct DumpInfo {
 	/*
 	 * for filtering free pages managed by buddy system:
 	 */
-	int (*page_is_buddy)(unsigned long flags, unsigned int _mapcount,
-			     unsigned long private, unsigned int _count);
+	int (*page_is_buddy)(const struct pginfo *);
 	/*
 	 * for cyclic_splitting mode, setup splitblock_size
 	 */
@@ -2657,28 +2656,26 @@ isHugetlb(unsigned long dtor)
 		   && (SYMBOL(free_huge_page) == dtor));
 }
 
-static inline int
-isSlab(unsigned long flags, unsigned int _mapcount)
+static inline int isSlab(const struct pginfo *i)
 {
 	/* Linux 6.10 and later */
 	if (NUMBER(PAGE_SLAB_MAPCOUNT_VALUE) != NOT_FOUND_NUMBER) {
-		if (_mapcount == (int)NUMBER(PAGE_SLAB_MAPCOUNT_VALUE))
+		if (i->_mapcount == (int)NUMBER(PAGE_SLAB_MAPCOUNT_VALUE))
 			return TRUE;
 	}
 
-	return flags & (1UL << NUMBER(PG_slab));
+	return i->flags & (1UL << NUMBER(PG_slab));
 }
 
-static inline int
-isOffline(unsigned long flags, unsigned int _mapcount)
+static inline int isOffline(const struct pginfo *i)
 {
 	if (NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE) == NOT_FOUND_NUMBER)
 		return FALSE;
 
-	if (isSlab(flags, _mapcount))
+	if (isSlab(i))
 		return FALSE;
 
-	if (_mapcount == (int)NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE))
+	if (i->_mapcount == (int)NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE))
 		return TRUE;
 
 	return FALSE;
-- 
2.52.0



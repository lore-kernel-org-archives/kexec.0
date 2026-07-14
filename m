Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1454BC44509
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 00:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZnEyvdnQ/uTjTZQvYMfQ5ic/yUlbEJQJ1aQa1EHH0zs=; b=2DJ0/pAWcL9il3vlmOu3YYD5gP
	kGH2pYbj6orJ0pCTsBoLsaUpx/JD0bKtEIv+soKj2LLqQs7yMBG45oLu1Ikg1sM2JQemz2ap/VMBh
	mU5Mcv/GNm6BowNHK96nSROLh0ajeHaZwhH/uIjlB3leDJhASpInJpiHrPhdJw+0oM8QW/3V2ZR6H
	tHCmiGlMfMf29JIEXwRU2WzQ+i83K5HDEV2oGPniglle90CzBx3wmyYucohlD02o+Ph5w8Q7yclIT
	8lPI5d1lki55W2Wi5mCcmK46ODoQzbWzcaGwT6XSmblNpK7RSYVryWNB5935BGWEpdOOjCTG6xGFn
	9GE70MNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjRHk-0000000AcIa-16Nj;
	Tue, 14 Jul 2026 00:46:08 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjRHh-0000000AcFw-3LFp
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 00:46:07 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DN4DJ12553080;
	Tue, 14 Jul 2026 00:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ZnEyvdnQ/uTjTZQvYMfQ5ic/yUlbEJQJ1aQa1EHH0zs=; b=
	O/1x0vrmvxZo3oJhCoWDc/HEPMd6YE3PH39a6lq8cvkDc7eoC+tRkHyVCgOfUTYe
	7MQTrl43LQDgiSdcka3SBkHj63Bul9CzfzrPmo9j9mWDpO675Be0F7XN//gnM58F
	UGWpTBUra1GEbj/aa83WTzQPdWGwZCcgxJMCXjQzj73ecX6NmVXRpsPo9shphhYA
	fvzOePaGkntxufPJ6XzwnVmC2pBrsgvnBN09Sivg5DqLyC99NQqkw5LfvL8x+e/V
	jNEzLgjMxsIaSKztWWrI+TcoPu/iUp6nnWN54JL13TdQ4o+Za6CZMVrwnqgkvf8f
	JAykYnVexiRQbi3v2/RKCA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbef0u9an-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 00:46:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66E0NZV7015056;
	Tue, 14 Jul 2026 00:46:04 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9qk9me-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Jul 2026 00:46:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFL5kXEmqiMsN9VwfvGL46vcEKotSzifpljJNbzAmZCjXqnNxeDcEDEUxAZg30id2lnEUwEIUqsyldqvHUG4d5pNTqCOy3l1y8d1hyRjhxuNNQGVLRrM1ZMpFVJPI6x1RyVZHT7WT/K+9kK9cwVblVTyjiZIVNDNOE8+27APjGp87ni6WvaWT3ySuyvC2qAo3UOYjijP2biOHXLbMMLay2xYZBL7GGJl0FZv5ZWgRwJ4T21Wdbf5/tyCm983Ijjq7sLzNhFgaQectr2gep91TZonh53S58SSd1VlaflV7fdGDLn0bTngaH8HyvPQY6ccTzfozVV/2D+SK9GYTy4AmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnEyvdnQ/uTjTZQvYMfQ5ic/yUlbEJQJ1aQa1EHH0zs=;
 b=fo8wCa9VKt59PbK9QZo9m+17AVoXASu82D1SZquxNVqwLnYThAQDHva0mEhUDZ+LOUIGaHObeSp9W+vCVq+k1QMR+CocgQ4arqfAZJySQQLChIvDHenwmQ82V3PNMDVrW4xNmY91sQ7W+qxum96Oiis7RIBzL3uXrP7D4P/ry22VdU2fVJ+W08XX2uSWZimIdcLDakyB/fWf+Cp0VJjq+uxYw652XoD6zD6N/thshdQS6fj7jcTtY8hbPbawGdy+Rfg2UgcPaRu8l2FQ/fJQ+u6EG2hfpoh6bVmvYV5r0+nJKjU77DXqPEiJKfe97ngZdqwfvgovIVfz4LJ2Rj/9pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnEyvdnQ/uTjTZQvYMfQ5ic/yUlbEJQJ1aQa1EHH0zs=;
 b=iUPrHqsan0zaioz8C+iW6Pmp3jO+BfpfIrU/GktKKEngLhtZ+T24oERYClD7qJj8mdB/ZXmDjXbOL/ZxAwMkrUsi8BLGg2zO+t6erUasfcu88ufYq0SkE73WjcPrltcgrCr1RATr7wrVgwMu9C1VbarRpYH7Wjy0lDtkXUfVXqI=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by PH3PPF3CEC6235B.namprd10.prod.outlook.com (2603:10b6:518:1::796) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 00:45:58 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.21.0181.019; Tue, 14 Jul 2026
 00:45:58 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org
Cc: ltao@redhat.com, Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH makedumpfile 3/9] Share page information with extension callbacks
Date: Mon, 13 Jul 2026 17:45:36 -0700
Message-ID: <20260714004550.3698175-4-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
References: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P221CA0084.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::35) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|PH3PPF3CEC6235B:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a265385-8f93-427e-e830-08dee14144d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: HV/+YlWTje/dSYxdXfPV2IoUWhdPBduKZZ8RlH5Vcbq4kEar3W9a6e7t9WSfaeb2IU53Eubh2JGKJdHAD+ZInPHYsxdrrW6+bb5Jnh1iKwzVe8Pxh1B/hDr5oK4EmGg83zTQ5qnU1faweQRpIRWDWQdpERvySNpsyvjD2YTyNyf6UCcI3lbRG8TZhRuWdb4f2PYHJErMdUQLKkrRBBckJvvMzWFR1rOdUs0vR/1HudLQBJBqxdAWiS0TCbskAY2ngdeEvQT6s87KHy0loS1sV7FfDQ3HA/SWB5cyeR4G0W9iXAt0O2yA/aAPA97+GcAA9jif6yXAm1e4UawjmwuuFBYaG6bqvVWwOCTqP4RRgqjKRctCMHArvf2V22kJt4E+3R96VAINiN36IhdJvt8oifZhRlFTu24+xR/tRNM02njR+cLTag4DYoOJ8mYQKtJ+viXYTm8iGQffHFSrH/ccFWziqSuB5vJiTPiugD6+FGpRXDm71y5suAaQoFQiZme2PFexqI/MNf4cay5NvIvutIhKTnHAeHu4bAlYTdkZMHACjH9qP/jBwN7tIenGy4DjWuBaCO3zTBeqUpBT3y88kQwOfNAhf43vBcjzSZje5R7ax6MKIX6QJu95RRHH028LF3Zn3SD0KVH7hACwdqknHhefR/YbFKTpgRtQuCehkAc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gNT00MQ4HF3kf24uQoQqm4SrDJg4bs9/pmJV0tzcKnkTIMc35qh8Zy8cYrFt?=
 =?us-ascii?Q?siB5m/gHRrHyJ63/neTReK5BFTnpvjdlVdQDnENr7kM0bucXGxmLeo45uF60?=
 =?us-ascii?Q?8dApvhz/EYaZI3jAVmw9/9GkoQBcRW+OEKZleCnEvuHNpRJVVHoX/iPzyGR2?=
 =?us-ascii?Q?TSqRKf4Fr+YwSxf08/b6HISeSOLPabxr3ge1SQhDqxMltQGxFMm1SK9cGa75?=
 =?us-ascii?Q?58gelzZGL29XPvlhEk9ROVkoAaH3t6OLxZbMZfa25BHhri6T9Bum5yWsdNv/?=
 =?us-ascii?Q?V8UsbXmg+hhldyLoyQWfV1nMsXtU1OYqUIRZsgfmBTQmpSg2pq0DFN4WPQ7X?=
 =?us-ascii?Q?TxRBjuUItLjfLzwJNf1KQafrsQpsBJ8Pty6IU6YdrlZySx0pNeI1fRw2Jhcl?=
 =?us-ascii?Q?E+dgfio/5g0P4wK9HzNkqC0e9vnWufNOwlGdJ6opATpfn4ULvz+z508f1Z5h?=
 =?us-ascii?Q?pn0cDJjB0QRk1rnnzpCPXnH0thoHJ35hZzj/57dn0CMQS/M7fsuo7woF4bFM?=
 =?us-ascii?Q?7ADSPTcfclU4L45ruXpR3coZIuxxw4syw1Bpk7UhFrn3LGePKxIhJUV1I26S?=
 =?us-ascii?Q?LsLR9/inZpiapfjU5fZYS0vFk7NMJjdGEKBXbrH2Hx/+XWjoyk0zpiK/J7Z9?=
 =?us-ascii?Q?4iS2aNQjqBGtRo1ujqe8Y3QpoIvDVVFjPDdPOmXvdRyoqWUScHfSR0ggfBRG?=
 =?us-ascii?Q?22Da+uMrKb2yDeb7miq2c0N2FI5SljYmojlEIA9MQ28+S2t2hhyYNcS78x4j?=
 =?us-ascii?Q?Q8cbyH7naSBWPW1z0FLqwYW+ffqw2hMLzfMgdQblhNCu2SQhN6BRKZRopM+K?=
 =?us-ascii?Q?HwdD0s8cqX5/l8xyPyZIwocWLdZkKTUlLzC70UzVBAN6iJR8PelTvyZ+Vear?=
 =?us-ascii?Q?rUWv6eIqS7/+JfCptapDi66wTmGPLFsZRMrKH4KGWk3HBUve1PbdAhNR7A60?=
 =?us-ascii?Q?iztVn5zTB+cyvXKCSWQ93+KA2CLkSCTLG1b9IumnKR1J20bunxiOeuMBRSzh?=
 =?us-ascii?Q?/6vSEws96dXmInRlfeV6YTpJbsbyhn8B1wkJRLbbTXC8wQdM/3MvEpdp9bym?=
 =?us-ascii?Q?Bep9AfUxRkBt6TTemu0reFcS1FGQNUC4h/IMYcK9BdirVkVPenrlqkpoVElP?=
 =?us-ascii?Q?PB1PKBHw2gADNr/n5fzqywb5u00JQqVtNK5IBImc8HXUPiZHy7AyozIwONmo?=
 =?us-ascii?Q?t2O4crpw2/U5y7DfXFwjDSn4+cK2hB9EGzZ1nI99BS+hvD2mm+VUfdHCBF7G?=
 =?us-ascii?Q?RbDF7Q3aPclMkCuI0SWx+9o9f4H9fSqOyI8h/AjfofhaldnIrmcPhqMXx1aw?=
 =?us-ascii?Q?w/Pkiv3a2kPFpBY3EIAy0cUJjEUU27nyaWIN6JDhEbkERixek05rZbDAqhN9?=
 =?us-ascii?Q?2DODiw987ZXk2HL++BpTyPen3x1lzYBHAjLpyT3sIRbtZpIyvog7HYFQMK+0?=
 =?us-ascii?Q?0W0zMUeY9kMf0Xk6ye3wBlTbXcfFfqhGPho92HYRuHKyQLQ89Q3IHab0ZJ7C?=
 =?us-ascii?Q?zqQ4y4HBBrO8y6leqVgkqiIaP4Wz8HpzAj+4hjClJYwo2+lKy3Dv0g7cZ1El?=
 =?us-ascii?Q?GybgIC3OyZVd+ZZtLnu44FoA5PLvcmH2BEoawfYmK6I14DvJ+vJpgluGi3ao?=
 =?us-ascii?Q?CaYrya7a5YrqXozpQed6E7KjWgBiM8Eto9ogJaYmK2SM8l0jSQxtnrzJQ3pT?=
 =?us-ascii?Q?Gvq3y95YjbEaOuTMndAe58ooKznXuV2VqFYx5slpjHaQ8HADxw21s5hf1juQ?=
 =?us-ascii?Q?4hWZoeupT+fM2rOweawGO/8dQK8Vrx8=3D?=
X-Exchange-RoutingPolicyChecked: qPwYGSqBvvf1I5KwVcKTbgKzSPE4F3yubf/GYvQPnRJD99M/v2xZ1gkaf1YIFrU9RFDgqP+Et8tx3iQp5kwObNgIl4+2HY72UP9pPjsVeUiWdCUo+OBc7ZGym8rkDdlHrN6fdE9vLpfCARTcwMTrVTFgJT4Zsn+kDqzpJtDjjSpl+IpOEDERt7grAgpWEhkx+41RYzU+A3rWCs/25AYgmXNyq46MdkLiN3IUgqXJH4SnR6qcI2WRHGzQo9aMHOa6yvCMBvT76hLChVdo7fVe8jHBTVgkCg2VkbpGcwAijgzZFbtzLuFrfTVHYtrCQyG2re3QctV6gOKdoFygOp5q+A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FwsNKOCdaHi3z2d36JdgI31ySLcmoqezStzyQnWU2kUwgwBd74OEUTRpjC9h9IeIqmDT2AP+d0b8MfC9pfiwyPIulgkp+Xa0ynwZCcAQuhnsKDeLjNEVjvE0RaVNQQEmaXaG/+0BVy//CUTU8oePhzNMpDgJyPPXF0CxDbjfvZs9BTcC4ClkG/60OCU4zzSV0ZpcvOqkrf+b++giYeSC2GauEuUR9+vhVZFS9fs1sVJrYGq/iW6MBFaiil0AVigkAGdtNGUDLBTg+T6elELqZjXv9YF9zzEnb8Naghn3JrHxQa2BFfAMqWP5py63IZ+vvulpn6IlzJn1KftolJnNWKDlX85ZopQLV4XkDEdjXwFndVtU/iXn53z+opVHGpdNcCG0sckEHFsr1eby0gbKwnwBXI09uppGqszFMNxYfQq4D5M3EMCQ+CAoj2+Z2xjxpbSggwsT1WKeCHJGcHfuySKzQYF/XRomJFLNLZknxzIOa21R+D8nrI9Kenfd5x4SbT5sarP6dvj3EuG3B/WTXMbtgdZ1jzbY/VuKwkeI70luRC0442tJP8sIGVgYedUVLADjE8mcAP7sfhtruj1k/iCm/VKr5f5XJkrvrY00ZpQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a265385-8f93-427e-e830-08dee14144d4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 00:45:58.1285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6NjecOXdYtRy2DMngH1kgJ41fbodx5N5tzY5M7rKQ9rYBZAEykDS1ztnKgRecOXDBRPYSww96khUsJOC1FyaBLhCUKf3zd6C0SOT3eqMDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF3CEC6235B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0
 spamscore=0 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607140003
X-Proofpoint-GUID: X7KoJDf0mmAhnRFU7vrKFhJ7QsljoH2K
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAwNCBTYWx0ZWRfXxHFt08EHn4un
 NVxZs8U6fqFHcP0mpDcbZPC2OX1VYaCWRqFtKTx5Cxs9jni8BF2ix/Z5DRgItpS+moXcCVL8bJ/
 AG9WFmEixVdWmMZ9xU7kHmJ1/Ovl5dEGCFJ6hGnc+z+zHqSx4Ryg
X-Authority-Analysis: v=2.4 cv=KJZqylFo c=1 sm=1 tr=0 ts=6a5586cd b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=BRMCUliFZU4PxBN4gIEA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13633
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAwNCBTYWx0ZWRfX+DbvpNSFnrcr
 II4QRfzuEVvt9tjceJveoFB0QQJhq3gLG2rEUgKOmtNauye3MCgOfEFkpgC7G4bZmEMT++pkX9E
 E4LhwyO2JOIfFlPsjnPQeYKLU1W5RX+UhyC7e5lCWHaWXJRXl/lXlwwbHQFGTEir+oejhk1Mz1e
 lsWyLJNrIak7xAF4Ztxex6B3JPVH7lkBQllt9as0QTV89usdzv+w/zX2O5LTATz2YFwo/7teoGd
 RAx9phYUeGqnqO33BrUh3GgRQqYhipIJJK6bNBi+czXOFfW3xmOMCUszFfdSWhJOAeu49bkNf/F
 dPT4KDdP1UIFR/HwNAjRxr9djyVhCvMHB19rgBNbCkciivSUE7KXz5JqxGVo/3A3lW31uNuH7Nv
 QCqxjURro5cCm9vAn7CpGrxI3fw8u866JeUzo5dxj9AY/vSuQFT530Ehhdj0BOuC6TP7QvTFeCQ
 NFZhp1dvkPIjWPoj6lxU7r5B7n2Y3vYFS0lJzS8I=
X-Proofpoint-ORIG-GUID: X7KoJDf0mmAhnRFU7vrKFhJ7QsljoH2K
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_174605_868022_8209F229 
X-CRM114-Status: GOOD (  20.15  )
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
 extension.c    |  8 ++---
 extension.h    |  3 +-
 makedumpfile.c | 83 +++++++++++++++++++++++++-------------------------
 makedumpfile.h | 16 ++++++++++
 4 files changed, 64 insertions(+), 46 deletions(-)

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
diff --git a/makedumpfile.c b/makedumpfile.c
index e882b84..a4c9bbf 100644
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
2.47.3



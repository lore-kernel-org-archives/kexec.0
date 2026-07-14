Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E26EFC44507
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 00:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N0qg++29RkPCNOyH4zxWkm6EHbpbteOzbwE86HGccZ4=; b=xyIv/h5lhYXwgRGRtg22utCcsD
	NK6xo5mZfmCgI99ABUPgbtPXAUIjgZjsb7vKmBN8I0AlQ/jRHIrvwhPo/+oIS068liM5BiztHLWtc
	E5XtvL05ifmfM5QdnilT64fdNW7nFjaGcwAx8Qx2U8a3Ya/vkEwEpJqc86pu34jb9RUmyrIV2181W
	JCq3oovfe57PeE/VqJazNH4PoAZAWgzE8T+/oLEJDTbcVTtke2CHiVP0AxTJZ4CHmBJGt8hYFpIKc
	g42mCjPEQUi3E7Qj7YnDzj6OwQDbDS3Y3iwSWvu5b01df+o2juS1FiezjVEJlMaoZO6duR7y5nLvR
	FzMbBSaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjRHt-0000000AcRn-0VfP;
	Tue, 14 Jul 2026 00:46:17 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjRHp-0000000AcO2-2To4
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 00:46:15 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DLEY951376587;
	Tue, 14 Jul 2026 00:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=N0qg++29RkPCNOyH4zxWkm6EHbpbteOzbwE86HGccZ4=; b=
	Xl0g4T2eU6kihVr7eBYc/ne8KM7Z3kvNXkdjd+ZjWKIc4qON/U+o90Esznl8gT84
	A/+ZeEp+bOKUsCq++sIT/tB/AVRX93ox8Vyr0HRPhKXD8waW/IiEguYYDgTo25oS
	JQpLUF0YVl5uuo8cCli9z4dbA0yNlBUvxkoywyNtbV2YQo4RhSDg+pxqo+A/AvvN
	BuhtH2ctmiuKDSPoZZHdCmKby/1GUcqvLRUU16ppqr8PxJNHrJu9U32efOt5Q39n
	d7F/OOLCUKVevYrlXWQBUTPVG8eAHlpUnRr8DMckuYzRNmv6fQo2K6V9FCgwSy35
	5LQWMKI5A4oLfG3P63nYnA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbed2ba7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 00:46:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66E0hWAp000843;
	Tue, 14 Jul 2026 00:46:11 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010010.outbound.protection.outlook.com [52.101.56.10])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9qv058-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Jul 2026 00:46:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hq+z4saJX9V9Eq5y73BtUysYmClVGM48NclExNLN11/ATIKYQ/yLiz3BYrDLGsXEBpKVT9YZuDTEIGu8G05TbHM1HknsO6kM/PNIgkMTOy107qFyf2sj+9AZqx4ITm66yxTrkof4uZsflt1zd3P373+J2Jcsvz/d4Lc0RGww8pfjl5ReFW5N58dL7oY+sNLa4a1fIjvjM5/FuQBly6MFxDiSqc1DAP+D0yNMs/NvgowAxzEBtvvXY22Fbn/4DR5OPzJlivKSC4bLVjWz42buwdaR2o/KRVdfA1pJGVT/7xo+2RgyNkIbtWNL0LtQtPur6I4IK9ekptGqDl90cgcn6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0qg++29RkPCNOyH4zxWkm6EHbpbteOzbwE86HGccZ4=;
 b=UjlQq+01P7q+BgrJGLWLJFPioPxDK/0ovtNkhKMwS1dGpzMbU8S67wHtvj4lDgeOtHrExbEkCm5Sdi0mN3xcGJ/Ahwk9oXqXRme13/Qb8ltkmZreZvFOGBhqeb2qnFzz8Kobgi3MixUCTdi7N5wyQ27wn8Xqjdo0BZjnRMdQ3QJVccZBKq6aLy9alE0TYf3RnUrkYlJYVIheLHrHo8xpLl7VUSVSYi+8TO1Cqz8m2Ebal1Nuf0cpctYI3U8ocvF3wgUNaXoFebAvUnr78A+d/Md6Z4aPdXcJ7jvkx2jbU/PmSBR+w6mYu56VtWjIxoyifTzBKyGys29yMdsltqxOdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0qg++29RkPCNOyH4zxWkm6EHbpbteOzbwE86HGccZ4=;
 b=P8UUFZQsQlfYZzdt7VATmEbwPdjWq6LTSdxcOnv5exk3Ua+6+A0PzhuJHMwUGU/aPVDPOvvwX80GMyWa9XE1HmgRs0sqo0Z98Q3U7MM1G+aheGpYqeUFIDJsYNf55ns5Ht9IyCNpikFTBRnxUlGzH3c0AkesK7vGDwuVAfiHMwI=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by PH3PPF3CEC6235B.namprd10.prod.outlook.com (2603:10b6:518:1::796) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 00:46:08 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.21.0181.019; Tue, 14 Jul 2026
 00:46:08 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org
Cc: ltao@redhat.com, Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH makedumpfile 8/9] Add userstack extension
Date: Mon, 13 Jul 2026 17:45:41 -0700
Message-ID: <20260714004550.3698175-9-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
References: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0014.namprd21.prod.outlook.com
 (2603:10b6:a03:114::24) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|PH3PPF3CEC6235B:EE_
X-MS-Office365-Filtering-Correlation-Id: ef29ec65-03cf-40a4-c73c-08dee1414ab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: CI59oochFEcmSO0hgz1QlC2JgURgZ9VYmeheUBPZJyDGwiwLvGQYcty/m/poshPHD/jFaOyzOaL0/s8/eSAWHyEF35P20cKkcENAB5Z7DIlpEC02dkRQeGv0u0npT2AEA1/B6jKCAyC9lirCdqRcqcDw0iXo5UZSp/nISN786f1Q15MySu0ZENLiQQsKtV63h+1EnAmNoJIcrbVBdefc71vwJOr4dTjt9017zdAwzJkCV0bWCTHGPJ60kOK58g27kTTkcNOyqlCanT604Siqk/yAxXZAgDL6CYENVOcC9Wbntb8Mqaw0N6uBmPm1uMj6d3Msty+/w3fcLuRs9e+zY1gTcWzcyNuCBlnDsmh+LphhhnwhVdSxnWK1irvHVwX7eVvSILb14sqTsFyk1DWBxdk0t07Lfaa4qLifHb5LIhr7JbL8hEsbpcRMxJb6mUHV+76fktLMc//csnQabzZiu9TL6yL1ZVSFYVM9HUcQQbmf67QAbU1yTmhChYXBXRLmyPF0aZgSsW1QOzuk6E49L8vFAQL+WW8QQaWdzlQtRnNfZntJ8gW1D1OPsAGzJgqd3ogykNB34rJoGNYcnBDPCYYettu3FjvULyb6Wc5iDJm3QWTjIJJQdGFnTn4CoI3C0uX2qFIlyBzBSQNlBGPnVMFNPlaEDy8xfC/jx1o9zAo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vtRBMJXPkbvH3QAMDSwiOd04mTXN+8PXaTJ1gmpPLE4OaquUrI3ifdQnRlPM?=
 =?us-ascii?Q?sji87o9bP6yw88elf4nvyKZX3DREfkv8cIXaBIrVCVeSSy5R9KFojnWryUK5?=
 =?us-ascii?Q?4kr7IEReBuyuYHngMk9dG/aAG+7ErLTHLh6JVZPm5Da/fCMzxDzFmNys6BUV?=
 =?us-ascii?Q?HZtClvdxmVts+yIsrxTNJnUqVPVilEEW6g5cW4Va+um373WKwNbFGLAfag7V?=
 =?us-ascii?Q?2Jq9qqwJ3SccLuQ1CEDT1Ej4/B7wZTQL0VE2VdAggUPgMLfPfMMq+fqmuVTa?=
 =?us-ascii?Q?f/yH2jFSuhYZp9qUhZrxZOqK6lUlA4I2X4P39FcBPBDy+dwt4uqHok3oQ0Lr?=
 =?us-ascii?Q?+VSt5369eVc6tt3kqP5Ij/lsYNwFcoIgWoQa28K3rAg8bkai9Zuwsu+ucpAK?=
 =?us-ascii?Q?lihAYh//p0f+5uGJrlbeu3tVDGkcqSZGggwosH5T2bE4dyytiWzVDShPobKm?=
 =?us-ascii?Q?eN7MYffJ6vGN4aOl63tM/4d9s2EpmMKgsMWPelqr/a2WZ3/jkiuKM2RenVqI?=
 =?us-ascii?Q?RSYTCp/sfyAq9QnwbUybwMpSuIPVjIe1BLq8oCUUZsVE/ycepiMF8z/HKrqg?=
 =?us-ascii?Q?uNfdIeIOJJY569lVBhmeeHqxyvLfZ0H98E4QtZaEQY9LzGTMrW5GREUWcgTu?=
 =?us-ascii?Q?6U9UhNMWTbAzbuOmNMeSYS2vzZDKUogD2vx3eEAZnf1p3JiXuz641TuTPu+Z?=
 =?us-ascii?Q?ejmHEdmqdQhUqUNzwotiVIukkM0KyFqA6tQJeaQRZYq5gh/BkQHnBbKsCjS5?=
 =?us-ascii?Q?SoYzHxA8pMsWKW9+TKlcRtlChuRmGAu7vM+WaGGN9oG4QbD008t56PYMTG+M?=
 =?us-ascii?Q?Y1JCSIOsAWNc8GZE4DZWs1i99zxXRIPPiUM3c4qXr8CSrkHWCOi6tpyHIXF9?=
 =?us-ascii?Q?RquHy4opWM5drDe5z0vniEi0Pyao7DzSoO2KOVefAVmfrqEWIbbTfRi0gww3?=
 =?us-ascii?Q?qCVPgQEGTMcN1SRzFSooP1t9I60HxArHofsarJdRr63YMsgzzBj6gOdPidFD?=
 =?us-ascii?Q?t9nRI9uisgjtWzyJgNL9GZqFdGDs7xTchujC1bhfYWCFmbbrvBYL1JFFfvCL?=
 =?us-ascii?Q?mJ8rt4H2LyleOMfoN5Y3gX4OK5EA5P7CkPhGJWnjvRQDVImz/zP2vw06cJBM?=
 =?us-ascii?Q?CvKDFPPusvcgjuxvSqK1zVYgDMQfUWHO/wMriDjI2KESMf1WnYEVFo98rA89?=
 =?us-ascii?Q?8jkDx1WLCpjJVSmHWSZoF7/mPL1SqygxvbFGouAqD55cWw/4c5mXuxy3RFPM?=
 =?us-ascii?Q?8y1O24LT+EjREEieZ0PAPdcPEGLn9UwKWq+mWCUk5X3pwuI2BpVkU4Y/V5aV?=
 =?us-ascii?Q?UqobLZ2k6ZTLEi/JQE8x0MzyQZYW0J6P23G7sLHE7jrrk22V5+NWS9+rGTSt?=
 =?us-ascii?Q?LuqzP6WwITobpAT7Pows+XRro32z3qSD5cejU8Fw7zRz3iBeHGgxYmnZV83c?=
 =?us-ascii?Q?9iwAdArO0jkj06V5XX77Od9ebuYxQbkEt9141ucOMWbWu2ZrzMCczP+Cml4R?=
 =?us-ascii?Q?8Olnjxki4ENF2Dlgbow0OmFgubz3upQzBK/DCN/s9rv5IdPMEsJV3mnxkm21?=
 =?us-ascii?Q?k5XHBZEdBckBy1m6Xmy1bAa3DaqqJSFP8X19ZglzltdNWfZZhvWv+iS8iGvR?=
 =?us-ascii?Q?h4Y493U1KBtybRf+x6C2/TZx2r1HV6yZtri3P5WdvZ/GZQ/mAqKz+D2PlFIb?=
 =?us-ascii?Q?KKMyfTn+tH8zpvGzJjveDXZ+Wh5XY/gJLws1ICxow+0X0L5o0dLU03IGoZpP?=
 =?us-ascii?Q?XffuEIdx162VZ3KfYDUKeJsFSihljgQ=3D?=
X-Exchange-RoutingPolicyChecked: PMWvvCbncSv2jJUZZ/XAAfKZMBGO5U9uywmg7ckZ4ujS/wRGxrtZeQGpsIIdi6B6yE8VHW1fp0E1BMafW5IlnrJPrlFMQnDxUsXI47sBI2v6iiJdkpY7lIOOVIpMRUOt+qcqQq/QFaFJfwAOtiZ3hXaPC4YCb4VMwYXYPhN/5Zjr+Emp1jG75I1VnZ2mWAegZJgAqgw3JDjN6tiwP3/pwzAgffVq5JJ7ZkbuYe5gDSS/WP1lIKHEyMoVQt15XHnNwYcv2/ZedRUAMEc9tfX9sGPrfqU8RovzRmv16Z41yhNv3tw7yokOZmp6UGU7ovk/E6IwhMeSe9XU3tTtJXeDbw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZcQoToqY56JGJTIXSpnp5hBDNFHZSWoIbACWpZ0VRJ7hid6nkg7SYn2dPOOR8vRw6hEOIGrKUXsVoxg7zg52FYrwxvtoTwBmYQH2fxRJ4ayUwgr54ajvQiHaG+XVIfAfwz54JiXTDSG1H5OwC7bwd5Asq+UdlPH8pu+H6uMfFb7R+QXpFnb4SEPdVoOscrXq+WrsrPM4UvTm7WZLWnz8r7TAf5i1xutbMm4jnEmWA6SNfrIUmpssp3HZ1DnJkyqcm+Pg9VKPJELjr33dkVn+ZPnj/ub6LMBEJq7UmPZQqFQ3ecE5isJJ3ZUQ+7hjL2S7MqW64jT7qRa/acsO56foUMvHc+H9SMg6k3/WxQZSwtK8Nm/jQXmi/L71tq41aVFi6VV9aD9MsEy1FAPsBww26W8ZSrlXfupZJVcGChtr04hII9Y6YVzDm5Dy+mj+8f5ebCc2qQnVzgd9Frgd4OgywpvFy9E58gXB9UUWvKSRHoO5zKHE23eimqX9APeml8psASGG8zWMLvKt6Rr0gz+ptV7rBNmaboO80Y290DmMbrv2UH8AcO/qs351FFopUBGj9josIsjKpfrT0j56bfQAeWLfr7jjZuzzz7/CDqgz9ww=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef29ec65-03cf-40a4-c73c-08dee1414ab0
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 00:46:07.8455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rN9AMQSm52M40cvmboaOR5PslbO1mnSUTHFpNANjODgO9hQ2mvlJ3j08aJd5bN56Xx++F+KrnQFlbjizKsSALzhOLmtrs6k6u/OLDaeEjmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF3CEC6235B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607140005
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAwNCBTYWx0ZWRfX9ABXgpX+SKGL
 xijnTSgPTtvUmyuvPhc4mHxS+pDnfCcFD5iFx6mQHuzKA7mM2DFJzuYK3D654ZpwLNp1XNl4Rlt
 RTU6Q4cKgWyVhvazECmISBiA5OpWs/3xPfbD1ekQ13tiasBvTf4+zSWsMw/dzUa0vQKjOlSp0Le
 WsiLGRgSDP70ABb0faoq/h/84faKCuGXAwghmo+4ejvP5m+kngurmf3ldlsAeYDL92yKnu9f1M2
 KHqzHg/z61LK6butm5PVgYYztm1Wjjk+eOoq7gHTkIUJNBDh/VeUGj1cw759jXV5GAysnyD+bqZ
 aUAhIRN+CSBIojZtbJLTMD8XT+euVkTMU9AivjTL/mJXVfFNfWuv6SlFiZJW6AKl/KWbkB8XABX
 gM06kVlawvp53C21Pm/nJDD9ayQ7nH8rTiXm2B2yHpRvw72MWROIxVK6RyczXPwC7UyUe1QiTSL
 Uq1Et2lDAA7Kj7mV1Q7WJGaAgIgmDrwDBWGCRBsA=
X-Authority-Analysis: v=2.4 cv=GcknWwXL c=1 sm=1 tr=0 ts=6a5586d5 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=i9XWJ5Kmf_Eq65lQOmYA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12222
X-Proofpoint-GUID: G2ZtJ892fo9Rbzrd5NrRqOIy2ZXf7NEM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAwNCBTYWx0ZWRfX3KfTrQRUQ+5B
 5E5W7U3yMqkCFtdac8E3MsMd+vivxstk13NoWTTUr49kzaU1ypw8X2zfmD4L2occ552mjq1C7wo
 4/qULTFZw9+XyrYrN2tjkWhj4DgQr3ow4Nb5Sd8AKBSD41+O2B1g
X-Proofpoint-ORIG-GUID: G2ZtJ892fo9Rbzrd5NrRqOIy2ZXf7NEM
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_174613_654853_172AE939 
X-CRM114-Status: GOOD (  21.50  )
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

Some kernel crashes are triggered by userspace. It can be helpful to
debug the user processes to understand why this occurred, but including
all userspace memory in is usually not feasible. The minimal useful
information is a stack trace, which can be pieced together from the top
of the userspace stack, and the unwind info from the executable and
DSOs. The drgn contrib/pstack.py script can be used to create such a
stack trace, assuming that the stack memory pages are available. Add
an extension which can include those memory pages into a vmcore without
including *all* of userspace memory.

To implement this extension, add helpers which walk the VMA tree for
both rbtree and maple tree implementations. Iterate each task, identify
the stack pointer, and find the corresponding VMA for the region. Build
a sorted list of anon_vmas along with the desired start and end offset.
When filtering pages, for any anon_vma, query this list and include the
desired pages.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 extensions/Makefile     |   4 +-
 extensions/userstack.c  | 325 ++++++++++++++++++++++++++++++++++++++++
 extensions/vma_mtree.c  | 140 +++++++++++++++++
 extensions/vma_mtree.h  |   7 +
 extensions/vma_rbtree.c |  56 +++++++
 extensions/vma_rbtree.h |  12 ++
 6 files changed, 543 insertions(+), 1 deletion(-)
 create mode 100644 extensions/userstack.c
 create mode 100644 extensions/vma_mtree.c
 create mode 100644 extensions/vma_mtree.h
 create mode 100644 extensions/vma_rbtree.c
 create mode 100644 extensions/vma_rbtree.h

diff --git a/extensions/Makefile b/extensions/Makefile
index 25e0a07..e8c41d8 100644
--- a/extensions/Makefile
+++ b/extensions/Makefile
@@ -1,5 +1,5 @@
 CC ?= gcc
-CONTRIB_SO := sample.so erase_sample.so
+CONTRIB_SO := sample.so erase_sample.so userstack.so
 
 all: $(CONTRIB_SO)
 
@@ -8,6 +8,8 @@ CFLAGS += -fPIC -shared -Wl,-T,../makedumpfile.ld
 $(CONTRIB_SO): %.so: %.c
 	$(CC) $(CFLAGS) -o $@ $^
 
+userstack.so: vma_rbtree.c vma_mtree.c
+
 clean:
 	rm -f $(CONTRIB_SO)
 
diff --git a/extensions/userstack.c b/extensions/userstack.c
new file mode 100644
index 0000000..bb1ea95
--- /dev/null
+++ b/extensions/userstack.c
@@ -0,0 +1,325 @@
+/*
+ * userstack.c: An extension for preserving userspace stack memory pages
+ *
+ * It can be useful to know what userspace tasks were doing at the time of a
+ * crash, but including all userspace memory is usually too much: usually a
+ * simple stack trace would do the trick. This extension preserves the topmost
+ * userspace stack pages for each thread in each process, making it possible
+ * to create a stack trace with a tool such as contrib/pstack.py in drgn.
+ */
+#include <assert.h>
+#include <stdbool.h>
+
+#include "../extension.h"
+#include "../makedumpfile.h"
+#include "../btf_info.h"
+#include "../kallsyms.h"
+#include "vma_mtree.h"
+#include "vma_rbtree.h"
+
+/* Required struct fields */
+INIT_MOD_STRUCT_MEMBER(vmlinux, task_struct, tasks);
+INIT_MOD_STRUCT_MEMBER(vmlinux, task_struct, signal);
+INIT_MOD_STRUCT_MEMBER(vmlinux, task_struct, thread_node);
+INIT_MOD_STRUCT_MEMBER(vmlinux, task_struct, stack);
+INIT_MOD_STRUCT_MEMBER(vmlinux, task_struct, mm);
+INIT_MOD_STRUCT_MEMBER(vmlinux, vm_area_struct, anon_vma);
+INIT_MOD_STRUCT_MEMBER(vmlinux, vm_area_struct, vm_pgoff);
+INIT_MOD_STRUCT_MEMBER(vmlinux, page, index);
+INIT_MOD_STRUCT_MEMBER(vmlinux, signal_struct, thread_head);
+INIT_MOD_STRUCT_MEMBER(vmlinux, list_head, next);
+INIT_MOD_STRUCT_MEMBER(vmlinux, pt_regs, sp);
+INIT_MOD_STRUCT(vmlinux, pt_regs);
+
+/* Optional struct fields */
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, thread_union, stack);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, mm_struct, mm_mt);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, mm_struct, mm_rb);
+
+/* Required symbols */
+INIT_MOD_SYM(vmlinux, init_task);
+
+/* Optional symbols */
+INIT_OPT_MOD_SYM(vmlinux, fred_rsp0);
+INIT_OPT_MOD_SYM(vmlinux, __start_init_stack);
+INIT_OPT_MOD_SYM(vmlinux, __end_init_stack);
+INIT_OPT_MOD_SYM(vmlinux, __start_init_task);
+INIT_OPT_MOD_SYM(vmlinux, __end_init_task);
+
+unsigned long THREAD_SIZE;
+bool ready;
+
+#define MEMBER_OFF(S, M) \
+	(GET_MOD_STRUCT_MEMBER_MOFF(vmlinux, S, M) / 8)
+
+
+static int for_each_task(bool (*task_fn)(unsigned long))
+{
+	unsigned long curr_proc = GET_MOD_SYM(vmlinux, init_task);
+	do {
+		unsigned long signal;
+		if (!readmem(VADDR, curr_proc + MEMBER_OFF(task_struct, signal),
+			     &signal, sizeof(signal)))
+			return FALSE;
+
+		unsigned long thread_head = signal + MEMBER_OFF(signal_struct, thread_head);
+		unsigned long next;
+		if (!readmem(VADDR, thread_head + MEMBER_OFF(list_head, next), &next, sizeof(next)))
+			return FALSE;
+
+		while (next != thread_head) {
+			unsigned long curr_thread = next - MEMBER_OFF(task_struct, thread_node);
+
+			if (!task_fn(curr_thread))
+				return FALSE;
+
+			if (!readmem(VADDR,
+				     curr_thread + MEMBER_OFF(task_struct, thread_node) + MEMBER_OFF(list_head, next),
+				     &next, sizeof(next)))
+				return FALSE;
+		}
+
+		if (!readmem(VADDR, curr_proc + MEMBER_OFF(task_struct, tasks) + MEMBER_OFF(list_head, next),
+			     &next, sizeof(next)))
+			return FALSE;
+		curr_proc = next - MEMBER_OFF(task_struct, tasks);
+
+	} while (curr_proc != GET_MOD_SYM(vmlinux, init_task));
+
+	return TRUE;
+}
+
+static unsigned long task_sp(unsigned long taskp)
+{
+	// The stack pointer is stored on entry to the kernel at the top of the
+	// kernel stack. If the task in on-cpu, the stack pointer will be in the
+	// PRSTATUS, but the stale value is very likely to be useful enough.
+	unsigned long user_sp_loc;
+	if (!readmem(VADDR, taskp + MEMBER_OFF(task_struct, stack),
+		     &user_sp_loc, sizeof(user_sp_loc)))
+		return 0;
+
+	user_sp_loc += THREAD_SIZE;
+	user_sp_loc -= GET_MOD_STRUCT_SSIZE(vmlinux, pt_regs);
+	if (MOD_SYM_EXIST(vmlinux, fred_rsp0))
+		user_sp_loc -= 16;
+	user_sp_loc += MEMBER_OFF(pt_regs, sp);
+
+	unsigned long sp;
+	if (!readmem(VADDR, user_sp_loc, &sp, sizeof(sp)))
+		return 0;
+	return sp;
+}
+
+struct task_stack {
+	unsigned long anon_vma;
+	unsigned long index_start;
+	unsigned long index_end;
+};
+
+static struct task_stack *stacks;
+static size_t stacks_count;
+static size_t stacks_alloc;
+
+static bool append_task_stack(struct task_stack *newstack)
+{
+	if (stacks_count == stacks_alloc) {
+		if (stacks_alloc)
+			stacks_alloc *= 2;
+		else
+			stacks_alloc = 512;
+		struct task_stack *newarr = realloc(stacks, stacks_alloc * sizeof(stacks[0]));
+		if (!newarr) {
+			return FALSE;
+		}
+		stacks = newarr;
+	}
+	stacks[stacks_count++] = *newstack;
+	return TRUE;
+}
+
+static bool record_task_stack(unsigned long taskp)
+{
+	unsigned long task_mm;
+	if (!readmem(VADDR, taskp + MEMBER_OFF(task_struct, mm), &task_mm, sizeof(task_mm)))
+		/* Propagate failure to read a value from the task_struct */
+		return FALSE;
+	if (!task_mm)
+		/* NULL task_mm is expected, continue */
+		return TRUE;
+
+	unsigned long sp = task_sp(taskp);
+	if (!sp)
+		/* Propagate error reading SP */
+		return FALSE;
+
+	int ret;
+	unsigned long vma = 0;
+	if (MOD_STRUCT_MEMBER_EXIST(vmlinux, mm_struct, mm_mt))
+		ret = find_vma_mtree(task_mm + MEMBER_OFF(mm_struct, mm_mt), sp, &vma);
+	else if (MOD_STRUCT_MEMBER_EXIST(vmlinux, mm_struct, mm_rb))
+		ret = find_vma_rbtree(task_mm + MEMBER_OFF(mm_struct, mm_rb), sp, &vma);
+	else
+		assert(FALSE); /* should be impossible */
+	if (!ret)
+		/* propagate error from find_vma_xxx() */
+		return FALSE;
+	else if (!vma)
+		/* No VMA found for the stack. This is unexpected, but gracefully
+		 * handle the condition and continue. */
+		return TRUE;
+
+	unsigned long vm_start, vm_end, anon_vma, vm_pgoff;
+	if (!readmem(VADDR, vma + MEMBER_OFF(vm_area_struct, anon_vma), &anon_vma, sizeof(anon_vma)))
+		return FALSE;
+
+	if (!anon_vma)
+		/* Not an anonymous VMA. This is unexpected but valid. Move on to
+		 * the next task. */
+		return TRUE;
+
+	if (!readmem(VADDR, vma + MEMBER_OFF(vm_area_struct, vm_start), &vm_start, sizeof(vm_start)) ||
+	    !readmem(VADDR, vma + MEMBER_OFF(vm_area_struct, vm_end), &vm_end, sizeof(vm_end)) ||
+	    !readmem(VADDR, vma + MEMBER_OFF(vm_area_struct, vm_pgoff), &vm_pgoff, sizeof(vm_pgoff)))
+		return FALSE;
+
+	/* Construct a range of indices we would like to retain. This is the
+	 * range of stack pages starting with the stack pointer, and continuing
+	 * to the top of the stack vma, or until a limit of 128 pages per task
+	 * is reached. */
+	unsigned long pgoff_start = (sp - vm_start) >> PAGESHIFT();
+	pgoff_start += vm_pgoff;
+	unsigned long pgoff_end = (vm_end - vm_start) >> PAGESHIFT();
+	pgoff_end += vm_pgoff;
+	if (pgoff_start + 128 < pgoff_end)
+		pgoff_end = pgoff_start + 128;
+
+	struct task_stack stack = {anon_vma | 1, pgoff_start, pgoff_end};
+	if (!append_task_stack(&stack))
+		return FALSE;
+
+	return TRUE;
+}
+
+static int stack_compar(const void *lhs, const void *rhs)
+{
+	const struct task_stack *lhss = lhs, *rhss = rhs;
+	if (lhss->anon_vma < rhss->anon_vma)
+		return -1;
+	else if (lhss->anon_vma > rhss->anon_vma)
+		return 1;
+	else
+		return 0;
+}
+
+void extension_init(void)
+{
+	if (MOD_STRUCT_MEMBER_EXIST(vmlinux, mm_struct, mm_mt)) {
+		if (!vma_mtree_init())
+			return;
+	} else if (MOD_STRUCT_MEMBER_EXIST(vmlinux, mm_struct, mm_rb)) {
+		if (!vma_rbtree_init())
+			return;
+	} else {
+		ERRMSG("error: Neither mtree nor rbtree available for VMA walking\n");
+		return;
+	}
+	if (!MOD_STRUCT_EXIST(vmlinux, pt_regs)) {
+		ERRMSG("error: missing pt_regs incfo\n");
+		return;
+	}
+	if (!MOD_SYM_EXIST(vmlinux, init_task)) {
+		ERRMSG("error: missing init_task symbol\n");
+		return;
+	}
+
+	// Determine THREAD_SIZE, which is necessary to find the offset of the
+	// userspace stack pointer register from the kernel thread stack.
+	//
+	// - Prior to v4.16, 0500871f21b23 ("Construct init thread stack in the
+	//   linker script rather than by union"), it was found in thread_union.
+	// - Between v4.16 and v6.10, 8f69cba096b5c ("x86: Rename
+	//   __{start,end}_init_task to __{start,end}_init_stack"), the stack
+	//   size can be inferred by the __{start,end}_init_task symbols.
+	// - Since v6.10, the size is inferred by __{start,end}_init_stack.
+	if (MOD_STRUCT_MEMBER_EXIST(vmlinux, thread_union, stack)) {
+		THREAD_SIZE = GET_MOD_STRUCT_MEMBER_MSIZE(vmlinux, thread_union, stack);
+	} else if (MOD_SYM_EXIST(vmlinux, __start_init_stack) &&
+		   MOD_SYM_EXIST(vmlinux, __end_init_stack) &&
+		   GET_MOD_SYM(vmlinux, __end_init_stack) > GET_MOD_SYM(vmlinux, __start_init_stack)) {
+		THREAD_SIZE = GET_MOD_SYM(vmlinux, __end_init_stack) - GET_MOD_SYM(vmlinux, __start_init_stack);
+	} else if (MOD_SYM_EXIST(vmlinux, __start_init_task) &&
+		   MOD_SYM_EXIST(vmlinux, __end_init_task) &&
+		   GET_MOD_SYM(vmlinux, __end_init_task) > GET_MOD_SYM(vmlinux, __start_init_task)) {
+		THREAD_SIZE = GET_MOD_SYM(vmlinux, __end_init_task) - GET_MOD_SYM(vmlinux, __start_init_task);
+	} else {
+		ERRMSG("Could not determine THREAD_SIZE: neither __start_init_stack "
+		       "nor __start_init_task found in kallsyms, nor is thread_union "
+		       "found in BTF.\n");
+		return;
+	}
+
+	if (!for_each_task(&record_task_stack)) {
+		free(stacks);
+		stacks = NULL;
+		stacks_alloc = stacks_count = 0;
+		ERRMSG("Could not gather all task stack VMAs, userstack disabled\n");
+		return;
+	}
+	struct task_stack *tmp = realloc(stacks, stacks_count * sizeof(*tmp));
+	if (tmp) {
+		stacks = tmp;
+		stacks_alloc = stacks_count;
+	}
+	qsort(stacks, stacks_count, sizeof(*stacks), &stack_compar);
+	ready = TRUE;
+}
+
+static int count_retained;
+static int count_checked;
+static int count_cached;
+int extension_callback(unsigned long pfn, const void *pcache, const struct pginfo *i)
+{
+	unsigned long index;
+	static struct {
+		unsigned long mapping;
+		struct task_stack *result;
+	} cache;
+
+	if (!ready || !isAnon(i))
+		return PG_UNDECID;
+
+	index = ULONG(pcache + MEMBER_OFF(page, index));
+	if (!(i->mapping & 1))
+		return PG_UNDECID;
+
+	if (i->mapping != cache.mapping) {
+		count_checked++;
+		struct task_stack search = {i->mapping, 0, 0};
+		struct task_stack *result = bsearch(&search, stacks, stacks_count,
+						sizeof(search), &stack_compar);
+		if (!result)
+			return PG_UNDECID;
+
+		cache.mapping = i->mapping;
+		cache.result = result;
+	} else {
+		count_cached++;
+	}
+
+	if (cache.result->index_start <= index && index < cache.result->index_end) {
+		count_retained++;
+		return PG_INCLUDE;
+	} else {
+		return PG_UNDECID;
+	}
+}
+
+__attribute__((destructor))
+static void userstack_exit(void) {
+	if (count_retained || count_checked || count_cached || stacks_count) {
+		REPORT_MSG("Extension userstack:\n");
+		REPORT_MSG("  PFNs retained: %d searched: %d, cached: %d\n", count_retained, count_checked, count_cached);
+		REPORT_MSG("  Recorded %zu stack anon_vmas\n", stacks_count);
+	}
+}
diff --git a/extensions/vma_mtree.c b/extensions/vma_mtree.c
new file mode 100644
index 0000000..ac8912e
--- /dev/null
+++ b/extensions/vma_mtree.c
@@ -0,0 +1,140 @@
+#include <stdbool.h>
+#include "../btf_info.h"
+#include "../kallsyms.h"
+#include "../makedumpfile.h"
+
+INIT_OPT_MOD_STRUCT(vmlinux, maple_tree);
+INIT_OPT_MOD_STRUCT(vmlinux, maple_node);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, maple_tree, ma_root);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, maple_arange_64, pivot);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, maple_arange_64, slot);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, maple_arange_64, meta);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, maple_range_64, pivot);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, maple_range_64, slot);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, maple_range_64, meta);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, maple_metadata, end);
+
+#define MEMBER_OFF(S, M) \
+	GET_MOD_STRUCT_MEMBER_MOFF(vmlinux, S, M) / 8
+#define KERN_STRUCT_MEMBER_EXIST(S, M) \
+	MOD_STRUCT_MEMBER_EXIST(vmlinux, S, M)
+#define GET_KERN_SYM(SYM) GET_MOD_SYM(vmlinux, SYM)
+#define KERN_SYM_EXIST(SYM) MOD_SYM_EXIST(vmlinux, SYM)
+#define GET_KERN_STRUCT_SSIZE(S) \
+	GET_MOD_STRUCT_SSIZE(vmlinux, S)
+#define KERN_STRUCT_EXIST(SYM) MOD_STRUCT_EXIST(vmlinux, SYM)
+
+#define MAPLE_NODE_MASK			255UL
+#define MAPLE_NODE_TYPE_MASK		0x0F
+#define MAPLE_NODE_TYPE_SHIFT		0x03
+#define XA_ZERO_ENTRY			xa_mk_internal(257)
+
+static unsigned long xa_mk_internal(unsigned long v)
+{
+	return (v << 2) | 2;
+}
+
+static bool xa_is_internal(unsigned long entry)
+{
+	return (entry & 3) == 2;
+}
+
+static bool xa_is_node(unsigned long entry)
+{
+	return xa_is_internal(entry) && entry > 4096;
+}
+
+bool vma_mtree_init(void)
+{
+	if (!KERN_STRUCT_EXIST(maple_tree) ||
+	    !KERN_STRUCT_EXIST(maple_node) ||
+	    !KERN_STRUCT_MEMBER_EXIST(maple_tree, ma_root) ||
+	    !KERN_STRUCT_MEMBER_EXIST(maple_arange_64, pivot) ||
+	    !KERN_STRUCT_MEMBER_EXIST(maple_arange_64, slot) ||
+	    !KERN_STRUCT_MEMBER_EXIST(maple_arange_64, meta) ||
+	    !KERN_STRUCT_MEMBER_EXIST(maple_range_64, pivot) ||
+	    !KERN_STRUCT_MEMBER_EXIST(maple_range_64, slot) ||
+	    !KERN_STRUCT_MEMBER_EXIST(maple_range_64, meta) ||
+	    !KERN_STRUCT_MEMBER_EXIST(maple_metadata, end)) {
+		ERRMSG("Missing required maple tree syms/types\n");
+		return false;
+	}
+
+	return true;
+}
+
+int find_vma_mtree(unsigned long mt, unsigned long index, unsigned long *ret)
+{
+	unsigned long long entry;
+
+	if (!readmem(VADDR, mt + MEMBER_OFF(maple_tree, ma_root), &entry, sizeof(entry)))
+		return FALSE;
+
+	if (!xa_is_node(entry)) {
+		if (index == 0)
+			*ret = entry;
+		else
+			*ret = 0;
+		return TRUE;
+	}
+	unsigned long long max = ULONGLONG_MAX;
+	void *node = malloc(GET_KERN_STRUCT_SSIZE(maple_node));
+	if (!node) {
+		ERRMSG("failed to allocate memory\n");
+		return FALSE;
+	}
+
+	for (;;) {
+		if (!readmem(VADDR, entry & ~MAPLE_NODE_MASK, node, GET_KERN_STRUCT_SSIZE(maple_node))) {
+			ERRMSG("failed to read maple node: %llx\n", entry & ~MAPLE_NODE_MASK);
+			free(node);
+			return FALSE;
+		}
+
+		int node_type = (entry >> MAPLE_NODE_TYPE_SHIFT) & MAPLE_NODE_TYPE_MASK;
+		unsigned long long *pivot, *slot;
+		uint8_t end;
+		if (node_type == 3) {
+			pivot = node + MEMBER_OFF(maple_arange_64, pivot);
+			slot = node + MEMBER_OFF(maple_arange_64, slot);
+			end = ((uint8_t *)node)[MEMBER_OFF(maple_arange_64, meta) + MEMBER_OFF(maple_metadata, end)];
+		} else if (node_type == 1 || node_type == 2) {
+			pivot = node + MEMBER_OFF(maple_range_64, pivot);
+			slot = node + MEMBER_OFF(maple_range_64, slot);
+			unsigned long long p = *(slot - 1);
+			if (!p)
+				end = ((uint8_t *)node)[MEMBER_OFF(maple_range_64, meta) + MEMBER_OFF(maple_metadata, end)];
+			else {
+				end = slot - pivot;
+				if (p == max)
+					end--;
+			}
+		} else {
+			ERRMSG("unrecognized maple node type: %d\n", node_type);
+			free(node);
+			return FALSE;
+		}
+		int offset = 0;
+		for (offset = 0; offset < end; offset++) {
+			if (pivot[offset] >= index) {
+				max = pivot[offset];
+				break;
+			}
+		}
+		if (&pivot[offset] >= slot)
+			offset = end;
+
+		entry = slot[offset];
+		if (node_type == 1) {
+			// leaf:
+			free(node);
+			if (entry == XA_ZERO_ENTRY)
+				*ret = 0;
+			else
+				*ret = entry;
+			return TRUE;
+		}
+	}
+	*ret = 0;
+	return TRUE;
+}
diff --git a/extensions/vma_mtree.h b/extensions/vma_mtree.h
new file mode 100644
index 0000000..69d9448
--- /dev/null
+++ b/extensions/vma_mtree.h
@@ -0,0 +1,7 @@
+#ifndef _MAPLE_TREE_H
+#define _MAPLE_TREE_H
+#include <stdbool.h>
+bool vma_mtree_init(void);
+int find_vma_mtree(unsigned long mt, unsigned long address, unsigned long *ret);
+#endif /* _MAPLE_TREE_H */
+
diff --git a/extensions/vma_rbtree.c b/extensions/vma_rbtree.c
new file mode 100644
index 0000000..c947fbc
--- /dev/null
+++ b/extensions/vma_rbtree.c
@@ -0,0 +1,56 @@
+#include "../makedumpfile.h"
+#include "../btf_info.h"
+#include "vma_rbtree.h"
+
+INIT_MOD_STRUCT_MEMBER(vmlinux, vm_area_struct, vm_start);
+INIT_MOD_STRUCT_MEMBER(vmlinux, vm_area_struct, vm_end);
+
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, vm_area_struct, vm_rb);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, rb_root, rb_node);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, rb_node, rb_left);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, rb_node, rb_right);
+
+#define MEMBER_OFF(S, M) \
+	(GET_MOD_STRUCT_MEMBER_MOFF(vmlinux, S, M) / 8)
+
+#define MEMBER_EXIST(S, M) \
+	(MOD_STRUCT_MEMBER_EXIST(vmlinux, S, M))
+
+int find_vma_rbtree(unsigned long rb_root, unsigned long address, unsigned long *ret)
+{
+	unsigned long node, vma, vm_start, vm_end, rb_left, rb_right;
+	if (!readmem(VADDR, rb_root, &node, sizeof(node)))
+		return FALSE;
+
+	*ret = 0;
+	while (node > MEMBER_OFF(vm_area_struct, vm_rb)) {
+		vma = node - MEMBER_OFF(vm_area_struct, vm_rb);
+		if (!readmem(VADDR, vma + MEMBER_OFF(vm_area_struct, vm_start), &vm_start, sizeof(vm_start)) ||
+		    !readmem(VADDR, vma + MEMBER_OFF(vm_area_struct, vm_end), &vm_end, sizeof(vm_end)) ||
+		    !readmem(VADDR, node + MEMBER_OFF(rb_node, rb_left), &rb_left, sizeof(rb_left)) ||
+		    !readmem(VADDR, node + MEMBER_OFF(rb_node, rb_right), &rb_right, sizeof(rb_right)))
+			return FALSE;
+
+		if (address < vm_start) {
+			node = rb_left;
+		} else if (address >= vm_end) {
+			node = rb_right;
+		} else {
+			*ret = vma;
+			break;
+		}
+	}
+	return TRUE;
+}
+
+bool vma_rbtree_init(void)
+{
+	if (!MEMBER_EXIST(vm_area_struct, vm_rb) ||
+	    !MEMBER_EXIST(rb_root, rb_node) ||
+	    !MEMBER_EXIST(rb_node, rb_left) ||
+	    !MEMBER_EXIST(rb_node, rb_right)) {
+		ERRMSG("error: missing required vm_area_struct & rbtree definitions");
+		return false;
+	}
+	return true;
+}
diff --git a/extensions/vma_rbtree.h b/extensions/vma_rbtree.h
new file mode 100644
index 0000000..a8b8d4f
--- /dev/null
+++ b/extensions/vma_rbtree.h
@@ -0,0 +1,12 @@
+#ifndef RBTREE_H_
+#define RBTREE_H_
+#include <stdbool.h>
+
+#include "../btf_info.h"
+
+DECLARE_MOD_STRUCT_MEMBER(vmlinux, vm_area_struct, vm_start);
+DECLARE_MOD_STRUCT_MEMBER(vmlinux, vm_area_struct, vm_end);
+
+int find_vma_rbtree(unsigned long rb_root, unsigned long address, unsigned long *ret);
+bool vma_rbtree_init(void);
+#endif // RBTREE_H_
-- 
2.47.3



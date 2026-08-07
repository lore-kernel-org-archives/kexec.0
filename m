Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD51BC5AC7A
	for <kexec@archiver.kernel.org>; Fri,  7 Aug 2026 16:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vxf9KgKp89JXTucAK+Y+VkV0dKd13CzVZnOkKW3xqDI=; b=me/qSkg8dU4wpgDjMImLrpdtSy
	DW3CqQ19TjO7Xv8vHxa/a7xQiBYJjMUlzDpECsJpPUQvWCEHtInzdcKPsVDhCaBEFxt9sO3M8Awr6
	1BYE8TmIoGQBhXlvwySfCIr6eu4/SuoOYKJyu4O+RR65eWROnhWpjRPHZoyVeMiOC37h2sGba2yv2
	bR6GpIvRnm+aCshFaZXbGyUnu3Iowq8n0H19AjvvpuXN4pwpEafHUdQzuvv7iJlzcvifkVVGR2mfK
	Vud4KhaiFaGxzqocELSs53n6cQFTrSm/z5NrFP3vOOx4WuxXw/GZAkKIblJvqpCaOI8rHbRHkHoHp
	LWl7Qchg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsNMx-00000008PwM-1Y8h;
	Fri, 07 Aug 2026 16:24:27 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsNMu-00000008Pvt-0jrx
	for kexec@lists.infradead.org;
	Fri, 07 Aug 2026 16:24:26 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677EtpXn1202869;
	Fri, 7 Aug 2026 16:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=vxf9KgKp89JXTucAK+
	Y+VkV0dKd13CzVZnOkKW3xqDI=; b=VxTP7kxf6+U74RgS6YZRzBBduPlrmn/fGC
	8KuxxQmo6+Bk88uIX68ctyTU8GDOrcbbi6cxLJM3BkDtaTtSiWxGacIEfN3G1UV/
	GckX2vM4TUyVyfGK5WIwISlaQOak5VyAhVkrKPLrJbCICzxhmWXr8nOp/72wRLV2
	RHqXRlDIvG7oRIvdah7MBkYc37BVHRbpbWUltfYoHAg835bqRBfYHXkpzannStP7
	UqVv67sfamdrdG5TqsrxuVIA3mvL7Z3co50fThRSKbphAq5vPGtV6sfAWcyZZOW5
	AfguKwxkqMr0dDR6ChlGdUQJNjzmusX0RW7UL3Sv6p9upIv+TwKQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs9btfw7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Aug 2026 16:24:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 677GKaWK029517;
	Fri, 7 Aug 2026 16:24:21 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78x78qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 07 Aug 2026 16:24:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+8xZFQler3M+vtP00ITiTrWNA6j6QT2ORLDWRnpUs1EyaxOeNuze3TNZzLzX8qXJRmUtZL7FoE5mFzptW2v+beH+ouxtEa3PMI/YlZGokNkkpjWYdBdRV6FqD0rCowLrrmfGI6hghw6A9mDN6jDH8o7tS2sAnplpveJd1Tm8dgQL/ChIZonl0vI/my1iPRPPJgsbSnWL3Nwx6qvxMmJOaazI+qs8f1oanFNqHBpXT5fDHPshsb3fJJILB43xxTox4tUNVUeVqeG0MNOvXRH+PUpPfY03x73fsMtQrvkLumL3ElkQQdVyyHO5L5h9kEcv9DTYE5XYP57eNnpeTBxZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxf9KgKp89JXTucAK+Y+VkV0dKd13CzVZnOkKW3xqDI=;
 b=YZ+8syl6+5/BpYqi9zJjwfYYLOoSBshRc3ORdaI9iBEyuZFp03GDqhTEhnsIZQnC76QFympZyvHv3BesbxVyFBUtbGwTte42+qRaqDg1LLpHOIZ21Ly/yhLp2dNHmACckzY9y+i7yt4eBJnYfPHcoT2ZgaMNquxX+uvqqauFuO09NEYBpUX4b7bP9F/sXi4KJHLxaA0kxQHmp9ktSxRXRjbUP8Wo6LH0E33MCufYd4BaZ3sW91tfYV+MHIABTEkOUlxavRNBuo3fZ0jD2UwgMG7+apYZnZvPZNSposBdeNCr2k6b2nPaI5mP+u+EVYd6EDWPw8i/J8KgLU2bFrK9Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxf9KgKp89JXTucAK+Y+VkV0dKd13CzVZnOkKW3xqDI=;
 b=kgYrVZoYCAz+9KLx6QDb3l6IWM4jnqnSSU/7DNjpNpDpRa0gto5UYS8CDQdsUbAuBd1cQ5q0CAb9F2w+jMga4fRUuuNIA696JKa+tiCe99BoKj7wL2Wi9ejk9kCgkwp/UaeLP7nE40MgXisI8gZ9fcq3eFLSoCxmoj1yc6oyi14=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by CO1PR10MB4481.namprd10.prod.outlook.com (2603:10b6:303:9e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 16:24:18 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.21.0292.018; Fri, 7 Aug 2026
 16:24:18 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org
Cc: ltao@redhat.com
Subject: Re: [PATCH makedumpfile 7/9] Add PG_INCLUDE_HEAD extension return
 status
In-Reply-To: <20260714004550.3698175-8-stephen.s.brennan@oracle.com>
References: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
 <20260714004550.3698175-8-stephen.s.brennan@oracle.com>
Date: Fri, 07 Aug 2026 09:24:16 -0700
Message-ID: <87y0eh3nm7.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: PH5P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::17) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|CO1PR10MB4481:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d3eb8f-28be-4ba6-9e35-08def4a0544b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|56012099006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SfOwctbRGebaNni/rCPr+GjialVcBgd73zzscCQUhXuJhQhwO5KUdf04lQiXw//r2pAe1KNFWOI+e/LB37+Ag/iTzPlQbf6qmvRB5hnUGmrfSlAHKGWvn26N9RVCd+plpraitUVL1DU12VmXMf4afh2Ckx1i/P6SW0Xu0hp11E6mSDTlKGcnF5tUWnTOcr682twZ2m00UCh1CeY6GnnkIQ5Hj00VLoMTkNwflIDW0bkQkoiHkvwhfW78UmWeCLGb7UcC46V3nbg5jgbhgRRZ1LnK4nCIJDjgab/V/OHeC1HMLOjqKEMQeAfu8iC6u+IKA1l1D7M8S+1pYaUM4rUoRFdvLZNqRQTX2FjCk+3rvDNA7WUfiG6w+i9iZeFMSCzBnOImbjVS4q5MUDqq3gxaxnZYk3BJzvE5apRFnjNjigO7qrzd0I5LrHy7WniaqHg0ga0FKHOoamSE2K5qHQFLpaYd3mrmGdyGAYbkDwIaUhRO3PvFLdC9CW9tk3/1ph1ZCs/BN9hwcLmrTR14FEoMywQ4oAjwh7D+eCI66eI5VhH1RlM+eX8vGfmRlTUwzSjrSPga11hmwXL8XIIU4vD4Wla8d9rLU5V8y/CwtRg8XGgYDztGlWD0YSBCG2FJNYm19apJAJRqzfYpvvz929iVoPjLedy3o5ygY5+x7zJ6YNE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m0evxExMR4gvMYKym/JYznygMDbKvpLRBseDvF5LH/qBxzy7ZEqvfnEOvtX2?=
 =?us-ascii?Q?g1FUbv7kQFslubRI++s3rzKlMoaonL/zqlEi5K1jmtK871j+vg9ave+RmB2E?=
 =?us-ascii?Q?dMwc/ae+Ui5dNZf/qnJQ/R+qgxXET0fZlQn4gH9G5eq3DAFj4PTS3TkIbbYa?=
 =?us-ascii?Q?+gDZr9+qDvMyenOatOaFhIQNyTEW5+wMWgMu7w8dUilHbm5k+gbNJGJw2jsm?=
 =?us-ascii?Q?y+EA5q1l9swEnJFbIu6F2JgOgxN+kejS9bzzcrxh/fM6CLnt/wroVOzHOSNL?=
 =?us-ascii?Q?POTEjwozj3BpKEqIR+9NTW0HG80SSavIEOSvZ6ovV/F/NEk79e9R3IEikenK?=
 =?us-ascii?Q?0Rhy8oROKT4ZInbZYw7/S/yS+i5Sw0GbHQ7ddJovRE2/GC16qvmmkYoZWpHB?=
 =?us-ascii?Q?sNt/XNJwPm5YvBaBdZPO82r7iq2nvu1zy4gPnxXyr7Q7zrd1tlltWAm34Pnz?=
 =?us-ascii?Q?jv+W+Ng+WaJ9JAIwDrk7jwSkBNdNvN5xnYjJ0iBi7JvWsQ8mAWWYYN3n0ctK?=
 =?us-ascii?Q?KyZWU0GLqF1uUIoZxdLuyNRadt7CYkEETKPuz1g02ELUAnkt9Tf6W6kWMWBe?=
 =?us-ascii?Q?I83nlOXd5Lt161UqJEVGZMhI69lppm4ecL6GAl6iFBMxkL+epY5VsMwMnJJE?=
 =?us-ascii?Q?0B6ElPRs6WWlhQOwuntvcG2mltLcqq+4UVj96U+TVX2dZT1bMJ1q3jhpkOp2?=
 =?us-ascii?Q?jNRyAwurJupp7Q2MRmD7m7dUs2+brmW2+wIHx4wzjMlgmco4fB48L44yXnw9?=
 =?us-ascii?Q?73divmB7SGoN0LMzg4lyWlcnFaJGwAtjbJxfj2/zEt9WS9dO6hoywt8BfKrI?=
 =?us-ascii?Q?/BvrwqXxhPQ4GGiyF8+uiDgHYBD1rSorJlWp+6+n12IOj+nQW2Ps3yTgXADH?=
 =?us-ascii?Q?iaV9e7FB25vZEgwqoczF3e9HAHekiABfxbVGZRhKJZsnLwyJ0T9f4dKZ5biW?=
 =?us-ascii?Q?0hPiijFvRIjfjTldAJaEq8I+iUz5w5H7BbPiQu7Y+qkMGC4TnPQDsCNdsgkK?=
 =?us-ascii?Q?o7XwfZJTej1xUl5NWvYUaWfXzmzJbCx9LLScyKdpQGbXsvFeEZML7zk+E0cQ?=
 =?us-ascii?Q?QGNz03Q3LEHewPsq4/NmM8ZHit6LIrPe7PiEQ3s4M+Olf90UML+n8X1Uqy94?=
 =?us-ascii?Q?jDEPgwEjDnCJKPxcwCiPeJAYyYIwcWHjdaGCRnSP3uUC+o/3q7hX4lBUj5Id?=
 =?us-ascii?Q?bnBsvVHGQs46BvpGkmPVskQFMG10hg0POE015zOw2n+C2FaYCDlaBxLLUj1f?=
 =?us-ascii?Q?cNw9yrdBFsrRlN2WkrH0kzd6+cftfb8Br3sObbtYvQSbiCTfwsO8r/iD9R1e?=
 =?us-ascii?Q?eTTwjQAd4qgAlVNff9khj02u8DskgvqUU29HEr9DBuezaXv7sHamuEbTCU0f?=
 =?us-ascii?Q?ggv2Er7UtXeMHWA5KSR0ldIi8bsBXoIGoZXuYagnQ2D/KdjKDiVfvFM5XGbt?=
 =?us-ascii?Q?XHjypxJ8jYup3XDOr0M5AnWsE0QFqHH5TklUyn15MeIEVCaQr+ssTm3GjTbO?=
 =?us-ascii?Q?KAr9d3FKma6Dp8MKl7JM6X0nyH59AJXghwQsrX+43wekv+ENosa5M0Vqh0G9?=
 =?us-ascii?Q?nlvt/6uhpb9pEffwY5rupw+x+/TOhGcY3llREM77/R4Sq0hC6bJHzB7hgTQc?=
 =?us-ascii?Q?d5HZSvhDQBgpbikVhzSD0QFi6Jq1iGUgCu4EEmpyFnBYBF4XN+k+oNe2HrU+?=
 =?us-ascii?Q?x4BkCAuye6LKeEtqL1M9GjFYm2wtLinGZXaVRLjsKbJZrgwD9wgLSBRkcpGF?=
 =?us-ascii?Q?l6kfuM78bjpystN4p2p/FEDY0q9sWw8=3D?=
X-Exchange-RoutingPolicyChecked: EKSQ8lfnc1ZY6ZZGA53uVKjqfol9VMHfczIS0iBljZTW55fAR1RV6WldmuEQneA0PRtzh19fzWhNu4xuJvbkR5vJj11VeOhzTdwPLc+Jdm6Rr5uRD61OZG9aMWbljnhD5lI3/qKiytTjdd/AIali+RkG+rxvaJs2SWW2xz4q5C6kjq7vpKVbWW8j25ReIYNmR3kRk6xPfoVDY39jMj1OZiXgR8nD1arbyS9lw3KuFFtTMxz17RIngKq36FQMtW27YLNKDqQEquFquOCLFChJPyrB7FKv173Vrr9hM7VqoubJxJm4GcuTgTNBcHbldTaxSKJRDrKsD29kF9JuVf+wTQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bgQa7nXdmcrEwf9TCAbphBfRDUmaBRrkXLoMPIFhZ2KyE8wdwQeocbrrMMDd+qv7DSre9A3mjfKfi8YUjazp2AuGFpetlnJ2NKihR46kAwOvBfnXirVMKw9rzs6lZtpzjVOIjba7JyjrLcpd+ddUvB6Omxtle1ZL1VEsyDO/5QPULL4RNhneyx/2G/QEI+m56+MJlFG1EcTiRHGgy0JL2QnTLBKMMk4QbF9hMuArcOOmvgUYOwfyw94ep9M76i5keqbJtDSO10fuBnyDyNgrx9NB4+CENfX/QMwuUS4y8c1MyGrnHzeJ+sotp0eAiKx6uPnsD66BDxaGJ0QJ6NAww461T3um/dSUCSeq8YAgXB8/HN73RtHRVEZmJpVFRmEqDuNDkX3PMLuTLJ7helr135cEvlKr35N5yG9R4tyTjBRsHattfw4s9gj4Bwdq804+PDOv2G1qF9mqc0zHWBrwqrgrba/W58DI/O5RWBGv1TR+nBfZUxGzOFC1LK/vwlJ3buktCcuMAx15NYSKxUiqRfP53j8+2Z7+7/Oo4Po7mM9OS2mOwTORoZ/nLCF/MX67kRPkaF6stCG0NAjYBNYtZiw1PAs+BpXq4qKZCcpgBUI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d3eb8f-28be-4ba6-9e35-08def4a0544b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 16:24:18.2951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xj3KzrORf/ZFNzJ708/Bo5Yp8sCEDH0vgaa/Yz2xbX9ORj9jwB+fvZyiRHrEUYTipGp+Pb5vnML9PF/rw1cst4JvslBfXssNuORMwZ+S7+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4481
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608070128
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEyOCBTYWx0ZWRfXwgZa1PBbkVGW
 h8TXlGt6puQdVlD9OaZSpTqJG31w4iAI/DyQ97joN4QAbJeJvwiqrBEqPNhKpQ2EtHSN5anjLyw
 HSS9L/l6awQJ1wHiOcufIvPu5tCtabiZVf+gosijoYr8Lx/0pdp4kcvK800Xh5+mnHCvNIuatdg
 ELZ8jhi12SwCVMHaizMNWu8fbDt9GEXdUaGQUmqUPKXH63CwBFdxQaKtaSFjqWunD1GQmgtUj6j
 DW64cNkbNJeuWNi74X1Oo9gdjGgP9fvy2p/rIkMIKNMNI2SN98lXrGZOV6gmoYEoyxIb8f2wAV/
 +42ERIYvLJOAkJXy0v0gvAnV4yMUxuLzGW4cFy2j9dFTNy/c93esR7ybbcruv9JOM5Yk98+7TxB
 g/1X0lDPM3HLSEO98eSiU5C48ztfG7uiXHaGeVtvkL+JgvUsWKEr02sIOdl+qwBNHVZvKpc5fON
 gJiWGnT9PUWSiME8LjYqOZdA8CX2WgRUYbHqWutc=
X-Proofpoint-ORIG-GUID: vG4v6ItnL2J5s7G7py9R2rLOfrTybvce
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEyOCBTYWx0ZWRfXwYWcayEnS9I5
 zI2GGZHod0MZEqvzrW039VPbjc7/jHuuhkOC6W5Z1by32zGPQVMYwBGIkRrPW5pDXJMHpbixQDb
 9KxvEh/vAUF/PAvbtaDU9IkbbJONYSa2la2TMa9r7BNl4Dh5Xqbh
X-Authority-Analysis: v=2.4 cv=ZOTnX37b c=1 sm=1 tr=0 ts=6a7606b6 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=WQ7C9zlWFRN6rof9kO8A:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13510
X-Proofpoint-GUID: vG4v6ItnL2J5s7G7py9R2rLOfrTybvce
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260807_092424_223491_C262CA49 
X-CRM114-Status: GOOD (  21.46  )
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

Stephen Brennan <stephen.s.brennan@oracle.com> writes:
> This allows an extension to request that only the head page of a
> compound page be included in the dump.

Hello Kazu,
Here's a more complete message which you can use to replace what's here:

---
Prior to patch "Do not call extensions for tail pages", extensions were
called for every page (including tail and head pages), yet their
decisions on tail pages were not respected when they conflicted with
makedumpfile's decision on the head page. Since that patch, we only call
extensions for head pages, and we use their decision for the entirety of
the compound page, which is at least consistent.

However, some extensions may want more fine-grained control. One such
policy may be to include only the head page, excluding tail pages. For
example, this is useful for an extension which includes just the first
page of ELF file headers within the page cache. Since page cache data
frequently uses larger folios, including just the head can avoid
unnecessary overhead.

So, add a new return status PG_INCLUDE_HEAD, which behaves as described,
including just the head of a compound page.
---

Thank you,
Stephen

> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>  extension.c    | 2 +-
>  extension.h    | 7 ++++---
>  makedumpfile.c | 9 +++++++++
>  3 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/extension.c b/extension.c
> index 9b29f0c..a7360d0 100644
> --- a/extension.c
> +++ b/extension.c
> @@ -314,7 +314,7 @@ int run_extension_callback(unsigned long pfn, const void *pcache, const struct p
>  	for (int i = 0; i < handle_cbs_len; i++) {
>  		if (handle_cbs[i]->cb) {
>  			result = handle_cbs[i]->cb(pfn, pcache, inf);
> -			if (result == PG_INCLUDE) {
> +			if (result == PG_INCLUDE || result == PG_INCLUDE_HEAD) {
>  				ret = result;
>  				goto out;
>  			} else if (result == PG_EXCLUDE) {
> diff --git a/extension.h b/extension.h
> index 22af9a6..3edfbeb 100644
> --- a/extension.h
> +++ b/extension.h
> @@ -4,9 +4,10 @@
>  
>  struct pginfo;
>  enum {
> -	PG_INCLUDE,	// Exntesion will keep the page
> -	PG_EXCLUDE,	// Exntesion will discard the page
> -	PG_UNDECID,	// Exntesion makes no decision
> +	PG_INCLUDE,		// Extension will keep the full page
> +	PG_INCLUDE_HEAD,	// Extension will keep just the head page
> +	PG_EXCLUDE,		// Extension will discard the full page
> +	PG_UNDECID,		// Extension makes no decision
>  };
>  int run_extension_callback(unsigned long pfn, const void *pcache, const struct pginfo *i);
>  void init_extensions(void);
> diff --git a/makedumpfile.c b/makedumpfile.c
> index f277360..69abb17 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -6667,6 +6667,15 @@ check_order:
>  			 * retained by an extension. */
>  			num_extension_retained += nr_pages;
>  			continue;
> +		} else if (filter_pg == PG_INCLUDE_HEAD) {
> +			num_extension_retained += 1;
> +			if (nr_pages == 1)
> +				continue;
> +
> +			/* FALL THROUGH and exclude tail pages */
> +			pfn++;
> +			mem_map += SIZE(page);
> +			nr_pages--;
>  		}
>  
>  		/*
> -- 
> 2.47.3


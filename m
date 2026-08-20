Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F43C5DF8F
	for <kexec@archiver.kernel.org>; Thu, 20 Aug 2026 23:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3w++GUsiuBT9NCWDw6uyxU0i9mz+t7k85IMkoMfK4pc=; b=uDKcoFOdPKBJ+k4RuGSGUROxHA
	FP+Vkp/2fZlzszmRDybjBjCaNmNirmrPiR4X1QsXcmnOdeVZ7XOKm2p2SZajKoRvkxopbbbX2V7Oq
	TLrILQE9evWZXbTtdPiI1OIu5PJazh/keGYPxrWRjngztQtWxKIiGzUKgLXZt7e/41vCu+Y7/idqj
	TB3eVho0zcRjAgaSzXbZ8vmheRhXBH+lTdEqmZzi4GureNcevBR7RzptBisppmdFKMFyZVLfm8AG/
	yALOvSHaxfl4uYBqHl7TlMbp+242r+24DCylpER01c5RNifV3RqyMiAQkDPozh9ge2k6DcKTMj8A2
	nt7WLz9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxCEM-0000000CLAe-2PDX;
	Thu, 20 Aug 2026 23:31:30 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxCEI-0000000CL9O-1hEU
	for kexec@lists.infradead.org;
	Thu, 20 Aug 2026 23:31:28 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KDOvdQ4124661;
	Thu, 20 Aug 2026 23:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3w++GUsiuBT9NCWDw6uyxU0i9mz+t7k85IMkoMfK4pc=; b=
	fFvQOlQGl2GRt4x+5Bbz0A02oRAiLYE8hI3rS6kCmqqjQMBRskk5OmeOmVlnR+EJ
	HPNMmkGA70BI71OmfX2twF3963TnFr7ODCZaCMih0dsLHJW7/ya9hKHf29WKqr5G
	W35Kgh2q8HznMsWZo2xaeXzN1883/L21ob4BlkpTjH8ERjvRlG1S5Ds5kMxVR5pa
	nkDjhwmLxb5ZegHEoD+nMWhVtpWoGZvaXDKZ3lDQpgrpUIHcH7vT6MzwDq5HXhil
	QMZBhM1o1UMUjbd8d7n5PKDQ+5RQivIu9z5Ha2sT5VJdlnJCVFW+3Qji5FU+bGAJ
	XYwmP6qnv56lJ05IWYvBjQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g4ydbm78f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 23:31:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67KNUboV020064;
	Thu, 20 Aug 2026 23:31:24 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010008.outbound.protection.outlook.com [40.93.198.8])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4g2ejttsum-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Aug 2026 23:31:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eE1Zi34Y97xQR1rFbSRKzAW2GjtDsnSyaZQvyYzKJUkMAKakt02bcvGiVhqioBbWs6g9/IuqCRre/69qpTnb7m0wgqvDmer2IAlUTy105ksBRCRjHX3nilL7sU0Vo0M/XWeCK7BBTlssopzZ9HPmYlLbZCYwxwPDjTEZ4DlTtGDpXB6tpCFfgoizQFajMMZLJzRIteaQbQEWVWI32GaTMzbt/+3bcgqmW9M3II5v+TtWnpQUY5s53W6OW1n1hNjC9fW9WIO9TwxhQq60YkrHsn+0/oPp7yZo4Sk5D6Bra3fVYi8XZWCnQc6igT+JcwzqjfPMSJnboPMqJvKnRTcs9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3w++GUsiuBT9NCWDw6uyxU0i9mz+t7k85IMkoMfK4pc=;
 b=ZEgFne7+sWSqTgEFx254WBYe1Nx8Lc8T6vYsfhovtrM8ow/9v2j9PcX33zKP3rbKGTkmDDwLTDNt7uJxrvlWd77k1NzmoduxSu++Z6DZJCdbp0Q3KDEe9B9GTsej9j/h8mS5yHgGiBeunC+0iowvHFbE9NzQWUKzCYiuMNafW0eJLmGN2YyE+CwXHiqQ86HJy7Zh1KRaFVCJA1/97g24eJcu9sVufKZlJHcHj5FWx6d+XJIDkvorJpcpUX1VDvNoO16f1LNSMHNAMPag5afU88e7vqdr+dVQA4bRc3fWo2UE4uWi0QlHvB8EKh87yEf7kuj116vQm6ekTBEcRL5b6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3w++GUsiuBT9NCWDw6uyxU0i9mz+t7k85IMkoMfK4pc=;
 b=S+n2iZUeCoFg1mFeM0nnIvM97WnYgVsROy4T++NxCaZQRmJ8YwkrdEkELqIX8Mb+YyAgqDXc48XZVEm7FgErQlRLFepJ6SHfTDQ+1LRhf0SBAIoZH6zUaUcSlS2mq/baMkZHtxSHyZKoEi/Upwzcw4oWEZ39NNvY3DbWparD1jQ=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by DM3PPFEABD4EF1B.namprd10.prod.outlook.com (2603:10b6:f:fc00::c53) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Thu, 20 Aug
 2026 23:31:22 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 23:31:22 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: k-hagio-ab@nec.com, kexec@lists.infradead.org
Cc: stephen.s.brennan@oracle.com, ltao@redhat.com
Subject: [PATCH makedumpfile v2 2/9] Honor CFLAGS in extension/Makefile
Date: Thu, 20 Aug 2026 16:31:07 -0700
Message-ID: <20260820233116.3105747-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260820233116.3105747-1-stephen.s.brennan@oracle.com>
References: <20260820233116.3105747-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::27) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|DM3PPFEABD4EF1B:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf7f64a-a348-443c-ecfb-08deff1324a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7owziuNm9t9doERSInHFpQ+uyfL7ohO+6DJHaWa6/1zyUX0GHDUhdFU4FXT3wx1QNApQ6XzpGNqUAzVTk+fWaro89Ml/elLmpJFGJuISRjkzqr8RaOuYtaLxosXpLuqDvyNBUCVjzcD65vEUdK01n5JFVrJ21v5AZt/Qw2o2xg2nA8/oa6oPs75T9dbYqfPe2iUXX/FSXdi/Iwvf+1W7RIn/Be90+S/amVC6TmgOqtKvUL56AOVXxXI0BBXcDLKnJWLx8s2yLAqNHflx3TLzJQ2gyHxC27VLGT9dtbUH4zgMqfPLMDLtdOgPG8JB2z8HBDgJ+p5GBggGgKkXz0iKBgGKFScYdK4vY1VIf04jfGKtMOrRyhBNBKJg/bIkmqdKa/BWFL/blm3P3EsvFU+1YCFusTbyg9XCFFD23FHq8EmYxBIPc4BV6+XaPj0AKVR7WrqHeMbfqoYcEadQmxO0ymouZjXedm1rPduZEn85IT4y7skpwvhqG0G+FNOjn4a1egREOKI+Epc/cTpXFPONdUYg6m/xLZqMV/P6vIC1ID0KKUNBfIR6MmGsblIIBjTP8Vn7adL3ILy0qq+3EtTbQ8QfhoN2pDfxdbbF3jMjRgyVZ+jrC5V5Bpop3oqfiE3Mpdd0M+txgl7gNoywaPf8dC5QNARxuJvfyxt7fAI0aT0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u9mSUBwxA+r5FcgE/lJzF4+h0CBtdRWyWxJuTQ2DpYb/h9g0zxO3O7BvIQMd?=
 =?us-ascii?Q?mrjIRYKEYJe4tGCkUevTxaArjWAfLR+dx8SEbxYxZe4lheWexMdEq6smWYMx?=
 =?us-ascii?Q?SDEEDo3a85ibkZs5BhegcwmeTbEs/lnF9EIX5af7dAzxOjk7b8Srrki7h/Zv?=
 =?us-ascii?Q?Q5yzOj2H8UhkHikmJHHCyypugKZU5k7AhshKOD9opudcrow8X/K4YGK+yqtj?=
 =?us-ascii?Q?QaX1qBtE2i7pwlC9eQ48xw2NgYQ4te/TZR7ySOH+Sn0gvRBYa/MYu8IFLDNp?=
 =?us-ascii?Q?m74AP641jHnpVc5zUEyqrSoO38xeUpxezVUER4Ti4S8GIJJoAumqjQrxmZkg?=
 =?us-ascii?Q?HoPos1vCd/2vp7Jm6tAuyZaPSkRT/ZfJ/O8NziDmbew5HKtUtRrTQds/UDx1?=
 =?us-ascii?Q?J2zz8NtH0qnUcEAAnxNcgF7X/d3M8xyR7AnLrg+6AQCdTpwmNUJFJ/1ENk2B?=
 =?us-ascii?Q?P63gqhDkMS+Cvz3cX4beybH3UGrX2udVhmIVyW0Se2MEqK3hth44aQMUx0nI?=
 =?us-ascii?Q?eBIdzEDyj93YGTXPrgICEB8PwQVxXN3+xgxandZRdZXNJXQwwEVRWiz/ONsE?=
 =?us-ascii?Q?8UdU8xCW9sk4E8/Lmgl/K9x41NuKX2n24mgt5XS+Xbns9fh3KnDmzQmbxVEY?=
 =?us-ascii?Q?1Tg9LYHX0pzsREnanzbI8ovMLcGzHUkweWcbQgDOH5g0NyfAzphIzo6DZ0j/?=
 =?us-ascii?Q?yuUz5EttLxVM9/z/J9Xq8lj2S7mbteL70ytrrUR8ZqLroglxJk/qvwa6jIvX?=
 =?us-ascii?Q?YsFCuNHCfhJ0pTh3rTWE9QvQu3bTnIyiJRXoWtrLdWMQrMzZurytOMAnYEfd?=
 =?us-ascii?Q?q4yf9xzRDtM+TvUVxJgxROcsQ2s8VdkcaA/3sBVfg2MsKFCGp2j99RYnt4o8?=
 =?us-ascii?Q?B5WZGfmu7ZEBHB7Hw+hhBnAlPhba2S/I6cIyNol2oTw9MHEPQ0CWIIhyzx1k?=
 =?us-ascii?Q?cB8cYUJGdCO18EkCP2asPKGcXXXFpCXxpzmqlXkf8FQeEsG+FUjTSegjVeUf?=
 =?us-ascii?Q?o7Xuc3TkN7SW0cX3uYx0+2Pst/b/bFvp03CF0nQeQccEV3vCSVaG5UOyZP+M?=
 =?us-ascii?Q?QMD9c3q63fJNOo66ZllBQzVV5RQozHamp7hUrc5Vq2BjfIx989p7HrZkGgrR?=
 =?us-ascii?Q?pMoY2DMk2kiQW22Gw20zu2cJ/eHtXNvleaYbkr1FRL2H1ZPpUvjUjhpuEnN9?=
 =?us-ascii?Q?x5VtbJwKwykeIV5beaqAezUeG4ZK6/OhrPTEz8BALaJuIXC39Mn/Raq0Y/7m?=
 =?us-ascii?Q?qHSLlrB15jiR69CHZ5PdqOPC5IcUIXl8QYcxmFxmlnMI7cXkkDSkuaxd1K/6?=
 =?us-ascii?Q?WRN9m+SGtRKUGptePru47bOd70NNz8XrTMJiQc11HU4ByMRM8q5VS7eJBuAi?=
 =?us-ascii?Q?6ZIUs6aJiLOEzYBWI9e1VRBevuXiWbYRowGlcFDT9BcL+YCawLQLxMv4v+L9?=
 =?us-ascii?Q?tgANO2CAs1BP1zDPOGXyDMa8u6bYPw+BetSQPDldhsFN5EGl7FS6s9rvOCeJ?=
 =?us-ascii?Q?7v9LNLkaEQPK/8cIBul4fTv7xEwG/vn3HyzzAj/njxd8Py+CyfEBIYCuBM83?=
 =?us-ascii?Q?KlItclOjCLG45hR85G0bNuxhgDXoaBDJe3mpyXbjbtm5NUER9Z4qGRKzOxQp?=
 =?us-ascii?Q?L+X5hxInnSNJbkaRRZCGhkUgbif6pRjrPQfyyLXgIWpmtJwM41DLiX57e8bN?=
 =?us-ascii?Q?6JziAqzut2A+QUEzmTwZTJL9rUOlKatkgnEfJyVb8lqwpVghFzHrV024dNp2?=
 =?us-ascii?Q?2C0gby/FEjN2bwQp68VnW0KZuGYbRK0=3D?=
X-Exchange-RoutingPolicyChecked: DpPjmEkKTElsd+PXmGjE/GR+2mvQg/Kb7c32nUvcZ4C/SkjtqIi5HTCumG3PXz8gJW6XJ5Ug7nkXeUDpSRC0KMtCJkUd3ZPaMHesTWU/hJqmyF99xdDILYT8MdBcn53XYkuHmuQ1jN4esZPEp1qihXO0HaCUTBGFta0d/9SQsiaErLqhZZnp81QWhflR1pqTuQ/2vtyXBFrSYKCukIVPmi3pNEF2omP4dekelBH5fWEAZ2MXA0fznhDl2elHHIl45CA/Wa2YQgy7x/GQaIzMV4x4DkWjd/dajS0KY25ynV2+iDl29DN26QYjGCGCvXM4xfMHS6zwDBvLJAA6+dyDuw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: G2WhWopgnu2qbNxp1wp81BCbhEbn4H5J8Bpfc9gjBCUn9xPr18wlqBObyMH92n4Dj+KVEIeDg9mtqWT3HVtaXBIQA0k5M0QciwG95ru5cFO/YbTuVrTPo3Bg7ki+6MQ5Fl4tHXyTjj6muiEHdqvEuv2KDaS3cJCck8yMV/QbH1j+isEXrz2+BRn3mOxYG36aT2sRpVxmlRuDRQQ9MA4UJteHOSg7HP5EVemXyiatyiIdGycaitSZV9lWveI1lzfkknHJMGN+2J5g+GcVhhsoAIZAEiIA3Dw3ZXM5+AHpiCe6qso2KjUq85cnH/MG0PSkjuL1GJ5znCH9JXLhjrSJPNua7cOVPPG5Ep7sMqN2X61ZmC21nGc+p6zZdhRhK+W89mqHBCBs6T0NV9ofzTr8UkqqfMT8a1A1REMVw8v0KksnhThE61pn2iQ0czxeuFrSBpXb+h3BJdiKoKwSX1ogrbdvk5dFtvrBjS0mxSBzovkadl6dUwIEp+Fm+dIh0s5hZoUg2FVlflcEoDx8Feijd78yBy14rJQpNJmB+tOqR3gCzA5Cm8Wpync5KIPG65rvU09ZGjR3gcHP1HTWicitKcga3VdjiCR4vEkT17g4gGg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf7f64a-a348-443c-ecfb-08deff1324a9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 23:31:21.9253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AglnUzv3M46f3rlKocNwO5BuWRVe0uuERwTB9i7gWYlomzv5+ho0Zg91oWgVXFAFIz/YCVU5/tnSk3ypJhbMVyCikVDgtQQ4JKh+DPB/evY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFEABD4EF1B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_03,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608200175
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE3NCBTYWx0ZWRfXzTlMWbLD1PIj
 Z6StTRJ8JUpDmdOxOsMNluVUzwT+9335VXx5pyg4eOgfBxnIcrKfzDPFAg79+/WVLKuZ4Ykn4mP
 ZHy5QFZkHGRDQpchB6DuUyLle8BSLGWMlTz+DTWKA31d9JbgCIqVLcKDdvS38OQ0Pt1H5J5a0dm
 lLwNU/bax2Y9X5YC5x8AOZ5QEYBnQlVlwHfSp7sJyBxSdO8r1JO0yVwYe7ESFk8wdXMbZUP4xAd
 /Z+QI9Rpk9GEZAUJ7352P0k5BPqCfPZWThLg4uYRR6418xEhruKga7Kd01IRhCXmY+1f7ubSHUd
 hWovF5rhwF+mcmWEBEcomWjmTqkPh3VGjINF09DS3c4Z4VOvo5b9Y0RUdh2Dhm4Hf36rzstNI0H
 1ek3b5le50v4CJCm5hh2YZ+CCOkxFY4SGXkxb3qnfgniJZGn35h89xF23kbcJjQLMjCH2h2nxg6
 LF6I0FkE+XAZw9LaHVi0K0rSKECqrXZK7TgKbqAU=
X-Proofpoint-ORIG-GUID: HWCW0m3_Y0nccttyoNp-UvSAsDbxLGnf
X-Proofpoint-GUID: HWCW0m3_Y0nccttyoNp-UvSAsDbxLGnf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE3NCBTYWx0ZWRfX+UHymwb56cgU
 GVlyRvBBbbSnQSdYDCSp/Un2oe81VCskjUe5jMuPQYv6xuemF8+Pu/jJEyaJ+hPJBHh9EDPepLC
 FHrrMKB8naemXVgRc6rLQeUkCcyOjySmNoiOX/n7l1agCUssZAGx
X-Authority-Analysis: v=2.4 cv=GpJyPE1C c=1 sm=1 tr=0 ts=6a878e4d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=7wwgIE6T-nLNQlAMlVMA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260820_163127_112776_EBB3C32E 
X-CRM114-Status: GOOD (  11.27  )
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
2.52.0



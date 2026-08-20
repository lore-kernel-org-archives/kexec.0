Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89B2C5DF87
	for <kexec@archiver.kernel.org>; Thu, 20 Aug 2026 23:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4GzULLHlxwwUEF/cnYGrD1uh3Ws4novjTmCPkLjx808=; b=zczw1rHCoUUAiKpXcpATY2X6Uo
	k9ssJfhXzrB2R9RTNZTCwbY6B2j+Zu8iQ+oVQHJpBctBPtU2C4Iu6AADn8AwqcOMWsMP+YiVyu9Rq
	ciJBTShzZhSuwzNkGKuMEINqNrwpYWVWKI9songX0yzkcYJUTPGZb/7fY6pRomgDf70RYU1j7aIM7
	/qUVAiBcR3EycTtbVyceTVqhlVRGsaKOSh+CGArMPLDuCypy8FSQoWNPJCT7vavBdOjW9G4CP5Xto
	jjfU4TgyhcQ9/GIS5SaIpRdzEs4fIlQQazoumoevChl/DQPrrD1ZDXsGOnFHSZuYmJjidrCE1arLR
	AoOtHMlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxCEh-0000000CLR0-2thz;
	Thu, 20 Aug 2026 23:31:51 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxCEa-0000000CLKn-1ANg
	for kexec@lists.infradead.org;
	Thu, 20 Aug 2026 23:31:49 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KN1U3i1281363;
	Thu, 20 Aug 2026 23:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4GzULLHlxwwUEF/cnYGrD1uh3Ws4novjTmCPkLjx808=; b=
	lm/A6tB2ePeGpZOgsdSg3gyK299CBcBszRdatADtmhz4vFZBWrZ2Mv9/R2Jm3PSR
	I092ZtifdS6vCQK2xwJZ4Nlml2OHrfsSzg9mQYvMgPHGtXQG1UMmdVxoqiDhTxGD
	N/mrMqzWa4CjaD/Hg5Cy3Fo6V7LrvY3o2ZmkZHbfpUIADB50sLX+SodoxhY40RTX
	hd37pGtLTIxjWWzr9vsVYa2pMjyooDqP1BymXrpkKT/CO/180WbYDNfOawmZRbo+
	UsQ3cY0uC3tWDBmras0kJGqshim+QZoQVKtc36HlxzllwdHz08zemmkouy1DVWbf
	Ymt5EkzOL+MGU9pKlQ2O4Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g4yd9cany-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 23:31:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67KNU9ID034324;
	Thu, 20 Aug 2026 23:31:42 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4g2ejfr334-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Aug 2026 23:31:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJKE2BnkEWuCI9vr8GKcOBbcJraHfo83FWOsm/MrFXxA80T7PMG/u8SGPmgl2mF36JTfzJ3I+i8acLMl4xSdky32MFRcvob8Pq/DOXC3+KP3zM97kGtZHGDMUjL2eTJQ3AigkWjaUEoVC5uCOmeETKJjrgiWEZVYGT0JZHcwyG9DzTGyXyWoSzkF02cAXdhMFMPYVGogs/3mkuvCBi6lhd3YoB92l4TsrDrRkhTFDf4r81BGWCxIok2eqDfAYY7FjLzQPH8ZN1fDhcpJSWizFPDEHfGalvThBSy+yt+2yla8jIEJOxeUcmnyH2q9mpYtswDXnMU5CT9LanRHaIN6OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GzULLHlxwwUEF/cnYGrD1uh3Ws4novjTmCPkLjx808=;
 b=DmnEMELpUEPSTtU6VQCLO89aNoYCYOaS5l1alC3K7odp3QLfcGZyxVvmoDwOsdiM4IW+t3g+gPF8kV7QV66JeyhFBvyTvzjDyxHz1X0P+I/vsSBOWnNChjyliAUtDVv5o5skfq/NiwerNUNMkMz6WCdhKMfI7aYlMnigRolaF3/fsuS2dpqrRUKPAxAcbulkOqN4tM5lt9lGDGXJakMqbXKKEzd22c3iGrr76+X2HA7cv3T4+Pxx0WCTAjAoEtGUPkLK2/rUFC0yVwRySO7xTpUFNFenibCK/suuKiKjniNJW5Wf7yxjO5kEpnaHt6I/wZbmVY7utU0VR93eyWGTyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GzULLHlxwwUEF/cnYGrD1uh3Ws4novjTmCPkLjx808=;
 b=yQ3bFgr4i9ZPxSZdGVUP0HoTl4/ktkXlrdE6GVRPP1ZsK6h1fHjh8y6gf8axyvqfNDELZcu+UIpqTkn2qMO71JdiubcHRtVVUxTBk4Imq32YEye9SaeCw6JaUPZZtRIqXFKas2aU2WVXkR8sIF2MTquvCKoHV/yryCTTo7lkWpQ=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by IA3PR10MB8420.namprd10.prod.outlook.com (2603:10b6:208:579::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 23:31:34 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 23:31:34 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: k-hagio-ab@nec.com, kexec@lists.infradead.org
Cc: stephen.s.brennan@oracle.com, ltao@redhat.com
Subject: [PATCH makedumpfile v2 9/9] Add elfheader extension
Date: Thu, 20 Aug 2026 16:31:14 -0700
Message-ID: <20260820233116.3105747-10-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260820233116.3105747-1-stephen.s.brennan@oracle.com>
References: <20260820233116.3105747-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH1PEPF00013308.namprd07.prod.outlook.com
 (2603:10b6:518:1::15) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|IA3PR10MB8420:EE_
X-MS-Office365-Filtering-Correlation-Id: d873d2be-ced3-42df-192b-08deff132c0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wLeLfOH4R57UVJCZwVc/TXWiVDMP6yt/YnKzgxiW+wHHQiXY1CDL7eBzqdTPx08I6J4c5pQZk7CsJLq7bhqScSvmld7mE+yXU5Mg0qqDl8BBO0o0pTf9GmU54TLyuT2ncDZH4yWNKI4+pQY4SFhcsBGlFSLGjwXLz9/gh8wGreRKNnqXnNmygB34U2AMkVtsggtLVhJxtfNvLUNUDc8OqbagzRk4USC2ASXnfGb0/HXEXn6aLAmF2vOFEUgDl4/GSUGISBodc8qBa5EPq4yvz4Lp0HWlVQDfG4/B8bviOb2YY4neBjg+ErEWhgyGQUGw1jeok8seL9SS1NKiHTETiFDTeKC9iYJWs3aaHp/g8q20x5Cp/AlGWuRHsJo48CbSa7Iurtg9TqkjSSbiMU+vHkA3Q9Vcdk8uGRWcQQZOCw+ERe2EdQ9MCvmiiIuXYmqIzIMkX+lvjtWRdabsljPfcycrRI8604PhkoqIRWI2rim5C8fQy2FF3j6QAoRLyraAA5xwljp1hoR1WTyWpJvo1dI9C4SKQUSMlPoufuQlMTRPj9chnqz9qmbYdc247HfrI5Ch1TkaEPUtxGonn1HhmH3kV3Kj4njUJU3CJxe/AlsoTdDHP6FwktUCm5SUlkj7bgpa5m5J9yMusKSJ/5HG8Kx6CX/CdDyGug2dsg6+4LQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fkeUUXO34U5SP5fUo5E6wTdczFuCLvhEU6FJblto2MsJEWPRaLtQsZWCAwYu?=
 =?us-ascii?Q?0Eq0LLaCWxodNsyCzl9f8VrNHkALJe6QK9er3EYCkuzzdGamGG2WmRj+Osll?=
 =?us-ascii?Q?pPr5mGYlBUPb/JHv1YM/wAwquYM9cxa/vDrS1CQzLTdTTs5AUTdKQsabPsL5?=
 =?us-ascii?Q?oeBARn4cK6S0SOmS7I5HficEkeKpVOsckkGeV/XQWpmv8HeBgypgSmHTZ30/?=
 =?us-ascii?Q?q7av2MbUbRocDmGCyOu60e69am84/SI8MElNWOBp+rqpDRqG++m58wMObQV9?=
 =?us-ascii?Q?XCjkZz5wGYVT1XK3hDWNdTP0psdxS2cf6tZfrUqC56oLxyMFgnqFibfa6Am4?=
 =?us-ascii?Q?ndY93LAKAROMlhp6ItrYa9cnWwp3lyxL9tm+/EdTxjxZQoYqshcWLJr5gnxi?=
 =?us-ascii?Q?fZjSWdC3f0BmsyWd2LZs58Bz8AFmdrQZBK3wSOwQ1Ezn0JQIuYKRbIqia732?=
 =?us-ascii?Q?ztCdVZRN4W8zJk4Mzd3M80ZuhWFzagabBrX8JhelnuYAQtn8ZtZSM4gpkUmo?=
 =?us-ascii?Q?081PdpspRWAewn3+vIcIOB5JI8D0MCvEJYoPzUgLxiHsHd1//N5URwZ37EZX?=
 =?us-ascii?Q?JR9VSOwakmhegUU+foOTPH0eSEe3FpV6YbHX7A3AQyd5iKnAQaJQTQc8VNLU?=
 =?us-ascii?Q?suX1i+r67vvoZHD4WGfS0ydw2np+7Sobn4xujUOxfHTVBx2TNNzLgwZIJIcm?=
 =?us-ascii?Q?UgBdbQtm4s3MxJbfLp3IxO51G0RbaPNtClVEmrThv2iW4viEhqY7uZ/8z+2C?=
 =?us-ascii?Q?HqnvzjMYLGCgh77+PhPqpRsf5+KDue5jJ0OXsEoGhhLyvLqC/UR0rtEOQh1t?=
 =?us-ascii?Q?dDNqep5VQ6urHD4maW7fe2DvgzkQ+dyXiPQ2Hsiyem36671vV30M+06nxGJ5?=
 =?us-ascii?Q?FxNfSsqR74DxvoGIfokWIyySeE1Kaj3tXFExn08VoCWeVfA66S4DyZ6prwBD?=
 =?us-ascii?Q?j8/Vc23kNyHeoz6VYdrPSatxMWuLGMchC/RzOaPi+e22aglbslD8DvT9HIBr?=
 =?us-ascii?Q?Omh8YcIe84aczxvRcLt1ftFIQkmdr1Tgr7UC+Nxi3p4DzhwFV21BWUfldD05?=
 =?us-ascii?Q?XLxMKSB5fsq603Qzs8Tmbub6YTaGbvcy/PzjTunJ4p9n8NAfLOWeFTxY3f6R?=
 =?us-ascii?Q?wAzYUpjZrdoAlP+S66jikh9B8q9U1AGqmSk8/Ptp8+G1ggHHoUKlQz9q0MER?=
 =?us-ascii?Q?BcEqKjF/jgEdlqZh3NYVbidj81Nlt5K9dlP8b9JThWqsnTgFa27VJhWjNvTe?=
 =?us-ascii?Q?bZRkCK962qVw7pTaueOFU6c/4LhLug/OYzxjOyRY9g3dGlbeRnkU817etusN?=
 =?us-ascii?Q?1D0iO3KlOkWPw+gplWzC4hidAnS9UQr4Q0jLUjidCcfc4nbrtQGFbvbnN8c0?=
 =?us-ascii?Q?3w2LBhwsIFIHJa4JSSRUIVvq3enyZSzO1dSxG8S2Mlaol5h+9GO9gMlqaO5H?=
 =?us-ascii?Q?/DpP4C9hRAdjq8m+M3Sb+Dumq6vRphW+TJ32/5QG8R1K1UB03usLn4ertaYP?=
 =?us-ascii?Q?VeFlM21bRZKfNdJHv0F24PDjqWJhI+qSjqUVed+Jnoe2KCicW5vj4WvGQNZS?=
 =?us-ascii?Q?uzpbwF4jwQPC+555RV0WV01u62QUGuDCBT//+KjKRKkucyK/aiY0ic5gVzIx?=
 =?us-ascii?Q?u6txZVYfkHxnEtDa2k4LprvWa287zRktg8DlgT3xFkCxl5cUa1Xta08KBX8W?=
 =?us-ascii?Q?q+Q4pPmDztRm7Dgk3uVPHO6A1EBjEP94V1QNfM2MDgslYNoRBiv6OZPvUanS?=
 =?us-ascii?Q?49IVjTvt14t92j66Vw+LwgjxoMzGN7s=3D?=
X-Exchange-RoutingPolicyChecked: jUb8GPLHpUgPVyb/D6P9O9lcgvIMwJ7Yxx+q4G5KwEKNHo4nU8hvzq9HTYXqGsgqUnvAijkJ7jl8y1Ypqap9Ovde8RaEm/s9fjag2PWt0GUhgdAEZgUxZeIILV0oVE8k5XfiZngCMmuVANTQGA6fcvyHvldnNIs+ninUM3P8/+LWhORYDjcIDo1T5f4Ue7ezhc/UI6a+wIYodaE+JVRYyGGOIggzWi0GswEIKzXhutn0VJVBvGL/HIS9ZjidXSrAC9+N+ZNVQCJaJBD5023+7gEMg09cpz46J34jIOCYrKGPg/AGmMIR5pUj0hTjt847Pb9wrB3p0uH2TGIzTDrY1g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gHVI09gGycQLw1kl0b9nG6evj23nfhs9I0/34cneJUqHV6BhGeYmFx6xcsYwc9lwx01WB21io1hTMEHQDt04xQcnIYA5Ye99FvqpB/xBZ1XffIW1X1PF7Vsofu1KIfQc1LHstPRbx9Cet9GhUQ7D7yKm7tMs2hezPwhsUwkpUaj6LY28jy5eBDazkwrXuIJH5JqcVXEhk90wXaaEvhT9cNeBzYc6IxUVgF2RYEbspTdVwQnyxElgfsx8MPW/uxLV19oajDbsbc7dbEYGpSWV23TWU6DyIBN55B91rlu15BLvXD5g6DwYtAK/8O/5TkjiPVKJNdKdvxRRskmzsjoUqEw+pBQnsBw8CBGo3ml+4EHX5261TsmWHTwYos8Jx7NgrEJ9f4QeQwIjsTOs+e1XRYXDjELfaMOmxSF6eyTSC6oIAAOumcEA98CQIJ7fT59oMKaHck/HemAOX3wYamFtOrzNmoJl2zKnwrdUw2fILZNhuKIh5RJd4fgHomIQP23jMlGs/1/oLoRt5K38gcylwczE+HaTWkuSfulV/FuevpFhCiaKhXZptr3FFM176RM4GxEZ3XhtJuXKZHN/Bo66631dcWzkgYEm1y/6ptTlLwA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d873d2be-ced3-42df-192b-08deff132c0f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 23:31:34.3181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwrgwUqb0idCZx8FM56bulRT/XpnOr3Kv4n75h4jVzcZ8b/iJ4vDM57I8bwA3PX2WrFH/TlmkaWCsAlRG2cUjc+vB1fWzce7lxrBk60iGH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8420
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_03,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608200175
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE3NCBTYWx0ZWRfXzvee+j3Bxvox
 qXweiwUcEiHrdvtyfGKuXkcgZ1ZPPnZMsfVTnw+rLWt+SM8KnzHfJm8RoLT0KkzLbJuUDIEptiX
 +ldLXpDjJ0hS4A06IKKCzEaKgTS7QWYtkgiuPC6ZLitNPSzJ95nq
X-Proofpoint-GUID: zWRUaOKJjzn2l4UPnKnP0WuVGk2japtq
X-Proofpoint-ORIG-GUID: zWRUaOKJjzn2l4UPnKnP0WuVGk2japtq
X-Authority-Analysis: v=2.4 cv=fbCdDUQF c=1 sm=1 tr=0 ts=6a878e5f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=baiSg9lI4TYJxSKu9S0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE3NCBTYWx0ZWRfX8aNQik1Drpmk
 ZBXVn3Cd1I3xtDPZY3q7/i7YbiK6zANsgfucHrFD/JZaSuld3YgGEc67OQsL0S/Tw/n6g27vM6V
 GJWlnwK8bb/ASry79cTr6aKsmYhYhCJjLa+P0sBUlp2cPocCtWB26oMGZgXPgV/Xz330XcURB/A
 JRrsrgBTn7CkvyWevwEnagszyRggIOzJAQE1BY+TH0IeQsGiZ/9UDNXTIQ8YjVV7GvOF6R05OZb
 XM/9lHte0gt1bZzFRnu7PuXwM2xIs1lelwpE2a6CPW1G2L9NRL8EQ+/vPgSjTr+ktXNfNOsjYVk
 NeYkIZCl8Y+UYlQL4abnMk/au4sT/zMp0s1mOTfSPw3QgusRgKpZSFNrkYLAzk0ZdnXXDuh/IVD
 7WoeKPxppuNbmtEHR5f7JRphNJltXxUFpYl9qlzbW+HRbtjrhUmV86NkCYQRg1sfwZM0DrGGgCJ
 /HM57hQaWG1jNolKcTw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260820_163144_458422_B698E58E 
X-CRM114-Status: GOOD (  25.31  )
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

This extension preserves the resident ELF header pages from the page
cache, which are mapped by userspace processes. It significantly
increases the chances that an ELF file can be identified by its build ID
and thus a userspace stack trace could be extracted from a vmcore (used
in combination with the userstack.so extension).

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 extensions/Makefile    |  2 +-
 extensions/elfheader.c | 93 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 extensions/elfheader.c

diff --git a/extensions/Makefile b/extensions/Makefile
index e8c41d8..c7918c7 100644
--- a/extensions/Makefile
+++ b/extensions/Makefile
@@ -1,5 +1,5 @@
 CC ?= gcc
-CONTRIB_SO := sample.so erase_sample.so userstack.so
+CONTRIB_SO := sample.so erase_sample.so userstack.so elfheader.so
 
 all: $(CONTRIB_SO)
 
diff --git a/extensions/elfheader.c b/extensions/elfheader.c
new file mode 100644
index 0000000..ccb17fa
--- /dev/null
+++ b/extensions/elfheader.c
@@ -0,0 +1,93 @@
+/*
+ * elfheader.c: Preserve resident ELF header pages from page cache.
+ *
+ * In order to accurately unwind userspace stacks, user debuginfo may be
+ * necessary. At a minimum, it is needed to translate addresses to symbols or
+ * function names, but it may also be needed for unwinding when frame pointers
+ * are not in use. Normally, userspace core dumps will retain the first page of
+ * mapped executable files, since they usually contain the build ID necessary
+ * for identifying the executable and debuginfo. This extension takes
+ * inspiration from this approach, with modifications suitable for the kdump
+ * environment:
+ * - Include non-anonymous page cache pages corresponding to executable files
+ * - Only include the page at index 0
+ * - Only include pages which start with the ELF magic header
+ *
+ * None of this guarantees that all ELF headers will be included. They may not
+ * be resident in memory. And even if the first page is included, there's no
+ * guarantee that the build ID resides in the first page. However, the best
+ * effort is already good enough to make many userspace stacks intelligible with
+ * minimal extra dump time or space.
+ */
+#include <limits.h>
+#include <stdbool.h>
+#include <string.h>
+
+#include "../extension.h"
+#include "../makedumpfile.h"
+#include "../btf_info.h"
+
+INIT_MOD_STRUCT_MEMBER(vmlinux, page, index);
+INIT_MOD_STRUCT_MEMBER(vmlinux, address_space, host);
+INIT_MOD_STRUCT_MEMBER(vmlinux, inode, i_mode);
+
+#define MEMBER_OFF(S, M) \
+	(GET_MOD_STRUCT_MEMBER_MOFF(vmlinux, S, M) / 8)
+
+static int retained;
+static int checked;
+
+void extension_init(void)
+{
+}
+
+int extension_callback(unsigned long pfn, const void *pcache, const struct pginfo *i)
+{
+	unsigned long index;
+	unsigned long inode;
+	unsigned short mode;
+	char elfmag[SELFMAG];
+
+	/* Only consider non-anonymous file cache pages */
+	if (!(is_cache_page(i->flags) && !isAnon(i)))
+		return PG_UNDECID;
+
+	/* Only consider the first page in the file */
+	index = ULONG(pcache + MEMBER_OFF(page, index));
+	if (index != 0)
+		return PG_UNDECID;
+
+	/* Only retain pages which are actually mapped to userspace */
+	if (OFFSET(page._mapcount) != NOT_FOUND_STRUCTURE &&
+	    i->_mapcount == UINT_MAX)
+		return PG_UNDECID;
+
+	/* Only retain pages for executable inodes */
+	checked++;
+	if (!readmem(VADDR, i->mapping + MEMBER_OFF(address_space, host),
+		     &inode, sizeof(inode)) || !inode)
+		return PG_UNDECID;
+	if (!readmem(VADDR, inode + MEMBER_OFF(inode, i_mode),
+		     &mode, sizeof(mode)))
+		return PG_UNDECID;
+	if (!(mode & 0111))
+		return PG_UNDECID;
+
+	/* Only retain the page if its content looks like ELF */
+	if (!readmem(PADDR, pfn_to_paddr(pfn), elfmag, sizeof(elfmag)) ||
+	    memcmp(elfmag, ELFMAG, SELFMAG))
+		return PG_UNDECID;
+
+	retained++;
+	return PG_INCLUDE_HEAD;
+}
+
+__attribute__((destructor))
+static void elfheader_exit(void)
+{
+	if (checked || retained) {
+		REPORT_MSG("Extension elfheader:\n");
+		REPORT_MSG("  ELF headers retained: %d (candidates checked: %d)\n",
+			   retained, checked);
+	}
+}
-- 
2.52.0



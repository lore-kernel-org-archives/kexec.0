Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAE1C44501
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 00:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hU1GghLvd/fGnm47ph1KLcLcVvOVCya1fTbwnBROUHQ=; b=jYZg6cbkwZC86baZMdUGvYtkjo
	aZBwJlnY0hzWOePzQQT85oa4sl4ptwd/e4PVcnpB929Ie8S4o7WrZitSqBW0c4HUy9Fo89Hmc8LmI
	l8VMS9HPyc7sSqAQNEGPEAl/HJNk4GSxXYW0NkvRpsYWoN6v6czyv9ybnfZf6snbOcH2QO2Al+wFc
	OXdlpDrDXvI8DBcT5roqtNNwBAx+4uFVgIQe6C/BjzylRzG1s7peD7zA3dcMvAy3Ijkv+vzqpcnC+
	O/tYyHTFWerhyLwX+D6EVLHNLFcti39xCXgUw9+eFLlesnbBJ2XCGi0T1ZZXXqoSYDneTAvH5CGGW
	EwiAu6LA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjRHk-0000000AcJ2-29KU;
	Tue, 14 Jul 2026 00:46:08 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjRHi-0000000AcFv-0ceG
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 00:46:07 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DLF80O1346125;
	Tue, 14 Jul 2026 00:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hU1GghLvd/fGnm47ph1KLcLcVvOVCya1fTbwnBROUHQ=; b=
	AFYApQO7cAbhrxjzPpFqYE5dL/pBqd1aZRuI1mCrC3iNVSpZaZ6ahkT36JvwoBKo
	pnwjdoq2ExcSj+IJGow1bqv9Pwb8D9dIwvH1XcOrm+BMbYLZ5foPIyC6II8Wts6j
	29UTyZZoEQIjqBHOgwxREPx8xeRdwKiyi2SAJRom20POFxiA2u92v6+RmdVF5G1O
	WDW1ovLW6+/fY57elP6otQ94fh9CVowP/ycAKEL/lHwfotoWqlMJMyps6bgwyNIX
	N6mXe8RW52AM6hfO61otmS/Tz9Ro/pCVy+6QFA0Pzoxdl4r6ANXkxuRg8QFrCIZ7
	kOvQVgO7DiUOHN/Z68H4HQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fben1k9f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 00:46:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66E0NZV8015056;
	Tue, 14 Jul 2026 00:46:04 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9qk9me-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Jul 2026 00:46:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGOe2oe/3CGhfBy1uuj/ErcJuRtQoHDFMxCuXIAAcsA202OqJTYX/1O20dq12wlAiMtCqAgWcwDd1pQX6oyplfxxVK3VqqLQ0J7Lmy3rFgdv/7S3zLZ2Cr/SLM6bU+LBj5vh+1YLlMSJ+QZ4Xi4vYkrl7bF78/iwfVJ9an8LHvEt1NKYoeMWV0TwLAIj3x+Uft/wBfAfl48Zscd45kav1/Rv8HNaWJkcdVH+53AxlFsYT15K3MNuykcj3DpzE02Uz4weA66vleauMxFoUb+uDV8gRZT3NPyZyNqHpJtvGX3qBix20WqwRtr72eUHDgw6SaI4wWxoDxUetlhcsKZmVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hU1GghLvd/fGnm47ph1KLcLcVvOVCya1fTbwnBROUHQ=;
 b=f2koQRXbMYweGc824wkePXcqvteYUFHXrTaIgZhLusG0yIpUcX6QS5EBH7shfnXS/1w95+kXh/Q4Xw+0Vvg6WUE0SMgppU5FnCvOcITHwNDW7tx6Ejd/SBP0CFlhX/MZrmIkNEAqxvIDIJxasg2G2j62+qzT5O5lL9qUmxcDww30UnWvqGYefbOEbiUL9PU8TVcBd6VdRSvnRVqZeizjLZeZM1bEEfqVKdpdmm4Kpw2Yo86a9pSIddOxeUUyBLZYEQdnNU87IcMUpJzUb9KKIe/k/Z9wmNQ44qB48zzLdwzGpDuJjOlHRppmb+D7PFKkGb8H0goItw4PZe1pk5xr7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hU1GghLvd/fGnm47ph1KLcLcVvOVCya1fTbwnBROUHQ=;
 b=z4dztfRQ2j7hYMKfGmvbbJIAttvKXAFGKO+oZ9DNccdRT2m5b5/bzkOYWtf9OaHlAyWaRofWutjmzPZqo6aWo1BsTN7FoKoSAtwvL+w5rkPQKh7WdTyLcfxpbbEjkggmL0JL7rNRfs8X1KHLT4/JCQJ4Bkp+zLsFkemVMZaxGwc=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by PH3PPF3CEC6235B.namprd10.prod.outlook.com (2603:10b6:518:1::796) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 00:46:01 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.21.0181.019; Tue, 14 Jul 2026
 00:46:00 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org
Cc: ltao@redhat.com, Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH makedumpfile 4/9] Introduce a stat for pages retained by extension
Date: Mon, 13 Jul 2026 17:45:37 -0700
Message-ID: <20260714004550.3698175-5-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
References: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH1PEPF000132ED.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::32) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|PH3PPF3CEC6235B:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f9c21b5-d529-45c2-0e9c-08dee1414647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: Sp4ZpzGDfShMnJVggwh+w6HtzWZHPHzK53YrRy3x7eKcyspeNSaLjm7mYsIWQNQs/i1q1xcsCwIHjmUC0Qdjb67M2yf2rB0BK8cKgrPZPLEgGdMnmSNejh0nzTOb2xQZ+22/faQiOQqfmQiPSSKT/DjlHtpTIh0kfnTbdjlkEk9HcXk7COV+UfKhGoF5oB4oZ30dr7xWuGQwrJDvqOCNn3k8gaVPcwJi8QVO/qpJqo5LN2UCYkVmW8HzDbpRz1wKfGQ7rpFe1TdxxLfmK6sIfch0AGkob7Z4AsYF/hCBD9AF8mLqXlp6yU1HjBUh+wqwjIea+MGbl/yNWzbYdMeAJJfT2uy5mAhdAA58ef0bE15CrGJsfnnZE/oDMMsScMfrUbNduuq1EVxBR1McXNu6S4PMkc0a90Fd4nrz8exk8u2DZSgrr+W6zLpJzcyYHe368VqkuHPU+rLNU6OBIf09UNCcX1Ckj29IlCM/iEEm4pQKDgCG1ph8i0eVSW+amasLVotCWcVjyvyCjFzxwV5BRH2jVruX+cP3fMAwQuldF0T2Lb8YM9nttHoFL5wIxs5BBtPRtgul/oVEDNyZqJv2ibCyfnsdWwg/KVFlUMkNSFTrdviZFOh5hARlMeoqAggQt5eDhO4cOAaW6ynMhbNQ2U0IfoQStnyvzNW3i7kOsKw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yGmbsTbVDUNGU4DWs7ORwPGwI9ZM4rWwT6PDS66bBeeqjxi3Y15Ll8c1XfGc?=
 =?us-ascii?Q?7q1AlqWETJPGQAQVqypsqtdG/l0037q7IoHKiycuoRsGF6Mo6gmgb7TqDdz2?=
 =?us-ascii?Q?fH917qJX41vvlQzBrHsUD6f+PvEydB/DiINFyu9feQEtVS0HLJ/TlnmwdZkK?=
 =?us-ascii?Q?5jB4DhLtEDET5t0l+Fty/EIl5x+zolW52RfMwQtjPomY9u9reLjvvInxg87F?=
 =?us-ascii?Q?vWDno8UFoKRDOOvv1H4jyROjLyJ8GbrxybtzcaKHUAaUXLEl3LDcUe7g84EH?=
 =?us-ascii?Q?oe3LoD6Ekcj+Z4/S3k9PZFuaFI9Q/TLW/ki2vDCYdsdJnE0PXnljpUw1Jyai?=
 =?us-ascii?Q?AuKlQj5Aok0r2k4Nr8rT9NN0bLDPUgcpeysAUfwiSnV5arN0Xi8nql99n4DR?=
 =?us-ascii?Q?BWabUaBqH3mOWodiLSNypEsIyEnVWRsq3VZWdpZKGMLpXMmVhq6/pjS/iJoS?=
 =?us-ascii?Q?3TZk5jKpQoy5qPsePH2TrikVv+L/f4v6FpWWeqQZBitKZPhtYehkEclxOGOM?=
 =?us-ascii?Q?iLkGPnkEKFAKBwBMs8E+7cBgE/JGhZKpwzWCeUpvu/8sMIf9JtjRawB/6OBq?=
 =?us-ascii?Q?bJfRnEapZXLFnNKU9fP6UHQQhgxBQKzbJ1NNtBaCevvoq3WRuCsnri+PIOS+?=
 =?us-ascii?Q?syYiBneRovnuPbhjnUrSoucjuaOngY4RGLoyb+RjqjC/csSpm8/NqpldXq6D?=
 =?us-ascii?Q?Iwbfxc/MschZxuplzG82uLrrFr54EXCLJQ21Qmd+Q0bseUsq8aef7FzXfe6h?=
 =?us-ascii?Q?5pLValMWFcHY3Ykyw5J8VnoCUWaCobrtVLsUBQ+csaYCzvSG1h7azi2rsd0T?=
 =?us-ascii?Q?tBHBeLp8f7BtCftuhU29T8xnyl+8v82WHmrzKHSf/orqLMrWk5AHr4EQ8pq2?=
 =?us-ascii?Q?RZ1er7xFxn+I8jlOKEEzXHe3m2Onsv2wo+RDmCzCYBKdW4BQH++jqu+V4kak?=
 =?us-ascii?Q?dx7TA6zVG6SkzYTVCdAcXKj4ehxWlksy2j8b6JC9nwjeDy+nXwSiT0gvWGyW?=
 =?us-ascii?Q?UY/smFPEDNXOAm1mCaViP8hXl3kUiFi2Qoba13cNEPwEAfPIe/B0HmjBBfcz?=
 =?us-ascii?Q?7CEXg7vLJ7ffC3X8XeV9an6VypwyfwoqhSLFMpgFE+vN9voEzz6yHdBGgnab?=
 =?us-ascii?Q?wMfj8bIEjDs7zABHKbolODoKPhdkLu7fxpd5zYdACkuiXsbPdd2k+Ily3zlc?=
 =?us-ascii?Q?6lyuPwqlWHef84o/osjroC2JrJgmMvELwQpVizVJDec4xCJZH98Dy643bRqV?=
 =?us-ascii?Q?aR/3+OccQ377UFrLV4le86Ftg7MFoNsTHQuzE+OcqWdbxllUWouN7gOPtlq9?=
 =?us-ascii?Q?yElvLH+ZmrYKhQz9nVg2RYPlBUVTLeEBbZj2oiwf2sC3bxcGumw3/pW1r2S7?=
 =?us-ascii?Q?VgHi4PJG4mkLvZlQkSsD5fQvxz7942wsXAA6goIOQOZ08eJixPXqIAL2GA97?=
 =?us-ascii?Q?I9FQuX+WOMSgvmdbPTr3hh/wZK8QXWrF8RYySVU8arSld4rXBs2FJr1tXCCz?=
 =?us-ascii?Q?iZ6UoIhCsRYJ4wf2Qwkx0F+uE8SSc9+65KH3OWeDC6kE8fvctTlkv4twrEZS?=
 =?us-ascii?Q?kxEHB03grs4RM3IMiovDVhCz19X7Lv70oGESsBme8hRbhgVNBqWa9Rem5tuz?=
 =?us-ascii?Q?LPqP/zqiVTtzIjlHUDg4XF9TmRu9UspjclGW0rj1U94aNkPqEfGSBgSAD5DK?=
 =?us-ascii?Q?c6NwhZ1D7Z/AW8atN806+JhzHV9ywUWNBiF4A2JZOlBbQz8bVNK/aLdjUc4o?=
 =?us-ascii?Q?QPCcvAMRo4iXicBiHvaowWqysg1n23g=3D?=
X-Exchange-RoutingPolicyChecked: MDJGFnHz1IzANasTEmq861mKZVTrJub6PYIR+MZjSlaeJKyIuHcJCPBfxLTTGv1/9hrt3xNsPn42eMi17MuXkf+72MYUpOHKTkCaF6eTQ5P3Pb3gna31RzJrb03z3h4N/IRYez1/juMArPVF7e2xR7eJPNMl2ebMNic4RewqyQqW+Tb5KRCOqpXRnnQfa4zARifSXUdhk9PnOCAu/u3HrJ/IHng5Pt3Fmswba0PjjM3ZkaaniFyrq0dOPckZQtAqwK8BM1EcDUGhFjmMTmvm1aDyAtcxb1CIraeH4heZyhrDCrDnQAf8NaLiAop9ze4PvIpGyP/8gAi2NECn6YUDgQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oFcNYj6fdmu263tiogJuZKraT2/ALqIKaI7cu/IIw9AbHCLs+4TgMfNzdlMVKUWHLJ2cMM1N5KZr/92uNWAvKO5WR9fuYqCiJyC5Vo4OPbJo9EA44myH+wyRuMx8Kj4ndud2dDg8qhxjYXfvXQ1ott7tTx6lzEmrUB+rQCGa3yoyY7nqCcVZsT/xp+5cAx8ZZWKtEwg42dbWDdoBpu+FtfhxZFCFZYn1h6U7liiT9820Ed4WSnf7Fp7vov01t/LN95lxWleQYk5rgq1LgO0hV04bR2IXK9jm0tsbWmFiCfZ9ZBYu5pODzLyOLiEd1j0vficClYLPQCTCX2H7WGV5NCLlrxh76JEGVhZDN3qFtjrw/bMpqHxJtHf0XZsHxq+oLL6BIjC9Fiup69e7JlU4tis8dTW1Ij4aKUHG4ow6f7vGWu+v3f2I99GWAD1HKSf0cu98mF+51tqsnoZbQJpmjVzSn0QVbmcCJynf9j3N+GcUb2PjJPPq4IESJjKTxc9UiMq3vfkJRSzCzlyNPxxdEvuAaVzxkrvvJWh+2d47hRTtDEmrn5sdghIFVebvrcVeP3WVEH2wR/hTI6kjocY1AojgP8oeVqNjzt48DQlyJuw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9c21b5-d529-45c2-0e9c-08dee1414647
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 00:46:00.2847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +rlpqnlbSbk4B1TFsjfG75KBGag/TpVRSuO4cVcVVRSpJVmf5sUutfdi+JcTWwtHIDAI1AYd7T9RkFyEEZRT1WOBc9oFdukMLOs/wJ3aEuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF3CEC6235B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0
 spamscore=0 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607140003
X-Authority-Analysis: v=2.4 cv=d5nFDxjE c=1 sm=1 tr=0 ts=6a5586cd b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=NFN8SqXP0gmw7mKU_zEA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13633
X-Proofpoint-GUID: NGesnuOxJws7OUKpjVMIuezSfYG-Ot1Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAwNCBTYWx0ZWRfX2UHjABq2w0xP
 Q3TlNMsyR1mLWnlqQ8wuRErsq0jXfon01gPI7PaZKd57fEnIbsXtAriObnYd0XFXJisUKsqwkT6
 bRBs4RAlmBiUds3ziMXvf8RK2rUDq1HKWnh3pxrFc2QJBD3w66GhcztodlHhZn+ASW3zWZ/pCwv
 imBLPTbMhtEO5vCnzO6/WX68f9xpgxuTR47G4duEiC0qEx4U53YokXD4ZdHOrJ5iagir+v84D6i
 GcqDK4c2QSJcFSNhtayP3sYq4LnoHaEBef6bPsAGHMu0o0dpP8GGUAuYILYikLw2XB2YIQ5X04m
 YlNq9nZSsRrEEXBrVe0Zn1P34v1poaxqunEhilQDu10C2dm77Q7mwdPpHNAuxfEoYwTGS/OEI+6
 8hT1fs25GLLgamSTLI2INnEzP6fXjrDHRve6KIriiXf9dvZ/VA5+zj3G4aty25eILXtqOFWRdwY
 XW7iqL9e7PokVGBcWbLn28h4dERIQdakta0gUNHE=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAwNCBTYWx0ZWRfX0PQ4Gz9u9adU
 6gtoC/Moul0C3wbMJbYHTlqudLZaqKUOrJn94na64g+znQw3ekLm7qeKJHE7BI7i5qp2j02PAPs
 SnkJvjU5CmfC4gPhRemuPhwXr+/mEvmnPXlkaWo3rtqxwh+v/icf
X-Proofpoint-ORIG-GUID: NGesnuOxJws7OUKpjVMIuezSfYG-Ot1Q
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_174606_314313_8939FCE1 
X-CRM114-Status: GOOD (  17.96  )
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

Extensions can mark pages to be excluded, but those pages may already be
excluded due to the dump level. We have a statistic to count pages
excluded by extensions. It counts only pages which were excluded because
no other criteria excluded them.

Extensions can mark pages to be retained, but there is no statistic to
count them. Adding a counter to the code as-is would not give us the
value that we care about. Just as above, pages marked for inclusion may
have been included anyway due to the dump-level configuration. The most
useful statistic is the one that tells us how many pages were included
by the extension, which would not have been included otherwise.

Introduce a statistic that counts this amount.  To do so, we have to
skip the short-circuit evaluation when PG_INCLUDE is returned. This
seems like a worthwhile trade-off, since the dump-level checks are all
reasonably efficient.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 makedumpfile.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index a4c9bbf..cf6a38f 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -106,6 +106,7 @@ mdf_pfn_t pfn_elf_excluded;
 mdf_pfn_t pfn_extension;
 
 mdf_pfn_t num_dumped;
+mdf_pfn_t num_extension_retained;
 
 int retcd = FAILED;	/* return code */
 
@@ -6638,8 +6639,6 @@ check_order:
 		 * makedumpfile extensions
 		 */
 		filter_pg = run_extension_callback(pfn, pcache, &i);
-		if (filter_pg == PG_INCLUDE)
-			continue;
 
 		/*
 		 * Exclude the free page managed by a buddy
@@ -6722,6 +6721,13 @@ check_order:
 		else
 			continue;
 
+		if (filter_pg == PG_INCLUDE) {
+			/* Account pages which would have been excluded, but were
+			 * retained by an extension. */
+			num_extension_retained += nr_pages;
+			continue;
+		}
+
 		/*
 		 * Execute exclusion
 		 */
@@ -8265,6 +8271,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 	if (info->flag_cyclic) {
 		pfn_zero = pfn_cache = pfn_cache_private = 0;
 		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = pfn_extension = 0;
+		num_extension_retained = 0;
 		pfn_memhole = info->max_mapnr;
 	}
 
@@ -9610,6 +9617,7 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 		 */
 		pfn_zero = pfn_cache = pfn_cache_private = 0;
 		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = pfn_extension = 0;
+		num_extension_retained = 0;
 		pfn_memhole = info->max_mapnr;
 
 		/*
@@ -10575,6 +10583,7 @@ print_report(void)
 	REPORT_MSG("    Hwpoison pages          : 0x%016llx\n", pfn_hwpoison);
 	REPORT_MSG("    Offline pages           : 0x%016llx\n", pfn_offline);
 	REPORT_MSG("    Extension filter pages  : 0x%016llx\n", pfn_extension);
+	REPORT_MSG("  Retained by extension     : 0x%016llx\n", num_extension_retained);
 	REPORT_MSG("  Remaining pages  : 0x%016llx\n",
 	    pfn_original - pfn_excluded);
 
-- 
2.47.3



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7224AFD88D3
	for <kexec@archiver.kernel.org>; Wed, 11 Mar 2026 00:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:References:In-Reply-To
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9LLKDccSqQyCsWTMoE1+q0hN8smpikJfvI8j4ow7Oc8=; b=HQPmj8hPRgskfPaTDjNsLFmpGA
	Tf2kJ0suHxCbn6g7z7DVNWTkFJpaCXqfR+bkTUNHtbsYMKFVIDm73geTW3J/63f+XdzV9FRsavsDU
	xZIWRWT7PWtijebI4YXV8V1S7rg5sk4pR82Qlto/Ki4GccNFZ2RXaqycSwDbyK8qBBc79erEWQw85
	8O2WEPceU3Oe4AB585yCGcuTTwsOjRMWJ5Vu9Ezm5nkKXIqfBTsHgIroggaVg5sw8x11dYbpesgUU
	0B6jcJVrJU0GtWD83rsBVYQYE2iBjarRfrpFjTJyOYde55h+wwFrxdzyRzF4ZCs039oIwrurXIRyx
	/juPRkcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w07b4-0000000ARuD-1HuF;
	Wed, 11 Mar 2026 00:38:46 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w07b1-0000000ARtV-1vAD
	for kexec@lists.infradead.org;
	Wed, 11 Mar 2026 00:38:45 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AFIDxr2485730;
	Wed, 11 Mar 2026 00:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9LLKDccSqQyCsWTMoE1+q0hN8smpikJfvI8j4ow7Oc8=; b=
	iFBMFuZHUbcGHnLk/3b9NJT3zs5uf0Mt+sD2/0dgnREzN5FEPInHqCLTsRVPgcXj
	7Z9Ni1FOHO1dC0mhJFrP/31e3Iqvr1496o4Bs29x2T+0tExGfrQ91W53rzwK9t2K
	+xKWGhVdnSXlvP++NwzEUm9Hzjvegy4ZqKAYsbmzGVZA9hLe6xsoJgRPvoIeJopo
	gbQDz72PYQo317fgrYfX7MSwWuF3FqraNBAgDLbiPYPfdKTdtLy7GTI0pX/p6BE/
	AjcG7vsDKfZ+/m7ynbAVT1HMJ/TsPCO2siCI0bzOxyDu/Ih0syldOjLJsyaR8R6c
	MrLg7v3ow6hniaTToNhl5g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cskyp40wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 00:38:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62B0Seqh040502;
	Wed, 11 Mar 2026 00:38:33 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4crafaw6tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 00:38:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8ozdqMt1K5tmD1chN+EfWCMZAFRWR7IjVRaTV1Vrei1PYJ/sYAtKRiqI8yNHELCVFMV525a8aSf0bkLzQRJ4T8UNRONogCOdbkXyNeCmpRE5hqSfSh0mMA5tDcuRvQDU2x8Fusb260Bm1gktUFP0p3ml9q23BHr06JXHSPmmflXctQ1MxpD2DmNV3kwScGSGcQYyE6EsQuUhVhedjdKxlWKPs523DtuOryvY2NXqqFkhLvFGHS1YvPBM6YcEnxR0oXMH5mM24Nl/50/GAma1Nb9p5DzBj7AN+Qb3uYpSke0vJesMFNGWSwkSYY0hHikWwSaf//NCYij910aGxKZ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LLKDccSqQyCsWTMoE1+q0hN8smpikJfvI8j4ow7Oc8=;
 b=CsPi4nQK0Zml4ekMPEPuW7qt9PRFHckJT5b5FWqj97uVaLVg8QhcFQErRc08afMYvt3Hww8jJOwHjwHj1mei+QJLzqe3zCi0OCv1vrNtn7XQLsUnSaypzekr14+n6RzOCSysEM+xV+b3nfOFoLhUzXoV7TCzvUYPEkuXvgQxQAM7SuwFV9N6XI8strfeWOORIugdzpzIRcXTMsvVnMeSk4gjHEFHwOyyLJI1ZF9ahW0Ok95YCoTbGVBBip682qRqlYRYEUjlrx7UDxV112k+d6emarwRf5PBHyyj+nQIyCrNWV/YgFuB9gPEamutM8v4WRlI1uaLenezwfB9xclUfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LLKDccSqQyCsWTMoE1+q0hN8smpikJfvI8j4ow7Oc8=;
 b=f/72M/koqzGPFXsoWB+SEW4OaURewXDOThKmSbnV6ob0h/dwM33+s8whwZb2qLIK2MHr3jGFZ2O8eSRhLh4s4T4MFoe9oWoDcB7xjWYwKZ9FNAIlQFvfLx+e1uDVef8kVZBPBN9AKRSKBRnZQfFgA05ip4mpdRU97Lurg7I8f2g=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by MW5PR10MB5692.namprd10.prod.outlook.com (2603:10b6:303:1a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Wed, 11 Mar
 2026 00:38:31 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.20.9678.024; Wed, 11 Mar 2026
 00:38:31 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Tao Liu <ltao@redhat.com>
Cc: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org,
        aravinda@linux.vnet.ibm.com
Subject: Re: [PATCH v3 5/8] Add makedumpfile extension support
In-Reply-To: <CAO7dBbW34=+DQMZ8NyPqPtm83nr2DYfa_z0Huf=NS8bzrh053w@mail.gmail.com>
References: <20260120025500.25095-1-ltao@redhat.com>
 <20260120025500.25095-6-ltao@redhat.com> <87ikcuv5ag.fsf@oracle.com>
 <CAO7dBbV-o4pTkaxaiZxfWHV7WDk=3fBc_XWVEs1XNWnvqJw46A@mail.gmail.com>
 <CAO7dBbW34=+DQMZ8NyPqPtm83nr2DYfa_z0Huf=NS8bzrh053w@mail.gmail.com>
Date: Tue, 10 Mar 2026 17:38:27 -0700
Message-ID: <87o6kvmc8s.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PH7PR17CA0009.namprd17.prod.outlook.com
 (2603:10b6:510:324::17) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|MW5PR10MB5692:EE_
X-MS-Office365-Filtering-Correlation-Id: 0460b485-f5ef-475d-b5ee-08de7f0684ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|7142099003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: nnlaqZKktpADC9UOmT6HDhSxVwPH+gRNbc/lW6TNMB5F+Z+r814nCbsgYjiRffbSTOKPleYGVpAdQ4LAlEG8k57lyXOKpqUK3fJRsivSHbmeXvOkjKQaWjYOIUD084BAg4FepsF+zxUfaxcUrI0PcrO8s71/Q5LbQVu+B4E6Ue9yB+mmT1Y6mgWxIjyXu359TohthTvWyMyyiO9SUf+RikJVGp7fY1OH5olE7u77M+LYPrjrb032SVm5aphY3vA+6dYRh2cgvfSb+ubLufDEpwmZQH82FGTlzUV8cJb1yuxHU1ypzLgjiqBh/SQtJUXLG9oMu79TvUXWpso62Ab9YLMQ3cIGVEtDhr65FK2SZ6oLkinvsO2ubZRbk0rm432uKMjzFYOTFMcNSSJsxrRzBv5PP7obx3lj4eq67kqgDFWORwDDhyx4ax7mk9Kd2cYnaAhh7XkOm9qGy8HFiHyVit4dGDQbpcnJE5b9LYlWH+1UVzgOrVo+PyYJ3ZhJWbgOvQg1YV7aThe6tD9UrAZwYyYVwCxP4mop+7VSsmEyxrzf/5CNmKCI3XLJQ83f4h0drjUxHzwViHHQ0mhILEt000rknCfizGIXvRDqicPUYkwBpK/lcy08QqO2tPo6Q0v/6RSmsE1cAWabtMfYhkTqjysjoU/tRdD3oshYvfeeQIktpo/tJ3zohLz6A580g5oWxF5h5TU6LrFV2vohfffhVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(7142099003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVRFaFg2UDlLcG1CbGhqS3dIRUFZajI2a2RHb01pcU1zTHBsWWVOS2ZMUHBt?=
 =?utf-8?B?RC9ndS9welhTbU9UZlg4WHdyVnZnMEJYZnkycTZjYmxQMUp1M1NwSTY2OEt3?=
 =?utf-8?B?d25DblF6T2tnMnBXdWl1S250ZnN4RFFKWVpBck51N2ZtZGRiSks1cXFWbDNX?=
 =?utf-8?B?bnkwa0ErbjZwa2dHU2hKcjJhOW1lRWwxUmRZSmhqKzRMY0xJWmNNdTF5U2Iw?=
 =?utf-8?B?Vk0yT1B4d0Q2djhsK3ErcWFRdThjZUpNb0NHN0dpVlFTclBXWVB0Y2JLWWVL?=
 =?utf-8?B?SytPRkZnRTlHVVl2ZEJWMkpwdTlmNTRRSnpHWFhrOW5sUG8ycWE5aHZpNDRH?=
 =?utf-8?B?SDlUZTJSZzlzcTdXdFZLUmxFM2JoMmFlSXBOcEx4RVFUWEZtYmk1Q2lFMU9Z?=
 =?utf-8?B?eU03UE91eGJ2d0hmbmhUQUg2WjNWTzVnekE4MFc0bzhKQUtzZWlaV1hodEtw?=
 =?utf-8?B?bEh2UXU2NlBXRWhWM0Nxak1qdmM4VlltYW9SQnhuVVJjVlM1QytIbUZFSnhS?=
 =?utf-8?B?RFY1ODhrQi9YTUdGZ1JVMVRiNm80MUZDN1Z6aVl2ZjVEQXlYa0pLeXpGdDFJ?=
 =?utf-8?B?dGIwNmFaWXRVdzFMY1pBRE9XbDRtdExlRFl3ZzVrUzY4ckxZQXI5bkRScGEy?=
 =?utf-8?B?SVc0bkxzSmJwVS81VDZpazFXWUFLdmRmVjBFSUtPM2Jpam00VHhCK1dJVVpF?=
 =?utf-8?B?Ymh0STJNVHNHUDhubmJSK2pWWHJycUR3Sm9FODE2dXVoZzBHbFR5QVE5VlBt?=
 =?utf-8?B?bjBNN0E4TngwOHR5enJyanNCNFRuMitmNlhTNzFvWG8rWHp3SnpPRFh1T3hZ?=
 =?utf-8?B?VVYraTFJeXRjanRFTkR5TDI3d0pZS3IwTk5JYVBxRkJLYmsvcjVxbXBQNGR5?=
 =?utf-8?B?bG5KRFQ0dHpFNW5UN3NQZmpUNVRVZ096Q2JleTNQNWFOV0lYeGRZTmtMWkFB?=
 =?utf-8?B?T3FzbmtmWFVGM1J2ZGc2N0htcDBCYUs3ODk0dW9JdW1hYS9nSElXTmN6MDVa?=
 =?utf-8?B?aGtTSTlVcS9WY2tPeHM0UG5jYVFVekJaNmdqeXJTaWpWZ3gvOXYvZ3huczZr?=
 =?utf-8?B?RHovSktsczlTS3VObUdaSkZOTXJnMUhTY08xb3h3aTRvRXp1aDU1N0ZFSnNy?=
 =?utf-8?B?RUZhc1BDUnd5NXZta09jeUI2QThTMUNPcXpTdldSWTJuU0U3RTF4R3orZit4?=
 =?utf-8?B?Q29wbEJ6eWJ2MkUyQnhCZXNBSGw4dWtDR0JQejl3K0lxMCtjYjEvRjRGVisy?=
 =?utf-8?B?UXd3Z0p4VUdkWTErZHRDTVorQjRjNnRJUUZPSzVFZHRidHdnRTVwcWo4VVdW?=
 =?utf-8?B?OE56aWw2Tnk1NHA0bDVwbTQ2S3lCZUJBZEQrRm1NeHlVb2UzTUJxL3IydUxv?=
 =?utf-8?B?dUw3OGZPYjRCdDF2YThaWFBRZ1VMeDY3dUNjZ0dqRXJqYk91MC82dmZJUm9w?=
 =?utf-8?B?Z3UrZGszK0xRYWpRSjJUNkFhMjR4NWNKVUZCOUxSQ1NPUTJ5RWx5TnIrb1Z3?=
 =?utf-8?B?YkFGSldGdnFiTDVoSUduUngrWXVtMVBoQUR6MUd2Y3RJY1pUZForUXJLL2ps?=
 =?utf-8?B?YVlQUmZEbURMU014QTd1REgveStGRmw4MzRhd1pzMVdOOFc2WjlQbDV0Wm04?=
 =?utf-8?B?NDBVTytiSTAvMFhBNk5PSkt4OG95SmFXT2hsNzAvU2lNSXJrN1NPMWRyZ1Z0?=
 =?utf-8?B?T0JDS3JzZ0dORzRtb3U1UzBmaTU5dFQyOHo0T0N1cFVnNm9sdFllbFhGRjlE?=
 =?utf-8?B?ZzQ5NENxU0ZZZ3BMRWNPVnlBd2c1UldHWHdralBMWnpuL3hsNTV0Z0VOdzY2?=
 =?utf-8?B?K2NyM0pCNVJ2c1U1Y25oSnkxU0VlZTJEeEFQLzFXay85cHBqSnlNSC9oQVov?=
 =?utf-8?B?cW5wbFRGSjY5cHFyZGtMYTFMQmI0c0FPc21lNkltbXNIeEVacmNTOHd0NUQ3?=
 =?utf-8?B?VUZwTHNNQlpIbTIrblhBUGVFSHFqeTdwM2FoanZxTFhhQngyNk84Q0xMd2lU?=
 =?utf-8?B?SDl4NS9xTkhZWDB3d3pjZHRMaGFuL3BlbU5VaExsY3krK3lJaE9SZi9aZUNr?=
 =?utf-8?B?aGYzbGE3cytON1NxZmRXM3NOa3FDck9pME5UdGpNQ1lvRGdRckVLSmhFQUtB?=
 =?utf-8?B?OE1vcXBCTVRDMFNXbnU2VXBXNTlzOUdJZkJUL3BYa2FYOExZV3hMUkNGM3ln?=
 =?utf-8?B?SVVSK3BtRkd6WDJYOXllNXZuajlsb2l0anplK2JVRy9uVy9ROWVxK1FaYkhz?=
 =?utf-8?B?VkQ0UFc2Z0RsL1dad1ppTnltSEZLdTRNNVVmYkZVUzJ2M2ZDd3dmUmNFZEp1?=
 =?utf-8?B?eEs1ZU5uQjRDc3UwNzAvNDkrdCtqOUpGRWNaeHlsZis5blQ4am9wbm1WMENS?=
 =?utf-8?Q?QvhxHarhkpdU3C7A=3D?=
X-Exchange-RoutingPolicyChecked: Utmcjki4LD+m0Pp5G7Y1njmyMyHSxbepKV1anNCpeKiRvGI+10Y44oemdwgEHQyKm3qUh8VUL7UjWsMJkDTZbJtcEzUyTRShufjcnxdA3MzrCtXQHMWTkQ+igOpvpwM6Iy81PKaXokTCFKvHN2H7vT5QRq1x0BPf32sDPEJA0xtGD+VZ7qHSX+xAl86dVZwPOCc+68BjLoQdTer823OWgThh5F3dvRUeexwqZI3Wfnr3jk1Vm/wivMFatxSM1eCHP3bANX9rPwa58UvfJbX1cwkApdflCSgyJ80oboJxd61l5NxwxKb09sUSgCeXoq7NX6tzfEleTxdds1zfKGbW2Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tHyacFOdJtct+sXwqJV3uWOIR0WUvBvr2bZeo73ouKcieEvWiwBRwUBTqc+NrJA0m8hkQ3U5LRzoC1HGJBuPGOjYjzvjrRKiGgJ6xzaThqVhS5a1UhEcWUwTRXdIvjC2HD55/r8m1MyveXeFIxpd+C8SBc9c9szUzc1PNn6dSBkulQBbLAymkZxlIoo8nUF3lvX+zAUXcIY9NVqm7t3RRAeVHuQht9JyK/NF2w0phlMed9z2CKnli08rO81srMnym35d6y0zlVNvPaFAyvrf6GiHY04li1DDKiPgrwM7NO1vBnoEpF89uXK8lc9iqnTqOgBiS0uqBO2owquKrd+HdU6V+iFrpjEWf2n/Ri7dCNol3UdqemvaqMUdzRFyirw22rw+EJxurTfKm35xiPb2VEWnvX6C7PJ0M0lHUpIv2wjI+9qb+qCNCP9EcX3W7w1F1y7NNrMHFr8BU2qiDsySUMcVdwaM6TmyOcwAr/HBWVHQ3NYVLCdlmd+jcsatmcH307VCMLZAEAUBGwA3puDXNPT9rQpUzo4w2LLmH4TjtPs+r9itRu81ddPeHQfmmH21Wki0vdQg2PEU3udmFkqEc1cOdg1Nq5oOv0+7gjhzmpA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0460b485-f5ef-475d-b5ee-08de7f0684ca
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 00:38:31.0114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfs3MIX2MZn/pV/5a+oU9lnXtOZ4IcimaHhJT2Y3dHXmMd0ufh0UoAlCApZSjgXpd37MWmbA0CwwD8G6D+YHbDUcl6IQGMzJ+AZau8DSvaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5692
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603110003
X-Proofpoint-GUID: _Dt1rEG_NgssiUDqzdresw8udaNlWkC0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAwMyBTYWx0ZWRfXyFeHr0LGSUd9
 KHsZiK6NgvaKXrzg31o4s6zLH8Oay+Z2VlpFduIiLxREbjfckF8S6scV0QCgc/It+7H+ZhIc/4H
 8NmHq4ph9HmJ2pegJEPz59dluqjpZzD3eFp3kWRxIe8ozRagoJns3Jma/8Ri8NYdslm39DMujZZ
 JxvPu+2NcS0NbgRRcyiZJ5pXrW+oV5owLhr44XnM/ae+TfuHNpmOuN2TIVk1vIfcRmQYObGTs88
 yPUoqbFnZ5IpcmjYB8OJwT7xc6yxpfMXB0h1MTipIGcpDP6Tzr0UyvyfSAGUuG9D5G41ONkPxsd
 DmKtDvf7mZptyNPDB+CfY9ydJepQBf0qW0HCQ/P74tOHvBxLK+BXqP3L5iaODI9JrkDxd2kbZ0/
 1SoGl3IOWYlaGMWyBiFllakKpGdEbhRQ0LM+QdpuZ89eMoYzW0TQx49ZHmGAzvKj1pNk8xe9M2K
 J6XIDy7qL5p1OJPZp3w==
X-Proofpoint-ORIG-GUID: _Dt1rEG_NgssiUDqzdresw8udaNlWkC0
X-Authority-Analysis: v=2.4 cv=XP89iAhE c=1 sm=1 tr=0 ts=69b0b98a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=NEAV23lmAAAA:8
 a=17FYL03jAAAA:20 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=bckxnTId1t9gAltwQQoA:9
 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260310_173843_775051_95D576AF 
X-CRM114-Status: GOOD (  25.36  )
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

Tao Liu <ltao@redhat.com> writes:
> Hi Stephen,
>
> Sorry I took some time to make modifications on v3 code. Please see a
> drafted v4 [1] for a preview.
>
> I followed your suggestion to let extensions declare the kallsyms
> symbol/btf types it needed, then during kallsyms/btf initialization,
> it will only resolve the declared symbol/types, thus getting rid of
> the hash table. Extensions now don't need to initial needed
> symbols/types by itself.
>
> In addition, users can specify which extensions to load at
> makedumpfile cmdline as:
>
> $ ./makedumpfile -d 31 -l
> /var/crash/127.0.0.1-2025-06-10-18\:03\:12/vmcore /tmp/out --extension
> amdgpu_filter.so
>
> Also "--extension" can be used several times, and amdgpu_filter.so can
> be an absolute path as well. If no extensions are specified, the
> btf/kallsyms of makedumpfile will not initialize.
>
> I don't know if this is what you wanted, or any suggestions for this?
> Thanks in advance!

Hi Tao,

Please accept my apologies for the long delay on this review.  I've gone th=
rough
each commit with my feedback. This looks like a really excellent job and I
think it is ready for the review of the maintainers. I've implemented my ow=
n
userspace stack extension on top of this support, and I find it to be great=
 for
my use case as well, with one small change (adding flags for detecting whet=
her a
struct or member is found).

Here is some more detailed feedback on a per-commit level; it's all pretty
minor.

d3aee7a ("Reserve sections for makedumpfile and extenions")

* This is just a note, but I've found that the linker script may not be
  necessary. GCC automatically creates the __start_SECTION and __stop_SECTI=
ON
  symbols for sections it creates.
* Otherwise, this is exactly what I was thinking!

102ae0b ("Implement kernel kallsyms resolving")

* Again, this is looking very close to the design I hoped for, thanks!
* I'm not sure whether is_unwanted_symbol() needs to exist anymore?  Given =
that
  users opt-in to specific symbols, we don't need to filter out noisy ones =
that
  would waste memory. What do you think?
* Unfortunately, upstream has made some changes to the vmlinux kallsyms enc=
oding
  in 7.0. You may want to check what we did in drgn to support those change=
s:
  https://github.com/osandov/drgn/commit/744f36ec3c3f64d7e1323a003789815869=
8585c4
* In kallsyms.c:

  +/*
  + * Makedumpfile's .init_ksyms section
  +*/
  +extern struct ksym_info __start_init_ksyms[];
  +extern struct ksym_info __stop_init_ksyms[];

  I'm not sure it matters, but the type here is wrong. It should be
  "extern struct ksym_info *" because you're storing pointers, not the actu=
al
  struct. That said, the type isn't used so I don't know that it matters.

4187b33 ("Implement kernel btf resolving")

* The get_ktype_info() function fails if either the struct or member is not
  found. This makes sense in a lot of cases, but there are other cases wher=
e we
  will want to use the presence or absence of a struct/struct member to det=
ect
  which version of code to use. For example, my userspace stack code will u=
se
  either maple or rbtree helper code for finding stack VMAs, depending on w=
hich
  is available. We can't know until runtime, when we check whether mm_rb or
  mm_mt is present.

  One solution is to handle this at runtime. We can have a macro like
  "HAVE_MEMBER(S, M)" and "HAVE_STRUCT(S)", and then each extension can che=
ck
  whether for the members it expects to be present. I think the major downs=
ide
  to this approach is that it requires manual effort, which is likely to be
  forgotten when writing extensions.

  Alternatively, we could set a flag in the struct ktype_info if the type i=
s
  "required" (or optional), and only fail get_ktype_info() for required
  structs/members. The concern with this approach is: what if plugin (A)
  requires a type which is not present, but plugin (B) does not? If both ar=
e
  loaded, the failure of A would cause B not to run. I'm not sure whether w=
e
  should care about that situation... I don't know if we have a use case fo=
r
  using multiple plugins at the same time. Until we do, we probably won't h=
ave a
  good idea whether it should be allowed for one to fail, but the other to
  continue.

  I've implemented this second alternative in my branch.

* Similar to the previous commit, __start_init_ktypes and __stop_init_ktype=
s are
  declared as structs but should probably be declared as pointers.

22097b7 ("Implement kernel module's kallsyms resolving")
edfa698 ("Implement kernel module's btf resolving")

* These commits are straightforward:
  Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>

ede22e8 ("Add makedumpfile extensions support")

* nit: the array "handlers" actually contains "handles" (no r) returned fro=
m
  dlopen(). The word handlers usually implies a function pointer or somethi=
ng
  like that, called to handle a certain situation. Maybe rename this to
  "handles".
* The run_extensions() function is called within a retry loop in
  create_dumpfile(). It seems possible that this could get called multiple
  times. But many of the global variables in the kallsyms, BTF, and extensi=
on
  code are not safe to be cleaned up and reinitialized. In particular, when
  array elements are freed, the lengths, capacities, and pointers are not r=
eset
  to 0/NULL. I think it would be wise to make all the cleanup functions cle=
ar
  the globals, so that they may be reinitialized safely.
* Further, I think it might be helpful to split extension loading, running,=
 and
  cleanup. Something like this in create_dumpfile():

        load_extensions(); /* loads everything and calls entry() */
    retry:
        /* ... create bitmap and dump ... */
        if (status =3D=3D NOSPACE) {
            /* ... */
            goto retry;
        }
        /* ... */
        cleanup_extensions();
        return;

  For two reasons: (1) this avoids unnecessary work re-loading and
  re-initializing the BTF, kallsyms, and extensions. (Though I still think =
it's
  safer to ensure they can be re-initialized safely.) And (2), this allows =
for
  future use of extensions in the rest of the dump operation. For my usersp=
ace
  stack extension, I plan to add a callback which allows extensions to over=
ride
  the decision to filter a page, since my logic can't be easily done via er=
ase
  info. So the extensions need to remain loaded during the creation of the
  dumpfile, and cleaned up after. I have tweaked this in my own patches,
  but I just wanted to share the use case.

c568635 ("btf/kallsyms based makedumpfile extension for mm page filtering")

* This looks good to me!
* I will say that for my userspace stack use case, while the "filter_page(.=
..,
  false)" mechanism for specifying pages that are retained *looks* useful, =
I
  wouldn't be able to use it because I cannot determine the PFNs for each s=
tack
  VMA. Instead, I have to use the page "mapping" and "index" fields to matc=
h the
  VMA and determine whether the PFN falls in a range I care to save. Of cou=
rse,
  just because *I* won't use it doesn't mean it's not useful :)

2b252ec ("Filter amdgpu mm pages")

* I'm no expert in amdgpu, but the overall approach makes sense to me, and =
the
  helpers look good.


At a broader level, while the add_to_arr() function is useful, I do think t=
he
dynamic array/vector pattern could be captured with a dedicated data struct=
ure.
For instance, drgn has this excellent LGPL-2.1+ header-only vector library:
https://github.com/osandov/drgn/blob/main/libdrgn/vector.h
I don't think it is high priority or must be addressed. Nor do I mean that =
this
particular implementation choice be used. It's just something to share & th=
ink
about.

To provide some context on my comments related to the userspace stack traci=
ng,
here is a branch of mine which is based on yours, that adds my userspace st=
ack
extension and a few tweaks:

https://github.com/brenns10/makedumpfile/commits/stepbren_userstack_v4/

Thank you,
Stephen

> Thanks,
> Tao Liu
>
>
>
>
>
>
>
> [1]: https://github.com/liutgnu/makedumpfile/commits/v4/
>
> On Fri, Jan 23, 2026 at 2:43=E2=80=AFAM Tao Liu <ltao@redhat.com> wrote:
>>
>> Hi Stephen,
>>
>> Thanks a lot for your quick reply and detailed information, I really
>> appreciate it!
>>
>> On Thu, Jan 22, 2026 at 1:51=E2=80=AFPM Stephen Brennan
>> <stephen.s.brennan@oracle.com> wrote:
>> >
>> > Hi Tao,
>> >
>> > This series looks really great -- I'm excited to see the switch to
>> > native .so extensions instead of epicc. I've applied the series locall=
y
>> > and I'll rebuild my userspace stack inclusion feature based on it, to
>> > try it out myself.
>>
>> Awesome, looking forward to your feedback on the code/API designs etc...
>>
>> >
>> > In the meantime, I'll share some of my feedback on the patches (though
>> > I'm not a makedumpfile developer). This seems like the most important
>> > patch in terms of design, so I'll start here.
>> >
>> > Tao Liu <ltao@redhat.com> writes:
>> > > This patch will add .so extension support to makedumpfile, similar t=
o crash
>> > > extension to crash utility. Currently only "/usr/lib64/makedumpfile/=
extensions"
>> > > and "./extensions" are searched for extensions. Once found, kallsyms=
 and btf
>> > > will be initialized so all extensions can benifit from it (Currently=
 makedumpfile
>> > > doesn't use these info, we can move the kallsyms/btf init code else =
where later
>> > > if makedumpfile needs them).
>> > >
>> > > The makedumpfile extension is to help users to customize mm page fil=
tering upon
>> > > traditional mm page flag filtering, without make code modification o=
n makedumpfile
>> > > itself.
>> > >
>> > > Signed-off-by: Tao Liu <ltao@redhat.com>
>> > > ---
>> > >  Makefile            |  7 +++-
>> > >  extension.c         | 82 ++++++++++++++++++++++++++++++++++++++++++=
+++
>> > >  extensions/Makefile | 10 ++++++
>> > >  makedumpfile.c      |  4 +++
>> > >  4 files changed, 102 insertions(+), 1 deletion(-)
>> > >  create mode 100644 extension.c
>> > >  create mode 100644 extensions/Makefile
>> > >
>> > > diff --git a/Makefile b/Makefile
>> > > index f3f4da8..7e29220 100644
>> > > --- a/Makefile
>> > > +++ b/Makefile
>> > > @@ -45,7 +45,7 @@ CFLAGS_ARCH +=3D -m32
>> > >  endif
>> > >
>> > >  SRC_BASE =3D makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mo=
d.h sadump_info.h
>> > > -SRC_PART =3D print_info.c dwarf_info.c elf_info.c erase_info.c sadu=
mp_info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c btf_info.c
>> > > +SRC_PART =3D print_info.c dwarf_info.c elf_info.c erase_info.c sadu=
mp_info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c btf_info.c ext=
ension.c
>> > >  OBJ_PART=3D$(patsubst %.c,%.o,$(SRC_PART))
>> > >  SRC_ARCH =3D arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/=
ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64.c ar=
ch/loongarch64.c arch/riscv64.c
>> > >  OBJ_ARCH=3D$(patsubst %.c,%.o,$(SRC_ARCH))
>> > > @@ -126,6 +126,7 @@ eppic_makedumpfile.so: extension_eppic.c
>> > >
>> > >  clean:
>> > >       rm -f $(OBJ) $(OBJ_PART) $(OBJ_ARCH) makedumpfile makedumpfile=
.8 makedumpfile.conf.5
>> > > +     $(MAKE) -C extensions clean
>> > >
>> > >  install:
>> > >       install -m 755 -d ${DESTDIR}/${SBINDIR} ${DESTDIR}/usr/share/m=
an/man5 ${DESTDIR}/usr/share/man/man8
>> > > @@ -135,3 +136,7 @@ install:
>> > >       mkdir -p ${DESTDIR}/usr/share/makedumpfile/eppic_scripts
>> > >       install -m 644 -D $(VPATH)makedumpfile.conf ${DESTDIR}/usr/sha=
re/makedumpfile/makedumpfile.conf.sample
>> > >       install -m 644 -t ${DESTDIR}/usr/share/makedumpfile/eppic_scri=
pts/ $(VPATH)eppic_scripts/*
>> > > +
>> > > +.PHONY: extensions
>> > > +extensions:
>> > > +     $(MAKE) -C extensions CC=3D$(CC)
>> > > \ No newline at end of file
>> > > diff --git a/extension.c b/extension.c
>> > > new file mode 100644
>> > > index 0000000..6ee7f4e
>> > > --- /dev/null
>> > > +++ b/extension.c
>> > > @@ -0,0 +1,82 @@
>> > > +#include <stdio.h>
>> > > +#include <stdlib.h>
>> > > +#include <string.h>
>> > > +#include <dirent.h>
>> > > +#include <dlfcn.h>
>> > > +#include <stdbool.h>
>> > > +#include "kallsyms.h"
>> > > +#include "btf_info.h"
>> > > +
>> > > +static const char *dirs[] =3D {
>> > > +     "/usr/lib64/makedumpfile/extensions",
>> > > +     "./extensions",
>> > > +};
>> > > +
>> > > +/* Will only init once */
>> > > +static bool init_kallsyms_btf(void)
>> > > +{
>> > > +     static bool ret =3D false;
>> > > +     static bool has_inited =3D false;
>> > > +
>> > > +     if (has_inited)
>> > > +             goto out;
>> > > +     if (!init_kernel_kallsyms())
>> > > +             goto out;
>> > > +     if (!init_kernel_btf())
>> > > +             goto out;
>> > > +     if (!init_module_kallsyms())
>> > > +             goto out;
>> > > +     if (!init_module_btf())
>> > > +             goto out;
>> > > +     ret =3D true;
>> >
>> > I feel it would be good practice to load as little information as is
>> > necessary for the task. If "amdgpu" module is required, then load kern=
el
>> > kallsyms, BTF, and then the amdgpu module kallsyms & BTF. If no module
>> > debuginfo is required, then just the kernel would suffice.
>> >
>> > This would reduce memory usage and runtime, though I don't know if it
>> > would show up in profiling. The main benefit could be reliability: by
>> > handling less data, there are fewer chances to hit an error.
>>
>> OK, I agree, mandatory kernel btf/kallsyms info + optional kernel
>> module btf/kallsyms info is a reasonable design. So kernel modules'
>> info can be loaded on demand.
>>
>> >
>> > > +out:
>> > > +     has_inited =3D true;
>> > > +     return ret;
>> > > +}
>> > > +
>> > > +static void cleanup_kallsyms_btf(void)
>> > > +{
>> > > +     cleanup_kallsyms();
>> > > +     cleanup_btf();
>> > > +}
>> > > +
>> > > +void run_extensions(void)
>> > > +{
>> > > +     DIR *dir;
>> > > +     struct dirent *entry;
>> > > +     size_t len;
>> > > +     int i;
>> > > +     void *handle;
>> > > +     char path[512];
>> > > +
>> > > +     for (i =3D 0; i < sizeof(dirs) / sizeof(char *); i++) {
>> > > +             if ((dir =3D opendir(dirs[i])) !=3D NULL)
>> > > +                     break;
>> > > +     }
>> > > +
>> > > +     if (!dir || i >=3D sizeof(dirs) / sizeof(char *))
>> > > +             /* No extensions found */
>> > > +             return;
>> >
>> > It could be confusing that makedumpfile would behave differently with
>> > the same command-line arguments depending on the presence or absence o=
f
>> > these extensions on the filesystem.
>> >
>> > I think it may fit users' expectations better if they are required to
>> > specify extensions on the command line. Then we could load them by
>> > searching each directory in order. This allows:
>> >
>> > (a) more expected behavior
>> > (b) multiple extensions can exist without all being enabled, thus more
>> >     flexibility
>> > (c) extensions can be present in the local "extensions/" directory, or
>> >     in the system directory
>>
>> Sure, it also sounds reasonable. My original thoughts are, user
>> customization on mm filtering are specified in .so, and if user don't
>> need one .so, e.g. amdgpu mm filtering for a nvidia machine, then he
>> doesn't pack the amdgpu_filter.so into kdump's initramfs. I agree
>> adding extra makedumpfile cmdline option to receive those needed .so
>> is a better design.
>>
>> >
>> > > +     while ((entry =3D readdir(dir)) !=3D NULL) {
>> > > +             len =3D strlen(entry->d_name);
>> > > +             if (len > 3 && strcmp(entry->d_name + len - 3, ".so") =
=3D=3D 0) {
>> > > +                     /* Will only init when .so exist */
>> > > +                     if (!init_kallsyms_btf())
>> > > +                             goto out;
>> > > +
>> > > +                     snprintf(path, sizeof(path), "%s/%s", dirs[i],=
 entry->d_name);
>> > > +                     handle =3D dlopen(path, RTLD_NOW);
>> > > +                     if (!handle) {
>> > > +                             fprintf(stderr, "%s: Failed to load %s=
: %s\n",
>> > > +                                     __func__, path, dlerror());
>> > > +                             continue;
>> > > +                     }
>> > > +                     printf("Loaded extension: %s\n", path);
>> > > +                     dlclose(handle);
>> >
>> > Using the constructor/destructor of the shared object is clever! But w=
e
>> > lose some flexibility: by the time the dlopen() returns, the construct=
or
>> > has executed and the plugin has thus executed.
>> >
>> > What if we instead use dlsym() to load some symbols from the DSO? In
>> > particular, I think it would be useful if extensions could declare a
>> > list of symbols and a list of structure information which they are
>> > interested in receiving. We could use these lists to know which
>> > kernel/module kallsyms & BTF we should load. We could even load the
>> > information into the local variables of the extension, so the extensio=
n
>> > would not need to manually load it.
>> >
>> > Of course this is more complex, but the benefit is:
>> >
>> > 1. Extensions can be written more simply, and would not need to manual=
ly
>> > load each symbol & type.
>> > 2. We could eliminate the hash tables for kallsyms & BTF, and eliminat=
e
>> > the loading of unnecessary module information. Instead, we'd just
>> > populate the symbol addresses, struct offsets, and type sizes directly
>> > into the local variables which request them.
>>
>> It is a clever idea! Though complex for code, I think it is doable.
>>
>> >
>> > Again, while I don't want to prematurely optimize -- it's good to avoi=
d
>> > loading unnecessary information. I hope I've described my idea well. I
>> > would be happy to work on an implementation of it based on your patche=
s
>> > here, if you're interested.
>>
>> Thanks again for your suggestions! I got your points and I think I can
>> improve the code while waiting for maintainers ideas at the same time.
>> I will let you know when done or encounter blockers if any.
>>
>> Thanks,
>> Tao Liu
>>
>> >
>> > Thanks,
>> > Stephen
>> >
>> > > +             }
>> > > +     }
>> > > +out:
>> > > +     closedir(dir);
>> > > +     cleanup_kallsyms_btf();
>> > > +}
>> > > \ No newline at end of file
>> > > diff --git a/extensions/Makefile b/extensions/Makefile
>> > > new file mode 100644
>> > > index 0000000..afbc61e
>> > > --- /dev/null
>> > > +++ b/extensions/Makefile
>> > > @@ -0,0 +1,10 @@
>> > > +CC ?=3D gcc
>> > > +CONTRIB_SO :=3D
>> > > +
>> > > +all: $(CONTRIB_SO)
>> > > +
>> > > +$(CONTRIB_SO): %.so: %.c
>> > > +     $(CC) -O2 -g -fPIC -shared -o $@ $^
>> > > +
>> > > +clean:
>> > > +     rm -f $(CONTRIB_SO)
>> > > diff --git a/makedumpfile.c b/makedumpfile.c
>> > > index dba3628..ca8ed8a 100644
>> > > --- a/makedumpfile.c
>> > > +++ b/makedumpfile.c
>> > > @@ -10847,6 +10847,8 @@ update_dump_level(void)
>> > >       }
>> > >  }
>> > >
>> > > +void run_extensions(void);
>> > > +
>> > >  int
>> > >  create_dumpfile(void)
>> > >  {
>> > > @@ -10884,6 +10886,8 @@ retry:
>> > >       if (info->flag_refiltering)
>> > >               update_dump_level();
>> > >
>> > > +     run_extensions();
>> > > +
>> > >       if ((info->name_filterconfig || info->name_eppic_config)
>> > >                       && !gather_filter_info())
>> > >               return FALSE;
>> > > --
>> > > 2.47.0
>> >


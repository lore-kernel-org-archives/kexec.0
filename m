Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBB7C55182
	for <kexec@archiver.kernel.org>; Mon,  3 Aug 2026 16:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jCugCLcf/pbk/KQnecLdtukPMM/sn/fYAcMx6pZzOOc=; b=dZjRx0+HzBP4ryzDlLMisDjian
	OPBSVyW1RxGIUFTecB1PZlO1WlPymY07VeTiOzibQSHT+y7M4KyKy82D90bD+0icFGSjrkl/PIzJO
	Vp1pMx6LU514e0Uw5Hq5m7861LLUJl8e6RoA4xcaFX2OMbHmTZ8pO2EUOxqkVmeLoG8pQdVVILLe7
	o2VnebxWTKm/hbfC5Clet0+30kxo0BN4npFU3Zw6Nagp+LcFZyXLpp7LrqZyxzzZfh90oNgICe+6c
	eOV0u72Rr5S4cQdn1cK6DUb1sqMCIhILaYwOM7okcKMclzMQCLVXKHsjO8Opt/rAZ9TbazYWMUi/A
	ysWQEdsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqvIc-000000003N3-1Usi;
	Mon, 03 Aug 2026 16:13:58 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqvIY-000000003Kv-3BLy
	for kexec@lists.infradead.org;
	Mon, 03 Aug 2026 16:13:56 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673C7VCb3789243;
	Mon, 3 Aug 2026 16:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=jCugCLcf/pbk/KQnec
	LdtukPMM/sn/fYAcMx6pZzOOc=; b=pARpOI7BnG5tatMYAwAZFbGjmxtJ6w4VRw
	DDm+kqiMeEAqwc7j0JLMYoEDs2PG8nzg9iSOR3osVFUHByQW4LjE4l4rUyB3Txc/
	ohF8Yc0jMdJQMIRD36CdDMDHmBlB9EWlKwHwzUqTKkIQcGp1303z8dXR4M3iNezG
	konp3FbzvpRm/QHs4oBCO+CFD3jv8ah3KPokQW9gkjvJ583JjZBly08/uhaq52Gj
	p/hqwfcE6AL0E5GMF1qWk8uXFymE+F+pbrHPHH3LwXSsv+nItTBYeOPZDE3duDhH
	6nxnhZ+IQIKPRUrpES3VsXXjDGOL0pYJcB0lKS7PwFnjiURgRM+g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs8ugc2k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Aug 2026 16:13:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 673G5eTh028260;
	Mon, 3 Aug 2026 16:13:51 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012036.outbound.protection.outlook.com [40.93.195.36])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78s3dyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 03 Aug 2026 16:13:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BiwJY+hYZdEIIS0j9jMaerfo0ZsRoJKYgEKUP8xjy3bKrGo4ZCIPTC9RDtscRFCACz8p9Q8RRAa/y9JhpOsEfkib2lUkFE2kU3p5ThgAUB6Rg0FYmArIgoOj+Ze3UNm8hUnhE/ZSu4vK1pubdpslh+YRoF1eccC5djj5Al9fUWR2CbokjdJw7ugOabwFldDTMHU21gMVRfxIU4SZ9ObUMhdEgkXI+o1tJunUBVXjZDnKAl4pM4lS7NcxQbyBG5gRjMH+zfaMB7EjQU5aL9lDNl19cTncANhvU2n5IYcumJz967Lk6fdRnwevoAtpRyTYwnLsZFLHc7EfI7BSt0j9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCugCLcf/pbk/KQnecLdtukPMM/sn/fYAcMx6pZzOOc=;
 b=ZiLoyciUV7xY8a0a1kMbJP+1xPdmAWUtwXzvK9TMqosRrU74RI/oETGSFjdJk3uiVW0/WJRvtRmQb3T9WjvhfyJY7inM57f3havwATNDD5y1w/Nb/6GBa/vxHC3qtXY+55PExGtBeuoPsMsbkpI+M1uFh4EruXejqcdE2izc5av13dHX5Hy1uOM4xO+CkwUc7xifhNNxIdIgWkpxap0gl5o6yaiuh85pJzpoTCBT9NdWcGdB9x4xfqlNVCyzF7hJ3se4Ziw83bX59xn2FC4ZQBiKnuoO1dbYnVxAtureoMNVZa0HhslfWkGREaxBkY+rUUhOUeq2FiymmlLeSFletg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCugCLcf/pbk/KQnecLdtukPMM/sn/fYAcMx6pZzOOc=;
 b=Yh2ePdMUe/LcQT7wVqp4ZOGxdSmgse2V+HdA207DPfFnbv6rF3tLCDtjXUxk8pXilxinWNhuzWnTikR4fHLPq5k432op8GFE4WT3nr2b17Y0XrqL6Zf7uom12GbSO81bhwWz9nzPcb2mAg29HBcznYukm4FuOOnIKE8JbvKSwCw=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by MN2PR10MB4189.namprd10.prod.outlook.com (2603:10b6:208:1de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 16:13:48 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 16:13:48 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org
Cc: ltao@redhat.com
Subject: Re: [PATCH makedumpfile 0/9] Improvements to makedumpfile
 extensions, plus userspace stack tracing extension
In-Reply-To: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
References: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
Date: Mon, 03 Aug 2026 08:55:45 -0700
Message-ID: <8733wv42ri.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::11) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|MN2PR10MB4189:EE_
X-MS-Office365-Filtering-Correlation-Id: f218d718-f2e3-4570-ccce-08def17a3369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 54xMT3UM9Mm8RJedsXvaSAklG82099FZ8o0znAG9tUyaxGo/Evg3BM+/cVkI8gvKJwR/Vu0n6fpzr6mFLk/Agf29Y01xK8r1RABq0UI0K9QnL/cgvj/Au0JSvJytRDzCT1l9kDErr3hZLFIVfOReWly7SoAUfsYrC33+TF6W9o7ue3FuVchpVt9c2aCGNg0xP4wFJMsbvZZqwwMdB+x5/U1Wxf4tIZivT1mzzYCjz6wVSPTFzjQRwyvjZGXWmjPy9/oueHp6nxcs4qA78cRBchp+pZw0QvIBsqDCIQIfgdh8qRn5bl9XGcCLRLl+HtM/EHur3KwtjXPxsoK6JJp78VwS6tQxIc91sfPxuxB2syckVQjd25DR/nPQjvC6K1JXKK9+xhVUkzSzKrABES2WqZdRgQ1Us/oLMWjV+k7E78E0HA/7JBXWmXE+518+e9O5wrXrYh71zZfFHKl07VbGVIjEDn+L3FgXJSMhtxpZlxkksmmf1DCted0HYzQcJqNa3gkIJ7B97vUd58IAO+vpdGpDfklr3r09bpnFiDzRYlm3IY+ObCA2shafZ2DLH+vlVvxxQ8ZeNJICLi4TIyxui7k/hvuR4HcuECjvzzLbweZzT+LKXOe5uSyDG3HbGkGY8D91iMu6Hy9vhP5v50fi98dSw+XHzUfOITtxl7+6SC0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jo5miGlXlunUfjAJCwQvAaxC+MTo4hnBoRZEgtdBzXDrHFPJWZUcRyiztHOZ?=
 =?us-ascii?Q?0mxuLtb6FfPiAJGWk6n3rmtTxKi2cGgD+5wKp40GRZaYylXLZILEq1LfgH9H?=
 =?us-ascii?Q?OPyNI4NNfplZFX+/Kl8nPLDusEvYLw2ZxPNs8DaQ8/OeKmdO/eT2tL0FXOkl?=
 =?us-ascii?Q?9jdW2694JX7WQYio7QlaGZSUlMhpIp2aZidZktuwnCKfFHlj/6GF8oAdsUuR?=
 =?us-ascii?Q?ZHyINVvVH+uqJtMsgRBb8nnlg7GlN4kYQ1F3O6v0qPOoXmM4lAF6chuTv/S/?=
 =?us-ascii?Q?XCmlvmhtTOFcWsgjc6UbZXVyC/LIxU4SQW/EG2MkLo3HlSiE+Nwqc7CkzxNu?=
 =?us-ascii?Q?cmZtRCIMDT33zzez2nre5kEIXt8nCb8aHi/kJcDYU+UMPduHa2qogj3PRjMz?=
 =?us-ascii?Q?PH5dnPUTKroF6CYVEsRdjRvYOLpIloOFpACV6yAYHLc+01FlZP86laKFNDzo?=
 =?us-ascii?Q?WQHcnWp0LzUxzf4ZWtRQnsDBAKK/QnIyWmCjSJVX4BSg6KvUCJZrTOSQCQZM?=
 =?us-ascii?Q?BpSSut7gilVXYECAclP/bKqwMbCxr5mNdf3D4m2NOIfvd5OKSylhXQnsVvbb?=
 =?us-ascii?Q?/EPP2eqnz9TZEM/E3FhnIRMusof+2dy2FRJ6vG3upYoA9RrG5prtIpFDCJFw?=
 =?us-ascii?Q?BvV3CRQI8nQ0Mhu+MFuntBiKeDuO803jsL6LFmDnhOQxJOJmcIB2AcciTzPX?=
 =?us-ascii?Q?wYVWA2WP5TVenMvHpEyFgaMFXSV6SX8JdT+sg9HnvXYOg9K+uqJCyE/zdZY7?=
 =?us-ascii?Q?DMRF0i7rwFo9OqOe7No+fzJhJy4wF0yRQIsJ5ur9P7hVi0a3gDCdpDpAx3gq?=
 =?us-ascii?Q?yREuAfyRd6H5Mh0Aot0QfAIt79/84K+j+I+BJ3E2DbWYZWCPS9z+lqNV4A7B?=
 =?us-ascii?Q?S+vN0ViaPAe4ujwGKkYWgoFe3iBMBpxbX7yBC5zgURJbRRaj4xJr06mJbDXz?=
 =?us-ascii?Q?AGKsEVIm7iqUohYkhQR52R8oMzoiYEFbZk1ALN3xubtcp+Ahk8HOduTsdPwA?=
 =?us-ascii?Q?WOOLBh9GUey4ZKg9LIxQ46C83iCNxamgTEk+7d2ShDRi/ipJVFxHaMagqvnR?=
 =?us-ascii?Q?mzv6Q5trfT6Th98vte4zcrB95L8JOahkuMsujFfGQveY/ON+1sboi/wwvuNM?=
 =?us-ascii?Q?L1FTQdshRrT1lqkgBrkHsX6nclJBvZO6UpRXC7rbp3ei9JGyTrPBkzsI2rPo?=
 =?us-ascii?Q?vTTC5QbEct38NVTI0CS++5GRbKB0qcSCAGXmXY5gaRGLGZzwSknqdBKkOUlM?=
 =?us-ascii?Q?cL6UmSo9m7BsyATufTatGHsj/LTSFeDodgxHUVpBM62uVTLji8UyjhXFoqcu?=
 =?us-ascii?Q?2995AEHDIiYIcFqFB8Ws2B9U3pdd5uehxgG/lZr9AljhOBgSrFzcighIdupy?=
 =?us-ascii?Q?26/EFWC/xvGL7KXdFBaQ3Ow8qSvGmFTslNHprsT2DBazdMUQ6QfNmyuQM1D7?=
 =?us-ascii?Q?4YTOfEWKfxb9KHvEGuf9p2Cf63xCtPFf8Ve+ZWFY2ouXUf7vPOGPPaqC5paW?=
 =?us-ascii?Q?9JXcffvg3UMafN4UPHOZDx2PibQw6bNytv+URopm3cmV3DtSQGZal4scE7hc?=
 =?us-ascii?Q?QXvNmNzvV75noycB7C4dg06gcihGMKAHbI6H2E6qehmvuvOXwCWM+0YhaSZr?=
 =?us-ascii?Q?lz2XDgITb4AZ3QvgAp+Rvt69ztEN4rnh0T2Ofew/nSEZg6LlHc1outTAWjSe?=
 =?us-ascii?Q?lpE7sHNyQaAionfkfVSZG8z49xBdsHWNdaJxshcIClyfdCGBVaWCvsMfS5bD?=
 =?us-ascii?Q?SOzDErIa0TAh26LtKZmBheZ8WdhoR4Y=3D?=
X-Exchange-RoutingPolicyChecked: DBEAbKwl0giqns5tR0ZyXSbBuFTcS0SLLeSZuwXY8fFtQKgFZEF7zEfQuOyeP7tyQf7RfA4qXQv61/fP7SZclh7E+yEAEUpHATVm4JssaCcVAjXlm90BEptUNKaQb0XDGdhlVrRIUjv47LoRSI9C+I/xPtx2/8kuHNVX31x2/A/fGVcTtEKZzqDi+Tv7gajhX1ZduPO0pt/GgIGibTiPxeUV/rfL4MKGGDbhwYJ0Gw+Pmv0bqbwh6CloQpR10/3dFfw59so2pBHLzCPjtvFo09f00slBrWrf3tejLW7h94N8VJYnn273S9G3wcaQbQGQLx53jmvuQ5aC8i+/PQ2XwA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 41EbCo5CWQzSHn+XlP0BZ08DISn4TmQgoHtJMz2vWAv1E3fvL0iJQIhtoAmLhQGm6kjVbrDqzes/BqYcY/+oiZsPrGpjo92sbXc8907qNCdpW8C3EfaDDSxhEmPnT88PXkFhn31XV3iCT9mtkPgnyTpB952NaHjdB9NE+SbuJMHtIkZfO129F379o4btNK53GFnyf3URK/dgpgebHhMcYhCXFak3v0U4CMM19F9Zb6PuTqCMb2gHlJ/FUQjdSwXN0K7+qKdiEGbFnWoIz693kQLnaaNJAQ6CTJkwc8z0EYES3gItmdXbNCidPWe0bx5ZrHxvMibAqZMigG6nBNw2M0+oQCMWS5YGJIv5WqYTTfztz8BNwm/YsyzLcee0j7QyQVZEd38hZ9YpbxMBu3jfCdxo0RtZzUX7Y4+lBfV/XvNQUROJxy0fB3eFLj3GsRD8xVzCXw+3j1ihT+0EISYGxc3r2CONxF5IvuIz9xrTPKe3sWZYzmelUYX/9f6bsfBH5Na7k/IIm3fxTZDs+Z0mkp0u3/kKCikybCw/s+BQCiUJTpEMAn4q1ROmBnfan8Kw9AYnFn2RbZYVkZ36cRYk2uRhr9VKNTClDhQqXVuXTn8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f218d718-f2e3-4570-ccce-08def17a3369
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 16:13:48.6859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R++iuFx+Mvr3UjtBVBdfCbtkVwZc4Fsblm+ksoBJiUK8pYUOmp8hVSHg+Rv830SOLXhyhhP/7FpmqMeuRdVJgajVzycGK9XEm5fLs5dXktw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4189
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608030144
X-Proofpoint-ORIG-GUID: 9bJb74Rj1og-KO5T2vkCtyq0XNsKATSq
X-Authority-Analysis: v=2.4 cv=XqnK/1F9 c=1 sm=1 tr=0 ts=6a70be40 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=ZLSXSzSCM89tNEpOOigA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12101
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0NSBTYWx0ZWRfX0DZGxW9Kk1Td
 pCBKdaJ1J2GItiFaladcJfkJiu2SvKqmJik8GW43PInHxqwjB8pYJhdo3il94+2xy1gUi+U5tG7
 69Ovz9anVRh9mJEl9q3A+Y7mK61j+kL4tTkcWYOs3WRC4g6Z0DKL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0NSBTYWx0ZWRfX0OvEnwn8z9Uq
 q2RFm1EuFUz+iIuu/iBXyBf+PEfnSyU+gRwXKlddUX51vUCiKsDZ4r5ZS+U3vUQFY8pOZuL3KJn
 G/Ld5dXXjTLnkWOGPdATEnsFAGDUz2Zj0WtPljjBkPP+YWsbYz2CejCMBTORlSnFjtdmh+WP+sQ
 m/9lcFfbcvT+LysDjm5LDQleXSS4VcFUfvidLtx8yrGq9+taMTbf/1BhUUtDanAwJJFSaCroVSy
 EFhlfTG//Tw3I72+Z/CAuY4w6d9Lx+GhyFa4Z5t45pI7/gy49JhA7xUcBpQ868y+ncNlqK+i9Dd
 4eUNNmyudOxvZ/DxiUBc3OyOD2AvsnHLIcL0POiXQhkp0WD+4WdXmBTaj54yP0ucKBaH3Zu8FJ0
 dZ7hWra+rcNpaOJSORVie7g0ILILLnc0C1XlKzKBkXz3AkLS1ElUV1OaFMg5iFiwg//TBN24f3c
 VUf3ku7d0RyyWkDzSYzniTb0oZqG8taCgIY1TJ90=
X-Proofpoint-GUID: 9bJb74Rj1og-KO5T2vkCtyq0XNsKATSq
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260803_091355_783849_085FC53A 
X-CRM114-Status: GOOD (  30.58  )
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

Hello all,

Just a gentle ping on this series.

Thanks,
Stephen

Stephen Brennan <stephen.s.brennan@oracle.com> writes:
> Hello all,
>
> Building on Tao Liu's excellent work for makedumpfile extensions, I'd like to
> share some incremental improvements to the extension system, as well as my own
> two extensions which enable userspace stack tracing. There are three topics
> related to the core makedumpfile extension system which are addressed here:
>
> 1. Tail pages handling. As patch 1 explains, extensions currently get called for
> tail pages, but their decisions are not respected. I believe the best approach
> is to only call extensions for the head page, but allow extensions to return a
> decision related to just a subset of the pages. To this end, patch 7 adds
> PG_INCLUDE_HEAD to include just the head page (leaving the rest up to the
> default policy), and patch 9 shows the elfheader extension which uses that
> functionality.
>
> 2. Counting pages included by extensions. This is done by patch 4. It alters the
> logic because it's really helpful to know whether a page would have been
> included by makedumpfile's dump-level filtering anyway, so we only count the
> additional pages.
>
> 3. Sharing makedumpfile's logic and knowledge about page metadata. Currently,
> extensions just get a "pcache" pointer, which means they must redo whatever
> logic makedumpfile has already done, in order to get information like
> compound_order. Patches 3, 5, and 6 factor out the page metadata into a new
> struct pginfo, which gets passed to extensions, and it also makes more of the
> helpers like "isSlab()" usable with this pointer.
>
> With those improvements, the final two patches (8 & 9) implement a pair of
> extensions that are useful for including a minimal amount of information which
> can be used to do stack traces of the userspace processes in a vmcore. The
> "userstack" extension includes the stack memory itself for each thread, and the
> "elfheader" extension includes the first page of mapped ELF files, so that ELF
> build IDs can be identified from the vmcore.
>
> My testing so far:
> - Live testing (/proc/kcore) x86_64 on Oracle UEK 8 (6.12.x based)
> - Refiltering on vmcores generated from UEK8, 7 (5.15.x based), 6 (5.4.x based)
> - Using the resulting filtered vmcores with drgn's contrib/pstack.py to generate
>   userspace stack traces.
>
> I still have significantly more testing to do and then share out:
> - Testing in kexec environment
> - Testing with upstream kernels, also verifying in a Fedora userspace
> - Sharing runtime and size comparisons with different workloads
>
> Despite the limited testing, I wanted to share these patches as they are,
> because I think the improvements for the core extensions framework are useful
> already, and don't require as much verification.
>
> For the extensions themselves, I would like to consider merging them as well, if
> there is interest. I think it would be useful for makedumpfile to contain shared
> extensions, including those for the GPU buffers which Tao Liu was working on, as
> well as the userspace stack tracing ones which I'm sharing.
>
> Thanks,
> Stephen
>
> Stephen Brennan (9):
>   Do not call extensions for tail pages
>   Honor CFLAGS in extension/Makefile
>   Share page information with extension callbacks
>   Introduce a stat for pages retained by extension
>   Move page checks into makedumpfile.h
>   Simplify arguments for page checks
>   Add PG_INCLUDE_HEAD extension return status
>   Add userstack extension
>   Add elfheader extension
>
>  extension.c             |  10 +-
>  extension.h             |  10 +-
>  extensions/Makefile     |   8 +-
>  extensions/elfheader.c  |  93 ++++++++++++
>  extensions/userstack.c  | 325 ++++++++++++++++++++++++++++++++++++++++
>  extensions/vma_mtree.c  | 140 +++++++++++++++++
>  extensions/vma_mtree.h  |   7 +
>  extensions/vma_rbtree.c |  56 +++++++
>  extensions/vma_rbtree.h |  12 ++
>  makedumpfile.c          | 188 +++++++++--------------
>  makedumpfile.h          |  78 +++++++++-
>  11 files changed, 798 insertions(+), 129 deletions(-)
>  create mode 100644 extensions/elfheader.c
>  create mode 100644 extensions/userstack.c
>  create mode 100644 extensions/vma_mtree.c
>  create mode 100644 extensions/vma_mtree.h
>  create mode 100644 extensions/vma_rbtree.c
>  create mode 100644 extensions/vma_rbtree.h
>
> -- 
> 2.47.3


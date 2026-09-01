Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A998DC61DD3
	for <kexec@archiver.kernel.org>; Tue,  1 Sep 2026 07:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kt/qvU+ajKe6lRsUKuAgqh/8uV72lTgiscx31lGmUTM=; b=myAcb5Dqfj3vL6fRlVcdKqIIxB
	iPweWpyVFJQFCFeD9YS5ge/RTLE+0O/gm3hi+yTsFeLdlLOH9+V3iua7TnS4OdVMKdilc2Y4dMFIU
	j5XXPVuTakbcJO+zC75K5Db1SwGOzHnn1cPtlkOLvE7ZAtL1fwBxrcF0v9T2oscJgPeyPELn5nesO
	GSkojBgg/GSoTNNGtp0MoJvmGEKPm413mtDq2igt2D5f+I2krH+5I6ufvGFqOZqUQFZWLcWwAwsuW
	OaXa2GyorUOEMazDxGH21NUUexM3nimckmS+/RgSrkT+s/u+sBjqI3isv283LqyDsf6fykHiuCCSv
	pmz4x7kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1If1-0000000B5uH-0OZq;
	Tue, 01 Sep 2026 07:11:59 +0000
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1Iev-0000000B5te-22Hz
	for kexec@lists.infradead.org;
	Tue, 01 Sep 2026 07:11:56 +0000
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68179J7J1564660;
	Tue, 1 Sep 2026 00:11:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=Kt/qvU+ajKe6lRsUKuAgqh/8uV72lTgiscx31lGmUTM=; b=
	QUHb70DMVMb0rZIqsL+nr1HfovarC5Mcs1fzlG4bKkFf5cqBXsqqJo2OfjEd0Jyo
	p10sFCrs1npPdMPDi4dHf6Q6X9+FfXn64v/Yd7UncWG65QpHB4MSvSvv7PaZc89m
	9PSsudlwzZZ22F9cp9Qp/7ufpmWYanqIz0pKQ6zPDxjopU81/ov5Opu3B5I+fent
	27W4x7yiKgXv2MhvBJ6U/ThZSgy7T+5O3gTgZhqb1wH8dSJPPSzylsbHIHYqIbFV
	YKfFKiGo+xx46ARId8iuEID0czcN9keR2VKb6y7h492W+e+L+8xRGGztqrI8oWlu
	XfKVru1lb/BIl+K+niBNbQ==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11023110.outbound.protection.outlook.com [40.93.196.110])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4gbxxebp31-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 00:11:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMxfshstCb7SZ5sDavCanjr7ywf67oQw2gWdZvkDLJ9fQumxalOVOGE1x4F8BqsgAAgcAYRaEWKiinPfv0zOu5Eghoe7DvuObA4aAUNgAXoLB0IKeobkNd49CSO54mkqfcrxNeGgNqW3gWVGn+/ahc6wlbwa3osik8m+FhCd2deEU5Hvx+9sLQScH9TWjOtcM53Dc0ochRIg0xB7nSQdZE7Y/PXPEX98jw587J9YEzuNcT1EFYZsMh2Nt1TKjzkxSeoAts3FcwANK4x6/jY8eh/w5EgvPjVT/+4s48/vDQrmii7S8D+auKAwRbXUTPjn0exHcnltWFsW/ZoYRZvt6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kt/qvU+ajKe6lRsUKuAgqh/8uV72lTgiscx31lGmUTM=;
 b=iwIV3zeyYnYu9iH7FzHjEP3rN9sIvBbymIV8gQtHVm6P15K16/k4WilN/2s12Jc/mLSWZD3dtsu3+PqhgSbRSuArYYMz1qP666SrQrBnMip67xb653BK9e86gotpYX1m2UiVp70SCVLvyHkG0pTqMGa5g3PMaapLXOdLuTTvjBXc3dwaqmJuGHPpqALh8nq7/4Igkr+DxnhlH6sF019NdAjRdc78fdBHgHI7Mii34qR8hAuOte2sQat088gxy/g93psQAcKeBAAqX7JNWRi/s3e4qV2LExI94/nOHaWYRjhvU0dv68+HtECjHgrlmQC1y2GgXSzJ1fcELsbOR28idw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by CO1PR11MB4961.namprd11.prod.outlook.com (2603:10b6:303:93::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 07:11:15 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 07:11:14 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: x86@kernel.org, kexec@lists.infradead.org
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org,
        baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com,
        pratyush@kernel.org, ruirui.yang@linux.dev, eric.devolder@oracle.com,
        hbathini@linux.ibm.com, sourabhjain@linux.ibm.com,
        ruanjinjie@huawei.com, brads@mainlining.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] x86/crash: reserve elfcorehdr for CONFIG_NR_CPUS, not CONFIG_NR_CPUS_DEFAULT
Date: Tue,  1 Sep 2026 10:10:40 +0300
Message-ID: <20260901071041.16311-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901071041.16311-1-ionut.nechita@windriver.com>
References: <20260901071041.16311-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIUP296CA0079.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:349::15) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|CO1PR11MB4961:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d7e469c-585e-4ce2-5116-08df07f835e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|23010399003|52116014|1800799024|376014|7416014|10067099003|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 5pG79gEL6i/madCO/OZHVVgdgJnNOrOgHk6N3RPX3qGDbekQOJcc4q4V45TUacQrILXbzvrnXTpZIpsIu9uoxUlzob8O+3Wor9ToH0qyFOAgBJa4vDTLdilXdnoCFMvfsF53pt6n5QGLAAbe42eAk9zgWJ9NCGIpsAfIFdGYPhVSLIYijgngAD2Q6XZ9ooFWcvXC12x2grRzBQuRjLlU+Ir2ffLgK5GjYXgRJ38XD8iS+D0B9+Zv+zBPaEKky45zUKqoR1AKsL6bdrtBXT5UJ1OHNMLsKZTLyocmdqR7gn8XRU7qCNbUg0rt2uEyIBM4a173VuK0vCmGxbCKPH6WAPsLoa74J4qe7UigmjZDUyy4gEgv0v9gWQOxsHwTR9s3DnpCvYzsiGPN9NmbsVyE/IT6npWix6SC5YbauoBFXEQYccRNzSImjMYHAdrmBgjdN2YicjwVDLbB69OGaJp71WqUEuDSwQmfacCKIAMGasYSfIf05ZnySZVg45IWbY8xqYrrBu9T7XUbxvL8TToy03Gfbi88pDOa9n3ycgdzvlqhDtuPIcQKpgpDP2T39S9BdiyC7zhonXmKpIhlXG84krGXbeXAW8IL2e2d3q7YMEpH3VFKLodeTTwrpsQ/CMspysb48gP8+oVXgIMMNStXqdd4Vm/iri254d2anF2pKu8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(52116014)(1800799024)(376014)(7416014)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5mjtghz8h+Twys56UqM9Zl/kndcHOK3Pl5wIEzeYkzG8XL48+Nqg17wkqgjb?=
 =?us-ascii?Q?fMAI/7ZgZF6+itwxGeIIDf/xmPl7tzZy0pt3EHFeYABb9fL9wz6BnrZqAMT2?=
 =?us-ascii?Q?dl2G1z1D58wMHtFKrs54BiAXg0IzIJ+hZRPBdXwOHCOKucDS2gDLg4otsDMt?=
 =?us-ascii?Q?aUMGXYOFoIr/FYkMUGzqwdoO68Uw7kS806tSZOeHUjM90q0pq8Fb9M2GLHnz?=
 =?us-ascii?Q?iGsMQTI+Jn58kEUM7GwG8DactUfF+teHa/Eq7lhhzLngdOwQdR92oCP+lDKL?=
 =?us-ascii?Q?hnM5mf1wWnhFJ77JWKBdThtLyDTLeECcsMl4hHVeXQyXjH9KP2A8pxrp2bnv?=
 =?us-ascii?Q?gJwykDHAGCqvBaQslIG5JKp4xzn5nEqQpnimj+7f8w6Krku1kpsT3lQFpYgQ?=
 =?us-ascii?Q?rUbXoAz40z9YNiIFQxkObfQ7dr1D8MOW/pKrmn4eTkXzi6iuug7yQL5cHEOp?=
 =?us-ascii?Q?SxiSztkol7QQnVdn53zRSY+eU5uv3REPiPq6Gckpl3iuS2L6OPmP+fEf6WAb?=
 =?us-ascii?Q?txzpz8xn9t7gkjeW+WYTFLoJaC90829kJ9UCjTSPvrU42Sf9QMwLyIZ+tZvk?=
 =?us-ascii?Q?3lV+SMYDqcq9LbfcKJgQZPo+BGcOSwZiv45VH5WPtMpHehnvvKjIcwAtd9tZ?=
 =?us-ascii?Q?5S1fS/xJS+0fw2IrDlZtPVRcQDJUFKjtIt0ZhmnKnxP8NfuUcGpbnLUuJPAU?=
 =?us-ascii?Q?xoCLHbcYVyC6q+ZmtAT7kkuzH1BATTQEQYZ4TbfURKdxnqv57micAEdV78zA?=
 =?us-ascii?Q?2CMJ45ERsXDk486PStKV4eT6L8h6vLS8pzxfZLOc35QmMfpct+cB0xoroVhy?=
 =?us-ascii?Q?MBZ+xKwha6t3OD/S3c8YRsgAXg9/1Chvq2gmWdnRBbaeexxmXq5Oi6pkIDCl?=
 =?us-ascii?Q?HgN8w4PJkwVYv4Q/RiYDsJGnsKK2T55SGnEMXru8LRWuQJuDzRtxo1L5296C?=
 =?us-ascii?Q?sHaI52uYGMwBKWqpRf3cwGmV3uH1dKqkr5XqLXm3wJKR88dXuZFwE9Anh1AD?=
 =?us-ascii?Q?D+G3k1nqXZOj7hyXc3zx7R1J8VXHyMoC7QpegnLPl8N3MTlJqKfA6yhm6178?=
 =?us-ascii?Q?1OzRSJlMNKbvmVJ7u3lUcorg5E7uaXPTpHt6oe95aeRxHKnHTL+bUE5G06v8?=
 =?us-ascii?Q?DJtM+goZdTaDYxLkb49AemgRJFgBzNZDX3NGPoN3M2zW0TNTHUU7ab8B9fNN?=
 =?us-ascii?Q?abbeKjrATL08BGGsj40THld4WGscPPOUSIdbOqMA4F6fg9xuY1dg7Ermvfjo?=
 =?us-ascii?Q?5EDUWd/OFES9Abg1+/v28jw4L+dGOFHTK9aER3Y4sWTI2R7LXyeL4IUKwv8Z?=
 =?us-ascii?Q?/URqhCsvARgCxjuUJEpy8MKzmICZYQbv7mluEdz1OrkmLF8H1cFh4vC9At7U?=
 =?us-ascii?Q?xU9lFg8tjttLQOiuNjRFkl/a8Pmp+BVmC9LLxUxoYcznjG476oytmHTLiLnN?=
 =?us-ascii?Q?Cm86g5vY36kOv1KE83ovMWzzDpFIIuIq4aDXFhYyhctBh5++SzRPAACvYgp9?=
 =?us-ascii?Q?6W7rouZRQIE+F5OMcrG3L/UYPj6nPNzPiOc+hL7CL7TTRwDi8b/H2peS4KVo?=
 =?us-ascii?Q?cDuHdygircssjRBgqVyv8BJngloK6INC/WJ+S/ZqzeUU3QZ6YEiATC8ycLBn?=
 =?us-ascii?Q?E85T/j88orNYTM+Ai4fcDne0GDbv1zDpUhHTUFesD3N3bBoYstTNKIfHL+ps?=
 =?us-ascii?Q?jFaQqjFoGErRjHOAem5sVPVMU4lbeOrGqaJRROPDI8CQk0G+yB0aFBSuVkN1?=
 =?us-ascii?Q?NiFIufz9nfPsgA32IGGqCANvHqMbIdUMfXFCK+v8KEEvuy7fnHBl/bGR8XkG?=
X-MS-Exchange-AntiSpam-MessageData-1: eGsasbaS/p5i5UnQxmsaYbm92dElGJFGrHo=
X-Exchange-RoutingPolicyChecked: Bf7r1kteUpb7Z8VcL4JDbua4cSdeL6awOzVCZuW7RBtnjReAgycicLWKGhlrZXeb9MhxNvixKk0YFNY/6NA8/PC4Sj2ZwwxJCMtYyipndVpgRo0HCinwMhol7KK4buwReB8ItXaBoK+XDOWXbd0J9j3v3rvNwCO0jhRq8//WeW6rspcYcbcmG4f/UCrHkUY7zexZD3haoI6OCa68f/+JoLOTddtRe8OYuh8z2JmyDeW1fNySdyDUGAgbukkU+vtVhjM+CvbNN01NSPNMi6DWwuAKxPuzG5da1lRrqEZkRiiXzXsC5EksQqNbh6cDY1gcJbWcafWqgl/k9a70pSI+Kg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7e469c-585e-4ce2-5116-08df07f835e1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 07:11:14.9517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OdhmNMwyNZnqPcSpmEATZxNlVw+FOo/9ECV/Y30MQsLR69ajAyqr7nCxNuUJe72G7KKR/HAeQjfNSWTCkL6yd7/rJR1REraZiv4nAd9BJ3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4961
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA2MyBTYWx0ZWRfX2X5o5n+4P8cr
 fYogbTHvA5xVyfBCyJEK+FAXrZMuKQLx8HHsw9KVTN2bxova3erNUZ6+4BJyld1Msjk3Wso8anT
 R3KzbC98aLXJKmBkm1gD7CjEru5JugaUBL0bHCuwbbjjpjm7jO8NqZaSJ92+FQok+7WZpphvqA5
 zj5Mpqrm8Q/Eq3GI7OGqQjlFveZuWP883SfMMS0CMD0+qojLkOcXMjv+RB6H+GNfhjEpPyrxxVF
 VIZEELlidt08ED1EFOvQmgmC81K/1OGu9R4wnCDkTdIlHsCXb9+vJlLGM7CnQKSVbHmJwnNp5Mb
 ea0GdeP4JcGtSAQBakQw7Eu+MG8Sib12qv5ykX379gyTqc77fvw2rO+je7ma75uvZggnIQIcWre
 ukCxX5W5TxOt6CAKx/Tvp17T1AG+Iyh5s/DW4kQd95MO8t/ZFK8J5Zy4jBLeizj3kWcxc6Clfhy
 skuBZAUYDYH0AljU6aw==
X-Authority-Analysis: v=2.4 cv=BJaDalQG c=1 sm=1 tr=0 ts=6a967a95 cx=c_pps
 a=qcps1HI71LguUYAr+x9W0g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=i0EeH86SAAAA:8 a=OuZLqq7tAAAA:8 a=VnNF1IyMAAAA:8 a=m8V-6NWbVX9GoHuZUvMA:9
 a=FdTzh2GWekK77mhwV6Dw:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA2MyBTYWx0ZWRfX8tQ4lnisk+YE
 E7Xv/FX08YBH1eK+9AVdz8UXAeE11KRIxICVpznx20I12fT0qnSK/lJHVPtl2x0ydb72dv6Olog
 pc4Kwa2/RJ4cU4VrO3+pL2z5lOg1kjHc10d184CBqN9MpRjM1Njg
X-Proofpoint-ORIG-GUID: 0oUvx6Hd3-K2UyBu3GW8_gg0QsDd6wjk
X-Proofpoint-GUID: 0oUvx6Hd3-K2UyBu3GW8_gg0QsDd6wjk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010063
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260901_001153_571223_C03B9FDE 
X-CRM114-Status: GOOD (  12.42  )
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

From: Ionut Nechita <ionut.nechita@windriver.com>

NR_CPUS_DEFAULT is purely a Kconfig thing.  Its entire purpose in life is
to start NR_CPUS at a sane value.  There is precisely one (buggy)
reference to it outside of Kconfig in the whole kernel: the x86 crash
code.

That code undersizes the elfcorehdr reservation whenever NR_CPUS exceeds
NR_CPUS_DEFAULT, because the header carries one phdr per possible CPU and
num_possible_cpus() is bounded by NR_CPUS.  kexec_file_load(2) then fails
with -EINVAL from sanity_check_segment_list(), and kexec_load(2) silently
truncates the elfcorehdr, which surfaces later as a bad or unusable dump.

Size the elfcorehdr reservation with NR_CPUS instead.

Fixes: ea53ad9cf73b ("x86/crash: add x86 crash hotplug support")
Assisted-by: LLM
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Baoquan He <baoquan.he@linux.dev>
---
 arch/x86/kernel/crash.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index e681ec9cf1dc..e6f23933a6df 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -369,9 +369,9 @@ int crash_load_segments(struct kimage *image)
 	 * maximum CPUs and maximum memory ranges.
 	 */
 	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
-		pnum = 2 + CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES;
+		pnum = 2 + CONFIG_NR_CPUS + CONFIG_CRASH_MAX_MEMORY_RANGES;
 	else
-		pnum += 2 + CONFIG_NR_CPUS_DEFAULT;
+		pnum += 2 + CONFIG_NR_CPUS;
 
 	if (pnum < (unsigned long)PN_XNUM) {
 		kbuf.memsz = pnum * sizeof(Elf64_Phdr);
@@ -430,7 +430,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
 	unsigned int sz;
 
 	/* kernel_map, VMCOREINFO and maximum CPUs */
-	sz = 2 + CONFIG_NR_CPUS_DEFAULT;
+	sz = 2 + CONFIG_NR_CPUS;
 	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
 		sz += CONFIG_CRASH_MAX_MEMORY_RANGES;
 	sz *= sizeof(Elf64_Phdr);

base-commit: 89c07d98716a13454ec3fd9f97689e812cc71bd4
-- 
2.55.0



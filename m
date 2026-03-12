Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA2E106ACEE
	for <kexec@archiver.kernel.org>; Thu, 12 Mar 2026 22:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:References:In-Reply-To
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B7u7y688lbAKGd6q/kwrVdI93HHzGauJ/jlpP/dKwng=; b=MEQtiL//EfRDfHpx0TiwhuGUvu
	0HLn1DS2imHgi7LqfVsrBuWXVHbahsPbt2F2Wx1+491rugdS+p21KGwTkufvTi//h8VfamXP8qINs
	11ANNR6kmD01OpCf/nFcQ5puAvnTjT3s5Q+xkeD82HVR67nx8VvMbYFkAjKz6FDrMfSJaWeacUKzg
	XcxpquAxxIbHCluJ5TX0Y2mqBZOX50U2x8cry4qCXy4zXyTe3QtHmKq9ylifhtxYxw8LmVZeLhOGA
	bwH2upC0sjEaD1bL0UzMHk0bUJ4rp9aSOolfCXo77/yamEwGYiA5oGyGNnhFbtdMpcIbMUAMNyqTl
	u7GVtm+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0oSJ-0000000FdCo-2Lik;
	Thu, 12 Mar 2026 22:24:35 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0oSG-0000000FdBn-09je
	for kexec@lists.infradead.org;
	Thu, 12 Mar 2026 22:24:34 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62CLGcvV3584373;
	Thu, 12 Mar 2026 22:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=B7u7y688lbAKGd6q/kwrVdI93HHzGauJ/jlpP/dKwng=; b=
	NoHsbh2e6wXYYlKADmFNSUMSpOi3xyjmobRl+RURa/9nfjzPuGWD8A5K8HA6u0yX
	bXXnsnB3FIx5bOgsu1qaBRbZkl+FmH6a4xuaZROSufkDB+7hPNk+Ys0IogHjmhM1
	xhYVk29A+oCD6wIxpFsVF6H2Q/i+kDXiY+8U9w37lIywYTDbaj2Ey+UWja1++JkV
	G3UH5iRd/B4VJCRt+7HffUc2yaLy9XtN1HaEgbUSot07T7Qkqmzu3tHnr/MdMwdO
	R6/DM7rie5xCCqcGp149C6ivudh9xszyiFanmXG7NSDxCzWkWU5xR2UqIIE1MSYI
	MHyp3XPDphMD+NRWEzU3hg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cuh4rhwat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 22:24:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62CM1HLm013379;
	Thu, 12 Mar 2026 22:24:28 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013014.outbound.protection.outlook.com [40.93.201.14])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cuh5dwutr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 22:24:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfHGQfErNQAesAFrYuTjyqfjC8Po+yA+p3xUfe3hp9XeE2mAJB7FUx0JpD1HpKs+eCQtR8Er/YWk5M+3dFX1wU8wygzb9qFboXbLJrBNv69UC5/c8fRxlNXbDoDEDsSFwZTYCJbJjoRGDiJGhu7aYtpNx4ARcTeWF+wy6YH7PlMfWdu+86oBISxKiY/EhxNVduG4Gc8MLedmoLPz6qvBKuAsTIywebPQGf+p9lJoap5kihc4CQxE7U/BrICqy4No4VQPTdWHrcFP3LHIILp/vrcwgQEZtt0/s2pRs2GtEwZMzmAXSoJsZmcbn0kXfiZPsWLXYeWhq8f9ZzCB+mN1VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7u7y688lbAKGd6q/kwrVdI93HHzGauJ/jlpP/dKwng=;
 b=BSBrXujB2s6CA+fULTD/HYtaDc684UJvkxScFgt+npk0To8WFlpM8ZIGu3nJwVo317uDO4AmltZqcWe78G4QRrBIO3DvoWK2fVgQbw7xo+xPCgSlO+efLRhLCDJyN8/yFCmZPt97j61iYDEO4tcBGABN/LLFZWU+FGuB6TMO9yVl2FTr7gmBNLLei0v5HAbm1/MmJnNNMdq39YWSucHe38zkX9izqAxU44AwaEjL5qVbCIaLNOctpRDBwI47Cdnqusbefxi5ZDnK8P8tAALRMr+CjiqrO46JLFzwX6uBH7rBvhd9kwshEIXEIeSRvFuu5vdgUUMM1zr971X1baVmyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7u7y688lbAKGd6q/kwrVdI93HHzGauJ/jlpP/dKwng=;
 b=tAi6HuvIp21MAstYWDLJO+S7qL1CiRz4ZzzAsL8IddfmF5rnZfF2aBp54t1o9MI8pnd1jjbelBiDSzPTcG2nlOGUE/3GWD17Yt1vTC3iq/N1lsTIsXWTzkdba69q6Vnhsps5HZLsrbd0WEqQIXaPD23xwjMd3HWqJxrNOxTf+/E=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by DS0PR10MB6055.namprd10.prod.outlook.com (2603:10b6:8:cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 22:24:21 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 22:24:21 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Tao Liu <ltao@redhat.com>
Cc: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org,
        aravinda@linux.vnet.ibm.com
Subject: Re: [PATCH v3 5/8] Add makedumpfile extension support
In-Reply-To: <CAO7dBbUGHCo8psJCvrfipR=7hYyGM16713ANM+6FDOjrhVNeUQ@mail.gmail.com>
References: <20260120025500.25095-1-ltao@redhat.com>
 <20260120025500.25095-6-ltao@redhat.com> <87ikcuv5ag.fsf@oracle.com>
 <CAO7dBbV-o4pTkaxaiZxfWHV7WDk=3fBc_XWVEs1XNWnvqJw46A@mail.gmail.com>
 <CAO7dBbW34=+DQMZ8NyPqPtm83nr2DYfa_z0Huf=NS8bzrh053w@mail.gmail.com>
 <87o6kvmc8s.fsf@oracle.com>
 <CAO7dBbUGHCo8psJCvrfipR=7hYyGM16713ANM+6FDOjrhVNeUQ@mail.gmail.com>
Date: Thu, 12 Mar 2026 15:24:19 -0700
Message-ID: <87ldfwn0to.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::24) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|DS0PR10MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: 85d157e6-a410-46c0-fb9a-08de80861b76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|18002099003|22082099003|56012099003|7142099003;
X-Microsoft-Antispam-Message-Info: zYQWYVhUdhQnzX7IeXWNSeEEN32I0dNmx8xfoTOyXg8iK8EjWdlcwE21bqF+kXxTwewXgiDty7wcdCJepNd5ovjZCXYL31oJdxU6S8BTac/XF2ayu46+4GC3+oiOLpgEzOSHkt4kFeTckdvjXIti321uJLmwrPuKHuU+8cqxRcvWd89EEu+g1fkV77F3Vwq89cLZ4/BMzmL1guO1wrVTmDwfB/5TAP6iIaueXeDhZBxA4J/MTxhkr2GHf5uReZw+IZeRZ7P/8YypFh+Dw46JW/LpAEQ5r6tkXpIIeh72IZHDCjr0C9U3nGPyf/8bTGR0iSeJDSLkOZmIgw+/eI9c6MYYXifk9lbbrewroCp5ZRnOzHP/idHaHYbZsMlR2h6n5G3tvSbXU67WGsJl2Iea+65UV+HwwClyQcEqTuryOUafZmoyrG0dIzzGw8/blsyL/Qzn8ZHGc2MPBCG+3cO3guBtZ6aHDVPFuQLDlZSkFllgJllKCYJj/UFdNq9//n9lWEz3TD+u48EcUfbPbshZqk6bogisrL2r380etzyO5Q2QLpKjpDb4fSFmoL92pZgHz6kLeoL50bP24gQOzT0DwVChogkQ6D1xK6Z9Ym7gckUA9wcjp822GMtF77+avu4kgACKPwEpjHO5duSwRZLFgnmUrIicQu+/3ABEZ4CjvIwxLqtmr/ohg1DP7Cbp+K2JBrVae5ipHP7MGnANvirZAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(18002099003)(22082099003)(56012099003)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ang2cjRjY0NRSTlTZVF2dmU1OWc4ZjN1ODRVRC9XNTNDZFZPSWl0dHd1cFNP?=
 =?utf-8?B?Q29NWU8vU21Bb0grbGpKbGluVGJJSHhuVGVMK2RrNEh4cEZTNmlLLzRWYWFm?=
 =?utf-8?B?WVdIU2pGb2NOMWszRXd2Q2thdkp2TktBWjRqbU5BajRYdXdtRlFOcGxxeVFh?=
 =?utf-8?B?Y2RWSE5iSktzb1JsOEV3UkRMTXlDTGlsNUFHWW5sdTFwUHhZUEFDTVpET2JZ?=
 =?utf-8?B?bW1WRDArVHRteFQ3c3RKMVNaK3BwOGFlN3lTOXB1T21uME1maTZHMGhXTXZ0?=
 =?utf-8?B?ZGFSRDg4MUc3MGw4a21hZUNkTzlvWnY0aWhVRTUzNGhPelU4RW9lNGpmN01a?=
 =?utf-8?B?dEE0Zy9vK3MwdW53bUFSSzVVa1dyVHZodTNvRWwzUS94WlVVVEpFWVg5SDdi?=
 =?utf-8?B?a3Azb0hVcUtpaVV6b2wvakVpb3VFckcvUkZ0TWoxWUtHUmNJUk1UWkhBT3JU?=
 =?utf-8?B?UVFha3lYd2tNV015VnJaWHpISUQrbmdDYm5HRWlpZmJYSGh6YUtuOWJTS0Vy?=
 =?utf-8?B?aXJMRG9SU2VXa2RFQmRmYk5QeVovNTBsUkF0MVJDVlJJMXRIK3R6NjBadnYr?=
 =?utf-8?B?U2ZNYlNlMy8wcWwxY3dBN005bnJyNmdJNlVjdGo0V2pjTHNLTmFvNU9zMDl3?=
 =?utf-8?B?QTlVNlFxWWhrTXkvWWNRVUt6bUVwa3VvUlcwaUtMWjhTcE1qNG9vV2F2WnRl?=
 =?utf-8?B?dHJXeXhyVUlHTzByQ0dZbk9BNTJkdUhtd3RZM2tIVVdLTnlBa1cxZDJGYXVa?=
 =?utf-8?B?ZDhmR2ZXYTVvWWN6UjJQZG9iRjk3ampzRE9lOHRmQk9FcGRWVU9LcHR5aTVj?=
 =?utf-8?B?Wmh4enJIWG1BeFhGNGw5S2xJRFMrcjhxeS8wTmZ0T25OUldKNTl2Sm9zSGE1?=
 =?utf-8?B?Y3RxdjNaMDRiL1ltM3NJUjJGS3dMVnZRTDdFRGFmb3dvTm85V09rZUNrSGxn?=
 =?utf-8?B?OU5iSDZ4UFpWZmt0YTZ1SG5pS3k4enc5OGxaT1VXRkc4aGRVTXVZbFNRb1Jw?=
 =?utf-8?B?NUduK1FXR0NPckJyVzluSTBDbXZXTzBQaGsyYmdjTjNZWWdjYVNLTk9icysr?=
 =?utf-8?B?UER6Q0JUQi9LdHNCeWdha1JvNTlEMkhqT3RIVUk0Q05VRnZnc1RLcnBORnZT?=
 =?utf-8?B?MUlEOGpQSGZDWE83MmIzem4wN08wdTVJV0R3UlJYQ0k1ek1hcDF2M3V0aVdN?=
 =?utf-8?B?c2Q3WnJoQzlFYW5SSm9EMS8vbFNiWkRFOHZyMGU3bXk4bXdDMjVsUk1SSGlB?=
 =?utf-8?B?NFoxd2JZWkM3TEE1NEFOUXA4aE12UEpPK0dVajlwMHYzYmlHOXFmMjR4Nll5?=
 =?utf-8?B?WWFUWEhWZzRPNk5iVFpvWVVQQkR0RDk0Wnc5ZFA2cDhCdW54Zis5RzBKdTJN?=
 =?utf-8?B?cXFMS3hQNExpOW9WMGpIYzBZYjR2ekVEU0kzYVVWeUhlaElkUG5lOUdVaXpm?=
 =?utf-8?B?WklVenlLeUVLQTBLZ3gwTnZobHZLdzdMRmV0cXdDejVta1pSSEYyOGhNaUFv?=
 =?utf-8?B?NzdtSXRNSGpva1JrVDE4amhQSmtHelA5T0lOVm5CcngxaXZYYTlwZVQ0b1ZX?=
 =?utf-8?B?OHF5L2tMSTJNN0FsTEMwUFNWZFBTWlBuTnNvaGtJTzVoTWZsaHRuelJkdm5l?=
 =?utf-8?B?bnRHcWxOdTd3ZHVWZlE1Snl4aXN3ZG1mdlBVM0Qvcm1ZZE9sakY1TmRuWFMx?=
 =?utf-8?B?WHBDd3NxQzJNOWF3dk5Jak5YR3pDOTdQQ2tiU1RGT3VmTjBwNml3VkcxeENu?=
 =?utf-8?B?Y2dhdElmQTljSjRQa1h5SGlSRjAxdmI5OHBGTjd1dmtacExRUUE3VkRFWlc5?=
 =?utf-8?B?amVaNGZHYlM2VkF4cmJhcW5Yalk3MUFPV1FRVXkyVUJhUlJQeHdGZjBXYVpR?=
 =?utf-8?B?bmpqakowcUdZVFR4U0hIQUxTdXVUMW9mbUZIVHN5S1lES0EvbW43TG01UXgr?=
 =?utf-8?B?d3BxSUZlajFuZVlPT1JxVVkvWS9jVWxYWU1mZlhFSmtLMWdlUWsrZEVNWVVx?=
 =?utf-8?B?REU4ZW1aZGxwcDRoNlhjNk1zR1FhVTlPNHJxV2VmN2Y2bWdKOS9BeEIxQklI?=
 =?utf-8?B?R3dlclU3T0VkTVBidDVGSElpejNTa3ZwaHQxMWdkWnRiVG4xMXhNNERYcGxO?=
 =?utf-8?B?NVUyMVM0Nno5MnAwMVl0NDJNekV2NmtOYUQ0MGdDWXBCKzExUTA4eGlCUWo2?=
 =?utf-8?B?bnN3cTMxS3orYWpmaDVvSkJ6VkhFazlEZFcrK2lCU0kxQzR3NUE1S0d6RHhM?=
 =?utf-8?B?N3ZSdzZGVGdndklZODUwT1JSQXZpMjRwa3Iyem9ZZTlJQ3ZLVDVoNkhJcGFv?=
 =?utf-8?B?ZlE0TmxNRGtLYXFqc2dycHUrQXE2a2Z2bkhScUJnMEJKMWl4a1FHSmU1ZmNJ?=
 =?utf-8?Q?prvtXWX1/7c+h0Gw=3D?=
X-Exchange-RoutingPolicyChecked: rYHECXhBCmD/QwA0LiIsCUHWBeu/c8W+XSNdMigzJUUV0Dn4Rwr14dER/quL0GXXixkGk9hsqnQmGkNvpuEpA5gJHk0KZui8xHj00YlDKHtWZSqc8t5grKTn+0hPd8uusRK+gXhDMGQYVUg3UZsH9WYxJ5Y5eIzmvwsSa0/gWZx0zGhS4n/KQMhPokIpG3YkALHROlUSwShJVpJaNM9yJR6eiDQADZGQ3Wv4gzrnlnyRVILoCliHx7LGJw2N/O56C4CK5F91/Z9QtTnJUxQwaEJup1wOe4KvsVginazJk3FEvV3pe2INHb0k8gcKeBfeRWjXM93GemFqlLKyXOv/HQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: URTV/gxIxOkrLLIpRGPuNIxGsIOz9qlBA07+/kg8XG8WF+ipQOsWYf9GDpZ+FwE8uvBIDhqlHwhS3yp81IrML3kvqqolPw5e+wPrH/IZGGberWa+cFeoVXpwZMjnxsb5dwVCVrqpBvmlrCo6fl6QDRb26n6iFfncMNJKuMF94CFbeWEF/Q3n0bY/zObEwyQfGqFOm3Dyxq1OkKH8HG2Ti07d3iYE3aQl+eg24jf+cklBfDYUj+X6SOGDS1r5AJjVLuI3dvMJn3IUTwo5vr2U4KYP+n6bEjfcs51Ydn6k/pfVUHDUR+iOdephgw9n0jFAK7m0nc6aACDryoT+orWsOB9PHPq1788sMkYaGsyuB10svHkwDYY5wwyeyPh/YAWnuxxM6+jKxXkhfLvcAYYRiW3BRNsmmtDt39MbDxhJVHQ8ha8fINcAuvXyWBJcDMqsZ968ChCpzbOMhL6wbRggn5Nef7vgpQkFEnQ4R/KGR/7brGdPm+whz9CWopZH3c0mPZDxN/WcqONCeRfXfFZbFwjtr4nQFf86Y1su6rH68zQm4JnBl6IspXHeQGdEwOiyOdwGUwBtjrj6GGiB+Z98S+8Yu33fIG1lNp0aiERRyOM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d157e6-a410-46c0-fb9a-08de80861b76
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 22:24:21.1213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJN+QF8e5zsPcECRQeQEGT9/y6Eir5K256K3/TtrPSgF8SJxht/ngGTvhisEHxDVX9Jewg2jnHY1uRNeT+z/FCFJpLymYM7qp/kAeRg2jMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6055
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_03,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603120180
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDE3OSBTYWx0ZWRfX4DrKUcbvDWSN
 ntDZDA5ZuoyNESDNjO8sjguI/S2g03by0aycmByQJHKChb1QjxnS7eem74n9Dk3Iu9pmktiNnXk
 5MVmeiFrB7bxBEyCf4Zho5cMuiksNej22SgG4P0qY4ZxvXsMLiXKTihN5OlDyEOnxWkjXA4abR8
 ALSypjKuEO17G/x2Nt5+pp+iFkOD408NaZRiIqOt+x3sYrh35YBpeOtmw9MK5S+IqrVDnB1Amhv
 X4CGXBYNwIc3mNGNzlKZNNAPAuANb5bztCNkzFjG7WG6Bma1baV1iKUc2bXI3c+MjUju11Vwd4T
 /HJ0eLeytkzMaG1ZZSpBttGHuzJnDV7gK51wxa5NSD0OgxvI/9V4wQ67wn/V8lMHPKlYHyOWtGS
 uKz9qTei6lUCDbXsGcw4mgMKCY9aKw2aLUCc5Joy1z/Bsb/LJn+1enfOc6v0+WSyoQE8Wr55rGt
 J+7UA3z66Kf8U+MeoAw==
X-Authority-Analysis: v=2.4 cv=FL0WBuos c=1 sm=1 tr=0 ts=69b33d1d cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=NEAV23lmAAAA:8
 a=17FYL03jAAAA:20 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=mWpTipzVs9LgbgRjIcMA:9
 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: J1QaOeEG85P-Qq2EMkBnTudnZIAQ_adN
X-Proofpoint-GUID: J1QaOeEG85P-Qq2EMkBnTudnZIAQ_adN
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_152432_674849_64A55426 
X-CRM114-Status: GOOD (  33.37  )
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
> On Wed, Mar 11, 2026 at 1:38=E2=80=AFPM Stephen Brennan
> <stephen.s.brennan@oracle.com> wrote:
>>
>> Tao Liu <ltao@redhat.com> writes:
>> > Hi Stephen,
>> >
>> > Sorry I took some time to make modifications on v3 code. Please see a
>> > drafted v4 [1] for a preview.
>> >
>> > I followed your suggestion to let extensions declare the kallsyms
>> > symbol/btf types it needed, then during kallsyms/btf initialization,
>> > it will only resolve the declared symbol/types, thus getting rid of
>> > the hash table. Extensions now don't need to initial needed
>> > symbols/types by itself.
>> >
>> > In addition, users can specify which extensions to load at
>> > makedumpfile cmdline as:
>> >
>> > $ ./makedumpfile -d 31 -l
>> > /var/crash/127.0.0.1-2025-06-10-18\:03\:12/vmcore /tmp/out --extension
>> > amdgpu_filter.so
>> >
>> > Also "--extension" can be used several times, and amdgpu_filter.so can
>> > be an absolute path as well. If no extensions are specified, the
>> > btf/kallsyms of makedumpfile will not initialize.
>> >
>> > I don't know if this is what you wanted, or any suggestions for this?
>> > Thanks in advance!
>>
>> Hi Tao,
>>
>> Please accept my apologies for the long delay on this review.  I've gone=
 through
>> each commit with my feedback. This looks like a really excellent job and=
 I
>> think it is ready for the review of the maintainers. I've implemented my=
 own
>> userspace stack extension on top of this support, and I find it to be gr=
eat for
>> my use case as well, with one small change (adding flags for detecting w=
hether a
>> struct or member is found).
>
> No worries at all :) Thanks a lot for your detailed comments. I'm
> looking through them as well as your code branch in github. This may
> take a while...
>
>>
>> Here is some more detailed feedback on a per-commit level; it's all pret=
ty
>> minor.
>>
>> d3aee7a ("Reserve sections for makedumpfile and extenions")
>>
>> * This is just a note, but I've found that the linker script may not be
>>   necessary. GCC automatically creates the __start_SECTION and __stop_SE=
CTION
>>   symbols for sections it creates.
>
> I have tried to remove the makedumpfile.ld linker script. The
> automatic symbol as __start/stop_SECTION are only generated for
> makedumpfile, aka the main program, but not for .so extensions. This
> is a breaker because I would expect all .so files have the
> __start/stop_SECTION symbol so they can be resigtered to main program.
> I'm not expert in GCC's default behaviours, so I guess I would prefer
> the current approach of explicit symbol define within the linker
> script, seems to be more robust...  Perhaps you can share your code on
> this, I will give it a try.

The key to making GCC generate the symbols for the sections is that the
section names should themselves be valid C identifiers (i.e. they should
not start with a '.'). Here's a patch to give the idea:

From 3618f51869e978328e49f6061eae94469bca43c5 Mon Sep 17 00:00:00 2001
From: Stephen Brennan <stephen.s.brennan@oracle.com>
Date: Wed, 11 Mar 2026 09:17:05 -0700
Subject: [PATCH] Use automatically generated section start symbols

GCC will create __start_SECTION and __stop_SECTION only if the section
names are valid C identifiers. This means we cannot use a leading dot.
Drop the leading dot from the section names so we can avoid defining a
custom linker script.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 Makefile            |  2 +-
 btf_info.h          |  4 ++--
 extensions/Makefile |  2 +-
 kallsyms.h          |  2 +-
 makedumpfile.ld     | 15 ---------------
 5 files changed, 5 insertions(+), 20 deletions(-)
 delete mode 100644 makedumpfile.ld

diff --git a/Makefile b/Makefile
index 8196aa6..e2cde8f 100644
--- a/Makefile
+++ b/Makefile
@@ -113,7 +113,7 @@ $(OBJ_ARCH): $(SRC_ARCH)
 	$(CC) $(CFLAGS_ARCH) -c -o ./$@ $(VPATH)$(@:.o=3D.c)
=20
 makedumpfile: $(SRC_BASE) $(OBJ_PART) $(OBJ_ARCH)
-	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJ_PART) $(OBJ_ARCH) -rdynamic -Wl,-T,maked=
umpfile.ld -o $@ $< $(LIBS)
+	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJ_PART) $(OBJ_ARCH) -rdynamic -o $@ $< $(L=
IBS)
 	@sed -e "s/@DATE@/$(DATE)/" \
 	     -e "s/@VERSION@/$(VERSION)/" \
 	     $(VPATH)makedumpfile.8.in > $(VPATH)makedumpfile.8
diff --git a/btf_info.h b/btf_info.h
index 2a78fbf..555f21e 100644
--- a/btf_info.h
+++ b/btf_info.h
@@ -29,7 +29,7 @@ void cleanup_btf(void);
 	struct ktype_info _##MOD##_##S##_##M =3D {		\
 		QUATE(MOD), QUATE(S), QUATE(M), 0, 0, 0, 0, R, R\
 	};							\
-	__attribute__((section(".init_ktypes"), used))		\
+	__attribute__((section("init_ktypes"), used))		\
 	struct ktype_info * _ptr_##MOD##_##S##_##M =3D &_##MOD##_##S##_##M
=20
 #define INIT_MOD_STRUCT_MEMBER(MOD, S, M)			\
@@ -60,7 +60,7 @@ void cleanup_btf(void);
 	struct ktype_info _##MOD##_##S =3D {			\
 		QUATE(MOD), QUATE(S), 0, 0, 0, 0, 0, R, 0	\
 	};							\
-	__attribute__((section(".init_ktypes"), used))		\
+	__attribute__((section("init_ktypes"), used))		\
 	struct ktype_info * _ptr_##MOD##_##S =3D &_##MOD##_##S
=20
 #define INIT_MOD_STRUCT(MOD, S) INIT_MOD_STRUCT_RQD(MOD, S, 1)
diff --git a/extensions/Makefile b/extensions/Makefile
index fc28577..a4dc86a 100644
--- a/extensions/Makefile
+++ b/extensions/Makefile
@@ -8,7 +8,7 @@ amdgpu_filter.so: maple_tree.c
 userstack.so: maple_tree.c vma_rbtree.c
=20
 $(CONTRIB_SO): %.so: %.c
-	$(CC) -O2 -g -fPIC -shared -Wl,-T,../makedumpfile.ld -o $@ $^
+	$(CC) -O2 -g -fPIC -shared -o $@ $^
=20
 clean:
 	rm -f $(CONTRIB_SO)
diff --git a/kallsyms.h b/kallsyms.h
index d94830e..1989dfe 100644
--- a/kallsyms.h
+++ b/kallsyms.h
@@ -17,7 +17,7 @@ struct ksym_info {
 	struct ksym_info _##MOD##_##SYM =3D {		\
 		QUATE(MOD), QUATE(SYM), 0		\
 	};						\
-	__attribute__((section(".init_ksyms"), used))	\
+	__attribute__((section("init_ksyms"), used))	\
 	struct ksym_info * _ptr_##MOD##_##SYM =3D &_##MOD##_##SYM
=20
 #define GET_MOD_SYM(MOD, SYM) (_##MOD##_##SYM.value)
diff --git a/makedumpfile.ld b/makedumpfile.ld
deleted file mode 100644
index 231a162..0000000
--- a/makedumpfile.ld
+++ /dev/null
@@ -1,15 +0,0 @@
-SECTIONS
-{
-	.init_ksyms ALIGN(8) : {
-		__start_init_ksyms =3D .;
-		KEEP(*(.init_ksyms*))
-		__stop_init_ksyms =3D .;
-	}
-
-	.init_ktypes ALIGN(8) : {
-		__start_init_ktypes =3D .;
-		KEEP(*(.init_ktypes*))
-		__stop_init_ktypes =3D .;
-	}
-}
-INSERT AFTER .data;
\ No newline at end of file
--=20
2.47.3



>> * Otherwise, this is exactly what I was thinking!
>>
>> 102ae0b ("Implement kernel kallsyms resolving")
>>
>> * Again, this is looking very close to the design I hoped for, thanks!
>> * I'm not sure whether is_unwanted_symbol() needs to exist anymore?  Giv=
en that
>>   users opt-in to specific symbols, we don't need to filter out noisy on=
es that
>>   would waste memory. What do you think?
>
> Agreed, I can remove this function.
>
>> * Unfortunately, upstream has made some changes to the vmlinux kallsyms =
encoding
>>   in 7.0. You may want to check what we did in drgn to support those cha=
nges:
>>   https://github.com/osandov/drgn/commit/744f36ec3c3f64d7e1323a003789815=
8698585c4
>> * In kallsyms.c:
>
> Thanks for the info, I will try this and update the code in v4.
>
>>
>>   +/*
>>   + * Makedumpfile's .init_ksyms section
>>   +*/
>>   +extern struct ksym_info __start_init_ksyms[];
>>   +extern struct ksym_info __stop_init_ksyms[];
>>
>>   I'm not sure it matters, but the type here is wrong. It should be
>>   "extern struct ksym_info *" because you're storing pointers, not the a=
ctual
>>   struct. That said, the type isn't used so I don't know that it matters=
.
>
> Right, this is an error. Thanks for pointing that out.
>
>>
>> 4187b33 ("Implement kernel btf resolving")
>>
>> * The get_ktype_info() function fails if either the struct or member is =
not
>>   found. This makes sense in a lot of cases, but there are other cases w=
here we
>>   will want to use the presence or absence of a struct/struct member to =
detect
>>   which version of code to use. For example, my userspace stack code wil=
l use
>>   either maple or rbtree helper code for finding stack VMAs, depending o=
n which
>>   is available. We can't know until runtime, when we check whether mm_rb=
 or
>>   mm_mt is present.
>>
>>   One solution is to handle this at runtime. We can have a macro like
>>   "HAVE_MEMBER(S, M)" and "HAVE_STRUCT(S)", and then each extension can =
check
>>   whether for the members it expects to be present. I think the major do=
wnside
>>   to this approach is that it requires manual effort, which is likely to=
 be
>>   forgotten when writing extensions.
>>
>>   Alternatively, we could set a flag in the struct ktype_info if the typ=
e is
>>   "required" (or optional), and only fail get_ktype_info() for required
>
> Agreed, an optional flag looks better.
>
>>   structs/members. The concern with this approach is: what if plugin (A)
>>   requires a type which is not present, but plugin (B) does not? If both=
 are
>>   loaded, the failure of A would cause B not to run. I'm not sure whethe=
r we
>>   should care about that situation... I don't know if we have a use case=
 for
>>   using multiple plugins at the same time. Until we do, we probably won'=
t have a
>>   good idea whether it should be allowed for one to fail, but the other =
to
>>   continue.
>
> Great question! I have thought about this previously. I suggest that
> if plugin(A) fails, it should just fail and allow the execution of any
> later plugins (B, C....) to continue. Each plugin is responsible for
> one task, like plugin(A) for dealing with amdgpu's mm page
> filtering,and plugin(B) for Intel's and plugin(C) for NV's. Plugin(A)
> certainly will fail if one machine have no amdgpu, thus the amdgpu.ko
> will never been loaded, so related symbol/types missing. This is
> expected and shouldn't block the later plugins.
>
> But the "fail" should gentle, not like the ones as segfault, which
> will crash the entire makedumpfile program.

Totally agreed up to here! I think it makes sense for plugin failures to
be independent.

It seems like the BTF loading process should not fail if any type or
member is not found. But once we've tried to load everything, we can
then go through each plugin's list, and if we find a "required" type
or member which is not present, we log that failure and don't run the
plugin. This shouldn't be much work, because we already have all the
types in an array for each plugin.

> Since currently plugins
> are native .so libraries, the quality of code is ensured by each
> plugin authors, rather than makedumpfile maintainers. Idealy the the
> plugins are well tested in 1st kernel before they are shipped to kdump
> img, but who knows. From makedumpfile's view, do you think we need to
> introduce a sandbox to isolate plugins from makedumpfile? This would
> prevent serious plugin errors from stopping makedumpfile from
> generating the vmcore.

Personally, I don't believe we need sandbox. The plugins should be
written to handle the clear error cases:

- Optional types or symbols may not be present, so validate them.
- Values read from /proc/vmcore may not be valid, or the read may fail,
  so check all return values.

That said, I'm not set against it, so if you believe it's necessary I
could be convinced :)

Thanks again,
Stephen

>>
>>   I've implemented this second alternative in my branch.
>>
>> * Similar to the previous commit, __start_init_ktypes and __stop_init_kt=
ypes are
>>   declared as structs but should probably be declared as pointers.
>>
>> 22097b7 ("Implement kernel module's kallsyms resolving")
>> edfa698 ("Implement kernel module's btf resolving")
>>
>> * These commits are straightforward:
>>   Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>>
>> ede22e8 ("Add makedumpfile extensions support")
>
> I will address those later after reading through your code branch.
> Thanks again for your detailed comments!
>
> Thanks,
> Tao Liu
>
>>
>> * nit: the array "handlers" actually contains "handles" (no r) returned =
from
>>   dlopen(). The word handlers usually implies a function pointer or some=
thing
>>   like that, called to handle a certain situation. Maybe rename this to
>>   "handles".
>> * The run_extensions() function is called within a retry loop in
>>   create_dumpfile(). It seems possible that this could get called multip=
le
>>   times. But many of the global variables in the kallsyms, BTF, and exte=
nsion
>>   code are not safe to be cleaned up and reinitialized. In particular, w=
hen
>>   array elements are freed, the lengths, capacities, and pointers are no=
t reset
>>   to 0/NULL. I think it would be wise to make all the cleanup functions =
clear
>>   the globals, so that they may be reinitialized safely.
>> * Further, I think it might be helpful to split extension loading, runni=
ng, and
>>   cleanup. Something like this in create_dumpfile():
>>
>>         load_extensions(); /* loads everything and calls entry() */
>>     retry:
>>         /* ... create bitmap and dump ... */
>>         if (status =3D=3D NOSPACE) {
>>             /* ... */
>>             goto retry;
>>         }
>>         /* ... */
>>         cleanup_extensions();
>>         return;
>>
>>   For two reasons: (1) this avoids unnecessary work re-loading and
>>   re-initializing the BTF, kallsyms, and extensions. (Though I still thi=
nk it's
>>   safer to ensure they can be re-initialized safely.) And (2), this allo=
ws for
>>   future use of extensions in the rest of the dump operation. For my use=
rspace
>>   stack extension, I plan to add a callback which allows extensions to o=
verride
>>   the decision to filter a page, since my logic can't be easily done via=
 erase
>>   info. So the extensions need to remain loaded during the creation of t=
he
>>   dumpfile, and cleaned up after. I have tweaked this in my own patches,
>>   but I just wanted to share the use case.
>>
>> c568635 ("btf/kallsyms based makedumpfile extension for mm page filterin=
g")
>>
>> * This looks good to me!
>> * I will say that for my userspace stack use case, while the "filter_pag=
e(...,
>>   false)" mechanism for specifying pages that are retained *looks* usefu=
l, I
>>   wouldn't be able to use it because I cannot determine the PFNs for eac=
h stack
>>   VMA. Instead, I have to use the page "mapping" and "index" fields to m=
atch the
>>   VMA and determine whether the PFN falls in a range I care to save. Of =
course,
>>   just because *I* won't use it doesn't mean it's not useful :)
>>
>> 2b252ec ("Filter amdgpu mm pages")
>>
>> * I'm no expert in amdgpu, but the overall approach makes sense to me, a=
nd the
>>   helpers look good.
>>
>>
>> At a broader level, while the add_to_arr() function is useful, I do thin=
k the
>> dynamic array/vector pattern could be captured with a dedicated data str=
ucture.
>> For instance, drgn has this excellent LGPL-2.1+ header-only vector libra=
ry:
>> https://github.com/osandov/drgn/blob/main/libdrgn/vector.h
>> I don't think it is high priority or must be addressed. Nor do I mean th=
at this
>> particular implementation choice be used. It's just something to share &=
 think
>> about.
>>
>> To provide some context on my comments related to the userspace stack tr=
acing,
>> here is a branch of mine which is based on yours, that adds my userspace=
 stack
>> extension and a few tweaks:
>>
>> https://github.com/brenns10/makedumpfile/commits/stepbren_userstack_v4/
>>
>> Thank you,
>> Stephen
>>
>> > Thanks,
>> > Tao Liu
>> >
>> >
>> >
>> >
>> >
>> >
>> >
>> > [1]: https://github.com/liutgnu/makedumpfile/commits/v4/
>> >
>> > On Fri, Jan 23, 2026 at 2:43=E2=80=AFAM Tao Liu <ltao@redhat.com> wrot=
e:
>> >>
>> >> Hi Stephen,
>> >>
>> >> Thanks a lot for your quick reply and detailed information, I really
>> >> appreciate it!
>> >>
>> >> On Thu, Jan 22, 2026 at 1:51=E2=80=AFPM Stephen Brennan
>> >> <stephen.s.brennan@oracle.com> wrote:
>> >> >
>> >> > Hi Tao,
>> >> >
>> >> > This series looks really great -- I'm excited to see the switch to
>> >> > native .so extensions instead of epicc. I've applied the series loc=
ally
>> >> > and I'll rebuild my userspace stack inclusion feature based on it, =
to
>> >> > try it out myself.
>> >>
>> >> Awesome, looking forward to your feedback on the code/API designs etc=
...
>> >>
>> >> >
>> >> > In the meantime, I'll share some of my feedback on the patches (tho=
ugh
>> >> > I'm not a makedumpfile developer). This seems like the most importa=
nt
>> >> > patch in terms of design, so I'll start here.
>> >> >
>> >> > Tao Liu <ltao@redhat.com> writes:
>> >> > > This patch will add .so extension support to makedumpfile, simila=
r to crash
>> >> > > extension to crash utility. Currently only "/usr/lib64/makedumpfi=
le/extensions"
>> >> > > and "./extensions" are searched for extensions. Once found, kalls=
yms and btf
>> >> > > will be initialized so all extensions can benifit from it (Curren=
tly makedumpfile
>> >> > > doesn't use these info, we can move the kallsyms/btf init code el=
se where later
>> >> > > if makedumpfile needs them).
>> >> > >
>> >> > > The makedumpfile extension is to help users to customize mm page =
filtering upon
>> >> > > traditional mm page flag filtering, without make code modificatio=
n on makedumpfile
>> >> > > itself.
>> >> > >
>> >> > > Signed-off-by: Tao Liu <ltao@redhat.com>
>> >> > > ---
>> >> > >  Makefile            |  7 +++-
>> >> > >  extension.c         | 82 +++++++++++++++++++++++++++++++++++++++=
++++++
>> >> > >  extensions/Makefile | 10 ++++++
>> >> > >  makedumpfile.c      |  4 +++
>> >> > >  4 files changed, 102 insertions(+), 1 deletion(-)
>> >> > >  create mode 100644 extension.c
>> >> > >  create mode 100644 extensions/Makefile
>> >> > >
>> >> > > diff --git a/Makefile b/Makefile
>> >> > > index f3f4da8..7e29220 100644
>> >> > > --- a/Makefile
>> >> > > +++ b/Makefile
>> >> > > @@ -45,7 +45,7 @@ CFLAGS_ARCH +=3D -m32
>> >> > >  endif
>> >> > >
>> >> > >  SRC_BASE =3D makedumpfile.c makedumpfile.h diskdump_mod.h sadump=
_mod.h sadump_info.h
>> >> > > -SRC_PART =3D print_info.c dwarf_info.c elf_info.c erase_info.c s=
adump_info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c btf_info.c
>> >> > > +SRC_PART =3D print_info.c dwarf_info.c elf_info.c erase_info.c s=
adump_info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c btf_info.c =
extension.c
>> >> > >  OBJ_PART=3D$(patsubst %.c,%.o,$(SRC_PART))
>> >> > >  SRC_ARCH =3D arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c ar=
ch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64.c=
 arch/loongarch64.c arch/riscv64.c
>> >> > >  OBJ_ARCH=3D$(patsubst %.c,%.o,$(SRC_ARCH))
>> >> > > @@ -126,6 +126,7 @@ eppic_makedumpfile.so: extension_eppic.c
>> >> > >
>> >> > >  clean:
>> >> > >       rm -f $(OBJ) $(OBJ_PART) $(OBJ_ARCH) makedumpfile makedumpf=
ile.8 makedumpfile.conf.5
>> >> > > +     $(MAKE) -C extensions clean
>> >> > >
>> >> > >  install:
>> >> > >       install -m 755 -d ${DESTDIR}/${SBINDIR} ${DESTDIR}/usr/shar=
e/man/man5 ${DESTDIR}/usr/share/man/man8
>> >> > > @@ -135,3 +136,7 @@ install:
>> >> > >       mkdir -p ${DESTDIR}/usr/share/makedumpfile/eppic_scripts
>> >> > >       install -m 644 -D $(VPATH)makedumpfile.conf ${DESTDIR}/usr/=
share/makedumpfile/makedumpfile.conf.sample
>> >> > >       install -m 644 -t ${DESTDIR}/usr/share/makedumpfile/eppic_s=
cripts/ $(VPATH)eppic_scripts/*
>> >> > > +
>> >> > > +.PHONY: extensions
>> >> > > +extensions:
>> >> > > +     $(MAKE) -C extensions CC=3D$(CC)
>> >> > > \ No newline at end of file
>> >> > > diff --git a/extension.c b/extension.c
>> >> > > new file mode 100644
>> >> > > index 0000000..6ee7f4e
>> >> > > --- /dev/null
>> >> > > +++ b/extension.c
>> >> > > @@ -0,0 +1,82 @@
>> >> > > +#include <stdio.h>
>> >> > > +#include <stdlib.h>
>> >> > > +#include <string.h>
>> >> > > +#include <dirent.h>
>> >> > > +#include <dlfcn.h>
>> >> > > +#include <stdbool.h>
>> >> > > +#include "kallsyms.h"
>> >> > > +#include "btf_info.h"
>> >> > > +
>> >> > > +static const char *dirs[] =3D {
>> >> > > +     "/usr/lib64/makedumpfile/extensions",
>> >> > > +     "./extensions",
>> >> > > +};
>> >> > > +
>> >> > > +/* Will only init once */
>> >> > > +static bool init_kallsyms_btf(void)
>> >> > > +{
>> >> > > +     static bool ret =3D false;
>> >> > > +     static bool has_inited =3D false;
>> >> > > +
>> >> > > +     if (has_inited)
>> >> > > +             goto out;
>> >> > > +     if (!init_kernel_kallsyms())
>> >> > > +             goto out;
>> >> > > +     if (!init_kernel_btf())
>> >> > > +             goto out;
>> >> > > +     if (!init_module_kallsyms())
>> >> > > +             goto out;
>> >> > > +     if (!init_module_btf())
>> >> > > +             goto out;
>> >> > > +     ret =3D true;
>> >> >
>> >> > I feel it would be good practice to load as little information as i=
s
>> >> > necessary for the task. If "amdgpu" module is required, then load k=
ernel
>> >> > kallsyms, BTF, and then the amdgpu module kallsyms & BTF. If no mod=
ule
>> >> > debuginfo is required, then just the kernel would suffice.
>> >> >
>> >> > This would reduce memory usage and runtime, though I don't know if =
it
>> >> > would show up in profiling. The main benefit could be reliability: =
by
>> >> > handling less data, there are fewer chances to hit an error.
>> >>
>> >> OK, I agree, mandatory kernel btf/kallsyms info + optional kernel
>> >> module btf/kallsyms info is a reasonable design. So kernel modules'
>> >> info can be loaded on demand.
>> >>
>> >> >
>> >> > > +out:
>> >> > > +     has_inited =3D true;
>> >> > > +     return ret;
>> >> > > +}
>> >> > > +
>> >> > > +static void cleanup_kallsyms_btf(void)
>> >> > > +{
>> >> > > +     cleanup_kallsyms();
>> >> > > +     cleanup_btf();
>> >> > > +}
>> >> > > +
>> >> > > +void run_extensions(void)
>> >> > > +{
>> >> > > +     DIR *dir;
>> >> > > +     struct dirent *entry;
>> >> > > +     size_t len;
>> >> > > +     int i;
>> >> > > +     void *handle;
>> >> > > +     char path[512];
>> >> > > +
>> >> > > +     for (i =3D 0; i < sizeof(dirs) / sizeof(char *); i++) {
>> >> > > +             if ((dir =3D opendir(dirs[i])) !=3D NULL)
>> >> > > +                     break;
>> >> > > +     }
>> >> > > +
>> >> > > +     if (!dir || i >=3D sizeof(dirs) / sizeof(char *))
>> >> > > +             /* No extensions found */
>> >> > > +             return;
>> >> >
>> >> > It could be confusing that makedumpfile would behave differently wi=
th
>> >> > the same command-line arguments depending on the presence or absenc=
e of
>> >> > these extensions on the filesystem.
>> >> >
>> >> > I think it may fit users' expectations better if they are required =
to
>> >> > specify extensions on the command line. Then we could load them by
>> >> > searching each directory in order. This allows:
>> >> >
>> >> > (a) more expected behavior
>> >> > (b) multiple extensions can exist without all being enabled, thus m=
ore
>> >> >     flexibility
>> >> > (c) extensions can be present in the local "extensions/" directory,=
 or
>> >> >     in the system directory
>> >>
>> >> Sure, it also sounds reasonable. My original thoughts are, user
>> >> customization on mm filtering are specified in .so, and if user don't
>> >> need one .so, e.g. amdgpu mm filtering for a nvidia machine, then he
>> >> doesn't pack the amdgpu_filter.so into kdump's initramfs. I agree
>> >> adding extra makedumpfile cmdline option to receive those needed .so
>> >> is a better design.
>> >>
>> >> >
>> >> > > +     while ((entry =3D readdir(dir)) !=3D NULL) {
>> >> > > +             len =3D strlen(entry->d_name);
>> >> > > +             if (len > 3 && strcmp(entry->d_name + len - 3, ".so=
") =3D=3D 0) {
>> >> > > +                     /* Will only init when .so exist */
>> >> > > +                     if (!init_kallsyms_btf())
>> >> > > +                             goto out;
>> >> > > +
>> >> > > +                     snprintf(path, sizeof(path), "%s/%s", dirs[=
i], entry->d_name);
>> >> > > +                     handle =3D dlopen(path, RTLD_NOW);
>> >> > > +                     if (!handle) {
>> >> > > +                             fprintf(stderr, "%s: Failed to load=
 %s: %s\n",
>> >> > > +                                     __func__, path, dlerror());
>> >> > > +                             continue;
>> >> > > +                     }
>> >> > > +                     printf("Loaded extension: %s\n", path);
>> >> > > +                     dlclose(handle);
>> >> >
>> >> > Using the constructor/destructor of the shared object is clever! Bu=
t we
>> >> > lose some flexibility: by the time the dlopen() returns, the constr=
uctor
>> >> > has executed and the plugin has thus executed.
>> >> >
>> >> > What if we instead use dlsym() to load some symbols from the DSO? I=
n
>> >> > particular, I think it would be useful if extensions could declare =
a
>> >> > list of symbols and a list of structure information which they are
>> >> > interested in receiving. We could use these lists to know which
>> >> > kernel/module kallsyms & BTF we should load. We could even load the
>> >> > information into the local variables of the extension, so the exten=
sion
>> >> > would not need to manually load it.
>> >> >
>> >> > Of course this is more complex, but the benefit is:
>> >> >
>> >> > 1. Extensions can be written more simply, and would not need to man=
ually
>> >> > load each symbol & type.
>> >> > 2. We could eliminate the hash tables for kallsyms & BTF, and elimi=
nate
>> >> > the loading of unnecessary module information. Instead, we'd just
>> >> > populate the symbol addresses, struct offsets, and type sizes direc=
tly
>> >> > into the local variables which request them.
>> >>
>> >> It is a clever idea! Though complex for code, I think it is doable.
>> >>
>> >> >
>> >> > Again, while I don't want to prematurely optimize -- it's good to a=
void
>> >> > loading unnecessary information. I hope I've described my idea well=
. I
>> >> > would be happy to work on an implementation of it based on your pat=
ches
>> >> > here, if you're interested.
>> >>
>> >> Thanks again for your suggestions! I got your points and I think I ca=
n
>> >> improve the code while waiting for maintainers ideas at the same time=
.
>> >> I will let you know when done or encounter blockers if any.
>> >>
>> >> Thanks,
>> >> Tao Liu
>> >>
>> >> >
>> >> > Thanks,
>> >> > Stephen
>> >> >
>> >> > > +             }
>> >> > > +     }
>> >> > > +out:
>> >> > > +     closedir(dir);
>> >> > > +     cleanup_kallsyms_btf();
>> >> > > +}
>> >> > > \ No newline at end of file
>> >> > > diff --git a/extensions/Makefile b/extensions/Makefile
>> >> > > new file mode 100644
>> >> > > index 0000000..afbc61e
>> >> > > --- /dev/null
>> >> > > +++ b/extensions/Makefile
>> >> > > @@ -0,0 +1,10 @@
>> >> > > +CC ?=3D gcc
>> >> > > +CONTRIB_SO :=3D
>> >> > > +
>> >> > > +all: $(CONTRIB_SO)
>> >> > > +
>> >> > > +$(CONTRIB_SO): %.so: %.c
>> >> > > +     $(CC) -O2 -g -fPIC -shared -o $@ $^
>> >> > > +
>> >> > > +clean:
>> >> > > +     rm -f $(CONTRIB_SO)
>> >> > > diff --git a/makedumpfile.c b/makedumpfile.c
>> >> > > index dba3628..ca8ed8a 100644
>> >> > > --- a/makedumpfile.c
>> >> > > +++ b/makedumpfile.c
>> >> > > @@ -10847,6 +10847,8 @@ update_dump_level(void)
>> >> > >       }
>> >> > >  }
>> >> > >
>> >> > > +void run_extensions(void);
>> >> > > +
>> >> > >  int
>> >> > >  create_dumpfile(void)
>> >> > >  {
>> >> > > @@ -10884,6 +10886,8 @@ retry:
>> >> > >       if (info->flag_refiltering)
>> >> > >               update_dump_level();
>> >> > >
>> >> > > +     run_extensions();
>> >> > > +
>> >> > >       if ((info->name_filterconfig || info->name_eppic_config)
>> >> > >                       && !gather_filter_info())
>> >> > >               return FALSE;
>> >> > > --
>> >> > > 2.47.0
>> >> >
>>


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62585C5DF7D
	for <kexec@archiver.kernel.org>; Mon, 17 Aug 2026 19:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:References:In-Reply-To
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aASJdX/XcQ/dlOLj7i0VI98xd+Au3Hv3lQEci2pRcZA=; b=QYIeWfSq8PfRGxXmhncnbluJL4
	jH1LZfMDz0J/1IL16rVM0WTY0lPAX8ID8Dui9iZSKX5Ly2IQJXbNFQy8v+TCpQiPfTlYFia+HY2X/
	7MGvzEKGpMV/N0QoT7n64FZ7u5YpAMyxcJhsn3YkdLDpGmEvz4eKW0JKH2Q0KonBSYJ9NBSfRF2Qb
	iZroDMepfjyWXix5OILnDTjRxpGgme++rymD84+CuvTfx1PmDf8+xnGooalxATu4CM5QFhTR/seQf
	SQZTTbqqeRXodplW50HvNpWYoFqPJ5MxLq8ECnA8TsXjCgjGMYoTyJ9PyXlPM4/9fq9j4r9z3XdDU
	UGLLe3uA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ww3UC-00000006kuQ-1tLb;
	Mon, 17 Aug 2026 19:59:08 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ww3U8-00000006ktB-0Jg1
	for kexec@lists.infradead.org;
	Mon, 17 Aug 2026 19:59:07 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HFe6Aa2038303;
	Mon, 17 Aug 2026 19:59:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=aASJdX/XcQ/dlOLj7i0VI98xd+Au3Hv3lQEci2pRcZA=; b=
	q4Qj1GTn9HnHK4RoMu0JAaBXhS//2CgtjXiJiE0veOnj/T9hIxRjZTsDHgArYtuV
	R6rmmuGCBAG9l9C9ys23ICXQttvIsb/t8fo5l5h2/BbuJO3/1kkehzy7tGUPwAYK
	myOVZyuLaloH4ZA7zIm10NHGMgA4FEYtYQduFXmbFWewQbZ26Uuja2QDOr+SbsAg
	wsfj8OskjnXD7aObvTOp6pcWBVLp6Ys4aarjH3av8WJ5ae5q+Kk0wBSvziVanOGI
	k6RS6gzbLAlT5mvGiNmXat0UTnqkXiKHKEG8agTtloh0eTuR4WYLXJ3wxQqB9Db8
	91hUCY5RZQJvogNSMUFY4A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g2g5cb2ae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 19:59:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67HJjYb7018163;
	Mon, 17 Aug 2026 19:59:02 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013041.outbound.protection.outlook.com [40.93.201.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4g32hpyejt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Aug 2026 19:59:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0OdyDJywwxLXrTLJ6n7OXKI3qfVDKyWo2ftF93kFALMLAeinuI77Vrn+v2CZZDKxUSJP+vBLuFOcnCHCDlhxgOwg/NBaEmvslFa77oZlYX4SciZqtULSvukhjXlwU4B5hO6Oo9Rq+QUSHUcF0+VhPoycpozBgSjfoX6sIJW8kuK9gnV6NT46qxAMHGx9q4myILWIPaDbknAItYuIF0XhamS0FnasmA548AcegA0IweuEORY53Cmckshm1izd93Pn51Z8EVYocdSNtP+wLXe1cEQkzNPKwA6UXYDl49qAdf9FgbLjef5vVKleWgm1oKMQSQiqIhEG4p7C+g1QJSD8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aASJdX/XcQ/dlOLj7i0VI98xd+Au3Hv3lQEci2pRcZA=;
 b=Lq+N7CdZpZ5oVqxd9t+1rf/nY9iNC4rp9hWhWKK0dirg/Jo/d4WjFoALcvngPn+S4JhTe8eqIozSNEjaBv2ztLm3y8hSVb81tcz3oUTQEry/sRteNfFklEyNZDp3xnNYmDGykD3snTKZtX6k2I9uW8f09yNonK1wHNpJiqq7f2FN+AzVM50aQWQta8VX4of7tlfxWJV0TN27v3yHnI8lP5C/gz86uHAgRTzZ57DDzL05TfXUqnCwRuSJRFDgpIE0igLfjrFaWpX6qMNLKSqrFNDaE0NSLstVmeLdWZaik3LU5CUhxtBgSSKYGIRuyXf+8Nq7CIqlX5MNG4SztX0JwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aASJdX/XcQ/dlOLj7i0VI98xd+Au3Hv3lQEci2pRcZA=;
 b=KqG1NGA0wWvCAQmvQYkPHVZXH4V/X8kMJvLmK2VQ+lugbYgWoKlmXQRJGASauXAVEMmB+3it+MbVAR/LLOhtiDZboJ+onRx2zJUmNF3bs/IJa4+Irkn52Hv0W6M0A45Wt//Z/Rn+b+o4KkNdb05xRIQY1Dg/Kn4mLd2LHjdq5rg=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by CH3PR10MB7716.namprd10.prod.outlook.com (2603:10b6:610:1ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 19:58:58 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 19:58:58 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Tao Liu <ltao@redhat.com>,
        =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IA==?=
 =?utf-8?B?5LiA5LuBKQ==?= <k-hagio-ab@nec.com>
Cc: =?utf-8?Q?YAMAZAKI_MASAMITSU=28=E5=B1=B1=E5=B4=8E_=E7=9C=9F=E5=85=89?=
 =?utf-8?Q?=29?= <yamazaki-msmt@nec.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH makedumpfile 4/9] Introduce a stat for pages retained by
 extension
In-Reply-To: <CAO7dBbU1AmQS6nh8OLGnB=tDw62NNsOEwodYc1_RQhP7qjteYw@mail.gmail.com>
References: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
 <20260714004550.3698175-5-stephen.s.brennan@oracle.com>
 <an0opyG2YuUD-Gez@localhost.localdomain>
 <429278f7-c1ad-4192-a9e3-9d765aa1fddf@nec.com>
 <CAO7dBbU1AmQS6nh8OLGnB=tDw62NNsOEwodYc1_RQhP7qjteYw@mail.gmail.com>
Date: Mon, 17 Aug 2026 12:58:56 -0700
Message-ID: <87bjb0cydb.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PH7P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::31) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|CH3PR10MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: fe780fc8-5f43-468e-13a9-08defc99f98d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|56012099006|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: HkefM7Mnw6byVEnjNV2YzrHlqY6S+fBwallqNWpdvNpZL7sPkf4V5qjxgLt2AH48Y3tVWwSQVjugiPUz2xbiNFAF0xOXEy0bmtypgcKFfpvSyZfThUhUiJnAjvOW0n5BxUnxxpDs471YmqzwlZFCTkPEYmsIxeQO85QPhPlyCymWd+5IaRBPKzpwqwht3a+F69Wovn671zCcu11h+drqH1I0X14POlEWnIHSQ8Ad5uUNfWweHnx4Y0jIFNOy8W7LzcuqixvdEiJe9ittqeijA5jaygqxuUn4hby89cmFypzzFOsexL9726G27vm5watjFfjKRvuv1wXsJXAlD5fYqEpK2W8NyMnjwf0IlncJKcXjn814eHhO+7mIAYtBDGqCuBUUsMRh2+z5Tg57uWmFYuVBzn5DWrYvA1NjWTNRNGdRCbwIrOR/1iA9v3/xsz0U+/yk1bQLaNBV60Mqrf+SpBzzTOOERG6tkFnmpVKfuxOPSdEVywfJhAPfwOGLlV56lQjXp2cROTgHGr337SW2R27eZWPSklDhuN3GWg+PWej1g+k7lUQ49wCEP+tD1qVBRIT9DnlOyvO1JritwHH4JPRIbSDkJZU6GDR6La8cdPv4lG5R27VKzwBY/23c81Ae1gmuTAHzS5Yo3KUEbYKmSP4SAZPJkx9qtfVHwlWhnSY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVJRR3pTQ2ZXNzFXcjZXNVl3WHgyMTlsUlJDSHFzM3RhRDJCZUljQ2FlYmF1?=
 =?utf-8?B?WXg5aUdSbCtSZi9pazF3cUNKM0JJODRIRzY3LzVVcW9VakdUbXdtVGJXWllZ?=
 =?utf-8?B?a0xxeHRoVjRSTEJXTmI3UzJYTUtUUEhERkZiSk0xVWVMS2t1WThOUWp4ZjJZ?=
 =?utf-8?B?Z2E1Q3BBSGZaOUp6ak44N093T1NPYm5sOVNlN0lId2RZckNmaENwV3NuVXY0?=
 =?utf-8?B?c3h0YXZsd2hiYStQWWtoYUlnN0tIK296T0ZsNG5SclY1UEV1WGtKa1daQTMz?=
 =?utf-8?B?SEVFMHFNU0VqelYrMm5ocEU3UHlFNVVOaXVBTytLdUtpS1dqd2hBdkZmeFAw?=
 =?utf-8?B?eXFTVDBuTzluVUJwUStPTHZUS0FiSGtzc3FnMGVYWnZuT0sxeFRXQVJlc2R1?=
 =?utf-8?B?cDJkMzBWQnhPZi8vV1NaSFB2MTVUZDh1K2NsMWZHNjc1K1JMRmdwS1JPbjFk?=
 =?utf-8?B?blJWWXNRSUZQaEdpdlBnaGRzd1c2NGdYTGxtN25RVHFtVEptQ2RFWXdIaWk0?=
 =?utf-8?B?MHNNOGRaOTFubDJTVjAvTHVXRXk5UUcwUXNZZk5mTlpzanJyMUVJajRESloz?=
 =?utf-8?B?MHBJMk9nNGNoU3ZWRnlzMGhxRGpTQnN2eDFtelZLTWgyZ2hkVFk0YytYWkcz?=
 =?utf-8?B?cGYxTTUxWm9RNldYL1BpU0NJQjROdEEwSURmVEJTUW1lMzRHelNkby83eGdt?=
 =?utf-8?B?eU9OdFo0cFZIQ3U2UmcrMjFGQnJHaXcySjZ6bno2cGU3a3JkTXIzV25TbmtX?=
 =?utf-8?B?bndQdlcrQ3kyNnc1WTV3UzAxV2RRM3BoUnQyV3NBZVRrdC9PazFlSTNqMlBQ?=
 =?utf-8?B?aE9mSmF2b0tUVU5CSm1ZVUNYNzRlYmV0dW40Q1pFT3N4anVGaFFsQ0tNUWIr?=
 =?utf-8?B?TWVWRGo5VW52d1g4QVlzS1MwQU1hcVlrSnJMREpZY1pVWjB2VUpZMnRiRHht?=
 =?utf-8?B?b016ZGx4U1Q3NTBpcjBZTXhQY2oyeGNyZ2NlMHQ4bXFleE1jNExid09SQ1l3?=
 =?utf-8?B?NmFFQXpxRTc0cFlDWTk3WHl6VW80cGQxaUZCMFhXZDkreUlwRmNjNEdROExn?=
 =?utf-8?B?QzBuY29Icm5tQ0xXbFVuejlqNGpwZFUxNUc1cnR4WHNWVmhTa0ZGZ0ZQeFRJ?=
 =?utf-8?B?YnZ6eUFKSjBvZDZTS3RGNG9EV1NyYzBaVVNNdk5zZWtGNDVidW1NMHZaSGFl?=
 =?utf-8?B?U1ljcnRXUlFRZDdhM1VZNzhlckNuazVUaVF6V3VsWS9CbHF3UUtNMk1TOWRT?=
 =?utf-8?B?ZVBWYlg3VXdsNjBIeCs5bnJhL1R5RG1aUmJ6dTI5czZ3R2lpTVNFRVc5dUFN?=
 =?utf-8?B?QWtuRzcyTDVEZFMrM0xrUURKNTBJRE1MTHJhWlFBdm5qTkdkZDIvYlZub3hE?=
 =?utf-8?B?RC9LVW4wZkUxM3h0d2JmQml6cUNMOGE0L3dMWUtQUWo5NTdva0NYZzNnT29C?=
 =?utf-8?B?RlNvWElsWjhaL3hrRWNCWThGblEwQk1RQkdDUHJOcnR5UW1uVUp6cjhpMzhC?=
 =?utf-8?B?NngyZW81V3BjSUMvaGY3NXRycmwzQkZ2MHl6RWFtT2dpb24yNGkzRHNQdUlZ?=
 =?utf-8?B?TS80TjBIYnB3dHVuVGF2dkJ0M2VQZUZPYmRURUxRaTh6SFlqNHE1OTV6Y0lz?=
 =?utf-8?B?Ri9VVE13KzZwQ3lFcHRVM2FneGlXYVBnNXJFdW5pbGk3akZyZHhydlZjbjQ3?=
 =?utf-8?B?dDUrZ1NNNWgzems3MDdtWjE4VHA2Z2J3RVRSNVVteHFEWTlmbFhwRU00OVc1?=
 =?utf-8?B?NGtEUVVOVGljYm5xNm9ZQVlIUFVxcXJxb2JkUGI1ZmgxWERaWk5TSWFrTlh1?=
 =?utf-8?B?Nks0ZzJ3bTc0WDNOTzhFSmtXVmd1dDA0RmYvbjZ0K2M4cy9JQ3d5aFRxK2NS?=
 =?utf-8?B?YzBOcHdSMkhpTWdhazJINGFqam5KNjFDV0s2dDlRM0pjVzFESzdoZWRkek9X?=
 =?utf-8?B?SmNhUnNWcnl0SU9KMDMxMkRqdk4zNVFXS0VrYlJEdnNWOWlvUmk5MmtrVVdS?=
 =?utf-8?B?YXROMmh6M2FlLys1UWdVYjVYVlhpM28zMmxEZHB5eXJzeUNFV2YrNWVvNDVW?=
 =?utf-8?B?QmNRaFcxSi85NXUwQS9FeGtlck5KRjV6ODY5Rm0yYW9XMGIvV2JrOHNQaEhG?=
 =?utf-8?B?UTE5akxSZlh5UTBIWmVXNnFyMFdveTg2TDI4WVhDN09LY0szTXk5emp3UUNr?=
 =?utf-8?B?OWJLNTd3TWw5R2dFdEtndHV5bGw0VUVVb2ZkZENCcWlCRlNpeVVUc1BCbVgy?=
 =?utf-8?B?VUhvZVFOb0dVeGtoME5UK0pWWTQ2SzI4WHFCWmM0Y1ZuWDRsZHJoTWUyY2tJ?=
 =?utf-8?B?TlVzOStJSGY0VDlEeGI3TFVOcFZYNEpxVVhnVDFlRmdVOVhrNGVncTRQV3VF?=
 =?utf-8?Q?H8mPwEtaegkf8yJ0=3D?=
X-Exchange-RoutingPolicyChecked: fMMBG5KxogE81fbHEEGUfThhwH/5SIe9HSaQFD5k63Uvo4y1qSCCeg+eJQwKb6NmNZEOOmHP6ZOu4lYj1/DnP1LWb6TI8VLCvk1uYOLX3c0OGyQu+Q49x1Im4m1gIU+najpzCiG8O2lBWDsSHH5Fce/uGp0f83Yxan6gk0zg0V1LKIekYGyIE5DvFJsC94IvvgCFAQO87ROvTSIkSfql5X9G533LuGR9lylKvj/FJvHD1P5L+fsCVU4TDqCjwRZ2yykFGmmmCWhkWKav5jbjLuii5zsv3KdLfdIrxWmW+577SS31r97yry1RLVqlrqs93Ncjmqkz8VV49NVcmsLQ9Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UitKle/IdbZ0GqSwF6V31KMuwSf3LM7gTDaag/f5pbZO5JXvzPgUDxSNIj93vrtFdC9UsQzMkoSehBFxQtbRoPfc+6keW8FHAROI2qCtB4SoE0lV+r4/C/KIDhMEDUV61LLS6vUlpEr4eSwnlvXhUhhGrrBIrtQaFljx9AcWURr/+qdhGqhsNCn9a7JccuujMy/Hh+CuxQrWYuEWhp09AAfseLpNTNFdeG/utuiyspd2Di6hqf1S9YmpRyUr598+RFi6QP8Fo0X1JjhhhEUtDICx+UvZLJnVtYKeqzIhu3IPq0MQkt8p8+8YPkIpwneXBbyDE+I3w4q4UHO7msnXEBIcd8jNcKYbusks2h8BjPw+LpclITwtCIgGj/kuc4tLR/9341BSgKgzffOuaWgHU535198681tM3EMGo6rNBPnpUJw+h+bU0Rf2PzUQHM4OqnmbowFGi+rj+1s2Ewi2By1iEt/owRsn5j62Dfr4JAnzShUPRJK+s564vrnqeDvdZdJ+b0DONRKP6J27zmLSYF+OCmph8i8GFHAja8a+qLn4YcTswOWdAeYZW5i8S4EbyIg2yY+JVN+QBazYe+EPA+Bq/9szDInAstLo60oKh44=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe780fc8-5f43-468e-13a9-08defc99f98d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 19:58:58.2754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOvICzlwwt8cZLGQmXAroa4SOHpxtDdgEAlpdFyMYkITNX2+RcmsYaVE7EuhOcv7PcG7BqwyJbmYKatZvAffiaI0885i4BabZhc5Emn8F9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 suspectscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608170151
X-Authority-Analysis: v=2.4 cv=INoyzAvG c=1 sm=1 tr=0 ts=6a836806 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=NEAV23lmAAAA:8
 a=20KFwNOVAAAA:8 a=nrACCIEEAAAA:8 a=yPCof4ZbAAAA:8 a=omT_IQ_8nfp6v0NgZ64A:9
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12099
X-Proofpoint-GUID: Hk7T5buR7jIkBEniiPcLNeWjCb8MjNHo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE1MiBTYWx0ZWRfX5FSszc0aupjh
 +c391acUDXMJZoYweTzV4sdUCSvUL1BUlpbWiy94TB3//Bdim4THu7VJN5aBGTGIFhfDR3W8fVW
 bNoTk59fhqu5RZ4Yw3F2z5HLg4zzfif/DNbFsXW6UlU8kruxWaxDqFk5AypslUxJhJDaCeJE7He
 YiMWeCThPbADHjkfYvN/V1ZOXLuCvV5+70G8Nj4SQxOAcFNQihHCvMAR2/+qLprVXn8eZnmYfIK
 tcQ9o2uz4n+MoCnwMYZhqbPMGbNe4eJNH5JKrYPQU6syY47gmrzVDegN97AY2UxI69uP/mYBthr
 pLF1ZyDEu09ajMFoGDZI+xwARyEUAOOy+VYrMQTS5f3bcJNvcEPtP/tKY3mTs7PvRWX6f1r1f52
 6p6n+M7K/TjRhDNJ0GePioXOpslNJBvWw1IUrppsnf/2elULiAo0fJ8rroW3wDazbo8aliuHPA7
 rmS8KJR/3cQd7aIZeqKnDtZLn6h51oPOA7hiiRoY=
X-Proofpoint-ORIG-GUID: Hk7T5buR7jIkBEniiPcLNeWjCb8MjNHo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE1MiBTYWx0ZWRfX7J8QWEwsb60p
 PvS02zVcu+uQLod1Zv6Rle7A/h1lEnoAYIGg3vDlEjtKdlM3L/4NcUzWlbmBbKFU9L/5/58w4RK
 ByiK1uQjBcY3hFVNL4SKOh3N7eC1jUEYqin+fJWEcNLM6d5aln3+
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_125904_461482_5F731ED7 
X-CRM114-Status: GOOD (  18.53  )
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

Hello Tao, Kazu,

I apologize for not responding on this patch's review sooner.
Thank you both for reviewing carefully.

Tao Liu <ltao@redhat.com> writes:
> Hi Kazu,
>
> On Thu, Aug 13, 2026 at 4:54=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=
=E3=80=80=E4=B8=80=E4=BB=81)
> <k-hagio-ab@nec.com> wrote:
>>
>> On 2026/08/13 11:15, Tao Liu wrote:
>> > Hi Stephen,
>> >
>> > On Mon, Jul 13, 2026 at 05:45:37PM -0700, Stephen Brennan wrote:
>> >> Extensions can mark pages to be excluded, but those pages may already=
 be
>> >> excluded due to the dump level. We have a statistic to count pages
>> >> excluded by extensions. It counts only pages which were excluded beca=
use
>> >> no other criteria excluded them.
>> >>
>> >> Extensions can mark pages to be retained, but there is no statistic t=
o
>> >> count them. Adding a counter to the code as-is would not give us the
>> >> value that we care about. Just as above, pages marked for inclusion m=
ay
>> >> have been included anyway due to the dump-level configuration. The mo=
st
>> >> useful statistic is the one that tells us how many pages were include=
d
>> >> by the extension, which would not have been included otherwise.
>> >>
>> >> Introduce a statistic that counts this amount.  To do so, we have to
>> >> skip the short-circuit evaluation when PG_INCLUDE is returned. This
>> >> seems like a worthwhile trade-off, since the dump-level checks are al=
l
>> >> reasonably efficient.
>> >>
>> >> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>> >> ---
>> >>   makedumpfile.c | 13 +++++++++++--
>> >>   1 file changed, 11 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/makedumpfile.c b/makedumpfile.c
>> >> index a4c9bbf..cf6a38f 100644
>> >> --- a/makedumpfile.c
>> >> +++ b/makedumpfile.c
>> >> @@ -106,6 +106,7 @@ mdf_pfn_t pfn_elf_excluded;
>> >>   mdf_pfn_t pfn_extension;
>> >>
>> >>   mdf_pfn_t num_dumped;
>> >> +mdf_pfn_t num_extension_retained;
>> >>
>> >>   int retcd =3D FAILED;        /* return code */
>> >>
>> >> @@ -6638,8 +6639,6 @@ check_order:
>> >>               * makedumpfile extensions
>> >>               */
>> >>              filter_pg =3D run_extension_callback(pfn, pcache, &i);
>> >> -            if (filter_pg =3D=3D PG_INCLUDE)
>> >> -                    continue;
>> >>
>> >>              /*
>> >>               * Exclude the free page managed by a buddy
>> >> @@ -6722,6 +6721,13 @@ check_order:
>> >>              else
>> >>                      continue;
>> >>
>> >> +            if (filter_pg =3D=3D PG_INCLUDE) {
>> >> +                    /* Account pages which would have been excluded,=
 but were
>> >> +                     * retained by an extension. */
>> >> +                    num_extension_retained +=3D nr_pages;
>> >> +                    continue;
>> >
>> > Maybe I'm wrong, from the code we are trying to retain nr_pages, don't
>> > we need to do
>> >                       pfn +=3D nr_pages
>> > to update the pfn of the next for-loop?
>>
>> Thank you for your review, Tao.
>>
>> The current code below does not use nr_pages to skip tail pages to be
>> retained, so I think this patch's code matches this.
>>
>>                  /*
>>                   * Unexcludable page
>>                   */
>>                  else
>>                          continue;
>>
> After rethinking, I guess both ways work:
>
> 1)
> if (filter_pg =3D=3D PG_INCLUDE) {
>   num_extension_retained +=3D nr_pages;
>   continue;
> }
> Then in the next for-loop, all the tail pages(for-loop nr_pages times)
> will hit continue:
> if (i.compound_head & 1)
>   continue;
> so all pages are kept within vmcore.
>
> 2)
> if (filter_pg =3D=3D PG_INCLUDE) {
>   num_extension_retained +=3D nr_pages;
>   pfn +=3D nr_pages
>   continue;
> }
> Then in the next for-loop, all tail pages are skiped(only for-loop 1 time=
).
>
> The effect is the same, all the nr_pages are hit by continue, so all kept=
.

Yes, as you noted in (1) the current design is that we detect compound
tail pages near the beginning of the loop, so we don't need to adjust
pfn. (For option (2), both mem_map and pfn must be adjusted, and they
must be incremented by (nr_pages - 1), not nr_pages. We must be really
careful when skipping the loop forward or else we corrupt the vmcore,
which is why I relied on option (1) in this patch.)

>> (Retained tail pages will be skipped at compound_head check.  If we
>> change this behavior, a separate patch would be preferable.)
>>
>> But on the other hand, if we set nr_pages to 1 when PG_EXCLUDE,
>> extensions cannot exclude tail pages?
>>
>>                  else if (filter_pg =3D=3D PG_EXCLUDE) {
>>                          nr_pages =3D 1;
>>                          pfn_counter =3D &pfn_extension;

Hi Kazu,

Yes, I agree this is a problem. if PG_EXCLUDE sets nr_pages =3D 1, then
extensions cannot exclude tail pages.

We could drop this "nr_pages =3D 1" line here. But I think this could be
more completely fixed by Tao's approach below.

> In fact, I didn't consider the case of compond pages when implementing
> makedumpfile extension. My original thought was, makedumpfile pass
> information of page one-by-one to extensions, allowing the extension
> to decide whether to keep or discard it. Thus the filtering logic for
> makedumpfile would be much simpler.
>
> Extension however, check page type(compound page or normal page) by
> itself. E.g. if it want to exclude a compond page:
>
> makedumpfile:
>
> for (pfn;;pfn++) {
>   run_extension_callback(pfn, pcache, &i);
>   ...
> }
>
> extension_call_back:
> if ((check_page_type(pfn, pcache, page_info)) =3D=3D compond_page) {
>     record_compond_range(pfn, pfn + nr_pages);
> }
> if (pfn within compond_range) {
>   return PG_EXCLUDE;
> }
>
> In this way, I guess we even don't need to introduce PG_INCLUDE_HEAD
> to makedumpfile, because it will be the same as PG_INCLUDE.

Yes, I thought this was your intention. But the current code (prior to
this series) doesn't respect tail page decisions, as described in the
Patch 1 body. The current code makes decisions by compound page, not by
individual PFN.

It is possible to handle each PFN in the way you suggest. It makes the
extension API simpler and more flexible, but it makes
__exclude_unnecessary_pages() more complex:

1. We need a special case in the middle of the loop to handle
   excluded/included compound tails. In this special case, we need
   special bookkeeping to ensure we decrement the correct PFN counter
   for PG_INCLUDE pages which were previously excluded.

2. Pending multi-page exclusions at the beginning of a cycle must still
   be performed, but the loop must still process them to ensure that
   extensions have an opportunity to re-include them.

3. When extensions return PG_INCLUDE on a head page, yet makedumpfile
   would exclude the compound page, we need a special case to ensure
   that we exclude all the tail pages.

When I originally decided to implement it the way shown in this PR
(calling extensions only for the compound head), I thought that doing it
your way would be too complex. Today I tried to implement it and found
that it's not too bad. Here's a version of this patch series which calls
extensions for each PFN:

https://github.com/makedumpfile/makedumpfile/compare/master...brenns10:make=
dumpfile:userstack_alternative_api?expand=3D1

In particular, this commit is the one that matters:

https://github.com/makedumpfile/makedumpfile/commit/a6695155a58ff5a3078e38d=
eeaf768adbc7cbdbf

The nice thing about this is that, with "struct pginfo", extensions can
now very easily test whether a page is a compound_head or not, without
relying on re-implementing makedumpfile's version-specific logic. So
this very nicely allows extensions to implement any exclusion they want:
they can either repeat their decision for each compound tail, or they
can do something more complex.

If Kazu is willing to accept this modest complexity for
__exclude_unnecessary_pages(), then I think it's worth it for the added
flexibility, and I would be happy to send that instead as v2 of this
series.

> Thanks,
> Tao Liu
>
>>
>> Thanks,
>> Kazu
>>
>> >
>> >> +            }
>> >> +
>> >>              /*
>> >>               * Execute exclusion
>> >>               */
>> >> @@ -8265,6 +8271,7 @@ write_elf_pages_cyclic(struct cache_data *cd_he=
ader, struct cache_data *cd_page)
>> >>      if (info->flag_cyclic) {
>> >>              pfn_zero =3D pfn_cache =3D pfn_cache_private =3D 0;
>> >>              pfn_user =3D pfn_free =3D pfn_hwpoison =3D pfn_offline =
=3D pfn_extension =3D 0;
>> >> +            num_extension_retained =3D 0;
>> >>              pfn_memhole =3D info->max_mapnr;
>> >>      }
>> >>
>> >> @@ -9610,6 +9617,7 @@ write_kdump_pages_and_bitmap_cyclic(struct cach=
e_data *cd_header, struct cache_d
>> >>               */
>> >>              pfn_zero =3D pfn_cache =3D pfn_cache_private =3D 0;
>> >>              pfn_user =3D pfn_free =3D pfn_hwpoison =3D pfn_offline =
=3D pfn_extension =3D 0;
>> >> +            num_extension_retained =3D 0;
>> >>              pfn_memhole =3D info->max_mapnr;
>> >>
>> >>              /*
>> >> @@ -10575,6 +10583,7 @@ print_report(void)
>> >>      REPORT_MSG("    Hwpoison pages          : 0x%016llx\n", pfn_hwpo=
ison);
>> >>      REPORT_MSG("    Offline pages           : 0x%016llx\n", pfn_offl=
ine);
>> >>      REPORT_MSG("    Extension filter pages  : 0x%016llx\n", pfn_exte=
nsion);
>> >> +    REPORT_MSG("  Retained by extension     : 0x%016llx\n", num_exte=
nsion_retained);
>> >>      REPORT_MSG("  Remaining pages  : 0x%016llx\n",
>> >>          pfn_original - pfn_excluded);
>> >>
>> > I suggest to reorder the "print_report" as follows:
>> >
>> > Original pages  :
>> >    Excluded pages   :
>> >      Pages filled with zero  :
>> >      Non-private cache pages :
>> >      Private cache pages     :
>> >      User process data pages :
>> >      Free pages              :
>> >      Hwpoison pages          :
>> >      Offline pages           :
>> >      Extension filter pages  :
>> >    Remaining pages  :
>> >      Extension retain pages  :
>> >
>> > IMHO, this is clearer to represent "Original pages" =3D=3D "Excluded p=
ages" + "Remaining pages";
>> > and "Extension retained pages" is a subset of "Remaining pages".

I agree, thank you for that. I will change the order of the lines in v2.

Thank you,
Stephen

>> > Thanks,
>> > Tao Liu
>> >> --
>> >> 2.47.3
>> >>


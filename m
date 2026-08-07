Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DA6C5ACD1
	for <kexec@archiver.kernel.org>; Fri,  7 Aug 2026 21:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:References:In-Reply-To
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iZttmWK8iocBCS41i65iZ2y+93Skfpo8cS1HlTu3TsQ=; b=so7dQAEYiG6y/Rg47ypSHmQ7Vn
	SXV211GrqBIBgOyUtzDNUFdSTcP7xDg6tK1T+q+1KB4Ckoe6+SQOYEsHvNEfW0VuH2XL4myWbSQUf
	dvp/y2YpMCLjq7Db2Am+3dDDAs4Fc69zHjlw9jI92JJ7JhM1nLEkgSjNs7YYB8a3BpOQW5bLN9LOZ
	ZzJb8ipSZThzBV6CrcwPT9heYNsC3bR1BpJjRTiC5NPYZiXdyj+BiZyqNh/kH5tfo1sxTXXK131PA
	KDtHy+bWXB0N9j+a+x5OLw3sU56NlvqnqdjC9FhX39aestcgDaeGLM79CdVSf4ugCyM1uhhL6Fblr
	wM+cZRfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsS3b-00000008lLi-2GWv;
	Fri, 07 Aug 2026 21:24:47 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsS3W-00000008lKp-3rkC
	for kexec@lists.infradead.org;
	Fri, 07 Aug 2026 21:24:46 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677IMdwH1606740;
	Fri, 7 Aug 2026 21:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=iZttmWK8iocBCS41i65iZ2y+93Skfpo8cS1HlTu3TsQ=; b=
	dxx++QlW9OKy+z4F5dZ6VXLe2Dd1FZwj/ck9cxdAO9Huvf/G922gUwWr1nf3j9mm
	kmnF1qfa10t094fU0Dxitw+ZDf7waAXCAY1xBtNrtpLiTDcgheOoQl/41b8f28B/
	HYSHYCIAszNiZuaMDf4mRcdh3AgWaqOvRNug9KSOiDGp8UjzI7KBvCi2o54UWyL8
	tDOHF0yKP+ehFvwNdR6/HD2jD9GPYqA//dV1+BVgZm8fn6gWwy4cFYBkudeU5Vzi
	gxFoaVC6VPLmZ+NGbmZAMpitP9T79viMdWve2Rk5OrZ9mGAaEuqa18twjX4KmC4y
	ZzrSqsunuXaO6NY4jCHnQg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs7cygqf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Aug 2026 21:24:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 677LKX5x030614;
	Fri, 7 Aug 2026 21:24:40 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012010.outbound.protection.outlook.com [52.101.53.10])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78xg50k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 07 Aug 2026 21:24:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAW0V4w0J9IhW6Cv0oaPJEs3w66LUIwJUzX+KZfZYNgvM7dOjxKgvSWI/DuS+0RloXU5TaFEicnVCj6DVovB9kThuv2Y9+jNjZGTVr4q8WUgpnBTr0Xg61d19rkmU6TLLdOraUwyJwX953xodyA0RelqLntAxN0TmeBC+oFL+qAGcYo/+tGF5yNy0pAuis7CIFkJOm6l/BwrZAIaGvamYlH75eiG1Wv7WNs9bM453Yab7V/8Jp/LihRv2tcF70+d8tnb8wC+xao+0HK5jKxde1fw+T1N3b82he9ogx1DW+xHsBocBEPDMUs9aWszQYZA5+jetP1c1FewPJV37djSOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZttmWK8iocBCS41i65iZ2y+93Skfpo8cS1HlTu3TsQ=;
 b=lLSSdjIuOHb1EdsUQmDkSvecc3+6gpWNlikM0k76kQUmNv//pVOqTtKpttxgopTCdX/fdviDjwM8/v7T62vBlAWCybeV+adi4X7NPBlYWGYzR7W8i1aCcC2gtfCu4kd98pGmjoVyE5bMneyCZMwlBr8ZLHj0TTaxZCmGDhT0sNRQHO6RBfW9GliOwriADbZukb2SedrrDhU3dxGUlXboiH1KiVTmgR/DBVCDvXVbV8veLz2lP/5y+AHq2R7HjY9tGPtMmCz5mpONXRCs6+Wx8cqlrjnMOyn7TgYzhxtTWFFsLzw7sAjwxPW9wjAjhtsGrw/7CJUKP75Z+MrmSbuNog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZttmWK8iocBCS41i65iZ2y+93Skfpo8cS1HlTu3TsQ=;
 b=BdlELD9XclzbcOfiBXgq751W50wCNTDocgZnSw5BulVrXI6jCvIEZFCmAGv/RHssl9ZtSNoCEWivDVEoDsfg/lmwtRTM7IGzM3P5psX0YbFhCOLAhBobxXXV1Gx1ZovQKQyOch1H29XH5RqGnQ6Tcy8zjBemOLoKQon3r6ZP61Y=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by MW4PR10MB5726.namprd10.prod.outlook.com (2603:10b6:303:18c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 21:24:34 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.21.0292.018; Fri, 7 Aug 2026
 21:24:34 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Tao Liu <ltao@redhat.com>,
        =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IA==?=
 =?utf-8?B?5LiA5LuBKQ==?= <k-hagio-ab@nec.com>
Cc: =?utf-8?Q?YAMAZAKI_MASAMITSU=28=E5=B1=B1=E5=B4=8E_=E7=9C=9F=E5=85=89?=
 =?utf-8?Q?=29?= <yamazaki-msmt@nec.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH makedumpfile 0/9] Improvements to makedumpfile
 extensions, plus userspace stack tracing extension
In-Reply-To: <CAO7dBbX---qP-Bqjza=z2HM4Nxn5+KtB-51WF4mvv++p666JYQ@mail.gmail.com>
References: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
 <7af7b171-88c0-4eb6-a18e-8e64fb4a71c0@nec.com>
 <CAO7dBbX---qP-Bqjza=z2HM4Nxn5+KtB-51WF4mvv++p666JYQ@mail.gmail.com>
Date: Fri, 07 Aug 2026 14:24:32 -0700
Message-ID: <87tsp539pr.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:610:52::31) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|MW4PR10MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: 2055b549-8f53-4b3a-69c1-08def4ca46a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|13003099007|22082099003|18002099003|10067099003|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: AGgvlVcwDMw/iTfxpPXMLhBPq6cN8YqwFv1m061Bi/F3ngG1S4WWPw772vNodxLuABvYDzinB07a6zBgiJYAE4ULcxAz/+Yq+gxBOBQVlUI7XpXZ0Zj54HIHjsX35Vro6menx0XTN3+/Q5C4yoK14LBIFstTZWMfLqeSNtmvOxjGe8gwXIZozH7e3FOK7f1kfaUkBsEyyiKTBm9XAZy4ir6kh+QSsJk1L5++isy1et58HyAIPaSTlZPrhUGIYxC2o3Eyl0tnT+20KYWu3g6ljS0usVYsbj8c86vMEcTrAAJfmfNk4nB80Im9O0w0xnE60Aq/dv5LNAQpWt2yU03W8BnDFHhDarJyJvHMn+CWtpmE2OXeoMRXRqw1sAfDoyOAsAzMa8nGwhGdE3G0gMq1Cjq3H+GE80yPqrVNjFuXielHqiSuaRXUHlJHq5qWD7WFjDxplGAXEALLjXjQkX+Bd3a6TbgSxYk2idi5+NcN2RqOCbx63L6AIfool/34P5mTw/JsRBCm1Fkafy0R6YllFXiw4H0vDQF4Ykhdx2onJ/F9OeDx7jdt5Bm1MI1wXpUvWxTNzdNc/fLY95YzqeiLEXgZCj9UjglVCMjXw9pLKc3u/jqAvM/oWLf2c608TyXwEL7eSvGYTptys3eTyZQJ95AdK6g/LOxc5KjSk2LPtMk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(13003099007)(22082099003)(18002099003)(10067099003)(56012099006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aitkVGlQY1ZrNG1tdzNvOFdMcGNpcjdCcFk0SmFjdkpsM0ZYN09rWW1Vck00?=
 =?utf-8?B?Z2JRS0VBL0JwaThOV05vUmtSZTBpajJML1IydHpyN2lxWEdudXlZM2JsempE?=
 =?utf-8?B?cTQ5SzFpekk1M0I1MlZ5cUlDc3l3SjdaQzB3cUZQaGp5NUtJb3dTWU9VVzJz?=
 =?utf-8?B?SVJPT29QM1lvZFFaUUF5SVBiV2NWWG5iY2lUMm8xL0hORTNFT1NRTnc1YjRj?=
 =?utf-8?B?QnFNM1NkSUh3Mk40S1N1WmlXdWpudjh3UENkK3pDcjVDdXkvV1dqd3NNYW55?=
 =?utf-8?B?N2Y3Q08ydkw2cWVCTzlmNENOK0ptWllpeDBlU3NKVno3dEVxY1BLNnFEY0Fr?=
 =?utf-8?B?OE4xZGsydm5yQ2RRQXVZL2UrL3B1UEhzeG85YThjNkpCU2NVT2kwQ0FIL29S?=
 =?utf-8?B?N3FsS3BNRWQwTTRQN0lkMDVBbWFuazdvc2FJajNpdXMrS2dhZGhMTCthYWI1?=
 =?utf-8?B?SVZMY1BVa2QxU2h3YUlZS1lVTXFLbXB4NTNQOHpJN0ZSK1JRaTlBNUxiR3hs?=
 =?utf-8?B?ZzhkRzlHN05HakxVd0NnNUMrajNhUmEreDBiN1lBa1ZaZnNTYmtiZzBYRDYy?=
 =?utf-8?B?Y1FRVkVjc2wrSlZJVURkcUZmV3lnTGJRa21qYnU1d2hKVGZPUEtISmg0ODBH?=
 =?utf-8?B?RHlYVDZ2MkF2aHF1c1VHc2hYUHd1N25MU2J5UlNFMnlVZHh0M1g2b3BpUVY5?=
 =?utf-8?B?bHcwNHZaSWJYdDhuWFBqNkFpekR0TnQyWUVpTHBUQm41YzY4VjJOSVdSZTRK?=
 =?utf-8?B?SlRzM2lCbzM5Qm1lRmdJbjJubzBldlRPb2JBM1BDNkNoVHJuQkJ3bFRISFlr?=
 =?utf-8?B?SGxmQ3E0UGk1VCsvckxTSkkvMmdlUzlsbnZCWXJvM3Rubkw4cGNteXplMTBN?=
 =?utf-8?B?QTc0RzBoeXRqQnNudjlHaWVSejRLRVRyNnRhMWF1bVJyV2hJWTlZVGNDWEV0?=
 =?utf-8?B?YTNDQUgvYklsOUdZaFRvODJFQjhpeGhLdVJMMXBaSmFDakEwL1MzeVVnVGpy?=
 =?utf-8?B?ZUphN3YrSXRMQk45QkpiejhMT3JSSHl4SW15WUdHVnV3REo2dWF2RlJoa1Jn?=
 =?utf-8?B?UmVybnBwTGNTeEg1V0w2dGtiU0RERlYvV2pydDlINDRzelZoeUk4VnNMenRR?=
 =?utf-8?B?STYreDNkZDhaa0dJeGsyY05xUW9IL3VON2FiOGNBSEcrb1JETjFtUm1zckpM?=
 =?utf-8?B?MENZT2hoUExxekcwNVl4WXgwU3FOa0VMcXdzaGNQcDA3R052VVRoVk5wOVc2?=
 =?utf-8?B?UEVpemovN3RZanRuQk4yMTNWbSs5c3Z0alZBZ2tnYUw0OW9BMUNyOEhjc2Nq?=
 =?utf-8?B?dGQ1cE9GQU45SnY3TUFkNG96WENBWHdRV0tIRnFtVlVVOG9yb2RORkJUS3c3?=
 =?utf-8?B?U2F3N3A1VXgzUlVZZHVEdUtSdUdJT0Fpb1ZaeUVOTis5dm10SkZnUHg0REdW?=
 =?utf-8?B?TS9CUjZXVkNpR1VEdGM5Z3h3VUJOYnpOcDNEWDRxTThCYmRIT3p0M25xUGtX?=
 =?utf-8?B?Q3ZZYzQ4N0FqaG1FNDJQT1V1d0djK09EcXBFOXkwejBzcUdEVk9UUndJc0Ew?=
 =?utf-8?B?SHdmdTRVUE16SmhGU1lUUE1XTDJHQVEwVFdtUFp4eDg0MG9TcHQ2eTZCOWVM?=
 =?utf-8?B?OWJySjVKWWpTUnl6dDU0bFJXSkhzQlF6Wm9rQ2hjMWMwSUxIb2FNTlE4a1Yy?=
 =?utf-8?B?Zm9pY0JLT2ExaUxNMWRML3NUZmh6T0Jnam5vM2trZmR4ZjZaMGpnbWdzNmVD?=
 =?utf-8?B?OEl6V2JZUmVDcVdKMTJkR1ZqS051ZDRMVmxBVk9mQVY2REZSVU5aL1cvV2Jl?=
 =?utf-8?B?aC9lM01TWjRGVVNyZnhzQjhhRUQvVnZaNHRLMWJyMm51ZTErbW5mNGw1RkR1?=
 =?utf-8?B?VHB0THJmMUNEZDUyT2I0NGI1eXJkUkFxaWhPNFI4RmdLQlI5WDhqaUxyRmhQ?=
 =?utf-8?B?Wi93NGpRdHQ4UHJrR1ErY2VIWFFHcXg2cTdCaXY2UDZnczdaZ1hXZEF3RFJq?=
 =?utf-8?B?aktheXdGTkowYS92UThYYktLKzVwbFBpRVNJTm1YOTdOa0RYWTlTc05NQ2NW?=
 =?utf-8?B?L282c1ZucFhQa0x2ZTZRbmdqd3REQ0M0bEFqem0zQ2l4M2IyM2hpc2NyaU4x?=
 =?utf-8?B?YXRCcnVPTUhHZ1ZBL1pJYmo4aEMwaTg5K01RcHJBcjRiUVNlWEMrb1hwcjI2?=
 =?utf-8?B?cnRaZi9USkxRQUE2elRpQkxXLzdWd1YreUY3Y0E5NTFXWTA1RllwM0tIUjBC?=
 =?utf-8?B?RjB3V0JKcU9Ha3gzdUxhbGNYb2IvaVFHV2FNd2lKOExMSEhjRFpQWDF3MC9Z?=
 =?utf-8?B?eURFRmhCOHRpcitVamR2VjN0S1I1U3puWVNxck1RWjZuT0FlTlJ4aW0rbEF6?=
 =?utf-8?Q?dK8Jr/rIQH9h1b90=3D?=
X-Exchange-RoutingPolicyChecked: c8CdSDWFjr2IJzy4eOpn48BabOoCkqFjxLMPUGq1Tm6UnAwFUmLwE+lTiZ7TRMQ41COUd5uB2D1XF0c59GW+Dq95rDlNmwkZhCV+qbWZUPeV4w+mbqRmIEoOGdc5gJf5aRfOGrCr08z7aUxDX7J1xVg8JkfnWdEgb/DY4Up6xveTwDEq3NIhfB39pZI7WRKus7ZFT7whf11BP4lTF96B2xoUoi7Oookw+8UFfyGb9gvZP/+wbGB3rF/Ji7qaUL+ZtRBNaXgj+xLOiSb8JIwINIjMh1f07aerCtOdIv/euGRC9jLvZRFmKTeLNobnWYJoGWp7VH3m9sTFQBCNX/L4Ig==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4tanrvkNmsDvlbjTJiIySHJroo1p+36rluOdesT89UeYYKcM6fR3W6Kpael1yerTpv/MmeOD9VXTqL9rlj+pKE5E6YEeAjVL4acn16jMhTpLOdwBFd3i7NBfuHjpJw1N6NeIsdXAaKf9Qbj2ecdCkOSimzABpciCtGL3zQf2to1lRMj/0gESLW7R7n0sRF/qyjYNKvnMUPkyUDbGHjC81inysOAyYjX2RwM8AhNEzk0id5mYFQXCmMgX/MDIrI0v8qHHXkyRyI2VmKkvUm7UNCuX1DWxQDKtHjiC+9seO4ckWLzFLEpxrelTmJ3yAjZIj4UUwc/Ezs0KC1kImGXZdukPus9xH9vmBF3uDSVMej2OU1ftolkTrP0LedXkVyVXCsDzl2uSWFzxsgYUjabXCH6yFw6rsSAsf6+veEIauBocqncYvOdoVPf/lW5GxMSXSZtMhDAO0XN4boLGD0M0072e6sxhzQ8lePQHE+mqdmeyChSS81lIhBlcBZSLlpVllKM3qCjgggGShsP2rkvPJy8rvbM7BwlgvHdxpmd/sTl14cjcbfg8QtUQJ5yy8THepXR3CpiVrrHuCrSYAiD2v0d35ugqEV4m7hhyXBm/nTw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2055b549-8f53-4b3a-69c1-08def4ca46a1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 21:24:34.2240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EaFP1jPWVpRLSnGa9mEWVHY1EghxDRVDxWRk6G939BZlH3n1ysJyH/jytQ78Cra95Qv2XRlSvQXbHk9foRhk7GAx3v72Kn69snJba1UEWKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5726
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_04,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608070167
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE2NyBTYWx0ZWRfX2gqwo3XZAIUR
 2TisZirOA36tXnMQ4AX1/8XgEDnKo7MHOQRrw0bEUccfP1KNMaJ6VuWP0Niv9chW96s832E4PBV
 mSYVlrCd0n0Byd/jN9D2a3inH99BbBbaYCrLG+UAtAWzYpnYlMbv
X-Proofpoint-ORIG-GUID: xgG4wP0Eb32ZermSI6FwnpvPpKSBRW5Y
X-Proofpoint-GUID: xgG4wP0Eb32ZermSI6FwnpvPpKSBRW5Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE2NyBTYWx0ZWRfX4nYB6S8RmDcV
 8shg/SA/VBC+s585R+W/OgNGMmmkl6IGgl+Ne2i2ih45OC4quvC0X86UjRHu8hbSlTNQbUi+BAG
 KeSowDIDLnJIPwDsW+XTPELY4SSIAr0F3k1tvcBu3/BJj54K0VYVSFKagPQwxnMUvLK+xb7QJyu
 NO9jhLLy5NjY9IFe78njs6SO8FXlSMk5flFHmpCvbmlPvTuRSrqid2LrUpmDVod6EKgz2MfU+et
 a0gREm8rZSnhnEvfrpQZQLZj8uPRwgjVsiu02gqglC9OFUSkPrNXts8SMc9NgNb49WV1JEKBuvZ
 Hg35qARgyINOOTkJ8I9Pp2ounlWy5UB1reYPK1JasS4x/tL/QofmRTZYdwthfVuW5j0RBRUuTAg
 wQSGabI9Ke1MejrFYpb4nClSZAngzCRlP7pO8CReuEDJctrJAnMMrcPnOS7WZohebmjsJEnQknT
 jm0pbCV3myHgfrOpIQSxuh5Pq+ZVtAeJbmU5EH2A=
X-Authority-Analysis: v=2.4 cv=TsPWQjXh c=1 sm=1 tr=0 ts=6a764d19 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=NEAV23lmAAAA:8
 a=20KFwNOVAAAA:8 a=nrACCIEEAAAA:8 a=PRRspnVL43WizvpBuooA:9 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13510
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260807_142443_275783_14A8456B 
X-CRM114-Status: GOOD (  22.09  )
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

Hi Tao & Kazu (responding to both in one message for simplicity :)

Tao Liu <ltao@redhat.com> writes:
> Hi Kazu,
>
> On Fri, Aug 7, 2026 at 1:52=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=
=E3=80=80=E4=B8=80=E4=BB=81) <k-hagio-ab@nec.com> wrote:
>>
>> On 2026/07/14 9:45, Stephen Brennan wrote:
>> > Hello all,
>> >
>> > Building on Tao Liu's excellent work for makedumpfile extensions, I'd =
like to
>> > share some incremental improvements to the extension system, as well a=
s my own
>> > two extensions which enable userspace stack tracing. There are three t=
opics
>> > related to the core makedumpfile extension system which are addressed =
here:
>> >
>> > 1. Tail pages handling. As patch 1 explains, extensions currently get =
called for
>> > tail pages, but their decisions are not respected. I believe the best =
approach
>> > is to only call extensions for the head page, but allow extensions to =
return a
>> > decision related to just a subset of the pages. To this end, patch 7 a=
dds
>> > PG_INCLUDE_HEAD to include just the head page (leaving the rest up to =
the
>> > default policy), and patch 9 shows the elfheader extension which uses =
that
>> > functionality.
>> >
>> > 2. Counting pages included by extensions. This is done by patch 4. It =
alters the
>> > logic because it's really helpful to know whether a page would have be=
en
>> > included by makedumpfile's dump-level filtering anyway, so we only cou=
nt the
>> > additional pages.
>> >
>> > 3. Sharing makedumpfile's logic and knowledge about page metadata. Cur=
rently,
>> > extensions just get a "pcache" pointer, which means they must redo wha=
tever
>> > logic makedumpfile has already done, in order to get information like
>> > compound_order. Patches 3, 5, and 6 factor out the page metadata into =
a new
>> > struct pginfo, which gets passed to extensions, and it also makes more=
 of the
>> > helpers like "isSlab()" usable with this pointer.
>> >
>> > With those improvements, the final two patches (8 & 9) implement a pai=
r of
>> > extensions that are useful for including a minimal amount of informati=
on which
>> > can be used to do stack traces of the userspace processes in a vmcore.=
 The
>> > "userstack" extension includes the stack memory itself for each thread=
, and the
>> > "elfheader" extension includes the first page of mapped ELF files, so =
that ELF
>> > build IDs can be identified from the vmcore.
>> >
>> > My testing so far:
>> > - Live testing (/proc/kcore) x86_64 on Oracle UEK 8 (6.12.x based)
>> > - Refiltering on vmcores generated from UEK8, 7 (5.15.x based), 6 (5.4=
.x based)
>> > - Using the resulting filtered vmcores with drgn's contrib/pstack.py t=
o generate
>> >    userspace stack traces.
>> >
>> > I still have significantly more testing to do and then share out:
>> > - Testing in kexec environment
>> > - Testing with upstream kernels, also verifying in a Fedora userspace
>> > - Sharing runtime and size comparisons with different workloads
>> >
>> > Despite the limited testing, I wanted to share these patches as they a=
re,
>> > because I think the improvements for the core extensions framework are=
 useful
>> > already, and don't require as much verification.
>> >
>> > For the extensions themselves, I would like to consider merging them a=
s well, if
>> > there is interest. I think it would be useful for makedumpfile to cont=
ain shared
>> > extensions, including those for the GPU buffers which Tao Liu was work=
ing on, as
>> > well as the userspace stack tracing ones which I'm sharing.
>>
>> Hi Stephen, (and Tao)
>>
>> sorry for my slow review and thank you for your nice improvements!
>> I've reviewed the patches 1 to 7, these make good sense and look very
>> clean to me.

Thank you very much for reviewing.

>> few comments:
>> * I also think that including extensions is very useful, but for now,
>> I have to not increase the maintenance cost as far as possible, so
>> will not include them.  (this way has some good points, for example
>> you can update them freely without my slow review :-)

I understand: more code means more maintenance. We can maintain our
extensions separately, thanks for the clarity!

>> For user access, I'm thinking about adding makedumpfile extension list
>> to its wiki page [1].  If you agree on this, please provide their
>> information (extension name, author, link, description).

Here are mine:

- Extension Name: elfheader
  Author: Stephen Brennan (my email)
  Link: TBD - see below
  Description: Includes the first page of any ELF file in the page cache
  which is mapped to userspace. This inspired by bit 4 of
  coredump_filter (see core(5)) for userspace core dumps. By including
  the header of an ELF file, it's likely that a debugger can identify
  its build ID and use that to find debugging information for it. This
  helps when used in combination with the userstack extension.
- Extension Name: userstack
  Author: Stephen Brennan (my email)
  Link: TBD - see below
  Description: Attempts to include the memory pages for each userspace
  thread's stack. This can make it possible to unwind userspace process
  stacks using a vmcore, for example with drgn's contrib/pstack.py
  script.

>> * Could you add a description why PG_INCLUDE_HEAD is needed to the
>> patch 7, as we cannot add the cover letter and the patch 9.
>> (Text alone is ok, or you can use v2 just for the patch 7.)

Done as a text reply to patch 7.

>> Otherwise, there are typos and comment style gaps, but those can
>> be fixed when merging.

If it's not too much work, please do make those changes when merging.
Thank you!

>> and Tao, please check if your extension can be rebased on this
>> patchset.  and also if you agree the extension list, please provide
>> the information.
>
> Sure, I will check for the rebase. In the meantime, will the
> extensions to be maintained in one repo (e.g. makedumpfile extensions
> repo, so everyone can PR to it), or they are maintained in each of
> individual repos, and link them under
> https://github.com/makedumpfile/makedumpfile/wiki#extensions?

I am open to either. I would be willing to co-maintain an extensions
repository with Tao, for example at github.com/makedumpfile/extensions,
so that there is a common place to contribute. That is, if this
arrangement would work for all?

If we did create a common repository, I think we'd want to set up some
expectations on the quality & maintenance. EG, some may be marked as
"maintained" with a maintainer and a scope of maintenance (supported
kernel versions, supported architectures, etc), and others as
"unmaintained", where we just make sure that they build & run with
makedumpfile, but don't validate their behavior on specific kernels or
architectures.

On the other hand, if it's preferable to stay separate, then I'm happy
to find another place to maintain the userstack & elfheader extensions.

Thank you both!
Stephen

> Thanks,
> Tao Liu
>
>>
>> [1] https://github.com/makedumpfile/makedumpfile/wiki#extensions
>>
>> Thanks,
>> Kazu
>>
>> >
>> > Thanks,
>> > Stephen
>> >
>> > Stephen Brennan (9):
>> >    Do not call extensions for tail pages
>> >    Honor CFLAGS in extension/Makefile
>> >    Share page information with extension callbacks
>> >    Introduce a stat for pages retained by extension
>> >    Move page checks into makedumpfile.h
>> >    Simplify arguments for page checks
>> >    Add PG_INCLUDE_HEAD extension return status
>> >    Add userstack extension
>> >    Add elfheader extension
>> >
>> >   extension.c             |  10 +-
>> >   extension.h             |  10 +-
>> >   extensions/Makefile     |   8 +-
>> >   extensions/elfheader.c  |  93 ++++++++++++
>> >   extensions/userstack.c  | 325 ++++++++++++++++++++++++++++++++++++++=
++
>> >   extensions/vma_mtree.c  | 140 +++++++++++++++++
>> >   extensions/vma_mtree.h  |   7 +
>> >   extensions/vma_rbtree.c |  56 +++++++
>> >   extensions/vma_rbtree.h |  12 ++
>> >   makedumpfile.c          | 188 +++++++++--------------
>> >   makedumpfile.h          |  78 +++++++++-
>> >   11 files changed, 798 insertions(+), 129 deletions(-)
>> >   create mode 100644 extensions/elfheader.c
>> >   create mode 100644 extensions/userstack.c
>> >   create mode 100644 extensions/vma_mtree.c
>> >   create mode 100644 extensions/vma_mtree.h
>> >   create mode 100644 extensions/vma_rbtree.c
>> >   create mode 100644 extensions/vma_rbtree.h
>> >


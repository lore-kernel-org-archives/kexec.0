Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3F7CCFA02
	for <kexec@archiver.kernel.org>; Fri, 31 Oct 2025 20:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8rDRz+W/HuEOmO89OEFK9vv3zsjOWVW5KF8bGUlca18=; b=bthSzheTUh7Uj13+bhgo8eAdyI
	csq7F7fQ/OvR/J3+MqIYpt+qbLrSZu4QuQiXEAbu/T6smsXImqYz3FE1y7IixxXOb/slOvbm9+ybC
	tPWyAguUIaq9gVk762BWdpqnmnyfwkXWpmkRiQ1SrC5FSx/ljkUNNscAgFwyMunriCl9rxKhWfIZV
	kMxYPZw9ff4RbdviCfAmM++mwy/Jrgspmt6OkdY9lCiyI9LML/7Qq10c2IdkEyMlHCWwJ0Y3TsAwe
	vKt1Fj4Nj8eLfHyWaK/6ah16Z38R0SQywVwDC5+vjs7+hHJqighZvE2EIk4nEX8eUC5587FUWS0DB
	q9jOgxSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEvwd-00000006n6v-2ePc;
	Fri, 31 Oct 2025 20:41:59 +0000
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEvwV-00000006n5X-43p5
	for kexec@lists.infradead.org;
	Fri, 31 Oct 2025 20:41:54 +0000
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59VK39JU000527;
	Fri, 31 Oct 2025 20:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps0720; bh=8rDRz+W/HuEOmO89OEFK9vv3
	zsjOWVW5KF8bGUlca18=; b=HfO6KZ9vHL/fq6ate9ZQpjO5pg9DmxxEZ2gz7RXC
	7N4jxxtSjfj+mEMwTvMcqsGq+GpneSPA+aTTuSBCXDNxIXAvHsqtt4XmDlqipcvJ
	k0Os3Q+ETnXnaPr/aYiPgoDkuvdIwMfiVAVBLJCXE4SpEkNARU3yixpSFtEe80LT
	gzYEU86071wUt5tuG9YJRZIT4TZVvmU7s7jqA7GP7vEhO3sn0WHb+iAMQxd5btqJ
	rGkLm2dmZkTfr+C4CrJ1H9VDjZsF7TPBw2XR5tODp3p03CqyWYmyFeT9R7JR8rSJ
	Fs41N4DgHuKuEdpKX2zMrJlLpJgj/Tub72eWxy/+ZX1e0Q==
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4a4jf18huu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 20:41:42 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id ED00E800245;
	Fri, 31 Oct 2025 20:41:30 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 31 Oct 2025 08:41:30 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 31 Oct 2025 08:41:30 -1200
Received: from DM2PR0701CU001.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 31 Oct 2025 08:41:30 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UEXPTVUUqfNLaf8kpmp1SdIxRZ9P5NNvg87+LziOjjzcfMuZuZjJgervcJNlhpjY99aswurTmGJippOOwh/1BfipYS+nXKXWJyfYmaUOfrT6ZQBOnsq8dhbWh6xgJKtHC58NZHCmnqZWDPSqT0LSDzrg1xro7thwSAhMjGvBLFBiCfu93vtaXFIT2fM5aLVa+0QdWplaBbrfbIuzwHzBYhHvLmghlmvmCRwGSBbBs+qPCpe5F3ng992JTmfNNLgDvClDm8jZIPBltN8p5ft7f3Mxv5olHUcrk3+fGUwebcnElKgCJPXH38W69VMMZzRrDL9vLWmkaT7B59wlaAh5Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rDRz+W/HuEOmO89OEFK9vv3zsjOWVW5KF8bGUlca18=;
 b=sw/Sg9JK8JpN1oZeDXIUi6RZbXa5HfC0JM0B0qOYmNL5arel3lbKm+/VPwWLqqTrNtvvYnUe130PRphWYLN6PJYIjy1pt4azBAg9Y2ZlNb31E45XroRNVJ2Kw3BiNw2WkLzjUzLX4ro//AI2ZSLT+/2wtHC8VF8R6wfd2d1I9AETU/kMisuGUvTC4+LUr1GLXN9l3glWTTWEN49AZnNyAEAbQ5bBSfscmG2+NOX6lUJnVjeeP5rGmbt3xHSXBcyTcF2K01+ZA4Q6SoKF1ig98+RD7w/p8cxphI0Lm/4qw5rBJW9rLog1reDY2ldUTuwl8kPEVE11bi6cgTAI07ou1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB1482.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:430::5)
 by PH8PR84MB3187.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:1ce::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 20:41:28 +0000
Received: from SJ0PR84MB1482.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::4815:5b7:fb3e:2405]) by SJ0PR84MB1482.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::4815:5b7:fb3e:2405%4]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 20:41:27 +0000
From: "Aureau, Georges (Kernel Tools ERT)" <georges.aureau@hpe.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
CC: "yamazaki-msmt@nec.com" <yamazaki-msmt@nec.com>,
        =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
	<k-hagio-ab@nec.com>
Subject: [PATCH][makedumpfile -R] Promptly return error on truncated regular
 file.
Thread-Topic: [PATCH][makedumpfile -R] Promptly return error on truncated
 regular file.
Thread-Index: AdxKpW5xGvUCyCBXQwG4FZfs9UsnJQ==
Date: Fri, 31 Oct 2025 20:41:27 +0000
Message-ID: <SJ0PR84MB1482BFA802020454722B80A79FF8A@SJ0PR84MB1482.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB1482:EE_|PH8PR84MB3187:EE_
x-ms-office365-filtering-correlation-id: 9947fa2a-cb70-4eb2-7ed6-08de18bddd9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-2022-jp?B?ZVM4d2ZPaUtwYm9KTWNEb1VsNVVBa3E0a2NCNVFvZXdKcGZlYkVtRDQw?=
 =?iso-2022-jp?B?ZkRNWmh6aHhEYmUyNS9kb2YzbTZmYUNUS3JuU1UwdHNyOG1DMU91S2JO?=
 =?iso-2022-jp?B?VjNlek1vbEdSRTBXQUpnSEJzM2l4MTN3dm1lTndrYjhwM0p5WUFrNmo4?=
 =?iso-2022-jp?B?YWVLLzd6U2pWajhxa0VTUHFQQ1hNcU9BNlB0bkRsZnFPMW92bDlHY2Vz?=
 =?iso-2022-jp?B?MFNTK0RWMnBuaWI3VzE3cVpFaDNHanBYWDdwdnBHTzNUaThrWmR4RVNX?=
 =?iso-2022-jp?B?Si9EakltR0x0UUVSVllBbHdCb2JzY3FFd2hwQnpDS2R0VGtNMFZrUDFT?=
 =?iso-2022-jp?B?UVVaQWhLV0JoRFl1dmZhb2FkckoyRWJsYVM0RnVGMlFKZHRXYkpTSTZt?=
 =?iso-2022-jp?B?WDZkSUw5Ky9vMytUYTQ1akFRUzU0SGQ5ekp6UHhkK3hMbTZEaEdnYm9k?=
 =?iso-2022-jp?B?aForeXhpTHljeWVNcDlnOEU4M1JBb2JHYjZIWTFNZWVVTzI5WlU2U3Qy?=
 =?iso-2022-jp?B?MnlZSkhEWlJSd3RaQk9KRWlPMjNGcXJZanNhOEltWEdxcm1YVkxOYUFx?=
 =?iso-2022-jp?B?ZTRNY3FpazNucTc2RjlJNUJPVjJ2SUk2ZFNwUHlPQVhuRXRHNGIyK2Vs?=
 =?iso-2022-jp?B?OVBRc1lJdFNodUs2Wk9SOE5uZEppWmpEeUVGYjVTNWhDLzNkSGRSeFMx?=
 =?iso-2022-jp?B?QzBlNXNseEpGQ0RBNTBLNkJsQnB5NnlNTk8ySEtBOUlVdSt0UHpHU1Fm?=
 =?iso-2022-jp?B?RmwzaEpBVXB2cUt0Vi8xNk9ZQXM4bWYxclZnUHhFK25NUDhWeDgxNmRM?=
 =?iso-2022-jp?B?cUZacHJ0cExwdi9zNkRNOVE4UE4wUTMwbSt3VDhuVnFkZjF3TFpqaTNn?=
 =?iso-2022-jp?B?NlZBem8vay9TRDlwdVgzb0NlUUQwN3BZSlJhd1RIc0djUE1pNmMyWFRr?=
 =?iso-2022-jp?B?ZVJjTUJ3azVvd0ZvYVdxQ1RDeGVkVXo2SEFId1VvWitBZkNzcTR3R1U0?=
 =?iso-2022-jp?B?UDFNb2tWWWo3MVZJRXIvY0NNK2RlQTVXc3crUnVOLzUrMytsMCtwUTlQ?=
 =?iso-2022-jp?B?SXoxQU5iQWFRbTkybjFCcG43VE84WDVjdGpnWGNYSXRUbkhRaG5McGJw?=
 =?iso-2022-jp?B?MXp6LytTeWtJUjN2S0dyNnQ5VXpMVnlySVJZeEpDWThBQjY1TmZQNWhS?=
 =?iso-2022-jp?B?NlczOEJxYzltZUhwTDhsYk5xY0k5c3NmQjB1M0QybDBjME1lbExqeUhv?=
 =?iso-2022-jp?B?bVNNR0w3NzY4UGVrWVlHNnJ1UllQNjZpR2JoRHBEMHRKYzR3NFpxdTJ3?=
 =?iso-2022-jp?B?czdkc0RRdWhydlhLOVp6aDFhb2s2eEtiT3R0R3QyZzBNdnNQTkQ0MStq?=
 =?iso-2022-jp?B?ZUlLQmxNMmVSSVdub3ZPUUlWNnVKV3UxajMvRGh4aGxkOHFMQ1pkTmlp?=
 =?iso-2022-jp?B?ZTc0UDNZQTFzRUNhbVMzQmRZQmlIWDIvOVZnRUFia2RtMjFCeUh3REpK?=
 =?iso-2022-jp?B?eUtGcG1JYytzOWt0cHZmTW84bmsxMWZMTTNtNGp4TUV5RVNRR21TeGpD?=
 =?iso-2022-jp?B?MUNyTW5kVHZ2N3JTaDhuVnhMWmNHSm5MSWkvUVVMUlRkTEtsbHE1YTZ0?=
 =?iso-2022-jp?B?bVl6Z0xHdndEak1jZ1RHN1BEbmhhU0lHUkNYOVZaSHRyQkc2V3N2dk5O?=
 =?iso-2022-jp?B?aXVwcHJMblF1R043QXFadFBzd1E1VlRLL1IvSlRnNmRBUDRCSEQwVy9i?=
 =?iso-2022-jp?B?c2huUXVqTitZOHpzMDBaL0gyOWdhTm0rRTdsQnducDFGMld6MW8xT3lq?=
 =?iso-2022-jp?B?amNrdTBFUVN4emFVdlBta0ZaQVhoMUhFL1ZFRXVQek9OLzZtNWRGMUtq?=
 =?iso-2022-jp?B?dm9wWm5OMWJhNkh2OW44MDJvVTlQb1I1bUFHM0Z6Qktienk2WmVHa3lU?=
 =?iso-2022-jp?B?dFlFSThPbGZ1MHZaV3hkRGpHaXdmbGpsQllHZ0JHME1UYk1td2QxUGtn?=
 =?iso-2022-jp?B?SHA0Qm40WFp6V1MweXBHSlArMUtmMTR0MHFUbldmZGJjYXhrZXVJaFhp?=
 =?iso-2022-jp?B?STd4MDRybUpvZUFFeXJhNU84QnFXMXpUQnh3aVlVbjRnSnhkYVJLakhF?=
 =?iso-2022-jp?B?RXU1dy9LQ3BLSzVEWU42OGN1QXlMRmh3N3JDZjdHcVI2UVc5eTlwdzBz?=
 =?iso-2022-jp?B?T2cyUFpueUFtcXNEVVJEREdJUjhQTGVx?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB1482.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?Y0xybWluUnZyQ2lHZTFLMXZJZHgyNTdHU2FTUVg5WkV0aGVIcHQ3Mnox?=
 =?iso-2022-jp?B?aTBQTWV1Y0ZITmROZ0UwNFNRM25rRVdRbjVtWjFPOVpqekJTbG1uQjFS?=
 =?iso-2022-jp?B?cnNNZjgvdWRiOThTQ2NZT2NKbi9iUnlnOXk4czlRWGpJZHVKNzNlUWNn?=
 =?iso-2022-jp?B?T29rTDltWExRTWsrb2Z1ZGFUM1lYd01jODZqM3RWWE9XOWNvT0dHT3Nn?=
 =?iso-2022-jp?B?QTU0UzNLNnhpNG9oaGt1RlBnOVB1aFZBNEVoYjVDY0ZXNzNPbUJvaTFx?=
 =?iso-2022-jp?B?RGgwRHMwUVdodUtFM08wL3czVmJxRzhwSFNGWDNYU1hQZk1Ra01qTm5F?=
 =?iso-2022-jp?B?UCtQMDRwdE9jT2xzNm52REp4RG1pVUYwMkRrU0JhZWhraDE1N3RieGhS?=
 =?iso-2022-jp?B?RHRvdUl5UmRBV25heXhvdVJwcXk0NUxPUTFtUVFCbExIYW9FalIvTWt2?=
 =?iso-2022-jp?B?bDZaTC95aGJsNEFyVjMrVlNEZmVGT21PSHl4UjBwU2ZWaEpTVzBrcDRv?=
 =?iso-2022-jp?B?aGNKYWVhUnR5WGhzMWViL2NhcW13d25XT212WUtrZk1IQVRTUEkxZXlu?=
 =?iso-2022-jp?B?TlhweFRIWXM5aDhoT0pnNjNVQU5oemJFa2dUZE01em1aUi9zTXNnb2RC?=
 =?iso-2022-jp?B?S1Ntak1CYjI1cjY0ZU5CZ0JhdkE1K0puZVdkOWtiTm03VXozMUI1S1lJ?=
 =?iso-2022-jp?B?bkJkVlFSVmJIYmxEWHlvT2s5OCtsMjNHMWdCdS81SHlFL085K2gxT0VI?=
 =?iso-2022-jp?B?U293NDAwN0xaVjB4VXl1WDVWN2JUbzV1S3JLS2NKNVl1dTh2S2NXdzZ0?=
 =?iso-2022-jp?B?SldGVE1ZY1UreUY1bDJIL0ZWZkVYRVNIdGkzL0Z4dXg1WVB1VE40OWZD?=
 =?iso-2022-jp?B?b0FCYUZuU2E0NlE1U3lua3JuSGtxZGp4TDlmUHhiV2RVa2pjQm5tR3g0?=
 =?iso-2022-jp?B?QUhuYXk3ZzVCaEdiUUM0QVRZeHd1cHcwWWxodVBuS0tobis5Wk5DMFZ5?=
 =?iso-2022-jp?B?czB4QW44VnhydDVGTUZxNHlPWU9jaDB5RC8wMDdQNlBjYVROa1FWSXR4?=
 =?iso-2022-jp?B?T0tpUURtVGRFTXFha1RPc2FtWDBWQU5WTmJaNU4rR284OUY1eld5aGUw?=
 =?iso-2022-jp?B?ZC9nVjY3ZlVZN05tNGpwWGpvSGNDY1JPT3kyV2oycWREUWt4ZnBoVVhJ?=
 =?iso-2022-jp?B?N1Rua2ExeTZuSTdYa2RaYzM3NTlJdnJ0SG9xYU5USzdzT1pHRlFJTFQ1?=
 =?iso-2022-jp?B?bEtLWWlWWThrVjZVVnlPZXU4WXB4OEQ1cVBuMzRvbkVDOHBtUHBNMmsx?=
 =?iso-2022-jp?B?MGs4UkZBcXBIYTROdGNDVFdiTE9YOE1ITGNpbXh4TW82dktxdXo1VzI2?=
 =?iso-2022-jp?B?c2htWEdqUXluTTAyQUwzdmV1Z042aW1vb2xBQjlKNXFhdWVaaFpyZGd2?=
 =?iso-2022-jp?B?cEpiZ1BvQkZVR3BlOE9McXNhazEydzRDWFBGQlhZVUF4T25Md1lHOHJt?=
 =?iso-2022-jp?B?eG9uWDdyd2hWUTZkSnBudUdoRVlJT1pnclA5dXkxeEl1Ny9JaWxRdDc4?=
 =?iso-2022-jp?B?V2FGSXJ6ZDVNT1licThCNGVHVmpiakJzWjhaV1ZWNCs2aEFoV2hxZ2Vv?=
 =?iso-2022-jp?B?dThtdzJRbEVUOTlZVHo0dk1QWitMSUdRQXp0NG1DcVhjSHorV0ZiaFhR?=
 =?iso-2022-jp?B?MElzWjBpTkd3anVDWGVlTzNySEVhTXg5bk5pMHVSNTNIMlhkOG1yTlcw?=
 =?iso-2022-jp?B?RDhhenpJdDl5V0ZJSHJ1bmpOellXOUkzMWpBZFNIR2gxZlFoLzNiMVJN?=
 =?iso-2022-jp?B?NTRZeEpUTi9ub3NEck13QkFLOEVzMUFQY2o5MThTNkdOTU1lM2Uxa0J0?=
 =?iso-2022-jp?B?UzRkQkdMOHd5K1A0eHI0dzN1QWlUQ0ZKb2FnNjhPRVJqM3A1K2JUdW10?=
 =?iso-2022-jp?B?YjlEMVZIR1l0cmZtR2lvWXYvL2J2ZitnSmF0MUpnR1cwL3BSNGZ2clZJ?=
 =?iso-2022-jp?B?ZWNEYjlLMWNpZ0l3eGs4VmVsYkRMcXJISGowV1RIVjRaU2ZBUWw1R3c0?=
 =?iso-2022-jp?B?d2lOWUlLcm5FZ215Q2xYU0NpU3k2STVwNU1SeU4yeFBNc1JVWHhSMUNQ?=
 =?iso-2022-jp?B?RisxRVQ3VDJPRTRmV2RPbU1WYmtsTVJaeUF4VEhwRlVnSU8wRElNRWM1?=
 =?iso-2022-jp?B?Zlo4N3BMckNLL0Q5Z0VLOTZDdk1iQUlFaGpLYWcvNEV6NVRLZkl4cEJR?=
 =?iso-2022-jp?B?QllGV3ZXT3JvVzRmSVpMdVZOOUFwcW1Sb2M4UXVnNFNQTEx6K2l0VTFU?=
 =?iso-2022-jp?B?ZWVhSg==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB1482.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9947fa2a-cb70-4eb2-7ed6-08de18bddd9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 20:41:27.8816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1fHl4sVIMFi4gsm6HfkpjgX9hD6NeM7GSTDldMrpmCTgF0PvnFAXV1gx887VnmWJWm2f7Q2FaB+s5OdGoZjryA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR84MB3187
X-OriginatorOrg: hpe.com
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDAwMCBTYWx0ZWRfX0vQ/Doiz4IlI
 ebslIuyLev8csfwhki7SdAz+aR6Pnszw33JAFOtitxgFRTixc9Ec/HC756mwS7uaSMBFA3z2MFQ
 SUnMpQoMxGyTnAiYvW3Z9CMt0DB5X/4BB+0xtXP4fGD7rIrrM7cO3PqdXqgLf0rz9H9RqkN6nNt
 onGHCc8UWqMtSgEkrkbnE7uhJ4clE5aVo3akv+ay4GRy06LXbcVcx20HO+ewqwsqH8fZxGZh+zL
 9JfW/0nTwzHW1Q2W6UCWxkahLdn2Ke7hYEgtqSJyJuGWtKWl0+xQagSO3EINVhnnFN5AwXM0vTQ
 jvulNkA3voqwFyVWd+U1n9H1/SgN503OGXtM7g9QSeHx7phSSBm7ec42Z7pduO8L8Zxubc5eh6P
 +2XYWEWBDgdlmoHz+6D4tMqFM81yfQ==
X-Authority-Analysis: v=2.4 cv=fMk0HJae c=1 sm=1 tr=0 ts=69051f06 cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=ZPSk82zQDygA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=MvuuwTCpAAAA:8 a=BVrZveS4p96uDTqNK7UA:9
 a=UAVRJdkkkM0A:10
X-Proofpoint-ORIG-GUID: -4y0gJuXKkflQgLjYn8RdDUWqInNQDHv
X-Proofpoint-GUID: -4y0gJuXKkflQgLjYn8RdDUWqInNQDHv
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510310000
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251031_134153_039174_3BA46CF6 
X-CRM114-Status: GOOD (  12.72  )
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

[PATCH][makedumpfile -R] Promptly return error on truncated regular file.

When reaching the end-of-file on a truncated input regular file,
makedumpfile -R is looping for 10 minutes before producing an error.
This is confusing for users. When stdin is a regular file, an improved
behavior is to promptly return an EOF error.

Signed-off-by: Georges Aureau <georges.aureau@hpe.com>
--
diff --git a/makedumpfile.c b/makedumpfile.c
index 12fb0d8..295b3cc 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5135,6 +5135,21 @@ write_cache_zero(struct cache_data *cd, size_t size)
        return write_cache_bufsz(cd);
 }
=20
+int
+is_stdin_regular_file(void)
+{
+       struct stat st;
+       static int regular_file =3D -1;
+       if (regular_file =3D=3D -1) {
+               if (fstat(STDIN_FILENO, &st) =3D=3D -1) {
+                       regular_file =3D FALSE;
+               } else {
+                       regular_file =3D S_ISREG(st.st_mode) ? TRUE : FALSE=
;
+               }
+       }
+       return regular_file;
+}
+
 int
 read_buf_from_stdin(void *buf, int buf_size)
 {
@@ -5154,11 +5169,12 @@ read_buf_from_stdin(void *buf, int buf_size)
=20
                } else if (0 =3D=3D tmp_read_size) {
                        /*
-                        * If it cannot get any data from a standard input
+                        * If we reach end-of-file on regular file, or
+                        * if we cannot get any data from a standard input
                         * for a long time, break this loop.
                         */
                        tm =3D time(NULL);
-                       if (TIMEOUT_STDIN < (tm - last_time)) {
+                       if (is_stdin_regular_file() || TIMEOUT_STDIN < (tm =
- last_time)) {
                                ERRMSG("Can't get any data from STDIN.\n");
                                return FALSE;
                        }





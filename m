Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C760C7EE30
	for <kexec@archiver.kernel.org>; Wed,  2 Jul 2025 00:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l7awGtliI66LAJvo0a22p3OOz7Ri6woq5boUpEpU7ZE=; b=XNqaLjV8vDqIMBh8rPcsg1CP7p
	E5f7reR/Ys34/RWlHaohq/T3CXdwY68j68aydL8sTu/sIWHHMmaY/ymw7qK3EtxA2vvLf2WUQp/My
	V/EsQi999KQB8DZ+Te9ERjNZYH+TmsfHDvMg3FOCQLJ5MZkb4j0oaGJHkrNTZUSzQwx1CAdrH+8p9
	aFOB/A0Jsc1pP8IHkn9VOU7gWBHQEGMcq28UPbDUBxZXCojWt47WqfE5qm3VLvfL072+/9MA1Ln/F
	cf74OcNeJdCSiwOdXJD3C5q3PKBj1QWb0bDFXkqZLgr78iT+qjLAAy1u9/ZzlmEc3ym3kGKkvJRW7
	QA/BdJPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWl6L-00000006syg-1ZUm;
	Wed, 02 Jul 2025 00:13:25 +0000
Received: from mail-japaneastazlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c405::1] helo=TY3P286CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWl6I-00000006syI-349s
	for kexec@lists.infradead.org;
	Wed, 02 Jul 2025 00:13:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWgRiqkCUN8mswTMHx+DftrBPT3ruG93+rhTorPIka+aq0M0y7pYtSLOUu+TrkhkUWTXESS0XVZpcYTfc9zLT/4Y7iG/FPkdcitGBRXp/sKL7dbQyG07XipDHSyoQtj8bpMzAMDRZhu0gKL73VI/l2d+iYMjFZXneDtPit5Tg/74DyQpO+Rl3xB71cvhaBhr6g5i7S48DVH8FGCZU7DWvBoyMVtOs/Vfgi2W4wH6U2zzUVRD1rhpVKG2P9wxIRhjL1Cskp6KMCL59nhaj5Tom/rIFyLPOEfgIhTEKnWLyZFGcdC5cuSCP0Si9/bFhGSknPhASVFLIejtIh8WXe+tHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7awGtliI66LAJvo0a22p3OOz7Ri6woq5boUpEpU7ZE=;
 b=SqZwjWvLWrQbB0OJ8LfxhIbiW/7tAW4yB00jlAHe7pIcUqq0t7J0xJPNX6QhnTEG6dqiYvAmhxuARXoLclJz8FQg/WAZvOOn2RQv69vX0MFWu8/lUU2J2RBkiVOM1GenJhq9q5bZIlSPg9JqxcCZ7rCpELaJm/4ZNv3VBMQn9hf89zYZn5gYbpCMRkGoNUqXYyijvMl49rXvoYCIHdj2uJxPXIlel226iqrNl9PLhuasVR3GuIrr3SxfnB9z6rMQHyE0AslsqXfi5BGu4zamCEN94MF8fpP0wnRV58NyKAbKLbaeZ1Q3dWYb7FgD2BkUgWVmyQijA/0+tcewU/Rg2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7awGtliI66LAJvo0a22p3OOz7Ri6woq5boUpEpU7ZE=;
 b=oIzSwQrdZhJEuRXEUtzJVhmpeOzzOBVn6IJ10Xj5kAfOzmnjsG2h4M2l+rB/YKpH17u9YdBUQlwT47fwm0zCcWfF5zD5PnCxLCCX6MX6vaCTPZyWD+rIOjzrVNpkZcmaJ/p07yu346pcowFfa0s/COhdzF/Dp3yl9OefclEhzKvc38y1ncexonays6gj4Mwk3FzrviF3+JBZ/cvKlJgB2h3kK552vlV2Sb2npXoLS0aqvfa61bsUZApX7mGmY1k0Ka2ovDHS/G0TSaOAanBylWtRE7OMEAd87TIR6+NG6wg5qEBRde6z6fJSCiommMRlNnbCaNPljiuKsk93+2yt9g==
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com (2603:1096:604:1de::11)
 by OSCPR01MB15752.jpnprd01.prod.outlook.com (2603:1096:604:3b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Wed, 2 Jul
 2025 00:13:15 +0000
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66]) by OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66%4]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 00:13:15 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Tao Liu <ltao@redhat.com>
CC: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>, "sourabhjain@linux.ibm.com"
	<sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v2][makedumpfile] Fix a data race in multi-threading mode
 (--num-threads=N)
Thread-Topic: [PATCH v2][makedumpfile] Fix a data race in multi-threading mode
 (--num-threads=N)
Thread-Index: AQHb5XiBHM/FX67D1ky3gbRMCQy+FbQc6x0AgAAGMoCAAQ/0AA==
Date: Wed, 2 Jul 2025 00:13:15 +0000
Message-ID: <5c425f4e-4e89-4500-993e-e4dfec50a4fb@nec.com>
References: <20250625022343.57529-2-ltao@redhat.com>
 <7c13a968-4a3a-4d0d-8977-3ba0a4a845b1@nec.com>
 <CAO7dBbXpkshxguPbHDA2YFZeYsDAbyswBCQ7x0UKY__4H1K2jQ@mail.gmail.com>
In-Reply-To: <CAO7dBbXpkshxguPbHDA2YFZeYsDAbyswBCQ7x0UKY__4H1K2jQ@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9993:EE_|OSCPR01MB15752:EE_
x-ms-office365-filtering-correlation-id: e3b85e36-793e-4b34-5b3f-08ddb8fd3da5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OTVrMmR4R3pYY1RBMzV6Y2lhZVBzQmlQaTlnckVxUVhob1U1Q3gxK203MjBj?=
 =?utf-8?B?cTE1MDVPdHoxcG0yMWd5aXdDOGExRmxRM2N3UFBJZ1hKVnEra1JaRmFDVjdM?=
 =?utf-8?B?aHZrM1A5MncvWlpac0pZcjRVQ1RYOGVYSk9wbitjTk14WU9XWEtnWUZyNklT?=
 =?utf-8?B?cU93RHBZRFJxV2laZmhTSEIrVzdoYzJaV2xnYTRIbEp4L05YdE5odVhkRU1W?=
 =?utf-8?B?eGV6MUxoNGpPbFdMbTI5cmF1UlJpNXp5NndUdVZwSFdKSWFadHQzMm5kWERJ?=
 =?utf-8?B?MmJMSjJPOW1SZE5JSklQZjRDSTUweXdjd3pkZWFCTmU3MUNzQmJRdnI3OUlK?=
 =?utf-8?B?Wlpxd1JkQjRIRTVQMkV5ZzRQSHFvNEhDWTZjdGdlUVVxQWpnNmt3TnJQcFhZ?=
 =?utf-8?B?dGpneC8xRWpkb3dTQ2w0SHBieEVsVzZPK0l6ZTQyTFZvQjM1SWFQRTUzMVB0?=
 =?utf-8?B?Mi9RTzFjKzg0U2lFWWt4Sy92d0tSdGhJZTJDZUtIQS9nckUrb3oyUG1Cc1pL?=
 =?utf-8?B?R3hNeU04ZGl5bVhrTGdva2g1RGtSM2NWRWEyamhvQzhkRjdsU1FMVWYxMkJF?=
 =?utf-8?B?cDlyNkorN3hzVStwMXAzSzBnWEFCZWdmb1RITGtBcjJ5WGppSVRvZTIvUEJI?=
 =?utf-8?B?ejF3Z2NaT1g4ejlWdTdsTWZDb0N2bm5xK3BHaXB6c0dTSjQ4QmpMbjJ5N2hT?=
 =?utf-8?B?L1Y1SDJtMW1PaHozUjBOay9QV3IzS2hNVXRhT3JNa1Fha3FVN3RNSGphWXk5?=
 =?utf-8?B?cDRCMDBqTWgzVm1iSmpLTVF2akpvNWh2clVZRzZPczRQZE9YZG4xME52L0FN?=
 =?utf-8?B?eEg4NXltaFRmOVBnckl6bDJESTRKWGc4aTAvWDQyOHIxMmc3TGtxSHlIRkpa?=
 =?utf-8?B?RmxlUHNQZmUwOVV6by9JWitBT2JTenFSbkJTWmkvYUNkSk4zWDUyYTZEZ3RX?=
 =?utf-8?B?S3IrdXRpUWJheVlGMDdUY1lUZzZKTzF0VmVkT0I4U0F0MXNFb21Gcm8zL05X?=
 =?utf-8?B?azF5dlAxV0J1QlNnTGJBbEdyclB4akE5Z2dMTHhtb2xDbU1TK3BQQVpuQjR6?=
 =?utf-8?B?VElueHJKWm1QK0dLdktaeE9WUEZKaVRPclUzYVg3c3hlQVBFbHI3V2VKZXB4?=
 =?utf-8?B?Sm5FSVIyZFhHV3dMTU1JSHJMQlFjUDQxOUUvcVBhNURnWnVNQjNFTE0zTnYx?=
 =?utf-8?B?dSt4T3ZxUjlWWnlDZXU2cXVoTDVLVWh6MENmaDhmenA3MkRNMm1Wb0pyc1Y1?=
 =?utf-8?B?cUw2TzN1eGx1c3NhNVpKY044SXBRNXZTRTRqWlZCSEVhMERMb3NwQXl5Z0RO?=
 =?utf-8?B?T1FtTVdtWHgvc1hvcXNxWlhjVmppWFR1eFR2NkFiL2ROSHJLNmN6Szg0ckV4?=
 =?utf-8?B?S1VBWUJ1R1hGY0ZlVEIrdGNTU21HV1h1RUJ0clFTTm1ZRVkydXd4bC9tSU9R?=
 =?utf-8?B?R2VNN2tmdjJJSlNZSGxMYkhoR0ZhR3RDOHhQYU9FaTZKKy80aUovQ0VycXpu?=
 =?utf-8?B?UWVrWmh6MU5JVnV2RzlScXJsbDFUZ0pkR0t4SXVCaVpyZjNzV2VnakpuT2ZG?=
 =?utf-8?B?cVY4ZzlSanBFTTloN000djJTT0F5RjE4Nm9aelJkWE1PUks1L2JXNXJ6R05V?=
 =?utf-8?B?dzNGSkR1TkhERHQ0YmxCQld4ZkxTV0lvR1MxeVVvdk9lUEo1cnRxQjFwdUNy?=
 =?utf-8?B?aFdrNkNaR1lNNUhzenA2c3VMYzY4emJab2FZMDVuWitGVWhmbmc2amxWSlZG?=
 =?utf-8?B?NUFCTjJjcnhsUklkdFVhMkV3ZitPNlFNdnNCWWRpRm53RWZhbGhwUVE5Q3c0?=
 =?utf-8?B?THdJRHgrNm9QUjBnajd5QTVVTnkzaWVna0NjVVZWNGIrRVdqM0JQa1FIWkRT?=
 =?utf-8?B?ZUNuTFBZVHo2NkJ5eXVteWpNZ3VZY2hwSnhqUVdncmpqTGVBSkFrbVhRZ1o2?=
 =?utf-8?B?WGNMbXFtZWgzM0ZSNS9nM1hlc1RVbWIzUVNJV0RGZjM1WjBsRHVJakM0cFdw?=
 =?utf-8?Q?3SNMidL2yUf6RjYwtl+mVoRrAgkAto=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9993.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHpzMi9saU1BTktoMVF0TDhvVHY1SEduVk1SSXkrQ2JqWS9TYjMxUU42TC9J?=
 =?utf-8?B?RDJzRXE3cy8rTG9BN3pVSFBkTUMwR2N5emI4Sm0vU0paeWhyLzZCMHVzV3Aw?=
 =?utf-8?B?aVdkNlpJaTJGVzlWdjExVGl5TzVJMDVSNDc2cHdtaEdBQjg1ZkV4Nmlva3FV?=
 =?utf-8?B?eWtGNloxajNacDZjYm53aEM5WVRYRDNaMWUwZ0swRzl3cnVlVFlRYTBBK05a?=
 =?utf-8?B?dUx3Z3NhUXpEZm5EV3FRN25ONXhSakZvVFBNNEtmZnFHcTJzQXByVEdIZDNr?=
 =?utf-8?B?cGRQQTA3MGsxUDB0ZlY4WDJoNGtqbXFNc1JZRk5KNEZUOHNyUXNUWEtnY05z?=
 =?utf-8?B?VHE1V2RweHhPcGZvSitkelNGcE9qUW5FQ0FTU0FXT0puUU12bEcySVJ4YkZv?=
 =?utf-8?B?Tlp1c043V0NnQ0NSQlMzNnNPOXVmWmpXM0dpZUtFeXNiZmV6RTZtUjQyT012?=
 =?utf-8?B?Tks4ZzkvN1Bpdy9KSnZqS29Cc3V4dGlGNFQ3OElsRWV0K2VCOUZaaGZER1RV?=
 =?utf-8?B?S3pjd2Y0aWVDWnAwMTN4RC9oYmdVU09saU9Fa1N2bkEvS0NyUkxqOXR5ZHVs?=
 =?utf-8?B?d1E5U25sRGZJVktKUHpUOVI3dFpqQUFqaXVQVVNRN2tFbCs2ODRaNmtjZGor?=
 =?utf-8?B?OElueWxhMmVIVWtZaDhja1VrblVzWFRxQzJsWkJwazlPaVNubloxejlvMTNI?=
 =?utf-8?B?M2RrV09XQ0U5U1FxTU1pRjFqaEtxZmFBZUljZTdsdzd4VWR1MFdGUTlvMSsy?=
 =?utf-8?B?c2orZG9Hc0JybGJuclY2eU5hcUhlU21RUmFYL3F5S3g3T0lPNHZHZ1o2QUs5?=
 =?utf-8?B?YTl6QkhvV2J4SkRYSVB1NXJ0bXpwNFp5VktDd2Y1U1pic2Z5WG9rYVhWalVZ?=
 =?utf-8?B?NHdGbmNCSElEMmVkVXduajNhTFpJV1liVlNUN3BIL1Rrd1Z4MnlUWE1LRFhl?=
 =?utf-8?B?ay9MYkUyVHR5N1VoU2hGbC9BUngvUE8xN1dqNWFUT1dBYUNrR3U3WlVHdDdZ?=
 =?utf-8?B?OEFXRFhMU29lQTRLZXQ2cHZCSnJsL2V5d1UxSThscUh4bWZ5aDhsM2djZndu?=
 =?utf-8?B?WGlJSE51NUM5ZWtYR1d2cTNzWUEzOVM5UnRoZE1LQzQxUHU0cDBhdmZJMjdZ?=
 =?utf-8?B?UU5oVnpWNnM2ZjBJRGcwMWNGa1R1QnBNTk5nZFdUbEJXcTBxejU3THZzTHFZ?=
 =?utf-8?B?eDEwSVZ6UzhyL09pRnlWeFVTSzJ0eThpQi9ITjV2bk4xdVRXNGZUREhmdi94?=
 =?utf-8?B?bWJ3ZmdJWG9JY1hSKzFJY0VHamZ2S250MWMxcVNuMkJrbzY2YVcvRmVoQ1dC?=
 =?utf-8?B?MzZPVHJWZldrYjlSSnNyOTdRTkpBeDQ2bk9zeU5hVzV2eWVrU3cyZ3JBTHFG?=
 =?utf-8?B?aklkY3lUcnJLMzYrRjJ4RXVDeXNBdWRFak9xaTJZa0V2V1JaWm03VFV5dmwv?=
 =?utf-8?B?am05ajZsRFgyWWZ1eTZEeUF6ZVgzcFFYRzh0UVc5bno0RzR5bFRDVGFVVGRP?=
 =?utf-8?B?ejZlTlB2aGN6V3Q4UUVCaHphQWNqQThRWng0dDd3UFNTZUhKRWVVK3RsYnVZ?=
 =?utf-8?B?WTNYL2cydk03TExXQXB3QjJHK1o4UzhCN3A4aWU1SFRlR3pSbmtBZzB5dTNC?=
 =?utf-8?B?WG0xTVFTYTBxdThoYWFBY3RUeDZZdVNLeTVlL3M4Z1MySmJJSFBySUZWUUYv?=
 =?utf-8?B?b1M4VkhFUEhPVW1wWDlYNFpNVUZMVUYycVZrdVFqMGtCd1hJOVZ3Ry82REJ5?=
 =?utf-8?B?R2JsQlAxSVhHTHd3eVVYZzVUM3d2ZFRZN01VcVVTNHhIK0c5WHZuN2ZtQUo4?=
 =?utf-8?B?NXhTN2UzaGFFRU1YL1FJcDZndklYc0NySGpjVFpEWVVnbEQ1aWpiSUZ1UjJ4?=
 =?utf-8?B?bHhuQ0QwREdQRGYySXM5dkdsVld6bVY3d0R2ZHV2YlZoQTA3YkFQSG5mc1Vk?=
 =?utf-8?B?QjRZd0xhK3J5MGpYL2VzeEN6R0Q2eW9ucmFvWDQzRDl4SHI0TERQVkI1Mmpw?=
 =?utf-8?B?YnhkZk54bXZ0RWFqWHFGaExLWXhKTzFZZEJMZ1ZxQkNWLy9UR2pzN0EwMVE5?=
 =?utf-8?B?RHlHbHVVYzg0YzRtU2djdU1WeFZ3b0dWVnZ5bFhaS010T3lrZ09hQ3FXT25L?=
 =?utf-8?Q?+PB9iHMKDh9p2CuutCxx78luX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F5DE7C3F97B354694DFFA1447A99032@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9993.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b85e36-793e-4b34-5b3f-08ddb8fd3da5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 00:13:15.6596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P3Wv4CY+ZmE8O1BnaVa5uN8dPDv3sRIK7HBI4ln8U+K75clqth5rgvYzdoVW3t39+qKVrt+J8HSj7dhpnc52tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15752
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_171322_881895_3AAD57ED 
X-CRM114-Status: GOOD (  30.62  )
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

T24gMjAyNS8wNy8wMSAxNjo1OSwgVGFvIExpdSB3cm90ZToNCj4gSGkgS2F6dSwNCj4gDQo+IFRo
YW5rcyBmb3IgeW91ciBjb21tZW50cyENCj4gDQo+IE9uIFR1ZSwgSnVsIDEsIDIwMjUgYXQgNzoz
OOKAr1BNIEhBR0lPIEtBWlVISVRPKOiQqeWwvuOAgOS4gOS7gSkgPGstaGFnaW8tYWJAbmVjLmNv
bT4gd3JvdGU6DQo+Pg0KPj4gSGkgVGFvLA0KPj4NCj4+IHRoYW5rIHlvdSBmb3IgdGhlIHBhdGNo
Lg0KPj4NCj4+IE9uIDIwMjUvMDYvMjUgMTE6MjMsIFRhbyBMaXUgd3JvdGU6DQo+Pj4gQSB2bWNv
cmUgY29ycnVwdCBpc3N1ZSBoYXMgYmVlbiBub3RpY2VkIGluIHBvd2VycGMgYXJjaCBbMV0uIEl0
IGNhbiBiZQ0KPj4+IHJlcHJvZHVjZWQgd2l0aCB1cHN0cmVhbSBtYWtlZHVtcGZpbGUuDQo+Pj4N
Cj4+PiBXaGVuIGFuYWx5emluZyB0aGUgY29ycnVwdCB2bWNvcmUgdXNpbmcgY3Jhc2gsIHRoZSBm
b2xsb3dpbmcgZXJyb3INCj4+PiBtZXNzYWdlIHdpbGwgb3V0cHV0Og0KPj4+DQo+Pj4gICAgICAg
Y3Jhc2g6IGNvbXByZXNzZWQga2R1bXA6IHVuY29tcHJlc3MgZmFpbGVkOiAwDQo+Pj4gICAgICAg
Y3Jhc2g6IHJlYWQgZXJyb3I6IGtlcm5lbCB2aXJ0dWFsIGFkZHJlc3M6IGMwMDAxZTJkMmZlNDgw
MDAgIHR5cGU6DQo+Pj4gICAgICAgImhhcmRpcnEgdGhyZWFkX3VuaW9uIg0KPj4+ICAgICAgIGNy
YXNoOiBjYW5ub3QgcmVhZCBoYXJkaXJxX2N0eFs5MzBdIGF0IGMwMDAxZTJkMmZlNDgwMDANCj4+
PiAgICAgICBjcmFzaDogY29tcHJlc3NlZCBrZHVtcDogdW5jb21wcmVzcyBmYWlsZWQ6IDANCj4+
Pg0KPj4+IElmIHRoZSB2bWNvcmUgaXMgZ2VuZXJhdGVkIHdpdGhvdXQgbnVtLXRocmVhZHMgb3B0
aW9uLCB0aGVuIG5vIHN1Y2gNCj4+PiBlcnJvcnMgYXJlIG5vdGljZWQuDQo+Pj4NCj4+PiBXaXRo
IC0tbnVtLXRocmVhZHM9TiBlbmFibGVkLCB0aGVyZSB3aWxsIGJlIE4gc3ViLXRocmVhZHMgY3Jl
YXRlZC4gQWxsDQo+Pj4gc3ViLXRocmVhZHMgYXJlIHByb2R1Y2VycyB3aGljaCByZXNwb25zaWJs
ZSBmb3IgbW0gcGFnZSBwcm9jZXNzaW5nLCBlLmcuDQo+Pj4gY29tcHJlc3Npb24uIFRoZSBtYWlu
IHRocmVhZCBpcyB0aGUgY29uc3VtZXIgd2hpY2ggcmVzcG9uc2libGUgZm9yDQo+Pj4gd3JpdGlu
ZyB0aGUgY29tcHJlc3NlZCBkYXRhIGludG8gZmlsZS4gcGFnZV9mbGFnX2J1Zi0+cmVhZHkgaXMg
dXNlZCB0bw0KPj4+IHN5bmMgbWFpbiBhbmQgc3ViLXRocmVhZHMuIFdoZW4gYSBzdWItdGhyZWFk
IGZpbmlzaGVzIHBhZ2UgcHJvY2Vzc2luZywNCj4+PiBpdCB3aWxsIHNldCByZWFkeSBmbGFnIHRv
IGJlIEZMQUdfUkVBRFkuIEluIHRoZSBtZWFudGltZSwgbWFpbiB0aHJlYWQNCj4+PiBsb29wbHkg
Y2hlY2sgYWxsIHRocmVhZHMgb2YgdGhlIHJlYWR5IGZsYWdzLCBhbmQgYnJlYWsgdGhlIGxvb3Ag
d2hlbg0KPj4+IGZpbmQgRkxBR19SRUFEWS4NCj4+DQo+PiBJJ3ZlIHRyaWVkIHRvIHJlcHJvZHVj
ZSB0aGUgaXNzdWUsIGJ1dCBJIGNvdWxkbid0IG9uIHg4Nl82NC4NCj4gDQo+IFllcywgSSBjYW5u
b3QgcmVwcm9kdWNlIGl0IG9uIHg4Nl82NCBlaXRoZXIsIGJ1dCB0aGUgaXNzdWUgaXMgdmVyeQ0K
PiBlYXNpbHkgcmVwcm9kdWNlZCBvbiBwcGM2NCBhcmNoLCB3aGljaCBpcyB3aGVyZSBvdXIgUUUg
cmVwb3J0ZWQuDQo+IFJlY2VudGx5IHdlIGhhdmUgZW5hYmxlZCAtLW51bS10aHJlYWRzPU4gaW4g
cmhlbCBieSBkZWZhdWx0LiBOID09DQo+IG5yX2NwdXMgaW4gMm5kIGtlcm5lbCwgc28gUUUgbm90
aWNlZCB0aGUgaXNzdWUuDQoNCkkgc2VlLCB0aGFuayB5b3UgZm9yIHRoZSBpbmZvcm1hdGlvbi4N
Cg0KPiANCj4+DQo+PiBEbyB5b3UgaGF2ZSBhbnkgcG9zc2libGUgc2NlbmFyaW8gdGhhdCBicmVh
a3MgYSB2bWNvcmU/ICBJIGNvdWxkIG5vdA0KPj4gdGhpbmsgb2YgaXQgb25seSBieSBsb29raW5n
IGF0IHRoZSBjb2RlLg0KPiANCj4gSSBndWVzcyB0aGUgaXNzdWUgb25seSBiZWVuIG9ic2VydmVk
IG9uIHBwYyBtaWdodCBiZSBkdWUgdG8gcHBjJ3MNCj4gbWVtb3J5IG1vZGVsLCBtdWx0aS10aHJl
YWQgc2NoZWR1bGluZyBhbGdvcml0aG0gZXRjLiBJJ20gbm90IGFuIGV4cGVydA0KPiBvbiB0aG9z
ZS4gU28gSSBjYW5ub3QgZ2l2ZSBhIGNsZWFyIGV4cGxhbmF0aW9uLCBzb3JyeS4uLg0KDQpvaywg
SSBhbHNvIGRvbid0IHRoaW5rIG9mIGhvdyB0byBkZWJ1ZyB0aGlzIHdlbGwuLg0KDQo+IA0KPiBU
aGUgcGFnZV9mbGFnX2J1Zi0+cmVhZHkgaXMgYW4gaW50ZWdlciB0aGF0IHIvdyBieSBtYWluIGFu
ZCBzdWINCj4gdGhyZWFkcyBzaW11bHRhbmVvdXNseS4gQW5kIHRoZSBhc3NpZ25tZW50IG9wZXJh
dGlvbiwgbGlrZQ0KPiBwYWdlX2ZsYWdfYnVmLT5yZWFkeSA9IDEsIG1pZ2h0IGJlIGNvbXBvc2Vk
IG9mIHNldmVyYWwgYXNzZW1ibHkNCj4gaW5zdHJ1Y3Rpb25zLiBXaXRob3V0IGF0b21pYyByL3cg
KG1lbW9yeSkgcHJvdGVjdGlvbiwgdGhlcmUgbWlnaHQgYmUNCj4gcmFjaW5nIHIvdyBqdXN0IHdp
dGhpbiB0aGUgZmV3IGluc3RydWN0aW9ucywgd2hpY2ggY2F1c2VkIHRoZSBkYXRhDQo+IGluY29u
c2lzdGVuY3kuIEZyYW5rbHkgdGhlIHBwYyBhc3NlbWJseSBjb25zaXN0cyBvZiBtb3JlIGluc3Ry
dWN0aW9ucw0KPiB0aGFuIHg4Nl82NCBmb3IgdGhlIHNhbWUgYyBjb2RlLCB3aGljaCBlbmxhcmdl
ZCB0aGUgcG9zc2liaWxpdHkgb2YNCj4gZGF0YSByYWNpbmcuDQo+IA0KPiBXZSBjYW4gb2JzZXJ2
ZSB0aGUgaXNzdWUgd2l0aG91dCB0aGUgaGVscCBvZiBjcmFzaCwganVzdCBjb21wYXJlIHRoZQ0K
PiBiaW5hcnkgb3V0cHV0IG9mIHZtY29yZSBnZW5lcmF0ZWQgZnJvbSB0aGUgc2FtZSBjb3JlIGZp
bGUsIGFuZA0KPiBjb21wcmVzcyBpdCB3aXRoIG9yIHdpdGhvdXQgLS1udW0tdGhyZWFkcyBvcHRp
b24uIFRoZW4gY29tcGFyZSBpdCB3aXRoDQo+ICJjbXAgdm1jb3JlMSB2bWNvcmUyIiBjbWRsaW5l
LCBhbmQgY21wIHdpbGwgb3V0cHV0IGJ5dGVzIGRpZmZlciBmb3INCj4gdGhlIDIgdm1jb3Jlcywg
YW5kIHRoaXMgaXMgdW5leHBlY3RlZC4NCj4gDQo+Pg0KPj4gYW5kIHRoaXMgaXMganVzdCBvdXQg
b2YgY3VyaW9zaXR5LCBpcyB0aGUgaXNzdWUgcmVwcm9kdWNlZCB3aXRoDQo+PiBtYWtlZHVtcGZp
bGUgY29tcGlsZWQgd2l0aCAtTzAgdG9vPw0KPiANCj4gU29ycnksIEkgaGF2ZW4ndCBkb25lIHRo
ZSAtTzAgZXhwZXJpbWVudCwgSSBjYW4gZG8gaXQgdG9tb3Jyb3cgYW5kDQo+IHNoYXJlIG15IGZp
bmRpbmdzLi4uDQoNClRoYW5rcywgd2UgaGF2ZSB0byBmaXggdGhpcyBhbnl3YXksIEkgd2FudCBh
IGNsdWUgdG8gdGhpbmsgYWJvdXQgYSANCnBvc3NpYmxlIHNjZW5hcmlvLi4NCg0KVGhhbmtzLA0K
S2F6dQ==


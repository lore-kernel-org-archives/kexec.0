Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDD1C77B7F
	for <kexec@archiver.kernel.org>; Mon,  8 May 2023 10:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TpQxsxySqu9bHBMeb3H5BetZWqEu9J8Fzi6/j2sovoM=; b=3JJptbmMiYtL9t
	/RzJVijSLu5HCUxruIKahvfDT3HZh3fvlfY0KCigNw7S6aW+1e+SQwE1pOuEvncktEmxmsTzfatP8
	EbMICMlFXScGSSVbwcuK+9ZvGhREXenQa1jCYcMLucnR3ne5duwXbXACN/LVL5aGGYv8lQ+vSjR0g
	zQ8qfecTZuZ9oppxzA4+GYkGvaTBUpleOjUSyQQArZLz0Ivq6lD+wl9vU08tFPUQ0M9HkIwPG9RLZ
	MVyrcDAfhIzd6CfI400chl4lZFnJ0Gze/hddCOWObKFSrdKeTDdp7omQPv6sUOaGu7o8XOy5A6wGo
	iHQ3pOV6hiz/BVyib9tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pvyJV-000KF2-3B;
	Mon, 08 May 2023 10:41:54 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pvyJT-000KE8-27
	for kexec@bombadil.infradead.org;
	Mon, 08 May 2023 10:41:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To
	:From:Sender:Reply-To:Content-Description;
	bh=bxAJ94fTRwnJlrBy3/Vcz0J3sPe5ZF21V14m9SUB09Y=; b=hwImbVFdrk7X7+XF8vQCvGzRFg
	z4pwOUe6bL6DO/9EjPokGUqN1oMnRIEp1oqw13RcjHq7NsxCMfpdu7VBBKJwmRvdTI8fon7zAkQz7
	rER6GDIc/eWmdsdwVan28+ynoIb/V9QBsEPwNhnr8isJfUngjuaB8qUCMFXNv/oYRQ4iR6ysCtOwI
	cmghy5TylqU0P0C94nC+d95rPfNJF2dtqhh+f3ksBslSpr8XNhqrjrIKNDyB6PyfF8PbPzE9wRQel
	q1EilZJlILpUsBzcXcPTXbWrV58y/XAZ5PpA7Cc9sOhqhhESqc+iCm1QcD7KkxyYHqtEnoiGm8op7
	f89jgtWQ==;
Received: from esa2.fujitsucc.c3s2.iphmx.com ([68.232.152.246])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pvxRb-0057Jw-1c
	for kexec@lists.infradead.org;
	Mon, 08 May 2023 09:46:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1683539171; x=1715075171;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bxAJ94fTRwnJlrBy3/Vcz0J3sPe5ZF21V14m9SUB09Y=;
  b=DANMp1breagaxEoLun2GHblJGqsuP6iqVFx/NBy/rxX3RoggGbnPtEBE
   CfSgIf+g2hzdhUmRg2Rhv4WoiyszY2fJyyJ8csfWj90zLdFsf0DBAt0TO
   2UoweRtJ0EtPKJtCJbjLFqfv/VLLV+uxXmSMCOQaEr6RfHnddP3bv24CV
   U9+cCV5Bb/wGx67idAwutxBVfRojssP9qWYdC9udFQY/t7q+n2uyinLfY
   vDVdeWPpRkgUaihOd6+8klpdMheY4woGwPOshkPe2bISprAkHXuwWw+89
   Sdc7iBCutk2Eg5R3knBJw1x/7bqAxZv+0FJJ0lpGbSdtqs1qfMRf+bNO+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="92012919"
X-IronPort-AV: E=Sophos;i="5.99,258,1677510000"; 
   d="scan'208";a="92012919"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 18:46:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2NjqtAMAKqEuVBVBzi9VpJyDZIX6wyYxUB37XBrIq5+QflQKobIjCROPVwRk0GUa9400CzSpyIoYUNE8HHXVcO6Qw7oSIMAh9N4vfw2hxkKb363snakJdJmqzKvPrw4N84i3dBG+XJfOFaoKny65hlp29N55TGXJGsgAe0otagjYuaRDM9tNc3aHSr8r+gbjnMeJXU22u37Iu685MfoHoMNhHsTAZsBN83RpRrrN87LSfJVGFbkV4iPTl1awSId4CT/j39RsupxLPAaA327753eRWYdtfOeO54AB09bk5t6cuaPpK+dX3ncb6Xmsl8R00FSngpjtmORU8N9LlU4nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxAJ94fTRwnJlrBy3/Vcz0J3sPe5ZF21V14m9SUB09Y=;
 b=bXGjnIkf1dTstss2EIQqKyURlKixaMYp/o+4QxsI3YmZsRuUcBIobaAA7WG9/3Yyzi0AIH349hrgQIyLsVlovdVO57ZY229OOOu+XtRGP0Qq3fT5uBsE9mfqnEdtJ9X2qLe6ud/RBZNAm8YL5wSlqGixWGvmGxcYbM+y4ibVsqBr6tpw0+tvZjaa41wa+Dd3IdTWdxi+M11Afk1mlL8ZG44GUUHD96P8pwZTEbj75qzuxWs1zN9NeMTPzzH9hbIpoIOoiFjp7/UxlflF0YGrzxK2smk3T0xPcU8iH0ucTGPV0mVRmfTbEVcDary7Z1evefApXoDV9VBgP6QtMEnhFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYWPR01MB10630.jpnprd01.prod.outlook.com (2603:1096:400:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 09:45:58 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::687d:4884:ec0b:8835]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::687d:4884:ec0b:8835%7]) with mapi id 15.20.6363.030; Mon, 8 May 2023
 09:45:58 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Dan Williams <dan.j.williams@intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Yasunori
 Gotou (Fujitsu)" <y-goto@fujitsu.com>, "Xiao Yang (Fujitsu)"
	<yangx.jy@fujitsu.com>, "Shiyang Ruan (Fujitsu)" <ruansy.fnst@fujitsu.com>
Subject: Re: [RFC PATCH v2 0/3] pmem memmap dump support
Thread-Topic: [RFC PATCH v2 0/3] pmem memmap dump support
Thread-Index: AQHZePGyDbRSw7SlpU2xnWSJHHhjFK9BFSkAgA8cuQA=
Date: Mon, 8 May 2023 09:45:57 +0000
Message-ID: <774fd596-5481-aeff-aace-8785158728ea@fujitsu.com>
References: <20230427101838.12267-1-lizhijian@fujitsu.com>
 <644c17823cf83_13303129460@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <644c17823cf83_13303129460@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYWPR01MB10630:EE_
x-ms-office365-filtering-correlation-id: 397165bc-e761-4f06-7456-08db4fa90675
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  ONjInwk9HAGisEU3A6PB5rk/1akACsCpuel0Y2JddPF0M2FeqJZxiuBvv/t5P8vLjQ5bSyRizaEoA7yvYDfwqD8//IEbXcoGbpo2PgxP7Ksdt36C886dw9yuVcMP/qH7Rh8EwdOJz4ZS/bbS7y/5ervtWaoFd+8TI1/B6Ejlqja7mVheVOPeryPsz9C4nCjkTo0owat5P1Q+1WOv7XABXSAdiV76DxDTRz7VGSSkgNHtcJxvEKdu46cECbE8b5VMuw0YGrKZ8P7rdUs9K9uOESX099nydqzzqjbUeg41ArvMh+QmA7cIqqPMEqV+KCst8JcBziRu9q5+AgW4htoLBZDuuT0HlglWJa4vq6hT6ENdbGq3zjDIO7jez6JmQuhUgVbyKQXzgxzV8WAdZ+o5e7D9L4I2gohsf/LiWsNtcaiaI3LPBN4VENq59/pv8QIUR3MUylVPoZM3G+wUwzDQAq+zgeWc7wbLXE8t/nLtBjzkrgJmKTX7D3S7Wn8Vf2yfaCK9+j98KI8YYaRENwDK3csn4pSbtB9BerXro0jBukp6El7JsACgMXw0c9N0lIdMwtuwEYYO4IRGngfY2DqsNjhquHyRF6PJ8p3mrUFJpzGiPl6Kw1ghf653xq2kvgZcBynX5zUQ9iDgiM76g/CVGlF4I1Z77BP+1SOnJTGk7DdKS3P1CrMTxdq39q7qNYpCmd++YP7cL9bdHC8d+Ae0Yg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11664.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(1590799018)(451199021)(83380400001)(966005)(91956017)(6486002)(478600001)(71200400001)(110136005)(54906003)(2616005)(6512007)(6506007)(26005)(53546011)(186003)(107886003)(2906002)(38100700002)(36756003)(66946007)(76116006)(64756008)(82960400001)(66446008)(66476007)(122000001)(4326008)(41300700001)(66556008)(85182001)(8676002)(8936002)(38070700005)(31696002)(86362001)(5660300002)(316002)(31686004)(1580799015)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?WGdMNG1tS3g3MVVtZVJWUjg1NHcyejRkZjQzYXlyRVhBc2Z5djBkUkk4ejJh?=
 =?utf-8?B?MGxDTXZLa1g5RGpsRCszTWRqMU82ckdWQzBoM2NQNlpHUEtSN0owWVdKd3NV?=
 =?utf-8?B?cXFBdjN1eVhGbU1CVTZCVDhmQTVyOHFkTGY3MVBDTzMzbkJodkxFbE9ZekMx?=
 =?utf-8?B?ekJiaVVJZHZMMVl4a2xqaEdqd3pmT2hWTDBnbWhtQldqdFZxMVRabjk1bXVV?=
 =?utf-8?B?RUNXVWxtb3pGaEllSmhhL08raW0yVmxoMG90NVZpRVBXeE9iRzVjVldyenFJ?=
 =?utf-8?B?dkFseHJEaWlRMmczcWk5TXJPV3ZFS2dvTGRXeitwVlN6b0FJZlZxNDdBQjZi?=
 =?utf-8?B?VE5tY3hMT3JHSTlDd2FTWVRJbFhSNkVra2dia2ZEL1dRRXN4RUloRkFOK05B?=
 =?utf-8?B?VTUyR1JGamlHRGxEQ3k2RzRZRWFzTjZha3dvMHdKQ3l4OVhPYXB2a0E0ZWpy?=
 =?utf-8?B?VHQ3VlZJSEQrRmc1OTVSWHBhSUNMVlBkOEtkSmNYaTl2WVB0U2NDZ3o5NGRm?=
 =?utf-8?B?d2trSXZUYjFXSmxUUW9TelRQTE9Wb3NiK3lqcFNzR01SaUhoVVVZUHozVVdW?=
 =?utf-8?B?MG93OWNjSzRML3V2YjhCNEhsdHB1Lzl0ZmhXazBCVW5DK1RaejRhSGVHQzEr?=
 =?utf-8?B?NlBFTUdGRUMrRmhsT0NmdmJyU0s5QkVvTFF4cFRoYzNZSXFSOTk1MWNJN2kr?=
 =?utf-8?B?d0RkeXpSa1hOcFhFNTFmSWVkelJMamR0WDN3TnhOUytUOGFGaWltc2V1T1Ri?=
 =?utf-8?B?RDVVUWVsNWptdmVVUExnUG9rZG9Fb0FPVWV3K1JKNTZQM29STWhZeU1PZTUz?=
 =?utf-8?B?aC9ZUjFHOURjZXhTTythTWk4T3dpb2VyQ0k3UUxRZUw1aGpOdmRKc002NTdI?=
 =?utf-8?B?N3M3NDB6c0x4SnlzOGZHMHNIcUVoMlpPRUhFVEFEOFNHblRiNVJLd200VFk0?=
 =?utf-8?B?QVYxZVIwL2xHN2hSd3R0amp5NEpwNmI1M2pDYXhxdktzVlJrR1J4dTI5dlUz?=
 =?utf-8?B?VVVhTUdRVkw3SVprL3ZkNkY2WWlzcFdtU21vdjlOYlRNWFlRN0F5RDFtaWpu?=
 =?utf-8?B?Z3hQckNNWFhXTjA3dDNEZ2lZZWZVQ1Z2L2dRb1ZFN0Q0a1h6NUdwY0ZDS2Mz?=
 =?utf-8?B?OG9aMWRpNUVmbzFFWWNta2FldGswaTVSTllhNHRxQm94dXAzaUl4eDRXU3Na?=
 =?utf-8?B?UC9MZ1JmVWo1NXdxWEV6Z21Hbyt3NEtzeE1NMWUrR0tUdWg0M1E5aDhUWity?=
 =?utf-8?B?aEN6T1RPcVRVMkZpdEJTVFJHei9HS2h2WVdPL3hUR05QaUljdW82MjRDd2ll?=
 =?utf-8?B?dlFBaXI1QzRHUmZNVit6bDBJNGx1QUI4Tm16L2prSHh1MnVlUytvUlc2a0My?=
 =?utf-8?B?UkZwQmJKWW9KdHFEL1ZEanhLVGRpdzhaQVBqU21MVEkwVTcyWGY4S2k1M3VO?=
 =?utf-8?B?eGVTai9DNmo5RVZqV3FxN3R2aUZuSlhhL1dIQ1RRemJ4ckpCdGNlMklzdlZB?=
 =?utf-8?B?bllqdkh1bFF5MXFOR3owYTBrS0p6VzFldDI3bHVsZ3lIZEpudktHUUJIMlFm?=
 =?utf-8?B?M2RNZUlUaWFEdFBaNHRDcHljb1IwMWlOSytPaW8vT1AyTGthb1FiRjYzNndQ?=
 =?utf-8?B?NVk2SzZsSm8zQWRsdkZRM2wvcC9YTjYwY2x5ek94dDJJUFNWR0xOampNc0N6?=
 =?utf-8?B?QWZhZUtRRGVFZjE4S1N0QmFLVlMrYzNMZUZpOE9pM2dCQWF3UXg4MFlVVU81?=
 =?utf-8?B?UFpOdFpNR25TMkhmTHdnbTlma2tkLzgvWlhUOVNiRDMvL1FsS1VDSktFY0c3?=
 =?utf-8?B?YnEvQ2hpQUhIdjhzdFBNRkVDTnNMN0JxNjhTSXhJdHRxL1FHOEhhbjlvVUJO?=
 =?utf-8?B?NnVIZTBMWUoxUEUrRFRIaXI0SUtHcnFsZ1hCenlkUzFkL0padkJIWVVLcTVK?=
 =?utf-8?B?Wkt2blNHYW1aN0RDZnpKOFc1bkJoSEplY3lOelUyOHJKMFErUmNaUGZ0dUw3?=
 =?utf-8?B?MEU4SE5lemRNL3QvVnY3VzRRcHkyb3pZTUc2VHQ5Z2pvYXA3R3BCMS90RWNj?=
 =?utf-8?B?bWE1emtGeUIySFlyeDhNZm54OWNLcGZRaTkxYU9mYWpqV0N4aFFtbG1CbTVH?=
 =?utf-8?B?a3JRa0hvMG1TakF0ZlMzK3FWWGNVckwrMkRwYjZiSVhWNkZ3R1hBUHpta2sy?=
 =?utf-8?B?Vmc9PQ==?=
Content-ID: <91293082011AD6408392E24906E9C504@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	YFarCe495PxMKRHkZpXIHMmrVKk5FtHRgDRWQx/PzYIpPPudsQCJiwTq+5laAXVAWv5w/rcT6cNmDAT3yOdGZ2giItWWXNiLKd6NQaL9eS1u5WCqD+LvxkxoM+t68VpdMUmUnYUvF13+9XRsBCLPPjtCly3qohztBKxetm+B9krTV9KzKfA/WeFBtSZY17QimT7Is6YwXGqY4kyS6NmwXM54BA3fR5tu3hGBgE7MDDYpJ9cNy59j2hS47Ndy9nM0OvgaFCOUuCKcDfnVrpCiEetz9e7GZ9fHT66sYlYPTXP55x4FA7O8xgxhkU+zb+Un8arwOMGFj4jJOgfOo3Dnfqx5IVm+0ml0eLPotksFBEimk1cfdESqjiIBHKaQX29fPPKZMl6BUBtpFtqbjkqvnoLaDthDbajqb0pc4XK6hIBS85mEBxOvHLFR3BuvRfltgIJDQmRcRMPFz82ZuFzcEsf8l6RRGQ6PxojEQlAVuOMdWlPLQrY6UyhRADe98zahx4QE+ltHStBE3PD7r54pK1zZWyArschkAFsns5pcqTv8sfwcpAAr5ittI3zv2kbrPUieDGiY4LeDzuKA2kC5wILZczeiX4BlMPDFpK0XD/Zc85a9SoJ1qkj+xHuwstSAFLEHaZf43VQUiNg7K5S9W2+57i2LXvUCyjjLOn4pPl8gvEbSz/F5FU/SBQq1BT4BC5Dkx1AVmZH68PXKnyMU2zHN/XJu9vB1M9W7zf07+MomsL2oBFKoYP6ZBhjtHFD1SnBi+k2ofPATr9sXr2V+L1fnHbOj4Y0MA9XMx7S7P5SoLA92hRtQ+avvcDI87YTVpL9exg1Ew/xVuC5L3vjrfXkqHvutGhbLrFSownmUgQvxTjzrfPz8hyf5txC6rm1ZztExTXufKBmk1l4Le8sTFszaEPEkHHwGMa9MP2+YTFE=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 397165bc-e761-4f06-7456-08db4fa90675
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 09:45:57.9245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zaVsGzuau8+1ez1oOhctYAbblKbUg3a7pfwfGuo/+NeV9MoJOheP/gvgR6g5+4SOJoltDbnHNiIedhWtEp6QWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10630
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230508_104611_774337_D3EC02AD 
X-CRM114-Status: GOOD (  16.19  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Dan,


On 29/04/2023 02:59, Dan Williams wrote:
> Li Zhijian wrote:
>> Hello folks,
>>
>> About 2 months ago, we posted our first RFC[3] and received your kindly feedback. Thank you :)
>> Now, I'm back with the code.
>>
>> Currently, this RFC has already implemented to supported case D*. And the case A&B is disabled
>> deliberately in makedumpfile. It includes changes in 3 source code as below:
> 
> I think the reason this patchkit is difficult to follow is that it
> spends a lot of time describing a chosen solution, but not enough time
> describing the problem and the tradeoffs.
> 
> For example why is updating /proc/vmcore with pmem metadata the chosen
> solution? Why not leave the kernel out of it and have makedumpfile
> tooling aware of how to parse persistent memory namespace info-blocks
> and retrieve that dump itself? This is what I proposed here:
> 
> http://lore.kernel.org/r/641484f7ef780_a52e2940@dwillia2-mobl3.amr.corp.intel.com.notmuch

Sorry for the late reply. I'm just back from the vacation.
And sorry again for missing your previous *important* information in V1.

Your proposal also sounds to me with less kernel changes, but more ndctl coupling with makedumpfile tools.
In my current understanding, it will includes following source changes.

-----------+-------------------------------------------------------------------+
Source     |                      changes                                      |
-----------+-------------------------------------------------------------------+
I.         | 1. enter force_raw in kdump kernel automatically(avoid metadata being updated again)|
kernel     |                                                                   |
            | 2. mark the whole pmem's PT_LOAD for kexec_file_load(2) syscall   |
-----------+-------------------------------------------------------------------+
II. kexec- | 1. mark the whole pmem's PT_LOAD for kexe_load(2) syscall         |
tool       |                                                                   |
-----------+-------------------------------------------------------------------+
III.       | 1. parse the infoblock and calculate the boundaries of userdata and metadata   |
makedump-  | 2. skip pmem userdata region                                      |
file       | 3. exclude pmem metadata region if needed                         |
-----------+-------------------------------------------------------------------+

I will try rewrite it with your proposal ASAP

Thanks again

Thanks
Zhijian

> 
> ...but never got an answer, or I missed the answer.
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65584C6FD1D
	for <kexec@archiver.kernel.org>; Fri, 17 Mar 2023 07:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rLRhhnmW2jwazW3CxSQe+FWvMM0tZPAgkK+WNis9yQI=; b=CUPIGjSLi7bbRA
	yr4wlQno5CygzlyMvPRhOYIkBAcVV+kIlTsVQCV/yF+j+0QPPx6zkbUfaJ7rKndcNxvCKISnF6Ysa
	lKsTXZtXgy9XWPNFPHWvzqIKKwXv0g8VAgIc/bk1znk7dTP/2DXCTwwv3ofcsDni4dZ27pYfQHbJT
	hNp8+24YdLiEXbgFG0FP85WJ+GtMSA98kryY5W3vZlaqyaJBohSG7x1KALJEx5xPkGtUUqPwSq56f
	uunZNE8rDQIupJleBQWclHYpWN+eAMbn5R6VoSMYcr/w7Iat/bfVpi406rqwqwsr2YK1N8Lod6/uo
	OQQpWDBLji7FUKNBmwYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pd4Y0-001ISX-0I;
	Fri, 17 Mar 2023 07:30:44 +0000
Received: from esa19.fujitsucc.c3s2.iphmx.com ([216.71.158.62])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pd4Xv-001IQb-2t
	for kexec@lists.infradead.org;
	Fri, 17 Mar 2023 07:30:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1679038240; x=1710574240;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WN0QXl2Mb6JWJpSbQ89wZp6I36j7hS1gTMuPJwdPioc=;
  b=upMxRwxZNEPYw8E+yirEk20mmuC0zC1eR8J41Dpoh3v9k4DJy7iUhSw9
   nwZCPEfF2jwTP/6nNdcB8VuI8Yf8RRFiVz4j9iiTIV2PK4IEWIVDTGv+H
   IYnIi8QFSXnAb01/4p1AFzUnLjmBwjo5cZoDMxoGz0lq38Q3ZiBA7rOaY
   Wpa+DO/rZgKl+VcgqCVi4LwM7HC5W9/hQI3sxz2YjkTmACZvHgUm/LRAH
   YRiXfVw+WCOAmfFveqOphV940MsHEHwVbTKkeJvZXpnatJyTdjFbY93IF
   AlAoRQLKpjLu12N2kIM2vQjKaXgDdprqFmOPsVknVIeQq4sIkFnrvX/k5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="79139383"
X-IronPort-AV: E=Sophos;i="5.98,268,1673881200"; 
   d="scan'208";a="79139383"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 16:30:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3zocRDGAwJoParASziNV7Hyc29LSlGXXENhG3Gz/a5VcjFCKYnnOfaB3XZNqHKc6U4ySzYTVvh80x28RjpuDgANfCURZMrcjgKGrE+Twk/jrac6k2Y6e5s1MvjruBS8FGoDLJibW0poAwveDBrBNdTM8mIrMq+9WKnD2+5iZc40IfdcJkYua6dE+AYk0QZ3SkyujREExttCZtWBHG47oSy6207Icg/c+jgr4EW/S5wlsidATID5i2NON01qjA3P+9smLbBmNCGzPQfFMy66ZlYDi9ouiV6jZuEY27S+CK8DUicXP/YrHvWOhRk5moz/tjr2rW72HJAaK9SbuBr44g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WN0QXl2Mb6JWJpSbQ89wZp6I36j7hS1gTMuPJwdPioc=;
 b=e1+7GUw/Rm0LKkoXIxD0VOAtS4H1kKmvaUJB4+j/PjN3P62K1yGwd5PzpzPJZMaW+L85jyNX0zDP5eKmoRJzW3HInMMyMA+t9Sogh2f1DyBuGg5dCUNeDSO6VLFqfcYTxUKJqObjCvMvMeeOB+PpgsXo1ZYk/ntc52NiVVaWWO1Na7mZOLir5kg0qDYAlstKHUYF7z0Fse22soxjSvdKVgRPR4m9A94nxr9/mxgxRoqitINhJsCIcG/qMQLpsbYIb+zaqoBuNCVI1W7G0lS+hs/CmrP7+MNuDoL36fj3PKjvvb93aHZDUivmuKuunpvalIfQQrjCDZ/qWqHKjR+Vmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB10399.jpnprd01.prod.outlook.com (2603:1096:400:244::9)
 by TY3PR01MB10416.jpnprd01.prod.outlook.com (2603:1096:400:254::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.33; Fri, 17 Mar
 2023 07:30:25 +0000
Received: from TYCPR01MB10399.jpnprd01.prod.outlook.com
 ([fe80::7532:1424:bac5:7688]) by TYCPR01MB10399.jpnprd01.prod.outlook.com
 ([fe80::7532:1424:bac5:7688%3]) with mapi id 15.20.6178.026; Fri, 17 Mar 2023
 07:30:25 +0000
From: "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To: Dan Williams <dan.j.williams@intel.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>, "nvdimm@lists.linux.dev"
	<nvdimm@lists.linux.dev>, "linux-mm@kvack.org" <linux-mm@kvack.org>
CC: Baoquan He <bhe@redhat.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>,
	"dyoung@redhat.com" <dyoung@redhat.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"horms@verge.net.au" <horms@verge.net.au>, "k-hagio-ab@nec.com"
	<k-hagio-ab@nec.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
	"yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>, "ruansy.fnst@fujitsu.com"
	<ruansy.fnst@fujitsu.com>
Subject: Re: [RFC][nvdimm][crash] pmem memmap dump support
Thread-Topic: [RFC][nvdimm][crash] pmem memmap dump support
Thread-Index: AQHZR0+Bi1lA/ErA5EK0zxLjybbH0K7+oGsAgAAVogA=
Date: Fri, 17 Mar 2023 07:30:25 +0000
Message-ID: <03bf236a-e832-ab81-2b2d-448aea37a2e4@fujitsu.com>
References: <3c752fc2-b6a0-2975-ffec-dba3edcf4155@fujitsu.com>
 <641404ea806dc_a52e2949@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To:  <641404ea806dc_a52e2949@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10399:EE_|TY3PR01MB10416:EE_
x-ms-office365-filtering-correlation-id: 809b9983-87ac-493f-f302-08db26b979ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  ZuDwzxbui74/dhyE5bQpeeCMXZDiwI2fY9afkAD5gsiLVwTMIi2MoTGd9pAbiUkkkjHnFIOQtyng2mKNW3xtUD/ww89IQN0sIg5aNNwHYuedYfq7clKvQ+JnXiIURFrjbPPFHd7ZhYHrcGvAt6F6UnaQC4XLdG3t5NLaV8sAa/xcIxKvKoXrPPA4ke2bTvBIv/9ZDEa8hA0AZFNYktrTMAQHHfHQRAtmqs9+OcB3CMknE5aolwdyjPOqaJszvEN8V+jdFn34Z+kuE7rQuFImElhnAuB2hY8T7ChN0p5e2DzAQSkHmGSc9pnndzPBuKElSzGEPo8LnoI3kDpXiSClYUBiXEEDH/lFYkLtCrGTypOL2PpUmYgXYfsyXzuzfaIiHxvlAffWJedvorbNQV9ChotFso/Ih+qQgs7Gc0t1onF+/aJYKqMOpjxFNeDNKjtjJ7QO7TvEI7UQ4Zx0a49XKddcs1sUiQRyhv54Y6oYOpudf3bv3M7XEXxe2D9YiM1kf9WRKOK3/NIyCkBYLlJhbNjL+uaFL8XYZ5TyuW4okIsLWszCnpKce8IoQh8ZkwAOi40OTKULcodcCWkzdBhWXrmG4Moxs+zSfdEcmWBKDRuTwYhMXzSTCkSSk6lVYOoViV/bInJocl9qWCreykaG5PELRIC39FQwPj+urEKi3+9YPRE6BDYiwpZn9e/plMpXl+7e6trjVHkxu/xZbayh4OvkLXzQdHQHGTI68l+Zw/XWJ++ndJ/ZfWDVMedYsQruEBeXq2xEeUN0g0tayty5yYJzqO0l67t9TsRVAOjq4HY=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10399.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(1590799015)(451199018)(38070700005)(36756003)(86362001)(85182001)(31696002)(966005)(71200400001)(110136005)(54906003)(478600001)(107886003)(6486002)(4326008)(41300700001)(7416002)(5660300002)(8936002)(2906002)(76116006)(64756008)(66946007)(66446008)(8676002)(316002)(66476007)(91956017)(66556008)(82960400001)(122000001)(38100700002)(186003)(6506007)(26005)(6512007)(53546011)(83380400001)(2616005)(31686004)(1580799012)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?bUlOc21oSTA3R1YxZVpHcmRDazRwV1gwWWpFTzBWOWlPYkRhbXY3QVk3TEha?=
 =?utf-8?B?ekEvREN6SGN0emxBeU8zOHBMVThCNHZTUC9HZGhhbzMvRjRVbDVneFp6Y1Uw?=
 =?utf-8?B?TnpFK1Y2c1M1Yk42bk15UXlwQ1BmZGdUUWV6R3VXbFQyaEtxVXQrbnpEbE92?=
 =?utf-8?B?eG5NaTBTU2lGTjdXZ1R6SFh6SHJlM3E4RUUvMnR5RUYvb2g1Rm1vY1REL0sr?=
 =?utf-8?B?c2l4NVNjL0ljSm1wVkZoNUR0ZUxJWEdkS3ZPcld3dEhacDFlVVFGVDFTTWdC?=
 =?utf-8?B?MmJsdFRHeXdpUVdSTDF5eXhEV2N1N0d0b1VpWHNFRHBOZ0pNdWlzK0luMFl1?=
 =?utf-8?B?QVAzdDkvaVgyWVkxZlRjWlN5NThSM3BtUlJ0OGM2dHRYbm5ZREV4WWVpWDdi?=
 =?utf-8?B?MmFLUVp4T3VMUDhpREZ6Nk5DUVRzc0VEUHgwTFB3bmQwY2hVd3BGWVpFQUNa?=
 =?utf-8?B?YmZuQmFsQitveTF6d1JqZGp1eTdPdDMzVmdRL1RjVmJUMWtNK3RKMjdGZUN3?=
 =?utf-8?B?dnUzd1NXcTQzQ3Bwd1B4dG05ZWNWcUpxcnZsaVRQblZGKzBvbWtFSGxxR1dv?=
 =?utf-8?B?RU9QVU5WbHJMRUVLTGgvaVFyUGtZT3NEamhzNWxBcGxrNUR5NktPUFEzRys3?=
 =?utf-8?B?TGZBVTgxeDdnZ0k4bnRnNGs0V1BNUGxZbVd2ZVJRaHIyc21ZQldhdUxFTWJy?=
 =?utf-8?B?TmU0YVU2YUgrR0FHbDZmYnlCSEhnUjBsQlJNckpRcS9RRXRldXpUVElvSXlh?=
 =?utf-8?B?Z1MzWU1SaWRGc0tMeWVYUzE5Y0ZBNWtWVTNYcXNGaGwrSEl5NllwUk1JcnEv?=
 =?utf-8?B?OE51RGExd2NWcFhRaTlFb1Jtd2o4eEVPSGxteFNPSzJZOElUWklXNGZOQWJH?=
 =?utf-8?B?VWlJYVNUZDM3RXlmNnAzOFhJbFNwaVYweUJkdkJuRm4vaVoxcVpBWFdkOEgv?=
 =?utf-8?B?eW9VYTYrL210Z0piYnNhQkt5ZG1kdkRHWW5UUnJsMGovRUt2RU1CZmJGdHFm?=
 =?utf-8?B?YTMzQ2VvSlJ5WkdwMWl2QjZ0WHlqUUxCaStRdm0xcG1tUWxFOXY5SmRnV2Vs?=
 =?utf-8?B?OFpvSW5BOS9lTU9RNlZ4Y1JiWXMzaHc3eHBPMnR3N25mZG55MkxwelpwdC9V?=
 =?utf-8?B?RmNsR2lXRjRnZXV4VGJWdWI3cC9yL0FJQzhGK1RBeW5YRk44V3Z1b05lQTBW?=
 =?utf-8?B?R3JValZsQUtPZEJxdVZUYWZwQ3JnOFNUVW8zaHY2bDFOZzI0WFg1NU5ySmRZ?=
 =?utf-8?B?L3NINXB5Zmg1L0d2VlpKQzY5U1hZNmYrMjF0MGFSQXE1NWlUSGNraHhNMUpX?=
 =?utf-8?B?cU1GZ2FoTHZhQ0FGTFcxUmFKR3lYcHllSk9HdWdVaGpISWV1T09iaHNSMEE2?=
 =?utf-8?B?L1laL2JzbGhneHM3NzBSUTZMZUZnMmtvb2E3M2FNUEdabkpuWU5LSlBYbEl5?=
 =?utf-8?B?dVZzOER0T0c1QWJWV2d2UmVyTkk1cStsV1VNdHpET0NxMFo4aitIRDl2WjU3?=
 =?utf-8?B?NU01TERITldrRHFTSDlqUlN4WDJIaUVPcHdJTlh3eVVkTmZ2OUJmNm1kS1Vn?=
 =?utf-8?B?QUk2dWlLM2xsZUxlL0x5dHpibDdDN3lBUEN5SllwNHppS2tjUnJyOFpDMHlh?=
 =?utf-8?B?Zm93YmthVVd0aGo0L2hraG10cEVzdEJEMFdHUFRoOUNYZkNmSXFkdE0yd2My?=
 =?utf-8?B?N242c25lRXFXVExtRkhFbkROTXpXL1M0VGlnNUxSS2FONVFqalNXOHNtTG1a?=
 =?utf-8?B?VjBIaFJLcnczcHJQQ2dSdlkrRzcyMHc4NEg2cUJzcndKczZsT1VIamowTnJk?=
 =?utf-8?B?M1NHaHdKMUY2OGF6bmRYeTNiUFhTekZMVW1ROGZxQkxXZlZlcDZaZ3FNNmUy?=
 =?utf-8?B?eEtZV1pueXIzd0JtbjlsR04xQVhnZUNYb0dwdk8renFsaTRzRmExd3lraVVJ?=
 =?utf-8?B?Mk9KWTNjNmMzcHo3eHMwdG9kZWY2ajlaRzZqWkFoWXpPWVNEa3Y5UzZnYi9F?=
 =?utf-8?B?NDZzQzI3MGRqdURqK25YTmsvNzFhTGtlT2hMaDZZdkRzNFVvejhCcnFzRFYw?=
 =?utf-8?B?MDMxRm96c0E5ZlZlVEdHbFlIYTZMc3BIRW9LcWZIQk5WTDR0c0MzalhkdzF6?=
 =?utf-8?B?MU9oTjAzY2c3eDg4OXRYUEdaZXVRdHljRWRXSzdiUlpkY24rSyt6NEU2ZFNE?=
 =?utf-8?B?OFE9PQ==?=
Content-ID: <C1E1A5F9D114464E8FC634F0FEFF2CA2@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	=?utf-8?B?Q05Hc2g1SGIrckhNSGE0VWFhcXhKUlNsYkk0OE9IWWxadUtweDhGUDF2eUpi?=
 =?utf-8?B?QXJzdWJRLytlcGRnRFp6dEZZQ3cvUkw4MEZHUlFpbm1SbVB4VlJSZVA3UGM4?=
 =?utf-8?B?WTF5bCtibGdObXIzckhHc0NaKzMxbmZaWXNlTSt5eDhBVURXVGpPTzBlZ1RS?=
 =?utf-8?B?OXJ4K3BtckZDZ0xrMzluT0FKemc3YkNZYVczZC81Rm1uR0Z5bWRyNk12Y0NT?=
 =?utf-8?B?M3l5WThURVpmN3hNcVc1ZWNYL2lHN3NMRURmRStZTlR4U3dNR0R4UUs3QjZi?=
 =?utf-8?B?YTFIbythN1RwQkRTK29yTFNQSXJVenhWUDZWWVQrM1ZxUlNKbUw4YWZHbXZ6?=
 =?utf-8?B?WnlEV0lab3JieW1odlVBU3E3RVMxS1g3LzlEeERLZ2Y2N0gyd05vSDUyYkdh?=
 =?utf-8?B?Ti9UalJCYXl5THFXRXBXNHEvZkoyQU1jNHU3YWFDQkE1a3RWQXpEc1RzZHlq?=
 =?utf-8?B?NVlkKzRtWDZxSlcvd1RIVXdydTA0UDJFU0locXhGNkpKeTU2RExtRkhWUkFq?=
 =?utf-8?B?VWo2b2d4OTFDdXJnWTQ3RHlDaGY0VTJ6c3JDa0ZKWk1Malk1OUM2c0FIeGJv?=
 =?utf-8?B?MEpDSHVzK0N2blhjMy9OMmxwVDBPR0NDWDZ2SVZSRGpVMnRvU0p2eHRtdDhV?=
 =?utf-8?B?OHdWNU9ZU2ZGV244NUNQMkdWWVFEcVoxYk1CNXZlSkNKdHFuM1pYamhraUw5?=
 =?utf-8?B?SjNsWTBJd215bEd1bmtzMXZGMFVZNjBxVWZkRmVER2JpWm5RU3RpbXpZZDY5?=
 =?utf-8?B?VUt4anVVOHNPSys2SE8wd1ZPdWRkeXl1ekxhT2J6enZJL2wxRWQ5THV3dGR5?=
 =?utf-8?B?Tkozb01yUFRRU3N0ZmQ3RHFYY1VNTE13ZEI0ZXRRUzN3cFdLOUNGbjEzejU4?=
 =?utf-8?B?K3BPVkx1ckp0NDJhdkVaMCt5bUg0VDhqTFlWeVRNQTE4VytlWWtKUHlDRUZ2?=
 =?utf-8?B?SHVxVUY1SUt1Y3FvN0JSMVZEVVZ1RW4rcEo0SU9hTTFkUGg1U1NMUm8raGcz?=
 =?utf-8?B?RURzQkF0Y2F2KzNXZ2pOTEMvSVlDNGlKMXB6L3dTZWFxWHVRRHlyNzQvYzU1?=
 =?utf-8?B?YzB3dlhxcWMySVl5NGxCendNUmdPOHRWSGRESnRtMzQ0MVpjY3pCYWdFaHU2?=
 =?utf-8?B?c1ptM3NsV09saUdZVFhFZk5FSkNidWkvcUh1bS9Xbmw5MmpjS2pIeEdRM3ZN?=
 =?utf-8?B?U2ZIaGNEVlJVdFp0YmtDZFRCL2dvVUdHY3lTejBCa25MRmJOVzdvZW1jaTk0?=
 =?utf-8?B?emVGWE9tMzcyM2ZiOWg1RW1Pd0dJOVBVMndmcjIzZHJXdjMrWjhmNlBjOXU2?=
 =?utf-8?B?VXBRMVdaYzdoc2R2M01meURzTEo4QjA1a1E2K2lqRjFRSTZkYStTMlI4dEtv?=
 =?utf-8?B?d25MeUt4ZXN3RkE9PQ==?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10399.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 809b9983-87ac-493f-f302-08db26b979ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 07:30:25.9187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvK/vy4OAY1XQSus7Yd649Tj76/wzJMNhtURB9Zhn83OPMQVHgPbVVKOXtf33sDnBlpp8AR0f/VayHG62X1Qyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10416
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230317_003040_227509_93650A36 
X-CRM114-Status: GOOD (  15.26  )
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



On 17/03/2023 14:12, Dan Williams wrote:
> lizhijian@fujitsu.com wrote:
> [..]
>> Case D: unsupported && need your input To support this situation, the
>> makedumpfile needs to know the location of metadata for each pmem
>> namespace and the address and size of metadata in the pmem [start,
>> end)
> 
> My first reaction is that you should copy what the ndctl utility does
> when it needs to manipulate or interrogate the metadata space.
> 
> For example, see namespace_rw_infoblock():> 
> https://github.com/pmem/ndctl/blob/main/ndctl/namespace.c#L2022
> 
> That facility uses the force_raw attribute
> ("/sys/bus/nd/devices/namespaceX.Y/force_raw") to arrange for the
> namespace to initalize without considering any pre-existing metdata
> *and* without overwriting it. In that mode makedumpfile can walk the
> namespaces and retrieve the metadata written by the previous kernel.

For the dumping application(makedumpfile or cp), it will/should reads /proc/vmcore to construct the dumpfile,
So makedumpfile need to know the *address* and *size/end* of metadata in the view of 1st kernel address space.

I haven't known much about namespace_rw_infoblock() , so it is also an option if we can know such information from it.

My current WIP propose is to export a list linking all pmem namespaces to vmcore, with this, the kdump kernel don't need to
rely on the pmem driver.

Thanks
Zhijian

> 
> The module to block to allow makedumpfile to access the namespace in raw
> mode is the nd_pmem module, or if it is builtin the
> nd_pmem_driver_init() initcall.
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

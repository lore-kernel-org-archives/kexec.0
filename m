Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F8DCF9C71
	for <kexec@archiver.kernel.org>; Wed, 25 Sep 2024 01:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OcLPLGzdEz56WBO/Z4It8CEwEy10hooI5kvi8MbcFQM=; b=ji6AcS76LHI1At
	NpUP0dmfKjYukIxwi8xqikcQjZ/Si4VO/QoI7KIoURmGv/CGZpkubbg3w5Xnxp/4pOSozDgeJRj9i
	T9WZcpKO/LGYgPM36Jdeyk5XYYtvzFfvZ4aAAUnWUnr/wxr/SFgEqpw5R7JpWz+WhTIZ1N9XeJed3
	guTHtnktOJh9VF8mF3xP1Q7uRDQPgaffBiazNPnj+ws9E3Uuyhxg2TPOWv1TTMwHtW5FNOVPNTIYa
	C//JhmVJw7Dk0yQTctageIw8o7EupQBk7yW4+Yyv0MEIVt4YUtLbwtazVkhTNcEAiX78BPnLV384a
	AnRBEES/ihAEt2YcZ44A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1stGxa-00000003ki4-2fO2;
	Wed, 25 Sep 2024 01:36:54 +0000
Received: from mail-japaneastazlp170110002.outbound.protection.outlook.com ([2a01:111:f403:c405::2] helo=TYVP286CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1stGxX-00000003khE-1zWl
	for kexec@lists.infradead.org;
	Wed, 25 Sep 2024 01:36:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xh+DBYy8Iq4+hHv6cvpl8/On1xgwU1xTHSAZyHylUVNb8KyajiQ8OEyBnVWdImmXJOBB8TGCVrta6xXHgNGqdJQ+MmwDdPLQDSHBUBpeNVIlJcHzTKRh9NIuQIp7xCjsanvtHooio0pUL0BvwwHuk2GCeGs+KrpRSjSlwDYvx4iwjfCSPhWeRMWmNwLpjQSvj9Ro5sATM3Eo4W2Wc1V3Ru86z0YN0jkcMhoCEO9z2+3nl7Or7/G0FzyglES9MUdktGPlNmW+l29k2Bq8RxXybU3I6kPo4TL6Hvy9adVFsxszWF603jXROQ7YwRyypOBOyyEdGMqphsnoBFvKj6T0Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTdQiMuE2mgsG2JsE7VR/sZOrtl1jCWL2CNZ5Lb5BjI=;
 b=E/TNSUZ1Rj1RC+OAZganY+GsZyxwx4x3o3+GLchYC+8DtGZMMuUBGNR5vLDIOD/E9BPOq6squjQG5L2zfqf1yWlCJzwvzvIISAlUXjS1N/GRSSV0jAkGqhVD6u3sg915c2T3YwhmCqgELHBGck8QwyMMR0UAiZ0IyG0/zWtTV1cCRrH1RzMms7MHPeAgLp4LB+zXYrwSuM5QXa1uV9HYbJ3ioppf2Ow1SDz5roPeBatD9Tl9oNCU6nmzq/1DywZwSNQk5b0xYTQc06EQ1EbIUupMkG3//x7zPNlJTOxE3jaZOax/kUp3EfYdJ8TqISHM2m1EbEBaRoDE6FFwrmn11w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTdQiMuE2mgsG2JsE7VR/sZOrtl1jCWL2CNZ5Lb5BjI=;
 b=R6AH3vD3ypMMjlKWS3Olix8PttFaBzHFFbCG4sYSwTdV+BuYHXRzdqSjmUgJYGthLZPpPWy7MdPd6Y3+EX/OGDh7Ll86udrYI3TOqVqqv9QqBrt7iB2xnTR2Aw8b8tCsJfkYb57cWPtb0U9BbdmWLkQl5PITHbaq/pIR/lcQiUjs7dNfLpEGD18qEhk08JUpUo/o4QjXgfMOJeYj5g0VorPQQVHy1iwf3/F9hxMAgxDCkq/E/XJKcydl0qnYor0a92VGeov9s8wmsvONToQ3f2hRIOboqsT8q3yDt7h4Ep+3SFk6RY6jbfC9BUhQXKIjWkIIc4K4JVqHPXzxmL7HpQ==
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com (2603:1096:604:1de::11)
 by OS3PR01MB10184.jpnprd01.prod.outlook.com (2603:1096:604:1e5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 01:36:25 +0000
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66]) by OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66%6]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 01:36:25 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Martin Friedrich <martin.friedrich@hetzner-cloud.de>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: makedumpfile fail to strip pages
Thread-Topic: makedumpfile fail to strip pages
Thread-Index: AQHbCy9/K3pvgGgJg0+b2wXotTtF4rJnwC0A
Date: Wed, 25 Sep 2024 01:36:25 +0000
Message-ID: <6a41c11b-0956-4101-9892-173bd78668b9@nec.com>
References: <164F5E03-EB17-451A-810F-58962BBC53B2@hetzner-cloud.de>
In-Reply-To: <164F5E03-EB17-451A-810F-58962BBC53B2@hetzner-cloud.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9993:EE_|OS3PR01MB10184:EE_
x-ms-office365-filtering-correlation-id: cb83b49a-1764-4dc5-6edc-08dcdd027811
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QS9UallNMHJrak9FZDZmamRWTDIvSVo5ejlVUHR2MU95dmJVczk0WEttZjh1?=
 =?utf-8?B?eUZYcGxIQWVWdHdaWllMeHVUUjRaSy9iZTRUaDR2UTBJWlZhRWFoZ2lpcWtS?=
 =?utf-8?B?d3o4bTUwcEc5VHRYR3pPV2IxT0U4bWg0dGJqbGZYdElaa3d3WUhMQXozc3VG?=
 =?utf-8?B?RE5aTmMrRmY3UCsrYjl4LzhrZEkwMDRhQkVhTFNUVG5pbEJzVFZ1SHNGblIz?=
 =?utf-8?B?TWtOYlhaT3VKTWw0ajl5bGswam1PMTNaUVJpd3o3OVZLOWpRS0pjUXhTK3dp?=
 =?utf-8?B?L2ZUOWtFQU5vYVlvc1VNelVVdzFhKy9CYmt5ZVJGSWtOWnNZczJNbDk0L1ln?=
 =?utf-8?B?b09xblpUMmFGL3dzSEg4OEJObWRVTmZidmNEOU1iMXR4dnAwaVI3cHc3MFo1?=
 =?utf-8?B?RjV2T1JBQkEyNGhjaHp2cmQ3VENpaW9DdW9rbDV4Uk1VYWhjb0Z4OEgrRkF6?=
 =?utf-8?B?V3g5dC9qQ2NzNUxvQWJlZ0MrVnQvdkU2QUd3SFNDN2ZkeUFReWxBc3ptVG9L?=
 =?utf-8?B?aVpJVzRHbkdRMGM4MnZNRUFBK2NRZUZFWDA2YUd5UXZPUER6VDZKdFIxejRs?=
 =?utf-8?B?eE80K29GaWtlNEwzSUczTWFVRlA2aTlxWlpRODV5SkRraGRkdVVvWitIOGVV?=
 =?utf-8?B?VGJWdzJ3Um92R3JSRDFnUWhxa0lZSXlKZEZyOXBpQjVxKytYSkJSOFhUbW5l?=
 =?utf-8?B?QjRGTlRZektlMjA0UFEzV2FYdCt4d1FWbHlzN2l0czc5UTdaN0xIRFN6NWFR?=
 =?utf-8?B?MmFydjcxVHBINDZWQ2tndTdhRExzZURVZnZ0Zm45ZjVsQysrRU5QZnVoZmlJ?=
 =?utf-8?B?MCtRSCtLbHlmKzd0dUNDcWJKcHJZWGlvVUVDTUN2TW1IdURRQzJSUW8zRk0w?=
 =?utf-8?B?akpBRmhJR25CamNpN1NIWm0rNXJzMWlRRU9id2JLS3NmK1FPbG54WXhsWEgz?=
 =?utf-8?B?VTU0RkV3aU0yYm44bXlPSVR2U2gwWE1FN3plZTJCT1c2aFcxZlFPeHgydk9V?=
 =?utf-8?B?TDlMNFlaNjVwQklNWGdPNXJYMmhSNmphRXU5ODJwc2xsSDJRaVErVnBDZmIx?=
 =?utf-8?B?WEFubE8zalREeTd2dWhOMUxwc2N1R2k2Z2xtN0RqWWt1R3NWTkhCMnBOOEpY?=
 =?utf-8?B?VkEyZXFIcFNjRzZIWFcwSWxlejJJUlpVaXdEQzFRbW5MRDBrcHJaN0l5SE9j?=
 =?utf-8?B?K3hHbG9ma2RpTlY2VEgvVWxJQ2RiZkdEMk1OTmpJZnQ5ZW5sVGdOKzdyQ2JE?=
 =?utf-8?B?aVZDV1I3SVl2dHB2MkVpd2dic3lSR3RvM3FPZkF4N1lmdXYvcXhpSVFOU0ky?=
 =?utf-8?B?dVI3TU5CbmtGOWRITVVBeG5WcFFEY0ZKOE9oUnpLK0M3aGNNdXdrNHFOOEtW?=
 =?utf-8?B?anF6TGRoNFpEaFAwUU9hZnlVazJ6dlV1cFl4MHJQU0lEUlFmeG5Ja2JncmVr?=
 =?utf-8?B?THQwVDV3cW4zRFlqdXk5YnFTUGhlNHAyUENQQlFXNW5NRnlFd0I0VkhIWXdS?=
 =?utf-8?B?OTV3OW5mZUtiNGtmVW1xQXltZi8wOEdJRWN6NkVaM1FiQ29YRFdldkF3Y0N5?=
 =?utf-8?B?NTN1cXgrUEIvdmtEWVFYRCtBaHJCM090VTd2c3ZwbGpLTk1nVkNteURpSitZ?=
 =?utf-8?B?VlVOSDRNL2szMVlhaW9qYVZrZ2dwNnhxWUJSc3F4dVRHN3B4Y2lZSU4vZEdR?=
 =?utf-8?B?OFQrd3dRb09WeFFnTGhTMjFnQURYVWwzdGs5VFB0dWFIMGtnN29uOVVENlgy?=
 =?utf-8?B?dHRGUGY2Y2pkeUlGSTV3MnVkcXhkR1NzZmJsVVI5c0Qrb3BOKzJ2TXRWUVYr?=
 =?utf-8?B?TGdId0JNQkllMVFLWjdjejU0L3ZIMkRCTjJTajh0MGpBanZxc0hEczNEU1N0?=
 =?utf-8?B?Um15WlFqZDZzeDF3Q0xNMXRjcTVlT2k1M2VtcVo0ZVNCNFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9993.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjVjM0F5UGlnSVBTbFpnckcyNTB5dDFIcW00ajZsQjIreWVxWWJjSmZNYm9N?=
 =?utf-8?B?M2h2QkJIMGh1RW1qZTVnNEF1MDAxdkFXTkc3QkZUNC9xVTZ1MkszUkZrVXB6?=
 =?utf-8?B?MWN4THhCSStEZGRKdG51RURKYk1xb1k2ODE0NmF3OTVNVTBYa3BaQzVLSjBq?=
 =?utf-8?B?ck04Q2F5aWlQM1NjKzVYYnBrZ1EyYXQyVWYzVDNQYlkram5iZXNMczBRTGIz?=
 =?utf-8?B?ZW14UTVUL2pHMjVZdnJ6aE5VNUxaYUh2Z1QxTU10ZmFsbkRWL0krejVaOW9M?=
 =?utf-8?B?U09keEdZRGFLUTNTVWtFSVFXd2RVV3V0NjRYWFdMRjVRNEZlaWpPRitUT0hs?=
 =?utf-8?B?UlFESUlOa0tIT3JPZFovNVYzRm9MclBtbXlML0dlSXNpL2sxR2V3YldhUXNI?=
 =?utf-8?B?d3dFQ3BrNC9nUHB5MGRFeGFMVXlZY2gycmlUekpKL1BYWW9NZE1EaUttU0p6?=
 =?utf-8?B?V0k3d1IyR0tuV05QM1V0M25ncmpyZldwZ3hPdzBFMXZkbnUzajg4N3BTSGF3?=
 =?utf-8?B?bnVXaTgxNWFwcXU1OW9WTXFGRW03VUlYMWJaV1E5UkdlTXpTdVp3MmJDbnov?=
 =?utf-8?B?ZVI2VzBzYTZBT3FmdnB4cGVyRTkzNUpJNCszODZ2RnFqSUFrZDU5S1JkajU5?=
 =?utf-8?B?dkM5RTI3UW1rdWVNR3AwTnBrR2E1akpnVU5EcDdEb2MzTnlDYjFrZFlUN01p?=
 =?utf-8?B?MzVaZW5ySlhmaGhrd015N2IwVFRxc2praXNUc1ZxSXNOUDhCZ0tLY29GQ3cz?=
 =?utf-8?B?TzBJL2UyN3d2cms0SG1LcDROaDBJYlAyUGx1ZC9LeEc3ZnpRTk1POFFhQTJn?=
 =?utf-8?B?aUd2MmI4NDJRN1BzNHZ0WGFQVVc4ZHBuVGpncytxemtHYVRrQndRLzRiSUd0?=
 =?utf-8?B?UmFhbEQwZy9NZ3NlbUU4OGlEbXdCcGpuaVhJVC9TcVNJRmM1Y2xPK0syQmw3?=
 =?utf-8?B?dWNYWjkvMC9aNFkxdDZkUGp4Ui92RFlFZDc5VzQwMDd2N0xzZTRBUFFJQ09X?=
 =?utf-8?B?eXI3dlFGbzIybS9HWU9lMzRLMFp3U1FJb04vajRGTTRIc25sN3lsbzVGb1hH?=
 =?utf-8?B?cDJkTnNBaFd2andXWjNSemdJNjZIZVQvMTQwYTBZdmRmUVdGc1FDYXNXa25Q?=
 =?utf-8?B?aFR4ZzUraFhpRDY3YlhnWG9waWpmRldPMVZ4amhDUmRhR01lSUhjU2Zpa21u?=
 =?utf-8?B?TENTbGlvVnM5Rlo5cnIraHhRRXhjeis1M1VmUTJQOUxwWFkrREhPR2p2eGky?=
 =?utf-8?B?cnBUamNJN3hGMTFtbmc3UUQ1NGNTQW1QSE4wSmZRWWF3eTJlTnBoUDVUazh2?=
 =?utf-8?B?OTZOTWgvM2d6cFNmLzVzcXoxaUYySEFXUDhkU0ZQQ2lmaEJGN3dMSTlWZ0Mw?=
 =?utf-8?B?YmNUSDd3dytJREVGSzF4clFUUTlzWXk3a0VNdHBlN1Y4QVJkRnpreThlUTJL?=
 =?utf-8?B?YUxCL1NwdFFCN3ZvNGw2TFNMbkNrK3BJMUpIb1ViaUZOeVFOTGNHMTRFTGxN?=
 =?utf-8?B?N3Y5bGRwbXNlMGhzQTZPZTlaeFpmNDJ6Wjl4RzZoMFkvTmpueCt1V2tsc1ND?=
 =?utf-8?B?Q0Q0aURxbWFsaks0LzdSTXhPK2NjaFdlSll1dThzWS9CTmJkTEM2Q3ZXdld1?=
 =?utf-8?B?MVA0VjRzLzNLc044V2tMMWZjUlVDbFl2bUVMYUNWbGtSdEhCRS9wZmJXWXVM?=
 =?utf-8?B?QkZPYVBkMGhaTmI0WnpaWjlzbWJZdS9rSmplczJDQWVkQytTMTMrZElvdHly?=
 =?utf-8?B?UGc1SldTcTNLQ2l5STNHQTJLOVNJemF3dVVzOEZ3Q3p2bng3WEludVh0WlRI?=
 =?utf-8?B?ZUJKbnNOWk02L3RwcENsQU5FV3NOYk9Kb0g5YWNzdHRkZm9UMGNmWlA4Qm1y?=
 =?utf-8?B?QzRVS3NTWUtFUWRORFVXODViZ0RDNW9rMzc0SzNzWjQwSEoxRTVoS1ljNWM5?=
 =?utf-8?B?SFBURVErZSszbVF6T05ITjVSSUVjRWpoWWRNSXFLWU5ScVh6Um5WZ0JUQWFV?=
 =?utf-8?B?Q3JWUStXT1RGOC9kUk1mVVYrSEtaVStzR3k3VTRjYm1oOWJjc1NxR2YzS1VX?=
 =?utf-8?B?NitrbmZETXVmdUVmY1lMU2dQMVdLVHMwRGJNMDZ5bFBGRzBlUHE2WkovWk1O?=
 =?utf-8?Q?osSGv2zAtR28SAFmcmCUgXYAr?=
Content-ID: <D614F6FE6F0DE544A65A7AF7C71B4B1D@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9993.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb83b49a-1764-4dc5-6edc-08dcdd027811
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 01:36:25.3224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yTeQmfTkiSRyv/+UMKr7kb4c9fyTps+ugQOvzgDsx8ZwWYa7csmE7exHB+wNhh79teDTfhW8trKdqw/G+Kd5rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10184
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240924_183651_988277_8D91CF47 
X-CRM114-Status: GOOD (  12.75  )
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

On 2024/09/20 16:31, Martin Friedrich wrote:
> Hello,
> 
> I try to identify the root-cause of an issue with kdump & makedumpfile which results in dumps to have a size of the system memory.
> Kdump-tools/makedumpfile has been configured to strip most pages with the flags: " -c -d 31" and transfer the dump to an ssh target.
> 
> I'm unable to replicate the issue by crashing kernel using sysrq-triggers. As long the system crashed by sysrq-trigger, the dump has the correct size and completes successfully.
> But as soon a system crashes for other reasons, dumps get huge and fail to transfer to the ssh target due to their size.
> 
> Our servers (x64/aarch64) are running Ubuntu 22.04 with a self built kernel 6.6.32 (config attached) and makedumpfile (backported 1.7.5-3 to Ubuntu 22.04).
> 
> Am I missing something within the kernel config which could cause this behavior?

hmm, I have not seen such a behavior.

- what happens with the latest (bd30437c6292) makedumpfile?
- is it possible to get makedumpfile logs with "--message-level 31" on 
sysrq crash and other reasons? (to compare the logs including stats)

Thanks,
Kazu
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

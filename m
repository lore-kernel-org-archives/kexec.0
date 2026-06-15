Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FB0CD98DE
	for <kexec@archiver.kernel.org>; Mon, 15 Jun 2026 08:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AzOsFEh6K+AezbTmUUaBbAzgyLWEQ7wmgaPorrNPO6U=; b=BSXFL5BRcEcdmsT/BZ2tIgPqkO
	1xWkKKtM4FTpde2ASd1D74ix6IdBB7McXf3BoYLjUdpZoBDbkEUJWwpTIxDjAqe68VW7p1LTHgFVb
	lWeF9xYUC0cRKXplQY54MugWF5cLsU/UJumJpFmRD0PBO25VqMAhUTD/pdAOKUl3+YL4P7yAdzFiY
	p0tk9xYDr+wejGi23xT5P24Lwstyxnj7JHz4JnO3CRFpjADr9GPJmGE9uQQPj90RybYaZfNtEgAYv
	VOWzI1AA/1c9VgsV/XiPYC6RA6oZCU5GMB+UJglBJLLC9hd9Bu75l+up4B+pQOaGVq8AcaFWV3kPr
	0PIp0PZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ2O9-0000000DqB4-1ZmB;
	Mon, 15 Jun 2026 08:09:45 +0000
Received: from mail-japaneastazlp170110002.outbound.protection.outlook.com ([2a01:111:f403:c405::2] helo=TYVP286CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ2O5-0000000Dq9d-2H19
	for kexec@lists.infradead.org;
	Mon, 15 Jun 2026 08:09:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJNPnKss+xzGCvEwE3swn+OrBCO96yyrrEbKj1HFEJzJRgTTOVJ1EmNfM15qED2JKa8klmOkY5edHEPi+phsMGKBLVzu3A/RIqZsl03GkIn7oTCziJwZc5o+s42OfmWPFMKcoq9XbrSKVjR8wpPntkMr5lhPMBMlzYIdsXC6JhK76aI9tiFVBEzGZHlLvbFI5p2BfMlAoClLHiGTDJfcMg7fGN2kmJrkIP0XUE6htuowTw2NA1K32uNrSd5ARj3+UhNadgzLz0+iL6VbSpFDQAVruuuMxrgWnIOrBp2naHc/Xyp8/KtzwYZaQzsT82FUZHq4/EWkBpZCD15GMqPnrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzOsFEh6K+AezbTmUUaBbAzgyLWEQ7wmgaPorrNPO6U=;
 b=hBOOsz20i1Z98X6ti0WHRbxithrAs9SL1u0XIvcAcrYxR2+624ILndTFMvaO80hQOXnERUTMjFu9dH5zKANcav/Zywu2Guk2QSm0WmSlyGFeayydoWVZQ77iz2ioCai9pGZT5BYb8VGmhNLKmtqoBAnnx/TTxtbTgSlYv829Oc+LarA/kn+lq+9jxUm3yClq/SyA+HBovLuHRwB0w5N62EfYlz6HiRUKK+g8tGxvPqMeVSnUcxJyp2+IByKQ+k5zF/d7QBhftQFonu0X/8MiRX6PFxjOQnHTaz/kMguVEhs4cnLvQPWNHuF0PlHNaWlpZJYsLpyvagGu2B86EtDgLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzOsFEh6K+AezbTmUUaBbAzgyLWEQ7wmgaPorrNPO6U=;
 b=BPAy+29InR8lOB6OPllUjAFWzYFS6NwLM1+mSkH5wNiMrnKSZIzglbbwVCAxVnDp472c4WQdiIUX4o90ERhVOvIiEJIbKCzRPJBxFtAcQ3peJCqGkQK2BUMHDFaRjkAHAqvhBrjrp2D6eXNcWHjXVCAsASyJqhN2QPQUaplnLEtETCjcMhYBBIk5jtvuau4Fop7FT3XtOXKCAinqh262YGeHy3SOuYLER3961kMMucuOUF26kY1j3hTeZerhX6V6bzXGvPqSJbU4QfykA3RRQuP7VA/vc1rxtY+BGmj0waqn6I+AaIBYUGZ2NNgck0/Ijr9Dq+4zutrpjUDdptDFMg==
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 (2603:1096:405:1d7::13) by TYCPR01MB10776.jpnprd01.prod.outlook.com
 (2603:1096:400:294::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 08:09:36 +0000
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820]) by TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 08:09:36 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Tao Liu <ltao@redhat.com>,
	=?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
CC: "stephen.s.brennan@oracle.com" <stephen.s.brennan@oracle.com>
Subject: Re: [PATCH v5][makedumpfile 6/9] Add makedumpfile extensions support
Thread-Topic: [PATCH v5][makedumpfile 6/9] Add makedumpfile extensions support
Thread-Index: AQHcy/lclxSqixzmRk+7o4cMJqDfsbY/pKkA
Date: Mon, 15 Jun 2026 08:09:36 +0000
Message-ID: <8b0079dd-e50a-4667-aabf-1612921b022a@nec.com>
References: <20260414102656.55200-1-ltao@redhat.com>
 <20260414102656.55200-7-ltao@redhat.com>
In-Reply-To: <20260414102656.55200-7-ltao@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB13462:EE_|TYCPR01MB10776:EE_
x-ms-office365-filtering-correlation-id: 896ffc96-1ba1-4b97-bacc-08decab57118
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|38070700021|22082099003|18002099003|4143699003|4133799003|11063799006|56012099006;
x-microsoft-antispam-message-info: t78Sr2iiQRR0U0jJV297+P/ApItRpDUo5IYzrylXEhCOfGk9gGq9nEbViCTG9+u6prYG901lEjY7RvSlMKxSQQcwyITVQ+J1AtC4LJcn4b8eexgkIHXD1yPnHAnZtLAXztgWSLpUttkGlcXVL9NBumMhnkMf14MSToUzlHds9Fjfh4GcJTF5z3jHAkmXTDiHayYRu10g9T2DD0ZKyWSk/moo6yQJ4Cbr3ZhjtCdcbPQqpVtbYS38ldsJN1JsUWwRyUdFow7GuBo2JjkW444YFRUwc2+vni3gBqzHaU6D011ShHbFMpGbfE6tF1XT/fJ0aM+awn2A54EdtIxLMWZZ878tJVEXqKz8sH9Z/B0ed/0oY/OIX1WJ2Hy7cDOIJ4jBS1IqBGcBdKMWHtSDMhqMrqzOaFbBJhNO/kPq8OTWVdQX30J7xbAnNRazxE/wbGa/yoen/OQK+82JpkZGGASugo3t4USgWXuTJlBDJkemNzNZbBcWWKGSKGPh2Ryz3BYu+DBLhw468gx74rzzpFurLUg8TZvSU5m+g01D2Au+Mw8p3qoBVgXwT9zr2eWr+k0t5sfLdNpDuus+wqum8c9UTtbY/xzXVFmqJPqE32Sln3F66WHg6Sok17dBFqvjc9LAoTLM7CyqYqzcGEDg6QlXEObwuD98K1vh2q3YvpZjffx/bQRDR95w5bOKNvqZ9Fpduvz6cquj6YVWkhZiI0vNiuCrVnH+Mh1wGXUUxU7+06AS+VkUj4y3VQKrMB3lxVHB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB13462.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(22082099003)(18002099003)(4143699003)(4133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjEzandKQVJZemV0UUdmUnlKR0M1c09XREF0eGdRMWVIcDZWRkFhajVsYTJR?=
 =?utf-8?B?bDI2VzQyZmtBd3l5UWRBR0JEYmhmb3JhTXVyRUdJRy9GaW9hN3Q5ZTl6Y1Iy?=
 =?utf-8?B?d3pxSmhDcHJUa0xJWlNtQjRZSmhXVWZndDZqQnNQTWJsUTUzUktNS2lHSTBG?=
 =?utf-8?B?THo4SVR6aTE3SWxvZ0FEMkozSGRsS2dXMDNuWmtTZGFYYXZXMVpUR2p2cSs2?=
 =?utf-8?B?dThzN21GOS9qSDRJdUpkSGcwYkJtVzI2ZmgxYTJmTmI5SUJvWHVleUtVOEpQ?=
 =?utf-8?B?bmErbTNWdlFjSllMYitsVCt3YUx2bktUbDRrYnBrK0R2em4rTHdtdXd2Yzh6?=
 =?utf-8?B?TVUveEw3V2srODc5UVh5bHk4ZXRtenI1d0NmWS9yUWZkM0tUWm8ycG5JME0w?=
 =?utf-8?B?SnhjZ2NhU2lOcXlZWUtkaDIwVG9NeGN1MGg0a041UlcvazZjbW44MHJPYUN3?=
 =?utf-8?B?TjY1TmZMbzR0TGVYZjlXZHltZ1FxZ01aMGlPRDRpVWpTYngxRS9NVTBnUUNP?=
 =?utf-8?B?OFJUdUdUZWNtNW1QQUFCRjU2a2pWbHN4L0VuSUlJR1hBUXRaRExYU0NYeWZj?=
 =?utf-8?B?QkJzV0EyeVRNRXJtZFNwRC9mcStES2dWN05KVnlMTFl4WVV0b25aa1NaT2xX?=
 =?utf-8?B?T0xEa2VSR0lVcStFYzNRRTN2ZjQwanBsUmlKRHc0LytFTE5IR05HSWwwd3pa?=
 =?utf-8?B?N3RPWHJ5aHRFVVhacURsUDFKc2dJQlgvL3cycVVRRmluRzd6cWhWSjNRV1pY?=
 =?utf-8?B?YWQxZEk2bTVmSnJGOExoVGZjOE9HZHdSeFNub0RhbVBRVjVBYi90WDA1TDlV?=
 =?utf-8?B?am5UbGc2UkpWbUtaOEUzcjgwbjdTVlhFK2lESTBYcWdtMlNrdTRtUjFZbkhP?=
 =?utf-8?B?aTJPYTFyT0thT1p5S3d1VUUwZm5nN3NwaFVTY2tWQ2QvcUhIeFZmU1BLbnhk?=
 =?utf-8?B?Y1o3eTlkQTZENnQ3dGxHakFFYWovbEdxN2pSOWRRN1VzQkt2MFoxSWUwK3lW?=
 =?utf-8?B?Q1hDNEtaaExHVjg5S1FCUEtrc045ZUZBb3U1UW1kTzlzNU1uMWhhMy9IR0Vn?=
 =?utf-8?B?QUNFUlFIY0pWQWZzV0IrTWlXQ0R2aCtmTzNQT1g1cUw0RGFWU1huTW9weUhn?=
 =?utf-8?B?UUhHYzh2V1hhRHZGYmdkcHlOMnVkc2F4RTNoM2pQMVlaVFg4eThVSWpOQzJq?=
 =?utf-8?B?NytjSFJMTEtsZldKMFhaaVcrK3Evd05oZ1Q1MURTOTJ4c1R3SThrNzBqZGRr?=
 =?utf-8?B?MExsTXV1T2EzL0ZheHBodmlENFhjTDVXSHV1V1RFOFZrZjBSNHRBSVc5SU0x?=
 =?utf-8?B?dFMvNG5OOVRDVXVXZVRBU2FCSzRIWngvbU5nbzZnNDNRaWV6cXFuMUIwRGZL?=
 =?utf-8?B?NlYzTnRTL0x4Y0cvM3BiREpJc00wMGU4MHhSSEN1Y2dVL1FTSTdDdmROYUMv?=
 =?utf-8?B?Sm5yN1JkalpsM3kxc29mL2oxMVBQQ1FKU3JOUWU2Y285WE1yNzh6UDJBTU5I?=
 =?utf-8?B?OTFXekdpSkNMdVlWTzlDSjJmQWYzbHIxLzhtbms4T1IzVDJpbjh4RzNHSFZG?=
 =?utf-8?B?UHhoVEJiVit0eEozVWduaGhWM2dYUUFXTTIzdS9oVGN1cVJuRWFBcTFJVW51?=
 =?utf-8?B?RFE2UXN6aUpRYmdnTDM2bGt4ODVBU2FpZTZ5TitNLzhHMVN3WmMvd01rTHl0?=
 =?utf-8?B?SU1rVm5uVkcyYitoUFIxYjVla3hWV0lQRld6YmovNDdCQkpLWXBuNmhPRisw?=
 =?utf-8?B?YkQybXMwL3BmaWM4N2hyVU4rU0p6Uyt2UzR6N2t4d0dpcW16U1dnQStwK25t?=
 =?utf-8?B?TzRYZGU2bnlFem8yS0tuQnhRWmlFUWs5NzJGSjRGcWdrTHJsSENiQmk0UU0r?=
 =?utf-8?B?clpnb1BNd21wK1JIS0dhamN0WUc2SzBDYkplNDAxWmY0Z0RnSlVLMy9wbDg5?=
 =?utf-8?B?WUFFRktSQXRhNnVhampVM1AyOU9aYTBHTUpBT1BHa014OE1mdHNPSExRSEFz?=
 =?utf-8?B?eUthT0IxRmh4NEx6Q2xvMVJoQ0swZGpaYUpNY3Y2eDY4T25qM2krQ2hydzF3?=
 =?utf-8?B?V2I0UWlTNU8xT1AvWi9WWWp2R21idCsyQWozbE0rQ3NUMk1meS9sNFVOR1lE?=
 =?utf-8?B?UjBBd0gzNVh2UlMzbG9oa3RJamhhak8wbmdWVis0QzNGV3h2YTdmb3lOV2xX?=
 =?utf-8?B?emdWWVNHUHhUMWVURkZudWJweHBhQWROb1pva3pCTlJPMmozYlViUHFUMEdz?=
 =?utf-8?B?VWxTNGI1RHFaRVQ2YVhSdVBJR25WMVMvbEZndlhMQUVaTHAwdDA1bmk3V05C?=
 =?utf-8?B?d1hUY3VidTlrcUluZ01aMlVhY0VFcUxQTURIZWVCdE1iak9ySE10dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84FF8E3F7FD27849820F852BF3AE6576@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13462.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 896ffc96-1ba1-4b97-bacc-08decab57118
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 08:09:36.7842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u3ACrNSelZAVMqpnwWHjN4zXo3gVv8FoWJ3EnZ2UnfxQj1+Z9Ke8MNggZzkgSoZN8xTeUmMMeD4BVJClybH/Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10776
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260615_010941_584747_3C75D790 
X-CRM114-Status: UNSURE (   9.99  )
X-CRM114-Notice: Please train this message.
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

T24gMjAyNi8wNC8xNCAxOToyNiwgVGFvIExpdSB3cm90ZToNCg0KPiArc3RhdGljIGJvb2wgaW5p
dF9rYWxsc3ltc19idGYodm9pZCkNCj4gK3sNCj4gKwlpbnQgY291bnQ7DQo+ICsJYm9vbCByZXQg
PSBmYWxzZTsNCj4gKwkvKiBXZSB3aWxsIGxvYWQgbW9kdWxlJ3MgYnRmL2thbGxzeW1zIG9uIGRl
bWFuZCAqLw0KPiArCWJvb2wgaW5pdF9rc3ltc19tb2R1bGUgPSBmYWxzZTsNCj4gKwlib29sIGlu
aXRfa3R5cGVzX21vZHVsZSA9IGZhbHNlOw0KPiArDQo+ICsJaWYgKGNoZWNrX2tzeW1zX3JlcXVp
cmVfbW9kbmFtZSgidm1saW51eCIsICZjb3VudCkpIHsNCg0KVGhhbmsgeW91IGZvciB0aGUgZXhw
bGFuYXRpb24gWzFdLg0KDQpzbyB3aGljaCBjb2RlIHBhdGggYWRkcyAidm1saW51eCIgdG8gdGhl
IG1vZHMgYXJyYXkgYmVmb3JlIHRoaXMgbGluZT8NCkkgY291bGQgbm90IGZpbmQgaXQuDQoNClsx
XSBodHRwczovL2xvcmUua2VybmVsLm9yZy9rZXhlYy9DQU83ZEJiVWFfOEgwZmUrOWJUTlRRV2pN
Vnk5cUNQaXUwZm8zZzhYYW1pRFNfTXI4ZUFAbWFpbC5nbWFpbC5jb20vDQoNCg0KPiArDQo+ICti
b29sIGhhc19leHRlbnNpb25fbG9hZGVkKHZvaWQpDQo+ICt7DQo+ICsJcmV0dXJuIGV4dGVuc2lv
bl9vcHRzX2xlbiA+IDA7DQoNCklmIGFuIGV4dGVuc2lvbiBpcyBza2lwcGVkLCB0aGlzIGxvb2tz
ID4gMCB3aXRoIG5vIGV4dGVudGlvbi4NCmhhbmRsZV9jYnNfbGVuIGlzIGJldHRlcj8NCg0KDQpU
aGFua3MsDQpLYXp1


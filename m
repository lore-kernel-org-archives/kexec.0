Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D3FEE4996
	for <kexec@archiver.kernel.org>; Mon, 21 Aug 2023 00:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=midBT2fIHnOnBwHWQnWf4KlhLZU32JpwzVkT72DMGl0=; b=uzn30kGA9bXmvT
	nY7+Zj7OCAkGHHCC4KLNZLGYCiZx+JmseXRU+qr0PEAtiD40gI1dAkNj1B7wDQDA6PT5NpfW3hxbg
	Xrm7wQSBCcyaPHa4Mm5TrrJmP5fJiYhVOxs7LVC05p+itzoh6lgv88qc0wU8OtdZn8SF3QF7rWJEj
	lAOV2m5duOl2ezNyjEjsvSjU3VXkdchJGNSFG39mv+u6uhbmpyqr/ujF8jXiDFOtzU2MI/8xPxjQG
	lcyHHAU1ZnUXKIpzDgm9J62PhV6i4yPDCGOCiXNVkfyRQy+2yD9fgiFahbqEzoStVC5wbgTFJrRHP
	ZLCWhmYCVQePiLNrLn0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qXt1g-00Cl4C-3C;
	Mon, 21 Aug 2023 00:44:13 +0000
Received: from mail-tycjpn01on2060c.outbound.protection.outlook.com ([2a01:111:f403:7010::60c] helo=JPN01-TYC-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qXt1c-00Cl3I-2Q;
	Mon, 21 Aug 2023 00:44:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaGsQX28yI8kY8kvWu8OLOtZD3r7FxiNQDZXkw8jnGheXv5FrWLESlORevXAUeQm67uuQE8wKQicu0JfCyEdTfhnA5wrCLGL4Euw2miCa+B8/bv+1YpbMqiFSjOE8wMH2DfzOuw+Q2aHeKKZkiI0CgmvaiERa1/PxiUZY+UolfZmX8hsAqIzID6OmKV7VUz4QFsch5eIO+mS/Zz7TMxXfNRvIpY/6/OtKws0NdPE1QuB/Gl3zFixejl7fK3v9P/mptNBsQymhQFMH5gBLbItr0P39jfjo7EStNNodOBWmpUktE9yc4vC90S4+rscModTBQL0FxFl99fLZdo+VS/bcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xEXmroTn5RuI8U7IBGsxEVIvrkz6oz+/xU2yDmuD14=;
 b=fHm1ySsRaO7f0BkdrYbsrqMVz8bkrSz8Z5IpUed4KLrberCv0XFb4K2IE0XLgiABFDoUbpwRuTKqbiW8djLroaRNXx378lgTZovQss9xP9vvPsGYlQBRr0vQG8xWKmHIEG2fTzEeeLmLT1FutVWeLYOUFjFcodZrbrTm5IBDBvlAX1LGxWevA9wa52BmCGMTX54VSkk/qzQnHXy+4tr4oh1fNWKzK5XLozantmGLxX4AEKPC7h+ioO5HuKTiVjARwkItXvCvvgTMKAmZEEmEJgzzITLeZ03jgw9NR2Td9InuMDSw6bN8wvQCGTG4XWZ09noqhHc6JUMP7GpintBdRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xEXmroTn5RuI8U7IBGsxEVIvrkz6oz+/xU2yDmuD14=;
 b=hBlJiB+hzYji8qNkT8aMuunnTgul1VNw6XSrmXqrxVFvbQZN1C1iU3eazFi/X+0XOIzD5EW/ii0v2qnE/nF41B4O4oSRjWO4rSrzINNTuy/FhUFgyD8IYXTulemma1Qwm4dgqwuLTHa3xBj4yBwm9mZBZrW89ljz63ehdQ6D9/U=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by OS0PR01MB5762.jpnprd01.prod.outlook.com (2603:1096:604:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 00:43:47 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::706e:4b73:60be:9f33]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::706e:4b73:60be:9f33%7]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 00:43:47 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Song Shuai <songshuaishuai@tinylab.org>
CC: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"crash-utility@redhat.com" <crash-utility@redhat.com>, Song Shuai
	<suagrfillet@gmail.com>, "xianting.tian@linux.alibaba.com"
	<xianting.tian@linux.alibaba.com>, "mick@ics.forth.gr" <mick@ics.forth.gr>,
	"heinrich.schuchardt@canonical.com" <heinrich.schuchardt@canonical.com>,
	"guoren@kernel.org" <guoren@kernel.org>, "yixun.lan@gmail.com"
	<yixun.lan@gmail.com>, "lijiang@redhat.com" <lijiang@redhat.com>
Subject: Re: [Crash-utility PATCH V2] RISCV64: Add KASLR support
Thread-Topic: [Crash-utility PATCH V2] RISCV64: Add KASLR support
Thread-Index: AQHZ0bmko31z8GvwHE+anmyvuTpw7K/z7aIA
Date: Mon, 21 Aug 2023 00:43:47 +0000
Message-ID: <158d3047-179a-4b1c-03a6-b9edfdbb5c0b@nec.com>
References: <20230818095028.1012639-1-songshuaishuai@tinylab.org>
In-Reply-To: <20230818095028.1012639-1-songshuaishuai@tinylab.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6777:EE_|OS0PR01MB5762:EE_
x-ms-office365-filtering-correlation-id: 65163561-7c1d-49dc-13a5-08dba1dfae13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9v0nxMn47tNVShXVvg1jqPhLnrN4R9rAMhcTqBOKBTWo3W0xj+bFwXy2Fl7J4XPR0ekNAEL87OfXqxN6ViQoX0aNX9tgfxmHMyP+pcyLHziuR+26jTUKZRG9xdo+F/E5bKfJcAdbCQUJY18ax/j7cvYDpqThgzOkRdXtQ/l26ewfglRQG4ySybmvMpCgd7N6R9IJ0Ai7zLrfC2ITvSvY8xqc1QW+TH0d6tvpUmc/3jgOQcFXKjVpAkTeuBmDvriAwC8NS1mhlmwCUIMxHcl5UPq04f5t5WmaPPTom3r0VNf8jJXpY4eZXYNgObXONUObZxS7MrL4pvGaics6jVtqJuKcuDMBzds6LGSxpshQqXmUxOCKaRhnRlMbUGgq4RCfT62b7CTrP2yuKSxF8sPBn7lLYElmeqAP4huEFcMfIKteRPwIRfrpop7qhQ06Pa2efPCFpNCYoyrkpPn8C98U02jeOMvnly3qQ9RGgVNrzHthSwv4tLSSCaXe5kyMR5t86MGllqZoW57qneiLUyL0N6veTCJvWps7keJbQi/oVbct/bqNLbb5Tl1225UKBrzj6FoY0Mx5agbn8Rje59vw/ZhsWagfJq8TbDZEI5iEyfGFL3TfziVBzX0sVREIH4coJCgr/Z8KxSUEUdTm6c+TfbGA5K6vaXBvNjjM4YLi29Zh4GgZFFt9QIt+Qr5otFYW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(186009)(1800799009)(451199024)(66446008)(66476007)(64756008)(6916009)(54906003)(76116006)(66556008)(66946007)(316002)(6512007)(82960400001)(8676002)(8936002)(2616005)(4326008)(85182001)(41300700001)(36756003)(122000001)(478600001)(966005)(71200400001)(38070700005)(38100700002)(55236004)(53546011)(6506007)(6486002)(2906002)(7416002)(83380400001)(86362001)(31696002)(31686004)(5660300002)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXF5UkE5bnBwUzhtQ2t4MTlCQmtUZ1Q3eTh2Y3lUdEpzS3FlSXV3OEhEU1VZ?=
 =?utf-8?B?SFQ3UUE5bk05UEVGRkFmS3NYVXBoSWJOU2g4ZTJ6TzlrK21GcHg1ZDhJNHl6?=
 =?utf-8?B?YTY1TW85TWZIMnpvWWdjNHVEcE9JT08wNTJ0U1JTeHJzSVo4R3R5SGYwbGRW?=
 =?utf-8?B?a1UxU0pGTlB3eVl4VHgrc2JpYklmbFF2SS9nM2VmbEFSdUtwVXA2aWxMRFdR?=
 =?utf-8?B?RkZvYURrMEQyeTVGQS9acnRvRHJHdERNZElCb1dPcVRZb1pRcUQ5Q1RWYXp6?=
 =?utf-8?B?dk5KbmlsTHB5TUFPR1c0V2ZPUXB6MGpFVS84NmdMN0RpcWtiSmo1ODRFZURq?=
 =?utf-8?B?TE5UV3JVTWJ1U1dwSHBESXo0aElRbjNraG9LelZHRHNYV3NMMkFIWHdHY0x1?=
 =?utf-8?B?MEhrQ2o3VGhGOWhPN1d5djAyUXZIM0N5WS9Bb3dXWEVXOHNaWEYwVUNNOFFY?=
 =?utf-8?B?emdvYlM5UlN2RlFXcDlUdURobzBLNVc5eXVrZjlxWXdNWXR4QjluYWVhKzJj?=
 =?utf-8?B?K0RGY2JvM1p5QS9JY3pNckJ2YzF2SlNUK2xEV3hyUEdPREtlMmVUL1A3M1B0?=
 =?utf-8?B?M01GaC84ajh5RnRKT3NRUmZyUXQvOUg2d3I5ZWNQODE1NHpWR2xreWpkRnRI?=
 =?utf-8?B?Yko1MlFncUFQcytSRGQ4em43ZFBBZFMycDRPbE5qZVlrRkVJSFRHWnlqWVBH?=
 =?utf-8?B?a2xFRVlYekU4TzEzekgvdyttUWdkNHZweGNaWUtaOUo3UG16bkcvd2swT0Nt?=
 =?utf-8?B?N3R0VzhNeUR0d0pzZkJHczNGd1AvZVZPeHZxV01MaUtpb1VUbk9nbEd3cjl1?=
 =?utf-8?B?VkFHWXpBRFVBOElqeXV1Y1Zzbnp5UHpjSGc0c0xFOUp0Y0F3WXVucFNLVFdO?=
 =?utf-8?B?MVlFRzZyS0dENkY5cG44dzdNckc3WURKSldOTDg0Qkp3Vy91S2FaZTRQZXQz?=
 =?utf-8?B?Ym1Qd2E3WHZkMlBHOThFcW12NWJYNVNBZjdyYTZHbG5sc3dlRk9lenR2c2Rk?=
 =?utf-8?B?UUY4U0RBVWNFOFFxZW4vTVVVZWE0VmRYWlBOaGRYbHhLNFFpeHFvY0lUOEds?=
 =?utf-8?B?Rk12QkR5R0U0SzM3QUlJUmNPVmNDb21uU2EwUUJkV0F3Vm1nNlFUcWRSNnFI?=
 =?utf-8?B?b2tBZ2NEbjNCVE9FVnVDVDluRXNmZFFRWW1xSVkwZDRPSUVaL0g2UFJqMHkx?=
 =?utf-8?B?UEtWNGZpcllVSW1LRElXQ2xwOGFWUjF4ZkVodkpmcXBrTVZKSGxISTROK0Rm?=
 =?utf-8?B?RkFYNzV3bEE1Q2FyaTNaL04yVVR2N1NRNG5sd1FiKzdHdGxROE5zS0J1TDBM?=
 =?utf-8?B?aGdwMDEyeThiSUw0MmYwRnViNzU0blI1QmVBa0NUbUtiVndwV01URXhMS2Ni?=
 =?utf-8?B?SE1HSjNnb1RWME8wUzBiSVlZVkpRak1rQkwxWmtOSnZLb3gzekkrZlp1S2FE?=
 =?utf-8?B?ekxEd1hDaENtSERqdHBIRUtDSms4Wm9WZjlpOWVYY1hVU0RUclMyRVdpNzJ4?=
 =?utf-8?B?Y01OeCtmVFhtTUZXbW9lM3pWa1lpeE9UZFI0Y2Z6OGkrVS9RRjRHbUFXTHNC?=
 =?utf-8?B?L0xIWHlHeFVVK05rT01vUUVVd0JvaWtKNysyS0dpOTlZUlFDZEUrZk5SeWRH?=
 =?utf-8?B?c296U0JUSklMZHBRODNmcE0yZW9EbVUvZWk2RFZZZFFPUElOWmRxU1RDOVBq?=
 =?utf-8?B?MDZaQmpuSGZqQTlSaEwzakI5YW0yT2EvUmgrNGJ0VzE5U1RPTElTbC9lK3Jj?=
 =?utf-8?B?bXNFQXpGaERyYVJWYm1OOGYzT1VtSkFyRVhxS0Y4QWhmUkl6L3Jua1FBOGIx?=
 =?utf-8?B?dlJaeHIxbzBtZTNFOTBYZ1JQQ3h2TWYrY3hJOTVZSFJFM2FlaENYVExmdFgx?=
 =?utf-8?B?THBBOGIzbXI4MWNPVitsNithbDRUaUdnUlNsWmZBbDNHdjA0SlRQV0hTRFhr?=
 =?utf-8?B?c0RuRmhJUWN2Y1VqK0wvZUEyeUFTNW5PaHVXRDA4c2E3MnVDZ0Q2WmdCQTFi?=
 =?utf-8?B?M1hpeGRlblU3R1hQc3VqaExGRmpFZUdjb05XN0szSUkzOE1yaURhTjhsdmx1?=
 =?utf-8?B?bmdPT0JhMnZrNE1uM1lJUFoxaUFhNTYzSjU4eVlBT1FJeUU5V0hiK055REFt?=
 =?utf-8?B?TDR2M3YvKzVHTmNQZlRPVXMrUjhzd3JPRGJibFp4RE5DbmduVGJjcUZFQTFi?=
 =?utf-8?B?cVE9PQ==?=
Content-ID: <E890638E7A2FB747804F8A15346C8D1E@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65163561-7c1d-49dc-13a5-08dba1dfae13
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 00:43:47.2734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PMiI+2KoJT6ZR3xWYiErWnb6qT6FPj92LkM0l7DrhEIDk1TyM6J2PMv8b3PxPK4gyYaLiKuEvmOiNXTtLfMq9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5762
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230820_174409_165741_0CA22AFF 
X-CRM114-Status: GOOD (  27.43  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

T24gMjAyMy8wOC8xOCAxODo1MCwgU29uZyBTaHVhaSB3cm90ZToNCj4gRnJvbTogU29uZyBTaHVh
aSA8c3VhZ3JmaWxsZXRAZ21haWwuY29tPg0KPiANCj4gVGhpcyBwYXRjaCBhZGRzIEtBU0xSIHN1
cHBvcnQgZm9yIENyYXNoIHRvIGFuYWx5emUgS0FTTFItZWQgdm1jb3JlDQo+IHNpbmNlIFJJU0Mt
ViBMaW51eCBpcyBhbHJlYWR5IHN1ZmZpY2llbnRseSBwcmVwYXJlZCBmb3IgS0FTTFIgWzFdLg0K
PiANCj4gV2l0aCB0aGlzIHBhdGNoLCBldmVuIGlmIHRoZSBDcmFzaCAnLS1rYXNscicgb3B0aW9u
IGlzIG5vdCBzZXQgb3IgTGludXgNCj4gQ09ORklHX1JBTkRPTUlaRV9CQVNFIGlzIG5vdCBjb25m
aWd1cmVkLCB0aGUgJ2Rlcml2ZV9rYXNscl9vZmZzZXQoKScNCj4gZnVuY3Rpb24gd2lsbCBhbHdh
eXMgd29ya8KgdG8gY2FsY3VsYXRlICdrdC0+cmVsb2NhdGUnIHdoaWNoIHNlcnZlcyB0bw0KPiB1
cGRhdGUgdGhlIGtlcm5lbCB2aXJ0dWFsIGFkZHJlc3MuDQo+IA0KPiBUZXN0aW5nIGluIFFlbXUg
cnY2NCB2aXJ0LCBrZXJuZWwgbG9nIG91dHB1dGVkIHRoZSBrZXJuZWwgb2Zmc2V0Og0KPiANCj4g
WyAgMTIxLjIxNDQ0N10gU01QOiBzdG9wcGluZyBzZWNvbmRhcnkgQ1BVcw0KPiBbICAxMjEuMjE1
NDQ1XSBLZXJuZWwgT2Zmc2V0OiAweDM3YzAwMDAwIGZyb20gMHhmZmZmZmZmZjgwMDAwMDAwDQo+
IFsgIDEyMS4yMTYzMTJdIFN0YXJ0aW5nIGNyYXNoZHVtcCBrZXJuZWwuLi4NCj4gWyAgMTIxLjIx
NjU4NV0gV2lsbCBjYWxsIG5ldyBrZXJuZWwgYXQgOTQ4MDAwMDAgZnJvbSBoYXJ0IGlkIDANCj4g
WyAgMTIxLjIxNjgzNF0gRkRUIGltYWdlIGF0IDljN2ZkMDAwDQo+IFsgIDEyMS4yMTY5ODJdIEJ5
ZS4uLg0KPiANCj4gUnVubmluZyBjcmFzaCB3aXRoIGAtZCAxYCBvcHRpb24gYW5kIHdpdGhvdXQg
YC0ta2FzbHJgIG9wdGlvbiwNCj4gd2UgZ2V0IHRoZSByaWdodCBga3QtPnJlbG9jYXRlYCBhbmQg
a2VybmVsIGxpbmsgYWRkcjoNCj4gDQo+ICQgLi4vY3Jhc2gvY3Jhc2ggLWQgMSB2bWxpbnV4IHZt
Y29yZV9rYXNscl8wODE1DQo+IC4uLg0KPiBLQVNMUjoNCj4gICAgX3N0ZXh0IGZyb20gdm1saW51
eDogZmZmZmZmZmY4MDAwMjAwMA0KPiAgICBfc3RleHQgZnJvbSB2bWNvcmVpbmZvOiBmZmZmZmZm
ZmI3YzAyMDAwDQo+ICAgIHJlbG9jYXRlOiAzN2MwMDAwMCAoODkyTUIpDQo+IHZtZW1tYXAgOiAw
eGZmMWMwMDAwMDAwMDAwMDAgLSAweGZmMjAwMDAwMDAwMDAwMDANCj4gdm1hbGxvYyA6IDB4ZmYy
MDAwMDAwMDAwMDAwMCAtIDB4ZmY2MDAwMDAwMDAwMDAwMA0KPiBtdWR1bGVzIDogMHhmZmZmZmZm
ZjM5NTJmMDAwIC0gMHhmZmZmZmZmZmI3YzAwMDAwDQo+IGxvd21lbSAgOiAweGZmNjAwMDAwMDAw
MDAwMDAgLQ0KPiBrZXJuZWwgbGluayBhZGRyICAgICAgICA6IDB4ZmZmZmZmZmZiN2MwMDAwMA0K
PiAuLi4NCj4gICAgICAgIEtFUk5FTDogL2hvbWUvc29uZy85X2xpbnV4L2xpbnV4LzAwX3J2X2th
c2xyL3ZtbGludXgNCj4gICAgICBEVU1QRklMRTogL3RtcC9oZWxsby92bWNvcmVfa2FzbHJfMDgx
NQ0KPiAgICAgICAgICBDUFVTOiAyDQo+ICAgICAgICAgIERBVEU6IFR1ZSBBdWcgMTUgMTY6MzY6
MTUgQ1NUIDIwMjMNCj4gICAgICAgIFVQVElNRTogMDA6MDI6MDENCj4gTE9BRCBBVkVSQUdFOiAw
LjQwLCAwLjIzLCAwLjA5DQo+ICAgICAgICAgVEFTS1M6IDYzDQo+ICAgICAgTk9ERU5BTUU6IHN0
YWdlNC5mZWRvcmFwcm9qZWN0Lm9yZw0KPiAgICAgICBSRUxFQVNFOiA2LjUuMC1yYzMtMDAwMDgt
Z2FkMThkZWU0MjNhYw0KPiAgICAgICBWRVJTSU9OOiAjMTcgU01QIFR1ZSBBdWcgMTUgMTQ6NDE6
MTIgQ1NUIDIwMjMNCj4gICAgICAgTUFDSElORTogcmlzY3Y2NCAgKHVua25vd24gTWh6KQ0KPiAg
ICAgICAgTUVNT1JZOiA1MTEuOCBNQg0KPiAgICAgICAgIFBBTklDOiAiS2VybmVsIHBhbmljIC0g
bm90IHN5bmNpbmc6IHN5c3JxIHRyaWdnZXJlZCBjcmFzaCINCj4gICAgICAgICAgIFBJRDogMTYw
DQo+ICAgICAgIENPTU1BTkQ6ICJiYXNoIg0KPiAgICAgICAgICBUQVNLOiBmZjYwMDAwMDAxNTJi
YWMwICBbVEhSRUFEX0lORk86IGZmNjAwMDAwMDE1MmJhYzBdDQo+ICAgICAgICAgICBDUFU6IDEN
Cj4gICAgICAgICBTVEFURTogVEFTS19SVU5OSU5HIChQQU5JQykNCj4gY3Jhc2g+DQo+IA0KPiBb
MV06IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXJpc2N2LzIwMjMwNzIyMTIzODUwLjYz
NDU0NC0xLWFsZXhnaGl0aUByaXZvc2luYy5jb20vDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTb25n
IFNodWFpIDxzdWFncmZpbGxldEBnbWFpbC5jb20+DQo+IFJldmlld2VkLWJ5OiBHdW8gUmVuIDxn
dW9yZW5Aa2VybmVsLm9yZz4NCj4gDQo+IC0tLQ0KPiBDaGFuZ2VzIHNpbmNlIFYxOg0KPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9saW51eC1yaXNjdi8yMDIzMDgxNTEwNDgwMC43MDU3NTMtMS1z
b25nc2h1YWlzaHVhaUB0aW55bGFiLm9yZy8NCj4gICAgLSBzdXBwbGVtZW50IHRoZSBvdXRwdXQg
b2YgbXkgQ3Jhc2ggdGVzdCBpbiB0aGUgY29tbWl0LW1zZw0KPiAgICAtIGFkZCB0aGUgUmV2aWV3
ZWQtYnkgZnJvbSBHdW8NCj4gDQo+IC0tLQ0KPiAgIG1haW4uYyAgICB8ICAyICstDQo+ICAgcmlz
Y3Y2NC5jIHwgMTEgKysrKysrKysrKysNCj4gICBzeW1ib2xzLmMgfCAgNCArKy0tDQo+ICAgMyBm
aWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL21haW4uYyBiL21haW4uYw0KPiBpbmRleCBiMjc4YzIyLi4wYzZlNTk1IDEwMDY0
NA0KPiAtLS0gYS9tYWluLmMNCj4gKysrIGIvbWFpbi5jDQo+IEBAIC0yMjgsNyArMjI4LDcgQEAg
bWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQo+ICAgCQkJfSBlbHNlIGlmIChTVFJFUShsb25n
X29wdGlvbnNbb3B0aW9uX2luZGV4XS5uYW1lLCAia2FzbHIiKSkgew0KPiAgIAkJCQlpZiAoIW1h
Y2hpbmVfdHlwZSgiWDg2XzY0IikgJiYNCj4gICAJCQkJICAgICFtYWNoaW5lX3R5cGUoIkFSTTY0
IikgJiYgIW1hY2hpbmVfdHlwZSgiWDg2IikgJiYNCj4gLQkJCQkgICAgIW1hY2hpbmVfdHlwZSgi
UzM5MFgiKSkNCj4gKwkJCQkgICAgIW1hY2hpbmVfdHlwZSgiUzM5MFgiKSAmJiAhbWFjaGluZV90
eXBlKCJSSVNDVjY0IikpDQo+ICAgCQkJCQllcnJvcihJTkZPLCAiLS1rYXNsciBub3QgdmFsaWQg
Ig0KPiAgIAkJCQkJCSJ3aXRoIHRoaXMgbWFjaGluZSB0eXBlLlxuIik7DQo+ICAgCQkJCWVsc2Ug
aWYgKFNUUkVRKG9wdGFyZywgImF1dG8iKSkNCj4gZGlmZiAtLWdpdCBhL3Jpc2N2NjQuYyBiL3Jp
c2N2NjQuYw0KPiBpbmRleCBhMDJmNzVhLi4yODhjN2FlIDEwMDY0NA0KPiAtLS0gYS9yaXNjdjY0
LmMNCj4gKysrIGIvcmlzY3Y2NC5jDQo+IEBAIC0zNzgsNiArMzc4LDkgQEAgc3RhdGljIHZvaWQg
cmlzY3Y2NF9nZXRfdmFfcmFuZ2Uoc3RydWN0IG1hY2hpbmVfc3BlY2lmaWMgKm1zKQ0KPiAgIAl9
IGVsc2UNCj4gICAJCWdvdG8gZXJyb3I7DQo+ICAgDQo+ICsJaWYgKChrdC0+ZmxhZ3MyICYgS0FT
TFIpICYmIChrdC0+ZmxhZ3MgJiBSRUxPQ19TRVQpKQ0KPiArCQltcy0+a2VybmVsX2xpbmtfYWRk
ciArPSAoa3QtPnJlbG9jYXRlICogLTEpOw0KPiArDQo+ICAgCS8qDQo+ICAgCSAqIEZyb20gTGlu
dXggNS4xMywgdGhlIGtlcm5lbCBtYXBwaW5nIGlzIG1vdmVkIHRvIHRoZSBsYXN0IDJHQg0KPiAg
IAkgKiBvZiB0aGUgYWRkcmVzcyBzcGFjZSwgbW9kdWxlcyB1c2UgdGhlIDJHQiBtZW1vcnkgcmFu
Z2UgcmlnaHQNCj4gQEAgLTEzNjAsNiArMTM2MywxNCBAQCByaXNjdjY0X2luaXQoaW50IHdoZW4p
DQo+ICAgDQo+ICAgCQltYWNoZGVwLT52ZXJpZnlfcGFkZHIgPSBnZW5lcmljX3ZlcmlmeV9wYWRk
cjsNCj4gICAJCW1hY2hkZXAtPnB0cnNfcGVyX3BnZCA9IFBUUlNfUEVSX1BHRDsNCj4gKw0KPiAr
CQkvKg0KPiArCQkgKiBFdmVuIGlmIENPTkZJR19SQU5ET01JWkVfQkFTRSBpcyBub3QgY29uZmln
dXJlZCwNCj4gKwkJICogZGVyaXZlX2thc2xyX29mZnNldCgpIHNob3VsZCB3b3JrIGFuZCBzZXQN
Cj4gKwkJICoga3QtPnJlbG9jYXRlIHRvIDANCj4gKwkJICovDQo+ICsJCWlmICgha3QtPnJlbG9j
YXRlICYmICEoa3QtPmZsYWdzMiAmIChSRUxPQ19BVVRPfEtBU0xSKSkpDQo+ICsJCQlrdC0+Zmxh
Z3MyIHw9IChSRUxPQ19BVVRPfEtBU0xSKTsNCj4gICAJCWJyZWFrOw0KPiAgIA0KPiAgIAljYXNl
IFBSRV9HREI6DQo+IGRpZmYgLS1naXQgYS9zeW1ib2xzLmMgYi9zeW1ib2xzLmMNCj4gaW5kZXgg
ODc2YmU3YS4uOGU4YjRjMyAxMDA2NDQNCj4gLS0tIGEvc3ltYm9scy5jDQo+ICsrKyBiL3N5bWJv
bHMuYw0KPiBAQCAtNjI5LDcgKzYyOSw3IEBAIGthc2xyX2luaXQodm9pZCkNCj4gICAJY2hhciAq
c3RyaW5nOw0KPiAgIA0KPiAgIAlpZiAoKCFtYWNoaW5lX3R5cGUoIlg4Nl82NCIpICYmICFtYWNo
aW5lX3R5cGUoIkFSTTY0IikgJiYgIW1hY2hpbmVfdHlwZSgiWDg2IikgJiYNCj4gLQkgICAgIW1h
Y2hpbmVfdHlwZSgiUzM5MFgiKSkgfHwgKGt0LT5mbGFncyAmIFJFTE9DX1NFVCkpDQo+ICsJICAg
ICFtYWNoaW5lX3R5cGUoIlMzOTBYIikgJiYgIW1hY2hpbmVfdHlwZSgiUklTQ1Y2NCIpKSB8fCAo
a3QtPmZsYWdzICYgUkVMT0NfU0VUKSkNCj4gICAJCXJldHVybjsNCj4gICANCj4gICAJaWYgKCFr
dC0+dm1jb3JlaW5mby5fc3RleHRfU1lNQk9MICYmDQo+IEBAIC03OTUsNyArNzk1LDcgQEAgc3Rv
cmVfc3ltYm9scyhiZmQgKmFiZmQsIGludCBkeW5hbWljLCB2b2lkICptaW5pc3ltcywgbG9uZyBz
eW1jb3VudCwNCj4gICAJCX0gZWxzZSBpZiAoIShrdC0+ZmxhZ3MgJiBSRUxPQ19TRVQpKQ0KPiAg
IAkJCWt0LT5mbGFncyB8PSBSRUxPQ19GT1JDRTsNCj4gICAJfSBlbHNlIGlmIChtYWNoaW5lX3R5
cGUoIlg4Nl82NCIpIHx8IG1hY2hpbmVfdHlwZSgiQVJNNjQiKSB8fA0KPiAtCQkgICBtYWNoaW5l
X3R5cGUoIlMzOTBYIikpIHsNCj4gKwkJICAgbWFjaGluZV90eXBlKCJTMzkwWCIpIHx8IG1hY2hp
bmVfdHlwZSgiUklTQ1Y2NCIpKSB7DQo+ICAgCQlpZiAoKGt0LT5mbGFnczIgJiBSRUxPQ19BVVRP
KSAmJiAhKGt0LT5mbGFncyAmIFJFTE9DX1NFVCkpDQo+ICAgCQkJZGVyaXZlX2thc2xyX29mZnNl
dChhYmZkLCBkeW5hbWljLCBmcm9tLA0KPiAgIAkJCQlmcm9tZW5kLCBzaXplLCBzdG9yZSk7DQoN
ClRoYW5rcywgYXBwbGllZC4NCmh0dHBzOi8vZ2l0aHViLmNvbS9jcmFzaC11dGlsaXR5L2NyYXNo
L2NvbW1pdC8xYWE5M2NkMzNmYTExZjlkOWJjOWRjN2U2YTY5OGQ2OTBmZGQxYmIzDQoNCkthenUK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFp
bGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

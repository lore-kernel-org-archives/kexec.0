Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B47C4332F
	for <kexec@archiver.kernel.org>; Thu, 22 Dec 2022 04:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Dsuku1B4KFwG6SDgugU76CZT8wAqlHsjG4oLmLg3REI=; b=qUrKq7G2ZiyUN6
	zYGF2zrbSZ5xw+9y7xA7BvL16Q7zQukPugrnsTfqUQI1ONMJAa2Qa9po3eC2sL+PtcflXEqtrdO8m
	W7fsxRWMY+wUQFmYoLvhntCWw3/86ozsvX0PHiikWz2tBzA+EE9SxLSCgeAu65LbDGuL6xzFejeZS
	aQkEmHWEEXGEE5jPbgtq/D/Gdg5wAUWG6qYYyuu6kIYdxot9G7T4UciKUFxxeGYy2MU7UDPJkFYjV
	unXl2cMhFb/Jp1uD58CB6ggM6jFG7Yxk8y/XAW/Kp8cSXYXiWFQ/5zSlRHt3BtTFsBScZZGPknGni
	cO/RqImlM0HgO8CdA//g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8DW0-006tjP-3g; Thu, 22 Dec 2022 04:49:08 +0000
Received: from mail-tycjpn01on2073.outbound.protection.outlook.com ([40.107.114.73] helo=JPN01-TYC-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8DVs-006teR-A8
	for kexec@lists.infradead.org; Thu, 22 Dec 2022 04:49:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGK8iE0ztfzqjVr0XrylxtNMgjq/p5gNT0qlgqqP+XxePQoQxohfOYaSbAepFwelATRxtOqfPjzNuGeBfF7TTHcG67kk/vSpmMLvExwG92XDgBj/99pjl0WyYWp6tyDROU3/F6sdcq9ahSFhvFXXz1P2sseFTlETuNNxPLupojYvJN6G3q1UcGbiDPwVfkrbzJyD7u9Cq14ifkTTQzrlypNR0PROjvVQ/FF7uel3jpX5tFENkkIxB4trnvdhBS3X0nAcEXj3Q5c/qNJd+zJ6FwmMPDwkGIJdYreXaBoydxdSI3h7gmnndmSkZIi9cTHY8sB2aLQRDUu2C1w03vSJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCLDtmliuttBkw9xOLLBq9r9JQdF9tAFcQc7uv33mkY=;
 b=Tt7Ur7A8zFW8LTWEzy9CGYmnGQUjVfqdzrb6Ibowbt5iZRSmgxPMKlCrrgEYy6sxYh0411zGmCj7fTLzAKoXea4dJjvhuFnmoCxLgbD9VikU4GppLZ8yFip0UZjPapxUWFYwSXvB0Aj/dqYVKc825XlO8RZOUMRxl+lIAGJmBrp2N7LQQm19yZ+hfHzRX2ufv6JSWkSxrjmMz12XsYQjwMAJZnM+sabJXqRKcq3zrXlgIU8qhmTBl6Zf9FDdffJZ/r9V2s+mcrdglwFfmQ/D+V6fA1dRYv8NdBMEvJqGjfzWe+vA+2KmwUc1HcSSlcINr5M+u/+5keRR5EPwjMSB/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCLDtmliuttBkw9xOLLBq9r9JQdF9tAFcQc7uv33mkY=;
 b=jqw2+reHIqLr/B1gDKPVvDsrMj73icvi38DmTIraci0NuycpEkCydjW31hVzcmeR39/jx6F31aZ85W/PgZnTb/XRVNGOH4l12JCuE/fzb/nQ5M+mf6X+vZixGMwlb6P5KxlcJRAvkpQ9y9kuH1bfMBif7LoYxponqMmX/ma27Mc=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by OSZPR01MB8611.jpnprd01.prod.outlook.com (2603:1096:604:18e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 04:48:52 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::7841:9155:aaae:72a5]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::7841:9155:aaae:72a5%9]) with mapi id 15.20.5924.022; Thu, 22 Dec 2022
 04:48:52 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Xianting Tian <xianting.tian@linux.alibaba.com>, lijiang
	<lijiang@redhat.com>, "crash-utility@redhat.com" <crash-utility@redhat.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"hschauhan@nulltrace.org" <hschauhan@nulltrace.org>,
	"lifang_xia@linux.alibaba.com" <lifang_xia@linux.alibaba.com>,
	"mick@ics.forth.gr" <mick@ics.forth.gr>, "heinrich.schuchardt@canonical.com"
	<heinrich.schuchardt@canonical.com>, "guoren@kernel.org" <guoren@kernel.org>,
	"yixun.lan@gmail.com" <yixun.lan@gmail.com>
Subject: Re: [Crash-utility][PATCH V4 1/9] Add RISCV64 framework code support
Thread-Topic: [Crash-utility][PATCH V4 1/9] Add RISCV64 framework code support
Thread-Index:  AQHY5CZdVCBWrb7lWkSZ0txIm6wOBK4YHhwAgAAHIYCAAAQmAIAUmbSAgAmoMoCAQ03JgA==
Date: Thu, 22 Dec 2022 04:48:52 +0000
Message-ID: <712596d6-a7c1-f0fa-4aef-6ecfa1f249a0@nec.com>
References: <20221020015014.46085-1-xianting.tian@linux.alibaba.com>
 <20221020015014.46085-2-xianting.tian@linux.alibaba.com>
 <4022d4a1-8967-3d09-e158-5a6f78f73655@nec.com>
 <4bccb5c9-6385-23d9-d496-65f9bd06beb2@linux.alibaba.com>
 <b5209fda-17c2-9271-c40e-1a0343a725a2@nec.com>
 <CANU+Zye-oDirOROVms1XODVunBf4rErQT1tGAY=62pZeufQUTw@mail.gmail.com>
 <f120e4f0-1db9-fc6a-85dd-f42b58ca4d88@linux.alibaba.com>
In-Reply-To: <f120e4f0-1db9-fc6a-85dd-f42b58ca4d88@linux.alibaba.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6777:EE_|OSZPR01MB8611:EE_
x-ms-office365-filtering-correlation-id: 855207ee-994c-408c-b57e-08dae3d7d2ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  7mWZYtVGzz3l4ojrLLXUkf/Akqbmtz4joVZHnAEbnDIRDDky/0HLeca/fw2hDOehoXBbURx9XNSW/KVeVGo5//A/id+x3c2AhYU6HIchGC04jDbt/8Efv+80mHoc2qDLmB902fZBPKBg/5FPGRAaY7mpHOQ/gzJfrJyjs2qwtunFiKwZ8x7qr3k55R9ak/GWwQ9o35ERJ8WF/fo4QmHXqqIJ4a6WhBa6j6+XKF1TvuC6rBj6QtS3vy0jFqoL28xIH82KfcjAFHV8wzLocPEPhUm3crgQ1LOBxrh9yqTVCLIFcyDMq1bOcGZKq6Su2DyY9oFmik5kkTxDwjFIYp+Z6H4TZB623ul7Gy4l/UWIVuj0ePPovSCuln4ZXZ9Q5HCFwY6D06KwBxgKZHKKMfhoS+u6D2PlAloz0QbAyi4KeT0xL/Ca8B/SZlra1im0GvNxy1fxHJdkDsF0y0KstT2hIa5s8ec6fYH2sdL+Ifvmigwd+c6RsMC73oxC+bTc3Fq2XLN+wipTuR5tiTOsYypcdhhAgEFYviR9hX2CBsA8tpQ88IIV8Uqza/cZP+GDDyXwEeAPchtKpDgTStCtqBILF07UOduMnKbvjG86d6ow/t3C/OFTX+QZ3J6aZq5AXd38jTBrClAUoBXbv76M3+mQbl8umAsByBiCxhO/UvRDS0/JP/jdgfTsxrMCyMJtqwJxTwZgviJ3+JHsm4gxp+1ziuJesWjVlQMvMMtQR9IVK1VXTy9x4LfHFevOOsRI7ncYvys4wg7rP8koqZ2HLmmO2Q==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199015)(85182001)(7416002)(36756003)(31696002)(86362001)(38070700005)(76116006)(4326008)(66556008)(64756008)(66476007)(4744005)(5660300002)(8936002)(54906003)(66946007)(966005)(8676002)(6486002)(55236004)(53546011)(71200400001)(6506007)(66446008)(110136005)(478600001)(316002)(26005)(82960400001)(41300700001)(6512007)(186003)(2616005)(38100700002)(122000001)(2906002)(31686004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?dUFmYzVNVDNRc0xEV3RIdU5RaUFUeFhSaVZqMU4vNzdhM0h0MXRYczdCTk5Y?=
 =?utf-8?B?RnpRNDRLbm5kQWNZZDR2NDB6NmRjcmNabEpoMUh5T2s3Z2x4enpNaHdiWGVO?=
 =?utf-8?B?UzZzVEZxQTlFNGp2emlTN2FkZ2ZFbE1xZmYyRFk4MDg2elJrWjZVOUtlOUtk?=
 =?utf-8?B?OVYycmtLWCtZdEhYNERPbWZTS1MwdmpFT1VVVFMrcklJeVdZWmFxVG41S3Aw?=
 =?utf-8?B?eHdaSHRzOU5DaWNBQUI4WHRGUUdEQTB1UVNqMGdUR3cvSHdtRVpERUdxb1BG?=
 =?utf-8?B?YjJvdWpOSFN6K1FaT09pWDVPVG1QSUpObTJMVmdvUUtrMUlram1lVWZmSnBH?=
 =?utf-8?B?REk3NTFuSkErZjZtUUxUNTJ0NHA0b0RGRFEveVVSSlVHUU5mWFVKM0lPUzBG?=
 =?utf-8?B?TnBFZ0p2MjhmRFgwWFVsaHdjRVJWR3B5OEx2UDVoOEduY3Z0SVhCQWJudSti?=
 =?utf-8?B?cyt2Q0dmNnJsdmQvYk1hWFVWMHcrc1J1TFoxREgzVU5rSkZTcU1vWDBGOGJW?=
 =?utf-8?B?YUJnb1ZiQXh3NW8yOW9SSHdNWGQ1VDhuSmMzdEovc0UwZEpvbHV1dVRsNVJt?=
 =?utf-8?B?cU9ObkZJeUxNbzliYWwrNko4Z2pFSmtnSEVyQnNxa0xuTG90MnVEWWVkbTZx?=
 =?utf-8?B?TVlwdUIwQkZKbVBNMUczQWdYNmprV0kyK0U0ZXV0SG85TjcxeThrMDFLajJl?=
 =?utf-8?B?MDIzMFh3VkhJb0gvUWVWT0d0Q2ZIWjE3SUorVlplSERISURURm1Tb3FHc0ZK?=
 =?utf-8?B?MFZOTzJjZk9aNGJveUhleTN5VU9laVc0R3A2aksyOVl0UTcrK3psV1NDVXNw?=
 =?utf-8?B?OXhteGR6RHR0S01ZVmJlUENqdjkzUE9YWUJZYTdQYTY4QkVwV0pVdVllVWV0?=
 =?utf-8?B?RGVEenJ1dlhiOEJWSENHWkdBOHJpODdZUW5xYzd2TkxjejE4K1djYXRHZWov?=
 =?utf-8?B?NkVXT0d0V21waDVKQ08wZFRuK0FmdjhZTFV0ekZybkZQbVdzU2JiUDYyS1Rp?=
 =?utf-8?B?MzM2YWRIaXdwYWE3VEo3UGltNkY1T2FIUTdGdU9BT0laZjgxYXZ3WGszWXh4?=
 =?utf-8?B?L01MOWZDeThmNVF2cU9RMVpGS1lhaWVmZmpzL09HRU1aQkhOcXNnenZUWHR0?=
 =?utf-8?B?UURFZHhRNDZDQmpkdDVHam1RYkNiaUs1TExXSk5BZm9OaGdVYUpGeVBwa00y?=
 =?utf-8?B?ZE04aHVXK0p1Nms1Y2JrM2NPb0MzTms5b1JIVThJSlduUk9ISFlmSkNtWWJa?=
 =?utf-8?B?NDFIZTJNVlg2K1JiK0dkdzJiVFFaOW9JR3RlSGJQd01vSW1HOTlMdDlaMFFE?=
 =?utf-8?B?RWczNktveVVRUFVtM2ZVZ2pBNjRKVUF3RkVLRG1DZEtuaG45OGR2MnN5c3Ni?=
 =?utf-8?B?cGpZVkpMODV4TVA4YmJ6amQ3N2RTWWFoMjM2Y1dqeHV6RUhhcHAwVkJJdHNu?=
 =?utf-8?B?UE15WStmTktNc0trUWV5MXNUVmNWbTQzcmN3Qks3L2xVWHF5ZDZGV2JuSGVW?=
 =?utf-8?B?aTNxTVdySGpIWGNYYll4alRDUHhmZW9UeEVIZGRqWXRXTHBraVBnc0tzdDB4?=
 =?utf-8?B?THBzOFE4M3A0K0RlL1lWUGhGY1ZyTzZXTWlLc3RuUXV4QlpGZGY3UHhMcmNB?=
 =?utf-8?B?elM0bkpXNE12MDBCWTU0NUJHYWZ0SWh1UHk5eVpZYjVYWWJxZHhxQXdoV29B?=
 =?utf-8?B?OGFZSTljN1B2RXIwekxlNlFwM1ppZ2I0VlhkdmI2Vk95Z0V3MjZ5dUpNK0dL?=
 =?utf-8?B?SUFFZENhcElNcWxTd05CYlhGdFhSdFpQTEY3amhOZ2hwMjBramUxYzRoeWF6?=
 =?utf-8?B?L2EzNkkyUStOL1JOQ3FWeVNXWWVnMXBxbDUwSmh1NHhuRGdKNU9Cb0pCYWtE?=
 =?utf-8?B?UmU0clpZemdsNkN5UXdhMDg0Um9xeWQ4bkRJY0U5bTZNNVlFR0RyKzdtNHRX?=
 =?utf-8?B?czJ0cHlnMlVyQmtTRlh5ajNXc29LS1o5bWNpYnBBeDZ4QlNOY0t2RDdrRU4w?=
 =?utf-8?B?N2RsemVkZzNhS04xc0tQUTV2RnFlYXF1QXp3eW96UWRmbEpLenUzUkp5ZzdH?=
 =?utf-8?B?ZUN5QXR6MUlRUTNFNHFWUGRndnpsNDY4MTR0THdQcFB4ODlZeFIwUFBmeEF5?=
 =?utf-8?Q?42gGJ3kBczQ1LH5wN4GghcGpT?=
Content-ID: <1B35156E80494B4F9C9B1E0985232D3D@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 855207ee-994c-408c-b57e-08dae3d7d2ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2022 04:48:52.2260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OqL7trGyGVeTC7O1QUbY9ARJ2eF++D2sNrvNCFBJ9k4j01o9IPSjGUeYjw3caDTqSWj6pVBub0d0YZhhK/vUMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8611
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221221_204900_853308_426A2ABD 
X-CRM114-Status: UNSURE (   7.22  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

T24gMjAyMi8xMS8wOSAxODowMSwgWGlhbnRpbmcgVGlhbiB3cm90ZToNCj4+IE9uIHRoZSBrZXJu
ZWwgc2lkZSwgc29tZSByZWxldmFudCBrZXJuZWwgcGF0Y2hlcyBnb3QgYWNrLMKgIGl0IHNlZW1z
DQo+PiB0aGV5IHdvbid0wqAgY2hhbmdlIGFueW1vcmUuDQo+Pg0KPj4gQW5kIHRoZSBWNCBsb29r
cyBnb29kIHRvIG1lLCBzbzogQWNrLg0KPiBUaGFua3MswqAgTGludXgga2VucmVsIFJJU0MtViBt
YWludGFpbmVyIHN0aWxsIGRvbid0IGFwcGx5IHRoZSBrZXJuZWwgcGF0Y2gswqAgbGV0J3Mgd2Fp
dC4NCg0KTm93IEkgc2VlIDY0OWQ2YjEwMTlhMiAoIlJJU0MtVjogQWRkIGFyY2hfY3Jhc2hfc2F2
ZV92bWNvcmVpbmZvIikNCmluIHRoZSBtYWlubGluZSwgc28gYXBwbGllZCB0aGUgY3Jhc2ggcGF0
Y2hzZXQuDQoNCmh0dHBzOi8vZ2l0aHViLmNvbS9jcmFzaC11dGlsaXR5L2NyYXNoL2NvbXBhcmUv
ODhhNDkxMGQ5NWQ0Li4uMGQ1YWQxMjkyNTJhDQoNClRoYW5rcywNCkthenUKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0Cmtl
eGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9rZXhlYwo=

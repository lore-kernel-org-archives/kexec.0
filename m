Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F8EC001B0
	for <kexec@archiver.kernel.org>; Mon, 24 Jul 2023 09:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4BlWkzm6RPRCAwEAVL6Xgmtf7tD8HvV+qOsXIrgUaBQ=; b=K5B39nnsDNgJRx
	wYdt6D3AjPJjsStJycPdQLaN7ZtEkWxjL1kCSf7pZv5VLMoKkRQs7A28gsGDdB2V43iS9LGSDkm7l
	UGW1J/pdn6Q9L1dTUEdwlXsdhBOFOqlxZZTVsxGQu8DzSlFCiV1L1Nsq/AsV4LN8em3oskV36Tz+v
	+qcunqR4FMNJPn2qt/Vu/g/BMyaUCfQetns4/0IZTw903PEtrECx6srXglLvL1U7H3glLJbE7yD99
	ORMjw+INk5DwSFlhSMYaxiXWwFZ4qZpEfy0MLndu++kd4NHhvb3zR7dqR/H8StTBMXaxfqUKe+4ee
	Xdq/DaUMTQb6LlFKIjew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNrmT-003OvQ-2H;
	Mon, 24 Jul 2023 09:23:05 +0000
Received: from mail-tycjpn01on20615.outbound.protection.outlook.com ([2a01:111:f403:7010::615] helo=JPN01-TYC-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNrmQ-003Oru-0a;
	Mon, 24 Jul 2023 09:23:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3zMekNGrUfB6VTViJi3Xohcjb6pcyINcojpA+IWZgNYOMgeeSkhjgqqGz+7uGlKUV2VtVV5nS5rumWf9EHLgAxDohK1C/GL5Fbhu4kM0y5i8D2+IYiwz8hhZ+3atKaWzKEzVNKid/Kr2F0RX1nEJImPfqGMw3hz9TqxGYuwE04TBMm87/U5zMcrzfSDoAdTjfJxDURVBt2XefPTjBibDoq6QBTziMyJFARM2D0XFtb2wGiDSs8dPvfLbDkmSPZ63z4kCYRA4FLq9nd4I2oLRjF4bCVxB2OiQl16nuAg3i52LwtvavQ0J2dHhTIrJ+QExTGM9E4kI5oNdxy5wqywwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Flnv7A01S3s3uoaMs+Lds14QXcVbozVA60I8LkFbQuE=;
 b=VPZ5mfmUaeNmQqF4FZGS+6AYNzGFs6+jjBpkDQyk7BPo+vxmmVCY6v9E/1AgE9OPsN2Hvgk4M1ZW2AGjYr2GOuo1zLn4qtVbITie4oF7TTl8klQoA4ZSe0W35K+UZYYvY3sk4I0BiBgx7ueKCdvjv5+2lf6vE4V/kb0RfpBP/hfyYDp8pnOEJP6MjW6z61U6z1pzvieCi3MkFsuBpuNiChjamWFZI+QFxSszzoFwXjQVAkgpU5QlYVYI34cmUE6BtMNyR8Zl14kxUFkZKzswrzP6EhpMuBGfPABbg27VOzrmMjf8z9oVqfrkZkOzMypGXFpr3C3bAsxxSrjpWnh2yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Flnv7A01S3s3uoaMs+Lds14QXcVbozVA60I8LkFbQuE=;
 b=VXNWKCgAnK3mp8kH/hHBa4ARZAQRxCir17Sn3/iEL37ZDrTuPrRz7/WScq5wDY16bJk+n4v4y1URIimWweNkK7c8XLAX5jOeyS6NKm8M2xtp6oRg0ahIUef3PW42uR9yc6w3rel3T/XyRZCtEgv+pjm0Cius34C4MMIqw5SqUME=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by TYCPR01MB11818.jpnprd01.prod.outlook.com (2603:1096:400:38c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 09:22:50 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::706e:4b73:60be:9f33]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::706e:4b73:60be:9f33%7]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 09:22:50 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Song Shuai <suagrfillet@gmail.com>, Conor Dooley
	<conor.dooley@microchip.com>
CC: "xianting.tian@linux.alibaba.com" <xianting.tian@linux.alibaba.com>,
	"mick@ics.forth.gr" <mick@ics.forth.gr>, "heinrich.schuchardt@canonical.com"
	<heinrich.schuchardt@canonical.com>, "guoren@kernel.org" <guoren@kernel.org>,
	"yixun.lan@gmail.com" <yixun.lan@gmail.com>, "lijiang@redhat.com"
	<lijiang@redhat.com>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>, "crash-utility@redhat.com"
	<crash-utility@redhat.com>, "alex@ghiti.fr" <alex@ghiti.fr>
Subject: Re: [Crash-utility] RISCV64: Use va_kernel_pa_offset in VTOP()
Thread-Topic: [Crash-utility] RISCV64: Use va_kernel_pa_offset in VTOP()
Thread-Index: AQHZvhBqH9E6h/MoRk+haTGseoP4WA==
Date: Mon, 24 Jul 2023 09:22:50 +0000
Message-ID: <fa792d6a-dd02-983d-2b4b-3674bde7c66f@nec.com>
References: <20230724040649.220279-1-suagrfillet@gmail.com>
 <20230724-sandpaper-raving-9ad883223e6d@wendy>
 <855df973-4f4b-6fff-a228-c1af80c14db0@gmail.com>
In-Reply-To: <855df973-4f4b-6fff-a228-c1af80c14db0@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6777:EE_|TYCPR01MB11818:EE_
x-ms-office365-filtering-correlation-id: f4981b8a-40d9-4f52-ba11-08db8c278d13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AgFEviBb8nz541zNmOM4jSkbkWa5o7qy/sF61Z+nLDGmZ6BrtnG16PUR8fmJCCIk9e9UdEBqKFXi1puKU8jVe9CkLL0PCX3FA82g3A6p4APJJz97+a8mRf12jLSmoKOTDoucvJ8bnKaQdwrSwtUFK4RI5jnI2/Cpcut9trgcReNPMHvGuNFJfgCgkb6eKBXJRchtOW4HzilyUqpnsbX1MxFieKr2Mlq8ldNIM2taXRqXuUN/p9mC+AQ2WdoSrXndWFpkPnDSIep8T+/FGE2VPcMRshyqle+ZbNVXQ0g/OpM2z7Ek0yAYLMiLqn1oezo2Vnd4amTC8JwZ71ABDK7/tU+56IrkpR0V87AXjhRg1GdOuTcGTltUyJ2JVdLDxfiI8zMnGedcR4ZcckqdkWquqM23F5MhkwBh5XRj7BqOcFBgI1TZ5JoFfYSSAOoQsABzkYh5WJNYUn0DgAd0b+HBYKSf7UuPTdZ9Slu7MRRwAAApOw91qenUvMO5RzK/3oPIMiFuNReA3DMxZUdjTZKEZ78DtOJc+Qgc5fnO8O7k9jTNLV5RujeCoDNh2RIqr27cW6PfrJz5uzcJJvbfI00FtbbWC+w+ok292RsRR9JtYi/dX7NM+vRYfcB/asz1b0zT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199021)(71200400001)(966005)(6512007)(6486002)(478600001)(110136005)(54906003)(186003)(55236004)(53546011)(2616005)(6506007)(26005)(2906002)(76116006)(41300700001)(66446008)(66556008)(4326008)(64756008)(5660300002)(7416002)(316002)(8936002)(8676002)(66946007)(66476007)(82960400001)(38100700002)(122000001)(85182001)(36756003)(38070700005)(31696002)(86362001)(31686004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlBucm9VSWFDdGtqdkxub1JmWGpEeGFRZHBDNUgzMHlaTC9mODZiZzdWRFRo?=
 =?utf-8?B?SVZNVGc1ME5EUEJ4Vy9YWlVzK0VwUUtmV1BaVkRheHhyY2JtbU00R2h0R3dJ?=
 =?utf-8?B?ZmRqMGZscjNMWDJ5bldsZ0s0bjNiTjRKSy8yZkIwWVYyalk1UGc0RVZjcmcy?=
 =?utf-8?B?eVpteVN2NEc2andJZzRNSlloZmtWMEd0OGtNRVNybFRRcUp3UndvNlIwRTJi?=
 =?utf-8?B?WUsrZUUveVhyV0hZNFlwY3ZpK1VnWTErQjE0OU9Uc2IwOTNFbmRvQXVxZWNv?=
 =?utf-8?B?R1Y2cTVmclJtQ1oxVUllT0E5NFN3a2toSXdQcTBZc2RRR0JGRnhtclQwU1di?=
 =?utf-8?B?MHZHMkNmelErbDN4S3VCZ1h6YmtVeE5xZEVRS3JsUUxLa1pxMzQ1RTltcWxH?=
 =?utf-8?B?ekVkNGVDUWlsNzM5bHJWQzkyaWJhNXpzRS9WZm0vQ09ENGRXdllXUjJzbE8v?=
 =?utf-8?B?eHRLR0o1WVRMUEl0Zndvcy82KzlDZWJ0Y29abmZxU08vZEpMYTNMQ253SCtv?=
 =?utf-8?B?MVBVS0dLZ0MwMVhDcUQ4QWhBZ2R2WjlhSU0vNnQ5RXErNFc4MTdGK2ExakVY?=
 =?utf-8?B?YmVsWmFOa2VybDlEdzAvdS9UeUxaYmtLWXRWUGQyT0k2TkFFVzM5Y1NycFI0?=
 =?utf-8?B?U1BmaDc5UUZmYjk3QmFpZklOQUd1dTNpQzhUQllqMlZNdnVrZkI5YzZlTkJP?=
 =?utf-8?B?Rmo0VDZUclVvK2V5eHNJU0YvUzRLM0NibWEza0pZNjlZS2VWbzdjeXpUN0k2?=
 =?utf-8?B?aS8vQjlSQjQ0KzRWaEpzd3c0ckNxZUU5bXBNQ1ZtNEd4ZktXL1dDS0FXcklD?=
 =?utf-8?B?ZWVRNWduckc2YzZMZE5xSCtIcWxydHlrOXZXcHVTOXdFS2loQjlET04xNmJU?=
 =?utf-8?B?WGFTZ20vNUgxa3NhTkdDWGdRaExZYVMzclhsY3pIaDRZenNCTnFZNlh4NTJH?=
 =?utf-8?B?Nkd4ZklrZTJjODRXRlNPRTdaZ0phNURWak9vbURRVG9qdy9aUSt1OGhqWmJQ?=
 =?utf-8?B?ekZDTnhpTVpEM0FCR01PVC9MN0MzTFkwTUx6TTl1SzlVY2lkZEIzVi9NR2hV?=
 =?utf-8?B?VEx6Zk5kRTVXZVNUZ3RtdjdnRWRhK1A0Sm5zMWVWNjNCalArdFVyYjBGdnZ6?=
 =?utf-8?B?R3JXSTFYUW1nYlBWWCtqcDE1cFJLNmk3Z01uUERTSWtudDdJRHh4c1dHUUNZ?=
 =?utf-8?B?MFpqMXJPVUdSdTVsVTdseXkvd2lBRHlKd1RodTNKeWI3RlVoVzFMSXBrQzFV?=
 =?utf-8?B?QkRaMG81NWpNR3JmSTlDZ0hlM0I4T3N3Y1BMa1E4QUcydHdOTzRuRytYRmM2?=
 =?utf-8?B?a0Q1eitNOEFuZ3FtZk5DTFF3VmF0NDRZQkcrK1BtY3VIeGZMdjI4R3FmNzJj?=
 =?utf-8?B?L3JGZmRuZHU0aHhsT3hzY09PTU1vS3c0aTNtU2JGRm0zcXRpZlFUMkYxTXp1?=
 =?utf-8?B?M0FPdG80U1JTL3ZiQk8zQ2l2VDRKZHVudTYwQzduVEFwM0JFMDQyb2ZmMVFG?=
 =?utf-8?B?OTZGT0RWcHgrWHlTeGg3c01sck5sVWJnbVczTHBkTEViY0ltZDV4ZE5EbWpa?=
 =?utf-8?B?ckRlY1dRTGtna1ZONFJ0MVpKdURLK3gvdlZSQzc0VG50ZlFjYTE0cmFJTXZp?=
 =?utf-8?B?d1M3eGFxRjFUY3hVMzFjbHp6YzRQUVErVjBkdkZrTUZBUGplNkhUNEZjT3Vq?=
 =?utf-8?B?a1p1L2VvZThxby9heG1Vc3ZsaVA2YzErVWJGY2U5WHlRMVZDZ0Q2WkJWd1dX?=
 =?utf-8?B?d2dDOFRIakhGbVBGM0x6NXUzWjZFTVlGa3JMemlrS3Z0RkV0bkc3bWd1Qzkw?=
 =?utf-8?B?SnVmSWZ2bHNDd0cvVHhxTm80UGUvUit0amNOUkRjT3k1SGdZOWFSbjdWZlRJ?=
 =?utf-8?B?SWZOREQ0TUZUVnRjVkx6OUxEaUJxc1I0UU5IYjlMQ0VubzA0ZHVaRklkd3RF?=
 =?utf-8?B?aEZXS0xCcW16UmdUWWY3YkdZYmhMSFpqSkM3dkYzWnFCdGNmakR1U3VkdWVi?=
 =?utf-8?B?K0k3dSszL2lEUzNZbzVSeXhlMEp6dng0dWRmYTFWRkhMelJpQ2twNjJFTThm?=
 =?utf-8?B?UTlCWC9BbklSZGNlVG5Lc1ovVXJUcnZXdjJxcWUwUjV5NDZ3cHhzVkRDaGx3?=
 =?utf-8?Q?5xGv3JCTYxOrEUihupckGBjUf?=
Content-ID: <8453B83744DD6D41AE143025D54A5F13@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4981b8a-40d9-4f52-ba11-08db8c278d13
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 09:22:50.1264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VJYNKI7hQZib5QJt5XNQxNaffJB3WBpnKnMbVpT/49pqOcvpjxakeC5cRoJSg8mQDd+v5QRKMMcecFnuMbsFCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11818
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_022302_506016_9C3B1FC9 
X-CRM114-Status: GOOD (  15.08  )
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

T24gMjAyMy8wNy8yNCAxNzo0NCwgU29uZyBTaHVhaSB3cm90ZToNCj4g5ZyoIDIwMjMvNy8yNCAx
NTo0MSwgQ29ub3IgRG9vbGV5IOWGmemBkzoNCj4+IEhleSwNCj4+DQo+PiBPbiBNb24sIEp1bCAy
NCwgMjAyMyBhdCAxMjowNjo0OVBNICswODAwLCBTb25nIFNodWFpIHdyb3RlOg0KPj4+IFNpbmNl
IFJJU0MtViBMaW51eCB2Ni40LCB0aGUgY29tbWl0IDMzMzUwNjhmODcyMSAoInJpc2N2OiBVc2UN
Cj4+PiBQVUQvUDREL1BHRCBwYWdlcyBmb3IgdGhlIGxpbmVhciBtYXBwaW5nIikgY2hhbmdlcyB0
aGUNCj4+PiBwaHlzX3JhbV9iYXNlIGZyb20gdGhlIGtlcm5lbF9tYXAucGh5c19hZGRyIHRvIHRo
ZSBzdGFydCBvZiBEUkFNLg0KPj4+DQo+Pj4gVGhlIENyYXNoJ3MgVlRPUCgpIHN0aWxsIHVzZXMg
cGh5c19yYW1fYmFzZSBhbmQga2VybmVsX21hcC52aXJ0X2FkZHINCj4+PiB0byB0cmFuc2xhdGUg
a2VybmVsIHZpcnR1YWwgYWRkcmVzcywgdGhhdCBtYWRlIENyYXNoIGJvb3QgZmFpbGVkIHdpdGgN
Cj4+PiBMaW51eCB2Ni40IGFuZCBsYXRlciB2ZXJzaW9uLg0KPj4+DQo+Pj4gTGV0IExpbnV4IGV4
cG9ydCBrZXJuZWxfbWFwLnZhX2tlcm5lbF9wYV9vZmZzZXQgaW4gdjYuNSBhbmQgQ3Jhc2ggY2Fu
DQo+Pj4gdXNlICJ2YV9rZXJuZWxfcGFfb2Zmc2V0IiB0byB0cmFuc2xhdGUgdGhlIGtlcm5lbCB2
aXJ0dWFsIGFkZHJlc3MgaW4NCj4+PiBWVE9QKCkgY29ycmVjdGx5Lg0KPj4+DQo+Pj4gU2lnbmVk
LW9mZi1ieTogU29uZyBTaHVhaSA8c3VhZ3JmaWxsZXRAZ21haWwuY29tPg0KPj4+IC0tLQ0KPj4+
IFlvdSBjYW4gY2hlY2svdGVzdCB0aGUgTGludXggY2hhbmdlcyBmcm9tIHRoaXMgbGluazoNCj4+
PiBodHRwczovL2dpdGh1Yi5jb20vc3VnYXJmaWxsZXQvbGludXgvY29tbWl0cy82LjUtcmMzLWNy
YXNoDQo+Pj4NCj4+PiBBbmQgSSdsbCBzZW5kIHRoZSBMaW51eCBjaGFuZ2VzIHRvIHJpc2N2L2Zv
ci1uZXh0IElmIHlvdSdyZSBvayB3aXRoIA0KPj4+IHRoaXMgcGF0Y2guDQo+Pg0KPj4gSWYgeW91
IHdhbnQgdGhpcyB0byBnbyBpbnRvIDYuNSwgeW91J2xsIG5lZWQgdG8gc2VuZCBpdCBmb3Igcmlz
Y3YvZml4ZXMNCj4+IGluc3RlYWQuIEl0IHNvdW5kcyBsaWtlIGEgZml4IGZvciB0aGlzIHdvdWxk
IG5lZWQgdG8gZ28gaW50byA2LjQgdG9vLA0KPj4gbm8/DQo+IFlvdSdyZSByaWdodCwgdGhhdCBz
aG91bGQgYmUgcmlzY3YvZml4ZXMgZm9yIDYuNSBhbmQgdGhpcyBpc3N1ZSBhbHNvIA0KPiBuZWVk
IHRvIGJlIGZpeGVkIGluIDYuNCBzdGFibGUuDQo+IA0KPiBIb3cgYWJvdXQgd2FpdGluZyBmb3Ig
Q3Jhc2ggZ3V5cycgY29tbWVudHMgb24gdGhlIGludHJvZHVjdGlvbiBvZiB0aGUgDQo+ICJ2YV9r
ZXJuZWxfcGFfb2Zmc2V0IiBpbiB2bWNvcmVpbmZvDQo+IGFuZCB0aGVuIGRldGVybWluZSB3aGlj
aCBzdGFibGUgdmVyc2lvbiBzaG91bGQgYmUgdGFrZW4gaW4gdGhlIGZpcnN0IA0KPiAiaWYiIG9m
IGtlcm5lbF92ZXJzaW9uLg0KDQpJIGRvbid0IGhhdmUgYW55IHNwZWNpZmljIGNvbW1lbnQgb24g
dGhpcywgaXQgbG9va3MgbmVjZXNzYXJ5IGFuZCBpZiANCml0J3MgYWNjZXB0ZWQgaW4gdm1jb3Jl
aW5mbywgdGhlbiB3ZSBjYW4gYWNjZXB0IGEgY3Jhc2ggcGF0Y2ggZm9yIGl0Lg0KDQpUaGFua3Ms
DQpLYXp1DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpr
ZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

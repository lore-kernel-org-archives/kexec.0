Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D59C77B61
	for <kexec@archiver.kernel.org>; Mon, 17 Apr 2023 01:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dyZ+++1/RCrN95cmYQ+8xkQP+bQIxgvVdTDPmgxgCtY=; b=b7XGQAUBXw7eCK
	o4aIYa1HofJ/dolVOT+81W8Qkt96ne53PoDgzxjLPatUJ2bGHNZGa42P36HJUedzxf8Qtza8MHq8C
	U3W2jy9nkYAVXTg6zjsuRqASTRcclCAZ1WZDbgfH63+YAWxqd5TM81TjCziX45/Y1UUAkfysasz2T
	MFBYNWasFH0jAB+GAIEAhJ7yv6zGIk5UKzDjlbFJBd9Vb2vN7Syk1OXebcMx3jictVJqdZEGrV/Fk
	G2n2flLpwXAWAmiAWfaULXmyT0Bmo/wYvaqNVfu2n94fFeZuW+S9zI0lxV7TIvz3n3ybAE494ekaU
	WdKlIlSBBfMuiOmE3jKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poDko-00Edmf-0i;
	Mon, 17 Apr 2023 01:34:02 +0000
Received: from mail-os0jpn01on20610.outbound.protection.outlook.com ([2a01:111:f403:700c::610] helo=JPN01-OS0-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poDki-00Edm2-0C
	for kexec@lists.infradead.org;
	Mon, 17 Apr 2023 01:33:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+PlGvEASVIwqqkArXTkSgPMPsRGwdKYmAd2m3dkPqMnTZFkSwTjG2YHLbQpcR/rFKAPU13JddYhalz/Z2LJcGuq/3SXbH8Nv1Hi63JLFEjBMo2xYGmTlI0UnxUCIWL4bsAYiiIS/Mz/m52xQxU6Ahe2Ttx1BffmOIvT7BDZyYeRTGYT8KpDQkFImH5TFsgjR8vdiZnQmLFEwoHs10zNSNFDtRCub978FgztUj/T/Sd6hLA93T7MutSCdH4t/NoyE4WQKeGytTGQ70sAee2Gg0adfT1kytv8dLw5lVn0fypknjYuAgzOmE/+oOJpVDu2WxdZbIMvyyZs6SEtesQH+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQdSxXRhyJ1cF6Kb5jGXV7A4ugcuf2P//bLk253ETwo=;
 b=iNkvueGjln9HiH9pUpguGsr45C8Z29cRcsER/SOl9A6r5A+a9+3BFZbw9rnjqBmwhLUl57WuZTtbJi6pS+whgbjsytwDYV3P/kE3wcm0UCr/+NzS8KhuN8tE63FhIKLP+ZICLyBwCec9Iwtvt8PXdACga5gwuhO70pMpk/Pu0piCr9fE8ncAbwxz8qcg+2YQACWVxFkXDKbIC9LqztpJqx6Ok5ZkEdzXuSoSxp+akxUzqC9SQWbD9H3KwLFq6C8plTurf9/jnoUbBdw9LpZJlXYxwCQEb2VLJgUDw4AZtmkvKcYfa2fKPyaZ73JZj8Iigc/9ZDacF2pV9LqF7Ty7Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQdSxXRhyJ1cF6Kb5jGXV7A4ugcuf2P//bLk253ETwo=;
 b=gHXjZ/FQlQkIY+kcmhNSYObxZwadUWaYpBWT8uQxsvemAhBxbprti6pyhOpq3E8sGmsuO8f1PzyKruzsWS3LHi3yVw0mOhU2zUccnmrvzM1tFG6xKeTjeLjfDRAnqYdcB9FXJObfHVxSzchxFuQrtJ10cYXIWggT4RjTVzBT/dY=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by TYCPR01MB9538.jpnprd01.prod.outlook.com (2603:1096:400:192::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 01:33:42 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::ddeb:3e24:4704:a7f]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::ddeb:3e24:4704:a7f%7]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 01:33:42 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Petr Tesarik <petr@tesarici.cz>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
CC: Luc Chouinard <lucchouina@gmail.com>
Subject: Re: [PATCH v1 0/2] makedumpfile: Fix a couple of warnings
Thread-Topic: [PATCH v1 0/2] makedumpfile: Fix a couple of warnings
Thread-Index: AQHZb7O/Lb35j0qWAEGUVx+76IWvJ68uueCA
Date: Mon, 17 Apr 2023 01:33:41 +0000
Message-ID: <eda8f1ef-efec-bddc-bbf5-89f3fa6f97c3@nec.com>
References: <cover.1681574529.git.petr@tesarici.cz>
In-Reply-To: <cover.1681574529.git.petr@tesarici.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6777:EE_|TYCPR01MB9538:EE_
x-ms-office365-filtering-correlation-id: ac514643-9ff2-4b16-7016-08db3ee3c70b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  RYK8MR6QwKSzR1tZ0BoWog1T2c74HIwsJOWidoCotIXj2QW/eDlLHKRtareb75Sk0InykYnr3B5gJR3gkOOY85Kn6iChJWIeexgWTYs3asf01IHfr3cpqgV7UiyReYQs+PL054AF6YSkQNbzM+nDGbvzFSuVqTesqI7iBe06NkLQ/YNUKSm/b+ODs7aw8LFFqxIIUoe/33jYTwdra1bhhxaS+GWz87F7eKnJqzsL4RE2AvDIDLXDWaxnp5o66gYMzOyYe7Ozhu8gcGo5bCUFCy7HDaNZEfFoHLNqr3fxhy/0AQsek12v6wuC28WMK5M7XyZFTbsSryEYEUNV60ugFfmMBeCO59tXbPiEgG8s4XXNNTRjXWt0cx2ClJLcS5f0CD7UQEN81fT2YWIiBTlgijzG0Ioip7Du1/gLX/5jOSDCvtq+2sfDSCiTtWU9J2KPbI6qQgyMDZfzstb3/4S1baO773nrYEUdkqfLkEicl7iOR6p2nlMy0c5MCd/YaS4KH2Qbjw1J7pWFevvEjYt5X0jXBhuP1ASAfzAB3CU1FZw04CTq8d42AzaAxXVlP0vTxjUthz0U9Ck67l+myKZbXVYpUSstpbxkVw6teuQ4RvO5RZWzHWkQu7j2dI/LmSqEiqa6BnJbLrqfKJJEoIZChw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(451199021)(36756003)(85182001)(38070700005)(2906002)(4744005)(5660300002)(8936002)(8676002)(41300700001)(122000001)(38100700002)(86362001)(31696002)(31686004)(478600001)(2616005)(110136005)(6506007)(26005)(6512007)(53546011)(71200400001)(186003)(966005)(6486002)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(316002)(83380400001)(82960400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?Zi8ybVd2aXJoNTdSQzlpNzk2OUx5Qmora21OdXlhZC9oL2MvYnJiZzdvaWZS?=
 =?utf-8?B?Vy9FcWtjY3FJd2h3Zk9ibFNyL01LVmVtc2dWRFlWL3dtZjFXdHlLWW9tdXRU?=
 =?utf-8?B?VzNQNnhjVHEzTlFmT1dhTUx4NGNFMy9ER21EVHQ1VkluT2o3WHhrbW84Nlgz?=
 =?utf-8?B?UVhDaEwxZngrcnJJYWxGcmVpdlV0eWgxOGM4aDM3QXBxRTlpRGt6S1M4T05N?=
 =?utf-8?B?dnhVbnNYTEFqRys5RjY2Qk41eVJGOHpySy9ZQ0hFNHNVZ3NGUFMweEFyZnVn?=
 =?utf-8?B?ajBaa2RxUGxNaE5qR25oZTk0cUcvV21NVUdNOFk5RDdRcldpeTJSQUFpdGZk?=
 =?utf-8?B?Zng2akNZak4yZ3JoK3dyU2dNTUVCcmVybklVWUFZODJMcC9PbUhXQVNaOERx?=
 =?utf-8?B?L25Zb2ZkWDU2bzBicy9oNkM4ZlJTbm0wVkFYbVltM2hxMW82Nmhybk1CTzE5?=
 =?utf-8?B?ODZBSTFJMlJTNndpOXZnanhHckY1TjgyemMzTE93N0JYWGo1SS9LTVdQYVJw?=
 =?utf-8?B?bjlBVm55VitiL1hXOTd4SGhqMkNNNFFEL3N4V3FHSHR0NFU2bWM5bDRHOFI1?=
 =?utf-8?B?dSswbm5jL3BVd3RCbDdzU1NRL1IvMkppNVgzQ1J6VGM0VERHQ2VvYW5nUE5i?=
 =?utf-8?B?Y2JWMlBvQk1TNllpVzZuS0NlRHIzQnFOQUNka3E3K0hWOHNzbkk1bkhiR09P?=
 =?utf-8?B?VXpGOUF3WWF3WnVkbGx0eWxSMVp0R2VQOVdRSmlnVzN6VnpTRTdweElLcmdr?=
 =?utf-8?B?NFJXYldIM1dTTUZpU3puUWN5TDNhOXFVcHVvUW5ORS9DZmk0RDh6WEpTbmJW?=
 =?utf-8?B?cjFDRFlRM1I1aTNHV21yZ29TUEFZcmE2eVA4Q1FIRDlNNE9xVTI3QVZFU3FW?=
 =?utf-8?B?dDBzd1ZRWi9NcFJsSlBrYW1aQWpsOTUzRHZBUCtBeERpUGIyOGk5Q3lOMlhY?=
 =?utf-8?B?bDVrU2V2UFBta1hXc2VYdWlKaGV5RWVqay9NWDZhVWl4TndNQnAvMCtDenQ4?=
 =?utf-8?B?cVFveDFHQlpFQUdrNjdSc2VnQVVuU0NsTjh6RkVqa3hZYzk1T1lCQ1Vib2hZ?=
 =?utf-8?B?Q3dZcVU1cFJCdVVoaG9VUmdncWZCeWFIV0R3aUtROE5uQThXbzlxck1CaHVN?=
 =?utf-8?B?V29ubWVuUnVicVA5cXNBanJJbitTUytJdG9oME1UdllldDVYUXlHaDc3cUJE?=
 =?utf-8?B?K2c5ZHdqVFM2S0Q5TDl4Q2hzdTVHOE9LSkxDeTdLRlFWbnAzUWNwQUZUVWFW?=
 =?utf-8?B?bGZZTGZsR090Sk0rcTFOaEZBQXZpanlJejNPeEZ6MDVVK0thVXljd1JacUow?=
 =?utf-8?B?T1RKdlpBNnJ4V3U2b2FqN0t1MEo5c2gxUWlQQUlhV24reUwvNjVDRWZ4cGpD?=
 =?utf-8?B?SG9SZi9pQ3pocWc5SzdyTStnWUMwOGdLWExOVEUxb0w5S2gvQVBPVktJY1Ay?=
 =?utf-8?B?V0w0QjlxWVh0dnM3MzFwZGZqbGF0TG56UjdRQ016UzVJalRhb2pFdksvZEx1?=
 =?utf-8?B?aysyNDAyN1dvYVFpVUhNMUxvL2hpTGJadzVRTmE0ekQ4OTBTbUJDM0V5ZTd2?=
 =?utf-8?B?eXU4WkFlTSs4ekpOVkloOWpHaW02RVY0d0R1KzI5WmE3WkRXWUpCdDBXVk9q?=
 =?utf-8?B?TXg5RkFQVGNPY1BqTkdxOXc3SldoeVlVcGdxZytDeWVTNzR4SWRtczljeHRz?=
 =?utf-8?B?Yk9qUk1BV2RQVmovR080U2xUMnZuUkdiVG5VL2hZeHhUZjZBcndlejNiVHlJ?=
 =?utf-8?B?L2NRTVBETzE2VVZsSE1vMU11OEtWVDFzc0RBTTdEclE5dlNMVnRSS0VDYWEw?=
 =?utf-8?B?eGMyVTVxbzQ4amxzWFhjWk5iaENIdDFaOVBUS3RXTnBmd1JlRkdPR2Y4c1Ju?=
 =?utf-8?B?NXo1aDFwWjJ4RjQ5WEtaRWJPVTdncWl0a3NxQkphZml5Vm1aU0NEbEFVdnBR?=
 =?utf-8?B?TkRFdTFXNGp1YW5lTTZJTUdDL1JFcm5FbUZqNTRxZnRzM1Fjd1ExRnpHTU8z?=
 =?utf-8?B?UDJGSFNTb0NFZHFOUDNRNVpjamNzVTJPK2RyTmR6bHdVVVZHV2NKTVB4UVpB?=
 =?utf-8?B?MUxJYTB1OEFWeHc0WWZPYlJNc2V5UVdncVlPeldFbGNjcEU5blVQR0ZlWmNj?=
 =?utf-8?Q?z1TC0a0KhnT9tltc6Z2frItRU?=
Content-ID: <8EC3F88869E9794188E92C78BAA25376@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac514643-9ff2-4b16-7016-08db3ee3c70b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 01:33:42.0460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O8u2KFrfEjTrA6C7p+5XhYH11kfoeG7EcOw+DunkfFBRpWdo+nKdaxOYT2EfcV8j06t7o3kjZ6iwLESnOHJ7qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9538
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230416_183356_482514_A4D6C1D5 
X-CRM114-Status: UNSURE (   9.33  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 2023/04/16 1:02, Petr Tesarik wrote:
> Although none of the warnings is a real issue, they clutter the
> build output, making it easier to overlook another, real issue.

Agree, applied the two patches.
https://github.com/makedumpfile/makedumpfile/compare/58553ad...8e8b881

Thanks!
Kazu

> 
> Petr Tesarik (2):
>    eppic: Fix incompatible pointer type warnings
>    eppic: Fix a warning about redefining ERRMSG
> 
>   extension_eppic.c | 4 ++--
>   extension_eppic.h | 1 +
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

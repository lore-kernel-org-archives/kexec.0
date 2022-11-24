Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746A1C4332F
	for <kexec@archiver.kernel.org>; Thu, 24 Nov 2022 01:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NGA6FbEeUkLr6ltcMR7O5p9swHjJLYFQdaXzAyH30lk=; b=hmbUyV7FhC3KcK
	giUJxZejmHFeAacMJmXpTwdfxIsHLOq7JaoMnYfJQ5XCEGKrk/loFNwKRwjwEAZuL3A6JsrPc4j66
	GhAmFw8/GIg3qlJ08GSImu3Q9Cwx9z277vBkq1jsIHjGgP4apdFOXi4ddSp165Zo/gIhaW0j/5jZm
	fVS1Y3HbUgokiIdS83yl7wLXXyegMci3eBA1Lz6eT3cHuzJLIx59n+bE0a3YgVPOXPRaNvLzY15jl
	Bwz+MlMU34OcvYgbLBV0H/9P/N9JIO62wUTFqy690KJrCbad9r9VYzc1Ek0GSR67THwQmZK7glAGh
	uNE1j5Xh8Fz6/Cl/IulQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oy1Ki-003WJW-Sh; Thu, 24 Nov 2022 01:47:20 +0000
Received: from mail-tycjpn01on2061d.outbound.protection.outlook.com ([2a01:111:f403:7010::61d] helo=JPN01-TYC-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oy1Ke-003WFG-RM
	for kexec@lists.infradead.org; Thu, 24 Nov 2022 01:47:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1pIdR9pMjq6mvFDNXIJrwZPj6evIdqK/NyJ/5qyLoCTimJyhsKuP1HwItOjiEJeNBbgYUe9tjWqNixm8/WbzAEMLAeLhBp3zaSbRV/o/vncqRgibhyCARFGmPYzSAZTvRu8kYdOPvmwaL2JIoQUyx86O3xrUI3B8HikkkBZYknv9AOn081WoY4t0BrOoxEC8plFGanECuAkZKXhrs7J2BC2sA2ikQgL/vwMjuC+b2vTDx3LDLi+lMqSpxVFn9sWRLRN/L7qea6z15qfIxRtQ6siTUot9TerT9aSjVvBU1DZ9L5yhy1Zh5N7U930vJUKik/zdXKbAUhVojO/Yhq3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldhYqfPMaevWVvoOlXH/vPp7gRGkdnwvRDHnXvK54i4=;
 b=SaEtqZ988V7EKojiud/sacoRVGPD6XBimQP7puhrG9N9ae6LGHn3jVrZuYSA3SVKc+vrATVj9r9coRfWb0DLcG6ZCsONKUBbdyUC7ovqbSZcSe/DR32rvOoQQwO21Uq/hbPu6Bva9p7/TJcut4bQ7cx0w1e1+XOC0RNSrXgi5RNxP9OH7PbAliLQKpbbKC/rzySBJowaRTsf9W1rPhpG/GWYkgNkRgKK1zNqrwXwdqfGFKh3jQ7z5U5dQvN2R45X5JXKYIi1j/2KcmnejhbpSLIV6JxCPxS4N+tlneVRaFmAwqeAky0E4XigXJl8+I7r+JV1GmUgQUSpTgdUVSLYBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldhYqfPMaevWVvoOlXH/vPp7gRGkdnwvRDHnXvK54i4=;
 b=AkAgzRc/R+1gvDCU1vdenN3jiz6yJk2hl3idiw/edw1I/HbecjSvBM3Erxr649tXOjvgGg9z+1XljMSGqq4vSbHdsD0c4R4bt1O+tjJsf02xkKjUQYpGDRSl7Z13+8fbVE7V0zWHY51n48xMkJTzGO15o/P46DqMBar4Ps4hiBY=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by TYCPR01MB10478.jpnprd01.prod.outlook.com (2603:1096:400:306::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 01:47:11 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::5905:d55d:b34b:addd]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::5905:d55d:b34b:addd%5]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 01:47:11 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"fontaine.fabrice@gmail.com" <fontaine.fabrice@gmail.com>
Subject: Re: [PATCH makedumpfile] Handle __mips64 as __mips64__ to avoid build
 failure
Thread-Topic: [PATCH makedumpfile] Handle __mips64 as __mips64__ to avoid
 build failure
Thread-Index: AQHY/5677QQcSmDF70C8kby7nE8wjK5NThaA
Date: Thu, 24 Nov 2022 01:47:11 +0000
Message-ID: <6db7a289-94f5-1e94-a937-8bcbd0634d7b@nec.com>
References: <b293ad8c-b380-4d6d-199a-3b9a496eb005@nec.com>
In-Reply-To: <b293ad8c-b380-4d6d-199a-3b9a496eb005@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6777:EE_|TYCPR01MB10478:EE_
x-ms-office365-filtering-correlation-id: 7a9c5dc9-8442-4adc-5a4f-08dacdbdce36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  o8So/0Z5Nur1VFPcgbIXmRh68CRLMUbM43bQkVkQQMtaWaGWLtvBEDu/zzQugBnnoIWE860wOiMbjzF5SzJ9O6OkRFMgmR6zIMCO/CmdvvmY/QCw2ULv7ijEtTzuaFc4PeEHP4GLcCY/auUWBDedPt2Aus4eIusbp1iglYLKVz4GPw4/LetR7rNJ2P9kV1S6iPSCV8ngfavqQGhNCoAo0Fbk1x9atUgRpjUbRmvhz2rrT6P+FfS2fEV7xhEL5kqjck6DjsdANjm3JpXeVD4qeXOEe+4hD6U5LZp0A79nTtHwcFOhnL9OCsIoxpIFqEdHWKNCTkdjtF8RyyaZkRb/XQ7b/2f5ZXqqSJyJ+BOKG1qzTPv2Cb8E3Z5+uHvX0FCwe5si80VMC7f4TMlnUBY898ef+KDSfClc643Zf+5RTLTTRExUwKryRDnEMP5JPOSVIaPhUxAnwUCmseFNuFtnC58idPMaTPcaw0akyqGUEDKWfSrmJ5bo8UAyBnz2YiAHr4pvS4CQ/5xL1Mg/cITTIozB4vYXWAVr8hs2CbpwuK3S/7p26oG10I1HHohX2pWROuakK9qkhR2riJWkloyg0QD0VxxYp389ufNnqA+FvfpRtQDqs0f+TuCO4KJDDOh9WrCkwlToUF6eMC63IWQHoz68i0LGzybmlz1QfRZIFCtJpUv/yKWC4wPdg/hfsGpUaqy42NQwR9ihSTwu9VKiLDyB6+lgy8zX/R1app0aOtZGhsZr8vqIllmmBwny/dLISxrlmGQMlrDofktxfXj9nkIiYat7WBMxXkatobF4PJc=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199015)(36756003)(85182001)(31686004)(86362001)(31696002)(38070700005)(66476007)(71200400001)(66946007)(66446008)(8676002)(64756008)(76116006)(66556008)(38100700002)(122000001)(82960400001)(6486002)(478600001)(6506007)(83380400001)(53546011)(2616005)(55236004)(26005)(6512007)(966005)(2906002)(316002)(110136005)(5660300002)(186003)(41300700001)(8936002)(2004002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?QllEZExnbGg5dkxLa1h5Ym9hVmwzeTQwVDlqd1orUkFNdGhJSTZWNFhKbXpT?=
 =?utf-8?B?dnBNampMVTF4TTBWNkRFMTYvZTFkT3ZsOFQwby9GYTMyZGhQNzY1OEdHS2U1?=
 =?utf-8?B?RnpQTmdHcnJEOHVLWDJudnZ2MmlVampQd0FzdUU1dFBSTURjSW4zMDFKY0xK?=
 =?utf-8?B?SGk4YUdESU04eGdZTVRsdXFxRnZRSHExRkI1MFZGM1Q5MTM5aWNsL25Bc2xp?=
 =?utf-8?B?SUxqYVRSR1hsb1lCNEV5VTBMc1hEeG1TOXgwVVJ2L3FINkNjbDd4RUJ0MjMx?=
 =?utf-8?B?NEdXWTdxSTZWMzFEZVY3K3ZpeG5FaTVUdTNhZDZWTm1Ibis0TlloWktUUVJZ?=
 =?utf-8?B?MTRqREltTE5FTVE1YVc0VDR2RjZsQzB5VVZnbmZHOS9YTHZ3cjREY3h2YXUy?=
 =?utf-8?B?K01LVVZ6bWlxQy9PcHdQYWtwbU5BUnh2V3dZS2ZLRExHbWU1WHlLN2ZpUTR4?=
 =?utf-8?B?SDRnQnFwVnJDd1p6cnZMemJGYnVicEIyL0RMVDlFY3hHZ3dRNjgvVU5ML09x?=
 =?utf-8?B?NzEvc2UwQ05TYlZWazlyYnhZd2lFR1NSdmtsVnpTTXdJOUVnYXE5V1QwMjRO?=
 =?utf-8?B?b0xPZ0taV3hIZkJhYWhjc0E2bWdpemtqRTIrbDRPcHFLZU1oU0I0UStlY3Mr?=
 =?utf-8?B?Nll3dzJkQ1gxYTVmNHdUY3FFZXB3bllCeUJxbVJzaU0veDR0Wm5YNnhvcnU4?=
 =?utf-8?B?Q2VYaUFwdXpIR2NpdWZ1RW95ZGRlU0dHZVl3Nkl5SkN2ZWFVbDRUSHpQOWtP?=
 =?utf-8?B?VlhPQk8vSVdqeXNXTytpQnBlVWdmMitaUGRGbmIyVWs3b0pVa29NUGVEdmQ0?=
 =?utf-8?B?WVBteUxSdjFjOGZyaXVtQmQySEw4NmlOV2Ird2VjM0dJOUt5eTVvVElNMndB?=
 =?utf-8?B?cGhQaHd4bVRnRE0zOXE1SGU2dW1xUGtQaHRJVnRZQjBkL0FNVFNpdkk3OWZx?=
 =?utf-8?B?SG5IWlFlSnJybGIyN1J6SDkyaTNRSTFnUUpZTFQ0NUpuSDhtMmJSVlJPdGlt?=
 =?utf-8?B?K2JpTGNvWmF4eEN3Qzd0ZG1SVEEvam5qdjhIUUs3eTZOUlZ0R2FacVJaaGtS?=
 =?utf-8?B?QmZnZSszcElRNFc2Z3lyK1Q4UjRxdFhEdDJhaXhrbFdMamE3a2d6ZnFJSmV4?=
 =?utf-8?B?c3pRTVpTK2hXNHlrNkR0eXJadyt6ZnRzRmUrQ09MZ3A1V2RwNWFadTJYMGJK?=
 =?utf-8?B?RGtnaWNldFFsUk1iMzBHTG9hQ0NwNkwzUmhYd2xkK2VCU1FDV2lxSHFtSm5I?=
 =?utf-8?B?aXFtQzAyRFlqUGRjVzhvMVgwcTNRU0VRakp5bXJjbjN1V05DMVU5ZTZlUWpP?=
 =?utf-8?B?TmZWWEtLSUVLYjVaY1ZoR3UzbGFCSGI5WHdrWEJMZmNBUEZrbjg5RE14K2Ir?=
 =?utf-8?B?RWxPaUN6QzlNK1pRSzlyb0RrVnFzZFBObU5ZY1pJTlN0Q3NXc1NneVhsd21J?=
 =?utf-8?B?aksyZTdmUk1LcEFRY2ZzYXNkUXZGUVAxMTdsMUE1akdTZm11TmRQMVNSYUZH?=
 =?utf-8?B?RFJJeG9Nc2pzOUdTVUdIVVZRcklPMFhneVpqY2pCdUdVeFpjWXVIL1k4RDQz?=
 =?utf-8?B?eEc3T1FmK2dNSlNwckZUd2lWaEhOYU9QVFlHNkNDQzhWZmQzS3QzZW9ZSVlU?=
 =?utf-8?B?cVBnenhQTTZaUThVWHlwYkdTKzFabk5mU0xjbzhGSVVxT1pGazF0U3h4aTVV?=
 =?utf-8?B?aVlyeXdkelhybmFucHVZT3JDb1JjeGRFUEI0THN1cXRNY2Q4Rk5mR1ZXTEZz?=
 =?utf-8?B?QU1SZTlCbUlVUkxBVGhqdzhidkY5cHFPbE0zYk94ZDhEdHZpQW90UEVxQzcr?=
 =?utf-8?B?dXNvVUdZYkV2NnFmKyszWVdBazZma3pLZCtBUHVxZWtOdjh3ZnJWRHJyNy93?=
 =?utf-8?B?ak84YVdJK2VjS3oxMVBqZVhJMTJzelI1TXJzY1d1VVVRU2pwL2U3QmRxMWZW?=
 =?utf-8?B?cmZtNVlPV1ZrcVRZalpxd3Vvc2xhQ0xuejlPcjVGNnRjVUwzQnBjb2h3b1BU?=
 =?utf-8?B?RkNua0FPTy9DeEpYOEZnTWQybm9nZVU3K0FVWkpvbVVZdSt2aEdRL1lpRHJU?=
 =?utf-8?B?OGJFQm1xSXFmdWwveXdadFJsTzJ2Nnl2a1JoMXNPQnhXb1Z2WE01MFF2aFF2?=
 =?utf-8?B?cEpSVlJRYkJlVDBvcUJjd2owZGJobWNvTUpGekdvVGJCak03WVl5NDMzenMv?=
 =?utf-8?B?alE9PQ==?=
Content-ID: <8703B9596250F144932F8E1CE5ADA027@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9c5dc9-8442-4adc-5a4f-08dacdbdce36
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 01:47:11.8371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MqbvekYcLh2bMzq5q1iQqK8idaHvpXh/R1pF5FpdHniKAnbLKjWgmPEjGo7z4tGLUUnvmaLXyzobmTRE3GQs7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10478
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221123_174717_123225_072E7567 
X-CRM114-Status: GOOD (  19.49  )
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

T24gMjAyMi8xMS8yNCA5OjUwLCBIQUdJTyBLQVpVSElUTyjokKnlsL4g5LiA5LuBKSB3cm90ZToN
Cj4gRnJvbTogRmFicmljZSBGb250YWluZSA8Zm9udGFpbmUuZmFicmljZUBnbWFpbC5jb20+DQo+
IA0KPiBIYW5kbGUgX19taXBzNjQgYXMgX19taXBzNjRfXyB0byBhdm9pZCB0aGUgZm9sbG93aW5n
IGJ1aWxkIGZhaWx1cmU6DQo+IA0KPiBtYWtlZHVtcGZpbGUuYzogSW4gZnVuY3Rpb24gJ2lzX2t2
YWRkcic6DQo+IG1ha2VkdW1wZmlsZS5jOjE2MTM6Mzk6IGVycm9yOiAnS1ZCQVNFJyB1bmRlY2xh
cmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikNCj4gICAgIHJldHVybiAoYWRkciA+PSAo
dW5zaWduZWQgbG9uZyBsb25nKShLVkJBU0UpKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBefn5+fn4NCj4gDQo+IEZpeGVzOg0KPiAgICAtIGh0dHA6Ly9hdXRv
YnVpbGQuYnVpbGRyb290Lm9yZy9yZXN1bHRzLzk0ODI0ZmE4YmFhOGVkYjk5YTVjYTI0NWU1NTYx
ZTBjNGU0MzA2MzgNCg0KbWFrZWR1bXBmaWxlIGhhcyB0byB1c2Ugb25seSB0aGUgIl9fYXJjaF9f
IiBzdHlsZSB0byBlbmFibGUgVEFSR0VUIGJ1aWxkLA0KZS5nLiAibWFrZSBUQVJHRVQ9bWlwczY0
IiBvbiBhbiB4ODZfNjQgbWFjaGluZS4NCg0KWW91ciBidWlsZCBlbnZpcm9ubWVudCBoYXMgIi1E
X19taXBzNjRlbF9fIiwgc28gZG9lcyB0aGlzIHdvcmsgZm9yIHlvdT8NCg0KLS0tIGEvTWFrZWZp
bGUNCisrKyBiL01ha2VmaWxlDQpAQCAtMjQsNyArMjQsOCBAQCBlbmRpZg0KICBBUkNIIDo9ICQo
c2hlbGwgZWNobyAke1RBUkdFVH0gIHwgc2VkIC1lIHMvaS44Ni94ODYvIC1lIHMvc3VuNHUvc3Bh
cmM2NC8gXA0KICAJCQkJLWUgcy9hcm0uKi9hcm0vIC1lIHMvc2ExMTAvYXJtLyBcDQogIAkJCQkt
ZSBzL3MzOTB4L3MzOTAvIC1lIHMvcGFyaXNjNjQvcGFyaXNjLyBcDQotCQkJCS1lIHMvcHBjNjQv
cG93ZXJwYzY0LyAtZSBzL3BwYy9wb3dlcnBjMzIvKQ0KKwkJCQktZSBzL3BwYzY0L3Bvd2VycGM2
NC8gLWUgcy9wcGMvcG93ZXJwYzMyLyBcDQorCQkJCS1lIHMvbWlwczY0ZWwvbWlwczY0LykNCg0K
ICBDUk9TUyA6PQ0KICBpZm5lcSAoJChUQVJHRVQpLCAkKEhPU1RfQVJDSCkpDQoNClRoYW5rcywN
CkthenUNCg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBGYWJyaWNlIEZvbnRhaW5lIDxmb250YWlu
ZS5mYWJyaWNlQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICAgIGFyY2gvbWlwczY0LmMgIHwgMiArLQ0K
PiAgICBtYWtlZHVtcGZpbGUuaCB8IDYgKysrLS0tDQo+ICAgIDIgZmlsZXMgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvbWlw
czY0LmMgYi9hcmNoL21pcHM2NC5jDQo+IGluZGV4IGFiNDViNmUuLmZkOTg3YjAgMTAwNjQ0DQo+
IC0tLSBhL2FyY2gvbWlwczY0LmMNCj4gKysrIGIvYXJjaC9taXBzNjQuYw0KPiBAQCAtMTYsNyAr
MTYsNyBAQA0KPiAgICAgKiBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0
byB0aGUgRnJlZSBTb2Z0d2FyZQ0KPiAgICAgKiBGb3VuZGF0aW9uLCBJbmMuLCA2NzUgTWFzcyBB
dmUsIENhbWJyaWRnZSwgTUEgMDIxMzksIFVTQS4NCj4gICAgICovDQo+IC0jaWZkZWYgX19taXBz
NjRfXw0KPiArI2lmIGRlZmluZWQoX19taXBzNjRfXykgfHwgZGVmaW5lZChfX21pcHM2NCkNCj4g
ICAgDQo+ICAgICNpbmNsdWRlICIuLi9wcmludF9pbmZvLmgiDQo+ICAgICNpbmNsdWRlICIuLi9l
bGZfaW5mby5oIg0KPiBkaWZmIC0tZ2l0IGEvbWFrZWR1bXBmaWxlLmggYi9tYWtlZHVtcGZpbGUu
aA0KPiBpbmRleCA3MGExYTkxLi4zODQyZjljIDEwMDY0NA0KPiAtLS0gYS9tYWtlZHVtcGZpbGUu
aA0KPiArKysgYi9tYWtlZHVtcGZpbGUuaA0KPiBAQCAtOTYzLDcgKzk2Myw3IEBAIHR5cGVkZWYg
dW5zaWduZWQgbG9uZyBwZ2RfdDsNCj4gICAgDQo+ICAgICNlbmRpZiAgICAgICAgICAvKiBzcGFy
YzY0ICovDQo+ICAgIA0KPiAtI2lmZGVmIF9fbWlwczY0X18gLyogbWlwczY0ICovDQo+ICsjaWYg
ZGVmaW5lZChfX21pcHM2NF9fKSB8fCBkZWZpbmVkKF9fbWlwczY0KSAvKiBtaXBzNjQgKi8NCj4g
ICAgI2RlZmluZSBLVkJBU0UJCQlQQUdFX09GRlNFVA0KPiAgICANCj4gICAgI2lmbmRlZiBfWEtQ
SFlTX1NUQVJUX0FERFINCj4gQEAgLTEyMDQsNyArMTIwNCw3IEBAIHVuc2lnbmVkIGxvbmcgbG9u
ZyB2YWRkcl90b19wYWRkcl9zcGFyYzY0KHVuc2lnbmVkIGxvbmcgdmFkZHIpOw0KPiAgICAjZGVm
aW5lIGFyY2hfY3Jhc2hrZXJuZWxfbWVtX3NpemUoKQlzdHViX2ZhbHNlKCkNCj4gICAgI2VuZGlm
CQkvKiBzcGFyYzY0ICovDQo+ICAgIA0KPiAtI2lmZGVmIF9fbWlwczY0X18gLyogbWlwczY0ICov
DQo+ICsjaWYgZGVmaW5lZChfX21pcHM2NF9fKSB8fCBkZWZpbmVkKF9fbWlwczY0KSAvKiBtaXBz
NjQgKi8NCj4gICAgaW50IGdldF9waHlzX2Jhc2VfbWlwczY0KHZvaWQpOw0KPiAgICBpbnQgZ2V0
X21hY2hkZXBfaW5mb19taXBzNjQodm9pZCk7DQo+ICAgIGludCBnZXRfdmVyc2lvbmRlcF9pbmZv
X21pcHM2NCh2b2lkKTsNCj4gQEAgLTIzNjQsNyArMjM2NCw3IEBAIGludCBnZXRfeGVuX2luZm9f
aWE2NCh2b2lkKTsNCj4gICAgI2RlZmluZSBnZXRfeGVuX2luZm9fYXJjaChYKSBGQUxTRQ0KPiAg
ICAjZW5kaWYJLyogc3BhcmM2NCAqLw0KPiAgICANCj4gLSNpZmRlZiBfX21pcHM2NF9fIC8qIG1p
cHM2NCAqLw0KPiArI2lmIGRlZmluZWQoX19taXBzNjRfXykgfHwgZGVmaW5lZChfX21pcHM2NCkg
LyogbWlwczY0ICovDQo+ICAgICNkZWZpbmUga3Z0b3BfeGVuKFgpCUZBTFNFDQo+ICAgICNkZWZp
bmUgZ2V0X3hlbl9iYXNpY19pbmZvX2FyY2goWCkgRkFMU0UNCj4gICAgI2RlZmluZSBnZXRfeGVu
X2luZm9fYXJjaChYKSBGQUxTRQ0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXw0KPiBrZXhlYyBtYWlsaW5nIGxpc3QNCj4ga2V4ZWNAbGlzdHMuaW5mcmFk
ZWFkLm9yZw0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tl
eGVjCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVj
IG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK

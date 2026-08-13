Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60343C5AC67
	for <kexec@archiver.kernel.org>; Thu, 13 Aug 2026 04:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bGaw+29gSllgjFgZkQticX86ts9KGCv7TZ5JCbgTzpM=; b=3X6pidwXFy8tV/btq0YXcjrqu/
	Zp8eRSJLOPKBOsi9mYX9oziITeU2dZi92mhP4/EGbw1A+UznAjf0dRKYvxn+Bj0kxWOZwLU7caLPq
	hgtuGK76gw+Od4JX8qBV+iuwCdRikTk6VkjmKUB8pf6EEtO9k6ZBNymCIR3N+yS1nSBPtKxVNHKt4
	9yZWRuDEIACw1hV9sYqziX0wvj78nYChLfL4fenG8lD2RWCnX+71L8SBao5ry2dlolRQZemwVmHGS
	BOHj29/JEnnamy0o6BmtaPGB98eYNHqBmxZl/ZVb3nAu7vvU7hQaWL+Ju5C0c4lDOATO9x96KYPcn
	aIGrTQBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuNT5-0000000HNk2-1EWQ;
	Thu, 13 Aug 2026 04:55:03 +0000
Received: from mail-japaneastazlp170100000.outbound.protection.outlook.com ([2a01:111:f403:c405::] helo=TY3P286CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuNT2-0000000HNj8-1rxD
	for kexec@lists.infradead.org;
	Thu, 13 Aug 2026 04:55:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9unDR6ped/O5O1hAGgJFhM/A1rha+Vy5ORg+cmlTqEvo5UQRd1tvMBUgISbG5FZCfoyCfAlp+DooWp0bieBAH5jZkR+dDfpcnQtzoI+q0Yh+e6+JqcUCiKDC5ryG5O2pkJyBut2m5M7GLOEvl/grf0+gaCNhLOe/MjgKp+f8W9tfSGO3ED8mTtG8lDVkaOXMYzy8CxYnP+JOhxFhCa/wA7QrChjM1JsM20z9+MiYsQbMF+KCRHG09f0FgEr/3WcdGdugjtNXa3kHy1qiFKhGXiavxg11LdiiFFoyalurQiePzs8+Fkzm2Iddxb8IReoI7B0EzwvtOVy+sAu10CpLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGaw+29gSllgjFgZkQticX86ts9KGCv7TZ5JCbgTzpM=;
 b=XKaxAWNcrlKaSokkSMPs1U5vi2QM/EgoHN+hWpnus7tIMZTtyBpn8+x3zZUKdiyJ3vvGR7u1GayUQxxToY8zmXoKyGdWyA+swb9nw5TE+5fdJ1gNciHIqbUNLOZFlojYXTWNtk+JtZ52swfJSddXvjAnhyQnSbKqYqKhdyTJuLevB1bu5YKzMAixGg9OahdpZabcQwPYEzFzTyuylgEkdp74ezgSEiY86YBCQ36s9y03VB4tWRkdOBSBHB2wzkV4Qj9UX7iKn82NvVHUlJBMSbrtwUaffgXbgTfMTSTS+JhO3RAYEVjExRwVg3B4NNbHZL6RItlCFbSnZGReuZx54A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGaw+29gSllgjFgZkQticX86ts9KGCv7TZ5JCbgTzpM=;
 b=fZGFTyne8kJ/AdKVS3KKI/csEwKnkLO7NuIW3SO4HcKd6AG5pGSZzJ4B69qV3cs3jL7ce8H6J3aQb07ENPaBU+09+ANhu/HhLaBN3Y7Mn2UpPqjhXpNiCnRA3MggAQWCH6dg08F/r8p4e8J6oijUzxTbcyp9vHGzYE4CfXKYFcNAvqvxEzc6roE53PRM6GPOsB7NXVqJgY2BXt8/lFRwNM2UBD3FCPMtDzK5qkEh0ENSF8sJmJ7aZJZBn6GBb1wb+6q7ETk68DkYCvOPrWQtYbY4DnIyPkCfyCVaeO+0wPT2smQoHxra0KPVv6i2/M7jlghwb00H2jDcgqZmiV3CCw==
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 (2603:1096:405:1d7::13) by OS9PR01MB18241.jpnprd01.prod.outlook.com
 (2603:1096:604:4a4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 04:54:46 +0000
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820]) by TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820%6]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 04:54:46 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Tao Liu <ltao@redhat.com>, Stephen Brennan <stephen.s.brennan@oracle.com>
CC: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
Subject: Re: [PATCH makedumpfile 4/9] Introduce a stat for pages retained by
 extension
Thread-Topic: [PATCH makedumpfile 4/9] Introduce a stat for pages retained by
 extension
Thread-Index: AQHdEyowLRMdCvPOA02goWgLx/oeyLabbMWAgAAsgoA=
Date: Thu, 13 Aug 2026 04:54:45 +0000
Message-ID: <429278f7-c1ad-4192-a9e3-9d765aa1fddf@nec.com>
References: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
 <20260714004550.3698175-5-stephen.s.brennan@oracle.com>
 <an0opyG2YuUD-Gez@localhost.localdomain>
In-Reply-To: <an0opyG2YuUD-Gez@localhost.localdomain>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB13462:EE_|OS9PR01MB18241:EE_
x-ms-office365-filtering-correlation-id: 762cc407-4300-429e-3531-08def8f6ff3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|56012099006|10067099003|6133799003|22082099003|18002099003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info: dfvb1tSMZarmZwTw/hLfRxxPj/WJFtUf7WIN25TGnnDqTCsQuYfUL0eiah2+RgYNq/+ON0yPmsL1P32uRNqBpw4ndLdFl0tI4wAZ7bUAedGRwpcItUVnCraO1k9DGeXGtrjdhbqnVuT3k7Xtg5I4IcIsJ1mPDdxEmpPqyKoG9Zz62cndUhgY7pN4NX05xJ5Bujq2+eY6kEItfTIlKfACvPzhmrswQxPuBTVd7a8oO7zPntUB7XvqBXKCMHZchA6+xOzwwTW+8sF67P/1w+PE0zmJ7me93PvUWq2M6mT/J0tWVKZXJYQ4v/M9Me5RRaOf894sS8ltR2TXNaOkV1abVM9lrslrZ59uOzlMJNLuWe2dYMpxg5b/W+lrFItI9xL1tBCLx8hJJ1J4OPkRQdufHPryJbT4yBgTZvYEMoIIqvk041Capd/E7CsI+2LWH/9a/Vuy36PAhhViVy3DInHe8vkTs7LPentvub3KV2MvOszznpwOpX7Svs+L4K2ZySU6xznxvWoPONLQLSGf2UHq3fl5HMQNvA7YoRBrdf7beCOKi17OtnLEWXkmJulMdEq4y0fUm6EQ2V7xr/qqGhbmuuT/Fbmj+rPH1gCAkVZExZvsJEKY6Ucek8BV3OHqCeVo6//kwoDQOSxpirCRcTOtmpRqx6dpdsEVQ6lTq6T61cKo7fS/TzyNUEegZBlOmqis2XAYadBFc0wdWuLAk7d1A5uOnYQi4Y6Vw742VQipn7M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB13462.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjM1TkFFRlZFdXR5RTE3bXBwRzVzWTRLU2FQV3JvVUVGWjU0aUpaY1Y4Yk1O?=
 =?utf-8?B?UVN3dm4rWTd1QnV2d2tyTGxPUGxwcFFpbzNmYW8wYkdrdDJMUSszZFNsZThk?=
 =?utf-8?B?MWZZblB3cVZ0ZVlEWGtobFhPMkJPSzRtTkl2VlJkeVlnZWJSV3N4ejh3d0tD?=
 =?utf-8?B?MHo5SkZaUjRSTnZub1IvQzFGblordHFzV25NSytQUVQzelpNTkp5b0pGeFhH?=
 =?utf-8?B?QzkxWmFkWjM4ZzJqeEFvK29yQnRqYnR4NUZ2K0lkWU5jVzNSZXdKL3JnelF3?=
 =?utf-8?B?NGVEb0I2VFZiZDFnK3pVRDFzY0hUYnYrZU1TSitMYUpzRnYwL0E0dlBoS2JG?=
 =?utf-8?B?WU1NR3Z1Mk9rS3pQaWd2MXlrOGROakZsWmhGamR2cXlCSmpCN0dzKzRQOVkr?=
 =?utf-8?B?RGpLTTdKcGQwaTc5c2M0M1hsOXdFeTNJK2UvZTVMVFlRTUs3cXdqSW1xVlBP?=
 =?utf-8?B?MkpIVTJscTQwWWJNcTdhdjZIcnpHOFhpNlRaZVRtWTF6eGdHdHJRaGwvYjA5?=
 =?utf-8?B?VGJSMVpqY0hYZHVFME1HdVF1dUl1MXl6eEQyaDVybjVXVk9Jd0xoa3VqQVRr?=
 =?utf-8?B?YmhQTS9URlREaGNrSXJWMHJSYTNoZVp3ZlpBV2JnU042M1NxMzVDK1hVKzNJ?=
 =?utf-8?B?OENoNkxSUWJra2tGanJ2UVYrUWJycmdKYlNqd2F1dnBrZkJORlFKU2pBQU9E?=
 =?utf-8?B?djBUTVc3MlNXcXM5b1N0dVZkNUlaYTFFMkhvZzA5akNic2J0emM5K0R0TVFp?=
 =?utf-8?B?cXBLSko5REFwMDFDdTFVTVZpM3RXU1h1My9RUFBPTGRnNy9STXFsZWdBYkdC?=
 =?utf-8?B?QUxvUGRMWDBiOVI4YzlqM0d6N2pxWmhEWXhueWxUWTNyK0IvQlBINGpKeXFJ?=
 =?utf-8?B?Q2hHK1I3UlRMM2IxWWlvMFZrZkx2K2FwV2srWGRGdXRNM3BtOFgwa0JZa2Nl?=
 =?utf-8?B?WGdiNG1HRXVlUHRlY1lObG5NbjZ5SlFHUmVDZlBVUXVodFBHb0hxWDJ3dDJL?=
 =?utf-8?B?WjE3Y25MQnFvUTM2THplT25xY3FRRVhXL3c5OEV6V2ZUZFNhalNjZTU0UERx?=
 =?utf-8?B?emdSWUdnNXl0b210TGdWakR1V05JQWdoelVNWGg5ZnQ0MVU4ZThUSG5XL1ZJ?=
 =?utf-8?B?a2FQbGdiLzAxNm94aktYcHlGSU5heFJUbS9MZTZGSFFnZjJFUk5HLzhPdWdU?=
 =?utf-8?B?M0Jld0VGOFkzUVhDVWZrYXNEdnQ1emtZc1dLTXFjTlJSYitDaGlhdlNuL0xr?=
 =?utf-8?B?T0dNYmxOWWlMckVPWjQyajUrZUdXeERwQVRTczNiK0toeXpLR1FlN3hMUk9m?=
 =?utf-8?B?a1k4algyam8xbWRwdVVoZXBIV1RieGVITUltNjFxN1NkUUtUcVpMK1ljRU9G?=
 =?utf-8?B?SU9UZlFJRTU5MEZ3YktvbXdPT0Fvd3hON1NwK01iMHFPUWZSM09wTnJNNjN1?=
 =?utf-8?B?ZURlOXVsZlBFNEQ1Yi9vNjY5WWYrZW5aMDJmc3NVa2lRa2w2cmcyY2xLTHJS?=
 =?utf-8?B?MFJ1MUIwQ1hYamp1eFkwekVBU0RMUmEzU2xmcitPalhjdFk1d1FycUZnc0tz?=
 =?utf-8?B?SDQwVnMyN1dIdlNmZnl6TFNCcTdrbk5EOXliYjdkWjZLcWpab1dEUmJmOXgv?=
 =?utf-8?B?R2lDZ2RmSmU4QVAwUzFDVkd4RXAwVFVUU3I1R0pleFA2WHU0TjY0cEJZaUpS?=
 =?utf-8?B?a3d0K0JGM3QrZ1lRcEhETGlldUV3WWlhNVQ4eXlFaE1MRWxCS2ZCcVczMVoy?=
 =?utf-8?B?TnM4SDJ3ajRGRU5qcDVlZ25JOWVtbjduMnpHNUYrOS9tS01pa0Q5dEd1THhj?=
 =?utf-8?B?SW5vREdiTHRwYVlzZHA5RGJtU1J4eDNiNzVUdGFuWEN3ZjljWmlmd2tTRisx?=
 =?utf-8?B?RXp6REFSSUxrZTZJK2M0R3Q5SmVHTTlYN1FjZHE3R2xyelR1eGZyY2IrWkxX?=
 =?utf-8?B?ck11alNMRDFLbE10RGlwVW8xbzBnOFpxOWxXUTAyRnhtTTY5dUsybnAxaFJG?=
 =?utf-8?B?OHFGekJOT1Ywd3VDOW5rOFpKQVkreDdHS1JNeFlsWVc3djFldVpwSFZoR2tQ?=
 =?utf-8?B?QWNNMUw0a0dQNDVMeGp1QXRudVE2SmpzeUlvTXNOejhyVXBlbXBkNklyYjI2?=
 =?utf-8?B?cytMekREOVFDZm5CenRSaytvSjlFdUNOdkJJdnpzR2JPR0VlMlRWTklxUUdN?=
 =?utf-8?B?K2FGRkd2cnFCdzZpUUFpeXNoV0lDK2k2c1JJcEZKeXBCU0hHZlprbVZLLzRp?=
 =?utf-8?B?cGxjZnpLSXI1VzVkYnZPb2xITjBGV0RJTkZrV0o2dnVEdHJ6SksxWTBnd1Nl?=
 =?utf-8?B?Y3RSRFdtM0VJOFhOdndHMUZoTWdtOGJoT3BOQ1NCMGhKbjlTSU5uUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF358B507B6BDF4994310D9FCABB7EBA@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13462.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 762cc407-4300-429e-3531-08def8f6ff3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 04:54:46.0731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WjtKl7M1k8q/9lkcQo7rjcWzONrTS+1Ot+8hM39fgg5LHMOs6Ao9HEflxU+3jRQQY669ccRFiq5O83LoXvT2+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB18241
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_215500_899991_B185653E 
X-CRM114-Status: GOOD (  26.82  )
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

T24gMjAyNi8wOC8xMyAxMToxNSwgVGFvIExpdSB3cm90ZToNCj4gSGkgU3RlcGhlbiwNCj4gDQo+
IE9uIE1vbiwgSnVsIDEzLCAyMDI2IGF0IDA1OjQ1OjM3UE0gLTA3MDAsIFN0ZXBoZW4gQnJlbm5h
biB3cm90ZToNCj4+IEV4dGVuc2lvbnMgY2FuIG1hcmsgcGFnZXMgdG8gYmUgZXhjbHVkZWQsIGJ1
dCB0aG9zZSBwYWdlcyBtYXkgYWxyZWFkeSBiZQ0KPj4gZXhjbHVkZWQgZHVlIHRvIHRoZSBkdW1w
IGxldmVsLiBXZSBoYXZlIGEgc3RhdGlzdGljIHRvIGNvdW50IHBhZ2VzDQo+PiBleGNsdWRlZCBi
eSBleHRlbnNpb25zLiBJdCBjb3VudHMgb25seSBwYWdlcyB3aGljaCB3ZXJlIGV4Y2x1ZGVkIGJl
Y2F1c2UNCj4+IG5vIG90aGVyIGNyaXRlcmlhIGV4Y2x1ZGVkIHRoZW0uDQo+Pg0KPj4gRXh0ZW5z
aW9ucyBjYW4gbWFyayBwYWdlcyB0byBiZSByZXRhaW5lZCwgYnV0IHRoZXJlIGlzIG5vIHN0YXRp
c3RpYyB0bw0KPj4gY291bnQgdGhlbS4gQWRkaW5nIGEgY291bnRlciB0byB0aGUgY29kZSBhcy1p
cyB3b3VsZCBub3QgZ2l2ZSB1cyB0aGUNCj4+IHZhbHVlIHRoYXQgd2UgY2FyZSBhYm91dC4gSnVz
dCBhcyBhYm92ZSwgcGFnZXMgbWFya2VkIGZvciBpbmNsdXNpb24gbWF5DQo+PiBoYXZlIGJlZW4g
aW5jbHVkZWQgYW55d2F5IGR1ZSB0byB0aGUgZHVtcC1sZXZlbCBjb25maWd1cmF0aW9uLiBUaGUg
bW9zdA0KPj4gdXNlZnVsIHN0YXRpc3RpYyBpcyB0aGUgb25lIHRoYXQgdGVsbHMgdXMgaG93IG1h
bnkgcGFnZXMgd2VyZSBpbmNsdWRlZA0KPj4gYnkgdGhlIGV4dGVuc2lvbiwgd2hpY2ggd291bGQg
bm90IGhhdmUgYmVlbiBpbmNsdWRlZCBvdGhlcndpc2UuDQo+Pg0KPj4gSW50cm9kdWNlIGEgc3Rh
dGlzdGljIHRoYXQgY291bnRzIHRoaXMgYW1vdW50LiAgVG8gZG8gc28sIHdlIGhhdmUgdG8NCj4+
IHNraXAgdGhlIHNob3J0LWNpcmN1aXQgZXZhbHVhdGlvbiB3aGVuIFBHX0lOQ0xVREUgaXMgcmV0
dXJuZWQuIFRoaXMNCj4+IHNlZW1zIGxpa2UgYSB3b3J0aHdoaWxlIHRyYWRlLW9mZiwgc2luY2Ug
dGhlIGR1bXAtbGV2ZWwgY2hlY2tzIGFyZSBhbGwNCj4+IHJlYXNvbmFibHkgZWZmaWNpZW50Lg0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IFN0ZXBoZW4gQnJlbm5hbiA8c3RlcGhlbi5zLmJyZW5uYW5A
b3JhY2xlLmNvbT4NCj4+IC0tLQ0KPj4gICBtYWtlZHVtcGZpbGUuYyB8IDEzICsrKysrKysrKysr
LS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL21ha2VkdW1wZmlsZS5jIGIvbWFrZWR1bXBmaWxlLmMNCj4+
IGluZGV4IGE0YzliYmYuLmNmNmEzOGYgMTAwNjQ0DQo+PiAtLS0gYS9tYWtlZHVtcGZpbGUuYw0K
Pj4gKysrIGIvbWFrZWR1bXBmaWxlLmMNCj4+IEBAIC0xMDYsNiArMTA2LDcgQEAgbWRmX3Bmbl90
IHBmbl9lbGZfZXhjbHVkZWQ7DQo+PiAgIG1kZl9wZm5fdCBwZm5fZXh0ZW5zaW9uOw0KPj4gICAN
Cj4+ICAgbWRmX3Bmbl90IG51bV9kdW1wZWQ7DQo+PiArbWRmX3Bmbl90IG51bV9leHRlbnNpb25f
cmV0YWluZWQ7DQo+PiAgIA0KPj4gICBpbnQgcmV0Y2QgPSBGQUlMRUQ7CS8qIHJldHVybiBjb2Rl
ICovDQo+PiAgIA0KPj4gQEAgLTY2MzgsOCArNjYzOSw2IEBAIGNoZWNrX29yZGVyOg0KPj4gICAJ
CSAqIG1ha2VkdW1wZmlsZSBleHRlbnNpb25zDQo+PiAgIAkJICovDQo+PiAgIAkJZmlsdGVyX3Bn
ID0gcnVuX2V4dGVuc2lvbl9jYWxsYmFjayhwZm4sIHBjYWNoZSwgJmkpOw0KPj4gLQkJaWYgKGZp
bHRlcl9wZyA9PSBQR19JTkNMVURFKQ0KPj4gLQkJCWNvbnRpbnVlOw0KPj4gICANCj4+ICAgCQkv
Kg0KPj4gICAJCSAqIEV4Y2x1ZGUgdGhlIGZyZWUgcGFnZSBtYW5hZ2VkIGJ5IGEgYnVkZHkNCj4+
IEBAIC02NzIyLDYgKzY3MjEsMTMgQEAgY2hlY2tfb3JkZXI6DQo+PiAgIAkJZWxzZQ0KPj4gICAJ
CQljb250aW51ZTsNCj4+ICAgDQo+PiArCQlpZiAoZmlsdGVyX3BnID09IFBHX0lOQ0xVREUpIHsN
Cj4+ICsJCQkvKiBBY2NvdW50IHBhZ2VzIHdoaWNoIHdvdWxkIGhhdmUgYmVlbiBleGNsdWRlZCwg
YnV0IHdlcmUNCj4+ICsJCQkgKiByZXRhaW5lZCBieSBhbiBleHRlbnNpb24uICovDQo+PiArCQkJ
bnVtX2V4dGVuc2lvbl9yZXRhaW5lZCArPSBucl9wYWdlczsNCj4+ICsJCQljb250aW51ZTsNCj4g
DQo+IE1heWJlIEknbSB3cm9uZywgZnJvbSB0aGUgY29kZSB3ZSBhcmUgdHJ5aW5nIHRvIHJldGFp
biBucl9wYWdlcywgZG9uJ3QNCj4gd2UgbmVlZCB0byBkbw0KPiAJCQlwZm4gKz0gbnJfcGFnZXMN
Cj4gdG8gdXBkYXRlIHRoZSBwZm4gb2YgdGhlIG5leHQgZm9yLWxvb3A/DQoNClRoYW5rIHlvdSBm
b3IgeW91ciByZXZpZXcsIFRhby4NCg0KVGhlIGN1cnJlbnQgY29kZSBiZWxvdyBkb2VzIG5vdCB1
c2UgbnJfcGFnZXMgdG8gc2tpcCB0YWlsIHBhZ2VzIHRvIGJlDQpyZXRhaW5lZCwgc28gSSB0aGlu
ayB0aGlzIHBhdGNoJ3MgY29kZSBtYXRjaGVzIHRoaXMuDQoNCiAgICAgICAgICAgICAgICAgLyoN
CiAgICAgICAgICAgICAgICAgICogVW5leGNsdWRhYmxlIHBhZ2UNCiAgICAgICAgICAgICAgICAg
ICovDQogICAgICAgICAgICAgICAgIGVsc2UNCiAgICAgICAgICAgICAgICAgICAgICAgICBjb250
aW51ZTsNCg0KKFJldGFpbmVkIHRhaWwgcGFnZXMgd2lsbCBiZSBza2lwcGVkIGF0IGNvbXBvdW5k
X2hlYWQgY2hlY2suICBJZiB3ZQ0KY2hhbmdlIHRoaXMgYmVoYXZpb3IsIGEgc2VwYXJhdGUgcGF0
Y2ggd291bGQgYmUgcHJlZmVyYWJsZS4pDQoNCkJ1dCBvbiB0aGUgb3RoZXIgaGFuZCwgaWYgd2Ug
c2V0IG5yX3BhZ2VzIHRvIDEgd2hlbiBQR19FWENMVURFLA0KZXh0ZW5zaW9ucyBjYW5ub3QgZXhj
bHVkZSB0YWlsIHBhZ2VzPw0KDQogICAgICAgICAgICAgICAgIGVsc2UgaWYgKGZpbHRlcl9wZyA9
PSBQR19FWENMVURFKSB7DQogICAgICAgICAgICAgICAgICAgICAgICAgbnJfcGFnZXMgPSAxOw0K
ICAgICAgICAgICAgICAgICAgICAgICAgIHBmbl9jb3VudGVyID0gJnBmbl9leHRlbnNpb247DQoN
ClRoYW5rcywNCkthenUNCg0KPiANCj4+ICsJCX0NCj4+ICsNCj4+ICAgCQkvKg0KPj4gICAJCSAq
IEV4ZWN1dGUgZXhjbHVzaW9uDQo+PiAgIAkJICovDQo+PiBAQCAtODI2NSw2ICs4MjcxLDcgQEAg
d3JpdGVfZWxmX3BhZ2VzX2N5Y2xpYyhzdHJ1Y3QgY2FjaGVfZGF0YSAqY2RfaGVhZGVyLCBzdHJ1
Y3QgY2FjaGVfZGF0YSAqY2RfcGFnZSkNCj4+ICAgCWlmIChpbmZvLT5mbGFnX2N5Y2xpYykgew0K
Pj4gICAJCXBmbl96ZXJvID0gcGZuX2NhY2hlID0gcGZuX2NhY2hlX3ByaXZhdGUgPSAwOw0KPj4g
ICAJCXBmbl91c2VyID0gcGZuX2ZyZWUgPSBwZm5faHdwb2lzb24gPSBwZm5fb2ZmbGluZSA9IHBm
bl9leHRlbnNpb24gPSAwOw0KPj4gKwkJbnVtX2V4dGVuc2lvbl9yZXRhaW5lZCA9IDA7DQo+PiAg
IAkJcGZuX21lbWhvbGUgPSBpbmZvLT5tYXhfbWFwbnI7DQo+PiAgIAl9DQo+PiAgIA0KPj4gQEAg
LTk2MTAsNiArOTYxNyw3IEBAIHdyaXRlX2tkdW1wX3BhZ2VzX2FuZF9iaXRtYXBfY3ljbGljKHN0
cnVjdCBjYWNoZV9kYXRhICpjZF9oZWFkZXIsIHN0cnVjdCBjYWNoZV9kDQo+PiAgIAkJICovDQo+
PiAgIAkJcGZuX3plcm8gPSBwZm5fY2FjaGUgPSBwZm5fY2FjaGVfcHJpdmF0ZSA9IDA7DQo+PiAg
IAkJcGZuX3VzZXIgPSBwZm5fZnJlZSA9IHBmbl9od3BvaXNvbiA9IHBmbl9vZmZsaW5lID0gcGZu
X2V4dGVuc2lvbiA9IDA7DQo+PiArCQludW1fZXh0ZW5zaW9uX3JldGFpbmVkID0gMDsNCj4+ICAg
CQlwZm5fbWVtaG9sZSA9IGluZm8tPm1heF9tYXBucjsNCj4+ICAgDQo+PiAgIAkJLyoNCj4+IEBA
IC0xMDU3NSw2ICsxMDU4Myw3IEBAIHByaW50X3JlcG9ydCh2b2lkKQ0KPj4gICAJUkVQT1JUX01T
RygiICAgIEh3cG9pc29uIHBhZ2VzICAgICAgICAgIDogMHglMDE2bGx4XG4iLCBwZm5faHdwb2lz
b24pOw0KPj4gICAJUkVQT1JUX01TRygiICAgIE9mZmxpbmUgcGFnZXMgICAgICAgICAgIDogMHgl
MDE2bGx4XG4iLCBwZm5fb2ZmbGluZSk7DQo+PiAgIAlSRVBPUlRfTVNHKCIgICAgRXh0ZW5zaW9u
IGZpbHRlciBwYWdlcyAgOiAweCUwMTZsbHhcbiIsIHBmbl9leHRlbnNpb24pOw0KPj4gKwlSRVBP
UlRfTVNHKCIgIFJldGFpbmVkIGJ5IGV4dGVuc2lvbiAgICAgOiAweCUwMTZsbHhcbiIsIG51bV9l
eHRlbnNpb25fcmV0YWluZWQpOw0KPj4gICAJUkVQT1JUX01TRygiICBSZW1haW5pbmcgcGFnZXMg
IDogMHglMDE2bGx4XG4iLA0KPj4gICAJICAgIHBmbl9vcmlnaW5hbCAtIHBmbl9leGNsdWRlZCk7
DQo+Pg0KPiBJIHN1Z2dlc3QgdG8gcmVvcmRlciB0aGUgInByaW50X3JlcG9ydCIgYXMgZm9sbG93
czoNCj4gDQo+IE9yaWdpbmFsIHBhZ2VzICA6DQo+ICAgIEV4Y2x1ZGVkIHBhZ2VzICAgOg0KPiAg
ICAgIFBhZ2VzIGZpbGxlZCB3aXRoIHplcm8gIDoNCj4gICAgICBOb24tcHJpdmF0ZSBjYWNoZSBw
YWdlcyA6DQo+ICAgICAgUHJpdmF0ZSBjYWNoZSBwYWdlcyAgICAgOg0KPiAgICAgIFVzZXIgcHJv
Y2VzcyBkYXRhIHBhZ2VzIDoNCj4gICAgICBGcmVlIHBhZ2VzICAgICAgICAgICAgICA6DQo+ICAg
ICAgSHdwb2lzb24gcGFnZXMgICAgICAgICAgOg0KPiAgICAgIE9mZmxpbmUgcGFnZXMgICAgICAg
ICAgIDoNCj4gICAgICBFeHRlbnNpb24gZmlsdGVyIHBhZ2VzICA6DQo+ICAgIFJlbWFpbmluZyBw
YWdlcyAgOg0KPiAgICAgIEV4dGVuc2lvbiByZXRhaW4gcGFnZXMgIDoNCj4gDQo+IElNSE8sIHRo
aXMgaXMgY2xlYXJlciB0byByZXByZXNlbnQgIk9yaWdpbmFsIHBhZ2VzIiA9PSAiRXhjbHVkZWQg
cGFnZXMiICsgIlJlbWFpbmluZyBwYWdlcyI7DQo+IGFuZCAiRXh0ZW5zaW9uIHJldGFpbmVkIHBh
Z2VzIiBpcyBhIHN1YnNldCBvZiAiUmVtYWluaW5nIHBhZ2VzIi4NCj4gDQo+IFRoYW5rcywNCj4g
VGFvIExpdQ0KPj4gLS0gDQo+PiAyLjQ3LjMNCj4+


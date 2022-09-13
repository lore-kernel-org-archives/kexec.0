Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0415FC54EE9
	for <kexec@archiver.kernel.org>; Tue, 13 Sep 2022 04:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ue3JFX6cIUny7PjZMTXS8o3ujWFERXBif7jKR3Sa/J0=; b=dKB0H/v0FFRu5Q
	oWnComibkVPiPwHxXcEj7xbUYnSKkJbm8ZHH8zE0oxf6EpapjAT7YNPyFJJROJlysExqqrsiznWCM
	FgY9fWf1Td3k8KfMBv8jHdjcGD6SOAmFkEUBzo0fsC2CPRpY1ki3E6znFkB2Gw/7WQ1UG1MIiwyd6
	rMd8QZ1m/Eyjg3g7Fvl/j1uGN+peDyQ4XkcJtCCn0eV4rNcwS1VIRDXuoJkyK0tQOooxSkzfaq2Ms
	TBeH/ETg3BfzEtObUit9BRKovXIFtLifT6KB+W/Rr1IqguxCfGkBml28HB81qMErbYIqeClf0+B4S
	1F0zmu8CwEakFgdKtHWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXxgj-001m4B-Qd; Tue, 13 Sep 2022 04:38:21 +0000
Received: from mail-tycjpn01on2050.outbound.protection.outlook.com ([40.107.114.50] helo=JPN01-TYC-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXxWm-001bjW-2P
	for kexec@lists.infradead.org; Tue, 13 Sep 2022 04:28:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Np5M5ZrPHYSgnFjlDr1TzmCOxl69El+hjT2EtISAV1QBJ12QNJVdIW+CYuL1YEgZnbPZ7SSvmvOBxfiIPGKmE8rYldJ9Ca/fxSW6pIIiktvUu3d8yIj8bl9Yrm6XcIpUYfuFWBTmKqnV+s54JIIkpgU3FSkZfIS0ERgGjn7ic0mbrMCLWn3CO4TMqgE8F1mJexJECx6bq3Lnl+y93bHX4pwcaQrqaSgHcC8klpkPSx1bLgj6sRMcwF+r0q8V0DpCqzf2rx2jIRt6yxn+c0As873FkRoBuuCFg2IJOnxWKmEuVbJtGD+HzDcZSkKfoUl+6BGQYivoquRPrc6ut2MKXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlV7XST9Fxj7jRvEYu/84X64QSLDXgVXtfAJpqi9e3g=;
 b=NzjkYcBFBLHM2M/cmZ4gaB8c21dDEvoAZrLQiimJM8l7NGerGeq1KywRRrtB82f+iNpOx3LO7pMLOoIB98JWc0J4UfWU6+yI2ZVKflh7nJHwgVhmmJPAXn5P9vybeaZYPIUtWU4Dgz2qENBiDtdyVl0XXJxC91KY65GVDScL1tihvR7Ge/UyAT8J8oteggQzJia4lX0WLTkCRQugICLgJuq/2FhUO4k5vYEou1lX5d+DyHSVeL/hz0Dpb4Jsw967Ita4sivDSPoVeUXg5kuQH+onyXL0EeVDWgpcHzVbRm+dwJUNWgKAoOChBalg5SWwDiVfhAHWbaBkxRzKnQbBZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlV7XST9Fxj7jRvEYu/84X64QSLDXgVXtfAJpqi9e3g=;
 b=R9dt3x3m72c8DrAeqw3QD9zAIVH70atr1r20xj0/Zjv2+yPjQEZ8eAP95DtYnj3OGKJhD6IdJ9ZdIAIwT4FXMo15e7JvgGCpSnYycUxb09a5wg1nKcYG1vgbv7TFG7A2vKjJf8jX9wPl4ZjwJq7sTK5Jc0ssV7p9NOr8HXieGmY=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by TYWPR01MB10033.jpnprd01.prod.outlook.com (2603:1096:400:1e1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 13 Sep
 2022 04:27:53 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::1de8:31fd:2234:5ac1]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::1de8:31fd:2234:5ac1%3]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 04:27:53 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Xianting Tian <xianting.tian@linux.alibaba.com>, lijiang
	<lijiang@redhat.com>
CC: "Discussion list for crash utility usage, maintenance and development"
	<crash-utility@redhat.com>, Nick Kossifidis <mick@ics.forth.gr>,
	"heinrich.schuchardt@canonical.com" <heinrich.schuchardt@canonical.com>,
	"guoren@kernel.org" <guoren@kernel.org>, Yixun Lan <yixun.lan@gmail.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"hschauhan@nulltrace.org" <hschauhan@nulltrace.org>,
	"huanyi.xj@alibaba-inc.com" <huanyi.xj@alibaba-inc.com>,
	"lifang_xia@linux.alibaba.com" <lifang_xia@linux.alibaba.com>
Subject: Re: [PATCH V3 0/9] Support RISCV64 arch and common commands
Thread-Topic: [PATCH V3 0/9] Support RISCV64 arch and common commands
Thread-Index: AQHYxC2XEPXXFM1jVkSSKKsoqcPC6K3co8kAgAAmOwA=
Date: Tue, 13 Sep 2022 04:27:53 +0000
Message-ID: <e9efc067-360f-3144-a1c4-728b12a7a148@nec.com>
References: <20220813031753.3097720-1-xianting.tian@linux.alibaba.com>
 <CANU+Zyd+276V6uDsWcyCtB+sfdu2xObvnh9Sxmr4d=UOt27nNQ@mail.gmail.com>
 <8c298bd7-434b-393e-0a04-7fc6956d5eb1@linux.alibaba.com>
In-Reply-To: <8c298bd7-434b-393e-0a04-7fc6956d5eb1@linux.alibaba.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6777:EE_|TYWPR01MB10033:EE_
x-ms-office365-filtering-correlation-id: 4754a0e3-ce83-43f1-0829-08da95405368
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  xIsR8QWhWLnStKR54hfc/Q9fOQbzUjN+q+0DR0cm4f0CahDvmFlXUw22oCRiZKrnW5eoFcruYp9IUsgUVPbMVsNaRaNzB6l344YrIBusRZjs3i0tPqAoc8hvTObkrZLMEBDC1TxYwwg0AGTURWDfWUO/Rqbm5njv4wBA2t8j0VEXQWHkka8a8xrzHG1V7GQo5rHJGerI9TY3lenu7qVU7anSvN8EgyZWCE9zkBck/QeB2OfIKyst+5xCzAm2nbogINYMf3/EYvWaGNcdg0GiE2+4CGwQhCZP+BncQ17cuISo6ftgteZ1iE+UrRnl1tbi3INxNtrdQ4JVCgfiE4eVTavJIszIFFKgTyGb5Xq0UdSr44NGGcOaSXMYLAzAewUUdC7v56yCLmtWJdhxgHqR3+aPGNdpDNltCU5jnzLDY8foQOc0SjpW3ewjnkb8gb8/n6GrDIWb0Ki9WJy6zmaxJRrrS+Td8/xk53r7Anuns0vyn7fDh/9eJZV0NVp1Ily5Szg+wWs9/ZxQCcHkOayQv8g8EF2NGKxHq6tLCgP2YeISdjmr4e8HyCk6lwMHX5CkyGSD7rbIF6QoALrUjxp90liYRQDUpVpv8wy53TuEmzWc/nuaYyXo2IsSlsVERHVx7JIeS8EaO7bP16fuddESpR/xXPCnAvm+shLSNbR9llszN0smYNuYPQG+IIv8EMSfmIVdK+23sT5/ehAxfIOhUGojWKvvdaZceMSBDTMLSp7hGQC+CUuIWF4BqlAlOZMV3Z/LqswGcgsmw+cPuYU6AekcxukdrQcu/mRqcCJ5Yiw=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199015)(85182001)(2616005)(122000001)(31696002)(86362001)(66556008)(38100700002)(82960400001)(41300700001)(6486002)(478600001)(38070700005)(316002)(54906003)(66446008)(2906002)(64756008)(110136005)(8676002)(6506007)(76116006)(66946007)(31686004)(4326008)(8936002)(7416002)(4744005)(36756003)(66476007)(5660300002)(53546011)(186003)(71200400001)(26005)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?cGZHY3pQOWdRQmpndUtmSElBU3UwK0laWjZJM05kTHJxc0Y1bUJ2ZWpSaU8r?=
 =?utf-8?B?UXBzbUkwcE1JNXNqaDMveVIrdHg2dUw3Qk1uWU5kV24zeVhYeEYwVFl3bE1m?=
 =?utf-8?B?RFhEd09hcDhqWVJ1YUFrSlpocEhSakFUakwvZDczUG1kVWY0bTZzTUpHbjJP?=
 =?utf-8?B?TkdWS0h0MGo0di9sVi9seWZkNUxNWU41ZjhsZHVhK2ZxVFhKSFZNWU0wYjRq?=
 =?utf-8?B?bklEbjExbnNFbnNpMGFyZkdEMnArejZUS05QMnRZVlFIc3M5MnR5T2dYWmUz?=
 =?utf-8?B?OUE3dTQ4YkV4RXV1b0MzM0RkdXJDdXRCYzVyaW53RWxhenUwbG5VbXZoR0w0?=
 =?utf-8?B?OURLbGpRdHhFZlpoOU5vL0FpWFNMamxhQWFFU1pSWDczR29EZjd6UjhXMkNl?=
 =?utf-8?B?UVBjMnk0QW9jZHM1NUJuWks1TGxnSFFUQ0dlLzdwSnFXWVVwVDczVHNGc0Rw?=
 =?utf-8?B?ekVhN0RKK2FhOGFvZmpHWlFKMm1FZ0V5eDdWazJTLzAyYUdjWWx2R3VKQXRy?=
 =?utf-8?B?Yms4RS9qeDErQndSSzhqV0c3aFB6NklEK2ZSei9SanpwOEQzMy9yOTZzVzV3?=
 =?utf-8?B?TTJvRlo4QjJTbS9ab0R5K1JsVGEwbTdHWTkxMklYK1J5TTFpRVdIMGVzMXNP?=
 =?utf-8?B?TnZtMFdnRU1aK3k0blVNNUorZTcyMTB4ODNNYzdGL3k1RVJQUSszQXdhV29Z?=
 =?utf-8?B?U3hFY1BJS2pGbHpjVW83VFJWZlNySWNyQXZDRmRpaTNxclFXTElIR203VnlW?=
 =?utf-8?B?STNnUkl5MmhuWVNPSHBMNTZyWEZHUXE1M0ZDcHViUW1qNGNOT0p2VjNTMEhQ?=
 =?utf-8?B?Z1lhdXdnSng1MTNPVHhZMk1EczMwSGlXVW4xUzZnNnpUK3o0VnRDVi9uS0Ir?=
 =?utf-8?B?UVNxem96TFR6NEg2WjVMbWNZV0poajQ1QVdQUjFyVm82L1Yra1F0Tk1xUXRZ?=
 =?utf-8?B?Sm1vK1RrcHpmWkVqOW1qNHdBSW8rL293VVZkUFhrNFIxQi9WNjUrRDF4bldv?=
 =?utf-8?B?L0dZbzNWU3Y1aFJPbmV3WlE1Wm1LS09qbDVVQXlwM0I2S3UvZFBKVkxCdnpR?=
 =?utf-8?B?bW5tUHRvUVJ6UGFMWC9Lb0d5aExaSGFQUTBwQWVMSyt4UjVESjR6cEV3dGpy?=
 =?utf-8?B?MkNOMjIwNVBocCtGVnJGd29xV3VwUy80MEVuQi9RTzBXaGZyNFN0RWF4N2Yw?=
 =?utf-8?B?OEZrdlVsdWI5QWJZbXBBcytYZjBQQWZQeVZvY0c2ajI4elRNcExkVkNMSFFz?=
 =?utf-8?B?NXhKOXlkTlE1bUM2TkZGR2NoM1B5TEI1U3Vjd3dvUHh0SmNrUEpjdXhNV1pr?=
 =?utf-8?B?SU9ObVpBMUJHUlVldTBrUWFuano0UkVTK0xBdm5LbldabUdJcWJoWHpDTG0y?=
 =?utf-8?B?Y1MyanppTHI1RHhZZDJnU2lhdTFpcGRCdFVXUk1KTzdCV2RIWFJaLzRML2pB?=
 =?utf-8?B?YnFWMzh2a2xJWDhrTjZjbGtWS3gzWDJ4bHBPQmhxZXhuZ3N6eGNVWTNKK2Y0?=
 =?utf-8?B?VXZmK3NIQ2Z3MzVDTG9lenJmK2ZzaTNNaWY0RmpEVU0xSjB2ZEs4bFFvS2Qy?=
 =?utf-8?B?QS9VdzRpVGE0RVFVRGs0eG5DK2ltcDNFMWVZU0EydGJzUVdSeWtwNDAvM2o0?=
 =?utf-8?B?OENKNWFITDZuRDJJNEd0SUhxWk1obHBRVU1pRWhiTlFMMVRING04eUM0RGFT?=
 =?utf-8?B?dE9lWnlIV2ZvcnI0NnZRSmswcTFZR1ZxWnV5T2crMmhqQmhSUmdLd1hENGZv?=
 =?utf-8?B?d3daSDhpZjExaHdpVTVlT2lUenBpeEpWSGJrMHhTcHViZzRIK1ZWVllsV0Ra?=
 =?utf-8?B?NVR1MURWcmF6UDFpM0hJMDBJdjBxNTQ4bmFVK1FtSTRqM3JLZzNKSGZ5M1lS?=
 =?utf-8?B?bkRkN3BmSVk5WFRxMzNGeFFpaWd3OWRld2JiQktnbUgrd21KeFpkSFhnMUJE?=
 =?utf-8?B?SFNCQUVLM1lIcllXTFZnbFBsaXdKNWxza3lMRmp2Qko0Vm96ZmgvRGFyZ1JF?=
 =?utf-8?B?NkxyWkxqK09FQm5ieVhwZEV6cXZkM0ZaTlgzdGVLVXZZdFlmT1J0OXZJYkx5?=
 =?utf-8?B?SjdYVnpWUzRJUU9GditvRFlFMW50Q2hBZ2IwZzQ4dlAwdUlSeHk4QzduaFpT?=
 =?utf-8?Q?2bao8H1GaSZClZi0DBqhIgS0k?=
Content-ID: <AEBFB938AB808643A200F90F62710463@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4754a0e3-ce83-43f1-0829-08da95405368
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 04:27:53.5963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MPnVt4DjMBz5za2xR8kgD/34igJHE3sf1yApPDRgqPOI6bD6y3FGnKiJ6Lnl7i+ETupeAYVyw/mrYGD9G0xFKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10033
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220912_212804_600925_3783D6EF 
X-CRM114-Status: GOOD (  10.13  )
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

T24gMjAyMi8wOS8xMyAxMToxMSwgWGlhbnRpbmcgVGlhbiB3cm90ZToNCj4gDQo+IOWcqCAyMDIy
LzkvOSDkuIvljYg1OjIxLCBsaWppYW5nIOWGmemBkzoNCj4+IEJ1dCBhbnl3YXksIHRoZXNlIGlz
c3VlcyBjYW4gYmUgaW1wcm92ZWQgd2l0aCBsYXRlciBwYXRjaGVzLCBzbyBmb3IgdGhlIHYzOiBB
Q0suDQo+IA0KPiBUaGFua3MgTGkgSmlhbmcgZm9yIHRoZSBjb21tZW50cyBhbmQgQUNLLA0KPiAN
Cj4gTm93IEkgcmVjZWl2ZWQgdHdvIEFDS3MgZm9yIHlvdSBhbmQgS2F6dSwgQ291bGQgSSBrbm93
IHdoZW4gdGhpcyBwYXRjaCBzZXQgY2FuIGJlIG1lcmdlZCB0byB0aGUgbWFpbmxpbmU/DQoNClVz
dWFsbHkgYSBjcmFzaCBwYXRjaCBpcyBtZXJnZWQgd2hlbiBhIHJlcXVpcmVkIG9yIHRhcmdldGVk
IGtlcm5lbCBwYXRjaA0KaXMgbWVyZ2VkIG1haW5saW5lLiAgSWYgdGhlIGtlcm5lbCBwYXRjaCBm
b3Igdm1jb3JlaW5mbyBpcyBtZXJnZWQgaW4gNi4xDQptZXJnZSB3aW5kb3csIHRoZSBwYXRjaCBz
ZXQgd2lsbCBhbHNvIGJlIG1lcmdlZCB0aGF0IHRpbWUuDQoNClRoYW5rcywNCkthenUKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBs
aXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

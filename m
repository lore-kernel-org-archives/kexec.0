Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95AAC433EF
	for <kexec@archiver.kernel.org>; Tue, 26 Jul 2022 06:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hdoUI0b3SjWoekWxrXBF/pZxuHBfctvBp4k9hJoPs8M=; b=prygmDnJgeLEzJ
	nyqy1MqSKKP/dgiQa0G5iSEcmk/9BHU013n+aUnsyhYzkw/ThvEc/ht3YCaigEQJFFoHTKyOwA29Y
	PF4GAAdZMZl+QciG1Y0c/4cYStvqIYs7jl9J+gtTwiBdREG0w/sa13tRZaOqkgq9EnVo7z9UAR1TJ
	bmiTbB9Z75i/YQtYD8jcHkparOrs8ZqDDXcALQ5Ew39/uKwvLKLdwm0TtEwUjVsAz59GHUIBL+Qbh
	MsECfE3IE0eNz89vjydCTD5cknOCDIfD80qQFyAU1tOs3NRFAhLVA72cPwgoEVkJJygO5gTzfqH6C
	HR8a7Kp+igt4xb/vg2iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGE7o-008tRw-CS; Tue, 26 Jul 2022 06:33:00 +0000
Received: from mail-os0jpn01on2087.outbound.protection.outlook.com ([40.107.113.87] helo=JPN01-OS0-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGE7k-008tMp-2o
	for kexec@lists.infradead.org; Tue, 26 Jul 2022 06:32:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Htl4YoATx9Ey7AE8HoeTLg88oDrCsuq+sJd/rvwTUNS5ltOoX7gjFs4CrwrGUSdE9rxV539/bfQfAqEFPgj0YarXuE1YuFVnw55je8hgK/qeotKilJ1H09pH8H44IynKj80U7HTlPRA9Z0yFT3zlj2GydH8peI29pkppZ3ktoxBbRBkbqO2YK+Pb/YmkK2fCM7mRbDBtSmcdVbyqBZFsTvf5NeVjpw1O7xrXkpJUngWQ/29zIqdO80orcFovj4mm95TMLnkO1YHUv4TpjP128c65Yx8hkoT5c1ytx2MUDzwkQ3AjhTey0+n+7WT+/0VM/r02OZyKO9PD695EomS9jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8HN1yXFeCAlX6zrssM7Hc7F9zF9Ws7Kar0VzuofXMQ=;
 b=BGkzBU9KMiJnUsWrlm0J+ToYBWjLNlR17AXdlWAAGAingguA6wcgBHMV1lujn3CvUJVxHpiIEh/P9KO/aXQfJx5JqFbqtfyPhBJ3gqWoWJAd4cbUM0MJfgqahN3QbM6vemYU4ituo7WkU6XkdkEspYFUGkPNWpsJmAmGTY9ZWzpIYDlsPPoxgkaHRQciYzEGjNPlRMB556nFVWyrS+tQpTW0nzse2g06KUfJ4IC00SPCqyfGYneYnD/yyqsNiBeHPQEy6SSTATH98qIyQwnPX6S1c9uNjM7vdGNnQvDnWfZNbu6QbqE3d2Ttn3Utum+PyUKs3CDL+WdDscgsd7lcXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8HN1yXFeCAlX6zrssM7Hc7F9zF9Ws7Kar0VzuofXMQ=;
 b=OqJnuW2lKbcX79mGVEx3TOnZs4x71S1lUhq0RSVKK8srz58Wum+NVk3gtstK0U9+wAZMTK1G6Yb48L7lmccLvEQ4cgS42mTvfj8xFrEo8SSMhR7QGt9Hey9f+1GXSAmtkM1eWf0KSmiKqJxu4oCxWyXrNBcrevgDr1DH9biT95k=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by TYYPR01MB6958.jpnprd01.prod.outlook.com (2603:1096:400:d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Tue, 26 Jul
 2022 06:32:38 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::b19c:bf5b:1ed:950e]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::b19c:bf5b:1ed:950e%5]) with mapi id 15.20.5458.024; Tue, 26 Jul 2022
 06:32:38 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: "Discussion list for crash utility usage, maintenance and development"
	<crash-utility@redhat.com>, Agrain Patrick
	<patrick.agrain@al-enterprise.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
Subject: Re: [Crash-utility] EXT: RE: crash: read error on type: "memory
 section root table"
Thread-Topic: [Crash-utility] EXT: RE: crash: read error on type: "memory
 section root table"
Thread-Index:  AdhDaGmX69pSK7AuRLCDk2uKH/N3HQAaQELgAHxPn/AA7xQMUAATrKyAFP1hpQAAvZMlgA==
Date: Tue, 26 Jul 2022 06:32:38 +0000
Message-ID: <713a12cc-9f62-c068-5743-49aa6a20068c@nec.com>
References:  <DB7PR08MB327305868D5DF87C2E31B972CA1E9@DB7PR08MB3273.eurprd08.prod.outlook.com>
 <TYYPR01MB67776D129929014239C34414DD1F9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
 <DB7PR08MB32733EC5606D43D47FDEDCC1CAE09@DB7PR08MB3273.eurprd08.prod.outlook.com>
 <TYYPR01MB6777C0B689B45FE92EB4712FDDE79@TYYPR01MB6777.jpnprd01.prod.outlook.com>
 <DB7PR08MB3273BAF582AD775E43E90B8ECAE79@DB7PR08MB3273.eurprd08.prod.outlook.com>
 <DB7PR08MB327340019202DE669D03D18CCA909@DB7PR08MB3273.eurprd08.prod.outlook.com>
In-Reply-To:  <DB7PR08MB327340019202DE669D03D18CCA909@DB7PR08MB3273.eurprd08.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf9c0a3d-fae5-4ea4-f95f-08da6ed0a253
x-ms-traffictypediagnostic: TYYPR01MB6958:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  TpU13EQ+wGlUVNHi9MS6kICIF3wzrrG7na2fkM6T6eOEnnYDEtF1yKLENVMM/uu8LCADkhgl0xhc+YDcAsPFFuIqbzf3y2bVBRrEfQClfz4T+fbfJVgHPYe+cUcIAJtLOkTRcqk48JNX0GZtRFipJMzLSsRdY6ytroHWeCtZKkkidG2B8teuCAhN5jRiqDbyxz66L2Yf+awr69+xHAlZjsav/W1mDpWHSe+wRs6hI+bZEO5gtFIedNAqqqG0JkkLdn33DFQciMjkSydyZa0pxRw5fNweTGmXK+tjoJNbQRw1/WMCrBG1H9W3AwSdVqz4yFgI369EbaTvAGNw6Qs8QsTEzzebiCUGO30hkFQi2FPlgcA9e6dJmKDJ9PcGr8cwITLyeI0+VJNuH9SWQt7vJckjnnqE21UIZmQ8x09tP+Z7a1yrH6ewhJC7kRU0xNXiTWKX+nJg08QyaO1NGNVyOCHYd5Qwhunm1anP41n4UQgqPmSdFMWgKj23Qf3K9YKzKM7akbQY2lpK7d4eRsOLOX5s86MUtpQzSAS0O5hG0KiFNZRdXIMVWghlH8BzG933wLEFEdKLPdMQlCO2ef0e2ZhUJ1lwqRMpy5aXqsJQJjb3arm+FFpELWR0oJTMFTlF9wCMLSkUZRRzpQjWPAG79H/209+yuMDgBKKWWFLSkhFnsjwLD7gxv+Dx0yQLJsZOJZEm7Iv6Ay1pMGIKc9Xxs202+T22v5LQHP+o0bzEynMKtc+pe6eRO0gv2Qm7hOjBUFI2FIWifzYQIkRUe6aofo4BcRidFoQOyW68VgwcWPQWQY6c0+w3/020kCxvwVqR43Hc7sLOJct6fHHN1BmZsL4SvvyF7r3hVEzWqqZLJv8KphfRwhhcMu7NWPa5osX8+ZVkObgSAlzm3/wi3M6FKA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(8676002)(38070700005)(64756008)(66476007)(82960400001)(66446008)(38100700002)(66946007)(66556008)(966005)(6486002)(478600001)(316002)(86362001)(31696002)(53546011)(55236004)(8936002)(5660300002)(76116006)(110136005)(83380400001)(6506007)(186003)(6512007)(26005)(2616005)(41300700001)(122000001)(85182001)(2906002)(71200400001)(31686004)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?Z3IvbUNOanoweUljTksyQlZmbnBtRzMyQ28zN3NMNkFpa1NTeXo5MmN4aXpO?=
 =?utf-8?B?cUo3RkJyWWlabjdRNUJscVF0dFFpdDN4TVZ5dkVvc3MwRFl1MnhnRXlCZ1lq?=
 =?utf-8?B?QXQwcjloSmF0QXM1dTNQTS9JY3llN1MzcnEzb1BXd200QjhvMU05dk9QWmdI?=
 =?utf-8?B?ck16QXppR3hibWJiOVlyaUI0U3NxSDNpY2FlS2c4V0o3OHJtMTlUNWFXR0ox?=
 =?utf-8?B?dkdVT1Zaak9pMHhtRm9SelFxOUoxRm9adkIwV1BmSWY5WkJWeWtUbnJCTUNI?=
 =?utf-8?B?K3JIb01ZcFkvZXoxaXgzQTN2WDMzSkdKVmdrS2lXbWQxYkQyaWxlMDRMRzhO?=
 =?utf-8?B?MnJIeG55MjZhdlBvUm9jZW94WUVhTU9EUXZxb25wYTA3L0hVdzdNVnlsTDQ2?=
 =?utf-8?B?S0VFcFl1bm01OXpLQ3A5RUs3Sk9nK1pQeSs5OGFwYVhidE02dzFjWG1kQ2lH?=
 =?utf-8?B?ZlVTODRHNXpYaFdmdUFFSmtGcmZuNW1OOXNqTUZIdWNwbDV4QjhuWTEyc3Qr?=
 =?utf-8?B?Nzc2K0Q2WG9yQmFBR3pmQ0hXd3pDK0RsQlBSeTZ2eitRSGRpUE1MWkExZU0x?=
 =?utf-8?B?T3VUZFdZSC9rc3NhMFArOHNGb1d2STREVjVKeGFhOG1Fck5ibERRdm5oWDdy?=
 =?utf-8?B?ZkVnQlludXFsdG1tOC8wWFJ1ZVRCNUZHUGhyc0QrV2lZOUM2Q0hTZDlCYTlT?=
 =?utf-8?B?VXArK293b2ZaVnZaSzZMS2tqK0NkNEYzNnhUZ0lTaTRNdDIvU3lENGsxRnFH?=
 =?utf-8?B?c29QVHg5dTNoanVISE11ekliOU9HMGpMNmJSYklTNlBsQ3RiUElQMXhvd01G?=
 =?utf-8?B?YjZNYlNTN0x1eWYwdDhRU3h1NjhXek1kZlczM0FBNkhidURkUzlWYnluQURX?=
 =?utf-8?B?WDdPR2hsN3BqdmNadTk2d0VkUHFPd1M2dnkyQUJ4V0NSS2hIdDVvOWdoTFZJ?=
 =?utf-8?B?aG5lVVFaMzVhVFFaNFpkc0hqS3IwS0VnYVE3YlpXYzVTZ3NYdzA4UzhUME5o?=
 =?utf-8?B?a1E2OVc1clgyTDF3SzhobVA5b29FKzV5YTh3Z0k4aVpVL1Zva3pZZmFZQTg4?=
 =?utf-8?B?M1JkNitaeTBaTnlidXFLTEtJMG41dGxhakNRTGFGQm5rTzRySjVuNG5IU2o4?=
 =?utf-8?B?YzUreWlTOEtHMzBvSFFNU0kxS0NVNnNoRG0ydzd2ZDF1TE5KSm1tTUViaEM4?=
 =?utf-8?B?b1NCcCtJWnhTbDMwYzg0a3pOTjZtQlJrbTE0aFQ2eGxtR1N0TVU4VWc0ZFNL?=
 =?utf-8?B?ZWxsVjRDNit2WFZzcTk3Wjlvak1CTUZ2ZWw3UEJTOFd0eEFiV3RmUU0wY3dV?=
 =?utf-8?B?dm5PYmFnaStqanR1RnpzYktsc1A4cjFNZzliVWdEc1RXcUpOUlo3aS9PM3Zq?=
 =?utf-8?B?TnhvMUNTMy8xQUJ6YWgyWEFzSEJNYThkdm81RGhjK2R3MnhDc2lIc2k5TXFY?=
 =?utf-8?B?eU1UM3AzL3V4WmNWMnh5c2xUcHJYdXVMczZwVnVMcTI5KzZrQkgwK29iaTY1?=
 =?utf-8?B?VWJsNzU2NXZYNHdvK29LUjNyS2hmVTBBZE9CeUcxUFFkaWdnY3N6UnF0eVVs?=
 =?utf-8?B?U1l6VEdVU3Y1clQvMFplNXNLVlQ3K0VsVmwwT2tWUXVxWUxPYitzUGpLVWhl?=
 =?utf-8?B?MFdCMDU0aHF2bGttajBZckJ6NGp2RWlIU1UyRkM1UHJvYThWUTc2bjRrQVBO?=
 =?utf-8?B?UWxnNzFiVnRaU1RFVjNSbjBlYTQ1elBXN0dGS2NRVDcwWU1ZRnlTbGpjYldM?=
 =?utf-8?B?UjMwVmlPUGhpdFVTaU1VbmR1bUM5NWRNcUpkT2FRWU5qck1pcW9hendWYjd3?=
 =?utf-8?B?ejB6MjA4bHljdThaQXU3TW5Xa1FZWVZjK3MvcEg4Mm5Fckp4eXRwUGZleFhI?=
 =?utf-8?B?ZFdVbTdrdTNjenc3RVYyMGVrbEwxSHBCWk40ODZ2Sm5nU0RsZ01sNkN2RG5v?=
 =?utf-8?B?THNvdllWK2xzMXJ4K2pySllXa09kYnJuejB4Y20xckNMVlZBcnJaYUpFOVV1?=
 =?utf-8?B?ZVkvUUl3K09JNldZeWp6V0hkeFkzT2pRaFJZNFkrVm9ZZTRDK2RrbEp1ditn?=
 =?utf-8?B?NXRHNTB0emZ3OEx5eUVOK2VlR0ZGZ0FKQUJVUEtkVFF1d3BVa0JPaDUvWlpO?=
 =?utf-8?Q?k0vrZT7ype5mSvGuXXPtaA6/V?=
Content-ID: <3650E4B1270A854C8E74303A05DBD466@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9c0a3d-fae5-4ea4-f95f-08da6ed0a253
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 06:32:38.1543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /cxc6kFEvdkDdSVGSAB9CjPij7n+5ezZT+3OLOge07gvSSF3i6Me2N7kcyt7cmI4AId9SlVCyQvjSHybtywJvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6958
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220725_233256_648758_43A0C737 
X-CRM114-Status: GOOD (  21.10  )
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

T24gMjAyMi8wNy8yMiAyMTowNCwgQWdyYWluIFBhdHJpY2sgd3JvdGU6DQo+IEhlbGxvLA0KPiAN
Cj4gQmFjayB0byB0aGlzIHRvcGljLg0KPiANCj4gSSB1cGdyYWRlZCBvdXIgc3lzdGVtIHdpdGgg
dGhlIGtleGVjLXRvb2xzIGZyb20gQ2VudG9zIDggU3RyZWFtLCBiYXNlZCBvbiBrZXhlYyAyLjAu
MjQgYW5kIG1ha2VkdW1wZmlsZSAxLjcuMS4NCj4gV2UgYXJlIHN0aWxsIGZhY2luZyBlcnJvcnMg
d2hlbiB1c2luZyAnbWFrZWR1bXBmaWxlIC1jJy4NCj4gDQo+IFJlbW92aW5nIHRoZSAnLWMnIGdp
dmVzIGJldHRlciByYXRpbyBzdWNjZXNzL2ZhaWx1cmUsIGJ1dCBzb21ldGltZXMgdGhlIGNyYXNo
IGZpbGUgY2Fubm90IGJlIHJlYWQgYnkgdGhlIGNyYXNoIHRvb2wuDQo+IA0KPiBSZWZlcnJpbmcg
dG8gSGFnaW8ncyByZW1hcmsgYmVsb3cgY29uY2VybmluZyB0aGUgc3luYywgSSBhZGRlZCBhIHN5
bmMgb3BlcmF0aW9uIGJlZm9yZSB0aGUgY2FsbCBvZiBtYWtlZHVtcGZpbGUgKGFuZCBqdXN0IGFm
dGVyIHRoZSBtb3VudCBleHQ0IG9mIHRoZSByZXF1aXJlZCBwYXJ0aXRpb25zKSBhbmQgYWRkIGEg
c2Vjb25kIGNhbGwgdG8gc3luYyBhZnRlciB0aGUgcmV0dXJuIG9mIG1ha2VkdW1wZmlsZS4NCj4g
SW4gdGhhdCBjb25maWd1cmF0aW9uLCB0aGUgY3Jhc2ggZmlsZSBjYW4gYmUgcmVhZCBieSB0aGUg
Y3Jhc2ggdG9vbCAodXAgdG8gbm93IGluIGFsbCBjYXNlcykuDQoNCkdvb2QsIHNlZW1zIHRoZSBz
ZWNvbmQgc3luYyB3b3Jrcy4gIEkgd291bGQgc3VnZ2VzdCB1bm1vdW50aW5nIHRoZSBmaWxlc3lz
dGVtDQpjbGVhbmx5LCB3aGljaCBjb250YWlucyBzeW5jaW5nIHRvIGRpc2ssIGJlZm9yZSByZWJv
b3QsIGlmIHlvdSBkb24ndCBkbyB0aGF0Lg0KDQpUaGFua3MsDQpLYXp1DQoNCj4gDQo+IFRoYW5r
cyBmb3IgeW91ciBoZWxwLg0KPiBCZXN0IHJlZ2FyZHMsDQo+IFBhdHJpY2sgQWdyYWluDQo+IA0K
PiAtLS0tLU1lc3NhZ2UgZCdvcmlnaW5lLS0tLS0NCj4gRGXCoDogQ3Jhc2gtdXRpbGl0eSA8Y3Jh
c2gtdXRpbGl0eS1ib3VuY2VzQHJlZGhhdC5jb20+IERlIGxhIHBhcnQgZGUgQWdyYWluIFBhdHJp
Y2sNCj4gRW52b3nDqcKgOiBtZXJjcmVkaSA2IGF2cmlsIDIwMjIgMTc6NDgNCj4gw4DCoDogRGlz
Y3Vzc2lvbiBsaXN0IGZvciBjcmFzaCB1dGlsaXR5IHVzYWdlLCBtYWludGVuYW5jZSBhbmQgZGV2
ZWxvcG1lbnQgPGNyYXNoLXV0aWxpdHlAcmVkaGF0LmNvbT47IGtleGVjQGxpc3RzLmluZnJhZGVh
ZC5vcmcNCj4gT2JqZXTCoDogUmU6IFtDcmFzaC11dGlsaXR5XSBFWFQ6IFJFOiBjcmFzaDogcmVh
ZCBlcnJvciBvbiB0eXBlOiAibWVtb3J5IHNlY3Rpb24gcm9vdCB0YWJsZSINCj4gDQo+IA0KPiAN
Cj4gLS0tLS1NZXNzYWdlIGQnb3JpZ2luZS0tLS0tDQo+IERlwqA6IEhBR0lPIEtBWlVISVRPKOiQ
qeWwvuOAgOS4gOS7gSkgPGstaGFnaW8tYWJAbmVjLmNvbT4gRW52b3nDqcKgOiBtZXJjcmVkaSA2
IGF2cmlsIDIwMjIgMDk6NDggw4DCoDogQWdyYWluIFBhdHJpY2sgPHBhdHJpY2suYWdyYWluQGFs
LWVudGVycHJpc2UuY29tPg0KPiBDY8KgOiBEaXNjdXNzaW9uIGxpc3QgZm9yIGNyYXNoIHV0aWxp
dHkgdXNhZ2UsIG1haW50ZW5hbmNlIGFuZCBkZXZlbG9wbWVudCA8Y3Jhc2gtdXRpbGl0eUByZWRo
YXQuY29tPjsga2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZyBPYmpldMKgOiBSRTogRVhUOiBSRTog
Y3Jhc2g6IHJlYWQgZXJyb3Igb24gdHlwZTogIm1lbW9yeSBzZWN0aW9uIHJvb3QgdGFibGUiDQo+
IA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4gSGVsbG8sDQo+Pg0KPj4gU3VnZ2Vz
dGVkIHRyYWNlIGFib3ZlIGdpdmVzIGZvbGxvd2luZyBpbmZvcm1hdGlvbiBhZnRlciBhIGNyYXNo
IC1kIDggY29tbWFuZDoNCj4+IDwuLi4+DQo+PiBrZXJuZWwgTlJfQ1BVUzogMg0KPj4gPHJlYWRt
ZW06IGZmZmZmZmZmYTQ5MjU4MjAsIEtWQUREUiwgImhpZ2hfbWVtb3J5IiwgOCwgKEZPRSksDQo+
PiA1NjAxN2I1NDI2NDg+DQo+PiA8cmVhZF9kaXNrZHVtcDogYWRkcjogZmZmZmZmZmZhNDkyNTgy
MCBwYWRkcjogMTI5MjU4MjAgY250OiA4Pg0KPj4gcmVhZF9kaXNrZHVtcDogcGFkZHIvcGZuOiAx
MjkyNTgyMC8xMjkyNSAtPiBjYWNoZSBwaHlzaWNhbCBwYWdlOg0KPj4gMTI5MjUwMDANCj4+IEdF
VEJVRigzMjggLT4gMCkNCj4+IEZSRUVCVUYoMCkNCj4+IEdFVEJVRigzMjggLT4gMCkNCj4+IEZS
RUVCVUYoMCkNCj4+IFBBR0VTSVpFPTQwOTYNCj4+IG1lbV9zZWN0aW9uX3NpemUgPSAxNjM4NA0K
Pj4gTlJfU0VDVElPTl9ST09UUyA9IDIwNDgNCj4+IE5SX01FTV9TRUNUSU9OUyA9IDUyNDI4OA0K
Pj4gU0VDVElPTlNfUEVSX1JPT1QgPSAyNTYNCj4+IFNFQ1RJT05fUk9PVF9NQVNLID0gMHhmZg0K
Pj4gUEFHRVNfUEVSX1NFQ1RJT04gPSAzMjc2OA0KPj4gPHJlYWRtZW06IGZmZmZmZmZmYTQ5MjZk
YjAsIEtWQUREUiwgIm1lbV9zZWN0aW9uIiwgOCwgKEZPRSksDQo+PiA3ZmZkMWI2YmIwMDA+DQo+
PiA8cmVhZF9kaXNrZHVtcDogYWRkcjogZmZmZmZmZmZhNDkyNmRiMCBwYWRkcjogMTI5MjZkYjAg
Y250OiA4Pg0KPj4gcmVhZF9kaXNrZHVtcDogcGFkZHIvcGZuOiAxMjkyNmRiMC8xMjkyNiAtPiBj
YWNoZSBwaHlzaWNhbCBwYWdlOg0KPj4gMTI5MjYwMDANCj4+IDxyZWFkbWVtOiBmZmZmOTA0Yzdm
N2ZjMDAwLCBLVkFERFIsICJtZW1vcnkgc2VjdGlvbiByb290IHRhYmxlIiwNCj4+IDE2Mzg0LCAo
Rk9FKSwgNTYwMTdkYTI2ZmQwPg0KPj4gPHJlYWRfZGlza2R1bXA6IGFkZHI6IGZmZmY5MDRjN2Y3
ZmMwMDAgcGFkZHI6IDNmN2ZjMDAwIGNudDogNDA5Nj4NCj4+IHJlYWRfZGlza2R1bXA6IHBhZGRy
L3BmbjogM2Y3ZmMwMDAvM2Y3ZmMgLT4gY2FjaGUgcGh5c2ljYWwgcGFnZToNCj4+IDNmN2ZjMDAw
DQo+PiBjcmFzaDogUEFHMyAtIGVycm5vPTIgcj0wIHBkLnNpemU9NDkNCj4+IHJlYWRfZGlza2R1
bXA6IFJFQURfRVJST1I6IGNhbm5vdCBjYWNoZSBwYWdlOiAzZjdmYzAwMA0KPj4gY3Jhc2g6IHJl
YWQgZXJyb3I6IGtlcm5lbCB2aXJ0dWFsIGFkZHJlc3M6IGZmZmY5MDRjN2Y3ZmMwMDAgIHR5cGU6
ICJtZW1vcnkgc2VjdGlvbiByb290IHRhYmxlIg0KPiANCj4gaG1tLCByPTAgbWVhbnMgZW5kIG9m
IGZpbGUsIGNhbiB5b3UgY2hlY2sgYWdhaW4gd2hldGhlciBwZC5vZmZzZXQgZXhjZWVkcyB0aGUg
ZHVtcGZpbGUgc2l6ZT8gIElmIHNvLCBzb21laG93IHRoZSBkdW1wZmlsZSBpcyBzaG9ydGVyIHRo
YW4gZXhwZWN0ZWQuDQo+IA0KPiBJbmRlZWQsIHRoZSBvZmZzZXQgcG9pbnRzIG91dHNpZGUgdGhl
IGR1bXBmaWxlOg0KPiBHZXQ6DQo+IGNyYXNoOiBQQUczIC0gZXJybm89MiByPTAgcGQuc2l6ZT01
MiBwZC5vZmZzZXQ9MTY4OTU2NDg1IHdpdGggYSBkdW1wZmlsZQ0KPiAxNjQ4MjAgLXJ3LXItLXIt
LS4gIDEgcm9vdCByb290ICAxNjg3NzU2ODAgIDYgYXZyaWwgMTc6MjMgY3Jhc2hkdW1wLS0yMDIy
MDQwNi0xNzEzDQo+IA0KPiBBbmQgYW5vdGhlciBvbmU6DQo+IEdldDoNCj4gY3Jhc2g6IFBBRzMg
LSBlcnJubz0yIHI9MCBwZC5zaXplPTQ5IHBkLm9mZnNldD0yMTU2NDA2NDkgd2l0aCBhIGR1bXBm
aWxlDQo+IDIwOTk4NCAtcnctci0tci0tLiAgMSByb290IHJvb3QgIDIxNTAyMzYxNiAgMSBhdnJp
bCAxMDo1OCBjcmFzaGR1bXAtNTg1LjAwMC0yMDIyMDQwMS0xMDU0DQo+IA0KPiBJIHRoaW5rIGEg
UkhFTC1iYXNlZCBrZXhlYy10b29scyBkb2VzICJzeW5jIiBhZnRlciBtYWtlZHVtcGZpbGUsIGJ1
dCBjYW4geW91IGNoZWNrPw0KPiANCj4gQWN0dWFsbHksIHdlIGFyZSBleGVjdXRpbmcgdGhlIG1h
a2VkdW1wZmlsZSBpbiBhIHNjcmlwdCBkZXNpZ25hdGVkIGFzIGluaXQgZmlsZSBmb3IgdGhlIHNl
Y29uZCBrZXJuZWwuIFRoZXJlZm9yZSwgd2UgZG8gbm90IHBlcmZvcm0gdGhlIHN5bmMgYXMgcGVy
IGNvcmVfY29sbGVjdG9yLg0KPiANCj4gVGhhbmtzLA0KPiBLYXp1DQo+IA0KPiBCZXN0IHJlZ2Fy
ZHMsDQo+IFBhdHJpY2sNCj4gDQo+IC0tDQo+IENyYXNoLXV0aWxpdHkgbWFpbGluZyBsaXN0DQo+
IENyYXNoLXV0aWxpdHlAcmVkaGF0LmNvbQ0KPiBodHRwczovL2xpc3RtYW4ucmVkaGF0LmNvbS9t
YWlsbWFuL2xpc3RpbmZvL2NyYXNoLXV0aWxpdHkNCj4gQ29udHJpYnV0aW9uIEd1aWRlbGluZXM6
IGh0dHBzOi8vZ2l0aHViLmNvbS9jcmFzaC11dGlsaXR5L2NyYXNoL3dpa2kNCj4gLS0NCj4gQ3Jh
c2gtdXRpbGl0eSBtYWlsaW5nIGxpc3QNCj4gQ3Jhc2gtdXRpbGl0eUByZWRoYXQuY29tDQo+IGh0
dHBzOi8vbGlzdG1hbi5yZWRoYXQuY29tL21haWxtYW4vbGlzdGluZm8vY3Jhc2gtdXRpbGl0eQ0K
PiBDb250cmlidXRpb24gR3VpZGVsaW5lczogaHR0cHM6Ly9naXRodWIuY29tL2NyYXNoLXV0aWxp
dHkvY3Jhc2gvd2lraQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

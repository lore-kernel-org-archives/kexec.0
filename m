Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2670C61DB9
	for <kexec@archiver.kernel.org>; Fri, 28 Aug 2026 02:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MS5Gj3ZQpeZ5StIJxbOVLevWiUvcH/5+BLHvqCQZcPU=; b=RluoeHnrzFJRslgYO8W4QUw+oV
	C1HA7mGga0ZDLmBBAZAYkDnuCTqqWnwrMkF/2YVTNcv8XpCjlPKpOOE5fB/GEOdaIJFNskDqQiDNg
	jlOmjM2uosMDysWd6XCvbI/HZba0fNqyXCjppGVnaCfd473+TEM1oqJa2cu9soXwQMNX6f4uewg3i
	qDsezeYsdcTFJoXSCYxt2nt1xtzJN0cBddv3LwxRY+rArQ0g5PHUkaq1pVjDUYXXTlzQd35We8nda
	vQ9Vi3kn1KLjrkWobHj0bkrovzU6+ReY1jMMj9MJciqIA3IuIMkRfhmfX1TtmkytnAZ7H+GzQmPXp
	3jIoyTbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzmm5-000000052ht-3nQp;
	Fri, 28 Aug 2026 02:57:01 +0000
Received: from mail-japanwestazlp170100003.outbound.protection.outlook.com ([2a01:111:f403:c407::3] helo=OS0P286CU011.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzmm1-000000052hU-2tE9
	for kexec@lists.infradead.org;
	Fri, 28 Aug 2026 02:57:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gt2zJu7GbMKzGEHsPJB2GEKc4CDsDVCfs3r3KoDjdYAaFyB5bNW2Dy1zX+vEcHvCnogodBt6SpGP/0APNBeR9mxqmrpgm1ELt6Rr7UheYEw/8lWMj3cGk8XnX/pO27Jmlsk75RZNP62b4zQeO/oo84kpvPNZ5H2pw0MFbYXz3Jlc/sPIMUC93EEmCP0VHvUHbWdas8ZobuN2BycTyjArEjX4ByBqnyIPkH1R3jJUmLYgkaMT/nv9uDHOYh2Xc4KopCz+jGoFR5TMhb8uQDUVDXtOh/azbmHMnErE8sMMu7EVgXgsV0u+lxRNveMCRUT9a8wem1jWUnRNsEBKCXw+CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MS5Gj3ZQpeZ5StIJxbOVLevWiUvcH/5+BLHvqCQZcPU=;
 b=OStYgVAlc1X9TkFbtVL8Z1G1TmblqId91EBTVEcX6gvGtG9pxZuZLtQrugCKzOTrDbqophq/5q46XEf+OkIS5LPnJs0/V7sbfdntVlaV4GQ+KQ9GtnlCH4BLtBOWu25Ujr6lL6uKRsfZ2jHXV0of+2zJUGnF+CaVb95C29EsbKSw9NHKp0mesbDmen3JHW1crpql3sdrMXQS6OG09Qw8lGnhVhDZYx6k/ufAcuoHBohx3b7lovNgxYbHeI2plIJNYAavFo33b3DZGavSY8YJGeJ2xHfamw1K/T9ZScGVCQnbZK9CWF1jQIPAqKL3bMbPk6tTtXYjl9kML78eDVc1ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MS5Gj3ZQpeZ5StIJxbOVLevWiUvcH/5+BLHvqCQZcPU=;
 b=eXbS5JGNYNl2YjMRkPKOM3E5IXLF7NKyzCvYyI05slul44JBTbsHPCN8equ5iPKjqsGx4h3H6H1E9bPTUWkpkSsnLr3mIEJBMoV1GoQhZisjAr+O1JZkftVE+9kkfPE/8MluHNHtshUDPBPByOAV6wxV75qnArNNIuj3lR+z8c3/n8kjxbeDEShjE6JPlNR8J+Rk8EbyzAAxV3ICr4CL9NgZeeo8X1r1MLAFl29PwKWUzVdCWNL0+f/E1c5/V2z/CpUvEsHWHhim2FGhG/A0esUll+2a4nEsdHyq8sdRCqdatiuqCdvqLqex85FGhVqkQhk1yPUU1Mmn45vkuUK8NA==
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 (2603:1096:405:1d7::13) by TYRPR01MB14274.jpnprd01.prod.outlook.com
 (2603:1096:405:21c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 02:56:39 +0000
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820]) by TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 02:56:38 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Stephen Brennan <stephen.s.brennan@oracle.com>, Tao Liu <ltao@redhat.com>
CC: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
Subject: Re: [PATCH makedumpfile 0/9] Improvements to makedumpfile extensions,
 plus userspace stack tracing extension
Thread-Topic: [PATCH makedumpfile 0/9] Improvements to makedumpfile
 extensions, plus userspace stack tracing extension
Thread-Index: AQHdEyorXwwQdBKvLk6+FbOcta264LaR+EQAgABmUoCAAOFbAIAAeusAgATPMoCAAURYAIAJEe4AgBArBoA=
Date: Fri, 28 Aug 2026 02:56:38 +0000
Message-ID: <04bbc82d-c9df-4b84-bac8-e7fd77a87206@nec.com>
References: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
 <7af7b171-88c0-4eb6-a18e-8e64fb4a71c0@nec.com>
 <CAO7dBbX---qP-Bqjza=z2HM4Nxn5+KtB-51WF4mvv++p666JYQ@mail.gmail.com>
 <87tsp539pr.fsf@oracle.com> <38980e2a-d303-42c0-81bd-ae25b52b94a8@nec.com>
 <CAO7dBbUcv5_OW8CJfzGB56U=PO3kbGkX7gz9-E4JEFFU+eVCMA@mail.gmail.com>
 <404ed232-6c8e-4112-b13c-6338156476d3@nec.com> <878q64cy7f.fsf@oracle.com>
In-Reply-To: <878q64cy7f.fsf@oracle.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB13462:EE_|TYRPR01MB14274:EE_
x-ms-office365-filtering-correlation-id: edf8a4aa-87e5-4ddd-0a2a-08df04affb22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|10067099003|22082099003|6133799003|18002099003|5023799004|4143699003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: AEB9BxP+PG0moiFQEavS8uikJ92r+AW7iJ+AcJ+jy9jJFcKJBBSfxydQ5hKGIvyP5FawGGpDDq8etA9TwMn1kpfRSnVYqbiifD4YcgldJf4geP3q0SmHup5JSz1qgYA3Fsxb6m4/kbFQtOVsTUyCfwXAehNFSAJGdWht1TxK0h8tZHoD2XrdBhMCJx39XcP2LvG9tpsZLJFi7ZDCbhPZbCWypqTllHV32s60kesh0KicMVr0lEKcFh70Jm07dsmHMjsyt+uCWgvOjf8V2XeQY0AYrCL1N9j+x4QMDQrr+zCvNx06ZG4G5JbmCyz/fx7BZqCKy9XTAoSInEhPg5Iu9NpzMASF2N5uiscVgvBole4mDJQXFzQGt5xKkkU1LNbHirM4HeYiXto+6OZg7yEdeWAzvhosQofl0xUquHsxsW4IojfjVyu3XDL22S4Ksggn11Rx2i8w0eWVAL3xdAd07EtNGWYjzM9Gidx2l6ZtU2ekRzk5C7JyZsfNg9PiRFZd+gtBIfgnrQAB5M3WhD43SMeZWQ/H6D9e0+FYapWwdy3YHcG+BWoQqRA3c86Vk5pTdy4wXOT6Bn19kSK1qsSNiW0Q0lQz9bXepNlDmmTFUaMH/jzcYQ8Re2gBg1IKP8bYMqTX/q4M7ZznWjnyBvgVpWRmCiEXNpRc0hgzsL6qOOEH9FvA2Mx5B8LBV9fSGM/JFNKB0BRfCq0xvUp9QeAc+1bdp9ca3Mx5qKV5ovczyFI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB13462.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(22082099003)(6133799003)(18002099003)(5023799004)(4143699003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzloK3pKS1hLVE94TzJxQUh2UUtDZkZKRzhMNEIwWjRlOWNTU1l6NzZzMmp4?=
 =?utf-8?B?WVR3WTM3RTQzQnkvbFhqWTdNaTYxMW9nNW5PWWw5cENEU01pRm9yemZVdUli?=
 =?utf-8?B?SWxGOXlndjdHT0ZPSkdhQWZYRk9rYjFJWGttZnU4b1JPUmdXNFVFUTVSMVYz?=
 =?utf-8?B?REJoYkROQW1taWRVbFJkeXpyY09SMEdTREwwZzQzdEFNdzgzbVZPKzZ6dVl1?=
 =?utf-8?B?VGl1SjNMUjQ3SWQxWGZGbGlNZHpWOUVNc0NYS0ZPTGFpSGQ5T1FDTXVBN2Zq?=
 =?utf-8?B?UDBZYjZzczdDM1g1MGtKdFpJRFJxK3JxZW05dW1rT1p3NFVNMnZiSVFBdUFY?=
 =?utf-8?B?UXR2Y2JqWWJCcjZjNTQwV2Q4VDdXVGFLV0F6Z2NpMU53S0o2MGFIYmNKRGVO?=
 =?utf-8?B?TGhlNTRGcUJpVldsZ3ZMSXk2d1dpVlpMSDlrQi9tczZnZW5wSXBOdW5OdGFw?=
 =?utf-8?B?V2szYXFOYm0yYStId0t1MjNZMnRKRDlKRXIyb2s3NVpGUEs4Rm5HaitZSkU0?=
 =?utf-8?B?cld3N2FrSE5RZFdxdUlwVGVWaE0xZ0xGWDNlTjFTaDNRNE5oNFQxZ3dmOEhI?=
 =?utf-8?B?NjdkNmlSOU5IYmJ6OTljb0tVcy8rdkFIYXpnNmVZcitnQVdNQ3cvcXF0dUhE?=
 =?utf-8?B?bnFPd1ppSHQ5MlM3WEw2UDc4ZlNxd2NiYTNzNHN6ZzVUSnRYR2pjejFrcFh3?=
 =?utf-8?B?TzZtSkoxMlpNOTE5b29wTWt5cTBEU0E3b0t5VVRPUG9SQ0pTMTFBTVpMYlBm?=
 =?utf-8?B?UzAvNVNveDVzSTh4b1NHUFVWMGdyN09nMkxEeVB4K2p0MzIrb0s4TThzeDd1?=
 =?utf-8?B?c3ZYVjFBeVVpMUFMTVkxL1RndWU0Z0pydGxmd3V6N2lSdGJQZTFaeFpDM3lK?=
 =?utf-8?B?b3Q1bnhPZjJXUzNxY3RMOUV4N2pneXoybDBybkRGaFZWWUlIOW85Y2ZhWWZt?=
 =?utf-8?B?d0pSR0hqd0dUMEFjV1EzUFRBVnZ6SU9WeW1yQ2hyS3h2T0xhVitDVTAvbElF?=
 =?utf-8?B?dExPaWkxZy8vc1J1b2NIT0l2Yk8vWmx0clpTSVdwOFpyWDZlejhEYWJ2SXhx?=
 =?utf-8?B?Y1gxeFFWckpzNllaV0paejQ3Z0x3aHAwRGM1R2trUDlEQStPTVJENStmdWpI?=
 =?utf-8?B?dE1tMEh6aG5MSEg4SXpOOEEvVS9KaU1IYlkxam95dmxIeDNuWndzOUdhaVpM?=
 =?utf-8?B?NXAwaEIzNVA2SmtJYittSVlSWnhZelJNM1BaY1NvVWJaVVFmVGVZVURzYkJN?=
 =?utf-8?B?RnBhdGRlNHRYZmxJdHNpUmtJdkhkT3pGcGxkOXZXRFJYUUd6VmlBcFBpRndK?=
 =?utf-8?B?WmUyYzN6QWNiVU5FaThFQTFVT3ZPVVVUVVB2YlRMZ3Y0cVozZE9jazhvRFJ6?=
 =?utf-8?B?UkZ1Vmh0cWhKYVdHeDhSbmp5RnJwNVhxcFBTWFI5T3dDY0dUNGZ2ZDI1eXl5?=
 =?utf-8?B?Qmp1dkFSNnRkQ096OE85OXhieDFKR2RUcHFOcW8xdDMwRDk5QkY2eXlqSmZh?=
 =?utf-8?B?MlN1WmlCQU5nUFlhSXd1MHlXU2pHeW1lZWcrUzNKTWVuTWRxbWtjK3ZXZERk?=
 =?utf-8?B?TE8xK3loWExXTmZFdkpkNTRueGtzYzhQdXZDN2R1NHdxSnlMMzlFaFZkUUo4?=
 =?utf-8?B?emRMSFI3cXlYdXphb3Nydm90Q3J1WjV4QkZWeWZJa1o1NUxKN2FRVjdvUGRH?=
 =?utf-8?B?QjVYMEJrVGU0Z1N5aHNqRGlTdzhidGgwQkd6eG9GbHNPbTRpUGoxUGh1dzdv?=
 =?utf-8?B?c3NCdDE5VlhmNEYycUt0bVdlVnVHbzc5UlhlYTVhOXN2V01sbGI0aGRBdGdw?=
 =?utf-8?B?a0ZSRjUxRC9zR0hLYVEyVXRoYUlTREQrWTJiVm5WbmQrL1lGTUtVSXdRSS9E?=
 =?utf-8?B?STJTMzBQUzMrMXh4MXU3SS93OVgzSEVSOWlOR2hxVVJoSDIyczJqVzd4NUR3?=
 =?utf-8?B?SHo1RGpQVmlaSlZRcjdQT0dVKzVxMFd2bnVWRDBDWkozVStWT3hNSnJWa05T?=
 =?utf-8?B?WStvT2huUFJNa0dVK3B5Ym5TVE1yR09OVy83Ym03cmZ6ZmM4TGNLaGo0aEpV?=
 =?utf-8?B?WnEwN1Z6Uk5nbzl2aSsrS1BjdWw3RUFJejNMdmZlRFZTd2JZMUQwcUgrTzRM?=
 =?utf-8?B?bnlMNU5JNWE1YldoaklHckdhWnJzOFluWnVpSUxxYjdwSmtPQ0ZzYTZVUmVp?=
 =?utf-8?B?MFZ0RzZFV0pqK1FEcWRwbThUTW51ejVMK0tESFVUNWpZUlVvYytBRkZSYXNS?=
 =?utf-8?B?R2hFcGVISnpRSEp0SGVPbFVnYU9rWDNGSWl1TVA3dWpHVUpGR2hOZlhEalEv?=
 =?utf-8?B?RDdJMXUxRzRsK3JKdUk3TFhkWHJMU0NySGtJYnMzN1BqRHp3aytDdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F1F9269885FFB44A521782B8C10D484@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13462.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf8a4aa-87e5-4ddd-0a2a-08df04affb22
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 02:56:38.8357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0TyI3Txuq+UOI7sExuRhQ/AkqoXPsh0WKwVpv230cjcEkCWPORre7rFWG3sVYV/4HCrrLrCu8unNYIgb2kKcJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB14274
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260827_195658_059594_7CBEA0A2 
X-CRM114-Status: GOOD (  12.10  )
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

SGkgU3RlcGhlbiwgVGFvLA0KDQo+Pj4gVGhhbmsgeW91IGZvciB5b3VyIHVuZGVyc3RhbmRpbmcu
ICBmb3Igbm93LCBwbGVhc2UgbGV0IG1lIGtub3cgdGhlDQo+Pj4gaW5mb3JtYXRpb24gb2YgeW91
ciBleHRlbnNpb24gb25jZSBpdCdzIHJlYWR5Lg0KPj4NCj4+IFBsZWFzZSBjaGVjayBteSBleHRl
bnNpb24gbGluazoNCj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9saXV0Z251L21rZGYtZXh0ZW5zaW9u
LWFtZGdwdS1tbS1maWx0ZXJpbmcNCg0KPiBJIGFtIHdvcmtpbmcgb24gY3JlYXRpbmcgYSBHaXRo
dWIgcmVwb3NpdG9yeSBmb3IgdGhpcyB3aXRoaW4gdGhlIE9yYWNsZQ0KPiBHaXRodWIgb3JnYW5p
emF0aW9uIGZvciBvdXIgZXh0ZW5zaW9ucy4gVGhpcyB0ZW5kcyB0byB0YWtlIGEgd2hpbGUgZm9y
DQo+IGFwcHJvdmFscy4gTWF5IEkgc2hhcmUgdGhlIGV4dGVuc2lvbiBVUkwgd2hlbiBpdCBpcyBh
dmFpbGFibGU/IEluIHRoZQ0KPiBtZWFudGltZSwgeW91IGNvdWxkIHVzZSB0aGUgVVJMIG9mIHRo
aXMgcGF0Y2ggc2VyaWVzIChvciB0aGUgdjIpLCB3aGljaA0KPiBJJ2xsIHNlbmQgb25jZSB3ZSBy
ZXNvbHZlIHRoZSBkaXNjdXNzaW9uIG9uIFBhdGNoIDQuDQoNCkkndmUgdXBkYXRlZCB0aGUgd2lr
aSBwYWdlLg0KaHR0cHM6Ly9naXRodWIuY29tL21ha2VkdW1wZmlsZS9tYWtlZHVtcGZpbGUvd2lr
aQ0KDQpwbGVhc2UgbGV0IG1lIGtub3cgaWYgdGhlcmUgaXMgYW55IHVwZGF0ZSBvciBpc3N1ZS4N
Cg0KVGhhbmtzLA0KS2F6dQ==


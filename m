Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DDBC5B572
	for <kexec@archiver.kernel.org>; Wed, 12 Aug 2026 01:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ZnySaT2FfJ/7vBL9+D6eS88nBXNmMkaS+8SDyov7gg=; b=kS1Qx9a3jPXreHBxUWp0x9Ub0L
	Ib6Vr81dWAvH293y49OE6svwQIPp8nvjNgXSjJW6UuYO2LKfrbw8hsX6FC2VPVDh2Xwq0lgDB6khJ
	NSNMJm4FuGXNvj7BIBTIbqEsDJqOoMxTzofe2XAVhCgAABmtB1WyfqO4LTxRg3/wPdlN0/yCzhjC7
	u8tiUSzT1Dtu5mlqME0stDJ/tDzufKiEMaO+XFYcL/B33LxVIDmRNuId3nSQ4UwxBX/ubMXU1Mdki
	9S02RVIJaz0Zx4VEsafOtApE/k6X299XzF8mAgxOb5Tek88BXrNZX7rnh79qTcJBcbVYHvc6dlq/c
	7pAGqt+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtxpN-0000000FCyl-1sFe;
	Wed, 12 Aug 2026 01:32:21 +0000
Received: from mail-japaneastazlp170100000.outbound.protection.outlook.com ([2a01:111:f403:c405::] helo=TY3P286CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtxpE-0000000FCxt-1TkI
	for kexec@lists.infradead.org;
	Wed, 12 Aug 2026 01:32:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujYSQOVeSHhcJV3l1IKldGcH9P8Ddz7tFcqJFsr+0b52UO0gIPZIeqJXbPpIsjdtxSVY/KBB0FN+vZJIYs8u+oSh8k8L6OcnmLTvV3wSR8338HrKrGc+K8SQW2bEUejUuFlwnOHV0XY5Z3lpvqVvwTcn6igw9nW4YEmxtnTwvQzDIJgmy70GKrru5UhhfamfrXc7P4mXDfgfOVv30TrCe2cZR77Vk5bmw1RsdJJZ3dqvYSgIxZ2eIxMq13tradQRmFgqc29ddHKgruiNYWrwHEk3uqjDC27ofms6Ard7n1/rGyCNFCJ0OUghKY7VQJcQ3X/xqXxdxBcrGacppVnWkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZnySaT2FfJ/7vBL9+D6eS88nBXNmMkaS+8SDyov7gg=;
 b=UlUfhYabFDOrBT8vF5h1ZemGdercZoBYxFKx8YBCAmyAJBj7hXufk7O7Mug/u88dTDX2aE4MqP365RzUvCLbuDhLOituPlXLHXOADx7WxEvcrmSvtqVhzREFq6RiFWDpu6lFunFM6lIdv0yZ5Q79GJZS5kzZjbAun/c7TIy6G8BGCKkrlGSFB80O6V3YbkD/8V2O2Q/IRCaNVwPNK/4hz33Khgr19tfNAOylhJ3LorFTqf04ACgxrqmyPkbSldd4KeCU9Tqvz3FMiTUBZwDJ9HSTImx/F3av5R/EXBZWADm76sRJV3p8ZXuAOylNfqFo2UhLAQ9RxllYBcj1uDiIkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZnySaT2FfJ/7vBL9+D6eS88nBXNmMkaS+8SDyov7gg=;
 b=VwlvEtTmXow5zdJd2emDGbsHj14dMaFXGtNdMSNWwd504euKpwsoyiOhuMg63icx/C7tRTeNJUbfn3+xydZIQXswclch978STIbr5b1Srf72N09iUc5RiTIZew3hjzLVtaYKJL7lEpwmtsXMd6sIxDHrBCT/OOdjQrpf/O6YjB/CPLn7Nd7msnzvE9N6jKQBKh4cUlJEan7LI2ZQOC8aSkwdI+evb7OGd4UZLGfYbi5MvDeIeonaBU/ljFJUy9SPyhDCt9YWrTY3cxcMuEUMgcCdEA+qrHL1lr2518gL04RDOVfJcNgFFJxs7HwTeEQjkwGPHbm0k9lfDT1SrE5Jdw==
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 (2603:1096:405:1d7::13) by OS7PR01MB14883.jpnprd01.prod.outlook.com
 (2603:1096:604:39c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 01:32:00 +0000
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820]) by TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820%6]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 01:31:59 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Tao Liu <ltao@redhat.com>
CC: Stephen Brennan <stephen.s.brennan@oracle.com>,
	=?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
Subject: Re: [PATCH makedumpfile 0/9] Improvements to makedumpfile extensions,
 plus userspace stack tracing extension
Thread-Topic: [PATCH makedumpfile 0/9] Improvements to makedumpfile
 extensions, plus userspace stack tracing extension
Thread-Index: AQHdEyorXwwQdBKvLk6+FbOcta264LaR+EQAgABmUoCAAOFbAIAAeusAgATPMoCAAURYAA==
Date: Wed, 12 Aug 2026 01:31:59 +0000
Message-ID: <404ed232-6c8e-4112-b13c-6338156476d3@nec.com>
References: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
 <7af7b171-88c0-4eb6-a18e-8e64fb4a71c0@nec.com>
 <CAO7dBbX---qP-Bqjza=z2HM4Nxn5+KtB-51WF4mvv++p666JYQ@mail.gmail.com>
 <87tsp539pr.fsf@oracle.com> <38980e2a-d303-42c0-81bd-ae25b52b94a8@nec.com>
 <CAO7dBbUcv5_OW8CJfzGB56U=PO3kbGkX7gz9-E4JEFFU+eVCMA@mail.gmail.com>
In-Reply-To: <CAO7dBbUcv5_OW8CJfzGB56U=PO3kbGkX7gz9-E4JEFFU+eVCMA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB13462:EE_|OS7PR01MB14883:EE_
x-ms-office365-filtering-correlation-id: d9e68db2-24c0-4b0f-132f-08def8118136
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|11063799006|4143699003|56012099006|3023799007|38070700021|13003099007|6133799003|10067099003;
x-microsoft-antispam-message-info: LPjIa1FiYfWXgVRHCEQHPAuAhAzsZ8mpS9O/m/qjzqm2ugOvlJmwfTlKZU7v7w+BqkV9Ezvpfyp6vHhSDF0ZBv0kNT9qYr3qY6KPXNzxBHlPNGpjPNWMEHnCyDFfo3RsQNpGHbgdIpktwfkTXlHCrQa3taMUe3MadMDH34R0vD+mEzWGKghDicEitc0t0IU3E/CcW/z7WGYQPRCuM2J1OztaKRmgBNpeXgG3zmGShLrFX3un1o4Y2/fiJfA9ZGmPO6nZwIzTBAMNaDs+stLjga8LJJYkCVUzRUEOSfxxII6MLJTJS4UK2iKIZkgSaIv4kI4u2QeA/RlPTxuzuMcGLYflb+K+0epTDzlse+1D2pRbUgYuomilDErWo8zTaHtCSKyFw3QTo7a9+GUXHDqGqovb2iQ7HWq8Hx7ZQsON+qWaVhHGMPHoeDztYHlwoqcSIrwVQWct10YJMF+xUlGpl+Wk8x05lEg1q91Myje35vY56xgotsMjoc5XvO4nICQepS4J2qWLzr2xjc10aVCLdytctHyUnVg/6msmerFbjqu5qXP+R2yeFdsl8fPwaAaMOuC24gG9cGwF07OF9ae943gPokaibC726k0VSPSK1+s2ikuTnB0ZvXeP4bouhC+80jXqILJNeh1dnB4OVaMCcKFBOJUPBelc9S5QnIzt8nRnrYaRcmZ729olr/JI4YF/dOYLUQE1m2TbLs4YA1M8y+Jhjkhb/3lDBa5LYFoPJ18=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB13462.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(3023799007)(38070700021)(13003099007)(6133799003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2pOTUNLejR0U2psK2REckJzMy9zdk9QS2VtcGdHZlNxNzF6TlpiVDNuNlhX?=
 =?utf-8?B?b3VyRXJGck1QYXpJUEUxSVdFdDVsWVN5bXRwMTFNKzBlM2R1d2JkdCt6MGFH?=
 =?utf-8?B?V1BOdlplaHRHQmNGYXR5d1VZUlNvUFdYUExTR2RVekJNNzExRkMrNCtLaktQ?=
 =?utf-8?B?VVRUK0NrN3FqekMxR01DaCs4Vms5eEoxM2NIUHE2ZEgyT1pMaEZoNmJuOWxZ?=
 =?utf-8?B?ZHZ2eHhuV0xlSWQzNFpibnpLb1BWc1JzOHNPRmlYbU1vNE5wazQ2enY2bVJi?=
 =?utf-8?B?eElQQlNvSlpETUluRjIvamwwWXFOd2lQYVZHcWcyTlEycEdYdkpxT2xVNHhK?=
 =?utf-8?B?QkJ0RkcrYUc3TlFrL21wSWZra0ZhWDhwS3BYcUd3VFZubGxpZXJPTGllVzZu?=
 =?utf-8?B?R0I4ZVFqdWZUNnhZRTAyNEt2eUs1OEErbC95T3FRRjlzb3U5Qy9Cd2xqU3Rs?=
 =?utf-8?B?RytXZjNSU1lqZVI3NUhTeFJWeDduQ2wreHBscEdYbU1xRmtCamo4dEtpcWZv?=
 =?utf-8?B?UC9hNlBaVEtYTThFWXlXRVFNQ0RvUnNFMHBZeVVKakdBeDZ6TEFvVEhYZUZQ?=
 =?utf-8?B?YkJxN3BzeEU5WnFTYXFIbUIwOWdnTGRyZ2t2bi9PWTVaZHRiYWdKYkRSWFhx?=
 =?utf-8?B?M3R2UEl6V29VOTNBY3JCZ1VFVUVLTHkxUTJGUUpGS0hFc09mSkQzeWM5eDh0?=
 =?utf-8?B?QzhmTE8xYmtYOHBscmVyNzM0bUp5TEpHWWhsTDA5Y0pycDh3VjdSWnZZOGVr?=
 =?utf-8?B?TGVETS9uL1pKRjl2bFpKUGJieFFPVjlLNVZsN1oxWHpxWVJwQ1AvNlNrenBR?=
 =?utf-8?B?ZkFDLzBscnI5aVFlaU55bHF3Vm1tRzFwR29Famcxd2tpdHFNQmU2Vmg4U3pG?=
 =?utf-8?B?dlNuTStLVU9xTXNTMFhmKzd0ZHIzNFhJODA0YjJlQkpQSkZJVU5nT2VjaTAy?=
 =?utf-8?B?Y3p5VmxkcGlidnBOSUFWUGtrT3ZMY2YvY0xWK3d5WVFqSnZJOFVVZ0ErbGxz?=
 =?utf-8?B?Y0o4cERLSGxYVGFrNnBHaHFycjBUQk9BMmVBSlUxU3k3WDZUZHIyUVE0clVS?=
 =?utf-8?B?a0NCS2FnQWNDUEVzL1liYitvZGd5aTB0ZmlMR0V4bStnNVZJR0dRMXFqVmZy?=
 =?utf-8?B?M0NuajFHZWEvUHJETmczTHZNRkZORmRkNU56cjN0UHl5QStTWlRZSnkvR1pm?=
 =?utf-8?B?amk1NjFvdklCZGVEamc3dkVhMzVPU3o0UnBJbkdpejdPdTBXaldwY04vVEJa?=
 =?utf-8?B?OHZsZ0lpS0h6MHI1TUhocFMyOG94dTNha3huSXJFQjZuUDFBQVU1eW80NDhC?=
 =?utf-8?B?RHRlZWIrWWt0VDhCUE1oTHFwZ0ZtUFVzNTRZMHY0bHZIaTFMMzJBSFlYUFBG?=
 =?utf-8?B?SVdPWnJDRmdvSE5kUzNQZ0hBekUrL0F1NmZWcDJqVnFCUXQyOHljaVVqUFhu?=
 =?utf-8?B?ZU12ZHY5bkpQd0w4VU4rcC9JbGsvWmd1ZHNBdGJBNnh4b2RlWWx4L0tnVjNW?=
 =?utf-8?B?V21pL1ZMUzBUQVRZaFlYc2V3V3FvS2VVR1FtMkhicG9YNTFIdStwVWpKb3l6?=
 =?utf-8?B?a0JNV3g0YTN4clZpZStHVTREQ2oyUFFCUHcwL1VPYy85ekkxbHZ1Y0FPSTVK?=
 =?utf-8?B?d0tNOUpOdUMvdXRpUHZGOFMvU2JaNDJZb3VuVWRDbExBVFBlVWxwQ0xDZmdM?=
 =?utf-8?B?RGl0OFRRTlV5bkd3MUJYcC91b3FyZDhpSkRXdndMRFVheHBFWC92d0w2aWNX?=
 =?utf-8?B?amx6ZkR0V3JLUHA0MTVZZ25jOFREVDI4aS9JYXFpTjhzVkhTTWdhNDBVQVNm?=
 =?utf-8?B?Szl3LzcrMDI2ZWRXS3g5ZkJsQnVOdmxxUngvY1hnUzVOckJFOU1rQ0dnUzVy?=
 =?utf-8?B?Qmova2ZhczRnRmdDd0E0elNLTWtyR250VnlUTWc2NnRmVjBLcHRPTmErN2VM?=
 =?utf-8?B?MVhwSk90YXRselpRa29VOFV5aG9ZUm85N2gvK0Jia3ljTXVEZjJGdnFJLytS?=
 =?utf-8?B?VGF6S2tnR3c2TFZFK09qTTI1Q1AwekRncWRuZkU3UW96MjFONmsxSEhkV2dB?=
 =?utf-8?B?TW5KcCtubzQ0Q3JxL3RkQVhwZDN0QzR3Uzg1WmUzTGJnL0ppMkYrV0JBdWw1?=
 =?utf-8?B?Z1UzMFlOOFVlb2JFcGhUbCs4eHNYTGNxZzBZT0MvWjl6S1NNYkdHMVpnTmhH?=
 =?utf-8?B?Skg2NURHMmdaYksxK2dHVGczdzR1VSthUWFaS0xETHpaKzV2c3pHVUY0M0Y3?=
 =?utf-8?B?WjNjbEZsNGY5aTJla3d1dWxIdlNwNW1EV2Q1VnNFK29QZS9EVDJkTE1yRzNw?=
 =?utf-8?B?ME0vNDNwMUtsZXNQNEtFSWhFT1pUOG1xOEJkT0RSYUNBazZHQmJ4UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <875848B97C24E64694E04B029EBEE1A6@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13462.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e68db2-24c0-4b0f-132f-08def8118136
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 01:31:59.8910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ePJ/7r8YkLLNj8RCp2WdiYzRI3uSlvlBjWBwcpmieS4/N/rtfyEecwqOkfsBAzjxIpqrFh7TfQR7IIPq2ES2nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14883
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_183212_782623_17D7EA6A 
X-CRM114-Status: GOOD (  24.42  )
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

SGkgVGFvLA0KDQpPbiAyMDI2LzA4LzExIDE1OjExLCBUYW8gTGl1IHdyb3RlOg0KDQo+Pj4+PiBh
bmQgVGFvLCBwbGVhc2UgY2hlY2sgaWYgeW91ciBleHRlbnNpb24gY2FuIGJlIHJlYmFzZWQgb24g
dGhpcw0KPj4+Pj4gcGF0Y2hzZXQuICBhbmQgYWxzbyBpZiB5b3UgYWdyZWUgdGhlIGV4dGVuc2lv
biBsaXN0LCBwbGVhc2UgcHJvdmlkZQ0KPj4+Pj4gdGhlIGluZm9ybWF0aW9uLg0KPiANCj4gSSBo
YXZlIGNoZWNrZWQgbXkgZXh0ZW5zaW9uIHRvIHJlYmFzZSBvbiB0aGlzIHBhdGNoc2V0LiBUaGUg
cmVzdWx0IGlzOg0KPiANCj4gMSkgUmViYXNlIGZhaWxzLCBidXQgb25seSBkdWUgdG8gY29uZmxp
Y3RzIHdpdGhpbiBleHRlbnNpb25zL01ha2VmaWxlLg0KPiBUaGVzZSBhcmUgc21hbGwgaXNzdWVz
IHdoaWNoIHdvdWxkIGJlIHZlcnkgZWFzeSB0byBmaXguDQo+IDIpIE9uY2UgMSBpcyBmaXhlZCwg
YWZ0ZXIgY29tcGlsZSwgbXkgZXh0ZW5zaW9uIGNhbiB3b3JrIGFzIGV4cGVjdGVkLg0KPiBIb3dl
dmVyIHRoaXMgaXMgYSBjb2luY2lkZW5jZS4gIEJlY2F1c2UgbXkgZXh0ZW5zaW9uIHRha2VzIGNh
bGxiYWNrDQo+IGFzOg0KPiANCj4gaW50IGV4dGVuc2lvbl9jYWxsYmFjayh1bnNpZ25lZCBsb25n
IHBmbiwgY29uc3Qgdm9pZCAqcGNhY2hlKQ0KPiB7DQo+ICAgICAgICAgIHN0cnVjdCBmdF9wYWdl
X2luZm8gKmN1ciA9IE5VTEw7DQo+ICAgICAgICAgIHJldHVybiBmaWx0ZXJfcGFnZShwZm4sICZj
dXIpOw0KPiB9DQo+IA0KPiBCdXQgdGhpcyBwYXRjaHNldCBjaGFuZ2VkIHRoZSBjYWxsYmFjayBp
bnRvOg0KPiBydW5fZXh0ZW5zaW9uX2NhbGxiYWNrKHVuc2lnbmVkIGxvbmcgcGZuLCBjb25zdCB2
b2lkICpwY2FjaGUsIGNvbnN0DQo+IHN0cnVjdCBwZ2luZm8gKmkpDQo+IA0KPiBNeSBleHRlbnNp
b24gd29ya3MgYmVjYXVzZSBpdCBvbmx5IHRha2VzIHBmbiBhcyBwYXJhbWV0ZXIsIGFuZCB0aGUN
Cj4gaGFuZGxlX2Nic1tpXS0+Y2IoKSBkb2Vzbid0IGNoZWNrIGZ1bmN0aW9uIHBhcmFtZXRlcnMu
IEhvd2V2ZXIsIEkNCj4gZG9uJ3QgdGhpbmsgaXQgaXMgYSBtYWpvciBpc3N1ZSwgb25jZSB0aGUg
bW9kaWZpY2F0aW9uIG9uIGV4dGVuc2lvbi5jDQo+IG1lcmdlZCB1cHN0cmVhbSwgSSBjYW4gYWRq
dXN0IHRoZSBmdW5jdGlvbiBzaWduYXR1cmUgb2YgbWluZQ0KPiBhY2NvcmRpbmdseS4NCg0KVGhh
bmsgeW91IGZvciBjaGVja2luZy4gIE15IG1haW4gY29uY2VybiB3YXMgdGhlIGNoYW5nZSBpbiBi
ZWhhdmlvciwgDQpwYXJ0aWN1bGFybHkgd2l0aCBjb21wb3VuZCBwYWdlcy4gIElmIHlvdXIgZXh0
ZW5zaW9uIHdvcmtzIHdlbGwgYWZ0ZXIgDQpzb21lIGFkanVzdG1lbnRzLCB0aGF0J3MgZ29vZCB0
byBoZWFyLiAgSSB3aWxsIG1lcmdlIHRoZSBwYXRjaCBzZXQgbGF0ZXIuDQoNCj4gDQo+Pj4+DQo+
Pj4+IFN1cmUsIEkgd2lsbCBjaGVjayBmb3IgdGhlIHJlYmFzZS4gSW4gdGhlIG1lYW50aW1lLCB3
aWxsIHRoZQ0KPj4+PiBleHRlbnNpb25zIHRvIGJlIG1haW50YWluZWQgaW4gb25lIHJlcG8gKGUu
Zy4gbWFrZWR1bXBmaWxlIGV4dGVuc2lvbnMNCj4+Pj4gcmVwbywgc28gZXZlcnlvbmUgY2FuIFBS
IHRvIGl0KSwgb3IgdGhleSBhcmUgbWFpbnRhaW5lZCBpbiBlYWNoIG9mDQo+Pj4+IGluZGl2aWR1
YWwgcmVwb3MsIGFuZCBsaW5rIHRoZW0gdW5kZXINCj4+Pj4gaHR0cHM6Ly9naXRodWIuY29tL21h
a2VkdW1wZmlsZS9tYWtlZHVtcGZpbGUvd2lraSNleHRlbnNpb25zPw0KPj4+DQo+Pj4gSSBhbSBv
cGVuIHRvIGVpdGhlci4gSSB3b3VsZCBiZSB3aWxsaW5nIHRvIGNvLW1haW50YWluIGFuIGV4dGVu
c2lvbnMNCj4+PiByZXBvc2l0b3J5IHdpdGggVGFvLCBmb3IgZXhhbXBsZSBhdCBnaXRodWIuY29t
L21ha2VkdW1wZmlsZS9leHRlbnNpb25zLA0KPj4+IHNvIHRoYXQgdGhlcmUgaXMgYSBjb21tb24g
cGxhY2UgdG8gY29udHJpYnV0ZS4gVGhhdCBpcywgaWYgdGhpcw0KPj4+IGFycmFuZ2VtZW50IHdv
dWxkIHdvcmsgZm9yIGFsbD8NCj4+Pg0KPj4+IElmIHdlIGRpZCBjcmVhdGUgYSBjb21tb24gcmVw
b3NpdG9yeSwgSSB0aGluayB3ZSdkIHdhbnQgdG8gc2V0IHVwIHNvbWUNCj4+PiBleHBlY3RhdGlv
bnMgb24gdGhlIHF1YWxpdHkgJiBtYWludGVuYW5jZS4gRUcsIHNvbWUgbWF5IGJlIG1hcmtlZCBh
cw0KPj4+ICJtYWludGFpbmVkIiB3aXRoIGEgbWFpbnRhaW5lciBhbmQgYSBzY29wZSBvZiBtYWlu
dGVuYW5jZSAoc3VwcG9ydGVkDQo+Pj4ga2VybmVsIHZlcnNpb25zLCBzdXBwb3J0ZWQgYXJjaGl0
ZWN0dXJlcywgZXRjKSwgYW5kIG90aGVycyBhcw0KPj4+ICJ1bm1haW50YWluZWQiLCB3aGVyZSB3
ZSBqdXN0IG1ha2Ugc3VyZSB0aGF0IHRoZXkgYnVpbGQgJiBydW4gd2l0aA0KPj4+IG1ha2VkdW1w
ZmlsZSwgYnV0IGRvbid0IHZhbGlkYXRlIHRoZWlyIGJlaGF2aW9yIG9uIHNwZWNpZmljIGtlcm5l
bHMgb3INCj4+PiBhcmNoaXRlY3R1cmVzLg0KPj4+DQo+Pj4gT24gdGhlIG90aGVyIGhhbmQsIGlm
IGl0J3MgcHJlZmVyYWJsZSB0byBzdGF5IHNlcGFyYXRlLCB0aGVuIEknbSBoYXBweQ0KPj4+IHRv
IGZpbmQgYW5vdGhlciBwbGFjZSB0byBtYWludGFpbiB0aGUgdXNlcnN0YWNrICYgZWxmaGVhZGVy
IGV4dGVuc2lvbnMuDQo+Pg0KPj4gSSB3YXMgdGhpbmtpbmcgb2Ygc2VwYXJhdGUgcmVwb3NpdG9y
aWVzLiAgQSBzaW5nbGUgcmVwb3NpdG9yeSB3b3VsZCBiZQ0KPj4gZmluZSwgYnV0IGZvciBub3cg
SSBoYXZlIG5vIHBsYW5zIHRvIGNyZWF0ZSBvbmUgd2l0aGluIHRoZSBtYWtlZHVtcGZpbGUNCj4+
IG9yZ2FuaXphdGlvbi4NCj4+DQo+PiAoTG9va2luZyBiYWNrIGF0IGNyYXNoIGV4dGVuc2lvbnMs
IHNvbWUgYmVjb21lIG9ic29sZXRlIHF1aWNrbHkgb3INCj4+IGhhdmUgdmVyeSBzcGVjaWZpYyBm
dW5jdGlvbmFsaXR5LCBtYWtpbmcgaXQgZGlmZmljdWx0IGZvciBhbnlvbmUNCj4+IG90aGVyIHRo
YW4gdGhlIG9yaWdpbmFsIGF1dGhvciB0byBtYWludGFpbi4gIEZvciB0aGlzIHJlYXNvbiwgSSB0
aGluaw0KPj4gaXQgaXMgYmVzdCBmb3IgdGhlIGF1dGhvcnMgdGhlbXNlbHZlcyB0byBtYW5hZ2Ug
dGhlbS4pDQo+IA0KPiBVbmRlcnN0b29kLCBleHRlbnNpb25zIGFyZSBkZXNpZ25lZCB0byBhZGRy
ZXNzIG9uZSBzcGVjaWZpYyBpc3N1ZSwgYW5kDQo+IGlzIGVhc3kgdG8gZ2V0IG91dGRhdGVkIHdo
ZW4gbWFrZWR1bXBmaWxlL2NyYXNoIHV0aWxpdHkga2VlcGluZw0KPiBmb2xsb3dpbmcgdXAgdGhl
IGxhdGVzdCBrZXJuZWwsIGJ1dCBleHRlbnNpb25zIGFyZSBvZnRlbiBsZWZ0IGJlaGluZA0KPiBk
dWUgdG8gbG93IHVzYWdlLiBMZXQncyBnbyB3aXRoIG1haW50YWlubGluZyB0aGUgZXh0ZW5zaW9u
cyBieSBlYWNoDQo+IGF1dGhvcnMgc2VwZXJhdGVseSBhbmQgbGluayB0aGVtIGludG8NCj4gaHR0
cHM6Ly9naXRodWIuY29tL21ha2VkdW1wZmlsZS9tYWtlZHVtcGZpbGUvd2lraSNleHRlbnNpb25z
DQoNClRoYW5rIHlvdSBmb3IgeW91ciB1bmRlcnN0YW5kaW5nLiAgZm9yIG5vdywgcGxlYXNlIGxl
dCBtZSBrbm93IHRoZSANCmluZm9ybWF0aW9uIG9mIHlvdXIgZXh0ZW5zaW9uIG9uY2UgaXQncyBy
ZWFkeS4NCg0KVGhhbmtzLA0KS2F6dQ==


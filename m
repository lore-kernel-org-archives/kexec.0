Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C206CD98DE
	for <kexec@archiver.kernel.org>; Tue, 16 Jun 2026 01:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h81dvZ93zoNixd4kwzO8hRenfn3fDFldTPLIrrv6o8c=; b=F/o29NCHUv+nAN/XOez9r7AyV4
	l6+JucX8/rvkV5At86BrHnLAKk3+tvXKxwMF/q3WADEncEf+oHHHOKEGAzclE2xHziHqg9OHdOVkx
	mniUiWhSjNNJGv5abzEQCdSImk/OTT+rLsxSgsGuInJMH7Bdiw56U7oQioG0WfbdEJMbH8ZEK8zuv
	PKumpAP5F3ET5hz6wQm73h58mOYWdis+IT1/xh2nEstUbF3A3ItH9V56SUKcp+vAcTnnlz2k1zMN6
	xRGnelyxcTcKmTcgmKa8EJec8gx6yC/O53jTuZBVrd3BkiDmk4AeE+idV1qfd6awE2Zgm9opO7Kaq
	V5e28msg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZImS-0000000F4RH-3pW7;
	Tue, 16 Jun 2026 01:39:56 +0000
Received: from mail-japanwestazon11011010.outbound.protection.outlook.com ([40.107.74.10] helo=OS0P286CU010.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZImP-0000000F4QT-3fIo
	for kexec@lists.infradead.org;
	Tue, 16 Jun 2026 01:39:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLGj5afgMKjIO7CF1ZqitTutW2joJbeYM5w5K0nKvE+Yoi0XhbFrJ32uIWcXfvWoQUQsKorit0LH69YBAE+pPOlfV11GdE/svkLlvVvBc3PHFyPv4GcQwa8ywACBO3+8ni/eCyXXBH0d66LIvkLH8jh6DI/LOWaPL1GSN5k8REZpTQkH/IxEeog/5I4Gz7nkn3SV14BztnSq9voqQfpyC0UMhNPO1+7DFPJKahALSIPhHuniWFyZRVgSMkHzugIImmvle3fXwu8PMdvpggN5Y//ELKo2odqw4iQ4KaTg0QtDi/RiltPzn4+pLHZU+NPzeKWCL19ozIBZRr/mwk3T2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h81dvZ93zoNixd4kwzO8hRenfn3fDFldTPLIrrv6o8c=;
 b=awcu/GYFX4qJlcXS1P7Jk50j96eawFX2hhiaK83zohaUAFQ0+Etip5ZukNyk5Cu6CIx9JrPTJJas8Jvu9TugkGdOfgSVRoSJdwZMCLgxuOvNSJ6nNukL3PHAh9UChE0xZxmx8qkB38MnYSk31g4bcExEHaMtM23YcATjMxONKNa29uK2nPYkMzBGoSewzginCBSXYza3Dqes2TLC4B7WAzi672gX+BgTJl3AxRvUlJ59LPtWjej+areGWxrRm+hb23pBQXhuHJVXk+sCsb8rEeL5DdikJ4x/OUCL+mt+LuxAjRIWuhqp/8ERDZt/TvihHIsrKxXVjGnJbO9MqkwxqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h81dvZ93zoNixd4kwzO8hRenfn3fDFldTPLIrrv6o8c=;
 b=hrZ//BXWFE9ptkC+VL5Ru8b53b0MCsEWepobZBELb1js/rnIR/txMgO5R0JgSqNms4SuMYkzgwhWcfu6kYayLYIDI/+l1VYK3EzCUXQBgfp/Oe/cb5QzYzcLSY9jJImxiyVsz7QSS2lk+8L9s8WNQxaltqJB+T8ebAUOE0ELLfMcAH7GfZm3RQ4Li7jWB1ywUOblmLMnjuSRY6Uyx4X1j+nrVDTC0bq6IRmB5FwOzmMMChuCWQT228DYT1qiw0wiea5MXspsDs+2zIuoWbgYgHBqvPAPQqyjq8T6hGYTQBy+BRrNWauVuNVxvYLpv4q1j2FP6due+XCL8lKPOJzgPQ==
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 (2603:1096:405:1d7::13) by TYXPR01MB15707.jpnprd01.prod.outlook.com
 (2603:1096:405:29e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 01:39:40 +0000
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820]) by TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 01:39:40 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Tao Liu <ltao@redhat.com>, Stephen Brennan <stephen.s.brennan@oracle.com>
CC: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
Subject: Re: [PATCH v5][makedumpfile 6/9] Add makedumpfile extensions support
Thread-Topic: [PATCH v5][makedumpfile 6/9] Add makedumpfile extensions support
Thread-Index: AQHcy/lclxSqixzmRk+7o4cMJqDfsbY/pKkAgACXlICAAGIggIAAK62A
Date: Tue, 16 Jun 2026 01:39:40 +0000
Message-ID: <f15ae344-bdcc-48a1-9c7b-0ea264d061d4@nec.com>
References: <20260414102656.55200-1-ltao@redhat.com>
 <20260414102656.55200-7-ltao@redhat.com>
 <8b0079dd-e50a-4667-aabf-1612921b022a@nec.com> <874ij3zq1k.fsf@oracle.com>
 <CAO7dBbU6V7XYYO9M+z_CK8UCnzfX7TB7DZka4Z_kqP-WvDbTaA@mail.gmail.com>
In-Reply-To: <CAO7dBbU6V7XYYO9M+z_CK8UCnzfX7TB7DZka4Z_kqP-WvDbTaA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB13462:EE_|TYXPR01MB15707:EE_
x-ms-office365-filtering-correlation-id: 3bdc00bf-f347-4ec7-c751-08decb4821f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|38070700021|6133799003|22082099003|18002099003|4143699003|4133799003|11063799006|56012099006;
x-microsoft-antispam-message-info: t3VQ+d8e3QPZZHGlWUP/YD2Q5oWK4z3+kulx7dJtssCf2bNkiq7X7DZz1feJoGNFgPdAlHparIvuUhDXkkAG3HQkmP+X1aEdn8vtRP8clzTenS1tqBV80oCLQiXx0rrNs+FpC/VV2qNpb912/wUP6JIPUO5BH0BaLry9johNBWn0KEzLt0z0U5K4EcFpzK4tJi65DjKOfkLu0FMVoNUk1O6/ucEu5KQrq6ljFaLdcOoAwkkobldAonJfASrMCO6FbGjsxBoQ+Df+EDWM7xyZybNuCT6pgT5jBXikzJxx8NHaCmkkcM0Qi8ySCoCmgt5SumTdw7M4MU2Q3+DZHvm5iJK+iXDRHNLmz7/4wJ01C4a8c+i5J7aem4FGuli/wZlFcQsR+uZpW6nabxyMBr0ZoKBSoeHfdl9Ypf/jWJy0Oqr/ATSLZrsc/sjwa/YLNbHVCEmNgibzUibGvl0s+MV5h75b7+nlb2h7fxQ/5dTRXviwHqnT+D7TIvA5eQ7YDbOTZyFwINa07IRKvDRWMxtkkdwS3Ddq0yVNH6TsjN6w3Wkld+hNTstHd+jAlzQEdDTWpysEcE/hicmEQ4n4Tp4Yq65mE2OOzCjbQfgZqksph2azmlfOTE4iXG87dfE/KpBNGnOLuFXUkZ/0Z1sk6UCBUUaw+FfdDwGzqrrZ4aYd2KRiPP1zkZcSUsbCe6xADAkzpxbxAv/uUwW4VxriiBch+DOFXlF5NUkFMyhl9ujqABKl4Td1oHIfryOcBnofDYeM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB13462.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(6133799003)(22082099003)(18002099003)(4143699003)(4133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clBFOGptTzNSYjYzRmprNWxuQXAyQjBGRnJBQzVCUFJBZndiTUdkbEtxYWJL?=
 =?utf-8?B?QTUwclAvenYyc2JOQTIwOU9wWXRYQzlINXhrcHNhMExZVENFL3A0ZWpvYk8v?=
 =?utf-8?B?OVNjWHpUOW5BWGcyNXo4aTFUUWIrNmZoK0xHdkp5eGQ2MmJwc05WSzVEbEEy?=
 =?utf-8?B?aWNpYk14TkRTOHVvK0ZYUEVZbG1Zbm12MSt3VUVHazBsQnFaNTRRNE9XYWVw?=
 =?utf-8?B?eXQwaUdyd2RleWRiUnlQYWJNaGZUdXZsRTVoM1A0cFdaYlpLc1lxVXgydDJ6?=
 =?utf-8?B?L1ZLbS9XOVNoa1NtYkZRVmNoMGFpR0ZSREJoNFZ4VjNWL00vOXNkTzl4Ri9l?=
 =?utf-8?B?Q0RiTDE3NUUvN0hpbEpKSC9NRHZWV01naHFjZ3BIOUpLOFNDMUtNKzZManlE?=
 =?utf-8?B?UzYxaTJwTEhqazgxdXp3aDJYRUhGSENrdnpmb1o2M3VUdXlSTFJSL1JUN3Bz?=
 =?utf-8?B?NnNUY1I2NWNDaVZ0SHZHN2dxSmNOa2pCck01TGZmYXZNeWRrTW5zSGU4VXRD?=
 =?utf-8?B?VmRGVmlXenJOTExYWCsyL1BLd0JTSHJlNktmQ0RoWjFuNlJZNW8rdDNjSEVF?=
 =?utf-8?B?TzRvYi9Dd2FjNU1JckYvYzhveDlYUUl0eVVrOEdueHFtRWJyeGwyZ0h0Zis5?=
 =?utf-8?B?U1JOSmVBZDAxbkhyaGh0U1p0dFAwNkdEOXpXcnJlQTkzeGNDK2tmWGdpSnQr?=
 =?utf-8?B?STJjZ2x0c2VhNjdyRWQ3ajZyWmVHSWJMN0dsamVoMTM2M3gxU3lIemtjN3NX?=
 =?utf-8?B?TnlkM2RIL2p5MmhKcmRERTJhR0pBdHdlSDdRbkxhRFVzVjhrVHdtcHQvK1VU?=
 =?utf-8?B?ZlMvb0oybksySFJ3Wm9RM2ZIWWNmU0hReUx3K0FKOHRvbmNwVzQ3REd0U2RS?=
 =?utf-8?B?UDhhQmhmbHFOQWlVRlZHRmxIZ0tZeTcyTHIwZmF2U3YvZ0kvZWR6UHRpVERH?=
 =?utf-8?B?RStwUnNGMlMvTDZ2NUdRekhuSldwL1ErUlFjOUZmYVhjbjFJY3dlUjN1VTUr?=
 =?utf-8?B?QUFMZG1ON3c1ZVA5MHR1RUhMMTFpaVVyaDY1WUhneS9SZC9QaDFIVGthOWNR?=
 =?utf-8?B?YTJXc3I5VFgxVllGa2FpUG5USTU4eFNTbXI0U3NTTXFPZCtFUjF5dW1td25P?=
 =?utf-8?B?ZlU4K2txNSs2SWdsMmVqdXVGaUJHeCs0UE44NEJLTHFxUW83NDUrN0dsQUk3?=
 =?utf-8?B?Wm9GMDVWb2VzcmZMakorR09GRUZjVERPd2lVU3BaT0xCRzZQMGVvcmtNZVRh?=
 =?utf-8?B?SHN3ME41SzN3Q3QyZmRadDlzenFURzkyVElxL3U5citvanpvS2NNK1JpYUU0?=
 =?utf-8?B?MFB1TVBOU0dyaENkekNlQi9FQ09vbVRPZ1ZTcDZwVEdHMHQrWFd6VnRUeDNR?=
 =?utf-8?B?N2RvY0syd29sQWliUm51NzF1Mk5KUnhJSmVPVm9EY1haQlNpSW56NTcyMGFh?=
 =?utf-8?B?aFhvSzlhYXZNd1N0Q0hTT1ZyTVd1Q2FBYU1lZUpBVDNFRkVYUTVIV21TcEto?=
 =?utf-8?B?OTR0OXJVbmJ1dng5TWQwaVI0cmZGT1pzWkpTSlFtUExaZWlQWjVxMU0wNUNT?=
 =?utf-8?B?aUU2Vy9VZWxkZGJtV1FzSGQvVmtJMStwZ2pKNDFkQXVZNnNraVBIT2FqUWJX?=
 =?utf-8?B?enppaDhjaWtrTjRvanJWVCs0cTR3MXgwdDlDZENEdktmZnJjejFRVklnK3Vi?=
 =?utf-8?B?V0o5UDRvcFRyN0FCcGRpZC9LYlVST1lhazRHSWNSN25qbDY5S0RkcXI5VVU4?=
 =?utf-8?B?NTRCL05makU1WGs5MU5zcFl6cXBVZXFYeldrTnZjbHFVS3ZFNjJyaXllRFVS?=
 =?utf-8?B?R2ZQVTY0RzhxSTQ5L1ZhOHBVY210UnVHZE1ZOUMxcnlZU1FFZEt2QzZYU21F?=
 =?utf-8?B?RGQzOGozcTdJOHo0bUJnaHB6Mk1RU3M5UkJlQ00xbWdLVjNYbFpQL2JOK0FB?=
 =?utf-8?B?dG1GZ0lRMWNXNFhtcHJ4OXBVbVZmcFJuMVpQbFVIeGlZMWtTNmFEQ2ZKVkFi?=
 =?utf-8?B?M2hNS1UyZXovaHppS0ZUZmNPWFo3NGg0RHJoQk5WYUJaK0xZNStyRHQ4UDNT?=
 =?utf-8?B?dHphNUxDazZ6cjAvVDRBZlJFRjV4djlONVpqb09rV2VtazNqU0dXRXk5eE9w?=
 =?utf-8?B?eXhwc0x4V1FicEI1TFJsTEE3a0t3QVBTNFlFWTMralI3QmJNdkRxajhzNUg1?=
 =?utf-8?B?K0RtaWpZTGRXalpzaVdRQWhFV2dya0tOTGh4Z3ZMU2RsVUNzSklwcGZnSCtz?=
 =?utf-8?B?a3VUcFNENkJaRmVROThjUzFBeUJtN1c4M1VyYWRpUjViUUtRRVRXRy9nV2Jp?=
 =?utf-8?B?WVZVOE5kR2FaS2QyQkhnWmo1eDhaVXNnNG44N3k4d1BLZ256R0N5dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35D6DDC91E7F1048B879B3BA22636FA2@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13462.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bdc00bf-f347-4ec7-c751-08decb4821f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 01:39:40.1153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zL2Bk34m1ge/q4jil8ZSW+n2zRtl90sjuUft3Ns/W0v8Xi+C+TpMmKA/l3xRHPkYD/JOKen5HIf41WaoSkpXIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB15707
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260615_183954_131320_7262A712 
X-CRM114-Status: GOOD (  18.84  )
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

T24gMjAyNi8wNi8xNiA4OjAzLCBUYW8gTGl1IHdyb3RlOg0KPiBIaSBTdGVwaGVuICYgS2F6dSwN
Cj4gDQo+IE9uIFR1ZSwgSnVuIDE2LCAyMDI2IGF0IDU6MTLigK9BTSBTdGVwaGVuIEJyZW5uYW4N
Cj4gPHN0ZXBoZW4ucy5icmVubmFuQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4NCj4+IEhBR0lPIEtB
WlVISVRPKOiQqeWwvuOAgOS4gOS7gSkgICA8ay1oYWdpby1hYkBuZWMuY29tPiB3cml0ZXM6DQo+
Pj4gT24gMjAyNi8wNC8xNCAxOToyNiwgVGFvIExpdSB3cm90ZToNCj4+Pg0KPj4+PiArc3RhdGlj
IGJvb2wgaW5pdF9rYWxsc3ltc19idGYodm9pZCkNCj4+Pj4gK3sNCj4+Pj4gKyAgICBpbnQgY291
bnQ7DQo+Pj4+ICsgICAgYm9vbCByZXQgPSBmYWxzZTsNCj4+Pj4gKyAgICAvKiBXZSB3aWxsIGxv
YWQgbW9kdWxlJ3MgYnRmL2thbGxzeW1zIG9uIGRlbWFuZCAqLw0KPj4+PiArICAgIGJvb2wgaW5p
dF9rc3ltc19tb2R1bGUgPSBmYWxzZTsNCj4+Pj4gKyAgICBib29sIGluaXRfa3R5cGVzX21vZHVs
ZSA9IGZhbHNlOw0KPj4+PiArDQo+Pj4+ICsgICAgaWYgKGNoZWNrX2tzeW1zX3JlcXVpcmVfbW9k
bmFtZSgidm1saW51eCIsICZjb3VudCkpIHsNCj4+Pg0KPj4+IFRoYW5rIHlvdSBmb3IgdGhlIGV4
cGxhbmF0aW9uIFsxXS4NCj4+Pg0KPj4+IHNvIHdoaWNoIGNvZGUgcGF0aCBhZGRzICJ2bWxpbnV4
IiB0byB0aGUgbW9kcyBhcnJheSBiZWZvcmUgdGhpcyBsaW5lPw0KPj4+IEkgY291bGQgbm90IGZp
bmQgaXQuDQo+Pg0KPj4gSGVsbG8gS2F6dSwNCj4+DQo+PiBJbiBrYWxsc3ltcy5jIGZyb20gcGF0
Y2ggMiwgdGhlcmUgaXMgdGhlIGxpbmU6DQo+PiAgICBJTklUX01PRF9TWU0odm1saW51eCwgX3N0
ZXh0KTsNCj4+IFRoaXMgYWRkcyBhIHN0cnVjdCBrc3ltX2luZm8gdG8gdGhlIG1haW4gbWFrZWR1
bXBmaWxlIGV4ZWN1dGFibGUncw0KPj4gYXJyYXksIHdoaWNoIHJlcXVlc3RzIHN5bWJvbCAiX3N0
ZXh0IiBmcm9tIHZtbGludXguDQo+Pg0KPj4gSW4ga2FsbHN5bXMuYyAiaW5pdF9rZXJuZWxfa2Fs
bHN5bXMoKSIsIGFnYWluIGZyb20gcGF0Y2ggMiwgdGhlIGZpcnN0DQo+PiBzdGVwIGlzIHRvIGNh
bGw6DQo+PiAgICAgcmVnaXN0ZXJfa3N5bV9zZWN0aW9uKChjaGFyICopX19zdGFydF9pbml0X2tz
eW1zLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAoY2hhciAqKV9fc3RvcF9pbml0X2tz
eW1zKSkNCj4+IFdoaWNoIGlzIGEgZnVuY3Rpb24gZ2VuZXJhdGVkIGJ5IHRoZSBtYWNybyBSRUdJ
U1RFUl9TRUNUSU9OKCkuIFRoZQ0KPj4gaW1wbGVtZW50YXRpb24gd2lsbCB1c2UgYWRkX2tzeW1f
bW9kbmFtZSgpIHdoZW5zIGl0IGVuY291bnRlcnMgdGhpcw0KPj4gc3ltYm9sLCBlbnN1cmluZyB0
aGF0ICJ2bWxpbnV4IiBpcyBwYXJ0IG9mIHRoZSBtb2RuYW1lIGFycmF5Lg0KPiANCj4gVGhhbmtz
IGZvciB0aGUgZGV0YWlsZWQgaW5mbywgeWVzLCBpdCBpcyBleGFjdGx5IGhvdyAidm1saW51eCIg
aXMNCj4gYWRkZWQgdG8gdGhlIGFycmF5Lg0KDQpobW0sIG1heWJlIEkgc3RpbGwgbWlzcmVhZCBp
dCB0aG91Z2guLg0KDQpUaGUgaW5pdF9rZXJuZWxfa2FsbHN5bXMoKSBpcyBjYWxsZWQgX2FmdGVy
XyBjaGVja19rc3ltc19yZXF1aXJlX21vZG5hbWUoKS4NCnNvIEkndmUgbWVhbnQgdGhhdCBpZiBu
byBleHRlbnNpb24gYWRkcyAidm1saW51eCIgdG8gdGhlIG1vZG5hbWUgYXJyYXksDQpubyBvbmUg
Y2FsbHMgaXQuICBpcyBpdCBvaz8NCg0KICAgICAgICAgaWYgKGNoZWNrX2tzeW1zX3JlcXVpcmVf
bW9kbmFtZSgidm1saW51eCIsICZjb3VudCkpIHsNCiAgICAgICAgICAgICAgICAgaWYgKCFpbml0
X2tlcm5lbF9rYWxsc3ltcygpKQ0KDQpUaGFua3MsDQpLYXp1DQoNCj4gDQo+Pg0KPj4gVGhhbmtz
LA0KPj4gU3RlcGhlbg0KPj4NCj4+PiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcva2V4ZWMv
Q0FPN2RCYlVhXzhIMGZlKzliVE5UUVdqTVZ5OXFDUGl1MGZvM2c4WGFtaURTX01yOGVBQG1haWwu
Z21haWwuY29tLw0KPj4+DQo+Pj4NCj4+Pj4gKw0KPj4+PiArYm9vbCBoYXNfZXh0ZW5zaW9uX2xv
YWRlZCh2b2lkKQ0KPj4+PiArew0KPj4+PiArICAgIHJldHVybiBleHRlbnNpb25fb3B0c19sZW4g
PiAwOw0KPj4+DQo+Pj4gSWYgYW4gZXh0ZW5zaW9uIGlzIHNraXBwZWQsIHRoaXMgbG9va3MgPiAw
IHdpdGggbm8gZXh0ZW50aW9uLg0KPj4+IGhhbmRsZV9jYnNfbGVuIGlzIGJldHRlcj8NCj4gDQo+
IFllYWgsIEkgYWdyZWUsIGBoYXNfZXh0ZW5zaW9uX2xvYWRlZCgpYCBzaG91bGQgYWxzbyBiZSB1
cGRhdGVkIHRvDQo+IGBoYXNfZXh0ZW5zaW9uX2NhbGxiYWNrKClgLiBJIHdpbGwgZml4IGl0IGlu
IHY2Lg0KPiANCj4gVGhhbmtzLA0KPiBUYW8gTGl1DQo+IA0KPj4+DQo+Pj4NCj4+PiBUaGFua3Ms
DQo+Pj4gS2F6dQ0KPj4=


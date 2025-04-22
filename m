Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D31BC369C2
	for <kexec@archiver.kernel.org>; Tue, 22 Apr 2025 08:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=coEkHFTWXEgo/CkGlfB6sJdAZaftHUarOAkRmkIXqYg=; b=1MQn6ADkgY3NXZkSggrO+FazF0
	vOP4ud0NrNploaY3b0wIbfU1Sbux9LkQDzERfiC0iK+Nbzq1PviEXnbRdl2oah40PUPkvzlfSjPqJ
	hC+75dcx46V8LxzYgMMC5l+tSa7W130rngwOtVVIY0TuQ6NfsMVXID+XpLZPKRuQuR6eO3FpqVth/
	wFY7YLhN516/VKXFr/BtXu4UWST3T3liSiGL+0z3I7fJDXGv7oxqg7IePEyuSrkNOtk5va2/DTqhx
	dvYuFiD7uS9YVFsUODsCv6E4Cs1FTmc58oUcel5OO8OgJD6m5KEUyMW0pPzxkia5ApI4mU9RtfA9L
	WfY39rCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u79BM-00000006O0G-1quM;
	Tue, 22 Apr 2025 08:40:44 +0000
Received: from mail-japanwestazlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c406::1] helo=OS0P286CU011.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u78XN-00000006D5j-1Ql6
	for kexec@lists.infradead.org;
	Tue, 22 Apr 2025 07:59:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/yQTIyLviNK35+NbXJ6uTzeff5fuqRx7A4m53aK98q5Y184OJUPzTviwgvh5UTIBWjTc6BaalGr0cv98S2Pzj43n8t1BZ1+slkbn5xe9bSV81/PqU1MG++O9EDEdzJBVORH2h7UAbB+GYbbAw2MQN06KViR8icyle6MIwx8O1LzcckZwtTAxI9ZBnDiG2rQYXyxKuE7rvfly2Pb+CyL2ISJIWNvdy9famZwtG2Qe1rZZAGiie9aOiXALvoO6788nsHeZDCrUC4IyJKfHGanqhKgXO/u/D6S+MxwaCKod93I8X7n2/Z9PILiDsutOw3g16qF+fpMausVmQ7gymPuDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coEkHFTWXEgo/CkGlfB6sJdAZaftHUarOAkRmkIXqYg=;
 b=VOWxzbfuhs57akr7RAOexjRWFGiTvZZCLMzFdmwX6DjJlpiz6Z8jhbyIWWBsOjan+cVyymRmSsFMIKoDC/URl2rFPsNCneN3b8LjOSLe8dgoNib83VXlXABjbV0zkKnP11vS5Z66mXghJzqi0deLaIl8F3eUHd0nJjdOb4hp0muboKuv7d8j9Mo5eqc1+kfdktDMI1CbU5XswDquQrQha9/XsG2wzPeg6EDodzhMxi3XIOCtsJ2PHsOalGyvyRgx2QEtS8wsLOoLS8iSXa/oEXE9GRFVYK5oxJ1VtTC984AocNNn51UYzA8uUIX3mGBrSh7YYx1x8+cZK3ha75htsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coEkHFTWXEgo/CkGlfB6sJdAZaftHUarOAkRmkIXqYg=;
 b=WOS0Ac/O+OKqSKorVKLz9pXRoAXUQRjzxz7Zn6FBFvAHtFlI2+cgW2xSezb0LDsuNeGSGkFfBg2wPWlvYT6N03kBoH0nFtfwu3Xhoqh4nl8t8NhOWKVqWTevQR8lIBf1VpIYhSPXmNyJw8ea79RwIqCLSzag1xrpLlLV1QV/RUwBVivpR7U8FVC7lHUGhVAGAT5oe9pBVlZNrpyBuA1CMulz5SaM2M2NUpWYVMWWDgKRUrL2xlU6JpTaSc1asjVHeGKZ8OQcgS2ZzzmTKWAtePKmNX7JPpiMg+xpmlvw9mjTthoyZxo7DBOHtb6A2WDWujameH1vWEV2ITcPH+bqFQ==
Received: from TY3PR01MB11475.jpnprd01.prod.outlook.com
 (2603:1096:400:40d::13) by TYWPR01MB8283.jpnprd01.prod.outlook.com
 (2603:1096:400:164::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Tue, 22 Apr
 2025 07:58:46 +0000
Received: from TY3PR01MB11475.jpnprd01.prod.outlook.com
 ([fe80::dc98:76b8:3a3:fcec]) by TY3PR01MB11475.jpnprd01.prod.outlook.com
 ([fe80::dc98:76b8:3a3:fcec%7]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 07:58:46 +0000
From: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: [ANNOUNCE] makedumpfile 1.7.7
Thread-Topic: [ANNOUNCE] makedumpfile 1.7.7
Thread-Index: AQHbs1xfAxkovfKrGk+2M2BL7v/YsQ==
Date: Tue, 22 Apr 2025 07:58:46 +0000
Message-ID: <0e3945ff-e224-49b2-b122-0c0290d00b74@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11475:EE_|TYWPR01MB8283:EE_
x-ms-office365-filtering-correlation-id: 90d8f2d1-6086-4b8d-01eb-08dd8173821c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SlFJZVA5MkxpSGVCK0tTWFJIdm5KYmJ3NmR0NDFQUlI0SEphNjlpZUFCNFl4?=
 =?utf-8?B?bGhsckhKUzBpUFV0Qm9NamExaENhQ0hjQmE1SkxJemJWRnc2bkpRa0JWcUg5?=
 =?utf-8?B?OUFHcUF5L3VnTEM3TmFCSXZwQW8zNUN1TmwyV1dJZG1JejJ3ZFgvMjUrSXM2?=
 =?utf-8?B?TWZFZU9kVURhejNNMGtnVi96MEhmTUIzb3lkRENPNkpkS2FhU3EyZkE1dHN3?=
 =?utf-8?B?YkgvWHBxemNkL3I2QXJST2xtQitKejgrR3VyV21wTzhsd1NEdnNGOS84OUh5?=
 =?utf-8?B?WjdmRUtrQlV6ZHBsK1Bmdyt5TlAwQUg1cXgwdFdwdEtRQ0xoNXh2TVNkVUZR?=
 =?utf-8?B?clFXWTRUaUNucGY3TGwxVGV6b0lsSEFOMlFwTEw0ZTduRVFHK1Z6cFQ4T0tw?=
 =?utf-8?B?b3JDYVorTXFWeVArQ0ZsUHd5TzFkMHpiQXZZWmZqZ3p4MjUxTkl5Ti91K21R?=
 =?utf-8?B?czBCOVNUdkw3TDNxa290YWRSMzdVUjZ1WUhGVVBGK3pkU0s4YU11Y1I0U3Ay?=
 =?utf-8?B?azVydEMxd2pGMG9Xdlk1Y0tkQk1taGl6SlowY2lpRlFaNW92RGd4dy9yQzFV?=
 =?utf-8?B?QU02MHJmOGpaQ2FzaEp0N3F0SXhVTHZUR0RNL0xZdjdIOWFtUENKL0YwUHRF?=
 =?utf-8?B?aU9jQURtekdPU3Jzdm55bWxtdkF1TWFPV0hDOUl6UTBQQjJzbjdCMGZpOUJY?=
 =?utf-8?B?dnQ4bE8rMytKNzJEK01aZkhTaXdCcTFPZ1A1WDc5eVphSVkwMW93VThTN3Fo?=
 =?utf-8?B?bzlRWVBReXFRZU9BRHVMTEZoSE1iYk1Kc3JVWlpkWDRkWG8vWlowK0xUYmpF?=
 =?utf-8?B?cTlWbVVGWTBGaWQwUnhydVFmWVZUcUphNlRIM2NubjJtenB4UEVyOFJWcjFp?=
 =?utf-8?B?U0x1SWF6YTBBNnYwdFV4RitXa0w2YVVhT2xmM2MyWUpLeU5ZMnNNdHRJdEE3?=
 =?utf-8?B?RmhrejNEQ2YwRHBQelQ1SmJJaDJtd2hWclUyRU9scm9aRGREV1FwZlJqdzVr?=
 =?utf-8?B?MVNWMjFGYnZHZzNQdzVZUExLTjJGY1NHUkxnbE9yQlBmYTdMRHZ0SGJId2Jy?=
 =?utf-8?B?bDdvSnMreDkzRXlvY2xvaGtxR0RwbnNLZXcvOFhjNm04cnBRNUJiRzdxenZw?=
 =?utf-8?B?bXUwREx0bjcxUStQN0lVUHVTZ2kyc09odTJCRTRMcGU4V253aVF0L0xjd1hw?=
 =?utf-8?B?T2dhSjBjcjIvbjl0ZnVnQzR2WXhJWmJROVhDU2RmUWtpUkppNjl2TDhORTFn?=
 =?utf-8?B?OERkQms3UDlFbTZPcUJTRWNBZ2Z2dStsc292MGZON05Nb3BLS2E3TThQTkVR?=
 =?utf-8?B?Q3NIZU8wWXh5WHFxNi96bUdqdkxaa2FPVktBbUh5TzVPbXZlTDY5d0dMRzNJ?=
 =?utf-8?B?NGJyR05RQlBuamlCYWx6MFlQejNvYzFHZzZDMk1HQVZhdDE2Rm5TR01pL2Iy?=
 =?utf-8?B?eEZxUitaNnJubm52TVppdHlBNWN5UVpFcUdnTlVBMWw2ZTV3NVV0dC91dWRY?=
 =?utf-8?B?QWpieXB4YnFvNDJzTTN5U2p4b1BhM1lWbnpwek1tTFpQeGZXR09VdE1BRWp5?=
 =?utf-8?B?dmZZeGhhWktIZUJCM2ZJQ3l6MVFYbHJzYXNhSk9CS082YjIwMkJhNGNwSXhB?=
 =?utf-8?B?Z2FmMFR3MGtXSTM2QXpUanhvM1hXbVo0VTJjVUlzZStxakFscm1rL1oycVBW?=
 =?utf-8?B?WkRFLzhXUkI5b0l3S3hRUTlGcmZCNjI0WmEwV1VlVkRiSURKZTFEQ0VRZTRZ?=
 =?utf-8?B?a0NDVnl0TlRiUlZuWUwrOWhBdEJ5Znk3Y2x0NnVnSUlPNUdjTHZNajlybDBV?=
 =?utf-8?B?bWRSLysrTEpuaE9PUTlzVzVQOEFVVENuU1VUbC8yeE8rQmozeUQ1NFN6SVRC?=
 =?utf-8?B?V1BMRUZJMVJUc3FLL1lvb3pXYlJvUlp4NDZTVUVBUUJ1Njg2LzFleXIxQTdy?=
 =?utf-8?Q?i/pCcLG7rxioWVtTW77BElzzSogEihAH?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11475.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVNReDdYZUVTU3hyTTZoTm84MDdjRVM0WmhVdjBPWE9LL3BMaXhRQVlJRWwz?=
 =?utf-8?B?T3BDckJZSi9yTnMzdjluUHg2M3AyQndCMFdINW40NnQzd290TldPdDZnRkwv?=
 =?utf-8?B?bDBQUktWQUc1ZzYzTzNOMnlQMExOcXlHVmc2MEw0UE5mcTJVdnlIUmpaQjBG?=
 =?utf-8?B?N3dyNFFsVUR2VkRIU0lOUURySE1RWG9TWG9JTTlUNldnbzBkK1E0SCtFeEI1?=
 =?utf-8?B?Nk8vN1UrTUhNVUJOMVRPOTZBSjBRSVhYZTA2cDBKRVhEaHNkd09WWmRiMDIv?=
 =?utf-8?B?UFdjcmt5N0VFcG9UN3V1V1J0alEyYXFyN0p5UXFDQ2RVazV1YXRQczBYcmVm?=
 =?utf-8?B?MHJCaXFMNUo0Y0hjQnVDUmVnTExua2lQMFBoVG5vbFF4YnllTmh1czhRMkph?=
 =?utf-8?B?K0FUcU0yZkRQajd5OFA4bnhhN1p6ZXpEV3N3alpuSXFBUVpqQzlmc0JmZmFr?=
 =?utf-8?B?azB2WjRaYkNIV09zWWNIRm9HdVY5ZXJMZUswcWJ5RGY2SUs1bklCSXpFdUg3?=
 =?utf-8?B?eU84NnJkN2VrWEFzbGhHUzlYU3ZUeW5OeWdmV0ZLM2ZjVDBYb0diWGxPeGlC?=
 =?utf-8?B?UllTR0ttUkkwSU51YXVJVVpSNHJmQTI4ZTFla24xNWVtbURaamtnWERsUWly?=
 =?utf-8?B?cURqOXFIMTgxN1hNaHl5R3pOa0lwZHVuZjhQNGJPS3pzM0NWY0ppQklGY1ZF?=
 =?utf-8?B?a1NjY2h1UWh6NUg1YWExMzBVbjVsa2FaNkhUNjlPZER2RGZOdUZUYVhSVkFC?=
 =?utf-8?B?YjJIRWlveThHSm9FWUM2VlFkd0l4aEdTQ2tNbFVjclVYbEJoN0pCSnVCV2x3?=
 =?utf-8?B?bGFvcnJhYy8vY2E4OUVsaHRZUmIzMktXcWw2K0t0ZEl4SWlRMUFvZXZoZ0VY?=
 =?utf-8?B?RGJ5bDExeVl1dTVoS05vejZJd3UrWDZSVWgyZ08zVnYrRkoyS3pHaFR3SHRL?=
 =?utf-8?B?L3hhNUErdnpKcFAvYXRLaGZNd2JXSy90VHEvVCs3TTZNS3FTUHQyUHJ0WWx2?=
 =?utf-8?B?T0tEbjFEVVVBOXFDMzA4SWZ5T0JCVmhYYTlrTHNEQmJWSHY2bURRWFlBa2xS?=
 =?utf-8?B?c2l6dnVrSlUxYUxPUGNmdDB5ZnBZelZEN1VRZEpQTFo2UWlZWEtCWnNyTXZv?=
 =?utf-8?B?RDM5MGpyOVd3K2xDQTFwUEI0VzBzK1JEUUlRWGNZVWNGTG9OZWw2Y2tRc2pV?=
 =?utf-8?B?SFZvQVRYT3N1UVN3Z2EyejdvS2NvelF6VUNBd3R2aW1NNWw1Mko0RXdqaUpV?=
 =?utf-8?B?dHFTaU5wZ29iaGlJRmRUVWxCOXlOVmhMZjVnNnFUQ0JFSW9CazBMWWVNOEhl?=
 =?utf-8?B?aFBlenp4bTQxUlRrU1A1OGxWVUkzc05DcFF2VEpjcldXWWRLckxWdUZsaFNF?=
 =?utf-8?B?NDJBeURlL2JBN3R5VENVT3NweXJNUWcxeDJvQ3luenA1c1JiSnljd1NZdytQ?=
 =?utf-8?B?T3NFcVZvT0ZUWnY4allnNmdqRTVZSnJyLy9tSXUycW1udzRoeFlqY0w3R2sx?=
 =?utf-8?B?SWMrY2t5dC9jRS9jU0kyeG01RmlpZXlWU1V1R28yMWlVWmxoQk45dmRIRTQr?=
 =?utf-8?B?VGFRNmZEZ2hQZXhpL1JJZXZwaFpsRWxGRGJnQjRHUUF5YkszbGI3cmh6bU1r?=
 =?utf-8?B?blNNSjF0Ykd5ZEtZVllKZ2JtZkZFNFppMlBXK0NRRFhEU0NDS2l3eExOZE02?=
 =?utf-8?B?MmVWU25pNmpTcDNSQWtoeXlnbUhlNllQZGd6Y2ZwZkFaRCtSNi83VGZ1czlH?=
 =?utf-8?B?U1VjWThpajVKSEZIL3ZNMjlXN2lkY08vQnJJZFVnYm11bElKT1ZDdU8zKzlr?=
 =?utf-8?B?amVGVXp4cVBlVUlMQWZ2dVpKTXZWWEJCaU1ITkNtdVlwbGRXaE9uVE5WY1c5?=
 =?utf-8?B?ZjVPbVA4dFlRK3grOGFyTUdEMW93SUx3L1pHZnNXWUxRai9maWZ5Y09meFVS?=
 =?utf-8?B?WjgyZU9NQVdxdUZmTmxqVnpMRmdzblp5Szd5R2dCTG96b3A4eWdLYitBeFkz?=
 =?utf-8?B?b1duQzI3WjRUMElwVllYN3VmbFBTeGNoa1d5c1hROER0emdlZzVOYWRwWEcz?=
 =?utf-8?B?ODNzVFNYYVVkSXo0ZjFnVStDT2duRVhzY3MxcTlZZ0M3OG1EYW1xbUhaN0VE?=
 =?utf-8?B?dUNEMlkyVzQ1NHFxMHo5bytGZEJQbWxHVnNMU3RDVlZKWGRSUVBwMStOSlZD?=
 =?utf-8?B?MFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B219AEED954124FA348E4EA4AB37172@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11475.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d8f2d1-6086-4b8d-01eb-08dd8173821c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 07:58:46.0338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q7N3ao3iaoeDAuwD7iRs9zRVuNY8t5Nm7JTmHrAcer/mQUyW2IjBZwSGB6d3+0bxffOqsMSBtR0FDxakjH5AlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8283
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_005925_531912_73548DC7 
X-CRM114-Status: UNSURE (   7.15  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

SGksDQoNCldlJ3JlIHBsZWFzZWQgdG8gYW5ub3VuY2UgdGhlIHJlbGVhc2Ugb2YgbWFrZWR1bXBm
aWxlIDEuNy43Lg0KVGhhbmsgeW91IGV2ZXJ5b25lIGZvciB5b3VyIGhlbHAgdG8gbWFpbnRhaW4g
dGhlIHRvb2wuDQoNCkRvd25sb2FkOg0KVGhlIGxhdGVzdCBtYWtlZHVtcGZpbGUgY2FuIGJlIGRv
d25sb2FkZWQgZnJvbSB0aGUgZm9sbG93aW5nIHBhZ2UuDQogwqDCoMKgwqAgaHR0cHM6Ly9naXRo
dWIuY29tL21ha2VkdW1wZmlsZS9tYWtlZHVtcGZpbGUvcmVsZWFzZXMNCg0KTmV3IGZlYXR1cmVz
Og0KLSBTdXBwb3J0IGZvciBrZXJuZWxzIHVwIHRvIHY2LjE0ICh4ODZfNjQpDQoNCkNvbW1pdHMg
c2luY2UgMS43LjY6DQplNGFlNmI1IFt2MS43LjddIFVwZGF0ZSB2ZXJzaW9uIChZQU1BWkFLSSBN
YXNhbWl0c3UpDQo3M2U2MmEwIFtQQVRDSF0gZml4IGdjYy0xNSBjb21waWxpbmcgZXJyb3I6IHRv
byBtYW55IGFyZ3VtZW50cyB0byANCmZ1bmN0aW9uIGVwcGljX2luaXQgKENvaWJ5IFh1KQ0KYTlj
ZjRkYSBbUEFUQ0hdIEltcHJvdmUgbWVzc2FnZSByZWFkYWJpbGl0eSBhbmQgZml4IHR5cG9zIChT
ZWlqaSBOaXNoaWthd2EpDQo3MmMzNDE0IFtQQVRDSF0gZml4IGRldGVjdGlvbiBvZiB0eXBlZCAo
Y29tcG91bmQpIHBhZ2VzIChMaW51eCA2LjEyKSANCihEYXZpZCBIaWxkZW5icmFuZCkNCmE1YjNh
NjAgW1BBVENIXSBNYXJrIHN0YXJ0IG9mIDEuNy43IGRldmVsb3BtZW50IHBoYXNlIHdpdGggdmVy
c2lvbiANCjEuNy42KysgKEthenVoaXRvIEhhZ2lvKQ0KDQpEZXNjcmlwdGlvbiBvZiBtYWtlZHVt
cGZpbGU6DQpUaGUgbWFrZWR1bXBmaWxlIGlzIGEgdG9vbCBmb3IgY3JlYXRpbmcgYSBkdW1wZmls
ZSBmcm9tIC9wcm9jL3ZtY29yZQ0Kd2l0aCBmaWx0ZXJpbmcgb3V0IHVubmVjZXNzYXJ5IHBhZ2Vz
IGZvciBhbmFseXNpcyBhbmQgY29tcHJlc3NpbmcgdGhlDQpyZW1haW5pbmcgcGFnZXMsIHRvIHNo
b3J0ZW4gdGhlIHNpemUgb2YgdGhlIGR1bXBmaWxlIGFuZCB0aGUgdGltZSBvZg0KY3JlYXRpbmcg
aXQuDQpodHRwczovL2dpdGh1Yi5jb20vbWFrZWR1bXBmaWxlL21ha2VkdW1wZmlsZQ0KDQpUaGFu
a3MsDQpNYXNhDQo=


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E76CDB46B
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 05:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0SsI6VZd6FOpEeADCyFceIDCGKeKUM4g7+C0xQhOsSc=; b=kkQgf0Gxdpbd4ckn42lEiZZHp3
	BzKH8x/vz/zj17PxRGZp7RQYQ3qf7wo7gdt6pOK+XJSLduiRul1CrRsSYwGIm/woQCB0YyzXif5UT
	XRBAwhSmWrbxNhBDEAFlf//H6rhJgnxl0K7zfPqfHNliUHorrtOUFhmttYnybu5mlydESwa7VTJMt
	/98zLRb5Ie2g50BomsjRA6lGEjjIhNRE1EhZ+XI5CR0EAC+vJZhrUV0y1j7tqK4obr5Y4RwZnuo+u
	9mkMl6CT/VZ1w8WqcH5ECSm9qzXQRF/2/7II6+tzijDqfGTJdkCSV6kGnfZy3ULQPIcER/bPmNNvE
	6PIb4fyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbX3k-00000004RAS-0SDk;
	Mon, 22 Jun 2026 05:19:00 +0000
Received: from mail-japaneastazon11010001.outbound.protection.outlook.com ([52.101.229.1] helo=TY3P286CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbX3g-00000004R9j-1nrc
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 05:18:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLikxfWO904mV7dvVZx1K3+FF/SWPcMAVS4gBnbBtjZWFe3pdY/xdw5wwzJL6YY45lb+hX+bqw+vREOs/InNPDyggsLFHenDqXczMvwkhqFP4C9W6hd9sZiEqWv4K3X0ckHfvRO9BkN879eLe/TcJXouckRU1hRh8GT5s4XEUBmGavxlKa5IGqpMMUf4S5XsJPBClND3SdqQLyYcBOzoMaloLYP+5KQ/TuaiVQyxA7JiR4DPtSviwfKE3a5uEoGf1svqOVfo7IVMwWi7Pbv1bLTn6z5nnmJi+63wT2AB1vM4p1N5cEd4H8tz9R+8yujvmlOTeVCx4ZKH5KaJqh9WCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SsI6VZd6FOpEeADCyFceIDCGKeKUM4g7+C0xQhOsSc=;
 b=gDe07Ydt4MwW472E8OrUEAYkFrxclF5V5aXHtD9QCVPsZ/G/ho2ZyvNXge+fgROZEQBPLBj11289RpBuUeXOnlrzR54LzPwrf0f6vdjljnQnoyboQxcsErE71hw45zKunmXq6L2B/tiHu5iN1PNHwx/k88dSPf1ZrJs0gwcLKei0LmfMZ8NgUdxZDOOaUQMYLHebxMsJVGVJMHTW8IvQlLvoMvy4eMbYAuaz6DCEdxn1CbPlf5A2oJTO/MkV9SOtiJdt2fJ0VD/Jn2XSFMg/Cngsxc36oWUAC0X7o/Dg4kLCtXvUNorLjcyXfMvY2rWrflGcu/Y4vdt56YpiBUAwuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SsI6VZd6FOpEeADCyFceIDCGKeKUM4g7+C0xQhOsSc=;
 b=bOmW9w0WtaW68KrjsSltxLZuT1rNmfcrBtICLUqjWg5I2oSFpwjvRZ7H7RHbO/kYapQhfgjCGMjsTfOmr3gu4qbXnmAH5A5htAKehk4U1nn4ACsQqn9IMIqu3b1YGSnc2cfQ/QPzgWkwn7Yld4AblQFQF863RY8rIkZ3ULGBynITczk4IRy7SWcj7qB032FIDO43btGDrkv1FjriBbqg7MuNWWSgxb0ouLKwxnLdM1Hcgzj0eQgO/qCsy7ATUixo6fojijE00eI53HTViRHGmjkK+i+hukPlJ7UVet9c8Xuy47bw+KvxKO3yJPul9Ym6Sd3Hxrt0pJhhYcbFzbEYUQ==
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 (2603:1096:405:1d7::13) by TYRPR01MB16474.jpnprd01.prod.outlook.com
 (2603:1096:405:2ee::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 05:18:40 +0000
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820]) by TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820%6]) with mapi id 15.21.0139.011; Mon, 22 Jun 2026
 05:18:40 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Tao Liu <ltao@redhat.com>
CC: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>, "stephen.s.brennan@oracle.com"
	<stephen.s.brennan@oracle.com>, "kjlx@templeofstupid.com"
	<kjlx@templeofstupid.com>
Subject: Re: [PATCH v6][makedumpfile 02/10] Implement kernel kallsyms
 resolving
Thread-Topic: [PATCH v6][makedumpfile 02/10] Implement kernel kallsyms
 resolving
Thread-Index: AQHc/hkE7HzQWhD0REqk0i1Yn5AMU7ZD/FgAgAAGXYCABg4dgA==
Date: Mon, 22 Jun 2026 05:18:40 +0000
Message-ID: <5bea5724-44b1-4a59-b58f-876960357c37@nec.com>
References: <20260617051834.95404-1-ltao@redhat.com>
 <20260617051834.95404-3-ltao@redhat.com>
 <30fe770e-286e-4272-bb7e-0e9ad01cecc5@nec.com>
 <CAO7dBbWUpZDRhKLG7XB7qcMONo-GuwBmhTZxnax+cNdmRYtU8g@mail.gmail.com>
In-Reply-To: <CAO7dBbWUpZDRhKLG7XB7qcMONo-GuwBmhTZxnax+cNdmRYtU8g@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB13462:EE_|TYRPR01MB16474:EE_
x-ms-office365-filtering-correlation-id: a639f91b-c442-49f7-d75a-08ded01db8b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|11063799006|4143699003|56012099006|38070700021;
x-microsoft-antispam-message-info: sw0TiUUYty/qD154aEg7j5E/64mhGMbaw2JSMSQvYDhV6LtwwHevOlCx3cqMTDnftVsfphrrp1aDDU1/0Pl+yD8vPUioTVgXDLW9Vp3hrren4Is22IsOl5OnJBtn7M+vgzDM1V499chO+Y6ZIuOWozEGklySmgCZDDXqHcxsSoWjByItpxbyhm3M39xod69OhALxJ+wSI1f8HGcqX+k7UKCeBqphqAapjcPTW+wY3RDg7MIt9/0ndOK5yAPZwAcDD4SXBifNIAt9efI0tmssUbRrpkdENAg5/DOe4x9+6zi8s0ggGWeH6pSjeuPDO/rh6MQ4kJ0iRV5svQRTj1CGFQ1tyLqLI3tGOVZUuas9NCLdPLEmp0QbflKkGxsmcEGE7A8CBX3GY/um/ntjszzUfseF2xi1wnYf1UT0kb6LfIyVXP00dKt6GyCRTZmWBX93bhZBXxv1GxIdRiveqwQ6BrjCc2Gt4QOgOJM+/+N+3rvVexE7jrlUQ9D7FUgcL2245HWRoU2KYAH7B241TuIgPIB5XmAsZIe2nLbnFis/3tbiBTspS81D2uydlT0xGW7nOIXVougqgA+Lc1rLN7OJWyHhtOOvPBiWZJovmtntEfmwUgn6ZqKCik3Qh8cYBdL1z6KFGfK+rDi8PRjvzGqBvS9sap75JREZIlwrDNbAieeggz04x2TZN7WkttVJI+4/YZMllG9Xz5gCF83D3+ziS2L4JMJ5vPP0yT23uevTw5g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB13462.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzkyaFh5UXcrZmFrbjNqbUFSN2Rva0tCNjFncGhJR0VUUFpSUXNuZVE4bWoy?=
 =?utf-8?B?dlRHcW5XbmVnUmR2L1RMQ0VxTjlOOTJtLzFOVnVCWE51S2hHdEdDdk5HZG1h?=
 =?utf-8?B?WTZHZXdsTWJwUUFKK3FEV1ZkdFpLb1FvMFdBZnhGVERmZVI1U3NrVjk5eGl2?=
 =?utf-8?B?S1ZNc1lGK0RNWHh3dUVhVkpsNFJLT3crWkQrelloeURNeEFXN0ZZSW1SK3Zz?=
 =?utf-8?B?L3FWMU4yQStNajd6K0xUQ2VuK3BkYTNad2t2ZmRqalVoYTdvck1Cc3FsUjNk?=
 =?utf-8?B?Q201WUxMQVpDMmUrMEsvZTd5UGhFemNUZVJUSWk3TjVXb2xibmxzdnA2NGNv?=
 =?utf-8?B?dTQ5WE4vUVY3QmFkM1VpYThJQmRqc1Jad0cwVUEwUTlOYTNwVFVkVkpRK2Qy?=
 =?utf-8?B?TFFBNUhZM28wMDdTOG0wYXc0SW9nQWkrY0NVcVhlbFIvWWJOcFFSL2todWdo?=
 =?utf-8?B?UXZaeW83WFI5NTlFSGxrZXBCR2h2aVlFUTJEeHJIVUhWMTdGczBHdytTc0g2?=
 =?utf-8?B?SlJhUVdjTkoxTy9ORWxhUlIvTmdnNGthdmRjSkl4blppOTRuWmRjL215Z0NV?=
 =?utf-8?B?cHRvNSt5QUI3TWF6bHZnaDJWcnpsQUpiUTBFcjQ4WVFOTXVhbWJxVmFKdE9r?=
 =?utf-8?B?N0VoWFZmWDRnNnRiUXV4Qi9rRk91UTFRNHhlTnEwUTdLRjN6NEhPNUhhQlVB?=
 =?utf-8?B?MFRHZ21SMXBrYS9LYm03cUlrTEQzd0w2cDNWTHIvOWFsNUVONHp2Q1d0VjNQ?=
 =?utf-8?B?SVFXdGZHZmhEa3kxY1c2RVFhOWduOUhzSWRjNUcrcFVkSjhrK2JHQk9NR2Zv?=
 =?utf-8?B?MU1QQUpVazRqZnF4Z1hxbTdscTNVd3c5YnNqdU5VT1VhL3lTTXVBcWc3bGk0?=
 =?utf-8?B?ak1TUEVMVEZORTIxUk9zNlpiNjFwN2FiOElJYUNzN21Ea3VJdjBhQXJnQkwy?=
 =?utf-8?B?elo4TGM5dVdPU3c3TlF6d2x4L0hSMDBSajlvTlJENy8zTmtyOUJRTDZiSDhM?=
 =?utf-8?B?ZjZ0YmI0YjBPdzNPMVNNUUZWUWFLckMxeU5iWGhUL3ZqUVU4cWhhZmFySGR4?=
 =?utf-8?B?bUowbGJ2b2ticUc5bFZHb0tXcHRkMjF4OU9kM3Bpb3FQVWpOT1p5dmpyRXNp?=
 =?utf-8?B?MkhWV1lRdHRUN1JyU2VFTlZBZzNBU2xOZGJ2UUh0Z0xxd1pjOTRLQWMzaDgw?=
 =?utf-8?B?SGlSTkFPaXFmOE1OZ2JPNDBuL3dlS1VnRmJ4NStFMVZwQkxPbGZVakhOK0NV?=
 =?utf-8?B?VXBXcDk0c1RRdmVZTDB5N2FiTXVmUk9nVmM3SU13dy9DREovbEhGTVNwV0Yr?=
 =?utf-8?B?dnp2K0tLMmIxRmpOQmx3OUxKNnVaazE1Qmp5ajhMbG9EblY0cHR2dzUzUDBX?=
 =?utf-8?B?YnduYXZVYWxqSWZvT1NSWHE2R2kraDFuTzN2RUxYSzRUWjFqV0lNMjc0aTlN?=
 =?utf-8?B?RGdwV29pL1loRXRuMzRNQWltS08yZkdZRDl0S2hCaGJkUDVtSUJteG5mRXJH?=
 =?utf-8?B?c0dTYTlXSzFldDVRSTRpMUpWNVM0cTlaL2RMZFdPaElROVJsNzE0WjlRMDRL?=
 =?utf-8?B?cktHOVYvb1ZERm5UM0xFdHZhZTh4VytlbkpXdnFUS2lhcmJGbFh3T2puYkJz?=
 =?utf-8?B?QXdWdDJkUll4RFFuUEZBemFSSVM3TUVocHRybXJreHkrSWFMUTVxa3dPTTNr?=
 =?utf-8?B?RWo2WVcvWE9vS1F1QUx4M1hKcVB3QzVmbytBdnlVSnNsWUYvN3lsRWN2K2g1?=
 =?utf-8?B?YWt0cnFNWDN0TnNTZ1M0WkpjQXhncExxb3dCQ2FOYVA4dW9UVmFrcFhtU1Vv?=
 =?utf-8?B?bE5ZTFRxcEp3V3dVdE11RWpXdUpVemEvOVdqcmRvT1JTb2dKUnV5SDFhZm44?=
 =?utf-8?B?Uks5cXVBUFRkMWtWYWtmU1ZXWnBlclBtVTlzNHVlV21UQ3A1UUtPQnpXdnF2?=
 =?utf-8?B?aTFQNkFmOTczc0t4dU9HT3A4RjkzMWFtd3YrdE44SnVhTXlSVDVvSDBvTFRI?=
 =?utf-8?B?WUVzcUVRN1cwdnJCUVhQeHp2bGxRd1ZPaVcrckJvc0RsdXBMS28rdEFsK04x?=
 =?utf-8?B?bWtZNVBKNElMTEp4MnpIRDI5SHhPQ3BQTUVXNVdIUnQ3SklXNnNVcGhrVmVh?=
 =?utf-8?B?TC8xbHNwWEJMQXo2NER0cGFaektyVkdpUUlkK0xCL216d05id2J1U2lBUGZ3?=
 =?utf-8?B?SDdYbjBJVDFpRFg1L1VZbHBsSjRPY2VqVXo3SmcyVWdqeURKWktRaFJZRU1I?=
 =?utf-8?B?SHhKQVVYMEtRbGx6dDAxKzkrbHN6WXE4dHRuak9rQ01OUzllTTgwdHFBbmJM?=
 =?utf-8?B?WHRkSUdjbVNlWFZJWlBrVklDVDl0Rlh3bkwwazVZUDhmTXBzOUp4QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F65439A1E212DC48A17CCCE3CE7EE81F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13462.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a639f91b-c442-49f7-d75a-08ded01db8b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 05:18:40.3946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tZ/1X96nfBGR490hVRC9CcYbdKwBVPRqjnZX9zPBSB9qcIfYaCiNL6Auu7KpMAmAKMTfWW0Dlzm1sPZRWaI/Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16474
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260621_221856_764333_8A32C83B 
X-CRM114-Status: UNSURE (   8.41  )
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

T24gMjAyNi8wNi8xOCAxNzo1MCwgVGFvIExpdSB3cm90ZToNCj4gSGkgS2F6dSwNCj4gDQo+IFll
cywgaXQgaXMgbmVlZGVkIGZvciByZWFsbG9jYXJyYXkoKSBpbiBrYWxsc3ltcy5jLiBGb3IgIm1h
bg0KPiByZWFsbG9jYXJyYXkiIGdpdmVzOg0KPiANCj4gICAgICAgICByZWFsbG9jYXJyYXkoKToN
Cj4gICAgICAgICAgICAgU2luY2UgZ2xpYmMgMi4yOToNCj4gICAgICAgICAgICAgICAgIF9ERUZB
VUxUX1NPVVJDRQ0KPiAgICAgICAgICAgICBnbGliYyAyLjI4IGFuZCBlYXJsaWVyOg0KPiAgICAg
ICAgICAgICAgICAgX0dOVV9TT1VSQ0UNCj4gDQo+IEZvciBnbGliYyA8PSAyLjI4LCB3ZSBuZWVk
IHRvIHVzZSBfR05VX1NPVVJDRSBpbiBvcmRlciB0byB1c2UNCj4gcmVhbGxvY2FycmF5KCkuIEUu
ZyBJIGNhbiBlbmNvdW50ZXIgdGhlIGNvbXBpbGluZyB3YXJuaW5nIGluIHJoZWw4DQo+IG9uY2Ug
cmVtb3ZlZC4NCg0KVGhhbmtzIGZvciB0aGUgaW5mby4gc28gbGV0J3Mga2VlcCBpdC4NCg0KVGhh
bmtzLA0KS2F6dQ==


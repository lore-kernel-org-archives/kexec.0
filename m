Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3880FC531CA
	for <kexec@archiver.kernel.org>; Thu, 23 Jul 2026 13:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+UnsMT8h/6tyFzY7Ccr880jPaPxiNpynvVUoI3JL+Tg=; b=ixHxnDhNMicJOC6TtFqRcqDn22
	GTILObjIwoMhtKsN4F2iBowCcgDWRAKe0gXSO+7KSeBJyrL3OJX5OE8QU2e4cO1R002Jp8QxfeAzB
	RGTnM6kLX31jNNDJL1+7I26m8TdJ1oeXlf3IWqHw2p82/+xNV1/Dekq/hi/8dBZ4YP3YnEnBjKPLc
	SylCwRXe/yM8UfVfN2H4S0lCG8DDLdlI4F4IX6gnulj/qOsVw5ouqxxgixCbl/s+L65rlEgiVKryi
	wObrjFCzCBNBund6hOTE1UqlcSkla2XjbjU9JRKfm3ponOjB8aEyb9qh/G8faxvNeGEAeUpojfxBx
	Lw5ZnD7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmt7D-0000000EK4l-48Qk;
	Thu, 23 Jul 2026 13:05:31 +0000
Received: from mail-northeuropeazon11012004.outbound.protection.outlook.com ([52.101.66.4] helo=DUZPR83CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmt7A-0000000EK2Q-2QRS;
	Thu, 23 Jul 2026 13:05:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKZH4BtQJE7waV0qIrbumiqtuvupxACG5wlSW8S9iJPXZQHQOFst3giSX1rRAq/RymgODrbaaUInTnaxgRRrqHbFCdSEsvCNsLqr1SjNmvD3ragZMDhcJyEvTq19qxIBgLP+HfCDoD4v9z3G+MYSfqgpuhosxsDA7FYij90DSTf0Yxgf2X5RO8p7LX+irC/4R2J2pxIdBvVSS5cHFhGz8peIVkoxxoPpzNv8hWU8Op00ZoxF5xc3aNaVkIaqprO/21Sjhe01vooirGCY/7WMLpybbXnYsgaHMjJKFWGlE9JwQ4PIq3vvXNa/A/KKaP1RhHAAXVdyqADuApxhxKwjog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UnsMT8h/6tyFzY7Ccr880jPaPxiNpynvVUoI3JL+Tg=;
 b=B+6Oo8PPpwZSj6pbmBirfaQdXJdQyrqsxTslWkEHZTzj4hU6r2KfwiteLEVcWOcGMN8ls8CMoY+BtdwVX7gKkJcdBhGqDs/+7g7G2oeet9RCtjVvmT35VDugDjwLbwNtuWGtORPF6l8xNGf+M7EVisOvP1CVWcKYHMcllSPtOhkRbWq1Cg/edDbiXYK8Oiw1Cxhb6GfmtRLlTNG5fdRnBuZIWMD7+owFVAC+QmtJXm/jbnb1aDNd44LlZO19SPyci56ppYEPTdme2TjeMBtxEToGOFZ3JZw3Y98Jg2HnZXU3BXtE+G9Ww6crVPvP3aAB5GIfIP9qJoawkyg8r4JY+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mobileye.com; dmarc=pass action=none header.from=mobileye.com;
 dkim=pass header.d=mobileye.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mobileye.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UnsMT8h/6tyFzY7Ccr880jPaPxiNpynvVUoI3JL+Tg=;
 b=PdiA5RQZbPawJiV4ZXFyu7vBcINZ+FTwC/Dw4BpUpJQonFEQf+GdSEWu1vhXg0RSvtx1S5Cth9ismhEmsWQnWzNr+VPJ1qpCYodOdeVILuJmik+LCdwXTXbDYuvhYtKDWZrqjioVUiWA6yimTGMSH7O+gCWlSScz8yWnVGyaqgM=
Received: from MRWPR09MB8022.eurprd09.prod.outlook.com (2603:10a6:501:73::11)
 by PAXPR09MB5559.eurprd09.prod.outlook.com (2603:10a6:102:283::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 13:05:21 +0000
Received: from MRWPR09MB8022.eurprd09.prod.outlook.com
 ([fe80::8c7f:5e18:242a:808]) by MRWPR09MB8022.eurprd09.prod.outlook.com
 ([fe80::8c7f:5e18:242a:808%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 13:05:20 +0000
From: Pnina Feder <PNINA.FEDER@mobileye.com>
To: Baoquan He <baoquan.he@linux.dev>, Omar Sandoval <osandov@osandov.com>
CC: Mike Rapoport <rppt@kernel.org>, Simon Horman <horms@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Dave
 Young <ruirui.yang@linux.dev>, Jonathan Corbet <corbet@lwn.net>, Alexandre
 Ghiti <alex@ghiti.fr>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org"
	<linux-mips@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-debuggers@vger.kernel.org"
	<linux-debuggers@vger.kernel.org>, Vladimir Kondratiev
	<Vladimir.Kondratiev@mobileye.com>, Gregory Greenman
	<Gregory.Greenman@mobileye.com>
Subject: RE: [PATCH 0/4] vmcore-tasks: export per-task metadata to vmcoreinfo
Thread-Topic: [PATCH 0/4] vmcore-tasks: export per-task metadata to vmcoreinfo
Thread-Index: AQHdAowiUUNg/VdmVUGNCCpKQdHgMrZhrLsAgBSf5YCAADjtgIAAINaAgAAw44CAATYrgIADMh0Q
Date: Thu, 23 Jul 2026 13:05:20 +0000
Message-ID: <MRWPR09MB802232B51C8299CF750B14978FC02@MRWPR09MB8022.eurprd09.prod.outlook.com>
References: <20260622211430.4008899-1-pnina.feder@mobileye.com>
 <akybBoCAm-kJbfHL@kernel.org> <20260720091927.GA1736709@horms.kernel.org>
 <al4X300UObXawEIJ@kernel.org> <al4yeHrkDHFoo6A0@MiWiFi-R3L-srv>
 <al5cbYMD18UbKe-6@telecaster> <al9gnbT5S0ALDieg@MiWiFi-R3L-srv>
In-Reply-To: <al9gnbT5S0ALDieg@MiWiFi-R3L-srv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mobileye.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRWPR09MB8022:EE_|PAXPR09MB5559:EE_
x-ms-office365-filtering-correlation-id: 4ab3963b-3e3b-40b3-b868-08dee8bb0cfb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|38070700021|3023799007|4143699003|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info: bozKyahZcKMY7to3e61XlpINsiAmim7mZV2bxyeXxRnIdZg5p5jQxXwz+B/pU/QQwbTqFpvq8FERStzf754TZhuIXvfsviTHf71FgO6FjgZpzmcc+bl8J+2qpZGdP9ThtKum0Tw1WuV12NYoFrDN0pFS8it1frlI+wIZBlZyxb1QA3xaeoBwuDoWU3CVjK4c9FzJzOA7QpzRfuL1qxRrDrDSs5otgWLgX1WYQO6tjOKaITW4/r3yPOAFmrEb+9tuAGn2nvXo16NDxMikB34fJn3BGkowDfMOsUS1Tbl4GrJhg+B106y6AiBAtAzh8Lg7FNd4OmMJ9A2odYixwXU702/zBT0MyO1s/02aBmcdggWHDSs6+qK1ZOaj+W+xVT1sn7ELaFQ9BTYQw9tN0XNI5m1xpQexe9J0bTMmgx7TdttWABrl8hRzddBl0AdoTFRuAfEiV3NXZLCqCmlTNxDTOfR250nZfeOrHw27OIkoPjfi+/wi1MLOOeDpXUykaUccx0ZDVIu7VykkD9HW1L3gIos0CrymZgSpOjBdyXAPCpp+XK5oa2nitwCDju/jQy86yCmSswDlbdANS4qUhV29aj06xeEkeA+kckliy9zBzq+Kuue41zgsOnp9cFVizYcbAIOCbxHDm75T6PV0/hIVlK+lvFaB1c0LLLShjPdvxDCWWyky1lSrpTSRsw0xn7W4TuH/oBzgs5G3Un6VGgfkkJYZUwm6rUXkTKg+2O0iyAU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR09MB8022.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(38070700021)(3023799007)(4143699003)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTNmR1daUDZoN3RMbVVOcUtCZWFSNjdUcDUyeG50Y3V3SXpzUGJORm1aMzNu?=
 =?utf-8?B?OXVUa0NJdkdRQTJFK2NtK0FVNFhKb1k0dTlGT3JRcUkyY0FrQncyV0FETmFv?=
 =?utf-8?B?Sk5BV0p3QStiVG5KZTNac3NOVm53ZEcwbkoxSWdtUTRUSENNbk5sTXhndDFP?=
 =?utf-8?B?WlRmT0pQdFlsZEI0cE1kclNMVmdLMU82RERvK0M2Vk9ka2h2clZmRldrZkRp?=
 =?utf-8?B?MUdsRDFETlFkQ3p6VzRndllmZE9IeTliM3phakRBWDdhL3Z1US95VVlYWDAr?=
 =?utf-8?B?WWVFNzUvZEhRaWVEODg0SG03Tk41bEZCNmZyRm1zQy9qTHZIWnRrM2FpODlV?=
 =?utf-8?B?NGsvT3RoRW5pemdGYjdJZ0g0cGo4NW9kZWw0YTdJekxTcThxbHJBMDlwVDZJ?=
 =?utf-8?B?dzVQWDkvYTAxM0RxZk5MWVc5YWpjY0lIakk5VG1idFhqYnpDTVFwRGxFekZv?=
 =?utf-8?B?YjJmeVd1Um9vOFBOMDloWmREYjlpamZEcjRORlNpZC9uQ2pJU1RlRlY1c2Qy?=
 =?utf-8?B?M0o4dG9FeEtRa3A3bEZzWXVDZHZWaGRjTjk5WVpzQXo5cWVNdWpBMVBIU1VE?=
 =?utf-8?B?VjBBemxQSWhDUXh3TDFQZC9TSHovblF2ZWpoNW0zQWkzMUtKTHY0TjNzWThQ?=
 =?utf-8?B?ZnIrMVRuKzBKNndpQU5jNThXWXVYMENLUlZrV1JEMmNBdlcxSEpxVGRrekZw?=
 =?utf-8?B?NG5oN3kvVWVkWnBXYmpMbmVLZnIyaDhiOFU1Y1AxN21tSU9UNExNd2hWM1Fu?=
 =?utf-8?B?QUFGSnNSUnhSamluM01qMXpNSnp0ZUV1cmxHcE51eEtmcWFtMDIwWkxHKzJG?=
 =?utf-8?B?eUMrb0pVNVZ1WlZSR0V0dVhNWm8xblJqcVk4TEw2Zi9QU0RJUmVxQTNxV3la?=
 =?utf-8?B?Q3h2VTlVUkI3WHE1TXk3QUdHL0VQeW9GT0g2ZWlHUUh0N0xndzJBcEo5QmN3?=
 =?utf-8?B?TFhvd1p6SnNsaFlCT2pjcExxbm9NbW9lYXdxSWs5V0thTHM0d3E0d3h1RVdP?=
 =?utf-8?B?R0FUQ2N4R3FVNFZuaG5INHdjZzEwR3RXMkxiZEN0b0lHSCtCZDNCaHFoaFRi?=
 =?utf-8?B?cDNwTjY3bTNYUlpmRHVjZUhlb25CcEdNdXp0Uk1YTTlYN3MwaVN3YVBHSitz?=
 =?utf-8?B?enVnTE83ek93a29ndG52SXI0UENtM1Q4V2NHdkRKaUErQTNXNkpBSVN2SlJP?=
 =?utf-8?B?SHFBdkpVemZBTGFmaHkxc0d1REtOQTZNYmRLYjY4a2kralY4Nm1LOUQzUW9Y?=
 =?utf-8?B?ZkJjWU5SOWk0Wm94SU9XNmtzaGFjbTRhR3MwQkovNGphajNuOHpjdXZMRUVq?=
 =?utf-8?B?UXN5ditUY2JIaDFrWlRKWGZvc2p4TjhSeEcrc1dGWlBRVmpLY0s0WW1tWm9z?=
 =?utf-8?B?VEVxbDBkSncrK2lxam5NeDNKKzNwVXdWcGRUZ0lFOWZSMU9XYVUyZFdNNjFt?=
 =?utf-8?B?ZzdNUWlWS0hPakFRVmQxajBiQzJrbUhwU0ZLdGd0OWVDNEpNRzJuRUJrRkZ6?=
 =?utf-8?B?RUoxeWx4eGVtb3R2STN3ZTR5VURiNSsybnNxUjVsQmtNTktUMDVRZ1prNDJF?=
 =?utf-8?B?Vm5DVXZ0eFRrZUN4V1ZEamh4Y1FQRElsRnhSSFp5K1RUM0p6VEplcGw3NEZn?=
 =?utf-8?B?NUR3YThJclpJbW5Fbzg3WWRPbkxVeGt2Rlg3Y2s2YjZaOXh1bnprakRVSVN0?=
 =?utf-8?B?cjh5aUQ4NmVFVEhZekZEek5TelRjWk45dEJCNjQ1ZUU0SUt2Vk5NRmVJMDlR?=
 =?utf-8?B?c0FRV0tzQ0o0dFVmdWhnYndlR1Vva3ZuQU5WZVBoTk80OWpaOFB1RVRrbW05?=
 =?utf-8?B?SUdNZGZXcWxtbW9FamUyK1NqZXAxRDFWUlhiaDFlV0FKVlpWUXBuRm1aczRL?=
 =?utf-8?B?Q3ZiWm9GT0gyeXRpQUljTjlrMzJHOEdzZVY3UVNxUVd4UkVuNmV0Z3JuRlVL?=
 =?utf-8?B?ZEFMMXFkUFB0SS9kbml5cEhDY1NBRGk3OUdWZTNQRFJoNkpveHdOdFRKL0Q0?=
 =?utf-8?B?ZWRnWVR4bDBNMjBXOGFYdmRnQ09DdmhodThnMHVXK25HQkVwMmRHK01WT0h6?=
 =?utf-8?B?SVVBOUd0Q1Z2aW5FUXhxT0U1NmF6Z2VIMXhpREh5UFJYbWZwcVU5b2pWaG9C?=
 =?utf-8?B?Qk9IQTYwWE12bW9ka3B5QnY5Y1MzWVNwRDJUbjRlZi9oWGpRMzEwa08xaGVT?=
 =?utf-8?B?Y1lzclk2L1dUMFlUMlQxWDRraG0vVWM1eDFydndWOEdRL09lcTVsb0duWFZu?=
 =?utf-8?B?d0dkSVFsako5Y29jMDk3YUUvRklhTEFuMHlwems3anBoK2RVTXZvMDZNbWpY?=
 =?utf-8?B?QmVBdGRkSUtjaEhvRmd0ajdjOURMek9IZ1ZQNjhiWTFqczhHR2xlZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mobileye.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRWPR09MB8022.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab3963b-3e3b-40b3-b868-08dee8bb0cfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 13:05:20.7008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4f85ba13-6953-46a6-9c5b-7599fd80e9aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5z5vRBOyMjarI0/LpwReOZW9VVNKbwfQ1aFZHFXKL9qOpKu+BeYmPgHxGAj+qcajSa1I8qtWhVJ1OhP4WyI+mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR09MB5559
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_060528_942638_FC1346E3 
X-CRM114-Status: GOOD (  43.65  )
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

PiBPbiAwNy8yMC8yNiBhdCAxMDozNWFtLCBPbWFyIFNhbmRvdmFsIHdyb3RlOg0KPiA+IE9uIE1v
biwgSnVsIDIwLCAyMDI2IGF0IDEwOjQwOjQzUE0gKzA4MDAsIEJhb3F1YW4gSGUgd3JvdGU6DQo+
ID4gPiBPbiAwNy8yMC8yNiBhdCAwMzo0M3BtLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0KPiA+ID4g
PiBIaSBTaW1vbiwNCj4gPiA+ID4gDQo+ID4gPiA+IE9uIE1vbiwgSnVsIDIwLCAyMDI2IGF0IDEw
OjE5OjI3QU0gKzAxMDAsIFNpbW9uIEhvcm1hbiB3cm90ZToNCj4gPiA+ID4gPiBPbiBUdWUsIEp1
bCAwNywgMjAyNiBhdCAwOToyMTo1OEFNICswMzAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0KPiA+
ID4gPiA+ID4gT24gVHVlLCBKdW4gMjMsIDIwMjYgYXQgMTI6MTQ6MjZBTSArMDMwMCwgUG5pbmEg
RmVkZXIgd3JvdGU6DQo+ID4gPiA+ID4gPiA+IFRoaXMgc2VyaWVzIGV4dGVuZHMgdm1jb3JlaW5m
byB3aXRoIHN0cnVjdCBvZmZzZXRzIGFuZCBzaXplcyANCj4gPiA+ID4gPiA+ID4gbmVlZGVkIGJ5
IHRoZSB2bWNvcmUtdGFza3MgdXNlcnNwYWNlIHRvb2wgdG8gZXh0cmFjdCANCj4gPiA+ID4gPiA+
ID4gcGVyLXRhc2sgc3RhdGUgZnJvbSBhIHZtY29yZSBkdW1wIHdpdGhvdXQgcmVxdWlyaW5nIGtl
cm5lbCBkZWJ1ZyBzeW1ib2xzIChEV0FSRi9CVEYpLg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+ID4gVGhlIHZtY29yZS10YXNrcyB0b29sIHJlYWRzIC9wcm9jL3ZtY29yZSAob3IgYSBzYXZl
ZCB2bWNvcmUgDQo+ID4gPiA+ID4gPiA+IGZpbGUpIGFuZCByZWNvbnN0cnVjdHMsIGZvciBlYWNo
IHRhc2s6DQo+ID4gPiA+ID4gPiA+ICAgLSB0YXNrIG5hbWUsIHBpZCwgc3RhdGUsIGZsYWdzDQo+
ID4gPiA+ID4gPiA+ICAgLSBWTUEgbGlzdCAoc3RhcnQsIGVuZCwgZmxhZ3MsIGJhY2tpbmcgZmls
ZSkNCj4gPiA+ID4gPiA+ID4gICAtIHVzZXIgcmVnaXN0ZXIgc3RhdGUgKHNhdmVkIG9uIHRoZSBr
ZXJuZWwgc3RhY2sgYXQga2VybmVsIGVudHJ5KQ0KPiA+ID4gPiA+ID4gPiAgIC0gdXNlci1zcGFj
ZSBiYWNrdHJhY2Ugd2l0aCBWTUEvZmlsZW5hbWUgbWFwcGluZw0KPiA+ID4gPiA+ID4gPiAgIC0g
a2VybmVsIGRtZXNnIGJ1ZmZlcg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gVGhpcyBw
cm92aWRlcyBhIGxpZ2h0d2VpZ2h0IHBvc3QtbW9ydGVtIGNyYXNoIGFuYWx5c2lzIA0KPiA+ID4g
PiA+ID4gPiBjYXBhYmlsaXR5IGZvciBwcm9kdWN0aW9uIGVudmlyb25tZW50cyB3aGVyZSBmdWxs
IGRlYnVnIGluZm8gDQo+ID4gPiA+ID4gPiA+IChEV0FSRi9CVEYpIGlzIG5vdCBhdmFpbGFibGUu
DQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBUaGUgY29tcGFuaW9uIHVzZXJzcGFjZSB0
b29sIGlzIHN1Ym1pdHRlZCB0byBrZXhlYy10b29sczoNCj4gPiA+ID4gPiA+ID4gICBTdXNwaWNp
b3VzIExpbmsgLSBSZW1vdmVkDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFNvcnJ5IGZvciB0
aGUgZGVsYXksIHRoaXMgZmVsbCBiZXR3ZWVuIHRoZSBjcmFja3Mgc29tZWhvdy4NCj4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gVGhlIGtlcm5lbCBzaWRlIGxvb2tzIGZpbmUgb3ZlcmFsbCwgYnV0
IHRvIG1lcmdlIGl0IHRoZXJlIA0KPiA+ID4gPiA+ID4gc2hvdWxkIGJlIGFuIGFncmVlbWVudCBm
cm9tIHRoZSB1c2Vyc3BhY2Ugc2lkZSBtYWludGFpbmVycyANCj4gPiA+ID4gPiA+IHRoYXQgdm1j
b3JlLXRhc2tzIGlzIHNvbWV0aGluZyB0aGV5IGFyZSB3aXNoaW5nIHRvIGFjY2VwdC4NCj4gPiA+
ID4gPiANCj4gPiA+ID4gPiBIaSBNaWtlLCBhbGwsDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gU29y
cnkgZm9yIHRoZSBleHRlbmRlZCBkZWxheS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJIHdpbGwg
c2VuZCBzb21lIG1pbm9yIGZlZWRiYWNrIHRvIHRoZSB1c2VyLXNwYWNlIHRvb2wgcGF0Y2hzZXQg
DQo+ID4gPiA+ID4gYnV0IG92ZXJhbGwsIHllcywgdGhpcyBpcyBzb21ldGhpbmcgSSB3b3VsZCBi
ZSBoYXBweSB0byBhY2NlcHQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSSBkb24ndCB3YW50IHRv
IGNyZWF0ZSBhIGNoaWNrZW4tYW5kLWVnZyB0eXBlIHByb2JsZW0gaGVyZS4NCj4gPiA+ID4gPiBC
dXQgaXQncyBwcm9iYWJseSB3b3J0aCBtZW50aW9uaW5nIHRoYXQgdXN1YWxseSBmZWF0dXJlcyBo
aXQgdGhlIA0KPiA+ID4gPiA+IGtlcm5lbCBiZWZvcmUgdGhlIGNvcnJlc3BvbmRpbmcgY29kZSBp
cyBhY2NlcHRlZCBpbnRvIA0KPiA+ID4gPiA+IGtleGVjLXRvb2xzLg0KPiA+ID4gPiANCj4gPiA+
ID4gU29ycnkgaWYgSSB3YXNuJ3QgY2xlYXIuIA0KPiA+ID4gPiANCj4gPiA+ID4gSSBkaWRuJ3Qg
bWVhbiB0aGF0IHRoZSBmZWF0dXJlIHNob3VsZCBiZSBtZXJnZWQgaW50byBrZXhlYy10b29scyAN
Cj4gPiA+ID4gYmVmb3JlIG1lcmdpbmcgdGhlIGtlcm5lbCBiaXRzLiBJIGp1c3Qgd2FudGVkIHRv
IG1ha2Ugc3VyZSB0aGVyZSdzIA0KPiA+ID4gPiBubyBmdW5kYW1lbnRhbCBpc3N1ZSBmcm9tIGtl
eGVjLXRvb2xzIHBlcnNwZWN0aXZlLg0KPiA+ID4gPiANCj4gPiA+ID4gPiBMZXQgbWUga25vdyBo
b3cgeW91IHdvdWxkIGxpa2UgdG8gcHJvY2VlZC4NCj4gPiA+ID4gDQo+ID4gPiA+IEknbSBnb2lu
ZyB0byB3YWl0IGZvciBCYW9xdWFuJ3MgcmV2aWV3IGFuZCBvbmNlIHRoYXQncyBkb25lIEknbGwg
DQo+ID4gPiA+IHBpY2sgdXAgdGhlIGtlcm5lbCBiaXRzLg0KPiA+ID4gDQo+ID4gPiBPaCwgc29y
cnksIEkganVzdCBub3RpY2VkIHRoaXMgc2VyaWVzLCBidXQgYSBxdWljayBsb29rIGdpdmUgbWUg
YSANCj4gPiA+IGhpbnQgb2YgJ05vLCBJIGRvbid0IGxpa2UgaXQuJyBXZSBoYXZlIGhhZCBDcmFz
aCB1dGlsaXR5LCBEcmduLCBub3cgDQo+ID4gPiBhIG5ldyBvbmUgY29tZXMgdXAuIEkgaGF2ZSBz
b21lIGNvbmNlcm5zIHRvIFBuaW5hOg0KPiA+ID4gDQo+ID4gPiAxLiBFeHBvcnRpbmcgbWFwbGUg
dHJlZSBpbnRlcm5hbHMgKG1hcGxlX25vZGUsIG1hcGxlX3JhbmdlXzY0LA0KPiA+ID4gICAgbWFw
bGVfYXJhbmdlXzY0LCBtYXBsZV9tZXRhZGF0YSkgYXMgdm1jb3JlaW5mbyBBQkkgaXMgcHJvYmxl
bWF0aWMuDQo+ID4gPiAgICBUaGVzZSBhcmUgcHJpdmF0ZSBpbXBsZW1lbnRhdGlvbiBkZXRhaWxz
LCBub3Qgc3RhYmxlIHN0cnVjdHVyZXMgbGlrZQ0KPiA+ID4gICAgdGFza19zdHJ1Y3QuIEFueSBy
ZWZhY3RvcmluZyBvZiB0aGUgbWFwbGUgdHJlZSB3aWxsIHNpbGVudGx5IGJyZWFrDQo+ID4gPiAg
ICB0aGUgdXNlcnNwYWNlIHRvb2wuIA0KPiA+ID4gDQo+ID4gPiAyLiBXaXRob3V0IERXQVJGL0JU
RiwgdGhlIGRlYnVnZ2luZyBzY29wZSBpcyBpbmhlcmVudGx5IGxpbWl0ZWQg4oCUIG5vDQo+ID4g
PiAgICBrZXJuZWwgc3RhY2sgYmFja3RyYWNlLCBubyBzeW1ib2wgcmVzb2x1dGlvbiwgbm8gdmFy
aWFibGUgYWNjZXNzLg0KPiA+ID4gICAgVGhhdCdzIGVzc2VudGlhbGx5ICJwcyArIC9wcm9jL1BJ
RC9tYXBzIiBmcm9tIGEgdm1jb3JlLiBIYXZlIHlvdQ0KPiA+ID4gICAgY29uc2lkZXJlZCBlbmFi
bGluZyBDT05GSUdfREVCVUdfSU5GT19CVEYgb24geW91ciBwbGF0Zm9ybXMgaW5zdGVhZD8NCj4g
PiA+ICAgIEJURiBpcyBjb21wYWN0ICh0eXBpY2FsbHkgPCAxIE1CKSBhbmQgd291bGQgZ2l2ZSBk
cmduIGZ1bGwgYWNjZXNzDQo+ID4gPiAgICB3aXRob3V0IG5lZWRpbmcgdm1saW51eCBkZWJ1ZyBw
YWNrYWdlcy4gVGhhdCBzZWVtcyBsaWtlIGEgYmV0dGVyDQo+ID4gPiAgICByZXR1cm4tb24taW52
ZXN0bWVudCB0aGFuIG1haW50YWluaW5nIH40MCBuZXcgdm1jb3JlaW5mbyBleHBvcnRzLg0KPiA+
ID4gDQo+ID4gPiAzLiBCZXlvbmQgdGhlIHRlY2huaWNhbCBjb25jZXJucywgSSB3b25kZXIgYWJv
dXQgYWRvcHRpb24uIHZtY29yZS10YXNrcw0KPiA+ID4gICAgdGFyZ2V0cyBhIGZhaXJseSBuYXJy
b3cgdXNlIGNhc2Ug4oCUIHBsYXRmb3JtcyB3aXRob3V0IERXQVJGL0JURiwgd2hlcmUNCj4gPiA+
ICAgIHlvdSBzdGlsbCBoYXZlIHZtY29yZSBidXQgY2FuJ3Qgc2hpcCB2bWxpbnV4LiBJcyBNb2Jp
bGV5ZSBjdXJyZW50bHkNCj4gPiA+ICAgIHRoZSBvbmx5IGNvbnN1bWVyPyBBcmUgeW91IGd1eXMg
YWxyZWFkeSB1c2luZyBpdCB3aWRlbHkgYW5kIGZ1bGx5Pw0KPiA+ID4gICAgSWYgdGhpcyBsYW5k
cyBidXQgZG9lc24ndCBzZWUgYnJvYWRlciB1cHRha2UsIHRoZSB+NDAgZXhwb3J0cyByaXNrDQo+
ID4gPiAgICBiZWNvbWluZyBkZWFkIHdlaWdodCBpbiB2bWNvcmVpbmZvIOKAlCBub2JvZHkgYWN0
aXZlbHkgdXNlcyB0aGVtLCBidXQNCj4gPiA+ICAgIGtlcm5lbCBjaGFuZ2VzIHN0aWxsIG5lZWQg
dG8ga2VlcCB0aGVtIGNvbnNpc3RlbnQsIG9yIHRoZXkgc2lsZW50bHkNCj4gPiA+ICAgIHJvdCBh
bmQgZ2l2ZSB1c2VycyB3cm9uZyByZXN1bHRzLiANCj4gPiA+IA0KPiA+ID4gUmVnYXJkcywNCj4g
PiA+IEJhb3F1YW4NCj4gPiANCj4gPiAoQWRkaW5nIGxpbnV4LWRlYnVnZ2VycyBtYWlsaW5nIGxp
c3QpLg0KPiA+IA0KPiA+IEkgYWdyZWUgd2l0aCBhbGwgb2YgQmFvcXVhbidzIHBvaW50cyBoZXJl
LCB3aXRoIGEgY291cGxlIG9mIG5vdGVzOg0KPiA+IA0KPiA+IDEuIGRyZ24ncyBCVEYgc3VwcG9y
dCBpcyBjdXJyZW50bHkgYSB3b3JrIGluIHByb2dyZXNzLCBidXQgaXQncyBzaGFwaW5nDQo+ID4g
ICAgdXAgd2VsbDogaHR0cHM6Ly9naXRodWIuY29tL29zYW5kb3YvZHJnbi9wdWxsLzYyNS4NCj4g
PiAyLiBtYWtlZHVtcGZpbGUgaXMgYWxzbyBnYWluaW5nIEJURiBleHRlbnNpb24gc3VwcG9ydDoN
Cj4gPiAgICBTdXNwaWNpb3VzIExpbmsgLSBSZW1vdmVkDQo+ID4gICAgSXQncyBsaWdodGVyLXdl
aWdodCB0aGFuIGRyZ24gd2hpbGUgc3RpbGwgYmVpbmcgbXVjaCBtb3JlIGdlbmVyYWwNCj4gPiAg
ICB0aGFuIHRoaXMgc2VyaWVzLg0KPiANCj4gVGhhbmtzIGZvciBhZGRpbmcgdGhlIGluZm9ybWF0
aW9uLCB2ZXJ5IGhlbHBmdWwuDQoNCkhpLA0KDQpUaGFua3MgZXZlcnlvbmUgZm9yIHRoZSBmZWVk
YmFjayBhbmQgdGhlIHN1Z2dlc3Rpb25zLg0KDQpJJ2xsIHRha2UgYSBsb29rIGF0IHVzaW5nIEJU
RiB3aXRoIHZtY29yZS10YXNrcyBhbmQgZXZhbHVhdGUgd2hldGhlciBpdCBjYW4gcmVwbGFjZSBt
b3N0IG9mIHRoZSB2bWNvcmVpbmZvIGV4cG9ydHMuDQoNCk91ciB1c2UgY2FzZSByZXF1aXJlcyBh
bmFseXppbmcgdGhlIHZtY29yZSBvbiB0aGUgY3Jhc2gga2VybmVsIGl0c2VsZiwgd2l0aCB2ZXJ5
IGxpbWl0ZWQgc3RvcmFnZSBhdmFpbGFibGUsIHNvIHVzaW5nIGRyZ24gdG9nZXRoZXIgd2l0aCBh
IGZ1bGwgdm1saW51eCBpcyBub3QgcHJhY3RpY2FsIGZvciB1cy4NCg0KVGhhbmtzLA0KUG5pbmEN
Cg==


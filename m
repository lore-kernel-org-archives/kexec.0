Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49FACD4F21
	for <kexec@archiver.kernel.org>; Tue, 12 May 2026 23:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cwk9mUfnsI70oj+61V9iyCdWSmkpe9DmFDaGq2oPTv4=; b=WBuZTNAgZNzxLSVUj+wWK9Ktr6
	GwqFZcbTnOSzAVg6B0i70XGqQqisPMxyJKbIGmIt309GyKnTveggDZ+z7WubMsu3tLFWxJwO6BCeM
	JpEbCAP0tCEUpAZaDpDsVZ9R/XYoWQaIaYyxt86bvWUWXUJZCfM0UltDNtOlLAENMOwcw+a5kBKNQ
	SODoJgnkRzEj1ri9BoMZg6UZCbZKNPEXxkqXyBp3zTEZJgc80C5ql+dbyQYU1tgMQAfPJMiqElPVe
	N041EMURm1M7LRmZpfgWozJ7SFPq3O7BM4KUlbSh0dSS5GcINLgj+P6DVUCVEOu7jEPq45s4fl2IX
	/nxjjxOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMwnp-00000000j5d-1rUD;
	Tue, 12 May 2026 23:46:17 +0000
Received: from mail-japaneastazon11011015.outbound.protection.outlook.com ([52.101.125.15] helo=TYVP286CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMwnl-00000000j4I-2FZ3
	for kexec@lists.infradead.org;
	Tue, 12 May 2026 23:46:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJdBbGNtnsObRyAe2nAcjBH2hHjmiieTOMKkn3GYFRUBnN+sAOYqrHDYkjf2vlynEeXGWOhKUFaAxuBVhtG4xhGV3wdm72xiQO6iEzfWb09BSiXJOms0cvTi31BCCNoTFbdlakSvlqHZZQE3oryNT9inPRBWKpjcSfXd/RIIvTvFR9ULkUVYVno+NHIjYM78k6IIgBPI3O1kRwwNKyWPUIpjy8SrJqEppxDOnPrN2ynwSmLtTZQAYIKk+YnHbMlyySdAohpf+LpO8ow2bkPhTIx7188aKUguObafo90HNTyxbP/+FQg8w8KIL0xi6VnwbxLotJhNLNKJKM9E8srGWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwk9mUfnsI70oj+61V9iyCdWSmkpe9DmFDaGq2oPTv4=;
 b=NK7ldBuRdJDe7tUDFBEG4jP2x3qjUqUmOW01QRymTEL3bPBbUtSWHanv69K1nPSfZEBTok9xQ0L8o8WIV6l+qEk/DVJqLJBPK/jZNKVABMyl7qP76VBLBvVJvQv2AMIazQVcJLLyiOhmaiLVdMovWJeByAw6G9Hm0IGMsB54FZwUaY4hX/g1zeXD04LbyeRHwFhqtGiYSigOtXumLLduwYsbhCZGOkAXLn4MBikgbi+PGjqYVlxLSi+Y5xUql9ISEpbRxvZRgLE0J8pDKJymK/e+k4rlG9dG3RVdMVZDc++PIKi83jXYnejwIxu9GdnkdnxFnCptwc/k2bHTiAmzug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwk9mUfnsI70oj+61V9iyCdWSmkpe9DmFDaGq2oPTv4=;
 b=EdPruRwmFqXjoJLNYjt1TyycbQJj/3x/6sPmdKauDG+OuKUKw+Rf36QC5W6jSzqGBrwJWg9Ln/JsudOyex5CKjAgPVEqh5EgjqXMIvr3w1rme4Nv5qsRoLylWKZGJE5laDwBHu8E1kdnKJyiu305H9GMPZOdUejQnyrDXZNE6wHPd0tS42iEKynGNvuY5wNaAZ9MGgwHRvUeUxAMuxERsr9SMbdBRTDHIHke1o7cBCgs1EBPiZHT/TBV7lP9u79w/UEhrscbvTL5UWcXNlbWbcvcNj49t9O6obY8svoX3tza0nkyXMhBF01oAVdD8qOBVdTtK7Ov3Fgws6XSzifi1A==
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 (2603:1096:405:1d7::13) by OSCPR01MB15925.jpnprd01.prod.outlook.com
 (2603:1096:604:3ef::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 23:45:59 +0000
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820]) by TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820%6]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 23:45:59 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Rui Qi <qirui.001@bytedance.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
Subject: Re: [PATCH][makedumpfile] Fix riscv64 virtual-to-physical address
 translation
Thread-Topic: [PATCH][makedumpfile] Fix riscv64 virtual-to-physical address
 translation
Thread-Index: AQHc3U+4QwF9qDGVNEW9+UcYdlJE8bYKBVYAgAES3wA=
Date: Tue, 12 May 2026 23:45:58 +0000
Message-ID: <28dced8f-a9c5-4514-b7d8-8110fd693133@nec.com>
References: <20260506115758.2497610-1-qirui.001@bytedance.com>
 <20260512072142.58396-1-qirui.001@bytedance.com>
In-Reply-To: <20260512072142.58396-1-qirui.001@bytedance.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB13462:EE_|OSCPR01MB15925:EE_
x-ms-office365-filtering-correlation-id: c90d27f7-ec7b-4e98-689b-08deb0809e4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|22082099003|56012099003|18002099003|11063799003;
x-microsoft-antispam-message-info: 4wD1UPHFGPoGnVFd05QMUy/OA7g/Am7EGkRI4GyyUsY/PuvKEFgX/aruydO17qX+s9rt+MUjRyfxpXG32exmMKqXYnxRCxp0P7dFVIlpoSgaTfakZgO3+7N+1vNiHs8i3nWet15HTQxWdgCO+payXguSnhT98bZL2fcn031n58Nmwz/HFaQ9mhKtuOQvttqz9WR32ubLjbVERVcjnK+YAE0xUOEaEllBO0Y8jkO+KxIg0MVoSFoBDFlahqNNgJBJTRiSkp7Xr3+UVRmskXr12rCpoJMvqsl4Q+7CTLjEq3VN85tvnqlFAHlCGZkYcHkbKh11nV6kvT3wE7Fws2lDQClyzPdmD7XlXDRJ4n7+lXsUkqGRhYhZcR6olJ8UN93UuWWNqvKwpVUlK+jDSqM7wequMNmqQFlDmNksszSFXy9y96xGF6rqe8cZ4guqv1GCP14p0AbxEU5487G8x2asOSC/78WB3rficv8uKZZxt3bvHic8NNV+f4BFZMf0iPXeB0sjTISBE2g1dQ2LV8+AkBSeawMNVZuknS3/vP1Je+wZEaP8z+2VRZKEJw9WM2B7EFDnMQooxQLWDU2i9h4msoexE/7mhRl8ba9J1aZlbIpVqCRIw4CDWDJndQ48OdexlLcSy7zwoVQhfrmswlTo43Xk+rzArCn+Zbw+ydKkNpNwt8fW7w+aypt6SsZi43QYe1kcW/P+n1Ak7FGvcyLZm/+TQLGfYrK5G9/F2I9t3qTMBEdUx+T0+wEyjc/bE1/Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB13462.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RW0xdHJRRWpvSXo2TXU4YzJwd1I1ZldSV2JsZzB6Z0hEMTN1alhMRHZLeEU0?=
 =?utf-8?B?eU1rUmdqZHFsZjkxZnhrUlhXRXgvVlpQdGpxaVBRODIzd21WcEVtYUJhZUZX?=
 =?utf-8?B?aDhjSDJjZjNORXBDUHFGRy9HTVpVYTBwdjJqRlZGRDI2VmkrN211ZDUyd3FY?=
 =?utf-8?B?bGx4aDBRY3ZvZURYSlRFQjJWTXZ6bXgraXU0VFJQUHkvNjRtb3Y2SHIySEgv?=
 =?utf-8?B?Wklmb0xQbzVjZE5uRWEyK3dXaVB3bEFTSy9pcXhSRmZrdzVXYy94QjBjOXRj?=
 =?utf-8?B?bExVTS83T1JsaXU1cHVEN3ZwTHpxUGFnZ3d4WXBtRUN5bVppNjMvSEx2SFhv?=
 =?utf-8?B?b1U5YVJjc1h4R29hc29Zbm9xNk5tMllIMXpsVmwyaW9DaHRjSVNSY1NDb3Jx?=
 =?utf-8?B?MVRRWGhTc09qeEdqYUZsZERFZkRZNFo2b2RxZklzaU15RjBuRzZOclBPRDFP?=
 =?utf-8?B?RCtkOW13aHg4MTBVUmFIZ0FGRnhFYkZvdGwyU0NmSWpzVXU0M2xYYVUzcEFi?=
 =?utf-8?B?UUdVaGk2S2FmUXpNcCtpcnpha2l3Qm9PR0hHNytDYjRRQ3Z4SForOU1xSUJK?=
 =?utf-8?B?K1d4SFV3STNHRCtNRDVQMnM0YVhlZWJhKzMzYWEraUExQmZ0QmwzT2MrOUJR?=
 =?utf-8?B?OU1hTi9zbk5kVjBIR0RrRDZXaFg2YSs5ZFRDQjVTVTlUME9McnB1WTZvczhM?=
 =?utf-8?B?c1NjM3ZtcEpLeXFWeHpuV2ZtalhmUnQ3WExEUVQ0anpublMvZmViLzZiWTdD?=
 =?utf-8?B?Q3R0bStuVXIyVXM0RjJNY0M4UlJ2bHdHOC91cEJncnduRk9nN0ZEQkw2L0VS?=
 =?utf-8?B?MWVLVllXcWh2NDhDWExIbXpOZFJjTTMwRlFsVFpXeGJvaUNTY0NvSjdRa09q?=
 =?utf-8?B?KzRQS0R5MkNHc2VWdXBqQkRUMGtwdDVyczE2bWllRm8zVndBNGNkb3dYRDRI?=
 =?utf-8?B?aXdyZ3VPK05RR0FqdXQ4NCtxeE1iVDA3M1htczVVRmtmOVpHb2NBRmg3ZVo3?=
 =?utf-8?B?cGFtVHhNUmxLQmphOTI4cGdDajNmNExLOGZpa2QzbnZSZXQxWmlhM0VkN2pW?=
 =?utf-8?B?SjE5d1JadkViM1BWYmZwYVd1ZWpjUDBValNxOEc3Z3M5MlhVZUhFZEwzTDFh?=
 =?utf-8?B?dHVZbTB3d3Q2SDBBc3V2aDkwZHJwV3l3UkVCcUgvWERuTGdPODdwS2FUNllP?=
 =?utf-8?B?dkQyd2U4S0kzdE1IUHcydUJqSmJoeWJtODg3VE04aEFSKzc1R1UwUDBaeE84?=
 =?utf-8?B?cTd2Q1hBK3FYWDFHdnJOUjdZTngrVmdUcHNZZTI0STM5V0dPWHN1QWk1R0Ji?=
 =?utf-8?B?eVNXUHUxaW41Z0JkZ3AvWHozM1dYdTVwaThZd0ZKYmRvVU10UFFTYi8vcmtI?=
 =?utf-8?B?ZGZLK2xQYU1HMEorMU84UWx5VnNRRVVxOVVkSlVybjZOOXRaang3dzdDbUNH?=
 =?utf-8?B?dkcyWlhnWldUTXZodk5wMUtUZFdEdzI4a3gvN2VKTEszT20xOFJJTVNCN3g5?=
 =?utf-8?B?cjZYVmhSUHdVemdoRmRWNTZzemU0ZmE2UnpBRm9GRHh0UE9xcEovaWdmUFVn?=
 =?utf-8?B?MmlsRjNjVFVvVUxpOE84VWNmR0Zvc3E4TjNReXhIQVlJVE5DQWhENjE3TUpG?=
 =?utf-8?B?NHZRSUFlMk0yMU9iWHEvZlVZVnB5b0RWMFRFZ25HQmFmZVpTdGJYUXZWY1da?=
 =?utf-8?B?NjJGYUhJcDVqRUw1UHQvdWZOSitOTkp6UjMvaU5yS3pzdVFiN1g3UUFERnZn?=
 =?utf-8?B?QWx5N1BSUG42VzNiWk5sTXVvcXFTZy9jTllFbnphMDJpNmJaMkNFaWUxN01j?=
 =?utf-8?B?dzg2OU1KZm5PY2tqQXVqY1NBQ0hYTG45ZDBFMVdSS1dMVWNBaE5rMm9hSmlz?=
 =?utf-8?B?L3oxZ2Nxc3hoZXkxekE2VWY4VjdpejhhNW4vU2VLZ0lBa0lCVGNDdzdqWEUy?=
 =?utf-8?B?aEhQOUN6MWp5QTJ3azFENXVIWWl5Mng4MDhydHhFcks0MHN2RUxNckNkN2o0?=
 =?utf-8?B?aTlMaEo0ZWZLK3pXU1NpeUI0TnVacnY3Rzg3YnlMeXNhUEZ3RTk1djZmSXZG?=
 =?utf-8?B?TC9wWWdQK2ZLNnl3N1h1TjRJNFRzMlhENE5ibkdkdXpPNzZlSmNzc2pUZGZo?=
 =?utf-8?B?VVdUMTBhbWwwb2xBcXFlZFQrWnJya2htV2dma1FVNlZlU003L3VySWNhU01M?=
 =?utf-8?B?ektadTFHVHArbENsbzY5TXNJL2x3RWEzcEdObmNFd0M0WFJva2pyNVNLZ296?=
 =?utf-8?B?WFRCdzlwd3ZGblp5Ry82ZFFxNUtSSGFmcDhFV0ttZUVQbEVJRWNFMWpmWDdv?=
 =?utf-8?B?Z0hMbmVMY01XQ1dEdURIeFlrMnpsTXFyZGpuSXYxZ0svU2JScXJFZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F222CE3D60C9E4FA338048AD348FA24@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13462.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c90d27f7-ec7b-4e98-689b-08deb0809e4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 23:45:59.0920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Fm1Z72J4z7r3CLcYTWh9QeJxil9WC7lAgQozu9xq5qm4G4Ed5XEdDT4xJkIoi1AocAKQ6Z89RJ+3QDccPWXGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15925
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_164613_857691_2A412AA8 
X-CRM114-Status: UNSURE (   7.33  )
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

T24gMjAyNi8wNS8xMiAxNjoyMSwgUnVpIFFpIHdyb3RlOg0KPiBQaW5nLg0KPiANCj4gVGhpcyBw
YXRjaHNldCBoYXMgYmVlbiBvdXQgZm9yIDYgZGF5cyB3aXRob3V0IGZlZWRiYWNrLiBDb3VsZCBh
bnlvbmUNCj4gcGxlYXNlIHRha2UgYSBsb29rPw0KDQpUaGFuayB5b3UgZm9yIHRoZSBwYXRjaHNl
dC4gIEl0J3MgaW4gbXkgcXVldWUsIHBsZWFzZSB3YWl0IGZvciBhIHdoaWxlLg0KDQpUaGFua3Ms
DQpLYXp1DQoNCj4gDQo+IExpbms6IGh0dHBzOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1h
aWwva2V4ZWMvMjAyNi1NYXkvMDM2MDU5Lmh0bWwNCj4gDQo+IFRoYW5rcywNCj4gUnVpIFFp


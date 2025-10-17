Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B99BCCD199
	for <kexec@archiver.kernel.org>; Fri, 17 Oct 2025 04:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1tjFZeLMXXTMV54ngHE7l9KtRTmXhuz/x1WgHEnVG2s=; b=GiGI0dO7dmrRLNOf9RkqHmxCxO
	+uyGdeiT8otX7vzg32ggBx/DyP4jdyPQKmAOocRl+u/mcTNe3yNq2yFOTpIYaO7sQ7JNX0SJ1HITa
	9glHflW1ywa0oowdXZG1yBPdF7cpPRpju7fP79zcJtKid4+Ar382uCNGOio0dFri1RESoZWzpeOXP
	YFLfJJAdyUeJnh5Ddg52qK/tiYifBOoLfBC9Lpem34KODb0aFd7cGk+6YEpFrwF3KiKgm4xJQ2uQK
	wK0+++QPqQSjIcoH5L74B3ywgRExWOXiRqc3aUf4+BW/IGzQiqbMJjbkiWFqCC4c5524JIF5hnsg1
	BDfSuxcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9byG-00000006W09-14uR;
	Fri, 17 Oct 2025 04:21:40 +0000
Received: from mail-japaneastazlp170100000.outbound.protection.outlook.com ([2a01:111:f403:c405::] helo=TY3P286CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9byD-00000006Vzl-0bcS
	for kexec@lists.infradead.org;
	Fri, 17 Oct 2025 04:21:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YtCxpGN9raRhz6uSnKRNOLH+WEVHYdetobGdOWtpI5QAkTWS6FpplzGPh4TP7fcPkuCAMkYTBAFF6cvI+noLY30Az8kBEFcxqRYG7kBLXhSye7AdbA/AN0QFTBPp/cijbWKOOpvb8iECcQYRVKsZ6fnBR7yEHMV0UP/1pm75zpVzPKSUWCxhl8WIktufMhfY1u0k3EK25yFa3CdIuhxUC/3gukaEUk7zwfJ4pO7FcC2lfXitVuv3586AU6oM0xTa3Q60sYtQDNU+26Uv1QJbG5eRd35ZpMadbOTKyWohBDZNBCT6TB8MrUkA2Xft97FhweyWowoKDQ6kAgsmglhZ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tjFZeLMXXTMV54ngHE7l9KtRTmXhuz/x1WgHEnVG2s=;
 b=ZBksBO1rMIQrK8t5siBw6efL7j2BBRE2fGkkjAFBjU0CeS6Be+RC14C0tE4xIXC7A+q7djBwRGYBsiK2kgLtkW17Ym94zpnioU/Phfxb+KsqncO21N+Y+IGsw/dmcGncCQ2uDqq8m3jC221I022Sdzn/SPLnz5sJHPcxfj5PXbYeAyL+3+qfCSaXzpCa8I2UNhZuVUygoLRuhc1XLw9pfrijoZDYXaWBNngRtheomb19g8FerLzTlTwH30eror7UmRzDFt6LiTA2Wu44BvgN65axVC0zvcanhdCv75ck0F22BFVTCafSYmOyDg0yM+AsRNf/2Y+a6CAKQL2hdWGqRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tjFZeLMXXTMV54ngHE7l9KtRTmXhuz/x1WgHEnVG2s=;
 b=lDU+sJaFaDJ5fLN9ce6Qd4Qedn0hYwFlvOtrzwuQz+gvN0fQ8giAGEpFcEYtn619aT3AbH3io08Ho1e2tzy9/YvwJ1wPSKrovnO3B5nzhOse3cWvpQe3vxMo2Qk96//OqCk91WDpHpdf89VoStEw6VqRowEk6mW8ssON+2L1sqpfIU7AU32tcbGR0cwHNKZaABrb8W9cuZmeNzz9s5oemQusKHMlgPmTjbCj08ZibydCWz+2+hrWxv6E9nNp4tOQwiX+wqbflc1+oI9FzubPB6qhawaqpUdb/lsUCEwatYG4qB1psm0P8X1Pmu3OYolSHGwTYn/1lIkz2DdCQJBiIQ==
Received: from TYWPR01MB7680.jpnprd01.prod.outlook.com (2603:1096:400:ec::7)
 by TYYPR01MB6959.jpnprd01.prod.outlook.com (2603:1096:400:d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.6; Fri, 17 Oct
 2025 04:21:26 +0000
Received: from TYWPR01MB7680.jpnprd01.prod.outlook.com
 ([fe80::a702:7478:5c45:6469]) by TYWPR01MB7680.jpnprd01.prod.outlook.com
 ([fe80::a702:7478:5c45:6469%5]) with mapi id 15.20.9253.005; Fri, 17 Oct 2025
 04:21:26 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Tao Liu <ltao@redhat.com>,
	=?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
CC: "aravinda@linux.vnet.ibm.com" <aravinda@linux.vnet.ibm.com>,
	"devel@lists.crash-utility.osci.io" <devel@lists.crash-utility.osci.io>
Subject: Re: [PATCH RFC][makedumpfile 02/10] dwarf_info: Fix a infinite
 recursion bug for search_domain
Thread-Topic: [PATCH RFC][makedumpfile 02/10] dwarf_info: Fix a infinite
 recursion bug for search_domain
Thread-Index: AQHb2e43A0POHsmGukyZJjkb+YGe67TGhuYA
Date: Fri, 17 Oct 2025 04:21:26 +0000
Message-ID: <8a3b3c55-f4f6-4c69-90f7-cdc7fc5094ee@nec.com>
References: <20250610095743.18073-1-ltao@redhat.com>
 <20250610095743.18073-3-ltao@redhat.com>
In-Reply-To: <20250610095743.18073-3-ltao@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB7680:EE_|TYYPR01MB6959:EE_
x-ms-office365-filtering-correlation-id: f46def9f-b774-40ec-6014-08de0d34a398
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?WDRyc3ljZDVJVHVxRjBIYXhUQVJneGVtUlYvTy9Mb05WS3JGSFpYbGhadlhv?=
 =?utf-8?B?K0RCcWlHUGUwclhlRUtHbFc3SWtGbEx4STI2NmxCRERMSzZxRUorQVVVTU4w?=
 =?utf-8?B?bTExQW5ENUNGRDIyNldLa0grRUpzTlRwVFkzcmRscDFXQ0ZyRWZaZUs4RFo0?=
 =?utf-8?B?V2JFbjVLVUNFZWxDZXp0TEk5R28rYkJ3VEttR09QU0o4djBtM0kvWHdzUHV1?=
 =?utf-8?B?aU9ETkhPMFNRMjIveThHdjJRb1pTaHlnZGExK3pjVUpzVVBKSGRVWG1xQ1Na?=
 =?utf-8?B?UTFYNytEbjJDL0todDFJbHlOdnZja3lLNTlKRW5SUExMSXZxMFA0RHVwb2Z2?=
 =?utf-8?B?T1hNd3RJSFNCb1A0MFRtbldWbnRuNjdCczg3ZEJYck8vUEpkak1YVzBvOHB3?=
 =?utf-8?B?b3ZZSTRTOCtOeDRSN0ticjZxQ0o3L001Y040bDFuQkRmTS9Rc1g4dE52aG9n?=
 =?utf-8?B?WVVxSW5GcVQ2Q2Q4cnFrcTBEWUhKYUprcXVqdTN5UDR6dnJzcXFaQ0ZmVjV2?=
 =?utf-8?B?c0o4dSs4MGpEeEg1eERXc0pSd25EQlJLU05YM0NrR1pkWHEwSGptNjNnenBW?=
 =?utf-8?B?cU95aXJXWktDOVdTNTNvRHc4T0hvZGFuNk5GZmovbjVvOWJVOS9yenV5bm8r?=
 =?utf-8?B?eUd2YjBlSVFDM2xnNzY0eFpvQnpHd2FZTFFHbFJUQlFjM2NadWZvRVVNWVpN?=
 =?utf-8?B?Z2dpdnZCNXJicE9CaVhEMXp0VWpya2pKSVFORnVYUmZaWjZsTGpHMEwxZVdM?=
 =?utf-8?B?bnE4L2RWS0VJditKMnYvSFJ2ZlhxMlQ4anpVNjlsQzFRWWlGMkx1cDA2SzQx?=
 =?utf-8?B?ekpmL1pCdlNTN0xQdkdkZTlpdXpQK3cycjdQTVBNT1FuaVlnbndla1RxUzFJ?=
 =?utf-8?B?QlE0ekhnUStLV2RhT1lLUHdqYnlGYzZBR0VoUTVMQVNHdVMydHBYZXlEUkZ1?=
 =?utf-8?B?eXVYbVFINHNxdHJTQjFwU1Nxcng5aUlRWTVpVlV6L3BuYjgrUDQvK2tFemlm?=
 =?utf-8?B?cmxiUU9BYnh1Qk41SnRZRVRFdVNTRFQ1cU0yT1FUaW81QXN3dkxxWnF6K1RX?=
 =?utf-8?B?UGhKcUwxUThCaWRQVUw2RjR5MU9CNHphelUzcjZFdk95YWFyUituOUxoK0t4?=
 =?utf-8?B?Rldpemx0eWloRHl3cnFRby8wMGVxY0JzMCszTDRIOFc0UnJXNjl0bUVpcXkv?=
 =?utf-8?B?NjZPZE0ydnlOcFJ5NkFTVEZ2VlRwQTJwSzd4aU9aMGdOS3BLY2RERTIwcDNG?=
 =?utf-8?B?OUtkdXFWblJTTkVIV2ZiWTVMT3FoaTc0c1Mwd1NZNGhKOStGbkxXN05OUXRV?=
 =?utf-8?B?elFLWDh5RkVPMDY4OTV0Tk9LQVlwRnlvR0xwdFBMcXBWQjJIQXprTUZCY2lz?=
 =?utf-8?B?OUU3VS84TEdQY1kxeGlWbG5BcUxNcEhFT2dMTXRnd1l0Q3FGbU9nT0hIZmdP?=
 =?utf-8?B?dnBJWnp3UmRRZEl5TWlEM1Z0bHFGQzZYeHdGTXlYUisxZGtWRmRzSW01eVhP?=
 =?utf-8?B?Q2UzZXp1cXAwdHVJdG9iWjZyaGsxeWxsRHVENWFBMkVxTFp1dzNtUE83WUs3?=
 =?utf-8?B?NGgyYVR5Y01Ccng3NG1ZdHRzSkxOeEdOWXRSR21qcE1pQjlZR0VZOFpjY0hw?=
 =?utf-8?B?b1d2cEZxbjk3L2N0dzlqK2ttMFQwNFZIWGJUMFNXOHdaZlVwZUtiTlFESDZ1?=
 =?utf-8?B?blB6N3dpckRja1BnaUUyeVNJbkpMZDNkVmFBVXpGMGNwZjZtMUcwK2NBSjZQ?=
 =?utf-8?B?SlpnbDZKZ0lsbnlpUW83TnpXUkdVbmVlU2lYVkRJMS90SUpwZm5xU3NML3d5?=
 =?utf-8?B?MDBLL1hUQ3huOStxWi93UWRKSWhPV2gzL0l4L2M1S0h6elF4YkxnSFBXejFv?=
 =?utf-8?B?d3RaYVN1ZjNURGNLQjdnbkR3RjAyMG1lMUpmSmptOEFUOGxqRVpSL0R0b1dn?=
 =?utf-8?B?VTlDZ3JjMnRYNDIyWmJ5cVlpcXI2MTQvRGtLVnJzTzlJY2xOeSt6VDg3OUJu?=
 =?utf-8?B?djVYa2VnYndRUnVWWHQ1a2U3MEdPOXhJdUZlMDBoZldjbmdvS1d4OTJzZ2FN?=
 =?utf-8?Q?WrKtfG?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB7680.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVJIdzB1aURUNmhPYUZwL0RFdWd3WFdJaGkrY1BacDdMcVAwRlVqaWZ4YlI4?=
 =?utf-8?B?bXFaUkZnV3RGRHh6ZXBPbzlOZWQ3ZXpWQ2NHaVk2ZGtwWk92YVhVbXVXbzBD?=
 =?utf-8?B?OXZGcnY5VmJtYUJ4Um5ObDJwbm5VZEp5MTJjbkVoTVhnSzdnOGM1dlBFN01j?=
 =?utf-8?B?d0trdGM2UXZIdGxTVHdwWFZtNGt6K1ozNzBBVDgzQkFKOGtlcXVtTU4rSFJ1?=
 =?utf-8?B?OG9jSWVhVU9iQTh6eEVMQVJyclZGSTlEQytCT2l3K1Q2dkJaU1FicTZZQjVy?=
 =?utf-8?B?UUxvUzduUTZnSmZCRW15VW5Kb0g1M08xQ1lHOTFOWTBYNUFsL2U3TmgxdS9i?=
 =?utf-8?B?SDEwS1BQTjJacUVQS2hBeXY4dVFKRzJqd2J0K2RRWXZyRHJxa1p2TkxvZ3Q3?=
 =?utf-8?B?ZE9lMlR3NlZUUUxpT05wVXpsMlRLbFdhdmozN0dwMWNibUwwWEJLNTV4SHhE?=
 =?utf-8?B?bVpQSlA5TEN6aWY3MTdpdGpvdndtOGxTVzAwVTlrK1RJZFFnVDErMEZ6K0RZ?=
 =?utf-8?B?TkVZT041aWtoTW5mQnNra2dDMFMxRkw5NVZGcVJXUEd0bm0vb2o2eVRHQ05I?=
 =?utf-8?B?MFNsOGZOYk0ycHJLMDYvTHJPemNnMXd6Q1lCSGZ0UzczYjVBbkxoMXhUNGtO?=
 =?utf-8?B?bVloWm9leEhoSS90eW1hdlhWaGU2aXJub0hjb0FnUHV1b0RGbElXUXRRTWlp?=
 =?utf-8?B?RVJsVFhxbVd1dkJ4L0NMTXhBR3JIbTg3dDZlSkprSG05VHFrdXZyR1h2aTNW?=
 =?utf-8?B?M211MENLSHJTMlZkVFZ5aWRvZ0MwWmlIY3RZdnhxMmo1K0hIaXZYV0RNNU9B?=
 =?utf-8?B?cTkya2JVVjh2UUxlOFBicTh5alFaUnhUWmh3ZVhtdkFNalh6WStiMEVvMnNh?=
 =?utf-8?B?aUNNYUpHUFZFK1hJRGhadE52Qlk3TEtQVlhoV2Y2UVdIL2dCTmNhQnJDVm93?=
 =?utf-8?B?OWZzY3J6eGk2T0JNdkRTZGN3Ynp5K3BqZWFXZGNPMTJDWXc0TmtoZXROMEZn?=
 =?utf-8?B?S2VoUUVsSzVyU2RZaWlseXhidEozSExKam5IWG9uWTkvYjlHaXRUeWRseFVw?=
 =?utf-8?B?OUljejBIaklqdkkrL2ZKZ2RTSXgyVGFNbWNiR1dLbmxCc3JzeVUxNzhkNDU4?=
 =?utf-8?B?SmJoMHNGQWR0U2xyZkNyWjRqS1I1N2hQU2hFZFlCUUJIaTdIVWFhUXJaSW9l?=
 =?utf-8?B?Q3FWOWJXZFJOU2FpTEc4NE1HTzkrK3k2cXJTT1A3YllDanFxaEMyaCtMT01m?=
 =?utf-8?B?WXVURGdjOVlMcVRTd080K3dqZEM2ZmhuUDdSbVIzVXFOekRHRGVEY0J6TE9y?=
 =?utf-8?B?dS9KcjAzQ0FSNzg3WDZJbXhVVncvWmV0TUVmZkVlK1JUcDI0RXpndFNGeUVG?=
 =?utf-8?B?R0liRG1JUk0wb2lvcFQxNEVWR3Y2ZHdMU1dMK3hmbDJDS2ZPdTlIdGd0TzdL?=
 =?utf-8?B?R1MrYlJNUjMrYVA1NS83eEVFVXlENzVhT01wY1ZvZngyRkNVNGNGMWh2d1kr?=
 =?utf-8?B?NXo4Zks4WmhpMzk3MkRuVHM5eWhIeUR1QmQyQnNJS0JtWE5NeTUyanNzeGkx?=
 =?utf-8?B?aGpGWVJFaWUrb0FrY0l5cllTMlpxcWk3dXZNOUM3b1R1UDlYeHMwekFXcXdp?=
 =?utf-8?B?QVFDdHFBc1Y2Q2dDdHdOR1ZjeTZ0M3V3Tlg4R0ZmV3pINmJmZXhSWUQzQWNO?=
 =?utf-8?B?R3NmaWJvSE1EU2JSMFB4WnZQN0R6MXUvVTVsRDZBMVp1cWxpVjJGeWg3NFVB?=
 =?utf-8?B?SmJFd0VwK29vdEk4ZE5FTUlZak5oNzJUcWphb3ZaS2E0c3crNlRkd0JwbVY4?=
 =?utf-8?B?YVI0U2tiUGhCS0xjZ1A2OU13K2Q2STNkeVhIVUlHQnVPVjFNYnM3aUdSRTVv?=
 =?utf-8?B?NVpVSTIvdHBCOU9MdWlQL3hZUzZsaGRoaDVYN0xnbnFoNVk4ZlF4NFdFK2hC?=
 =?utf-8?B?ZzdiZzAyd2hWYXhQN0t4bWVrVVM4dWx6ODFIUjR2bk5SRjZBanEzd3gzdGh0?=
 =?utf-8?B?M095RzhrbEZHMmsvYWVlU2ZvT25uQmtmWDFYVTVJTnl5UGU3UDdZb284NDE5?=
 =?utf-8?B?bmx6VmRBTUM1cndaWDNsekppZXY1KzhIa0huaWk2MFJUNXk1eVZaaTNNK28z?=
 =?utf-8?Q?oDwkXkyy/udayqNoB3DiqcDTX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D55CD3CAF970044A392B8D8D081B033@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB7680.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f46def9f-b774-40ec-6014-08de0d34a398
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 04:21:26.7052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iNuyfSMQvwQzVT19abBEJ+BNqz3BnrxKKCtiawcm7heVsO0XvC/TCv0NkmduFziwEW9f++u766AUa7OOSh1d+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6959
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251016_212137_628661_026451DD 
X-CRM114-Status: GOOD (  22.35  )
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

SGkgVGFvLA0KDQp0aGFuayB5b3UgZm9yIHRoZSBmaXguDQoNCk9uIDIwMjUvMDYvMTAgMTg6NTcs
IFRhbyBMaXUgd3JvdGU6DQo+IFRoZXJlIGlzIGFuIGluZmluaXRlIHJlY3Vyc2lvbiBidWcgbm90
aWNlZCBpbiBydXN0IHN5bWJvbHMuIFRoZSByb290IGNhdXNlIGlzDQo+IHVuY2xlYXIgdG8gbWUu
IFRoaXMgcGF0Y2ggd2lsbCBhdm9pZCB0aGUgYnVnIGJ5IHNraXAgdGhlIHJlY3Vyc2lvbiBvZiBy
dXN0DQo+IHN5bWJvbHMsIHNpbmNlIGN1cnJlbnRseSB3ZSBkb24ndCBuZWVkIHRvIGRlYWwgd2l0
aCB0aG9zZS4NCg0KSSBjb25maXJtZWQgdGhhdCB0aGUgcmVjdXJzaXZlIGR3YXJmX2NoaWxkKCkg
Y2FsbHMgcmVzdWx0IGluIGEgbG9vcCwgYW5kIA0KSSdtIGFsc28gbm90IHN1cmUgaG93IHdlIGNh
biBhdm9pZCBpdCBjb3JyZWN0bHkuICBJIHRoaW5rIGZvciBub3cgdGhlcmUgDQppcyBubyBkZW1h
bmQgZm9yIGVwcGljICsgUnVzdCB3aXRoIG1ha2VkdW1wZmlsZSwgc28gSSBjYW4gYWdyZWUgYWJv
dXQgDQpza2lwcGluZyBSdXN0IERJRXMuDQoNCkkgdGhpbmsgdGhhdCBwcm9iYWJseSB5b3UgdHJp
ZWQgdG8gc3VwcG9ydCB0aGVtIGFzIG11Y2ggYXMgcG9zc2libGUsIHNvIA0KdGhlIHBhdGNoIGhh
cyB0aGUgbGFuZyBjaGVjayBpbiBzZWFyY2hfZG9tYWluKCkuICBidXQgYSBoYWxmd2F5IHN1cHBv
cnQgDQptYXkgYmUgY29uZnVzaW5nLCBpLmUuIG1heWJlIGEgdXNlciBjYW5ub3QgZGV0ZXJtaW5l
IHdoZXRoZXIgaXQncyBub3QgDQpzdXBwb3J0ZWQgb3IgYSBidWcuDQoNClNvIGNvdWxkIHdlIHNr
aXAgaXQgaW4gZ2V0X2RlYnVnX2luZm8oKSBsaWtlIGJlbG93IGFuZCBkZXNjcmliZSB0aGF0IHRo
ZSANCmVwcGljIGV4dGVuc2lvbiBkb2VzIG5vdCBzdXBwb3J0IFJ1c3QncyBkZWJ1ZyBpbmZvcm1h
dGlvbiBpbiB0aGUgbWFuIHBhZ2U/DQoNCkBAIC0xMDA3LDYgKzEwMTAsMTIgQEAgZ2V0X2RlYnVn
X2luZm8odm9pZCkNCiAgICAgICAgICAgICAgICAgICAgICAgICBFUlJNU0coIkNhbid0IGdldCBD
VSBkaWUuXG4iKTsNCiAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIG91dDsNCiAgICAgICAg
ICAgICAgICAgfQ0KKw0KKyAgICAgICAgICAgICAgIC8qIE5PVEU6IGN1cnJlbnRseSBSdXN0IGlz
IG5vdCBzdXBwb3J0ZWQuICovDQorICAgICAgICAgICAgICAgaWYgKGR3YXJmX3NyY2xhbmcoJmN1
X2RpZSkgPT0gRFdfTEFOR19SdXN0KQ0KKyAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7
DQorDQogICAgICAgICAgICAgICAgIHNlYXJjaF9kaWVfdHJlZSgmY3VfZGllLCAmZm91bmQpOw0K
ICAgICAgICAgICAgICAgICBpZiAoZm91bmQpDQogICAgICAgICAgICAgICAgICAgICAgICAgYnJl
YWs7DQoNClRoYW5rcywNCkthenUNCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVGFvIExpdSA8bHRh
b0ByZWRoYXQuY29tPg0KPiAtLS0NCj4gICBkd2FyZl9pbmZvLmMgfCAxNSArKysrKysrKy0tLS0t
LS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2R3YXJmX2luZm8uYyBiL2R3YXJmX2luZm8uYw0KPiBpbmRleCBh
M2EyZmQ2Li43Mzg0MmFiIDEwMDY0NA0KPiAtLS0gYS9kd2FyZl9pbmZvLmMNCj4gKysrIGIvZHdh
cmZfaW5mby5jDQo+IEBAIC04MzcsNyArODM3LDcgQEAgc2VhcmNoX3N5bWJvbChEd2FyZl9EaWUg
KmRpZSwgaW50ICpmb3VuZCkNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIHZvaWQNCj4gLXNlYXJj
aF9kb21haW4oRHdhcmZfRGllICpkaWUsIGludCAqZm91bmQpDQo+ICtzZWFyY2hfZG9tYWluKER3
YXJmX0RpZSAqZGllLCBpbnQgKmZvdW5kLCBpbnQgbGFuZykNCj4gICB7DQo+ICAgCWludCB0YWc7
DQo+ICAgCWNvbnN0IGNoYXIgKm5hbWU7DQo+IEBAIC04NTksMTAgKzg1OSwxMSBAQCBzZWFyY2hf
ZG9tYWluKER3YXJmX0RpZSAqZGllLCBpbnQgKmZvdW5kKQ0KPiAgIAkJCWlmIChpc19jb250YWlu
ZXIoJmRpZV90eXBlKSkgew0KPiAgIAkJCQlEd2FyZl9EaWUgY2hpbGQ7DQo+ICAgDQo+IC0JCQkJ
aWYgKGR3YXJmX2NoaWxkKCZkaWVfdHlwZSwgJmNoaWxkKSAhPSAwKQ0KPiArCQkJCWlmIChkd2Fy
Zl9jaGlsZCgmZGllX3R5cGUsICZjaGlsZCkgIT0gMCB8fA0KPiArCQkJCSAgICBsYW5nID09IERX
X0xBTkdfUnVzdCkNCj4gICAJCQkJCWNvbnRpbnVlOw0KPiAgIA0KPiAtCQkJCXNlYXJjaF9kb21h
aW4oJmNoaWxkLCBmb3VuZCk7DQo+ICsJCQkJc2VhcmNoX2RvbWFpbigmY2hpbGQsIGZvdW5kLCBs
YW5nKTsNCj4gICANCj4gICAJCQkJaWYgKCpmb3VuZCkNCj4gICAJCQkJCXJldHVybjsNCj4gQEAg
LTkyNCw3ICs5MjUsNyBAQCBzZWFyY2hfZGllKER3YXJmX0RpZSAqZGllLCBpbnQgKmZvdW5kKQ0K
PiAgIH0NCj4gICANCj4gICBzdGF0aWMgdm9pZA0KPiAtc2VhcmNoX2RpZV90cmVlKER3YXJmX0Rp
ZSAqZGllLCBpbnQgKmZvdW5kKQ0KPiArc2VhcmNoX2RpZV90cmVlKER3YXJmX0RpZSAqZGllLCBp
bnQgKmZvdW5kLCBpbnQgbGFuZykNCj4gICB7DQo+ICAgCUR3YXJmX0RpZSBjaGlsZDsNCj4gICAN
Cj4gQEAgLTkzMiw3ICs5MzMsNyBAQCBzZWFyY2hfZGllX3RyZWUoRHdhcmZfRGllICpkaWUsIGlu
dCAqZm91bmQpDQo+ICAgCSAqIHN0YXJ0IGJ5IGxvb2tpbmcgYXQgdGhlIGNoaWxkcmVuDQo+ICAg
CSAqLw0KPiAgIAlpZiAoZHdhcmZfY2hpbGQoZGllLCAmY2hpbGQpID09IDApDQo+IC0JCXNlYXJj
aF9kaWVfdHJlZSgmY2hpbGQsIGZvdW5kKTsNCj4gKwkJc2VhcmNoX2RpZV90cmVlKCZjaGlsZCwg
Zm91bmQsIGxhbmcpOw0KPiAgIA0KPiAgIAlpZiAoKmZvdW5kKQ0KPiAgIAkJcmV0dXJuOw0KPiBA
QCAtOTUwLDcgKzk1MSw3IEBAIHNlYXJjaF9kaWVfdHJlZShEd2FyZl9EaWUgKmRpZSwgaW50ICpm
b3VuZCkNCj4gICAJCXNlYXJjaF90eXBlZGVmKGRpZSwgZm91bmQpOw0KPiAgIA0KPiAgIAllbHNl
IGlmIChpc19zZWFyY2hfZG9tYWluKGR3YXJmX2luZm8uY21kKSkNCj4gLQkJc2VhcmNoX2RvbWFp
bihkaWUsIGZvdW5kKTsNCj4gKwkJc2VhcmNoX2RvbWFpbihkaWUsIGZvdW5kLCBsYW5nKTsNCj4g
ICANCj4gICAJZWxzZSBpZiAoaXNfc2VhcmNoX2RpZShkd2FyZl9pbmZvLmNtZCkpDQo+ICAgCQlz
ZWFyY2hfZGllKGRpZSwgZm91bmQpOw0KPiBAQCAtMTAwNyw3ICsxMDA4LDcgQEAgZ2V0X2RlYnVn
X2luZm8odm9pZCkNCj4gICAJCQlFUlJNU0coIkNhbid0IGdldCBDVSBkaWUuXG4iKTsNCj4gICAJ
CQlnb3RvIG91dDsNCj4gICAJCX0NCj4gLQkJc2VhcmNoX2RpZV90cmVlKCZjdV9kaWUsICZmb3Vu
ZCk7DQo+ICsJCXNlYXJjaF9kaWVfdHJlZSgmY3VfZGllLCAmZm91bmQsIGR3YXJmX3NyY2xhbmco
JmN1X2RpZSkpOw0KPiAgIAkJaWYgKGZvdW5kKQ0KPiAgIAkJCWJyZWFrOw0KPiAgIAkJb2ZmID0g
bmV4dF9vZmY7


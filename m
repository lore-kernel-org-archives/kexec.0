Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA631E6F068
	for <kexec@archiver.kernel.org>; Tue, 23 Dec 2025 08:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=633s/+gZId/+m9ChdZWL5j/jUX0amtxFI//EpswL3xo=; b=CKgEtUH8JlR8MTQlFQZHOomkB+
	I8iPjHpHYAB5Sd/zUXpgJFXAuOEzQOjmaGWQ9rjj1jj1wrX88pvkESHZV/IVKR3L1/FGBhq+vr7Yv
	wylZqqpyvUisb4KI/hBJc7B8vUqat7Clt4Na1o8PMgHs7rXsDWVOqfofWnZ8NWuTFYKK1Z/FmQ0WH
	/C6fqN+vZQiShcfv9p1Ol25SGi9gD88n1/WJmlF/fXGm10JqxP9hS8wXPpZuQzzV//YTrI5Eyj4da
	BIN0MFFW6zdfarQD4QZKRmDzXZysBbmJwqDluhVeE5z92RNPZZD3qR7zxuGmAIVRyIv2Z97SkE28J
	/tX/4hfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXxQm-0000000EfXW-2G37;
	Tue, 23 Dec 2025 08:07:44 +0000
Received: from mail-japanwestazon11010067.outbound.protection.outlook.com ([52.101.228.67] helo=OS0P286CU011.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXxQk-0000000EfX6-19We
	for kexec@lists.infradead.org;
	Tue, 23 Dec 2025 08:07:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQpRkajqIKRGJUC154X1YiQtSzcc+sMRENgF0mU77Sal3NkCDnUq7dJXwIzjR6LPWVNh0B6DLLv4tDqy2DI6TqUrKilMWOYLK0Uwqr0TF/J/S8Xc+dzPOHcQNdwjjw5GSkDhtKvT8lBafFH8IOy+idRxsQVPxp+rqqblIzv3m4LCtJ+BWY7KA9s81kCdB+j6VUQsvW/PWL1L+O6Ft2qmuiY3xRSiLhuLfqgxZPWd/AKe4NgzGPRIGKYnl0lonM0yPdCpLHzTWjnA/WS4Vq4hexOb90EKWxFllaheA7cSczV2s+sNE8knemhaO3u048PsTpdHS122y48ow81/O+iqRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=633s/+gZId/+m9ChdZWL5j/jUX0amtxFI//EpswL3xo=;
 b=QkU0VTNEyuxCHuBSUxT9lv4qlBfrFWwH2vgz7c/UImI65ceWYO+KuijtcylMqR1swhvJ/1NckjzalLX2tQK4i6MJTI87N4+3Ax/bF1e6vrEorIFxa8lp0d1Zwc/In5DoXd1yuwuVj20Iu/a32LWmUB7NY2rbAwlDHlRiJIIDDif/Mv8YPmVLhf703nOPr5BTp1ZzD60kVQyfK7AqBw/UOuNNxTQgpRi/1L6Q0GkdSv6qQ0j/T12niC4igWDH6EJCyWHDbJ3EtClOR7P+69lPPst9BoNeIL/yEbPrGiT/YSSixZR1XryxyM3A3xe7O5GsFJs0mpsheB0SBma6hqfnKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=633s/+gZId/+m9ChdZWL5j/jUX0amtxFI//EpswL3xo=;
 b=Pm5NtZUiVMOnqDpo1TW5hvBRBwzBN4TmYdv0eHmJRse/3EMosvVwSmnk+/zIoEq6jivUHpOpKmVj8+osdbdLoF//DFkU4beqmJ67PBv3qG84Gi7bW/cVLECagLUSBYFw9EyjTvmNV9o8B9nKXraPHUeZfm2VGuTAPXDsxvj+JrXThxGBuxQ3+pu5SDn3wEwLFcWz3Q4N9ZeCgPPaIfhyCfMtIt8XQ9ZO/EJDz7TFylkutxjp7nM4A85R0LQXFijGPme+unqNR0T6lkCqj3OPLbznkAYYRvDqj1/TztDuPAwRgWPI1eykN0kLqk+5KfJpUDnXhkkaDF8BJEG34TlFow==
Received: from TY7PR01MB14510.jpnprd01.prod.outlook.com
 (2603:1096:405:245::11) by TY7PR01MB13692.jpnprd01.prod.outlook.com
 (2603:1096:405:1ef::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.8; Tue, 23 Dec
 2025 08:07:34 +0000
Received: from TY7PR01MB14510.jpnprd01.prod.outlook.com
 ([fe80::2ab8:58c8:b276:9f7d]) by TY7PR01MB14510.jpnprd01.prod.outlook.com
 ([fe80::2ab8:58c8:b276:9f7d%4]) with mapi id 15.20.9456.008; Tue, 23 Dec 2025
 08:07:34 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Tao Liu <ltao@redhat.com>
CC: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
Subject: Re: [PATCH v2][makedumpfile 14/14] Introducing 2 eppic scripts to
 test the dwarf/btf eppic extension
Thread-Topic: [PATCH v2][makedumpfile 14/14] Introducing 2 eppic scripts to
 test the dwarf/btf eppic extension
Thread-Index: AQHcQhBsPdkljmzjr0iicEGgWap9x7UvQkIA
Date: Tue, 23 Dec 2025 08:07:34 +0000
Message-ID: <d469ccde-a000-45f4-820d-f74977c08a2c@nec.com>
References: <20251020222410.8235-1-ltao@redhat.com>
 <20251020222410.8235-15-ltao@redhat.com>
In-Reply-To: <20251020222410.8235-15-ltao@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14510:EE_|TY7PR01MB13692:EE_
x-ms-office365-filtering-correlation-id: 26328531-643f-4e97-6754-08de41fa546a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?L0svczlPc2pIaGJPaHdjblBzZ3dHUzZ3d1NPcFBSc0RyL2lBNnZLMHoyNE9C?=
 =?utf-8?B?ZG0yaENsOW5OekdIM0VMQzdWY2ROU1ZUaVo5Njkxc0VScGlSb1ZQcGVYQ2JC?=
 =?utf-8?B?djBnZ2RmeWo3aDhoWlRTMmZFYzMrSHg0TnBXVzRiVUFNcGMyVDR6YU82SjV6?=
 =?utf-8?B?UnRJSXVaWmlyOFQ2UEtMQlBjVExnYktyRGpXREZqNC9rMUcwRGYwOVRYZmNX?=
 =?utf-8?B?Ly9mSmpKNFdCcmZiNEdFWWpNc0pMSzI1aFF0SVRtZEhnY3hKTnJ0dHcyQ0o0?=
 =?utf-8?B?OHZ2VlZ0amRzdE5zWWJmbXYwS09qWXYwclRSRXhqbFU0bURpNkNzZmMyeWd4?=
 =?utf-8?B?WTVJdUdJNURJZ04xQ3EvdHRXZHlxZ0JjWHlkdXBaMi82a1hVMDhSajQ5bHRw?=
 =?utf-8?B?ZmdKZkxjaGVDL242dXdXb2h0QUFqQTRSenp2WXlwbUorYnAvK3BGR1A3cElS?=
 =?utf-8?B?K202WWtSZFRUL0JLWk5NYU5mTitKc0drM01DYlJWamR3d1VoYlQxOTV2KzBK?=
 =?utf-8?B?UEZCSFhYYi8zZU5rZ003R250cGlxRE1XWlBLb2RnYUo1TDR0ajFvQXc0VHgx?=
 =?utf-8?B?NnNubmVXdlY4MklzTmpwMXQraDYxcXVLL2hld0NqRG01YjBIaHFwNTEydUFZ?=
 =?utf-8?B?MHhlbzVscHdxaXlpaHpJVzc3Q3BQQ24xYzNrUDFMcSt3Z2k2VnlMN1ROUDcv?=
 =?utf-8?B?MFdRckRWSkplblBWbHVLczlNWVVFTVg3U2pRNWkvOVRwVEUwaVpSdUtEZDd1?=
 =?utf-8?B?dDdIUjRtU1FVWHMvUXlCNDdYQzJVU3ltUTh3TTlOVm5KaXl6YnpGMW1VYzFK?=
 =?utf-8?B?U0pUS2x5VWxVMnRiNlliSTgyWFZER1pBcDN2NXAvUEc2RUgxMFYwN0VOL01C?=
 =?utf-8?B?L3pTZmQ0K21SRVdTN2M5dlVPVElTMGx0UEwyMGV4ZmVlYUo3RDNhQlduY1FC?=
 =?utf-8?B?aUYzdWlFYW1VeGNrY0ZVL2RqbkZvUllPVmxRK0pWaVptNERvWTRob0hEWGtD?=
 =?utf-8?B?dFFvSk44ZlhReTNlVW5CbkpGNmpoYXgvNC9QUG9qeTZsSC9zS1ZyRmZGdmlF?=
 =?utf-8?B?RjQvYWx0VDl3L0dhLzYveW1LNzdVc0YrVmZLS1BzRW0wOFU1akNwc0hVcjIy?=
 =?utf-8?B?Z1NNTDYzSkU5elN0UFA3YWZUcTdsYkc5ck44NXVpcjBTaGN4NUg1Q2VFOC90?=
 =?utf-8?B?Y3N5eDB1WG9FZU5xK0ZmQmpTWStaS0V3dml0YnUzNC9lc1pqbWR1UGY3dGNH?=
 =?utf-8?B?L3cwamV5TmEzTTNIdkFXYkNYd2FSYW8xc2ZTU2JrYWhpaDgranowR0FHRW51?=
 =?utf-8?B?T3lzNWlLZEJiQTJvakdpaVltVzl0YTl0R3Q0R24zQndTWCsyb21lUHJ6Yi9u?=
 =?utf-8?B?Q2pzUHpYUytxNUxIaS93UHhwblFKTHB4b0t3K0FkMlZlV1JZQWlUeHdSQkty?=
 =?utf-8?B?aG41NldFTkVRaVRPMDhwby9ncU1EUDh4SEw1WjNWK0MyNFRMYTFRVzlMRENp?=
 =?utf-8?B?NGl5c1dmRGg5QkNaa3BVcFFtTzVtRDdyaWZaeEVJNTlSb3k1akdacWZRd1RO?=
 =?utf-8?B?YXFwYlYzbzJ1Q2xkTC94Y2poWVlUZnhWYk1ZRFJsM1pKM1BMSVJOaytCcGpF?=
 =?utf-8?B?TVdGN2F6WUFaZVJHZFptVlVVZ3NqbjdpdDJQY2w2NmlpZHBBbFRPdGVhLzZT?=
 =?utf-8?B?YXArYzkyRlJYOW1xR1FsNDAvbzl2RDJ0NmVvakEwVnpqNDZBOU9KdmtyNHRY?=
 =?utf-8?B?RFZUQ1ZMRERXS01uRlA4ODQ3SmdLZ0lzeVFFV1NWZ3NDSXVGL0MvaVQ3MnBH?=
 =?utf-8?B?dWk5ajAwSFNQaVZJZk1Ib1Ara1BlT2JmQTQ4MDVpNm1uYmlvbE9NMmhKK0VP?=
 =?utf-8?B?WlNXTllRQkVWTWpsbnlqOTFRVmt0OTlQYWFTUW5YaXRFSjNZcCthdXZYNFkw?=
 =?utf-8?B?S1BKakV4Tk0wRyt5MjNmWTVsUEtocGNIdGlzU2gzZkFyRWMvSE9YdzZmT2Vm?=
 =?utf-8?B?UDlWczZsNVdKUTdSaEZyb1RmRDJHZXl4S1Mxd1Bva2lsako4VFRZR01aV0ph?=
 =?utf-8?Q?Iw5Dbi?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14510.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enFpN2o2bkdQbzcwcStzUlB5akRVYVd5M1B1WG00YjlvZ3h6cHJlUTBKOE9Q?=
 =?utf-8?B?UGxKcU1BRTRaa2t6bGxLT1ZEQnNqVU1wSnB4ZmZzK0sxc00rLzdTM1BJODNz?=
 =?utf-8?B?YzJ1K2hSeHZTSjNDdFZXUFhXR05SR0pLVE9iaHJURWNiN2RBTlF4eTNPRVdu?=
 =?utf-8?B?M0N2UnNIT05XVWUxL0tYS090S0xlRERXNGJQZXlmNGk1TU1YcEJHQXY3Q0ZO?=
 =?utf-8?B?UFUvRWt5cm9IVko1eFVESGNyNXFZZm9OZmo2YnJZN3V6V1EyckZtWGFNWVFu?=
 =?utf-8?B?Y1kwblpqdEFPZ1ViajNMWWhHRXRLbHJSZllEbU9wR1o3dFBtTWlRQ09QMzZZ?=
 =?utf-8?B?WUxFOTZLcDlOSkdaSzNQWk5TVzEvWVNTUmxlbnZLa2VZd2VVOXM0NkNrM2Rq?=
 =?utf-8?B?Y3RnNHZ4OEsrVkZJNnIrSTFhb3RENUNYYWh6SGoxSFVOQ3BjZVRTU1RUblA2?=
 =?utf-8?B?Ykp1WkdBNWxrNm82TU9tdjR4VkJJRzdSVWp3RWU1d3V5eE5lZlRTNUYrRnVm?=
 =?utf-8?B?TUVYRjlrVWhFQkNJeTVRRkhQTFV0aE1CRVJRREVFcjFHUEgxU1lkUVBNZmNw?=
 =?utf-8?B?MjBCQkg4MjNJVUxlVGZJMElqa0NibEpYcmdBZ2ViWGVNU0pIM2QrcklITGtF?=
 =?utf-8?B?eDFYRTdmQ2xkdUtrY0duMmVwK1dtYWcyVnZ4VzVxWEZpVmp6MWJvaGJVNjE2?=
 =?utf-8?B?T2wvZHNEcWJTL205QkEwTmN1Z3loNDhNak5nbElpS2tWbS92MGpoTzdyZWNn?=
 =?utf-8?B?aXB3VlFPTS8rV0kzNElGTHRTcDFLc0NHQmpYUmcySXI4djVkZnVrTFhRWVlN?=
 =?utf-8?B?NXJDaDNFQTkydjlUL0FPbGJDTXpuays3NzB1M0I4WGNRNVFjckJGNHl5bzVK?=
 =?utf-8?B?ZDJjbzNESmVMVFVVb3grZWtKVTJrNklQVkVNeHdjMHlKZ3pPSXc1MkVjc2sw?=
 =?utf-8?B?MnFoMGFkSjlyN2syRFNIWHFUWjRueDZYazdqL2NiSnRnSXREdXI5MzBTMHVu?=
 =?utf-8?B?djl1aUFFTTB0VVMxRi9oRjNUSWJEVUdpRHRoWEZ2NjJSbTBXN24yeHo1TW9F?=
 =?utf-8?B?WGhLOXNUVlo3cHpiTy9oN0VTcGszbkd2dDZCTlcvTFhWSHYvQjNyY3hPYUZ1?=
 =?utf-8?B?U3JuS3Q0K3RRbjdpVEJnSnlxdzZreXo0NWw5RHBNaS9jbzNaQXdFVEx5UElk?=
 =?utf-8?B?cTI5UGFQZjVYRk1TNjNrNloybUNUaFI3TXUrUXlhR0VoRVY0UkR1eDBFNW9a?=
 =?utf-8?B?Mk5BY3ZrTnFOTHNQR2tSZlNwNFViNVRHclFZSHdsdURQRUtoVnZIVDNHcDV1?=
 =?utf-8?B?cU9ZQkZWU0JYR2dDcUdJUVZXbm5KODhnaGJ0amF1ODZ2TjJxZjRuN25Fci9O?=
 =?utf-8?B?cERnclFva1FmTGtCanhrS0ZCbXEvNERQV0RrelJ2bFl3a0ZkaHJoVWM4S0pI?=
 =?utf-8?B?NVJJeGg0b3dnVFNVUmVzUTlEdTA2VWxVdWxoUTQ0bHZINXA5ZStHeU5PRmNO?=
 =?utf-8?B?cTV2SXVVQlZ1S1A5Z3p2TTdKVFdPSXluMlpPZFVsR3Bia0Q1di9yM0t4RlJl?=
 =?utf-8?B?OE0rMHJFTHNsTHdYVXphNlRZK3FTYVJ0VDFDTkJYNEdjSTI2Q2h0ZmFnTlFP?=
 =?utf-8?B?cHpORmplOStzRUVLUTkwQWh1a2VMUnd4MmJLTlNlL2s2RExjMzkzc3ExbGt2?=
 =?utf-8?B?dVp2b3R1cFowNFVZU2VaTXRicnlrR0d3KzF2VTZZZFkrOENWS2F2RWFOaDI0?=
 =?utf-8?B?dUhTYTNseTFobWh0cXZ4YktQaDlwakhUZGhwT3BsM1RCdnpBa0hsL3p3NGpi?=
 =?utf-8?B?ZE94eXIvbkhFRVpITHgveUc1RCt0M2JCNWJETndnM0lsb01iN0VJTU55Tyt1?=
 =?utf-8?B?K01xaWdSKzd2VVhCWlRhNUNOd3c4bDFkRS9QSFMvN21HTnRGbElobkNoVkxu?=
 =?utf-8?B?TW1vR1JRSUFHNHBaQ25ZSzY5RXBycjQ1REtHeXB4UTFNQnVqT1VOWVZ6Q2M1?=
 =?utf-8?B?NjM5ams3d3k4WWh5bnQ0TXRMWGF1U2p6STlzTzJGNU1TS1A2eHpDTjhZaDZQ?=
 =?utf-8?B?enhlb0RTOWp2amxBeVpSZERzeVhINDBpTmg0SG5CWVZicmxIMzBRTWpoWWxw?=
 =?utf-8?B?dGFOUmRTQmtDQ0VndjgyeXk4WFYxcC9neTZEdldtQXIwSENDQXE0L0VaaHVw?=
 =?utf-8?B?M0p5YWpFN2pIUHYvOXRENk12VVhlaEMzNFdrYlN4amFhT0h1bEV0aVBiRGhZ?=
 =?utf-8?B?UXRKY1FvYStJb2RJcGFLUFdGZyt4OG1KWXpCaHRXOElDTGQ1UEF6UFM4bTlp?=
 =?utf-8?B?QWpENVR0bGppSmRaNm1qRFVkOHh2WUx4Ni9rbHVjalhzNXFHVXlMUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5EAC4FE24A7C94DB7029F67A989B282@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14510.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26328531-643f-4e97-6754-08de41fa546a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 08:07:34.6830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TuNAVzD1bwqfCbMGc02grVGfRQSf4+o8Xp/B2ca8Ap2giBvabQcaj/S/hujIZgvtndaKdviHG19ivuCyEu6OFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13692
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251223_000742_325334_10E4B2A6 
X-CRM114-Status: UNSURE (   9.28  )
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

T24gMjAyNS8xMC8yMSA3OjI0LCBUYW8gTGl1IHdyb3RlOg0KPiBUaGlzIHBhdGNoIHdpbGwgaW50
cm9kdWNlIDIgZXBwaWMgc2NyaXB0cy4gT25lIGlzIGZvciBmaWx0ZXJpbmcgb3V0IGFtZGdwdQ0K
PiBtbSBwYWdlcywgdGhlIG90aGVyIGlzIGZvciBwcmludGluZyBhbGwgdGFza3MgVk1Bcy4gZHdh
cmYgJiBidGYgZXBwaWMNCj4gZXh0ZW5zaW9uIHNob3VsZCBwcm9kdWNlIHRoZSBzYW1lIHJlc3Vs
dCBmb3IgZXZlcnkgZXBwaWMgc2NyaXB0LCBtYWlubHkNCj4gZm9yIHRlc3QgdXNlLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogVGFvIExpdSA8bHRhb0ByZWRoYXQuY29tPg0KDQpZZXMsIEkgdGhpbmsg
aXQncyB2ZXJ5IGdvb2QgdG8gaGF2ZSBtb3ZlZCB0aGUgbWFwbGUgdHJlZSBjb2RlIGludG8gdGhp
cyANCmVwcGljIHNjcmlwdC4NCg0KYnV0IEkgbWF5IHRoaW5rIGFib3V0IG5vdCBoYXZpbmcgbmV3
IGVwcGljIHNjcmlwdHMgaW4gdGhlIG1ha2VkdW1wZmlsZSANCnJlcG9zaXRvcnkgYW55IG1vcmUs
IGxpa2UgYXMgdGhlIGNyYXNoIGV4dGVuc2lvbiBtb2R1bGVzIGFyZS4gIEJ1dCANCnBsZWFzZSBr
ZWVwIGluY2x1ZGluZyB0aGlzIHBhdGNoIGluIHRoZSBwYXRjaHNldCBmb3IgcmV2aWV3IGFuZCB0
ZXN0Lg0KDQpUaGFua3MsDQpLYXp1


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57F4C43334
	for <kexec@archiver.kernel.org>; Fri, 22 Jul 2022 12:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DArMI3nK93VbDy+tV5v6m91VH1SLfsjHuZjdt/FIbCI=; b=hM2lUgDwZCd7RW
	zUC2AtZeCsLsc7P0RBkAHraKUZ/veNPgtG+T6FvmcrP+rCpx7flvmLROGWky032rY1hQ7QFBDBiz5
	cb68KEYXw53u23X7CyAiA2S7obmbw0PfwRdKz63o9xcO1lb5dqfci4ov6jNrYfgFgUaOn4/LwqKgF
	AA97V5BEKN8acf02IBj9ai511xb90MSDxmN8c5EJkTRAdSjqUNtzovojC1m+S84qTHaRkxixGuqFm
	ecD8Egb//xWJy+zEPhshskSuZVuWJ+K14KMzHE6YjRE+aAnBifCkdtI4fLyi1Lg54wYFHDMT71uDj
	Fb8IkX6ugA0Md2jos7rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oErOa-003uAc-LY; Fri, 22 Jul 2022 12:04:40 +0000
Received: from mail-eopbgr70081.outbound.protection.outlook.com ([40.107.7.81] helo=EUR04-HE1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oErOW-003u37-Tt
	for kexec@lists.infradead.org; Fri, 22 Jul 2022 12:04:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/WBEE+aCqaRisMwYB0sUKam5j40RDpfGvwW9RLhRDu37sC5dlxmfCgSnDHMWrcXVi3OBkNKt9QxO5oK7mro1P+hCOM7Cj6JOYNZ+4qTcXvr7FIK9x4A11flJlYJFtYEWaE/HPnxRXT9D76tHObWkxEkdwKOR+XbKmPgviZq/nn7MfAv0K8xHYKXGXwrO+Uuzzyc6p8YO6jYPk5LZihmyKNBpbZf71ipe6MktP5lI2+wZAvZAP3LqcEL2oDTCXXlsbg2zh7JCLTG2q2Po4gxl1ALukHhzPgdRPoxI4z6HkV8lw2uV8dbimZk0J0cuMtOzNMQYgNQFdrGr4JRkiQZRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wbc4QtPlXEEq2oOEJ4Cwf6EEbIoyqiN4UsM+6+Nz2aw=;
 b=mZc3+fwdCYZmIv5EEdrWeRDeTMKY4M4DtrPzWmZ5SJt4gwZfJ5l9ukrty1nV6c8yLF15obyZA6Fc6g4DDWKhrQ51WohzYS/nHou1Mii9pyUpMQG4GsfO29f+zyCyTEm0SfAlcpvvVMfUSvw5X+uYYGLI3pTkE9WA2uD2XLv+GR5q91l4+Bp2wpFm3RGadc+IROC9XE5AheYnrhgSYa97AYefzVAJdr2r0GUcKOwXFrlQXvgDEi2hTmpKCspzfYSfzn5Usf9Ab1ZQ0KNoBvWrPTlyUVgq3W/wPGUfXtg0iUP35j3PrvdaGVrRqTBhBHjoCeYrJ7OK72GqgZq9M1usMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=al-enterprise.com; dmarc=pass action=none
 header.from=al-enterprise.com; dkim=pass header.d=al-enterprise.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=al-enterprise.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wbc4QtPlXEEq2oOEJ4Cwf6EEbIoyqiN4UsM+6+Nz2aw=;
 b=OIXtKC4L/tP6Q4dVSYsN62EfL/wsFF6e3Dfja0B1uJ+1LhW2hHmKQ1m3JkQ2fM+iT5kN51FqHqu/Q68cy8eWox7LkzRyT4PsrjNUGUjd3RtfuJ/vht2k97OJb4gAk3LOz99fK/iYhsAZeBcfe7ndcgjMLwP/nvM6r/kAwy97iPs=
Received: from DB7PR08MB3273.eurprd08.prod.outlook.com (2603:10a6:5:28::29) by
 VI1PR0802MB2301.eurprd08.prod.outlook.com (2603:10a6:800:a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Fri, 22 Jul
 2022 12:04:30 +0000
Received: from DB7PR08MB3273.eurprd08.prod.outlook.com
 ([fe80::506d:8bb6:ab95:992b]) by DB7PR08MB3273.eurprd08.prod.outlook.com
 ([fe80::506d:8bb6:ab95:992b%3]) with mapi id 15.20.5438.023; Fri, 22 Jul 2022
 12:04:30 +0000
From: Agrain Patrick <patrick.agrain@al-enterprise.com>
To: "Discussion list for crash utility usage, maintenance and development"
	<crash-utility@redhat.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
Subject: RE: EXT: RE: crash: read error on type: "memory section root table"
Thread-Topic: EXT: RE: crash: read error on type: "memory section root table"
Thread-Index: AQHYSYqsWWrQEWxjFU+W0zFqakg/bazjAcDggKfvntA=
Date: Fri, 22 Jul 2022 12:04:30 +0000
Message-ID:  <DB7PR08MB327340019202DE669D03D18CCA909@DB7PR08MB3273.eurprd08.prod.outlook.com>
References:  <DB7PR08MB327305868D5DF87C2E31B972CA1E9@DB7PR08MB3273.eurprd08.prod.outlook.com>
 <TYYPR01MB67776D129929014239C34414DD1F9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
 <DB7PR08MB32733EC5606D43D47FDEDCC1CAE09@DB7PR08MB3273.eurprd08.prod.outlook.com>
 <TYYPR01MB6777C0B689B45FE92EB4712FDDE79@TYYPR01MB6777.jpnprd01.prod.outlook.com>
 <DB7PR08MB3273BAF582AD775E43E90B8ECAE79@DB7PR08MB3273.eurprd08.prod.outlook.com>
In-Reply-To:  <DB7PR08MB3273BAF582AD775E43E90B8ECAE79@DB7PR08MB3273.eurprd08.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=al-enterprise.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0bb81024-d06e-487f-881f-08da6bda554d
x-ms-traffictypediagnostic: VI1PR0802MB2301:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  iMggUgpNJh2iE6hG1PDNE8QaEEGTECal/3G64qnCMJ/iEM+urOWNq8QKtG2Re895YHpL5PfHIh9/8/Atz05CWkFIT7xX7RZ0HhIdJkS8qLAlgFG3JGFf4arS5Iohi6iKZIW9R+Mt5+NC2ynccByr9CeQm8Ln4qZo1iOylHWLg6HFoZCImLl22HreqgkylBBxKWBNCqnl9sofpjrDgqvWKeA0C7Vr90DOrlI/Hc0SphDdJvSuUngC37Py74+R1I7WowvD2ZyTSdvxhK4fANutsBxxhFnZyXmL93Dq4+XX9Ccq/m6g15cOgrVr83HhESZoLt3S4TZ8JYaf1H6hfGGhZ6kKlUJe+70pLRC5a5XFrZPLo+0F7KJ6mHLbN2xBrmQYPwOlIQywTxkExvGVYdDBxD7d55/2cH2H1dd7PkV7ErmMU7KFsSh2GDKiXMm9btI9+vhiXhnmV/peZ7xYGBgUMnsBQ3RHoRmWzYg2FrVIhp1mYKUuPfwmlehGnrgD0VPKRsL/zFRXJqlNJEGBnUoERgGOoTJJovu9Jj9fXJkTQEKmcf7qpvOYXI9jFYDsKmZZb0aQvkK3jAbYvnlZPcY04MDgQjQCbe25N2QwNBD3vR7EMHNYyFBe2WF67daMdyWvAdTwnVbmWSMtKVaY6LQMAv2xtoTk9+0QpbjDAcLRrfTdoP0kVFgFqRAk88DCY+NUU35To6wA5NdFQernLl0E/q+1wUp0W/J3H/agKANXaXXvV3t3BYDcamYiYH/dDR4kAaEOS64yuvNrD6niRfkexlcqul+1Opsgei6A3SCOPRA7/UMlHW0dOtxH9d/84HdbGzlaTiCzVD/u9Q/i9tvA1w==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR08MB3273.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(39860400002)(346002)(376002)(86362001)(66946007)(76116006)(2906002)(66556008)(66446008)(8676002)(122000001)(83380400001)(5660300002)(38100700002)(66476007)(82960400001)(8936002)(64756008)(38070700005)(52536014)(26005)(55016003)(110136005)(71200400001)(316002)(9686003)(41300700001)(33656002)(478600001)(6506007)(186003)(966005)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?VFRxbVdCemVrODN1VTVvNU9CMmwzVDh3d2E1WTlVSEpXWXpTVTV6QkZuaG1i?=
 =?utf-8?B?WCtlbE0zUnlmVnU1aEQvZ3JzeHM5WmFpd2xhalE0ZGhScTQ0MTZUYWp4S2hI?=
 =?utf-8?B?Ni9sTkM5cURzQnRxdkdEa2lRRGtNVm0wRFBtR2ZiWnhZanNqa012YXRzNith?=
 =?utf-8?B?ejFZQUhNc3pkditPZzhNWVNOaUk3ZWR1enBEa0FEaW0vQURFamw1cnhaaUE5?=
 =?utf-8?B?SGRaVDI3N2liVG9FL1BSV1Z5d3ZJTzNwcGxlUHI4dDNBb3NNNFJMS2R0djFB?=
 =?utf-8?B?WFNZV3k5cDQ2SHU3bHF6OEdTMi8rZytMWWh3d241VHZOa1VRdHJHb2RKck1J?=
 =?utf-8?B?TVRQMVdmM1FxMGw4NldodmxzRVBZaW1lSFpqcy9aUlNoR2lTa0U1YTlwTXdu?=
 =?utf-8?B?VVA1R3BnT3RrSXdjY1l5WVhDMUJ4NklEVnhyVzBrdWpDRk05SHd2TnpWRFhx?=
 =?utf-8?B?ekpoYmRBMDBCOXloNks5dGh0ay9kdk40WDRaM0NuY09qRjJ5TU1ta3hMVEg5?=
 =?utf-8?B?VkwyVFNML1JMNUFmZGlpNm1Id0ZKaCswU2cyVlI5dFFJTDFoTG9yZnJyYTFT?=
 =?utf-8?B?VTVRdTQ5dlZkQ01VWUhSWlpVRW4xZFR3OHVYeTZFWUVzYlcxK0RqUkttR215?=
 =?utf-8?B?eWFBYytxNVRCR0R4cC9SbE5YdUI3V2JRd2JkL1AyUDY0SitFK00wNFptWVVo?=
 =?utf-8?B?SzNsZFNJV05NWGZZVndIWERJY1dzTE82aGFISWFabjZmK2E1ZERCaFhnM21x?=
 =?utf-8?B?VGtVSjRiWlRvVXMyenRvTDdSNC9xamlhcnV0UEZiVWNpOG1WSU4yaVpVMmFp?=
 =?utf-8?B?cVNoQkhLa3hPdG5hL0M3dkFLL1hESU5Nb2UrMVJta0YyOTZCRGMxZzNtNm5l?=
 =?utf-8?B?L1ZuRW8xV3l5NjhXWGxTK0Mxc1Yzb21RNis1K2xsVi9WdE5CWjJZeEFiMzZ5?=
 =?utf-8?B?a21xaWpvenIweERrOGNhdXhIZ3RlWnFIbEY1TVhlNDFxUTFLSGx3Z0ZiZTF2?=
 =?utf-8?B?WTdSeGd5M2ZEdVZhVDBJcFBCSEQvU2RFSnVDb3BtV0dJOTB3TjUvVEFRMjRP?=
 =?utf-8?B?NlRHalVtaVU5U2hjcnZFOHMvbVdjUE9oQm0wbzFPRk9McUhWQjU1ODRkWUlT?=
 =?utf-8?B?L2o3cEVxU25GUy9nZjQybTNwaVEvR1pDcnRtTUJaWXN4NmxQbTU4VEpkOHlZ?=
 =?utf-8?B?bjZBRXVndjA2Si9KR1RKV2JubTFKQ09yZVBrM3ZRNXBZaDJhQTNBZkV6czVO?=
 =?utf-8?B?QTEwV0ZyeFptQ25PR3hkMVU1QXlxVjc3QkNKTmV5U1h6R2FLK1VCYVZMQW1w?=
 =?utf-8?B?RkpFTFNLUUFkSzJick9UVzRQenc0NDhsbUJRQ0lUSjhzT1JHSkFCdWwwR21K?=
 =?utf-8?B?Q1J5QVMza0lPTTBoTjY5eHcxbHJyeGZkcS9hbEdLMFBIM0FtNTR5UWd2c1Vp?=
 =?utf-8?B?V1ByTDZSR2dSQXhKOHZwaTlhZWpxcDRnS0czY0xWRFVUdWJmd2tZOEJUelJp?=
 =?utf-8?B?cmczb3hCT3BqaTJ5V2J6YS9MdHhkaHpRZ25HSURic0l3U0w3T2RVblZnYVRN?=
 =?utf-8?B?TDByTE54VXNJZnowNFJ1dHJkcERKS2IyY3RNR0pVK0FlckpucHVjQktVc21v?=
 =?utf-8?B?Q1dMVkFnYmVzTXJBUVR3MnpaMjJ4aXNTSzA2ZXZQc1V3VkxzV29TbHZmajBM?=
 =?utf-8?B?dTB4aHNwWmtIaElVRERWM25GRU16Si9OVU1ZaU1nVjZpbEFnZllXVUQvRzBa?=
 =?utf-8?B?Ny95UURHRnEreEZtVUFucjJGMEwyRzdQQ2taSzRUd2VvVHRZUEtaYm83QkRH?=
 =?utf-8?B?Y21mNEpaVTRRdFhJZkdDS0ZkVFJBUyt1UEtkRkMzeHg5amVQM3VUeVllOGFI?=
 =?utf-8?B?RUdpdnVVY2VoczkyOGpad0IxZ2NLdXV2MWRxeUVpeGlDNGcyVE1LdVNSYUhj?=
 =?utf-8?B?R0E0blNXU2NpbUdWWElHR2FiNFgwZlhaaFk1aTQwTUI2RndNWjRRb3hUYmpj?=
 =?utf-8?B?MjFzR0NtaExSMXozMm5ud2Mwd2wyK0FFRUVTVEppNHc2T3lXU09QbXBBanJz?=
 =?utf-8?B?UTNjMHZXQ3hYVmVmakhVQUhUSXp5ekRXd0Vtd0Z6RTUvRnNDR0E4QnJQbm9i?=
 =?utf-8?B?cGxxYk1kdzNTY0p2SEsrcTgzTjZTeTJ1N0wvdmFqN2N3d2xlNFU2K0RJSFZJ?=
 =?utf-8?Q?6y00rJXB4f02TeqWtWvOakI=3D?=
MIME-Version: 1.0
X-OriginatorOrg: al-enterprise.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR08MB3273.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb81024-d06e-487f-881f-08da6bda554d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 12:04:30.3752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e410eb7-628b-4a1c-ab28-642f4be058a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zz2dll9nrpzpyPJRwCCOsgcMw4zCS+uTu7KOQ5sSmx+f9CGKKgMuPpHaU5n49M/gZqLNz/JcD6zQyoIwluo/l59d8mT/8CorNBbc84UMrnM/9cba/SmnzHSNcOIQ0y5z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2301
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220722_050437_521476_32B03579 
X-CRM114-Status: GOOD (  10.00  )
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

SGVsbG8sDQoNCkJhY2sgdG8gdGhpcyB0b3BpYy4NCg0KSSB1cGdyYWRlZCBvdXIgc3lzdGVtIHdp
dGggdGhlIGtleGVjLXRvb2xzIGZyb20gQ2VudG9zIDggU3RyZWFtLCBiYXNlZCBvbiBrZXhlYyAy
LjAuMjQgYW5kIG1ha2VkdW1wZmlsZSAxLjcuMS4NCldlIGFyZSBzdGlsbCBmYWNpbmcgZXJyb3Jz
IHdoZW4gdXNpbmcgJ21ha2VkdW1wZmlsZSAtYycuDQoNClJlbW92aW5nIHRoZSAnLWMnIGdpdmVz
IGJldHRlciByYXRpbyBzdWNjZXNzL2ZhaWx1cmUsIGJ1dCBzb21ldGltZXMgdGhlIGNyYXNoIGZp
bGUgY2Fubm90IGJlIHJlYWQgYnkgdGhlIGNyYXNoIHRvb2wuDQoNClJlZmVycmluZyB0byBIYWdp
bydzIHJlbWFyayBiZWxvdyBjb25jZXJuaW5nIHRoZSBzeW5jLCBJIGFkZGVkIGEgc3luYyBvcGVy
YXRpb24gYmVmb3JlIHRoZSBjYWxsIG9mIG1ha2VkdW1wZmlsZSAoYW5kIGp1c3QgYWZ0ZXIgdGhl
IG1vdW50IGV4dDQgb2YgdGhlIHJlcXVpcmVkIHBhcnRpdGlvbnMpIGFuZCBhZGQgYSBzZWNvbmQg
Y2FsbCB0byBzeW5jIGFmdGVyIHRoZSByZXR1cm4gb2YgbWFrZWR1bXBmaWxlLg0KSW4gdGhhdCBj
b25maWd1cmF0aW9uLCB0aGUgY3Jhc2ggZmlsZSBjYW4gYmUgcmVhZCBieSB0aGUgY3Jhc2ggdG9v
bCAodXAgdG8gbm93IGluIGFsbCBjYXNlcykuDQoNClRoYW5rcyBmb3IgeW91ciBoZWxwLg0KQmVz
dCByZWdhcmRzLA0KUGF0cmljayBBZ3JhaW4NCg0KLS0tLS1NZXNzYWdlIGQnb3JpZ2luZS0tLS0t
DQpEZcKgOiBDcmFzaC11dGlsaXR5IDxjcmFzaC11dGlsaXR5LWJvdW5jZXNAcmVkaGF0LmNvbT4g
RGUgbGEgcGFydCBkZSBBZ3JhaW4gUGF0cmljaw0KRW52b3nDqcKgOiBtZXJjcmVkaSA2IGF2cmls
IDIwMjIgMTc6NDgNCsOAwqA6IERpc2N1c3Npb24gbGlzdCBmb3IgY3Jhc2ggdXRpbGl0eSB1c2Fn
ZSwgbWFpbnRlbmFuY2UgYW5kIGRldmVsb3BtZW50IDxjcmFzaC11dGlsaXR5QHJlZGhhdC5jb20+
OyBrZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnDQpPYmpldMKgOiBSZTogW0NyYXNoLXV0aWxpdHld
IEVYVDogUkU6IGNyYXNoOiByZWFkIGVycm9yIG9uIHR5cGU6ICJtZW1vcnkgc2VjdGlvbiByb290
IHRhYmxlIg0KDQoNCg0KLS0tLS1NZXNzYWdlIGQnb3JpZ2luZS0tLS0tDQpEZcKgOiBIQUdJTyBL
QVpVSElUTyjokKnlsL7jgIDkuIDku4EpIDxrLWhhZ2lvLWFiQG5lYy5jb20+IEVudm95w6nCoDog
bWVyY3JlZGkgNiBhdnJpbCAyMDIyIDA5OjQ4IMOAwqA6IEFncmFpbiBQYXRyaWNrIDxwYXRyaWNr
LmFncmFpbkBhbC1lbnRlcnByaXNlLmNvbT4NCkNjwqA6IERpc2N1c3Npb24gbGlzdCBmb3IgY3Jh
c2ggdXRpbGl0eSB1c2FnZSwgbWFpbnRlbmFuY2UgYW5kIGRldmVsb3BtZW50IDxjcmFzaC11dGls
aXR5QHJlZGhhdC5jb20+OyBrZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnIE9iamV0wqA6IFJFOiBF
WFQ6IFJFOiBjcmFzaDogcmVhZCBlcnJvciBvbiB0eXBlOiAibWVtb3J5IHNlY3Rpb24gcm9vdCB0
YWJsZSINCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gSGVsbG8sDQo+IA0KPiBTdWdn
ZXN0ZWQgdHJhY2UgYWJvdmUgZ2l2ZXMgZm9sbG93aW5nIGluZm9ybWF0aW9uIGFmdGVyIGEgY3Jh
c2ggLWQgOCBjb21tYW5kOg0KPiA8Li4uPg0KPiBrZXJuZWwgTlJfQ1BVUzogMg0KPiA8cmVhZG1l
bTogZmZmZmZmZmZhNDkyNTgyMCwgS1ZBRERSLCAiaGlnaF9tZW1vcnkiLCA4LCAoRk9FKSwNCj4g
NTYwMTdiNTQyNjQ4Pg0KPiA8cmVhZF9kaXNrZHVtcDogYWRkcjogZmZmZmZmZmZhNDkyNTgyMCBw
YWRkcjogMTI5MjU4MjAgY250OiA4Pg0KPiByZWFkX2Rpc2tkdW1wOiBwYWRkci9wZm46IDEyOTI1
ODIwLzEyOTI1IC0+IGNhY2hlIHBoeXNpY2FsIHBhZ2U6IA0KPiAxMjkyNTAwMA0KPiBHRVRCVUYo
MzI4IC0+IDApDQo+IEZSRUVCVUYoMCkNCj4gR0VUQlVGKDMyOCAtPiAwKQ0KPiBGUkVFQlVGKDAp
DQo+IFBBR0VTSVpFPTQwOTYNCj4gbWVtX3NlY3Rpb25fc2l6ZSA9IDE2Mzg0DQo+IE5SX1NFQ1RJ
T05fUk9PVFMgPSAyMDQ4DQo+IE5SX01FTV9TRUNUSU9OUyA9IDUyNDI4OA0KPiBTRUNUSU9OU19Q
RVJfUk9PVCA9IDI1Ng0KPiBTRUNUSU9OX1JPT1RfTUFTSyA9IDB4ZmYNCj4gUEFHRVNfUEVSX1NF
Q1RJT04gPSAzMjc2OA0KPiA8cmVhZG1lbTogZmZmZmZmZmZhNDkyNmRiMCwgS1ZBRERSLCAibWVt
X3NlY3Rpb24iLCA4LCAoRk9FKSwNCj4gN2ZmZDFiNmJiMDAwPg0KPiA8cmVhZF9kaXNrZHVtcDog
YWRkcjogZmZmZmZmZmZhNDkyNmRiMCBwYWRkcjogMTI5MjZkYjAgY250OiA4Pg0KPiByZWFkX2Rp
c2tkdW1wOiBwYWRkci9wZm46IDEyOTI2ZGIwLzEyOTI2IC0+IGNhY2hlIHBoeXNpY2FsIHBhZ2U6
IA0KPiAxMjkyNjAwMA0KPiA8cmVhZG1lbTogZmZmZjkwNGM3ZjdmYzAwMCwgS1ZBRERSLCAibWVt
b3J5IHNlY3Rpb24gcm9vdCB0YWJsZSIsIA0KPiAxNjM4NCwgKEZPRSksIDU2MDE3ZGEyNmZkMD4N
Cj4gPHJlYWRfZGlza2R1bXA6IGFkZHI6IGZmZmY5MDRjN2Y3ZmMwMDAgcGFkZHI6IDNmN2ZjMDAw
IGNudDogNDA5Nj4NCj4gcmVhZF9kaXNrZHVtcDogcGFkZHIvcGZuOiAzZjdmYzAwMC8zZjdmYyAt
PiBjYWNoZSBwaHlzaWNhbCBwYWdlOiANCj4gM2Y3ZmMwMDANCj4gY3Jhc2g6IFBBRzMgLSBlcnJu
bz0yIHI9MCBwZC5zaXplPTQ5DQo+IHJlYWRfZGlza2R1bXA6IFJFQURfRVJST1I6IGNhbm5vdCBj
YWNoZSBwYWdlOiAzZjdmYzAwMA0KPiBjcmFzaDogcmVhZCBlcnJvcjoga2VybmVsIHZpcnR1YWwg
YWRkcmVzczogZmZmZjkwNGM3ZjdmYzAwMCAgdHlwZTogIm1lbW9yeSBzZWN0aW9uIHJvb3QgdGFi
bGUiDQoNCmhtbSwgcj0wIG1lYW5zIGVuZCBvZiBmaWxlLCBjYW4geW91IGNoZWNrIGFnYWluIHdo
ZXRoZXIgcGQub2Zmc2V0IGV4Y2VlZHMgdGhlIGR1bXBmaWxlIHNpemU/ICBJZiBzbywgc29tZWhv
dyB0aGUgZHVtcGZpbGUgaXMgc2hvcnRlciB0aGFuIGV4cGVjdGVkLg0KDQpJbmRlZWQsIHRoZSBv
ZmZzZXQgcG9pbnRzIG91dHNpZGUgdGhlIGR1bXBmaWxlOg0KR2V0Og0KY3Jhc2g6IFBBRzMgLSBl
cnJubz0yIHI9MCBwZC5zaXplPTUyIHBkLm9mZnNldD0xNjg5NTY0ODUgd2l0aCBhIGR1bXBmaWxl
DQoxNjQ4MjAgLXJ3LXItLXItLS4gIDEgcm9vdCByb290ICAxNjg3NzU2ODAgIDYgYXZyaWwgMTc6
MjMgY3Jhc2hkdW1wLS0yMDIyMDQwNi0xNzEzDQoNCkFuZCBhbm90aGVyIG9uZToNCkdldDoNCmNy
YXNoOiBQQUczIC0gZXJybm89MiByPTAgcGQuc2l6ZT00OSBwZC5vZmZzZXQ9MjE1NjQwNjQ5IHdp
dGggYSBkdW1wZmlsZQ0KMjA5OTg0IC1ydy1yLS1yLS0uICAxIHJvb3Qgcm9vdCAgMjE1MDIzNjE2
ICAxIGF2cmlsIDEwOjU4IGNyYXNoZHVtcC01ODUuMDAwLTIwMjIwNDAxLTEwNTQNCg0KSSB0aGlu
ayBhIFJIRUwtYmFzZWQga2V4ZWMtdG9vbHMgZG9lcyAic3luYyIgYWZ0ZXIgbWFrZWR1bXBmaWxl
LCBidXQgY2FuIHlvdSBjaGVjaz8NCg0KQWN0dWFsbHksIHdlIGFyZSBleGVjdXRpbmcgdGhlIG1h
a2VkdW1wZmlsZSBpbiBhIHNjcmlwdCBkZXNpZ25hdGVkIGFzIGluaXQgZmlsZSBmb3IgdGhlIHNl
Y29uZCBrZXJuZWwuIFRoZXJlZm9yZSwgd2UgZG8gbm90IHBlcmZvcm0gdGhlIHN5bmMgYXMgcGVy
IGNvcmVfY29sbGVjdG9yLg0KDQpUaGFua3MsDQpLYXp1DQoNCkJlc3QgcmVnYXJkcywNClBhdHJp
Y2sNCg0KLS0NCkNyYXNoLXV0aWxpdHkgbWFpbGluZyBsaXN0DQpDcmFzaC11dGlsaXR5QHJlZGhh
dC5jb20NCmh0dHBzOi8vbGlzdG1hbi5yZWRoYXQuY29tL21haWxtYW4vbGlzdGluZm8vY3Jhc2gt
dXRpbGl0eQ0KQ29udHJpYnV0aW9uIEd1aWRlbGluZXM6IGh0dHBzOi8vZ2l0aHViLmNvbS9jcmFz
aC11dGlsaXR5L2NyYXNoL3dpa2kNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK

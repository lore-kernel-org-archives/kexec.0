Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFD5CF6491
	for <kexec@archiver.kernel.org>; Mon, 30 Sep 2024 08:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=16DMrilY/pyPwSnuF/FF5p6zhqrjE0wLN4qYwGCvi40=; b=fa4YYAc5z+h1gc
	Z+cincw+Bzn+ZYUIdhERmjIl8d88tt4ynJ+4yWhjonpg9T7lGW7LHEC7iUPNhR41y0TaewII/bpod
	RL43od96ohIobDQsaCcuyO2sf4V4Wpx/n/AsGTh1YUDU9chTqdFdhK3uCIUKgO8ygMMZHcJ9WEOpC
	pqdAm2bmyoF3OP8C2lSp8zlDTjstDbc6UY2/14N3cUmEs8LiGxb8BfIqdBi3+nCXTRk2qIYyGj4SF
	2rsxbQGaN7Y+b3MFPobcDL8vt3H7TO0t3+zHnQCWLkhSfz07olKg0zaC3g1NR/a4/s6/u0nFNdFXL
	6UYmeg/S5azRjcy4obiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1svBcr-0000000GIdh-157k;
	Mon, 30 Sep 2024 08:19:25 +0000
Received: from mail-japanwestazlp170110001.outbound.protection.outlook.com ([2a01:111:f403:c407::1] helo=OS0P286CU010.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1svBbr-0000000GIW1-3tth
	for kexec@lists.infradead.org;
	Mon, 30 Sep 2024 08:18:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbGNCdzmO2rRzLE/DRLYY549Cw8k8dnd4r4OFMgBlrxXLh5A91e89BWsbxtQUk2jzfHM2g+w5u2vV2zq/FJ9ZGRLc8fv2CT8LFNBXBuf3hzHCMMcwBij75DcdjDzlW/L97ALOXlj+o08hmN1t9c8QumttskuEUh7lq4jLgxGAZta6VVKUEdpbzcK6uDJTpZl5vGkvTDVvM5OoIjEHpdewDVWigPgWpxnmOreyLrWOi7k9YTzX/ALnunS+oa+/0SzK80zEDYIFSEC/eqnK502a8V5RgUGuxU++VDZ2G/F1tnvHVxWabak4E6tSVTuNJThsudcQoClUPZBqfLC6+/2Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4kSrl0NJ8uD605+kC0+SCMJ5nPldsqXX1I8xtamAwI=;
 b=SDGGL+/3NXWvsLovpP62IVQpzWOZ5pHTZaa6YAW3tG8JZ0uPscoxkSJoxyFkzhtW7PgoXFsrkOxKQj8YHV5FsXw7376DTEBJ2D5MEal5VQ9dc5sS3QG72/hj/3s0szV16e29U3CJNNPYQgMNSmsSA4Zp3Jv68nlCYG2NE+xGWYLc4ZwdfkPLWvcgP0fkyCdq2rew86jjxyva8NyXnA/N7xHGgemOb3IwDJjr/vhsHflZUCGLc9EkLXrNf9o7YaMwhFbR8y1ner8ZaDiz7VN9LxawGxlHUL9OhaST89Uob7xMs2y59jKYEUFT4H/VY+DIhvH1QWZt9gfPwulCFj+kwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4kSrl0NJ8uD605+kC0+SCMJ5nPldsqXX1I8xtamAwI=;
 b=SOAAE45Jc8tFQIBH2f5L685LWw21SgIoieamDXqCr4QLZPBxGJRUiauXG35Rlpc1W0ICWhxqVJzFvgMELNUErg8UsTrIX7XK0vGkzMPslCwPWgaZXdCrVOXcrqX4BWp5SO3TgvCpuPCsRt7OQLX1TJZqdoQxFnDNhDokS+uGW+M2O8rV3D+B242jnEmViNOCD2brt1w/83SpmHm0vbplTPvhApsWhXFYEKsZKjHxWp9Xgfgvp+6luSW0pXacC0Gj1s1+p2KJ/pFbcKEzjRjopkwJHKpFR3BZR3SfwNUJJvJMr/9vi+2r/OsEAnv8RfqDTkvDab7IVVBXwjxjtjKSwA==
Received: from TY3PR01MB9997.jpnprd01.prod.outlook.com (2603:1096:400:1de::7)
 by TYRPR01MB13374.jpnprd01.prod.outlook.com (2603:1096:405:1c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 08:18:02 +0000
Received: from TY3PR01MB9997.jpnprd01.prod.outlook.com
 ([fe80::f4a0:426:4a25:6122]) by TY3PR01MB9997.jpnprd01.prod.outlook.com
 ([fe80::f4a0:426:4a25:6122%7]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 08:18:01 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Ming Wang <wangming01@loongson.cn>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
CC: "lixuefeng@loongson.cn" <lixuefeng@loongson.cn>, "gaojuxin@loongson.cn"
	<gaojuxin@loongson.cn>,
	=?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>
Subject: Re: [PATCH makedumpfile] Fix incorrect PFN exclusion when LOAD
 segments overlap
Thread-Topic: [PATCH makedumpfile] Fix incorrect PFN exclusion when LOAD
 segments overlap
Thread-Index: AQHa7fPA1qiABnWZWUyrxFZpVkHEorJwRmwA
Date: Mon, 30 Sep 2024 08:18:01 +0000
Message-ID: <80b58b89-d08e-45f2-af28-b285b9b17b69@nec.com>
References: <20240814024315.3166766-1-wangming01@loongson.cn>
In-Reply-To: <20240814024315.3166766-1-wangming01@loongson.cn>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB9997:EE_|TYRPR01MB13374:EE_
x-ms-office365-filtering-correlation-id: 279557ef-da1a-4faa-0b10-08dce12866ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YWtybWc3amdhRnhMOTVtL1RSVjRtcTg0Vnh3cEhwQmx4RURQalV4eHNpNTV4?=
 =?utf-8?B?ZWZHRzRCRmN3S1QwWFN1VFBndWp2RGlwSElOa1RqT0c5SzZzaS9ub2c4eGN1?=
 =?utf-8?B?Wk9IQkVnd0loNzhVOGlBT1ErenNsVS8vNm9qa0p4am5URHFtRlk1TUw5UXZ6?=
 =?utf-8?B?UXBTTlN4S2srOTEzZ29XbHMrbFQzenc5ZU1odHdHTWp6Z29veGF4djdSUDg0?=
 =?utf-8?B?cFpkVFYwR2lCVUh5S3loTFY0ZFo2cFFlZ29HRXUvbERPTS84dUtGNFV4dExs?=
 =?utf-8?B?S2NPR0tkZnZCamdaeXdXYnBOcnorTGlQZTN0SWRvMnZWS05rZVo3WkYwRXVW?=
 =?utf-8?B?WjJwSGdoZmdXVmVQVVAvN0VhNXVoZTlUaXY5VEpDNXVvWjFvMCtGOW9HbHdm?=
 =?utf-8?B?K0d3MWw1NlF5SERHc2RGbUdNbEVNbTVzZU5nU1duSVNhU1NJSStjRHdXbmhZ?=
 =?utf-8?B?OUphMitqNE91UUs0QmZxN2lER1hjZ2ExZC9QVkpBNmFNU01jemFjNDhHQU54?=
 =?utf-8?B?L3J3NGFKVVdiQmFYMDk2VGZKVUNQdTJzeGc0QXpZN3BKcVpFRysyR2M2dnNp?=
 =?utf-8?B?SlBOQmxzemdka2JGbEgyV3JRNFBOZndIQnRYQVdoNzMrTEMwVkl1S2wvSjZX?=
 =?utf-8?B?bDZFU1VpanFKLzlCQmpPNFBCcUpCTVBKRGkxRVNQOEJIQlRmdzdpaXVaMGVT?=
 =?utf-8?B?dFF3Wk9laHdxL000VzBwVjI5SjFXcmVDUHpkMjZjdFJqZ3kyWmFwcVZ0eFdM?=
 =?utf-8?B?cDJmZVR2Y3labkRlUnp2L1pobFFZU0x0Ly9KMzN3S0Y0RnpiS2dsVWM4dzVk?=
 =?utf-8?B?NXphNVVNT1dGZ1JRYWZ3akpua2tGQnF5VjF3aHM2d3JRdm9HM2g5bEVMUVp3?=
 =?utf-8?B?M2NaWmtTeHZjS25MZXZiZzdXVzNOTGVSRVUwWjlpSlo5d1RXemtzVUNkOU9V?=
 =?utf-8?B?b0ZSeG1CV0IvaXVZSUtDMTNIMVk4U0gvY0RmOFFVQ0NPOWlBMDBIVVpRQVhu?=
 =?utf-8?B?emVsVW0vSUxSU0Z6QktiM1dwM29reEovKzBGRFM1ZWNOZGp2TVZHL1FNTUY5?=
 =?utf-8?B?R084bDJZVUxVNlRjYWVJcmFXcnBjSTlwbHd4RWt4ZnFXQlFHcGptWUZWRVJ0?=
 =?utf-8?B?TG5SYUx6TjFsVnh3bkFnOTIwUXU3QkVZN3JtbWY1enZ6bGpsRFpBUVZJT0xD?=
 =?utf-8?B?a09vdGVsdzdEQmFUOTlYK1dLUHkyNW8vU3FZbXJMRnY4K0F2aHFVZCtjWjdF?=
 =?utf-8?B?UXRMN1d3bmFxaXEyYzBQQWo1NngyM2NJU3V6M1JJQmJXMXp0SmJyazdNSDN3?=
 =?utf-8?B?WnFUdFBRdDB4M3JjTTlJTUJYOVUrOVBUN1VoUGk2a1NHOHFJVjg4ckdDWkJC?=
 =?utf-8?B?Y0xMOWwyNWpwRHNDVnppbmcxb0tvNHg1YmFrc084ODZOd3hOZExsRk91SjBz?=
 =?utf-8?B?NmRWR3g5SWQ2MmNPRmRNanltU2l1NXNjaHVXUDdVLzYzYUlEdCtLczRPVS9a?=
 =?utf-8?B?eXcweHUzNUN2ZUcrRVB4dklZck1GeDd5b0xxUGszZ2s5SDljSklZVERkbVR1?=
 =?utf-8?B?Tkh3UUlFa2U0NEtJS2dTOXN2eHZQODBGUmRZeDNtQW1RaVNEbkRXcm1rUnlT?=
 =?utf-8?B?Z016OWpOeGtwT2VrS2xMdzRIelltQmJlUi9PRWpDVWRsK0RvTktESTgxam5m?=
 =?utf-8?B?RERyU0lKajRTZWVINCtieWQ0QTc0dk0rS2VyMUZGbTdBeEgxSFFKWXU5amNV?=
 =?utf-8?B?cGFmdWVuZDVVd21SOENIWTAxL294a1JoKzRPSDd3eDVoellhWXh0QTBNdjJO?=
 =?utf-8?B?RWVHWlVSd3dxQklLWHZTQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB9997.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0NGQmtjQmhvTjdJalIxTHNmMHRPc09udC81Z0hhejR2eWJKdzBOYnNXMUJ3?=
 =?utf-8?B?amI3QytiV1pKNmlvSDVEQWd6M0dhZXFEVkhNckRxQ05HTTJPMTlUblM1U0Fj?=
 =?utf-8?B?Sy9wK1U5TU15QnFLME9ra1RKNm9hcC9GdjZUMDVDMXBWRlBnQnF5Y3lTY3JH?=
 =?utf-8?B?Sk95ODBlakgvMStYUlVyWitjYkszcHhveVkyZnE5UXlZenRWcXR5UCtzSDBz?=
 =?utf-8?B?bnFTWjlGVUcxV2Mxcjl3M2V6b3dIZUZFbjNqMTU4MTVrNldRbFVMZ3c5ZFM3?=
 =?utf-8?B?MTVXWnU5T3A2WmFxN0MzZ3o0bDgwdmhKMm1pcytFMjdLTi84ZnVxRUNhcCtU?=
 =?utf-8?B?ZmJZSGJnbWYrbWtGTllhT1ZuYUtwWnhab0lPK2NHSDZUai9mR3U1RXhzMTM4?=
 =?utf-8?B?NUZDYm5pSkNKc3Iwbk1KQVoxamRObXFqYTRJekthOXRUdkZxVFlna2JSSElw?=
 =?utf-8?B?WGcvWG1aNWNaM0FKbmdIbEk3THJEcWxsTjVHNnBrVDFBYlRxckpqay8rbW1p?=
 =?utf-8?B?RGtHTmpXUWg3RXNzQlRZdk5KcFo2dzh3S0NCRnZIa1dmenpSQ1VDV2hHdzBI?=
 =?utf-8?B?VWtqNWFFM1JTMVhnQ29OeXpOSnZmS21pWWo4MSsybUN3R1huK3BCRkFIT2Vi?=
 =?utf-8?B?Ti8veE9hOXZwZ1pDNzByaENFL3BVWHZpL1dIM3E2NzFreTdWVWNTOURLbmgx?=
 =?utf-8?B?T0REaVJXT2dDeE05eDhyTFZuNVAzYkhNSlhjNk1uaWQ2YVMraS9qZWM5b0hB?=
 =?utf-8?B?MFZxZG5Kb0FEUW5mQzdzSUVSd3NqVE9CbjRwWXRQaUV1eWVpYmR5NG1McWN0?=
 =?utf-8?B?SmFVWjJvK1FvUHpkMUhlaWVtcGZ3M1RqYzBZRVJMZ01YTHBmdXBrc3Q5dk9C?=
 =?utf-8?B?bS84SWpaVEhrdUxQViswM3BqOFdwdHZMSGN2TndUeFpPRW5CdWMyUDU0dCsz?=
 =?utf-8?B?ckNYckNoOHFIT1JWUmNyUVprVEx4cTJkUHJJTGhaWlZPeGdZQmJWVE9MOHB1?=
 =?utf-8?B?QnhnYmYvaGRWQlIvbFVLQ3RCOW1yMTVZaW1CTXFZTG1kZVc4Y1dMbG5sT2dU?=
 =?utf-8?B?QTdMaUI5SEN3b3JoRlR0dCtEcHdiV1MrZW9sb3VyMXZKOUFJc2RxR05pTWJV?=
 =?utf-8?B?RktIS1lhTGJTU0ZDNDZWOHNMU1BMcDhQV2d1aVNmc05BTHJCVDZPM1FsdENj?=
 =?utf-8?B?NWtOaFZWNnNydlhYMllBK2s0UkRvRXpZaGRRRFNqRzVobGcrczIvLzIraE9q?=
 =?utf-8?B?MzNWNGg4a25EOTZNVG81NmxTODNwQzliSlNxMHJkb0xWa0NheDZqWjJCeGNM?=
 =?utf-8?B?UEVRZ1JLeEdrV203ck05cWQ0M0w0ZGUrbmRvbytCYlNqNmJ3R2VWOVA5cytm?=
 =?utf-8?B?YzJORFQvaEdjdUNMeHBZWTVhUTdnVVIwODVFa0Jzam9uOWFTUXh0ZFJCcHdQ?=
 =?utf-8?B?cWdqZHJXYWc4bFJSaStTdVpaQWxkRUFWRit3N0kyNHhsckhXYXQ5MUY3TGtQ?=
 =?utf-8?B?eVhJZVhsc2o3alZuQW5DTXhOYlNFUWFKaC9oNFo5U0dSWGh2czVrdW9tdnJF?=
 =?utf-8?B?SHRTT0J1TGRjV3pmdzNraFpnZGdqNWxibEd2UFFZQXFIZWgweWwzNE9LUDFO?=
 =?utf-8?B?WStWaXc0UTBpR0d2QmFaMHlSaVRmajhvRGhuL1d5SXd4VVVBckRlNE9ScDhx?=
 =?utf-8?B?SWk1M1Jsa05nbmVHdVFPMHJWUlZGeFc4MzRUdVRWRUhrWExucElqeTJNWFRt?=
 =?utf-8?B?dW9OOFlBUWhZTXB3bjhXZlJSMGVkR1pGajF3OCsvZzRFMUdkWXJtdHA5aG9x?=
 =?utf-8?B?RmZVenliRFAzNENRZklrRENkTFhMdEpvM2dUdk8wZHdZdy84SGFIeDZQNWRY?=
 =?utf-8?B?WW1USkFpd1RJY1RuKzVTRzZWMFFMOGt1Ukk3U0RlcVJxT0RraElqaVhvR3JU?=
 =?utf-8?B?SVZhME9SZSttRUdROTVqalRUWnFKWCtEd2F3R0JacFpmNkpleTQ3TmZMZlZj?=
 =?utf-8?B?eUVzL2ZML0hwRFowVHR5Z1ozNDl1bnhhK2NoVnBpdWd6UDJIdC9wREJYdDh0?=
 =?utf-8?B?TlpnWGc5S2crTGlXN1hLTCtHRFNYQUpWcW5rYmFlQTJsVktINDdCRjlYcGdT?=
 =?utf-8?Q?c7EyOFMIfuDPhNl0Ijah2sr2U?=
Content-ID: <26383E017FBA1D4EB520F8F41420DA04@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB9997.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 279557ef-da1a-4faa-0b10-08dce12866ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 08:18:01.8955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z2+MROiBgmF0Clqc1cWF+YZwIGrrchFXs4Uj7AvpvllNqfKla+NUPzX30gr5DseUNfDySy1Ld31d8o5ISR/qdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13374
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240930_011824_469549_9053CFB9 
X-CRM114-Status: GOOD (  26.53  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Ming,

sorry for the late response to this patch.

On 2024/08/14 11:43, Ming Wang wrote:
> When iterating through LOAD segments to exclude pages in
> `exclude_nodata_pages`, simply using `phys_end` to track allocated
> PFNs can lead to the erroneous exclusion of valid pages from a
> subsequent LOAD segment if its `phys_start` overlaps with the
> previous segment's address range.
> 
> This patch addresses the issue by checking for such overlaps with the
> next LOAD segment's physical address range. If an overlap is
> detected, we continue including PFNs from the current segment until
> reaching the end of the overlapping region.
> 
> This fix ensures that all valid pages within overlapping LOAD segments
> are correctly included during PFN exclusion.

I have a few questions:

- I heard from Masa that the overlap is caused by a bug, isn't it fixed 
on the kernel side?  or it will be fixed but is this patch for existing 
kernels that have the bug?

- exclude_nodata_pages() is for dumpfiles created by "makedumpfile -E", 
which uses p_filesz in program headers to record existing pages after 
exclusion.  The function excludes pages only between 
phys_start+file_size and phys_end, so if p_filesz == p_memsz, it will 
not exclude any pages.
I would like to check how they are on your machine, so could I have a 
"readelf -l /proc/vmcore" output?

- Do you mean that the bug always puts the two LOAD segments that have 
the same phys_start in a row?

Thanks,
Kazu

> 
> Signed-off-by: Ming Wang <wangming01@loongson.cn>
> ---
>   makedumpfile.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index ce0d40e..f07f831 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -5207,7 +5207,7 @@ static void
>   exclude_nodata_pages(struct cycle *cycle)
>   {
>   	int i;
> -	unsigned long long phys_start, phys_end;
> +	unsigned long long phys_start, phys_end, next_phys_start, next_phys_end, overlap;
>   	off_t file_size;
>   
>   	i = 0;
> @@ -5222,7 +5222,25 @@ exclude_nodata_pages(struct cycle *cycle)
>   			pfn = cycle->start_pfn;
>   		if (pfn_end >= cycle->end_pfn)
>   			pfn_end = cycle->end_pfn;
> -		while (pfn < pfn_end) {
> +
> +		/**
> +		 * phys_start                        phys_end
> +		 * LOAD[ 0]           200000          2186200
> +		 * LOAD[ 1]           200000          ee00000
> +		 * LOAD[ 2]         90400000         b8a00000
> +		 *
> +		 * In the above example, When iterating through LOAD segments, simply excluding
> +		 * already allocated Physical Frames (PFNs) based on 'phys_end' can lead to an
> +		 * incorrect exclusion of valid pages within load[1], particularly in overlapping
> +		 * regions between load[0] and load[1].
> +		 */
> +		get_pt_load_extents(i + 1, &next_phys_start, &next_phys_end, NULL, &file_size);
> +		if (next_phys_start == phys_start && next_phys_end > phys_end)
> +			overlap = TRUE;
> +		else
> +			overlap = FALSE;
> +
> +		while (pfn < pfn_end && !overlap) {
>   			clear_bit_on_2nd_bitmap(pfn, cycle);
>   			++pfn;
>   		}
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

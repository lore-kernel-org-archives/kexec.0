Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8BCCAC5B0
	for <kexec@archiver.kernel.org>; Mon, 29 Sep 2025 06:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GIBEyA+BgTuYTVOSGoFs37itJgxGxGmOJ1qISJXuCRw=; b=k5CjSweHyqvixi4LfJzNWwgHpm
	NkB0qACP9DiDgBt1ZwSfSObTMV/n1pfCnnQO37SIJ5c/v2bkFnHNMVP49WYrNm3JmNNWiRmnCvTZj
	FhYT2a2s36skH9YF3Kx7YTMIi3p9MX7yjfZULSPlRAHVoiS6aqsRnfOda1WCGBfjw5cpd8kvfPwdH
	OuEajAhN0uogHL1KT79iRivXYdtOW9auah5wtbjyF41SgRuBkjjk6ojEpriwU174kaZ+gWXh2Ftpj
	nWsrEAl4NPicmlfNlgOmgz8VorfjMsm7SW0i/XdHFhKQb/ySeILjjvUW50EB2yCF1R8h3P7rWpwWd
	9O0Mpeww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v37Pk-00000001UUO-40Av;
	Mon, 29 Sep 2025 06:31:12 +0000
Received: from mail-japaneastazlp170110002.outbound.protection.outlook.com ([2a01:111:f403:c405::2] helo=TYVP286CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v37PF-00000001UTm-1Es7
	for kexec@lists.infradead.org;
	Mon, 29 Sep 2025 06:30:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yikQLyIHn1KDYXL4dLqhTwUeGe0K+rFtSj+bmhDeiKIH9VfR8az/EzMqOqY8cGJdf9+kRetAiZdui7iSkNfdEtsxqIxTEBLabGp7orxr73ku6htGZ1XkoL7AWdTBvOtvBZbCiE1cNmgdcwoGvFStiolXKUGsV9MDTRj/dCJzldJ7l4NumexkVJJFUHMbDHi5UkzCBF1g1ASrfH4EztNuRsNv4l+qmx0iwth4osi2KlrYHar7n7H9DfKIbs+ObMATVVlxUbZpU+cCSEnNHtwd2vhEXUbP5vdYrhbRo/waoSmB42QDs4CRY0udwR458fyvSIC/Kf+Prd1MnGTE5G9xRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIBEyA+BgTuYTVOSGoFs37itJgxGxGmOJ1qISJXuCRw=;
 b=xxQtk2Ffbr1ErloYTalniyBI4Y6/eU3OwtUV9gVOIxzPWMr7Dv06To61UdNKt8pqtngqqeRBUxN47Q2o23LTtcQG446u95O4ew/T+5I0ng4PVZMqD3UCq8SKVyI0S5kqPSdlNUg1yqLfhktf6K+qR5dl8k2VI8AvTETzjoo8fbWCoJ0C8kLWBguK9qWdnKjCuhcTK4SEbItTWzg+/eZ+s3+N4aHmiB4uZuG4zHlJFjtk7nVIxMDAPJtAOCb+o8C+kn7svzCml6sOaxN2SYHczxHuwRCi2/wtrhTVr2jElGSy6VlC32JrieSAVA0hcAPrH4MVN5Rl7v7jdzoNYZyg5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIBEyA+BgTuYTVOSGoFs37itJgxGxGmOJ1qISJXuCRw=;
 b=aiaO4PhppkCcPoDbcCwIPsIW7aV9RMwfl+giBho5pf4vrFaQ70OsVYhRHoCmNBMWmi68VEI278vAgMGkr//yRcGTIHhNwRnjOTnhZXD5Q2ST2WH75Fc1OzDGEex+t/7fK0Xt3z5OTIfRugmWA12vOkY75HMtujNhnGbq8JMzq+QOJ0GlslLjNs8BRAgPgo3KSRng6AbIMNlPrReMTdwqNbhu+t2NQwkDq625H9T97JNAxmhKMlIDZlrLUvPcg2b5fO0L61jhuqIIqwUUb7fN3+IY/4NQgwEQjQGrXIptx/FiyTlquaZiCbf67vcWI5PDDAtTa6mHrEnd5tjaYWPowA==
Received: from TYWPR01MB7680.jpnprd01.prod.outlook.com (2603:1096:400:ec::7)
 by TY3PR01MB10173.jpnprd01.prod.outlook.com (2603:1096:400:1da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Mon, 29 Sep
 2025 06:30:21 +0000
Received: from TYWPR01MB7680.jpnprd01.prod.outlook.com
 ([fe80::a702:7478:5c45:6469]) by TYWPR01MB7680.jpnprd01.prod.outlook.com
 ([fe80::a702:7478:5c45:6469%5]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 06:30:21 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Tao Liu <ltao@redhat.com>,
	=?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
CC: "aravinda@linux.vnet.ibm.com" <aravinda@linux.vnet.ibm.com>,
	"devel@lists.crash-utility.osci.io" <devel@lists.crash-utility.osci.io>
Subject: Re: [PATCH RFC][makedumpfile 01/10] dwarf_info: Support kernel
 address randomization
Thread-Topic: [PATCH RFC][makedumpfile 01/10] dwarf_info: Support kernel
 address randomization
Thread-Index: AQHb2e42Q6Tev68+kkG1Zwv3jRIz2bSqYQYA
Date: Mon, 29 Sep 2025 06:30:20 +0000
Message-ID: <c1b21df8-580a-4119-8c61-fce52fa0e8e1@nec.com>
References: <20250610095743.18073-1-ltao@redhat.com>
 <20250610095743.18073-2-ltao@redhat.com>
In-Reply-To: <20250610095743.18073-2-ltao@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB7680:EE_|TY3PR01MB10173:EE_
x-ms-office365-filtering-correlation-id: 9785a87f-9094-4ff0-d0bd-08ddff21aa21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TTlKdjBHN0xRWUFXN3B2ZW9pQ05hcGNhWHdrTzRwYXE5Y2V1cjNFOWZwbnln?=
 =?utf-8?B?RXlNL1pWaWpvUUZ3SWNaK1I3bFRqUHlCTUNkKzBuMUk0OHpSVzQ0Rnc1c3hh?=
 =?utf-8?B?MUdDVTJjUU93VjU2cWpVWU5sVW9BQXgrVTBuWFZMTyt6MW5TZkI1MjN0UHpj?=
 =?utf-8?B?ZTRlWGFna3ZLdjdseWFqR08wNjJ1Tm9xcE5zbUM3b3BlcXp1WXZ0ZnZpN3dr?=
 =?utf-8?B?SXdGdjEzcmV3eW8wd3RqNmhKWGdTOHFWOWNOaUlZNm9QWWJ2b2FhL1lqOUN3?=
 =?utf-8?B?UXF2dkhKR0FtSXNhYUNPbkc0aU55Mi80WHdEWkxIa2Nkb0pSUHE4dVZlNkcv?=
 =?utf-8?B?SThuNWhpMW5TK1RYNTR5TVA1c0J0dy9vTVE1U2NkbXE4dkkxbFlld0F2K2pn?=
 =?utf-8?B?d3hFUWFLcXB3REx1bWdpWTRZWjdUM2FETVM4L0k1NjZjSGlWZ1J1TGRidlRS?=
 =?utf-8?B?QkxLMU44aVdzSi9nclc5NnREdURxOElDTmk4bnBBQzEzb2hBQ21Hdk9YN0NB?=
 =?utf-8?B?eUo2R2ZMa00rTGY5U3l2dVNGYUFOSSsvOGI3RHRQZnBZOXl1QzRnT1UyN3BZ?=
 =?utf-8?B?SzhxRFNNQVB4T3dvYi9VZVlJS2xyVFhtUUJnLzVzRmMzVUhsQ3NhMGVFOGk0?=
 =?utf-8?B?YkxkdzBIUjV0MjVVaW1BTEg1Y0daVHV0UDI5V1VQWlhiMlVBVkFvWTNGMCt2?=
 =?utf-8?B?QUJaZmlnUmlMcjdSSVhpc2ZYNEJVTHBnNWRGN25DK25LdUlZSmtlN1pQOERz?=
 =?utf-8?B?WlhNbDJjbEpGTjRyQXJaWWpVK3NTQXBBU0pVR2l3VXQwVnlmdkFjVzZmVmlS?=
 =?utf-8?B?QzB3THlwdGNhNVBvRXFUcmR1UDNKc0VtQmtCQXRteGFDNU11Y0ErcVZ0Ynhr?=
 =?utf-8?B?U0laVE9yWHRpdmxSa21nR1RDQjVlVTlkRURIZkhYYmZLd1h1djhFYk5oS0V5?=
 =?utf-8?B?dGl4MVdzSXFTcVlDMGxRVjFTU2txRUhhdGZZUVdNYUVVWk1lenN2ODQ2Z0Ro?=
 =?utf-8?B?OStZWmh3LzZQSmtFSDlIb3dZcEtaZG1JUmhHSVduQ2VUeDlTTytXS29JVVZs?=
 =?utf-8?B?SGhya2dDVWZVTEpUWnpUVG5YUUNyclcrQ014THlGM2RqcE1pay8zVy8xRExx?=
 =?utf-8?B?d3Yyd2xDOUxMT2Jtdk9zNGFrWk9abm9MQTQ3eHRXa254VjR4dHdyS2F3dy9u?=
 =?utf-8?B?dDJsaDdvOHJacUJpQTI1K2o5bEdPZ1NTaEo5dDc3cTlsNXUzTmRwbEtxK2hS?=
 =?utf-8?B?YldsQ1kyU01YRm0zWFlHVERwK2d1cURUdFBMUktzeDFObjZUWCtvdDZnd1Qx?=
 =?utf-8?B?OXBSbi9LOFpYQTdKaldWd2tWM2ZsVTIvNWswV2pHL01UZ2szNTFWcXVmSEVR?=
 =?utf-8?B?QnQvNGFlWEJrT2lEaXRTV1prNG8wVUtrYmFHbFpFZU9wMW1GNGRBeG5WaVov?=
 =?utf-8?B?QXVIeHhkZVRJU0NLcVJCUzEyWi82bDMvNjE0VVFVV0x4cFA5QktZem5qRVB1?=
 =?utf-8?B?ZjZ6US9kck5zckNrMWdiVWFCNm9VWUYzaFl4MlJOemVGSzNlQnZVS0lTVW9B?=
 =?utf-8?B?bEZ2RFp3UVo5R2Nza2xIV2pPT2JMcS85VWp0RkJMQTVESlE4WFUvSnB5bmRX?=
 =?utf-8?B?eGJKMlZKQW0xdjJxSEtudUxkQXlaNEN4dStsU3o1ZGM1MTlXQjlna1pQQmhC?=
 =?utf-8?B?cW1ha0I1ajN4UWp0Z29MVWYwQlVGSzhtdC9TNitrd25tcVlST3ltcDVpRyty?=
 =?utf-8?B?L09CT3dlNmZaWmtpeVpSaVFoQ1J0S0VqNlZ5VEo0WFlCblpTTkExdkl2REdw?=
 =?utf-8?B?VnUzT0FhUTF5U3Y1clRDS2Q1eldYY0xOa1lESkg1K0VRVGhGT1RHbzg0UUlK?=
 =?utf-8?B?amgxMHB1R2xMTGw2RXhiMnZFOTk0YS9ISDd1WFJuNW9vZk0zb2lsVm1PZmNP?=
 =?utf-8?B?TUpGTGlQWFJlLzN0K1VOOWtQKzdIVUdUSU9yMjRRN0JtZ3AwaTNQRWxlZ2tQ?=
 =?utf-8?B?dVFFUXJ3V0ZoZGx5WWh4ZkdONHlYSENJVGRwS1UzYkVTSmFiYnNYMU1Ta2pF?=
 =?utf-8?Q?hoVU9l?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB7680.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFNsVUtEZjh6R0l2b2xjQWFvM05XdVgvQ0d4MXFDbUVkTkgyZ0tvbkxLYnA5?=
 =?utf-8?B?eG5vS1o3TW9HMzBMZHZWanBxcDMzb1VlemlzYmVHNzlYYjJkKzZDTzNOWEpn?=
 =?utf-8?B?OHYzejIzR1hjNDhPdzFRMDZDaW93TzZUYkpzaDIxa1ljanp1b0pHcnlJK0FX?=
 =?utf-8?B?TWQzMkxCUkF2QmpGdURYb2NZRGttdE5PS0hrQ2JKcmFtcVVTWituOFNqZ3k3?=
 =?utf-8?B?TFFuNERBRFpSRk1xcmdoODdDKys4WlhaVUhvTmZMTkFtT3ZjZ1REMFZ3Sm13?=
 =?utf-8?B?SlBpaEpodEhZR3RLM0s5RW1LVm5lakswd2dqdGZsTXVCQWxLWSttVE1ibFdB?=
 =?utf-8?B?Y0VCZHI2MmRKTDY4QVovY1NlUHpGSE1sL2ZqRWxONlV1NkZDMVFRS01odzVB?=
 =?utf-8?B?T0lCNm1DTUZCekJ4V1p5MDVYUVdxc0JTUVVDN1p5d3BZOVBwWnhBK3FTdnBn?=
 =?utf-8?B?N2VRZTRRRmJ6MzhoMzFXWTBJVFdyZ05yK2xtS3BDc3hCbmZleDNEMWlyTmE3?=
 =?utf-8?B?WW9tWWJRbUlIS244YlplN2dIczJLOVo0YzU1RGttQjVIY3VpVzhhRzNCd0hC?=
 =?utf-8?B?cTlidDNKdG9teHJRV3YzSnpuWXNGaU1rTkpMU2F4czF1U29tZVFzK3VtMUk3?=
 =?utf-8?B?UDFxNDYzaGJsOE1XUWxWWTFGclVHcDduczg1ZTZUTnNZSjFIZEpnbTJlaTBN?=
 =?utf-8?B?aCtKeGppV2ptWFVtblgvTFdSQ20vMXUvTk12SlNMbGx5b2pwb1NSbHFHeW5i?=
 =?utf-8?B?eVRCM0ZiM2YwckR6SjFBME1ERW5HWEYrcjR2ZlVmWmcvcWNnblZYbWttdkUz?=
 =?utf-8?B?clZrRFcxMGVHNDgrSXVTbS9JaHVFTWI3azJEWEMwaG5VTnN2Qi81QWo0QXgr?=
 =?utf-8?B?b0lCZXlJTUgyT1l3OC9pcTBpMGhlVkNCNGw5Mjh2TXRpTk5hV21RaCtYNTlQ?=
 =?utf-8?B?RDNQR1U5Z3dPMFVqcExZMzVta2hHL2tUdWJLQUJ6S0RjbENUT29NOUV2R3ZS?=
 =?utf-8?B?aHBTSm8zb2FudVExYkRHTER2R3pHd2hocm1oOFphUnJKL2l2ekp0OXJmaVZ3?=
 =?utf-8?B?Wm5WcGxwYTNPU2FsR1puaGdaWGNZaVhndWlmcWtrU0FOTERiVHRGZEZIdTBh?=
 =?utf-8?B?cFNqbjhMZUl6TU85QnRxeDJRNXZkUnBQdGUrSU56TlYrN3Rrb1BVV2FzK1h0?=
 =?utf-8?B?T2VveFAwbDFXTVN4Z3lEdDFYbEdMTFVUVlZkY1c3R2RaUmpoYytWMXhVUXBu?=
 =?utf-8?B?emw5cklzcExmK2tHbUJMYWNHS3NSN2tUb1dFQjU2clg2bU5QdWw5ZEJBVDN3?=
 =?utf-8?B?aEJhZlNNN1ltQjBoMFJDcUZCNm4zbDJjQkZ2RzZCMHJ0WDFvTWVJYzl3Wld6?=
 =?utf-8?B?bUtuT1F6MVVzYmhtV09mQWUyUFNZbkduS2VFcHdVWjBFYTBaQklabjBRNTFh?=
 =?utf-8?B?aEFwQm5yVTFnbjQxKytCRlBCQzlUNmp5SGJvaWlGS2VySmdxejhJVytoU0Iw?=
 =?utf-8?B?NVppbUNncEFIb2EwM0thdnR4d25rNDNSZ0F1Tkdmcm9rR3EyQ0dWOHlvbVg2?=
 =?utf-8?B?TGowMG1sTHZSaDBZMUFTcXo4VUlYMnZPUTZSZUhlTG1GcjFyWHNHSHZwb0d1?=
 =?utf-8?B?Vks0UlJ2UGZ0c0FIZEgzT05uTXU3ZFdsb24rcHNqd1ljdjhoa3VWaWpqb29v?=
 =?utf-8?B?MkhrVUplSng0aS9SM2hYUmxSVkRUcC9PUkEvM1JxVDFweVZiQTgxNnpkd0tE?=
 =?utf-8?B?cDh6T3JSWjliK2RVWFdpdHRjek0zRDgxcXpzRUpibXE4MTdiZEg1SUp4bzZ3?=
 =?utf-8?B?MXVuMExPQUVzREEyZm5tSU9Jc2tXb3hoNHFrZlR5Z2hjM0c1RTdDaHcwZEw2?=
 =?utf-8?B?MFE5dGdiQi9TNStnL2Rpd0tjaitLVitmYmdRL3EwWnZpUi9mY1luWlBMKzFR?=
 =?utf-8?B?QlZDakJGL3RFMEt5M0xtbkhWRDZlZlZnYTBVd29IM0ZPUEJia3Urd3dBd01O?=
 =?utf-8?B?QVlsSmtlRVNGVDZ6U25LMDN1UDl0bmJuR0ROY0lIci9RMzBGekg5S0pydVhE?=
 =?utf-8?B?TFU4OW5BTUNMTE0xekVFQXBodGVaNnNWaTN4UHljU1lxVHNFU0syUmxhYy8y?=
 =?utf-8?Q?8kiFwFzLPqdipiVm9w2p54GWT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E3C0DF5647AF247B211BA1972ED5573@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB7680.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9785a87f-9094-4ff0-d0bd-08ddff21aa21
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 06:30:20.9631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mn/prGp79rAnJQZY9HdcsmE3P6jQNcP0gnYnX8QkGwdz7xJLfNWkjxKh3W7dyhf4gHqEGPmgnK70uuat710EaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10173
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250928_233041_700576_E2A57DB7 
X-CRM114-Status: GOOD (  18.99  )
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

SGkgVGFvLA0KDQpPbiAyMDI1LzA2LzEwIDE4OjU3LCBUYW8gTGl1IHdyb3RlOg0KPiBUaGVyZSBp
cyBhIGJ1ZyBvZiBub3Qgc3VwcG9ydGluZyByYW5kb21pemVkIGtlcm5lbCBhZGRyZXNzLCB0aGlz
IHBhdGNoIGZpeCBpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRhbyBMaXUgPGx0YW9AcmVkaGF0
LmNvbT4NCg0KYXBvbG9naWVzIGZvciBteSBsb25nIGRlbGF5IGFuZCB0aGFuayB5b3UgZm9yIHRo
ZSBwYXRjaC4NCg0KVGhpcyBwYXRjaCBsb29rcyBnb29kIHRvIG1lIGFuZCBJIHdvdWxkIGxpa2Ug
dG8gbWVyZ2UgdGhpcyBzZXBhcmF0ZWx5IA0KZnJvbSB0aGUgc2VyaWVzLCBzbw0KDQpBY2tlZC1i
eTogS2F6dWhpdG8gSGFnaW8gPGstaGFnaW8tYWJAbmVjLmNvbT4NCg0KVGhhbmtzLA0KS2F6dQ0K
DQo+IC0tLQ0KPiAgIGVyYXNlX2luZm8uYyB8IDggKysrKy0tLS0NCj4gICAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Vy
YXNlX2luZm8uYyBiL2VyYXNlX2luZm8uYw0KPiBpbmRleCBhZjZiZmFlLi5iNjdkMWQwIDEwMDY0
NA0KPiAtLS0gYS9lcmFzZV9pbmZvLmMNCj4gKysrIGIvZXJhc2VfaW5mby5jDQo+IEBAIC0xODgx
LDcgKzE4ODEsNyBAQCBnZXRfc3ltYm9sX2FkZHJfYWxsKGNoYXIgKm5hbWUpIHsNCj4gICAJaWYg
KCFzdHJjbXAoZ2V0X2R3YXJmX21vZHVsZV9uYW1lKCksICJ2bWxpbnV4IikpIHsNCj4gICAJCXN5
bWJvbF9hZGRyID0gZ2V0X3N5bWJvbF9hZGRyKG5hbWUpOw0KPiAgIAkJaWYgKHN5bWJvbF9hZGRy
KQ0KPiAtCQkJcmV0dXJuIHN5bWJvbF9hZGRyOw0KPiArCQkJcmV0dXJuIHN5bWJvbF9hZGRyICsg
aW5mby0+a2FzbHJfb2Zmc2V0Ow0KPiAgIA0KPiAgIAkJdm1saW51eF9zZWFyY2hlZCA9IDE7DQo+
ICAgCX0NCj4gQEAgLTE5NDIsOSArMTk0Miw5IEBAIGdldF9zeW1ib2xfYWRkcl9hbGwoY2hhciAq
bmFtZSkgew0KPiAgIAkgKiB0aGlzIGZ1bmN0aW9uIGlzIGNhbGxlZCB3aXRoIGRlYnVnaW5mbyBz
ZXQgdG8gYSBwYXJ0aWN1bGFyDQo+ICAgCSAqIGtlcm5lbCBtb2R1bGUgYW5kIHdlIGFyZSBsb29r
aW5nIGZvciBzeW1ib2wgaW4gdm1saW51eA0KPiAgIAkgKi8NCj4gLQlpZiAoIXZtbGludXhfc2Vh
cmNoZWQpDQo+IC0JCXJldHVybiBnZXRfc3ltYm9sX2FkZHIobmFtZSk7DQo+IC0JZWxzZQ0KPiAr
CWlmICghdm1saW51eF9zZWFyY2hlZCAmJiAhIShzeW1ib2xfYWRkciA9IGdldF9zeW1ib2xfYWRk
cihuYW1lKSkpIHsNCj4gKwkJcmV0dXJuIHN5bWJvbF9hZGRyICsgaW5mby0+a2FzbHJfb2Zmc2V0
Ow0KPiArCX0gZWxzZQ0KPiAgIAkJcmV0dXJuIE5PVF9GT1VORF9TWU1CT0w7DQo+ICAgfQ0KPiAg
IA==


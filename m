Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D6DFA373E
	for <kexec@archiver.kernel.org>; Thu, 27 Oct 2022 00:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kvIVtevBhwsT07D8FPz0ogwl1iO6WzlAp/rQE7ij0dU=; b=U0assKqpHRY05j
	as1mnAiXFRculibWrojQiPjLoQ21iyaCsBl85bW2x55jc2hR+OvRhlu/6aFpvvNPaTKNFVbiYMdkR
	pTFK0zTnffKHykTVha02mYH3RAjN5x0UsegT99XEO2qPRO4p2eFnRNF5YcA+i1gr4lVP8vOqUS0Re
	Yu6YR7u8x1E7x3hMYZXhNWZuZBwMpqItTyTvjGP5pmct0jcdWU3YvyeG2xpBbdJNMnH1LVHJmA3g1
	9LTsXVLABWfbyqUb/tpLA8Jbq7SvXsC79ogkKCIKdNKRPJ17mzt4p7GbvFGuEqz+ZXtChxeT3OE8Y
	xPN5hBAfmVaHKivIg9Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onqxM-00BNr7-GK; Thu, 27 Oct 2022 00:41:12 +0000
Received: from mail-tycjpn01on2057.outbound.protection.outlook.com ([40.107.114.57] helo=JPN01-TYC-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onqxE-00BNpe-Uh
	for kexec@lists.infradead.org; Thu, 27 Oct 2022 00:41:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4eLCYBjXiCD9wC9XUNvr7jqVIPuxpF1T/+mD1A+YoVfwONEDcN6Ue7VaRjMdi06lLbTg/dO2mr+SVT+zsYTnRpca8fOoBLCepf9n099vFrPh0q5NE8TAfxAu28fLt7qz6jaYPAPpY2HdzCoUewTVw18e3glBO88UwJIXtD1t3DB2wyt33U1UxmBxXblcjMo8eYR0Lqb6NBw1ev0wGPCvYhhElMC6G2JU7TNmSj3wbx/fWBqRnryfFyaCJi2dv+ff4tmUSLlweKQR5t799viIzbfuNixQahGmY6umK7XtvTqAiLRGSuvsh7I8QrFqHhCpTZH8zuO1zxHIKsFr0xVfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRXSEjjOgC4q59gRe8yWo9ynOK3QbUffIh9ZXo8yi38=;
 b=Jgs+xbhSdUlRksGic1YE2nTQ7G5I4cOyWIwkcqwGyBidAE+9tUyj+H2Pn5t+W2qHJ2c3yLdSrjVleRMow3c6Wk7ivoSsmJ4YnIVo3qP3ExqnxucjO/MbhEobWpMrIzT1kK22LYWDLeegLRg6EphwdrCC/0GJxVIae+550+wE9JVgdK/hjUr6xlqOt+1p3ao0unFDc7cPFkcgGYn/28g0kIovT7saoJ9EXBmAXFDu3tL0OHsn6I9I1wctd7rdUJdKZjmyNYah8EwMJXISFD884LhulL2g/faAYZJjdSavygWRFg04QqovqGO2FKZLeIg/8jA9SmkHLA8M9VB5ZncQPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRXSEjjOgC4q59gRe8yWo9ynOK3QbUffIh9ZXo8yi38=;
 b=fTleXYiA0DtJHp9ScV+l0OFEKLStAUP+apSZeWVrTPfmR0JIbqSxl13ZQ84r0jj15rAjm2IEd5CpsfpFZ0A6kXQsNuHVTpessPNiW99373lVlh2Of3Ul4+3MFYmWoNidHQGiHxvvnGOjtkEhIc/rrGLmTRJKlAZiwVgx9yZctaQ=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by TY1PR01MB10834.jpnprd01.prod.outlook.com (2603:1096:400:324::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 00:40:50 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::1f99:8d77:182b:f149]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::1f99:8d77:182b:f149%5]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 00:40:50 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Leonidas Spyropoulos <artafinde@archlinux.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH] Makefile: Remove version from /usr/share/makedumpfile
Thread-Topic: [PATCH] Makefile: Remove version from /usr/share/makedumpfile
Thread-Index: AQHY5TeRi3sJqFTIh0uBMvmNJDmGUq4c1TwAgASZ2YA=
Date: Thu, 27 Oct 2022 00:40:50 +0000
Message-ID: <c11dcd13-e146-1ef7-18e2-e03cab19630a@nec.com>
References: <20221021102459.28070-1-artafinde@archlinux.org>
 <8952f78a-fec5-e9b2-7823-33e126aa209d@nec.com>
In-Reply-To: <8952f78a-fec5-e9b2-7823-33e126aa209d@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6777:EE_|TY1PR01MB10834:EE_
x-ms-office365-filtering-correlation-id: 523d98e3-c9c0-4ead-b691-08dab7b3e59e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  hinckqhloUSU9UauGpIfMsiB4dhy7XdMFgsUaBshLs2IK5flTgtQ3KQkBIA/GNZ0/u3eYbN3++aCyXmG9Af0lOqAbMmugPMSGu97azrE62eNULXgsUlSBwO+1lZaO7nvUR0CTe08Jbkx87q+vT9Gxa6vhrXoCJ3GF+hDegPYJOErGentTfGxuKZBusmTjL0RQ+u0afDgLEgof5fdOjNhzolUm4uVrKgFpuVffMstCVJBoKjom6mzfr2ctekyBcCMR1J4nsUbANuLXZntLVL6K6+32Hzz6P3LcyJwlQqgmrQTzoaJn/LiHGVq6FOIYCEvH8ampLlmR2AC5R9r1tRZ6w7QODyH2+RxKrxyMrS0iFUGjwj5UytFt3nYbs9ebnv3N0t8zOzWGuj4k/CrShXaXOniCD7wka2sj5JYOuYrFYbuOCkhBzFyQKkPBXhjPqzAg65RNbXpKeg+I59HFBTimBisR7QOFCa4KV7fxnQLSsw4ADeXnlOSG05HRwpzz1I40qC5vgIQC6cI2XqwWPhv3nKMXhylVnJZhLkajtA9b+B/SDzBzT8iOulM6HMjLgodO+IBGh3fDlwWPTM6guzsi/gIn5SkCwJDgl+mL4cTAsMIX4zGAkoPu2NyW/hPCM1z3ydElgPwq45/sg03k/2IDSy0zw5RTYs921gH8eRoYLPCirAkCAmt6qdzY85HoY5J4lwCEOfJONfzv31/kCdg2aBsdZnAPN6SUVBJ9L9DyiBTmcJZxMI2V0h9gSfZ8C9GPR0+IctZjTquCzfRTg9WmDz6bJo8OO+hfpe6WhJeiamZAnyccOlzwAmo7f81r7Ee
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199015)(66446008)(64756008)(186003)(66556008)(41300700001)(2616005)(478600001)(76116006)(66946007)(66476007)(2906002)(82960400001)(8676002)(122000001)(38070700005)(71200400001)(38100700002)(6486002)(86362001)(31696002)(316002)(110136005)(6512007)(6506007)(53546011)(4744005)(31686004)(966005)(8936002)(85182001)(26005)(36756003)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?SlNxazlPaElIMFRXNHVnNmZYaWRmSkpOT25Qaks4bXByYkMvYktzcFl3YjFo?=
 =?utf-8?B?ZEx2SHZmYk9yQzF2RlFmQ1FzTGxvQVRQZFlxaTRQdHNyVlhpQldoUUtRbFlC?=
 =?utf-8?B?RG1VKzZ4dnRSTDVobk4vVFZvOUhvY1FncXkxei9UUG1DWFBjVDdISUlJMVp5?=
 =?utf-8?B?V1BKM2lWRkJWcU9mU3Y4a0p2Ync4NmczdytKbGt4Q1hHZW10TVIrcjdVN1NQ?=
 =?utf-8?B?TGlnRTNCUk1GQ0pjQ3J4ekVocGw1SlptT3liQnAyb0grOXR2Q3ZuODJHeWZm?=
 =?utf-8?B?QzUwdEtLRUlGN0JJODJlaEpVV2Npc3NCc1VuTXFCbzlHMnMyQm5pUkE5TFIz?=
 =?utf-8?B?aHBrS3ZlMlJ4M1ZEUzdvWmxIQkh6L3ZSd1NlSTdOc3JiVXVTei9oRXY5K01r?=
 =?utf-8?B?RHNCZERUdWlGam5iWTlndThGSmJ0YitOejRBenkweSt1Skk0UFRpN1N3K0RJ?=
 =?utf-8?B?aDFUTDk5VmFHbVpnc0dJUjI4ajloWmN1R1M3M2swMGpjYUZzQkhST0d5OEY5?=
 =?utf-8?B?ak1NNXd2bW5lK25hak9WajM1ZUxDcGQ2OWZmVmR3NzF4VjhpK0c3RWJHdGxX?=
 =?utf-8?B?STFhUUdqN3hWL1c1UzVGZytQblpuMk9DNXlkUUpkbklvU2t3c0kwSUpJRWlK?=
 =?utf-8?B?MzJZNFVucTlRMXBkdWM3Wi9ia084WnNCWjFtbXZobFBLbE5oVGxhUEE2S0Rq?=
 =?utf-8?B?QVVJMDVUMnJzU2FiR2ZPY2h0MWhhUnpHRVQ4aE1ncXR1cnk0NFBFdmM1WmlD?=
 =?utf-8?B?SndwUTllMUpPWEF6Z0VCeENQd2NFaFh5MlhiVjJneWRIQWt2WG44byt1WkJV?=
 =?utf-8?B?dFdTeVFwdmpWRnRCQnFBL091SXc0SHI4eTdLMlJmMFovVS9vRkRpQ3ZhM2Fn?=
 =?utf-8?B?RjBCMHZSQkJLb25MU29vNFN5RDBpNEltaUlta0xNcFl5WnVrUExNRGs3OTJ4?=
 =?utf-8?B?Zm0wZ3hsenk3NjgxdUcvamc4TzZRRjVHVW45Qk1BNWxIUG9CalltbEdrK2JW?=
 =?utf-8?B?R1orcW51MXZDL3lpODJ3MDl3SGNaUGdwZzJTZTJ6d2FMQkV5REJWR0Nwek9P?=
 =?utf-8?B?R3JKS1p1ZWR2RFFEZEloeXhHK3BDa0hqRHVhVnM5cjlGWnJMWExCVGhWQkNx?=
 =?utf-8?B?dDZuZHRlbGtaU3NzKzQyMmpram1SZ0M5SGUraGxtTjBsMDBkeTRTU2JyeUJO?=
 =?utf-8?B?MFJWbzFucE1jN1Y1bGZudENTT3p3OW9Wd3N5bnlOQURlbklyRWx6V0IrVkxk?=
 =?utf-8?B?MSt6UFY2NGlJMGxLU0NEV0xIVzVSVEk4TjRVQThGK0pvemtEbkJBYmJDcEwr?=
 =?utf-8?B?QnBaRndQRDlobjZMa3piRzFrNE1Ya0ppdWo3OWxmMGdUR3VjZDB6YWpTam81?=
 =?utf-8?B?ODl1dm5qaE92dmNBUTVjOUJwQkFwaTNUMTkwNmgrdlQvcnBFZjNLRS9JNG10?=
 =?utf-8?B?bnF6cW5IM1NmeUEyK2wvVHVCMy82RVA0S2lNcXV5bUNTSmJuUVpSSDBzckVN?=
 =?utf-8?B?Y3Zpby9zM1d5SDk0TUEvbWpCVURwRHd3MDNadVZBamZXaEUrYVZ0c0kwVXB5?=
 =?utf-8?B?YmhKTHphQzB2R053NnlaNmdFS21LV1hTNUZ3cFN4R3FvY3dzZHVjRjhjTmd5?=
 =?utf-8?B?US9yNmNHVTVLcUYwbFdhczZvTXhodUhzZ1pOUUQ5dUtzdnpFZzRvYU95MERq?=
 =?utf-8?B?RDBFYWRldkRvdmJFeFdwby9vNFU2bVZjRXV1WHhkVkpjaHI2aWYwUmZVUGpF?=
 =?utf-8?B?ZUNRT2NUZFNmTlRzOEhWdXJBcjVTMjBna1F1WHJiUEp4YnlWRldDc0w4dnJ4?=
 =?utf-8?B?U08vQWNNMmc5bThUVGYxVktyQWt1a0ZNZFlKUnQzRENuOHljQTNQN2doQlJS?=
 =?utf-8?B?QVpnMDhzbjlld3I3OWxWci9SdUMxSlJqYytxZ2JEZHNSUGxQV1U5K0pMR0hN?=
 =?utf-8?B?SnFyVUlMbW1TSzhibnpHMWZuQTJURWlvUGNyNlp6MEp6Yms1bXNJcHRFay92?=
 =?utf-8?B?V0s0SlMzVjdxSGN2WENnTzNucjBSNVZBbGhhTUhNdkpsekVyVExiaDIzOEVm?=
 =?utf-8?B?ekVhM1hYV3l3emp4ZE5oNFg1WHhleldBRGtzZUlLY3J2dEFlNFk3aHBDZ0gv?=
 =?utf-8?Q?MJ/QsYaGWiWmZQnaqJLPzwA0N?=
Content-ID: <1744E0336F565C44BB6D778E24C03E9D@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 523d98e3-c9c0-4ead-b691-08dab7b3e59e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 00:40:50.5603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vudxg8wqIYbVgXESfZKGspm078HBvYAxjjTGAexgGl9odjR4GgHSbQN/JMLwI+njj+5AVG4f5tAWEZWxw2OYjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10834
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_174105_824511_2F27E874 
X-CRM114-Status: GOOD (  14.49  )
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

T24gMjAyMi8xMC8yNCAxMToyNSwgSEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSkgd3JvdGU6
DQo+IE9uIDIwMjIvMTAvMjEgMTk6MjQsIExlb25pZGFzIFNweXJvcG91bG9zIHdyb3RlOg0KPj4g
VmVyc2lvbiBzcGVjaWZpYyBwYXRocyBkb2Vzbid0IG1ha2Ugc2Vuc2UgYXQNCj4+IC91c3Ivc2hh
cmUvbWFrZWR1bXBmaWxlLiBUaGlzIGFzc3VtZXMgeW91IHdpbGwgaGF2ZSBvbmx5IG9uZSB2ZXJz
aW9uDQo+PiBpbnN0YWxsZWQgd2hpY2ggb24gYSBub3JtYWwgc3lzdGVtIGl0IG1ha2VzIHNlbnNl
IGFuZCBkZXZzIGNhbiBhbHdheXMNCj4+IHNwZWNpZnkgZGlmZmVyZW50IERFU1RESVIgcGVyIHZl
cnNpb25zLg0KPj4NCj4+IEZpeGVzOiAjMTANCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBMZW9uaWRh
cyBTcHlyb3BvdWxvcyA8YXJ0YWZpbmRlQGFyY2hsaW51eC5vcmc+DQo+IA0KPiBUaGFua3MgZm9y
IHRoZSBwYXRjaC4NCj4gDQo+IEkgYWdyZWUuDQo+IA0KPiBUaGUgcGF0Y2ggWzFdIGludHJvZHVj
ZWQgdGhlIGRpcmVjdG9yeSB3aXRoICR7VkVSU0lPTn0sIGJ1dCBtYWtlZHVtcGZpbGUNCj4gaGFz
IGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgYW5kIHRoZSBkaXJlY3RvcnkgZG9lcyBub3QgaGF2ZSBh
bnkgZGF0YSB0aGF0DQo+IGhhcyB2ZXJzaW9uIHJlc3RyYWludCwgc28gSSBkb24ndCBzZWUgYW55
IHJlYXNvbi4gIEFsc28gSSBkaWRuJ3QgZmluZCBhbnkNCj4gZGlzY3Vzc2lvbiBpbiB0aGUgbGlz
dCBhcmNoaXZlLg0KPiANCj4gSSB3aWxsIG1lcmdlIHRoaXMgYSBmZXcgZGF5cyBsYXRlciBpZiBu
byBvYmplY3Rpb24uDQoNCkFwcGxpZWQuDQpodHRwczovL2dpdGh1Yi5jb20vbWFrZWR1bXBmaWxl
L21ha2VkdW1wZmlsZS9jb21taXQvZjFkODRhNWQ2OWQ4MWJjN2E4OWFlZmFlNTA0YmU4OGRmMWU1
MDY5Mw0KDQpUaGFua3MsDQpLYXp1Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK

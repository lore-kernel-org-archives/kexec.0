Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA92C3DA70
	for <kexec@archiver.kernel.org>; Fri, 26 Jul 2024 00:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iYecDgoE6nhNgn690yBhBHHOtYnbwmHowtyyFNkDxZk=; b=Nn4CYiU+wu94q9
	N9VzJnyGHIfok6iDXi1ZBxHTL9xU0T74BDcguOZ+Aa9u3H72bKmf90ZBFHCYmynz73phqLEb/LDlW
	KUDmWi8DyqcMOEFk3f/iwuhxk/FV/ZfM8kEsC62j1sLVaUz8k6HMy+OA3auJInt1ZOvet7CXhzx2I
	DtacBwDjWcasrdy+YnuooCXW3lCe7khbb3LaAM+WIOq4tQb/LRVjXEAC8am4ZbX1LbUsRxWoU4bT7
	0/wUhoj4VQRO3ZWActoVXhkqWIhHWA8kv/5Q+oM34kLWQphHFZxDlkftLnp6iT4da5Ik5vBDcRFU/
	Dt/O4LalqNGAgPzNl53A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sX8Sk-00000002SsD-2fWN;
	Fri, 26 Jul 2024 00:05:34 +0000
Received: from mail-japaneastazlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c405::1] helo=TY3P286CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sX8Sg-00000002Sp4-3Cyx
	for kexec@lists.infradead.org;
	Fri, 26 Jul 2024 00:05:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvxQyefgmsCPbqnOwd48Wd0cxDktoD21ILAMBSU6mIK+NhX8ymCMtksSe9JdNi4vvcYFXbIpzYrj/Q2OhQYyWaCzMMLjbji0+4znadKL5AaaP9GCELH5V8TTO4MkpVIJuAeQRq8UNbmELTZowOmiWj1vHnrgI6HeE6oACTMq1B3KPme813wZUK1xlumUNUAs7b9maO7+JglwtL3w+DCdD8RNRx3KemXk48mjjICvFQtyDpvuy8/O8hn3h09jmjvk3L9YVXQl6Dh35GElx+Cjj1+iIOGvxi8ZPBfnFrReCsJi+7UAPR1CQt8p9yESic2yOZHgBaVHOdrSAAEDgNO3kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lgobm8oa0cQyIPb2k9K7JxNtr3MVQqdRnPaCByvaTVw=;
 b=QPZh72ihD5LduqExlpIIogQhSMhbaoZHGLzX52fSiAfqLPvgCmyiWAaEf7EPA/P6xPSbg2YX2TDCmXu+2FSPlNTC7MMrCLo0cM3uP3b03H1rY3NcbUaBzcbcrQHVfDtmQvsbQ+wCQSznqLrEC0wUUUjvM9DVM7iwx070FyULtmlyWEwcfgcTqVPnsO4K78sNFZXbGodmQO+HJzdH0GG3PaQ3vXAH8sAvlza4IFtjPfQBO0wy9EoIZzpCQJ/Zbl0byOp0zP6ZUmzY/gnrlgmmrnZbvSbZdqKjfzndQgPob0aI0y7p/kja3b2D56BvsrzAvYaEe+xG3ngp4+Da/k0wqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lgobm8oa0cQyIPb2k9K7JxNtr3MVQqdRnPaCByvaTVw=;
 b=kiJ9lCAxABcr/zeir0jN3FutjNdjQcHeMR20MdtXLB19AbVcxjXPow+F4eG1aLOhZ/KX7dGIRw3rYiO4ePG5JLtHlzqzsmm/UCm1qX3ea1xeRwJLsGvmjXUPcWPthgSH7hva/xR96MB0VM06YrFUnSQkgFhK6PbxhgqFeUSMoyGRd7jp5olEQQP7bFLPyDA+zhkFYOOtdJsXK3cj9GkN9yF2MnI8I8FRZy+Wpa7stMd6+pCtx5zrFpGbBTKqcYHDR5vsBUvaCsSM5Ze63WnwQnYQFxCHY2ShjGWt9uvW6YI9JQujkZ1OaP7hP31hxERfhjmMWY8ksglGrWYR0ZewfQ==
Received: from TYCPR01MB10963.jpnprd01.prod.outlook.com
 (2603:1096:400:3a5::14) by OS3PR01MB6071.jpnprd01.prod.outlook.com
 (2603:1096:604:d3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 00:05:06 +0000
Received: from TYCPR01MB10963.jpnprd01.prod.outlook.com
 ([fe80::f07d:6a76:a936:693c]) by TYCPR01MB10963.jpnprd01.prod.outlook.com
 ([fe80::f07d:6a76:a936:693c%3]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 00:05:06 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Lichen Liu <lichliu@redhat.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH] makedumpfile: call initial before use cache
Thread-Topic: [PATCH] makedumpfile: call initial before use cache
Thread-Index: AQHaxqMQwxsleF2YyU2gDtYfxt0hF7H6rMAAgAS1oYCAAxXigIABnxWAgAQ6OAA=
Date: Fri, 26 Jul 2024 00:05:06 +0000
Message-ID: <94273290-a7f7-45e7-9c93-6c797dc8611b@nec.com>
References: <20240625015712.3266086-1-lichliu@redhat.com>
 <bcdaf3b8-599d-4af1-af92-188e4072d143@nec.com>
 <CAPmSd0Pd3afnTZGog3pXEY_mh093WDW27HJLUGN2QYDwk8RHyQ@mail.gmail.com>
 <072f683a-e16d-45a7-9f4c-b59e75a8d05e@nec.com>
 <CAPmSd0NoDT8=kOm=aDBb=uAfdSno9YWs6JMh2-_cPWV6juGEQg@mail.gmail.com>
In-Reply-To: <CAPmSd0NoDT8=kOm=aDBb=uAfdSno9YWs6JMh2-_cPWV6juGEQg@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10963:EE_|OS3PR01MB6071:EE_
x-ms-office365-filtering-correlation-id: f21a25d4-781e-4379-ea4a-08dcad069b01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dlVqcWtQYmtnazdlUUxQMmdFRS9FTlQ0UmxJOVYyOTgwZVA0ZzRRZWI0OEJY?=
 =?utf-8?B?b3Z0ZlBoS1VpRWxRWE0xWFQ4ZW5heWZkVGg1eWoyOHlobUNzNzFTRTFoc282?=
 =?utf-8?B?V2Z0dHBoRytYSWhuSnlTTlBvNTh1R1ZDdlgzRUlwbDQySUkrTVMxbGdJOVZs?=
 =?utf-8?B?Mms3T3RWSHExQ0FrL1FqZkJnLzd4cHR5NXhlK3dnUFR2VFV6L3RORnJzMmRE?=
 =?utf-8?B?WU1mZkhJRVlXZ1dqSWJhRXh6bzNKVkhlODFFbXYxOVBmVDhUdi9NRkpsQ216?=
 =?utf-8?B?dzA4bHVwZStZcS85NGRkQVc4aFNPeG9NZU4rc0Jhdmk1VUp2VlV4eVJNUFFX?=
 =?utf-8?B?aU5BVCtObjQ4SXhSNDRGTmEyV0tRSkQrcC9ibUptdzZoSUJocEFrS2hLR3BX?=
 =?utf-8?B?am9pUlJoTE5kUExsRFZMVXdLVDEwZis3VGdlNFFtMldoQm15b21zcmlxZmUy?=
 =?utf-8?B?ejQwVWxUdGhMakZIV3NQUGQxaVVZR1oxdXhOQ1FMSG45cmdRMGJINUZQMGN0?=
 =?utf-8?B?ck9NTVc0RjVRZnV6VjBjb08reGhoWW52VjdwOHNJciszdjNOSWxSVzZxQVJL?=
 =?utf-8?B?UncreU0wQzk3ZW84cDRnRHpnaUdQeFkvUUZQWCt3NVVycW9uWGV0VWRxNVFP?=
 =?utf-8?B?YXgrWUJTdUZrUEhyUXd6T2h4Wi93Q25VbTBjQjJkalE3dXk4MzZlbjlUK2Nv?=
 =?utf-8?B?V0hRR1Z6bEY0NlFGMWE4WXlTK3g5bmtUVlhoWHkxSjBmWlNrKzRhRjlWOFN0?=
 =?utf-8?B?dlU3WHB4QWlLWEh2anBxaGh1eEh5SXIzNUF0NkZEdml5b0pNNkh5djdzOE15?=
 =?utf-8?B?UXBveHBzckh3d054NDhrNklLZlkwYWRNUGxXbEk0anpOZ0pQRHdDdjlWYVFw?=
 =?utf-8?B?YmpEVWo2RlFoVURScXlBUGJ5Z29UNEp4b1BRcysrbWVLbllzU2gwTTVBNzFY?=
 =?utf-8?B?Sm9CeGlFOS9hMGM0Y0pyL3VNQmtKWjJaOVNWUk1GTkczSkFvWHlLYmh4c2NL?=
 =?utf-8?B?NDE0YkhHeUgrdU9PZjNQMEcvWGJZVDRYckFLc3hZLzFPNU9MbU41T01PdVYz?=
 =?utf-8?B?Ykp1bFFoMW52bFVJNHlyVEE1UE5SNjZZNHBnVUhLdVNhejhqUEhJN2ZreFdz?=
 =?utf-8?B?U1dpcEtKRExLZmtVUkZKK3JDbUFzSjNlOWpSVUV1M0NXWG5GQVFjRWtoZnA3?=
 =?utf-8?B?MUZGYzd5dUdOblRtZlFUNjJ0MUdqbGh5SjBPY2I0RUhCVXdjMzdkVy8xTzI0?=
 =?utf-8?B?VUlnckxza2lFTHQybC9jVElCam8xNmZOd01wOURma0x1S2NqclZhZGUyaTRD?=
 =?utf-8?B?SzVEN0s2TCtUdmlHL3BLckJKUW4zRmNCamVWTU9WU3h5bGV2WnFPOWxUM3ph?=
 =?utf-8?B?T3lHSnRkWitqMDcrOERCNDNpZHdGRUFWQ3h1STNQM0plNHlLQmQ5cnFNU2Qy?=
 =?utf-8?B?bnpISlY1NnpMcnJDRUtXVHpBb0hYZS9WcmJidVJ2bXFZY0x0eVFBbWFWajFv?=
 =?utf-8?B?RTcyemhldS9WY2hHVmxlaFJQZ3BOWDU0ZnIxcE5tSEZ6ZnhqMGM4QzIvZjZT?=
 =?utf-8?B?OTdlclBTdlFqUWQzb1Bia1d4TmRlSndySG1iVjJqaVJPc092OGV3WlpNWEJF?=
 =?utf-8?B?dWZYSSs3Z1Z0TERmU25kWlBXNlMxaGV4OFNYdnpsbWdGVFU5VWgxZUJOR2ll?=
 =?utf-8?B?cFpRdThrcUl1SFVuNUVCMmJMb0ZONGNvRkdLdzVCdW1LTi84UEpkVGNCQVdt?=
 =?utf-8?B?dm5JWU11RlRHTFBpZ3hOcjBYR3ZLbjdkT0hZSjhKU3hnbkFzeXR5WS80K1R4?=
 =?utf-8?Q?gLnynqbvkACSgXz2k4s4NgDRRxjE5KNnz9E7g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10963.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFNxOS9ZNWxTYjhXdk9mbmRrOE0vZTBUbjUxVkNQcy83aDRHaTh3bGJrd2JQ?=
 =?utf-8?B?VXRMZTFOa2Urb0Nwa3YxblV5QmsvN3dOZitJSjluVWFrV0grTFBZaHEveStG?=
 =?utf-8?B?MDRzb1cyVitEeFZmVUpRQ1UwcnhxbWIzQWhJSXU2cmxJSEtVdHgxOW5ZV0tM?=
 =?utf-8?B?eUhWcFNxZERmVzJUZm9ISjVRVDhrQS9xZElhN1ZiZU1rajA2RURTSDJXbDgy?=
 =?utf-8?B?bFF6QjdVQ1VOTlErWk9CblM4L3FITjdQMWVRR3puOXJaZmVFaDRHZEtIcko3?=
 =?utf-8?B?TXZhT2pyY09zUXF6c1pseDNIRTliUU9lOHFMaVdaSytnWXpFZUdFaWluR3dY?=
 =?utf-8?B?c3hCTVBVN3Nta0V1Q0JkSURCNVFrdG9CaG1XN2srOGNXU3pZTWZqMTJSVXBk?=
 =?utf-8?B?TGx1WDU3QitwZE9pY3YrcGlCcm9BMlFIaDNjdmtTb3BnQU9VTnMwQUdJb2tU?=
 =?utf-8?B?WXNab25FbndEWmNSV0hSTU53ZWdkYzd5WW5XcFc4OTZhbUhkL2h5U3VYQ1lr?=
 =?utf-8?B?WkpZcVdNV2tHaUJMWGJjd2ZNSWNQN0lWNXRoM3RjMWhJTGx1TkpkcHhqNHhx?=
 =?utf-8?B?WWFMaGVUdkhyWHpKWGhhWHhqMjk2K01GR3hobDh2NU9OeVR5cnFESWV1TzYw?=
 =?utf-8?B?N0picGI2SDRwMVZJZWRrQUozWUdXTFdzd1J5bmRKTlRNV0s3TUF2ZVJCQ2tM?=
 =?utf-8?B?VWFZTThmVWJ1YVA5OUZHdGhiak1HNGdjQWlSWUlNcTFqeXdYR0NUdXNBeVJ2?=
 =?utf-8?B?S2hQTU82eGNvbGZvWW5VdTk3MnlCTVVmVUNuMTEwU1YyT09CcGphL29MRGl0?=
 =?utf-8?B?ZnVSR0VYUE1Wam5lbXVxK29yR05QdmJVcVJvWVIzUDNBMHIveEdKUjArc2hl?=
 =?utf-8?B?cTQrSFVZUFJ3OUJVelN1WG8va2xWcEcvUGJxSjluT3UxU2lNNFpTbFRPYU82?=
 =?utf-8?B?WVAwYmltam51T1l4WU4ySkpZUDF5Uy8xK24xU2lvQWg2NTQzNkZnb3RQdnQ1?=
 =?utf-8?B?VndzWFNQS2YzR3R5N29uc0svRUIraUxnOWZuUjB1cXZFRUZLRDkxZDNaOXYy?=
 =?utf-8?B?Ym9rRWJhOENZcWQ3T1Z5a2JQOFBleGxmY1ljQ2ZrWXJVQWZGR2NvbkdKKy9p?=
 =?utf-8?B?THFFb0JYbVJoMDVLbUc5SUY0UVZFZ2dZNzNSd1prNG51VEN4Tjh2TGtiTml4?=
 =?utf-8?B?bEZBYjlFcFkzSFJoN2d5TllySFcyT1FvNTNRRTlFWWlteis1b0pjckxDK2My?=
 =?utf-8?B?MkVXc0ZiaTdDanVMSmozTlJwTXZxbGVUTWNybHZQSlJSR1ZYdXFtUFZCVWhR?=
 =?utf-8?B?cXBDNDZZL2xRelpLS2FVbVFGUzI4Zktra3NFNmxYdEQ5ZWZlQW4yTURZbGlV?=
 =?utf-8?B?QitmdktHa2licGJhOEx3cjEzcXVHdURLbDZ6SU9DTVl0WUJ1RGFYVU5ZWGhn?=
 =?utf-8?B?NnB5S0NnUW13bWFqNGtzemNDR1lBTVFnUkhRbHFNcUs1bmFaVTBBR3ZXVGk5?=
 =?utf-8?B?OTE4RWUxek1VQndhMlZBSFdlZFdwMWhrSGtKNnFFclZ4dFQrMzB6ZWtHRkhJ?=
 =?utf-8?B?ZnEyV1I0L0VRei90VlFwWktkSmR1MUVWcE5zYzNTOWYzSVVMMWY3WTBCbXJ3?=
 =?utf-8?B?Z204UWdiUEQvTzk5VGZ0Y0g2RS8wL2lhTnZPb0FCaVk4RURzUjFFTWlkUDVz?=
 =?utf-8?B?eWhYckJ5UEhEMkRMWnhoSytueHV5QTBqNFFHMkV0UkFubS9NNmpzVmhpdzJL?=
 =?utf-8?B?ajN4bFpnY2RkOWFoWEtHdWc3SVY4TE1nNWVwUGZjd0t4REx2OXF3Z2RnaHgz?=
 =?utf-8?B?ZWlWQlBJMmVqalZKT1RUNW85MVdKNFV2bDdwZVJjUFBmZXJzdkxJRExHbUtX?=
 =?utf-8?B?ZDJsNmV4MDJIdWpsbnl4TENLTG5PaG1sczRyazU2OFF5T1FoOUhoaE9tei90?=
 =?utf-8?B?SGNLZkJERG1NRmdtSmZPK3FLVjJGTjNJbXF4SEFZeVVwc1paUGhkMU5OSlZZ?=
 =?utf-8?B?Q3d3aDl5TU42UG1wc1lSdFphckxMeWN5L3NNOE03WWc2VEJQWXlraFlOL3Z0?=
 =?utf-8?B?bkVHUmRRNEkvZVlBNTlJdDFUTEE4di9aOFdYekZncHFDUmhBWkxBZm5lRTdn?=
 =?utf-8?Q?bVJJQestYkJShdUHJsW15gyCq?=
Content-ID: <AF15BD8E4203C4478404E7C03F51E83C@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10963.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21a25d4-781e-4379-ea4a-08dcad069b01
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 00:05:06.1363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oOZsq2MDdK3ZIuBVZTflElQEpRJaxU5pfh51gwTh+oJGvTxR1StGvRCuy52AzxyW5iu1m7y8yi8orVP7BNM3kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6071
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240725_170531_056057_A7ED4309 
X-CRM114-Status: GOOD (  22.15  )
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

DQpPbiAyMDI0LzA3LzIzIDE2OjMxLCBMaWNoZW4gTGl1IHdyb3RlOg0KPiBZZXMsIGl0IHdvcmtz
IQ0KPiBUaGFuayB5b3Ugc28gbXVjaCENCg0KVGhhbmtzLCBhcHBsaWVkLg0KaHR0cHM6Ly9naXRo
dWIuY29tL21ha2VkdW1wZmlsZS9tYWtlZHVtcGZpbGUvY29tbWl0LzkwMDE5MGRlNmI2N2IyZGU0
MTBjZmM4MDIzYzFiMTk4YTQxNmNlYjMNCg0KS2F6dQ0KDQo+IA0KPiBPbiBNb24sIEp1bCAyMiwg
MjAyNCBhdCAyOjQ24oCvUE0gSEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ0KPiA8ay1o
YWdpby1hYkBuZWMuY29tPiB3cm90ZToNCj4+DQo+PiBPbiAyMDI0LzA3LzIwIDE2OjM4LCBMaWNo
ZW4gTGl1IHdyb3RlOg0KPj4NCj4+Pj4gVGhpcyB3aWxsIHdvcmsgb25seSBmb3IgNC4xOSBhbmQg
bGF0ZXIga2VybmVscywgYnV0IG1pZ2h0IHJlZHVjZSB1c2Vycw0KPj4+PiB0aGF0IGhpdCB0aGUg
aXNzdWUuICBEb2VzIHRoaXMgd29yayBmb3IgeW91Pw0KPj4+IFRoYXQgd29ya3MgZm9yIG1lIGJl
Y2F1c2UgSSdtIHRlc3RpbmcgZm9yIHRoZSA2Lngga2VybmVsLg0KPj4NCj4+IFRoYW5rcyBmb3Ig
dGhlIGNoZWNrLiAgSXMgdGhlIGlzc3VlIGEgc2VnbWVudGF0aW9uIGZhdWx0Pw0KPj4gSSd2ZSBt
YWRlIGEgcGF0Y2ggYmVsb3csIGlzIHRoaXMgT0s/DQo+Pg0KPj4NCj4+ICAgRnJvbSAwODQ3NDJj
YmE1YjgxZGE1NjMwNzQ0NTRhYjhjODc5ZThlNDExY2IwIE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAw
MQ0KPj4gRnJvbTogS2F6dWhpdG8gSGFnaW8gPGstaGFnaW8tYWJAbmVjLmNvbT4NCj4+IERhdGU6
IE1vbiwgMjIgSnVsIDIwMjQgMTQ6MzE6NDMgKzA5MDANCj4+IFN1YmplY3Q6IFtQQVRDSF0gV29y
a2Fyb3VuZCBmb3Igc2VnZmF1bHQgYnkgIm1ha2VkdW1wZmlsZSAtLW1lbS11c2FnZSIgb24gUFBD
NjQNCj4+DQo+PiAibWFrZWR1bXBmaWxlIC0tbWVtLXVzYWdlIC9wcm9jL2tjb3JlIiBjYW4gY2F1
c2UgYSBzZWdtZW50YXRpb24gZmF1bHQgb24NCj4+IFBQQzY0LCBiZWNhdXNlIHRoZSByZWFkbWVt
KCkgb2YgdGhlIGZvbGxvd2luZyBjb2RlIHBhdGggdXNlcyBjYWNoZQ0KPj4gYmVmb3JlIGl0J3Mg
aW5pdGlhbGl6ZWQgaW4gaW5pdGlhbCgpLg0KPj4NCj4+ICAgICBzaG93X21lbV91c2FnZQ0KPj4g
ICAgICAgZ2V0X3BhZ2Vfb2Zmc2V0DQo+PiAgICAgICAgIGdldF92ZXJzaW9uZGVwX2luZm9fcHBj
NjQNCj4+ICAgICAgICAgICByZWFkbWVtDQo+PiAgICAgICAuLi4NCj4+ICAgICAgIGluaXRpYWwN
Cj4+ICAgICAgICAgICBjYWNoZV9pbml0DQo+Pg0KPj4gVGhlIGdldF9wYWdlX29mZnNldCgpIGlz
IG5lZWRlZCB0byBnZXQgdm1jb3JlaW5mbyBmcm9tIC9wcm9jL2tjb3JlIGRhdGEsDQo+PiBzbyB3
ZSBjYW4gYXZvaWQgY2FsbGluZyBpdCB3aGVuIGEgdm1jb3JlaW5mbyBleGlzdHMgaW4gdGhlIEVM
RiBOT1RFDQo+PiBzZWdtZW50IG9mIC9wcm9jL2tjb3JlLCBpLmUuIG9uIExpbnV4IDQuMTkgYW5k
IGxhdGVyLg0KPj4NCj4+IChOb3RlOiBmb3Igb2xkZXIga2VybmVscywgd2Ugd2lsbCBuZWVkIGFu
b3RoZXIgd2F5IHRvIGZpeCBpdC4pDQo+Pg0KPj4gUmVwb3J0ZWQtYnk6IExpY2hlbiBMaXUgPGxp
Y2hsaXVAcmVkaGF0LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IEthenVoaXRvIEhhZ2lvIDxrLWhh
Z2lvLWFiQG5lYy5jb20+DQo+PiAtLS0NCj4+ICAgIG1ha2VkdW1wZmlsZS5jIHwgMTIgKysrKysr
LS0tLS0tDQo+PiAgICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9u
cygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9tYWtlZHVtcGZpbGUuYyBiL21ha2VkdW1wZmlsZS5j
DQo+PiBpbmRleCA1YjM0NzEyNmRiNzYuLjdkMWRmY2NhNTBkOCAxMDA2NDQNCj4+IC0tLSBhL21h
a2VkdW1wZmlsZS5jDQo+PiArKysgYi9tYWtlZHVtcGZpbGUuYw0KPj4gQEAgLTEyMDE5LDE0ICsx
MjAxOSwxNCBAQCBpbnQgc2hvd19tZW1fdXNhZ2Uodm9pZCkNCj4+ICAgICAgICAgICAgICAgICAg
REVCVUdfTVNHKCJSZWFkIHZtY29yZWluZm8gZnJvbSBOT1RFIHNlZ21lbnQ6ICVkXG4iLCB2bWNv
cmVpbmZvKTsNCj4+ICAgICAgICAgIH0NCj4+DQo+PiAtICAgICAgIGlmICghZ2V0X3BhZ2Vfb2Zm
c2V0KCkpDQo+PiAtICAgICAgICAgICAgICAgcmV0dXJuIEZBTFNFOw0KPj4gKyAgICAgICBpZiAo
IXZtY29yZWluZm8pIHsNCj4+ICsgICAgICAgICAgICAgICBpZiAoIWdldF9wYWdlX29mZnNldCgp
KQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIEZBTFNFOw0KPj4NCj4+IC0gICAg
ICAgLyogcGFkZHJfdG9fdmFkZHIoKSBvbiBhcm02NCBuZWVkcyBwaHlzX2Jhc2UuICovDQo+PiAt
ICAgICAgIGlmICghZ2V0X3BoeXNfYmFzZSgpKQ0KPj4gLSAgICAgICAgICAgICAgIHJldHVybiBG
QUxTRTsNCj4+ICsgICAgICAgICAgICAgICAvKiBwYWRkcl90b192YWRkcigpIG9uIGFybTY0IG5l
ZWRzIHBoeXNfYmFzZS4gKi8NCj4+ICsgICAgICAgICAgICAgICBpZiAoIWdldF9waHlzX2Jhc2Uo
KSkNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBGQUxTRTsNCj4+DQo+PiAtICAg
ICAgIGlmICghdm1jb3JlaW5mbykgew0KPj4gICAgICAgICAgICAgICAgICBpZiAoIWdldF9zeXNf
a2VybmVsX3ZtY29yZWluZm8oJnZtY29yZWluZm9fYWRkciwgJnZtY29yZWluZm9fbGVuKSkNCj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gRkFMU0U7DQo+Pg0KPj4gLS0NCj4+IDIu
MzEuMQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhl
YyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB38C4167D
	for <kexec@archiver.kernel.org>; Mon, 28 Nov 2022 12:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Yh3Rd+CchXPve0K2Ohb9hhW2cUvqrUvwQ6Vx7RXJ9GY=; b=qq6BWw4Dhw1QVB
	G5cnY0U2LzMtpsm/0Us9HdX4z5buFvVUdvRCG518KDMSccpWJYJOuw/FZaA8on6I/1/NGGv0kdqLE
	PP03pULERtd/eahF1vcNVrppyqxmZdVUgwO2Hugtdo/+JkDdHdBRzu9q14ctSpJ5z8anKOsMAdFVj
	/HVp0iAzUZv5qUbQuu274YfKPWORN4wmv1FGARfnNe5OjESDRZaNNlOzg+rWv5N6YSyQ5nnobGnEt
	ep6NzE1CkuiHt6gERxD/A+F2PlhiUSFn+Q4bFgMgE2pNB2r1bLn7YvmTjKw9PPwx65Wf7LdGGXRgC
	/injZde6qgJhCxiv70XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozcrw-001THJ-I7; Mon, 28 Nov 2022 12:04:16 +0000
Received: from esa7.fujitsucc.c3s2.iphmx.com ([68.232.159.87])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozcrt-001TE6-Aa
	for kexec@lists.infradead.org; Mon, 28 Nov 2022 12:04:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1669637054; x=1701173054;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=lOOvK4x6dbwIDe6IqtZy+jjkbpgcQZrRxu9v1HAc6RI=;
  b=Fw2EYasglUNR+q8jXK1zv3AK/HqwSN7BydzBl2fusUsAUSImjI6Wbg3S
   4Hz+31GTV5Z51thXFZ8iJfIyeMEd4BMvPG4c3lF6n5ZSm4ObOTik6tlH4
   nfYSo3wLSPy4MBtTPjJAYEdLB0od8yHSl5u8qxpDGMRSiodR/KjUta/Xu
   k3zzkIYDpQrINPYmtK6aglg0iYBpOLcInW5mznSKnEF2EWZTm6cxsSm8e
   e4CbJS/fpwMPvPftNHhnmMxXdwiOGevCCSEh+6LAiFQk7eduTjVeQrhmE
   OMlRMPbuBGlID9rKI+8UQRIde1+iIM3MFx9XSaxviegVWcYYK3DZ6O7nl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="71165601"
X-IronPort-AV: E=Sophos;i="5.96,200,1665414000"; 
   d="scan'208";a="71165601"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 21:04:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyyQtAPvHF8vtzbZ+yAnGvETPY63wZxus5fgIW2/cUJ9lLjjXyWDDs4aeBxuZG2MmddsC8jFt5+afgxZ4lI1zihBGlHz98orE4ADy/qMy8G/Q5h8VqoH/dyKJvPeoUNsY1Aj0YLlbD4Hb86PJ1tVMCvbc0bs4mjMozoLuKgh/fdPssbxvKojibxprylzTBCvzbTP5OQmvfg0qKEFPmzg4L14iOf54UdtaVTYBf5WGDFR9OZBu7yu76I3CwOAC80MqUCoQTImnJIKTIzhtB6RtgwiwW11EdgMK9HUm6GEOz1B52WLyicwazwgysDgs51gdrzzqEF98D2L90HU+OxHQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOOvK4x6dbwIDe6IqtZy+jjkbpgcQZrRxu9v1HAc6RI=;
 b=a9dR163DFl/aB74YmsiMy3NTo3Bayg+mSI1MqasV5seO9rlbsL93Mq4n3hAT0QPaUoOjn9gEZCgXkR0L3bGf9Ae4aL81Yex5mIkYMTfOCZxy1Iku06LPwOdMXiX5ji2sxWPXoa0GPmKG6lvTKIjbqTURpNikcoyr4J3fqRqhPK1aUTNdCdsmOX9h+TpVmdxKE7zBpXDQv8qZS8uM2iCb3StuUJ6JfPKnHsbGG/RUbT2xDUZcaO6j6Qdl7Ps+ShZAsBL+uIiTTM3OXaNiTPJDx6b+DF7TVZjtSjHg2CMUGrgj39llcw7ElEDIkmELFoP4mHwwsB1ZKmjVU0yzHpImqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by TYCPR01MB9765.jpnprd01.prod.outlook.com
 (2603:1096:400:20b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 12:04:00 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9%9]) with mapi id 15.20.5857.022; Mon, 28 Nov 2022
 12:04:00 +0000
From: "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "nvdimm@lists.linux.dev"
	<nvdimm@lists.linux.dev>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: nvdimm,pmem: makedumpfile: __vtop4_x86_64: Can't get a valid pte.
Thread-Topic: nvdimm,pmem: makedumpfile: __vtop4_x86_64: Can't get a valid
 pte.
Thread-Index: AQHZAyGAOITJM2u3P0G+LOV0TMT94A==
Date: Mon, 28 Nov 2022 12:04:00 +0000
Message-ID: <ac8d815b-b5ca-4c4f-4955-ba9adbce8678@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|TYCPR01MB9765:EE_
x-ms-office365-filtering-correlation-id: 72e6347d-1e7a-46da-5e16-08dad138a28a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  IxRqO1r/7CFVJtL2zX28BSsT9QnqnzKVGx6QUGQjNh05McabiXzHV/e1VMAerIP/a8V8l5v99rTH/wlbeCVAJivdgZ3JXTjMStjh5lha+xITtFaM+PGeDpC4KyhnP21svCh8D41sIsRr3lUm3WQuAYuBlVWhhzmVFjsIlz1UkpMVYYxYdR6Oy3F0ig098xUjMqZi+nhY7jJZEdekRDmUu47M25plVnX+h4HBMH7DEoWlROyF49pCwy9IOJ6hEeKotwnXclbD8oSufWZ8vY4sAaqRjP3yakyICRwzzN2fLw56iC+52aRCcSXh1UXKsb9pwY1Hf7dLKwidIumbb2QQwnInODXkx0oFm9BqZOgQQo+VwBmQX1uCQAw7hJGtvMjxh4h866ZFNGd2q0PgrWrzJYLZ5kShEdbZmpP97cN+wJ1nMKDHxwWXXBiD4UQ/V1xehiC08lhSEsPS4VAyFXhzSULEQF0h5n0XUgZZjU5qRXQhYTza5emHdih63d3oj8uvgAE7Fe56d88gtJEWtvDa9nOQKz74PMK3vBxQrfqTH5zHPLZ36eGTG94X7IAfNp7PaBmK+Tee4gTgLpnmDr7fkE15gb+gOoOJZR+kxL9rhkGG9+mcfhXFIEmTLMg2BMU5MXZBtn3qfun8acK3Y8Uh0TzNnfqwwfkWmkrF07y7YcUQRg9ukxB4MuVSo0v6K6m1C5EuqFRxLGY30Lz7jUKHD17y/VAGnHZIrBD2oraThtTARwpcNdy73tf/ZMnET0dNiOHquoIRlxu9ZYT7SRhTCPwduJM1GKNoMZtij1TzZhE=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199015)(1590799012)(66899015)(2906002)(31686004)(8936002)(316002)(1580799009)(41300700001)(5660300002)(4326008)(66946007)(76116006)(8676002)(66556008)(64756008)(66446008)(66476007)(91956017)(6506007)(36756003)(6486002)(85182001)(110136005)(82960400001)(478600001)(71200400001)(38100700002)(2616005)(186003)(86362001)(26005)(6512007)(31696002)(122000001)(83380400001)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?RWxYQ3FtNFRGRW4xbkllMWdnMFFva2s2b2tMKzlEN0M2WDBWeVB3MVZQdjJv?=
 =?utf-8?B?SXI1aThJa2FmYURVcGg2d2VXL0M2eTBNSFB3VTBrbFRSMS9rZzUyWXdPWVly?=
 =?utf-8?B?WS9zZHhpcmZpNTZncVg3aDAwVWJoTHk2U25jVzVZaEV6MlR6WjNpWXU1RTkr?=
 =?utf-8?B?bTRCT0ZHS3JMVllTUTRRamF4NU5VVUpwaldpNEYzS2pjbDBTR3hVais2OEVn?=
 =?utf-8?B?QXVxeC9McUhmdEcyNWdXQ1Y2QkRpNVg4T041b04vaUVaWXB6YlkrMjRMeGpK?=
 =?utf-8?B?MkFxNTljbmQvK3VzUEpxTXlTZ2lzbVdOSUIvSHloZFZ2T1ZzaG5OblNGWnBK?=
 =?utf-8?B?Vmc5ZnBZOFVIMHBiUVgxSUhxelUydEpjYmJjQ2Y2Q08xWkFGMGpMLzhJVWpm?=
 =?utf-8?B?T3FwaHBWdSt2c2VSQzhLT0pra1hyNnhqcnZQSkFBbXY1STh1b2RRSVF4VVFE?=
 =?utf-8?B?YXVrM0ZnL0o0SEg2Mk5UMERqbEtQbUNiNFo0TGJPMGJDUWkrMW81blAzRGFS?=
 =?utf-8?B?UkJkVHkvY295Q0pmbFB2SmR5RVY2WHRqc09vbCtxYjhOaUdqelBzN0dTUDBG?=
 =?utf-8?B?SVF3MGRtQXhlOE54YnExT0Q5b1hMK0JBWmZELzN6bllyMGxlR25TbmFqdkp5?=
 =?utf-8?B?SUJPOFNyM09LaFJOak5JWnJqSkZGWWw3alZTUHRXbUdML3FKMXdHcG5iUldv?=
 =?utf-8?B?aXVsWG1obEZFM083TE84cHNZd1RON25EOTZzcW51NVJWUGV4MFBYUEpUZFY4?=
 =?utf-8?B?aWUxREFGWmUwVHZIMmlVZUpNdUZWSGhVMWN4elY0TWRJYS9LWVcreXQxUGxV?=
 =?utf-8?B?dGNWN1FRejRjUlpNL2pCQmZDV0hDRVlDdld6R3ZHVWg5Z3JFWVdEcjRyMFkv?=
 =?utf-8?B?eis1OUllVGFyT2F4MmlHd1d2dTNMbzl0b0ZuREM5aUZSQ3IvSlBHdlNLOE1J?=
 =?utf-8?B?VkdHbnh2cVJ6TFk5VWJaWllmZUh2cFJIdnFib2RWTldqNG8yaXgxbDZ4YjY3?=
 =?utf-8?B?Wjd3L2RWN0pTa2lTSmZucHlqbjVKNzRsTjNYSnhPTExmaXZYZXRzbnN5TmZQ?=
 =?utf-8?B?YUphUjlNQWFjSHdUMmhLMGRCWnJiM0t2Q0xTVXdqb2xTYVdTZTR2eVoyNjNG?=
 =?utf-8?B?TXFUVU1lZDZ3OE1OaEVJNVlCYm1iTFF5dFpsWFdHNUlwMXNJc2U3eDQ2Q3Iy?=
 =?utf-8?B?NzFyelBhWnpsVTVreHoyeFliWmg2ZVFFVnNYSysyWEx4eGVSQmNCbStVV29S?=
 =?utf-8?B?cnIrN1ZHTnF3Y0xmQUg1akdVTG9RQThBNzQvdHVUMFhxTmJ1MnNWbTFmN3lU?=
 =?utf-8?B?ZWlMUkNQaWprUjZOQStJdS9jODdXemNsaVFzTklSaFJ6cXM4TVZsNnlIcGQx?=
 =?utf-8?B?czZydE1jRWMxbFU1N2xqS2ZVRVd5NTQxM2Jndnk5ejdDOWt0QTlDc3pMQnNS?=
 =?utf-8?B?RlVOTEVQd2ZmL3VCWTVJY0ljMjhjM1ZzNkhmVUNWS1VyaTVQY2ptWlpQQ2Vn?=
 =?utf-8?B?dmt6T1M4SE02a2lQUjRFaWtQZDErRUNTV2IvTkJ2ZkIrdDVEcVQyd3ZnVlJ6?=
 =?utf-8?B?NEdadWdyaWdtU0tyV3Q5WUhLRFFOKzZLVnI1anBXc3VOZUxRREVKbTRaUXdW?=
 =?utf-8?B?dGdqY0Rnd0l0cjRUc3pORm45M0NWY0syTW5CaGtBelpQNXphb2oxNVp4cXVu?=
 =?utf-8?B?bkRhQU03dmc2b2dYRkJuOEJDSHNvbWdaZGozaTYvQVBXRGttbFBnNnY1L3dD?=
 =?utf-8?B?YldLc1c0THFBbHJEYW4wR3E0SG5nR01xa3lKbHg2YVd2NE5pNTBGQVFJSFBw?=
 =?utf-8?B?cnhsd1psODdrMjd2cUoxN3JuemdvNWdZTGtBQWU1LzBxaHh2YUQwaHl5QkRM?=
 =?utf-8?B?cjZSUTBlYUtCd1l5WE9Layt4VVFveHZRaHpUQWJuZWw2QmpaanIvZmY0RExr?=
 =?utf-8?B?S0hQdUdPQ2NZekpTNFJuSlZQc3orcS9GSXFOMVN3TjdWWU8wUXFnNzQzWlg5?=
 =?utf-8?B?OUVKTGMwclVsMUJDZjR0RFBnejI5VDAxMGdCaTFUK2hrYk81SzZzNmZ6NTd3?=
 =?utf-8?B?dXJNZ0ljOXBvV2IraGFQYnFVZlBiVVZCVzc2UXNHSnRyeXVMVXVxVFhQRUY2?=
 =?utf-8?B?UkNDK0ZWbUN5Y2tBMXdOemZwRmNqZlYya2RDdzl6bmRWNVdReWk2RjcwSUU4?=
 =?utf-8?B?QlE9PQ==?=
Content-ID: <5CC563FD53E2834183D6F620BEEFC7DE@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	edICV0F65iVIR0lt8FXr0Yy4LR5XalKOwgLWXTAKDotRzL5L2q6nzxjhXuYwIdIqZi6d3/5ogEIVS9DC4FxuzPVGVgrWZJNXWFgcftNZQlLfL+uP90R3jtrUYlP/fX8WcGOl1YvudgghwFVlS1m/iTBDfdWNy8iIAzkShJcWElFbGYs4nunBYqmyAcgLPiSlQG2NC3mQg0jr4pV8fRlfdkmrp2od4CeYxHlqTcwI4udlkTl0XZVyQn5CYyXcMt8EJF6cc1e7w9HqCoVNm7fbzXl6CxWCCABC268UzOynFv7kCVENWLVpOgVRdicE6UKGiibZkI5dr5urqbF/k5tTnjiSTtoNti/qRXpUsLLoJt5Om9oqnorIfF2insDA6zbg59Kd4aSp0KzdKHQk5Ohx+tdYhFvCZkViOW89xpvjwY4h6BRXPInsGapjJsAgnXwvryG/QUhr+8kGGYzyMH7pX2zl1EbyX1JARvXsYIVenj+mWNEdOhIKSDdqp8c/So1LhdaHWSf3ATwLIpNpPpO1OlXFEc4EdJeO++1OAvc6L1GfMOWkneEB2UJfbxVLOZqmmpjsia6NpWUQOYT0fHu6Pvk2zvlqwiVoh5Y1V4whZV94bSobq5RV/anEL0pAZ74GCndMPZ5R5It9pMDW6daE1y+lOXh9w0Mg7yV5grUzMcN7efeyzkTSjOGVyOJ3ThjuyRP1hSgLYVhLCjAbQMLI9WhhkQX6XAcxj1drBGsbs+fQQfkWjTBA3mEESLyrpqe0Znejnl5iGMlrdKQcU3CgEW8Ci+6CSZ3XZWPbKh+VhBfChOAmscIKE+AE4Aibzl1zqR141FCtRrGF077tREeCXp8AlHUDty+cZPjhyopvauNQLXnfj3m7aojJsPS9MoQX
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e6347d-1e7a-46da-5e16-08dad138a28a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 12:04:00.1072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9L2kqjzSMRxQRtHB5ItBzITzmPljJKI/AEC9fPGkQZBWqeQOr3djE4uvnMREjwLYCNtr+zl3+2BBNCX767idgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9765
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221128_040413_843292_D3439399 
X-CRM114-Status: UNSURE (   7.59  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi folks,

I'm going to make crash coredump support pmem region. So
I have modified kexec-tools to add pmem region to PT_LOAD of vmcore.

But it failed at makedumpfile, log are as following:

In my environment, i found the last 512 pages in pmem region will cause the error.

qemu commandline:
  -object memory-backend-file,id=memnvdimm0,prealloc=yes,mem-path=/root/qemu-dax.img,share=yes,size=4267704320,align=2097152
-device nvdimm,node=0,label-size=4194304,memdev=memnvdimm0,id=nvdimm0,slot=0

ndctl info:
[root@rdma-server ~]# ndctl list
[
   {
     "dev":"namespace0.0",
     "mode":"devdax",
     "map":"dev",
     "size":4127195136,
     "uuid":"f6fc1e86-ac5b-48d8-9cda-4888a33158f9",
     "chardev":"dax0.0",
     "align":4096
   }
]
[root@rdma-server ~]# ndctl list -iRD
{
   "dimms":[
     {
       "dev":"nmem0",
       "id":"8680-56341200",
       "handle":1,
       "phys_id":0
     }
   ],
   "regions":[
     {
       "dev":"region0",
       "size":4263510016,
       "align":16777216,
       "available_size":0,
       "max_available_extent":0,
       "type":"pmem",
       "iset_id":10248187106440278,
       "mappings":[
         {
           "dimm":"nmem0",
           "offset":0,
           "length":4263510016,
           "position":0
         }
       ],
       "persistence_domain":"unknown"
     }
   ]
}

iomem info:
[root@rdma-server ~]# cat /proc/iomem  | grep Persi
140000000-23e1fffff : Persistent Memory

makedumpfile info:
[   57.229110] kdump.sh[240]: mem_map[  71] ffffea0008e00000           238000           23e200


Firstly, i wonder that
1) makedumpfile read the whole range of iomem(same with the PT_LOAD of pmem)
2) 1st kernel side only setup mem_map(vmemmap) for this namespace, which size is 512 pages smaller than iomem for some reasons.
3) Since there is an align in nvdimm region(16MiB in above), i also guess the maximum size of the pmem can used by user should
be ALIGN(iomem, 10MiB), after this alignment, the last 512 pages will be dropped. then kernel only setups vmemmap for this
range. but i didn't see any code doing such things in kernel side.

So if you guy know the reasons, please let me know :), any hint/feedback is very welcome.

--------------------------------
[   56.380802] kdump.sh[240]:   OFFSET(atomic_long_t.counter)=0
[   56.385976] kdump.sh[240]:   SIZE(latched_seq)=64
[   56.390217] kdump.sh[240]:   OFFSET(latched_seq.val)=48
[   56.395750] kdump.sh[240]:   LENGTH(free_area.free_list)=5
[   56.401295] kdump.sh[240]:   NUMBER(NR_FREE_PAGES)=0
[   56.406772] kdump.sh[240]:   NUMBER(PG_lru)=4
[   56.408783] kdump.sh[240]:   NUMBER(PG_private)=13
[   56.415401] kdump.sh[240]:   NUMBER(PG_swapcache)=10
[   56.421269] kdump.sh[240]:   NUMBER(PG_swapbacked)=19
[   56.426797] kdump.sh[240]:   NUMBER(PG_slab)=9
[   56.428911] kdump.sh[240]:   NUMBER(PG_head_mask)=65536
[   56.435175] kdump.sh[240]:   NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE)=-129
[   56.437522] kdump.sh[240]:   NUMBER(HUGETLB_PAGE_DTOR)=2
[   56.442233] kdump.sh[240]:   NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE)=-257
[   56.446943] kdump.sh[240]:   SYMBOL(kallsyms_names)=ffffffff9e5eb9b0
[   56.452486] kdump.sh[240]:   SYMBOL(kallsyms_num_syms)=ffffffff9e5eb9a8
[   56.458891] kdump.sh[240]:   SYMBOL(kallsyms_token_table)=ffffffff9e76e038
Excluding unnecessary pages                       : [  2.7 %] \                  __vtop4_x86_64: Can't get a valid pte.
[   56.476355] kdump.sh[240]: readmem: Can't convert a virtual address(ffffea0008f80000) to physical address.
[   56.483192] kdump.sh[240]: readmem: type_addr: 0, addr:ffffea0008f80000, size:32768
[   56.489350] kdump.sh[240]: __exclude_unnecessary_pages: Can't read the buffer of struct page.
[   56.494516] kdump.sh[240]: create_2nd_bitmap: Can't exclude unnecessary pages.
[   56.501427] kdump[242]: saving vmcore failed, _exitcode:1
[   56.506871] kdump.sh[240]:   SYMBOL(kallsyms_token_index)=ffffffff9e76e3e8
[   56.511820] kdump.sh[240]:   SYMBOL(kallsyms_offsets)=ffffffff9e574240
[   56.516816] kdump.sh[240]:   SYMBOL(kallsyms_relative_base)=ffffffff9e5eb9a0
[   56.522270] kdump.sh[240]:   NUMBER(phys_base)=4330618880
[   56.526372] kdump.sh[240]:   SYMBOL(init_top_pgt)=ffffffff9ea26000
[   56.531827] kdump.sh[240]:   NUMBER(pgtable_l5_enabled)=0
[   56.535773] kdump.sh[240]:   SYMBOL(node_data)=ffffffff9f2829a0
[   56.540830] kdump.sh[240]:   LENGTH(node_data)=64
[   56.545405] kdump.sh[240]:   KERNELOFFSET=1b400000
[   56.549841] kdump.sh[240]:   NUMBER(KERNEL_IMAGE_SIZE)=1073741824
[   56.554862] kdump.sh[240]:   NUMBER(sme_mask)=0
[   56.558820] kdump.sh[240]:   CRASHTIME=1669635006
[   56.562812] kdump.sh[240]: phys_base    : 102200000 (vmcoreinfo)
[   56.567343] kdump.sh[240]: max_mapnr    : 23e200
[   56.572837] kdump.sh[240]: There is enough free memory to be done in one cycle.
[   56.577843] kdump.sh[240]: Buffer size for the cyclic mode: 587904
[   56.582390] kdump.sh[240]: The kernel version is not supported.
[   56.590812] kdump.sh[240]: The makedumpfile operation may be incomplete.
[   56.593489] kdump.sh[240]: page_offset  : ffff888000000000 (pt_load)
[   56.599405] kdump.sh[240]: num of NODEs : 1
[   56.601457] kdump.sh[240]: Memory type  : SPARSEMEM_EX
[   56.605806] kdump.sh[240]:                        mem_map        pfn_start          pfn_end
[   56.611275] kdump.sh[240]: mem_map[   0] ffffea0000000000                0             8000
[   56.619601] kdump.sh[240]: mem_map[   1] ffffea0000200000             8000            10000
[   56.626356] kdump.sh[240]: mem_map[   2] ffffea0000400000            10000            18000
[   56.631342] kdump.sh[240]: mem_map[   3] ffffea0000600000            18000            20000
[   56.636392] kdump.sh[240]: mem_map[   4] ffffea0000800000            20000            28000
[   56.642359] kdump.sh[240]: mem_map[   5] ffffea0000a00000            28000            30000
[   56.649430] kdump.sh[240]: mem_map[   6] ffffea0000c00000            30000            38000
[   56.656364] kdump.sh[240]: mem_map[   7] ffffea0000e00000            38000            40000
[   56.659915] kdump.sh[240]: mem_map[   8] ffffea0001000000            40000            48000
[   56.666405] kdump.sh[240]: mem_map[   9] ffffea0001200000            48000            50000
[   56.671485] kdump.sh[240]: mem_map[  10] ffffea0001400000            50000            58000
[   56.678435] kdump.sh[240]: mem_map[  11] ffffea0001600000            58000            60000
[...skip...]

[  OK  ] Closed udev Control Socket.
[   57.075801] kdump.sh[240]: mem_map[  53] ffffea0006a00000           1a8000           1b0000
[   57.479463] systemd[1]: systemd-udevd-kernel.socket: Deactivated successfully.
[   57.088368] kdump.sh[240]: mem_map[  54] ffffea0006c00000           1b0000           1b8000
[   57.094242] kdump.sh[240]: mem_map[  55] ffffea0006e00000           1b8000           1c0000

[  OK  ] Closed udev Kernel Socket.
[   57.500084] systemd[1]: systemd-tmpfiles-setup-dev.service: Deactivated successfully.
[   57.101694] kdump.sh[240]: mem_map[  56] ffffea0007000000           1c0000           1c8000
[   57.113148] kdump.sh[240]: mem_map[  57] ffffea0007200000           1c8000           1d0000

[   57.120456] kdump.sh[240]: mem_map[  58] ffffea0007400000           1d0000           1d8000
[  OK  ] Stopped Create Static Device Nodes in /dev.
[   57.128022] kdump.sh[240]: mem_map[  59] ffffea0007600000           1d8000           1e0000
[   57.136194] kdump.sh[240]: mem_map[  60] ffffea0007800000           1e0000           1e8000
[   57.146275] kdump.sh[240]: mem_map[  61] ffffea0007a00000           1e8000           1f0000
[   57.153289] kdump.sh[240]: mem_map[  62] ffffea0007c00000           1f0000           1f8000

[   57.165975] kdump.sh[240]: mem_map[  63] ffffea0007e00000           1f8000           200000

[   57.178271] kdump.sh[240]: mem_map[  64] ffffea0008000000           200000           208000
[  OK  ] Unmounted /sysroot.
[   57.189515] kdump.sh[240]: mem_map[  65] ffffea0008200000           208000           210000

[   57.195177] kdump.sh[240]: mem_map[  66] ffffea0008400000           210000           218000
[   57.202848] kdump.sh[240]: mem_map[  67] ffffea0008600000           218000           220000
[   57.211403] kdump.sh[240]: mem_map[  68] ffffea0008800000           220000           228000
[   57.220052] kdump.sh[240]: mem_map[  69] ffffea0008a00000           228000           230000
[   57.224179] kdump.sh[240]: mem_map[  70] ffffea0008c00000           230000           238000
[   57.229110] kdump.sh[240]: mem_map[  71] ffffea0008e00000           238000           23e200
[   57.237287] kdump.sh[240]: mmap() is available on the kernel.
[   57.243230] kdump.sh[240]: makedumpfile Failed.
[   57.246415] systemd[1]: kdump-capture.service: Failed with result 'exit-code'.
[   57.255054] kdump[264]: Kdump is using the default log level(3).
[   57.262390] systemd[1]: Failed to start Kdump Vmcore Save Service.

Thanks
Zhijian
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

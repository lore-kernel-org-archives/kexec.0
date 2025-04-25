Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383A6C369D1
	for <kexec@archiver.kernel.org>; Fri, 25 Apr 2025 07:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=inGvqoIiV2FY2RSKWOYRWPNK1P5SaL7lYGk0GYPWId8=; b=MoF9//xFE6TZp6v6striEIPxym
	4uQ90XjZvCMhBtLtZTUkHytWAqzAOWJUmSrw0XXNXeW5f7RuIPoinIIsx8bWghE3mRY3MFrYpS0o9
	8X1wI/hrwr07W3pHR03Ao0T9K7+J0BJg4Ohu+glwc6srqsygSDhc1hH41FCmBWMEl/nVNL2lQLIOy
	JKNLLaSYduaBLzVHT8Eynb16jg9krIOUW1jIps4QSVqitD4qGex01XX2CyMkYMO8JePaPzHWLJwNi
	k56ewqwmQOx/ir8ZVws9wzJYw1kQromP/+quMiPtyVqngZm64W4mF1zqEoaFtPGSePDrGZkjtM2Ed
	zrVETyTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8DTr-0000000GBci-0qJm;
	Fri, 25 Apr 2025 07:28:15 +0000
Received: from mail-japanwestazlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c406::1] helo=OS0P286CU011.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8DTo-0000000GBbl-0bQv
	for kexec@lists.infradead.org;
	Fri, 25 Apr 2025 07:28:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAHBDRZj4S1NzuT+2RWB9r0XKprKvYEVFOBQl/MzfjlrtMT1CI+6yj+MH3OHZC1N9mf/34RjSqcnXqPRiZMqvZPsAn7ET9SOME2oZnlegx26fQpwRT+dd45F5mrTDoJCFFiJq5HZiskAsqJdvwdQnilkirc836bxVSUvRS6fvVH6X7t1jZBIyw7J6Svsdt8LSx78hhMMHNSOV+ZFGwRwgQ3OIjHCl9jQWBjQ7Jsv11ynCkSYJUfeLhwwIGpU+uT10E5TegQj5etfgTE179x1nyyT72Pj5ajM/qqTMXdXqy7OrqxsQRLn3cJXRpS/M+X+zg4X64vXQFsS3J0WDQVNKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inGvqoIiV2FY2RSKWOYRWPNK1P5SaL7lYGk0GYPWId8=;
 b=n0x+/EdvLw/BYdjTZvnaCMOF71k9VkT4e5/+vWX2RIbk0ItMW7/LRGX4yF5X5282LtRh0GvbxiERJAeJ61Sgb6/bRLHDKPlJQPid0l/e7AMFYrPD9RBwQMdMj6aITipZ253/CPpiIxCr0RjQZyY2+sKr9xSwaM03nE7KbvF08qrtXXlpLNxMb0zw2lZfwNQWMK1MbfLoEVOELBgJCZrRDIjsYOS0TSTzfziwooQtEkUPfQ3ugGq6sCP7fdf098V5i8o2sbIfcCU9BpEYwu8agPtDR3L455ViFTYvOAkrrPDO90MpKFwrw3ThaeH5WnhKcmu2WktjfLnBsw50mwbUxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inGvqoIiV2FY2RSKWOYRWPNK1P5SaL7lYGk0GYPWId8=;
 b=WLDx+kqP3g4gRHz/K9Ln9/ipueu0AyF4swe3x1I2XQd2VpXkZmX84eIL9bJiN6CJaTzoVAgkZkElt8WVCw6pUfW5DSfB4wz6LU2wJYp6VOfhP5nFr65iAcAsc2wlE3cT4cLZkoYGmjxPFsfqNFRnsBOdciq+M3NWwxlMwcj0HG6xQGqmDkWZmhPP4tS6Od35I1LQLrcKU/3pWSUfuiEW7IcPXZtGJG27iHat+JWERQ9g86b4t/xuLL+pgPrrrNuc2r8MXVLxYHqB7fVIqIUtQU9vJhwYViQcpO8boY8lUrn6dLF8w1My+i2hlVpii39NYvTWW1VaH22WvxYwbD59GQ==
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com (2603:1096:604:1de::11)
 by TYCPR01MB10794.jpnprd01.prod.outlook.com (2603:1096:400:296::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 07:27:59 +0000
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66]) by OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66%6]) with mapi id 15.20.8678.024; Fri, 25 Apr 2025
 07:27:59 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Leonidas Spyropoulos <artafinde@archlinux.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [ANNOUNCE] makedumpfile 1.7.7
Thread-Topic: [ANNOUNCE] makedumpfile 1.7.7
Thread-Index: AQHbs1xfAxkovfKrGk+2M2BL7v/YsbOxnTWAgAJjM4A=
Date: Fri, 25 Apr 2025 07:27:59 +0000
Message-ID: <f556c595-b301-4818-b50c-e185c32fbcc6@nec.com>
References: <0e3945ff-e224-49b2-b122-0c0290d00b74@nec.com>
 <3609c281-fe6d-4a85-af69-0b2ec958250a@archlinux.org>
In-Reply-To: <3609c281-fe6d-4a85-af69-0b2ec958250a@archlinux.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9993:EE_|TYCPR01MB10794:EE_
x-ms-office365-filtering-correlation-id: 7bffc6a7-8373-48e2-179e-08dd83cab4c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VDJxekdFS0tvUU5oYjBwOS9RVWpoU0c4akFNZVIzNVFEbmtZY2ZITmRUb0Uy?=
 =?utf-8?B?ZTJ4OGw3VTRSOWRPSndQa1B6eUZiWjB2ZUQ2cXJ1dXljODhENEo2Wk9mRU9Q?=
 =?utf-8?B?TjFmRU5Iam1tNUliZUNmUFV1cjF0a25nUXgvZWZhMkI4alBrUGdkYS83elVq?=
 =?utf-8?B?QXpwTDF3Z0ExTFVrY1gxRmIzN1R5TEptRk9URktMRmhzQ0pra3l1bjJWeU04?=
 =?utf-8?B?V2ZNb21DQUhmekpEblN2RzJhaFdmTTBqaStzL3U3NVZTY0ZBelNZWnZRbS95?=
 =?utf-8?B?RjRYY05IZUw5V2I2WUJRL1lERjlZcStVbWFvdlN6U255QTNRWWFnbi9YZFds?=
 =?utf-8?B?NWhlZmt0VTRGYm44eGRIeHRPeDczbEtRQzRwcEhmSzhzQjh3MDVHbEtFcmNR?=
 =?utf-8?B?cnpGakRrSEx2b09sb1Z4cENhK2MvMHppY0Y4OEF2WGV6Myt2ZlRWT1BQdWZ4?=
 =?utf-8?B?c1daZCtIRlp4Mlk0M1lDRjExekF1L045SWl2L1ozZ0dNMkdacHlMUlRJME9Q?=
 =?utf-8?B?SGh6d2RPckJrekdpc3d5eUZCc1RDWDhsWEZJOEpWVFJvdG9qYUpWc1dCOW5a?=
 =?utf-8?B?ZHFoRm0zeTBld3ZNbnh0TzRndy9EdDRPdUE2T0cxMWJmNWk2TjdpYXJSRWpt?=
 =?utf-8?B?MGx4WWx6eHo1Z3phcHZ4ZVZMVG05TDhtcURBdUEvOFZJT1NpdjNmNlhORVda?=
 =?utf-8?B?L05EYTdMMGR5bzkvbmlzaFNBblQ2QzMvLzV3blRRRzJPYlZxT2dyMW0rcXNV?=
 =?utf-8?B?TEpsVkYwR3puTnNlN1draEgyMWdPaEZLYjI3VWVRSnFrNWtJWUgwSTVzd2NX?=
 =?utf-8?B?Qm1yTFZIOXFGL0dOaVczNEVyRktFTjJnTUxFMGpXeU10djluQlo2ajNSdWts?=
 =?utf-8?B?K3gzTm1Sb3pLM21MSWVrRXRhOUR3L05yTTNBVmRXckZWUVM0TUdNcUkzTU1Q?=
 =?utf-8?B?R1RYWnJtSFhGSnVpc1MzaXFwMGZKMHJnYWJhRUZTajZUTk1KN1NsTHBBUTFi?=
 =?utf-8?B?K2lydlU0OVZlanBUaUFhL2tuOThwVFRncW9qWGFYQ0JXUG5PT29vc1B6K0FG?=
 =?utf-8?B?VzRHbmo4dTNhcER6TXFONjUwY29YTUVCZnJJYlRZMkxwSEZaU1QvVHh4VkZz?=
 =?utf-8?B?c0I3UzBRZ1NHWEtPam84RnMzVGxzTVVFa1lyVm02SkROM1hjY1ptKzZNeGVa?=
 =?utf-8?B?dXNmc1kvWlpyL3QycTFmRmMwYUk4a0V2YnBiY25xU05TM3RQczV4MTMxeVJh?=
 =?utf-8?B?L2Rnb2ZzdTg3RXBsR2E4NzZsMVZhZ004VWI2cXo2d3psdkZIQ2pJYmdFTHJG?=
 =?utf-8?B?TGRNbnhGbGljcVh0RnBzczNncEpINzNHRWtIVzgwdkFiSW5tdjBqaExaSThO?=
 =?utf-8?B?WnFVLy8rZjduMFdXQUcxWC9YZ25zVDh1NGwwZVcwTWF0UVh2czNnTjQwVXBF?=
 =?utf-8?B?NlFJayt3RDV2YjZHazR2QXpHRzNITzMrRklDRXU4Zk5zZmlXaXFMTjJMbXhl?=
 =?utf-8?B?ZlZMOFlHVDd6TnhlNmMxYUJCUG9kaXdjcUZBRUs1WHZQQmJYS0VIci9odmhD?=
 =?utf-8?B?bWFLZXZ5dU91RW9zRnN4azFMWjdkMjQ2Z0pnczduL1pxMlR2ZGwrTEpaMnZB?=
 =?utf-8?B?MS8yL0lrV1I2UWpyME40VVNxZ0hYcGZocUQyZXFLT3RFVW1TWWlxZ0NiMzMw?=
 =?utf-8?B?bHNQcXY0eDdIMllGRGx6T2swb244bDFQNkhwSlRnS04yWVhXY0tmTEpQZldE?=
 =?utf-8?B?S3Z2S3A1b2kySjVrRHdrZjdqNVFYQmVrOFZBam5pZUUxOEh4d0ZJTGF4RHNZ?=
 =?utf-8?B?TmlZNWxFMXVrY2xIK1ZyMUJLbkpURjJUZkg2cnA2RmI2VDNhblhkeC9nM3Az?=
 =?utf-8?B?NXgxMzN5c1g4eXhFakNZR3NmWDlYTWM3Um5Qd1JHTnpKRVQ0NGNaU3orc0pq?=
 =?utf-8?Q?Kdr7EL8wlK0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9993.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cG1jajBHUXQxcFhIY0lpSWgyWENySXBVekVOUUFmK0dKTk05OTVhQkNsVmVV?=
 =?utf-8?B?Z3dJWnJPVzVPM2ZxZTBIbWVPTkkwVzF4UHlOTWtwc0EyaGMyKzFuR28zUEVp?=
 =?utf-8?B?TnRCeUd6ejluM3V3NzUrbFA3d0lWTDMwc3NsUW9ZV016OTJMdVFmYk1SRFpt?=
 =?utf-8?B?eGJiZVhsRmRnTmVGNG1qdEFqTnJwVTlJWURxbWdLanRNa3NpcDYxSkM4ZS9T?=
 =?utf-8?B?MVVhcjVBQUZ3TnB0dk0xdm9jSVpzRzRjZXAxZXBVZXFYZGl5Y3hpZEh3QnB2?=
 =?utf-8?B?OHlKRWIrSlFxRXdpZkwyNVNOdG1iMVRPS1Z3Q3BEYTZnTWdZNEh2cHpFRjJK?=
 =?utf-8?B?dVZMTU1uckFNL2N2R0tsMnFPcXpZcEdVL3RYMjhyVXJnVHNHTGlLTkxHZGVX?=
 =?utf-8?B?WEIzZ1hSUVF3dklqRjJoMVFuWWFwZmFaZnpqSXRIbjdNSm1GRHVrdWJSY1VT?=
 =?utf-8?B?a04yaFVVT1Ntd0FZSGdDb2dWSTlLNGJjMFhRTXY0dmlmWnFVQzIxMksyTXZL?=
 =?utf-8?B?a3ZaMisxZXRLSEFMdEZCdUFqL1ZtN3BYTy9sNGpsaU5mYVZFWWsvL2tSNlQ1?=
 =?utf-8?B?TDBFTW8rTC9Zd1FyUmNncnlHZ1BWY2R4WEg5K2RWTWcwakZoYlFYWFVDNUt3?=
 =?utf-8?B?WXpaVVp6MHAxSnFiWHY3bGU1dWhyejUrQ1M1WlBla2Y4cmdFU3o1ell3WUp6?=
 =?utf-8?B?ektodXV5VjA2Q1AwTTZkc1J3TmQxcE1CcmtNbEowd2xMbnhROFJRc0JlSFBz?=
 =?utf-8?B?NmNEZzFGUGxLMFRUVmxURHNTZ0tmcW5xYTZ3YmlmUTlHb1E0RVlPWHhzRlo2?=
 =?utf-8?B?aUErWmNBeDFpKzBVZEduN1haeGtaTXlHdkFtcXo0b3BXMmFqUnFtcUhyYWZR?=
 =?utf-8?B?M2tTaUhuWk9naU9waWZqcTY1QWdkaWNZSEsySmlhVDFqbWlDKytaZ2h5Wklo?=
 =?utf-8?B?V0hDNmUydktEcktUSS9IQzAra0FtOWJtamNkQlBSVFNOeW14Z09seTM2dUNQ?=
 =?utf-8?B?MndQVnRaSXJYZm4wVUg0c05ZeXh3Q2Fuc1ZzTFliWTcydWUrRnRIWjJ6Mi8z?=
 =?utf-8?B?dHo5VG9qRm9uQXZVOG9EUng5VkF1RmF6VjRWTzZzNHNmdmFsVzFnZU9LQ05y?=
 =?utf-8?B?Ukh6ZmsrOEFFdVYycXVrNUxsdW9MdjJtK0JNQ2w5TUNlOTdqd1JnQXJHRk1N?=
 =?utf-8?B?Z2tmbUdkdDFLdTdLYmpGN1NXWlZEVlNvc1dwb1NsVGxjK2xmRloyWlE0dWZ3?=
 =?utf-8?B?eVE2czY1NXVMb0huT1E2eFpGVEY3VGgyb05INFlSUkZiT3RiSy8yNCtmbGk4?=
 =?utf-8?B?eXZRdithSTluVTV6TUo2bW5peTk5YURKQjRRRkN3SVNSa2ZlYmtlMTVrd2lZ?=
 =?utf-8?B?czJBOEJyUzl3Y001dVpzQWtwckJrU2FLVHN2SlJDMm1DSitIWVNjanBac0Z2?=
 =?utf-8?B?V21BNUJWSWY0TVl6N3NUTGphWFdQdDNyY1kwYzZGcDNUTmJ1R0ZsT1ZKTUQ1?=
 =?utf-8?B?aEdVK3JvdFl0azB0bjZlOWtsbDVmR1czL3Z1cS9oK0FWNjJIWGg0RnczOGpj?=
 =?utf-8?B?dHV3WjBkOVdHTzBOaTRjOU1oVkUrQzlIa0NsNW5uL0dWWlVHVldaRFZQdUpk?=
 =?utf-8?B?RVVENmJXM2tScWtUdjJ6Zm85SEVpekJQeS93UWJ2enkwV3BPNWZhaUpUM3J6?=
 =?utf-8?B?dFFHL2ltS2RjRzY5ZkNOdk1VRGJJQzN0eGFybG1XVlc0UmlLRVJ3OW41Rkwy?=
 =?utf-8?B?c2hXSVdwRmJhcTRFc0VDUUtYVUptYVZyeFBzUWVuQ2VCTDdyZlAyaHlRYUdL?=
 =?utf-8?B?SFVUNGxVV1JwcHplK3JraVRxSnBSWDloaXQ2cUh5OXZXdEp1VVNpZkJId0Iz?=
 =?utf-8?B?Lzh3aXpCUWVHaWR4L3ZxWFNrdXRMZERxVGtubXRSbTR1WFl6LyttNjZVK25H?=
 =?utf-8?B?SGJ3eHhyVmg0Z05Dd0VZRXRFSTR3RWFVRGdRTk1hLzFJUmhxYnZBTENDQ3VC?=
 =?utf-8?B?ZDZsVUY1d3B3VUxJY1doU0J1Ynk0WFVuOWx3VEpUSEtEY2c5akRwV29xWFZy?=
 =?utf-8?B?bk1FekpUcVg3NTRIZG9CME1vVXRmNFlDMjh3Tk83anVKVnI2eTBVendIbnNx?=
 =?utf-8?Q?wHlk14ULkpLZZHONFgrOcVO6Q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4ED4AB00EA282F4EAE82D21775620758@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9993.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bffc6a7-8373-48e2-179e-08dd83cab4c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 07:27:59.5372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JuGucpvXzoVK5L+x/mBn7/scI8z0YY7pXwfa5QXoq8xVROz4SLlBoyrhvuaYaaUjTEvM1QwAfUhu9XhM4vmZCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10794
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_002812_452331_02B2F9F7 
X-CRM114-Status: GOOD (  18.28  )
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

T24gMjAyNS8wNC8yNCA0OjAwLCBMZW9uaWRhcyBTcHlyb3BvdWxvcyB3cm90ZToNCj4gT24gMjIv
MDQvMjAyNSAxMDo1OCwgWUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkpIHdyb3RlOg0K
Pj4gSGksDQo+Pg0KPj4gV2UncmUgcGxlYXNlZCB0byBhbm5vdW5jZSB0aGUgcmVsZWFzZSBvZiBt
YWtlZHVtcGZpbGUgMS43LjcuDQo+PiBUaGFuayB5b3UgZXZlcnlvbmUgZm9yIHlvdXIgaGVscCB0
byBtYWludGFpbiB0aGUgdG9vbC4NCj4+DQo+PiBEb3dubG9hZDoNCj4+IFRoZSBsYXRlc3QgbWFr
ZWR1bXBmaWxlIGNhbiBiZSBkb3dubG9hZGVkIGZyb20gdGhlIGZvbGxvd2luZyBwYWdlLg0KPj4g
ICDCoMKgwqDCoCBodHRwczovL2dpdGh1Yi5jb20vbWFrZWR1bXBmaWxlL21ha2VkdW1wZmlsZS9y
ZWxlYXNlcw0KPj4NCj4gSGVsbG8sDQo+IA0KPiBJJ20gYSBwYWNrYWdlIG1haW50YWluZXIgZm9y
IEFyY2ggTGludXggb2YgdGhlIG1ha2VkdW1wZmlsZS4gUHJldmlvdXMNCj4gcmVsZWFzZXMgd2Vy
ZSBzaWduZWQgYm90aCB0aGUgY29tbWl0IGFuZCB0aGUgdGFnIHdpdGggdGhlIEdQRyBrZXkgb2YN
Cj4gS2F6dWhpdG8gSGFnaW8uIFRoZSAxLjcuNyByZWxlYXNlIGlzIG5vdCBzaWduZWQgKG5laXRo
ZXIgY29tbWl0IG5vciB0aGUNCj4gdGFnKSBhbmQgZnJvbSBhIGRpZmZlcmVudCBwZXJzb24gKFlB
TUFaQUtJIE1BU0FNSVRTVSkuIEZyb20gYSBjaGFpbiBvZg0KPiB0cnVzdCB0aGF0J3Mgbm90IGdy
ZWF0Lg0KPiANCj4gSWRlYWxseSB3ZSdkIGxpa2UgdGhlc2UgdG8gYmUgR1BHIHNpZ25lZCBhbmQg
aGF2ZSBzb21lIGtpbmQgb2YgY2hhaW4gb2YNCj4gdHJ1c3QgZnJvbSBwcmV2aW91cyByZWxlYXNl
IHRvIGN1cnJlbnQuDQo+IA0KPiBUbyByZXNvbHZlIHRoZSBjdXJyZW50IHNpdHVhdGlvbiBJIHN1
Z2dlc3QsIGlmIHBvc3NpYmxlLCB0byBhZGQgb24gdGhlDQo+IHJvb3Qgb2YgdGhlIHByb2plY3Qg
YSB0ZXh0IGZpbGUgd2l0aCBhcHByb3ZlZCBHUEcga2V5cyB3aG8gYXJlIHJlbGVhc2luZw0KPiB0
aGlzIHByb2plY3QgbWFkZSB3aXRoIGEgc2lnbmVkIGNvbW1pdCBmcm9tIEthenVoaXRvIEhhZ2lv
LiBUaGlzIHdpbGwNCj4gZXN0YWJsaXNoIGEgY2hhaW4gb2YgdHJ1c3QgYmV0d2VlbiBIYWdpbydz
IEdQRyBrZXkgYW5kIE1hc2EncyBrZXkuIE9yDQo+IG1vcmUgY29tcGxpY2F0ZWQgc2lnbiBNYXNh
J3Mga2V5IHdpdGggSGFnaW8ncy4gSW4gYm90aCBjYXNlcyBhIG5ldw0KPiBzaWduZWQgdGFnIDEu
Ny44IHdpbGwgYmUgcmVxdWlyZWQgYXMgb2Ygbm93IDEuNy43IGlzIG5vdCBPSyAoaW4gdGVybXMg
b2YNCj4gY2hhaW4gb2YgdHJ1c3QpIGFuZCByZS10YWdnaW5nIGlzIGFsc28gYmFkIGZvciBkb3du
c3RyZWFtIHN5c3RlbXMgYW5kDQo+IGZvciBzZWN1cml0eS13aXNlLg0KPiANCj4gWW91IGNhbiBm
aW5kIG1vcmUgaW5mb3JtYXRpb24gZm9yIEFyY2gncyBtb3RpdmF0aW9uIG9uIHRoaXMgYW5kIG90
aGVyDQo+IGRpc3RybydzIGluIG91ciByZWNlbnQgUkZDIFswXQ0KPiANCj4gWzBdOiBodHRwczov
L2dpdGxhYi5hcmNobGludXgub3JnL2FyY2hsaW51eC9yZmNzLy0vbWVyZ2VfcmVxdWVzdHMvNDYN
Cj4gDQo+IENoZWVycywNCj4gDQoNCnNvcnJ5LCBJIGRyb3BwZWQgdGhlIHByb2Nlc3MgYmVjYXVz
ZSBJIG5lZWRlZCB0byByZWR1Y2UgdGhlIG1haW50ZW5hbmNlIA0KYW5kIHJlbGVhc2UgdGFza3Mg
b2YgbWFrZWR1bXBmaWxlIGluIGhhbmRpbmcgaXQgb3ZlciB0byBNYXNhLiAgV2hlbiBJIA0Kd2Fz
IGEgY3Jhc2gtdXRpbGl0eSBtYWludGFpbmVyLCBJIGhhZCBub3Qgc2lnbmVkIGl0IGFuZCBnb3Qg
bm8gcmVxdWVzdCANCmZvciBpdCwgc28gSSB0aGluayBpdCdzIG5vdCBlc3NlbnRpYWwuDQoNClRo
YW5rIHlvdSBmb3IgdGhlIGluZm9ybWF0aW9uLCB3ZSB3aWxsIHJldGhpbmsgaXQgaW4gdGhlIG5l
eHQgcmVsZWFzZS4NCg0KVGhhbmtzLA0KS2F6dQ0KDQpwLnMuIHdlIHdpbGwgYmUgaW4gaG9saWRh
eXMgbmV4dCB3ZWVrLCBhbmQgYmFjayBvbiBNYXkgNy4=


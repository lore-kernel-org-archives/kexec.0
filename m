Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451F2C3DA64
	for <kexec@archiver.kernel.org>; Tue,  6 Aug 2024 09:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jPa/yzyfIQc6tQnWM1DHl0tdQA4cjpnnaqjIbhl7HME=; b=Dg40UqpbfMWtOt
	sZRZPgawTzfA/ASrJX48TA3Q5cyU5MShD/5tO6Xjxa2vKictXi5HWZ2aleKaFH8yFJFgRPK2NY85D
	ZoMESu/qCpVMARC6s4cJgoT8sdCgp2ZlTVHKhthqZ3WdxIAiBvYXSj0ALD1CvNlJh8qGh6DCSg2VS
	JAuA+8flsegh2fbknFFDKzNm1kesGSyunBLlviXXzKnZ8eVdMhC+p3bnK2TBULVyZoyltuJfltYuo
	GEnOKZTgfP1/oZPXoSsxq2Q+3mOOgprnQOPkIaR6g7Z9aDS4v8tO9Cwn4inRczRX61q8D19MmVJBG
	sSehpzh3R9G92gr7+ycw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbG5d-000000012VZ-02PH;
	Tue, 06 Aug 2024 09:02:45 +0000
Received: from mail-japanwestazlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c406::1] helo=OS0P286CU011.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbG5Z-000000012TT-1DdW
	for kexec@lists.infradead.org;
	Tue, 06 Aug 2024 09:02:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KflpaggjRstmKC7eAMXVkzzri5/un1gXuz9Bp8uE+v4JKIsdWTy1h4ZCR01z4sd53LrncNHviWxu5vA7vez+lCnlfpJFwXZuRDIR5UDkR5xkuLfW4jGxb5Vaq7mAO1No2bBzMOtNFhMLgbasFXUtEJEUwzPeTPFzXk7ycFGmlH6t1hHzlQyA4ByRnqW8g1PT9Bdd2S2adhWY5g3zWCKiGmw8rThD9ZMr3UPojqB3DVGtjYwy0KSQiSYHm4+Y0hVw25DA/K6qBOJX2jui0fUlclLo11q2SP8md1zEQrS+xb8S1zOHSE+hcDNcD1iqLNqPafRGjHJDMUrNtf6Jx5tcKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFlZJa/ygHdTFfz6sECTGdiVtHwNHsWakU/4XFEUGz0=;
 b=a52mmH8J/YDSArj++LYD2jIJZKFI7kiZhHdLAoN3RBotOhA/+0iwblAMXobUd6WfjMI51Q29A0805esapNqxtvG0LxTDH4nrom8SeFlCHrjtHCrfzVQn2qFzJtIdLuGLoTj5WVIdVQ45Zm02UCY9Tpvz7MOrYnOJ2lhN5hbrVjl3LTztcNsFsOuWZabm+1EQ8jRK80hBVR46OPbHeWQ1bc6RBokPcpFBKoKVweRJ/ddhCtymBAMYy8aOmtVrvv1cmNYWiCDrkWbIBPZf7D/3kjuVF1t7VWcFEHVKg7oNNRj7pYnCrpDAxsEwLebAjWH7uWjpO6XujiMP6c+/B4VJtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFlZJa/ygHdTFfz6sECTGdiVtHwNHsWakU/4XFEUGz0=;
 b=ACt8LUidZ0nxh6nfmjkm0foR/Ir7Cb/yPblm+wqdcygAM6B02WWQj5vjkNXnyyZ5iFmlAlfTr2hjnzgNz/9q2ZduAvFwLc+rsGKFhyp2Jb/PUCjzc2qylMRdSQ9cWlhnXk7zAw9+9N42ww5EkO4JE0ZiQxMYhDLKz4EvyBEKeA1xLWg5COen0Ef1Pqs2fmJdq14NytoKIarqJaiFtbGuvRiD4QOrH5tY3Z0+JIrheOqX74REIflZLboEGaiqAz3kFjdokfqqJ0hoV5NkK6/xXjQ1HyIKhAbXZ2iGetQCWDHQkp2qiwxJjdjiM6OsFVTe3i8x0utVqn4XiGWHKxZ+3A==
Received: from OSZPR01MB8561.jpnprd01.prod.outlook.com (2603:1096:604:18a::12)
 by TYWPR01MB10002.jpnprd01.prod.outlook.com (2603:1096:400:1e2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Tue, 6 Aug
 2024 09:02:22 +0000
Received: from OSZPR01MB8561.jpnprd01.prod.outlook.com
 ([fe80::762e:140d:d637:26ce]) by OSZPR01MB8561.jpnprd01.prod.outlook.com
 ([fe80::762e:140d:d637:26ce%7]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 09:02:22 +0000
From: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>
To: Jiri Bohac <jbohac@suse.cz>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>,
	=?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= <k-hagio-ab@nec.com>
Subject: Re: [PATCH makedumpfile] makedumpfile: make reserve_diskspace do
 nothing for flattened format
Thread-Topic: [PATCH makedumpfile] makedumpfile: make reserve_diskspace do
 nothing for flattened format
Thread-Index: AQHa599ZId2eZZz4qEa7XlAT+SaX0g==
Date: Tue, 6 Aug 2024 09:02:22 +0000
Message-ID: <99a146b3-bf8d-4de2-9d9c-0abcc705b3a6@nec.com>
References: <ZnLJOTWFM5P1PTMf@dwarf.suse.cz>
 <5b665470-182f-4414-8a9b-b1ebf5337b2c@nec.com>
In-Reply-To: <5b665470-182f-4414-8a9b-b1ebf5337b2c@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8561:EE_|TYWPR01MB10002:EE_
x-ms-office365-filtering-correlation-id: b6b72f5a-8001-483f-d376-08dcb5f67bd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V2RMZXk3eE45R2RsN0xueEJOUWwyUlQ3cG16UFJyamM2bUxHT1ZTMExWcnlW?=
 =?utf-8?B?cC9Bdmt0VkQ0KzZjV1lKSnZrLzI0U2R4S0R2a0x1M2Fna2ZOOUp1cjdERnI3?=
 =?utf-8?B?RkxBS3F2dzUrY0lrczdHYXhQcjRIeERCMndOWGVVT0YySW1MNlpJVCtYYlpD?=
 =?utf-8?B?bWlUY3lxYXIzakdPMjI0YmM5TXNRT3JXZy9oN0R5SENBSGNBQ1ZtRGNXT28z?=
 =?utf-8?B?UkFUK3hxd1I3UkhOMW9kOEEwUVArUjlMQnA5YlJ6UlVDQjZ3MGFjQ1BJRXhq?=
 =?utf-8?B?QzhsMFRBSWQ4YXhrQ1FtNDJ0ZWYxdmUwMkhoYUEzRDExQnRtdW9vbnQxYzNn?=
 =?utf-8?B?UWIyZTk3b1g5MG1JVnZKTHVBVUFqVkpXNFkrUDdzQUJCbFdkZEtUV09iSWQr?=
 =?utf-8?B?cEp3RkROTm1iT2VNWE85UDZ1cUF6MFRjWkRoY0pKYStUd0tQazRwOWpPaCs2?=
 =?utf-8?B?V1dNbmYrVDc4dXZBdjVVK3Qwc1JOeFJKdTRnMjRGcWRhSS8xTDV3eW1aVW9u?=
 =?utf-8?B?NGd0UFNkM1NsSVBmaERNSDRTUnUxTTBtV3ZTdVF5RE91U3dtQmFDRzJkT01V?=
 =?utf-8?B?dWVNMitneGNPVEJ5bWRad2FMekw5RExWODZCWVo3cEJUcXRUUzRRNTQ5aHcz?=
 =?utf-8?B?TE5zK0ZrY2Q1ekhydU5vMXZ1Yk55YktqTFYrV0F0MWdudDRha3RobnFmVkFQ?=
 =?utf-8?B?RFFLZU9jbzdXcFpVU2toZ2JWTGY2Y3VHVnJpY3JLMHNPTHZYRVRWOVhtZVl4?=
 =?utf-8?B?VSswREE4Y3VBKzE0bkZsSFdwSjUrV05JaTF6WUhyc0NuaFJxMVBQR1Q4azVZ?=
 =?utf-8?B?QTkvZlVpa1BVTzU0UmpGc3dWb0VlZHVFYXVJQ3ZKVTRMSGc2UFBETk9yZE54?=
 =?utf-8?B?LzBYQndCZFAzbDIwZ3FKbzkzbTJ4MkJURUdQSG8wY2hBMkpYMEdEYTRRcnRo?=
 =?utf-8?B?VXYrcnc3bVl3RG41U29OeVFONHVXb2RtcXJhQTlSQnVaMGRKeGt0OWhTWWZz?=
 =?utf-8?B?U2RMeXMyZWsrQm4yL0xRQ1BEbWpEN24zMDJXU1hQZTZheWdxRmJjUk04bEVi?=
 =?utf-8?B?ck9xYmdVMWdKWkpMNUNLZWlFM0JxMmxoakRUblNPQUF5RTJ2NVQzNTBsWUEr?=
 =?utf-8?B?aWRsVUJMUUJuQW9sVUY3c3NqenpEc1d4a1ZISk5wQjBmUDNJVkJSa1E5ZEdo?=
 =?utf-8?B?NzF3c2J4MFRrWDdkT3dKNzJpUktNSE9WeUtERkJwWnUwemx1RldKVkZrMnNz?=
 =?utf-8?B?dEdWRFAzeHJGQWtrQmNxQ1NGY21vOUxuQ0s4VW9MUzArUUhrZmZySGNlWWFM?=
 =?utf-8?B?ZkV5VCtndlFIM0VwaW9pS3Jid3NGazM0WGljR3o3S0JCVXh0WVQrMFEvaFZ0?=
 =?utf-8?B?aktrOHg5TW9NalpMZFg3UnJmWHpkaDBya1JmSVZpd09KZlIxa3R6ZE5YT01t?=
 =?utf-8?B?NS96OVRieXRyL3dXeTZmOU5NUXJxRk9qeDN4NlY3UWw0N1haQklMU2NNYloz?=
 =?utf-8?B?cHROKzhjZnN3c3lrK1JUN2NJdTF2V0FYcUdpSHNEYjBFeU01RTFhbUpSL2M4?=
 =?utf-8?B?S3ZyS2Y4UnZjZlc0c3U4b2I4SW1CbVc1ZVRucHNxN0xka2JmelF2akJoWUxU?=
 =?utf-8?B?UDZ6TmFnaVFlZ1dQQnkvamJFS3h5cjVXVkY4NlV0ck9Lait5SFVVVXo2RWdG?=
 =?utf-8?B?bEx6YVdNTi9JUFIxRVVaRVp5cWorM1lDT0o5NTVrWnpLS2gwOGl2Kys4Wkhi?=
 =?utf-8?B?SFVJZiswVm83a2wrSnJKSGRRSEJTT0FSbnZnTkd2MGthMU1yUW4wTExEeXFD?=
 =?utf-8?Q?SwE57elbBqsGGVbFz+uFhCtLJCcLIP4O8Hzl4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8561.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3hsWWlVSEl2a3lwZjgwR2RIVURIVlNBVGozK0FQejByenlUWmVGUUdyYTJo?=
 =?utf-8?B?YVhRM3JsbzRDQ0g1S0RhZjI1WHh1YkFpUGt1RnF1Qlh6NWx0OUh4ZWVuU1hU?=
 =?utf-8?B?TGJOM3VXc0ZoVUduYVJ0SkdGVTlVb0dEMkY1cUF4TWw2elVkOVVKQ2gwOTRQ?=
 =?utf-8?B?dDluWmVTM1dyb1dhaGNPaTJ5T3B5d1M1SSswUmtVRUtMS0RvbTlBdXJHcC9X?=
 =?utf-8?B?dFhieUFOa0l3K2FBaWtHaTdsYU1pUDlmejR1T1NkdTducTlobkhaMjdRZWlm?=
 =?utf-8?B?Q2VaS0JZTnFUL1hwVUhmdUZ4L01LZGl4R3d4ZUNxeGhxUmc1UGZmSk9ZSlBL?=
 =?utf-8?B?VitKdXpjdFlyTlY2WWZtTDduM29adDc3L1JReGpMSkg0Q1FlUlgzUmdmdWtS?=
 =?utf-8?B?YnBMOVdvQlIwNGZMOG8rS1JWOVlPaUZmSFVjZFE5QzVHbng3S3lTZTAvTHky?=
 =?utf-8?B?clFVU2s5SVN2aTgyclZpd2ZwSW9BR2NUcTdDNzNPUHlBR3YwVThVbEJDUW83?=
 =?utf-8?B?TWFkT0VGZllxR2R4SmZjNUE0TXFFV3lZTDY3K0x1STJxMit6UGhsOVpsZzg1?=
 =?utf-8?B?d0JoNThBQ21uaUNQc2todlVRUkpjRUxqR1o1aVB2OHRVeEk2UjZZZ0YramVp?=
 =?utf-8?B?Wk1Hc3dBOEc1dmpGK2tYNndCZFB0VXFta2YwUUNabHY0Q044bW5aRktJMlBG?=
 =?utf-8?B?dVJqaXhTMmRydHBySFhrb2REVXhYc3RvaGIzN0llREgyZmM0SVNwVHZidmtB?=
 =?utf-8?B?YWkwa2NkaTF2WlN0U2k4MExDRUpWSHora1J6cDBzMnNSMlJWUFdNNUQwdi8v?=
 =?utf-8?B?TzdtYll3c1hJenVuRERlT0VKRFE1cDc1eVdSSHovbll6NEFpYXZmM0pRblRo?=
 =?utf-8?B?cFlQVUxLdmRhSnNKTUthQzRodjFnZHl2RnFidXBkcjROSzJqSHRkL0QxKzhi?=
 =?utf-8?B?a1VoYW5VUjJNblJFL0w0anVxMXhZMVhQek56d0dUMEFoNGEvRXVjdDZZZGl6?=
 =?utf-8?B?MVduVXVEVjlPV1lycEFLTHJjVXQwMEJFcWx3aTdGU0lhNENPZDViQmYzbU1o?=
 =?utf-8?B?RWVJN0lPdmZGVVNpTDdDRzV2d01DRUQvb3hhT09KaWZ3bEcyYjQwdTlYWEQ4?=
 =?utf-8?B?bHUzdzBHS3g5OVVYWDluT3VlRkRSckthU0FaLzlVMVYvbW55QWxRT2lDak1W?=
 =?utf-8?B?M0VxUTJPWlZhUWJzdTlQcXJybVpBNjg1cytjTExET3pTOXBzR3FSZHM1dU9Q?=
 =?utf-8?B?WnptNUhXWmFtS0FKYzc5WityMzB2OTRLTUFOenZxcG9JM0Zsd05BbTZ5TFpZ?=
 =?utf-8?B?UTVFSmllUG9wbitUT1c1VmU3cHZTOFVNRVN2b0NoMDBmdEkvdXN6ZU1iWU5w?=
 =?utf-8?B?NDBGVXFFbi8yOGFCRENzMS8xeEZSc0E5K2ZvU3VFdUc4S3RxZzNOK1ArODMr?=
 =?utf-8?B?ZWFjT1EwVGNMbTlIWTJ5RzV6aUlNdndBSzVBSXlxaksvV09mQnpnM0lyU28r?=
 =?utf-8?B?V0NuWlRQdmVtdXg0YkNlTVJQbUg0S1lJLzdEeFpseXRLbnVQQVd0SlpBOHN1?=
 =?utf-8?B?ZkswMzlXZmEwOHVXQlRUaUVEUlUrWGxuQ0VSYjVJY1RvTEdXZytXVWQ0R2Nj?=
 =?utf-8?B?b1NPdnV2S0RoUE1nK2pjcGtjN2dDRWttVTBiOU80akhhNUYyR1JtYmtTSmRQ?=
 =?utf-8?B?OHZ0ZUpEZ2FWVmdZZE1EVHF5ejM4WG5xZ1Z1aGg5cUYyakg0NzFhMWVjdHhY?=
 =?utf-8?B?TzdmNlJDRlhvM2lVTEIvK1VWWVpacnF0K1doQ0hScDhBa1E5ZjB2K3g3d0JT?=
 =?utf-8?B?MVhVY05BdU1wdlcyRmlsOTI5Tk40WnZySTcxdUs5UWRNUkRCa0RLN3huSml1?=
 =?utf-8?B?WjI4RjUxQjduWXQwNW92RHJva015TTFwUUluOEwyK2ZNeCttME9VRlZVckZv?=
 =?utf-8?B?YVZTMk53dmpLdlFnZzFaRFd4TmJzcVlBOFlQLzgyQml5WWRvTGxmUzJ1UWhG?=
 =?utf-8?B?OUF4VitRM0lrMWZkZXFQYkJxeHpQYWFUZk55Ym9iZThGVW1uekF4R2FPL05y?=
 =?utf-8?B?cWxUWElHalFDTjRWMlVRWmN0dnZPYVJWaXZ3QnZGWEFRRVZwanU3K3VVOEtJ?=
 =?utf-8?Q?Mfbj2HInbZ4h8kQAWI3KbB/xZ?=
Content-ID: <07FC885334EE2C4FBCE5BC2B423FE1D2@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8561.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b72f5a-8001-483f-d376-08dcb5f67bd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 09:02:22.3239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EU0IvNRO6ZvVw89mKhTdgRvKZPsdmjTtRDvW2CZTVfujrR1kBosdUMAUj35/rekd13aPOFvuKcyCZarNQOtcSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10002
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_020241_584187_EF9024D9 
X-CRM114-Status: GOOD (  22.81  )
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

DQpPbiAyMDI0LzA3LzE5IDE3OjAwLCBIQUdJTyBLQVpVSElUTyjokKnlsL4g5LiA5LuBKSB3cm90
ZToNCj4gSGkgSmlyaSwNCj4NCj4gc29ycnkgZm9yIHRoZSBsb25nIGRlbGF5Lg0KPg0KPiBPbiAy
MDI0LzA2LzE5IDIxOjA0LCBKaXJpIEJvaGFjIHdyb3RlOg0KPj4gbWFrZWR1bXBmaWxlOiBtYWtl
IHJlc2VydmVfZGlza3NwYWNlIGRvIG5vdGhpbmcgZm9yIGZsYXR0ZW5lZCBmb3JtYXQNCj4+DQo+
PiByZXNlcnZlX2Rpc2tzcGFjZSgpIGlzIGNhbGxlZCBieSB3cml0ZV9lbGZfaGVhZGVyKCkgdG8g
bWFrZSBzdXJlIHRoZXJlIGlzDQo+PiBhbHdheXMgc3BhY2UgdG8gd3JpdGUgdGhlIHByb2dyYW0g
aGVhZGVyLCBldmVuIGlmIHdyaXRpbmcgb3RoZXIgZGF0YSBmYWlscw0KPj4gYmVjYXVzZSBvZiBF
Tk9TUEMuDQo+Pg0KPj4gVGhpcyBpcyBoYXJtZnVsIHdoZW4gd3JpdGluZyB0aGUgZmxhdHRlbmVk
IGZvcm1hdCB0byBTVERPVVQgZm9yIHR3byByZWFzb25zOg0KPj4NCj4+IEZpcnN0LCBpdCBhY3R1
YWxseSB3YXN0ZXMgZGlzayBzcGFjZSwgYmVjYXVzZSBmaXJzdCB0aGUgYmxvY2sgb2YgemVyb2Vz
IGlzIHNlbnQNCj4+IHRvIFNURE9VVCBieSByZXNlcnZlX2Rpc2tzcGFjZSgpIGFuZCB0aGVuIHRo
ZSBhY3R1YWwgcHJvZ3JhbSBoZWFkZXIgaXMgc2VudCwNCj4+IG1lYW50IHRvIG92ZXJ3cml0ZSB0
aGUgemVyb2VzIHdoZW4gdGhlIGZsYXR0ZW5lZCBmb3JtYXQgaXMgcmVhcnJhbmdlZC4NCj4+DQo+
PiBTZWNvbmQsIHRoZSBhbGdvcml0aG0gdXNlZCB0byByZWFkIGZsYXR0ZW5lZCBmb3JtYXQgZGly
ZWN0bHkgYnkgdGhlIGNyYXNoDQo+PiBwcm9ncmFtIGRvZXMgbm90IGNvcGUgd2l0aCB0aGUgZmxh
dHRlbmVkIGZpbGUgY29udGFpbmluZyB0d28gY2h1bmtzIG1lYW50IGZvcg0KPj4gdGhlIHNhbWUg
b2Zmc2V0LiBJdCB1c2VzIGEgYmluYXJ5IHNlYXJjaCBvbiBhIHNvcnRlZCBhcnJheSBvZiBmbGF0
X2RhdGEgaGVhZGVycw0KPj4gdG8gZmluZCB0aGUgZGF0YSBpbiB0aGUgZmxhdCBmaWxlLiBJdCBt
YXkgcmV0dXJuIHRoZSB6ZXJvZWQgY2h1bmsgd3JpdHRlbiBieQ0KPj4gcmVzZXJ2ZV9kaXNrc3Bh
Y2UoKSBuZWFyIHRoZSBiZWdpbm5pbmcgb2YgdGhlIGZpbGUgaW5zdGVhZCBvZiB0aGUgYWN0dWFs
IEVMRg0KPj4gaGVhZGVyIGxvY2F0ZWQgbmVhciB0aGUgZW5kIG9mIHRoZSBmbGF0dGVuZWQgZmls
ZS4NCj4gVGhhbmsgeW91IGZvciB0aGUgcGF0Y2gsIEkgZm91bmQgYSB2bWNvcmUgdGhhdCByZXBy
b2R1Y2VkIHRoZSBpc3N1ZToNCj4NCj4gJCBtYWtlZHVtcGZpbGUgLUZFZCAzMSB2bWNvcmUgPiBk
dW1wLkZFZDMxDQo+ICQgY3Jhc2ggdm1saW51eCBkdW1wLkZFZDMxDQo+IC4uLg0KPiByZWFsbG9j
OiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5DQo+IGNhbm5vdCByZWFsbG9jIHJlc2l6ZWQgRUxG
IGhlYWRlciBidWZmZXINCj4gJA0KPg0KPiBhbmQgdGhlIHBhdGNoIGZpeGVkIHRoaXMsIHNvDQo+
DQo+IEFja2VkLWJ5OiBLYXp1aGl0byBIYWdpbyA8ay1oYWdpby1hYkBuZWMuY29tPg0KPg0KPiAo
TWFzYSB3aWxsIGFwcGx5IHRoZSBwYXRjaCwgcGxlYXNlIHdhaXQgZm9yIGEgd2hpbGUuKQ0KPg0K
PiBUaGFua3MsDQo+IEthenUNCj4NCj4NCj4+IEZpeGVzOiBlMzkyMTZmY2U5ZjczNzU5NTA5ZWMx
NThlMzljMjg5ZTZjMjExMTI1ICgiTWFrZSB0aGUgaW5jb21wbGV0ZSBkdW1wZmlsZSBnZW5lcmF0
ZWQgYnkgRU5PU1BDIGVycm9yIGFuYWx5emFibGUuIikNCj4+IFNpZ25lZC1vZmYtYnk6IEppcmkg
Qm9oYWMgPGpib2hhY0BzdXNlLmN6Pg0KPj4NCj4+IC0tLQ0KPj4gICAgbWFrZWR1bXBmaWxlLmMg
fCAzICsrKw0KPj4gICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9tYWtlZHVtcGZpbGUuYyBiL21ha2VkdW1wZmlsZS5jDQo+PiBpbmRleCBjYWRj
NTk2Li45NjI0YzNmIDEwMDY0NA0KPj4gLS0tIGEvbWFrZWR1bXBmaWxlLmMNCj4+ICsrKyBiL21h
a2VkdW1wZmlsZS5jDQo+PiBAQCAtNTIwNiw2ICs1MjA2LDkgQEAgcmVzZXJ2ZV9kaXNrc3BhY2Uo
aW50IGZkLCBvZmZfdCBzdGFydF9vZmZzZXQsIG9mZl90IGVuZF9vZmZzZXQsIGNoYXIgKmZpbGVf
bmFtZSkNCj4+ICAgIA0KPj4gICAgCWludCByZXQgPSBGQUxTRTsNCj4+ICAgIA0KPj4gKwlpZiAo
aW5mby0+ZmxhZ19mbGF0dGVuKQ0KPj4gKwkJcmV0dXJuIFRSVUU7DQo+PiArDQo+PiAgICAJYXNz
ZXJ0KHN0YXJ0X29mZnNldCA8IGVuZF9vZmZzZXQpOw0KPj4gICAgCWJ1Zl9zaXplID0gZW5kX29m
ZnNldCAtIHN0YXJ0X29mZnNldDsNCj4+ICAgIA0KVGhhbmsgeW91LCBKaXJpLCBmb3IgdGhlIHBh
dGNoLiBTb3JyeSBmb3IgdGhlIGxhdGUgYXBwbHkgdGhlIHBhdGNoLg0KDQpodHRwczovL2dpdGh1
Yi5jb20vbWFrZWR1bXBmaWxlL21ha2VkdW1wZmlsZS9jb21taXQvYzc2MzAxMjc3NTUyYjk1YjYx
M2ZmZTlkNWEyMTFkMDFkZjczYmQ3OQ0KDQpUaGFua3MsDQpNYXNhCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0Bs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8va2V4ZWMK

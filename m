Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA60C4345F
	for <kexec@archiver.kernel.org>; Tue, 23 Apr 2024 02:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=BTdaYwp1qa9XutPXpFTIZTaGmObqfJIIcwTzJtMfzCI=; b=H1ml+6Qv9AE4wU
	RHwZo/JQ12sh+wj/ubHCnNGsd+M+ZlKw9DV8R3OYjJxmnuP46rR0IcX8ZBWzqJZz28xG3PsVeBlTX
	dzWBi/k0FW3Wh68I8XHcThmDY6tnUJWpTRjnS5+Ma0zCqW0FuiHYT4nThYDas+SZ8f+q02Di1C4gx
	8pUPtuDQwQ2amgEdaoZ2Mm4Tyg/1WdbbXqNYoa6Dg1SjFIdzR0NIlq9y5wXb++fPPnRoMWzjjvLoO
	gD1Asbwj3CD1PpoNr88VEBf8fEJqaoscBBfsxPllzoVgeYMKS5T+G8/ac65IyRULDPBFDOIanOsWX
	jrCgb6P3XVm7xBzfMZZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rz5qa-0000000FkTb-3IgI;
	Tue, 23 Apr 2024 02:25:28 +0000
Received: from mail-tycjpn01on20601.outbound.protection.outlook.com ([2a01:111:f403:2019::601] helo=JPN01-TYC-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rz5qW-0000000FkPf-33FB
	for kexec@lists.infradead.org;
	Tue, 23 Apr 2024 02:25:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5a6KuUEUn4p5pEYRKQzvbgagdCD1UZrjj5AVtU6vla0kv69DN8D/3pUS1T2hdWfJ4CM6TCnBwVWPqYTnAyNzkBNr5YxoMbHnza/JXZmshWfp6xmdpmhqg1HanjeMxjhdLpLqEOE8ZqHTPlO2W8EJQiJ4PFXGnaB7XOAJDFChUyv45uSUsVZEm9Yr9VHecKFUUOKttXSC/miYiU5MD+IYVwVpFcVJhmnFSUchCJTab8r0k5kGIZ/YjUYapcSP8E7oTrzm4oxlXONvEviNZdv+kEzR3022I8pKKQJ7MtEO45AdU+VOPsnUa8qBLMS7qw4SCBTowHk/QoDMzta31GIsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGB9Z/0oELNghlJNIrsv0k4B9T0pbF9R+I6AWxGjd0c=;
 b=YD+4XkJdBavALG8DBxRA9mQAaZZqEhdYH7sd2DSTHKD7oAt1ycHZUVmP31ZaNSaxgAc+oISdilJM+jhcygyqF4ljQ4pj7Q/igD3R3jPk7brQRN+d+tgV+/DH/QbFmhZKzPR3rLnJ6sH6LE+m+5cNsG/MwKKyhe5dWbmVPm1TAmN9yv6aom80Hn9GK125RMdvCcTIVe7UebnJnMFUwR3NSgdhGAlhKZybKYsQ9pgnB8aVIN4OQZdehMpr0YBApZ4RlyOFVUWwRSH4IXnWX1qsutXQT/vBOCaCY6v76e8UFv6J3+B9USdTuOE97GTOieQG2Wxoqtyklbgtwy0vtQbqJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGB9Z/0oELNghlJNIrsv0k4B9T0pbF9R+I6AWxGjd0c=;
 b=UQwSLxElgFaKWVJrTdmdF+wGgPfn5cQ3x5elHmZc7rEsEAtRkcfIqAMwozMadl5YERtzDwRARLmCtzzOqzYdXcKs/R9+O23kKlQx1RMuGNXDE2J6djjaaAG2nr7Hp6l649NLJSR5+Dz9g0zzAF1H4a92zZGEnc3zgc9b4B9Ao5Rld8iKgRm9NGZyGX6osOjTuFSD7WgsH4OmJjKgDMjwktHRB9T5qVtY43zfyg4rZvTQr1QajYEjhJHwZLNBxshk2H5PtjP6R/0Wz8U6P0V7OQsNRAFdiM1D67QpL8HvGRK8oAFPW4F/M/UuHjPeHpyW8qzZg8Pie6yAzqQ+uWy22A==
Received: from TYCPR01MB10963.jpnprd01.prod.outlook.com
 (2603:1096:400:3a5::14) by OS7PR01MB11485.jpnprd01.prod.outlook.com
 (2603:1096:604:240::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 02:25:04 +0000
Received: from TYCPR01MB10963.jpnprd01.prod.outlook.com
 ([fe80::7245:8970:3fcf:1f6b]) by TYCPR01MB10963.jpnprd01.prod.outlook.com
 ([fe80::7245:8970:3fcf:1f6b%6]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 02:25:04 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
	<k-hagio-ab@nec.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: [PATCH makedumpfile] Update maintainers
Thread-Topic: [PATCH makedumpfile] Update maintainers
Thread-Index: AQHalSVzfIJtankMG0e90JXAreNRQg==
Date: Tue, 23 Apr 2024 02:25:04 +0000
Message-ID: <1713839101-14791-1-git-send-email-k-hagio-ab@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.8.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10963:EE_|OS7PR01MB11485:EE_
x-ms-office365-filtering-correlation-id: ba0b8b08-6421-4388-2a41-08dc633c95cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?iso-2022-jp?B?RUhhcDRCVkNUQ2loRHllclZ0bHV0eDJlTTJtb2s0T2M0WjRoUFR1dHJ6?=
 =?iso-2022-jp?B?by9zRkZiamdlQk5sMnJJdU9nTzB5M05lNTdaUE5jSzhqVXhaTkVvVzBh?=
 =?iso-2022-jp?B?cy9KZ0ovM2M4cmVGOXhZSkU0UEJnSGVXVEJPVWdPdi9aY1JYSDkvVGhq?=
 =?iso-2022-jp?B?alFTeDE5TUUrakJFZGhiYklNbnBaZERHMGtPQ0drNzNGVzRycndRMWxL?=
 =?iso-2022-jp?B?bVhzanZ5YlF6VGtSWTEvOVEzcmRVVzd6TEdUaG5SYnZ0N2l4YkFhdTNR?=
 =?iso-2022-jp?B?a1dYMjJ2eG15Q1dwNkYyZHBHa000NTRaK2Q0UXZnSkt4YU9Zd1JtSjZo?=
 =?iso-2022-jp?B?VDFRSkE5K2VaUjVBZk1IYlFhU3gzS1J0T2plb3JoYlZNYk5ENktSV3ds?=
 =?iso-2022-jp?B?RTNTMFhMd1NGOUYvM0NFaFRYRGpTck5rS1EvZGNXWFlvcnpvcVhJUm5o?=
 =?iso-2022-jp?B?cTJjNTVTb3MyMU5zTjVyZktrY3g1REg1Vk5ISElSaXE2dUsvejZ2SUZw?=
 =?iso-2022-jp?B?akY3cExaL1cyR014b2poRTJiMVVMRFBRclhFek5KRmJ2Y05mUjBSdTBI?=
 =?iso-2022-jp?B?S3pYazBYMmJmSkhSQU5pcHRjZ2piR3dTZFdQYVlUazJ3MzFRcTNVaFQ1?=
 =?iso-2022-jp?B?Z1JNZlg2T1dKeTRoQmhsVE41bUM4V1h6a2I4dCs3aE9pMkJEY0lwV0gw?=
 =?iso-2022-jp?B?Q3Q3S1V6bFJnMUdXbXQ3bFlZSVRXTkRVbHl4WDJ1SEV2SGhRdkY2bEJL?=
 =?iso-2022-jp?B?cWVxbkVSaktIMzFQb0JTdWRtRU5xb2c5dkdvYVpaOEROclhWYUhENEpH?=
 =?iso-2022-jp?B?RjVwelM4NHJWNWVpM1pvcjBQUHQxbm1pY2t3Z2xGclpsUEY3cWRadFpK?=
 =?iso-2022-jp?B?ZDJHRWNkb0FuK1BseFEyTkNIaThsODJWRldEWkd0djRHbFVsZmd6Ykwx?=
 =?iso-2022-jp?B?ZnVWMUVITSs4KzlnTVg2eDF2ZGFta3RDZ2toNWdxUGpZR3NrSkc5Rnc2?=
 =?iso-2022-jp?B?aTFiRXRpQWFhM1lMOFJobTFhRmNvcmJBbXhkVHV6UWF6V0cxNnBDdXZi?=
 =?iso-2022-jp?B?RmZ0SlI3Q3lOWFRTeW1BVjc4TlRGMDA4dmZiMHBsU2lVYVJrcXRzT2ZP?=
 =?iso-2022-jp?B?SEM3bzIwM3AvY0ZDS1Q3Slk4WHJuZG1GUWgwTWZERlBhdTgyT2xPUFZ2?=
 =?iso-2022-jp?B?TEZ6TFArRjBGKzRmcjQrTUpCM2ZEODhoTnJSR1dQa3c0YlpMZ0xEQzM4?=
 =?iso-2022-jp?B?MnF6cUhTMGhxL0YyL3FkU0pISUY2MGhDV1BiUFA1R2FKeFpmYm9vMXZW?=
 =?iso-2022-jp?B?c29XcFNRTm9WUzJud1huSnpUUC9ydHJadnpBbkxzQUFxdGtRNC9QdjNH?=
 =?iso-2022-jp?B?RE95YWE1VXVUN2pPN21hTmNmN05oZEdab3M1VFQ4ZFc2WURvVW5vUmZE?=
 =?iso-2022-jp?B?eWdod1BmQlVaeHA3V25SdXBXMGNhSzJlMGxOU2lOV05UdDJnMmR2QkpQ?=
 =?iso-2022-jp?B?c1k5NHRyaHRHNGUxRVlMQjJhM3VJN2xoWnRodytjUnZxUUxxVlhZeDBv?=
 =?iso-2022-jp?B?UmZFdlk5T2FwQ1FqQ3A0R3NMNXhjbU83MTB2QitTNDBLM3FkOHhkWU84?=
 =?iso-2022-jp?B?VXU2NkUrQWRRUEpmT0dSa1EyUVBlbHZrVUhMNzF1OERoQWFReDUydlRC?=
 =?iso-2022-jp?B?czA2UXp6bjg4dE1ESTVRb1BBTGN2YlpVWVgyNk05L1ZIdnZZTStaaEhw?=
 =?iso-2022-jp?B?TjlMam1zSzFLcWJsbVhHcG9aSENRckdKQzRlcjl2YVBqdW5zelRVMHZs?=
 =?iso-2022-jp?B?TlFMV3czbzFvZkdoMHdCSSt1dCtYbVZEZ2NtU1ExZUlPRnkzaW5OTUVY?=
 =?iso-2022-jp?B?dEFFYWExeHgzcTMzbEd3blpFNFRmV24wcmZxVGVocXhvNUk0MXljNWpz?=
 =?iso-2022-jp?B?RVhKUWxuY00xNEdTV2ltWTk4WHk0dz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10963.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?QmxpeVdpM0NXQVRHZUNib1JVamVvNFh1SVY1SjdzY0tIL2hxd2ZzM0Nn?=
 =?iso-2022-jp?B?T3N0VTRQZmRlVGtqR1hOdUhQOURtK01yU2lEL090S05IVmVuK0Fqd0lX?=
 =?iso-2022-jp?B?TENOVlZlTXMxM3hVWWtONUhEcFMxc1RFaXdYekVWaFZuRVdtVDhvZFdL?=
 =?iso-2022-jp?B?RGtVeG5MdklINmx0amtKRDJqbjhob2FXZ2llb2JGN3VnNmdBbXpCRnN6?=
 =?iso-2022-jp?B?TzNMOTM1bVY2QVUzYUU5WjlLbWdBZWFiTXNRUlVIUVZ5ZS9RMzN0d1Zy?=
 =?iso-2022-jp?B?S1VsTHMyYnYzcU1vUENMTHByWlRoNVkzSnpMbENSM0lOSjhKWkpYeHZV?=
 =?iso-2022-jp?B?bjdDM0xXNHJFbjNPTXdzTVc1dWJEbHdXakdLL2JLdlRyd3RMeVV3aTQw?=
 =?iso-2022-jp?B?ZkJnT1c4bE1QVUgyeWJhMGhoaXlPL2ZNUkU3cC9qcE41N2o2aHhvazVV?=
 =?iso-2022-jp?B?M1FBUEcxV210T2FPVFBOWTdKZzFnU2dVU2t0a0Rqc3ZQZkhBUyt6WHlr?=
 =?iso-2022-jp?B?MXA4dW9mWFpvWlRHejNYSUNYZmVBdUxyOVhTSkRQY09UMS93akFtK3pD?=
 =?iso-2022-jp?B?MXV1cEVndGlqYjliWWVlakcrem5NQ2NSOUpmUE5aOFZlTG5VN2NuNUJL?=
 =?iso-2022-jp?B?cEZMSFd0RXdKYmVXZWY1cGgyTDU4QWFlL2hPOHpEMkVYSUJ5WmJvaSs2?=
 =?iso-2022-jp?B?a29ESkhHa1dRaWdmdFAvOWMrZ3dzUjJKZmQvL08xaW45NlVSUC9oVnp5?=
 =?iso-2022-jp?B?bmpvd0crZEJXMFBER0Y2Q0NUT3VuNUJleUVTeExhazRieFdiazd5NWkr?=
 =?iso-2022-jp?B?aG5JVFRGSWNKR28rTUUwaTN1OVZ0cllJUjYyVnV5aXQvNHdzdGx6WllM?=
 =?iso-2022-jp?B?SHlRUktSYlJ6dk1iTVk0WFNCNnJiemhsa2dKdGhzcnBIYVM3ZWFLWms1?=
 =?iso-2022-jp?B?c2V2OVJ6Y3VwMDI1TTNiWlA1dXN4czJrMDZWL1Q1cnNzV3NiQmtRN2kx?=
 =?iso-2022-jp?B?c0tGQWpVOUxkOTRqcmFDWXRxRlNTWHZuaEU4LzVIWXhiSmpCV0tUUVhs?=
 =?iso-2022-jp?B?Nm9VTjhneGZJQzFGMnkvYUYxTjdzZXd1MEkzbWVuZHNPNVVNSnNKY2pP?=
 =?iso-2022-jp?B?dGdiL0tJOUV0V25weTBQdDk2VUF6c2dwRXFJUTJGQ284czV0ZFFFT0sy?=
 =?iso-2022-jp?B?QlZtZzJSSnk1NVJyRWtQeU85cFk5Q0lRaFhDSzJ1VCtmZG5CbnNyQjg0?=
 =?iso-2022-jp?B?RWkraXBKNzZJNjd5ZDFubXhqdkdjcms2NVpFRmRnWkZjRjlOSFBBSnBm?=
 =?iso-2022-jp?B?SFZBcEtjVTJpWnVtdnFrN3lCNStTUWtDaTBqS3plcHNjMHZMVE1JaXZ4?=
 =?iso-2022-jp?B?RklsNE83MXUrcExhS1piQ0tGSDhsUTYwZ2UvdEREVmM1ZlVqV0gxTHlP?=
 =?iso-2022-jp?B?OWx4bExFU3hQMEVLblpvZE1kV3dOcnJ1VS9aSmtTK215NjJSczlWZyth?=
 =?iso-2022-jp?B?T1d2ZGJ3M05rVElxV1pIajdyaDdxdGYvd2JGdXMreTBHbGpuUHlNbm45?=
 =?iso-2022-jp?B?Q1REYjNlV2NXMUNLR21yZmZyZmg4azN4a0pzUjdmdTlQbWppSnppdmRE?=
 =?iso-2022-jp?B?c0o5VzBDb0d6M290SUIveDV0QTVtalBwZzB2Z09qanBqeWQwNjJ6UU5K?=
 =?iso-2022-jp?B?VW40dHhjOWJ1QmtUaEZhOFlGak1OaWRFYTBNRGZBUU52Q2VRaGl5anpI?=
 =?iso-2022-jp?B?QkN0T0hpK0I3bDdGV204MG5DV1VDQm94OWVYUVR2b3VvYXZ5NU1NQW9H?=
 =?iso-2022-jp?B?V25GUC9CZUgxc3lCcHlGbU5VMUx4OGhXck5qSDFYOWNxaXBpdEJ0SVVF?=
 =?iso-2022-jp?B?c2NRa09taDVpZ3NxcVZyQ2FaVjV4akQyOE4ybVM3ZzgwZCtSYk5Wc0lG?=
 =?iso-2022-jp?B?N1lrQ2VkNzZVd0xRdTFYanpNUkZzazZQSkNQY0w2MGtSV2xCUm4rbEhW?=
 =?iso-2022-jp?B?VzI0STMvM0RndWQ1bHBjai81V3ZUcmpteUVnM1VjU2VCcDJYZ2ZYa1U4?=
 =?iso-2022-jp?B?K1dmS2YxZ05TUXduWlYvQUExUUp1UXpKU3N2YnA0ZXRBaU9KYmRFSlBa?=
 =?iso-2022-jp?B?VDI1dGZXM2VYRFdnd1dlUm1MOGhMWkwrNnlIVGxxUlpNT0t1azQ1QkVT?=
 =?iso-2022-jp?B?dE1RUmlrQTZkMkhZb0haQ0VaMVFWTFZzWm1Ic1JJRjZJNW1ockhTSVBZ?=
 =?iso-2022-jp?B?Qmk2cGZ5TnNqODlJWjluam1GWGtsQklQak0wUk1WOEJ4QlpMVC9xZUlq?=
 =?iso-2022-jp?B?UDIvLw==?=
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10963.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0b8b08-6421-4388-2a41-08dc633c95cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 02:25:04.2119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WNMxPpTUSTjY4CtRTyzr7x8O3WmNUTrNrtojpQmLzTJyHy+f4MIZSEIPFgmvgtfm6itpZ2jKru3f3GLzM6ED0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11485
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240422_192525_054283_DAF5E253 
X-CRM114-Status: UNSURE (   6.18  )
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

Add Masamitsu Yamazaki (NEC) as co-maintainer.

Signed-off-by: Kazuhito Hagio <k-hagio-ab@nec.com>
---
 README | 1 +
 1 file changed, 1 insertion(+)

diff --git a/README b/README
index b9d8dc3dcff4..6f22af725114 100644
--- a/README
+++ b/README
@@ -266,6 +266,7 @@
 
 * BUG REPORT
   If finding some bugs, please send the information to the following:
+  Masamitsu Yamazaki <yamazaki-msmt@nec.com>
   Kazuhito Hagio <k-hagio-ab@nec.com>
   kexec-ml <kexec@lists.infradead.org>
 
-- 
2.31.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

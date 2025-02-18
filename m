Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C5BC021AA
	for <kexec@archiver.kernel.org>; Tue, 18 Feb 2025 12:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SaWszirhVuUvfv4ey9q/u6Zo3yx8iNgBK/aHqZ8xFzY=; b=wqeQuhkeAN1kTJcG/9HkepxFfQ
	SwOB3JT2KJ5wuH/zqu8FIWpV9N/ssn3Us6k4eCbQGoPNFcNLkzBjREPxM1pY9qRzz27BZSsF95D+I
	KIiiatEytLGDnKDltBfYe2bnQ5OWN95p4hm1A34qOQgmBSTW711ULfVweXDimBC1wTeyp2SDWj4+m
	XdEYeDAwlHH3RQZ0Ow9eXjjlBZs8g7rx90wC10bx1fLnpwAdlnHNE37uRRuUMjuu9satdYFXjSRCz
	iv0dg1qXierNeuSJEZ8h511LrObAoVrYjL4RCcPlVp1CQWGDlw0sRXgIEO3h3s57VM4CFKfUavXx2
	rR9KWhoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkMvX-00000008Bhe-28cY;
	Tue, 18 Feb 2025 12:42:15 +0000
Received: from mail-japaneastazlp170110002.outbound.protection.outlook.com ([2a01:111:f403:c405::2] helo=TYVP286CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkMvV-00000008BgU-14Cf
	for kexec@lists.infradead.org;
	Tue, 18 Feb 2025 12:42:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRVLpAGtBBfZqq4i8WYG3hk7IxWYx+8Wxg/oi3xfQyEDh9DLO6mPTEBPGuhJgfTnyzuQXzHfg8utOovYc2USEsZ6nqeX83qvDv1hSIuqhAfY/Ho83eb9N7vfugUuYe76YtlUwRicd1dcb0xcIQtBh1a2/rhH2jHLqF1Qjyxjgrw3Rr4NA/22uhgqybILjYOICr5uZ6llgw50K8P+LIecomwmiBQCtNY8z28U6lNlYJndfaY4l1L+gG9WV9khhhSUBSM2AdPpT8mnKBr7fV/wa3X0/A5uitGNNSNIxBQMfiwZ0daDntUnSrMdJuxLbcufiFYjtNbD73ziFYnFhpjAxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SaWszirhVuUvfv4ey9q/u6Zo3yx8iNgBK/aHqZ8xFzY=;
 b=gnRyLv+NYsniZVRy2cRAXAMR3pkqIVqovh+gsWJoMfpH24SMAXq+cMvA4necyeiBT31LycpEVYNCArSZkEduXNWGkQ5NVQ7/UFNXrdg5F82cdgwkdite4AIw/Oe9cuK7sB7djrIdClNhvB6Om6g0CfTHfVBJqkfGdRdEugv2cp15+qiut1ShGmXwII+GPIeHocDnPa3wlI6rc1xsRrmbSbKWqmEm20wmwbdlWuFBZCvAyPKQM7tp4p2Q2y9hjiIGSajt4NCLLN68KEtm5uiHIIXGH4IZmVmGOnP573n1PCfSan2Y5mUeqTmm0hsvOJVO2hJL0S5OCdD0fx7X+uvlRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SaWszirhVuUvfv4ey9q/u6Zo3yx8iNgBK/aHqZ8xFzY=;
 b=qFX3ILD7+q1x3QV46HTbE7P7lE9XSrKyKNwxnzNQ+MRpUD96aub1E6+GVsVllJmchIpKGkDZCgF5qZfKAMccOg6cBx8msvFOveYRw+dKOVRlxPM/dsItC+r+7wWer5MBmHIMrxeJy1W58k/tIC7inX3Vm3ZOBJr0SoZQM5eOJTpto6wj0+0usjSNIykqi/x1IKmBO8i5qQKjv9JDa2Ob18uWKs0z7uykdwS0RfOI0TwanmCaV+C5YzdeiAQedKC2laLMCjefUsBGfpebYFH6BwcMDJIGKADtmooI+Jucj6bJWtLu59JtelMtvhfgxEfmtiSwATuzqLA++cE8JwqluA==
Received: from TY3PR01MB11475.jpnprd01.prod.outlook.com
 (2603:1096:400:40d::13) by OSRPR01MB11616.jpnprd01.prod.outlook.com
 (2603:1096:604:231::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 12:42:02 +0000
Received: from TY3PR01MB11475.jpnprd01.prod.outlook.com
 ([fe80::dc98:76b8:3a3:fcec]) by TY3PR01MB11475.jpnprd01.prod.outlook.com
 ([fe80::dc98:76b8:3a3:fcec%3]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 12:42:02 +0000
From: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>
To: Seiji Nishikawa <snishika@redhat.com>,
	=?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= <k-hagio-ab@nec.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH] Improve message readability and fix typos
Thread-Topic: [PATCH] Improve message readability and fix typos
Thread-Index: AQHbYwv5W7Y1ekALv0OUCVBtEuyGl7NNPuQA
Date: Tue, 18 Feb 2025 12:42:02 +0000
Message-ID: <b46eebc8-2873-4433-a224-5d1a56479107@nec.com>
References: <20250110030047.73538-1-snishika@redhat.com>
 <20250110030047.73538-2-snishika@redhat.com>
In-Reply-To: <20250110030047.73538-2-snishika@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11475:EE_|OSRPR01MB11616:EE_
x-ms-office365-filtering-correlation-id: 448d8758-2f5b-486c-3dfa-08dd5019a4f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Q2Vjc0h1NXNXaWtGNk4rWUFpd0szUkU5MG9zanZ0bmRVTXVGZWYvWDR0S24w?=
 =?utf-8?B?Umh5NmtZRm83VjhFRmVvdGFWejRBZmxvWmlaWmwwR1RSUWQxdVVIWU5YNXdY?=
 =?utf-8?B?SmliUjdUaDNhU1VxYmZkMHFmSWRGeDNyQ051UWNIbUd0aVJKb0NORloreWJH?=
 =?utf-8?B?cmNEUC96LzIzdzlUZnBzQnFzM1RJOHA4QkxidGJMcEkrclNFRWVPWTY3Z2Ro?=
 =?utf-8?B?Z0VWaHlCYWJhWk8wT3FmYlVqM0lOcEpIMHlGVFRHWlpqdS9obHdFbHlCVHRv?=
 =?utf-8?B?M0xIUXFGU1YxVllvK2d1c2ZieFRwMXFXT2cxTXFTNEpwbmNkU0d5SU1HTW5E?=
 =?utf-8?B?b3pRbFFSV1AwVlRINmFVZzlHNzhINDRnNjJGQzJpNGpERGQyZHBxWmFlUVhs?=
 =?utf-8?B?aVF3bjVSdjhQU2phOXhjaW9HVElxU0FET2RnYlpDNS9jZFdVMi82ZEtyUU5M?=
 =?utf-8?B?WU9udjl6dFc2YnZMN3VQczk1aERmUCt6clVDZ044c2dqdFlmVElIbE9DVmVz?=
 =?utf-8?B?VVJPSEh1VjcwdWthekZuUElGMWw2TFdvQWQ2QjhSZkNhbEsrK1lxWS8wN1d3?=
 =?utf-8?B?aUFPWWdWcTRkZVNvMDBmU0l3eTFQMW9jM0NiRlIyN241SWt3U1J5ZmpSSS9r?=
 =?utf-8?B?Q3ArV2I5UWJ1M0ZJNERIUkhLV29QSjZNRFRwenpTamVmeUpqZHdqSm82R1BM?=
 =?utf-8?B?WHc5YVoxTmJsNUtjaVd6RjdIQjBzWXBYZXlYT3NmU25CcmZ2anlYVkpISmNi?=
 =?utf-8?B?NUNVNXQ5cXRiUU8zejM0NUNaZFJMMk5BYTR6RWJwZitjRVgzcjR0VnlzMFFC?=
 =?utf-8?B?ZFE1eWFTVHR4bVVaL2k5TEVIMzRCZjNlNnVzeUx0Vkw4TXFpeHIzZG9VWllB?=
 =?utf-8?B?N0JYNkxUMUlteXRId3dwbWVFUlNDU0swSWFNTUZtNHhibmp4NnlBaVZRMnZk?=
 =?utf-8?B?TTFYNXIvdG1JMk5leTlVbC9UaExHU2NteVhqS1A1N0Y5Vmk3YmJiMXdWOENR?=
 =?utf-8?B?czhjckNHTUk1Q203WWxvdE5xbzFQT1BqZXN2SDNMMkZ1WWRTSXZrOGd1ZllK?=
 =?utf-8?B?cjU5M0lOUWdiTFg0RkVreVdpTkIwK2NmdEs2aVBnTzVXbTRoU0FKNG16ZENn?=
 =?utf-8?B?cnhETjMzM2R5VklJcllWVmRWUHRGclZQOGRHS1BzNE1GRDROcXBSS1pjbEJG?=
 =?utf-8?B?OW03T3hHWUp1WVpmYXJ4WDJGajArOXFyaGZkNEhqR2pmTThEWWJ4YXNrZnN0?=
 =?utf-8?B?dmtNSXBYbHNqSjl5NllnRzRsR0Q3VDVIUDVGUU9QUFhJUjRKTWRCVm9SSVpq?=
 =?utf-8?B?aHRpYzNSU0FLa2Z3MEJSTzZ4OFNEQzMySHlZU05jNTBJRXhCVlZMdVRic0c2?=
 =?utf-8?B?MS9KNG11bTFtZk40VTlESS8yOHBxYUtLZGZmNk9RN081SDRzQ25uR3VXMmdV?=
 =?utf-8?B?WmhQUXU2bzVmSzBlOVBHSUEvOXg5c3h2TFhDNzhQOEt0dTNlczZZc0dPd01L?=
 =?utf-8?B?N3ZjbjF2a0lQMHJHV3ZZZUE1U1NhVUtPaVd2RUVXQ3dsUjNBNWZjazBVWnFr?=
 =?utf-8?B?VnJqc29PS2d4SFRJcXdJWVVmK2Y4VDEwbjdZdnc5QW5OTURsOUQ4QzJIbEVH?=
 =?utf-8?B?WmxpbGpON2NLeXB2c0ZIN0FtWFdSaWs1NlRhRXJ6ZGNuYnp0MEtEZU5Ebnhm?=
 =?utf-8?B?bGsrY2djUTJyMGw3YnZrM2w0Sis4S1E5TkcxRC9DOVE3QnRFS2l6bmVNbmhj?=
 =?utf-8?B?cHIweW1qbXJyYU4zZ1A5WHFtVkJpT290TlVlbXA3bVJ3L2xSNloxSjdjZ2U4?=
 =?utf-8?B?d2pzSW5PZWNLL2sySjFIV0FiUFh0dXp5eWEvVXZHL2RicWV3b1EveVNuNGhi?=
 =?utf-8?B?N1BuVUMyOGZYVURSUzYxYXFJUUkrUTQ2NjcrYUVFYy81NW5WMGJpQTk2RGZI?=
 =?utf-8?Q?FZ6hyp7NZRLp0/rDwso54jqAKNx9PHuv?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11475.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ek5EbXZXdGY5TWpYaVVxNjFSaVd4OXRRbVVFbmowTjBFZ0VORmdMcndpbWVW?=
 =?utf-8?B?WjhvcFd3c2tlUHNqRTRtNWtUSkhVanFLclBkUHVrZytyeWZzYWlrZGx5U3d5?=
 =?utf-8?B?RDQrN1Bpb2Z4TGhhTktoTXB3aGd5eHhSRjRIeVRzZGZNOTQyZ0VoelE3NWlF?=
 =?utf-8?B?ZEFKYmJBZnFWbHNhbFdmN09EdG03ZnlUaWJhY3FxVXpBY0ZFeHlZYWU2NndL?=
 =?utf-8?B?dEh1c0FkaHd1TEMvUmFPSTl1OU9IbFlYd2czbXhsaTlDYUJvQi95NGNXckpL?=
 =?utf-8?B?Ti9rMjdialpxaVYvS09od2JLWHBQWDRPM01wM2VyaXB4Mit2MDRWcFFFVlRu?=
 =?utf-8?B?TUtYUVEvYlc0TVZ1cHlieTNkdEVBbXBucDVhaHM2WkpYb2dhVjh4RElLSmJx?=
 =?utf-8?B?N2JLUEdsUnZzdEpkYVpDekd2WklQNmh6aHpFV2orc3pJY3pYejIrb2o3eVY5?=
 =?utf-8?B?YWFTRW9IamdnUm5qejUyR0R4MCtxNHBnbktDb1ZvM1ZKMUJYcVc5cFdwVzVu?=
 =?utf-8?B?d21ndVFkeTdLOFdSTEpYNmh3SFBEK1puVzlaeXMvU1FzSkNkNUZOa3JLRkFV?=
 =?utf-8?B?VWZ2YkJYUFJnTDRHZGV1UkFXNXl3WlJHdmxWcXlUTkRVanU3VmJhL3ltck0w?=
 =?utf-8?B?S0E2MTlvTEc4MGg3QlhFZCtmNXE3RXBqaE51cFM2SjJMQlJHa1lHKzNPeVNq?=
 =?utf-8?B?aVJpL1Fhb2ZIeURkTFpreEg3NnpESHpqR2RQVkVSR1REWTR6R2JJWmNralRa?=
 =?utf-8?B?RkVoSFFrem5jVEdlMjkzU3dFajhPVkVnK0ZCSmhyd2R2RCtMcUUrNzRld09Q?=
 =?utf-8?B?VmxIQmlSUGNsV2FGbkxwZko0WnFZUjhKR1FwOGJpK0tJUmk5QnRPY0pSUXdN?=
 =?utf-8?B?SklTZUdWTzBBNllubDlCZEdpeEF5ME1KMXVtRVdlcFhuNXhWVHlwVy9ZTEhK?=
 =?utf-8?B?WThBdzcxYzg2ejFUS25OQmVVRU9rVEtnSlZVeHAyMDFwZTQybE1CRnR2NG9O?=
 =?utf-8?B?NVJCREI5Ukx4eFNlRXVyZU9oZ2xYZ0FXbEs1Y0NTWEFpam9HR1dzL3JBR3Nz?=
 =?utf-8?B?QXRiWFZlM21Oc1ljdmFoUzdEOWJGSU1QNlR1UzUyd3AyTks4WTVzcmI1ellG?=
 =?utf-8?B?U3BPRHpGdzkyQVRlaGNITVlnOHJ6bm5HYVFmK0lSSE1kTVZES1pRK3B6M1JD?=
 =?utf-8?B?ZGJJdnNlQ0RTNGgvS1VFUWZlanEvR085VjNzUWI4K3M3Qk93eGlOK0JWUDM3?=
 =?utf-8?B?dGtrdC8yVTNkRmxlQ3NScXJseVBYQWpaL1ZPZG5pb003NFJsVEFubFhFRW90?=
 =?utf-8?B?Uyt4RHF2SjFHZDJKTmxNWTZOSXhCLzhaTS9tNWJGOUQ3aWluWFg3ZlRhVlZM?=
 =?utf-8?B?VGpxbDhnUEF4UnZZOVRJdTJHdmVGdXIyUzNDRjEwVXNxck13U0R4Qm85cEJZ?=
 =?utf-8?B?N0ZhRXc2ZGk1b3FiVm5aNUxLenc1clkvNFBjR2k2S0h4a3RNUGVYTXRKeXlr?=
 =?utf-8?B?T0tUVUwvRWVHWjJVSlhCVHVzVVJmWVNnMTlqSm5CVEtCTEE4MWoxTFpHc2VL?=
 =?utf-8?B?MnJxQUM4amk4djJFMlA4UnRIdzRZeVZMcE43QW9nVGlhZUJsWCtsZXd0cXFw?=
 =?utf-8?B?UHl2c2d1SUUxVmh2SHVhZFF4VERNYzBCb0FLVEg3NkdiZmJ5cWxGNGxHUmR4?=
 =?utf-8?B?SXI0cm9FOXBkallWMW9EL2pJK28vM2FTNnBQWFBqbnNGYnQ0R01WZ2FVZ0ds?=
 =?utf-8?B?Njh4UG9VcThLYW5xcVhtZENzVGw5UUtzeEtiU1NNR05Hb0g4YW9lajNFMWpE?=
 =?utf-8?B?RVFXZDlNV1dzRXordFRyVFB4TlhDUXJnd0MrNjV6a0J1K0hWMDlBc3RyREwx?=
 =?utf-8?B?aFV3bmdxTFNrdW9hN3dRZ0o5YlNvMDNWRS95aG5CekpWMDM3U2NqOHQwY1lh?=
 =?utf-8?B?bElnTVBWVHVvVkdBemplZ0hzT3V6QzFNM2dKaUxVek1Ob21vKzNseFV1RDlh?=
 =?utf-8?B?TmcyaFkxcmQ3QWZ4YWt6TldSRWkzZ3lISG56eU04ZVNhK3grMktzWGNqTU1k?=
 =?utf-8?B?V0dEV1NtTnJYMVh0ZDRsSHAybUpRR25ZR1BYSXU3VjFMWnB0UDV4M0tnSXNa?=
 =?utf-8?B?cEdDODhoVUg3eFBHS1ZTUjAyMVBjc0JDdmlCTVQ4b0xuM1RDSnI1NzlxZ21a?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14A88CC1975238448F1CA9F281D48742@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11475.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 448d8758-2f5b-486c-3dfa-08dd5019a4f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 12:42:02.8353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GWqv4jfL/Ud9cc/3P8OGH7Ap+EA9THNzlgnEUTTKE2nY/LodUZTQXmLMwZJA64VsZDYyEwwU+yCLgEpFbIXH+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11616
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_044213_293620_F359E6C4 
X-CRM114-Status: GOOD (  22.33  )
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

SGkgU2VpamksDQoNClRoYW5rcyBmb3IgdGhpcyBwYXRjaC4gVGhpcyBwYXRjaCBoYXMgYmVlbiBt
ZXJnZWQuDQpTb3JyeSBmb3Igc2F5aW5nIGxhdGUuDQoNCkJlc3QgcmVnYXJkcywNCk1hc2ENCg0K
T24gMjAyNS8wMS8xMCAxMjowMCwgU2VpamkgTmlzaGlrYXdhIHdyb3RlOg0KPiBUaGlzIHBhdGNo
IGVuaGFuY2VzIHRoZSByZWFkYWJpbGl0eSBvZiBzZXZlcmFsIG1lc3NhZ2VzIHByaW50ZWQgYnkN
Cj4gYWRkaW5nIGEgc3BhY2UgYWZ0ZXIgYSBjb21tYSB0aGF0IGlzIG5vdCBmb2xsb3dlZCBieSBh
IG5ld2xpbmUuIFRoZXNlDQo+IGNoYW5nZXMgZW5zdXJlIHRoYXQgbWVzc2FnZXMgYXJlIGVhc2ll
ciB0byByZWFkIGFuZCB1bmRlcnN0YW5kLg0KPg0KPiBGb3IgZXhhbXBsZToNCj4gQmVmb3JlOiAi
VGhlIGtlcm5lbCBkb2Vzbid0IHN1cHBvcnQgbW1hcCgpLHJlYWQoKSB3aWxsIGJlIHVzZWQgaW5z
dGVhZC4iDQo+IEFmdGVyOiAiVGhlIGtlcm5lbCBkb2Vzbid0IHN1cHBvcnQgbW1hcCgpLCByZWFk
KCkgd2lsbCBiZSB1c2VkIGluc3RlYWQuIg0KPg0KPiBBZGRpdGlvbmFsbHksIHRoaXMgcGF0Y2gg
Zml4ZXMgbWlub3IgdHlwb3MgaW4gdGhlIG1lc3NhZ2VzLCBmdXJ0aGVyDQo+IGltcHJvdmluZyBj
bGFyaXR5IGFuZCBjb3JyZWN0bmVzcy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogU2VpamkgTmlzaGlr
YXdhIDxzbmlzaGlrYUByZWRoYXQuY29tPg0KPiAtLS0NCj4gICBtYWtlZHVtcGZpbGUuYyB8IDEy
ICsrKysrKy0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDYgZGVs
ZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9tYWtlZHVtcGZpbGUuYyBiL21ha2VkdW1wZmls
ZS5jDQo+IGluZGV4IGJhZDNjNDguLjJkM2IwOGIgMTAwNjQ0DQo+IC0tLSBhL21ha2VkdW1wZmls
ZS5jDQo+ICsrKyBiL21ha2VkdW1wZmlsZS5jDQo+IEBAIC00NDQ0LDcgKzQ0NDQsNyBAQCBpbml0
aWFsKHZvaWQpDQo+ICAgI2VuZGlmDQo+ICAgDQo+ICAgCWlmIChpbmZvLT5mbGFnX2V4Y2x1ZGVf
eGVuX2RvbSAmJiAhaXNfeGVuX21lbW9yeSgpKSB7DQo+IC0JCU1TRygiJy1YJyBvcHRpb24gaXMg
ZGlzYWJsZSwiKTsNCj4gKwkJTVNHKCInLVgnIG9wdGlvbiBpcyBkaXNhYmxlZCwgIik7DQo+ICAg
CQlNU0coImJlY2F1c2UgJXMgaXMgbm90IFhlbidzIG1lbW9yeSBjb3JlIGltYWdlLlxuIiwgaW5m
by0+bmFtZV9tZW1vcnkpOw0KPiAgIAkJTVNHKCJDb21tYW5kbGluZSBwYXJhbWV0ZXIgaXMgaW52
YWxpZC5cbiIpOw0KPiAgIAkJTVNHKCJUcnkgYG1ha2VkdW1wZmlsZSAtLWhlbHAnIGZvciBtb3Jl
IGluZm9ybWF0aW9uLlxuIik7DQo+IEBAIC00NTI3LDcgKzQ1MjcsNyBAQCBpbml0aWFsKHZvaWQp
DQo+ICAgDQo+ICAgCWlmIChpbmZvLT5mbGFnX3JlZmlsdGVyaW5nKSB7DQo+ICAgCQlpZiAoaW5m
by0+ZmxhZ19lbGZfZHVtcGZpbGUpIHsNCj4gLQkJCU1TRygiJy1FJyBvcHRpb24gaXMgZGlzYWJs
ZSwgIik7DQo+ICsJCQlNU0coIictRScgb3B0aW9uIGlzIGRpc2FibGVkLCAiKTsNCj4gICAJCQlN
U0coImJlY2F1c2UgJXMgaXMga2R1bXAgY29tcHJlc3NlZCBmb3JtYXQuXG4iLA0KPiAgIAkJCQkJ
CQlpbmZvLT5uYW1lX21lbW9yeSk7DQo+ICAgCQkJcmV0dXJuIEZBTFNFOw0KPiBAQCAtNDU0MSw3
ICs0NTQxLDcgQEAgaW5pdGlhbCh2b2lkKQ0KPiAgIA0KPiAgIAl9IGVsc2UgaWYgKGluZm8tPmZs
YWdfc2FkdW1wKSB7DQo+ICAgCQlpZiAoaW5mby0+ZmxhZ19lbGZfZHVtcGZpbGUpIHsNCj4gLQkJ
CU1TRygiJy1FJyBvcHRpb24gaXMgZGlzYWJsZSwgIik7DQo+ICsJCQlNU0coIictRScgb3B0aW9u
IGlzIGRpc2FibGVkLCAiKTsNCj4gICAJCQlNU0coImJlY2F1c2UgJXMgaXMgc2FkdW1wICVzIGZv
cm1hdC5cbiIsDQo+ICAgCQkJICAgIGluZm8tPm5hbWVfbWVtb3J5LCBzYWR1bXBfZm9ybWF0X3R5
cGVfbmFtZSgpKTsNCj4gICAJCQlyZXR1cm4gRkFMU0U7DQo+IEBAIC00NjM1LDE0ICs0NjM1LDE0
IEBAIG91dDoNCj4gICANCj4gICAJaWYgKGluZm8tPm51bV90aHJlYWRzKSB7DQo+ICAgCQlpZiAo
aXNfeGVuX21lbW9yeSgpKSB7DQo+IC0JCQlNU0coIictLW51bS10aHJlYWRzJyBvcHRpb24gaXMg
ZGlzYWJsZSxcbiIpOw0KPiArCQkJTVNHKCInLS1udW0tdGhyZWFkcycgb3B0aW9uIGlzIGRpc2Fi
bGVkLFxuIik7DQo+ICAgCQkJTVNHKCJiZWNhdXNlICVzIGlzIFhlbidzIG1lbW9yeSBjb3JlIGlt
YWdlLlxuIiwNCj4gICAJCQkJCQkJaW5mby0+bmFtZV9tZW1vcnkpOw0KPiAgIAkJCXJldHVybiBG
QUxTRTsNCj4gICAJCX0NCj4gICANCj4gICAJCWlmIChpbmZvLT5mbGFnX3NhZHVtcCkgew0KPiAt
CQkJTVNHKCInLS1udW0tdGhyZWFkcycgb3B0aW9uIGlzIGRpc2FibGUsXG4iKTsNCj4gKwkJCU1T
RygiJy0tbnVtLXRocmVhZHMnIG9wdGlvbiBpcyBkaXNhYmxlZCxcbiIpOw0KPiAgIAkJCU1TRygi
YmVjYXVzZSAlcyBpcyBzYWR1bXAgJXMgZm9ybWF0LlxuIiwNCj4gICAJCQkgICAgaW5mby0+bmFt
ZV9tZW1vcnksIHNhZHVtcF9mb3JtYXRfdHlwZV9uYW1lKCkpOw0KPiAgIAkJCXJldHVybiBGQUxT
RTsNCj4gQEAgLTQ3MjEsNyArNDcyMSw3IEBAIG91dDoNCj4gICAJCQlERUJVR19NU0coIm1tYXAo
KSBpcyBhdmFpbGFibGUgb24gdGhlIGtlcm5lbC5cbiIpOw0KPiAgIAkJCWluZm8tPmZsYWdfdXNl
bW1hcCA9IE1NQVBfRU5BQkxFOw0KPiAgIAkJfSBlbHNlIHsNCj4gLQkJCURFQlVHX01TRygiVGhl
IGtlcm5lbCBkb2Vzbid0IHN1cHBvcnQgbW1hcCgpLCIpOw0KPiArCQkJREVCVUdfTVNHKCJUaGUg
a2VybmVsIGRvZXNuJ3Qgc3VwcG9ydCBtbWFwKCksICIpOw0KPiAgIAkJCURFQlVHX01TRygicmVh
ZCgpIHdpbGwgYmUgdXNlZCBpbnN0ZWFkLlxuIik7DQo+ICAgCQkJaW5mby0+ZmxhZ191c2VtbWFw
ID0gTU1BUF9ESVNBQkxFOw0KPiAgIAkJfQ==


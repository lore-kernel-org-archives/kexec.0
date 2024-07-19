Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD007C3DA5D
	for <kexec@archiver.kernel.org>; Fri, 19 Jul 2024 08:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/1NJFrN6bQSSLYMu105idDiLTg7LdQsqTSbRXYh7T6Y=; b=3rgIdjMxSJw0RS
	8iH4M5aEtA7KSX6ymIgLMPuOttvKxE2Vt/3OTU5ui2I8D+3bjKrXYGneLc6ohTWmLBeRXr0E0hpGB
	+jLMTC8lQAdayGqiw1IYQTzBug1UPJI0mllwIQm7QyiBQYRZjM3v+FEQJ5Z3EoJ3hsfv15OoiM/Z8
	rOQk+/1/MZg05fpoDR0uPfqtH2w08Y4osWNyKSy7XCKjXMjTAr7o1WlbMq183Une30InrPxZ3O7rU
	eztHXrhRKh5w5ecfDPWX5KlK0hdaJ81cf3sJ5CNN2A3BsyvHCOVAO653gBC0ZTp/NtZ/C+Vb1CZRe
	dcYnYwrwf19uQNhyBoFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUiXi-00000001z3k-1adC;
	Fri, 19 Jul 2024 08:00:42 +0000
Received: from mail-japaneastazlp170110002.outbound.protection.outlook.com ([2a01:111:f403:c405::2] helo=TYVP286CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUiXV-00000001z2Y-0gAR
	for kexec@lists.infradead.org;
	Fri, 19 Jul 2024 08:00:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AyMseX5WQW9ViT71yEv9WLDOnF/3rw2oBZlwQ7Tdw16HvfWmjeuy7P+YwTCpb6UHs5ZyA5ug/7WlDimzDA2pwSZh8wBMjxk8gwB2dWTNNYXWYvO8IzVrO4EHXXyIXbHCPlsl93GjJyUGHWhqZSlr0w8hkBVQASrz7jRsH89iGiYZa3ZIFge7eCp6VtWmag+cQanb+DA/4cgRnPafR4/blUHdgDbgrjVEUXHtvWERXLLImpW+UyrtVih50O6GfW2lRaPKM5GN85LLDyCT6ApMc2xoH3IePkCq5CIE03Wgvgcl2RmUWviLvGYhPbL+RkHEWHG/Zn7VpqetFhVgjx/Z5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnunoX0cux5UPDOzNR2d9vfQnLqa6vv2/Hz7tfBM35A=;
 b=T6Px9/gay03feiBdrlOsQGDNZTRLwplncXev+jndRO9gqBqN0zl2BNTjr8KPK2Lap4lbsi+AVcjhV4y6BQQryf2zN+9mWonZvfooaDcOhFkSvM7apBpN9xuX4QyAFx/5eeTtdcOLnNwXV+5AK27nyJhXNNns6/oHOqmAGt3/eB71xOrRWWGz3FPhclJvdLGXRxwvuM4uLSpnyYxmWtkZj1HgBxH4+KNx+gqtkGJRG9aOy/rnV0juf7hcU+3Ao2w4sZUnfLzCNEKyfyP+r6OMi+XXPUG3vokOL3iWHNF3mhVjMhV4+DSGbst81yp9CdmTaiZO1NWaYjfoRwXrsmQ99A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnunoX0cux5UPDOzNR2d9vfQnLqa6vv2/Hz7tfBM35A=;
 b=K5taFRJB1aTA9ZBLTfb9xTYL0ib9n/fCnUPvmRkj5kha4kiBW9EZ1kkEmucHXmnI7nPWhOcg5A0Ar7kEMvHyOu+IGwYnXZuzv0Tr0wMZNX9FpU2XwFOh7L/Xd2QA/j6b8ZUPRLe4khGgJ3ocUUdRBr3SHqc/wNH+yLddIxg2Ai1dwXWZHKI+fJV3cAHMyAmgSKIUmM122SEtqn+l+CwUfsu7rE5jq8tAWcN9K+ExADNfzyIoMuY37lYXPGeuEwWAe0rXoosoCOksuPCG2YcGKK9dWyNo5NjVFMxjN5SJjH1e/rLH6wzjKRlTgzhZG4FJhPvvGnzUaYL9VglCAGSRHA==
Received: from TYCPR01MB10963.jpnprd01.prod.outlook.com
 (2603:1096:400:3a5::14) by TY3PR01MB11904.jpnprd01.prod.outlook.com
 (2603:1096:400:409::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Fri, 19 Jul
 2024 08:00:08 +0000
Received: from TYCPR01MB10963.jpnprd01.prod.outlook.com
 ([fe80::f07d:6a76:a936:693c]) by TYCPR01MB10963.jpnprd01.prod.outlook.com
 ([fe80::f07d:6a76:a936:693c%4]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 08:00:07 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Jiri Bohac <jbohac@suse.cz>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
CC: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>
Subject: Re: [PATCH] makedumpfile: make reserve_diskspace do nothing for
 flattened format
Thread-Topic: [PATCH] makedumpfile: make reserve_diskspace do nothing for
 flattened format
Thread-Index: AQHawkDgDyuoogo+x0mESc6sZzRq0bH93r2A
Date: Fri, 19 Jul 2024 08:00:07 +0000
Message-ID: <5b665470-182f-4414-8a9b-b1ebf5337b2c@nec.com>
References: <ZnLJOTWFM5P1PTMf@dwarf.suse.cz>
In-Reply-To: <ZnLJOTWFM5P1PTMf@dwarf.suse.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10963:EE_|TY3PR01MB11904:EE_
x-ms-office365-filtering-correlation-id: 990d60e8-d390-40a0-06cc-08dca7c8ce80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TUNTL3BhNmhWdmZyVmx2L1NiVXhwUldHbkE1MGRqclk4OTlFZTA4aXNFVHEw?=
 =?utf-8?B?UVJnZ2JwWmNCSnozN2FEdHFQQlNFazZTMEZoYUdTTnJ3bU4zaFdLMlFRZHZy?=
 =?utf-8?B?a1NoZkl2U0kyNGRQU3kxaEVkRnpFbXU5Sy9kRFpWaFQ2OUNCRjRDZ1lzK0dv?=
 =?utf-8?B?SkhaallnQXllb0x4TnlqNTFBZXNSNWw5dTV4b3NQTVhpUlI1Zm5RRnpNZXlR?=
 =?utf-8?B?aU81VjFKNzdHWkdDNml6eHBwZWp3bmU0cFFaeStMV3lvR1YxTDFFSjhzTDJY?=
 =?utf-8?B?djA5S0ZCUnlRUkpaZ0Erd3RxcHJBUkk0cVNObHFXZTBBRUdmZmhTaGtxcjU0?=
 =?utf-8?B?azB1amFrQWl6ZFJTTUhRMGxJYmNrM0lOZFJxZzVzaGVBSXNySDZFMVQxNzFo?=
 =?utf-8?B?VHpXdkhIQjBmd0lCekFQV1d2WmJYcFhJbGMzQlFsUFkzMDF0YmhrZG1PV2xL?=
 =?utf-8?B?dkZRMW1qS1BlUFBoQ0lMTkVXczgrZ21VWUM2SWttdU5oL2FRcDdFbGVQaHBn?=
 =?utf-8?B?MW1LeHc1V1pYaU1TU2RXMXdrQ3FOQkxBZm90Z1NSMHAxRTRPalExNHhtN1hv?=
 =?utf-8?B?Tk1weGNTOTBibFBmanRXdU1YRUxsOFJjQVRSeS9xRUplY1R3M3lNeEkrWjBl?=
 =?utf-8?B?OGhwWWpoNU5nV01EZEdHNStDQmtibmNoUFR3ak1aNVBUV0w4SHRyRVUvWG1o?=
 =?utf-8?B?aFFIR3VPeVRyam1xU040Q01FVUY1ZTlTeVJKU0FXV1d2TmM5NXNOZkEzNDl4?=
 =?utf-8?B?L2hSVlRSbUtlbHlaOEowVko4MUtRbjd4Z2V4RGF4YXg3SlZ0R2Q5WVdGamd3?=
 =?utf-8?B?d2MrR2g5OWtlcWpDSGJqZis0emxyRTA4TWJoV0ZZSWVkWnBpNTVVUVlDb2Rk?=
 =?utf-8?B?Y2VDTGhVcStUeWtCZGE2TkdBTnlJeXV3ZFRUd2VwdHdCaVFoOVZzS3JJbWxZ?=
 =?utf-8?B?RzBJMHZiaG96T00vbE1RbTdQV2NVUFdhOURDWDNlWUlsbVFtNXdXVkN3T1Ev?=
 =?utf-8?B?aGZYSkdZNVBvZWVjZUZGOXNLOEVsc1BIRXlvblVybkhMOXZTUldvQmVXNmVR?=
 =?utf-8?B?L0RYRUY4OVAyUnh3VkxENWZwUUJ0MWtLV3FDclZmb29KSVBYcHdvS2s0VUgr?=
 =?utf-8?B?ZW42WkNFL1FOa01UQ1I1MWtWWXZFeFFyNmZJMkdkbkhoV1RlWnNzUWFKWWtW?=
 =?utf-8?B?Y2MrWmFtdDcwUGY3bjNpbTNNSUN2WkQ1alZteklZRXhYM1M0UWF0OVo4SDly?=
 =?utf-8?B?eHBZTTBkeWhPQmVNZDY1dHVTM2V2YjVhRG5ONDN0cElHeVRJMTRoSzFaNFJB?=
 =?utf-8?B?ckgyTDNaaFJoY3lLSjFMZTN5bkEzWVRQT2NqSlZtaGN2cWtjUWxxSm82OElE?=
 =?utf-8?B?TTFWcXd1NGc3bGdQRmhUbkppdGlKMzNkS055ZlMzaE5WQzNGM2Q0eWM3V0dm?=
 =?utf-8?B?V3dyYTdkcUNLVHNGTTNlWDlLdnBtMmlRNWxxWWNVN2hhOU82dkR3Q0dQN2px?=
 =?utf-8?B?dWdJT1NCcmhwQksxc05kZlRDODk1SFF0NG4wQnh6RTRvM3BhMDhieGswZGYz?=
 =?utf-8?B?QUlwSGIxcFhTdmpYemJjQzI3NGxmbDIxYnZKNVIxZUpjeTFOb1doQkVNWHZ4?=
 =?utf-8?B?MTYxQ3dnZnlEdWJxbWFlc3A4YVVQVUk3NXVCOGsxZ0pyU09DMU5RSUtNUTh5?=
 =?utf-8?B?ajkwSEY3NTl0RGNUOVBsVDJXQmN3QjhQN1B4QWdRMVdmTUZlcXdudmsyVGlw?=
 =?utf-8?B?MG43Y2d1ZFJvd3U4UStPNElvdE0zOXZUYThkZkY4R0dwL3BYNVUzSHdoSmVp?=
 =?utf-8?B?MW14Y2UrMUw1SVBITnNOdkUwYW5VM0hNdUF0S3dMb1REc1EyUHdEaWhGQUxU?=
 =?utf-8?B?UU45Z3hOTUNGenJZM0c3aGFXY1RyWndadjh0bGRVaWRRQ0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10963.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0dINEo2elppUUppVmRyMkpzUE1mYWY3UG1yOXdjeFN2ZHU1SUpHMVdPWWJl?=
 =?utf-8?B?T0xISGIyTGtnREd3NC8vVDU0cnlrYXhnYVRtZ2x1elBCaWNEK0FTdEZpeWVH?=
 =?utf-8?B?SFVhSWNIOXNBNjNrQXVsWmlmUEw0ODMvdlFNRm1VWS9BcjVOQUVIUGE1U042?=
 =?utf-8?B?VU8ydWZrcVJNM0dyVnVTRlJicmZVS3pDSXVodFZ5U251WnYwL0g4aWN4OXJh?=
 =?utf-8?B?aU9vMXFXTVBZUVMxbUN6emVVUzUxd1pGcy90QjJiUVhpSy9HTXNQSFhlaVRs?=
 =?utf-8?B?cWVudi9oNG5mRVByQVRKUGp2WUhkYWZjNjE2LzlsVjIyRlBZVVptLzFUWnow?=
 =?utf-8?B?Tkh1TnMvaFY1VzlTanZza1BHVkRWTHRWMVdXQk5ud3lnYzl1K1R5TWw1SEZK?=
 =?utf-8?B?S3J6cEU4bDdvZzgzSUM0SGhzVU00ZEFvc0NtejlPYVUrZ0c3SHhZdlJVU1NM?=
 =?utf-8?B?Q0JsU25nT1M0VXJ2c1ZKUmhhK01JV2xVWGZwalBkMFgraTA3K3ZLT0FsN0tq?=
 =?utf-8?B?MzE1eFovUnhiQVdaVzhLdjN3Wmd6QStmR3NBbHlKcEJYdkdybGFUUnFuREVI?=
 =?utf-8?B?d2lBNkJqU2JRTHQ3ME1UZmhXWG10WkRSdERmWUZYZ0doWndyNmF2bk81NGRo?=
 =?utf-8?B?dHI2UkRGZHhmNldRMkFCUERCMFY1RWhNTmxwUXJnd3JkN0ZTL29NeTg5VDFz?=
 =?utf-8?B?T0tWcEZtY0J5N1NGZUZiSWpXblhvemxaL2lTZFhYUEhNdXFYMkFqRjdxVVgw?=
 =?utf-8?B?S0VTQXhBTU9CaDY0NEdqbnBrZ0lsNGt4QVZ6SWN3YXBucDFpaG4zVVlKQVNZ?=
 =?utf-8?B?anM1dkFWZjZ6QW1qalpRam5BbzFXbko1SngzeWhOMjkzYXdkL0M3Z3NrTTlI?=
 =?utf-8?B?M3d5ekU2M0pIRDd6dFlXWlQ2R0hManhaK2hLZDdDR1A2bVozZ1NRbnFjM3lZ?=
 =?utf-8?B?M2FHNzVxQ3dKejAraUZVR1l3bEpJMUlEajRjN2ZHN3prRVkwVjN0cE50L0hV?=
 =?utf-8?B?V3VrVG5sMENSbzQzT3h5bTJBdkhjSENoY3N0MXpLWGszZEpqNlUvK1NUNXho?=
 =?utf-8?B?amNBVWl5MXQrYW15bitxYmlTS1ZBUFYwL0h6V2lIUU0yRHlCdk9QQkRySGdr?=
 =?utf-8?B?aUdTNDY4eWFQdk16ZTVXVVZEV1gwYTFoUlJCRUR5QXFTVXdUbDY2U2hpL29K?=
 =?utf-8?B?RStlRkg5OGdyWTg3L0o4dW9YSlZ1VmhibWZadkJ3L1ZZNHBHejAyYU42NWt4?=
 =?utf-8?B?WnRLS29WZTRDc3NyNzN6aXpzRUYxS0tUKzZFaWRTUzNuQ2o1TlVabUVSTkVJ?=
 =?utf-8?B?Z1FKL0ZySDR5WUVhZS90ZU1ZYWp5VjJRSmtRSGZCbVY2cnowNkhuR2drNFBZ?=
 =?utf-8?B?cmUybllYSlVZbFBHL3RveTgxV2tsdFA5eTdldkxQYmZ4UjdjK0d3ZWQ5RjdU?=
 =?utf-8?B?WC9CdndaaEdqTHpvT1RyQU9rT1RMMDRYK1U0d25yMGlLQTEzZTRDNFd1eGJo?=
 =?utf-8?B?Tllqc3dtTW5RMzhCZU1EekJLVTUyVmlSZGs0aVRDWkd2SjRtSllsdDBhRVRw?=
 =?utf-8?B?OSttd0pQa3hqUmNrd2ZNbGQ4SGgvc0kyUWw2YTlscHUybXBpWEtucWY3T0J3?=
 =?utf-8?B?UlM1Q1JQT0JqZ2d1clBDL0xHUkQ1dUhSa3VUNWlLZXBVMEFqZTBKUU0wbUdG?=
 =?utf-8?B?eUtlT24xVHY0SklXSHNtM0oyMlExUktzYXZ4Z2hmcjFRMUVqMTdyZ2ZJYzQ1?=
 =?utf-8?B?ZmtzTW84aWlwWG1yQ1d5ZjJTTnVDeEgxODVxazRMWnhCTHI3TThrdmJzVldL?=
 =?utf-8?B?V2x5Rm5mNm1LWC9lRlVKbGpxVlFUTW1pVm8xK1dzWWZ2OEhvcCtIdWpnT3FT?=
 =?utf-8?B?eTVZMEViM2FrR1l6aE10blUwVGVDa1BFcWdOZWpvVFVxUnVyanREc3o3eU5m?=
 =?utf-8?B?TDFHMmRFcG1Ta3N5KzQ3eEpzalRvcWw4TlUvSzk1N0N5WlNuNHJXTkZnWUhw?=
 =?utf-8?B?TmNnVG03SHBMbytiTmNlVm95Y3JOeUhZRkQ2QTVoYmEwbzJhSGVzcDB0OHd3?=
 =?utf-8?B?WEhDcG8rbGNKUDlFbS9ZdVBPNUNXTTVaVXJCcGZSTGU3K1FrZHdCYi9Jc2tM?=
 =?utf-8?Q?06RWHWyhFK/LB1iXVHxw2eH8g?=
Content-ID: <55AB353C71CE0A4B8AAD65C6722D5E1C@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10963.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 990d60e8-d390-40a0-06cc-08dca7c8ce80
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 08:00:07.9144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YEzcPqyLtX7BxmpiqoYaa7s7jytgiWMpcQRG5oFQQpevrWDzNKCyouqbuq/GRvFjRXUDylJUBvV1zymARsJvQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11904
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240719_010029_464181_FB0F2DCC 
X-CRM114-Status: GOOD (  23.21  )
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

Hi Jiri,

sorry for the long delay.

On 2024/06/19 21:04, Jiri Bohac wrote:
> makedumpfile: make reserve_diskspace do nothing for flattened format
> 
> reserve_diskspace() is called by write_elf_header() to make sure there is
> always space to write the program header, even if writing other data fails
> because of ENOSPC.
> 
> This is harmful when writing the flattened format to STDOUT for two reasons:
> 
> First, it actually wastes disk space, because first the block of zeroes is sent
> to STDOUT by reserve_diskspace() and then the actual program header is sent,
> meant to overwrite the zeroes when the flattened format is rearranged.
> 
> Second, the algorithm used to read flattened format directly by the crash
> program does not cope with the flattened file containing two chunks meant for
> the same offset. It uses a binary search on a sorted array of flat_data headers
> to find the data in the flat file. It may return the zeroed chunk written by
> reserve_diskspace() near the beginning of the file instead of the actual ELF
> header located near the end of the flattened file.

Thank you for the patch, I found a vmcore that reproduced the issue:

$ makedumpfile -FEd 31 vmcore > dump.FEd31
$ crash vmlinux dump.FEd31
...
realloc: No such file or directory
cannot realloc resized ELF header buffer
$

and the patch fixed this, so

Acked-by: Kazuhito Hagio <k-hagio-ab@nec.com>

(Masa will apply the patch, please wait for a while.)

Thanks,
Kazu


> 
> Fixes: e39216fce9f73759509ec158e39c289e6c211125 ("Make the incomplete dumpfile generated by ENOSPC error analyzable.")
> Signed-off-by: Jiri Bohac <jbohac@suse.cz>
> 
> ---
>   makedumpfile.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index cadc596..9624c3f 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -5206,6 +5206,9 @@ reserve_diskspace(int fd, off_t start_offset, off_t end_offset, char *file_name)
>   
>   	int ret = FALSE;
>   
> +	if (info->flag_flatten)
> +		return TRUE;
> +
>   	assert(start_offset < end_offset);
>   	buf_size = end_offset - start_offset;
>   
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

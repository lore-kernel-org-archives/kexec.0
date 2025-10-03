Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD88CCA471
	for <kexec@archiver.kernel.org>; Fri,  3 Oct 2025 07:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UVdSKWdK7LVXmdlBsRkux95RqjPZUjnygq9HvOmcLfA=; b=KUbAMKG+TlA1benv7TwKuF/KvT
	+CxHp4hFtWQ5aWLmOm2nLM0V8bAcq0nf889TzNdBY/tDET1AQFRIistmkbDgJuqwzqtxW7Hwgn1hv
	XL9/Vl1y/OJjoHhiUHg7w1D8ww/YsocZLKgtBz4oDBaNmpp7Uad7PZCL4Jjr2gh6k3xf3jDx16y0c
	8xl3uycGQUVE1tOsB1ifUr8eULPC7NVmRwXfBJ+fisGrYntnAtVbuYah4Bn6ccY+9u+S8QyfUjNCW
	8nKn08UOpH/aCfRdfHcIxUfNNM+WQ5F06rp+o++tUbcfmkFt0O8kBMzGsG61/mkQXmlvT/lZqIRtq
	fg1301TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4a8L-0000000Bo8s-1HKd;
	Fri, 03 Oct 2025 07:23:17 +0000
Received: from mail-japaneastazlp170100000.outbound.protection.outlook.com ([2a01:111:f403:c405::] helo=TY3P286CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4a8F-0000000Bo82-3bEh
	for kexec@lists.infradead.org;
	Fri, 03 Oct 2025 07:23:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUzqpA438fxOl6Om4xMgY9j0VTT0PO8lQyWuMn4r2K9aC5Xvt0WF2PLTR2da9+Qta24tHxoNbhhwhkXhWpk4iqNwy7nEugJ4ap8bFVPnl/2ehm7F1dpu7cloKXTEu766vy9fRmViwXc6NQkNnn0TKiqc+e96Rgxs6o1kMf4mhKSHV8wBNjxhzxrI/3UN66ODuBXJ93uM/6xtrtik7mImTymcB8EW3RaLL3mRxAZr+Sy01wFCiN+/CcombMmK3glIrYlSj94/S0IxM9kUw3Sqse755xKSEEGaRIqSWv9EMRPadkInbnEzvBA95IWcni5z9S8WN2sS88au+snEautgNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVdSKWdK7LVXmdlBsRkux95RqjPZUjnygq9HvOmcLfA=;
 b=HaP5Y7ZeEfQNrtC2btMZxwhrigyW6LiEpFRdIEEzIhd8i6pnDQzoEKDvkuduId/EPtthy9/09lfzExVONVDfCvYTC0V0rKDA2ePo6DkIk64d5eDc4UM/rqjdd5Ry7iyaeJ1p1p7XROnmsOYbVxSYHVJ0w2Ifsj0I6zliFZRSOOe/EGwVdBIBtdf6WlBqt2qnroSBvVWDEyBOfJVG118Z/kjDiN4wB4qkhHDbdSE3OR+hyizQ4Rbyd0fnDlt0zQOJgpGL1wGW5Xejz85WIT78rqOEvlOGfrJj03X0a+l0iQgXoWNOLF5V5kdmXHu8mJWVIuktfbm49tWr5O3cD8QlxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVdSKWdK7LVXmdlBsRkux95RqjPZUjnygq9HvOmcLfA=;
 b=oouuVHRG6UjlreZMvyxf82idc1ZzW8TExyMrfCyJAcKv8cBZFOy4CmX905ABKjAvI0aS/kpYyjyimjYHFYRWTyNNjqXaZtbvmnZuPGWBk3D0w6o7Rc0sRXZCCDpO/kF5vEzhCLuHjv4b80nFwsgT1i5hBzBpdBSpJEjcwopvn88O2yxBQ856tR4/snO5l4N74PzkPyKXt1hUEvZObhOjeKm1xlSsJtnfRou27v2ZfEO3M067qQ9Cldi7jab2OktlLmkL7QMpnKax6Ba5bGZDZqH/CUVqS98xW0a9ZJ1v16oNzk40dwemgBWLGXGJOirMcGmAt14XOGdTwRSP6hKcxw==
Received: from TY3PR01MB11475.jpnprd01.prod.outlook.com
 (2603:1096:400:40d::13) by TYCPR01MB8535.jpnprd01.prod.outlook.com
 (2603:1096:400:13a::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 07:22:53 +0000
Received: from TY3PR01MB11475.jpnprd01.prod.outlook.com
 ([fe80::dc98:76b8:3a3:fcec]) by TY3PR01MB11475.jpnprd01.prod.outlook.com
 ([fe80::dc98:76b8:3a3:fcec%5]) with mapi id 15.20.9182.015; Fri, 3 Oct 2025
 07:22:53 +0000
From: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>
To: Tao Liu <ltao@redhat.com>,
	=?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>
CC: "aravinda@linux.vnet.ibm.com" <aravinda@linux.vnet.ibm.com>,
	"devel@lists.crash-utility.osci.io" <devel@lists.crash-utility.osci.io>
Subject: Re: [PATCH RFC][makedumpfile 02/10] dwarf_info: Fix a infinite
 recursion bug for search_domain
Thread-Topic: [PATCH RFC][makedumpfile 02/10] dwarf_info: Fix a infinite
 recursion bug for search_domain
Thread-Index: AQHb2e43w9z/flNF10ewqRGC2K2SL7SwuSWA
Date: Fri, 3 Oct 2025 07:22:52 +0000
Message-ID: <ec719745-caa8-4b97-945e-6409234a217d@nec.com>
References: <20250610095743.18073-1-ltao@redhat.com>
 <20250610095743.18073-3-ltao@redhat.com>
In-Reply-To: <20250610095743.18073-3-ltao@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11475:EE_|TYCPR01MB8535:EE_
x-ms-office365-filtering-correlation-id: 37affbb7-d10d-47f8-64a3-08de024daa96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Uzd4a002R1l4N1RGTFBmdXZUbEtvaTYzUmcrQStwUHRmaDB0YUQ0Ri9xVE9y?=
 =?utf-8?B?Z3pXSEVwNU9jQW96REdXUEh6QitEYnBETU55bnM3MmZJeUhIeWpBSGh2Qjc0?=
 =?utf-8?B?dmJ3MUlQa0lRU0R2REpRYytXTXNsUVBKRUY1OEhXdnkrL2Q5emdkN1YrOEhJ?=
 =?utf-8?B?QWFCYnhmR1l1ekZ1MlBIa3FHQnhmY2RuQkVKN0pSRkpZSXU1Ujh1dXFVeW9O?=
 =?utf-8?B?MzJ4MDBmZDh5WlQxVmNQRGozR2xsQlAzbzhLT2F5Nnl0SVI1UkNmWkV3Mnlv?=
 =?utf-8?B?SzlLb01LL1RTVFcvOUp4cGZtUnpFRXFlMEdIMTJjYjZiTjROZC9ZbENYR2c4?=
 =?utf-8?B?MnVLZTVxZXcxMnNPMzNnSUs3elFENW5NcVlGUkl4MGQyUEZ1TU8rTDQvdVEw?=
 =?utf-8?B?OHJmbit2NUIwOWJZRzdNKzJFOVdlbzRzRHZGWHE3K0haSGI4VGk4RzFDdDhN?=
 =?utf-8?B?eEJzMFdZQzlTc1daWUQ5emlNUVM5UFFYZlJGL0ZnbzEyVFZCNnVVNy94ZFln?=
 =?utf-8?B?NmozZGJGN2VCb0pXbjhKZlVTTG1KR3puZnNGanF6aHI2ZlJEZ2RVK3VxVEFU?=
 =?utf-8?B?VEtrazlRZ0ZNTHZZSjNHUUgxNGU2SWpxcTE4ZVNlL212SEl5ZFR4dmNLRkdB?=
 =?utf-8?B?MjRFbnVhZ0t6bFpndmhkWWF5RzAvREI2Q0pMdzhmRnIvNXhCS0JXMHJnSXBv?=
 =?utf-8?B?YklXbDVQT25pbTdrYVpmZDQvUU1PUmZ0b3BGendHQW56RzVQZTZnOUZRNWps?=
 =?utf-8?B?dG4zRDZlczRUYWoralpMdGs1RU9hZjU5MmVUZDVxSE9qa0dWQStSYTNVMHdK?=
 =?utf-8?B?c1NBSFpNdDZLb0plRjhCc0h4bDc0VFZuYjEzaGFzaUg5RVhJdlIrWTJhUmV1?=
 =?utf-8?B?Wkp5NGNVK0NhTGRoY2FIY0QxRE5EUmpCY3l4NVM4YzFZcWdaZ1RuSlNPN1o1?=
 =?utf-8?B?OEFERW16dHlvUE9vZ0RTODR2ODhxSmJVdUdGZU0wTjVKSkg2eDBiNWtEaUNK?=
 =?utf-8?B?RThKT1JJa0JKblBIeG04WnpqV1FScHpXRitpRnNDWFFmaERQQzZhT1FKT0x4?=
 =?utf-8?B?c1Q1MEQ0aFc3ZThQYWI5aytMcloreHFWK1N2NUhPQzhVSEFPa0cxcG5sUHBv?=
 =?utf-8?B?RG0rejVzQ1FFMVFLV3QzVjYyZk1rVmFJdkFQTDZtME1QVzNxdFlaTjB4Qm9z?=
 =?utf-8?B?Q05ieU5teTh3MmtJdTZpQkRCTHNSNHFoMWZmcGY0a08rd1prcjF1d2JVc2pB?=
 =?utf-8?B?eWd4QVVmYVUrSWNnL1BNN3FXVmUwUC81Rkl0VW9iMHdldWRCbjhhZkdBSVJr?=
 =?utf-8?B?OFpKNHpHbVN4WFdKRkRQeVhQTTZsZ3JRQnZabUV4WTV5RVNaT25TVjhSWEk4?=
 =?utf-8?B?OXFDUFQ4THFHakxDN3JQc1ErQXVUYXhYR0ltQnorN2RLOTZEbVdVUUg0YXpE?=
 =?utf-8?B?Rkh6dTlORzRjdkVra0VhYVF0ZzM2VzRkWk1aSTA1R09maDUrUmRQRkdGakhQ?=
 =?utf-8?B?ejNYdTlUVXpLTTg4b01Fd3JlUVdvRE1sMVhZSW1maWJOTGpMcWl1ZFRJZUcr?=
 =?utf-8?B?dTZCUGIzZFh4bHVXUHNzNkQram1pMkUvYW4yOVBXdU1HVVpzbWc2UHZIbjg3?=
 =?utf-8?B?Y2ZENHlnWVJFaGpNSHh3UVJDcSsxRnB3T3ZUV3dMTXNQY0YzczRmMkFZWVQ0?=
 =?utf-8?B?Yjk0VzduQTUvYnZQZi9wYUxJRWo5SFJ3NEdDWXNZdGtIeGxEVGxMRTRtVVZ5?=
 =?utf-8?B?L3hDTVhsZEROMWVLZVY5YjY1MlZJcStWRjVwMkMzUWdhVVFWcUtKTzJPWG5N?=
 =?utf-8?B?eWpQYU1STXhSZ20vQmdOaG80eTE2RlphcktzTkk4WTdJM0RkSDl6QnhHV2la?=
 =?utf-8?B?TVlrU1BpUzJhUVlSSUlqQ2JxUFcycmNWRHBvVnlFOG54MUZoTXp5VHBITFkx?=
 =?utf-8?B?b3ZXZFFZbDBWQVBjT3pOMzVocDFwdWpQRlVTdEllbm1RNTRPU01aM3hWaHNi?=
 =?utf-8?B?YVRBVlVQMHU2alJLTjBNeFllMDlaNVZ3OTVlVlRxbEhiVWU1T0tINWlGOExi?=
 =?utf-8?Q?PcfboJ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11475.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1BFSXNYNmJDQ0VHbm1lZGVOMm0vSzVmMzR2MXdPVXhQTzdKdVRJQVUzb2Fr?=
 =?utf-8?B?VE5IL2xiOXhidHdVOUptcmdac0xhRGYrK081dVNDc2RSNVZQdzhKNUtmMm5W?=
 =?utf-8?B?V3JQK1pFdzhaZ0V6cFZuakhxMjRla2pSb3lGZ0R4WnNWZWJjT0IreG1QQ2Mz?=
 =?utf-8?B?UVNMeU5sT0ZjS2dHR1J4TkdEbmJaclVKREtiY0ZpUnFGMm9KY2pnYzcwdk54?=
 =?utf-8?B?STJ3eHRsUlhNNjNxU0UzbTlmWW5HTmxOL1VZUC9ldXo2QmI0SEgvMkFxY01S?=
 =?utf-8?B?VXgvdTlNQ2NJL3gzampxbThiSFdZRSswaUZSOGtGRWJicHlnRTVlQlRGTjlO?=
 =?utf-8?B?ZjFXL0c1dUloc01OT3N2bzVUWE9yRW1NT1VmQllxRFM0ZTh2bVJkUlcrNTda?=
 =?utf-8?B?bERzMTF6em83WDArOVNiTmdtZUVYR1V5OEtvVDQ0Y0hnajdYMTE5bXFENXc3?=
 =?utf-8?B?cUsyalIxYUF6cFNuLzlSdm9EYmZBVm1FRVlQbk5TZ2ZZODBUM0EreWhuMnlH?=
 =?utf-8?B?RWFxT0IwZmc0dlE4R1FTMlVVZkdBVGpnSUpycWRsQW8vNmNtb0VXUDJIb3oy?=
 =?utf-8?B?RmJzbGQvdUc1MGxOYlFVR3hKbDRUQVBkYnpQSEZMVW5xVktDWkdOckp2OVFj?=
 =?utf-8?B?UmtoLzVwZU5HQ2JCSm1OMWhNWktNaitNeUZNcHdQT2ZiWGpkNncwWTVCS0tt?=
 =?utf-8?B?aUplL3RjUU1DMkJrK0s0Qk8ya0pMeTFjTzBzQ2FpK1VLTDY0ckFMblYxVmtV?=
 =?utf-8?B?bXJMdFIzSUNUVU9BN1N1RGF6MHhtY2tzTFRQYnRDMWhSYkVNU2w3cjYzSEd5?=
 =?utf-8?B?amZ1VkU0U2kxRDF4TWI5aDk3RS9abzJ3SFpMdXc1ck02U0U2MXQwTXVCK3FX?=
 =?utf-8?B?SFQxVkw2LzhaL0FiRDBiOTB2MGM3ZzRjWkd2NDZkSGM1UkdaamJwVExJejRZ?=
 =?utf-8?B?cjFYeW1SZ29PTFhJMzRKSldRdXhxNmNCeDJNby9MWmMwMXl1anFEUUQwYjJw?=
 =?utf-8?B?c0VlcXUvSVJhOGptQ0U3aUY1azRuUVQ2K3kxWVRBN1k3TWhMWi9wTVFNUnFM?=
 =?utf-8?B?VWtKN2p1OFFWbzYrelRKNit2OWdjdDc3bHNYbVQ0ZUs0YjRnTWJMMTA5Z2V1?=
 =?utf-8?B?SG10SGpYNGp6TUxHSHZnTGx0YnN1SVAwSHN6OXM2M3d1MW5hOXJYMlJQZWVU?=
 =?utf-8?B?R1dHWWpGVWhkbFA1MmNrZG90dk5uMHJVdjZ0dmhkeTJOOEJ6d0lHa1E1Sm5P?=
 =?utf-8?B?OXRoUE1xcEMvUXppRTJZMmVKSnVVcE9mVWZMNkhaZjVwWjhjUFRxV2FxZmhy?=
 =?utf-8?B?bFVpeVhtOEsydFhxQURkSWx6SDAvWE05YXpMbyttcG5IdVNEWjVMU2NOTDFh?=
 =?utf-8?B?VEVPUnRiUVowT1N0VG9BQnBlQWJUMlo1ZVIvNlk5TjVVRi9xU0greUNwR2pF?=
 =?utf-8?B?Qk12bjFxSFRERXJoR2xDdFZQakxPaGV1Uk81bnpXMmhLQTY2a1FQT0k1Y0ZQ?=
 =?utf-8?B?SFBLYjI0ak9UbXd4RFdyNzd5dnJMMm9OY0VXUlpVQkxxMDJOeFp2Y2UyeXZ5?=
 =?utf-8?B?cTNSS1Z1b1k4Nm9DMnlMdWJSRmluYk94Z2RMcnIvSVlTWVlpN3ducll6RkVl?=
 =?utf-8?B?c3FWMXBtZVhNSis5cU8zNHVpZ1RHRG9jeHoyU0lUVFlMckRRbit2MFFoa0pq?=
 =?utf-8?B?eDZaczlObWxxbERGVUVjRFhSZHp5U28zNnVjaEY5R1VRUVl0d2xkMkpOekxT?=
 =?utf-8?B?RG9XeENLWGtjZzVWYytmbmFUY2RRZFNiM1pIUmFCbStLbzlYbVNzekNZOEVN?=
 =?utf-8?B?UFFhYTNhVzFPdDY5Q3pZQW42ZkMrRVhzNER0TzFuUk1xZlYxblFqcVRpK0g3?=
 =?utf-8?B?akZ0SnN5VTEyMTM1UlVJYlQ4SXNLcXBvTHNHQjJJNzZ5UGZNaWVZY0lvMjFT?=
 =?utf-8?B?bTVIWmFBRFFsMC9Fdk1MVTFLdi9SL0hVa01lWFg1a3JlVHArSmpKeEJ5TDBC?=
 =?utf-8?B?b2xTUzNVbnhYbGpTZ0pZWGJ0ZXR2eE9jL0twZmpQc3ptS3FLdWkxTk5VQmZQ?=
 =?utf-8?B?dVRIZU5wREdWeUUxcWg3akNjUXQzd2xmNzVzUGNGODNoUnJEeWVuTGlpS2ZQ?=
 =?utf-8?B?WVBXeUtTOVoxVFZpVlJWV0JPTXgwWThZMWhuMUJqY0s4TWNlMldDVnhGNk16?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5E8E1ABE342EA45B678216F4346B249@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11475.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37affbb7-d10d-47f8-64a3-08de024daa96
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 07:22:53.0742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T4qp+S2CSG80T57zYpQvcq2TrscOznIjECSNisHnd2Ovnsh/vEAs5MQB5Qhcw7uPvd3UUh8MjucfU8sqohvDog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8535
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251003_002312_118555_A92C0142 
X-CRM114-Status: GOOD (  19.11  )
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

T24gMjAyNS8wNi8xMCAxODo1NywgVGFvIExpdSB3cm90ZToNCj4gVGhlcmUgaXMgYW4gaW5maW5p
dGUgcmVjdXJzaW9uIGJ1ZyBub3RpY2VkIGluIHJ1c3Qgc3ltYm9scy4gVGhlIHJvb3QgY2F1c2Ug
aXMNCj4gdW5jbGVhciB0byBtZS4gVGhpcyBwYXRjaCB3aWxsIGF2b2lkIHRoZSBidWcgYnkgc2tp
cCB0aGUgcmVjdXJzaW9uIG9mIHJ1c3QNCj4gc3ltYm9scywgc2luY2UgY3VycmVudGx5IHdlIGRv
bid0IG5lZWQgdG8gZGVhbCB3aXRoIHRob3NlLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBUYW8gTGl1
IDxsdGFvQHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgIGR3YXJmX2luZm8uYyB8IDE1ICsrKysrKysr
LS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25z
KC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kd2FyZl9pbmZvLmMgYi9kd2FyZl9pbmZvLmMNCj4gaW5k
ZXggYTNhMmZkNi4uNzM4NDJhYiAxMDA2NDQNCj4gLS0tIGEvZHdhcmZfaW5mby5jDQo+ICsrKyBi
L2R3YXJmX2luZm8uYw0KPiBAQCAtODM3LDcgKzgzNyw3IEBAIHNlYXJjaF9zeW1ib2woRHdhcmZf
RGllICpkaWUsIGludCAqZm91bmQpDQo+ICAgfQ0KPiAgIA0KPiAgIHN0YXRpYyB2b2lkDQo+IC1z
ZWFyY2hfZG9tYWluKER3YXJmX0RpZSAqZGllLCBpbnQgKmZvdW5kKQ0KPiArc2VhcmNoX2RvbWFp
bihEd2FyZl9EaWUgKmRpZSwgaW50ICpmb3VuZCwgaW50IGxhbmcpDQo+ICAgew0KPiAgIAlpbnQg
dGFnOw0KPiAgIAljb25zdCBjaGFyICpuYW1lOw0KPiBAQCAtODU5LDEwICs4NTksMTEgQEAgc2Vh
cmNoX2RvbWFpbihEd2FyZl9EaWUgKmRpZSwgaW50ICpmb3VuZCkNCj4gICAJCQlpZiAoaXNfY29u
dGFpbmVyKCZkaWVfdHlwZSkpIHsNCj4gICAJCQkJRHdhcmZfRGllIGNoaWxkOw0KPiAgIA0KPiAt
CQkJCWlmIChkd2FyZl9jaGlsZCgmZGllX3R5cGUsICZjaGlsZCkgIT0gMCkNCj4gKwkJCQlpZiAo
ZHdhcmZfY2hpbGQoJmRpZV90eXBlLCAmY2hpbGQpICE9IDAgfHwNCj4gKwkJCQkgICAgbGFuZyA9
PSBEV19MQU5HX1J1c3QpDQo+ICAgCQkJCQljb250aW51ZTsNCj4gICANCj4gLQkJCQlzZWFyY2hf
ZG9tYWluKCZjaGlsZCwgZm91bmQpOw0KPiArCQkJCXNlYXJjaF9kb21haW4oJmNoaWxkLCBmb3Vu
ZCwgbGFuZyk7DQo+ICAgDQo+ICAgCQkJCWlmICgqZm91bmQpDQo+ICAgCQkJCQlyZXR1cm47DQo+
IEBAIC05MjQsNyArOTI1LDcgQEAgc2VhcmNoX2RpZShEd2FyZl9EaWUgKmRpZSwgaW50ICpmb3Vu
ZCkNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIHZvaWQNCj4gLXNlYXJjaF9kaWVfdHJlZShEd2Fy
Zl9EaWUgKmRpZSwgaW50ICpmb3VuZCkNCj4gK3NlYXJjaF9kaWVfdHJlZShEd2FyZl9EaWUgKmRp
ZSwgaW50ICpmb3VuZCwgaW50IGxhbmcpDQo+ICAgew0KPiAgIAlEd2FyZl9EaWUgY2hpbGQ7DQo+
ICAgDQo+IEBAIC05MzIsNyArOTMzLDcgQEAgc2VhcmNoX2RpZV90cmVlKER3YXJmX0RpZSAqZGll
LCBpbnQgKmZvdW5kKQ0KPiAgIAkgKiBzdGFydCBieSBsb29raW5nIGF0IHRoZSBjaGlsZHJlbg0K
PiAgIAkgKi8NCj4gICAJaWYgKGR3YXJmX2NoaWxkKGRpZSwgJmNoaWxkKSA9PSAwKQ0KPiAtCQlz
ZWFyY2hfZGllX3RyZWUoJmNoaWxkLCBmb3VuZCk7DQo+ICsJCXNlYXJjaF9kaWVfdHJlZSgmY2hp
bGQsIGZvdW5kLCBsYW5nKTsNCj4gICANCj4gICAJaWYgKCpmb3VuZCkNCj4gICAJCXJldHVybjsN
Cj4gQEAgLTk1MCw3ICs5NTEsNyBAQCBzZWFyY2hfZGllX3RyZWUoRHdhcmZfRGllICpkaWUsIGlu
dCAqZm91bmQpDQo+ICAgCQlzZWFyY2hfdHlwZWRlZihkaWUsIGZvdW5kKTsNCj4gICANCj4gICAJ
ZWxzZSBpZiAoaXNfc2VhcmNoX2RvbWFpbihkd2FyZl9pbmZvLmNtZCkpDQo+IC0JCXNlYXJjaF9k
b21haW4oZGllLCBmb3VuZCk7DQo+ICsJCXNlYXJjaF9kb21haW4oZGllLCBmb3VuZCwgbGFuZyk7
DQo+ICAgDQo+ICAgCWVsc2UgaWYgKGlzX3NlYXJjaF9kaWUoZHdhcmZfaW5mby5jbWQpKQ0KPiAg
IAkJc2VhcmNoX2RpZShkaWUsIGZvdW5kKTsNCj4gQEAgLTEwMDcsNyArMTAwOCw3IEBAIGdldF9k
ZWJ1Z19pbmZvKHZvaWQpDQo+ICAgCQkJRVJSTVNHKCJDYW4ndCBnZXQgQ1UgZGllLlxuIik7DQo+
ICAgCQkJZ290byBvdXQ7DQo+ICAgCQl9DQo+IC0JCXNlYXJjaF9kaWVfdHJlZSgmY3VfZGllLCAm
Zm91bmQpOw0KPiArCQlzZWFyY2hfZGllX3RyZWUoJmN1X2RpZSwgJmZvdW5kLCBkd2FyZl9zcmNs
YW5nKCZjdV9kaWUpKTsNCj4gICAJCWlmIChmb3VuZCkNCj4gICAJCQlicmVhazsNCj4gICAJCW9m
ZiA9IG5leHRfb2ZmOw0KDQpIaSBMaXUNCg0KVGhpcyBwcm9ibGVtIG5lZWQgdG8gYmUgc29sdmUu
IEJ1dCBJIGRvbid0IGtub3cgaG93IHRvIHJlcHJvZHVjZS4NCklmIFlvdXIgc2VydmVyIGlzIHJ1
bm5pbmcgcnVzdCBwcm9ncmFtLiBPciBPciBpcyBpdCBydW5uaW5nIGFzIGENCm1vZHVsZSBieSBy
dXN0PyBQbGVhc2UgdGVsbCBtZSBob3cgdG8gcmVwcm9kdWNlIGl0Lg0KDQpUaGFua3MsDQpNYXNh
DQoNCg==


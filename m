Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55613C982D3
	for <kexec@archiver.kernel.org>; Thu, 17 Sep 2026 08:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vUThPHI1Nz2NzgExFr/TTI0k0plhHqOMdBbgvEQzNPk=; b=PiLSNvaNZkBMfHQWlucqZY78iC
	e69mm2NARw19udncPdJebEA994iascY3uOBQ9GjdlbpwFNGoJrLcAbiQQVeOEa5HFh4dKFOOQ1v7Y
	7MNX6Y5PELvMWC76yx/AoY/pwrvY38+mEUL20IklhQ8UklxmLCKAgpJ9DxjlzbPrdHER9VEGCoOmq
	S1bCvfsp17gNoKrcCdCkmxxrpz1JTJ4Q4LqRprlFp11/KJrXgQcvjXW4wTSG5BlW2rQVsq8XUDbPU
	d/LulBYIbnQAE1b8naQMKqvTwnxorjTVcBH1G5ybRWUSgp/tJfdisUQeUmU75MZ3SxLoNH4SMHFwE
	NXet4YfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x77Ca-0000000ArA2-18Qf;
	Thu, 17 Sep 2026 08:10:40 +0000
Received: from mail-japaneastazlp170110002.outbound.protection.outlook.com ([2a01:111:f403:c405::2] helo=TYVP286CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x77CV-0000000Ar8l-3o7T
	for kexec@lists.infradead.org;
	Thu, 17 Sep 2026 08:10:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmyiLPPRJyk8GvSiLGGLQQnOd3CGOuuIZOwCFHgc96PobTvNu9eid74OjGhh3XcOdncLBTiWlj0EzkQY1TGoCc6ld8pXvdrvVE1+DhtH3rHaGfHt7ij83LeI1t2dCCoPyl+iIbNc2G3if//IRMpKOMXp8F3bI6Kbka4N8P65NuyV01YN+/L/wclhIKWfh4cC9GvEE9FsovmnwqEDtkinWKFno1uzEKKuiQDS/Zs+3L2lgteQsG1+OP5HbjrKp6+VWQQcnJsPiygLZyRE7NEi8CnYlyH9/9XT9fXrWOViIhRqKqNjpw5i5YIR5gMWLhq34BiYVmssne2pg+NmpbTfAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUThPHI1Nz2NzgExFr/TTI0k0plhHqOMdBbgvEQzNPk=;
 b=mBIv9734+Os4c0LusFGReVXsUi4TRdZkKVKzY6nUoUUC3qgOXl40TSbwpNAziQvJV9uTl7rJfGegHlz9xLDnQ5Ghi1EHbB6ft0RSADe7p5ZoJJk2nr8UKGdWRLLsmVos3fmPukEJSJfk+KEptNryNC6esIjeTITLWOl5JyhaTtuo7ieWtkrBwsHHB9DG+TizPDzHEgVBVC9cXte5lp+wkmld749JRio49lYFvfZGmXQTCFWe5AV18r+dp6kajXZxd1JRsh3J7Tp6muj8PuTKlXaTTTEOlewWyHxW1/MmZDNEJcFjBObNHei0KI+yOtz8VjiXsIXZCblI48mVrPkzrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUThPHI1Nz2NzgExFr/TTI0k0plhHqOMdBbgvEQzNPk=;
 b=VfBoE4Ls5FpI7+FR+SipxQGU6WYY9++GnWIGde9bqPvNWPlcuTVn97iO8kaVPrC/pYvZqm50g10e7mWlrPX4ThJloAyZ/jCoRAjG+mvoPkaGUqK8U26P9CDDdBUSXAbKVTSbjNVbCNIu1NueHh9l/2qkWhhX7aD39VglCfCbeASOeD+oBB49DGMhDusAfsLKg7dc/qMffii1JMvztqnu0sOtbFnSrMkvuGvRywpG51qbs8kPCDuocGpoWEQuopN3OLeJCP6Wy1rPDxZYgs+3oTQQ3HFP2JU0YFfKsUGEzyioPMDYJf/o53xZap92mprqsD75f0cDCDO1wIzknQEk6g==
Received: from TY1PR01MB10753.jpnprd01.prod.outlook.com
 (2603:1096:400:322::11) by TYRPR01MB13405.jpnprd01.prod.outlook.com
 (2603:1096:405:1c7::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Thu, 17 Sep
 2026 08:10:13 +0000
Received: from TY1PR01MB10753.jpnprd01.prod.outlook.com
 ([fe80::2a66:6d54:28:11]) by TY1PR01MB10753.jpnprd01.prod.outlook.com
 ([fe80::2a66:6d54:28:11%4]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 08:10:11 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
	<kazuhito.hagio@nec.com>
To: Nikunj Kela <nkela@crusoe.ai>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
CC: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
	<k-hagio-ab@nec.com>, "bhe@redhat.com" <bhe@redhat.com>
Subject: RE: [PATCH] Derive the mem_section mem_map mask from SIZE(page)
Thread-Topic: [PATCH] Derive the mem_section mem_map mask from SIZE(page)
Thread-Index: AQIhZkyUwqAwDME02GWQmp8kxMDAYbZKBiRw
Date: Thu, 17 Sep 2026 08:10:11 +0000
Message-ID: <TY1PR01MB10753FE96BBA5EEBCAF6F13DD84B82@TY1PR01MB10753.jpnprd01.prod.outlook.com>
References: <20260904190825.79964-1-nkela@crusoe.ai>
In-Reply-To: <20260904190825.79964-1-nkela@crusoe.ai>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB10753:EE_|TYRPR01MB13405:EE_
x-ms-office365-filtering-correlation-id: dbe11e75-adbe-440b-1fbd-08df14931894
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|6049299003|4053099003|3023799007|38070700021|10067099003|11063799006|56012099006|6133799003|5023799004|22082099003|18002099003;
x-microsoft-antispam-message-info: PMarHZC2yrBS/2EnLBca1fulAmjyXh4vvQKYNEbQZiNH5FM1YSxcsS1O501ByVUtAdvTFxNm8AZHNihg3eOaqT8zfjcltv1gPC8+BMtDKUD4TPBDgQfgjplYPGbZLRxpu/Yhv/QI5YbuluxufCtrFCiXYiO6nQNK0igzF/5gB5kuGhjc3F3rWjtw5EdccpQQBEGjyauT7GXQdx5f2ogrFq6mu5CFFj+geeU6fb4GYKm8FXby6oEQP236iP/caINB+4429raKKaaOEsymVT9/Nukha6pYj8JQkr6rW5sODMYCgUaAG8+QzYfWAkXMQ9A/YVwanwAvY+vogymhXP2s8atVYwecLO6OWKWDpYMs0vcOz4m1TihXj6q5DHDjeis+m4T+xmuPus/ugiZJKtp+5hx7oQeL/7eFbT3283SQBGUlDqTp9H4U3ZTJdsofl5y4RpAqCI/NoS/5J5hagF0giuW+3MQpfO2piRpdgyl+LCXYdR4yK/INwnUBKEdpqtr5VKDuWKVuOXlAROcuOWof06AuG9da8N9gwwQc/FE85dA19z288EJEc3VRpvqUW2vus2EyybE7AYmrbfdcXmHc/60L+cTX9vbCxE8YgIkpRntY5NjgvCe0f6Xpm/yxhWmi5iimHgtpw0Xs84vOCzbUBRTmMIx1j7/iMr7cAh/5y8rcK9ZM7a9hd1AXW5owvLVJX39gZoZekbmrWnB/eU8FYcD+44lTKB0YvOkYbXXHoiY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB10753.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6049299003)(4053099003)(3023799007)(38070700021)(10067099003)(11063799006)(56012099006)(6133799003)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?ZDRnUzNyOUxmY0ZWUFE2OGRJaytPM3FzNTVUTXRHdE1oZmFrdkhERThz?=
 =?iso-2022-jp?B?SzZFOWtYTmNidDBpM3ZuRnJYT2ZvbTNLVGR4dThZYlpyQ0dkTEhvNk9p?=
 =?iso-2022-jp?B?czNYcno3V0VadUZyWElYd2twVC9lYzhSaVVDb05mVGtxWmFNSWpockhE?=
 =?iso-2022-jp?B?d3RZb2lvdnNzUVE5aldKQTNicVdhV3lWWTZFd213bFJFNk5idnkvVXlC?=
 =?iso-2022-jp?B?VnBrM3ltcjNDcExDckM2aHptUEIyc0xROXIyTy8zczg4bCsyOWhORE1X?=
 =?iso-2022-jp?B?bzY2bVloS2dURnhZRDE4eGFldTAxQU5xbjRCSUl6UGRpZTM5clE2bTFZ?=
 =?iso-2022-jp?B?MjJjTmR5OWdnUVhOcGxyK0ltcFBDc0pEM2tFZkErUGxIWFVpazdCbnh1?=
 =?iso-2022-jp?B?YUQrZFZJRGpDQXl6b0lQY1ExSlR4aks1ME9YbkZDVGQ5dFYxWjdXWEM2?=
 =?iso-2022-jp?B?RXgxMjhqQ05DQUxsVHNOVXNqNUFieC83ZFZWczFLUE5qRVlFNjFiL244?=
 =?iso-2022-jp?B?UWw1MzZXTHFCVWdjR3N2ZEhuWEIwNWlsbHlJOElZYmZQZWJSeHEvWUVm?=
 =?iso-2022-jp?B?WjZ5QVRoaVBSTWozMWN3dFA2azFwTEg1Nk0wejNkNmNkaHZkRmt2bFQv?=
 =?iso-2022-jp?B?VUxia3ZDQUNzdWRTcGVLWUxOTGVXaTh5Z0V2bkdaUFpLTEtnZ21VQ0lI?=
 =?iso-2022-jp?B?Zk0zVkNOanF5Y25ZanJoR1pkMFVGMWNjUkhuamh1aWU3cVkxMGRNOGFO?=
 =?iso-2022-jp?B?S2tsK1lyNFRyc2lpSmRZODRhQ0JGakRYSm9CeG4rY2YwNzJIaVZyVTdi?=
 =?iso-2022-jp?B?NnlURkgyd2RiRDBUOTVGMnlPQkI3cm9DdTRNMkdyZStTSjBDQTFtdHJz?=
 =?iso-2022-jp?B?TVErSGlhcitHRmZFTVhWK2NSNHpmMVR5ZldQanNqdEhWUFgzY2VpNWlG?=
 =?iso-2022-jp?B?eDdmb1ZVTzhPM1pQdlJ6N3VNUFRVdGpIbVN0YmphaHR0K2lHa1lBd3VO?=
 =?iso-2022-jp?B?eFZRUzZ4UHVlLzMwRkI5QXdDTnE2MnhoN29wOTE4MnY3b1FXeHZBeW1T?=
 =?iso-2022-jp?B?czdqRVZ6R3pSc0s2dGFtSE9KNDBQcW16RlFnZ0dHYjBIWEwzVGtXMWl6?=
 =?iso-2022-jp?B?ci9mREVQTytyZHhNaEp1QWFFVWtkRlp2eUFFLzBNTUNTSnlLcVNUMUtT?=
 =?iso-2022-jp?B?RFRyTzRwRks3RTQ3blhiZXd1V0xCZUNOTjRPZ3czVmN4ZVdqWmV5SVpw?=
 =?iso-2022-jp?B?c1E1eXljZjRFSFgrZnl1dlBpSHh3L01hc01WLzA0eUszUUthaTlpNGJI?=
 =?iso-2022-jp?B?M3VDaS9ZalRzNTN0R1JPeTl0UUhXMS9MazEzT2JTeHdLTS84Uk9hTFRl?=
 =?iso-2022-jp?B?TThlNG9GeVRZZWZJa0NQUklWSmUyZFNGM0VSbDF3azJzVk5Nb0VRTWRa?=
 =?iso-2022-jp?B?VkN5RmJnMUt5d0RhTjAxc2RkOWdOS0tDSzRnWlJBR2JvQ1Z4WWtuaU1W?=
 =?iso-2022-jp?B?V1NnelRKRmhUbjJvY2JkeXdOVS9UZU9HdVY5dHFwek1EVjB4WGRDNDVQ?=
 =?iso-2022-jp?B?MjhHclVZTVRod1N1MVhjRnRWVVNjYVVHZnl2M3hmWjcybTB5U1lMNDNI?=
 =?iso-2022-jp?B?ZWE5eWtSam80WE5ocGd5eTB4QnJjYzZTVVduUndNTTc5RWIyL201bXlX?=
 =?iso-2022-jp?B?d0g0bGMwcXFKZFVjOW1CakdYZjk0UE1OVzlUOW1KZnFDK3pWZnRPV1JM?=
 =?iso-2022-jp?B?UUZSSGNOOEpSL2p1bDNBUVhES2RxaCtEZ2VweExFM0dPV0RFNmhMM25S?=
 =?iso-2022-jp?B?YWllWUs3aEFXbXNqZGdmVTFiV0R3c1IvNHA1QWxGbDlrYm15aTBYYUVN?=
 =?iso-2022-jp?B?UVUxdGZycVdRZkx1UmdMSVVMa1ZIT0ZCSDRXbDVzYXYyZGRLWFc0Ym5h?=
 =?iso-2022-jp?B?c2lvNXFDMEo3MkMxR3lMbVdjeHczTUd3eUMrL2N3NGppMmhROFRud1J2?=
 =?iso-2022-jp?B?dWhHOTcwWmoxMHJFV0RDQkxpTGRDOG9NbXJoU2FkMHFSVlprU1JzNTFF?=
 =?iso-2022-jp?B?TTAxVWJxV1BiWS8rSmExNnRTNG1pYUlKT0JOU3JQSmxCd0dRYlpGOWFQ?=
 =?iso-2022-jp?B?Qzh1SU5tUVg3UGpKMEhPNzNKYllFc2wrbTZrWHErZkI1bmhaekZvbkdW?=
 =?iso-2022-jp?B?U045amJuRUlEQUphZUM2bENpVms2QWlzb1poYVBZanR1WjRqdjU2QnQ3?=
 =?iso-2022-jp?B?S1JsK3l6ZllhUStTY0NPWWtVVVVOeDBnRG12SXpxVU5CVFpwRHBKQzVE?=
 =?iso-2022-jp?B?Y0xTbzMzcjEvbEIxRS9xeGFjVGRuaWtmVzJGTkpiYTZaY2F1aXVYUzhr?=
 =?iso-2022-jp?B?aGtRUDZyZ1VxTmZDTCtxMk9HL0szeDJoT0k4M29ZRzlVbWNaQkZlZUN1?=
 =?iso-2022-jp?B?Q2MrN1ZmenJtT1pTMUZHVVdsL05pY2gwdjUrS3ppMmNKaEdIeHpaUVc3?=
 =?iso-2022-jp?B?QkR5YVFmTkRIeTIxVFdKSGExOHZWTElQeklyZz09?=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_00E4_01DD46C7.65303FC0"
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB10753.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe11e75-adbe-440b-1fbd-08df14931894
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 08:10:11.4438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rGUys3TfcKtOeoOJQ4yVD0fxxacj+R587tmLRmcAuZeTFv0NiEfcebtY8dZLGBmO6g7J55ufvu9oxRzxhUqYWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13405
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260917_011036_288565_9F7DE1EB 
X-CRM114-Status: GOOD (  37.07  )
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

------=_NextPart_000_00E4_01DD46C7.65303FC0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit

Hi Nikunj,

thank you for the patch.  sorry for my delay.

(My email will be changed to this From address soon.)

> -----Original Message-----
> Linux 6.15 added a new mem_section flag bit, SECTION_IS_VMEMMAP_PREINIT
> (commit "mm/sparse: allow for alternate vmemmap section init at boot",
> Frank van der Linden), used on x86-64 to mark sections whose vmemmap
> was pre-initialized at boot for HugeTLB Vmemmap Optimization (HVO).
> With CONFIG_ZONE_DEVICE=y this is bit 5, and SECTION_MAP_LAST_BIT in
> the kernel moved to bit 6:
> 
>     SECTION_MARKED_PRESENT_BIT,      /* 0 */
>     SECTION_HAS_MEM_MAP_BIT,         /* 1 */
>     SECTION_IS_ONLINE_BIT,           /* 2 */
>     SECTION_IS_EARLY_BIT,            /* 3 */
>     SECTION_TAINT_ZONE_DEVICE_BIT,   /* 4 */
>     SECTION_IS_VMEMMAP_PREINIT_BIT,  /* 5 */
>     SECTION_MAP_LAST_BIT,            /* 6 */
> 
> makedumpfile still defines SECTION_MAP_LAST_BIT as 1UL<<5, so
> SECTION_MAP_MASK is ~0x1f and bit 5 survives when section_mem_map is
> decoded in section_mem_map_addr().  For every section that has
> SECTION_IS_VMEMMAP_PREINIT set, the resulting mem_map address is off
> by 0x20 -- half a struct page on 64-bit.  All struct page fields read
> from those sections are misaligned (page.flags reads page.index,
> page._mapcount reads the next page's lru.prev, ...), no exclusion
> filter matches, and the pages are kept as "dumpable kernel data".
> Nothing is reported, because the bogus address still passes
> is_kvaddr().
> 
> The kernel sets this flag on every section backing a boot-time
> gigantic hugetlb page when HVO is enabled (hugetlb_vmemmap_init_early()).
> On the hosts with lot of hugepages reserved at boot-time, the core size
> grows significantly. It increase the time taken to generate the core as
> as the disk space needed to store it.
> 
> Signed-off-by: Nikunj Kela <nkela@crusoe.ai>
> ---
> Tested:
>   - x86-64, Linux 6.17.13 (SPARSEMEM_VMEMMAP_PREINIT=y, ZONE_DEVICE=y),
>     1470 x 1 GiB hugepages, HVO enabled
>   - arm64, Linux 6.11, 512 MiB hugepages, HVO not enabled
>   - No 32-bit target available; the 32-bit case is a provable no-op
>     since mask is unchanged
> 
>  makedumpfile.c | 16 +++++++++++++++-
>  makedumpfile.h |  5 +++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index ba01137..be885f3 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -3705,7 +3705,21 @@ section_mem_map_addr(unsigned long addr, unsigned long *map_mask)
>  		return NOT_KV_ADDR;
>  	}
>  	map = ULONG(mem_section + OFFSET(mem_section.section_mem_map));
> -	mask = SECTION_MAP_MASK;
> +	/*
> +	 * The encoded mem_map is struct page pointer arithmetic, so it is
> +	 * always SIZE(page)-aligned, and the kernel guarantees that all
> +	 * section flag bits fit below that alignment (see the BUG_ON in
> +	 * sparse_encode_mem_map()).  Derive the mask from SIZE(page) instead

The whole patch looks good to me and tested ok, but does the BUG_ON says
about the relation to that alignment? 

  BUG_ON(coded_mem_map & ~SECTION_MAP_MASK);

(currently this is in sparse_init_one_section() as VM_WARN_ON_ONCE though.)

This seems that all section flag bits fit below SECTION_MAP_LAST_BIT, not the
alignment.  Is it ok to remove the "(see the BUG_ON ...)" to avoid confusion?
If it's ok, I'll remove it when merging.

Thanks,
Kazu

> +	 * of hardcoding the number of flag bits, which changed in Linux 4.13,
> +	 * 5.x and again in 6.15 (SECTION_IS_VMEMMAP_PREINIT, bit 5 with
> +	 * CONFIG_ZONE_DEVICE), and fall back to SECTION_MAP_MASK if SIZE(page)
> +	 * is unknown or not a power of two.
> +	 */
> +	if (SIZE(page) != NOT_FOUND_STRUCTURE && SIZE(page) > 0
> +	    && !(SIZE(page) & (SIZE(page) - 1)))
> +		mask = ~((unsigned long)SIZE(page) - 1);
> +	else
> +		mask = SECTION_MAP_MASK;
>  	*map_mask = map & ~mask;
>  	map &= mask;
>  	free(mem_section);
> diff --git a/makedumpfile.h b/makedumpfile.h
> index c4f3614..e2ab034 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -195,6 +195,11 @@ test_bit(int nr, unsigned long addr)
>   *     version 4.12,
>   *  2. it has been verified that (1UL<<2) was never set, so it is
>   *     safe to mask that bit off even in old kernels.
> + *  3. since Linux 6.15 (SECTION_IS_VMEMMAP_PREINIT, bit 5 with
> + *     CONFIG_ZONE_DEVICE) there are six flag bits, so this value is
> + *     stale; section_mem_map_addr() derives the real mask from
> + *     SIZE(page) and only falls back to SECTION_MAP_MASK when that
> + *     is not possible.
>   */
>  #define SECTION_MAP_LAST_BIT	(1UL<<5)
>  #define SECTION_MAP_MASK	(~(SECTION_MAP_LAST_BIT-1))
> --
> 2.54.0

------=_NextPart_000_00E4_01DD46C7.65303FC0
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIbHTCCA3Uw
ggJdoAMCAQICCwQAAAAAARVLWsOUMA0GCSqGSIb3DQEBBQUAMFcxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMRAwDgYDVQQLEwdSb290IENBMRswGQYDVQQDExJHbG9iYWxT
aWduIFJvb3QgQ0EwHhcNOTgwOTAxMTIwMDAwWhcNMjgwMTI4MTIwMDAwWjBXMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEQMA4GA1UECxMHUm9vdCBDQTEbMBkGA1UEAxMS
R2xvYmFsU2lnbiBSb290IENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2g7mmY3O
o+NPin778YuDJWvqSB/xKrC5lREEvfBj0eJnZs8c3c8bSCvujYmOmq8pgGWr6cctEsurHExwB6E9
CjDNFY1P+N3UjFAVHO9Q7sQu9/zpUvKRfeBt1TUwjl5Dc/JB6dVq47KJOlY5OG8GPIhpWypNxadU
uGyJzJv5PMrl/Yn1EjySeJbW3HRuk0Rh0Y3HRrJ1DoboGYrVbWzVeBaVounICjjr8iQTT3NUkxOF
Ohu8HjS1iwWMuXeLsdsfIJGrCVNukM57N3S5cEeRIlFjFnmusa5BJgjIGSvRRqpI1mQq14M0/ywq
wWwZQ0oHhefTfPYhaO/q8lKff5OQzwIDAQABo0IwQDAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/
BAUwAwEB/zAdBgNVHQ4EFgQUYHtmGkUNl8qJUC99BM00qP/8/UswDQYJKoZIhvcNAQEFBQADggEB
ANZz53xPdtCNv+y6or40xSgytXz8bJwsK70JnlO/a16qEUi25Qijs8o9YU3TRgmzPsOg42NVG/K6
76054UO5OKPmL4omO++gUFb5xgr9OM3EC3BRlJeYBN/DX5TVFckUQZzEXXVkFQ3/VTDsho//De8s
uWNG9qr837xp/S4SSGSa4JXwpu8pjwGxFbUMHaX+aSxpJHges6cccWLuysiXrBddisL4R4ZuKsRW
MZXQZ4mFK/lspl1GnQyqguSZUd1wt9tWPWHkauFc1vb+Pd5BzAeuY1K/U1P0K+nH/bb3gl+F0kEY
24GzBBzFH6SAbxUgyd4MiAod1mZV4vxIySkmaeAwggROMIIDNqADAgECAg0B7l8Wnf+XNStkZdZq
MA0GCSqGSIb3DQEBCwUAMFcxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
MRAwDgYDVQQLEwdSb290IENBMRswGQYDVQQDExJHbG9iYWxTaWduIFJvb3QgQ0EwHhcNMTgwOTE5
MDAwMDAwWhcNMjgwMTI4MTIwMDAwWjBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
MzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMKR2xvYmFsU2lnbjCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAMwldpB5BngiFvXAg7aEyiie/QV2EcWtiHL8RgJDx7KKnQRfJMsu
S+FggkbhUqsMgUdwbN1k0ev1LKMPgj0MK66X17YUhhB5uzsTgHeMCOFJ0mpiLx9e+pZo34knlTif
Btc+ycsmWQ1z3rDI6SYOgxXG71uL0gRgykmmKPZpO/bLyCiR5Z2KYVc3rHQU3HTgOu5yLy6c+9C7
v/U9AOEGM+iCK65TpjoWc4zdQQ4gOsC0p6Hpsk+QLjJg6VfLuQSSaGjlOCZgdbKfd/+RFO+uIEn8
rUAVSNECMWEZXriX7613t2Saer9fwRPvm2L7DWzgVGkWqQPabumDk3F2xmmFghcCAwEAAaOCASIw
ggEeMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDAfBgNVHSMEGDAWgBRge2YaRQ2XyolQL30EzTSo//z9SzA9BggrBgEFBQcBAQQx
MC8wLQYIKwYBBQUHMAGGIWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL3Jvb3RyMTAzBgNVHR8E
LDAqMCigJqAkhiJodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QuY3JsMEcGA1UdIARAMD4w
PAYEVR0gADA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0
b3J5LzANBgkqhkiG9w0BAQsFAAOCAQEAI3Dpz+K+9VmulEJvxEMzqs0/OrlkF/JiBktI8UCIBheh
/qvRXzzGM/Lzjt0fHT7MGmCZggusx/x+mocqpX0PplfurDtqhdbevUBj+K2myIiwEvz2Qd8PCZce
OOpTn74F9D7q059QEna+CYvCC0h9Hi5R9o1T06sfQBuKju19+095VnBfDNOOG7OncA03K5eVq9rg
EmscQM7Fx37twmJY7HftcyLCivWGQ4it6hNu/dj+Qi+5fV6tGO+UkMo9J6smlJl1x8vTe/fKTNOv
USGSW4R9K58VP3TLUeiegw4WbxvnRs4jvfnkoovSOWuqeRyRLOJhJC2OKkhwkMQexejgcDCCBbcw
ggSfoAMCAQICEHgDGD3+WNDO2k205RT0B5YwDQYJKoZIhvcNAQEMBQAwTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wHhcNMjAwNzI4MDAwMDAwWhcNMjkwMzE4MDAwMDAwWjBSMQswCQYDVQQGEwJCRTEZMBcG
A1UEChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBTZWN1cmUgTWFpbCBS
b290IFI0NTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBANx5zG0G+W274FYEbH/gdcwt
BUnoS9xU7Ft3lXK/f2KdhamKJFBfU+XbdG+kKVsTKgmtmsUvwvd2O6FFRqpD5iT+K7BvMnAZRlp5
Ji/8PX1fZMtXzGFhqNmVbuOVoG5/RxIY1u8DyfuK+pq9ghWpVXdLEU9Z4GvDcfMM2FTVgWg+E7kV
LoeKPEQnNmIkbvgsBXIwYb1CkSPEnSWn2VSaFKMxrYB5DKdjbJijrFdHMx9lluHQ0jXa+XH3oaYl
tUFd3z5g2NH2n6XyuMwTqo/5sm7hgy2T3T6FGt3osVwmActJhfz80tR/hWKGdPnL7DUiogwwjzur
eetW8vpC8+35H0WJQCmt6pJ06lL9VrQr2qLtdcJuq85SkEv23vBJj5pI1IgZbUXmzIy53WRgYAJA
+LnPvFjrPYW5xgrTnAdmj8cYOSNG4Tweoy9QYZILPSts8aNHOFeRqw2Pxp1NBNImUlzlpf0qLRYq
AWnnqX3hNrexKsXZsY29uYvOzIuhPgtIzVCVNMTYCFnYayb0vvXUIhcAV8mumwQwM58L+99Woslu
VHbasZdiJ1kPEYoiG2SWP6jxtyRKjTxTfG2Ddj2yJkhz9UQWAS0JKo4WllDQcwZduyJIgkwKRlo/
gP9c8vKarCwI4Nbq8BI4gU+mEO1Gq8wWnAvPZKaZAoVEZ0at/U3nAgMBAAGjggGNMIIBiTAOBgNV
HQ8BAf8EBAMCAYYwKQYDVR0lBCIwIAYIKwYBBQUHAwQGCSsGAQQBgjcVBQYJKwYBBAGCNxUGMA8G
A1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFKCTFShu7o8IsjXGnmJ5dKexDit7MB8GA1UdIwQYMBaA
FI/wS3+oLkUkrk1Q+mOai97i3Ru8MHoGCCsGAQUFBwEBBG4wbDAtBggrBgEFBQcwAYYhaHR0cDov
L29jc3AuZ2xvYmFsc2lnbi5jb20vcm9vdHIzMDsGCCsGAQUFBzAChi9odHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9yb290LXIzLmNydDA2BgNVHR8ELzAtMCugKaAnhiVodHRwOi8v
Y3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjMuY3JsMEcGA1UdIARAMD4wPAYEVR0gADA0MDIGCCsG
AQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG9w0B
AQwFAAOCAQEAOvlzQO2Pez2rAiyHFDhN+zIE3IAHKOqW95dgxyJ9V3UxPSBeZXXZkKQY2kO9Deov
mLViMFmf8R/ne8o8wnaznibmnwJXk9q5bnEFA152ZycgVneRnYzLOBWwhYlkoCQ8sZigV0uF9rCW
p8eJVbuF43YVo+7hRUdSeA4VOBBi/rzTJ5EQ93c8jdu5rXyxhGfl3NQWpXSudtTqLa9NbVDAx6TV
Pz1zq0+Vfwn4/FOfdhRDPPGFhHOp2YORVrkWlQcSW6Dr6Y7qPsbJFcJFE1qLhBJJ3vhy6Ex6Jegf
5moEbkl0TMRcwmlIpuWEPTwoiQYYVL3mNkUHH3nMous6itfAljCCBsAwggSooAMCAQICEQCC5e3V
cwjUz2NrpgAMsxccMA0GCSqGSIb3DQEBDAUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9i
YWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIFNlY3VyZSBNYWlsIFJvb3QgUjQ1MB4X
DTI1MDIxOTAzMTYzMloXDTMwMDIxOTAwMDAwMFowUzELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEds
b2JhbFNpZ24gbnYtc2ExKTAnBgNVBAMTIEdsb2JhbFNpZ24gR0NDIFI0NSBTTUlNRSBDQSAyMDI1
MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAvWrJ+NEJF+jE9RNhVRk3kBjjbta/YE7s
NJrlayyFOOTLtu30cRVAI24xWK0ti2bGAh1g7Urm+Oq4VD8xW8wN2eSSRQFK0h3LyK2+ROiVmKJB
Nvr952wHOsAv7FkOf+nCaDzoh+85Gj+XBCy9RLZNR7DQsHjvEqlQCz3jUe9wVaacPJyJnm1raIJn
icUNsO3Ydwf/6z1Envv052DD89F2PDEKDuF3G8WcisRVNx+PUqP11WDWjLaZPRaHXqDENBGE+hJ0
E/QH9h4VzhuUdu3fuF2CU3jn8IwIq4gvmvQTEOmBqoIO9RNliBs77IlrPezVCrTL3NbfEXQEK/r6
j4LiWideegtH8WrpyRKDCrVvt05mIxO6VGybK3ixAO6LylnbKhIFZVJdgpa2RfOVsWxUTQEPRz6L
UQTnfjmcvNG5QZiE5SMfshi59ZiesdA4jXehuRVvDQE2bL4LTSiDbJT7vw4+Mv/R/4t2vaTgaCA0
2z6vx9byu+msz16SJN1nvGFuZl5RMJB8Iwg3pYMYN2b3kPOpSe1zLRqiEO6bcVvDTdjQLR3LufdN
V+J4NmFS8y/LAEud0S/ClW+OKpgkniJexs0kxjCa1imjHoKo9WMK3G/56MfuCGliJ+yy7bTdEBto
owzkC7+hDj1uVpXbFVnvxTyOXHylfGZLe3x6uTxGs/8CAwEAAaOCAY4wggGKMA4GA1UdDwEB/wQE
AwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQBgjcUAgIGCisGAQQBgjcK
AwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdDgQWBBTZ
pKAnywokqjGqQ31zcMx/tSW7kzAfBgNVHSMEGDAWgBSgkxUobu6PCLI1xp5ieXSnsQ4rezCBhQYI
KwYBBQUHAQEEeTB3MDMGCCsGAQUFBzABhidodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9zbWlt
ZXJvb3RyNDUwQAYIKwYBBQUHMAKGNGh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0
L3NtaW1lcm9vdHI0NS5jcnQwOwYDVR0fBDQwMjAwoC6gLIYqaHR0cDovL2NybC5nbG9iYWxzaWdu
LmNvbS9zbWltZXJvb3RyNDUuY3JsMBEGA1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOC
AgEAsMLFu+o4sROEpzNAGqtVI4l6kDCkVAUhjqgWmSpayAg0Nh1y/u6BARdLGRvqaA+4eofWwln2
I7/JC89hwY5SDwr9N5zrUt7fxtIy1O59LkqrVqtZBhCBJflA8jojsnYFhi0DY+30y15Ct6xXoGbJ
rxMucbgUYLBeOtBE2fAYBnHlOnWnoISv3/UkhH1OGk/cDwBDWTjsGbBNPqhXfFTSzYGDXXSMelCK
BH8iy9z1Y3iweUXdads8LRrB/jJKiPFg0IKvtZ0F2W0XbaSTI6viNs9yCuhGVkVcvI5969bXaURu
afdrsBc/b5BDGbhLoLMrsEMJKTXxRSWQo9nucFxRBsOvrwmF0Jqajk31yCj0gNxhq9DxFIxB8Hpo
uktarijPZWMdQdSC08N+7yeCirXFBTWNwLeHFdSJ1w5DiiEPRJvQz6wSVdieYapQZjZBsssktUTU
PB3c57A/mLOohUGdV/R+n3LV8vkifmaN8qeUZ43vaWf9BKUREANEgZeUH4js3dY+ARsb7hhXLcyd
JsxpQ380xJkCK1ZTOG379748LgMorFiGrE0ALamNIpX6VrjiOIpxu/dhb91OTRTa5ioKu0oTjxR/
ApVx+fNuJd0DwsrRgOWyf+hsUTCGrc80nDX1inhpkxZLAyTiYNBuE7bP0tdmXh0jLvuu29HU4PJi
X+IwggbPMIIEt6ADAgECAgwc9H1d6WHRdK2m1hwwDQYJKoZIhvcNAQELBQAwUzELMAkGA1UEBhMC
QkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKTAnBgNVBAMTIEdsb2JhbFNpZ24gR0NDIFI0
NSBTTUlNRSBDQSAyMDI1MB4XDTI2MDcxNDA2MzkxMloXDTI3MDcxNTA2MzkxMlowgeQxCzAJBgNV
BAYTAkpQMRkwFwYDVQQMExBORUMgR3JvdXAgTWVtYmVyMQ4wDAYDVQQIEwVUb2t5bzEPMA0GA1UE
BxMGTWluYXRvMRwwGgYDVQRhExNWQVRKUC03MDEwNDAxMDIyOTE2MQ4wDAYDVQQEEwVIQUdJTzER
MA8GA1UEKhMIS0FaVUhJVE8xGDAWBgNVBAoTD05FQyBDb3Jwb3JhdGlvbjEXMBUGA1UEAxMOS0Fa
VUhJVE8gSEFHSU8xJTAjBgkqhkiG9w0BCQEWFmthenVoaXRvLmhhZ2lvQG5lYy5jb20wggEiMA0G
CSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDKuiBlmNPtapAtHdggySGKKkFes02rTa0XxDr0DFZH
PbaX8pRTH5AL8v564OoPCb6v7GTiR01S9RKRT/UCDV/heMw1Jwx3KdCWnCjGBImucVnGd9HOKWzd
6uFNZ28CqYfVFxJxqn/w9r4+zbO336MCGVDsFzsZNuRkxRlgLe0sk4UVCF46uztTNrxO+8uc9WIy
clM2KS9n3bM5MI27+tRHNMNat6m21DBRdsZTowPUWI4qOZqFfXjKWMKv6Sj+YFqcnCV7eG0NYnGw
QLmevTnFYgWkMQxlu0fbCuIawW5e5ljjT9e13WFq2pTpwreKrkTBVhrt2J13Jqfck2sUjRURAgMB
AAGjggIPMIICCzAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADCBlQYIKwYBBQUHAQEEgYgw
gYUwRwYIKwYBBQUHMAKGO2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2Nj
cjQ1c21pbWVjYTIwMjUuY3J0MDoGCCsGAQUFBzABhi5odHRwOi8vb2NzcC5nbG9iYWxzaWduLmNv
bS9nc2djY3I0NXNtaW1lY2EyMDI1MGUGA1UdIAReMFwwCQYHZ4EMAQUDAjALBgkrBgEEAaAyASgw
QgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9y
ZXBvc2l0b3J5LzBCBgNVHR8EOzA5MDegNaAzhjFodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dz
Z2NjcjQ1c21pbWVjYTIwMjUuY3JsMEkGA1UdEQRCMECBFmthenVoaXRvLmhhZ2lvQG5lYy5jb22g
JgYKKwYBBAGCNxQCA6AYDBZrYXp1aGl0by5oYWdpb0BuZWMuY29tMB0GA1UdJQQWMBQGCCsGAQUF
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
X/G77iidAAAAAAAA

------=_NextPart_000_00E4_01DD46C7.65303FC0--


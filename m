Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BB2CED618
	for <kexec@archiver.kernel.org>; Wed,  9 Oct 2024 07:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gHhHJeJG0xtIL5+ijxHdGOu1pjSg6K1nd+NtIQTlQ50=; b=I5nnY7dC31lFYL
	VWWPltPwIS4d+9aQOPAzT8F5JtVOSHn0BAqutiNFAJu8GenwX2im2o5A3GNok4xt7ON88cBijxpKa
	KJOF7k+AI0HgxhExYGC9LmkiUAoeouc9bYAM7y1rbXJgjsB85X5eZNmOhRxliib9LEwCCrnzWV+iC
	OQMN5W4YF52UTSqFavk7zF6kLhLDQE2mINZeB/UUx+Mav4vEFibRE2Ibaf04Rle4U4VMdalnxKtwe
	PkC6PG040YeC6SCKUNK7XYC1WyNN4HNfbENHLZvywz8N0GV6kzYzuwAHHGMlGFsZhCyWimrCW2hQa
	vXZwZlp/aB1Nabkq5hGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syR6x-00000008EEy-3ZFJ;
	Wed, 09 Oct 2024 07:27:55 +0000
Received: from mail-japaneastazlp170110002.outbound.protection.outlook.com ([2a01:111:f403:c405::2] helo=TYVP286CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syR66-00000008E5P-0lqJ
	for kexec@lists.infradead.org;
	Wed, 09 Oct 2024 07:27:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDILfVRRQq4M21inEQX2XntxdnhToQ7pPUZ35NfJOHDhGAMj2Jl2ghHkdGF56Exr2yskoZd2Q+y5G0XBB51JAUEJj3ob9MATRNhUMU5azE9+Gnbvn9VTr6JyCdw5sICnXY2TPf4KwAi4tO10qh7S4aSx9BoSxQZFCH1AvztSwhw06YrPNU9wSWz4FHf67JcU1sxUkQIQAa0/o8IwVGvzckRaZwFfPw9qC2nHcQRiEo5I6/YYGiqTF1BCddH2k4YCoyOr2Ui8bpHbYczQ7o+9aClAGEIKgu+sk7H4h5f4wkg9iAC6i7rma7DAd0EB4umsFGD5ZM7rvm1CG1AcVlw7nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUf+0a2MUA6jESqtsM3AOm27R+uIla7BKAVAUsgl/3c=;
 b=FqnX4LqyMfLhARqrVy5qtfelnXkXWri0SYzKMAQ215+PaePaZbRWCNQjeqzkUQcicYugL259zqIN09LTdLKNlZkNPwPkHm5fkaV0GnXvfmby7T4x/9qHgBLXTut7gR+Bt3qDkvbbygVmfUXfAWPBu3cooS1AmQ6GRPEbv6+vRnj2cxDOstuaTDIrhMeyoora5mX+/UN0bVZugQu1s96luHk3KGo1SmrZbZvAamysQuQj7pq1O6H7FGLxE76832W+n98P5cwr1oLuJ/dXP4mJw4KY+vUHXO1vn17x9yIyTBOrK3xEOUOxSHhUnbdxgPCoIs1ZhwsRs9vh5ZsAWxP1cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUf+0a2MUA6jESqtsM3AOm27R+uIla7BKAVAUsgl/3c=;
 b=FvpYpo4NjrV0D8rCqGb1/z7B75cCRDVfq9keCE3qTWG1HVhVP3GKE8eYMdYnZBGdLGpCt74kD6w3nt2zqlGhXklgL+IncM10MTEW6ENvzlNBr/hycOIxwp151C6lOP4znPVStv7jpdHkh/8FJsOFGyxi3EPbaKW5dW6QGMtP9cBE07tN4svMPqXmkD8lr8Q1yO9ivgiiwotWU6WatrzhF1wJhrlw0/FWUHnR51tqYG9x+cat1ODNwiau+edp0DuvfU60nPbPKLwThw6l9nDvyXDgz81h0Bz758Q6zGLa3wEZ8eZZH0D+KAyIfxrzPhRGKzvbBNzlaxMiWwKVmTyKDA==
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com (2603:1096:604:1de::11)
 by TYCPR01MB8469.jpnprd01.prod.outlook.com (2603:1096:400:156::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 07:26:51 +0000
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66]) by OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66%5]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 07:26:51 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Ming Wang <wangming01@loongson.cn>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
CC: "lixuefeng@loongson.cn" <lixuefeng@loongson.cn>, "gaojuxin@loongson.cn"
	<gaojuxin@loongson.cn>,
	=?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>
Subject: Re: [PATCH v2] Fix: Exclude pages correctly in exclude_nodata_pages()
Thread-Topic: [PATCH v2] Fix: Exclude pages correctly in
 exclude_nodata_pages()
Thread-Index: AQHbGhFvwQS9V7MUckCYdhsJsh3/PrJ+BRMA
Date: Wed, 9 Oct 2024 07:26:51 +0000
Message-ID: <04f32cc9-4fc4-48f4-8000-b5e0a07a3e92@nec.com>
References: <20241009060635.1799444-1-wangming01@loongson.cn>
In-Reply-To: <20241009060635.1799444-1-wangming01@loongson.cn>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9993:EE_|TYCPR01MB8469:EE_
x-ms-office365-filtering-correlation-id: 4a36ef62-d30d-42ce-13b8-08dce833be70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Ulpwa2NOUStXZnpEWkg3b3M1dFJtd2c3V0lrTjBzWmtZenk3Y0VFV0pManFC?=
 =?utf-8?B?WE9hazNtMjF0dHdCYW8wUDBrdlluODlvQ1Z5VVlYZ0RLeFhpZ0NiaGRBL2Vi?=
 =?utf-8?B?TGdqcHBrV09xZUozM2psVWtYWjRWeEh2dVJtWklXYldJRTMrcUplTUVnMVhG?=
 =?utf-8?B?MkZoQW1MTUh3c3JESXNscFk2L2dmZ3Jwa3NENWorK3V5c3IvLy82bSt4UUNH?=
 =?utf-8?B?Y0Ivck4zcE5CZVFjb0VyY0IweHEyL0I0RlYrL0ltQ2hFRkFzSmpRS1g5aHo1?=
 =?utf-8?B?MzJ5MktqSXN4QzBSVWVRcjhlN01ZckVEZWgzNWE1aXJzVkljMW1zWFN4aE1p?=
 =?utf-8?B?emRMeXg5TkVsU0RURitOSE5nUVR6bUxXc0F3YzluSDd1cG8xalpYVkE4cGl6?=
 =?utf-8?B?RWJiSEY5cE1uRFZ3TTR5RUVUTEZsZno2TE9NVFZpNnFWb2RXL3JhSk1BTy9H?=
 =?utf-8?B?NnhqZSszZ3dNUnpCS0tNVWhpTlc4MW91RzdiRWg2dktkS25SeU94Z25QdXVx?=
 =?utf-8?B?bG1RdHBjamVMdlRzYVlFelRRTE5GNzNYcU8yd2JSYkJSVEMwMXA0MUNENUZh?=
 =?utf-8?B?Ykx5Qk1JcjFPaExjWVF1SkF0ZlpHc0VmWDc0NVlDOTBDRzRMUVNzeFN4RDZB?=
 =?utf-8?B?TjBvQU5iRzlHcDA0bzlMcUtHWnRzTGNYUm1Jc2tBNWI3S09QQWxoVjVLb1Nr?=
 =?utf-8?B?QUNabm4xWmcrYTM3MVRpc2h2OGQ5UmVDTzlPZnF2YVJxS1ZpeEp4anJYR0JC?=
 =?utf-8?B?a3hCTGxLRHpaZmpabzBqcklXNDJkTW9MalZWbVFUZHJqbGVtMXkzUlBybTVI?=
 =?utf-8?B?cVVQS1JmN3hsTHRPYmxRWThXQmxBY2V1a21maTJKRHF1eXFMTWljUHUvVC9p?=
 =?utf-8?B?UEVVQkdMWldSU1ozK1BBZUk2ZEhKdjJkbzhuN0pXZ0RQUk9PQi9rZzNGcDQ1?=
 =?utf-8?B?NUplS2lBMmVDNXlCNmJSV2VXZ2JVY0RhM00zbDAreFZJenBsaUVCeGxOUUxp?=
 =?utf-8?B?SVUzWDA5RVZKalIzUEZ1SCtkVVNocCtXQUFwM1c5VCtwWnBGWjFkc2ROZk5w?=
 =?utf-8?B?REJsTytrQW80NTMxa01sbW5pSkkxbEJPSnVCUUxFdzNUelpOdWppbm5MWTQw?=
 =?utf-8?B?OUNBU2ZlQ2NjQXhXaXpvK3JLV2lYZ2U3d1FHbkkrcUE5ZTB3VHJFK2Q4bmNi?=
 =?utf-8?B?bXc2T1dnY2JFc0ptTTBFdWlIRjJGTWgyQUV2czM3Tk1EaXNxK2xvSFRQeHFa?=
 =?utf-8?B?VmkzbFVSRkJSZ2tTQm9zcGYvOXlIeTBKNVI3VWR5VHZ6RXRRcitlVFZzdUJv?=
 =?utf-8?B?UDlteXJoZFJjQWZXV2dNWDdSZWRIRzZHeWhva2pscEo1YlJUQTY0SU9KZUNv?=
 =?utf-8?B?elhsMm9JVVc5emkxY0tmb3NlcWlQZFVJbEpEbW1SNDI1MllhVDZqbSthYlBE?=
 =?utf-8?B?VXRSNG1SYURlQnRJTkdDV015SjBkY1JKQVRqVWtTbU5CdmxxRHBHamREUGkr?=
 =?utf-8?B?cGpTRzJUY3MwR2h5bytsWk5yOWxUOUQ5OHVXNVlTZEIydHFaZ2RqRjVqd3pw?=
 =?utf-8?B?ODIyLzZRSC8rZWZqdW9QZ2ppTVN1djJhTHduUEJ1NFdMY2ZYRmhyWDFiRGQ0?=
 =?utf-8?B?NHE3WDJSemt2dlhPVUpLbjQ2RDM4c0loOE5TcXFNUGtJN1ZOU2g3N0M4eFFn?=
 =?utf-8?B?Wk9ZV0VIZW1mL3MwYnc0UkkzcWRNOEFtY3NoRWRwcURQM2ZUb0hZY0pvUnl4?=
 =?utf-8?Q?wg/gKDgfJToHT6NNe4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9993.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkljeGJObkhuNytLaE5uWWdTeXpNRkVvcElLTXpmRTJUTVBKeFo0bUdPdUxk?=
 =?utf-8?B?Qmg3c2pUQ2o2eGN6V2tWdVdRcU9MTWFEaFVLZ05KMXR0eVk0V0ZXUjJKaXVH?=
 =?utf-8?B?K1BnZ3FSWnBhQTgxYUlFeVBXSzJROXI3aG0wMGtLKzJ0VUdENVhIYWs3Um5X?=
 =?utf-8?B?RzhabEdPTUlLdERTbUlGODRnZ2dQbmJXd1RiYjJhb0RLWXpVWXNKT3o5eHIw?=
 =?utf-8?B?SlVud1lZM1hvcHBEMXY5TXFGa25Mb2w1MjZkZ1lKWUhTWDFUcjFPSzVZL0tS?=
 =?utf-8?B?aFVZVEtmQ0ZGdWpmaXdXNXdoaTNLTmRvWUNZdHgxSVJEQU4rMC9kUnhWM1RN?=
 =?utf-8?B?K2lBNDZkYVBQQ2JJOTRzcExIOXJRNTd2VFZyNW1SR1ljL1g0T2hPOGQrOUkw?=
 =?utf-8?B?SmZjdmhvdS9CckdQMHlkdVh0Y0p0YzRiNG1qcFoxaDFWOEsvWjFEUVF5WXR5?=
 =?utf-8?B?NFNPY2tEWHRqUVBGVFJ5eUZ1Q3lUbkhwbFd5V2tQU3RXOWhnQWpsRis3NjZO?=
 =?utf-8?B?NWtNVTBPUGNmbUhMMkFtSFlMMHZYOVJuYWozUTQrWFhDTGlxdHF5WmsvTE96?=
 =?utf-8?B?QmsydjR3MTdtWnNHZEhiUEljWlVZWDNBRFEvVWhzNFFCb2F1aVN2SGl6S01Z?=
 =?utf-8?B?VTlZVkVOWEJRcC9PTEloQWFOY3FIbEtmTU5jZEJDQ29wSzZaU0RRd3N2R2la?=
 =?utf-8?B?ek1HdG9IaklRaFFSME1aOWlTOVZDajZCN1dGemVUYUkzdHVoMG1SWlNKbnc0?=
 =?utf-8?B?WGRwQVQ1NDN3dEQ4dk1XZWs1NFRSVFNnQWlvNlZmK2ZKOGpFRDRnTzNVSkpx?=
 =?utf-8?B?Q3djazRlcVJDODJOWUNLaUM0WHY4WjEra096c2pxWE4zcHF1U1Z3RVhUSlkw?=
 =?utf-8?B?K3lrdndiYlllTlpHU3FhMTdST21TOGRzbGdPZ1MvZUVJYmI2ZGpQZ1VBc1J1?=
 =?utf-8?B?eDBSeTd1MVZycVVNOHJKSWFBRXNNR3V4bVhoOHJIZXhwWlRsaGZyNzAvQnlC?=
 =?utf-8?B?MHF6ZWVhM2FQZVZnVmlyRHd1RVJKQUdsNlV6RmxiR1g1d3Y4bWc2RFY3QTBF?=
 =?utf-8?B?YVc4ejNxYStHdTFxdEtnWWdXQ01BT01pYXNCaTYvVFFKSUVodVNsTWNZYU1m?=
 =?utf-8?B?eVpvb0JCUy9kbnJvcldMalh1SVRJajdpUXJZT29YYW9BRlk1UVlyL0lPYnhX?=
 =?utf-8?B?bm9tTTBmd3hab0IwcXBMRWxvRERaUnZCNEZtRmtNSTlhN0YxTk9rc2phcThm?=
 =?utf-8?B?b0M3ZHhjRXRoQk9hSVFrVENPZitMRzJxQml2TnkxeWhhYklwTDI3S3VPUm1Z?=
 =?utf-8?B?ZjRXYkdnZWdsQVJ6VHg5NE92NmdqRTNjdVNEN0MvM2pXV0UrK3Z1YjFTSjAy?=
 =?utf-8?B?SFBvbzEwZTh2Mnd5bTF5VDE0YmJUZUFBb0JDSVQxa28vUkVIVEtpM3Q1ZXZJ?=
 =?utf-8?B?cm9aKzg0dU9Cd2hYRGdIUFcxdWxZSWlhanF0L1F1a2I1WUZaakV3cnZyL2pX?=
 =?utf-8?B?cExlRTQ4Y2RQVS90TWFtR1JqdExFb0hxNW0vRmZUMDhBMEdjaTBvODROQ3hN?=
 =?utf-8?B?UGEwa05Ia0sySktKTFVXVWF1c1hONEVhQkhjbTdxd2lEaE4zejd1OGRmRzVv?=
 =?utf-8?B?OHppeFAvc2FzKyt2SHhtT0ZHa2tZS05pbUdPNHVXN2IybkdTbVE0V1RtZUxr?=
 =?utf-8?B?TnU5c0FmV25zVzhGaFl4ek1zMjNnWWpHRzl5R2dKM3l1N2JWU3k2NlpYa1Bu?=
 =?utf-8?B?R3dmTTdQelhLb2g3bXI3MmJaWnhZUm1iWU1PbnNOd3VtWjZsb09OZ3EzL3lX?=
 =?utf-8?B?TU5WYzNOY2QxandVcS9KYjdpQjd5cURXQytrR2lMNmR2NnlTTFJXVHJFQkh5?=
 =?utf-8?B?ZysvYk40OEJUUWo1bTQxZkVWNGJ0ejZKVkxoSjVIckRqTXZRVjNOSlVYaTdC?=
 =?utf-8?B?YXhzZy8zc0UzczBGUEpOMGx5ckdOcHNGWkk3OUI1TGxLd0dONCthdng2SlJk?=
 =?utf-8?B?SmVvMXZpeEk2MHhUU010RitZNkgrR0lieVlMVTJnT1k1Nk9xN1NZdWtnZi9o?=
 =?utf-8?B?bW9VVVlkclRNdm5teWloanRpYUhwdTBtbm5CYnc2MGVDUnV3Rkp4a0ZMZllx?=
 =?utf-8?Q?PQa3W5O3f75OMOPg0DVAWDNjt?=
Content-ID: <0029F65BBB434844A70CF7FFEABB9D82@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9993.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a36ef62-d30d-42ce-13b8-08dce833be70
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 07:26:51.5529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nbL/LIveA+o5ySAB8eSDttkDmI3jeiQ62ks5XUO39noG7Qx7iuMtLimOx/pcMEaQdFl786kDsHwzKNSkdB3GOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8469
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_002702_422224_040D35E9 
X-CRM114-Status: GOOD (  17.92  )
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

On 2024/10/09 15:06, Ming Wang wrote:
> The calculation of the starting PFN for exclusion in
> exclude_nodata_pages() was rounding down, potentially excluding
> the last valid page of a LOAD segment.
> 
> This commit fixes the issue by rounding up the calculated PFN to the
> nearest page boundary, ensuring that the last valid page is included and
> not erroneously excluded.
> 
> Signed-off-by: Ming Wang <wangming01@loongson.cn>
> ---
>   makedumpfile.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 2fa67e7..b356eb3 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -5215,7 +5215,7 @@ exclude_nodata_pages(struct cycle *cycle)
>   				   NULL, &file_size)) {
>   		unsigned long long pfn, pfn_end;
>   
> -		pfn = paddr_to_pfn(phys_start + file_size);
> +		pfn = paddr_to_pfn(roundup(phys_start + file_size, PAGESIZE()));
>   		pfn_end = paddr_to_pfn(roundup(phys_end, PAGESIZE()));
>   
>   		if (pfn < cycle->start_pfn)

Thank you for the v2 patch.

I confirmed that without the patch "makedumpfile -d 0" excluded some pages wrongly:

$ makedumpfile -d 0 vmcore dump.d0
...
pfn 0000000000054000 pfn_end 0000000000054000
pfn 000000000006989f pfn_end 00000000000698a0

crash> ptob 6989f
6989f: 6989f000
crash> rd -p 6989f000
rd: page excluded: physical address: 6989f000  type: "64-bit PHYSADDR"

and it didn't with the patch:

$ makedumpfile -d 0 vmcore dump.d0.patched
...
pfn 0000000000054000 pfn_end 0000000000054000
pfn 00000000000698a0 pfn_end 00000000000698a0

crash> rd -p 6989f000
         6989f000:  cccccccc30646870                    phd0....


Tested ok and applied.
https://github.com/makedumpfile/makedumpfile/commit/f2c5f761ea99dbacaaf988caf1d51bc142b353fa

Thanks,
Kazu
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

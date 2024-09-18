Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67C6CAC5B2
	for <kexec@archiver.kernel.org>; Wed, 18 Sep 2024 01:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wGZMQb/euhCuqphqXpkgEVvwsipHfGVL8EO6b18SwL8=; b=iWm1wQIXocNUOT
	YgcyaQvar5cgAEaExq7/g+/qj62LSDQY+iWpHSKM7mH1yfhVxzQXn4c0ItjDGVG2BDkf3vMlj6tiH
	JIsaK91If60x4MB1m345xAciwp088CRjDRoOPd1r/hVFH+jKM8f05o42ulw+80iOrfMAPbRJvf0bK
	DY575mZVckGj3BYDyCTZ4Lu6+/mYsTcOTb0jLyGORFUWRXYsrZ+9wPfNLoHaOo8Khx0dMsOt6MV0D
	fRvRH9qwnukZozG3mjjzFcRzJyn6LrprlEDRMMO3Qgz56O7yYq1ofBNfoTcXf/XhFNBxNMT0Z+h3s
	Iucx13+TsX7ew3bbq6hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sqjCB-00000007EoJ-0Duq;
	Wed, 18 Sep 2024 01:09:27 +0000
Received: from mail-japanwestazlp170110001.outbound.protection.outlook.com ([2a01:111:f403:c407::1] helo=OS0P286CU010.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqjC7-00000007Ens-3MIM
	for kexec@lists.infradead.org;
	Wed, 18 Sep 2024 01:09:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cqc8hbva1EIpUJAeBmg2oAbb/8mIi7q87vZ9l+l9Qwy54w6Nk6rjT3mB1nTz/1Alja84f9l7nNcmTn6AXSrgbBufSycrvE0RPvxCfMzNlRRcZ0BMgJsI04oeELNWaOGuIeWbTtQfO+VOJd8TM/zehjcGDmX1R8MandfcchGCUdVyqgxYuSjlkWCCcOigtbFgmz6E8uODYRUw+TJHm2AhZuy1rVA4H1ZeJVv72h1bVeAFWC/whdMjkDXXV0xK82f0ck9SoraMTQftpmOwoH74GYyn+zmNo7EBQ7+7dLZHzaXbm+niSIYO/9KAJx1h5haCDxX1BR9bK1JRAPzoOG5BNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZKYS1A/SS/TeYy3MSSxXdgrJKBkicQ9g0RYFOHYXak=;
 b=Ya3lmujUkqxK3N6CcXXWeiXHkk1CEyRw+tUGvMlgKlTy938SUG1L6HYUs/S7BnIbV7mYng2A7sCQ0oReY+8pLhC8f1TegDcYSi/FOSjl3fTfyX3kkBtk1tjK2uzaYdkzrgSiQUJ7Hy7UIJYI2M+9zM1vBdWXykT5p5PKQq4nwf5mlIxTjIj1ew0MgaBj0AjbuqXJ8eYHixvx4RwjEoOieq5cvToTlnToY9ECls9STVprUWCKHKZLQqb8rQtADqvXk9SQlX5vlKzZBBExdHn4biijbLZCH4CspqTCbej8eWmYgaxWapNLVvbxi0z72CxOBGfMNN85Mu1hs2J6GcJ8vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZKYS1A/SS/TeYy3MSSxXdgrJKBkicQ9g0RYFOHYXak=;
 b=P3EDngOHZ4DCK/OkuwYMFfvg+aKGrKsjAbX4Fm8m/8YzlcQrgXE1RZdgkkMUO48mY7bQY4gnMND2rxmGb9nbzYRYnRevQklxGnnCgHRwozjj155+KIqF80rLOuMhUYvwhqhy8xATGpaTaJgdJu1/NjWacf8C0ldU1U+5+2ua8ha8rAav9XJJAxD3N3CpI4OH6rh+vqaZ8hnxeryGfj9YqT6V2yN3aEROhkeZ/V1MGo9yLPu8IIayI5SpvcAbnFiZIW+y9KoTa9YjUUah6SuxWGbqnzm6FR2OjoRviQWk5Ey5jBhXNnhcFsO2YLB3wY6UUmYfbr/l/rvkuI6oJBQjSQ==
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com (2603:1096:604:1de::11)
 by TYWPR01MB10822.jpnprd01.prod.outlook.com (2603:1096:400:2a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 01:09:07 +0000
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66]) by OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66%5]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 01:09:06 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
CC: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>, Philipp Rudo <prudo@redhat.com>
Subject: Re: [PATCH] Submit physical address to is_phys_addr()
Thread-Topic: [PATCH] Submit physical address to is_phys_addr()
Thread-Index: AQHbBeonNdlKgoyVJ0OI1cxQ+DCTAbJcwuIA
Date: Wed, 18 Sep 2024 01:09:06 +0000
Message-ID: <1ce6bdc0-2f5b-4d39-8d55-d352b697fa35@nec.com>
References: <20240913143500.3615218-1-agordeev@linux.ibm.com>
In-Reply-To: <20240913143500.3615218-1-agordeev@linux.ibm.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9993:EE_|TYWPR01MB10822:EE_
x-ms-office365-filtering-correlation-id: d9e69478-1a32-4b9a-1530-08dcd77e7e97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?b2RienJobkJVRklUZ0J0bXJ6WkNZQ3F2VmlFR3Z0OEt6eGJKWXZZZ1NUZlA0?=
 =?utf-8?B?RjRFcEVlNkNYVUVMdlZSVlBvVDFBS2lqc05XTVkyMUVDbG5PWXBZcE1mSW5M?=
 =?utf-8?B?UFA5dFB3b3NEUHhLdWxNUFJyWG5lQTRrL0JVZTc2MlBxeVNBUFhPcm9DcSsy?=
 =?utf-8?B?Q28xRzdQaXg5RTdBeXM5Rmx3R2J5SWo2dGtHS2ZyZFZnSW1HdnRhdUdnbnJO?=
 =?utf-8?B?UVVmbWhBWmtOTGpYMmZUTXdRZVo5V3V5TzJKZjlWOXE0c0k4dWhZZnptMlY4?=
 =?utf-8?B?cElPdzhYaGxBaDFuWmZBc1F5M0tuc0VkakNONjU4ZFFIQm11V0lwUXVsckxW?=
 =?utf-8?B?Z29EdForUFRtdnpvUjc5Q3lFVnJVVXZVUkUyblBPRVRoTWQ5L1BrMG1xQUpG?=
 =?utf-8?B?NWx6WnJEWk9UeHYwcmZ1OEl5MHV5eko5Z2FsTTYzelV1cUNWaHNaS1AzKzI5?=
 =?utf-8?B?TVEydXBFMGN3NWRaTXY4dFMwWUtyeGlhNmJ2emo3KzRjdGY3dkJJaXV0WldP?=
 =?utf-8?B?MGRjZUxCWURKYU9FMU1hdTl6N3ByS1RueU1vUTdubm4rWXdkM1lRQnJUNFZJ?=
 =?utf-8?B?VVVLZTJzcGdmbXRSKytGaXJIYWs2T3FXWkEvTEdxMjNRR28vdEhSdXFpNzJp?=
 =?utf-8?B?T3RpUmgwNmNYbjF2YUgzREpaZEdQL3E5M3BuVkRmdEYzVHpkcUFCVUE4Ymh5?=
 =?utf-8?B?eVpoYWxZbFpiWUo5aGRXN1ZYbEVGNGF3U0NrRVAwVGVtaENEcCt1dW9OQjhE?=
 =?utf-8?B?aS9Mbk42c3Q4M2s0YlIrWTNFMzRVWnhLU2NZUXFlb1pHTHp3c0owdVZiczNN?=
 =?utf-8?B?d3FqWSsyRktDTFpLNWRrdjMzQURiQzd3bVkyRWNxamZGbjkxL2dqTkE0M1h4?=
 =?utf-8?B?Uzg2S2FZa0tST000K094UkZhVC9aRXdiZDlQNlRlanpZK1pUcXNvVHJKMVRS?=
 =?utf-8?B?S1ltU3ViWWFXRGsyUXpna0tWNGtPaHN1N2pUZGhoMENkOXM5VGxGM1F3UE40?=
 =?utf-8?B?aVBDWlR5dmxScUlBSThMUkQrZ1Rza0JnNWE5YVdtcFlSdTVreE1zRmNxUzFO?=
 =?utf-8?B?anE1SkNoanZpTG5DY0NTRVpxM0tJVTVIZDgvdmVOeDd5UDRPZzdFRUdHRFlM?=
 =?utf-8?B?TVUrQnBHaGNKNVA1KzZUc1VTckZQUFBiaDFwbmNXdGZsMk11WC9PbDZnaXpq?=
 =?utf-8?B?VEw4N3JQN0V3UUpSZHRFcWdLMm5yeVQ3NmJmdHNjTmQ4Vm1yL1pLSC9Mdys2?=
 =?utf-8?B?TE8xUnRYUU4yMjRrRyttaVFtazVlMnRDU2tkejhkQWV6OUtDTHFlRnpQQkNU?=
 =?utf-8?B?aE9Jbk1JaUIzSU9paTg3RDdMNGhieGlEc1l4U3AvT0crbzlZWGNScWhueEM4?=
 =?utf-8?B?akJtTENCbUJMZmw2b21YdVBwb1NBYzNiclhFQU1rQmxjWks0UExOSEJmWXhl?=
 =?utf-8?B?N2JSWmlnbnIvY2hNYXowTCsxRlpZajVIdHhYWE8zeGV0NjE4bUZGNDB5VGoy?=
 =?utf-8?B?R09FYTJHNGhsWjhUOUpqamFpbUVEWTNrdUpLNGNoTDU3WExmaGRpcjE5UExq?=
 =?utf-8?B?b3h2NkdWV3IyMWFkRzQ5YjJlZ1llbjRoQzVxZmlZYXozYkVVYWJXRnFMSGE3?=
 =?utf-8?B?ei9VZzNhNGU4anZoQk9SaExxM3JnWDdzdm9kcCtyWXJJTGZ6NDErOFJDWDMz?=
 =?utf-8?B?UkYvcnZkWkdrQUtxRE9jYnVrUUdqRHFSNk9TSEpuazI4blI4VHhCeWRqRHoz?=
 =?utf-8?B?S1lGUHRIZWp6M3VRODJ1ZWZqdEk0ZmVtSVdHbEJlc1FabXNJUzBoUTFNbWhZ?=
 =?utf-8?B?b3VWWkdPeHVUUTlPcmNjaFc0WHIzS21YRG04WngrQndQcFdGa2REZnd5bGVv?=
 =?utf-8?B?bVpmWi84WVhhc1JPRFFSeGVGZDgyckZBajN4OUw5ekpHclE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9993.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2hYckVZZFZucDNZazREUnlYYmxndEU3U0VTZlhCa2JpRlVEMUxUK1J6ZW9W?=
 =?utf-8?B?UEU0SStnMklDS3JvdmhGUFJFQklSUmsyTWdQdFEvVkZoNFY0TGo0dG5haG9Z?=
 =?utf-8?B?ODI4UDVVcm1KWmgwR2dSVXdjZnpJRHptanNaMUhyRGZGdGYvSUhWV2NKY2pV?=
 =?utf-8?B?RzVGa3BGUUhKVEtrR3hRUThIczRrRnNmZzVGRDJ5ZjViMHJubmpCZFhTOHVh?=
 =?utf-8?B?SmVwU011bDR1amYyUnh5bG9sTWhBVzVqOWdzb0hzaUVoeXVSeThCc3hDQTRO?=
 =?utf-8?B?SGtzSzBsbDh3TFEyYjNKNHMrMmF3SGZybFIvd29vOU5nalpHTCtCMldteHV6?=
 =?utf-8?B?bFN2ZFpQUjl2UTd4WGFLdjMzc3ZiaTgyajZrQkZlUFhlNFN2cEY4Wk82eFZL?=
 =?utf-8?B?TTBoZ0d6T2hzY0dFSkpvQWxzMkNaSmlLbXVDVVliS3BQRTRUUERUYTNqOTJa?=
 =?utf-8?B?c2tQZWRVMzM2ajRwSWlvcDVNcUZhb0hwc0g2YlNDV0YzUko1SzNSZnRWb0dp?=
 =?utf-8?B?S1R1emJtL0sxQkh6cVdaV3NRc0t3eUt0MWVpWmhGTjFyajRIbGdsdlFUMXFq?=
 =?utf-8?B?dGZObHQyeUxiVU5WeVJiUkNKdUpVQ0dWWFFwaGkzOHQ2a2RVVDRRcUltVzlp?=
 =?utf-8?B?bXIyRFFWUmJqYTJFck1SaGJnWUNBVmx4c2RaNkp1bjdZdDZNT1NNeUtFd2wy?=
 =?utf-8?B?OWNYSWNNc3RmOFpTcGtuUWVjOXZSUUNmWHoxdjF0U1kyWnpIdG5YeXYrNllW?=
 =?utf-8?B?anhUVEdQYXNPYllkdFo1UEdmL2NsajFJZkhjc2NBcUtYVTZrV3NUblRyY1ZL?=
 =?utf-8?B?eVFLSGpyWm5wZDNSRXY1dDhnbmtKRDRqeU5pMkFITXhmKzlicDJxdkZqUEdw?=
 =?utf-8?B?aFV5bmZSU3lReFdmd2RENmMvQzhXQm5qbVV4ZDM2a0dXRWRlT1B6T3dtbVB1?=
 =?utf-8?B?bG9OL240cE5NVlVFWFhWcXRzUytUWXlpaG94V1VaZ0VIZVRYUG91L1BFcUMy?=
 =?utf-8?B?Uktha3hYUXJkbTI3V1U4NnNLN3VxenFPUFdaNWN6MTVMbUtCT29PZnJFWjFL?=
 =?utf-8?B?cmo5UDVCU2xTQWJ6NjZFWWdNRVVxczZZQTVkYXpqdXpreDRnWlJud25pYktn?=
 =?utf-8?B?bXlQLzFEdG1leldWNHpVRktGdmZVRmNNRDdGV3ExVG9xT2tTMitzdVk3Vm1U?=
 =?utf-8?B?dFdDbThhUWFsZUo3b1NhNFQzMk80WWl1NFE5TVh4bGh6MmtZVjhHLzVXa0tD?=
 =?utf-8?B?dVVDMHpCM3UzMWU1NzJsSmF6ZG1NN0hGV2VGMkhWMmFLSjFieWE0U0tTSFlY?=
 =?utf-8?B?THRsZmpyTVpPNlIzQW9NTjFDc3FmeUc3SUdwT2lUSjZSL0VFbkJLaEFpRWlM?=
 =?utf-8?B?N3BSeDI3NWIrbkZ2RW1kMVZHM1ZOMlJibEo5VE9zNGNpVTFoUE5nUjFBQ1hG?=
 =?utf-8?B?cFlTUU8xdjhOYUJKalJkZ1p4Y1piMms1QnJIOUxJaHlzVnlnRFNyanBUckNh?=
 =?utf-8?B?cFR2dFA5aFhJUTN1TWpyVEVtbXdteEtOYXcxbEVxdVRUZVc0U3BSQlllZlo1?=
 =?utf-8?B?M0sxNC9ieXlmZEd5QzAvYk0yUHhBdlZ5R0NMTVo0NG11VlAxQzBDejlrVGYx?=
 =?utf-8?B?RHFjUWp0SHUvbjd6SFROT05MQmI5TzRndzdMUUNmZnlYMjBkalFRZS91amFU?=
 =?utf-8?B?N0FwcHNZSVhyN2xueWNZbm5oa2ozdW5rNHFLMWQ2djhVeWJ0VE9uSFZjTVVr?=
 =?utf-8?B?L2VneG1QcDhtZlRPK2g4MVZhT3BHaWJvRWsvb0JRMEJSYnRMVjI4ZkxFeEty?=
 =?utf-8?B?Z21Uci9DeWZNdkhPelNIRVhHdDVMY2YvZVN6UnRDZmYyMjArL2ZhZVdKZ1Fp?=
 =?utf-8?B?Yytkang1b0lpM1lVZUg4b1ZOSzZjTXFrYTFWUzI0Ym93YThDcVNqS3hUTFZ1?=
 =?utf-8?B?UEEzTTd4Sm9HN25PRW1IRXhKZXo2bHpYQ3pOZk5qaEJUYjZwUU1SOVRkYUhM?=
 =?utf-8?B?YVo1UjZrNVNrZVRkMjU0STdBeGluM21NRzFKZXZzQmIzRXBaSUhrcWRUMUpC?=
 =?utf-8?B?b1F4eUdOZjlGNVNhRzV4d2NnN3Z4bGhjQllHR01PZDUxaHBzbWoxOUpGVGpu?=
 =?utf-8?Q?5MG22QVzZiGybkJCeDvR1wlXl?=
Content-ID: <1926C5750FD78C46AF259777FECA2470@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9993.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e69478-1a32-4b9a-1530-08dcd77e7e97
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2024 01:09:06.9274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kijnpr/qaxHOKhW36yhQ0TNQie7WyF2J5BN+CrATsekNzC3ueKSrutZ5gPquFsbYcWqDARulE7g27ZOCIphYOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10822
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240917_180923_938637_BC0A253E 
X-CRM114-Status: GOOD (  18.40  )
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

Hi Alex,

Thanks for the patch.

On 2024/09/13 23:35, Alexander Gordeev wrote:
> ELF program table virtual address is submitted to is_phys_addr()
> function, most likely as a leftover of replaced is_vmalloc_addr()
> function, as result of commit 2e452d75fa78 ("[PATCH v3] Enable
> --mem-usage for s390x."). Submit the physical address instead.

If this leftover causes a failure, could you add the error and brief 
description about it to the commit log?

It looks like currently is_phys_addr() is used only by s390x, and the 
patch looks good to me.

Thanks,
Kazu

> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>   elf_info.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/elf_info.c b/elf_info.c
> index bc24083..7f3d053 100644
> --- a/elf_info.c
> +++ b/elf_info.c
> @@ -765,7 +765,7 @@ int get_kcore_dump_loads(void)
>   	for (i = 0; i < num_pt_loads; ++i) {
>   		struct pt_load_segment *p = &pt_loads[i];
>   		if (p->phys_start == NOT_PADDR
> -				|| !is_phys_addr(p->virt_start))
> +				|| !is_phys_addr(p->phys_start))
>   			continue;
>   		loads++;
>   	}
> @@ -786,7 +786,7 @@ int get_kcore_dump_loads(void)
>   	for (i = 0, j = 0; i < num_pt_loads; ++i) {
>   		struct pt_load_segment *p = &pt_loads[i];
>   		if (p->phys_start == NOT_PADDR
> -				|| !is_phys_addr(p->virt_start))
> +				|| !is_phys_addr(p->phys_start))
>   			continue;
>   		if (j >= loads) {
>   			free(pls);
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

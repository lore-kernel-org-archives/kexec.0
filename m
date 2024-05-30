Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588B6C27C43
	for <kexec@archiver.kernel.org>; Thu, 30 May 2024 07:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=4eKYhAa9XAfYV8VmidpH/tiJHJCEl8h9kDoz2x+9Ldo=; b=NM8niTo8tw+lsu
	J6mG9GgeQ4kgSY3r+tfv5NVR4ig8ABlSn7NFVNXzBq7wH7S7kUWa3jeEUS5N4YPwigKRFtfLCXRAC
	GDNw9MRa85zzqDggkTZvMHTy+SAVvUUkmJxxdm25FCzcG8ayAdsEmgahN4K/ig/ecpYDx1/H/hYZs
	FQLXgvWw0rdRTI9uNzWtZ9AeyAoQQil+N+f4kqvSPuTZ0HqEQWO/oxT8AWNTk8t4pGade/BTPm4Cq
	0yMGLq+P99Jwqv2ig8msk6yNm4H6LYZJRktgt3UpTvUSFU3RIlhSGq4ZO15vjs93trfD1B7LO9T7K
	T4ACUZ0KazDtvrC3zhGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCah6-00000006ZCy-01A2;
	Thu, 30 May 2024 07:59:28 +0000
Received: from mail-os0jpn01on2061f.outbound.protection.outlook.com ([2a01:111:f403:201a::61f] helo=JPN01-OS0-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCah1-00000006ZAI-1zR2
	for kexec@lists.infradead.org;
	Thu, 30 May 2024 07:59:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OW4R872KhN5iN03teiGXFytFbf1XOVLaTyNS0ZVnKowzCrefhd2mZZpTTNbiMNrKtli6dxlhfqqFqa+yr4uSvscrJeUR/dxd5dPhHuuAXwUkvWLIQMB/c+/3ER8jATkxm2o2CBgxVZW5q4UU1ed4hEg/5/YkYH7dCYeybcehIoROOeUgnYpt5jV2GVKOCp+h6NmwygQDP9CsgHyMcpywOq5JpsYXQBtfgzDJHAO0KRwIzCvTvwKotesaHcrpO1m6ZuQpqubKS2DKT+r9d/5iRGJJlF/inVOANWlMr7LLfgAquiWVQmWdFCoc+21INBUVyzPzKSvXKcoGBSwhXtIVoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0vkXb8ixOVGlSt7LnTdL6S6iDJ6NiroMW/1/O9PGE4=;
 b=kz70FABkCZl+LfMypCsWkZP7UrPq6m4MDIO20VX9qu944JCPCmyRLKP4/KCXNcbNTBSI1QLJ5AnZX7WVQWWHGfCo0SjSMLWHcxylKIAC2SP8tjsVds/C4LdXJpKDZ4tUli0cFp25JLSYam6whMo06r0UyFjpQNvn8If2RSjZP39kT2EQzyBsgnvAcihjhwRVpjIBdBZ4VpUZz/6je8M/kByG0GyqSl5kczQwNZug7wHDJRi+73RqLKdnU5qQKVa/aTtrLgCG3qa1VQKDpnnGgv95aYXV33BaFOnPmTXY2g9evGF1w+rrCJGMXcNALI/HCYyuFsPAvPdkkqbmroDP2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0vkXb8ixOVGlSt7LnTdL6S6iDJ6NiroMW/1/O9PGE4=;
 b=WVUjQ+OPmH8psKw9MZp/YDgaOE0V5PQZS1IXY7lf4ab24Mn5MRdEmQeuwMDdNNc8j9u1eHq8XdQKP1xq6FfX7mn9zRFv9xEUz2EXNORF8OO7qW+H7EovDCIzvg9r2ArSmBKmG+CimpO2vKXzEXkamGu2BhnvCqOMjejnNGZtlx3zKiLeLDHO75o8MqAon68iyQ+86bvib05cCXKkRjOZM27Z5vAFYtnPDmvlumSlcSOzISR80WuCR3ldu6B7iXmKO1TAuJOLdrWs/h9sMyxY7xi/REFJcV0ipB6w0gsGlcM6G/YSDuqw0j9YmEZ8qODMB7Bs+ZhZ34VIe9YC99qOWw==
Received: from TYCPR01MB10963.jpnprd01.prod.outlook.com
 (2603:1096:400:3a5::14) by TYCPR01MB6817.jpnprd01.prod.outlook.com
 (2603:1096:400:b4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 07:59:02 +0000
Received: from TYCPR01MB10963.jpnprd01.prod.outlook.com
 ([fe80::f07d:6a76:a936:693c]) by TYCPR01MB10963.jpnprd01.prod.outlook.com
 ([fe80::f07d:6a76:a936:693c%6]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 07:59:02 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
	<k-hagio-ab@nec.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
CC: =?iso-2022-jp?B?WUFNQVpBS0kgTUFTQU1JVFNVKBskQjszOmohIT8/OHcbKEIp?=
	<yamazaki-msmt@nec.com>
Subject: [PATCH makedumpfile] Fix failure of hugetlb pages exclusion on Linux
 6.9 and later
Thread-Topic: [PATCH makedumpfile] Fix failure of hugetlb pages exclusion on
 Linux 6.9 and later
Thread-Index: AQHasmc8VVAx8W8zPkya4Js9wVEuUQ==
Date: Thu, 30 May 2024 07:59:02 +0000
Message-ID: <1717055930-23334-1-git-send-email-k-hagio-ab@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.8.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10963:EE_|TYCPR01MB6817:EE_
x-ms-office365-filtering-correlation-id: 4ba029be-c5df-4269-292a-08dc807e5ef3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?iso-2022-jp?B?cVZXblBUYzFDbGdkY29OK01nRVRaWitCRU1rYVQwSVFhWS9LTE9rSGVN?=
 =?iso-2022-jp?B?SEY0a3Jycm9iOEFNOExreWNtUVFTMW1OUXpCeVFBc1BoeXNWcFRIbldE?=
 =?iso-2022-jp?B?RTZiQ3d3cHNjdk4wM2hvYTdRNE5LNm0xQXZnRnFFcWR2STZaUzI0RWhW?=
 =?iso-2022-jp?B?eEtUZ2w3UmtobTNyZ0ZPb25UcGVkbWRrNTFFRGhwR1hjSGxTNTNpUU1p?=
 =?iso-2022-jp?B?eDBTNGtHeGVlcG43WXlQMHYvTktKbVZ2MlVqbHJGTGtaN0JxL1RxMUZP?=
 =?iso-2022-jp?B?aytlOHN1R1QvS3NCL2RHL25BbzJJakpHc2QyaDk4REQwMG5ib0lyVEs0?=
 =?iso-2022-jp?B?V3hSaCtRc082NVo0S25MQVNLK293Z1ovZzJ0aE5qZXdGZlBSbEVrNWlo?=
 =?iso-2022-jp?B?cmxxRmZSRVpHZ2gvaHBPM3JZd0pvQ21xL3JSQUY5ZlhJczdaandOTGtu?=
 =?iso-2022-jp?B?bHpWSHF6U2dWay9zOERIVWxCbnNjWWRmMU9menB4WkJNQ2FMRzlLeWhW?=
 =?iso-2022-jp?B?YWFaMEZWUWZBODFKSGQwR2h1c0o4aVVmOHJ6OUpaNEN0ejRnVmJJZjRk?=
 =?iso-2022-jp?B?UnluSzlkOFdoazJNM3k4MXV6SFdIVW51Z0ttU3d4REFESURnUWI3djJZ?=
 =?iso-2022-jp?B?Z1lNdkxLVmwwbENoK3g2SlJmOStIa25ZQlljSzY4TjNGeis4LytKV0cy?=
 =?iso-2022-jp?B?RmFjZnZFVGZjQVpkcUhsSkZQSEVhVmJUS1IwVTBXQm1aUEd1TTFRM0dS?=
 =?iso-2022-jp?B?K0FETHQvSGhLT09vTFhWOS8xN05heHRFbGhXRGhlNVhhV25hOWovVWNB?=
 =?iso-2022-jp?B?WkZOQVkwaUdZUGNTRjA5Unh0UVd5UDJ5MXZzT1BhaDlSaXhFZWkyR0dS?=
 =?iso-2022-jp?B?Wkx6OFpJS2xMYWg2czZadTB6N3NUZzdVb0VRV25iUG9MQXlFdUUvTUF5?=
 =?iso-2022-jp?B?Mlh6aHYwL2RxTk1wbVpkQVpwVUhWd2N3Q1lBelVjQlNiMEpuaTVHK3Z1?=
 =?iso-2022-jp?B?TG03OUpDY1FLUkhRdXBtWEoraTV3M0hVRkhwQ0lwODlkYmVJN1Y5SFNy?=
 =?iso-2022-jp?B?MXhjZzVDQlRnSlAxdkY2NkxmT0w1V2xQMmR6T1pqVi9wMSszOW96VW9v?=
 =?iso-2022-jp?B?NHJSd1MwT0QzSjlXUjRQMjY0WklVTTdlQ0dYYkFxRVhuZ1g0WUVleWNh?=
 =?iso-2022-jp?B?YXJRWUVTN2NRUTBqMVdCejBQODZHL3BSZXpQSXIvd01NOEFlN3AxMkxj?=
 =?iso-2022-jp?B?WlFnamJCMFJ6SlJnOEc5UGZKOHV1QzZ2UTNKeU1uT3NXRDU0R1h4Kzlz?=
 =?iso-2022-jp?B?SlpqWkI3OFJvL3gzVERidTBpcU1RWitxV1ZwSWs1NTIvWHJla0NoWTNY?=
 =?iso-2022-jp?B?OEt3UStrNGU4VG83eUM3VS9tcjluUFcvdjRpYUxIcnVOOGxjbVRGa3lh?=
 =?iso-2022-jp?B?QVV6NzVZVFlET2NCdVV1bTJNYm1zNmFUTGxXTTNYczFrZW96WVYwcHZ2?=
 =?iso-2022-jp?B?dTJncFE3OWczS2U5bUVpWlpSNHBQMmJiY0wvYkk3TUtSanVnRVBpMkMw?=
 =?iso-2022-jp?B?Q041UzJ4M1JYV1RZa1BaaTFiRWl5RDFsYUNtY3d0MW5sbXRqMWVQSTdX?=
 =?iso-2022-jp?B?OUkwZ1I3QWNhWnVHcWRGV1RHRXVuVTMxL3BJYW0wZVpIWDhJN0dhc1RB?=
 =?iso-2022-jp?B?b1MzVnpoUXF2MlFrRzNkSUhJTkVneUE4WkN5VzNZdE1aWDE3TVRJR0ky?=
 =?iso-2022-jp?B?NW5XSGtvYVh0YVRUVlRYcDJGbjBScFkzbmthOTRwS1NPay9lUFNrRFpr?=
 =?iso-2022-jp?B?ZlZEbjBFUEd5SEdBeE0zbGlsbFZxUDYxL0V3QXlQOTRPVlpoVUFlcWlr?=
 =?iso-2022-jp?B?OFZ2QmRNa1NMajBCZmt2aExabjk5SlIxeE8rL0pEUGxoUkxER2tNNk0v?=
 =?iso-2022-jp?B?VkRuTDY4YnBBYXp1M0dOakxwWXFNdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10963.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?M1ppT0pJVDJLa0FWbXladlNXbUptUUlXZjVyWDJDOGVxWlA4VDhVTVl6?=
 =?iso-2022-jp?B?U0o0bjhkNGpYSkZ3UVVrVGFLTTNsTzdHMXVVSFdheDRtczNNeWZWY1FM?=
 =?iso-2022-jp?B?RGdPQ0o3eXZtc1libzFkdmhSVitZeldXbDBGUGVaRmpaQ1dWUlN4MXJU?=
 =?iso-2022-jp?B?bDZLSVBMSzdCV1M4bVFOQU4zOFY0M3dDQnFFWW5ia0syKzhSNWFnQk9H?=
 =?iso-2022-jp?B?cG4xNWdXRmdTYjg4MHJaTUNuWVpXMGxnQklnMkVwREF0SEhiN2F0enFj?=
 =?iso-2022-jp?B?Y1YwMyt0dC9qL1p6Y3BDY3VzYndXM2hIR01BOUxPK1BHYnNKZ04xRytH?=
 =?iso-2022-jp?B?dkFsYlMrVXNJRUVVM1RzOEtrd01YdDh2NlRZU2Zxa21UNnZ1dnJRR25J?=
 =?iso-2022-jp?B?NlN3WHJXdTVoTFl4dnlXR1ZxQ1BwL0N1dXlFQTR3OVZZV0luRnFQT2FO?=
 =?iso-2022-jp?B?QTh5bXRpVTNBeldjSWw5eXpYcWZZRGdUdERJS3FTcXo5OEFacEI0TnFN?=
 =?iso-2022-jp?B?ZXZHV0J2RTl3NVphNDNaVlR2R3o5Z09UN0p4SDVDYy9UdXl4NlpZTDBn?=
 =?iso-2022-jp?B?akJhM3BwL3NtRmtuN3MvZGI2U2VQcUFIUEtxY1BpVUxIQ0xOa2ZoamNR?=
 =?iso-2022-jp?B?L2FqVmtMbm1KVThVSkE1ck42SUZMc25hNmhGSlVtdXNxN2dFdngwTkcv?=
 =?iso-2022-jp?B?TDlXSlMwellBVHFvZjdqeXgvZFVVVHMxS3BGVklKOHVoYkF2M0U0eGkz?=
 =?iso-2022-jp?B?cEdaYTl0M2p4b0Q2RWZsdTVXZ21sK3F6LzBRRXE4N2J1bThIS2JzYzcz?=
 =?iso-2022-jp?B?VnI5SjJoZG52MVBtK0UvYjRsNG5DMWVPUWJUeUlKMGs1dDUzd045STlJ?=
 =?iso-2022-jp?B?SC9aWk9aUExUdkhUbjJRUGIrbEJnZUZIbHI2NXQwVGZsbU93V1FnZ1dF?=
 =?iso-2022-jp?B?R2ovWTg2MzhyZjgwdHZ2SUowQXlldG8yQVVVb2UwNFRlblNtOE9nbHpq?=
 =?iso-2022-jp?B?OERBWGZCTzJCd2lGcHRGaTdIM1ZHNE1ocmk2OEc5YnA1alo4ajZOUDRN?=
 =?iso-2022-jp?B?cTdLVWdiNHRxSmlkMndPeHQvRGNVT1FMNVJ2TXlZZStJckR4UlJNNm9a?=
 =?iso-2022-jp?B?ZmpvMk83cHJjaEF2WHJOdERZTXhIcXhjRTZrQi9KV05TOXE3NHFtSHAx?=
 =?iso-2022-jp?B?OXR5R2JmRHRSd3pxMzhIb2ZQTVBSWjZNUUNOVFV0bHVlQWNEcWdUUkMw?=
 =?iso-2022-jp?B?K0M0NGRMVDNaLzc5NWM4ZWF0NkY0enJlUmVoTXdrTXhTRElSVlRnVHEw?=
 =?iso-2022-jp?B?OUxLdUUybkg0K2JVMVEzYUpuMjhhbW1ZVGxyaktsNUZhcndYSFJNRUtq?=
 =?iso-2022-jp?B?MnZTeWoyK0RWTExweW9YZERNdVhubUxKOUErUFg2QjZlWExmbC80L3dn?=
 =?iso-2022-jp?B?eGs0ZklxREVXM1pBMGViM05ZZjdjRzNpUFZreFdWWUMrdHZqa1hxbGx3?=
 =?iso-2022-jp?B?ekIzSjh6cmV6S3R6RGRwT09tNlF1ZHRZbEs1K1VrZmJBcHhkSWZOaGRk?=
 =?iso-2022-jp?B?Nk9OZXZQc2hBYXpJdGYvYU9uYjZ1bmRLRmx5SDlwUWFLQjhOR2tWZ3dU?=
 =?iso-2022-jp?B?V1B3K3ZGY2NoeGtlN3hOQTRocGdQYWVCbjJPY09MQUJKUllrNHc3akNV?=
 =?iso-2022-jp?B?NnBjaXJSWFRWQmVzSDVqSmI0cVZnb1ljbk13SjRFemMyUzczQXV5eTUy?=
 =?iso-2022-jp?B?eTZCRjBEbGxPQngrY1NGbjVXMWt2ZkFHQ002alhWQXIwUmVxUi9lYjRK?=
 =?iso-2022-jp?B?cGd6ajV1TUp4TDVJZ3FXb3lZcmV2d1FDL1BOSENkMWhLWW4rZHNmUUVL?=
 =?iso-2022-jp?B?OTE0QWVseDlia3ZnSTh0UVJLbTAwUzYybk1LRjdmdmRhRzFuWmx1MHJB?=
 =?iso-2022-jp?B?M3VwM0F6VU92Z0RTYjVGazFmenEreUF1ZmtFVENadHpsVDRNQWFBbEpO?=
 =?iso-2022-jp?B?Q0dVY24zWDlqR05PeXhDRFVERGErNFB1QjdUdkxBRDR0VkhCUDNIcXd6?=
 =?iso-2022-jp?B?aG5COUdFNnFXZmtqbExaK0pRejR3S29xc2FaNnREUFlPOWZ2YThxNDAw?=
 =?iso-2022-jp?B?N0ZmUUU1a3pTbkcxUnBVUnlSaDBONUEyMzNuZ00yWk1nblZuL3lJczh1?=
 =?iso-2022-jp?B?U2Jzb0s2Rytmdm42U0ZkaCsxa2dyU2N0R01sQmlRc2VhdUgwdlJEbTE0?=
 =?iso-2022-jp?B?OWpGQ0pnRjg0MmJDdUF4N1N3bkhDQkk5VDVDdytaRGsxdGd5d3BoVU10?=
 =?iso-2022-jp?B?UzdOMQ==?=
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10963.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba029be-c5df-4269-292a-08dc807e5ef3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 07:59:02.6401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ggHR2ICAfhjOSWVVuWiu+tvmnj6lpj1rWnlm5XM/k9DI212g5UPmDksBzyNeJ8pohyOft3WIHUf/BKmtFpy2EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6817
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_005923_768004_287D233E 
X-CRM114-Status: GOOD (  14.21  )
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

* Required for kernel 6.9

Kernel commit d99e3140a4d3 ("mm: turn folio_test_hugetlb into a
PageType") moved the PG_hugetlb flag from folio._flags_1 into
page._mapcount and introduced NUMBER(PAGE_HUGETLB_MAPCOUNT_VALUE) entry
into vmcoreinfo.

Without the patch, "makedumpfile -d 8" cannot exclude hugetlb pages.

Signed-off-by: Kazuhito Hagio <k-hagio-ab@nec.com>
---
 makedumpfile.c | 22 ++++++++++++++++++++--
 makedumpfile.h |  3 +++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index d7f1dd41d2ca..a6cadc9092c9 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2975,6 +2975,7 @@ read_vmcoreinfo(void)
 	READ_SRCFILE("pud_t", pud_t);
 
 	READ_NUMBER("PAGE_BUDDY_MAPCOUNT_VALUE", PAGE_BUDDY_MAPCOUNT_VALUE);
+	READ_NUMBER("PAGE_HUGETLB_MAPCOUNT_VALUE", PAGE_HUGETLB_MAPCOUNT_VALUE);
 	READ_NUMBER("PAGE_OFFLINE_MAPCOUNT_VALUE", PAGE_OFFLINE_MAPCOUNT_VALUE);
 	READ_NUMBER("phys_base", phys_base);
 	READ_NUMBER("KERNEL_IMAGE_SIZE", KERNEL_IMAGE_SIZE);
@@ -6510,6 +6511,9 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 		_count  = UINT(pcache + OFFSET(page._refcount));
 		mapping = ULONG(pcache + OFFSET(page.mapping));
 
+		if (OFFSET(page._mapcount) != NOT_FOUND_STRUCTURE)
+			_mapcount = UINT(pcache + OFFSET(page._mapcount));
+
 		compound_order = 0;
 		compound_dtor = 0;
 		/*
@@ -6520,6 +6524,22 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 		if ((index_pg < PGMM_CACHED - 1) && isCompoundHead(flags)) {
 			unsigned char *addr = pcache + SIZE(page);
 
+			/*
+			 * Linux 6.9 and later kernels use _mapcount value for hugetlb pages.
+			 * See kernel commit d99e3140a4d3.
+			 */
+			if (NUMBER(PAGE_HUGETLB_MAPCOUNT_VALUE) != NOT_FOUND_NUMBER) {
+				unsigned long _flags_1 = ULONG(addr + OFFSET(page.flags));
+				unsigned int PG_hugetlb = ~NUMBER(PAGE_HUGETLB_MAPCOUNT_VALUE);
+
+				compound_order = _flags_1 & 0xff;
+
+				if ((_mapcount & (PAGE_TYPE_BASE | PG_hugetlb)) == PAGE_TYPE_BASE)
+					compound_dtor = IS_HUGETLB;
+
+				goto check_order;
+			}
+
 			/*
 			 * Linux 6.6 and later.  Kernels that have PG_hugetlb should also
 			 * have the compound order in the low byte of folio._flags_1.
@@ -6564,8 +6584,6 @@ check_order:
 		if (OFFSET(page.compound_head) != NOT_FOUND_STRUCTURE)
 			compound_head = ULONG(pcache + OFFSET(page.compound_head));
 
-		if (OFFSET(page._mapcount) != NOT_FOUND_STRUCTURE)
-			_mapcount = UINT(pcache + OFFSET(page._mapcount));
 		if (OFFSET(page.private) != NOT_FOUND_STRUCTURE)
 			private = ULONG(pcache + OFFSET(page.private));
 
diff --git a/makedumpfile.h b/makedumpfile.h
index 75b66ceaba21..f08c49fc73be 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -165,6 +165,8 @@ test_bit(int nr, unsigned long addr)
 #define isAnon(mapping, flags)	(((unsigned long)mapping & PAGE_MAPPING_ANON) != 0 \
 				&& !isSlab(flags))
 
+#define PAGE_TYPE_BASE		(0xf0000000)
+
 #define PTOB(X)			(((unsigned long long)(X)) << PAGESHIFT())
 #define BTOP(X)			(((unsigned long long)(X)) >> PAGESHIFT())
 
@@ -2255,6 +2257,7 @@ struct number_table {
 	long    PG_hugetlb;
 
 	long	PAGE_BUDDY_MAPCOUNT_VALUE;
+	long	PAGE_HUGETLB_MAPCOUNT_VALUE;
 	long	PAGE_OFFLINE_MAPCOUNT_VALUE;
 	long	SECTION_SIZE_BITS;
 	long	MAX_PHYSMEM_BITS;
-- 
2.31.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAD6C52D7C
	for <kexec@archiver.kernel.org>; Wed, 21 Aug 2024 07:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:
	References:Cc:To:Subject:Date:Message-ID:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=8o6QvrsIAvB8P6WysGMiix8RVHAWbgHVcC7e1zNq3HI=; b=ah8t5UXzGPMVO+OGzZz0W1HZUB
	IVRJ/LLrJcMbjGZubOsUELySI6j5oq51+vUxd5zHP/2yv8LQMeTyHIrex1LY7muoVmZaH6Pujtded
	3rK3Z5elk1cl1UhJchOOi8VnLfjGewdaSLaPBXazvlrVKi4VnRaQXxnm6rISqljkjk8b7c9MWIdGt
	1HdLhmKj/NKPt5PMUgla4/DHQnO3ZU83Ac7LHGflM2P7f9DKQhVEGbiz7Vz2CxY0lnNzskM0S8HLS
	fw4+vv5nNGUEIqJ4fCvuHVgkgn4oDF0xp/0XnmZJIZvsF3Acqgdms4Isp1wmScNQBtzzpGPRdOtMJ
	O8WOgg9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgfnM-00000007v5e-3OAQ;
	Wed, 21 Aug 2024 07:30:16 +0000
Received: from mail-am0eur02on20607.outbound.protection.outlook.com ([2a01:111:f403:2606::607] helo=EUR02-AM0-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgfnI-00000007v4d-2HRC
	for kexec@lists.infradead.org;
	Wed, 21 Aug 2024 07:30:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+eA1egPB0uDJ3DD2YraRNZJ70wKjhlLZrzaWCfxhJVYaM49gbLTOfmVDSLf8zIrUEqxRGd51eHfwcua+kCl21P//IofBnvIUc35j2VOz8Kz/5eB6HxAJpaolFHiYfJLLmsLdMLC5qgEJ2HARVuzmaC8pBbe2i3vZkxSei6Wo8pj1MS94uw0SMOUZM9iVCa4mrCKCBjHpq3vUK459mkeknZAGi3xWBV32ACp/q9kCOi714imiBRBhn4UORZQ3nHJdyPbZFQnA2RdDtUu0/KvZWjJ5BH31+85kUXSjVs8d45HuN92Y7n1X8LTFh7UgBC8ntKqpllO379Fd9alVjWgzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcCp6ldLDqQLl8fuF+aIBw5sIuE5DABkPegTLOQR/XE=;
 b=GabzapxhmsC8m7zzRXF6uLL9ogAn4vXo6LjdKyj/uYcEghM2gDuddH3bFWpBxOylN7ZKGQ4324lcIBuvmTg8VGAOL8RahsCgSrCol4S042fYqwuDsYv51r5SdVpjwPUkplIX2UPP5i5VurjqsLZIWBzCEgA0xu1KEBwroC8CEd/7COklyeLMWJw3US6EqCmwjgZ7VbaYHUnlGaiUji2JNXY/9v6zB9+esx+BFwJL5t9pTIHNZjFuFKd3gxO/XPpw6UfIyUzQVQIgjiDRvA5aCOjWMD5ECOu1Gn8Zdx5SxyXDvjSBaM93DbAdiaxFAd7uUIIkmI4EzJWJwoyW5a2pMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcCp6ldLDqQLl8fuF+aIBw5sIuE5DABkPegTLOQR/XE=;
 b=K/Bpj7L50rqh5hicT7OWpu21JZrMfJyNbLcmXO+UeYDii5dplkoNWXvBPZBiEdMRseMJfvqe6qKsU29y0dlXVHh9lBilVuMrltOpLBZnG9uPlk1fSt5xEGcShMyE6Y7q8+7USe6bTizesJ7gUTxB6cFQvYT8uU2NJxzE7pTZwvhMWPrmuT8N7Jx1kKdqVrMeFjOT7AyLE304rilFm+IGYyVtKhnsEEiKy8uCE2rOwyBX6iDNJ23jKM9BXOxJWGpcyoxOSm1Wu6DKo0SpVIKuDPkRK4SMWYVrMsQnOp5GkMZU4Y31K5TTUA1LNObh7rfBSA0ntQWPxQRPSOw9eDknIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by AS8PR07MB8006.eurprd07.prod.outlook.com (2603:10a6:20b:394::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Wed, 21 Aug
 2024 07:30:02 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 07:30:02 +0000
Message-ID: <2874031e-bb32-43dc-8220-7756dc2b36a2@nokia.com>
Date: Wed, 21 Aug 2024 09:30:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] makedumpfile: Add ftruncate error handling
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 =?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?=
 <yamazaki-msmt@nec.com>
References: <20240815141733.4050230-2-stefan.wiehler@nokia.com>
 <db15a94c-3fa5-47e6-8c8d-59665bb119a8@nec.com>
Content-Language: en-US
From: Stefan Wiehler <stefan.wiehler@nokia.com>
Organization: Nokia
In-Reply-To: <db15a94c-3fa5-47e6-8c8d-59665bb119a8@nec.com>
X-ClientProxiedBy: FR0P281CA0270.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::16) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|AS8PR07MB8006:EE_
X-MS-Office365-Filtering-Correlation-Id: 67bc19d0-c305-4387-9df2-08dcc1b31208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEF6dzhJcmxLREtMd0M0ZktBVmdDRkZXaHdaS1Q1c1I4WGZpUmZGeWNiNUd1?=
 =?utf-8?B?RHAvR2FuRXd2czNSaUVCQjJEZVVNQjdLc2VmSCt6TmlVcGE5Yko3a0o4NkZy?=
 =?utf-8?B?MDA2V0lYUlZlYUl6SHErNzJ2VEUxMFZKZWZpMThFUXJhS0dQbjQ3TXg4aUx5?=
 =?utf-8?B?QkNmVkZabm9nZUc0UDJhOER0b3dPZXkyK2JiVzBhLzR4K3lzTmJMa0gxdDNl?=
 =?utf-8?B?MmFKZm5Gak96ZlVnM0x2WTF1TzNQOWtyNjc5Z1BjQUFEUDVZRTlPU2ptRFVJ?=
 =?utf-8?B?RHozUklHUTZyek5RbC9Ia1pWZlpWYkZoS2IvRkcxOW1vUmJ6MjFwMllSTExX?=
 =?utf-8?B?WjJrVk03aGhvSStCaUphZVRWRy9oZTh2MmpIcTB1U1loUC8rc2c4S09sUGRS?=
 =?utf-8?B?YUhoYk0zS0ErcGRzRkhUcHR2UVRSSWNYNzkzQ3ZnVm51S0xjaWJ3OCtqdklS?=
 =?utf-8?B?VURIdWNkNnI1QjVuRy9JVUhMM0VKc1MxYzg0d1BqNVVzRitlWnFRWSszSzQy?=
 =?utf-8?B?a3Bnb3FZUXYxRnRLbEpzMTBmVjZSaE05VGIxS0pkdGZKUG1BNWNwaEFGclp3?=
 =?utf-8?B?aUNhU0dDWEpZczJJTUgwU0Q1K2s3c2hIek1zZjhzeWxmdUJUdTNHcUlML2pn?=
 =?utf-8?B?YW50dUhuODUvT1poRnhiZU5hTXpDUTJYcmhkeUlmdzlFb1l2QUFWZnV4K2F5?=
 =?utf-8?B?UmU4Q0tyeklGWFBQQkxrNFUzckhHYVpKcFRETHFBOXk2ZWpRelFlTlUyUjNF?=
 =?utf-8?B?SXk3VWF1Y1EzelUxZFQ0ZStGcEEzN1B5em1KY3VMUGxpSm40R3RnQVVsTFB1?=
 =?utf-8?B?TUd1blN4WlZ5TUdtRzRSQUozRzdZRThxellDTGhGOWpicWhHVGRlazQwMWRH?=
 =?utf-8?B?alZKcktMU3d0M21JWHNYOEs4TDNRQVpTaGhOY0pRK0txNkRqQTBBckVuV09B?=
 =?utf-8?B?VlpJclpqYjlBdmhUTEhvTUE5Y0JQUU8yQ0RTa3g5TUlzUFAzTnZaek5LdmlP?=
 =?utf-8?B?d1phUW9mSDVqQ2pMRU1hWnRvQTlqY0h5SU9GM1NtR09ad3ZtRWxUMHZWUzZa?=
 =?utf-8?B?Q0xDblh4QXhwNDh4YjZvQUFxREsvcGVmSVIvS1I1UGNwTHQ3aVJaWFZWN05p?=
 =?utf-8?B?S3VKbFpDQXVzZU5zTFEvQWtaakR3MU5kY2g4dXd6TDJ1QXU0UzZKYU1wejdr?=
 =?utf-8?B?QjllVEQzbHAzNksxUEF4Vjg2WHp3dGVYaUhMM3lpYUZuRk9yZXZoQnJuQkF0?=
 =?utf-8?B?T3BycHFxS2xDSWJYMEd0ZmphdHJrSmcwMkhOcGRGZUczMGdJSmdNdEc3Nzhp?=
 =?utf-8?B?dDBZYkkxR1NUYnY2SUFSZS9WZFVUTXVVdmFENDRoYzJxclYrS3dRNVFDYktx?=
 =?utf-8?B?UFViL3lISitPdXNOVEZZMTF0MHZNS1FrdTZRSmVtMURqK290UEQ4bndjNEZx?=
 =?utf-8?B?Nk5UOW9xMG5aditDU29vdXB0bUdjcnp5TkMyRFhnbWttaDB5bklqK01aN3c4?=
 =?utf-8?B?MkdYN1UyWDVMdy9WSGl0ODB1eEJUZy9JS2VYRmt2dUVtT2tXTXlXKzdhWU4x?=
 =?utf-8?B?Yzh2cThEMWZ0NDJqMzNySkdVSmppZVIyQUJacjdNVkVaZUFXb3RUNlNndGdN?=
 =?utf-8?B?cnFvZXdaYnNVVXJrTmxQQWJDWDBGaTAwUHpqRWNYK0xCcWRuMXczWk1WaVpL?=
 =?utf-8?B?WVNqcFRsVXNCSWhHUTRWaWp3dU1yUUUzYmFURFpjS2pxOGdEVGlYaWhpWkxQ?=
 =?utf-8?Q?nyUz03meiAS4HzPCmw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmtXUFZiTlYwRmF5MTluZjZCaGtxTm9ZWitWWDJxeFpVeVZ5T3dIZy8reU1I?=
 =?utf-8?B?WHdZMXgxM3pmVEk2YkFSWTh0TlR5SHg4WlJOM0dEU0U5aG5VNGR2c0dORG1r?=
 =?utf-8?B?Q1ZSOVVUUm9RaU9xaXNvNmFjallKWXNtK0wxcnhKclFaUyt6OWhQd3Q0Q1hV?=
 =?utf-8?B?a3J5a2t6MDkyWk1MeE9CVTlocm5GY3ZpUjBDOFNpZzFCK3I4bmRUMmk0OHB1?=
 =?utf-8?B?ZjhmbE9IYUlPUHI1SlhxNkFCNXhleS9uNlN6WmNESE9MYzgvOEFiajdJVTJL?=
 =?utf-8?B?QUh4VnVzb0FoVEpha1kySTVKTEpRWW1Ud0ZJMzdQZ1d5YnpkVGZTa3pJajNK?=
 =?utf-8?B?K3JBU3hwNFF2N3ZQME52NWwrRWRyMGZlZmFuaE1pU2hBRDRkN0owUnU2bm9j?=
 =?utf-8?B?QUVNVmNPN25td29Pd3BobFpTVnI3d3dhajFjbm9BZzlOS2JDQ2tWaU9Bb1dR?=
 =?utf-8?B?aVF6U0w1NERkdTd2RERtc2lwM3pDNzNaaUN3T3Vhc3pheThicWZnS2tWZHZh?=
 =?utf-8?B?SWlRNUgwZWFrNjB1ZjdMN005RFJ0NzVtQ0Q2OUtIQ0ZqazNiK0t1MDg0RXBu?=
 =?utf-8?B?T3JLTnpZTFBYZ1BCT0xteEJFVERYcXpsaUhZS1AwcnlkUE1VR3dJOU4yeEM3?=
 =?utf-8?B?dWNiQXdyQXNUTHR5QlR1LzEySFdocGxObTFMbnJ3N2JvSEcxeFY3Y1VvOG92?=
 =?utf-8?B?Z2ZjU0I0SzQ5SnhIMUVDSFdjY05pM2s2dTVZa1FSWHdzemdaTlJjQkdRNVVh?=
 =?utf-8?B?QzZmOEh2KzBtamdiOWxHdk45SlFxTCt6V2dscS9DYjFFT3N1UFZqMXF1eGI0?=
 =?utf-8?B?RXV2TjM4Wk1nUUFickxmeExScWRLbTdpKzJhVC9DaWFveUN1K3RRdDFaWVRI?=
 =?utf-8?B?SFlpRkcwNndCNXBwb2lZNCtrUW5iZ3ZTbzZidDQvWFAyOUJXNjBrS3pXbURM?=
 =?utf-8?B?WllGZ3c2ZWtwWXU1OWdFMGNpM3NtRzMraDNDaFpOd0Q4UVlDRml1Q25nVkxp?=
 =?utf-8?B?Z3psS3Z2eWtUNGtzOGFFdGdqU3FqaEhIbEt2WHdsWjZhb2ZzZUFhQUo0aUNv?=
 =?utf-8?B?cGFkTkNydExycjVwdlNHRFR1RlhjUG9lU0YzWjdoN1N3WWhoWllXd2orNjBr?=
 =?utf-8?B?RFltY2wyWmJtZ1c0KzJBVjZkUjU1M3BnV1J4STNwa2J2OTFHenZ2ckJJdzVp?=
 =?utf-8?B?RmN2NmhsemkvUCtWSHNVNC9FUzdjNnkzak5yaGJ2YzVVdVIvY1hORC9COFp0?=
 =?utf-8?B?RVBrbUVqc09sOWJaQWxmNnZSRnRVdnpZTzM0dVlJZHQ3eGNtWUVzdWVTeVZC?=
 =?utf-8?B?YkEzNDkvNXNSMWtLL3l1SmRWY2VZTml0TjBiR09LeHR6RXNOZkxudG0rbEk1?=
 =?utf-8?B?MmQ5d29BRWJ6OWh2SHlTVmU4cXNGVU5PS0pMOFFZc0h4U1RWN0pFL3U4clU1?=
 =?utf-8?B?RHorMTVmaGM1cEJvdmxLTS92UGtnRTNkQUlJeDVrSDJ3cEs4bkhsbm83MWVy?=
 =?utf-8?B?MXNzazhOT2MybHpZZVM3OUhNVHZrUk9QMHEybk9JaFJJbkdINFVaYk9wMGpW?=
 =?utf-8?B?bnNjdTd3QnArTEdJZERjRnVMT3owNlkwNFJhdDAwMDBDWHE3eldIL2ZmME1L?=
 =?utf-8?B?ZDVaM2xPeE5pVUVaTHQrNERkSlZJSzdxTmRCeHo1VWxCVFg0RVFPKzhaVE91?=
 =?utf-8?B?ZVBlWE9QMG04MW5PMlVPQmdZRjA2UnJGSGF1aWJsTDBVQ3NKZFh4QVhmN1JQ?=
 =?utf-8?B?WkZGZFRPY2dGdkZuanZOYkRua1dHc0tJV0EzQ3lVQWhDNVhWU3FTZDJaWVRD?=
 =?utf-8?B?bWpYSHFlRjFvT2ZJSzRVamVpSGIyTm9WbUZoa3dHZFFTVnFYMU5naWZYZ2VT?=
 =?utf-8?B?aG8wR1k1ZTJpM0ROZVZmeHV5TWFWYkw3cVUvMXYveDJIaTR1ak00OGhvY0lu?=
 =?utf-8?B?VkJUZ1l3NWlaZUhpRW5RaCtNKzRnbWRpQ3NzdU5hai9LWEpDd0M0aHZoRmhy?=
 =?utf-8?B?bDhqN21VWWgxa2pOWmRCNWZ2bnpuSGEyeGFsaFBLb2d0YWh1d3ZGTUNqZE00?=
 =?utf-8?B?V1hJMjJ3Q1hWSllYZHlwUXFLTlQzRjVOTUh5b0hsYmdxSi9iSHhGS1ZjR0Vr?=
 =?utf-8?B?WmhqaURJTFRRUk5YcW5waXdoMDBIOFFKL1hjR3pGMnJXajh6bU5WZ3BzUTFU?=
 =?utf-8?B?TGc9PQ==?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67bc19d0-c305-4387-9df2-08dcc1b31208
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 07:30:02.6550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iuIig+f4pjdVRv50xUmk7fl0AgTxB6xR0C5TXPBtOc0JfGOARpS7b0LrZPmnlWcjSYTXJMFU6nUTmGStUIMaeQTEY9DRUPcq4lKacqaXdvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8006
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240821_003012_660977_784A06A1 
X-CRM114-Status: UNSURE (   6.97  )
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

> I tried to reproduce those warnings, but could not get either one
> with a plain make command and gcc 14.1 (or clang 18.1).
> 
> out of curiosity, what compiler version and build command do you use?

We use GCC 12.2.0 and build via the BitBake recipe:

https://layers.openembedded.org/layerindex/recipe/52214/

The recipe removes hardcoded CFLAGS in the Makefile, so it is not
obvious to me right now if we get these error warnings due to additional
CFLAGS we inject by default to each recipe or due to below patch alone:

https://git.openembedded.org/meta-openembedded/tree/meta-oe/recipes-kernel/makedumpfile/makedumpfile/0001-makedumpfile-replace-hardcode-CFLAGS.patch?h=master

Kind regards,

Stefan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

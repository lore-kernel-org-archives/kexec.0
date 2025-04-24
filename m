Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6A6C369D5
	for <kexec@archiver.kernel.org>; Thu, 24 Apr 2025 20:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ky/OJG+7ZLU7tFhG9sZ1NExnIARuoIGHNfZxtZBMYxc=; b=KMILIf31cgaIjccY9vTYIQYbRY
	/nit5OVu1H1QgedSwWiJyvy9I3efczn/D13bZnD9X7ljwbK74ofBYn+vutUCTKvyE6dVeESuRzyNZ
	aaN1GrRhl8CoQR2/SuF3nAaZDu2lLlmVsv6RHgQ2IrOf5Mj4JXS7fGPFp2kYwzE/u1TDCR1hv8ioz
	30f6taS3B5JGJc8kxHVB8GCrJsYpW9bJEMJK5oh/QTriZcYZhH3dwVsEHzmF/+9pqGryi2RMTgCg7
	HfGAyaFzVAbb/bNg5YZgJ1Xf+rnyX+3ooGPOpVKCyPSJdHECrpslHZTGLL3qYrQuGuRRzUlhJ35zC
	r2IbczlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u82yN-0000000FIf4-3EOS;
	Thu, 24 Apr 2025 20:15:03 +0000
Received: from mail-mw2nam10on20612.outbound.protection.outlook.com ([2a01:111:f403:2412::612] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u82Ei-0000000FC9I-35yL
	for kexec@lists.infradead.org;
	Thu, 24 Apr 2025 19:27:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWo8B4rWYUBquEnTTuSKVZ9/ClFWL0tuh4abv5IWDJlQ+G1O7M5Jgk5fJ7/JmRYl22NxqfFUmptudNE1PzzhCGO/2S03kCNvWaG9F9H4SjgGr7OUN9WxzMkEggrWn12LaDSlJtYMEa9CU5sLfuzwE/QgZREzm78UhIcJGpD/hXBJmGIWDfs31ygwj8waXf7/ESmS/Mtsx6ryjvhGGjavniEYo+6tmGvCzobepRUoUM/P3IxPM50+uf941+15dI91iuWGRYDwG1ul6g++YXvneUDjHFhWUSeKsaVgYItNDjpENzzyl1c271LKdy6+dzSqF3DfgVNmmrUpEDjL0KHTvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ky/OJG+7ZLU7tFhG9sZ1NExnIARuoIGHNfZxtZBMYxc=;
 b=JYBxh1ieyUz0HCOBBB5Vgoty0Mh7rE25XcUu70o0Ft8uq4LrsZym5VNfBB8+5ImNK3J7VhXCFVaL0uI5KQYIamtZccxg2doMNMpk4QLHIxZWjmuQY3kxCCZk4kK3eppN0JToNiPFnTJch+2g6bTFWkrGNGhVnEayvfAOMewgxvcgQldLX9zpN6dbMO63vz7Ld3/QzIiz6sMdMUjnxHHS6nvt3EnDUSZ1xWHLZRtwmTvSInWZ+Lml+yLhGcZ1SIHTL709j3Rs6U4hJBEoe6qtmEEZoLPIsdSWPHQYajbTDXJjcoowO+XcToirPx3RcK4NyAaVeEfyjeQzOvVDMgDs3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ky/OJG+7ZLU7tFhG9sZ1NExnIARuoIGHNfZxtZBMYxc=;
 b=b7PORn30pN8HsHARqBCTydwUAJ2/DumVIOmn2xqwnRgKspCf0HXQ0TiHtOmpOcHXiOVLoM4EMr29apIc5T2iiYT5icdN7qiFbZ3i3QXPYNz5gAceQG25wKHxp7dO+fUiIxrkwfctzgWEvUgbr3N861ThDHKlRhqTmM+0O8jBL8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by BL3PR12MB6426.namprd12.prod.outlook.com (2603:10b6:208:3b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Thu, 24 Apr
 2025 19:27:48 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef%5]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 19:27:48 +0000
Message-ID: <0238d607-3fd7-4deb-92ac-c01aca2090fa@amd.com>
Date: Thu, 24 Apr 2025 14:27:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/sev: Fix making shared pages private during kdump
To: Tom Lendacky <thomas.lendacky@amd.com>, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, bp@alien8.de,
 hpa@zytor.com
Cc: michael.roth@amd.com, nikunj@amd.com, seanjc@google.com, ardb@kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev
References: <20250424142739.673666-1-Ashish.Kalra@amd.com>
 <4311dbc7-efb5-ab6e-046c-87e833119236@amd.com>
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <4311dbc7-efb5-ab6e-046c-87e833119236@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0061.namprd16.prod.outlook.com
 (2603:10b6:805:ca::38) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|BL3PR12MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb2f446-0382-4466-65a9-08dd836618a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZDVGbmlSNXROTkZkSG5aTkd0cE5jZTJxYW1pVy9MaUl1TU50cUZhVzR2WVh5?=
 =?utf-8?B?K3hhc2hldE8zbVhObW5IRzNNN3JLMjlsV05qYjJtQVJsNUphMFdIRzRkMDJy?=
 =?utf-8?B?ek5LSmhNTFlaMjNvNHFzOEFDRVhWVW9xbnp4QWgyS0x2QzhQQ01SUW9sTXhx?=
 =?utf-8?B?NEFiV1NXbkRkajV3Q1lTWGhWZWVaZVBrSldNbCt5SHpIVXk2NFNrZlI4dWhz?=
 =?utf-8?B?aFAvY2ptMkZKRzB4aGxOMDNDT2RrUFRxdStDVWEyeHl1dVdjNkVQN096ZTIz?=
 =?utf-8?B?N0hQUGIxZjdvbUp3TmR4a0dhcTZZY1ZqWFcvQkdzTERiN1dWQjR0WUxZRFcx?=
 =?utf-8?B?dDVKeWJmOHNTZXhXLzZMeUJvN2VGb0hINVhaSXNObWpSbUEybDFuNlZxcWYw?=
 =?utf-8?B?Q2gvUnZLMEdxWFNEVnpSZlZGT1pCWDJWa1ZWcEs4QkVkV2szTmUwNFNpRUkw?=
 =?utf-8?B?Q3VaVWJmSWtOeVA2S1NLVE0wOXJDR2pLNDEzUXo2WWczYW93NVZoNWFMOG1w?=
 =?utf-8?B?OUtHQURKNkcxSTVGaFZ1MktuNnE2Y1FqdjRDWnZBbGdjM1cyaStmaWdOZjJ1?=
 =?utf-8?B?dGFuS2pOdFpUVHNnalk5bGlORHhmWlVwOWd3WEdZelArNVFZY2ZVQzhLdURo?=
 =?utf-8?B?OXBxU2ZlaFlmV0gweUJsVUpWdFd0RTRBeGZlN0RGZlBiRnVzWnJhbGNBQ2tw?=
 =?utf-8?B?NS9OLzNPQzR5QXZDWUNIMnVkZzYyVzM1c3BkS1k3NzVUdHZ1eGhPdGthSkVF?=
 =?utf-8?B?dWJHZDgvSk80am9yR0sxV0prSUJ1UXBVbmdWSGEvekNQemF1MDZndkMrL2gx?=
 =?utf-8?B?Q3NHQURNWUpSRWtJZTFUaXJiOWg3eVNaSmVRV2hXMkRmWWdvNndVRmdiZ3VG?=
 =?utf-8?B?bk5KTkhiZzNmVVV5ejcxb2J4QjBRSFluOExSZzRRQWEyMXNCc2FoaW03L0M5?=
 =?utf-8?B?dldSeWRBdDR5UWcvNHJTbG13Y1ZOTk9GWXduVkNURi9Wem9uL0syRldudWNQ?=
 =?utf-8?B?eFRCejRHNzlEUGdxZXY1d210VmhSd1hEZVZGNUwvQ2M1Q0pLaE41Tkt0dk1V?=
 =?utf-8?B?ZCtqNUhSM1JVWHR2SC9YbjBsL2gzUWc4SzN5Z1pkK0NNdXNZVDJRSWNjWHky?=
 =?utf-8?B?Z2MyeGFMM1F5S1FBWUFEYzFjOEh0c21LR0ViMmYzdytrQTEyNnNwRC8vanI1?=
 =?utf-8?B?TWVWUFY3ZGJBK2dBanhLby9vUEtCZWZPNFZnYm9pUlhNTWdXSTc1TEZldTNy?=
 =?utf-8?B?dCtrd0VMaktXaDFhVmVMLy9oU3B0RWkySHp6cVVTaFNBN1NjbFpSQTAxcDBs?=
 =?utf-8?B?VDhZVkZBYjNJMjFKd3BUczF0b0RvcWlaemlMZTladkJ2TjNDaUtLenVTK2Ev?=
 =?utf-8?B?bnY3Ly80bEhwWG1LSVpkMzBOSkt4ODZTdHU2Y25SRWRRb0RKYUFwcXVoOC9F?=
 =?utf-8?B?RW5EK29ST0lUV3hRZlcxSHhWMUVCR3NXNDJOcmU5YXlVQ29GOWlna3d0Uyt2?=
 =?utf-8?B?cmpTMnJnbWl1RFlEaWluc2FuK0pvWnZHd04xNTcyNHpDdG5EMVAxNUxydFRt?=
 =?utf-8?B?RVArTjV5ckV4VnJVYUNOK3hDbGNreVpTYk9xOWkwWjVXc1pEc3IxY0Zmendx?=
 =?utf-8?B?dUVLNDBzYWwwWWV0SmwyS1hRU0toaWtNaFNETGRNNHlWakZGc3FTZ2lkV0ZV?=
 =?utf-8?B?NEJlUTFIOXl5alhaMnNTbk9iZ1hieDl0a2hIcDV4dUlBcG0vUDdYbmlPSDlm?=
 =?utf-8?B?Z1ZEY1VpMDB3Mi83b3JrcjZxcDcxSC90TFp5VEpOUVdWS3VTYmx5WDhEaUFi?=
 =?utf-8?B?NXJ3bHJGczJ6emQxVldSMHlXcGlvT2Z0L0VZTUM0eHhPamNwbS9uakQwczhi?=
 =?utf-8?B?My9IQUR6VEl0LytEVEZpVWNLWTNRbVJZNW9nUGhoeCtNL3JJZDlhZXQ4bzE1?=
 =?utf-8?Q?MBvZX6FM4/k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnJReGgrZ0xZTmZVT2FpWWtORXhDaWZ5d1NyT2NQRnZEQWN1dW5INUxDclQ2?=
 =?utf-8?B?bFYyNWd1V3pHYktWaHMxRGxzNEF5alhnZWh4cjc0M0d1RzBLdVdWb3k2TmhZ?=
 =?utf-8?B?c0oza0xNT1FXSUJBRDBteWZ5N204bEQyRENQOGFnYkYrYXJ2Z21YNVBRYVUx?=
 =?utf-8?B?NHZDUnBGWENSSzZoUFQ5Z2hJSFRpVlo3MHZJRkt0citiN3pBUnJRQXQyc0tB?=
 =?utf-8?B?bkkwRVRoZTEwUnlEdlRzRHlPdVFOL3MwWFl2RkoxTDhEbkxuUFZVYUNHNzky?=
 =?utf-8?B?T3ZXWEhlc2Z2UDFCcHFiRGExZVdBbnZVU21idUVXNGdOK0NHTkRneUp1elJz?=
 =?utf-8?B?RG00Vnp4OWdaOStxSm1BeWhzNkVWNUVtNklmQkdCUFFyQkh3V3dINDZVanJP?=
 =?utf-8?B?dnd0T2FaSlloRkRZc1V5bG5hNnc1TjRjQlM0dlBRTDFnWXNmcm0yMHVLVk4z?=
 =?utf-8?B?aU9qam10R2xOVnVtZ2FubHZDNy9Udng4QW9LVEtXeVRQUU0wUmY1alVUUndk?=
 =?utf-8?B?SS92WkdrV256SlBDZWtjWHgrdHFxNWRhOWUvVkxtV1FDeGZ5SU8xS2dwN3Q4?=
 =?utf-8?B?TVppbHhxNWl4a3Z3Nmw0Mk16a243Y3ZMdzRkeUlsbDZyZmdyZnl4Y0k1ampy?=
 =?utf-8?B?cHpoRmFNbnpYcFYrSk5KYWNmT3hOTGMzRjFncUk4UUlncmhSUEVQeVJFcm1H?=
 =?utf-8?B?eTFIdjEyajdrTklpS1RSQmpCeTVBRW9oSzYxTlFDT3pXeVFQY3ZEUkVua3VQ?=
 =?utf-8?B?QTRyWDNZYlNDMlYrR2Z5cDFLc0V0WGRTQkFFcHRrZmJGZUlIS2xUSXpBdmdm?=
 =?utf-8?B?Uk9UelY4dzdXN1RNMlpJeUhMY1lUSG4wbTlBbHFUNWVyMWxvS252NzFzYVlU?=
 =?utf-8?B?STVhUVFjM29kRzdHWFZ4dVB5WnFkNFVRK09TK1Nxc21KWnJtVXFkSS9VYWhk?=
 =?utf-8?B?aVJxOFp4YzVoRzR3eU5Dc1Q2OWIrSEV6S3A5RENXN2xtK0dJZWcwQkhsbkJD?=
 =?utf-8?B?enpkdUxBOG9yRWs4VFMzbXZ6dExFQndITkp3R3dFbEJSRU9pR082emUvM25G?=
 =?utf-8?B?M2plYyszeGV6SkNURGc4RkNCYlBHeUVSdGFjaW9IRjBodFNCMUV6cXE4d0No?=
 =?utf-8?B?VnpnQS9sSnhLNHlSMkFiTHdwRitNbDdoRlB0RWlidDczamxTRWFOMWN5RXJo?=
 =?utf-8?B?WmsyaHo0aERFNzNNQm1WcGZTT0tySDlSUW9md1ZTY3JTcTNKU1pubUxQTWxP?=
 =?utf-8?B?T3YvV0VsS0puZDBHR1l1SzVrV1lFSWllMThxYnBQck13VTB5TmJadVBuOGQ2?=
 =?utf-8?B?Rm1Cd3dOS0gzWnBVZmhDcVJBdFNQZEpqZE9oL3ZpMnA0SEZvM3VFOXY5VXdu?=
 =?utf-8?B?YnFrdFRqNlk3Qm1LQ2dySjUzQ2RRWWo2Szd3aG8yTUZSRlRGendrMExTdWVo?=
 =?utf-8?B?YnQ1TlBoNmxGQzR6N01FWlRoWFkrRHlaTVF4QjBVY3N1VXBkSGhuTjBFQlFi?=
 =?utf-8?B?NWtrU2VWMkFhbHlwL1o4d0h4cUdzOEFrbjJWbXV1Mnp1SGxlUGc1a0VTOGo5?=
 =?utf-8?B?czE4ZWswVFU0czZEbklTZERvME0xMDRCZVh3NEhldFg1N01ZaEZua25ubVQ5?=
 =?utf-8?B?SmtGME1kd2Q2bGtjUFZJaVV2VW9YTzB0MDRsbElSREFNUXJ2alVXUmhmVmI5?=
 =?utf-8?B?SituZi8wSWVHKzhmY0hDTU1EVUhVZUtzZTk4UzFwOXdQSkk1eGE3bE8zMlZv?=
 =?utf-8?B?bjg1VEEweXdaUjlSVC9xZHh4Q1lSSEk4anJMbEhnTUJEQ2tvcGROM25TaEtu?=
 =?utf-8?B?K0tLSGhpS2N0akJzdEF0RGJ2cExJQ2ZBK09pWnYxSkpycTV3YkRKMkNzOWFh?=
 =?utf-8?B?MUpUWElnSUE2eUNJVVJVTHp2WnVsT3FOcXZidSthRVBOZmRYNjF1MS9XamNQ?=
 =?utf-8?B?QTFSUUNGZHpRdUE5SUdqRkR3eEJEN1BwR1R4WWEzUUIvU2RBejNkK1dodVIv?=
 =?utf-8?B?WWVHSlpWYmJJZUtSc3pPYUlPbFhRWGQxUEJVSzJkWS9BMkpyVUlzSUJ4VS9q?=
 =?utf-8?B?eHJDV1FIMFZNcWxRVVJnTm9FTWIwRENYUUhZN21NT01JRFQ3ZlhGMlBFVDZr?=
 =?utf-8?Q?kdSCT++x+5zjHefoPzUjeVt8H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb2f446-0382-4466-65a9-08dd836618a5
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 19:27:48.2015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWy7SUE0M6ywC0dgoIPCL2by+AWFcHBeTIiG7HW57c0Rx1uaVt6KccHu3uHwEw7eO76yi32LugKDN4Qs+DGXMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6426
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_122752_782445_94399185 
X-CRM114-Status: GOOD (  17.99  )
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

Hello Tom,

On 4/24/2025 10:29 AM, Tom Lendacky wrote:
> On 4/24/25 09:27, Ashish Kalra wrote:
>> From: Ashish Kalra <ashish.kalra@amd.com>
>>
>> When the shared pages are being made private during kdump preparation
>> there are additional checks to handle shared GHCB pages.
>>
>> These additional checks include handling the case of GHCB page being
>> contained within a 2MB page.
>>
>> There is a bug in this additional check for GHCB page contained
>> within a 2MB page which causes any shared page just below the
>> per-cpu GHCB getting skipped from being transitioned back to private
>> before kdump preparation which subsequently causes a 0x404 #VC
>> exception when this shared page is accessed later while dumping guest
>> memory during vmcore generation via kdump. 
>>
>> Correct the detection and handling of GHCB pages contained within
>> a 2MB page.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
>> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
>> ---
>>  arch/x86/coco/sev/core.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
>> index 2c27d4b3985c..16d874f4dcd3 100644
>> --- a/arch/x86/coco/sev/core.c
>> +++ b/arch/x86/coco/sev/core.c
>> @@ -926,7 +926,13 @@ static void unshare_all_memory(void)
>>  			data = per_cpu(runtime_data, cpu);
>>  			ghcb = (unsigned long)&data->ghcb_page;
>>  
>> -			if (addr <= ghcb && ghcb <= addr + size) {
>> +			/* Handle the case of 2MB page containing the GHCB page */
> 
> s/2MB page/a huge page/
> 
>> +			if (level == PG_LEVEL_4K && addr == ghcb) {
>> +				skipped_addr = true;
>> +				break;
>> +			}
>> +			if (level > PG_LEVEL_4K && addr <= ghcb &&
>> +			    ghcb < addr + size) {
>>  				skipped_addr = true;
>>  				break;
>>  			}
>> @@ -1106,6 +1112,9 @@ void snp_kexec_finish(void)
>>  		ghcb = &data->ghcb_page;
>>  		pte = lookup_address((unsigned long)ghcb, &level);
>>  		size = page_level_size(level);
>> +		/* Handle the case of 2MB page containing the GHCB page */
>> +		if (level > PG_LEVEL_4K)
>> +			ghcb = (struct ghcb *)((unsigned long)ghcb & PMD_MASK);
> 
> For safety, shouldn't the mask be based on the level/size that is returned?
>

Yes that makes sense and i will fix it accordingly.

Thanks,
Ashish
 
> Thanks,
> Tom
> 
>>  		set_pte_enc(pte, level, (void *)ghcb);
>>  		snp_set_memory_private((unsigned long)ghcb, (size / PAGE_SIZE));
>>  	}



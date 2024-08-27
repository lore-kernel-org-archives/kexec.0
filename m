Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E235C54734
	for <kexec@archiver.kernel.org>; Tue, 27 Aug 2024 13:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:
	References:Cc:To:Subject:Date:Message-ID:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=1bD+Hg4qm7qzGZn20YfDScsjUOo+xsxPfY2RHk0Etik=; b=AbRxocQkob1BXzx6MQejljRce+
	j7Rps0TzhhZ5OpQ/XPAOAfPe5uScRXVkf4cDxiFDw//yvmbmtjLKJRmLqFgkw5fMvn5aif3eTnn72
	rsurSqO3lg7vhrrEvSSmJvK7ApRkMwnnp1dRQfwmkc2lA8UJaA5azmlJaBrm0kQij0VT2BxkFhuOc
	kCEwuJ0ZXVvPxXHMrwKI8fHC1NZxZqJnu2Hdec3vxznQ5Pyuh5T+XXXUzVE7wd59KKn9nMfOQaiRI
	oHsX1a6uUxIUzIgHxM+raK9GhWwAl0ZWWIJP+96dHieylkGeUq53quIp6zrFe9m7rs7GLugAfNwCz
	LegK4HPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siwcS-0000000BWun-3Tug;
	Tue, 27 Aug 2024 13:52:24 +0000
Received: from mail-mw2nam12on20628.outbound.protection.outlook.com ([2a01:111:f403:200a::628] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siwcP-0000000BWtl-2fU0
	for kexec@lists.infradead.org;
	Tue, 27 Aug 2024 13:52:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDc5uDJgH80mPn+2JD1HMSZEePipmbmNADS2+rDue6ChclQHv0Beyez+OSuYhDXD1bz5hLfKFdfLocCKxYpbshlXSLMSYNk3ZWzAyH4jni7uuHULcmFSjmsqC4dNoQvhZAWRwJA9rMMFF1C09anoSAyZ8URdqxwB+KcL3hrR2AU252YmeQwe/8A7uzJrJzHsBI9bjwNUp4PhtNgnRYCyAkk39obsNvC4bZ3v9iUDIvyYMfoYPKiUTKuFgVIA3VbktxsmEUSF0sVtanBukOJ+Qzc45KaUabrn1GZ3mSaBc03ojmjjEYVwuP6qZJWRTwNEyxh//+8JPpH+hwaWulQQ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKy9vNXy+hJkYv5JGkBECxuDJzQgVSzKuNLctBRsA7A=;
 b=hiY8o/hiu3lSX0bbc1rTKKnr1dc+litSBwFgeYNrwNi6MkTyvHPiwSiMG5Z4jRLoLhb9niPOq7ChoyqeADkkRf12+ZHVMZhlq71GmPQdlIG04hmPz4FNr88hoM7ducn2zNpWZNzOtx+qKMRbM0h+UGtceKW9h+flZDUmV47bmKFyd5dV7DO3p54nB0WunqEu8hUWAeJdTFvEhqC5sk4opV86nyk1WisyqJLK3iIcu8xtlD0VIV+QN0p87ZJo21BAugfKKB6owEzYM51ldsdu2td0/JpPP6sDXwKppjNcDGcfBeiJqx8qWoMZEN+wRQ/WQpjE6JOxkML8fb3bTaMqRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKy9vNXy+hJkYv5JGkBECxuDJzQgVSzKuNLctBRsA7A=;
 b=fWUGcp8ZThGLUEZ51weEmFgju65RjY0J8gPGDWG4MMj8uuj36+YHwqfUXycSsMd1bR0sXIgXdfL5F4v5rfYad5ZciKlhkzpgum+++hAnr9eFxG/jGVWa0LWupJodpmRtySBzlJ6vQmzKW1XyIJXcq9DRUUzku+uJv3aM5pbgn8s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by LV8PR12MB9262.namprd12.prod.outlook.com (2603:10b6:408:1e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 13:52:17 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 13:52:17 +0000
Message-ID: <be6e5ab6-8b43-1a3f-39a6-b4aa5e0523ac@amd.com>
Date: Tue, 27 Aug 2024 08:52:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/mm/sme: fix the kdump kernel breakage on SME system
 when CONFIG_IMA_KEXEC=y
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, noodles@fb.com, x86@kernel.org,
 lijiang@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org
References: <20240826024457.22423-1-bhe@redhat.com>
 <35e40987-1541-cbbe-6b16-1ddadc2c4c35@amd.com>
 <Zs1FrZVuZK14Je7z@MiWiFi-R3L-srv>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <Zs1FrZVuZK14Je7z@MiWiFi-R3L-srv>
X-ClientProxiedBy: MN2PR17CA0020.namprd17.prod.outlook.com
 (2603:10b6:208:15e::33) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|LV8PR12MB9262:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d3b6464-889f-43c5-70cc-08dcc69f76d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUxmWk9HYjZNbkJUWHpBeGYzZ0s1UWU3TE9DTFFTNU83OGtLSFdiWUZkS1hJ?=
 =?utf-8?B?UkN4RnVReTIzWEZqU3Iyano3K0NSdUlxTzdGVkFuZVRCR2w3aURad3ZiRC9R?=
 =?utf-8?B?Q3pybnF0UWVtTmdhMEIvZFZGcWlxQmVKL3NtMEszTjBvcjVwaE1SaHQzOFlV?=
 =?utf-8?B?L1RRQ0wvYmYwUW5ERStpOW9sb0tlQkFhc0IvZHBKdXVQY2hoVm1VOTFhQlZx?=
 =?utf-8?B?K2pjaVV2emE4dXJtTmpYVWVTZHBXOGhXTU9SMGRkQ2diSWMrbzdiRjgyZklU?=
 =?utf-8?B?cysxUXg0cjJqZGVTcUN1TVlkYmt6Q3hFdWpNbzE3MVJ6RWt6cWlOK1pOZzQ1?=
 =?utf-8?B?Ym83dmsxVlVmWW5JQzcvek9vd3NKSk9HbWpkS1JvcWZYbTBDd3FKMkJyUkxZ?=
 =?utf-8?B?KzVhd2R4SzZsZCtyVVU4dXl0KzF4dEZzOXZGb1A3dGJCTGRwUVRaQ1F6dS9r?=
 =?utf-8?B?K0VGMWZSV1crb2VOcHRRYnU5cE9TSmZaYzIxalBPOXZDRitKOERRS3FGUXVZ?=
 =?utf-8?B?eEFZRHh1b3A0QzZUek1DdDZncEhad0hXSFRRR1lVN3ZoME5TcGx1WnQyOGQv?=
 =?utf-8?B?Z05hdFppRWtpVzM3QXR4SmZJQU5Jc3pPVmVVeTVKYk13ajJFMU0xUHg4dTRS?=
 =?utf-8?B?Szd5MStUS2V1NFhYV3RwSnZrTzJBZUdVemV0SUQ2VjlQYU1PbXV2OU52dXd2?=
 =?utf-8?B?T21HVXBEOC9RSThxVUwyY0gyM2ozNjEyb2VhakZqdksyZTVxSjBlUFh3eEtJ?=
 =?utf-8?B?b1F4QjRyR0dKWGltdy9zQUM5ZzFwd09yYzdJUUgrWHNHak1TY0toR1NxeG1N?=
 =?utf-8?B?U3lTME80cUdMa3dkVWRVdnU0dVp0cjdOZEVGWHVNNHgwRGEwMk5CQUJaYXM2?=
 =?utf-8?B?N2QxSXdMdnp6TllRSnNEdloyVGFZSno2TmFBNUIwWkptWlVRTEYydUlHUGxq?=
 =?utf-8?B?WmRaL0gzcFFTc21lY3J6b2RzcjBuMFRSQTg3djFsWVBxbE9KbHh0UWZkYUs0?=
 =?utf-8?B?MzZnNjBhVHB0am91Tyt2aGxUaGlJN0FLZWxLL2RTVmFzNWxOYTY5L2djbkZZ?=
 =?utf-8?B?NmxWYmVNRDNOcjZiOTJtdzk4bytyWlpTT0ZHU3JNOTQ5VUIwK2kvcVlaYmpO?=
 =?utf-8?B?c0JhK29NSHZlb0lpeVVrcTYycmRyVTVQZFJ3R0ZwZ05nLzJ1MVZDMHdrQW82?=
 =?utf-8?B?a00wZ2EraHVRSmM0S0JPaDhyN0JqRk51U1d1dHMxa0piSkg1UkN1OEpuZElm?=
 =?utf-8?B?SzU4cGh4dWtSZGN5eVUyWXpMVURPKzdNbm1aZC9mdUFaYlBMNHJkWm14R0pJ?=
 =?utf-8?B?S0pKelpoV1JxVnI0MUdCNlFBT2ZvR0JyYTFwdEtlbGx4REpxWVlkaUFMdmk1?=
 =?utf-8?B?RDU5TFNpbUhsakFzS2VMZWo3TDJJdzc1TnBtc0FMN1dBb0J0Z1ErVncrRDBR?=
 =?utf-8?B?K29uOWFtTERVaFR4R05mdkZaaTRiSGtlaGMwNmN5M1kzTUlBU3F0RjFkc1ph?=
 =?utf-8?B?bHNhUldrTjB1VGJTa0RCdUtpTTlhbWt0WHYvNHZCMm9jRlZYOHIrUTNuaTJY?=
 =?utf-8?B?THUzTVhHV0tSYmtycUh0SzQ0VEF5NFN6alkwOXBRb25scTJ1NUZEVHVWOTlO?=
 =?utf-8?B?cGZmZ29NTmlqRnNXejg1QzNTckVUOHhIMTBJMGRwbHRENEVnZnF3WmhhV1Uz?=
 =?utf-8?B?UEdjZGZJRFg3SzRMMFNkcWJTYU1jcGN0UUdTeVdWU2dzZFdFNG1Ma2RvT3Mv?=
 =?utf-8?B?WmJjbUhhNGprYzlJaGdoTjVvc1EzQ3NPdHRQTW8rZVgzZWJSNVQ0T3R0d1N6?=
 =?utf-8?B?dEpVaUNNalNQaHE5ck1UZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkJxYTZTM3hxay9OZWNZV0dCbXREKzR2V01ZRHhWVlNaZ01PSUtvM0R0eUxp?=
 =?utf-8?B?SUVMQisrMGNvTW1nQzBOZmw2TndUMHVpT0VxdHI5T2FwUTVaaUg0bWtpQVow?=
 =?utf-8?B?dkhpME43RzBLOGZnTmpNT2FCRzN6YnhpOFcxcjE5V3ZVb0Y1aXRjYnNUdGQ3?=
 =?utf-8?B?bGFXNkd3OUlxZkNPak5WVEc1VW03a3lIT2hQQnFMdU40am91eWp5ZHBtbng1?=
 =?utf-8?B?bFc1Y1Z5WmhPeVZmQjl3N0YwVXpKOFVEUFR4SVNhUjgzMUUxMldQZGo0Q2hK?=
 =?utf-8?B?L0FZVWhjRWdqMVRiZ3JzcnRRSEJHa3hlOTNIdHovQWhhNHpuZGhJQnJ6Qjl3?=
 =?utf-8?B?ejVUenBsdGJsM3F5MytLNHhUVVVOREdIeStKTkNGYSt5YTVhWlJ1YnB0Z3NP?=
 =?utf-8?B?d1h6b3B0aW1mWHQ4ZkdrRnl2MlRESTJaQm5iWVVONnhPWEg3WSs0eTZ5UjVU?=
 =?utf-8?B?RVNVU0I5NTBXMlhmTDFUWFZiSjBSL2RCemJvbE1nUUw2ckQ5TnFqbnRNWDdB?=
 =?utf-8?B?MlV6QTJTcVBsWVZNSDF2WE5KNS9nM3BFcXlyUjQyUy9iK0tmRmUzZjBrTlFR?=
 =?utf-8?B?QzlGcG9ocXA5V3gvdXdjcUdwT25ZNkdwc2hlclAvQzBmSDRLOFB6YmR2OXNa?=
 =?utf-8?B?SXZXaDhJUWdOa3pZdlllZFpVQVorVFlzSFhnNVhTMGl0WS9aWEovK21XZExI?=
 =?utf-8?B?VDEzZTRWbmVicEFNNnUyR3RIZ05BVUszU1JqbTlNY3ZYUFp5NUhaWkh2aFFi?=
 =?utf-8?B?VDh0eUVPN0ZFOHh0eDRkaTE5cnF5alhMcFVJcDArTUc4UE5acmxZbGNzdGdz?=
 =?utf-8?B?ZDljR2pHcFI2V0c2NlB0cXlMRkd4NFJ1R1NrYXU1NHkxWGlESVhhT2NUZ3RG?=
 =?utf-8?B?SUxIU3hFZ1RRQi9Fbm5VemVCRC9PVmRSSWh4ekZ6bnNUVzlZN0dZcmVsWlJR?=
 =?utf-8?B?b0w3dG1ESmMwWFBuVDN5Q3RyVFRUNEsyb1lMNTBpdTdEeUo3b0RqUFFnZnE4?=
 =?utf-8?B?VkhXTHpMWFVpMFFvQW85SjIxOURzdXQyMWhCYUpOQVB2eENEREpWTFAwTmY1?=
 =?utf-8?B?RXZYdXVSV21GaWs0OTdsVmpOTUtZWE5qQnNoWS8wRW5NZFlEYm1wUmQ2dXha?=
 =?utf-8?B?ZzNDMHE1WnlObTNRY1hUcDZvNm9oRmw5a25yNndIVm56Qkk2UnE1ZTJ0THJp?=
 =?utf-8?B?Y3U1cC8xS0RFSE9rSFNmdzJCVGFXSHF6MmQwSlpKM3I3eVIxWHd2NXBLV3Nt?=
 =?utf-8?B?emlFVERBbVdLL2oyalFQWmMzOStUUnhwZzFmRFpRR0ZXVEk3RnhOdi9pZlJO?=
 =?utf-8?B?cXM3Tkc4Z252Qkhqd0xwTW9qL3B5aDNvdWU4RHdHb0tLZGtXSTNDZytpSnJC?=
 =?utf-8?B?eGdMVlFVd3l6bDdmWTNpeW1DaHFTdmNVL1pFOXhTZVdmclQ0ZWo1Qnl0bXBx?=
 =?utf-8?B?OXp5ZEtxN3hNdjIyUTRJWU9Vb3d2UEtHMG1BUmhtZzF0RElZblppZlFyY1RP?=
 =?utf-8?B?MmRXczBTd05WZzJCeHJhbDdjUm9qazU4UVFKVVlQQVh4Z1dQMnUxaW5Xek14?=
 =?utf-8?B?bFFLeUtkRmRtUUZWcGNSdGFFMGhJbHRGVS9vSzJvQlhhTWRPcklhN1VsU2lV?=
 =?utf-8?B?REEwcEpRVk9PNTIwcnZqcEJ6Zmw1RS8vRkxGMU5KaFRmenQ2aGN3WUVPMWpt?=
 =?utf-8?B?dWlDdFpBYlNZMWR6MFdPVkdXTXIvYnlsLzBMdlpPZ1lOYUt2aGJtTGRqQ0FF?=
 =?utf-8?B?USsxNWovTlU5cEZCME5TRmgzRHNZcFc2R1Rxc09HUmhFWk9DVGU3bG9yU3JU?=
 =?utf-8?B?SEVvL1l2Y3JsM1dDL01wNXp0NGxvZkxZMGdHeUVXcFV2RlFGVE1hcUM3R2VC?=
 =?utf-8?B?M2dqWkM4MXh2WDc5SzVKZll3U1N0UllGczBwbTFlTEp2OWVEbnNXYWRQd29q?=
 =?utf-8?B?N3BMUFJwQTZGMWYxaWRxb3hYdWQyTmZVbllXNjNDTTAzUnE5a1JYdFVjd1pi?=
 =?utf-8?B?WVUyaEN0dUt0TDFEcytFTlJKbHBtVkg2dWhmUVhveGZGZmhMZHhsajZsaWZo?=
 =?utf-8?B?Qjh2L0crWTlGZUFCdkNCYmlVZ253a2xFN3llQnBTdE9BV212UjAzMFZ5ZTdi?=
 =?utf-8?Q?SAhBDzrBum7mWg9imaYi8zXQV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3b6464-889f-43c5-70cc-08dcc69f76d1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 13:52:17.6965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7eS9+ITmYGGLqROMR5Y5ksevbldVs4gStwPVrKWfm5ORbl1X5HacEBVexKE3BhMGKjodZ4FMd+wQGRuV8vErNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9262
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240827_065221_715548_2013A124 
X-CRM114-Status: GOOD (  17.39  )
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

On 8/26/24 22:19, Baoquan He wrote:
> On 08/26/24 at 09:24am, Tom Lendacky wrote:
>> On 8/25/24 21:44, Baoquan He wrote:
>>> Recently, it's reported that kdump kernel is broken during bootup on
>>> SME system when CONFIG_IMA_KEXEC=y. When debugging, I noticed this
>>> can be traced back to commit ("b69a2afd5afc x86/kexec: Carry forward
>>> IMA measurement log on kexec"). Just nobody ever tested it on SME
>>> system when enabling CONFIG_IMA_KEXEC.
>>>
>>>
>>> Here fix the code bug to make kexec/kdump kernel boot up successfully.
>>>
>>> Fixes: 8f716c9b5feb ("x86/mm: Add support to access boot related data in the clear")
>>
>> The check that was modified was added by:
>> 	b3c72fc9a78e ("x86/boot: Introduce setup_indirect")
>>
>> The SETUP_INDIRECT patches seem to be the issue here.
> 
> Hmm, I didn't check it carefully, thanks for addding this info. While
> after checking commit b3c72fc9a78e, I feel the adding code was trying to
> fix your original early_memremap_is_setup_data(). Even though
> SETUP_INDIRECT type of setup_data has been added, the original
> early_memremap_is_setup_data() only check the starting address and
> the content of struct setup_data, that's obviously wrong.

IIRC, when this function was created, the value of "len" in setup_data
included the length of "data", so the calculation was correct. Everything
was contiguous in a setup_data element.

> 
> arch/x86/include/uapi/asm/setup_data.h:
> /* extensible setup data list node */
> struct setup_data {
>         __u64 next;
>         __u32 type;
>         __u32 len;
>         __u8 data[];
> };
> 
> As you can see, the zero-length will embed the carried data which is
> actually expected and adjacent to its carrier, the struct setup_data.

Right, and "len" is the length of that data. So paddr + len goes to the
end of the overall setup_data.

Thanks,
Tom

> 
>>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

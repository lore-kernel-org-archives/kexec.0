Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD16CD4F23
	for <kexec@archiver.kernel.org>; Wed,  4 Sep 2024 19:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Cc:
	To:From:Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A5VFFMPxHFhiPNUkTSmPKi8WlFuY3z8StXerFqdS7z4=; b=nP67kh7Crhnk4f
	brfdJbgt/jl1GLj3CXbyNUkuTePqFyHVBWTHZqYBSQPgyCfMUr27bxRal4/ulQBlyfAX6jyg8p8UZ
	pj1PJN7w7KkUBINDe3q4PoRjBRHwZquZw9ZFaetG0qJqmNlWcSe7LR5on1z6Qxik1kHgLrBegWXtT
	7icifcP3KTRio6CgvIf/+Ov4fnLxhRjOGKsbQu/4E80WoFHJ/KHi+E3+j95U75nmlmfIlrZdE4Ejf
	rAO+8pNgGrOD78Yb79KoS7Loz614LYlVOX8h5ua8jsAuda78K9a7lgvDs95/1gcQbhJbeROQysm2K
	irCSOaaOFpbKCFwVwt4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slvza-00000005sCc-3yY9;
	Wed, 04 Sep 2024 19:48:38 +0000
Received: from mail-co1nam11on20623.outbound.protection.outlook.com ([2a01:111:f403:2416::623] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slvvn-00000005rFT-1Sf8
	for kexec@lists.infradead.org;
	Wed, 04 Sep 2024 19:44:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XuCuhKBJIA5llSq7UBokYAHZJCi6xEcsUrTrS5K+ujurGj7ybHo2LlLUtlH/qtkkwnK0jB3q5oU9s8GlCNB7jyg3Xc3j9LP7Q4JUIX5C6F7Fl3p25kFf04afISTMUs/5EmugB8WYmLEuVxM9IBjm95oXtHB28AYYZXZcaRC25RZlntnGGHVJ8AXHxIRnrP0n1Gww+4O5NJGwDg4Vdld8ioF4QUSFzPCAmEcrfAOWS60aam7byvmGYWNoF4VEF24kwnnTtGn4wRxByBv8B7RbdLJKmijI4R1pce7STXXorewH7L+2Fd8/wp9xk31gp/J0fy8ntip7wGU91lNgxObCIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsibxcKAXN+bv18fkS85nWEFtgQgqC+Gu/L2q8r5ixk=;
 b=u+o6LywKtBKegNNL9iLa30byIQb2Jq+q1VOyAAziUD39/PCB/NJtD9/qXkHNelXB4YV4zmoQSsoOXZZDVSEC7fNSaNTrM+vnfMOWiS+DPwZfayT6U0Rk9r68ivJoxeIjSuiEO3kr4pXI2xXo0NMa303OOnpnDanS3cDzdx1AU27PLbzOjqXTpeUuLjJM2+VDchmJpN9fqCEBBYuUThwbIeKR9GYxO7l6a74u4qMXIEwS5UBVqARozCkl3niPGzhvudVQo4tH87G6qaU7uHiou0qcKZlrV9a9AQpHbrMCClpBtPgvrfz5dtetLkc1DlxVWtCpLzQYxsmKhgXW5kdWfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsibxcKAXN+bv18fkS85nWEFtgQgqC+Gu/L2q8r5ixk=;
 b=DOfvnLOdMThku2eCqcKDEmLLhXA4+6z/J36rP6a2BcxftAsej0LJ7sId5j+kFXAOKJzCYvzNfxTw5rIh7l6QbSa4NNRvgmpOS5R3uCCHJfoVnWbX0GK6gFUSExKvZCdRb2ZH/kOD0Uljsq6DEbGW+zNvTLmItaDbT2o26y5OxAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 19:44:37 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef%7]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 19:44:37 +0000
Message-ID: <89cef849-4309-478c-8250-3e668943fa15@amd.com>
Date: Wed, 4 Sep 2024 14:44:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/sev: Fix host kdump support for SNP
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, dave.hansen@linux.intel.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 thomas.lendacky@amd.com, michael.roth@amd.com, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev
References: <20240903191033.28365-1-Ashish.Kalra@amd.com>
 <ZtdpDwT8S_llR9Zn@google.com> <fbde9567-d235-459b-a80b-b2dbaf9d1acb@amd.com>
In-Reply-To: <fbde9567-d235-459b-a80b-b2dbaf9d1acb@amd.com>
X-ClientProxiedBy: SN7PR04CA0161.namprd04.prod.outlook.com
 (2603:10b6:806:125::16) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|CH3PR12MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: 0606b37c-a72b-4cac-8c65-08dccd1a0236
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHppYlZxOGp5bFVDM0ZEWEZWeWlKeEtBS1dmZXIrc0RjMW0zTEk5QTRoWnJW?=
 =?utf-8?B?eVRXV0N5dUJtMXZZUEh6dzVISDdBdlM3VGxyd0ZqajBmS1ZQYWEzbllVS1lT?=
 =?utf-8?B?R3VGeWJzUktsN3I1eGhuMGdLK3VWdlJQV3BxdjI5aVBSOW0xdVJPektCSEVC?=
 =?utf-8?B?NW5IWWdyNHg0aFU3NUR1YmFDTHgxeFdaTVh6OENPS3Z3WFBaL3NJaTd3cWhr?=
 =?utf-8?B?ZG5Ib0RKYS8vTjBqSk02UXBTWVVpM0RHVStWZnJjLzNZVTczWnJ3VldsMEcz?=
 =?utf-8?B?WXRsRWFXTXBnQUlwRTRIMWx4bkFVRjQvQ2grNjRMSEVFKzE4VzBpY211bnVy?=
 =?utf-8?B?TEtVMWJ6NDFOMkR5b2MxRzdDZ1RVZ0R2YVAraEd5TnVSVWtrd0E1ZmlRRCsx?=
 =?utf-8?B?ZG00ekt6dnRBNTU1R011azh5RzRaTUpnZTdNSG1OZDVyUGt1WngrQXdGaGVa?=
 =?utf-8?B?b3N2TUlxckhxbDZ2TUZNeml6UVlVTy9Ra3kwVUZDREtmYWhDYyt0MUFxSkdn?=
 =?utf-8?B?M0VSZ2tPd3pPVklEUWpkazRHNktIVmtHQ3dvRWRSM1lqaHVQZUtRbHQzQys3?=
 =?utf-8?B?amcvdUdrWFJHcFkxWWZ6Ti90SkNkMVlrdm9aU25TclU0UTFJUCtEVURLN0Va?=
 =?utf-8?B?ZEpDdTU2UDEvcDdUNStMUjVNWkdBN1VIY1g1eUdrdVV3emJHUHN2anFtU21s?=
 =?utf-8?B?NHhGNmZJTkQrbDk2VmRpWkpveDQ1VVNESERyTHpZdGR0enRFc2RLYUdNeGNZ?=
 =?utf-8?B?MGs3MHJMZjI3TVY1OWJjQVZuSlVLazQvS1VheEEwZk1HOE1WWitxdXdNK1hX?=
 =?utf-8?B?ZWFJTmx2WFRVVzR3MVd5YnhaMCtpRFFrZkxKZlZpSzhUNk5YZE4yUnU1djQy?=
 =?utf-8?B?SDBNNC9lUVdValJIbWtQTVJhaXBDaGpqb1JmSUFka3dkb0JYOXhndGlvS093?=
 =?utf-8?B?c2dOb25QQUkwaERCRjhrWVJyTlVNTCtmM1JjRjNBNVJhODc4NFZONG1nNm05?=
 =?utf-8?B?Rk5IbXlIbDdiVitrRmdrYTFGOUx4cEszK29qU050ZFo1aUZ3cm9OTTI3Yi9Q?=
 =?utf-8?B?ZWU1VHVYVGMxWHFWMzk5ZmFOQzdtTkJWL2RXYStxRUxWRUJBNkhsR1l1T2xz?=
 =?utf-8?B?clVkbzIwaDh4RG04YXNqTjRmN0I0OE51dEQ5aGo5YmpyREJudlZkVDYwUlMw?=
 =?utf-8?B?NzhZOVJlMXhkd0hXMTN0SzltQVRUZkVaQ2VsSTNPQ3lLUmxnejlnbzlvYVpq?=
 =?utf-8?B?WUdoelZ1ZjBva0tQclMxYlVJTEFtaSthT1ErczhkZXlPVG5tTzRhZ2VaU1ln?=
 =?utf-8?B?N3lLRUxjQkxQZHh5b21aUE5YMGJnN3AwcWV1bS9PcWY0R2RvV01JSVorSjhF?=
 =?utf-8?B?YkVkeXJjUFBzcFpVMWF6dWx0RERVWGowdCtMRTF3WmhRMWw2cVA0OWx2V2RP?=
 =?utf-8?B?eWJ4cE9YUGdQdHB3bG5VbGlsV3lzU0RHd1pDekdvRXB3MVJHZVdIRURsdEVz?=
 =?utf-8?B?UTA3WWRRWmhBR0FyZUZEeVFIMWVEQkRQMUU4ZkRoK0QrODVZVWZzTlBnenBI?=
 =?utf-8?B?dGhNZ3REVGd3Y3BIVkxhVlBycnl3RUd6Y2Y3aDFJbUpLR1pTdW9OOW5PK2RJ?=
 =?utf-8?B?Z2I4NSsrdFBNNTU1VjBaRlNPTzJtTFQ2N1RqcmZvNHdwejF5SzFlWmR2L25K?=
 =?utf-8?B?YjZiSUpCSVV2NWxCZjRKb2NlZ1pDUkk1M2pib251ZUVhZXJXYmhVaGJFVUw0?=
 =?utf-8?B?cURqcHR2TlQvcnExeVBtMUpyOXhxWlB0WFJvbVBFcHVVM0ROOUJwMTdZOWJw?=
 =?utf-8?B?YWtpaDV3S3A1Si9uWXhyUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WENDZzRWYjhUa3p6N1JVWDJNWXc0RXFMelptSlB6YWdXNHNQelJaRXJoSXZI?=
 =?utf-8?B?Ym1lbWRlZlFQZGF6S1Jnc1FXNkZZMnJaek9NYUFBRGYwVU5BREIwbXZFUjE2?=
 =?utf-8?B?NmM4N01uMHdWT0swSVp3dE5uUFZBWlk0eURLcUtNTW9KTXgyQzYrdUpBdnhk?=
 =?utf-8?B?ai9IYVM2L084RDEwNDJrcTgvL2NubEhJN3dHR3hNeENJc3g0bHV0QjVUc2N4?=
 =?utf-8?B?YWdTWE1PNmZweTVsUE9rUUl0VlMyUit2YklLOW1jb0xtMTluSHBQeTRLZi9C?=
 =?utf-8?B?YXppQU5NVVk3SmxHbDdPbXM4YlVya1BCYjZ5bmhTTHNDVk4yeXovUjdZVWVm?=
 =?utf-8?B?UDhBM3UzNDdwN2hweWVFV0V4TU5qazNiQU03NVZqei95dlNMa01pWFRqMmFm?=
 =?utf-8?B?Ykw4Snk4UGtxQS9PTjkvWm5HSTcxLzZVdGxBNyt6NFJPT0k1czFFblp4eXdq?=
 =?utf-8?B?UTljU29UWjJORERSNThyMHdSNUFnNnpDT2dMMWdjYkROejFPODltR0RSMWho?=
 =?utf-8?B?bTh5YmNLYUlNMW1meTZjS2VhdUI1L0VYa3A0U011RisxS2JXSFVvNmlYYTJ4?=
 =?utf-8?B?N0c1U0g2eEp2dEVWMXdmQm1jdngzdStsRHcwNmdCbkRsbSt6ZWxLR3FBM2FD?=
 =?utf-8?B?QnE4ZWVJQi8rMEprR0dZN01hUHlaUjZZeTVydUM3YW0rOTRrbHJpcUg2blcx?=
 =?utf-8?B?RTliUkRjS05YbGtVRkhGZ29xSlI5SmpENDd0U2xwY28rU3FZWWpQNWZEUko3?=
 =?utf-8?B?R0NlRmlBQ3RoaEFxYldzSUZESWdsemRVNEFxZUNnb3RXVk8zOVkvZzdPTmVO?=
 =?utf-8?B?V2dyc1MyZi95ZU42OXRpOFNZQitqU1MwWmU2UU96SysrQ3Y3L2EwcDN2U2dt?=
 =?utf-8?B?ZDVMT1dpWEF1ZnZMY3R0RzVZQzVsL2FZS2dtSFZTMVZkSVRLZ2NvNVNPck8x?=
 =?utf-8?B?cmF1Ly84ZXBaVHc1dmpnc0VqaHBUc0NPY25aZTRCQUpwVmM5NlI5dTZzcmpG?=
 =?utf-8?B?MFAvVHRGQ0NwYWJoTjdqb2VIc0s2UXhlMFRhMkp6MFgyUXFzQ2JBa2ZIc1Y5?=
 =?utf-8?B?djJMdHYycE1BTnZBNWdFbUJxSm5WK0thOGFyVmdEaFJUYmxIcWFqWGRGWC9a?=
 =?utf-8?B?WFFOcWdMeEx3Ym5EMGs3UGs4a2NzTmJwWFFVUFFacGJXeStyeVdnY1JvcTli?=
 =?utf-8?B?YWgwZEhNUXFZWWRLdnV6MVo0MndqbjhCY01WaXZjbm9hVHc3STFaa1gwZHov?=
 =?utf-8?B?YnAxU1h5bjVxMzZXdE8vVTFHcnA3cGVoS2k5aEZZRk41ZzlzSGl5dXhJUXpK?=
 =?utf-8?B?ekVVckdXTWQzdWVsNkRKa0gyUzAzM2MxWnpocElFMGh3dS9pajEwQ2tHSm45?=
 =?utf-8?B?dHl3QTVsT2xCcEFGRXJaSWsyT2FabFVaSkJ6SUpNd0tLbm52cjhMYjl1SzJu?=
 =?utf-8?B?bFAydGNMME5NOWpWREY5WDRTOFVza3dNNllHWk1nRGs1U09WWEhrenVyNU82?=
 =?utf-8?B?aWJEbmtReWNCMmY4bWtFdnNMYXR5dmxORjl0WnMzejJ6NlcvbEJaWDBVSUU2?=
 =?utf-8?B?UmRVSm5UYXJUN0lraEF3UjlIZHlCRmp1VWdSdlBRSlhLQlJCa0VuSjdiVU1v?=
 =?utf-8?B?Qkx6ME1UMnF4OXQ0cXlIZHJRS3RWMXVwY1VETmhCYWxkWVVwTGNWS1lkc09O?=
 =?utf-8?B?T2VNZnhuUXp4alVhR0cyRmIvRDA0QXlvaGVIV1ZnN0JuTndHMFlSbHptRDha?=
 =?utf-8?B?cWswbnBLRmJqUHpLRktiMUo2R2pjZENPM3VXeEVZaXJLUk1FOFZMVHh0Zlds?=
 =?utf-8?B?Y2tiMzFHalZFVUZBaVMxT05PMlpqWGVBdGlaSFdSampYcFNPZ1B6ZnlYdzJE?=
 =?utf-8?B?TXhGQ0FHOEtWVjJORlc4a3N6Z0JWTVd0aWdwaWs3eSthNndGQ2YwZEh5c2Za?=
 =?utf-8?B?KzdxRk85SHRHYkNpTVM0NFB4RGUvRFpTYTBmR2FIN2ZNZjFNSlR3NXNYSkNn?=
 =?utf-8?B?d2I3YUxzeStMRW5EVm1yWTFjQ3Q4Nk55YmN3UWN4MHJCOUE5UVVwZU9yUjFV?=
 =?utf-8?B?MmlvbXRoUm5QTWsvclduNnBwczB6eDI0alc4Szc3UWlhY1FsQ0t6R2xHZndi?=
 =?utf-8?Q?hnAPkdhuyDNKp+gifDIYPKprJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0606b37c-a72b-4cac-8c65-08dccd1a0236
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 19:44:37.1653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/R8szOA/lcG3KEcdHVCafNprfKqnmqPqBLcAgluOaQQkRYCR8OOQ3zEU27PN2fa2/LbnLM6XP4NXE3iqnrG9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9194
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_124443_402924_8DB05CDB 
X-CRM114-Status: GOOD (  10.43  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

SGVsbG8gU2VhbiwKCj4+PiAgZV9mcmVlX2NvbnRleHQ6Cj4+PiBAQCAtMjg4NCw5ICsyODkwLDEy
NiBAQCBzdGF0aWMgaW50IHNucF9kZWNvbW1pc3Npb25fY29udGV4dChzdHJ1Y3Qga3ZtICprdm0p
Cj4+PiAgCXNucF9mcmVlX2Zpcm13YXJlX3BhZ2Uoc2V2LT5zbnBfY29udGV4dCk7Cj4+PiAgCXNl
di0+c25wX2NvbnRleHQgPSBOVUxMOwo+Pj4gIAo+Pj4gKwlpZiAoc25wX2FzaWRfdG9fZ2N0eF9w
YWdlc19tYXApCj4+PiArCQlzbnBfYXNpZF90b19nY3R4X3BhZ2VzX21hcFtzZXZfZ2V0X2FzaWQo
a3ZtKV0gPSBOVUxMOwo+Pj4gKwo+Pj4gIAlyZXR1cm4gMDsKPj4+ICB9Cj4+PiAgCj4+PiArc3Rh
dGljIHZvaWQgX19zbnBfZGVjb21taXNzaW9uX2FsbCh2b2lkKQo+Pj4gK3sKPj4+ICsJc3RydWN0
IHNldl9kYXRhX3NucF9hZGRyIGRhdGEgPSB7fTsKPj4+ICsJaW50IHJldCwgYXNpZDsKPj4+ICsK
Pj4+ICsJaWYgKCFzbnBfYXNpZF90b19nY3R4X3BhZ2VzX21hcCkKPj4+ICsJCXJldHVybjsKPj4+
ICsKPj4+ICsJZm9yIChhc2lkID0gMTsgYXNpZCA8IG1pbl9zZXZfYXNpZDsgYXNpZCsrKSB7Cj4+
PiArCQlpZiAoc25wX2FzaWRfdG9fZ2N0eF9wYWdlc19tYXBbYXNpZF0pIHsKPj4+ICsJCQlkYXRh
LmFkZHJlc3MgPSBfX3NtZV9wYShzbnBfYXNpZF90b19nY3R4X3BhZ2VzX21hcFthc2lkXSk7Cj4+
IE5VTEwgcG9pbnRlciBkZXJlZiBpZiB0aGlzIHJhY2VzIHdpdGggc25wX2RlY29tbWlzc2lvbl9j
b250ZXh0KCkgZnJvbSB0YXNrCj4+IGNvbnRleHQuCgpBY3R1YWxseSBsb29raW5nIGF0IHRoaXMg
YWdhaW4sIHRoaXMgaXMgd2h5IHdlIHJlYWxseSBuZWVkIGFsbCBDUFVzIHN5bmNocm9uaXppbmcg
aW4gTk1JIGNvbnRleHQgYmVmb3JlIG9uZSBDUFUgaW4gTk1JIGNvbnRleHQgdGFrZXMgY29udHJv
bCBhbmQgaXNzdWVzIFNOUF9ERUNPTU1JU1NJT04gb24gYWxsIFNOUCBWTXMuCgpJZiB0aGVyZSBh
cmUgc2V2X3ZtX2Rlc3Ryb3koKSAtPiBzbnBfZGVjb21taXNpb25fY29udGV4dCgpIGV4ZWN1dGlu
ZyzCoCB3aGVuIHRoZXkgc3RhcnQgaGFuZGxpbmcgTk1JIHRoZXkgd291bGQgaGF2ZSBlaXRoZXIg
YWxyZWFkeSBpc3N1ZWQgU05QX0RFQ09NTUlTU0lPTiBmb3IgdGhpcyBWTSBhbmQvb3IgcmVjbGFp
bWVkIHRoZSBTTlAgZ3Vlc3QgY29udGV4dCBwYWdlICh0cmFuc2l0aW9uZWQgdG8gRlcgc3RhdGUg
YWZ0ZXIgU05QX0RFQ09NTUlTU0lPTikuIEluIGJvdGggY2FzZXMgd2hlbiB3ZSBpc3N1ZSBTTlBf
REVDT01NSVNTSU9OIGhlcmUgaW4gX19zbnBfZGVjb21taXNzaW9uX2FsbCgpLCB0aGUgY29tbWFu
ZCB3aWxsIGZhaWwgd2l0aCBJTlZBTElEX0dVRVNUL0lOVkFMSURfQUREUkVTUyBlcnJvciwgc28g
d2UgY2FuIHNpbXBseSBpZ25vcmUgdGhpcyBlcnJvciBhbmQgYXNzdW1lIHRoYXQgdGhlIFZNIGhh
cyBhbHJlYWR5IGJlZW4gZGVjb21taXNzaW9uZWQgYW5kIGNvbnRpbnVlIHdpdGggZGVjb21taXNz
aW9uaW5nIHRoZSBvdGhlciBWTXMuCgpJIGFjdHVhbGx5IHRlc3RlZCBzb21lIG9mIHRoZXNlIHNj
ZW5hcmlvcyBhbmQgdGhleSB3b3JrIGFzIGFib3ZlLgoKPj4+ICsJCQlyZXQgPSBzZXZfZG9fY21k
KFNFVl9DTURfU05QX0RFQ09NTUlTU0lPTiwgJmRhdGEsIE5VTEwpOwo+Pj4gKwkJCWlmICghcmV0
KSB7Cj4+IEFuZCB3aGF0IGhhcHBlbnMgaWYgU0VWX0NNRF9TTlBfREVDT01NSVNTSU9OIGZhaWxz
PwoKQXMgbWVudGlvbmVkIGFib3ZlLCB3ZSBjYW4gaWdub3JlIHRoZSBmYWlsdXJlIGhlcmUgYXMg
dGhlIFZNIG1heSBoYXZlIGFscmVhZHkgYmVlbiBkZWNvbW1pc3Npb25lZC4KCkluIHRoZSBjYXNl
IHdoZXJlIFNOUF9ERUNPTU1JU1NJT04gZmFpbHMgd2l0aG91dCB0aGUgVk0gYmVpbmcgYWxyZWFk
eSBkZWNvbW1pc3Npb25lZCwgY3Jhc2hrZXJuZWwgYm9vdCB3aWxsIGZhaWwuCgpUaGFua3MsIEFz
aGlzaAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtl
eGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK

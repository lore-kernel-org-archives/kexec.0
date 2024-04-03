Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD33CD128A
	for <kexec@archiver.kernel.org>; Wed,  3 Apr 2024 21:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:CC:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GZo3l2c1wN8vxjv18DnZSx+ZvTps09t3C45h4ZJ84/k=; b=cz18bID+Hyd6C7OVui2qtnHSw+
	q1JZrxJY7u1zhO5BpkOOz8LK3poZFhV2Dz3dW0XCURriYDbFiABwKH6FaZavGFMa8hXUa7r8oJvfm
	SkGGEk1C2YXSHL+q+fzQS+bsQHLDzcCztHkmf47sxQv+1I4fi3YC+t5iSzonQYnuot4wDo5beGcSH
	6KkMCJuMylaiz8jxx0Fegpv2sBt7oZVqsj33sxDvxSZGz6dPN0Q4yp2j7sm9sQZ7tgHXcc1koxKQY
	+hOk47vLnx086PO2ztTjEgpn3PDM8Ov2CdVHN35yypF565wMMosLayLDLA3a2zaVSpaLzlhjZgD9Q
	NzI+1shw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs8Lo-00000000IEK-2jQ9;
	Wed, 03 Apr 2024 21:40:56 +0000
Received: from mgamail.intel.com ([192.198.163.10])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs8Ll-00000000ICU-3HXR
	for kexec@lists.infradead.org;
	Wed, 03 Apr 2024 21:40:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712180454; x=1743716454;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wxdvWbFRR+8aHH4/sGNdzd7O8Kjx2Xmct5a4bNDiHR4=;
  b=ADj5QLOHKEcXl3SlPBhWIW/MMeS57oTVl4G94/YkVl/5XeqXeiFCFYh5
   Bwmf9QxjxzuFfdywIg9y614I4RT8fYbEf3fVQWyO04eLWJ45lPfLaRcPI
   LJzm4SojxMLMUX0vP4rfLZIRLxdHuTtNY1lu7tl4/VUzat3mKCnDgrxaM
   FqEkJDdN+ZSo6u7/027C5nzHyZ/aPOjPvSfY1A8+9k8MAkht3vnRXCazC
   vxKIrUOmq/9CFf2+L2XNLsawy8xFu2J5Bcc/9HvGO0HwN4vJ52J4CkMXE
   wfCo/unAXLA20JS+JGmlVk6zSHQGU7H0UXy1DdpUAOGAWQoKzd/63r0o3
   g==;
X-CSE-ConnectionGUID: 5AwCg8WuRRaAOFhIPWx9tg==
X-CSE-MsgGUID: HM1sx25zT1mjv+2EPeAhPQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18798925"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="18798925"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 14:40:50 -0700
X-CSE-ConnectionGUID: UwR/VidWT+apLT5naA79Rg==
X-CSE-MsgGUID: 2ynfN7EPRpq1nqztGLoe5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="18600775"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Apr 2024 14:40:49 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 14:40:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 14:40:49 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 14:40:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxPhChuiEia2EpXnDcx46GdO4jf8x6pDQiCULkJbHQGuVXxniBwJYAs8IPBmSPMJAivmQBEp19MjW5T9Lm3h/9Xn3K9YIQMsKqdbJyThkWs5PG/lglKGNqpR6Jjh/ePCEbtGuTJoRaUPFUCk9eg0o8yTsjcPuW7zf9S129EMAv9NIj8/smCg8pxHHPSinfKp/Hc5c/F0+19pxTAyoX86/3MvY34x8r5SM4AQWNiYliMuTb2UI15jejJXED4tMGsjgGOJMaMrRl0xGQAGmLPWKswAydomigEx6H8t2Mk6n7tUaflU0G+wgEquzKx+jFQGM7L8Yd/e62LOHvQ7FyhpRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1u0p0SYv940vsowlvK3IVvui3oRbgUfuda7u4B8gIe8=;
 b=YwyzCL5W2xg4xA3lqwnHf/XFSwc2hekAeuXkuISH0GVpQTZwnlamk5EFkjpVyZFypL4SZeL50rM7gqqTwXaW6ZxdWg8M+71O5fNHMaro8/zmDBnkBdtgGhF6WDe0MbDQ1K7ZnRpEGvZcITyB9eTiuhtwtYkKkTLhLACKPw7u9GRI/OAw3P1QFNUyDMlwroJF54NnKpDKFtMQCfRu96JGHCsXLOKHmRrWWCdf2GEfuzqTyFww3yYB70KjBNKCpXFDjrPCMdjwkb7wiAoWkJ8DdJcHxuwqSKArrzrEYqDQGZQ5HjvCDWK6WeQZuTuStjbrjfVVbGv2AtxZfOCLkKTmwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CY5PR11MB6091.namprd11.prod.outlook.com (2603:10b6:930:2d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 3 Apr
 2024 21:40:47 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7452.019; Wed, 3 Apr 2024
 21:40:47 +0000
Message-ID: <8e4e1d80-11ef-472f-befc-f61310281f18@intel.com>
Date: Thu, 4 Apr 2024 10:40:34 +1300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv9 05/17] x86/kexec: Keep CR4.MCE set during kexec for TDX
 guest
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Xiaoyao Li
	<xiaoyao.li@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena
 Reshetova <elena.reshetova@intel.com>, Jun Nakajima <jun.nakajima@intel.com>,
	"Rick Edgecombe" <rick.p.edgecombe@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, "Sean
 Christopherson" <seanjc@google.com>, Baoquan He <bhe@redhat.com>,
	<kexec@lists.infradead.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
 <20240325103911.2651793-6-kirill.shutemov@linux.intel.com>
 <b94c81ef-50f2-4e66-9533-461791777d10@intel.com>
 <dlixf7bld4efdh5goir5nreabkgtcwfbvv2rovjqrvjttplqss@auuqnt4h2llj>
 <j4s4n5slt6a234w5o5r4zjmb3xj53odnmwekt6ihotfzotd7ur@ghyvphwcki57>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <j4s4n5slt6a234w5o5r4zjmb3xj53odnmwekt6ihotfzotd7ur@ghyvphwcki57>
X-ClientProxiedBy: MW4PR04CA0059.namprd04.prod.outlook.com
 (2603:10b6:303:6a::34) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|CY5PR11MB6091:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lDlcT6Uye/Grv/ccz2s+8qfNHS01KSv43oltaUiKrQW5sjPCj7LNH6XOm+/4lODrQ1Q90BJIbe4D+XrHphAJyT9BNDXUIQaptVUe28qXSJ+Suba6BH0VcfdZCCSBf6D+OtHR9f1KD8OtxctAyjnPQBIgOSUt61Lk8YiTkFoaeRyG5h9y8e8nCVCEMXoC086rZmJwwMHP3vij0nF4jKNXqKTOgs06nZuaFeYM6mRwCwMLC3UDGfXSyqvIkys1xEo4DMtkKGQsk+BEsg7ZO5GCCgVG+CcooUfH6Ldmgn7pxxbjOkMlSdLjhVpEwlJmYJ+F0ovVRvxo3j2iNGGIXpZtyvTF+QGDlyE3m0J1BI4OMH0PRJJDs8JX1/7B0HGNdc58szd6l+HlKrmuKELTD51QgwdG4exX3WTXKYElLVazlWgpZtJEID+OAK+x9TgCmnQ2t9Cejw2H6trVXQRZIuHTX6LJZdtJUaDmFIleN7b6MSwd/R4AYLe8o+FRIK9jkQzIQErfgrMr3TJk3ueirjdYTwk9lKtZus0tCT6iMKfCRw8vaEv8w903yQdV6wJcpdJfus0SbtlqExaU7y+oN2NBlpVY0FLtmcH254VqX/bfjQli0kvKt6Hxud16wny5/rM7/afFElISMLtos9gn7zI2M3go+1GfEuhCZ4vBqAsBA9Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OENlVVVtOXBNZDNsRW5TaGt2am1PZEgwN3p1TXZ6dkZZVE5WdFJqYndlbXRt?=
 =?utf-8?B?SGwzdzRGdzVxa0JVL3dpYlVKRFNDdFJFb3pZMzlXdmRXMUYxN3NPRHJGU2RC?=
 =?utf-8?B?U0t2VFl2NXpzcVFMaXBadUh3VUMrS29IUFN6a1BKSXJWazZtWExQNDJ5VlRu?=
 =?utf-8?B?Qk8ycmg0VnlQYkpycm80OGFyRGltVGlGVFNwRU9kRzZ4bmRsRDV4eHAzTHJP?=
 =?utf-8?B?VkYxVXZLZFUzM3hNZk96Y0w3S1p5TVk5cG14OG4zcy9sQjRiV1pCT0lsVzlI?=
 =?utf-8?B?dXg0czZWcFJWM1NNSVQyVjE1alJzdGhtbXNRVEF5Wk9keVF0dWNCVFhiczBH?=
 =?utf-8?B?Sm5SMC9lenBVSFlrZFZHZ05RU3B6cXRhZmR5N01xbVM2SDdubUdxUWJNMjZK?=
 =?utf-8?B?d3BFYkVrTnFtS21OdUxCalpPd0lFTlJyVEV5SGNyTTlKaG1VaGZLZVRuMi9R?=
 =?utf-8?B?Q2pYN1dKZTdkVm0yTkE4Y2RMS1EwaHB4UUM1VkcvY3BQRjdJb1hla0FtMkFM?=
 =?utf-8?B?Nms3QXc3ZDlQSEJXR1dHcGVLSXJCcUFDakhSL2xyZXRzdFEwKzlhKzNsUStU?=
 =?utf-8?B?OTcvZEZ6WDY0Q3ZxT1dHb3JGNFJIV21sZVlYRmFibGZDcWZ6eHRLS0x2RVlJ?=
 =?utf-8?B?Tk4zcXUwQXZVWE5MbEY1OVlxbGFIcUk5N0Y3OGo2c0IxczdIRFVKWXRNWUxz?=
 =?utf-8?B?elJISExQV0Z3d0FMa2VrYWxPMlZJU01sSTBUZGd0UzZBSnJRSXYrQW9lQnBz?=
 =?utf-8?B?dUdUcmhxenlwc1ZQY0JSSVJxdVZxdnE5U0o3M0k4QjRUTWRYMGNXYmw3bk1M?=
 =?utf-8?B?VTg0QVBaZHBLZFpySjdlT1JmS2s2ZHRVOGYwT2pvT3lMd3NBUDVKeHVBNmY3?=
 =?utf-8?B?c3BMME11Zmw0QlVmOWJtczB5bzIrdVR3eW8zL2k4ZXNuUkczRTBnNURsK0J6?=
 =?utf-8?B?eUlOS0pnVXFRSjdDL1lyRlhoMFJzWEowTFJZamJiQzdyNTBkS2Z2eW9qcEc5?=
 =?utf-8?B?Q0M2M3hBMmk1QnE4N2pnZms5U3NWY0JSNnpCSVZWK2drdXRod28vV0FnVHpM?=
 =?utf-8?B?T0hGeUxRSnBWS29Xc3BMREpSd3cyeCtRT1d6bk8vVXQ0Z0RSZDlxRjVybFcv?=
 =?utf-8?B?S2lVcG0yL3ZJZDAyaWZYdjZiYkVPbVVPTUNVeEIycHc0ejZDTmZOWGZQcnRQ?=
 =?utf-8?B?TXJ5L3lWWm1pTklRc2RaTXdiQzVucnZhNDMyak5QZys2UW9QRDgwVUsvNmZM?=
 =?utf-8?B?Nm1zbWpGU0tsQzVqU1Jxdm5YdWxiTzZKYjNSdmRmdk41cytsMGhnV0JaLzJQ?=
 =?utf-8?B?Rm1rZmJDWFBhd09OMXUxOXhuZEFqZFdKT2FsQ0luSlZmQ1FLWUVzTTUwZlJX?=
 =?utf-8?B?dHp3UTVVNm5PbTZueWVEZHV6ZnJ0Y1JFMlEvQkg2d2cwckJuY2hwMGNROUw5?=
 =?utf-8?B?cnFzTHk2Q2EyN3ZLZW1QTWJ1R2ZybWZRWTBCVFcvb0I5SGIwSklaRWM4Nk53?=
 =?utf-8?B?Ny9XM1dvZjlJZzU0S0RCY2lhL3JrYWZ0ZFFRS3BuU2xxc3gzaXFYZkIzb1d5?=
 =?utf-8?B?V2dRdUc5Zjk5ZVhTV3o3ZlNMSU4zYktBbVBRdTJrTTgvRzlMNURHZGZYTVd2?=
 =?utf-8?B?Z3JlVHFrdFp0RDBZOUZzbGxhOWlVY1NpWHM5R0NObml4dGhhZjJnb1FXY0RR?=
 =?utf-8?B?bWtzd3o2VVg3MWxYbHptSHl5bEE4d2tkeEtoOTd2VkRJQ241Z05BdEpnd3o3?=
 =?utf-8?B?NFcxZFRVNEhwUXh6bmpId2lDZ2tqZm9pTHRNTTQvelNpejFOVXFUMSsvSGlE?=
 =?utf-8?B?VW5qNHpuMkRzVlBhdTNBMHczTWNJQ0Y5Z1pvVHNUZlk1d1p1Y3dMbWgwSEl2?=
 =?utf-8?B?cGR3V0Yvc3dzaytBeDZ2NUtZaFppa0gyRzNFWWVhcDJhV3VWZ3FIbjNVQ1lB?=
 =?utf-8?B?MFYraE9VT2xwOFIvU09zbFpzejdZcmlNRmw4azFlQVlmTkFnbDRKUHNWMVlQ?=
 =?utf-8?B?Z0R5L2phLzBrWmt1YnVqTzlhZHhqdWY2U0ZLQnZaRlh2RHZrNGJXSmwvblFu?=
 =?utf-8?B?b1VsTHBPS0lZaG01MDVhaUJVYzg4emJ3bHV6UGg3OVJRZVAzNWNQODd2c0U0?=
 =?utf-8?Q?Lq4SxGTW5G5Utvgf6V3EC10pb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51558196-0628-49b3-59ba-08dc5426b916
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 21:40:47.2178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QE3sopmEjUj84JtseQxsF8ekkAWXk6nuBaF7WQ+M85n59sVW5FHMnUUExodyMbgJdv3mw9NaVldaioSOStD8HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6091
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_144053_947578_8D94A278 
X-CRM114-Status: GOOD (  17.36  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 3/04/2024 4:42 am, Kirill A. Shutemov wrote:
> On Fri, Mar 29, 2024 at 06:48:21PM +0200, Kirill A. Shutemov wrote:
>> On Fri, Mar 29, 2024 at 11:21:32PM +0800, Xiaoyao Li wrote:
>>> On 3/25/2024 6:38 PM, Kirill A. Shutemov wrote:
>>>> TDX guests are not allowed to clear CR4.MCE. Attempt to clear it leads
>>>> to #VE.
>>>
>>> Will we consider making it more safe and compatible for future to guard
>>> against X86_FEATURE_MCE as well?
>>>
>>> If in the future, MCE becomes configurable for TD guest, then CR4.MCE might
>>> not be fixed1.
>>
>> Good point.
>>
>> I guess we can leave it clear if it was clear. This should be easy
>> enough. But we might want to clear even if was set if clearing is allowed.
>>
>> It would require some kind of indication that clearing MCE is fine. We
>> don't have such indication yet. Not sure we can reasonably future-proof
>> the code at this point.
>>
>> But let me think more.
> 
> I think I will go with the variant below.
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index 56cab1bb25f5..8e2037d78a1f 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -5,6 +5,8 @@
>    */
>   
>   #include <linux/linkage.h>
> +#include <linux/stringify.h>
> +#include <asm/alternative.h>
>   #include <asm/page_types.h>
>   #include <asm/kexec.h>
>   #include <asm/processor-flags.h>
> @@ -145,11 +147,17 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>   	 * Set cr4 to a known state:
>   	 *  - physical address extension enabled
>   	 *  - 5-level paging, if it was enabled before
> +	 *  - Machine check exception on TDX guest, if it was enabled before.
> +	 *    Clearing MCE might not allowed in TDX guests, depending on setup.

Nit:  Perhaps we can just call out:

	Clearing MCE is not allowed if it _was_ enabled before.

Which is always true I suppose.

>   	 */
>   	movl	$X86_CR4_PAE, %eax
>   	testq	$X86_CR4_LA57, %r13
>   	jz	1f
>   	orl	$X86_CR4_LA57, %eax
> +1:
> +	testq	$X86_CR4_MCE, %r13
> +	jz	1f
> +	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST
>   1:
>   	movq	%rax, %cr4
>   

Anyway,

Reviewed-by: Kai Huang <kai.huang@intel.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

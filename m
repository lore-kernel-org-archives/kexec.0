Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BABC5478C
	for <kexec@archiver.kernel.org>; Wed, 28 Feb 2024 21:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:CC:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T1zcdUzLef/meG2UCrU74X3SzTMKQOPUrWjQwLlCE/E=; b=lsK8c7LihKCrNLgIWeCxfXiPXi
	p6OdFz8MT8WekRfm14gfEfICPyIHIk0eQNwzke8ZF29oR91ivGjAkdh6i+B2Qal9/xTSGov9s6HT0
	Z6KH4htEkPDchk9I21wlIkYfW778JdLEXduaaCYScjARisf1B3JT7IMI929Pz7l9h9gRvVCJ6NY7Q
	DEV/W0YK5AfJ0fJv36LFj4QzoSJlTKzvVsCDecrfu5WY67UcTRZEd9hVh2tpBPGeL40B+f8uha9up
	mS2HkkrdymzB7eRmG+66J6zq7CG6j7SKOhM+b8qFtPJkPaEf9j6BkfzrW7qEKew7D9D3KlUTl0Btd
	p0vVqf4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfRL2-0000000AxgI-0uCW;
	Wed, 28 Feb 2024 21:19:40 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfRKy-0000000Axe8-2qYh
	for kexec@lists.infradead.org;
	Wed, 28 Feb 2024 21:19:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709155176; x=1740691176;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nt44DkolKzsUPoJxyNmiJIHee98QaZKlCYjowzDbJUU=;
  b=QDMPZQUbiug41R5tY9SkEm4e8PCVI3/dgmcObrGRwp5GGk3B6OeqcABl
   rmTS4mb72nu0Kr/6QHddTa99BvGHZh558QEkeXhiXrannvHng3jCrI7+H
   X6e1yojcnFed6ZMFuDULVHiO3qthxFZvro4wWHqRITzsSnmpwfuz2YN8E
   cBmSHE4h4VyEg8YHuIm4SOT4D4QlGkrrxChjCWph9uftB8n0rN5znx40E
   SnVO6zqTOoWlVmNQWbYbdRI6li2yjXwCQlMYJyNH3ACRpdmLoGKzsWl7o
   qaX5K8tcUkbMl9h/KvHESOQw9dLkGgvapSo1+m3Hg5U2URSS5MsrG8az/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14226472"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="14226472"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 13:19:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="7447965"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2024 13:19:31 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 13:19:30 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 13:19:30 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 28 Feb 2024 13:19:30 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 28 Feb 2024 13:19:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lv0Fplg61Gvd+9FgdT3s9eIDmW8qezjIYpwDL3pHIrrcykTWex5osu55cFapwAFeL7vyKZeJPAQOohg6FnFPdPXGiirfQH//5iiaoP072RLYpSQ0s8MnVR4XwDcS2wJ1bRIKxjXkAyL7z/MqTmH/u1vteqkqahOuSBBda47pD4gCj/PtZqk+Qp2eABMnNqkp/h5Ik3A8w+xkNAIB5jRODtmeZJ7LBiXFBWyZFHUABmI2vTySHTZql69w5muzjW/12Wx0NzuITdIrnTf1slKpd2RK4JMVuQHjaxE4ETAEs6YvyMkEVO6mOgBH+Za6JAqYimWT+EyYd6YjfzhElWYtCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59ggcYnHLabUuTSdrBUf73qwpGvRFJPemKbEXJqY/aI=;
 b=axRSkN2bwMDo9vPiSYK1v57mseqXaB56hL0EyQO0uWO40WgDFCL0CniiwX/lIUpVEpN7DUc+cv4rhuuZvPS2ISr1prpNWbJCyiMXzLrg4jkVMsCUj6Qm/aB+LD9CAPwVkFvA744ziQvOFr2W0wDs7Sjm/3R26Fwv1wQ4AkzyKTNEq3snc9taj9n16RlSvice6QkJ0KMbx6269F5MimsrdSB6m06tXuT6nzTMe6jo+nvCGErfE/zPm3kOVg6eSIxQ/bQNwlMD7aNdcaDowrkurE+9/xAUEp4dkJX8GqRFCB3HiDoBZkwGFysSr/d25AXCDv1tzxqMXO55/+yzQ/PFIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SN7PR11MB7603.namprd11.prod.outlook.com (2603:10b6:806:32b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Wed, 28 Feb
 2024 21:19:24 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7339.024; Wed, 28 Feb 2024
 21:19:24 +0000
Message-ID: <2f8c2032-d8ac-4be2-a409-9880c310aead@intel.com>
Date: Thu, 29 Feb 2024 10:19:11 +1300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 17/17] ACPI: tables: Print MULTIPROC_WAKEUP when MADT is
 parsed
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, "Elena
 Reshetova" <elena.reshetova@intel.com>, Jun Nakajima
	<jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom
 Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>,
	"Sean Christopherson" <seanjc@google.com>, Baoquan He <bhe@redhat.com>,
	<kexec@lists.infradead.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>
 <20240227212452.3228893-18-kirill.shutemov@linux.intel.com>
 <0a633c22-8426-42cf-9572-7812ffc75d0a@intel.com>
 <3jgmzzbjmwtf2rtrbiulhwjj5xwzc3icf4gxcmugyyq5n7pg5m@ua3poay4gmku>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <3jgmzzbjmwtf2rtrbiulhwjj5xwzc3icf4gxcmugyyq5n7pg5m@ua3poay4gmku>
X-ClientProxiedBy: MW2PR2101CA0030.namprd21.prod.outlook.com
 (2603:10b6:302:1::43) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|SN7PR11MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: 5614ea36-3207-403c-d761-08dc38a2eff3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1+b6dMlqtG3CQgm+9lP7dRlHKKxat/p4ucjVSChI0xuVXqyrXF2B10x43kk2VDCI8PnBPouUTN2Huj77WXcFmLuiJkCj6A9iXeZ57iw+Cxv9Lwni7w3Qk9E6CgcLuFKBLFWI/9ETyHcQwrt9Zoqk9LoZY7kqNA6Hh4bcFmphotcje3Z9yUqS/7kn6zwMEN0lwrLHWy0DbZ0Lwh/aruoGzXD+UCt01Bm9zvj/xWkhCXxBB67ft35vgiuOey5EOjS2pNSZW2yxj9Fn9/WMmsAF7IiqI68k/Oua35S60X1/ZgkFL1KgoaSifKqcDQ9O+lo7sc8/mh30V4C8a8uZs0G4Gsvgs9boWbMu4MJS2kxypNPKsGBwX7w2BNgBta9OdKryaKE8HZYo7Zs1oXiBSClGasFVOAsAJsqP8prCrxZkF19sK/oDnHB3AmwsHiGna1hPFBQjUnPPhZFM15y0zDvSvX7P/+wuHP2SwpSLhqNFqvy+RAP2faEzySQL154e9RebV12l5Cv8m6mo+XTg+E5oiDENadBuCYNMxBuLPERdx8Pkpl+yhE560YKOgYoQVzlZ1fK+t3hB9e18Ic2RCuv3zYB8/cj+OPDBeozAYRESf44PuTlGWLIX1KzWh5sgjoS9+xhyMnuKSOBKB6lLNjJihg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVByV2RKbFlGbkFNL1dsei9oQ1ZEKy90bmpZR0xSSUVRZVJVUGNDOHlDVktB?=
 =?utf-8?B?ZHg1Rll4NVhnSFZjRUtZVHpidUtaOElDajZ3Q2Ezd2I5V2NnTC8yenk1N0tO?=
 =?utf-8?B?WGNqQ3JIRCt0RVc5R3I1NWFFUjAzS1JMaTRaVU53L2lGck5tQnk3MExJbzU3?=
 =?utf-8?B?UzRrNVh1TGRrai8vTitpZ1NBYVdnVURoeUs5enR2NzVoWmhHK3R1K25tQlNk?=
 =?utf-8?B?ajI3UE1aOXV1S3NTYWpWbjhBMGsxZG9hdFlBZW16MjJ4YjlEQU1SL3dSMlc4?=
 =?utf-8?B?WWx3Z0N0N3hDTHFtOGdFdUZ0a3NDWFFPdnowNWpFZjk2cGI3eVMwWnVWTUF5?=
 =?utf-8?B?bkZWdHhJNjh4eUZQQ2FHcy9RWStLcStldnBhM2w1djkweTNZanZ2a013cGhx?=
 =?utf-8?B?dXZKcmZ3VFA3bXhiK0YzeDY1VGJJa0pEQ1NTM1llbXVpV0hnOVdzSGJQT3BL?=
 =?utf-8?B?enhOTkhHQU5qVlM2UXhURnFUMkwzMUVObVRWUm9vamd0TWxmTlpFVzU4SnZn?=
 =?utf-8?B?Si9DdzE4QmFxcGpncWhaam91TjNlWXoxRm5oOTBXVHY0RUJIRmhWN05ieFhs?=
 =?utf-8?B?OVpndUU0cjBqS2I0WGFDdTN5M1d3QTM0S2Y4Y3h4aGZUN05DSUlNVTd6VVpW?=
 =?utf-8?B?T2YvTzE2Q09QSmxIdmNha1JldUtWQnRFSVVLMVQ4RkMxcndjY0Y1OXlIeWFM?=
 =?utf-8?B?TFloSHBYSDFoREZrdUpDaHlWQWpVMWVhSlV2ZUFJL283azFVYW9HNjB2THI4?=
 =?utf-8?B?YkUwTlpjNml0M28xaVplem9sbzRZeVdkNnE2eXphcm9QM1lpUnVsOGhCMmtP?=
 =?utf-8?B?cE1NS1NrRko0MkNNL1pOd0FsdTBrZ25FMnpMS0JzaFRRQ2RJUlY4em9VQXgx?=
 =?utf-8?B?RTFiTlFwbU5CT2xDOGtGbTE3c011UHlZcUxkUkNqL3hleVFia3Q0Sm14ZHYz?=
 =?utf-8?B?UURlUERmNTlZdGRwU2ZIY1R3Q3pEbkxKRGNjZUlXVWhnakl4TmUxcjgxSXpX?=
 =?utf-8?B?SjZ0aUs2ZG4wSmxKVXNkU056Z2lmeVhTWVIrekNHMk9yTmdRVzRlelhjV3lV?=
 =?utf-8?B?cmpaQmdJUndncitiV2lhWGxXTk10bWNrYUJiNU1FY0Q3eTc4WTBiNHp0NEZa?=
 =?utf-8?B?azZ3RFdkbVB2WU9BaGVQaFJDM0FFanYwRU00c1JZemdqNklJdnZkSnNNVGNa?=
 =?utf-8?B?dkJJTlBwR09aK0NnTVBZZmJaVzRVVUJVTzBsTld2akNLSWhJYVFWbVVWTmZr?=
 =?utf-8?B?RVo0RjRweDhwVXdoTW5abGNSR0RZRGdyVHhDZUxHd2puUnRoTmNrUi8wdzlV?=
 =?utf-8?B?QkhvY0ZScnVSSHdjS2dCR3N0ZCtmc1BEY1NybTAwZUpZVHdiV1NSQjJsRW5i?=
 =?utf-8?B?eExhbisxdnkwRExrQk9TVFYvdkxBT1JIZVIrcGQwYTIraHlIOHplSVR1RWhS?=
 =?utf-8?B?L2RHRk11U3R5MWRyT0QxQ3BVS0duZGlDcW5DU1ZHS1c0Q1o4eGJUWkZkbWhU?=
 =?utf-8?B?Y0tSZFQxOFI2cmRjbWRhS051SGR4QmNBd2Jra1MveVZVY3kvVjIwVXY1ZUVS?=
 =?utf-8?B?aS9ieGVaV2xUVE9NbXVGZk10ZjNWU3hJODE5NFQwOC9GZ3N5bjhzTkttdElp?=
 =?utf-8?B?L2UyTEY4R2UxMUVqdkEzNUprMjB6Z2NTdmxuc0ZicHNqSTVKeUw5WEhXcVFz?=
 =?utf-8?B?d3FpMlFyZEFZRzNTZHIwcVgwaGJwVTN6Tm9qMHpHNnpmUTJCSU5hc3Rhd3JT?=
 =?utf-8?B?MjZTOTFySjQ5T3dsdjVUYjY0OU9zOS92OWlyZnVhV1A0bXJ0NDZ4bEVSdFJU?=
 =?utf-8?B?Z3d6bjMxWkFOeTl0Zk44ZFJDWWtHSTl3OWxoTkRYeVdLb3RqRThSV0x4ek1H?=
 =?utf-8?B?NUJqTEFkTWhJR3NxOGwvN3ZIc1puSjEzRVFVK01sU0pnbkNFRzgxZ3FidmdS?=
 =?utf-8?B?bUN5VGwxZ2pSR2F0cUtEMXdET2JhQTZoSnp6Wkh3dmllOUpxdzltM0Y2Nmho?=
 =?utf-8?B?OTRzalE1NjR4MWJYeHgxUFpuRTd4MTR4OFFYUEhBOW4rK29BZFoyS1UxQ1ph?=
 =?utf-8?B?UWRhei9zMnk0ZW9lVlNNMS9nc0ViRzc5bTJEQUxYdGR0alI3ekhVVDRndDBB?=
 =?utf-8?Q?aybAdkEmLWyFeu2HU/bqHVns/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5614ea36-3207-403c-d761-08dc38a2eff3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 21:19:24.3211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZbZZMEitphRh2orjKemTRan7HDQOPSYZYg8QcnhOXsP/OD+TtBMx7GwRC2fZzzO7r34vYQSyc+q3/BwqkfWGpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7603
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240228_131936_807110_99ED9EF1 
X-CRM114-Status: GOOD (  18.20  )
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



On 29/02/2024 4:22 am, Kirill A. Shutemov wrote:
> On Wed, Feb 28, 2024 at 11:08:38AM +1300, Huang, Kai wrote:
>>
>>
>> On 28/02/2024 10:24 am, Kirill A. Shutemov wrote:
>>> When MADT is parsed, print MULTIPROC_WAKEUP information:
>>>
>>> ACPI: MP Wakeup (version[1], mailbox[0x7fffd000], reset[0x7fffe068])
>>>
>>> This debug information will be very helpful during bring up.
>>>
>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> Reviewed-by: Baoquan He <bhe@redhat.com>
>>> ---
>>>    drivers/acpi/tables.c | 14 ++++++++++++++
>>>    1 file changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
>>> index b07f7d091d13..c59a3617bca7 100644
>>> --- a/drivers/acpi/tables.c
>>> +++ b/drivers/acpi/tables.c
>>> @@ -198,6 +198,20 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>>>    		}
>>>    		break;
>>> +	case ACPI_MADT_TYPE_MULTIPROC_WAKEUP:
>>> +		{
>>> +			struct acpi_madt_multiproc_wakeup *p =
>>> +				(struct acpi_madt_multiproc_wakeup *)header;
>>> +			u64 reset_vector = 0;
>>> +
>>> +			if (p->version >= ACPI_MADT_MP_WAKEUP_VERSION_V1)
>>> +				reset_vector = p->reset_vector;
>>> +
>>> +			pr_debug("MP Wakeup (version[%d], mailbox[%#llx], reset[%#llx])\n",
>>> +				 p->version, p->mailbox_address, reset_vector);
>>> +		}
>>> +		break;
>>> +
>>
>> Hmm.. I hate to say, but maybe it is better to put this patch at some early
>> place in this series w/o mailbox version and reset_vector, and add
>> incremental changes where mailbox/reset_vector is introduced in this series.
>>
>> The advantage is in this way someone can just backport this patch to the old
>> kernel if they care -- this should be part of commit f39642d0dbacd
>> ("x86/acpi/x86/boot: Add multiprocessor wake-up support") anyway.
> 
> It is not subject for backporting. It is just a cosmetics fix (or debug
> facility). Any new MADT type would generate a warning. Nothing wrong with
> it.
> 

OK fine to me.  Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

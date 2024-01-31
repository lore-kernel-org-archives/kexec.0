Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DA5C47DB3
	for <kexec@archiver.kernel.org>; Wed, 31 Jan 2024 13:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RgS+zV+cQXDQCPuwcQDDKlocetd2sm9BpOt/Z1Z0cAw=; b=lXkNRP2YUmAtb9
	V3LbfSzNF6ah+XD2dBRTNeJM6KVdsaSOEjzvGoH0kwO3biFveMY/guDG/HfwOrbYjpAIeJ/Wu11c7
	lRKhfzs5who2RuQyP6FUxE3EeaSRak7d0UUDPjdgEo8bAP1bW6NXwsaVYk0nKZuFZ1fUUDuYq4fdc
	3pASSrlE3zgaeXryq7H6/HRmvLD20FF/4ZhNG+PUH6/KSS3qwD70JSjnDMIgkNPBr0Hhhvn59u+2O
	EYqE/FyecC+RAqIqcDRiumEOdts6m5bhwM/x9cMU+vmNvjxFvTXzcPpD7bIcsx4JN3DapFVLifdPT
	WFZdNV42q60AMG7pwpKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVAJX-00000003X6T-09M8;
	Wed, 31 Jan 2024 13:07:39 +0000
Received: from mgamail.intel.com ([192.198.163.13])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVAJT-00000003X4K-3et5
	for kexec@lists.infradead.org;
	Wed, 31 Jan 2024 13:07:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706706456; x=1738242456;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kMxGEXSr3c+FcHEKFigR1pJ0y3XDrbF9poqn++jaeGg=;
  b=kPD5+z41MgtQmw54iVZQcfV7yaoZrZKbuGGFhEe9Re2vfEZ4JpV4vwei
   1hm5dT6nkEMsyUD/ycQbVplv/GHTOd48CzAT35SDPB1RuvDkl39rstrDN
   Y5VD7aOobCZuadq4Vd5+kF/50yeNxIKqTsnYhE0C6mK7M6W+mIkSmK3yq
   ZHrzCxa0559+dylSwkm+TB9KvaY0R8AW1wA7nPq0+/XVKM+REvtDbL+/I
   fmtV2EU5HZcjpBkwMTr1qEemuU9KCSg+iDkRnYsINTelca/upw9PeKXat
   UaH4zxVLSfNXPsPxLBKMwC683162+xp1DzPsSG/QGiqUjRiHpfQ/DKqnT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="2533509"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="2533509"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 05:07:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="4088465"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 05:07:33 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 05:07:32 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 05:07:32 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 05:07:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQ8ydbWL0gqnlhe/OIauik2M07r8yhHd9/WZWWoJIdqzgRn0bp0YB+FED8PnnDUcXauqrrGL7dA3FrLuPpuqglILklHWKIADtjPHJsGr3jfkwtoMsP6gr8XDY9Rz6VFaR1aQE0wJZd568oB59zbgG5UQsw8mTcb58UUhM3nXX69MDvXdVVolVMS6bYpwaA/KIiGdA29iMQWv7NXM8HE5LCPqNK3e1pP7BjsfdYRZJReiynekvU38gVUrQIg51wQEX1VgwqEx/zfy+tgAhLoosuWPR8pIZU57wKyiybEtGEkCWa8B0nQBUpNiThN90ZAfvi1AFg8OenGQQWZSb1RvDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMxGEXSr3c+FcHEKFigR1pJ0y3XDrbF9poqn++jaeGg=;
 b=HD3Ax+HYGkYbF/S7WgWG4v/KAYnxNkRwtIeB8Lo5Pu3C1nDmwakZeyLRYH5EcW/8TRO+P8OAc0TvfeFTrUXWGkG01L4RV2suSSCMko3jqn0cwz9nlm9y7zsMVBGDBMdopM1BX6srGg8xiHHwqWa2g4dzDrxdTISY9xhtVjctVckRYXvNn+I8lXya5OYTpH2TjlKGRMhAl1q5tBVy0LwJCClLMqFMYz21fvZi9fk81R9KYzBnSSDpV6IUHJrmzxC3YWeGNBxqb0MmO074aHbHglkc4/iiXoZ1forxfjQ6UjF8v+SV+30QTVXfs7XaWFFkLOLFBa3/RD3fukvYAoRkrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA0PR11MB4701.namprd11.prod.outlook.com (2603:10b6:806:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 13:07:29 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab%6]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 13:07:29 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>, Baoquan He <bhe@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Hunter,
 Adrian" <adrian.hunter@intel.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, "Sean
 Christopherson" <seanjc@google.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv6 00/16] x86/tdx: Add kexec support
Thread-Topic: [PATCHv6 00/16] x86/tdx: Add kexec support
Thread-Index: AQHaTsTUrJt5Lc/78EGyyMMPX3aqzLDyZwKAgAEqbYCAAFhhAIAAAwYAgAAByQA=
Date: Wed, 31 Jan 2024 13:07:29 +0000
Message-ID: <BL1PR11MB5978633DF36A69F8020818E1F77C2@BL1PR11MB5978.namprd11.prod.outlook.com>
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
 <3f44458f-2b4a-4464-a3df-cb791298dafc@redhat.com>
 <efe20a00-9a7c-4c03-8fcc-fce265cdbf0e@suse.com>
 <ZbpBbAkPxQZ6gHoE@MiWiFi-R3L-srv>
 <5d91fc11-0b3b-40f0-872d-abdbb4038f76@suse.com>
In-Reply-To: <5d91fc11-0b3b-40f0-872d-abdbb4038f76@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA0PR11MB4701:EE_
x-ms-office365-filtering-correlation-id: b62b4c33-41c5-4185-eb91-08dc225d9408
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bMpuB1s06iUhlWzlOIzEW5C5tQsGneU59DnNcj7j3Piuv2/GUoyJzwbaQrZ0prw9olVWwuyGZZShRmqF2DxpMYGHYHpUALCLuIoPII/AKTQHNRWp/UKI0/E752Xamp67GCfAzzXar52geQ8vS/Vs2fmEhPPMB2fjpXKaGUJlZAgchEw8SGdiBJL10kSi7gBOUXqfr/DpDtdfNrxuQPoHVELoEaXkB1g9riTnIp+Xgg4wKUzVtH9uzi7/5nE6LAG8v0ADGaOGXns+ZhKNvPzzkbjmUHXTk6yZWji3uZtk8bAyRx2ToxZNhu98U+bQgefUSb3e3FYeYFqeOubBkIpHEjVC0zsE4z0JKqGEaSN8TfwbLjpa1tO3AK5tki4zrBX2DkCU9+OusSulXbDGwGUlCc6xmk+12Gv0UZP4zHSr1KOZ5IePZGHhcarNWTyi/bMa5Z8xyOa0Uskkmyqmq7pz0MNJz5lJuY5KltaPrWgt0tCvWXBK9u4koYH64n/k1igUQXb1xb+mDoIEjrD+SYJZZKpizZfGYJjUL++vFCdzNzszy48gdb3k9gy2BiUfJVPLS5B07reN0qOqfk1R6QMGH4XhKj1kn8PwGftweICNkl/Lh8joc25Bju8csBR7ldRg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(366004)(376002)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(83380400001)(26005)(9686003)(38100700002)(122000001)(478600001)(52536014)(4326008)(8936002)(8676002)(5660300002)(7416002)(4744005)(2906002)(6506007)(7696005)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(54906003)(71200400001)(110136005)(316002)(41300700001)(38070700009)(86362001)(33656002)(82960400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0FLMXBWckJyUExSV01jRi9rTmVteGMrcFk0eTNadjN1RTJaMlpsR2FKR1hR?=
 =?utf-8?B?dXY2eTNsRmRZS2RMWllTUE5SWUxIVlVuc3l3RUdjVnFtNVp3RHZFdExTZW1y?=
 =?utf-8?B?V3RPMEpLaEprMTZTNGtYeUJqakd2KzZqVSt6aDJhaGRKWnZDSEVZcG15TEph?=
 =?utf-8?B?L1ExTmd5aEJqS0xZbFZndVdDZHcxdEVpQk4xYXMybDFmUzhqUHZUTlhydGVL?=
 =?utf-8?B?bTB0VnUxS0hxa0xYczlma24vbi9jSGtIM2hvYzZ1Sy9hN3pPbjE1amhyZ2tl?=
 =?utf-8?B?TGNYSlJiaUNPdXpmVEV4V2hGR0ZnWVRLU3U4VWMvMCtzd0VMeHRqem5jb1NL?=
 =?utf-8?B?VnZTM3o2dnR2U1phT2tVZy9sbTJPTFl5T0tTMkFoWmZpVk16RTFWSDMzd1Jt?=
 =?utf-8?B?VWM5YlBXajJROXFMZy96RkFTVXhpeUM3Yk91cHVCTFhVMnlycG04SVhPT1ZX?=
 =?utf-8?B?Ti9ESlUrZm9sOG5RUUZXVERYKzQvRTVwMnQyNjVVSlhnVzROOE8yV2pPME1s?=
 =?utf-8?B?QkV0bUlHRzZyUjR6V0hSMnYrWkpZcmlsenNNOEI5dFNWb0NjMFdLNzA2eHVS?=
 =?utf-8?B?bFJqU2ZZMUVmRjQ3dlVWR0NGTHNKeTZ3TVpHdzJnN1ltNVMrdWRXSWJ6cG1H?=
 =?utf-8?B?M1ZVbDlsV3dqZzgvc1ZLT05KcGpnZ3ozdG92cy95dkJxKy92WGNqWUlZN0xV?=
 =?utf-8?B?V2VTejBjbUtNUkdSaVhMTTlmMDJCdzRwU2Fob2R4RUM0NVJLVmJiZmg5cGxU?=
 =?utf-8?B?d0xZdXlvdkU2dGJaL1pCSE90RFlWMXIvRlhFNjJleENkT3k0ejVDOHI0YUxB?=
 =?utf-8?B?N0VPNCsvcGQ4T05mVE5oZG94QlRnVnFTRTJMSHpVeHRyMVhhYnE2NkZkcmlH?=
 =?utf-8?B?SXFMd1lJOXNiUjRjQ2RYS1BhSFJEdHJQTk9yZW1XaCtNRjJiamtJd1B0dDVK?=
 =?utf-8?B?UkY1T1IyRTBTajYyMzhhays5VW9aYytNNjRHMDhXbGJNUnVCTEV2MFZrZUF0?=
 =?utf-8?B?L2p5dUFGM3JKVURBOVhubW9la0RVdEFSUUgwSngvRzVMMXM2S1ErUHRySGhJ?=
 =?utf-8?B?YkQ2aDhSNjkrWDB5djhoZEE3VktHa1c3Yks4aEQzM2Q2c2hmZjl0eHlUTFd3?=
 =?utf-8?B?c3BqeC82YjJZKzJpOGVoNUVGYjJLT2tla1RRQ2ZrTVhqU1hWYlNzL1F3MW01?=
 =?utf-8?B?dk5PcEFieTFtMUVFaW9aYXZ3bVZGTjlOc0NqS3JGQUtCNkcreEpBWENYVFZo?=
 =?utf-8?B?WW5OOWZpRktNSzM1WFJzZGhhT3RnaWdTY0RmbFA4SzRtc2xiY05jMTlpN3g4?=
 =?utf-8?B?dmRIdnpmU0RqUXdDanphZ25rRktHdE9ZbE5ZZFNCZzB5Y3h4amg1cExtM0h0?=
 =?utf-8?B?b3V1SFgxNTJjME5CZFFUSlQvL0ZSVHA1dGtCM3Z6V1ZBVFN2aWxrSnA0NXRT?=
 =?utf-8?B?Z2Z0b0NLY25DMU95RUxvdU9CWDNjNzZucnRLVFIyU1F2ZUlkU0dWK29XM0VO?=
 =?utf-8?B?ZTlyT1YraFpPc1hhb25iSCtaZUNGWEZNR0N0TEY4QjhZWCtSZi94RFh3Q2pN?=
 =?utf-8?B?azhSOFVaUGFjUlNHTTk2WTIzUUZkT3dBZVpZMDlLTC9LMTdNaFVKOWlJVzdp?=
 =?utf-8?B?WEdrZ2dVeUhCdzcraHkza3BrNmxpQk9kVFVlYU5FN2Y2RW95Y283MXpxQ2NW?=
 =?utf-8?B?bFUwdDgxTDlnRlg3T2NkenA3UGpxMWQ1dDR0T0dDZ3ZsVTNPdThFb2hkUmN3?=
 =?utf-8?B?THUxZVVMZXdqY2JnWVM2bTFPaWlCWkpBUGprMk9za05aVFVUQ0pjRm03cm9X?=
 =?utf-8?B?NmlqNTVnTXdoVnhNRG1mNUg1V2dxeWhxeG9RVnd5WnQveFU1T0ZzZS9YYUZD?=
 =?utf-8?B?Yzd1WG5RWjFqcldRcDhodi9iWXFJbTA1d01Ja3IrTWJMZjhUZlpYSWVnYVpN?=
 =?utf-8?B?TkVDNGt1TDNSa0QwQVBuaWpQN0tuNFN3TjVRVjYyUHZKYzExRFJFQmJuRDZl?=
 =?utf-8?B?cVpWTHRSTms4cnZjT2kwdkdXQ1JMNEsva2czV1JCWXNPVHdvc1Fqem1CZC9M?=
 =?utf-8?B?Nzc2M0wrdndkUU0wR1hwQ2VKNUNHNjdiMWVGN3pUbWVlT3FpRXZoc1Y0YUNK?=
 =?utf-8?Q?VI4nSRxYEKv26atmLyN8Ps0GR?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b62b4c33-41c5-4185-eb91-08dc225d9408
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 13:07:29.0658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i+HZ8fTxHuy/2+QW2TmPTg4LgOmdt+t8b4w1gVkYgFpjkKDNiDNDp3+Wh1TJ9QfOH7qimOHgag7DfAVQBZ4LEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4701
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_050735_965901_2FA8008C 
X-CRM114-Status: GOOD (  13.17  )
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

> > Runtime disabling kexec looks better than at cmpile time, esp for
> > distros. While from above patch, making using of kexec_load_disabled
> > to achive the runtime disabling may not be so good. Because we have a
> > front door to enable it through:
> >
> > /proc/sys/kernel/kexec_load_disabled
> 
> AFAIU it can't be enabled via this sysctl because the handler for it expects
> only 1 to be written to it:
> 
>       2                 .proc_handler   = proc_dointvec_minmax,
> 
>       1                 .extra1         = SYSCTL_ONE,
> 
>    994                  .extra2         = SYSCTL_ONE,
> 

This is also my understanding.  

The documentation also says once it is turned to disable we cannot turn back again:

kexec_load_disable
===================

A toggle indicating if the syscalls ``kexec_load`` and
``kexec_file_load`` have been disabled.
This value defaults to 0 (false: ``kexec_*load`` enabled), but can be
set to 1 (true: ``kexec_*load`` disabled).
Once true, kexec can no longer be used, and the toggle cannot be set
back to false.
......
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

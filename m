Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB47BC61D97
	for <kexec@archiver.kernel.org>; Wed, 22 Nov 2023 18:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e0u/9l1DCumIaO/zdZm1SsKhhuOw1aZ+su6NsXFIg4w=; b=KT5VP0GvZGkW0z
	FD3nzaOAbHOzT+OHCHvLBdcalmX7y9STEgAa5eOZacamAMZK8FdiVd7y/++Z8vL28KoXf57Js+lBi
	0FdfOa5CiN6M5LMGuKeaW+PRq65uKHUOV/86od82kJXT2JFWNQ9/u1OEL5VttRi+PcYzXXrK/UfH9
	3942kN5QDAs0IBzgb2STeOB0Wf4LEhbqBnUT7J229W4nJgZ5TOw7QGVP6F51H/mnavuEnGtOyca99
	IGfW8+xi00qW4q6nSby2PPFFJSSwsYblYZOZitP956ULFhC8DPl48m/BGu5MPvL46YYIIRXCOZFiD
	vbkTqwaACb+VrWu54n3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5rus-002ouw-0K;
	Wed, 22 Nov 2023 18:25:38 +0000
Received: from mgamail.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5rup-002osB-0k
	for kexec@lists.infradead.org;
	Wed, 22 Nov 2023 18:25:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700677535; x=1732213535;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=m+KeDiFPGCVRDdzXqmZgr7/InfUFUFxjpOFJ/WkX41g=;
  b=ewuHkAZ4ZyXQO4YspdBd39iSwQheZ89nhJiSBZ+GPK8USdZUfyrf7HIY
   FW9S/p5q//UQPlEjscEvH1heO/sUi5dD6Z0TaFkhjQ6ui9bGJPJG2/NSu
   +CuAMTD81pzws+wuJrf9F5noujv6zDRVafCJeQV9UHK+me3Hdayy+mT4w
   PLnzipmr21A8wh93yaGL495VXve6ewdOuf2EEIHqf2JuYc/x3/SHZUAxD
   0gpavZz8Kk2mSBYX/asnrN7rVzbsEdiBKyArV8ZX2vr5UdEPdu3ietqhN
   42V9yLEJguRBKMW5Me9FEcwXCdJRZ+rGaL+YNEvYzMv+gVN7SKoIAw7aj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="382519096"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="382519096"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 22 Nov 2023 10:25:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="766950817"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="766950817"
Received: from unknown (HELO fmsmsx602.amr.corp.intel.com) ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 02:10:17 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 02:07:50 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 02:07:50 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 02:07:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyP+kBiF0xu0DGlZ5QtiyNYXH0+eeHeflW5XScN07CJGIRsDjTEIiF/xFYVYeeXbUHDOif1FUfQOleC+wndVsK5e5a0D8gVZ2CDUBPPDRYUVML3smEeq90VYbmby8kAvn7WHdwHGvinmtqEW137WFWRdBKcevPBAgiAQoPbIYrapywSSF9n8z1enm9h6Ybkckqcp10pml0bp9bp05Zn7TdzS6ipWjWLS+pEMUeGc1p/EHN9HinMpWvoOMsFDVoCnE4b0UDFv/cBuEZQhkxTdsk3X877+Y76O/bd9AiepBQQ1W6FWiqtV7474uLywUHPOrQsL3dBJBQC34vxXm7CWRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+KeDiFPGCVRDdzXqmZgr7/InfUFUFxjpOFJ/WkX41g=;
 b=Atgx9und6LJgyO0VtqfHeKmsY0wblISymTNH/5rqC10wQCpsjy2fHkDfFGzw+wyKptoN2qNrZqSXEiMoh3dRAexVxdBnUPV+DNvp0QL0/xf13K7YE66RF/vZ5AaUw2tZsiuiX4n0G5TOANLlZI/XdxHsuNuVY7flaw1v8Gmm0CqRLXnJVj8JGYzKE7vmU1UApxHgKmMhJQohyqo6M8RnDd908ywEg39vomKZBQb0MIxukUt48rlhzBlXKzca48FoYsBpOqrGKKZlV10tNNDAD6LZ+iHik4Y15vNn+tNuNjxXIgsLYF7GrcE/z4qjOYVffSGbqLzTTe2At/laslSUpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA2PR11MB5098.namprd11.prod.outlook.com (2603:10b6:806:11c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 10:07:44 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 10:07:44 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"bhe@redhat.com" <bhe@redhat.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCHv3 10/14] x86/tdx: Convert shared memory back to private on
 kexec
Thread-Topic: [PATCHv3 10/14] x86/tdx: Convert shared memory back to private
 on kexec
Thread-Index: AQHaF7t4jzxmtwRfDku+BnGgRkzK3LCEKzGAgABoCYCAAZTDgA==
Date: Wed, 22 Nov 2023 10:07:44 +0000
Message-ID: <d7ac53b76217abbb9bc06717b76ec91a376ba210.camel@intel.com>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
	 <20231115120044.8034-11-kirill.shutemov@linux.intel.com>
	 <8277e9a1df4c3fd968edf670b0aa7dc1dd50dcf8.camel@intel.com>
	 <20231121095859.36xiltn2gwgyxmwy@box.shutemov.name>
In-Reply-To: <20231121095859.36xiltn2gwgyxmwy@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA2PR11MB5098:EE_
x-ms-office365-filtering-correlation-id: 06e71cee-b5d0-4598-d380-08dbeb42dee8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pUyDlV3RJ8eKznxbnHH7pleGCcHWBU0MoojcVQZgMIutqYregAngvaAzjG7UhVXkG0ByD5LX11k/20c3s622i/P7EG9r8V6E2Hvq4U9P0KEHsUqeUuHjAPtldEg5VLKtpAjaD37bnvbLL9ccRQIg2bznmZgNd/ewSMs3GWoDt+QUyOc3spuLaswj30zPoHFdCGzPkeSK4z9dO/8EdOopRBDh50H/63S4B9c+/WVLKfFuGhA7+aQHaCJJhbATJjVfcF0dw9KrEYEp0zuLyoOqzNcxuResxT/rC6tQlVrOt2DT6N/pNxubmAfk4aTYGVZC9atOWtvJyUALr5VMFX3bj568Xm/wXN2VPkbFNZVhEqsviBVnV7CFQRQHC9o7Id9sju9EdQecvA3Dre58L0z4/Qpf+yWATVIMJye4blrQ02IlDp88tGIasXBavLYMgiOJqAIjTPYh+LAR4A9q2RmErQzHJBw5/GblXt1jYv1GHEIwt1wl6OSE9W6ftIaa/ZLnyB5JtK5XfTdzEhxv2zcpft0Ijnm/l5XWNTE5PJc/DKVIHcxojUV2sOR1+6NHCVKveMX9RnUGRBLviKvRSckaASlyyqaegzQqaXGs/1AIX174NVsuKw0XAoFeM0tEbKdpo/SEFsm2I0BkFRFuqux9iA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(396003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(2616005)(6486002)(6512007)(83380400001)(6506007)(71200400001)(8676002)(4326008)(8936002)(41300700001)(2906002)(4001150100001)(7416002)(478600001)(5660300002)(316002)(6916009)(91956017)(54906003)(64756008)(66446008)(66556008)(66946007)(76116006)(66476007)(86362001)(36756003)(38100700002)(82960400001)(122000001)(38070700009)(60764002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjdxTFQvc0VMQTVXaHozZFFUbVl1cVRrcVRBVnVVc0hTcnhkQzA3Z3VDNVhD?=
 =?utf-8?B?cnBKUUFoWDBUQ1pOb1NOcldWY2FvYStnWHVPZmluTHhNbjlMK2dJcVVRdVJ0?=
 =?utf-8?B?T242Mmp2RTRETGtTMU5FMVZzRlM3V3kzMEE3OHQ4S3lJV0k4aFJIVVhLVENs?=
 =?utf-8?B?WWZESDI2czBwYkdBMDhMekIrSUpGTlFEWkZqZ0RycUozZWxJdFZmcGRTVkNI?=
 =?utf-8?B?NTdtK2c4UmdEcTNIM0trdG51a1EzWlpBVk5WQ1BMSGE5SGlmK0NZQW9XcWd0?=
 =?utf-8?B?NDUyQWo2aDBqbkpCWmFFVElIb1MzamQ2WlJqekZqM1ZBYnV2am1kNHhTZEs5?=
 =?utf-8?B?eFVmSC9GYjY1VzBQREVrcThNL0ZXVms1SHQ3RWgyQ1JCaWJwTWlwMFpKRXpX?=
 =?utf-8?B?QXk4TE9tRkdvSks4VUYyMW1hbDNJcW5XVTI2eDVTMTc4U2EyVVc5ZW9qdGtZ?=
 =?utf-8?B?L0w4cWpaRVNicTNUSlpmaHJZRUJrYWpNS1phYSt6MDdPNkM0UXpaaW1mOFRx?=
 =?utf-8?B?Wi9BV1BBK0xLa1d4cWx6eHo4b2gwMEcwOXUybHVzWTB4MGdwUDNMK0cwV2FB?=
 =?utf-8?B?WkhCOFR2c0xXVzlBcEc5Mi8wOFF6bzdaRlNBUEdDRXUvaktuMlJ6U0hGbzVT?=
 =?utf-8?B?dlFmSmF5bTlqYmlONVcwSEhYZElYenBWRXJjVEdqNVlHUlVpQzFCaHJGdmNE?=
 =?utf-8?B?SXVFNkc3amZzZENHRG44eDkwNTh3TWtnYmk5Z1A5ZkJvUXNKa1FIc3NpZVpE?=
 =?utf-8?B?dXpFS1pTQUxlb29NRmpuZU9ySnAvS2F1Wm9Ia2lEQk8xcVJaaHQ5YU8wcjJR?=
 =?utf-8?B?ak5KQnE5RElMVHZnRnNxdEdISTNHOEpQNTlUN2U1aWxKcmVCckR5blBSR282?=
 =?utf-8?B?VFJ6OEFtVDZkc2lQUWFDcWdTcmVCQVZHNXJ6dzVWNWQxcHZLRTMrQ3hyRmk5?=
 =?utf-8?B?dW9lUHduM09FbVBRR0JsbndRNTBJMCtpc3NQL1pmL2NvTzFNYVdYYkUybzFU?=
 =?utf-8?B?Smc4TXhzY1l5dGo3MFBaWFJkczZETVN1K1J1V0NGOGF5U3QwVlNpK2Ivb01k?=
 =?utf-8?B?VnVEMWgvRmV2d0dXeDBLYmZWK00yL0RqRVBuYS9TTENpSTlGVWV2MnRUNXV6?=
 =?utf-8?B?WDJoUUtOei9jTGVSaS9RSm5YcDgwOVpuQXNKK3FOaXhaeWFIdnFJMitxSlM3?=
 =?utf-8?B?ejFjZXYxOXlveFF4akRLVFF1YTZHTUlpOHZSQUZiNDcydjJ1cTl1dUU3Q2pj?=
 =?utf-8?B?UU01WERkdFpxOW5ISTZ4OVVaUE1VZmJiKzFrYzV0cytuZ1VOWWpyVkZXWHN2?=
 =?utf-8?B?bGtOcTNUZXNFbkEyRTVqbUQ0cDA3aWt2cXh6c0dvU2pYc1RJcGZRYVo0elht?=
 =?utf-8?B?bVBzMVdERldLR0VxNUg5UStES0Z0VzJ3MzFCMDZtNXJhT0tFbFlic1hoa0cw?=
 =?utf-8?B?RTBjVEhXUzM3aVZtN3ZFQ3B2eGhHQVlnVXEzMzlKUXpnVmdLZSt0TFBKbDRJ?=
 =?utf-8?B?RXJIMmlnWVhuQXYxLytIMDhJbXRwcmVQcnVydEUxalBjWDdhbDNpcG9FTkFw?=
 =?utf-8?B?SkFid0VxR0lDbEl0dGhTUmdMY3pLL2sya1VxbWlvSldBdWZnZm5jeS9mYzNv?=
 =?utf-8?B?VTk2ckJ0L3dlVTV4WjhYNmFhbHFLd0g5YmczYW5JTThycVc2SDUwZlNPV1VB?=
 =?utf-8?B?cHNzVlRYeW14MmUweDdiRnhLejFveWJBUmJHNEY5WWdyZGZVRWEvNGdhaVNY?=
 =?utf-8?B?Vk0xdlRNQ2tta0FPRENFcWNjKzFYQzZDOTkwQm1VendWZUxIWktxa2pNdm5B?=
 =?utf-8?B?bVl0M2daZ1JXT1pUMU9CNFZ2RzFJMFJPN1VPT2poMStRelZFNlJyaUpySDRK?=
 =?utf-8?B?S1Z3WjllZmJRZERaTlo3WTdBSXpDelU5VUE5QmNaeTVVRElXRzh6eitYNFNn?=
 =?utf-8?B?eHBPelREVFlFOWJzakVkNXc0WU5xWFhENzJJcjMzU0FianV3amZEdmNhMGZF?=
 =?utf-8?B?WlJ2UWM5TjVnVkRRUTh0U3ZKY0Z4cGh5MkpmYXFHdmJpQkxYMlVjYXN3cm1V?=
 =?utf-8?B?bFcyWXBPZ09ESjFvbk5yZGwycXRCMktQQXBRNjIwS0JEc1lyMkQ3YWNRTHZq?=
 =?utf-8?B?eWpsVnhZUE1RS2RvL014SE5tUWVKa2UzTnUrcGRCK05mdGpkcEFVWGNPc29N?=
 =?utf-8?B?UHc9PQ==?=
Content-ID: <F35F81FE9B284D4EA0939E818DDA7C7C@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e71cee-b5d0-4598-d380-08dbeb42dee8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2023 10:07:44.2729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aHtqhsHJtCosm9fwu/G6c4LFQNMZGveu2yVn61gYg7NscimrEqK64WyXWNtVTNPil2lMIESYE6iBE+w9y0ELmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5098
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231122_102535_384644_FBDCD35E 
X-CRM114-Status: GOOD (  30.83  )
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

On Tue, 2023-11-21 at 12:58 +0300, kirill.shutemov@linux.intel.com wrote:
> On Tue, Nov 21, 2023 at 03:46:41AM +0000, Huang, Kai wrote:
> > 
> > >  
> > > +static atomic_t conversions_in_progress;
> > > +static bool conversion_allowed = true;
> > > 
> > 
> > [...]
> > 
> > >  /* Used while preparing memory map entries for second kernel */
> > >  struct crash_memmap_data {
> > > @@ -107,6 +108,9 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
> > >  
> > >  	crash_smp_send_stop();
> > >  
> > > +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> > > +		x86_platform.guest.enc_kexec_unshare_mem(true);
> > > +
> > >  	cpu_emergency_disable_virtualization();
> > >  
> > >  	/*
> > > diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> > > index 830425e6d38e..9fb302562bfd 100644
> > > --- a/arch/x86/kernel/reboot.c
> > > +++ b/arch/x86/kernel/reboot.c
> > > @@ -12,6 +12,7 @@
> > >  #include <linux/delay.h>
> > >  #include <linux/objtool.h>
> > >  #include <linux/pgtable.h>
> > > +#include <linux/kexec.h>
> > >  #include <acpi/reboot.h>
> > >  #include <asm/io.h>
> > >  #include <asm/apic.h>
> > > @@ -31,6 +32,7 @@
> > >  #include <asm/realmode.h>
> > >  #include <asm/x86_init.h>
> > >  #include <asm/efi.h>
> > > +#include <asm/tdx.h>
> > >  
> > >  /*
> > >   * Power off function, if any
> > > @@ -716,6 +718,9 @@ static void native_machine_emergency_restart(void)
> > >  
> > >  void native_machine_shutdown(void)
> > >  {
> > > +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) && kexec_in_progress)
> > > +		x86_platform.guest.enc_kexec_unshare_mem(false);
> > > +
> > >  	/* Stop the cpus and apics */
> > >  #ifdef CONFIG_X86_IO_APIC
> > >  	/*
> > 
> > In native_machine_crash_shutdown() the "unshare" is called after
> > crash_smp_send_stop(), but here it's called before the stop_other_cpus().
> > 
> > I am wondering if you call "unshare" after stop_other_cpus(), can we guarantee
> > there's only one cpu running in both normal and crash kexec in which case you
> > might be able to get rid of the "conversions_in_progress" and
> > "conversion_allowed" above?
> 
> For normal kexec we need to keep other CPUs going so they can finish
> conversion cleanly and get us to the known state. Note that the conversion
> is not atomic wrt preemption.

Yeah makes sense.

Add a comment to explain this?  That would help to remind us when we look at the
code like years later.

> 
> In crash scenario we do the best effort: detect if we race with conversion
> and report. We cannot really wait for conversions to finish: we get into
> crash path with IRQs disabled and in generally unknown state.
> 

Maybe it's good idea to add a TDVMCALL to query page status from the TDX module?
In that case we can avoid the inaccuracy when looking at the page table.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

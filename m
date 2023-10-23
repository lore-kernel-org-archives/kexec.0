Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EBEC00A8F
	for <kexec@archiver.kernel.org>; Mon, 23 Oct 2023 22:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qlFn1xeZBEhsQj+u2Y8BbPVUOU9NMkJDHK6mdgVejbQ=; b=bWoO6iidPl7wCV
	/LQZ3uY2NKxLrkzB0d1YD6nwZBZhmIXquGRngmusTXPWS4xoi8jX1O1q0io42Qu3iSdbpnHp332Sa
	gANJDVtfZvMMGevScW2ffD/9nNtk4jq5FD8nNwWF2uJ5gV2N43waqdau2/w83AGN8USBbYhf+yVVt
	k852a3uB2aT9HxgPG1reCACML2WtbTylJbY/3qXG5p5JAhy48bsdKIeIk65HsgwuXhzTrk6ckeXfM
	bhAt6VtKFqJrxsktWWpDQ8KIBPTUim8SrntxqgiwUC0NIjuUET7Y6wWPh5JNWZEPKOs2KUCkSXNtG
	YWDmqme89tOOTejlZb0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qv351-008MDq-0Q;
	Mon, 23 Oct 2023 22:07:23 +0000
Received: from mgamail.intel.com ([198.175.65.9])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qv34x-008MCB-0H
	for kexec@lists.infradead.org;
	Mon, 23 Oct 2023 22:07:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698098840; x=1729634840;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mR6V81BjyTYo4OFmzjTf/0azn4zPFPXAZA179q9zHbE=;
  b=RqZ4yl83+Ha5F4Pm9/Zbx+UhkMbp6BfrjI4Oa7TjvYo8pg9FVRHuDZFE
   FUq3r1qDNt0tI7tMiW0LClfd90G00IFUCa9MbJO7ITz8vnzm/WmIHAkTs
   hloJssG93X1jaeCWTdNLR420U3JPbEBsAp5ZrwpU5nSYUh9JJMuiTDimZ
   dxU2QtEbYZq3Fx3XOYRDSkUCIm3bsp2N97SSg6iltTxu4nYZSv+s8YnFB
   5yd4/+XWakOUd+DxIhltah18PiHZWlAUWX+W0I197r+xQVI/obWwE/5CJ
   NB3kKoN5OYIgoRf7v3E1G+CludXofkjqEqt+OzjV6BAdcBsSxiJRMZauf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="5565272"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="5565272"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 15:07:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="828592270"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="828592270"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 15:07:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 15:07:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 15:07:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 15:07:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BD2VWurOOhAZN6KQezAq5FqLbZ8r5hz8wff9LeiJb4uxfU0YrtQ3dQ9q3Me2epjNYVotekBNZl1qIwiiVrVOoKjLWS3J5dGn7u9g3zAiQO5oUhxYOhX4tKt2q9AvrUJRb6UDfGHVGrOm6fDzRgNXrfeGYE/8K7083wbVcbDr3D1ujUZE91uRmTJxwPxHWxrF9c48QSQoVQHBDK53qNHkdntNjbOwEhGPE/3N7g0HzLVz7CkD6ktzvDGFLPLFDLfAmqnVqKqHImRv926kgMnlmZd7cBZxpG/z3Cc3/6mM35dkDAYU3yz2rZQWJ+hb0CXXgDEcA+XBX8fDyKZxuMwUUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mR6V81BjyTYo4OFmzjTf/0azn4zPFPXAZA179q9zHbE=;
 b=LurVXJehc8N02wj8YXuKjC/npMeby4UQIRXi/qWvhZ5iacLpIj6ibaP399m+naerWk1hKjaQ+ErLS0w2hmM/YhDAy+o+TJF4tEWw27p4LpQ5f8W25AhaA2VecGm/4O6ZBm8dADGu514nKA8jOyLprGyRZ3Y6IodGuLB29Q8E2dxIEY/X2vNaiHfDUML8cz4kolCVTOAhTGme5RlHju2HfVGhfeTzU6jQs3rvT2JZBVeIxSQQ1u73Wo7lyQDu5ahQX0tz1q1OHdo3ZeYh54Yoq7noqfPckElTAhY/aD4a1RJjxztmmTRmX5dnPjhOfR1/ggdT02AuOvZ7byp9CYIXvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA0PR11MB4606.namprd11.prod.outlook.com (2603:10b6:806:71::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Mon, 23 Oct
 2023 22:07:05 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527%7]) with mapi id 15.20.6907.022; Mon, 23 Oct 2023
 22:07:05 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "Christopherson,, Sean"
	<seanjc@google.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"bhe@redhat.com" <bhe@redhat.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCHv2 02/13] kernel/cpu: Add support for declaring CPU
 offlining not supported
Thread-Topic: [PATCHv2 02/13] kernel/cpu: Add support for declaring CPU
 offlining not supported
Thread-Index: AQHaA2fulhiwSXIJjU27xCEE2qMPErBXIG8AgABkzACAAG51AA==
Date: Mon, 23 Oct 2023 22:07:04 +0000
Message-ID: <e3ffb5c47126f03ef998f4ae5df81b9c9bd20da7.camel@intel.com>
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
	 <20231020151242.1814-3-kirill.shutemov@linux.intel.com>
	 <0a29fef814e51a2aa0030ec9cc97366718859411.camel@intel.com>
	 <20231023153142.bes7zxcjc2soihsl@box>
In-Reply-To: <20231023153142.bes7zxcjc2soihsl@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA0PR11MB4606:EE_
x-ms-office365-filtering-correlation-id: 13d85db1-2fc1-4120-8e17-08dbd414643f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: entBaYKBUK+7UPA/48QzTmhxO6CrZ3a/Tq2fPq3iYXd8INfGeVNXOXtiVmLU6mZWL+G4kyDDozXI9ZgVx2uBySql4zH/bY3XPpB7vGIZlWTgOXDDoLzNHRjthpfHOpCZBzHMZBuR7xYz7scpI5IJAfg1oLGpPWey/TqWr1eSvlPpRPDUQldp+ORqmHH8i7Qc2dIop19M4lXDi7ajcCjaW+j1Zayav+lEF8SIvvf4hq+jtdrBjwnvNNc4t1WM5vWPo01JlAvNyhDXe3oaVtb0mOSOLhTpawfT3S6P70JFJXR7l8gY+yttL8vg4CCfBk9mqsub5GYYXrFNat4NYQAXhruGMWnrd/OsFN/KzrY5TvfhxYlPE01qzYORLjDAN8IWl5cpA7H92dhm8pXni/CgRm7EKKLVDGneIFvCOsnCAiok8km6EWweShFUxwAM3r83ANqLbGDbx8nfRltz+UI7uVQK0ag4RsnjM6Pbgc28vr7O1rdgE7+/SdEsS6VLZ2nlDMd8l87B1M5lm8Q7EORc+dGxWGx3hjTyajucXNZqhCNiGZOFKnoU1+wZgaX9xIqnFB9MN4XpgVqkes6TVaCNSbbJKfS636aHUwT0lGRSrAioAq4DqI/lvJIBlMsnhlio
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(2906002)(38100700002)(91956017)(122000001)(6916009)(66556008)(66946007)(316002)(64756008)(54906003)(82960400001)(66476007)(76116006)(6506007)(2616005)(71200400001)(66446008)(478600001)(6512007)(83380400001)(6486002)(36756003)(4326008)(41300700001)(86362001)(7416002)(5660300002)(8936002)(8676002)(26005)(38070700009)(4001150100001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXVPN0lPL3NjQUJiNmJQQ1Y1dVlJNGFkRlZhdFpPcjhZc2x1aHJTb3pEeEdB?=
 =?utf-8?B?VTViWXRxVHJlc01YMjRLOGxMTnFsbno3UlZYcnhDNkJVWWdXS1ZVN29jY0Zq?=
 =?utf-8?B?ZTZJTmtoWi9TVXJPTHlCdWV0aFZ3V1VvRXVqcHMwQTE4SVQzMkY3WDlQU1JJ?=
 =?utf-8?B?NDd3eGE4SUNwZElPVXBMMTU5d1ZKNmdZK0Y3V3dhdEdsYkcvbG1XRlc1Rmdi?=
 =?utf-8?B?TkgwNGFvb3hWTGZUVml4Y0pweWtJQ29vRUphS2RpUlRBbnpsaTZzdkJmdzh4?=
 =?utf-8?B?d0x1cHd6Nkx4d3U0eVB4UmhsU3lKZUIyYm8wVW1SRktWWDJSSW9YTnozVWlS?=
 =?utf-8?B?UnB3SnFzWFQvNk1xVHprdVptMlN1MFRsVkErMjRCdTg0S1loMEttRU5UdXJZ?=
 =?utf-8?B?ZDhkSi9rTndCTjNKZi8vdzZvNmJsbCtNMk53c3ZUSTBFbUgvSjlEMC9VQW5n?=
 =?utf-8?B?UWdSMnhDOHpEQUxQYi9HUzZ1cmRZajVnNDJnVkp2QmpRbFY3aWZxejRQam8r?=
 =?utf-8?B?c0dvMy8xNFdBbHZJc2ZJQW1qN1puNjdiaDBMQmcraFhDeVhBcHBPZFpjNHo1?=
 =?utf-8?B?S2hLaithM0x3UmtkM1FhWmdoQ05qbGhHd0l3RWgzamEvQlpiU1dCMWNCZU45?=
 =?utf-8?B?dHIvVmZUL2pYL0xNcTF6TTJJQ3k0MTFUNGVEL09aK2puNi9qWUhyUE9XcDhw?=
 =?utf-8?B?bkNXMkl5MFQrM1pwL2VsU21vWFBDdlV2NFFxQ2FueTJBdVAyM0xRN2d4N2pz?=
 =?utf-8?B?U0FlTzlMbFRCVGxwMnAvVXZNdG55SmJlOHNOV2ZzblE0U0RJS2NzM3dockNo?=
 =?utf-8?B?VHNQY0RyeldDVURpK1RQVFp6TytiMGk0Nm8wQ29PTlA1TWozRnhVaDgwdWQ2?=
 =?utf-8?B?b2RTczdTdk1pQy9EMTNYVjkyNEhIQlV1MjdZU1Y2ZzJKdFo3T0Qxekl5aDB3?=
 =?utf-8?B?eWJWNjdJSm5yRWc2NFVGWEQwVU9QUEprY0Z3REFpTXZnblU0WmpVdUl6c1VY?=
 =?utf-8?B?UENzWTBwTWwvLzk3LzY2RWxRUUVrUldoMktFbTdIM2lnNVl3ZFVuWXJQZ043?=
 =?utf-8?B?SzNxY2t4VXRvRkE4SjNoSDZja21tbDNUSGFyTFUrUTlHdDZ4bEVuVVNFNDFB?=
 =?utf-8?B?YkFqM21xY2NpayttOWdWcjRuc3kwZTJVMDRiRVk4am9nRWJOaWNmSldmSDlw?=
 =?utf-8?B?bnhzWHcza09oY3Y0SXFHNktBR3Vxdkg2QU51NHAvU1pPcmFHSy9SZ3dJTnlt?=
 =?utf-8?B?eVZyWEVSRVU3TlJCVnE4VnRhSEF1bmlUWmp3V0F1MEVya01KQ2EzaW1sTzQw?=
 =?utf-8?B?NGt1NGpXVlpnZnM3WXg5bitYb1B6SThJcFlMNnUwMCtkV3BzRnQrSExodW1n?=
 =?utf-8?B?clMxZndPbFhlUE40K2orSmRwdk9ZQjJzZUJ6QWVUS3NLd0ZEZERTV3g0MkNL?=
 =?utf-8?B?OGFTM295Y3lld0ZCUkVPQ3dsa3VTYmtSZmZSRlNOdHozZUlFNkM0VTd0blpp?=
 =?utf-8?B?UlNGM3NQNkQ2L2YvUGt4VlJYdTFhblZVRFA3TzRDczhWd2VsZi9vOTk0SlJX?=
 =?utf-8?B?WW13R01ubHkrR2tVRktOQXdmSFdOMUpNOTNpZWtiNC9LYnRYSzZPUlAxRU40?=
 =?utf-8?B?L2xJclRnV3poS2t6aEpwdnVTZkdCeVJDTkV2VTR3SzB0Wms4cUVZd2RvbEVC?=
 =?utf-8?B?QmVEdkJVMFdsYXg1a0svYWxaTzZqd2pQbVpUbVg2T3hpcnZnZVNtYmxKVE0w?=
 =?utf-8?B?ejJOeEtnd212R1ExVDVINjd6dGRzYlNXSVdyMWFNY1Bza0FsYjVSNXZNbHkz?=
 =?utf-8?B?Qm5aR0lmV0dzeWp4NzhRTUhuUnhjUzNRcGpPa1hRRTFVeG10S2JQemJ4dVgy?=
 =?utf-8?B?cWt4NFhSY3dUYVdxWWdCVzhQQzVja2Z5QkttekQ2d1U2SmNqejQyLy9scjRh?=
 =?utf-8?B?eU5MZm9UN1hVUGNIUEMxYjVSbzkzWWNjMktnZXg1Tk10YWlpTnQyNHZTN0Vx?=
 =?utf-8?B?MEdCR1RYRmxnL3UrWjE4bmVFUHA0S0FZTk1HeG4vSTh6OUdkc20va0YvZ1F3?=
 =?utf-8?B?STNwSnllNFkyb1UrQlhkQzVrcThEZThOTDNjd2NJK29raWlGb1dVVjNaMmhm?=
 =?utf-8?B?cEl2ZE1HNTFKSE9UU1U0djhIbGhaSGtkak55RENJM3lXSzV6Q1lURnRCUStC?=
 =?utf-8?B?OEE9PQ==?=
Content-ID: <A1AE6408115B01479CD1F4539083C91B@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d85db1-2fc1-4120-8e17-08dbd414643f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 22:07:04.9439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e5FZ1G83m/iz/CRxpVbEbBcOjnINQIT+OG8F+7yvU+265kvLJFZW9qOXbn+AuyRGbd7vMWzmF7MY1uSdM8Lqtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4606
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231023_150719_186325_69D539D9 
X-CRM114-Status: GOOD (  26.34  )
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

On Mon, 2023-10-23 at 18:31 +0300, kirill.shutemov@linux.intel.com wrote:
> On Mon, Oct 23, 2023 at 09:30:59AM +0000, Huang, Kai wrote:
> > IMHO it's a little bit odd to have two mechanisms in place, even in this middle
> > state patch.  Is it better to completely replace CC_ATTR_HOTPLUG_DISABLED with
> > the new cpu_hotplug_offline_disabled in this patch? You can explicitly call
> > cpu_hotplug_disable_offlining() in tdx_early_init() so no functional change is
> > done.
> 
> I can. But I don't see how it makes a difference.

Personally I think this is better because it is odd to have two mechanisms in
place even temporarily especially when we can avoid it.  But no hard opinion. 
Up to you.

> 
> > Or I am wondering why cannot just merge this and the next patch together, with a
> > proper justification?
> 
> Because the very next thing reviewers would ask is to split them :P
> 
> > Btw, IMHO the changelog (this and next patch's) seems didn't explain the true
> > reason to replace CC_ATTR_HOTPLUG_DISABLED.
> > 
> > 	Currently hotplug prevented based on the confidential computing
> > 	attribute which is set for Intel TDX. But TDX is not the only possible
> > 	user of the wake up method.
> > 
> > "TDX is not the only possible user of the wake up method" doesn't mean we need
> > to replace CC_ATTR_HOTPLUG_DISABLED.  E.g., other CoCo VM type can also select
> > CC_ATTR_HOTPLUG_DISABLED if it uses MADT wake up method.
> > 
> > To me the true reason is the new MADT wake up version actually brings the
> > support of offlining cpu, thus it's more suitable to decide whether the CoCo VM
> > needs to disable CPU offline based on the MADT wake up version, but not the CC_*
> > attributes that is determined by CoCo VM type.
> 
> No. MADT is orthogonal to CoCo. It can be implemented outside of CoCo
> environment and CoCo platform can implement other wake up methods. It is
> not up to TDX/SEV/whatever to decide if offlining is supported. It is
> property of the wakeup method implemented on the platform.
> 

Yeah sure.  Can we put this to changelog to make it clearer? :-)
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

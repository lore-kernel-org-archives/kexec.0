Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553D6C5ACB3
	for <kexec@archiver.kernel.org>; Tue, 21 Nov 2023 03:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=82vkEcNYcKSYsxLfPtFy0WnQbKOaHBs3/JezD2k/cbo=; b=MByM2aa8avu5dM
	TAb1sfyfAwxn2uPl3v1kKa6AKgdHo3fdZ6u96f+2tEztlZuEvFOW6CVoLJHrvHuLi/umFlHK1RmFw
	b73T1qYugTHae1X5nN1SSg3wca1J0YgEO2u/ZB9xpQeHub2NWb7NSJMZKFNujAl7ccIAtpSBazAJ6
	rU2Hnzcjz2LHbdRyFUbyHX1E6sDpmhHOk0nGTvX/zOrQGxsoerzjwRAiVPiSJ4XgzhPWNLw3KaKpz
	s/VKdG0ON3v1C0qoCj+3HAoIUfr22pZ5s6rcnBbf6QHumxqhHe747Rr0fVd90p5gJagUsBnlVWjmg
	58IizdspSsEwKx0ZC44Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5Hiu-00FXg7-20;
	Tue, 21 Nov 2023 03:46:52 +0000
Received: from mgamail.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5His-00FXeV-0d
	for kexec@lists.infradead.org;
	Tue, 21 Nov 2023 03:46:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700538410; x=1732074410;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7Pib0oCpJWKBAAk+JbTQaVJ6+M0FVnCFzepeUn3kwFo=;
  b=RhvmnIVBfeffsqYCEBUQzzAgXWECWFeMqk/4mw+PNkrfowyWVJ77daDS
   c0AqQLv6Ga9lAE7HqICEM0bipn1dj3ngZhoxAUYgba6SkAXK9Qw3Qqj5G
   k1Fhy5jjVVo27zX4+BYDygX3fAOAUmufTsQlMBXoZmKmR+xeW4my9XeSK
   3A0gzd/R13YpXZ3S0auZrzUjB35eoivbJIBkhJIO17ppaGzUsDvGwfoec
   UcQOWcuXNl1yI7PZoXaWHAKIsEYrrHIRlAianEVSVYqeUWlEcLqyd5miS
   PwZ3WMblMvBPv/w/LumMWdQ9lpewJVBYFnAjsbPWmeUlbo9jnDXwNhOzf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="458253711"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="458253711"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 19:46:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="884057077"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="884057077"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 19:46:45 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 19:46:45 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 19:46:45 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 19:46:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNb36l7xPFWbaHWyirN4Gg76SQpIyTFEIAkVBoEUERONhddmomYDXzrQmxcWjhY4XGfvMOBC7ez2EyjkeAgycixL4xhllh42FEdmkyShFsm+YOvc06/y9h5HUWgnNU03yCD6lWiFWMqe/HF2lNRqKoU5FrInFF2IVyyD0KRSlN9oxUehsIIYvJ7z25MMaRhAZWa9ssX1KTH+7bu03yoEo87YV0jogOS+vaPn6e0s5BzpKz8mUqUrVMEco3KpD4OhG04k/toRzErx/HBR0EFcA4O61DzP6ZjeYfvL1My7lIoh9UQfY1MIPeVDYu17IG+daKFxvJerIuSL3LyNFfnKnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Pib0oCpJWKBAAk+JbTQaVJ6+M0FVnCFzepeUn3kwFo=;
 b=FIMRgi1uHvz41YBrJhufzT3VoMsL8mmsHWVRjKvQcV8IZpFUldiXkaEWkrL1wVcWG8MCPR161GMnbrPuX87rXbYEB3NAct0+CcE206rc3BTw2ecYOVZ2mfifujMifmQHAjudXkUJpf8bXWWdBGqBcDsMLecpaTcBzsF/fjby8cUbntq79JNRSchAUjuBgUvUGoSJEWDYX0YY4nG5euVMuzGdaLrBAInW0FEW5W7FguQ2Q6vZKqWO+NqRw3NtsQVHg+vXl5sbE2iShnHapNnifaQU07gidQ6kHP+Y++rYKB/MgfhTmj9c+tW/S1zUDyC8MdMUMjgaY/xvK1+tm/yx9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MW4PR11MB5892.namprd11.prod.outlook.com (2603:10b6:303:16a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 03:46:43 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 03:46:42 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, "seanjc@google.com"
	<seanjc@google.com>, "bhe@redhat.com" <bhe@redhat.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv3 10/14] x86/tdx: Convert shared memory back to private on
 kexec
Thread-Topic: [PATCHv3 10/14] x86/tdx: Convert shared memory back to private
 on kexec
Thread-Index: AQHaF7t4jzxmtwRfDku+BnGgRkzK3LCEKzGA
Date: Tue, 21 Nov 2023 03:46:41 +0000
Message-ID: <8277e9a1df4c3fd968edf670b0aa7dc1dd50dcf8.camel@intel.com>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
	 <20231115120044.8034-11-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231115120044.8034-11-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|MW4PR11MB5892:EE_
x-ms-office365-filtering-correlation-id: 6e7a4aa5-c381-44c9-b2bd-08dbea44792d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yPoflpdK+U0cdBqqWbEiiHyHFSrdhjaFa0Ly2ZlzjcVoKY7YC8Qxg1y6TRbmnGqXjrQm1xBIfZR7mDq1cfjx8s19LHLNwVdv61OwdBP/HOmeYPMMxzlpOyuYle83mh1wzswfnc/GrcJjbsiUZBIjQlXF0s3CyQhQLYExSmNPd/o4uiRF1t8uj3+z7FazL73jlNlslDP30hk2hLFDvdGWWWFCgHbm+OnM54Ma4/KNawgdsrvOhet63pjDUA3PR982D1uJa0nBDYkW92rId8JQXgZFO8Pg2CpIrRbRt2Fo3lC7CR1KmMib1v5rC5T6kOpDNZTVWkyfEM4ROCQCjVcBBLz5NK45YUeqqD2EwN29zgomIwwhcuj6zPY9bvAt5+90IjfhZ1dEdCxnPEMY/25OG16V9eITdqQvQP6erg+MAO4CUcxF8JZnSszlbDmfmrdNnrmJgCYAfDp1e4nUfQ7WVilXFN8xjcZqBH88PSSyAZ7CPfLrNKS2AsOl0LgGhSDvcWJwmJjSmcU9SxrNQIxhiqEHg2lLPVfrih9GxgneZsfMMC1V2wpC96xM/fOXdsus3gB6ruPfHr9cIplv6ZCqvnynZBAgbNXYCOi4xbRTJHsuMdDpPGwEgT34T9NPy3nYWHFDK+MJj/8324L8PUVdLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(396003)(346002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(5660300002)(2906002)(7416002)(122000001)(6486002)(82960400001)(38100700002)(6512007)(38070700009)(86362001)(36756003)(26005)(6506007)(2616005)(478600001)(71200400001)(41300700001)(8676002)(8936002)(4326008)(76116006)(66556008)(66946007)(110136005)(91956017)(316002)(64756008)(66476007)(66446008)(54906003)(60764002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHNpblgvYnJOaytaUElNTW1kV0tnaDFYTWlCYU95M3gvWGdNQkhkQzRsVEoz?=
 =?utf-8?B?Z21XNlo3WDVLSnVKMFpObjJsN1dvS0t5Z2g5ZWVuU0ZBTWkvV2IzRW5BSG1P?=
 =?utf-8?B?YzZBN1FiRVNQazhtcDY0WXZFZ3l1Q3FENHA3WkUzVnlkc1U4RDU3RS9ES0to?=
 =?utf-8?B?V2FPczhIRDI4b0tJWWRzYmxGdlFkbmhaMDR0RXkvVDYwZHlMN3MvSlVBWW11?=
 =?utf-8?B?YzRUazBUQ2hubG9PbURjVTcxb0FSR0tpdFI4cmx5VEp4em0zWEJONDVXZHFv?=
 =?utf-8?B?Tncwb0hqYTVxVEpUR3ZJbmV1aGkrdStTTzdRUTFXVTM0ZE9VdEVPWVlIY3lw?=
 =?utf-8?B?WTAwWVl4U2cxQitkaUJjVHkzcWZtOE01T1EyZExreDFVSnhpM0FYQ21FVG8v?=
 =?utf-8?B?SDRqOUVFV0JuQmE5ZTdvZ3VCSWVGVlArNjl4QzlnTGIyQUo0cDRpcWorTmZR?=
 =?utf-8?B?MSs0ZGJwZjJ4aEFnL2xTSmxPckd6bWJLK2ZtQW5MaklTVXpIMHU4Z3dUaU5a?=
 =?utf-8?B?SGVpTVQweXYzOXA4MkxSemRFWXZOdmFtaEsrNThucVhhdWRYV0tOekt6dWxv?=
 =?utf-8?B?am03b1RsRldrdXhsSHc3MjVLOVFFL1I1cWtPVFloUWxndUw2aDVabVZGaFFN?=
 =?utf-8?B?THNDMlJ5ck5kTVdudnNHRXdtMGRyQWc4ZHZRaFp4SFlFSTBZQXJ0NU9mQWY5?=
 =?utf-8?B?NlpHb2ljRlFNRUtNMGpuWW5mRnhKd3U1bzIrYjZjcmtiTVIzVU01RjRpY01m?=
 =?utf-8?B?NkhPM0RLOVAvWlRMSUJiMDduWG5zOHd3WEM4M1RXWGlBc1hETU56U2ZCdjVY?=
 =?utf-8?B?VlZjeC9KTWk1eng2dWxIUGV2QUZmSEJXdytQejNIY3lrOGVlQWFnVWVRU3M0?=
 =?utf-8?B?QTdFNy9aU3NaVm5ReHRkQkxvUnR1eXNXbmVRY2VDRHV4N3h5UnA5amlKNGhh?=
 =?utf-8?B?c3BjY0hGMXVnTm82Z1BKbzJ5dFc3a2J2SWR2N2dIU3dnZTd1SVZ2c1lZRERH?=
 =?utf-8?B?ZGZ0MTVEd01aQjArTWN6ck5CRHBiOERZZDBxK2pCZzNqbFROaWgweEM2UDZK?=
 =?utf-8?B?SkgyVnI1b2NhWnM0UTdTRHJmZUUySWIvMFRFdWRhblFkSE1XaFYwVDByWllq?=
 =?utf-8?B?eDVmNXY4b2pOck5aa2kvYXRaNm9keHV2d0VuZ3BNY1BpNEliWVhBcjhKNHhI?=
 =?utf-8?B?OUtHNjFhSmgrbFpCanlyVncrODFqSWhIc1pwWVZqS1VTUUc5U1RBbmFKL1do?=
 =?utf-8?B?dEVSbjdlLzNqaTFrU0ZqY0x3cmw2c2prbENFeklmUHpIOXpBTmdKbFBrSWlE?=
 =?utf-8?B?SjVWN0VXQ0FYSXpyeEtFdkNTMHBwOTdFandBTjdwbElGNnNJYVJiZlYyM1lk?=
 =?utf-8?B?UEVIZmJUSGN5cENZNUYxYnJxMTYzTG41SG9BNWJ2QnF4L1ZJSW05Wks5NG5W?=
 =?utf-8?B?MEJZUVBqYU5mQXhLdks4WjRQVGllb1JTYnFNRTgwUUFPV2hVOG5rRVRZTWQ3?=
 =?utf-8?B?c0krbHdpdFVDSC9sYUFKaXhob2RpejlXc0NpUFI2Vkw4K2JIKzVJci9ZcWts?=
 =?utf-8?B?aGltYVV3ZGYxbUN4TGwzNXhoOUMreERVazJrZHRYOEtGYjZ2L2R6dVFnQ1U3?=
 =?utf-8?B?MWIyTExSdkEzM0NnSFZpTytGcmNrTEgvMVYzUkJkRGJQZFB4Uk9JQUtsbDc2?=
 =?utf-8?B?ZVMxbm5hTEtHQU5HMEhibG55YnFwaEpMSWdzUXRvcldhNGk0U29uRU1CRDRU?=
 =?utf-8?B?NzBVMEFEM09xSFAwWUQ1YnpNaDFicVE1ejdBZEdVVkZCTmN0ZW5oUEk1Q1BI?=
 =?utf-8?B?QWNiTUl4K29HYTE1aFpldWp3eTJ1QWJFL1ZocTBoV2pGVHR2N2FHNi9LRXdm?=
 =?utf-8?B?a0d6bU1QRmV1ODl6c3ZyU3dBa3VaekN5N1haa1J1RDlmVkhxM0Y1a2t1Skkv?=
 =?utf-8?B?dnh5ZnZLZVErVHh0alJLTnliNk1qZWZTUXFzK2ZzU3R5djF2VzUyeXZJM210?=
 =?utf-8?B?bmdXVDRVakN5MVo2emtaZXQ2eDlvb0c5K3AyUkdxRzJtdHVDcUg1ekhzTDlw?=
 =?utf-8?B?ZVhOdU9HV1MvUHFEWlQ4TWc5VjVTTFNTTVJ2aEUza3dTR2xTUHVOOUNjZmFx?=
 =?utf-8?B?VVFhdVlmcUh0bGkyYm9UaUZ3QnNNNVlnd2tGY08zNDNKZlo1dzE0TTdYSStG?=
 =?utf-8?B?Y0E9PQ==?=
Content-ID: <6E04DDC9AE12E84FA8D3A5D7CF22D0C4@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7a4aa5-c381-44c9-b2bd-08dbea44792d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 03:46:41.4732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fcY+AlohoYLZuCf8XUAWFfdfK4fX581HquUGWZpVBA49IdQXG9QlnETQTGOBCEVBYuguiAeygy3myWIZBsHV6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5892
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_194650_374052_E499E3E7 
X-CRM114-Status: GOOD (  16.56  )
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


>  
> +static atomic_t conversions_in_progress;
> +static bool conversion_allowed = true;
> 

[...]

>  /* Used while preparing memory map entries for second kernel */
>  struct crash_memmap_data {
> @@ -107,6 +108,9 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
>  
>  	crash_smp_send_stop();
>  
> +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> +		x86_platform.guest.enc_kexec_unshare_mem(true);
> +
>  	cpu_emergency_disable_virtualization();
>  
>  	/*
> diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> index 830425e6d38e..9fb302562bfd 100644
> --- a/arch/x86/kernel/reboot.c
> +++ b/arch/x86/kernel/reboot.c
> @@ -12,6 +12,7 @@
>  #include <linux/delay.h>
>  #include <linux/objtool.h>
>  #include <linux/pgtable.h>
> +#include <linux/kexec.h>
>  #include <acpi/reboot.h>
>  #include <asm/io.h>
>  #include <asm/apic.h>
> @@ -31,6 +32,7 @@
>  #include <asm/realmode.h>
>  #include <asm/x86_init.h>
>  #include <asm/efi.h>
> +#include <asm/tdx.h>
>  
>  /*
>   * Power off function, if any
> @@ -716,6 +718,9 @@ static void native_machine_emergency_restart(void)
>  
>  void native_machine_shutdown(void)
>  {
> +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) && kexec_in_progress)
> +		x86_platform.guest.enc_kexec_unshare_mem(false);
> +
>  	/* Stop the cpus and apics */
>  #ifdef CONFIG_X86_IO_APIC
>  	/*

In native_machine_crash_shutdown() the "unshare" is called after
crash_smp_send_stop(), but here it's called before the stop_other_cpus().

I am wondering if you call "unshare" after stop_other_cpus(), can we guarantee
there's only one cpu running in both normal and crash kexec in which case you
might be able to get rid of the "conversions_in_progress" and
"conversion_allowed" above?
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

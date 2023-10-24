Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF43C07545
	for <kexec@archiver.kernel.org>; Tue, 24 Oct 2023 10:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+xKCEqqm6225hUPlmbQf/T9AG3i/45LYFnEXGQNztQk=; b=Msock1m3ZIVaT9
	pjHQHACS9jzvapzgPeTBt8EkgfDTCU9asdA5U4aALev6byiCBTe5qm6zCILCeR56trSwMQGyelV+q
	63SSRbxw9myWTEW9e08xDrNowoemp6SAeHbXJR+Qi9infHb6DN8MzOkVUyMy+140ZBi7aetsmaJ0B
	781bPnteo+E1H6aXJYxQdc11/H2UNEVsqhwjt13jDvf/sKhV6YTOhUarW5LyN1GXQzLH53qGLhTyh
	h0+Ot0o6kAOuP/vwpaG4z+NyR8bgpM+HdGtlVWmZis8E4Z5xJaBcCYq+oRNOvigg+MRJWKdD+hxVa
	K0Si4JYu5pr1T1UghFaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvEUX-009QCO-1v;
	Tue, 24 Oct 2023 10:18:29 +0000
Received: from mgamail.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvEUT-009QAI-2S
	for kexec@lists.infradead.org;
	Tue, 24 Oct 2023 10:18:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698142705; x=1729678705;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vj0FtENoWmEXqcpWNvsxQIHzTTrJxl9c39IYyLj7Smg=;
  b=ji7Ofc6o/pF6oRQBD+RW/g/tMVt0/t2/W2Xyp9MX90FygWr0sHnFupqy
   PWT+DiTXWhEzTPvoF77x6Ct4Olb44vs6yBHeyvCSb+HJaOOJhA5OjvorJ
   0il/jz245MZWbxxjv/PQ06o8ULR5n4zrPYDW2vT5/ELvUBX0Emnix1CdP
   dMoQ6SBXBJcgVZ+wF9SoJzVWssfyAIpry3AXi54cDIKBtct8zSmEHTeLB
   jAku6LahhHHJK0/3CWMTcJdXjJ+RIn12ketjBmLee/AZG6Qe0uPNmJ+1k
   PAmadlyy3FrxQEJgHJUtr0prICYcCOYhxr2T2hz2omsO9OP5lMnEEP+Y9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="385922246"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="385922246"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 03:18:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="875023341"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="875023341"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 03:18:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 03:18:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 03:18:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 03:18:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 03:18:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFUASRbP10V4Xgm+KcX6kv2LTPqPGC7xNVF0OtoppTwNxdLz1UL9fvsi+oqO+U9ONfI4sMbfZRWgfA+IGD4x0ZNmlJqdtGEkVdcCdoDjWXFJ/DNM1TrAY6scHpCp/uJcG6F3G7lpLVcU+9ebvo9mfm10JBrpm10yG7xVtLXC6jKYSkAnD59rrPMJkZ1dSrUReLgjeKYaWY11DcSvS/SUwjfu5KyUL/4IvMWt9hYDgANEvri4JJNYB8xSQqzOi3dyCCNp/9sh8xWrgycAn/SF4XFcbXxIiZYayr5DM3+wqY5ym29cCqqiuLZieDIboqjH90F3pFW41/e/JZ6BQFDwfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vj0FtENoWmEXqcpWNvsxQIHzTTrJxl9c39IYyLj7Smg=;
 b=LFXWmSdzvyPw4W+zqY772OY0D3bcK6cHITxWXwIZNDG6ChVhmQ499DylHc+ii/tIVXYqgN9bFpPX6zZNmrRlNMoMDonefft5D/N2De0gzJBEyvayie7Q4FXytv1Pc1SF6NoJRnwIEIFXxZt35TVGvUhi+ukP6MZqbnbJNkKH+qxt4yksMrIipeKa3WFoRL8W7npWYQSqLvzf7yfZ24X6GZ8Jgjuv+5vs/NNBFN3nUeqi90u6MkzGcct+92V/KIswnbA05lowq09n/BBBsNOygi4fZb3cMkHhO0TPqRNFfHc2kJ35NFgbeYKupK9eoaXbLkWaPAu8T0xF1JSiQ4b07g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA3PR11MB7584.namprd11.prod.outlook.com (2603:10b6:806:305::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 10:18:17 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527%7]) with mapi id 15.20.6907.022; Tue, 24 Oct 2023
 10:18:17 +0000
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
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Christopherson,,
 Sean" <seanjc@google.com>, "bhe@redhat.com" <bhe@redhat.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv2 12/13] x86/acpi: Rename fields in
 acpi_madt_multiproc_wakeup structure
Thread-Topic: [PATCHv2 12/13] x86/acpi: Rename fields in
 acpi_madt_multiproc_wakeup structure
Thread-Index: AQHaA2fvy/mci/52H0W00rFaX71mEbBYv/yA
Date: Tue, 24 Oct 2023 10:18:17 +0000
Message-ID: <40aecea05530f65a1e252a4fe75724238a8d0fd6.camel@intel.com>
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
	 <20231020151242.1814-13-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231020151242.1814-13-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA3PR11MB7584:EE_
x-ms-office365-filtering-correlation-id: 8df6c471-bf77-4533-555b-08dbd47a8a82
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VSKeRaZf0qWyfZs7zV0jolq5wAXzmIoUfpzcb7jYKvJfTjzHDXnkWEo74b26ta18vx2zo9HKaCT5n1KVQVcnDMEzG9iyjvfUxxK6ZWnSZD8a2aL6aHDrWyb1S40tBYoYLGSheQHurlQRkIK+9x7mfoKRn2gh9h97+FnLWtJMV9QdoiMuQ8Op8aiczzgqTzDyvvhkM2lazOKAoNnN41OFs1WQ2p6JynuZ8T+VL//D1tQQXGnuJ77gNUr05IdhsyB8s6GdENKpbP6o5IyjZDhkso1OyvMQFvOktpeqxs4KAR/CGYHcr4HI21lH1wfwP6sUQbfK/3nnuV/GjCSXjXkHiI6j3WqxPHuRfZ4WrxxbB6yFhgSFMtvMRisabAgrpPmYxAz08VHWoSditzKhEkbH7XVOv0/IYxn/QZqKLUB8UFpMyINDMbeEy1r+V5gu1AuSpB+6jsvOurBCkdcmoBxjESyNJ6kKAu+A1XnyRDNszC1rdxb9yUw6mBwnNMzxUSr+VWIC3d4025h87P3Jn5r3n73Q8mhE7thHFPjkt3XHiTMCBExVat8zLeS6oOaUuzYOI1vTyDgfdAOMSHo82gG+Ar6VtAHrqMORL19soUn4QZzQe/DKRlrPh7Mh8dZ5nR6f
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(39860400002)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38070700009)(6506007)(2906002)(7416002)(38100700002)(41300700001)(86362001)(4001150100001)(36756003)(26005)(4326008)(122000001)(82960400001)(2616005)(83380400001)(8676002)(6512007)(66556008)(6486002)(8936002)(71200400001)(76116006)(5660300002)(316002)(478600001)(66446008)(66946007)(91956017)(110136005)(64756008)(66476007)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWhJWkxJQmZibHViU1RMTHVzdW54S1hDSVN6NEVBcUxqYWIzVmQ1YzNXZ2l2?=
 =?utf-8?B?Z1JGMnlHallHQ2ZnaFNacHFMaThodS8xOFBPRTVjeXJUNkpvZUVUOHQ0NHNJ?=
 =?utf-8?B?bWhQS0g0TjEvamRQU0ZDUWxXdi9OVzlpVlZWUWtrWU9uS3NVaHhrYWgwOEZj?=
 =?utf-8?B?ODEwUkN1S1VENElONmJzTzF0cnBqL3M4WTdyd1VlWWN0cjBxdWgrVGtHbjFn?=
 =?utf-8?B?T2NwdTVzWHU3a1pGaWpYVXVUMURSa1ROU3F5U0w4NGxEYjc0Y1VXTy9iT0tz?=
 =?utf-8?B?MzZzZ2NpbnY5Sk13aDF4emtYYUhkZGV6blZqZTNRblRWU3lmQ0Rvc1gzYmZE?=
 =?utf-8?B?bmt1WVp6T1BMUVlXYWJtODU3Qlo0WEgzTU0rblpCWDVvcklHV3dKQ0VLdW1Z?=
 =?utf-8?B?YmhNMExITmFxUTB4ZEV0UXM2YjBnajhEZjk3d2FvV290anZ4QTgxeVRTTjlX?=
 =?utf-8?B?ZEdRWXUwK1hTZE9jVW83eG0wdm1oV2VnS3BOQm16VW5mdDdrSktMZzdkZXBF?=
 =?utf-8?B?YkFMUS9GQ085NHFuamI5RlhoWnNobkNiTXl2RW9FRmtzUDBvOXJjTXp6dUR0?=
 =?utf-8?B?dXB2ZzNnVXA1OTdlQzZudWxUblJiS0oraXNkeklGM05FbnJZTFJONVhlRTg1?=
 =?utf-8?B?dDF5Zk1hUC9aMDAzcWNZSDFjUWM4WkUyYTd1cnJhMXlKS3BTREluQ08rVlE3?=
 =?utf-8?B?S1BrRUJwbFp3ZWcvNWJTNlZHWnpJdnVzUDB0RmpLTGZ6RGJ2b1Bma084QmpJ?=
 =?utf-8?B?UTVQYnJ5ZVRmKzFCZHk3Y0EvSXFKNmxvb3JZcktmREZFZHZhSUdzM3ZDMkhs?=
 =?utf-8?B?YlpleVNBT2Q3d1NBTk5LdUpQdnBCUTk1WHNKVzU3Nzl6eXRjRG1zL04veTRK?=
 =?utf-8?B?YUN0WTNITytRbUhlU1JSRU1oZHZjYXo5VU1sOXN6R2Y0bFhHQWRrVXZoQ1dM?=
 =?utf-8?B?Wk4xOC9uMzlKbzlRTlJveFNMQkRyK0pxTHlXRkl5RWVWWVBrbVQwRVIwL3JW?=
 =?utf-8?B?L1EybjVWZTFqaDcvdi9YMHJ6K0trOENNSlNyYTI1N3YzMHVPUS9KOWtwbXBC?=
 =?utf-8?B?WExScTBWbHVhc3ZseGRpMTQ1Q3VnVW40eW8rZVhRWUdDNWg4MWFyZC9FZHA0?=
 =?utf-8?B?djJ4aHdBM1BRQXpKQ1ZmNktoYUJVeldSTjdJU2c5dWdvZk5WcUU4OXdVdVVF?=
 =?utf-8?B?S2orSDdZU2dZbEM0NGF1UWp5TWNaQlM2b0pZWFRkWXlJWStrUzNCY3BLdkZa?=
 =?utf-8?B?ZEkvUUdzbVhpNmplVzdXcEtuZFllMlJnMS9nbzNUckxuSkFDTGV1VFhsZ2Z3?=
 =?utf-8?B?dGQxMkNDWDJIY21Yd3Q3aXFWYVMwK3JQVkFiemZYYndyRTl6dHFzSXIyV2Ru?=
 =?utf-8?B?Y28xK1Y5UFYyOHVRZTdjcWhTWEg3STZDTDF5SGJveHorY1JqaXVnWThKNzM0?=
 =?utf-8?B?eHQ3SUZLTU0vOUllaW5YejNsZzFGc0ptUlpSWUtRQmloRnNMZnliRS9DMkwy?=
 =?utf-8?B?a3drZVFibEpMZXNDMVdIbWYvdVA1N3RXREdGdVRGUTJORlVKeUVvTUIzVWdj?=
 =?utf-8?B?c1FWVGhFbHBBcTA0bi9jbk9ZMk5QZWE2UmJlUnBXaFZNY3o4R3Q5YmZUOXp5?=
 =?utf-8?B?MGxrbWRkaXY3K0ZEeGE4UjVMUU95cm1TeVQ0MW1TVDZ3V3VRYlhmbzNkUk1W?=
 =?utf-8?B?WHViTWEvSWc3U1d1bzdVVTZNbHl2NlRvOU55OW9GSlcrNnp3dHJSbXozWkx0?=
 =?utf-8?B?YlRZalFIRjhWdncxVWZnMFplZjJWeEIzNTdwdnVCU3VJd0VKUUsvSW5WdFYy?=
 =?utf-8?B?L2RDdFlFSm9NckM2U3B6azdXWDZWV0oyL0FYQnhJUDNqd3Q0WmxVMWw4bkhJ?=
 =?utf-8?B?dS8vNE1QUXE3Yk1jejVaV0QrQmJscVlNdkFGUzhLODBVajZEak5pUzdqSURO?=
 =?utf-8?B?dTVEbVVSalJNTzZWUTAwclA2SUlNUzZvMUg2N1FMMWV5NHBuS2NmNWgyUm5k?=
 =?utf-8?B?VW44NkIzNkJ1Nmo1cnAzQnhpdXA4MkxHbEpYSlpKUHpsM0U1dmRETXNUN05X?=
 =?utf-8?B?QUx4YUZ0ZkFrNWQyUFJlbVBNcE16NGpxL2NlT2NNOWIwekxDSlhYbjdVd1VY?=
 =?utf-8?B?a25GS0ppbmpjTG9LMU9JOXVyT2x5VVZ5M2NveTBwOGlKZ0NNSkNnNnl3RzNp?=
 =?utf-8?B?UVE9PQ==?=
Content-ID: <E022A1BC942E374A82A7EE6134A76320@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df6c471-bf77-4533-555b-08dbd47a8a82
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 10:18:17.7469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6XbxmxzmgTiIAH3SZSBJcphKcgNy9gpyh1r+yeW9vXn7z2xIm4q4xVPOiQz9yjIwWE3B0oWwPmvntLXFniuczA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7584
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231024_031825_859233_57925159 
X-CRM114-Status: GOOD (  20.93  )
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

On Fri, 2023-10-20 at 18:12 +0300, Kirill A. Shutemov wrote:
> To prepare for the addition of support for MADT wakeup structure version
> 1, it is necessary to provide more appropriate names for the fields in
> the structure.
> 
> The field 'mailbox_version' renamed as 'version'. This field signifies
> the version of the structure and the related protocols, rather than the
> version of the mailbox. This field has not been utilized in the code
> thus far.
> 
> The field 'base_address' renamed as 'mailbox_address' to clarify the
> kind of address it represents. In version 1, the structure includes the
> reset vector address. Clear and distinct naming helps to prevent any
> confusion.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/kernel/acpi/madt_wakeup.c | 4 ++--
>  include/acpi/actbl2.h              | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
> index 9bbe829737e7..ad170def2367 100644
> --- a/arch/x86/kernel/acpi/madt_wakeup.c
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -79,7 +79,7 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
>  
>  	acpi_table_print_madt_entry(&header->common);
>  
> -	acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
> +	acpi_mp_wake_mailbox_paddr = mp_wake->mailbox_address;
>  
>  	cpu_hotplug_disable_offlining();
>  
> @@ -98,7 +98,7 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
>  	 *
>  	 * This is Linux-specific protocol and not reflected in ACPI spec.
>  	 */
> -	mp_wake->base_address = 0;
> +	mp_wake->mailbox_address = 0;
>  
>  	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
>  
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 3751ae69432f..23b4cfb640fc 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -1109,9 +1109,9 @@ struct acpi_madt_generic_translator {
>  
>  struct acpi_madt_multiproc_wakeup {
>  	struct acpi_subtable_header header;
> -	u16 mailbox_version;
> +	u16 version;
>  	u32 reserved;		/* reserved - must be zero */
> -	u64 base_address;
> +	u64 mailbox_address;
>  };
>  
>  #define ACPI_MULTIPROC_WAKEUP_MB_OS_SIZE        2032

Reviewed-by: Kai Huang <kai.huang@intel.com>

Nit:

Looks this patch can be moved to an earlier place because IMHO the justification
you provided in the changelog also makes sense even w/o the new wake up
structure version.  Anyway up to you.
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B445C5AD4C
	for <kexec@archiver.kernel.org>; Tue, 21 Nov 2023 02:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MWEK4BlBogtVWXh5k3vSy281JPPzePUTHBUpB+dXrDc=; b=zv0PKJnaGaAki8
	lMtszjcbjm9jPw/ndvuQrfewTe0CgkdkAtNcAvtUI6DuMwcBxn8CIowAvY2EeMlGh9c/m3kMEdzBy
	ZJSFhY1/ZhzM8qgbUAczjS0zDFeoSD3BrU+gd8qDCUdoBEKiUEwl0iR5XXJiZIlDl4boZ+lujIDL2
	tRAi/2BbuCDVftKB6w+nf3bY5jeN/XHSxyAK6/5nkW3EowbSySLQDoy5kpuxezJxCJReuHwgma/CC
	i8SGncJCU4padUVDEd7TbfhFQFkWIHddQdYH7c9+xObDENFJmM5Z8+uzg6mh9qKGD00Ha+tsc4j+3
	r8kdgkZ2LnWX+BlpVapw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5GBx-00FOVu-2A;
	Tue, 21 Nov 2023 02:08:45 +0000
Received: from mgamail.intel.com ([192.198.163.7])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5GBu-00FOV3-2k
	for kexec@lists.infradead.org;
	Tue, 21 Nov 2023 02:08:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700532523; x=1732068523;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mmn7eVYcOlCt4CDAYYNp1OqyVyZ+afC4Hz9b2kcUQHE=;
  b=iLZQVO02+D6ZpAoE++AOu4msNTX5JMqsuGqpnIgGKcESpCU/cMSatzXm
   caoR6Ueeie8mgqYqn/RvXeYB0kFfjNym/r3Fcmdi+g+//cE0HOkXb4iQE
   xOt2nOJ3bDy6+wYzpr1AOcQe7Vdqu45g90O4na1uEBqXA9i67mLY2sVjC
   UrnYd+L9BH1SiAd4rjSc9idM9J7X8DADDvVj5T0v0xgpy5rd2VFrPW71M
   JZF426A3k2LAy+o85lXRs2EeTR3X9Ca6i6r4+CndY9vE4BmDiWqb90vvb
   0zjaJIZu4aX0d/NOg0E5zzG/PDXo5S0rpzj5hnftqGgtl+tY5YGrb0Qcm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="13294385"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="13294385"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 18:08:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="1097903550"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="1097903550"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 18:08:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 18:08:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 18:08:41 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 18:08:41 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 18:08:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOyvc5Yvb8A4fSsMTCXIjr5imyNolC6pmPr+IZ4ycI2g+l9snkmgDmo3OLGAf19s8tGzzkUh5teTN5QA1KElV02I3QYujXT+BJwx8v7sWej28y/Yd6uYE58vFYzrtCiunk4dRgY8X+DrkFO6IzsJSnuvqXPEklIrTr628NU+PtubOlgS2OqkFKouXKz8AtvvHo1wt4XfPg9TT+YG9ShYYe2ZgmCC/rAJHwbvpPraxEjWAYozhs9CT52umNqbnkLGFSa/EKB/CoJ7FjKWtnL9uxZ/RsB4Y952AV0wiQr5y2x27RgDbZNABI/MR+uIp/YFe4Y6VevuPPPp56ONB6/kSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmn7eVYcOlCt4CDAYYNp1OqyVyZ+afC4Hz9b2kcUQHE=;
 b=FZ4ZR6zvGUke/S9S67Je0/1Ieocj3N/pqq7zGRpyTlZT7cjJxxGtQv6j0lDhNYcVIgD0xOacszqM08jB8C94Mcf57+pueh8Smhw/1PoFDGH8m3V4Bozs7aYbpvReDe6Ghx4von6z4o0/RAIyqJxKB63bBSlu3z3VaCTY58hsyXU4RxvoipE2skl7ZAXKGqnTPQ/7noYXAVSGMo92VBmK5iw+Hc5DUoGWAFEvRhOfP3LvaR7D3GI8lewahg6wHodbcRONsCBrkfgC22RZqMfvaBksKMUq8ZWj+0X0LYy0/xZZXQG5vzzbkZMNQIJbsbf9+QsTUBopO1J1uR3K0u8cyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH0PR11MB5016.namprd11.prod.outlook.com (2603:10b6:510:32::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 02:08:39 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 02:08:39 +0000
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
Subject: Re: [PATCHv3 02/14] x86/apic: Mark acpi_mp_wake_* variables as
 __ro_after_init
Thread-Topic: [PATCHv3 02/14] x86/apic: Mark acpi_mp_wake_* variables as
 __ro_after_init
Thread-Index: AQHaF7t2IRXWZKiMDUC1ORBuEcgjNLCED82A
Date: Tue, 21 Nov 2023 02:08:39 +0000
Message-ID: <d2b8e1667c9f79da4b600ad36d1c9bd53353e7ab.camel@intel.com>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
	 <20231115120044.8034-3-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231115120044.8034-3-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH0PR11MB5016:EE_
x-ms-office365-filtering-correlation-id: b446a0d9-085a-4829-95b2-08dbea36c6fb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +EyoO2RALZUT5xvrGLX8g3RvY72TtU03jw7tWdPDpmm0OrjOIo+h1m92zWD+KnNZoRdWPEB5dL5scI9tvKBLOGqNy1EfUXazGiLkt8f2XsUtn0VTTr6A/CJj4z3jLMLrgcf86ABAgJfSwsdSaApt6ZMM2l0ebc0rf2G9bMyMLv/f/xlgFJukXAHbTsBL7IcWJjnWb6351xNumZwzNQVAQrEl+u3xBVw31r9vNZUZF0oUG89S59SSoiQuccSz/TdTzBIt3LU38wkC5w25DpqTj+uisoIrUIKbLzmEjI6nqq0IDdwvPROpNt6hQy5Q0ltkOnwViuZ7lew7u9FQqjQljMmmuKwza138fvUpGGjsy0KnSspY79DjW3075uO2R+onNFGSu7NAHq0eNAhSeDKfKsjnpYjatOYGAVJpYONluYUqfHNyXg9Z7XDl/MZ/o2v2heIHyb8sAOQy/w/pYPkJbkbkCPBMCbSkzhLEmUGwIdqda0WwKZQr7FHUSfUgrsQ30dIOHE4vqeQK1NYePXG4mAjSk2Qec7zLTSMNqpHh1Qln7jOfiE6o4N+LE4TzJ5GG55Ly1DUanZnFR6S2NRvh1tZ51Pp7Gn1j19RvSYRjuy77/Muq4guTybKY1tWT8SLm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(36756003)(86362001)(5660300002)(7416002)(4001150100001)(2906002)(38070700009)(6512007)(26005)(82960400001)(2616005)(478600001)(71200400001)(83380400001)(122000001)(6486002)(6506007)(38100700002)(76116006)(91956017)(316002)(4326008)(110136005)(8676002)(8936002)(66556008)(66476007)(66446008)(64756008)(66946007)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkdNNUo2V1FnSmZHV2NGS21tT2hUUFBpcUN5Y084aFJWb3IrMjVYVnVNMXo4?=
 =?utf-8?B?cUttR3BUdjJKbjJIS1hOZmtrb3c2eVRDaG94OGU5N2tudnF3eWJxWlNMeU5X?=
 =?utf-8?B?OVpuWjJINDFJbDhST2crN1prdHlhU1UrMnd6MTNqMW1MSjlrZ3hpVDBBSEtl?=
 =?utf-8?B?MmJHWUVuUTFwV3VWOG43di9qYlh6azMzSm10UXZvN0k1T3lJbWRzTk1zVHJ6?=
 =?utf-8?B?TVpXWDJ6YVZYaVBZbThQLzVPMnUvb3g5aFBXUWdXMEhiRmNTTTcwUmtMYzFy?=
 =?utf-8?B?MXdsa0JLZVZrODJCTEhtYzBkU1RiVitOOXpnMTNUSG4yWUU2dFdnMjhpWWs5?=
 =?utf-8?B?NGJSK1duWlRrM2tjZG5WZUpKWEtPZno3cWFlSURQSktVcjBjN1ZQTDVhbG5k?=
 =?utf-8?B?cmViL04rNzJCMGVlNmtqbnJ0VHZxb2NOWVYzV1B0WU9Rc0h6Nlo1WkthRU9X?=
 =?utf-8?B?N0tLaXlPSExraklFTWE1czF1bmZwSlJQK1NaR0pNcWdvQVhxWDZGVVF1U285?=
 =?utf-8?B?VXRsT2M4RVAzUzNUMk1QSDR1T2xXL3VDUERwLzlMN29qSS9BVzVhcXhkVFZu?=
 =?utf-8?B?ODBPQm5xa0krd0tMNjhjMk1nL0lFdWN2OTY5ckZ3Y1BRRHdxNi81bzA1bGht?=
 =?utf-8?B?NXgwekxEY1VEUUVhWUhKRVJEakF1WmZ5OHNxWVlBd1FFdzNNREJGU1V0RUNh?=
 =?utf-8?B?MUNLQWI5bmgxdXU0UzVIdU9LcGp3RVYwT3ZCRUwyYzlkSlJHaGphV1JRTUE0?=
 =?utf-8?B?bkdST2tGZEN6Uzl0dXhuckRmOWVzUTl1eXA1R0w4SjUvaklyall1bitqUXJ3?=
 =?utf-8?B?OVZpU0dtaWU4V0x6ZmRwNXg0KzlqR3JqVG9zRnp0U2JFSzhCbytDSWtkdnI3?=
 =?utf-8?B?RHE0WjVJcEd2dXNmUjJRYmVXeGFzZkhvc0tjY0doN1JqMWgrOXZESGQxT3Ns?=
 =?utf-8?B?bnpZekVabFdnZDYzWXE5VldJTmZIcTNTU2pjT2hRV1B6VHd0SXJhM3VXeUto?=
 =?utf-8?B?QWpBS3MwYW9IL2ZjbFZsUjJTVFp2Z21qVEhyZ3NpaFlXLzRtNGlPMzQ4Lytw?=
 =?utf-8?B?ZG5QOWxDcGJJb3JaTHllRkFDYmF1NWRnYURsZGp0a215bmNXYUZMYUlWSlds?=
 =?utf-8?B?QndNTVFnOEdDVDdUazhmYzNDNU0wWHhQZnZYRXNuTEJ3YjBjemdqd3dJYlhQ?=
 =?utf-8?B?bS92RG1ZZDZNaVVub0dLbDdTYkI1bjZBdGZBQ3VGQ0FMZFJGeDQ5U0V1Vm1s?=
 =?utf-8?B?SXdRWjlWc1JQNTFnWmRIcXNPRG9jRFhDa0RHNHNqUkRCZG5HdWRmZEJheXA5?=
 =?utf-8?B?L2MycStoWVRWVm1ETGkyc21CZXd6RVBQOGhVcGF0akEyK3pxNTBSTURtN0NQ?=
 =?utf-8?B?MEk5QzRsV1dmanlKbFFXMGhzcUNDdWpERUhUamtjTWNpYUtBUCsxVlp1K3VZ?=
 =?utf-8?B?cFliYVdYQ0J4bnZFMVNUVlhaQjdmTjM0aVh0TDVXZXBSNlBQRm5zRmwwZlZL?=
 =?utf-8?B?R1dwb1B2RS9xVzI4K25UbFB6QkFkS01ZNkF5OS9xNFZ4R2dMSWVIdll0azVC?=
 =?utf-8?B?UmlzOEtkc3JoQjc1UjRtZ0NhVWtlWU8zaUU5ZlJLY1l6dkx4c2pCV1I1U0V1?=
 =?utf-8?B?QjZtVVhrdnd2SWUrc2JxbHExbGtWMHB4VVpIdDk2OTJkSzQzT1VvbExiSzlC?=
 =?utf-8?B?YlUrSS9VRHMzNXNJSzJmTXovSlJXNUxLc2ZncGFvVWMxRmh4TjVlNzlMcU9I?=
 =?utf-8?B?NmpRdTJzTGhTaVpZV1RSRlhGcnI5Tm8vd3hYcEY3UEV4dnpid2NVd3Ivakxu?=
 =?utf-8?B?RWNKdEtreUlFK1ZvcisrczJ0VndINHk2UEVpMEJDbzhFTmFrS0tYTklwR3Bs?=
 =?utf-8?B?Rk9qMWFrWERxTFR6aVd3VkVER01VT0VvcFZrL1h5dUVvQ2dIeG1DSDZHbTZp?=
 =?utf-8?B?M1h4emwrZWsvWG1ZcThBKzR2TWZkZVlWbnNrZTJNT1YvU3dQNjBNbTRTMVAw?=
 =?utf-8?B?V3lPTlJ6ZmVBOERPalZJRUR2MnlvNFZTR2hTVUlNcldENHJXQmdYR0NsdHFI?=
 =?utf-8?B?U1B1OXd1dS8xdmN4MnpZYVMwQWFFMXlodHJmdEpFWGljWkZmdStDTjZTcXZB?=
 =?utf-8?B?cE9WNXlMckUxemEwblNjYi9zNjFJWll6TlVxRjk2RGh1c2NScXp4N0lTTkhw?=
 =?utf-8?B?cmc9PQ==?=
Content-ID: <4E2E81EA753FBD4DAAFC4395DC4CFF34@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b446a0d9-085a-4829-95b2-08dbea36c6fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 02:08:39.0486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M2ilQB9YP/NurGVD33ZJxXeLxzvMQ99oyVCZf2YSUbs9OF4pqkxC3jPyBDDliae6VvbgR4ILK7PZ0UEaXmDDHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5016
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_180842_908502_72374F45 
X-CRM114-Status: GOOD (  13.22  )
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

On Wed, 2023-11-15 at 15:00 +0300, Kirill A. Shutemov wrote:
> acpi_mp_wake_mailbox_paddr and acpi_mp_wake_mailbox initialized once
> during ACPI MADT init and never changed.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/kernel/acpi/madt_wakeup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
> index f4be492b7e4c..38ffd4524e44 100644
> --- a/arch/x86/kernel/acpi/madt_wakeup.c
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -5,10 +5,10 @@
>  #include <asm/processor.h>
>  
>  /* Physical address of the Multiprocessor Wakeup Structure mailbox */
> -static u64 acpi_mp_wake_mailbox_paddr;
> +static u64 acpi_mp_wake_mailbox_paddr __ro_after_init;
>  
>  /* Virtual address of the Multiprocessor Wakeup Structure mailbox */
> -static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
> +static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox __ro_after_init;
>  
>  static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
>  {

Reviewed-by: Kai Huang <kai.huang@intel.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

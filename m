Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D25AC47073
	for <kexec@archiver.kernel.org>; Mon,  8 Jan 2024 03:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Tef4PU6+9Hwn9w7kses7AxEobkj/DMlVw88FL0Nb3IQ=; b=Z+/HH5vQ+hpPKf
	SaTp7H7i7JOU8kq7hkdQJzKnQzmag5IWwbgA0oCBqkSh456ua4oz5hSeCNZl6AJoiSGtkvzMA2UfV
	PSYeBQ14cpHycTZMzrfiY5PdzfrkYUEujj1whh/NPHrsAY7qtB9F0X2GkDpv/0v8mpZGgW9qDbW/r
	R46vbC5FJqpRMSmpWcI6ZDMKKGeUdzId1IpHYVZaupmhHoNU9U7yGAQMH90V+KQhbeLcxx4cf4omd
	tE7XiID4JK8Ptf407n58uaYmI5dGkbCQaMd3oofsbdnaFb3q8ahVZe9XeSNmenFzBGYcBQO1pSkom
	GQHL2/NdOzby1CfZMU0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rMg4u-003t6b-0y;
	Mon, 08 Jan 2024 03:13:28 +0000
Received: from mgamail.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rMg4r-003t5b-0f
	for kexec@lists.infradead.org;
	Mon, 08 Jan 2024 03:13:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704683605; x=1736219605;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=p+I233PhA1LU4sJBoibk3bkd7BPUU41xKkXjKdRvEdw=;
  b=FQ6uQdwI9hpxabUNnRqd+QQRj3q3O4G1U6KKW/Z/TIrsCJ2+QRQOo3PE
   rYz7YZgVTwUOkKj6otB6XZt4qC7SQr2CDIY7E/cNYCkSCAhursNXjC5jK
   ysdBi7zV6u+fcibY07rXlfdW1rZf0k1pE/xFG3eGoPSvbb21guPbwRqs6
   OC2R1pcJmtnThQNxfFdzprmOH0Xxftg3yp2ahV4LoxjDIfvO2ambZOrvp
   j9rTjJBc1g7rsKHdQJ7O7XoREx5eaW2Ci1GdzdYO7eYvlr0RjL12oA8NV
   1p56dj13BkHBZxLHGKz+QlN6QcGIQXsMPZiVE3iEEI5rzxBcNn++l1jUz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="394953250"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="394953250"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 19:13:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="23033341"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2024 19:13:16 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Jan 2024 19:13:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Jan 2024 19:13:09 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Jan 2024 19:13:09 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Jan 2024 19:13:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiMpQC7KzyxeN8V6/bw+05IlMMqtks+56tzqskwHQ9U/zv6KoMuT7LAS7nXjbgqib/YJx5jLedOxK4GR9onWlZUaCC7RglyN5nvuHqOSbqqL7oL1uXpNGsww5pGRIqhEGjZYTqUxkP8Dj0gU8G5DwnqFWuW+laSAMU9T6cty91Nq7BhmEQXMnBOuRR0RF19Zsg9zSRR7amaRSCu6hdO8u7sLPrHVF8+5Id29tkPRTDIq4WnjeCQ+UJYnsWu1f2bEkTVvNMSS90jQlrDQ6myCml1sICQ3FJVBG2CsfAXuD5wqF1eSAX7KghUa5sNNYMWtYNBVLsKCHZLD9VkQ6keavw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+I233PhA1LU4sJBoibk3bkd7BPUU41xKkXjKdRvEdw=;
 b=BmMJBONMo5EEisaDwNRKj1SgPaGMN6Ik/eNjYHykgbsbDML3sv3y8XL3uE5OtBcLzumgF82B4NDb/WSgdzIYWF2JV9OzyxGdpjKrL37idBRm8iUpI71Ep0Ybibgt0whmqV58uUFzy5PApS459kTjHYw2qL2VtGxmvCwnTUi4Go9KVi9OhK2n3PGlS6iUbYl+qT2XRvLloXsmyc0qn2D5QJrP1NU6KCnTM6XFfWdeLSOvk/pvNPp9yqKpGjkSHlMpGaY2rFq7vwdFto0wvsp2RXVfc+WQs6FULPwJnMUSwp9/Ttec3JWZSsrucBOTgKY14iMuBoJBehNm7OLs2qU73A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CO1PR11MB5025.namprd11.prod.outlook.com (2603:10b6:303:9e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 03:13:07 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ca1e:db:ee01:887]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ca1e:db:ee01:887%5]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 03:13:06 +0000
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
Subject: Re: [PATCHv5 15/16] x86/mm: Introduce kernel_ident_mapping_free()
Thread-Topic: [PATCHv5 15/16] x86/mm: Introduce kernel_ident_mapping_free()
Thread-Index: AQHaNTH0QWBZ51600E6mdH8oHBHhWbDPVskA
Date: Mon, 8 Jan 2024 03:13:06 +0000
Message-ID: <ba8265977a4b30f48b6b33fb135b714d5ada2a52.camel@intel.com>
References: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
	 <20231222235209.32143-16-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231222235209.32143-16-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.50.2 (3.50.2-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CO1PR11MB5025:EE_
x-ms-office365-filtering-correlation-id: 082e49c4-79ea-4ef6-bdc9-08dc0ff7bbc2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h4slw/bWAY+znazMMyp/+Qht4M/qGTs8IPU5axLyARkhEThVbmSLTB+jU7CG55xJVro4yP8CFfq6+icP74Vw/lUQFJ/aM9WCaR1q5PMmJ8/xuumF4NPzTA3vBTDvIEUZAQrZtytzQdqV1ZALrh1/H7B9IUlPnU7dNPf4NzwyQqKcoBwex2QIam2oJy1KV5wkvbV0oCM8pO6UqIWABx2ie1uD/weY72SHMbu1LFx7WMb3eumxojKKJd2dQfLYEOLVvVM+WPKAi50Rl+YuYRopTz4uVyYTi1bU+4kRZu2Lhd7qqqJdXctfXShPJJDH9S2XDx6jpMLwlPStUgoIMc5ovymhCwgXK1CUqnGyqn5wPj7dNM0udJZuR3w5Bd/0cxXAixCTFCfRZG8dug3CuwKSmfB3+LK0SUPSNa7esyKBft5BueX80mYFLwhOhPE7HVxUry/AuVPMyyphFFrHVmvitlvKdyH2XnxIZ2HAq5EKNshHGlPOqorAqMMSWaPCLJO8009JFrU4pK91POZr4tk17qKCnTKR/uv7rVk2ho1VM1hk7FXqb0QsRjqNxNwIBn1t8riUScR0+hBFKpuBDUz3vaR4dYvWxj98tALRj0FPQvy015hv4i4qeAWfM127N3nL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82960400001)(478600001)(122000001)(38100700002)(6512007)(6506007)(26005)(2616005)(8676002)(8936002)(110136005)(7416002)(54906003)(5660300002)(4001150100001)(2906002)(316002)(86362001)(4326008)(38070700009)(66556008)(66476007)(66446008)(64756008)(71200400001)(91956017)(36756003)(66946007)(76116006)(41300700001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SU0xMEg3N3pkSWxLb0JzN1BCYnJHRWt0MGxZZFFqZnphNXJpeTljZmtVQmFU?=
 =?utf-8?B?WXdPaW1YbXZUK3FHSytxNnZPZzN4UkQwd0FSNHpZZmhDSm5tRkFkbU91R2N4?=
 =?utf-8?B?b01BK3VBNTN4Sm5xNHgzM0sxVFVhZGFuYlI4S0xCcE9ERjZNOGh6OUhFUmda?=
 =?utf-8?B?bi9yWDlDMmdpSjF0ZE9WN2pVU05kSXZoYmJ0UXE3cWczaDZrcUlReFhqN3lj?=
 =?utf-8?B?UmVZL09ZYXFRUW5tOVp4TytmeXlyRUFFVlBSTTJQNXV3ZGVoQU4zOW94N0tO?=
 =?utf-8?B?M05Cakcxd0JleitPSG9VOE95TG1IMjJLQkJybTRzUC9HRVJLdG5MeGhXVXA0?=
 =?utf-8?B?cWdJbVpIbXltcHQyQnFkbXhBSHhpNmJiTWcwaTBUeEVsSEk2MDdPMlJ1V2Ni?=
 =?utf-8?B?SjF0RmNsZmc4bDBsTWh1ZDFPdDZmNUo1K3dkQVRkRFhEQWRwd0lwTXVFT3pp?=
 =?utf-8?B?emhLL0dBQm1zMlQvdTlhNUZSR0RKMDR4OVNEd01TVy9zU1RINXJDN2lJckpF?=
 =?utf-8?B?MjlKWXdNMkNRaWU3RlJad1I3SHNKQk81Si9yRlYyM1E5dXJMSm9uZFBHV1U2?=
 =?utf-8?B?NnFsVUkvWTVFKzVobXJlcHNvK3cyM250cWh6S0d3elpmMU1FcGlPdTRwbzQ3?=
 =?utf-8?B?RDlvbGhvaWlQbUxjMFh4amVCd29mR255c3hYamphWU5hUVpubXF1MGVPRTBr?=
 =?utf-8?B?RnpZREx5NXdtQlorbU43d0MyQTAwbXNDY252ajducGZub2JOWTN1V0tYVVVm?=
 =?utf-8?B?TnNSRDRwWjM3S2YrdE8wZW5tMUhtODRVeUdCbFFSbEYvMHdrTlpKWHJaMWZy?=
 =?utf-8?B?WjM2V0tPNFB6NFM5K2dGUXY5RmRxOFAxT3pZUFNHS05PZEh5SG9mOG03ejVw?=
 =?utf-8?B?aUVkT2pMR2JvQVdDTmc0eUdOK1dwVXRsWHRWUWJVdXl2QlphZk5rZzNpNHBR?=
 =?utf-8?B?SkNUdFllSC8yYitiUEw1ZzZIQTZYU2thcXc1cDMvbkZaZUdxK3h6dFhWZ3ow?=
 =?utf-8?B?ZkM5ejVXYkVRR0FWd2xqQlFpTUpJVDNZU3ozNHJmVUJCTkoxUmt0RlJSZlZu?=
 =?utf-8?B?RHA2Ui9uN0ZQc1ViL3B3TjNBZEV5L2ZEYWVlRDFPUFUwdy8zMGhrTlp6YzZL?=
 =?utf-8?B?RDJOWDVZdnpFeHdVOFZ1eWsyaEFqMXRURWFWTjRocCtOcTlDWTFGWWZjVFlx?=
 =?utf-8?B?eHNEdm9kejRKS3RGa1hrZTNoSU9TdGQ2TTBXSGo0VThuK05YM2tOcHN3elZw?=
 =?utf-8?B?N0FLbUFGejdRR1gwMzhDMEZjcE43WGVURUdURkVnOTQ4MWxOZnYwQ1NRN2Rw?=
 =?utf-8?B?ZStvWEROYnJ1QkV0ZDRYdzkrVE8xS21mOTdKa1FwVHVMYTVNa1JnalF0UGNn?=
 =?utf-8?B?YVN3MmU0S1VUbU5ZUUoxY3hWazJuS2hsUkNYaFNqNkZOVHpsMlFZQVgrY0ZJ?=
 =?utf-8?B?a0dhTVpvRDNORlNma0RkdVhyNlBub2lDRWhWQXZUSTZobTJuckg0aVRnenhK?=
 =?utf-8?B?aEs4Ymc0RG54S2VCWVd2UXZiQi9tZHlpamtHZGcxTkRsUkZrWm5tZXVnTksx?=
 =?utf-8?B?ZW42dld2VEh6dlBweC9TYXVrZUF0TlByMjF1M09JNDZYQm14QWNUTHpsYXpM?=
 =?utf-8?B?Q3M2d3FtUitOMmh6TElTN29xVisycXNoRStYOG1zSU9jK0lCeFY1MWpsMGw4?=
 =?utf-8?B?Y2lEQTB0ZURqNHlnTWRVWE5WaVFGZXkxS0dPVzVseUt3c1N1NWdzeE5MZFRy?=
 =?utf-8?B?MWQxR2RFQXp4eW1tRjdWUE15cmlBNDNuNkpFd0JMejZCYldmaUkxR1lhQTFj?=
 =?utf-8?B?QTVHTmtHbXhuanNDaVUrdEh0K2c1c1FLbWFkbEpYRHlDYStucnkzRGtGTjVz?=
 =?utf-8?B?S2hEUkVIV2J3YlU1WTBHQzg5dGdWRExtVCs0R3ZWOEtzRTU5STFSRzgyTEwr?=
 =?utf-8?B?TEJmZ3dhcVdpTzM3dUlLTVUrSFdua0Jsd3Z2cC81UFhlbUhrNEI4Um1mMDMx?=
 =?utf-8?B?UkkzRXBWZmk2YXhLOEFoaTFwSEtwaEppVFZoYnVCUm5haURKT1BjN1g2Z21h?=
 =?utf-8?B?MUZXdlI2Tm8xRGg5TmpRMGV3WWZWdlRHZVEyVU5RV3pEOTBYbGpRMDJndTBH?=
 =?utf-8?B?Um5XdW5pazh5ZDRodkg0Tk9qMCsvdmd2dFJNRXVhMHBNQmY3MEpSalBmcThS?=
 =?utf-8?B?ZUE9PQ==?=
Content-ID: <9698360C291F9241B61026CA714DBDAA@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082e49c4-79ea-4ef6-bdc9-08dc0ff7bbc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 03:13:06.0979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1nWuN/dMqw/S8M83gtL9Ua/q+/GKmcLo3ppKQ5ook2PttBMruxh40Kk7DkdxMYRpJ44Sp7kQjUQocOSXFe3ENw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5025
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240107_191325_260177_68F93F08 
X-CRM114-Status: GOOD (  19.75  )
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

On Sat, 2023-12-23 at 02:52 +0300, Kirill A. Shutemov wrote:
> The helper complements kernel_ident_mapping_init(): it frees the
> identity mapping that was previously allocated. It will be used in the
> error path to free a partially allocated mapping or if the mapping is no
> longer needed.
> 
> The caller provides a struct x86_mapping_info with the free_pgd_page()
> callback hooked up and the pgd_t to free.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/include/asm/init.h |  3 ++
>  arch/x86/mm/ident_map.c     | 73 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 76 insertions(+)
> 
> diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
> index cc9ccf61b6bd..14d72727d7ee 100644
> --- a/arch/x86/include/asm/init.h
> +++ b/arch/x86/include/asm/init.h
> @@ -6,6 +6,7 @@
>  
>  struct x86_mapping_info {
>  	void *(*alloc_pgt_page)(void *); /* allocate buf for page table */
> +	void (*free_pgt_page)(void *, void *); /* free buf for page table */
>  	void *context;			 /* context for alloc_pgt_page */
>  	unsigned long page_flag;	 /* page flag for PMD or PUD entry */
>  	unsigned long offset;		 /* ident mapping offset */
> @@ -16,4 +17,6 @@ struct x86_mapping_info {
>  int kernel_ident_mapping_init(struct x86_mapping_info *info, pgd_t *pgd_page,
>  				unsigned long pstart, unsigned long pend);
>  
> +void kernel_ident_mapping_free(struct x86_mapping_info *info, pgd_t *pgd);

Maybe range-based free function can provide more flexibility (e.g., you can
directly call the free function to cleanup in kernel_ident_mapping_init()
internally when something goes wrong), but I guess this is sufficient for
current use case (and perhaps the majority use cases).

Reviewed-by: Kai Huang <kai.huang@intel.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

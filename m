Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB8DCD11DF
	for <kexec@archiver.kernel.org>; Tue, 26 Mar 2024 10:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I6FmppWkKBCDYzOsy6QxT47SB07dQlICyA1k6+u+ZHs=; b=IuC7nN/8bRCEJg
	OmlExtbyOBh0OS8xZa+KHlUxDaM9/MqYLC642DkX2LvieB2wHgmjHEYxlskhO2ZltA4FynZ1d83um
	eiiNeWLH5ALujAXzu8etaYo+mbiWIpZ3kzZZVihOKhmvP2AaaL00aYABECVJMSl5RlKsxd01nyriR
	t8/KB1+sQUmUzxv6xy72PTFH4CQi55Ym4lE7TwgXhmdBODZSgYUUMRoKwzAr6r26CULakz6umUGsi
	KHor0XFIc/FrUQHZHCYQYXcQnLeFnWyxgFhlEfsqtWv6/6OZPIf+F7CKdpkNLMpG0hglqaDmWRHz6
	zddlN+2BmnaXazmJhP0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp45R-00000004439-0Ec0;
	Tue, 26 Mar 2024 10:31:21 +0000
Received: from mgamail.intel.com ([192.198.163.19])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp45N-0000000441W-2VYd
	for kexec@lists.infradead.org;
	Tue, 26 Mar 2024 10:31:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711449078; x=1742985078;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TSXTiVjTn3Fpa0olL6u7vCLAnOh8aQ3QrCsKdv8ovCg=;
  b=bZAKDEu3RQghCYWgoqaP0uS0vCM/74i2vtOgkwqQ9VIpg1SR1Oq7BGn2
   XM2heWtHN8yK0Lrs3kxeH1cbVXVmGI8SGS9iqmr8xJQZTPdW/ParJYD3D
   TNId7XrG1m0OcJxMPaEXTdA5qoGar6Ds8wviEIx41Jqv5MxkdzcD8edeJ
   RF93rPKjbQ0+kOIxuAVdNbGs362uPwtXH5igI2AdFxCxfQc+O7r5iomXe
   jwjih0hFhB1zo+YxC3Qy+pQy8jqJOqjx4JJwtNpR8naFXky1+yPjwaYhJ
   wlHcc6+gPDLX9l+L45L3fBf6YqmD5258ed+GSObxi6A2lWcrjRE9dhW+H
   A==;
X-CSE-ConnectionGUID: 3hRXw4ILTKOo6gIdJfA9Jw==
X-CSE-MsgGUID: fudtNyBJSEGN/QnceLDbZA==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6356050"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6356050"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 03:31:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="15893977"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2024 03:31:17 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 03:31:16 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 03:31:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Mar 2024 03:31:16 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 03:31:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtrepTemrTwVCtK/wgqQBLJ/YH537VWCCqUlmWoc9WYEpcCWyA4McHn8qNdwS6od+5dwMJ2FV3FSr7IyJXY1ue5jPVrqnTHwNQSKnWWdecmHdB4QhVGRAHgwudkhYhyRj6mplx9dTT0/Kl7xhfKQZTCbswpF4WKcQcbEYsWj6ysfERJYlnVsLGbJ/JI+GB1I8h10oeKQyMBEwEBz/DLivV0sep3K0UT6SSJVfdDLLUA1g784i+Wrr25ndohrDe7JqSHzlD6ARkCJJ5TScDFopUzO+fDGQy7RXgOO6mDawuSPOwTPB6h+bL9dxylCe3lDOIJoViBaFBwAQRYxgJp82A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSXTiVjTn3Fpa0olL6u7vCLAnOh8aQ3QrCsKdv8ovCg=;
 b=RhsvGnkgvzS1y2FAyDmlE/ag/SpnVyRVRzlfcvRLJQM2EC1rc215VehVdioHv+Gt7GLatB5AdSC18CRWu+zOR232tqZceS59gbiihYt/l3eN3jN3YD0aXSYgyc4r5uD80CoXAYuqVwa35aIPYtan1oCrKgIhUYJSr4O0mcgkQsARojKebQ5U7U34VXl3RTnrnA3zfFBall2NbYBMOtYttFfDpbsfh1xjvl2+g8N2Trn2a9khj1cDonpZoNUt/yXJYIEZdnD5B5e36JqgzHNL4idJoqt8n/TwqIU8cMmSvCgaqDEY1EP89DXi3BuWNWHpy+03WSGdn0v0n04dLOIp9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB5279.namprd11.prod.outlook.com (2603:10b6:5:38a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 10:31:14 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 10:31:14 +0000
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
Subject: Re: [PATCHv9 10/17] x86/tdx: Convert shared memory back to private on
 kexec
Thread-Topic: [PATCHv9 10/17] x86/tdx: Convert shared memory back to private
 on kexec
Thread-Index: AQHafqDi8hrQKUdIqk6I9OvheiGwgrFJ1DAA
Date: Tue, 26 Mar 2024 10:31:14 +0000
Message-ID: <44c129d5088c26cf48dd67046de6a2f2babe9978.camel@intel.com>
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
	 <20240325103911.2651793-11-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240325103911.2651793-11-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB5279:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: whwaCGRtIWQw+ba/vLudvm4dPdxKntAj1AxZuLfJT688LhKfDTvU/Uz8pdSW4wPlf/4UDJLn3nrG/BoLAUc3X3Bn6sCdHgjaMCmdNEdXuHhgcSRjUgIomCp6UYmTENzsrVGXwH4l7ZnfPOX+tql6KmmWiN5kGFwVASAxBFUmzmGyUXnR4rwmi4MDBPiOJNLJwX/MBi94L3YugCji8WEsTpsxALUZ0ZMOnwjJpooypiQYC+sGGDNeVi1rPi2EYL/3fDxjf2RpxozpLnCsYv7GBRBVgWb5sV+FmgUdNmvNRhWpbBQV8D97BpebVOp4KWww6XKotg+jqFazKvv0+WXCV8I3nDusenYUCAa7jxnGwzmXMsoVp2R2kZksusHJvuLLIdNjWueZoGF7XzrHhN0PS0pEUTa0LpdFVT06363WKhPaWBBmBvokUVP4qtHO/SEquDRVj0lAqbo5WBXwV2W5Dh2AhziM5poPyQWQmftO2a5M8AhCeqzJdcq8USxblhWYa1VsLkhXUnTUo1NUAVvkNk8CU+bpNi3V2G0KpxcalqccBVD1W1ajUTzdICiL8nWneLxuaR/EBMoSYqNDmIuzd8H8ZFyZp0c+9CRu7ZYif5cQZ7djoPf8lly13TCa6OkVvA4z0qmf1pSR3MgmKPFdbed6UIv/W827S5HZhzLGR2E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3cvbkIvR1pQOGN4WHhNOXFTbFJMY2NNYXpEbUdDaTFrMzRNaThDWml0Ykhk?=
 =?utf-8?B?QUxXY0phM1VjZzNCYmh3bVZkcDQ0dkFqV3lQZmd6Ym5jbGdWVTBSZ1VwMjNC?=
 =?utf-8?B?TFBvUzdLMjVNVjI2d1dNUGpEU3NRYmFpN2tKcEpHMnBvUmVHdlpkMWNsUGVZ?=
 =?utf-8?B?MEgxb1ZPVnk1M0JzaHltM3JsSW9UYzNXM0lOczVXZ0gxNVFGa2pvZGJkZEh6?=
 =?utf-8?B?TzAzSGRQenlyUHRuNUpkY2N6UVZqeldtS1VvdWdzNkVVVHFjTktLSlNmV1VZ?=
 =?utf-8?B?KytvMlNVaWFzYTMxZEFYWlc4RWl4aGNLQzBDdHBCWkZINk1JdnVreDBueEVB?=
 =?utf-8?B?NmUxZHNuMFVoUXBISlhqa2JBTUVHczBNUDZKbXN2YmRYYk1aZkthcityNVFw?=
 =?utf-8?B?RndaNGNDbTlTS2R6dmZpRnVtaVFteHRNRm12QU1CWXc0Zm93OVNSQmh0UE1r?=
 =?utf-8?B?RUtOYkZaYTI0UlZKcHBBdVBCUlVpV0tBTXc2bTdzdTlXdThJdFhuUEJEeTd0?=
 =?utf-8?B?NG1wMmlRdzkwQXliNHQ1QlJOYnRVODE5cGU5M1ZEUzczczhTRDE2VWtXOFZH?=
 =?utf-8?B?bnJXRVVmcVdBa3E1MVJvOThFM2VGWjVvbm0rQktOclpYUTFmM2xzakdmQWtT?=
 =?utf-8?B?ZTZ1ajBRSFFnNDNhZllXODZVaHBFenBWS3kvaERzOFZtS0Jmb2k1cjFpYUs3?=
 =?utf-8?B?Nnk1a09ZY2RlRHQ3bGQ0OFZWYnN2RkYrUDJ4L3AyQ2prQzFUTjZvWjNnQisr?=
 =?utf-8?B?T2RhNmxjT2ZKbUlhalRJNE1rTkg3TFpDeE05c2V6ZUx0RzNKekdXVnVHZm0y?=
 =?utf-8?B?dzdHVFgwMXpSQmJzWDRSUXBlSWJXUHp0QVF5V1FRQVhqeitONytkT0lZVlZJ?=
 =?utf-8?B?QVpiSGZtdFI2TTRWd2o0dktNU0FHWStmbDJkQnpvVlpYd09RaUw1c3Y4YXdr?=
 =?utf-8?B?aU5kQURlT1l4UzhxVFVEUjdEUUx1QXNTRzlGNnNkQ2M4TTVsZHBoRFRSUEl5?=
 =?utf-8?B?czAzYkZSQSsxTGR5SHhONWYvUXhOUWhOdU5zY1BoYWs0RGFPWjJtTWZOalRN?=
 =?utf-8?B?VWZaZkpzR2Fqc1JrQ09BS1BOb051V1lSMSs0QWFsRkVlaHJzYWd6QnROQXNI?=
 =?utf-8?B?Q25jUXBEMzRjejg1WXJHblFhb1Y1Y1czclBFT0tOclA2UWF0Z0JiUWNNOTZ1?=
 =?utf-8?B?VVAyMzhtVVBjSElaZnQ3T081OUhPVGpmN0VnanBDdmsvNXJUZEtaUkozbFE0?=
 =?utf-8?B?OUdyVlpNYlIwUFdabnBLZ2ljTENuMEhRRGNRMFJBdnpwTWRCMzViWVNhZWZ0?=
 =?utf-8?B?dVFCcDBhYnhQNFBpU2xrbmplcW1PeE1yV2NwQXBjWStnalNYcTFRM1p0eEFh?=
 =?utf-8?B?WmFRK1Y3L0MzVXRheWt5c1JqRmZ6c29KWVlJWGJFL2xmazhwQzVZZkhFODha?=
 =?utf-8?B?VnBmTXQ0TjVBWFlPbHNuS1VFcEhFYWJXdU5OMDhhREdldEI2RVVUNWQ1aXpi?=
 =?utf-8?B?S0cvR0h2QytHU01hd2VRWEU4WVUrb0NPSjIxRWZSRFR2N1JhT1ZsWjU4ZlZG?=
 =?utf-8?B?NjNRMm8zTGVMMFd0Q3E1cjRzQXFLTWxVeno1K2ptM3pHKzNGR2h1QjRBeG1S?=
 =?utf-8?B?aTlMVHBUeTFMdDVtNVFOSWZKd043RFVoc013S2ZQRWUzNWFUMHVnZGc5cGlT?=
 =?utf-8?B?M0dkSm1yTUViZkZXZlVheDRQUmpjUjZ4YXlnakdXWjBIQ2pjZnFCZ2xBdmNx?=
 =?utf-8?B?WU1JYS8xQXdrNi9pQ3ZTSTM1S05WL3BzRmxoNUdyV0xYN21qS21EcjRCZWhy?=
 =?utf-8?B?WERGankrLzFoUzBENFFOVlJUeHpyNXQ3ZlRiVEc2L0N1b2tVcDlNNmNRL0hR?=
 =?utf-8?B?cEtuNWtUNjg3aDZKUTNNcEExVXJ5UWtCdHZrNWdZc0pyR1Z1UERmWTJ3czNQ?=
 =?utf-8?B?dnFyYzgvRS9DVWU1eis4MDZ6cGE5VEk2YzZNd3F4RTZkSGhRa0RoM2xXd3FE?=
 =?utf-8?B?RE5UbzBYTXdHbmZFWWdpV3M3aVZBZXhDS05XaytZb2tOaEhKUkhCdEZBbWZq?=
 =?utf-8?B?REVFU0x4dElEdDZGYUlXWDRpaTlkUmQrWjRBbEdwR3g0YmxSYkU3S1poUWR5?=
 =?utf-8?B?eEg5c3U3anFlS2FxSWI0YVVNbnlsa1ozYjlLa3c4a20vQkt4cW1LMG1seG9r?=
 =?utf-8?B?OUE9PQ==?=
Content-ID: <ABE85E2A8DEB374BB6B8AF2B310EF1BB@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 233a3bba-bd0a-48bd-f4c9-08dc4d7fdd2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 10:31:14.6179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Clj1AzUABnWB8D0Ih8CqinJlnAolpx5yBFlWFzeHXY3BqdhZDO3MOMZkC3iMxvZzPAQjsiO7IDxQCjp6SfVukw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5279
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_033117_731476_28E4C349 
X-CRM114-Status: GOOD (  14.05  )
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

On Mon, 2024-03-25 at 12:39 +0200, Kirill A. Shutemov wrote:
> TDX guests allocate shared buffers to perform I/O. It is done by
> allocating pages normally from the buddy allocator and converting them
> to shared with set_memory_decrypted().
> 
> The second kernel has no idea what memory is converted this way. It only
> sees E820_TYPE_RAM.
> 
> Accessing shared memory via private mapping is fatal. It leads to
> unrecoverable TD exit.
> 
> On kexec walk direct mapping and convert all shared memory back to
> private. It makes all RAM private again and second kernel may use it
> normally.
> 
> The conversion occurs in two steps: stopping new conversions and
> unsharing all memory. In the case of normal kexec, the stopping of
> conversions takes place while scheduling is still functioning. This
> allows for waiting until any ongoing conversions are finished. The
> second step is carried out when all CPUs except one are inactive and
> interrupts are disabled. This prevents any conflicts with code that may
> access shared memory.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 

Reviewed-by: Kai Huang <kai.huang@intel.com>
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

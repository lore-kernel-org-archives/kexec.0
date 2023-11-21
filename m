Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8EEC61D85
	for <kexec@archiver.kernel.org>; Tue, 21 Nov 2023 02:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rnXJnw7jCDjNOkzNDSpWssboR1ExFnvJB/ln35heTA8=; b=PlLon+gqtap/4p
	SB3eV5ObunYqc+XQGa7XxO1ercJrsDBs3VTmGU4yOO19QfZene6DuxwJrSloTE7ORkUxfEPs43NnG
	YvQoIPxwfpUkYwefyv588xnfrmGPv1xFGqxJCIooJrG64juDW0xSGiI/4rrs1YhCw9WaOCtRHO+gr
	Yl26vkdugEZ8/aNOa+dUCTpmJ10kQkcntAZxPZ7RRvBoWvxcxK8IcEzXTVhwZg1m/yPOM+za31RRQ
	I5BsB/W/YWratPijJxPZc+b7RLjEvNDvzgTmK4srvpJO1f60rWDtZlBmod7jcJ1/VB12ZjIX/dD+H
	zAgKN6oIprLpRwWdTdxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5Gnj-00FTIS-2Q;
	Tue, 21 Nov 2023 02:47:47 +0000
Received: from mgamail.intel.com ([198.175.65.10])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5Gnf-00FTHJ-0Q
	for kexec@lists.infradead.org;
	Tue, 21 Nov 2023 02:47:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700534863; x=1732070863;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eZ0xRePgtTSluLO8A0/OUPfITFm2Qf1uhBeGi8kItWE=;
  b=OOe7DMKCIiga+zno3A/z/S/iiPVF6sroCMKwgDkHvODknVLNi1XqNm/h
   K/jKxJAhGeTmjjRr8/QBBlulnOj1K0t5snSnWWqmcWmYPNHhcpuNEVrHt
   PFsYj6NZKvkEykETePhx9py46Pv3YqjQ8P/Ian3vwt7v/Zr4pOYdhLy6K
   2TOyquAa3Kp9JL3NNgonRijU0NuWwg/Cvs1RkSNjDcECMiLZq+JYCr3fd
   mSa+SBPuSQh+nCMvAKPJ6SFxc0EOUepdvxTu7uTySDIzPx7c7MXadHDje
   xy5wa7cCoYISyNcWz2reLqCVeW+RlgR2lmD2R2rx62bK/zm7+0qWcj5La
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="4943255"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="4943255"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 18:47:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="1097918168"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="1097918168"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 18:47:37 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 18:47:37 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 18:47:37 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 18:47:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJkIy7A7WwN7f0noOLBDVQammQkidGI3B2FDoQSivTkewmPgiWmn7Z+MngT/XgIRzp+USqfVsMcBmL3FZj4CCamEJryW4a3lMJt9eWR95HVfFvsopn3oHEjbjnikNozkKcahUJbyc3gYhN1nyToKPiMikOhGrmOxKaA4nDeUEf5cibr7MIbvhRVRfjPd2IztVf24mOcDbmoa1wgh2zIH8yK465vkZfpjLzwpdki+3/TYsmk1z0dRAOJplOV2mdydA64mUxNbr9L9m7gJErbTfTK+E2tXFazdSXdaDoI0Qc/BgluRVisa8KxwCqxjYLW2ZFHXvN3fTDb4OQv78kH7pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZ0xRePgtTSluLO8A0/OUPfITFm2Qf1uhBeGi8kItWE=;
 b=gCK8OXxkn3r8CsDJPX9NqgxFdDtyji1wIhNvl7/xRqz7AmygIYdhkr4CMyE5Xjx1BLpNILGd/EUHh43C6tDFjyk5jruHROY7PkOAYmUGizqXKqiyzuae7sNZDkmGiiYH2BKBqcv16bLeCGmXrFbJ6/uuUk+M17NIMusCxYIwK6fE48CFkzT1QyXIMUcNv8AUQ322saGhYwkOysXwRcN9PIxKR1MNFduzS2WscI4tg7nMx9M1c+ZQmFEFO+LJ0Y6UK68Kp+4IMY5MoNZVFKO1Gl6bxdhyMazMCGEodAO4JuvSozYDxX8O+lrjSCB8Ek65EmGQKAACJwGQVJsdjw7I3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA1PR11MB8396.namprd11.prod.outlook.com (2603:10b6:806:38d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 02:47:30 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 02:47:30 +0000
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
Subject: Re: [PATCHv3 09/14] x86/tdx: Account shared memory
Thread-Topic: [PATCHv3 09/14] x86/tdx: Account shared memory
Thread-Index: AQHaF7uCCRkuC/Mwf0eGEDDjV6f6h7CEGqmA
Date: Tue, 21 Nov 2023 02:47:29 +0000
Message-ID: <07e7619d098ba3579f642a97b644f256884ed0a2.camel@intel.com>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
	 <20231115120044.8034-10-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231115120044.8034-10-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA1PR11MB8396:EE_
x-ms-office365-filtering-correlation-id: 03b3860b-acd8-4fd3-7f7c-08dbea3c343c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0e3bt4CWbvsvmlbh2jb+lmz1KV5rNTRUQ8bv89fnNI4IXus2AzxDqWJO8YM+1rBtrn+r0FLnugvruwj5lZj39FsYGhZUUg/+iMrZfvc5cPDFpkTR5qMu1/wjI1zcN2R+XuXY2LXOitTncEWdI3Nq8St5/BYvAvmqgX3KaxtoV739UCAJJ5jZoTLurgUlmn2HOG5+UUG8XV0oVlXXSjUxpgPauJPnorR/HjTuv5vr0vgosS9QWLcxJIKn01mPpQVRtcDxVDpURIgLZA6Ow8ejLJyK60aL4JBhW17uR7rmm4muWIlhJJiGXlZ7xik9tNq7b/zhO4IQ8qYrrY4YB2D9lMYn/PVc2752BsbMPSETg7BUYcvs7o5z7gYeZewR6DEffPzg0G++Ok4yRineUTXW4kBPNXV4dWMHpyKtbfyHiPfwmdRcu6x9RzAASUOTeeCWXDKNyIpBwYIDjKPiz0YU/aUgs0GLd3MnOlnyGBEniQVeDJ2WHbbe+b89KkEE3dwTcWsiWYvK+so6bIoTRgh6in5+j6DbGIVOKiERAT7T0vEUuZf4sxUDmDW37+377+sSWlK6AWeI5OdTmHJ/hhOICbopbXoziaASeSJXWU76yEGIJLJwl4VKHA/Aa6+iYANJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(366004)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(82960400001)(83380400001)(71200400001)(6512007)(478600001)(6506007)(38070700009)(76116006)(110136005)(66946007)(91956017)(122000001)(54906003)(66446008)(66476007)(66556008)(64756008)(316002)(38100700002)(8936002)(4326008)(8676002)(6486002)(26005)(2616005)(86362001)(15650500001)(7416002)(5660300002)(41300700001)(36756003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEdCYnFqZjBDdFI1eTJjS3JHT2ljN1JueDViWEF1a3lEZzl5bWdwU3BDL1g3?=
 =?utf-8?B?L1p6UktZSXAyY0IxMVRxTzRYZHg4OVVyblcxOHM0bFNWOU1oRm9GQi9VS3d5?=
 =?utf-8?B?a3NKZ1pWbURZMXhkclRaYzRwSTM0NG5tN0xXWEpZNy8vK2FTWSsyTjFXQTZQ?=
 =?utf-8?B?WElJUHpUSmNZM05ZSnZMNEZuUzduVHhPbXJ1eVZ0QWMrSmJIb1djckpFUUZ4?=
 =?utf-8?B?NUUwUHB4Y1l3aHd3OU1lRGd3WldwRWFQK3lSVVh5T29wT0IzUTZsTVFFd2ph?=
 =?utf-8?B?M1E2QWNSU2tBRG45ajNqTUFJb3JKWktnUUxKSWVuZ3JjT0JvU1pJc1VsR3dt?=
 =?utf-8?B?bTBsNlJRM21pekcxSlVEcHdVSVVicXcvbFJ6eTBXMWd5aGx5L2lLYk1pcjR0?=
 =?utf-8?B?RThYN3ZpRDRUNGdqcUNJbHhRMjhFelY0NlJ5bkNjNGtRbUZJK2hYcnAwbCts?=
 =?utf-8?B?YkQwMWF1T0NlRVh4QWZoNlZOWXJXYUxieTJvcUdqRjFnVzRtRmhuYktjS29Z?=
 =?utf-8?B?WkFyK2NmdTVqSW4wYlM4TjBCcFhVd0JJRGxTN0gvRkZybU5CY1M4eTNVNEtL?=
 =?utf-8?B?QWtZdzVyTlpCOGdoblBkRHBkemd3ak1ueE04REw5Ly9EK0VFd1RRSnA0S1pl?=
 =?utf-8?B?SDhMbGxJVDdxYUVIR1pNTmx1YTBRczNnOXRZckZ3ZWZCbEVYZVIvZG5zdnJ1?=
 =?utf-8?B?RVNTZktxQUlIb085aVNiTkRDK2NVa0pLWWF3d2cxK1l4U0V5ald3Nm1OYTV1?=
 =?utf-8?B?YmlKMHZrOUdqSmtPdXhJYU5iWUdQc1ZBVGtxK2xXRk9KTGVwdlNGazhCWkNT?=
 =?utf-8?B?SEMyL2tYeXpZWm1vVE8vQ3BOODNHRjRTZXZYdWVjRVhIaUNIdTQyNHVseGZE?=
 =?utf-8?B?YnpxM3hib2N3OG9lVlpJU1B3NzRieGx2L21sUDlwSUR6T1o5TmRvdFNSRDRI?=
 =?utf-8?B?Q0RJL1Y5cTNSMUFxNjk4cm40QjQ3Y1MwUDR1UCt5TVdzS25GWEs2VStTWXlC?=
 =?utf-8?B?RE1WNG9NTHhjVUNweTNSY1NWK0ZkVDI1ckk5V2c5TTZ1ZWtMV0FIRkVhUWth?=
 =?utf-8?B?MlRmL2lac1Vrb1VSbHFPbkJCbEZ6R0ttNi84dG1LOTlhOWExZ2dtcUZSRTNO?=
 =?utf-8?B?Wml5Z1JJWGRHNGt6dmdUVHFjL3gyUWE3SEM4b2xVUzFnVEdHYVdxUjZNZEdO?=
 =?utf-8?B?STJTdmVlUVZVUzc4Z3l4L3U1L2s4cjlDTnBrMGFFem5PVml1REtlN0N2N3dJ?=
 =?utf-8?B?TkN2MFBOUHMvVXFMc0U4ZHo0Y1FuZWJNWTdsRUhIWFBJamRTWHZjMS9wS3VH?=
 =?utf-8?B?bEdWNSt3aEdZam1zVmRlMWkwUVYxSjc5eUZrelpMZFd3cUlyRnZyUVVZNUJh?=
 =?utf-8?B?YU0wRUJGNGt1WVdXUk9Sc041YkNyRVpLekE2UkoxZnRVSnl6c2VoZnNQaHJX?=
 =?utf-8?B?MG1GNHdWbEJUaTJvQ0F2R1BWM29QRStpeGJaRGdhSTZCZUN5L0R3UVRmM2ky?=
 =?utf-8?B?Y2U0UkdMcnVWS2kzOG5aVkI5L3RvaUFwem11VGtZS3ExWTkrR2hLNnVPN280?=
 =?utf-8?B?bm9qdm5XcXJkWmlNVmNIeXkzK05YQmxYSHhJc29aSko0MUwra3hmQjI2b1Iz?=
 =?utf-8?B?NlZ2SW9QYldUaVh1cW41Nnp4MDRVb0FYb3QyaXo1VFRkaEh5aGx5OHk2TlhZ?=
 =?utf-8?B?TG5ZYjliVTFydmpZb3BkTnd2c2l2aVIyTDFkUWhkbE45a2hTMk5COG9ZNFdB?=
 =?utf-8?B?Ky9mWGdLOFczQmU0Z0NXYVBBM0wyVkoyeTl3Q2hTNXZneG4vM2RZclRpS3NO?=
 =?utf-8?B?b09raGgremhXYS9SV3R1R1d2elltcDNnT1BSdzF2c3ZLWXV3SDJXN0pZdi9J?=
 =?utf-8?B?QVYzT3UxTll5SFdrd2NXdjc1ZUVJb1NOcFJBV2ZQekRFWmZvOFEvT0lHbEEx?=
 =?utf-8?B?Q0M5QVBIWldmWG11ZFkzdUlkSlVjNXg5eWY2Sm1GWWhvd3Q1cDl5ZHo5SlUr?=
 =?utf-8?B?SE52eXFFOE1seWk0UjN1NDhYL0s0Nnk5Y3pjVG1yeWcvYzc0Y3VnNE1vejF0?=
 =?utf-8?B?MFVoQi93eGwyWGhuRlE2dlh1eTdSYVliWm5DcWlNeWJnWTFlbG0wVCtQSmkz?=
 =?utf-8?B?UE5XNUw4NSs5eERpZG1ZTVRQRkc1TnI2QmJQSjl0SXBVZWsxaWF2SzB2RU1N?=
 =?utf-8?B?d0E9PQ==?=
Content-ID: <8164D82C80863A4ABA7EEBCCDFAA4DE5@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b3860b-acd8-4fd3-7f7c-08dbea3c343c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 02:47:29.8269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qu1hk9B7xNKVF0J6/bclrdgixbhAslGWrGke+HU5QLDwACdMG6lNhz4YyFHLcs8zautYKsJ8VbvyBzvAcrKB1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8396
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_184743_290483_D14B1B6E 
X-CRM114-Status: GOOD (  18.28  )
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


> +static atomic_long_t nr_shared;
> +
> +static inline bool pte_decrypted(pte_t pte)
> +{
> +	return cc_mkdec(pte_val(pte)) == pte_val(pte);
> +}
> +
>  /* Called from __tdx_hypercall() for unrecoverable failure */
>  noinstr void __noreturn __tdx_hypercall_failed(void)
>  {
> @@ -820,6 +828,11 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
>  	if (!enc && !tdx_enc_status_changed(vaddr, numpages, enc))
>  		return -EIO;
>  
> +	if (enc)
> +		atomic_long_sub(numpages, &nr_shared);
> +	else
> +		atomic_long_add(numpages, &nr_shared);
> +
>  	return 0;
>  }
>  
> @@ -895,3 +908,59 @@ void __init tdx_early_init(void)
>  
>  	pr_info("Guest detected\n");
>  }
> +
> +#ifdef CONFIG_DEBUG_FS
> +static int tdx_shared_memory_show(struct seq_file *m, void *p)
> +{
> +	unsigned long addr, end;
> +	unsigned long found = 0;
> +
> +	addr = PAGE_OFFSET;
> +	end  = PAGE_OFFSET + get_max_mapped();
> +
> +	while (addr < end) {
> +		unsigned long size;
> +		unsigned int level;
> +		pte_t *pte;
> +
> +		pte = lookup_address(addr, &level);
> +		size = page_level_size(level);
> +
> +		if (pte && pte_decrypted(*pte))
> +			found += size / PAGE_SIZE;
> +
> +		addr += size;
> +
> +		cond_resched();
> +	}
> +
> +	seq_printf(m, "Number of unshared pages in kernel page tables:  %16lu\n",
> +		   found);
> +	seq_printf(m, "Number of pages accounted as unshared:           %16ld\n",
> +		   atomic_long_read(&nr_shared));

unshared -> shared?

Btw, I am not quite sure what's the purpose of reporting number of shared pages
in both kernel page table and that the kernel is accounting?

IIUC, there might be slight chance that the former is different from the latter
(i.e., when user reads this while the kernel is converting pages
simultaneously), but in most of the time the user should see they are the same.

I can see it might be helpful to report @nr_shared to the user, but how can
reporting both help the user?

That being said, I think perhaps you can separate the /sysfs part as a separate
patch because it's not a mandatory part of this series but a nice to have.  Then
the /sysfs part can be reviewed separately. 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42865C369C2
	for <kexec@archiver.kernel.org>; Thu, 24 Apr 2025 13:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jNySl43K3iirpRyyifM7R4O4nOijbc6nNeXaOjisqts=; b=OuziE3DWN/oyBe4vUfD3mgA5ot
	NPkKfY2c6XVn3hkJIAmdCYkcFq1nnno74HgRMG0Wise55FfJEsUtac/7UGa/QoQG5gH+z6IUoD6gF
	yqHjqWnSNXelW+leVsfDgR2V0GoTdyLYmAZvu0CRJ40gDgH8zwkab6nBhFelrcvLKpFGMYoTp2T1S
	vV5W1dHyIHnLORy3MyGzX8eMfE95qM7DIuh1f3YblTr6zUo/9OXBIs87rU+YJHC3FgjwcPrML6B/f
	Teaj2EI0aiBmbUAvnsWwuyp3G+GTmsgTFxDCOUTz3LYz0c36tEEXqdkQOWhbswUs+4dwAxRE4T37x
	tMa16pBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7wwn-0000000EFGf-0pXO;
	Thu, 24 Apr 2025 13:49:01 +0000
Received: from mgamail.intel.com ([192.198.163.17])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7vhz-0000000E2e3-39l0
	for kexec@lists.infradead.org;
	Thu, 24 Apr 2025 12:29:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745497780; x=1777033780;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jNySl43K3iirpRyyifM7R4O4nOijbc6nNeXaOjisqts=;
  b=Duu1fPcw+CuOu0yu6dfgg/kiw5JV8h4J1kPhXhSmMwFIMpqmBuvKdYPJ
   lcI7Rlakky/MSsJOW/MztCqnUkjrTrHyU2VR3eI7GTCNRP50/KnAw7V1N
   nNeu/DkTUCiv4SHkg5UOqHupgRjz2A7hIjbif9mFJ+eo/BpdHwepWW3Tn
   OeJscgyF4Bb8x43X/sFTmkUoxKcyjsrWlNG5L1L+ydkl+yliYqWso0ZrV
   a3guf3d+DeLLDBWuCWhAVHhRAB1EoHZfaRlczkkAs1TzU2T+2fHpIRPl6
   uTHf8Enox8Y6eSPcF6pxfyP+7NBXYAY47zyvzDJSemkDzDLzC2XinGWbg
   A==;
X-CSE-ConnectionGUID: VtYZr2+rR9KOS+mCd5pGVw==
X-CSE-MsgGUID: kaIoe6nnQqWnfCaetGwZQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="46999431"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="46999431"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:29:38 -0700
X-CSE-ConnectionGUID: 1E3c8c7NRq+4LiiI0WPzYg==
X-CSE-MsgGUID: ebGgnhH2RBOBuTP33w/LsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="132908297"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:29:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 05:29:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 05:29:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 05:29:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTCL9Y/5vp9YJgwMefJgqT97rGLWAspDjLZVX6eKyEMFRNZAWn+IJy7y/Sjz9T/1dEq1bieRMkmLSQweNGJsAWzd4u+bqTgDcmljG6EtfH+8/EiYd1aAgEDBctjiDgbrviy4k9scTnNBFggR47O0ncJ7IxL1JeLjK+dgPeAoWzZdxCk67vcb6V9riEBYezTrvn8HDCBT2jCmosD0EKdZQRaoyWZMYpDQ2SFlcXYodXNhl5liWjnhzCdld23Sc16TqitnJBAw9NEfvm9Dv6Y2EwHx6unJf1aktI8L6ieC6knl7totEdNvvhYxy4G5w2Mu64/TIoUfd8dLhjSvwb02YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNySl43K3iirpRyyifM7R4O4nOijbc6nNeXaOjisqts=;
 b=KB7EPMsWqEfHbEYOo8thjdxA7kPAnYhvQBnyEiJkfFruhncvvYhDYuzP2AjbHTBNr/Uww/xVJUuxfz/msea6+MuvcF4KBVyCUV4AbItkdfADV2bfADvhIJz9aY108OaCQUM6vkL9uyyLmTPuW6fef0q7be/GG+79gdEJd4RouoH6h7n4xPUpl3QbhHzcjgtvzShm3QKGE5l1cr3c+7o1CXIzCojbN+miVu1Hmj85NgrNHvvzwkg7RieHJ9GV8fjICBcOEOzjHxoutKt6fV/tPxSsiT1HYpsY98XWxE56WDLTkqsZci+BOZSlzXztrYKfeXXNckpYn0Ztln4hW00C9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BL1PR11MB6001.namprd11.prod.outlook.com (2603:10b6:208:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Thu, 24 Apr
 2025 12:29:18 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 12:29:18 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "x86@kernel.org"
	<x86@kernel.org>, "linux-integrity@vger.kernel.org"
	<linux-integrity@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "ross.philipson@oracle.com"
	<ross.philipson@oracle.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "ardb@kernel.org" <ardb@kernel.org>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>, "peterhuewe@gmx.de"
	<peterhuewe@gmx.de>, "James.Bottomley@hansenpartnership.com"
	<James.Bottomley@hansenpartnership.com>, "trenchboot-devel@googlegroups.com"
	<trenchboot-devel@googlegroups.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"mingo@redhat.com" <mingo@redhat.com>, "Ghatraju, Kanth"
	<kanth.ghatraju@oracle.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"luto@amacapital.net" <luto@amacapital.net>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "dpsmith@apertussolutions.com"
	<dpsmith@apertussolutions.com>, "jarkko@kernel.org" <jarkko@kernel.org>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>, "mjg59@srcf.ucam.org"
	<mjg59@srcf.ucam.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "nivedita@alum.mit.edu"
	<nivedita@alum.mit.edu>
Subject: Re: [PATCH v14 04/19] x86: Secure Launch main header file
Thread-Topic: [PATCH v14 04/19] x86: Secure Launch main header file
Thread-Index: AQHbsttyyPZHG7nt802BE1VhSFOzvLOyw0SA
Date: Thu, 24 Apr 2025 12:29:18 +0000
Message-ID: <e2d00d7cc4cfc33a3b328fe8386f6d164bc46184.camel@intel.com>
References: <20250421162712.77452-1-ross.philipson@oracle.com>
	 <20250421162712.77452-5-ross.philipson@oracle.com>
In-Reply-To: <20250421162712.77452-5-ross.philipson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BL1PR11MB6001:EE_
x-ms-office365-filtering-correlation-id: d17489d4-2cb3-4ab9-7683-08dd832ba211
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NDg0UVNiMm9LL0NkWlBBWnpLTHF1azZqRERMVG9Kd3lEY1ZpOEJUU1FKa3pp?=
 =?utf-8?B?cFpqSTNIVy92M3pkM1dOYnBFKy9oUVp5dTF6cDM5SVZpa01BVWJsN2VaeEJu?=
 =?utf-8?B?NHorYUI1eGxtV3dLdkNzZFhYdDZOU1o4T1UyeE1zcXUwaWQ4QTIzMnpZcmV1?=
 =?utf-8?B?Tk53SUVQYWdXYnlTRjNVcFYyaUpycVFDelhydVc1cGR4ZTZwSDA2TkVZQ2w5?=
 =?utf-8?B?OWNHZDgrVUpSVEs3WmltNkZBSzM3cjNJYjJKSlU2L211eUpnM0Z4b0NsVUhs?=
 =?utf-8?B?aHZVc3hkU2M4RzZMSUhRT3pNVHRvQXhtbFBZK0ZBRldHVHJTMjFhOE1mam9v?=
 =?utf-8?B?bW1Zb2htbWpxT2NhbW94T2VNZG9PdU5WbmpQZjNISGRFZzluOG1rRjBtTXpL?=
 =?utf-8?B?OFA1Q01paTRGYmpDTHlRSUFLRFR0QTFqUFB3WEJKUWpzL2hsWkVnZEFmOEcz?=
 =?utf-8?B?TkltZnFpdnBZMHNNTTVDU0F4bEN0NWFaajdMM2lZSmpUQ3kvMjhOaExZZGJh?=
 =?utf-8?B?T2U5b2htZWFNMm1QOGJ4R25hZTlSNW5wblVvSk1oY1pGc1Juc29KVmxWQ1Fa?=
 =?utf-8?B?V25QQnpMT29rVllQeGdhVzEwQnJUNmx5UWhtMEQrUDBqR00wclovUEd6c2RL?=
 =?utf-8?B?alNBSkxRYllFeU5UYTdzVVBQSWhsT1p3WStPVExabzlZKzlnRkgrSU1LaHp0?=
 =?utf-8?B?UXdlQnEwSmlYNEs3OEovOExuRWc5OVNNZkxqd1hUSnVORk9VYjE4Sy9XRy9P?=
 =?utf-8?B?UkpzbkdEVS9sNGZSNVE0N0J6ZDcvL3VwV3pXQ3FFOHJzbnJpU0ROWXNYOG9R?=
 =?utf-8?B?Q3gvQ2wrOER0WmhHcGJQelZzMWQ3TVBVVitZc09DQ0VoMnllVmFXT05RT0pi?=
 =?utf-8?B?Q25FOVpjWEx4Q0tCVVlqKzVpM2tOTWsxTVEvWkRTV2ppeDZpK0hVZ1ZEa000?=
 =?utf-8?B?VjNpSENsa2dUalMxRHhYb0NKLzZ0N1dsMXJPdytUZ2N4WGhadFJwWXVJaDNP?=
 =?utf-8?B?YUNCdzZ2UlJuWWhYZ25wMjRjb08rQTVYRzQ0UEQ5M3dNakZSWkJjS0VwZ2gx?=
 =?utf-8?B?K0pHYkQ4b0E5TXErU042NXVrVTZjNjNJZ1M0RUZpQzRxaTdyVW9hL0dxMkkx?=
 =?utf-8?B?YlFZWXJ4dlRMVkJ0Y0RkY3FHU21vVXdXdXlUbUNCZFdnUHovRE5RV1VOdm9y?=
 =?utf-8?B?WU5XTjJFV1FSNjhxTHdhQ0FWcGdUQ0dPWHZuWkFmQ3lqYzZjK085QkFGM0h6?=
 =?utf-8?B?KzBMaW9NaW1IV2NVTW1OcGlGVlBWbUtQSTlyNmNNN1RLVXZrMFJJYS8xbXk1?=
 =?utf-8?B?NjRIZUhnNmlrbFc3VU5CN0lrN0hiWkhNbFRrTWQ1MlVySks0QlJaSHROZzR1?=
 =?utf-8?B?YzZheHRmN0JJek1DczJxem5ua1ZZU1ZIa21IbmpyREYwVW42Nndrc3VFREYx?=
 =?utf-8?B?dFMwbDViNjBEWmVmbEtzUGtlL3F4alNMODRLZkFnZURoajVBcGFBL2ZYcEJz?=
 =?utf-8?B?ZnY4S0pHUXVpN2FveXY3ZEViRGFoc0tQd3ZuT2xvRVdWL3QwaDBYMElhaHBU?=
 =?utf-8?B?QWhFcjlSU205a0Q5WDVGYVdTRVpLY3V6OFQ5NGdTTTNyTW9aTTM1by94d3NQ?=
 =?utf-8?B?MFlLb3d4cElTazJXQ0xBTlFCTVJpU1R4SHpPQjBmdFJ5NE1ZVFBBMEFidVA5?=
 =?utf-8?B?eldJbDRZZUFCbmc5WVVlUzlNY1hQLzErRzNLeTZsekhQSTZIMUticGtKUEVX?=
 =?utf-8?B?aU8zV3FlVmsxbmlxbkNhNFRwWDFodGEvVEJhbU9IcUg0eGY0QjV0d3ZYYnFV?=
 =?utf-8?B?R25GVEdpVzI1aWY3NnBWSUVHbDdxNkpsbStzVGx4T3FlYjh6V3NEV01uemhT?=
 =?utf-8?B?Y29iUHRhL1Z6b1BuNHI1UnZGL2ZnY0RKVnFZZkVCWFIydjB1YTlOQlJWNzFH?=
 =?utf-8?B?cHg2VFVHUjlTQ1F3Y0ZqbkdlM0RvV2U3TUFGdUpBeWdMUzNXMnVSSGtpMG1M?=
 =?utf-8?B?cDFreE16N05RPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHhLRzR1MDlqRklTNWtLTVBEQmw1aHI0cEg2NmIwVFpmSnhvcytYM1pkWS8z?=
 =?utf-8?B?SWFuRlpIRkF0VjJEQmNTTHNQWHhZQ1pybzFsb0hKL3NxMmdyMEgrWk52TWtB?=
 =?utf-8?B?Uk40YVBEamlFd1NRWnFmTUJrdXgxaENNeERIZW9aeXQ0T2lFNFNiVVE0SzBG?=
 =?utf-8?B?NmpSaEU3YkJwdVpxMmN5bWU2SlMwWXkwdnhFcU5oeFJSdUNCTTlxNnlBLzJB?=
 =?utf-8?B?QWRYUHVzb0x2NkdIK0VIVjFwUHgxZGV3ZG40d3RJSExUUXgzUEZqdXBwVWgv?=
 =?utf-8?B?VjdyZkc1NzFsb0xod080ekgzVStqSlYyWkNLMTZ6aTBhbGg3S2VhOGJ5SlFB?=
 =?utf-8?B?TzJyVVNyTVlHZEFFY3FvVDk5UWJid3ZDVDVoK2lVQ3NPWWE0TkdFRkxpUnlC?=
 =?utf-8?B?ZlUwRjFoRUhGNDAyQkdnUGduajNsamlHV3FQL2w0V1BMcjRjRTdNeVdrQUtN?=
 =?utf-8?B?TThhNkNZcnJvZDA1L1l3V1l5UXVCRDJHZUZJMWk5S2RCbDJwelpUS0I0SHBX?=
 =?utf-8?B?WWhzT3cxUEU1TEkrUGNwNGhYcXRjY3N4S1VjOUtoakdrMjJ2TVFlWmhyK25h?=
 =?utf-8?B?YlR6OE5DT215RjMraHg3aWJTTWhtcWNxcXhuS3FlTWhyRGRjTGNiSTBNWkc5?=
 =?utf-8?B?Zk1ZajBrdmNOdXFKSTROVkJaOGNkb3BtRkhvZFMralNGTU1zNjYzazNaNTRk?=
 =?utf-8?B?MnNTU0xURG5TM1pXZ09oV2VaYVVjeEJCUWdOVEJ5NWh2cTJzMUgrNEY5K1dj?=
 =?utf-8?B?WFUybTh0M0E0V2FHT00yMTdSKzByZVBFZ3RJNWErQk1QMWR2TTh5WFk3VU1p?=
 =?utf-8?B?LzFKc2E4N04rVks2bStNb3AyODZ0T2VhNno3endDeEVFUFk4MkdHRmY2VWFN?=
 =?utf-8?B?aHhFMW9CbWVBalI3TFUwNUh3QWUycDJmQ21nQ25ROUMxd2QrSlpjV1pKSXh1?=
 =?utf-8?B?a3JtQ1RHRHBGUlFWT2xiRmo3dEpUTG1kYVppVjc4SkZRbGpVVWd5ZW5LQ2V3?=
 =?utf-8?B?bndvTTRUbk1teEFaY2JWdDFsc3FKZmozWGlHclZacW0zdlpPczNFUnJ1Z0FP?=
 =?utf-8?B?eUlYd0hJeWR5T2g4MjNmSUtWYmlwODhGMDhvWklKcGVWYXgxaHBHdzdjNE9t?=
 =?utf-8?B?T2ZTZUdaQ091Si95dWwvaFhqT05Ma0FORDdGNFlsZzV0VHJ5NkgrWXZOOUxB?=
 =?utf-8?B?WGlhRWg0b2FYSkJiWjQ2RkFucy90UWt6NS93aDdxa0U4bSs1cEcxaUIycWtu?=
 =?utf-8?B?Q2xmdVBlTE1OS0NtWDR5eVZ6TXpWSUNEQzUwcGpNM3duaW9TdDByeUFEVDcw?=
 =?utf-8?B?YmMxdWd4MnpxMG1kZ2dmMzZYanpTbEpwU01NdzAwa0NpMTdZTEdJNU1wSnNI?=
 =?utf-8?B?Sm9ueWhZTW9kM3FzQW5oc0VyYjA3OTVsZWRQNzN3OWpEM0JHdkYzdjlkbjIz?=
 =?utf-8?B?cTRZTFhVOFdTcDA5eEZJMG91WVJFRjZzMGhYTi90NzBEQ3FndVNwaVlTeElM?=
 =?utf-8?B?aWFOVkg0eU0vdVlvZ0h3WCtJczFLT2orcWIrMzZXODE5UEpJZzdVRUNVMVZi?=
 =?utf-8?B?WTk3djFBRlNpd2k2cG5vYWlCdlVlNWJEMkFTSndlTUltc29LUVdab2JqNHp3?=
 =?utf-8?B?R3lWUHkvS1NSSDQwcStMUGduM0dSZ240QTFOZVh3RXlPMHhVTU1lcjJNNW5m?=
 =?utf-8?B?NVhSUWMvcnZPcEx4RWdmbUpYbjc4QXB1ZmZEanlpZVlFdHpsTUc5YW9QMFZi?=
 =?utf-8?B?QTRTZ0xYK2RpR1hBWml0QkVzY2NLSkloS3JzMXVYWVdicXdPVDc3NXZRSEtU?=
 =?utf-8?B?VG42RkxYeEVEbDhZaW45UDd6UEJPMlozQjFEREd3L0FKSVluakNSSGMxb1pU?=
 =?utf-8?B?eENIZGxYZjV6Q0hWL1psb0lhTncrOElEOUpDNi91eWYyalBpcFVmMnpZNEZo?=
 =?utf-8?B?b0VkeDVNTkpVaGVkaFZxWi8zMmcyQ1RuSnhNdERicHJsVFQ5NkJHdGo2ZnZ6?=
 =?utf-8?B?c2E0NXZwVmR4eFNCWlNLNGN5ZGtBOS9PTkV4aVZXNWh4K2ZnajVqSGcwWmhZ?=
 =?utf-8?B?UmtmTjNscSs5aGFDcUo0bTlyUUgzU1hwVU1KNzRjWG5rSGtSUG9GaloxY2R5?=
 =?utf-8?Q?VQN80uBLoRQ/0oh6sz0gNLjtx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68E7D840E685884A87000CB3FB53B256@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d17489d4-2cb3-4ab9-7683-08dd832ba211
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 12:29:18.2136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HwFGLX/lVW4/3IN2JVznpb+v1A+uctJS17Rpek/Peqj9Hr+3Ha7PuXIY9d9rNRb2j+PKLrvs+w4hRzL+bmNLdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6001
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_052939_818739_536ADCB9 
X-CRM114-Status: GOOD (  16.49  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

T24gTW9uLCAyMDI1LTA0LTIxIGF0IDA5OjI2IC0wNzAwLCBSb3NzIFBoaWxpcHNvbiB3cm90ZToN
Cj4gSW50cm9kdWNlIHRoZSBtYWluIFNlY3VyZSBMYXVuY2ggaGVhZGVyIGZpbGUgdXNlZCBpbiB0
aGUgZWFybHkgU0wgc3R1Yg0KPiBhbmQgdGhlIGVhcmx5IHNldHVwIGNvZGUuDQo+IA0KPiBUaGlz
IGhlYWRlciBmaWxlIGNvbnRhaW5zIHRoZSBmb2xsb3dpbmcgY2F0ZWdvcmllczoNCj4gIC0gU2Vj
dXJlIExhdW5jaCBpbXBsZW1lbnRhdGlvbiBzcGVjaWZpYyBzdHJ1Y3R1cmVzIGFuZCBkZWZpbml0
aW9ucy4NCj4gIC0gSW50ZWwgVFhUIGFyY2hpdGVjdHVyZSBzcGVjaWZpYyBEUlRNIHN0cnVjdHVy
ZXMsIGRlZmluaXRpb25zIGFuZCBmdW5jdGlvbnMNCj4gdXNlZCBieSBTZWN1cmUgTGF1bmNoLg0K
PiAgLSBEUlRNIFRQTSBldmVudCBsb2dnaW5nIGRlZmluaXRpb25zIGFuZCBoZWxwZXIgZnVuY3Rp
b25zLg0KDQpMb29raW5nIGF0IHRoZSBhY3R1YWwgY29kZSBpbiB0aGlzIHBhdGNoLCBzZWVtcyA+
OTAlIGNvZGUgaW4gdGhlDQo8bGludXgvc2xhdW5jaC5oPiBpcyBJbnRlbCBzcGVjaWZpYywgZS5n
LiwgVFhUIHNwZWNpZmljIG1hY3JvL3N0cnVjdHVyZQ0KZGVmaW5pdGlvbnMuICBJdCBkb2Vzbid0
IHNlZW0gdG8gYmUgdGhlIHJpZ2h0IHdheSB0byBvcmdhbml6ZSB0aGUgY29kZS4NCg0KRS5nLiwg
Zm9sbG93aW5nIHRoZSBjdXJyZW50IHBhdHRlcm4sIHdoZW4gd2UgbmVlZCB0byBhZGQgc3VwcG9y
dCBmb3IgYW5vdGhlciBUWFQNCnNpbWlsYXIgdmVuZG9yLXNwZWNpZmljIHRlY2hub2xvZ3ksIHdl
IHdpbGwgbmVlZCB0byBhZGQgeWV0LWFub3RoZXIgc2V0IG9mDQptYWNyby9zdHJ1Y3R1cmUgZGVm
aW5pdGlvbnMgZm9yIHRoYXQgdGVjaG5vbG9neSB0byA8bGludXgvc2xhdW5jaC5oPiBhcyB3ZWxs
Lg0KDQpUaGF0IHdvdWxkIGJlIGEgZ2lhbnQgbWVzcyBJTUhPLg0KDQpDb3VsZCB3ZSBtYWtlIDxs
aW51eC9zbGF1bmNoLmg+IG9ubHkgY29udGFpbiB0aGUgY29tbW9uIHRoaW5ncywgYW5kIG1vdmUg
SW50ZWwNCnNwZWNpZmljIHRoaW5ncyB0byBzb21lIHg4NiBoZWFkZXIocyksIGUuZy4sIDxhc20v
aW50ZWwtdHh0Lmg+IG9yIDxhc20vdHh0Lmg+Pw0KDQoNClsuLi5dDQoNCj4gKy8qDQo+ICsgKiBF
eHRlcm5hbCBmdW5jdGlvbnMgYXZhaWxhYmxlIGluIG1haW5saW5lIGtlcm5lbC4NCj4gKyAqLw0K
PiArdm9pZCBzbGF1bmNoX3NldHVwX3R4dCh2b2lkKTsNCj4gK3ZvaWQgc2xhdW5jaF9maXh1cF9q
dW1wX3ZlY3Rvcih2b2lkKTsNCj4gK3UzMiBzbGF1bmNoX2dldF9mbGFncyh2b2lkKTsNCj4gK3N0
cnVjdCBzbF9hcF93YWtlX2luZm8gKnNsYXVuY2hfZ2V0X2FwX3dha2VfaW5mbyh2b2lkKTsNCj4g
K3N0cnVjdCBhY3BpX3RhYmxlX2hlYWRlciAqc2xhdW5jaF9nZXRfZG1hcl90YWJsZShzdHJ1Y3Qg
YWNwaV90YWJsZV9oZWFkZXIgKmRtYXIpOw0KPiArdm9pZCBfX25vcmV0dXJuIHNsYXVuY2hfdHh0
X3Jlc2V0KHZvaWQgX19pb21lbSAqdHh0LA0KPiArCQkJCQkgY29uc3QgY2hhciAqbXNnLCB1NjQg
ZXJyb3IpOw0KPiArdm9pZCBzbGF1bmNoX2ZpbmFsaXplKGludCBkb19zZXhpdCk7DQo+ICsNCj4g
K3N0YXRpYyBpbmxpbmUgYm9vbCBzbGF1bmNoX2lzX3R4dF9sYXVuY2godm9pZCkNCj4gK3sNCj4g
Kwl1MzIgbWFzayA9IFNMX0ZMQUdfQUNUSVZFIHwgU0xfRkxBR19BUkNIX1RYVDsNCj4gKw0KPiAr
CXJldHVybiAoc2xhdW5jaF9nZXRfZmxhZ3MoKSAmIG1hc2spID09IG1hc2s7DQo+ICt9DQo+ICsN
Cj4gKyNlbHNlDQo+ICsNCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBzbGF1bmNoX3NldHVwX3R4dCh2
b2lkKQ0KPiArew0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW5saW5lIHZvaWQgc2xhdW5jaF9maXh1
cF9qdW1wX3ZlY3Rvcih2b2lkKQ0KPiArew0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW5saW5lIHUz
MiBzbGF1bmNoX2dldF9mbGFncyh2b2lkKQ0KPiArew0KPiArCXJldHVybiAwOw0KPiArfQ0KPiAr
DQo+ICtzdGF0aWMgaW5saW5lIHN0cnVjdCBhY3BpX3RhYmxlX2hlYWRlciAqc2xhdW5jaF9nZXRf
ZG1hcl90YWJsZShzdHJ1Y3QgYWNwaV90YWJsZV9oZWFkZXIgKmRtYXIpDQo+ICt7DQo+ICsJcmV0
dXJuIGRtYXI7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBzbGF1bmNoX2ZpbmFs
aXplKGludCBkb19zZXhpdCkNCj4gK3sNCj4gK30NCj4gKw0KPiArc3RhdGljIGlubGluZSBib29s
IHNsYXVuY2hfaXNfdHh0X2xhdW5jaCh2b2lkKQ0KPiArew0KPiArCXJldHVybiBmYWxzZTsNCj4g
K30NCj4gDQoNCi4uIGJ0dyBpdCdzIG5vdCBjbGVhciB3aGljaCBwYXJ0IG9mIHRoZSBjb2RlIGlz
IGNvbW1vbiBjb2RlLiDCoA0KDQpMb29raW5nIGF0IHRoZSBhYnZvZSBjb2RlLCBpdCBzZWVtcyB0
aG9zZSBmdW5jdGlvbnMgYXJlIGNvbW1vbiBmdW5jdGlvbnMgY2FsbGVkDQpmcm9tIGNvbW1vbiBj
b2RlLiAgRS5nLiwgc2xhdW5jaF9maW5hbGl6ZSgpIGlzIGNhbGxlZCBmcm9tIGtlcm5lbC9rZXhl
Y19jb3JlLmMsDQp3aGljaCBtZWFucyBpdCBpcyBhIGNvbmNlcHQgaW4gdGhlIGtlcm5lbCBjb21t
b24gY29kZSBhbmQgbXVzdCBiZSBhdmFpbGFibGUgZm9yDQphbGwgQVJDSHMgKEkgaGF2ZW4ndCBy
ZWFkIGhvdyBvdGhlciBmdW5jdGlvbnMgYXJlIGNhbGxlZCwgdGhvdWdoKS4NCg0KQnV0IHRoZSBu
YW1lIHNsYXVuY2hfc2V0dXBfdHh0KCksIHNsYXVuY2hfZ2V0X2RtYXJfdGFibGUoKSBhbmQNCnNs
YXVuY2hfaXNfdHh0X2xhdW5jaCgpIGFyZSBxdWl0ZSBJbnRlbCBzcGVjaWZpYy4gIFNvIGl0IHNl
ZW1zIHRvIG1lIHRoaXMgcGF0Y2gNCl90cmllc18gdG8gc3VwcG9ydCBTZWN1cmUgTGF1bmNoIGF0
IHRoZSBhcmNoIGFnbm9zdGljIGxldmVsIGJ1dCBpdCBkb2Vzbid0IGRvIGENCmdvb2Qgam9iIGF0
IHRoZSBhYnN0cmFjdGlvbj8NCg==


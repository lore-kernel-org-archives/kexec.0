Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B4EC0032E
	for <kexec@archiver.kernel.org>; Fri, 20 Oct 2023 11:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y8bOYIzjZQDoAHOROQUh1uEhDvjp+efHIh3Y66LKVCU=; b=S6RSJGtMKrM55y
	oXACSgdeq7gzXeGpGmY46B6DY/+xAdAnpZL5/Ia+FaM/VWFh8MD/3LqzrvrrwJ/ycjmAtz6OlxzK3
	X7WINpgoiVdXXVgG3ekPqnxja6t1UPaRUxmWBi0qXreiPzcj2Lo8mmEKdLGsC9HNHDWxyns0vw5xF
	v+fPN4hIU+qRRU6a4uvDOQNLpO1+ESYmcbEPhF6OgSFRfjea/QN4YYoV+N4xfMZJ79Cij41CzVbXI
	SQqUYtLAAdQJIGgk273Sig5Gx8pldzXIZWc3kROETWXaZXPrNEYXZvoJ8R3Nqv72dzFECHLXaPRTC
	NNBqfyoSrtpNfcWajTFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qto9p-002CRl-0a;
	Fri, 20 Oct 2023 11:59:13 +0000
Received: from mgamail.intel.com ([192.198.163.7])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qto9l-002CQh-1F
	for kexec@lists.infradead.org;
	Fri, 20 Oct 2023 11:59:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697803149; x=1729339149;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=89RHfZqq/ju+vKsbTscYy2mQYy8fPpeCuZH5nPclPUc=;
  b=k4cm5cDR+nXmD8zIOBJTbSsXXDbPYQCJ8RPmpeejto5ku6/jcHvCckf0
   rhtd0fV/SghETH4TFvW/0KAmbHgdoWw6kK/7tD/GhquR7pvzRjNYaQ1w+
   BCFMmkjafrV77L2956w2Syq4BuSfBNyhIp6PLUKgHu8mSc+LwUZpDKOCn
   uKszafpYa9VnRmMX7qvb2KaB5fnr66o8DWJ2Qdzwg3fCi+WofEKEqMRz0
   63OVwUt9uMdIWWq4cMXVcnE1w3rK31xSlNr08ihXYahLSucelfkOGPDVA
   hdLOM7mAEHDG8a63p2+A4F+PKzp601O/c8AFURP+5SJAbWBtajpIdHGrh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="8048054"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="8048054"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 04:59:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="827716811"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="827716811"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 04:59:07 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 04:59:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 04:59:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 04:59:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cF2bSO9A+Yh7nzAt3ptJcfcM8wjnV0VQSbDesKqzcLhc0dKbJcknBsB7jnsIgKwmAX/R6Y18bfZ8To79PzPr9UraWuTETOeNVknupOv+JZwqPJooM84C2UnKQtOCVGxpLPzLC3IHQv8pSo9xLs+LuNilFPtJG84NmeIb2eX5VYuxTk/y2H903swWapz1pjs5SPShSLG/WiaQ38PTm3bTllAOFUqJ48+CTmgOcasItzESV143QEstEglbEtR05qTnABVbHzU1EPyCKw9rm/98RYG0iMdTiQYtz1XtoZo9kPl/c1Ru8zREOTnyEetAQy3wc4MFPfRrvsxwUAUeyAvgQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89RHfZqq/ju+vKsbTscYy2mQYy8fPpeCuZH5nPclPUc=;
 b=bDh4nSw0Fs9vpLVHowDtv9dzhQOH5wfGTrf3M5c6cUH3JnKPBeeZoQ5/Rk2rLdn3HcL8ogtmY/s58n+qwcwWw0ZqxXMHvP0C/SE0yq/lhkIuiSHaCiJq9Kceo2k8DNQXS4rEoHyZBYAJU4y44vPnZdrDDQcDN7scwb6PgbZaJOZJ5Tg9V3Henp/8ZElLOBRobfse+wIimRL57OzbiHOTX19qYC59jqSWhUEn8vDRjGDWkHm1v81+ibDfUb1yPkxPyixgOcPk+YHXQc3upJtVDKLvMVNKLTwWX6jOmmV80nJvruqAKZOiNIyQ0ADxuxv62MZMjhnLrJwmjN51qsauyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CO6PR11MB5572.namprd11.prod.outlook.com (2603:10b6:303:13c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 11:58:59 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527%7]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 11:58:58 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"Nakajima, Jun" <jun.nakajima@intel.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH 03/13] cpu/hotplug, x86/acpi: Disable CPU hotplug for ACPI
 MADT wakeup
Thread-Topic: [PATCH 03/13] cpu/hotplug, x86/acpi: Disable CPU hotplug for
 ACPI MADT wakeup
Thread-Index: AQHZ95EyP1ClwZ3KGUST35mBv7+5VbBC2L+AgA/RuIA=
Date: Fri, 20 Oct 2023 11:58:58 +0000
Message-ID: <edcd14bce71326e168a4dc11e5f1771e6f623aa8.camel@intel.com>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
	 <20231005131402.14611-4-kirill.shutemov@linux.intel.com>
	 <9f9fef1eb387e6098ca762d10e9c2002296c89f6.camel@intel.com>
In-Reply-To: <9f9fef1eb387e6098ca762d10e9c2002296c89f6.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CO6PR11MB5572:EE_
x-ms-office365-filtering-correlation-id: 2903cbaa-7d8c-4fdf-0200-08dbd163f13d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 11X7/ZP7uIojWNxV0TdTrgJKkDbCjSD4zlHEa0LJTjNJeFGhh/t0t1RcpF67wIoVmao7f336xGCop48Rn2ISR8ZT1JiuqjfLJ1SNQh2wyP5v47OIkwMsXmzSYnAEM+XdBipY9zU2hDV9cBwB+nkIMlopcJvjslLTOvVW0ucyLoqybHSlWqY0hYKnsbMrB03rpJjLNMKy+ZfUxo6WvxwLkow6+wl3wlfQxsL/QeZ3w5QWjNwL8T5xlRYbiYF/rPUubV8ZduTkingPgtwkx0zTcrXg6RJS2hVZjiGmiHOr5dN4Ik7BEk0dsEoeSx3HDPiV8GrcQCg0/7MIY9GMryt9PvTbzGhlwWUzGeh1ZALsTSNoWoZEKkkIBwPuZbaUyeTxK/tUzYniF6tapaaopP4B3168+iICaS/xtgxpem2u2HhhCx7OxpmOvGZ0gQokAx0/fuiFqGEyY+qP12DIWydb5/u8ppfYJ3wwZPkJ45gkSEJCDN0rwYRDJdTMJmoS+tiqF3K3GhnSGbK95bnH6m7c1cWBsS3emEUjoC6xsW5Xz9tnGp6N0RDw/l71d8/Xw10bW2go1uHCtPhh29GeMQcTCK52Nfh8LHjyWBG9LgSbLhjxe4+xckDF9iZyMUeq/S4W
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(346002)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(4001150100001)(41300700001)(2906002)(7416002)(6486002)(478600001)(5660300002)(8676002)(4326008)(8936002)(110136005)(66946007)(91956017)(316002)(64756008)(54906003)(66556008)(66446008)(66476007)(76116006)(38070700009)(83380400001)(36756003)(86362001)(122000001)(38100700002)(82960400001)(2616005)(6512007)(71200400001)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnliSXRXVER2UE0vUE1jZHhTa0Z1dFo1elJiNkZBbjVwQTB1NWtKNTVQRWF0?=
 =?utf-8?B?V1lpSG5CTm9rODltUWludFJOMXRoU2J5MFk2Sm1FR1hGeFAwV2EvQ0ZKWHRI?=
 =?utf-8?B?ck1xcks2aTg1WVBwbHI3SVFEdUFYQU44TnlpYlFGUi9iYnZKQVFDUUtMZmxz?=
 =?utf-8?B?S1g1bVEreEJxN055c3Q5VFZ4aWRWbzNkSXcyT3FOODRFWVQxWGFsSXFUeFky?=
 =?utf-8?B?dk1jTG9BUnRnNVh1KzdSWjBvN3pVb2l4V2kwNUt5bmVqWkFBU05MSkg5Y0RI?=
 =?utf-8?B?U3dNRDdoWDNOSmw5cVpHNHZpUWFRWlcyQm1LMWdleEhJY0cxeGd1MGt3YlFm?=
 =?utf-8?B?Uk54d1JrWFBpNzhlUVNnYWhxUFFDQVdTWmRnVUlzVktJeDRoT25nTUMrRnRH?=
 =?utf-8?B?Q2xmRlN3MjVWZC9DS1RDMVJJbHAzM21MVksweDNVdzJTTU82b3QwejB4dXUy?=
 =?utf-8?B?Q3NxeEg3L0toYzFWVUhDL25lSEpmdTZwTnZwN1Q3dWpZVTA1V2RnbVprSTlB?=
 =?utf-8?B?bU42b3pHQ3I4WXZFLzhlOFpLZ0lONVpkMThseGdnNXMyRUFpZ2dwaG1vcGtH?=
 =?utf-8?B?cEdybC9VKzFTMmNuL1l0ZHpZZWQrM0VFdTNRMFRVUUNweUQ1YTgreEo0MDdx?=
 =?utf-8?B?SXZmeVVPU3VFTmNmYThKZFNieWJNdVVYTFBJNWtyMEV5eFVNdVhvV2t5aEFz?=
 =?utf-8?B?bWF4MEVJQ1J0RzdTU0FWS2JmL3NZZi9TOUFacVJyUmNycnRsZEF2elhlQkl1?=
 =?utf-8?B?QWVYbXNFUm1Dam9KZDkzQmlvUUY3MjdqbDIxNm9iQ3hVRll6SC9DYkpwZVRB?=
 =?utf-8?B?azZjNXF1TGt3Tkw0UytPL2JuYVpTbno2WjZYSDVOTWMzT25CWlRVMlRteXR6?=
 =?utf-8?B?Ui9SWmF0NzhBeFBtVEk0bDRUcU1WNjJlSmR2dmlBbllrWEV5enVlZ2trNXF6?=
 =?utf-8?B?cVllV1pXVHovd2RsOXcvb3doM3E5cVJHR2hQTmdSS2xQYkZlL3VaQjdRaThy?=
 =?utf-8?B?K1Rsd2NDMGFaUUtaNnNSZlozRXRLL3h1UElxSUIwM1hUcDFsdCtVelUxd2Rr?=
 =?utf-8?B?ck8zdkpIbWJuKzNYK0JaRUhSZGRIT2FZbmRBYU0vcmQ3QmI1dGE5dXVSVFhp?=
 =?utf-8?B?ZnpNZTlRUUpBd1hGV0U4ZzhFVEJIQi9zVldnekRQSjVrelRvVzJxMHZWSVlu?=
 =?utf-8?B?NUU4cVRDQ1h4MjlTRWo2eUJKcmZXNFFZVjlDa2Z1K2pRYlI5NkpBQlpqdDlP?=
 =?utf-8?B?WWFweGFzZU54RGxERmdlc0RjTitWcDY4OU5HUHhXUm9sbXQ3WDhTR3FVZnRu?=
 =?utf-8?B?aVZlWm5tbGlMQ0s4Szh1UWpUZkp5ZHZFdjRJYzBVTFZSQTZNTGVrWll2ZTN4?=
 =?utf-8?B?K3Z2enNmZ2FNa2JyOXgrK3pjQmdzLzlXWDdHSjQ5NDg2MVJvV2lOT0twdWVV?=
 =?utf-8?B?YVJ6NWFmL0NPWDlJeHNKMElRdWRRTzQwckpWaUN5TjhSTjJNK3FrWkloc2ww?=
 =?utf-8?B?NmVUemkwbll2dkltRTRKOTdLSUpYT05ZMDM5QmVSR3A0cm0wSERmOVY1dHNr?=
 =?utf-8?B?d1duYTdaQWVObTJBVnNVWmZ1RmlQVktSU3JyWHRPUU1WUkZ3TW5kVTg2b29T?=
 =?utf-8?B?UUhpNUVuSEVKc1IwQ1NQcVMxTFB2eS9ZUVZHamFqT3Q3V2Yyb2FGMEVYQWJ6?=
 =?utf-8?B?LzErZ25DUVdFcnFnZ0ZxMEEvanBTc2NtUTQwd25lT2x1ZmVER0NpNTFPbW05?=
 =?utf-8?B?eDEvR0VESXlRVG84QkZuU29ka0dGNWtjTUwwajk4M3VHVGFva043b2VuNXVE?=
 =?utf-8?B?OVRWUUJ0SUUvZU1JamJjN3BhVEdEZmx6NnFsaFZhZERhUmhxUk9mTEt0MS8x?=
 =?utf-8?B?NlVNNFZldE9lWDhJZ2xGRzRRSmFxK1haSkw2c3RpbDNsajRyaWRqOHJjbzBZ?=
 =?utf-8?B?cFNVdEY4V3VnZmQ2TmhTdHBlbzlGNzlPNTZnYnppN2U2c2pRbjFFVEsvSTFh?=
 =?utf-8?B?VUJOL3lGcTdEQmJtNVFZTkhRVmZqY2JTMWRLMlRRY3NGRWJWdWVZc2NJcmFw?=
 =?utf-8?B?NEpTK2psZUYxbENKb2MxR3ZGQkRybGJnci9UZGEwWFVVV0ZMbm5KNDBFYjcv?=
 =?utf-8?B?R2VHT2FxTnQ0L0t1SFd2ck1QK0M0VDh0RWZkeCtJUGFkd2N0UjdHK3J5dnJY?=
 =?utf-8?B?bWc9PQ==?=
Content-ID: <FE9846D6B4488C4EA37D21726C00372C@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2903cbaa-7d8c-4fdf-0200-08dbd163f13d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 11:58:58.2202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HAkDvTplQmFRbWYRaLCSWPf6TB21jsiXoZbrVS/fdJdhdjql8cYhQQQdReSE+olp6gC6e+vxVDMedE6DArHfXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5572
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_045909_463222_9D0D261E 
X-CRM114-Status: GOOD (  27.36  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

T24gVHVlLCAyMDIzLTEwLTEwIGF0IDEwOjI0ICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+
IMKgLyogUGh5c2ljYWwgYWRkcmVzcyBvZiB0aGUgTXVsdGlwcm9jZXNzb3IgV2FrZXVwIFN0cnVj
dHVyZSBtYWlsYm94ICovDQo+ID4gQEAgLTc0LDYgKzc1LDkgQEAgaW50IF9faW5pdCBhY3BpX3Bh
cnNlX21wX3dha2UodW5pb24gYWNwaV9zdWJ0YWJsZV9oZWFkZXJzICpoZWFkZXIsDQo+ID4gwqAN
Cj4gPiANCj4gPiDCoAlhY3BpX21wX3dha2VfbWFpbGJveF9wYWRkciA9IG1wX3dha2UtPmJhc2Vf
YWRkcmVzczsNCj4gPiDCoA0KPiA+IA0KPiA+ICsJLyogRGlzYWJsZSBDUFUgb25saW5pbmcvb2Zm
bGluaW5nICovDQo+ID4gKwljcHVfaG90cGx1Z19ub3Rfc3VwcG9ydGVkKCk7DQo+ID4gKw0KPiAN
Cj4gQm90aCBvbmxpbmluZy9vZmZsaW5pbmcgYXJlIHByZXZlbnRlZCwgb3IganVzdCBvZmZsaW5p
bmc/DQo+IA0KPiBUaGUgcHJldmlvdXMgcGF0Y2ggc2F5czoNCj4gDQo+IAlJdCBkb2VzIG5vdCBw
cmV2ZW50IHRoZSBpbml0aWFsIGJyaW5nIHVwIG9mIHRoZSBDUFUsIGJ1dCBpdCBzdG9wc8KgDQo+
IAlzdWJzZXF1ZW50IG9mZmxpbmluZy4NCj4gDQo+IEFuZCAuLi4NCj4gDQo+IFsuLi5dDQo+IA0K
PiANCj4gPiAtLS0gYS9rZXJuZWwvY3B1LmMNCj4gPiArKysgYi9rZXJuZWwvY3B1LmMNCj4gPiBA
QCAtMTUyMiw3ICsxNTIyLDcgQEAgc3RhdGljIGludCBjcHVfZG93bl9tYXBzX2xvY2tlZCh1bnNp
Z25lZCBpbnQgY3B1LCBlbnVtIGNwdWhwX3N0YXRlIHRhcmdldCkNCj4gPiDCoAkgKiBJZiB0aGUg
cGxhdGZvcm0gZG9lcyBub3Qgc3VwcG9ydCBob3RwbHVnLCByZXBvcnQgaXQgZXhwbGljaXRseSB0
bw0KPiA+IMKgCSAqIGRpZmZlcmVudGlhdGUgaXQgZnJvbSBhIHRyYW5zaWVudCBvZmZsaW5pbmcg
ZmFpbHVyZS4NCj4gPiDCoAkgKi8NCj4gPiAtCWlmIChjY19wbGF0Zm9ybV9oYXMoQ0NfQVRUUl9I
T1RQTFVHX0RJU0FCTEVEKSB8fCAhY3B1X2hvdHBsdWdfc3VwcG9ydGVkKQ0KPiA+ICsJaWYgKCFj
cHVfaG90cGx1Z19zdXBwb3J0ZWQpDQo+ID4gwqAJCXJldHVybiAtRU9QTk9UU1VQUDsNCj4gPiDC
oAlpZiAoY3B1X2hvdHBsdWdfZGlzYWJsZWQpDQo+ID4gwqAJCXJldHVybiAtRUJVU1k7DQo+IA0K
PiAuLi4gaGVyZSBjcHVfZG93bl9tYXBzX2xvY2tlZCgpIG9ubHkgcHJldmVudHMgb2ZmbGluaW5n
IGlmIEkgYW0gcmVhZGluZw0KPiBjb3JyZWN0bHkuDQo+IA0KPiBBbHNvLCBjYW4gd2UgcmVuYW1l
IGNwdV9ob3RwbHVnX3N1cHBvcnRlZCB0byBjcHVfb2ZmbGluZV9zdXBwb3J0ZWQgdG8gbWF0Y2gg
dGhlDQo+IGJlaGF2aW91ciBiZXR0ZXI/DQo+IA0KPiBBbnl3YXksIGlzbid0IGl0IGEgbGl0dGxl
IGJpdCBvZGQgdG8gaGF2ZToNCj4gDQo+IAlpZiAoIWNwdV9ob3RwbHVnX3N1cHBvcnRlZCkNCj4g
wqAJCXJldHVybiAtRU9QTk9UU1VQUDsNCj4gwqAJaWYgKGNwdV9ob3RwbHVnX2Rpc2FibGVkKQ0K
PiDCoAkJcmV0dXJuIC1FQlVTWTsNCj4gDQo+ID8NCg0KSSBwcm9iYWJseSBoYXZlIG1pc3NlZCBz
b21ldGhpbmcgaW1wb3J0YW50LCBidXQgSSBkb24ndCBxdWl0ZSB1bmRlcnN0YW5kIHdoYXQncw0K
dGhlIHJlYXNvbiB0byBoYXZlIHRoZSBDQ19BVFRSX0hPVFBMVUdfRElTQUJMRUQgYXQgdGhlIGJl
Z2lubmluZywgYW5kIG5vdw0KcmVwbGFjZSBpdCB3aXRoIGNwdV9ob3RwbHVnX25vdF9zdXBwb3J0
ZWQoKT8NCg0KRnJvbSB0aGUgY2hhbmdlbG9nOg0KDQoJQ3VycmVudGx5IGhvdHBsdWcgcHJldmVu
dGVkIGJhc2VkIG9uIHRoZSBjb25maWRlbnRpYWwgY29tcHV0aW5nDQoJYXR0cmlidXRlIHdoaWNo
IGlzIHNldCBmb3IgSW50ZWwgVERYLiBCdXQgVERYIGlzIG5vdCB0aGUgb25seSBwb3NzaWJsZQ0K
CXVzZXIgb2YgdGhlIHdha2UgdXAgbWV0aG9kLg0KDQpDQ19BVFRSX0hPVFBMVUdfRElTQUJMRUQg
aXMgb25seSB1c2VkIGJ5IFREWCBndWVzdCwgYnV0IE1BRFQgY2FuIGJlIHVzZWQgYnkgbm9uLQ0K
VERYIGd1ZXN0IHRvby4NCg0KQW55d2F5LCBpZiB0aGUgcHVycG9zZSBpcyBqdXN0IHRvIHByZXZl
bnQgQ1BVIGZyb20gZ29pbmcgb2ZmbGluZSwgY2FuIHRoaXMgYmUNCmRvbmUgYnkgcmVnaXN0ZXJp
bmcgYSBjcHVocCBjYWxsYmFjaz8NCg0KCXN0YXRpYyBpbnQgbWFkdF93YWtldXBfb2ZmbGluZV9j
cHUodW5zaWduZWQgaW50IGNwdSkNCgl7DQoJCXJldHVybiAtRU9QTk9UU1VQUDsNCgl9DQoNCgku
Li4NCg0KCWVyciA9IGNwdWhwX3NldHVwX3N0YXRlX25vY2FsbHMoQ1BVSFBfQVBfT05MSU5FX0RZ
TiwgIm1hZHQtd2FrZXVwIiwNCgkJCU5VTEwsIG1hZHRfd2FrZXVwX29mZmxpbmVfY3B1KTsNCglp
ZiAoZXJyKSB7DQoJCXByX2VycigiUmVnaXN0ZXIgQ1BVIGhvdHBsdWcgY2FsbGJhY2sgZmFpbGVk
LlxuIik7DQoJCS8qIEJVRygpID8/PyAqLw0KCX0NCg0KVGhpcyBkb2Vzbid0IHBvbGx1dGUgdGhl
IGNvbW1vbiBDUFUgaG90cGx1ZyBjb2RlLCB0aHVzIHRvIG1lIGxvb2tzIG1vcmUgY2xlYXI/DQoN
Cg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMg
bWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

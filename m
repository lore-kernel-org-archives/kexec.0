Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98EDC61D85
	for <kexec@archiver.kernel.org>; Tue, 21 Nov 2023 02:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M/uGWHjsAztxHvkocIiTpjWsaIK/o4xp9X7XsNQffLQ=; b=NYDgv86ngNNOlh
	Z71xCGe0mD1p5p1kERoqyC35W1PURjlqlV7zspiyzEhAkt4Uo2C7xZiBvtZkZ61BazThzw0DxAnuz
	qHRJfgyMgsECMOzrkktGbwD39pEXb1rmgQcJ5bjLW62zBoc34R+mtA2KI7jkqUMDgmeJ/a/YQIljn
	W3IbbLhjjd7a/OyENpYzWmTrygjYAIATun4GmRdmsjhRrHqKu4Slj2Q2vkad9Te9oAYY9P1w4tXPf
	YiErX3MwUzZjS6pJHoklsoQ3B60nRS+EcO4rY3SHTFo2ajTvB+3cQ+Ocnfr51Bh5ZXs9bP2UTWhsE
	2h4xCvvHwrcemHQj14GQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5GJ9-00FPXN-2X;
	Tue, 21 Nov 2023 02:16:11 +0000
Received: from mgamail.intel.com ([198.175.65.9])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5GJ4-00FPVM-2t
	for kexec@lists.infradead.org;
	Tue, 21 Nov 2023 02:16:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700532967; x=1732068967;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=C1l1zbDYO85gdzIttCScxRhhoUDz41tFNlBrcYIOB7s=;
  b=lBMMyp2T1OvXH49mg0Dp+zZJ1m+3rgblpE3XwwW9++Q3XmGJPQsiVfMk
   k/buUssI3GJuOFDIx99sNXafYCMsAIHUtGaqF0hU1IZdivNDHD8iLucMk
   dydkLvsF1jESpiDcx5J/ISE7zxDqmpzGvDxrQsdfz6pJ8XU73sQYin8Ov
   OzR4FZ/3Pb70blOwa45cZxyB6cFdvbwwDVkDqosr3Y8JW/pJHTtkzzvoG
   YU3fqKp3SRugbTLJoBbSIUqEz3l8oS2ElF0P9i0cYaEGboItDEwMjn0jQ
   HyQHEtSt0zksQbmPLZv08v+87LGb96DL+zhugDXLwQooG6EYLcfjyqw2C
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="10415184"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="10415184"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 18:16:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="716392486"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="716392486"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 18:16:03 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 18:16:03 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 18:16:03 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 18:16:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRLe+BHmORXrkgxPnipzp3qTy0Uqlkgk0wughu8HLhxybKedlovysUgLBZFnQmRPdunSw1AkG4h9EhX5in+T6Bo+dktUk+oo4uYIiI1OmVBzLkV9LE9GtaMdiD8eVwoUhEcgCQU8GOhhiqyxHh6KG21hx2+c7l/zaNMHwceUS2rRWGezACUlVVwKNaQYRmUweijQvOHzN20yDmrIeUgS5If4j8uhrjKegJZVDh5mgf7+4b2nE2UnXAV8ZF6ow0XYmqcaH6kcWgdlw7+qFVANgTUC7pqZ89wxbFVUF4UfVU8KlWGdgGN7/3s5zd7yKCZqXNvQOOWy1KAS227NdSNiFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1l1zbDYO85gdzIttCScxRhhoUDz41tFNlBrcYIOB7s=;
 b=MgEiiDX6lyVYjvn7kN773px/adDaZ8RXMR1UQ86RKilwZ0wgVMwRVMSb7YSbUY2CTt2HyJa/3BLZj7P1CprjrFsynFMPm0tmaO/makIs9mOHsT0w3CVLygz6LlvC03tVqqBMV4LPlbcENoVtWoXtLpSEhLtqxTZMTejkvDvagnt4t9azn944ELNaaSUkR3/qMYuKgAiVw7wRawq8UMXqEWinoHY1T9VoHzuX0YqMo4YCb4OjG3KWoK6tkIXeW2FBuIodYT3PEIZ9f/+s5Jse4Oy9g4GVHUZl75zjavcni9b7CxJHR5342H24Oe0eRvkOsma7jCwqGwUyHx++47HR5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ2PR11MB7455.namprd11.prod.outlook.com (2603:10b6:a03:4cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Tue, 21 Nov
 2023 02:16:00 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 02:16:00 +0000
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
Subject: Re: [PATCHv3 03/14] cpu/hotplug: Add support for declaring CPU
 offlining not supported
Thread-Topic: [PATCHv3 03/14] cpu/hotplug: Add support for declaring CPU
 offlining not supported
Thread-Index: AQHaF7t0uC/HCaCpGUa/jrwdAjWU87CEEdgA
Date: Tue, 21 Nov 2023 02:15:59 +0000
Message-ID: <dbb07c1ba14dc1bd3066aa8b784b884c67638ac1.camel@intel.com>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
	 <20231115120044.8034-4-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231115120044.8034-4-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ2PR11MB7455:EE_
x-ms-office365-filtering-correlation-id: cddd2a2d-d808-4451-cb00-08dbea37cdcb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AiyeAE5bLsjUBAm6z+umDxRZVi83dKHdhUy9JyeXyZwx5U3PYq23/4I2+q7pVFAiMTd8Ik4CvUVoRRNF/TJN6/8Z2nLfUXMEzUSAEceK7YYEWtOoBrV9jA9NEu3vdFVN3BJ9grmPTRkBY6C2M/kxwXVzM9leMlucbh8ga2URNxQYlzbmeOPm0Gf2l+GJ0QOx7hwvkK3iAi0CTVQZLGQN/C4c/ldzaVcG/EYSYJ54vH6PTVOgIwKIsAwBjVl3D2RmTJgxkc10YcCZ4q8w+cRxVu/L/zfx+aGPzXZz81qxKWHp3mYuWUfYaArlYWBgd4cU1y+8sdSy2iIbTW+KQOBWIEshoS/+Pte/7qUGsyxP8W4yy1Gl0QXEJr4VN6RD8tS555Gqr8/RXutXiKqlqjebsw/jIcMuLlsKQqSufv09UNQxvQXnq8Up78fInWLOcs4Un2o3dWzU2aYPA5tvP/LiY7mky4Z+Itck9BT+QsNN+1309t9l3oOT1NykXJs0fZWWkbwMyG03SppUS4nN7T9ovnVhwx6sbLLsXMv7iO8/UBPoiF0p6wdLncwVscWhPLRgI12lSkl2vCTAIpzqF9cRKXS62XCe8lHMoOSyoGMHkVYZZlNwls3uWa45DmJHdhTh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(82960400001)(4001150100001)(2906002)(122000001)(38100700002)(8676002)(8936002)(4326008)(86362001)(41300700001)(5660300002)(7416002)(71200400001)(6506007)(64756008)(66476007)(66556008)(54906003)(76116006)(66946007)(91956017)(110136005)(316002)(66446008)(38070700009)(478600001)(83380400001)(6486002)(36756003)(6512007)(26005)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlFpT1FwUGwzMVFSQTNKS3NpL1VDaUJtZWRQRnpDQ0NkMjhJOFBZVW0zd2xW?=
 =?utf-8?B?M2kxL01yZVNxdW9kdHduQ0lHTnAxdXBpVjU4L1dQRVA4WkpvVUxGek5rNDJu?=
 =?utf-8?B?ZHVSOHBqSWY5VTJvSHBiWWs0UEFnM0hNRU5rYTlBendsdnYvQUs3Nko5cFpC?=
 =?utf-8?B?WWFPTVUzY3UxWlRFbTE2bnhjckN1eUs0Nkt3dmVCZ1A4OTFERnp6cDhyY0FH?=
 =?utf-8?B?ak0vb1JaTVZJTWExTXlhSnIzVjRBcUVJbWE2R3pkUUdRbXh3SEhEV3hVVlRO?=
 =?utf-8?B?L2pFL3hqUXpQK29QYzN2cEZLN3BhdVJaK2dUREdXRDlMajRDWEg3N20vdms2?=
 =?utf-8?B?UGV2em5EWDFoNFlRbVViRUZpYmtrSkhpMThMMEZSYXU0QTlEUUhYWGZWaXNh?=
 =?utf-8?B?M3BCTEo3WjNGWVhxdDBGMGZhTkxjUDVXZ3hkQlY4cDViREhLVklla2k4cWY0?=
 =?utf-8?B?dzJkMjVsWjJoMWFiaFY0c3dURjJPL2tXa1lsYlhzYk5UcUFsT1JGc2ZhTUFD?=
 =?utf-8?B?MHNxc29nY0pJcFkvOEZZRWFTUEI5Yitvb2pBNGtjZUtVbzAyYVVKMjR5UTlo?=
 =?utf-8?B?M2lRMXVuUDF1T011ZlNxd2Y5aUhVQjZrUklVTkdlVU4vdk02eGYwRFp1c1Jh?=
 =?utf-8?B?aHJjN01jTzl0TjNFV1VjdHFjVmhuTlNzTzR1Ym5DUEhtUUhCd2JvYWcrWW84?=
 =?utf-8?B?N0dQRHcwcmFqU3JhYzNBeEpOT0J2YTBFblN0cmlLQ2NQRytqQ3QyUDE2OEs2?=
 =?utf-8?B?NkIrSS9PRTRzemNLZGwxR3BiV21vMkFpZjZQNCtlQWU3eSt6RTlmTThEdzFM?=
 =?utf-8?B?MkhiSCsrWVJERkE4ZjI1cUtleWFUZGYyS3U3RmV4Q1Z2LytDWitFUkVmRDF6?=
 =?utf-8?B?Rk9wdXUrM2RRa3pPd1dxMTBZS0pEV2pPZ3h6czVPWTBYVE00aGxjdmdITnZl?=
 =?utf-8?B?N0RQVkFoMm5IUzhGU2xMQXFydm1qM1lOQXBxS2hxWFFWQTZHSFRYWmFrWC9y?=
 =?utf-8?B?bmRTcXdlczkraUFLOGJwaHQ2V1hib3dEQVFzUEpmS2pMUlN5QzJHM25ySVRW?=
 =?utf-8?B?U0lXdkFzK3crY3Y4NkRFWnlmUE0wK0tsZVVxakZRWGxxcUlHMlVsaWVZMnp1?=
 =?utf-8?B?d0JyN3prV05uY0R2K0M0cDJFNVFKNDFtUGpPQkhxWTZLMkwrVUgwdUJna2FB?=
 =?utf-8?B?dVlaV1h1VEpqL1NzTG91ZzJrQU93ekNTMkxySUNiNHdtYTg0eWxRYTY0RDd5?=
 =?utf-8?B?VnRnZEYvVlA4NTN4bmg4MzgyMXQ0dUhzOWFrNzR4eHlBY3Y5N3p5NVhPZ0lU?=
 =?utf-8?B?MkVMcFFTL0xqUFIrNUlNRGVaMm1CV0lOU1ZsU0NwTUhzdjI1NkMyK2ZNOXdB?=
 =?utf-8?B?MHIwODRTT3YvVnd2aXQ1a3ZSWWZHaFAvMy9qNU9NWXpZN1JNa25iT3hVdXUr?=
 =?utf-8?B?M3dBbDFNUENZaVZEOHlENGc0cDA4L0RvMUR1VW53MVgwclJsSlIrNStnOFhm?=
 =?utf-8?B?a2hvWE9jMnlMQnNPQ05sZ2tDVWgrU054RmVBd25QeENEbU91c1FxdzV6WmNP?=
 =?utf-8?B?T3NYS2ZCS2h0TVpXOGhHR2lGRlBvdTd5OFJIcFJoL0FGT1BHbHJRQ3ViK0FU?=
 =?utf-8?B?dGtWL0ZCUFBtSWhwWU5vWkpKaU5YSTVscTNrbjBJWWt1VWNqTklWdGhXcU9r?=
 =?utf-8?B?K3hocnlQZlJNSUlTaE8rck9iK01BL0dhZ09VeExjcVU1RXg0N1JnZWdaUzgx?=
 =?utf-8?B?ckY5eENIdFN1R3R2R2FCQ1JMNGhwVDFlQ3dFVGEzblNIWGw0ZHpmZjM1blY3?=
 =?utf-8?B?QnNJNzM2YzB3aWJhSzEvM21CbS95VzdEYUNrU0UxMTFORFBjME5KVUxVN0hT?=
 =?utf-8?B?ZXdXVWN6NU1DZWZ6bXZ0WGZwUlNoS1ZhUkxyWDJYUGZBSXp5dHJMaXpra0Vm?=
 =?utf-8?B?WitIaXhqSEFtWFU1QWdEdGF1a3RjdkdRblNPdG1XMFdJc2VTWkwwMDYranAz?=
 =?utf-8?B?L2JlM2d2R3kzRG90SXNvYnJYUkR3bTZpNTlWR2RQUlZBV29zYzdOTjhGM21C?=
 =?utf-8?B?VjBtQUxDa2F6dmJkQmZNMmw2UTJKV1JHbjdPSHRnam50RHJKV0dlYmp6VHU2?=
 =?utf-8?B?NW1wN2FqcWJpdmZiVFRkcUtGZEkvRWRGUXJJVUI0Qk5PSFlUL3Yrcm84Q1pz?=
 =?utf-8?B?SFE9PQ==?=
Content-ID: <14CAEC77AF43E743AE9D2350C8022D38@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cddd2a2d-d808-4451-cb00-08dbea37cdcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 02:15:59.9811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FoYpq83fSZ+LUcQy0bBbzBfMrtDu4XGRBdCs48gB9BBrw4ZYAfeLs/vM3BmmuRn28mkVhBTNqXOmj+gPMl9yGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7455
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_181607_069747_D2A7E5A8 
X-CRM114-Status: GOOD (  25.84  )
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
> The ACPI MADT mailbox wakeup method doesn't allow to offline CPU after
> it got woke up.
> 
> Currently offlining hotplug is prevented based on the confidential
> computing attribute which is set for Intel TDX. But TDX is not
> the only possible user of the wake up method. The MADT wakeup can be
> implemented outside of a confidential computing environment. Offline
> support is a property of the wakeup method, not the CoCo implementation.
> 
> Introduce cpu_hotplug_not_supported() that can be called to indicate
> that CPU offlining should be disabled.

cpu_hotplug_not_supported() -> cpu_hotplug_disable_offlining().

> 
> This function is going to replace CC_ATTR_HOTPLUG_DISABLED for ACPI
> MADT.

Is MADT too generic? MADT wakeup?

> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  include/linux/cpu.h |  2 ++
>  kernel/cpu.c        | 13 ++++++++++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index fc8094419084..46f2e34a0c5e 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -134,6 +134,7 @@ extern void cpus_read_lock(void);
>  extern void cpus_read_unlock(void);
>  extern int  cpus_read_trylock(void);
>  extern void lockdep_assert_cpus_held(void);
> +extern void cpu_hotplug_disable_offlining(void);
>  extern void cpu_hotplug_disable(void);
>  extern void cpu_hotplug_enable(void);
>  void clear_tasks_mm_cpumask(int cpu);
> @@ -149,6 +150,7 @@ static inline void cpus_read_lock(void) { }
>  static inline void cpus_read_unlock(void) { }
>  static inline int  cpus_read_trylock(void) { return true; }
>  static inline void lockdep_assert_cpus_held(void) { }
> +static inline void cpu_hotplug_disable_offlining(void) { }
>  static inline void cpu_hotplug_disable(void) { }
>  static inline void cpu_hotplug_enable(void) { }
>  static inline int remove_cpu(unsigned int cpu) { return -EPERM; }
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index a86972a91991..af8034ccda8e 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -484,6 +484,8 @@ static int cpu_hotplug_disabled;
>  
>  DEFINE_STATIC_PERCPU_RWSEM(cpu_hotplug_lock);
>  
> +static bool cpu_hotplug_offline_disabled;
> +
>  void cpus_read_lock(void)
>  {
>  	percpu_down_read(&cpu_hotplug_lock);
> @@ -543,6 +545,14 @@ static void lockdep_release_cpus_lock(void)
>  	rwsem_release(&cpu_hotplug_lock.dep_map, _THIS_IP_);
>  }
>  
> +/* Declare CPU offlining not supported */
> +void cpu_hotplug_disable_offlining(void)
> +{
> +	cpu_maps_update_begin();
> +	cpu_hotplug_offline_disabled = true;
> +	cpu_maps_update_done();
> +}
> +
>  /*
>   * Wait for currently running CPU hotplug operations to complete (if any) and
>   * disable future CPU hotplug (from sysfs). The 'cpu_add_remove_lock' protects
> @@ -1522,7 +1532,8 @@ static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
>  	 * If the platform does not support hotplug, report it explicitly to
>  	 * differentiate it from a transient offlining failure.
>  	 */
> -	if (cc_platform_has(CC_ATTR_HOTPLUG_DISABLED))
> +	if (cc_platform_has(CC_ATTR_HOTPLUG_DISABLED) ||
> +	    cpu_hotplug_offline_disabled)
>  		return -EOPNOTSUPP;
>  	if (cpu_hotplug_disabled)
>  		return -EBUSY;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

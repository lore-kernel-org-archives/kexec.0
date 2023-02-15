Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0BFC05027
	for <kexec@archiver.kernel.org>; Wed, 15 Feb 2023 01:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Sea/yjhwXSTWQbdE/Lt8uVstDZGXgYYbhGUHJUjYWVQ=; b=ghBvyDpPDeKp/I
	Sa1cTIVqtYoSQOfxM4+gtlm0hR5vHAVXAmWmSS2sLPDGHHIWJ+u2Tze36+8xBk2LVznRPWrzisdve
	HFxucX8PMQmNN9OUqQmEjEhEBJoH+u0FoDG2DKERf8d5V7/WgBe5VoJEpUkjUhsLPoyzS3TfJDIo2
	khNgs+lKS8zPNrslAJVRmLPHuRKUyrOTZs8Za9o15iwCXUhscisJBezuTnoTh+AFsyT0LdvfnQ4CW
	eX5UnvzXj8tzEIJqsWSdpHEDsmAtA8UBCl8yXqgy/Ozl1RGbcoRN0U8WA911i5Mqwgi3vW2yQp26n
	fFB/Nld9No0XN0tR+7nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pS6zD-004KK7-06; Wed, 15 Feb 2023 01:53:31 +0000
Received: from mga03.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pS6z9-004KHP-AP
	for kexec@lists.infradead.org; Wed, 15 Feb 2023 01:53:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676426007; x=1707962007;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YjzMRrr79cvWHhnzBj3/lDYHN5uz17MKB6Bd7+tQo6I=;
  b=Px+5v7VaHkUA6zlad9YAgYSoWnGmlizf8uWnGX1Dfut4Qm9s99IbPVg8
   AvZBTH9OCPevv+lXQau4jRoCQJALxlOFHAPltEqDQSFduPbm3QhP89Oo8
   QNKcqujIdO3HAJ/8onjvjlNjWGHjyVOQZPTV8QJTrrkauwWfRzFkLq0j2
   AD+zQqcDQ8pc5BUa4//vRUv9vQWltfZ12XM/iM4z2aeMRcBQr9p1N/e/B
   HK1Dzq0HB+ORUFwyx8urNLZeywXFxKuJkGdm4IJrQHpNHxEX/QT00S4MX
   6LYbSUm38J8o2vlWk6t1vYimNhvv/rJlvKSss7QwLkSQhIGuRpKS3OxLE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="333457966"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="333457966"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 17:53:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="733099146"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="733099146"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 14 Feb 2023 17:53:22 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 17:53:22 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 17:53:22 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 17:53:22 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 17:53:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxZZ8y9MYQqNSikNNQgDesPlEsLIRxqBixxiHse4OQBRtEa5iOzgDHowb/xSn+hti1Zrf3jUIH/dU+KEAKV6bUKBN7yfatYBSAXjKA7FtxEH46ZzGKy+E0K47ZaWjSmM2q3Q/p2KNdSDHg8NYhrT1HAlfG54QvWRWcRU9K1+8N11eAxBMkgwYiAfQwUNUb5GoVEAB1aTlUmmfv8Q2VJvF5IW+M0J97mvZJ58S/96K+ggZh2il/28D40BVB5GRA8RXYjYfONWzwDx4/gMdGyD0/ImdvcPXChCw9j80Kx3f4twSpiiMLy5+BESfvQP28iZX5FYjYQ+5JkgEWVE0idNFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjzMRrr79cvWHhnzBj3/lDYHN5uz17MKB6Bd7+tQo6I=;
 b=HXbi0aHfZgfKowfQNaIX2zuINNAgwe1mf3uWVo9f3PnbX6CqJ5P9FiyMWkj8OgQx9aDyl8bvtyghMPqRVs1UdIqxlWoTAnoKvHT9K20ixh50HI+F17/oXesgrd1DCfhk9BawCv8iCvXSeAZ0317BOhhjxrgBD/uk4H0TUPLkzQZsYyi3+5j5t/KhcRhrcixt6ipIziywaQjHS9ij0E4WJ1j9uZrfN4noChatctZhXtnpxcu5hq9UIh9bNwjJJGOUMPDgoK4oFB0SNPzWIxNms11JDJVmcOvm2PxhE+FtADirHc3b2vjbY+Q852YtfSf999RD+XC2YB0QIrXqsH1MJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM6PR11MB4561.namprd11.prod.outlook.com (2603:10b6:5:2ae::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Wed, 15 Feb
 2023 01:53:19 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3f19:b226:ebf1:b04a]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3f19:b226:ebf1:b04a%7]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 01:53:19 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>, "bp@alien8.de" <bp@alien8.de>
CC: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Yamahata, Isaku" <isaku.yamahata@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 2/2] x86/tdx: Convert shared memory back to private on
 kexec
Thread-Topic: [PATCH 2/2] x86/tdx: Convert shared memory back to private on
 kexec
Thread-Index: AQHZQAXD7tsyIloqhU2IdZsgp2Dap67PQH4A
Date: Wed, 15 Feb 2023 01:53:19 +0000
Message-ID: <39b41f5b5852c5e9d23acb84a4ed4d9bf8a7c092.camel@intel.com>
References: <20230213234836.3683-1-kirill.shutemov@linux.intel.com>
	 <20230213234836.3683-3-kirill.shutemov@linux.intel.com>
In-Reply-To: <20230213234836.3683-3-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3 (3.46.3-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM6PR11MB4561:EE_
x-ms-office365-filtering-correlation-id: 9a42e274-a81d-4da6-0795-08db0ef7697c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VSGvgC4PrsHVO0rVjVCNrxXBGlFGLZK2pSc6mZhEZudcnjXI0rLRnwVUVnz48Vy1uGmarL9pVTH/CeRYyAanvqIgVAT3rBQvemyg6Lz9VqnsT4zsKnuCgNNcBYPcr7guzCXp0Ro7dK3X0eAhAHTjxGuKn3yWKZeJ0levR433ezRn/47zywGvFwEGd8MUEZDRMGzQlslKv/+Ogi0IKYa3IqBtcDIuXSMUwEJbR+Aj4GnDoaBVjELZxELKEQBF9jG4w2lHTLdbuUG8E6BMGCcbsU5tQn4LCHvyWCuN981AURT2QCpC//k/qVoIvAydWhorjQQFHMi8P0AY04BX+vFlbxncnPVeWTNIE93zB/SpvObqIgddPOzWfLCrGcjo3XocYJeqPzQaXjH/QCl9WVn7+8YbpuDQp59gygPrDxnt6PTCWuipup++5UMRj7CA/xJ//11NsELdhq2VVfOKxlcYuGIsctqz6mWZy/UFSCsN4WtWDQ4kqXWhgSpUsxv772Gq8OMmnarbXpL6hMw4TmL2zVySE6DAo2aS5AIO5F+hydqaOOBOfrEh6SJRQln+ziH36ezZL5ApTwJiWUrtZf8MX2xAW1aXjAcRKZfFxJeKoHm7gNywl2fuZur0zd+/r+U5NqWQMomTuojkiQB6UKA98qm3lteIUuYWKOdTG+C4ufebQKisz7R4AfIMMl3PkUGP0MxB4ENzHLNsLBUBMMRTFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199018)(82960400001)(91956017)(66946007)(38100700002)(76116006)(5660300002)(66476007)(4326008)(2616005)(6486002)(38070700005)(41300700001)(36756003)(71200400001)(66556008)(8936002)(8676002)(64756008)(478600001)(2906002)(110136005)(54906003)(66446008)(316002)(83380400001)(26005)(186003)(86362001)(6512007)(122000001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDNYMHNUZHlJOWdNekE1Wk9MQkp4dGZYdTNjT3RJbU0zcVdNbmdoMmYzWTNG?=
 =?utf-8?B?WVJxS3B2U2p4WU12aHRjaGc3QVgvTDlnS2JJK0l3ZVAwOVpoaU90cnl0SXFG?=
 =?utf-8?B?TWRzcXFCVytwR0MxU0tHazQvd2M3WnFRMlIxdUs0UVc4RkFoL2VTVGRBUmxS?=
 =?utf-8?B?TUVJV3ovU3VBanpyRTBUUFlvOUJQREtodzYzT0Q3ekJzSzgyd0s3eGQ4OGgx?=
 =?utf-8?B?NGIxSlBxV1ZENlVrWTlYaWlxL25tRmd4QWd5U1MwTStZSUhIYlZNVlJXZ1dp?=
 =?utf-8?B?bk1uazI1SXRJNWhFMUxjMjlTUml1ODYvWFZqSzA0cVVSQTF2b1lhazY2NDNs?=
 =?utf-8?B?dzlJWWpNcEhtQnE4aEh4SlpOWE5oQjNrUi82TkNrWmNFZ0xBSnhnZW1sWDRR?=
 =?utf-8?B?eE5hbXZBWEJpQ3dsMzVhZVVYUTJRRmdLeC9xYmVMWm95RU5DMDUrdTUvb2RP?=
 =?utf-8?B?SXcvdVZrWHlwYm00QXpRTTE0NDRUTG1qK3pqOVZjUWJqaEsvUnB3Q201K2JE?=
 =?utf-8?B?SmRsa2tGZXBneE4xeFY5a240bGpEemJRMUViVnNMUFFKUDFzZDEzRGN4ZDht?=
 =?utf-8?B?MTNZd0N2b21qQkdwdXVldUpWN1d1L2VXYThGbTJ3NVZiS3Yrc1BGT2Z1T0pq?=
 =?utf-8?B?WUMvWTdvWCtmR0pqYVFvVjB2VlBzTVU0eUt1aDdTT2hpUUVsVlk4dXlyZUkr?=
 =?utf-8?B?K0RxckpwNnpTUXU0YWs0UE05NHgva3hmbC8yUnBKUmxIazRqTXl4M3h1N1BB?=
 =?utf-8?B?KzBndUFXNHJIbFlhSGo0ZVAvemZOUGdTU05OMFB0SDh4VEg5QjcybityeXNN?=
 =?utf-8?B?YW5MeXg2MTVORGdwVUxveDQveUtMUUhqWDU3emVocDhkaVo2di9hYm1IaVh5?=
 =?utf-8?B?U2xrd3JnK0lhZFlRWE9UbTVIWTNXczVWZUFZU1lKcXY3MUJGSWRxQmUyQ05Y?=
 =?utf-8?B?YmVTdlFzUWoxWVVNazlKWmFqZisvTEdXMGlJZE82eTVPSCs3a3JQeVFvSkFM?=
 =?utf-8?B?OXJqUzhzVkozV3cvK3piUFRMbyt4NzVma2pHekIrN3ZrYlNZOVNUbG9FZFN3?=
 =?utf-8?B?TklhSTJqZ05LRDVTTFIxM0wvNUdPNFNnTXFLbG9tMVFhVGJmbEFuaUJrblV2?=
 =?utf-8?B?eTUzY0dvVEZ4VVBnbkhQdE5tcHQ2bVZiK2Njd2VqckVhbURVdk5XelhnbDhi?=
 =?utf-8?B?dmE0Q1BLdnBVQStNOTFHcFA5VzU0MGg4QTBmTVBQbGNpcXBpVVUwVENwRWVS?=
 =?utf-8?B?T21IY3NOdmh5NnRNTlFDY2lobG5iWGo2U1BERlVaVWhVUFdBZVQzRk5LNlVF?=
 =?utf-8?B?WS9SaEJuMFJJVmcxR3JKZDB6VGkxT0dqSUFocE9vdUVlOGNoelpHSWpZMmdY?=
 =?utf-8?B?bkpTWTNoeHQ1bklBTWRVN0tFeGpVWmlJeUhubk9SNzZFZ3pIRWZoN1E1MTli?=
 =?utf-8?B?NVFWQjJpbW0vYWZ4NndRUnZkRTB2ekhxVTRpa2dUR2VVc3grMXR0V0FpSDQ5?=
 =?utf-8?B?N3I2K2VrL3Jzand0WVNiVnBtdEhCVEdXWDZGb25LU1hsNHMzRXkzT2QxMVEr?=
 =?utf-8?B?NDZLeHI1ZFAxMisxUVZoT0NlcDBqbHp1UHdjZ0FZcDdRUnR6VFRXUkdqZWZi?=
 =?utf-8?B?QWVTQjQxek9wVnlXYzJlMjUrMkFmOGFaYWp0UE9ReWhBVkszKy9PeVlkbVJT?=
 =?utf-8?B?WjJ1cGhMOGlhT3BiRVg4QzdPVGxyWXVjbXhKL2JUK0hiVXN0cUVDVHpMajNy?=
 =?utf-8?B?TUhQU2svblllNWVLWjg2cjRQM093OEpCTUFyeHM1NFdoeEsxN2xrb1JhbElE?=
 =?utf-8?B?dkZZTjJuVDM5MHlGWTA5Z0JiL0xZMjJGbGF4NlIxSXBsNVpiN25jYVJMVWsv?=
 =?utf-8?B?WlA2ZC81Ynd3WTZBd05FcEVBeXVPTFZwcWQ1bXR1Z0RmdXNUWFBzczFuODJp?=
 =?utf-8?B?TWFZZmRTRU81ZmVEeGY2TC9IQStWT2hJbDVReWxVS09PSjhtSURWdEdvS1E2?=
 =?utf-8?B?dXlsdGwxMXJGNVV0QXNITUpVRkk4aW9mQ29KckRnQ1Ezbk5Wai9KUmRKWU9R?=
 =?utf-8?B?MXhXQzRNdHArKytPdVhRUnE1UjNWVjZXWmpFbi9RWHJQc1NoKzZBRzU3ZVdV?=
 =?utf-8?B?dUthWE5YY2hsSTNRTmRkdFlvOTQ1dmZvZ3d0eEI2TGxLSTlZSzUxS1djTVhO?=
 =?utf-8?B?T1E9PQ==?=
Content-ID: <84C0A106BEDF754AB6C2B2D0730CF993@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a42e274-a81d-4da6-0795-08db0ef7697c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 01:53:19.2035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qT4NH8sUdf2GlhIIg3uxMI87Zbk1HWYA+gSDatyK5FtZiQKnIFeE42DfkBJiN1ymwVweSoNAEIuYdhA6IeEh8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4561
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230214_175327_426717_15E65F0D 
X-CRM114-Status: GOOD (  13.14  )
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


> +void tdx_kexec_prepare(bool crash)
> +{
> +	/*
> +	 * Crash kernel may want to see data in the shared buffers.
> +	 * Do not revert them to private on kexec of crash kernel.
> +	 */
> +	if (crash)
> +		return;
> +
> +	/*
> +	 * Walk direct mapping and convert all shared memory back to private,
> +	 * so the target kernel will be able use it normally.
> +	 */
> +	mmap_write_lock(&init_mm);
> +	walk_page_range_novma(&init_mm,
> +			      PAGE_OFFSET,
> +			      PAGE_OFFSET + (max_pfn_mapped << PAGE_SHIFT),
> +			      &unshare_ops, init_mm.pgd, NULL);
> +	mmap_write_unlock(&init_mm);
> +}

Looks the page table walk is done unconditionally when !crash.

I think it's better to check whether this is TDX guest (either this function, or
below in machine_kexec()) and just return early if it's not a TDX guest?

[..]


>  /*
> @@ -312,6 +313,7 @@ void machine_kexec(struct kimage *image)
>  	local_irq_disable();
>  	hw_breakpoint_disable();
>  	cet_disable();
> +	tdx_kexec_prepare(image->type == KEXEC_TYPE_CRASH);
>  
>  	if (image->preserve_context) {
>  #ifdef CONFIG_X86_IO_APIC

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

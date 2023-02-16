Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EF3C636CC
	for <kexec@archiver.kernel.org>; Thu, 16 Feb 2023 17:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E/EfmeJR/VYqPDR+Ow1n/dBE1oYexKfX3gynt/z5Iao=; b=wDEyzbAcXkywYM
	4eibBwEpVwbvwcwWB3dmHsPHSw2fqC+fWfvY1ewrXK9pRPiseC7epvpIdJYAgab63K5EqmBr5ejQs
	zH15uikpWdgLzmZHNZr0Ae9iwfF/+WA2pwtT03ZMZ/RW6IonBBgCI8Z+hM30z8Vy+M0isTQm2ZZG8
	CdrO6RF5kl/UrgU1jL2k9QLTFOMxxN/+zHGWT2IsBkFit5QcyWDSsOIspIC+X3XVuA5AAckFTzij1
	ncQkarL7fxir/ODyMUO9ziibpqMJxi0diF6ZJ/7BTAQhTdpE6Yit3GKoDRu5Pw7F9RpkpJL8jVeux
	XwOJje+n3HSH5GYUs3Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSi8x-00BMid-UT; Thu, 16 Feb 2023 17:34:03 +0000
Received: from mga09.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSi8q-00BMhb-Tf
	for kexec@lists.infradead.org; Thu, 16 Feb 2023 17:33:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676568836; x=1708104836;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UzbIOQNSNOGdkWlHafBkexNj5aSMrrOBqxZ5tF8sfPw=;
  b=IF3BhJ7GRleiKe8wtGZAMaZnsBMoqDlO19pn3ZRglZ7dRaSgqDpcMB4q
   6TC9LXqW5WB6zv6DWlU9pqRYanaTtn+oG4HDXUtYGN6I+tUAkdlAY0MDa
   VEIrzAl9volsmmGjDgzNb2DjuMMDoB1RsYQVaa3dCVdvNiQrzfvJbb2jh
   znoy3dkIm2CGA8Pdn8lkFBUUW+4WmfqYHrRXAVk5inMzpTtn0KhGoevYu
   EE0TYbE8EC/kiOteAV1N7mtKQGDSBMimQu+gLwnIT3DG0zj4HvaWQGGEh
   s/mGcIWu95eVcAqKxt12JbJhC56vBX5+++7UD+lvMkA2+yvp1ZFhD1aRs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="333132016"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="333132016"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 09:33:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="779440793"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="779440793"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 16 Feb 2023 09:33:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 09:33:26 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 16 Feb 2023 09:33:26 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 16 Feb 2023 09:33:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPdvChLQp5NPjBsb51s8nKF2Dd4fgluTYwFkuc+rEhRqX5CeI/bvIGGA4ddAhR7kFRRv15KAa8GbY4+SYYlhiIczMJRfzeRXLxTS4dZV5GJZwgCvnv0nTa1mYD8pR+GhEEjKeSRxH7nLWJ684zPWlXkO5UY1PQB571MBCzPKdgzukSIHW7s5lA2QaqXt4t0oYhPTTQp71RT0u4/lsAnTnaicEUyRtIMwS2b3Pa8SJKv+S/nBvx4E7HCNqcwVFlIM/2IGbzG/91p/sY4xkb+YespJDo4fDVlrSXXZPCb9RGguzau9BSYfiT9SVA0oI5kitGEKYhQlbvyFslsYyVnYrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzbIOQNSNOGdkWlHafBkexNj5aSMrrOBqxZ5tF8sfPw=;
 b=g56sToyI5N+oKrGa/SXXLE2i9By1E7z1+uBGwWhHnkLsWJyUCtc4A4z4MJm0aG951Fm75ViK7Qxf90JzJUHVSPPZrMu8kcNHQ/eYW7OeJNPgYcQADeJB+qvyUOkYNcnSOw97n/ZUPwD/7NrP+6J3AJGG26GbygptCjWSE5lo0okdtaijMSzIv3X/ODTYvv0ZxvfSuEIlYIIz8+Gtos4WwayCk2mGtcBRUpTJ8Y2bUGvxbnzuL3OmEvm0JjCTdxpv2RWy2OIvJdjNkPBoOLmkfb29E/km8/5+/o3FaQB5/BTcaUy+t3THTwrAsoHgAf9cWsUX+yCDDPVvkOtzRFrJow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN6PR11MB8241.namprd11.prod.outlook.com (2603:10b6:208:473::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 17:33:22 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 17:33:22 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kirill@shutemov.name" <kirill@shutemov.name>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"bp@alien8.de" <bp@alien8.de>, "Hansen, Dave" <dave.hansen@intel.com>,
	"Yamahata, Isaku" <isaku.yamahata@intel.com>
Subject: Re: [PATCH 1/2] x86/kexec: Preserve CR4.MCE during kexec
Thread-Topic: [PATCH 1/2] x86/kexec: Preserve CR4.MCE during kexec
Thread-Index: AQHZQajuqwnKk7a2c0Cd8swcb05FJ67RUvoAgACDOQA=
Date: Thu, 16 Feb 2023 17:33:21 +0000
Message-ID: <69763ade82cd7718e709547c977f354dd324e6fe.camel@intel.com>
References: <20230213234836.3683-1-kirill.shutemov@linux.intel.com>
	 <20230213234836.3683-2-kirill.shutemov@linux.intel.com>
	 <bcaf4b7121e20ba27dd2cc2b347feb35ae7bfa53.camel@intel.com>
	 <20230216094340.bl3k5q6ine2luhoz@box.shutemov.name>
In-Reply-To: <20230216094340.bl3k5q6ine2luhoz@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MN6PR11MB8241:EE_
x-ms-office365-filtering-correlation-id: 82956a96-761e-430f-2651-08db1043e66e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fq+iEKOAHnrtG9Xg2MzjlSvoPEUUEfMxjVL+ySykCSFZLMcRieWISVe+QJM27W+rJkLhA9xeHigndayjcEfqpjmQ9+Ps2zfTStwVo4B8i/JGWDBe6CprU/65b0c2GIEWSAJ2fFiitpfWZCAs9Hb1l8KBEEtJzONVpdeQqaV7wSIpPz1DuNH2+Ljpa0F9G+bVlwk5RqOgN44MJ1RyvkqFYi36/e/5VK9L6wSM+VQEU4oDPqW0o7qBDuwEZMD+T0TaNJAR4UM1WuqAEtUpf8NAlwf74spV0XGyl1sqI7zGNSRB2U7/7bOY9NDymLwyZ1mRM/Wc2wMNZiZFp+NvRspLkaY2ZWYYtKKa2TuT54k7AKQ1AlkY5Nv7frLRvBKbryZhtxnVNRMpXmWigyIOblhWp72v9kJvO/oJ8+Le7LnIId5guQS5/8xZYCXcNYY07alpSWpYXzFrt37m8phItlL8H8a5OToJplm27TobgwPaGEIrA+RoRebGOnCnqMmglyNJnorD9E7QwS+ScTlzLWy14MPXlA3gi+3r242F6sMd4HlVGeLJvp46JogJbhkepRIcNgnFOzEcjH0jAPMx8goEeFCfA0vyhkCw1MN9uThkHthM+mllDl+xKweUT819tAsHpxGsiXPQX0gg40ESO7JLOEc/GfPlkAxIKJMv02RRhs2Q7wr2WFZlC/9z8geUKel/WfXuMt1gIx5d8bfHqktHxhzATINTehfKJL9NoShUR1E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199018)(5660300002)(8936002)(2906002)(54906003)(66556008)(76116006)(64756008)(8676002)(6916009)(478600001)(41300700001)(4326008)(66946007)(66446008)(71200400001)(66476007)(316002)(36756003)(82960400001)(2616005)(38100700002)(122000001)(6486002)(6506007)(86362001)(186003)(26005)(38070700005)(6512007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVZOUGtyWHRKcXBkckxEbGJJVGxnV2FpeGtHZU13TjhyYUNMVEgyNTdZMDlm?=
 =?utf-8?B?OXlrVUZjRlN3QmttbFhGeVJDQ1BPU1VUUVVvRHRlU0NaNC9za29UbWRTd0V3?=
 =?utf-8?B?MzNxNHhFV1ZHVGZuQWY4L2J4NUVoYmgvVkplZWJBLzdQNXNYeS9SaGVuTDVy?=
 =?utf-8?B?SWNHV25FNUhqdEp0L0dRUy9qQzVSeXh3WTAxWTJxc0w4ZUdUUXN1L3pnNVRE?=
 =?utf-8?B?TnhNNFdoT3AzVUh0RFN5bzAyd2JkRFNick80cFVvY2hWVWg4MlhoazFvRy8y?=
 =?utf-8?B?aFRzcnBoenlPemNIdnB3UG4vL3h1a1phekZ1Mkhjb0wxelZMUkRENUFSZWNh?=
 =?utf-8?B?RDlwK2dNZWxDSTJ3bmdWeFB3aTJzbXVTYWp2bFh2YmJQQzdzRHJ5VTRla3Vr?=
 =?utf-8?B?YUpwWU5UdzUrTDNvVS9tcGxEQTcrVnI3N0RoWjFORXcyVGc0UDBhVzV2UXc1?=
 =?utf-8?B?RmVxMkJ1T0t0WnJiVWpFcFA1RDdQbzBJRWVMZjN4ZkpxUXpabWVuUWc1dktJ?=
 =?utf-8?B?Uk5vZTBXRk5DMUkzdk9BbXhTaGZzYjlWZmJ4NTY5eXlMRUlXWlRMZHdzUCtH?=
 =?utf-8?B?VFdQMC94Z1JVbTRlUWFiRFV4K0FIZERIc054Z3hnK0trbUpNYlhwSkxYOE0y?=
 =?utf-8?B?eFlaRDBsZy81VDBaQTFIemp2OXU3Y3lWVmNrL2lhdUJLK2xnL1Z1RmV3ZUQ5?=
 =?utf-8?B?WWRJQklhMUltYVdUaFdwM2kxWDMrRUpHM3pTWGxBZ1R6azU3SjMycXBvZGpx?=
 =?utf-8?B?Sm85K1IwbkVlWUJJUW9yd0VYMjA0bEE0algrSHVSN1FUYUpWM1VQTXNLUGlJ?=
 =?utf-8?B?ZXFZUXN3T1oyUWM1dmdYTStqZG8wdVNRdVQ0YlQvNUNNYnNwdmRpS2E4S0c5?=
 =?utf-8?B?SGJNRERMWXhoa2tKYlNJa1M0dGxUZXp1cEdqd0o1VVlQcWtCRXpIcUE4djVP?=
 =?utf-8?B?bk5JTXNiOGVXU1lQcmJ6ZUdtVVVKbjhZUnArZHFHODFlMEp0c0h4SmZpT05R?=
 =?utf-8?B?RThBcERlVExYbjN5eFcrcWlWNnhGYldnTDJQV2tKbTJ4clFWaXlCbkRyenV5?=
 =?utf-8?B?QUU0UFdyYzdZenlRcSs5SENLclZOMXB3V3V3eGpWZ3o2ZWk3djQyeTRuWmhk?=
 =?utf-8?B?Rkk0OWxwMTBVTU43cWhLRWp3Nk5HaWZzUmdrdFZuUS9BSys2Ym5hUnNQSFhQ?=
 =?utf-8?B?QnR4U2V6YlpTMjZRSUdZdDVoS0tCUTFDYVFiM0tBSkd4Z3B2bFdheVliQmtV?=
 =?utf-8?B?cHB2UHl0NUY3YnNFQjl4VU9pcHVlbi84QlVXSEswOVBzNnB1cE9KUS9zd3Zq?=
 =?utf-8?B?WE9UWE1yV0hpUDFyaUUzek1TU3ZnWS9YMlFvWm5YR3FKWkl1UTRkZm9Pa0VL?=
 =?utf-8?B?TVh1ZDQ0N2pQdVBsVWdxNkUwMWlOZDRQUkFYNTk1blVoT3FtczN6b21XQW9O?=
 =?utf-8?B?dElJQmNuaUNEY0JCbU0rbTdiUHJYaUtvaVlHYVo2eThONWVtVnZRSVRpd0ZI?=
 =?utf-8?B?SnpSV1A1UFJhMHNRamg0czZOZ1JOSVlLOXpLSUcrUUtDU0NGTjh5eUYrdDhX?=
 =?utf-8?B?dHRURlVYcG9TWnV3cC9TaVdOZXI3NzFwR2hTbDBzWHlXYlB4TGxTdEdwVy9q?=
 =?utf-8?B?Q0xXMFdPWElGQUY4YlhRQjhEL1pqTG9ES0pnUGpEdEd5eTZrWmRwaUowZjVY?=
 =?utf-8?B?WG5XWTFLbUR4cHRUYiszUjJOSGdUVXJBYTRldzhsWUxLZGZKSVBrMVdHZ2Iy?=
 =?utf-8?B?VDRsbjI4Mnk5Q3J2UUZ2cXhVM0ZGalNrWXNhTW1XdjlNcnZ1MlVMU1ZsbGc2?=
 =?utf-8?B?QVlCcjk1Sm4yUHZWeGtHNU44bE85akxkc0gzMGdrVjgzM1cyZjV3QlRFdXVD?=
 =?utf-8?B?b1RlUmpsb2tuN2tXc1d0bnV1SmJGVFQ0M0ZVcUZGL2VncDdCaGErREpxbHg3?=
 =?utf-8?B?ditHaHlqdWtIRjVjbk5sOFllMTdpcVdhdDFFVGVkcC9KT3UydjF1M1pjb1lq?=
 =?utf-8?B?eXI0djE4QWlvZDJtTVEwS0lEaVlnd0xNblRQQ3VCVEhYVGlrMEI5MHlsYVBy?=
 =?utf-8?B?cFp1RW9EV3Mzd0ZxM2hPREp5WjNYSTY2UlFsblNpUEV2cHhqYWk1amlkNFRR?=
 =?utf-8?B?K0dqdnphaDdOaWlvYTJ6T3JPTm1KVUEySkx5SzBobWxDZlo3Y1h5eGZLZU5h?=
 =?utf-8?Q?FO+ADvilWe+FWS08Gg+4X6o=3D?=
Content-ID: <F231D9F98DC9CA48AFED3C4061758D6E@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82956a96-761e-430f-2651-08db1043e66e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 17:33:21.7263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o1kzRrYIsPivixRu8JccDEFQKYDBLUX0qbyOTHzwHrxi9Rkro5gfIoY+j6yMgAvOT3gMyyhjRyYdni93D16Ai+lzAhXr1zkIWSonkGRH19k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8241
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230216_093357_028053_95CFCE3A 
X-CRM114-Status: GOOD (  23.67  )
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

On Thu, 2023-02-16 at 12:43 +0300, Kirill A. Shutemov wrote:
> On Thu, Feb 16, 2023 at 01:49:39AM +0000, Edgecombe, Rick P wrote:
> > On Tue, 2023-02-14 at 02:48 +0300, Kirill A. Shutemov wrote:
> > > TDX guests are not allowed to clear CR4.MCE. Attempt to clear it
> > > leads
> > > to #VE.
> > > 
> > > Preserve the flag during kexec.
> > > 
> > > Signed-off-by: Kirill A. Shutemov <
> > > kirill.shutemov@linux.intel.com>
> > 
> > I wonder whats going on with the pre-existing switching between eax
> > and
> > rax in this code for the cr0 and cr4 manipulations. Do you know
> > what
> > the reason is?
> 
> 32-bit ORs and ANDs save one byte per instruction. And there's no 32-
> bit
> MOV to/from control registers in 64-bit mode.

Oh right, I think I recall now. There is a 64 bit AND in the CR0 piece
here too, which of course is outside of these changes.

But otherwise, it's not clear from the patch what the implications are
of leaving CR4.MCE set for the non-TDX environment. I see in head_64.S
it will clear it during boot if the kernel doesn't support machine
check. So it leaves a little window where CR4.MCE is set where it
wasn't before.

The piece in head_64.S talks about how an #MC will crash the system if
it happens before the machine check stuff is fully setup anyway, so it
doesn't hurt to leave it on. Is that the reasoning for this change as
well? If so it might help to add a little more about the reasoning in
the commit log.
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

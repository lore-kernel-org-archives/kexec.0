Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC4BC4167B
	for <kexec@archiver.kernel.org>; Mon,  4 Dec 2023 22:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/nS1GT9djcSKOX2G+MvywgJheYiPK/dcadL9rNNUCNo=; b=LU/G8S1yHfN+12
	ZKmMaDCNagpLmNFCMcFs0UppkH8tHMHWUwby/EVoPkD3AncmMoUTbrJEYOlepIirv+jYK7rx9HdAG
	fTVJ24vr3TVc4Fiqeb3PIroYVugYGl+t6iAsWWPcIcUjyu87T52mtGsG3YXYKUPa2G7c6sfW1NPJl
	2qPXuCLXdXukuCk0uaNktJ0Pa2hEmKWa41JcEIkSDmM9CM3WX2ANVPh+xy2tDQfmV6C+ReB17bX7C
	hmLkFoQ9T0cZqcBgQMx61Ma1jhpPFGbQx0or7CYiGsYd2qWSZFzlZQOrlSxfWEKupDX9nAG4luDBk
	X3ANt3IHI51lamz86b/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAHfY-005jQF-3A;
	Mon, 04 Dec 2023 22:44:04 +0000
Received: from mgamail.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAHfU-005jPS-1r
	for kexec@lists.infradead.org;
	Mon, 04 Dec 2023 22:44:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701729840; x=1733265840;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=x7wd6x65mV5DJQQbZ6JunbUaHvgWfLr8cH+8GuKaS94=;
  b=N/fLDYMvPY8Hqmnm9ERYW7q3Rv8FKYdaPgPqLQHM2tXnNz7GsK2O2YAL
   4Lc0MjxoqbuFtCGeUbhmkSLH3otiE0UT3YqDR+yVbwhsbkNv4cy5nRqfF
   cp6Aa9STjAH1wykrhuosi3XAWXy7j+vuDDDdmr+TDJjyQMoe4xH21gWJ3
   4RW/Sky2p/GCe87sznb+EcGm2k6gGkMcfc+bSrRMsCZygzS6fqab9Bm9v
   N47i90LVUEsyNhpcSV6t/PKPKf2uTdz7MNx1FJap+sMiYQZFy3+0D7BHR
   +g5geW0hkqz8cjXd6Q0RdaOFoUuRKw44dM8vIrGhYgziwUslKwreVatT0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="460301381"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="460301381"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 14:43:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="944036711"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="944036711"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2023 14:43:55 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 14:43:54 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 4 Dec 2023 14:43:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 4 Dec 2023 14:43:53 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 4 Dec 2023 14:43:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cn1/DY94Zc1YLP8k/L0nyr7GEQKSt5iKK5eoX4Di4rx6B+TNQ0TqdDST85MTPL6cL0zxszl2groI8Oe+qCNM3X2b54n1f1GLvGUwK6g2PIy/jXU56qSY2PAdj30PQVXBdCbWuHOKA42AdWFWpTiPohGi1HUSeTFGydZB1YxFIx6ZaIrLNNlD06rmBb0iBBntudu9uYF68GhrOkVZ22TKZDb17X8ybFshLSthlEh+kNuyRj0Qfvta83UTjX9r7Dtbi8lwH1sNmkrhtVTmrG85ekpuvuftpmcbX2T5/in8c2pAoApgIJJ2CUU0AmDDYaFhW3JOa9tEpne1sLRg3HRJvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7wd6x65mV5DJQQbZ6JunbUaHvgWfLr8cH+8GuKaS94=;
 b=JCG3Ui0Z4GUe8wKYeucWtB1Ui8jm4K7vUwrhC5TeIRvkO0HI64uMg6PNKqBxJxhTn9FO3rudgfU30YndmeUc5FwYbvz8Hz31S/ZmjGO3d17oVs/hedW7euGOAne+6akRGmOxKHbwh+Ac0d9V7HpeQWm/058Su39aKgBN4VDDoTiUyIJMH8QhUO6p6nT2gdOJmgPbUzIyocxQyIKIfCLEPLk6gvyTlCk4i/OmjEm5oXN2sw82Q8rqMWmJpf0mRLjaddR7FpfKz0yE5/H27jO+8uS1g4V49mu8Et6+T6kKwFSxlSKSPGx47jCh23sVSWtZAeCeuZutEK7VF0YKHS+MkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CY8PR11MB7010.namprd11.prod.outlook.com (2603:10b6:930:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 4 Dec
 2023 22:43:45 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 22:43:45 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"bhe@redhat.com" <bhe@redhat.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCHv3 14/14] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Thread-Topic: [PATCHv3 14/14] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Thread-Index: AQHaF7uAoLPWjNmQzEmSsNIC3961FrCHshEAgAz8r4CABShugA==
Date: Mon, 4 Dec 2023 22:43:45 +0000
Message-ID: <5642b6cb66d4a1ecad87155d7635ab6b1fab60d2.camel@intel.com>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
	 <20231115120044.8034-15-kirill.shutemov@linux.intel.com>
	 <7012ba92206efaa6f0a0a2e1a28355d67d55265a.camel@intel.com>
	 <20231201155739.rxo6l5om6mdw54rs@box.shutemov.name>
In-Reply-To: <20231201155739.rxo6l5om6mdw54rs@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CY8PR11MB7010:EE_
x-ms-office365-filtering-correlation-id: 60e1c2e8-a60f-418a-d9ae-08dbf51a78f7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pEA6+CFUvQdKhTS9IvVcjLAk2jZqEMuRL2OdgPc0WJfAMNepSTI2cn90U4+lPaA+P4gM3X1I+5i2WiQsRa/TM/1DCVOVgKgU3Jc0r10eu2KxRU+SkmxYTRuV52ke6rqSAUEcCMBwgZ1uL/z4xf22mCF1a16fkl7lPmywvQS8owbAmtVssstogKkW3+0+ym9SxN3y4i/cfT09b0c0+vglm2nvQ+b8VbaqmmkDSOUCjqF78zX8YszxyM96sBF2oi0Vs3X0jFZO7HpVp9gHaNg7+QjS2EkPew33KF7oHG29oCA76nLdalhLl1FX2YE1Qha0OlYcY6C+51Z5neXoM2QC9cSo9x6sbTSvwueVGKtgGxWltcecwx1pJhv+v357nRQ7P4mcwq1OhdLO++6F/ubF2/RNE56KXbSszELoeDsSCAP2h15ZanbFrb1AnHoDKCds/LlFFyRRuIxMDbJoI/lVrqii/bR0eon8xdNnREJgR3O+Wb06oAuUlS198kcACU7/e+Evkk515FXeKQp5T2Ma/VyJXyjna82sK8EKcBvPtzMepuaKH6oGRnUhv+Kjc3kb3Je9i5V0Oyn9/D+mZY0bE8ORg9r3UmIzNrLgmD/KzZGznr1afUZZwn5JGeCvXigC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82960400001)(26005)(2616005)(38100700002)(6506007)(6512007)(122000001)(71200400001)(478600001)(6486002)(66946007)(76116006)(66556008)(64756008)(66446008)(66476007)(54906003)(6916009)(91956017)(316002)(8936002)(8676002)(4326008)(2906002)(38070700009)(41300700001)(36756003)(86362001)(5660300002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVE5UjkxQXgveTRMeEtON3plT2dZMHhteW9KQzMwdGs2cXhLNUVyaFlBMExF?=
 =?utf-8?B?K3NzOENYemsvTFpoVlpkMGRZWXZxVHJ3QnM2V3FjdlFBdzhJRTd3RlBJc1M1?=
 =?utf-8?B?NTRrR05zUXhsbUNUaGZNYnpIa1BKaWczQ2NlYzBvMkRWMm9VakpmSzhwRWkw?=
 =?utf-8?B?K1FrMjNwMmlrRXp5R2JHTElDSW9zdTJKSG10ZkMzN2J5UmEzOS9GNmhlM3d4?=
 =?utf-8?B?Y2NkbDhQLzVkK1oyTHRnK1REM2RMWVovS1NyZVgxTmF6dHNPVDVZNitpMnBD?=
 =?utf-8?B?SHorbjJzNWxPT1drdzJHd05qRW1RRzhxRFFwYy9VeDdOS21aM2E2a1B1R015?=
 =?utf-8?B?V2xJaGNHMzR4TmhOaGw2MkZYR3haeVdxaTEzRDNsY1FZa2wvblhhQ0VaV3ZU?=
 =?utf-8?B?Y1dta0RFYU1pelVjanNLQ204cklMTVRGVGZWZWxQNVJucXltcjdFM282K3RR?=
 =?utf-8?B?d3cxYmdjRmVjb0pPV3FJMWJScXJkaHROSVNQNzE2ajE4eitYRzFBV2tZb1VE?=
 =?utf-8?B?dWdqRFg0NkxWR3hYclF1MUNKVHpnL1R6ZndIRnlrUW1MNDQ2WmdoNU5Sa1dQ?=
 =?utf-8?B?aDZmbDZJaWJKM0NxTElXY1IwdVVvT1RKRTFkL1YvK0lHdGNmazFTSEJIcVNw?=
 =?utf-8?B?MkFJeTlTelNhVW9vMHVXenZ0ZFlsRXNFWk1XUkt2TGpxWVhtaEsrYXNNS2hO?=
 =?utf-8?B?c2k0azFCclZob05MY1RmY0JTdmpLT1Ziam1UNUFyeDhOSjhUdE9qbElJcnVN?=
 =?utf-8?B?ZGxvTU1ONm9KRFlhZHFscWFSTS9mSEVZdDlKb2lWdmRZRVBrSTV1SUt6c3R0?=
 =?utf-8?B?aHFHTFE3ZXN3QTB5VVFnNm5OZ0ZtbzM3bW5pclFuUzZ6S2Z0b21paXVXV0Yr?=
 =?utf-8?B?LzRIRStYOG1IeUEzTS81cHFEZmtnZkRwS0JBdTlUK2ZEc2c0OWF3WWZXbFFM?=
 =?utf-8?B?Q0xnR3dlZ21oejUrY3ROVlhPU09sa0hVVGxzbGZYYWg1bTdTdnhPOWIzS3dW?=
 =?utf-8?B?N2h6ZHJKMFRzTEVINHdtWFFUTERMakcvV2FxRG8vZlpKVEFLOVY5QXg4SXdK?=
 =?utf-8?B?US9ya1lpclVIemtxZ0gwM3FMZ3NEcG90ekF6SllJVE5uUVR3OGF2dDFmRm94?=
 =?utf-8?B?OWw1OFpOSTd0SGh4WlArMy9OSit0MXIzaWFxNm9zeUhFTTVRbTdjRjVORXZE?=
 =?utf-8?B?dVdKSGsvNnZFV2FHVkl3OHcvYkoybS85b2l2aTVxQXA0Vko3bXRIa3BiSWNn?=
 =?utf-8?B?cWtuRzlBT0ljVHJmemxvMXk5WjhNWmExV1YxbHVaYTgzUUcrWndTeWlheWVT?=
 =?utf-8?B?cXB1V3hkU0lIbGNXOUhYWVNtWFdqTVVtV2RJVndKaDNVYUlxQ1huSDNwekdr?=
 =?utf-8?B?eTFGS0ltUE1LTTNKaGp3dldPT2NTeEI4Ny9qR2VWb041WWFiaFlVL2FBRkdl?=
 =?utf-8?B?dUdPM1JTZWQxTDcyTWRyaTFNSnZ0NDcxK3k3ZTVRaVVUYmh3bUlkWHFEem1a?=
 =?utf-8?B?NHVlTXdRUU10SjFxWDJyaG1UNjJIYUlVellPZ1djZDNtNUltQ2ZTM2FQTmtX?=
 =?utf-8?B?ZytrNjlmY0RqMWFaeEJSSjdKTGt4ZVlCLzUzekN6YVhjcnZQZWQwWDdudmFz?=
 =?utf-8?B?TFVFZndtcEptbWRFV3FENVlXNHVHVVpoQjluaFVGajBZcUlWNkYvMExRM01q?=
 =?utf-8?B?OUgzVEVveDExbHFKazVmM0lOaDFOY3FDWmJtYkI4alRxY1RFV2hnRUhYbFdR?=
 =?utf-8?B?YnY3dmNBQ1djMzVSZklKbmNmQnAzaEZBSnZRbW53SExzUWROY0twU3dFNXVm?=
 =?utf-8?B?SXJnOGNlYUwrdUxaYjlLRHQyaXgrZHNudkl2NVNVNmpUaUFMc0U5SGZnWkoz?=
 =?utf-8?B?VE1uK0ZxdnFnTEUydlMwZmwrUk9VbFJ5b1hWdE9uanZVR3hVa3BldXNZVFly?=
 =?utf-8?B?NWt1dUtQUHJLQ1VwTlBRaXFNWVFuTTM2R2JXYlo3RERTaWw2aDZNT1ZnY3ZM?=
 =?utf-8?B?UkJncUlUYXprQnlsVDEwMlRRVzZHRzJjb3g0Z1E4cDVXcGdva1dzdlBBSi9y?=
 =?utf-8?B?bnc4UnV0VWlNMDRuc2pYc1VPYTNwRWtXOERGeStDVnN5YXZ5MURMdHVrTVFD?=
 =?utf-8?B?TmFFekM1eXowV1RrUEU0MFdVVGNoRDBqLy9FN3R4cy9qbmZEUUhXdk9ZaWNY?=
 =?utf-8?B?N2c9PQ==?=
Content-ID: <77C0F8492DC6D04DB24842D08C96735D@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e1c2e8-a60f-418a-d9ae-08dbf51a78f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 22:43:45.0317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HZLdW+T7ZliMjD+L+5OoJ/a4ai4DTwev30yFykgvl7YdsHcqCiqjUD+QVZ4XNWYxVAmErJAK8//MILSzjMlVcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7010
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_144400_702423_4AABCC17 
X-CRM114-Status: GOOD (  17.35  )
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

> 
> > > +
> > >  int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
> > >  			      const unsigned long end)
> > >  {
> > >  	struct acpi_madt_multiproc_wakeup *mp_wake;
> > >  
> > >  	mp_wake = (struct acpi_madt_multiproc_wakeup *)header;
> > > -	if (BAD_MADT_ENTRY(mp_wake, end))
> > > +	if (!mp_wake)
> > > +		return -EINVAL;
> > 
> > I think you can keep the BAD_MADT_ENTRY() check as a standard check, and ...
> 
> No. BAD_MADT_ENTRY() will fail if the struct version is V0 because the
> size will be smaller than sizeof(struct acpi_madt_multiproc_wakeup).

Ah OK.  Maybe worth a comment like below?


	/*
	 * Cannot use the standard BAD_MADT_ENTRY() to sanity check the
@mp_wake
	 * entry.  'sizeof (struct acpi_madt_multiproc_wakeup)' can be larger
	 * than the actual size of the MP wakeup entry in ACPI table because
the
	 * 'reset_vector' is only available in the V2 MP wakeup structure.
	 */


[...]

> --- a/arch/x86/kernel/reboot.c
> +++ b/arch/x86/kernel/reboot.c
> @@ -878,10 +878,14 @@ static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
>  	cpu_emergency_disable_virtualization();
>  
>  	atomic_dec(&waiting_for_crash_ipi);
> -	/* Assume hlt works */
> -	halt();
> -	for (;;)
> -		cpu_relax();
> +
> +	if (smp_ops.crash_play_dead) {
> +	    smp_ops.crash_play_dead();
> +	} else {
> +		halt();
> +		for (;;)
> +			cpu_relax();
> +	}
>  

Agree this is better than explicitly checking TDX guest. :-)
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

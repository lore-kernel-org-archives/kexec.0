Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3085C5478C
	for <kexec@archiver.kernel.org>; Tue, 27 Feb 2024 23:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:CC:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=73m4MRxUGSD7ts2q5jnN8K6NmwFIkz3PKEeCsQV6YCY=; b=SQm7WZjQJU3C4FEIFqbLaBnfSw
	SbcXFHYDndNZPwXcopkUYNOM3plvJScjG5wRELMZ1DwSymfPEPWlmuUsVsEmhPOHWE8o743qO4l6r
	FixfgqAwNJWdi85J5/VXCTAYEk81VjtuzeR33I9DuB8Gi2SPJ5uhw/y9BNLwy7Q9aL2X4kgRjdF1A
	zOSD677zrgXTjrKaRL1gH5gXZootaoopMSO8CsSxBwErTv764X3XMfjwTAo0YabpbPf3fDM3gMOOr
	Q0StftDtb02LDn6loHuvGOkmkBIfS3ScXru1BLAkRemrPRaWyA4qzWn3BHJ2m2UtrOPMJtxxOCQ3z
	f8pm6kkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf6gb-00000007D42-14r4;
	Tue, 27 Feb 2024 23:16:33 +0000
Received: from mgamail.intel.com ([192.198.163.9])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf6gY-00000007D2O-25kW
	for kexec@lists.infradead.org;
	Tue, 27 Feb 2024 23:16:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709075790; x=1740611790;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=toWAAySRY9cdVsfoJkQx1O3bNVVtOR4qOakOqLQ4PlI=;
  b=mpfUJudwoO5fTAP8U/Y/YE7JA1ehYE+AXGyvDT9ULPdrgbJD5RjFQYoc
   Mba76xXl8k6EF9Vgb4OHD5jOQJ/31ZuTnKOwFdQmGB9ixQmYkh/I0hZas
   sbM0XHDTuA9t7G1zGkDb+mErVR/Zu0YE2l+wk1mR7kM3O3LzO+qMtSibC
   T8dw9hvYTB7W8w1V9uN+VSAN6j128oHDvWXpFlyS9CkSEqSFA8qU6RA2k
   YysFCSlN+hZRuOHL+sFzZuKQZp1jf0MLkIq4MmfCuQDUC/LYr3kKP+bZ+
   gBfYHQB+6NrOrgCjkY/ZG+mPiHqnssNtg9Pamnsnyd5eeN4i6Isbfar85
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14160645"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="14160645"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 15:16:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="7182266"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 15:16:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 15:16:27 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 15:16:26 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 15:16:26 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 15:16:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HyQ8CNlpWZ9g4wIRzyxzjp5RGe1NQLryxF/x84BzL4Ps5c6aK3rIB+ZErqe1C2aQt78kW3bhPNHBhtX5XNqE4TBjq7DUhbjrwvednY6b6TGDdZDIRSv/BasFX+AHvAdJ0RTvSMlSK3kdShT8q1ZL2RzQq1T2BFeFKQ6ZJEuwCZ4piaR3he3DNnlHJOjIwlIicqHYOVROjtMcSaIzOIWmBAdWGScA9r4JZAh+cygZ6A6LB37wvUOGnoFXL9NIrOgoZ+ePj4kGkV49RbmZguTiNqc3F+D6outcAs2hNIFcmshe3OfEXElXhAqovpBABCVYWoE+6E0QteaW3c5mSZHqxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2p9yJ4YIjenNxszbc1H7CPMB3w85BjC27k8qwD7JOs=;
 b=KihDz7Kd++RNl8DcSwAan1IR8M8XvDQmrtxaqZMIBxa/BtsTPG6XwGpf+GoSqyDxqOjMRjzSiiQoGVGO/tahwUt7c00x0BNsvFww/rsoTZ0GuGn5QESDFm9f8YND1XCOZ4uFPDYRG6EaktwH2ZnbjEJfp9pr4vG6CnMVlDMeZBIgw4qMLwT9A0bHnoshyUpIig/d+eI9WBQ3rnfyJUptM3BK7mPRBaqJWkML50raOyC2iHNDvvj/WTbO1gnE+lPqFdwo0k0I3IOmTAm0butMR4pP+QJZvNdB6ig7dbJPtWcKWz00zPVyhiiPGCZDx8knxtUs4DC5Rbl035vmhRseEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by IA0PR11MB7355.namprd11.prod.outlook.com (2603:10b6:208:433::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.13; Tue, 27 Feb
 2024 23:16:24 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7339.024; Tue, 27 Feb 2024
 23:16:24 +0000
Message-ID: <3885ab33-d704-4e50-bad7-0dbe3b012ebe@intel.com>
Date: Wed, 28 Feb 2024 12:16:11 +1300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 09/17] x86/mm: Adding callbacks to prepare encrypted
 memory for kexec
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, "Elena
 Reshetova" <elena.reshetova@intel.com>, Jun Nakajima
	<jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom
 Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>,
	"Sean Christopherson" <seanjc@google.com>, Baoquan He <bhe@redhat.com>,
	<kexec@lists.infradead.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Nikolay Borisov <nik.borisov@suse.com>
References: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>
 <20240227212452.3228893-10-kirill.shutemov@linux.intel.com>
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <20240227212452.3228893-10-kirill.shutemov@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:303:b6::31) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|IA0PR11MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: 199ac9fd-83a5-4ccc-080f-08dc37ea1dcd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5KJ1tkKPRCl/1WNTt+E8wZU94udEVuZNlE5+wdDqt/DMEqhA8PpbF2ukyU1waerI+dMoMmRi7SV9piU92iwUHl0Z07KAM0CtRJslzdx0EN5Fx9p7woORs6n6IL9FgaP87wWW38a0eEJtxvmlRg/CAgJQsVFotxJsZFrDeinJBGYZSZloJkwTAIDP7U+cW8w36oSjsjpagDG/vql3IWE4CY2IjNVbWnG8k3jtGCAktjWvQUcIyBH2sF4q6M3hyS+6KpUV3aB0chNV9s7vGm31dpipYZXP5fNNlCC6Zk5TmHVxrtiPxOt2BXAWXVN2TfWvV8gpai0g2oG+mUsTAnMmB4/WU9mm9ooJf0iRqWEe3B9VO47ABwBaj115HFP84gIOtxEZa1Tly12Vu5d7/vZ51Kqp7aRxPgWF5U0E5fcC338t0ZA6GRJEvtIUbE2JCm7PLAMmqXx+x6/u4hMPoGBLX5XsPlZfjC7oEsrhmeAj1d1PWaRoxa2k5koHj1/984Q9lkCWywHWhEqMU+7TsEctDP8HbkjbJM40bDIec/YQXbDxJ+9PqCtYBF6hcg6BOglnxQ9o06xOnBjTUpFIalxHY6lPrd3RdVU1iao/xeX8lN0h67bPlcM5Mmj7+Sl/OImuUHUgXy+S9umLP1A/d0ykhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnZ6QTdGTDdiS3FJUm5aSU82RFpqN1pUU01ta1E3Wk9NUzA1a3V0UEorNk5q?=
 =?utf-8?B?ejVYNmp5VElmbnpwenQwUVpkU2pWYnNhWEtEU0JtdFBhRTVCaFNlbTRQSjNl?=
 =?utf-8?B?QWJqdi9aNWV0SWw1bE9oakUvODBBWFgrNzhqWXhxZmZZcFJXTWYvRTVoTUxO?=
 =?utf-8?B?UUw3ZmRoTmVRNjRVbHl2QzFndEdqT3haWHBGUit4VUYvTXZMV1NpUDFPRlNx?=
 =?utf-8?B?QTA2RXRjYWUwWEFqc216NGw3YWY5aTY5Y2xlbGZlL0F0SEg3Tm9GQzJkWTJv?=
 =?utf-8?B?MlNoR0VFa0gyb1o4OGo4S0E1blZNL245ZkVleUpZaHAxaHVrT0lhWVZmNHdh?=
 =?utf-8?B?SVBCYzZZaUt5VGZuMDhvNWpFTDZlRWNvMFB6SEs0WGd1OFozSldWQ0lLRGNU?=
 =?utf-8?B?Sk9URGlzSkFwYkZZMVNaejVFa1FtV1JoY2RiczE2MUFVcENsa0cwbm55ZTls?=
 =?utf-8?B?ZUM2b3UwL2U3cXBhaEtzekF6dHJ6SlZkSVpxa3FGeXpleGJ6dnhhWStpdWtm?=
 =?utf-8?B?eEdoOGFBREhXcU1YS1pDbTNpbzVkWGZWNnJBWVdDRkNGVmNaZCswZ3JvN1BT?=
 =?utf-8?B?TGF5NTJyZi84Z0l1UDFpbE8rcHZoQVorUUc2cWlKaW9mUXB6M3l5Q0Fsd1Zm?=
 =?utf-8?B?MW12dnJzTXp4ZThveHREZWxad0EySHZsd21nMUlUYW85aStVVWdvRDV0TW9s?=
 =?utf-8?B?bmlicUlpRE5YdDZNOVl2NXN4QVM0c0IrQWtDaFlvWFBXa0pnVGY1anN5b2wy?=
 =?utf-8?B?Y3hPTFcvdi9OazZ1S2ttTERuclIyWTFGZktOM1NZQzhzMUtNRGRmZXZaMkNE?=
 =?utf-8?B?dXdGRDdZWjdwN29jTlNTOEgrSnNJZ09vNkltaUhPci8wU0lrVTVhdFlDU2Jy?=
 =?utf-8?B?dS96K21pWE5Yczh1TkZrQ091a2ZtalNPZGVSRFNod013NlF2SUkvZDcyYUVl?=
 =?utf-8?B?RXNxejNjVTFIL2xnZGp4TnBJWkxxeEUrTUxzb0krM3NGZ1hlK0wwcDJvczNa?=
 =?utf-8?B?U0w2aUp6QkZpaWp0bGVhb09iZDlMcTYyNklxcGZRZDJwWlZXcTRZOFZkVUJM?=
 =?utf-8?B?QXEvbC9yaCtJa1MxbldJSFAva09kNTAwandZN3cvTzJXZnNiRUZqNnFsZkJJ?=
 =?utf-8?B?MWhlSTI2QXFGNlBmRHBtdmFhZ3VFWVNwc3g5ZnFpWDUvUWNGVG5nMTJ3ZUVQ?=
 =?utf-8?B?SU9XZnR0YjYzdWNUTUllM21pYmJESFJ0OGZESFJJWURIaXFNOUZ3OXh0eWMw?=
 =?utf-8?B?NGt3OEdhRlhjN3pKeVZ6YjVaK2FvSTJpeVdzN3ZacENWSlVwcm9vZU82ZXAv?=
 =?utf-8?B?NCtNMWVFelpwa29VeWRnVFNmbEhPNzJEdkYyVEl4bjNRMldhdVgrdmQvVDkz?=
 =?utf-8?B?TWNlYXVIL0VCU1p6OFZGbUphdlVrSm5pSUhhL0ZEWXorcmo1Rk56UkdaSjBR?=
 =?utf-8?B?Yi9jRTdtaHp0OUEvc2xGVzRRNlgrd0RpaDkzNXJNcmxFeWV4MnBtUlp5a21I?=
 =?utf-8?B?VFphaWxtb2E4akdncE05SU1mRUxjaE9zNW5hMXA0eUppSG1VTDNnS2xvVGR0?=
 =?utf-8?B?NlM0aTFaMjJTVXdKWW5uQWZETzJXeVYzb2NCMTV2ZVRPaVErcWNtNkkwWEtl?=
 =?utf-8?B?ZUZUa21VS2NmUUVYYUJaZEc2b0dnK0M0a3czRm4wam1Md2FYbGJ6K0lJeXF4?=
 =?utf-8?B?eTdkSzFMZ2JIMU14S01kN3I3eE96alJIUk5Wd283cFFEMlZGdzN6VUw1RVFE?=
 =?utf-8?B?cFhwS1dSaTErZzVNNk95V1B3bFVqNU54Q0tBYzIvODRIcFF0cGRydy9pL3VL?=
 =?utf-8?B?M0xiNDdqek5hdVhoWlRUb2VORW1yQlUrOXoyak14QXRkZXpyMkhvSjFBL1d5?=
 =?utf-8?B?RCtsdmJIVjVXRDI2VUM1WkVVbEIvRkpybFp4c2M0T3VYd3I4RjhieXRYcG9U?=
 =?utf-8?B?emd4S2xvL2NMR3FxSW5wNjY1RW03SkpSUzhCb3Y1cDVweFRPUkhKM3NtTXlr?=
 =?utf-8?B?RzVyRVN6d25kZWxDRzc0VjgvcVBZSm9NRUlSL3lpUmVKZHZuYUZ2MlIvdy90?=
 =?utf-8?B?QzZ3VFYzejVDa3JQV2dTMnY4YUVoZTFobHJ1UDVqNTZ4ZFRCZUVDcjR1VzVO?=
 =?utf-8?Q?hI4OZSEKto0McEEryScck3Pzo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 199ac9fd-83a5-4ccc-080f-08dc37ea1dcd
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 23:16:24.3104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pXrMxQ+ZwR4lEhURnzYaohhAKLDmkxMw9n6j2aCWggktlI089lyijQaEIqpg3qB7pqsQI3D3GoBvoIhANY0rWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7355
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_151630_597508_BB29CB70 
X-CRM114-Status: GOOD (  11.60  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 28/02/2024 10:24 am, Kirill A. Shutemov wrote:
> AMD SEV and Intel TDX guests allocate shared buffers for performing I/O.
> This is done by allocating pages normally from the buddy allocator and
> then converting them to shared using set_memory_decrypted().
> 
> On kexec, the second kernel is unaware of which memory has been
> converted in this manner. It only sees E820_TYPE_RAM. Accessing shared
> memory as private is fatal.
> 
> Therefore, the memory state must be reset to its original state before
> starting the new kernel with kexec.
> 
> The process of converting shared memory back to private occurs in two
> steps:
> 
> - enc_kexec_stop_conversion() stops new conversions.
> 
> - enc_kexec_unshare_mem() unshares all existing shared memory, reverting
>    it back to private.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>x
> ---

Reviewed-by: Kai Huang <kai.huang@intel.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E50C54E58
	for <kexec@archiver.kernel.org>; Wed, 20 Mar 2024 21:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:CC:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZraDlJitEA2pIttwFUQyFKw4NvpSrA9EfG7zFEogDGw=; b=LGLr0JsDvYVDjlYdu5fPKDlwyF
	cNe81fUKBMelsREGyBx2rHjmgogiCgAEddOB2/mmGuQNQEVJHa4pCYPWvPUrM1DJwiIWLDEhJ8oRK
	HsLGAdeguQhQIs7Ol3vZ7phq8JxZ8MS/cSwacFylguPXHAnE+eMsSv5pex8E79CT6090juIdzeMn6
	gG0UiTSa1FePmtX/OEpiRUXBJVaq6D3Tv8Uvy8bM/ohSwXe0rQj54Kn8ImOKP0FTPizoVUXUgm0aS
	0x/5i/VcucyKK9cVsPV4ehBEAV6r4z94226gQ3/MCSksfhJnfTjcCTfDs90jC6Gdu0fNCzUdHOl4T
	7fSq1S6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rn3vR-000000014J8-0wFe;
	Wed, 20 Mar 2024 21:56:45 +0000
Received: from mgamail.intel.com ([198.175.65.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rn3vO-000000014Hr-0iPp
	for kexec@lists.infradead.org;
	Wed, 20 Mar 2024 21:56:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710971802; x=1742507802;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=of/76jEAeh5K9jSAY5l5/fqoEfljdUgCL5b086Q9oTg=;
  b=Keykb9Y0EMa6O4jFIxXSHJEBDTNwPhV9v+1+X9UqXexv+EsK9saWlakY
   AKZFM6X79npDHC5Zd0aCluOe4dcMpMNvaGDyWfgUjVz59hbysCqmvfroC
   9nXyT25ocRwxg1hWojPXs6DwFY7nZo4vNH2VKWv+NcCHzFvAKOh4P0BcH
   P3pfSKMEj4+UT5c3q6osSkPRqzAQuVHT1lVZybm7Vdt3OQFDWpM87ZCz1
   QH3yw7OSSSZdn0MbKLamUA+yXO4HQcLg0fu3rDGEol6LctbIVrFPzE2qt
   M11NwT2W85DllJJB7c3ObcvWkXCtOITpVvPsT8+1mBEuMWVilaBYkHAgk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="16471952"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="16471952"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:56:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="18933101"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2024 14:56:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 14:56:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 14:56:33 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 14:56:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XS1lRAGwu4O72mWws2hq66YbRY3BmXW4wGQjgjRSJWV2OxhdmCRMT5dwVBDbHMRwEeJGqd+UTgbdHwffYBvPsGUSvn3cmbjwTa/sBTPKxV019iRGja4ejLTb6wt9JzZKc8/gUxZ4nW+HhRfWeADTtLAFtlLigvyiTYQX3LulTIKTnSk9SWxuDthexPP5NrJzsk4ixmLU/RQCvQ6dLVGIWPdEvwiipXTwrAuFZ+ZdwuTnC3RcBbB/rlAxlsqsuGBfCEQyrH5zLEdWjYt27Zc+rYlwRvdm4I418MYSmjVBLsCSLkoczP75fpvx7L2Im+TRS4Dlgf6rxXqX+c9JrmmY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnG7kf8+9C9sEoTMAH3zoaC6HUU37Izv32jftV/iswY=;
 b=TLfaYlI/pGNYyD7dR+yycpYFwbWMi2+oKTJ3wqaoaRVir8aOJbnFT+fKpM5EHrGEuQwmjFYARlrGjslVbJzcq/6yslG376LhXaMu1mqesq2q3LuWYDiQh4cZZhTNO9rT9dwGS04OzL/MB7q9AjDOpURV5X8JLy9oLVO7igvFSpIw54eKV8AvoZY1D3KhzQmk0GclWZ5canhHkLyE3mEzb62aOJnJ7MlGzxKE/fkPaI8J+SAi8yp5TjbYzwTc2CcdBO5I4SWZUepPWq1AJVtNyWw+EQzSWY0FOFwf3J+ihodGFXa0S4DpEaFUUDs5NqY4XQM/4sYTzia0v7pQQ/Bd7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MW5PR11MB5930.namprd11.prod.outlook.com (2603:10b6:303:1a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Wed, 20 Mar
 2024 21:56:31 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7409.010; Wed, 20 Mar 2024
 21:56:31 +0000
Message-ID: <4d9fe26b-cf0e-4381-9dee-20f43f371710@intel.com>
Date: Thu, 21 Mar 2024 10:56:20 +1300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/kexec: do not update E820 kexec table for setup_data
Content-Language: en-US
To: Dave Young <dyoung@redhat.com>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
	<kexec@lists.infradead.org>, Baoquan He <bhe@redhat.com>, Eric Biederman
	<ebiederm@xmission.com>
References: <ZeZ2Kos-OOZNSrmO@darkstar.users.ipa.redhat.com>
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <ZeZ2Kos-OOZNSrmO@darkstar.users.ipa.redhat.com>
X-ClientProxiedBy: MW4PR04CA0180.namprd04.prod.outlook.com
 (2603:10b6:303:85::35) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|MW5PR11MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bad6151-1370-4be4-be4a-08dc492899e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ha5HsgaPnxuKQd7gHcchyYjuKwiOHhYPJ+MmE1PDJeOuo9Tlq2NgOPDpuOodNN2+Blk/DQW8lIIQhIaVS4+jbdQ1DIRfkrSeejtID/OWSnv+dkVyLV23j7/thYRtxA4LuhD9zaDoT4ml12nFHiuvIVb2y1mnBy9W1j7PSodEDYeha4AB+uJ09RGzAAmEERGHMHoMd8A4nY+378qaxQe5tiPV8DfgoX1+tKySxtUzEzwldRKl2KM3bDWQFgYWZ9RYZtRcF4crmqYzd9V0/qpZ/FkST32fidnGi95yZjJdlDI47afcKRsD8wJ4uEMKp/z0sbrZ428TAxO3m1kPRXBFsEdejsdRmEBXCQMrwSczxXyyPGzHk3JqhIrdEdffTOXYMIrG/yP3TIOIkrGteHPQK5l60wg+QvJI44V9Is2FUFame+Chqp9YdmbdqNS7GiAIVSilvAotHqZ34cKnItN4DyqcLi4fkh9ZPuefkFQULEp1RGNCi07QL6xkMkcXic/g0/RpxreCwciQzwm+RL1+J/CY1d+k1rZbswZ7jwzcSsCTEL8aiFPGL7zdEZ14xWgLhffgopcrYJ+GHOZbXdIiTMGa9HWqPB2JUU9S9VxTI+g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFZubWZGWEFUbitnKzRiN3VlY0krT0JGdlY1dTZWTFdKUEt2ai9aZGk5d1Y3?=
 =?utf-8?B?QzhlSjFyYlpqVjFJTi9YM2pXb3FjeUgwSG1UcUE0aklPdmk4RlFsc004Q0ww?=
 =?utf-8?B?RXV0dGxiL1dPeDhuQ3dSNjBnUndqV0NhVUtNaldQRDBvQ2dFL2N2ZXZnY3lj?=
 =?utf-8?B?S1dxcjRUb2VhbTRndG83bkxJNGRabkdNQmFGNjR0ZzVIMU9ENVRiY25jSTlH?=
 =?utf-8?B?S2pOWlEwQXdSYmR3bC91UjBKYkNhMXNEWkpWTWtvazExM2FEa1Nxcmswc2FM?=
 =?utf-8?B?Nkh5Q0F4QUd2b3QrSC9QU0lwYzgvNFZUanBWQ2h1dFhSK2dSVG94ZnZRSmNF?=
 =?utf-8?B?ZE8waDN6STRhQ1ZacUhWeVI1aGVDSUNGeXZ1VGNYdXJjYlVTZFZtNkJUd2U0?=
 =?utf-8?B?MWhGbXhvejdNeHpxVzZ4NjE5a21jZm5sL2lTWUJVNHUwVERiN3VlU25iSGNy?=
 =?utf-8?B?NzZiZnZlandSWldmK0lKV0cxb2J6R1o4MFBsMEFuZnRwZ1NwV1NuYjY1cGxp?=
 =?utf-8?B?bHFzTm5COVBBZ3diS2M4N004Tk1DK21xZy9tRWJwU1RieGh2QWlMKy9wZng2?=
 =?utf-8?B?K2VpeWNoOVJBU2tYZDJFdGNpMEpuN21TYy90TUF3UzNYbzRWT3ZjdDRUVDgz?=
 =?utf-8?B?WjZJWlArRU1iMmtNa09keStaZkxyblcxWkVWa1JVZVZ6YVNJQTI2dGprWkJp?=
 =?utf-8?B?SFB6QSttZy92T3YrV0NwTVNvbUJPajJ4ay9LYllVdmJvdVByYWUxNlhTa2Yr?=
 =?utf-8?B?N1A3N2ErNnRoYzlGbUZvcjZrVnhpMDhraXFQQldRaXRid05MTFhMUTlzcVR5?=
 =?utf-8?B?WnNnTEtiY0g2QjY2SHdLY0ljNHhCcFI1TGU1QlRxZHBiekUwWWlJM05EY3cw?=
 =?utf-8?B?QXBWOHRHRVR1UlNCMVFMQmJpa0RtbFo1eDM2czdxR0kyYVlGWlZHZTVwa092?=
 =?utf-8?B?eTBvVURINkEyTEtkcS8xR2dMRmFQRktzbVNNb3QzY3hKTlNXVS9sU3FDbVYx?=
 =?utf-8?B?Zy80S3dTVHJqeE12YUIwTVc2TVpUdXR2L3NrYURuQkdwY3l4TWhFSWxpU1F4?=
 =?utf-8?B?MnhydVIvS0cyc1hndGs1MnVCMVNrdWxnL25rekszVUZSVWxBMGx6bmVVUG9J?=
 =?utf-8?B?SWY5alNXREprZUpoRmx2MjNKZEZHYjc1L1VVS20zak5ZZWNHTUc3UWd2ZXYw?=
 =?utf-8?B?dVNxMk4vS2pnd0FWSFhwaUVmOXpuM2FyRnE1NXBoUk94Z2drN1I1S0dPYytI?=
 =?utf-8?B?TzVKSWtLRndSS29XVlFuQ0UzQU1wcDg3WXdJN1VNbWI4ME1zUkZYSDlvd3d6?=
 =?utf-8?B?aXdWRUQ4NVBHbStDUjFUTkxDZ3dGdjlOYTlNS2RZbjdGSGFEQ1lhaWtVZERX?=
 =?utf-8?B?am1uQXd5VWF1ZFlOSUVkaTVucVJ0aHQvN0plVVJGRW9OV2x6aUVRNVo3NXdr?=
 =?utf-8?B?RDRVb0QySm9reTFVZXF6WnhVL1lmMzVZNW5pbzJ1SjB2RUlxOWZPYnVmRjMz?=
 =?utf-8?B?Mi9waVp2VjNSamtPcGJCOWoycDhQb0xnUTRtYVZuMEZlZUNXRUZxcUJFdW5r?=
 =?utf-8?B?dUFuTEhpN1diWUpHRy9MSlZUY1E1NStRem45RTNEOFlpcDVwVW8yK3FFNUV2?=
 =?utf-8?B?Z3hjV1lUODhQNVJRU1hpeVFSWkVOVHh6SGx4YkI1V05hVnk0QitoSXR5TlJP?=
 =?utf-8?B?MjI3azlhZExBbTlxS3d6OXBwL0ovR1M3ZDNUc3o2MGg4WjhOUlhNT3h1eThq?=
 =?utf-8?B?REhQNFo5SzhkM0xJVFF0eDVac210Y05NTy94QjJQSStPaU5MWFV2V244K0gr?=
 =?utf-8?B?ZlBPcTFlN2VtR3dvczJ0WEFrdFV6V0FBY2FGbWJuNFJqWVZiTE82UnhJMVQz?=
 =?utf-8?B?ZkFnNVlTVkFaeGljRU1MczZMMms5YWxlcG5JcXB6Q2FrdkZIdUs5RlhVYm9U?=
 =?utf-8?B?YjlyQTBRTEtDaE9hOXNWVWI0eGdiaDBQdFF0ejFxVnNXZTlDSVk2TUFTY0ll?=
 =?utf-8?B?dmFDNEhrMGFieFI2cUNGYno4eXA1U1Mrc2RKM1RESFJ5czdGOWdYamtzSmpn?=
 =?utf-8?B?UTJERy8veEw4SkNjeTNQN3lqeFJvQUw5eVBnYkN6MHBhY2ZldHBBSXFyUHhy?=
 =?utf-8?Q?mqg8Z4YNkhtaLE/uGVbVq2XvA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bad6151-1370-4be4-be4a-08dc492899e5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 21:56:31.0246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pysZkq8F29K1JCtTgr4YpkbHI+r4VRMf5FX81OjcvO4xhHWkataM6fnaQ+ycJBJLajdMTzF7Msp1Er2uS70Fzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5930
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_145642_292606_26A6CC23 
X-CRM114-Status: GOOD (  29.13  )
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

Hi Dave,

Some nitpicking in changelog:

On 5/03/2024 2:32 pm, Dave Young wrote:
> crashkernel reservation failed on a Thinkpad t440s laptop recently,

',' -> '.' to make it as a standalone sentence.

> Actually the memblock reservation succeeded, but later insert_resource()
> failed.
> 
> Test step:
> kexec load ->
> 	kexec reboot ->
> 		check the crashkernel memory
> 		dmesg|grep "crashkernel reserved"; saw reserved suceeeded:

"suceeeded" -> "succeeded".

> 		0x00000000d0000000 - 0x00000000da000000
> 		grep Crash /proc/iomem: got nothing

And somehow I found it's not easy to read.  :-)

> 
> The background story is like below:

Better to have an blank line to make text more breathable.

> Currently E820 code reserves setup_data regions for both the current kernel
> and the kexec kernel, and it will also insert them into resources list.

"will insert" -> "inserts".

> Before the kexec kernel reboot nobody passes the old setup_data, kexec only

			  ^ "reboots"				  ^ and

> passes SETUP_EFI and SETUP_IMA if needed.  Thus the old setup data memory
> are not used at all. But due to old kernel updated the kexec e820 table

   ^ is					     ^ updates

> as well so kexec kernel see them as E820_TYPE_RESERVED_KERN regions, later

"so kexec kernel" -> ", the kexec kernel"

"see" -> "sees"

", later" -> ", and later"

> the old setup_data regions will be inserted into resources list in kexec

"will be" -> "are"

> kernel by e820__reserve_resources().
> 
> Note, due to no setup_data passed in for those old regions they are not

			    ^ is

> early reserved (by function early_reserve_memory), crashkernel memblock

						   ^ and the

> reservation will just regard them as usable memory and it could reserve
			
"regard" -> "treat"

> reserve crashkernel region overlaps with the old setup_data regions.

double "reserve".

"crashkernel region" -> "the crashkernel region"

"overlaps" -> "which overlaps"

> 
> Just like the bug I noticed here, kdump insert_resource failed because
> e820__reserve_resources added the overlapped chunks in /proc/iomem already.

			  ^ has added
> 
> Finally, looking at the code, the old setup_data regions are not used
> at all as no setup_data passed in by the kexec boot loader. Although

			  ^ is passed

> something like SETUP_PCI etc could be needed, kexec should pass
> the info as setup_data so that kexec kernel can take care of them.
> This should be taken care of in other separate patches if needed.
> 
> Thus drop the useless buggy code here.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>   arch/x86/kernel/e820.c |   16 +---------------
>   1 file changed, 1 insertion(+), 15 deletions(-)
> 
> Index: linux/arch/x86/kernel/e820.c
> ===================================================================
> --- linux.orig/arch/x86/kernel/e820.c
> +++ linux/arch/x86/kernel/e820.c
> @@ -1015,16 +1015,6 @@ void __init e820__reserve_setup_data(voi
>   		pa_next = data->next;
>   
>   		e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> -
> -		/*
> -		 * SETUP_EFI and SETUP_IMA are supplied by kexec and do not need
> -		 * to be reserved.
> -		 */
> -		if (data->type != SETUP_EFI && data->type != SETUP_IMA)
> -			e820__range_update_kexec(pa_data,
> -						 sizeof(*data) + data->len,
> -						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> -
>   		if (data->type == SETUP_INDIRECT) {
>   			len += data->len;
>   			early_memunmap(data, sizeof(*data));
> @@ -1036,12 +1026,9 @@ void __init e820__reserve_setup_data(voi
>   
>   			indirect = (struct setup_indirect *)data->data;
>   
> -			if (indirect->type != SETUP_INDIRECT) {
> +			if (indirect->type != SETUP_INDIRECT)
>   				e820__range_update(indirect->addr, indirect->len,
>   						   E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> -				e820__range_update_kexec(indirect->addr, indirect->len,
> -							 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> -			}
>   		}
>   
>   		pa_data = pa_next;
> @@ -1049,7 +1036,6 @@ void __init e820__reserve_setup_data(voi
>   	}
>   
>   	e820__update_table(e820_table);
> -	e820__update_table(e820_table_kexec);
>   
>   	pr_info("extended physical RAM map:\n");
>   	e820__print_table("reserve setup_data");
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

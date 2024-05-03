Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BB1C4345F
	for <kexec@archiver.kernel.org>; Fri,  3 May 2024 16:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P5CRTFGQSIwWATmtNifYPbAYxRPs46M1VvuG0mp49WA=; b=qnmMiIhj/yLNty
	b9oCnfcitlpnntcyI5SHYeA/bf+Cujg1iTkEGgij+q9zswbbw/sVZ6/NGbskuY9YRZyvZaGfn7sDI
	3qtcLs3fJRuTV5pETsJREdzSyESOLX92kqCAowVLXRmr9/BFVkhXEX9PLUmpzd9uMaWybsqUzTKdI
	AIFhkL5UvCi3CSRq9LYqbdBvpAOuv1aezHCDdpnhtE70sp6NNOLFGZFbZFVlORDt1MnjNEgGaE7/c
	F2jqBjKJL5urdPlOXF6AoPdP5BK4pvZXpsJQGGmOuqeLJ3wA9jNc31qtmTuG06+RgfVHx1AwQ55eH
	EYZRfD2FwopPsiCGIWAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2vmi-0000000HE8e-0efP;
	Fri, 03 May 2024 16:29:20 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2vmf-0000000HE5z-1w4M
	for kexec@bombadil.infradead.org;
	Fri, 03 May 2024 16:29:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=/bAfl9s6aXfwpEU2dMYC/8CfKmR8alos9r7tL6M/SwM=; b=LYkITdVnLw7TVM8fAYNqUaUzOq
	+jSur4svGWY0MYt39dVRGJXgEkpqJ1sG2UTPwHZaDmQMRn/84FIcZmlDta6x4Zo373fxxtQCahns5
	AW2oCgGVi2l+g826ZV1FKdUhVnbbVoL3n/hSPD8UBiT/bOSDeKM+jKiHmeXm1zD3qzxRsr+8Y9vv7
	bANoha+ImJCbgFjNM2PdqcWuV36wzS6OZQ6q1aVPUjhjPxiUvgiH7XAaPBshbatuHOKLWbHaG7YtC
	+22lTkAyEnS7CcC03tqkuY+lD8HTHfxW5tAt5KzvPEIu2JgFSzyPudncD2Uxi2CXAECrtDbk7UY6f
	bDkmiAOQ==;
Received: from mail-mw2nam12olkn20801.outbound.protection.outlook.com ([2a01:111:f403:2805::801] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2vmb-00000000bnj-2hCS
	for kexec@lists.infradead.org;
	Fri, 03 May 2024 16:29:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhmJ61ZHGxGwlee1JgTSfR3XLLK+ET1RRI8PYTREFtMh8MMkioPm2i7gpImDFOztPZW8A1iUBVrJbjCs8bWAsQWU38ABD4osIlHJYdw3zNaSN2DmgQi/vHbUlovLf+DrG0u0xDazFX/QVfX3vLG308J+I9VTd5924cCdNr9pp1JB0ui5/ZGElCl0Doim2P231/oRLLIBKc+bg2LaETnCnwVh601y1WIDvtdD5e395qnFGcd9xnTQrI1gHrly0n3i1piw58rlIi6JNYTtgyAQLUgLOZYyDLe4wPpukPVLc9j1XKNUK0BVR87IZtZpV0hFwp0fP0I60qidM/g+CJzAiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bAfl9s6aXfwpEU2dMYC/8CfKmR8alos9r7tL6M/SwM=;
 b=eW1Mte+4chapVJ4o1CGAYty5PDS3vjooOVwZ4P8l1+NW9pfMy0d8IC8nb6TamJVUBB3HQ6Tekw3cpFUpi5ypqqgBX0NXBiYGahwAnoDZh1azyrFWrc00LvLVwIuSqZ1sh1/S2iV6AB1rE7aORWrgtrSr8SGte2dC0/4Azob2eFaNDjxIulo99JYKtvnH96OctC8LBPmEk6PsSiyr56juF8MYMKTrIuzYvXvgD5OZjxZ8i71udKVi6POKCVpTVpTskZvOilmI+yzeyUK9Zy0Gqdl+Z6JN8084MEgr9g3ms6iGx/Q4M+gDDqdE6/24FjgL8NNkpD2eZtjYpiWNjcuuRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bAfl9s6aXfwpEU2dMYC/8CfKmR8alos9r7tL6M/SwM=;
 b=QwbmOp7PzGVasgpcxHxemeccZn5zolcIFS/aZIGhW+nmtjlddJtDo3pk8UZrTT+JsGdEgh0es9ixEe4D5ALDaM57NZE5SZIZmE4mD71Ed8j5fGuy4mz43biQNscwZSWVft2dN/m7woQzId3LKNVMTJzG/9ugVmMf5qtRMei7j4bZyRjxJ72THK0OHhH7AjDqDZlcrSQ3Dblaaax3Jd3WypFEngZQXyRgOljc2CbeLeJLPCMx0zwxcLlcc8zzxrmwZMh7VnqyLG4EaLP+TCMomJj4dtC26IkPp9CmTu759+SrJfFYanYmElHVOfxLOQ8zOapuRHtzGHaXnLzQaJxGHQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7485.namprd02.prod.outlook.com (2603:10b6:a03:290::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.34; Fri, 3 May
 2024 16:29:00 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 16:29:00 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, Kuppuswamy
 Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova
	<elena.reshetova@intel.com>, Jun Nakajima <jun.nakajima@intel.com>, Rick
 Edgecombe <rick.p.edgecombe@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, Sean
 Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Dave Hansen <dave.hansen@intel.com>, Tao Liu
	<ltao@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: [PATCHv10 06/18] x86/mm: Make
 x86_platform.guest.enc_status_change_*() return errno
Thread-Topic: [PATCHv10 06/18] x86/mm: Make
 x86_platform.guest.enc_status_change_*() return errno
Thread-Index: AQHainGOGgLZb+RBzEGqD3vxVAH8/rGF1L6A
Date: Fri, 3 May 2024 16:29:00 +0000
Message-ID: <SN6PR02MB41574C2859020B4FD2769703D41F2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-7-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240409113010.465412-7-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn: [lLXVGSFLIWgI8GBDoptx5TBo15FYb8dJ]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7485:EE_
x-ms-office365-filtering-correlation-id: 22955027-b143-44c5-aea9-08dc6b8e2375
x-microsoft-antispam: BCL:0;ARA:14566002|461199019|102099023|440099019|3412199016;
x-microsoft-antispam-message-info: H6HAeNE9XHVPsyUY8duZJqk1ngNKp4oNN0WkIdJEcr7n9vuGPg6DSogP2mAy24bYPn3zzE1e4vPw8kBJLWX7L4BTnYsUm8S4gsdC/EWFM493DB8Eid2l4+jb0BH/b/Lhhgup2bu/I9pYRTM3mVjdLewy2r1qrKKSmYmpxjgb7NROwWyiISc7ipTmdxuXXXOaU+Lil/8ERxZIlrGkWapQ32F8KSyHia05MAZDP40InNcS5XaeFmg31k0GmmWtvmSanL0VQ92DWoa1q28A9MA3BXSSMHSziazpSM5pdyNfz0YqNjRHJX4/r30x5NuqVSWtebSeYc88htqr49XLjcBEMtxQ4ApyJ3o3C4IHvGZUFtya6qL3MN4Gnpl2lTmBV77xEJgviy4k+nAJrRPqX/FXl5Ku3/Kq0Q+UZx4WFoNo5XMVVgBlBj/BvLvGNFhemDQ8/w1an+xswzvhyDjO7ZVCVBeoPHLXUWaofYf42xDAPlgRYe8f8Zu3JT/iL2rrIFeDHfgJYUSDQFmKRgkajs9V4flffbr/aK+3FBuYbg0bwaG/ARnuwx0NDTYfZ3gb7WXb
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1d8QWYCm2HA4i3QEeqXV1q+pj3A4ShmQ2vu42AGp1T67a1aywmk0yPwZpiAq?=
 =?us-ascii?Q?DpZin0pDlA5G6lVKUN4Jic5UW7GqpMJCZS3nZXp4ho6B5M/UqySI5MCq6a+I?=
 =?us-ascii?Q?JjWVSExHX1JvsDpOsxg++1xl2IHBhQzASqPnQlv1ZCoeKiyVDcPUETlyV0JN?=
 =?us-ascii?Q?6Pu9zf/apzGd7eYyVPFaEv7D4dc/Bc8RwVteZJrvB5BvbXM4bIlLuPQNI3gl?=
 =?us-ascii?Q?8BA/fsTF/CQAQGid+ZRSB6SOtCrbWWsnl+tmNtK0UUlgNlnmIgCDTy4xEqxn?=
 =?us-ascii?Q?35qGs0z6pYJi/K+sf/UecWTcUKZgw8rJD/9XtxzcAkvF9trGr5ZjxVGGCX9B?=
 =?us-ascii?Q?8j2cTRav7v5lMWe/4J2UdfMVQUdYe2r08mHysUEnixwzL+pN3dnAYC/sRMU5?=
 =?us-ascii?Q?/kn8blGLIFG9y/VTIHtm7uC3GQD9Y4JwHDQiDweSxxURmvLhTGQt0F8oyCIY?=
 =?us-ascii?Q?+20/vIUfaa4+NwrLLUEzUiqZN4qUUNRGT3/T9ngPbVK22ypX1g7DrgX4xLEm?=
 =?us-ascii?Q?0a3m7DLNumuhNQqI7uQaYaTmOei/10LfJpKlfefsrbU82+0Fn4lMY3NdV11x?=
 =?us-ascii?Q?R07vTSh+5LFHoyc1BHNR8lFYojUGP9Zgyu9rFyh/j4AV+d0GrOJ8cVneWr4B?=
 =?us-ascii?Q?rYn4/EiWDNN2vpE9BOVbdj6fLLwsP+SsuxJldalZ6nMul48vL3WFE4zXCfEi?=
 =?us-ascii?Q?G0g1eglZHThcVqVB6D0gxiXVbuDcrMFGSZzUZs0i4X2nQXYLN2amUkNTbDhL?=
 =?us-ascii?Q?4XEKVA25H2ht+RaOJH8jLeRMimBDl6trhZp8lP84zj2c413tCxkR3bOp44JO?=
 =?us-ascii?Q?F4dBkD4GqYjzd1JGEJnCmcpvh7ocpT5CkyAs4rkkqz8/EcR+jlYF3JakB9Xz?=
 =?us-ascii?Q?6I8WpJyze82BguRcByEEsf236RuIIsOm5GB/eiKIlaveE9aqnp7f1YQpxgLb?=
 =?us-ascii?Q?tuu8EnIx1P9OKEYxqfgsIslEyjuGPPpoznJd2cxQfWlyqjWa9K1i47uJchto?=
 =?us-ascii?Q?BG8u6YiS8n006vV4zpbUnvcYD421mE7JaM5xcfFoeqpgoM/7g12RJiNDoi2B?=
 =?us-ascii?Q?YWdVBncCGtBdq0VQNRl+emJmUZS+jukxbcUqURojTpE6EdxgRvhAaZtNsx5B?=
 =?us-ascii?Q?C50eLrCtDxM2+esTIXGXO9fy8g6hPVBODloINLcU0MiSPxZrPcgSzPQJqjQl?=
 =?us-ascii?Q?JQmXmARpkhpu1TMKV+mB3vtfPxeGxkhO335725Ru9BbEKYOaUOUtLNv173I?=
 =?us-ascii?Q?=3D?=
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 22955027-b143-44c5-aea9-08dc6b8e2375
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 16:29:00.4168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7485
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240503_172914_039633_B2EA369C 
X-CRM114-Status: GOOD (  24.36  )
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

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com> Sent: Tuesday, April 9, 2024 4:30 AM
> 
> TDX is going to have more than one reason to fail
> enc_status_change_prepare().
> 
> Change the callback to return errno instead of assuming -EIO;
> enc_status_change_finish() changed too to keep the interface symmetric.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Tested-by: Tao Liu <ltao@redhat.com>
> ---
>  arch/x86/coco/tdx/tdx.c         | 20 +++++++++++---------
>  arch/x86/hyperv/ivm.c           | 22 ++++++++++------------
>  arch/x86/include/asm/x86_init.h |  4 ++--
>  arch/x86/kernel/x86_init.c      |  4 ++--
>  arch/x86/mm/mem_encrypt_amd.c   |  8 ++++----
>  arch/x86/mm/pat/set_memory.c    |  8 +++++---
>  6 files changed, 34 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index c1cb90369915..26fa47db5782 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -798,28 +798,30 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
>  	return true;
>  }
> 
> -static bool tdx_enc_status_change_prepare(unsigned long vaddr, int numpages,
> -					  bool enc)
> +static int tdx_enc_status_change_prepare(unsigned long vaddr, int numpages,
> +					 bool enc)
>  {
>  	/*
>  	 * Only handle shared->private conversion here.
>  	 * See the comment in tdx_early_init().
>  	 */
> -	if (enc)
> -		return tdx_enc_status_changed(vaddr, numpages, enc);
> -	return true;
> +	if (enc && !tdx_enc_status_changed(vaddr, numpages, enc))
> +		return -EIO;
> +
> +	return 0;
>  }
> 
> -static bool tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
> +static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
>  					 bool enc)
>  {
>  	/*
>  	 * Only handle private->shared conversion here.
>  	 * See the comment in tdx_early_init().
>  	 */
> -	if (!enc)
> -		return tdx_enc_status_changed(vaddr, numpages, enc);
> -	return true;
> +	if (!enc && !tdx_enc_status_changed(vaddr, numpages, enc))
> +		return -EIO;
> +
> +	return 0;
>  }
> 
>  void __init tdx_early_init(void)
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 768d73de0d09..b4a851d27c7c 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -523,9 +523,9 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
>   * transition is complete, hv_vtom_set_host_visibility() marks the pages
>   * as "present" again.
>   */
> -static bool hv_vtom_clear_present(unsigned long kbuffer, int pagecount, bool enc)
> +static int hv_vtom_clear_present(unsigned long kbuffer, int pagecount, bool enc)
>  {
> -	return !set_memory_np(kbuffer, pagecount);
> +	return set_memory_np(kbuffer, pagecount);
>  }
> 
>  /*
> @@ -536,20 +536,19 @@ static bool hv_vtom_clear_present(unsigned long kbuffer, int pagecount, bool enc
>   * with host. This function works as wrap of hv_mark_gpa_visibility()
>   * with memory base and size.
>   */
> -static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bool enc)
> +static int hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bool enc)
>  {
>  	enum hv_mem_host_visibility visibility = enc ?
>  			VMBUS_PAGE_NOT_VISIBLE : VMBUS_PAGE_VISIBLE_READ_WRITE;
>  	u64 *pfn_array;
>  	phys_addr_t paddr;
> +	int i, pfn, err;
>  	void *vaddr;
>  	int ret = 0;
> -	bool result = true;
> -	int i, pfn;
> 
>  	pfn_array = kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
>  	if (!pfn_array) {
> -		result = false;
> +		ret = -ENOMEM;
>  		goto err_set_memory_p;
>  	}
> 
> @@ -568,10 +567,8 @@ static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bo
>  		if (pfn == HV_MAX_MODIFY_GPA_REP_COUNT || i == pagecount - 1) {
>  			ret = hv_mark_gpa_visibility(pfn, pfn_array,
>  						     visibility);
> -			if (ret) {
> -				result = false;
> +			if (ret)
>  				goto err_free_pfn_array;
> -			}
>  			pfn = 0;
>  		}
>  	}
> @@ -586,10 +583,11 @@ static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bo
>  	 * order to avoid leaving the memory range in a "broken" state. Setting
>  	 * the PRESENT bits shouldn't fail, but return an error if it does.
>  	 */
> -	if (set_memory_p(kbuffer, pagecount))
> -		result = false;
> +	err = set_memory_p(kbuffer, pagecount);
> +	if (err && !ret)
> +		ret = err;
> 
> -	return result;
> +	return ret;
>  }
> 
>  static bool hv_vtom_tlb_flush_required(bool private)
> diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
> index 6149eabe200f..28ac3cb9b987 100644
> --- a/arch/x86/include/asm/x86_init.h
> +++ b/arch/x86/include/asm/x86_init.h
> @@ -151,8 +151,8 @@ struct x86_init_acpi {
>   * @enc_cache_flush_required	Returns true if a cache flush is needed before changing page encryption status
>   */
>  struct x86_guest {
> -	bool (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
> -	bool (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
> +	int (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
> +	int (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
>  	bool (*enc_tlb_flush_required)(bool enc);
>  	bool (*enc_cache_flush_required)(void);
>  };
> diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
> index d5dc5a92635a..a7143bb7dd93 100644
> --- a/arch/x86/kernel/x86_init.c
> +++ b/arch/x86/kernel/x86_init.c
> @@ -134,8 +134,8 @@ struct x86_cpuinit_ops x86_cpuinit = {
> 
>  static void default_nmi_init(void) { };
> 
> -static bool enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool enc) { return true; }
> -static bool enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return true; }
> +static int enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool enc) { return 0; }
> +static int enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return 0; }
>  static bool enc_tlb_flush_required_noop(bool enc) { return false; }
>  static bool enc_cache_flush_required_noop(void) { return false; }
>  static bool is_private_mmio_noop(u64 addr) {return false; }
> diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
> index 422602f6039b..e7b67519ddb5 100644
> --- a/arch/x86/mm/mem_encrypt_amd.c
> +++ b/arch/x86/mm/mem_encrypt_amd.c
> @@ -283,7 +283,7 @@ static void enc_dec_hypercall(unsigned long vaddr, unsigned long size, bool enc)
>  #endif
>  }
> 
> -static bool amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool enc)
> +static int amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool enc)
>  {
>  	/*
>  	 * To maintain the security guarantees of SEV-SNP guests, make sure
> @@ -292,11 +292,11 @@ static bool amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool
>  	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && !enc)
>  		snp_set_memory_shared(vaddr, npages);
> 
> -	return true;
> +	return 0;
>  }
> 
>  /* Return true unconditionally: return value doesn't matter for the SEV side */
> -static bool amd_enc_status_change_finish(unsigned long vaddr, int npages, bool enc)
> +static int amd_enc_status_change_finish(unsigned long vaddr, int npages, bool enc)
>  {
>  	/*
>  	 * After memory is mapped encrypted in the page table, validate it
> @@ -308,7 +308,7 @@ static bool amd_enc_status_change_finish(unsigned long vaddr, int npages, bool e
>  	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
>  		enc_dec_hypercall(vaddr, npages << PAGE_SHIFT, enc);
> 
> -	return true;
> +	return 0;
>  }
> 
>  static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 80c9037ffadf..e5b454036bf3 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -2156,7 +2156,8 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
>  		cpa_flush(&cpa, x86_platform.guest.enc_cache_flush_required());
> 
>  	/* Notify hypervisor that we are about to set/clr encryption attribute. */
> -	if (!x86_platform.guest.enc_status_change_prepare(addr, numpages, enc))
> +	ret = x86_platform.guest.enc_status_change_prepare(addr, numpages, enc);
> +	if (ret)
>  		goto vmm_fail;
> 
>  	ret = __change_page_attr_set_clr(&cpa, 1);
> @@ -2174,7 +2175,8 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
>  		return ret;
> 
>  	/* Notify hypervisor that we have successfully set/clr encryption attribute. */
> -	if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
> +	ret = x86_platform.guest.enc_status_change_finish(addr, numpages, enc);
> +	if (ret)
>  		goto vmm_fail;
> 
>  	return 0;
> @@ -2183,7 +2185,7 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
>  	WARN_ONCE(1, "CPA VMM failure to convert memory (addr=%p, numpages=%d) to %s.\n",
>  		  (void *)addr, numpages, enc ? "private" : "shared");

Nit: Now that there's an error code instead of just a boolean, it would be nice
to have this warning message include the error code.  Some of the callers of
set_memory_decrypted()/encrypted() also output a message on failure that
includes the error code, in which case this message will be redundant.  But
many callers do not.

> 
> -	return -EIO;
> +	return ret;
>  }
> 
>  static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
> --
> 2.43.0
> 

My nit notwithstanding,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

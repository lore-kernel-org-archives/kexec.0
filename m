Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799B8C54798
	for <kexec@archiver.kernel.org>; Wed, 28 Feb 2024 00:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qao2/yn2PxUIXWmEDVKb/8BlI/TZYYAFLsiOLwDtxxI=; b=hE50EsrOsJ5g6d
	mq7PyLqO519qT7c8NuNpnu9xYUjXqKlJMwzMu0BpxmZN++QeNHD4K+AOWlxegkdhFV1nLtDuK1b4w
	bw3eZlJTbp9Qx4j440lWXrRDScCfQXNVytyVKlxWSiHTi0Mav8RV9xepFnXUptFspsx4Cmg8Uf3ux
	12rC8kU7EG9YwzSChkDGesakLBIJg8Z6OXe/7CG51AdjkovNllhy0v4Npw6XisgKBra7KOv+jixPp
	66TAjAW8tjw0MiEeRPiz9KEuhyywWxUaf8FcaZS3kyluMv+B5eofal1TMEAe2pl23mCY8LdAgGw8A
	B5ywmfhvxnDcwA4pGtWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf7lL-00000007O3F-0W2V;
	Wed, 28 Feb 2024 00:25:31 +0000
Received: from mail-os0jpn01on20601.outbound.protection.outlook.com ([2a01:111:f403:201a::601] helo=JPN01-OS0-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf7lI-00000007O2b-1BgS
	for kexec@lists.infradead.org;
	Wed, 28 Feb 2024 00:25:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KT76YBz9ItUIp5SngQuLCIBAvyTZDPk4ASeLPmOVTILCgqCH7lLQ4YmAa0MmBd5zfjGMdBhDfok4kgxl16VZbvz5OPow1SreBHE65mmxYXCNhP3YUEzid8T74xEDZ1ny4VB+q8woenDgeBawdpRguIOuIH8tKNJ/82VLPlYSABBsSH5WxnJXCzrHDWiWxEPB9DZAYiUPmZ60cCSu4r2pcI5337WFKZMKQZ0yc9ACr1LK4/wr5zKr2emrk1Dnmh3MbEHSCEo23Zq0zyDscrABYLpMUUlCgcbDFr4cK3Vkrg/PULTP7y8CJfLh+rlz3i82c9IyvdRtthhv/PuAdtP4DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqBIYrgd49FfzstfFowBX6hA99YV3wFwo5JRSEEaSAY=;
 b=Y0k+4H3bFgWdopWZ6whhsJJbSnpvq08qy4gAJmENMdWNvCq/1QEcs1EugOB+fIknALuTGwcb3dxOfEqK+ocxAq4gFqhyyZ6wEORw52vBZMEQvv1hL+sWF7771NHQ5Yh4ZA23ZRE5YXtnbZKb0h6FBdBpUo2UgGB8yMux4q+iYMgdWs6GLGjsXS0W5S60sxEJdy2rW1iytP5VVNJmrT8y9PnUMIew9MfuT7hgJFcU3mIzcD54lNKXzodyzo6L8BaCYv3YzHnvCuQfrU4xaBMG0GDLfCkrGyy3n1fe81Pm3R6lt/4LwUiEcyDgrXCVoTYnvYIlAr73YWN/bA0x6UPbNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqBIYrgd49FfzstfFowBX6hA99YV3wFwo5JRSEEaSAY=;
 b=oNi5UROKuGvZQNpHqA/k8smr0skuujQrly1xVGTLUNVOSXgv5MMEIEnYtARawh5/K4UKF0tD5sTuLnbE0VYa7nZ+ah0+oJ2r2MuKB2K3jKBto011KmNqnwqdJz37EMh2dKBaeQTjuMuT8SelJ10k2ikGZpA1VcHGWqxeTuxbyLGrAZKni8jhxuvfcCcHVFKfnirIYr1Jh/suq68w+J6VaAHzxrI3LQVYak+HE+61JwzPMJHUZj93oBqdxBG+s7nD8QqUByonzRX2fNo5OCByzau9CJ4qY1PAEXjnV09OO4JRLZOAoWtRxKiX229UqGavptZuXtvkgP6AZjBRgWh3aA==
Received: from TYWPR01MB8608.jpnprd01.prod.outlook.com (2603:1096:400:179::5)
 by OS3PR01MB6181.jpnprd01.prod.outlook.com (2603:1096:604:d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 00:25:05 +0000
Received: from TYWPR01MB8608.jpnprd01.prod.outlook.com
 ([fe80::cfdc:527a:433e:fac8]) by TYWPR01MB8608.jpnprd01.prod.outlook.com
 ([fe80::cfdc:527a:433e:fac8%4]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 00:25:04 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Aditya Gupta <adityag@linux.ibm.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
CC: Baoquan He <bhe@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>, Mahesh
 J Salgaonkar <mahesh@linux.ibm.com>, Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH] makedumpfile: ppc64: read cur_mmu_type from vmcoreinfo
Thread-Topic: [PATCH] makedumpfile: ppc64: read cur_mmu_type from vmcoreinfo
Thread-Index: AQHaZjPZyNvVpPFx+UOPZSe5BC48CbEe7HqA
Date: Wed, 28 Feb 2024 00:25:04 +0000
Message-ID: <b57e7684-ccc3-4a7a-bcbf-3ecd9429cbc4@nec.com>
References: <20240223083913.135091-1-adityag@linux.ibm.com>
In-Reply-To: <20240223083913.135091-1-adityag@linux.ibm.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8608:EE_|OS3PR01MB6181:EE_
x-ms-office365-filtering-correlation-id: b8fa27c1-061d-4f7e-b452-08dc37f3b5d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jo6g+QEgELN+bDXe5RliI+DqS4x1keOiGj3xjQgCXNgnzG+HlASTg6snVenHz6Uuro6SnUUnmxKD2euFqQJmRSMlZ5IHxWue1/cxMzzykKR3JkUcu+arlyGtOxN2lJRM18RcEZ/8xcMCB6esPKzdFTVpNwBKepwVjyHpZuUWvFWilP/LNR3xOr9pHfBhDmXfpau3jOW+HnDpHHKlMzxBB1ncWabwpLHv3VwGZQIF+hefXKbiiJfNa5z5op51vjckTBVRISQ9lruQuI6EXdsmx2G9tmh1zs6NEcMcrnldKOMnvOylmpmDYetzUEwHhdmryZFhJNmtwGTFMrhTPOVY7dPwqzPq6eVs4xkefCK0fJhGsHsFssWxUVX9UAGtdihbzoD5eMO8g+PsL/9xhnydUzeKl6Npi5XBUD6k26lKOEl7m4P8LdPAdHUtotutOF1hqftyl8X4qcO4zWs4Zeg2V1QXiUfKE/lvMhFHYIeKZVIdMK96fLL8PXS2QhDzgS2aheQjVx+2nkVtDGr3cnMvPpo34iGaCdqKDeZAmt8EgtvDAlwEUB9WItVFlurPr6oJMgOCqBWI6riphIUtKDPxmvPWJFxXSYQHPzOc+9Clzw4SZ6HX4Nj2zyGcODJv6Gi6p2EwmwdG1LiYrNGoe9RudYZmvwhXRb6EZTjVkVOLVaFr/znlqQNb7ZcLLA706DZgreakUWtUjl6RzvpYZnhSNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8608.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3J2NVpqSVBkNStFTGtyQkZVQlVGOEdyZ202cVN2N2FHSDd5RXg3eitqeGpW?=
 =?utf-8?B?RlNVOC9LRUZSengybWptb2hkN1ZhSEJUYkRhM3E2UXBiL3Iyay9iemJMcUpH?=
 =?utf-8?B?MkRnaUZlNnpidnl0Ly9DVmFnTGFjcDlVbW1YbnJmb3dSbldwclducytOeHJs?=
 =?utf-8?B?REU4cXVscDdqeTFmSUJaT2g4akU0Q2MzLzZHeTZoUVd5bXhmM0R5NU15Mm5C?=
 =?utf-8?B?SFRieS8vdHIrV21IRkZLM0NvVmVsR2pLODVvWEVweElnZnBzb3ZiVS9RS3hK?=
 =?utf-8?B?NEJKQllXY2hkdkpZZzRidkRydHR5bmZMd1dFOUF6UkNsZVpsYTNFeVBPWjdq?=
 =?utf-8?B?N2JRTE9Udk1pcjBVMm1ncEdXTmRGQ2daa3dLWnduLzdtbFFMV2RPWWlLNkFQ?=
 =?utf-8?B?NTdmQ0NkK2tHOG9uS05yQllPbnc4QlkrT2VIREppTm9pN2REaDJKWVRzTkZi?=
 =?utf-8?B?U2hYQmVUQWRoMVU5WG93VXRYdUU3TGc1NFl3RDlyRjF5TTJaQ1FWdDQ3aWNl?=
 =?utf-8?B?LzZSMzAyNEhBZ29wSFVxdVRVRlIzNHo5cGtmb1M3b2N5THZBbjNzUm93dUty?=
 =?utf-8?B?WElWUm15ZklBQ0Vadmx3WFkwWmovWnA2NXl3UC9mTzM0WkhFaGlGUEdXU2RD?=
 =?utf-8?B?R0tMLzlweWpmaTRJVFFZTmlQVDQza0dQdlNxMng3RXo4aWkxeXdPdUN2cXE0?=
 =?utf-8?B?eTFUQlg1MysvQndXdXBKcDhzMlBmSWtyMWYzM3R1by94VGVUOU9naEI4TWJu?=
 =?utf-8?B?Z0JrcnFCYnRLWmtPYU9QcXlrMFZ4WUg2ZG15UU9lUzlBZWZrRGFGWk5rY3ZT?=
 =?utf-8?B?Ump0UURHRmRRR1QyOEY1SDhIWk9tOExBeC9mMW1vaDN3WmFMMFN2SlR1a29F?=
 =?utf-8?B?RUhROTgvelNnQlBIZHAvOVlIMGpaUjJpREJiNndVd0VkZ0EyZGM1bktBRFh2?=
 =?utf-8?B?NWIxOU92b2VSTkZ5VlFLa0VNcDZhZktxYTJLZU9TMVZRUnZCeCthb04zUFdM?=
 =?utf-8?B?ZWtrQzl6c1BZTWRuNFQxVTd4NW1sNzNXRHd0QmZUcUUyeTJIcDlEMFFoNHRi?=
 =?utf-8?B?OHdjT2RReGxhNDNyVUVHWEl0WG0wWHpxQ2EvZFhEamNjTk5KTXUzVUZZZlBV?=
 =?utf-8?B?enlNRCtpS1BQeXZBNzlQaDdjT1ZZOElwZXRUU1JnYnM5ZzltVDhoaGFGWm1D?=
 =?utf-8?B?QXprRVBoMTV2SzE0MVBSNU9IZitvNnl6NXAzQnVTai9GSFhqUkgyK1pQWUtn?=
 =?utf-8?B?eGd3VS9RY1RReW5FZkJ3N0puVHc3TVV3N3pGUEFSNmp5TE45bjl3ZVhKU05s?=
 =?utf-8?B?TGJhY09iVG1JbXZnNll1K3pHdC9MeWhqaENlclVxRGxBbUFFWCtUb1pBcnNT?=
 =?utf-8?B?azJSMVR2bnd3QzZIaWNUc2dFVkNMYU1SU28wdDlkZWdnL1p3dkNUUVphMldR?=
 =?utf-8?B?TmZraXdrNTFrRVVMTm5CT2hJTzg1Mkk1V2Zic3ZXUXJ2VEVxTTM0cEpSNzJI?=
 =?utf-8?B?UnlQRm5RMFZKR2trcWFFR0pHUk0zVGJ1eUhYYWNISmJTUFBqQTlwckZSdHlS?=
 =?utf-8?B?VWFNOXpWcjZjQ3I1RjBGNUd3alUyaDlueFJhTmV4a3NENFh4eDBJRW1Wd2RF?=
 =?utf-8?B?RHVac1A0NStscXRVRFRjU1VsUGdMS0Z1N2p2a1Jtc2I5d0lpRktmcnBZT1Jz?=
 =?utf-8?B?a0dlMHlUZmhLVHVKQmdiR0RnaGk5UmF2ZHQyRU5pZSs1d01hV3BQQVdFR1dh?=
 =?utf-8?B?T2dyVHVVc1RlNEx5Wlo0T0VnbktnY2p3U0hmd0o2bFI5d2dGVDk1Z2JyU0wz?=
 =?utf-8?B?TXRkTi9TQVA3Kzd5VUVGT09QWHFqTFJ1ekFsT2owbkFtNExDTFp5NGpsakNz?=
 =?utf-8?B?UVR3cGxYenduSmNWSCttWHFFek9KSW1wMEZOQnBLMDVMbEhTWWpaVTVsUS9h?=
 =?utf-8?B?M1RlMkdudmFQL2tVdzBlVU1KME5Yd252RFRMeU9oeXlTWEdZN2tVb3JNVDhI?=
 =?utf-8?B?dExWYXhrWjA0RjJqTlJ2SnM1TWJnS0Z5OGlOYmwrVmFLWlh4VUE2a3NxQVFj?=
 =?utf-8?B?bUJqcS91Qk9XWUd6KzZlZXBTb3JJT2VXSEgyelFudzA4WWNuNmdpalVrbEto?=
 =?utf-8?Q?hA/RvoNYTht5Euqx1fNwT1hsn?=
Content-ID: <F3841DB80CCAC74A89B00C0FA8F32F17@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8608.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8fa27c1-061d-4f7e-b452-08dc37f3b5d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 00:25:04.6819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O/NxS1AN7fAdsQJ52kIb0MH5aYZKQowEIgTbv1wAsV69fYOy6MJZXVNw+gTM7XxWp4XlUzvUFRYaXpsxVcyZuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6181
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_162528_594938_7DF01DC3 
X-CRM114-Status: GOOD (  27.74  )
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

On 2024/02/23 17:39, Aditya Gupta wrote:
> Currently makedumpfile depends on reading the 'cur_cpu_spec' kernel
> symbol to get the current MMU type on PowerPC64.
> 
> The disadvantage with this approach was that it depends on bit '0x40'
> ('MMU_FTR_TYPE_RADIX') being set in 'cur_cpu_spec->mmu_features',
> which implies kernel developers have to be careful of modifying
> MMU_FTR_* defines
> 
> Instead a more stable approach was suggested by contributors in
> https://lore.kernel.org/linuxppc-dev/87v8c3m70t.fsf@mail.lhotse/, to
> pass information about the MMU type in vmcoreinfo itself, instead of
> depending on the MMU_FTR_* defines
> 
> This was implemented in linux kernel in:
>      commit 36e826b568e4 ("powerpc/vmcore: Add MMU information to vmcoreinfo")
> 
> With this commit, if RADIX_MMU is there in the vmcoreinfo, we prefer it
> to get current mmu type, instead of 'cur_cpu_spec'.
> On older kernels, where RADIX_MMU number is not there, makedumpfile will
> simply fall back to using 'cur_cpu_spec'.
> 
> The earlier defines for 'RADIX_MMU' have been renamed to 'MMU_TYPE_RADIX'
> which avoids conflict with the vmcoreinfo string 'RADIX_MMU', as well as
> being more clear about the value 0x40 with a comment about MMU_FTR_TYPE_RADIX
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>

Thanks, applied.
https://github.com/makedumpfile/makedumpfile/commit/71ac00c8a3464608ac19f7c89d7220073d7374a9

Kazu

> ---
>   arch/ppc64.c   | 15 ++++++++++-----
>   makedumpfile.c |  1 +
>   makedumpfile.h |  9 ++++++---
>   3 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/ppc64.c b/arch/ppc64.c
> index 96c357cb0335..3b4f91981f71 100644
> --- a/arch/ppc64.c
> +++ b/arch/ppc64.c
> @@ -250,7 +250,7 @@ ppc64_vmalloc_init(void)
>   		/*
>   		 * 64K pagesize
>   		 */
> -		if (info->cur_mmu_type & RADIX_MMU) {
> +		if (info->cur_mmu_type & MMU_TYPE_RADIX) {
>   			info->l1_index_size = PTE_INDEX_SIZE_RADIX_64K;
>   			info->l2_index_size = PMD_INDEX_SIZE_RADIX_64K;
>   			info->l3_index_size = PUD_INDEX_SIZE_RADIX_64K;
> @@ -300,7 +300,7 @@ ppc64_vmalloc_init(void)
>   		/*
>   		 * 4K pagesize
>   		 */
> -		if (info->cur_mmu_type & RADIX_MMU) {
> +		if (info->cur_mmu_type & MMU_TYPE_RADIX) {
>   			info->l1_index_size = PTE_INDEX_SIZE_RADIX_4K;
>   			info->l2_index_size = PMD_INDEX_SIZE_RADIX_4K;
>   			info->l3_index_size = PUD_INDEX_SIZE_RADIX_4K;
> @@ -635,14 +635,19 @@ get_versiondep_info_ppc64()
>   	 * On PowerISA 3.0 based server processors, a kernel can run with
>   	 * radix MMU or standard MMU. Get the current MMU type.
>   	 */
> -	info->cur_mmu_type = STD_MMU;
> -	if ((SYMBOL(cur_cpu_spec) != NOT_FOUND_SYMBOL)
> +	info->cur_mmu_type = MMU_TYPE_STD;
> +
> +	if (NUMBER(RADIX_MMU) != NOT_FOUND_SYMBOL) {
> +		if (NUMBER(RADIX_MMU) == 1) {
> +			info->cur_mmu_type = MMU_TYPE_RADIX;
> +		}
> +	} else if ((SYMBOL(cur_cpu_spec) != NOT_FOUND_SYMBOL)
>   	    && (OFFSET(cpu_spec.mmu_features) != NOT_FOUND_STRUCTURE)) {
>   		if (readmem(VADDR, SYMBOL(cur_cpu_spec), &cur_cpu_spec,
>   		    sizeof(cur_cpu_spec))) {
>   			if (readmem(VADDR, cur_cpu_spec + OFFSET(cpu_spec.mmu_features),
>   			    &mmu_features, sizeof(mmu_features)))
> -				info->cur_mmu_type = mmu_features & RADIX_MMU;
> +				info->cur_mmu_type = mmu_features & MMU_TYPE_RADIX;
>   		}
>   	}
>   
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 3705bdd93deb..1bd7305f49ca 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -2987,6 +2987,7 @@ read_vmcoreinfo(void)
>   #endif
>   
>   	READ_NUMBER("HUGETLB_PAGE_DTOR", HUGETLB_PAGE_DTOR);
> +	READ_NUMBER("RADIX_MMU", RADIX_MMU);
>   
>   	return TRUE;
>   }
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 3ed3ba551d96..a7b344974636 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -747,12 +747,13 @@ unsigned long get_kvbase_arm64(void);
>   /*
>    * Supported MMU types
>    */
> -#define STD_MMU         0x0
> +#define MMU_TYPE_STD         0x0
>   /*
>    * The flag bit for radix MMU in cpu_spec.mmu_features
> - * in the kernel. Use the same flag here.
> + * in the kernel (MMU_FTR_TYPE_RADIX).
> + * Use the same flag here.
>    */
> -#define RADIX_MMU       0x40
> +#define MMU_TYPE_RADIX       0x40
>   
>   
>   #define PGD_MASK_L4		\
> @@ -2258,6 +2259,8 @@ struct number_table {
>   	unsigned long kernel_link_addr;
>   	unsigned long va_kernel_pa_offset;
>   #endif
> +
> +	unsigned long RADIX_MMU;
>   };
>   
>   struct srcfile_table {
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

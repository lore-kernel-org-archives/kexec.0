Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F2ECAC5A7
	for <kexec@archiver.kernel.org>; Mon, 22 Sep 2025 02:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bve0wL9neCYopjQikw+sFDgdFEgVaAf58KkneoOdVLI=; b=jxEJe0motfzdwAzfDk6tHW+vMY
	gvGRSq1gtq4iV2zVN96wC+RnoGrx1J6bWxPS2cVeb+g+Qh/f1EYqUmX4JX5YUBzECZdcYn5Eh9GXD
	t4qHz3O5BWdVvX+tg34lok+lM8HV8FDpRxjFYTwcq9irVFFzCElhOfrRema5pLsn1vBPxj9atGxOb
	pF2Qfgyvf5jj1OGq0PfxQTkrcY1cdxLs4VEN6dzK7uQiFUVL65Sc1Adq3L7Cx/W28i1Hi6DiJHv0P
	AHjYeZtaf8Bmfkaf54WiKJpvE9Jzjwy89gG+ro/IJYH+vpPT4AKFA2u1wauw01J0EomoH1JX7NZkO
	AOj6p+ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0WlC-00000008egf-25Ys;
	Mon, 22 Sep 2025 02:58:38 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0Wl5-00000008eg2-2ODU
	for kexec@lists.infradead.org;
	Mon, 22 Sep 2025 02:58:37 +0000
X-UUID: 01232342976011f0b29709d653e92f7d-20250922
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_MISS, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:20d4412c-66ab-493f-b90a-0ac799f22c32,IP:10,
	URL:0,TC:0,Content:7,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:2
X-CID-INFO: VERSION:1.1.45,REQID:20d4412c-66ab-493f-b90a-0ac799f22c32,IP:10,UR
	L:0,TC:0,Content:7,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:2
X-CID-META: VersionHash:6493067,CLOUDID:f9dedc5b97a02604b6d4201fcac3f24f,BulkI
	D:250922105023BFX7STGK,BulkQuantity:1,Recheck:0,SF:17|19|24|44|64|66|78|80
	|81|82|83|102|841|850,TC:nil,Content:4|50,EDM:-3,IP:-2,URL:0,File:nil,RT:n
	il,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,
	BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 01232342976011f0b29709d653e92f7d-20250922
X-User: duanchenghao@kylinos.cn
Received: from localhost [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1070465600; Mon, 22 Sep 2025 10:58:24 +0800
Date: Mon, 22 Sep 2025 10:58:21 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: horms@verge.net.au
Cc: kexec@lists.infradead.org, tangyouling@kylinos.cn,
	chenhuacai@kernel.org
Subject: Re: [PATCH] LoongArch: Change COMMAND_LINE_SIZE to 4096
Message-ID: <20250922025821.GA317763@chenghao-pc>
References: <20250922021057.206063-1-duanchenghao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250922021057.206063-1-duanchenghao@kylinos.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250921_195831_995755_30699E6F 
X-CRM114-Status: GOOD (  21.50  )
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

On Mon, Sep 22, 2025 at 10:10:57AM +0800, Chenghao Duan wrote:
> The default COMMAND_LINE_SIZE inherited from asm-generic is 512, which
> is too small for modern use cases. For example, when the parameter path
> in the cmdline of the kdump first kernel is too long, the limit is
> easily exceeded when loading the second kernel.
> 
> Increase the command line size to 4096 bytes, In LoongArch, this is
> consistent with the upstream configuration of the Linux kernel.
> linux kernel commit: f7794a4d92ade518c813de69a01b27ca6d8d86f3.

I'm very sorry, but the commit ID in the previous email was incorrect.
linux kernel commit: f7794a4d92ad(LoongArch: Increase COMMAND_LINE_SIZE up to 4096).

> 
> This patch is necessary because the Linux kernel has been changed to
> 4096. When the kernel cmdline size exceeds 512, the --reuse-cmdline
> option of the kexec command will inevitably result in an error.
> 
> The COMMAND_LINE_SIZE in kexec/arch/loongarch/crashdump-loongarch.h
> is unused, so it is removed here.
> 
> Suggested-by: Youling Tang <tangyouling@kylinos.cn>
> Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> ---
>  kexec/arch/loongarch/crashdump-loongarch.h | 2 --
>  kexec/arch/loongarch/kexec-loongarch.h     | 2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kexec/arch/loongarch/crashdump-loongarch.h b/kexec/arch/loongarch/crashdump-loongarch.h
> index 25ff24b..dac9e71 100644
> --- a/kexec/arch/loongarch/crashdump-loongarch.h
> +++ b/kexec/arch/loongarch/crashdump-loongarch.h
> @@ -20,7 +20,5 @@ int get_crash_kernel_load_range(uint64_t *start, uint64_t *end);
>  /* crash dump kernel support at most two regions, low_region and high region. */
>  #define CRASH_MAX_RESERVED_RANGES      2
>  
> -#define COMMAND_LINE_SIZE	512
> -
>  extern struct arch_options_t arch_options;
>  #endif /* CRASHDUMP_LOONGARCH_H */
> diff --git a/kexec/arch/loongarch/kexec-loongarch.h b/kexec/arch/loongarch/kexec-loongarch.h
> index 2c7624f..0bd462f 100644
> --- a/kexec/arch/loongarch/kexec-loongarch.h
> +++ b/kexec/arch/loongarch/kexec-loongarch.h
> @@ -13,7 +13,7 @@
>  
>  #define CORE_TYPE_ELF64 1
>  
> -#define COMMAND_LINE_SIZE 512
> +#define COMMAND_LINE_SIZE 4096
>  
>  #define KiB(x) ((x) * 1024UL)
>  #define MiB(x) (KiB(x) * 1024UL)
> -- 
> 2.25.1


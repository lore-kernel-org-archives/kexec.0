Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5727DC61DD6
	for <kexec@archiver.kernel.org>; Tue,  1 Sep 2026 20:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aEZEmYZMoaqekOPk8qqP2ODpRIO0XT0q9KzPXapNk2g=; b=xlyD9DJNLjyDtQCwGLTlzkVtzp
	NZzgzMKFq9sJUzVtuWD+RP1sk5lP5wrywMtGo962FJ2gn/N7LWaew1GMBT/Yp6gr5gQtdnA5iU/QG
	K67BBd5Yd9FjjKjrqlqtCWh74RimAxbeKD/j0jdbjhjmbBCHXFmraYNiln4vjACXxZkCitubSlFlj
	6hfcky56/w1XII101oLuSBbntz9pe7Gahz6txb3LKx8QgrorTG3cu3H35mZGtCQ1dXhzkcaomxu6W
	GQTrdKWeHdJMxzq35WSLTbEOFjTGDycG9WafWkYaZNkVi198iC0m5fY9gAppEOi9yhSae/UJ2L52G
	mtZgtVRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1UsK-0000000DIuF-3F3y;
	Tue, 01 Sep 2026 20:14:32 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1UsJ-0000000DIts-1eMb;
	Tue, 01 Sep 2026 20:14:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8B951600D9;
	Tue,  1 Sep 2026 20:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F541F00A3A;
	Tue,  1 Sep 2026 20:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788293670;
	bh=aEZEmYZMoaqekOPk8qqP2ODpRIO0XT0q9KzPXapNk2g=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=lbice+wLj+lCT8QM98ULT3hhnoph1ybVba4ki8BaTAtUERzwAFL3Q3ECL7S5NT1Bw
	 af2GJr4OE3roJ0CS54vKzLOApz5rbUWlstAZhqaAhUNZ+JAnPt7rSJsk7J5froWi6z
	 n6f784ysOfk8nLzxDJ3tgE66oJGb46pYShdqP6dF53A4x5gCcAGnWTkm2AlG7GUgbe
	 7psRiBXFRCeVSoQRgDSVpVkwPSeHbJYdpqYtqhOmr7exMFXhudxgQCLL7hmUTZebm0
	 wspK7+0gVSANfLCupzkEWgZLef4c9lQ7lAmSrFa9KB3Su9TirvLHRfJcxRMW4GPASs
	 HWsZUWUQSNuLQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 02/17] kexec: Extract kexec_free_segment_cma() from
 kimage_free_cma()
From: Mike Rapoport <rppt@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
 chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, 
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, tglx@kernel.org, 
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
 akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, 
 pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, 
 kees@kernel.org, thuth@redhat.com, gshan@redhat.com, jic23@kernel.org, 
 james.morse@arm.com, ardb@kernel.org, leitao@debian.org, 
 yeoreum.yun@arm.com, sourabhjain@linux.ibm.com, coxu@redhat.com, 
 tangyouling@kylinos.cn, hbathini@linux.ibm.com, adityag@linux.ibm.com, 
 ionut.nechita@windriver.com, liaoyuanhong@vivo.com, seanjc@google.com, 
 fuqiang.wang@easystack.cn, makb@juniper.net, piliu@redhat.com, 
 ebiggers@kernel.org, jbouron@amazon.com, mclapinski@google.com, 
 me@linux.beauty, graf@amazon.com, bgwin@google.com, robh@kernel.org, 
 takahiro.akashi@linaro.org, palmer@rivosinc.com, x86@kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org
In-Reply-To: <20260826092541.3905933-3-ruanjinjie@huawei.com>
References: <20260826092541.3905933-1-ruanjinjie@huawei.com>
 <20260826092541.3905933-3-ruanjinjie@huawei.com>
Date: Tue, 01 Sep 2026 23:14:00 +0300
Message-Id: <178829364020.3691424.17302958503793700435.b4-review@b4>
X-Mailer: b4 0.17-dev
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

Hi,

> kimage_free_cma() relies on image->nr_segments to iterate over segments.
> When an architecture loader (e.g., arm64) truncates nr_segments on a
> mid-way failure, CMA pages allocated beyond the new boundary become
> unreachable, causing silent memory leaks.
> 
> Extract the per-segment freeing logic into the exported helper
> kexec_free_segment_cma(), so that architecture loaders can release
> individual segments before nr_segments is truncated. Refactor
> kimage_free_cma() to loop over the new helper, preserving existing
> behavior.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 83c296c0eb6cc..d7c83938dfd3d 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -533,6 +533,7 @@ extern bool kexec_file_dbg_print;
>  
>  extern void *kimage_map_segment(struct kimage *image, int idx);
>  extern void kimage_unmap_segment(void *buffer);
> +extern void kexec_free_segment_cma(struct kimage *image, unsigned long idx);

No need for extern, even though it's inconsistent with old declarations.

-- 
Sincerely yours,
Mike.



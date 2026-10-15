Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC47CC6B2F
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 08:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k8El4r9kmcBjSvocgSz2oUF4ZFCHqS1+xsg30+hV1TU=; b=aqA/nCbTa5zi0WAeYA5whzN0nk
	czvZMZoRHZ7btGU35aepVKF2qze+uF/zfBFedEmJc04OAjQKxxiwUtMByRreG1E5/RE1JuAx0+zt1
	UQoIrjqP315NmnH4Tj0NgOwtzv5o01e+ljk1Fvk6hKwM1+vRwZ2b1ixWgKFJmQ4taq3FxIcXpxujd
	1XiuNzCt3aCdWVC528pkS24qeKbwcrLydR0NO8nJv6XRZeydZ2Epw0gwheNToUHstmiqVsqdBLcCo
	7lwSjl2gHvt/sF+AexVjEqj3kPQwW/wQ8tvkn5Tpzssc1PziRnwK4jrAuyoBdG5nV4WpoPr8aK1II
	QpZuKmbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHGYE-0000000H732-3RpO;
	Thu, 15 Oct 2026 08:10:58 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHGYC-0000000H72t-2LqK
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 08:10:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1133C410A3;
	Thu, 15 Oct 2026 08:10:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331691F000C4;
	Thu, 15 Oct 2026 08:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792051855;
	bh=k8El4r9kmcBjSvocgSz2oUF4ZFCHqS1+xsg30+hV1TU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cNSSuVBEww63PNgXf33nf+5D5YQxFDye0o+j6LIJdhUnAuqlirHwoGQ7f/K84Y1/A
	 ZeE6l8cwI64APgJM+lP4vbQ8S/2ZHkij868t9zzh/Zi+DpAtyK5TFpCWsemIduHZrU
	 MvFaXRsVvEd3tVuV6XE0k5cENmP854YlZkDfG6jKslOrYZO9QUlXq+XTNnJtl1FzVk
	 QLlifpmmnZy4kPBNaceIrajkJ8tTXvuOR2CkyOtydoN2jZGR1sgEX2CdV5m+n3JP1K
	 iwL58epLDIhrsXYeL0kl1VPRJ8MpXvuKk3MMxZTMjt688eXT99lfdPTMiwUXK6Kdbn
	 9BiWQTGHYhOIA==
Date: Thu, 15 Oct 2026 11:10:48 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: tudor.ambarus@linaro.org, mchehab+huawei@kernel.org,
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
	linux@weissschuh.net, linux-kernel@vger.kernel.org, corbet@lwn.net,
	aleksandr.loktionov@intel.com, kexec@lists.infradead.org,
	pratyush@kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH v1] docs: xforms_lists: Handle DECLARE_KHOSER_PTR()
 struct members
Message-ID: <atCKiDTSST8TKKNQ@kernel.org>
References: <20261015020313.946940-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015020313.946940-1-pasha.tatashin@soleen.com>
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

On Wed, Oct 14, 2026 at 10:03:13PM -0400, Pasha Tatashin wrote:
> KHO ABI structures declare their preservation pointers with
> DECLARE_KHOSER_PTR(name, type), which expands to a union of the pointer
> and its physical address. kernel-doc does not know the macro and does
> not see the member: it warns that an unnamed member is not described
> and that the description of the member is excess.
> 
> Translate DECLARE_KHOSER_PTR(name, type) into "type name", as is done
> for DECLARE_KFIFO_PTR().
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  tools/lib/python/kdoc/xforms_lists.py | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
> index e3dda2fe8a537..e81d8a7702cbb 100644
> --- a/tools/lib/python/kdoc/xforms_lists.py
> +++ b/tools/lib/python/kdoc/xforms_lists.py
> @@ -45,6 +45,7 @@ class CTransforms:
>          (CMatch("DECLARE_HASHTABLE"), r"unsigned long \1[1 << ((\2) - 1)]"),
>          (CMatch("DECLARE_KFIFO"), r"\2 *\1"),
>          (CMatch("DECLARE_KFIFO_PTR"), r"\2 *\1"),
> +        (CMatch("DECLARE_KHOSER_PTR"), r"\2 \1"),
>          (CMatch("(?:__)?DECLARE_FLEX_ARRAY"), r"\1 \2[]"),
>          (CMatch("DEFINE_DMA_UNMAP_ADDR"), r"dma_addr_t \1"),
>          (CMatch("DEFINE_DMA_UNMAP_LEN"), r"__u32 \1"),
> 
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> prerequisite-patch-id: 557b4f406b7530b8be07d3e3aa6015ad89ceaa6d
> prerequisite-patch-id: c0430a4f0096e4be93a6200aa4e8a1d392238ca5
> prerequisite-patch-id: 524c71eab38a9175f9920f38717c8ed3b157299f
> prerequisite-patch-id: 61cfc274edef2fb23a1b867c9e0d063578387c45
> prerequisite-patch-id: ac022b05628f8e495a224216352aa037a022aae4
> prerequisite-patch-id: 50668baf257da9873190d08f21538ddc453261a8
> -- 
> 2.56.0.385.gd3acb90ef8-goog
> 

-- 
Sincerely yours,
Mike.


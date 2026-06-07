Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8318BCD8C9F
	for <kexec@archiver.kernel.org>; Sun,  7 Jun 2026 17:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p13qmOJLATrPkWrp+bXLKA89GU/CFXpglcWbzZhweFA=; b=YfeJKE65bjy5zO5hru/OWrhhH2
	kf/qQbly+nxqTW257fp5hsQmulBphuZzfUugLJF/2tu7tX1cPUJO1XgJLM9J2WXxPSLLTQ74ywYX+
	vUB2nfKGqRZDjC8FgxQC6bmt7b9NV5bpMQPBI1zBWe3U3CIfcL1V+Y6D0FaRj4xCpsnijaqDcY+QV
	IKvQPBFSptrNc3V4gjYSzu9aHeKY4ltHyUI+tC64yQruoUV7D3f6zejTK8e0QEbUbakI7FvNMiCAu
	WvrQF0z1cPPsuCiZMl0y/WLPuQ+KTaJtyo2O8gerzmxDFjncc6CWFKwBCj53ARiJU/O+36I6JaqTd
	wwnne8Nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWHmm-00000002O52-2XuK;
	Sun, 07 Jun 2026 17:59:48 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWHml-00000002O43-0DEP
	for kexec@lists.infradead.org;
	Sun, 07 Jun 2026 17:59:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1416F436B8;
	Sun,  7 Jun 2026 17:59:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78311F00893;
	Sun,  7 Jun 2026 17:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780855186;
	bh=p13qmOJLATrPkWrp+bXLKA89GU/CFXpglcWbzZhweFA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Id3zNGSuQQrCyIBS1HT+yPq9MzOB1URA4ipc2w9gwWuXsYJn+RSzuj+IRWSYArMz/
	 r2bAdENTeVv0i296ZT9xYlRvUGSy/MYOg6/1g60IR+s+L+Z+6wjl3Wlv27sFTA+ZHa
	 g+ku3trRQZyP9yzZcg0Vuyx4YrhE77Uy3qJ55T6Hv3trt2dCAmenIsRF5fwiIv5biq
	 iRzVn6CToE8JnrsJWUN9g0yy2GhPrzhWdQIknmaM8x+miwJ8IiaZm8ScgYlklx3qpF
	 ysbiSHI8rHT/3stcctQKFTJKJtX9u/iaa+55KrYHvQ9k1KsqRNPGZym/EjN5c38y0t
	 HQeZuTcMbavag==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC v1 1/9] kho: split out radix tree tracker into
 kho_radix.c
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Mike Rapoport <rppt@kernel.org>, linux-kselftest@vger.kernel.org, 
 shuah@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
 skhan@linuxfoundation.org, linux-doc@vger.kernel.org, jasonmiu@google.com, 
 linux-kernel@vger.kernel.org, corbet@lwn.net, ran.xiaokai@zte.com.cn, 
 kexec@lists.infradead.org, pratyush@kernel.org, graf@amazon.com
In-Reply-To: <aiWYZhoSOAruIIM3@plex>
References: <20260605033235.717351-1-pasha.tatashin@soleen.com>
 <20260605033235.717351-2-pasha.tatashin@soleen.com>
 <178083348873.1648214.11020626647820932506.b4-review@b4>
 <aiWYZhoSOAruIIM3@plex>
Date: Sun, 07 Jun 2026 20:59:40 +0300
Message-Id: <178085518028.1648214.13339471022594901667.b4-reply@b4>
X-Mailer: b4 0.15.2
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

On 2026-06-07 16:20:50+00:00, Pasha Tatashin wrote:
> On 06-07 14:58, Mike Rapoport wrote:
> 
> > On Fri, 05 Jun 2026 03:32:27 +0000, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> > 
> > It's radix tree data structure implementation, kho memory tracker is it's
> > user. Please rephrase to keep the semantics clear.
> 
> Yeap, I will update it.
> 
> > I don't see much value in moving kexec_handover.o to a separate line,
> > btw, the same is true for luo_core.o, but it's not important enough to
> > change.
> 
> This is purely for consistency. I wanted to use the exact same style in 
> the Makefile instead of having two different ways of declaring the 
> object lists.
> 
> This:
>     luo-y :=                                \
>             luo_core.o                      \
>             luo_file.o                      \
>             luo_flb.o                       \
>             luo_session.o
> 
>     kho-y :=                                \
>             kexec_handover.o                \
>             kho_radix.o                     \
>             kho_block.o                     \
>             kho_vmalloc.o
 
I mean this:

luo-y := luo_core.o		\
	luo_file.o		\
	luo_flb.o		\
	luo_session.o
 
kho-y := kexec_handover.o	\
	kho_radix.o		\
	kho_block.o		\
	kho_vmalloc.o




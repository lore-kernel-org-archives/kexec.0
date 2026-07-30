Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6352C54FDF
	for <kexec@archiver.kernel.org>; Thu, 30 Jul 2026 08:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=55G67AD+bUlnQtHL1MJavniTLpGKt7vPc4y+cPkS8Qo=; b=0IH9JbSDzj+39opbGp/rwOTKhQ
	kYbTp6hMVwppgD2w3BpAv2svFhciZZHmwFR/OlNsGDpeuh8FaAzRa7ZxH0cSg0yrR/n02AFXbRien
	SpMnehW/DnfrR/9xX3a8ZeXmzirafxPGNVLWZWoLLMOcLB+NzEM3EgxDSH8q7C+99mZdtwQbgOWnj
	0bBVB8yxceUhIn1aHWEne+GsdaFv7MMpsPa/LZjAw0sypvE6GxznHaGiL5PZCykcnCuwhX+x/8hIg
	xWgQakpkN5+/99PR24sgn61oGfQDaZXbOp6sgP2D07bQglMV3qHzgMTXD8ISQCmxzQ9x7lqSo/wz/
	7P8qpgIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpMJe-00000009ttg-26XU;
	Thu, 30 Jul 2026 08:40:34 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpMJc-00000009ttH-3vAf
	for kexec@lists.infradead.org;
	Thu, 30 Jul 2026 08:40:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 193C5600BC;
	Thu, 30 Jul 2026 08:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499731F000E9;
	Thu, 30 Jul 2026 08:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785400831;
	bh=55G67AD+bUlnQtHL1MJavniTLpGKt7vPc4y+cPkS8Qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Am3w9iBbksLZSYkGW+BC2SXWaPrsXS+3w0PfbAUiFLEio7Ojf0Mp6S5i+8TfgZJQ7
	 P0oEDWw3vSLdXYio4+t/tv5rqP3m3i6YA0+nbhUwJCvoZ2Aag+k6zPehyBKcXT7ir5
	 l7Egai/6QWPr4er0MIKnLmzK/p7t/cVDFc5YJWjzgGfGK6Tpuzmfkyug6zxOkJatZ6
	 nyjomqeZ/UizlLOFCXdwnG+WkTF7Wn8jaz4YvGRtw2fU+vEEjVRZ97lQiQn8+BcND8
	 W1BuAwvX2mVAHr5hud0roY3B9Tm1f2aipjudB63eKi0xt+KNbdCbNwjboFOq/scBOu
	 rkkhhxo0776pA==
Date: Thu, 30 Jul 2026 11:40:23 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>,
	Jork Loeser <jloeser@linux.microsoft.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/22] kho: generalize radix tree APIs
Message-ID: <amsN9_4LTNFBxaFE@kernel.org>
References: <20260729145610.2827231-1-pratyush@kernel.org>
 <20260729145610.2827231-2-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729145610.2827231-2-pratyush@kernel.org>
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

On Wed, Jul 29, 2026 at 04:55:46PM +0200, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> Generalize the APIs by taking the key directly and doing the encoding at
> the callers. Rename the functions to kho_radix_add_key() and
> kho_radix_del_key(). In practice, this removes a line each from the
> functions and moves the encoding function call to the callers.
> Similarly, update kho_radix_tree_walk_callback_t to take the key
> directly.
>
> diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_tree.h
> index 84e918b96e53..f368f3b9f923 100644
> --- a/include/linux/kho_radix_tree.h
> +++ b/include/linux/kho_radix_tree.h
> @@ -34,30 +34,24 @@ struct kho_radix_tree {
>  	struct mutex lock; /* protects the tree's structure and root pointer */
>  };

sashiko: This isn't a bug, but did you miss updating the kerneldoc for
struct kho_radix_tree?

And indeed "DOC: Kexec Handover Radix Tree" talks about addresses and
orders.

-- 
Sincerely yours,
Mike.


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92116D59D99
	for <kexec@archiver.kernel.org>; Mon, 15 Dec 2025 00:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bSQzs2zyofJIiD9Po65MO4CVZedsjX6hWoWDes6ZDR8=; b=n+f8yYZDVK50zcmqS+POwXAA1S
	ELZj7pewLryat6upVzjf/Hvl1t2JMYK6nyrpzHIxFfehKamxj5zIkY+YQ75AveXga5a67Ta9plnpT
	rr3RdZ+V0YVJOCSmTecwHXwh096jiR1Vh2PNr+DPueP9RQ5cQyoe9HNB67kJMgDbOjg9th71loyDW
	2tH9toc2ZsI0qgwvosTT602LWDqHT4yUGWfIphmhXmUEQ5VaCBAJCFSZGR0pJG23VR36zLRy0z4z6
	coZVI+ryH26qjadv8H+7LO4B++jo87T+L+mDnEXhUf0SFRf++OHmU0lg9aY/bsVIMhBI9+ThhR3WK
	iGzLTkqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUwVf-00000002s6Z-2AHA;
	Mon, 15 Dec 2025 00:32:19 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUwVd-00000002s6L-2fM1;
	Mon, 15 Dec 2025 00:32:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 15FA36001A;
	Mon, 15 Dec 2025 00:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7522FC4CEF1;
	Mon, 15 Dec 2025 00:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1765758735;
	bh=iDanXjHGL1VenyIF9T2sn7s24shSIuXjweiHQ9QZyBw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=zrydWG6IPT1jznYJUN56vuve8VampF+tpoLfHM1x4PPjJy9kksx0q+ObWCeB9Ggy0
	 q/Oc19g4pnVS++7p2yACjKZ0NH9R9vs/6zUH0s32PFHGvGlpAvSUooTJ8M3OKF/DIC
	 zq0KPJUWPpEXHxfmCT1iCEIBxCCrVGHnwIWpLwxU=
Date: Sun, 14 Dec 2025 16:32:14 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Qiang Ma <maqianga@uniontech.com>
Cc: bhe@redhat.com, catalin.marinas@arm.com, will@kernel.org,
 kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 2/3] kexec: print out debugging message if required
 for kexec_load
Message-Id: <20251214163214.5018b9c083f11c7ecc081a5d@linux-foundation.org>
In-Reply-To: <20251212095649.857796-3-maqianga@uniontech.com>
References: <20251212095649.857796-1-maqianga@uniontech.com>
	<20251212095649.857796-3-maqianga@uniontech.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 12 Dec 2025 17:56:48 +0800 Qiang Ma <maqianga@uniontech.com> wrote:

> The commit a85ee18c7900 ("kexec_file: print out debugging message
> if required") has added general code printing in kexec_file_load(),
> but not in kexec_load().
> 
> As a result, when using '-d' for the kexec_load interface,
> print nothing in the kernel space.

That doesn't sound like a thing which "kernel test robot" would detect
and report.

> Since the segments debugging message has already been printed by the
> user-space tool kexec-tools, it will not be printed here in the
> kernel space.
> 
> And print out type/start/head of kimage and flags to help debug.
> 
> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202510310332.6XrLe70K-lkp@intel.com/

Oh I see, that's a warning against an earlier version of this patch. 
But this is labelled "v1"!

I suggest we remove this Reported-by record.

> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -166,6 +166,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>  	if (ret)
>  		goto out;
>  
> +	kexec_dprintk("kexec_load: type:%u, start:0x%lx head:0x%lx flags:0x%lx\n",
> +		      image->type, image->start, image->head, flags);
> +
>  	/* Install the new kernel and uninstall the old */
>  	image = xchg(dest_image, image);

Thanks, I'll await reviewer input before proceeding with this series.


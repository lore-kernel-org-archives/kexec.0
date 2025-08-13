Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6537DC87FCF
	for <kexec@archiver.kernel.org>; Wed, 13 Aug 2025 03:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8MI7iF6Nyg2OgB1oufUtmgIjjSsYijuk9SW5l2ka+mE=; b=VheomA1tvNLi+lNn4vKZ8+xih9
	bKWZKiu0pWty4wLKT9RgxVLz/d0GMMR3WeHEUWyVWVcpqVBqBiBJOvu/E7yzySrgRUDMcf23LAm4j
	8YnLE/fFZA0/Xgb5gYl0sBMwSL7HKpJU1Oc1iBwRsFUTRQ+VtMtyVZFwX+8WYtUWHcFkm7JA+0s2m
	LiA7oJKWHtfscTHyJ+atLKxAXxR9jI67bFuRevrZgB16qXc9SGiMoVxJHT6Rf8CvJpHYn58N1q7ab
	jVmpVZ2sxZsjGcRyUO0sNrEnda7suxX81eWZFrpRoXDua/QEnrBSt+cG1vEvmM1cEuzZcc7hBesBU
	bNO/wQgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um26c-0000000CVuq-0VWS;
	Wed, 13 Aug 2025 03:24:50 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um26a-0000000CVuG-46I4
	for kexec@bombadil.infradead.org;
	Wed, 13 Aug 2025 03:24:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=8MI7iF6Nyg2OgB1oufUtmgIjjSsYijuk9SW5l2ka+mE=; b=Bxylu2kpsMyB6TklFl4sLE1hrL
	Ac1VBKuxCtG9xlrvzP5MxkgkHX7bDj5iUGivPzkbi9OGewQOAZgxh8cbIGa69SiAIpCkQ3uuju7sI
	bAz3ijmdSvngt/mlyIK2WhRSBRh2LhQkwEB9+CTwTZ+ZOqa4+ARu2J9ENlh6rLofRZx4exoFApWEB
	s16pzS25lwW2qEBHgGEBcAic3MeAwkrzjacTvj7syMtIUwUMjmN6t7+FUMR2ryc8HMsFOfTrK/yWc
	vT/6VGvur5q4+QcRRUdonVL+NRb7CZ5IH6X9xcKO6tVZoPgDQEyJ5zOjtK/SFp7jF+R3Q62ak3TsG
	VbtRzgIQ==;
Received: from layka.disroot.org ([178.21.23.139])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um26X-0000000Fx35-15Yn
	for kexec@lists.infradead.org;
	Wed, 13 Aug 2025 03:24:47 +0000
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id F3A4525BB1;
	Wed, 13 Aug 2025 05:24:42 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wN79A9bzqULE; Wed, 13 Aug 2025 05:24:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1755055482; bh=EpC1PWK0QNP1EdR5yDUCeYLD2Y1efS+n85zghXKneKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gPYubN//e9XqID6gKvy0mwwT86JVPqCGYfpQWizbt4+ljNgm4pAFW6Ou88IFg3EcM
	 dkxMYXVyVkhCz/n621Dwfedy3RZSfb4n/ABydqhm9nmdsA1ALvUJ2m+dsvn5kwy+rW
	 bBzh93SckyPmoSGs+KXBzkgvbcf9flIdXx0W9Y6ebs1WYOAU9X3LE8sOjSs4mKUqmq
	 ebGxAB2UmuA5Lp2tWprIv3rTYzGOdBMH7O15L0bbUllVVUCAIG2uoXhujgJXVjG3bY
	 UDc+JiIKU5KuYm48TcwwYf9QePtesjzh5xGPzfWuU7Pp96yJ/dy45cgnzSH/xtV6gF
	 fjK9UYCOvGXwQ==
Date: Wed, 13 Aug 2025 03:24:27 +0000
From: Yao Zi <ziyao@disroot.org>
To: Youling Tang <youling.tang@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH 2/6] LoongArch: Add kexec_file support
Message-ID: <aJwFa8x5BQMouB1y@pie>
References: <20250811092659.14903-1-youling.tang@linux.dev>
 <20250811092659.14903-3-youling.tang@linux.dev>
 <aJojDiHWi8cgvA2W@pie>
 <6de97571-7ef0-4bbd-b55f-5ad41898a6ec@linux.dev>
 <af866071-81c1-44d5-ae02-273d6e9c04d4@linux.dev>
 <aJsGg8__ppyBrkfL@pie>
 <27513334-3086-4353-bf6c-fdee082a8ce8@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27513334-3086-4353-bf6c-fdee082a8ce8@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_042445_667944_83A9898C 
X-CRM114-Status: GOOD (  54.85  )
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

On Wed, Aug 13, 2025 at 10:18:12AM +0800, Youling Tang wrote:
> Hi, Yao
> On 2025/8/12 17:43, Yao Zi wrote:
> > On Tue, Aug 12, 2025 at 03:06:23PM +0800, Youling Tang wrote:
> > > On 2025/8/12 14:15, Youling Tang wrote:
> > > > Hi, Yao
> > > > On 2025/8/12 01:06, Yao Zi wrote:
> > > > > On Mon, Aug 11, 2025 at 05:26:55PM +0800, Youling Tang wrote:
> > > > > > From: Youling Tang <tangyouling@kylinos.cn>
> > > > > > 
> > > > > > This patch adds support for kexec_file on LoongArch.
> > > > > > 
> > > > > > The image_load() as two parts:
> > > > > > - the first part loads the kernel image (vmlinuz.efi or vmlinux.efi)
> > > > > > - the second part loads other segments (eg: initrd, cmdline)
> > > > > > 
> > > > > > Currently, pez(vmlinuz.efi) and pei(vmlinux.efi) format images
> > > > > > are supported,
> > > > > > but ELF format is not supported.
> > > > > > 
> > > > > > Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> > > > > > ---
> > > > > >    arch/loongarch/Kconfig                     |   8 ++
> > > > > >    arch/loongarch/include/asm/image.h         |  18 ++++
> > > > > >    arch/loongarch/include/asm/kexec.h         |  12 +++
> > > > > >    arch/loongarch/kernel/Makefile             |   1 +
> > > > > >    arch/loongarch/kernel/kexec_image.c        | 112
> > > > > > +++++++++++++++++++++
> > > > > >    arch/loongarch/kernel/machine_kexec.c      |  33 ++++--
> > > > > >    arch/loongarch/kernel/machine_kexec_file.c |  46 +++++++++
> > > > > >    7 files changed, 219 insertions(+), 11 deletions(-)
> > > > > >    create mode 100644 arch/loongarch/kernel/kexec_image.c
> > > > > >    create mode 100644 arch/loongarch/kernel/machine_kexec_file.c
> > ...
> > 
> > > > > > diff --git a/arch/loongarch/kernel/kexec_image.c
> > > > > > b/arch/loongarch/kernel/kexec_image.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..fdd1845b4e2e
> > > > > > --- /dev/null
> > > > > > +++ b/arch/loongarch/kernel/kexec_image.c
> > ...
> > 
> > > > > > +    /*
> > > > > > +     * The location of the kernel segment may make it
> > > > > > impossible to satisfy
> > > > > > +     * the other segment requirements, so we try repeatedly to find a
> > > > > > +     * location that will work.
> > > > > > +     */
> > > > > > +    while ((ret = kexec_add_buffer(&kbuf)) == 0) {
> > > > > > +        /* Try to load additional data */
> > > > > > +        kernel_segment = &image->segment[kernel_segment_number];
> > > > > > +        ret = load_other_segments(image, kernel_segment->mem,
> > > > > > +                      kernel_segment->memsz, initrd,
> > > > > > +                      initrd_len, cmdline, cmdline_len);
> > > > > > +        if (!ret)
> > > > > > +            break;
> > > > > > +
> > > > > > +        /*
> > > > > > +         * We couldn't find space for the other segments; erase the
> > > > > > +         * kernel segment and try the next available hole.
> > > > > > +         */
> > > > > > +        image->nr_segments -= 1;
> > > > > > +        kbuf.buf_min = kernel_segment->mem + kernel_segment->memsz;
> > > > > > +        kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> > > > > > +    }
> > > > > > +
> > > > > > +    if (ret) {
> > > > > > +        pr_err("Could not find any suitable kernel location!");
> > > > > > +        return ERR_PTR(ret);
> > > > > > +    }
> > > > > > +
> > > > > > +    kernel_segment = &image->segment[kernel_segment_number];
> > > > > > +
> > > > > > +    /* Make sure the second kernel jumps to the correct
> > > > > > "kernel_entry". */
> > > > > > +    image->start = kernel_segment->mem + h->kernel_entry -
> > > > > > text_offset;
> > > > > A non-relocatable loongarch kernel cannot be loaded to arbitrary
> > > > > address. Thus this loading function seems to only work for relocatable
> > > > > kernels, maybe it's better to leave a comment indicating the limitation.
> > > > > 
> > > > > For now, we don't seem to have a way to find out whether the kernel is
> > > > > relocatable (for example, a flag in kernel image header), so it's
> > > > > impossible to point out whether the loaded kernel boots fine with
> > > > > arbitrary loading address...
> > > > LoongArch enables the relocation of the kernel when the kdump
> > > > feature is enabled.
> > > > 
> > > > config ARCH_SELECTS_CRASH_DUMP
> > > >          def_bool y
> > > >          depends on CRASH_DUMP
> > > >          select RELOCATABLE
> > > > 
> > This only means the currently-running kernel is relocatable, not the one
> > being exec'ed, right?
> No.
> > > When enabling KEXEC_FILE, the RELOCATABLE configuration should
> > > also be enabled. Both kexec and kdump require this.
> > I'm not sure whether you're talking about the running kernel or the one
> > that is going to be exec'ed. This method of kernel loading requires the
> > exec'ed kernel being relocatable, not the currently running one.
> > 
> > And I think it's totally reasonable to use KEXEC_FILE for non-crash-dump
> > purpose, for example, linuxboot. It'll be confusing to the user if the
> > system just hangs after booting a non-relocatable kernel, which is hard
> > to debug.
> > 
> > Thus IMHO we should ideally refuse to load non-relocatable kernels, or
> > add a FIXME comment to indicate the situation that it's impossible to
> > determine whether the exec'ed image is relocatable.
> The first kernel and the second kernel are generally the same kernel
> (the same image).

This isn't true. There're real-world cases using kexec-file to load and
boot an unrelated kernel image. Please refer to petitboot[1] and
linuxboot[2] which uses kexec to act as a bootloader.

> When KEXEC_FILE is enabled and RELOCATEABLE
> is enabled by default, it has been forcibly guaranteed that both the
> first kernel and the second kernel are relocatable kernels regardless
> of kexec/kdump operations.

This cannot be guaranteed since the first and second kernel could be
completely unrelated. Please see my previous comment.

> Unless the second kernel it loads is an older version of the kernel (the
> older version of the kernel does not use the default configuration, with
> CONFIG_KEXEC enabled but CONFIG_CRASH_DUMP disabled,

> this is not acorrect usage).

This may be incorrect for kdump's use case, but kexec-file isn't only
meant to be used with kdump: it just loads an arbitrary kernel image and
executes it, no matter whether it's for capturing a dump, booting a
newer or older kernel, or etc, and there's no guarantee about features
enabled in the second kernel. It's incorrect to assume the user only
loads relocatable images with kexec-file.

> Thanks,
> Youling.
> > > Youling.
> > > > After enabling the relocation, LoongArch is the PIE kernel. For
> > > > more details, please refer to commit d8da19fbdedd ("LoongArch:
> > > > Add support for kernel relocation")
> > Best regards.
> > Yao Zi
> 

Thanks,
Yao Zi

[1]: https://github.com/open-power/petitboot
[2]: https://github.com/linuxboot/linuxboot


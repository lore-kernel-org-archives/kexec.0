Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAD4CA0EC4
	for <kexec@archiver.kernel.org>; Tue, 12 Aug 2025 16:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WopR+H6mOmaY1vvDAfBZSsaG6bftAoF7LrvzU6V3dJY=; b=OYKgY9aeIYmFFJuXSlMBQ2GSN6
	GR6YFarJmsxp3YejOJnRCx4qfKmTQrss2Qq4c/yRsarT8XwhWMMAUAaAPS7t01KZOO7tWNGibzAN2
	k2PyoAgsQ3lj/SQaLjKYTh+C873bPndBr1NXPn142EU1D+JAopvqG3+TppeChr6KBoug2gsGkM0Ve
	Nfm6uyRH6HqPBQebeWKL2i4QsP2f7UJgT+38A7WetF635vdJ7ETrU0thpkoeMpD+3nRDP1TQxxmiw
	1f1q1d0MY+eDhMYRDzihEowhH1EoByzax1T1YJ/3H9pX9qhbCv0E5LILmstXNO6CXB9R+ycflfJNO
	+gTHTJzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulrhg-0000000BHGJ-0mfz;
	Tue, 12 Aug 2025 16:18:24 +0000
Received: from layka.disroot.org ([178.21.23.139])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ullXV-0000000AQ3m-0L63
	for kexec@lists.infradead.org;
	Tue, 12 Aug 2025 09:43:31 +0000
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 31DAF2588F;
	Tue, 12 Aug 2025 11:43:26 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JUhdKEmfHZPA; Tue, 12 Aug 2025 11:43:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1754991805; bh=VoQtnN8TVNFZ35OF82gYJyQyCQWCWSyi54UG/5Pr244=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c2tx00vQAKJGnzvzuLEMjpjeoaNpI1Lx0c3Y8cYCtqN4lEKdCwFGNrqXbwho96cDr
	 De1FkMyLuefVDZ+EHP+/XKNmUy4XwSfPWGEiUj93BWfM8qh+seZfrg7OLRBKdPtyho
	 4xOzvuxmCq4q8r348zHFgM9DXNb1lhhU+ALeaggJj6kTqFkH06UOrLRRFxk6VbWsCj
	 DUqEitM07Olvng7ttQyjj6AkbsX8m+F+Oc/nN0EuOqWpP+mKScI++CAojssp9JPQli
	 bbNjTsLkTOQd6peyhyYtg9f+LfX6Uczqd3MoJV8BVGu3raF2pAoBrESbufbZwQR9ey
	 qHp4TQ/TBwk3g==
Date: Tue, 12 Aug 2025 09:43:13 +0000
From: Yao Zi <ziyao@disroot.org>
To: Youling Tang <youling.tang@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH 2/6] LoongArch: Add kexec_file support
Message-ID: <aJsGg8__ppyBrkfL@pie>
References: <20250811092659.14903-1-youling.tang@linux.dev>
 <20250811092659.14903-3-youling.tang@linux.dev>
 <aJojDiHWi8cgvA2W@pie>
 <6de97571-7ef0-4bbd-b55f-5ad41898a6ec@linux.dev>
 <af866071-81c1-44d5-ae02-273d6e9c04d4@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af866071-81c1-44d5-ae02-273d6e9c04d4@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_024329_669181_35254882 
X-CRM114-Status: GOOD (  42.59  )
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

On Tue, Aug 12, 2025 at 03:06:23PM +0800, Youling Tang wrote:
> On 2025/8/12 14:15, Youling Tang wrote:
> > Hi, Yao
> > On 2025/8/12 01:06, Yao Zi wrote:
> > > On Mon, Aug 11, 2025 at 05:26:55PM +0800, Youling Tang wrote:
> > > > From: Youling Tang <tangyouling@kylinos.cn>
> > > > 
> > > > This patch adds support for kexec_file on LoongArch.
> > > > 
> > > > The image_load() as two parts:
> > > > - the first part loads the kernel image (vmlinuz.efi or vmlinux.efi)
> > > > - the second part loads other segments (eg: initrd, cmdline)
> > > > 
> > > > Currently, pez(vmlinuz.efi) and pei(vmlinux.efi) format images
> > > > are supported,
> > > > but ELF format is not supported.
> > > > 
> > > > Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> > > > ---
> > > >   arch/loongarch/Kconfig                     |   8 ++
> > > >   arch/loongarch/include/asm/image.h         |  18 ++++
> > > >   arch/loongarch/include/asm/kexec.h         |  12 +++
> > > >   arch/loongarch/kernel/Makefile             |   1 +
> > > >   arch/loongarch/kernel/kexec_image.c        | 112
> > > > +++++++++++++++++++++
> > > >   arch/loongarch/kernel/machine_kexec.c      |  33 ++++--
> > > >   arch/loongarch/kernel/machine_kexec_file.c |  46 +++++++++
> > > >   7 files changed, 219 insertions(+), 11 deletions(-)
> > > >   create mode 100644 arch/loongarch/kernel/kexec_image.c
> > > >   create mode 100644 arch/loongarch/kernel/machine_kexec_file.c

...

> > > > diff --git a/arch/loongarch/kernel/kexec_image.c
> > > > b/arch/loongarch/kernel/kexec_image.c
> > > > new file mode 100644
> > > > index 000000000000..fdd1845b4e2e
> > > > --- /dev/null
> > > > +++ b/arch/loongarch/kernel/kexec_image.c

...

> > > > +    /*
> > > > +     * The location of the kernel segment may make it
> > > > impossible to satisfy
> > > > +     * the other segment requirements, so we try repeatedly to find a
> > > > +     * location that will work.
> > > > +     */
> > > > +    while ((ret = kexec_add_buffer(&kbuf)) == 0) {
> > > > +        /* Try to load additional data */
> > > > +        kernel_segment = &image->segment[kernel_segment_number];
> > > > +        ret = load_other_segments(image, kernel_segment->mem,
> > > > +                      kernel_segment->memsz, initrd,
> > > > +                      initrd_len, cmdline, cmdline_len);
> > > > +        if (!ret)
> > > > +            break;
> > > > +
> > > > +        /*
> > > > +         * We couldn't find space for the other segments; erase the
> > > > +         * kernel segment and try the next available hole.
> > > > +         */
> > > > +        image->nr_segments -= 1;
> > > > +        kbuf.buf_min = kernel_segment->mem + kernel_segment->memsz;
> > > > +        kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> > > > +    }
> > > > +
> > > > +    if (ret) {
> > > > +        pr_err("Could not find any suitable kernel location!");
> > > > +        return ERR_PTR(ret);
> > > > +    }
> > > > +
> > > > +    kernel_segment = &image->segment[kernel_segment_number];
> > > > +
> > > > +    /* Make sure the second kernel jumps to the correct
> > > > "kernel_entry". */
> > > > +    image->start = kernel_segment->mem + h->kernel_entry -
> > > > text_offset;
> > > A non-relocatable loongarch kernel cannot be loaded to arbitrary
> > > address. Thus this loading function seems to only work for relocatable
> > > kernels, maybe it's better to leave a comment indicating the limitation.
> > > 
> > > For now, we don't seem to have a way to find out whether the kernel is
> > > relocatable (for example, a flag in kernel image header), so it's
> > > impossible to point out whether the loaded kernel boots fine with
> > > arbitrary loading address...
> > LoongArch enables the relocation of the kernel when the kdump
> > feature is enabled.
> > 
> > config ARCH_SELECTS_CRASH_DUMP
> >         def_bool y
> >         depends on CRASH_DUMP
> >         select RELOCATABLE
> > 

This only means the currently-running kernel is relocatable, not the one
being exec'ed, right?

> When enabling KEXEC_FILE, the RELOCATABLE configuration should
> also be enabled. Both kexec and kdump require this.

I'm not sure whether you're talking about the running kernel or the one
that is going to be exec'ed. This method of kernel loading requires the
exec'ed kernel being relocatable, not the currently running one.

And I think it's totally reasonable to use KEXEC_FILE for non-crash-dump
purpose, for example, linuxboot. It'll be confusing to the user if the
system just hangs after booting a non-relocatable kernel, which is hard
to debug.

Thus IMHO we should ideally refuse to load non-relocatable kernels, or
add a FIXME comment to indicate the situation that it's impossible to
determine whether the exec'ed image is relocatable.

> Youling.
> > After enabling the relocation, LoongArch is the PIE kernel. For
> > more details, please refer to commit d8da19fbdedd ("LoongArch:
> > Add support for kernel relocation")

Best regards.
Yao Zi


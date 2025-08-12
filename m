Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6A2C87FCB
	for <kexec@archiver.kernel.org>; Tue, 12 Aug 2025 06:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u7tiZ218SU9bp0Yx3lUBxbi4FJTF/4XCQKk+SDX6GIQ=; b=fAtKGoDAoZb6kr+KRD4+hSAVVc
	477tG8CGqg2XX32gPHW9baom34JWvBImjpjzmhlOsIZadg+Ib3z2pOA10x/+oX0yb236aa9izCuGe
	FPyEk5w8oQ0rFHsLfwqDIlccUNR/rzou/LiZpUywLyxoEUxO2PKfkxJ4aS+lneCUZ3gmBlFdXqkQF
	aiGKMOaTT+El8GyKlMYhvt4NKcCnAeSodR/lzpefWjvqwOKUIVrruxEvGmEgdP7ukdihsy04wUKb4
	Scwiy2DP2Dh1RxTSPeFGJwd77SFuKXg4dfrHYeKGtEzro3ACl0ceRU6OIfQB458l320HpXZbRB7qD
	TaetCXKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uliSl-0000000A1VP-1TB7;
	Tue, 12 Aug 2025 06:26:23 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uliSf-0000000A1Ua-2idZ
	for kexec@bombadil.infradead.org;
	Tue, 12 Aug 2025 06:26:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u7tiZ218SU9bp0Yx3lUBxbi4FJTF/4XCQKk+SDX6GIQ=; b=SCoYoMZKociVY2cNciCqE+QXt3
	NROEGZmEdxEfO0xo24odqzQe1AiFkIl5Adx+r8MjOIwoCfUCIuQnPJflyDsG3zBUyaxCJVjH9dOPh
	bQzORZQEauo3uDE79L4sd742hq9eoKUTB1fI5AUAqMdBVmIvUDpskkROLtOq4tN4JdqrZY1YH5DtO
	NZo514ymmI7C66o7OqYDxeh+3rCY3vW+xlj50eIPQUgyMDYIleFg7jwlhcK3na2f0kHRwMbih+ZGS
	U9HF0Qgqdc/29hJE5WmuMLeSVfI9y23GfUAt6O3kg7jcFmhTZSYHQATm+ICXP5uwP+DZBBoe0ECFp
	kJs8gAuA==;
Received: from layka.disroot.org ([178.21.23.139])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uliSb-0000000Fhog-3e6A
	for kexec@lists.infradead.org;
	Tue, 12 Aug 2025 06:26:15 +0000
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 3840F25C35;
	Tue, 12 Aug 2025 08:26:11 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OBZHdVsZLZlm; Tue, 12 Aug 2025 08:26:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1754979970; bh=o2OqDw7n5r920iRkQ3j3ACHBg5pyQbHlMjYQxfJsnm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D3qGPFXhn4i/FPlSl6+s6RyHnduwgt2nrWJmIkk/awjzSfgJyi2mU/WrieGYVRjOh
	 mSUnxxTgUEla34qTIa6goSXqlJOZnmq/HXai4RDIvQFw4wejlEzVjm6uHnX/w1cr6e
	 bAjASzGD0mkbgFtYtmay/MLLWQrpow1s1wDm+HiWniO3sxV4LYgI5s/8iSugUjNrgH
	 KULv7fwdmhBsWEckGjjmZMkeBERMOjrtr2rW7PG1YSTW61ost5f9WjLlyLBurOyG+1
	 DmT1MP8ndmEPShPKd1pWma8/0ZCXVEhK/hNOefKoIXUfmwtclkgsD5Zw77lGCR38Xo
	 dKp8Gx3jAl8pg==
Date: Tue, 12 Aug 2025 06:25:57 +0000
From: Yao Zi <ziyao@disroot.org>
To: Youling Tang <youling.tang@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH 3/6] LoongArch/kexec_file: Add initrd loading
Message-ID: <aJredf2InXhHY7ek@pie>
References: <20250811092659.14903-1-youling.tang@linux.dev>
 <20250811092659.14903-4-youling.tang@linux.dev>
 <aJovKIKFqX6xi9ra@pie>
 <0767b8fe-7c04-4e73-9235-ee326ee058cc@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0767b8fe-7c04-4e73-9235-ee326ee058cc@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_072614_209871_F3E98360 
X-CRM114-Status: GOOD (  35.12  )
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

On Tue, Aug 12, 2025 at 12:05:30PM +0800, Youling Tang wrote:
> Hi, Yao
> On 2025/8/12 01:58, Yao Zi wrote:
> > On Mon, Aug 11, 2025 at 05:26:56PM +0800, Youling Tang wrote:
> > > From: Youling Tang <tangyouling@kylinos.cn>
> > > 
> > > Add inird loading support and pass it to the second kernel via the
> > > cmdline 'initrd=start,size'.
> > I think This won't work if the exec'ed kernel enables
> > CONFIG_CMDLINE_FORCE. Is it possible to mimic libstub's behavior of
> > installing a configuration table LINUX_EFI_INITRD_MEDIA_GUID?
> The command line passed by kexec to the second kernel has no effect if
> CONFIG_CMDLINE_FORCE is enabled, which is not quite suitable for the
> kexec scenario.
> 
> Currently, the initrd, elfcorehdr, and mem parameters will all be passed
> through the command line to maintain consistency with the implementation
> behavior of kexec-tools. It is possible that the content of systab will
> be modified in the future and some parts will be integrated into systab
> (the current cmdline mode will be better compatible with the elf kernel).
> > 
> > > Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> > > ---
> > >   arch/loongarch/kernel/machine_kexec_file.c | 71 ++++++++++++++++++++++
> > >   1 file changed, 71 insertions(+)
> > > 
> > > diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
> > > index bc91ae0afa4c..e1240644f529 100644
> > > --- a/arch/loongarch/kernel/machine_kexec_file.c
> > > +++ b/arch/loongarch/kernel/machine_kexec_file.c
> > > @@ -34,13 +34,84 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
> > >   	return kexec_image_post_load_cleanup_default(image);
> > >   }
> > > +/* Adds the "initrd=start,size" command line parameter to command line. */
> > > +static void cmdline_add_initrd(struct kimage *image, unsigned long *cmdline_tmplen,
> > > +				char *modified_cmdline, unsigned long initrd)
> > > +{
> > > +	int initrd_strlen;
> > > +
> > > +	initrd_strlen = sprintf(modified_cmdline + (*cmdline_tmplen), "initrd=0x%lx,0x%lx ",
> > modified_cmdline is allocated as COMMAND_LINE_SIZE bytes, thus I think
> > it's possible to overflow the buffer.
> At this point, modified_cmdline can clearly know that it only stores
> the additional commands we add (initrd,mem,elfcorehdr), and will not
> exceed COMMAND_LINE_SIZE.
> > 
> > > +		initrd, image->initrd_buf_len);
> > > +	*cmdline_tmplen += initrd_strlen;
> > > +}
> > > +
> > > +/*
> > > + * Tries to add the initrd to the image. If it is not possible to find
> > > + * valid locations, this function will undo changes to the image and return non
> > > + * zero.
> > > + */
> > >   int load_other_segments(struct kimage *image,
> > >   			unsigned long kernel_load_addr,
> > >   			unsigned long kernel_size,
> > >   			char *initrd, unsigned long initrd_len,
> > >   			char *cmdline, unsigned long cmdline_len)
> > >   {
> > > +	struct kexec_buf kbuf;
> > > +	unsigned long orig_segments = image->nr_segments;
> > > +	char *modified_cmdline = NULL;
> > > +	unsigned long cmdline_tmplen = 0;
> > > +	unsigned long initrd_load_addr = 0;
> > > +	int ret = 0;
> > > +
> > > +
> > > +	kbuf.image = image;
> > > +	/* not allocate anything below the kernel */
> > > +	kbuf.buf_min = kernel_load_addr + kernel_size;
> > > +
> > > +	modified_cmdline = kzalloc(COMMAND_LINE_SIZE, GFP_KERNEL);
> > > +	if (!modified_cmdline)
> > > +		return -EINVAL;
> > > +
> > > +	/* Ensure it's nul terminated */
> > > +	modified_cmdline[COMMAND_LINE_SIZE - 1] = '\0';
> > > +
> > > +	/* load initrd */
> > > +	if (initrd) {
> > > +		kbuf.buffer = initrd;
> > > +		kbuf.bufsz = initrd_len;
> > > +		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> > > +		kbuf.memsz = initrd_len;
> > > +		kbuf.buf_align = 0;
> > > +		/* within 1GB-aligned window of up to 32GB in size */
> > > +		kbuf.buf_max = round_down(kernel_load_addr, SZ_1G)
> > > +						+ (unsigned long)SZ_1G * 32;
> > > +		kbuf.top_down = false;
> > > +
> > > +		ret = kexec_add_buffer(&kbuf);
> > > +		if (ret)
> > > +			goto out_err;
> > > +		initrd_load_addr = kbuf.mem;
> > > +
> > > +		kexec_dprintk("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> > > +			      initrd_load_addr, kbuf.bufsz, kbuf.memsz);
> > > +
> > > +		/* Add the initrd=start,size parameter to the command line */
> > > +		cmdline_add_initrd(image, &cmdline_tmplen, modified_cmdline, initrd_load_addr);
> > > +	}
> > > +
> > > +	if (cmdline_len + cmdline_tmplen > COMMAND_LINE_SIZE) {
> > It's too later to check for overflowing here, where the data after
> > modified_cmdline may already be overwritten.
> At this point, we append the original command line to modified_cmdline,
> so it is appropriate to determine whether the command line length exceeds
> the limit.

Thanks, I misunderstood the code logic: before cmdline_add_initrd
appends new arguments, modified_cmdline is empty instead of containing
a copy of cmdline, so this is fine. Sorry for the noise.

Best regards,
Yao Zi


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D03C47DDB
	for <kexec@archiver.kernel.org>; Fri, 26 Jan 2024 06:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5zitt3pQTBIAgnYDjt6h5/in56c47p5m8OERYT4mIwo=; b=KfR4HXjj1Merw8
	lYkVoI/DUvGDwnRdMZTx5s68fxJMlRjXer9acfUfhBbMAkEc2fi7/SvyD2iMd/FPW8lsqTwYxT0hq
	fqIb+IKH+Gj5btRQ41Zihgkqopxcfaso8r6m+hKaQrS4sNFwpwTMT6buEcwypv/yA545i5VOPrtvr
	5RE365j8LxXv2IofXgBgXgEJWQMHaTDkqOZIA7+IDvi9j6vXMRbS89enyOnN8UMS599fkvYSfG04w
	g8W8JaMQ2NAd1hxkVeDve1skAu3kR2d6gbFsR2ZA/w4o7mrwQB1kr+y0rXZcoMw+0XbMQUHmVdwri
	xYDGzOA28wyDj1oN5jQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTFNP-00000003Ciq-28Ag;
	Fri, 26 Jan 2024 06:07:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTFNL-00000003Cgn-1SKx
	for kexec@lists.infradead.org;
	Fri, 26 Jan 2024 06:07:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706249258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z72p/1NCFMOucyopgj4TN6714b15v6kjfWKT6hd64FE=;
	b=OXePnKwRnWqjAg2tkIgijCa3Aby18RqsbT/azQ+mw0MyP0qiE00Y7luB5k1jJ7BLpwASn6
	rNZEzdOsHnkE4rwD/SBGJ7gBo7X/zUxGILf0RENkyDeePiHep4Zg8SyadrV6bubTPpg71n
	AbFL3fdUEscdMYUZZHaV4bPKJU4dPPs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-Dvx_BaF4N36KKDvV0yy-Nw-1; Fri, 26 Jan 2024 01:07:33 -0500
X-MC-Unique: Dvx_BaF4N36KKDvV0yy-Nw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19D621013664;
	Fri, 26 Jan 2024 06:07:32 +0000 (UTC)
Received: from localhost (unknown [10.72.116.117])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 925AD492BC6;
	Fri, 26 Jan 2024 06:07:30 +0000 (UTC)
Date: Fri, 26 Jan 2024 14:07:27 +0800
From: Baoquan He <bhe@redhat.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
	loongarch@lists.linux.dev, akpm@linux-foundation.org,
	ebiederm@xmission.com, hbathini@linux.ibm.com, piliu@redhat.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH linux-next v3 00/14] Split crash out from kexec and clean
 up related config items
Message-ID: <ZbNMHwVhWxMyvKH/@MiWiFi-R3L-srv>
References: <20240124051254.67105-1-bhe@redhat.com>
 <20240126045551.GA126645@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240126045551.GA126645@dev-arch.thelio-3990X>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240125_220739_478169_7A7AB56E 
X-CRM114-Status: GOOD (  11.21  )
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

On 01/25/24 at 09:55pm, Nathan Chancellor wrote:
...... 
> I am seeing a few build failures in my test matrix on next-20240125 that
> appear to be caused by this series although I have not bisected. Some
> reproduction steps:

Thanks for trying this, I have reproduced the linking failure on arm,
will work out a way to fix it.

It's weird, I remember I have built these and passed.

> 
> $ curl -LSso .config https://git.alpinelinux.org/aports/plain/community/linux-edge/config-edge.armv7
> $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- olddefconfig all
> ...
> arm-linux-gnueabi-ld: arch/arm/kernel/machine_kexec.o: in function `arch_crash_save_vmcoreinfo':
> machine_kexec.c:(.text+0x488): undefined reference to `vmcoreinfo_append_str'
> ...
> 
> $ curl -LSso .config https://github.com/archlinuxarm/PKGBUILDs/raw/master/core/linux-aarch64/config
> $ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux- olddefconfig all
> ...
> aarch64-linux-ld: kernel/kexec_file.o: in function `kexec_walk_memblock.constprop.0':
> kexec_file.c:(.text+0x314): undefined reference to `crashk_res'
> aarch64-linux-ld: kernel/kexec_file.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `crashk_res' which may bind externally can not be used when making a shared object; recompile with -fPIC
> kexec_file.c:(.text+0x314): dangerous relocation: unsupported relocation
> aarch64-linux-ld: kexec_file.c:(.text+0x318): undefined reference to `crashk_res'
> aarch64-linux-ld: drivers/of/kexec.o: in function `of_kexec_alloc_and_setup_fdt':
> kexec.c:(.text+0x580): undefined reference to `crashk_res'
> aarch64-linux-ld: drivers/of/kexec.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `crashk_res' which may bind externally can not be used when making a shared object; recompile with -fPIC
> kexec.c:(.text+0x580): dangerous relocation: unsupported relocation
> aarch64-linux-ld: kexec.c:(.text+0x584): undefined reference to `crashk_res'
> aarch64-linux-ld: kexec.c:(.text+0x590): undefined reference to `crashk_res'
> aarch64-linux-ld: kexec.c:(.text+0x5b0): undefined reference to `crashk_low_res'
> aarch64-linux-ld: drivers/of/kexec.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `crashk_low_res' which may bind externally can not be used when making a shared object; recompile with -fPIC
> kexec.c:(.text+0x5b0): dangerous relocation: unsupported relocation
> aarch64-linux-ld: kexec.c:(.text+0x5b4): undefined reference to `crashk_low_res'
> aarch64-linux-ld: kexec.c:(.text+0x5c0): undefined reference to `crashk_low_res'
> ...
> 
> $ curl -LSso .config https://git.alpinelinux.org/aports/plain/community/linux-edge/config-edge.x86_64
> $ make -skj"$(nproc)" ARCH=x86_64 CROSS_COMPILE=x86_64-linux- olddefconfig all
> ...
> x86_64-linux-ld: arch/x86/xen/mmu_pv.o: in function `paddr_vmcoreinfo_note':
> mmu_pv.c:(.text+0x3af3): undefined reference to `vmcoreinfo_note'
> ...
> 
> Cheers,
> Nathan
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

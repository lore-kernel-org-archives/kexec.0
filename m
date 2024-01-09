Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E28C46CD2
	for <kexec@archiver.kernel.org>; Tue,  9 Jan 2024 03:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a13Qdt0QMpBiuRioJI/ajTH0iwEJ6FcHTMN8WxuwWyc=; b=ZFnimR/3nxEeRY
	E+njLE57GQy5t+mZaEmJ8WlVdx0tuVp07ZC95zKyvsjJrwnimKyCBPwlGpwO6p0sbE+RnIJ7xFqYr
	DZrJMqu5MWUiSoP+EC5kTdSaT1OtpQfSCb2H+t1Lk42dawV9AZ4liOMZJizJCVRu8QCq2FHWfoONH
	q2lwMGgKrj7MY0bERe+tQ/vYKSFzUQjSXhW8u8v5MEKV/1wYYPhhmElqC7PWDngVtEbl+IajUG4um
	Kazs+zfY2re7UnxMofiDxmHZnFyYPck17+xWY8onTFVNYHAZzJyc4LP2N5RYuTogjVxw15V81vLzk
	KSoAW7XofD9WCAUin4sQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rN382-006pna-1U;
	Tue, 09 Jan 2024 03:50:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rN37y-006pl9-0k
	for kexec@lists.infradead.org;
	Tue, 09 Jan 2024 03:50:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704772209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a0GQAZNSgQ9NYel79tdKOQqcnL4ZPX5GxjXGFUqL5FQ=;
	b=e13/v2wN/YcjrNNSSG5Ws0edv9GxRJ5hmbbIjKYM+rasZOLO/xX95m6xCTvKEd11fbCj0O
	LL7YRqtg7jeCESCj3P1mDTV2/S2h4nF6vmGL0dpg6Z25lYMMZ1Oe2Y8GlWOhNaVTzFvfm+
	Gp/L0bG51h/n0ow9Y/bEJQpVzhue9/o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-z2OS85ljPFq20Ze8WhKemQ-1; Mon, 08 Jan 2024 22:50:00 -0500
X-MC-Unique: z2OS85ljPFq20Ze8WhKemQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29B0285A588;
	Tue,  9 Jan 2024 03:49:59 +0000 (UTC)
Received: from localhost (unknown [10.72.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FFC53C4F;
	Tue,  9 Jan 2024 03:49:57 +0000 (UTC)
Date: Tue, 9 Jan 2024 11:49:54 +0800
From: Baoquan He <bhe@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	akpm@linux-foundation.org, kexec@lists.infradead.org,
	hbathini@linux.ibm.com, arnd@arndb.de, ignat@cloudflare.com,
	eric_devolder@yahoo.com, viro@zeniv.linux.org.uk,
	ebiederm@xmission.com, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/5] crash: clean up CRASH_DUMP
Message-ID: <ZZzCYr7t0FrMWafB@MiWiFi-R3L-srv>
References: <20240105103305.557273-6-bhe@redhat.com>
 <ZZqk+AnXbqnJuMdF@rli9-mobl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZZqk+AnXbqnJuMdF@rli9-mobl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240108_195010_336842_B24E3358 
X-CRM114-Status: GOOD (  15.82  )
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

On 01/07/24 at 09:19pm, kernel test robot wrote:
> Hi Baoquan,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v6.7-rc8]
> [cannot apply to powerpc/next powerpc/fixes tip/x86/core arm64/for-next/core next-20240105]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/kexec_core-move-kdump-related-codes-from-crash_core-c-to-kexec_core-c/20240105-223735
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20240105103305.557273-6-bhe%40redhat.com
> patch subject: [PATCH 5/5] crash: clean up CRASH_DUMP
> :::::: branch date: 2 days ago
> :::::: commit date: 2 days ago
> config: x86_64-randconfig-122-20240106 (https://download.01.org/0day-ci/archive/20240107/202401071326.52yn9Ftd-lkp@intel.com/config)
> compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240107/202401071326.52yn9Ftd-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/r/202401071326.52yn9Ftd-lkp@intel.com/

Thanks for reporting.

I have reproduced these linking errors, will consier how to rearrange
code change and fix them. The thing splitting kdump out could be more
complicated than I thought.

> 
> All errors (new ones prefixed by >>):
> 
> >> ld.lld: error: undefined symbol: crashk_res
>    >>> referenced by initramfs.c:638 (init/initramfs.c:638)
>    >>>               init/initramfs.o:(kexec_free_initrd) in archive vmlinux.a
>    >>> referenced by initramfs.c:638 (init/initramfs.c:638)
>    >>>               init/initramfs.o:(kexec_free_initrd) in archive vmlinux.a
>    >>> referenced by initramfs.c:0 (init/initramfs.c:0)
>    >>>               init/initramfs.o:(kexec_free_initrd) in archive vmlinux.a
>    >>> referenced 77 more times
> --
> >> ld.lld: error: undefined symbol: parse_crashkernel
>    >>> referenced by setup.c:479 (arch/x86/kernel/setup.c:479)
>    >>>               arch/x86/kernel/setup.o:(arch_reserve_crashkernel) in archive vmlinux.a
> --
> >> ld.lld: error: undefined symbol: crashk_low_res
>    >>> referenced by machine_kexec_64.c:539 (arch/x86/kernel/machine_kexec_64.c:539)
>    >>>               arch/x86/kernel/machine_kexec_64.o:(kexec_mark_crashkres) in archive vmlinux.a
>    >>> referenced by machine_kexec_64.c:539 (arch/x86/kernel/machine_kexec_64.c:539)
>    >>>               arch/x86/kernel/machine_kexec_64.o:(kexec_mark_crashkres) in archive vmlinux.a
>    >>> referenced by machine_kexec_64.c:539 (arch/x86/kernel/machine_kexec_64.c:539)
>    >>>               arch/x86/kernel/machine_kexec_64.o:(kexec_mark_crashkres) in archive vmlinux.a
>    >>> referenced 36 more times
> --
> >> ld.lld: error: undefined symbol: crash_update_vmcoreinfo_safecopy
>    >>> referenced by kexec_core.c:522 (kernel/kexec_core.c:522)
>    >>>               kernel/kexec_core.o:(kimage_crash_copy_vmcoreinfo) in archive vmlinux.a
>    >>> referenced by kexec_core.c:610 (kernel/kexec_core.c:610)
>    >>>               kernel/kexec_core.o:(kimage_free) in archive vmlinux.a
> --
> >> ld.lld: error: undefined symbol: crash_save_vmcoreinfo
>    >>> referenced by kexec_core.c:1053 (kernel/kexec_core.c:1053)
>    >>>               kernel/kexec_core.o:(__crash_kexec) in archive vmlinux.a
> --
> >> ld.lld: error: undefined symbol: paddr_vmcoreinfo_note
>    >>> referenced by kexec_core.c:1148 (kernel/kexec_core.c:1148)
>    >>>               kernel/kexec_core.o:(crash_prepare_elf64_headers) in archive vmlinux.a
> --
> >> ld.lld: error: undefined symbol: append_elf_note
>    >>> referenced by kexec_core.c:1390 (kernel/kexec_core.c:1390)
>    >>>               kernel/kexec_core.o:(crash_save_cpu) in archive vmlinux.a
> --
> >> ld.lld: error: undefined symbol: final_note
>    >>> referenced by kexec_core.c:1392 (kernel/kexec_core.c:1392)
>    >>>               kernel/kexec_core.o:(crash_save_cpu) in archive vmlinux.a
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

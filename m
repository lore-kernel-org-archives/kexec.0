Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE7B606A325
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kr9WghWI;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Si5aKroF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KZ1lrmFftcZp227HDnBABEgI98zobYONU8pPNNvhy9c=; b=kr9WghWIGZqEwlNqiukWD7dpTf
	EddPI+2q9C8LFb6JXTRmhUaPfwP74zLzi0X6+NssIbDXskaWVCwoFNta+Bq5Jr5aaULEiIW9vx4ld
	mtnFb4lHu90LqrUU0WUi9j5iOQKPiikeQ0jjaerJth0Y/zwMv7R5/XCzRmz1jux4OBeNI0cyBsSO4
	Rh2+Z2qFSbGWnHOlyEt1c6Tm9OskXQHneWbO2pawRXXwBaKaVgU1nb9MyPIhpw5Y+h1nqcwqTRK/9
	uEPADqeiHxihdtWPnLMMVbQOUDt9oZwGsvRrVTq1654bhquqhcCZ07j+e4Mg+HH+uuSPEYNocgbbw
	rRY9zUbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ56U-000000099ol-1Dyh;
	Tue, 20 Oct 2026 08:21:50 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ4vt-000000097ke-2qk6;
	Tue, 20 Oct 2026 08:10:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1EE8B60DA4;
	Tue, 20 Oct 2026 08:10:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843E51F000C5;
	Tue, 20 Oct 2026 08:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792483852;
	bh=KZ1lrmFftcZp227HDnBABEgI98zobYONU8pPNNvhy9c=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Si5aKroFBRQWvoPfQiWUtXY5pV8QpgRTZoMyRO15GNPz4DBKDDZ4+iSIyNHYtvZqz
	 G8lOTVxx6NmBdsjO1UBSP1zEZT4qLneCQe7uGvJPIQWns6h93fPilB2DLZGNa+FI1X
	 oNs2kA2m181Alm8R8g1+o+T40SoWbc2YMPMz1bo6wE5Vo2J4fzJ+Of7PHBfk2YhNhd
	 LNw3L2V3Q9kl/VRl12GSWRwMxpeyB7LrxcW/Qgu01ReVPUn0VH6x9EK6nNiGmKVqO+
	 uomF8qMGugM60D+AO/F2HDVDsDC4mXpuL2c4vvdFyya6eaFTHDwOvRcep1YD0ejLSn
	 ILyvkm6wO3wvA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 09/14] x86/crash: Fix massive out-of-bounds write on
 32-bit Highmem
From: Mike Rapoport <rppt@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
 chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, 
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
 ritesh.list@gmail.com, sshegde@linux.ibm.com, tglx@kernel.org, 
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
 gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
 akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, 
 pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, 
 leitao@debian.org, yeoreum.yun@arm.com, sourabhjain@linux.ibm.com, 
 robh@kernel.org, coxu@redhat.com, kees@kernel.org, tangyouling@kylinos.cn, 
 liukexin@kylinos.cn, zhangtianyang@loongson.cn, guodongtai@kylinos.cn, 
 maqianga@uniontech.com, chao.gao@intel.com, kai.huang@intel.com, 
 vishal.l.verma@intel.com, seanjc@google.com, piliu@redhat.com, 
 thuth@redhat.com, jbouron@amazon.com, me@linux.beauty, 
 mclapinski@google.com, graf@amazon.com, bgwin@google.com, 
 hbathini@linux.ibm.com, eric.devolder@oracle.com, 
 takahiro.akashi@linaro.org, james.morse@arm.com, palmer@rivosinc.com, 
 x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, driver-core@lists.linux.dev, 
 kexec@lists.infradead.org
In-Reply-To: <20260921090450.807575-10-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-10-ruanjinjie@huawei.com>
Date: Tue, 20 Oct 2026 11:09:39 +0300
Message-Id: <179248377976.302547.17579416672238014424.b4-review@b4>
X-Mailer: b4 0.16.1-dev
X-Mailman-Approved-At: Tue, 20 Oct 2026 01:21:11 -0700
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jinjie,

> On 32-bit x86 systems with HIGHMEM, kmap_local_page() only maps a single
> 4KB page. However, the elfcorehdr segment can span several pages (up to
> hundreds of kilobytes).
> 
> The original code blindly copies 'elfsz' bytes at once via
> memcpy_flushcache(), overwriting adjacent fixmap entries or critical
> virtual addresses.
> 
> Fix this by copying the new elfcorehdr page by page.

This is independed of other fixes and can be sent as a separate x86b fix.

> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Chao Gao <chao.gao@intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Eric DeVolder <eric.devolder@oracle.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: stable@vger.kernel.org
> Fixes: ea53ad9cf73b ("x86/crash: add x86 crash hotplug support")
> Link: https://sashiko.dev/#/patchset/20260907125404.922123-1-ruanjinjie%40huawei.com
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/x86/kernel/crash.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index e681ec9cf1dc8..3c9f4fbbe7ff0 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -447,9 +447,10 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
>   */
>  void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>  {
> -	void *elfbuf = NULL, *old_elfcorehdr;
>  	unsigned long mem, memsz;
>  	unsigned long elfsz = 0;
> +	void *elfbuf = NULL;
> +	unsigned long done;
>  
>  	/*
>  	 * As crash_prepare_elf64_headers() has already described all
> @@ -484,21 +485,20 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>  
>  	/*
>  	 * Copy new elfcorehdr over the old elfcorehdr at destination.
> -	 */
> -	old_elfcorehdr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
> -	if (!old_elfcorehdr) {
> -		pr_err("mapping elfcorehdr segment failed\n");
> -		goto out;
> -	}
> -
> -	/*
> -	 * Temporarily invalidate the crash image while the
> -	 * elfcorehdr is updated.
> +	 * The segment is physically contiguous but can span several pages.
> +	 * On 32-bit Highmem architectures, kmap_local_page() maps only a
> +	 * single page at a time, so copy page by page.
>  	 */
>  	xchg(&kexec_crash_image, NULL);
> -	memcpy_flushcache(old_elfcorehdr, elfbuf, elfsz);
> +	for (done = 0; done < elfsz; ) {
> +		size_t chunk = min_t(size_t, PAGE_SIZE, elfsz - done);
> +		void *dst = kmap_local_page(pfn_to_page((mem + done) >> PAGE_SHIFT));
> +
> +		memcpy_flushcache(dst, elfbuf + done, chunk);
> +		kunmap_local(dst);
> +		done += chunk;
> +	}

HIGMEM is only enabled on 32-bit and there elfsz cannot be "massive"
because it is the size of the headers just built for the CPUs and RAM
ranges actually present, not the large memsz reserved for hotplug.
On x86_32 (NR_CPUS <= 64) that is a few KiB at most.

Also, crashkernel is capped at CRASH_ADDR_HIGH_MAX = SZ_512M on X86_32,
which is below the default lowmem limit. For lowmem pages,
kmap_local_page() returns the contiguous direct-map address, so the old
code was already fine.

So the overflow needs the crash region to be in highmem, either through
crashkernel=size@offset above lowmem or through a large vmalloc=
setting, and an elfcorehdr larger than one page.

It is still worth fixing, but please drop "massive" from the subject.

The changelog should also mention the conditions when this could happen.

-- 
Sincerely yours,
Mike.



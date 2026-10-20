Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6176606A321
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RhZ+BO1a;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IzyGO92R
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qE6OXYMZCNhpTVqGUe213qDW93yxbpeyhbeKhLS4ZJQ=; b=RhZ+BO1aIAfDGF+p4k3iH2H4WK
	n+XbyeQuZgHWOFu+B8osx4q9OV8bVuX8es2CxdpC2+QfYqsdVYkrDF0dyGl+GgGp8l/qCzK3NSCZ/
	YW+ufh4Q6KcmDMnyCDrSYneo8T8aS6eTjH28AC4aaT+j0QowbRZ2xKaSmfhqiV6GxQX/+y+TcoWNF
	7rC5MiY5/Txks5LaB4F8Nt9PADU5oZ2h4UTdX2xKYTMranJSIyElAP50tECZfn2qqF5MTg1QDcKuu
	FOJZyc2lop4np+zhFVuU5Wc1i3TTDhUlabK4m934IT8NJdWDR9N5aT3UXbWiXA+lFSxNAfNEbfHa5
	95WAUsQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ56T-000000099nY-3rtz;
	Tue, 20 Oct 2026 08:21:49 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ4vf-000000097ic-3ZY4;
	Tue, 20 Oct 2026 08:10:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4BDD560229;
	Tue, 20 Oct 2026 08:10:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FC41F000C7;
	Tue, 20 Oct 2026 08:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792483839;
	bh=qE6OXYMZCNhpTVqGUe213qDW93yxbpeyhbeKhLS4ZJQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=IzyGO92Roy0DLQa95pMkJ03Bsx6UAwYJ9RGvSlTqTRAN5PpmHyGaPT0JR/f6L2Gqs
	 Q7DLgOTXUy3kHWVjtLJhTqjualhaQ1wu+ge85rzJEHCMK8KDS3daees6n7Ec5J6IyW
	 EK2hsFBuOeriYkFpDN3PJeTEIDYoNI3CcC/GFyPYdIPcVzgT6G1+FSPBq2Lv0jmSh2
	 AUkAFSkHj1F6OOlyiafKVljw4qbKhWr7KG0+Jkv9LQAs/393EOwra7DqAiXyB7U27t
	 Ud66NV0Hiv+XPejPYXfQRJKi8lofyLyoH7kNkBaIBpjUFCfpS7M2yDHuDCXiAzh6rF
	 IQn8Ye8g66exw==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 04/14] arm64: kexec_file: Fix CMA page leaks in
 segment placement retry loops
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
In-Reply-To: <20260921090450.807575-5-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-5-ruanjinjie@huawei.com>
Date: Tue, 20 Oct 2026 11:09:39 +0300
Message-Id: <179248377975.302547.8678981752345638279.b4-review@b4>
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

> During kexec image placement retry loops, any midway failure causes
> the loader to truncate `image->nr_segments` back to its initial state
> to purge the failed segments.
> 
> However, this truncation introduces a memory leak. The CMA pages
> allocated via kexec_add_buffer() during the failed attempt are tracked
> in the `image->segment_cma` array. Because the subsequent cleanup paths
> only iterate up to the truncated `nr_segments` boundary, these allocated
> CMA pages outside the new boundary are permanently leaked.
> 
> Fix this by explicitly releasing the associated CMA buffers in
> the failure paths before `image->nr_segments` is reduced.

I looked and how load_other_segments() implements error handling and it
seems it really needs more than these fixes.

It does not really follow "all or nothing" and it's use of "goto
out_err" is quite loosely coupled to actual error handling.

The same applies to LoongArch.

> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Breno Leitao <leitao@debian.org>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Yeoreum Yun <yeoreum.yun@arm.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: 07d24902977e4 ("kexec: enable CMA based contiguous allocation")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/arm64/kernel/kexec_image.c        | 1 +
>  arch/arm64/kernel/machine_kexec_file.c | 5 ++++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> index b70f4df15a1ae..ffcb7f9075e62 100644
> --- a/arch/arm64/kernel/kexec_image.c
> +++ b/arch/arm64/kernel/kexec_image.c
> @@ -107,6 +107,7 @@ static void *image_load(struct kimage *image,
>  		 * We couldn't find space for the other segments; erase the
>  		 * kernel segment and try the next available hole.
>  		 */
> +		kexec_free_segment_cma(image, kernel_segment_number);
>  		image->nr_segments -= 1;
>  		kbuf.buf_min = kernel_segment->mem + kernel_segment->memsz;
>  		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;

Sashiko comment about turning the loop into an infinite one seems valid
to me:

-- 
Sincerely yours,
Mike.



Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026B7606A322
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 03:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FjwOVo/I;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HuUipxgR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RbLlIDBzxSpd5cJfPOd2N3zvhSlGP9L2jcWxKocz/10=; b=FjwOVo/IFwr9nUOaoai4vTKHqy
	Nehkg5wLAE8vQWKUKCI85XqaqW+7yLmc2rcb33L+IALk96LQmTZqdxG57YJ0LOE4UdGrKfu2No3cw
	mJQkfgUMQYAIl7tCu2zWPOSyTp6fZ/Ufry/x7gIaVfXcD95NsZ3hhLsCMhbvmsKKFdFGUUeDzeDSU
	ArbPEIrwMQpVNmVyOAyPMaZvWpltq/QXyq4RudYO8YT9lB2t54y5LEgeoEVGZO3JxX9QoL8MsLLME
	yWsDvQ8h4/3uEHo4nD88/L7FraPlmYF3A1dBOdPKmqOwUoSiQtV9evGwO74nhxydW7W3cS0PXTa8M
	+nmhOIhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJN5S-0000000B0qe-2VPw;
	Wed, 21 Oct 2026 03:33:58 +0000
Received: from out-248.mta0.migadu.com ([2001:41d0:1004:224b::f8] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJN5P-0000000B0pG-1xV2
	for kexec@lists.infradead.org;
	Wed, 21 Oct 2026 03:33:57 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=y927hDeFwTRi1uuF8AFccBXiuWM2sJNn4YnO+caicLI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792553630; v=1; x=1793158430;
 b=HuUipxgRWS3e7sDvPB7ilyEUPgRtTmYZ+Pmv+0G7aSfoBB64N9Ezdvggr7cyCJYhNYRoNABQ
 1NIALLv0lL+pT7s1Ta2HlXtIcSDzHQRv1LjU8Bz41eNK1xug9eM3nBz5/ICuWBm7aW60JdMJAdN
 h6MPK5xaXrRLUQqt3HGTojB0=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 071bc8b21379f3c8;
	Wed, 21 Oct 2026 03:33:50 +0000
X-Mizu-Trace-ID: 071bc8b21379f3c8
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: pratyush@kernel.org
Cc: rppt@kernel.org,
	pasha.tatashin@soleen.com,
	chenhuacai@kernel.org,
	ardb@kernel.org,
	shuah@kernel.org,
	ilias.apalodimas@linaro.org,
	akpm@linux-foundation.org,
	baoquan.he@linux.dev,
	ruirui.yang@linux.dev,
	guodongtai@kylinos.cn,
	kernel@xen0n.name,
	graf@amazon.com,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v5 1/5] efi: add a KHO configuration table channel
Date: Wed, 21 Oct 2026 11:33:42 +0800
Message-ID: <20261021033342.3110-1-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2vxza4p95v6e.fsf@kernel.org>
References: <2vxza4p95v6e.fsf@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_203355_718462_25D3A0E9 
X-CRM114-Status: GOOD (  36.33  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Pratyush,

Thanks for the detailed review. I've rewriten the comments and commit messages
myself for v6. Replies inline.

On Tue, Sep 22 2026, Pratyush Yadav wrote:
> > +config EFI_KHO
> > +	bool
> > +	depends on EFI_STUB && EFI_GENERIC_STUB && KEXEC_HANDOVER
> > +	help
[...]
> I don't like adding a config for this sort of thing. Do we really need
> this? Why not just have the code always compiled and only used by
> loongarch? I don't really see we need a user decision for this sort of
> thing.

Agreed, v6 drops it.

> > +		/*
> > +		 * Reserve the stub-allocated table so it is neither handed
> > +		 * out by the buddy allocator nor placed on by kexec
> > +		 * segments, mirroring the memreserve handling above.  This
> > +		 * runs on every boot, so it also protects the table in the
> > +		 * next kernel until it reads it.
> > +		 */
>
> Nit: this comment is too wordy. Can you please make it more concise and
> to the point?

v6:

	/* Keep the buddy allocator and kexec segments off the table. */

> > +			if (kho->fdt_addr)
>
> When can kho->fdt_addr be NULL? Also, perhaps print a warning if
> early_memremap() fails?

It is 0 when there is nothing to restore:

  - on a cold boot, because the stub installs the table zeroed;
  - after a kexec into an image without KHO state, such as a crash
    kernel, because the table is zeroed just before that kexec.

v6 says this in the struct documentation, and adds a pr_warn() when
early_memremap() fails.

> > +	/*
> > +	 * Keep a persistent mapping of the table, the same way
> > +	 * efi_memreserve_root_init() keeps the memreserve root mapped:
> > +	 * efi_kho_update() is also called on the crash kexec path, where
> > +	 * memremap() is no longer an option.
> > +	 */
>
> No need to mention memreserve. Just explain the reason here. And keep it
> as short and to the point as possible.

v6:

	/* Map it now: the table is also written at panic time. */

> This is unreadable. Please add a human touch to this.
>
> And once again, the fact that it mirrors efi_mem_reserve_persistent()
> isn't important.

v6:

	/*
	 * Write the KHO addresses the next kernel should use, or zeroes
	 * if it should boot without KHO.
	 */

> Why ENODEV? Wouldn't ENOENT be a tiny bit better?

Neither, in v6. No table is the normal case outside LoongArch, so
efi_kho_update() now returns 0. The only error left is a table that
could not be mapped at boot, which returns -ENOMEM.

> This has too much information. You need to make it more to the point.
> For example, "without a device tree" already implies there is no /chosen
> property in the first place. No need to mention the function either.
>
> The lifetime of the table is certainly useful information but again,
> should be much more clear and to the point.
>
> Also, you should document what each of the members of the struct mean.

Agreed. v6:

	/**
	 * struct linux_efi_kho_data - KHO state passed to the next kernel
	 * @fdt_addr: physical address of the KHO FDT, 0 if there is none
	 * @fdt_size: size of the KHO FDT
	 * @bootmem_addr: physical address of the bootmem area list
	 * @bootmem_size: size of the bootmem area list
	 *
	 * Pointed to by the LINUX_EFI_KEXEC_HANDOVER_GUID configuration table.
	 *
	 * The EFI stub installs this table zeroed on a cold boot. It stays
	 * in place across kexec; the running kernel rewrites it just before
	 * each kexec, and the next kernel reads it during early boot.
	 *
	 * The layout is fixed. Changing it requires a new GUID.
	 */

> Note: I recently sent a series that renames scratch to bootmem [0]. It
> looks close to landing. So you likely need to rename this to
> bootmem_{addr,size}.

Thanks for the heads-up. It is in liveupdate/next now, so v6 is based
on it and uses bootmem_{addr,size}.

> Why __packed?

No good reason. All four members are u64, so there is no padding
and __packed changes nothing. Dropped.

Thanks,
George


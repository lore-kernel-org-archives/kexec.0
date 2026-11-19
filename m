Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD1F606A324
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HQfRRRtp;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MIHzLV8A
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=+o0bQUd8q0A+WRUXZxAmN8P7csYU6Eu6m9jj0vuUv3w=; b=HQfRRRtpP52QtHadIrC6HmTJxT
	dDWaBCbPZi6jHvK0AK8SH4qH0pVS3EfkE/TiGJf8pT1s6a+rfPaOSYTQukUFTBQwv/5CRjNJF8OxK
	E926AqH7lPa5fbLqXhghlbnl+2vh96axPQ8k4AhxdvmU4fLdz/nTa0ubNRykt1zMNjQjQDe7Ggjgg
	ZpZlwcr/FgddWxX4sJiTUTC8O5aBLdOPAHIMwfFwb6QMkSS0SGZK/l1Ch5eD9a2T7F34pjORdYs+Z
	gKPL8F7qKKS3dV+P5iu1lW2Eu23VKS3oQl4GaBfV0fX7AfRVlLQfkzE5B1zLagwCTW/XvAv3Z1BHm
	QZU0N+cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTzqO-0000000Bcn8-0bkB;
	Thu, 19 Nov 2026 10:58:20 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTzqM-0000000BcmJ-1TXt
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 10:58:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 050A1612E9;
	Thu, 19 Nov 2026 10:58:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA28D1F000C4;
	Thu, 19 Nov 2026 10:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795085896;
	bh=+o0bQUd8q0A+WRUXZxAmN8P7csYU6Eu6m9jj0vuUv3w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=MIHzLV8As6nXxtqY6me3mqzdXMBaRaBOWQfGJwhvK3jossC2GDG2Ra6MFKWW4G+PA
	 FSE2j3Y2nrgYKsoZRqeaQlmmR8HldEkKQX/ibJlGfPtyxwuDyYtL+xn/5wmzzz9v7l
	 5FGWgzmXPkWsCVt8Us7AHZKoM27j4CijTLiDv3A5kZZVUgHGXiPdfaNJLoY6UIIyb3
	 5zUQWEG9CGNQ5rsRZ+yKBwxyMv1MVd/HvFPW6rmUc8+i1/G3rENaOYczrKWZpdGWCp
	 PdEYWVcB7FsPeI2kwfT60Qzmw+M8L3OMHvVFc0+jgQvHEL/6alUpmO0kf3kFqCnvDg
	 nyLPMZIojBYvw==
From: Pratyush Yadav <pratyush@kernel.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: chenhuacai@kernel.org,  ardb@kernel.org,  pratyush@kernel.org,
  rppt@kernel.org,  pasha.tatashin@soleen.com,  shuah@kernel.org,
  ilias.apalodimas@linaro.org,  akpm@linux-foundation.org,
  baoquan.he@linux.dev,  ruirui.yang@linux.dev,  guodongtai@kylinos.cn,
  kernel@xen0n.name,  graf@amazon.com,  liukexin@kylinos.cn,
  loongarch@lists.linux.dev,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kselftest@vger.kernel.org,  linux-efi@vger.kernel.org
Subject: Re: [PATCH v6 1/8] efi: Pass KHO state to the next kernel in a
 configuration table
In-Reply-To: <20261119082252.9120-1-dongtai.guo@linux.dev> (George Guo's
	message of "Thu, 19 Nov 2026 17:22:52 +0900")
References: <CAAhV-H5Vse=pKC3Beqhqxa7fqadiGVNqkSy_06HZ3Luw2Pmj5Q@mail.gmail.com>
	<20261119082252.9120-1-dongtai.guo@linux.dev>
Date: Thu, 19 Nov 2026 10:58:11 +0000
Message-ID: <2vxzecch3x6k.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19 2026, George Guo wrote:

> Hi Huacai, Ard, Pratyush,
>
> On Wed, Nov 04 2026, Huacai Chen wrote:
>> I prefer to keep it in LoongArch until a second architecture, and I
>> think Ard is the same. But this is not a strong objection to Pratyush.
>
> Kexin Liu and I have tried x86 as the second user, to see whether the
> common table holds up. It needed only small changes:
>
> - The x86 EFI stub installs the table, as the LoongArch stub does.
>   install_kho_table() moves from efi-stub.c to efi-stub-helper.c so
>   that the x86 stub can call it.
>
> - kexec_file_load() skips the SETUP_KEXEC_KHO record when the table
>   exists and the next kernel will get efi_info. Otherwise, for example
>   on a legacy BIOS boot or with noefi, it falls back to setup_data.

Do we even care about non-EFI boot? I'd say ignore that for now until
someone comes with a real use case for KHO on such systems.

>
> - When there is no SETUP_KEXEC_KHO record, the decompressor's KASLR
>   code looks up the KHO bootmem areas in the table, so the kernel is
>   not decompressed onto preserved memory.
>
> The table layout did not change. The only change to the common code is
> that efi_kho_table_found() is no longer __init, since x86 calls it at
> kexec load time.
>
> Tested in QEMU on x86_64. With OVMF, the KHO vmtest and
> luo_kexec_simple pass, and the second kernel finds the KHO state
> through the table. With SeaBIOS, the KHO vmtest passes through
> setup_data.
>
> So I would like to keep the table common in v7. Would you prefer the
> x86 patches in the same series, so that the generic code comes with a
> second user, or as a separate series on top?

This should be a follow up series. Don't get your series get caught up
in x86 changes.

>
> Pratyush, does this match what you had in mind for x86?

Sounds good to me. You will still need to chase Ard for an ACK on the
generic EFI table though.

-- 
Regards,
Pratyush Yadav


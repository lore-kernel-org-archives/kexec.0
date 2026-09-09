Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E3FC79F82
	for <kexec@archiver.kernel.org>; Wed,  9 Sep 2026 00:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rqDAXVamJDqDm7CB0ZWG2yGaN0peUYMJjUzbrCbdIoE=; b=jliP+uFCciYOIzzHZnUY59LLFt
	OeGRW1Wvx9SUN/RQlCQpTWHrVj5p4lTWalLw1iF/8tAAY+g1iGo/K2KlFXR8dpWyjFcKvq/I0Glb9
	OWemasGiHfdVGtZXW5u1QSsPmxwpXAzPMvO5Uv0rntJdsOA7q7OvL8aMagTZArBqisIRnH/u2j398
	nvWiS9F6zHF/+lHw+lFj9A4Obb7nM3JiclA59JmjJgYvRC0giaNnYBcnGlLgjsrDdLE96jyWxXeUn
	JHwZN3iLiSesZVDy1bi0/YmDmdAerVRDeoNiwBCKlOA69DMb6SfaQdYTqYlkmM7UG+OuiEXbdAyO+
	vE+fWt3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46Yt-0000000AYGf-2Emq;
	Wed, 09 Sep 2026 00:53:15 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46Yq-0000000AYGN-3JGB;
	Wed, 09 Sep 2026 00:53:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 618A041791;
	Wed,  9 Sep 2026 00:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E471F00A3A;
	Wed,  9 Sep 2026 00:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788915192;
	bh=rqDAXVamJDqDm7CB0ZWG2yGaN0peUYMJjUzbrCbdIoE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ei4HqNHbuFw/xlOC+677YJ6Su4j1Ya8m8Y5Zfl4n1Fz57Qq59YoVOnulVyIoUsfHc
	 4ddZKSeOissymfGqqaY59V94yUldMkw5H9h3IprBdZOf+VrX+Bad5nQAQI90YArrxH
	 TV5FhBvD/1mTHUJcJQSUukebB4U3bPYckBMekrnb2zrwml3VH0InLEw7v+8+1wJLxJ
	 8cH5NV/A2lUC9OHNeexXr4yyB0E50FoSTsHTpBRJwqOx6xHJoPg8pIZ1S8hebWxrnv
	 U7XWasTISXvL5tnyAwbgv47Kkw5YKz5pXqq41LY0hhg9fR1f+ToRkzndVjrKcStdOq
	 HBwNRvMOF2xLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/9] crash_dump: Fix potential double free and UAF of
 keys_header
To: "Coiby Xu" <coiby.xu@gmail.com>
Cc: "Jinjie Ruan" <ruanjinjie@huawei.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Sourabh
 Jain" <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org, "Pratyush
 Yadav" <pratyush@kernel.org>, "Dave Young" <ruirui.yang@linux.dev>, "Will
 Deacon" <will@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Baoquan He" <baoquan.he@linux.dev>, linux-arm-kernel@lists.infradead.org, "open
 list" <linux-kernel@vger.kernel.org>
In-Reply-To: <20260909003657.1570544-2-coiby.xu@gmail.com>
References: <20260909003657.1570544-1-coiby.xu@gmail.com>
 <20260909003657.1570544-2-coiby.xu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 00:53:11 +0000
Message-Id: <20260909005311.B1E471F00A3A@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Prematurely clearing `is_dm_key_reused` breaks the ARM64 kexec_fil=
e_load retry loop and defeats hotplug dm-crypt key reuse.

Pre-existing issues:
- [High] Mapping crash-reserved memory with `kmap_local_page()` causes out-=
of-bounds reads if dm-crypt keys exceed a single page.
--

commit 9cf0538566bf6406e97a7f29629856abff44a5b0
Author: Coiby Xu <coiby.xu@gmail.com>

crash_dump: Fix potential double free and UAF of keys_header

This commit addresses a potential double free and UAF of keys_header when
loading dm-crypt keys for kdump. It establishes an invariant to free
keys_header at the end of kexec_file_load unless reuse=3Dtrue.

> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_im=
age.c
> index b70f4df15a1ae..1a0ca54adc9a4 100644
> --- a/arch/arm64/kernel/kexec_image.c
> +++ b/arch/arm64/kernel/kexec_image.c
> @@ -110,6 +110,7 @@ static void *image_load(struct kimage *image,
>  		image->nr_segments -=3D 1;
>  		kbuf.buf_min =3D kernel_segment->mem + kernel_segment->memsz;
>  		kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> +		crash_dm_crypt_cleanup(image);

[Severity: High]
Does this call to crash_dm_crypt_cleanup() during a retry loop unintentiona=
lly
free the keys_header buffer?

Since crash_load_dm_crypt_keys() unconditionally clears the is_dm_key_reused
flag before returning, any mid-retry cleanup performed here when segment
placement fails will see the flag as false and wrongfully free the valid
keys_header buffer.

>  	}
> =20
>  	if (ret) {

[ ... ]

> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index c685497cd470e..f638fb4b8554c 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -84,18 +84,25 @@ static int add_key_to_keyring(struct dm_crypt_key *dm=
_key,

[ ... ]

> -static void get_keys_from_kdump_reserved_memory(void)
> +static int get_keys_from_kdump_reserved_memory(void)
>  {
>  	struct keys_header *keys_header_loaded;
> +	size_t keys_header_size;
> =20
> -	arch_kexec_unprotect_crashkres();
> +	keys_header_size =3D get_keys_header_size(key_count);
> +	keys_header =3D kzalloc(keys_header_size, GFP_KERNEL);
> +	if (!keys_header)
> +		return -ENOMEM;
> =20
> +	arch_kexec_unprotect_crashkres();
>  	keys_header_loaded =3D kmap_local_page(pfn_to_page(
>  		kexec_crash_image->dm_crypt_keys_addr >> PAGE_SHIFT));
> =20
> -	memcpy(keys_header, keys_header_loaded, get_keys_header_size(key_count)=
);
> +	memcpy(keys_header, keys_header_loaded, keys_header_size);

[Severity: High]
This is a pre-existing issue, but does this copy read out of bounds?

kmap_local_page() guarantees mapping exactly one physical page frame. If us=
er
configuration has enough dm-crypt keys (e.g., > 10 keys, where each struct =
is
388 bytes), keys_header_size easily exceeds the 4KB page size.

Copying beyond the single-page mapping will cause out-of-bounds reads and
could trigger a kernel panic on systems with HIGHMEM or when
CONFIG_DEBUG_KMAP_LOCAL is enabled. Could memremap() be used instead?

>  	kunmap_local(keys_header_loaded);
>  	arch_kexec_protect_crashkres();
> +
> +	return 0;
>  }

[ ... ]

> @@ -441,18 +458,33 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>  	r =3D kexec_add_buffer(&kbuf);
>  	if (r) {
>  		pr_err("Failed to call kexec_add_buffer, ret=3D%d\n", r);
> -		kvfree((void *)kbuf.buffer);
> -		return r;
> +		goto out;
>  	}
> +
>  	image->dm_crypt_keys_addr =3D kbuf.mem;
>  	image->dm_crypt_keys_sz =3D kbuf.bufsz;
>  	kexec_dprintk(
>  		"Loaded dm crypt keys to kexec_buffer bufsz=3D0x%lx memsz=3D0x%lx\n",
>  		kbuf.bufsz, kbuf.memsz);
> =20
> +out:
> +	is_dm_key_reused =3D false;

[Severity: High]
Does prematurely clearing is_dm_key_reused here destroy the state needed for
the segment placement retry loop?

On ARM64, if the first attempt at segment placement fails, the kexec load
code retries the loop. Since the flag is unconditionally cleared here, the
first iteration will clear it. When the retry cleanup executes in
image_load(), it will see is_dm_key_reused =3D=3D false, freeing the keys_h=
eader
buffer and leaving subsequent retries without the required keys.

>  	return r;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909003657.1570=
544-1-coiby.xu@gmail.com?part=3D1


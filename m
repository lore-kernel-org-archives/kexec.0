Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D00CC79F9E
	for <kexec@archiver.kernel.org>; Wed,  9 Sep 2026 00:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QCn4OEnHLNQOKmzJsiaaUSfwxj7ZgT9z0ighC6IauIs=; b=2Fg3k9u+3Iofn3H3YVy61jUale
	SRpS866kKwXaetMettKchZeDj5k00LLOA7KwCiNBecvqm5ZyksP1jsEt37Ks9mSDEAwoEHBD5/AN2
	NxLrNO2zDiR2NjeYdItT8SZu2tAagFjCwJJVc9ZOGpjKTgTV/WHDLn4Jo8d/vRHSVNktOfG7Z9iPZ
	tOdhhpprwKuzz6D5JZqfQfU59JEFMZ1hl5RgBU8WkjUUF+SRfvOU2C6pg0f3sdzrp0yjLTK45wDPZ
	Ae8TQ5QsTII+1Y6459oMOKWv/61UifINXpZRD5hz9caPKEEfFDz82ueO0k8urWWpS69cvQArTPuPf
	mgJF6zKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46Xj-0000000AY4R-0t8d;
	Wed, 09 Sep 2026 00:52:03 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46Xi-0000000AY4H-1Mi1;
	Wed, 09 Sep 2026 00:52:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 85D01601FE;
	Wed,  9 Sep 2026 00:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971151F00A3A;
	Wed,  9 Sep 2026 00:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788915121;
	bh=QCn4OEnHLNQOKmzJsiaaUSfwxj7ZgT9z0ighC6IauIs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LyaxXpSWdzPebNC94mbBljjNsCX8TcPAJefgt17gkPtdzmyisNXO4MIZYDIKFQfHK
	 LN7f1kh/Csse0aWpdxw+T21ZIcxKAAeUAemEC99lC0aBmgLqWC0WwLJW56vh+n2DIn
	 Sb3s5Eiv4osYhigb0WE3zK8teAC84SJerZi5MBT7CG7zk7G+Egulem1xXyHiCANyam
	 dXMxbWO9ujUMgqqRgfPaYLz+XHuLm2CdHsUylQe19cWkj5GtVH93nckoCTyUz5nPt1
	 0JhVu/zrdzeDFn9PXdqNjYHWCG6bsRRvuc/LtyWW0+cIah368ARD+zBdoArYXfOUKm
	 ShAn0xEC6GvPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/9] crash_dump: Read the number of dm-crypt keys
 from reserved memory
To: "Coiby Xu" <coiby.xu@gmail.com>
Cc: "Sourabh Jain" <sourabhjain@linux.ibm.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Pratyush
 Yadav" <pratyush@kernel.org>, linux-arm-kernel@lists.infradead.org, "Baoquan
 He" <baoquan.he@linux.dev>, "Dave Young" <ruirui.yang@linux.dev>, kexec@lists.infradead.org, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Will Deacon" <will@kernel.org>, "open
 list" <linux-kernel@vger.kernel.org>
In-Reply-To: <20260909003657.1570544-3-coiby.xu@gmail.com>
References: <20260909003657.1570544-1-coiby.xu@gmail.com>
 <20260909003657.1570544-3-coiby.xu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 00:52:00 +0000
Message-Id: <20260909005200.971151F00A3A@smtp.kernel.org>
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
- [High] Unconditionally clearing `is_dm_key_reused` defeats the key cachin=
g mechanism, silently breaking hotplug kdump reloads and ARM64 segment retr=
ies.

Pre-existing issues:
- [High] Out-of-bounds read past the 4KB window of `kmap_local_page` when r=
eading dm-crypt keys from reserved memory.
--

commit f9061da466f53a4935cffc1bfaa1ac6f1ef0c0ef
Author: Coiby Xu <coiby.xu@gmail.com>

crash_dump: Read the number of dm-crypt keys from reserved memory

This patch reads the number of dm-crypt keys from reserved memory to handle
cases where users add or delete keys by mistake. This aims to improve safety
over reusing saved keys for CPU/memory hot-plugging.

> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index f638fb4b8554c..3a416933979f8 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -88,21 +88,31 @@ static int get_keys_from_kdump_reserved_memory(void)
>  {
>  	struct keys_header *keys_header_loaded;
>  	size_t keys_header_size;
> -
> -	keys_header_size =3D get_keys_header_size(key_count);
> -	keys_header =3D kzalloc(keys_header_size, GFP_KERNEL);
> -	if (!keys_header)
> -		return -ENOMEM;
> +	int r =3D 0;
> =20
>  	arch_kexec_unprotect_crashkres();
>  	keys_header_loaded =3D kmap_local_page(pfn_to_page(
>  		kexec_crash_image->dm_crypt_keys_addr >> PAGE_SHIFT));
> =20
> +	if (keys_header_loaded->total_keys <=3D 0 ||
> +	    keys_header_loaded->total_keys > KEY_NUM_MAX) {
> +		pr_warn("keys_header saved to reserved memory may be corrupt\n");
> +		r =3D -EINVAL;
> +		goto kunmap;
> +	}
> +
> +	keys_header_size =3D get_keys_header_size(keys_header_loaded->total_key=
s);
> +	keys_header =3D kzalloc(keys_header_size, GFP_KERNEL);
> +	if (!keys_header) {
> +		r =3D -ENOMEM;
> +		goto kunmap;
> +	}
> +
>  	memcpy(keys_header, keys_header_loaded, keys_header_size);

[Severity: High]
This is a pre-existing issue, but does this memcpy() cause an out-of-bounds
read in get_keys_from_kdump_reserved_memory()?

The pointer keys_header_loaded is set up using kmap_local_page(), which
establishes a virtual mapping strictly limited to a single 4KB page.
However, keys_header_size can reach up to approximately 49.6KB (128 keys
at 388 bytes each).

Could this read past the kmap_local_page window if enough keys are populated
to exceed the 4KB boundary, causing a kernel page fault or copying unrelated
memory into the dm-crypt keys buffer?

> +kunmap:
>  	kunmap_local(keys_header_loaded);
>  	arch_kexec_protect_crashkres();
> -
> -	return 0;
> +	return r;
>  }

[ ... ]

> @@ -432,12 +442,13 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>  	};
>  	int r =3D 0;
> =20
> -	if (key_count <=3D 0) {
> -		kexec_dprintk("No dm-crypt keys\n");
> -		return 0;
> -	}
> -
>  	if (!is_dm_key_reused) {
> +		if (key_count <=3D 0) {
> +			kexec_dprintk("No dm-crypt keys\n");
> +			r =3D 0;
> +			goto out;
> +		}
> +

[Severity: High]
Does this goto out path in crash_load_dm_crypt_keys() unintentionally defeat
the key caching mechanism?

By jumping to the out label where is_dm_key_reused is set to false, it
appears the kexec cleanup function (crash_dm_crypt_cleanup) will now
unconditionally free keys_header since the flag is cleared.

On architectures like ARM64, if kexec segment allocation fails and retries,
the dm-crypt keys may be silently omitted from the new kdump image because
the retry loop will skip loading them (returning success but leaving out the
keys segment).

Could this break the intended caching mechanism for CPU and memory hotplug
events, leading to a silent failure to unlock the encrypted dump target
during a crash?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909003657.1570=
544-1-coiby.xu@gmail.com?part=3D2


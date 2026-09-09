Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7458EC79F82
	for <kexec@archiver.kernel.org>; Wed,  9 Sep 2026 00:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jSmq3oCnp2YAGwPRamuT28dFabYmGkAvDYbBsJAm1ms=; b=ZPqCOjn0Pfh3MHT+htOYgMqRBl
	+mQL7+Z9HDuwb92VOTqm6bnoJ5baVLmNwXTMcWdbjWLX50XAxahKCEBpj+bfHjZiWYAOM4UEjcEMx
	SBVdOFvPmAMH8ge/+gLFrdbweeBhcEvtYPDhUD9v0E+EtH7yU9M2WGFcUQvD94KTO6CL8yW45x0U2
	am4ySo3ZrwzyL/z3fDPccynIy7zpNZMcM/Eruk8GP5AKxW85zcy7Quk++YvbD2CpZfYCwrVG6GI2I
	kka1BZropEAMicxpxL+n7hopsLIYEfzbxrxJwhCZBH7NADLcedkAiuHblDdDYoQWeIw73PnxkvKpt
	Bz9TbBNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46V8-0000000AXlO-1LDo;
	Wed, 09 Sep 2026 00:49:22 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46V6-0000000AXkg-3P29;
	Wed, 09 Sep 2026 00:49:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 41F5C601FD;
	Wed,  9 Sep 2026 00:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7802D1F00A3A;
	Wed,  9 Sep 2026 00:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788914960;
	bh=jSmq3oCnp2YAGwPRamuT28dFabYmGkAvDYbBsJAm1ms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B2yAef8KtyR421Rf1tDcWdczuhbM0kb1hvxrobN/ZkUmZ8zE4DdPV79APxzELRFdm
	 5WJtJknInPlJctDcCG13XIWNnD4OO4oSP0pAsXOvLkoiyXOMK98VF0nA+pdyS7IREf
	 6WTF6cXyWXpFCY2bxpfwU6Vn7pFB1WbsUvvIwJq3cgtcMulMaPaFcaMgbGmq+1IDqg
	 m5LXK0V+E9jet95Fz0cUDdEOWRr4g4eoaI16FHH3B/zkYfRnMFwz8h4R3P9XonoVw0
	 SdJi35BygJFlz3IbgIL5nnYVGRqS0Egrik6OiM4VF/4naLPKoNARkKzEs3lEToksMC
	 /EOhwKpE7ygfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/9] crash_dump: Check the function return codes in
 restore_dm_crypt_keys_to_thread_keyring
To: "Coiby Xu" <coiby.xu@gmail.com>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Will Deacon" <will@kernel.org>, kexec@lists.infradead.org, "Pratyush
 Yadav" <pratyush@kernel.org>, "Dave Young" <ruirui.yang@linux.dev>, "Mike
 Rapoport" <rppt@kernel.org>, linux-arm-kernel@lists.infradead.org, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Baoquan He" <baoquan.he@linux.dev>, "Sourabh
 Jain" <sourabhjain@linux.ibm.com>, "open list" <linux-kernel@vger.kernel.org>, "Jinjie
 Ruan" <ruanjinjie@huawei.com>
In-Reply-To: <20260909003657.1570544-8-coiby.xu@gmail.com>
References: <20260909003657.1570544-1-coiby.xu@gmail.com>
 <20260909003657.1570544-8-coiby.xu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 00:49:19 +0000
Message-Id: <20260909004919.7802D1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [Medium] Memory and reference leak of the key returned by key_create_or_u=
pdate() on the success path.
- [Medium] Incorrect return value assignment from `dm_crypt_keys_read()` br=
eaks the caller's success check for empty key sets.

Pre-existing issues:
- [High] Missing validation of `dm_crypt_keys_addr` leads to arbitrary memo=
ry reads.
- [High] Buffer over-read from single mapped page in get_keys_from_kdump_re=
served_memory().
- [High] Missing validation on parsed key attributes leads to massive Heap =
Out-of-Bounds reads and Information Leak.
- [Medium] Double fetch of the key count from untrusted memory leads to Hea=
p Out-of-Bounds read.
--

commit e9dcb18898d315e8ec7102932e9391f9c0892b97
Author: Coiby Xu <coiby.xu@gmail.com>
Subject: crash_dump: Check the function return codes in restore_dm_crypt_ke=
ys_to_thread_keyring

This commit adds return code checking for dm_crypt_keys_read() and
add_key_to_keyring() to properly abort when reading old memory or
allocating a keyring fails. It also deletes unused code related to
the key reference.

> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index b8fe630462cfa..bc70fbb79e0f6 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -66,7 +66,7 @@ static int add_key_to_keyring(struct dm_crypt_key *dm_k=
ey,
>  			      key_ref_t keyring_ref)
>  {
>  	key_ref_t key_ref;
> -	int r;
> +	int r =3D 0;
> =20
>  	/* create or update the requested key and add it to the target keyring =
*/
>  	key_ref =3D key_create_or_update(keyring_ref, "user", dm_key->key_desc,
> @@ -74,8 +74,6 @@ static int add_key_to_keyring(struct dm_crypt_key *dm_k=
ey,
>  				       KEY_USR_ALL, KEY_ALLOC_IN_QUOTA);
> =20
>  	if (!IS_ERR(key_ref)) {
> -		r =3D key_ref_to_ptr(key_ref)->serial;
> -		key_ref_put(key_ref);
>  		pr_debug("Success adding key %s\n", dm_key->key_desc);

[Severity: Medium]
Does removing key_ref_put() here leak the key reference?

key_create_or_update() returns a key reference specifically for the caller
with an incremented usage count, so without key_ref_put(), the key's usage
count might be permanently elevated, preventing it from ever being garbage
collected.

>  	} else {
>  		r =3D PTR_ERR(key_ref);

[ ... ]

> @@ -134,9 +132,14 @@ static int restore_dm_crypt_keys_to_thread_keyring(v=
oid)
>  	}
> =20
>  	addr =3D dm_crypt_keys_addr;
> -	dm_crypt_keys_read((char *)&key_count, sizeof(key_count), &addr);
> +	ret =3D dm_crypt_keys_read((char *)&key_count, sizeof(key_count), &addr=
);

[Severity: High]
This is a pre-existing issue, but is it safe to read from dm_crypt_keys_addr
without verifying if it was ever initialized by the command-line argument?

If the kdump kernel is booted without the dmcryptkeys=3D parameter,
dm_crypt_keys_addr might remain 0, leading to arbitrary memory reads
when this sysfs attribute is triggered.

> +	if (ret < 0) {
> +		pr_err("Failed to read the number of dm-crypt keys\n");
> +		goto out;
> +	}
> +

[ ... ]

> @@ -151,12 +154,18 @@ static int restore_dm_crypt_keys_to_thread_keyring(=
void)
>  		goto out;
>  	}
> =20
> -	dm_crypt_keys_read((char *)keys_header, keys_header_size, &addr);
> +	ret =3D dm_crypt_keys_read((char *)keys_header, keys_header_size, &addr=
);

[Severity: Medium]
If dm_crypt_keys_read() succeeds, it returns a positive byte count which is
assigned to ret. If there are no keys and the loop below doesn't execute,
will this function incorrectly return a positive value instead of 0?

The caller config_keys_restore_store() expects !ret to set restore =3D true,
which would fail if ret is a positive byte count.

> +	if (ret < 0) {
> +		pr_err("Failed to read dm-crypt keys\n");
> +		goto out;
> +	}
> =20
>  	for (int i =3D 0; i < keys_header->total_keys; i++) {

[Severity: Medium]
This is a pre-existing issue, but does the second read from oldmem physical=
ly
overwrite keys_header->total_keys with unvalidated data?

If oldmem changes concurrently or the read partially fails, the newly fetch=
ed
total_keys can exceed the originally validated key_count. The loop bounds
check uses this unvalidated bound, potentially causing a heap out-of-bounds
read.

>  		key =3D &keys_header->keys[i];
>  		pr_debug("Get key (size=3D%u)\n", key->key_size);
> -		add_key_to_keyring(key, keyring_ref);
> +		ret =3D add_key_to_keyring(key, keyring_ref);

[Severity: High]
This isn't a bug introduced by this patch, but are key->key_size and
key->key_desc validated before being passed to add_key_to_keyring()?

The completely untrusted key_size is passed as the payload length to
key_create_or_update(), which might read far out-of-bounds from dm_key->data
and embed leaked kernel heap memory into the key payload. Additionally,
key_desc is not checked for null-termination.

> +		if (ret)
> +			break;
>  	}

[ ... ]

While reviewing this file, I also noticed another pre-existing issue in
get_keys_from_kdump_reserved_memory():

kernel/crash_dump_dm_crypt.c:get_keys_from_kdump_reserved_memory() {
    ...
	keys_header_loaded =3D kmap_local_page(pfn_to_page(
		kexec_crash_image->dm_crypt_keys_addr >> PAGE_SHIFT));
    ...
	memcpy(keys_header, keys_header_loaded, keys_header_size);
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but does this memcpy() read
past the boundaries of the mapped page?

kmap_local_page() establishes a mapping for exactly one page (4096 bytes),
but keys_header_size could be up to ~49KB. This will read far beyond the
single page boundary, potentially causing a kernel panic on architectures
where kmap_local_page() does not fall back to the direct map.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909003657.1570=
544-1-coiby.xu@gmail.com?part=3D7


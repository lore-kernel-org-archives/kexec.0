Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21EA606A7DC
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 13:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Qx03X6bA;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=JTawrn+r
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:
	Subject:Cc:To:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=XQDfTOBLyQYKItk/7IbkqTdv3CPMUC9LzGhAb3DHHto=; b=Qx03X6bA3N/8tF
	JMVI+U1eX0/8XWcwhRMmH8v+tRzCr1u9ikHlHH5c2R4dqED1EXoQK5/DdwZrVsXZorfYvnVlot/nw
	DRNJ4n2CJ97iZi+VWeRnQKS/gvcvuh8GIlPL/zRHb+uriscsw0o7A4ajPI4Dub0ANopGAS6IQq0r0
	snXPgh+v0NPzTg/WMmhPJz9ZKXH/ZmVe+9b+XauuNMHgIGDY+uK3ff6DCsKZWC53ngO8Z+ftHSVAg
	WfBsbab8LT1FZJwmOBfSawLSk61Mg9NvImgeuLX9EsAW0zRSNk5TROmwgeOLC/bQpPMm+NhewyZ8V
	fwOe2+bMKUFeF5NPiJDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQlcZ-00000003z8N-326o;
	Tue, 10 Nov 2026 13:10:43 +0000
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQlcS-00000003z1g-0roW
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 13:10:37 +0000
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-5e9528732b4so724484e0c.0
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 05:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794316235; x=1794921035; darn=lists.infradead.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XQDfTOBLyQYKItk/7IbkqTdv3CPMUC9LzGhAb3DHHto=;
        b=JTawrn+rV5K3g8n7kPinScEgKrVbl1Gs9N9IOZO0TL65ajFQuSEH+aTdsIsZbaonq7
         CfwrpMBJ2El2PEtB/mVF0wyX5o+YuvXSKDd1WKpM94M8FgMB5B2QHNn8MELJEXJmWNAa
         nNUYxeOW8hF+3Bkq2ezn1di32spViDyt7BikhF6HmyZBLY4yIpJ7qO5KcD/xnrwuZs9u
         nnZufSPlOo4gYsDyILAiyQkmHxuR4kXT0aD3rJ/2eRHRZNqPuSFzGMVflFHAwwK+e2kW
         3nuZWgSwKHR8VBRJrWgD2tpfcfbQsqQL8Jo+74iJMBoirPqgNanUxn6Plfaf/OxaxnzX
         qfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316235; x=1794921035;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XQDfTOBLyQYKItk/7IbkqTdv3CPMUC9LzGhAb3DHHto=;
        b=jwaawhvORXAqFtu6sPpryVr5quMyEWF6ouW6ahIY7p5K42ESJcpG2Sl+tregW/L5Eh
         1P1HGbRGVU0eyCBqLcYsXyiLl2TplKR5GvwWLmhMhmmLkOQfjr1K7T6VwX7SZ90AdkHg
         iTSRBwFkhiVtIBnh1f4UwIsgn8RmAChj+SefsIOPrmPND/w4NLhrfCdZqiL3Y0zw0DNH
         CY0tw3tJuq5hAHGDBmZkQ5RHOBPtf7EsK+kdgK6J62DvloMU95u/f1M1Vi7kbPepiM85
         ns0hiK436YZxWnnWSbsoOheo/Dc10HZKbtJN+hUiOGyIw7M1LJadmSS3mtXjrYXbOUOt
         +zsA==
X-Forwarded-Encrypted: i=1; AL+hErHl6NkCb1uOrEzFNW9jwGBk/jrvpDcXtb9H7I+aJCuUwFtSpa5ALKpmDFKSyy4sz9Ug80w2vQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z/6GU0BwAYC966xHaLRy3SDs+a03Z3CtuMzmS4Jjna9qB5xO/fl
	Z/DM9WmLOiFofzAg+XwoR0i7ufSHr2+RQtxtkWquhTfwjJ14m27XthF3hqxOANkvTps=
X-Gm-Gg: AYBFou3vPC12b59t28NclPHSZ/NH1tiUZQxbgL8/bWby4ylqyTCe3MTus85YvlaYjoK
	2o3u+cg5ED4gBC3onw9M5kf3X4aCOCklaocnf10NZ9yufbTlXyG0CE0Ktpw+4/tuef4SXC4PjVU
	jHoZ/qMrQc20IvbB66LFslwbJ/xH09S4vb9GiV2wc+RY1LaPztaFUSVXjZxzotyNE2AbUsgXiMM
	EO+1dXzAsS62aAqhEVgqgt9Etl0ArqMiLVH9ypxKHrLf535RUbkt+4kYgqfpl9whNBuVx1CLS2T
	XH90Ux9Qv7gR66vJc5rcz047cErKvEsNa8ww99g+/nEodnKwqRIUocLSWn51dXyp28UHR9IkGVq
	y59NfRxom8WTlJKBk+JhPSGgzM86fITMFInxy60F3t6jQW5dMaB0OQBTfzaK86WUxbS/E10oQJi
	hpI/KaIOyWVIq9Xzk1hlBWeyfjPouVeDQrbZSTidJYIC+a+5+S19E9u+2u4NbL+eaic9QtZrCK1
	x9gEG+aFzyDqA3j24xDNamdSov+CtdA6c3dBt5Us+uulASXuXKW0M4sux49FrhXJ4WDbg8ExcOP
	q1g5HaXpL6s/HOhPoCGEH49TPhr8c3e8JNqvwxlKAkgewCNp2KRsiA8vb43FZTBKTIugwZXR759
	zFEPvZ0N/TxX9cVpDXs9c0diA3iu2XmQ=
X-Received: by 2002:a05:6122:222a:b0:5c7:fbb5:6ea0 with SMTP id 71dfb90a1353d-5ee0d068066mr932090e0c.4.1794316234604;
        Tue, 10 Nov 2026 05:10:34 -0800 (PST)
Received: from localhost (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c20081409sm1695863241.8.2026.11.10.05.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 05:10:33 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Nov 2026 08:10:32 -0500
Message-Id: <DMRK0PU0VCN3.15F59WLOQ05P4@soleen.com>
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>,
 <robin.murphy@arm.com>, <maz@kernel.org>, <will@kernel.org>, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>,
 <seanjc@google.com>, <jgg@nvidia.com>, <loganodell@google.com>,
 <arnd@arndb.de>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <oupton@kernel.org>, <alex@shazbot.org>,
 <gle.com@google.com>, <pbonzini@redhat.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, <kevin.tian@intel.com>, <joro@8bytes.org>
Cc: <kvmarm@lists.linux.dev>, <linux-pci@vger.kernel.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, <kexec@lists.infradead.org>, <kvm@vger.kernel.org>,
 <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <skhawaja@google.com>, <sagis@google.com>, <linux-arch@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 02/19] kho: block: Record the entry size in the block
 header
From: "Pasha Tatashin" <pasha.tatashin@soleen.com>
X-Mailer: aerc 0.22.0-39-g5d7784875be2
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-3-tarunsahu@google.com>
In-Reply-To: <20261110050202.529473-3-tarunsahu@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_051036_346344_44D25298 
X-CRM114-Status: GOOD (  40.59  )
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Nov 10, 2026 at 12:01 AM EST, Tarun Sahu wrote:
> Subsystems using the KHO Serialization Blocks framework currently do
> not record the serialized entry size in the block header. The entry size
> is only known to individual callers, which must track and store it in an
> owning serialized data structure. If a newer source kernel adds fields
> to an entry, the changed entry size breaks the stride when an older
> target kernel iterates over blocks.
>
> Add an entry_size field to struct kho_block_header_ser. On the outgoing
> side, record bs->entry_size into every block header during allocation.
> During restoration, derive the entry stride directly from the block
> header instead of relying on caller-supplied dimensions. The
> kho_block_set_init() interface remains unchanged. A zero entry size,
> or one that differs between blocks of a set, is rejected during
> restoration.
>
> This change modifies the serialized layout of struct kho_block_header_ser
> and shifts the offset of serialized entries within preserved blocks.
> Bump KHO_FDT_COMPATIBLE from kho-v4 to kho-v5 so that pre-v5 and post-v5
> kernels cleanly reject mismatched handover state during boot. Also
> update the stale compatible string example in the documentation.
>
> Suggested-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> ---
>  include/linux/kho/abi/block.h          | 10 ++++----
>  include/linux/kho/abi/kexec_handover.h |  6 ++---
>  kernel/liveupdate/kho_block.c          | 32 +++++++++++++++++++++++---
>  3 files changed, 38 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/kho/abi/block.h b/include/linux/kho/abi/block.=
h
> index 36bdbaf9b3b8..a40b0906c821 100644
> --- a/include/linux/kho/abi/block.h
> +++ b/include/linux/kho/abi/block.h
> @@ -40,9 +40,10 @@
> =20
>  /**
>   * struct kho_block_header_ser - Header for the serialized data block.
> - * @next:  Physical address of the next struct kho_block_header_ser.
> - * @count: The number of entries that immediately follow this header in =
the
> - *         memory block.
> + * @next:       Physical address of the next struct kho_block_header_ser=
.
> + * @count:      The number of entries that immediately follow this heade=
r in the
> + *              memory block.
> + * @entry_size: The size in bytes of each serialized entry in the block.
>   *
>   * This structure is located at the beginning of a block of physical mem=
ory
>   * preserved across a kexec. It provides the necessary metadata to inter=
pret
> @@ -51,9 +52,10 @@
>  struct kho_block_header_ser {
>  	u64 next;
>  	u64 count;
> +	u64 entry_size;
>  };
> =20
> -static_assert(sizeof(struct kho_block_header_ser) =3D=3D 16);
> +static_assert(sizeof(struct kho_block_header_ser) =3D=3D 24);
>  static_assert(!IS_ENABLED(CONFIG_64BIT) ||
>  	      __alignof__(struct kho_block_header_ser) =3D=3D 8);

The above change goes away once my comment on the previous patch=20
is addressed.

> =20
> diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/a=
bi/kexec_handover.h
> index 2f4fb9c63942..6f12f5037ea5 100644
> --- a/include/linux/kho/abi/kexec_handover.h
> +++ b/include/linux/kho/abi/kexec_handover.h
> @@ -41,7 +41,7 @@
>   *   restore the preserved data.::
>   *
>   *     / {
> - *         compatible =3D "kho-v3";
> + *         compatible =3D "kho-v5";
>   *
>   *         preserved-memory-map =3D <0x...>;
>   *
> @@ -62,7 +62,7 @@
>   *     };
>   *
>   *   Root KHO Node (/):
> - *     - compatible: "kho-v3"
> + *     - compatible: "kho-v5"

These are just examples, don't update them.

>   *
>   *       Identifies the overall KHO ABI version.
>   *
> @@ -90,7 +90,7 @@
>   */
> =20
>  /* The compatible string for the KHO FDT root node. */
> -#define KHO_FDT_COMPATIBLE "kho-v4"
> +#define KHO_FDT_COMPATIBLE "kho-v5"
> =20
>  /* The FDT property for the preserved memory map. */
>  #define KHO_FDT_MEMORY_MAP_PROP_NAME "preserved-memory-map"
> diff --git a/kernel/liveupdate/kho_block.c b/kernel/liveupdate/kho_block.=
c
> index 0d2a342ef422..9b148009085e 100644
> --- a/kernel/liveupdate/kho_block.c
> +++ b/kernel/liveupdate/kho_block.c
> @@ -16,6 +16,12 @@
>   * array of serialized entries. Multiple blocks are linked together via =
a
>   * physical pointer in the header, forming a linked list that can be eas=
ily
>   * traversed in both the current and the next kernel.
> + *
> + * Each block header also records the size of its entries. A newer kerne=
l may

"newer kernel" does not make sense in the documentation comment, as any=20
kernel can do that. I would suggest "outgoing kernel." By the way, in=20
this series you use the terms "source" and "destination" kernel, whereas=20
traditionally we have used "outgoing" and "incoming." While both=20
conventions work, it would be preferable to maintain consistency.

> + * append fields to an entry, so the kernel that writes a block and the =
kernel
> + * that reads it can use different entry sizes. The reader steps through=
 the
> + * entries with the recorded size, so every entry is found, and it does =
not read
> + * beyond the recorded size of an entry.
>   */
> =20
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> @@ -110,6 +116,8 @@ static int kho_block_set_grow_one(struct kho_block_se=
t *bs)
>  	if (IS_ERR(ser))
>  		return PTR_ERR(ser);
> =20
> +	ser->entry_size =3D bs->entry_size;
> +
>  	err =3D kho_block_add(bs, ser);
>  	if (err) {
>  		kho_block_free_ser(bs, ser);
> @@ -242,7 +250,8 @@ static bool kho_block_set_is_cyclic(struct kho_block_=
set *bs)
>   *
>   * Restores a serialized block set from a given physical address. The ca=
ller is
>   * responsible for ensuring that the block set @bs has been allocated an=
d
> - * initialized prior to calling this function.
> + * initialized prior to calling this function. The entry size and the nu=
mber
> + * of entries per block are taken from the restored block headers.
>   *
>   * Return: 0 on success, or a negative errno on failure.
>   */
> @@ -250,6 +259,7 @@ int kho_block_set_restore(struct kho_block_set *bs, u=
64 head_pa)
>  {
>  	struct kho_block_header_ser *ser;
>  	u64 next_pa =3D head_pa;
> +	u64 entry_size =3D 0;
>  	int err;
> =20
>  	/* Restored block sets use size from the previous kernel */
> @@ -264,8 +274,21 @@ int kho_block_set_restore(struct kho_block_set *bs, =
u64 head_pa)
>  	}
> =20
>  	while (next_pa) {
> +		u64 capacity;
> +
>  		ser =3D phys_to_virt(next_pa);
> -		if (!ser->count || ser->count > bs->count_per_block) {
> +		if (!ser->entry_size || (entry_size && ser->entry_size !=3D entry_size=
)) {
> +			pr_warn("Block contains invalid entry size: %llu\n",
> +				ser->entry_size);
> +			err =3D -EINVAL;
> +			goto err_destroy;
> +		}
> +		entry_size =3D ser->entry_size;
> +		bs->entry_size =3D entry_size;
> +		capacity =3D (KHO_BLOCK_SIZE - sizeof(*ser)) / bs->entry_size;
> +		bs->count_per_block =3D capacity;
> +
> +		if (!ser->count || ser->count > capacity) {
>  			pr_warn("Block contains invalid entry count: %llu\n",
>  				ser->count);
>  			err =3D -EINVAL;
> @@ -370,7 +393,10 @@ void *kho_block_set_it_reserve_entry(struct kho_bloc=
k_set_it *it)
>   * @it: The block iterator.
>   *
>   * Iterates through previously written entries during state deserializat=
ion,
> - * respecting the actual count stored in each block's header.
> + * respecting the actual count stored in each block's header. Entries ar=
e
> + * spaced by the entry size recorded by the kernel that wrote them, whic=
h can
> + * be smaller or larger than the caller's structure. Fields beyond that =
size
> + * are not present in the entry.
>   *
>   * Return: A pointer to the next serialized entry, or NULL if all serial=
ized
>   * entries have been read.





--=20
Pasha



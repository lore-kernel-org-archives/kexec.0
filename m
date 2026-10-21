Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26CD606A31A
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 17:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Mj9JXgKu;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=hEUiBpG0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=csULT7PmXNkTg9HaShgHK/UOyRj2pqW39WBnWQcueFE=; b=Mj9JXgKu4YoMS9AosSuDIVhaf3
	xTw2B5+z4l+mKkCB0uk4bpEqt4KYoGMHpyPAFyb/8LqF44DbR7zV7yNMnEyBxUO5PHao8cNbFBNkg
	ixRsTS7qJ6kCgAWkFyYyr4ysS4vgHYS5e7UW0Ef/Hv56VkOPq3WZwj4pPnpfPVTdY3agkRbGq4U6j
	1HvTghm4Kxx4U7icwrHb09Ywc+hSzAJRshzOuQUVVsbZJrzXS7hE/QYSfZMcx+tSnS+o4J+xvgdJV
	+vGp1mIRIm87R98C+r3pvozEpuqbLKSFraFf0Wq97L7fxkTJyMhDXIOWVBGE8z4AQvQ6se/Olvx6M
	8BtcxuAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJaHE-0000000CZc7-1IIz;
	Wed, 21 Oct 2026 17:39:00 +0000
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJaHA-0000000CZbI-2JtQ
	for kexec@lists.infradead.org;
	Wed, 21 Oct 2026 17:38:58 +0000
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-3a772ec8389so8157721fa.3
        for <kexec@lists.infradead.org>; Wed, 21 Oct 2026 10:38:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792604334; cv=none;
        d=google.com; s=arc-20260327;
        b=eAZ5FvBoPOh8VRHuhLeRWo3KKJa0ky0uPGNistmRQht1TkuqQF7IOCEmMpUgZ26wa6
         wjyjV362oZC8ops/SW5l34PDiDabvrRbMK3HuoVVPQ7TmF/Pwv4lB+bOFqqEKC20tlog
         UmhnQ2YfbR0Bdco5AJ7dQ2eTtOIwSVUZXy3AeBI7XP9aWSjYe+rS4TOPBOFYwhp19kUg
         XXuq9VxPPtkfcYrnIbWmvqeZe4owQZl8/EGvB6REVp2p2uPIJXArUGtTiCKgM1ABEOs2
         CXWEQ538JOeku1oD4Z/HoLS7JCUNMXgxVOvV+ZM6XHkV/a5qIPikTXZ2WxDJG/u+pO+5
         cK2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=csULT7PmXNkTg9HaShgHK/UOyRj2pqW39WBnWQcueFE=;
        fh=M4qM8dtVfRPcur9ptnIHdS2nk+0eKSh8u7vRBOwcdTY=;
        b=l+pxrREGr9HdnAaY9KqZnJbd4RCNVjvumcnlzxeBwVURGGRqz2iFnax9JYIskqA/LH
         O6A91snNA2TBi5iSmpSvFH/EpfwDC5gni/aei+vEjCtCVu7bvc1pA+054lSMPHXhTIRe
         8piIBcgJjagumssmcgk5QOZjEn70X60BX49ZV9Ibhl1dOWA7pecjhvuWD/LvLJRZ9QNq
         lvnxW3IPs9j6z7VaHZAYm76l3O2Z1p1VU6IzeO7bj2HSUp2DYTpm9JcY10uFhCMWKvvI
         DumVKj805DrAhxbRslEUGmp7PGrJh2s+cY7Bse+xlNeCwbslTbuz7Pn+oi7b0UkB2w4O
         Y61w==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792604334; x=1793209134; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=csULT7PmXNkTg9HaShgHK/UOyRj2pqW39WBnWQcueFE=;
        b=hEUiBpG0aQRKzO838JJp96QSAd8DgE+MwKVz4P8lGK5Qc9k0TRC2z6FtlP80gjFBKW
         6dc8CdJPz6Ym/le66RGHShV80kvf7dUn8r7xWPfYaXGfRLO6GRFQ/HUybPyGkKiKtLAq
         MadTUSTd+IbQpT77CVhTCELLhoaDAL/55gXyuhLjrgApW/rm9IpwaTdaV3faiZHKkmPE
         eSHDHTw/tOwfgTwpkjO25jelCJT6L0OkX54fWzmkOMEWWwxBNbxSQomL5/SR1cQTlfcz
         XN7LsjtBFzUyHQi9kAETdZK6APZi8di9MmCz4CtV7Mdiw81yfyUC6HVK8+r55AzlM4YH
         9Z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792604334; x=1793209134;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=csULT7PmXNkTg9HaShgHK/UOyRj2pqW39WBnWQcueFE=;
        b=bSa7v3xGeS7gi1emWAYmo/CWqzzmMA/gMCXn4PJp5/B60R3mAWs1a9aLjfemeX/g96
         GZCNY53SUpQAKwrWSLOJQxVJ+fmO4sHb9b18a/TQJhlkC3kj8F3jr48YbCa8JbxsiGmQ
         DXeXlHqmJolKfjEr8a7hySMRy/kM5H1YbNKJ795DvWA3Y6yJjJ8P0SETk2gSooIq6t9c
         +ED8no5hj+A3aLxORuwv7Ils1BeiN8CTYWWzvu4bNIoO2nP5Wfnc1tZxZ3WiNQChs9sB
         Hg/hpJLJ8A70KjSMB9xNVozUQ8WEAD+AdlxCiNzyQt6dRo6+tNR7Z3e5LQ3ARmFd9ZsP
         blmg==
X-Forwarded-Encrypted: i=1; AKwUvByE3el8GPBdKjIh3gGAhWsqIi0yISR+LQUcymPoNDaDzXoTC4iBPHGp8kFD+sBobnlUq8n/BA==@lists.infradead.org
X-Gm-Message-State: AFq9FYJ7TCPL/30tK7gdVE7+7OewnhAIDmFWR4x6NH3wjvqiKdiFy0aF
	v/axh0LMqoFvV5NQIQesGxGTP6QS7biU0gKuAVqplkiTfOdCBrK0yWYzc5qOvTTmr1FdfaP7yK1
	mQo+ULaC2ClJ5lqUsB6yRQnbtWxFYTZvgPlGn8/r9zQ==
X-Gm-Gg: AYBFou3YPXRFHwteSV4k9ThKsI+dbiEWCqUkUrRSnJWAkgJLHODqfcU+p5OyVnGcwwU
	VBPrGiEJR1an+koKPAkuZ0zz2brF4OL99WPLSkczzkJggrxMOoU/AidD4pfIryiHnV6Cl5ZdCzT
	FpoTYN/MFpo0r5DtdrEoqspZzdYvjyE/vxZCbEpWt82DCaWqTH40zYhELuvd0NtbFIeWEbVHl4q
	WECjbbsE+flEA/oxa+BtiX3G0ud87Qzy+qqnrDULFfuBDB3ArUKWSLr1QRA5t5C7u7x12Sx2Wug
	7EpYdmBFZwI9rKfqgY9ZibHEP+GOIOXQHs6vHw7K4NNEieRWwXyZEYx24TNcqhfBIw0lbQR9azF
	s94xADbA0MHiIvXkNXYHzbTiBi5AjupxRJ/ApjDjWZdtiBGjsOFfHA8jjhlc1Wxf5ftI=
X-Received: by 2002:a05:651c:4210:b0:3ab:473f:4340 with SMTP id
 38308e7fff4ca-3ac44229527mr7899791fa.25.1792604334224; Wed, 21 Oct 2026
 10:38:54 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-5-tarunsahu@google.com>
In-Reply-To: <20261021152527.375070-5-tarunsahu@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Oct 2026 13:38:17 -0400
X-Gm-Features: AclHuK9EmTvcDrSPqjt_gHIG_UhFcRBGzP6kEtdhbGsx9XevNkAWoOmg1utImw8
Message-ID: <CA+CK2bCWo7ixrNLKPvqETn3JSFwSNaB2UsPgy9RHVAhWroJURQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/4] mm: memfd_luo: Add the 2-bit pair feature header
To: Tarun Sahu <tarunsahu@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	David Matlack <dmatlack@google.com>, jgg@nvidia.com, robin.murphy@arm.com, 
	loganodell@google.com, oupton@kernel.org, kevin.tian@intel.com, 
	alex@shazbot.org, dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, 
	will@kernel.org, Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org, sagis@google.com, linux-mm@kvack.org, 
	kvmarm@lists.linux.dev, iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_103856_893811_C9E0E120 
X-CRM114-Status: GOOD (  33.67  )
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <tarunsahu@google.com> =
wrote:
>
> Embed the fixed-size 128-byte struct luo_feature_hdr at the start of
> struct memfd_luo_ser and define enum memfd_luo_feature
> (MEMFD_LUO_FEAT_CORE and MEMFD_LUO_FEAT_MAX) for memfd preservation.
>
> All current struct memfd_luo_ser fields (pos, size, seals, flags,
> nr_folios, folios) and MEMFD_LUO_ALL_SEALS belong to
> MEMFD_LUO_FEAT_CORE (LUO_FEAT_REQUIRED in memfd_luo_features). Future
> changes add new entries to enum memfd_luo_feature before
> MEMFD_LUO_FEAT_MAX and append any new fields to the end of struct
> memfd_luo_ser so existing field offsets never shift.
>
> Signed-off-by: Logan Odell <loganodell@google.com>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> ---
>  include/linux/kho/abi/memfd.h | 35 ++++++++++++++++++++++++++++++-----
>  mm/memfd_luo.c                | 14 ++++++++++++++
>  2 files changed, 44 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.=
h
> index 371ffd108a79..f0b5235a408d 100644
> --- a/include/linux/kho/abi/memfd.h
> +++ b/include/linux/kho/abi/memfd.h
> @@ -13,6 +13,7 @@
>
>  #include <linux/types.h>
>  #include <linux/kho/abi/kexec_handover.h>
> +#include <linux/kho/abi/luo.h>
>
>  /**
>   * DOC: memfd Live Update ABI
> @@ -21,11 +22,20 @@
>   * reboot using the LUO.
>   *
>   * The state is serialized into a packed structure `struct memfd_luo_ser=
`
> - * which is handed over to the next kernel via the KHO mechanism.
> + * which is handed over to the target kernel via the KHO mechanism.
>   *
> - * This interface is a contract. Any modification to the structure layou=
t
> - * constitutes a breaking change. Such changes require incrementing the
> - * version number in the MEMFD_LUO_FH_COMPATIBLE string.
> + * This interface is a contract. `struct memfd_luo_ser` starts with a fi=
xed
> + * 128-byte `struct luo_feature_hdr`. The relative order and offsets of
> + * fields must remain unchanged as features are added or retired: new fi=
elds
> + * are appended at the end of `struct memfd_luo_ser` under a new feature
> + * flag in `enum memfd_luo_feature` (before `MEMFD_LUO_FEAT_MAX`), and
> + * retired fields are kept in place so subsequent offsets never shift. I=
n
> + * the target kernel, fields of a `LUO_FEAT_REQUIRED` feature are guaran=
teed
> + * present once `luo_feature_hdr_validate()` succeeds, whereas fields of=
 a
> + * `LUO_FEAT_OPTIONAL` feature should be accessed only after checking
> + * `luo_feature_is_active()`. All current fields (`pos`, `size`, `seals`=
,
> + * `flags`, `nr_folios`, `folios`) and `MEMFD_LUO_ALL_SEALS` belong to
> + * `MEMFD_LUO_FEAT_CORE` (`LUO_FEAT_REQUIRED` in `memfd_luo_features`).
>   */
>
>  /**
> @@ -58,7 +68,7 @@ struct memfd_luo_folio_ser {
>
>  /*
>   * The set of seals this version supports preserving. If support for any=
 new
> - * seals is needed, add it here and bump version.
> + * seals is needed, gate them behind a new feature flag.
>   */
>  #define MEMFD_LUO_ALL_SEALS (F_SEAL_SEAL | \
>                              F_SEAL_SHRINK | \
> @@ -67,8 +77,22 @@ struct memfd_luo_folio_ser {
>                              F_SEAL_FUTURE_WRITE | \
>                              F_SEAL_EXEC)
>
> +/**
> + * enum memfd_luo_feature - Feature indices for &struct memfd_luo_ser.
> + * @MEMFD_LUO_FEAT_CORE: Core feature covering `pos`, `size`, `seals`, `=
flags`,
> + *                       `nr_folios`, `folios`, and %MEMFD_LUO_ALL_SEALS=
.
> + * @MEMFD_LUO_FEAT_MAX:  Number of defined &enum memfd_luo_feature featu=
res.
> + */
> +enum memfd_luo_feature {
> +       MEMFD_LUO_FEAT_CORE =3D 0,
> +       MEMFD_LUO_FEAT_MAX,
> +};
> +
> +static_assert((int)MEMFD_LUO_FEAT_MAX <=3D LUO_FEAT_MAX);
> +
>  /**
>   * struct memfd_luo_ser - Main serialization structure for a memfd.
> + * @features:  ABI feature and size header for memfd_luo_ser.
>   * @pos:       The file's current position (f_pos).
>   * @size:      The total size of the file in bytes (i_size).
>   * @seals:     The seals present on the memfd. The seals are uABI so it =
is safe
> @@ -79,6 +103,7 @@ struct memfd_luo_folio_ser {
>   *             struct memfd_luo_folio_ser.
>   */
>  struct memfd_luo_ser {
> +       struct luo_feature_hdr features;

I have not looked into this yet, but I would prefer to use some kind
of macro constructor for serialized structs. That way, they will
automatically include the header, making it easier to search the code
for what is actually preserved versus what exists only in this kernel.

So, I think something like this:
/* Base serialization header: 4 bytes total size, 4 bytes flags */
struct luo_ser_hdr {
    __u32 total_size;
    __u32 flags;
};

#define LUO_SER_INIT_HDR(obj, _flags) do {           \
    (obj)->hdr.total_size =3D sizeof(*(obj));          \
    (obj)->hdr.flags =3D (_flags);                     \
} while (0)

#define DECLARE_LUO_SER(name, expected_size, members)       \
    struct name {                                           \
        struct luo_ser_hdr hdr;                             \
        members                                             \
    };                                                      \
    static_assert(sizeof(struct name) =3D=3D (expected_size),   \
                  "LUO struct " #name " size mismatch!")

Usage:
/*
 * Header:  8 bytes (hdr: 4 bytes total_size + 4 bytes flags)
 * Payload: 8 (pos) + 8 (size) + 4 (seals) + 4 (_pad) =3D 24 bytes
 * Total:   32 bytes
 */
DECLARE_LUO_SER(memfd_luo_ser, 32,
    __u64 pos;
    __u64 size;
    __u32 seals;
    __u32 _pad;
);

struct memfd_luo_ser *ser;
...
LUO_SER_INIT_HDR(ser, 0);

Thanks,
Pasha

>         u64 pos;
>         u64 size;
>         u32 seals;
> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> index 64f8b8cb75bd..ea1f4c8cd259 100644
> --- a/mm/memfd_luo.c
> +++ b/mm/memfd_luo.c
> @@ -84,6 +84,10 @@
>
>  #include "internal.h"
>
> +static const u8 memfd_luo_features[MEMFD_LUO_FEAT_MAX] =3D {
> +       [MEMFD_LUO_FEAT_CORE] =3D LUO_FEAT_REQUIRED,
> +};
> +
>  static int memfd_luo_preserve_folios(struct file *file,
>                                      struct kho_vmalloc *kho_vmalloc,
>                                      struct memfd_luo_folio_ser **out_fol=
ios_ser,
> @@ -284,6 +288,8 @@ static int memfd_luo_preserve(struct liveupdate_file_=
op_args *args)
>                 goto err_free_ser;
>         }
>
> +       luo_feature_hdr_init(&ser->features, sizeof(*ser),
> +                            memfd_luo_features);
>         ser->pos =3D args->file->f_pos;
>         inode_size =3D i_size_read(inode);
>
> @@ -525,6 +531,14 @@ static int memfd_luo_retrieve(struct liveupdate_file=
_op_args *args)
>         if (!ser)
>                 return -EINVAL;
>
> +       err =3D luo_feature_hdr_validate(&ser->features, memfd_luo_featur=
es);
> +       if (err) {
> +               pr_err("memfd_luo_ser feature header validation failed (s=
ize=3D%llu, flags[0]=3D%#llx): %pe\n",
> +                      ser->features.size, ser->features.flags[0],
> +                      ERR_PTR(err));
> +               goto free_ser;
> +       }
> +
>         /* Make sure the file only has seals supported by this version. *=
/
>         if (ser->seals & ~MEMFD_LUO_ALL_SEALS) {
>                 err =3D -EOPNOTSUPP;
> --
> 2.56.0.212.g129ede20d9-goog
>


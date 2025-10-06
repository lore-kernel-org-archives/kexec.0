Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8D7CCA470
	for <kexec@archiver.kernel.org>; Mon,  6 Oct 2025 17:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ku0CTKpCW0+jCKseUl9YA3cobk32kED67HOsvkr/Nvw=; b=IjBBM0Tf3W47hneW/CF0Q86mbi
	jiKkfnEwDj2jhvH2oK0i1/0n1oDQBuS4c5b9jdNcEwZMNytjrfXIcedF9CETnBiOwbWQ6QJRlxX9r
	0TVbHAXsT9wp1vYjWgOcNobYzGdpry4yEFPcUIRE8T23MolYEf7wZZesKwrQM+fQcUKyfou3RyZ1L
	jo+cXn+mHCpOnxq6uoDCmlKcio9pUqKhOSouDr/AIpsWUQYhynO1adY2iizD98/9/I38cGvr/bRHc
	ULXGrOWXeNB+d/ziYzZ+vC1+4hDVZEkypiLXMpeuNrHLo6SKTtrn1hAN+qn6nNG4JUF6pZ4GXlL8q
	6jeHusIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5ozq-00000000UrS-3c40;
	Mon, 06 Oct 2025 17:27:38 +0000
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5ozo-00000000Uqt-13Hj
	for kexec@lists.infradead.org;
	Mon, 06 Oct 2025 17:27:37 +0000
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4da7a3d0402so57383291cf.0
        for <kexec@lists.infradead.org>; Mon, 06 Oct 2025 10:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759771655; x=1760376455; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ku0CTKpCW0+jCKseUl9YA3cobk32kED67HOsvkr/Nvw=;
        b=Dt8hDlRNg6k4A9mbYiac+FjoOhKqpwIp3zn9qJP9QNfA32EVNn1JwuBjl5T0FzQk2u
         2PsDVUprFz0UaZIUVwDu1KwqkhYKERszQojcVKqkEXQqYfDy+i2HObV05m2vb+SXF4wK
         a5mAKLAHQ36QgTLy6ahwTk0f0Ee7kQY6QoGdRwXamlzkmu+9C7Ek2TwA9kHCAb7RN/sC
         UntOr3kEGZ+27vHx9AkYxZFYY/NwSlQOL3F8B1LLGM7tUoxJhDNtmFTk32aeU7WYyhJl
         VmDq/AfO3MdJBGXT3GhT0voP6+ohGEhfVzkgFqas+b2eUQlCy0l1QPVBaqbGXavGRm4u
         MS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759771655; x=1760376455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ku0CTKpCW0+jCKseUl9YA3cobk32kED67HOsvkr/Nvw=;
        b=gdhpcq2boVWreWPKk9sTPdVNwPFK8Zrv2Q+hQBUFo8ly9NsGVhI/fLn0/oJXrr7Hcz
         QaUJKtg0drcshxCxtb1wlp/7VyRWVG6In6RYFJxJ4mMDvtCe1oSD9KZVJF8sYOqKV7PA
         fEnJTPNQiFbivqYqZfcbRrJEu+csnYQXyweYzoOAREZ+F+LCMf8GTyWZOvOLNIcH5/eZ
         vT0NY0mJczdh3yy6tH9b7QjvFNZaLfAW2fjSzGObZb/9N76dQ7XGj/oWj40OHTzBdomo
         uiH9LuFSrWLJD1MXYz3EJHINdwJnIQkJ/1LZ2r2NjI27W7YqtAj7uMnYYMjUiFmhopuA
         HIkg==
X-Forwarded-Encrypted: i=1; AJvYcCVXiPkOLbcbxdC24DCHWjezfFvKh9Jpm9uf2zbVTvstnT/8E5+08a7NsIsjWenG+RXtwTm/6g==@lists.infradead.org
X-Gm-Message-State: AOJu0YxEZHjd0/PC7V0sPAkA5JpEybWqEj9mJARbIyLbr/U185Hk3oLw
	nrxjKPr5A9P4LKjLmHfmbHwgMd4LcvlW2qhCXpKPqls/hOzMgR26NL0Dm+EihCgdcJbEqQHBNjn
	4jM73fYLFCpouPQubZ0he6Ouzw65k/fkqS3imdLUNMQ==
X-Gm-Gg: ASbGncuXQtlTVR69mT+sTMT2V/+FQAMJljojmlvnMMelzcD7QehowOAsf3NPilV4BFI
	bEJbPDCaLOGWS/JwIR+HODZsHofH62UeQP6iML6uoOUGja3Ut1HzMull90kh2d1PStJbxJ1AgLU
	/IiOnIacecNEQY7/LgKMw5ZEyt1jilYXmFeeTZVTwFwtnJA3kwwBQEnWHoLmoJHeUsk91vEDVS0
	6TU85/kExknZW8Ji2J/n0Q/X+ZvSNrmhvQD4qc=
X-Google-Smtp-Source: AGHT+IGjwaWmNcZg1BOGu3Lg22in3+tENKw0l6sBQmtPIPzfXbP/uKdYn+6Dbs6vJDK/UWx2hnc6bcJqDsmk/KFcfOE=
X-Received: by 2002:a05:622a:4a05:b0:4e4:d72d:69b2 with SMTP id
 d75a77b69052e-4e6de87d231mr5887871cf.24.1759771654434; Mon, 06 Oct 2025
 10:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20251001011941.1513050-1-jasonmiu@google.com> <20251001011941.1513050-2-jasonmiu@google.com>
 <20251006141444.GN3360665@nvidia.com>
In-Reply-To: <20251006141444.GN3360665@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 6 Oct 2025 13:26:57 -0400
X-Gm-Features: AS18NWDfvI9sQ2V-f9FenduGtjBMq7JKIMo0f5LFRGNvBcQXIH9FiriSpPm5yuU
Message-ID: <CA+CK2bBaQEVySFcNmyQnWayZ7K=z5FxU7wTyNtmO7ja7NNGo3Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] kho: Adopt KHO radix tree data structures
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jason Miu <jasonmiu@google.com>, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Changyuan Lyu <changyuanl@google.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251006_102736_328516_2B7AE8C9 
X-CRM114-Status: GOOD (  51.50  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, Oct 6, 2025 at 10:14=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Tue, Sep 30, 2025 at 06:19:39PM -0700, Jason Miu wrote:
> > @@ -29,7 +30,7 @@
> >  #include "kexec_internal.h"
> >
> >  #define KHO_FDT_COMPATIBLE "kho-v1"
>
> We don't bump this?
>
> > -#define PROP_PRESERVED_MEMORY_MAP "preserved-memory-map"
> > +#define PROP_PRESERVED_PAGE_RADIX_TREE "preserved-page-radix-tree"
> >  #define PROP_SUB_FDT "fdt"
>
> I'de really like to see all of these sorts of definitions in some
> structured ABI header not open coded all over the place..
>
> >  /*
> > + * The KHO radix tree tracks preserved memory pages. It is a hierarchi=
cal
> > + * structure that starts with a single root `kho_radix_tree`. This sin=
gle
> > + * tree stores pages of all orders.
> > + *
> > + * This is achieved by encoding the page's physical address and its or=
der into
> > + * a single `unsigned long` value. This encoded value is then used to =
traverse
> > + * the tree.
> > + *
> > + * The tree hierarchy is shown below:
> > + *
> > + * kho_radix_tree_root
> > + * +-------------------+
> > + * |     Level 6       | (struct kho_radix_tree)
> > + * +-------------------+
> > + *   |
> > + *   v
> > + * +-------------------+
> > + * |     Level 5       | (struct kho_radix_tree)
> > + * +-------------------+
> > + *   |
> > + *   | ... (intermediate levels)
> > + *   |
> > + *   v
> > + * +-------------------+
> > + * |      Level 1      | (struct kho_bitmap_table)
> > + * +-------------------+
> > + *
> > + * The following diagram illustrates how the encoded value is split in=
to
> > + * indices for the tree levels:
> >   *
> > + *      63:60   59:51    50:42    41:33    32:24    23:15         14:0
> > + * +---------+--------+--------+--------+--------+--------+-----------=
------+
> > + * |    0    |  Lv 6  |  Lv 5  |  Lv 4  |  Lv 3  |  Lv 2  |  Lv 1 (bit=
map)  |
> > + * +---------+--------+--------+--------+--------+--------+-----------=
------+
> >   *
> > + * Each `kho_radix_tree` (Levels 2-6) and `kho_bitmap_table` (Level 1)=
 is
> > + * PAGE_SIZE. Each entry in a `kho_radix_tree` is a descriptor (a phys=
ical
> > + * address) pointing to the next level node. For Level 2 `kho_radix_tr=
ee`
> > + * nodes, these descriptors point to a `kho_bitmap_table`. The final
> > + * `kho_bitmap_table` is a bitmap where each set bit represents a sing=
le
> > + * preserved page.
>
> Maybe a note that this is example is for PAGE_SIZE=3D4k.
>
>
> >   */
> > +struct kho_radix_tree {
> > +     unsigned long table[PAGE_SIZE / sizeof(unsigned long)];
>
> This should be phys_addr_t.

Maybe u64 ? This is a preserved data, I would specify the size, and
not care about 32-bit arches. Also, if we ever have to support larger
physical spaces, this radix tree version would need to be bumped
anyway.

>
> > +};
>
> You dropped the macros so now we don't know these are actually
> pointers to 'struct kho_radix_tree'
>
> > +/*
> > + * `kho_radix_tree_root` points to a page thats serves as the root of =
the
> > + * KHO radix tree. This page is allocated during KHO module initializa=
tion.
> > + * Its physical address is written to the FDT and passed to the next k=
ernel
> > + * during kexec.
> > + */
> > +static struct kho_radix_tree *kho_radix_tree_root;
> > +static DECLARE_RWSEM(kho_radix_tree_root_sem);
> > +
> > +static int kho_radix_tree_max_depth(void)
> > +{
> > +     int page_offset_bit_num =3D BITS_PER_LONG - PAGE_SHIFT;
> > +     int order_bit_num =3D ilog2(__roundup_pow_of_two(page_offset_bit_=
num));
> > +     int bitmap_bit_num =3D PAGE_SHIFT + ilog2(BITS_PER_BYTE);
> > +     int table_bit_num =3D ilog2(PAGE_SIZE / sizeof(unsigned long));
> > +     int table_level_num =3D DIV_ROUND_UP(page_offset_bit_num -
> > +                                        bitmap_bit_num + order_bit_num=
,
> > +                                        table_bit_num);
>
> All should be unsigned int. Below I suggest to put it in an enum and
> use different names.. And since the function is constant it can just
> be an enum TOP_LEVEL too.
>
> > +/*
> > + * The KHO radix tree tracks preserved pages by encoding a page's phys=
ical
> > + * address (pa) and its order into a single unsigned long value. This =
value
> > + * is then used to traverse the tree. The encoded value is composed of=
 two
> > + * parts: the 'order bits' in the upper part and the 'page offset' in =
the
> > + * lower part.
> > + *
> > + *   <-- Higher Bits ------------------------------------ Lower Bits -=
->
> > + *  +--------------------------+--------------------------------------=
---+
> > + *  |        Order Bits        |               Page Offset            =
   |
> > + *  +--------------------------+--------------------------------------=
---+
> > + *  | ... 0 0 1 0 0 ...        | pa >> (PAGE_SHIFT + order)           =
   |
> > + *  +--------------------------+--------------------------------------=
---+
> > + *            ^
> > + *            |
> > + *  This single '1' bit's position
> > + *  uniquely identifies the 'order'.
> > + *
> > + *
> > + * Page Offset:
> > + * The 'page offset' is the physical address normalized for its order.=
 It
> > + * effectively represents the page offset for the given order.
> > + *
> > + * Order Bits:
> > + * The 'order bits' encode the page order by setting a single bit at a
> > + * specific position. The position of this bit itself represents the o=
rder.
> > + *
> > + * For instance, on a 64-bit system with 4KB pages (PAGE_SHIFT =3D 12)=
, the
> > + * maximum range for a page offset (for order 0) is 52 bits (64 - 12).=
 This
> > + * offset occupies bits [0-51]. For order 0, the order bit is set at
> > + * position 52.
> > + *
> > + * As the order increases, the number of bits required for the 'page o=
ffset'
> > + * decreases. For example, order 1 requires one less bit for its page
> > + * offset. This allows its order bit to be set at position 51 without
> > + * conflicting with the page offset bits.
> > + *
> > + * This scheme ensures that the single order bit is always in a higher
> > + * position than any bit used by the page offset for that same order,
> > + * preventing collisions.
>
> Should explain why it is like this:
>
> This scheme allows storing all the multi-order page sizes in a single
> 6 level table with a good sharing of lower tables levels for 0 top
> address bits. A single algorithm can efficiently process everything.
>
> > + */
> > +static unsigned long kho_radix_encode(unsigned long pa, unsigned int o=
rder)
>
> pa is phys_addr_t in the kernel, never unsigned long.
>
> If you want to make it all dynamic then this should be phys_addr_t
>
> > +{
> > +     unsigned long h =3D 1UL << (BITS_PER_LONG - PAGE_SHIFT - order);
>
> And this BITS_PER_LONG is confused, it is BITS_PER_PHYS_ADDR_T which
> may not exist.
>
> Use an enum ORDER_0_LG2 maybe
>
> > +     unsigned long l =3D pa >> (PAGE_SHIFT + order);
> >
> > +     return h | l;
> > +}
> >
> > +static unsigned long kho_radix_decode(unsigned long encoded, unsigned =
int *order)
>
> Returns phys_addr_t
>
> >  {
> > -     void *elm, *res;
> > +     unsigned long order_bit =3D fls64(encoded);
>
> unsigned int
>
> > +     unsigned long pa;
>
> phys_addr_t
>
> > +     *order =3D BITS_PER_LONG - PAGE_SHIFT - order_bit + 1;
>
> ORDER_0_LG2
>
> > +     pa =3D encoded << (PAGE_SHIFT + *order);
>
> I'd add a comment that the shift always discards order.
>
> > +     return pa;
> > +}
> >
> > +static unsigned long kho_radix_get_index(unsigned long encoded, int le=
vel)
>
> unsigned int level
>
> > +{
> > +     int table_bit_num =3D ilog2(PAGE_SIZE / sizeof(unsigned long));
> > +     int bitmap_bit_num =3D PAGE_SHIFT + ilog2(BITS_PER_BYTE);
>
> Stick all the constants that kho_radix_tree_max_depth() are computing
> in an enum instead of recomputing them..
>
> > +     unsigned long mask;
> > +     int s;
>
> unsigned for all of these.
>
> > +
> > +     if (level =3D=3D 1) {
>
> I think the math is easier if level 0 =3D=3D bitmap..
>
> > +             s =3D 0;
> > +             mask =3D (1UL << bitmap_bit_num) - 1;
> > +     } else {
> > +             s =3D ((level - 2) * table_bit_num) + bitmap_bit_num;
>
> eg here you are doing level-2 which is a bit weird only because of the
> arbitary choice to make level=3D1 be the bitmap.
>
> I'd also use some different names
>
> table_bit_num =3D=3D TABLE_SIZE_LG2
> BITMAP_BIT_NUM =3D BITMAP_SIZE_LG2
>
> Log2 designates the value is 1<<LG2
>
> > +             mask =3D (1UL << table_bit_num) - 1;
> >       }
> >
> > -     return elm;
> > +     return (encoded >> s) & mask;
>
> It is just:
>
> return encoded % (1 << BITMAP_SIZE_LG2);
> return (encoded >> s) % (1 << TABLE_SIZE_LG2);
>
> The compiler is smart enough to choose bit logic if that is the
> fastest option and the above is more readable.
>
> > +static int kho_radix_set_bitmap(struct kho_bitmap_table *bit_tlb, unsi=
gned long offset)
> >  {
> > +     if (!bit_tlb ||
> > +         offset >=3D PAGE_SIZE * BITS_PER_BYTE)
> > +             return -EINVAL;
> >
> > +     set_bit(offset, bit_tlb->bitmaps);
>
> set_bit is an atomic, you want __set_bit()
>
> > +     return 0;
> > +}
> >
> > +static int kho_radix_preserve_page(unsigned long pa, unsigned int orde=
r)
>
> phys_addr_t
>
> > +{
> > +     unsigned long encoded =3D kho_radix_encode(pa, order);
> > +     int num_tree_level =3D kho_radix_tree_max_depth();
>
> kho_radix_tree_max_depth() is constant, stick it in an enum with the
> rest of them.
>
> > +     struct kho_radix_tree *current_tree, *new_tree;
> > +     struct kho_bitmap_table *bitmap_table;
> > +     int err =3D 0;
> > +     int i, idx;
>
> various unsigned int.
>
> >
> > +     down_write(&kho_radix_tree_root_sem);
> >
> > +     current_tree =3D kho_radix_tree_root;
> >
> > +     /* Go from high levels to low levels */
> > +     for (i =3D num_tree_level; i >=3D 1; i--) {
> > +             idx =3D kho_radix_get_index(encoded, i);
> > +
> > +             if (i =3D=3D 1) {
> > +                     bitmap_table =3D (struct kho_bitmap_table *)curre=
nt_tree;
> > +                     err =3D kho_radix_set_bitmap(bitmap_table, idx);
> > +                     goto out;
> > +             }
> > +
> > +             if (!current_tree->table[idx]) {
> > +                     new_tree =3D kho_alloc_radix_tree();
> > +                     if (!new_tree) {
> > +                             err =3D -ENOMEM;
> > +                             goto out;
> > +                     }
> > +
> > +                     current_tree->table[idx] =3D
> > +                             (unsigned long)virt_to_phys(new_tree);
>
> current_tree =3D new_tree
> > +             }
>
> else
>
> > +
> > +             current_tree =3D (struct kho_radix_tree *)
> > +                     phys_to_virt(current_tree->table[idx]);
> >       }
> > +
> > +out:
> > +     up_write(&kho_radix_tree_root_sem);
> > +     return err;
> >  }
> >
> > +static int kho_radix_walk_bitmaps(struct kho_bitmap_table *bit_tlb,
> > +                               unsigned long offset,
>
> phys_addr_t
>
> > +                               kho_radix_tree_walk_callback_t cb)
> >  {
> > +     unsigned long encoded =3D offset << (PAGE_SHIFT + ilog2(BITS_PER_=
BYTE));
> > +     unsigned long *bitmap =3D (unsigned long *)bit_tlb;
> > +     int err =3D 0;
> > +     int i;
> >
> > +     for_each_set_bit(i, bitmap, PAGE_SIZE * BITS_PER_BYTE) {
> > +             err =3D cb(encoded | i);
> > +             if (err)
> > +                     return err;
> > +     }
> >
> > +     return 0;
> > +}
> >
> > +static int kho_radix_walk_trees(struct kho_radix_tree *root, int level=
,
>
> unsigned int
>
> > +                             unsigned long offset,
>
> phys_addr_t.  I would call this start not offset..
>
> > +                             kho_radix_tree_walk_callback_t cb)
> > +{
> > +     int level_shift =3D ilog2(PAGE_SIZE / sizeof(unsigned long));
> > +     struct kho_radix_tree *next_tree;
> > +     unsigned long encoded, i;
> > +     int err =3D 0;
> >
> > +     if (level =3D=3D 1) {
> > +             encoded =3D offset;
> > +             return kho_radix_walk_bitmaps((struct kho_bitmap_table *)=
root,
> > +                                           encoded, cb);
>
> Better to do this in the caller  a few lines below
>
> > +     }
>
> >
> > +     for (i =3D 0; i < PAGE_SIZE / sizeof(unsigned long); i++) {
> > +             if (root->table[i]) {
> > +                     encoded =3D offset << level_shift | i;
>
> This doesn't seem right..
>
> The argument to the walker should be the starting encoded of the table
> it is about to walk.
>
> Since everything always starts at 0 it should always be
>   start | (i << level_shift)
>
> ?
>
> > +                     next_tree =3D (struct kho_radix_tree *)
> > +                             phys_to_virt(root->table[i]);
> > +                     err =3D kho_radix_walk_trees(next_tree, level - 1=
, encoded, cb);
> >                       if (err)
> >                               return err;
> >               }
> >       }
> >
> > +     return 0;
> > +}
> >
> > +static int kho_memblock_reserve(phys_addr_t pa, int order)
> > +{
> > +     int sz =3D 1 << (order + PAGE_SHIFT);
> > +     struct page *page =3D phys_to_page(pa);
> > +
> > +     memblock_reserve(pa, sz);
> > +     memblock_reserved_mark_noinit(pa, sz);
> > +     page->private =3D order;
> >
> >       return 0;
> >  }
> >
> > +static int kho_radix_walk_trees_callback(unsigned long encoded)
> > +{
> > +     unsigned int order;
> > +     unsigned long pa;
> > +
> > +     pa =3D kho_radix_decode(encoded, &order);
> > +
> > +     return kho_memblock_reserve(pa, order);
> > +}
> > +
> > +struct kho_serialization {
> > +     struct page *fdt;
> > +     struct list_head fdt_list;
> > +     struct dentry *sub_fdt_dir;
> > +};
> > +
> > +static int __kho_preserve_order(unsigned long pfn, unsigned int order)
> > +{
> > +     unsigned long pa =3D PFN_PHYS(pfn);
>
> phys_addr_t
>
> Jason


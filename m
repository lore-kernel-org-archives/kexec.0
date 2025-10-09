Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D84BCCA470
	for <kexec@archiver.kernel.org>; Thu,  9 Oct 2025 02:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AOYj62ptF6atgMYt5r0y+73WXkLSYqfPTH3G+5RzDpE=; b=HcN92smHMA5/X0qg7pBdJ4p8qE
	lLSagTZ2PLc8C6S6CQQMNQwhYuoFb3qcDYaCWf7iFS3bGI2JGLDRViBYTYXvvv9Ed4D/UnyvCVg2U
	ad+xBOO+Mlxft5zyQTBRCCOuR/fAanJejZW/WCB1Mmm2u2xgw4R6X0rh0yMDirXzqAJb24KCnXzm7
	Sq1rbX2uRHbWDjKYQvS+0AvZYKLIMNXhGvy5YeyQ9uFfaJdLOhbPpPujpjvh9nSjuxR3eXFFBmXWs
	HyG/tf+tKMMjl3h7fOb/ihp0MwjbWesvStl0AurEkYw9BvESjnJXI5MLLeNcck6ymfE9rPmtA3gH0
	oZQSCcHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6g48-000000051zL-0DhV;
	Thu, 09 Oct 2025 02:07:36 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6g44-000000051yx-2i76
	for kexec@lists.infradead.org;
	Thu, 09 Oct 2025 02:07:33 +0000
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-46e504975dbso2473455e9.1
        for <kexec@lists.infradead.org>; Wed, 08 Oct 2025 19:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759975650; x=1760580450; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOYj62ptF6atgMYt5r0y+73WXkLSYqfPTH3G+5RzDpE=;
        b=WTHPWIdBfaQ0VjYzbeELhQVze1lYj4HXSsSkU3aO+SoTvD97IF89TfXhWptpaCDWI2
         W1+cfLDxgxpTVGf54dVI/fgDaffPA0djaONGQEIL8lldB5B7A0FTpLtBTYPHrOs/C9WD
         JeNIz6YSRpnYW+1TcT1jlZDZU0MBlyyETPJawOUg5UgmKS0XM08HXj0Ny1d2XCxGXSAM
         hoHkebnYNWeW1FHz1lgmsndkHB/H2lw3quzFXMb3mtUaBrWPU8Wtpez36d858/Z/7QoQ
         iIcF+uHk0WxqmdZw84++baFQUh4Dx5fHU/NSlt/9u667HJTrYMVhy0NE0Czazl9QIjZZ
         23sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759975650; x=1760580450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AOYj62ptF6atgMYt5r0y+73WXkLSYqfPTH3G+5RzDpE=;
        b=Za0Og6Sa3klpkBZ+w+RIFBaB8M5vGrdu4tCl1iVpumKCy6uCQON6Ms9vGtAvWYY3Q3
         VXqrI5T13orp1MRWbmtn4H+lrI8b6EqiGaim6gJ4W3FO56Uso1qcn8OYVj5M5i8ufVM1
         n66d1F1C84WtkLZfmUnchOq2JvkZmsX/lB+PaI3BUWXZUR3cyKP6aYY/LnSDn7n7OMXw
         yoAAvdlCNVuYA+QjGGrEmmfwjjjC8x5Sy2NBU1q7CV7gGvI2XzSwCt0Qo0U/oTc1rwmV
         lwujZzHDYzqGZT2UlkAE+9C05GpTDcQ1L/uda4DPaAmbYDa6UsysS4+0UAFn0oSlebpp
         mopw==
X-Forwarded-Encrypted: i=1; AJvYcCWRPTqrIQ9VDQjswyqUwQBoNCo2BUa7rUwwr/1A32LkmqLKJtmgQx7C9KWMNIKavHjEGMWSjQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzog/XljZltZr3LbVHlxn2x3ls1XA54gxCnsN2S/GBN9IuaBzkR
	QPDlFft/lDWXd1los037ngcWIZnD9p9iCoJpM4cj0A1SOCld27890oldBlaARC1QugENGPLAFkX
	M8zR+8TyI+GuCK6cE0ewoo1zagX+0SRM17JzAsGbR
X-Gm-Gg: ASbGncuHoApLvPECk5IdtloywSSZnpDkjMyqAOpspdeJjtBoMmNLehP8z6COrygzS7t
	KsWptTsFQzyxtaQ5N06HxdzuBHp6GMTghS/LeSNtsDHGZ8nYx00+z2kpO3IDOB1DYsSKFkkeY7b
	vzDOMmktqCnEWKasPX7S3fYq8sGQEqDMzBZqc08Oe5AaLim6QRXWDuxPFr34qdODgG+YDcQX3FM
	jXiWbdkDPFNpzyyKjaahQex/10rUJb+xnF7xie36s/evqnYyzSTcY8vwWxGPJsmfE09c8IaGwSx
	V6A=
X-Google-Smtp-Source: AGHT+IHFGBlwkyomkdGP+02MpVf0OmgYgkGJzmO0wXhaXnPevK+aEz3O3W5DnuNfHGv90uQYvqNSpuGSu7q/Lmv5aj8=
X-Received: by 2002:a05:6000:4202:b0:425:7346:d1b6 with SMTP id
 ffacd0b85a97d-42667177b78mr3443459f8f.17.1759975649815; Wed, 08 Oct 2025
 19:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20251001011941.1513050-1-jasonmiu@google.com> <20251001011941.1513050-2-jasonmiu@google.com>
 <20251006141444.GN3360665@nvidia.com>
In-Reply-To: <20251006141444.GN3360665@nvidia.com>
From: Jason Miu <jasonmiu@google.com>
Date: Wed, 8 Oct 2025 19:07:18 -0700
X-Gm-Features: AS18NWB4PW66azTKpAtdJovUwEfqAjBAxqz9kEyCAdzq27GwUtBpfhjUIx6ym0g
Message-ID: <CAHN2nPKjg6=0QTcSoptxvQW9MpP0YwGUTx_gQDBxgCtSzxY5Pg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] kho: Adopt KHO radix tree data structures
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251008_190732_784503_640CE764 
X-CRM114-Status: GOOD (  48.22  )
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

Hi Jason,

Thank you very much for your feedback again.

On Mon, Oct 6, 2025 at 7:14=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
> >  #define KHO_FDT_COMPATIBLE "kho-v1"
>
> We don't bump this?
Will do. Will be "kho-v2".

>
> > -#define PROP_PRESERVED_MEMORY_MAP "preserved-memory-map"
> > +#define PROP_PRESERVED_PAGE_RADIX_TREE "preserved-page-radix-tree"
> >  #define PROP_SUB_FDT "fdt"
>
> I'de really like to see all of these sorts of definitions in some
> structured ABI header not open coded all over the place..

Do you think `include/linux/kexec_handover.h` is the appropriate
place, or would you prefer a new, dedicated ABI header (e.g., in
`include/uapi/linux/`) for all KHO-related FDT constants?


>
> >   */
> > +struct kho_radix_tree {
> > +     unsigned long table[PAGE_SIZE / sizeof(unsigned long)];
>
> This should be phys_addr_t.
>
> > +};
>
> You dropped the macros so now we don't know these are actually
> pointers to 'struct kho_radix_tree'
>

Agreed. Will change `u64` according to Pasha's comment. And we use
explicit casts like `(u64)virt_to_phys(new_tree)` and `(struct
kho_radix_tree *)phys_to_virt(table_entry)` in the current series. I
believe this, along with the `u64` type, makes it clear that the table
stores physical addresses.


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

Yes I did think of returning a const for `kho_radix_tree_max_depth()`.
I think using enums is a better idea and I can place all above values
as enums.


> > + */
> > +static unsigned long kho_radix_encode(unsigned long pa, unsigned int o=
rder)
>
> pa is phys_addr_t in the kernel, never unsigned long.
>
> If you want to make it all dynamic then this should be phys_addr_t

Should this also be `u64`, or we stay with `phys_addr_t` for all page
addresses?

>
> > +{
> > +     unsigned long h =3D 1UL << (BITS_PER_LONG - PAGE_SHIFT - order);
>
> And this BITS_PER_LONG is confused, it is BITS_PER_PHYS_ADDR_T which
> may not exist.
>
> Use an enum ORDER_0_LG2 maybe

I prefer `KHO_RADIX_ORDER_0_BIT_POS` (defined as `BITS_PER_LONG -
PAGE_SHIFT`) over `ORDER_0_LG2`, as I think the latter is a bit hard
to understand, what do you think? This constant, along with others,
will be placed in the enum.

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

Good point on the level numbering, we'll switch to 0-based where level
0 is the bitmap. The modulo operations you suggested play nicely with
the 0-based numbering too, thanks. Will also update the names and put
them in enum.
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

But the caller is in a different tree level? Should we only walk the
bitmaps at the lowest level?

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

You're right that this line might not be immediately intuitive. The
var `level_shift` (which is constant value 9 here) is applied to the
*accumulated* `offset` from the parent level. Let's consider an
example of a preserved page at physical address `0x1000`, which
encodes to `0x10000000000001` (bit 52 is set for order 0, bit 0 is set
for page 1).

If we were to use `start | (i << level_shift)` where `level_shift` is
a constant 9, and `start` is the value from the parent call:
  - At Level 6, `start` is `0`. `i` is 2 as bit 51:59 =3D 2. Result: `0
| (2 << 9) =3D 0x400`. This is passed to Level 5.
  - At Level 5, `start` is `0x400`, `i` is 0 as bit 50:42 =3D 0. Result:
`0x400 | (0 << 9) =3D 0x400`. This is passed to Level 4.
  - At Level 4, `start` is `0x400`, `i` is 0 as bit 33:41 =3D 0. Result:
`0x400 | (0 << 9) =3D 0x400`. And so on.

As you can see, the encoded value is not correctly reconstructed. This
will work if the `level_shift` represents the total shift from the LSB
for each specific level, but it is not the case here.

I will, however, add a detailed comment to `kho_radix_walk_trees` to
clarify this logic. I also agree to change the name of `offset` to
make it more clearer, how about `base_encoded`, or do you still prefer
`start`?

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

Will do the update in the next patch version. Thanks again.

--
Jason Miu


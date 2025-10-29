Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B178CCF9EA
	for <kexec@archiver.kernel.org>; Wed, 29 Oct 2025 01:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FkMWjO1rSdAnohkJyNyWXb5OhMJ5uqLxrhrL1OkZrHQ=; b=0bI1koutU3yOHCUy+dL+M8KaaY
	n4JJN9idWVfkB7kRie38tg9vMtA7LY6RqsCdir3LRXuBJP0iEO8fHLOD9j78qTadO+eBj5LFJzgSm
	E9hnMoVCuwdAgR2BKQmi0wN3jXY2XBYcDcy6AMN2/J6Chs5wGRUIw69rD33GJbpSdldbXfXGE6J2k
	+sIELI8a8Uw5D5ahxreHQSR2wSN7g8E7ebqIBIm2W3PaHT7Ahbu+iC5DpYcXQPhTeCjHb6YhXAJtz
	iU1iv9n6SxTS/CgBjbAep1DZvy7vhak8WQGGrAADVpyLUaun2SPC/ykZ+lFCetMhn5WETT8pBOJsu
	o3Jfeh2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDuz5-0000000GvKY-2g9s;
	Wed, 29 Oct 2025 01:28:19 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDuz2-0000000GvJm-44yq
	for kexec@lists.infradead.org;
	Wed, 29 Oct 2025 01:28:18 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so66178715e9.1
        for <kexec@lists.infradead.org>; Tue, 28 Oct 2025 18:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761701294; x=1762306094; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkMWjO1rSdAnohkJyNyWXb5OhMJ5uqLxrhrL1OkZrHQ=;
        b=R8L6yCpFM7rFVfO5vsvIfWfCF2Zy2DeOdLxlryCu6ECOeaYp2VR1/lJpfqojgaWiXd
         sy+QtBXBPqL9PmvkHwaDQzfYYOvEbi87noXfg1XL7tvIDgVCUuIhrdOZj2fdYQCh85qK
         al9/BP10vg8+fI/H/iEiGxVgY4bMtQm/+d9KH9jTqthUXwLzq0H7QZXFL2jIwnDhWxSH
         MbHe0DI3KwvmaJnLJNqlcFo1n11ctfQLgUxcxiKLP/+sXF56p09QKwGPADXSqLFjdUvI
         lZ6SafknFZDMcpTmFkTsZk4l9pz24rP7YPH/ODOzb5lQ5MOdUp1QgLCwOlwCJGANifve
         pXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761701294; x=1762306094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkMWjO1rSdAnohkJyNyWXb5OhMJ5uqLxrhrL1OkZrHQ=;
        b=avYHruxBHBbSXPm4vrFxikW96+Lykv57dDjiaHTNNGHBSeO25CJ/sFMZfR5NTdGU/J
         g7uQh0+a9UBqRs0ReVhTeji0ODuafaCzvxN0s9iFplNzwSZjmtjs+jqh8fFgGIYsja+8
         z7wJTo9MKUnvrDajx4W0VGCmcyV7Yy9+9WMpMsgGwUBqKFtyN6J0JFkffjqWbN+BdZDB
         40VBV9S5NkT6KpHNjBFv1mtBWNEbxtqHhs2ms9eG05kLojRfd2qSJsVm2SK7k5KIoxvj
         bnDk5P5rdeIx7OuRmO82L1V5hdQ8+j1JSiUe6/+itHHFLjAyfBSA/xlWnw5aBVVJgHkV
         /k0w==
X-Forwarded-Encrypted: i=1; AJvYcCW6MOXxvKJQBV0Ene0U2IHRUObU4IhPhpJFXqLYHs7bFZjA5TRuTYRi5zdwhPJCHfYdgQS0LQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwrqK1rBbyemLFbcCzO0YxJ7SVPYA0H8GCFP7R34lks4lpMICzw
	wjzhE3+XnL0Y09qoxjFGJfMb/x7uSmfErDsJVV1lt0NBZpvWbGPEYI0y0Wy/xLW5LMV7Y7ZMzrG
	ZzHu+LHLIS7q2ZE/BvKMi1llc3OW6S/lwn006kkVx
X-Gm-Gg: ASbGncs960dJsiLgDJN1J0csrb33sotH7NGcFf3gsQW+D3ZeHCEwR5bkqh9O68g7U+F
	AkhpYmPIpJyeeRPrH0bZSLvUXKF/2uZ7exCKlknWfTHd3dj6PpA3l2f7s34ysrwZQZAgQYjxFgO
	W2nk+mreh9O0PhQABXICxF7XUK+xM7VOAZ1L0iHcF3db0O1uTt7hLLKk9A1ARo06gwfLOhoYbQF
	jpoByhgfoArcNJwtF8Dnm4rXwiay1COXBbGzkgxGUGSTPmBe/M5+gC3WtaWGLPo2HKAZMaP7HWz
	YytgkkF14ETy48A=
X-Google-Smtp-Source: AGHT+IG3KRiPIoob60XGXfb5m+5xbP/GP4YmXgJstFq9lCOwlcC3zoZDZB5x16vG8VyFsQPcmth6oAyMlVZsee0e+BM=
X-Received: by 2002:a05:600c:6384:b0:475:e007:baf2 with SMTP id
 5b1f17b1804b1-4771e1f5a1fmr8930625e9.41.1761701294081; Tue, 28 Oct 2025
 18:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20251020100306.2709352-1-jasonmiu@google.com> <20251020100306.2709352-2-jasonmiu@google.com>
 <20251023174317.GO262900@nvidia.com>
In-Reply-To: <20251023174317.GO262900@nvidia.com>
From: Jason Miu <jasonmiu@google.com>
Date: Tue, 28 Oct 2025 18:28:02 -0700
X-Gm-Features: AWmQ_blKKmsXCeIJmd0P-TrVuYl0Tfsj5kSCFLMW2X0j-f70Ldi62zWKU78x_VA
Message-ID: <CAHN2nPKbxM5Bc9SDHHyvHbUPvsatMa6W59tXuVwfytxF7v+DRg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] kho: Adopt KHO radix tree data structures
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
X-CRM114-CacheID: sfid-20251028_182817_090645_3F56DACB 
X-CRM114-Status: GOOD (  42.66  )
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

On Thu, Oct 23, 2025 at 10:43=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
>
> On Mon, Oct 20, 2025 at 03:03:04AM -0700, Jason Miu wrote:
> > - * Keep track of memory that is to be preserved across KHO.
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
> > + * |     Level 5       | (struct kho_radix_tree)
> > + * +-------------------+
> > + *   |
> > + *   v
> > + * +-------------------+
> > + * |     Level 4       | (struct kho_radix_tree)
> > + * +-------------------+
> > + *   |
> > + *   | ... (intermediate levels)
> > + *   |
> > + *   v
> > + * +-------------------+
> > + * |      Level 0      | (struct kho_bitmap_table)
> > + * +-------------------+
> >   *
> > - * The serializing side uses two levels of xarrays to manage chunks of=
 per-order
> > - * 512 byte bitmaps. For instance if PAGE_SIZE =3D 4096, the entire 1G=
 order of a
> > - * 1TB system would fit inside a single 512 byte bitmap. For order 0 a=
llocations
> > - * each bitmap will cover 16M of address space. Thus, for 16G of memor=
y at most
> > - * 512K of bitmap memory will be needed for order 0.
>
> I think it is valuable to preserve this justification for
> bitmaps. There was a lot of debate over bitmaps vs ranges and this is
> the advantage of bitmaps. It is a bit subtle..

Sure, I will update the description about using the bitmap, along with
the new values.


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
> > + * offset. This allows its order bit to be set at position 51,
> > + * i.e. shifting right, without conflicting with the page offset bits.
>
> This description is correct, but the diagram is misleading. Maybe like th=
is:
>
>  *  |0| ... 0 0 0 1          | pa >> (PAGE_SHIFT + 0)              |
>  *  |1| ... 0 0 0 0 1        | pa >> (PAGE_SHIFT + 1)              |
>  *  |2| ... 0 0 0 0 0 1      | pa >> (PAGE_SHIFT + 2)              |
>  [..]
>

I see, giving new examples makes the order bit positions more clearer.

>
> > + *
> > + * This design stores pages of all sizes (orders) in a single 6-level =
table.  It
> > + * efficiently shares lower table levels, especially due to common zer=
o top
> > + * address bits, allowing a single, efficient algorithm to manage all =
pages.
> > + */
> > +enum kho_radix_consts {
> > +     /* The bit position of a 0-order page, only supports 64bits syste=
m */
> > +     ORDER_0_LG2 =3D 64 - PAGE_SHIFT,
> > +     /* Bit number used for each level of tables */
> > +     TABLE_SIZE_LG2 =3D const_ilog2(PAGE_SIZE / sizeof(phys_addr_t)),
> > +     /* Bit number used for lowest level of bitmaps */
> > +     BITMAP_SIZE_LG2 =3D PAGE_SHIFT + const_ilog2(BITS_PER_BYTE),
>
> "bit number" is a bit confusing when using a lg2 terms..
>
>         /* Size of the table in kho_radix_tree, in lg2 */
>         TABLE_SIZE_LG2 =3D const_ilog2(PAGE_SIZE / sizeof(phys_addr_t))
>
>         /* Number of bits in the kho_bitmap_table, in lg2 */
>         BITMAP_SIZE_LG2 =3D const_ilog2(BITS_PER_BYTE * PAGE_SIZE)
>
> Then use the constants in the structs:
>
> struct kho_radix_tree {
>        phys_addr_t table[1 << TABLE_SIZE_LG2];
> };
> struct kho_bitmap_table {
>        unsigned long bitmaps[(1 << BITMAP_SIZE_LG2) / BITS_PER_LONG];
> };
>
> > -struct khoser_mem_chunk;
> > +static inline phys_addr_t kho_radix_tree_desc(struct kho_radix_tree *v=
a)
> > +{
> > +     return (phys_addr_t)virt_to_phys(va);
> > +}
>
> virt_to_phys already returns phys_addr_t ?
>
> > +static inline struct kho_radix_tree *kho_radix_tree(phys_addr_t desc)
> > +{
> > +     return (struct kho_radix_tree *)(phys_to_virt(desc));
> > +}
>
> phys_to_virt returns void *, no need for a cast
>

Yup, will update the types in both functions.

> > +static int kho_radix_set_bitmap(struct kho_bitmap_table *bit_tlb,
> > +                             unsigned long offset)
> > +{
> > +     if (!bit_tlb ||
> > +         offset >=3D PAGE_SIZE * BITS_PER_BYTE)
> > +             return -EINVAL;
>
> WARN_ON ? These are assertions aren't they?

Yes, will add an assertion here. Or should we use "BUG_ON"? As if this
error happened something is quite wrong and I do not think it is
recoverable.

>
> > +static int kho_radix_walk_trees(struct kho_radix_tree *root, unsigned =
int level,
> > +                             unsigned long start,
> > +                             kho_radix_tree_walk_callback_t cb)
> > +{
> > +     struct kho_radix_tree *next_tree;
> > +     struct kho_bitmap_table *bitmap_table;
> > +     unsigned long encoded, i;
> > +     unsigned int level_shift;
> > +     int err =3D 0;
> > +
> > +     for (i =3D 0; i < PAGE_SIZE / sizeof(phys_addr_t); i++) {
> > +             if (root->table[i]) {
>
>
> if (!root->table[i])
>    continue
>
> Remove a level of indentation here
>
> > +static int __kho_preserve_order(unsigned long pfn, unsigned int order)
> > +{
> > +     unsigned long pa =3D PFN_PHYS(pfn);
> > +
> > +     might_sleep();
> > +
> > +     return kho_radix_preserve_page(pa, order);
>
> might_sleep should be in kho_radix_preserve_page() ? The might should
> be placed around if statements that might avoid a sleep, and that is
> not in this function.
>

I got another feedback that we can merge the kho_radix_preserve_page()
__kho_preserve_order(), so the might_sleep() will be in the if
statements.

> >  static void __init kho_mem_deserialize(const void *fdt)
> >  {
> > +     struct kho_radix_tree *tree_root;
> >       const phys_addr_t *mem;
> >       int len;
> >
> > +     /* Retrieve the KHO radix tree from passed-in FDT. */
> > +     mem =3D fdt_getprop(fdt, 0, PROP_PRESERVED_PAGE_RADIX_TREE, &len)=
;
> >
> >       if (!mem || len !=3D sizeof(*mem)) {
> > +             pr_err("failed to get preserved KHO memory tree\n");
> >               return;
> >       }
> >
> > +     tree_root =3D *mem ?
> > +             (struct kho_radix_tree *)phys_to_virt(*mem) :
> > +             NULL;
> >
> > +     if (!tree_root)
> > +             return;
>
> Seems weird?
>
> if (!*mem)
>    return;
>
> tree_root =3D phys_to_virt(*mem)
> kho_radix_walk_trees(tree_root, TREE_MAX_DEPTH - 1, 0,
>                              kho_radix_walk_trees_memblock_callback);
>

Yup, this looks more natural, my mind was thinking to check tree_root.

>
> This is prettty good now, IMHO
>
> Jason


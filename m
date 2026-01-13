Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FCDD29DC9
	for <kexec@archiver.kernel.org>; Tue, 13 Jan 2026 05:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=78QjJmPPcRBD9z/YkfxYdK7B4K+CO0yClwJwNbFrsWI=; b=Qoey4CrCtEuHQlTlise3KpmKMr
	QyZzAlvXYzKr1KI2MPy81z9DErFvHGETPVj2fgmSc8+jKQUkc/ZmjX8tl2uJzCxjSdsvbViq2rJcL
	qpILVGKnha2XbQi7txVJyZk8NTt52Bf3Z4OQ1+HvBT7xo6EtH3EvnPXioZE2gs4cNil6dc2SniHHE
	ZuRs/dToggmcpggeTXg9ziBIG1+XeYoATEr5U4pfyqbxLLRt3A4Ug3IjtSWKmSwWy8LHDmabxZV67
	zxLztgVnmJDUSLAVgcbWGvzK6xQU/As5X/qW5TSHUL5H/4FO+ZHTS0IEuNq0LnqeEZzXAmGmosVXB
	Rb+Xwmmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfX21-00000006YWb-0FAd;
	Tue, 13 Jan 2026 05:33:29 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfX1x-00000006YVg-18HV
	for kexec@lists.infradead.org;
	Tue, 13 Jan 2026 05:33:27 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so52708635e9.3
        for <kexec@lists.infradead.org>; Mon, 12 Jan 2026 21:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768282402; x=1768887202; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78QjJmPPcRBD9z/YkfxYdK7B4K+CO0yClwJwNbFrsWI=;
        b=WHdbX6CP7cdK29rGt1cFgmueJiTivB86Io+i+v9DGS9O2NXmomkKSdRTEnGaQ9+WX1
         dQE5W9gLkvdyKzbh8N+WZZ1rlRxgdGFv/1oznAn1zofibAWKXZqLIob5yHKsCSEMs5kD
         Jfj2P5Pv5AtRhFlIY4LwYx5KqSxSoqdhYe9KuIiMbqiejcVTMmnxyzWlY8hnar4Pz5TZ
         pgnWJdAucpF9AbBVmpCLhzVKhEszY6so/oZ9LhNpWUVe+I846kPW3DO2GqIgIf9NiDEd
         SxL/ZkwGWNlAo+eGJIhADy8spsiyge1Qo/+C9XoNANpLYRuwVHT38HRgx97M/68PIIgc
         xuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768282402; x=1768887202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=78QjJmPPcRBD9z/YkfxYdK7B4K+CO0yClwJwNbFrsWI=;
        b=iaYtjPOak8eP9J7KNGMYJQNRttAi82MY5shiGASP8q1/lCh+3XgEIDSDV/FWuPvqet
         8EfvbtpwyTdSe3dM6Ea+s7HDfibZ9NJDTZSSrbe5QydrWdWqzF+w87PdAeI9ZW7gMidO
         IuXICiw2wpvTW7RS8l1QROTmlOv88qgy7YUOvTkr/Xv9I+xv9/GhyYul1x559lyLyyL2
         ExRqKbiOekc4J+5xo7PSyrzWVB+lO1YNV/8gcAIWYYSWtU7cJJwaEdBBAwmOCmm8c2fX
         ERKElGOOrJCVLkf2e7iN2e0T/ISymvvAFFfW7F6USCxH6DhCRmYNXFxaW1qU+CutWtMW
         4Fgw==
X-Forwarded-Encrypted: i=1; AJvYcCVsKmBTddOFVUOHFrP58bccxP4sx0wyjCDdvXI7R9U+jc/cDqvJGEA5yHINW4FRayHpWTCPYg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwHyzfJNRj/JvYDW0qsCA+xMyzgcqKDUrQgdGZdHC3x/BTqJTMW
	9lNKi19TgJjhfCGkUPk46iVLAIhzz887vjfdBK3NG2ZoHIiOgamVNVlhyNFInKEj5YsksoYAfX0
	3ZJ8YfsZ4N6ZOJosUszpFD0A64XNVlZ1XZ0n/doD4tvpdLQ0bkrbfAGR23K4=
X-Gm-Gg: AY/fxX7Xyyq9djRDQReuZFV/GzaEgW63BTHNWh9stdJ2LGgfchFGJ0YVo2ESX1Use5T
	4D7YzT7EsNWoMiedFMRHzP9JGmzJMClQY3QGMTXsYw1Qu7KbPEPadiN8jBLmNzWLoOXG2tHyk5X
	iEiB9kZ+mRflOlsTFAdYIePX7YfnWPF5Tl5Lmh4ZhKlJyVxmZiABDzzZGVpH+8Hy2fjCFThLpzh
	7C3gz4KLkFnEhkJvap65xAUkNLOCSOoHnZMa94+x8iZfzFJvxudclrzwChBhnNkDw2orUDSXPtI
	dDyyEZ3FTQISrUbm7BMpMJjiNQ==
X-Google-Smtp-Source: AGHT+IEEN4AWGOx75npEubvSu4mCUXKcXIZgHx1LK0Y31u42UnqHzT4YTtI0ga8X/oxUo8uM9cnrKT9V0xnvF0Shwds=
X-Received: by 2002:a05:600c:82c3:b0:47a:8154:33e3 with SMTP id
 5b1f17b1804b1-47d84b5b4b4mr195755735e9.28.1768282402050; Mon, 12 Jan 2026
 21:33:22 -0800 (PST)
MIME-Version: 1.0
References: <20260109001127.2596222-1-jasonmiu@google.com> <20260109001127.2596222-2-jasonmiu@google.com>
 <aWTJ2v9J-Aa6ykBf@kernel.org>
In-Reply-To: <aWTJ2v9J-Aa6ykBf@kernel.org>
From: Jason Miu <jasonmiu@google.com>
Date: Mon, 12 Jan 2026 21:33:10 -0800
X-Gm-Features: AZwV_QiirD93hHTgP_r628fIv81n3_PDlKfZ1YgIy6hbB_xwpILRrNBnr0ZrVfU
Message-ID: <CAHN2nPL=wnqjici92Vj5Ub5w=xXN8CDfOVjOTUOWs4VeJC107Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kho: Adopt radix tree for preserved memory tracking
To: Mike Rapoport <rppt@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260112_213325_492951_5C881520 
X-CRM114-Status: GOOD (  57.60  )
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

On Mon, Jan 12, 2026 at 2:16=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Thu, Jan 08, 2026 at 04:11:26PM -0800, Jason Miu wrote:
> > Introduce a radix tree implementation for tracking preserved memory
> > pages and switch the KHO memory tracking mechanism to use it. This
> > lays the groundwork for a stateless KHO implementation that eliminates
> > the need for serialization and the associated "finalize" state.
> >
...
>
> ...
>
> > +/**
> > + * DOC: KHO persistent memory tracker
> > + *
> > + * KHO tracks preserved memory using a radix tree data structure. Each=
 node of
> > + * the tree is exactly a single page. The leaf nodes are bitmaps where=
 each set
> > + * bit is a preserved page of any order. The intermediate nodes are ta=
bles of
> > + * physical addresses that point to a lower level node.
> > + *
> > + * The tree hierarchy is shown below::
> > + *
> > + *   root
> > + *   +-------------------+
> > + *   |     Level 5       | (struct kho_radix_node)
> > + *   +-------------------+
> > + *     |
> > + *     v
> > + *   +-------------------+
> > + *   |     Level 4       | (struct kho_radix_node)
> > + *   +-------------------+
> > + *     |
> > + *     | ... (intermediate levels)
> > + *     |
> > + *     v
> > + *   +-------------------+
> > + *   |      Level 0      | (struct kho_radix_leaf)
> > + *   +-------------------+
> > + *
> > + * The tree is traversed using a key that encodes the page's physical =
address
> > + * (pa) and its order into a single unsigned long value. The encoded k=
ey value
> > + * is composed of two parts: the 'order bit' in the upper part and the=
 'page
> > + * offset' in the lower part.::
> > + *
> > + *   +------------+-----------------------------+---------------------=
-----+
> > + *   | Page Order | Order Bit                   | Page Offset         =
     |
> > + *   +------------+-----------------------------+---------------------=
-----+
> > + *   | 0          | ...000100 ... (at bit 52)   | pa >> (PAGE_SHIFT + =
0)   |
> > + *   | 1          | ...000010 ... (at bit 51)   | pa >> (PAGE_SHIFT + =
1)   |
> > + *   | 2          | ...000001 ... (at bit 50)   | pa >> (PAGE_SHIFT + =
2)   |
> > + *   | ...        | ...                         | ...                 =
     |
> > + *   +------------+-----------------------------+---------------------=
-----+
> > + *
> > + * Page Offset:
>
> To me "page offset" reads as offset from somewhere and here it's rather p=
fn
> on steroids :)
> Also in many places in the kernel "page offset" refers to the offset insi=
de a
> page.
>
> Can't say I can think of a better name, but it feels that it should expre=
ss
> that this is an address more explicitly.
>

I updated this to "Shifted Physical Address," borrowing the idea from
Jason Gunthorpe. (Thank you =3D)

> > + * The 'page offset' is the physical address normalized for its order.=
 It
> > + * effectively represents the page offset for the given order.
> > + *
> > + * Order Bit:
> > + * The 'order bit' encodes the page order by setting a single bit at a
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
> > + * The following diagram illustrates how the encoded key value is spli=
t into
> > + * indices for the tree levels, with PAGE_SIZE of 4KB::
> > + *
> > + *        63:60   59:51    50:42    41:33    32:24    23:15         14=
:0
> > + *   +---------+--------+--------+--------+--------+--------+---------=
--------+
> > + *   |    0    |  Lv 5  |  Lv 4  |  Lv 3  |  Lv 2  |  Lv 1  |  Lv 0 (b=
itmap)  |
> > + *   +---------+--------+--------+--------+--------+--------+---------=
--------+
> > + *
> > + * The radix tree stores pages of all sizes (orders) in a single 6-lev=
el
>
> "sizes" can be misleading here because "all sizes" can mean non power-of-=
2
> sizes as well. I'd just use "pages of all orders".
>
> > + * hierarchy. It efficiently shares lower table levels, especially due=
 to
>
> Don't we share the higher levels? Also using "tree" instead of "table"
> seems clearer to me.
>
yes, updated.

> > + * common zero top address bits, allowing a single, efficient algorith=
m to
> > + * manage all pages. This bitmap approach also offers memory efficienc=
y; for
> > + * example, a 512KB bitmap can cover a 16GB memory range for 0-order p=
ages with
> > + * PAGE_SIZE =3D 4KB.
> > + *
> > + * The data structures defined here are part of the KHO ABI. Any modif=
ication
> > + * to these structures that breaks backward compatibility must be acco=
mpanied by
> > + * an update to the "compatible" string. This ensures that a newer ker=
nel can
> > + * correctly interpret the data passed by an older kernel.
> > + */
> > +
> > +/*
> > + * Defines constants for the KHO radix tree structure, used to track p=
reserved
> > + * memory. These constants govern the indexing, sizing, and depth of t=
he tree.
> > + */
> > +enum kho_radix_consts {
> > +     /*
> > +      * The bit position of the order bit (and also the length of the
> > +      * page offset) for an order-0 page.
> > +      */
> > +     KHO_ORDER_0_LOG2 =3D 64 - PAGE_SHIFT,
> > +
> > +     /* Size of the table in kho_radix_node, in log2 */
> > +     KHO_TABLE_SIZE_LOG2 =3D const_ilog2(PAGE_SIZE / sizeof(phys_addr_=
t)),
> > +
> > +     /* Number of bits in the kho_radix_leaf bitmap, in log2 */
> > +     KHO_BITMAP_SIZE_LOG2 =3D PAGE_SHIFT + const_ilog2(BITS_PER_BYTE),
> > +
> > +     /*
> > +      * The total tree depth is the number of intermediate levels
> > +      * and 1 bitmap level.
> > +      */
> > +     KHO_TREE_MAX_DEPTH =3D
> > +     DIV_ROUND_UP(KHO_ORDER_0_LOG2 - KHO_BITMAP_SIZE_LOG2,
> > +                  KHO_TABLE_SIZE_LOG2) + 1,
>
> Extra tab in indentation of DIV_ROUND_UP would make it more readable IMHO=
.
>
> > +};
> > +
> > +struct kho_radix_node {
> > +     u64 table[1 << KHO_TABLE_SIZE_LOG2];
> > +};
> > +
> > +struct kho_radix_leaf {
> > +     DECLARE_BITMAP(bitmap, 1 << KHO_BITMAP_SIZE_LOG2);
> > +};
> > +
> >  #endif       /* _LINUX_KHO_ABI_KEXEC_HANDOVER_H */
> > diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_t=
ree.h
> > new file mode 100644
> > index 000000000000..8f03dd226dd9
> > --- /dev/null
> > +++ b/include/linux/kho_radix_tree.h
> > @@ -0,0 +1,72 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef _LINUX_KHO_ABI_RADIX_TREE_H
> > +#define _LINUX_KHO_ABI_RADIX_TREE_H
>
> I misinterpreted the file name during v3 review, no need for _ABI here :)
>
> > +#include <linux/err.h>
> > +#include <linux/errno.h>
> > +#include <linux/mutex_types.h>
> > +#include <linux/types.h>
>
> ...
>
> > +#ifdef CONFIG_KEXEC_HANDOVER
> > +
> > +int kho_radix_add_page(struct kho_radix_tree *tree, unsigned long pfn,
> > +                    unsigned int order);
> > +
> > +void kho_radix_del_page(struct kho_radix_tree *tree, unsigned long pfn=
,
> > +                     unsigned int order);
> > +
> > +int kho_radix_walk_tree(struct kho_radix_tree *tree, unsigned int leve=
l,
>
> I think 'level' and 'start' should not be a part of public API. We don't
> want to expose walking the tree from arbitrary place.
>

Sure, update the function implementation as well.

> > +                     unsigned long start, kho_radix_tree_walk_callback=
_t cb);
> > +
> > +#else  /* #ifdef CONFIG_KEXEC_HANDOVER */
>
> ...
>
> > +/**
> > + * kho_radix_decode_key - Decodes a radix key back into a physical add=
ress and order.
> > + * @key: The unsigned long key to decode.
> > + * @order: An output parameter, a pointer to an unsigned int where the=
 decoded
> > + *         page order will be stored.
> > + *
> > + * This function reverses the encoding performed by kho_radix_encode_k=
ey(),
> > + * extracting the original physical address and page order from a give=
n key.
> > + *
> > + * Return: The decoded physical address.
> > + */
> > +static phys_addr_t kho_radix_decode_key(unsigned long key,
> > +                                     unsigned int *order)
>
> Nit: *order can be on the same line as key
>
> >  {
>
> ...
>
> > +static unsigned long kho_radix_get_index(unsigned long key,
> > +                                      unsigned int level)
> > +{
> > +     int s;
> > +
> > +     if (level =3D=3D 0)
> > +             return kho_radix_get_bitmap_index(key);
>
> I'd drop this and use get_bitmap_index() explicitly for level-0.
> Maybe also rename _get_index() to _get_table_index().
>

The function name is udpated and the caller will call
kho_radix_get_bitmap_index() for bitmap level explicitly.

> > +
> > +     s =3D ((level - 1) * KHO_TABLE_SIZE_LOG2) + KHO_BITMAP_SIZE_LOG2;
> > +     return (key >> s) % (1 << KHO_TABLE_SIZE_LOG2);
> > +}
>
> ...
>
> > +void kho_radix_del_page(struct kho_radix_tree *tree, unsigned long pfn=
,
> > +                     unsigned int order)
> > +{
> > +     unsigned long key =3D kho_radix_encode_key(PFN_PHYS(pfn), order);
> > +     struct kho_radix_node *node =3D tree->root;
> > +     struct kho_radix_leaf *leaf;
> > +     unsigned int i, idx;
> > +
> > +     if (WARN_ON_ONCE(!tree->root))
> > +             return;
> > +
> > +     might_sleep();
> > +
> > +     guard(mutex)(&tree->lock);
> > +
> > +     /* Go from high levels to low levels */
> > +     for (i =3D KHO_TREE_MAX_DEPTH - 1; i > 0; i--) {
> > +             idx =3D kho_radix_get_index(key, i);
> > +
> > +             /*
> > +              * Attempting to delete a page that has not been preserve=
d,
> > +              * return with a warning.
> > +              */
> > +             if (WARN_ON(!node->table[idx]))
> > +                     return;
> > +
> > +             if (node->table[idx])
>
> There's already WARN_ON(!node->table) and return, no need for another if
> here.
>
> > +                     node =3D phys_to_virt((phys_addr_t)node->table[id=
x]);
> > +     }
> > +
> > +     /* Handle the leaf level bitmap (level 0) */
> > +     leaf =3D (struct kho_radix_leaf *)node;
> > +     idx =3D kho_radix_get_index(key, 0);
> > +     __clear_bit(idx, leaf->bitmap);
>
> I think I already mentioned it in earlier reviews, but I don't remember a=
ny
> response.
>
> How do we approach freeing empty bitmaps and intermediate nodes?
> If we do a few preserve/uppreserve cycles for memory that can be allocate=
d
> and freed in between we might get many unused bitmaps.
>
> My view is that we should free the empty bitmaps, maybe asynchronously.
> The intermediate nodes probably don't take that much memory to bother wit=
h
> them.
>

I think memory preserving and than unpreserving is not a common use
case. I suggest keeping the current simpler implementation instead of
doing the cleanup, we can address this memory usage optimization
later. If we implement this, I tend to clean up all the empty bitmaps
and intermediate nodes to avoid incomplete tree traversing paths.

> > +}
> > +EXPORT_SYMBOL_GPL(kho_radix_del_page);
>
> ...
>
> > +/**
> > + * kho_radix_walk_tree - Traverses the radix tree and calls a callback=
 for each preserved page.
> > + * @tree: A pointer to the KHO radix tree to walk.
> > + * @level: The starting level for the walk (typically KHO_TREE_MAX_DEP=
TH - 1).
> > + * @start: The initial key prefix for the walk (typically 0).
> > + * @cb: A callback function of type kho_radix_tree_walk_callback_t tha=
t will be
> > + *      invoked for each preserved page found in the tree. The callbac=
k receives
> > + *      the physical address and order of the preserved page.
> > + *
> > + * This function walks the radix tree, searching from the specified to=
p level
> > + * (@level) down to the lowest level (level 0). For each preserved pag=
e found,
> > + * it invokes the provided callback, passing the page's physical addre=
ss and
> > + * order.
> > + *
> > + * Return: 0 if the walk completed the specified tree, or the non-zero=
 return
> > + *         value from the callback that stopped the walk.
> > + */
> > +int kho_radix_walk_tree(struct kho_radix_tree *tree, unsigned int leve=
l,
> > +                     unsigned long start, kho_radix_tree_walk_callback=
_t cb)
> > +{
> > +     if (WARN_ON_ONCE(!tree->root))
> > +             return -EINVAL;
> > +
> > +     guard(mutex)(&tree->lock);
> > +
> > +     return __kho_radix_walk_tree(tree->root, level, start, cb);
>
> Like I said, let's make it
>
>         return __kho_radix_walk_tree(tree->root, KHO_TREE_MAX_DEPTH - 1, =
0, cb);
>
> and drop level and start parameters.
>
> > +}
> > +EXPORT_SYMBOL_GPL(kho_radix_walk_tree);
>
> ...
>
> > @@ -260,11 +388,20 @@ static struct page *kho_restore_page(phys_addr_t =
phys, bool is_folio)
> >
> >       /* Clear private to make sure later restores on this page error o=
ut. */
> >       page->private =3D 0;
> > +     /* Head page gets refcount of 1. */
> > +     set_page_count(page, 1);
> >
> > -     if (is_folio)
> > -             kho_init_folio(page, info.order);
> > -     else
> > -             kho_init_pages(page, nr_pages);
> > +     /*
> > +      * For higher order folios, tail pages get a page count of zero.
> > +      * For physically contiguous order-0 pages every pages gets a pag=
e
> > +      * count of 1
> > +      */
> > +     ref_cnt =3D is_folio ? 0 : 1;
> > +     for (unsigned int i =3D 1; i < nr_pages; i++)
> > +             set_page_count(page + i, ref_cnt);
> > +
> > +     if (is_folio && info.order)
> > +             prep_compound_page(page, info.order);
>
> It looks like this reverts latest Pratyush's changes to kho_restore_page(=
),
> please rebase on a newer version of mm.git/linux-next.git.
>

Yes, sync-ed again.

> >
> >       adjust_managed_page_count(page, nr_pages);
> >       return page;
>
> ...
>
> > +static int __init kho_radix_memblock_reserve(phys_addr_t phys,
> > +                                          unsigned int order)
>
> I don't think _radix should be mentioned in the callback at all.
> How about
>
> kho_preserved_memory_reserve()?
>
> >  {
>
> ...
>
> > +     /* Reserve the memory preserved in KHO radix tree in memblock */
>
>         /* Reserve memory preserved by KHO in memblock */
>
> What data structure is used to track the preserved memory is not importan=
t
> here.
>
> > +     memblock_reserve(phys, sz);
> > +     memblock_reserved_mark_noinit(phys, sz);
> > +     info.magic =3D KHO_PAGE_MAGIC;
> > +     info.order =3D order;
> > +     page->private =3D info.page_private;
> >
> >       return 0;
> >  }
>
> ...
>
> >  static __init int kho_out_fdt_setup(void)
> >  {
> > +     struct kho_radix_tree *tree =3D &kho_out.radix_tree;
> >       void *root =3D kho_out.fdt;
> > -     u64 empty_mem_map =3D 0;
> > +     u64 preserved_mem_tree_pa;
> >       int err;
> >
> >       err =3D fdt_create(root, PAGE_SIZE);
> >       err |=3D fdt_finish_reservemap(root);
> >       err |=3D fdt_begin_node(root, "");
> >       err |=3D fdt_property_string(root, "compatible", KHO_FDT_COMPATIB=
LE);
> > -     err |=3D fdt_property(root, KHO_FDT_MEMORY_MAP_PROP_NAME, &empty_=
mem_map,
> > -                         sizeof(empty_mem_map));
> > +
> > +     scoped_guard(mutex, &tree->lock) {
>
> This runs exactly one time on boot and there's no place in the code that
> can concurrently change tree->root.
>

Updated and I understand the idea. Personally I think having a mutex
lock always when accessing the tree makes the logic symmetric, but
this change is certainly more optimal. =3D)

> > +             preserved_mem_tree_pa =3D (u64)virt_to_phys(tree->root);
>
> I don't think we should cast phys_addr_t to u64.
>
> > +     }
> > +
> > +     err |=3D fdt_property(root, KHO_FDT_MEMORY_MAP_PROP_NAME,
> > +                         &preserved_mem_tree_pa,
> > +                         sizeof(preserved_mem_tree_pa));
> > +
> >       err |=3D fdt_end_node(root);
> >       err |=3D fdt_finish(root);
> >
> > @@ -1332,16 +1329,26 @@ static __init int kho_out_fdt_setup(void)
> >
> >  static __init int kho_init(void)
> >  {
> > +     struct kho_radix_tree *tree =3D &kho_out.radix_tree;
> >       const void *fdt =3D kho_get_fdt();
> >       int err =3D 0;
> >
> >       if (!kho_enable)
> >               return 0;
> >
> > +     scoped_guard(mutex, &tree->lock) {
>
> No need for lock here. If anything tries to access the tree before the ro=
ot
> is allocated we are anyway doomed.
>
> > +             tree->root =3D (struct kho_radix_node *)
> > +                     kzalloc(PAGE_SIZE, GFP_KERNEL);
>
> No need for casting from void *.
>
> > +             if (!tree->root) {
> > +                     err =3D -ENOMEM;
> > +                     goto err_free_scratch;
> > +             }
> > +     }
>
> --
> Sincerely yours,
> Mike.

Thanks again, sending out the v5 patches.

--
Jason Miu


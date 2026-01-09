Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC888D232C6
	for <kexec@archiver.kernel.org>; Fri,  9 Jan 2026 00:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6ZXsFnHVRKgsVqJ0geKDryjhTjN/amGCQXZ3AOgajXE=; b=20Nhv64qFEqN+fgW+kpS7yyDP4
	xiF3cyPAwyZ7IivXhW6Zmfzu8YZQrVzzE62UKtws6O502tW0oyXRJ6FokG3PNqeU0nTXuhfMpcPJ6
	Y2WvRZfdqhu8pZWYcHgdo0p7jAGDgE9BHwv48O8UM1zhZp60xkK4TvrJx4aF3hgfMN/lls4dNYsFb
	MzMyAu0pEWyXtlJEu1ZZKuvfnrjfVd6rfu+8owedLlBGucjTgUv0Y5ohRTnXP3CnTNLl2UcpXbmPV
	Luiiz64ehul0lvLTJIT2fdFmmgBdjJJEdqMRKX0T/78AeAPD2p5QGhXin5RTz3ybZ4vuCwGCUpp9v
	q5PIXSpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ve03m-000000011Kg-35U3;
	Fri, 09 Jan 2026 00:08:58 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ve03j-000000011KJ-0ngV
	for kexec@lists.infradead.org;
	Fri, 09 Jan 2026 00:08:57 +0000
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-4308d81fdf6so1883391f8f.2
        for <kexec@lists.infradead.org>; Thu, 08 Jan 2026 16:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767917332; x=1768522132; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZXsFnHVRKgsVqJ0geKDryjhTjN/amGCQXZ3AOgajXE=;
        b=2QsnVA+92aVcZbTHJK/3RgW09Dz/fjpvO4kDu1U0wxlftFo+XGQhG6mrLBwJn4WAxB
         5ZokOJKanakFssIocsUDxE5VFiOPoH7+o1SWxrHxjVYDKoVHGIfLKnWySF2pmeog21cM
         mESROLgZinEL3nYW7YEbJhPICtTd4jxTbcAUpDpCmq2YsWlYDn/mih9LYjdDccddUQDR
         kViVQBb30V+5bxKtBMP/l7JHI0Z/rqVySC7O/OUadm+kQPP4kvQNPFw2k2G9vLw3a9fh
         g222RgqmedK5jS+XwkvvzWVHdCvFSYeucKGqKLwZZoHILq1hzcYuzQ9jWORkLdi4LTk3
         x9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767917332; x=1768522132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ZXsFnHVRKgsVqJ0geKDryjhTjN/amGCQXZ3AOgajXE=;
        b=Tu7/+yvkOHn1HZMH7ayueZA1bcreUG6oeV03p2srz3MqBU07e+FsFSiQ8kEvB9rXUu
         JBgS4HmQF7VBgSiE4pvlybNeAnEJyZBvYfAMQyLTvH1FOAOheYyf9lYocsM2pMBvrhCT
         jbiqbdCfrGcREO7Pe68uW66kiEInXxkgoHjeoyorOuE8Omb1Zh8oikMVATw8QcYEgo50
         O4BKEo75uM6qagG5ppywgF+OpJuYkb/BcUcaENFMBylvYFKBaXvqszLiWJhbUeyCBUmL
         mISdLHgmMzIy+uVBKMwH/qimj0d7JoeGElwSQnMCQEBpbymt9sTNVWOXO3NdKWE+oFek
         AFIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLOFWR0/qhvm7cfjXfKzc1z0gvIOxtBb7S51V+RyOuRFBJ02kDnCdl0pK94Cilel2cZLyfoA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwP78u+9hKDZTFzqlX6g0zL0aviYX+PuAz1xG2yVPktbOZ6Fnp0
	wOEZICXFY7ezShJIum/RGU6tI8748cjBYeWea2mH9x59OYWdAsjSfH/hKGjcYvnan69m9zTM0ML
	4rkYYXTV05uYGUN6Lw5SEh716T9s21lG52rf7D4SZ
X-Gm-Gg: AY/fxX6W/hD7FQUMliYWzHBDYsEX1n0qQvgsY4+i9xcXBBTwgEp4RAwkOaRFkq1D5MJ
	7FJxYc8vEmQwLe6Hd/hjN1QpHsqa3Z6OtCDm/erskca/SxucIl6sLg++TIpq0QG8WtWHzR+kmWY
	aE0I7atG9xN0Dl0XPnClN5OSvl/Os2mubeMZ0FJ4HA9ZAIbxVJAdrsMXxPHuufv8dIUx2QNUTaC
	lIeOR8v/tae9/PsouN8ghTXAYIXbktZ8vP1X/kK1gXKiJd6cMWetFUtyE1PZCMm/nj/GI4B0eZK
	CWO4Y5Fq5Q==
X-Google-Smtp-Source: AGHT+IGY6RJoWVczfWR48UVI8jo40++Mh1u6XiwfWqVePbZ9SpTxmZwBu6BjlfkNGQhwSwUMnlg1JwfN0lozaVpx0uk=
X-Received: by 2002:a5d:5850:0:b0:429:b9bc:e81a with SMTP id
 ffacd0b85a97d-432c32f58d0mr7760003f8f.0.1767917331760; Thu, 08 Jan 2026
 16:08:51 -0800 (PST)
MIME-Version: 1.0
References: <20251209025317.3846938-1-jasonmiu@google.com> <20251209025317.3846938-4-jasonmiu@google.com>
 <aVuD-PeGIRnr8jZh@kernel.org>
In-Reply-To: <aVuD-PeGIRnr8jZh@kernel.org>
From: Jason Miu <jasonmiu@google.com>
Date: Thu, 8 Jan 2026 16:08:40 -0800
X-Gm-Features: AZwV_Qhg2Zt4e60JlInyLnLjzcgINwHwVMNjPyiOulG7k5LubpQae51p6aiGWnE
Message-ID: <CAHN2nPJCi_LvD31dZseFVpUBJDdBxK24q7DyMQzBBOr1Ph1wrg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] kho: Adopt radix tree for preserved memory tracking
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
X-CRM114-CacheID: sfid-20260108_160855_544137_93295EA7 
X-CRM114-Status: GOOD (  52.72  )
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

Thank you, Mike for your comments! I put my update into the v4 patch series=
.

On Mon, Jan 5, 2026 at 1:27=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wrot=
e:
>
> On Mon, Dec 08, 2025 at 06:53:15PM -0800, Jason Miu wrote:
> > Introduce a radix tree implementation for tracking preserved memory pag=
es
> > and switch the KHO memory tracking mechanism to use it. This lays the
> > groundwork for a stateless KHO implementation that eliminates the need =
for
> > serialization and the associated "finalize" state.
> >
> > This patch introduces the core radix tree data structures and constants=
 to
> > the KHO ABI. It adds the radix tree node and leaf structures, along wit=
h
> > documentation for the radix tree key encoding scheme that combines a pa=
ge's
> > physical address and order.
> >
> > To support broader use by other kernel subsystems, such as hugetlb
> > preservation, the core radix tree manipulation functions are exported a=
s
> > a public API.
> >
> > The xarray-based memory tracking is replaced with this new radix tree
> > implementation. The core KHO preservation and unpreservation functions =
are
> > wired up to use the radix tree helpers. On boot, the second kernel rest=
ores
> > the preserved memory map by walking the radix tree whose root physical
> > address is passed via the FDT.
> >
> > The ABI `compatible` version is bumped to "kho-v2" to reflect the
> > structural changes in the preserved memory map and sub-FDT property
> > names.
> >
> > Signed-off-by: Jason Miu <jasonmiu@google.com>
> > ---
> >  Documentation/core-api/kho/concepts.rst   |   2 +-
> >  Documentation/core-api/kho/fdt.rst        |   7 +
> >  Documentation/core-api/kho/index.rst      |   1 +
> >  Documentation/core-api/kho/radix_tree.rst |  17 +
> >  include/linux/kho/abi/kexec_handover.h    | 124 +++-
> >  include/linux/kho_radix_tree.h            |  81 +++
> >  kernel/liveupdate/kexec_handover.c        | 658 ++++++++++++----------
> >  7 files changed, 568 insertions(+), 322 deletions(-)
> >  create mode 100644 Documentation/core-api/kho/radix_tree.rst
> >  create mode 100644 include/linux/kho_radix_tree.h
> >
> > diff --git a/Documentation/core-api/kho/concepts.rst b/Documentation/co=
re-api/kho/concepts.rst
> > index e96893937286..d38bcaa951e4 100644
> > --- a/Documentation/core-api/kho/concepts.rst
> > +++ b/Documentation/core-api/kho/concepts.rst
> > @@ -71,7 +71,7 @@ in the FDT. That state is called the KHO finalization=
 phase.
> >  Public API
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  .. kernel-doc:: kernel/liveupdate/kexec_handover.c
> > -   :export:
> > +   :identifiers: kho_is_enabled kho_restore_folio kho_restore_pages kh=
o_add_subtree kho_remove_subtree kho_preserve_folio kho_unpreserve_folio kh=
o_preserve_pages kho_unpreserve_pages kho_preserve_vmalloc kho_unpreserve_v=
malloc kho_restore_vmalloc kho_alloc_preserve kho_unpreserve_free kho_resto=
re_free is_kho_boot kho_retrieve_subtree
>
> Ouch. This would be unmaintainable :(
>

With the newly merged concepts and FDT doc (ab37f60bc0eb), I also
merged the APIs into the index file so all the info is in the same
place.

> > diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho=
/abi/kexec_handover.h
> > index 74f4fa67e458..bdda2fe67353 100644
> > --- a/include/linux/kho/abi/kexec_handover.h
> > +++ b/include/linux/kho/abi/kexec_handover.h
> > @@ -10,6 +10,8 @@
> >  #ifndef _LINUX_KHO_ABI_KEXEC_HANDOVER_H
> >  #define _LINUX_KHO_ABI_KEXEC_HANDOVER_H
> >
> > +#include <linux/bits.h>
> > +#include <linux/log2.h>
> >  #include <linux/types.h>
> >
> >  /**
> > @@ -35,25 +37,25 @@
> >   *   parses this FDT to locate and restore the preserved data.::
> >   *
> >   *     / {
> > - *         compatible =3D "kho-v1";
> > + *         compatible =3D "kho-v2";
> >   *
> >   *         preserved-memory-map =3D <0x...>;
> >   *
> >   *         <subnode-name-1> {
> > - *             fdt =3D <0x...>;
> > + *             preserved-data =3D <0x...>;
>
> Please extend the paragraph describing "compatible" change in the commit
> message to mention that "preserved-data" is a better name than "fdt"
> because some subsystems will not use fdt format for their preserved state=
.
>

Sure.

> >   *         };
> >   *
> >   *         <subnode-name-2> {
> > - *             fdt =3D <0x...>;
> > + *             preserved-data =3D <0x...>;
> >   *         };
> >   *               ... ...
> >   *         <subnode-name-N> {
> > - *             fdt =3D <0x...>;
> > + *             preserved-data =3D <0x...>;
> >   *         };
> >   *     };
> >   *
> >   *   Root KHO Node (/):
> > - *     - compatible: "kho-v1"
> > + *     - compatible: "kho-v2"
> >   *
> >   *       Indentifies the overall KHO ABI version.
> >   *
> > @@ -68,20 +70,20 @@
> >   *     is provided by the subsystem that uses KHO for preserving its
> >   *     data.
> >   *
> > - *     - fdt: u64
> > + *     - preserved-data: u64
> >   *
> > - *       Physical address pointing to a subnode FDT blob that is also
> > + *       Physical address pointing to a subnode data blob that is also
> >   *       being preserved.
> >   */
> >
> >  /* The compatible string for the KHO FDT root node. */
> > -#define KHO_FDT_COMPATIBLE "kho-v1"
> > +#define KHO_FDT_COMPATIBLE "kho-v2"
> >
> >  /* The FDT property for the preserved memory map. */
> >  #define KHO_FDT_MEMORY_MAP_PROP_NAME "preserved-memory-map"
> >
> >  /* The FDT property for sub-FDTs. */
> > -#define KHO_FDT_SUB_TREE_PROP_NAME "fdt"
> > +#define KHO_FDT_SUB_TREE_PROP_NAME "preserved-data"
> >
> >  /**
> >   * DOC: Kexec Handover ABI for vmalloc Preservation
> > @@ -159,4 +161,108 @@ struct kho_vmalloc {
> >       unsigned short order;
> >  };
> >
> > +/**
> > + * DOC: Keep track of memory that is to be preserved across KHO.
>
> Maybe "KHO persistent memory tracker"?
>
> > + *
> > + * KHO tracks preserved memory using a radix tree data structure. Each=
 node of
> > + * the tree is PAGE_SIZE. The leaf nodes are bitmaps where each set bi=
t
>
> Maybe "Each node of the tree is exactly a single page"?
>
> > + * represents a single preserved page. The intermediate nodes are tabl=
es of
>
> And here "a single preserved page" reads to me like a single order-0 page=
.
> I think we should note that each bit can represent pages of different
> orders.
>
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
> > + * This is achieved by encoding the page's physical address (pa) and i=
ts order
>
> It's not really clear what "this is achieved" refers to.
>
> > + * into a single unsigned long value. This value is a key then used to=
 traverse
>
>                                          This value is then used as a key=
 to ...
>
> > + * the tree. The encoded key value is composed of two parts: the 'orde=
r bit' in
> > + * the upper part and the 'page offset' in the lower part.::
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
> > + * This design stores pages of all sizes (orders) in a single 6-level =
table.
>
> s/This design/The radix tree/ and s/table/hierarchy/
>

Yup, the documents above are updated.

> > + * It efficiently shares lower table levels, especially due to common =
zero top
> > + * address bits, allowing a single, efficient algorithm to manage all =
pages.
> > + * This bitmap approach also offers memory efficiency; for example, a =
512KB
> > + * bitmap can cover a 16GB memory range for 0-order pages with PAGE_SI=
ZE =3D 4KB.
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
> > +     /* The bit position of a 0-order page */
>
>                  ^ this is either position of the order bits or length of
> the "page offset" for an order-0 page
>
> > +     KHO_ORDER_0_LG2 =3D 64 - PAGE_SHIFT,
>
> I'd spell out LOG2 rather than LG2 here and below.
>
> > +
> > +     /* Size of the table in kho_mem_radix_tree, in lg2 */
>
> We don't have kho_mem_radix_tree anymore, do we?
>
> > +     KHO_TABLE_SIZE_LG2 =3D const_ilog2(PAGE_SIZE / sizeof(phys_addr_t=
)),
> > +
> > +     /* Number of bits in the kho_bitmap, in lg2 */
> > +     KHO_BITMAP_SIZE_LG2 =3D PAGE_SHIFT + const_ilog2(BITS_PER_BYTE),
> > +
> > +     /*
> > +      * The total tree depth is the number of intermediate levels
> > +      * and 1 bitmap level.
> > +      */
> > +     KHO_TREE_MAX_DEPTH =3D DIV_ROUND_UP(KHO_ORDER_0_LG2 - KHO_BITMAP_=
SIZE_LG2,
> > +                                       KHO_TABLE_SIZE_LG2) + 1,
> > +};
> > +
> > +struct kho_radix_node {
> > +     u64 table[1 << KHO_TABLE_SIZE_LG2];
> > +};
> > +
> > +struct kho_radix_leaf {
> > +     DECLARE_BITMAP(bitmap, 1 << KHO_BITMAP_SIZE_LG2);
> > +};
> > +
> >  #endif       /* _LINUX_KHO_ABI_KEXEC_HANDOVER_H */
> > diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_t=
ree.h
> > new file mode 100644
> > index 000000000000..5101a04f6ae6
> > --- /dev/null
> > +++ b/kho_radix_tree.h
> > @@ -0,0 +1,81 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef _LIVEUPDATE_KEXEC_HANDOVER_RADIX_TREE_H
> > +#define _LIVEUPDATE_KEXEC_HANDOVER_RADIX_TREE_H
>
> Please use _LINUX_KHO_ABI prefix
>

Updated. This is the "include/linux/kho_radix_tree.h" for the public
kho radix tree API, but we like to use the same _LINUX_KHO_ABI prefix,
correct?

> > +
> > +#include <linux/err.h>
> > +#include <linux/errno.h>
> > +#include <linux/types.h>
> > +
> > +/**
> > + * DOC: Kexec Handover Radix Tree
> > + *
> > + * This is a radix tree implementation for tracking physical memory pa=
ges
> > + * across kexec transitions. It was developed for the KHO mechanism bu=
t is
> > + * designed for broader use by any subsystem that needs to preserve pa=
ges.
> > + *
> > + * The radix tree is a multi-level tree where leaf nodes are bitmaps
> > + * representing individual pages. To allow pages of different sizes (o=
rders)
> > + * to be stored efficiently in a single tree, it uses a unique key enc=
oding
> > + * scheme. Each key is an unsigned long that combines a page's physica=
l
> > + * address and its order.
> > + *
> > + * Client code is responsible for allocating the root node of the tree=
 and
> > + * managing its lifecycle, and must use the tree data structures defin=
ed in
> > + * the KHO ABI, `include/linux/kho/abi/kexec_handover.h`.
> > + */
> > +
> > +struct kho_radix_node;
> > +
> > +typedef int (*kho_radix_tree_walk_callback_t)(unsigned long radix_key)=
;
>
> I don't think radix tree users outside kexec_handover.c should bother wit=
h
> the key encoding.
> The callback here should have physical address and order as parameters.
>

I have updated the related function signatures and removed the
kho_radix_encode/decode_key() from the public API. I think this makes
the interface cleaner, thanks.

> > +
> > +#ifdef CONFIG_KEXEC_HANDOVER
> > +
> > +unsigned long kho_radix_encode_key(phys_addr_t pa, unsigned int order)=
;
> > +
> > +phys_addr_t kho_radix_decode_key(unsigned long radix_key,
> > +                              unsigned int *order);
>
> These should not be a part of public interface.
>
> > +int kho_radix_add_page(struct kho_radix_node *root, unsigned long pfn,
> > +                    unsigned int order);
> > +
> > +void kho_radix_del_page(struct kho_radix_node *root, unsigned long pfn=
,
> > +                     unsigned int order);
> > +
> > +int kho_radix_walk_tree(struct kho_radix_node *root, unsigned int leve=
l,
> > +                     unsigned long start, kho_radix_tree_walk_callback=
_t cb);
> > +
>
> ...
>
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kex=
ec_handover.c
> > index a180b3367e8f..81bac82c8672 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -66,155 +68,302 @@ static int __init kho_parse_enable(char *p)
> >  early_param("kho", kho_parse_enable);
>
> ...
>
> >  struct kho_mem_track {
> > -     /* Points to kho_mem_phys, each order gets its own bitmap tree */
> > -     struct xarray orders;
> > +     struct kho_radix_node *root;
> > +     struct rw_semaphore sem;
>
> It does not look like we have concurrent readers, why choose rw_semaphore
> and not mutex?
>

Yes, we currently do not have concurrent readers, I have updated to
use a mutex. In the future when we support parallel tree accessing we
can extend this to rw_semaphore.

> >  };
> >
> > -struct khoser_mem_chunk;
> > -
> >  struct kho_out {
> > -     void *fdt;
> > -     bool finalized;
>
> The next patch removes finalization, probably removing the finalized fiel=
d
> should be done there.

All finalization related updates are grouped to the next patch.

>
> > -     struct mutex lock; /* protects KHO FDT finalization */
> > -
> >       struct kho_mem_track track;
> > +     void *fdt;
> > +     struct mutex lock; /* protects KHO FDT */
>
> Please don't move the fields around.
> And while the update of the comment is correct, it seems to me rather a
> part of the next patch.
>
> >       struct kho_debugfs dbg;
> >  };
> >
> >  static struct kho_out kho_out =3D {
> > -     .lock =3D __MUTEX_INITIALIZER(kho_out.lock),
> >       .track =3D {
> > -             .orders =3D XARRAY_INIT(kho_out.track.orders, 0),
> > +             .sem =3D __RWSEM_INITIALIZER(kho_out.track.sem),
> >       },
> > -     .finalized =3D false,
> > +     .lock =3D __MUTEX_INITIALIZER(kho_out.lock),
>
> Please don't to move fields.
>
> >  };
> >
> > -static void *xa_load_or_alloc(struct xarray *xa, unsigned long index)
> > +/**
> > + * kho_radix_encode_key - Encodes a physical address and order into a =
radix key.
> > + * @pa: The physical address of the page.
> > + * @order: The order of the page.
> > + *
> > + * This function combines a page's physical address and its order into=
 a
> > + * single unsigned long, which is used as a key for all radix tree
> > + * operations.
> > + *
> > + * Return: The encoded unsigned long key.
> > + */
> > +unsigned long kho_radix_encode_key(phys_addr_t pa, unsigned int order)
> >  {
> > -     void *res =3D xa_load(xa, index);
> > +     /* Order bits part */
> > +     unsigned long h =3D 1UL << (KHO_ORDER_0_LG2 - order);
> > +     /* Page offset part */
> > +     unsigned long l =3D pa >> (PAGE_SHIFT + order);
> >
> > -     if (res)
> > -             return res;
> > +     return h | l;
> > +}
> > +EXPORT_SYMBOL_GPL(kho_radix_encode_key);
> >
> > -     void *elm __free(free_page) =3D (void *)get_zeroed_page(GFP_KERNE=
L);
> > +/**
> > + * kho_radix_decode_key - Decodes a radix key back into a physical add=
ress and order.
> > + * @radix_key: The unsigned long key to decode.
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
> > +phys_addr_t kho_radix_decode_key(unsigned long radix_key,
> > +                              unsigned int *order)
> > +{
> > +     unsigned int order_bit =3D fls64(radix_key);
> > +     phys_addr_t pa;
> >
> > -     if (!elm)
> > -             return ERR_PTR(-ENOMEM);
> > +     /* order_bit is numbered starting at 1 from fls64 */
> > +     *order =3D KHO_ORDER_0_LG2 - order_bit + 1;
> > +     /* The order is discarded by the shift */
> > +     pa =3D radix_key << (PAGE_SHIFT + *order);
> >
> > -     if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), PAGE_SIZE)))
> > -             return ERR_PTR(-EINVAL);
> > +     return pa;
> > +}
> > +EXPORT_SYMBOL_GPL(kho_radix_decode_key);
>
> Please make kho_radix_encode_key() and kho_radix_decode_key() static.
>
> > +
> > +static unsigned long kho_radix_get_index(unsigned long radix_key,
> > +                                      unsigned int level)
> > +{
> > +     int s;
> >
> > -     res =3D xa_cmpxchg(xa, index, NULL, elm, GFP_KERNEL);
> > -     if (xa_is_err(res))
> > -             return ERR_PTR(xa_err(res));
> > -     else if (res)
> > -             return res;
> > +     if (level =3D=3D 0)
> > +             return radix_key % (1 << KHO_BITMAP_SIZE_LG2);
>
> I'd split this to
>
> static unsigned long kho_get_radix_bitmap_index(unsigned long key);

Sure, as we already have a function to handle the leaf level walking.

>
> >
> > -     return no_free_ptr(elm);
> > +     s =3D ((level - 1) * KHO_TABLE_SIZE_LG2) + KHO_BITMAP_SIZE_LG2;
> > +     return (radix_key >> s) % (1 << KHO_TABLE_SIZE_LG2);
> >  }
> >
> > -static void __kho_unpreserve_order(struct kho_mem_track *track, unsign=
ed long pfn,
> > -                                unsigned int order)
> > +/**
> > + * kho_radix_add_page - Marks a page as preserved in the radix tree.
> > + * @root: The root of the radix tree.
> > + * @pfn: The page frame number of the page to preserve.
> > + * @order: The order of the page.
> > + *
> > + * This function traverses the radix tree based on the key derived fro=
m @pfn
> > + * and @order. It sets the corresponding bit in the leaf bitmap to mar=
k the
> > + * page for preservation. If intermediate nodes do not exist along the=
 path,
> > + * they are allocated and added to the tree.
> > + *
> > + * Return: 0 on success, or a negative error code on failure.
> > + */
> > +int kho_radix_add_page(struct kho_radix_node *root,
> > +                    unsigned long pfn, unsigned int order)
> >  {
> > -     struct kho_mem_phys_bits *bits;
> > -     struct kho_mem_phys *physxa;
> > -     const unsigned long pfn_high =3D pfn >> order;
> > +     phys_addr_t pa =3D PFN_PHYS(pfn);
> > +     unsigned long radix_key =3D kho_radix_encode_key(pa, order);
>
> pa seems unused elsewhere, you can just put PFN_PHYS() into
> kho_radix_encode_key().
> And radix_ prefix for the key seems redundant to me.
>
> > +     struct kho_radix_node *node;
> > +     struct kho_radix_leaf *leaf;
> > +     unsigned int i, idx;
> > +     int err =3D 0;
> >
> > -     physxa =3D xa_load(&track->orders, order);
> > -     if (WARN_ON_ONCE(!physxa))
> > -             return;
> > +     /*
> > +      * This array stores pointers to newly allocated intermediate rad=
ix tree
> > +      * nodes along the insertion path. In case of an error during nod=
e
> > +      * allocation or insertion, these stored pointers are used to fre=
e
> > +      * the partially allocated path, preventing memory leaks.
> > +      */
> > +     struct kho_radix_node *intermediate_nodes[KHO_TREE_MAX_DEPTH] =3D=
 { 0 };
>
> Let's try keeping declarations in reverse xmas tree order. This long line
> can be the first declaration.
> And I don't think this array deserves such a long comment, it's quite
> obvious why it's needed.
>
> >
> > -     bits =3D xa_load(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
> > -     if (WARN_ON_ONCE(!bits))
> > -             return;
> > +     might_sleep();
> >
> > -     clear_bit(pfn_high % PRESERVE_BITS, bits->preserve);
> > +     node =3D root;
> > +
> > +     /* Go from high levels to low levels */
> > +     for (i =3D KHO_TREE_MAX_DEPTH - 1; i > 0; i--) {
> > +             idx =3D kho_radix_get_index(radix_key, i);
> > +
> > +             if (node->table[idx]) {
> > +                     node =3D phys_to_virt((phys_addr_t)node->table[id=
x]);
>
> Is casting to phys_addr_t required?
> We should have an assert that verifies that phys_addr_t and u64 have the
> same size somewhere, otherwise everything falls apart anyway.
>
> > +                     continue;
> > +             }
> > +
> > +             /* Next node is empty, create a new node for it */
> > +             struct kho_radix_node *new_tree;
>
> Please don't mix declarations and code unless strictly necessary.
> And new_node seems a more appropriate name here.
>
> > +
> > +             new_tree =3D (struct kho_radix_node *)get_zeroed_page(GFP=
_KERNEL);
> > +             if (!new_tree) {
> > +                     err =3D -ENOMEM;
> > +                     goto err_free_alloc_nodes;
>
> This reads to me like "on error free and allocate nodes". err_free_nodes
> sounds a better name.
>

I was thinking, "When an error occurs, free the allocated nodes" =3D).
But I agree err_free_nodes is a better one.

> > +             }
> > +
> > +             node->table[idx] =3D virt_to_phys(new_tree);
> > +             node =3D new_tree;
> > +
> > +             intermediate_nodes[i] =3D new_tree;
> > +     }
> > +
> > +     /* Handle the leaf level bitmap (level 0) */
> > +     idx =3D kho_radix_get_index(radix_key, 0);
> > +     leaf =3D (struct kho_radix_leaf *)node;
> > +     __set_bit(idx, leaf->bitmap);
> > +
> > +     return 0;
> > +
> > +err_free_alloc_nodes:
> > +     for (i =3D KHO_TREE_MAX_DEPTH - 1; i > 0; i--) {
> > +             if (intermediate_nodes[i])
> > +                     free_page((unsigned long)intermediate_nodes[i]);
> > +     }
> > +
> > +     return err;
> >  }
> > +EXPORT_SYMBOL_GPL(kho_radix_add_page);
> >
> > -static void __kho_unpreserve(struct kho_mem_track *track, unsigned lon=
g pfn,
> > -                          unsigned long end_pfn)
> > +/**
> > + * kho_radix_del_page - Removes a page's preservation status from the =
radix tree.
> > + * @root: The root of the radix tree.
> > + * @pfn: The page frame number of the page to unpreserve.
> > + * @order: The order of the page.
> > + *
> > + * This function traverses the radix tree and clears the bit correspon=
ding to
> > + * the page, effectively removing its "preserved" status. It does not =
free
> > + * the tree's intermediate nodes, even if they become empty.
> > + */
> > +void kho_radix_del_page(struct kho_radix_node *root, unsigned long pfn=
,
> > +                     unsigned int order)
> >  {
> > -     unsigned int order;
> > +     unsigned long radix_key =3D kho_radix_encode_key(PFN_PHYS(pfn), o=
rder);
> > +     unsigned int tree_level =3D KHO_TREE_MAX_DEPTH - 1;
> > +     struct kho_radix_node *node;
> > +     struct kho_radix_leaf *leaf;
> > +     unsigned int i, idx;
> >
> > -     while (pfn < end_pfn) {
> > -             order =3D min(count_trailing_zeros(pfn), ilog2(end_pfn - =
pfn));
> > +     might_sleep();
> >
> > -             __kho_unpreserve_order(track, pfn, order);
> > +     node =3D root;
>
> This can be done at declaration spot.
>
> >
> > -             pfn +=3D 1 << order;
> > +     /* Go from high levels to low levels */
> > +     for (i =3D tree_level; i > 0; i--) {
>
> tree_level seems unnecessary, just use KHO_TREE_MAX_DEPTH - 1.
>
> > +             idx =3D kho_radix_get_index(radix_key, i);
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
> > +                     node =3D phys_to_virt((phys_addr_t)node->table[id=
x]);
> >       }
> > +
> > +     /* Handle the leaf level bitmap (level 0) */
> > +     leaf =3D (struct kho_radix_leaf *)node;
>
> idx should be updated here for level 0.

Yes, thanks for catching this.

>
> > +     __clear_bit(idx, leaf->bitmap);
> >  }
> > +EXPORT_SYMBOL_GPL(kho_radix_del_page);
>
> ...
>
> > +
> > +/**
> > + * kho_radix_walk_tree - Traverses the radix tree and calls a callback=
 for each preserved page.
> > + * @root: A pointer to the root node of the radix tree to walk.
> > + * @level: The starting level for the walk (typically KHO_TREE_MAX_DEP=
TH - 1).
> > + * @start: The initial key prefix for the walk (typically 0).
> > + * @cb: A callback function of type kho_radix_tree_walk_callback_t tha=
t will be
> > + *      invoked for each preserved page found in the tree. The callbac=
k receives
> > + *      the full radix key of the preserved page.
> > + *
> > + * This function walks the radix tree, searching from the specified to=
p level
> > + * (@level) down to the lowest level (level 0). For each preserved pag=
e found,
> > + * it invokes the provided callback, passing the page's fully reconstr=
ucted
> > + * radix key.
> > + *
> > + * Return: 0 if the walk completed the specified subtree, or the non-z=
ero return
> > + *         value from the callback that stopped the walk.
> > + */
> > +int kho_radix_walk_tree(struct kho_radix_node *root, unsigned int leve=
l,
> > +                     unsigned long start, kho_radix_tree_walk_callback=
_t cb)
> > +{
> > +     struct kho_radix_node *node;
> > +     struct kho_radix_leaf *leaf;
> > +     unsigned long radix_key, i;
> > +     int err;
> >
> > -             new_physxa =3D kzalloc(sizeof(*physxa), GFP_KERNEL);
> > -             if (!new_physxa)
> > -                     return -ENOMEM;
> > +     for (i =3D 0; i < PAGE_SIZE / sizeof(phys_addr_t); i++) {
> > +             if (!root->table[i])
> > +                     continue;
> > +
> > +             unsigned int shift;
>
> Please don't mix declarations and code unless strictly necessary.
>
> >
> > -             xa_init(&new_physxa->phys_bits);
> > -             physxa =3D xa_cmpxchg(&track->orders, order, NULL, new_ph=
ysxa,
> > -                                 GFP_KERNEL);
> > +             shift =3D ((level - 1) * KHO_TABLE_SIZE_LG2) +
> > +                     KHO_BITMAP_SIZE_LG2;
> > +             radix_key =3D start | (i << shift);
> >
> > -             err =3D xa_err(physxa);
> > -             if (err || physxa) {
> > -                     xa_destroy(&new_physxa->phys_bits);
> > -                     kfree(new_physxa);
> > +             node =3D phys_to_virt((phys_addr_t)root->table[i]);
> >
> > +             if (level > 1) {
> > +                     err =3D kho_radix_walk_tree(node, level - 1,
> > +                                               radix_key, cb);
> >                       if (err)
> >                               return err;
> >               } else {
> > -                     physxa =3D new_physxa;
> > +                     /*
> > +                      * we are at level 1,
> > +                      * node is pointing to the level 0 bitmap.
> > +                      */
> > +                     leaf =3D (struct kho_radix_leaf *)node;
> > +                     return kho_radix_walk_leaf(leaf, radix_key, cb);
>
> I'd inverse the if:
>
>                 if (!level)
>                         return kho_radix_walk_leaf();
>
>                 err  =3D kho_radix_walk_tree()
>

I think we want to check if we are at level 1 so we can just walk the
leaf level (level 0). I have updated the branching order.

>
> >               }
> >       }
> >
> > -     bits =3D xa_load_or_alloc(&physxa->phys_bits, pfn_high / PRESERVE=
_BITS);
> > -     if (IS_ERR(bits))
> > -             return PTR_ERR(bits);
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(kho_radix_walk_tree);
> > +
>
> Feels like an extra empty line is added here. Please drop it.
>
> >
> > -     set_bit(pfn_high % PRESERVE_BITS, bits->preserve);
> >
> > -     return 0;
> > +static void __kho_unpreserve(unsigned long pfn, unsigned long end_pfn)
>
> The change of __kho_unpreserve() signature does not belong to this patch.
> If you feel strongly this change is justified make it a preparation patch
> before the radix tree changes.
>

__kho_unpreserve() is no longer takes "struct kho_mem_track" because
it is replaced by "struct kho_radix_tree", see below. So this change
will be a part of this patch.

> > +{
> > +     struct kho_mem_track *track =3D &kho_out.track;
> > +     unsigned int order;
> > +
> > +     if (WARN_ON_ONCE(!track->root))
> > +             return;
> > +
> > +     down_write(&track->sem);
> > +     while (pfn < end_pfn) {
> > +             order =3D min(count_trailing_zeros(pfn), ilog2(end_pfn - =
pfn));
> > +
> > +             kho_radix_del_page(track->root, pfn, order);
>
> If we are going to expose radix tree APIs, it would make sense for them t=
o
> take care of the locking internally.
>
> For that we might need something like
>
> struct kho_radix_tree {
>         struct kho_radix_node *root;
>         struct mutex lock;
> };
>
> and use the root struct as the parameter to kho_radix APIs.
>

I think having the API handle the lock internally is a good idea. This
means we need to expose this "struct kho_radix_tree" as a part of the
public API. Previously "struct kho_mem_track" did the same thing but
just for kexec_handover.c internal use. I renamed it to "struct
kho_radix_tree" and moved it to the public kho_radix_tree.h header so
the clients can use it.

> > +
> > +             pfn +=3D 1 << order;
> > +     }
> > +     up_write(&track->sem);
> >  }
>
> ...
>
> > -static void kho_update_memory_map(struct khoser_mem_chunk *first_chunk=
)
> > +static int __init kho_radix_walk_tree_memblock_callback(unsigned long =
radix_key)
>
> This name is much about being a callback for walking the tree and very
> little about what the function does. It should be the other way around.

I renamed it to "kho_radix_memblock_reserve()", hope this makes more sense.

> >  {
> > +     union kho_page_info info;
> > +     unsigned int order;
> > +     unsigned long pa;
>
> In the most places we use 'phys_addr_t phys' for physical addresses.
>
> > +     struct page *page;
> > +     int sz;
> >
> > +     pa =3D kho_radix_decode_key(radix_key, &order);
> >
> > +     sz =3D 1 << (order + PAGE_SHIFT);
> > +     page =3D phys_to_page(pa);
> >
> > +     /* Reserve the memory preserved in KHO radix tree in memblock */
> > +     memblock_reserve(pa, sz);
> > +     memblock_reserved_mark_noinit(pa, sz);
> > +     info.magic =3D KHO_PAGE_MAGIC;
> > +     info.order =3D order;
> > +     page->private =3D info.page_private;
> >
> >       return 0;
> >  }
> >
> >
> >
>
> Too many empty lines here.
>
> >  /*
> >   * With KHO enabled, memory can become fragmented because KHO regions =
may
> > @@ -789,14 +774,22 @@ EXPORT_SYMBOL_GPL(kho_remove_subtree);
> >   */
> >  int kho_preserve_folio(struct folio *folio)
> >  {
> > +     struct kho_mem_track *track =3D &kho_out.track;
> >       const unsigned long pfn =3D folio_pfn(folio);
> >       const unsigned int order =3D folio_order(folio);
> > -     struct kho_mem_track *track =3D &kho_out.track;
> > +     int err;
> >
> >       if (WARN_ON(kho_scratch_overlap(pfn << PAGE_SHIFT, PAGE_SIZE << o=
rder)))
> >               return -EINVAL;
> >
> > -     return __kho_preserve_order(track, pfn, order);
> > +     if (WARN_ON_ONCE(!track->root))
> > +             return -EINVAL;
>
> Can we move this to kho_radix_add_page() and kho_radix_del_page()?
> I see that some preserve/unpreserve methods WARN and some don't.
>

yes, the root pointer checking and warning are moved into those radix
tree public functions.

> > +
> > +     down_write(&track->sem);
> > +     err =3D kho_radix_add_page(track->root, pfn, order);
> > +     up_write(&track->sem);
> > +
> > +     return err;
> >  }
> >  EXPORT_SYMBOL_GPL(kho_preserve_folio);
>
> ...
>
> > @@ -1213,25 +1214,12 @@ EXPORT_SYMBOL_GPL(kho_restore_free);
> >
> >  int kho_finalize(void)
> >  {
> > -     int ret;
> > -
> > -     if (!kho_enable)
> > -             return -EOPNOTSUPP;
> > -
> > -     guard(mutex)(&kho_out.lock);
> > -     ret =3D kho_mem_serialize(&kho_out);
> > -     if (ret)
> > -             return ret;
> > -
> > -     kho_out.finalized =3D true;
> > -
> >       return 0;
> >  }
> >
> >  bool kho_finalized(void)
> >  {
> > -     guard(mutex)(&kho_out.lock);
> > -     return kho_out.finalized;
> > +     return false;
>
> Most of the finalization changes belong to the next patch IMO.
>
> >  }
> >
> >  struct kho_in {
> > @@ -1304,18 +1292,49 @@ int kho_retrieve_subtree(const char *name, phys=
_addr_t *phys)
> >  }
> >  EXPORT_SYMBOL_GPL(kho_retrieve_subtree);
> >
> > +/* Return non-zero if error */
>
> That's what 99% of the kernel does, no need to comment about it.
>
> >  static __init int kho_out_fdt_setup(void)
> >  {
> > +     struct kho_mem_track *track =3D &kho_out.track;
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
> > +     down_read(&track->sem);
> > +     preserved_mem_tree_pa =3D (u64)virt_to_phys(track->root);
> > +     up_read(&track->sem);
>
> It seems to be the only place that uses down_read(). So we actually don't
> have concurrent readers. Let's just use a mutex.
>
> > +
> > +     err |=3D fdt_property(root, KHO_FDT_MEMORY_MAP_PROP_NAME,
> > +                         &preserved_mem_tree_pa,
> > +                         sizeof(preserved_mem_tree_pa));
> > +
> >       err |=3D fdt_end_node(root);
> >       err |=3D fdt_finish(root);
> >
> > @@ -1324,16 +1343,26 @@ static __init int kho_out_fdt_setup(void)
> >
> >  static __init int kho_init(void)
> >  {
> > +     struct kho_mem_track *track =3D &kho_out.track;
> >       const void *fdt =3D kho_get_fdt();
> >       int err =3D 0;
> >
> >       if (!kho_enable)
> >               return 0;
> >
> > +     down_write(&track->sem);
> > +     track->root =3D (struct kho_radix_node *)
> > +             kzalloc(PAGE_SIZE, GFP_KERNEL);
> > +     up_write(&track->sem);
> > +     if (!track->root) {
> > +             err =3D -ENOMEM;
> > +             goto err_free_scratch;
> > +     }
> > +
> >       kho_out.fdt =3D kho_alloc_preserve(PAGE_SIZE);
> >       if (IS_ERR(kho_out.fdt)) {
> >               err =3D PTR_ERR(kho_out.fdt);
> > -             goto err_free_scratch;
> > +             goto err_free_kho_radix_tree_root;
> >       }
> >
> >       err =3D kho_debugfs_init();
> > @@ -1379,6 +1408,11 @@ static __init int kho_init(void)
> >
> >  err_free_fdt:
> >       kho_unpreserve_free(kho_out.fdt);
> > +
> > +err_free_kho_radix_tree_root:
> > +     kfree(track->root);
> > +     track->root =3D NULL;
> > +
>
> No need for empty lines around the error handling
>
> >  err_free_scratch:
> >       kho_out.fdt =3D NULL;
> >       for (int i =3D 0; i < kho_scratch_cnt; i++) {
> > @@ -1422,7 +1456,7 @@ void __init kho_memory_init(void)
> >               kho_scratch =3D phys_to_virt(kho_in.scratch_phys);
> >               kho_release_scratch();
> >
> > -             if (!kho_mem_deserialize(kho_get_fdt()))
> > +             if (kho_mem_retrieve(kho_get_fdt()))
> >                       kho_in.fdt_phys =3D 0;
> >       } else {
> >               kho_reserve_scratch();
>
> --
> Sincerely yours,
> Mike.


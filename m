Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FD7CAC59B
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 20:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wg66ytqT5gW0pLgpcFNtD+RmpG9kakagwaMvlSmeZ+A=; b=J3yWj4pgCt50dpRsjRtbWu5Mnq
	udTtZCoBMW7bcRY3JzdI+afAiWe/QpMJmIOSlqhfRkzyo3QQj/f7KuKfvJ7NkWDqITZmvgp04+Ozs
	vEzIlfHXYxy0J3ed+21SCyGAuQcNd4YosfUCkh/IO9Gdl3cQaz0hRhJoKmZo/9yNFQVhO8HVgZlfv
	kT/Y3/QiGV2NSFgHN13Di5lbUbUeEDxvZrcTobMJ3htPnPLSXfsjTKYozK3m9ya7sHvNoGU4oeRU2
	l0xVKYF3HWSyz/9yhlX5fzfHM7sygIm+Y1DZGOJQ7sDb1Rr99cJFnA7RGwXL1VEWJxUpH5scb5D4/
	NSkpEmDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uybye-00000008xWY-1tDs;
	Tue, 16 Sep 2025 20:08:36 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw1T0-00000008cqi-14Rb
	for kexec@lists.infradead.org;
	Tue, 09 Sep 2025 16:45:15 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-61cfbb21fd1so255a12.0
        for <kexec@lists.infradead.org>; Tue, 09 Sep 2025 09:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757436312; x=1758041112; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wg66ytqT5gW0pLgpcFNtD+RmpG9kakagwaMvlSmeZ+A=;
        b=vrGnZiK70LGLeW9DhA73RU20Y2ZkkXbHSONWtQqaFKLgyfEos1kii0wudSgxG80FBD
         Nj7pPgbWHQkjIVGb6i4Z5CS9a5R3N1iE5yI3WpmePRc73m5rUECnWM6MCJYkgiInl7AV
         OamLwlpkNiMqaN4Qlcg6buqhnSSnq7iLOrCnt1SHsUCApX7BAnRgy93QU2vsq05zTb3J
         xhTUVaBLPbC0VYIUWAF7LnIOFzPmiTCMNotmvBR3eFXwH8LMS/BNmZxT8pdzgBSfIwjH
         4ANd9G8sRQEI5jPyKoUXAHoPRjUBzYNMPydvXGM41ev+Zap2kBMKsSDxPbuPvBEXuHEP
         KhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757436312; x=1758041112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wg66ytqT5gW0pLgpcFNtD+RmpG9kakagwaMvlSmeZ+A=;
        b=rD2StExb1xPp72VW5ENMZoQJz6+5cFgYCN21d8CDGgq0fuiaAG0NM+MoKu5MuC1fYm
         xtefk8oIRLN/XkCbE40H5tGZvYNJ5afUBIjZK1voTlWlJoDONp80CNsotSz7z1v5N07Z
         G4d1k1JhctQYUSr2vWA/afWfThiM+oIFPq0wy0cqKp1Yi8cDpBYAE/BMS+3l55H90kgK
         4vIqPPc09agrBVNjgSuthOk9YX68JQKZxXZPiiVELxaZ7JAW/eG9lOemIHSXWiW56Hi1
         qmsUTxyBoAHzCZqS+nQqlhJZx2fvOHxCdBIEstFrWSAD6geIOvcz+/2VEG3S5SZ3sk+A
         A7WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr1BtoDYgziJhN2w8a9gRxBhMJHEADuJarefCM53MElxLwYOttOPIyQE8T9NLbp3gKNwM7Kw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwtCAA6Qv9kqDigGP8DstuzCnhttExwvx5R9+5AszjRwE4pcahK
	zox3GpbHJ7FWXdw+DltJGDUi5p6I5LVRj7DjsZajWtcpcHUjo7OBngkCoOrt9Sz8A3Q3uyWrSRd
	hscVxlolNBaWwJRS69/mHImVIweNVd+caF6IbqQlD
X-Gm-Gg: ASbGncskY4GKKL8y7KuddXoM9Y9AIEyncPSBdrsHEKMptNvAxS38hL5uerg+amX99T9
	H+xrrp+3Rk4VdeuN2qRMeYIOCgkXcnAGXtxTaBGKcaaP9tw+jN+Z7oogtqvsn6KFIZZ8h2ucZeS
	ite1IPHTCD2qEaparouzksPB84yb3hF7+7JxtUM+owoqjixUAInJaUYHJ4V9oaexFglFDaxHruE
	KZXtoJTzImbr/QoXOh+ydzRIixOO0WTiz42B0yfqGgn9RCdjQeeBk4=
X-Google-Smtp-Source: AGHT+IGPGk0qf/IiaeJSTR25Y6zNMAmob9Bf6pRZiB8Cz91tPx5tFvdw6FMK8xHuP6h0JHF887G6sd0LUCfFyNW1CIU=
X-Received: by 2002:a05:6402:d60:b0:61c:d36d:218c with SMTP id
 4fb4d7f45d1cf-6234d3ee779mr242645a12.0.1757436311257; Tue, 09 Sep 2025
 09:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com> <ea1a5ab9fff7330b69f0b97c123ec95308818c98.1757329751.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <ea1a5ab9fff7330b69f0b97c123ec95308818c98.1757329751.git.lorenzo.stoakes@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 9 Sep 2025 09:44:58 -0700
X-Gm-Features: AS18NWD_8AWrPfmI0tsMVHUiuAGzDjgerBQcQZeWasEIUA51d1DPsE14BgjCaGA
Message-ID: <CAJuCfpFr+vMowHzAs7QDwMmNvS4RMJg0xqXkYAxBLCKh1wdAmQ@mail.gmail.com>
Subject: Re: [PATCH 06/16] mm: introduce the f_op->mmap_complete, mmap_abort hooks
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Matthew Wilcox <willy@infradead.org>, Guo Ren <guoren@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	"David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Nicolas Pitre <nico@fluxnic.net>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@redhat.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Baoquan He <bhe@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Dave Martin <Dave.Martin@arm.com>, 
	James Morse <james.morse@arm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-mm@kvack.org, ntfs3@lists.linux.dev, kexec@lists.infradead.org, 
	kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250909_094514_455006_6088FC3C 
X-CRM114-Status: GOOD (  49.68  )
X-Mailman-Approved-At: Tue, 16 Sep 2025 13:07:58 -0700
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

On Mon, Sep 8, 2025 at 4:11=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> We have introduced the f_op->mmap_prepare hook to allow for setting up a
> VMA far earlier in the process of mapping memory, reducing problematic
> error handling paths, but this does not provide what all
> drivers/filesystems need.
>
> In order to supply this, and to be able to move forward with removing
> f_op->mmap altogether, introduce f_op->mmap_complete.
>
> This hook is called once the VMA is fully mapped and everything is done,
> however with the mmap write lock and VMA write locks held.
>
> The hook is then provided with a fully initialised VMA which it can do wh=
at
> it needs with, though the mmap and VMA write locks must remain held
> throughout.
>
> It is not intended that the VMA be modified at this point, attempts to do
> so will end in tears.
>
> This allows for operations such as pre-population typically via a remap, =
or
> really anything that requires access to the VMA once initialised.
>
> In addition, a caller may need to take a lock in mmap_prepare, when it is
> possible to modify the VMA, and release it on mmap_complete. In order to
> handle errors which may arise between the two operations, f_op->mmap_abor=
t
> is provided.
>
> This hook should be used to drop any lock and clean up anything before th=
e
> VMA mapping operation is aborted. After this point the VMA will not be
> added to any mapping and will not exist.
>
> We also add a new mmap_context field to the vm_area_desc type which can b=
e
> used to pass information pertinent to any locks which are held or any sta=
te
> which is required for mmap_complete, abort to operate correctly.
>
> We also update the compatibility layer for nested filesystems which
> currently still only specify an f_op->mmap() handler so that it correctly
> invokes f_op->mmap_complete as necessary (note that no error can occur
> between mmap_prepare and mmap_complete so mmap_abort will never be called
> in this case).
>
> Also update the VMA tests to account for the changes.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/fs.h               |  4 ++
>  include/linux/mm_types.h         |  5 ++
>  mm/util.c                        | 18 +++++--
>  mm/vma.c                         | 82 ++++++++++++++++++++++++++++++--
>  tools/testing/vma/vma_internal.h | 31 ++++++++++--
>  5 files changed, 129 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 594bd4d0521e..bb432924993a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2195,6 +2195,10 @@ struct file_operations {
>         int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_bat=
ch *,
>                                 unsigned int poll_flags);
>         int (*mmap_prepare)(struct vm_area_desc *);
> +       int (*mmap_complete)(struct file *, struct vm_area_struct *,
> +                            const void *context);
> +       void (*mmap_abort)(const struct file *, const void *vm_private_da=
ta,
> +                          const void *context);
>  } __randomize_layout;
>
>  /* Supports async buffered reads */
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index cf759fe08bb3..052db1f31fb3 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -793,6 +793,11 @@ struct vm_area_desc {
>         /* Write-only fields. */
>         const struct vm_operations_struct *vm_ops;
>         void *private_data;
> +       /*
> +        * A user-defined field, value will be passed to mmap_complete,
> +        * mmap_abort.
> +        */
> +       void *mmap_context;
>  };
>
>  /*
> diff --git a/mm/util.c b/mm/util.c
> index 248f877f629b..f5bcac140cb9 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1161,17 +1161,26 @@ int __compat_vma_mmap_prepare(const struct file_o=
perations *f_op,
>         err =3D f_op->mmap_prepare(&desc);
>         if (err)
>                 return err;
> +
>         set_vma_from_desc(vma, &desc);
>
> -       return 0;
> +       /*
> +        * No error can occur between mmap_prepare() and mmap_complete so=
 no
> +        * need to invoke mmap_abort().
> +        */
> +
> +       if (f_op->mmap_complete)
> +               err =3D f_op->mmap_complete(file, vma, desc.mmap_context)=
;
> +
> +       return err;
>  }
>  EXPORT_SYMBOL(__compat_vma_mmap_prepare);
>
>  /**
>   * compat_vma_mmap_prepare() - Apply the file's .mmap_prepare() hook to =
an
> - * existing VMA.
> + * existing VMA and invoke .mmap_complete() if provided.
>   * @file: The file which possesss an f_op->mmap_prepare() hook.

nit: possesss seems to be misspelled. Maybe we can fix it here as well?

> - * @vma: The VMA to apply the .mmap_prepare() hook to.
> + * @vma: The VMA to apply the hooks to.
>   *
>   * Ordinarily, .mmap_prepare() is invoked directly upon mmap(). However,=
 certain
>   * stacked filesystems invoke a nested mmap hook of an underlying file.
> @@ -1188,6 +1197,9 @@ EXPORT_SYMBOL(__compat_vma_mmap_prepare);
>   * establishes a struct vm_area_desc descriptor, passes to the underlyin=
g
>   * .mmap_prepare() hook and applies any changes performed by it.
>   *
> + * If the relevant hooks are provided, it also invokes .mmap_complete() =
upon
> + * successful completion.
> + *
>   * Once the conversion of filesystems is complete this function will no =
longer
>   * be required and will be removed.
>   *
> diff --git a/mm/vma.c b/mm/vma.c
> index 0efa4288570e..a0b568fe9e8d 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -22,6 +22,7 @@ struct mmap_state {
>         /* User-defined fields, perhaps updated by .mmap_prepare(). */
>         const struct vm_operations_struct *vm_ops;
>         void *vm_private_data;
> +       void *mmap_context;
>
>         unsigned long charged;
>
> @@ -2343,6 +2344,23 @@ static int __mmap_prelude(struct mmap_state *map, =
struct list_head *uf)
>         int error;
>         struct vma_iterator *vmi =3D map->vmi;
>         struct vma_munmap_struct *vms =3D &map->vms;
> +       struct file *file =3D map->file;
> +
> +       if (file) {
> +               /* f_op->mmap_complete requires f_op->mmap_prepare. */
> +               if (file->f_op->mmap_complete && !file->f_op->mmap_prepar=
e)
> +                       return -EINVAL;
> +
> +               /*
> +                * It's not valid to provide an f_op->mmap_abort hook wit=
hout also
> +                * providing the f_op->mmap_prepare and f_op->mmap_comple=
te hooks it is
> +                * used with.
> +                */
> +               if (file->f_op->mmap_abort &&
> +                    (!file->f_op->mmap_prepare ||
> +                     !file->f_op->mmap_complete))
> +                       return -EINVAL;
> +       }
>
>         /* Find the first overlapping VMA and initialise unmap state. */
>         vms->vma =3D vma_find(vmi, map->end);
> @@ -2595,6 +2613,7 @@ static int call_mmap_prepare(struct mmap_state *map=
)
>         /* User-defined fields. */
>         map->vm_ops =3D desc.vm_ops;
>         map->vm_private_data =3D desc.private_data;
> +       map->mmap_context =3D desc.mmap_context;
>
>         return 0;
>  }
> @@ -2636,16 +2655,61 @@ static bool can_set_ksm_flags_early(struct mmap_s=
tate *map)
>         return false;
>  }
>
> +/*
> + * Invoke the f_op->mmap_complete hook, providing it with a fully initia=
lised
> + * VMA to operate upon.
> + *
> + * The mmap and VMA write locks must be held prior to and after the hook=
 has
> + * been invoked.
> + */
> +static int call_mmap_complete(struct mmap_state *map, struct vm_area_str=
uct *vma)
> +{
> +       struct file *file =3D map->file;
> +       void *context =3D map->mmap_context;
> +       int error;
> +       size_t len;
> +
> +       if (!file || !file->f_op->mmap_complete)
> +               return 0;
> +
> +       error =3D file->f_op->mmap_complete(file, vma, context);
> +       /* The hook must NOT drop the write locks. */
> +       vma_assert_write_locked(vma);
> +       mmap_assert_write_locked(current->mm);
> +       if (!error)
> +               return 0;
> +
> +       /*
> +        * If an error occurs, unmap the VMA altogether and return an err=
or. We
> +        * only clear the newly allocated VMA, since this function is onl=
y
> +        * invoked if we do NOT merge, so we only clean up the VMA we cre=
ated.
> +        */
> +       len =3D vma_pages(vma) << PAGE_SHIFT;
> +       do_munmap(current->mm, vma->vm_start, len, NULL);
> +       return error;
> +}
> +
> +static void call_mmap_abort(struct mmap_state *map)
> +{
> +       struct file *file =3D map->file;
> +       void *vm_private_data =3D map->vm_private_data;
> +
> +       VM_WARN_ON_ONCE(!file || !file->f_op);
> +       file->f_op->mmap_abort(file, vm_private_data, map->mmap_context);
> +}
> +
>  static unsigned long __mmap_region(struct file *file, unsigned long addr=
,
>                 unsigned long len, vm_flags_t vm_flags, unsigned long pgo=
ff,
>                 struct list_head *uf)
>  {
> -       struct mm_struct *mm =3D current->mm;
> -       struct vm_area_struct *vma =3D NULL;
> -       int error;
>         bool have_mmap_prepare =3D file && file->f_op->mmap_prepare;
> +       bool have_mmap_abort =3D file && file->f_op->mmap_abort;
> +       struct mm_struct *mm =3D current->mm;
>         VMA_ITERATOR(vmi, mm, addr);
>         MMAP_STATE(map, mm, &vmi, addr, len, pgoff, vm_flags, file);
> +       struct vm_area_struct *vma =3D NULL;
> +       bool allocated_new =3D false;
> +       int error;
>
>         map.check_ksm_early =3D can_set_ksm_flags_early(&map);
>
> @@ -2668,8 +2732,12 @@ static unsigned long __mmap_region(struct file *fi=
le, unsigned long addr,
>         /* ...but if we can't, allocate a new VMA. */
>         if (!vma) {
>                 error =3D __mmap_new_vma(&map, &vma);
> -               if (error)
> +               if (error) {
> +                       if (have_mmap_abort)
> +                               call_mmap_abort(&map);
>                         goto unacct_error;
> +               }
> +               allocated_new =3D true;
>         }
>
>         if (have_mmap_prepare)
> @@ -2677,6 +2745,12 @@ static unsigned long __mmap_region(struct file *fi=
le, unsigned long addr,
>
>         __mmap_epilogue(&map, vma);
>
> +       if (allocated_new) {
> +               error =3D call_mmap_complete(&map, vma);
> +               if (error)
> +                       return error;
> +       }
> +
>         return addr;
>
>         /* Accounting was done by __mmap_prelude(). */
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_int=
ernal.h
> index 07167446dcf4..566cef1c0e0b 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -297,11 +297,20 @@ struct vm_area_desc {
>         /* Write-only fields. */
>         const struct vm_operations_struct *vm_ops;
>         void *private_data;
> +       /*
> +        * A user-defined field, value will be passed to mmap_complete,
> +        * mmap_abort.
> +        */
> +       void *mmap_context;
>  };
>
>  struct file_operations {
>         int (*mmap)(struct file *, struct vm_area_struct *);
>         int (*mmap_prepare)(struct vm_area_desc *);
> +       void (*mmap_abort)(const struct file *, const void *vm_private_da=
ta,
> +                          const void *context);
> +       int (*mmap_complete)(struct file *, struct vm_area_struct *,
> +                            const void *context);
>  };
>
>  struct file {
> @@ -1471,7 +1480,7 @@ static inline int __compat_vma_mmap_prepare(const s=
truct file_operations *f_op,
>  {
>         struct vm_area_desc desc =3D {
>                 .mm =3D vma->vm_mm,
> -               .file =3D vma->vm_file,
> +               .file =3D file,
>                 .start =3D vma->vm_start,
>                 .end =3D vma->vm_end,
>
> @@ -1485,13 +1494,21 @@ static inline int __compat_vma_mmap_prepare(const=
 struct file_operations *f_op,
>         err =3D f_op->mmap_prepare(&desc);
>         if (err)
>                 return err;
> +
>         set_vma_from_desc(vma, &desc);
>
> -       return 0;
> +       /*
> +        * No error can occur between mmap_prepare() and mmap_complete so=
 no
> +        * need to invoke mmap_abort().
> +        */
> +
> +       if (f_op->mmap_complete)
> +               err =3D f_op->mmap_complete(file, vma, desc.mmap_context)=
;
> +
> +       return err;
>  }
>
> -static inline int compat_vma_mmap_prepare(struct file *file,
> -               struct vm_area_struct *vma)
> +static inline int compat_vma_mmap_prepare(struct file *file, struct vm_a=
rea_struct *vma)
>  {
>         return __compat_vma_mmap_prepare(file->f_op, file, vma);
>  }
> @@ -1548,4 +1565,10 @@ static inline vm_flags_t ksm_vma_flags(const struc=
t mm_struct *, const struct fi
>         return vm_flags;
>  }
>
> +static inline int do_munmap(struct mm_struct *mm, unsigned long start, s=
ize_t len,
> +             struct list_head *uf)
> +{
> +       return 0;
> +}
> +
>  #endif /* __MM_VMA_INTERNAL_H */
> --
> 2.51.0
>


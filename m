Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98A3E63C8E
	for <kexec@archiver.kernel.org>; Sun, 25 Jan 2026 12:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iqNzYgcK682OGBzEU/mbNTmwKAsTKy2bpCfAaVM9lTw=; b=wn88bXfD5Nr7laMPIUVh35R6BT
	9w3/CqwKNVnO3chM+C+o2NdwZteB0LhTbSbojv8pTLRllfe7Gnd7NB0WQe+XfqQWGnwl0v4StGE2h
	U9VLv3lOFWHvBbYiYE6ThmO7NF3Jv4O6ubmohb6BOsIMS6n7XTUyc385E3P8jvVIfn6fo4mXTTurK
	IZ/Rpa8ozQD9+El1n5rInCuA9Jh0zOM1a1IYY3pZibaGdSRZA5xRi4tKlS+pf7xY11GjtbKbEcONT
	BfEqKr0fyLI69Lu/aA/Y0HOfuRC+ARefnNDZLd66Lzemy+Sex4NYxrpT1GFJUCPyR6iy5ZvOg718G
	duqtXyVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjyqC-0000000B9Mn-3CDc;
	Sun, 25 Jan 2026 12:03:40 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjyqA-0000000B9MM-0rSJ
	for kexec@lists.infradead.org;
	Sun, 25 Jan 2026 12:03:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 49EF242BB2;
	Sun, 25 Jan 2026 12:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4209AC4CEF1;
	Sun, 25 Jan 2026 12:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769342617;
	bh=VgoxmZlbv0mSVt43gxyu4AMX9q5s+p+eQWF9sR0Ddes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X4kzUMsFpCh/ex88C06+BH3I+aBZEdkYLS8o7XjZ7xGsN0h4N0RX6P76iOt2kl2vI
	 d0qIEYPI+bPyahOl9Y5rMTOzV4tk4scT80WhLCzBvK0IAytDzkk3piase1AAB3Q7YY
	 NSqGHdrlU6VItCS5c+sQwlkX2UCaAm6WDS4t8do5WQHuK1VDCr+cOVwP2ZgesTR+jf
	 QXWvdXxiKx+I6tlaqA2y8o9hmK5xn4BuHND6zQC/5JDluqBaffrJ4CPDctaSYm8e9t
	 tvl8SnaPQwhURaMNc6uD1DKZ+Ww3uY8qP8mpYksXUfxX/55ZiB9d8VR6hNxIQdLdMA
	 9Jy3wZK1W56oQ==
Date: Sun, 25 Jan 2026 14:03:29 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: memfd_luo: preserve file seals
Message-ID: <aXYGkb-QtYNaWYw4@kernel.org>
References: <20260123095854.535058-1-pratyush@kernel.org>
 <20260123095854.535058-3-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123095854.535058-3-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260125_040338_287383_14835C22 
X-CRM114-Status: GOOD (  35.02  )
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

On Fri, Jan 23, 2026 at 10:58:51AM +0100, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> File seals are used on memfd for making shared memory communication with
> untrusted peers safer and simpler. Seals provide a guarantee that
> certain operations won't be allowed on the file such as writes or
> truncations. Maintaining these guarantees across a live update will help
> keeping such use cases secure.
> 
> These guarantees will also be needed for IOMMUFD preservation with LUO.
> Normally when IOMMUFD maps a memfd, it pins all its pages to make sure
> any truncation operations on the memfd don't lead to IOMMUFD using freed
> memory. This doesn't work with LUO since the preserved memfd might have
> completely different pages after a live update, and mapping them back to
> the IOMMUFD will cause all sorts of problems. Using and preserving the
> seals allows IOMMUFD preservation logic to trust the memfd.
> 
> Preserve the seals by introducing a new 8-bit-wide bitfield. There are
> currently only 6 possible seals but 2 extra bits are used to provide
> room for future expansion. Since the seals are UAPI, it is safe to use
> them directly in the ABI.
> 
> Back the 8-bit field with a u64, leaving 56 unused bits. This is done to
> keep the struct nice and aligned. The unused bits can be used to add new
> flags later, potentially without even needing to bump the version
> number.
> 
> Since the serialization structure is changed, bump the version number to
> "memfd-v2".
> 
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> ---
>  include/linux/kho/abi/memfd.h |  9 ++++++++-
>  mm/memfd_luo.c                | 23 +++++++++++++++++++++--
>  2 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
> index 68cb6303b846..bd549c81f1d2 100644
> --- a/include/linux/kho/abi/memfd.h
> +++ b/include/linux/kho/abi/memfd.h
> @@ -60,6 +60,11 @@ struct memfd_luo_folio_ser {
>   * struct memfd_luo_ser - Main serialization structure for a memfd.
>   * @pos:       The file's current position (f_pos).
>   * @size:      The total size of the file in bytes (i_size).
> + * @seals:     The seals present on the memfd. The seals are UAPI so it is safe
> + *             to directly use them in the ABI. Note: currently there are 6
> + *             seals possible but this field is 8 bits to leave room for future
> + *             expansion.
> + * @__reserved: Reserved bits. May be used later to add more flags.
>   * @nr_folios: Number of folios in the folios array.
>   * @folios:    KHO vmalloc descriptor pointing to the array of
>   *             struct memfd_luo_folio_ser.
> @@ -67,11 +72,13 @@ struct memfd_luo_folio_ser {
>  struct memfd_luo_ser {
>  	u64 pos;
>  	u64 size;
> +	u64 seals:8;

Kernel uABI defines seals as unsigned int, I think we can spare u32 for
them and reserve a u32 flags for other memfd flags (MFD_CLOEXEC,
MFD_HUGETLB etc).

> +	u64 __reserved:56;
>  	u64 nr_folios;
>  	struct kho_vmalloc folios;
>  } __packed;
>  
>  /* The compatibility string for memfd file handler */
> -#define MEMFD_LUO_FH_COMPATIBLE	"memfd-v1"
> +#define MEMFD_LUO_FH_COMPATIBLE	"memfd-v2"
>  
>  #endif /* _LINUX_KHO_ABI_MEMFD_H */
> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> index a34fccc23b6a..eb68e0b5457f 100644
> --- a/mm/memfd_luo.c
> +++ b/mm/memfd_luo.c
> @@ -79,6 +79,8 @@
>  #include <linux/shmem_fs.h>
>  #include <linux/vmalloc.h>
>  #include <linux/memfd.h>
> +#include <uapi/linux/memfd.h>
> +
>  #include "internal.h"
>  
>  static int memfd_luo_preserve_folios(struct file *file,
> @@ -222,7 +224,7 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
>  	struct memfd_luo_folio_ser *folios_ser;
>  	struct memfd_luo_ser *ser;
>  	u64 nr_folios;
> -	int err = 0;
> +	int err = 0, seals;
>  
>  	inode_lock(inode);
>  	shmem_freeze(inode, true);
> @@ -234,8 +236,15 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
>  		goto err_unlock;
>  	}
>  
> +	seals = memfd_get_seals(args->file);
> +	if (seals < 0) {
> +		err = seals;
> +		goto err_free_ser;
> +	}
> +
>  	ser->pos = args->file->f_pos;
>  	ser->size = i_size_read(inode);
> +	ser->seals = seals;
>  
>  	err = memfd_luo_preserve_folios(args->file, &ser->folios,
>  					&folios_ser, &nr_folios);
> @@ -444,13 +453,23 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
>  	if (!ser)
>  		return -EINVAL;
>  
> -	file = memfd_alloc_file("", 0);
> +	/*
> +	 * The seals are preserved. Allow sealing here so they can be added
> +	 * later.
> +	 */
> +	file = memfd_alloc_file("", MFD_ALLOW_SEALING);

I think we should select flags passed to memfd_alloc_file() based on
ser->seals (and later based on ser->seals and ser->flags).

>  	if (IS_ERR(file)) {
>  		pr_err("failed to setup file: %pe\n", file);
>  		err = PTR_ERR(file);
>  		goto free_ser;
>  	}
>  
> +	err = memfd_add_seals(file, ser->seals);

I'm not sure using MFD_ALLOW_SEALING is enough if there was F_SEAL_EXEC in
seals.

> +	if (err) {
> +		pr_err("failed to add seals: %pe\n", ERR_PTR(err));
> +		goto put_file;
> +	}
> +
>  	vfs_setpos(file, ser->pos, MAX_LFS_FILESIZE);
>  	file->f_inode->i_size = ser->size;
>  
> -- 
> 2.52.0.457.g6b5491de43-goog
> 

-- 
Sincerely yours,
Mike.


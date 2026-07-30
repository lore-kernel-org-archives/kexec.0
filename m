Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D43C5516D
	for <kexec@archiver.kernel.org>; Thu, 30 Jul 2026 18:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:MIME-Version:References:In-Reply-To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YghvBOxKZj6r8MAI+WUSEYlYQEu1XclpHCz2MD6Rx8I=; b=LW1cC1a8y0ODd8vqYF5uTI9gC2
	uODIGdgWUyQkCSxpBjrtib9QzOixKxZjuPIxEfEGHNA/12a2Vh0IYrMES3nXlI9oc5ClgI2xdd6eG
	HZue+hBpaiPOAWUXoD8cLVdCEjT4HmjyAM0EoXePXAw2IAHxln2GaFL5CGdJ4FQvvhG7vZAEapyRI
	YN/CGOv3B+xz4UfkhA7zrlc7yn9TomHB5U2N/tPGuM50pTPw7jaoCNxlBBQsJknAsXXhJwp++nPV4
	7CmZkSZbfEqSp+eprd7RpROaB+q/FMNUYB8/VzjZQ0+W4BEvUYTc3i42ces0JOeht1GfXzRFEnJi3
	H9biuPEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpVFf-0000000B8Uf-2BMg;
	Thu, 30 Jul 2026 18:13:03 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpVFZ-0000000B8S5-0yGP
	for kexec@lists.infradead.org;
	Thu, 30 Jul 2026 18:12:58 +0000
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso196428a91.3
        for <kexec@lists.infradead.org>; Thu, 30 Jul 2026 11:12:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785435176; cv=none;
        d=google.com; s=arc-20260327;
        b=FMn1e9ySp9GUmpEjsyvJV2fk83Gitew1LhYPbBRtXmXDuPmdAc8Pv6lb0C5N3DPXP6
         K84X7hYps3kZY3OgWQobsL67wD0vMGsapImW2xXsetvCrFYC43DNQXAqQ920WxOIml//
         Wcv3kJ4mtKM+A3kEHv792sXQ+wOkPCA7zXXLj1CnVlUyo6ZzfEfWWO0LY7cMJBTiqtKW
         GsKOz5/6rQoXbcgQwapKOBKs1lIPyKTnaH8pLVcZJIkQTEk5L7YmYuBXVb+VlpAcQmGW
         Jo4LlncqFK468LK31B4QZIwYA26mGOS+OMMRHTK2fBGzJ1f5QLUcSIX4ZOB4HMQfnQGa
         MJsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=YghvBOxKZj6r8MAI+WUSEYlYQEu1XclpHCz2MD6Rx8I=;
        fh=wjl1cJoy+vpa3doTfYbTFvsGfqqCIWHnJcs+G8S/tQY=;
        b=PrIUBDQ2Jc+qjWbmLKT+eAKGxPzJu9EoYglcndFwGvO4K4LH95+Um3+x6F3dOjrb5t
         NYZ2MWZvcq7x+J9kxo/U77N79X93pTBXzgM1SMpkSPmAN7VFPe1NZwPGmFEvxeOHil3d
         5WYwRHgLFWqL+mLzDvh5LH8mO9Zp0c9jhKdGVXcggE79zFAvQtIr/QlJxoyzxvytJvHB
         lEDRYQCq4Rl6Ez0cPV3k3LP9nDnqL+73nLvVe9+uDG5lTWkboVs6/Ebf4xdxBp6qsxh2
         HYV+DnUZs5SFq2DA9IwWbcTLnPRvMKrmvTuvWHQvQcMewq13mwjnw4yoIbYq3E9RNPIe
         qosw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785435176; x=1786039976; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YghvBOxKZj6r8MAI+WUSEYlYQEu1XclpHCz2MD6Rx8I=;
        b=GD5tf9wHjUMp8BoP4NsuX72tjW2Mc8bh03dt5pPDRaG4v3yVjZWK8GcyhFAmyuobxF
         KVrGO/Vy2hRRXKvBZpUQkZZ9CbTCNiMvDrW0sjDObykqw+4idS+as73iQ/mGhaEBfiok
         yDURfWTbO9nbT6FFS+piJKurZvX2mko2rRyZrA4EL0of7YFU3CEn6wDTSbOwxCDifiBn
         yQtXWjvaBH3U2RrvGZSERp/84glQEX40H+D+qb1UemEUZxQf7IrcfuP5dBkf7bm1d22u
         9o0ngx8eYBXWfo2JigI4TzbcHPkZDvrrP6nUQqhRNTVNVjvOUP9j6fY/GM2uGU9Nbkig
         WLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785435176; x=1786039976;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YghvBOxKZj6r8MAI+WUSEYlYQEu1XclpHCz2MD6Rx8I=;
        b=TLHimeoB55vEjIvzBxqQJxi2FfgqJRxukJ+OyuG0WQkpD8tU8KWN0zVyv0qEpF23TN
         RAWioChvJqPeDISdRqtcXYrpRDxoopeY9RBlPYPSG7VzMPbCTwPAIVW8lqIfIxWScmCJ
         bEpuDFlzJKTs79K40m16oU+fZst9RYUCGXH/E1Aui/zM+lHUPFNyY8mybCOxxCWglhQL
         TR7Vz9OB8mqqcL/FU0n6QJ8Q7QmR1V5hx7W9MET9HUt1svbkM1Tz/1KvGc7dV+UjXi0B
         JM+UZAD/pmwgqv/BIzfKrz97nGavijU5/N0tBMvDCdG20J7RsYd7lmcD2iRzHte2KTV0
         wEBg==
X-Forwarded-Encrypted: i=1; AHgh+RobXNyTXb81XoIM5Czg40gIloa4/8pq341u3Eqkdff7qBzZRPvlQs7ljrNHSKgivbIuWjZyxg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxxPUrWOlrl6UjcVd0Gnr+ivUs+XrfKbeDlk+qHOPCIBwj4O9wN
	Zzg+v2Fax8CYKV/zraobzVk2yapZd4wsQ2W2b930R6l08pnn8nAH/CbOM2Q9blSbwN/+MUdksSg
	tt651TO16RaMT4+mJ8+eiG9wk3BI6rkmcVM/1eVAw
X-Gm-Gg: AR+sD10leySkORqe0ohWLWmpdaQEa4B2CpCiQghGwH+lqdeJ+IVdOD1F90Z7VxTXUMM
	PWW3xtUl53t8QF2sx4gwOrUHdacD7rhzxmCszUqU3Ryi6h0tOWgZGZg2gK196LWbjNtKwIUsRci
	D/Dq7kzX/xCiiAzcHz7tT0ffmCa1cUgGyos0/XXrMqL6XPtH7s/q4yjiEALYzyRa5ZC0Q0vu++1
	6iixU2A12jrY+b/z9+jM2iZzMJjigJw72hDSSZ+fTR9mH3HrUcMQQCQ6A2S9FkjH16nBWb9x47I
	2LBgynWcsQUgUjAopxKnSxQIA2nhzZ4CkGN4PA4Up0x4kiHsk//jH4aPzZ/iElSotJxYTTqr0XR
	J+Il+KcYuwpeLdWWyRFPpmChhuDAyjPCuiw==
X-Received: by 2002:a17:90b:582c:b0:380:fead:448d with SMTP id
 98e67ed59e1d1-38f9bdaf33amr3348945a91.13.1785435175540; Thu, 30 Jul 2026
 11:12:55 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 11:12:54 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 11:12:54 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260728121138.1103610-7-tarunsahu@google.com>
References: <20260728121138.1103610-1-tarunsahu@google.com> <20260728121138.1103610-7-tarunsahu@google.com>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 11:12:54 -0700
X-Gm-Features: AUfX_myTOZtTYgrc2JARzoakReAlBZfwUvudyD8fyzAtRRNHq5OayI8CE2nMNDE
Message-ID: <CAEvNRgEVxQS2r0_iPHciV=NEKFzwnrfitp-QdP1keAg5Ud7-TQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/11] KVM: guest_memfd: Move internal definitions to
 internal header
To: Tarun Sahu <tarunsahu@google.com>, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, seanjc@google.com, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, sagis@google.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: linux-kselftest@vger.kernel.org, andre.przywara@arm.com, 
	michael.roth@amd.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	will@kernel.org, vannapurve@google.com, maz@kernel.org, fvdl@google.com, 
	kvm@vger.kernel.org, oliver.upton@linux.dev, kvmarm@lists.linux.dev, 
	alexandru.elisei@arm.com, skhawaja@google.com, aneesh.kumar@kernel.org, 
	linux-doc@vger.kernel.org, David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, 
	kexec@lists.infradead.org, suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_111257_309274_57A8B1D2 
X-CRM114-Status: GOOD (  24.86  )
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

Tarun Sahu <tarunsahu@google.com> writes:

> Extract 'struct gmem_file', 'struct gmem_inode', and GMEM_I() from
> virt/kvm/guest_memfd.c into a new internal header virt/kvm/guest_memfd.h.
> Also split __kvm_gmem_create() to expose a non-static
> __kvm_gmem_create_file() helper that returns a 'struct file *' instead of
> an fd.
>

This is done basically to support a new virt/kvm/guest_memfd_luo.c
file.

Would like to know what Sean thinks of this! I'd like to know for future
guest_memfd work too.

> These internal definitions and helpers allow upcoming guest_memfd Live
> Update Orchestrator (LUO) preservation code to access guest_memfd
> internals and reconstruct guest_memfd file instances from preserved state
> without installing them into a file descriptor table up front.
>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> ---
>  virt/kvm/guest_memfd.c | 68 +++++++++++++++++-------------------------
>  virt/kvm/guest_memfd.h | 39 ++++++++++++++++++++++++
>  2 files changed, 67 insertions(+), 40 deletions(-)
>  create mode 100644 virt/kvm/guest_memfd.h
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index db57c5766ab6..dd84bba8974b 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -7,38 +7,12 @@
>  #include <linux/mempolicy.h>
>  #include <linux/pseudo_fs.h>
>  #include <linux/pagemap.h>
> +#include "guest_memfd.h"
>
>  #include "kvm_mm.h"
>
>  static struct vfsmount *kvm_gmem_mnt;
>
> -/*
> - * A guest_memfd instance can be associated multiple VMs, each with its own
> - * "view" of the underlying physical memory.
> - *
> - * The gmem's inode is effectively the raw underlying physical storage, and is
> - * used to track properties of the physical memory, while each gmem file is
> - * effectively a single VM's view of that storage, and is used to track assets
> - * specific to its associated VM, e.g. memslots=>gmem bindings.
> - */
> -struct gmem_file {
> -	struct kvm *kvm;
> -	struct xarray bindings;
> -	struct list_head entry;
> -};
> -
> -struct gmem_inode {
> -	struct shared_policy policy;
> -	struct inode vfs_inode;
> -	struct list_head gmem_file_list;
> -
> -	u64 flags;
> -};
> -
> -static __always_inline struct gmem_inode *GMEM_I(struct inode *inode)
> -{
> -	return container_of(inode, struct gmem_inode, vfs_inode);
> -}
>
>  #define kvm_gmem_for_each_file(f, inode) \
>  	list_for_each_entry(f, &GMEM_I(inode)->gmem_file_list, entry)
> @@ -557,23 +531,17 @@ bool __weak kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
>  	return true;
>  }
>
> -static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
> +struct file *__kvm_gmem_create_file(struct kvm *kvm, loff_t size, u64 flags)
>  {
>  	static const char *name = "[kvm-gmem]";
>  	struct gmem_file *f;
>  	struct inode *inode;
>  	struct file *file;
> -	int fd, err;
> -
> -	fd = get_unused_fd_flags(0);
> -	if (fd < 0)
> -		return fd;
> +	int err;
>
>  	f = kzalloc_obj(*f);
> -	if (!f) {
> -		err = -ENOMEM;
> -		goto err_fd;
> -	}
> +	if (!f)
> +		return ERR_PTR(-ENOMEM);
>
>  	/* __fput() will take care of fops_put(). */
>  	if (!fops_get(&kvm_gmem_fops)) {
> @@ -612,8 +580,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>  	xa_init(&f->bindings);
>  	list_add(&f->entry, &GMEM_I(inode)->gmem_file_list);
>
> -	fd_install(fd, file);
> -	return fd;
> +	return file;
>
>  err_inode:
>  	iput(inode);
> @@ -621,7 +588,28 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>  	fops_put(&kvm_gmem_fops);
>  err_gmem:
>  	kfree(f);
> -err_fd:
> +	return ERR_PTR(err);
> +}
> +
> +static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
> +{
> +	struct file *file;
> +	int fd, err;
> +
> +	fd = get_unused_fd_flags(0);
> +	if (fd < 0)
> +		return fd;
> +
> +	file = __kvm_gmem_create_file(kvm, size, flags);
> +	if (IS_ERR(file)) {
> +		err = PTR_ERR(file);
> +		goto err_put_fd;
> +	}
> +
> +	fd_install(fd, file);
> +	return fd;
> +
> +err_put_fd:
>  	put_unused_fd(fd);
>  	return err;
>  }
> diff --git a/virt/kvm/guest_memfd.h b/virt/kvm/guest_memfd.h
> new file mode 100644
> index 000000000000..c528b046dd69
> --- /dev/null
> +++ b/virt/kvm/guest_memfd.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __KVM_GUEST_MEMFD_H__
> +#define __KVM_GUEST_MEMFD_H__ 1
> +
> +#include <linux/kvm_host.h>
> +#include <linux/fs.h>
> +#include <linux/mempolicy.h>
> +
> +/*
> + * A guest_memfd instance can be associated multiple VMs, each with its own
> + * "view" of the underlying physical memory.
> + *
> + * The gmem's inode is effectively the raw underlying physical storage, and is
> + * used to track properties of the physical memory, while each gmem file is
> + * effectively a single VM's view of that storage, and is used to track assets
> + * specific to its associated VM, e.g. memslots=>gmem bindings.
> + */
> +struct gmem_file {
> +	struct kvm *kvm;
> +	struct xarray bindings;
> +	struct list_head entry;
> +};
> +
> +struct gmem_inode {
> +	struct shared_policy policy;
> +	struct inode vfs_inode;
> +	struct list_head gmem_file_list;
> +
> +	u64 flags;
> +};
> +
> +static inline struct gmem_inode *GMEM_I(struct inode *inode)
> +{
> +	return container_of(inode, struct gmem_inode, vfs_inode);
> +}
> +
> +struct file *__kvm_gmem_create_file(struct kvm *kvm, loff_t size, u64 flags);
> +
> +#endif /* __KVM_GUEST_MEMFD_H__ */
> --
> 2.55.0.229.g6434b31f56-goog


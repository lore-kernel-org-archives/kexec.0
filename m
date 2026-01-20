Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FECCA5FB7
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 17:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M/SyHKIfT52m21jYTqMJn0kce5uLNXDcSuIH1lAA/Hw=; b=uL07Ad3hgu0VQFHPTITXIeyjl0
	cJY6JstH1Ym0oeoEZkqdvgzigVXePJ894EojDd1sb7JPZaBKpUvn2YvaPec1tspM/ByIFaWJHW5O9
	2vPJ9GC+EYf+znaBQk2GEXvd/5jwZOqbGnG+ibbOfojhdJjw72dWtl3q3upN2c14kGAd2S0Z7EgjR
	pFjoB087HX4brRf5H9K9pRhnUJns103d4orW4mdee/4ebxBs2u6fpyzRBG1O/jf9Q2qQ4UrYxWgS1
	djbXYr0n7PFYOs8XkE8ELPoIUr4CUN/82aTDbihycNZYyrli++Tla+VE/8oDYSppkvVei46ojWNeX
	vBxcuHyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viFTh-00000004EqL-0Eev;
	Tue, 20 Jan 2026 17:25:17 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viFTc-00000004EpZ-3klz
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 17:25:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 36EB0419A1;
	Tue, 20 Jan 2026 17:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1CBC16AAE;
	Tue, 20 Jan 2026 17:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768929910;
	bh=uwcLAOQjUO7lgxgkzAkEQvTOODBzpF5UAYJY///qzRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YuhQzc8Vo5QgOoQr9WpCPpsmsss0Ld5GnV1/9/q1mqcvMKHE+oa93rfwoKENXXr/a
	 ewFcnaoV4m1ruoMthZ8RU1USM8Yrby4s3UMWbtBVZHhO53uATdVtLk9WJ0zZ+NXPb9
	 5wJ3QTmYYbuSpGNXGL4z6pg3KFAg9U5s7aW4dc5utdJHzcX2bqWafG7oh4+JBs8nOX
	 0PZvInefyHxobeICJIRrwnX7ql0dYyws+eIerB/K3pJva2Wsm/KYak7HDCAVcGQYeb
	 2+0rMWBXq8l4uerPAhKBVjhko1zlrLKcA7N9sITfLuGwrGDuZI5YCLoEF6BKDwMBpt
	 ZfZxqeLfxecNw==
Date: Tue, 20 Jan 2026 19:25:01 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Jason Miu <jasonmiu@google.com>
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 2/2] kho: Remove finalize state and clients
Message-ID: <aW-6bdsOScsBodwe@kernel.org>
References: <20260116034432.1520731-1-jasonmiu@google.com>
 <20260116034432.1520731-3-jasonmiu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116034432.1520731-3-jasonmiu@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260120_092512_979387_6D354231 
X-CRM114-Status: GOOD (  49.33  )
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

On Thu, Jan 15, 2026 at 07:44:32PM -0800, Jason Miu wrote:
> Eliminate the `kho_finalize()` function and its associated state from
> the KHO subsystem. The transition to a radix tree for memory tracking
> makes the explicit "finalize" state and its serialization step
> obsolete.
> 
> Remove the `kho_finalize()` and `kho_finalized()` APIs and their stub
> implementations. Update KHO client code and the debugfs interface to
> no longer call or depend on the `kho_finalize()` mechanism.
> 
> Complete the move towards a stateless KHO, simplifying the overall
> design by removing unnecessary state management.
> 
> Signed-off-by: Jason Miu <jasonmiu@google.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  Documentation/admin-guide/mm/kho.rst        | 53 +++++----------------
>  Documentation/core-api/kho/index.rst        | 12 -----
>  kernel/liveupdate/kexec_handover.c          | 21 +-------
>  kernel/liveupdate/kexec_handover_debugfs.c  | 23 ---------
>  kernel/liveupdate/kexec_handover_internal.h |  3 --
>  kernel/liveupdate/luo_core.c                | 12 +----
>  kernel/liveupdate/luo_flb.c                 |  2 +-
>  tools/testing/selftests/kho/init.c          | 20 --------
>  8 files changed, 14 insertions(+), 132 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/kho.rst b/Documentation/admin-guide/mm/kho.rst
> index 6dc18ed4b886..454b378cf239 100644
> --- a/Documentation/admin-guide/mm/kho.rst
> +++ b/Documentation/admin-guide/mm/kho.rst
> @@ -28,20 +28,10 @@ per NUMA node scratch regions on boot.
>  Perform a KHO kexec
>  ===================
>  
> -First, before you perform a KHO kexec, you need to move the system into
> -the :ref:`KHO finalization phase <kho-finalization-phase>` ::
> -
> -  $ echo 1 > /sys/kernel/debug/kho/out/finalize
> -
> -After this command, the KHO FDT is available in
> -``/sys/kernel/debug/kho/out/fdt``. Other subsystems may also register
> -their own preserved sub FDTs under
> -``/sys/kernel/debug/kho/out/sub_fdts/``.
> -
> -Next, load the target payload and kexec into it. It is important that you
> -use the ``-s`` parameter to use the in-kernel kexec file loader, as user
> -space kexec tooling currently has no support for KHO with the user space
> -based file loader ::
> +To perform a KHO kexec, load the target payload and kexec into it. It
> +is important that you use the ``-s`` parameter to use the in-kernel
> +kexec file loader, as user space kexec tooling currently has no
> +support for KHO with the user space based file loader ::
>  
>    # kexec -l /path/to/bzImage --initrd /path/to/initrd -s
>    # kexec -e
> @@ -52,40 +42,19 @@ For example, if you used ``reserve_mem`` command line parameter to create
>  an early memory reservation, the new kernel will have that memory at the
>  same physical address as the old kernel.
>  
> -Abort a KHO exec
> -================
> -
> -You can move the system out of KHO finalization phase again by calling ::
> -
> -  $ echo 0 > /sys/kernel/debug/kho/out/active
> -
> -After this command, the KHO FDT is no longer available in
> -``/sys/kernel/debug/kho/out/fdt``.
> -
>  debugfs Interfaces
>  ==================
>  
> +These debugfs interfaces are available when the kernel is compiled with
> +``CONFIG_KEXEC_HANDOVER_DEBUGFS`` enabled.
> +
>  Currently KHO creates the following debugfs interfaces. Notice that these
>  interfaces may change in the future. They will be moved to sysfs once KHO is
>  stabilized.
>  
> -``/sys/kernel/debug/kho/out/finalize``
> -    Kexec HandOver (KHO) allows Linux to transition the state of
> -    compatible drivers into the next kexec'ed kernel. To do so,
> -    device drivers will instruct KHO to preserve memory regions,
> -    which could contain serialized kernel state.
> -    While the state is serialized, they are unable to perform
> -    any modifications to state that was serialized, such as
> -    handed over memory allocations.
> -
> -    When this file contains "1", the system is in the transition
> -    state. When contains "0", it is not. To switch between the
> -    two states, echo the respective number into this file.
> -
>  ``/sys/kernel/debug/kho/out/fdt``
> -    When KHO state tree is finalized, the kernel exposes the
> -    flattened device tree blob that carries its current KHO
> -    state in this file. Kexec user space tooling can use this
> +    The kernel exposes the flattened device tree blob that carries its
> +    current KHO state in this file. Kexec user space tooling can use this
>      as input file for the KHO payload image.
>  
>  ``/sys/kernel/debug/kho/out/scratch_len``
> @@ -100,8 +69,8 @@ stabilized.
>      it should place its payload images.
>  
>  ``/sys/kernel/debug/kho/out/sub_fdts/``
> -    In the KHO finalization phase, KHO producers register their own
> -    FDT blob under this directory.
> +    KHO producers can register their own FDT blob another binary blob under

Nit:                                      ^ FDT or another binary blob

> +    this directory.
>  
>  ``/sys/kernel/debug/kho/in/fdt``
>      When the kernel was booted with Kexec HandOver (KHO),
> diff --git a/Documentation/core-api/kho/index.rst b/Documentation/core-api/kho/index.rst
> index 002bdf0beb2e..0a2dee4f8e7d 100644
> --- a/Documentation/core-api/kho/index.rst
> +++ b/Documentation/core-api/kho/index.rst
> @@ -71,18 +71,6 @@ for boot memory allocations and as target memory for kexec blobs, some parts
>  of that memory region may be reserved. These reservations are irrelevant for
>  the next KHO, because kexec can overwrite even the original kernel.
>  
> -.. _kho-finalization-phase:
> -
> -KHO finalization phase
> -======================
> -
> -To enable user space based kexec file loader, the kernel needs to be able to
> -provide the FDT that describes the current kernel's state before
> -performing the actual kexec. The process of generating that FDT is
> -called serialization. When the FDT is generated, some properties
> -of the system may become immutable because they are already written down
> -in the FDT. That state is called the KHO finalization phase.
> -
>  Kexec Handover Radix Tree
>  =========================
>  
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 06adaf56cd69..14d2c66491a6 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -68,8 +68,7 @@ early_param("kho", kho_parse_enable);
>  
>  struct kho_out {
>  	void *fdt;
> -	bool finalized;
> -	struct mutex lock; /* protects KHO FDT finalization */
> +	struct mutex lock; /* protects KHO FDT */
>  
>  	struct kho_radix_tree radix_tree;
>  	struct kho_debugfs dbg;
> @@ -80,7 +79,6 @@ static struct kho_out kho_out = {
>  	.radix_tree = {
>  		.lock = __MUTEX_INITIALIZER(kho_out.radix_tree.lock),
>  	},
> -	.finalized = false,
>  };
>  
>  /**
> @@ -1209,23 +1207,6 @@ void kho_restore_free(void *mem)
>  }
>  EXPORT_SYMBOL_GPL(kho_restore_free);
>  
> -int kho_finalize(void)
> -{
> -	if (!kho_enable)
> -		return -EOPNOTSUPP;
> -
> -	guard(mutex)(&kho_out.lock);
> -	kho_out.finalized = true;
> -
> -	return 0;
> -}
> -
> -bool kho_finalized(void)
> -{
> -	guard(mutex)(&kho_out.lock);
> -	return kho_out.finalized;
> -}
> -
>  struct kho_in {
>  	phys_addr_t fdt_phys;
>  	phys_addr_t scratch_phys;
> diff --git a/kernel/liveupdate/kexec_handover_debugfs.c b/kernel/liveupdate/kexec_handover_debugfs.c
> index 2abbf62ba942..430c9521d59c 100644
> --- a/kernel/liveupdate/kexec_handover_debugfs.c
> +++ b/kernel/liveupdate/kexec_handover_debugfs.c
> @@ -75,24 +75,6 @@ void kho_debugfs_fdt_remove(struct kho_debugfs *dbg, void *fdt)
>  	}
>  }
>  
> -static int kho_out_finalize_get(void *data, u64 *val)
> -{
> -	*val = kho_finalized();
> -
> -	return 0;
> -}
> -
> -static int kho_out_finalize_set(void *data, u64 val)
> -{
> -	if (val)
> -		return kho_finalize();
> -	else
> -		return -EINVAL;
> -}
> -
> -DEFINE_DEBUGFS_ATTRIBUTE(kho_out_finalize_fops, kho_out_finalize_get,
> -			 kho_out_finalize_set, "%llu\n");
> -
>  static int scratch_phys_show(struct seq_file *m, void *v)
>  {
>  	for (int i = 0; i < kho_scratch_cnt; i++)
> @@ -198,11 +180,6 @@ __init int kho_out_debugfs_init(struct kho_debugfs *dbg)
>  	if (IS_ERR(f))
>  		goto err_rmdir;
>  
> -	f = debugfs_create_file("finalize", 0600, dir, NULL,
> -				&kho_out_finalize_fops);
> -	if (IS_ERR(f))
> -		goto err_rmdir;
> -
>  	dbg->dir = dir;
>  	dbg->sub_fdt_dir = sub_fdt_dir;
>  	return 0;
> diff --git a/kernel/liveupdate/kexec_handover_internal.h b/kernel/liveupdate/kexec_handover_internal.h
> index 0202c85ad14f..9a832a35254c 100644
> --- a/kernel/liveupdate/kexec_handover_internal.h
> +++ b/kernel/liveupdate/kexec_handover_internal.h
> @@ -22,9 +22,6 @@ struct kho_debugfs {};
>  extern struct kho_scratch *kho_scratch;
>  extern unsigned int kho_scratch_cnt;
>  
> -bool kho_finalized(void);
> -int kho_finalize(void);
> -
>  #ifdef CONFIG_KEXEC_HANDOVER_DEBUGFS
>  int kho_debugfs_init(void);
>  void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt);
> diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
> index dda7bb57d421..84ac728d63ba 100644
> --- a/kernel/liveupdate/luo_core.c
> +++ b/kernel/liveupdate/luo_core.c
> @@ -230,17 +230,7 @@ int liveupdate_reboot(void)
>  
>  	luo_flb_serialize();
>  
> -	err = kho_finalize();
> -	if (err) {
> -		pr_err("kho_finalize failed %d\n", err);
> -		/*
> -		 * kho_finalize() may return libfdt errors, to aboid passing to
> -		 * userspace unknown errors, change this to EAGAIN.
> -		 */
> -		err = -EAGAIN;
> -	}
> -
> -	return err;
> +	return 0;
>  }
>  
>  /**
> diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
> index 4c437de5c0b0..22f6409875c9 100644
> --- a/kernel/liveupdate/luo_flb.c
> +++ b/kernel/liveupdate/luo_flb.c
> @@ -630,7 +630,7 @@ int __init luo_flb_setup_incoming(void *fdt_in)
>   * data handle, and the final reference count. This allows the new kernel to
>   * find the appropriate handler and reconstruct the FLB's state.
>   *
> - * Context: Called from liveupdate_reboot() just before kho_finalize().
> + * Context: Called from liveupdate_reboot().
>   */
>  void luo_flb_serialize(void)
>  {
> diff --git a/tools/testing/selftests/kho/init.c b/tools/testing/selftests/kho/init.c
> index 6d9e91d55d68..88a41b6eba95 100644
> --- a/tools/testing/selftests/kho/init.c
> +++ b/tools/testing/selftests/kho/init.c
> @@ -11,7 +11,6 @@
>  /* from arch/x86/include/asm/setup.h */
>  #define COMMAND_LINE_SIZE	2048
>  
> -#define KHO_FINALIZE "/debugfs/kho/out/finalize"
>  #define KERNEL_IMAGE "/kernel"
>  
>  static int mount_filesystems(void)
> @@ -22,22 +21,6 @@ static int mount_filesystems(void)
>  	return mount("proc", "/proc", "proc", 0, NULL);
>  }
>  
> -static int kho_enable(void)
> -{
> -	const char enable[] = "1";
> -	int fd;
> -
> -	fd = open(KHO_FINALIZE, O_RDWR);
> -	if (fd < 0)
> -		return -1;
> -
> -	if (write(fd, enable, sizeof(enable)) != sizeof(enable))
> -		return 1;
> -
> -	close(fd);
> -	return 0;
> -}
> -
>  static long kexec_file_load(int kernel_fd, int initrd_fd,
>  			    unsigned long cmdline_len, const char *cmdline,
>  			    unsigned long flags)
> @@ -78,9 +61,6 @@ int main(int argc, char *argv[])
>  	if (mount_filesystems())
>  		goto err_reboot;
>  
> -	if (kho_enable())
> -		goto err_reboot;
> -
>  	if (kexec_load())
>  		goto err_reboot;
>  
> -- 
> 2.52.0.457.g6b5491de43-goog
> 

-- 
Sincerely yours,
Mike.


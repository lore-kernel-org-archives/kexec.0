Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538E0C9EC64
	for <kexec@archiver.kernel.org>; Mon, 12 Jan 2026 10:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oQ+uhczkBU6ZeuZtsKRxUa8pjHCFPyNvAqTeWv5HkrM=; b=s0m3MQ8l93pvklnsboAgbYi6V6
	I5DxHwyA+D/yZo5cEk6p7TwcQ1XzV/dylgcHZDTnWbHfHPorISv5SMQkcQsMyKhgt9nU/rqRgnCdA
	/lx85dD8mEYSRvzjk9n3l3GztrGLVY753pKr3f+ioZ4byquUI6KYkbyN1STytcMsznbjPa7Sv6BOP
	c7bEWUoPXADNu5EiATy/MNjq/zWOPVVxYlD6uyUr8c/NhmrT3heos/ajCHIrqvZBAm6kKJ52hK80H
	d3bLiknDhzhHG50Nf3AXZHmun3dabJUJeWFoDuvh0NDj4Df+RPf3cfmDlAu6yE+pEgTqwyJJvedlg
	33N5T83Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfF7I-00000005AOH-42rQ;
	Mon, 12 Jan 2026 10:25:44 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfF7H-00000005AOB-0x6z
	for kexec@lists.infradead.org;
	Mon, 12 Jan 2026 10:25:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 345466013B;
	Mon, 12 Jan 2026 10:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8994C19422;
	Mon, 12 Jan 2026 10:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768213541;
	bh=iZB8w08zTJZOeuhUYutrmZtQ2wK2v16pDgwJWhcGpSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TB3TSWJyHUhoynAjWb06w7GIhKYoQDVMDrLeaOT0MyjqtCXWmRvgze14tZD7P/Aij
	 oT7udaN4OUG/CI8sVA29DGFSF/v5h1VFOat9mN011g6JpkGPfSW50Kn/IqmKuckQGg
	 L4w6njj6XBbg9UFgkKL1gks7m4swycKWV21aYcdp2FPiTRJFv6a5g7hOrV9zU6Fytr
	 f6IqfCwKyzJ9fTSddo3Qk3g5INIYOh8v1UxrdwcElcfPv0PObPyj/klddRE3z7yxxH
	 nH1xlOn92G7FHq3eDu2acNAfKG49EI7MwWD0/ritUdvPLFui90LZUCPn9VPt1441t9
	 3/2xOo4VMXz1w==
Date: Mon, 12 Jan 2026 12:25:34 +0200
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
Subject: Re: [PATCH v4 2/2] kho: Remove finalize state and clients
Message-ID: <aWTMHgHXy9Z-cKeb@kernel.org>
References: <20260109001127.2596222-1-jasonmiu@google.com>
 <20260109001127.2596222-3-jasonmiu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109001127.2596222-3-jasonmiu@google.com>
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

On Thu, Jan 08, 2026 at 04:11:27PM -0800, Jason Miu wrote:
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
> ---
>  Documentation/admin-guide/mm/kho.rst        | 52 ++++-----------------
>  Documentation/core-api/kho/index.rst        | 17 ++-----
>  kernel/liveupdate/kexec_handover.c          | 21 +--------
>  kernel/liveupdate/kexec_handover_debugfs.c  | 23 ---------
>  kernel/liveupdate/kexec_handover_internal.h |  3 --
>  kernel/liveupdate/luo_core.c                | 12 +----
>  kernel/liveupdate/luo_flb.c                 |  2 +-
>  tools/testing/selftests/kho/init.c          | 20 --------
>  8 files changed, 16 insertions(+), 134 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/kho.rst b/Documentation/admin-guide/mm/kho.rst
> index 6dc18ed4b886..57d5690dce77 100644
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
> +``CONFIG_KEXEC_HANDOVER_DEBUGFS`` set to y.

s/set to y/enabled/

>  ``/sys/kernel/debug/kho/out/sub_fdts/``
> -    In the KHO finalization phase, KHO producers register their own
> -    FDT blob under this directory.
> +    KHO producers can register their own FDT blob under this directory.

"own FDT or another binary blob ..."

> diff --git a/Documentation/core-api/kho/index.rst b/Documentation/core-api/kho/index.rst
> index 7ddc4d3ecac5..286a6d0b9956 100644
> --- a/Documentation/core-api/kho/index.rst
> +++ b/Documentation/core-api/kho/index.rst
> @@ -9,8 +9,9 @@ Kexec Handover Subsystem
>  Overview
>  ========
>  
> -Kexec HandOver (KHO) is a mechanism that allows Linux to preserve memory
> -regions, which could contain serialized system states, across kexec.
> +Kexec HandOver (KHO) is a mechanism that allows Linux to preserve
> +memory regions, containing kernel data structures in their live,
> +in-memory format, across kexec.

I'm not sure about "live, in-memory format". memfd does preserve some
serialized state rather than "live memfd".
The existing phrasing is general enough and I'd leave it as is.
  
> diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
> index 4c437de5c0b0..ddc9110a2b45 100644
> --- a/kernel/liveupdate/luo_flb.c
> +++ b/kernel/liveupdate/luo_flb.c
> @@ -630,7 +630,7 @@ int __init luo_flb_setup_incoming(void *fdt_in)
>   * data handle, and the final reference count. This allows the new kernel to
>   * find the appropriate handler and reconstruct the FLB's state.
>   *
> - * Context: Called from liveupdate_reboot() just before kho_finalize().
> + * Context: Called from liveupdate_reboot() just before return.

Just

	Called from liveupdate_reboot()

is enough IMO.

>   */

-- 
Sincerely yours,
Mike.


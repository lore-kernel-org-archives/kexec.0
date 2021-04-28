Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbh1s-00HLCB-PV
 for kexec@lists.infradead.org; Wed, 28 Apr 2021 10:02:50 +0000
Date: Wed, 28 Apr 2021 18:02:29 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v5 03/13] buildid: Stash away kernels build ID on init
Message-ID: <20210428100229.GA8374@localhost.localdomain>
References: <20210420215003.3510247-1-swboyd@chromium.org>
 <20210420215003.3510247-4-swboyd@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210420215003.3510247-4-swboyd@chromium.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jessica Yu <jeyu@kernel.org>, Evan Green <evgreen@chromium.org>, Hsin-Yi Wang <hsinyi@chromium.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org

On 04/20/21 at 02:49pm, Stephen Boyd wrote:
> Parse the kernel's build ID at initialization so that other code can
> print a hex format string representation of the running kernel's build
> ID. This will be used in the kdump and dump_stack code so that
> developers can easily locate the vmlinux debug symbols for a
> crash/stacktrace.
> 
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: <kexec@lists.infradead.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  include/linux/buildid.h |  3 +++
>  init/main.c             |  1 +
>  lib/buildid.c           | 15 +++++++++++++++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/include/linux/buildid.h b/include/linux/buildid.h
> index ebce93f26d06..f375900cf9ed 100644
> --- a/include/linux/buildid.h
> +++ b/include/linux/buildid.h
> @@ -10,4 +10,7 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
>  		   __u32 *size);
>  int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size);
>  
> +extern unsigned char vmlinux_build_id[BUILD_ID_SIZE_MAX];
> +void init_vmlinux_build_id(void);
> +
>  #endif
> diff --git a/init/main.c b/init/main.c
> index 53b278845b88..eaede2f41327 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -857,6 +857,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
>  	set_task_stack_end_magic(&init_task);
>  	smp_setup_processor_id();
>  	debug_objects_early_init();
> +	init_vmlinux_build_id();
>  
>  	cgroup_init_early();
>  
> diff --git a/lib/buildid.c b/lib/buildid.c
> index 6aea1c4e5e85..1103ed46214f 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
>  #include <linux/buildid.h>
> +#include <linux/cache.h>
>  #include <linux/elf.h>
>  #include <linux/kernel.h>
>  #include <linux/pagemap.h>
> @@ -172,3 +173,17 @@ int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size)
>  {
>  	return parse_build_id_buf(build_id, NULL, buf, buf_size);
>  }
> +
> +unsigned char vmlinux_build_id[BUILD_ID_SIZE_MAX] __ro_after_init;
> +
> +/**
> + * init_vmlinux_build_id - Compute and stash the running kernel's build ID
> + */
> +void __init init_vmlinux_build_id(void)
> +{
> +	extern const void __start_notes __weak;
> +	extern const void __stop_notes __weak;
> +	unsigned int size = &__stop_notes - &__start_notes;
> +
> +	build_id_parse_buf(&__start_notes, vmlinux_build_id, size);
> +}

LGTM, thx.

Acked-by: Baoquan He <bhe@redhat.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

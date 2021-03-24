Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOzkc-00Gj0h-Nn
 for kexec@lists.infradead.org; Wed, 24 Mar 2021 09:24:33 +0000
Received: by mail-ed1-x52c.google.com with SMTP id h13so26779463eds.5
 for <kexec@lists.infradead.org>; Wed, 24 Mar 2021 02:24:29 -0700 (PDT)
Subject: Re: [PATCH v2 02/12] buildid: Add method to get running kernel's
 build ID
References: <20210324020443.1815557-1-swboyd@chromium.org>
 <20210324020443.1815557-3-swboyd@chromium.org>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <7ef21ff8-8056-3b07-31ac-bc2de89fa7a0@rasmusvillemoes.dk>
Date: Wed, 24 Mar 2021 10:24:27 +0100
MIME-Version: 1.0
In-Reply-To: <20210324020443.1815557-3-swboyd@chromium.org>
Content-Language: en-US
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
To: Stephen Boyd <swboyd@chromium.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jessica Yu <jeyu@kernel.org>, Evan Green <evgreen@chromium.org>, Hsin-Yi Wang <hsinyi@chromium.org>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org

On 24/03/2021 03.04, Stephen Boyd wrote:
> Add vmlinux_build_id() so that callers can print a hex format string
> representation of the running kernel's build ID. This will be used in
> the kdump and dump_stack code so that developers can easily locate the
> vmlinux debug symbols for a crash/stacktrace.
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
>  include/linux/buildid.h |  2 ++
>  lib/buildid.c           | 19 +++++++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/include/linux/buildid.h b/include/linux/buildid.h
> index ebce93f26d06..2ff6b1b7cc9b 100644
> --- a/include/linux/buildid.h
> +++ b/include/linux/buildid.h
> @@ -10,4 +10,6 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
>  		   __u32 *size);
>  int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size);
>  
> +const unsigned char *vmlinux_build_id(void);
> +
>  #endif
> diff --git a/lib/buildid.c b/lib/buildid.c
> index 010ab0674cb9..fa1b6466b4b8 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -4,6 +4,7 @@
>  #include <linux/elf.h>
>  #include <linux/kernel.h>
>  #include <linux/pagemap.h>
> +#include <linux/string.h>
>  
>  #define BUILD_ID 3
>  
> @@ -171,3 +172,21 @@ int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size)
>  {
>  	return parse_build_id_buf(build_id, NULL, buf, buf_size);
>  }
> +
> +/**
> + * vmlinux_build_id - Get the running kernel's build ID
> + *
> + * Return: Running kernel's build ID
> + */
> +const unsigned char *vmlinux_build_id(void)
> +{
> +	extern const void __start_notes __weak;
> +	extern const void __stop_notes __weak;
> +	unsigned int size = &__stop_notes - &__start_notes;
> +	static unsigned char vmlinux_build_id[BUILD_ID_SIZE_MAX];
> +
> +	if (!memchr_inv(vmlinux_build_id, 0, BUILD_ID_SIZE_MAX))
> +		build_id_parse_buf(&__start_notes, vmlinux_build_id, size);
> +
> +	return vmlinux_build_id;
> +}
> 

Hm, is there any reason to do that initialization lazily and thus need
an accessor? If the system is coming down hard, there's a (very very
small) risk that one thread starts finding the build id, is in the
middle of the memcpy, another thread also ends up wanting the vmlinux
build id, sees some non-nul byte, and proceeds to using the partially
written vmlinux_build_id.

Perhaps consider just exposing the vmlinux_build_id[] array itself,
adding a init_vmlinux_build_id() call somewhere early in start_kernel().

It could then also be made __ro_after_init.

In any case, if you decide to keep the current way, please rename the
local variable (just "build_id" is fine) so that it doesn't shadow the
very function it resides in, that's very confusing.

Rasmus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93AD7E6FE24
	for <kexec@archiver.kernel.org>; Tue, 23 Dec 2025 18:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y0mvoCbuMd4eC9vUuRIk+xJnlqy18MydCTDV6Wj6wlQ=; b=UzzIY8koi+nq9mpod09FiRrUc1
	NVhsl9lXzAAJVVRZili1QUW8KMcCSsgP2W5StNg6FvILekgspmd3anibzRY1frM9PYSrVlz7GFIfP
	hXXBIwmSpHOF/MeyqfMxlPGnW3nYFnduVyLfVFPf0M8pqVH8+aLAHNw2XGQMchUNvhHpRSlNBl+Mb
	3FxycyJyTbG2v4cSAD+en/H8AnTCQsyW1VVFErDo4n2AfQ7knrK9t+vqVFWnWEExnLydPAdz6KSAL
	/8FhR/aGudIv6QmhOZfRy8oLs/FwuKMEaD6ye821BRZ3cqLMFTeSMCzgKlVmtjCWlnBK485givsaR
	cYtwCbHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vY6pI-0000000FvrF-2BAr;
	Tue, 23 Dec 2025 18:09:40 +0000
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vY6pF-0000000Fvqm-1dnk
	for kexec@lists.infradead.org;
	Tue, 23 Dec 2025 18:09:38 +0000
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-6418b55f86dso7107096a12.1
        for <kexec@lists.infradead.org>; Tue, 23 Dec 2025 10:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1766513375; x=1767118175; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0mvoCbuMd4eC9vUuRIk+xJnlqy18MydCTDV6Wj6wlQ=;
        b=ZHwQoCiVxZRL7whqSPbeUuqNvGKHi0RAXno8AMeIhYy4i7KOQfq5OrPDdxIjJJIEmE
         kcWRxjj0Bj6CWbaEhHhz0JUrsoIw/f21MtgiGBubjmL/O1dr2Kia+hg1unPM0FwJpBOk
         2AtD8mdIe1OK6sS08DNoYtNpfQ36u0LaVbBkUqkTb1lfy3S9GY/j9uiN40nU52EKzZZF
         9cMg06QOYMlyDDWW3DPtTtD/FCy3gzRRfrIEHZP0mbTp0Q09htsrOHe6PbbYxJxPHCmg
         ylaAw1e3OR5X9QNNVUqq8BZCg0+MYgYOWslRQQQmvpTJvib9ZfWGEWf2JtvemyxRbDzi
         tWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766513375; x=1767118175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y0mvoCbuMd4eC9vUuRIk+xJnlqy18MydCTDV6Wj6wlQ=;
        b=nt4DR0/4/T/SuVdKtTsinkm1rFEaHmV/+/Y37H42TvD6XpQGDFWWm9Obefw57d/LJH
         TkJs6hugCis8CsJEKh9fYfW8tLspNG+jP0/VyuEwBGqHPsYouLrO75C8KT5gbLO571YD
         jk22tjM9kWN/fYMyIZh9Php92Q6RJ19HKEbHRWmx63RKM88jKLhP0h1ZW5a3CKP95dsg
         9lX1rcxtWc0GNJQaez3VkPVfzC1NPDxkWzCAGZcFaNvrA4xXpBBgLUFt51qjxxzrJYQO
         buEXoTZRL4MsZi98vqthtF/dZwJHWDUzOmdSS458IkcDF4ICsHO5LR0zmpvVtS9hUWSc
         T/9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVj+vhhHwuPYZS1VM21dEDoXxusjba95hO7Z7xt3labHNwwJ76n1lEwa5crSO506ETKG/HL+w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx5yWMayhelzkPgAAHkd+SwxWqbIRq4NosacCY245z+1AsYtNYR
	THcbm6gyhx6sMmEHf/kI3cPOW+KXJDv9Y6+dq4e9PpIQbByWq+IVkopNYDEYiuyoPyvu/v8lVj4
	J7I9cr6pCQvefpbWStKfi14qC9LvHq/kuHtWsTioihw==
X-Gm-Gg: AY/fxX6aqiTfisXnnz1Be1DupFOtiNRbdQn6kyhjMMEpaL7Q1+WvXqz9Y8fig8pYTiB
	M7SOyA/TIXt7M69z/xzAZTl2+yrfqS3p8rJmThNTcV0fidEd9Tsech6aU6keYEhGXmi50VF1wX9
	3dWs57BU7hGEcRKTcljcB9X28im2u5/Uzln2gw2/AMtLoOJfPROlD7rH2AR/fw4XKiKENWlXjlz
	NXkFJKI9xGC0R29rr+Ys6S+AvBpGMy1tdxKHPtFwhoZVGCNrArImo64d4ksHd8Ti4IWQe1TQx56
	XU9Z/ERpewsOYuI9CPo6GDteqQ==
X-Google-Smtp-Source: AGHT+IHHyUf0R+vHniFfbEYJMvb3fpH/MlbN/XPxv0Z5WmJczLbpPFoRGmWoDzSU9Fg1wq7iuKESJj2bcABIf0GuBCY=
X-Received: by 2002:a05:6402:535b:20b0:64c:62f7:1ac4 with SMTP id
 4fb4d7f45d1cf-64c62f71cb9mr9764002a12.32.1766513375289; Tue, 23 Dec 2025
 10:09:35 -0800 (PST)
MIME-Version: 1.0
References: <20251206230222.853493-1-pratyush@kernel.org> <20251206230222.853493-4-pratyush@kernel.org>
In-Reply-To: <20251206230222.853493-4-pratyush@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 23 Dec 2025 13:08:59 -0500
X-Gm-Features: AQt7F2pUw5VhwuozKnCUEq4zB5jjvJjDYSUWusyCg9tH-jAG1cRM1Slm6WUoNhs
Message-ID: <CA+CK2bApV4A-hCO3eHX7-1QdjDX=FpnrVHfa8TQBt_1JStY-BA@mail.gmail.com>
Subject: Re: [RFC PATCH 03/10] liveupdate: do early initialization before
 hugepages are allocated
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Alexander Graf <graf@amazon.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251223_100937_486020_AE5FD5EB 
X-CRM114-Status: GOOD (  30.37  )
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

On Sat, Dec 6, 2025 at 6:03=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org>=
 wrote:
>
> To support hugepage preservation using LUO, the hugetlb subsystem needs
> to get liveupdate data when it allocates the hugepages to find out how
> many pages are coming from live update.
>
> Move early LUO init from early_initcall to mm_core_init(). This is where
> gigantic hugepages are allocated on ARM64. On x86, they are allocated in
> setup_arch(), so have a call there as well. Keep track of whether the
> function was already called to avoid double-init.
>
> liveupdate_early_init() only gets the KHO subtree and validates the data
> to ensure it is valid and understood. These are read-only operations and
> do not need much from the system, so it is safe to call early in boot.
>
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
> ---
>  arch/x86/kernel/setup.c          |  7 +++++++
>  include/linux/liveupdate.h       |  6 ++++++
>  kernel/liveupdate/luo_core.c     | 30 ++++++++++++++++++++++++++----
>  kernel/liveupdate/luo_internal.h |  2 ++
>  mm/mm_init.c                     |  7 +++++++
>  5 files changed, 48 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 9bf00287c408..e2ec779afc2c 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -26,6 +26,7 @@
>  #include <linux/tboot.h>
>  #include <linux/usb/xhci-dbgp.h>
>  #include <linux/vmalloc.h>
> +#include <linux/liveupdate.h>
>
>  #include <uapi/linux/mount.h>
>
> @@ -1216,6 +1217,12 @@ void __init setup_arch(char **cmdline_p)
>
>         kho_memory_init();
>
> +       /*
> +        * Hugepages might be preserved from a liveupdate. Make sure it i=
s
> +        * initialized so hugetlb can query its state.
> +        */
> +       liveupdate_early_init();
> +
>         if (boot_cpu_has(X86_FEATURE_GBPAGES)) {
>                 hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
>                 hugetlb_bootmem_alloc();
> diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
> index ed81e7b31a9f..78e8c529e4e7 100644
> --- a/include/linux/liveupdate.h
> +++ b/include/linux/liveupdate.h
> @@ -214,6 +214,8 @@ struct liveupdate_flb {
>
>  #ifdef CONFIG_LIVEUPDATE
>
> +void __init liveupdate_early_init(void);
> +
>  /* Return true if live update orchestrator is enabled */
>  bool liveupdate_enabled(void);
>
> @@ -233,6 +235,10 @@ int liveupdate_flb_get_outgoing(struct liveupdate_fl=
b *flb, void **objp);
>
>  #else /* CONFIG_LIVEUPDATE */
>
> +static inline void liveupdate_early_init(void)
> +{
> +}
> +
>  static inline bool liveupdate_enabled(void)
>  {
>         return false;
> diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
> index 7a9ef16b37d8..2c740ecad8e6 100644
> --- a/kernel/liveupdate/luo_core.c
> +++ b/kernel/liveupdate/luo_core.c
> @@ -69,6 +69,13 @@ static struct {
>         u64 liveupdate_num;
>  } luo_global;
>
> +static bool __luo_early_initialized __initdata;
> +
> +bool __init luo_early_initialized(void)
> +{
> +       return __luo_early_initialized;
> +}

I think the above is not needed, both the global variable, and a new functi=
on.

> +
>  static int __init early_liveupdate_param(char *buf)
>  {
>         return kstrtobool(buf, &luo_global.enabled);
> @@ -133,20 +140,35 @@ static int __init luo_early_startup(void)
>         return err;
>  }
>
> -static int __init liveupdate_early_init(void)
> +/*
> + * This should only be called after KHO FDT is known. It gets the LUO su=
btree
> + * and does initial validation, making early boot read-only access possi=
ble.
> + */
> +void __init liveupdate_early_init(void)
>  {
>         int err;
>
> +       /*
> +        * HugeTLB needs LUO to be initialized early in boot, before giga=
ntic
> +        * hugepages are allocated. On x86, that happens in setup_arch(),=
 but on
> +        * ARM64 (and other architectures) that happens in mm_core_init()=
.
> +        *
> +        * Since the code in mm_core_init() is shared between all archite=
ctures,
> +        * this can lead to the init being called twice. Skip if initiali=
zation
> +        * was already done.
> +        */
> +       if (__luo_early_initialized)
> +               return;
> +
> +       __luo_early_initialized =3D true;

Please, make __luo_early_initialized static local.

> +
>         err =3D luo_early_startup();
>         if (err) {
>                 luo_global.enabled =3D false;
>                 luo_restore_fail("The incoming tree failed to initialize =
properly [%pe], disabling live update\n",
>                                  ERR_PTR(err));
>         }
> -
> -       return err;
>  }
> -early_initcall(liveupdate_early_init);
>
>  /* Called during boot to create outgoing LUO fdt tree */
>  static int __init luo_fdt_setup(void)
> diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_int=
ernal.h
> index 6115d6a4054d..171c54af7b38 100644
> --- a/kernel/liveupdate/luo_internal.h
> +++ b/kernel/liveupdate/luo_internal.h
> @@ -114,6 +114,8 @@ int __init luo_flb_setup_outgoing(void *fdt);
>  int __init luo_flb_setup_incoming(void *fdt);
>  void luo_flb_serialize(void);
>
> +bool __init luo_early_initialized(void);
> +
>  #ifdef CONFIG_LIVEUPDATE_TEST
>  void liveupdate_test_register(struct liveupdate_file_handler *fh);
>  void liveupdate_test_unregister(struct liveupdate_file_handler *fh);
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 93cec06c1c8a..9a5b06a93622 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -31,6 +31,7 @@
>  #include <linux/execmem.h>
>  #include <linux/vmstat.h>
>  #include <linux/kexec_handover.h>
> +#include <linux/liveupdate.h>
>  #include <linux/hugetlb.h>
>  #include "internal.h"
>  #include "slab.h"
> @@ -2681,6 +2682,12 @@ void __init mm_core_init(void)
>         arch_mm_preinit();
>
>         kho_memory_init();
> +       /*
> +        * Hugepages might be preserved from a liveupdate. Make sure it i=
s
> +        * initialized so hugetlb can query its state.
> +        */
> +       liveupdate_early_init();
> +
>         hugetlb_bootmem_alloc();
>
>         /* Initializations relying on SMP setup */
> --
> 2.43.0
>


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE65FA3728
	for <kexec@archiver.kernel.org>; Fri,  2 Jan 2026 16:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zeSSjhvJc9NbrcAF6AZdEf+u5YF9OPhTESoyVoM1+Iw=; b=ykXHBQC+Pp1MpNGbRgOnD9iDNN
	hLr3HXLzLQsNjNjoPxHMiqX7C/Kv2tZlCvZUy20mckhlJSxPOACqblMGsuLvep5F1Myo2HSacc2ty
	bKf94CMbyaGqcpCyURqBecON1h+LKMKJ/tl96yqPmQ+kS657iO2WJ5PJpmU2eBRqmgguqmGn/Gyvj
	6Fa1mhLk9ag9yrS6m6dpncE3Go1XI/YmcTmUgU+Xvg7KdWTNu0S5KsQpVbln/GBRcz/Yr/+vYk+xy
	mEivJnv6klwda/Ausudu24NH6xWWRUgkLEFbSEfEdZP52ZkX0gBtYlPY5ewwObBYE7Pxoj3FwVGO+
	X2ZNDk6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbhrf-00000008UWp-00Q2;
	Fri, 02 Jan 2026 16:18:59 +0000
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbhrc-00000008UWG-1BUq
	for kexec@lists.infradead.org;
	Fri, 02 Jan 2026 16:18:57 +0000
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-64d80a47491so155121a12.1
        for <kexec@lists.infradead.org>; Fri, 02 Jan 2026 08:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1767370734; x=1767975534; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeSSjhvJc9NbrcAF6AZdEf+u5YF9OPhTESoyVoM1+Iw=;
        b=c4VfKbGHR36DALrDv9wEwhpTBqDt5c6l+NtRE3t9WvBb1lj4jKw2whtYFZgxSws9B3
         JKnVmMdDTt1gNZL7doHHyuYZ90ybAK61lH6Pe9e/BGo04jow2yRr4KM/tUCaBg1uXqbV
         mjVqGNq/8tApmHUUdZSLsoDKDoMjhe5b/JLvV/klmNsqdDVAwxCYhP5QoYL0q3rr8uRi
         tx1i70NYlxroN5PK+Hc3Rl+IoteCpOdRQuj4DV3/i1w9CKLou2oTli0w5tkNu2d1L6ES
         nZ5Smid4hUyDgL9w1OGSOMvdAsRxutvZr84VTFgY2pYV1GKVrkHqA1wf3OtH6vr2c9NU
         6lgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767370734; x=1767975534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zeSSjhvJc9NbrcAF6AZdEf+u5YF9OPhTESoyVoM1+Iw=;
        b=v6S1bJJ8c1BmVc1oLvUspSf6dnadgnfo1NczfuGGPC+wGe7OJgEXs8vLjH5lOWf50w
         1ji8HELgidkkxgiynEKcDZ4GtDa3P6hFb/55af8LRQdcMWI5nWn7VJepoiSKBUPBEW8o
         ZM0Ii8ZHGnDs5CLO/PQVnUBsFIsvpIoxIHpMchmwI6SXSMoKtjKogoDG5+2iwaFHS3n5
         FcoML7DOuQ2TXLaA/50+ntFuP46DygPExlxTuVCbgRMV0+YyEPCcFYQExHBF84LFaE4Z
         8ODXnCtOSEAcerY/jequ4XL69Cy2yD6biNGQr+yuHRnQp9csf48900zAdf9LNWuNkL8p
         CMzQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9b0+eFzncecRdmiQVsEIQ1n0DPl91JNgVUW+1VPKnF+gO/opwBTxX7Pz5FnkQ7wA2nN5dig==@lists.infradead.org
X-Gm-Message-State: AOJu0YxG6FwcT3oNAmZv5KasjipbJCGUd7ajWYXJ+ylt818gQHWD+LcY
	p0BzDT0+QrwuS5/276zWiWClhVmtE2X68Ytcba8+DfEv4sxczYuJfYQk4XMwwcsTReHywAkjE2S
	ugGwxpBnz4T/wDpqF1aqWRFWufuKPZJzCrG32hq5lTQ==
X-Gm-Gg: AY/fxX7j/SYnF0q3nkFUgt8GEjUaytYI2vR+yziXxLugibV8FGf2fRsxQgmrvOkyHuV
	k4PwuchY4R75T+tsILU4CrGjIxfO/HWPzL0VpHtohBJYW2mH9xrI5aLMfNZ0mZ1FhZ5UkXJP2JC
	vEHoiI/EDakUzU9aSFgTohoL8w2e88Gc3f0okg9vkDhMrKZsxUMEXG3uKt2MGiLTsGKqiGiRbI7
	z54rpQcRoWIg1nDIu2l4nP0UctmYZxGCK9RWS7msJSFX+0qKSN3sJ1hNsuQK35yINoNE/i2UkfH
	VrKBbv/2BblpVNjKIQe7ZaqgLw==
X-Google-Smtp-Source: AGHT+IHtn3UsaIXslAlt12Rz3O0Gv/1EEh0UkZgY/dVxYDUflHpcNxeZ23ykq9/lKqCwP3DVceW2HXyq1NR2iJLFSgc=
X-Received: by 2002:aa7:db44:0:b0:640:93ea:8ff3 with SMTP id
 4fb4d7f45d1cf-64fd4c61696mr161286a12.13.1767370733817; Fri, 02 Jan 2026
 08:18:53 -0800 (PST)
MIME-Version: 1.0
References: <20260102-kho-v2-0-1747b1a3a1d6@debian.org> <20260102-kho-v2-1-1747b1a3a1d6@debian.org>
In-Reply-To: <20260102-kho-v2-1-1747b1a3a1d6@debian.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 2 Jan 2026 11:18:16 -0500
X-Gm-Features: AQt7F2rxDAXLSMcs3XAyYfXHtg1p8NF7W4L-cxju6b-9ZMk5GeGor7WCGXUdfPY
Message-ID: <CA+CK2bBKJqSEdvNYwVQvgBJZdWjn8vmbHo=L=eYLjcaMN3954Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kexec: history: track previous kernel version
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, usamaarif642@gmail.com, 
	rmikey@meta.com, clm@fb.com, riel@surriel.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260102_081856_348447_B78DD0F4 
X-CRM114-Status: GOOD (  30.09  )
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

On Fri, Jan 2, 2026 at 9:53=E2=80=AFAM Breno Leitao <leitao@debian.org> wro=
te:
>
> Add CONFIG_KEXEC_HISTORY to store and display the kernel version from
> the previous kexec boot.

I do not think we need a config. Let's just enable this by default, as
I suggested in RFC.

>
> When enabled, the current kernel's release string is saved to the
> "previous-release" property in the KHO device tree before kexec. On
> the next boot, if this property exists, the previous kernel version
> is retrieved and printed during early boot.
>
> This helps diagnose bugs that only manifest when kexecing from
> specific kernel versions, making it easier to correlate crashes with
> the kernel that initiated the kexec.
>
> Disabled by default to avoid overhead for users who don't need this
> information.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  kernel/Kconfig.kexec               | 13 +++++++++++++
>  kernel/liveupdate/kexec_handover.c | 29 +++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index 15632358bcf7..b770c68a3800 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -94,6 +94,19 @@ config KEXEC_JUMP
>           Jump between original kernel and kexeced kernel and invoke
>           code in physical address mode via KEXEC
>
> +config KEXEC_HISTORY
> +       bool "Track kexec kernel history"
> +       depends on KEXEC_HANDOVER
> +       help
> +         When enabled, the kernel will store its release version in the
> +         KHO FDT before kexec, and the newly booted kernel will read and
> +         print this information during early boot.
> +
> +         This is useful for debugging and auditing to know which kernel
> +         version performed the kexec that booted the current kernel.
> +
> +         If unsure, say N.
> +
>  config CRASH_DUMP
>         bool "kernel crash dumps"
>         default ARCH_DEFAULT_CRASH_DUMP
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec=
_handover.c
> index 73da00aeaa99..06d99627bb3c 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -21,6 +21,7 @@
>  #include <linux/page-isolation.h>
>  #include <linux/unaligned.h>
>  #include <linux/vmalloc.h>
> +#include <linux/utsname.h>
>
>  #include <asm/early_ioremap.h>
>
> @@ -36,6 +37,7 @@
>  #define KHO_FDT_COMPATIBLE "kho-v1"
>  #define PROP_PRESERVED_MEMORY_MAP "preserved-memory-map"
>  #define PROP_SUB_FDT "fdt"
> +#define PROP_PREVIOUS_RELEASE "previous-release"
>
>  #define KHO_PAGE_MAGIC 0x4b484f50U /* ASCII for 'KHOP' */
>
> @@ -1253,6 +1255,9 @@ bool kho_finalized(void)
>  struct kho_in {
>         phys_addr_t fdt_phys;
>         phys_addr_t scratch_phys;
> +#ifdef CONFIG_KEXEC_HISTORY
> +       char previous_release[__NEW_UTS_LEN + 1];
> +#endif
>         struct kho_debugfs dbg;
>  };
>
> @@ -1332,6 +1337,10 @@ static __init int kho_out_fdt_setup(void)
>         err |=3D fdt_property_string(root, "compatible", KHO_FDT_COMPATIB=
LE);
>         err |=3D fdt_property(root, PROP_PRESERVED_MEMORY_MAP, &empty_mem=
_map,
>                             sizeof(empty_mem_map));
> +#ifdef CONFIG_KEXEC_HISTORY
> +       err |=3D fdt_property_string(root, PROP_PREVIOUS_RELEASE,
> +                                  init_uts_ns.name.release);
> +#endif
>         err |=3D fdt_end_node(root);
>         err |=3D fdt_finish(root);
>
> @@ -1455,6 +1464,25 @@ void __init kho_memory_init(void)
>         }
>  }
>
> +#ifdef CONFIG_KEXEC_HISTORY
> +static void __init kho_print_previous_kernel(const void *fdt)
> +{
> +       const char *prev_release;
> +       int len;
> +
> +       prev_release =3D fdt_getprop(fdt, 0, PROP_PREVIOUS_RELEASE, &len)=
;
> +       if (!prev_release || len <=3D 0)
> +               return;
> +
> +       strscpy(kho_in.previous_release, prev_release,
> +               sizeof(kho_in.previous_release));
> +       pr_info("This kernel was kexec'ed from kernel release: %s\n",
> +               kho_in.previous_release);

May be reduce the message slightly:
i.e. "kexec from: %s\n, kho_in.previous_release"

> +}
> +#else
> +static void __init kho_print_previous_kernel(const void *fdt) { }
> +#endif
> +
>  void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>                          phys_addr_t scratch_phys, u64 scratch_len)
>  {
> @@ -1527,6 +1555,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 =
fdt_len,
>         kho_in.scratch_phys =3D scratch_phys;
>         kho_scratch_cnt =3D scratch_cnt;
>         pr_info("found kexec handover data.\n");

This message is not needed if the previous kernel version is always printed=
.

> +       kho_print_previous_kernel(fdt);
>
>  out:
>         if (fdt)
>
> --
> 2.47.3
>


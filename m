Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB1BC02198
	for <kexec@archiver.kernel.org>; Mon, 10 Feb 2025 16:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iMSmHPU88YDOwPSpB5j+WYq7IwFLmL60+7nFTkoWpv8=; b=ujWBRV/LQ653uIvdd0kPjkdAPo
	P9cAOC/UiOjPaRn5Y7aSaJoownST5C7SwkzcuBLXNCEg5HV13M1oL+HC3xJTPeJE/sHg20hThFZi7
	I0uGrYwZ4Pep4AQTRSjnbdSD3/PSBFNYRM2U1wpa81UAlFlxTfQC/TH2K5OYyBOI/7lM7X7oh2lA1
	McPVSe7tAocVbRlLJy6/wy2hAsWeq0HWHKX1QRkt1tAZ4G0kKPzXuFZb6VqSgldKYMnOp4oKHE+a4
	8jmN3G+FHplGTNXt66XgkKZpA+0jjVy5qMo4Zx3mBcjyx5eOexVSiP9n1Sma2RWIZ3+x08+obRIk6
	7xrvUqRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thWJw-00000000RBk-02xe;
	Mon, 10 Feb 2025 16:07:40 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thWGa-00000000QNf-2z30;
	Mon, 10 Feb 2025 16:04:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EF3375C5A95;
	Mon, 10 Feb 2025 16:03:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492DEC4CEE5;
	Mon, 10 Feb 2025 16:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739203451;
	bh=MmLzTVOIrpo7J0HmbhxBdjKvlFVJINa0c786cp4K2is=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IMZF+ghuSiCCJz57Q5USpgV4CW3vxkE+nfMG1knu6gzbU8ZVVARB0CrktiwrIk67E
	 Hp+1zFYkDBupPWkLP2fek6SjxBtdd8uZX3bsyrNGaGd3VDsFNAQzMV0B8Bw7PLqno7
	 J8yGHYrFy3lE1q9NnvTqoTJ6L6/fNTihHlNov7BXlXsi3mInlQtMMtxsIsIU8E/YP2
	 6fuhEdcGiIM2KpifkoHYPYf7AyXzUlFejV237V6OD7muNrezl//ORBJCZM9V0Z2cGP
	 fe78vxqe0+Y6PyqE84mgPUSfNDFYrpSDzRGZFIFOrU6co1irCDDPsKdgFbxPQ6BLzB
	 vldIL+nl53Ugw==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5de4c7720bcso5034094a12.0;
        Mon, 10 Feb 2025 08:04:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU73aOjIrKOrTr8FH+snA6xDDLSlf6tfAKyZ8rzM20eidHLtx6wh8qRSDteR7RUDSAR6uJ0kg==@lists.infradead.org, AJvYcCWOh8QrSp7em/Q//sGN+zN1E8L4Ywkaz6RTRuUEXNp9pB8PXt3xVSgHAu1reBGAvRvu7JQ1/DKM2ygaLkdyxWbgIA==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywjw/PY1gqF5U6hFp/KfpCiL6VOnuGawElbGyYvQg2mQ/D72sCz
	GIKXSQNYScZOpAVyglisvofcQa8eU5NV6Ofr8QB8AoshdBi4js95rRguNpOI5p5u88qpoXQN2HC
	ebgL5zdE8F3aJDgAHQrmZFtr/FQ==
X-Google-Smtp-Source: AGHT+IFRZNJEmIDWeGq7jBDTWhH6Y05jOZW3+7OggCVpp9D3eKLI+N0SQhYn4TTzkQ07b3SjWfpk0D6PnrkmWhtaNlQ=
X-Received: by 2002:a05:6402:4308:b0:5de:5cea:869e with SMTP id
 4fb4d7f45d1cf-5de5cea8b38mr8326232a12.32.1739203449824; Mon, 10 Feb 2025
 08:04:09 -0800 (PST)
MIME-Version: 1.0
References: <20250206132754.2596694-1-rppt@kernel.org> <20250206132754.2596694-14-rppt@kernel.org>
In-Reply-To: <20250206132754.2596694-14-rppt@kernel.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 10 Feb 2025 10:03:58 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLBf1Vv6K5mK6x9JRqegvScSNFpAEE2iJOkJ4JuBTLsCw@mail.gmail.com>
X-Gm-Features: AWEUYZkqxkn1PB0pgkw5chjo9LRqD9SA0TtsGYB7u__vI-ErDb4_rUvPql-Dcx4
Message-ID: <CAL_JsqLBf1Vv6K5mK6x9JRqegvScSNFpAEE2iJOkJ4JuBTLsCw@mail.gmail.com>
Subject: Re: [PATCH v4 13/14] memblock: Add KHO support for reserve_mem
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Anthony Yznaga <anthony.yznaga@oracle.com>, Arnd Bergmann <arnd@arndb.de>, 
	Ashish Kalra <ashish.kalra@amd.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, 
	Eric Biederman <ebiederm@xmission.com>, Ingo Molnar <mingo@redhat.com>, 
	James Gowans <jgowans@amazon.com>, Jonathan Corbet <corbet@lwn.net>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Pratyush Yadav <ptyadav@amazon.de>, 
	Saravana Kannan <saravanak@google.com>, 
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Usama Arif <usama.arif@bytedance.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250210_080412_847298_246F4B7B 
X-CRM114-Status: GOOD (  36.49  )
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

On Thu, Feb 6, 2025 at 7:30=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wrot=
e:
>
> From: Alexander Graf <graf@amazon.com>
>
> Linux has recently gained support for "reserve_mem": A mechanism to
> allocate a region of memory early enough in boot that we can cross our
> fingers and hope it stays at the same location during most boots, so we
> can store for example ftrace buffers into it.
>
> Thanks to KASLR, we can never be really sure that "reserve_mem"
> allocations are static across kexec. Let's teach it KHO awareness so
> that it serializes its reservations on kexec exit and deserializes them
> again on boot, preserving the exact same mapping across kexec.
>
> This is an example user for KHO in the KHO patch set to ensure we have
> at least one (not very controversial) user in the tree before extending
> KHO's use to more subsystems.
>
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  mm/memblock.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 131 insertions(+)
>
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 84df96efca62..fdb08b60efc1 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -16,6 +16,9 @@
>  #include <linux/kmemleak.h>
>  #include <linux/seq_file.h>
>  #include <linux/memblock.h>
> +#include <linux/kexec_handover.h>
> +#include <linux/kexec.h>
> +#include <linux/libfdt.h>
>
>  #include <asm/sections.h>
>  #include <linux/io.h>
> @@ -2423,6 +2426,70 @@ int reserve_mem_find_by_name(const char *name, phy=
s_addr_t *start, phys_addr_t *
>  }
>  EXPORT_SYMBOL_GPL(reserve_mem_find_by_name);
>
> +static bool __init reserve_mem_kho_revive(const char *name, phys_addr_t =
size,
> +                                         phys_addr_t align)
> +{
> +       const void *fdt =3D kho_get_fdt();
> +       const char *path =3D "/reserve_mem";
> +       int node, child, err;
> +
> +       if (!IS_ENABLED(CONFIG_KEXEC_HANDOVER))
> +               return false;
> +
> +       if (!fdt)
> +               return false;
> +
> +       node =3D fdt_path_offset(fdt, "/reserve_mem");
> +       if (node < 0)
> +               return false;
> +
> +       err =3D fdt_node_check_compatible(fdt, node, "reserve_mem-v1");
> +       if (err) {
> +               pr_warn("Node '%s' has unknown compatible", path);
> +               return false;
> +       }
> +
> +       fdt_for_each_subnode(child, fdt, node) {
> +               const struct kho_mem *mem;
> +               const char *child_name;
> +               int len;
> +
> +               /* Search for old kernel's reserved_mem with the same nam=
e */
> +               child_name =3D fdt_get_name(fdt, child, NULL);
> +               if (strcmp(name, child_name))
> +                       continue;
> +
> +               err =3D fdt_node_check_compatible(fdt, child, "reserve_me=
m_map-v1");

It really seems you all are trying to have things both ways. It's not
Devicetree, just the FDT file format, but then here you use
"compatible" which *is* Devicetree. At best, it's all just confusing
for folks. At worst, you're just picking and choosing what you want to
use.

I'm not saying don't use "compatible" just for the sake of looking
less like DT, but perhaps your versioning should be done differently.
You are reading the 'mem' property straight into a struct. Maybe the
struct should have a version. Or the size of the struct is the version
much like the userspace ABI is handled for structs.

> +               if (err) {
> +                       pr_warn("Node '%s/%s' has unknown compatible", pa=
th, name);
> +                       continue;
> +               }
> +
> +               mem =3D fdt_getprop(fdt, child, "mem", &len);
> +               if (!mem || len !=3D sizeof(*mem))
> +                       continue;
> +
> +               if (mem->addr & (align - 1)) {

It's stated somewhere in this that the FDT data is LE, but here you
are assuming the FDT is the same endianness as the CPU not that it's
LE. Arm64 can do BE. PowerPC does both. I'm not sure if kexec from one
endianness to another is possible. I would guess in theory it is and
in practice it's broken already (because kexec is always an
afterthought). Either you need to guarantee that native endianness
will never be an issue for any arch or you need to make the endianness
fixed.

Rob


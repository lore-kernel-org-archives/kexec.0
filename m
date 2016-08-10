Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bXKed-0003aY-FI
 for kexec@lists.infradead.org; Wed, 10 Aug 2016 03:58:08 +0000
Received: by mail-pf0-f174.google.com with SMTP id p64so11455121pfb.1
 for <kexec@lists.infradead.org>; Tue, 09 Aug 2016 20:57:46 -0700 (PDT)
Date: Wed, 10 Aug 2016 09:27:43 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH v3 2/3] arm64: Add arm64 kexec support
Message-ID: <20160810035743.GA27500@localhost.localdomain>
References: <cover.1470693832.git.geoff@infradead.org>
 <177affa377979b1f10d5bd39107b96fe506eb683.1470693832.git.geoff@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <177affa377979b1f10d5bd39107b96fe506eb683.1470693832.git.geoff@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Geoff,

On 08/08/2016:10:19:33 PM, Geoff Levand wrote:
> Add kexec reboot support for ARM64 platforms.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---

> +
> +		arm64_mem.page_offset = ehdr.e_entry - arm64_mem.text_offset;
> +
> +		dbgprintf("%s: e_entry:       %016llx -> %016lx\n", __func__,
> +			ehdr.e_entry,
> +			virt_to_phys(ehdr.e_entry));
> +		dbgprintf("%s: p_vaddr:       %016llx -> %016lx\n", __func__,
> +			phdr->p_vaddr,
> +			virt_to_phys(phdr->p_vaddr));
> +		dbgprintf("%s: header_offset: %016lx\n", __func__,
> +			header_offset);
> +		dbgprintf("%s: text_offset:   %016lx\n", __func__,
> +			arm64_mem.text_offset);
> +		dbgprintf("%s: image_size:    %016lx\n", __func__,
> +			arm64_mem.image_size);
> +		dbgprintf("%s: phys_offset:   %016lx\n", __func__,
> +			arm64_mem.phys_offset);
> +		dbgprintf("%s: page_offset:   %016lx\n", __func__,
> +			arm64_mem.page_offset);

Although it works on mustang, I would like to understand few things:

This is what is being printed by kexec-tools:

elf_arm64_load: e_entry:       fffffc0008080000 -> 0000004000080000
elf_arm64_load: p_vaddr:       fffffc0008080000 -> 0000004000080000
elf_arm64_load: header_offset: 0000000000000000
elf_arm64_load: text_offset:   0000000000080000
elf_arm64_load: image_size:    00000000013a0000
elf_arm64_load: phys_offset:   0000004000000000
elf_arm64_load: page_offset:   fffffc0008000000

kernel is having 42 VA Bits, so a debug print in kernel says that
PAGE_OFFSET=fffffe0000000000. Notice the difference between the values
calculated by kernel and kexec-tools. Isn't it confusing? I think kexec-tools
page_offset is text_page_offset and not the one which kernel uses. So, probably
we can rename it accordingly. Otherwise, we may sync kexec-tools's
virt_to_phys() and vice-versa definitions with that of kernel definitions.

In my case, kernel has kimage_voffset=fffffbc008000000. So kernel translate
virtual address fffffc0008080000 as fffffc0008080000 - fffffbc008000000 =
0000004000080000 which is matching to the one calculated by kexec-tools (for
e_entry).

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

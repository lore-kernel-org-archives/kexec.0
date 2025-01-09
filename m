Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE86E77197
	for <kexec@archiver.kernel.org>; Thu,  9 Jan 2025 15:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QfPumVhxmW44KPDHbWCPCC6NHA7pW5e/EmTJnTfES50=; b=SpNYUROxd4qfcqN+R85+hu4I9w
	cux8RhhxJspa9paHSMGH7MFrIMAbTM5BIug9NSfG87cELRww9IT7cyAabmJmjpoAO8BcbkEpRGqBy
	/OgZB1rJN7sQ8Acrd2dKX1uSa8LQK+W5za7il0D/1ALYIPPBhNKM5AICfPpYF+RA2MqddVJ9XgB+1
	1iXxMZWjZc2KwAluAUa7/BUkCbbG+PAFBy2yBL5xhVjYdzV7T5uF7id8sCI1bTH09C4/d1vO1mWPK
	xxJ9vARgAr5rKwZf3J71wLUm53qHFdrUC35ymbfe+K3oRJ+KaHcVCFUSQ3Jykx8FWntaX4/UTiiKT
	4XFy+V1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVuj1-0000000CWeS-0GOk;
	Thu, 09 Jan 2025 15:45:35 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVuiz-0000000CWdf-0NzY
	for kexec@lists.infradead.org;
	Thu, 09 Jan 2025 15:45:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id BBB87A4202A
	for <kexec@lists.infradead.org>; Thu,  9 Jan 2025 15:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E757CC4CEE4
	for <kexec@lists.infradead.org>; Thu,  9 Jan 2025 15:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736437531;
	bh=B5qGzh3F3kerw7P377R3DsRB1w+E7Ta1ahc6bkUY/1M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cmRkMjY8OsIYYJDWKSpjhw+g+1zB4rBWS7SE3iX5pPFtvLujNylb8kt2Fqr54vP+q
	 KUra8lVVKeiRM3F4onBR98Rv59+Nkv/C4T8tzq3ZNjJC5PUpPQLC7EnnketY4MN7WP
	 5laxah/hDyJw1lb6Pn+padKhPWYms3hI3auLtTSmpeXvlXlm5PZ2BOzP2RAW/zBPBL
	 X35uZMXUS0ZWzlrkIyaO7BoOVGP0+M1UlyNNalPNAoKE3zEg81soUYNbTw2JZ9jMV8
	 mA+/O8ObKIEh4ksS647Y287P4Jok/a82Zrt5pN7c/XGRZUGIVfJ8RJyYv0gQf9iJe6
	 Yaj9Jgygdp5kg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53ff1f7caaeso1076073e87.0
        for <kexec@lists.infradead.org>; Thu, 09 Jan 2025 07:45:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCURKjWXBsz1P36D45G1yNLELPeLlBUnz4OPhq+5H17cMHZQahPE8sU5R4d6Xo6Xo+HB88ES5Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YyZWaTFguyJsSy1PdQ0VtuEVFVtAyLMsEVXY8bs7HZzMJ4rl5Yj
	NRS/sXGfxYcrFsDxKLMrL5nkxr4ulEiVOHk9mh6eBsaEILoFz8+ZpAfqfFG/fj/D4R6AuOP4KBj
	qZuOZQ8FuoeLRcgApe1qfMkWSTfw=
X-Google-Smtp-Source: AGHT+IFGG2VZLnb6Rf9cPbXGfRKdHD2AX/axHtZpfvjPsUUlrem6ul0qd2lRvBmBrREq0G7sO/Ktr8Z6TbVGz2UNujk=
X-Received: by 2002:a05:6512:b8b:b0:542:249c:2156 with SMTP id
 2adb3069b0e04-5428452b8bcmr2118447e87.15.1736437530239; Thu, 09 Jan 2025
 07:45:30 -0800 (PST)
MIME-Version: 1.0
References: <20250108215957.3437660-1-usamaarif642@gmail.com> <20250108215957.3437660-2-usamaarif642@gmail.com>
In-Reply-To: <20250108215957.3437660-2-usamaarif642@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 9 Jan 2025 16:45:18 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH54Y0ae1OGwBe7-UiRBq9cFkDHbjxos_rEZPtan7NNzQ@mail.gmail.com>
X-Gm-Features: AbW1kvY3sSuQK6Y-79x26wc0_PSSMv_8bcWle1lLxS4GweITKQnpqDTYjg3HPTc
Message-ID: <CAMj1kXH54Y0ae1OGwBe7-UiRBq9cFkDHbjxos_rEZPtan7NNzQ@mail.gmail.com>
Subject: Re: [RFC 1/2] efi/memattr: Use desc_size instead of total size to
 check for corruption
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io, kexec@lists.infradead.org, 
	hannes@cmpxchg.org, dyoung@redhat.com, x86@kernel.org, 
	linux-kernel@vger.kernel.org, leitao@debian.org, gourry@gourry.net, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250109_074533_270407_9C343CDE 
X-CRM114-Status: GOOD (  32.83  )
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

On Wed, 8 Jan 2025 at 23:00, Usama Arif <usamaarif642@gmail.com> wrote:
>
> The commit in [1] introduced a check to see if EFI memory attributes
> table was corrupted. It assumed that efi.memmap.nr_map remains
> constant, but it changes during late boot.
> Hence, the check is valid during cold boot, but not in the subsequent
> kexec boot.
>
> This is best explained with an exampled. At cold boot, for a test
> machine:
> efi.memmap.nr_map=91,
> memory_attributes_table->num_entries=48,
> desc_size = 48
> Hence, the check introduced in [1] where 3x the size of the
> entire EFI memory map is a reasonable upper bound for the size of this
> table is valid.
>
> In late boot __efi_enter_virtual_mode calls 2 functions that updates
> efi.memmap.nr_map:
> - efi_map_regions which reduces the `count` of map entries
>   (for e.g. if should_map_region returns false) and which is reflected
>   in efi.memmap by __efi_memmap_init.
>   At this point efi.memmap.nr_map becomes 46 in the test machine.
> - efi_free_boot_services which also reduces the number of memory regions
>   available (for e.g. if md->type or md->attribute is not the right value).
>   At this point efi.memmap.nr_map becomes 9 in the test machine.
> Hence when you kexec into a new kernel and pass efi.memmap, the
> paramaters that are compared are:
> efi.memmap.nr_map=9,
> memory_attributes_table->num_entries=48,
> desc_size = 48
> where the check in [1] is no longer valid with such a low efi.memmap.nr_map
> as it was reduced due to efi_map_regions and efi_free_boot_services.
>
> A more appropriate check is to see if the description size reported by
> efi and memory attributes table is the same.
>
> [1] https://lore.kernel.org/all/20241031175822.2952471-2-ardb+git@google.com/
>
> Fixes: 8fbe4c49c0cc ("efi/memattr: Ignore table if the size is clearly bogus")
> Reported-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  drivers/firmware/efi/memattr.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>

The more I think about this, the more I feel that kexec on x86 should
simply discard this table, and run with the firmware code RWX (which
is not the end of the world).

The main reason is that the EFI memory map and the EFI memory
attributes table are supposed to be a matched pair, where each RTcode
entry in the former is broken down into multiple code and data
segments in the latter. The amount of mangling that the x86 arch code
does of the EFI memory map makes it intractable to ensure that they
remain in sync, and so it is better not to bother.


> diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
> index c38b1a335590..d3bc161361fb 100644
> --- a/drivers/firmware/efi/memattr.c
> +++ b/drivers/firmware/efi/memattr.c
> @@ -40,21 +40,17 @@ int __init efi_memattr_init(void)
>                 goto unmap;
>         }
>
> -
>         /*
> -        * Sanity check: the Memory Attributes Table contains up to 3 entries
> -        * for each entry of type EfiRuntimeServicesCode in the EFI memory map.
> -        * So if the size of the table exceeds 3x the size of the entire EFI
> -        * memory map, there is clearly something wrong, and the table should
> -        * just be ignored altogether.
> +        * Sanity check: the Memory Attributes Table desc_size and
> +        * efi.memmap.desc_size should match.
>          */
> -       size = tbl->num_entries * tbl->desc_size;
> -       if (size > 3 * efi.memmap.nr_map * efi.memmap.desc_size) {
> -               pr_warn(FW_BUG "Corrupted EFI Memory Attributes Table detected! (version == %u, desc_size == %u, num_entries == %u)\n",
> -                       tbl->version, tbl->desc_size, tbl->num_entries);
> +       if (efi.memmap.desc_size != tbl->desc_size) {
> +               pr_warn(FW_BUG "Corrupted EFI Memory Attributes Table detected! (version == %u, table desc_size == %u, efi.memmap.desc_size == %lu, table num_entries == %u)\n",
> +                       tbl->version, tbl->desc_size, efi.memmap.desc_size, tbl->num_entries);
>                 goto unmap;
>         }
>
> +       size = tbl->num_entries * tbl->desc_size;
>         tbl_size = sizeof(*tbl) + size;
>         memblock_reserve(efi_mem_attr_table, tbl_size);
>         set_bit(EFI_MEM_ATTR, &efi.flags);
> --
> 2.43.5
>


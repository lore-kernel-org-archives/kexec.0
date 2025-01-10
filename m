Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D213E77188
	for <kexec@archiver.kernel.org>; Fri, 10 Jan 2025 07:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E5FQyYuJRAqTDtcg2R1PwlZyl3j/wbKGhcADYTV2RiI=; b=QeJicSPw7+xdXGQBS8qY4Xex8j
	5Y94/PKRlMqztrRyMSbkCh0s2+DvmXMny8eQCqcsv6zN85fJe+V5BIc8LGx6O6Z9SBQ/mqG+dGalX
	jfbBMqBEl24c0XPnN2anGPMlWhsaY3+6aiG4lXBRdR1BoLh6eauWhFAHcoLkER+nOYV1l8eKgVhk8
	6CpuOC3O3YghvR9EK5DDLtA3bUyNvJjuZgyPfZq7+0JB9+OAB4iEpjn6+hoF6+qjYXim95CcN8zbo
	rJkLCHe0ECY7fSdod0eZt9N06eKaxInxAe/YpHA4xh4H7KlTzYN+Ngl5CRdjKejlr5SELZxXNza7q
	egfxprTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tW9NJ-0000000EMh9-21xv;
	Fri, 10 Jan 2025 07:24:09 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tW9NG-0000000EMeV-1bKV
	for kexec@lists.infradead.org;
	Fri, 10 Jan 2025 07:24:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 86E70A41A1C
	for <kexec@lists.infradead.org>; Fri, 10 Jan 2025 07:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FCFC4CEE5
	for <kexec@lists.infradead.org>; Fri, 10 Jan 2025 07:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736493844;
	bh=ONjJpzfv9Zxk2928li0BEitQLEUhD2tb/bzhAdSta+4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mlqtP4f7yLqe9jqY1wvABgSYtJQ/KT8ckCH3jOjNC78qpHkDbDdfWWTusH7SH+AdL
	 v+y4ODqcCIpDG1Vr0gp6kgujKfG4cao3Ney0QVKjj/FyLlji+6ZuZXGwa4Ocm2r16y
	 DZtxQTa9EsgZ/Enkn9+wlcriHH1MWuKiZRQwJK8+6ndu/Nmw0iITZBP4i1sGMSdDof
	 cS2IoS2dP8H7TqnsWGjdnZeGRau0pf5WHSG+01InUKUlx66yJUPQhWkt7QNhiFIDBZ
	 nXxOB19/88YKzI82fYZfS7QaemmmYAQB+ObrqyGTdJb2pQxEDBbgU3wkh5oIRcQP4e
	 oNe8pJXQ2I5bA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-540254357c8so1621921e87.1
        for <kexec@lists.infradead.org>; Thu, 09 Jan 2025 23:24:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVAZcM0iv03OW6+lAMgtxL4FnXrfODIaqrVCFNNTMb5fJJK2IHSeXLMAWKG7bEgMPNG6aR0Zg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx0LEW+7hyvX0ROCfGetGKL1DAfnija/SMgR5uaZn/mCSUOYt61
	fZaTBcOiMif+g5mNFhBydPyyjliwONoVlvpC2NlQOKhbEeuFscRnqpb1d6gs/6kM1c42aNBYO45
	FVh/5wdQ2YSKdz12tOK6/Ylhu1e0=
X-Google-Smtp-Source: AGHT+IGYqkfOo1l5vp36+uebNKlLgeJDXUixK18FpXwrJSpHyumiIGT64CNoieQ3oaHhrHajrgMKZe9lPCDnkLCfZdM=
X-Received: by 2002:a05:6512:3082:b0:542:6d01:f54d with SMTP id
 2adb3069b0e04-542844f3fc1mr3354249e87.3.1736493843027; Thu, 09 Jan 2025
 23:24:03 -0800 (PST)
MIME-Version: 1.0
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-2-usamaarif642@gmail.com> <CAMj1kXH54Y0ae1OGwBe7-UiRBq9cFkDHbjxos_rEZPtan7NNzQ@mail.gmail.com>
 <d9c84079-6593-43f4-9483-648b665f03db@gmail.com>
In-Reply-To: <d9c84079-6593-43f4-9483-648b665f03db@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 10 Jan 2025 08:21:21 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGYsJrqDzy_+g_wSAAEuQ_OnxvyJ8ZE+4gbr6KOY7iuow@mail.gmail.com>
X-Gm-Features: AbW1kvaLZXidD5PN4oD-GwjBbzl6R0uQiwKJYbNGyIakDi17-k8ZzLnZ277sE34
Message-ID: <CAMj1kXGYsJrqDzy_+g_wSAAEuQ_OnxvyJ8ZE+4gbr6KOY7iuow@mail.gmail.com>
Subject: Re: [RFC 1/2] efi/memattr: Use desc_size instead of total size to
 check for corruption
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io, kexec@lists.infradead.org, 
	hannes@cmpxchg.org, dyoung@redhat.com, x86@kernel.org, 
	linux-kernel@vger.kernel.org, leitao@debian.org, gourry@gourry.net, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250109_232406_550453_B800DCFB 
X-CRM114-Status: GOOD (  30.10  )
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

On Thu, 9 Jan 2025 at 17:36, Usama Arif <usamaarif642@gmail.com> wrote:
>
>
>
> On 09/01/2025 15:45, Ard Biesheuvel wrote:
> > On Wed, 8 Jan 2025 at 23:00, Usama Arif <usamaarif642@gmail.com> wrote:
> >>
> >> The commit in [1] introduced a check to see if EFI memory attributes
> >> table was corrupted. It assumed that efi.memmap.nr_map remains
> >> constant, but it changes during late boot.
> >> Hence, the check is valid during cold boot, but not in the subsequent
> >> kexec boot.
> >>
> >> This is best explained with an exampled. At cold boot, for a test
> >> machine:
> >> efi.memmap.nr_map=91,
> >> memory_attributes_table->num_entries=48,
> >> desc_size = 48
> >> Hence, the check introduced in [1] where 3x the size of the
> >> entire EFI memory map is a reasonable upper bound for the size of this
> >> table is valid.
> >>
> >> In late boot __efi_enter_virtual_mode calls 2 functions that updates
> >> efi.memmap.nr_map:
> >> - efi_map_regions which reduces the `count` of map entries
> >>   (for e.g. if should_map_region returns false) and which is reflected
> >>   in efi.memmap by __efi_memmap_init.
> >>   At this point efi.memmap.nr_map becomes 46 in the test machine.
> >> - efi_free_boot_services which also reduces the number of memory regions
> >>   available (for e.g. if md->type or md->attribute is not the right value).
> >>   At this point efi.memmap.nr_map becomes 9 in the test machine.
> >> Hence when you kexec into a new kernel and pass efi.memmap, the
> >> paramaters that are compared are:
> >> efi.memmap.nr_map=9,
> >> memory_attributes_table->num_entries=48,
> >> desc_size = 48
> >> where the check in [1] is no longer valid with such a low efi.memmap.nr_map
> >> as it was reduced due to efi_map_regions and efi_free_boot_services.
> >>
> >> A more appropriate check is to see if the description size reported by
> >> efi and memory attributes table is the same.
> >>
> >> [1] https://lore.kernel.org/all/20241031175822.2952471-2-ardb+git@google.com/
> >>
> >> Fixes: 8fbe4c49c0cc ("efi/memattr: Ignore table if the size is clearly bogus")
> >> Reported-by: Breno Leitao <leitao@debian.org>
> >> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> >> ---
> >>  drivers/firmware/efi/memattr.c | 16 ++++++----------
> >>  1 file changed, 6 insertions(+), 10 deletions(-)
> >>
> >
> > The more I think about this, the more I feel that kexec on x86 should
> > simply discard this table, and run with the firmware code RWX (which
> > is not the end of the world).
>
>
> By discard this table, do you mean kexec not use e820_table_firmware?

No, I mean kexec ignores the memory attributes table.

> Also a very basic question, what do you mean by run with the firmware RWX?
>

The memory attributes table is an overlay for the EFI memory map that
describes which runtime code regions may be mapped with restricted
permissions. Without this table, everything will be mapped writable as
well as executable, but only in the EFI page tables, which are only
active when an EFI call is in progress.

> Sorry for the very basic questions above!
>

No worries.


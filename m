Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAB6E77188
	for <kexec@archiver.kernel.org>; Fri, 10 Jan 2025 17:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1EgRjamZ5sQ9vlPGaogG4jnmCx1/oqSKvS3eMUJ904k=; b=GGDolXyM3EPIC9Xrfd7slkQbqx
	3E3JIaJLLds5op3aBdHDXz2QTzXHYXTqsvT8xLQ0yf1SD//e7IT1s5O+Hg81/eoB323/tDUue2DZG
	7rDvMNXhwGmmaZE5QqQkJ5zmdH9Q/CeVV63/3uKDfkv5DmRzszhctjnzMOyio6z0cRxzwed6nwtcb
	n2JkQ1jZ8pQpgxtW4dfq7KhlJjmq/JJpm3Fq6vBIml7chOHBxAn/Qn2Wh9xnunrS83XiovFHdFFZ6
	CB3wKCYfjMaJcSHLmwRvRomGdMjOCr9sP09ZzooqeZrDZVOTFy2l0IQg/kXeZzYB59sYfJ6OhT9lE
	pyXn8dew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWIoc-0000000GQel-0Jgq;
	Fri, 10 Jan 2025 17:28:58 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWIlW-0000000GPsi-0uHB
	for kexec@bombadil.infradead.org;
	Fri, 10 Jan 2025 17:25:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:Subject:Message-ID:
	Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1EgRjamZ5sQ9vlPGaogG4jnmCx1/oqSKvS3eMUJ904k=; b=ombs2p8s73wDmR6Rmwf8sVzrnw
	gf+oAORyrWys2q99cgnjmzD2IVylC8VqTZCkKhQqQq/m+hKvPEkrsT5HC2NbQzt/Rt/ULI8NLI5Sa
	a3BAF+Kffos/55RzJGmfv/pTtFp5LAp5e4yAPnf9lxlX2UE9Dqq4a5xDfO05VSwfb+4X76EwV70k7
	MJo2R4s6K3QL89B9kD/IiXi55VB5ZVS/7UX6Q+zshJSnp8+WTU8arUsT1zWxirC1TqpBQB9QSBbuq
	KIyt8toatR/3+a+1cdunGds0LsavQAHriLABLvKe7I320X/T/s8VpT6bBVuS/ddJmAIPx8ItarvZd
	8k7UD/Yg==;
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWIlS-00000009rD5-2alB
	for kexec@lists.infradead.org;
	Fri, 10 Jan 2025 17:25:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B1586A42749
	for <kexec@lists.infradead.org>; Fri, 10 Jan 2025 17:23:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C7BC4CEE5
	for <kexec@lists.infradead.org>; Fri, 10 Jan 2025 17:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736529937;
	bh=uBrDyOj3slbVJ+PIUj2mbwZthei0bY1+kDWt5/y2BrE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=czlK2XO5KZAXhCzhutpznnEWzdQywlK2JxHrSr5SoEXQwHrFouikK90abHZsXdjye
	 Nd+Ta4utFCS8OXLI0UVFUdS82e89fuHpSfi1s4bnKD92fqK3corhrTSCydzpiXj0j/
	 ZWyD58iw6TTa97sunHeotB4Lo6DD4pNKFBRWsxAbboh0pRhW+YAp28+pMKlmQ3iXNv
	 vu9UagSdzqVTnj3pS+PHe6vGePRqRMDYRDdzX19MH5PP6VUFJqYY+Tbp2kI8gnkPwd
	 jyhp9cyJf6zA1QgDfybm39secevcsVawv3wsMM5F/Qz4D0t7p6pjuEDQbiQD2rAX09
	 dmOs6mmECXfUQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ffd6b7d77aso25691461fa.0
        for <kexec@lists.infradead.org>; Fri, 10 Jan 2025 09:25:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVPKrDxxqxWf8Ce3AYbeM5ElEfr2nHN8Goi75JwhdADxVDBY28qsK0VQJotswGtprHHdnDv2A==@lists.infradead.org
X-Gm-Message-State: AOJu0YzLb7ebB7TlIt5y4WbadGw/EaIGEIngRB/UKxzWRNPbdiIx3qMU
	Cdvb3WXnrxFETEdu+JatAOeJbcfdvb8sFGw1RRa3ChtetZUQD6m53nxK30ktsGtXH7ZT78Zheog
	GgVZpY01aSgoo4ZELTkzFZdAUXEY=
X-Google-Smtp-Source: AGHT+IH1YfVBqbm+Pgf7TBeHFLTJOJ9Hm6qsUhBbmahKzi8ZRlMk7bsMFmjtEcNd8F2vUCVRY9HYSEle6Ia2vdTZc80=
X-Received: by 2002:a05:651c:1415:b0:304:9de0:7d9 with SMTP id
 38308e7fff4ca-305f45a0f1fmr28575561fa.21.1736529935923; Fri, 10 Jan 2025
 09:25:35 -0800 (PST)
MIME-Version: 1.0
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-2-usamaarif642@gmail.com> <CAMj1kXH54Y0ae1OGwBe7-UiRBq9cFkDHbjxos_rEZPtan7NNzQ@mail.gmail.com>
 <d9c84079-6593-43f4-9483-648b665f03db@gmail.com> <CAMj1kXGYsJrqDzy_+g_wSAAEuQ_OnxvyJ8ZE+4gbr6KOY7iuow@mail.gmail.com>
 <8613563a-ee7c-4271-b1f0-4d1ac365ad3a@gmail.com>
In-Reply-To: <8613563a-ee7c-4271-b1f0-4d1ac365ad3a@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 10 Jan 2025 18:25:24 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHqKw1CxqdqsYAgOXR4P+DxokBa3FGKUw4zPj+wbDMaqA@mail.gmail.com>
X-Gm-Features: AbW1kvYPA0MmDvM52yYY8OWWdO9cYIpDAVPSEFxEiFLV6IJYQpauDzlmq49gb3Q
Message-ID: <CAMj1kXHqKw1CxqdqsYAgOXR4P+DxokBa3FGKUw4zPj+wbDMaqA@mail.gmail.com>
Subject: Re: [RFC 1/2] efi/memattr: Use desc_size instead of total size to
 check for corruption
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io, kexec@lists.infradead.org, 
	hannes@cmpxchg.org, dyoung@redhat.com, x86@kernel.org, 
	linux-kernel@vger.kernel.org, leitao@debian.org, gourry@gourry.net, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_172543_093485_6C63FA18 
X-CRM114-Status: GOOD (  36.31  )
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

On Fri, 10 Jan 2025 at 11:53, Usama Arif <usamaarif642@gmail.com> wrote:
>
>
>
> On 10/01/2025 07:21, Ard Biesheuvel wrote:
> > On Thu, 9 Jan 2025 at 17:36, Usama Arif <usamaarif642@gmail.com> wrote:
> >>
> >>
> >>
> >> On 09/01/2025 15:45, Ard Biesheuvel wrote:
> >>> On Wed, 8 Jan 2025 at 23:00, Usama Arif <usamaarif642@gmail.com> wrote:
> >>>>
> >>>> The commit in [1] introduced a check to see if EFI memory attributes
> >>>> table was corrupted. It assumed that efi.memmap.nr_map remains
> >>>> constant, but it changes during late boot.
> >>>> Hence, the check is valid during cold boot, but not in the subsequent
> >>>> kexec boot.
> >>>>
> >>>> This is best explained with an exampled. At cold boot, for a test
> >>>> machine:
> >>>> efi.memmap.nr_map=91,
> >>>> memory_attributes_table->num_entries=48,
> >>>> desc_size = 48
> >>>> Hence, the check introduced in [1] where 3x the size of the
> >>>> entire EFI memory map is a reasonable upper bound for the size of this
> >>>> table is valid.
> >>>>
> >>>> In late boot __efi_enter_virtual_mode calls 2 functions that updates
> >>>> efi.memmap.nr_map:
> >>>> - efi_map_regions which reduces the `count` of map entries
> >>>>   (for e.g. if should_map_region returns false) and which is reflected
> >>>>   in efi.memmap by __efi_memmap_init.
> >>>>   At this point efi.memmap.nr_map becomes 46 in the test machine.
> >>>> - efi_free_boot_services which also reduces the number of memory regions
> >>>>   available (for e.g. if md->type or md->attribute is not the right value).
> >>>>   At this point efi.memmap.nr_map becomes 9 in the test machine.
> >>>> Hence when you kexec into a new kernel and pass efi.memmap, the
> >>>> paramaters that are compared are:
> >>>> efi.memmap.nr_map=9,
> >>>> memory_attributes_table->num_entries=48,
> >>>> desc_size = 48
> >>>> where the check in [1] is no longer valid with such a low efi.memmap.nr_map
> >>>> as it was reduced due to efi_map_regions and efi_free_boot_services.
> >>>>
> >>>> A more appropriate check is to see if the description size reported by
> >>>> efi and memory attributes table is the same.
> >>>>
> >>>> [1] https://lore.kernel.org/all/20241031175822.2952471-2-ardb+git@google.com/
> >>>>
> >>>> Fixes: 8fbe4c49c0cc ("efi/memattr: Ignore table if the size is clearly bogus")
> >>>> Reported-by: Breno Leitao <leitao@debian.org>
> >>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> >>>> ---
> >>>>  drivers/firmware/efi/memattr.c | 16 ++++++----------
> >>>>  1 file changed, 6 insertions(+), 10 deletions(-)
> >>>>
> >>>
> >>> The more I think about this, the more I feel that kexec on x86 should
> >>> simply discard this table, and run with the firmware code RWX (which
> >>> is not the end of the world).
> >>
> >>
> >> By discard this table, do you mean kexec not use e820_table_firmware?
> >
> > No, I mean kexec ignores the memory attributes table.
> >
> >> Also a very basic question, what do you mean by run with the firmware RWX?
> >>
> >
> > The memory attributes table is an overlay for the EFI memory map that
> > describes which runtime code regions may be mapped with restricted
> > permissions. Without this table, everything will be mapped writable as
> > well as executable, but only in the EFI page tables, which are only
> > active when an EFI call is in progress.
> >
>
> Thanks for explaining!
>
> So basically get rid of memattr.c :)
>
> Do you mean get rid of it only for kexec, or not do it for any
> boot (including cold boot)?

Only for kexec, and only on x86

> I do like this idea! I couldn't find this in the git history,
> but do you know if this was added in the linux kernel just
> because EFI spec added support for it, or if there was a
> specific security problem?
>

Mapping memory RWX is generally a bad idea, so we should avoid it if
possible. But EFI runtime memory regions are only mapped during a EFI
runtime call, and these don't happen often at all, so the benefit is
only marginal. (In the early days of EFI, it was more common for the
OS to map these regions permanently, but we stopped doing that a long
time ago)


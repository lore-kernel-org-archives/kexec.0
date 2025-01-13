Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A607E77188
	for <kexec@archiver.kernel.org>; Mon, 13 Jan 2025 02:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8tjexe4TPFa4m9QlhBjs7sJPAbZ6T/UDfptFEwG+BFw=; b=yQcgty+WobQc2SBfZhNYFEx1mc
	Z8cm+HYhQsgLcx1CqIvSbOg9BKIcVGQjE5SjHLSitlKkLP+KmysnGVwW9Rkfi07mTSYtov9R8aLgE
	Yn0YmG5p10epvvpCykKs/o11qrYK0oQmxqtyMls3PvhW3fnHON2gCb+WIQpPTlMFSJ2G0f3hY99B2
	/Dlyp9u/6HNQsHs3kNqq2In4iVZcWHFiGZooPHAwpY6RmWAhilXxq6siUhb2JFtEN7rEzxFmmeKfA
	790DC6TpISTvKKsV22HJfk32IekGW0neKtflcAxaFYnEkkRb8hEBtMun+oGC1TKk9/89vaZuu1kF6
	qXGX0MNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXAGk-00000003pLM-3kAs;
	Mon, 13 Jan 2025 02:33:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXAGe-00000003pKf-403s
	for kexec@lists.infradead.org;
	Mon, 13 Jan 2025 02:33:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736735606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8tjexe4TPFa4m9QlhBjs7sJPAbZ6T/UDfptFEwG+BFw=;
	b=OUAusMJ5YjNux+5sf57I0tn88uQFvp7HVrpIYw17aRYytY7vg+R5Zzy0WuIwxugHE/Eo3B
	RA3g+b6vWTb2hyKTFptP9h0CBZ2IDtJm/o4BpKq1tjixp+Kkauzz5Yje36xludrLZtdlYD
	Flcxbf5lsFlJo9tzUaOpGYicxdzqX2U=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-8qdN7gqaNJqCdS4PnGfjFA-1; Sun, 12 Jan 2025 21:33:25 -0500
X-MC-Unique: 8qdN7gqaNJqCdS4PnGfjFA-1
X-Mimecast-MFC-AGG-ID: 8qdN7gqaNJqCdS4PnGfjFA
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a819a4e83dso36916745ab.1
        for <kexec@lists.infradead.org>; Sun, 12 Jan 2025 18:33:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736735604; x=1737340404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8tjexe4TPFa4m9QlhBjs7sJPAbZ6T/UDfptFEwG+BFw=;
        b=acGKtXKiNxBykZ+3vLSBH7iP2IGiVpNPMjYZeldRwm7Fvtehz/MOA0vVW2hjjXqbDG
         SNmJ8DOh0YICbdxhMnEKEST09jqHLbLBRECQYPRIJMUEQmZwzNKjdqSiAOrIsgeT6YbZ
         SDpfeSwoBRL/4MqVCOvziGDCqgZmkT1G5ZsBZRtQvMeKbrazgs+Wv7QA251n8AA7N97Y
         qrGgYlAWGnZDzxAHWeAPD77ylKBdX04la7mFPIPV/SiA9icUtIOuU5ArX1zz4PaK3qjc
         j/9Oe7DgPZZh5RXIdmyMwEMoWFJ703e0+FmJKlCZh5s6SopxpI1P/ol6qh5N79A36NgD
         DP1A==
X-Forwarded-Encrypted: i=1; AJvYcCXsNIZcRPdIGhx03ZFUWXbslkn+inU3xW9hz252mlo3vDUJczwkGiIWLVo4yrV6RZMw6xP3rw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxcXTDlVgVf62FPCWR3WCxK8KRl+EIN5jWa/VJvHXoRZlltZDxT
	b/qAQerI+uQdeBaaWqWeDO8IF2YFjtkcCwyfWRh98Dl5avr96/0vrKiwD6xe9PK+ZdRp6RsifLF
	ZCAJL+SoCQzhonWsIN85XgThd1DqntGK2WdIH/S7VinyPyfkCqsiWfBo384JqT3Mh95UR2N0rU4
	mZe9O+9lWF2LjGuyq7h2vIW3EnRJYhb4YZkbd9dAjj7eM=
X-Gm-Gg: ASbGnctG5jY5FXkM5K5A/i8JPtTTn01aF6epzIS4nMim5gmMT1SIFNuMvDU2uZa6gOf
	rBQgQaKOl5UdoKpAfaeQaKfbfu9QxswiVT3+/Tzo=
X-Received: by 2002:a05:6e02:308b:b0:3a7:6c6a:e2a2 with SMTP id e9e14a558f8ab-3ce3a9b8f55mr145581495ab.9.1736735604320;
        Sun, 12 Jan 2025 18:33:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHX/BB3a+x1+hlFag+y4MCY2vYZR+JO6tZHm61qqMxdGOWka7/7g093c98crf0DIa7amAkRJIPbGaJHsF5lggk=
X-Received: by 2002:a05:6e02:308b:b0:3a7:6c6a:e2a2 with SMTP id
 e9e14a558f8ab-3ce3a9b8f55mr145581395ab.9.1736735604015; Sun, 12 Jan 2025
 18:33:24 -0800 (PST)
MIME-Version: 1.0
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-2-usamaarif642@gmail.com> <CAMj1kXH54Y0ae1OGwBe7-UiRBq9cFkDHbjxos_rEZPtan7NNzQ@mail.gmail.com>
 <d9c84079-6593-43f4-9483-648b665f03db@gmail.com> <CAMj1kXGYsJrqDzy_+g_wSAAEuQ_OnxvyJ8ZE+4gbr6KOY7iuow@mail.gmail.com>
 <8613563a-ee7c-4271-b1f0-4d1ac365ad3a@gmail.com>
In-Reply-To: <8613563a-ee7c-4271-b1f0-4d1ac365ad3a@gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Mon, 13 Jan 2025 10:33:29 +0800
X-Gm-Features: AbW1kvYKcHAghdXJwnimGQLKt2N80oQHvYivo3yXntwzaQ6sbrU260HdmO9BHWo
Message-ID: <CALu+AoS8tb=HgaybDw5OG4A1QbOXHvuidpu0ynmz-nE1nBqzTA@mail.gmail.com>
Subject: Re: [RFC 1/2] efi/memattr: Use desc_size instead of total size to
 check for corruption
To: Usama Arif <usamaarif642@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, devel@edk2.groups.io, 
	kexec@lists.infradead.org, hannes@cmpxchg.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, leitao@debian.org, gourry@gourry.net, 
	kernel-team@meta.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4TvGQbUcHn9wLYIR8urknwCbHSKrKcplkIUp98DqC9Y_1736735604
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250112_183329_066575_C4D45EE0 
X-CRM114-Status: GOOD (  38.42  )
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

On Fri, 10 Jan 2025 at 18:54, Usama Arif <usamaarif642@gmail.com> wrote:
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
> I do like this idea! I couldn't find this in the git history,
> but do you know if this was added in the linux kernel just
> because EFI spec added support for it, or if there was a
> specific security problem?
>

Usama, can you try the patch below?
[ format is wrong due to webmail corruption.  But if it works I can
send a formal patch later ]

$ git diff arch/x86
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 846bf49f2508..58dc77c5210e 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -561,6 +561,11 @@ int __init efi_reuse_config(u64 tables, int nr_tables)

                if (!efi_guidcmp(guid, SMBIOS_TABLE_GUID))
                        ((efi_config_table_64_t *)p)->table = data->smbios;
+
+               /* Not bother to play with mem attr table across kexec */
+               if (!efi_guidcmp(guid, EFI_MEMORY_ATTRIBUTES_TABLE_GUID))
+                       ((efi_config_table_64_t *)p)->table =
EFI_INVALID_TABLE_ADDR;
+
                p += sz;
        }



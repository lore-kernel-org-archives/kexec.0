Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5146E77188
	for <kexec@archiver.kernel.org>; Fri, 10 Jan 2025 07:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kYqbSLzknzruTkzUb3qvktdfdDW95zy1Jf8hzJJDvMM=; b=Rv5hMxXOmI1eBZdljNP1qNzwrU
	BGME7k9BobYQtGYl1IEva2F3if9O/0xxE35yMztsKzcsNbXtwmI186kzuXvvSDQsT4Xfob2FyjPqE
	Rg5dO36XfohUEz5lt9G7gvlPWl0PYBPmBJM07l82qqvYWR61ubGQXk4ZHzxGaJs4plJ9vx4crkdpE
	VJAcqfoOGn79y3m51V4WPIQNKrnofpz2mzsjPd+8/240nmS6veJsaYk3yZkv2wJCk5prOvNlNH5BZ
	TCNjhHkpl2naFhpT5b2cDMjLTVrlP71dM4UoHhgU46xUg4wOV2Z8g/d1nnbNzYKE6HI2cf4hu+Okz
	m3C8WuzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tW9ZI-0000000EO0k-0xJy;
	Fri, 10 Jan 2025 07:36:32 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tW9Xh-0000000ENpA-3D1f
	for kexec@lists.infradead.org;
	Fri, 10 Jan 2025 07:34:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 80F62A41A18
	for <kexec@lists.infradead.org>; Fri, 10 Jan 2025 07:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AD5C4CEE4
	for <kexec@lists.infradead.org>; Fri, 10 Jan 2025 07:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736494492;
	bh=kYqbSLzknzruTkzUb3qvktdfdDW95zy1Jf8hzJJDvMM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RSWPXrXq938Ij3QM6DZYS+bTFT/0HhHNLE+f8evIgqGIN0HqrHunna1C8DUEBqgh+
	 GMPIBrYuEkYWG3JYpbDeDsPA98WOnKmPZBehjAkSrLB7QJwR8Lns9q0P3FkB2c1Ky9
	 og172lpGKRWO0JB2zRIv2bNTsz3Iu6MPx8+qtCZIk7LfkRF7YyBrQGpKbVUVgA2qMC
	 A1gYS9/2xdmgx9Px0SHQqKZfxUo4oMQRUIoKjbcbMQXr4S9V+1blVFsWg9hFXUciHH
	 N5mM7PCnFnWIVEtogOsNS7xoiBSxJwXz2gnSOZhkNkJsTHd+xYjMXx17Q1e7WGqKdC
	 jlf3/Rsnpk4RQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53e3a227b82so1530021e87.0
        for <kexec@lists.infradead.org>; Thu, 09 Jan 2025 23:34:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWNrariAr5o2FLVu3p3dnqGOnd4HEIEFzvnYCL5PcA4lvNPjD/C9uyGDRxu1SJ6aJCc/Av5dw==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywfv8ORs78GXkFrlhZFUApSywK/MHYwWUmF9Rchm53uEucrMY3n
	5B50yJxkcAjmap0qneooApQVHsWzGuXwc1AmwDDUdq5PncgjyTk0tZ+YOFx9GMeVhJLAr4H9VM4
	kw3WiiOwnjVDXUoEgDWPkWBsmeiY=
X-Google-Smtp-Source: AGHT+IHcf2xM9VvsYkjaloDENOtP+ZvDGKm/5QwUX3w3+EsHJCn4Dx75mqct7KEITe06bcj8EHmwCzJigOu+TQuR7FA=
X-Received: by 2002:ac2:4e08:0:b0:540:2ff1:309d with SMTP id
 2adb3069b0e04-542845c56cfmr3059582e87.34.1736494490953; Thu, 09 Jan 2025
 23:34:50 -0800 (PST)
MIME-Version: 1.0
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-3-usamaarif642@gmail.com> <CAMj1kXFWZNRwx1H2HT8V9hNvUKDi0O3kcLku+g94UOvNBzz5eQ@mail.gmail.com>
 <cade51c5-5fcc-4208-b46c-f2e2038f03e7@gmail.com>
In-Reply-To: <cade51c5-5fcc-4208-b46c-f2e2038f03e7@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 10 Jan 2025 08:32:08 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFwgnQT4jQF8zsX05PdrF_QDXK0+Z-6DD6LiSgjqY738A@mail.gmail.com>
X-Gm-Features: AbW1kvad1Ep7ZJNKHY5SzNw-aw7vA2PCxxRZNUDwL7taXhAPV5dXJQCNTI_QuUA
Message-ID: <CAMj1kXFwgnQT4jQF8zsX05PdrF_QDXK0+Z-6DD6LiSgjqY738A@mail.gmail.com>
Subject: Re: [RFC 2/2] efi/memattr: add efi_mem_attr_table as a reserved
 region in 820_table_firmware
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io, kexec@lists.infradead.org, 
	hannes@cmpxchg.org, dyoung@redhat.com, x86@kernel.org, 
	linux-kernel@vger.kernel.org, leitao@debian.org, gourry@gourry.net, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250109_233453_935449_96151A56 
X-CRM114-Status: GOOD (  35.89  )
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

On Thu, 9 Jan 2025 at 17:32, Usama Arif <usamaarif642@gmail.com> wrote:
>
>
>
> On 09/01/2025 16:15, Ard Biesheuvel wrote:
> > On Wed, 8 Jan 2025 at 23:00, Usama Arif <usamaarif642@gmail.com> wrote:
> >>
> >> When this area is not reserved, it comes up as usable in
> >> /sys/firmware/memmap. This means that kexec, which uses that memmap
> >> to find usable memory regions, can select the region where
> >> efi_mem_attr_table is and overwrite it and relocate_kernel.
> >>
> >> Since the patch in [1] was merged, all boots after kexec
> >> are producing the warning that it introduced.
> >>
> >> Having a fix in firmware can be difficult to get through.
> >
> > I don't follow. I don't think there is anything wrong with the
> > firmware here. Could you elaborate?
> >
>
> So the problem is, kexec sees this memory as System RAM, and decides
> it can be used to place an image here.
>
> I guess the question is (and I actually don't know the answer here),
> whose responsibility is it to mark this region as reserved so that
> its not touched by anyone else. I would have thought it should be
> firmware?
>

No, it is the OS. The firmware only reserves regions that are needed
for its own correct operation at runtime. For informational tables
such as this one, it is up to the OS whether it wants to reserve it
and keep it in place, consume it and release the memory, or ignore it
altogether.

> Maybe its not the firmwares' job to mark it as reserved, but just pass
> it to kernel and the kernel is supposed to make sure it gets reserved
> in a proper way, even across kexecs.
>

Indeed.

> I think in the end whoevers' responsibility it is, the easiest path forward
> seems to be in kernel? (and not firmware or libstub)
>

Agreed. But as I pointed out in the other thread, the memory
attributes table only augments the memory map with permission
information, and can be disregarded, and given how badly we mangle the
memory map on x86, maybe this is the right choice here.

> >
> >> The next ideal place would be in libstub. However, it looks like
> >> InstallMemoryAttributesTable [2] is not available as a boot service
> >> call option [3], [4], and install_configuration_table does not
> >> seem to work as a valid substitute.
> >>
> >
> > To do what, exactly?
> >
>
> To change the memory type from System RAM to either reserved or
> something more appropriate, i.e. any type that is not touched by
> kexec or any other userspace.
>
> Basically the example code I attached at the end of the cover letter in
> https://lore.kernel.org/all/20250108215957.3437660-1-usamaarif642@gmail.com/
> It could be EFI_ACPI_RECLAIM_MEMORY or EFI_RESERVED_TYPE, both of which aren't
> touched by kexec.
>

This is a kexec problem (on x86 only) so let's fix it there.


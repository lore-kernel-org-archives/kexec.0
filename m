Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C4EC5B56A
	for <kexec@archiver.kernel.org>; Mon, 10 Aug 2026 14:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5rrAvPgRrohANHyT7hdY7z+O8aQ4K1pdWWyNquNpNJ8=; b=WR8Yi5P7iFkx41MQS0jS7D8CEx
	/TOLrXjlHl6Zn6EiAZMxZl3HjT3fMetnAsJtE53eh+cP7W6gL08OV4+5iKRYRa4zCD88BJvqy+710
	iZ48PIP2AH2Pf/uk7KhhKeEs/W80is+cQVah3Mt1fcAS7HpEWO8lOsRNiH3sOJelZ1PIVRjlIJ73v
	fJ3OZd6sJh0gMLb/tNalyc4SWiMaVDCDqJlmwRqK3iv2VESETAmv3jk/5rcMGXLZsOA6ee7GhbUZa
	LeuA7MKQ5iX69NEej7OUFZL9B47Ng9jDqrT9AIwt/dv/UB1d29hKeBPXB7cakzSGNV4iu83XuKv8U
	vsYiKqPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtR6b-0000000C1lD-2EYC;
	Mon, 10 Aug 2026 14:35:57 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtR6W-0000000C1kX-2TxH
	for kexec@lists.infradead.org;
	Mon, 10 Aug 2026 14:35:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0C09360052
	for <kexec@lists.infradead.org>; Mon, 10 Aug 2026 14:35:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78301F000E9
	for <kexec@lists.infradead.org>; Mon, 10 Aug 2026 14:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786372550;
	bh=5rrAvPgRrohANHyT7hdY7z+O8aQ4K1pdWWyNquNpNJ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mokf2untmLnI3fXVkZl9R1TO+I3D6j3AGjfvZwlTjVihK2ebOho2oQYup6uW9rOtJ
	 ImXvrtxVu0Xd4nsZKmwB6BqLwDEpy7Rl/+PPEzC4UFFM+NUR0ljJB9JsFTVCvsSZKf
	 cVNj8v6IBepszhYaAdBd7rrMrYOUeqJOZdB4pBHj5VPk2FaMAsepKXFAPYgBQKtTv1
	 kvMMNBdFm54k5NusUJR9CltM7nilqfNZ0Y6bjhbdu0ttPM5ZAo5TMeSqd+qZyTPRjM
	 Yjw9y/j2HOh6NyXhEDTPUV3kda3hc3Z63LKyCZRgDia2v6J6v/nAMSC8FBzsMaagHq
	 cW4vCyK8OiTPw==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a1a546a6bbso2596650a12.1
        for <kexec@lists.infradead.org>; Mon, 10 Aug 2026 07:35:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrMHeTAlirhYVTPW+D30HXr3tyrcwzKe6jkWKAP9ewx2E5vXnQ7wcz+OVjDBXjwJoms4U1riQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxaAzMv0TFn8k5UNe0reqgqka4iC0C8rOI2oQCPurb3z75l1jjj
	J8DLJE7O6ni+Ynnsjg6X813vGC/zeowt9HBrdE7j5oMlbR34YbXWZZ8FHeGi/ZZJ7ICfHXuEuEo
	7FsJGXQs4yy9aIFHtaHqlCJhduoXIyso=
X-Received: by 2002:a05:6402:190b:b0:697:e953:d14d with SMTP id
 4fb4d7f45d1cf-6a1b4b9a7c9mr14019689a12.17.1786372549348; Mon, 10 Aug 2026
 07:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260807103714.33074-1-dongtai.guo@linux.dev> <20260807103714.33074-2-dongtai.guo@linux.dev>
 <CAAhV-H4xxPXVRNXP42CBtMdVXbBZ4E6A997jZmw7HpEUSFAj9g@mail.gmail.com> <96bd0e57-b517-4008-905f-9860661afaf2@app.fastmail.com>
In-Reply-To: <96bd0e57-b517-4008-905f-9860661afaf2@app.fastmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 10 Aug 2026 22:35:37 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6UufWevaCds851xSxEMLeLcq+8wpoWq8OyeXib25GEUQ@mail.gmail.com>
X-Gm-Features: AUfX_mx7myO5n6AdZGyKWT1euUf6zZnDQmB3Nd8fohz-ozaccG8I_T8jUbfMATo
Message-ID: <CAAhV-H6UufWevaCds851xSxEMLeLcq+8wpoWq8OyeXib25GEUQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] efi: add a KHO configuration table GUID
To: Ard Biesheuvel <ardb@kernel.org>
Cc: George Guo <dongtai.guo@linux.dev>, Mike Rapoport <rppt@kernel.org>, pasha.tatashin@soleen.com, 
	pratyush@kernel.org, shuah@kernel.org, guodongtai@kylinos.cn, 
	WANG Xuerui <kernel@xen0n.name>, graf@amazon.com, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Aug 10, 2026 at 9:14=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
>
>
> On Sun, 9 Aug 2026, at 06:18, Huacai Chen wrote:
> > Hi, George,
> >
> > On Fri, Aug 7, 2026 at 6:38=E2=80=AFPM George Guo <dongtai.guo@linux.de=
v> wrote:
> >>
> >> From: George Guo <guodongtai@kylinos.cn>
> >>
> >> Kexec Handover (KHO) passes the address of its state FDT and of its
> >> scratch area from the current kernel to the next one.  On architecture=
s
> >> that boot with a device tree, the current kernel writes the
> >> linux,kho-fdt and linux,kho-scratch properties into /chosen, and the n=
ext
> >> kernel reads them back in early_init_dt_check_kho().
> >>
> >> Architectures that boot through EFI without a device tree have no such
> >> channel.  LoongArch is one of them: its efistub passes the EFI system
> >> table and the command line to the core kernel directly and never creat=
es
> >> an FDT.  x86 has the same problem and carries the state out of band
> >> instead, in a struct kho_data in the setup_data chain of its boot
> >> protocol.
> >>
> >> Add an out-of-band channel for EFI: a LINUX_EFI_KHO_TABLE_GUID
> >> configuration table entry, under a randomly generated GUID, pointing a=
t a
> >> struct linux_efi_kho_data.  The
> >> current kernel loads the structure and an extended configuration table=
 as
> >> kexec segments, then switches the EFI system table to the new table
> >> before jumping.  The next kernel finds the entry by GUID and calls
> >> kho_populate().
> >>
> >> The structure carries no version field.  An incompatible change to the
> >> layout must use a new GUID, which is the usual rule for EFI configurat=
ion
> >> tables.  The handover payload itself is versioned separately, by the
> >> compatible string of the KHO state FDT that kho_populate() checks.
> >>
> >> This patch adds the definitions only.  LoongArch is the first user; an=
y
> >> other EFI architecture without a boot FDT can use the same channel.
> >>
> >> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> >> ---
> >>  include/linux/efi.h | 24 ++++++++++++++++++++++++
> >>  1 file changed, 24 insertions(+)
> >>
> >> diff --git a/include/linux/efi.h b/include/linux/efi.h
> >> index ccbc35479684..789ab9e4312a 100644
> >> --- a/include/linux/efi.h
> >> +++ b/include/linux/efi.h
> >> @@ -422,6 +422,7 @@ void efi_native_runtime_setup(void);
> >>  #define LINUX_EFI_COCO_SECRET_AREA_GUID                EFI_GUID(0xadf=
956ad, 0xe98c, 0x484c,  0xae, 0x11, 0xb5, 0x1c, 0x7d, 0x33, 0x64, 0x47)
> >>  #define LINUX_EFI_BOOT_MEMMAP_GUID             EFI_GUID(0x800f683f, 0=
xd08b, 0x423a,  0xa2, 0x93, 0x96, 0x5c, 0x3c, 0x6f, 0xe2, 0xb4)
> >>  #define LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID    EFI_GUID(0xd5d1de3c, 0=
x105c, 0x44f9,  0x9e, 0xa9, 0xbc, 0xef, 0x98, 0x12, 0x00, 0x31)
> >> +#define LINUX_EFI_KHO_TABLE_GUID               EFI_GUID(0xc941b6c7, 0=
x7b3f, 0x4af6,  0x9e, 0x50, 0xfc, 0xb3, 0xa8, 0x86, 0x8a, 0x17)
> > I don't know whether it is allowed to define a new TABLE ID while
> > doesn't touch the UEFI SPEC.
> >
>
> That is fine in principle: the whole reason for using GUIDs as identifier=
s
> in UEFI is that everyone can invent their own, and the risk of conflicts =
is
> negligible.
>
> All LINUX_EFI_* GUIDs are Linux inventions, and are not mentioned in the
> UEFI spec at all.
OK, then I think the direction of this series is correct now, and I
hope there will be more archs share this GUID.

BTW, I think LINUX_EFI_KEXEC_HANDOVER_GUID may be a little better than
LINUX_EFI_KHO_TABLE_GUID.

Huacai
>


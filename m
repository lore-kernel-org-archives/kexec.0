Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68D5C98321
	for <kexec@archiver.kernel.org>; Fri, 25 Sep 2026 16:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JARynGJUCvOWQyNY1o+FlzMj+Bv1IKnpsppKykEkgD0=; b=DyyZrhUnwZnpBACEWR8L9FOHdW
	Epw95GHd3CulEz6YHvpiOPg1nWkn95ZvFBzU51IqmWs8TNJNysdvbaWXu+ozAQL9j/Z9Bc7VOxHva
	ooBNoKtDbQYORMEVQ89bZqb9vouEcaM5apDQkYrCv959mS/+MSe7xLN9LWjbpTZVbEyBNf7pkHu5R
	wwdbL48r5cuIXE+sjrk0mS1mAucfz9MkMHMtMm5G56lfbXBqFkXmPfanvnLy/86VLC+qoE9yrrHfL
	Fj3A+cD2WrSnYYPM9q9gEkAkRSxsn4WHok8gsWh+Gak1hpAxxa6oNM655h5wkyzJAG4DHWNTWCmTj
	Sq+2mmPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA9AH-0000000E0wm-0SaF;
	Fri, 25 Sep 2026 16:52:49 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA9AG-0000000E0wN-0IN7
	for kexec@lists.infradead.org;
	Fri, 25 Sep 2026 16:52:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 83C0F60258
	for <kexec@lists.infradead.org>; Fri, 25 Sep 2026 16:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3739F1F008A5
	for <kexec@lists.infradead.org>; Fri, 25 Sep 2026 16:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790355167;
	bh=JARynGJUCvOWQyNY1o+FlzMj+Bv1IKnpsppKykEkgD0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VLvy7LjLV2lwF8xnen2f4bIBb9oDB2QwHkoz6EYM5DvhyEZtITS8HBqpcGfakhIzS
	 k32rhF6dfMKsKJ63WzcNiH+IVdxnkyAsoq/4UsXmE3YsjeCuQuAnZ8Zlu/deuHk6Fz
	 iC0AtdVi9G6i7QZph3lAKpqewVTJ03IVe6M+1KSNCoNpRsj4G/dPqIKwYmhQE2qZjW
	 HgCXSfsDz+9azthI8GCWtnF/wnCaz2UQNclzH9G+qKloZD/WcUmIn6ZcHj8Kv56+vW
	 KefDbXJmh5ATXCavdZ2/nKKoz54ISFYSi8BA6YyFuU6hiloreXbO8TmhVkdulhp6Tw
	 utniKwNv2o42w==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a36de66c0dso10439711fa.0
        for <kexec@lists.infradead.org>; Fri, 25 Sep 2026 09:52:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw7emUDLOckNMWOxE6IDtLds1hWKLhj7YJfWrDsMB1duMN+ST8UmeTeMXFFkFbXdwY+g2KW0w==@lists.infradead.org
X-Gm-Message-State: AFuF++kAY5Ddnl6j0frWZPyBoRVAO3vQpIw66wkcefMUBlVTTYm9yJ5Q
	lkYeHuIh/xMsfmo8COvAH32TbmKVmvZWPSUZrzz6noHsxiVyacTHxvTBt2FOCMoVw3pACtVeczi
	0BnM7intdFtt8lVfJM0fpO0hZ/KfUojI=
X-Received: by 2002:a05:651c:222c:b0:3a6:4e4d:9d1d with SMTP id
 38308e7fff4ca-3a64e4d9ecemr6264461fa.0.1790355165530; Fri, 25 Sep 2026
 09:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260805070900.3390978-1-matthias.goergens@gmail.com>
In-Reply-To: <20260805070900.3390978-1-matthias.goergens@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 25 Sep 2026 18:51:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0izV3g1mSKJtKMcc=TfeUjJofSXCX92y4XX55Lam28qOg@mail.gmail.com>
X-Gm-Features: AclHuK85wIOJjS4FjOn7NpdlQI5RIKzhlYZPPYKaHhvSAVTRRtE57QyxOv3z4_k
Message-ID: <CAJZ5v0izV3g1mSKJtKMcc=TfeUjJofSXCX92y4XX55Lam28qOg@mail.gmail.com>
Subject: Re: [PATCH] x86/hibernate: Ignore page-zero RAM in E820 checksum
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, pavel@kernel.org, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, yu.c.chen@intel.com, jlee@suse.com, 
	baoquan.he@linux.dev, dyoung@redhat.com, io@r-ricci.it, scardracs@disroot.org, 
	moravec@ukf.sk, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
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

Sorry for the late response.

On Wed, Aug 5, 2026 at 9:09=E2=80=AFAM Matthias Goergens
<matthias.goergens@gmail.com> wrote:
>
> The legacy kexec_load path reconstructs the E820 map exported through
> sysfs.  kexec-tools leaves the first 1 KiB unavailable for the real-mode
> transition, so a kernel entered through kexec_load can see conventional
> RAM starting at 0x400.  A subsequent firmware boot reports the same RAM
> range starting at zero.
>
> The hibernation E820 checksum compares those byte representations and
> rejects the image, even though the maps agree from page one onwards.  The
> reproducer observed this exact transition:
>
>   firmware:     RAM [0-0x9fbff]
>   kexec_load:   gap [0-0x3ff], RAM [0x400-0x9fbff]
>   firmware:     RAM [0-0x9fbff]
>
> Common x86 setup already converts conventional RAM in page zero to
> reserved memory in trim_bios_range() before registering hibernation
> nosave regions.  Page zero therefore cannot occur in the image.
>
> Canonicalise only the conventional-RAM portion below PAGE_SIZE before
> calculating the checksum.  Preserve RESERVED, ACPI, NVS, UNUSABLE, PMEM
> and all other E820 types so that changes to exceptional mappings remain
> detectable.  Maps without conventional RAM intersecting page zero retain
> the previous checksum byte stream.
>
> This is deliberately narrower than the June proposal to checksum only RAM
> and its opt-in relaxed_memmap successor.  Rafael noted that ignoring non-=
RAM
> changes could hide moved ACPI or UEFI regions still used by the resumed
> kernel.  This patch preserves every non-RAM entry and ignores only RAM wi=
thin
> page zero, which common setup already reserves and excludes from the imag=
e.
>
> Changing the checksum semantics means an image made by an unpatched
> kernel can fail to resume under a patched kernel, or vice versa, when its
> raw map contains page-zero RAM.  Such cross-version attempts remain
> fail-closed; normal same-kernel hibernation is unaffected.

So this should update RESTORE_MAGIC in arch/x86/power/hibernate.c to
indicate the protocol change.

> With the reproduced raw-map difference retained, both the direct-boot
> control and legacy kexec_load hibernation/resume tests passed.  The test
> kernel also completed a clean full bzImage build.
>
> Fixes: 62a03defeabd ("PM / hibernate: Verify the consistent of e820 memor=
y map by md5 digest")
> Reported-by: Roberto Ricci <io@r-ricci.it>
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
> Link: https://lore.kernel.org/all/Z-hYWc9LtBU1Yhtg@desktop0a/
> Link: https://lists.openwall.net/linux-kernel/2025/04/04/1372
> Link: https://lore.kernel.org/all/CAJZ5v0jmOj0WBtMTvbnaD+2b0bTFowA=3DJWrq=
RzaaCYpHpai1Nw@mail.gmail.com/
> Link: https://lore.kernel.org/all/20260623165724.10753-1-scardracs@disroo=
t.org/
> ---
>  arch/x86/power/hibernate.c | 47 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 43 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
> index a2294c1649f65..ec53c970c92e6 100644
> --- a/arch/x86/power/hibernate.c
> +++ b/arch/x86/power/hibernate.c
> @@ -63,6 +63,25 @@ struct restore_data_record {
>         unsigned long e820_checksum;
>  };
>
> +static bool trim_e820_page_zero_ram(struct e820_entry *entry)
> +{
> +       u64 lowmem_size;
> +
> +       /*
> +        * Page zero is BIOS-owned and registered as nosave.  Boot loader=
s may
> +        * therefore omit part of its conventional RAM entry without chan=
ging
> +        * any memory available to the image.  Preserve all other E820 ty=
pes.
> +        */
> +       if (entry->type !=3D E820_TYPE_RAM || entry->addr >=3D PAGE_SIZE)
> +               return true;
> +
> +       lowmem_size =3D min_t(u64, entry->size, PAGE_SIZE - entry->addr);
> +       entry->addr +=3D lowmem_size;
> +       entry->size -=3D lowmem_size;
> +
> +       return entry->size;
> +}
> +
>  /**
>   * compute_e820_crc32 - calculate crc32 of a given e820 table
>   *
> @@ -70,12 +89,32 @@ struct restore_data_record {
>   *
>   * Return: the resulting checksum
>   */
> -static inline u32 compute_e820_crc32(struct e820_table *table)
> +static u32 compute_e820_crc32(struct e820_table *table)
>  {
> -       int size =3D offsetof(struct e820_table, entries) +
> -               sizeof(struct e820_entry) * table->nr_entries;
> +       struct e820_entry entry;
> +       u32 crc =3D ~0;
> +       u32 nr_entries =3D 0;
> +       u32 i;
> +
> +       for (i =3D 0; i < table->nr_entries; i++) {
> +               entry =3D table->entries[i];
> +               if (trim_e820_page_zero_ram(&entry))
> +                       nr_entries++;
> +       }
> +
> +       crc =3D crc32_le(crc, (unsigned char const *)&nr_entries,
> +                      sizeof(nr_entries));
> +
> +       for (i =3D 0; i < table->nr_entries; i++) {
> +               entry =3D table->entries[i];
> +               if (!trim_e820_page_zero_ram(&entry))
> +                       continue;
> +
> +               crc =3D crc32_le(crc, (unsigned char const *)&entry,
> +                              sizeof(entry));
> +       }
>
> -       return ~crc32_le(~0, (unsigned char const *)table, size);
> +       return ~crc;
>  }
>
>  #ifdef CONFIG_X86_64
> --
> 2.55.0
>


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4DD9E6815C
	for <kexec@archiver.kernel.org>; Tue, 17 Feb 2026 10:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WkP9sV7zEEh/ycQYc4JlwnuQ3mFYmRf4njLKvnF86jU=; b=G2+6DO+dB93XgcO/ZE4eIioSLs
	9fPHgAH14cpHwLpt6CM46f0+GgAq9lFZ5SfiROKo4AAprtAi9c3GtoIcMk7b+pkV2zFe+CHrjDuLG
	hshINrZMWGNHTTzt3Ak5ZoynuTQ+yj4pygjrZTKQn1FlfNIMR9JNr9Ga1qw08J0H6vbVApwNsDb3N
	XLJKPA3hUqZthDyKDUYmQTLo0FSYCRVhFzquwCzVIhQxNBCSThyd9akJpbpuYTZZJqh9cp0zQKNON
	RJHDU6b8CgC5L8LLXNdHZdKAR/GHn0mCdGN393a6hHYGBiqELYOufC2/4ZQBIESzE3iC8/3HqlfjM
	twprlyFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsHtd-00000007zWF-1cre;
	Tue, 17 Feb 2026 10:01:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsHta-00000007zVo-1dHa
	for kexec@lists.infradead.org;
	Tue, 17 Feb 2026 10:01:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771322488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WkP9sV7zEEh/ycQYc4JlwnuQ3mFYmRf4njLKvnF86jU=;
	b=LuBdKsP+pAa9knusKQ6H1OhQO/FSQA+TosEM1vxn/iZ4kfhgW8klwRDKJdSi4q9cYyNKbd
	csUGpyP2nQqwcnzVDEHbQ8WW0NN+TwA7RgzvtCZfUn086+f04hdUOTUQkng70kYqFHPFNb
	jSLde+4FCBEqBi+8VOsvdwNFls4T1Oc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-BspTCP6FOniG6i0P0fk5WA-1; Tue, 17 Feb 2026 05:01:26 -0500
X-MC-Unique: BspTCP6FOniG6i0P0fk5WA-1
X-Mimecast-MFC-AGG-ID: BspTCP6FOniG6i0P0fk5WA_1771322485
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-385ba7acdd9so20014571fa.2
        for <kexec@lists.infradead.org>; Tue, 17 Feb 2026 02:01:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771322485; x=1771927285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkP9sV7zEEh/ycQYc4JlwnuQ3mFYmRf4njLKvnF86jU=;
        b=qdV1q9BHzhmgU37uiAzdtZs/wzfx31xXeKkUWkyfi8UFQ+Gr+LvhmsYG78Z5/y/0/Y
         a3Xz3oyrb9a/guy+2QYiJVvQakRtZ5htS1Ly4wnIIC5ue7N+jaGML+XyvggyIq/LtgC1
         k2ZcCBu1jcC/5OYCI8a245FWGbMp1+zmvSMsLqs0Ef5B8QL/wOYd3Ve4gKvKUWu9rNhS
         Pv5BtmtBXltoZtIdP7OozLO43xT/cnKhksy9kuRHF8+bHCh2Dxn8LceRg0rcFx1umKTK
         G7vKR4puLDEjw8WIm+otl9Gnl46JDt/JNIe7jtrWzDnP1PYaZX6clMwqZUbDgVl0uFe0
         73zQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3PVHARQyWwI2C9PlteVguU8xaNMQAJe5JlC9L2z9YFiS7PNvfOVNq/JPwxAuscTZ005672Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YzvcJz40wfziGj8fyFEzBqkj7pezczMMn6FQyumYcpgaQGCkuHK
	ZohYguEEh3oie2Ke9bnn6bw3xGDI2X0QnJ8DPi3Wv7YvSjUI+yjiGes9fL88nutXHRlU73rbPg0
	mkzYKCuJUDwew0oAiBarde0ZTpBW1rSzfkZFVLc8GmuN6rxlwN4aXoAhVDRrH3qrRN0syzCA7r3
	pntIJ7P5rDdxkrWC/qrc8kOZsUirMCj5ogt8Az
X-Gm-Gg: AZuq6aLNzRVYyBxmtxAwdMY0JtPuRKN4k1Ti908Mmf4hhmI4tbbogLfYQ8FtfqCeKqF
	zmXXMBNGf1fzkcl+ENJ+2vSbdthG9Dok4szi+B0ngqYicneJCioDe07FWJq89Tu302gy0RRuQvT
	3kncZmK4aeEYytoi9IOth+iGHuTut+/fO6pV8oq0RBoNCBFz5sKoYzg+frMnO5OGBcze68W8kZM
	i5AV7YaQwNT8Cj9gomznLUnR2rvK1cUsWy0YipSUIulczYc5wtS6um4MjzQQ82wzFn/
X-Received: by 2002:a05:651c:1ac8:b0:385:c21f:37e1 with SMTP id 38308e7fff4ca-388105154f8mr30173351fa.15.1771322484929;
        Tue, 17 Feb 2026 02:01:24 -0800 (PST)
X-Received: by 2002:a05:651c:1ac8:b0:385:c21f:37e1 with SMTP id
 38308e7fff4ca-388105154f8mr30173181fa.15.1771322484427; Tue, 17 Feb 2026
 02:01:24 -0800 (PST)
MIME-Version: 1.0
References: <aZQg_tRQmdKNadCg@darkstar.users.ipa.redhat.com>
 <824bf9d5-93d3-4791-a064-3852014a1264@app.fastmail.com> <CALu+AoRdo5E-irxymu7WAV+L=sKLbjnOXtLLe7RHWX-NZtjvNw@mail.gmail.com>
 <61f0c9ad-a435-4856-8ebe-d5a81f72330e@app.fastmail.com>
In-Reply-To: <61f0c9ad-a435-4856-8ebe-d5a81f72330e@app.fastmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Tue, 17 Feb 2026 18:01:55 +0800
X-Gm-Features: AaiRm53GXhlC37NOtJ3S5h3LMzGLEWl_lhdxyUWNnt9ZM53wyjhzIw3ZXFoet1Y
Message-ID: <CALu+AoTkGWXAokzXwo6C+6K1-mk3r9YA=WauXAggP628F_=ABQ@mail.gmail.com>
Subject: Re: [PATCH] efi/x86-stub: store acpi_rsdp_addr in bootparams
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, x86@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cOMk3XnEYSmdNLlrYFdZj5dA1CHM4fJDpj7EUKA5vQ8_1771322485
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260217_020130_523492_A8FAE765 
X-CRM114-Status: GOOD (  33.33  )
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

On Tue, 17 Feb 2026 at 17:20, Ard Biesheuvel <ardb@kernel.org> wrote:
>
>
> On Tue, 17 Feb 2026, at 09:19, Dave Young wrote:
> > Hi Ard,
> >
> > On Tue, 17 Feb 2026 at 16:10, Ard Biesheuvel <ardb@kernel.org> wrote:
> >>
> >> Hi Dave,
> >>
> >> On Tue, 17 Feb 2026, at 09:04, Dave Young wrote:
> >> > Kernel panic occurs during a kexec reboot when EFI runtime services
> >> > are not enabled in the first kernel. The issue is that the second
> >> > kernel cannot find the ACPI RSDP address during boot.
> >> >
> >> > In legacy boot, the acpi_rsdp_addr is set in early x86 boot code.
> >> > However, kernel decompression has moved to the EFI stub for EFI boot.
> >> > Therefore, the x86 EFI stub must also be updated to store the
> >> > acpi_rsdp_addr in the boot parameters to ensure the kexec kernel
> >> > can find it.
> >> >
> >> > (Note: If the pre-kexec kernel was itself a kexec boot, the later kexec
> >> > reboot will still utilize the legacy decompressor path, so the original
> >> > code remains functional though some cleanups can be done later.)
> >> >
> >> > Signed-off-by: Dave Young <dyoung@redhat.com>
> >> > ---
> >> >  drivers/firmware/efi/libstub/x86-stub.c |   18 ++++++++++++++++++
> >> >  1 file changed, 18 insertions(+)
> >> >
> >>
> >> If this issue is kexec-specific, can we move this to where the kexec code prepares the boot_params struct for the next kernel?
> >>
> >
> > The kexec use case is it depends on the pre-kexec kernel saving it
> > during boot for noefi case.  I do not have a better idea to do it in
> > kexec code for the time being.
>
> How about something like this?

Thanks!  It works for me, however the legacy kexec_load syscall still
failed with a panic I did not dig into the root cause yet, I supposed
it will find the rsdp from /sys/firmware/efi/systab file, maybe some
userspace code bug.

Anyway I'm fine with this fix,  would you like to send a formal patch
since you proposed it?  Otherwise I will resend with the changes.

>
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 7508d0ccc740..24aec7c1153f 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -313,6 +313,12 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
>
>         /* Always fill in RSDP: it is either 0 or a valid value */
>         params->acpi_rsdp_addr = boot_params.acpi_rsdp_addr;
> +       if (IS_ENABLED(CONFIG_EFI) && !params->acpi_rsdp_addr) {
> +               if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
> +                       params->acpi_rsdp_addr = efi.acpi20;
> +               else if (efi.acpi != EFI_INVALID_TABLE_ADDR)
> +                       params->acpi_rsdp_addr = efi.acpi;
> +       }
>
>         /* Default APM info */
>         memset(&params->apm_bios_info, 0, sizeof(params->apm_bios_info));
>



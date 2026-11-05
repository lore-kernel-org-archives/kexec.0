Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9320B606A31B
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 10:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HdD+tBlK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=+mKdlgKO27T7zaM0EZirUNSUHhSIV/TKUV4SSUSBbFc=; b=HdD+tBlK/fH4IbZy7mB2vCICBS
	o5Zx2iQnSZ8jVbZYr79kps5iQpKoqCWlVD3a0fDaxhGvncbobZouTHJPSOg7WiHp8VoN/RTLO56Nz
	mfwutwd7FX+gGb3GymysMiGqiiL7kvyvzLvHIqIdOlv+u+XVh/sQLkJzxwVPLDfAKfIOO8fPitJ+h
	mJxuRzkk6qzeBSKuucLgcpmibh2eZOtFl9m/IXIlWm9W2I5zRXxWOFaayLoZNwNrAJzDYvQWBnz3R
	lyATFKOQj20Tgc2+H8ZwdlIkX+BAktE9knl6fDPL3nDVUsA/IK0XYUEfnf0ADG0vRIRd/HVYYwkyD
	xKGWv3rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOuIe-00000008O0D-1JUh;
	Thu, 05 Nov 2026 10:02:28 +0000
Received: from mail-ot1-f41.google.com ([209.85.210.41])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOuIZ-00000008NzY-2Yxw
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 10:02:24 +0000
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-83bbcfba0ffso1148377a34.0
        for <kexec@lists.infradead.org>; Thu, 05 Nov 2026 02:02:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872942; x=1794477742;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+mKdlgKO27T7zaM0EZirUNSUHhSIV/TKUV4SSUSBbFc=;
        b=ziACJ6Oyv2jrU7tXCHkwPh5sYMII1ArniXkmbpeuO7viiE2SbFGpexhy065zHriExT
         nIAMdFePXFxmOnwLreMRwscapNhE04Ka1remYbNrpUnk4xS4W1K0kLGPFSo4Xu4BtqsF
         6rO9lcKDaIXYt1ucFJs5O1B4soLp8aSJmC91FQ81c++ldLJZpzh8aL6ticyUwal4eE5n
         oa/4x1qp381oO6nnZFnkz60DCgh+IAFCkyCjdubscXSpXTngJamBB7jlJQuaFDTFXzfp
         phQPB6NOt69TUKrmM/8c5tJjNvjsYu+WMzXYBE0ADKj2ACLRd8f2SEASmQ36wHCocoA3
         4myw==
X-Forwarded-Encrypted: i=1; AKwUvBxN8Ok3lDfnNtKhXEmJgjqTMPugVnwoGvdWmxgBZdIYVeVStpWFAgB+a54AaQK8Zrh1/5TAiw==@lists.infradead.org
X-Gm-Message-State: APuU4Z8STX6gOdF9PqmuEMNurhQxMwbSuBu7ex82z1jOIPQZV9iifMM/
	HdsC95qX6pL1cjqDxlnjbzeW9PlqZ80KmfrPoPbdSihUXuyyAAIOkOTvAyNe2QODpKo=
X-Gm-Gg: AYBFou39LoaUoPgtoeMfvEVvhfxSxig1XiEKe0vpQXx6AHbKsfhNKMZfaFTT44Ewjlo
	4sjo0rkbZtwwIpwKILLg5c5FcRpr5RAk1DQvcK62Bu8H8N29YxC7kq2Zyk8jFDX+IKskfjk2vkq
	FnYqxmKmfqGsBWmMYOy0Hh5IuFbqdJzAe6UVyiZXQvGgqjE7I42j0C5rISCKoczns36FWcDXrgC
	Q83ASL0zQrgcZ6vrmBiNrk+40DNSgSFHb0euPq9V2hgxrQXHXYFn/8bEifFtnxjNCZe35uS5mlg
	Y9UcD1x9xCOV4m+gKCiFLDEIWcQJGJcJxB0tpdQa/Q/wDzE9ncYX4OBOG3u9mXybxzUpSg2nmFD
	Ztc+smifrT6G8S/U2Nn1f6FnhZzucsvGye9Dks2M9JKZ4b1J1MTZM1cFTZ4WHgdPcLHBJPFB68S
	HBFQtAg7cXL+0cH+GObOr7Gi+lLCMjntngCRhoYMASrg6MiigV6knRgAqQY4yR1X7+ml+eI95jS
	026ZuSyBr249AOOLrt052o3DcOVm+laCIKvfqHaWo+PodosiJw7H1q7ZjuBx9hwd2m9KgLkhAAF
	UwDWM1fmdDG/gYPr3yc1lwr1Wo7wfcBEXNRdzEVdJVwRpxSTAcDrAQLzxJH9QAY0EKeDNEGxRrl
	nfrdDmEYFY5Y0L50=
X-Received: by 2002:a05:6808:f0b:b0:4f5:1cd4:d2be with SMTP id 5614622812f47-5640d67aa60mr15963756b6e.0.1793872942402;
        Thu, 05 Nov 2026 02:02:22 -0800 (PST)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com. [209.85.167.178])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567aa022a51sm3920617b6e.17.2026.11.05.02.02.20
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:02:21 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4d198f1a591so982295b6e.2
        for <kexec@lists.infradead.org>; Thu, 05 Nov 2026 02:02:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwPM67Uf6Bw45mJ6zJxX+NMYhLHDj9MSxrI807Bpv5OHmZYOuQ9VqfbJbqsHgMChkGCApTwwQ==@lists.infradead.org
X-Received: by 2002:a05:6102:950:b0:7b3:8f0a:f76c with SMTP id
 ada2fe7eead31-7d072bb3726mr8218716137.13.1793872596997; Thu, 05 Nov 2026
 01:56:36 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104-work-procfs-cleanup-v2-0-1e6687e226b1@kernel.org> <20261104-work-procfs-cleanup-v2-5-1e6687e226b1@kernel.org>
In-Reply-To: <20261104-work-procfs-cleanup-v2-5-1e6687e226b1@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:56:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWkL=-oCgLA3HB0_Js_TdJ+P9FDBPF-u2z7uHrL+m7g-g@mail.gmail.com>
X-Gm-Features: AclHuK_YSG69l_UQ8CXymziWm2hhXR-Ce9gvdG6ZGXmuBEE26IV_RBgt33sxH_I
Message-ID: <CAMuHMdWkL=-oCgLA3HB0_Js_TdJ+P9FDBPF-u2z7uHrL+m7g-g@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 5/6] proc: drop the _buf suffix from the new methods
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net, 
	jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, 
	samba-technical@lists.samba.org, sparclinux@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_020223_794071_014446C6 
X-CRM114-Status: GOOD (  19.79  )
X-Spam-Score: -1.6 (-)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 4 Nov 2026 at 22:16, Christian Brauner <brauner@kernel.org> wrote:
> The _buf suffix told them apart from ->proc_write(), ->proc_read() and
> ->proc_ioctl(), which copied to and from userspace themselves. Those
> are gone now. So drop the suffix. ->proc_write(), ->proc_read() and
> ->proc_ioctl() are the methods that work on procfs' buffers from now
> on, which is what kernfs calls its read and write as well.
>
> Done with sed. The flags and helpers in fs/proc that go with them are
> renamed to match.
>
> No functional changes.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

>  arch/m68k/kernel/bootinfo_proc.c                   |  2 +-
>  drivers/zorro/proc.c                               |  2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k/zorro

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


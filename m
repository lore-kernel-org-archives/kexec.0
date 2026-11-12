Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29AA606A31C
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 19:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YB4XHlLE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=x7avfF8CE7MQkedzx8waSCJsEYoj4qczcsv6b4mLDHA=; b=YB4XHlLEg6AVu3lnD7E6WYLp0B
	jUY6h20lT7lRdTHovpjuWRsxSWqAAS0fF9nrzny7f9RM+34A7Qpv9b4qTeiUtYzopAxVlE6KDj+Hj
	EfJsFXLMKnlHA0KMfgM0RIHXUyf9QVkytsz7NeKiIZ1dOy8gmaXNtcWZqWqzyLzEzxD7sx6e+PvBz
	BlCZ7ysqCLNu648rUdWB9bDgAvjxh8xT7HfvxewAU3ifWTjLXfkS6/ySfzaauyYQxuTh6PsIYX47+
	uCWJTdxzSsnHauIQtH8kEkeXMyzVIKpgkq72YvgoO7j7TzNpZfCaAc3DFlnApsOkE3vFMgOpcHgA0
	PHCKe+Zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRa9u-0000000AvA5-1Lr9;
	Thu, 12 Nov 2026 19:08:30 +0000
Received: from mail-vs1-f49.google.com ([209.85.217.49])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRa9m-0000000Av8L-2Tye
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 19:08:25 +0000
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7d2db6408cfso54077137.1
        for <kexec@lists.infradead.org>; Thu, 12 Nov 2026 11:08:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794510501; x=1795115301;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=x7avfF8CE7MQkedzx8waSCJsEYoj4qczcsv6b4mLDHA=;
        b=fLyQmmihabwBjmxdtOxFWtgXxXv8looZY/4q7G+cjIL3Mj0mg4evaz1HQ7cKUDUoNK
         TyAfqW5GWfXd89u111f5WaQH+lRYn7s95zgb2EUG2MQX+P8JYJkUFuDAk9ZiHmLwdnWj
         rpay2//dxeMhHQCqv7hTzTtEzrIRFkSoP5eGQ6PzO8TX+VFtFy9AQ8l5ylt4efQeU/L+
         p8vx2/AeaPGevXIm+5OI/dMWAuhG5kLfFuhxWKK9KdUOk/+0rv9W1KKmmvlMZlktp8+a
         nIejtCGQNSp0kheCfUX4noaSPaqAFHlJCaTNWe5Djdo7tJPleedjZgMTs6lpnT9BPSO+
         1+4Q==
X-Forwarded-Encrypted: i=1; AL+hErGC5zoo2MpCLbQkOzTKuwFdY2qGxrNNVu4mT6p3/Yjuuo7qZYVuElkzJ/YaDG5ZeSFoP9nzTw==@lists.infradead.org
X-Gm-Message-State: APuU4Z/zLz/eotlD13qKhXFqN7nGe7qFOxjHHmYRP+WWPJXWMCEkNk0m
	/s1/2CkQ7fwC6OKLxjJsh43DGGzShjuidnlLeRXbYpZ0S4xMzps/L3bOVWla1TBjv+M=
X-Gm-Gg: AYBFou0sPFQMqKOa3cv4sxa3uWnB/svUb/P7qxOqU2GU+7voQ8ldYY2YqYjyM6AO6Vx
	MHhtgaFHEq9L9eGJ1l0fUlMlDME0NrGclAy5wxtNIfvGV0kKyaODHAAXNKxHKCk9wDTwmKr0pP5
	hR+b3kVX23JQyO0/2acXr3B+eYBdybMOH5/glYiJdvjG3GyX+PaEDK1E1CdVlxBjq7b24Ww0s5H
	DtrHyeKl2PxZSqMXC3h31m4EK1M1eBJo/Bixxh7KycK9mAwgxBxJXM6ZQUbZc8NRo+NDYuPKFN/
	rMsK7vKKheqdeM+LRD64aeh+IeGbo9BSky6vEYjp6i7eJbIrTU0qr3bmU06UipydicTUQ9I42GW
	C7n/vgPFXUv1MzvNmM5pZlHSrwCCdikoMBZCLsggOnQo13C67mca5+AQea6kjTwhF1/ciju3DNG
	bRvfsHRTTFHfOAnAHDQtVrYhwBEnUtCgv2RBdOKeEwvQTJqLUP54lDjgDnrEAkE0nt0ApYPAWOo
	E9b3O2Ikj53zDFqx2gQ6hIDfbZTK7ai42ilwRYTpAJVdc/A7HZ7HtT8Jw1Pa2D0vQWxXoNl1qUO
	ezUoMyxlZ/WPAQmhaQCmbDvtjFuYyVTp+lB9lApDFh812XLmtpJ4E3sCNGGOC1SG7fg=
X-Received: by 2002:a05:6102:6f08:b0:7d0:5688:f507 with SMTP id ada2fe7eead31-7d64d7ca46bmr53993137.20.1794510501324;
        Thu, 12 Nov 2026 11:08:21 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d64c1b33e1sm256689137.1.2026.11.12.11.08.02
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 11:08:08 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-998569550adso141105241.2
        for <kexec@lists.infradead.org>; Thu, 12 Nov 2026 11:08:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHXO3wBXzmMBe+dPOKgK9NTVKBHEE3iAX/LTMZK7C4sZUNxpCk3rh0VJIOUGcEIawPlFjmUpw==@lists.infradead.org
X-Received: by 2002:a05:6102:c15:b0:7d2:8dd0:2eb with SMTP id
 ada2fe7eead31-7d64d6ed886mr73919137.8.1794510481935; Thu, 12 Nov 2026
 11:08:01 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org> <20261112-work-procfs-oldmem-v1-2-ecdcafd99265@kernel.org>
In-Reply-To: <20261112-work-procfs-oldmem-v1-2-ecdcafd99265@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Nov 2026 20:07:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUgOGjwOUMxSabUgtaVeKZW1wx78XOJL8joGKkZEj7RZw@mail.gmail.com>
X-Gm-Features: AclHuK8l5OcVstuPYNpoHJ657hIuMQK5i9ySH9sE9lHb16H-lVuh0fnzCqi0JCs
Message-ID: <CAMuHMdUgOGjwOUMxSabUgtaVeKZW1wx78XOJL8joGKkZEj7RZw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/4] sh/crash_dump: check ioremap() in copy_oldmem_page()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Breno Leitao <leitao@debian.org>, 
	Chris Mason <mason@kernel.org>, Thomas Gleixner <tglx@kernel.org>, x86@kernel.org, 
	kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, stable@vger.kernel.org, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_110823_727433_301AB080 
X-CRM114-Status: GOOD (  17.87  )
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 12 Nov 2026 at 17:43, Christian Brauner <brauner@kernel.org> wrote:
> copy_oldmem_page() maps a page of the old kernel with ioremap() and
> copies from it without checking whether the mapping worked. If it
> didn't, the copy reads from an offset into the NULL page.
>
> Return -ENOMEM like the other architectures do. read_from_oldmem() turns
> that into -EFAULT like any other short copy.
>
> Fixes: 4d5ade5b29c6 ("sh: kdump support.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


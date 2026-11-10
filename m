Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3153F60A2611
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 01:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=eWXCQjAS;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=eL8Srwgj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=; b=eWXCQjASmceZCAPPyo6dALDYwl
	n41xApZMVwIGzkfUaT92+StBtu+du9KW/sXrrbWM2XgqCU+e2jbtBCBW4xQx9O1bV5Jty7xhLRYuv
	XU/iKqAff5Gkat2S1YzyLI1bY8n4xKiOjGXEje//XUiCFwSS8YAzq29EkH2n1kqmEbtTu7lVKBlif
	RhxTG454LJ/qdczWqQ3DT0q2u4uupdRTlFhWXkD+MbA4aYrdY9Htzv8+yGwvuc8UjycsIZhLlHlaH
	xrrIlXvlO+Bl6VwQPGSP3ZaoB4vvtK6JKyOR11VVJCBOWuEDhL2U5WjkHFwC6t74oAW5XvqfOtQZg
	uqPS4XSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQaYe-000000023vk-3bXm;
	Tue, 10 Nov 2026 01:21:56 +0000
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQaYc-000000023rn-0rzU
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 01:21:55 +0000
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-6b6e7a05225so2032475a12.0
        for <kexec@lists.infradead.org>; Mon, 09 Nov 2026 17:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794273712; x=1794878512; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
        b=eL8SrwgjG3KWhr+2EeMG+sj4XBGI+KlAkbjzkSpKfR37YsLJk3RTZMl3SzAl/GwIhh
         c7EnX7sZWnqlOBdr77WFlpfeN/oxy92mJjfYpY3qOSVDsJhYwo8iloClv+/QVDEFBQma
         0c2S8sGgTm6yNpEee2RZcb+g4xSrjIWATM+cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794273712; x=1794878512;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
        b=eAIICUVZT7u/VbczxkrA/HucvIPkN3Z6rCDFEueaVejLciQXKqpSozEVQuU4KyHZOW
         3HCn94nQXZSgMVfFmhQwWFCmKkR3d2yDsLvh8fTuzhmAq5g8AcbmxQwvwqsKJOX4Chl4
         tQUQdf2H+xG5ll75evs2AsjMf8QaHq80ME0aAdgjYwSxXG6DZZUUJPJBSMuNlgwgZae4
         vOX/SeShHXUK2aUNhSGcIbbXFTQXJOWNmsxGLVnwsiPEsFG4WZhWp2PqU0ci5BXdFx8h
         QN/g+ibAqgNJxP8w8VgLEoDGxENZ7UYiITAfJ+LyTsdYbDj49tnistZUNfayOHUpz+Sm
         H1Wg==
X-Forwarded-Encrypted: i=1; AL+hErHG4WI4Cgl2Z4ENPWmkKL6z930/O612ryAgHaSYpeeYKZ9R3dhzoIx5DDWPk1ZD8mMJhfHfDw==@lists.infradead.org
X-Gm-Message-State: APuU4Z9zUM7dhkf6oglq8xNy/+cQdhz3muPgGoc428eMclCXJFsVcVM6
	WsgiN4fkWiM9A/mwwkr2Fd0ncoyDgoE/oSfAv3qyLEqTl0Sa/7Bf9MvHJTPD00+AckXNHVBjAFM
	GTb/pNqRTZA==
X-Gm-Gg: AYBFou3RvyOft58xXcgcX6unyKKkuZfGnxaSYTQRhXNVpc9KINdB+HhCWqcjTmuQii2
	bDkp8WhxkUQAqhj0Wpyec3QNG6C1ib/t3pnAE3a1uHidDYOJBeQgqMTVgGIahZqBoDgTCiheO9U
	ZLWrnOu8eT8SXijOkGI+hcjBmIoTuwKbdHua5JbiL6DBdSANLdrLycBn7Ietl0dQ3LJ1Vnj6NVl
	zsqgMACIeWZP5+iMmn0VF3cmTlkDDp91VN8soRhfSfPYFlzhvRks7x1IUsCpEZu4bxrGuEiFl3w
	Ws7ZmVAaAO3VbOE2Jim0He5vJUfQdCFaMzM3yX+upZ8TgRGqoJvIx8kCuzs+j4PyoWB7fGaqo9e
	32vBj1V7FYF9bx4sl4CaTp50xEYcQ9fweAjr5uXWQbKDYcpl6Mps3W54RTzUAOJZZicA1aJ0aMy
	dPBQOniKnzaWtEBqEyCT+sWUXLnfbvJoZ3xtZFb4y/23FICpcmTSN0pMD+CTvIhFB3TA6h3WZHV
	aR38wzbYKoURhzo1i5PBJa6vovXp6QjXdDKh/4KPDWYVib+uW+M35kfX0Zj2oYQ9uVzYuZThJO9
	YcnOhivqGx6N8YRKt0vf26zPbZsepunR7jBKNX5QGGf8ZR9BS48iXdaSo00lbU+mzs5GtSb4xDh
	R/Q==
X-Received: by 2002:aa7:d813:0:b0:6b7:834:4eb3 with SMTP id 4fb4d7f45d1cf-6b7564f9db8mr682491a12.7.1794273712247;
        Mon, 09 Nov 2026 17:21:52 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7578bcc7csm420007a12.10.2026.11.09.17.21.52
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 17:21:52 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b577addee9so2037863a12.1
        for <kexec@lists.infradead.org>; Mon, 09 Nov 2026 17:21:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHSXvfWXqwC1d7eOJ7Peal+0ULd44xChdz8Mq/Sqtp+3zdl3gDt3s96XfnFP2gM4dLJNEgeuQ==@lists.infradead.org
X-Received: by 2002:a17:907:9451:b0:c41:1750:59a2 with SMTP id
 a640c23a62f3a-c50495dfbd5mr87253466b.12.1794273275844; Mon, 09 Nov 2026
 17:14:35 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
 <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
 <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner> <20261108185953.28054fb3@pumpkin>
 <alpine.DEB.2.21.2611090504170.17804@angie.orcam.me.uk> <20261109214558.0d9d5228@pumpkin>
In-Reply-To: <20261109214558.0d9d5228@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Nov 2026 17:14:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whsA3tKcUCBJDj_vmJ11rVGT9rivgnKjGRgMO21CPmCxg@mail.gmail.com>
X-Gm-Features: AclHuK-x8jcOOQUqd2amGoGEAKER9jIFGaeL4LxxWAd0cGV7dz_RR64PtDogpPU
Message-ID: <CAHk-=whsA3tKcUCBJDj_vmJ11rVGT9rivgnKjGRgMO21CPmCxg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
To: David Laight <david.laight.linux@gmail.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Christian Brauner <brauner@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
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
X-CRM114-CacheID: sfid-20261109_172154_255987_93BED55D 
X-CRM114-Status: GOOD (  10.30  )
X-Spam-Score: -1.8 (-)
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 9 Nov 2026 at 13:46, David Laight <david.laight.linux@gmail.com> wrote:
>
> Just that the cast would have to be:
>         u8 *foo = (u8 *)bar;
> where 'bar' is 'char *', and I don't think you need a cast there when
> char is unsigned.

.. and just to clarify: 'char' is always unsigned in the kernel on all
architectures since commit 3bc753c06dd0 ("kbuild: treat char as always
unsigned") back four years ago...

            Linus


Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EAB606A334
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 10:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jY02RlzI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=LrgDMUrSYXpYgkAhfsYKg0ebb/uLgOfOMhqzX4yL0j4=; b=jY02RlzIcIDTXMK0KrXaW+UVYn
	XW2bg9rh735GDMFLaDIOHWoWVdOrQ0Q8Ff/LBcVQpyOmI3fnJiiaQcB9LmtxCBQXGzecG3S+6cx5S
	t4Q3sf0FdwKCcMdgpqgq4UBzJ6VxOfmWTaSkX5pA52/lsi9Z26/IBx0S8gviz/JLpxGxhqr68MD7g
	wuxzIg2jXECdsZMCYk/NoaC2DnG7L0efMOF0RyKbRaCWYaCfbL4h9gxxDrq9WYpVMt3Uf3BD1p9NU
	c4wGyRIYFc8dj9CKB60+Kcd4Bk06hgkeCLQ+qA6xf0iKtzSze5nuMHAdlS8Xtry2UcZgW7LqN4amk
	d5SXIylw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOuHS-00000008Nop-2wWp;
	Thu, 05 Nov 2026 10:01:14 +0000
Received: from mail-qk1-f178.google.com ([209.85.222.178])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOuHP-00000008NoP-2mOi
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 10:01:12 +0000
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93e7ad9f78dso201217885a.1
        for <kexec@lists.infradead.org>; Thu, 05 Nov 2026 02:01:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872870; x=1794477670;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LrgDMUrSYXpYgkAhfsYKg0ebb/uLgOfOMhqzX4yL0j4=;
        b=Fm4UYT4cD7CQxsmDaQxd8/SIeMzaePDB92tNEG75SizqmQ8WKGci8/Fszf8H1L/3ou
         0Mxg9xo9WNiPg6wWtIW6TNl3E7lrOc3VG8DP0QxYDEx7WX65bwycq54L4ji6TgHTuxPY
         3StvLv3Ju39XyVuDEYKvD5djzVgLdHOaKZC0YLOjXeg91L/qGp+im7+UhtR7IGuVFMdP
         2Jf8HpYc4YKJG4GLdB+zlS0k4kayRuJF9H8xUW90cVIiaOuSEMLdQek1Kmw4djKMNZis
         fz2w+X631ZodvcWEzGb2IjBO9SGO3egMM9rrqB8+w7cIX3wVyfEGamk8agGLLXRMqnEm
         MnPg==
X-Forwarded-Encrypted: i=1; AKwUvBzgwlkXb+QKOGUXDqDMVZMlMQsozgYgHiXWgcB/TpaiZCRz0rDxzGOFRxEpulpq7jF4eWXnIQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z/mXg7/lcaCCQkXHe8oNgLiaZ0iEnrj1jJT+Q7tf8PuUUUQCiUZ
	khGQANlT1KwDsmYVuoUa/UiuRLFvBR15gTTFybImmWIonlBW3RO/jNflrmsfAZZ35+k=
X-Gm-Gg: AYBFou0DDc7eBPOwcolqkdDzW8Arg70O9sFWHSrxupR9VvntDfwadu5hypvv114CB7F
	Ab63Y9viLJhkmaT/GpxMFk9abk+mxL4bJbs6q3oDgUJTzuJ7Y1RmsQ428d56FSf3GVevUgAANe1
	lP2kIWNfqCkIV5kbFkWM5lXxlZMgnaai6w3JhDkYevUQ/GHlvGXEkwXEG5FVWv5hjKeEwE0EUT2
	93+sSn7thV5tFaJ7O8kZNKK7gaSHfQti5h4ZrWM09XbNOZxxg6e7bBBuc0q3LfRgQtp+G6zdQQu
	sWFT8tgYS6kMjzJsSaAhiEWslAG/2UKB1h1Xg5r+Hk5CxrzJWps0quk+EbycQ0R9Z+K2TXIChP9
	0qkFs2PYaYMOO2NsJzbhrY8vA/bn9WpE9MQnre5E2dZ8Dzgn+zZCXBTM/W7UAADz9J//ffPip7K
	4BSE0XE4C5lxu6G1d54RDqjgJ052NvVCTcasmN7g9XuMrcQidRMwIWpmkmNUojhyUKihAg+ITau
	MGJ+o2meB4MP71xHEUy3J5xZJzXcO739khMcp7uPWuXvVPU8HEUL57f+2rhROLZK8CniVuko4vs
	Fr3Tq9eskLGB1i6HuwQmEDa6r9Eb+Veh6oiBcNwqLs/ZJHz9y0u/y8c5wROiw9NwDU5BZQ==
X-Received: by 2002:a05:620a:6292:b0:93f:26d6:d70b with SMTP id af79cd13be357-944217108f8mr2973437085a.29.1793872869879;
        Thu, 05 Nov 2026 02:01:09 -0800 (PST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com. [209.85.222.179])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d479a81asm426106385a.14.2026.11.05.02.01.09
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:01:09 -0800 (PST)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-945ae2daa3eso203193085a.0
        for <kexec@lists.infradead.org>; Thu, 05 Nov 2026 02:01:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxNFvV3WY8ZQNk0Wo2euGrEkbiRA8ilE450G2USAZNa9bLn8cbxFp/xysHTsRlEGe4BXocHoQ==@lists.infradead.org
X-Received: by 2002:a05:6102:5108:b0:7cc:56a:58e5 with SMTP id
 ada2fe7eead31-7d072d84a58mr8269567137.37.1793872526219; Thu, 05 Nov 2026
 01:55:26 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org> <20261104-work-procfs-drivers-v2-2-245e54e87116@kernel.org>
In-Reply-To: <20261104-work-procfs-drivers-v2-2-245e54e87116@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:55:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVHxQvKnJyKHrOZhaOg9Rn2hMeRU1JnMFFEEi31FPZaGg@mail.gmail.com>
X-Gm-Features: AclHuK_UsJ1nGicdWEWcMLQAICTi1A7pGF3yhNkxXkXRPqohle17eXAHHNBsR6k
Message-ID: <CAMuHMdVHxQvKnJyKHrOZhaOg9Rn2hMeRU1JnMFFEEi31FPZaGg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 02/26] zorro: let procfs copy out reads
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
X-CRM114-CacheID: sfid-20261105_020111_731360_7D7B3DBF 
X-CRM114-Status: GOOD (  17.32  )
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
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 4 Nov 2026 at 20:43, Christian Brauner <brauner@kernel.org> wrote:
> Implement ->proc_read_buf() so procfs copies what is read from
> /proc/bus/zorro/<slot> to userspace after it unpinned the entry.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


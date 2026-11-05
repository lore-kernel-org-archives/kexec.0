Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A9F606A328
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=W0SpKnM/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=SqrTjgENN7Dfs+HehxbKPgACeb32UvvfMAFijNHd6N4=; b=W0SpKnM/HsVkNTZCy9KeNrksNX
	sFbggCsJ/Y5fr2FE1zaitfBgSFH4RGAK+I3F/q98zW7ppL51m75cB8V9u7urGo97OVEmyyauevX8W
	/foEwC/B6TQpvmZ05G/KE1FR7vBRwiRlz0eucM3A1UWRpm0HILwOde3CkioNZjTtXeGIUE+HNqxUA
	e0/AuwsVRHKP5eN/fvl9wT2FmxtYb/JCJL5ZCqUtx/e5RMP/2sWFnS4+iTKRVWf1X7XNY81RHi1a+
	dB65SblEoC5tE3RJo70bt4WuFa36/pnpx7nP3sjxpW/QmTd7Pz2t603aXiJ5zMseujDsyHfwSg66v
	sdEzPy3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOu1f-00000008LpO-2b7C;
	Thu, 05 Nov 2026 09:44:55 +0000
Received: from mail-vs1-f45.google.com ([209.85.217.45])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOu1c-00000008Lod-2Sx9
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 09:44:53 +0000
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7cc0e865dd1so513978137.1
        for <kexec@lists.infradead.org>; Thu, 05 Nov 2026 01:44:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793871891; x=1794476691;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SqrTjgENN7Dfs+HehxbKPgACeb32UvvfMAFijNHd6N4=;
        b=ZXZqzjQ3r/CQiuD5q9PJHuLXxy6DWBLbSB59+8qjwlNPFQ8LJSbaoPbtnHGjOCNBUA
         B3McifMWUc3y/nMmX9gUI+lLvgfPCpLdHLqgwbRPtuOoSqtrDiJjMgPg/MxXRXiQ9I4f
         C71JqiiwVXxWmL2u//c/SXCdC4SulW98hs/HzWMrTYXieS2mQrrs0mEp+AwGdnE23qVz
         5+wLMdq+HUMx+EedsXMVsxhKIdAn4e66ALAp7mb+8YW2/3RVdv2vFWnRY0nOX2pH//tG
         GXiwZf0o76vOhqadJ6mBRuW9geLVHgA4UgIeJL7q0fDJnf10juiw+/gJE4zCOLUrAxn6
         7nTg==
X-Forwarded-Encrypted: i=1; AKwUvByOx5VtahCVjw++qbO+PQShgB9p6PEsLBp25vybcNT9a7R1NXdrieAAjT09ESwcnEtPBqpoog==@lists.infradead.org
X-Gm-Message-State: APuU4Z8kgxkXFsiYswELwSAtnIADWqSkkeGUOwAqu+9gGlWagNXYa4Mt
	TPtZqcwv+V3VVH8wNajyiMZqpfoNRTg3ELp7C7WI9Z3VJTaPlndATESaOWsxlYNGpOw=
X-Gm-Gg: AYBFou0/8iHW/xiFXbEroOPJZFgxSgqh0LimEShTyhSy8e/7YP+GXYHcmzY9T1AJska
	5WttxbcvUDbU4UP1cZEYDkMBMAQtfZZfYS+pD/D7fW2ANuJJk5+fPJ3n6wMxxyxu/6HqiJWRhDq
	YXTk4bY5RVOQ4zwk+CJaTKbGiP29IFwnAdoAYWS/1jYILI5Ek9tgc1vSqotWVuAB8SAJwdopWvL
	p3hnjowKip9EC+j7m7SQG5qlJSDmvrQBOHFuBlnMy7ts41/R7Iy3s7MiXaNWeiTTHl/g3HH84Dj
	aS7V9RxbRmARPRyoKxDAiUJ8GfPVROphpMmqvmZxByKh/bDFkoaANJsS7nxGiBdb1cvGNHqReVd
	UHuoMBwF1eqywIr1XsNQn9L8xZH3hG5iAeLJrxwrbwz/ZXuiWLJoYfPnCAYTdykDLZcLX+bmMYJ
	uA+m8zgWSbaQbE4XKHO4FhazkeK4Dwu54nOIO1ST19VpPKB2AXJ1nq4aKDM/qdrZXRTAwm268BO
	NbF6HpUeGl/NKaQgu6DnDeWLt8/5cyyp5p1xH17bPNrcVBJRmrg268udJf7KblxFgg3zb8MCO4D
	RGYLcFGdhPaHectOqQ6oqbTfvFjf7SgxzPOMdfw/NhNsKxw13IXLxJ+iq+U5Y5xtFQ==
X-Received: by 2002:a05:6102:f12:b0:7d2:7c63:5a08 with SMTP id ada2fe7eead31-7d27c637376mr2173786137.32.1793871891192;
        Thu, 05 Nov 2026 01:44:51 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d91d2693sm4020511241.7.2026.11.05.01.44.45
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 01:44:48 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7cc2bb73cd9so498928137.3
        for <kexec@lists.infradead.org>; Thu, 05 Nov 2026 01:44:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByFpJHNS8lU3VD3asj8fQ/59RZjEYSu+5BhP6Apn+tSY/Br5glFBKBbTrIcUI6nb3RKYvUpRw==@lists.infradead.org
X-Received: by 2002:a05:6102:3ec5:b0:7cc:2bb7:131d with SMTP id
 ada2fe7eead31-7d072baa484mr7324212137.9.1793871885062; Thu, 05 Nov 2026
 01:44:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org> <20261104-work-procfs-bugfixes-v2-10-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-10-021c84d852e0@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:44:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUy1RYKG0g8OWss3AD-jyYx3DXL0K7ABYkFUdxTxZ9VdQ@mail.gmail.com>
X-Gm-Features: AclHuK9D-nB8icBns0zdoQH8fV1cfUPJ6LOey8o_VlUZpDIGqKC4cFf8-j5-HdE
Message-ID: <CAMuHMdUy1RYKG0g8OWss3AD-jyYx3DXL0K7ABYkFUdxTxZ9VdQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 10/51] zorro: size the proc files like what they serve
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
X-CRM114-CacheID: sfid-20261105_014452_632722_A8358D64 
X-CRM114-Status: GOOD (  16.91  )
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

On Wed, 4 Nov 2026 at 20:18, Christian Brauner <brauner@kernel.org> wrote:
> The files under /proc/bus/zorro hand out a struct ConfigDev and seek
> within that, but their size says sizeof(struct zorro_dev). Say
> sizeof(struct ConfigDev).
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
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


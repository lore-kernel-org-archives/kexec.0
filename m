Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1181A606A326
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 10:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wg0VIhUw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=n+1lmuZTLENNkpqKh8T8PUriZ63OKZ7RGcjsYNzzAGM=; b=wg0VIhUwgoutWwP3yDXPTY3yY6
	P6lspYIlBN7Tk4Uh7G2x1cP23LrWI6mCzYrE93oewGTHCWiAaP4BBusK8l9BEooNIP4ze1Omdm+Q9
	p9RHQP5+VWFHWchYyZh7JZ34Wg/RrpVfFVkPCLxutlsBIRvokX+sfpQmeDVNV6SNiPmAj3YXShsgn
	8DeImBfRosv/+UmsjSZhybkkv27TEdVNXHrt7wkmlMT3Go4WKBasYvJ/e1K9lYZaK6V7ULNNSiJVc
	g2ljol08ewQCw/nB/BswfPf3tTFhu4bX53bvwZlpYZkq5J+tbj2qEfI7AOvum+y/ij2lVKPgjXILw
	28XaLcVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOuIF-00000008NwX-38fT;
	Thu, 05 Nov 2026 10:02:03 +0000
Received: from mail-qt1-f172.google.com ([209.85.160.172])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOuIC-00000008Nvf-2Hv0
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 10:02:01 +0000
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-533778ab0bdso18545151cf.3
        for <kexec@lists.infradead.org>; Thu, 05 Nov 2026 02:02:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872919; x=1794477719;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n+1lmuZTLENNkpqKh8T8PUriZ63OKZ7RGcjsYNzzAGM=;
        b=DCtEBl5t5c96XyEGcTe3X6MYfIhd56VMEz2bFC+9g2J7xS+YQ5z29EosEORKZbsuJq
         4AREH/5GwUWapJnmSYsR2bCqQ+0+H6+BOkQuGAraDoCspZNt0c7V8WGT1tNeeZ5HfaiF
         fMcqNJRq1bJ9m7h0MDruxM1oD7KX2QcBURUZZsuTNntlZH2PziNz4z/myZRw9qonZV2V
         Noo2I22yaKdB1fPwKoEmOUJed1GJNkBjPA9DSj7iktjCwHi+AQPl7r+GDOv/EtQYvOaL
         yUnp6w7yTAUeBGFBsTPUlG7JCK1kPaqQZPVY8YL2GACDyYr8474F14qLxWuYtGtdOBZQ
         tCaw==
X-Forwarded-Encrypted: i=1; AKwUvBwq04GGGeDAhGHM7iNsFqLelIzYQAZcON47PV/CBwAjz5ZmT8qsI94C+e8MShekzCXXljTi6Q==@lists.infradead.org
X-Gm-Message-State: APuU4Z857CzyDi0bCYX15HuUpJrAXgduer1Lm9/Blr4Kk30AwAcqaTFa
	rBSXMvGwZXJQmYOFDFxPyGu2m9N0GjRosv27lf/XBhfTjORZ6A0OBTb4j8AtbKE0GDQ=
X-Gm-Gg: AYBFou2gRu0uQpycA+JJjIf0VkmOjLN6ShNW8MqTmy59PYVV8SfXTr8m/U3uXQA54KF
	ZWBw/fP26+Q7a+xWWLTtSfVSFX7GRSualDPv9QccYwbSYuMXLh/52135Hm6P2+2iffE5ThUM1OT
	PC4tSV9naCmyBhwqb9eDkCyQD7tkIAnrzYX+0V9JrjqiXBvbVXHqjmvIMysQkkdXAFQUrSEVI15
	IbbfA10tmgLD380x+4sbewMOVzDfhSFNvbCRTfaQY0k55hhvavtwX/22zAue90qrfS2OFT8okAV
	g/R9uFlejDuuVuW6c7PkEEGIJGDG3FyyAWUV793rSQiTcN7oItLoChgnFY86PVr5ji4C+0hMOEo
	hFiWVWgDeH2Ss9u9Bb4X8adrEhR5ZBVscWHEj7qYoD3cNZ44Wc0+H/15AXNat78X4gkejnt9rtR
	NCfg/XU+5AVIw/B/BVYjGdvmOYaRGYcimqtlMoD5sNdTVgeL7PgILp9srlfM2NmjRhOpkTKIi1h
	1eH5fhjLA/vxLoTdTRPss2SXEU7e+XUqza2eBNakowsy7Z+aHiTPMqc9pHHL8IVuJa/qswq004B
	hYGRZeYnLH0qsWVtiCuGX5AodIORtkkbb2oaDyJcsSUTNC29MBTEkh2BYNGX1GnaAFDrRg==
X-Received: by 2002:a05:622a:410f:b0:535:2314:6280 with SMTP id d75a77b69052e-542b639bf45mr290966231cf.17.1793872919050;
        Thu, 05 Nov 2026 02:01:59 -0800 (PST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com. [209.85.222.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10c4dcddsm48002281cf.20.2026.11.05.02.01.58
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:01:58 -0800 (PST)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93f269e335eso196666085a.3
        for <kexec@lists.infradead.org>; Thu, 05 Nov 2026 02:01:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBypGJHvCNjQgrJxZA2hldHuFqqoQ/Cg24pYWOjGhkp5A3Soj+0canc36gOkkziJae4V8vCW5w==@lists.infradead.org
X-Received: by 2002:a05:6102:6449:b0:7cb:bc5e:7dad with SMTP id
 ada2fe7eead31-7d072baa450mr7614890137.10.1793872492413; Thu, 05 Nov 2026
 01:54:52 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104-work-procfs-arch-v2-0-2aeb952c9597@kernel.org> <20261104-work-procfs-arch-v2-4-2aeb952c9597@kernel.org>
In-Reply-To: <20261104-work-procfs-arch-v2-4-2aeb952c9597@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:54:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUNBs_NyhFpXonirMXkYptUWsAizMvVpGHUDLzto1LGJg@mail.gmail.com>
X-Gm-Features: AclHuK_RsrcE7hVRjmpZezBV5tMd490Mza2XAQiqUTgUNqAiHAzRP5z7NIbtMh8
Message-ID: <CAMuHMdUNBs_NyhFpXonirMXkYptUWsAizMvVpGHUDLzto1LGJg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 04/23] m68k/bootinfo: let procfs copy out reads
 of /proc/bootinfo
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
X-CRM114-CacheID: sfid-20261105_020200_612085_32A99E0F 
X-CRM114-Status: GOOD (  17.05  )
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

On Wed, 4 Nov 2026 at 20:36, Christian Brauner <brauner@kernel.org> wrote:
> Implement ->proc_read_buf() so procfs copies what is read to userspace
> after it unpinned the entry.
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


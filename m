Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C949606A31C
	for <kexec@archiver.kernel.org>; Sun,  8 Nov 2026 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WP403eNH;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OlxUtW4W
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=; b=WP403eNHb9aVKk
	pC5i4oF6mmU4EtRJCPRMt5cqJ0xwwBOsCqF0ZkM9pqFcCsVoT8xA5coYuW/9hEe9opEoQa59lpV05
	ky/UYvI6EtjdbmyeT1tvhb45pQZ55U/YwZMtUrP6ylR/WsvzubeVVngnFjKDVusGR1ef6XZ7z89v/
	xsMZBIW+1WvIy+ieg98Ghlo1Q0sl4rgVOeLq47nEfjCrdI0w060cfh4Azr5JZSGh2EiS3OBZCY3sq
	kYTzOVra1DDUV47qYRT5XuG6VZgABK8pYcahxBPXK3CNJlWFGZefW/qLycTCVpdaMpimRBzzpvo/C
	swXy0DllJRfLztWoIvRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ87W-0000000GVIk-0LYy;
	Sun, 08 Nov 2026 19:00:02 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ87S-0000000GVGc-3q1W
	for kexec@lists.infradead.org;
	Sun, 08 Nov 2026 19:00:00 +0000
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso1791465e9.1
        for <kexec@lists.infradead.org>; Sun, 08 Nov 2026 10:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794164397; x=1794769197; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
        b=OlxUtW4W6uqa2tsKt9NGfVi9D57GZbeCca5A50Gy/2/cFvf+U89j+Az9aB7nxeacOs
         BebgBAWAN1hUYkyU2z4gGkWyXuGWelET9WNN0luIU6k+5ETtHPWzTKM0U8R7ekg0PkOO
         CDXJ6DGfxXw4FRD4Myx+kJKHo2xG/2zLU1BbmCN+RlBsk6vdVaJVhfwwUxhZL0DaFTp9
         SK9ukAQmCf41fQ4G3rVkRCBN6JWbV4aWwtfMkVtM7t/EIbSaQIT3+GP+0Jq9DLF/fVb9
         /BURrY7bWfhnyI0KWO5OPd20wdSSaEehjiNAxngcGYDxqOfAC7oCCDqFWaTnLU0aJqbT
         2d/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794164397; x=1794769197;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
        b=KN3qII+s5CrZaiW9kFtU2xKGjus7SyAISaGMWFbOURexpf5Uu0g2NPsQVAHmfuCNKR
         kc9pRQVIlFLWG93veHZoK2YXw5olnEXellJvreqiLQsMWeZLRELUp5mQkEdoFGqlDQjK
         1xvChbxp5FY5nYcvFV0d9uQPcY2vJIQDOCqOv8T+4gIye1FFC6FMtI+j2Cmwci0r9oht
         g2xMdS+B7lM1GaXm6//1tbOEdbRmIZVeMQ6BW3PEsCbRpVd6MGrCOOXakIZ0QrX1JQok
         4I/FECiRama4GThQk9LgbNlgKUHA6xD+eRfYkg0wRaxxkYew7eCqh0iosEa33YCuB0AK
         K2hQ==
X-Forwarded-Encrypted: i=1; AL+hErFbrz6mPiYVoNFf48DmihthmBcg3QD+gfv1+UBMv2lmaGxutcpfmDBuLt9O+ib0YnJ8N0rSSQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z8VTpRcOlszUgX1uJu3DxBl3gmgU9Y6Zrz2iu9jd2vF3MP1jdbd
	K7Cyr0pMMbitz83buu4MvWqtmJwXA65gHjPvHcsH2ISU9D8r5lkXPd5g
X-Gm-Gg: AYBFou0L7C3UALExr/sCIFhEtdZkBsEUzMEFX8tQ5xWFKQzMgKEbb58HKo6fXWUheA8
	NawDKitpTWrKFB/0oV2h7mVyvJlwn/D5baaQ7KsYUaBTeDRfscl7HbGQoxU626k/8J1qAPdbHkb
	q5TwYdNBM1h3qISa1VcsqfN0Am57YKFuTX86UzMnNaRFbtsRUBaCJD2xZif3HQwc6TgvKJOOwLw
	xbF+5XpmCmwK+Oh7TZl82MFmntAPlSX+LRAxbeHWfXgikBXMy83jsQKEaBHeAe9cYYeCxLjYQ0Y
	FxT/3B+l/SSW6cH74fV7BtaO55c6M/o0XpvzXMMjNgVHWFmNCaXuLw4gNpLdmiaS5yIDs+PoEBr
	x2RKN2dE7pDceEBKxMTFNxSsk2watM/tlVXnUmFYo5NeMcZUrgJIc6LuokwBQNtXuf9VDDq/3Ft
	yh14GtoZ1NJXSvvQ9rYrpoHTQdJ31Tcywrq/eOuwRMzkjopamdIfXF0pkMW17aoTRMmdCvnKQxb
	YVc74/ad+eyKomxbLMLqutno3sEO1nJjZTQoPcevOMp63MA/aRnbobDVQCXg/SKtuf2xl1UYlGW
	PwhTTpsVOFbXuwy565jh/rsoLKIriE9Q5tVOOVvYZCP7cHx6yxuivQj1FfR7Q/dr
X-Received: by 2002:a05:600c:468f:b0:4a1:7e77:c382 with SMTP id 5b1f17b1804b1-4b960d9b170mr35982125e9.5.1794164396406;
        Sun, 08 Nov 2026 10:59:56 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7efb1f3acsm185228445e9.14.2026.11.08.10.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 10:59:56 -0800 (PST)
Date: Sun, 8 Nov 2026 18:59:53 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-fsdevel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, Josef Bacik
 <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, Jeff Layton
 <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet
 <edumazet@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, Christoph
 Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, Joel Granados
 <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara
 <jack@suse.cz>, Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-um@lists.infradead.org,
 linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, ntfs3@lists.linux.dev,
 platform-driver-x86@vger.kernel.org, coreteam@netfilter.org,
 kexec@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-mm@kvack.org, linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
 samba-technical@lists.samba.org, sparclinux@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-debuggers@vger.kernel.org, Chuck Lever
 <cel@kernel.org>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
Message-ID: <20261108185953.28054fb3@pumpkin>
In-Reply-To: <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
	<CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
	<20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_105958_968904_4B8FF5F6 
X-CRM114-Status: GOOD (  12.48  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 7 Nov 2026 10:48:35 +0100
Christian Brauner <brauner@kernel.org> wrote:

> > While at it, I think it would be good to use this conversion as an
> > opportunity to replace "char *" by "void *", which will probably let
> > you drop several casts from users.  
> 
> So I tried that too. The thing is it drops exactly one u8 * cast in
> ntfs3's label write. 

Since char is now unsigned that one isn't even needed...

David


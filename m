Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0477B607F2AA
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 20:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Z3eU32Oh;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=gSZvp9Ms
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=; b=Z3eU32OhX6CM6tEk13G+Kjbxnd
	NVc55R8ur/FWeYKCzIKwjgDYm0P4txFccOzEiHBvqwTyQxVRLM9h9OC1FCotgsU64qXTSb5QM/UiV
	7qLI6pYwpQLHiMVKTb7WNKQKSX4sqN0w6I4LdG7ZhAm1blL0HPHY02+H7mIgKMfQGGsWFua/1pBon
	ez6WmKgCGiYv4B6I7QIZNbcjizXelwfiZzatIpQgS6AGOvbV+v+fBWLO0Kxr9+q4GO4y/Gi0RJ/o4
	eKxcMWgO+GQ0j6No7N8rNY0x17wYJUpc8d4a1qfTEuuux/uERslwIXksRfKcMxblmxA4YV5pWHqt/
	iufIcckw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOhKs-00000006rbq-1IZI;
	Wed, 04 Nov 2026 20:11:54 +0000
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOhKm-00000006rat-1TfA
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 20:11:53 +0000
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-c418e215671so167626166b.0
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 12:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793823106; x=1794427906; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
        b=gSZvp9Msmajc5hpUmiGk/Vv2RYzUdBb7vPMPEO+2QBKGa94ysIbxB+kXLIw213nE2k
         kgypC+oGjygahQZ0y7ifWl7BbkOZFyxP9rf1QgGdd4/Gje2ZUJ9xzzBAkMDqRp3R9S0Y
         WrK05WCh8At223plQzIP5N0Fj17G7cR8Qu0ZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793823106; x=1794427906;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
        b=CqU8EuenxKrxoJiElPCCLTEmJZtKZBB2/AiBR2r+V/r+E/ymM6QvBQoFdMXLf9+5Bv
         1k20/A/+b0Oi1XxOGUUCWlP/lbddymlDr+yOfvnmevPokk3mOUzCwqbNUu1jScQL/MFw
         NtfoFBUZay4sZHspWQ+Xc79CZalPWJDFBQvIbF3mzyn2vvi+bGbRqZz6T/sOOzCzs2Xq
         uX069JsrvyPmDb9zjyGHvwPEuTZe1eG0M5rfrm0RCoz57rdFofj/6Lu9qWxtyqWLHYzk
         mjq7TZ+cr3err0kT9hoRgVu0kzUt+GEbg2vLfMvTHjU091Jkwt5yYUDFPNEk2kc+jpZf
         vZNQ==
X-Forwarded-Encrypted: i=1; AKwUvBzvxvnboxdVC/KIUCkiNm0GN3mHIGdD/UuHdKhTQS4r2WXckA+DLPGQnHYxImBDj3vat34I2A==@lists.infradead.org
X-Gm-Message-State: APuU4Z+6E/nZUpV1wJwS3C8Kt16HDESr8tsEZoZm0wuTrTBlTbCeKoGk
	CFqqri7BOMITOsyoJ7jzj+fAkPK7CmOOVII8A1hWm8TURUnb6Mq1ar6UjAZ7K7U9HZ/auMVNWoP
	TrFtjV0X4lA==
X-Gm-Gg: AYBFou0kglX2KxfFiMp3Hu+4xnBKK24tqkq7O5Y7202FjgNMaebTWiMq8U5jh6RuYCi
	NwlR8tDiAf4dV4Vr4h1EOi28lqNE66Sxj662OaywV4qok5AugfUT7F1kLxsayNpW1QPQJnQhYKF
	mUrLlNPDYIuvk8M3rQGO1As+qXRGzCW/jmI+Uj6aveSAgtm0+YiHbQPsQttXAZcPyBC0Lj0IlaS
	1TYDPTr9+kpLNwtdhSvzSG0pwpkMaoJ/kAj3jWBUp1b2udFYTa0Wymaw8fHgCQouFFWudjercLm
	Xtil/sChNz7ANPKHjTUuDiBgt4313b0vDNlVVyMCKuG7Myx/9knquj/XffXfeYQE6jSiulJD93q
	7ib/wALshW02jwmaw8dtOScouKmylPMPGvZAzqqpIPS+stA78PayEmzJROaTcdW4fDY6fKcksOx
	oCtF1xDvFq2apC/UHobEDSy/1km9H689mQXPI8BZIjDXjk5c90FDZmPN/I7/INXAPxrpCOeKvTI
	qh0u6YIjcir0QaWaSH0cT82sQeYh4hT88kfL/CZVAwiFrZZFRM4F0L1SKqWuz0RR4aXVySQxge9
	LXj4q5ubORu9qJbkHrwseMf8zlxUxyX21/6lADj6l9IUwBrXpih7R50ofFG0jemP1PZfXT43IEM
	o/DHbmPFP4y6HiGexNG7BAvs=
X-Received: by 2002:a17:906:99ca:b0:c31:c767:adfb with SMTP id a640c23a62f3a-c4ca7432ef7mr1447976266b.0.1793823106176;
        Wed, 04 Nov 2026 12:11:46 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e43ea74sm106628666b.33.2026.11.04.12.11.46
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 12:11:46 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4550d8ab15so176871166b.2
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 12:11:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwwBeR8yaX8TmPpq8uAnxGxrdAn2v3RTEd118QTuZIo0Wh/D/KcAfTwuhG5qTcs6xW7T+Cgww==@lists.infradead.org
X-Received: by 2002:a17:907:60c8:b0:c49:a4b1:9cb1 with SMTP id
 a640c23a62f3a-c4ca795fa50mr1973235866b.3.1793822725121; Wed, 04 Nov 2026
 12:05:25 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104-work-procfs-v2-0-b45cd5789ac5@brauner> <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
In-Reply-To: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 4 Nov 2026 12:05:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
X-Gm-Features: AclHuK9j_YIgrwhhpWOlnull6heAULBd4dgTqoOhUQQjFm_MgoIgrL1vgPfefvI
Message-ID: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 00/30] proc: convert the fs, kernel and mm
 entries (Part 5/7)
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
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
X-CRM114-CacheID: sfid-20261104_121148_777692_8C3B6F4E 
X-CRM114-Status: UNSURE (   7.98  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.7 (-)
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

On Wed, 4 Nov 2026 at 11:49, Christian Brauner <brauner@kernel.org> wrote:
>
> Part 5/7 of "proc: move procfs to what kernfs does", on top of part 2

Christian - way too many patches, re-sent much too often, cc'd to way
too many people.

Nobody is going to read these repeated resends, and all you are doing
is clogging up peoples mailboxes.

             Linus


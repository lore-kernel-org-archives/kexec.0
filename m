Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5532CC0218A
	for <kexec@archiver.kernel.org>; Thu, 30 Jan 2025 09:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4CM+Y34LzyqTPbJa964bMKTZoegb6ZCbeVLJYvxkr2Y=; b=dBoPD7X4/tgcDhf+Fd6ZLGaSGy
	M5xUtBC8H67N7jOmtcZAsF3bTh8SvVg1DnCRHMm6pfTwkqAXrawVlMIkbBfluYyGuMk2QHGDveiLS
	VEAnWCATm6yJ+vPcY9dhWGh0PmyZLhOVcCS6p1UocuVKCibFD4HXUs6sxrVaWukXWbyn6zyheBy+G
	dWrXU/njb8X15plG0ojw0Ed296v5xz83cUx9DzbxrqeG4Gm8zAR52+DoJsDef+iCOJxrmWkzx6FkJ
	av4b2pX9ppITS23BBtoPYika24qJ2UBzEa50yT8rrD0jSY+pk1Li4Kyj/5Dhkd/yrL8EtlZNQjwzG
	+ZVjefiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdQZl-00000008Tyh-1rz3;
	Thu, 30 Jan 2025 09:11:05 +0000
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcnkJ-00000005Az2-2DS7
	for kexec@lists.infradead.org;
	Tue, 28 Jan 2025 15:43:25 +0000
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-e5447fae695so10101576276.2
        for <kexec@lists.infradead.org>; Tue, 28 Jan 2025 07:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1738079001; x=1738683801; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CM+Y34LzyqTPbJa964bMKTZoegb6ZCbeVLJYvxkr2Y=;
        b=S3XKveMjKzfH4sM7l+XcDfSpOxOCeWxER5OxmK97tYGgefExIMXdeuU9fDTRcDrAOX
         oUzzvm75N/hHXZCCRyae0SDsuFtnZQOhy3njpv1m2bOmW8FvGJCwZf+IVDT4R6+y9PHD
         02/PrEkU0SoBv7VGOI7YFix6KZ1KGztwBbjlAGMYPMQdIwyydXU7oMq8VuD5IlLKVAMR
         bLZ5XDbvVg3BKw9AwbVShFEDjIZnNUnK2nGtV3+9h8E0r1R+8vRPX7Nx83YIWCHsje7O
         TCTOYTXBhQGHiMH0OLq7Ve1vIWjQmleYy4heoM87IbOq+SsITtDlRcLiTm8n9W2tv0qO
         M6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738079001; x=1738683801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CM+Y34LzyqTPbJa964bMKTZoegb6ZCbeVLJYvxkr2Y=;
        b=NBwKt4RzBx9NldQIbqvSaWf1KRrH/JxibTPPBcjaC2UGs2XwE3k83Wk8ViAd15iM5d
         XKEb46IZnozxOEmLlCBgZdieHTZc1XeDYJOkQ/QpiZ9fQNrovy3Yz0dEoEqVNVbf67cu
         nWEUoxjF7TANMGZvvbvQjBsMfWhfPn24CF6oXTnSKQiyvmiKZxHRlRaHNpWXtKQXLaG3
         iCR6KXC7puaOPmSGIIaM3C+mkniugZYiK91hkxqUFeO4F5ZA3yvftVdBd0YUHpE2tg1h
         25qDpYEqwfvPxY+bcz8334q6m6v0XZ/qn1CjOE7LOuRvFltffun77r+s+nvSoL1VbVuH
         booA==
X-Forwarded-Encrypted: i=1; AJvYcCVWzOjW0McN4fy3UQoGUw2v0SLunU/1O3OyRSBkLVnzuaBKlcKxJDhM2lwsqOc2om8Qbtrz2g==@lists.infradead.org
X-Gm-Message-State: AOJu0YxJQoZZcYhqQHpyOksH3dYm5h4pUGGMWjGYVdS4hdQcst0B1QWj
	yV+Vs+uNXFl0t0yeBoP2G5gu/pDqUMIhCVU0gcYgHvrgR2PTgdZFwyHATpdgbWrHl4G9B095PO0
	4h7VkLMVkAnOSv5A6C+u6sGSbHjNlW3MN0b9E
X-Gm-Gg: ASbGncuOaMmu+C2i3NTwgb//iSQf2uwItdq2xbPQO1ZsCDVlokyZxHx5DspDYl0EXu0
	Cd9uZXpNOZaNrRCZOV0BC1maw4KCtEJgoYcMDOVjP4cTjce/ZeLVX43r4UstgpeJHUgllRUY=
X-Google-Smtp-Source: AGHT+IGuLqrmdoXiE8apV7tzhOJZ5Xm1OF/NxWm8Kjkh7RMoG05FR1MdO9WMx2ebniwyt0o5rEC0Jv+xP432BtVJDY0=
X-Received: by 2002:a05:690c:4d02:b0:6ef:6646:b50a with SMTP id
 00721157ae682-6f6eb6b2881mr361409457b3.20.1738079001445; Tue, 28 Jan 2025
 07:43:21 -0800 (PST)
MIME-Version: 1.0
References: <20250110-jag-ctl_table_const-v2-1-0000e1663144@kernel.org>
 <Z4+jwDBrZNRgu85S@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <nslqrapp4v3rknjgtfk4cg64ha7rewrrg24aslo2e5jmxfwce5@t4chrpuk632k>
 <CAMj1kXEZPe8zk7s67SADK9wVH3cfBup-sAZSC6_pJyng9QT7aw@mail.gmail.com>
 <f4lfo2fb7ajogucsvisfd5sg2avykavmkizr6ycsllcrco4mo3@qt2zx4zp57zh>
 <87jzag9ugx.fsf@intel.com> <Z5epb86xkHQ3BLhp@casper.infradead.org> <u2fwibsnbfvulxj6adigla6geiafh2vuve4hcyo4vmeytwjl7p@oz6xonrq5225>
In-Reply-To: <u2fwibsnbfvulxj6adigla6geiafh2vuve4hcyo4vmeytwjl7p@oz6xonrq5225>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Jan 2025 10:43:10 -0500
X-Gm-Features: AWEUYZkHRaUuCTQsu1U9C5jhigmIE9c2_8OmkE_i2Qv7ILXtAaTfDLC5EcLBZNk
Message-ID: <CAHC9VhQnB_bsQaezBfAcA0bE7Zoc99QXrvO1qjpHA-J8+_doYg@mail.gmail.com>
Subject: Re: Re: Re: Re: [PATCH v2] treewide: const qualify ctl_tables where applicable
To: Joel Granados <joel.granados@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Jani Nikula <jani.nikula@intel.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org, 
	openipmi-developer@lists.sourceforge.net, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-serial@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-aio@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, 
	codalist@coda.cs.cmu.edu, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, fsverity@lists.linux.dev, 
	linux-xfs@vger.kernel.org, io-uring@vger.kernel.org, bpf@vger.kernel.org, 
	kexec@lists.infradead.org, linux-trace-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, 
	Song Liu <song@kernel.org>, "Steven Rostedt (Google)" <rostedt@goodmis.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Corey Minyard <cminyard@mvista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_074323_880547_2C60E7CE 
X-CRM114-Status: GOOD (  18.94  )
X-Mailman-Approved-At: Thu, 30 Jan 2025 01:11:04 -0800
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

On Tue, Jan 28, 2025 at 6:22=E2=80=AFAM Joel Granados <joel.granados@kernel=
.org> wrote:
> On Mon, Jan 27, 2025 at 03:42:39PM +0000, Matthew Wilcox wrote:
> > On Mon, Jan 27, 2025 at 04:55:58PM +0200, Jani Nikula wrote:
> > > You could have static const within functions too. You get the rodata
> > > protection and function local scope, best of both worlds?
> >
> > timer_active is on the stack, so it can't be static const.
> >
> > Does this really need to be cc'd to such a wide distribution list?
> That is a very good question. I removed 160 people from the original
> e-mail and left the ones that where previously involved with this patch
> and left all the lists for good measure. But it seems I can reduce it
> even more.
>
> How about this: For these treewide efforts I just leave the people that
> are/were involved in the series and add two lists: linux-kernel and
> linux-hardening.
>
> Unless someone screams, I'll try this out on my next treewide.

I'm not screaming about it :) but anything that touches the LSM,
SELinux, or audit code (or matches the regex in MAINTAINERS) I would
prefer to see on the associated mailing list.

--=20
paul-moore.com


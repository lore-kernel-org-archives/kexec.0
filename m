Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F82E77188
	for <kexec@archiver.kernel.org>; Fri, 10 Jan 2025 11:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JSxjuNyxDuPeZYeh/mDIk1/h0nKxV8R1eU/I8hrKgcA=; b=eigGat5JIHReeANPvmKtgBNqP4
	kffscIoypnijwPzFATwT2iZeOC+Yu43nbcEEVT+1M52gYGR6frqX+AkhersPS+u0Q0M2b8jK92Ra5
	lskGTY13f1divLeoyKe47KwUTokDeR4Ki7J17kzeQjPLh4oCvxUUTbUKzFWzIlCA65UWTgtByGasx
	ZntBrxPKinmUs1qOhIo37yXhTCsVD9vWgAWP3Lt4wSx+KYh3b0g9/N0azXedSY3b2LhF9leAVR6+e
	yppWw6o5f4/qR6GRWpcRWMwRtLbVY1C1YGvyG7h6lbH1KLkPtPIP1Y4i7O2E5d/bpqVqLlqj0W3gv
	LMUAk9Sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWDJl-0000000F91N-1ofu;
	Fri, 10 Jan 2025 11:36:45 +0000
Received: from mail-ej1-f48.google.com ([209.85.218.48])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWDJj-0000000F90D-0su8
	for kexec@lists.infradead.org;
	Fri, 10 Jan 2025 11:36:44 +0000
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaf8f0ea963so384364166b.3
        for <kexec@lists.infradead.org>; Fri, 10 Jan 2025 03:36:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736509001; x=1737113801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSxjuNyxDuPeZYeh/mDIk1/h0nKxV8R1eU/I8hrKgcA=;
        b=Yc8GLCh7H/jzMZtPI8Vi15XshMfdlzDlA9oDsWBqFr2O1rJlxfSqHunUcNrjDEVAJ8
         r8QZP/BhOnmprhK/HFcfogW8kZgXEKCQ8fkEmt8OETo6xtPNVx3QmaH8YP+ZIbq0j4Sg
         X+4CIh0BFnnc0LFfSpHjbjEeatkSCgBX3vhGoG2Z2xOr8JipUBQYGsu/mNrp5UD5XK1d
         aW74U6X9vv5qLUsQGV6cwBE3VNEzkP3xE526vrIno0eS0vvKdQwtd7J83Pp69DZPmppc
         sKc3nLKDKQKFetSFSb9g8UjeI7iNFm4AZ5HhhzINlVttyTzyxZbSgjtESDF1c/tu29R+
         jgfg==
X-Forwarded-Encrypted: i=1; AJvYcCW+CARs1y5Z+x+kHPF8RrnpMr/Wwu+KDP86c9lQ+iidJARGcMc/rz/+9th9OGjbWHC87SzHlg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyK3x1eGwhb2fmZ4Y4MkfJcHHvC0ydkPi1uEjxSXwz9QYN6IhhY
	mRvqR4ms/Z/tKjO8y6HA0FLJx4EDxXZqgB0kHYeImo5bMnG68WR7
X-Gm-Gg: ASbGncsGo47BYXqmO2NFe5t3uDt0LQpqNSxtceH1n0DmgRBP5neutD0x9R7A2EIER8c
	Sqf32swN9XObrwvtJQfXuxTTBjbH5c2493hz1SEBVZ/ceugsEdlp+6z7rju0rOBBNc0dzX2vcmB
	CJzr68tujQHKxqB1Xb3T4WH1jmTrqH3X47ANzluPYfw+s7EzqRBE77HJsBZDfm1ju/7t5DVqBeb
	kmSxNWLyl20U9xVGJ4WGirg+VHd/lJK1Y1XKr3DMP05EBc=
X-Google-Smtp-Source: AGHT+IGIZlaaiO27kV1c6pYvSmK5yivViBw4/s4Cw1C7tk9hpsncmsora6RSQ36sS5AvV4d5XB7zDw==
X-Received: by 2002:a17:906:7311:b0:aab:7467:3f6a with SMTP id a640c23a62f3a-ab2ab6a45f5mr887149666b.21.1736509000764;
        Fri, 10 Jan 2025 03:36:40 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c905ec09sm157964566b.32.2025.01.10.03.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 03:36:40 -0800 (PST)
Date: Fri, 10 Jan 2025 03:36:38 -0800
From: Breno Leitao <leitao@debian.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Usama Arif <usamaarif642@gmail.com>, linux-efi@vger.kernel.org,
	devel@edk2.groups.io, kexec@lists.infradead.org, hannes@cmpxchg.org,
	dyoung@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
	gourry@gourry.net, kernel-team@meta.com
Subject: Re: [RFC 2/2] efi/memattr: add efi_mem_attr_table as a reserved
 region in 820_table_firmware
Message-ID: <20250110-tricky-grasshopper-of-maturity-21771f@leitao>
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-3-usamaarif642@gmail.com>
 <CAMj1kXFWZNRwx1H2HT8V9hNvUKDi0O3kcLku+g94UOvNBzz5eQ@mail.gmail.com>
 <cade51c5-5fcc-4208-b46c-f2e2038f03e7@gmail.com>
 <CAMj1kXFwgnQT4jQF8zsX05PdrF_QDXK0+Z-6DD6LiSgjqY738A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFwgnQT4jQF8zsX05PdrF_QDXK0+Z-6DD6LiSgjqY738A@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_033643_254784_8198D838 
X-CRM114-Status: GOOD (  19.00  )
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

Hello Ard,

On Fri, Jan 10, 2025 at 08:32:08AM +0100, Ard Biesheuvel wrote:
> On Thu, 9 Jan 2025 at 17:32, Usama Arif <usamaarif642@gmail.com> wrote:

> > I think in the end whoevers' responsibility it is, the easiest path forward
> > seems to be in kernel? (and not firmware or libstub)
> >
> 
> Agreed. But as I pointed out in the other thread, the memory
> attributes table only augments the memory map with permission
> information, and can be disregarded, and given how badly we mangle the
> memory map on x86, maybe this is the right choice here.

If this augmented memory is not preserved accross kexec, then the next
kexec'ed kernel will be able to find the original table?

I understand that the memattr region(s) need to be always (in each kexec
instances) `memblocked_reserved` to protect it from being used as a
System RAM, right?

Thus, if it is not passed throught e820, kexec'ed kernel needs to fetch
it again from original EFI table at kexec/boot time. 

This brings me another question.

If the kexec'ed kernel sees the original memory, why can't it
augment/update the RX permissions *again*, instead of passing the
previous augmented version from previous kernel in this crazy dance.

> This is a kexec problem (on x86 only) so let's fix it there.

Would you mind explaining what kexec needs to be done differently?
Should it preserve the augmented memattr table independently if it is
mapped in e820?

Thank you!
--breno


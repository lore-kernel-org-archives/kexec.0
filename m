Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C3DEB64DD
	for <kexec@archiver.kernel.org>; Sat,  5 Aug 2023 09:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2dvoo/7z8OjiuuYD8nzA5ILG8HYsEOxvZ7cbKSFi5yE=; b=v2pms8canjCnUt
	uAZEBt+0HnkMdBJTf7TH6SHdRL/RflHV/PaLLaqJUlezDuY7N0lqWdGclN/7hgJY0WcWBsHKXakm2
	sbuskZPcGTBIX/ee8IT2HIa3pnV5ma8l9L5B5qXEz8Y4HJJ4FnHHsc/936kc4n4cfpl+IQkh30DAy
	PcYVu0xofF7ONNXAWtaxmLkomU5QxNvcjH6AkmVJBu4x0qzmM3W54BfmZ0bcYUcqolCJeqmDYBMtz
	XXoqLlnm2FVzUB+6NUspWJI6CSz6+OI5csKj3xCaUcXxbykCalHxfkR6CKkFtUHPkJ0qPYcshwpCU
	7IU0yOk6VYrZ3LSSOVIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qSDQT-00Dskd-0l;
	Sat, 05 Aug 2023 09:18:21 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qSDQP-00Dsja-13
	for kexec@lists.infradead.org;
	Sat, 05 Aug 2023 09:18:19 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F35A640E01E6;
	Sat,  5 Aug 2023 09:18:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id F44GW5dpf85V; Sat,  5 Aug 2023 09:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1691227078; bh=AX17IsjWs1wvCdpan7Z6cB5tCZ+nkFjypGCrx0zZWWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DjmfrOdCMiReVXUtSgbKkcELpVKnElf2p6URQNv3oZgYrXnXsreH38hdp6EqaDTuh
	 dznglyyAoRGNBNd6Ic5wXuH6PaXe+4hgcFzXx0QWlds5Q7hh6aR6qG5sOVoL8w0JOw
	 B84gmm9uAryZ201SFIZalXgiTm843BQeb+5+KpOrP+wJYHLDpgnTFxv/V/WGb6mUIw
	 LC1EjJflSN4s1YMpeKJJB0L8QqnjzApeRtlbWqeEaQHmWbQn+QpivU0b7namA+qV0z
	 AkEpVjpYCrmRaxdTcHGzRsYI0A5Olyg34O5CXIi/K2++CMcGGT3KAyguNbFzOIXLV3
	 /Y3EP0KOy/NSKsdvKsDjT4HWUMY1ccz7gWcur0E79SgzbF+Qban4Vi8Gng1DsIFz+G
	 A/parmDJwv3zjjb2N1FlOdYPjDEIII9aB8XqGREPgN1xnN0QCNsJJ91jz5J1sqe4R5
	 pPzY6ZCd4AZ/w7r2C2x9HzKQzB5H/V0fwk9MGKo/tfmGzznFGuZI8j1J2Aw2AMG0+6
	 wQLOdT0hZq/g3akwzT546qPo49Jos4m15YnUnzItQfiFQbTZZvAepyXUfc8n/PzAz1
	 mIKUN4NTCHp73dr5//xQx3jgemf1op8+zPEoXlvBnK51PaNmeQA4P4sy7r4ftkpqIw
	 0D/sB6U9LxC4s5JFZlW1S/m0=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A5BD740E019D;
	Sat,  5 Aug 2023 09:17:43 +0000 (UTC)
Date: Sat, 5 Aug 2023 11:17:38 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
	Tom Lendacky <thomas.lendacky@amd.com>, Tao Liu <ltao@redhat.com>,
	Michael Roth <michael.roth@amd.com>, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, linux-kernel@vger.kernel.org, bhe@redhat.com,
	dyoung@redhat.com, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
Message-ID: <20230805091738.GAZM4TslVWR3HHKeUC@fat_crate.local>
References: <20230717141409.GGZLVMsU6d/9mpJvMO@fat_crate.local>
 <CAO7dBbXJv9JzDbSa-DLT03+osYCQXNUXFwz63gbq=NGDxEVyEA@mail.gmail.com>
 <20230728165535.GDZMPzB/ek5QM+xJqA@fat_crate.local>
 <CAO7dBbVyuLHH6RfdVQkU5ThXaJ-F4yvFAYD1PDNGkOpph9xvnA@mail.gmail.com>
 <20230802093927.GAZMokT57anC5jBISK@fat_crate.local>
 <99cb3813-1737-9d10-1f24-77565e460c55@amd.com>
 <20230802135856.GBZMphIHHLa3dXRRVe@fat_crate.local>
 <CAMj1kXEM5hGknVGwHh_w99D4L8yrYrTFycwGHZ0CQun70CLipw@mail.gmail.com>
 <20230802155146.GCZMp7ksDdN2ETVzKV@fat_crate.local>
 <CAMj1kXHnSzdQw5CMAVXU7EzpnrdRvAqKZVgA+EV35kHmwVULgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMj1kXHnSzdQw5CMAVXU7EzpnrdRvAqKZVgA+EV35kHmwVULgQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230805_021817_534105_4A316700 
X-CRM114-Status: GOOD (  17.18  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, Aug 03, 2023 at 01:11:54PM +0200, Ard Biesheuvel wrote:
> Sadly, not only 'old' grubs - GRUB mainline only recently added
> support for booting Linux/x86 via the EFI stub (because I wrote the
> code for them),

haha.

> but it will still fall back to the previous mode for kernels that are
> built without EFI stub support, or which are older than ~v5.8 (because
> their EFI stub does not implement the generic EFI initrd loading
> mechanism)

The thing is, those SNP kernels pretty much use the EFI boot mechanism.
I mean, don't take my word for it as I run SNP guests only from time to
time but that's what everyone uses AFAIK.

> Yeah. what seems to be saving our ass here is that startup_32 maps the
> first 1G of physical address space 4 times, and x86_64 EFI usually
> puts firmware tables below 4G. This means the cc blob check doesn't
> fault, but it may dereference bogus memory traversing the config table
> array looking for the cc blob GUID. However, the system table field
> holding the size of the array may also appear as bogus so this may
> still break in weird ways.

Oh fun.

> I don't think we can kill it yet, but it would be nice if we could
> avoid the need to support SNP boot when entering that way.

That's what I meant - not boot SNP guests through the 32-bit entry path.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

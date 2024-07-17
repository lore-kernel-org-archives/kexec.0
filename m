Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8388C3DA60
	for <kexec@archiver.kernel.org>; Wed, 17 Jul 2024 23:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ds8yiiovVYVbFehrYaLi42XNWAMdaDnf4aNbxQiTC9I=; b=M0yX4zpWGu6C5D
	KsQZygjw6EnRvaXBlN4zwthdYcosu1jtZDhp+Tfolh/VsSLy+NMgjuwSlfab0n0Q+b0lP2mp9fZJN
	NSE9Lm72mcXXAIRtfq5R0bQK4QoBY7rCpkcT/cxGfLY6GhPpUW52u19bKZOXwqNUkELJmHhEIOwth
	AQgHLI7DaWs0D/0OXHwuTxFhq24TcTuSSW5/ikoInX2/SESW190lCJuQCPBO7KR0/oiAnTPRwSMdv
	j6Nh+XhoTSIfoLeb4CqzC3NpAHpkl4Gp+iFibrm184KsaJ1kVn3lnL3OO2G1kU4sScxzBHpRghrTV
	7FzivctXuJbXBBn7Mfqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUDdZ-0000000FAWf-00Xz;
	Wed, 17 Jul 2024 23:00:41 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUCab-0000000F1wB-02ue
	for kexec@bombadil.infradead.org;
	Wed, 17 Jul 2024 21:53:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:Subject:Message-ID:
	Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Gwv4GLwX8rCMngg6ThUxnvDL4Iu5N+x3Ck3c3FmCpi4=; b=Ywj4e9cvp+86NZFfnkEUzBjyzY
	RhX4LsTm5P9XMCmwyKSqybGjlJ4n7IwuEpGrlFlU5VqHRPoLADr+CB+mjkY5LXGtGiJ0/HbytW/u3
	MbDEth4NUYJI/cfex3TAAy19pbWyF8/rilQV32vNrdDTD1kkRzjJUVu6hXcjbDTHnwCWAfIWTaDz7
	+TNofrRzMxOqTbLGUAdZXwGbuspb327eaWbrscyer+o8vEb6PPz4bV3/gmcEfgnLubjntfa/Mz3Wj
	PorlDbXac/Lv0nWVZ94IFrycRWVwYF4kTGXSjAuBImSz91sk2heeK8/9bZGrOIrkWkTL4XQwIeJxa
	PgMTtwTA==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUCaX-00000002PlF-1zIK
	for kexec@lists.infradead.org;
	Wed, 17 Jul 2024 21:53:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7477361975
	for <kexec@lists.infradead.org>; Wed, 17 Jul 2024 21:53:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D5EC4AF1A
	for <kexec@lists.infradead.org>; Wed, 17 Jul 2024 21:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721253204;
	bh=2hNKo4PRlRL5HpgATzZ4TV0W6nttMnM5e0eF+5Mjub0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AnPX+U9c48j4O8UxGmxwQ0NrNzpMU+YP8PL8yLystZQLYQOOX0lcLezJB2hX300zT
	 fcx1FaWwSaZc6pBsAs1p4/GJDztsgmWvSqohxbnkINB/bWV12WeUINHgRaqQxWaq7P
	 l4y7SIxldsYUU9YCM4hoiVEBAUzp3Jm0Mk0IjNzzPBbtQ5UeQUwudCmrvdKLO0oYcO
	 HHTUWVaPXh18rdymSaWnXJEwnG7J1Vm60MldsOriyf/TRLhZdAYLjOkZ07d5iZtZPa
	 jtJVRv87NA05+y/2uGjhB7Kxji4l2ujQ+vrlTBv4xJR4e4WqO+1V4Q8X7t5M9zq7v0
	 0vudlyMAI45ag==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eecd2c6432so2931501fa.3
        for <kexec@lists.infradead.org>; Wed, 17 Jul 2024 14:53:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUMGnmOnxLpn+q3xMp87bu5P3TMTStpZO9G9Ds+GKUxCj9KvMfkQNBmtfbbU2EO1rBvBqAVrq+bZIsAp4QsbRoFsYQQMiBMD43f
X-Gm-Message-State: AOJu0YxEd1GnBj3cya/s6cMiY1fnrSkKcy8CYZklLG013DZlV07WtKEr
	ADm1JI4Y3Td82sPGZa+viiaPcMf5ERS9VFD4L77g8zlD5KMTyC2gp2Wn91y1s9S4AG1RQ+BF52P
	YBTH7g7ohfhz16u7lsyPDhN1ccII=
X-Google-Smtp-Source: AGHT+IHQA5REQfR6PJuDJ5WJHovXh5yxPkwShu/QgAgI8DmO7TG1mfxo+DDoQQvj4nWpnCxV2bSVNwiXncM9U1sfLSs=
X-Received: by 2002:a2e:b60c:0:b0:2ee:52f4:266 with SMTP id
 38308e7fff4ca-2ef05c53bd9mr5245661fa.3.1721253202794; Wed, 17 Jul 2024
 14:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240717213121.3064030-1-steve.wahl@hpe.com> <20240717213121.3064030-2-steve.wahl@hpe.com>
In-Reply-To: <20240717213121.3064030-2-steve.wahl@hpe.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 17 Jul 2024 14:53:11 -0700
X-Gmail-Original-Message-ID: <CAMj1kXEgvORTj3FT54Dq39d-tQLXDdmEPEVc=x6H8Schmdu6fg@mail.gmail.com>
Message-ID: <CAMj1kXEgvORTj3FT54Dq39d-tQLXDdmEPEVc=x6H8Schmdu6fg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] x86/kexec: Add EFI config table identity mapping
 for kexec kernel
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	Pavin Joseph <me@pavinjoseph.com>, Eric Hagberg <ehagberg@gmail.com>, 
	Simon Horman <horms@verge.net.au>, Eric Biederman <ebiederm@xmission.com>, 
	Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>, Russ Anderson <rja@hpe.com>, 
	Dimitri Sivanich <sivanich@hpe.com>, Hou Wenlong <houwenlong.hwl@antgroup.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Yuntao Wang <ytcoode@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <jroedel@suse.de>, 
	Michael Roth <michael.roth@amd.com>, Tao Liu <ltao@redhat.com>, kexec@lists.infradead.org, 
	"Kalra, Ashish" <ashish.kalra@amd.com>, linux-efi@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_225329_874953_D365CEA8 
X-CRM114-Status: GOOD (  26.40  )
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

On Wed, 17 Jul 2024 at 14:32, Steve Wahl <steve.wahl@hpe.com> wrote:
>
> From: Tao Liu <ltao@redhat.com>
>
> A kexec kernel boot failure is sometimes observed on AMD CPUs due to
> an unmapped EFI config table array.  This can be seen when "nogbpages"
> is on the kernel command line, and has been observed as a full BIOS
> reboot rather than a successful kexec.
>
> This was also the cause of reported regressions attributed to Commit
> 7143c5f4cf20 ("x86/mm/ident_map: Use gbpages only where full GB page
> should be mapped.") which was subsequently reverted.
>
> To avoid this page fault, explicitly include the EFI config table
> array in the kexec identity map.
>
> Further explanation:
>
> The following 2 commits caused the EFI config table array to be
> accessed when enabling sev at kernel startup.
>
>     commit ec1c66af3a30 ("x86/compressed/64: Detect/setup SEV/SME features
>                           earlier during boot")
>     commit c01fce9cef84 ("x86/compressed: Add SEV-SNP feature
>                           detection/setup")
>
> This is in the code that examines whether SEV should be enabled or
> not, so it can even affect systems that are not SEV capable.
>
> This may result in a page fault if the EFI config table array's
> address is unmapped. Since the page fault occurs before the new kernel
> establishes its own identity map and page fault routines, it is
> unrecoverable and kexec fails.
>
> Most often, this problem is not seen because the EFI config table
> array gets included in the map by the luck of being placed at a memory
> address close enough to other memory areas that *are* included in the
> map created by kexec.
>
> Both the "nogbpages" command line option and the "use gpbages only
> where full GB page should be mapped" patch greatly reduce the chance
> of being included in the map by luck, which is why the problem
> appears.
>
> Signed-off-by: Tao Liu <ltao@redhat.com>
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> Tested-by: Pavin Joseph <me@pavinjoseph.com>
> Tested-by: Sarah Brofeldt <srhb@dbc.dk>
> Tested-by: Eric Hagberg <ehagberg@gmail.com>
> ---
>
> Version 3: Do not rename map_efi_systab to map_efi_tables, and don't add
> 'config table' to the comments, per Ard Biesheuvel request.
>
>  arch/x86/kernel/machine_kexec_64.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBF0E9A02D
	for <kexec@archiver.kernel.org>; Tue, 17 Feb 2026 18:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RULzBjhtFXzekE/KOE5jHSRwoGRzGNZUVeSpUqKf7bw=; b=tSHjMJYTiQzTiiq08UtyJGUk5P
	Q/3R9x71UMxJSjj3/L+6XJ+nmRzijeLLebK7S1UeVsukjjjaDbCFifNJwOQEJ6bAyE/o6kVJL/ON/
	gxFe+k2I5dAHyJA0pgYS5qHhiO6c9LuQzSzx0JuWx7u0wvKOncV26Xo9IgarbVQMlpPz9/8/yUrBq
	TNalk5rU0MEmvDELg3a1cTOlyU5vHO1k88Bnkli3O4n9bqv93Vyecrz00A3XVQjNTkBudZ9/rGXvZ
	AOO/t6xZG5zf14gdQD98celMIXK5AMqlM2ZcVWnJkFyrQpW6f7QzgOvXL/0PTV+5WKQX0fSeApCFh
	kurzrZZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsPbN-00000008hSu-2k9X;
	Tue, 17 Feb 2026 18:15:13 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsPbK-00000008hSH-2O34
	for kexec@lists.infradead.org;
	Tue, 17 Feb 2026 18:15:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E9F0543958;
	Tue, 17 Feb 2026 18:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADC8C4CEF7;
	Tue, 17 Feb 2026 18:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771352109;
	bh=BLXPqjtq+IcP0wOW8zJwe5S6I6ouY4pZ9WPNbvh+gvU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ncWZszqUcCkso6eRJYjQF4ykYjd2dea6lzevm+OKxN/OqDdZA5XE83oajZf32yKla
	 3XmIb1zmHUy/HfBNKLxaJZJWKK/cCbtvEpV7MBKMaS1BdIhe6ATBnp09IrVI6BhJZ+
	 +KCCdSyGZRESVQJLrkF8trL7MW89/fPZTvfLI3lN32Z4wys+icRuL4zcxyq9FmMq2o
	 EHKvljejqccnUXKOTe5aYwWzK8v64Iu3kuqMctxAb6LkIRE6t2oZp3dFH/Q08WlWsB
	 DPBPONeSEI5HXzxpf9YHRFEW7ccVYItvGWInw0fEPU5FPkivyyrrsWFeAdPuCdXJnp
	 RcY0a2rWV2xVA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 98AC3F4006E;
	Tue, 17 Feb 2026 13:15:08 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Tue, 17 Feb 2026 13:15:08 -0500
X-ME-Sender: <xms:LLCUaWO0rWTliOLGuI9AMINm3T5W3Dv4sOqbH0wB9M5inx2OQ8cm4A>
    <xme:LLCUafyT2e7ibOvwXbOGRYv8COaM01fgTVvDrYVQHmBjtm8iLEnCR6-19LrbdLVF8
    ToY9IuOZiF4kBWZDGE658AffueZSSTYJQE0m5JtFlffQt0BGutdOsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
    jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvgigvggtsehlihhsth
    hsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepugihohhunhhgsehrvgguhhgr
    thdrtghomhdprhgtphhtthhopehlihhnuhigqdgvfhhisehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:LLCUaejlUfQxTF9zgHLVwIgZa1YuhRj8LZCgfofr-iOhHyo2rvthSw>
    <xmx:LLCUaSuVvrSv5TMGfY3SJyzEvahKwYyx2I8-2wKDD2F7TeOFhpoQjA>
    <xmx:LLCUaf5_kUWv32vvj-7c_8EVKoVdkwrYluaW7_RdE7HXkBgAOLkkHg>
    <xmx:LLCUaeMiB34u-Xo0fCnfI_nUnPxpVhJYYqIDX9D-HQ5HXBB1_rkqBQ>
    <xmx:LLCUadubG3xD5kKpPRlH0z0HDYGGKBFXJubOapg-bntLNgS7RDg15_8i>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 71014700069; Tue, 17 Feb 2026 13:15:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AR4vd3DIDa3F
Date: Tue, 17 Feb 2026 19:14:48 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Dave Young" <dyoung@redhat.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, x86@kernel.org
Message-Id: <eba774b8-1127-4c77-99fc-943b6de8af54@app.fastmail.com>
In-Reply-To: <CALu+AoQMdng7QfKJjY1wugLu79AWbg0=x9SkvvT6TdwXjviM3A@mail.gmail.com>
References: <aZQg_tRQmdKNadCg@darkstar.users.ipa.redhat.com>
 <824bf9d5-93d3-4791-a064-3852014a1264@app.fastmail.com>
 <CALu+AoRdo5E-irxymu7WAV+L=sKLbjnOXtLLe7RHWX-NZtjvNw@mail.gmail.com>
 <61f0c9ad-a435-4856-8ebe-d5a81f72330e@app.fastmail.com>
 <CALu+AoTkGWXAokzXwo6C+6K1-mk3r9YA=WauXAggP628F_=ABQ@mail.gmail.com>
 <665dc599-8488-4761-b3c3-07b994cb82b8@app.fastmail.com>
 <CALu+AoQMdng7QfKJjY1wugLu79AWbg0=x9SkvvT6TdwXjviM3A@mail.gmail.com>
Subject: Re: [PATCH] efi/x86-stub: store acpi_rsdp_addr in bootparams
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260217_101510_676001_8362C7F4 
X-CRM114-Status: GOOD (  29.22  )
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

On Tue, 17 Feb 2026, at 11:29, Dave Young wrote:
> On Tue, 17 Feb 2026 at 18:27, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>>
>>
>> On Tue, 17 Feb 2026, at 11:01, Dave Young wrote:
>> > On Tue, 17 Feb 2026 at 17:20, Ard Biesheuvel <ardb@kernel.org> wrote:
>> >>
>> >>
>> >> On Tue, 17 Feb 2026, at 09:19, Dave Young wrote:
>> >> > Hi Ard,
>> >> >
>> >> > On Tue, 17 Feb 2026 at 16:10, Ard Biesheuvel <ardb@kernel.org> wrote:
>> >> >>
>> >> >> Hi Dave,
>> >> >>
>> >> >> On Tue, 17 Feb 2026, at 09:04, Dave Young wrote:
>> >> >> > Kernel panic occurs during a kexec reboot when EFI runtime services
>> >> >> > are not enabled in the first kernel. The issue is that the second
>> >> >> > kernel cannot find the ACPI RSDP address during boot.
>> >> >> >
>> >> >> > In legacy boot, the acpi_rsdp_addr is set in early x86 boot code.
>> >> >> > However, kernel decompression has moved to the EFI stub for EFI boot.
>> >> >> > Therefore, the x86 EFI stub must also be updated to store the
>> >> >> > acpi_rsdp_addr in the boot parameters to ensure the kexec kernel
>> >> >> > can find it.
>> >> >> >
>> >> >> > (Note: If the pre-kexec kernel was itself a kexec boot, the later kexec
>> >> >> > reboot will still utilize the legacy decompressor path, so the original
>> >> >> > code remains functional though some cleanups can be done later.)
>> >> >> >
>> >> >> > Signed-off-by: Dave Young <dyoung@redhat.com>
>> >> >> > ---
>> >> >> >  drivers/firmware/efi/libstub/x86-stub.c |   18 ++++++++++++++++++
>> >> >> >  1 file changed, 18 insertions(+)
>> >> >> >
>> >> >>
>> >> >> If this issue is kexec-specific, can we move this to where the kexec code prepares the boot_params struct for the next kernel?
>> >> >>
>> >> >
>> >> > The kexec use case is it depends on the pre-kexec kernel saving it
>> >> > during boot for noefi case.  I do not have a better idea to do it in
>> >> > kexec code for the time being.
>> >>
>> >> How about something like this?
>> >
>> > Thanks!  It works for me, however the legacy kexec_load syscall still
>> > failed with a panic I did not dig into the root cause yet, I supposed
>> > it will find the rsdp from /sys/firmware/efi/systab file, maybe some
>> > userspace code bug.
>> >
>> > Anyway I'm fine with this fix,  would you like to send a formal patch
>> > since you proposed it?  Otherwise I will resend with the changes.
>> >
>>
>> Excellent. I'll queue it with a link to this thread.
>>
>
> Thanks a lot!
>

Actually, looking at that code more closely, I kind of wonder why the kexec code tests for EFI_RUNTIME_SERVICES to begin with. Perhaps it might be sufficient to do this:

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index c3244ac680d1..bec91ee7e668 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -192,7 +192,7 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
        struct efi_info *current_ei = &boot_params.efi_info;
        struct efi_info *ei = &params->efi_info;
 
-       if (!efi_enabled(EFI_RUNTIME_SERVICES))
+       if (!efi_enabled(EFI_MEMMAP))
                return 0;
 
        if (!current_ei->efi_memmap_size)

That way, if the first kernel was booted via EFI but without runtime services enabled, the kexec'ed kernel will simply inherit the ACPI and EFI tables.



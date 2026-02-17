Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB8DE68149
	for <kexec@archiver.kernel.org>; Tue, 17 Feb 2026 09:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iDQnkQTyseFK1aCyvDCk7enLEzozWQLe9QTnHrjRVrQ=; b=ps96wdZ6KHWetEFpeRKUGjW48v
	kisJJ+0SMEm5g74QvxXjnY8pXJ8XbRnoEnnHt5HwFZcQe1Rg4bTRaNEubL14gdildsDtfT5Nk1K2h
	KrSBx+43YysfQUeWiqL2iy7gTu3dD/S8qMVMtsvWOxE1GpUbxaTOZNk9MuP4VMkX3+iFJZUz0qEA1
	wVzUACRAQgw5mNyovytChtQbctu2bhfi/LI5wgZQUgsghsB50uHXBNUp56TSvFZvbCODEmPwA+PUx
	ru05s/XrEs7vs7TH9hY5L4S4zmJj0lLJb+48skKuk6oy5osKtrgl7t7UNC7wgdAezRQNTsH8Cmnhy
	4P0UkSYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsHG3-00000007vuB-3uwG;
	Tue, 17 Feb 2026 09:20:39 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsHFx-00000007vtn-2xfQ
	for kexec@lists.infradead.org;
	Tue, 17 Feb 2026 09:20:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6781C40990
	for <kexec@lists.infradead.org>; Tue, 17 Feb 2026 09:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDD4C4AF0B;
	Tue, 17 Feb 2026 09:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771320032;
	bh=m77q98Ca7HhJMMoYJsCKLdXVsY8u/UjfHANHKEYGBjU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=CGGBNNBXOLJ/IKmOnYGdIg8cu7qzhe4CMaZhSxS/SxMomha10+xE4y0jb3bYbfv2l
	 nGRaKps4sGbyEJPmn0r7HekV7HPyFh1Zq2mklLVp9mgfiy5NV6BcLSNEmDRRqIc8y6
	 CPbNh3O1Un4BnE/63VfO4CPJIJ+incMK+7onmrE52aFMSjwp7/owD1EDqPHH5C4PuD
	 N0vKzuxa+2Vte/vMZ8zvJCvZCNVPeclBYMXCbtvSIPLWF51Si0Jzs66CUjWht2H1tX
	 vXQDMlYoPuasEUwMnjPBi3PgJzx1OgaMMkSw2BU1KSQTvHQfaURRJMyI6qJ5EDFZMV
	 KU6GzegdNlN1w==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id F2FFEF40068;
	Tue, 17 Feb 2026 04:20:30 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Tue, 17 Feb 2026 04:20:30 -0500
X-ME-Sender: <xms:3jKUad5AQwpLcRsTwGFcrZgfAB3xGuLPCAYJ38BnfwJUYdTt3r9cQg>
    <xme:3jKUaVvmIPeTUGkoOFQgIrgqytBg8xfoKvS7Eb8rOhu7hZILlXRaQOs5Z5lv7rY_P
    F82jZ2sX3ItCDaUhDx4Cu6v9Ordx-OnaiE2e2mccys4aupyzvVZMJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudelfeekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:3jKUaQvUYrq89aP4BKjBFrAiE7TfsQ1wuUQgfS0tCurxZTEcwhknXw>
    <xmx:3jKUaRJsKyIrAaOfbfvzMihfbUEBmIVLRowyizn6gunz7MCoHXhtXg>
    <xmx:3jKUaVmK8BRDZRY3hO0bvz8rBNR9b8gN2eNQ4u60cLwDwRedi3YPIQ>
    <xmx:3jKUaaJNsKJwhuC2rKvHpYDkjruqZBrrmcTk_OhyWzHd14r5uJflSw>
    <xmx:3jKUaS5pnh6OAnFuIWQ2oCfUyzeUAKjrWcchWiJ84dmNJwVMdEdyHymL>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CBDA6700065; Tue, 17 Feb 2026 04:20:30 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AR4vd3DIDa3F
Date: Tue, 17 Feb 2026 10:20:10 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Dave Young" <dyoung@redhat.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, x86@kernel.org
Message-Id: <61f0c9ad-a435-4856-8ebe-d5a81f72330e@app.fastmail.com>
In-Reply-To: <CALu+AoRdo5E-irxymu7WAV+L=sKLbjnOXtLLe7RHWX-NZtjvNw@mail.gmail.com>
References: <aZQg_tRQmdKNadCg@darkstar.users.ipa.redhat.com>
 <824bf9d5-93d3-4791-a064-3852014a1264@app.fastmail.com>
 <CALu+AoRdo5E-irxymu7WAV+L=sKLbjnOXtLLe7RHWX-NZtjvNw@mail.gmail.com>
Subject: Re: [PATCH] efi/x86-stub: store acpi_rsdp_addr in bootparams
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260217_012033_791787_702D91E9 
X-CRM114-Status: GOOD (  25.17  )
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


On Tue, 17 Feb 2026, at 09:19, Dave Young wrote:
> Hi Ard,
>
> On Tue, 17 Feb 2026 at 16:10, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> Hi Dave,
>>
>> On Tue, 17 Feb 2026, at 09:04, Dave Young wrote:
>> > Kernel panic occurs during a kexec reboot when EFI runtime services
>> > are not enabled in the first kernel. The issue is that the second
>> > kernel cannot find the ACPI RSDP address during boot.
>> >
>> > In legacy boot, the acpi_rsdp_addr is set in early x86 boot code.
>> > However, kernel decompression has moved to the EFI stub for EFI boot.
>> > Therefore, the x86 EFI stub must also be updated to store the
>> > acpi_rsdp_addr in the boot parameters to ensure the kexec kernel
>> > can find it.
>> >
>> > (Note: If the pre-kexec kernel was itself a kexec boot, the later kexec
>> > reboot will still utilize the legacy decompressor path, so the original
>> > code remains functional though some cleanups can be done later.)
>> >
>> > Signed-off-by: Dave Young <dyoung@redhat.com>
>> > ---
>> >  drivers/firmware/efi/libstub/x86-stub.c |   18 ++++++++++++++++++
>> >  1 file changed, 18 insertions(+)
>> >
>>
>> If this issue is kexec-specific, can we move this to where the kexec code prepares the boot_params struct for the next kernel?
>>
>
> The kexec use case is it depends on the pre-kexec kernel saving it
> during boot for noefi case.  I do not have a better idea to do it in
> kexec code for the time being.

How about something like this?

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 7508d0ccc740..24aec7c1153f 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -313,6 +313,12 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 
        /* Always fill in RSDP: it is either 0 or a valid value */
        params->acpi_rsdp_addr = boot_params.acpi_rsdp_addr;
+       if (IS_ENABLED(CONFIG_EFI) && !params->acpi_rsdp_addr) {
+               if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
+                       params->acpi_rsdp_addr = efi.acpi20;
+               else if (efi.acpi != EFI_INVALID_TABLE_ADDR)
+                       params->acpi_rsdp_addr = efi.acpi;
+       }
 
        /* Default APM info */
        memset(&params->apm_bios_info, 0, sizeof(params->apm_bios_info));


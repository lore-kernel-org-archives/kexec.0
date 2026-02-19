Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D1CE9A03B
	for <kexec@archiver.kernel.org>; Thu, 19 Feb 2026 07:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b+7AVyO2qz7ZD1SSrPXWqWMMnOffhY8qE+P2GQebjVg=; b=i3cOhSrrhFoyh0JqaClvhpuns5
	goatOHXAt70O+L0rWmBD8SD/ifFGDUsOBjZ+p5+7ouXMoxVXunnhfRC9kXAfmy1iTjvweTwkBN4ZF
	6l7V0LSzoYbvBE5EmYCF4TUzprxBN3+dO9yNTdEmIdGWK3F+baE56UGbfFW5Dd+hllT9y2ich3sMl
	fTrvzteZq9df6DG0J6OjMcX3EtqVDHDTF2dJXIPFfkybxVXCMfUYSipwFez94SVlZbyNfXD8i+iCz
	czuiJNdX3rn2KyLHaAdrJ73o+dTlPkN++YK027uhSiou0meZahTKP7sZZI22OVWOFpXXAlWEeSK9U
	5ZVdpW3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsyMG-0000000B2F1-0JGI;
	Thu, 19 Feb 2026 07:21:56 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsyME-0000000B2Eu-2guJ
	for kexec@lists.infradead.org;
	Thu, 19 Feb 2026 07:21:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BBD2760128
	for <kexec@lists.infradead.org>; Thu, 19 Feb 2026 07:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B4CC4CEF7;
	Thu, 19 Feb 2026 07:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771485713;
	bh=Ou7ySdIQWXiWriFhR45WVSxPkt1Uy+MKznyhuxQi4Xw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=J026NxZ/M+/EY78DJPC9oteKnlkywHGpZhT671e9QNUAp+tvHhYlMs/pbboHp0bCO
	 +ReP64FhPe8tCYDftBv8x8Y9+jFp+OqkUo+GCRpZQs5V6X3E0AXchT3AZH19eq9w2i
	 enPwafPewNppXqONfa8nMQufAEErHKDK1z0bO2tHWT6JSUKaSmNiz++UUdfEY5Iv3a
	 0b9XYtMm9pyQjsGjjk2DwdzoHXWDdTX599GeRCn7cZ/wJxvVpCzvg2O1+YZfnHn1j7
	 MeMswB3HHYO07dOLVl5tX9Dj6mfjsv+XSj3yAsryloUkLilFcJ4Sqel1lJmupNKVhN
	 ZqMfVs4dtI4TA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 05773F40068;
	Thu, 19 Feb 2026 02:21:52 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Thu, 19 Feb 2026 02:21:52 -0500
X-ME-Sender: <xms:D7qWaX21y9gFPaTmzqLWzTBoS5nCiy5xv_Wvk0l18hxhGySOTb97dA>
    <xme:D7qWaQ5oleQVyebjta6lLkSnTDtYURScr2l56z6_Ngl3Xqe_NE5BHBhkxO4LHi1_X
    lYh2avwdAEY1CXT9E2IhDZgcr-3LC30rPjiTaftqXbYcRYCssNqog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdegleduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:D7qWaTLbTuz0Dj6d9-BPmauH-eFSmR_KWwjL4gX7KPlqLbd_USPo5g>
    <xmx:D7qWaa2BC9zcxDj6xG4pKJ8H6y-UFSU0BhAHguxzrK3sW5QQy7osKQ>
    <xmx:D7qWaVj_puEdjRoz81T4WT6rKcPrmqSG98WXWnSW9YHzRqkcaOUXpg>
    <xmx:D7qWaTU4kbZS-TLjxxZdSR9ZO4Vi6dbkZQR3bR1dEdDIz86bm9Y1tA>
    <xmx:D7qWacVbpmH-UPF7gWUu5xNm29cDs-Z3XyF4JmL3pBygEA85i0oQCCw7>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CB2AF700065; Thu, 19 Feb 2026 02:21:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AR4vd3DIDa3F
Date: Thu, 19 Feb 2026 08:21:30 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Dave Young" <dyoung@redhat.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, x86@kernel.org
Message-Id: <7c10262c-b320-4e80-b92b-107b693a928f@app.fastmail.com>
In-Reply-To: <CALu+AoRdx_=FFkFUcfwc8Z_7qmMbyC6Yf5AJA6PpTyDcjBS2Hw@mail.gmail.com>
References: <aZQg_tRQmdKNadCg@darkstar.users.ipa.redhat.com>
 <824bf9d5-93d3-4791-a064-3852014a1264@app.fastmail.com>
 <CALu+AoRdo5E-irxymu7WAV+L=sKLbjnOXtLLe7RHWX-NZtjvNw@mail.gmail.com>
 <61f0c9ad-a435-4856-8ebe-d5a81f72330e@app.fastmail.com>
 <CALu+AoTkGWXAokzXwo6C+6K1-mk3r9YA=WauXAggP628F_=ABQ@mail.gmail.com>
 <665dc599-8488-4761-b3c3-07b994cb82b8@app.fastmail.com>
 <CALu+AoQMdng7QfKJjY1wugLu79AWbg0=x9SkvvT6TdwXjviM3A@mail.gmail.com>
 <eba774b8-1127-4c77-99fc-943b6de8af54@app.fastmail.com>
 <CALu+AoRdx_=FFkFUcfwc8Z_7qmMbyC6Yf5AJA6PpTyDcjBS2Hw@mail.gmail.com>
Subject: Re: [PATCH] efi/x86-stub: store acpi_rsdp_addr in bootparams
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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


On Thu, 19 Feb 2026, at 07:57, Dave Young wrote:
> Hi Ard,
>
>> Actually, looking at that code more closely, I kind of wonder why the kexec code tests for EFI_RUNTIME_SERVICES to begin with. Perhaps it might be sufficient to do this:
>>
>> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
>> index c3244ac680d1..bec91ee7e668 100644
>> --- a/arch/x86/kernel/kexec-bzimage64.c
>> +++ b/arch/x86/kernel/kexec-bzimage64.c
>> @@ -192,7 +192,7 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
>>         struct efi_info *current_ei = &boot_params.efi_info;
>>         struct efi_info *ei = &params->efi_info;
>>
>> -       if (!efi_enabled(EFI_RUNTIME_SERVICES))
>> +       if (!efi_enabled(EFI_MEMMAP))
>>                 return 0;
>>
>>         if (!current_ei->efi_memmap_size)
>>
>> That way, if the first kernel was booted via EFI but without runtime services enabled, the kexec'ed kernel will simply inherit the ACPI and EFI tables.
>
> Actually it does not work,  EFI_MEMMAP is unset in function
> efi_memmap_unmap() when runtime is disabled,  so nodifference for
> checking EFI_MEMMAP or EFI_RUNTIME_SERVICES bits.
>
> The x86 kexec efi code is simply written to assume EFI runtime is
> enabled as it copies the cooked runtime service mem ranges in memmap.
>  If we want to improve it I suspect the efi initialization code could
> need changes, and then even if first kernel disabled runtime, the
> kexec 2nd kernel still have chance to enter virtual mode to enable
> runtime.    But this does requires more work to be done.
>

Yeah, fixing that seems a bit risky, and not really worth the reward.



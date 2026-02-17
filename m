Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A639E68168
	for <kexec@archiver.kernel.org>; Tue, 17 Feb 2026 10:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sNqqlW1WZJRsQUWDCkcLpm7zErRUKAS7zLh6SP50S8c=; b=avsV677aYNGUA88JGmaHOeITdU
	slHwqyn5qaQe3g3wiKQjiWwz8WZPTLAJn0u20lw8fNDA1fyFfVjEQbdS1mJsrUAQXeQUnn2YoJDvQ
	gdDyKqLzjnFYhXNYLvytqISjT9hyrYG+R5ImyUU1btrtJT3wWuS4vYlwfYrWqrmf1OPo9H1s9hqjm
	W9R8CG5n9xVCRpQVFGNdWsrNzAshHXnvvCUT/7kz2CFbVxmCKOnSpYYKJmMEPe/ZqNGniy7YN2gQX
	46O7YKK+/sjR7pJ6mukyiyKjKYykkdJ525VVjmLI5hpFyOYrCrwrVvGZJH8SSWmWfDjlKWxuOQGCV
	ezJfb/9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsIIW-000000081jg-1Utj;
	Tue, 17 Feb 2026 10:27:16 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsIIT-000000081jC-2Pp3
	for kexec@lists.infradead.org;
	Tue, 17 Feb 2026 10:27:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C96B843E85
	for <kexec@lists.infradead.org>; Tue, 17 Feb 2026 10:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD4BC19423;
	Tue, 17 Feb 2026 10:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771324032;
	bh=A1RZeYH6sHmVQh3ml2jbUXSijJJc+yhNtIXFCMMdagk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=kGTZyWK9NxTBeFN83u6JR8u46jSt/HGQRh8X8Wc1W8Jdg2KABSt1+TzNn0aI5SpMH
	 YC6g6hC4pTUUh4iO7d0BWe6EU/6CD9gDrn/2cZbLXf9GD8C96WlkSZtyB9+Uj5lXDQ
	 2zI4nabQR1mYSnd7wNFL0P29KPd/+tTv3k0IpPbcvlXYLz5+LNdJqzEH9/7LllfE/q
	 kWDNnGBAbxkLC2Svs2CTIjvKWjL/GKEKvbflW65uivF0+22E7p8h4n1OTcpYvmWsRo
	 ngviNI4I7oTvLeOJgPXIgmRnGFEnlxjIuHmfvVHc8OKXfsOKwXF1AZ89Ey+5j0aEsg
	 JgIHauhOptjdw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 574D6F40069;
	Tue, 17 Feb 2026 05:27:11 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Tue, 17 Feb 2026 05:27:11 -0500
X-ME-Sender: <xms:f0KUafmP-W0tWKNjtMHllwpq6l4o81zaMJZFjcNebcAVCO-EpAuQ7g>
    <xme:f0KUadrWto3QOLEthKf1rWjt29SJdatJSw9P8UQ-UJSD2esZmb-hoOe-VFQuI9Xlf
    nckXZ7IHAnnrO90izWyoQOQH3PPVKVA-yRAopbWKakBUQJ5TnR_zBE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudelhedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:f0KUac6_bu1irJOhkeuPf2MVEBvFMvF3dI7AXJJMWh2UeH7BIVZfPw>
    <xmx:f0KUaRkA1AVSX625YG9KqAx_e_IUfJHQXnPm4KyEW7Shthn1f82Cag>
    <xmx:f0KUaVTbKQHfhODebLnPjN9Mu3aVWvG-VlObfXpGfrJiuX2YBhWFAg>
    <xmx:f0KUaYFKPQcnu_fgHH30m8xE3dKdqBpIgI1XpVR7NASXTYPLuD5z-g>
    <xmx:f0KUaSFuahm6Waz9LKrgjPFmltNZEhvw2K78uP5inOA8rFZiT1CKSFtG>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1D43C700065; Tue, 17 Feb 2026 05:27:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AR4vd3DIDa3F
Date: Tue, 17 Feb 2026 11:26:50 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Dave Young" <dyoung@redhat.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, x86@kernel.org
Message-Id: <665dc599-8488-4761-b3c3-07b994cb82b8@app.fastmail.com>
In-Reply-To: <CALu+AoTkGWXAokzXwo6C+6K1-mk3r9YA=WauXAggP628F_=ABQ@mail.gmail.com>
References: <aZQg_tRQmdKNadCg@darkstar.users.ipa.redhat.com>
 <824bf9d5-93d3-4791-a064-3852014a1264@app.fastmail.com>
 <CALu+AoRdo5E-irxymu7WAV+L=sKLbjnOXtLLe7RHWX-NZtjvNw@mail.gmail.com>
 <61f0c9ad-a435-4856-8ebe-d5a81f72330e@app.fastmail.com>
 <CALu+AoTkGWXAokzXwo6C+6K1-mk3r9YA=WauXAggP628F_=ABQ@mail.gmail.com>
Subject: Re: [PATCH] efi/x86-stub: store acpi_rsdp_addr in bootparams
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260217_022713_683957_46049014 
X-CRM114-Status: GOOD (  24.46  )
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



On Tue, 17 Feb 2026, at 11:01, Dave Young wrote:
> On Tue, 17 Feb 2026 at 17:20, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>>
>> On Tue, 17 Feb 2026, at 09:19, Dave Young wrote:
>> > Hi Ard,
>> >
>> > On Tue, 17 Feb 2026 at 16:10, Ard Biesheuvel <ardb@kernel.org> wrote:
>> >>
>> >> Hi Dave,
>> >>
>> >> On Tue, 17 Feb 2026, at 09:04, Dave Young wrote:
>> >> > Kernel panic occurs during a kexec reboot when EFI runtime services
>> >> > are not enabled in the first kernel. The issue is that the second
>> >> > kernel cannot find the ACPI RSDP address during boot.
>> >> >
>> >> > In legacy boot, the acpi_rsdp_addr is set in early x86 boot code.
>> >> > However, kernel decompression has moved to the EFI stub for EFI boot.
>> >> > Therefore, the x86 EFI stub must also be updated to store the
>> >> > acpi_rsdp_addr in the boot parameters to ensure the kexec kernel
>> >> > can find it.
>> >> >
>> >> > (Note: If the pre-kexec kernel was itself a kexec boot, the later kexec
>> >> > reboot will still utilize the legacy decompressor path, so the original
>> >> > code remains functional though some cleanups can be done later.)
>> >> >
>> >> > Signed-off-by: Dave Young <dyoung@redhat.com>
>> >> > ---
>> >> >  drivers/firmware/efi/libstub/x86-stub.c |   18 ++++++++++++++++++
>> >> >  1 file changed, 18 insertions(+)
>> >> >
>> >>
>> >> If this issue is kexec-specific, can we move this to where the kexec code prepares the boot_params struct for the next kernel?
>> >>
>> >
>> > The kexec use case is it depends on the pre-kexec kernel saving it
>> > during boot for noefi case.  I do not have a better idea to do it in
>> > kexec code for the time being.
>>
>> How about something like this?
>
> Thanks!  It works for me, however the legacy kexec_load syscall still
> failed with a panic I did not dig into the root cause yet, I supposed
> it will find the rsdp from /sys/firmware/efi/systab file, maybe some
> userspace code bug.
>
> Anyway I'm fine with this fix,  would you like to send a formal patch
> since you proposed it?  Otherwise I will resend with the changes.
>

Excellent. I'll queue it with a link to this thread.


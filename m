Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACD0C433FE
	for <kexec@archiver.kernel.org>; Sat,  5 Nov 2022 14:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-ID:References:In-Reply-To:Subject:Cc:To:From
	:Date:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o8sFYUA07hTW39KblDwShkzg7VAfYRqW/4JKLjQJWiI=; b=PC7Rg7XDWW6luq2HxmjM7vaTuB
	xhPodu6kol1KheomuAavzwO7ncePgkc4GEARpCQ3fKenfsI99cifAz5qPNLaNzvY3JJgmmHhANfCC
	CYIJo93NC7gqr8hrd3LQsZ0FcwGxdNbnHS7U0NU9a/sEarcEkhqr34gvkauEv1YNm0EqwpZhlAHdU
	oFo06XfketY4lx9HXqgkiW/i0szmeKGye1edVvqoWwWhPiK1pmUDQHfFfPpfqjErjU7FjG0Xmmykn
	0hJz6ajyLKLAMkvyTVEt1I6pT5GQmd78Rzfmn4gIOKt7VU4thsj7ReCW0fHVvIptoPrc7ZIqfxgvM
	lheL3XgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1orK0b-006g4O-3x; Sat, 05 Nov 2022 14:18:53 +0000
Received: from [37.120.193.124] (helo=mail.cock.li)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1orK0X-006frD-JZ
	for kexec@lists.infradead.org; Sat, 05 Nov 2022 14:18:52 +0000
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tfwno.gf; s=mail;
	t=1667657790; bh=J7AqfEf7LvFDpqBYRlFhO8k4vfiTi6BH8M8TJ5Qv02s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KbjOkyroeyovBXygh35SwSIFVx4a8Xt4hpUdDp97q6+8nixOx0RL4hiUij+/vaePB
	 2t4XRTbjU72AtJckqln8KAw7Gq8M7xAGwh8wRnj4Zy8Hk67eCM8ewY41eb5w/gph0+
	 V1nz7lFLcltMnB2qPASazgNWMFpbSZKEoWWWXTxPWedNps1MM17/CrukWl+qquu3yG
	 oyaaW5bvy3r4UZfFujMTt/VeUM+DZRoQigihRWBAbRuXOCQKZt11WaLyOovNeKA8YN
	 QZxKHIUQBZJ8Klzj+4IXMfcHwEADJvCTxze47rpdqMyJX0xxEeIItilpzTyM70OY0a
	 Xz2px1nk9okRQ==
Date: Sat, 05 Nov 2022 14:16:30 +0000
From: ns@tfwno.gf
To: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Eric Biederman <ebiederm@xmission.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ard Biesheuvel
 <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: Re: Bug: kexec on Lenovo ThinkPad T480 disables EFI mode
In-Reply-To: <CALu+AoTVtO=-tzbgjeVRQ3uO0yGUPWKPuAiLn0CpaAq_=xr-sw@mail.gmail.com>
References: <3acf1cc7a974cb4fb9b77b39311c6714@tfwno.gf>
 <Y2XUNive2KMwTjUF@MiWiFi-R3L-srv>
 <CALu+AoTVtO=-tzbgjeVRQ3uO0yGUPWKPuAiLn0CpaAq_=xr-sw@mail.gmail.com>
Message-ID: <2f43e1e583a92e1592c48a15a763e1f7@tfwno.gf>
X-Sender: ns@tfwno.gf
User-Agent: Roundcube Webmail/1.3.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221105_071850_106460_152E6D82 
X-CRM114-Status: GOOD (  45.12  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 2022-11-05 05:49, Dave Young wrote:
> Baoquan, thanks for cc me.
> 
> On Sat, 5 Nov 2022 at 11:10, Baoquan He <bhe@redhat.com> wrote:
>> 
>> Add Dave to CC
>> 
>> On 10/28/22 at 01:02pm, ns@tfwno.gf wrote:
>> > Greetings,
>> >
>> > I've been hitting a bug on my Lenovo ThinkPad T480 where kexecing will
>> > cause EFI mode (if that's the right term for it) to be unconditionally
>> > disabled, even when not using the --noefi option to kexec.
>> >
>> > What I mean by "EFI mode" being disabled, more than just EFI runtime
>> > services, is that basically nothing about the system's EFI is visible
>> > post-kexec. Normally you have a message like this in dmesg when the
>> > system is booted in EFI mode:
>> >
>> > [    0.000000] efi: EFI v2.70 by EDK II
>> > [    0.000000] efi: SMBIOS=0x7f98a000 ACPI=0x7fb7e000 ACPI 2.0=0x7fb7e014
>> > MEMATTR=0x7ec63018
>> > (obviously not the real firmware of the machine I'm talking about, but I
>> > can also send that if it would be of any help)
>> >
>> > No such message pops up in my dmesg as a result of this bug, & this
>> > causes some fallout like being unable to find the system's DMI
>> > information:
>> >
>> > <6>[    0.000000] DMI not present or invalid.
>> >
>> > The efivarfs module also fails to load with -ENODEV.
>> >
>> > I've tried also booting with efi=runtime explicitly but it doesn't
>> > change anything. The kernel still does not print the name of the EFI
>> > firmware, DMI is still missing, & efivarfs still fails to load.
>> >
>> > I've been using the kexec_load syscall for all these tests, if it's
>> > important.
>> >
>> > Also, to make it very clear, all this only ever happens post-kexec. When
>> > booting straight from UEFI (with the EFI stub), all the aforementioned
>> > stuff that fails works perfectly fine (i.e. name of firmware is printed,
>> > DMI is properly found, & efivarfs loads & mounts just fine).
>> >
>> > This is reproducible with a vanilla 6.1-rc2 kernel. I've been trying to
>> > bisect it, but it seems like it goes pretty far back. I've got vanilla
>> > mainline kernel builds dating back to 5.17 that have the exact same
>> > issue. It might be worth noting that during this testing, I made sure
>> > the version of the kernel being kexeced & the kernel kexecing were the
>> > same version. It may not have been a problem in older kernels, but that
>> > would be difficult to test for me (a pretty important driver for this
>> > machine was only merged during v5.17-rc4). So it may not have been a
>> > regression & just a hidden problem since time immemorial.
>> >
>> > I am willing to test any patches I may get to further debug or fix
>> > this issue, preferably based on the current state of torvalds/linux.git.
>> > I can build & test kernels quite a few times per day.
>> >
>> > I can also send any important materials (kernel config, dmesg, firmware
>> > information, so on & so forth) on request. I'll also just mention I'm
>> > using kexec-tools 2.0.24 upfront, if it matters.
> 
> Can you check the efi runtime in sysfs:
> ls /sys/firmware/efi/runtime-map/
> 
> If nothing then maybe you did not enable CONFIG_EFI_RUNTIME_MAP=y, it
> is needed for kexec UEFI boot on x86_64.

Oh my, it really is that simple.

Indeed, enabling this in the pre-kexec kernel fixes it all up. I had
blindly disabled it in my quest to downsize the pre-kexec kernel to
reduce boot time (it only runs a bootloader). In hindsight, the firmware
drivers section is not really a good section to tweak on a whim.

I'm terribly sorry to have taken your time to "fix" this "bug". But I
must ask, is there any reason why this is a visible config option, or at
least not gated behind CONFIG_EXPERT? drivers/firmware/efi/runtime-map.c
is pretty tiny, & considering it depends on CONFIG_KEXEC_CORE, one
probably wants to have kexec work properly if they can even enable it.
I admit the help text for it is arguably pretty good, but I feel like
the config option is only really useful for embedded, the same
enviroments where people would disable stuff like CONFIG_DMI -- a config
option that I would argue is pretty justifiably gated behind
CONFIG_EXPERT, because far too many systems break without it & it's
pretty small code, so really not worth it unless you absolutely know
what you're doing. Similarly, I don't really think there's much value
in disabling the ability to kexec without the firmware except if you're
heavily informed & must have the size reduction, especially since in
EFI land that's where your DMI info comes from, if I were to argue for
it on the basis of CONFIG_DMI being gated. In summary, it can cause
quite a bit of unnecessary confusion despite only being useful to a very
small minority of users.

Thank you!

> 
> Otherwise you can add debug printf in kexec-tools efi error path to
> see what is wrong.
> kexec/arch/i386/x86-linux-setup.c : function setup_efi_data
> 
> And if it still not work please post your kernel config, I can have a
> try although I do not have the t480 now.
> 
> 
>> >
>> > Regards,
>> >
>> > _______________________________________________
>> > kexec mailing list
>> > kexec@lists.infradead.org
>> > http://lists.infradead.org/mailman/listinfo/kexec
>> >
>> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

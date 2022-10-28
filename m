Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA92C38A02
	for <kexec@archiver.kernel.org>; Fri, 28 Oct 2022 13:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-ID:Subject:To:From:Date:MIME-Version:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=xlMmYoy4FjvnrMieKnQ5VRZ/qXN/MEvGCb3sZm3QryE=; b=3Rsen98xQDKqeL
	kNWucXHe65tFM7QSNUYrRPLrc9ppzTG+s4/HqKISv9ygp1iUM3w+QcoOYS30RepEDZhZ4vFKz6ab6
	kt+6/Ckhiuk6ZStX1+c+vc95hMLrPrD/w5by3ZqlSvOE/SdiowSUqUXxqJf/n7l5vPmRO7C2Re2wl
	jSPO5/1VRNha0u4A3HAhYRJj1WA9/A6vnbsjjWSm2Jye2S5e3X7K0vNuoxI0/ZTCbYIoSuQIa4+Y0
	5KKHEdUEphEXcUQGtvMFFEp61FgqF1R9rEVHDIz0QCdXUC/vlwCNphtvsrRsLkLu4r8iYASP4xeV5
	r0newuwCtFZrXWF1qZkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooP3C-00HDbV-H1; Fri, 28 Oct 2022 13:05:30 +0000
Received: from [37.120.193.124] (helo=mail.cock.li)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooP2e-00HCh8-9W
	for kexec@lists.infradead.org; Fri, 28 Oct 2022 13:05:02 +0000
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tfwno.gf; s=mail;
	t=1666962143; bh=DtqNWOtFT8hw8nEEdF0WNtUoPrpPIt01zfqy5oCYP98=;
	h=Date:From:To:Subject:From;
	b=HFXv+/6hCmM4TKSJ1FVpzgYQgQ05+CzT6N83RncfSJI5p/5NoB7F5BycLwFfO627h
	 NPKc+nhle+14LrcO8CpuE2DhIQwe6cv5PUPKXj6Zr7oU2ZIxOk+xjbj51T/+t6hHIN
	 3Vqq/i1noAP9mJRAQdEfeD3JC5eyk3RttfIUDbENEr7FdFGoMdcxmtwA3ZQNVFyGHc
	 9y2Ho64yPjz5beRlVbYAJa0uoDy2qhuUtB4zM5hit+7DiD8axQcMe/cze3kpb/7lSX
	 q3gRFm0Cv5YcdOIaiJzqZM4KfHq6EN22QWxOWCx9bINWR3S6rJZHG4aBnEqaeYuNop
	 XlwBpoQ+6wJHQ==
Date: Fri, 28 Oct 2022 13:02:23 +0000
From: ns@tfwno.gf
To: Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 linux-efi@vger.kernel.org
Subject: Bug: kexec on Lenovo ThinkPad T480 disables EFI mode
Message-ID: <3acf1cc7a974cb4fb9b77b39311c6714@tfwno.gf>
X-Sender: ns@tfwno.gf
User-Agent: Roundcube Webmail/1.3.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221028_060458_557177_05DEAEB0 
X-CRM114-Status: GOOD (  16.10  )
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

Greetings,

I've been hitting a bug on my Lenovo ThinkPad T480 where kexecing will
cause EFI mode (if that's the right term for it) to be unconditionally
disabled, even when not using the --noefi option to kexec.

What I mean by "EFI mode" being disabled, more than just EFI runtime
services, is that basically nothing about the system's EFI is visible
post-kexec. Normally you have a message like this in dmesg when the
system is booted in EFI mode:

[    0.000000] efi: EFI v2.70 by EDK II
[    0.000000] efi: SMBIOS=0x7f98a000 ACPI=0x7fb7e000 ACPI 
2.0=0x7fb7e014 MEMATTR=0x7ec63018
(obviously not the real firmware of the machine I'm talking about, but I
can also send that if it would be of any help)

No such message pops up in my dmesg as a result of this bug, & this
causes some fallout like being unable to find the system's DMI
information:

<6>[    0.000000] DMI not present or invalid.

The efivarfs module also fails to load with -ENODEV.

I've tried also booting with efi=runtime explicitly but it doesn't
change anything. The kernel still does not print the name of the EFI
firmware, DMI is still missing, & efivarfs still fails to load.

I've been using the kexec_load syscall for all these tests, if it's
important.

Also, to make it very clear, all this only ever happens post-kexec. When
booting straight from UEFI (with the EFI stub), all the aforementioned
stuff that fails works perfectly fine (i.e. name of firmware is printed,
DMI is properly found, & efivarfs loads & mounts just fine).

This is reproducible with a vanilla 6.1-rc2 kernel. I've been trying to
bisect it, but it seems like it goes pretty far back. I've got vanilla
mainline kernel builds dating back to 5.17 that have the exact same
issue. It might be worth noting that during this testing, I made sure
the version of the kernel being kexeced & the kernel kexecing were the
same version. It may not have been a problem in older kernels, but that
would be difficult to test for me (a pretty important driver for this
machine was only merged during v5.17-rc4). So it may not have been a
regression & just a hidden problem since time immemorial.

I am willing to test any patches I may get to further debug or fix
this issue, preferably based on the current state of torvalds/linux.git.
I can build & test kernels quite a few times per day.

I can also send any important materials (kernel config, dmesg, firmware
information, so on & so forth) on request. I'll also just mention I'm
using kexec-tools 2.0.24 upfront, if it matters.

Regards,

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

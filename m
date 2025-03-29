Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12567C36008
	for <kexec@archiver.kernel.org>; Sat, 29 Mar 2025 20:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qtGq3mNlYow8hi5/IZSZYU3QysB2Tb0jRTp1wsbBTts=; b=der+0yegB/67LuH7cJjsWG8dZL
	cLsqZi5w2yeDFmkJB+iY6zL89+E57KLB7oEI7n1Uh+P1jCRip6Zr5Apr/0uCvXJPzZtcVVAVvuwRb
	5SuZ1IUf1PNQLtYQvfof5zwHsa5+vgA2jAuBJk6bYKQgGFgJ0CO8YtVPMiLgPRh15I1yBgXnbjxVu
	1isR5l+OPiWuaDWh0ujI/SSD9v1zrGYQ03FrKtazVmaIIEFL1Ss4zsB5PWlyRERkcPwjjtNlVyMh7
	Zra7SaaBuoNc7OcnLsBi/DhvWarVYJpFPCoYk5NM6IRGGibv7mkLAVBEvRkdSQ+ilmoeq40rGG7Q+
	JmzYKMUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tycp4-0000000FUuA-1kKC;
	Sat, 29 Mar 2025 20:30:30 +0000
Received: from out-170.mta1.migadu.com ([95.215.58.170])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tycp0-0000000FUtd-2cCz
	for kexec@lists.infradead.org;
	Sat, 29 Mar 2025 20:30:28 +0000
Date: Sat, 29 Mar 2025 21:30:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1743280222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qtGq3mNlYow8hi5/IZSZYU3QysB2Tb0jRTp1wsbBTts=;
	b=aW4M8QS3b++thG7g7a2HoNC7FuNBkM9NxwhZFG7OEAcPIU3vSt1JEBcuQSUED39rbYCBWm
	w0sNFCzjZ9TaQ3sy9FtZB1SUoGKzjVDVk4OeXIiEG+MycVufpSxUJkMfVV/qfNJjt2r9vk
	RIknYmi7YS74pwtd4tOuX7a/HWZridkVyxahP63wTdb+qY5P7YajZoA1QOoZuIOYHdcrQE
	EavM9q1MZFIfo9Dyq7KFIScP7P1Y6/Th14lOKuHkHQqrkswPgSZjZOuDEOi0HEEev2w5XC
	KZ7cjfSTZLYjxMwwGuyHtSNA4Y65VD/GjIbQGNxs7f64hrPjxtqjazYtnkGbwA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, ebiederm@xmission.com,
	rafael@kernel.org, pavel@ucw.cz, ytcoode@gmail.com,
	kexec@lists.infradead.org, linux-pm@vger.kernel.org,
	akpm@linux-foundation.org, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-ID: <Z-hYWc9LtBU1Yhtg@desktop0a>
References: <Z4WFjBVHpndct7br@desktop0a>
 <Z5bx7ZHNcyc5fM_L@darkstar.users.ipa.redhat.com>
 <CALu+AoSSKh=5ELgQyzDrGEDm5fm2XKteH1ZC70mm89pNSSPMHw@mail.gmail.com>
 <Z-c7V2hptt9U9UCl@desktop0a>
 <Z+dQZozsbdls6yqJ@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+dQZozsbdls6yqJ@MiWiFi-R3L-srv>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250329_133027_307140_33FA7543 
X-CRM114-Status: GOOD (  25.01  )
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

On 2025-03-29 09:44 +0800, Baoquan He wrote:
> On 03/29/25 at 01:14am, Roberto Ricci wrote:
> [snip]
> > Anyway, I performed yet another bisection, this time with just plain
> > defconfig plus CONFIG_KEXEC_FILE=y, and I got different results.
> > 
> > Updated steps to reproduce:
> > 1. Boot kernel >= v6.8 in a virtual machine created with this command:
> >    `qemu-system-x86_64 -enable-kvm -smp 1 -m 4.0G -hda disk.qcow2`
> > 2. Load the same kernel with:
> >    `kexec --kexec-file-syscall -l /boot/vmlinuz-6.14.0 --initrd /boot/initramfs-6.14.0.img --reuse-cmdline`
> > 3. Reboot (or call `kexec -e` directly)
> > 4. Hibernate and reboot: `printf reboot >/sys/power/disk && printf disk >/sys/power/state`
> > 5. Upon resuming, three things could happen, depending on luck:
> 
> OK, this is a little complicated. wondering why you need to do the
> hibernation and reboot. Just for curiosity.

The reason I do hibernation and reboot instead of hibernation and then
manually boot again is just convenience during tests. The issue occurs
with manual reboot too.
The reason I want kexec + hibernation to work is to fix a hibernation
issue on a system using ZFSBootMenu, a bootloader based on Linux which
uses kexec to boot the final OS. Other software using the same
mechanism include Petitboot and LinuxBoot. They might be affected as
well but I didn't try.

> > 5a. A kernel oops:
> > ```
> > [   42.574201] BUG: kernel NULL pointer dereference, address: 0000000000000000
> ...snip... 
> > I will send config and dmesg in replies to this email.
> > 
> > The bisection pointed to
> > b3ba234171cd kexec_file: load kernel at top of system RAM if required
> [snip]
> 
> I doubt how this caused the failure. I have several questions, could you
> help answer:
> 
> 1) Can this problem be stably reproduced with kexec_file_load?

Every kernel build I tested which contains that commit is affected.
However a given build will not always lead to the same of the three
possible outcomes I described. E.g. first you get a oops (case 5a),
then you repeat the same steps with the same kernel image and the
system may get stuck at a black screen instead (case 5b).
But it never fully works.

> 2) if answer to 1) is yes, can reverting b3ba234171cd fix it stably?

Yes. None of cases 5{a,b,c} I previously described occur. Seems to work
fine.

> 3) If answer to 1) and 2) is yes, does kexec_load works for you? Asking
> this because kexec_load interface defaults to put kexec kernel on top of
> system RAM which is equivalent to applying commit b3ba234171cd.

No, it doesn't. While hibernation alone works, kexec + hibernation
results in the system just rebooting without resuming the hibernation
image, but no crash or other weird behaviour occurs.
Initially I decided to focus on kexec_file_load in order to narrow
things down, but that was before noticing that the bug could manifest
itself in different forms.
It is possible, indeed, that both syscalls are affected by the same
problem, which is not caused by commit b3ba234171cd.
I tried to test kexec_load with some older kernels, but I got build
errors, so I tested longterm releases where such errors have been fixed.
With v4.9.337, kexec (via kexec_load) + hibernation works.
With v5.4.291 it doesn't.
I'm not sure how bisection could be done in this case.

> 4) Can you add '-d' to 'kexec -l' to print more debugging message?

When using kexec_file_load, just these two lines get printed:

```
Try gzip decompression.
Try LZMA decompression.
```

When using kexec_load on kernel v5.4.291 (which doesn't work):
[the output is in a reply to this email]

When using kexec_load on kernel v4.9.337 (which works):
Identical to above, except for the exact hex value of some addresses.

> 5) Can normal kexec trigger the failure? I mean operating kexec w/o
> the hibernation/resumption. 

No, kexec without hibernation seems to work fine, regardless of kernel
version and kexec syscall used.


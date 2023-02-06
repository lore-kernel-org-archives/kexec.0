Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6C4C636D3
	for <kexec@archiver.kernel.org>; Mon,  6 Feb 2023 17:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Cc:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Lqt2gjXf1zmYeOBHmVXwIffnEzlXX25WNPwMG+m1buo=; b=tj1YLHbwLyzrBZ
	3gD1Cu4jgPJHRVoF93r2GiUjhVPMV7MdhrY4j0MA2zX2iTobnJQm4tGf1IBlUq/mzywoP8xUkfLeq
	hE+z36QC2+ME6GWSa53mRSa+ZBNGxD3/8BYeKU1aHuccNSXELe367HuQuTBss5Mrj/P2sa5gL7O0F
	hJ2h2Uv6L2p1n9ovecIpC9+Ee4BnNAY7dphyg4tHKaQeiCQmPHCcTdMgAKaUxkP4YTa30B4q+WRY4
	JsXC0A7HoBR+30w4OkuUidHFc8GTYDQ0hYOQp4z4wn/yO4azsjfmJNGC0SWjv+Ce5Q4nm/dbSbPXL
	Di1/xJWcOUitWf9frjMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pP5Yz-009Xyt-RI; Mon, 06 Feb 2023 17:45:57 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pP5Yv-009Xxx-Ry
	for kexec@lists.infradead.org; Mon, 06 Feb 2023 17:45:55 +0000
Received: by mail-pl1-x62a.google.com with SMTP id r8so12956304pls.2
        for <kexec@lists.infradead.org>; Mon, 06 Feb 2023 09:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUlkqzlWqGkCJ4BbYya51xWhyTnod5O743o0UfxJk40=;
        b=H+6t6vFnGRAVvhNX1HPOc9SKSuB+jjRmTgdP5gbLzXgqkwu1hi7KAewRn0GU6xyw/q
         AK3HT+pZFfZAnrnVo+fP0mUK2RB+6+iakQLRqPMjjHKb/W5EZ0SfHA9d3AoaJP9Xhwgn
         ZMfYY5HvP2iIKSvE8oAb1+1ZMuti2pSssWyoW8Szb+f0XeDida4i71KzHPut5Zc4OJC1
         ndU499ul5LurOicLCNoBwHzy+T1BG1KxQI/gd6Ca+28ntOztiULT/LCSLVg417Nk3Il4
         F2qMv29gmC24ZR5sKxk/RCoxsE2JAUnBFAlM/TVBvFvF+NX9+r0vM3qRnDMnM/GF4cmL
         kqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUlkqzlWqGkCJ4BbYya51xWhyTnod5O743o0UfxJk40=;
        b=dTzU67sEqxbi29/Htfmrp32Uxk8o63Pnelr8tM4YnwtOIu5qG1PpmJmwQ9OWetyod0
         CrQOkFKgdWb9cI7ZuWvFMzxVV8Rn9fBUsBObtt2j9ZoVHqWSZvpyfeA9v3vssmZ7RgVE
         a2KROxbqEgvrEiP1bGSgnZHivl7ZRJYJmb6Nw/K9EBjYr+gzcmAxhu6jrJvsVE8VolID
         HuxSXD66/dR02cbJ3HoEf5yzVSdU88h3kaHqTAmQWgQJeMCf5vNGXlC+3vODvJoyZ3AT
         UNtiM3YtkZFRfBidkluGv6yw59l562AXTF/IuNXbx/gFxrqBdqBnW9D1/66UQduUQpOF
         UcKA==
X-Gm-Message-State: AO0yUKXchyfwUlFTu4kAvwNzTpraa7WEa0sSHgjzdQVRCUVjtOfGNPeo
	9DifMET5e1OKISOnXnYAuAKnldMfpILYyA==
X-Google-Smtp-Source: AK7set+B5vnfy/sIGeol+YkwMPoPjc62uNuGyY7AliBi7HTEhlKVB159vHlE7tNGPTfGcbfuS4i7gA==
X-Received: by 2002:a17:902:f109:b0:199:cb9:ce81 with SMTP id e9-20020a170902f10900b001990cb9ce81mr297130plb.16.1675705549415;
        Mon, 06 Feb 2023 09:45:49 -0800 (PST)
Received: from smtpclient.apple (yishen-mbp.mcdb.ucsb.edu. [128.111.208.67])
        by smtp.gmail.com with ESMTPSA id d3-20020a170902b70300b00193020e8a90sm7166386pls.294.2023.02.06.09.45.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Feb 2023 09:45:48 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: Unified Kernel Image Support
From: Yishen Miao <mys721tx@gmail.com>
In-Reply-To: <20230206173320.103a9d21@rotkaeppchen>
Date: Mon, 6 Feb 2023 09:45:37 -0800
Cc: Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org
Message-Id: <1DC56DB1-780D-45B8-964A-DDD54B0FCDDE@gmail.com>
References: <5D04A23B-9A82-4186-AFA8-7E3A0FBBDF86@gmail.com>
 <Y+DGJfYEJpbee/bM@MiWiFi-R3L-srv> <20230206173320.103a9d21@rotkaeppchen>
To: Philipp Rudo <prudo@redhat.com>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230206_094553_944471_50F98267 
X-CRM114-Status: GOOD (  33.37  )
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

Hi Baoquan and Philipp,

I did some digging and the UKI spec seems to suggest the .initrd section is the complete cpio image. [1]

The following commands should make a usable UKI. [2]

$ cat esp/cpu_manufacturer-ucode.img esp/initramfs-linux.img > /tmp/combined_initrd.img
$ osrel_offs=$(objdump -h "/usr/lib/systemd/boot/efi/linuxx64.efi.stub" | awk 'NF==7 {size=strtonum("0x"$3); offset=strtonum("0x"$4)} END {print size + offset}')
$ cmdline_offs=$((osrel_offs + $(stat -Lc%s "/usr/lib/os-release")))
$ splash_offs=$((cmdline_offs + $(stat -Lc%s "/etc/kernel/cmdline")))
$ linux_offs=$((splash_offs + $(stat -Lc%s "/usr/share/systemd/bootctl/splash-arch.bmp")))
$ initrd_offs=$((linux_offs + $(stat -Lc%s "vmlinuz-file")))
$ objcopy \
--add-section .osrel="/usr/lib/os-release" --change-section-vma .osrel=$(printf 0x%x $osrel_offs) \
--add-section .cmdline="/etc/kernel/cmdline" \
--change-section-vma .cmdline=$(printf 0x%x $cmdline_offs) \
--add-section .splash="/usr/share/systemd/bootctl/splash-arch.bmp" \
--change-section-vma .splash=$(printf 0x%x $splash_offs) \
--add-section .linux="vmlinuz-file" \
--change-section-vma .linux=$(printf 0x%x $linux_offs) \
--add-section .initrd="/tmp/combined_initrd.img" \
--change-section-vma .initrd=$(printf 0x%x $initrd_offs) \
"/usr/lib/systemd/boot/efi/linuxx64.efi.stub" "linux.efi"

While the .cmdline section in a UKI cannot be changed per se, it is relative simple to generate a new image with the updated .cmdline. If the user is signing their own binaries for Secure Boot, this should allow them to edit the .cmdline in a roundabout way.

Hope these helps!

Best,
mys_721tx

[1] https://uapi-group.org/specifications/specs/unified_kernel_image/
[2] https://wiki.archlinux.org/title/Unified_kernel_image



> On Feb 6, 2023, at 08:33, Philipp Rudo <prudo@redhat.com> wrote:
> 
> Hi,
> 
> On Mon, 6 Feb 2023 17:19:33 +0800
> Baoquan He <bhe@redhat.com> wrote:
> 
>> On 02/03/23 at 10:46pm, Yishen Miao wrote:
>>> Hello all,
>>> 
>>> I am experimenting kexec on my box. It uses systemd-boot as the bootloader and boots from a unified kernel image (objcopy'ed cmdline, kernel, initrdramfs, and microcode updates). As of kexec-tools 2.0.25 and systemd 252.5, when I rum systemctl kexec, it returns the following:
>>> 
>>> 
>>> # sudo systemctl kexec
>>> Running /usr/bin/kexec --load "/efi/EFI/Linux/ArchLinux-linux.efi" --append "root=UUID=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"(null)
>>> Cannot determine the file type of /efi/EFI/Linux/ArchLinux-linux.efi
>>> 
>>> It seems that systemctl successfully identified the UKI from systemd-boot, however, kexec could not recognize it.
>>> 
>>> Are there any plans to add UKI support to kexec? Your response is greatly appreciated!  
>> 
>> My colleageus mentioned UKI recently. We have plan to support it, while
>> haven't started to work on that.
> 
> I've looked into UKI recently. In order to provide some base support
> one should only need to teach kexec_file_load the new file format [1].
> However that still leaves two fundamental issues which limit the
> usefulness of that support.
> 
> 1) The way I understand it the initrd contained in the UKI is only a
> stub that is supposed to read further "modules" from disk which
> together form the initrd needed for the given hardware/system
> configuration. The problem is that the kexec_file_load syscall only
> accepts one fd for the kernel and one fd for the initrd. So to support
> multiple modules we would either need to introduce a new syscall or
> define a uABI that allows to pass multiple initrds via this one fd.
> Either way it's a new user interface and should be designed with care.
> 
> 2) As the kernel command line is part of the UKI and is protected by
> the signature it cannot be changed by users. So to support kdump with a
> UKI a distro would need to find one crashkernel= parameter that works
> for all users which is impossible. Thus before kdump can be supported
> with UKI there needs to be a  mechanism in place that allows users to
> edit the command line. Others have the same problem. There is an open
> issue on github [2] to add this support.
> 
> So all in all I believe there will be kexec support for UKI but I don't
> see it to come anytime soon.
> 
> Thanks
> Philipp
> 
> [1] ...and kexec-tools if you like to support kexec_load. But as the
> main use case for UKI is together with Secure Boot I don't think that's
> necessary.
> 
> [2] https://github.com/systemd/systemd/issues/24539
> 
>> I have a testing machine at hand right now, just finished teseting
>> upstream patches. If you have the detailed steps about how to make UKI,
>> privately or publicly, I can try it now, and see what we can do.
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

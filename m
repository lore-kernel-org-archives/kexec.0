Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8132FE77188
	for <kexec@archiver.kernel.org>; Sun, 22 Dec 2024 20:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:
	Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aBxp+u0VL9hclJhT7KBRKPWF+rKY2/97p0eiyzGofBQ=; b=kNZ0Tz+zPAT0YQewVHwDQUSJAS
	boAEiXHd34jmu7oKY8FHIxNfq0Dy8m4jsb44gX27N2eyI+9ZC04Kj9VtCV4LTliRfNPCcYFcTovRC
	ardxq1CWqrbt6uRnicx/0WwZvzfWw40EpC0V/O4VTy2XXH5UaAS0PUbkz9bVuxdGQS5dL7N9ucLdH
	o9uvWNmpTfZlW0dz7Bw6ZQksoszV3+9NfgBOxImvZjrTjys5IrVGNAk+gpp32u3zBVcIg3N83Wv3M
	3ncrvpsyomcfP6i8zM5XBVtyVA4aDkaO8zyIOkRvqjEqV9HtZQ1bQFcd5n5d1kTEIwMgMt65wnBks
	JwYU0qIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tPSDW-00000008mo6-3q1h;
	Sun, 22 Dec 2024 20:06:23 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tPSDR-00000008mne-0mky
	for kexec@lists.infradead.org;
	Sun, 22 Dec 2024 20:06:18 +0000
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-7fd4c0220bbso3173228a12.0
        for <kexec@lists.infradead.org>; Sun, 22 Dec 2024 12:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734897976; x=1735502776; darn=lists.infradead.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBxp+u0VL9hclJhT7KBRKPWF+rKY2/97p0eiyzGofBQ=;
        b=Afx/vxRViiMSHTBaCf2OLZYg2DmY4MVW9w+WrKfGuaDkfm6ihu8bjzNNSHCWCwc2lD
         G0zPu4O42lZVNFYEF+RhfrLr8uviL1hN7o71k3P3+7iGkQoh4fJR4tPqChA9PqgxkNl4
         C1uhUoaMeUrFE+iE9WFWR0iBs3IuOYYRxn3Z7c1CctflJDEzNWBaZe2CSRfQW6ErraMe
         m9Ag6fAp6TarrBy0y5QvMTEctEBvfKnLnqAEC/bEIBoIYznmShjK8nVuOf/+X5kRSOUf
         rvUo526eGaQi8mvQb6tQ5rqm+VARvBiEXH5MTrM+ERepfxIpZS3sKdIrl28EprNtum1p
         49NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734897976; x=1735502776;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBxp+u0VL9hclJhT7KBRKPWF+rKY2/97p0eiyzGofBQ=;
        b=O+PxMtKt1Ul8a7K1ymnezmjyf7iHsgu0l5NwXdYeioDgh2H89IFnFr6AOXY2A5/mGd
         QJnx7SVIzuwbcvZO7Ysw1hncM4w5NSkBmSk+aj3lPCGw32HsUd3TaLcSNWNfMvSfT6bI
         0T1RdO3Awm67N46zii17xVCDcWENoHi3MTVX8hvARXMLOOMnauY19Owd9GdYBjbSQSSx
         KuZMmOoRpgx9Nm91wgeTm/9gq4Xfr+FeBVLmGKmEEiUnsCl38ih8Gn3hvbqWKcLRaZdj
         cQoIVR0ZqrHbkJqt4dNPUcBNszrhtG0rVDUKpgUSCRdRM0NP3vWYba38XrEFWJrBSJ0n
         LwMA==
X-Forwarded-Encrypted: i=1; AJvYcCXaB/2mcfDgXRg0Nv1Xv9bMOFZ7fwtDArPixpHB6Ky4QcHwH836QA5erC6w732lzgu26nnjmA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy2Yw1lsa86SdjjzQcWOXrqGF/J2U/hHNuc3xoMDgqqYGB0Mwa7
	zvQEqfjPGfTDSfdPHZQpD3kcWXCbw7xZGvK+K1eXXdJM5aUqPynMwtqmuvy7
X-Gm-Gg: ASbGnct45FaP5hJUyNCbPhBXqn5KxcnhFY3C29YsWuTFOtye58DbsNxxzfbaqjGuFnC
	CJnekj+c+wWNiT5kxZhEnTR8FBjEZXiuLbt+c6q3aEWfuKPtVmMWRqUH2WivgT7Amck2AZu4xUZ
	VqCNA/bNg21OYRhTcK0Ke7t2ShZBXUDgDxXz4UAXb6vf1TSU8rJPNuyEFaveodgDyDl6tXPXaX4
	gtM4eu7oeoZo2MMIgj26eGJ0z1Wm5HZPhDdb4w1PFyuHbLrvfWRFPZ718NWEZ53QJEw7QKpMYKM
	PF6NUvN0p8DxWHPGAwImpCPdcZc=
X-Google-Smtp-Source: AGHT+IG9A1uXyj4481mWEFVzosPBb0wPkMyVT6yXUa8R8EmX4EIUsuRa+zyPcQxZNVetHxG7vTYK0Q==
X-Received: by 2002:a17:90b:534f:b0:2ee:ab29:1482 with SMTP id 98e67ed59e1d1-2f452e2ecc8mr16685309a91.16.1734897975726;
        Sun, 22 Dec 2024 12:06:15 -0800 (PST)
Received: from smtpclient.apple (ResNet-10-185.resnet.ucsb.edu. [169.231.10.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96e933sm60433515ad.59.2024.12.22.12.06.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Dec 2024 12:06:15 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: Unified Kernel Image Support
From: Yishen Miao <mys721tx@gmail.com>
In-Reply-To: <1DC56DB1-780D-45B8-964A-DDD54B0FCDDE@gmail.com>
Date: Sun, 22 Dec 2024 12:06:04 -0800
Cc: Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <28571AAC-25A3-4CAF-A292-4D69C33C1C16@gmail.com>
References: <5D04A23B-9A82-4186-AFA8-7E3A0FBBDF86@gmail.com>
 <Y+DGJfYEJpbee/bM@MiWiFi-R3L-srv> <20230206173320.103a9d21@rotkaeppchen>
 <1DC56DB1-780D-45B8-964A-DDD54B0FCDDE@gmail.com>
To: Philipp Rudo <prudo@redhat.com>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241222_120617_242542_475CFE61 
X-CRM114-Status: GOOD (  27.52  )
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

Looks like kexec_file_load got UKI support in September 2023 =
<https://lore.kernel.org/kexec/20230911052535.335770-1-kernel@jfarr.cc/T/>=
 and kexec-tools also received UKI support on x86_64 recently =
<https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/=
?id=3D0475ec5d32469a486713f9ed7023645bbbbb8769>. Hopefully we will have =
full UKI support by kexec-tools 2.0.31.

Best,
mys_721tx

> On Feb 6, 2023, at 09:45, Yishen Miao <mys721tx@gmail.com> wrote:
>=20
> Hi Baoquan and Philipp,
>=20
> I did some digging and the UKI spec seems to suggest the .initrd =
section is the complete cpio image. [1]
>=20
> The following commands should make a usable UKI. [2]
>=20
> $ cat esp/cpu_manufacturer-ucode.img esp/initramfs-linux.img > =
/tmp/combined_initrd.img
> $ osrel_offs=3D$(objdump -h =
"/usr/lib/systemd/boot/efi/linuxx64.efi.stub" | awk 'NF=3D=3D7 =
{size=3Dstrtonum("0x"$3); offset=3Dstrtonum("0x"$4)} END {print size + =
offset}')
> $ cmdline_offs=3D$((osrel_offs + $(stat -Lc%s "/usr/lib/os-release")))
> $ splash_offs=3D$((cmdline_offs + $(stat -Lc%s =
"/etc/kernel/cmdline")))
> $ linux_offs=3D$((splash_offs + $(stat -Lc%s =
"/usr/share/systemd/bootctl/splash-arch.bmp")))
> $ initrd_offs=3D$((linux_offs + $(stat -Lc%s "vmlinuz-file")))
> $ objcopy \
> --add-section .osrel=3D"/usr/lib/os-release" --change-section-vma =
.osrel=3D$(printf 0x%x $osrel_offs) \
> --add-section .cmdline=3D"/etc/kernel/cmdline" \
> --change-section-vma .cmdline=3D$(printf 0x%x $cmdline_offs) \
> --add-section .splash=3D"/usr/share/systemd/bootctl/splash-arch.bmp" \
> --change-section-vma .splash=3D$(printf 0x%x $splash_offs) \
> --add-section .linux=3D"vmlinuz-file" \
> --change-section-vma .linux=3D$(printf 0x%x $linux_offs) \
> --add-section .initrd=3D"/tmp/combined_initrd.img" \
> --change-section-vma .initrd=3D$(printf 0x%x $initrd_offs) \
> "/usr/lib/systemd/boot/efi/linuxx64.efi.stub" "linux.efi"
>=20
> While the .cmdline section in a UKI cannot be changed per se, it is =
relative simple to generate a new image with the updated .cmdline. If =
the user is signing their own binaries for Secure Boot, this should =
allow them to edit the .cmdline in a roundabout way.
>=20
> Hope these helps!
>=20
> Best,
> mys_721tx
>=20
> [1] https://uapi-group.org/specifications/specs/unified_kernel_image/
> [2] https://wiki.archlinux.org/title/Unified_kernel_image
>=20
>=20
>=20
>> On Feb 6, 2023, at 08:33, Philipp Rudo <prudo@redhat.com> wrote:
>>=20
>> Hi,
>>=20
>> On Mon, 6 Feb 2023 17:19:33 +0800
>> Baoquan He <bhe@redhat.com> wrote:
>>=20
>>> On 02/03/23 at 10:46pm, Yishen Miao wrote:
>>>> Hello all,
>>>>=20
>>>> I am experimenting kexec on my box. It uses systemd-boot as the =
bootloader and boots from a unified kernel image (objcopy'ed cmdline, =
kernel, initrdramfs, and microcode updates). As of kexec-tools 2.0.25 =
and systemd 252.5, when I rum systemctl kexec, it returns the following:
>>>>=20
>>>>=20
>>>> # sudo systemctl kexec
>>>> Running /usr/bin/kexec --load "/efi/EFI/Linux/ArchLinux-linux.efi" =
--append "root=3DUUID=3DXXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"(null)
>>>> Cannot determine the file type of =
/efi/EFI/Linux/ArchLinux-linux.efi
>>>>=20
>>>> It seems that systemctl successfully identified the UKI from =
systemd-boot, however, kexec could not recognize it.
>>>>=20
>>>> Are there any plans to add UKI support to kexec? Your response is =
greatly appreciated! =20
>>>=20
>>> My colleageus mentioned UKI recently. We have plan to support it, =
while
>>> haven't started to work on that.
>>=20
>> I've looked into UKI recently. In order to provide some base support
>> one should only need to teach kexec_file_load the new file format =
[1].
>> However that still leaves two fundamental issues which limit the
>> usefulness of that support.
>>=20
>> 1) The way I understand it the initrd contained in the UKI is only a
>> stub that is supposed to read further "modules" from disk which
>> together form the initrd needed for the given hardware/system
>> configuration. The problem is that the kexec_file_load syscall only
>> accepts one fd for the kernel and one fd for the initrd. So to =
support
>> multiple modules we would either need to introduce a new syscall or
>> define a uABI that allows to pass multiple initrds via this one fd.
>> Either way it's a new user interface and should be designed with =
care.
>>=20
>> 2) As the kernel command line is part of the UKI and is protected by
>> the signature it cannot be changed by users. So to support kdump with =
a
>> UKI a distro would need to find one crashkernel=3D parameter that =
works
>> for all users which is impossible. Thus before kdump can be supported
>> with UKI there needs to be a  mechanism in place that allows users to
>> edit the command line. Others have the same problem. There is an open
>> issue on github [2] to add this support.
>>=20
>> So all in all I believe there will be kexec support for UKI but I =
don't
>> see it to come anytime soon.
>>=20
>> Thanks
>> Philipp
>>=20
>> [1] ...and kexec-tools if you like to support kexec_load. But as the
>> main use case for UKI is together with Secure Boot I don't think =
that's
>> necessary.
>>=20
>> [2] https://github.com/systemd/systemd/issues/24539
>>=20
>>> I have a testing machine at hand right now, just finished teseting
>>> upstream patches. If you have the detailed steps about how to make =
UKI,
>>> privately or publicly, I can try it now, and see what we can do.
>>=20
>=20



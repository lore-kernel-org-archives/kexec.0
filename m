Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D02F606BD46
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 06:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=A26udsUv;
	dkim=pass (2048-bit key) header.d=multikernel-io.20260707.gappssmtp.com header.i=@multikernel-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JmK4Viuk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=z3Hb/ilx/b4fjyZAOC7azdPBoN2aJE2v6bttuYM0sMY=; b=A26udsUvB/jtXB
	Dn8ufaJOtOc/yes7gC7z0QhF04Ti0uqmeKKMaIZbgNkheHjY2HxfNziTgVSMKenjUFvq9E2Ibyst2
	ymtyEGFd5chsPkf7VphFsV+KzU4g4U2vbkuf9/BD8X4o0K1jN8ZoSqk29AtfSAs0HWQBrsNS1IDEJ
	fy7CfwkKrOGeKTIGJCQeZMQzMki7EO+PPg83EAWYvo6HDVaqW8f1MlnlR5gMaMcwDCpgGvoB5/IPR
	Vb9fb+qJ8XuQ0AZbcTa3cR/RM5Ar18KWu9Z3pm5c0C+2LApi5/61XzOl3fldRF+g5krVWlOXFWUzJ
	PTEYSrVCf9q+LXy1QsXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQfaV-00000002hPM-3GLi;
	Tue, 10 Nov 2026 06:44:11 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQfaS-00000002hOj-2oyH
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 06:44:10 +0000
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-c4d58c50743so58529666b.1
        for <kexec@lists.infradead.org>; Mon, 09 Nov 2026 22:44:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794293046; cv=none;
        d=google.com; s=arc-20260327;
        b=rOX+vzuTvqznEC+vTjMgv9JU130yICpIMHfMUZQXBR710sRD3liBTc9Xfhlw13QoFC
         kKiG93j0wtTiZhTtErFpcrhuxv5Ytl3bWox0DeGj8ANLeVvPJ6yESdvUgag7Z3hLwH35
         Niaw3q9VawsCUuE1K06frntzsZqL0X14Hqh7pZCNhZ7zNXtPSdBVAq5141voa1iJGB8K
         X8ymv7i3jRnk2e648hNRXTP4JuXxsoDFzbpZbC2O8/JubpgiEcUVKRpQtzMCx8+G+EKu
         hFzSBwK0kUS3uq24yyYT/GylL9mkm8200Zqz2YGKW+de/2wWJyzCHoB5xzQCcm1IVDud
         1Yqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z3Hb/ilx/b4fjyZAOC7azdPBoN2aJE2v6bttuYM0sMY=;
        fh=DeXj+kOZx8Dx2AO5pNZrtrpbSZad3oKWDbAMKU0RZFY=;
        b=EHp8FhQryYhzeE7D7p8jDRNLpf0a1r72Wpt12zrNhzA9e4TSQ0uFMJ6VKmi/WyEEhH
         Nw+G1bvMm1WRIv5+uITYBrtHxak3PaG8LJCHBU3O8n4YKWVST/iJRq6QdQjNA8tKJMfb
         Xa6Y2pfd/V7V7h22G04lSuNWvFCmI/gBknShJwvnsegrWkMpD0DJEqYErb1CLThnYKz8
         YAUrEC+1xRJFrUf8Wbp/5hCO12JLSrm/mT8CjUUmFxG6KXc+NAMyl7SU/HpPNseiVn8a
         +ZViu6jMjm/2NW1u/v2KtxcMZA7DHtwJPTe2Z19q6Sdg+5WrL+hKOTxJTousxs89a4BL
         Afrw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20260707.gappssmtp.com; s=20260707; t=1794293046; x=1794897846; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z3Hb/ilx/b4fjyZAOC7azdPBoN2aJE2v6bttuYM0sMY=;
        b=JmK4ViukuzpVQ24p4gg48tN/3vfvbVbtj6m1sMcC6xeUlYGU2xtIv7aWegcAkccu61
         Tu1+l04DY8vxjT0fJHekH9ZtMSX0JuZfkG4miC8TOQVnY7GPurq2guDE8Emx8lh4Zq2p
         oBZM/GByQu7H7iTHbT50SiUUU6mjr83HmdpF3XS0XoKmIhLmxGQsqfon/VV9g6sGqbJq
         afcq8VW+Psf06ovYhQa9jRkQIr7IxGhLFKF6U/Bu8v4J4R8+xfM7q6lTVXm6T5Qnoq4y
         ALCDcp7I+UZp7rCSH457/EnaTKv7IrvqLZE9ocqEAEr1T3K8aZ0kbayu9scbRfHAizN6
         epTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794293046; x=1794897846;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z3Hb/ilx/b4fjyZAOC7azdPBoN2aJE2v6bttuYM0sMY=;
        b=FLcvLHdkOWxfZ1HTDAWXQBR4C8u0b7aAL/vJ/Zk7sePUCjOI7QPba8z//Er/66nSW7
         zNz+T5G9h8jxC6V/Pq6i5e8T4MkHvt4243dhwp5RoLQNDrRS65holR+SJoK7K/qydXvy
         uWl0XiD+kr04lDtuJ/MsSz5byNAfuVQiw0K9US4t/MjPjth+gc+HUBQBhXxVoP88+fX4
         2Ytnbu0nAj42BJiQJtO8AqiyAGsmgI6hImQfMkiiP7LI5qSbbAm1f+D8f3GL+7ReSy/K
         ejiymAxbOf2jp99FqofxtZj0xRTwYLercWrRSf8DJvupqR8Qc3YM1a/l7d6Wxi2krTE4
         MisQ==
X-Gm-Message-State: APuU4Z/98YSc/Oikax2DtRcf9hpXUrXNf3X9wYHLfWlPtmsogUpglqaS
	xC0rW71tXEA/rzCducgwrOmyYZrIv2JEZLU4EEzwtshCBEVZL1ApL5nI02UQ0ho3ZJKSMrEdvyn
	2avfB6W9xCbC/H8FKEkIizV9ew65icNFBECQrFK0b7S4njoFydR4+aiTD1Q==
X-Gm-Gg: AYBFou3B8sCU2znVoE6yXFZfS3eD8Xs4qZmJKJYzMbgjdUplXJ8BNrHQNbT0yJK7wNT
	NhtcJdHZ5O1cJAtoLNmq/QPFui1aXcLH+HlbAFY1gedBs4L9jwhcOriYtYo9y2n48NIs16Ls83V
	ev0q/LMTZQ86QgJfWm8/99CieOUuSDDAdHxeSqXy1Tymqn2dae/PVQ6lFeqQdesrfjJTGXSMjA1
	oDZK+eUcX3u+nMIvwpvPb+Zc2teckaGA99awlnImVOX7P9h3YWpMQzymaexAcvZ/VaqrFfdNQ/1
	t+yofoiecVFYxu8LncAgarJWHqFTFT0YpwsVORo/bxr0tFqB0QdO0LIYd6NpDhoxHOv+AHGVeyg
	n2+p9CVmaI8euEJ0qiwjyNwMyPd7/1I0+7a2mBIcCVz0Slnea349l8YCIxfE2XvUUUtRbFzfeY3
	jIx4Em5aqDkf1oNmOU7AUJf84Y/ZjxZWgkJd/Abzy8KE/H2cU=
X-Received: by 2002:a17:907:3ea8:b0:c46:d837:b358 with SMTP id
 a640c23a62f3a-c504922a4demr124994466b.3.1794293046031; Mon, 09 Nov 2026
 22:44:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261108004716.3828406-1-7z0423arsenova@proton.me>
In-Reply-To: <20261108004716.3828406-1-7z0423arsenova@proton.me>
From: Cong Wang <cwang@multikernel.io>
Date: Mon, 9 Nov 2026 22:43:53 -0800
X-Gm-Features: AclHuK84aRayHJ63zdxJTtuA3kZ57aahgNSGGmfmWS_Wu36kmtAL2yYbd74IWAk
Message-ID: <CAGHCLaRQDEELHFtJNzh-m3jhJGndBQgjGC=ZP0gye73Ch__WKg@mail.gmail.com>
Subject: Re: [kmorph] QEMU test report: takeover OK, a build break, two config traps
To: Yun Wang <7z0423arsenova@proton.me>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_224409_001993_5BA8E35D 
X-CRM114-Status: GOOD (  31.61  )
X-Spam-Score: -1.9 (-)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Yun,

On Sat, Nov 7, 2026 at 4:49=E2=80=AFPM Yun Wang <7z0423arsenova@proton.me> =
wrote:
>
> Hi Cong,
>
> After your announcement [1] I tried multikernel + kmorph in a QEMU/KVM
> guest on x86_64. The takeover itself worked: 10 of 10 runs, with the
> predecessor crashed by sysrq-c. I also hit a build break and two
> configuration traps that the next tester will probably meet; details
> and a fix below.

Thanks for your tests and detailed report.

>
> Tested: multikernel/linux 57fd249 (7.0.0-mk4), kmorph 9ec046e,
> GCC 16.2.1, QEMU 11.1.3 (q35, KVM, 4 vCPUs, 4 GiB). The lines named
> below are unchanged on master (77a05a4), and kmorph main is still
> 9ec046e.
>
> 1) Build break: CONFIG_INTEL_IOMMU=3Dy with CONFIG_IRQ_REMAP=3Dn
>
>      drivers/iommu/intel/iommu.c:2806:35: error: 'struct intel_iommu'
>      has no member named 'ir_table'
>
>    intel_iommu_claim() uses iommu->ir_table unconditionally, but the
>    member only exists under CONFIG_IRQ_REMAP (iommu.h:733).
>    x86_64_defconfig + kvm_guest.config + the MULTIKERNEL options hits
>    it, and so does this one command after "make prepare" on that
>    config:
>
>      make O=3Dbuild drivers/iommu/intel/iommu.o
>
>    The patch below follows the intel_irq_remap_claim() pattern already
>    in iommu.h: a small helper in irq_remapping.c, a stub for
>    !CONFIG_IRQ_REMAP next to the existing one, and iommu.c calls only
>    the helper, so there is no #ifdef in the .c file. checkpatch
>    --strict is clean. With it, the config that failed above builds as
>    a full bzImage (0 errors, 0 warnings), drivers/iommu/intel/ also
>    builds with IRQ_REMAP on, and kmorph takeovers worked on the
>    patched IRQ_REMAP=3Dn kernel in QEMU (10 of 10). QEMU has no vIOMMU
>    here, so intel_iommu_claim() itself did not run. The three files are
>    identical on master (77a05a4), so it applies there as is.

Do you mind submitting a PR here https://github.com/multikernel/linux
for your patch?

(We are not upstream yet, so we still rely on GitHub for collaboration.
That would also reduce noises for upstream too.)


> 2) "kmorph arm" fails with ENOMEM on a 2 GiB x86_64 guest
>
>      Baseline: failed to allocate 132 MB on node -1: -12
>      kmorph: error: pool initialisation failed: Cannot allocate memory
>
>    mk_take_memory() only tries ZONE_MOVABLE and ZONE_NORMAL, and below
>    4 GiB x86_64 has neither: /proc/zoneinfo shows Normal and Movable
>    with present 0, everything is in DMA32. With -m 4G (2 GiB above the
>    PCI hole) "kmorph arm" takes 0.6 to 0.8 s. The README transcript
>    shows 2047 MB of RAM, so a clearer error or a README note would
>    help. I did not try movablecore=3D.

I created a Github issue to track this:
https://github.com/multikernel/kmorph/issues/6

>
> 3) A successor with no boot-time PCI device adopts no PCI function
>
>    Without devices=3D in kmorph.conf the takeover logs
>
>      Failed to move device 0000:00:1f.2: -1
>      kmorphd: adopted 0 devices: 0 reset, 0 quiesced
>
>    From reading the code: mk_pcifront_host_fenced() returns early when
>    the successor has no PCI bus, so mk_pcifront_direct_access stays
>    false and mk_pcifront_adopt_function() returns -EPERM
>    (pcifront.c:150-153 and 704). The same VM with
>    devices=3D0000:01:00.0 instead logs "Host fenced: config space is
>    reached directly through ECAM", adopts three functions, and the
>    e1000e comes up as eth1. Without devices=3D, kmorphd's network
>    restore also waits about 3 s per NIC that never shows up, so
>    panic -> TAKEN_OVER took 6.8 s instead of 0.9 s (7 runs). The
>    README lists devices=3D as optional. This one is also on the kmorph
>    tracker, with the log lines:
>
>      https://github.com/multikernel/kmorph/issues/2

I appreciate it. I fixed it earlier today.

>
> Timing with devices=3D set and the defaults (5 x 100 ms probes), n =3D 10=
,
> min / median / max in seconds on one host clock:
>
>    panic -> fence starts                 0.51 / 0.56 / 0.61
>    fence starts -> TAKEN_OVER            0.29 / 0.34 / 0.39
>    panic -> shell on successor console   0.93 / 0.97 / 1.04
>
> Two more sessions of 10 runs (the second on the patched kernel above)
> gave the same picture: median panic -> TAKEN_OVER 0.91 and 0.90 s.
> The series were run by scripts Claude generated; I also re-ran the
> README commands by hand once (10 of 10, median 0.91 s).
>
> This is a console-only image: no service, no traffic, no real
> hardware, no vIOMMU. It says nothing about the nginx figure.
>
> Two smaller things. kmorphd logs through one /dev/kmsg fd, which the
> kernel rate-limits to 10 lines per 5 s unless printk.devkmsg=3Don, so on
> a default command line "state TAKEN_OVER" never shows. Details:
>
>    https://github.com/multikernel/kmorph/issues/1

Ditto. Fixed.

>
> And the successor boots without a swiotlb ("No low mem": its 128 MB
> are above 4 GiB). I did not test a 32-bit-DMA device after a takeover,
> so that one is a question, not a bug.
>
> The QEMU rig, the logs and the exact commands are available if you
> want them.
>
> [1] https://lore.kernel.org/all/au5M_M_RzWfXLr0T@pop-os.localdomain/
>

Regards,
Cong


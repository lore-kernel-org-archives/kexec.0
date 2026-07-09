Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5848EC43458
	for <kexec@archiver.kernel.org>; Thu,  9 Jul 2026 09:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gR+QAL/WiiMkgGZMsvP1Z/jsw3bpbKqGcBCjnBdyIlc=; b=49JNzrnZnBaRqcOfkuTf1D5c0z
	QLBqyBT3+OhnRvZlRZxq9wAI1AI5Ot17i42TdwAPMq33dr8ERwOtYIazAP+v+NoYPGpfuLTllwkn4
	h8fL5frTlho+PxlZJzlSuPg9N5FDa0JMsLD+OitEs6oCr9G0FDM0lVWg2KGgmwh6dv9LSoSJugV6r
	WyukINM0pQdwAYfP2opB9PwP5zZ/Jp1MOIPREO0w630j0eAfn+l73kr9CeUt/RNI3zwJ7rCrjaZ4Q
	LiduVHUGYWNlCLom6nnlL285Hk6U+D68DMWGmIAJV922vAAPTgdaz4dmegkKCkWOCgDre8lTbUZpo
	XhEYZQFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whkmo-00000001jkd-1Lja;
	Thu, 09 Jul 2026 09:11:14 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whkmn-00000001jjq-0Hm8
	for kexec@lists.infradead.org;
	Thu, 09 Jul 2026 09:11:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 254DC6136D
	for <kexec@lists.infradead.org>; Thu,  9 Jul 2026 09:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE8D1F00A3F
	for <kexec@lists.infradead.org>; Thu,  9 Jul 2026 09:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783588271;
	bh=gR+QAL/WiiMkgGZMsvP1Z/jsw3bpbKqGcBCjnBdyIlc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UwJM8/C6hjL9FBuP7Mj04Euk4+hq4oUTE9BMMQ5Vrq494lvDcRkRnhpAsdKiBKtRW
	 hpPl5qByPHb3iGFnn7haNR7bT51QrRJggMvbPOBLWF4CBPLndJ11Iwo0CES+31bJ4c
	 szj3YBJ3MLDMxuP+859dgFbjPIE2BBbSxuaZ49sLyZvPCQODbjHg67mbX+wPwwgngm
	 0XizsbG2TlimD1jL9Cs/lIhrAoJuc0ooZQPgMl+6REqPnZTNJ6JnEc4SXRKNqjQL1p
	 f5NSbD1JZYqgX+AKMEu0m9Zb+Utzu/JL0gg+BtOIcaZr3PnhFT++3GRY3G9nk2RCSm
	 fMLrWYN0qtL6A==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-698acd36d67so3343291a12.0
        for <kexec@lists.infradead.org>; Thu, 09 Jul 2026 02:11:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqECLmoIIK0vaegV5+xtucRobKC6+USB4k+x+R3i7MGsplwFmgAZelhQGeWGY6kqJdNoeBr9g==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzg474cLmtBJwNyDrxdFRaKghpwGvW5NMja9JKqWAPNlv2GFlwQ
	VpFRaPkS8omk81vm8azLQTOV5d94KfNUIawwA+jqZQRlXOSULifTAVyCgJg1ZQWjzF66KGuy+3v
	PrXuFAliccV6NwwKUVynrJOjf3kzSJXE=
X-Received: by 2002:a05:6402:5d0:b0:698:3365:f950 with SMTP id
 4fb4d7f45d1cf-69ab449d9b1mr2517052a12.21.1783588270450; Thu, 09 Jul 2026
 02:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260701155957.534779-1-dongtai.guo@linux.dev>
In-Reply-To: <20260701155957.534779-1-dongtai.guo@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 9 Jul 2026 17:11:34 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7S9_hPDFoCtzgfY9TeH_koN9NfKq9mo8y9BmLA5-7how@mail.gmail.com>
X-Gm-Features: AUfX_mw-J_OdSnOhcx8hpiENv7LyWcgVB1B-LCMMPWcvWcr0SNfHbuBObPnbLUw
Message-ID: <CAAhV-H7S9_hPDFoCtzgfY9TeH_koN9NfKq9mo8y9BmLA5-7how@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] LoongArch: kexec: avoid clobbering the QEMU FDT
To: George Guo <dongtai.guo@linux.dev>
Cc: maobibo@loongson.cn, loongarch@lists.linux.dev, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, George Guo <guodongtai@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi, George,

On Thu, Jul 2, 2026 at 12:00=E2=80=AFAM George Guo <dongtai.guo@linux.dev> =
wrote:
>
> This series fixes two ways the LoongArch kexec path can clobber the
> firmware-provided FDT that QEMU places at physical 0x100000, which made t=
he
> second kernel boot silently (earlycon auto-detection reads a corrupted FD=
T).
>
> Patch 1 moves the relocation trampoline off the hardcoded 0x100000 onto t=
he
> kexec core's control_code_page (as arm64/riscv do), so machine_kexec_prep=
are()
> no longer overwrites the FDT.
>
> Patch 2 removes the remaining fixed command-line address (KEXEC_CMDLINE_A=
DDR,
> 0x108000).  QEMU's machine FDT declares fdt_totalsize =3D 1MB and thus cl=
aims the
> whole [0x100000, 0x200000) upper half of the reserved 2MB, so 0x108000 li=
ves
> inside the FDT and only survives because the FDT's real content is small
> (~3.6KB) and 0x108000 falls in the trailing slack.  The command line is p=
assed
> to the second kernel in register a1, not at a fixed address, so it is loa=
ded
> into its own kexec segment instead, removing the overlap regardless of FD=
T
> size.
>
> This addresses the two questions raised on the v3 trampoline patch [1]:
>  - "how to avoid the cmdline overlapping FDT" -> patch 2.
>  - "how to avoid the control page being corrupted by the new kernel" -> t=
he
>    trampoline is executed only by the current kernel and is dead once the=
 new
>    kernel starts, so being overwritten afterwards is harmless; the kexec =
core
Who told you the trampoline is dead code? All non-boot CPUs are
running in the trampoline, you can use maxcpus=3D1 to go to the new
kernel, and do something, and then hotplug the non-boot CPUs at any
time.

The trampoline should live all the time for safety, ARM and RISC-V
both have the trouble, especially when memory is small.

And I don't want to hear "If others can do something but LoongArch
can't, then LoongArch has a drawback; if others can't do something but
LoongArch can, then it is useless".

BTW,  you have never replied to my comments, all you have done is
submit new versions again and again. Who told you to do things like
this? You want to take your ill code again and again, or your employer
counts the number of your E-mails in the mailist as the amount of your
work?



Huacai

>    also keeps the control page outside every relocation destination, so i=
t
>    cannot be corrupted during relocation.  The command line is different =
(it is
>    read by the new kernel), which is why only the trampoline uses the cor=
e page.
>
> Tested with tools/testing/selftests/kho/vmtest.sh on LoongArch (QEMU,
> kexec_file_load): the second kernel boots with the full command line and
> earlycon, and KHO restore succeeds.
>
> This series depends on [2] ("LoongArch: kexec: Fix address space mismatch=
 in
> command line lookup"), whose char head[] change patch 2 builds on.
>
> [1] https://lore.kernel.org/all/20260604114106.391502-1-dongtai.guo@linux=
.dev/
> [2] https://lore.kernel.org/all/20260701023747.56221-1-dongtai.guo@linux.=
dev/
>
> Changes in v4:
>  - Add patch 2: load the command line in its own kexec segment, dropping =
the
>    fixed KEXEC_CMDLINE_ADDR that overlaps the QEMU FDT (addresses the com=
mand
>    line concern from the v3 review).
>  - Patch 1 (relocation trampoline): drop the KEXEC_CMDLINE_ADDR comment a=
dded
>    in v3 that claimed 0x108000 does not overlap the FDT (it does; patch 2
>    removes the fixed address entirely).  No functional change otherwise.
>
> v3: https://lore.kernel.org/all/20260604114106.391502-1-dongtai.guo@linux=
.dev/
> v2: https://lore.kernel.org/all/20260601033820.38805-1-dongtai.guo@linux.=
dev/
> v1: https://lore.kernel.org/all/20260528135828.196953-1-dongtai.guo@linux=
.dev/
>
> George Guo (2):
>   LoongArch: kexec: use core control page for relocation trampoline to
>     avoid QEMU FDT conflict
>   LoongArch: kexec: load the command line in its own segment
>
>  arch/loongarch/include/asm/kexec.h         |  1 +
>  arch/loongarch/kernel/machine_kexec.c      | 38 ++++++++++------------
>  arch/loongarch/kernel/machine_kexec_file.c | 33 +++++++++++++++++--
>  3 files changed, 49 insertions(+), 23 deletions(-)
>
> --
> 2.25.1
>


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47AC7C3600B
	for <kexec@archiver.kernel.org>; Thu, 27 Mar 2025 21:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2pn8dpSd2+6jO547scpNtzYqkdq0JQ+NnUDA5CXJOJM=; b=Q8UbOfmepLVTi7n/nrgY2DLWB2
	iaQ6JltmOPYurRUfLoGl7fPxvXH/AoOCkreMF55KHpTp3+kr9SapveW5N+vaQVkeW8w5X+j0yH20I
	4264cJDJIW6oYXowKEXG2GZB57b70sjygdPGHS2P+79sPMEyJLqpwzJz07CVUikyxA2kNJ5xKODAY
	++yYI35dhKAz4byVBiOPYy6r16D+ZUEpJatZ9cJ/R7LlefPK+MkSKtxGlJI96zCot0pOXKHdozWUU
	Z7n24aYOxP9NVy7GG5mRng7JsQ2r+SB9B9ZJFRxMLxAv87hFpUNL9/c5mP6Lz/aS2b8REoUtnhgWT
	oOqthK/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txufO-0000000C3xJ-2GSY;
	Thu, 27 Mar 2025 21:21:34 +0000
Received: from mail-out.m-online.net ([212.18.0.9])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txufI-0000000C3wo-3T4L
	for kexec@lists.infradead.org;
	Thu, 27 Mar 2025 21:21:30 +0000
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4ZNxRV6bXWz1r4pg
	for <kexec@lists.infradead.org>; Thu, 27 Mar 2025 22:21:25 +0100 (CET)
X-Auth-Info: ON6LIjMJ5J+YcJZMQ/CjYm15Kj4lbNIEeRYLB1XbA67eRtTZh8xn229yegm7XMhw
Received: from localhost (aftr-82-135-83-39.dynamic.mnet-online.de [82.135.83.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA id 4ZNxRT5YmNz1qqm7
	for <kexec@lists.infradead.org>; Thu, 27 Mar 2025 22:21:25 +0100 (CET)
Date: Thu, 27 Mar 2025 22:21:24 +0100
From: Matthias Gerstner <matthias.gerstner@nefkom.net>
To: kexec@lists.infradead.org
Subject: kexec: locate_hole failed regression since v2.0.27
Message-ID: <Z-XBVNHIE2744opA@q910.gerrit.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cOX02+ZLDprT350p"
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250327_142129_154373_CB4123D3 
X-CRM114-Status: GOOD (  14.02  )
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


--cOX02+ZLDprT350p
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Date: Thu, 27 Mar 2025 22:21:24 +0100
From: Matthias Gerstner <matthias.gerstner@nefkom.net>
To: kexec@lists.infradead.org
Subject: kexec: locate_hole failed regression since v2.0.27

Hello list,

I just stumbled over whats looks like a regression in `kexec -l <kernel>`
that was introduced in release v2.0.27. I'm using kexec on amd64 in an initrd
context and made a bigger jump from v2.0.20 to v2.0.30. After that kexec
failed with:

```
$ kexec -l /path/to/kernel
Could not find a free area of memory of 0x9000 bytes...
locate_hole failed
```

I can also reproduce the error on my regulaer desktop system, however, so it
is not specific to the initrd scenario.

I digged a bit deeper and found that the regression was introduced via commit
29fe5067ed07, which implies the `-a` / `--kexec-syscall-auto` option. In the
debugger I see that `info->memory_ranges` is 0 and `get_memory_ranges()` was
never called when `locate_hole()` is executed. When running `kexec -c -l
/path/to/kernel` then everything works as before.

Here is a `gdb` backtrace from the spot where the error pops up:

    Breakpoint 2, locate_hole (info=0x7fffffffd690, hole_size=36864, hole_align=4096, hole_min=12288,
        hole_max=655360, hole_end=-1) at kexec/kexec.c:314
    314                     fprintf(stderr, "Could not find a free area of memory of "
    (gdb) p *info
    $2 = {segment = 0x0, nr_segments = 0, memory_range = 0x0, memory_ranges = 0, crash_range = 0x0,
      nr_crash_ranges = 0, entry = 0x0, rhdr = {ei_class = 2, ei_data = 1, e_type = 1, e_machine = 62, e_version = 1,
        e_flags = 0, e_phnum = 0, e_shnum = 17, e_shstrndx = 16, e_entry = 1872, e_phoff = 0, e_shoff = 35104,
        e_notenum = 1, e_phdr = 0x0, e_shdr = 0x55555566b5d0, e_note = 0x55555566baa0, rel_addr = 0, rel_size = 0},
      backup_start = 0, kexec_flags = 0, backup_src_start = 0, backup_src_size = 0, file_mode = 1, kernel_fd = -1,
      initrd_fd = -1, command_line = 0x0, command_line_len = 0, skip_checks = 0, elfcorehdr = 0}
    (gdb) bt
    #0  locate_hole (info=0x7fffffffd690, hole_size=36864, hole_align=4096, hole_min=12288, hole_max=655360,
        hole_end=-1) at kexec/kexec.c:314
    #1  0x000055555555bdaa in add_buffer_phys_virt (info=0x7fffffffd690, buf=0x55555566c640, bufsz=28896,
        memsz=36864, buf_align=4096, buf_min=12288, buf_max=655360, buf_end=-1, phys=0) at kexec/kexec.c:396
    #2  0x000055555555be46 in add_buffer_virt (info=0x7fffffffd690, buf=0x55555566c640, bufsz=28896, memsz=36864,
        buf_align=4096, buf_min=12288, buf_max=655360, buf_end=-1) at kexec/kexec.c:410
    #3  0x000055555556796c in add_buffer (info=0x7fffffffd690, buf=0x55555566c640, bufsz=28896, memsz=36864,
        buf_align=4096, buf_min=12288, buf_max=655360, buf_end=-1) at kexec/add_buffer.c:12
    #4  0x0000555555562243 in elf_rel_load (ehdr=0x7fffffffd6c8, info=0x7fffffffd690, min=12288, max=655360, end=-1)
        at kexec/kexec-elf-rel.c:259
    #5  0x0000555555562a91 in elf_rel_build_load (info=0x7fffffffd690, ehdr=0x7fffffffd6c8,
        buf=0x555555580a40 <purgatory> "\177ELF\002\001\001", len=36192, min=12288, max=655360, end=-1, flags=0)
        at kexec/kexec-elf-rel.c:436
    #6  0x000055555556894c in do_bzImage_load (info=0x7fffffffd690,
        kernel=0x7ffff7464010 '\377' <repeats 200 times>..., kernel_len=8655872, command_line=0x55555566b5b0 "",
        command_line_len=1, initrd=0x0, initrd_len=0, dtb=0x0, dtb_len=0, real_mode_entry=0)
        at kexec/arch/i386/kexec-bzImage.c:211
    #7  0x00005555555694ec in bzImage_load (argc=3, argv=0x7fffffffd958,
        buf=0x7ffff7464010 '\377' <repeats 200 times>..., len=8655872, info=0x7fffffffd690)
        at kexec/arch/i386/kexec-bzImage.c:467
    #8  0x000055555555e269 in do_kexec_file_load (fileind=2, argc=3, argv=0x7fffffffd958, flags=0)
        at kexec/kexec.c:1367
    #9  0x000055555555ed65 in main (argc=3, argv=0x7fffffffd958) at kexec/kexec.c:1758

I'm not sure how the collection of the memory ranges is supposed to work in
this context. The kernel I'm running does have CONFIG_KEXEC_FILE=y set in any
case. I'm also not seeing any relevant failed system calls until the error is
hit.

Regards

Matthias

--cOX02+ZLDprT350p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEQMifAG+4oyi4OjfMFK1vZXkJcoQFAmflwVQACgkQFK1vZXkJ
coRnpQ/+KQQ4L1Ut6LtblntnmanPCrXZ4/3ODoX4hSCgCI1S65Tk48Sg0tYkIo89
RuALS5tkfaJePiE3a3eXwpZ7l8u/kwOOeQdiemsCSQnamxAG3/cbbgk02Tc3F8qG
/dkKDj5BT452JFvTX+40ddezd1H9AqqjFYmDp5weQxtmZPkR7ayd7Qs0WnXYGZtI
IcuX1lzV57K4oNk03IukDziZHJWf4vC1QaAKyAO3DCC6DQWAnPv//PNl8T929mr1
VQsMY9BLtI8Q5Ums3hFBSkC9KhEvYZMSR6/UT1tK3FxikexZVi1Fx6K32v/Xhs3c
IVMgCZG7/QsfH6Gq0X/4Fy8/n2v6eGc8s67CvHztCvI1lZFOnG934koPB3mpe1ER
yIG+PBNmGysu7ogud3n65Ly9NwmsfUChFVuZFTiKuuF7OyMq5/Oe/ixqTjfur+jA
Cdq1BtDOT5Ot7lsTI6LB0xpPeQM1Sqplot8RRw1WpwH+i8K7Y9g7jtkjJUmET6ZA
u6WMCEF27Y87mvtqW2PsqTuBb8aIGg3H2z5z8gcaCeusLUNb2ULSXhz9pnyvYeMJ
5Uh42kP8Dy0p7yyUykURMS4X+qhqHQrU3HG/23JXZlnPkC37TGYc0qgt0A7+hUZK
tIncInYQEQRSBUMAz38wme5QEoQy9nUvEGKua5AY7OEJQnH0WHg=
=vqny
-----END PGP SIGNATURE-----

--cOX02+ZLDprT350p--


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB0D1073CA5
	for <kexec@archiver.kernel.org>; Wed,  8 Apr 2026 12:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:From:To:Subject:Message-Id:
	Date:Content-Type:Content-Transfer-Encoding:Mime-Version:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KfTNmYa3LP5ZjwRxlWCLHoSF5NUmyiGhtzguuu39KnU=; b=WfvHR4RckX8ifzZjR0qcSmvrCD
	Et61iy6bbSNiljFG4Fu638YH3mH1vG1vlwMcJaY/uAsxEajVvbGhG31W4ZKB6lnrZBdHetPGeY/Ve
	iAYzGvanAfHR3WzR0tW8Iu1M5F/RvL0HbSMLzS7dsz7Wq3rdU2Zs+Phy/a3Y+ZKNcN8QYR44ylAXg
	kpceM5qxCOfnbYg5Q4OQVpIBCzaa+yfAIV2EnynC7wEGHLi7O0qUachzX5uDXwxdpZo3MN3UTn585
	Q+KL7aoOKPDQ5W2+kfEVIVakkNNOw9ehSTWP4GE3ihR3hOjmT/SAfX+G6qjdwkssIYomZIPgylo34
	/FTFQ8SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wARtG-00000008omP-2BvY;
	Wed, 08 Apr 2026 12:20:14 +0000
Received: from mx-02.verkligendata.se ([91.223.231.12])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wARtC-00000008olQ-3VYo
	for kexec@lists.infradead.org;
	Wed, 08 Apr 2026 12:20:12 +0000
Authentication-Results: madvise.sigsum.org;
	dkim=pass (2048-bit key; secure) header.d=glasklarteknik.se header.i=@glasklarteknik.se header.a=rsa-sha256 header.s=dkim header.b=aQf8gFag;
	dkim-atps=neutral
Received: from mail-01.sigsum.org (mail-01.sigsum.org [46.227.66.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mail-01.sigsum.org", Issuer "R13" (not verified))
	by madvise.sigsum.org (Postfix) with ESMTPS id 508B07FF46
	for <kexec@lists.infradead.org>; Wed,  8 Apr 2026 14:20:00 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 131D8BFAE9
	for <kexec@lists.infradead.org>; Wed,  8 Apr 2026 14:19:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glasklarteknik.se;
	s=dkim; t=1775650799; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding; bh=KfTNmYa3LP5ZjwRxlWCLHoSF5NUmyiGhtzguuu39KnU=;
	b=aQf8gFagxesUVwqHNoqwQ1AnIgqupdMCokEblXRpIKZyj1rkKhCj8IW666RLMtaYN3wE8L
	6cIuyeYIbO1M3drdt7IEftYtmAzA4ZIskevkBLqC0iKFKJDEeipDRaUsvjaKiKbHV84/MR
	I97UzJgFjCuAFHbqHoKV+6cVPq16I1AT+YyDiUtTSGQRyNfIGWgMHzGUcX4ge9TOJ1xMoZ
	PJPMnALwVl52p2oHsiMO8HWAWZafa/kK+9ez3kdB2QV+SxKpulai+UF9c8buTzI/xpUpMF
	Bf5SzoeOln7AO8VvZOMZMrb35lVcU/ptalKnyX6F5dp7usIp/Cubgz/8MsHITQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Apr 2026 14:19:56 +0200
Message-Id: <DHNROAISY87U.1KKR1293WLMN5@glasklarteknik.se>
Subject: consistent kexec crash on specific HP server
To: <kexec@lists.infradead.org>
From: "Daniel Lublin" <daniel@glasklarteknik.se>
X-Mailer: aerc 0.21.0-0-g5549850facc2
X-Last-TLS-Session-Version: TLSv1.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_052011_460979_596E60A8 
X-CRM114-Status: GOOD (  11.43  )
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


Hello,

We are seeing a reproducible kexec crash on specific hardware, and would
appreciate any pointers on what is going wrong, how this could be
debugged further etc.

Hardware: HP ProLiant BL460c Gen9, BIOS I36 05/17/2022
With 2x Intel Xeon CPU E5-2667 v4 @ 3.20GHz ("Broadwell EP")

kexec consistently fails on this platform. The system hangs hard or
reboots upon kexec. This happens both when doing kexec from our
bootloader stboot in Go, and when using kexec-tools (2.0.29).

The crash has been observed on all 3 machines of this exact model that
it has been tested on. kexec has not been successfully run on this exact
model; but we run kexec on various other server models.

Various kernel have been tried.

- custom 6.12.x (relatively small, all built-in, no kmods), with our
  stboot-go doing kexec
- kernel 6.6.15 from Debian bookworm, and userspace, kexec-tools based
  on it
- kernel 6.12.61 from System Rescue iso, with its userspace etc

When using kexec-tools, the procedure has been:

    kexec -d -l /kernel --initrd=3D/initrd
    kexec -d -e

With crash happening on `kexec -e`.

Observed behaviour upon crashing has varied; sometimes immediate reboot,
sometimes hang followed by reboot.

When using the Debian kernel we had one more verbose crash. I managed to
take some screenshots of the remote servers console, and the ocr:d text
(so not 100%) follows below.

Thank you for any advice!

...
E820 memmap:
0000000000000400-0000000000092fff (1)
0000000000093000-0000000000093fff (2)
0000000000094000-000000000009ffff (1)
0000000000100000-0000000062e60fff (1)
0000000062e61000-000000006b460fff (2)
000000006b461000-000000006b461fff (1)
000000006b462000-000000006b4e2fff (2)
000000006b4e3000-00000000784fefff (1)
00000000784ff000-00000000791fefff (2)
00000000791ff000-000000007b5fefff (4)
000000007b5ff000-000000007b7fefff (3)
000000007b7ff000-000000007b7fffff (1)
0000000080000000-000000008fffffff (2)
0000000100000000-000000187fffffff (1)
/sys/firmware/edd does not exist.
kexec_load: entry =3D 0x187fff7730 flags =3D 0x3e0000
nr_segments =3D 7
segment[0].buf   =3D 0x56152e71e680
segment[0].bufsz =3D 0x70
segment[0].mem   =3D 0x100000
segment[0].memsz =3D 0x1000
segment[1].buf   =3D 0x56152e7266c0
segment[1].bufsz =3D 0xc8
segment[1].mem   =3D 0x101000
segment[1].memsz =3D 0x1000
segment[2].buf   =3D 0x56152e71ec10
segment[2].bufsz =3D 0x30
segment[2].mem   =3D 0x102000
segment[2].memsz =3D 0x1000
segment[3].buf   =3D 0x7f0dab1c1010
segment[3].bufsz =3D 0x6929f5
segment[3].mem   =3D 0x187c36d000
segment[3].memsz =3D 0x693000
segment[4].buf   =3D 0x7f0dab858010
segment[4].bufsz =3D 0x8e2800
segment[4].mem   =3D 0x187ca00000
segment[4].memsz =3D 0x359c000
segment[5].buf   =3D 0x56152e718fe0
segment[5].bufsz =3D 0x404d
segment[5].mem   =3D 0x187fff2000
segment[5].memsz =3D 0x5000
segment[6].buf   =3D 0x56152e711d60
segment[6].bufsz =3D 0x70e0
segment[6].mem   =3D 0x187fff7000
segment[6].memsz =3D 0x9000
sleeping 3 before kexec
sleeping 3 before kexec
[   20.486015] pcieport 0000:00:1c.7: Enabling MPC IRBNCE
[   20.490565] pcieport 0000:00:1c.7: Intel PCH root port ACS workaround en=
abled
[   20.508324] pcieport 0000:00:1c.6: Enabling MPC IRBNCE
[   20.513781] pcieport 0000:00:1c.6: Intel PCH root port ACS workaround en=
abled
[   20.530010] pcieport 0000:00:1c.4: Enabling MPC IRBNCE
[   20.535828] pcieport 0000:00:1c.4: Intel PCH root port ACS workaround en=
abled
[   20.554003] pcieport 0000:00:1c.0: Enabling MPC IRBNCE
[   20.560203] pcieport 0000:00:1c.0: Intel PCH root port ACS workaround en=
abled
[   21.157711] {1}[Hardware Error]: Hardware error from APEI Generic Hardwa=
re Error Source: 1
[   21.157717] {1}[Hardware Error]: event severity: fatal
[   21.157721] {1}[Hardware Error]:  Error 0, type: fatal
[   21.157725] {1}[Hardware Error]:   section_type: PCIe error
[   21.157727] {1}[Hardware Error]:   port_type: 4, root port
[   21.157730] {1}[Hardware Error]:   version: 1.16
[   21.157734] {1}[Hardware Error]:   command: 0x6010, status: 0x0143
[   21.157737] {1}[Hardware Error]:   device_id: 0000:00:02.2
[   21.157741] {1}[Hardware Error]:   slot: 0
[   21.157743] {1}[Hardware Error]:   secondary_bus: 0x07
[   21.157746] {1}[Hardware Error]:   vendor_id: 0x8086, device_id: 0x6f06
[   21.157749] {1}[Hardware Error]:   class_code: 000604
[   21.157753] {1}[Hardware Error]:   bridge: secondary_status: 0x2000, con=
trol: 0x0003
[   21.157755] {1}[Hardware Error]:   aer_uncor_status: 0x00100000, aer_unc=
or_mask: 0x00000000
[   21.157757] {1}[Hardware Error]:   aer_uncor_severity: 0x00062030
[   21.157759] {1}[Hardware Error]:   TLP Header: 00000001 0700000f 791de06=
c 00000000
[   21.157762] {1}[Hardware Error]:  Error 1, type: fatal
[   21.157764] {1}[Hardware Error]:   section_type: PCIe error
[   21.157766] {1}[Hardware Error]:   port_type: 4, root port
[   21.157767] {1}[Hardware Error]:   version: 1.16
[   21.157768] {1}[Hardware Error]:   command: 0x6010, status: 0x0143
[   21.157770] {1}[Hardware Error]:   device_id: 0000:00:02.2
[   21.157772] {1}[Hardware Error]:   slot: 0
[   21.157773] {1}[Hardware Error]:   secondary_bus: 0x07
[   21.157774] {1}[Hardware Error]:   vendor_id: 0x8086, device_id: 0x6f06
[   21.157776] {1}[Hardware Error]:   class_code: 000604
[   21.157777] {1}[Hardware Error]:   bridge: secondary_status: 0x2000, con=
trol: 0x0003
[   21.157778] {1}[Hardware Error]:   aer_uncor_status: 0x00100000, aer_unc=
or_mask: 0x00000000
[   21.157780] {1}[Hardware Error]:   aer_uncor_severity: 0x00062030
[   21.157782] {1}[Hardware Error]:   TLP Header: 00000001 0700000f 791de06=
c 00000000
[   21.157787] Kernel panic - not syncing: Fatal hardware error!
[   21.157790] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.6.15-amd64 #1  D=
ebian 6.6.15-2
[   21.157795] Hardware name: HP ProLiant BL460c Gen9, BIOS I36 05/17/2022
[   21.157798] Call Trace:
[   21.157803]  <NMI>
[   21.157807]  dump_stack_lvl+0x47/0x60
[   21.157823]  panic+0x180/0x330
[   21.157833]  __ghes_panic+0x67/0x70
[   21.157843]  ghes_notify_nmi+0x1e1/0x390
[   21.157850]  nmi_handle+0x61/0x150
[   21.157862]  default_do_nmi+0x40/0x100
[   21.157874]  exc_nmi+0x139/0x1c0
[   21.157879]  end_repeat_nmi+0x16/0x67
[   21.157887] RIP: 0010:intel_idle+0x62/0xb0
[   21.157896] Code: 48 89 d1 65 48 8b 04 25 00 2c 03 00 0f 01 c8 48 8b 00 =
a8 08 75 14 66 90 0f 00 2d e5 18 50 00 b9 01 00 00 00
 48 89 f8 0f 01 c9 <65> 48 8b 04 25 00 2c 03 00 f0 80 60 02 df f0 83 44 24 =
fc 00 48 8b
[   21.157900] RSP: 0000:ffffffffa4603e30 EFLAGS: 00000046
[   21.157905] RAX: 0000000000000020 RBX: ffffe8f3fea30ad0 RCX: 00000000000=
00001
[   21.157908] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 00000000000=
00020
[   21.157910] RBP: 0000000000000004 R08: 0000000000000002 R09: 00000000000=
02459
[   21.157913] R10: 0000000000000018 R11: ffff888c4fa31fe4 R12: ffffffffa47=
9a500
[   21.157915] R13: ffffffffa479a6b8 R14: 0000000000000004 R15: 00000000000=
00000
[   21.157920]  ? intel_idle+0x62/0xb0
[   21.157925]  ? intel_idle+0x62/0xb0
[   21.157929]  </NMI>
[   21.157931]  <TASK>
[   21.157932]  cpuidle_enter_state+0x84/0x440
[   21.157938]  cpuidle_enter+0x2d/0x40
[   21.157951]  do_idle+0x20d/0x270
[   21.157961]  cpu_startup_entry+0x2a/0x30
[   21.157967]  rest_init+0xd0/0xd0
[   21.157973]  arch_call_rest_init+0xe/0x30
[   21.157986]  start_kernel+0x4de/0x790
[   21.157994]  x86_64_start_reservations+0x18/0x30
[   21.158002]  x86_64_start_kernel+0x96/0xa0
[   21.158007]  secondary_startup_64_no_verify+0x18f/0x19b
[   21.158019]  </TASK>
[   21.158072] Kernel Offset: disabled
[   22.099458] ERST: [Firmware Warn]: Firmware does not respond in time.
[   22.099462] pstore: backend (erst) writing error (-5)

--=20
Daniel


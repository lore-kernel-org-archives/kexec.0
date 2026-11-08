Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6926F606A331
	for <kexec@archiver.kernel.org>; Sun,  8 Nov 2026 00:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Mm/6iDWT;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=ex6ux7odynbm3d3bieiceub7qm.protonmail2 header.b=rjuH4+CM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:From:To:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=miYEEFkV8Z9i/2WhkZJGbAnT2PZHJfO76Fege8iJvSk=; b=Mm/6iDWTiVSgb2Dd1KtdVS2s4P
	x47hZJEaOoIPUNjGFYACjBleUUYiCJjEJbPIODvEuPNUkUwL5sLFo7muLzpITgID37Nt8inmMyDu5
	vAs8LL+deBxtD31OXHNbe2CPn1Hhb+E8ctnhyqmWpQ0QT955qXSGhPBmeS9sSzTjnm9loc/29GB6c
	YCt7w+9dxJs40s8QEh6kMkDoh+9Gt7oe87hvEpAxGVJ1tlbWM3u0pmavOrVn5hO+TSbO19pguKpfO
	O4WviBbtyOrJdAHMQc3w+p/x+905+15Hhde3MnBktUSclvJO9xDogfn54IziZ+PBHQ8jhMBSlVREg
	aRiFaGMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPr6M-0000000FYqf-2AtG;
	Sun, 08 Nov 2026 00:49:42 +0000
Received: from mail-43101.protonmail.ch ([185.70.43.101])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPr6I-0000000FYqI-1rKI
	for kexec@lists.infradead.org;
	Sun, 08 Nov 2026 00:49:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ex6ux7odynbm3d3bieiceub7qm.protonmail2; t=1794098973;
	x=1794358173; bh=miYEEFkV8Z9i/2WhkZJGbAnT2PZHJfO76Fege8iJvSk=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=rjuH4+CMOxjvkJtxk5T3cPqA+hWog5zbhsiunsiTk6KP5CDu6Ts7//q2IFKfrHSaH
	 axhY4DX7/x0nkBsJ4uKg+3x91maZTMHHNZZA2m4bboG3MPBLGg6lrcUTtyB/FbPbbd
	 RPhWUm/9HLK+I7HvukYX6MHpeBsQxJ/DeKA3P1tax2KgmuHLDgzzwmDPBX2Tff31Wx
	 2zamqDJAAPkstFd26trhlynV6g21bxA4Q0LSLJLdTRUnCjleWCnrqu0+H4KCfw66mi
	 Mm1lELCU099/HwHFi96t6jalQVwtg9J8Khxh/oapMaq+1SXf1nHJNrKlf1g2S3MD8b
	 PLwcL9kswAMNg==
Date: Sun, 08 Nov 2026 00:49:29 +0000
To: Cong Wang <cwang@multikernel.io>
From: Yun Wang <7z0423arsenova@proton.me>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [kmorph] QEMU test report: takeover OK, a build break, two config traps
Message-ID: <20261108004716.3828406-1-7z0423arsenova@proton.me>
Feedback-ID: 227066774:user:proton
X-Pm-Message-ID: 6e9de18d4efdc9a5741a003cdf1f8a901846ef61
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261107_164939_151233_18FAF4FF 
X-CRM114-Status: GOOD (  15.32  )
X-Spam-Score: -2.8 (--)
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
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Cong,

After your announcement [1] I tried multikernel + kmorph in a QEMU/KVM
guest on x86_64. The takeover itself worked: 10 of 10 runs, with the
predecessor crashed by sysrq-c. I also hit a build break and two
configuration traps that the next tester will probably meet; details
and a fix below.

Tested: multikernel/linux 57fd249 (7.0.0-mk4), kmorph 9ec046e,
GCC 16.2.1, QEMU 11.1.3 (q35, KVM, 4 vCPUs, 4 GiB). The lines named
below are unchanged on master (77a05a4), and kmorph main is still
9ec046e.

1) Build break: CONFIG_INTEL_IOMMU=3Dy with CONFIG_IRQ_REMAP=3Dn

     drivers/iommu/intel/iommu.c:2806:35: error: 'struct intel_iommu'
     has no member named 'ir_table'

   intel_iommu_claim() uses iommu->ir_table unconditionally, but the
   member only exists under CONFIG_IRQ_REMAP (iommu.h:733).
   x86_64_defconfig + kvm_guest.config + the MULTIKERNEL options hits
   it, and so does this one command after "make prepare" on that
   config:

     make O=3Dbuild drivers/iommu/intel/iommu.o

   The patch below follows the intel_irq_remap_claim() pattern already
   in iommu.h: a small helper in irq_remapping.c, a stub for
   !CONFIG_IRQ_REMAP next to the existing one, and iommu.c calls only
   the helper, so there is no #ifdef in the .c file. checkpatch
   --strict is clean. With it, the config that failed above builds as
   a full bzImage (0 errors, 0 warnings), drivers/iommu/intel/ also
   builds with IRQ_REMAP on, and kmorph takeovers worked on the
   patched IRQ_REMAP=3Dn kernel in QEMU (10 of 10). QEMU has no vIOMMU
   here, so intel_iommu_claim() itself did not run. The three files are
   identical on master (77a05a4), so it applies there as is.

Signed-off-by: Yun Wang <7z0423arsenova@proton.me>

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7cec65cf5..d28928abe 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2802,8 +2802,8 @@ int intel_iommu_claim(u64 base)
 =09up_write(&dmar_global_lock);
=20
 =09iommu_pmu_register(iommu);
-=09pr_info("%s: claimed; DMA translated%s by this kernel\n",
-=09=09iommu->name, iommu->ir_table ? " and interrupts remapped" : "");
+=09pr_info("%s: claimed; DMA translated%s by this kernel\n", iommu->name,
+=09=09intel_irq_remap_active(iommu) ? " and interrupts remapped" : "");
 =09return 0;
=20
 out_unlock:
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index ad6c2287c..005bec130 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1222,10 +1222,16 @@ static inline bool dmar_unit_foreign(struct intel_i=
ommu *iommu)
=20
 #ifdef CONFIG_IRQ_REMAP
 void intel_irq_remap_claim(struct intel_iommu *iommu);
+bool intel_irq_remap_active(struct intel_iommu *iommu);
 #else
 static inline void intel_irq_remap_claim(struct intel_iommu *iommu)
 {
 }
+
+static inline bool intel_irq_remap_active(struct intel_iommu *iommu)
+{
+=09return false;
+}
 #endif
=20
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_=
remapping.c
index 9e5042fdb..a5aa32d1c 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1205,6 +1205,17 @@ void intel_irq_remap_claim(struct intel_iommu *iommu=
)
 =09raw_spin_unlock_irqrestore(&irq_2_ir_lock, flags);
 }
=20
+/**
+ * intel_irq_remap_active - Whether interrupts are remapped through a unit
+ * @iommu: the DMAR unit
+ *
+ * Return: true when @iommu has an interrupt remapping table.
+ */
+bool intel_irq_remap_active(struct intel_iommu *iommu)
+{
+=09return !!iommu->ir_table;
+}
+
 static struct intel_iommu *remapping_unit(u64 base)
 {
 =09struct dmar_drhd_unit *drhd;

2) "kmorph arm" fails with ENOMEM on a 2 GiB x86_64 guest

     Baseline: failed to allocate 132 MB on node -1: -12
     kmorph: error: pool initialisation failed: Cannot allocate memory

   mk_take_memory() only tries ZONE_MOVABLE and ZONE_NORMAL, and below
   4 GiB x86_64 has neither: /proc/zoneinfo shows Normal and Movable
   with present 0, everything is in DMA32. With -m 4G (2 GiB above the
   PCI hole) "kmorph arm" takes 0.6 to 0.8 s. The README transcript
   shows 2047 MB of RAM, so a clearer error or a README note would
   help. I did not try movablecore=3D.

3) A successor with no boot-time PCI device adopts no PCI function

   Without devices=3D in kmorph.conf the takeover logs

     Failed to move device 0000:00:1f.2: -1
     kmorphd: adopted 0 devices: 0 reset, 0 quiesced

   From reading the code: mk_pcifront_host_fenced() returns early when
   the successor has no PCI bus, so mk_pcifront_direct_access stays
   false and mk_pcifront_adopt_function() returns -EPERM
   (pcifront.c:150-153 and 704). The same VM with
   devices=3D0000:01:00.0 instead logs "Host fenced: config space is
   reached directly through ECAM", adopts three functions, and the
   e1000e comes up as eth1. Without devices=3D, kmorphd's network
   restore also waits about 3 s per NIC that never shows up, so
   panic -> TAKEN_OVER took 6.8 s instead of 0.9 s (7 runs). The
   README lists devices=3D as optional. This one is also on the kmorph
   tracker, with the log lines:

     https://github.com/multikernel/kmorph/issues/2

Timing with devices=3D set and the defaults (5 x 100 ms probes), n =3D 10,
min / median / max in seconds on one host clock:

   panic -> fence starts                 0.51 / 0.56 / 0.61
   fence starts -> TAKEN_OVER            0.29 / 0.34 / 0.39
   panic -> shell on successor console   0.93 / 0.97 / 1.04

Two more sessions of 10 runs (the second on the patched kernel above)
gave the same picture: median panic -> TAKEN_OVER 0.91 and 0.90 s.
The series were run by scripts Claude generated; I also re-ran the
README commands by hand once (10 of 10, median 0.91 s).

This is a console-only image: no service, no traffic, no real
hardware, no vIOMMU. It says nothing about the nginx figure.

Two smaller things. kmorphd logs through one /dev/kmsg fd, which the
kernel rate-limits to 10 lines per 5 s unless printk.devkmsg=3Don, so on
a default command line "state TAKEN_OVER" never shows. Details:

   https://github.com/multikernel/kmorph/issues/1

And the successor boots without a swiotlb ("No low mem": its 128 MB
are above 4 GiB). I did not test a 32-bit-DMA device after a takeover,
so that one is a question, not a bug.

The QEMU rig, the logs and the exact commands are available if you
want them.

[1] https://lore.kernel.org/all/au5M_M_RzWfXLr0T@pop-os.localdomain/

Thanks,
Yun Wang



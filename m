Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDE9D5B161
	for <kexec@archiver.kernel.org>; Tue, 16 Dec 2025 03:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bhCHGGEp4nwkCTbAG0NQ2tB+VM9yXbUAuoxmXeZRUII=; b=rrzI9Xe/MksqszSDizt5VBQFyZ
	ULHH6xyOcdCAjsvLYt23WP718poQRRAHCybpG299ppGaM8uBZGOwetPq8xK8DHasoOgOscnDB/s2x
	dFv4uSA4q/ycAYAQN5BcqRWvtm9MqRkArJVVtX3tBTtjMj+/k0/bFx/AiCuz7Xtaesa5GPjITsa5i
	X0XsgBWBnxySGtqdKb5MurodJBtL7fiTYbNN437pkD36lc34lvYdFDn7fWEobYXk9QcwnMcqgWF3Q
	iaMYdPSqA8yC8ObrT2pWVBhUEE+FWduu2UZJYUJlKmOS30bBCtvRBhdqyU7XDPXrTDvUuMxnminoq
	LN5mgZ8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVM0t-00000004djX-0FkT;
	Tue, 16 Dec 2025 03:46:15 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVM0q-00000004dj5-1W1Q
	for kexec@lists.infradead.org;
	Tue, 16 Dec 2025 03:46:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E78AC43D79;
	Tue, 16 Dec 2025 03:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46499C4CEF1;
	Tue, 16 Dec 2025 03:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765856769;
	bh=pSGYuRMvBKPFBLH+IHHROcdygnUFsHEmbW+bkqAwZac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XLGHz6t0zQTXBXbPM0LT9pPAlum1Ynru9rHis8eTow9FOLRjJNOL2XsKLj/IdQQ/A
	 vLGRarqJkBymWN5hyRWg3BMkcM8+rgV6LC0AJeKpe9jRonn3wl0Rf8fWupn0CGVomq
	 aEUIPpdeELEeZK46Xd0sv0BG/HqWVrSQOv9rfNs1vv9qrZ0uuKoNY534+fxTe6DPxV
	 0a9APA3VMNhpt/cq+4o9BZGubGxbyR11tXitIWpWmNLQFd0QcNCm986DIt99QRUbpe
	 GKV16JI36iTLR7jEwcM07WFcWVIuQexiIIgaySSJuPykDm0onC5UBC56LaNtKsy3Yf
	 YbLBvYKEIjnhA==
Date: Tue, 16 Dec 2025 05:46:05 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux.dev,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	ebiederm@xmission.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
Message-ID: <aUDV_e19I0I3GIzN@kernel.org>
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215233316.1076248-1-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251215_194612_447926_B65E7C73 
X-CRM114-Status: GOOD (  32.07  )
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

On Mon, Dec 15, 2025 at 03:32:48PM -0800, Ross Philipson wrote:
> Secure Launch is a vendor-neutral approach to implementing TGC Dynamic
> Root of Trust (DRTM) support in the kernel. This is complementary to
> better known Static Root of Trust (SRTM) schemes such as UEFI SecureBoot.
> 
> This series provides the common infrastructure along with Intel TXT
> support, without needing the tboot exokernel. Support for AMD SKINIT is
> pending the common infrastructure getting nailed down, and ARM are
> looking to build on it too.
> 
> Originally, tboot were approached to see if they'd take support for
> other vendors, but they elected not to. Hence this approach instead.
> 
> Work is being coordinated by the Trenchboot project, https://trenchboot.org/,
> organising Secure Launch support for upstream open source projects including
> Grub, iPXE and Xen. The goal of the Trenchboot project is to make DTRM easy
> to use.  e.g. for Grub, it's simply adding "slaunch" as a command in the boot
> stanza.  See https://trenchboot.org/user-docs/QUICKSTART/#linux-quick-start-guide
> for more details
> 
> Patch set based on commit:
> torvalds/master/fd57572253bc356330dbe5b233c2e1d8426c66fd
> 
> Depends on v3 of the following TPM patch set (note this patch
> set is being actively worked on separately):
> [PATCH v3 00/10]  tpm: Decouple Trenchboot dependencies
> Message ID: 20250929194832.2913286-1-jarkko@kernel.org
> 
> Finally we would like to thank everyone for their input and
> assistance. It has all been very helpful in improving the quality of
> our solution and in reviewing/strengthening our security posture.
> 
> Thanks
> Ross Philipson and Daniel P. Smith
> 
> Changes in v15:
> 
>  - Rewriting and reformatting of the cover letter, commit message and
>    code comments per requests from maintainers.
>  - Introduction of a early TPM driver in the x86 setup kernel to allow
>    TPM extend command very early in the boot.
>  - Remove previous TPM extending architecture that attempted to update
>    the TPM PCRs later in the boot process.
>  - Split slaunch.h into 2 files, with a new txt.h. The former contains
>    platform agnostic definitions for the SL feature. The new txt.h file
>    contains Intel TXT definitions from the public specs.
>  - Split TPM headers up following the specifications where the
>    technologies are defined.
>  - Include set of split up TPM header files to allow TPM driver reuse
>    in other environments (e.g. early kernel, x86).
>  - Fix code formatting and type-os.
> 
> 
> Alec Brown (1):
>   tpm: Remove main TPM header from TPM event log header
> 
> Daniel P. Smith (6):
>   tpm/tpm_tis: Close all localities
>   tpm/tpm_tis: Address positive localities in tpm_tis_request_locality()
>   Documentation/x86: Secure Launch kernel documentation
>   x86: Add early SHA-1 support for Secure Launch early measurements
>   x86: Add early SHA-256 support for Secure Launch early measurements
>   x86: Secure Launch late initcall platform module
> 
> Ross Philipson (21):
>   tpm: Initial step to reorganize TPM public headers
>   tpm: Move TPM1 specific definitions and functions to new headers
>   tpm: Move TPM2 specific definitions and functions to new headers
>   tpm: Move TPM common base definitions to new public common header
>   tpm: Move platform specific definitions to the new PTP header
>   tpm: Add TPM buffer support header for standalone reuse
>   tpm/tpm_tis: Allow locality to be set to a different value
>   tpm/sysfs: Show locality used by kernel
>   x86: Secure Launch Kconfig
>   x86: Secure Launch Resource Table header file
>   x86: Secure Launch main header file
>   x86/txt: Intel Trusted eXecution Technology (TXT) definitions
>   x86/tpm: Early TPM PCR extending driver
>   x86/msr: Add variable MTRR base/mask and x2apic ID registers
>   x86/boot: Place TXT MLE header in the kernel_info section
>   x86: Secure Launch kernel early boot stub
>   x86: Secure Launch kernel late boot stub
>   x86: Secure Launch SMP bringup support
>   kexec: Secure Launch kexec SEXIT support
>   x86/reboot: Secure Launch SEXIT support on reboot paths
>   x86/efi: EFI stub DRTM launch support for Secure Launch
> 
>  Documentation/arch/x86/boot.rst               |  21 +
>  Documentation/security/index.rst              |   1 +
>  .../security/launch-integrity/index.rst       |  11 +
>  .../security/launch-integrity/principles.rst  | 308 +++++++
>  .../secure_launch_details.rst                 | 587 +++++++++++++
>  .../secure_launch_overview.rst                | 240 ++++++
>  arch/x86/Kconfig                              |  14 +
>  arch/x86/boot/compressed/Makefile             |   8 +
>  arch/x86/boot/compressed/early_tpm_extend.c   | 601 ++++++++++++++
>  arch/x86/boot/compressed/head_64.S            |  29 +
>  arch/x86/boot/compressed/kernel_info.S        |  50 +-
>  arch/x86/boot/compressed/sha1.c               |   7 +
>  arch/x86/boot/compressed/sha256.c             |   6 +
>  arch/x86/boot/compressed/sl_main.c            | 638 +++++++++++++++
>  arch/x86/boot/compressed/sl_stub.S            | 770 ++++++++++++++++++
>  arch/x86/boot/compressed/tpm.h                |  42 +
>  arch/x86/boot/compressed/vmlinux.lds.S        |   7 +
>  arch/x86/include/asm/msr-index.h              |   5 +
>  arch/x86/include/asm/realmode.h               |   3 +
>  arch/x86/include/asm/txt.h                    | 330 ++++++++
>  arch/x86/include/uapi/asm/bootparam.h         |   1 +
>  arch/x86/kernel/Makefile                      |   2 +
>  arch/x86/kernel/asm-offsets.c                 |  20 +
>  arch/x86/kernel/reboot.c                      |  14 +
>  arch/x86/kernel/setup.c                       |   3 +
>  arch/x86/kernel/slaunch.c                     | 615 ++++++++++++++
>  arch/x86/kernel/slmodule.c                    | 348 ++++++++
>  arch/x86/kernel/smpboot.c                     |  47 +-
>  arch/x86/realmode/init.c                      |   8 +
>  arch/x86/realmode/rm/header.S                 |   3 +
>  arch/x86/realmode/rm/trampoline_64.S          |  32 +
>  drivers/char/tpm/tpm-buf.c                    |  10 +-
>  drivers/char/tpm/tpm-chip.c                   |  34 +-
>  drivers/char/tpm/tpm-sysfs.c                  |  10 +
>  drivers/char/tpm/tpm.h                        | 180 +---
>  drivers/char/tpm/tpm1-cmd.c                   |  18 +-
>  drivers/char/tpm/tpm1_structs.h               |  97 +++
>  drivers/char/tpm/tpm2-cmd.c                   |  32 +-
>  drivers/char/tpm/tpm2-space.c                 |  13 -
>  drivers/char/tpm/tpm2_structs.h               |  58 ++
>  drivers/char/tpm/tpm_tis_core.c               |  21 +-
>  drivers/char/tpm/tpm_tis_core.h               |  64 +-
>  drivers/firmware/efi/libstub/efistub.h        |   8 +
>  drivers/firmware/efi/libstub/x86-stub.c       | 100 +++
>  drivers/iommu/intel/dmar.c                    |   4 +
>  include/keys/trusted_tpm.h                    |   1 -
>  include/linux/slaunch.h                       | 251 ++++++
>  include/linux/slr_table.h                     | 308 +++++++
>  include/linux/tpm.h                           | 240 +-----
>  include/linux/tpm1.h                          |  87 ++
>  include/linux/tpm2.h                          | 247 ++++++
>  include/linux/tpm_buf.h                       |  57 ++
>  include/linux/tpm_command.h                   |  30 -
>  include/linux/tpm_common.h                    |  99 +++
>  include/linux/tpm_eventlog.h                  |   4 +-
>  include/linux/tpm_ptp.h                       | 139 ++++
>  kernel/kexec_core.c                           |   8 +
>  security/keys/trusted-keys/trusted_tpm1.c     |   1 -
>  security/keys/trusted-keys/trusted_tpm2.c     |   1 -
>  59 files changed, 6319 insertions(+), 574 deletions(-)
>  create mode 100644 Documentation/security/launch-integrity/index.rst
>  create mode 100644 Documentation/security/launch-integrity/principles.rst
>  create mode 100644 Documentation/security/launch-integrity/secure_launch_details.rst
>  create mode 100644 Documentation/security/launch-integrity/secure_launch_overview.rst
>  create mode 100644 arch/x86/boot/compressed/early_tpm_extend.c
>  create mode 100644 arch/x86/boot/compressed/sha1.c
>  create mode 100644 arch/x86/boot/compressed/sha256.c
>  create mode 100644 arch/x86/boot/compressed/sl_main.c
>  create mode 100644 arch/x86/boot/compressed/sl_stub.S
>  create mode 100644 arch/x86/boot/compressed/tpm.h
>  create mode 100644 arch/x86/include/asm/txt.h
>  create mode 100644 arch/x86/kernel/slaunch.c
>  create mode 100644 arch/x86/kernel/slmodule.c
>  create mode 100644 drivers/char/tpm/tpm1_structs.h
>  create mode 100644 drivers/char/tpm/tpm2_structs.h
>  create mode 100644 include/linux/slaunch.h
>  create mode 100644 include/linux/slr_table.h
>  create mode 100644 include/linux/tpm1.h
>  create mode 100644 include/linux/tpm2.h
>  create mode 100644 include/linux/tpm_buf.h
>  delete mode 100644 include/linux/tpm_command.h
>  create mode 100644 include/linux/tpm_common.h
>  create mode 100644 include/linux/tpm_ptp.h
> 
> -- 
> 2.43.7
> 

Most likely I'll review this after the holidays (for heads up).

BR, Jarkko


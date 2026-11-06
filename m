Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5B3606D810
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 00:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Dcs/jbS7;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WdW2xPHL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=j3QnOqT1bd63wcrV6KvOAip3wCLe11FN2NBTadJaa9M=; b=Dcs/jbS7BqvW4+//3CTskOAlfX
	jiW8C+iLo4a7/Y2MvfRGN3uobgcuTNYhiElURsRF0oX1WLNDZphcRCdVMOqQXqmm5G+jXziCciqO4
	7I5pHNijONUk7R84riEsJdHWLlHj6W0TptMtdrwEOZ3vI8fb0DSaSYVikap7eTMAvQ+GxYF6W6vYv
	qgdZlFJSmHZSljzMJXyK9xhu02LrhDzQqgUiZVazfVwzG4bzuTq8ncnz3w1svaCILGozU41kdNXka
	tpSUsizaesD9SBezlv1a2yFz2naymyL+fT62opXOqUFrU7qOa3+dLOIhOP0G61sKFs3oiU+Fy4AhN
	oKoXICvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP82m-0000000Ave0-1X3w;
	Fri, 06 Nov 2026 00:43:00 +0000
Received: from mail-ot1-x348.google.com ([2607:f8b0:4864:20::348])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP82k-0000000AvdO-0YZF
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 00:42:59 +0000
Received: by mail-ot1-x348.google.com with SMTP id 46e09a7af769-84fe2593525so236771a34.3
        for <kexec@lists.infradead.org>; Thu, 05 Nov 2026 16:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925776; x=1794530576; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j3QnOqT1bd63wcrV6KvOAip3wCLe11FN2NBTadJaa9M=;
        b=WdW2xPHLG/3ZbRMO3/Lfrgg9pns3wAUnEU1z2zQ5JyJTuFpV5Y9aMA94Z/Mmw8UJ6c
         aE5x3F2/TH8bVoPGtJfmAxgIR6D/aXqZlO86i7yEV9BtMyo0P9r8qu7rtmofvk9A4yv5
         Cqp7MXnlgJ4cxoapr1z/TwTJD0NNwDArEk0jrDdrhtGPkZ/NKZsRsshanM1DfUFL+3p6
         5lpyABGEi99bpUE5f8ckhFeUokUce6DjG1t57flRma1bs8zkwToijIxcB4GNUmut8K4z
         yiZnctnHNedVeuNb2D08c4J+blwz1Y2ogJGfdKS+P1K0I/cTsz0DSP7x1wfDiSx/RYRe
         B/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925776; x=1794530576;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j3QnOqT1bd63wcrV6KvOAip3wCLe11FN2NBTadJaa9M=;
        b=hEiQSginTxAWUlyD7x+XbQRrcSbhEbAgOzF7Tf2DZlxYLiSMCb2MZNbj/ACwF7hJHv
         J1ypy8NVsQXOmyxwQj4LYMPTUo8bRUeMUqg9NJWyZt8zZ7uE7ah8MKMJyJP+g7beaeqf
         bfbW72vXcz+z2d4nezZwwEoJODxhZ+oJOeURIoc/M+PBLHPcZhK3F/tNiY+itd4HIkNy
         HDhgb8QGEwIJAHOwkfAGTFSgiocaeSk5i88+6VeI4f94T96YI7kKmtlNqK9H3vVP1Xk3
         D3XNLD7prIrn/j3KMz3Eq2Vo9NduzrV1HNDKxdEvBjvd3ie6FOWHRUjv1zJzJyhScIuC
         vElw==
X-Gm-Message-State: APuU4Z+F6V7ZSHvN0L/LYiPN2nO0V2vccKnYAyjwlXFnkXvBNqd2rAzB
	T4w0OY+OLUFC5sew5jo+jvu44kyYL4+o2SppevE4stepXBE2MrtJ9CvpTVvC8793Ntb990CxqTU
	NcIQA4HPlLr4l+69Zu5It0jI6IkewI/k+Zq1/qX2LrSrj3qSH+ZW1qabA++7vDMbuUNOQxWZl45
	/2AUE3hwL3HOrixCpc2NbWJvPFr3m1K2X4+zTn93p7s/VAcDQuD80=
X-Received: from ilmt14.prod.google.com ([2002:a05:6e02:10e:b0:50d:9814:cccb])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:3a0d:b0:540:5827:6d8a with SMTP id 5614622812f47-567e185afd4mr616724b6e.66.1793925776141;
 Thu, 05 Nov 2026 16:42:56 -0800 (PST)
Date: Fri,  6 Nov 2026 00:42:01 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106004218.604799-1-dmatlack@google.com>
Subject: [PATCH v2 00/17] PCI: Index saved capability state by configuration
 space offset
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Cc: Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Lukas Wunner <lukas@wunner.de>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_164258_197013_D1BB07CF 
X-CRM114-Status: GOOD (  32.73  )
X-Spam-Score: -9.5 (---------)
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series can be found on GitHub:

  https://github.com/dmatlack/linux/tree/liveupdate/pci/savedstate/v2

This series replaces the per-capability save buffers with a single
per-device store indexed by configuration space offset, lays out struct
pci_saved_state the same way, and adds helpers for drivers to preserve
struct pci_saved_state across a Live Update.

The main motivation here is Live Update. VFIO snapshots a device's state
with pci_store_saved_state() when the device is first opened and
restores it with pci_load_and_free_saved_state() when it is last closed.
A Live Update can happen in between, so VFIO needs to pass this state to
the next kernel.

This is not safe today because the layout of struct pci_saved_state is
defined by the kernel that produced it: which capabilities get a record,
how large each record is, and what each word in it means.  Nothing ties
a saved value back to the register it came from, so preserving it as is
would turn the private layout of every capability save buffer into Live
Update ABI [1]. Indexing saved values by configuration space offset
makes the layout a property of the hardware rather than of the kernel
version, so it can be preserved as a bitmap of saved DWORDs plus their
values, and the next kernel can decide per register what to restore.

[1] https://lore.kernel.org/linux-pci/aukvTvnfyAvahb51@google.com/

The same change also makes saving and restoring capabilities simpler
and more robust:

  - Capability save buffers were allocated at ten sites (plus one
    hand-built by a quirk) across three phases of a device's life, and
    four of them (AER, DPC, PTM, TPH) ignored allocation failure, so the
    capability silently went unsaved (patch 1 fixes DPC). Now each
    device has exactly one allocation, and its failure is reported.

  - Each capability's save and restore routines had to walk the same
    registers in the same order through a buffer cursor, and code
    elsewhere had to know which slot held which register. Now saving is
    a single pass over a bitmap of reserved registers, each restore
    routine names its registers by offset, and the common logic lives
    in one small helper library (drivers/pci/saved-caps.c).

Patches 1-16 are roughly net-neutral in size. Outside of the new helper
library (half of which is comments), this series removes about 250
lines from the PCI core.

Series Overview
---------------

This series implements the following:

  1. Allocate the DPC save buffer during device setup instead of when
     the portdrv DPC service binds, so that every capability is set up
     in the same phase, and a reset before the service binds no longer
     loses the DPC Control register (patch 1).

  2. Add the per-device store. Capabilities reserve registers by offset
     during device setup, and the values are allocated in one array once
     every capability has been initialized (patch 2).

  3. Lay out struct pci_saved_state as a bitmap of saved DWORDs plus
     their values (patch 3).

  4. Convert PCIe, PCI-X, LTR, L1SS, AER, PTM, TPH, DPC, ACS and VC to
     the store, one capability at a time (patches 4-14).

  5. Replace the per-capability save functions with a single pass over
     the reservation bitmap (patch 15).

  6. Remove struct pci_cap_saved_state and the code that managed it
     (patch 16).

  7. Add helpers that preserve a struct pci_saved_state in KHO memory
     for the next kernel, which callers reference by its physical
     address (patch 17).

Design Notes
------------

  - The store only covers capability registers. The configuration space
    header is still saved in pci_dev.saved_config_space.

  - Registers are saved a DWORD at a time, since configuration space
    reads have no side effects, but restored at their own width, since a
    neighbouring register in the same DWORD may be RW1C (e.g.
    PCI_EXP_DEVCTL and PCI_EXP_DEVSTA).

  - struct pci_saved_state describes a device's complete saved state at
    every commit, so a bisect landing in the middle of the series does
    not silently lose state in pci_load_saved_state().

  - PCIe capability registers are now saved with raw DWORD reads instead
    of pcie_capability_read_word(), which returns 0 for registers the
    device does not implement. Restore still goes through
    pcie_capability_write_word(), which skips them.

  - The reservation bitmap is embedded in struct pci_dev so that
    reserving cannot fail. This grows struct pci_dev by 136 bytes on
    x86_64 (2448 to 2584), which stays in the same kmalloc-4k bucket.
    Removing the per-capability allocations, each with a 24-byte header,
    saves 32 to 160 bytes of slab per device. The blob from
    pci_store_saved_state() grows (e.g. from 192 to 256 bytes for a
    typical endpoint), since it now carries a 128-byte bitmap.

  - Along the way, quirk_intel_qat_vf_cap() no longer builds a PCIe save
    buffer by hand, and pci_load_saved_state() no longer performs
    potentially unaligned 32-bit reads of packed records.

Merge Plan
----------

This series applies on top of v10 of the PCI core support for Live
Update series [2], which is targeting Linux 7.5. This series is
targeting Linux 7.5 as well.

Both series will be merged through liveupdate.git, matching the
agreed-upon tree in the MAINTAINERS entry for PCI LIVE UPDATE.

[2] https://lore.kernel.org/linux-pci/20261013162529.1928093-1-dmatlack@google.com/

Testing
-------

All patches were build-tested individually. The series was tested
using the VFIO selftests, which reset devices many times and so exercise
the PCI core's save and restore paths. The tests were run in a QEMU VM
using an emulated igb device, and on bare metal using an Intel DSA
device on an Intel server.

To check that the series does not change what gets restored, every PCI
config write made by the kernel with and without this series was traced
in QEMU (pci_cfg_write trace event) while performing FLR, PM and VF
resets, runtime suspend/resume under vfio-pci, and the VFIO selftests on
an igb device below a PCIe Root Port, and while resetting a PCIe switch
Downstream Port. The writes to all of these devices were identical. Of
the capabilities this series touches, that setup covers PCIe and AER.

The series was also build-tested on x86_64, i386, arm64 and ppc64le,
with gcc and clang at W=1, with sparse, with CONFIG_PCI_LIVEUPDATE
enabled and disabled, and with each of CONFIG_PCIEAER, CONFIG_PCIE_DPC,
CONFIG_PCIE_PTM, CONFIG_PCIEASPM and CONFIG_PCI_IOV disabled.

The helpers in patch 17 were tested across a Live Update selftests (not
yet posted), extended so that the test driver preserves each device's
struct pci_saved_state along with the device. On x86_64 and arm64 in
QEMU, for every tested topology, the next kernel got back the state that
was preserved, dropped a saved DWORD that it does not reserve, and
restoring the state wrote back a register that had been changed before
the Live Update. The full set of patches used for testing can be found
on GitHub:

  https://github.com/dmatlack/linux/tree/liveupdate/pci/savedstate/v2-test

Future Work
-----------

The next version of the VFIO PCI Live Update series will use the new
helpers to preserve the state that VFIO captures with
pci_store_saved_state(), in place of [PATCH v6 05/27] [3]. Please see
the PCI core Live Update Roadmap for the rest of the planned work:

  https://lore.kernel.org/linux-pci/20261001232133.560284-1-dmatlack@google.com/

[3] https://lore.kernel.org/linux-pci/20261102153656.1431701-6-vipinsh@google.com/

Separately, the one remaining saved state allocation could be made fatal
to device setup. pci_device_add() returns void today, so a device whose
saved state could not be allocated is still added.

AI Assistance
-------------

This series was developed with the help of an LLM-based coding
assistant, which was used to draft code and commit messages and to
review the series. I reviewed every change and take full responsibility
for all of it.

Changelog
---------

v2:
 - Rebase onto v10 of the PCI core support for Live Update series, and
   target liveupdate.git.
 - Add patch 12 to convert the ACS save buffer added by the PCI core
   support for Live Update series to the store.
 - Add patch 17 with helpers to preserve struct pci_saved_state across
   Live Update, replacing [PATCH v6 05/27] of the VFIO PCI Live Update
   series [3] (Vipin, Bjorn).
 - Drop the Assisted-by tags, which upstream no longer asks for, and
   describe the use of AI tools in the cover letter instead.
 - Add pci_saved_cap_shift() so the code reading and writing 16-bit
   saved registers shares one shift calculation (Josh).
 - Move the rename of pci_allocate_cap_save_buffers() to
   pci_reserve_saved_caps() from patch 16 to patch 14, where it stops
   allocating, and mention ACS and VC in the comment at its call site
   (Josh).
 - Fix inaccuracies in the commit messages of patches 2, 7 and 15
   (Josh).

v1: https://lore.kernel.org/linux-pci/20260924173501.856380-1-dmatlack@google.com/


David Matlack (17):
  PCI/DPC: Allocate the DPC save buffer during device setup
  PCI: Add an offset-indexed store for saved capability registers
  PCI: Lay out struct pci_saved_state by configuration space offset
  PCI: Save PCIe state in the saved capability store
  PCI: Save PCI-X state in the saved capability store
  PCI/ASPM: Save LTR state in the saved capability store
  PCI/ASPM: Save L1SS state in the saved capability store
  PCI/AER: Save AER state in the saved capability store
  PCI/PTM: Save PTM state in the saved capability store
  PCI/TPH: Save TPH state in the saved capability store
  PCI/DPC: Save DPC state in the saved capability store
  PCI: Save ACS state in the saved capability store
  PCI/VC: Split the VC Resource Control restore into a helper
  PCI/VC: Save VC state in the saved capability store
  PCI: Save reserved capability registers in a single pass
  PCI: Remove the per-capability save buffers
  PCI: liveupdate: Add helpers to preserve struct pci_saved_state

 Documentation/PCI/liveupdate.rst |   3 +
 drivers/pci/Makefile             |   3 +-
 drivers/pci/liveupdate.c         | 133 ++++++++++-
 drivers/pci/pci.c                | 383 +++++++++++--------------------
 drivers/pci/pci.h                |  59 ++---
 drivers/pci/pcie/aer.c           |  80 +++----
 drivers/pci/pcie/aspm.c          | 111 ++++-----
 drivers/pci/pcie/dpc.c           |  41 ++--
 drivers/pci/pcie/ptm.c           |  42 ++--
 drivers/pci/probe.c              |   9 +-
 drivers/pci/quirks.c             |  30 +--
 drivers/pci/saved-caps.c         | 308 +++++++++++++++++++++++++
 drivers/pci/tph.c                |  68 ++----
 drivers/pci/vc.c                 | 272 +++++++++++-----------
 include/linux/kho/abi/pci.h      |  32 +++
 include/linux/pci.h              |  31 ++-
 include/linux/pci_liveupdate.h   |  23 ++
 17 files changed, 959 insertions(+), 669 deletions(-)
 create mode 100644 drivers/pci/saved-caps.c


base-commit: 312200e9211ede3f9a03cc17d094805e06e4674e
-- 
2.56.0.455.g6c5a503b38-goog



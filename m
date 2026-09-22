Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368E7C98302
	for <kexec@archiver.kernel.org>; Tue, 22 Sep 2026 04:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JtaSAfNZWJ/23JZX4TX1si8kmJS1+YCVEwp8EWMG/RM=; b=4A0DXhihb0Jb4TCLKOPNxED6YX
	Kf6qWiBuu7jRJFtZyqz4C8wTeEwD0yNRRstsJNRC9NpjCclFHhlFZNdF7+C/QegVjvz5TeVFFN4NM
	QSw4LUpDmVynPb+/sz2DvzG1+OBragNWThMxBw/I7OlBdtE1C2lUQc2wh5btB5miyfpEpddtMEbZ6
	t74K6IUY185p73uqi4UCGGiD4DMWA/lPc4SEtwSW+vZhqQV443Gb/nqq7DTMEE4gLFJdUPVg7hRf7
	QKicv+wgSOL6cL+CcW8FprG4jRhYODP/qYKkOdwNFwQ+r+ON0rzleNdd/Ys7rrbIoKEoq6ZGhfxNc
	ItqoYV5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8rsy-000000049nz-3rUs;
	Tue, 22 Sep 2026 04:13:40 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8rsx-000000049np-126m
	for kexec@lists.infradead.org;
	Tue, 22 Sep 2026 04:13:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A091640840;
	Tue, 22 Sep 2026 04:13:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A081F000FF;
	Tue, 22 Sep 2026 04:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790050418;
	bh=JtaSAfNZWJ/23JZX4TX1si8kmJS1+YCVEwp8EWMG/RM=;
	h=From:To:Cc:Subject:Date;
	b=UIKqt4PEYrcADAfd+X2Wgtg6yh6AcL9MgOaTuTIKnSsq4LFg5XqQR2zHe9a/ZbAZv
	 m+enA1NTkG0SjCXRCFXP0rEzr26MhL5V9/DlyS0N9M+dbPcNkfjfbI6qxWLrV3AGcQ
	 F3m14qPPRKSTGOHRe1Wc348dK9bu5BEQLL4QGi7fNaC0EKz/MHjyOpaPM+j4PY7CD9
	 dEZsxjewEOy7CriZpl8V2yde9l7wtfE+/It8Xuw7X2Fq7zl34avEJRhdc/imcFaBc7
	 zT0GYqf/8DrAL++a16JNCp3QcZJ1dBhofzrgoQP5HvM3CLTXkUKuncZvjrzY4x/kWh
	 BaKemxUoYJoOQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Baoquan He <baoquan.he@linux.dev>
Cc: x86@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-efi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH v3 0/4] kho: rename "scratch" to "bootmem"
Date: Tue, 22 Sep 2026 06:13:12 +0200
Message-ID: <20260922041321.233986-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

The term "KHO scratch" is vague and overloaded. It does not accurately
describe what the memory is for. This was discussed previously at [0].
The conclusion was to rename "KHO scratch" to "KHO bootmem", since this
is memory passed by the previous kernel for early boot allocations.

In addition, memblock does not care about the provenance of the memory.
It cares more about how it should use it. Use MEMBLOCK_KHO_NOPRSRV,
instead of MEMBLOCK_KHO_SCRATCH, to describe this memory to memblock.

This series does the renames. It also gets rid of a redundant Kconfig.

While the diffstat is big and scary, most of the changes are mechanical.
The most interesting functional change is in patch 4.

This series touches a lot of files across a lot of trees. But since all
of that is purely KHO-related code, I would like to collect ACKs from
the maintainers and take it via the liveupdate tree.

Ideally we should queue it in liveupdate/next early in the v7.4 cycle
since it will cause a lot of conflicts with other patches throughout the
KHO tree.

[0] https://lore.kernel.org/kexec/agHGOxSnP_VraH1M@kernel.org/T/#u

Changes in v3:
- Fixup some typos and update some leftover comments still referring to
  "scratch".
- Update early_init_dt_check_kho() to use bootmem instead of scratch.

Changes in v2:
- Rebase on latest liveupdate/next.

Pratyush Yadav (Google) (4):
  memblock: get rid of CONFIG_MEMBLOCK_KHO_SCRATCH
  memblock: rename KHO_SCRATCH to KHO_NOPRSRV
  kho: rename KHO scratch to KHO bootmem
  kho: rename kho_scratch= commandline parameter to kho_bootmem=

 .../admin-guide/kernel-parameters.txt         |  15 +-
 Documentation/admin-guide/mm/kho.rst          |  18 +-
 Documentation/core-api/kho/index.rst          |  36 +-
 arch/x86/boot/compressed/kaslr.c              |  12 +-
 arch/x86/include/uapi/asm/setup_data.h        |   4 +-
 arch/x86/kernel/e820.c                        |  11 +-
 arch/x86/kernel/kexec-bzimage64.c             |   6 +-
 arch/x86/kernel/setup.c                       |   2 +-
 arch/x86/realmode/init.c                      |   2 +-
 drivers/firmware/efi/efi-init.c               |   6 +-
 drivers/of/fdt.c                              |   8 +-
 drivers/of/kexec.c                            |  16 +-
 include/asm-generic/kexec_handover.h          |   2 +-
 include/linux/kexec.h                         |   2 +-
 include/linux/kexec_handover.h                |  16 +-
 include/linux/memblock.h                      |  30 +-
 kernel/kexec_file.c                           |   4 +-
 kernel/liveupdate/Kconfig                     |   1 -
 kernel/liveupdate/kexec_handover.c            | 340 +++++++++---------
 kernel/liveupdate/kexec_handover_debugfs.c    |  24 +-
 kernel/liveupdate/kexec_handover_internal.h   |   4 +-
 mm/Kconfig                                    |   4 -
 mm/memblock.c                                 |  56 +--
 mm/memfd_luo.c                                |   3 +-
 mm/mm_init.c                                  |   6 +-
 tools/testing/memblock/internal.h             |   2 +-
 26 files changed, 313 insertions(+), 317 deletions(-)


base-commit: db3db4c33a1cf89a201ad1a11c63f503b248ee32
-- 
2.55.0.1082.g2b9226bbc0-goog



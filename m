Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD2FCE79A6
	for <kexec@archiver.kernel.org>; Mon, 25 Sep 2023 21:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:To:From:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=4n2wqu7dzdZdvegV8YhwFaxh5TyZP1VB+kq+b9lykZk=; b=fpp+BBdko6ZbmF
	ZaFZ3B04MZMLjJPr5vX45zX8Chmqp5+hzXl//YHAYOIAZdvenRc+ipYfyksAxKVLvv9cfkCbLo0Sj
	RSvbmcfBE4nVE3GYsOIwpBP475Krtyl+Q/Kat0S5ph7BkVhbetVBILu68xAunU9jYPw3vtR/gnFCY
	SlMz9989eEiqGfI3rnax21hOaQQycyAVmN+U/EiAS8V06H/dJuo61G3yEXkQ63rAwh4iN0nlXhUBk
	HTrLZE5AqKu/8iw8DNs3JnlhDWly4Co9H4mnYDQ16jm6OA876pbu2EhFOsmRJ2BUU9WZJrouE0jr3
	8yGB7EHjr2uoEoRzOKYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qkt7N-00F3DM-0q;
	Mon, 25 Sep 2023 21:27:49 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qkt7K-00F3Bg-1L
	for kexec@lists.infradead.org;
	Mon, 25 Sep 2023 21:27:48 +0000
Received: from skinsburskii. (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
	by linux.microsoft.com (Postfix) with ESMTPSA id DDCDC212C81A;
	Mon, 25 Sep 2023 14:27:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DDCDC212C81A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1695677262;
	bh=hmiXPEKTxjWEpYohVVXoJZw5lHawLeSYKZ1nAgM5rOU=;
	h=Subject:From:To:Date:From;
	b=Y6F8iX0PEngloXvHldjwJs4qLPA+37QFBLJJLHx8XTvU6BW+MxihCBXHsuCn78M+4
	 thY7oibUo0B5VVOpodRaMdMC/z/HLKbdB751/pSqGPNHnV7xnrPod7kRANVbANVs1l
	 fKhksFV2MsV3hZfAJmP2wZVchvGg15vCgoUg2qX8=
Subject: [RFC PATCH v2 0/7] Introduce persistent memory pool
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 ebiederm@xmission.com, akpm@linux-foundation.org,
 stanislav.kinsburskii@gmail.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 kys@microsoft.com, jgowans@amazon.com, wei.liu@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, graf@amazon.de, pbonzini@redhat.com
Date: Mon, 25 Sep 2023 14:27:40 -0700
Message-ID: <169567722094.19708.3583735425859054859.stgit@skinsburskii.>
User-Agent: StGit/0.19
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230925_142746_511444_A8FA7ECF 
X-CRM114-Status: GOOD (  15.64  )
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

This patch introduces a memory allocator specifically tailored for
persistent memory within the kernel. The allocator maintains
kernel-specific states like DMA passthrough device states, IOMMU state, and
more across kexec.

The current implementation provides a foundation for custom solutions that
may be developed in the future. Although the design is kept concise and
straightforward to encourage discussion and feedback, it remains fully
functional.

The persistent memory pool builds upon the continuous memory allocator
(CMA) and ensures CMA state persistency across kexec by incorporating the
CMA bitmap into the memory region instead of allocation it from kernel
memory.

Persistent memory pool metadata is passed across kexec by using Flattened
Device Tree, which is added as another kexec segment for x86 architecture.

Potential applications include:

  1. Enabling various in-kernel entities to allocate persistent pages from
     a unified memory pool, obviating the need for reserving multiple
     regions.

  2. For in-kernel components that need the allocation address to be
     retained on kernel kexec, this address can be exposed to user space
     and subsequently passed through the command line.

  3. Distinct subsystems or drivers can set aside their region, allocating
     a segment for their persistent memory pool, suitable for uses such as
     file systems, key-value stores, and other applications.

Notes:

  1. The last patch of the series represents a use case for the feature.
     However, the patch won't compile and is for illustrative purposes only
     as the code being patched hasn't been merged yet.

  2. The code being patched is currently under review by the community. The
     series is named "Introduce /dev/mshv drivers":

         https://lkml.org/lkml/2023/9/22/1117


Changes since v1:

  1. Persistent memory pool is now a wrapper on top of CMA instead of being a
     new allocator.

  2. Persistent memory pool metadata doesn't belong to the pool anymore and
     is now passed via Flattened Device Tree instead over kexec to the new
     kernel.

The following series implements...

---

Stanislav Kinsburskii (7):
      kexec_file: Add fdt modification callback support
      x86: kexec: Transfer existing fdt to the new kernel
      x86: kexec: Enable fdt modification in callbacks
      pmpool: Introduce persistent memory pool
      pmpool: Update device tree on kexec
      pmpool: Restore state from device tree post-kexec
      Drivers: hv: Allocate persistent pages for root partition


 arch/x86/Kconfig                  |   16 +++
 arch/x86/kernel/kexec-bzimage64.c |   97 +++++++++++++++++
 drivers/hv/hv_common.c            |   13 ++
 include/linux/kexec.h             |    7 +
 include/linux/pmpool.h            |   22 ++++
 kernel/kexec_file.c               |   24 ++++
 mm/Kconfig                        |    9 ++
 mm/Makefile                       |    1 
 mm/pmpool.c                       |  208 +++++++++++++++++++++++++++++++++++++
 9 files changed, 394 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/pmpool.h
 create mode 100644 mm/pmpool.c


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C69BC83F1A
	for <kexec@archiver.kernel.org>; Tue, 22 Jul 2025 02:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lSwc1vyulJuvNqLhe1M0ZnUGND+a1yAaTcK8d1Zd0o4=; b=hPcNxVxMbr185vBrLmDossC3tK
	fd3QWdNbAXPNp5mR+eEbLN15RDdJHaHgK0P46PoTd5vBXt7ND11b9UF47DgVcv4/MMk09sWcYMRv/
	TtdpaY+o73Rk6T4XFQ2D2HHbkR4E0HCD0R+0+IccsPPyUqiaTsxIKf0I6qpzT0xJ7akjLvhqiIHsK
	genDnQViVwO7SzTYpCgdJcRaP6ITz4eoKJnrtSwYP20r/YLS62UnAiZtzWnWuItx9r8cLFva8Vqnk
	CtFNlUGA14yAcy69DEi+zFO3h8UccAARUPwJzN/jCL4hjpPRacS+EPnju/cunymysnQq2zchmm52Y
	ksrUmM7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue2MU-000000014IE-1jMe;
	Tue, 22 Jul 2025 02:04:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue2MJ-000000014Gs-3lBh
	for kexec@lists.infradead.org;
	Tue, 22 Jul 2025 02:04:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753149838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lSwc1vyulJuvNqLhe1M0ZnUGND+a1yAaTcK8d1Zd0o4=;
	b=I7p8bIi+2Uqn7UTkcvUxU2Nx5xZ8t3lD27PolY1WQaNibBtGbl3GGR9kKCjHKyLuNCeEbG
	HyQ18vxWZ85L4/HnIcYcU1OEbpSfK2WEHebuDliZq/a2IzTPcrVPvktdpoLw4P9p+MKUHb
	WOEzo/LR/SniAdJ9782/X1cC4baDNhA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-GOkzrbrKMxmN3qemUH76Fw-1; Mon,
 21 Jul 2025 22:03:54 -0400
X-MC-Unique: GOkzrbrKMxmN3qemUH76Fw-1
X-Mimecast-MFC-AGG-ID: GOkzrbrKMxmN3qemUH76Fw_1753149832
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6B381800294;
	Tue, 22 Jul 2025 02:03:51 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.104])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8DE9818003FC;
	Tue, 22 Jul 2025 02:03:40 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: 
Cc: Pingfan Liu <piliu@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>,
	Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org,
	bpf@vger.kernel.org
Subject: [PATCHv4 00/12] kexec: Use BPF lskel to enable kexec to load PE format boot image
Date: Tue, 22 Jul 2025 10:03:07 +0800
Message-ID: <20250722020319.5837-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_190400_011660_68F7043F 
X-CRM114-Status: GOOD (  18.77  )
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


*** Review the history ***

Nowadays UEFI PE bootable image is more and more popular on the distribution.
But it is still an open issue to load that kind of image by kexec with IMA enabled

There are several approaches to reslove this issue, but none of them are
accepted in upstream till now.

The summary of those approaches:
  -1. UEFI service emulator for UEFI stub
  -2. PE format parser in kernel

For the first one, I have tried a purgatory-style emulator [1]. But it
confronts the hardware scaling trouble.  For the second one, there are two
choices, one is to implement it inside the kernel, the other is inside the user
space.  Both zboot-format [2] and UKI-format [3] parsers are rejected due to
the concern that the variant format parsers will inflate the kernel code.  And
finally, we have these kinds of parsers in the user space 'kexec-tools'.


*** The approach in this series ***

This approach allows the various PE boot image to be parsed in the bpf-prog,
as a result, the kexec kernel code to remain relatively stable.

Benefits
And it abstracts architecture independent part and 
the API is limitted 

To protect against malicious attacks on the BPF loader in user space, it
employs BPF lskel to load and execute BPF programs from within the
kernel.

Each type of PE image contains a dedicated section '.bpf', which stores
the bpf-prog designed to parse the format.  This ensures that the PE's
signature also protects the integrity of the '.bpf' section.


The parsing process operates as a pipeline. The current BPF program
parser attaches to bpf_handle_pefile() and detaches at the end of the
current stage via disarm_bpf_prog(). The results parsed by the current
BPF program are buffered in the kernel through prepare_nested_pe() and
then delivered to the next stage. For each stage of the pipeline, the
BPF bytecode is stored in the '.bpf' section of the PE file. That means
a vmlinuz.efi embeded in UKI format can be handled.


Special thanks to Philipp Rudo, who spent significant time evaluating
the practicality of my solution, and to Viktor Malik, who guided me
toward using BPF light skeleton to prevent malicious attacks from user
space.

*** Test result ***
Configured with RHEL kernel debug file, which turns on most of locking,
memory debug option, I have not seen any warning or bug for 1000 times.

Test approach:
-1. compile kernel
-2. get the zboot image with bpf-prog by 'make -C tools/kexec zboot'
-3. compile kexec-tools from https://github.com/pfliu/kexec-tools/pull/new/pe_bpf

The rest process is the common convention to use kexec.


[1]: https://lore.kernel.org/lkml/20240819145417.23367-1-piliu@redhat.com/T/
[2]: https://lore.kernel.org/kexec/20230306030305.15595-1-kernelfans@gmail.com/
[3]: https://lore.kernel.org/lkml/20230911052535.335770-1-kernel@jfarr.cc/
[4]: https://lore.kernel.org/linux-arm-kernel/20230921133703.39042-2-kernelfans@gmail.com/T/

v3 -> v4
  - Use dynamic allocator in decompression ([4/12])
  - Fix issue caused by Identical Code Folding ([5/12])
  - Integrate the image generator tool in the kernel tree ([11,12/12])
  - Address the issue according to Philipp's comments in v3 reviewing.
    Thanks Philipp!

RFCv2 -> v3
  - move the introduced bpf kfuncs to kernel/bpf/* and mark them sleepable
  - use listener and publisher model to implement bpf_copy_to_kernel()
  - keep each introduced kfunc under the control of memcg

RFCv1 -> RFCv2
  - Use bpf kfunc instead of helper
  - Use C source code to generate the light skeleton file



Pingfan Liu (12):
  kexec_file: Make kexec_image_load_default global visible
  lib/decompress: Keep decompressor when CONFIG_KEXEC_PE_IMAGE
  bpf: Introduce bpf_copy_to_kernel() to buffer the content from
    bpf-prog
  bpf: Introduce decompressor kfunc
  kexec: Introduce kexec_pe_image to parse and load PE file
  kexec: Integrate with the introduced bpf kfuncs
  kexec: Introduce a bpf-prog lskel to parse PE file
  kexec: Factor out routine to find a symbol in ELF
  kexec: Integrate bpf light skeleton to load zboot image
  arm64/kexec: Add PE image format support
  tools/kexec: Introduce a bpf-prog to parse zboot image format
  tools/kexec: Add a zboot image building tool

 arch/arm64/Kconfig                           |   1 +
 arch/arm64/include/asm/kexec.h               |   1 +
 arch/arm64/kernel/machine_kexec_file.c       |   3 +
 include/linux/bpf.h                          |  39 ++
 include/linux/decompress/mm.h                |   7 +
 include/linux/kexec.h                        |   6 +
 kernel/Kconfig.kexec                         |   8 +
 kernel/Makefile                              |   2 +
 kernel/bpf/Makefile                          |   2 +-
 kernel/bpf/helpers.c                         | 225 +++++++++
 kernel/bpf/helpers_carrier.c                 | 211 +++++++++
 kernel/kexec_bpf/Makefile                    |  71 +++
 kernel/kexec_bpf/kexec_pe_parser_bpf.c       |  67 +++
 kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h | 147 ++++++
 kernel/kexec_file.c                          |  88 ++--
 kernel/kexec_pe_image.c                      | 463 +++++++++++++++++++
 lib/decompress.c                             |   6 +-
 tools/kexec/Makefile                         |  90 ++++
 tools/kexec/pe.h                             | 177 +++++++
 tools/kexec/zboot_image_builder.c            | 280 +++++++++++
 tools/kexec/zboot_parser_bpf.c               | 158 +++++++
 21 files changed, 2007 insertions(+), 45 deletions(-)
 create mode 100644 kernel/bpf/helpers_carrier.c
 create mode 100644 kernel/kexec_bpf/Makefile
 create mode 100644 kernel/kexec_bpf/kexec_pe_parser_bpf.c
 create mode 100644 kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h
 create mode 100644 kernel/kexec_pe_image.c
 create mode 100644 tools/kexec/Makefile
 create mode 100644 tools/kexec/pe.h
 create mode 100644 tools/kexec/zboot_image_builder.c
 create mode 100644 tools/kexec/zboot_parser_bpf.c

-- 
2.49.0



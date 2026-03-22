Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B91D109449E
	for <kexec@archiver.kernel.org>; Sun, 22 Mar 2026 02:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Cc:To:From:Subject:
	References:In-Reply-To:Message-Id:MIME-Version:Content-Type:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C3yk/q7eH8rp5D8jTNecDXCdPi+w+YMjus7wVEqvPgU=; b=WoK9ZLwcGj0UuGO5VYmV3nrr1z
	VwjEkLkGrXYXN3H6hzhcVAmfeWy99FQuYAe4A1KMyJRDnzSeuQ//Lon6ZkTpRFnABbs6prlxWM1zc
	9LkZgrkYv2CzolPhob9t2kuHqagcN4isVJA1TYK5ktNNecqMYsGstab/LbOdO4FYWL7W4ioQJqqpn
	esL+4q+hQzTpl3JfNgrhBQmpok8z+Wk3I8VjAOp5iaHq9i59IjBhTP33AgjXzrqzm+Blj+Jfpqi/q
	yRHAnPTJcSCyPZ+0DUpBGl2kklWsfIhYDaV4S6FSs+791CezhhSUT3oCS8QJ1KVpAq6LaSea2ojCQ
	GXq4aM7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w48WS-0000000Ez9I-2y3m;
	Sun, 22 Mar 2026 02:26:36 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w48WR-0000000Ez8j-0aTl
	for kexec@lists.infradead.org;
	Sun, 22 Mar 2026 02:26:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 01A5E6187B;
	Sun, 22 Mar 2026 02:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF33C19421;
	Sun, 22 Mar 2026 02:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774146393;
	bh=04bzTo918vWykfq87u9nThEPf6NCCLr7DFNhKAIeb1g=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=TVfz9j6y+Nd3fCKsvI0FgVrOBfBvwwD/wRmej3joaZgbnBvbWM6EpiOope5F4MiwY
	 FW0jMcDyxsOdI8eWnDgXS3PoiOmLPv1y/Pz19AeoNtJ3zhGx3YvD3fqSLRCkBccwFB
	 hf4s9P/sbKdIZH8hsv9gCkA4BG4N2y7u7hALxZnpO33PxQjQmVfkaDiVc9lPMmFs/X
	 cxg/K2sPgmN0r+qUS5e9RaFEl0RSqC31B0uztQLhSgVUGvAh4vu0AljsDpvLe52RLJ
	 juKPSD4PfF33QTHupsCp1t+mxqkaCXYSuWSeiY+bWZQiXjpJLtR3pm7w2HxCGLKjR7
	 AvE5NWr5KFYQA==
Content-Type: multipart/mixed; boundary="===============2311370585025315084=="
MIME-Version: 1.0
Message-Id: <92cc512b979dc5f37dcb39e9c2b1d804d3e6153733f29355e96869543deeca31@mail.kernel.org>
In-Reply-To: <20260322014402.8815-12-piliu@redhat.com>
References: <20260322014402.8815-12-piliu@redhat.com>
Subject: Re: [PATCHv7 11/13] tools/kexec: Introduce a bpf-prog to handle zboot image
From: bot+bpf-ci@kernel.org
To: piliu@redhat.com,kexec@lists.infradead.org
Cc: piliu@redhat.com,davem@davemloft.net,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jeremy.linton@arm.com,catalin.marinas@arm.com,will@kernel.org,ardb@kernel.org,horms@kernel.org,kraxel@redhat.com,vkuznets@redhat.com,prudo@redhat.com,vmalik@redhat.com,kernel@jfarr.cc,bhe@redhat.com,dyoung@redhat.com,akpm@linux-foundation.org,bpf@vger.kernel.org,systemd-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 22 Mar 2026 02:26:32 +0000 (UTC)
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

--===============2311370585025315084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/kexec/Makefile b/tools/kexec/Makefile
> --- /dev/null
> +++ b/tools/kexec/Makefile

[ ... ]

> +ifeq ($(ARCH),$(filter $(ARCH),arm64 riscv loongarch))
> +	EFI_IMAGE := $(srctree)/arch/$(ARCH)/boot/vmlinuz.efi
> +	KERNEL_IMAGE := $(srctree)/arch/$(ARCH)/boot/vmlinux.bin
> +else
> +	@echo "Unsupported architecture: $(ARCH)"
> +	@exit 1
> +endif

The else branch uses recipe syntax (@echo, @exit) at top-level
Makefile scope, outside of any rule.  On unsupported architectures
this would produce a confusing GNU Make parse error rather than
the intended message.  Should this use $(error ...) instead?

> +zboot: $(HEADERS) $(call BPF_ARTIFACTS,zboot) build_zboot_image

There is no rule or file for the build_zboot_image prerequisite
in this Makefile.  Will this cause "make zboot" to fail with
"No rule to make target 'build_zboot_image'"?

[ ... ]

> diff --git a/tools/kexec/zboot_parser_bpf.c b/tools/kexec/zboot_parser_bpf.c
> --- /dev/null
> +++ b/tools/kexec/zboot_parser_bpf.c

[ ... ]

> +/* ringbuf 2,3,4 are useless */
> +#define MIN_BUF_SIZE    1
> +#define MAX_RECORD_SIZE (IMAGE_SIZE + 40960)
> +#define RINGBUF1_SIZE   IMAGE_SIZE_POWER2_ALIGN
> +#define RINGBUF2_SIZE   MIN_BUF_SIZE
> +#define RINGBUF3_SIZE   MIN_BUF_SIZE
> +#define RINGBUF4_SIZE   MIN_BUF_SIZE

ringbuf_map_alloc() in kernel/bpf/ringbuf.c requires max_entries
to be both power-of-2 and PAGE_ALIGNED.  With MIN_BUF_SIZE set
to 1, ringbufs 2/3/4 will fail map creation with -EINVAL since
PAGE_ALIGNED(1) is false.  The minimum valid size would be
PAGE_SIZE (typically 4096).  Would the BPF program fail to load
because of this?

[ ... ]

> +static int fill_cmd(char *buf, __u16 cmd, __u16 subcmd,
> +				    const char *src, __u32 data_len)
> +{
> +	struct cmd_hdr *hdr;
> +	char *payload;
> +
> +	hdr              = (struct cmd_hdr *)buf;
> +	hdr->cmd         = cmd;
> +	hdr->subcmd      = subcmd;
> +	hdr->payload_len = data_len;
> +	hdr->num_chunks  = 0;

The struct cmd_hdr (in kernel/kexec_bpf_loader.c) also has a
pipeline_flag field at offset 3:

    struct cmd_hdr {
        uint16_t cmd;
        uint8_t subcmd;
        uint8_t pipeline_flag;
        uint32_t payload_len;
        uint16_t num_chunks;
    };

This field is not initialized here, and bpf_ringbuf_reserve() does
not zero the returned memory.  The kernel's kexec_buff_parser()
reads this field:

    fill_pipeline = cmd->pipeline_flag & KEXEC_BPF_PIPELINE_FILL;

If the garbage byte happens to have bit 0x1 set, this would
trigger unintended pipeline fill behavior, causing extra
allocations and copies into next_parsing_buf[].  Should
pipeline_flag be explicitly zeroed?

[ ... ]

> +SEC("fentry.s/kexec_image_parser_anchor")
> +int BPF_PROG(parse_zboot, struct kexec_context *context, unsigned long parser_id)
> +{
> +	kexec_sig_enforced sig_mode;

[ ... ]

> +	sig_mode = BPF_CORE_READ(context, sig_mode);

The type kexec_sig_enforced does not appear to exist as a type
(enum, typedef, or struct) anywhere in the kernel sources.  The
only related symbol is the function set_kexec_sig_enforced().
Similarly, struct kexec_context (in kernel/kexec_bpf_loader.c)
has no sig_mode field.

Since the BPF program includes vmlinux.h generated from the
kernel's BTF, it would fail to compile without this type, and
the BPF_CORE_READ would fail CO-RE relocation without the
struct field.  Are these expected to be added by a patch not
yet in this series?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23393379437
--===============2311370585025315084==--


Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B3A606A8A0
	for <kexec@archiver.kernel.org>; Fri, 13 Nov 2026 09:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HOaBWKZm;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=UpCRHb2K
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8Pc1VZfIDVGJzZNtwuo8QG46Hbc/13m3DgBGkiUdd+o=; b=HOaBWKZmwASmLhycwaqnFXQP8a
	q4Bx7rXEzFTkzhrxVQXnRPQTem1Hs6aMXaLz7le9HOknM4DUHhzU6D7Q+2Ck5XJe6h4W5SawTaTPg
	t+9hMHVNmb9JI2IRbHMuEt2X5Mgtk0e69NBUu2x+y/dKk5vkFXJ6FzGfsEijuLRJHarZMhazsojDQ
	2p/K8c010mpvGZva+LKbl653OcC2InDB4nUmK4V2zuWKcK6BYT9qjISqZE5/dbkrSI3nouz8gU54y
	qdtn5fbogeiDBvTd6643770hcmZPsb7u9WnMTkYFOCes4/km3bh5jomj9gwFHxJV1y0D8gcEK+Nnf
	A88ekfog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRnk1-0000000CEpn-4C1h;
	Fri, 13 Nov 2026 09:38:42 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRnjz-0000000CEnk-1CE1;
	Fri, 13 Nov 2026 09:38:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8Pc1VZfIDVGJzZNtwuo8QG46Hbc/13m3DgBGkiUdd+o=; b=UpCRHb2KbmBJPwtI+DbP0LaL8d
	sOk0q8WFr88S3iAMSHj2p/NnbWVzQGiNdZN3nNdO1zLyJsTHzDT2AYpDsszvlBsPXovwNFHmP0hr1
	SY9lV829yFxFIN3zvj63ln8CFFNj2wJUNMYIHBmKmY/JsW4XoVGlDKbDaDwxxN5mWJ+s4cUXlOuR/
	42UfaRA1qiSu2ICNxybe2yLc35tfTycNpZWbHnjQ/jcxlqy6tYUcS/Bi6fkLYSwXtlLGPpV1jMI8t
	xnhOZeXq4yQ0FVHQXpu6b4xvxJ6oAklL5bw8J+RqC+cFo9eyWVg+5AE204arB4mOGXs0IEiF0Nobe
	Yc0NfHCw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRnjp-00Eeb5-2V;
	Fri, 13 Nov 2026 09:38:30 +0000
Date: Fri, 13 Nov 2026 01:38:22 -0800
From: Breno Leitao <leitao@debian.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Chris Mason <mason@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, x86@kernel.org, kexec@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH RFC 3/4] crash_dump: recover from a machine check in
 copy_oldmem_page()
Message-ID: <avbagwxWrmFrjrtV@gmail.com>
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
 <20261112-work-procfs-oldmem-v1-3-ecdcafd99265@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-work-procfs-oldmem-v1-3-ecdcafd99265@kernel.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_013839_356303_688AC177 
X-CRM114-Status: GOOD (  23.83  )
X-Spam-Score: -4.4 (----)
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 05:37:09PM +0100, Christian Brauner wrote:
> A capture kernel reads the memory of the crashed kernel, and that memory
> may well have uncorrectable errors. That is after all what the first
> kernel often died of. Every architecture that maps a page of the old
> kernel and copies it out does so with copy_to_iter(), and a machine
> check in that copy takes the capture kernel down.
> 
> On x86 a machine check in the kernel is only recovered from if the
> instruction that took it has a machine check safe exception table entry
> or copies from userspace (cf. error_context()). The copy of an old page
> is neither. Its source is kernel memory, whether it goes to the buffer
> of a read() or, since commit 4a22fd20379c ("vmcore: convert
> __read_vmcore to use an iov_iter"), into a kernel page for splice(),
> sendfile() and copy_file_range(). So a read of /proc/vmcore that runs
> into a poisoned page panics the capture kernel, and so do vmcore's own
> reads of the ELF headers and notes. Breno sees the result on a fleet:
> the first kernel dies of a machine check and the capture kernel produces
> no usable vmcore at all (cf. [1]).
> 
> On book3s64 a machine check in the kernel is recovered from if the
> instruction that took it has an exception table entry (cf.
> mce_common_process_ue()). The user copy has them, so a read() comes up
> short there and read_from_oldmem() returns -EFAULT. The copies into
> kernel pages have none and panic the same way. Other powerpc platforms
> don't recover from a machine check in such a copy at all.
> 
> Copy with _copy_mc_to_iter() instead. x86_64 and PPC64 select
> ARCH_HAS_COPY_MC, and on x86_64 and book3s64 the machine check safe copy
> turns the machine check into a short copy, which read_from_oldmem()
> turns into -EFAULT like any other short copy. On x86 that holds for the
> fragile and the enhanced fast string variant, a CPU with neither gets
> the plain copy it has today. Everywhere else _copy_mc_to_iter() is
> _copy_to_iter(). Put the call into a helper, copy_oldmem_to_iter(), so
> that the copy of a page of the old kernel lives in one place and an
> architecture that gains a machine check safe copy later gets this for
> free. The helper does the same check_copy_size() as copy_to_iter(), so
> hardened usercopy keeps checking the copy.
> 
> With a v7.4-rc1 capture kernel reading /proc/vmcore and a machine check
> injected into the copy of an old page the capture kernel is gone. A
> machine check panic prints no trace of its own, this one comes from
> panic_sys_info=all_bt:
> 
> [    0.580568] mce: [Hardware Error]: CPU 0: Machine Check Exception: 7 Bank 1: bd80000000000134
> [    0.580574] mce: [Hardware Error]: RIP 10:<ffffffff81909b11> {_copy_to_iter+0x81/0x850}
> [    0.580584] mce: [Hardware Error]: TSC 202f2117f ADDR 10000000 MISC 8c
> [    0.580587] mce: [Hardware Error]: PROCESSOR 2:aa0f02 TIME 1794493617 SOCKET 0 APIC 0 microcode aa0021c
> [    0.580589] mce: [Hardware Error]: Machine check: Uncorrected unrecoverable error in kernel context
> [    0.580591] Kernel panic - not syncing: Fatal local machine check
> [    0.582587] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 7.4.0-rc1-g6628e7d4c6b2 #1 PREEMPT(lazy)
> [    0.583101] Call Trace:
> [    0.583198]  <#MC>
> [    0.583279]  dump_stack_lvl+0x4d/0x70
> [    0.583419]  nmi_cpu_backtrace.cold+0x18/0x6e
> [    0.583584]  ? __pfx_nmi_raise_cpu_backtrace+0x10/0x10
> [    0.583772]  nmi_trigger_cpumask_backtrace+0xba/0xf0
> [    0.583955]  sys_info+0x83/0xb0
> [    0.584075]  vpanic+0x1b4/0x303
> [    0.584197]  panic+0x66/0x70
> [    0.584488]  mce_panic+0x19e/0x290
> [    0.584799]  do_machine_check+0x627/0x9a0
> [    0.584953]  ? _copy_to_iter+0x81/0x850
> [    0.585099]  exc_machine_check+0x68/0xb0
> [    0.585246]  asm_exc_machine_check+0x1e/0x40
> [    0.587747]  </#MC>
> [    0.587831]  <TASK>
> [    0.588092]  ? iomem_map_sanity_check+0x98/0xb0
> [    0.588430]  ? __ioremap_caller.isra.0+0x1a9/0x300
> [    0.588604]  ? __copy_oldmem_page+0x3d/0xb0
> [    0.588928]  __copy_oldmem_page+0x5e/0xb0
> [    0.589079]  read_from_oldmem.part.0+0xe3/0x140
> [    0.589247]  read_vmcore+0x137/0x280
> [    0.589381]  proc_reg_read_iter+0x49/0x90
> [    0.589533]  vfs_read+0x348/0x490
> [    0.589666]  ksys_read+0x76/0x100
> [    0.589792]  do_syscall_64+0xde/0x4b0
> [    0.590103]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> With this patch the same injection ends the read() with -EFAULT, the
> capture kernel logs the machine check and keeps running.
> 
> [1]: https://lore.kernel.org/all/avRXzzCSzT9Qj2FC@gmail.com/
> 
> Reported-by: Chris Mason <mason@kernel.org>
> Suggested-by: Breno Leitao <leitao@debian.org>
> Fixes: 4ae362be5093 ("[PATCH] kdump: read previous kernel's memory")
> Fixes: 54c32021eb6f ("[PATCH] powerpc: Add arch-dependent copy_oldmem_page")
> Fixes: 4a22fd20379c ("vmcore: convert __read_vmcore to use an iov_iter")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>


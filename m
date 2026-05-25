Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F82CD5BCB
	for <kexec@archiver.kernel.org>; Mon, 25 May 2026 07:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ffTsCl52tDDJ9WJMBEtPkp7+qwtVftVHOsX4VQzd+hQ=; b=SXfpOj8HiqiPN3t2lVu8V0TDLt
	Xzj9aKGqEL923ADlpcs7nhtSHmBUMhFqrQMNoIXKeWdMh1HU2/9ZZ7JsfORk2UZPHnZqSXHfv1Cyy
	MMwkrXs+Fzr7iTBTSTigFUB71VI4lMWhkiy8MwPiE7hmUFXRI1+aAYDUJX7EMD4vboEWGAzsuNET3
	dtAYoO8+INKnKpb/jOFeTF0YjNiNDpGtaFt3gr149yG1SMbx0h9WCfRg3NuYvzBQgkh+Lo1xGnxlF
	gIsjpgX/5eX7JAUJosv4v10ptj+B4PNTXhs4pGOGsISiaZ1cFcxWAPJ2R0jXZlxN824zkzCubyRgS
	BhseX+rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRQ30-0000000GYv8-07J2;
	Mon, 25 May 2026 07:48:26 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRQ2w-0000000GYuX-3raV
	for kexec@lists.infradead.org;
	Mon, 25 May 2026 07:48:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DBACD44037;
	Mon, 25 May 2026 07:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00941F000E9;
	Mon, 25 May 2026 07:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779695301;
	bh=ffTsCl52tDDJ9WJMBEtPkp7+qwtVftVHOsX4VQzd+hQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=J6Ums5B+7Lu3MakC2zVCTCT3gKG+WJsmtE0pvAGhRPT1rudrXkgUpO07M33BcCgEN
	 TMXK2GayHABOZ6GioC9+c7H6qHOZMwl1ZL64YTN0J8aVvt1OD9DCpfL9h4rofi0RuI
	 4KB9Fsx4prdeFZvt4Z97sNj92YQDvrXqtvszS/ZLnSlsre9eF0/hfmcd5nhL+PIqy1
	 nIznVI0znL3PR+eHwnsK9TtjgufBF0B6T7eJo1woXIR/y60oWcP9mejxnyv1xkLRoW
	 ttIb9AYZPRhR+FlF3lzPS10iGRR7fxbNPi6+EfjOSo1nE7O5vsAKNNgKCJDKQ+3Zl1
	 e95B8kRLjRc+g==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/7] LoongArch: add KHO support and selftests
From: Mike Rapoport <rppt@kernel.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: chenhuacai@kernel.org, rppt@kernel.org, pasha.tatashin@soleen.com, 
 pratyush@kernel.org, kernel@xen0n.name, graf@amazon.com, shuah@kernel.org, 
 loongarch@lists.linux.dev, kexec@lists.infradead.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Guo <guodongtai@kylinos.cn>
In-Reply-To: <20260525062810.103367-1-dongtai.guo@linux.dev>
References: <20260525062810.103367-1-dongtai.guo@linux.dev>
Date: Mon, 25 May 2026 10:48:14 +0300
Message-Id: <177969529480.4047269.2120994507098781563.b4-review@b4>
X-Mailer: b4 0.15.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260525_004822_987390_8A1B44A5 
X-CRM114-Status: GOOD (  15.80  )
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

On Mon, 25 May 2026 14:28:03 +0800, George Guo <dongtai.guo@linux.dev> wrote:

Hi,

> [...]
> 
> Bug fixes (patches 3-4)
> ------------------------
> Patch 3 fixes a build failure with CONFIG_KFENCE=y: virt_to_phys() and
> phys_to_virt() in asm/io.h expand to use offset_in_page() and
> page_address(), which require <linux/mm.h> that was not included.

This fix looks unrelated to KHO, it makes sense to send it as a separate
patch.

> 
> Patch 4 moves KEXEC_CONTROL_CODE from 0x100000 to 0x180000.  QEMU
> places its machine FDT at 0x100000 when booting with '-kernel'; the
> previous placement silently overwrote the FDT with the relocation

And I believe that patch 2 and patch 4 can be folded into patch 1 so
that addition of KHO support will be a single patch.

> trampoline, breaking earlycon in the kexec'd kernel.
> 
> Selftest support (patches 5-7)
> -------------------------------
> Patch 5 adds loongarch.conf and extends vmtest.sh to recognise
> loongarch64 as a build target.  QEMU's LoongArch virt machine is
> FDT-only (no ACPI), so 'earlycon' must appear on the kernel cmdline or
> the console UART is never discovered and the test log stays empty.
> 
> Patch 6 disables SERIO_I8042 and its dependents in the QEMU_KCONFIG
> fragment.  QEMU's LoongArch virt machine has no i8042 controller; the
> fallback port probe hits a page fault on the memory-mapped I/O range and
> panics before reaching userspace.

This should be folded into patch 5 for sure.

> 
> Patch 7 polls the serial output for the test verdict and kills QEMU once
> it appears.  QEMU provides no EFI runtime services on LoongArch, so
> machine_restart() falls through to an infinite idle loop and QEMU never
> exits after kexec.

And since without this selftest would hang on loongarch, the timeout
handing should be folded into patch 5.

In general, the rationale when adding new features is to make sure that
after each patch there are no regressions and the new functionality
either works or cannot be enabled until completely implemented.

-- 
Sincerely yours,
Mike.



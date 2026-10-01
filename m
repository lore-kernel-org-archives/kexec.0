Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF03CA5FCF
	for <kexec@archiver.kernel.org>; Thu,  1 Oct 2026 16:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:In-Reply-To:Subject:CC:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=8F9+lpy3V1Yl1wcdKSphAECSLZz4osJu4uWhm9xA1GU=; b=zfoCAjJ6NrFPLhZ2MD0MkhttoV
	QR37IxHq5kb+Bnz1DYXDrrhx5F7FB1tf6YszTFMjaQ2UQ6wdgYv8TkicrDB4UejFB/aIetnyiRgtD
	aQzixuYZvkZFJuWjVskPEOAukrw09ZP18ruq/dGfhmst0MdbsnGYaBSBqBD8ZXVe6PDDhsYVDlOXB
	8kgedgCzi/nUTeEE1YSV5f7G05JqvIgzA5CUk+B8/28adLSg1yWcMc86ANu7odfRlmZg22HJDxcqM
	C8FaG0jbFnv2/bvvw2VdP94aDoER01vKGYSGnN5yzERKt+Wty6dWDEAOBYbOjSYrnC1Js7S6ad65t
	exEgO2mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCK23-00000009mLH-0sra;
	Thu, 01 Oct 2026 16:53:19 +0000
Received: from mail.mainlining.org ([5.75.144.95])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCK20-00000009mKU-06OB;
	Thu, 01 Oct 2026 16:53:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790873577; bh=8F9+lpy3V1Yl1wcdKSphAEC
	SLZz4osJu4uWhm9xA1GU=; b=bIVwCPuuR5boSqT4zIKAfC6BsNl7oH1RWhHSBOK51yxFYQHErm
	9Ehah0eq1VmKR6s4aQvY7sEEj7dlnGTDPtRBtuJ/3K2QwAgk/th+4ZdmfCE6DVnvKs+vvRFLmoD
	uFheuOsID8Vs25gZRqSVDX4UyTfLinUFmo8f5Y4k0sj5rnNRRCkXBTgXJgPs6pMgl2w0lvBjvhJ
	nm6SYHRZp85w5Qf/SdpfUh2qnSunTXvFDDoLrkiGcuih6ICSZelp7rnDYembk0BUOfMz5UUesR3
	1Ra52dxyoOuFEWQKJiQ+sG6IwWp3cjBGI52Tw8WrS6KBS/pdNCc4Ac+d0aPv/x31pVw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790873577; bh=8F9+lpy3V1Yl1wcdKSphAEC
	SLZz4osJu4uWhm9xA1GU=; b=TLeS1x+07OKyp7Y41Bv59QHa1ZC5LyUP86OqeRf+MfKBRO8GoF
	OpHXVuruAiHXRPQtJFqYym+Rej01xqkI2xBA==;
Date: Thu, 01 Oct 2026 17:52:58 +0100
From: Bradley Morgan <brads@mainlining.org>
To: shradhagupta@linux.microsoft.com
CC: akpm@linux-foundation.org, arnd@arndb.de, baoquan.he@linux.dev, bp@alien8.de,
 catalin.marinas@arm.com, dave.hansen@linux.intel.com, decui@microsoft.com,
 haiyangz@microsoft.com, kexec@lists.infradead.org, kys@microsoft.com,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 longli@microsoft.com, mhklinux@outlook.com, mingo@redhat.com,
 pasha.tatashin@soleen.com, pratyush@kernel.org, rppt@kernel.org,
 tglx@kernel.org, wei.liu@kernel.org, will@kernel.org, x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_0/2=5D_hyperv=3A_Run_VMBus?=
 =?US-ASCII?Q?_kexec_cleanup_from_syscore_shutdown?=
In-Reply-To: <20261001132128.1703511-1-shradhagupta@linux.microsoft.com>
Message-ID: <C8205996-C913-487A-BB8A-E3DD018AF747@mainlining.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261001_095316_212493_7F3160B4 
X-CRM114-Status: GOOD (  12.90  )
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

On 1 October 2026 14:21:25 BST, Shradha Gupta
<shradhagupta@linux.microsoft.com> wrote:
>Kexec reboot fails on ARM64 Hyper-V guests because the VMBus
>connection and SynIC CPU hotplug state are not torn down before the
>secondary CPUs are stopped. The kexec kernel consequently starts with
>the previous kernel's VMBus state still active.
>
>The previous version added an ARM64-specific syscore shutdown
>implementation. This version follows Michael Kelley's review and moves
>the cleanup into the existing architecture-independent VMBus syscore
>operations. This removes the separate x86 handler dispatch and gives
>x86 and ARM64 the same ordering:
>
>  device_shutdown()
>  syscore_shutdown()
>    VMBus UNLOAD and SynIC CPU hotplug teardown
>  machine_shutdown()
>
>On x86, VMBus teardown now runs before hv_stimer_global_cleanup().
>This ordering is safe after commit be0cfab740e5 ("clocksource: hyper-v:
>Remove support for stimer interrupts in message mode") removed the
>VMBus dependency from synthetic timer handling.
>
>Patch 1 adds a read-only helper that reports whether a kexec reboot is
>in progress. The helper is exported because HYPERV_VMBUS is tristate
>and the common syscore callback must also link when VMBus is a module.
>Patch 2 moves the cleanup into the common callback and removes the
>obsolete architecture-specific setup/remove interface.
>
>For stable kernels that still support message-mode stimers, an
>ARM64-specific backport will be needed to preserve the existing x86
>ordering.
>
>Changes in v3:
>  - Use the existing common VMBus syscore operations on all
>    architectures, as suggested by Michael.
>  - Remove the x86 handler pointer and the weak setup/remove interface.
>  - Add an exported read-only helper for modular VMBus builds.
>  - Correct the Fixes tag to the commit that enabled Hyper-V on ARM64.
>
>Changes in v2:
>  - Use syscore shutdown instead of an ARM64 machine_shutdown() hook, as
>    suggested by Catalin.
>
>Shradha Gupta (2):
>  kexec: Add helper to report an active kexec reboot
>  Drivers: hv: Run VMBus kexec cleanup from syscore shutdown
>
> arch/x86/kernel/cpu/mshyperv.c | 17 +----------------
> drivers/hv/hv_common.c         | 10 ----------
> drivers/hv/vmbus_drv.c         | 22 ++++++++++++++--------
> include/asm-generic/mshyperv.h |  2 --
> include/linux/kexec.h          |  2 ++
> kernel/kexec_core.c            |  7 +++++++
> 6 files changed, 24 insertions(+), 36 deletions(-)
>
>
>base-commit: be0cfab740e58b70047ef6e7e3d578f00ed5d258
>

Wow! Great!!!

Whole series:

Reviewed-by: Bradley Morgan <brads@mainlining.org>

--- Thanks!
"I'm not a very positive person" - Linus torvalds


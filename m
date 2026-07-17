Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6721C4450F
	for <kexec@archiver.kernel.org>; Fri, 17 Jul 2026 07:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ykj7j2TDvNrFWyx2wOeD7eQtBc+/mXRhuYo6V5jMIW4=; b=wvFP8SQJPt2WfAC5XN2uxF65lE
	zt4Ch1eorWzydDcnRzfeJqwESz4HHU3Ql8AiNCAepWFBlabGL8/4JDvHvGmcYYM92GunEAKn2Db/8
	lEVwW2ix/hGn9kV9XA/JB2C3SqvGwCPI5DjP83yIin2DltRigxHW2IIOuODn1fjlJm3pQqIYA3OUI
	ZXcWCWRq/+UT38+BRfqvfxawrVYwAN9Px3NLRyH74S1db/D4xN0hFHd+SniKBtBt7HDOyiM+FGRfc
	/lWTkqzH5YQTqRMV2hAuAM2nX06BPVo0dXBZgzfiD178DsLYppdO8mEVv7OR1BBMjzMtkQWCpJ5S9
	j7WbKBIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkcoR-00000001NZM-3QWI;
	Fri, 17 Jul 2026 07:16:47 +0000
Received: from out-174.mta0.migadu.com ([2001:41d0:1004:224b::ae])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkcoN-00000001NYQ-3XfZ
	for kexec@lists.infradead.org;
	Fri, 17 Jul 2026 07:16:46 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784272598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ykj7j2TDvNrFWyx2wOeD7eQtBc+/mXRhuYo6V5jMIW4=;
	b=HZthQBFwTPafqA7/z8vwiqrBkzvUO6Y6RY+wDUW/8KsrKgOfmqOmtCh+mGmkMr2L4Vu/M5
	gVElcxGlKit8oIvT+BaHiUEX62Tu6aJm0C2oMC3Ndfi1kOMtncpa4xVEXsSgUwTKrLyQaa
	8jRfWaIKaro9zHCU4gTAPlMG3G069xI=
From: George Guo <dongtai.guo@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Shuah Khan <shuah@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Alexander Graf <graf@amazon.com>,
	Kexin Liu <liukexin@kylinos.cn>,
	George Guo <guodongtai@kylinos.cn>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/3] LoongArch: kexec: add KHO support for FDT-based
Date: Fri, 17 Jul 2026 15:15:51 +0800
Message-ID: <20260717071551.11904-1-dongtai.guo@linux.dev>
In-Reply-To: <CAAhV-H5B6Mj2-AffkstJ4f8EEmvvPOGXoDy2QNudKD2kSz2XkA@mail.gmail.com>
References: <CAAhV-H5B6Mj2-AffkstJ4f8EEmvvPOGXoDy2QNudKD2kSz2XkA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260717_001644_026762_443725BD 
X-CRM114-Status: GOOD (  11.47  )
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

Hi Huacai, Pratyush,

Thanks for the direction.  You were both right that the v3 approach was
the wrong shape, and I have dropped it.

Let me restate the constraint and report what I did.

> But LoongArch is different, the efistub doesn't create a FDT, instead
> it passes the EFI system table and command line to the core kernel
> directly.

So LoongArch has no boot FDT, and the arm64 /chosen path does not apply.
My v3 synthesized an FDT and rewrote the DEVICE_TREE_GUID entry only to
reuse the generic reader.  That was the hacky part, and it is gone.

I followed the x86 model instead.  x86 has no boot FDT either; it carries
the KHO pointer in setup_data (struct kho_data) and calls kho_populate()
directly.  LoongArch has no setup_data, but it does pass the EFI system
table.  So I use the EFI configuration table as the channel:

- The first kernel builds a small handover struct (the KHO FDT and
  scratch addresses), adds a dedicated GUID entry pointing to it, and
  loads both as kexec segments.  machine_kexec() switches the system
  table to the extended table before jumping.
- The next kernel scans the configuration table for that GUID, reads the
  struct, and calls kho_populate() directly.

There is no synthesized FDT, no DEVICE_TREE_GUID rewrite, and nothing on
the command line.  I did not go back to the v1 command line because that
exposes the addresses to unprivileged userspace through /proc/cmdline.

I tested this on real LoongArch hardware (ACPI/UEFI) with the live update
two-stage kexec test and the test passes:

$ sudo ./luo_kexec_simple --stage 1
# [STAGE 1] Starting pre-kexec setup...
# [STAGE 1] Creating state file for next stage (2)...
# [STAGE 1] Creating session 'test-session' and preserving memfd...
# [STAGE 1] Forking persistent child to hold sessions...
# [STAGE 1] Child PID: 1242. Resources are pinned.
# [STAGE 1] You may now perform kexec reboot.
$ sudo kexec -l /boot/vmlinuz-7.1.0-rc6 --initrd=/boot/initramfs-7.1.0-rc6.img --reuse-cmdline
$ sudo kexec -e

$ sudo ./luo_kexec_simple --stage 2
# [STAGE 2] Starting post-kexec verification...
# [STAGE 2] Retrieving session 'test-session'...
# [STAGE 2] Restoring and verifying memfd (token 0x1a)...
# [STAGE 2] Test data verified successfully.
# [STAGE 2] Finalizing test session...
# [STAGE 2] Finalizing state session...
#
--- SIMPLE KEXEC TEST PASSED ---
$ sudo dmesg | grep kexec
[    0.000000] [      T0] KHO: found kexec handover data.

I will send this as v4, folding in Mike's two selftest comments.  If you
see a problem with the EFI configuration table approach, please tell me
before I post.

Thanks,
George


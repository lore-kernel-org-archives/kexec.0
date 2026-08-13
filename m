Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00052C5DF67
	for <kexec@archiver.kernel.org>; Thu, 13 Aug 2026 16:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WCiQ2PIGfe2qaMn38Q/OEHxu2Z2ztzJDsBcYH2TPtp8=; b=N7VGJqQBm+6I8Y2g8+KK6mI5LV
	eyIR7vntYwtqBUgMHa2JW+I8GKWWovhgFu7RGwyN3cQI+qIuZB7cioSX/IRdvIREgiNOhNU1+ZByO
	5FSx2Y0iHvnhGQ3+O9oDAhqwLihiofp/K73OFpZ+HEA9griVy5p1jOakzWf8XUzFhme5KZ6lGLQq/
	3yU1JzWRYbO45Nv7h0YTqEHXaExvTQ4u1iVJbttXZoDTV9Y+C3C0ECLBhUyHCCUOgCAC5nsHzb60V
	N1Uz6HQqa7C09+ZeXAE4cwj5OSfraFfOEYN5u63qMuCIWHMtMbQVPIdqn46Fz/bE7er/WrvtX0JtO
	bW0dyxvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuXts-000000016SD-3i9g;
	Thu, 13 Aug 2026 16:03:24 +0000
Received: from out-91.mta1.migadu.com ([2001:41d0:203:375::5b] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuXtp-000000016RT-3T3f
	for kexec@lists.infradead.org;
	Thu, 13 Aug 2026 16:03:23 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=TfiVg463NFynci603WWT4ZTChHOhrPxJeP6Z8Zrf2Es=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786636998; v=1; x=1787241798;
 b=byX9NwPRkbxM1XhzsTNegiKtHm0dUVHF8oqKNC4vOuM6GteEP6xfak+TUS+0m+AYpqTrBJS3
 nce5+FJ55Y6tCCUKmiF7c3QkfDs/lLOMzYfCLKXeHwIRoeB1PbXeXWgQyUm81ELXPmGB8hJ+awl
 hmoUeEwcfSk9WLLOzuI2dI/c=
X-Envelope-To: kexec@lists.infradead.org
Received: from localhost (223.70.159.239)
	by smtp.migadu.com with ESMTPS id 86f3e37813a2a36a;
	Thu, 13 Aug 2026 16:03:14 +0000
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org
Cc: rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	shuah@kernel.org,
	ardb@kernel.org,
	guodongtai@kylinos.cn,
	kernel@xen0n.name,
	graf@amazon.com,
	liukexin@kylinos.cn,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 4/4] selftests/kho: add LoongArch vmtest support
Date: Fri, 14 Aug 2026 00:03:07 +0800
Message-ID: <20260813160307.15130-1-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAAhV-H7+1bv6ULPO1+SZ5R=XFxNTh+54rqnYQUAW26kF83kiMg@mail.gmail.com>
References: <CAAhV-H7+1bv6ULPO1+SZ5R=XFxNTh+54rqnYQUAW26kF83kiMg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260813_090322_009810_25011A83 
X-CRM114-Status: GOOD (  13.29  )
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

Hi Huacai,

On Sun, 9 Aug 2026 at 12:16, Huacai Chen <chenhuacai@kernel.org> wrote:
> You never answer me why in your test you should disable i8042 from V1
> until V4. In normal use we use a single kernel for both host and guest.

I owe you an apology: I did not actually understand your question. I
thought the commit message had already explained the reason (the
i8042_flush() panic), so I treated it as answered and never addressed
what you were really asking. Let me answer it directly now.

You are right that this is not just a selftest detail. i8042 is built on
every LoongArch kernel: arch/loongarch/Kconfig selects
ARCH_MIGHT_HAVE_PC_SERIO, and KEYBOARD_ATKBD and MOUSE_PS2 (both default
y) select SERIO_I8042 under it. So your "single kernel for host and
guest" point is correct -- a normal defconfig kernel has i8042 built in.

On the QEMU virtual machine there is no i8042, so PNP finds nothing and
i8042_pnp_init() falls back to probing the i8042 status and data
registers (I8042_STATUS_REG, I8042_DATA_REG) directly. On LoongArch those
registers are memory-mapped, and on the virtual machine they are not backed
by any device, so i8042_flush() takes a page fault and the kernel panics
before userspace. A normal LoongArch defconfig kernel booted as a QEMU
guest hits the same panic -- the "# CONFIG_SERIO_I8042 is not set" in
loongarch.conf is only a workaround to let the KHO selftest boot, not a
fix.

The real fix is separate from the KHO series: make i8042 bail out on
LoongArch when ACPI/PNP does not describe a controller, so the direct-port
fallback never runs. I have prepared that as a standalone patch -- the
relevant hunk is below -- and will send the full patch separately. The
selftest workaround can be dropped once it lands.

diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -1633,8 +1633,14 @@ static int __init i8042_pnp_init(void)
 #else
		pr_info("PNP: No PS/2 controller found.\n");
 #if defined(__loongarch__)
-		if (acpi_disabled == 0)
-			return -ENODEV;
+		/*
+		 * LoongArch legacy I/O ports are memory-mapped and are not
+		 * safely probeable when no controller is present: a direct
+		 * probe faults on the QEMU virtual machine and on any FDT-based
+		 * boot.  Do not fall back to probing them directly; if ACPI/PNP
+		 * did not describe a controller, assume there is none.
+		 */
+		return -ENODEV;
 #else
                if (x86_platform.legacy.i8042 !=
                                X86_LEGACY_I8042_EXPECTED_PRESENT)

Thanks,
George


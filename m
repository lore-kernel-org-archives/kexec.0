Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CA2C10F04
	for <kexec@archiver.kernel.org>; Fri,  8 Dec 2023 07:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3lqK3HFVtYLFo/UuSJUSf7DuGZBSXatAvfB08PDq8CY=; b=h6AtjwD7U9bVux
	IwGiynq9mKdU2PFYME5zrfiGeGmZis1DDRetTNVVo18n4c2gbhKHPocSvQUxXAWBKWSbaenZOzc8n
	JEVDMSvAO4rdPCwRZaURUH5Gq8BoRTlvV7oMatTJ1zxpijGzm1p93uKlozjzBjDJseFsxbHFSCszU
	t96zuBYONT88mJEWOMYhraB8G5uPd439TADjI81m8zxBIr3TXMcQOnPTq3vjrIyL1ynYKEWu9/k3V
	CcL//nYl5MDxOzGKr+EYfX69waN5agwfqMOOTRlloMK+ZHzQnORDwpmg0nJoHvLh27pw8NjzkoCe/
	cAskTjnmihyh3KucxmcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBVWH-00EzD9-09;
	Fri, 08 Dec 2023 07:43:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBVWD-00EzCN-31
	for kexec@lists.infradead.org;
	Fri, 08 Dec 2023 07:43:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702021406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mD12z3Ph+93M5Ou5tdqyf4RyVew89UEB1udxQaJBbFk=;
	b=QGJrQDWjCH4obV445rTLcS7KffDO+BNTxQJQ4fzlsQIBYMeLBn/+UXEDi8Qy3NIo1EMtHo
	B5ZyLuqtM06P/fRiIq12vkVSKmZ3WlFmHtvjmTU0t4m1KcUqjr32h0tdNBwKNdxSVq2a4y
	NQer9PdlYW4qtTzETPXiEjM6MWro9vs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-InC0YeG0PumZKyP_DYV22Q-1; Fri,
 08 Dec 2023 02:42:43 -0500
X-MC-Unique: InC0YeG0PumZKyP_DYV22Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37ABF3C0274D;
	Fri,  8 Dec 2023 07:42:43 +0000 (UTC)
Received: from localhost (unknown [10.72.112.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 89CD58CD0;
	Fri,  8 Dec 2023 07:42:42 +0000 (UTC)
Date: Fri, 8 Dec 2023 15:42:39 +0800
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, loongarch@lists.linux.dev,
	kexec@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-sh@vger.kernel.org,
	x86@kernel.org, akpm@linux-foundation.org, eric_devolder@yahoo.com,
	sfr@canb.auug.org.au, ignat@cloudflare.com
Subject: Re: [PATCH 0/5] kexec: fix the incorrect ifdeffery and dependency of
 CONFIG_KEXEC
Message-ID: <ZXLI748b85be459B@fedora>
References: <20231208073036.7884-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231208073036.7884-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231207_234330_066402_470402EE 
X-CRM114-Status: GOOD (  12.79  )
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

Forgot adding kexec to CC, add it now.

On 12/08/23 at 03:30pm, Baoquan He wrote:
> The select of KEXEC for CRASH_DUMP in kernel/Kconfig.kexec will be
> dropped, then compiling errors will be triggered if below config
> items are set:
> 
> ===
> CONFIG_CRASH_CORE=y
> CONFIG_KEXEC_CORE=y
> CONFIG_CRASH_DUMP=y
> ===
> 
> E.g on mips, below link error are seen:
> --------------------------------------------------------------------
> mipsel-linux-ld: kernel/kexec_core.o: in function `kimage_free':
> kernel/kexec_core.c:(.text+0x2200): undefined reference to `machine_kexec_cleanup'
> mipsel-linux-ld: kernel/kexec_core.o: in function `__crash_kexec':
> kernel/kexec_core.c:(.text+0x2480): undefined reference to `machine_crash_shutdown'
> mipsel-linux-ld: kernel/kexec_core.c:(.text+0x2488): undefined reference to `machine_kexec'
> mipsel-linux-ld: kernel/kexec_core.o: in function `kernel_kexec':
> kernel/kexec_core.c:(.text+0x29b8): undefined reference to `machine_shutdown'
> mipsel-linux-ld: kernel/kexec_core.c:(.text+0x29c0): undefined reference to `machine_kexec'
> --------------------------------------------------------------------
> 
> Here, change the incorrect dependency of building kexec_core related object
> files, and the ifdeffery on architectures from CONFIG_KEXEC to
> CONFIG_KEXEC_CORE.
> 
> Testing:
> ========
> Passed on mips and loognarch with the LKP reproducer.
> 
> Baoquan He (5):
>   loongarch, kexec: change dependency of object files
>   m68k, kexec: fix the incorrect ifdeffery and build dependency of
>     CONFIG_KEXEC
>   mips, kexec: fix the incorrect ifdeffery and dependency of
>     CONFIG_KEXEC
>   sh, kexec: fix the incorrect ifdeffery and dependency of CONFIG_KEXEC
>   x86, kexec: fix the wrong ifdeffery CONFIG_KEXEC
> 
>  arch/loongarch/kernel/Makefile  |  2 +-
>  arch/m68k/include/asm/kexec.h   |  4 ++--
>  arch/m68k/kernel/Makefile       |  2 +-
>  arch/mips/cavium-octeon/smp.c   |  4 ++--
>  arch/mips/include/asm/kexec.h   |  2 +-
>  arch/mips/include/asm/smp-ops.h |  2 +-
>  arch/mips/include/asm/smp.h     |  2 +-
>  arch/mips/kernel/Makefile       |  2 +-
>  arch/mips/kernel/smp-bmips.c    |  4 ++--
>  arch/mips/kernel/smp-cps.c      | 10 +++++-----
>  arch/mips/loongson64/reset.c    |  4 ++--
>  arch/mips/loongson64/smp.c      |  2 +-
>  arch/sh/include/asm/kexec.h     |  4 ++--
>  arch/sh/kernel/Makefile         |  2 +-
>  arch/sh/kernel/reboot.c         |  4 ++--
>  arch/sh/kernel/setup.c          |  2 +-
>  arch/x86/boot/compressed/acpi.c |  2 +-
>  17 files changed, 27 insertions(+), 27 deletions(-)
> 
> -- 
> 2.41.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

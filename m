Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EE3C678DB
	for <kexec@archiver.kernel.org>; Mon,  6 Mar 2023 03:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=/06a3Bhe/VbK1kdeyvWLg/DK6/6kAoHUvNFlYw8Ytbw=; b=JFrjEHTqm1D3D8
	wXqCWM5BSRjWYwO64OSd46n8P9iwqbb7zKGUkXvPc6hqK0Z3A0xENxptU6hgJXVJGqSFveGWQj1mt
	XAIEndPKCMHqyCQ3iZ8Pbf9YEpbn9ha+iRi+qSWfeIPki67BXfy1nKG1kejCgPC4VwS5aXbdZ7TWQ
	kxA8oKeu8SoKPfuYbjgHLGBXvbrAs8KMWZe47FJVhAyiwO2LHLDikSnGHXRwi4L4dPaFr6NWGpYAy
	TF7FqtiuTwMj+SR0wONhqWVXxGYtQrljy8F2zVB8xraGz6aqBJtElMeX+4bbQMZXCpPcWJq7uMiir
	AHXiNZjWS5wsvIjjo6Fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ18c-00B2Vs-QU; Mon, 06 Mar 2023 03:03:46 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ18L-00B2Oo-No; Mon, 06 Mar 2023 03:03:31 +0000
Received: by mail-pl1-x62c.google.com with SMTP id p6so8834954plf.0;
        Sun, 05 Mar 2023 19:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678071807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GYopMUaQRW9Dv0DHFros5KA77xZDqrJK6NU0WooYypU=;
        b=X3JAn9LL3tBtDUT+BbLvnP6eATZM7qc5rqV2LaZVW1t7hPPZcn3usqeIfQYzV2JqiS
         sVRCxguJTHLczZJGcNJe8SzvKxJxv66vX03Hae3/o4IaZlp0+WLCQBGO9aao/V6d2IM9
         GnK1fctWu4SfY42KNVGCKuTLAQAf1iDIt8hdCbdgZgvqbxxENQC5v2n7+Ef6G1e0l299
         0+GjQ4xuJMw3C0VzL5nfVuf7XPLjNjkQ3NiJRGgBJwMFOxFi+SLC6RIFIBtWbuAseMXG
         iyOwDRoQg8cMCY5VXJLsQgT3VXDvLYPe57WErycdWslVjjkkPgQnA8aw3byLvdQrxG6v
         UEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678071807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GYopMUaQRW9Dv0DHFros5KA77xZDqrJK6NU0WooYypU=;
        b=J4mltVjK3VdZi/YOMHINbDU+1BFT3p+gWMzDWX2TtMaMdj6mVC5U04wO2XmtvF1hKI
         zCBdABJbZU6J1ijxucFnxOOH3upMQjaBxK7ddNT1m/0zZFR9CjMWGt9AaHk7ucSKB2s0
         hrgakbXzkj/fk+1M8IofVJjqZVDgvvjJBLqqDwr4BtuWrbmep0zvSS3o/T9nURRjUGxB
         oTWmdE7i0HjDn1ES6uJRy4JURKpvj2039KHR+9w+/owYsq0kc+pwuiz/jGr6LiqVf+tg
         yfUgmQc81EBsDs/XiAyrI7n8yXdgIJi6GC4cKiAbUyUUxzdf7EU9XCrZIKFKeINHCANn
         WJmg==
X-Gm-Message-State: AO0yUKUhJ4kufCRlcMwFbbE676PhSlswdkPL+F4daq7EtY6vIDOWeKGB
	JJ5XRkozHDJrz9abOfUDYNdMfAop9g==
X-Google-Smtp-Source: AK7set8MGWb52Jm1pOUgvUaZvO0N8sqK6Q1bmEy5eoJ0WrhT3EB7tvx03iog7dzsZQLFMpfes3oJcg==
X-Received: by 2002:a17:903:2cb:b0:19c:f747:2517 with SMTP id s11-20020a17090302cb00b0019cf7472517mr12094679plk.1.1678071807419;
        Sun, 05 Mar 2023 19:03:27 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id jy16-20020a17090342d000b0019719f752c5sm5410439plb.59.2023.03.05.19.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 19:03:26 -0800 (PST)
From: Pingfan Liu <kernelfans@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Pingfan Liu <kernelfans@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	kexec@lists.infradead.org
Subject: [PATCH 0/6] arm64: make kexec_file able to load zboot image
Date: Mon,  6 Mar 2023 11:02:59 +0800
Message-Id: <20230306030305.15595-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230305_190329_810051_5E3493AE 
X-CRM114-Status: GOOD (  15.56  )
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

After introducing zboot image, kexec_file can not load and jump to the
new style image. Hence it demands a method to load the new kernel.

The crux of the problem lies in when and how to decompress the Image.gz.
There are three possible courses to take: -1. in user space, but hard to
achieve due to the signature verification inside the kernel.  -2. at the
boot time, let the efi_zboot_entry() handles it, which means a simulated
EFI service should be provided to that entry, especially about how to be
aware of the memory layout.  -3. in kernel space, during the file load
of the zboot image. At that point, the kernel masters the whole memory
information, and easily allocates a suitable memory for the decompressed
kernel image. (I think this is similar to what grub does today).

The core of this series is [5/6].  [3,6/6] handles the config option.
The assumption of [3/6] is kexec_file_load is independent of zboot,
especially it can load kernel images compressed with different
compression method.  [6/6] is if EFI_ZBOOT, the corresponding
decompression method should be included.


Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: kexec@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
To: linux-kernel@vger.kernel.org

Pingfan Liu (6):
  arm64: kexec: Rename kexec_image.c to kexec_raw_image.c
  lib/decompress: Introduce decompress_method_by_name()
  arm64: Kconfig: Pick decompressing method for kexec file load
  lib/decompress: Keep decompress routines based on selection
  arm64: kexec: Introduce zboot image loader
  init/Kconfig: Select decompressing method if compressing kernel

 arch/arm64/Kconfig                            |  59 ++++++
 arch/arm64/include/asm/kexec.h                |   4 +-
 arch/arm64/kernel/Makefile                    |   2 +-
 .../{kexec_image.c => kexec_raw_image.c}      |   2 +-
 arch/arm64/kernel/kexec_zboot_image.c         | 186 ++++++++++++++++++
 arch/arm64/kernel/machine_kexec.c             |   1 +
 arch/arm64/kernel/machine_kexec_file.c        |   3 +-
 include/linux/decompress/generic.h            |   2 +
 include/linux/decompress/mm.h                 |   9 +-
 include/linux/zboot.h                         |  26 +++
 init/Kconfig                                  |   7 +
 lib/Kconfig                                   |   3 +
 lib/decompress.c                              |  17 +-
 13 files changed, 314 insertions(+), 7 deletions(-)
 rename arch/arm64/kernel/{kexec_image.c => kexec_raw_image.c} (98%)
 create mode 100644 arch/arm64/kernel/kexec_zboot_image.c
 create mode 100644 include/linux/zboot.h

-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

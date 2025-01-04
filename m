Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C20E77197
	for <kexec@archiver.kernel.org>; Sat,  4 Jan 2025 14:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=BKNiV3QEEiOj1Le3vlBLmpRmhzkmvu5zT7BlJh3wiAc=; b=B+oGTOLklsJ21o
	lphMir3tqsrtoFLJcXL7m0LVFVZHsGAmhWHWHESNBopbsE+KuNnCTWbhFhwLbny9G1NGZZ2FqmGJL
	wfbhSdh47pHWVz01+kZRD9qh7rqPvAP80y2k4VPptN2If2MMMVibWSVoIpQSyAMh+defntV0tUiSL
	he3nWCXMZbf2UfN7qrG2CUW1CsIebkwCKkV7pEE6uDuAiMeISroZNIdUWJcYxR53DMt5LLTqO12JY
	aUIr5Vj0/DVBD5D5Rgita2WQk8ABr6Ln8GFXdoB7SnXShxPSEegi8+EijyD5dcxhS0USKSFubEeeU
	DIK8UIRcjMwlWYVfxVSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tU5Ig-0000000F7b2-0JgT;
	Sat, 04 Jan 2025 14:38:50 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tU5Ia-0000000F7aZ-1Bey
	for kexec@lists.infradead.org;
	Sat, 04 Jan 2025 14:38:45 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-216426b0865so180194475ad.0
        for <kexec@lists.infradead.org>; Sat, 04 Jan 2025 06:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736001523; x=1736606323; darn=lists.infradead.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BKNiV3QEEiOj1Le3vlBLmpRmhzkmvu5zT7BlJh3wiAc=;
        b=mGnktnkEMB1yAD8PxTc19DaNA9ir2QzPukcT1JSTO28YVsXxVEHYE+cMbDzJrr21g4
         FvmkbiEqPzndHHYD3X5BLs0y6TVUKbQ8pFrE2+mH833yBql51kwCMFUfqhNKt/kiAvVR
         Rxubs+Pb0J7vnTM1CHko93Q2LePbncpRNiElFyGLSdZnwT0J8JajSycqdFw7h1j2AO00
         7CDKRCrr6uFggTSdrSSbtLOd/lEkpVkumKbabww8DPoGCYnlo/GXNeSKryUi1J4/FGbE
         piou+S9k0n3n/ODIfBZUvh1nIwVeFWyV0Y2bT8C2kD40/8RHhZ5jTv/WO/HsHAggJQfg
         UVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736001523; x=1736606323;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKNiV3QEEiOj1Le3vlBLmpRmhzkmvu5zT7BlJh3wiAc=;
        b=WdzxrhIIwPN2gb1zJo7IN1HB/zmVX85P0EzpSfzEby+iFTH1oQf4/I1/68+Oh29bNA
         Q2fmLb+Dr7v4w++HXwy7KQlSQOfuMr8b05vUIhVzh1MNTX8OJ6QYRfIVErquj1uaMLJy
         ZSwFg+NJ+8qN30VrDNYLnj3pPHtx7x12VQvu+rP0kW8R6csv7st8chdRe6SpV0cCPQYR
         f0IGPWVtjm/UPKVdc8H3gISq/Yj3TwLKmb97F+TLgk86brFkudycsqxuJ9AQjR8NwwND
         Jz7g2ZyJqukmiDaIINcP1PCgbs+k3XF4cmrpIDMjYeItF/4UnJ3qjvq7UY/GHCiLA4s6
         FWBg==
X-Forwarded-Encrypted: i=1; AJvYcCXOCYs2GkV4ZYCqnfmeh21FatmDuuDFkuoT2mk16qS7LixBsSTGmPzS7Jx5R9lYZKcbWEf5og==@lists.infradead.org
X-Gm-Message-State: AOJu0YwEZvZwEhShhF3s5wto8ydan7k776oW4MSDRKK2cQQhj8Rr/xhp
	lrrA8oreX8pPLtdsSxzY8/3y2X6cDitAPV86TpEN/zjTXqKx+6sDgQk+ZJz0RQY=
X-Gm-Gg: ASbGncu2etuVBmJAJe7JKp1k5XAYXXsTnpChNR5ScgwS9boC7cmSfqA5Oe954K83mWT
	BOFOCalXalRYG1I72yWXxM8m7tMtiRNxFMWbfJ9USocBXMyD2O7ZQO+zw2ZCmZH4iI6TMsshwMD
	HxuWiA9mRkTQ7dYb0DsKJhIkm7KTbnbBePVa5AJig8Q+NycxCO4IExUVwbuLnJM51iTEi9P+Zt/
	+SBFXeRHhGR1SzPmwYlxAgcij9f+moOaAlsWAWeCFtVBIAq3k9LhNAhYBQkmHU=
X-Google-Smtp-Source: AGHT+IHMKqIuk9Mp4P+qfjslbof1yC0x6Ct9CbXfed2Znwm+wkFLa5rTAL+cuIXWXtg5bkhTzZKJyg==
X-Received: by 2002:a17:903:2286:b0:215:b087:5d62 with SMTP id d9443c01a7336-219e6f1483fmr809248225ad.36.1736001522852;
        Sat, 04 Jan 2025 06:38:42 -0800 (PST)
Received: from localhost ([2400:4050:b783:b00:4952:3c52:120a:27e9])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-219dc97182dsm261833855ad.82.2025.01.04.06.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jan 2025 06:38:42 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 0/5] elf: Define note name macros
Date: Sat, 04 Jan 2025 23:38:33 +0900
Message-Id: <20250104-elf-v2-0-77dc2e06db4e@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOlHeWcC/y2MywrCMBBFf6XM2kieaFz5H9JFTKZ2QFNJJLSU/
 LsxuDyXe84OGRNhhsuwQ8JCmZbYQB4G8LOLD2QUGoPkUgspOMPnxO5njk5Zbb2y0J7vhBOtvXI
 bG8+UP0vaerSI3/r3pel+EUywk0WruTI8GH4Nbou0Hv3ygrHW+gVYO/OllwAAAA==
To: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
 Dave Martin <Dave.Martin@arm.com>, Baoquan He <bhe@redhat.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 kexec@lists.infradead.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250104_063844_595737_32F2C86D 
X-CRM114-Status: GOOD (  11.69  )
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

elf.h had a comment saying:
> Notes used in ET_CORE. Architectures export some of the arch register
> sets using the corresponding note types via the PTRACE_GETREGSET and
> PTRACE_SETREGSET requests.
> The note name for these types is "LINUX", except NT_PRFPREG that is
> named "CORE".

However, NT_PRSTATUS is also named "CORE". It is also unclear what
"these types" refers to.

To fix these problems, define a name for each note type. The added
definitions are macros so the kernel and userspace can directly refer to
them.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- Added a macro definition for each note type instead of trying to
  describe in a comment.
- Link to v1: https://lore.kernel.org/r/20241225-elf-v1-1-79e940350d50@daynix.com

---
Akihiko Odaki (5):
      elf: Define note name macros
      binfmt_elf: Use note name macros
      powwerpc: Use note name macros
      crash: Use note name macros
      crash: Remove KEXEC_CORE_NOTE_NAME

 arch/powerpc/kernel/fadump.c               |  2 +-
 arch/powerpc/platforms/powernv/opal-core.c |  8 +--
 arch/s390/kernel/crash_dump.c              |  2 +-
 fs/binfmt_elf.c                            | 21 ++++----
 fs/binfmt_elf_fdpic.c                      |  8 +--
 fs/proc/kcore.c                            | 12 ++---
 include/linux/kexec.h                      |  2 -
 include/linux/vmcore_info.h                |  3 +-
 include/uapi/linux/elf.h                   | 86 ++++++++++++++++++++++++++++--
 kernel/crash_core.c                        |  2 +-
 10 files changed, 111 insertions(+), 35 deletions(-)
---
base-commit: a32e14f8aef69b42826cf0998b068a43d486a9e9
change-id: 20241210-elf-b80ea3949c39

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>



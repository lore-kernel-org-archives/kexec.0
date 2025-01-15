Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08908C02180
	for <kexec@archiver.kernel.org>; Wed, 15 Jan 2025 05:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Akn62yShjkzTVW+wH6ehtLyqM9iw3YLFKJEmmviG+rI=; b=ztZb3KPV6kPh+T
	bsTRllH0EU+dGmFu3Agr0X4C+NHXBpGt0hSzQeSeIZ2UqoAKak/eSZYz9Me3RYmiVlmq7worBKVP0
	F6cjh7wQe2NRNbB9sq285Y+OFZr6rlUyBH/MemEbUYKIVR0MR5JByXFZQoov2kf1AmnmfQ5ZmY2vN
	oiSMq/GFnwoCs0wHOTX3ZxeIF2gR88dmcxZDnE7MtBZUM/GOHbDbLlam1XR0wVylBPWZNylBhx9nz
	gcdJSlqaG+rHrTZ001ujxQU20SgF3sg2PU3rlQ1OI2tUOD4ArgTf1pA+VcWe//370byrBs6tXMWpW
	l3SnoLhZBbAyDGD8MdmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXwGf-0000000Aixg-2dkX;
	Wed, 15 Jan 2025 05:48:41 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXwGb-0000000Aivk-2hEw
	for kexec@lists.infradead.org;
	Wed, 15 Jan 2025 05:48:39 +0000
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2efd81c7ca4so8327007a91.2
        for <kexec@lists.infradead.org>; Tue, 14 Jan 2025 21:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736920116; x=1737524916; darn=lists.infradead.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Akn62yShjkzTVW+wH6ehtLyqM9iw3YLFKJEmmviG+rI=;
        b=p4JvX+x7yO7Zvs4LMelRi3EcgUg9ntZFnuPjPMfhfHKiGX37oVcA+faWC4BfcZY4nM
         uNRphqpuclHErxN7uZ7/bAI4AabDaaWDK6yAVm6xtCFeVbNen5BCwCiSz9IpbPnt1KqU
         JliyLdgbMqLaCkWrrB402PMN5tEQf9hPF/U6vtyCTovCiOrC5EA5p/I0qEDUCDprS8+r
         vq4V3Wtl9tqqljMwVRvZilgosY5JFpp3V5CQd5L1U7+/J8OjhxcWTx5XE86YP99bYh5N
         ukUdOnIKKF63qnCgcHMLuQnXBV+KdADgdU9GhJE4mBqGMzXRKZzwt3nfHgaeVqNJseES
         x0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736920116; x=1737524916;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Akn62yShjkzTVW+wH6ehtLyqM9iw3YLFKJEmmviG+rI=;
        b=gDAsuP0xt9X6tRcxVIJgVv8Xc0pctd4RN8pB7Zdrrwvrjl2e7hTrEyCC2R8XMnbJEh
         kH/7Rhlj1m1HittgaarlvGeL1Ek+UN5p0XUQ4IRKjf/PjcmP/is96/X6f9vjgtYhjZpd
         7bhEgIqicWrdTDtqYG1xKTjtgLZaIicFRAJ85ZWLkInuUq3ZJXD1E1S319n31MPmfCjO
         no+KG5TzQb2EoX7CY0PS0jlQchYbFnxAWuwJWVQQwQpPkazxOjGBsuPk/kRbphNPnQxx
         YH6rcUtQwm/bhxuB0BdU3KjIqwlCTLJSeARD4A/+cjLqahfOxu/Fx4jYyFgQKsC1JBOZ
         40nA==
X-Forwarded-Encrypted: i=1; AJvYcCWEzYv/EZiOlyw0RM0bcw/DKeQcUKi4r/zEELPEMTYsK5C2RRXE2gBSJaFy66KAYL2arFQJJg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwQJ+LTzLfeXKH4JFpL9ZQwWL31cwirMNykR0pQkO/7o0BFYktE
	681fezKzPMBKLRfQhiQDKFWcsknIwk9D/kxRrRR6x0Ftp85Ltim4tnQrM/IgOKs=
X-Gm-Gg: ASbGncvUn7GGBItZaTaYqGBy3G47vOf+3ykIyFvcW/7M7t00zLtjje2eiy9J/8ZABev
	Nq5Zi5gt/h7FktCpsRGEZJGK4BQes7ZRbliNO0D8NtjBhn7zyE5Pj99vXXhDHuvdnYgZWWmooEy
	pahkqU/q1DSJBJfbidEUMMYBHyldTsf+BL3BKJgXBpgvMtgXWDsizEP5/PVcfzWDAZqp1uB4DQo
	vKfV2MydmK6GiwUi0tWsZyjv9ROw/Amcc0CnveuQ8MgTeuk7kySc1YqFOk=
X-Google-Smtp-Source: AGHT+IGTAFr6fQ9a6YArcK/8amGmkIoCg+M7qyB/EhAZVK1D/0q1h57yniAmS1nzzXQhV2aOnFsX2A==
X-Received: by 2002:a17:90b:3bc3:b0:2ee:bbd8:2b9d with SMTP id 98e67ed59e1d1-2f548f75de6mr34075229a91.34.1736920116365;
        Tue, 14 Jan 2025 21:48:36 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f72c1cb28csm504577a91.21.2025.01.14.21.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 21:48:35 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 0/6] elf: Define note name macros
Date: Wed, 15 Jan 2025 14:47:57 +0900
Message-Id: <20250115-elf-v5-0-0f9e55bbb2fc@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA1Mh2cC/2XMyw6CMBCF4VchXVsz04tYV76HcdHLoE0UDBgCI
 by7BTTBsDyT+f6BNVRHatgpG1hNbWxiVaahdxnzd1veiMeQNhMgFAoETo+CuyOQlUYZLw1Ln6+
 aitjNlcs17Xts3lXdz9EWp+vXCz37Fjny3JBRIDUEDedg+zJ2e1892RRoxQ9pQFALEhx4ngcvC
 A7BKdoguUb5gmRCxninQTu0TmyQWiHEBamEnDwqLCwEH8wfGsfxA3RS27E2AQAA
To: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
 Dave Martin <Dave.Martin@arm.com>, Baoquan He <bhe@redhat.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, 
 LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 kexec@lists.infradead.org, binutils@sourceware.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Heiko Carstens <hca@linux.ibm.com>
X-Mailer: b4 0.14-dev-fd6e3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_214837_961344_86E7626B 
X-CRM114-Status: GOOD (  16.02  )
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

For userspace program developers
---------------------------------------------------
While the main purpose of new macros is documentation, they are also
hoped to be useful for userspace programs. Please check patch
"elf: Define note name macros" and if you have a suggestion to make it
more convenient for you, please share.

I added the Binutils mailing list to the CC as it contains code to parse
dumps. I'm also planning to share this series on LLVM Discourse.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v5:
- Noted that patch "elf: Define note name macros" allows removing
  duplicate definitions of note names.
- Reordered NT_GNU_PROPERTY_TYPE_0 to precede notes used in ET_CORE to
  show its not specific to ET_CORE.
- Link to v4: https://lore.kernel.org/r/20250111-elf-v4-0-b3841fa0dcd9@daynix.com

Changes in v4:
- s/powwerpc/powerpc/
- s/NT_INIT/nt_init/g s/NT_SIZE/nt_size/g
- Removed parentheses that have little value.
- Fixed the code alignment in get_cpu_elf_notes_size().
- Link to v3: https://lore.kernel.org/r/20250107-elf-v3-0-99cb505b1ab2@daynix.com

Changes in v3:
- Added patch "s390/crash: Use note name macros".
- Changed to interleave note name and type macros.
- Described NN_ and NT_ macros.
- Link to v2: https://lore.kernel.org/r/20250104-elf-v2-0-77dc2e06db4e@daynix.com

Changes in v2:
- Added a macro definition for each note type instead of trying to
  describe in a comment.
- Link to v1: https://lore.kernel.org/r/20241225-elf-v1-1-79e940350d50@daynix.com

---
Akihiko Odaki (6):
      elf: Define note name macros
      binfmt_elf: Use note name macros
      powerpc: Use note name macros
      crash: Use note name macros
      s390/crash: Use note name macros
      crash: Remove KEXEC_CORE_NOTE_NAME

 arch/powerpc/kernel/fadump.c               |  2 +-
 arch/powerpc/platforms/powernv/opal-core.c |  8 +--
 arch/s390/kernel/crash_dump.c              | 62 ++++++++-------------
 fs/binfmt_elf.c                            | 21 ++++---
 fs/binfmt_elf_fdpic.c                      |  8 +--
 fs/proc/kcore.c                            | 12 ++--
 include/linux/kexec.h                      |  2 -
 include/linux/vmcore_info.h                |  3 +-
 include/uapi/linux/elf.h                   | 89 ++++++++++++++++++++++++++++--
 kernel/crash_core.c                        |  2 +-
 10 files changed, 134 insertions(+), 75 deletions(-)
---
base-commit: a32e14f8aef69b42826cf0998b068a43d486a9e9
change-id: 20241210-elf-b80ea3949c39

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7A4E7719D
	for <kexec@archiver.kernel.org>; Sat, 11 Jan 2025 05:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=3P73rJyuNl3Q0nwSoWVJRyshylUCVEtly88Ev7msAUs=; b=PNzpEc9WiLtGds
	7T0htnpbibNFf7vOP47d5RRs0XCqTRHAyHASInshI2efL1Rq79IMwml5rTyRABAvkT9OLEA93EK9X
	FKV0Bz+Dg7ceALFjx4Lhlr+fypeLmxpxv4zxziAfbka9xE/1VkImY6y0sj+JzCdFkJq4wYES3exb9
	zoJ+cgxXsMQqnmDg0X0szXnxB+2kpK2WViMwD7khJA4Xz8osYbTKGBspjiNiMNfi44xH2kwRJ6y1e
	qJeV/+0L5s7lL3YAGKLScYn1IyIbBHSAo4vaD8Iy0CMJGGqccesbOZfQ+vY1HKDZsKZ0spcJQwhY9
	yY16FEf03QMVO/O3iFUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWUMk-00000000EYk-39ER;
	Sat, 11 Jan 2025 05:48:58 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWUMh-00000000EXu-1x4k
	for kexec@lists.infradead.org;
	Sat, 11 Jan 2025 05:48:56 +0000
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2ef89dbd8eeso3559889a91.0
        for <kexec@lists.infradead.org>; Fri, 10 Jan 2025 21:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736574534; x=1737179334; darn=lists.infradead.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3P73rJyuNl3Q0nwSoWVJRyshylUCVEtly88Ev7msAUs=;
        b=VnFLzTjneSSF3joEZaehSQufX08VNlyrz1A/8Tcn5ivtlipiwHRMmI1uY6QzKryl+y
         IWLS49WApmV1WvmwLqg2s56BFnKBLJ9OscrXZ6nk+JJqXJ9g5Q0K6AKJjs4f2MEsbxq9
         v9gW/vqC9Ddxt118JYjt53bTDbGjccnmth9V5CnJ3HgALNcJWSYswsqrHW0rtsIicxwL
         6wMqoN+x+ZPqvfprAL9hZj52zsTXSWmrJzfo7S1+8SAD/ZDhVGmRSjJtzuCHluaUGMiJ
         peajG4Kk+MLpNL5F3i42YN74CCKQgcnLznYMWzzLiiWkOPEWGeKrlIpkb0KLZf0KSqU0
         7lng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736574534; x=1737179334;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3P73rJyuNl3Q0nwSoWVJRyshylUCVEtly88Ev7msAUs=;
        b=pUrzcfts4uP/CTbr+Ms+6FL9BVAOoduijBo0ebedCqlK+mF9uObVmqIVSLs9oMlfv0
         phoUlu/sZd2Arp+lssUIj1WYDcF7VarRKLEpSldN5E+bLI5NzVUKBlgAx4fauu3enUjK
         VRm6Hqkib2vCHWakV6EZaTDK+5Q/d4n1WkXbjmGclsk41A55f9IeusWCdZaqqcFoPZVv
         GcMSUH+3BagCp7uLlz3B7pjNGt7M8r8IcttwV8JWvHIPL/JwMuvk7hywf3RWqOkhODiX
         c5yP7bfDgc2Y6Dk5jFJ9IUMzNCBrrD7W7QkXSpDLceloLjlmSWhhhqB6jIsrJUgOLk/r
         VJHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGYMhTz1GL01fdkSjwcx1fu4HeVuY4Yk8srULrSWHHuYuZ/KgQmA48SK+6YFCgS8lgQbjZLg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwEoZf5G1/Gtw1Yo0og883bnXGriPWa89mW7PhpoVhMR3VYMs4O
	hWI/ea2dQkoD6O/v/MYLSzqVWvluw1OuZ6HAhnpJ83TGFJ5PiBVaWdWcp6C5E3g=
X-Gm-Gg: ASbGncuPV2Retzzgryz6JV3p1VVu4AjLiEuasxgr2IM5wDGhwBykFTnB2GE2Gu26jkh
	50clPq3SUR5aIF2O9JSZL9vCm+KDCjrdbX/ORyIYytY8e2AU9SL0MevSJx58ymhy8xavgLzEr6n
	mWR3FXAlufLbH/es9Ei6JLM4YcJI1WRhGqeqLbjbjeZvixlQGgiHr4+yNRXbLBHTWy+mkx9D/Zz
	Ku1gtJ/1tSiKF97UB0iOqmkLO5Fe9RZ36hxezcxckhUFuYbUUAYgm7HNMs=
X-Google-Smtp-Source: AGHT+IHnxhywBj4CVIR5TvzIlJFphpilQTNTWugzFhTp+kcciB5abGLTfjWrtU8KJEUcfzvGCQC8ng==
X-Received: by 2002:a17:90b:538e:b0:2ee:3cc1:793a with SMTP id 98e67ed59e1d1-2f548f580femr19629798a91.29.1736574534006;
        Fri, 10 Jan 2025 21:48:54 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21a9f1372e7sm21407345ad.83.2025.01.10.21.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 21:48:53 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 0/6] elf: Define note name macros
Date: Sat, 11 Jan 2025 14:48:43 +0900
Message-Id: <20250111-elf-v4-0-b3841fa0dcd9@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADwGgmcC/2XMywrCMBCF4VcpWRuZ3Kxx5XuIi1xGG9BWEgktp
 e9u2iooLs8w3z+ShDFgIodqJBFzSKFry5CbirjGtFekwZdNOHDJOAOKtwu1e0AjtNROaFI+HxE
 voV8qp3PZTUjPLg5LNLP5+vZcLT4zymitUUsQCryCozdDG/qt6+5kDmT+QQoYyBVxCrSuveMIO
 28l/iHxjeoViYK0dlaBssxY/oOmaXoB8zVRagEBAAA=
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
X-CRM114-CacheID: sfid-20250110_214855_509933_E9977C61 
X-CRM114-Status: GOOD (  15.64  )
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
 fs/binfmt_elf.c                            | 21 ++++----
 fs/binfmt_elf_fdpic.c                      |  8 +--
 fs/proc/kcore.c                            | 12 ++---
 include/linux/kexec.h                      |  2 -
 include/linux/vmcore_info.h                |  3 +-
 include/uapi/linux/elf.h                   | 86 ++++++++++++++++++++++++++++--
 kernel/crash_core.c                        |  2 +-
 10 files changed, 133 insertions(+), 73 deletions(-)
---
base-commit: a32e14f8aef69b42826cf0998b068a43d486a9e9
change-id: 20241210-elf-b80ea3949c39

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>



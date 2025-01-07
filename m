Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B452BE77199
	for <kexec@archiver.kernel.org>; Tue,  7 Jan 2025 12:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=opIuyGFUTzWuwcM2pYQXlXkOFxHji1aKoxh7XPTxYrQ=; b=rQrxKvVO2YEAdy
	Lv0V79WGdAKzN5h46AACWNl/Lnl7ArCLVDsGXlSXMBRZhimydKhGUMdZ67dEle7UZs8kABN0Vay2l
	hQLGdSsfK1P4xXcKqsNy2+gRgle/xompJm5LGBIDshBVBl9wAgEB8IfTtQARBzor+UC8efLbTDfzR
	AvksKvdyfZRDj4tI4b5HLicrAmI1xbrZLA5d9wxfiwJDCohHCoctycb/J+DpwhdV5DFhfuzCKR07H
	eB7SEaw1+FohD0K2N9kOn238WBJt3n25Bt/+sgP/GlsaTytXkH3UILVLj2oK6/17E1WGyHihw5fPO
	nFREcKqzgALw1FK4hClQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV90y-00000004phR-1e9I;
	Tue, 07 Jan 2025 12:48:56 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tV8zy-00000004pGY-0V6f
	for kexec@lists.infradead.org;
	Tue, 07 Jan 2025 12:47:57 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-219f8263ae0so178323785ad.0
        for <kexec@lists.infradead.org>; Tue, 07 Jan 2025 04:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736254073; x=1736858873; darn=lists.infradead.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=opIuyGFUTzWuwcM2pYQXlXkOFxHji1aKoxh7XPTxYrQ=;
        b=KYatoF/GSubJN9wrGZK4mzNGQbx9ZNoFwBHGrcKd2ss9G7fKuu0qYmXdYTanMv5bPB
         77eLhMMEhQbCdui5kPgpDX43Cq6y3QaQSkrdCdTzfwJhUhiWkwSN7TO0oKDSwnOd3W7d
         kGx5yR2VzIBa5dGXH80msU47mRa1adyZAkWwH304W7XBrT4OYoS2ftQHiS0HIIYa6ei8
         FeM4iivDANyLvfLMP9KCzpnPX+PAtiX34c4D5ofnUEoATcztqZV5oeQ5+JZggvi368tR
         KHovEB4/BikdZeDvfi8uk6rZNtwSliLejmDdpVAh9IXL4TEvUNLVoSTXuPTMMnUpQ7JT
         gI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254073; x=1736858873;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=opIuyGFUTzWuwcM2pYQXlXkOFxHji1aKoxh7XPTxYrQ=;
        b=fgQ2ZwrlILN0NiNQFt1rAlsqtQpDi9U/TWnyNpteefHxi0Fxyw9OBw9E+k4V/oolZ0
         sQmXAbQCLxnczJgfsP4SlHZC9JoDBAF7OMRT66Gakkwj2JOfqSnQedx9BQzono6p08Bo
         mrdW7N31BJhY5etuBaZdysEp8CWNNeoRmJp3Sy/qGUM8hz2zXUpB2ewLImYzJQnb9OYB
         Qcca48uZMe7ZZ1OdvSVXchycr7N/n8ULVzlZWrJ+1BTLg/dVVrl/9OjbcMitwBgQFOF/
         EiWW8XReGvUEf/cyTDGP+HPyGbvWY8K/36qYkUI60Y9WYdBQyQcBAhtqq/tSDPhA7781
         geVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlQ/l7Hm8s3avw+Upsft6o9umDZPcxV/g+h9n6ynob3CvTw5AjJn4JHpIkVbTHveMJ10jVQA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwWgj1ftsSgzqr+qEOLUWVW2XMUp3xk/sjQz0Wd5tCeTiqhzZlf
	JExZ1mfmgmGyGRwBG96UROBJbolMP5xq+OzDHhbqzgMM8rBj5F2JlR917ntFTAg=
X-Gm-Gg: ASbGncsMlgnutnt2yyqoTu70BQx7bXfF+Ae+UritTGQf5efkMF3wzF8uH/Hcb4UAzth
	FVzzJUOWGECIPv4bo3vpBJE+F2j33bRBISCIu5+Wj4PDuQ/3rdNVz8UjiLuJsEDAlPsB5l0OgzG
	ShBhEStmY/KyebXNdZYHP8QvhaELBXzc1Iz8vLKEz7F2B0pw58rLO8jsZz15Ee5n/ElF0305pTC
	SUT9IVxp+hPHsoGPKvIWJoU2XYQT2p2XCjWzKK6pkx3YAMJrrisp0Fknyk=
X-Google-Smtp-Source: AGHT+IH/TI3sUb6l2+b2WaTSh1evq6vZuS5S4szn4UoWwy5hsMxR0UzHoKY9BZVjFfB8co0JCgCCAg==
X-Received: by 2002:a17:903:11d2:b0:216:2f91:92c7 with SMTP id d9443c01a7336-219e6e89278mr972540505ad.12.1736254072686;
        Tue, 07 Jan 2025 04:47:52 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-219dc972b0dsm309970895ad.112.2025.01.07.04.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 04:47:52 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 0/6] elf: Define note name macros
Date: Tue, 07 Jan 2025 21:45:51 +0900
Message-Id: <20250107-elf-v3-0-99cb505b1ab2@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP8hfWcC/1WMwQ7CIBAFf6XhLGZZwIon/8N4aGFrSbQYMKRN0
 3+XVj14nJc3M7NE0VNip2pmkbJPPgwF5K5itm+GG3HvCjMEVAIFcLp3vD0CNdIoY6Vh5fmM1Pl
 xq1yuhXufXiFOWzSLdf36qDc/Cy54bcgokBqchrNrpsGPexsebA1k/EkaBKiPhBx4XTuLBAfXK
 vqTlmV5A7A3TXfMAAAA
To: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
 Dave Martin <Dave.Martin@arm.com>, Baoquan He <bhe@redhat.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 kexec@lists.infradead.org, binutils@sourceware.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_044754_427368_E156BEDB 
X-CRM114-Status: GOOD (  15.57  )
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
      powwerpc: Use note name macros
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



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CFAF5545F
	for <kexec@archiver.kernel.org>; Wed, 25 Feb 2026 06:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=aRRYrwJJKmmym1rA1RWT0WjPr4yt1zKA44KIR1qeZ14=; b=W6V12PuuVOYkd5
	KioXNmlEXmt2RXkx8jnis3ZdwENwQSU5Ui4OPHQkhsl7AmNT08JDrwJtcH6Tc81BJDZCjxkTdRL4T
	Yw2GBbTbIZdXJAr9Fq7C4z5nAkUPqJhpEshdfjXwqqVjO3gpZoWgScl2ejuhXw54Y6duxg6km+YIs
	4g+E9qzXy+aR9nOjMZtXExaQZl7GnLFC0m0+WZTri+ShJAwccfxwpK4yr6taeyiUjEQF4DMz9gmrj
	8UiHeLxAtwpN8RMfPXoQlwCNFCL95zJ0uTKEVPiqdu/ZOahpmpQqVjOpxiMS2w85dwULnORg+v3k+
	M3bqhw7h3Ou3Ul0vm0hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vv809-00000003H3e-0C8Z;
	Wed, 25 Feb 2026 06:04:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vv805-00000003H2O-3sND
	for kexec@lists.infradead.org;
	Wed, 25 Feb 2026 06:03:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771999436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aRRYrwJJKmmym1rA1RWT0WjPr4yt1zKA44KIR1qeZ14=;
	b=D8NIXueqTSNEp+BZhMMFnrKwOWTgVOSLbZgr1yfCiiTalIgJDDKXuTEkpwr7YDDtaPPbuo
	FgnryQ8M7DfaI3orJo5MsfcpcnlVkQCYqlU5m+eA30IM9r84Icul7KP22aMM/xYiLJrnxA
	KdLGX2BFHWUXTke6b4irDqxBNxewhc4=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-F2m0x7bmNma1_1Zj9-y1Bg-1; Wed, 25 Feb 2026 01:03:54 -0500
X-MC-Unique: F2m0x7bmNma1_1Zj9-y1Bg-1
X-Mimecast-MFC-AGG-ID: F2m0x7bmNma1_1Zj9-y1Bg_1771999433
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8243767ce2aso2859871b3a.2
        for <kexec@lists.infradead.org>; Tue, 24 Feb 2026 22:03:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771999433; x=1772604233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRRYrwJJKmmym1rA1RWT0WjPr4yt1zKA44KIR1qeZ14=;
        b=Oe4cRts4etKxD3DbCQIZ6iX+E/yw5PScvNT4Sy0Ab9OpwQlm5Xa79qf03O7G2OWE5b
         JwPbHmS58LEf0DBeOTTwK9GSMsFf/GkMlh4A9tUH9MW6FCbIT1zK+4NW/qpDI+ccbECm
         mjvcWjr1NcZPg+LE6SdRUlDIl4C+dL57HNab0n+0fui6FvwJpoRCQVfx3HNJp9pGRtKl
         ETwaIFxcQCCKhtgBmIv6vHAT7zxTLRU5eNII5YEGnfs21SaGdX/TjGOndBKmaKU10rl+
         EqJ3xSO+qCAPx4iUaEnOo0Du2GC/KnUYWoOXY7/NIb/Ao6oo55WblXYWB3f73Vk+h2QV
         yq3g==
X-Gm-Message-State: AOJu0Yw3h4QdhlqPNQw+HQ9VS1ycK+fCV0itA/iEz1Lid2jhG3QLjB7e
	KRhpgCeJfQXIOAfad86pzXZfA5ayeXim/LayvqpPZivOqtqyNlBL71ELJ4twDLd9KsDdBkFk8vu
	L2SpBvHU9CwHtDFb7EqmZyL/g1HOy9F5bmUxWk6jXlq3K7ZcDGO+WPfuR0SB62EIJVyvnbANp8E
	u6nRTGb9EuxnbG50YyJHRPNLuVwCoFBM3lFuPtTu11eE0=
X-Gm-Gg: ATEYQzwVu7g52DtBSXgusxYzLQs8rtlv8VIq6DW2q2zHs66sggW/s+Jq7VQkOdgV8Se
	ejo4TSRrQnJBmlKWvSVk0a9OgD+Yud0YmMvG4fx1ljAeHQQkEbH0ygULoWsOpVHMPM7fShuSoUE
	dVHgm6A/GfnoBeIE1SCr5S10sFSnOJ9b2TUgeFR4qplppux/vDycAsjRBQdWiTs4ouiR+pVzqLi
	N+ksd1EsVC4JOetb/aV9fVeKtpWKO5/DkqwUaVbxEa85ilR4ivIjw4eEGXWzV/BKLH0Q2t2usPM
	uMl243d2/6iQY4+h9qLEGoPTI3qM8kdvgff9wreM7OznGqcNPWMnu1FUWN5j+dbFg3eNx3a7a79
	fwqQbXE8JlhK0
X-Received: by 2002:a05:6a00:ac3:b0:81e:8e66:38e0 with SMTP id d2e1a72fcca58-827249f8d7dmr1267971b3a.20.1771999432767;
        Tue, 24 Feb 2026 22:03:52 -0800 (PST)
X-Received: by 2002:a05:6a00:ac3:b0:81e:8e66:38e0 with SMTP id d2e1a72fcca58-827249f8d7dmr1267934b3a.20.1771999432047;
        Tue, 24 Feb 2026 22:03:52 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8ecc83sm12341778b3a.62.2026.02.24.22.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 22:03:51 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	devicetree@vger.kernel.org
Subject: [PATCH v5 0/3] kdump: Enable LUKS-encrypted dump target support in ARM64 and PowerPC
Date: Wed, 25 Feb 2026 14:03:43 +0800
Message-ID: <20260225060347.718905-1-coxu@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SRnqllYQlmgcDUMwXuhjNr_s-zn6GwKzHA-19_g2tX0_1771999433
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_220358_026144_516F54BF 
X-CRM114-Status: GOOD (  12.80  )
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

CONFIG_CRASH_DM_CRYPT has been introduced to support LUKS-encrypted
device dump target by addressing two challenges [1],
 - Kdump kernel may not be able to decrypt the LUKS partition. For some
   machines, a system administrator may not have a chance to enter the
   password to decrypt the device in kdump initramfs after the 1st kernel
   crashes

 - LUKS2 by default use the memory-hard Argon2 key derivation function
   which is quite memory-consuming compared to the limited memory reserved
   for kdump.

To also enable this feature for ARM64 and PowerPC, we need to add a
device tree property dmcryptkeys [2] as similar to elfcorehdr to pass
the memory address of the stored info of dm-crypt keys to the kdump
kernel.

[1] https://lore.kernel.org/all/20250502011246.99238-1-coxu@redhat.com/
[2] https://github.com/devicetree-org/dt-schema/pull/181


v5
- Improve commit msg [Christophe]
- Fix a compiling error found by kernel test robot

v4
- Make arch-specific code more succinct by printing more logs in
  arch-independent code [Will Deacon]  

- Also use device tree for PowerPC to pass memory address of dm-crypt
  keys info
  - powerpc v2 patch that passes the dmcryptkeys kernel cmdline
    parameter:
    https://lore.kernel.org/all/20260106074039.564707-1-coxu@redhat.com/

v3
- Delete the property after reading it [Rob Herring]

v2
- Krzysztof
  - Use imperative mood for commit message
  - Add dt-schema ABI Documentation 
    https://github.com/devicetree-org/dt-schema/pull/181
- Don't print dm-crypt keys address via pr_debug

Coiby Xu (3):
  crash_dump/dm-crypt: Don't print in arch-specific code
  crash: Align the declaration of crash_load_dm_crypt_keys with
    CONFIG_CRASH_DM_CRYPT
  arm64,ppc64le/kdump: pass dm-crypt keys to kdump kernel

 arch/arm64/kernel/machine_kexec_file.c |  4 ++++
 arch/powerpc/kexec/elf_64.c            |  4 ++++
 arch/x86/kernel/kexec-bzimage64.c      |  6 +-----
 drivers/of/fdt.c                       | 21 +++++++++++++++++++++
 drivers/of/kexec.c                     | 19 +++++++++++++++++++
 include/linux/crash_core.h             | 14 +++++++-------
 kernel/crash_dump_dm_crypt.c           |  7 +++++--
 7 files changed, 61 insertions(+), 14 deletions(-)


base-commit: 7dff99b354601dd01829e1511711846e04340a69
-- 
2.53.0



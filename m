Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3248E7106D
	for <kexec@archiver.kernel.org>; Thu, 21 Sep 2023 13:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mchFdlA1QXI5V3q9D8tRsgdIcbz6lV0qFRQBKLcabUY=; b=VRIEoSUBZ9FsR0
	BUja6NSuCt+AJgEWBh5sdmVQEZ0bgGLusQGeOn3YqNxvlhPhSoRTFGpgjkavyW8Nvw73bquZnaRIF
	w68N8oIsnEuUKjawUYhZIau1/53Dn29vhv0CNKMbctYBMe7drZC58/KxcbAf2nzF/q7cA7xnWUrdU
	SQ5AKNw3d7MJAWsIopMTqcaJtP9pi9CNTwYIJQeScq93hjNo7ECTnfq8Co/Ub6YpjOKPcqE4R8f4n
	32n5MHeipU8glZ5VUhidObGAoHlBoxQGSB9YVZ3PczD+oujqa9prhZNdESY4TkpDZcfUeql8Ed4wQ
	RU3bUibGdtgzj6bF6veA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjJs8-0069F7-1e;
	Thu, 21 Sep 2023 13:37:36 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjJs0-0069Cr-2x;
	Thu, 21 Sep 2023 13:37:30 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68fdd6011f2so719077b3a.3;
        Thu, 21 Sep 2023 06:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695303447; x=1695908247; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/sF+QqiplgSBso/5vnIDx564mKj+3dahN17Ytb8x4c=;
        b=UIGl7VeAOhESQN2NVQp0dcc5Wyu27cBRJbNz0yfwPbjlvxh+KYfofnh2Bk0+2u6e2h
         qIOTTl/DIZ16n0mPKdK2itz/jv7Ypud0qET9qwV3uhOfzWUDhEZ8YUItgl6mBVtIrG3n
         DqC2iEpT7IR/cnpH43FfwQepQAXbTt5pC4QacWCPMZUJ6ERgiyG8nyfn2B8DqCHzPvJw
         mm/61qQJi+u7Md6bmKekEaqjiGBHtn9yB0RuFay959Pyl9pSVYqkWXuxVNqwydhTy/20
         G/LXrmpbMGHULmkwME4Lw4Oqyq3StviD5RGSj2Lc0suj6ohhbdDdE5QaSTChBHCLI2Up
         V1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695303447; x=1695908247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/sF+QqiplgSBso/5vnIDx564mKj+3dahN17Ytb8x4c=;
        b=EUyPPACBLUXvK20IwpH3usPj9YNe8ZZtBDUoyMtt+1DelTya7Ru+8wa670EC7Hqpd+
         uePGOAxrRdoujT8mhAG+tAJFR/OQc4H0pjrWwtM0WhXh0gk4yqDY0j1uBElG3v+xwmV2
         LPH/wy/efRqbdqnfqsBsL0ivTXJnu/gDKzpsolfRDnKwhhaM4NUK6uPJUOh4mCKTW+qO
         evO5LjofD4+rUpLFrt92EXa2jpcDHaL8LEDnUEySk9J1SawWjdwHkF1RCv5rEpyfLbv2
         JnZCxe2MEwOy865x40b41ncjWBpAbZACQH2fo0ic40sKOZzQZgoM9Zw0Nvu2wt67MKQw
         X/oA==
X-Gm-Message-State: AOJu0Yz8HfsLGbDCRR/rJQKX+ww6X9ggRVUzuVzxNXVnvAryUe1ycg22
	tts0X3VY13n+1MNa9TW2cA9E/t1t+dhb
X-Google-Smtp-Source: AGHT+IFYH/I9kqNhfmStNK/TQjvWgoMG9nLTrTw4wEL3FMorBwBtH3/8wSbZzWlFfAXyGMUCUPjboA==
X-Received: by 2002:a05:6a00:2d08:b0:68e:2cc4:c720 with SMTP id fa8-20020a056a002d0800b0068e2cc4c720mr6153219pfb.12.1695303447480;
        Thu, 21 Sep 2023 06:37:27 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d24-20020aa78158000000b00690188b124esm1389785pfn.174.2023.09.21.06.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 06:37:26 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-efi@vger.kernel.org,
	kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	"Jan Hendrik Farr" <kernel@jfarr.cc>,
	"Baoquan He" <bhe@redhat.com>,
	"Dave Young" <dyoung@redhat.com>,
	"Philipp Rudo" <prudo@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 1/2] zboot: Signing the payload
Date: Thu, 21 Sep 2023 21:37:02 +0800
Message-Id: <20230921133703.39042-2-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230921133703.39042-1-kernelfans@gmail.com>
References: <20230921133703.39042-1-kernelfans@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_063728_953046_E42504B8 
X-CRM114-Status: GOOD (  10.96  )
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

From: Pingfan Liu <piliu@redhat.com>

Emulate the scheme of module signing to sign the zboot's payload i.e.
Image before it is compressed.

And overall, the signature on vmlinuz.efi will be used by UEFI boot
loader and the signature on Image will be used by kexec file load.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: "Ard Biesheuvel <ardb@kernel.org>"
Cc: "Jan Hendrik Farr" <kernel@jfarr.cc>
Cc: "Baoquan He" <bhe@redhat.com>
Cc: "Dave Young" <dyoung@redhat.com>
Cc: "Philipp Rudo" <prudo@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org
To: linux-efi@vger.kernel.org
To: kexec@lists.infradead.org

---
 drivers/firmware/efi/libstub/Makefile.zboot | 23 ++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
index 2c489627a807..fd4305a4ebbd 100644
--- a/drivers/firmware/efi/libstub/Makefile.zboot
+++ b/drivers/firmware/efi/libstub/Makefile.zboot
@@ -4,13 +4,30 @@
 # EFI_ZBOOT_PAYLOAD, EFI_ZBOOT_BFD_TARGET, EFI_ZBOOT_MACH_TYPE and
 # EFI_ZBOOT_FORWARD_CFI
 
-quiet_cmd_copy_and_pad = PAD     $@
-      cmd_copy_and_pad = cp $< $@ && \
+
+#
+# Signing
+#
+ifeq ($(CONFIG_KEXEC_ZBOOT_SIG),y)
+ifeq ($(filter pkcs11:%, $(CONFIG_KEXEC_ZBOOT_SIG_KEY)),)
+sig-key := $(if $(wildcard $(CONFIG_KEXEC_ZBOOT_SIG_KEY)),,$(srctree)/)$(CONFIG_KEXEC_ZBOOT_SIG_KEY)
+else
+sig-key := $(CONFIG_KEXEC_ZBOOT_SIG_KEY)
+endif
+cmd_sign = scripts/sign-file $(CONFIG_KEXEC_ZBOOT_SIG_HASH) "$(sig-key)" certs/signing_key.x509 $@
+else
+      cmd_sign := :
+endif
+
+cmd_copy_and_pad = cp $< $@ && \
 			 truncate -s $(shell hexdump -s16 -n4 -e '"%u"' $<) $@
 
+quiet_cmd_copy_and_pad_sign = PAD and SIGN     $@
+      cmd_copy_and_pad_sign = $(cmd_copy_and_pad) && $(cmd_sign)
+
 # Pad the file to the size of the uncompressed image in memory, including BSS
 $(obj)/vmlinux.bin: $(obj)/$(EFI_ZBOOT_PAYLOAD) FORCE
-	$(call if_changed,copy_and_pad)
+	$(call if_changed,copy_and_pad_sign)
 
 comp-type-$(CONFIG_KERNEL_GZIP)		:= gzip
 comp-type-$(CONFIG_KERNEL_LZ4)		:= lz4
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

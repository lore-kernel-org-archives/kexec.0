Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7046DC761A6
	for <kexec@archiver.kernel.org>; Thu, 30 Mar 2023 09:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WxVpdDcqQwjoZb19OJ8F8E5NqhsGV9GWhBFc5AdlYLM=; b=WtJVQAXWkKfAb2
	8Ow37UQ9rbrTFlXh5nCPCxITb+mhYkZFt5reIy3sFKX4IsWRWz2fAl4ATdFO01RpRc66QeYpXRkLD
	ly9Ol4VJn89zHfj/xMQvtp8S/5Rwy/RFZFMo93oXgU2DJmt8HtX2byYHYpA1OlHa/wosrYqo/hsgm
	LSZe6r/ngXcPIeVTo9EQGljrMpKhMFAMCapdZbgdif242m/zG+IgqOXuLhllbaDx+6oAkHwG80EAC
	Iey/pjJ0KMXCF7lDt8Z3ZJ8oSiHoUxsbVBP/cX0/c5BKIEn3vNfA76t8PMBqJ7wsoxdZ/9Q6Q8NsZ
	QhF43Hvw/b68GL1ww88w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phoqO-003KEb-1Y;
	Thu, 30 Mar 2023 09:45:20 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phoqL-003KC7-1i
	for kexec@lists.infradead.org;
	Thu, 30 Mar 2023 09:45:19 +0000
Received: by mail-ed1-x534.google.com with SMTP id b20so74126350edd.1
        for <kexec@lists.infradead.org>; Thu, 30 Mar 2023 02:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680169515;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RP2whGHxY9E5x0G60FkplpO6Msu4rnrvVDst1YhxnH4=;
        b=IjQBd/+yqDgfC6l8l+UQ4SJFT3mv4DXq/ugkc8lAzKIy9GkkF/9pE1Mh0myFCSFUvf
         AgvtdkStMT3ma/7pbgLI2yp6RMAjeUgIw65Sb/ItJhK5mO2KlA1iv5423UNNCP1uAmpQ
         3fg4rgiYgRyj9PGIrJ6n28XC6bc5KgfMh70K8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680169515;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RP2whGHxY9E5x0G60FkplpO6Msu4rnrvVDst1YhxnH4=;
        b=ETVzaW2eLyou+XFrTT4Q0BJt9MxXtKwQjz52Y5Yt28S6Lau6uGQyscY8/MSeNh4i3K
         LSOx2Dppgs79OR9oixE83XqtsFAqJSUeslGsE5+UUnuk0B9ikvgTZbIhk9SWnph3/aFj
         TzryAbYC333KsluMduWcCwkahPxPJbIlJGwidWNR0UepI0U17OBgTlEXZWXqolfJ19AD
         973I3Fjo+es+awVbrdfTdJy45cSg2LYC0LGQbPB8jXpoIGi3I92gbT9lPMJ91xfRYsSL
         TUPMNsnwotR8GQiGg1uJaXBraRl84L6ltN+Bwg6wiBJAzCd/UsbEIZpdcHnjsB4Lj2vq
         Q1gA==
X-Gm-Message-State: AAQBX9eXYpJ6kfXrkf6RKmYKitd8t3/WyoDMY9qF6nZhHlMiB1R5b5mt
	5B4hQbbQgaEnu6tsYESrcfgevg==
X-Google-Smtp-Source: AKy350Zg4BajluaYUf4mgS9VbyMFuNH43cmXIg7AlblB0LpT1FcprKQ69DnoDdlaFE0knJfDwaoqkg==
X-Received: by 2002:a17:906:8392:b0:92c:5f1:8288 with SMTP id p18-20020a170906839200b0092c05f18288mr24186052ejx.13.1680169515396;
        Thu, 30 Mar 2023 02:45:15 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:1396:ff5d:6e2a:df6d])
        by smtp.gmail.com with ESMTPSA id k9-20020a17090666c900b0092b606cb803sm17683616ejp.140.2023.03.30.02.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 02:45:15 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 30 Mar 2023 11:44:48 +0200
Subject: [PATCH v5 2/2] x86/purgatory: Add linker script
MIME-Version: 1.0
Message-Id: <20230321-kexec_clang16-v5-2-5563bf7c4173@chromium.org>
References: <20230321-kexec_clang16-v5-0-5563bf7c4173@chromium.org>
In-Reply-To: <20230321-kexec_clang16-v5-0-5563bf7c4173@chromium.org>
To: Eric Biederman <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com>, Philipp Rudo <prudo@redhat.com>, 
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Ross Zwisler <zwisler@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Simon Horman <horms@kernel.org>, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4042; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=sl6K1VSwL+1LyYrdz/oxSd3LOsvL2UCVP6pzeLWPy1Q=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkJVok98RKwyzQtMEXTvDv5OfJerWqnGMS2NKs2
 DJr6RojE4+JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZCVaJAAKCRDRN9E+zzrE
 iHOqD/4szxWo11qcXn44Q+uzXQtETg3pZ52c8iQ3lFFyc+7YegOCvOXUXAkZv+wSL4uHyJRNzJT
 nSiJeEc29WUlnRoTBrW2VEwG2ojXcrfo92B7FJTR8putcifU63Dby0pWa2r/JdlYEdEC8H+dMnk
 ds2lqGOx6O/KEkprhp90mAzm1/SmsImuOcLF1IOT0tQwHT/8ESuTuXfsbpodSFtgM/IHEA6BWoW
 8jPhxkxvACuZxbEvp3j65I+VIUAjbd7zIodTy+cSv2+/JLPDRVE9Lq5g2NNg1gGLQS7E7tbxWLD
 lED6W0GuMSqOrQyzt71I5v62Z3qmeEUweOwr5dRWl/sePzuD7sDzSvU434mbT46UaZXnsvTZIl5
 vmNXhHLgqy2nQRDKMzyDV7MO7FXloVzIuvM6c+oEkrJ0EDxDC+b9PAmYbkHmMNMmuViLY/cysvz
 hgP38Z4fDMZGlBZZibGLWOHR65aXPHKNuE2pxgQ3juv7zhyiyBoS4zBQUMz37jgmZXRAOH3zVnB
 BU7l8TMuegLfJL8N2kW53iSp9vOTfLrS1fvKYtrqKiNykUUFM4S+6dH0nClgc0HoCGawEGa4+rb
 H50Yv5+iQssPhEbNs6Dg14f+dmwfzCVauUcYBO097k6eLUrSd9TajkZGetSul9+gxGK07KvCVZh
 rmjrfJTxyjszHWw==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_024517_571960_E2288873 
X-CRM114-Status: GOOD (  15.18  )
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

Make sure that the .text section is not divided in multiple overlapping
sections. This is not supported by kexec_file.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 arch/x86/purgatory/.gitignore        |  2 ++
 arch/x86/purgatory/Makefile          | 20 +++++++++----
 arch/x86/purgatory/kexec-purgatory.S |  2 +-
 arch/x86/purgatory/purgatory.lds.S   | 57 ++++++++++++++++++++++++++++++++++++
 4 files changed, 74 insertions(+), 7 deletions(-)

diff --git a/arch/x86/purgatory/.gitignore b/arch/x86/purgatory/.gitignore
index d2be1500671d..1fe71fe5945d 100644
--- a/arch/x86/purgatory/.gitignore
+++ b/arch/x86/purgatory/.gitignore
@@ -1 +1,3 @@
 purgatory.chk
+purgatory.lds
+purgatory
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 17f09dc26381..4dc96d409bec 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -16,10 +16,11 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS
 
 # When linking purgatory.ro with -r unresolved symbols are not checked,
 # also link a purgatory.chk binary without -r to check for unresolved symbols.
-PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib
-LDFLAGS_purgatory.ro := -r $(PURGATORY_LDFLAGS)
-LDFLAGS_purgatory.chk := $(PURGATORY_LDFLAGS)
-targets += purgatory.ro purgatory.chk
+PURGATORY_LDFLAGS := -nostdlib -z nodefaultlib
+LDFLAGS_purgatory := -r $(PURGATORY_LDFLAGS) -T
+LDFLAGS_purgatory.chk := -e purgatory_start $(PURGATORY_LDFLAGS)
+
+targets += purgatory.lds purgatory.ro purgatory.chk
 
 # Sanitizer, etc. runtimes are unavailable and cannot be linked here.
 GCOV_PROFILE	:= n
@@ -72,10 +73,17 @@ CFLAGS_string.o			+= $(PURGATORY_CFLAGS)
 AFLAGS_REMOVE_setup-x86_$(BITS).o	+= -Wa,-gdwarf-2
 AFLAGS_REMOVE_entry64.o			+= -Wa,-gdwarf-2
 
-$(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
+OBJCOPYFLAGS_purgatory.ro := -O elf64-x86-64
+OBJCOPYFLAGS_purgatory.ro += --remove-section='*debug*'
+OBJCOPYFLAGS_purgatory.ro += --remove-section='.comment'
+OBJCOPYFLAGS_purgatory.ro += --remove-section='.note.*'
+$(obj)/purgatory.ro: $(obj)/purgatory FORCE
+		$(call if_changed,objcopy)
+
+$(obj)/purgatory.chk: $(obj)/purgatory FORCE
 		$(call if_changed,ld)
 
-$(obj)/purgatory.chk: $(obj)/purgatory.ro FORCE
+$(obj)/purgatory: $(obj)/purgatory.lds $(PURGATORY_OBJS) FORCE
 		$(call if_changed,ld)
 
 $(obj)/kexec-purgatory.o: $(obj)/purgatory.ro $(obj)/purgatory.chk
diff --git a/arch/x86/purgatory/kexec-purgatory.S b/arch/x86/purgatory/kexec-purgatory.S
index 8530fe93b718..54b0d0b4dc42 100644
--- a/arch/x86/purgatory/kexec-purgatory.S
+++ b/arch/x86/purgatory/kexec-purgatory.S
@@ -5,7 +5,7 @@
 	.align	8
 kexec_purgatory:
 	.globl	kexec_purgatory
-	.incbin	"arch/x86/purgatory/purgatory.ro"
+	.incbin	"arch/x86/purgatory/purgatory"
 .Lkexec_purgatory_end:
 
 	.align	8
diff --git a/arch/x86/purgatory/purgatory.lds.S b/arch/x86/purgatory/purgatory.lds.S
new file mode 100644
index 000000000000..610da88aafa0
--- /dev/null
+++ b/arch/x86/purgatory/purgatory.lds.S
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm-generic/vmlinux.lds.h>
+
+OUTPUT_FORMAT(CONFIG_OUTPUT_FORMAT)
+
+#undef i386
+
+#include <asm/cache.h>
+#include <asm/page_types.h>
+
+ENTRY(purgatory_start)
+
+SECTIONS
+{
+	. = 0;
+	.head.text : {
+		_head = . ;
+		HEAD_TEXT
+		_ehead = . ;
+	}
+	.rodata : {
+		_rodata = . ;
+		*(.rodata)	 /* read-only data */
+		*(.rodata.*)
+		_erodata = . ;
+	}
+	.text :	{
+		_text = .; 	/* Text */
+		*(.text)
+		*(.text.*)
+		*(.noinstr.text)
+		_etext = . ;
+	}
+	.data :	{
+		_data = . ;
+		*(.data)
+		*(.data.*)
+		*(.bss.efistub)
+		_edata = . ;
+	}
+	. = ALIGN(L1_CACHE_BYTES);
+	.bss : {
+		_bss = . ;
+		*(.bss)
+		*(.bss.*)
+		*(COMMON)
+		. = ALIGN(8);	/* For convenience during zeroing */
+		_ebss = .;
+	}
+
+	/* Sections to be discarded */
+	/DISCARD/ : {
+		*(.eh_frame)
+		*(*__ksymtab*)
+		*(___kcrctab*)
+	}
+}

-- 
2.40.0.348.gf938b09366-goog


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

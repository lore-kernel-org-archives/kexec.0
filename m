Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5ECC76195
	for <kexec@archiver.kernel.org>; Mon, 27 Mar 2023 15:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0LfgH35i9QplP5ADPuhhqFDJ1h9T7qDlK/d0OpowhK8=; b=YbINpmYIFisOzW
	vY3nX/kqYmDfItZ+Dscr7KgIHhsSVkcspls1aTJoZjb0cCPqUZY0rN5ULIhNVFftVBxbwJSJPyCfy
	8OijI8AjiWPbwKQZJct1o2wDQtmGCciDF5pbMvbl0DAfp4xSg9gVTxOzchR/qs74T4v/185eQtLv0
	+XsGMl5vsoa0D2L5rsmtSyO1hotiRDI9WrcAkVL+3l42Ho2zXoy7x3Afj6yBu2quYTrSbMEh8InVg
	Ou7sgVaqQivNROXG1z86+GKOQTAgOA/vCofA0fOqWT5qiQW2bZVCLuJOW/EkyjWxBtxhGTm6EurS8
	UeT3KJ2++Z0FJ5JjQn8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgoRH-00BSGW-2u;
	Mon, 27 Mar 2023 15:07:15 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgoRE-00BSCh-15
	for kexec@lists.infradead.org;
	Mon, 27 Mar 2023 15:07:14 +0000
Received: by mail-ed1-x52e.google.com with SMTP id r11so37531753edd.5
        for <kexec@lists.infradead.org>; Mon, 27 Mar 2023 08:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679929628;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4F21eaCjPlHPX0mt5BYCkFL5YU30FB5WE06H9+TgyGM=;
        b=Nk8teTJSKpMvzOa2aMHyMoIsxBKdK0bqysKUKWgePW4/z76CuPzpsa2b9Svg7JXOua
         ls6++OZGzpLGm2yBZC1w3G/FdDMXQutiA7p/DqRBiiqQ/NHmLhrQa/wjG/GOZFyjuTWP
         eSkjeOLKdDPKy5v835waRLRiQO7MXqQqFQSfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679929628;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4F21eaCjPlHPX0mt5BYCkFL5YU30FB5WE06H9+TgyGM=;
        b=dUwC1f4c1AZuqIfGw2uTF086jqyYyPSEHcxqwtsM6zFtZeiiB6UlqUt5pB7QH7sznT
         zseViejgTl8cXB7eSNGlRTVeve2VM0NOeY8EzRHjPVFPGNsyKbwsJKCzcHPEsXWS2oEg
         fF1gzx5ItBPLbKdBuVG6m6ceXFfZTPtjxKpE5GLCOY0qOONEdHkhllu25m1AUMo7TUmq
         muBO2+mhpNP/n7LX5M+7a9YZ/7bfJbDUiuNI2OkHT7RmlVaVK2OA85k43AVipiqbAozi
         DjulTSPjQy/5azvpNrXbYma/6VOAYcNb2b5+RajZUJVjueizDDq3jj9kU4su8mZ+xEF6
         EtRw==
X-Gm-Message-State: AAQBX9elFBRTPQNVOEc7VrDMvQ0exm+0Va5Nc6sUwtHl1UfFQ4Ky5/QR
	XOHlQKQKj/XlSOOHQ0Pfi3i38w==
X-Google-Smtp-Source: AKy350ZZZL8pphDOUectQe/OR6qxHzSfDr7AGLq5vY5gioai9U/NBlK35cUThEdpgdEqCtzjJsZJCA==
X-Received: by 2002:a05:6402:d3:b0:4fa:e1fd:5a30 with SMTP id i19-20020a05640200d300b004fae1fd5a30mr12303438edu.19.1679929628405;
        Mon, 27 Mar 2023 08:07:08 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:ed3c:5e9e:b8e4:8695])
        by smtp.gmail.com with ESMTPSA id t9-20020a50c249000000b005021d1ae6adsm5312428edf.28.2023.03.27.08.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 08:07:08 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 27 Mar 2023 17:06:54 +0200
Subject: [PATCH v4 2/2] x86/purgatory: Add linker script
MIME-Version: 1.0
Message-Id: <20230321-kexec_clang16-v4-2-1340518f98e9@chromium.org>
References: <20230321-kexec_clang16-v4-0-1340518f98e9@chromium.org>
In-Reply-To: <20230321-kexec_clang16-v4-0-1340518f98e9@chromium.org>
To: Eric Biederman <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>,
 stable@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
 Ricardo Ribalda <ribalda@chromium.org>, Philipp Rudo <prudo@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, kexec@lists.infradead.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=4062; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=qY09zbcWDi4omI4cAAqSkSf1QXILb3VpDDT9kkUrd8k=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkIbEXTTl0yvDRVdkTXHHm+0bOTv2j/hTT7auw+OrA
 crD/BLWJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZCGxFwAKCRDRN9E+zzrEiAsbD/
 0UsWhT4KOuvSbykGED1lnG/+pTSa3Xp9DDzRODKaqq2yNEiujiz6N8UcEW7t5GEA1++UUUAZPD8MBd
 bqegVfBE1QvTudCz7SYGQ34tYg0NRZfYEJRi4GjJ8LWSH3aBVjTdRTOHVf3Ixv5iZXjA5CnD7gij80
 CVs0m7tTmWtk/mISLzsXIYvDVvIumbQD9tevfwTFP1gk8TqZk7nE/LFzTyuiDwBzGWQuRFKeBJM7qQ
 lhCoPJcFrLahBfcmEKsbhcznykvHmhTRHFf5s0uRr7qVWANQd4l+a/2+XOSgEwwheY87nL5H2Z6fXY
 oc02JXg7tJtKn7W5uqnoyUfJWj5W7QiYwN9KDAdfVBUGaVYwEX75y8EMjdN4vhdgmCuHcMxoC/BQz8
 fDl/PO8eCnDXEsg5z+is1bdMXSJ20JCU1GPgldC9eG2QR7kFXgOF5NOLg2ndjXwd5cVDB0aAuzxfAe
 FTJDe/5ecHdkjIrCSECROJSIAlKKu/5zGsJ0yaTs1aIr02aiU0y2UZQ9HCLdcXHf4erZBypIYNy+QE
 fOoXFDdNjXCWkQlhBsEsrgIhrSZWbvMjM3KJ9Vvb8q1Er0jFnuvOqclpT0mwW5gLbsvQv2+gPHPHdq
 M+FO5RVET3Muy4/a+4eTLUi8jn0UyioYEI4LV5esDnAGuRelODSlNgdM6ohQ==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230327_080712_379544_344D19FE 
X-CRM114-Status: GOOD (  15.20  )
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
2.40.0.348.gf938b09366-goog-b4-0.11.0-dev-696ae

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

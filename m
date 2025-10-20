Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A3CCCD19F
	for <kexec@archiver.kernel.org>; Mon, 20 Oct 2025 22:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1DN3wDH3/gohyYkAuJoGUhhOOOZQuLULC+f0i+CNUAo=; b=YuTYUA1aXD6KPtO25YB2aApzOz
	JNjpISMdq5+Pvu7NlCksgl7uXx3abBPcKY1XOs338lkxJvFunJ2piwgo5fVD/H1+eVHsK9TIlWt7j
	vq4kwIGd3XLT59L6P8nfyVsNjWWJ0DXqoHY88Pw1lLtwXV5GDkSnSRdcrxXe/hE+HSYub8Lohe6R3
	vVol/QgvtKZSJAx4NbX+PIOpVDJbkQXOzFT+Tk2Cv/VsIFQRayqkf4DAS6tzN0jaWenBhmklwSQwI
	9heZFOLURL7ghrm3ZVdtUwlrnp3IIfISSmdwTQCFM+vFCDuM23JSt199qaORKTSou/f0kL70c7MEt
	FtDhSSfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAyJV-0000000FB7Q-1D3l;
	Mon, 20 Oct 2025 22:25:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAyJS-0000000FB6Q-3n9S
	for kexec@lists.infradead.org;
	Mon, 20 Oct 2025 22:25:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760999110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1DN3wDH3/gohyYkAuJoGUhhOOOZQuLULC+f0i+CNUAo=;
	b=KkjxVUkxfJDpKb7QqjhT10APCTaDBryHJmCknJuVPjQ9lBu5oRQ7CArQ96BRiyPoDWfuwd
	EpDBQGwRr1qI4GKhp8TvOTWGGBB0w9uQSA93wkfopwNQhXvPHAxkYtl1ghVya9FtmQpxKi
	r78tfQaL9uUv3WXX7BzhHdSCA2IdNTI=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-DC4XFwqLMLqaYpuv3kN1DQ-1; Mon, 20 Oct 2025 18:25:05 -0400
X-MC-Unique: DC4XFwqLMLqaYpuv3kN1DQ-1
X-Mimecast-MFC-AGG-ID: DC4XFwqLMLqaYpuv3kN1DQ_1760999105
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-78106e63bc9so4905841b3a.0
        for <kexec@lists.infradead.org>; Mon, 20 Oct 2025 15:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760999105; x=1761603905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DN3wDH3/gohyYkAuJoGUhhOOOZQuLULC+f0i+CNUAo=;
        b=AgpTts2gTq0LKGxzf9sQohI+qqfKWHNtVBoZFLmG2ru/pxECV1lst1Gi7pak/cW+B1
         jzdCPHJtEtX99lSA7Y5Hb/AMqlZNzir2RAo6feSlqPU5OjIU2wmZUKoyzEWIwxGqKFgQ
         ErzHv6Fl+6G3SUAvrZ8PGM8Tx70EBnz95e3cCaqotpxDk2UIIbto8rvDaQYCWs/d6EfA
         MrxnhNUfbE/I/OS9+pni0OfDXOuxi1Iz1SlozPYWpNErI1ZoFVF43hYrIzPvL3/haCdq
         bAVInsuWh7YV56bs3LEXE6QXY/UfCx/zPK6MdPaLM68s0edMHZmX1ZiwMaGSiQXQYK1x
         s4Ig==
X-Forwarded-Encrypted: i=1; AJvYcCWzTDVOGmU1Q1q6RZhJ6Rsfx5veuxkaUgsjaeO+ewh6TEf97l9GsYJTIDIqpvk15HIAN1L0uw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyNo5Rm0B3/eN1BBVFdF9wnNpkvARJL/vUkWBWTI2PaFH/PKjJO
	mofl9+bhjJ2B/0cEVsME4rlxOyFMUXwm8KqrgzZaEC+M3zCmDPCDiFZXeZQ6sH0RQ9g+ET57CP5
	EnJ69d/zifcLOsNabP256YzF0hBdBqLHfWHaDNVkgYl4EeN3dZl9WYONlpIyq7g==
X-Gm-Gg: ASbGnctHqi99J/aGWZHPqXjzDEp68aL13kR7RLIsvM9Woi29K097GZzYakgjRtLI2C9
	8JO5kJ4fuXrOUjF1iLPGa8UXzBEFDeNeGK3UYmnMK6pd6aX1PTWhKB42PXO7Ic3h4Kd9PrJ2v8k
	cj2tELcHOdAuVMCHt8BsJFbSthKBIRfhv1tXd6dOTUMBsO+MIIkPNdU/d6VMCO5lW2WSy+ZrBCU
	QjXvj8FABTHWsT9wvni+vdWTATPbPkLZ9O9rXqdgSr9sl9Ou0RzE1fV/mCKkVXmw4aUMu+7Aopq
	x+tRLlMxbYoVxdyBciXkbIx7YJho5C5FohZM9XKywp8XvAeVIhQMjD+q+YdKqtIqmSbkjM6xl85
	mR9V+g6ezO5WsiJQiuUrxZ12RvG5slhtXuXNHIIAPlis=
X-Received: by 2002:a05:6a00:194b:b0:781:556:f33 with SMTP id d2e1a72fcca58-7a220a5e915mr17592536b3a.5.1760999104581;
        Mon, 20 Oct 2025 15:25:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDtYofkR60TjxsNI0yI+Ns/+8C7J8yxdasEckmP0ZFvAzF2odOeVtlE538QJNu1URBDSGOpQ==
X-Received: by 2002:a05:6a00:194b:b0:781:556:f33 with SMTP id d2e1a72fcca58-7a220a5e915mr17592511b3a.5.1760999104166;
        Mon, 20 Oct 2025 15:25:04 -0700 (PDT)
Received: from localhost.localdomain (115-189-93-209.mobile.spark.co.nz. [115.189.93.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010e265sm9229263b3a.52.2025.10.20.15.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:25:03 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v2][makedumpfile 13/14] Docs: Update eppic related entries
Date: Tue, 21 Oct 2025 11:24:09 +1300
Message-ID: <20251020222410.8235-14-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251020222410.8235-1-ltao@redhat.com>
References: <20251020222410.8235-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QGGkEQUYG7iwYZvpDFqv1jKsD6KIT6uAQ9vwtBEBUyk_1760999105
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_152511_041956_1F9BBCAF 
X-CRM114-Status: GOOD (  12.42  )
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

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 makedumpfile.8.in | 24 +++++++++++++++---------
 print_info.c      | 11 +++++------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/makedumpfile.8.in b/makedumpfile.8.in
index d22588e..acc4405 100644
--- a/makedumpfile.8.in
+++ b/makedumpfile.8.in
@@ -6,7 +6,7 @@ makedumpfile \- make a small dumpfile of kdump
 .br
 \fBmakedumpfile\fR \-F [\fIOPTION\fR] [\-x \fIVMLINUX\fR|\-i \fIVMCOREINFO\fR] \fIVMCORE\fR
 .br
-\fBmakedumpfile\fR   [\fIOPTION\fR] \-x \fIVMLINUX\fR [\-\-config \fIFILTERCONFIGFILE\fR] [\-\-eppic \fIEPPICMACRO\fR] \fIVMCORE\fR \fIDUMPFILE\fR
+\fBmakedumpfile\fR   [\fIOPTION\fR] [\-x \fIVMLINUX\fR] [\-\-config \fIFILTERCONFIGFILE\fR] [\-\-eppic \fIEPPICMACRO\fR] \fIVMCORE\fR \fIDUMPFILE\fR
 .br
 \fBmakedumpfile\fR \-R \fIDUMPFILE\fR
 .br
@@ -54,6 +54,8 @@ be excluded.
 .B \- User process data pages
 .br
 .B \- Free pages
+.br
+.B \- Customized pages which specified by eppic macro
 .PP
 makedumpfile provides two \fIDUMPFILE\fR formats (the ELF format and the
 kdump\-compressed format). By default, makedumpfile makes a \fIDUMPFILE\fR in
@@ -72,10 +74,10 @@ filter commands. The memory locations that require to be filtered out are
 then poisoned with character 'X' (58 in Hex). Refer to
 \fBmakedumpfile.conf(5)\fR for file format.
 .PP
-Eppic macros can also be used to specify kernel symbols and its members that
-need to be filtered. Eppic provides C semantics including language constructs
-such as conditional statements, logical and arithmetic operators, functions,
-nested loops to traverse and erase kernel data. --eppic requires
+Eppic macros can also be used to specify kernel pages or kernel symbols and its
+members that need to be filtered. Eppic provides C semantics including language
+constructs such as conditional statements, logical and arithmetic operators,
+functions, nested loops to traverse and erase kernel data. --eppic requires
 \fBeppic_makedumpfile.so\fR and eppic library. \fBeppic_makedumpfile.so\fR
 can be built from makedumpfile source. Refer to
 \fBhttp://code.google.com/p/eppic/\fR to build eppic library \fBlibeppic.a\fR
@@ -316,10 +318,14 @@ command syntax please refer to \fBmakedumpfile.conf(5)\fR.
 
 .TP
 \fB\-\-eppic\fR \fIEPPICMACRO\fR
-Used in conjunction with \-x \fIVMLINUX\fR option, to specify the eppic macro
-file that contains filter rules or directory that contains eppic macro
-files to filter out desired kernel data from vmcore while creating \fIDUMPFILE\fR.
-When directory is specified, all the eppic macros in the directory are processed.
+To specify the eppic macro file that contains filter rules or directory that
+contains eppic macro files to filter out desired kernel data/pages from vmcore
+while creating \fIDUMPFILE\fR. When directory is specified, all the eppic macros
+in the directory are processed. Please note, if the option is used in conjunction
+with \-x \fIVMLINUX\fR option, makedumpfile will use the dwarf data of
+\fIVMLINUX\fR as debuginfo for symbol resolving; otherwise, btf & kallsyms
+data(if available) of \fIVMCORE\fR will be used instead. Rust symbols are not
+supported in eppic macro file.
 
 .TP
 \fB\-F\fR
diff --git a/print_info.c b/print_info.c
index 8d3b1cb..60b1657 100644
--- a/print_info.c
+++ b/print_info.c
@@ -77,7 +77,7 @@ print_usage(void)
 	MSG("\n");
 	MSG("  Creating DUMPFILE with filtered kernel data specified through filter config\n");
 	MSG("  file or eppic macro:\n");
-	MSG("  # makedumpfile    [-c|-l|-p|-z|-E] [-d DL] -x VMLINUX [--config FILTERCONFIGFILE]\n");
+	MSG("  # makedumpfile    [-c|-l|-p|-z|-E] [-d DL] [-x VMLINUX] [--config FILTERCONFIGFILE]\n");
 	MSG("    [--eppic EPPICMACRO] VMCORE DUMPFILE\n");
 	MSG("\n");
 	MSG("  Outputting the dump data in the flattened format to the standard output:\n");
@@ -190,11 +190,10 @@ print_usage(void)
 	MSG("      from vmcore while creating DUMPFILE.\n");
 	MSG("\n");
 	MSG("  [--eppic EPPICMACRO]:\n");
-	MSG("      Used in conjunction with -x VMLINUX option, to specify the eppic macro\n");
-	MSG("      file that contains filter rules or directory that contains eppic macro\n");
-	MSG("      files to filter out desired kernel data from vmcore while creating DUMPFILE.\n");
-	MSG("      When directory is specified, all the eppic macros in the directory are\n");
-	MSG("      processed\n");
+	MSG("      To specify the eppic macro file that contains filter rules or directory\n");
+	MSG("      that contains eppic macro files to filter out desired kernel data/pages\n");
+	MSG("      from vmcore while creating DUMPFILE. When directory is specified, all the\n");
+	MSG("      eppic macros in the directory are processed\n");
 	MSG("\n");
 	MSG("  [-F]:\n");
 	MSG("      Output the dump data in the flattened format to the standard output\n");
-- 
2.47.0



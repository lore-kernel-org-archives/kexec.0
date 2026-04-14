Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13465ED7B9B
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 10:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GjOcjD5hYdO+mH4J9yZLJIS5gQ1A7Vsr5OYLif6rGlU=; b=OYrff2evYW2bZX/xqGerHDbY2A
	8Omjm4ARJoSfstvkDX5DB7wPvln3elMcT2GL6xa24F0Gw1LkBAeSRUpeOiSbselSb7XHZues/ptyd
	sgI8OOxQKB/IStYZD257MUgsVYMjYR5khixA+63peufks+tFDOknDs55OJ4WkzVE9sPo56SFrETxy
	ZRL76HMgQt3BEmcDMin9/5HGq8L3x1GUhRJ285gC4WMDRsjKmgDK8u9q7ZJL6d4fFvMbcxGV2TV55
	IUlXqp4t10+Kf9oGIDn7b15GlHKpCDjHz5AZxTH2jTuDruF0h30zZNG+uc0cxgnowf9aHl7YLvNTr
	z/LlflQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCazt-0000000H97F-33Q7;
	Tue, 14 Apr 2026 10:27:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCazq-0000000H95B-3Kok
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 10:27:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776162474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GjOcjD5hYdO+mH4J9yZLJIS5gQ1A7Vsr5OYLif6rGlU=;
	b=coEPUGOMcxGV7fMn8V2XQoH7je25TX6UqTYk++ObKHBUrl7xlhj/wN+HYlBRwVwyAGqv5k
	m1i4PKjql3by552sIuKyglid0VWiv6oQUk8UXUigcLhhc3+jhGcqpKLBg8k+/e45ev0NpN
	5GxMzY7EkWqYnlbRECJkQeLIIlRTFis=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-3FFxduiDPu24Jb57ebgO4A-1; Tue, 14 Apr 2026 06:27:51 -0400
X-MC-Unique: 3FFxduiDPu24Jb57ebgO4A-1
X-Mimecast-MFC-AGG-ID: 3FFxduiDPu24Jb57ebgO4A_1776162471
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b2d0c1ead1so84000965ad.0
        for <kexec@lists.infradead.org>; Tue, 14 Apr 2026 03:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776162470; x=1776767270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GjOcjD5hYdO+mH4J9yZLJIS5gQ1A7Vsr5OYLif6rGlU=;
        b=Gr7RWRxsnQgeMSm/6GLlwKJGusKmhCclIjzuV+PeqnywkzVyoZfItIJm0rnuIzP7KY
         KxA+rBB+ZWmAFFDj2SJaGZZcvZ/TDooZiP/ms5gWNA+bAWnkE5I8iA8aHX3obLm9HWbw
         JZV0NsZaUnFseLA5HnEtY8WKl8Uwb2qlNJZJqQnQzxbKqr2+lm0PGSXlfXlCTRkpJvS8
         4MsHwf4toznPwK/lPcaPH4z9R0xgi27opaiXIhPgFXNAwXUi9c+Nbgrb1Hag/Eg7mkYu
         sYi3BYALs+0ovh2lVTROMthJTGSGLuDKYxeVfwouzg5YLY1foAG29B9Y3/64Sgk7Zqde
         iU4w==
X-Forwarded-Encrypted: i=1; AFNElJ+3Ymn0BYaFl5xwr6aWUoa5m+yVetQVQvewsANVSXAp+NY8f3Bqsj9Kagc6UJUe75Z6sZcqnQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy4iq17akEbZj26d0xOm2rVQk9E6mvNoliyWEMHITUguwZ/LySB
	gmDsSVuj4zr9nIWRl1bwDE8g5K1ZCzTvvUjHYSkC0EPtx70M8giqFmEJuEtOlH3Mkky42s47F/W
	spg9a0pPjWWU/Er/Pv7MlPuMTIpdBRDnKgZmxqyrH24/1YEQ7UymjJQpi0LTrlg==
X-Gm-Gg: AeBDietuY5is8CVkaZb/IIedjXOWmSVAbOrycYEhD+dAKH/qPxw2RDI4Z7w0q/Wj9pG
	nKnuBcVAFjWE0kxZj1njL7bkfayfeNUT0crPYqcP7yfxvW9ml5fQ70Auwe+Uvkdo4gtxTZKmUBC
	Q75s5kjR3fAU9WzpG8jrTvCCy9rClMlXRjKtMxVpAglZ7H8pcpQuWlwKHDmF7lR5E/wp45XXDN1
	49OOALcraopNLulbVS0hoXbV0zG2ytKKnBfl4UGA6ZkAqPxTVqRrWJjPw6MUhiv8rxQpc4o1BDO
	cgNQQeVeD4kSCKndSWhSXCGSIyj8QfC08ZdI5TzU9G8LlFNzJHO5lakYghflxX4V6EqKo7TldoB
	ZbYjrWJbxM/TmVQ0kHJiw4W6YUdDMkdF2j3RWayISORJbIsJeAcZI/2S+hWp8PDVfVge3
X-Received: by 2002:a17:902:ea02:b0:2b2:5503:1ba0 with SMTP id d9443c01a7336-2b2d5944b17mr179372965ad.5.1776162470578;
        Tue, 14 Apr 2026 03:27:50 -0700 (PDT)
X-Received: by 2002:a17:902:ea02:b0:2b2:5503:1ba0 with SMTP id d9443c01a7336-2b2d5944b17mr179372755ad.5.1776162470151;
        Tue, 14 Apr 2026 03:27:50 -0700 (PDT)
Received: from localhost.localdomain (122-63-70-7.mobile.spark.co.nz. [122.63.70.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f431c3sm136809165ad.79.2026.04.14.03.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:27:49 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v5][makedumpfile 8/9] Doc: Add --extension option to makedumpfile manual
Date: Tue, 14 Apr 2026 22:26:55 +1200
Message-ID: <20260414102656.55200-9-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260414102656.55200-1-ltao@redhat.com>
References: <20260414102656.55200-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yaAgLwBVf6swTgDKt6p260c2P26UZr4MqzgajtzfwdQ_1776162471
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_032754_904649_7C871D20 
X-CRM114-Status: GOOD (  11.42  )
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

Suggested-by: Kazuhito Hagio <k-hagio-ab@nec.com>
Signed-off-by: Tao Liu <ltao@redhat.com>
---
 README            |  6 ++++++
 makedumpfile.8.in | 11 ++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/README b/README
index b2666cb..0f1ccb9 100644
--- a/README
+++ b/README
@@ -65,6 +65,12 @@
     # make USEZSTD=on ; make install
     The user has to prepare zstd library.
 
+  - Build with extension support:
+    # make EXTENSION=on ; make install
+    The user has to prepare bpf library with version(>=v1.4.0).
+    Note: the extension will only work for kernels with DEBUG_INFO_BTF
+    & KALLSYMS enabled.
+
   - Build the extension module for --eppic option.
     # make eppic_makedumpfile.so
     The user has to prepare eppic library from the following site:
diff --git a/makedumpfile.8.in b/makedumpfile.8.in
index 1edd0ff..5af1786 100644
--- a/makedumpfile.8.in
+++ b/makedumpfile.8.in
@@ -2,7 +2,7 @@
 .SH NAME
 makedumpfile \- make a small dumpfile of kdump
 .SH SYNOPSIS
-\fBmakedumpfile\fR    [\fIOPTION\fR] [\-x \fIVMLINUX\fR|\-i \fIVMCOREINFO\fR] \fIVMCORE\fR \fIDUMPFILE\fR
+\fBmakedumpfile\fR    [\fIOPTION\fR] [\-x \fIVMLINUX\fR|\-i \fIVMCOREINFO\fR] [--extension \fIEXTENSION1.SO\fR [--extension \fIEXTENSION2.SO\fR ..]] \fIVMCORE\fR \fIDUMPFILE\fR
 .br
 \fBmakedumpfile\fR \-F [\fIOPTION\fR] [\-x \fIVMLINUX\fR|\-i \fIVMCOREINFO\fR] \fIVMCORE\fR
 .br
@@ -664,6 +664,15 @@ This option cannot be used with the --dump-dmesg, --reassemble and -g options.
 Display report messages. This is an alternative to enabling bit 4 in the level
 provided to --message-level.
 
+.TP
+\fB\-\-extension\fR \fIEXTENSION.SO\fR
+Load makedumpfile extensions. By using extensions, users can programmably
+customize mm page keeping / discard, alone with the traditional page-flag
+(-d dump_level) based filtering. The option can be used multiple times to
+select various extensions. NOTE: this option needs EXTENSION=on when build
+makedumpfile with libbpf(>=v1.4.0). Also this option only works for kernels
+with DEBUG_INFO_BTF & KALLSYMS enabled.
+
 .SH ENVIRONMENT VARIABLES
 
 .TP 8
-- 
2.47.0



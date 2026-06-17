Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C2ACD98EE
	for <kexec@archiver.kernel.org>; Wed, 17 Jun 2026 05:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yR4jY3Bhz+Z10hafR2mM6uTUqAFYz2SZYuyN4V3IfV4=; b=4nacUXPovl5egaEwjbma0UZ4sj
	YTc8o72QPbf9mPN1sRDSg85C2bT9/cD5d/2U/FUW1M63UvX9UGfJDAH1d/yaGRoIWj4talNP2iyEg
	RCTlb8Ue17q2FffvjszbWmpz/Zu2gPfsENILxG5FIuliSqjDrPL/IUVB6Dg+in56jqQb7eaWHk/iB
	1is9YD9cwxAWCjPjceYu+27GLZtDFaH7jVufmk5hG8Sno27R6W0h8lXMc/SxAR/Fvkk58pzdB5778
	rOcfgtNoiU+YlNPZfQQR0y5cOOQZgKlrps8Lkj2j1WUHKaph8hSvIRIg5CGjDp76w3r6Jx6/AiI/D
	nNAjdJwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZiht-0000000GeFy-46p5;
	Wed, 17 Jun 2026 05:20:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZihq-0000000GeDt-3Llm
	for kexec@lists.infradead.org;
	Wed, 17 Jun 2026 05:20:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781673654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yR4jY3Bhz+Z10hafR2mM6uTUqAFYz2SZYuyN4V3IfV4=;
	b=MjYl8+YCJCKyBvnA/bcsf79RuLyKTYZb+akezeOPCyT3vACMyhXeMa25hIXs0iPcQCKRRv
	drcl9k5apgmfDzSRO7ln+2Aq5nwbJpndwPMZfmfzhWVxSoJBPbTZaea3ExMBz9DfXs6zl2
	6gJs3mZnz7QrxjvmaLIXJvfGhh8k2nw=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-mO8EI6q4NjK-CkdI6Y21xg-1; Wed, 17 Jun 2026 01:20:51 -0400
X-MC-Unique: mO8EI6q4NjK-CkdI6Y21xg-1
X-Mimecast-MFC-AGG-ID: mO8EI6q4NjK-CkdI6Y21xg_1781673651
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8428384f31fso4104093b3a.3
        for <kexec@lists.infradead.org>; Tue, 16 Jun 2026 22:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781673650; x=1782278450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yR4jY3Bhz+Z10hafR2mM6uTUqAFYz2SZYuyN4V3IfV4=;
        b=QS9F6nOlGcz24Z/4kwSS/UO5XRhaHlcZ8K0T7Jl7uno1oSiDfUvUb8aI1O5E8apZEc
         Q7wgvbQk///HpJ2LjCk+5POvwBoT4frtXrod0PuimS0bu0xeJe/IrV/lLHMR0atFBAWS
         Nccb8UiNcL9A9TbR1xCw/3/ShMm8DGHr9ZE0a69tiaROKOP2A07fzc80iq7Oj8prDrYc
         WR5yGaCVtG3xMRCxDc+0+Ka7vC6hp1PmcZVSkBS4gJq8cEZT5SLJvo6/epRDxZMNZQRw
         dLtE+nvfDBWfi7JuFl322vuC6vxTayU53sL79T2IcoEFKkrdcx0dKXSnZl35rQ4Z6GRk
         0E1Q==
X-Forwarded-Encrypted: i=1; AFNElJ/E/mdtKzqPMJ2C0+ACprqBZ/gam2tJkwseIwRNKhCTbWlRMC9japLyfugyKuvuVu5SK1GKsg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyH9BjEbDjccWLkzqLmY6iZB/uScYd+Ttp0Va/mXjkLGDf4fEb9
	hCIiglJGM+gnPuf1Pk9Xukz/1xlRG0tc2ZSLD2TuOEnalkd9cw44KfitGJjHk4+ZjzN0RH5Vv5R
	2bHKuQOcxheE3t2RUdwoGvn5q60zqbYVQkyc8S1hxQfmKiuN0PLwsyT9aDxxBQQ==
X-Gm-Gg: Acq92OFtyo27B7rHoTLCC0iKHna+Tq9On2ZkUjxvX7bJBl9JJXkoLDQjbW11tHg+WG8
	9OmqIM0fuiYt6jVBmMzeZE+KPzeFoCUHa9SgMNbszE5byblK3Sw+mgQOrruclJodTq4MKEBnJPG
	1A34r5ScgygvL13bAigbRaCX/aWqWjQgW0uedNiPNuSHMK9tqDCluVG4QJyb25V50JbN4fjnvnU
	Y4cwCpZ7dpkOhSby++d8S5ywbftL7RkmfPPTjjGQ4Svv0PNmMxsQhWF0lWTOP7DqBWijVQkuPWT
	JcNNMsqkgj/F+Rl7tyjgWYD3ywAZdSHVCda5CvLBJ1jaixjfFwMkgc0HPSuHetOCQm8AGmkNjgs
	098sfAKO8chJVSizt/s5mjo8kJrNx1F3biezhF3mv2KDiIFu5Qw==
X-Received: by 2002:a05:6a00:2790:b0:842:5719:4552 with SMTP id d2e1a72fcca58-845247bcb7cmr2363195b3a.46.1781673650486;
        Tue, 16 Jun 2026 22:20:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:2790:b0:842:5719:4552 with SMTP id d2e1a72fcca58-845247bcb7cmr2363177b3a.46.1781673650010;
        Tue, 16 Jun 2026 22:20:50 -0700 (PDT)
Received: from localhost.localdomain (122-63-72-97.mobile.spark.co.nz. [122.63.72.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afc8a84sm17234894b3a.38.2026.06.16.22.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 22:20:49 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	kjlx@templeofstupid.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v6][makedumpfile 09/10] Doc: Add --extension option to makedumpfile manual
Date: Wed, 17 Jun 2026 17:18:33 +1200
Message-ID: <20260617051834.95404-10-ltao@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617051834.95404-1-ltao@redhat.com>
References: <20260617051834.95404-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oUQbjdDgozD1BXYLWoHwxGzjfXrk1T81-C82zs_-MXw_1781673651
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260616_222054_911526_1C6F22B8 
X-CRM114-Status: GOOD (  11.11  )
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
Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Signed-off-by: Tao Liu <ltao@redhat.com>
---
 README            |  6 ++++++
 makedumpfile.8.in | 11 ++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/README b/README
index a80b656..b674a10 100644
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
index 1edd0ff..b1a0991 100644
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
+(-d dump_level) based filtering; as well as kernel data erasure. The option
+can be used multiple times to select various extensions. NOTE: this option
+needs EXTENSION=on when build makedumpfile with libbpf(>=v1.4.0). Also this
+option only works for kernels with DEBUG_INFO_BTF & KALLSYMS enabled.
+
 .SH ENVIRONMENT VARIABLES
 
 .TP 8
-- 
2.54.0



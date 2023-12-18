Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16741C35274
	for <kexec@archiver.kernel.org>; Mon, 18 Dec 2023 08:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kNw4Z1VFHZxD0P63vL6PMI0r9YFRMWx856YXmhOSy5A=; b=b9+Wo2VRg1Uvvo
	Ke7PC7dx1uqJKzYo1RVPNQYgesLu18AoSab4ZM+eHxeUTwWBcgMOaG4QxjyffCuvoAn0K/tgFgHR0
	C+/3WHCNcPhOrGUBb0C2hv5BPd2B/PyaTx8SmL4naisKhMr8G4tR4J94NLKhWl0YkSGiy5ePQkusC
	O2MGzRHpj5AY4Z7voPtQv91bIvtXfyxZ1Vx+tqstYXoQKIygCebCOhyjopOkuYBPN0yYwnGVEJUpN
	N6hVcSXKaKlY28WpeOo4bsQw7bSQJY2GzLbJE61ICp0K4WA+madEw7vy1cQsiogec1xl1mfAbr9IO
	BL0oeI0TfiAfte2gbxLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rF8rF-009RuC-1d;
	Mon, 18 Dec 2023 08:20:13 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rF8rD-009Rtj-0l
	for kexec@lists.infradead.org;
	Mon, 18 Dec 2023 08:20:12 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6d8923fe26bso91921b3a.0
        for <kexec@lists.infradead.org>; Mon, 18 Dec 2023 00:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702887610; x=1703492410; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGXJfJUC6+i72m0QAwIpuYVASGrOzqEaIU/ssLgkxys=;
        b=Fzu/R32QWqIeUAQ7PaCQag2go70fYdZQnYhulefCeirUYBtWE0jrxAMD4Rp66FOgvA
         iDuDAhkgyCJXsmEQTDXD4SDfX+n6mwI47iudV30dvmxeyaHAXS1RRLIJ6UgEvkK7fqB/
         Nr3WGVmlc60gGI+/31YnJ+QeJo8durkkSFHZwC6r6NKQ2sZRsRfOydaWd8lGjn4FtQ8/
         0jojPEo0y5xxnpl68mFr/TecXjeGPAQCEmMwjaEMn4gyxpsEp4W1frJvF8Mj6AvX5u1R
         fxxtOdCKK5p0N/IX+Zd6wTogh+bWXBl+cDsXZKjW3kMoKoiSB/5KztrZUTC3MNpkEs6r
         VnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702887610; x=1703492410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGXJfJUC6+i72m0QAwIpuYVASGrOzqEaIU/ssLgkxys=;
        b=CjjnYJguf0nvx4dKvMuLmEsvG6j//o5w5iYlrYnZwNJzpUp+QR9MTnvnY/Xelj5MKE
         PM090RD1MSomzsFCAslLlUWFzH8GQrMiWarpQ6gOXjryuoHhqDP7QEANgdxYut9qIhiZ
         QygvJIuUkIDL26jTVMXKfJSzRSTAl/HDGnXoMbNCzWGM+WoJJmklnk14ayENmcZ6uUC4
         cvGxjS4PQ0x3/ykgkVvw9rXBlrKZUNwv0qBUwgpRTT9c5Ma97c92AqMj4eq/GIYVaAQu
         YvJh0qHe4OiqHlN6+NVkg6UwJSFK6D149dEHiw4TTme0urBHJpR8exiwWZb+C946oy27
         gxIQ==
X-Gm-Message-State: AOJu0YwVMrbPzYbAtCNMe1aQ291AGWFhgEuC5XPbo7rXjCN5bQ89o+6o
	KfNpFMXIY+86YZ2q+zLqVE4=
X-Google-Smtp-Source: AGHT+IEKvVYdPp68O5SMLi09JSS6ZiB8EJPj5nr/rrg/BFpl7pNHLPjglrvlKg1U1yk+zb4Au0xJjA==
X-Received: by 2002:a05:6a21:627:b0:190:354d:f90f with SMTP id ll39-20020a056a21062700b00190354df90fmr7340264pzb.117.1702887610090;
        Mon, 18 Dec 2023 00:20:10 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902704200b001d06b63bb98sm18426954plt.71.2023.12.18.00.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 00:20:09 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Takashi Iwai <tiwai@suse.de>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH 1/2] x86/crash: fix potential cmem->ranges array overflow
Date: Mon, 18 Dec 2023 16:19:14 +0800
Message-ID: <20231218081915.24120-2-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218081915.24120-1-ytcoode@gmail.com>
References: <20231218081915.24120-1-ytcoode@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_002011_274173_54CA2606 
X-CRM114-Status: GOOD (  12.21  )
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

The max_nr_ranges field of cmem allocated in crash_setup_memmap_entries()
is not initialized, its default value is 0.

When elfcorehdr is allocated from the middle of crashk_res due to any
potential reason, that is, `image->elf_load_addr > crashk_res.start &&
image->elf_load_addr + image->elf_headers_sz - 1 < crashk_res.end`,
executing memmap_exclude_ranges() will cause a range split to occur in
crash_exclude_mem_range(), which eventually leads to an overflow of the
cmem->ranges array.

Set cmem->max_nr_ranges to 1 to make crash_exclude_mem_range() return
-ENOMEM instead of causing cmem->ranges array overflow even when a split
happens.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 arch/x86/kernel/crash.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index c92d88680dbf..3be46f4b441e 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -282,10 +282,6 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 	struct crash_memmap_data cmd;
 	struct crash_mem *cmem;
 
-	cmem = vzalloc(struct_size(cmem, ranges, 1));
-	if (!cmem)
-		return -ENOMEM;
-
 	memset(&cmd, 0, sizeof(struct crash_memmap_data));
 	cmd.params = params;
 
@@ -321,6 +317,11 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 	}
 
 	/* Exclude some ranges from crashk_res and add rest to memmap */
+	cmem = vzalloc(struct_size(cmem, ranges, 1));
+	if (!cmem)
+		return -ENOMEM;
+	cmem->max_nr_ranges = 1;
+
 	ret = memmap_exclude_ranges(image, cmem, crashk_res.start, crashk_res.end);
 	if (ret)
 		goto out;
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

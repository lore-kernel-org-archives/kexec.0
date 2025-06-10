Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DE9C71133
	for <kexec@archiver.kernel.org>; Tue, 10 Jun 2025 10:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/uZ4S9/34v/3hH/OKtFsujF8ai9oip1Yehg2gKXo43I=; b=ElwdDklnl0UnZgSqjgM62mva9l
	CcbLUwqn4wSzXI+aVby6I1sENW1tRX9YeO1FCXRDl42IVZUrdOmQfrBnF7U/F+BldZUoZ3HnW6qru
	+tXHkNPunbFo8qgkfsU+fPj1ouHYO2uTCKMWJy6iqC0LOsXRjEpMWFvCzPnAwlj2yLB78lrBdB7yi
	71Id5jlgKznBG4WV/2nWvPrDcxLU2dDBmeOxZrkcUyJwmEr2YjryDGh+MfXBYnwSKvH0PUwb9MEs0
	0Bq7j5Et1z+xWQJO8LLYiVwSJkJdoS8X/6faUarkIEPA4CWci24BniGXcOZdCfRulVDG/XRPT6kja
	j54hFubA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOwf1-00000006YA5-0uJb;
	Tue, 10 Jun 2025 10:56:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOvlg-00000006Qf6-03Xb
	for kexec@lists.infradead.org;
	Tue, 10 Jun 2025 09:59:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749549583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/uZ4S9/34v/3hH/OKtFsujF8ai9oip1Yehg2gKXo43I=;
	b=NcKVqlfUpFx4Rd/9FDio16qa+9occcLKVNnzjFdxLB9fg4i+o5ClypR6sJhQe5ZjvZ1bBJ
	gBzsm4Cs0vKvpnj3aFJBLppbtPUFKO6eiHJdG5lxuZ+Hf36J0fiSDduHAB+ElJC6vjvvKM
	p4F5wXbaB7l8K2ktAlpbvwh7F8ScdrY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-nA2PnKzhPrS2jesudFtnng-1; Tue, 10 Jun 2025 05:57:58 -0400
X-MC-Unique: nA2PnKzhPrS2jesudFtnng-1
X-Mimecast-MFC-AGG-ID: nA2PnKzhPrS2jesudFtnng_1749549477
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2358ddcb1e3so80290745ad.3
        for <kexec@lists.infradead.org>; Tue, 10 Jun 2025 02:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749549477; x=1750154277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uZ4S9/34v/3hH/OKtFsujF8ai9oip1Yehg2gKXo43I=;
        b=fznQIAPX70nqP2jJyaqOZ0Ll8/7K6ggMtVk/Bv9mpFDMBmSuDkfXhuGKT3nO/77YIb
         Ofz70r8jgY16Vhr8/GEGKCZ5ALCaoDW8nz/kc1G0bZinO1tJD3F8WKixtIbKYMmEnmqW
         TrJbcU8me6VtW6teaWXNucT+8k/1XiYJqRWrTxV9XfkpTpz5O8SkMkJFVJKlbN/CU0do
         8HEzTw+CvY4boykGNj5WpoBxAV5lMl6C9696KKxiereG4uaCsAT+McsrIYgevwqA2J4J
         +II30Ge7JCiRetGQOW6S8+T0+Qm30RwYxI0jS5WNSeFKYx431vX8SWm4k2zWondMvM8R
         1Tgg==
X-Forwarded-Encrypted: i=1; AJvYcCWgRrBuWNtYIzaYCMqFkc5RYcXlAWoW42RaJqhYbW0Cl7wkTbGXaSTCoElphPik8iPZM3QH9Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YwH2O7U5eWorkp0RKmAofWKBmoDGvm5oIrLAi0L9aJ+e+ST3XTl
	1mSoaEMJtbEsX3watL6l2xq1gDUQpJOFveHC9k9dax+rgSr+I19SWMHZ6cgN46zhMCN7sLcvJzh
	Q4juG/6GaiUk1ZGy4XtWy6BEh9bW0MDtKkJgXRx+q5zTnEMOlEkO4DRfhWOpn0A==
X-Gm-Gg: ASbGncsHTDkunhWxeoQ8iGLAh/A76Mb7adKxhEp/UsHRotsiI8kvOhZbwvX01IsyI4f
	wilv4nr8Zih38c/PXziFO17fkZMHHGqCOz3VHTWt1twdq0xX0v4dzOCkK6YPXXIuTBW7diVkvlI
	SxaK8sjG3iOTe88tj6gEQ37ztTb4zvtubuNMw802bux/NT5vj6W7FDiMeNTzPQAl6Te+ESdMSqO
	SZQqXh4/Fgaknz7bJWj5OMABdVSRw2EJI70sqzKVjHnHQ0lxcFVni2GNNmnvwVpUmzTqo2jplP+
	QFnis8//V6oUszIfHXQsB3ctpDo1/EI=
X-Received: by 2002:a17:902:ce12:b0:234:ef42:5d5b with SMTP id d9443c01a7336-23601cf8db4mr241236505ad.16.1749549476907;
        Tue, 10 Jun 2025 02:57:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/fRnU/SXM5ecrJU6pzJNHjYfJIeoOoIqQ8vAygRXXWUiwGuC/nTaTf+45XeSBZDJbxq9fHw==
X-Received: by 2002:a17:902:ce12:b0:234:ef42:5d5b with SMTP id d9443c01a7336-23601cf8db4mr241236255ad.16.1749549476630;
        Tue, 10 Jun 2025 02:57:56 -0700 (PDT)
Received: from localhost.localdomain ([118.148.112.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603405f5fsm68189085ad.172.2025.06.10.02.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 02:57:56 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	devel@lists.crash-utility.osci.io,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH RFC][makedumpfile 01/10] dwarf_info: Support kernel address randomization
Date: Tue, 10 Jun 2025 21:57:34 +1200
Message-ID: <20250610095743.18073-2-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250610095743.18073-1-ltao@redhat.com>
References: <20250610095743.18073-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JgG96bJrxSI4jwRQ2QbfZaywl6q6ggcbgZm2DS3dxF0_1749549477
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_025944_123520_2E210834 
X-CRM114-Status: GOOD (  12.55  )
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

There is a bug of not supporting randomized kernel address, this patch fix it.

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 erase_info.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/erase_info.c b/erase_info.c
index af6bfae..b67d1d0 100644
--- a/erase_info.c
+++ b/erase_info.c
@@ -1881,7 +1881,7 @@ get_symbol_addr_all(char *name) {
 	if (!strcmp(get_dwarf_module_name(), "vmlinux")) {
 		symbol_addr = get_symbol_addr(name);
 		if (symbol_addr)
-			return symbol_addr;
+			return symbol_addr + info->kaslr_offset;
 
 		vmlinux_searched = 1;
 	}
@@ -1942,9 +1942,9 @@ get_symbol_addr_all(char *name) {
 	 * this function is called with debuginfo set to a particular
 	 * kernel module and we are looking for symbol in vmlinux
 	 */
-	if (!vmlinux_searched)
-		return get_symbol_addr(name);
-	else
+	if (!vmlinux_searched && !!(symbol_addr = get_symbol_addr(name))) {
+		return symbol_addr + info->kaslr_offset;
+	} else
 		return NOT_FOUND_SYMBOL;
 }
 
-- 
2.47.0



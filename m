Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8E3CCD19F
	for <kexec@archiver.kernel.org>; Mon, 20 Oct 2025 22:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sz3E6az2AG827xi7VpAsUO+/rbNT9kGXRyRUiZcBh7k=; b=0/LB84QDoPaMbj+PSDlfLkY9S0
	0oOOX+4NyHNxwuM+yU4TNgPz/tZNrkybkGgp2NCp9V+S8Wa5PRCjRQyqaYNvSOis3frn+m/ZIb/oe
	ozWZuP7dw7up5Pq3jFPWvZL3jb4mvy1pfY4zRPvJhyJtCuhK/b+jSKFxVpf5PgpJJHT5TqzFjXfzB
	A00D1EHr0flhzb5hy4x2x/H2uzHuG2Tzs7rj1vviBVSrult6lq9RT4VnpOh3+SCtJ7oNf8dPm4q64
	qlVNy7zbgG8UMW+U1NMwhLavhbx9lQ2XDYeARbcYN46stii1/HJBjzi/NncP9UrojOs16wzBBZm+9
	Tv1CGhFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAyIt-0000000FAtZ-2mWn;
	Mon, 20 Oct 2025 22:24:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAyIr-0000000FAsK-0Izq
	for kexec@lists.infradead.org;
	Mon, 20 Oct 2025 22:24:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760999072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sz3E6az2AG827xi7VpAsUO+/rbNT9kGXRyRUiZcBh7k=;
	b=GMWU9Pl62hCC+TKQSuXsTD/DcOmOhclN+m0mkir+ElNEcPoK7+R9rHS0X9cRMB6GoKA3PP
	SXxSiiG6SD8O4KZkxbwML6ipY0rdYrYjugOH4ukp13FR0eEawrH8WcjHvct45esFXa3Cur
	Q5kDN1rLvmUNuIdW5ns7wLxOlOhVgKE=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-Z_Fxl4-AOJGTOEt8DMG8nA-1; Mon, 20 Oct 2025 18:24:30 -0400
X-MC-Unique: Z_Fxl4-AOJGTOEt8DMG8nA-1
X-Mimecast-MFC-AGG-ID: Z_Fxl4-AOJGTOEt8DMG8nA_1760999070
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-783c3400b5dso3193744b3a.1
        for <kexec@lists.infradead.org>; Mon, 20 Oct 2025 15:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760999070; x=1761603870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sz3E6az2AG827xi7VpAsUO+/rbNT9kGXRyRUiZcBh7k=;
        b=HYnthnOxHURYAZ1AgQbTDqXHQfIatObLTctJCpF2dXUbJ19vbupSPnYQozllfxGmp0
         8xTnfoKVTNpnk6Q6/0LpwX8fWlNUEBWsL60k37stN2f9dysAVY4oeqFGTei6vfl+oSFG
         5f4PFpSCp1UnDdGqxsgaU/xT8AEF1HF7KfOoYujMulVp/2sL977M9b1siVodir0+2J4z
         gv0WQ0TWoq0vwPoUaWy/sj3TjDLWeGJS2gwolExaksrNgM/I8bkGI+JPVzoBjtqlqZgv
         gmjU/B9Ok7TUtnRvHR0V1w9bLk+HJl9lBO4ALuj2YeLHgrsQIEra6/LG+QgfxETxtw/X
         sJUg==
X-Forwarded-Encrypted: i=1; AJvYcCU4iTiNYk0IwqrdBHFfRQQTdBxOq7GLPKy6ANoQlKZRXaaWc2HrO9JBUFYZ9AJvAhcWtOtUJQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyt0oVve6S5qpCEJUteVqCe6PdGAR+r/tN/AsZdIKSx7DTOWloN
	0JalqLJmA2yhDQ4Bq+Wj3EXJScbGXyW6no69wAcSN1RVCGBSt3ZGK1BoncFi/81Woc7NJhIuyR6
	hsC71BXSrao/82I5ax8Ml5fFn75chRcjf/b/9XSonGrA42769+a13x52dSdNwyw==
X-Gm-Gg: ASbGncuqv5ysg94rIaFIWxFC48sOtbBTvS+6m8y4e76hUX/zp4iWN4x+PTnWWRxK7uk
	TPk8c8g48FXTaRI4TYX+8iIWDmmrk15y3wMPICOc6RjrGanLqEx4I4jPAB5y+OnjIm5/61epbqC
	VkT6MnIRGDZxMzlQHe8jIXGcww4hKmR5Od43F6bUbFpbpuzU9c0xLs0NAqyc12V5yfMyTgxfOhe
	yy5IIERMYRPZL/5s70sy43TNwyuDolWdkk0TCXy40F2w/WaelG1RxyWkOSJkbA3Wdi//BUHANj8
	Tofk8LZskV06ywspRwUwlyCtqu/6H53iOFK5+moFYhrdYgb+tbgd3RGneNWaiI/4EZw2hj/knhY
	WaqWktjeTq4HHnnY9Nnu7bND5ESAFMeZPvPl1jS527CI=
X-Received: by 2002:a05:6a00:2184:b0:792:4e77:6ffa with SMTP id d2e1a72fcca58-7a220b2c6d2mr14632227b3a.23.1760999069860;
        Mon, 20 Oct 2025 15:24:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsMGJw1/Iblq1MDiPd1VVG18HyBLLSfvCIW9wc9l3yVKslpYRr+xSCCrLPNBNT6SlZ/vtmIw==
X-Received: by 2002:a05:6a00:2184:b0:792:4e77:6ffa with SMTP id d2e1a72fcca58-7a220b2c6d2mr14632210b3a.23.1760999069471;
        Mon, 20 Oct 2025 15:24:29 -0700 (PDT)
Received: from localhost.localdomain (115-189-93-209.mobile.spark.co.nz. [115.189.93.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010e265sm9229263b3a.52.2025.10.20.15.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:24:29 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v2][makedumpfile 03/14] dwarf_info: Support kernel address randomization
Date: Tue, 21 Oct 2025 11:23:59 +1300
Message-ID: <20251020222410.8235-4-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251020222410.8235-1-ltao@redhat.com>
References: <20251020222410.8235-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y9UGZzKEd01VwQbqMsGkdpFirtrQrj7VZAr2R0F7GAI_1760999070
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_152433_182045_4DF4CF2F 
X-CRM114-Status: GOOD (  12.83  )
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
index fd316c1..d68e1a2 100644
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



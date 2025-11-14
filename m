Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34999CE8D76
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 19:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CmV4Tapi6eaC+qTnDSzcGvKGmED+q5xqWekcnxWZ1ms=; b=TJKLno3CWD0xwmNKBSkHlkIl67
	CLmCJUbrQHDbi+9iCn1FYmLBUaZkdmxvP8JgwTPYBkFkAlL+KwiAmLZRbuLzoXmgDn1c3/Z9y68jO
	ggy3EaVSIz+yuuRzhNMRFfQGoT/BuXKKLrslC/dwJSELwH8Uf1KiiHTYbpjzEZaDC8Fl6BctzksmQ
	VAAiMdGM/XnyG061Z61qSKC9l1ljT08VWhMlpX0aKmbwIAYDSGEN/tOaAPZD27Z8HzdHpBLKmWIK7
	dXj/7Z96ckHDkfQNuqI6BnASvXBrbaZWtWNZR+Bg3jfVBuyS7xBVaU8xfI8SrjNabiPVcxvIBm15t
	lXq+DgZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJz1w-0000000CzSC-1kTN;
	Fri, 14 Nov 2025 19:00:20 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJz1u-0000000CzPm-3uZm
	for kexec@bombadil.infradead.org;
	Fri, 14 Nov 2025 19:00:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=CmV4Tapi6eaC+qTnDSzcGvKGmED+q5xqWekcnxWZ1ms=; b=MyDVXls+oRgcsrlbET1MRgA6Rf
	N8GJGP3+7yVcN7wmJYHuXX8xP29nBuGsKoDfXiAXtVNrwazyAHc2V7c7+lNf+31yLSlVYKCTGbbP5
	fyxxhSGrNjDEPm2erdH7nAnYvGXjmJ42JhSYmcyJ45Jc7BQc/JmKrgyRg7SwJHbzf+LYuVekgyHF6
	erVYg1LSwqcNkuwh5puxKQLig8mjc/kYXViJazntNQ1ubBan5/wmhX00/hm4J5jITcnuQX4QleRQ0
	fiJWKku9mZxRBIFb/tHi/B/bKXg1qQKtmhAUnxrZO4l+u+91pJmiU84MWbt6tCCUvH7HO9VAcYJ6q
	UyNfK9FA==;
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJyAC-00000003JnZ-3pZg
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 18:04:51 +0000
Received: by mail-yx1-xb12c.google.com with SMTP id 956f58d0204a3-63e19642764so1973479d50.1
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 11:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763146814; x=1763751614; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CmV4Tapi6eaC+qTnDSzcGvKGmED+q5xqWekcnxWZ1ms=;
        b=cKQwIthFb7BHyPIo61WIwVDaibrrCaMQ9wd4dvbN2gMtqX1M5erCJ28fJOJYV/EPul
         4bp7OhQSIhZLyr+mVmqomCsPwF06teYmKaRXo2Xl4WGxXszBPoZTD4u9I96FyEwjrNwy
         Uvojyzv/JlF9RpfFvJOfP208ho9G7+3SfZAt2xILN90me6kM+bs/NOmPwzS3XGBerp2+
         qzDNb2sh8elyhvcv8Y1AC1Bo/TxSVu5JLaLCJvoYavJHLBOpjS1eqiigmV4SBfvPdSYA
         oMQ0Py4IJlODg5jtJWIJ6riwx1ta7Kreow61eBq2Yr9sfT3sdwgNlJax/Ox6Dwc9ecin
         PkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763146814; x=1763751614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CmV4Tapi6eaC+qTnDSzcGvKGmED+q5xqWekcnxWZ1ms=;
        b=FOicEvcLBoqYP6MLnznI8IjAGB/KjfX5meFuwqAWVAq8j6uwalclYsTVXuQb8uNjg+
         kPzmD1ysYObtu3h79LMNrSROb7ATjd9Bgg8DF0PTiPcaKLaGPnItjixyFnnJKGzhlsVx
         EjbjEAV4r2C+vpEiOel1KpPKQ9Z5fhiC6dfVrmaQ+ay41f3x0xSnDv0SwtrJf5ZRPqTz
         M9bu3iLFRINdpQT24BEJ8Gmb6bt2wxA5MZWhIB/eOFBmVwx6I31mgNebRXSUAKjnHsbV
         1cZi9RFeU3X7bh4uwXQq3MQPQBLXkfuvy0vSv6n7f0M+Tpa7aJ75AWnLKlNNn77CQrhq
         f0kA==
X-Forwarded-Encrypted: i=1; AJvYcCWfnpJG5jdvDjaWz7LrUq3Dwa/DkhhVSNbQ8/glG6QIMFqpSo9lpQSMJKA2ceBmba7E8zuBUw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxsTAm2th/9nYyo5845gzbdT6i2I9r3leg0MBJ+4CZ9JXjnIGOP
	HfowCrtuzEXvXMbhwOu6FQ7UPGkwt2TcCLNNfksINXiXrN9LH4yMfWu9pxn7w0QQARs=
X-Gm-Gg: ASbGncsjQMu5LWYpT4DltA/20r+rUxc++hwqsV4fhAwIN++IPSbRcUkr5D1T6HJfy3i
	zJvjCHG/ApNiPvIJHwHvOuNm4f3t3nnm0hF1RGGkyNYXppV3nAGMHnstHLfEUt5bd4HdFdYRnmO
	u8mtOSyizzvEVzPOo5A7EvGPMk7M8mVzJ8DRqf3HJ0NyXixQXOpgnHrvCKEuAQOKAXUUaIaERzM
	SvpqYf+SZu+EGj1lCFupzQq9WrZXuyraHPCrygLYxPXMrpsmNySWeRFBoh1vJx9Oqjd+0nSjbny
	Fp4KRf1fo3G8jMlQJSvbzayT5IKAkckbvoCHiroDQm98VJPeT3ubAiNyYkthYRyqSWarMyl+Yn6
	/fxOWJhFpA/DLBPMivLW2OYVeWUU5/f/l4YdPefhCIPi57XfLVE8fV4ke+XGWPpI0PG5eIDazD7
	86BoS/I+FcAxfZQTofsH3fZTXMfeWvt0FLRRL/XdyMTGjeh8dWwddq4eM2P3YKkbZuYbyB
X-Google-Smtp-Source: AGHT+IFAKuuH0ctE7rv8UKB4xSpR2fZv8zxYrTA+ywvPJYYrpw0z8KKJWcD+1hoAuKOrrQSN5X6HsA==
X-Received: by 2002:a05:690e:d06:b0:63e:b62:5826 with SMTP id 956f58d0204a3-641e7716e5fmr3272878d50.67.1763146813743;
        Fri, 14 Nov 2025 11:00:13 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6410e8f4f2esm2014058d50.0.2025.11.14.11.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 11:00:13 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	jasonmiu@google.com,
	arnd@arndb.de,
	coxu@redhat.com,
	dave@vasilevsky.ca,
	ebiggers@google.com,
	graf@amazon.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [PATCH v2 06/13] kho: Always expose output FDT in debugfs
Date: Fri, 14 Nov 2025 13:59:55 -0500
Message-ID: <20251114190002.3311679-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
References: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_180449_016800_AEB44B66 
X-CRM114-Status: UNSURE (   9.31  )
X-CRM114-Notice: Please train this message.
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

Currently, the output FDT is added to debugfs only when KHO is
finalized and removed when aborted.

There is no need to hide the FDT based on the state. Always expose it
starting from initialization. This aids the transition toward removing
the explicit abort functionality and converting KHO to be fully
stateless.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index bed611bae1df..3e32c61a64b1 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1234,8 +1234,6 @@ int kho_abort(void)
 	__kho_abort();
 	kho_out.finalized = false;
 
-	kho_debugfs_fdt_remove(&kho_out.dbg, kho_out.fdt);
-
 	return 0;
 }
 
@@ -1306,9 +1304,6 @@ int kho_finalize(void)
 
 	kho_out.finalized = true;
 
-	WARN_ON_ONCE(kho_debugfs_fdt_add(&kho_out.dbg, "fdt",
-					 kho_out.fdt, true));
-
 	return 0;
 }
 
@@ -1425,6 +1420,9 @@ static __init int kho_init(void)
 			init_cma_reserved_pageblock(pfn_to_page(pfn));
 	}
 
+	WARN_ON_ONCE(kho_debugfs_fdt_add(&kho_out.dbg, "fdt",
+					 kho_out.fdt, true));
+
 	return 0;
 
 err_free_fdt:
-- 
2.52.0.rc1.455.g30608eb744-goog



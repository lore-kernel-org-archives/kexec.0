Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1D9C678DA
	for <kexec@archiver.kernel.org>; Tue, 10 Jun 2025 10:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wQmLR0Z8AXNqfqqIVbsop67F3e6eYjJdyvMPpUHvRBI=; b=avQXYc5DkUjHj6iQj6XPpyqxQb
	l5beGpJUc1aF44MWho26V+X84t9y5NwyWBR6zyquOdspvCamrIkRyLAy6dc4/UoE8i/KAEPsPhagV
	sO4KN+42R3sIYivLh0mwvvn9XEMrRJMA2VkFhUgl1KNFhMU0n5CKav4gHfvKLE9yEQUa7Ux2Yot+l
	ExPPgrZXgEYBhOmoteuqY/OqVPTMwZQpdAeSoXVtgGfVRNeiWgsQgrLzzAI2xySxrV7Bt9Q/3Wc3D
	QeErWKV5T7CnT+keWLatgAwP+otzVQH4q7fleYsGgdTPfjQv+lSj41wTSgxBdUO1q9UUEpQxfNkf8
	W5I/LT5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOwez-00000006Y7i-1Ezx;
	Tue, 10 Jun 2025 10:56:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOvlT-00000006Qc1-2AwQ
	for kexec@lists.infradead.org;
	Tue, 10 Jun 2025 09:59:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749549570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQmLR0Z8AXNqfqqIVbsop67F3e6eYjJdyvMPpUHvRBI=;
	b=ejdwQPAB+lNmy/v/AyikXeoQ4VYxQH2xKw71ut6XW84MVkK6T7NXIpKGeBoJM7xZDbZJGi
	vgLvxa9wotwupffB/hCbFHQY0eko/YlwLH4kX/TALhzbq2lDQo8Y36c/WuLegKVEUQfMaR
	9Qqy2D6oRC1JH/cHTScJjBVggqvsxIg=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-KJ8jcWcpOFiUq8GCGQsCqg-1; Tue, 10 Jun 2025 05:58:01 -0400
X-MC-Unique: KJ8jcWcpOFiUq8GCGQsCqg-1
X-Mimecast-MFC-AGG-ID: KJ8jcWcpOFiUq8GCGQsCqg_1749549481
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-234dbbc4899so83189205ad.2
        for <kexec@lists.infradead.org>; Tue, 10 Jun 2025 02:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749549481; x=1750154281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQmLR0Z8AXNqfqqIVbsop67F3e6eYjJdyvMPpUHvRBI=;
        b=tUoIQlMc2fgRs3ByislH+xUThaDvPQ7O1WxD2lDHyGO8sExitXLEA6yJ2RqqTYrrip
         3tmbH/VZwJFSBsY0MQP0HOwshOm1XVBPPcTmukot+lVuYHi4HysTiKw0nlPGoIcTza8l
         yby392b0v8JVrazUsLyubCoTdSDKSF/oxKSVuSrRmXLmG7if7h2qiXoY3Ac2w+uPZ/mo
         /wxLclRzj32Ump482OKadpNNlN63F9jJK8kilFO3AX2m8IVCB3V/JQuwj4vbA0aE59vn
         E9zGVD/Bcp31mULNGOBk1gFQ8gRamthWKllZr15P7OzRRd1P5djq62lJTta0GjfGjNTS
         lYCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKLjNgu0O1g7dwcGhR5Tk12WI+EgNJEFMq1M69TKavFvYRJe9zh2/R7JihaijYbbTbaVcTwg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzIfCCywWBbO7VAQRXaTp8YkqWVPg2PxVE3cD0bfDX+TOts8GFD
	mZ/FaLoZhskqRzm+6ns8P5ubjD5lTAtwAdlUw0gxZU8YZOQnwYdrAfoO3v8PAxe2EiZJjPG0Ye6
	DEwUylWYuGIchhAMmKwNT3f/Ipsb9q/M9hDFIryUYgQDPVEPVyrcZxjcj0d8SKQ==
X-Gm-Gg: ASbGncvplYAc6bnhnjBnoy5x8VzJ9tB6JZaCKa3/psh2eG4ATmy5zGpGEDwPrsCFhVP
	rpnXHgTWN0Wx9c19paW5lwKqPTs3hcNVqd/Anatr2rC10kiD4aq5J6PQBLlDfa8OkNx1P7shYv0
	0SgdFRZDnC5ojSUzQsYjbM1THzp2U69yTf6rP47feZ8KLoGHCCD3LOmugP8SFosk/H/xnCxQ3LM
	NyXbDgOEKDBH1q0y582jbUlNHXTVxP9DnIs0EJRcPHR3HBH8BAJN5rCWPRjf1UU+q0cO0qLEbgZ
	1NaIjR5X0QK9BwNH3nQbCxkfNhWbH9c=
X-Received: by 2002:a17:903:1b64:b0:234:f1ac:c036 with SMTP id d9443c01a7336-236383596cdmr27783535ad.50.1749549480858;
        Tue, 10 Jun 2025 02:58:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHW6oZob5/z4KB7RqwvIMW4tDdZQAgQTWbj4fBlk+vjrMvnhrWn++yeKW34lGx8xIa/Z072lg==
X-Received: by 2002:a17:903:1b64:b0:234:f1ac:c036 with SMTP id d9443c01a7336-236383596cdmr27783385ad.50.1749549480554;
        Tue, 10 Jun 2025 02:58:00 -0700 (PDT)
Received: from localhost.localdomain ([118.148.112.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603405f5fsm68189085ad.172.2025.06.10.02.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 02:58:00 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	devel@lists.crash-utility.osci.io,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH RFC][makedumpfile 02/10] dwarf_info: Fix a infinite recursion bug for search_domain
Date: Tue, 10 Jun 2025 21:57:35 +1200
Message-ID: <20250610095743.18073-3-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250610095743.18073-1-ltao@redhat.com>
References: <20250610095743.18073-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u85vw_I-m4SK9aRO2PWuRADSlS9SVnNqiHJtC0CDsKI_1749549481
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_025931_631212_C7CBB733 
X-CRM114-Status: GOOD (  10.83  )
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

There is an infinite recursion bug noticed in rust symbols. The root cause is
unclear to me. This patch will avoid the bug by skip the recursion of rust
symbols, since currently we don't need to deal with those.

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 dwarf_info.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/dwarf_info.c b/dwarf_info.c
index a3a2fd6..73842ab 100644
--- a/dwarf_info.c
+++ b/dwarf_info.c
@@ -837,7 +837,7 @@ search_symbol(Dwarf_Die *die, int *found)
 }
 
 static void
-search_domain(Dwarf_Die *die, int *found)
+search_domain(Dwarf_Die *die, int *found, int lang)
 {
 	int tag;
 	const char *name;
@@ -859,10 +859,11 @@ search_domain(Dwarf_Die *die, int *found)
 			if (is_container(&die_type)) {
 				Dwarf_Die child;
 
-				if (dwarf_child(&die_type, &child) != 0)
+				if (dwarf_child(&die_type, &child) != 0 ||
+				    lang == DW_LANG_Rust)
 					continue;
 
-				search_domain(&child, found);
+				search_domain(&child, found, lang);
 
 				if (*found)
 					return;
@@ -924,7 +925,7 @@ search_die(Dwarf_Die *die, int *found)
 }
 
 static void
-search_die_tree(Dwarf_Die *die, int *found)
+search_die_tree(Dwarf_Die *die, int *found, int lang)
 {
 	Dwarf_Die child;
 
@@ -932,7 +933,7 @@ search_die_tree(Dwarf_Die *die, int *found)
 	 * start by looking at the children
 	 */
 	if (dwarf_child(die, &child) == 0)
-		search_die_tree(&child, found);
+		search_die_tree(&child, found, lang);
 
 	if (*found)
 		return;
@@ -950,7 +951,7 @@ search_die_tree(Dwarf_Die *die, int *found)
 		search_typedef(die, found);
 
 	else if (is_search_domain(dwarf_info.cmd))
-		search_domain(die, found);
+		search_domain(die, found, lang);
 
 	else if (is_search_die(dwarf_info.cmd))
 		search_die(die, found);
@@ -1007,7 +1008,7 @@ get_debug_info(void)
 			ERRMSG("Can't get CU die.\n");
 			goto out;
 		}
-		search_die_tree(&cu_die, &found);
+		search_die_tree(&cu_die, &found, dwarf_srclang(&cu_die));
 		if (found)
 			break;
 		off = next_off;
-- 
2.47.0



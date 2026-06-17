Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C419CD98E1
	for <kexec@archiver.kernel.org>; Wed, 17 Jun 2026 05:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qxuLptXB/ZLZQ8eygPS+oG5dUJlWGW1JFl2BoUoE+og=; b=MeGAw/VRAzCCSh3j9pSZ3IsTPj
	7P/Ac03OlOTQ6HfKFMLj9fbOg2mHw6AQ+5MN7dZgz5N9vX1tc0Ff8ryr8BxF+qtzOr+DDlDeAz7y+
	0nURnnCyE1LWbp0qGR7ggRlVxGTLkiK/flqoHA7bMys/bHxBU9UPZwTLrLvVwq1p/WMB6IOkuZN8K
	YTDXAnsQGNYmNKC8JG6/3RE0JAxXowF8fHki8a7iGUFGvjxsz1bOzhNbhQTQB7F+Ws65iVaf2jNsK
	C56khLMyJ0STdXo7zUFwx7OqY8hxh6+G5KqbWj2jN5YjL3gXjr8tf9xYKoQEQ/Gz/LARvchICL+c/
	d88A/vEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZihE-0000000GdxT-49Mo;
	Wed, 17 Jun 2026 05:20:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZihC-0000000GdwO-49G4
	for kexec@lists.infradead.org;
	Wed, 17 Jun 2026 05:20:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781673613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qxuLptXB/ZLZQ8eygPS+oG5dUJlWGW1JFl2BoUoE+og=;
	b=VEawtaniT0+ii1MtgpybMJlDWbDz6UYu9uTZIBN9o1JTmvm+lmFXAGgAZCvRaeOs3uDTlq
	MqAcZcpv+q0QClylShoq3ZqqPQCbRnSHTAC3WHoxxbM1MKtCAn09Jfy1+WsgvSRcCMoe3I
	mB6pXt+gUkL2PpYmnRqXYT7l9NI9RNo=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-lsvAIShVOEqlBX0HINk16A-1; Wed, 17 Jun 2026 01:20:12 -0400
X-MC-Unique: lsvAIShVOEqlBX0HINk16A-1
X-Mimecast-MFC-AGG-ID: lsvAIShVOEqlBX0HINk16A_1781673611
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-842688fa7b8so517888b3a.0
        for <kexec@lists.infradead.org>; Tue, 16 Jun 2026 22:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781673611; x=1782278411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qxuLptXB/ZLZQ8eygPS+oG5dUJlWGW1JFl2BoUoE+og=;
        b=RaaJ/cZRIxJl+XwsrhryQpCdi/O9LSehg9EyZiy7g/RU4qfEXS3aDk4rI6fG44W9SW
         /Qrqr6Yo9SEMWWyiRGL5RmSRVMun7cpF9WRUiuNIItjYXe67+iRo0Ttf8zcTGC4MKHTp
         xul/WZY7BWgO7v+Fv3Cy53g5E6jpTYCnk6VjwcL6maWF2NBWPBtAvCUCrDa1l0tK+a6+
         YiDjKU0G3TqODSyqSKxVXvrAImfsWZdjFll2DLsPaxZ2kb/ab4GMAE17X9G6HZgevy68
         QiFGfd+NGE4ssR4Uyhimxs1mdJpFROKdd71gX9wkGweeRGsAsm1cwKGCdWNM2ioZoiZC
         KjVg==
X-Forwarded-Encrypted: i=1; AFNElJ/aC4Sp64EC1kXCqU0PG0TVrkmo1IYuDc4DSdWyA2jpATxKEr7tmnvMbIDabQBi8BSvO2f+kg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxRnnXqBq1hj5MsiHBcIxjfCp2NsH3e5PeX7iBpkEqnDP8cRTmp
	BbgN7IvnMgk+rl22bMMVd0fXx9m4Y0DoZY0rDQSXSOAARWxLk5dBfaBb8rDFPmgVzpyUx8uhQ0S
	HXDmdjOXh8B4oMcd9oYEH1pOgMvCb8nw4rrySKJMbjczHgeeXMwQ2OnumfnqcLw==
X-Gm-Gg: Acq92OHQWI6jVN4jr/Mmqv5vAbArxBgrKLHfrbCKlOo34GkKtplD2APBI4NnXqRuhiK
	pCnMlVQ+K3dAmrpFqpkkxuJPijlGrtlExDuC++8MUsWx/NQg/KHeMSGxwf+L7WfqD6943iUcdgW
	D/YfHHUwVz7y/Ov2ZIIFgrSQwDzOo6ck5GUJa/CKn9cGlCUUnhQizqbWNeLPkR/pXp721smb18F
	bZKX9Mthv5j5vGppxw2j6fdYHRI7sjOArvuLHFy/lPQWluRY8UZnJwSP4w2GxrDO9DXpT02cR/f
	4KIcx8riqqaMRYCmERyxBHFZ04vMNhVRfo93VbarNx4+ZCQlf6Cs6R8xWlQN7QAWrwmMCLYsLm2
	h0jjT1g01WGm/GcDrlQCIAnC0sLLTiBwIQMZzdfNqgKGCKMVhXA==
X-Received: by 2002:a05:6a00:1796:b0:82f:7888:e2fa with SMTP id d2e1a72fcca58-84526b5221dmr1355421b3a.17.1781673611027;
        Tue, 16 Jun 2026 22:20:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:1796:b0:82f:7888:e2fa with SMTP id d2e1a72fcca58-84526b5221dmr1355403b3a.17.1781673610595;
        Tue, 16 Jun 2026 22:20:10 -0700 (PDT)
Received: from localhost.localdomain (122-63-72-97.mobile.spark.co.nz. [122.63.72.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afc8a84sm17234894b3a.38.2026.06.16.22.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 22:20:10 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	kjlx@templeofstupid.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v6][makedumpfile 01/10] Reserve sections for makedumpfile and extenions
Date: Wed, 17 Jun 2026 17:18:25 +1200
Message-ID: <20260617051834.95404-2-ltao@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617051834.95404-1-ltao@redhat.com>
References: <20260617051834.95404-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -QyCs4qY4SMeLJX9-4qAagnwFa5Y99mQfEd22bLJ__I_1781673611
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260616_222015_102078_B9FCA533 
X-CRM114-Status: GOOD (  12.98  )
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

This patch makes preparation for btf/kallsyms support of
makedumpfile and extensions. Any needed kernel symbols/types
will be reserved within a special section, .init_ksyms for
kallsyms symbols and .init_ktypes for kernel types. During
makedumpfile kallsyms/btf initialization, those missing info
will be resolved. A makedumpfile.ld script is introduced for the
purpose.

Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Signed-off-by: Tao Liu <ltao@redhat.com>
---
 Makefile        |  2 +-
 makedumpfile.ld | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)
 create mode 100644 makedumpfile.ld

diff --git a/Makefile b/Makefile
index 74acbe2..9482332 100644
--- a/Makefile
+++ b/Makefile
@@ -113,7 +113,7 @@ $(OBJ_ARCH): $(SRC_ARCH)
 	$(CC) $(CFLAGS_ARCH) -c -o ./$@ $(VPATH)$(@:.o=.c)
 
 makedumpfile: $(SRC_BASE) $(OBJ_PART) $(OBJ_ARCH)
-	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJ_PART) $(OBJ_ARCH) -rdynamic -o $@ $< $(LIBS)
+	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJ_PART) $(OBJ_ARCH) -rdynamic -Wl,-T,makedumpfile.ld -o $@ $< $(LIBS)
 	@sed -e "s/@DATE@/$(DATE)/" \
 	     -e "s/@VERSION@/$(VERSION)/" \
 	     $(VPATH)makedumpfile.8.in > $(VPATH)makedumpfile.8
diff --git a/makedumpfile.ld b/makedumpfile.ld
new file mode 100644
index 0000000..474ad41
--- /dev/null
+++ b/makedumpfile.ld
@@ -0,0 +1,16 @@
+SECTIONS
+{
+	.init_ksyms ALIGN(8) : {
+		__start_init_ksyms = .;
+		KEEP(*(.init_ksyms*))
+		__stop_init_ksyms = .;
+	}
+
+	.init_ktypes ALIGN(8) : {
+		__start_init_ktypes = .;
+		KEEP(*(.init_ktypes*))
+		__stop_init_ktypes = .;
+	}
+}
+INSERT AFTER .data;
+
-- 
2.54.0



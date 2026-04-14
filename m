Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A005ED7B9A
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 10:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=djFNrxHWp2tkVkQMqB52uGt0G0Z8SwlnT1FOoqobWms=; b=RoiqFcz9tQ65F3CC98Qbh/KWpW
	4BqKH3FE0yARv9ZrNp6ZzKDY4WJpDof3PVQ4CcVQepyKkdHfzq4x3ZxdNELjmQy1DlnWSAb2EpHcP
	tcGuFqWwk+MgKD62UNA5k9X4DXgo8dEu+4OmixoXGb1bGRd4A6J/ArfbVgPrL8Ib7tPl0LnE115LX
	m0Ay4jsFjYYAatwa+6UDGOuvsxLYqRKzoQP1WmPP/H5OxFBiJR2HFxFtG9vaoyyS3BuE/LCWNw7Pc
	aWY2iOcC9yR30XPqpgmFONdBABhu0kGS67esfxPdTWTMzSq9JH8O+oL+uGhWeUgU2iorLy9qg+1n0
	I0Y9QJsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCazO-0000000H8oC-0m9E;
	Tue, 14 Apr 2026 10:27:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCazM-0000000H8mo-1ANU
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 10:27:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776162443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=djFNrxHWp2tkVkQMqB52uGt0G0Z8SwlnT1FOoqobWms=;
	b=O0Uqj9ETue+7Pp9AbxTFlf1iAy3GCGDK5wjWYVBA7nmVeFg0Z/MRx+mTjxi7HQBLuA1vwW
	z1xTS229y+HX4W6OvU5sLfIsKaSQaYNbM7I4lhbOTlQhQ92VBvfSWMA6PM7vA7BWFIDurp
	aLJbq1MXWd5LsFxVP/gChg2NUYGYrGA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-7E2GpTzYNGeaA_quIAOcSg-1; Tue, 14 Apr 2026 06:27:20 -0400
X-MC-Unique: 7E2GpTzYNGeaA_quIAOcSg-1
X-Mimecast-MFC-AGG-ID: 7E2GpTzYNGeaA_quIAOcSg_1776162439
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b45cd0bb96so22070785ad.3
        for <kexec@lists.infradead.org>; Tue, 14 Apr 2026 03:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776162439; x=1776767239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=djFNrxHWp2tkVkQMqB52uGt0G0Z8SwlnT1FOoqobWms=;
        b=qEGaDqt6qBqF2bNxKQLOO6Yy7GeKhPX9+5bNZ3bSkeHF3UXvdYZPvJb/KLdEbKk1+b
         5hdrHENe1YuQShSrnIECsopyoYnuPXRXyp9EFY4masz+Zu89I8vescjV+Na1paIYo+uf
         c/I/+/2WnfElimG9WqNrR65zsErt6r9wrSQ9G4ZBunvwO4TBCruLQvb+r2bvoDNsb17y
         q4q6KM9bUn2XGqCUQhJPsjms1QmEAf/7mU+w0KjMOCEz3wHEUtn/1g9hoSfblx4XKvKi
         MBrzn5obZMocYKLlf5RM/RENTQOMoI3G3wAqT6fyJffRaEJkxbxOdcWJ4XNVzdNsJLYY
         OISw==
X-Forwarded-Encrypted: i=1; AFNElJ+0j2n37O89Fa37CPVDswUZ1s/wQmmF8BRRattIP/USsgHjvZXCEyl+tAYO4DRJ+hbu7ONlew==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx7VdOAb7Exk3ounGPkvSamfeZn6YMiijDoQomYDoVRyh3c2ic7
	j3vzhVHf2HFytFcQ7meM9+4uZU2blkgOfiQn4NCMgUwjo5oehl+fFXTH+4tNSwOymKdirjckkbY
	Ux4baCsG3f1lh3IO5PS2Th/AXBDyv5Ob4Reyk7oTJChKkM4CU2I7O1TBA1zUIBA==
X-Gm-Gg: AeBDies9+jh0eRnLbaTPJVhtYpaaENiKAVialq4SpCuwnn8q2a2KtsC9hk1IBnT/BzS
	q2I2PPRZCiAeqMYbTsySeUys2j9DXh9Nxgx5Jl8pzX367q9kYPxu53OCljto32V+3+pQ9H4IY0S
	JLMIDmU6xvm55qLk5is3AKULP2ROc0BZHC+MIXYF/u4qmEX86TDlfhCj5wqvSRYfCsKmd2dey/5
	jQgdGiIj4zs/LY/iEgeJz66yYDivxtZ2bcKXrwksy0H6R7fPT2ETRamzXGN4JCZOa/6cDOOljBE
	6uWp4Mih4RVNNHPmXTh4VMbwkB5gu70/e48/qkeZ4IT+pyQv1wsu997yL/xijwQDdQOtW4QvGYT
	2zdORd5cgvJvkhOTLaM6rS0j1nE5C4CCzzUnl1+Kg+Qy27gs3c+XR0uflBuaePtnxIdm6
X-Received: by 2002:a17:903:27c5:b0:2ae:8253:1452 with SMTP id d9443c01a7336-2b2d593e9a0mr108157695ad.11.1776162438988;
        Tue, 14 Apr 2026 03:27:18 -0700 (PDT)
X-Received: by 2002:a17:903:27c5:b0:2ae:8253:1452 with SMTP id d9443c01a7336-2b2d593e9a0mr108157505ad.11.1776162438414;
        Tue, 14 Apr 2026 03:27:18 -0700 (PDT)
Received: from localhost.localdomain (122-63-70-7.mobile.spark.co.nz. [122.63.70.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f431c3sm136809165ad.79.2026.04.14.03.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:27:18 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v5][makedumpfile 1/9] Reserve sections for makedumpfile and extenions
Date: Tue, 14 Apr 2026 22:26:48 +1200
Message-ID: <20260414102656.55200-2-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260414102656.55200-1-ltao@redhat.com>
References: <20260414102656.55200-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: o139iDJhLi7vufVremDyq276xeeDdx9fnED_HgTvzpY_1776162439
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_032724_389670_9D409F19 
X-CRM114-Status: GOOD (  13.23  )
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

Suggested-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Signed-off-by: Tao Liu <ltao@redhat.com>
---
 Makefile        |  2 +-
 makedumpfile.ld | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)
 create mode 100644 makedumpfile.ld

diff --git a/Makefile b/Makefile
index 05ab5f2..15a4ba0 100644
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
2.47.0



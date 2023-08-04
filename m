Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D44C001DB
	for <kexec@archiver.kernel.org>; Fri,  4 Aug 2023 09:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=MXBuTBs7y/nx7UsI4Hzkc7L4gCTW2yZU5gVVx+xPbyw=; b=YhUmKIi1lxnu0j
	MKKQIzs6ZDtQkOkufV6xUp6rZN+tXmUS/42YMxgw7WXy73NHZonq5urtZSakyyim8GcG+0gdhTAg2
	YDvkzjuRZdcWyDz6Uq1yMDJdD6fmr1ot+jfirG+ZX+uu/ABdRO1qitMmfH2lMJn1D387Zvvvfu/aG
	DvLRNs/er/PH5pLt1ojDWZ/P3v7BcyISD1Hx09Furd70qY9OGV+D70OYL3d83D7M4RMuuhE38p9jw
	l7XwmxGeIqbDQkJkS9lsu+rIRCA4mtQCxJDcG8feK1jBf15AkK8sXDIi6ud2IOMeU/7z8WMj1PVwV
	j7j//1VsVtQfcqn15TOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRquy-00Bz9E-0V;
	Fri, 04 Aug 2023 09:16:20 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRqut-00Bz8G-1Y;
	Fri, 04 Aug 2023 09:16:16 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bbc06f830aso13439305ad.0;
        Fri, 04 Aug 2023 02:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691140574; x=1691745374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UrjG9rnH2NzTSctzZIvkOvwr1uRZUx+aymjSrHb5yT4=;
        b=J5Fii411FDOFOVqMoeCwM4rXnVKKuG5itOI2EgfdPtx4pBv4yfe8VwmQKRChb6WrKr
         RXF3+IA/ZVrP4wVghO9A8AGTUOvz2FVM2AzP3rxzWPRTgleKnjUdf/Ae7GiB3VxqRhtz
         r8yVJOfba783a4NX0Em3fviXKA57GA5hUv4VzEKcA2Qdtm0LAPFgoxZtgU5elTRKN9rT
         8ugSMgh6IvS1R/7etfJxoJ7vZf9Ck0r6tlG1VoesLwATVOsKMQmMRvnSlFyMoAFH9cfE
         dQc589fD5ZET9IuOshJXFKt+fzpXs11MUZ/yhvr+VtGuNR+76TVz/CDAA5txsetPipcE
         A9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691140574; x=1691745374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UrjG9rnH2NzTSctzZIvkOvwr1uRZUx+aymjSrHb5yT4=;
        b=CODjE4duoXA9DHs4bfEim6p2RZhdP+YnaTMdCa9a28Mxv0+eZtA3/5OkovIYJO/+Px
         OSF0Ec9kPvxo24vlwYuCp81apKG6p+Tj82Xs0tSfTYdB/epnJXSBaHR0Hz4GpyQGkFIt
         ReAsn4BcVYILmAnD5epBb4HPmCCt4VPRJb4REgEYPuO/RPmQq/LIEMoWdJRY9jAWBUjk
         f+ekudbp4YL4eiDiccjTKrBcfYhJljsJ4thNQMyLpOOnnuxMWhKEXZ85w0/tYkjSko3Z
         wcIGDVtG3q4kMPSO9gRHvJLm0peGSL31ujXKMZlmy/mDXGcZCmsFO8J0Ey80H7woUitl
         Z/9A==
X-Gm-Message-State: AOJu0YxPtsHMG9GGWz9b82QyAoftrBhu9JnSaXmTu0ZbHIMj+nv4662K
	LvRJHSuZ8+Gn4+A6JR8gMKs=
X-Google-Smtp-Source: AGHT+IGOo/8nQx5lnqtY++gVvvtI8ONaHpiJgRZeRc8p6gTLm5RJIluatJIAabgFdQ2xuZZiaYNfsA==
X-Received: by 2002:a17:902:d4c5:b0:1b8:7613:594d with SMTP id o5-20020a170902d4c500b001b87613594dmr1867250plg.24.1691140574150;
        Fri, 04 Aug 2023 02:16:14 -0700 (PDT)
Received: from localhost.localdomain ([2408:843e:c90:213e:379:7882:d981:bf4c])
        by smtp.gmail.com with ESMTPSA id r1-20020a63e501000000b00564250660f3sm923322pgh.78.2023.08.04.02.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 02:16:13 -0700 (PDT)
From: Song Shuai <suagrfillet@gmail.com>
To: xianting.tian@linux.alibaba.com,
	mick@ics.forth.gr,
	heinrich.schuchardt@canonical.com,
	guoren@kernel.org,
	k-hagio-ab@nec.com,
	yixun.lan@gmail.com,
	lijiang@redhat.com
Cc: linux-riscv@lists.infradead.org,
	kexec@lists.infradead.org,
	crash-utility@redhat.com,
	Song Shuai <suagrfillet@gmail.com>
Subject: [Crash-utility PATCH V2] RISCV64: Use va_kernel_pa_offset in VTOP()
Date: Fri,  4 Aug 2023 17:15:59 +0800
Message-Id: <20230804091559.3005820-1-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230804_021615_518002_6CA93105 
X-CRM114-Status: GOOD (  15.36  )
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

Since RISC-V Linux v6.4, the commit 3335068f8721 ("riscv: Use
PUD/P4D/PGD pages for the linear mapping") changes phys_ram_base from
the physical start of the kernel to the actual start of the DRAM.

The Crash's VTOP() still uses phys_ram_base and kernel_map.virt_addr
to translate kernel virtual address, that made Crash boot failed with
Linux v6.4 and later version.

Let Linux export kernel_map.va_kernel_pa_offset in v6.5 and backported
v6.4.0 stable, so Crash can use "va_kernel_pa_offset" to translate the
kernel virtual address in VTOP() correctly.

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
Changes since V1:
  - remove unnecessary first kernel version check as Kazu suggested
  - amend the commit-msg as Alex suggested
---
 defs.h    |  4 ++--
 riscv64.c | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/defs.h b/defs.h
index 5ee60f1..c07e6d7 100644
--- a/defs.h
+++ b/defs.h
@@ -3662,8 +3662,7 @@ typedef signed int s32;
 	ulong _X = X;									\
 	(THIS_KERNEL_VERSION >= LINUX(5,13,0) &&					\
 		(_X) >= machdep->machspec->kernel_link_addr) ?				\
-		(((unsigned long)(_X)-(machdep->machspec->kernel_link_addr)) +		\
-		 machdep->machspec->phys_base):						\
+		((unsigned long)(_X)-(machdep->machspec->va_kernel_pa_offset)): 	\
 		(((unsigned long)(_X)-(machdep->kvbase)) +				\
 		 machdep->machspec->phys_base);						\
 	})
@@ -7021,6 +7020,7 @@ struct machine_specific {
 	ulong modules_vaddr;
 	ulong modules_end;
 	ulong kernel_link_addr;
+	ulong va_kernel_pa_offset;
 
 	ulong _page_present;
 	ulong _page_read;
diff --git a/riscv64.c b/riscv64.c
index 6b9a688..7b5dd3d 100644
--- a/riscv64.c
+++ b/riscv64.c
@@ -418,6 +418,28 @@ error:
 	error(FATAL, "cannot get vm layout\n");
 }
 
+static void
+riscv64_get_va_kernel_pa_offset(struct machine_specific *ms)
+{
+	unsigned long kernel_version = riscv64_get_kernel_version();
+
+	/*
+	 * Since Linux v6.4 phys_base is not the physical start of the kernel,
+	 * trying to use "va_kernel_pa_offset" to determine the offset between
+	 * kernel virtual and physical addresses.
+	 */
+	if (kernel_version >= LINUX(6,4,0)) {
+		char *string;
+		if ((string = pc->read_vmcoreinfo("NUMBER(va_kernel_pa_offset)"))) {
+			ms->va_kernel_pa_offset = htol(string, QUIET, NULL);
+			free(string);
+		} else
+			error(FATAL, "cannot read va_kernel_pa_offset\n");
+	}
+	else
+		ms->va_kernel_pa_offset = ms->kernel_link_addr - ms->phys_base;
+}
+
 static int
 riscv64_is_kvaddr(ulong vaddr)
 {
@@ -1352,6 +1374,7 @@ riscv64_init(int when)
 		riscv64_get_struct_page_size(machdep->machspec);
 		riscv64_get_va_bits(machdep->machspec);
 		riscv64_get_va_range(machdep->machspec);
+		riscv64_get_va_kernel_pa_offset(machdep->machspec);
 
 		pt_level_alloc(&machdep->pgd, "cannot malloc pgd space.");
 		pt_level_alloc(&machdep->machspec->p4d, "cannot malloc p4d space.");
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

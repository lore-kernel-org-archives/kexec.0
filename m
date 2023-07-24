Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B58EEB64DD
	for <kexec@archiver.kernel.org>; Mon, 24 Jul 2023 04:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=eguwr+f4225ZWJfKRslU1BX2W/cGJdUCXzeFHPFYcqY=; b=MJ3voaMriRoicV
	RiKZtQsfW29VQUKrEeN8fipUeyik8A1PbiSXfANTUg/xbAehpJxw0ezIgl1KMY7XAdovUxYknuxZQ
	Xx9AK9iTQc5b7FMd+12dzNXLPef/5UBhSoyfnMfV8qQJ7oxQoNyP9usYPUKfb+35YHlcIv7tRKmJ0
	0lcX4Vmx+PuRCoEs4iZakyn9RnQsJ5s2ITPCfPyRiraV/JMaeWM/lvrKieLPiFeK7dXwKfPP6hSye
	krtDWUvc9vvEk6fEiTBWm78lLjNrYcBUfR5hh8Ukgn9aI/FRJY8v8QGE1Ypgzndn+oy+bo7xZMBXa
	Mb0azVa6JASIqdbGcdJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNmqp-002hnQ-2C;
	Mon, 24 Jul 2023 04:07:15 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNmql-002hm9-0j;
	Mon, 24 Jul 2023 04:07:13 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b895a06484so22535385ad.1;
        Sun, 23 Jul 2023 21:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690171629; x=1690776429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rzaXmaM90CwRiDC0CLa3hn4H8n/ehUM+MFpO+YooPxs=;
        b=CNKzZeEhmV3IdmOlie4pEq8H78jaNra75posUh35xctFSDH1CsNqV59IULIJbs9+nZ
         Khpt6LS23j0F3MFYoLbo5XiG0GkmYR65lWx9yMay3Lc7egj+NWr1Aq+JWlmMNRr5qCwv
         BMgszrigMGpe2L6YOm9DOaT5kfz39X+GdZejd9/34OBj6dZZtDwr1ki4VRn1IMwWv+m2
         qqeG0XoGQYozJsOEMQiaHc2/dcNtOsV+zaovdU6k+n8EFChg2V/SyXL1UE7z56a3i/Fh
         DOz9ytVNl0ZXypOhc/BkBciRgaXD0RuJ5PKmAd5ntcS2biQNKudPkMMrXc+IKQ+VcrmK
         lyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690171629; x=1690776429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rzaXmaM90CwRiDC0CLa3hn4H8n/ehUM+MFpO+YooPxs=;
        b=QKq7fYIlE4R9tOQRLEGFkFzFG/b5WVLp2MDluDZp9nSwzqzYdIDrdClh0DGfPbiBCb
         5YSo6smT9MvKHxl5wSLSDKw/uKFU2d0pqcvxAChEwH6hg3YMllDRRjmxL9aaOtAJQW2k
         Wt+TBngvS2WkGByYrVLiAAf0Z2OosR8Wl5+uaJrqQ2Ij4iCVF2kqHcx8Kciyyhb42R4S
         U+6a0IAvffJEFHlVa7FCHrwpfwEZqeZONFbUFARTgA5msFoAy4sKgpFXX4wN1J5EYL3U
         Stv1eivmCd2A+FwBSY4gkBOAXO0wxh5AwIoEdZGsMdSO9niPm+MmA7SMdw1O26xzA79W
         +vvg==
X-Gm-Message-State: ABy/qLb7JHlXO/D8lENSgq5bA7/1IgauRiIVqheemQGzQxJq74HAeBtK
	Dky8fSCxIzqs5IqgEKe2kms=
X-Google-Smtp-Source: APBJJlH+vL/jc3UHlAMQGRlaqmRo5OtGvR159nOENE2Iim64hpkk3zo7UCerJIIfKQykGNjn0Ki+Cg==
X-Received: by 2002:a17:902:b114:b0:1b8:7483:d481 with SMTP id q20-20020a170902b11400b001b87483d481mr7488086plr.8.1690171629021;
        Sun, 23 Jul 2023 21:07:09 -0700 (PDT)
Received: from localhost.localdomain ([2408:843e:c80:6366:6f45:6862:79bc:e5e6])
        by smtp.gmail.com with ESMTPSA id u19-20020a170902a61300b001b830d8bc40sm7698126plq.74.2023.07.23.21.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 21:07:08 -0700 (PDT)
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
Subject: [Crash-utility] RISCV64: Use va_kernel_pa_offset in VTOP()
Date: Mon, 24 Jul 2023 12:06:49 +0800
Message-Id: <20230724040649.220279-1-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230723_210711_287412_3FB5EC7E 
X-CRM114-Status: GOOD (  15.13  )
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
PUD/P4D/PGD pages for the linear mapping") changes the
phys_ram_base from the kernel_map.phys_addr to the start of DRAM.

The Crash's VTOP() still uses phys_ram_base and kernel_map.virt_addr
to translate kernel virtual address, that made Crash boot failed with
Linux v6.4 and later version.

Let Linux export kernel_map.va_kernel_pa_offset in v6.5 and Crash can
use "va_kernel_pa_offset" to translate the kernel virtual address in
VTOP() correctly.

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
You can check/test the Linux changes from this link:
https://github.com/sugarfillet/linux/commits/6.5-rc3-crash

And I'll send the Linux changes to riscv/for-next If you're ok with this patch.
---
 defs.h    |  4 ++--
 riscv64.c | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/defs.h b/defs.h
index 358f365..46b9857 100644
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
index 6b9a688..b9e50b4 100644
--- a/riscv64.c
+++ b/riscv64.c
@@ -418,6 +418,27 @@ error:
 	error(FATAL, "cannot get vm layout\n");
 }
 
+static void
+riscv64_get_va_kernel_pa_offset(struct machine_specific *ms)
+{
+	unsigned long kernel_version = riscv64_get_kernel_version();
+
+	/*
+	 * va_kernel_pa_offset is defined in Linux kernel since 6.5.
+	 */
+	if (kernel_version >= LINUX(6,5,0)) {
+		char *string;
+		if ((string = pc->read_vmcoreinfo("NUMBER(va_kernel_pa_offset)"))) {
+			ms->va_kernel_pa_offset = htol(string, QUIET, NULL);
+			free(string);
+		} else
+			error(FATAL, "cannot read va_kernel_pa_offset\n");
+	} else if (kernel_version >= LINUX(6,4,0))
+		error(FATAL, "cannot determine va_kernel_pa_offset since Linux 6.4\n");
+	else
+		ms->va_kernel_pa_offset = ms->kernel_link_addr - ms->phys_base;
+}
+
 static int
 riscv64_is_kvaddr(ulong vaddr)
 {
@@ -1352,6 +1373,7 @@ riscv64_init(int when)
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

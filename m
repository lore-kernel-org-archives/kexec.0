Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCCFEC0032E
	for <kexec@archiver.kernel.org>; Mon, 23 Oct 2023 02:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	Mime-Version:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=4MRu8YRopJzy72ZAbMgCyQMtUBiqyuOFUoumC33PlZ8=; b=SbJ
	BRGiW4ILU9f1hbfPh64C7jbjSbkr0ayP8oX32ZhRx6rIdgn3ffjqrTmzxq/DFEVHYbrUCiZ6G1HPM
	Bg76ON6PPe426ow7jQuez1LqfcD1zwerhX4xQYlMaGtyxvW+WCuhqLdhypuF/lw7Wnu2yteX3RhmE
	ObvALlVpARYrwynd+1v2/vLJe6GI1hTxIHi0NqC/mmEQY8uPjDoSKjeAqOcfnYapDxs7u6KHOzPj6
	ON0CgjgbvYwASFv31pnsdddqyZoCvIORtzZq129fmz18ubbwhO8HLhuwPXHRfmgUs8MA2+xjahmP4
	c2+3uGOE2HevtTvMUCiWd//N94/P8rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qukj3-006FwG-0i;
	Mon, 23 Oct 2023 02:31:29 +0000
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qukj0-006Fvt-3B
	for kexec@lists.infradead.org;
	Mon, 23 Oct 2023 02:31:28 +0000
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d86dac81f8fso3648215276.1
        for <kexec@lists.infradead.org>; Sun, 22 Oct 2023 19:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698028285; x=1698633085; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i051oq9Sq7RRdnOZ5mTNUWUdMgsVYPFmVIteiDrh8b4=;
        b=f5bkPIfwMW7/9NUZEOq+eSgJAuN+C0GM2AcIlHB8Ci7iWK7Kx8WG360VEBfTh2NkvY
         9ZI4WwTGoilKfXvyCUI0h+l+gLvi3bO7fSpRSZ0Fepz6eRQoMO7WCiJkCvzbuceQUMVm
         hOADN4RYsaJKrBzR3o/7gIlZZpbpYO/1ixThptcIZqpUg0fu+n/nBcRTUWT+s4wl/hrL
         C/PoBAijUeFcj9djoSW9zaqOtEMKpvqzLOAZuCVc4IKe87zJHs8TfAeeooTdCzZ6Kfpy
         /FbxbiIfpiFtLP5BV3EdPtNQBPkBRE1FtsgbWQoKIpXCX3Y7au7vlUM7AFwmR4Fn0Nto
         FRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698028285; x=1698633085;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i051oq9Sq7RRdnOZ5mTNUWUdMgsVYPFmVIteiDrh8b4=;
        b=dCHu8H5PGzzHQ89jBlBA3hfDUtLrEzqFAYTDwpghqCvYw6j5qMisVHJheutl7tnv+w
         K5X3ZTpIm8pH6wIzwUopTv8dZVsqn57A0huAAlD/m/fZHdwcbJIvuWBSPIt8OdUYIXrY
         ormG1IbwCa4UjUtkG0eRPwAmSHv9L0ugF77ByuxeNpHNR8E70iCZ3LBrW1pavzrKuGeh
         0b9te/0S4m17OTFfWloqDiFEmY+p8m/Pmb2wI6dtXP7TFl+zqL54BtZy8mxlNCN/oHQ3
         /wQ8ZVzndTr9QOrBzevNrx8G2IT5C38AfsVr5g+uyypOiIK037D6eBAjCEm7xOtsPogI
         RSjg==
X-Gm-Message-State: AOJu0YxVl2hP69MbMsqrCFsqi2wy9ThD3IzW3LLzJhArgFYijFD1Mpom
	KK2cuL+Fyaj8EM/9P6sYjLvwUpmXOvjimZ0=
X-Google-Smtp-Source: AGHT+IEDHKZ2WJeGWk0321vcZMf4DAg9fPUhtFHtJdXcej40bv7/okhqiWF2bcMvcq2G55IOELysT0o7SeVgSEg=
X-Received: from jsperbeck7.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:26dc])
 (user=jsperbeck job=sendgmr) by 2002:a25:3491:0:b0:d9a:3dac:6c1a with SMTP id
 b139-20020a253491000000b00d9a3dac6c1amr155361yba.11.1698028285033; Sun, 22
 Oct 2023 19:31:25 -0700 (PDT)
Date: Mon, 23 Oct 2023 02:31:21 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231023023121.1464544-1-jsperbeck@google.com>
Subject: [PATCH] x86/kexec: set MIN_KERNEL_LOAD_ADDR to 0x01000000
From: John Sperbeck <jsperbeck@google.com>
To: Eric Biederman <ebiederm@xmission.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin " <hpa@zytor.com>, 
	Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Zac Tang <zactang@google.com>, 
	Cloud Hsu <cloudhsu@google.com>, linux-kernel@vger.kernel.org, 
	John Sperbeck <jsperbeck@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231022_193127_029764_FD682E27 
X-CRM114-Status: GOOD (  18.56  )
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

The physical memory range that kexec selects for the compressed
bzimage target kernel, might not be where it runs from.  The
startup_64() code in head_64.S copies itself out of the way
before the decompression so it doesn't clobber itself.

If the start of the memory range selected by kexec is above
LOAD_PHYSICAL_ADDR (0x01000000 by default), then the copy remains
within the memory area.  But if the start is below this range,
then the copy will likely end up outside the range.

Usually, this will be harmless because not much memory is in use
at the time of the pre-decompression copy, so there is little
to accidentally clobber.  However, an unlucky choice for the
adress of the kernel and the initrd could put the initrd in harm's
way.  For example:

    0x00400000 - physical address for target kernel
    0x03ff8000 - physical address of seven-page initrd
    0x0302c000 - size of uncompressed kernel (about 50 Mbytes)

The decompressed kernel will span 0x01000000 through 0x0402c000,
which will overwrite the initrd.

If the kexec code restricts itself to physical addresses above
0x01000000, then the pre-decompression copy and the decompression
itself will stay within the bounds of the memory kexec selected
(unless a non-default value is used in the target kernel for
CONFIG_PHYSICAL_START, which will change LOAD_PHYSICAL_ADDR,
but that's probably unsolvable unless the target kernel were to
somehow communicate this to kexec).

Signed-off-by: John Sperbeck <jsperbeck@google.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index a61c12c01270..d6bf6c13dab1 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -36,7 +36,7 @@
  */
 #define MIN_PURGATORY_ADDR	0x3000
 #define MIN_BOOTPARAM_ADDR	0x3000
-#define MIN_KERNEL_LOAD_ADDR	0x100000
+#define MIN_KERNEL_LOAD_ADDR	0x1000000
 #define MIN_INITRD_LOAD_ADDR	0x1000000
 
 /*
-- 
2.42.0.655.g421f12c284-goog


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

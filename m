Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71937C04A95
	for <kexec@archiver.kernel.org>; Fri, 23 Sep 2022 17:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Ft4e7ILzTcolF9hZA61fIc046dpLyLAccj7Ij+9Nxqc=; b=wdslbEgCSUSSNF
	BJaDxTBizzEkVyf+oJHrcxAj4x0wCuxATgqgSvlan/axLKnKX9o+GQ+XzupB0IH440nDc55Tt7LzJ
	S0ZzlLU3IlJcZLgheqI6u1vJeMgg1yH3hb1b4yOckb7QL0+eflQx44auIqWP4eDvtB5g2knbKy+KG
	Mi8QTzUsUCSwpaSHDfOv2NrUHa3Gu+7cOr5HiiG9chvPtLGcBTwjSRn7Uc8zgoszWLpUx2LDVfn8T
	oiMMLABduX7k1O9XeH8tFnOQW0AFHprHcCX5mUl7glYS0anrnl+ioLzmHTn215cG8cOJT3Tf0yyPE
	3pQ8Rb0MRpdiYYVXaaYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obmCf-0054UQ-8a; Fri, 23 Sep 2022 17:11:05 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obmCa-0054Mh-Kb; Fri, 23 Sep 2022 17:11:03 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 9C334219EC;
	Fri, 23 Sep 2022 17:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1663953043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZSPBzEUu4HvvRKKrmrdU/FMS6Qx20fLyxT3yF1tghgc=;
	b=uumJiLIU2hCeUjB//pYmunQ3XhUTmH5n97IVRpx0df4OZYv5fuXBQ0xekIy4XJccvKNdf+
	ZZ2q/2pniI8zXucmq84IOe9+SqdEoZRhNamUxbx08sYZ/Rz9mhwPlaqhD1IuXjRA5vy2v5
	Iqu37b4i4NZhqLy45/3MLfqEcVgd2Os=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1663953043;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZSPBzEUu4HvvRKKrmrdU/FMS6Qx20fLyxT3yF1tghgc=;
	b=Fngpn3ub5IEe7UJDgzoo8OBgYwiwTJAr8CYGfJ5/Ppmar1cb8XYsiESPKo8Bi3lpB3A8SE
	scN82gpoaRkfC7CQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
	by relay2.suse.de (Postfix) with ESMTP id 44B9C2C15B;
	Fri, 23 Sep 2022 17:10:41 +0000 (UTC)
From: Michal Suchanek <msuchanek@suse.de>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Suchanek <msuchanek@suse.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Philipp Rudo <prudo@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Egorenkov <egorenar@linux.ibm.com>,
	linux-s390@vger.kernel.org (open list:S390),
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)),
	linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)),
	kexec@lists.infradead.org (open list:KEXEC),
	Coiby Xu <coxu@redhat.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 5.15 0/6] arm64: kexec_file: use more system keyrings to verify kernel image signature + dependencies
Date: Fri, 23 Sep 2022 19:10:28 +0200
Message-Id: <cover.1663951201.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_101100_831135_73F36C25 
X-CRM114-Status: UNSURE (   8.32  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hello,

this is backport of commit 0d519cadf751
("arm64: kexec_file: use more system keyrings to verify kernel image signature")
to table 5.15 tree including the preparatory patches.

Some patches needed minor adjustment for context.

Thanks

Michal


Coiby Xu (3):
  kexec: clean up arch_kexec_kernel_verify_sig
  kexec, KEYS: make the code in bzImage64_verify_sig generic
  arm64: kexec_file: use more system keyrings to verify kernel image
    signature

Naveen N. Rao (2):
  kexec_file: drop weak attribute from functions
  kexec: drop weak attribute from functions

Sven Schnelle (1):
  s390/kexec_file: move kernel image size check

 arch/arm64/include/asm/kexec.h        | 20 ++++++-
 arch/arm64/kernel/kexec_image.c       | 11 +---
 arch/powerpc/include/asm/kexec.h      | 14 +++++
 arch/s390/boot/head.S                 |  2 -
 arch/s390/include/asm/kexec.h         | 14 +++++
 arch/s390/include/asm/setup.h         |  1 -
 arch/s390/kernel/machine_kexec_file.c | 17 +-----
 arch/x86/include/asm/kexec.h          | 12 ++++
 arch/x86/kernel/kexec-bzimage64.c     | 20 +------
 include/linux/kexec.h                 | 82 ++++++++++++++++++++++----
 kernel/kexec_core.c                   | 27 ---------
 kernel/kexec_file.c                   | 83 ++++++++++-----------------
 12 files changed, 163 insertions(+), 140 deletions(-)

-- 
2.35.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

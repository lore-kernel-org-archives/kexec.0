Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDAECD5BA4
	for <kexec@archiver.kernel.org>; Wed, 20 May 2026 09:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9oyw9vanLGG7tQ9dBSW9pJHSWXBGqZj5GxnQmef6pVg=; b=xV/zRMqVx2h7Pl4VeJe4shhWRn
	jxXAHqOlmmtPaxaRSlIQuwf7MBI1e55HuiuruMSxYtNxpOrBIQ52Y9qgPw36asQjdNxywaKDmAz+B
	3H0JtCpThINzEBGLeCkVgBvuIrz1nzkjzrKlLHvS+elT/RU1Fy3MIs/FPpAdKtb+//8H/xRk/GmDH
	rhjsgkrtSRfrtdzy1qr5yF6h8TSDxWa9c5G9mGsYg/4GGShEXqtYUCfyZDSFKyiQVN3iFe1smXy7f
	yXPkrzy1Fag6kPMEXDAEFxhkE+1Y6NLzkkRGZz+vyeqA4Ib532xZCCSE+YTbja0y/66SHTiXZNdVC
	zJUOtWiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPd5I-000000046N8-3qTI;
	Wed, 20 May 2026 09:19:24 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPd5F-000000046Jm-324f
	for kexec@lists.infradead.org;
	Wed, 20 May 2026 09:19:22 +0000
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-835386ff122so4772886b3a.3
        for <kexec@lists.infradead.org>; Wed, 20 May 2026 02:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779268761; x=1779873561; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oyw9vanLGG7tQ9dBSW9pJHSWXBGqZj5GxnQmef6pVg=;
        b=F0BC7GrQ9gz40k05v4xdh2evvBiag1cSC9iop9xn53qN2aJDBmUbtCOjJ3najRlZBO
         dTNzh8HkZtfRBLlvnVYwXhVpwMwW6E+EaiuJRB1jUspZO4CR5ZcR55WE/ZdNhRfzdf0e
         CDL6n/IlvbaKj3aF2uFgKBiQrHDRey1tIDEBUqn6YhTETkiys5vX1loKSztemkzJbqAm
         2RhwGH2paqIZENTEISkaNSHa7Cc69EF8LL7yu/13cBVT99+WBOH2XnXs2drZOPppQ5vX
         gBgSVM4wKTS3xN17+JYpUtafJciJAwly/XBPN+GI1hGN2+Y5HKYmzjEXaDx7jcBMiMIx
         +EPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779268761; x=1779873561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9oyw9vanLGG7tQ9dBSW9pJHSWXBGqZj5GxnQmef6pVg=;
        b=LxUcaL4PtgBG9P5f2L+68Tl3Eg9rIPM++ykHbqZKw+OYEwgzccgSro0IW90PUk2YFt
         GQCNL6gbcaaYeu3zTM35SKWUPvNVXrCUbzo2aSI+a5WN4A+Y1G3bgr9wXSfkdL9nX5gW
         Y53r7fVUujFpI2ukce9hJ9CWq1Z5Xf59oHQpIlq9AZ+616PdqnEAwyIf7sgJ6f0OLs4E
         9eC3SpLoytyU5AXhJenAgCPdPyEsj3OiRc9osnVylaanGawc0DU4xmjoltbd0snoSucK
         KqCRt3ZMc4267okjo2m3HEGSa1+loAvY8nhkDUdYOebhx0VN9Z2PM9HMDgEKbfA30ogT
         qiQg==
X-Forwarded-Encrypted: i=1; AFNElJ9dFM6mlPQxRxM+2ntl579ySszQB1xJUfOCsXqyGjbeE4wFUfAZ00+b3deCuZcN3qyXrDYbbA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyG6oeVw06tQS8Te9+Um2YpkG86s9z9V+t63i5XXRsGguQaYegH
	uvv+vdShukl8EEJ0sXrJ3+Oc1ZUr1CE2t9JoFfrJ+y1YHqV8Uv/sxqNX
X-Gm-Gg: Acq92OFNBckX0PWscqBvPtwN5srK+Jde783dNxswOXA564miWECcbNnvFbB8+h8/LDH
	DDKyjTm4wGC4PNcbSEs/5AtGQ2QedoAZnCCZQ2U/7aO40xOREl7HJgjWgFmtb0pSMvJu7CXmbGu
	2y/pvRjkml5RI9nvWwsDNyJKlrp2wee4pEh9iYui3BZvbvxuSBsMWVqNr8QwMK9hpg/gd4ZsTYP
	KaaCGINkwJrnMPw2604xSiB980BWu5yPU95wsSaWrR4CLjWUOPEkDH+N6mW1y5mLCSeKoWAJAb7
	eBTC2eCKzZnAQoA55Ln4ey9JnPbjGwW5QscItLSalIBk5KJFD6jVCy4W397+9sKREsu0+4+YSxs
	36RHmicMFd+Mfmw8AS46UcAgxHktE5tImAAmUNtnu7VPGGksJWABUejq2rTGjCS93Vh7YrAEeWi
	NQBfPxnql8iNsP/l7yJEJFWxAbOyvvYSvqr+tJZg==
X-Received: by 2002:a05:6a00:3289:b0:82a:7aa3:a2fb with SMTP id d2e1a72fcca58-83f33c9b2dcmr22248125b3a.37.1779268761111;
        Wed, 20 May 2026 02:19:21 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f63bb986dsm10208967b3a.48.2026.05.20.02.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 02:19:20 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
X-Google-Original-From: Wandun Chen <chenwandun@lixiang.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev,
	zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	leitao@debian.org,
	kees@kernel.org,
	coxu@redhat.com,
	tangyouling@kylinos.cn,
	songshuaishuai@tinylab.org
Subject: [PATCH v2 2/8] kexec/crash: provide crash_exclude_mem_range() stub when CONFIG_CRASH_DUMP=n
Date: Wed, 20 May 2026 17:18:38 +0800
Message-ID: <20260520091844.592753-3-chenwandun@lixiang.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520091844.592753-1-chenwandun@lixiang.com>
References: <20260520091844.592753-1-chenwandun@lixiang.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_021921_786351_EBE021D7 
X-CRM114-Status: UNSURE (   9.48  )
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

From: Wandun Chen <chenwandun1@gmail.com>

From: Wandun Chen <chenwandun@lixiang.com>

Prepare for an upcoming change that excludes non-dumpable reserved
regions from the kdump vmcore and will call crash_exclude_mem_range()
from generic, non-arch code.

No functional change.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
---
 include/linux/crash_core.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index c1dee3f971a9..0033d4777648 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -87,6 +87,12 @@ static inline int kexec_should_crash(struct task_struct *p) { return 0; }
 static inline int kexec_crash_loaded(void) { return 0; }
 static inline void crash_save_cpu(struct pt_regs *regs, int cpu) {};
 static inline int kimage_crash_copy_vmcoreinfo(struct kimage *image) { return 0; };
+static inline int crash_exclude_mem_range(struct crash_mem *mem,
+					  unsigned long long mstart,
+					  unsigned long long mend)
+{
+	return 0;
+}
 #endif /* CONFIG_CRASH_DUMP*/
 
 #ifdef CONFIG_CRASH_DM_CRYPT
-- 
2.43.0



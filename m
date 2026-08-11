Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB69C5B56A
	for <kexec@archiver.kernel.org>; Tue, 11 Aug 2026 16:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xrrHTlApXY4U6JlaL8nMvnN7qO+xyOd6Xm+nS8KTJxI=; b=OuP7CkkA4jjB79UKj62mDqnCXj
	aEQbudR9jjBfvcwO4CH+v5kHPn0nJqJ/GUv/7h4oANN7JC2Nddu1MktSVoVAIeuyN5yyHDb9oBOyZ
	xf4NJA7C0KbNpg6QCIOGLNIMrJHjOkaNC3lzEU0EJaX3q7D5vbkzFkh42NPO/Ol9W8NJvykIy3/rI
	cC6LWQbhOq5a6GQxjAHQLtV812SuonXUuVl6Xp088sWzxie1d5rfQMN3PlR9PbUB8ebvjYPd2EalL
	CDtEJc05Bwk4ycDuHC6LgTmF7B2Xy8/Ic4ZLW+U/qCNfkMzYHO4/s8+hHm5Ozy/hjNmFsWkcXObRs
	L+aoE7EQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtpC4-0000000ETYN-1WEL;
	Tue, 11 Aug 2026 16:19:12 +0000
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtpC0-0000000ETWx-3iM9
	for kexec@lists.infradead.org;
	Tue, 11 Aug 2026 16:19:10 +0000
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-52d37b65926so737611cf.2
        for <kexec@lists.infradead.org>; Tue, 11 Aug 2026 09:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786465147; x=1787069947; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xrrHTlApXY4U6JlaL8nMvnN7qO+xyOd6Xm+nS8KTJxI=;
        b=MYkHk+EHe+pa9kSQMLGqGohlTVLHtZpudX6I/yi1lvBWAwINanZVQDTsqIKSUDbkpA
         kqgJauX4sITjutOkkG1aOB1lE2hFrKkgrbQZ+CxWCdEfwafSsv/t+BMsuyp0JxNiOGK+
         bkMsmpHuufhhUeiHOfe2UVRCkI518+KaD5Qj/htISANi3knFsPCjD+wt7tgukKngptFZ
         3F77Kh7M6ONlfsvpp10t+LSqE+BxrN0Uwt1QiQ4/FnPX3gngi6dh35e10/4lPUD7zImh
         AZ6zw3i+D9TPnWyAm6ivf4M8tm1JQHv7iaEjdUiNsMNbyQrgzH28jWuVTjNiTtKdmzCj
         WBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786465147; x=1787069947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xrrHTlApXY4U6JlaL8nMvnN7qO+xyOd6Xm+nS8KTJxI=;
        b=hPhlzxt76zNcirmx6rC385vpEIlRI9jN3M7rFsJV4khf7kClnhXnSdp2pEMHoI83C2
         kNsAFh9DzHFkYcdRViaYMbDb2XwjTQm3kiK+wY3TVpx+AZ70d5nOmBtj6z/jdCyZRgWH
         WcLjEW9yDRBctMHS/pFVfMqK60qO1TBeVWobZRvPFoc8aOO+ExEM8KfiVjYCR81ju2xs
         wNkfbkAGSSpcHzZQd+D+/TcdoURiiMHCR6SX/DKwzgVSBRKfPzrz4QfZBZuVH9F/B/T9
         BlhcvUDz5Dk58hThCk2/5jKxKBycgdcP0tvuKkbQALVfV+Jfn1w2qrQrxgiz3UQUzIsM
         QCyQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrz7l37r0uybvFK5LB4C239dtmiCNT2XMCUt5aXR5439+MWzpG6y7rl2Ei9qh6gh32zTNIF+A==@lists.infradead.org
X-Gm-Message-State: AOJu0YxnO3uC6zf5C/O6TNJJ2fwb0Zl/mQJd74bxaRjG/c6YIoZCqFyq
	GTq4FzYxZiLftJ7Kzld2AJeuRYUAlx6vgNNpJ5c0GDRXIjQE42wd87fv
X-Gm-Gg: AR+sD10BJ3lIc7KRdONeqO8MZ0iU6Ax7SC4MTPjhgjmDbeXwMA4AjbouKSatD/5xpPa
	wRPsOzjzl8nRlH970tG9E7yOX1uQL3TgzulA+aY1aZ/wvcegDWs5SZal6HH2MbkINJnaVP4WYBt
	fV8Va0LhrgdrB2jxmnw/lVtmumyd1BSkoASp159ai2H021/5AlBrnwPovTmkUpXbZiuI+ZRw16L
	a3M3mtebdEVoNIniIi/SBx4i6D0HEIeFd7MoEFoICm8LPDlU2/N3XbsjnJWT64mHT10AsX1h40D
	uy8LlaHv3MBXKJnznw63On0JGaWN6+xd6uWV9+hVMcIbaQmlBQsvPi2wrW5gcqa3Dlwn2qRlP7k
	Rx54SEVRdJXkUEwEre3ipcukviNEasKAHK5ZF6LWipq0sySsbERJArrlEp7+4C4FYDpOQcx/EsZ
	Kqv5g6YSwjpaNPvH9oFzRBKoydf5lFKTDdsz++lsVUlZCEr6tMy4IM0ed4W1OkaR6CpCRQFw7+F
	SiKgSSt5Mbl16nTrFiHY79kwifi5Xba421xkFsruCnaxeM/XZFL
X-Received: by 2002:a05:622a:4185:b0:527:9603:8123 with SMTP id d75a77b69052e-52d600ad28emr17978671cf.2.1786465147363;
        Tue, 11 Aug 2026 09:19:07 -0700 (PDT)
Received: from CW-D0XG2Q16P7-L.mynetworksettings.com ([2600:4041:5d54:8900:9c8d:ddb9:b1a2:735f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c3bf12fsm2323716d6.38.2026.08.11.09.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 09:19:07 -0700 (PDT)
From: Maxi Saparov <maxi.saparov@gmail.com>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
	Evangelos Petrongonas <epetron@amazon.de>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	sdimitropoulos@coreweave.com,
	Maxi Saparov <masaparov@coreweave.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] kho: do not reserve scratch memory in the kdump kernel
Date: Tue, 11 Aug 2026 12:18:57 -0400
Message-ID: <20260811161857.3096-1-maxi.saparov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803193938.8778-1-maxi.saparov@gmail.com>
References: <20260803193938.8778-1-maxi.saparov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_091908_977850_03451773 
X-CRM114-Status: GOOD (  14.93  )
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

From: Maxi Saparov <masaparov@coreweave.com>

If a kernel with CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT=y (or kho=on)
does not receive a handover FDT, it reserves KHO scratch memory in
kho_reserve_scratch().

The kdump kernel always takes this path. Since commit a6715d7ec472
("kho: skip KHO for crash kernel"), the kernel does not add KHO
metadata to the crash kimage. As a result, the kdump kernel never
receives a handover FDT and always reserves scratch memory.

The kdump kernel boots in the small crashkernel= memory reservation.
On our x86 hosts, the kernel and initramfs make approximately 176 MB
of early reservations. The scratch areas then use approximately
650 MB more of the crashkernel memory. When a large early allocation
fails, the kdump kernel panics:

  bio: can't create integrity buf pool

A kdump kernel has nothing to hand over: its only task is to dump the
memory of the old kernel and reboot. Fix is to disable KHO at the top of
kho_memory_init() so that the kdump kernel does not reserve scratch
memory.

Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Maxi Saparov <masaparov@coreweave.com>
---
v2: Move the kdump check to the top of kho_memory_init() as an early return.
v1: https://lore.kernel.org/all/20260803193938.8778-1-maxi.saparov@gmail.com/

 kernel/liveupdate/kexec_handover.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 6fad9152387a..97729dec6359 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -12,6 +12,7 @@
 
 #include <linux/cleanup.h>
 #include <linux/cma.h>
+#include <linux/crash_dump.h>
 #include <linux/kmemleak.h>
 #include <linux/count_zeros.h>
 #include <linux/kasan.h>
@@ -1631,6 +1632,12 @@ fs_initcall(kho_init);
 
 void __init kho_memory_init(void)
 {
+	if (is_kdump_kernel()) {
+		kho_enable = false;
+		pr_info("disabled in the kdump kernel\n");
+		return;
+	}
+
 	if (kho_in.scratch_phys) {
 		kho_scratch = phys_to_virt(kho_in.scratch_phys);
 

base-commit: 3a0b8fa2eb36afc88b62a95f33f0c77c71fa5ded
-- 
2.55.0



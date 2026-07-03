Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA76C43458
	for <kexec@archiver.kernel.org>; Fri,  3 Jul 2026 16:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3K0E0NM72auILi8yROfk9NB1x+Dtfoc70vwQZ/qZzGo=; b=n+wPeOySVWsVKB53o99UeB2lIW
	pbd/6yOuC7eBbI+CrQcKorf9F/5Fn53pMH6W8OqL/PpFVIEsGAuUUQ0v62Xz80emjJMhs6ACfptQB
	3t8QqxdnYFajy5mH8OnFxofhToWwjCPPNHKAMdW8m+/By9EP2rlqr+aSptluUCj6hrThkmCb4ZPPE
	t55lyzbX2q1RJuzQONEimHjrt5gYHBbRxAWKZcOiTHI3lyGRfKQ01GNiyyhqpPs8UE0n1bkyNads+
	xvS13++FSMKQ3kF9uxi27k+EpAlXj/7MhVyZIGeDy49V1RC7Evj9RRFlGU2n60vKOjr03ErG/Nkfp
	Q2aIlhqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfgfz-00000007YEo-1mIx;
	Fri, 03 Jul 2026 16:23:39 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfgfy-00000007YEh-0YqM
	for kexec@lists.infradead.org;
	Fri, 03 Jul 2026 16:23:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5521C60051;
	Fri,  3 Jul 2026 16:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202831F000E9;
	Fri,  3 Jul 2026 16:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783095817;
	bh=3K0E0NM72auILi8yROfk9NB1x+Dtfoc70vwQZ/qZzGo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=W6mJ2lPSSr7fQVHiCBRxmOm2J3VgKdsiAVnoh7UqlmUbmNBmpn5kG/gX7c3IpNRwq
	 OahDuPuCMT4d5UBEGKkxvYhPwNKDH6vEapW/f8SI1XAlz1GFBJpaiwG2EFfSxfIrPg
	 Ubou/UTUmIoZO4tF95ssEJq5VNddLoXdd//4oH5SslL54bxbJRr/CKQj5vMMdUmXy4
	 MkCnhYeh6xoNKWeezIgkX7pU0qKN49na3sl8jeog3qgpmewy9Kp1k0exXYDCb11k0Z
	 be+/EH8cdmq3KzDsHP1NdAZSIUn/dnXMrpTfSA9C9VKcTn7XmfsZw3xnePWNIzX5Yc
	 4JWCaUqo2Sncg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Thomas Gleixner
 <tglx@kernel.org>,  Ingo Molnar <mingo@redhat.com>,  Dave Hansen
 <dave.hansen@linux.intel.com>,  "H. Peter Anvin" <hpa@zytor.com>,  Pasha
 Tatashin <pasha.tatashin@soleen.com>,  Mike Rapoport <rppt@kernel.org>,
  linux-kernel@vger.kernel.org,  x86@kernel.org,  kexec@lists.infradead.org
Subject: Re: [PATCH v2] x86/setup: do not include kexec_handover.h from
 asm/setup.h
In-Reply-To: <20260703153044.GCakfVpO_egX4B9y_1@fat_crate.local> (Borislav
	Petkov's message of "Fri, 3 Jul 2026 08:30:44 -0700")
References: <20260703143705.2525168-1-pratyush@kernel.org>
	<20260703153044.GCakfVpO_egX4B9y_1@fat_crate.local>
Date: Fri, 03 Jul 2026 18:23:33 +0200
Message-ID: <2vxzjyrcf3ei.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Fri, Jul 03 2026, Borislav Petkov wrote:

> On Fri, Jul 03, 2026 at 04:37:03PM +0200, Pratyush Yadav wrote:
>> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>> 
>> x86 asm/setup.h includes linux/kexec_handover.h. This is because it is
>> used by setup.c and kaslr.c. But this inclusion is problematic. The
>> header is included in many places, so it results in the KHO header being
>> propagated there. Also, the setup header is used by realmode code. If
>> KHO header includes things like mm.h, it causes a big dump of
>> compliation failures.
>
>> Nothing in setup.h uses anything from KHO. Remove the header from
>> setup.h, and directly include it in setup.c. which does use things from
>> KHO. Since kaslr.c is a part of the decompressor, avoid including linux
>> headers there directly. Instead, split out struct kho_scratch, which is
>> the only thing the kaslr.c uses, and move it to
>> include/asm-generic/kexec_handover.h.
>> 
>> This change should also help reduce files recompiled when
>
>> kexec_handover.h changes.
>> 
>> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>> ---
>> 
>> Notes:
>>     Thomas/Ingo/Borislav/Dave, is it okay if we take this patch through the
>
> See my reply to Mike about using the generic-y infrastructure.

To double check I got your point correctly, is this what you mean?

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index ac02aed8757b..22267a83e064 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -32,7 +32,7 @@
 #include <asm/setup.h>	/* For COMMAND_LINE_SIZE */
 #undef _SETUP
 
-#include <asm-generic/kexec_handover.h>
+#include <asm/kexec_handover.h>
 
 extern unsigned long get_cmd_line_ptr(void);
 
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index 078fd2c0d69d..47ef8cb482e3 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -15,3 +15,4 @@ generic-y += fprobe.h
 generic-y += mcs_spinlock.h
 generic-y += mmzone.h
 generic-y += ring_buffer.h
+generic-y += kexec_handover.h

-- 
Regards,
Pratyush Yadav


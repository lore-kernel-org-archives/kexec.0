Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E13CA0FF6
	for <kexec@archiver.kernel.org>; Wed, 27 Aug 2025 01:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2UnMuGasmVuP4gCxURIWl1J6XW6MlBewwbuLMN9pEkc=; b=W4iaa5sf/rSMFke4ZX8RR+h3F4
	ixy9QwjQ/SocJEME58y1J66qVSCLGUDwmEOQwDcAghwWGhuuqjfkyWIB9JCFRs8OI0CrWbCtnlKys
	GoTE+8C41B8PnvyQSovDLkhwaI/GBhWvWJsC0h2PLbJNrZjNdS0pB0ErnA7uupD+N4ljuGNn1aB1A
	LcK7WesKhpNyphKKDMdcc8xU1sGCArfqMjLlIP26T9+VczBc9QcjKb45oWyiY/OQyWKJVKJ4abgyn
	4NMzDHOg1+QnyaYhJD/hTutt8mSeIKWMwDnoZhoi6KwjiEHmkk9Ks/PznZq9Cnj5eKkGVJGPki7nG
	URILjQdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ur4dg-0000000DUkg-2UYq;
	Wed, 27 Aug 2025 01:07:48 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ur4dc-0000000DUkA-39Va;
	Wed, 27 Aug 2025 01:07:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 287206022A;
	Wed, 27 Aug 2025 01:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B4DC113CF;
	Wed, 27 Aug 2025 01:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1756256863;
	bh=2bj+qTAYnr7Hk8Btw7x0K9XP+Ek85nue9lNeuKCH1HY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iBJB/cjGU37/tTE692qCZ8U05f2lTBZW0U8RP6oJvMzb76cCO85ohsYB6JsggiF8H
	 5hInQqxJuvLhIarrbtnM4qEXrqJf6z4ux2lOsdbTXch6dyP2cezFlxztXBW9VwOa4P
	 l540ZXGp5MSsXXaP3IG1fdjk1GmxiY0ymsnNA5uc=
Date: Tue, 26 Aug 2025 18:07:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Breno Leitao <leitao@debian.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bhe@redhat.com, oxu@redhat.com, berrange@redhat.com, kernel-team@meta.com,
 Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64: kexec: Initialize kexec_buf struct in
 image_load()
Message-Id: <20250826180742.f2471131255ec1c43683ea07@linux-foundation.org>
In-Reply-To: <20250826-akpm-v1-1-3c831f0e3799@debian.org>
References: <20250826-akpm-v1-1-3c831f0e3799@debian.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 26 Aug 2025 05:08:51 -0700 Breno Leitao <leitao@debian.org> wrote:

> The kexec_buf structure was previously declared without initialization
> in image_load(). This led to a UBSAN warning when the structure was
> expanded and uninitialized fields were accessed [1].
> 
> Zero-initializing kexec_buf at declaration ensures all fields are
> cleanly set, preventing future instances of uninitialized memory being
> used.
> 
> Andrew Morton suggested that this function is only called 3x a week[2],
> thus, the memset() cost is inexpressive.
> 

Thanks, I queued this as a replacement for your eralier "kexec/arm64:
initialize the random field of kbuf to zero in the image loader".  I
added cc:stable, a mention of the UBSAN failure and I added thie Fixes:



From: Breno Leitao <leitao@debian.org>
Subject: arm64: kexec: Initialize kexec_buf struct in image_load()
Date: Tue, 26 Aug 2025 05:08:51 -0700

The kexec_buf structure was previously declared without initialization in
image_load().  This led to a UBSAN warning when the structure was expanded
and uninitialized fields were accessed [1].

Zero-initializing kexec_buf at declaration ensures all fields are cleanly
set, preventing future instances of uninitialized memory being used.

Fixes this UBSAN warning:

  [   32.362488] UBSAN: invalid-load in ./include/linux/kexec.h:210:10
  [   32.362649] load of value 252 is not a valid value for type '_Bool'

Andrew Morton suggested that this function is only called 3x a week[2],
thus, the memset() cost is inexpensive.

Link: https://lore.kernel.org/all/oninomspajhxp4omtdapxnckxydbk2nzmrix7rggmpukpnzadw@c67o7njgdgm3/ [1]
Link: https://lore.kernel.org/all/20250825180531.94bfb86a26a43127c0a1296f@linux-foundation.org/ [2]
Link: https://lkml.kernel.org/r/20250826-akpm-v1-1-3c831f0e3799@debian.org
Fixes: bf454ec31add ("kexec_file: allow to place kexec_buf randomly")
Signed-off-by: Breno Leitao <leitao@debian.org>
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Coiby Xu <coxu@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Kairui Song <ryncsn@gmail.com>
Cc: Liu Pingfan <kernelfans@gmail.com>
Cc: Milan Broz <gmazyland@gmail.com>
Cc: Ondrej Kozina <okozina@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/arm64/kernel/kexec_image.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/kernel/kexec_image.c~arm64-kexec-initialize-kexec_buf-struct-in-image_load
+++ a/arch/arm64/kernel/kexec_image.c
@@ -41,7 +41,7 @@ static void *image_load(struct kimage *i
 	struct arm64_image_header *h;
 	u64 flags, value;
 	bool be_image, be_kernel;
-	struct kexec_buf kbuf;
+	struct kexec_buf kbuf = {};
 	unsigned long text_offset, kernel_segment_number;
 	struct kexec_segment *kernel_segment;
 	int ret;
_



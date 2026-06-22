Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0714CD98F2
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 13:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5GIZ0EvmyeofZt+KuGK8sX+zOx16/K5vzQf48c5oMdk=; b=mfv3jUrybci06G2K+JoC1gj3oJ
	HfJAdafjNjt3+V+XKQnIJTQQISZguFmmzl9jcfRpWujQbD38VXAWskEHz/Ahnr4DCZTfi087GqFar
	z0e2pxFT/hnudKZ0eGW00UMSUrF2pTR/qo4h3pW3dOFu0KGc4p7QvXjwc27jK2E5t4EthOEl/vdzR
	575zdbCxK19MYvrYE3aGrHsL7H80Un+5GpAG3D6KhG2HE9S2Ngha0pesL9U3sgjf6WwQivniBcPzV
	uqCyybbA7fb3uIzwS0RZWpT1nOP7l1nJHVip2wK5CJyTXUVo6KnViUvKdsuHMn4hp5qXSLJ/OLyaI
	TuUV+s8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbf2e-0000000529V-2bL1;
	Mon, 22 Jun 2026 13:50:24 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbf2a-0000000529D-2UCH
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 13:50:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AEA67601F5;
	Mon, 22 Jun 2026 13:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F3A1F00A3A;
	Mon, 22 Jun 2026 13:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782136219;
	bh=5GIZ0EvmyeofZt+KuGK8sX+zOx16/K5vzQf48c5oMdk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=opzebwG3oAXni6Y5t9ueUfnK4xbyCh7wU4VKChfS6E52l7lSaGYh8V7YDMvZCeTBE
	 C47DgCbxkmux999t+LrgA/WGUI5EvxOGLQ/t12sOqHyPCnGUrarWgFpVyDVAWzG0FJ
	 xR6b1ITL+oieMTR7yHVOQgnvA2aVeIW+ZuIJcIGY8+HQlN8uP3S0+CPQbWrmDxgS+Y
	 Be2L9kC2bYE+APN1dk6d8HdCY/JNWjJsDbVMaWwCMCwGZpcmByx32WbFAttucYNlJQ
	 WfdWBFwrAgb1hL8D9+/ptzG70B7iVTkCeCmeG57r7BXTqees/sG8zKppymbVZWbEuh
	 FG51W7hq+60EQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Baoquan He
 <baoquan.he@linux.dev>,  Mike Rapoport <rppt@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Pratyush Yadav <pratyush@kernel.org>,
  kexec@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 header file
In-Reply-To: <20260619160654.75980-1-thuth@redhat.com> (Thomas Huth's message
	of "Fri, 19 Jun 2026 18:06:54 +0200")
References: <20260619160654.75980-1-thuth@redhat.com>
Date: Mon, 22 Jun 2026 15:50:16 +0200
Message-ID: <2vxzik7aofaf.fsf@kernel.org>
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

On Fri, Jun 19 2026, Thomas Huth wrote:

> From: Thomas Huth <thuth@redhat.com>
>
> While the GCC and Clang compilers already define __ASSEMBLER__
> automatically when compiling assembly code, __ASSEMBLY__ is a
> macro that only gets defined by the Makefiles in the kernel.
> This can be very confusing when switching between userspace
> and kernelspace coding, or when dealing with uapi headers that
> rather should use __ASSEMBLER__ instead. So let's standardize now
> on the __ASSEMBLER__ macro that is provided by the compilers.

Sounds reasonable.

Acked-by: Pratyush Yadav <pratyush@kernel.org>

>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
[...]

-- 
Regards,
Pratyush Yadav


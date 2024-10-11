Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6B0CFD2E0
	for <kexec@archiver.kernel.org>; Fri, 11 Oct 2024 08:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Died9nHE3n23EzYwzlzCl4acU4hCg8gVjIJ5Y4CiMMs=; b=tlsid7mQfG49Lg
	T0TndTid1CeTvaxHnmApdE0pGch2NwfozijJnt/HXH9QAg/rMMM/paY02LajwwXrM/ShxouPn4ujO
	rhd4TdrAmCpE9CaQs7ZdpEkuWjjLrcN1ECMpxSm66LQDr0wCKw6SqkWzO2b3yg5pS137gl3uQgcNg
	+CWbhtJIwhEYLlPJNa1iAaQCTgFKAY91oV+vG2illTS6D1frYOx5i0kHHI5yfabArhp1TftlVjcnj
	pzFJvIaC3vnjAn1xjE2M1HBotAvrVlvfFhPdyHsDieqsV7BuwwEHl17KUAg8uBtp3hAiB6OcoWHUJ
	av77q5GxtdHPj9ms4NBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szBGq-0000000Firi-1quN;
	Fri, 11 Oct 2024 08:45:12 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szBFr-0000000FiUr-33ax
	for kexec@lists.infradead.org;
	Fri, 11 Oct 2024 08:44:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 17FD5A45227;
	Fri, 11 Oct 2024 08:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4860C4CEC3;
	Fri, 11 Oct 2024 08:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728636250;
	bh=NX1Qexf6vfsbVvbEuZ2b9TVNhqODkwQOR3tP+f2t4sU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nIRbq6joBIPkus2l3VO7l9rO9J874Df8N2Vw+j3pdVvWRB9Dgq16lqjvH1//g/X6n
	 kP/95doGRwcVYwJcyYV3gX6fpa2gXP7vqOuZ738Tkubc3NBK744NxoCozBTulcrHmm
	 XGKRH5bFMMSbLKWxTGtXxXM19i42cJWYTDok/Qd+2FTWDox6JXG6DqW4dXPgNgeonq
	 FIYKLsVFPhunnqjAxtoo2wVZVILZQbbvc/okqRpRpMeyYm0TL5ufVU3whlxkwQiLdQ
	 g57/jpDz/w3rrMVToWbrO6Me4fUC5sHzYxNb2aUPNdy3vep44b/FzJ/a8awTP4R1Sy
	 ioowdpFsZV11A==
Date: Fri, 11 Oct 2024 09:44:06 +0100
From: Simon Horman <horms@kernel.org>
To: Pingfan Liu <piliu@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	kexec@lists.infradead.org
Subject: Re: [PATCH 2/3] kexec: Introduce UKI image parser
Message-ID: <20241011084406.GB66815@kernel.org>
References: <20241008115408.21944-1-piliu@redhat.com>
 <20241008115408.21944-3-piliu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241008115408.21944-3-piliu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_014411_859970_34593ABC 
X-CRM114-Status: GOOD (  16.06  )
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

On Tue, Oct 08, 2024 at 07:54:02PM +0800, Pingfan Liu wrote:
> A UKI image is a PE file that consists of several sections, typically
> including: .text, .data, .linux, .initrd, .cmdline, and others.
> 
> The kernel image is stored in the .linux section, which is one of the
> formats currently recognized by kexec-tools. Therefore, the UKI parser
> can be used to strip away the UKI layer, allowing the other parser to
> process the kernel image.
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: kexec@lists.infradead.org
> ---
>  include/pe.h      | 104 +++++++++++++++++++++++++++++++++++++++
>  kexec/Makefile    |   1 +
>  kexec/kexec-uki.c | 122 ++++++++++++++++++++++++++++++++++++++++++++++
>  kexec/kexec.h     |   4 ++
>  4 files changed, 231 insertions(+)
>  create mode 100644 include/pe.h
>  create mode 100644 kexec/kexec-uki.c

Hi Pingfan Liu,

I think you need to squash the following into this patch
so that pe.h is included in distribution tarballs.

You should be able to see the problem by running: make distcheck.

diff --git a/include/Makefile b/include/Makefile
index cd88a26b1476..6a3e8541c36d 100644
--- a/include/Makefile
+++ b/include/Makefile
@@ -8,6 +8,7 @@ dist += include/Makefile		\
 	include/x86/mb_header.h		\
 	include/x86/multiboot2.h	\
 	include/elf.h			\
+	include/pe.h			\
 	include/image.h			\
 	include/unused.h		\
 	include/boot/linuxbios_tables.h	\

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

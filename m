Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31135C77B73
	for <kexec@archiver.kernel.org>; Mon, 22 May 2023 04:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fcA3s5ZU8uCHXafYnAGRVlAaSzatOuz2mKl6sWOXGx4=; b=SQakiXwyZCHZs/
	DbckukE9tXBNtTLKKc6ZDUcGxxv7wZCaUm5X559VdhXQCQia6lmxmTHtQdYgPb1PuAqBHAIQmcCZD
	cxcs6hdwh942iZ1IGD1IJf3RxHLWOO+LprKcVr1V1dmY0oEfvBrC1UEC0SZROhVztjh08LtMBS7ns
	2l/G5Q25q/9rFhLyiUrnmCaZ992+97+IsVzuNGsSw2tN4psW0JE9gpx+8wEZW1IWYV5KT3OmYRKi8
	UJKiS9SjYbQcwCSZJFm0F/i1nqQUmmfXooU6xuOD2qG+UXxNk3FST5WiE4ERo3M0QNmZOzpX3RdbL
	ZSdAmEJ0DeqkwxeOw80Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q0wyu-005HUU-1l;
	Mon, 22 May 2023 04:17:12 +0000
Received: from gandalf.ozlabs.org ([150.107.74.76])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q0wyr-005HTb-1t;
	Mon, 22 May 2023 04:17:11 +0000
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4QPkft3zztz4x4B;
	Mon, 22 May 2023 14:16:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1684729020;
	bh=AVLVOohCWlNWsFlZp/IjXPMalhLXANn4M3eXvq7tzo4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pgufz1uRbk/l6Rkj1iL6mZYqH3IRjcKojpyTlmnAqC5gBLrUBoE9FFstCMUjKSjQa
	 uv9vN+rApxtjlJ8i1zW14wzuxXSWmzFWQpJmE+6E5yQ16RHo80JIMVZFCkzEud3Rsd
	 crFSqYweTi2+OSAyQrKmkoPy6AY1LlMn3p4HCzfgB27T+V6UTyE7OgP+ZngP7e0K/g
	 xrERP69ypwM37e6nnw4lM8nQO1q9vvBO0V6MtmIgeKMJxW1qB5hv4V1bHGEHIl5WZr
	 GLi3ASKQsCuuTsN3XYaBrB9DgTnDKaHMkGPu9JFhl45o+kil82t9uN8FJoBA2XwUIK
	 n8c477C2qGY9A==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ricardo Ribalda <ribalda@chromium.org>, Eric Biederman
 <ebiederm@xmission.com>, Philipp Rudo <prudo@linux.vnet.ibm.com>, Dave
 Young <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Nathan Chancellor
 <nathan@kernel.org>, Tom Rix <trix@redhat.com>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>
Cc: Baoquan He <bhe@redhat.com>, Philipp Rudo <prudo@redhat.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ross Zwisler
 <zwisler@google.com>, Steven Rostedt <rostedt@goodmis.org>, Simon Horman
 <horms@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 llvm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, Ricardo Ribalda <ribalda@chromium.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH v7 3/4] powerpc/purgatory: Remove PGO flags
In-Reply-To: <20230321-kexec_clang16-v7-3-b05c520b7296@chromium.org>
References: <20230321-kexec_clang16-v7-0-b05c520b7296@chromium.org>
 <20230321-kexec_clang16-v7-3-b05c520b7296@chromium.org>
Date: Mon, 22 May 2023 14:16:54 +1000
Message-ID: <87h6s59f0p.fsf@mail.lhotse>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230521_211709_793295_5F032948 
X-CRM114-Status: UNSURE (   8.13  )
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

Ricardo Ribalda <ribalda@chromium.org> writes:
> If profile-guided optimization is enabled, the purgatory ends up with
> multiple .text sections.
> This is not supported by kexec and crashes the system.
>
> Cc: stable@vger.kernel.org
> Fixes: 930457057abe ("kernel/kexec_file.c: split up __kexec_load_puragory")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  arch/powerpc/purgatory/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

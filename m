Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F7F606A320
	for <kexec@archiver.kernel.org>; Sun, 22 Nov 2026 03:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lSPemOhQ;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T1gEkbx6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:Date:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NieCLCvG+gDw8VjVQsEmj+Xb3Nuvde1xSdj6TYYBmIA=; b=lSPemOhQ9pNz6Qmk0skFcEeaBV
	ZHm60FpqPoPQcbweF8iCq28ooChZYphKVd7OmPJ3bpWI3Z7l/1BrMk3HRNidefGmUx/qseQ5IQcEU
	KEdUAfxSqj1RukuDEpv4km2M6HxleoPtMeIHLRDVlfo7qB8EQEq/NrWio0X4qMvdBjmEmciutLw6+
	evhwPW31HrkoBYCZtPuUVJVMAfMYRn+nLGbCl60pIwXuhsq8hexnoe8ox9kLPgz3Zjta6cJR/YfCZ
	gAqunb4fMqRSac4NeJVlHJsgw1qVdGxdeUpz/TN72fBq68PDzeaynA4bWDG6u6OSk0tZaR6c1Z+7t
	xHi0AXmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUxsw-00000000hOY-1sN0;
	Sun, 22 Nov 2026 03:04:58 +0000
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUxsq-00000000hNg-3Xsz
	for kexec@lists.infradead.org;
	Sun, 22 Nov 2026 03:04:54 +0000
Received: by mail-dy1-x1334.google.com with SMTP id 5a478bee46e88-380c28f9e35so3166916eec.1
        for <kexec@lists.infradead.org>; Sat, 21 Nov 2026 19:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795316691; x=1795921491; darn=lists.infradead.org;
        h=content-type:mime-version:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NieCLCvG+gDw8VjVQsEmj+Xb3Nuvde1xSdj6TYYBmIA=;
        b=T1gEkbx6FcFYvQ7HLPuhM7Rf/1/LclKLeScZTCE/WTEnjj7zX+b1zruKUND7Eht8yA
         TTo4qIfVVoxCExaeLGnrGdjretO2JuimpPPKQ2V0BUvWxmLw87NnpBryXFS/9wZKKQDc
         BdYJxbbk1TWU1PIA/n7yKRAwGdWai2PWQGz91JdvI5rVsIwaKECGvsk+lt4x8WCOBiRj
         axYU2ipt7Qwb2d70RGFLMrd649ymAV+ucaKhxYS2fQPB3TxwZ13x2KerkoSLVerGLQKB
         kAhT6IOn4+U65meyKuAeCD9mXgRCabnJ29FMZgp8p7dWflnyIvSyiabqHIAnD3luBU0N
         iwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795316691; x=1795921491;
        h=content-type:mime-version:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NieCLCvG+gDw8VjVQsEmj+Xb3Nuvde1xSdj6TYYBmIA=;
        b=apfQsQBq+SJ9QviiDv3af80URHwHBajG6ATRmdnRqIvk1GOwYLwUIhEXIB+pizZtLQ
         stjUmJJJ9Ma3GUfCy30QWGe3p6oX6NfJ2J+aL34paw+YV0Jjx+A4DJg+oZQ9M4PWkxG3
         r//9qrr4LYwRUsbKnDRCk6FSDhHlc/EiurFtiqtZRLSNjt3S+3Of8PbYIYZ4EmycS23j
         X69DRXiwxY6jhAezw43X1mpHA8WtqSABMbJWxdsP0a2VUN4SaROhadCLjPq53V84vYXw
         mfJfuOGBCeCSWT59PH3ow4cgkhhO23jLp0Sgd/YKf5Q4V4HxtTGEepaEas2rCeJiI6hk
         Wn2w==
X-Forwarded-Encrypted: i=1; AL+hErEh4tUqC8x0T+5IdoeQiHMmrksiltEjxo8dn9qMI2vV2AmR4SrMszRuZiCTLEVdO+lVGuSx8g==@lists.infradead.org
X-Gm-Message-State: APuU4Z9JSi0bGAwKz8Ec+CSFPkyaYN4Y44SQSCv/qoNTtqext6wsjadJ
	/jAJyestjlMZbssJn37WKJqTmZ4t4KXC1ZI1ie5H/egzfaZ6tr+Ly/hP
X-Gm-Gg: AZFdTZdE+7DiI119NJgwaOa18pcDY+e9IXSAGWNCemHyfblwVk7QjKd5cR+s/8yiDRg
	SZgAsLm94xFA+QX7rZZ0uFr9esyLTdlZNlD7EDyGPmWvWM0m34gJVlw63pqRD3dpEYtBLx/2Xb4
	niwc7/ZTlKPII48VZQmlMrCgbH4G4THnHQHfHG4fNw6vBMH4chbBMjXq5i+th4ArG976yxvlTl/
	MoSXAvjooMJHiFXXwM7iV/zA77mPkkP4JghYy+DS8Ytll+J+8ySVn0WTfxMlFk9Z5cqzeASlatL
	MfvMABffDTnKsIZDbxDnNFzKxt7N0Ws8bKHciaWkydQxEVK+WjUKWPQJPsJeJhsGopyPTHxvAfS
	/0kTqCb3Djid2cObMOrwktaGciqyEiIDPGbHGCcBd6O9S3awmnqTfRQMC6zmjWjkwikxHTLs5Gw
	Rtpbfp+HFYA2bBzKykcPUexNhlqyi6AMKX9VadyjutqMrPYmvce+UNux0F4CIRKOa1VHIWt3821
	ZhTwmI0msf139UUtKpMgOrlO4GDJB54vcWiI4eGhumBZ0SvJtj5mrZbfl5ZvBpYlqnmE46AI0T1
	fu8ckB15P5oNeAwfE9zWV/9hjiYjMwh7Ca6/6kYCcbnPQV62
X-Received: by 2002:a05:7300:50fa:b0:383:9f52:e54d with SMTP id 5a478bee46e88-3856ff52e83mr8869235eec.8.1795316691531;
        Sat, 21 Nov 2026 19:04:51 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567da4f85sm24302948eec.27.2026.11.21.19.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 19:04:50 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <baoquan.he@linux.dev>, Borislav Petkov <bp@alien8.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, 
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Paul Walmsley <pjw@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Rich Felker <dalias@libc.org>, 
	Russell King <linux@armlinux.org.uk>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, x86@kernel.org
Cc: Alexandre Ghiti <alex@ghiti.fr>, Christian Borntraeger <borntraeger@linux.ibm.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Cong Wang <cwang@multikernel.io>, Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev
Subject: Re: [PATCH 2/2] arch, kexec: declare kexec and crash capabilities in Kconfig.kexec
In-Reply-To: <20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org>
Date: Sun, 22 Nov 2026 08:33:10 +0530
Message-ID: <wlq5k1ox.ritesh.list@gmail.com>
References: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org> <20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261121_190452_886391_981B0339 
X-CRM114-Status: UNSURE (   9.51  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

"Mike Rapoport (Microsoft)" <rppt@kernel.org> writes:

> The options that let an architecture opt in to kexec and crash dump
> features, like ARCH_SUPPORTS_KEXEC or ARCH_SUPPORTS_CRASH_DUMP, are
> defined in each architecture's Kconfig as def_bool, and most of them are
> copied over several architectures.
>
> Declare these options once in kernel/Kconfig.kexec next to the options
> that depend on them, similarly to how mm/Kconfig does it, and make the
> architectures select them instead.
>
> Selection conditions are preserved, so there is no functional change.
>
> Acked-by: Baoquan He <baoquan.he@linux.dev>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

No function change observed in this patch (as described in the commit msg).

LGTM, feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com> #powerpc



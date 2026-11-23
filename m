Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCCB606A31A
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 19:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=spqGNaDi;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=LKWG0xYA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=bht87HU90ydQuqNwMWxnyUlGx5v3MiB0Rcrd/VnWTho=; b=spqGNaDimPIKvUOJMTgvYuTcjb
	eSI4l5vbRlPDT0vwQan4EKqcL6xGqzvLDPmIbWosg4JGPo940OadW9QqH+QWco7hmeeIomof1Vo2s
	bFNyNSvERS4zohWRirypeWplsKli8urwOdeUbnmYt51Hrgs2H05/tEuSZamOPBeKR2Wlwg29+xa3n
	Tw2LqlAiiEB8Ma7KEQKBjIl5OApqBdLIxSewfdfpP3hFcmCLbe59kLbbryL7eFpHEcMECDCuA5M+h
	9pexGPfHRXMCFBV2VaMxZkxJRloWRI2zN6myhNuvOu7s/zHtxnrw4HOi7iwNPBQGzpeRsOR8UYKG/
	r5LEPiFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVZWX-00000004dLN-1zbq;
	Mon, 23 Nov 2026 19:16:21 +0000
Received: from outgoing2021.csail.mit.edu ([128.30.2.78])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVZWT-00000004dKX-2R5C;
	Mon, 23 Nov 2026 19:16:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bht87HU90ydQuqNwMWxnyUlGx5v3MiB0Rcrd/VnWTho=; t=1795461377; x=1796325377; 
	b=LKWG0xYAvifu27tUgnMFc3PsV/Prd9r5YGTuhrOe78/LT0r/W5Pa2EGCc+j+MClXOuc4s7kS7XQ
	Ztcx2rGG+JqPvJjzwTCxFLrnIxunyiUZisfWOa1t9b25n0dYSdtEh7G8+cYcvwW5uSZhaJxJSxck8
	L8uBIGR3/3yvNOjrUhj2S3oYnLS+ruyg4fKatCeW4fX1BfCJ3jM8/8Qw5taKvw5wMsslaY2eOl8ua
	3eYAbyLZOOzQNs0Cy8MFCWdm7nmqFSzG9j/4EJaQR7lvRMGGdYeTE8uV98shlJzt6vqLbWzh01nFj
	Xw9xXNta1iIDt81Kw+mx8pCiiKURuT2FXGhA==;
Received: from [49.207.211.146] (helo=csail.mit.edu)
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <srivatsa@csail.mit.edu>)
	id 1xVZVX-006Xqr-OR;
	Mon, 23 Nov 2026 14:15:20 -0500
Date: Tue, 24 Nov 2026 00:45:01 +0530
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>, Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Paul Walmsley <pjw@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, Rich Felker <dalias@libc.org>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>, x86@kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Cong Wang <cwang@multikernel.io>,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	WANG Xuerui <kernel@xen0n.name>, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev
Subject: Re: [PATCH 1/2] MAINTAINERS: add kernel/Kconfig.kexec to KEXEC
Message-ID: <awSQtauit5QObOPQ@csail.mit.edu>
References: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org>
 <20261119-arch-kconfig-v1-1-37c276fe4d26@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119-arch-kconfig-v1-1-37c276fe4d26@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_111617_786978_E4D45E81 
X-CRM114-Status: GOOD (  13.09  )
X-Spam-Score: -1.9 (-)
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 08:16:57AM +0200, Mike Rapoport (Microsoft) wrote:
> kernel/Kconfig.kexec is not matched by the KEXEC entry, so
> get_maintainer.pl does not report kexec maintainers for changes in that
> file.
> 
> Add it to the KEXEC entry.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Srivatsa S. Bhat (Microsoft) <srivatsa@csail.mit.edu>

In the spirit of finding any other misses in listing out relevant
files under the kexec and crash entries in MAINTAINERS, I found a few
other files that need to be added (unrelated to the Kconfig.kexec
which is the focus of your current patchset). I'm planning to send
a follow-up series to address that.

Regards,
Srivatsa


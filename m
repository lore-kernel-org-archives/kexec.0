Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9971D606A326
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 07:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cV87/Pzl;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jRpAWJeD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=hNd5MCBb+RwQDRLrwFjdA5miwBKz7JlHYmdVmb0QLqo=; b=cV87/PzlPg5jGUdbLnjxKA/GEJ
	utNyIHnZ/yS3LzGavbAvf2Hr6sE35U2FBCV4B+pc7zIoGrfm1zGdrzkccTh0RJwiFxON/14hIrabm
	loNF9THo2IQmmVtFWmpE62mS3ctkXoFSfT/IXTmu5U6InnuzNgHNdRNfdBQAsbwNzEltADwvaK4fN
	svKC9LISVhPV9iy8U5dSbAO2MEdTnDdrgkSGYSZZMgIiUyHQ3JlDKr9w9Rpqgb1NFj10DwOfCXlYL
	MSzk+e/hXlynueo4Jfb6JJ8T7YyFPioDDv5GFTLIOF2btshuniI6pR6W2FoYd/oj0fpCEi/DosOpy
	+XBplr/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTwm4-0000000B68K-151S;
	Thu, 19 Nov 2026 07:41:40 +0000
Received: from out-95.mta0.migadu.com ([2001:41d0:1004:224b::5f] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTwlz-0000000B66Q-1en9
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 07:41:39 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=6tO+X4PnRnD+Jk0uYi9e+cJ5+jxuZiQPrphEOsBPyUs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795074090; v=1; x=1795678890;
 b=jRpAWJeDfhzRjp0tMgYsPxG27OVP/tOWcJ/LQhjQ73YyguUVzBJIk9e6igo5ThSrN/dX9FMW
 bZra7IUn8I/rAqXJ0NlITYqlsau1cJMj9jUX1QQPXNjf97NVYMKnp1K1+v+f+gbq9xnGbaFV9/k
 QXdNQC1HwUPojy675ONU9hn0=
X-Envelope-To: kexec@lists.infradead.org
Received: by mta11.migadu.com with ESMTPS id f0d3d04c8dc3375f;
	Thu, 19 Nov 2026 07:41:30 +0000
X-Mizu-Trace-ID: f0d3d04c8dc3375f
X-Migadu-Flow: FLOW_OUT
Date: Thu, 19 Nov 2026 15:41:24 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
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
Message-ID: <av6oJBDv2fAaWSog@fedora>
References: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org>
 <20261119-arch-kconfig-v1-1-37c276fe4d26@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119-arch-kconfig-v1-1-37c276fe4d26@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_234135_865902_171CA7A7 
X-CRM114-Status: GOOD (  15.01  )
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
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 at 08:16am, Mike Rapoport (Microsoft) wrote:
> kernel/Kconfig.kexec is not matched by the KEXEC entry, so
> get_maintainer.pl does not report kexec maintainers for changes in that
> file.
> 
> Add it to the KEXEC entry.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Baoquan He <baoquan.he@linux.dev>

> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d738990161bd0..c61a1f0ad330e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14782,6 +14782,7 @@ W:	http://kernel.org/pub/linux/utils/kernel/kexec/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
>  F:	include/linux/kexec.h
>  F:	include/uapi/linux/kexec.h
> +F:	kernel/Kconfig.kexec
>  F:	kernel/kexec*
>  
>  KEXEC HANDOVER (KHO)
> 
> -- 
> 2.53.0
> 


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EBFC4345F
	for <kexec@archiver.kernel.org>; Sun, 28 Apr 2024 17:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qj2R7ZTrRugIULcjZAhSApqgEOILdNbMwDBQeJQympw=; b=XPJSe6uk3OEF+H
	Ye4Vkz4J6B8IuWaSAXZV1t1i0DFEkvcAocJ1BNl4T2jNRY0hS0aZXffw9D7p0Tf8cvA75kykAW0Yd
	wUFUqF8zdfRqYHsi0CTXZyHgz8QAS3G4rsXsr8QXc2kAhQW5S5jU9Sl41jkpP3KQKEQuZAPxvU8Wz
	7lUS4Qn5qXS5RBQHGJ+VK/hMK6m6oxqmMCFxfdeOfmIIsT1aEgTVoO0NRuesyt0i1HFGbtY6uh18G
	G3YEfQC4eV1W/Ap6miTruEo+tj3jwzQx9qF7+y3wnRtvG5b4IZjY6qLBak8+alS7GlKhM4yu7Bczw
	Cg6FSWAZtwsexBDCO9QA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s18IV-00000000Oly-0J31;
	Sun, 28 Apr 2024 17:26:43 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s18IR-00000000Ok7-0gSY
	for kexec@lists.infradead.org;
	Sun, 28 Apr 2024 17:26:42 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7CF0B40E0187;
	Sun, 28 Apr 2024 17:26:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DS8HxuSXsenB; Sun, 28 Apr 2024 17:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714325191; bh=AF8W5OpNeob6gkJBdYGpZUOpvF721UDovoNC7CvPOHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RUQiBFDe6dDNPHrCSly4pEgY8TtrM8DbCwhUr+mxNl3Lm8ocQxCYt9/mYcR5YHQx2
	 uvweoaTlWfeD3iIEAGsvWR2pBXOfQczb237pnxPwBSHT/PkDiQUxSvbHgdKEoIa/wN
	 q3k3VxIhmUboThxtYAcJCh9gBqStlMXe/EdEX5THho6000MBHxZhGBt5nJu8KNFAC1
	 UY+VEWkQeMVJBvujL8td3illvcSw81wjz+5DUM/YgtnzVLUT6Usrbd+ljDGCY3Kvi1
	 QBx/KCEFBHMsBGVUM36n9UbNV9/ToBMGVMvw977DDG/Ld+ZMP4uqATXfVv3Oo0VzwT
	 IYmsFSkyMgqFVcg2xgPYM7lx6+2FD+Ia7RARnO/uqb+jlr75G904vEHbY23Y68AG+o
	 KdCtX3Pb74t+ofbOFnPuLLdNss/oYGrDuDZyNGqd5EaXz4zMWRLThSnhxMHVdkZzvE
	 ZYuPSB6VnJteiNT4QE2RtrMmsgDVFtaatl2Bxv9+Ir9wTbg5C2i+uwLkOzZdEH5oFJ
	 5fvE/YWQ1BMsRycDcbKcBFhhd9j7VobrUTkvEX551lrDD+q4k4aa820sX2I6AvuT1K
	 Dab7a/zyCk+Oh5NJIPuAdehS3vflkdDSg7Q0OWkuklZ1LFSxOrPEMeuCPuD2mdTo0W
	 azDtrM/cYn0ny3rwBRhZb0k8=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 28CB040E0205;
	Sun, 28 Apr 2024 17:26:04 +0000 (UTC)
Date: Sun, 28 Apr 2024 19:25:57 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
	Tao Liu <ltao@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCHv10 06/18] x86/mm: Make
 x86_platform.guest.enc_status_change_*() return errno
Message-ID: <20240428172557.GLZi6GpTaSBj-DphCL@fat_crate.local>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-7-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240409113010.465412-7-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240428_102639_371004_F98786B7 
X-CRM114-Status: GOOD (  12.26  )
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

On Tue, Apr 09, 2024 at 02:29:58PM +0300, Kirill A. Shutemov wrote:
> TDX is going to have more than one reason to fail
> enc_status_change_prepare().
> 
> Change the callback to return errno instead of assuming -EIO;
> enc_status_change_finish() changed too to keep the interface symmetric.

"Change enc_status_change_finish() too... "

"Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behaviour."

You should know this by now...

> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Tested-by: Tao Liu <ltao@redhat.com>
> ---
>  arch/x86/coco/tdx/tdx.c         | 20 +++++++++++---------
>  arch/x86/hyperv/ivm.c           | 22 ++++++++++------------
>  arch/x86/include/asm/x86_init.h |  4 ++--
>  arch/x86/kernel/x86_init.c      |  4 ++--
>  arch/x86/mm/mem_encrypt_amd.c   |  8 ++++----
>  arch/x86/mm/pat/set_memory.c    |  8 +++++---
>  6 files changed, 34 insertions(+), 32 deletions(-)

Another thing you should long know by now: get_maintainer.pl. You do
know that when you send a patch which touches multiple different
"places", you run it through get_maintainer.pl to get some hints as to
who to CC, right?

Because you're touching HyperV code and yet none of the HyperV folks are
CCed.

Do I need to give you the spiel I give to kernel newbies? :)

Lemme Cc them for you now.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

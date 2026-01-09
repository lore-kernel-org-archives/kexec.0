Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B9CD26D9B
	for <kexec@archiver.kernel.org>; Fri,  9 Jan 2026 20:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0G8ZpIB7PKKPCBS89cczhj+k44r6aydNZxzyLOosVqg=; b=ojs7+G+mxkbsdOlX+FPe2b5tFT
	kHEt8VcvwdelRVIXulL5at2DNeiustsR351+ExC5DERij3j1EUI+GGWOZLu0+itat6sqLVh02JIcR
	zbbOjN9U4lmidDrgaZllHPgf1kH/ivt0Is4qWX3Af+Gd1txYxaiKtN4Joe3f23fR8cVBlXy9ti6vz
	WV6WbHVFaGEh25G4wjtF6g/3s199to/O4L0pX+QKi1Y+eww4hXcGEzZa6xZo4K4X52ZfkavndXB7Q
	+RnQPSGYy19qQWEyk0fJkwOJM55Xl/04iYbGUC4VEwVWcShFR0VCWNUAh1lOrW+LyVopgbRQHvFho
	jgpHlA/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veIqA-00000002yxA-2b1n;
	Fri, 09 Jan 2026 20:12:10 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veIq7-00000002ywo-0ldd
	for kexec@lists.infradead.org;
	Fri, 09 Jan 2026 20:12:08 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F314940E01BB;
	Fri,  9 Jan 2026 20:12:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sFMh_cNHjU4m; Fri,  9 Jan 2026 20:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1767989518; bh=0G8ZpIB7PKKPCBS89cczhj+k44r6aydNZxzyLOosVqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gb3fzT4aZM5zZSMwbEz68Zyw0yL2bQlGuuPwKItPLS0g/MFwGrI/Gn0XzAHwUO9GE
	 lMJNi3VNSXhKyiFFkc1KHKnSZcksZjMmlaTqMLHF/OqasKFe8nHRZv9kOodWnsYZ73
	 3Tm5JLFRxF7LC5BFeIAqGx0tiPqnkvF8jY1IwxCmw0cO3niVew2Fx80kSIgSlgQfeY
	 5xtzUnwqRJomnUWcWEe1mml5UicBqgHR0kKm0SKLYX5ffbR0CZuH91woWn+mMlB+Dy
	 vVd3SsuJfUIBctY7xAo8GyumrkzsR4Lp8vBbIFoB1oM7+RcnsJymIVgwACqC95jEZV
	 X51yPT3K6cN8KLJAgXFo4Z9IN9e+66xkG7slGj0HMwDms/V8XFvWXacv7hgF34nA8K
	 Q+VkZWUSLuCaq+5nPgLmoR3vqC4bGFfNgc58Zzl2JXBM/GoZetJ8kzIg93SHftycW+
	 6toBKtyQ3o3UQuL5k4odPb9TnRUZzh3yEWEWC6qv9DUGdE/QK1YOKEKEmOELaZddms
	 f27cRoGYEyEPOmuJjaOpoTqksQJS2CYcCs3kO6k4HLlq7CtB01D/BpiJlwSxaoa9RR
	 Pr1CBm7ZqujCUSsJ7GPCrDEf0hnYPp6O+3pOiTysySKw7dLZQbT32swoaOb/bV56LC
	 ZaydLiXYTJutzNBP80SCLNgA=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 2F82F40E0028;
	Fri,  9 Jan 2026 20:11:49 +0000 (UTC)
Date: Fri, 9 Jan 2026 21:11:42 +0100
From: Borislav Petkov <bp@alien8.de>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, x86@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/crash: Use set_memory_p instead of
 __set_memory_prot
Message-ID: <20260109201142.GFaWFg_kR8eW48CpUp@fat_crate.local>
References: <20260106095100.656292-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260106095100.656292-1-coxu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260109_121207_380878_8D49EBAD 
X-CRM114-Status: GOOD (  18.02  )
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

On Tue, Jan 06, 2026 at 05:50:58PM +0800, Coiby Xu wrote:
> set_memory_p has been introduced since commit 030ad7af9437 ("x86/mm:
> Regularize set_memory_p() parameters and make non-static"). There is no
> need to use __set_memory_prot.
> 
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  arch/x86/kernel/machine_kexec_64.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Why aren't those a single patch?

---
From: Coiby Xu <coxu@redhat.com>
Date: Tue, 6 Jan 2026 17:50:58 +0800
Subject: [PATCH] x86/crash: Use set_memory_p() instead of __set_memory_prot()

set_memory_p() is available to use outside of its compilation unit since:

  030ad7af9437 ("x86/mm: Regularize set_memory_p() parameters and make non-static").

There is no use for __set_memory_prot() anymore so drop it too.

  [ bp: Massage commit message. ]

Signed-off-by: Coiby Xu <coxu@redhat.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20260106095100.656292-1-coxu@redhat.com
---
 arch/x86/include/asm/set_memory.h  |  1 -
 arch/x86/kernel/machine_kexec_64.c |  5 +----
 arch/x86/mm/pat/set_memory.c       | 13 -------------
 3 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 61f56cdaccb5..4362c26aa992 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -38,7 +38,6 @@ int set_memory_rox(unsigned long addr, int numpages);
  * The caller is required to take care of these.
  */
 
-int __set_memory_prot(unsigned long addr, int numpages, pgprot_t prot);
 int _set_memory_uc(unsigned long addr, int numpages);
 int _set_memory_wc(unsigned long addr, int numpages);
 int _set_memory_wt(unsigned long addr, int numpages);
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 201137b98fb8..0590d399d4f1 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -673,10 +673,7 @@ static void kexec_mark_dm_crypt_keys(bool protect)
 		if (protect)
 			set_memory_np((unsigned long)phys_to_virt(start_paddr), nr_pages);
 		else
-			__set_memory_prot(
-				(unsigned long)phys_to_virt(start_paddr),
-				nr_pages,
-				__pgprot(_PAGE_PRESENT | _PAGE_NX | _PAGE_RW));
+			set_memory_p((unsigned long)phys_to_virt(start_paddr), nr_pages);
 	}
 }
 
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 6c6eb486f7a6..40581a720fe8 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2145,19 +2145,6 @@ static inline int cpa_clear_pages_array(struct page **pages, int numpages,
 		CPA_PAGES_ARRAY, pages);
 }
 
-/*
- * __set_memory_prot is an internal helper for callers that have been passed
- * a pgprot_t value from upper layers and a reservation has already been taken.
- * If you want to set the pgprot to a specific page protocol, use the
- * set_memory_xx() functions.
- */
-int __set_memory_prot(unsigned long addr, int numpages, pgprot_t prot)
-{
-	return change_page_attr_set_clr(&addr, numpages, prot,
-					__pgprot(~pgprot_val(prot)), 0, 0,
-					NULL);
-}
-
 int _set_memory_uc(unsigned long addr, int numpages)
 {
 	/*
-- 
2.51.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


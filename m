Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC084106ACFE
	for <kexec@archiver.kernel.org>; Thu, 12 Mar 2026 23:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bwmhrK1mTh+MLga869G8X7ffK5a55BOcYDLNgMLau3w=; b=YROrzH2ZhkV4DVpqMSoJJZvioz
	7bpUW34l3FCRZ33VfQ5ew8Dw+Ym1UR+lFvvE0vd8oqMBn+6/eCWPmZO0DdeMlvVaDLPozKwZKa6BP
	G8eLr/yjv7ab6f6dG2nLtzo9FLUK9olP2uRqRzsoTB/ChGUMMvhLzasaU9EHy3OJQUvxjGt6AA7G1
	WRor33Oz7/8oTH/wr6UKV7Z/Qs+j4umUNUazeODD9nvvL777ILfCowZzQZtFURN/JkPESFAO2J1fa
	G+IxBoJ3TYnO6kRep/OMkCJpxa7++j6iQvpuI5I1TmAz8IpvzMH43meucEtg/fcOliTM01fVawlOd
	YEgmtj9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0prT-0000000Fpl0-1dOy;
	Thu, 12 Mar 2026 23:54:39 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0prQ-0000000FpkP-3krS
	for kexec@lists.infradead.org;
	Thu, 12 Mar 2026 23:54:38 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DBF7F4DE48;
	Thu, 12 Mar 2026 23:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773359673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bwmhrK1mTh+MLga869G8X7ffK5a55BOcYDLNgMLau3w=;
	b=fk+HrQFzF538OaZee5zKteZcA0YzllQN4x1inGCAbXjNlo6QUNFUqNbGrCH5EeTJbbl1jk
	FTvU17qIJfkQDV+ln6qt+1UPpVopM6PIvAMUtTOjZZJ3/a+RYpvPc0tmmUajk0tARslnmX
	EHrtJDNB0KVkLkU4HiHWqk3laOWGWpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773359673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bwmhrK1mTh+MLga869G8X7ffK5a55BOcYDLNgMLau3w=;
	b=GjeLT5POJ2ppQv2V8UcAch81RQWi73SsE94ZqWuISHtXbtVGKO30Qb71oigY1fJWtdCROD
	hJQD5w9T4bPhNBAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nK3FApym;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6EDt9gxw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773359672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bwmhrK1mTh+MLga869G8X7ffK5a55BOcYDLNgMLau3w=;
	b=nK3FApym7tfNn1DYJAjxANwZrZkOi+7diHoNWII3ULI7GL59N/yI/X6ge92tRZaTNO+iDP
	rbkiSLfVzTovlXnwx+sm2XdjW+milZHXwHV3OFqONrs/aDXtvH33MrKfrw0c8b1brwsruE
	f+oOYH59XwjN26di3wGpoeV3fGBkJnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773359672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bwmhrK1mTh+MLga869G8X7ffK5a55BOcYDLNgMLau3w=;
	b=6EDt9gxwjTnn8WVNa/iDDOJbUxG4c6IPQDPESQ58T74caGcpdtTs0tWldMb3C2Klzv+2cX
	aUwaMbUSyMcQ9xBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A3794022C;
	Thu, 12 Mar 2026 23:54:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QCh3CDhSs2lNPAAAD6G6ig
	(envelope-from <ematsumiya@suse.de>); Thu, 12 Mar 2026 23:54:32 +0000
Date: Thu, 12 Mar 2026 20:54:29 -0300
From: Enzo Matsumiya <ematsumiya@suse.de>
To: Yury Norov <ynorov@nvidia.com>
Cc: Yury Norov <yury.norov@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Eric Biggers <ebiggers@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-spi@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Steve French <sfrench@samba.org>, 
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH] lib: count_zeros: fix 32/64-bit inconsistency in
 count_trailing_zeros()
Message-ID: <atnytehtvt6h6kp2ndxsa3x257usezp3bk5hp4ch7gf5w2zake@omihp5zbio3l>
References: <20260312230817.372878-1-ynorov@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260312230817.372878-1-ynorov@nvidia.com>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,rasmusvillemoes.dk,kernel.org,zx2c4.com,vger.kernel.org,lists.infradead.org,microsoft.com,ziepe.ca,samba.org,amazon.com,soleen.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DBF7F4DE48
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_165437_251877_978D48B2 
X-CRM114-Status: GOOD (  17.99  )
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

Hi Yury,

On 03/12, Yury Norov wrote:
>Based on 'sizeof(x) == 4' condition, in 32-bit case the function is wired
>to ffs(), while in 64-bit case to __ffs(). The difference is substantial:
>ffs(x) == __ffs(x) + 1. Also, ffs(0) == 0, while __ffs(0) is undefined.
>
>The 32-bit behaviour is inconsistent with the function description, so it
>needs to get fixed.
>
>There are 9 individual users for the function in 6 different subsystems.
>Some arches and drivers are 64-bit only:
> - arch/loongarch/kvm/intc/eiointc.c;
> - drivers/hv/mshv_vtl_main.c;
> - kernel/liveupdate/kexec_handover.c;
>
>The others are:
> - ib_umem_find_best_pgsz(): as per comment, __ffs() should be correct;
> - rzv2m_csi_reg_write_bit(): ARCH_RENESAS only, unclear;
> - lz77_match_len(): CIFS_COMPRESSION only, unclear, experimental;
>
>None of them explicitly tweak their code for a word length, or x == 0.

Context for lz77_match_len() case:

	const u64 diff = lz77_read64(cur) ^ lz77_read64(wnd);

	if (!diff) {
	...
	}

	cur += count_trailing_zeros(diff) >> 3;

So x == 0 is checked, however it does assume that
sizeof(unsigned long) == sizeof(u64).  I'll have to fix it for when
that's not the case (even with your patch in, as __ffs() casts x to
unsigned long down the line).  Thanks for the heads up.


Cheers,

Enzo

>Requesting comments from the corresponding maintainers on how to proceed
>with this.
>
>The attached patch gets rid of 32-bit explicit support, so that both
>32- and 64-bit versions rely on __ffs().
>
>CC: "K. Y. Srinivasan" <kys@microsoft.com> (hyperv)
>CC: Haiyang Zhang <haiyangz@microsoft.com> (hyperv)
>CC: Jason Gunthorpe <jgg@ziepe.ca> (infiniband)
>CC: Leon Romanovsky <leon@kernel.org> (infiniband)
>CC: Mark Brown <broonie@kernel.org> (spi)
>CC: Steve French <sfrench@samba.org> (smb)
>CC: Alexander Graf <graf@amazon.com> (kexec)
>CC: Mike Rapoport <rppt@kernel.org> (kexec)
>CC: Pasha Tatashin <pasha.tatashin@soleen.com> (kexec)
>Signed-off-by: Yury Norov <ynorov@nvidia.com>
>---
> include/linux/count_zeros.h | 9 +++------
> 1 file changed, 3 insertions(+), 6 deletions(-)
>
>diff --git a/include/linux/count_zeros.h b/include/linux/count_zeros.h
>index 4e5680327ece..5034a30b5c7c 100644
>--- a/include/linux/count_zeros.h
>+++ b/include/linux/count_zeros.h
>@@ -10,6 +10,8 @@
>
> #include <asm/bitops.h>
>
>+#define COUNT_TRAILING_ZEROS_0 (-1)
>+
> /**
>  * count_leading_zeros - Count the number of zeros from the MSB back
>  * @x: The value
>@@ -40,12 +42,7 @@ static inline int count_leading_zeros(unsigned long x)
>  */
> static inline int count_trailing_zeros(unsigned long x)
> {
>-#define COUNT_TRAILING_ZEROS_0 (-1)
>-
>-	if (sizeof(x) == 4)
>-		return ffs(x);
>-	else
>-		return (x != 0) ? __ffs(x) : COUNT_TRAILING_ZEROS_0;
>+	return (x != 0) ? __ffs(x) : COUNT_TRAILING_ZEROS_0;
> }
>
> #endif /* _LINUX_BITOPS_COUNT_ZEROS_H_ */
>-- 
>2.43.0
>
>


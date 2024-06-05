Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32B3C27C52
	for <kexec@archiver.kernel.org>; Wed,  5 Jun 2024 20:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m65AzK32Ui7MzmcmJsoTTUgxxNstfz5UV2Ge1WtinCI=; b=iYGl55UKjj1u+R
	MTWnjtGgiYA0Q04Pk5xwuEZFRLZsbVfW9BdYg9N6p9HT9BGm09IOK6+LAFtyL3gO+CDlCyq94MRGe
	PdF4hCHYoPrXg/sQke3KzEyMuuj2bUkhlY2vd1lzw1skDJkNETb2AjsdmTYmgg5CksArvnJ0ZAfjc
	SfjND/KEQyREBMsPFqj7iy+BbhAsWtFANe8zu/hGYHMCMhBypVqfVtfclKXscMOgRZK+ybXthPJrB
	HLWpuzAIUqX6+qvgeiHeN3b/ji+c3x5bOk5r29iNleiIdFsO5oY1ecamrS2ZiAIPDEXyfj8eq3Ag9
	oJ9bqb+gJrmZWMUl6rlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEx29-00000007QQd-3eYV;
	Wed, 05 Jun 2024 20:14:57 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEx27-00000007QPc-0BuM
	for kexec@lists.infradead.org;
	Wed, 05 Jun 2024 20:14:56 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8BCA240E0177;
	Wed,  5 Jun 2024 20:14:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8zifVUZdnrvr; Wed,  5 Jun 2024 20:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717618488; bh=qZG3f/DmbJHa7xvgS2GeAG2D5DGmpu+ILLLLB6UEuR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V4qtiawH2MYeOTIyka2HhiqpEQ+lB3CFYPtNRKcpHzU/RDvOw/XNmRxkzDndptqSV
	 Qs9mArBgjw/IFCrKmtUZyCCuX3UErjmfR8qMCaffGEHdYKDGd49sy5GgoCdonecEIZ
	 DuoejzzWW4AHjQaYPEPzWke4YeahLqyTcYz7VECSLJdSClODpi9Y7VI2hmzKVwkCKZ
	 i7SC42+21K5NfMJsEl6n/B+HgDzL0hH2WlZ7j8fsb92RdbhrAi5cSLBCHlKqEhMAC2
	 j0l4IxoxAigb9mrsc9AsdpEjALw8ENQKQPXUKXWeUOWNyG4qq/FCjMTFPS3gzp5hEq
	 Lz8nDpS6ADk6Bs/wjlTsc+uteKumWWaljQ1sDtFkRO8Jg0ZI8/srdNLxRybzCOzukz
	 Yri5q7Lc3oLN3yrAiQGA2lrsAJR+SRn0L2seHkhWSGzq1SA2xT+QO5Gt5r/mcSrWTN
	 D/dUp4Wtylc3+i6I3nISnzmKhX/IigvhLZ+mBW6lqFoTgTS7Agqif+JZ+dDVYxe0ET
	 RAv72qvNA1GkyrmYpdoEOQZjqU5dVj/JxMhYuWnDSBBQ8x9TpxilYemPu4v/r4ZXJw
	 wW1irkVmMk0XT4leNy7sAec1uJ5n2SKSA3vx0R939WXMoVh2skr6SlFG2MHnl/1+xP
	 Meqs6haSXEfuBHXivleOsbzU=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 52C6440E016A;
	Wed,  5 Jun 2024 20:14:21 +0000 (UTC)
Date: Wed, 5 Jun 2024 22:14:15 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, rafael@kernel.org, hpa@zytor.com,
	peterz@infradead.org, adrian.hunter@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
	bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/3] x86/boot/compressed: Skip Video Memory access in
 Decompressor for SEV-ES/SNP.
Message-ID: <20240605201415.GZZmDHF9-lThZ6XQOz@fat_crate.local>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <cover.1717111180.git.ashish.kalra@amd.com>
 <75a313a44bfaf3f97027393665d625be2f881e66.1717111180.git.ashish.kalra@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <75a313a44bfaf3f97027393665d625be2f881e66.1717111180.git.ashish.kalra@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_131455_284005_BB01DB52 
X-CRM114-Status: UNSURE (   9.95  )
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

On Thu, May 30, 2024 at 11:37:14PM +0000, Ashish Kalra wrote:
> -	lines = boot_params_ptr->screen_info.orig_video_lines;
> -	cols = boot_params_ptr->screen_info.orig_video_cols;
> +	if (!(sev_status & MSR_AMD64_SEV_ES_ENABLED)) {
> +		lines = boot_params_ptr->screen_info.orig_video_lines;
> +		cols = boot_params_ptr->screen_info.orig_video_cols;
> +	}

By now I get an allergic reaction from this sprinkling of "if sev..."
everywhere in the code.

>  	init_default_io_ops();

<--- right here there's a call to

	early_tdx_detect();

You can add a early_sev_detect() counterpart here and clear lines and
cols in it along with an explanation why it is being done.

This is at least a bit cleaner than this.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

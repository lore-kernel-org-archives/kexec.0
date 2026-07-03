Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1479EC43458
	for <kexec@archiver.kernel.org>; Fri,  3 Jul 2026 15:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZBDzBrulDAzRoYoAputO0VKZJ56+Z7BD/3jMwbMpdqU=; b=IefM634hlUNtcVME2sIwRdjml9
	Zud9HDApvBrCnSu0FBOqDTR2Ut+b5p/JluFuYHKXn3m8RSuw/P+7+heKrNFyQTspwa1cD7tb+Q+Uj
	fgA2q5ecchbiXD8CbYOAmuBx8W17anfgKHDQJMtldphimhSw0c+bQ8hnxb4xPhP0/GH72qxrrTgLT
	ar+IQQ6BoXPoQalWQmC2wvIO3sX8zBf2HKuggmftlRYu+LRMgdHGeoPYAhgoO2nWariq8Q1ATgfvt
	z/jgev+HiMQc30OEH745GtIIgq3Pjnuz0lJK8F3/RHSRbJombWSbebZ56isbHYv2/v8Kr589VR3cA
	bfMIu1cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wffrC-00000007PVZ-1mLK;
	Fri, 03 Jul 2026 15:31:10 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wffr9-00000007PUE-1rln
	for kexec@lists.infradead.org;
	Fri, 03 Jul 2026 15:31:09 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 20EFE40E01DB;
	Fri,  3 Jul 2026 15:31:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cJ-aZ2mXGHTA; Fri,  3 Jul 2026 15:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1783092658; bh=ZBDzBrulDAzRoYoAputO0VKZJ56+Z7BD/3jMwbMpdqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bZ3wYHEl7qE1wccf31CLMn60/VWYlxCHlQ6exf8Ny02/+gUvOo5HgI4Z6l6qnMA/H
	 BhxGCsdgAshMwr2Mr1hiWgsjb6CAXMKH/tt4VWPKiML9T5CMYq6P+rAMOnelI9YjLk
	 V/8jg+/R6nK2eAo5jM44QQNBdEGbsGbO7YXZOPb6NKsF2cPd1wapkZAfBg0anXeetN
	 qjDHtq0jmhOtRmet/RY1iCFrQqEd+l3Gei0KzkLjYvrCfFkMxlsRUBFjPBUORgq/Yu
	 EYb4BImVA91ysUKvrOMCzoen9KGjXvfq633Fyc62b0Vz/OEWglVQlHsgD8KESdbKId
	 1pYpzVdG4y8nAqX1vYryt+W/4WY1Re3YSNoMKmHntpBL7+Kf79Uqn+XdKcwxEjQz1s
	 90ZYrqDq+UnsjzHaqMm/OwGe2/phBB1Ubflp3+TZrtUgsJHv2tOSQanYS/cOzrHtLi
	 bX0GmAWaPuO5L7av2KkJQDYGCDIE9ZhKk/QsVxJdk42FGxsQpjWFjJsvXhlF/3k8x9
	 yy+gn6dnmN3trnh02KuIuYuEEExqsSqFwCL4FeM5sKIs5x+qTXjg1Ats2ZJMNgFULG
	 ObvoFEKDl5Zxmos48wLq3LkP3Ni/ZDjoeaEOKj5TxQKDvmyTTk6sOnXwerzYnzM2he
	 e6/4VHZBg4NEjqI0LNqP9TCw=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 62B8440E00B8;
	Fri,  3 Jul 2026 15:30:47 +0000 (UTC)
Date: Fri, 3 Jul 2026 08:30:44 -0700
From: Borislav Petkov <bp@alien8.de>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
	x86@kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH v2] x86/setup: do not include kexec_handover.h from
 asm/setup.h
Message-ID: <20260703153044.GCakfVpO_egX4B9y_1@fat_crate.local>
References: <20260703143705.2525168-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260703143705.2525168-1-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260703_083107_632798_FF4CF41D 
X-CRM114-Status: GOOD (  14.96  )
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

On Fri, Jul 03, 2026 at 04:37:03PM +0200, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> x86 asm/setup.h includes linux/kexec_handover.h. This is because it is
> used by setup.c and kaslr.c. But this inclusion is problematic. The
> header is included in many places, so it results in the KHO header being
> propagated there. Also, the setup header is used by realmode code. If
> KHO header includes things like mm.h, it causes a big dump of
> compliation failures.

Use a spellchecker.

> Nothing in setup.h uses anything from KHO. Remove the header from
> setup.h, and directly include it in setup.c. which does use things from
> KHO. Since kaslr.c is a part of the decompressor, avoid including linux
> headers there directly. Instead, split out struct kho_scratch, which is
> the only thing the kaslr.c uses, and move it to
> include/asm-generic/kexec_handover.h.
> 
> This change should also help reduce files recompiled when

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> kexec_handover.h changes.
> 
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> ---
> 
> Notes:
>     Thomas/Ingo/Borislav/Dave, is it okay if we take this patch through the

See my reply to Mike about using the generic-y infrastructure.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


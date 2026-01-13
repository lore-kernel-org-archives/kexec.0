Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A75D2D111
	for <kexec@archiver.kernel.org>; Tue, 13 Jan 2026 14:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pSiuhQph/ApvBsNWFxpJdgFvWzz5gyNJmVSo8oa2Ohs=; b=gAIfM/ViM/F3NR9b5n+MUn6yjk
	rr62bCeId/6wE3kSeAVTv0v8IiFqi8saq7IV9U0vpEbx0RsGDpPtjcde8e2wgOAJECcBTQADSO8fW
	y88GLTN1aJfRWVAlqxWpblzlU7Z+TrPYx/e/GcpBUjUAY+7+hA7w2AIQCoBVWwGZ3wCrIs9RF89tk
	FBH45Zlve001A8fEIcwRbuZCC9GzTFE9Q37gLFBfauN3IgZkNxGIBbjQiOZlLK5ktxwSXhdHBqGbB
	YbNUrronBFS3V34WXVcO7YiBuuMqkdYcKAJTKm8e7tnUIREc/StL0SNW6HiVNGZ9st75OvVwY4oyX
	BKi6e/dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vffNI-00000007Fvl-2O98;
	Tue, 13 Jan 2026 14:28:00 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vffNG-00000007FuG-03g0
	for kexec@lists.infradead.org;
	Tue, 13 Jan 2026 14:27:59 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B395040E01A9;
	Tue, 13 Jan 2026 14:27:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jyg3Aw5gpyWn; Tue, 13 Jan 2026 14:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1768314469; bh=pSiuhQph/ApvBsNWFxpJdgFvWzz5gyNJmVSo8oa2Ohs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=exuhMc0gxTQAKQSsuJUSatMmyysckIRa0c9yrwY5b0HKgAAD3t8CtP04EpoVeZ9Mq
	 P2isYOJkeYQFqHMzNTjiMnAUjKzfT+jaMG1r8DL/aLsywTWLKBqgDx5pu2TC9wPATu
	 Bdzaha5+SBLp3skLTM0LtnkI/iePKBM6WUlC0zYNPlMrmkCF1nivFfJG5kzn77Z2f8
	 oRvIVIDq4JE41Fiw5/REhzLauudrqElKHgrBR+eyLdDLVD0ODZ0EfiMroXPuRLhtJn
	 YEj1AQ5TmOybYKLsgpRiTdjP68BNaduHe/TCtQ+NJDIJRLam2tRvWS5r4qKjoDL9i5
	 rHvJ8GLBG5WWt3nkOM3TWjN+/WPUMQJeOtUIZc9JoFZKaLj+hvyn+R7hbOrbFEy7QE
	 XHytybwweCSHJcdkAziHxkR+ZtgTs1TPf0KRQFV8cgvCRVWriJeabP9+IPIO0kWLvc
	 u6E/OxKbcDe8kC1pOFZE3m7AJFFfz13XLt/BgZLW0l0Kavfja6rVrHOegupdqIfhki
	 7PX8FvFk9TDJBukdtDs0wEsGnYXY/o2zcQa/KMGaYsIatH//A8KjQlzeINxtiEUciP
	 BnQk+Jm6/6RsjHLTdKI1CZ390M5i9oPKUpIPLGOYx+BDpZQG3gF7jHOGzkXUsmTNZP
	 A5qvDK2IndFbuApg/iwQCmwQ=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 268EF40E00DA;
	Tue, 13 Jan 2026 14:27:40 +0000 (UTC)
Date: Tue, 13 Jan 2026 15:27:33 +0100
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
Message-ID: <20260113142733.GKaWZWVR_0Q_awGa80@fat_crate.local>
References: <20260106095100.656292-1-coxu@redhat.com>
 <20260109201142.GFaWFg_kR8eW48CpUp@fat_crate.local>
 <aWYWm4gLwFmvM730@Rk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aWYWm4gLwFmvM730@Rk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260113_062758_204371_B942A2B0 
X-CRM114-Status: GOOD (  12.02  )
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

On Tue, Jan 13, 2026 at 06:14:38PM +0800, Coiby Xu wrote:
> I thought smaller patches are easier to review. But seems it's unnecessary
> for this case.

Right, especially if the two patches do one logical thing - removing
__set_memory_prot(). Then one patch is better.

> Thanks for squashing the two commits and also updating the commit
> message! I notice you also added a Link tag. Does it mean there is no
> need for me to re-send your new patch as v2?

Yap, I can queue it, no need.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


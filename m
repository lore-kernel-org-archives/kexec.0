Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C0DC04FFE
	for <kexec@archiver.kernel.org>; Wed,  8 May 2024 12:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WyDkzlIuYvkxro0QBtTXCM4qFabcBPkGahy8hlVZoDU=; b=iGYh5IpOaYaOwy
	3kQDRb+sG3b25rgRD2orcomyju8MQny0dOyLNn0YebSY0Z1mfcEKdReOG/ZWK4RKkSNKSx4Bbvb44
	B0yEmSLJyHRIdfhG00QDtrQm6IBdUuNC1TqEj0rfR5TUNhO8IZskCnJHAAeEUnk4Ikyi/U5plKYPi
	9kVytiOzKl2PnpQw5Avk+eCJw86emgEIpnkQPD8S0kGWajnZYoG+0DJe1HA45KDSwvYS2h7Ka4Uc9
	UqAvsIHt5NJtBOHOIWWdAJmdBKXOqREIQdLpZGBoQaN8oHbQLqjXVdHN3YD+4dqZL66BewNLcUKvY
	eh3t4SoDIptnF7D+L03w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4gG3-0000000FPnJ-1VER;
	Wed, 08 May 2024 12:18:51 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4gG0-0000000FPmC-3ioE
	for kexec@lists.infradead.org;
	Wed, 08 May 2024 12:18:50 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ADCA940E024C;
	Wed,  8 May 2024 12:18:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XQyq8Rs12_HQ; Wed,  8 May 2024 12:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715170722; bh=zAP8WZWIDY0jQdc667ULP2ScBNTHP+zF1XZ2Xi2qwfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zdre9eqm6W74SVfkLa/gHXSJCJs0g9ztPCczJoGzIqos+FM5zlXKPr5JcEl0nHxsr
	 YTGVnJBUJZ+qNWfG+DW8k801y9m61ZmGnPgxbp4SkmR24tCGiLWsAGFRhC5Ez0hjAi
	 kyskakZGM7EtPjtxXQNWF+u3j/Nz+plu4qW0Pd6idZVDjvpYXbQsVIl+JWJ91EGJkA
	 Hx0hNlPOcQ3WNA+6Lr3BXCr3nJXj5wpjz6gKtGmd26vL47o7U+EOyNzNOdEIOe9Qty
	 JRuOZ0raQ33fKRWQA2p4bMcT5THSTuXzlhwNvp30wP6IyFD44rBnSkxfawRlDGR6Qm
	 WnGIXOf3zH24ZbeFGFq9YPaTooXZQu4egcyjn4UUCMDpLO5tEyn2Y2/DNbA3tbyrxw
	 Jez9NkiRwfeXCZB9c8nyuAVSJ5tjNJTvWsSQy5i/O6MPY79C8lVw8FR10aGHiPKF31
	 dg7/gyJmr9g4dL10a/bzdXSlKaSx+4GU3qgLiQHQpReMwyHRrRWXjD3nzLMNlsGPN4
	 iRNXSXxPLxIm+TPnd/EXWMLI1B9PlR+QZ+t88PmZuu4+tABSRtayztkQye+WOc14i2
	 1iJrr3YX2YqPfpx1ICr73bMEMg0ML8GxC7JkBI7FoHSNUtf8yy+mjwSnziX/tsD8ek
	 vb4vp5/LFwT6LdqKDXgRf4P0=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 141E140E01A3;
	Wed,  8 May 2024 12:18:21 +0000 (UTC)
Date: Wed, 8 May 2024 14:18:19 +0200
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
	linux-kernel@vger.kernel.org, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv10 13/18] x86/acpi: Rename fields in
 acpi_madt_multiproc_wakeup structure
Message-ID: <20240508121819.GEZjtti1unC6GEFpPZ@fat_crate.local>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-14-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240409113010.465412-14-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_051849_097726_61351E33 
X-CRM114-Status: GOOD (  10.49  )
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

On Tue, Apr 09, 2024 at 02:30:05PM +0300, Kirill A. Shutemov wrote:
> To prepare for the addition of support for MADT wakeup structure version

"In order to support... "

> 1, it is necessary to provide more appropriate names for the fields in
> the structure.
> 
> The field 'mailbox_version' renamed as 'version'. This field signifies

From Documentation/process/submitting-patches.rst:

 "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
  to do frotz", as if you are giving orders to the codebase to change
  its behaviour."

So:

"Rename 'mailbox_version' to 'version' because... "

> the version of the structure and the related protocols, rather than the
> version of the mailbox. This field has not been utilized in the code
> thus far.
> 
> The field 'base_address' renamed as 'mailbox_address' to clarify the

Ditto.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

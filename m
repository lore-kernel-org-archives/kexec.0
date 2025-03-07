Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D387AC28B23
	for <kexec@archiver.kernel.org>; Fri,  7 Mar 2025 19:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nRLv4a6SOJqdV7xCTzsz9N3jBKIETe94Y8MjVn1JQKc=; b=Zn2S/jsptyuZahUA295DsBV2PA
	2KWztyiYwyAnc/P8btkQxVmljqqky9FsB9VhcIdpWOdcnaWxA3kCIkop6Ras4DVX7xU5D6C3aba9d
	3fIrNBzwm/DhFCTgx9oNhXtUgTNiw11e6LKI9O+GHvroVnh7UACc4ufvFCgszFEXHDxt1EDpKq+At
	b23MZX1tNuP7uy5xT7YyUzXUTFynTjdmFGL1e1QvsK7JkobNWSPwwyVoyC9MH5aADuUgaMDMshSyu
	yejyQETS4/8yix0FPGssa07Ca0BsyQ8DpPNKlLwBdwp8TgH3PAvikJg+rwHEERJXuqBQeh+Xtud1W
	Ws4p84IA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqdVh-0000000FNDq-2UfL;
	Fri, 07 Mar 2025 19:37:29 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqdVe-0000000FNC6-0Un3
	for kexec@lists.infradead.org;
	Fri, 07 Mar 2025 19:37:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id AC6FCA4519B;
	Fri,  7 Mar 2025 19:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1235C4CED1;
	Fri,  7 Mar 2025 19:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741376244;
	bh=gdJJj0Y+vIMQxl2pF/V+JeYln0YLxtYpZd3GhmHEoMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cW+40b7p32mLKFSwQhsZH6rP9RxyzfSQuk2cWhW6r7FcrXqRf7t+1NavLAixHCDG4
	 tof9vEYVEcENkLBBLXtmlDBX+SDWmcOYBOHaDYh08VYLXBxIjXD0MkSGyY1caOWHex
	 gqYREeYkVZ4FeBdglamBrrGdm3WTfLcNxQUA2aEREznnWqs0Ig19i1yFHKsTCdaFAa
	 Md1jAQLl3quoOYRr9qd+foB2MFdHcY2uo966ZYZ+X7uYPIqbEnJH6dcAThUvU7o4nD
	 YKqmoB5xskRqBVoPlBQTpvNJ7xJ9K5SEC6vZWKt4Swc61UgoQyMO3JQWvlOKkgPxSB
	 QQv1xCH3VauFg==
Date: Fri, 7 Mar 2025 21:37:19 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: ross.philipson@oracle.com
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	ebiederm@xmission.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v12 04/19] x86: Secure Launch main header file
Message-ID: <Z8tK704hkyoZZc7_@kernel.org>
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <20241219194216.152839-5-ross.philipson@oracle.com>
 <Z8qFdeM8YEck2j1C@kernel.org>
 <d2adb4c4-b03f-4fbd-81c2-1cd017ed2822@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2adb4c4-b03f-4fbd-81c2-1cd017ed2822@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250307_113726_242526_4C6B578B 
X-CRM114-Status: GOOD (  15.98  )
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

On Fri, Mar 07, 2025 at 11:25:20AM -0800, ross.philipson@oracle.com wrote:
> On 3/6/25 9:34 PM, 'Jarkko Sakkinen' via trenchboot-devel wrote:
> > On Thu, Dec 19, 2024 at 11:42:01AM -0800, Ross Philipson wrote:
> > > Introduce the main Secure Launch header file used in the early SL stub
> > > and the early setup code.
> > 
> > Just would need a *short* description of what slaunch.h holds. I guess
> > it holds Intel TXT micro-arhitectural data structures? Anything else?
> 
> Later it will contain data strutures etc. to support other architectures
> like AMD and Arm64.
> 
> > 
> > This helps e.g. reviewers to skip some but still keep on track what a
> > patch contains (and return back to it when necessary).
> 
> Yes we can make it clearer what is in this header file.

As per code changes I did spend two hours reading them just to make sure
that I can understand the TPM specific code changes, and also that they
make total sense to me.

Therefore I've put a lot the nagging is around documentation and
definitions. I really could not find anything in the source code that I
could pinpoint being absolutely wrong.

This really needs just now the stamp from tip maintainers. As per TPM
changes they do have my blessing (no need for reviewed-by's as they
have SOB already). I hereby also give permission to pull TPM changes
through tip tree...

> Thanks
> Ross

BR, Jarkko


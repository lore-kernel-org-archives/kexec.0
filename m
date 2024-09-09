Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15115ECE579
	for <kexec@archiver.kernel.org>; Mon,  9 Sep 2024 09:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QzpT7ZxFCVqMFuf0H1JlQDkhKCZYa5pAR5o9+F8/xEo=; b=ldQsJF/x1b9viG
	Bi309vrZWxSKB5DRQQeJzGo2qeyCB9l2u1ahlXwp4sI3lYY69wRA63VpWBnPxTHXblP2Mu+NFPQO1
	nKGDIsUJz+pEz//3YZso5pLHb3JIA6R7dg+4lJWa//rR6f3g2j/VD7kyM3oq5u1yJdQBVch3k3fEE
	ZKtkP3H4Q3L7NA3Aowqu43cbGb/ImuB064KNcHaAFUdFwVui6Ge3Ds1n1gkZUn+6GuWWOFqBycaDa
	PIJMjbNqbLEt/bq7l+sLC67RE722VPuEdvjp9LOd+84KPJKlqQFF0Nf1kopnzgDWYKJ518P1ohMB9
	LOuMiSKPWIWWgT6evw1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snb1x-00000001OKI-0yoP;
	Mon, 09 Sep 2024 09:49:57 +0000
Received: from gardel.0pointer.net ([85.214.157.71])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snb0e-00000001O2T-03M9
	for kexec@lists.infradead.org;
	Mon, 09 Sep 2024 09:49:55 +0000
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id EDB21E80261;
	Mon,  9 Sep 2024 11:48:30 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 68469160143; Mon,  9 Sep 2024 11:48:30 +0200 (CEST)
Date: Mon, 9 Sep 2024 11:48:30 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Philipp Rudo <prudo@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Pingfan Liu <piliu@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
Message-ID: <Zt7EbvWjF9WPCYfn@gardel-login>
References: <20240819145417.23367-1-piliu@redhat.com>
 <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
 <20240906125438.1e54c5f6@rotkaeppchen>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240906125438.1e54c5f6@rotkaeppchen>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240909_024836_228927_8D54D210 
X-CRM114-Status: GOOD (  20.24  )
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

On Fr, 06.09.24 12:54, Philipp Rudo (prudo@redhat.com) wrote:

> I mostly agree on what you have wrote. But I see a big problem in
> running the EFI emulator in user space when it comes to secure boot.
> The chain of trust ends in the kernel. So it's the kernel that needs to
> verify that the image to be loaded can be trusted. But when the EFI
> runtime is in user space the kernel simply cannot do that. Which means,
> if we want to go this way, we would need to extend the chain of trust
> to user space. Which will be a whole bucket of worms, not just a
> can.

May it would be nice to have a way to "zap" userspace away, i.e. allow
the kernel to get rid of all processes in some way, reliable. And then
simply start a new userspace, from a trusted definition. Or in other
words: if you don't want to trust the usual userspace, then let's
maybe just terminate it, and create it anew, with a clean, pristine
definition the old userspace cannot get access to.

> Let me throw an other wild idea in the ring. Instead of implementing
> a EFI runtime we could also include a eBPF version of the stub into the
> images. kexec could then extract the eBPF program and let it run just
> like any other eBPF program with all the pros (and cons) that come with
> it. That won't be as generic as the EFI runtime, e.g. you couldn't
> simply kexec any OS installer. On the other hand it would make it
> easier to port UKIs et al. to non-EFI systems. What do you think?

ebpf is not turing complete, I am not sure how far you will make it
with this, in the various implementations of EFI payloads there are
plenty of loops, sometimes IO loops, sometimes hash loops of huge data
(for measurements). As I understand ebpf is not really compatible such
code.

Lennart

--
Lennart Poettering, Berlin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

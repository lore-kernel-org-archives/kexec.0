Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F477E6FE55
	for <kexec@archiver.kernel.org>; Sat,  7 Sep 2024 11:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Lxslj59CZ8S5VC0/ntZX3xGaWYlmI8A48NzQaKVWSu8=; b=vJ8DqWxRNyaCrL
	kC95ktHUF8aXXu5JagRKsUFfcvAp/iujMyF6zbJiJpu8HzR6S5r4YK7z6NYVExr4qlYKLzGMGOKoL
	EtszdVXUGM5GJwc5MO3FgYad3Ea0vOXt7GpTMd+doWN10E7GbrcnF4eBShhf1uku6UYnVCCaG6Htl
	P+rHfaRS28h2fHfdr9FXa2GdHnad+Rpc4O3yRCFiWEbLKrbjp3Cc2fxXzDdU1md8ciUjPocsZ+Ci6
	4qtChmuDUFFX/rOWutpcSBaxXphZ6fj/41joX2GkzAH2Kln9EQ2/YbWHNYFT1H+8ENDWnxpmiquB8
	0O9mJ+UD449uo7rUghaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smtbF-0000000Eusq-1QQy;
	Sat, 07 Sep 2024 11:27:29 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smtbB-0000000Eurd-0gWu
	for kexec@lists.infradead.org;
	Sat, 07 Sep 2024 11:27:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id D6A58A40201;
	Sat,  7 Sep 2024 11:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A9DC4CEC2;
	Sat,  7 Sep 2024 11:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725708443;
	bh=DzlgCZvoAslqJIa9rfeEGQCc5NjF7zvlXCe6WoEoX7I=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=RBWcyKFZe/9mOh4BaocbZV1L/fwv2mg/sbQWsUMfPaK8pCqrsjbDfX4iRVV1T69zh
	 PTDY+O3fp00QR8UNjCq6pPT0w3UjUBvLOTUF+8iO4dFu2zdraTQli68wfSOHL4D7xF
	 BZt445JRlAGbbnd6znNMZmF/XGFj3lMEKbNnnUvLOVOK6sGfpVjx0iLAvh279I2wqQ
	 hSuzSRj4CcTMoSONY7fVDlMo3bFYaLBDz6fes8sULlD9l1n+CZzrb3KqOdhA1UZ1el
	 osJbkjs6RfaTR1jOGl6IYOusIPlEs69Pp7wrcq2rNie/x1qL6JzEXuvC2s2FCYZjjj
	 fiLrmYhXP+m9A==
Mime-Version: 1.0
Date: Sat, 07 Sep 2024 14:27:20 +0300
Message-Id: <D400L4YN4K7K.264IDL4O8374F@kernel.org>
Cc: "Pingfan Liu" <piliu@redhat.com>, "Jan Hendrik Farr" <kernel@jfarr.cc>,
 "Lennart Poettering" <mzxreary@0pointer.de>, "Eric Biederman"
 <ebiederm@xmission.com>, "Baoquan He" <bhe@redhat.com>, "Dave Young"
 <dyoung@redhat.com>, "Mark Rutland" <mark.rutland@arm.com>, "Will Deacon"
 <will@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Philipp Rudo" <prudo@redhat.com>, "Ard Biesheuvel" <ardb@kernel.org>
X-Mailer: aerc 0.18.2
References: <20240819145417.23367-1-piliu@redhat.com>
 <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
 <20240906125438.1e54c5f6@rotkaeppchen>
In-Reply-To: <20240906125438.1e54c5f6@rotkaeppchen>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240907_042725_291225_8C3D458D 
X-CRM114-Status: UNSURE (   5.89  )
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

On Fri Sep 6, 2024 at 1:54 PM EEST, Philipp Rudo wrote:
> Let me throw an other wild idea in the ring. Instead of implementing
> a EFI runtime we could also include a eBPF version of the stub into the
> images. kexec could then extract the eBPF program and let it run just
> like any other eBPF program with all the pros (and cons) that come with
> it. That won't be as generic as the EFI runtime, e.g. you couldn't
> simply kexec any OS installer. On the other hand it would make it
> easier to port UKIs et al. to non-EFI systems. What do you think?

BPF would have some guarantees that are favorable such as programs
always end, even faulty ones. It always has implicit "ExitBootServices".

Just a remark.

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

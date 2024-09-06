Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A1DCE7AFF
	for <kexec@archiver.kernel.org>; Fri,  6 Sep 2024 10:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZyqSrGu0+HYNSD1KX+QnmFWV0C2/YOg+Qp06njBF8c4=; b=RSMsqC3R61jwBx
	LUw/COafnH0q4B/usACAs5u1WrYkc1gWzYt0IW3gskfrp3NYQnbO0Noo8BrUn0J6xxReyeuXe+RrH
	4Cfy0KAugNuinhKhMSptXvtJUgdnmwOOfJ3F1tKQl9tUpo/EYv51gh3dK3vHF+6i0Fl5FkPoo1UzF
	fUEQ0LtshnatLrDRpXPz4xx3F3Kqej7q3sgSmC0LG8o5pRCegB2Equ6E/IRmgNIF5wUvK6LlFcNOp
	ccmUfan69U6xax8u4xoDMMUkM+kzs8Mkv6LDPnHFFScE2KxFTEO/S/H2Et/AOQM6NLDSZjeYo5Ble
	JoudCwp4v4FHwe7TkxGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smWcQ-0000000BrES-18iD;
	Fri, 06 Sep 2024 10:55:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smWcK-0000000BrDi-3Lsg
	for kexec@lists.infradead.org;
	Fri, 06 Sep 2024 10:55:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725620102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bz2nJuvJfSC/E6iHvxzgQOTw9UEW2x/G2ibR8rkxWXo=;
	b=VI8QyMV7TsDvIrryUMIvJWaroo+/oV3hNWmj8L052NuCg6JN7ePc3OfBwprILc2N+5kraO
	UNxyjKWKHyL3BhksKlkNNkYulipDk48XZWWgYT8hr8OERVXt48bFH2TfQP8mHe5uc5dnkD
	cy9VuuRuhd6a4Bi5eLFtKAJu2frHIXo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-qM2hcHPQPPWgr4iBH0cb6Q-1; Fri,
 06 Sep 2024 06:54:57 -0400
X-MC-Unique: qM2hcHPQPPWgr4iBH0cb6Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40AB81956048;
	Fri,  6 Sep 2024 10:54:55 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.193.186])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 377013000238;
	Fri,  6 Sep 2024 10:54:46 +0000 (UTC)
Date: Fri, 6 Sep 2024 12:54:38 +0200
From: Philipp Rudo <prudo@redhat.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Pingfan Liu <piliu@redhat.com>, Jan Hendrik Farr <kernel@jfarr.cc>,
 Lennart Poettering <mzxreary@0pointer.de>, Jarkko Sakkinen
 <jarkko@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Baoquan He
 <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Mark Rutland
 <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
Message-ID: <20240906125438.1e54c5f6@rotkaeppchen>
In-Reply-To: <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
References: <20240819145417.23367-1-piliu@redhat.com>
	<CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
Organization: Red Hat inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240906_035504_960209_E9AF4D05 
X-CRM114-Status: GOOD (  43.06  )
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

Hi Ard,
Hi Jan,

On Wed, 28 Aug 2024 19:08:14 +0200
Ard Biesheuvel <ardb@kernel.org> wrote:

[...]

> Thanks for putting this RFC together. This is useful work, and gives
> us food for thought and discussion.
> 
> There are a few problems that become apparent when going through these changes.
> 
> 1. Implementing UEFI entirely is intractable, and unnecessary.
> Implementing the subset of UEFI that is actually needed to boot Linux
> *is* tractable, though, but we need to work together to write this
> down somewhere.
>   - the EFI stub needs the boot services for the EFI memory map and
> the allocation routines
>   - GRUB needs block I/O
>   - systemd-stub/UKI needs file I/O to look for sidecars
>   - etc etc
> 
> I implemented a Rust 'efiloader' crate a while ago that encapsulates
> most of this (it can boot Linux/arm64 on QEMU and boot x86 via GRUB in
> user space **). Adding file I/O to this should be straight-forward -
> as Lennart points out, we only need the protocol, it doesn't need to
> be backed by an actual file system, it just needs to be able to expose
> other files in the right way.
> 
> 2. Running the UEFI emulator on bare metal is not going to scale.
> Cloning UART driver code and MMU code etc is a can of worms that you
> want to leave closed. And as Lennart points out, there is other
> hardware (TPM) that needs to be accessible as well. Providing a
> separate set of drivers for all hardware that the EFI emulator may
> need to access is not a tractable problem either.
> 
> The fix for this, as I see it, is to run the EFI emulator in user
> space, to the point where the payload calls ExitBootServices(). This
> will allow all I/O and memory protocol to be implemented trivially,
> using C library routines. I have a crude prototype** of this running
> to the point where ExitBootServices() is called (and then it crashes).
> The tricky yet interesting bit here is how we migrate a chunk of user
> space memory to the bare metal context that will be created by the
> kexec syscall later (in which the call to ExitBootServices() would
> return and proceed with the boot). But the principle is rather
> straight-forward, and would permit us, e.g., to kexec an OS installer
> too.

I mostly agree on what you have wrote. But I see a big problem in
running the EFI emulator in user space when it comes to secure boot.
The chain of trust ends in the kernel. So it's the kernel that needs to
verify that the image to be loaded can be trusted. But when the EFI
runtime is in user space the kernel simply cannot do that. Which means,
if we want to go this way, we would need to extend the chain of trust
to user space. Which will be a whole bucket of worms, not just a can.

That's why I tend more to Jan's suggestion to include the EFI runtime
in the kernel. Alas, that comes with it's own problem, as that requires
to run code in the kernel that was never intended to run in kernel
context. So even when we can trust the code not to be malicious, we
cannot trust it to not accidentally change the system state in a way
the kernel doesn't expect...

Let me throw an other wild idea in the ring. Instead of implementing
a EFI runtime we could also include a eBPF version of the stub into the
images. kexec could then extract the eBPF program and let it run just
like any other eBPF program with all the pros (and cons) that come with
it. That won't be as generic as the EFI runtime, e.g. you couldn't
simply kexec any OS installer. On the other hand it would make it
easier to port UKIs et al. to non-EFI systems. What do you think?

Thanks
Philipp

> 3. We need to figure out how to support TPM and PCRs in the context of
> kexec. This is a fundamental issue with verified boot, given that the
> kexec PCR state is necessarily different from the boot state, and so
> we cannot reuse the TPM directly if we want to pretend that we are
> doing an ordinary boot in kexec. The alternative is to leave the TPM
> in a state where the kexec kernel can access its sealed secrets, and
> mock up the TCG2 EFI protocols using a shim that sits between the TPM
> hardware (as the real TCG2 protocols will be long gone) and the EFI
> payload. But as I said, this is a fundamental issue, as the ability to
> pretend that a kexec boot is a pristine boot would mean that verified
> boot is broken.
> 
> 
> As future work, I'd like to propose to collaborate on some alignment
> regarding a UEFI baseline for Linux, i.e., the parts that we actually
> need to boot Linux.
> 
> For this series in particular, I don't see a way forward where we
> adopt this approach, and carry all this code inside the kernel.
> 
> Thanks.
> Ard.
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

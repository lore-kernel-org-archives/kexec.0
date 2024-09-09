Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6FAECE57A
	for <kexec@archiver.kernel.org>; Mon,  9 Sep 2024 14:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6SFrej3gUlv3+FWrotv5JTJ+yxgpWrlUWYUx3Jh9wzk=; b=tGmhnqxqxgY4dQ
	K6xZnplt7yf9fkrYP3WSDmmPQpg025FbAoT6JhKYMGMG606XRGRFin3QuPxyUEo4S4lyQudlGQvt6
	wzs/Z99DWML8dLgJNiCjOdsnbcMxq4R2myHXWW5zjRYmVOQcrkSz+cz0t3MN+Kx6vF7Rwd53XpHGd
	G3XV6dpDlvxsMeiz61VxFswHmUt6M29N3hsX9Y66MX5D/mse/p9x9t3fjiX2Cbe4w9Z5lftXeNuUs
	Ujs4NJHDXP4SDOhotEYO3G3EOoTZbPar9/LeMaNImJqoqEC28WlQgNwibAyjTCWhmSyuryCTCAvW4
	MHJfdhIDDbFfaUL2chnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snf9d-00000002EE4-0vRf;
	Mon, 09 Sep 2024 14:14:09 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snf0q-00000002CVz-3hiL
	for kexec@lists.infradead.org;
	Mon, 09 Sep 2024 14:05:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4A160A43BFE
	for <kexec@lists.infradead.org>; Mon,  9 Sep 2024 14:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B2CC4CEC7
	for <kexec@lists.infradead.org>; Mon,  9 Sep 2024 14:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725890703;
	bh=39t/3qJV4Q2JW5H0rZSfS2mJT51lZ2xxZvskNVI7R9o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Lk2Gj73FjiSiEZus3uC7mkNG4XywWqQ7NR0y3ikap2Q+6o++ADr1PK8l7VSXdhcsQ
	 NrMbhgAEtgUEC99n6rRBm5+kaHpo5Mop5C3UcgHmG1YsEOqL8UYNP7ne3w/YGnDQab
	 VN2eyxke+dnFp1KjS1Bft2bKSut8sTHIM/gKDNpyMWTR06KGjTm7cd6TRZIv/S93Ob
	 jN3iD2WphAFVmr+r3zIFplnxxY0ChXDhTvmCHR04xg+fxiKIEf9BFe24MzKGHEKKNm
	 zzvs+TMo+CjJxcZP5R8dUsyksaRN9X8bPXbOQandqBAkMMmORoo12ZNGx4OZ/M/+fG
	 FpucO2WUCsqDw==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f75428b9f8so29495761fa.3
        for <kexec@lists.infradead.org>; Mon, 09 Sep 2024 07:05:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrcUGDJeqKx6gAbl07HRA3UjFIbDkjaeUZzbseUESSpm4x0qVsiLTZKXWhngZVskJOSmyfFg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx1yLIzN0NOmx6+Jxxptc/i4h8t2IE2OLg+ePOJJ76VDQsV9T87
	DqQPOhcDv5i0yKco+lWy/kmVkc8ud3vccMGTXwmTIXMCPgs0E1kLpOwlJYkTrG1Pi6iYiI1ruvt
	gQmezT8RdxJEROhVAXXi3QH7QHaA=
X-Google-Smtp-Source: AGHT+IEJTNfHR7krKocDudQJXBZne2qOZFYCOAl5tMDGgePisWMZ4797/twUNPb5n/v9GxwDhTtOYhmZyMfcyRmybBY=
X-Received: by 2002:a05:6512:1283:b0:536:553f:a6e7 with SMTP id
 2adb3069b0e04-536587c7fe0mr10827543e87.32.1725890701674; Mon, 09 Sep 2024
 07:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com> <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
 <20240906125438.1e54c5f6@rotkaeppchen> <Zt7EbvWjF9WPCYfn@gardel-login>
 <Zt7RJepoCiCMRZSu@archlinux> <20240909154940.7ab93782@rotkaeppchen>
In-Reply-To: <20240909154940.7ab93782@rotkaeppchen>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 9 Sep 2024 16:04:50 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHN5NgUJ+wwaZxsKeT4bDHqO6C2CHaALAi7JV5hWVmR2A@mail.gmail.com>
Message-ID: <CAMj1kXHN5NgUJ+wwaZxsKeT4bDHqO6C2CHaALAi7JV5hWVmR2A@mail.gmail.com>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
To: Philipp Rudo <prudo@redhat.com>
Cc: Jan Hendrik Farr <kernel@jfarr.cc>, Lennart Poettering <mzxreary@0pointer.de>, 
	Pingfan Liu <piliu@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240909_070505_084966_8285AC5B 
X-CRM114-Status: GOOD (  69.16  )
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

On Mon, 9 Sept 2024 at 15:49, Philipp Rudo <prudo@redhat.com> wrote:
>
> Hi Lennart,
> Hi Jan,
>
> On Mon, 9 Sep 2024 12:42:45 +0200
> Jan Hendrik Farr <kernel@jfarr.cc> wrote:
>
> > On 09 11:48:30, Lennart Poettering wrote:
> > > On Fr, 06.09.24 12:54, Philipp Rudo (prudo@redhat.com) wrote:
> > >
> > > > I mostly agree on what you have wrote. But I see a big problem in
> > > > running the EFI emulator in user space when it comes to secure boot.
> > > > The chain of trust ends in the kernel. So it's the kernel that needs to
> > > > verify that the image to be loaded can be trusted. But when the EFI
> > > > runtime is in user space the kernel simply cannot do that. Which means,
> > > > if we want to go this way, we would need to extend the chain of trust
> > > > to user space. Which will be a whole bucket of worms, not just a
> > > > can.
> > >
> > > May it would be nice to have a way to "zap" userspace away, i.e. allow
> > > the kernel to get rid of all processes in some way, reliable. And then
> > > simply start a new userspace, from a trusted definition. Or in other
> > > words: if you don't want to trust the usual userspace, then let's
> > > maybe just terminate it, and create it anew, with a clean, pristine
> > > definition the old userspace cannot get access to.
> >
> > Well, this is an interesting idea!
> >
> > However, I'm sceptical if this could be done in a secure way. How do we
> > ensure that nothing the old userspace did with the various interfaces to
> > the kernel has no impact on the new userspace? Maybe others can chime in
> > on this? Does kernel_lockdown give more guarantees related to this?
> >
> > Even if this is possible in a secure way, there is a problem with doing
> > this for kernels that are to be kexec'd on kernel panic. In this
> > approach we can't pre-run them until EBS(), so we would rely on the old
> > kernel to still be intact when we want to kexec reboot.
>
> I don't believe there's a way to do that on running kernels. As Jan
> pointed out, this cannot be done during reboot, as for kdump that would
> mean to run after a panic. So it would need to run when the new image
> is loaded. But at that time your user space is running. Plus you also
> always have a user space component that triggers kexec. So you cannot
> simply "zap" user space but have to somehow stash it away, run your
> trusted user space and, then restore the old user space again. That
> sounds pretty error prone to me. Plus it will tank your performance
> every time you do a kexec, which for kdump is every boot...
>

kdump has a kexec kernel 'standby' to launch when the kernel panics.
So for the UKI/EFI payload case, this would imply that the load
involves running the payload until EBS() and freezing the state.

Whether execution occurs in true user space or in a deprivileged
kernel context is an implementation detail, imho. We don't want to run
external code in privileged mode inside the kernel in any case, as
this would violate lockdown already. But it should be feasible to have
a EFI compatible layer in the kernel that invokes the EFI entrypoint
of an image in a way that protects the host kernel. This could be user
mode on the CPU or perhaps a minimal KVM virtual machine.

The advantage of this approach is that the whole concept of purgatory
can be avoided - the EFI boot phase runs in parallel with the previous
kernel, which has full control over authentication and [emulated] PCR
externsion, and has ultimate control over whether the kexec reboot is
permitted.

> > You could do a system where you kexec into an intermediate kernel. That
> > kernel get's kexec'd with a signed initrd that can use the normal
> > kexec_load syscall to load do any kind of preparation in userspace.
> > Problem: For that intermediate enviroment we already need a format
> > that combines kernel image, initrd, cmdline all signed in one package
> > aka UKI. Was it the chicken or the egg?
> >
> > But this shows that if we implemented UKIs the easy way (kernel simply
> > checks signature, extracts the pieces, and kexecs them like normal),
> > this approach could always be used to support kexec for other future
> > formats. They could use the kernels UKI support to boot into an
> > intermediate kernel with UEFI implemented in userspace in the initrd.
> >
> > So basically support UKIs the easy way and use them to be able to
> > securely zap away userspace and start with a fresh kernel and signed
> > userspace as a way to support other UEFI formats that are not UKI.
>
> Well, in theory that should work. But I see several problems:
>
> 1) How does the first kernel tell the intermediate kernel which
> file(s) with wich command line to load? In fact, how does the first
> kernel get the information itself? You would need a new system call
> that takes two kernel images, one for the intermediate and one for the
> kernel to load,for that.
>
> Of course you could also build the intermediate UKI during kernel build
> and include it into the image. Similar to what is done with the
> purgatory. But that would totally bloat the kernel image.
>
> 2) I expect that to be extremely painful to debug, if the intermediate
> kernel runs into a panic. For sure kdump won't work in that case...
>
> 3) Distros would need maintain and test the additional UKI.
>
> 4) This approach basically needs to boot twice. But there are people
> out there who fight to reduce boot times extremely hard. For them every
> millisecond counts. Telling them that they will need to wait twice as
> long will be very hard to sell.
>

I don't think intermediate kernels are the solution here. We need to
run as much as possible under the control of the preceding kernel, and
minimize the bare metal handover that occurs after EBS(). Adding more
code to the purgatory (as this series does) is not acceptable to me,
as it is extremely difficult to debug, and duplicates drivers and
other logic (making it an 'intermediate kernel' of sorts already)

> > >
> > > > Let me throw an other wild idea in the ring. Instead of implementing
> > > > a EFI runtime we could also include a eBPF version of the stub into the
> > > > images. kexec could then extract the eBPF program and let it run just
> > > > like any other eBPF program with all the pros (and cons) that come with
> > > > it. That won't be as generic as the EFI runtime, e.g. you couldn't
> > > > simply kexec any OS installer. On the other hand it would make it
> > > > easier to port UKIs et al. to non-EFI systems. What do you think?
> > >
> > > ebpf is not turing complete, I am not sure how far you will make it
> > > with this, in the various implementations of EFI payloads there are
> > > plenty of loops, sometimes IO loops, sometimes hash loops of huge data
> > > (for measurements). As I understand ebpf is not really compatible such
> > > code.
>
> I don't believe we can simply take all those payloads and recompile
> them to eBPF. There definitely needs to be some refactoring done first.
> For example the IO loops you can drop for eBPF and simply map to the
> corresponding kernel function, letting them do the full IO in one go.
> There will be cases where that will be more difficult like for hash
> loops when you have to have the same hash at the end. But I believe
> even for that ways could be found to get it to work.
>
> Anyway, I'm sure that the picture I have in my head is way
> oversimplified. There will be many pitfalls to handle for sure. Still I
> believe it would be a nice experiment.
>

Today, UKI functionality is implemented in terms of EFI API calls. Any
solution that needs either a parallel implementation (eBPF vs EFI) or
needs to unpack the UKI in order to perform the steps that the UKI
would perform itself if it were executed in an EFI environment is a
no-go in my opinion.

So either we provide some EFI compatible runtime sufficient to run a
UKI, or we re-engineer UKI to be built on top of an abstraction that
can be implemented straight-forwardly both on system firmware and in
the EFI context.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

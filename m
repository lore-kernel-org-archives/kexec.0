Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D77CEDD9B
	for <kexec@archiver.kernel.org>; Wed,  9 Oct 2024 14:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R3Jb5uO/kgjJkmz91XqhBzo0gz+h/PU8FM7gFcfpkV8=; b=G4EkLWvrmPi5qT
	U0ibUC/XW9riSrT19Xat89cGHal6zDI7aa/ciNywlslXO5Sw764Ulj1Wh5cChsLqzm589qxnNunU/
	IMLPlbbWxg7H5qWDNNUwv/LSLog+3JULn6Z1DDaJc2doUACioRb96ocxI/XmDLWUXR0F/CJOXOmPD
	R9IteKabV+tMK2Q3M0Jr2M3qkGaRM9Cl3aPSAUDcm8HZGobrzu73Ze6aNS7duZuw93wX0N9MhqhEX
	KMDw/trKSk0g//hxIN5ZOQ6cc7kEiRvfIlAHrRDB3SCRoPcw0qKFoZIhU+d4hejPa+OCfrqzwecuF
	OOoO2G8PINRqeYIK7gbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syXRr-00000009Y6x-12rs;
	Wed, 09 Oct 2024 14:13:55 +0000
Received: from the.earth.li ([2a00:1098:86:4d:c0ff:ee:15:900d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syXJm-00000009WVp-0UhE
	for kexec@lists.infradead.org;
	Wed, 09 Oct 2024 14:05:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=i1QThVF8dGkG2MCAzs0bja3ZVNDTNwm3Axl492fNNQY=; b=FkSzYKLdsa0heLdvcU+riirsHk
	5ldUDp/FP484xNSeeztScBp45hUlq+ZRp+wFFrY3fB9dYaTM5pKpFhP6/ewD76V3QCwv8/JvJhEcV
	om5c+iz9GUHRUQ6ay9DhFugwZqTha4QeyBYGvqhXtxqQ43eA8REg+8FQxcl6iCLgZG6DTbw2pbPpn
	SFH1YTPoJgRJqhFEa/6r4L0RTtxQQ5kDFJqWu4UxdQBeiVutp3cGLMmTuQ917o4vJKXyQVU8sPFgz
	5ls/1NhgvclwdaR8wH0J0ZoZI7bvsFNbvFe5rwZ3l6XpnzVaEomulvUec2qCSZkmJC/3xpxeRPtNh
	ThsOA9oA==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1syXJa-003F6L-2V;
	Wed, 09 Oct 2024 15:05:22 +0100
Date: Wed, 9 Oct 2024 15:05:22 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Breno Leitao <leitao@debian.org>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Usama Arif <usamaarif642@gmail.com>, linux-efi@vger.kernel.org,
	kexec@lists.infradead.org, bhe@redhat.com, vgoyal@redhat.com,
	tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
	linux-kernel@vger.kernel.org, rmikey@meta.com, gourry@gourry.net,
	linux-integrity@vger.kernel.org
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in
 820_table_firmware
Message-ID: <ZwaNorA0hUhdQ8ji@earth.li>
References: <20240913-careful-maroon-crab-8a0541@leitao>
 <5c525fe8f33fffebc0d275086cc7484e309dfae0.camel@HansenPartnership.com>
 <87o74n5p05.fsf@email.froward.int.ebiederm.org>
 <CAMj1kXF7EohKai9nyxSnvu32KNdUcNZxxP69Sz-vUZ-6nmvekg@mail.gmail.com>
 <874j6e482p.fsf@email.froward.int.ebiederm.org>
 <CAMj1kXEa4DSY8omHGhoTK0U5isvK2G-PJO9go-QK_Mzny=g6ow@mail.gmail.com>
 <87setx3b8l.fsf@email.froward.int.ebiederm.org>
 <CAMj1kXHtNrsdsHQWMXrq9jAyzxEJnTW0M7-OEA0kpb3KS2cZ=w@mail.gmail.com>
 <ZwZIoQobJrltBpTX@earth.li>
 <20241009-feathered-polar-manul-ea6e33@leitao>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241009-feathered-polar-manul-ea6e33@leitao>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_070534_270755_85DC36F0 
X-CRM114-Status: GOOD (  43.11  )
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

On Wed, Oct 09, 2024 at 03:46:32AM -0700, Breno Leitao wrote:
> On Wed, Oct 09, 2024 at 10:10:57AM +0100, Jonathan McDowell wrote:
> > On Wed, Sep 18, 2024 at 09:36:06AM +0200, Ard Biesheuvel wrote:
> > > On Wed, 18 Sept 2024 at 05:14, Eric W. Biederman <ebiederm@xmission.com> wrote:
> > > > Ard Biesheuvel <ardb@kernel.org> writes:
> > > > > On Tue, 17 Sept 2024 at 17:24, Eric W. Biederman <ebiederm@xmission.com> wrote:
> > > > >> Ard Biesheuvel <ardb@kernel.org> writes:
> > 
> > > > >> This should not be the kexec-on-panic kernel as that runs in memory
> > > > >> that is reserved solely for it's own use.  So we are talking something
> > > > >> like using kexec as a bootloader.
> > > > >
> > > > > kexec as a bootloader under TPM based measured boot will need to do a
> > > > > lot more than pass the firmware's event log to the next kernel. I'd
> > > > > expect a properly engineered kexec to replace this table entirely, and
> > > > > include the hashes of the assets it has loaded and measured into the
> > > > > respective PCRs.
> > > > >
> > > > > But let's stick to solving the actual issue here, rather than
> > > > > philosophize on how kexec might work in this context.
> > > >
> > > > I am fine with that.  The complaint I had seen was that the table was
> > > > being corrupted and asking how to solve that.  It seems I haven't read
> > > > the part of the conversation where it was made clear that no one wants
> > > > the tpm_log after kexec.
> > > >
> > > It was not made clear, that is why I raised the question. I argued
> > > that the TPM log has limited utility after a kexec, given that we will
> > > be in one of two situations:
> > > - the kexec boot chain cares about the TPM and measured boot, and will
> > > therefore have extended the TPM's PCRs and the TPM log will be out of
> > > sync;
> > > - the kexec boot chain does not care, and so there is no point in
> > > forwarding the TPM log.
> > > 
> > > Perhaps there is a third case where kdump wants to inspect the TPM log
> > > that the crashed kernel accessed? But this is rather speculative.
> > 
> > Generally the kernel/host OS and the firmware are touching different
> > PCRs in the TPM.
> > 
> > The firmware eventlog covers what the firmware/bootloader measured;
> > itself, option ROMs, secure boot details, bootloader, initial
> > kernel/initrd (if we're talking grub as the initial bootloader). These
> > details are not changed by a kexec, and provide the anchor of the
> > software trust chain.
> > 
> > A kexec'd kernel will generally not touch the same PCRs. The primary way
> > I know to carry kexec measurements / logs over to new kernels is using
> > IMA, which will be configured to use one of the later PCRs (default of
> > 10).
> 
> What about in the case where you don't have Grub, but, use the kernel as
> the bootloader, kexecing into the desired kernel?
> 
> Will the bootloader-kernel touch the same PCRs as GRUB, or it will only
> touch PCRs above 10?

A kernel kexecing into another will generally use IMA if it wants to
measure into the TPM, which will use PCR 10 by default and not conflict
with the firmware PCRs (and you then use the IMA integrity log, which is
passed over a kexec, to work out the kexec side of things).

You still need the firmware event log in that case because the
"bootloader" kernel combo you load is measured into the TPM by the
firmware.

You _could_ technically configure things up to re-use some of the
firmware PCRs, but it generally wouldn't make a lot of sense to do so
and I've not seen any examples of that sort of configuration.

J.

-- 
101 things you can't have too much of : 41 - Tea.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

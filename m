Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552B2CAC5B2
	for <kexec@archiver.kernel.org>; Wed, 18 Sep 2024 03:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:
	In-Reply-To:Date:References:Cc:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=s+z9W7zkfvo0WqXbbYgJo9Qhy1XOU/Ewfsn9/H5bSDw=; b=Pdnq1t1ZuS9XgfrfhywD6yjYcm
	2l2c8OWWujVT62MocgcYePdPd5mHWAeFoNE92eOrxo0P6o6nmO5lSQ55wp2kivSoi+LiR0KdLF8Na
	NfWUlEjF4Vrz6Mm+aWzx3emUjtXU95joAtRPEiBC8bKMK53IoQGLlz4eTqn7/WCI3qE30BsqNb+9q
	dfepcyRfcG5GB8FAsoYULAtmZhox9nYXFQgRUIl6goynSqJgz8WpqUWlnTztWLmibqIt8p47WjTjr
	nT8xbWzZFhD9oprGc8mVsyBFDHE/hr2mhy/vDYdkLs6/z8ZL4huelALKv87EFqNXLyGuKUrdoGUkB
	Awlc1neg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sql8z-00000007MlH-3L77;
	Wed, 18 Sep 2024 03:14:17 +0000
Received: from out03.mta.xmission.com ([166.70.13.233])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sql8w-00000007Miy-2Xse
	for kexec@lists.infradead.org;
	Wed, 18 Sep 2024 03:14:15 +0000
Received: from in01.mta.xmission.com ([166.70.13.51]:34848)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sql8d-004Anw-KA; Tue, 17 Sep 2024 21:13:55 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:41268 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sql8c-005NV4-DJ; Tue, 17 Sep 2024 21:13:55 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,  Breno Leitao
 <leitao@debian.org>,  Usama Arif <usamaarif642@gmail.com>,
  linux-efi@vger.kernel.org,  kexec@lists.infradead.org,  bhe@redhat.com,
  vgoyal@redhat.com,  tglx@linutronix.de,  dave.hansen@linux.intel.com,
  x86@kernel.org,  linux-kernel@vger.kernel.org,  rmikey@meta.com,
  gourry@gourry.net
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
	<CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
	<2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com>
	<CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
	<20240912-wealthy-gabby-tamarin-aaba3c@leitao>
	<d9df5012cd3306afa2eddd5187e643a3bbdfd866.camel@HansenPartnership.com>
	<20240913-careful-maroon-crab-8a0541@leitao>
	<5c525fe8f33fffebc0d275086cc7484e309dfae0.camel@HansenPartnership.com>
	<87o74n5p05.fsf@email.froward.int.ebiederm.org>
	<CAMj1kXF7EohKai9nyxSnvu32KNdUcNZxxP69Sz-vUZ-6nmvekg@mail.gmail.com>
	<874j6e482p.fsf@email.froward.int.ebiederm.org>
	<CAMj1kXEa4DSY8omHGhoTK0U5isvK2G-PJO9go-QK_Mzny=g6ow@mail.gmail.com>
Date: Tue, 17 Sep 2024 22:13:30 -0500
In-Reply-To: <CAMj1kXEa4DSY8omHGhoTK0U5isvK2G-PJO9go-QK_Mzny=g6ow@mail.gmail.com>
	(Ard Biesheuvel's message of "Tue, 17 Sep 2024 17:35:20 +0200")
Message-ID: <87setx3b8l.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1sql8c-005NV4-DJ;;;mid=<87setx3b8l.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+kvMZT12Ifk9zEW+PAKwuz6Tn0dqFT3Ew=
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in
 820_table_firmware
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: gourry@gourry.net, rmikey@meta.com, linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de, vgoyal@redhat.com, bhe@redhat.com, kexec@lists.infradead.org, linux-efi@vger.kernel.org, usamaarif642@gmail.com, leitao@debian.org, James.Bottomley@hansenpartnership.com, ardb@kernel.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240917_201414_680796_56DA1F5D 
X-CRM114-Status: GOOD (  55.69  )
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

Ard Biesheuvel <ardb@kernel.org> writes:

> On Tue, 17 Sept 2024 at 17:24, Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Ard Biesheuvel <ardb@kernel.org> writes:
>>
>> > Hi Eric,
>> >
>> > Thanks for chiming in.
>>
>> It just looked like after James gave some expert input the
>> conversation got stuck, so I am just trying to move it along.
>>
>> I don't think anyone knows what this whole elephant looks like,
>> which makes solving the problem tricky.
>>
>> > On Mon, 16 Sept 2024 at 22:21, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> >>
> ...
>> >>
>> >> This leaves two practical questions if I have been following everything
>> >> correctly.
>> >>
>> >> 1) How to get kexec to avoid picking that memory for the new kernel to
>> >>    run in before it initializes itself. (AKA the getting stomped by
>> >>    relocate kernel problem).
>> >>
>> >> 2) How to point the new kernel to preserved tpm_log.
>> >>
>> >>
>> >> This recommendation is from memory so it may be a bit off but
>> >> the general structure should work.  The idea is as follows.
>> >>
>> >> - Pass the information between kernels.
>> >>
>> >>   It is probably simplest for the kernel to have a command line option
>> >>   that tells the kernel the address and size of the tpm_log.
>> >>
>> >>   We have a couple of mechanisms here.  Assuming you are loading a
>> >>   bzImage with kexec_file_load you should be able to have the in kernel
>> >>   loader to add those arguments to the kernel command line.
>> >>
>> >
>> > This shouldn't be necessary, and I think it is actively harmful to
>> > keep inventing special ways for the kexec kernel to learn about these
>> > things that deviate from the methods used by the first kernel. This is
>> > how we ended up with 5 sources of truth for the physical memory map
>> > (EFI memory map, memblock and 3 different versions of the e820 memory
>> > map).
>> >
>> > We should try very hard to make kexec idempotent, and reuse the
>> > existing methods where possible. In this case, the EFI configuration
>> > table is already being exposed to the kexec kernel, which describes
>> > the base of the allocation. The size of the allocation can be derived
>> > from the table header.
>> >
>> >> - Ensure that when the loader is finding an address to load the new
>> >>   kernel it treats the address of the tpm_log as unavailable.
>> >>
>> >
>> > The TPM log is a table created by the EFI stub loader, which is part
>> > of the kernel. So if we need to tweak this for kexec's benefit, I'd
>> > prefer changing it in a way that can accommodate the first kernel too.
>> > However, I think the current method already has that property so I
>> > don't think we need to do anything (modulo fixing the bug)
>>
>> I am fine with not inventing a new mechanism, but I think we need
>> to reuse whatever mechanism the stub loader uses to pass it's
>> table to the kernel.  Not the EFI table that disappears at
>> ExitBootServices().
>>
>
> Not sure what you mean here - the EFI table that gets clobbered by
> kexec *is* the table that is created by the stub loader to pass the
> TPM log to the kernel. Not sure what alternative you have in mind
> here.

I was referring to whatever the EFI table that James Bottomley mentioned
that I presume the stub loader reads from when the stub loader
constructs the tpm_log that is passed to the kernel.

So I believe we are in agreement of everything except terminology.

>> > That said, I am doubtful that the kexec kernel can make meaningful use
>> > of the TPM log to begin with, given that the TPM will be out of sync
>> > at this point. But it is still better to keep it for symmetry, letting
>> > the higher level kexec/kdump logic running in user space reason about
>> > whether the TPM log has any value to it.
>>
>> Someone seems to think so or there would not be a complaint that it is
>> getting corrupted.
>>
>
> No. The problem is that the size of the table is *in* the table, and
> so if it gets corrupted, the code that attempts to memblock_reserve()
> it goes off into the weeds. But that does not imply there is a point
> to having access to this table from a kexec kernel in the first place.

If there is no point to having access to it then we should just not
pass anything to the loaded kernel, so the kernel does not think there
is anything there.

>> This should not be the kexec-on-panic kernel as that runs in memory
>> that is reserved solely for it's own use.  So we are talking something
>> like using kexec as a bootloader.
>>
>
> kexec as a bootloader under TPM based measured boot will need to do a
> lot more than pass the firmware's event log to the next kernel. I'd
> expect a properly engineered kexec to replace this table entirely, and
> include the hashes of the assets it has loaded and measured into the
> respective PCRs.
>
> But let's stick to solving the actual issue here, rather than
> philosophize on how kexec might work in this context.


I am fine with that.  The complaint I had seen was that the table was
being corrupted and asking how to solve that.  It seems I haven't read
the part of the conversation where it was made clear that no one wants
the tpm_log after kexec.

If someone wants the tpm_log then we need to solve this problem.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB90E9A04C
	for <kexec@archiver.kernel.org>; Thu, 19 Feb 2026 07:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ct7M2EnEqPGJaoxw/b/Bb/bf4YYJesdPbL3unDpHoUI=; b=IEXUC+BnRe3zmYFL1s9zlrpeai
	y3g6xzQ7zLFmBCFxFCRqzUmblax5dPI0VT/m3UM4ZUbJl7vYfNoTp11AtHBR4IzwVm0jFV9gbpp+1
	P3lgOhuUIKYHp5Xg5V0u1Qb/jIvBPZX6ys6ngaEkgFGAqD9sZllkRrIs7+J5k3UbBQWdyZERxf6ru
	HE4aLIRYEko6Doa2Dy4NGjuDXGsmou/wiIOi+qhJ7qJ8CALYbT7Y1CWKLCVKLlns/SqOMX1kDldP/
	QWiXBoVyx/BhDwGTnSuVQ3fD/h+foDYahm6oFzdHv+a1juvE0/ADsRpZPFyAr8FJQQIPFuV2ZqEST
	u6Ioy8AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsysd-0000000B52b-3a9y;
	Thu, 19 Feb 2026 07:55:23 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsysa-0000000B521-03Sf
	for kexec@lists.infradead.org;
	Thu, 19 Feb 2026 07:55:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 508EC6186A;
	Thu, 19 Feb 2026 07:55:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1EFC4AF09;
	Thu, 19 Feb 2026 07:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771487718;
	bh=pzbK4/brNz010auB9728EGVQiHeaL9TguEYVSzMvosk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=N4iaJjTwhPsUSIw/0tVqi0Wuaonzo3KM0NGXPNmfYCWl/cGhFtueCK/+728B4GUrL
	 TMh2PycyFWg34db12zB4FGynt9FkyWu9PRfK3CddxE1kwHAGS64sjh4LxW7dUDDmXe
	 GKSJ69RqbDsPxrIm9smqPMOYgaaKz/sHVczqc4w73FExob5B2Dlg4kWeA6dSUJagmr
	 3S+/GlR/lmfBderEx8n8/mSdHoUajuBoNIvGcbcNcBPbF+iMmTGZxswmhxn4o1tTNx
	 L1htvApQDN33C7pWQi2wXMCJwBJKPrIqpqxWyPVHa2H3sp/f6XnSLivaUO+nCMt0Zr
	 jzyW4tlAgp1RA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 45BADF40069;
	Thu, 19 Feb 2026 02:55:16 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Thu, 19 Feb 2026 02:55:16 -0500
X-ME-Sender: <xms:5MGWaZRKE8Ruz9fmbEYmk4H5lzQ5-zRr0MuEO5P_F1JZbXi2RRQQVw>
    <xme:5MGWadmMNsXduT7E6Uq7nJrZlvJGIKzKb0uP1G7Mm8OQTWCPS2UHYIdt-d33U6EMd
    FfV1NELxawXYk4V9niOQusN5kHnJlgqxxCCnnFv-RN44MsM_JWpxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdegleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpeeuteeiudeigeekjedvheduieehteetgfdtuefghfejgffhfedtleehvdeh
    fffhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeefvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepnhhivhgvughithgrsegrlh
    humhdrmhhithdrvgguuhdprhgtphhtthhopehluhhtohesrghmrggtrghpihhtrghlrdhn
    vghtpdhrtghpthhtohepughpshhmihhthhesrghpvghrthhushhsohhluhhtihhonhhsrd
    gtohhmpdhrtghpthhtoheprghnughrvgifrdgtohhophgvrhefsegtihhtrhhigidrtgho
    mhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoh
    epphgvthgvrhhhuhgvfigvsehgmhigrdguvgdprhgtphhtthhopehhvghrsggvrhhtsehg
    ohhnughorhdrrghprghnrgdrohhrghdrrghupdhrtghpthhtohepthhrvghntghhsghooh
    htqdguvghvvghlsehgohhoghhlvghgrhhouhhpshdrtghomh
X-ME-Proxy: <xmx:5MGWaQrTlO_H0Mob2v0oWSZhVnKE8GIcS6zblXO65tnvCJ3av6UZNQ>
    <xmx:5MGWaUDOsEcd6Q_bO1fv6si6ilfGp8v83nBXZtXvrrhjJ2KETt4_DQ>
    <xmx:5MGWaRNGd9fZiWxwtbMd7y2HQ3BNt-5qTsLDnKh-FIGdB3_3jHJ78w>
    <xmx:5MGWablqDJwvTtmFQIOQi068xLRNpmuck6JGsQ0R88Dp_ysIgeXKGA>
    <xmx:5MGWabfyU6Y_VYhL-tFs7ATSMD5qvQp-YyUSitnmKMnFHbLkkIJE9i1g>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0E84D700065; Thu, 19 Feb 2026 02:55:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AAnEvm6syrbF
Date: Thu, 19 Feb 2026 08:54:55 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Andy Lutomirski" <luto@amacapital.net>, "Simo Sorce" <simo@redhat.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>,
 "Daniel P. Smith" <dpsmith@apertussolutions.com>,
 "Ross Philipson" <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev,
 dave.hansen@linux.intel.com, "Thomas Gleixner" <tglx@linutronix.de>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, "Jarkko Sakkinen" <jarkko@kernel.org>, jgg@ziepe.ca,
 nivedita@alum.mit.edu, "Herbert Xu" <herbert@gondor.apana.org.au>,
 davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
 dwmw2@infradead.org, baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Message-Id: <558d0f28-01fb-4447-891c-2ffbf869c077@app.fastmail.com>
In-Reply-To: <CALCETrUMR0RvOFXGzL7=F4c-3veL+1Sm2xf-BprHTK4=UKw8yA@mail.gmail.com>
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <b5f2b5a5-b984-4ed3-a023-c06d634f9146@app.fastmail.com>
 <1ffd3cb5-2c76-4371-a067-3e4849907d80@apertussolutions.com>
 <49d169bf-0ad2-49be-b7d7-fceb9e7f831a@app.fastmail.com>
 <CALCETrUE8c-dxRWhtHKz_PojwZuWMXJSzOsFQf2vt5LS3ATwpA@mail.gmail.com>
 <1BBD7449-8420-43FD-930B-A4E1BA38FFC6@zytor.com>
 <CALCETrWzG1Mjb-RcwLQ5-tGFZ15WKHjZbqtLvyif+UPuVKJ_5g@mail.gmail.com>
 <32e62cef7b89d9691bdd4120388ce752fd041230.camel@redhat.com>
 <CALCETrUMR0RvOFXGzL7=F4c-3veL+1Sm2xf-BprHTK4=UKw8yA@mail.gmail.com>
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 18 Feb 2026, at 22:54, Andy Lutomirski wrote:
> On Wed, Feb 18, 2026 at 1:04=E2=80=AFPM Simo Sorce <simo@redhat.com> w=
rote:
>>
>> On Wed, 2026-02-18 at 12:34 -0800, Andy Lutomirski wrote:
>> > On Wed, Feb 18, 2026 at 12:29=E2=80=AFPM H. Peter Anvin <hpa@zytor.=
com> wrote:
>> > >
>> > > On February 18, 2026 12:03:27 PM PST, Andy Lutomirski <luto@amaca=
pital.net> wrote:
>> > > > On Thu, Feb 12, 2026 at 12:40=E2=80=AFPM Ard Biesheuvel <ardb@k=
ernel.org> wrote:
>> > > > >
>> > > > > On Thu, 12 Feb 2026, at 20:49, Daniel P. Smith wrote:
>> > > > > > On 2/9/26 09:04, Ard Biesheuvel wrote:
>> > > > > ...
>> > > > > But would it be better to disable the runtime services by def=
ault when doing a secure launch? PREEMPT_RT already does the same.
>> > > >
>> > > > So I have a possible way to disable EFI runtime service without=
 losing
>> > > > the ability to write EFI vars.  We come up with a simple file f=
ormat
>> > > > to store deferred EFI var updates and we come up with a place t=
o put
>> > > > it so that we find it early-ish in boot the next time around.  =
(This
>> > > > could be done via integration with systemd-boot or shim some ot=
her
>> > > > boot loader or it could actually be part of the kernel.)  And t=
hen,
>> > > > instead of writing variables directly, we write them to the def=
erred
>> > > > list and then update them on reboot (before TXT launch, etc).  =
[0]
>> > > > This would be a distincly nontrivial project and would not work=
 for
>> > > > all configurations.
>> > > >
>> > > > As a maybe less painful option, we could disable EFI runtime se=
rvices
>> > > > but have a root-writable thing in sysfs that (a) turns them bac=
k on
>> > > > but (b) first extends a PCR to say that they're turned back on.
>> > > >
>> > > > (Or someone could try running runtime services at CPL3...)
>> > > >
>> > > > [0] I have thought for years that Intel and AMD should do this =
on
>> > > > their end, too.  Keep the sensitive part of SMI flash entirely =
locked
>> > > > after boot and, instead of using magic SMM stuff to validate th=
at
>> > > > write attempts have the appropriate permissions and signatures,=
 queue
>> > > > them up as deferred upates and validate the signatures on the n=
ext
>> > > > boot before locking flash.
>> > > >
>> > >
>> > > *If* a physical EFI partition exists there is a lot to be said fo=
r this approach.
>> > >
>> > > The only issue with this that I can see is for things like networ=
k or CD/DVD booting where there isn't necessarily any EFI boot partition=
, it might not be writable, or it might not be persistent (e.g. http boo=
ting typically uses a ramdisk, like the old Linux initrd.)
>> >
>> > Hmm, I guess my approach is a 100% complete nonstarter for installi=
ng
>> > Linux from a CD, and it's really not awesome for installing Linux f=
rom
>> > a USB stick.
>>
>> Doing any of this on a removable device feels generally like a trap.
>> You get your USB disk in, try to boot, and it saves vars, but reboot
>> fails for whatever reason, you plug it in another machine ... and it
>> tries to "continue" from there? The amount of validation needed and
>> testing for failure modes across reboots sounds really painful.
>
> I kind of stand by my other previous suggestion, though:
>
> As a maybe less painful option, we could disable EFI runtime services
> but have a root-writable thing in sysfs that (a) turns them back on
> but (b) first extends a PCR to say that they're turned back on.
>

After setting the EFI boot path to GRUB (or systemd-boot or whatever) at=
 installation time, what other meaningful interactions do we expect with=
 the EFI runtime services?

And given that the secure launch is orchestrated by the bootloader , wit=
h which the kernel has a backchannel via its configuration file, it shou=
ld be rather straight-forward to implement the staging of variable updat=
es there if we really need it.=20

Doing any of this at the EFI/spec level might lead to a situation where =
the OS now has to guess which of the provided APIs to manipulate variabl=
es is the least broken.

Of course, for readinf variables, dumping the RT variables into a memory=
 buffer at boot time and exposing it via a EFI config table would be rat=
her straight-forward, but it is also something I feel should be the job =
of the boot component that takes part in the decision to shield the runt=
ime services from the OS.





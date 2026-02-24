Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BEEEFB816
	for <kexec@archiver.kernel.org>; Tue, 24 Feb 2026 08:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uGL5V4ybrZtgDy4Ez2EE0bWwenNORHtw2SqAtXBgfrM=; b=wBbXdwrgDgm6y+dxJIf98K+7Va
	MbXnIsCZpwhtwxlyfq4EkeS8jeKgTfUqBE9FVfNXNxtQZG4KBBUrK3HSrvRrUbxRUgj0pI0xm4nZw
	T30nrUJfTCeMHEBARdsB0e9KpgYL2xHl0PlZHTV4RS0qXArn2p2HWVgTBFuD97boS1TJ5cVZzupCs
	qde0uIGoUy+kT0TYduAZYM90bapsxa0X3hSWp2t9ZBHwohn+Du0WhIL+gIj3VQgXwO211CtafRJtZ
	lk2JXSaD0yetzS3Vl/v4h1gM9n4uoMyHZIt8ov4b1oHUmIAhmum6E5nWhKrxzOal4i6w00jWYEjrC
	V9+xwSog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vunl2-00000001e0P-18f2;
	Tue, 24 Feb 2026 08:27:04 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vunkz-00000001dzn-2F5H
	for kexec@lists.infradead.org;
	Tue, 24 Feb 2026 08:27:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CAF23443EF;
	Tue, 24 Feb 2026 08:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FC4C4AF0B;
	Tue, 24 Feb 2026 08:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771921620;
	bh=uGL5V4ybrZtgDy4Ez2EE0bWwenNORHtw2SqAtXBgfrM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=axVIXYxUgRkP5VNvV98V1g0wnA7ipOtwAd357KTFn/CRheTNFVp2/ypFLpseuiOSL
	 s9Q7QuK+wValYwI9sm1NvSzwKKauls2jJemU2qF4e2xWQENKI5xKo6RkUE1FQx1B6Q
	 vVyy4y3eIPEpyz/hZYwSrq7o9uLSizPq5zATgrc1OgaUp8r4HGU/V6B/QLFH3tXvZv
	 jxyPe5nAOBfUIt5RSL/OxgJ4TK0+zElK7XNg+lj1xTPrTENRsg8gx6GocV9NXgfZPb
	 49tGwDX7vI7I+gmhucE9HiReXDACKRnKGuO23ez5Ccp5cxjJxw9fzJi/X67fWXSBqk
	 3RDTrQdPBZ1jQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8F85BF4006A;
	Tue, 24 Feb 2026 03:26:58 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Tue, 24 Feb 2026 03:26:58 -0500
X-ME-Sender: <xms:0mCdaeS4gs9_4cI0M3pb0ELas63mgebvYSvnSqB9RAqe_bOYHciYMQ>
    <xme:0mCdaelkhNJa-C8gAgeqSnHrqMx1JykXK-Eg_2ErefnrT4Df3ZGe-uThtv4pUDPFO
    ZQhtHrXX3ZH00eunOoHDteXfbtsHZRZiB_CKFosv4GOq7i0LD320dc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeelieekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:0mCdaVC92Ri72Ftpm6M5ZohWHZYKotgc9AzwW5hBVioygJzJDEfkLw>
    <xmx:0mCdaeNvbe_P3jm_Oi-bOhVymevi0WIoW07XL-dampoag-b4eTcdow>
    <xmx:0mCdaUkYLeWTXG5vbaFJ-xDDYExrF_SQLlH8ZGP-nr6zp_k6ZkhkZA>
    <xmx:0mCdaQc57QXzPMBBpX0iwdRcBoNXBcYM2z9j-KjrSVl2AiKAzVHE5Q>
    <xmx:0mCdaZD30e_5mV6VzzV0zJSiWC_PzLK46AJe_IvUTDxy6JlFAdW7YCjw>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5DE47700069; Tue, 24 Feb 2026 03:26:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: A1ToacgRLhLF
Date: Tue, 24 Feb 2026 09:25:33 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Andrew Cooper" <andrew.cooper3@citrix.com>,
 "Daniel P. Smith" <dpsmith@apertussolutions.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 "Eric Biggers" <ebiggers@kernel.org>
Cc: "Ross Philipson" <ross.philipson@oracle.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "H . Peter Anvin" <hpa@zytor.com>, dave.hansen@linux.intel.com,
 "Matthew Garrett" <mjg59@srcf.ucam.org>,
 "James Bottomley" <James.Bottomley@hansenpartnership.com>, peterhuewe@gmx.de,
 "Jarkko Sakkinen" <jarkko@kernel.org>, jgg@ziepe.ca,
 "Andy Lutomirski" <luto@amacapital.net>, nivedita@alum.mit.edu,
 "Herbert Xu" <herbert@gondor.apana.org.au>, davem@davemloft.net,
 corbet@lwn.net, dwmw2@infradead.org, baolu.lu@linux.intel.com,
 kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Message-Id: <ce68fcc7-d90d-4ee3-bb25-3f960442e281@app.fastmail.com>
In-Reply-To: <02e6a889-ff72-4c18-b9ee-35fcef3570f6@citrix.com>
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx>
 <281c3bb3-13f6-47a2-9a9a-134e397bf686@apertussolutions.com>
 <c9a0cd9f-17cb-49e5-a411-b78ef9c7e35e@app.fastmail.com>
 <02e6a889-ff72-4c18-b9ee-35fcef3570f6@citrix.com>
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch early
 measurements
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_002701_633773_DE22AE8A 
X-CRM114-Status: GOOD (  29.59  )
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



On Tue, 24 Feb 2026, at 00:08, Andrew Cooper wrote:
> On 20/02/2026 3:35 pm, Ard Biesheuvel wrote:
>> Coming back to this old thread after having spent some time playing w=
ith the code:
>>
>> On Thu, 22 Aug 2024, at 20:29, Daniel P. Smith wrote:
>>
>> <selective snip>
>>
>>> Another fact to consider is that the current Intel's TXT MLE=20
>>> specification dictates SHA1 as a valid configuration. Secure Launch'=
s=20
>>> use of SHA1 is therefore to comply with Intel's specification for TX=
T.=20
>> As I understand the Intel TXT spec and the code:
>>
>> - TPM 1.2 is no longer supported by the TXT spec (since 2023)
>> - TPM 1.2 is not supported by your GRUB implementation
>> - in TPM 2.0 mode, SHA1 is only supported by the TXT spec if it is th=
e /only/ algo supported by the TPM
>> - the proposed kernel implementation ignores any SHA-384 and SM3-256 =
PCR banks if they are active, and caps them using a { 1, 0, ... } fake d=
igest.
>>
>> So apologies for being slow, but I still struggle to understand why i=
t is so important to have a SHA-1 implementation to cap those PCRs. Is i=
t just to support systems with a TPM 2.0 that only has SHA-1 banks enabl=
ed?
>>
>> Assuming that this code will get merged this year, it will be in a LT=
S branch by 2027, by which time distros like Debian will pick it up.=20
>>
>> I fully understand that this code has lived out-of-tree for more than=
 a decade, and you likely prefer to get everything upstream that your cu=
rrent users may be relying on. But for Linux, this is a new feature, and=
 merging code now that is basically obsolete on day 1 is not something w=
e should entertain imo.
>>
>> (and apologies for re-opening yet another can of worms - I assure you=
 I am trying to be constructive here)
>>
>
> I appreciate that you've got concerns, but I don't think these
> characterisations are fair.=C2=A0 Ultimately yes, we do want to suppor=
t TPM
> 1.2 systems because we have users wanting a way off the out-of-tree pa=
tches.
>

That was my question, yes. So supporting TPM 1.2 as well as TPM 2.0 with=
 only SHA-1 banks enabled is needed not to comply with the spec, but to =
support existing out-of-tree users. That needs to be called out, because=
 what I am quoting above is a claim that it is needed to comply with the=
 TXT MLE spec.

So the debate is really about whether or not such systems should be cons=
idered obsolete at this point.

And why is it ok to just cap active SHA-384 banks rather than perform th=
e proper measurements?

> 3-year-old hardware is new enough to still be in full support from OEM=
s,
> and totally fair game for distro LTS's even at this juncture.
>

3-year old hardware that shipped with a TPM 1.2?

> The TXT spec does not speak for what OEMs choose to support, nor for t=
he
> TPM spec (where SHA1 is a mandatory algorithm for TPM 2.0), nor does it
> speak for other silicon vendors we're trying to support (there are AMD
> patches waiting for the interface to stop changing).
>
>
> But lets ask the question the other way around.=C2=A0 What does refusi=
ng SHA1
> gain?
>
> AFAICT, there's no meaningful reduction in complexity in the early cod=
e;
> the TPM library speaks TPM 1.2 and 2.0.=C2=A0 There is a small reducti=
on in
> binary size for not including SHA-1, but including it is no extra C
> because we reuse the library that already exists.
>

The complexity of the code is not the problem. The problem is that we'll=
 be stuck supporting it long past the point where anyone is making meani=
ngful use of it. I'm not keen on being on the receiving end of a bug rep=
ort from your last remaining TPM 1.2 user, with no means whatsoever to t=
est or reproduce.

> The cost is a failure to operate in some TXT configurations that exist
> on in-support CPUs, as well as older systems.
>

Sure, some systems will be left behind. I just wonder how many of those =
would be upgrading to the v7.3 LTS kernel to begin with, 4 years after T=
PM 1.2 support was dropped from the TXT spec.

In any case, the code changes themselves look fine to me. I am more conc=
erned about the long term maintenance: the x86 boot code is very complex=
, given how many boot methods it supports, and it is rather difficult to=
 regression test all of those.





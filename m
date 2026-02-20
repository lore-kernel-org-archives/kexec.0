Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBD5C56206
	for <kexec@archiver.kernel.org>; Fri, 20 Feb 2026 15:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rk95DXVUJ/uTE7v54hGbwsw6fj/K+loJ3mwosggZSgY=; b=NviyfkYMSJLSwO7JtHHKv9yZJi
	FgBqoWcTqXXOb1b0VkDdyZGENjdaACKirpQO2huFGweSwMARGDOZYRkjTAiTK8SdB7JDeeHmTj5ay
	Om0wuT0h9vEioXIfiUSiOXx9xOmDgR8nFx/rQh8ipN27P4dbFNqu3JTS28IC/7xQ7kzj7s55qYUNS
	jC8OHV3n/v/Xwm4U88RSGwhVItClZRMIdOYZP7IyyOMXze/2TBqpM6n7apIn0Hu/QZFNtGsvfdWbp
	p/Zimnb+dsC2PDt8CTxsdwLjvdwyV/4MVKxkaqKqm+7CAKQXZv9vXcizJVaOQj7pRmvjJGU5C2lWa
	f3Oingrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtSYO-0000000F3Cy-0mAR;
	Fri, 20 Feb 2026 15:36:28 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtSYL-0000000F3C8-4ATd
	for kexec@lists.infradead.org;
	Fri, 20 Feb 2026 15:36:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 19BFB60134;
	Fri, 20 Feb 2026 15:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADE5C116D0;
	Fri, 20 Feb 2026 15:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771601784;
	bh=Ip+Ok3z4b8Mn4e2k/xxO7ygofUYVx5NJdGPJvg3Uvvo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=d8j24fM/iIueOFUXQImLRiw/Nvq9i5abxog58HkgSvv3tfg3f8bPIw4TIaTL2cNsF
	 gj5E9/mdWAZ8jDtMoQbP0PsHlnKjlIaYKj+W4RmlL35pZsFnxdbTRoGlT/HDBOL1oD
	 hS9oP7F1wMw4vHb8tBOq8YsCezfJ2JQwZUjGQnK92/Q6OTmB+qs8Dhl4KVI+wJ9Ynn
	 bL7miOtFFyZc+7gtzmfTPsDwSVtXhaWtx6TIZIex4mvbDtrG809w7MJGHQP/NDckLn
	 BLhR46uTaItrkYXBa7Po6XxMGAHum954lWlXf6VMAlRckrSh48zxvKM9vVUQTwYL26
	 EkdgubbdOGCcQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id DD74FF4006D;
	Fri, 20 Feb 2026 10:36:22 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Fri, 20 Feb 2026 10:36:22 -0500
X-ME-Sender: <xms:dn-YaXpKzgBI7lLLXvVnqkp9s_8LSG6eYRHb_v7Dh4I_nA74WDDqdw>
    <xme:dn-Yacclxv5BJtKZ-Qq1XI4iHx3RyLHcNXmhZ9xG5qOn3jV4EcwK33tH6kozNhz9o
    AbjnGXi1_VPLoTivYQYVCdUF9t9jfiBkqZ4d5ah8cdAmjyXu-PjMSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
    jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
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
X-ME-Proxy: <xmx:dn-YaZBdaidTbvEBGfz-iUZ-mgy8GA-vuxokns0lACS79eaqin2sjQ>
    <xmx:dn-YaU4tmc_oQXzOQdSawhF3iuF8TCBCCqScSkC_zNOtmM0y7z9SfA>
    <xmx:dn-YaQlTtj_nEiNEidchtEBlqmzl0pkyLthbR5p7BnKlCdBg4gvexw>
    <xmx:dn-YaXfzUes1HVb7VveqSbLUM6qO4SVJqCj2HwTjJqow0G19GkCsMw>
    <xmx:dn-YaZ3f8bIvTNMtbs-XCNvgBOCGXlsfh9Hb0ZD3p2MiApd3SUqnKoDq>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A57F1700065; Fri, 20 Feb 2026 10:36:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: A1ToacgRLhLF
Date: Fri, 20 Feb 2026 16:35:44 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>,
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
 kanth.ghatraju@oracle.com, "Andrew Cooper" <andrew.cooper3@citrix.com>,
 trenchboot-devel@googlegroups.com
Message-Id: <c9a0cd9f-17cb-49e5-a411-b78ef9c7e35e@app.fastmail.com>
In-Reply-To: <281c3bb3-13f6-47a2-9a9a-134e397bf686@apertussolutions.com>
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx>
 <281c3bb3-13f6-47a2-9a9a-134e397bf686@apertussolutions.com>
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch early
 measurements
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

Coming back to this old thread after having spent some time playing with the code:

On Thu, 22 Aug 2024, at 20:29, Daniel P. Smith wrote:

<selective snip>

> Another fact to consider is that the current Intel's TXT MLE 
> specification dictates SHA1 as a valid configuration. Secure Launch's 
> use of SHA1 is therefore to comply with Intel's specification for TXT. 

As I understand the Intel TXT spec and the code:

- TPM 1.2 is no longer supported by the TXT spec (since 2023)
- TPM 1.2 is not supported by your GRUB implementation
- in TPM 2.0 mode, SHA1 is only supported by the TXT spec if it is the /only/ algo supported by the TPM
- the proposed kernel implementation ignores any SHA-384 and SM3-256 PCR banks if they are active, and caps them using a { 1, 0, ... } fake digest.

So apologies for being slow, but I still struggle to understand why it is so important to have a SHA-1 implementation to cap those PCRs. Is it just to support systems with a TPM 2.0 that only has SHA-1 banks enabled?

Assuming that this code will get merged this year, it will be in a LTS branch by 2027, by which time distros like Debian will pick it up. 

I fully understand that this code has lived out-of-tree for more than a decade, and you likely prefer to get everything upstream that your current users may be relying on. But for Linux, this is a new feature, and merging code now that is basically obsolete on day 1 is not something we should entertain imo.

(and apologies for re-opening yet another can of worms - I assure you I am trying to be constructive here)

-- 
Ard.



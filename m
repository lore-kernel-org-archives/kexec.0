Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC55E9A02C
	for <kexec@archiver.kernel.org>; Wed, 18 Feb 2026 21:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pPcRNxiA9VF/PkhlksjBanylvA2gRYuNpURfmKx7ewA=; b=EOuQXwjDOxjD0QY7l4S+lpavZL
	RlxmOyZRxuSdFdSkMRuWgztteiv6oPfGyZ2XgNEiyxwBTrUuWRwzS4nPcagHHWDq7Au+gCOj42NQm
	K4q0ttcBHRPp+TvMix6qi31KUa701qNezS1rEMnWR3FK3JBHP0T/U4cgcl6d0ooHaZwRZ/Qz+OxCO
	X6y59HroKrzRUo5dOLRA6iTBDwqNg5FLcD1nztJWaxKq0ndnGV9vhi9OPXpEXZJjBsKO4S+hqnC0O
	1HqSMRwHUChlpPBx/kcFxEiW5ohlCt2X2jfAp7tL1Y8wGw5k8zGHdoYk3ECZQwSul4qalkP20A9HG
	e2w5PW4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsojx-0000000AQHx-3taZ;
	Wed, 18 Feb 2026 21:05:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsoju-0000000AQHZ-295H
	for kexec@lists.infradead.org;
	Wed, 18 Feb 2026 21:05:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771448740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pPcRNxiA9VF/PkhlksjBanylvA2gRYuNpURfmKx7ewA=;
	b=OfhPFieTdI9PklA0QcJmVM8XT87Slkm5JA7dm40+fyaBUvbFtLiV4HJPwsgY8bDpY06c9V
	DEv3FTfiFWh5i5MJl4yGgKo/e8k2P9Z0kGbIzTanJqtZyGZUVWJK+KXnSruaA91K/9gAE7
	PTDfwcxxiSqwxcExCaljs4oY2eDdf+0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-dvSkX7VVPSK0sw8CYWl_tg-1; Wed, 18 Feb 2026 16:04:06 -0500
X-MC-Unique: dvSkX7VVPSK0sw8CYWl_tg-1
X-Mimecast-MFC-AGG-ID: dvSkX7VVPSK0sw8CYWl_tg_1771448646
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb4817f3c8so138000285a.3
        for <kexec@lists.infradead.org>; Wed, 18 Feb 2026 13:04:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771448646; x=1772053446;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPcRNxiA9VF/PkhlksjBanylvA2gRYuNpURfmKx7ewA=;
        b=iEOhoWB1e2TeAepLROJmCdguL6o4tjulI9Dzr+aaa89jW2N2zU4QzfKRWSJBV1zCP1
         Oe7HbVgESY3Bj9egR6g1nrjs7jXsKoLPZGyPD4FtBLtlh7zKqJbdvnd5TlF3v0R1HxC0
         XCDW8avQ+GMESr53LLSZKbmxWtqvPYvvjUrp8vS2aptZULj7TO6SlIYN0MedTak+a4wB
         NepZIBqZStGHR2+FeA8UYxWDSiTaniP10PdFtw4xDrgMnOE59GlxSqlSeBhu5+oV/1b6
         QtrzBuAo2tG4r/hMJPmxT6a3o3FOx3OS8qF+ku1eKLxs8Eo1mkQ17ALNugl72kw/TCKz
         lMSA==
X-Forwarded-Encrypted: i=1; AJvYcCW9wknaH1CTXGd6eUsaX/9I6ChHqOu1KIIxJ4TbA6IXWbqDUJ4I4iWhnZKR11DP9BN/Vcw+8A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzho7pgxolVxixlz9WEBY7fVnalSQ6uoR26f39Uk2vNe4h89xto
	OQIHYSLmEjjExqF8PbM4lx1BhHvybnuTa/qFwkVr2dnjjPQnTFtZKws2m3fg53gBQRCJn04vVDW
	BggozE3QhbXfia6uVE/FlU89BVJP5N1uh4WusSM4EDickzWANTcojMWFWDiMWsg==
X-Gm-Gg: AZuq6aKkuX/Iqx0TH0vKKB8e/fpzz8BK0akaeVMenMhztRLiCmwizxPITEEe7UqYxwm
	R/HScCOh/Rc8411mvmuTxcKCAQWIeiyL+1CKw42n8X5D3wYXHDyOsmsYD2EOC2aq9E50XhiEWhc
	R9HynF0eyUNM7P/ucqNMrB//qRawsSNXvNaCda/HseqsGnQhip+nTKHcIQR2dQApnJPxZ4LXL+A
	8CnXr3MEQXZlCxPpiT9XNSrb+Lcm8kQFP3+tWrD/SK2cVy9raRueMTYUIqbIIZR0y3PJU/7Hs26
	XdpdSRpsi6Nb4m5ZSHhGJNKaJfz8Nh0k0s8Jp+0HX3tSoNgYRmgcRTC8V+R5Cgiqgci42NRX39A
	pjwPTdHKbVST6KJJ+
X-Received: by 2002:a05:620a:4689:b0:8cb:4dc4:61be with SMTP id af79cd13be357-8cb4dc46babmr1909604585a.49.1771448646122;
        Wed, 18 Feb 2026 13:04:06 -0800 (PST)
X-Received: by 2002:a05:620a:4689:b0:8cb:4dc4:61be with SMTP id af79cd13be357-8cb4dc46babmr1909597185a.49.1771448645565;
        Wed, 18 Feb 2026 13:04:05 -0800 (PST)
Received: from m8.users.ipa.redhat.com ([2603:7000:9400:fe80::7a7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b1c7ef7sm2079117785a.28.2026.02.18.13.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 13:04:04 -0800 (PST)
Message-ID: <32e62cef7b89d9691bdd4120388ce752fd041230.camel@redhat.com>
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
From: Simo Sorce <simo@redhat.com>
To: Andy Lutomirski <luto@amacapital.net>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, "Daniel P. Smith"	
 <dpsmith@apertussolutions.com>, Ross Philipson <ross.philipson@oracle.com>,
 	linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, 	linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, 	kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev, 
	dave.hansen@linux.intel.com, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar	 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 mjg59@srcf.ucam.org, 	James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, Jarkko Sakkinen	 <jarkko@kernel.org>, jgg@ziepe.ca,
 nivedita@alum.mit.edu, Herbert Xu	 <herbert@gondor.apana.org.au>,
 davem@davemloft.net, corbet@lwn.net, 	ebiederm@xmission.com,
 dwmw2@infradead.org, baolu.lu@linux.intel.com, 	kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, 	trenchboot-devel@googlegroups.com
Date: Wed, 18 Feb 2026 16:04:03 -0500
In-Reply-To: <CALCETrWzG1Mjb-RcwLQ5-tGFZ15WKHjZbqtLvyif+UPuVKJ_5g@mail.gmail.com>
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
	 <b5f2b5a5-b984-4ed3-a023-c06d634f9146@app.fastmail.com>
	 <1ffd3cb5-2c76-4371-a067-3e4849907d80@apertussolutions.com>
	 <49d169bf-0ad2-49be-b7d7-fceb9e7f831a@app.fastmail.com>
	 <CALCETrUE8c-dxRWhtHKz_PojwZuWMXJSzOsFQf2vt5LS3ATwpA@mail.gmail.com>
	 <1BBD7449-8420-43FD-930B-A4E1BA38FFC6@zytor.com>
	 <CALCETrWzG1Mjb-RcwLQ5-tGFZ15WKHjZbqtLvyif+UPuVKJ_5g@mail.gmail.com>
Organization: Red Hat
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LQqLM5HRB6Ss_KrkzmVkvcQZrY9hjvQwXZO6YdgSH6Q_1771448646
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260218_130542_631956_4685DF60 
X-CRM114-Status: GOOD (  44.27  )
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

On Wed, 2026-02-18 at 12:34 -0800, Andy Lutomirski wrote:
> On Wed, Feb 18, 2026 at 12:29=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> w=
rote:
> >=20
> > On February 18, 2026 12:03:27 PM PST, Andy Lutomirski <luto@amacapital.=
net> wrote:
> > > On Thu, Feb 12, 2026 at 12:40=E2=80=AFPM Ard Biesheuvel <ardb@kernel.=
org> wrote:
> > > >=20
> > > > On Thu, 12 Feb 2026, at 20:49, Daniel P. Smith wrote:
> > > > > On 2/9/26 09:04, Ard Biesheuvel wrote:
> > > > ...
> > > > > > Surprisingly, even when doing a secure launch, the EFI runtime =
services still work happily, which means (AIUI) that code that was excluded=
 from the D-RTM TCB is still being executed at ring 0? Doesn't this defeat =
D-RTM entirely in the case some exploit is hidden in the EFI runtime code? =
Should we measure the contents of EfiRuntimeServicesCode regions too?
> > > > >=20
> > > > > Yes, in fact in the early days I specifically stated that we shou=
ld
> > > > > provide for the ability to measure the RS blocks. Particularly if=
 you
> > > > > are not in an environment where you can isolate the calls to RS f=
rom the
> > > > > TCB. While the RS can pose runtime corruption risks, the larger c=
oncern
> > > > > is integrating the D-RTM validation of the Intel System Resources
> > > > > Defense (ISRD), aka SMI isolation/SMM Supervisor, provided by the=
 Intel
> > > > > System Security Report (ISSR). Within the ISSR is a list of memor=
y
> > > > > regions which the SMM Policy Shim (SPS) restricts a SMI handler's=
 access
> > > > > when running. This allows a kernel to restrict what access a SMI =
handler
> > > > > are able to reach, thus allowing them to be removed from the TCB =
when
> > > > > the appropriate guards are put in place.
> > > > >=20
> > > > > If you are interested in understanding these further, Satoshi Tan=
da has
> > > > > probably the best technical explanation without Intel market spea=
k.
> > > > >=20
> > > > > ISRD: https://tandasat.github.io/blog/2024/02/29/ISRD.html
> > > > > ISSR: https://tandasat.github.io/blog/2024/03/18/ISSR.html
> > > > >=20
> > > >=20
> > > > Thanks, I'll take a look at those.
> > > >=20
> > > > But would it be better to disable the runtime services by default w=
hen doing a secure launch? PREEMPT_RT already does the same.
> > >=20
> > > So I have a possible way to disable EFI runtime service without losin=
g
> > > the ability to write EFI vars.  We come up with a simple file format
> > > to store deferred EFI var updates and we come up with a place to put
> > > it so that we find it early-ish in boot the next time around.  (This
> > > could be done via integration with systemd-boot or shim some other
> > > boot loader or it could actually be part of the kernel.)  And then,
> > > instead of writing variables directly, we write them to the deferred
> > > list and then update them on reboot (before TXT launch, etc).  [0]
> > > This would be a distincly nontrivial project and would not work for
> > > all configurations.
> > >=20
> > > As a maybe less painful option, we could disable EFI runtime services
> > > but have a root-writable thing in sysfs that (a) turns them back on
> > > but (b) first extends a PCR to say that they're turned back on.
> > >=20
> > > (Or someone could try running runtime services at CPL3...)
> > >=20
> > > [0] I have thought for years that Intel and AMD should do this on
> > > their end, too.  Keep the sensitive part of SMI flash entirely locked
> > > after boot and, instead of using magic SMM stuff to validate that
> > > write attempts have the appropriate permissions and signatures, queue
> > > them up as deferred upates and validate the signatures on the next
> > > boot before locking flash.
> > >=20
> >=20
> > *If* a physical EFI partition exists there is a lot to be said for this=
 approach.
> >=20
> > The only issue with this that I can see is for things like network or C=
D/DVD booting where there isn't necessarily any EFI boot partition, it migh=
t not be writable, or it might not be persistent (e.g. http booting typical=
ly uses a ramdisk, like the old Linux initrd.)
>=20
> Hmm, I guess my approach is a 100% complete nonstarter for installing
> Linux from a CD, and it's really not awesome for installing Linux from
> a USB stick.

Doing any of this on a removable device feels generally like a trap.
You get your USB disk in, try to boot, and it saves vars, but reboot
fails for whatever reason, you plug it in another machine ... and it
tries to "continue" from there? The amount of validation needed and
testing for failure modes across reboots sounds really painful.


--=20
Simo Sorce
Distinguished Engineer
RHEL Crypto Team
Red Hat, Inc



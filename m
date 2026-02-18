Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B47E9A049
	for <kexec@archiver.kernel.org>; Wed, 18 Feb 2026 21:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K6id67RYm+WkjGu//HTup/gkJF0wPsfSPDN/OaX8LFM=; b=riNL+jtLWmb3KQDhlTmlQSJRXz
	X4u8zvFFcjJI8mJDprY7zISDw9+neNc4aQbTLmmIZ9eRBWRu4L/8byLQsi2rrvo2/aeZ9TpvFAI7v
	8Au2VeTK9HAbaFZB2z1JXTLO56E2oz39TKtqn9Jo5pZRaGNmrDd9MwIQjvWyBne1ItqJapiEqDLMy
	nNyncktX/oMTOpj2nP4e9GJFyDT2SWXkC0IqfgDbse38q2rYd0UQAsO56pxd2UQUgg6XdfqSB1o0f
	zSKxZCgdk+oBj5pk2JyF9HjP7V5GBSbt0EKOIJJioPmO8lzIXP02IZzsYga+KIoyJZAYLGLDXpa+v
	i4irDQhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vspVm-0000000AUjj-2SaA;
	Wed, 18 Feb 2026 21:55:10 +0000
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vspVj-0000000AUjJ-0awH
	for kexec@lists.infradead.org;
	Wed, 18 Feb 2026 21:55:08 +0000
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-59e5eaa491cso459834e87.0
        for <kexec@lists.infradead.org>; Wed, 18 Feb 2026 13:55:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771451705; cv=none;
        d=google.com; s=arc-20240605;
        b=eLDJ1RtfA+rGHE05SmsDA+FjcHTjJuc9H363idmHEIPxvZqQZ4QjtZxL4wQr+2Imm2
         2EbqqHTRa6GP5BaUCKFC/sM49FxZq6CNb9YB8OW2hSm03r8H56hIuFA1/77SQOXyruOF
         rx7la9weQWRDBqyGBTdZ3igPYUn44Fts3M2Z9QFWSflpD23GSahjmpu/cLVWoBGIH13a
         cdv7pF122mB8nb2ndEgd5sBaz8x0gYkSQfuowonKEp6XJRewuNML5YZlLyqR3LPIFdKX
         /C+oCHShb3gib4EC/SkL5wglJraVEV7p+etQV7jl8J4jU5dmdDSTpgLK690sfOH0/g4l
         L8fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K6id67RYm+WkjGu//HTup/gkJF0wPsfSPDN/OaX8LFM=;
        fh=Ugqyl0aUQoYRrxwLc0F4thtliKrRDOQjuc++VP6YK+A=;
        b=VP610SMcVmBCPZrtvhHy3nn6O3wnpzRk+nvtn5E8r7C2WthKiaJSFWR0uUjw35mt8O
         EZKOo6e0JIbXvm3DlNR1AQxQP6sjNsThmk+A9JTtjSvnQjiexvgELXpsGJe1ht+5iUx+
         1HzH8D67e0GnLYj7xdFldlV72PQcvSBsmecWJ481XgysuvsC4m98gmNawEOHbjVRxW3A
         myA+GM+TvN+0s7VqLAzfTVY8g5/hqcUxnkHLUAriAHbRWI1TWXLLevJKdYTywrxxUCs6
         0sIWhsDfXkFOQik54ic61CIB8ygFT7ZtIEeGR0PmqoNUI7bYYBophRUQvUgyobDVJatC
         CjPQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1771451705; x=1772056505; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6id67RYm+WkjGu//HTup/gkJF0wPsfSPDN/OaX8LFM=;
        b=L4Z7V1uQR1ZhLGRR40riiON7wXPjfkfmrnww6M0I+nmUwUHKP0h+hb2XjTEmGxRnB3
         rtDY8Gf1ykJDW6QKIT2Tv9f8jj7uNhkds4M/waKCvEYdrjYwlI5C9kdT2UfZAn3ho7wG
         TdUHo4gGlElN0eX5aAlp3bjCLyij80vsb0TPeEfcCMYG2yQLvYiQYVtog9NOwf1eS3kF
         NM/MT54XoXFVG2z5/2JCB7G/vO+84KYoXSB8/1dLihFZnpdYLAPjFDVxSkw6xeHTX+/R
         kWh6WDUNnvQ0LqLJe9wE56JFXtJeJ+/76Hx32J7ecyxtCjTftg5ehDaYIntAKxUfNx9z
         TXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771451705; x=1772056505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K6id67RYm+WkjGu//HTup/gkJF0wPsfSPDN/OaX8LFM=;
        b=pyoRJUGa6R6lfS7Nu2GHYPZC6syUP7Fno+91yJIYMA9GxDMSuCtm66llgpAjISqGe2
         R8Sn++ljXI0VuA0+3q9UEAAHu/fQBfJlnbOepkYkxnEbBx09miVNxtWYAwCA5VsYY8+g
         WWNB3JjaVyBT3GqZLUy1FzMUXhQLWAAGBTfK/WwYgcnNwMk6Ln8nF5IvmaqEloT3ANO8
         0jGPNKK79C6dZEkw5gmZB5P+eZrgR9b9yS1p22H+gNLRwga47eluB/sNav/IKyxqybMO
         EzRmB/tDWZPjslS627xIvrDIJKdya/jFaf4cA5P7ebRKJClSkQ3RewCOLjNLOoVoMk8z
         Jw5w==
X-Forwarded-Encrypted: i=1; AJvYcCWDnhA4U/awc3TKb/qYKLOJzurYKukBgiRFTlNvFEoiMsQ+iMFeKi2W0CT1FOTpCQreV5+KQw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzoMzbhILhDUnI87XdrohHxNXyw1mNh04KraF8cUVaJd9B3NOD3
	wECUW2xLmYy1IjdWi9vOHzd3CSXgJomo7KzWg9h2XRKJkT8DGcrp1Xvk3Ym5/PnLgVcsbgTOdgU
	i+qB6J8VhD5OG+D4M6ZqopVg3wE28M41XwGvXhmUb
X-Gm-Gg: AZuq6aJo6SqnIK/8bLxfYlhEC4rn3KTY+jK72J58RWs1vZxWZC+xgp0pE0QkLR5cHL+
	QFHy8wCsdWMMpt7vYyTewW9RcCokQw0ziqDw07TX2P5kh90cxxWomyCitp4GOuiRkTgRIfB5JSj
	KJh3kUcYMjmXaW6oQ3IYneF9vES5VmjFyS2Ht+d2miEBoK3KsLJm6N2Ei68GfSMLepJBbfQSw3w
	ykPs2L3eivkd9WY3ANWIaVFzEIYyDy7ALOBoRw2Eu9mUelDmetg9u2uLsS9xLYsPNa8CSNPaIH7
	LeWw
X-Received: by 2002:a05:6512:304d:b0:59e:1880:2ef6 with SMTP id
 2adb3069b0e04-59f69c0f33dmr5396130e87.10.1771451704704; Wed, 18 Feb 2026
 13:55:04 -0800 (PST)
MIME-Version: 1.0
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <b5f2b5a5-b984-4ed3-a023-c06d634f9146@app.fastmail.com> <1ffd3cb5-2c76-4371-a067-3e4849907d80@apertussolutions.com>
 <49d169bf-0ad2-49be-b7d7-fceb9e7f831a@app.fastmail.com> <CALCETrUE8c-dxRWhtHKz_PojwZuWMXJSzOsFQf2vt5LS3ATwpA@mail.gmail.com>
 <1BBD7449-8420-43FD-930B-A4E1BA38FFC6@zytor.com> <CALCETrWzG1Mjb-RcwLQ5-tGFZ15WKHjZbqtLvyif+UPuVKJ_5g@mail.gmail.com>
 <32e62cef7b89d9691bdd4120388ce752fd041230.camel@redhat.com>
In-Reply-To: <32e62cef7b89d9691bdd4120388ce752fd041230.camel@redhat.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 18 Feb 2026 13:54:53 -0800
X-Gm-Features: AaiRm50_oD7OC0ANa5Bzl9PQloeEGVtFI0Bz_O-wbD80wJJi63Y8TTUsLaV64pE
Message-ID: <CALCETrUMR0RvOFXGzL7=F4c-3veL+1Sm2xf-BprHTK4=UKw8yA@mail.gmail.com>
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
To: Simo Sorce <simo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, 
	"Daniel P. Smith" <dpsmith@apertussolutions.com>, Ross Philipson <ross.philipson@oracle.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-integrity@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org, iommu@lists.linux.dev, 
	dave.hansen@linux.intel.com, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, mjg59@srcf.ucam.org, 
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca, nivedita@alum.mit.edu, 
	Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260218_135507_486612_5A04FE03 
X-CRM114-Status: GOOD (  44.93  )
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

On Wed, Feb 18, 2026 at 1:04=E2=80=AFPM Simo Sorce <simo@redhat.com> wrote:
>
> On Wed, 2026-02-18 at 12:34 -0800, Andy Lutomirski wrote:
> > On Wed, Feb 18, 2026 at 12:29=E2=80=AFPM H. Peter Anvin <hpa@zytor.com>=
 wrote:
> > >
> > > On February 18, 2026 12:03:27 PM PST, Andy Lutomirski <luto@amacapita=
l.net> wrote:
> > > > On Thu, Feb 12, 2026 at 12:40=E2=80=AFPM Ard Biesheuvel <ardb@kerne=
l.org> wrote:
> > > > >
> > > > > On Thu, 12 Feb 2026, at 20:49, Daniel P. Smith wrote:
> > > > > > On 2/9/26 09:04, Ard Biesheuvel wrote:
> > > > > ...
> > > > > > > Surprisingly, even when doing a secure launch, the EFI runtim=
e services still work happily, which means (AIUI) that code that was exclud=
ed from the D-RTM TCB is still being executed at ring 0? Doesn't this defea=
t D-RTM entirely in the case some exploit is hidden in the EFI runtime code=
? Should we measure the contents of EfiRuntimeServicesCode regions too?
> > > > > >
> > > > > > Yes, in fact in the early days I specifically stated that we sh=
ould
> > > > > > provide for the ability to measure the RS blocks. Particularly =
if you
> > > > > > are not in an environment where you can isolate the calls to RS=
 from the
> > > > > > TCB. While the RS can pose runtime corruption risks, the larger=
 concern
> > > > > > is integrating the D-RTM validation of the Intel System Resourc=
es
> > > > > > Defense (ISRD), aka SMI isolation/SMM Supervisor, provided by t=
he Intel
> > > > > > System Security Report (ISSR). Within the ISSR is a list of mem=
ory
> > > > > > regions which the SMM Policy Shim (SPS) restricts a SMI handler=
's access
> > > > > > when running. This allows a kernel to restrict what access a SM=
I handler
> > > > > > are able to reach, thus allowing them to be removed from the TC=
B when
> > > > > > the appropriate guards are put in place.
> > > > > >
> > > > > > If you are interested in understanding these further, Satoshi T=
anda has
> > > > > > probably the best technical explanation without Intel market sp=
eak.
> > > > > >
> > > > > > ISRD: https://tandasat.github.io/blog/2024/02/29/ISRD.html
> > > > > > ISSR: https://tandasat.github.io/blog/2024/03/18/ISSR.html
> > > > > >
> > > > >
> > > > > Thanks, I'll take a look at those.
> > > > >
> > > > > But would it be better to disable the runtime services by default=
 when doing a secure launch? PREEMPT_RT already does the same.
> > > >
> > > > So I have a possible way to disable EFI runtime service without los=
ing
> > > > the ability to write EFI vars.  We come up with a simple file forma=
t
> > > > to store deferred EFI var updates and we come up with a place to pu=
t
> > > > it so that we find it early-ish in boot the next time around.  (Thi=
s
> > > > could be done via integration with systemd-boot or shim some other
> > > > boot loader or it could actually be part of the kernel.)  And then,
> > > > instead of writing variables directly, we write them to the deferre=
d
> > > > list and then update them on reboot (before TXT launch, etc).  [0]
> > > > This would be a distincly nontrivial project and would not work for
> > > > all configurations.
> > > >
> > > > As a maybe less painful option, we could disable EFI runtime servic=
es
> > > > but have a root-writable thing in sysfs that (a) turns them back on
> > > > but (b) first extends a PCR to say that they're turned back on.
> > > >
> > > > (Or someone could try running runtime services at CPL3...)
> > > >
> > > > [0] I have thought for years that Intel and AMD should do this on
> > > > their end, too.  Keep the sensitive part of SMI flash entirely lock=
ed
> > > > after boot and, instead of using magic SMM stuff to validate that
> > > > write attempts have the appropriate permissions and signatures, que=
ue
> > > > them up as deferred upates and validate the signatures on the next
> > > > boot before locking flash.
> > > >
> > >
> > > *If* a physical EFI partition exists there is a lot to be said for th=
is approach.
> > >
> > > The only issue with this that I can see is for things like network or=
 CD/DVD booting where there isn't necessarily any EFI boot partition, it mi=
ght not be writable, or it might not be persistent (e.g. http booting typic=
ally uses a ramdisk, like the old Linux initrd.)
> >
> > Hmm, I guess my approach is a 100% complete nonstarter for installing
> > Linux from a CD, and it's really not awesome for installing Linux from
> > a USB stick.
>
> Doing any of this on a removable device feels generally like a trap.
> You get your USB disk in, try to boot, and it saves vars, but reboot
> fails for whatever reason, you plug it in another machine ... and it
> tries to "continue" from there? The amount of validation needed and
> testing for failure modes across reboots sounds really painful.

I kind of stand by my other previous suggestion, though:

As a maybe less painful option, we could disable EFI runtime services
but have a root-writable thing in sysfs that (a) turns them back on
but (b) first extends a PCR to say that they're turned back on.

--Andy


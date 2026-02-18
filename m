Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CC6E9A04B
	for <kexec@archiver.kernel.org>; Wed, 18 Feb 2026 20:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vcy7R/11wcjfKOQI7WogUozCzX0mH6u0BCoPreJyb8U=; b=x3eOGjl/omtAuS/IRtOS/Bx6kt
	r51Mbs/f9TBiinZ0x51gIE5c1Zw78Ekw/vQUwYyARRdL3fcZ43e+QHRSrCWh4QucjfyZyHsUX/quk
	nOg++uFqnu2JPTMbTgWWKGH61tKpGbmqdLVCET4sNyQs8hNonRrg7qKiKwnfgZ0Xo8xyu6YRktSNV
	mVrj5UoSOq3H7BhwKxl0Es4OCIRtYy+Z+SoR4FkkivoaY2deGC9XDPUHXT+Giv99NpwqXAn+lvoGW
	1rWnzeNeVR4GDEN+2VmtdzavXNBa6jbsBhbHst+F0Jy8/dOx6N9jc5kbjFPnJh2BvonwwjMPInVW7
	LUWr9HXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsnlx-0000000ALrd-0FQs;
	Wed, 18 Feb 2026 20:03:45 +0000
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsnlu-0000000ALr1-12Ho
	for kexec@lists.infradead.org;
	Wed, 18 Feb 2026 20:03:43 +0000
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-59e60b3ccdfso471952e87.0
        for <kexec@lists.infradead.org>; Wed, 18 Feb 2026 12:03:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771445020; cv=none;
        d=google.com; s=arc-20240605;
        b=PGWYZOJnF0ZnxevhHB9l3z0cXiZmx4ucdggz5SQqYTWirh4sILUL2zUDNeh79fdKjz
         Olj2eF2b0ds/P+FzzGcYE2KB1/VJ39/yrwaw/UlSTGkHQerhKEY6b96/1FVcjcRJCkda
         OEkVjm0UEf6xxwEKXkN8yLYoPjH9+8npv/37m+kpK0Lg7O7JlVNRTqx5saMdyRgOg4f+
         vtw9vsq9lrvHeJtJabI/L2ZpwzXGnvEee58RoSdAR8rPbRdKWsT8GU10zllz/a6hFYt6
         x/Pz5MIxqOE3+tAo993fBzjMzZ19anZkr0OxCRgdCIv8PKzttpQ8ADsH7NrreP8FwPc2
         b40w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vcy7R/11wcjfKOQI7WogUozCzX0mH6u0BCoPreJyb8U=;
        fh=55OSIcjK6iws+oKH6UF9ia+y1rqmQPKob2ShGcHS72k=;
        b=ObPgz9ClOJTvfGkw247QwA2873uh6QCS16QURm6pWGWp1re2yf3v4Ooo8IFMA48Jkd
         uUJHCym8QX9QH71juLBMP87lH2evnTCeKTrp4lQmxXbJhW/JrMj1EcS0OmOJnMIo4KHy
         w32y+tBWN7d+E1ghqJEelghSQeTkFZu748EKZxKhvfy2ahsY5TMxq3DZcloquiJ18nfo
         CTKD+lLjcA2PojgQYpyHlm+wMKKq9va8E+rTsQcwUD3uFfCPCxP+7RWcmdqDH70po7xV
         kcUfy5qT2dlLT6V72VU3TroU+xckvTwYJaL7KNV32RLyvzBZ3qPSW1hC5N7AkxWCrSuh
         cCFA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1771445020; x=1772049820; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vcy7R/11wcjfKOQI7WogUozCzX0mH6u0BCoPreJyb8U=;
        b=tiDvO15MSLWCOxgoTvz5jpAysYHCP+EzFnKQRl3c9FuWDqsk5zQd3N0L0uaDlg08y0
         jtFvt0NxwuH8+ZfjN6EEN3E//B8W0iySyy9z1R+i2qyWFuD1NjZhXzUGvrDl2wAbY6is
         4dmulL+IodP5GOh3OuBQTh5qQNBM67DP4bYXWWlv7NpSbFwuZt57XK9wgnCe/t/f4b76
         7kLXotOSk6hXrCHlI60Omw9hpr8nMSv4qwkdemXffgRl5oXmTXkytMfjYZFQjvSG6LYY
         oibT+XXGS+SKQCD8IZlOPKfBga6Zgt9Rq29Kx3jkGxnPz6Luhy9TkPR9df9ixh7vW6+l
         +N8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771445020; x=1772049820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vcy7R/11wcjfKOQI7WogUozCzX0mH6u0BCoPreJyb8U=;
        b=krCuPsc2EAwAAmDCNWwUbLqMXArsUFvtY704FSUhcog8Wf+qM7vTp4dFctC9UQHCW7
         YgvNQ5W2Hv33lGvjIHm8deeyaIH6VlDl+hFhgrLv+Nw/BhkAXrZtguHKFfT+Emsw2aX1
         6muUnxA06OaAHfOLUC4J8HjuDAnl3LRfIWqhsohlH1gvScoINWtgSWtFEU+TbGzvcsoT
         3pGq6Oq8nroW7CsNDkvanClhQZjrGKbqAjxHYfzG/ME5IKz2niZY83ylxOLU/Ec099Xg
         GkfmaZ5X9LlRIRXDKggVoPQJE3DaRlHpAkwW1lAo5rPReU9Y1hsoBNEfp/p1sAPXUYji
         aITA==
X-Forwarded-Encrypted: i=1; AJvYcCVsUqviK/jrmF45D2rZwaTIKpXTet96dhSWCIWuC/f6dMXV7oUGBMEpbVBOoAcFYZMR6PGsWA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzvW9OswVaxrgsKH7ZUyE0UipxMpx0w8EjCEW79Fka1WocVKGOF
	/z4Ru0gGcC6lbL7CwhGjvbJJ+9kRRB8BNKQ4bVHfHHT+TwJjkNkVexAIT4pe+lDI+rVFlnFXrq0
	NgrwDPP4bsdw6IbCxqhEDHepQ9Uo5A2JfhS9OLM0H
X-Gm-Gg: AZuq6aK/F2uzDkhBaVYJlqb6bZkeVGFNpjPbNzYGdzUIQMxB9iyvLnAcrPJwuZE+8pL
	64etJZrl8aQ64woq1yImHS3C/RbW8DcHnzaGZwwTEY9OlsAulsPd7xxNbowRhRD86wKAAwvEsfY
	+XeAP83EGSAM2kNmjnFZ3ClM2vBR1lnrm+021y7P622VBxVfZLU5WFr3y3TqoxfnxAI23eC8VC5
	OdfKiWCAeWB69FLtmFRwSURqOOgkRGJ0s6djQqUMJeQxOzHmTwHW84kRIgpohP2MxvuQ5nBLhi+
	JxqVYD3mOSqNbqg=
X-Received: by 2002:a05:6512:3992:b0:59f:6edb:b7ea with SMTP id
 2adb3069b0e04-59f6edbb86bmr4081097e87.42.1771445019417; Wed, 18 Feb 2026
 12:03:39 -0800 (PST)
MIME-Version: 1.0
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <b5f2b5a5-b984-4ed3-a023-c06d634f9146@app.fastmail.com> <1ffd3cb5-2c76-4371-a067-3e4849907d80@apertussolutions.com>
 <49d169bf-0ad2-49be-b7d7-fceb9e7f831a@app.fastmail.com>
In-Reply-To: <49d169bf-0ad2-49be-b7d7-fceb9e7f831a@app.fastmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 18 Feb 2026 12:03:27 -0800
X-Gm-Features: AaiRm50K0AfYUHogK4D4rjv3z3w5Xga5sdt_IpbZg6dO6uXxKWdtAoPp16KXxJI
Message-ID: <CALCETrUE8c-dxRWhtHKz_PojwZuWMXJSzOsFQf2vt5LS3ATwpA@mail.gmail.com>
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
To: Ard Biesheuvel <ardb@kernel.org>
Cc: "Daniel P. Smith" <dpsmith@apertussolutions.com>, 
	Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux.dev, dave.hansen@linux.intel.com, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, 
	peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca, nivedita@alum.mit.edu, 
	Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260218_120342_570132_4364B221 
X-CRM114-Status: GOOD (  26.15  )
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

On Thu, Feb 12, 2026 at 12:40=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> On Thu, 12 Feb 2026, at 20:49, Daniel P. Smith wrote:
> > On 2/9/26 09:04, Ard Biesheuvel wrote:
> ...
> >> Surprisingly, even when doing a secure launch, the EFI runtime service=
s still work happily, which means (AIUI) that code that was excluded from t=
he D-RTM TCB is still being executed at ring 0? Doesn't this defeat D-RTM e=
ntirely in the case some exploit is hidden in the EFI runtime code? Should =
we measure the contents of EfiRuntimeServicesCode regions too?
> >
> > Yes, in fact in the early days I specifically stated that we should
> > provide for the ability to measure the RS blocks. Particularly if you
> > are not in an environment where you can isolate the calls to RS from th=
e
> > TCB. While the RS can pose runtime corruption risks, the larger concern
> > is integrating the D-RTM validation of the Intel System Resources
> > Defense (ISRD), aka SMI isolation/SMM Supervisor, provided by the Intel
> > System Security Report (ISSR). Within the ISSR is a list of memory
> > regions which the SMM Policy Shim (SPS) restricts a SMI handler's acces=
s
> > when running. This allows a kernel to restrict what access a SMI handle=
r
> > are able to reach, thus allowing them to be removed from the TCB when
> > the appropriate guards are put in place.
> >
> > If you are interested in understanding these further, Satoshi Tanda has
> > probably the best technical explanation without Intel market speak.
> >
> > ISRD: https://tandasat.github.io/blog/2024/02/29/ISRD.html
> > ISSR: https://tandasat.github.io/blog/2024/03/18/ISSR.html
> >
>
> Thanks, I'll take a look at those.
>
> But would it be better to disable the runtime services by default when do=
ing a secure launch? PREEMPT_RT already does the same.

So I have a possible way to disable EFI runtime service without losing
the ability to write EFI vars.  We come up with a simple file format
to store deferred EFI var updates and we come up with a place to put
it so that we find it early-ish in boot the next time around.  (This
could be done via integration with systemd-boot or shim some other
boot loader or it could actually be part of the kernel.)  And then,
instead of writing variables directly, we write them to the deferred
list and then update them on reboot (before TXT launch, etc).  [0]
This would be a distincly nontrivial project and would not work for
all configurations.

As a maybe less painful option, we could disable EFI runtime services
but have a root-writable thing in sysfs that (a) turns them back on
but (b) first extends a PCR to say that they're turned back on.

(Or someone could try running runtime services at CPL3...)

[0] I have thought for years that Intel and AMD should do this on
their end, too.  Keep the sensitive part of SMI flash entirely locked
after boot and, instead of using magic SMM stuff to validate that
write attempts have the appropriate permissions and signatures, queue
them up as deferred upates and validate the signatures on the next
boot before locking flash.


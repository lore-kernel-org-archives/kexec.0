Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3CCE9A02C
	for <kexec@archiver.kernel.org>; Wed, 18 Feb 2026 20:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6AtdZqt2ARoYJJMPe919rNdJ3JohEndwFbHKNaMS4Pw=; b=FsFbmQjT6K3438h5NNTHGj3zdh
	XjvlJNEAMCvUZYIIhzLZ3LoxXN1lZxOq5EJuzicYOtO1AIBsCVvd5t1lRHGxPF38btQMVJpsc8SSz
	F4mz5OmKTgdEID+nfhkrExZrqPM14n2gOG0BNBw7Gveg/exXBlVtX+HUEXwken847asKOd6v0bDXh
	CnDKFFJD6CIYeOPnTOpY6JbxLq8nO/68Mh2l2TW6PUnBaXAf0Th1NbOE6FzHZeXfDdlAPJIvHE+Ny
	FuZF07EdyfJlpLuNc5gyWSiktyQUg9uJPgc/zl4sQD4sPG6Zhvt3rLPQq/QfgqavmFcWZN9YrwHz3
	ueUG1r6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsoFV-0000000ANw5-1afz;
	Wed, 18 Feb 2026 20:34:17 +0000
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsoFS-0000000ANvC-26xb
	for kexec@lists.infradead.org;
	Wed, 18 Feb 2026 20:34:15 +0000
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-59e5eaa491cso382808e87.0
        for <kexec@lists.infradead.org>; Wed, 18 Feb 2026 12:34:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771446852; cv=none;
        d=google.com; s=arc-20240605;
        b=JS6Zpzy7dfRs47eBgq6QBeNXXdFFijBo9SpSfj/YysUBiFwHA8FDmMvl03Tz3FGffp
         +vEeKevKE9W9kqDP+R83T1qGZYOGc6J9qKc51Ppn+zzq5DGv71/y09RJWbtvrk9dmeGY
         /dx1IN17VTgaGRJY07Rd6fE23aJdQ43nHvE7gFcTTzrNfDf0dDIwqEOM3C/CXuHk7pDj
         gGPPrtEw0C6o4HDsvmnD4Dpzd5w31Txvb+kx1FdmIqa2Vd7AJtXUZR0Diw2ruOYsq4WG
         tXnHA3ujzYlWXgxgPAEkNsZ6Q9PPCUpi/rvOIgbgO86IfhfEcrOlcXwovr5D4nuVqQDs
         zSYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6AtdZqt2ARoYJJMPe919rNdJ3JohEndwFbHKNaMS4Pw=;
        fh=ZPENzjUsagSnFLDSEmnwmqpb6KxoEDSCDjzlWxJSqTM=;
        b=kSjvuQsKfaIE/hd3DpEvOMp302IOytG4GVHLmdg7EsjJMxnvAPX+sx3K2URpicedg6
         F4m7oUvTRAa0pbHZgVfiLSdFRvdpNyA8+epgsHcpv+sRAAm+w9SabSd26AnaCXlb7rXj
         CjDSr1PptLy8sxWHOQugnDTjTnh24TCqaEgqtc9dRnMTZsHg1mZu62hE3XUuKsLPay0E
         FALdndMqz91BDlI+WKD/QyX3YQGp7Le/SAkgYYeLDEz5T5MveDgvLpQJUIlAKnG7f69B
         U0+n6EEszhiJc7r6aWN7DaZpnZNLKUaHsYLCFVBvdmUAZWBiH3zZNK44kMi/jnNWm6uu
         XyPA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1771446852; x=1772051652; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AtdZqt2ARoYJJMPe919rNdJ3JohEndwFbHKNaMS4Pw=;
        b=SfJXYO43vMwjbb/1m/9B8rRv+QeIoPcgv7YvgFbE7Ng+Src3u9UqbIIU1VSqFs3fLZ
         mfDzzR8dfaJkUriKypmXjIdqLKnPLnz3E7OiSVPNM4NO+7CuanEPGfJNEpVM9K/CUe4x
         cCg7aPQUMcOrCftExTLirixBIfqHiAG2caqlMIPwyeF8MpUc9N3MZ++++rZdnvmJWbxy
         MiUmlwE/v2IOJ1HIV+0s8H7BfntjO1n/KMKzTqvfVhzJ/Zm1UJECMB/XZHhNk6wSXHPZ
         MWPyYLacgtd2JQz2PzXwV6G7wBU93uMMq9Q4hG8XYh7Twt2kcgT+G91X9I4OMMw3fZOq
         QqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771446852; x=1772051652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6AtdZqt2ARoYJJMPe919rNdJ3JohEndwFbHKNaMS4Pw=;
        b=VnfiPW+SumaXEEuy0CW0TRmoYtf/lxvX08c8MmqIvSQ4h/JzFK7l3ogwJndjuxJWV/
         8rsSJAsH4Pjl23DCglHLenemrjrD8vxpTvmmqtdInIhpdBoEDgn0YxYn1uyp8xpLPmoM
         MP9Movw4tepNOmH+yoOCRmsouS3RNbxcL9Bn3e9JCKKgc8gOhwfr81u7ei8iK9d+toPe
         BEL4bcVbV8trakBVHIhu2W/0ecnLIqkLAGoRRrTFixf0IlN6H1RQE7LQE5DFd5cKdzd8
         OCakYo5DMgvX+C4dFbf4wXmfQFBhVgFQXsbwLezHzIKGyIJbbWb8Skq3xWu0EEqr8DzZ
         MyCg==
X-Forwarded-Encrypted: i=1; AJvYcCWMHHFRmMc7e7nOiv6JxJB09r1IwXEkhHDccKgTQ/gKWB8q8WrJCAFxAbVZpUu/xHEPP23JLg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx/VbOqwTak8vJgejeUJhPFBQqm9O47kOh85uDTNVkI/zK/Yxmv
	5I2A8WS2f65UNT55+D5Mk+HFQ3u1ZtyE/XplgG0Ej8OB7a/BOKyz9wPl2DpUMsNXyhYeLCKzQEs
	mStwIJHPJmQJSNxstXjnNi/P044+UiJxq8pY6Ndxq
X-Gm-Gg: AZuq6aJPoiPyERaR5q820A2wSQYG8/7RRrzERA3sYa4VBmDtNMWxLXOj19aLF7+WPUB
	AVfoWJEAOxbnc/zd7Dy/bA/1i3Ce3lP0hK3lItASm4tK/WSlDyfpaRJEjGC6ASdNwUzgZiT/Hj4
	UYtr/H9q0+GoKq/JbR2GNffE0qjjK8Fx+tNsROigs8E6NwnRBMRJNWfogy6ii/rYZ5j1+klcv+l
	TCfdUz5KHoLhaLSalzVjH9q6XHVSuef+oymZ8FW+gLuBWovl4ZylTg36erM3KE4t2Hi5KQgm7Dr
	Mgel
X-Received: by 2002:a05:6512:1284:b0:59e:63b7:585e with SMTP id
 2adb3069b0e04-59f69c68122mr5099221e87.36.1771446852112; Wed, 18 Feb 2026
 12:34:12 -0800 (PST)
MIME-Version: 1.0
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <b5f2b5a5-b984-4ed3-a023-c06d634f9146@app.fastmail.com> <1ffd3cb5-2c76-4371-a067-3e4849907d80@apertussolutions.com>
 <49d169bf-0ad2-49be-b7d7-fceb9e7f831a@app.fastmail.com> <CALCETrUE8c-dxRWhtHKz_PojwZuWMXJSzOsFQf2vt5LS3ATwpA@mail.gmail.com>
 <1BBD7449-8420-43FD-930B-A4E1BA38FFC6@zytor.com>
In-Reply-To: <1BBD7449-8420-43FD-930B-A4E1BA38FFC6@zytor.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 18 Feb 2026 12:34:00 -0800
X-Gm-Features: AaiRm52O5CUthtEuekouveR3oQDy41lsj_ZjT1TsYC4xSgI6Vkc6OZxoV-XcGok
Message-ID: <CALCETrWzG1Mjb-RcwLQ5-tGFZ15WKHjZbqtLvyif+UPuVKJ_5g@mail.gmail.com>
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, "Daniel P. Smith" <dpsmith@apertussolutions.com>, 
	Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux.dev, dave.hansen@linux.intel.com, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca, nivedita@alum.mit.edu, 
	Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260218_123414_587075_45D0BD11 
X-CRM114-Status: GOOD (  35.30  )
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

On Wed, Feb 18, 2026 at 12:29=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wro=
te:
>
> On February 18, 2026 12:03:27 PM PST, Andy Lutomirski <luto@amacapital.ne=
t> wrote:
> >On Thu, Feb 12, 2026 at 12:40=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org=
> wrote:
> >>
> >> On Thu, 12 Feb 2026, at 20:49, Daniel P. Smith wrote:
> >> > On 2/9/26 09:04, Ard Biesheuvel wrote:
> >> ...
> >> >> Surprisingly, even when doing a secure launch, the EFI runtime serv=
ices still work happily, which means (AIUI) that code that was excluded fro=
m the D-RTM TCB is still being executed at ring 0? Doesn't this defeat D-RT=
M entirely in the case some exploit is hidden in the EFI runtime code? Shou=
ld we measure the contents of EfiRuntimeServicesCode regions too?
> >> >
> >> > Yes, in fact in the early days I specifically stated that we should
> >> > provide for the ability to measure the RS blocks. Particularly if yo=
u
> >> > are not in an environment where you can isolate the calls to RS from=
 the
> >> > TCB. While the RS can pose runtime corruption risks, the larger conc=
ern
> >> > is integrating the D-RTM validation of the Intel System Resources
> >> > Defense (ISRD), aka SMI isolation/SMM Supervisor, provided by the In=
tel
> >> > System Security Report (ISSR). Within the ISSR is a list of memory
> >> > regions which the SMM Policy Shim (SPS) restricts a SMI handler's ac=
cess
> >> > when running. This allows a kernel to restrict what access a SMI han=
dler
> >> > are able to reach, thus allowing them to be removed from the TCB whe=
n
> >> > the appropriate guards are put in place.
> >> >
> >> > If you are interested in understanding these further, Satoshi Tanda =
has
> >> > probably the best technical explanation without Intel market speak.
> >> >
> >> > ISRD: https://tandasat.github.io/blog/2024/02/29/ISRD.html
> >> > ISSR: https://tandasat.github.io/blog/2024/03/18/ISSR.html
> >> >
> >>
> >> Thanks, I'll take a look at those.
> >>
> >> But would it be better to disable the runtime services by default when=
 doing a secure launch? PREEMPT_RT already does the same.
> >
> >So I have a possible way to disable EFI runtime service without losing
> >the ability to write EFI vars.  We come up with a simple file format
> >to store deferred EFI var updates and we come up with a place to put
> >it so that we find it early-ish in boot the next time around.  (This
> >could be done via integration with systemd-boot or shim some other
> >boot loader or it could actually be part of the kernel.)  And then,
> >instead of writing variables directly, we write them to the deferred
> >list and then update them on reboot (before TXT launch, etc).  [0]
> >This would be a distincly nontrivial project and would not work for
> >all configurations.
> >
> >As a maybe less painful option, we could disable EFI runtime services
> >but have a root-writable thing in sysfs that (a) turns them back on
> >but (b) first extends a PCR to say that they're turned back on.
> >
> >(Or someone could try running runtime services at CPL3...)
> >
> >[0] I have thought for years that Intel and AMD should do this on
> >their end, too.  Keep the sensitive part of SMI flash entirely locked
> >after boot and, instead of using magic SMM stuff to validate that
> >write attempts have the appropriate permissions and signatures, queue
> >them up as deferred upates and validate the signatures on the next
> >boot before locking flash.
> >
>
> *If* a physical EFI partition exists there is a lot to be said for this a=
pproach.
>
> The only issue with this that I can see is for things like network or CD/=
DVD booting where there isn't necessarily any EFI boot partition, it might =
not be writable, or it might not be persistent (e.g. http booting typically=
 uses a ramdisk, like the old Linux initrd.)

Hmm, I guess my approach is a 100% complete nonstarter for installing
Linux from a CD, and it's really not awesome for installing Linux from
a USB stick.


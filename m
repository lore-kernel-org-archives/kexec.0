Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92920C369C2
	for <kexec@archiver.kernel.org>; Tue, 22 Apr 2025 21:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Hc5x03Xt6Q8VLLhD3mCqz80+X90ssoJI+f+CleuBKQ=; b=nNEIOICTPLljS6TZcene22mtPH
	nfuz7YrNOpaFEv2BYcANHnEzUFXuIusdMWlPGfbXKjOyHfH3ORfYIFlDNIlyBoqvbjJrqyas1tYjc
	bp35NDpzMSmiiV7vuw8M/Lpvrwv4wjYz5f7SYBTD+ibJhwjp8b8XThfdkH0CGxc+MlQSgxfqsgq/d
	jBf90cWz5HarZ4qo94Dsr2M50kPZN7XxVh5a449kHShFRW+Y/NqmztLcMLOYPvJ7p0rajktpemWpB
	eZXoYLLhBzS4b3P1PrhTqKNy3oY7jfKYthnCzxgQk9M5lKq124Qv9KzZXDtwrhOQctE13PVjx2n7E
	I1ZDVehw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7L8l-00000008a6c-3Zfh;
	Tue, 22 Apr 2025 21:26:51 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7L8j-00000008a5K-0Yw1
	for kexec@lists.infradead.org;
	Tue, 22 Apr 2025 21:26:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4C9C5A4BE3E
	for <kexec@lists.infradead.org>; Tue, 22 Apr 2025 21:21:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47A8C4CEF3
	for <kexec@lists.infradead.org>; Tue, 22 Apr 2025 21:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745357207;
	bh=9Hc5x03Xt6Q8VLLhD3mCqz80+X90ssoJI+f+CleuBKQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h/D7yWRxhbT0Tokd9yCp1wg9xCgigqp3o/yVm8u9b06tDs17VYlkXgDU2aKW+tBEW
	 yCFBWgaWcd9omhGXkDuPp7Lt9n5PqXhp+tTGMo9ams2ktewBPqhsq1gZcpvy0FHL19
	 Kzfr1/T+J+vS0tqDyftCuRmUR5Qdukw/vc+WnDWc8OJCiw4ChzEg9UgCLeqUobbDHt
	 fT9OYOrU03U/lBXrwh75XJJ+nGMz7uFFqrzPHi4ccGmIRSkGGIoHkpoDTdGy1jf0zq
	 7UYuaRvxExEQ/uuuaiRPfMFtyeRRyXUuO5bVqNWk3tNUQfdJkgjjHHwRz4FIW7A464
	 Gfm/LQFCLpQ5w==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3105ef2a070so56554481fa.2
        for <kexec@lists.infradead.org>; Tue, 22 Apr 2025 14:26:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKkS+2Bq/RSKbYR/K2uhuFP9qBmj6jk60NXSaPdSvDrxEmbfBZnJV0bKA0J5eggbPBoTeg3w==@lists.infradead.org
X-Gm-Message-State: AOJu0YzY4FZ9OUU+kkXG8DMB/x2iFAciwwIWNsuROpg61m0RfB3ohsss
	Wx8hxZ4a+Thzd7garvFP3QYAadjADPZz/Rsjygr1x7rByGZvrm24Q4Qc5pnNiwi92vtn352fQrs
	aNhDhT+PIXnUOX3oO0ojUpdcQduY=
X-Google-Smtp-Source: AGHT+IHNjwddJlnhR8ziXrRYCvaKzZHBeDFB7aTS+2S6/Juebmx60PYYbz8oxxdYeTQFH7iZZN2OhK0zcRmnc7XV21k=
X-Received: by 2002:a2e:9586:0:b0:310:749c:f8da with SMTP id
 38308e7fff4ca-310905bac8fmr43410821fa.22.1745357206245; Tue, 22 Apr 2025
 14:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250421162712.77452-1-ross.philipson@oracle.com>
 <d96f9c5e-64ed-4c28-a8ad-e22daea19742@intel.com> <c05731ae-bcf1-4747-b64c-0f4b79f3587f@citrix.com>
In-Reply-To: <c05731ae-bcf1-4747-b64c-0f4b79f3587f@citrix.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 22 Apr 2025 23:26:35 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHNpxTqm5hOcxdKRnE58WLmhJo0Rk5pvVGyAtkkki6bvg@mail.gmail.com>
X-Gm-Features: ATxdqUE-wCQ698lYIM2xY-XaLjiHODMSR6r5gfRYGnF_Ynuwr3onsuyDzkvTRu8
Message-ID: <CAMj1kXHNpxTqm5hOcxdKRnE58WLmhJo0Rk5pvVGyAtkkki6bvg@mail.gmail.com>
Subject: Re: [PATCH v14 00/19] x86: Trenchboot secure dynamic launch Linux
 kernel support
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Ross Philipson <ross.philipson@oracle.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-integrity@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org, iommu@lists.linux.dev, 
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, mjg59@srcf.ucam.org, 
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jarkko@kernel.org, 
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_142649_301138_6217A420 
X-CRM114-Status: GOOD (  18.83  )
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

On Tue, 22 Apr 2025 at 20:17, Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>
> On 21/04/2025 9:52 pm, Dave Hansen wrote:
> > Purely from the amount of interest and review tags and the whole "v14"
> > thing, it doesn't look like this is very important to anyone. Not to be
> > to flippant about it, but if nobody else cares, why should I (or the
> > other x86 maintainers)?
>
> There are several downstreams already using this as a part of their
> overall system security, one example being
> https://www.qubes-os.org/doc/anti-evil-maid/
>
> It's all giant out-of-tree patch series (in multiple projects; Grub,
> Xen, iPXE too).

... and this is the main problem: All the existing protocols and
layering go straight out the window, and are replaced with bespoke
alternatives, for booting but also for secondary bringup, etc etc

Conceptually, the secure launch could be performed under the hood,
e.g., during ExitBootServices() when doing EFI boot, and the OS would
have to be none the wiser (or at least, not need 100s of additional
lines of opaque assembly to be able to operate in this mode).

The fact that all these components need such intrusive changes in
order to orchestrate this pivot to the reduced TCB constitutes a
spectacular failure in design IMO, but AIUI, the software side is not
really at fault here: the layering violations are intrinsic to the
hardware support in the CPU. I'm sure Andy or others on cc can
elaborate on this, as they have done many times already.

So if that is true (I'm not a x86 uarch expert by any measure), then
pushing back on this series on the basis that it is ugly and intrusive
is not really reasonable. From security pov, I think D-RTM is an
important feature and it deserves to be upstream if it is used widely
in the field.

OTOH, if the arm64 implementation (which is still on the drawing
board) bears any resemblance at all to the x86 version, it can be
considered NACKed already.


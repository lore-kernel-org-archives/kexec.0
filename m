Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C237C3ABD8
	for <kexec@archiver.kernel.org>; Sun, 18 May 2025 14:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rAUybgx3w08Pk16V3V7ElWMaPW68BeTRsRpRxxQzxeE=; b=ka3puWS2c2uOm3oWzhno+eScoK
	kLoaNTNGrX4vOQRYMWZc5Jk065gtXWEaoMI8t5F2SvXkQwfv4NchcvlNasw/zh7h8O7wurL19DPnG
	Jdfrl964TrkbSGrYi2/4zLvXaAy8SvY7OI8ORqGfRC6S9tfa5HbSYSO71daEbdxFh6kwHnxbq00GB
	LU+Lh2dHQ2pLRrQtYew9WU1T6Y8JKJsRA2NZEzWS9HQJ1CqlxsCxMmUCP/HxvhHRcW/TPovo7dBeP
	g7ehh2RaAEcFzEt4tYTd8wFy3ztrOnVo11X55avG9B6OwoQX631CIPzu2Z4wlbP+/mk4Ar7C5PeTw
	YUEMhT3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGfDr-00000007CJi-3BkO;
	Sun, 18 May 2025 14:42:39 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGfDp-00000007CIZ-0doI
	for kexec@lists.infradead.org;
	Sun, 18 May 2025 14:42:38 +0000
Received: by mail-ed1-x542.google.com with SMTP id 4fb4d7f45d1cf-600210e4219so4856569a12.0
        for <kexec@lists.infradead.org>; Sun, 18 May 2025 07:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747579355; x=1748184155; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAUybgx3w08Pk16V3V7ElWMaPW68BeTRsRpRxxQzxeE=;
        b=LOQnPpNVg2ERvPMQHKbvbYel/5ckLG3pLmvoxeCy291S0Cj5UZy6kF54M+aDuXzJ1C
         MpQmeKXGsMd742qjhrHfYyqN8i8XKH9dgfRF4kfrX1WZ8n3rRZNHlAkV2V44lnGmiKoU
         IDSIIoGTfGK/ZFBh/IlB+6HswrzDqtbmGi6HAk19cgbJbFKPgzcYAWQ9cvKA+sxEYCrb
         EYMUt4P4DWUC5BiuxIjgC18RUSPNMzNByhl3iuR4tuWuETKhjPoBRU+8MEzsJyrz7KOC
         90KqeCy6Bi8DoePbQC8HN1KBnAMw4WxzHqeVKwTIBZ6TW0vaLd0krFlPbZ/+UBJRbCPW
         J5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747579355; x=1748184155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAUybgx3w08Pk16V3V7ElWMaPW68BeTRsRpRxxQzxeE=;
        b=jgYPgrTTCK2uYdnuJWvw5Lj5oWiHhqdudkasHdur17ymoBie3Wz9ysSPpwsHL5UNPf
         o0v/kfEREWPWklkKM32zlqLB6T8EfUTnxNB0S268zX0IZVyUMYtV3qotcHhfY3Iu4/Ge
         csyTT0RK0HeZDw4sydPPIm5ZGJNAL3q4frEzw6FReHpFf4jUnq1N/o73j4N+8rPMKk8v
         DtJEa3OtTWQ2mUX3lPkGWMUbTwi05GWH95uU9TlbSm81kZrHmC+vBIvUauEaImNMF247
         jDz7tzWMypcSTRQoqosOcPACR2PVoYAqwiJa8fXrTMDznZfk+8Ko5/ko1m6XzRi+7n0g
         QLKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqm1PbsOYFnAN4ShIonPQYoc5WBPgnD3bLYB4Yenyk2DS/0/OOYz3+RwmyeuCDqmg+napK+g==@lists.infradead.org
X-Gm-Message-State: AOJu0YxsuAG22OSIu8DSdNKKInlX38kOO7/ZP3mFtQxGc3NAqp5uzxrq
	B38MW4iiV6kW2kSTG+LmFLMeAAnd5E4lyMCnA3l9Sux3ORNlWMl3QswrwCsJfSyGXY6/MGWAeQu
	AUVgOG2tzyCd9yZyekMa/HkxCmm+Or74=
X-Gm-Gg: ASbGncsqB/wRSIQo2PfosaWiIjmccEWlg2gZ2VaGKRU3MMGCU9dFr+cd2Zll+U7Q2rA
	pJQNpRZTR1G9o49Bey/uMj50WQXcjifyl2Ze8WnTDK7ie9Cf2EzbDdP5T2RlV7tXtLWn8M2WmP2
	sa0YBcAJXE7jjIGIETboe+9guXhhUaYw==
X-Google-Smtp-Source: AGHT+IHB++m0GR0lO5TfW8cZq+R6bSxHcLUjm6jGofGJAl2FV1P4JdhTYEzSIBs2qV2FvWjm0WoY9STztiddXe/xN+k=
X-Received: by 2002:a17:907:7d8d:b0:ad5:4998:9f1a with SMTP id
 a640c23a62f3a-ad549a7e5e8mr600457266b.5.1747579354599; Sun, 18 May 2025
 07:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <18F9BD47-282D-4225-AB6B-FDA4AD52D7AE@gmail.com>
 <9b18e8e3-f3e2-48d4-839a-56e1d8f62657@intel.com> <03d0db6b-628e-4a5e-8e71-852233b83f60@apertussolutions.com>
 <fbb23ee0-c0b4-4b0e-8861-940f8ceaf161@intel.com>
In-Reply-To: <fbb23ee0-c0b4-4b0e-8861-940f8ceaf161@intel.com>
From: Mike <mikewallacesmith90@gmail.com>
Date: Sun, 18 May 2025 09:42:23 -0500
X-Gm-Features: AX0GCFuU42_TMoi_HKtSGmNW7XrkC1FL6iyDZjOSvOw7NwM1rf6CdCYLar4WcGI
Message-ID: <CAAyYeYjp0v2PYt1owTdOpQD8_NjakquyXbUr5M1a_OWLEKHQ0A@mail.gmail.com>
Subject: Re: [PATCH v14 00/19] x86: Trenchboot secure dynamic launch Linux
 kernel support
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Daniel P. Smith" <dpsmith@apertussolutions.com>, Rich Persaud <persaur@gmail.com>, 
	Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux.dev, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, 
	ardb@kernel.org, mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, 
	peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net, 
	nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net, 
	corbet@lwn.net, ebiederm@xmission.com, dwmw2@infradead.org, 
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com, 
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com, 
	Sergii Dmytruk <sergii.dmytruk@3mdeb.com>, openxt@googlegroups.com, 
	"Mowka, Mateusz" <mateusz.mowka@intel.com>, Ning Sun <ning.sun@intel.com>, 
	tboot-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250518_074237_188588_4E846F09 
X-CRM114-Status: GOOD (  13.75  )
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

On Mon, Apr 28, 2025 at 7:57=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 4/28/25 17:04, Daniel P. Smith wrote:
> >> OK, but why do this in Linux as opposed to tboot? Right now, much of t=
he
> >> TXT magic is done outside of the kernel. Why do it *IN* the kernel?
> >
> > There was a patch set submitted to tboot to add AMD support. It was
> > rejected as tboot is solely focused on Intel TXT implementation.
> >
> > This meant I either had to go the route of yet another standalone loade=
r
> > kernel or do it in the kernel. Doing it as an external loader would hav=
e
> > required a new set of touchpoints, like the one you are highlighting. A=
t
> > which point, I am sure I would have gotten the question of why I didn't
> > do it in the kernel.

Will this cause any patent infringement issues in Linux [1]?

1. https://patents.google.com/patent/US9075995B2


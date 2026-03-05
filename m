Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05117F47CC1
	for <kexec@archiver.kernel.org>; Thu,  5 Mar 2026 19:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BFL2J/Icfk5z6sblaLG86L1o2xcdsDyOfso7V9JzEr4=; b=UtACb1Ei3V2VN4Kz8xD4HWwuH7
	TpfRweOYJMtxqzVeVNM1S4tBpdl09BPF8kpdC4PE8Ip63p3eJfN/SWT/0r5A0HtijBgl3kHdp2oI5
	lNOJ69B9bIw+xfh/74+je/35VsVmvaIrfYRs6g6mPPWYHftyfVFSBvbo/e2kgja/nT+jJ8cEwqgRM
	Hh8UHueF+vOuraxa+2PtRurboa1fQQAXfhJ4ksDufIWV+23CW1dDOcczxmARHJWUfUKNrKrsIh0rP
	tE5EJvcPPeRqQ0bB1j1NevTrEvuI1LynQ8DqASsFraVXh5WXBXQDJE+sSwjD/4qw1mg/bC9NDfRtI
	oKobKWGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyEay-00000002TGZ-1meE;
	Thu, 05 Mar 2026 19:42:52 +0000
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyEat-00000002TG5-2M72
	for kexec@lists.infradead.org;
	Thu, 05 Mar 2026 19:42:48 +0000
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5a12fbbd9d2so1231093e87.3
        for <kexec@lists.infradead.org>; Thu, 05 Mar 2026 11:42:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772739765; cv=none;
        d=google.com; s=arc-20240605;
        b=fEBoM9w0g9f2n8q3v40LKtbpcEscIz4oD1YSXPBSMgjsn+zP7StXxn5LojKtbsGh7b
         WpCPeX1slZMZiWWnFbzd02p0m4u9PGir/H1tsciCZlQ4CotkNbum8Gh6Dz+gcN8lSoTN
         lCkiw1RyrQkjELsfWN6WRxVBcIFik5jqxMUJwtz0nQpDU37cKYI2bf0zvlpYsJc+GIcs
         LdKXfxqGrdnRrLvArl4Ram/hPfAcWEEF5z0Qkaasgj1oATV+StJ4AP1XR24Laee+xRjH
         09kJtguwwPLUlmYpqMBzcjc3zD748rLc6uB8jySTeTuHBC5KiYG4s5k7Os3ys5NUbGN3
         w7qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BFL2J/Icfk5z6sblaLG86L1o2xcdsDyOfso7V9JzEr4=;
        fh=Tzs/nzTIiR1S4c9KJC8+VbqcALRtBdA2rzlzdUynyNk=;
        b=dushu2mLATdDRV3yi1yD21SZiqXXz9gAz1RMjLN6O9E9Ms1zsfyuMOZtzSC+BBzRf8
         1VHmrpVR4DfCFfz+mZp4+3R8sIT/+mxxTkfw+Ml6/KOyHJ0dZhMAL2Ko2Fja7aSPsJaB
         q5e1MUnjhFoHEt3Iz8BL9BRzKbDZr5Rhzevo017HkjLtYSL8JOUNsGpjdlCuCMzT9Jcr
         FTPpR0sewqmI467SIIz0n/hkm0n8LVFYe/3PX5nq17bgQA1OfyXd3Uk/Jpa+gasr+T+C
         WoQuWsgGcqlhLr9EZ1HuGcTYlJBPmYNXLNXoPDUFqRHzKpM69P+4d+F8vyWiPhuI3bb3
         fmVw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772739765; x=1773344565; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFL2J/Icfk5z6sblaLG86L1o2xcdsDyOfso7V9JzEr4=;
        b=mbgGIIej30AVWWQVjvgcHFDOJF+fxaQ1+OHYZZmiYshLhQUJnZrAFSLzrKICaGJ6KA
         xptxbYVpnsq4LuL+gGeS1+eMBgVUDq7Q9zBdbrr5EROoWllGuXNy986BPNI1GTf6EALC
         15dEEZvMOvljhlPo8A/NbNw2Nq8JeUNssHThI1kr6xE3/Z8UEFuQ3KqlkVSuZLyRUI/3
         7vqz5uCqa4EW9LX/4f7yQ6NwlJlcJeOOxByMeFBLezxsxcCiYu3R5woTH9HAFrDMw3zd
         nfvKc99KBWLw9wNie+X+BS2azMLznpoO89jU5hYxuRS7Fn8D3/3/FQCWSPDN+dbdOHQ/
         FlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772739765; x=1773344565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BFL2J/Icfk5z6sblaLG86L1o2xcdsDyOfso7V9JzEr4=;
        b=wlR/EGn9yCfVen51mJbP6iIsmUm7Mjc+lH8MrNaMv/vYAHNFNBSBm9brbR13+GbvWn
         VXTm/LDkTZZPG4PIZ97dNBG/dmaYc52quAHSf9iM9e/bv7xToY+4P/nOmETaZpo+Fti5
         fknXW0GF7Gh14btifn9/ef1tk5oyE7lvspqA0wKZvf5+eNcZPUQKcKvtzhtVbA76ydio
         9L0nUfZMMMRsTDcOaQFXArdIqu+noguUmGC3xA9ewIepPG4+kh0juUPCgSgjw1lqKdF8
         eZsz96FoiM89Mk/AiUwQshOaXJ10JgYomCgsbtQfn8lrEmvHJ1I2TuiFR/nnjGlZIERK
         gWOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdzwb3kE8OUGnCacym24EzylHiT/J9HI/3Om7qg2f6ZXXyFhjyg529zl966FdKKF4TIDhRiw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzXl9/Exv5erA5SfPmIxX3JywUOqFkmQ/GWswrEVSNtTAmYm/0o
	XBghVm6tUMhn0TtSBroitBboOlPJGVE1s9QEawzxMaG416m0kEODCPHEJEFsdiL2gZCusigfQGC
	XS56Gp0AdscNloZnin0n19DxIZkXqPnYsieNNMZQT
X-Gm-Gg: ATEYQzxDQQ7B8VgR7RJZfn1KX7YDR4S+/SF5K4PmqdyzUa3YY1AgZVilfvKKYMxZe5z
	/kquiVL2Fyqebtg4xH1MXdbDmXyAE7HIt5Pcb3MCyayY2z4iflNqrGdbpx7zIVyVG2Uxn7Bn5MH
	9wAhId5/MkAPr10TouheZX/Hx1IPMPORrsmhh5L044wJJQRkydGMfihrDj/EFMGLeE7cj7dRw+4
	MA2BGdkqXfSpjidU46+bx4X0q2Fbf2MzYH0tQj2TrMJ5Yo36MQTMa19aRgPE4ndG9WJQVPZgXHV
	2W1nj5/5
X-Received: by 2002:a05:651c:1587:b0:38a:6f5:4b54 with SMTP id
 38308e7fff4ca-38a3c815300mr2046311fa.4.1772739764639; Thu, 05 Mar 2026
 11:42:44 -0800 (PST)
MIME-Version: 1.0
References: <20260129212510.967611-3-dmatlack@google.com> <20260225224651.GA3711085@bhelgaas>
 <aZ-TrC8P0tLYhxXO@google.com> <20260227093233.45891424@shazbot.org>
 <CALzav=dxthSXYo13rOjY710uNbu=6UjzD-OJKm-Xt=wR7oc0mg@mail.gmail.com>
 <20260227112501.465e2a86@shazbot.org> <20260301192924.GR5933@nvidia.com>
In-Reply-To: <20260301192924.GR5933@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 5 Mar 2026 11:42:16 -0800
X-Gm-Features: AaiRm52QizUmbxb_ZZJRNIFYAvXcIrsVMR2oGVyxQJsUboHWoi4G3a03BNBWEM8
Message-ID: <CALzav=deyfyzGXzSGmEbjvLr8Nn9Rpeh9w9JVk0vmb9FcURYPw@mail.gmail.com>
Subject: Re: [PATCH v2 02/22] PCI: Add API to track PCI devices preserved
 across Live Update
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260305_114247_632588_394F0830 
X-CRM114-Status: GOOD (  17.93  )
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

On Sun, Mar 1, 2026 at 11:29=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Fri, Feb 27, 2026 at 11:25:01AM -0700, Alex Williamson wrote:
>
> > There's obviously a knee jerk reaction that moving PF drivers into
> > userspace is a means to circumvent the GPL that was evident at LPC,
> > even if the real reason is "in-kernel is hard".
>
> Given we already have GPL licensed kernel drivers for the PFs it
> doesn't seem like a reasonable worry to me to fret about some cut down
> version of a kernel driver running in userspace.
>
> Further, let's be honest here, the people most interested in all of
> this are doing it to support their proprietary VMMs. I'm pushing that
> we must have at least a reference implementation in qemu before the
> kernel parts should be merged..

Yes, this is why we built VFIO selftests with the driver framework
[1]. We wanted to ensure Live Update support could be well tested
upstream independent of VMM adoption and without requiring complex
orchestration.

Google is also working on upstreaming Live Update support into Cloud
Hypervisor and the kernel pieces land.

[1] https://lore.kernel.org/kvm/20250523233018.1702151-1-dmatlack@google.co=
m/


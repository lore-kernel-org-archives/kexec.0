Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FEFE9A053
	for <kexec@archiver.kernel.org>; Thu, 19 Feb 2026 17:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UUE/Joru8hXMHvDVf62I8TaujuFRVcwhp9CDDO4vFKM=; b=ImKWYl2EkztNuyrsd/Pgo+hEm2
	rPSUUBju3P5sy4WArhXkvpkrPU/sVRJp4+8IUxDx2HO6+6dzAUnIo+zu51DKUn3VVg1Sp8ZTxL20o
	iHQHmhAYxid1W620iE0kUGsIB0LoO6aYbhM2cSevLCoa3AyWuZcIVhqkx9nAvFq9eTxyUDpPvnnri
	tU/w9/Aiawx0q7VovKtwEhD1wEACTC+Hc3HJkiqXVAB5Gepla5A4tk4ned9lM18vjxIPY+Bj11gZF
	dLFU9GFoo3WhqQk6J8UZz2J2fFNpWdXaE1HXOFqiiwB/vujQy3+eEq/dl4XDbbB7B8W4wOKrprFsP
	wDg+R8eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt7vP-0000000Bi85-2D0A;
	Thu, 19 Feb 2026 17:34:51 +0000
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt7vK-0000000Bi7U-0BmC
	for kexec@lists.infradead.org;
	Thu, 19 Feb 2026 17:34:47 +0000
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-59e5eaa491cso1628499e87.0
        for <kexec@lists.infradead.org>; Thu, 19 Feb 2026 09:34:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771522484; cv=none;
        d=google.com; s=arc-20240605;
        b=iy/yJmKIBxHru3uSeJRG4ZzKhp/co4RvgD4FKEFoP6TON1bvicD7PAFxmhzTGniJhs
         1Vata8DdeI2FQ+AhYgLgRSKebDp8aYaqidJyg6HCDbyTjIwMPeyIFhieCWMHZyGYRbYQ
         DPl6JRqf9NrO2CwhjDTPg6STWtqebjtMVbG3nKjcttJ51fAvtnKhOrJDz5wKoZMZFd8/
         xltDmibIdJ8lyh+qVIDTsRqYeEbd9fk7ds3xfVgReKRdUsZi+1/d6aNVPDZFZlvgIPVN
         otU9JflICo0bWWbJGJz9GBvoWN5OXFxG6WseNc8Sc2kyckB2LI/q76nLiKRGG1CbC5ip
         z5Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UUE/Joru8hXMHvDVf62I8TaujuFRVcwhp9CDDO4vFKM=;
        fh=wuEmpsxP4tHzhtNleOLQPgq1nirbaWVA4zrHJ0UcgDI=;
        b=YmPuU46HO15sIQbv6Z20nCHYmx4CHFbSAvYi26hjWySpt+3mE0dnNwDgVecY177FUW
         /0G/LUDFMzMdDXxGw/xClS5vpVH9WWQJn50d+m75f43jTra/ElN1EdMRCLYbbj4LoqV9
         zNtk962Ki+atNU8U33LnJ9QuMzP1PSwJhV4HvOzUcA2sQR//cJmKIlJGS2wcCUS+xGN3
         5E9lhxi9b01pFmX/QYLjsLDcLNKmMmA6jzc3Q1RyaBdom5Yl5IICMU3eWM2WQjfX+d3W
         72RmXljzc7hlR5naG11DZ+n/Q8bECZa8WH2fj5+0ZtgCQPe7CLDfk94bDr57HWxu3oTO
         SnLA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1771522484; x=1772127284; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUE/Joru8hXMHvDVf62I8TaujuFRVcwhp9CDDO4vFKM=;
        b=TFigxYd39HX13bvtAO8m8VBzyNklk5Mcl7F9OV8pTYX/eBHtHUWBJJDqiLcmBkhEde
         ZW9vy+oOlWSjMsbTDzqlyfA8X4quCr03vbkjVwasHQQvpcpQtzj4SzyKIeXIuaFipSRF
         yz5e3StiEoI/jdR6Eb7WgluGig1XUQ2BAhQ982LyFqXP1rLJ3Fk3UutVH3LSPCuTz8ni
         UGkL53hHM9tW+ZWPnerbM/C7WzgjUxRT2djQKNVGaSxiw9WoJwOc+CrB1xYNaNIkWtB2
         p74pc1ftgza22O+ooq5m7wdpQFgjidPNW2iwY+uA2w6dmfyyCNCIaYfUdKQQKMnfTG9r
         a9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771522484; x=1772127284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UUE/Joru8hXMHvDVf62I8TaujuFRVcwhp9CDDO4vFKM=;
        b=H80/Bu6rbW1nELHyjgQNAUZgwxelc48aWdqpaU0RQN0p6PWFNxgJNEud3DhHNFGvoG
         YhkeDQryWNnPZy8hzE6fhxOcsB6w4YlJn/y9oQu8e/BUtDKUpEtatgWfUm6uLIadxgdi
         0Ncm9oaThJGzHK05m1+u8mHDdcTK9i6KquYxifjZvii9ddUi1ycwlLxU0FkCnYgRDSob
         eHPR2vijLks3doL3SQ5EBrVCs7jnp9w8dPaNjGNJs5ns6roRgKy2k6M/WTBlCVDWPvLD
         Q8RcP5a/htFZMpJOVHCN9RMf2e5irwQtIBsNHhoMyvc2GKwoN8vkiBse61lOH4gk0gTk
         sD3g==
X-Forwarded-Encrypted: i=1; AJvYcCUlk1KEeORxjktbPjNwZix1hwjYtbPMWPvdZPhci1zzGtW27blxPWoP3Pd5y6hLBlYleB9QuQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxSFr2YA2sMphrMdHZgMlX9rdK2ueCGP4P8PPQD+z7JQ12YzdpN
	9RO4fn3MuYfQxofsXLlMybBcvGXl5pWp76/wjePvSaw8ddEd5LmHbgrUhRoWWZwmgXAVf/F8G+r
	n82GstosWmsgBUQv5u50+Bz3g+5bdlk7D7Q0ooYd2
X-Gm-Gg: AZuq6aJoyjrgPlyQgyeHbwTTOMzTS1R/FRFwdv4bbHVACVJJWuCR/k5FWXmJL94FwKw
	qbmrmAghoWGt/sXprj0la1MTv+x9nCuFDoBgnu9MsqdgzCzKljmjqjS4N3XZMe4CRGvoSVk5UBQ
	RFVEEEN4OXigA8QgtU2ga1KfustkPQ5IyafXbVSJKfPXoIp4lnVFguRK8jAcFktdSuShRVug17D
	k9wG0DKOybwuNS1KCawiQZHAQcp+LhY6nyBhKun7dAXlCAlOC6Sqwpli90NC5JkN83++Z7ItCe4
	q1bd
X-Received: by 2002:a05:6512:2242:b0:59e:5e07:17fc with SMTP id
 2adb3069b0e04-59f69c28542mr6061794e87.18.1771522483387; Thu, 19 Feb 2026
 09:34:43 -0800 (PST)
MIME-Version: 1.0
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <b5f2b5a5-b984-4ed3-a023-c06d634f9146@app.fastmail.com> <1ffd3cb5-2c76-4371-a067-3e4849907d80@apertussolutions.com>
 <49d169bf-0ad2-49be-b7d7-fceb9e7f831a@app.fastmail.com> <CALCETrUE8c-dxRWhtHKz_PojwZuWMXJSzOsFQf2vt5LS3ATwpA@mail.gmail.com>
 <1BBD7449-8420-43FD-930B-A4E1BA38FFC6@zytor.com> <CALCETrWzG1Mjb-RcwLQ5-tGFZ15WKHjZbqtLvyif+UPuVKJ_5g@mail.gmail.com>
 <32e62cef7b89d9691bdd4120388ce752fd041230.camel@redhat.com>
 <CALCETrUMR0RvOFXGzL7=F4c-3veL+1Sm2xf-BprHTK4=UKw8yA@mail.gmail.com> <558d0f28-01fb-4447-891c-2ffbf869c077@app.fastmail.com>
In-Reply-To: <558d0f28-01fb-4447-891c-2ffbf869c077@app.fastmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 19 Feb 2026 09:34:31 -0800
X-Gm-Features: AaiRm522PbtXXP376kUUKctZtEGG7xWnV2UAINAeVODac9_j4h5cpV1OS3ViHZU
Message-ID: <CALCETrWynypSD7vEjJNLcym3JhBw4k0ovDiR_3YuOHh92TnM=A@mail.gmail.com>
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Simo Sorce <simo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, 
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
X-CRM114-CacheID: sfid-20260219_093446_335433_4A37991D 
X-CRM114-Status: GOOD (  49.29  )
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

On Wed, Feb 18, 2026 at 11:55=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> On Wed, 18 Feb 2026, at 22:54, Andy Lutomirski wrote:
> > On Wed, Feb 18, 2026 at 1:04=E2=80=AFPM Simo Sorce <simo@redhat.com> wr=
ote:
> >>
> >> On Wed, 2026-02-18 at 12:34 -0800, Andy Lutomirski wrote:
> >> > On Wed, Feb 18, 2026 at 12:29=E2=80=AFPM H. Peter Anvin <hpa@zytor.c=
om> wrote:
> >> > >
> >> > > On February 18, 2026 12:03:27 PM PST, Andy Lutomirski <luto@amacap=
ital.net> wrote:
> >> > > > On Thu, Feb 12, 2026 at 12:40=E2=80=AFPM Ard Biesheuvel <ardb@ke=
rnel.org> wrote:
> >> > > > >
> >> > > > > On Thu, 12 Feb 2026, at 20:49, Daniel P. Smith wrote:
> >> > > > > > On 2/9/26 09:04, Ard Biesheuvel wrote:
> >> > > > > ...
> >> > > > > But would it be better to disable the runtime services by defa=
ult when doing a secure launch? PREEMPT_RT already does the same.
> >> > > >
> >> > > > So I have a possible way to disable EFI runtime service without =
losing
> >> > > > the ability to write EFI vars.  We come up with a simple file fo=
rmat
> >> > > > to store deferred EFI var updates and we come up with a place to=
 put
> >> > > > it so that we find it early-ish in boot the next time around.  (=
This
> >> > > > could be done via integration with systemd-boot or shim some oth=
er
> >> > > > boot loader or it could actually be part of the kernel.)  And th=
en,
> >> > > > instead of writing variables directly, we write them to the defe=
rred
> >> > > > list and then update them on reboot (before TXT launch, etc).  [=
0]
> >> > > > This would be a distincly nontrivial project and would not work =
for
> >> > > > all configurations.
> >> > > >
> >> > > > As a maybe less painful option, we could disable EFI runtime ser=
vices
> >> > > > but have a root-writable thing in sysfs that (a) turns them back=
 on
> >> > > > but (b) first extends a PCR to say that they're turned back on.
> >> > > >
> >> > > > (Or someone could try running runtime services at CPL3...)
> >> > > >
> >> > > > [0] I have thought for years that Intel and AMD should do this o=
n
> >> > > > their end, too.  Keep the sensitive part of SMI flash entirely l=
ocked
> >> > > > after boot and, instead of using magic SMM stuff to validate tha=
t
> >> > > > write attempts have the appropriate permissions and signatures, =
queue
> >> > > > them up as deferred upates and validate the signatures on the ne=
xt
> >> > > > boot before locking flash.
> >> > > >
> >> > >
> >> > > *If* a physical EFI partition exists there is a lot to be said for=
 this approach.
> >> > >
> >> > > The only issue with this that I can see is for things like network=
 or CD/DVD booting where there isn't necessarily any EFI boot partition, it=
 might not be writable, or it might not be persistent (e.g. http booting ty=
pically uses a ramdisk, like the old Linux initrd.)
> >> >
> >> > Hmm, I guess my approach is a 100% complete nonstarter for installin=
g
> >> > Linux from a CD, and it's really not awesome for installing Linux fr=
om
> >> > a USB stick.
> >>
> >> Doing any of this on a removable device feels generally like a trap.
> >> You get your USB disk in, try to boot, and it saves vars, but reboot
> >> fails for whatever reason, you plug it in another machine ... and it
> >> tries to "continue" from there? The amount of validation needed and
> >> testing for failure modes across reboots sounds really painful.
> >
> > I kind of stand by my other previous suggestion, though:
> >
> > As a maybe less painful option, we could disable EFI runtime services
> > but have a root-writable thing in sysfs that (a) turns them back on
> > but (b) first extends a PCR to say that they're turned back on.
> >
>
> After setting the EFI boot path to GRUB (or systemd-boot or whatever) at =
installation time, what other meaningful interactions do we expect with the=
 EFI runtime services?
>
> And given that the secure launch is orchestrated by the bootloader , with=
 which the kernel has a backchannel via its configuration file, it should b=
e rather straight-forward to implement the staging of variable updates ther=
e if we really need it.
>
> Doing any of this at the EFI/spec level might lead to a situation where t=
he OS now has to guess which of the provided APIs to manipulate variables i=
s the least broken.
>
> Of course, for readinf variables, dumping the RT variables into a memory =
buffer at boot time and exposing it via a EFI config table would be rather =
straight-forward, but it is also something I feel should be the job of the =
boot component that takes part in the decision to shield the runtime servic=
es from the OS.

So there's sort of a usability issue here.  On the one hand, this can
all be orchestrated to work.  We build a kernel, and the kernel
supports secure launch.  Someone makes an installer image, and that
image is configured to skip secure launch, then install to disk, then
program EFI vars, then reboot.  And the installed image is configured
to do the secure launch, and EFI variable writes are turned off.

On the other hand, this all sucks.  I'm getting sick of having the
kernel tell me that I am not permitted to do things.  I'm sick of
writing software that deals with unnecessary restrictions.  If I were
writing an OS with a USB stick-based installer, I might want to be
able to boot the thing and decide later whether I'm installing an OS
to disk.  (In fact, many USB installers work this way.)  But, in the
model where EFI variable writes are hard-disabled on a secure launch,
the decision to do the secure launch happens before the decision to
install an OS, and we all lose.

So I'm proposing that EFI variable writes be treated a bit like kexec
[0] -- root (which is already part of the TCB for any practical
purpose) is going to decide, like a grown up, to execute some code
that it doesn't fully trust -- in this case, the EFI variable writes.
And root will coordinate, correctly, with whomever it's busy using the
TPM to coordinate with, and tell it that it's going to do something
that will change its trustworthiness.  So it works like this:

1. Secure launch the environment on the stick.  (At this stage,
neither the boot loader nor the kernel has the faintest clue whether
anyone needs that secure launch, but this doesn't matter.)

2. The owner of the machine clicks "install".

3. The installer makes some partitions and writes some files.

(Up until now, the security posture of the running environment has not chan=
ged.)

4. The installer decides that it's now time to do untrustworthy
things, namely writing EFI vars.  So it unmounts anything it mounted
using TPM-sealed keys (or not -- this is between the distro and
whoever trusts the distro), and it does:

# echo 1 >/sys/.../extend_pcr_and_unlock_efi

which *first* extends a PCR because we are about to change our
security posture and *second* sets whatever flag permits use of EFI
runtime services.

5. The installer writes to EFI variables.  And the installer can no
longer generate attestations to its previous security posture, which
is the correct behavior.  And maybe the user can no longer unlock
their home directory or whatever until they reboot.  Which is not
really a big deal.

(This is *dynamic* root of trust.  In theory the system could do a
DRTM re-launch and recover its security posture, but I don't think
this is implemented.)


One thing I like about this is that it involves very little code.

[0] Do we actually handle kexec intelligently?  I have no idea.  I'm
still getting used to the time that gdb fails half the time because
someone has a strange concept of security.


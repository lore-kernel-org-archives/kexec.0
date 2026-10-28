Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61265606A31A
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 14:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zeG5cECw;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eCZuuK8G
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6CnDrX+La+2Fu6jP7wM+lot0uCoQlPoWp1MsRc4XNYs=; b=zeG5cECw1QPCuFzuRKX3ydNtfv
	LLsSCwhP7ZbdOHS5KIBgFi7yw2haeYwBObpHK9xrVC1sEB9kstpU87AP5F36n5wKlXo38GeYzPtic
	A9/KHZnkYLnl/v+gJ/P37I9hkVJI2URCX4VqoQSv75wYn+dJEruNBW7VwnjKJFroHk/XrQT6KQgB/
	b/EWbPHKx79TKNkcz6eBd+mivkLL+nYFOjfICzP5Va9bLFpXv4oecgj1MyE/zBLHFY5Vxg306CNZ8
	egevKRC9VUUiDeiB7+DqWLU3kavPMVfXvSL4CiVGSyFWE0twrpM9HK3CHBL0al1UlE4GtTKUVy8C5
	J0M9SXhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM4be-00000007CTo-18sN;
	Wed, 28 Oct 2026 14:26:22 +0000
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM4bb-00000007CT9-1a0T
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 14:26:20 +0000
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-8b05bf699easo10252737b3.2
        for <kexec@lists.infradead.org>; Wed, 28 Oct 2026 07:26:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793197577; cv=none;
        d=google.com; s=arc-20260327;
        b=A8i9oJEk1pBEQLLY1TZjdiN8cB/9sQo+TXlrz8To1+FaTQ5S+ptsInnyrCkJkNGWWP
         0uVFKGqveGxycwUxeaBgsvCSBb86nr+HebWd7wBkVVTzDVkgqfDuafigKbUgqE/MYv0P
         k99jgnUC6GFPHlrfuvKi5hte+GJPewhGd2K2ctHHLEf3QeHZesxRklSthY2AzDZy5S0Z
         IQyV3fvy9aVP29lVdWpQOSRliutKo+fw9G13466L8mz9z+r3YVJCWQs/VRP6iSFmn5sk
         L6MNyaA+gmzIcO4RbbcCfP8L26PRuTWP36QyYuDsGNqusWXshmwsTd7SoNdteObqTOV2
         lsFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6CnDrX+La+2Fu6jP7wM+lot0uCoQlPoWp1MsRc4XNYs=;
        fh=AKi5uDq2O2K/cpxZmCR7/kbHxqKd4i9O6DTIcetTK1A=;
        b=qOJ6vAdZO2akcD3BVECJxBeQ7vZeqmsQkUlZ7ejkueLYiX57MsSS229/Idne5YfXRM
         m/GpOStx0YLKuA/OvUDrFgts2W2vzQuABMBRvEDLeSlczCfEi3cDLZjyanrk1iK20Qft
         OxZXhsZlI+Db8d8TRb4wb7f8h/+JunLljpzZnhLISczC3oMauSz3U2ZEb7U7AoODwqmI
         010ip3oKIYh8c+7Isc4J8rE//yguBr8DK+QzIYfTXFv/CmgWPniNq/oLtinbEWSRog3U
         KwZuwlpyBiJvbOs1ZMGWSPKEoNbWKXsZyfu0x9p8PbpOg/Lz6Gle7sO/Yz5iQ1PDURP8
         0NFw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197577; x=1793802377; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6CnDrX+La+2Fu6jP7wM+lot0uCoQlPoWp1MsRc4XNYs=;
        b=eCZuuK8GQaCxBnpGf4/jC/HoiRPUGXC5g+4PCKeoPUsR7HVrSAHa6R7q4ZfXMPX3yN
         F31y5gjTbUsOdDtMsXLO/xPErmyo9KhjpvsW7mvcVLLEMFWOPiYPv0gA2FSpPvJ7wDZ7
         JSCjca/EEOhIIovhvJ7fp6cfCR9yce3ZCBRpuCqGuwseMION7ENqs7h8h6Sw6tLDyMx2
         iZNs+1feGYpicZmbIZ4M/L0NRB5X91TyrMgFDHtYKftrZINk6OH7X5i7Wo6DsHKs/zo2
         u2mDSz5MWzKxWKj4rpEbbY2loNHmCikIbft8oPXZZsmnM3N3ZryDdVWoyobdw/TpORyx
         xh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197577; x=1793802377;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6CnDrX+La+2Fu6jP7wM+lot0uCoQlPoWp1MsRc4XNYs=;
        b=2gonrbERO9ijqxf1k2m/B5Zm5RhrMw76OA6n/4xVaI+BdpOAi++5Lakwp0fPKeqAfp
         O85OM1VzpKLEOxgoYGv7ubPlfAN62P/5BOrroIf18nlG3VckV+mbBW5Huk2bHqlXytXg
         /mE2h+RmpHoSvISjA9BPa2kFqK1jBPgBUcNHMTWfQrnGSfTycuMo5ydVEOLL6MK4R3bM
         5vBx3QTPxogBzmpArweRcU5pIHJuDch3Ws/ZYrT8cQ34yM9W+F99CtYkEjuDp6Q5hkNC
         S3VQi9RuxiKQcw+KMjmmtIGpcK/2yOA85L1NwpCOTQ+Uk1ZFjvIi7P6zbeDInX3ha5f7
         eByA==
X-Forwarded-Encrypted: i=1; AKwUvBz/7QJbPxv6EYaVfk7Sy7QwuibPRdyIEHUL/8TjbGh7Q01d31YXt5scn24oybB8vhUURBhN9w==@lists.infradead.org
X-Gm-Message-State: AFq9FYJ/AncAm7wi+fvXUSpl2ghQppVICOCwHlX8LP/LiY6slsjYCCAm
	r29jmSiQAgTXlfKpNfiopO2u4zjDiBOH5M9rbP7vLU4xLGg47R9fhD/TkKN6gIOCa7EyC5f8jVA
	+GhPmxwkvJBtoO9Cmh6zPssP7ZF4l9gY=
X-Gm-Gg: AYBFou29kMGTqI8uhJ6/w1PbA78nJUOw+aoAubmwdgSuHWYnWLyR01DJYR9DoRzw6aH
	bRcKmzOjafhq8HW+xr+3wZ0gONc0uYHxhFJjjC4R1o3bBZcEpL4HnPCYnl9PQyhx1oooWJtfasr
	oApwOf6IzlnFXFDyVXqhmho6sF51XUoOxkSzcQR7an6SniE1LgZ3hrZBlU8/d/35fjb2+lFUK8W
	dgfch3dimxMkLCQfx3kVAtz3NS9xX/Ech02anHZBg45U+VpgxhRnWCEslS+Fl22copHZEoeKaXY
	9HOB8nI2MYVXOCbK5DftWUmpc4J+JF+oSy6f0VLm5R/9pTa8LbEZMujdmU3KrVmDaBBECeUk4lZ
	VC3JA1nWpUau4ir9+Km2rUcPFlniDMfCGUJJT+kQWOu71GFQTiaBwTLTl8oNwbWOHlwhyPCQ=
X-Received: by 2002:a05:690c:e90d:b0:8b0:d42c:54e9 with SMTP id
 00721157ae682-8b1b5c9953bmr12024777b3.34.1793197576747; Wed, 28 Oct 2026
 07:26:16 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
 <20261019-b4-ipe-keyring-rfc-v1-1-156f0b93e843@nvidia.com>
 <702ade20-a2f3-4919-97e6-c72faa89399a@kernel.org> <20261021-groll-donnerstag-erfuhren-ce34a0ed4e97@brauner>
 <CAHC9VhTHUU0h9k74CMT6wYhMwyY3YhbSSFwJoDTvoFRyTFVZwg@mail.gmail.com>
 <20261022-hausbank-dozent-hurtig-9443f3777475@brauner> <CAHC9VhQ4sdCRvJ+YPZoiQzR_hgQN6-=84qvnTDDGPf=7=L9-jA@mail.gmail.com>
 <5143896100674c9fd744c4d7d6ce12232910e789.camel@gmail.com>
 <CAMw=ZnR54hMBwGTps23t9Mm_VO1bAvmeX8uTf_VJ0rJsFNMLuw@mail.gmail.com> <37b653494cf282c6e428e2ae8fd781a0ea69bf3f.camel@HansenPartnership.com>
In-Reply-To: <37b653494cf282c6e428e2ae8fd781a0ea69bf3f.camel@HansenPartnership.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Wed, 28 Oct 2026 14:26:05 +0000
X-Gm-Features: AclHuK_2pDead4oUBgww1V4NOQP7FrJJqtxPGmwYbVPNkoSmhvEEW-kSQFaRSpM
Message-ID: <CAMw=ZnQU0PRSn5gh-QNT+GuKroQaRsRUUMDB=rM=LSX+=h-JkQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] ipe: add the .ipe policy keyring
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Paul Moore <paul@paul-moore.com>, Christian Brauner <brauner@kernel.org>, Fan Wu <wufan@kernel.org>, 
	Manuel Huber <manuelh@nvidia.com>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Andrew Halaney <andrew@amutable.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_072619_430296_2D282EA1 
X-CRM114-Status: GOOD (  40.75  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 28 Oct 2026 at 12:42, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Tue, 2026-10-27 at 11:07 +0000, Luca Boccassi wrote:
> > On Mon, 26 Oct 2026 at 12:57, <luca.boccassi@gmail.com> wrote:
> > > I think there is one issue with the design pattern where keyrings
> > > are set up in userspace, that I have mentioned a few times already
> > > and I got documented in
> > > https://www.freedesktop.org/software/systemd/man/latest/systemd-system.conf.html#RestrictFileSystemAccess=
> > > as well: they are trivially bypassable if the kernel has kexec
> > > enabled and it is signed. The security model relies on the "good"
> > > userspace running first, but if kexec is enabled, there's no
> > > guarantee that will be the case, and as far as I can tell it gives
> > > root trivial capability of overriding it and extending the trust
> > > chain as the attacker wishes.
>
> The attack sounds doable, but it also seems to be exploiting a gap in
> kexec policy: kexec is supposed to behave like a warm reboot so if boot
> policy requires UKI only then so should kexec and that sounds like the
> thing that should be fixed.

I don't think that's the case though, even before KHO/LUO existed,
kexec has never really behaved like a warm reboot, as for example boot
services do not run again, so various chains of trusts are not reset
(eg: a bootloader might now be blocked so warm reboot would not work,
but kexec would). And since KHO now exists, the difference is even
greater, as more and more state is retained across the boundary.

> What's the mechanism boot uses to ensure UKI only? So we can see if it
> can be adopted to kexec.

There isn't one, and I don't think there is correlation, as booting a
UKI is not the only way to boot a system. Eg: this problem applies
just as well to booting an arm system on uboot. So I really would not
tie this to UKI or UEFI specifics, it's more generic.

> > > This is of course not to say this new IPE keyring shouldn't be
> > > added. But perhaps it would be nicer if the default build flag was
> > > mutually exclusive with kexec being enabled? Not sure if that can
> > > be expressed in Kconfig though? default: yes-if-kexec-off, no-if-
> > > kexec-on
>
> I wouldn't do this because a) I don't think it's an IPE problem, I
> think it's a kexec one and b) distros get very tetchy about hard to
> solve feature anti dependencies.

Note that I wasn't suggesting an explicit conflict, but merely to
model the default values of the kconfigs with such a relationship,
allowing manually setting any combination the user wants. But it was
just an idea, maybe it's not worth it, dunno.

> > > At the very least IMHO this relationship should be documented
> > > explicitly in the kconfig blurb, as it seems to me it's a major
> > > footgun to leave laying around, and users might not necessarily be
> > > aware of it.
>
> I'd document the need for trusted userspace on kexec if it was a boot
> requirement, yes.
>
> > KHO/keyring folks, what would you think about preserving sealed
> > keyrings across kexec via KHO so that the chain of trust can't be
> > reset by userspace? Good idea/bad idea/yes send patches/no go
> > away/etc?
>
> Well, yes, we do have a similar problem with the trusted keyrings.
> They're actually initialized from the shim created ..RT variables
> (which are volatile, but don't die on kexec).  On first boot they're
> initialized before user space, so we know they came from shim (or
> another trusted component in the boot chain) but if root uses UEFI RT
> services to add to a ..RT keyring, the added key will appear trusted
> after kexec.

If it is possible to overwrite the RT variables then yeah it sounds
like we want to preserve the machine/platform keyrings too via KHO.


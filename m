Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C49C369D1
	for <kexec@archiver.kernel.org>; Fri, 25 Apr 2025 11:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:Cc:Date:Message-Id:
	Subject:Mime-Version:From:Content-Transfer-Encoding:Content-Type:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NxUaPsRL3DayWO3frv2ULqEXQAoXMSOznD4LncXDA04=; b=oZM70Ho5Hl7+7Ls2GrJ8CCMajr
	zc0rsvYNLVyVLLL8+xzCdGMd/UXw4zfLJmnCUEPq0qwf2oixjNmPTg9F3Jy4o1votxmF1x58WY+BU
	U5dYpA5TNh3tOtwJwJJwqzcfxAJkBwZvg8VDyPr4ZXJOJeYfo2AX7x6iQ2MVeQbg76ytQjuND/8px
	NMI+jmUpGs8CKLQvH6zXrsMgGtFe415cExZgJ99d4qZfMf+e+ueHc5VQMMBoFG0QlGwoRh2dJK1H4
	VFXziLOFQLUCQmcTqnkPuIKzZXUX16V1CXJB+K9DsNxHnmpVRsG7ZHZRrjf/8hFoPGuqXJYHb6+ty
	n41USu2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8HKn-0000000Gz3c-3hEq;
	Fri, 25 Apr 2025 11:35:09 +0000
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8G3J-0000000GgO0-2FPK
	for kexec@lists.infradead.org;
	Fri, 25 Apr 2025 10:13:03 +0000
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-5259327a937so843334e0c.0
        for <kexec@lists.infradead.org>; Fri, 25 Apr 2025 03:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745575980; x=1746180780; darn=lists.infradead.org;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NxUaPsRL3DayWO3frv2ULqEXQAoXMSOznD4LncXDA04=;
        b=chVke30ayLixd1P4AqYAFiu7pPPBV+szHuFvI+2DTtSR2HivHoMCGQ3JqtEUB0vfen
         3+Ebp8U78dUkywWhwG1xp82M5VqpcpI4jpGY7kURjMRU5Ftc7LzVLRSR6F6saaX3CeNO
         HH7H2XY31t0AS9IESi1Ed4CUyQhuiZyWfLvhW2LgPMCJugqCTABdMWRRQELsXse7tT81
         32Ov56mC+e4LrhvhdN1hHMy43iGODOylhL8BPJHXfIrxKYb2Zz1WkUK9RsefE8gqDeX8
         MNU4G8lintYSgtP3LfXc7QPNAhgm2BHqYsTSZKXVrWG9GMoP9fWAotvjfwcuym6LQHOl
         p8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745575980; x=1746180780;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NxUaPsRL3DayWO3frv2ULqEXQAoXMSOznD4LncXDA04=;
        b=szU9vDWFzQyJz3q1O0hoWUh9C+ci6f8AIwPmJAUy3Fx93Bgs3mCpi37eDw3empt3zM
         S0dmnDTRWREzl9Vvv3uxm1VyABAbZu/4E3w02m4R7/JLR4l1vMa1CmyMCfbKB36Q+Owc
         gchsRD+vPO6t7CLYyz6vVxdMKj5Tp/2J0P60pgv5KoEblArIgDtquZrwMH9TgmhgA7wE
         CPvpWARS3nIOuHUPR44hmdIrO3Tzjw+oLSbtJUA9BY/NLp12IkRTFBySgyqdKYrmBKvi
         jKXMUi5WyQyrDRTemXnA/pRhySFSzsNxyudK7IKsKQz2Sab2OWZd9/gQuUQ6pjkD95MN
         rldQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyyhGfXPPT1WXApfFr+W7ciq2U9zQXz6FGaNCdEm+mAfnCjoDarXo05uwYzaxyeSGLPAT3FA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxSgaDydEFUTQU1gMNVZyLEbjmOQZd0diVTXXLcxgixojXC2PwX
	+Yfj5VDVqSsMhhUhSab2Ou1f+AStsu5hbhx3DIvUxiy7VS3aInev
X-Gm-Gg: ASbGncuer6YGeJMIsraw+zP2KZqOG6xfLpc4HnwDKWc8jg17zqlc0TqaFxjaacUzksG
	+pz9+bLWX3ZA1TIrqLRhDtQseQGv7w8T9qMquoCv5nMaM501sX4MkpHVV0/ifRopzzmM07geEYD
	D8jeEXbdl9RnOZ8EBq6pFqfGNGUVlgqn0f/fisGSBCWA7ujxR4QguiOuypOgV5I6wFyl+P8GMPw
	9JbLRSs0auY2Q5oDxBaSC9uH9FFoeFxzDgO+yLPCf5bdHG1HtZi8hEr1M4+b9gFY5Lqj5FV65yN
	wVJWN7I8dx/y2eXA3F58+FiE508OwzWeYA4Hhw0x94j0o+R5GB1UE1SMX6JJuUdBk2VzCocA1KY
	gZENfSSzp7PnSrRD/
X-Google-Smtp-Source: AGHT+IGiA/Yn603iCEcUZTepPAJSDOP4M4TDfO1zGDg1GjK6jBe0wK+uDj0rtvLjSeP4gVl0jlYXxQ==
X-Received: by 2002:a05:6122:da5:b0:50d:a31c:678c with SMTP id 71dfb90a1353d-52a89d3e399mr831693e0c.2.1745575980041;
        Fri, 25 Apr 2025 03:13:00 -0700 (PDT)
Received: from smtpclient.apple (216-131-82-239.nyc.as62651.net. [216.131.82.239])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52a79f21b86sm605458e0c.9.2025.04.25.03.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 03:12:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Rich Persaud <persaur@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v14 00/19] x86: Trenchboot secure dynamic launch Linux kernel support
Message-Id: <18F9BD47-282D-4225-AB6B-FDA4AD52D7AE@gmail.com>
Date: Fri, 25 Apr 2025 06:12:46 -0400
Cc: Ross Philipson <ross.philipson@oracle.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev,
 dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 corbet@lwn.net, ebiederm@xmission.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com,
 Sergii Dmytruk <sergii.dmytruk@3mdeb.com>, openxt@googlegroups.com
To: Dave Hansen <dave.hansen@intel.com>
X-Mailer: iPad Mail (22E252)
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_031301_567931_5606790A 
X-CRM114-Status: GOOD (  17.20  )
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

=EF=BB=BFOn Apr 24, 2025, at 2:45=E2=80=AFPM, Dave Hansen <dave.hansen@intel=
.com> wrote:
> =EF=BB=BFOn 4/21/25 09:26, Ross Philipson wrote:
>> This patchset provides detailed documentation of DRTM, the approach used f=
or
>> adding the capbility, and relevant API/ABI documentation. In addition to t=
he
>> documentation the patch set introduces Intel TXT support as the first pla=
tform
>> for Linux Secure Launch.
>=20
> So, I know some of the story here thanks to Andy Cooper. But the
> elephant in the room is:
>=20
>> INTEL(R) TRUSTED EXECUTION TECHNOLOGY (TXT)
>> M:      Ning Sun <ning.sun@intel.com>
>> L:      tboot-devel@lists.sourceforge.net
>> S:      Supported
>> W:      http://tboot.sourceforge.net
>> T:      hg http://tboot.hg.sourceforge.net:8000/hgroot/tboot/tboot
>> F:      Documentation/arch/x86/intel_txt.rst
>> F:      arch/x86/kernel/tboot.c
>> F:      include/linux/tboot.h
>=20
> Linux already supports TXT. Why do we need TrenchBoot?

One reason is to generalize DRTM support to other platforms.

RFC: Trenchboot Secure Launch DRTM for AMD SKINIT=20
https://lore.kernel.org/lkml/cover.1734008878.git.sergii.dmytruk@3mdeb.com/

OpenXT.org measured launch usage of tboot originated in 2012, when I was the=
 program manager for XenClient joint development [1][2] by Intel and Citrix.=
 TrenchBoot was proposed in 2018 at Platform Security Summit and evolved [3]=
 based on LKML and conference feedback. The tboot community was introduced [=
4] to TrenchBoot in 2022.


> I think I know the answer, but it also needs to be a part of the
> documentation, changelogs and cover letter.
>=20
> Also, honestly, what do you think we should do with the Linux tboot
> code? Is everyone going to be moving over to Trenchboot

OpenXT will migrate development of measured launch from tboot to TrenchBoot S=
ecure Launch, after upstream Linux and Xen have support for both Intel and A=
MD DRTM. Previously-deployed Intel devices using tboot, derived from OpenXT,=
 will need support until users upgrade their hardware. Qubes is integrating [=
5] TrenchBoot into AEM (Anti Evil Maid). Since Oracle has spent several year=
s working on this TrenchBoot series, they might use it, hopefully they can c=
omment.=20


> so that Linux support for TXT/tboot can just go away?

[opinion]
Which one will prevail? That may have less to do with tboot-trenchboot diffe=
rences and more to do with AMD-Intel product marketing and OEM segmentation o=
f DRTM features, some certified by Microsoft as "Secured Core" clients with S=
MM attestation (Intel PPAM and AMD SMM Supervisor).

Intel requires client vPro devices for TXT, but has slowly expanded the list=
 of eligible SKUs via "vPro Essentials" segmentation. AMD SKINIT is present o=
n most processors, but DRTM currently requires a dTPM instead of the "mobile=
" fTPM implementation in AMD PSP firmware, with dTPMs mostly present in AMD O=
EM "PRO" or Embedded SKUs.

If AMD included the full TPM 2.0 reference code in their PSP fTPM,  or if MS=
 Pluton implemented a full TPM 2.0 that was compatible with DRTM, then the n=
umber of AMD DRTM-capable devices would be much higher than the number of In=
tel vPro or AMD PRO devices, expanding the market for DRTM-capable software l=
ike Linux (trenchboot) Secure Launch and Windows SystemGuard. That would inc=
rease client adoption of trenchboot, as the only option for Linux DRTM on AM=
D.

On servers, both AMD and Intel hardware support DRTM with dTPM and other roo=
ts of trust, but there are other launch considerations, including BMCs, SPDM=
 device attestation & vendor hypervisors.
[/opinion]

In a perfect world, Intel-signed ACM (used in TXT DRTM) binary blobs would b=
e accompanied by public read-only source code, with reproducible builds that=
 generate those ACM blobs. In that perfect world, Intel ACM and tboot develo=
pers would review the TrenchBoot Linux series, recommend improvements and gu=
ide customers on migration from tboot to upstream-supported Linux DRTM. Neit=
her has yet happened. Both would be welcome.

Rich


[1] https://www.intel.com/content/dam/www/public/us/en/documents/success-sto=
ries/3rd-gen-core-vpro-citrix-vendor-spotlight.pdf

[2] http://media12.connectedsocialmedia.com/intel/11/9510/Air_Force_Research=
_Laboratory_Security_Collaboration_Government.pdf

[3] https://trenchboot.org/events/

[4] https://sourceforge.net/p/tboot/mailman/message/37631560/

[5] https://blog.3mdeb.com/2023/2023-01-31-trenchboot-aem-for-qubesos/



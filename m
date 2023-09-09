Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65841EE14AA
	for <kexec@archiver.kernel.org>; Sat,  9 Sep 2023 17:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:Cc:To:From:Date:References:
	In-Reply-To:Message-Id:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ELrmyVa34LfQY33n0M6C+dZ5MDGfIQtnFWMN3CFt0uk=; b=dGDlhD3HYUdzLo
	dH8Az4k3+nZDKF6WEpcXo7A4BnHccXxpyQahER0q3MaelJsjQ0JnSbkMGEFqrGwY9OP3FHKkTiV0r
	mkDfAeVCv1iM/QZW1lPeSTV+PiedgiWsqDPHbCg24GGizktGdOefz9jtmixXAYtxdJvzzi8rgnSbB
	588kJxzcpeJmvKiEMjYrqR196A2LmhTAKK+PegBw/KpcDVRK7KhwMsy+sBcBMF+Vl4XY9HeeQL746
	k1POGjs9zzYjsDJWkIhSAXUc6oq7mT3dUNgcJ6IYyH8XDsAWVp1QYOypzLSWnPJzRrWOrt7WdQjQT
	T3DVynkxXHcZ1FXLIR6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qf2EF-00FgLh-2V;
	Sat, 09 Sep 2023 17:58:43 +0000
Received: from wout4-smtp.messagingengine.com ([64.147.123.20])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qf2EC-00FgLL-0o
	for kexec@lists.infradead.org;
	Sat, 09 Sep 2023 17:58:41 +0000
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 7A6203200915;
	Sat,  9 Sep 2023 13:58:35 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Sat, 09 Sep 2023 13:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1694282315; x=1694368715; bh=kz
	fQfbD4H0h1eVP4XE03NxUwAQnVnu2GWtpn9ElctzI=; b=iQHRGv7n2P0Iu0lgUu
	q1VaaMYEWNb3Yljns1enh64TgG2naQ4FGTdscA4l4/WZ6T882PoG41gjfGWu4tbQ
	tbIVAdzqu24XwI7xBvUTvvaWW5mzbYABvw5uGGFwbHyW91BzYObAAauyDLYr15Ji
	VdmfK8wOzQti/Gvg3+spltK5uY45UUZ0deNMblo2Wn4vcu/aC4w73BhMJLo/bABT
	W0S/9VGLNCg6BdC3h8h8AcrfEvng8GtHKlEGhXmbviMlAvk+uydXIbjU6DAGyfq8
	9biylLJx7bLpCP4dWpd/nLPIYBEpNy/yTJnW0JRO80oIetKtXaGdolHC0XaqepCS
	Vz9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1694282315; x=1694368715; bh=kzfQfbD4H0h1e
	VP4XE03NxUwAQnVnu2GWtpn9ElctzI=; b=OG8L8gGqmb+H6oqbYvA8drV2fIeG1
	3mX+xmlqNLJonvpBcA53CV2RsDpVvOV6HcIV9GGfwMUGpEgh93PDre9mXPNRO3PS
	YIsLU+T4CgEe5D5WT1Yhs1qxl29gn4AmHEEFjRoNWcfPkeJS01as9j+O8WC+ovC1
	BfZb1CkMUzczJSblw5KVbRlsdYKRoR1nox8SdKSRvatLicew9SuZwsHMPsFJXVY4
	pi7TbRYS9wTW0c2kFdDTh+cu1dPcDZux1yKT8fkRBl87ifaOb2/BL/pJ05JP5Z/j
	YpGLYy3JKslPOBth7JGPub71UOiHAV45Vdj1JRQN7UXTrLR947zKl7i3g==
X-ME-Sender: <xms:SrL8ZPsQAt5YXtlr3Egoccj8k3Wcua0m7I8fRt228As_N7ncroYV_g>
    <xme:SrL8ZAfZfPvwY40c_cMmGOJgXuVevNVqp4sJYF13Obhz8Y1zc0vceN9gljCW3SsYr
    m9MzuNeNdisSFsf9l4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehledguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdduhedmnecujfgurhepofgfggfkjghffffhvfevufgtsehttder
    tderredtnecuhfhrohhmpedflfgrnhcujfgvnhgurhhikhcuhfgrrhhrfdcuoehkvghrnh
    gvlhesjhhfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpeffffeufefhiedvfeehgeev
    ffffffduvdduhfefjeekgeeviefhuddvgeekvddvhfenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkvghrnhgvlhesjhhfrghrrhdrtggt
X-ME-Proxy: <xmx:SrL8ZCwK-VrOTsm5ia085m9jcCKunKhxCP2iImHIZoZTPQdUsiBffQ>
    <xmx:SrL8ZONIoEgYxO6ljafhdqFQYbwchY_ZvlCnKgykNghrbYLgRcI7RQ>
    <xmx:SrL8ZP--QjUWDMIV__rsPbGkRVOb_Dshc-AIXD4xlAIU4E2or-FmGQ>
    <xmx:S7L8ZA0PY8dT4Ik5njquLVDDPTnOXzyJMOoTkdaW3tR3ITeN5apa1A>
Feedback-ID: i0fc947c4:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1516015A0091; Sat,  9 Sep 2023 13:58:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-711-g440737448e-fm-20230828.001-g44073744
Mime-Version: 1.0
Message-Id: <5c94f7f4-697f-4388-9243-009c0c2d745f@app.fastmail.com>
In-Reply-To: <CAMw=ZnT-Ck-Y4i-MZAf99U5nzgDaj-q8UPRH_c00JgGMtUy_QA@mail.gmail.com>
References: <20230909161851.223627-1-kernel@jfarr.cc>
 <CAMw=ZnT-Ck-Y4i-MZAf99U5nzgDaj-q8UPRH_c00JgGMtUy_QA@mail.gmail.com>
Date: Sat, 09 Sep 2023 19:57:09 +0200
From: "Jan Hendrik Farr" <kernel@jfarr.cc>
To: "Luca Boccassi" <bluca@debian.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
 tglx@linutronix.de, dhowells@redhat.com, vgoyal@redhat.com,
 keyrings@vger.kernel.org, akpm@linux-foundation.org, bhe@redhat.com,
 bhelgaas@google.com, lennart@poettering.net,
 systemd-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230909_105840_629319_ACD9AF7C 
X-CRM114-Status: GOOD (  14.95  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

> - the cmdline section is actually optional, just like it's optional to
> pass it on a traditional kexec load, so it should be used if present,
> but skipped if not

Should be an easy fix.

This should be updated in the UKI documentation as for other optional sections it's explicitly marked. I assumed that in the case of an empty cmdline the section would still be included but empty. Or is that semantically different: empty .cmdline section -> no cmdline allowed, no .cmdline section -> user can specify cmdline in bootloader?

> - the dtb section also is optional but supported, and given kexec
> supports loading a new dtb I think this change should support it too
> immediately.  Moreover, we are adding support for multiple DTBs in a
> single UKI (by simply having multiple .dtb sections, and picking the
> one that matches the firmware), as a stretch goal would be nice to
> support that too, but it can also come later

As far as I know dtb is not supported by kexec_file_load at all at the moment. Maybe someone here knows more about this. I'll look into it.

> - also what would it take to support arm64, which is the other major UEFI arch?

I'm not familiar with UEFI on arm64, but I can certainly look into it. I assume it's not gonna be that difficult.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

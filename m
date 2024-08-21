Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD32BC52D6F
	for <kexec@archiver.kernel.org>; Wed, 21 Aug 2024 15:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5lpHcoIhye85u9lQSvnGE6w7ZI4PdVv7VTdCMF+ptNY=; b=hfnv7UWp4LJ8lV
	VfMWipnrhzDdiLDuhOGkgvtJ9buYLHK8Sdr6WvFK6R1rCzTDpyOXco13BYK2dZ9qDIArpZRG0Isvd
	MQOrIdF0SqXqDNrbKPLiMFlknleWqTAwZEiSYquvkvbSq02N+EUDRp6eRJ8CLlB5+1Z1S3HrdfqVF
	v11H5hcEX8ANJbrielgu0/HuWb9JtgGE70xC6XEMoNFxgmE0mqcspiASzDBzqeMfAIMcDUBSc4rJO
	PUTQX9NYM09SEIpIelU2+2Hd8hmkqZJWHsTGWV5xbeY3pOj6bUCfmfwaowRQfsxoORMTf/gzdta2q
	SCbTWltSeAfZ5DjqrbAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgnWt-00000009ZF3-3ohT;
	Wed, 21 Aug 2024 15:45:47 +0000
Received: from gardel.0pointer.net ([85.214.157.71])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgmSp-00000009LBQ-2Pgv
	for kexec@lists.infradead.org;
	Wed, 21 Aug 2024 14:37:34 +0000
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id 953C4E80807;
	Wed, 21 Aug 2024 16:27:13 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id CE5BD16008A; Wed, 21 Aug 2024 16:27:12 +0200 (CEST)
Date: Wed, 21 Aug 2024 16:27:12 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Pingfan Liu <piliu@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>,
	Philipp Rudo <prudo@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
Message-ID: <ZsX5QNie3pzocSfT@gardel-login>
References: <20240819145417.23367-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240819145417.23367-1-piliu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240821_073731_781407_24085097 
X-CRM114-Status: GOOD (  13.92  )
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

On Mo, 19.08.24 22:53, Pingfan Liu (piliu@redhat.com) wrote:

> *** Background ***
>
> As more PE format kernel images are introduced, it post challenge to kexec to
> cope with the new format.
>
> In my attempt to add support for arm64 zboot image in the kernel [1],
> Ard suggested using an emulator to tackle this issue.  Last year, when
> Jan tried to introduce UKI support in the kernel [2], Ard mentioned the
> emulator approach again [3]

Hmm, systemd's systemd-stub code tries to load certain "side-car"
files placed next to the UKI, via the UEFI file system APIs. What's
your intention with the UEFI emulator regarding that? The sidecars are
somewhat important, because that's how we parameterize otherwise
strictly sealed, immutable UKIs.

Hence, what's the story there? implement some form of fs driver (for
what fs precisely?) in the emulator too?

And regarding tpm? tpms require drivers and i guess at the moment uefi
emulator would run those aren't available anymore? but we really
should do a separator measurement then. (also there needs to be some
way to pass over measurement log of that measurement?)

Lennart

--
Lennart Poettering, Berlin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

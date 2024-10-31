Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CCCD767FA
	for <kexec@archiver.kernel.org>; Thu, 31 Oct 2024 19:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pzIHMwnCu2j7KqNlvqe2qLjHqyfnLuPicYM7uzv25J8=; b=CXccF6xblGUpgY
	9/kCZFwX5V4p0naoaE8vYotIE9FFefjngKJa8Tik92FL+Zl8m7xCuVuHVxi2qSy9RdCTipGx2rqPm
	5dBFhlC7FEeUIAF4n5eNvvlwq1JqHQX0JT+urPSHnL+VtohNAAbAyxwTnUj28F2YVwYy7NZcLmqCx
	fIlM0xqS8pzWsFBuZD9Ro6YjF7rUjQwDw5QDlerqeWBOBBbUCk3eY0uJBdLrI+bC9qWZVe2uIkJO6
	L03h8BWw0ytEMSHZRdQ+q/eqyBWsAdQsGMEYATYXubNTavn1ZZi/Zb3hsGsgzyJ5PPu0SSgTRNtOx
	tkYusvf+Jlax7gQB6rrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6anM-00000004d5S-49EC;
	Thu, 31 Oct 2024 19:25:25 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6anF-00000004d2X-3glb
	for kexec@lists.infradead.org;
	Thu, 31 Oct 2024 19:25:20 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730402715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iQ+EOPL/V+hQ49Yycx1LmMX/gDzsFgIKjYT1P4zOubs=;
	b=vjv/af64u6mEzqmtnnI2LLHwiqEAbrxeScDOJDQ+xzgfhak0wuopvAH75wdHaIGtILg7Kp
	LBDNN9rPonxWJ3T8l0/HV9iryIEYfgsBQUF7r5Zox6rqNLupQFThwE8ly2YxgrkxPa3CSg
	PQ82uXnIJ6u+kIKsgqNiA1TG0v3YV3DOtR7hk0lMhdv3ZRjXU4sIV/dr5oTriImAIGnyvn
	HebLhfFGMDQtogeuUdmDzfhYi8MAoL8vmU4sCzAIig+g6oeq8werbC0UFQDPGjt+fFl3hu
	0Fk4o8uuFPl/rHsJGYUO4vgPg5P1k3AkC4/pzZXkFGKiLPowTyt1u8E9aRU2wA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730402715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iQ+EOPL/V+hQ49Yycx1LmMX/gDzsFgIKjYT1P4zOubs=;
	b=O304umbi8H6l/f1CHjtv+6rKM+lfYXngXWnPnxmhIZB2RBZrwBkxEAZinNpNMu0Vi+7AWR
	5tv90Kg2ggamzjAg==
To: Ross Philipson <ross.philipson@oracle.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: ross.philipson@oracle.com, dpsmith@apertussolutions.com,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
 James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
 jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 corbet@lwn.net, ebiederm@xmission.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v11 00/20] x86: Trenchboot secure dynamic launch Linux
 kernel support
In-Reply-To: <20240913200517.3085794-1-ross.philipson@oracle.com>
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
Date: Thu, 31 Oct 2024 20:25:14 +0100
Message-ID: <87wmhoulb9.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_122518_080509_EEE1E348 
X-CRM114-Status: GOOD (  16.34  )
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

On Fri, Sep 13 2024 at 13:04, Ross Philipson wrote:
> The larger focus of the TrenchBoot project (https://github.com/TrenchBoot) is to
> enhance the boot security and integrity in a unified manner. The first area of
> focus has been on the Trusted Computing Group's Dynamic Launch for establishing
> a hardware Root of Trust for Measurement, also know as DRTM (Dynamic Root of
> Trust for Measurement). The project has been and continues to work on providing
> a unified means to Dynamic Launch that is a cross-platform (Intel and AMD) and
> cross-architecture (x86 and Arm), with our recent involvment in the upcoming
> Arm DRTM specification. The order of introducing DRTM to the Linux kernel
> follows the maturity of DRTM in the architectures. Intel's Trusted eXecution
> Technology (TXT) is present today and only requires a preamble loader, e.g. a
> boot loader, and an OS kernel that is TXT-aware. AMD DRTM implementation has
> been present since the introduction of AMD-V but requires an additional
> component that is AMD specific and referred to in the specification as the
> Secure Loader, which the TrenchBoot project has an active prototype in
> development. Finally Arm's implementation is in specification development stage
> and the project is looking to support it when it becomes available.
>
> This patchset provides detailed documentation of DRTM, the approach used for
> adding the capbility, and relevant API/ABI documentation. In addition to the
> documentation the patch set introduces Intel TXT support as the first platform
> for Linux Secure Launch.

So this looks pretty reasonable to me by now and I'm inclined to take it
through the tip x86 tree, but that needs reviewed/acked-by's from the
crypto and TPM folks. EFI has been reviewed already.

Can we make progress on this please?

Thanks,

        tglx


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

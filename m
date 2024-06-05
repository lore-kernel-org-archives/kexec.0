Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C18C27C53
	for <kexec@archiver.kernel.org>; Wed,  5 Jun 2024 11:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fxCOegVY+DMSF8c+qxB2iQy4eZvDXmOOL8u/yg4Bnmw=; b=FWM1TxWE68YMFk
	wSrnRRWGdZRKADJ45tdBqhGosqB3f7enURrChsyY8kx3gL0ha8ihO/wpXRScKf9d0OdzDddBjFceC
	rdpob7FfO+Rym+FNE0N1LgqXZDBHzfMKYZWAZZT2iP9KbZtzgbLBJuSwN1IQpcFR1YOxAeXsV1LIL
	MtWoGhNAM41hFwWVoXSPYdRRGph8h9p5Z2WQ4+TN9lMIL2gRsQfZjhaK2ebjRERvuyUltHUcdAld6
	5h8kMpDB4rkYeiHn9y0WUWiklrI67ulDbBVvvmDSJATryQN+CzfoNZ5gp+eDPYzuUzsscVUH6bjrc
	HQz3iDdZWF1Cr64D3Jtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEoch-00000005gEl-3znI;
	Wed, 05 Jun 2024 11:16:07 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEoce-00000005gCC-2c45
	for kexec@lists.infradead.org;
	Wed, 05 Jun 2024 11:16:06 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5CC1E40E0191;
	Wed,  5 Jun 2024 11:16:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2MM_uH0b_vZ5; Wed,  5 Jun 2024 11:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717586158; bh=MyNP/8A3mneC0TU0vkHmFz9QbD6ZPJz2lnq7g0nJwME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=asNtDGm0aWrqbbyqfz8gB/pIkAwBrS0jW1fszHDBAAE73YTZ1RXmITordyLpNuAhX
	 tUz7P7b7vWLs+JLMUA35+eo4pHvEJXdcODIEuYvYcNEAP7586+vjckHFwuDboH1ljM
	 OE5XYQzs1qvsg5G4qWvi5TqHshLp5wFVV/fBxmdsChG0uOrJSWAxt17BAD+0TRbTWy
	 ye+MDYoA+c3o8gUTX9RQqa19pNy62l6UKhx+TT1AWuKyorUWYwmnhHQ5sCDFTyxMpV
	 UQwfYaQTey+ui3KYvP+gHOXsKX/n2Nc62GvrjxlA2Y+DEqRE9zk+iPtEZTBnI6SSIt
	 ZGQFLFMOp6qDBWAadS70VF9O8UUJIlmRQ1lFlZybAyEYnhkd5CBWvrtSI3nAHZ/gzm
	 4Sr/r0cb7UGb/VMo/3bBRtYjavnG1zO6gfSR02K9obmsBgFXoUSziNzeTJJNRER5aX
	 Py1DQa6A1lYwmXiw6mFSSky198TDK0p7NWndsTKW9JDo9+RkmCerytU3W94k7rDZQg
	 IxoiUgrhUHgJDTBSiMzkXxnNyGUSU0v723hRw990dEOJUGPu4JYGi8mta1rgJ6FzXn
	 4FkfWdMKfAdj5xWNC3fq9Nyno77B4x1ZMMiPutVhTMC5YVy+u5Pk78y9vfPKQ+jSUK
	 xiThwe6cbzf+amDt7WH8S3Ys=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2559440E016E;
	Wed,  5 Jun 2024 11:15:29 +0000 (UTC)
Date: Wed, 5 Jun 2024 13:15:27 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Dave Young <dyoung@redhat.com>, Mike Rapoport <rppt@kernel.org>,
	"Kalra, Ashish" <ashish.kalra@amd.com>, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	rafael@kernel.org, hpa@zytor.com, peterz@infradead.org,
	adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
	jun.nakajima@intel.com, rick.p.edgecombe@intel.com,
	thomas.lendacky@amd.com, michael.roth@amd.com, seanjc@google.com,
	kai.huang@intel.com, bhe@redhat.com,
	kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Message-ID: <20240605111527.GEZmBIzwpsrai31qWT@fat_crate.local>
References: <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local>
 <Zl3hwYL2GDiyUfGo@kernel.org>
 <CALu+AoSnA4323QbQG7wrNptosz7tfEfztsE1=o6G=FaLbQ_tKQ@mail.gmail.com>
 <20240604094358.GBZl7h3otTCYJ5rkkt@fat_crate.local>
 <CALu+AoS=-=PbMRxC-1rpfSTPpMOmM5BGRBjLhDwgOC3=4C71ng@mail.gmail.com>
 <20240604180212.GHZl9WpAfNVERTjMqw@fat_crate.local>
 <CALu+AoRqNmsWXi+HXYNYTY=pXJ3sLTLKyXNeJz9EoxEsHzFdQA@mail.gmail.com>
 <20240605074257.GAZmAXAbkc5TGVds5u@fat_crate.local>
 <CAMj1kXFweoskB_qnUFA1b+QXWhjovwMfpM00cGb9KMcm4Zr7EA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMj1kXFweoskB_qnUFA1b+QXWhjovwMfpM00cGb9KMcm4Zr7EA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_041605_245314_60A82B4C 
X-CRM114-Status: GOOD (  19.22  )
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

On Wed, Jun 05, 2024 at 10:17:22AM +0200, Ard Biesheuvel wrote:
> I'd argue for the opposite: ideally, the difference between the first
> boot and not-the-first-boot should be abstracted away by the
> 'bootloader' side of kexec as much as possible, so that the tricky
> early startup code doesn't have to be riddled with different code
> paths depending on !kexec vs kexec.

Well, off and on we end up needing to be able to ask whether the current
kernel is kexec-ed. So you need to be able to access that aspect in
kernel code - not in the bootloader. Perhaps read it from the
bootloader, sure.

But see my other mail from just now - it might end up not needing it
after all and I'd prefer if we never ever have to ask that question but
just from staring at EFI code it reminded me that we do need to ask that
question already:

        if (efi_setup)
                kexec_enter_virtual_mode();
        else
                __efi_enter_virtual_mode();

*exactly* because of EFI and that virtual_map call nonsense of allowing
it only once.

And we check efi_setup here because that works. But you can't use that
globally. And so on...

> TDX is a good case in point here: rather than add more conditionals,
> I'd urge to remove them so the TDX startup code doesn't have to care
> about the difference at all. If there is anything special that needs
> to be done, it belongs in the kexec implementation of the previous
> kernel.

Sure, but reality is not as easy sometimes.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

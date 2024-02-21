Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3EEC48BEB
	for <kexec@archiver.kernel.org>; Wed, 21 Feb 2024 23:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fIHdS3KppgW9vF7LdwDx7q6aDmc69ZVVTHhdEUrq/2A=; b=sBokdhf7Lfh/nF
	Rei+0rOydeneLC4r1bO4oaOpPjYGkg4AMIZNkoCVokMK3q/zdW0kR9utOLn20a0u04USC2k8wGp2n
	pCJ+ZeDoG9+pPdEyFNzy+Uaj7srsafU+Shf5GtrsoxPr5upidMsBmvsGbeRrylF+rxtZmowU4jhF9
	woM8/PcBeht4UVblAykWck2AcAwXuUxztEUvJK7k7J29bfzU+SdFMRxQLQmSWqHvVFKVZNCHrk3I9
	s211TIteziLQwxLYNFyY1xoan/lI+i7lIRt2MbiX8HRhiEzbQOY1mkuamfzMJiEXWURrdNaeAHj0S
	09/5ERwm6DNLFufSOGVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcvww-00000002tJt-3CCX;
	Wed, 21 Feb 2024 23:24:26 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcvwt-00000002tJ8-3Wro
	for kexec@lists.infradead.org;
	Wed, 21 Feb 2024 23:24:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 80A9B61519
	for <kexec@lists.infradead.org>; Wed, 21 Feb 2024 23:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F993C433A6
	for <kexec@lists.infradead.org>; Wed, 21 Feb 2024 23:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708557862;
	bh=o0pBvdU+JHgT39C/oZ43v61yIgxOBybqfEpddDffT+s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Uo6j9C+3yRULLuhfUameeJdnFArY/DJQDmDNfb1NtvgSUoJu5xf4jfx3Gzy+QWSD9
	 /Ki6xXWWXFKWco2i+oBjemS298yxFH2zmONSAJcVKpgnn5ASa+vrnmQIpFxASzABp+
	 xoSQLSGYl7MTRjNIb7yQfurBY6V9FXK8ivBg1ovDs85Q1KUONIJVWj5xmY8Ur8JYYU
	 fZHc/w3kaVNWAkptQF2laAOVKKd9frUPsRF+EkoYYE7i6AHxoYzxa8iLUf660a9KUD
	 GjhfnDzRtt2+7CtEkm91mWF+v2OU9tMK+ATcehpGg8SBuGV4NPe2dcC3yYgKO2TTcg
	 nGOx4pK29xnCA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d2509c66daso25066001fa.3
        for <kexec@lists.infradead.org>; Wed, 21 Feb 2024 15:24:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVeNp0P4xamI+RDt9sWCq97AVocoR4+0Z/py9N3QiCV+uP70vzPiX0YcmncjB1o841LvPeRvbaqS9Xb2rwzAUicb4+cXiW6gB8E
X-Gm-Message-State: AOJu0Yw6Ivi+K5ttNhENs5pf5zq76ElNB77ZQHPNLbGYKnGsr0cLKoCj
	2pDEbcCwnRMZGW1wH8bqDvx2pbkrQHAS49g/60S/UbX2KHnIG5ztNUEbwmGpgDcil4Ro2dS/MiH
	st0wks33E2sTSHL1JsWzb6y5G0TA=
X-Google-Smtp-Source: AGHT+IEFjS3UH7erXEZ4kbkF96yuQm9TlfZ1AWhPucU81wH0eazr9XKjePangSR6zBzRuAu+rhDmfGqI9zl7A6Q+3YI=
X-Received: by 2002:a2e:b8c8:0:b0:2d0:c77c:b1ca with SMTP id
 s8-20020a2eb8c8000000b002d0c77cb1camr14950388ljp.49.1708557860236; Wed, 21
 Feb 2024 15:24:20 -0800 (PST)
MIME-Version: 1.0
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-16-ross.philipson@oracle.com> <CAMj1kXF3k_c4Wn9GU+NC_+_aYfDpAzAUnfR=A4L_T+re1H3G=w@mail.gmail.com>
 <dc53f100-062b-47ae-abc8-5414ce8d041c@oracle.com> <C98F883A-31D5-4F67-97FF-4AEFAADDDC74@zytor.com>
In-Reply-To: <C98F883A-31D5-4F67-97FF-4AEFAADDDC74@zytor.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 22 Feb 2024 00:24:06 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFYVbCd3EaweseNndhmOwdbzEmvB1vjWk2rmTBxAoPCxg@mail.gmail.com>
Message-ID: <CAMj1kXFYVbCd3EaweseNndhmOwdbzEmvB1vjWk2rmTBxAoPCxg@mail.gmail.com>
Subject: Re: [PATCH v8 15/15] x86: EFI stub DRTM launch support for Secure Launch
To: "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>
Cc: ross.philipson@oracle.com, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, dpsmith@apertussolutions.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, kanth.ghatraju@oracle.com, 
	trenchboot-devel@googlegroups.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_152423_988844_B02A47D5 
X-CRM114-Status: GOOD (  23.57  )
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

On Wed, 21 Feb 2024 at 21:37, H. Peter Anvin <hpa@zytor.com> wrote:
>
> On February 21, 2024 12:17:30 PM PST, ross.philipson@oracle.com wrote:
> >On 2/15/24 1:01 AM, Ard Biesheuvel wrote:
> >> On Wed, 14 Feb 2024 at 23:32, Ross Philipson <ross.philipson@oracle.com> wrote:
> >>>
> >>> This support allows the DRTM launch to be initiated after an EFI stub
> >>> launch of the Linux kernel is done. This is accomplished by providing
> >>> a handler to jump to when a Secure Launch is in progress. This has to be
> >>> called after the EFI stub does Exit Boot Services.
> >>>
> >>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> >>> ---
> >>>   drivers/firmware/efi/libstub/x86-stub.c | 55 +++++++++++++++++++++++++
> >>>   1 file changed, 55 insertions(+)
> >>>
> >>> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> >>> index 0d510c9a06a4..4df2cf539194 100644
> >>> --- a/drivers/firmware/efi/libstub/x86-stub.c
> >>> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> >>> @@ -9,6 +9,7 @@
> >>>   #include <linux/efi.h>
> >>>   #include <linux/pci.h>
> >>>   #include <linux/stddef.h>
> >>> +#include <linux/slr_table.h>
> >>>
> >>>   #include <asm/efi.h>
> >>>   #include <asm/e820/types.h>
> >>> @@ -810,6 +811,57 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
> >>>          return EFI_SUCCESS;
> >>>   }
> >>>
> >>> +static void efi_secure_launch(struct boot_params *boot_params)
> >>> +{
> >>> +       struct slr_entry_uefi_config *uefi_config;
> >>> +       struct slr_uefi_cfg_entry *uefi_entry;
> >>> +       struct slr_entry_dl_info *dlinfo;
> >>> +       efi_guid_t guid = SLR_TABLE_GUID;
> >>> +       struct slr_table *slrt;
> >>> +       u64 memmap_hi;
> >>> +       void *table;
> >>> +       u8 buf[64] = {0};
> >>> +
> >>
> >> If you add a flex array to slr_entry_uefi_config as I suggested in
> >> response to the other patch, we could simplify this substantially
> >
> >I feel like there is some reason why we did not use flex arrays. We were talking and we seem to remember we used to use them and someone asked us to remove them. We are still looking into it. But if we can go back to them, I will take all the changes you recommended here.
> >
>
> Linux kernel code doesn't use VLAs because of the limited stack size, and VLAs or alloca() makes stack size tracking impossible. Although this technically speaking runs in a different environment, it is easier to enforce the constraint globally.

Flex array != VLA

VLAs were phased out because of this reason (and VLAISs [VLAs in
structs] were phased out before that because they are a GNU extension
and not supported by Clang)

Today, VLAs are not supported anywhere in the kernel.

Flex arrays are widely used in the kernel. A flex array is a trailing
array of unspecified size in a struct that makes the entire *type*
have a variable size. But that does not make them VLAs (or VLAISs) - a
VLA is a stack allocated *variable* whose size is based on a function
parameter.

Instances of types containing flex arrays can be allocated statically,
or dynamically on the heap. This is common practice in the kernel, and
even supported by instrumentation to help the compiler track the
runtime size and flag overruns. We are even in the process of adding
compiler support to annotate struct members as carrying the number of
elements in an associated flex arrays, to improve the coverage of the
instrumentation.

I am not asking for a VLA here, only a flex array.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D047D75E3A
	for <kexec@archiver.kernel.org>; Fri, 22 Nov 2024 13:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ft4564hHBGkICUTkZjOLlmPFHPv4/CYfCDRSgrLHfNA=; b=u+VULrJlxifM47eSViAIjVP+qb
	FrSqcGqTr7SmEnz60TGSQTasmR/aIZyw1gnSJFBaGg2mX16OhNqx1a+NMLYLUIJjDW2iwhgL2ACSt
	eSJUFJ6UzDM/f/2CbV1O2lLmEjlHp/FYN8tC1AzLRAQ7MciZ/cB4rBPv7Xtn/Ddzy7i7IG4PepihY
	fQ7MjeONnOuZh7Dz8O+XeSz0b7CP5vHBURX3rJ8AzXB6/iqHm144ygJcEK8S98YYMfP3RGi3WM+XQ
	dfZl2h2/PqDcQgA8txBZdH3FSE7mHuaqZeWT0eTaeAe+/hLq1CMiDwkHguO6m69vyondUr6yMF47A
	AXJ+fPJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tETKL-00000002ViL-0Ye8;
	Fri, 22 Nov 2024 13:04:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tETKI-00000002Vhy-3aTs
	for kexec@lists.infradead.org;
	Fri, 22 Nov 2024 13:04:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732280637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ft4564hHBGkICUTkZjOLlmPFHPv4/CYfCDRSgrLHfNA=;
	b=K/P1owA2WyQkFBA27jWS8Jgg9Ij0UYZ/80iZgEixAT22sheVfNKAZn9d/3CJ/Mv7ejyOMY
	n3qn1sO+EjAtGQv9py0uCvofWoEMuVoNbquOBx+rohHoWc1lQWTSsZl0P98EUDcNrUimzT
	vJ9RukJC53s2/ZNhlC8mKEqJH5Be9B8=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-ZiF0W4-QPayvFl9nTnSflA-1; Fri, 22 Nov 2024 08:03:56 -0500
X-MC-Unique: ZiF0W4-QPayvFl9nTnSflA-1
X-Mimecast-MFC-AGG-ID: ZiF0W4-QPayvFl9nTnSflA
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6b9f3239dso24593115ab.0
        for <kexec@lists.infradead.org>; Fri, 22 Nov 2024 05:03:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732280636; x=1732885436;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ft4564hHBGkICUTkZjOLlmPFHPv4/CYfCDRSgrLHfNA=;
        b=lMJzOiqzQ8hu1YlmOmq+WqCYM2YmxWmCLtP6CzaUziZfpE7P8RZ7CKUevWhdr5Q+HH
         hQ4oTDNm/8L57GUcA8o+/O8VZWw2qNrRw/pZu9dT8YNark5vTVGdgM/NgwVY+K8atJb9
         wV6MR6qyJLQiijQnsc0C0jfYdY1AuRW3oAH2Napu1v+r92vKg3zlJ5lfDkGq/L7vxB0L
         mP6EO/UMhbiyVpV6lXs9RqH0d9xLlJ5Ah3+WSTbtDaTDUmpsW9LK/5f4/7sQlv3iGdy/
         KDMD5MiaBhNti/ksv0cSplw9UNnjCKhYoYX3ZkDokbXiTdilK+2m2yQUUil8s+JI+FOM
         Mz9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRGfx05g/OK/fFkABUDYvYX6NSQF1TxcIW2DitMcqAwFrqMPVi2HJ+2pWwcasFUIHlEk8T8Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YxiU4QFC3opP8md5GGDJ9KecrdQneuH6DqQ0Tccyu7gv64a+xq/
	BK6kRbcS2KAwJZEHgH11WYJltYqY9eWwfuhwKmWHrJsDMXV8Da3mAnTQmIfLn1wryMHZWsbQsmC
	D+5lxKcD28E0wLdgAnGtFmFLTgXw+OiUvFjLaa4/cTYEPNFySVkiifhl95ISZrR8QkQRkKz8x/f
	SSCxjiS5lhmufZFW0zfhRAZxkuF1AUOBad
X-Gm-Gg: ASbGncvjUOYXPQ4qla9srV5lUq2Tb0lAaEBaMisyNp1Q6gLHRiGlMe9cz9QiMLNIm2A
	kOEUGHClsitkZ1Hqde3BiFs4ZDffw+o6V
X-Received: by 2002:a05:6e02:4416:10b0:3a7:a4ec:6cfc with SMTP id e9e14a558f8ab-3a7a4ec6eb1mr6221855ab.8.1732280635681;
        Fri, 22 Nov 2024 05:03:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjBIujeBiiBto12x7Ie0ZkLS7jCkUl1dIw1psG2/yNOJ8YhDHEILctT4OBs1UgwnhG2+2a8NNiGBzHeq0VFf0=
X-Received: by 2002:a05:6e02:4416:10b0:3a7:a4ec:6cfc with SMTP id
 e9e14a558f8ab-3a7a4ec6eb1mr6221485ab.8.1732280635355; Fri, 22 Nov 2024
 05:03:55 -0800 (PST)
MIME-Version: 1.0
References: <20241112185217.48792-1-nsaenz@amazon.com> <20241112185217.48792-2-nsaenz@amazon.com>
In-Reply-To: <20241112185217.48792-2-nsaenz@amazon.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 22 Nov 2024 21:03:49 +0800
Message-ID: <CALu+AoTnrPPFkRZpYDpYxt1gAoQuo_O7YZeLvTZO4qztxgSXHw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/efi: Apply EFI Memory Attributes after kexec
To: Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Matt Fleming <matt@codeblueprint.co.uk>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stanspas@amazon.de, nh-open-source@amazon.com, 
	stable@vger.kernel.org, kexec@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z_XS3eqUae26x1qBHOPWUk5jGoVA0HaFtO_fsyLyLxE_1732280636
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_050358_964823_C865CD1C 
X-CRM114-Status: GOOD (  16.57  )
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

Hi,

On Wed, 13 Nov 2024 at 02:53, Nicolas Saenz Julienne <nsaenz@amazon.com> wrote:
>
> Kexec bypasses EFI's switch to virtual mode. In exchange, it has its own
> routine, kexec_enter_virtual_mode(), which replays the mappings made by
> the original kernel. Unfortunately, that function fails to reinstate
> EFI's memory attributes, which would've otherwise been set after
> entering virtual mode. Remediate this by calling
> efi_runtime_update_mappings() within kexec's routine.

In the function __map_region(), there are playing with the flags
similar to the efi_runtime_update_mappings though it looks a little
different.  Is this extra callback really necessary?

Have you seen a real bug happened?

>
> Cc: stable@vger.kernel.org
> Fixes: 18141e89a76c ("x86/efi: Add support for EFI_MEMORY_ATTRIBUTES_TABLE")
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
>
> ---
>
> Notes:
> - Tested with QEMU/OVMF.
>
>  arch/x86/platform/efi/efi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index 375ebd78296a..a7ff189421c3 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -765,6 +765,7 @@ static void __init kexec_enter_virtual_mode(void)
>
>         efi_sync_low_kernel_mappings();
>         efi_native_runtime_setup();
> +       efi_runtime_update_mappings();
>  #endif
>  }
>
> --
> 2.40.1
>
>
Thanks
Dave



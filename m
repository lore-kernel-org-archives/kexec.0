Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6062CD4F3E
	for <kexec@archiver.kernel.org>; Sun, 16 Nov 2025 14:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E/Y2Up6627+KSz5a+6vTFY7dxyvWIBUQP6LhDWx3ZbY=; b=UR7qxtIcXHPcCKHQXRL257T5eC
	xfbs+dsab8R3QjGjVzkpn9Uro5uMNk7kNUkZHnr5YaZpcAViiYEdMNmkXKxxxQXrVQqt9c85Jco7k
	+L2o+g6C7xUtsiWYQ31AomHJ2tuZerS6hNjrpd5jT8JjjVppCV5jGWEoPWxmmkkwfSKD9uddILbTx
	Vunc/toOgI/V4GhSv+2+tmqtCUvM3pfA6PrnW+Hta2DrlmAtsqh3EnnQeyfTywQ1mMTBtLTfu6SZa
	rLFIVsskCUtpnT0vHySAogUjCII0l/fiFV29Xbs9lr8EMFT9R+eRI8ErloEgG6+yLkkWROGNMfm2N
	nkD9NpBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKeCM-0000000El9h-2xHU;
	Sun, 16 Nov 2025 14:57:50 +0000
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKeCH-0000000El9K-0XI7
	for kexec@lists.infradead.org;
	Sun, 16 Nov 2025 14:57:46 +0000
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso1377621a12.1
        for <kexec@lists.infradead.org>; Sun, 16 Nov 2025 06:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763305063; x=1763909863; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/Y2Up6627+KSz5a+6vTFY7dxyvWIBUQP6LhDWx3ZbY=;
        b=daHP/XuqAmxWEo+4u8K+ywelifQo1EXFKARF/k8kx8GVJ/c029+xRV5G/PzTE71Qv1
         d6l7XPtQRMGb3pLax7QbWA3jOQ5In72VHFxbz876fzfQAxnf381lC5Oq1TpemLPS19TB
         PskZglc+m6kfqBZkfLehLbZzMJEP51iRCNSGggMeF5+enrnDtvQeIuEGKMsujDU4FW+P
         T2P7uAet+Va3y57Tv5ceXSnelQ4vZTPIBe9FxM+ZeGcXe7zewr8VqvpPVOSKVhA/DM9A
         VDrjwDt+9XJ5EY3WczzkXHGhwom3m8AfML4c08rM1YaJj1Yy7KcQ7ONuRa9QbFVwiqZE
         cEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763305063; x=1763909863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E/Y2Up6627+KSz5a+6vTFY7dxyvWIBUQP6LhDWx3ZbY=;
        b=k6JfXE9id0Bd2zgG1+7sUNsMHxLTHyR7Ym3qS3CNyVKzR6NFTBOrlq0EfuqyfRcMjt
         bjS9uwc1RRddmBRjjJbhw3Bd9YU9yAC34O3Z6gJYQLyLlFD/fhVI6bqMSG9Tin03a2nl
         dgBQCMxKZzqh7ikTWSJ51JPofjz86hzcmg4dHkPdx2GlFerlMLm8utFC1K0ZqwYEgJCR
         8veKoN47dJQERr3ZU2irOJDfbQDBF3k5+m4d8DGCy1YldfND63YTJPTqaTs9ixh06zMK
         ntKHX4ku5Pn45DW/GSK7lQDhCI22Al11TJqXOsLdkTV+4TU/ilyy8tEjaEeZP34DmWtx
         hJaA==
X-Forwarded-Encrypted: i=1; AJvYcCWwoJbf0fN1396m2L37SF1mYsNGxyz2C8wRFt7XC95w6nRcCnhsVMBPshCRCsowCbMQp2cHkw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzihC0KX2CUV8taxE4+zWZdGmsqw3DxZo25CIBx6xRuL1Gp1OK2
	6hz67Wx1p1Uz1kqLx2LfcCMh7RKYoJQGnC6Ot+suIDqgFWlC0otgnknYNXMeiA0wHdht3P1yM55
	1irr6+P5C6AoDmkN+m5Tqaaqki0Nqcdzc4oH6h0k0Cw==
X-Gm-Gg: ASbGncugH2vxgQJPvOVzM+UGrf7J9IoKeGjsoivlftEDArMUCFYBbXezIUmxUeI6oBU
	asOz5ficKLd50Xewfsn3TdouCs/zcKqP2tEYUmJAJXSRe0HFcYTlQulFM1smo58A3AHxvB6PyPh
	IKN/xVg8jIoGPu7rPMAXmNsq5K+2G94UxGe5yu9WnTNwdRVFAOvVEJ7uCxP7W+wyYbkOm2MZmfx
	C1a82s6pNHZ3mdr7Zf6cu1fOjvDVZK4meJ8N7jEEPs2OXrg4lg50rQKRtAR+7zptxZcpe+F4QHI
	8zu62ENkJpM6xeIPOmmGh1gOHQs/
X-Google-Smtp-Source: AGHT+IFzCTKe+4oomiSL3/XUvnLJJ+h9FkIHFHoxYiYbAnr5wXaa8WsvkSSDNZQRrZhaV59Tuhi0aL3GyuwkRYUtKTg=
X-Received: by 2002:a05:6402:1656:b0:641:1cbe:a5bf with SMTP id
 4fb4d7f45d1cf-64334cf0fd6mr8966314a12.9.1763305062361; Sun, 16 Nov 2025
 06:57:42 -0800 (PST)
MIME-Version: 1.0
References: <20251114190002.3311679-4-pasha.tatashin@soleen.com> <20251116064918.35549-1-ioworker0@gmail.com>
In-Reply-To: <20251116064918.35549-1-ioworker0@gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 16 Nov 2025 09:57:05 -0500
X-Gm-Features: AWmQ_bknMK8U4gd8bjwM0cRGJKpRjLCOKKOLfwahMDCMf_AdWWN6xXq3RI7dyNo
Message-ID: <CA+CK2bAK6V3iaUr_vRmXiU=7c2HFdBc7Cybj_H7ZDQez-WSSsw@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] kho: Introduce high-level memory allocation API
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, bhe@redhat.com, coxu@redhat.com, 
	dave@vasilevsky.ca, ebiggers@google.com, graf@amazon.com, jasonmiu@google.com, 
	kees@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, rppt@kernel.org, Lance Yang <lance.yang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251116_065745_220066_6B554803 
X-CRM114-Status: GOOD (  22.80  )
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

On Sun, Nov 16, 2025 at 1:49=E2=80=AFAM Lance Yang <ioworker0@gmail.com> wr=
ote:
>
> From: Lance Yang <lance.yang@linux.dev>
>
>
> On Fri, 14 Nov 2025 13:59:52 -0500, Pasha Tatashin wrote:
> > Currently, clients of KHO must manually allocate memory (e.g., via
> > alloc_pages), calculate the page order, and explicitly call
> > kho_preserve_folio(). Similarly, cleanup requires separate calls to
> > unpreserve and free the memory.
> >
> > Introduce a high-level API to streamline this common pattern:
> >
> > - kho_alloc_preserve(size): Allocates physically contiguous, zeroed
> >   memory and immediately marks it for preservation.
> > - kho_unpreserve_free(ptr): Unpreserves and frees the memory
> >   in the current kernel.
> > - kho_restore_free(ptr): Restores the struct page state of
> >   preserved memory in the new kernel and immediately frees it to the
> >   page allocator.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  include/linux/kexec_handover.h     | 22 +++++---
> >  kernel/liveupdate/kexec_handover.c | 87 ++++++++++++++++++++++++++++++
> >  2 files changed, 102 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_hando=
ver.h
> > index 80ece4232617..38a9487a1a00 100644
> > --- a/include/linux/kexec_handover.h
> > +++ b/include/linux/kexec_handover.h
> > @@ -2,8 +2,9 @@
> >  #ifndef LINUX_KEXEC_HANDOVER_H
> >  #define LINUX_KEXEC_HANDOVER_H
> >
> > -#include <linux/types.h>
> > +#include <linux/err.h>
> >  #include <linux/errno.h>
> > +#include <linux/types.h>
> >
> >  struct kho_scratch {
> >       phys_addr_t addr;
> > @@ -48,6 +49,9 @@ int kho_preserve_pages(struct page *page, unsigned in=
t nr_pages);
> >  int kho_unpreserve_pages(struct page *page, unsigned int nr_pages);
> >  int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation);
> >  int kho_unpreserve_vmalloc(struct kho_vmalloc *preservation);
> > +void *kho_alloc_preserve(size_t size);
> > +void kho_unpreserve_free(void *mem);
> > +void kho_restore_free(void *mem);
> >  struct folio *kho_restore_folio(phys_addr_t phys);
> >  struct page *kho_restore_pages(phys_addr_t phys, unsigned int nr_pages=
);
> >  void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
> > @@ -101,6 +105,14 @@ static inline int kho_unpreserve_vmalloc(struct kh=
o_vmalloc *preservation)
> >       return -EOPNOTSUPP;
> >  }
> >
> > +void *kho_alloc_preserve(size_t size)
> > +{
> > +     return ERR_PTR(-EOPNOTSUPP);
> > +}
> > +
> > +void kho_unpreserve_free(void *mem) { }
> > +void kho_restore_free(void *mem) { }
>
> The compile is unhapply here when CONFIG_KEXEC_HANDOVER is not set ...

Thank you, Andrew already applied a fix:
https://lore.kernel.org/all/CA+CK2bBgXDhrHwTVgxrw7YTQ-0=3DLgW0t66CwPCgG=3DC=
85ftz4zw@mail.gmail.com/T/#u

>
> ```
> ld: arch/x86/realmode/rm/video-mode.o: in function `kho_alloc_preserve':
> /home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec=
_handover.h:102: multiple definition of `kho_alloc_preserve'; arch/x86/real=
mode/rm/wakemain.o:/home/runner/work/mm-test-robot/mm-test-robot/linux/./in=
clude/linux/kexec_handover.h:102: first defined here
> ld: arch/x86/realmode/rm/video-mode.o: in function `kho_unpreserve_free':
> /home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec=
_handover.h:104: multiple definition of `kho_unpreserve_free'; arch/x86/rea=
lmode/rm/wakemain.o:/home/runner/work/mm-test-robot/mm-test-robot/linux/./i=
nclude/linux/kexec_handover.h:104: first defined here
> ld: arch/x86/realmode/rm/video-mode.o: in function `kho_restore_free':
> /home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec=
_handover.h:105: multiple definition of `kho_restore_free'; arch/x86/realmo=
de/rm/wakemain.o:/home/runner/work/mm-test-robot/mm-test-robot/linux/./incl=
ude/linux/kexec_handover.h:105: first defined here
> ld: arch/x86/realmode/rm/regs.o: in function `kho_alloc_preserve':
> /home/runner/work/mm-test-robot/mm-test-robot/linux/arch/x86/realmode/rm/=
regs.c:102: multiple definition of `kho_alloc_preserve'; arch/x86/realmode/=
rm/wakemain.o:/home/runner/work/mm-test-robot/mm-test-robot/linux/./include=
/linux/kexec_handover.h:102: first defined here
> ld: arch/x86/realmode/rm/regs.o: in function `kho_unpreserve_free':
> /home/runner/work/mm-test-robot/mm-test-robot/linux/arch/x86/realmode/rm/=
regs.c:104: multiple definition of `kho_unpreserve_free'; arch/x86/realmode=
/rm/wakemain.o:/home/runner/work/mm-test-robot/mm-test-robot/linux/./includ=
e/linux/kexec_handover.h:104: first defined here
> ld: arch/x86/realmode/rm/regs.o: in function `kho_restore_free':
> /home/runner/work/mm-test-robot/mm-test-robot/linux/arch/x86/realmode/rm/=
regs.c:105: multiple definition of `kho_restore_free'; arch/x86/realmode/rm=
/wakemain.o:/home/runner/work/mm-test-robot/mm-test-robot/linux/./include/l=
inux/kexec_handover.h:105: first defined here
> ld: arch/x86/realmode/rm/video-vga.o: in function `kho_alloc_preserve':
> /home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec=
_handover.h:102: multiple definition of `kho_alloc_preserve'; arch/x86/real=
mode/rm/wakemain.o:/home/runner/work/mm-test-robot/mm-test-robot/linux/./in=
clude/linux/kexec_handover.h:102: first defined here
> ld: arch/x86/realmode/rm/video-vga.o: in function `kho_unpreserve_free':
> /home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec=
_handover.h:104: multiple definition of `kho_unpreserve_free'; arch/x86/rea=
lmode/rm/wakemain.o:/home/runner/work/mm-test-robot/mm-test-robot/linux/./i=
nclude/linux/kexec_handover.h:104: first defined here
> ld: arch/x86/realmode/rm/video-vga.o: in function `kho_restore_free':
> /home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec=
_handover.h:105: multiple definition of `kho_restore_free'; arch/x86/realmo=
de/rm/wakemain.o:/home/runner/work/mm-test-robot/mm-test-robot/linux/./incl=
ude/linux/kexec_handover.h:105: first defined here
> ld: arch/x86/realmode/rm/video-vesa.o: in function `kho_alloc_preserve':
> /home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec=
_handover.h:102: multiple definition of `kho_alloc_preserve'; arch/x86/real=
mode/rm/wakemain.o:/home/runner/work/mm-test-robot/mm-test-robot/linux/./in=
clude/linux/kexec_handover.h:102: first defined here
> ld: arch/x86/realmode/rm/video-vesa.o: in function `kho_unpreserve_free':
> /home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec=
_handover.h:104: multiple definition of `kho_unpreserve_free'; arch/x86/rea=
lmode/rm/wakemain.o:/home/runner/work/mm-test-robot/mm-test-robot/linux/./i=
nclude/linux/kexec_handover.h:104: first defined here
> ld: arch/x86/realmode/rm/video-vesa.o: in function `kho_restore_free':
> /home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec=
_handover.h:105: multiple definition of `kho_restore_free'; arch/x86/realmo=
de/rm/wakemain.o:/home/runner/work/mm-test-robot/mm-test-robot/linux/./incl=
ude/linux/kexec_handover.h:105: first defined here
> ld: arch/x86/realmode/rm/video-bios.o: in function `kho_alloc_preserve':
> /home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec=
_handover.h:102: multiple definition of `kho_alloc_preserve'; arch/x86/real=
mode/rm/wakemain.o:/home/runner/work/mm-test-robot/mm-test-robot/linux/./in=
clude/linux/kexec_handover.h:102: first defined here
> ld: arch/x86/realmode/rm/video-bios.o: in function `kho_unpreserve_free':
> /home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec=
_handover.h:104: multiple definition of `kho_unpreserve_free'; arch/x86/rea=
lmode/rm/wakemain.o:/home/runner/work/mm-test-robot/mm-test-robot/linux/./i=
nclude/linux/kexec_handover.h:104: first defined here
> ld: arch/x86/realmode/rm/video-bios.o: in function `kho_restore_free':
> /home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec=
_handover.h:105: multiple definition of `kho_restore_free'; arch/x86/realmo=
de/rm/wakemain.o:/home/runner/work/mm-test-robot/mm-test-robot/linux/./incl=
ude/linux/kexec_handover.h:105: first defined here
> make[5]: *** [arch/x86/realmode/rm/Makefile:49: arch/x86/realmode/rm/real=
mode.elf] Error 1
> make[4]: *** [arch/x86/realmode/Makefile:22: arch/x86/realmode/rm/realmod=
e.bin] Error 2
> make[3]: *** [scripts/Makefile.build:556: arch/x86/realmode] Error 2
> ```
>
> Perhaps these stubs should be declared as static inline? That should make
> the compiler happy and resolve the linking errors :)
>
> ----8<----
> diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handove=
r.h
> index 6dd0dcdf0ec1..5f7b9de97e8d 100644
> --- a/include/linux/kexec_handover.h
> +++ b/include/linux/kexec_handover.h
> @@ -96,13 +96,13 @@ static inline int kho_preserve_vmalloc(void *ptr,
>
>  static inline void kho_unpreserve_vmalloc(struct kho_vmalloc *preservati=
on) { }
>
> -void *kho_alloc_preserve(size_t size)
> +static inline void *kho_alloc_preserve(size_t size)
>  {
>         return ERR_PTR(-EOPNOTSUPP);
>  }
>
> -void kho_unpreserve_free(void *mem) { }
> -void kho_restore_free(void *mem) { }
> +static inline void kho_unpreserve_free(void *mem) { }
> +static inline void kho_restore_free(void *mem) { }
>
>  static inline struct folio *kho_restore_folio(phys_addr_t phys)
>  {
> ---
>
> [...]
>
> Cheers,
> Lance


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 894CCD715C7
	for <kexec@archiver.kernel.org>; Sat, 24 Jan 2026 05:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pA37LDcFYwwnhvblhGQ0rVtsHjmK32ixACHWM/vsdj8=; b=QAtIby1LjZ80I665xAqoQG2kLu
	lTV1Zw8bZpUsJGS/q3VOO48btWSNtAD74yh5rmTxmpaq5cv14A5XeD+PEyOYqXd79BJ8XAgvSHxQg
	RkieR/73GtVCaO1g822Vjk7YNXeLXOmM2SirAE30jYjfexdNFX6ABTSjK8PdhxwxXcW/HZ1SVvzAi
	PMQV09FHTXRhlIBW4WQ3DnK9PKWHg2JG5K+wLL8MvmsuR5LCheNqtJs+z04vJWyQ8eNr/2D2e8vv+
	LaAC3OO4MBKvBtPL1BKzcAaz3ED8ioyMCMI42RAy+6ZEndj0ymPzJqyvJo2SbNiDAvCreEkewxuP4
	EhdhsoIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjWZw-0000000A1dq-0DgU;
	Sat, 24 Jan 2026 05:53:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjWZr-0000000A1dQ-2j70
	for kexec@lists.infradead.org;
	Sat, 24 Jan 2026 05:52:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769233972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pA37LDcFYwwnhvblhGQ0rVtsHjmK32ixACHWM/vsdj8=;
	b=Ln2jBNsGanrY+xwW4byTrgr/UvV7Jy1Ixl7mXrW45A16HsL2+gdPjQp4FSDUUha+wuEB4n
	l6biHFYqKWbMflnRaZ4vq9k8UPrpW1lsGsrSU0emPKM+XdkYSa0ZFjGB4TogM7ttP6xD7/
	eLx/lcwI1AO0eEkpoTK4RudT5dKIjcw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-UOwur1XCNQ-cimhfep8VLw-1; Sat, 24 Jan 2026 00:52:49 -0500
X-MC-Unique: UOwur1XCNQ-cimhfep8VLw-1
X-Mimecast-MFC-AGG-ID: UOwur1XCNQ-cimhfep8VLw_1769233969
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-502d38a3e39so34670701cf.3
        for <kexec@lists.infradead.org>; Fri, 23 Jan 2026 21:52:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769233969; x=1769838769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pA37LDcFYwwnhvblhGQ0rVtsHjmK32ixACHWM/vsdj8=;
        b=Tjqf1Qayi/1wFeaYTodMuuu3E1uGpoalq1voS8dwHGjtHTJ3en+JQD10OBLX5BRcog
         8DIt2QSa9+mDRxf991LLR/EK1bmQBSWPP35x43OYZiHJmuAz2le9a8ZOtJKSk6DNkHwk
         iaxBbyHB9PArBJ9E3hUjK/WXvRUHmI85tCAQufsp+SRaouDbUj4OJuUQniexR5zOFKon
         xlqA7nWICL3QnSyl0DHGDAqv403eL8xhkK5SjYwgdPS46274WAvmB8WKukq4coef6aTC
         X0ZxVMMaOTZXVwSuKaZRqIqx8RjsiWpNGQCtbal0CIl1q1cadzF1aTSV12OL0pUr0p/m
         ZqzA==
X-Forwarded-Encrypted: i=1; AJvYcCUBtMwwiDMAVgiqa8Tnk5pBhifUoEt7h5PJMd8QvZA0kl7P1QM6yZv+sjw/OaH06AyzhOw2cg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw3jr2MO7ZcETrTVmIRdWE+UH4jLfPvTSHLbhmEVjztBHBlHEk3
	rVkM9glDNSk61QZSA5Vv/juTpx/veI0ZJDoOq+aZlfxkSAj0u3NjlCYOjWYryqzrCGixLOzhS6i
	tNurRjdc91jfGnH95pezc64tsJbST4eTDYg3PX+vsVnrsIotMgjJeGi5IIEcI1DPxHb8AoNIvji
	sHmdL6BIpUXydOI4E9KUtxFaL2UQXMrHw2q8Wz
X-Gm-Gg: AZuq6aKQb114hjNDIEwjIJMvDRDS3FaQM3VoGyORjnuajM4styTkp58DV4967or7iBj
	hyTZR+6/tAahxR7Wyko1TxR7moKfn/A6Ao72xUk1EHuNQV/n8An4DCdu5tqXraHeMHA0vnysz5J
	TYEKAR/L1tOdKMEK3sA+YEB19zNvjat7J7BwEkr+noCI/PBG7S63jcigcPqBXzmOpOrpY=
X-Received: by 2002:ac8:7dd5:0:b0:501:863a:a89e with SMTP id d75a77b69052e-502f77dc80cmr65778351cf.80.1769233969106;
        Fri, 23 Jan 2026 21:52:49 -0800 (PST)
X-Received: by 2002:ac8:7dd5:0:b0:501:863a:a89e with SMTP id
 d75a77b69052e-502f77dc80cmr65778261cf.80.1769233968652; Fri, 23 Jan 2026
 21:52:48 -0800 (PST)
MIME-Version: 1.0
References: <20260120025500.25095-1-ltao@redhat.com> <20260120025500.25095-2-ltao@redhat.com>
 <87a4y3vmsi.fsf@oracle.com>
In-Reply-To: <87a4y3vmsi.fsf@oracle.com>
From: Tao Liu <ltao@redhat.com>
Date: Sat, 24 Jan 2026 18:52:12 +1300
X-Gm-Features: AZwV_QgY-Zt1xHo3jjFxBf2O2lkocBzRRWrHIdxk_KwnFALYg7AXuxgrVb_pSjQ
Message-ID: <CAO7dBbUaRD3NTjt4oqfOTK5mSU9J4hH7Lc=xx1pJMeB_YLFdRg@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] Implement kernel kallsyms resolving
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org, 
	aravinda@linux.vnet.ibm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AFbS2ZEfSacRIMcCGk4JpkiyygF1M36a58ZD9rJTMJw_1769233969
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260123_215255_839798_AB316213 
X-CRM114-Status: GOOD (  55.08  )
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

Hi Stephen,

On Sat, Jan 24, 2026 at 2:10=E2=80=AFPM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Hi Tao,
>
> You've managed to do nearly the same as my implementations of kallsyms,
> but with far less code! Nice! Thank you for this.
>
> A few comments inline.

Thanks again for your detailed information and comments on the
patchset. Please give me some time to digest your information and
reconsider the features to be implemented for v4.

Thanks,
Tao Liu

>
> Tao Liu <ltao@redhat.com> writes:
> > This patch will parse kernel's kallsyms data, and store them into a has=
h
> > table so they can be referenced later in a fast speed.
> >
> > Signed-off-by: Tao Liu <ltao@redhat.com>
> > ---
> >  Makefile       |   2 +-
> >  kallsyms.c     | 265 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  kallsyms.h     |  17 ++++
> >  makedumpfile.c |   3 +
> >  makedumpfile.h |  11 ++
> >  5 files changed, 297 insertions(+), 1 deletion(-)
> >  create mode 100644 kallsyms.c
> >  create mode 100644 kallsyms.h
> >
> > diff --git a/Makefile b/Makefile
> > index 05ab5f2..6c450ac 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -45,7 +45,7 @@ CFLAGS_ARCH +=3D -m32
> >  endif
> >
> >  SRC_BASE =3D makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.h=
 sadump_info.h
> > -SRC_PART =3D print_info.c dwarf_info.c elf_info.c erase_info.c sadump_=
info.c cache.c tools.c printk.c detect_cycle.c
> > +SRC_PART =3D print_info.c dwarf_info.c elf_info.c erase_info.c sadump_=
info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c
> >  OBJ_PART=3D$(patsubst %.c,%.o,$(SRC_PART))
> >  SRC_ARCH =3D arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia6=
4.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64.c arch/=
loongarch64.c arch/riscv64.c
> >  OBJ_ARCH=3D$(patsubst %.c,%.o,$(SRC_ARCH))
> > diff --git a/kallsyms.c b/kallsyms.c
> > new file mode 100644
> > index 0000000..ecf64e0
> > --- /dev/null
> > +++ b/kallsyms.c
> > @@ -0,0 +1,265 @@
> > +#include <stdint.h>
> > +#include <stdbool.h>
> > +#include <string.h>
> > +#include "makedumpfile.h"
> > +#include "kallsyms.h"
> > +
> > +static uint32_t *kallsyms_offsets =3D NULL;
> > +static uint16_t *kallsyms_token_index =3D NULL;
> > +static uint8_t  *kallsyms_token_table =3D NULL;
> > +static uint8_t  *kallsyms_names =3D NULL;
> > +static unsigned long kallsyms_relative_base =3D 0;
> > +static unsigned int kallsyms_num_syms =3D 0;
> > +
> > +#define NAME_HASH 512
> > +static struct syment *name_hash_table[NAME_HASH] =3D {0};
> > +
> > +static uint64_t absolute_percpu(uint64_t base, int32_t val)
> > +{
> > +     if (val >=3D 0)
> > +             return (uint64_t)val;
> > +     else
> > +             return base - 1 - val;
> > +}
> > +
> > +static unsigned int hash_index(const char *name, unsigned int hash_siz=
e)
> > +{
> > +     unsigned int len, value;
> > +
> > +     len =3D strlen(name);
> > +     value =3D name[len - 1] * name[len / 2];
> > +
> > +     return (name[0] ^ value) % hash_size;
> > +}
> > +
> > +static void name_hash_install(struct syment *en)
> > +{
> > +     unsigned int index =3D hash_index(en->name, NAME_HASH);
> > +     struct syment *sp =3D name_hash_table[index];
> > +
> > +     if (sp =3D=3D NULL) {
> > +             name_hash_table[index] =3D en;
> > +     } else {
> > +             while (sp) {
> > +                     if (sp->name_hash_next) {
> > +                             sp =3D sp->name_hash_next;
> > +                     } else {
> > +                             sp->name_hash_next =3D en;
> > +                             break;
> > +                     }
> > +             }
> > +     }
> > +}
> > +
> > +static struct syment *search_kallsyms_by_name(char *name)
> > +{
> > +     unsigned int index;
> > +     struct syment *sp;
> > +
> > +     index =3D hash_index(name, NAME_HASH);
> > +     for (sp =3D name_hash_table[index]; sp; sp =3D sp->name_hash_next=
) {
> > +             if (!strcmp(name, sp->name)) {
> > +                     return sp;
> > +             }
> > +     }
> > +     return sp;
> > +}
> > +
> > +static bool is_unwanted_symbol(char *name)
> > +{
> > +     const char *unwanted_prefix[] =3D {
> > +             "__pfx_",       // CFI symbols
> > +             "_R",           // Rust symbols
> > +     };
> > +     for (int i =3D 0; i < sizeof(unwanted_prefix) / sizeof(char *); i=
++) {
> > +             if (!strncmp(name, unwanted_prefix[i], strlen(unwanted_pr=
efix[i])))
> > +                     return true;
> > +     }
> > +     return false;
> > +}
> > +
> > +uint64_t get_kallsyms_value_by_name(char *name)
> > +{
> > +     struct syment *sp;
> > +
> > +     sp =3D search_kallsyms_by_name(name);
> > +     if (!sp)
> > +             return 0;
> > +     return sp->value;
> > +}
> > +
> > +#define BUFLEN 1024
> > +static bool parse_kernel_kallsyms(void)
> > +{
> > +     char buf[BUFLEN];
> > +     int index =3D 0, i;
> > +     uint8_t *compressd_data;
> > +     uint8_t *uncompressd_data;
> > +     uint64_t stext;
> > +     uint8_t len, len_old;
> > +     struct syment *kern_syment;
> > +     bool skip;
> > +
> > +     for (i =3D 0; i < kallsyms_num_syms; i++) {
> > +             skip =3D false;
> > +             memset(buf, 0, BUFLEN);
> > +             len =3D kallsyms_names[index];
> > +             if (len & 0x80) {
> > +                     index++;
> > +                     len_old =3D len;
> > +                     len =3D kallsyms_names[index];
> > +                     if (len & 0x80) {
> > +                             fprintf(stderr, "%s: BUG! Unexpected 3-by=
te length,"
> > +                                     " should be detected in init_kern=
el_kallsyms()\n",
> > +                                     __func__);
> > +                             goto out;
> > +                     }
> > +                     len =3D (len_old & 0x7F) | (len << 7);
>
> The 2-byte representation was added in commit 73bbb94466fd3 ("kallsyms:
> support "big" kernel symbols"), in v6.1. It seems useful to include a
> comment about that, at a minimum.
>
> It also seems to me that, for older kernel versions, this means lengths
> 128-255 are ambiguous: for v6.1+, they indicate a long symbol, but for
> kernel versions prior to that, they are valid lengths.
>
> I guess this is implemented for current kernels, but it might be worth
> checking the kernel major/minor version for this. Though, I haven't
> personally witnessed the issue, so maybe it's unnecessary. I will test
> this on some older kernels and let you know.
>
> > +             }
> > +             index++;
> > +
> > +             compressd_data =3D &kallsyms_names[index];
> > +             index +=3D len;
> > +             while (len--) {
> > +                     uncompressd_data =3D &kallsyms_token_table[kallsy=
ms_token_index[*compressd_data]];
> > +                     if (strlen(buf) + strlen((char *)uncompressd_data=
) >=3D BUFLEN) {
> > +                             skip =3D true;
> > +                             break;
> > +                     }
> > +                     strcat(buf, (char *)uncompressd_data);
> > +                     compressd_data++;
> > +             }
> > +             if (skip || is_unwanted_symbol(&buf[1]))
> > +                     continue;
> > +             kern_syment =3D (struct syment *)calloc(1, sizeof(struct =
syment));
> > +             if (!kern_syment)
> > +                     goto no_mem;
> > +             kern_syment->value =3D kallsyms_offsets[i];
> > +             kern_syment->name =3D strdup(&buf[1]);
> > +             if (!kern_syment->name) {
> > +                     free(kern_syment);
> > +                     goto no_mem;
> > +             }
> > +             name_hash_install(kern_syment);
>
> Like I mentioned in a prior email, if we were able to know the list of
> symbols we care about up-front, we could entirely avoid creating the
> hash table, and also avoid maintaining a list of symbol prefixes we want
> to skip loading. I'm not certain that you would want to go that far, but
> it's a thought.
>
> > +     }
> > +
> > +     /* Now refresh the absolute each kallsyms address */
>
> I think this could use a better comment. This is my understanding of the
> history of the kallsyms address encoding history:
>
>     Kallsyms originally stored absolute symbol addresses in a plain
>     array called "kallsyms_addresses". This strategy was called
>     "absolute kallsyms". In Linux v4.6, commit 2213e9a66bb87 ("kallsyms:
>     add support for relative offsets in kallsyms address table"),
>     introduced two ways of storing symbol addresses relative two a base
>     address, so that 64-bit architectures could use 32-bit arrays. These
>     methods were CONFIG_KALLSYMS_BASE_RELATIVE and
>     CONFIG_KALLSYMS_ABSOLUTE_PERCPU. The ABSOLUTE_PERCPU mechanism was
>     used by architectures like x86_64 with a percpu address range near
>     0x0, but kernel address range in the negative address space. Some
>     architectures, namely tile and ia64, had to continue using absolute
>     kallsyms due to very large gaps in their address spaces.
>
>     After both architectures were removed, absolute percpu was dropped
>     in v6.11 commit 64e166099b69b ("kallsyms: get rid of code for
>     absolute kallsyms"). In v6.15, the x86_64 percpu address range was
>     moved away from 0x0, and as a result ABSOLUTE_PERCPU was no longer
>     required. It was dropped in 01157ddc58dc2 ("kallsyms: Remove
>     KALLSYMS_ABSOLUTE_PERCPU"), leaving only the BASE_RELATIVE scheme
>     (which no longer has a kconfig entry, since there is no other
>     scheme).
>
>     This code implements support for BASE_RELATIVE and ABSOLUTE_PERCPU,
>     but absolute percpu is not supported. The kallsyms symbols
>     themselves were only added to vmcoreinfo in v6.0 with commit
>     f09bddbd86619 ("vmcoreinfo: add kallsyms_num_syms symbol"). At that
>     time, only ia64 would have used the absolute percpu mechanism. Even
>     if these commits were backported to quite old kernels, BASE_RELATIVE
>     and ABSOLUTE_PERCPU would suffice for most other architectures until
>     v4.6 and earlier.
>
> I don't know if all of the context is necessary, but I find it helpful
> to know.
>
> Thanks,
> Stephen
>
> > +     stext =3D get_kallsyms_value_by_name("_stext");
> > +     if (SYMBOL(_stext) =3D=3D absolute_percpu(kallsyms_relative_base,=
 stext)) {
> > +             for (i =3D 0; i < NAME_HASH; i++) {
> > +                     for (kern_syment =3D name_hash_table[i];
> > +                          kern_syment;
> > +                          kern_syment =3D kern_syment->name_hash_next)
> > +                             kern_syment->value =3D absolute_percpu(ka=
llsyms_relative_base,
> > +                                                     kern_syment->valu=
e);
> > +             }
> > +     } else if (SYMBOL(_stext) =3D=3D kallsyms_relative_base + stext) =
{
> > +             for (i =3D 0; i < NAME_HASH; i++) {
> > +                     for (kern_syment =3D name_hash_table[i];
> > +                          kern_syment;
> > +                          kern_syment =3D kern_syment->name_hash_next)
> > +                             kern_syment->value +=3D kallsyms_relative=
_base;
> > +             }
> > +     } else {
> > +             fprintf(stderr, "%s: Wrong calculate kallsyms symbol valu=
e!\n", __func__);
> > +             goto out;
> > +     }
> > +
> > +     return true;
> > +no_mem:
> > +     fprintf(stderr, "%s: Not enough memory!\n", __func__);
> > +out:
> > +     return false;
> > +}
> > +
> > +static bool vmcore_info_ready =3D false;
> > +
> > +bool read_vmcoreinfo_kallsyms(void)
> > +{
> > +     READ_SYMBOL("kallsyms_names", kallsyms_names);
> > +     READ_SYMBOL("kallsyms_num_syms", kallsyms_num_syms);
> > +     READ_SYMBOL("kallsyms_token_table", kallsyms_token_table);
> > +     READ_SYMBOL("kallsyms_token_index", kallsyms_token_index);
> > +     READ_SYMBOL("kallsyms_offsets", kallsyms_offsets);
> > +     READ_SYMBOL("kallsyms_relative_base", kallsyms_relative_base);
> > +     vmcore_info_ready =3D true;
> > +     return true;
> > +}
> > +
> > +bool init_kernel_kallsyms(void)
> > +{
> > +     const int token_index_size =3D (UINT8_MAX + 1) * sizeof(uint16_t)=
;
> > +     uint64_t last_token, len;
> > +     unsigned char data, data_old;
> > +     int i;
> > +     bool ret =3D false;
> > +
> > +     if (vmcore_info_ready =3D=3D false) {
> > +             fprintf(stderr, "%s: vmcoreinfo not ready for kallsyms!\n=
",
> > +                     __func__);
> > +             return ret;
> > +     }
> > +
> > +     readmem(VADDR, SYMBOL(kallsyms_num_syms), &kallsyms_num_syms,
> > +             sizeof(kallsyms_num_syms));
> > +     readmem(VADDR, SYMBOL(kallsyms_relative_base), &kallsyms_relative=
_base,
> > +             sizeof(kallsyms_relative_base));
> > +
> > +     kallsyms_offsets =3D malloc(sizeof(uint32_t) * kallsyms_num_syms)=
;
> > +     if (!kallsyms_offsets)
> > +             goto no_mem;
> > +     readmem(VADDR, SYMBOL(kallsyms_offsets), kallsyms_offsets,
> > +             kallsyms_num_syms * sizeof(uint32_t));
> > +
> > +     kallsyms_token_index =3D malloc(token_index_size);
> > +     if (!kallsyms_token_index)
> > +             goto no_mem;
> > +     readmem(VADDR, SYMBOL(kallsyms_token_index), kallsyms_token_index=
,
> > +             token_index_size);
> > +
> > +     last_token =3D SYMBOL(kallsyms_token_table) + kallsyms_token_inde=
x[UINT8_MAX];
> > +     do {
> > +             readmem(VADDR, last_token++, &data, 1);
> > +     } while(data);
> > +     len =3D last_token - SYMBOL(kallsyms_token_table);
> > +     kallsyms_token_table =3D malloc(len);
> > +     if (!kallsyms_token_table)
> > +             goto no_mem;
> > +     readmem(VADDR, SYMBOL(kallsyms_token_table), kallsyms_token_table=
, len);
> > +
> > +     for (len =3D 0, i =3D 0; i < kallsyms_num_syms; i++) {
> > +             readmem(VADDR, SYMBOL(kallsyms_names) + len, &data, 1);
> > +             if (data & 0x80) {
> > +                     len +=3D 1;
> > +                     data_old =3D data;
> > +                     readmem(VADDR, SYMBOL(kallsyms_names) + len, &dat=
a, 1);
> > +                     if (data & 0x80) {
> > +                             fprintf(stderr, "%s: BUG! Unexpected 3-by=
te length"
> > +                                     " encoding in kallsyms names\n", =
__func__);
> > +                             goto out;
> > +                     }
> > +                     data =3D (data_old & 0x7F) | (data << 7);
> > +             }
> > +             len +=3D data + 1;
> > +     }
> > +     kallsyms_names =3D malloc(len);
> > +     if (!kallsyms_names)
> > +             goto no_mem;
> > +     readmem(VADDR, SYMBOL(kallsyms_names), kallsyms_names, len);
> > +
> > +     ret =3D parse_kernel_kallsyms();
> > +     goto out;
> > +
> > +no_mem:
> > +     fprintf(stderr, "%s: Not enough memory!\n", __func__);
> > +out:
> > +     if (kallsyms_offsets)
> > +             free(kallsyms_offsets);
> > +     if (kallsyms_token_index)
> > +             free(kallsyms_token_index);
> > +     if (kallsyms_token_table)
> > +             free(kallsyms_token_table);
> > +     if (kallsyms_names)
> > +             free(kallsyms_names);
> > +     return ret;
> > +}
> > diff --git a/kallsyms.h b/kallsyms.h
> > new file mode 100644
> > index 0000000..a4fbe10
> > --- /dev/null
> > +++ b/kallsyms.h
> > @@ -0,0 +1,17 @@
> > +#ifndef _KALLSYMS_H
> > +#define _KALLSYMS_H
> > +
> > +#include <stdint.h>
> > +#include <stdbool.h>
> > +
> > +struct __attribute__((packed)) syment {
> > +     uint64_t value;
> > +     char *name;
> > +     struct syment *name_hash_next;
> > +};
> > +
> > +bool read_vmcoreinfo_kallsyms(void);
> > +bool init_kernel_kallsyms(void);
> > +uint64_t get_kallsyms_value_by_name(char *);
> > +
> > +#endif /* _KALLSYMS_H */
> > \ No newline at end of file
> > diff --git a/makedumpfile.c b/makedumpfile.c
> > index 12fb0d8..dba3628 100644
> > --- a/makedumpfile.c
> > +++ b/makedumpfile.c
> > @@ -27,6 +27,7 @@
> >  #include <limits.h>
> >  #include <assert.h>
> >  #include <zlib.h>
> > +#include "kallsyms.h"
> >
> >  struct symbol_table  symbol_table;
> >  struct size_table    size_table;
> > @@ -3105,6 +3106,8 @@ read_vmcoreinfo_from_vmcore(off_t offset, unsigne=
d long size, int flag_xen_hv)
> >               if (!read_vmcoreinfo())
> >                       goto out;
> >       }
> > +     read_vmcoreinfo_kallsyms();
> > +
> >       close_vmcoreinfo();
> >
> >       ret =3D TRUE;
> > diff --git a/makedumpfile.h b/makedumpfile.h
> > index 134eb7a..0dec50e 100644
> > --- a/makedumpfile.h
> > +++ b/makedumpfile.h
> > @@ -259,6 +259,7 @@ static inline int string_exists(char *s) { return (=
s ? TRUE : FALSE); }
> >  #define UINT(ADDR)   *((unsigned int *)(ADDR))
> >  #define ULONG(ADDR)  *((unsigned long *)(ADDR))
> >  #define ULONGLONG(ADDR)      *((unsigned long long *)(ADDR))
> > +#define VOID_PTR(ADDR)  *((void **)(ADDR))
> >
> >
> >  /*
> > @@ -1919,6 +1920,16 @@ struct symbol_table {
> >        * symbols on sparc64 arch
> >        */
> >       unsigned long long              vmemmap_table;
> > +
> > +     /*
> > +      * kallsyms related
> > +      */
> > +     unsigned long long              kallsyms_names;
> > +     unsigned long long              kallsyms_num_syms;
> > +     unsigned long long              kallsyms_token_table;
> > +     unsigned long long              kallsyms_token_index;
> > +     unsigned long long              kallsyms_offsets;
> > +     unsigned long long              kallsyms_relative_base;
> >  };
> >
> >  struct size_table {
> > --
> > 2.47.0
>



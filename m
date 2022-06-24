Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9655BC433EF
	for <kexec@archiver.kernel.org>; Fri, 24 Jun 2022 02:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MMvzDcSUJ6WOEXOMJfER0XRqbssInlzgpjQRK0QLC9U=; b=4dFqd3pyl3GzDn
	vkCY9chw43ox7D9MBP+x7kgEeoE8GsU5Z22KbQ2pXCU+fyoq5ccQ6Z+CQggpG0d+fcOZHa93Gwo/1
	SuF6Zq5IwjWpsfThau4pAIBLouJeRUWkQ/ARL73eECcyTBszFkQIOYW8crGV1nB8Fh3zguT9JbZK/
	nmjkGf28SOIEGU/lm2RQ/lDz1O+hH3ujGja9acgur21TIjjQY/MP2m5ggG1w6nH9aTu6BXquaH1JC
	NYVPm+R8AuhIELjG52e71MARDLPrlBbwXsxEqQeq0adrYhpGteF4tSbaIZoYuj1Fgwvyb4u/NpzTJ
	+0A4CE0GjQBQ3fcfV7mQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4Ysk-00HQVX-R0; Fri, 24 Jun 2022 02:17:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4Ysh-00HQRA-Md
	for kexec@lists.infradead.org; Fri, 24 Jun 2022 02:17:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656037013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MMevWlMsvGzPDiM2Lypw9wKXAiTXhNE+iSPI2yfY/90=;
	b=Or7sFmDQwb8Ec0EaPd7tf1cxa+T5/eheritg+dBqXP3mmWNH8P6eEFCaImgkulMXZ0wGqN
	Riuv+6YackxGD+g00ONW4o9y3cV12fHhGwQzvjTgNvR1qGOibYBqXviCOKDz85BMubRwaz
	0opEhrfdcee68MECtJZohbM8FfIdySM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-hJXtbRU7Nea0EEq8UbUOoA-1; Thu, 23 Jun 2022 22:16:50 -0400
X-MC-Unique: hJXtbRU7Nea0EEq8UbUOoA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73F9E296A612;
	Fri, 24 Jun 2022 02:16:49 +0000 (UTC)
Received: from localhost (ovpn-12-66.pek2.redhat.com [10.72.12.66])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B23BC2810D;
	Fri, 24 Jun 2022 02:16:47 +0000 (UTC)
Date: Fri, 24 Jun 2022 10:16:44 +0800
From: Baoquan He <bhe@redhat.com>
To: Li Chen <me@linux.beauty>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Eric Biederman <ebiederm@xmission.com>,
	kexec <kexec@lists.infradead.org>
Subject: Re: [PATCH] kexec: replace crash_mem_range with range
Message-ID: <YrUejNdTnVR9b13E@MiWiFi-R3L-srv>
References: <18165bf7271.d72aa7571639569.7041635736718062250@linux.beauty>
 <YqqPiU+tkCh+vXC/@MiWiFi-R3L-srv>
 <1816a5f606e.e04b74691938779.8131546087211870513@linux.beauty>
MIME-Version: 1.0
In-Reply-To: <1816a5f606e.e04b74691938779.8131546087211870513@linux.beauty>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bhe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220623_191711_850493_826E399C 
X-CRM114-Status: GOOD (  30.24  )
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

Hi,

On 06/15/22 at 07:37pm, Li Chen wrote:
> Hi Baoquan,
> 
>  ---- On Wed, 15 Jun 2022 19:03:53 -0700 Baoquan He <bhe@redhat.com> wrote ----
>  > On 06/14/22 at 10:04pm, Li Chen wrote:
>  > > From: Li Chen <lchen@ambarella.com>
>  > > 
>  > > We already have struct range, so just use it.
>  > 
>  > Looks good, have you tested it?
> 
> No, I don't have ppc machine, just pass compile on x86.

Can someone from ppc side help test this patch? If no, I will try to
find a ppc machine to run the test. Thanks in advance.

Thanks
Baoquan

> 
> 
>  > 
>  > > 
>  > > Signed-off-by: Li Chen <lchen@ambarella.com>
>  > > ---
>  > >  arch/powerpc/kexec/file_load_64.c | 2 +-
>  > >  arch/powerpc/kexec/ranges.c       | 8 ++++----
>  > >  include/linux/kexec.h             | 7 ++-----
>  > >  kernel/kexec_file.c               | 2 +-
>  > >  4 files changed, 8 insertions(+), 11 deletions(-)
>  > > 
>  > > diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
>  > > index b4981b651d9a..583b7fc478f2 100644
>  > > --- a/arch/powerpc/kexec/file_load_64.c
>  > > +++ b/arch/powerpc/kexec/file_load_64.c
>  > > @@ -34,7 +34,7 @@ struct umem_info {
>  > >  
>  > >      /* usable memory ranges to look up */
>  > >      unsigned int nr_ranges;
>  > > -    const struct crash_mem_range *ranges;
>  > > +    const struct range *ranges;
>  > >  };
>  > >  
>  > >  const struct kexec_file_ops * const kexec_file_loaders[] = {
>  > > diff --git a/arch/powerpc/kexec/ranges.c b/arch/powerpc/kexec/ranges.c
>  > > index 563e9989a5bf..5fc53a5fcfdf 100644
>  > > --- a/arch/powerpc/kexec/ranges.c
>  > > +++ b/arch/powerpc/kexec/ranges.c
>  > > @@ -33,7 +33,7 @@
>  > >  static inline unsigned int get_max_nr_ranges(size_t size)
>  > >  {
>  > >      return ((size - sizeof(struct crash_mem)) /
>  > > -        sizeof(struct crash_mem_range));
>  > > +        sizeof(struct range));
>  > >  }
>  > >  
>  > >  /**
>  > > @@ -51,7 +51,7 @@ static inline size_t get_mem_rngs_size(struct crash_mem *mem_rngs)
>  > >          return 0;
>  > >  
>  > >      size = (sizeof(struct crash_mem) +
>  > > -        (mem_rngs->max_nr_ranges * sizeof(struct crash_mem_range)));
>  > > +        (mem_rngs->max_nr_ranges * sizeof(struct range)));
>  > >  
>  > >      /*
>  > >       * Memory is allocated in size multiple of MEM_RANGE_CHUNK_SZ.
>  > > @@ -98,7 +98,7 @@ static int __add_mem_range(struct crash_mem **mem_ranges, u64 base, u64 size)
>  > >   */
>  > >  static void __merge_memory_ranges(struct crash_mem *mem_rngs)
>  > >  {
>  > > -    struct crash_mem_range *ranges;
>  > > +    struct range *ranges;
>  > >      int i, idx;
>  > >  
>  > >      if (!mem_rngs)
>  > > @@ -123,7 +123,7 @@ static void __merge_memory_ranges(struct crash_mem *mem_rngs)
>  > >  /* cmp_func_t callback to sort ranges with sort() */
>  > >  static int rngcmp(const void *_x, const void *_y)
>  > >  {
>  > > -    const struct crash_mem_range *x = _x, *y = _y;
>  > > +    const struct range *x = _x, *y = _y;
>  > >  
>  > >      if (x->start > y->start)
>  > >          return 1;
>  > > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>  > > index 58d1b58a971e..d7ab4ad4c619 100644
>  > > --- a/include/linux/kexec.h
>  > > +++ b/include/linux/kexec.h
>  > > @@ -17,6 +17,7 @@
>  > >  
>  > >  #include <linux/crash_core.h>
>  > >  #include <asm/io.h>
>  > > +#include <linux/range.h>
>  > >  
>  > >  #include <uapi/linux/kexec.h>
>  > >  
>  > > @@ -214,14 +215,10 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf);
>  > >  /* Alignment required for elf header segment */
>  > >  #define ELF_CORE_HEADER_ALIGN   4096
>  > >  
>  > > -struct crash_mem_range {
>  > > -    u64 start, end;
>  > > -};
>  > > -
>  > >  struct crash_mem {
>  > >      unsigned int max_nr_ranges;
>  > >      unsigned int nr_ranges;
>  > > -    struct crash_mem_range ranges[];
>  > > +    struct range ranges[];
>  > >  };
>  > >  
>  > >  extern int crash_exclude_mem_range(struct crash_mem *mem,
>  > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>  > > index 8347fc158d2b..f2758af86b93 100644
>  > > --- a/kernel/kexec_file.c
>  > > +++ b/kernel/kexec_file.c
>  > > @@ -1183,7 +1183,7 @@ int crash_exclude_mem_range(struct crash_mem *mem,
>  > >  {
>  > >      int i, j;
>  > >      unsigned long long start, end, p_start, p_end;
>  > > -    struct crash_mem_range temp_range = {0, 0};
>  > > +    struct range temp_range = {0, 0};
>  > >  
>  > >      for (i = 0; i < mem->nr_ranges; i++) {
>  > >          start = mem->ranges[i].start;
>  > > -- 
>  > > 2.36.1
>  > > 
>  > > 
>  > > 
>  > > _______________________________________________
>  > > kexec mailing list
>  > > kexec@lists.infradead.org
>  > > http://lists.infradead.org/mailman/listinfo/kexec
>  > > 
>  > 
>  > 
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

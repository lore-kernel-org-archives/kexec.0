Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C281D3B7E2
	for <kexec@archiver.kernel.org>; Tue,  9 Dec 2025 03:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NbFVdOXb1Nr6+8TD5KZltub496iqTHAYaOUL7OnbUgQ=; b=HmohIObeKmZPufmJ7FdSD7FLSD
	d6XFIYsevTfyBOzQi/LweUMFC652SpWDWivH2Vpv5dMi3KSP4PBU8aML9uhTPBpvV03mj2GpHWFDW
	M2c/G/f/jjIRquIRrxJ1gsbwmLgZCzBwhwxIVCzfbfqptTjFPcIqnlFO339wuRyuGLhwjirXQCTke
	9t7Plnd3iePg9qQbr1J7768R6eD8ppiincQXok7U2YO9ltKmWBgQ+pQUtTXz+dimwgCH1Q8xQ1BBe
	6djvY3Frlmpcxtos09r1SpLhaxFZGn4BwCgPkjEa1s6RuS5u6uCHWeeoXpz2pvg/XJVr2izwdbcvY
	4MEMjLTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSoOZ-0000000DlrN-2AfU;
	Tue, 09 Dec 2025 03:28:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSoOW-0000000Dlqu-3Rxm
	for kexec@lists.infradead.org;
	Tue, 09 Dec 2025 03:28:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765250887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NbFVdOXb1Nr6+8TD5KZltub496iqTHAYaOUL7OnbUgQ=;
	b=UE1Q/njYzWeAztwQXFKi4qEtvrWLaUlbjy1+8/tN0tg5eWz4J+DOP4eDvEzP21mW9v5Tkr
	IFNUm1QIorU8BSS2f/mtEtAh6/u6l4DnuF7rS+vxIuEi2iDEBqXOtgQetpQa2o/vmXDYSq
	GWcagEruGIUSknrmhbV/008Fnkp4ZGU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-P4iN0WunM0CoN3RLOuYODw-1; Mon,
 08 Dec 2025 22:28:00 -0500
X-MC-Unique: P4iN0WunM0CoN3RLOuYODw-1
X-Mimecast-MFC-AGG-ID: P4iN0WunM0CoN3RLOuYODw_1765250878
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A24091956088;
	Tue,  9 Dec 2025 03:27:57 +0000 (UTC)
Received: from localhost (unknown [10.72.112.51])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2678719560AD;
	Tue,  9 Dec 2025 03:27:54 +0000 (UTC)
Date: Tue, 9 Dec 2025 11:27:50 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com,
	dvyukov@google.com, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	elver@google.com, sj@kernel.org, lorenzo.stoakes@oracle.com,
	snovitoll@gmail.com, christophe.leroy@csgroup.eu
Subject: Re: [PATCH v4 02/12] mm/kasan: move kasan= code to common place
Message-ID: <aTeXNkWx/U8MB9hf@MiWiFi-R3L-srv>
References: <20251128033320.1349620-1-bhe@redhat.com>
 <20251128033320.1349620-3-bhe@redhat.com>
 <CA+fCnZeHZ4+8GOn0untumM0TE9TeSHqja9kAsbEb-+jbEFNQQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZeHZ4+8GOn0untumM0TE9TeSHqja9kAsbEb-+jbEFNQQQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251208_192808_938348_025E09F5 
X-CRM114-Status: GOOD (  32.72  )
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

On 12/04/25 at 05:39pm, Andrey Konovalov wrote:
> On Fri, Nov 28, 2025 at 4:33 AM Baoquan He <bhe@redhat.com> wrote:
> >
> > This allows generic and sw_tags to be set in kernel cmdline too.
> >
> > When at it, rename 'kasan_arg' to 'kasan_arg_disabled' as a bool
> > variable. And expose 'kasan_flag_enabled' to kasan common place
> > too.
> 
> This asks to be two separate patches.

Makes sense to me, thanks..

> 
> >
> > This is prepared for later adding kernel parameter kasan=on|off for
> > all three kasan modes.
> >
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  include/linux/kasan-enabled.h |  4 +++-
> >  mm/kasan/common.c             | 20 ++++++++++++++++++--
> >  mm/kasan/hw_tags.c            | 28 ++--------------------------
> >  3 files changed, 23 insertions(+), 29 deletions(-)
> >
> > diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
> > index 9eca967d8526..b05ec6329fbe 100644
> > --- a/include/linux/kasan-enabled.h
> > +++ b/include/linux/kasan-enabled.h
> > @@ -4,13 +4,15 @@
> >
> >  #include <linux/static_key.h>
> >
> > -#if defined(CONFIG_ARCH_DEFER_KASAN) || defined(CONFIG_KASAN_HW_TAGS)
> 
> These changes of moving/removing CONFIG_ARCH_DEFER_KASAN also seem to
> belong to a separate patch (or should be combined with patch 12?); the
> commit message does not even mention them.

Yes, combining tit with patch 12 sounds great. I will move patch 12 to
earlier oder.

> 
> > +extern bool kasan_arg_disabled;
> > +
> >  /*
> >   * Global runtime flag for KASAN modes that need runtime control.
> >   * Used by ARCH_DEFER_KASAN architectures and HW_TAGS mode.
> >   */
> >  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
> 
> So kasan_flag_enabled is now always exposed here...
> 
> >
> > +#if defined(CONFIG_ARCH_DEFER_KASAN) || defined(CONFIG_KASAN_HW_TAGS)
> 
> but the functions that use it are not. Why?

Good question. I didn't consider this reasonably. At the beginning, I
thought it could cause problem if people has specified 'kasan=off'
before patch 12 when bisecting. That's why put kasan_arg_disabled and
kasan_flag_enabled declaration outside of any ifdeffery scope. Now after
reconsiderring, putting patch 12 earlier can solve the problem.

Thanks for careful reivewing, all suggestions are good and taken.

> 
> 
> >  /*
> >   * Runtime control for shadow memory initialization or HW_TAGS mode.
> >   * Uses static key for architectures that need deferred KASAN or HW_TAGS.
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index 1d27f1bd260b..ac14956986ee 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -32,14 +32,30 @@
> >  #include "kasan.h"
> >  #include "../slab.h"
> >
> > -#if defined(CONFIG_ARCH_DEFER_KASAN) || defined(CONFIG_KASAN_HW_TAGS)
> >  /*
> >   * Definition of the unified static key declared in kasan-enabled.h.
> >   * This provides consistent runtime enable/disable across KASAN modes.
> >   */
> >  DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
> >  EXPORT_SYMBOL_GPL(kasan_flag_enabled);
> > -#endif
> > +
> > +bool kasan_arg_disabled __ro_after_init;
> > +/* kasan=off/on */
> > +static int __init early_kasan_flag(char *arg)
> > +{
> > +       if (!arg)
> > +               return -EINVAL;
> > +
> > +       if (!strcmp(arg, "off"))
> > +               kasan_arg_disabled = true;
> > +       else if (!strcmp(arg, "on"))
> > +               kasan_arg_disabled = false;
> > +       else
> > +               return -EINVAL;
> > +
> > +       return 0;
> > +}
> > +early_param("kasan", early_kasan_flag);
> >
> >  struct slab *kasan_addr_to_slab(const void *addr)
> >  {
> > diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> > index 1c373cc4b3fa..709c91abc1b1 100644
> > --- a/mm/kasan/hw_tags.c
> > +++ b/mm/kasan/hw_tags.c
> > @@ -22,12 +22,6 @@
> >
> >  #include "kasan.h"
> >
> > -enum kasan_arg {
> > -       KASAN_ARG_DEFAULT,
> > -       KASAN_ARG_OFF,
> > -       KASAN_ARG_ON,
> > -};
> > -
> >  enum kasan_arg_mode {
> >         KASAN_ARG_MODE_DEFAULT,
> >         KASAN_ARG_MODE_SYNC,
> > @@ -41,7 +35,6 @@ enum kasan_arg_vmalloc {
> >         KASAN_ARG_VMALLOC_ON,
> >  };
> >
> > -static enum kasan_arg kasan_arg __ro_after_init;
> >  static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
> >  static enum kasan_arg_vmalloc kasan_arg_vmalloc __initdata;
> >
> > @@ -81,23 +74,6 @@ unsigned int kasan_page_alloc_sample_order = PAGE_ALLOC_SAMPLE_ORDER_DEFAULT;
> >
> >  DEFINE_PER_CPU(long, kasan_page_alloc_skip);
> >
> > -/* kasan=off/on */
> > -static int __init early_kasan_flag(char *arg)
> > -{
> > -       if (!arg)
> > -               return -EINVAL;
> > -
> > -       if (!strcmp(arg, "off"))
> > -               kasan_arg = KASAN_ARG_OFF;
> > -       else if (!strcmp(arg, "on"))
> > -               kasan_arg = KASAN_ARG_ON;
> > -       else
> > -               return -EINVAL;
> > -
> > -       return 0;
> > -}
> > -early_param("kasan", early_kasan_flag);
> > -
> >  /* kasan.mode=sync/async/asymm */
> >  static int __init early_kasan_mode(char *arg)
> >  {
> > @@ -222,7 +198,7 @@ void kasan_init_hw_tags_cpu(void)
> >          * When this function is called, kasan_flag_enabled is not yet
> >          * set by kasan_init_hw_tags(). Thus, check kasan_arg instead.
> >          */
> > -       if (kasan_arg == KASAN_ARG_OFF)
> > +       if (kasan_arg_disabled)
> >                 return;
> >
> >         /*
> > @@ -240,7 +216,7 @@ void __init kasan_init_hw_tags(void)
> >                 return;
> >
> >         /* If KASAN is disabled via command line, don't initialize it. */
> > -       if (kasan_arg == KASAN_ARG_OFF)
> > +       if (kasan_arg_disabled)
> >                 return;
> >
> >         switch (kasan_arg_mode) {
> > --
> > 2.41.0
> >
> 



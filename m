Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6393C87FD2
	for <kexec@archiver.kernel.org>; Fri,  8 Aug 2025 13:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GIqJ6f/aDwqAFbRn5MC1kbdMPJMwUfUOc/srLwo7ZjI=; b=GRHaTsAR9V7xG9JlQInUz9fDgV
	3Buhfc+se7Bi1MHOtK5/5A2EziBMeDF/8dS2S2La94LVb3r06EknFBcPXEjMP+PqtfbxXx71CJdzU
	zAJLy5SFzpOCVI/nuLXcvuTqUHWKVTwS5Ie99vFDM/1vpeLXhAZ+WgIoFydOnXFWjnoH/C4E8iSMo
	Yi2inXcd+Ly+ShHmgylqhZq5rJLkbxQf/qGZC3IdetgF4NaWKZGAKQTq7d6uuDVQTBDDObjaSgEwF
	PTrdSVx7FLH3gm+0ynOTFPV78pMEwQ6DulyrQv5PCovYLIkekQ90GQ5kZp2E/ZbZq5QR8u8yskLd7
	If8Hi9VQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukMuq-00000002taD-1q0j;
	Fri, 08 Aug 2025 13:13:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukMjK-00000002s8B-1Cy4
	for kexec@lists.infradead.org;
	Fri, 08 Aug 2025 13:01:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754658113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GIqJ6f/aDwqAFbRn5MC1kbdMPJMwUfUOc/srLwo7ZjI=;
	b=C3SeBB8HD1gNrtdvPrLscqvKV5oH6LxctUA3n+l8plXHcv7yMfuOOjfF1Pz9jggFaHdrz+
	N8lmZuAK6nsB7zAKYyDs/APysMEZ8vhVnyII96bUjUqaK0t8NkkpeUNHkGTGOQeoh9ljki
	NbTsRs/kLjv8OwPnUMwy6Nt3Pb2l+kc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-CU-roWnKMwqBdKpO_Vmcog-1; Fri,
 08 Aug 2025 09:01:49 -0400
X-MC-Unique: CU-roWnKMwqBdKpO_Vmcog-1
X-Mimecast-MFC-AGG-ID: CU-roWnKMwqBdKpO_Vmcog_1754658103
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1812F180034D;
	Fri,  8 Aug 2025 13:01:43 +0000 (UTC)
Received: from localhost (unknown [10.72.112.126])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7BBB61800297;
	Fri,  8 Aug 2025 13:01:41 +0000 (UTC)
Date: Fri, 8 Aug 2025 21:01:37 +0800
From: Baoquan He <bhe@redhat.com>
To: Marco Elver <elver@google.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com,
	andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 2/4] mm/kasan: move kasan= code to common place
Message-ID: <aJX1Mcc1QrkUgi89@MiWiFi-R3L-srv>
References: <20250805062333.121553-1-bhe@redhat.com>
 <20250805062333.121553-3-bhe@redhat.com>
 <CANpmjNNr7e6DXQrZva8k46jELr1JSkjExWvQOyrkY5VD8mOadw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNr7e6DXQrZva8k46jELr1JSkjExWvQOyrkY5VD8mOadw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250808_060154_398696_4BC6CC4A 
X-CRM114-Status: GOOD (  21.76  )
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

On 08/06/25 at 09:11am, Marco Elver wrote:
> On Tue, 5 Aug 2025 at 08:24, 'Baoquan He' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > This allows generic and sw_tags to be set in kernel cmdline too.
> >
> > When at it, rename 'kasan_arg' to 'kasan_arg_disabled' as a bool
> > variable. And expose 'kasan_flag_enabled' to kasan common place
> > too.
> >
> > This is prepared for later adding kernel parameter kasan=on|off for
> > all kasan modes.
> >
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  include/linux/kasan-enabled.h |  4 +++-
> >  mm/kasan/common.c             | 27 +++++++++++++++++++++++++++
> >  mm/kasan/hw_tags.c            | 35 ++---------------------------------
> >  3 files changed, 32 insertions(+), 34 deletions(-)
> >
> > diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
> > index 6f612d69ea0c..32f2d19f599f 100644
> > --- a/include/linux/kasan-enabled.h
> > +++ b/include/linux/kasan-enabled.h
> > @@ -4,10 +4,12 @@
> >
> >  #include <linux/static_key.h>
> >
> > -#ifdef CONFIG_KASAN_HW_TAGS
> > +extern bool kasan_arg_disabled;
> >
> >  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
> >
> > +#ifdef CONFIG_KASAN_HW_TAGS
> > +
> >  static __always_inline bool kasan_enabled(void)
> >  {
> >         return static_branch_likely(&kasan_flag_enabled);
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index ed4873e18c75..fe6937654203 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -32,6 +32,33 @@
> >  #include "kasan.h"
> >  #include "../slab.h"
> >
> > +/*
> > + * Whether KASAN is enabled at all.
> > + * The value remains false until KASAN is initialized.
> > + */
> > +DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
> > +EXPORT_SYMBOL(kasan_flag_enabled);
> > +
> > +bool kasan_arg_disabled;
> 
> You lost __ro_after_init

Right, thanks for careful reviewing.

> 
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
> > +
> > +
> > +
> 
> Why extra blank lines?

Good catch, will remove it in v2. Thanks.



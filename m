Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6362AC61DF4
	for <kexec@archiver.kernel.org>; Sat, 25 Nov 2023 02:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lc/m1ClgY4wCPYij8t8DgW+c6rBUHV5HUMSDll0Yr/I=; b=RBo93PuUJ0js+0
	xCUW5Adtbm1g6ktgWXSXoMMU4VR6OTTnKP/evDKIXf2TXIoPLb4nkfu6bPROwwF02KRvNrZnWiz1Q
	ltrHDzG+U1YbCSE+wbEd+GmMipEVLpgIPWYj6UyxUc6BYyWLqyVAImZBsvBA47AAg0aNzlqWEufz/
	5PhvTIltMUDLiJavX2QphgOLz2YmzDIIh2QgK71+ErYaXzI/Fp7IcaI97fIJSWDgv+2lCVngsfvMl
	oUwvUNzkecR7rqZXdD/sb4UBRUFKIsM8ZwDTqGHlyweF7pnwXISk9/+ZDwth69PgBxIV7ugXrVF7L
	EJdTv0wninLI9Jjw6hBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r6iQZ-008QRN-2X;
	Sat, 25 Nov 2023 02:29:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r6iQY-008QQg-09
	for kexec@lists.infradead.org;
	Sat, 25 Nov 2023 02:29:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700879388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OPID5CjYb2m6MvI+i3cidt4yTGrsfS5NjhuE3IlMXf0=;
	b=VyJ3awFlqbdY5q8QX7xlc9MrGHdLfmkCijBkNE8ZSfaMqr2uscpzfE8LoDdLoqyhAhxjrB
	EvWgVMA23XZ1dci5L3I3hOduGzVb0rTgZJuzSFa1oqSXYOOUWymfTgkAVen/VVo+BPWZpc
	IE+sOWFgF0gISlik+pUuxzAWDt3O7aU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-Bz5UptqaO1Kx4oL_jq0oKQ-1; Fri, 24 Nov 2023 21:29:46 -0500
X-MC-Unique: Bz5UptqaO1Kx4oL_jq0oKQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74094811E7D;
	Sat, 25 Nov 2023 02:29:45 +0000 (UTC)
Received: from localhost (unknown [10.72.112.36])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C57782026D4C;
	Sat, 25 Nov 2023 02:29:44 +0000 (UTC)
Date: Sat, 25 Nov 2023 10:29:41 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ignat Korchagin <ignat@cloudflare.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org, eric_devolder@yahoo.com,
	kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH 2/3] drivers/base/cpu: crash data showing should depends
 on KEXEC_CORE
Message-ID: <ZWFcFU9PjHl2L09u@MiWiFi-R3L-srv>
References: <20231123073652.507034-1-bhe@redhat.com>
 <20231123073652.507034-3-bhe@redhat.com>
 <CALrw=nFzy2zq-khLUCXsuf8J5_mka0YPyTosO190OUst2QSjVQ@mail.gmail.com>
 <ZV80X+lf2iOOTboW@MiWiFi-R3L-srv>
 <20231124084441.b913fc404fec53d5d0946c55@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231124084441.b913fc404fec53d5d0946c55@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231124_182950_153935_C673DD9A 
X-CRM114-Status: GOOD (  15.31  )
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

On 11/24/23 at 08:44am, Andrew Morton wrote:
> On Thu, 23 Nov 2023 19:15:43 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > > > CONFIG_KEXEC is used to enable kexec_load interface, the
> > > > crash_notes/crash_notes_size/crash_hotplug showing depends on
> > > > CONFIG_KEXEC is incorrect. It should depend on KEXEC_CORE instead.
> > > >
> > > > Fix it now.
> > > 
> > > Can we add Fixes/CC stable, so it gets eventually backported into 6.6?
> > 
> > Makes sense. Will add it in v2 since I need respin to add the missing
> > stuff in patch 1. Thanks.
> 
> Please avoid mixing cc:stable patches and this-merge-window fixes in
> the same series as next-merge-window material.  Because I'll just have
> to separate them out anyway, causing what-I-merged to unnecessarily
> differ from what-you-sent.

Got it, will send them separately because the issue that this patch is fixing
has been there for very long time. Thanks for noticing.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

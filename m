Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B1DC47DD9
	for <kexec@archiver.kernel.org>; Sun, 24 Mar 2024 10:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BuHDloxIlhvVRdrRW8VTIvQYINOCqwMh+RqHGuU4KWg=; b=OEsGXS5n/U+LDX
	mYQGMOA14gJxVQ3vNxuVsJRztALil+oimjcHhG32yUhjtQqrxrgvlV13mCOsr2/wObrZxE+in9mmr
	5ex6eImxC+JE1UuknS0X1KvQyI92GrkjOv569Q0KQ6eqAUpjULgGZrWyrDjjdyvrmbte23XFxw+eg
	8rmFYwJDTc9wNqt9Ws/7ntrKXS9UlHBciG5ZyU+uJuz7x5PXIcK0cWFsRoohto+SkqjTebLYvMeak
	N3aoos9fEewz1mq+1fH+R3k0o+sGynqdGka4lXGLEuQEQA97pxQaE6mLnGIWfp1dH2IOh2CuEqQo1
	/d+0ga6EHvKYOLByq4bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roKfI-0000000CIVE-2HDl;
	Sun, 24 Mar 2024 10:01:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roKfE-0000000CIU8-1249
	for kexec@lists.infradead.org;
	Sun, 24 Mar 2024 10:01:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711274472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RfH3QzU95PzfsukOJ1WaAwTLgYf8vlvgxPDNhEf4xog=;
	b=XiyD3/civ7xZHxY7jp5l9IBCp+8u+Pe9W7FM+9JSmYpUB1fkSMIpQQpXa+XhaZspLY0EnI
	8qcOWN15GhyJTuryA5SVWVoDkEtTiQLI59pCeI6wZEpr+gF69Y0j6S60R8ZAA5LEnLibtw
	mTLNQhELKVsXrIPVwf4Xxff95rsLVjc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-wDbvS-nJNOSmsMCHyVhjNg-1; Sun,
 24 Mar 2024 06:01:08 -0400
X-MC-Unique: wDbvS-nJNOSmsMCHyVhjNg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F8B81C05AF4;
	Sun, 24 Mar 2024 10:01:07 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7ED5D492BD3;
	Sun, 24 Mar 2024 10:01:04 +0000 (UTC)
Date: Sun, 24 Mar 2024 18:00:53 +0800
From: Baoquan He <bhe@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	akpm@linux-foundation.org, chenhuacai@loongson.cn,
	dyoung@redhat.com, jbohac@suse.cz, lihuafei1@huawei.com,
	chenhaixiang3@huawei.com
Subject: Re: [PATCH] crash: use macro to add crashk_res into iomem early for
 specific arch
Message-ID: <Zf/51a+QonYj6sI7@MiWiFi-R3L-srv>
References: <20240324033513.1027427-1-bhe@redhat.com>
 <Zf+m4YtKtmdrjw4Q@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zf+m4YtKtmdrjw4Q@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240324_030116_448442_987CF475 
X-CRM114-Status: GOOD (  12.30  )
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

On 03/24/24 at 05:06am, Ingo Molnar wrote:
> 
> * Baoquan He <bhe@redhat.com> wrote:
> 
......snip
> > ---
> >  arch/x86/include/asm/crash_reserve.h | 2 ++
> >  kernel/crash_reserve.c               | 7 +++++++
> >  2 files changed, 9 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/crash_reserve.h b/arch/x86/include/asm/crash_reserve.h
> > index 152239f95541..4681a543eba3 100644
> > --- a/arch/x86/include/asm/crash_reserve.h
> > +++ b/arch/x86/include/asm/crash_reserve.h
> > @@ -39,4 +39,6 @@ static inline unsigned long crash_low_size_default(void)
> >  #endif
> >  }
> >  
> > +# define HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
> > +
> 
> Any reason for that stray space?

No clear reason. I saw stray space was added for macro definning when my
below patch was merged, not sure if this is preferred. And there are
a lot of "# define " when searching with 'git grep "# define " arch/x86/include/'.

commit 85fcde402db1 ("kexec: split crashkernel reservation code out from crash_core.c")


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

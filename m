Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A00CCFA05
	for <kexec@archiver.kernel.org>; Thu,  6 Nov 2025 03:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+rv33evyCdtZ/WOHyRrPfVlUnSklHK0ydY8JP6rULH8=; b=Xyz8CPxWFF8sp1KHfvRGvx42jL
	84ADsonY2vUXLgH1VmnfuLUdMXODCa457dpfeBCYffG+ISJnw1KVXs11KcqX7SZFJjwLxb4TC2t+y
	bOlXDpm81BVF+wh0V1xcUSKmMQeHY+tekKk07lm6pP5VYKx1QS70lxZycEn7wj0sRTRds7g3+Iam7
	zc0pbvTymqT1+pT1mYeQWgPFPe6hpAiWkKOCK/2k0XP1Cd8IdY5FPNiQiR+KLj7Sethki8fGkre7B
	TEKb6sw3WRczLiww6bjDTQ4bk45Kok65KxB2ziX9hVE8Aovo1saZd/Eg77L8dlbzR9TSd8Hi2vazm
	Yu5aVlUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGqZl-0000000EoCZ-1aP4;
	Thu, 06 Nov 2025 03:22:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGqZd-0000000EoC6-3CXq
	for kexec@lists.infradead.org;
	Thu, 06 Nov 2025 03:22:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762399327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+rv33evyCdtZ/WOHyRrPfVlUnSklHK0ydY8JP6rULH8=;
	b=W4xxc+A3culLqhjVjy6cNfG8EaJUwPUfLMAQcWGmlhAPxd94TlJ0lbn3zkYTB8ye0BpyV6
	D137Bk5X4UGaEkDIL2aV/yuhYvoILkKA3xl42ptJ1+azVXDeIieCBxFjTIW1H+SxFLu/vK
	EZK75uuMzemjcqo5mF4hh8tKVm8si5I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-8TnxEnnfP1ut28_PEjFtyg-1; Wed,
 05 Nov 2025 22:22:03 -0500
X-MC-Unique: 8TnxEnnfP1ut28_PEjFtyg-1
X-Mimecast-MFC-AGG-ID: 8TnxEnnfP1ut28_PEjFtyg_1762399322
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44AC919560B2;
	Thu,  6 Nov 2025 03:22:01 +0000 (UTC)
Received: from localhost (unknown [10.72.112.190])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E67DA1956095;
	Thu,  6 Nov 2025 03:21:58 +0000 (UTC)
Date: Thu, 6 Nov 2025 11:21:54 +0800
From: Baoquan He <bhe@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Alexander Graf <graf@amazon.com>,
	Steven Chen <chenste@linux.microsoft.com>
Subject: Re: [PATCH 2/2] kernel/kexec: Fix IMA when allocation happens in CMA
 area
Message-ID: <aQwUUh3noWGXaite@MiWiFi-R3L-srv>
References: <20251105130922.13321-1-piliu@redhat.com>
 <20251105130922.13321-2-piliu@redhat.com>
 <aQwCDMhidg+a2Jzt@MiWiFi-R3L-srv>
 <CAF+s44StrV1USH4ZLQ6DRobXA=hXOs6EVkmeeeTsK-koWsV_KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF+s44StrV1USH4ZLQ6DRobXA=hXOs6EVkmeeeTsK-koWsV_KQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_192209_876089_5976411C 
X-CRM114-Status: GOOD (  28.48  )
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

On 11/06/25 at 10:33am, Pingfan Liu wrote:
> Hi Baoquan,
> 
> Thanks for your review. Please see the comment below.
> 
> On Thu, Nov 6, 2025 at 10:04 AM Baoquan He <bhe@redhat.com> wrote:
> >
> > Hi Pingfan,
> >
> > On 11/05/25 at 09:09pm, Pingfan Liu wrote:
> > > When I tested kexec with the latest kernel, I ran into the following warning:
> > >
> > > [   40.712410] ------------[ cut here ]------------
> > > [   40.712576] WARNING: CPU: 2 PID: 1562 at kernel/kexec_core.c:1001 kimage_map_segment+0x144/0x198
> > > [...]
> > > [   40.816047] Call trace:
> > > [   40.818498]  kimage_map_segment+0x144/0x198 (P)
> > > [   40.823221]  ima_kexec_post_load+0x58/0xc0
> > > [   40.827246]  __do_sys_kexec_file_load+0x29c/0x368
> > > [...]
> > > [   40.855423] ---[ end trace 0000000000000000 ]---
> > >
> > > This is caused by the fact that kexec allocates the destination directly
> > > in the CMA area. In that case, the CMA kernel address should be exported
> > > directly to the IMA component, instead of using the vmalloc'd address.
> > >
> > > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Baoquan He <bhe@redhat.com>
> > > Cc: Alexander Graf <graf@amazon.com>
> > > Cc: Steven Chen <chenste@linux.microsoft.com>
> > > Cc: linux-integrity@vger.kernel.org
> > > To: kexec@lists.infradead.org
> > > ---
> > >  kernel/kexec_core.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > > index 9a1966207041..abe40286a02c 100644
> > > --- a/kernel/kexec_core.c
> > > +++ b/kernel/kexec_core.c
> > > @@ -967,6 +967,7 @@ void *kimage_map_segment(struct kimage *image, int idx)
> > >       kimage_entry_t *ptr, entry;
> > >       struct page **src_pages;
> > >       unsigned int npages;
> > > +     struct page *cma;
> > >       void *vaddr = NULL;
> > >       int i;
> > >
> > > @@ -974,6 +975,9 @@ void *kimage_map_segment(struct kimage *image, int idx)
> > >       size = image->segment[idx].memsz;
> > >       eaddr = addr + size;
> > >
> > > +     cma = image->segment_cma[idx];
> >
> > Thanks for your fix. But I totally can't get what you are doing. The idx
> > passed into kimage_map_segment() could index image->segment[], and can
> > index image->segment_cma[], could you reconsider and make the code more
> > reasonable?
> >
> 
> Since idx can index both image->segment[] and segment_cma[], the
> behavior differs based on whether segment_cma[idx] is NULL:
> 
> - If segment_cma[idx] is not NULL, it points directly to the final
> target location, eliminating the need for data copying that
> traditional kexec relocation requires.
> - If segment_cma[idx] is NULL, the segment relies on the traditional
> kexec relocation code to copy its data.

I see, thanks. While image->segment_cma[idx] records the struct page of
the relevant cma area, but not virtual address. Is it OK for IMA later
to update? ima_kexec_buffer is supposed to be a virtual address,
wondering how IMA behaved in this case.



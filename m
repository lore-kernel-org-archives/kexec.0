Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9D4C77B73
	for <kexec@archiver.kernel.org>; Wed, 31 May 2023 07:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gv2eeg2hcii9srTUHBOPz8p4sXq+i+aBuMuV0ov4rmw=; b=KxAQSvVfwI4gw9
	bnKD4hdRKT1WKB2g5mILS1v8Yqnhrvh2ytSydhrdlJ9Hu/NO0pK1UUW5BaSzcKMiOFdlf09V2eca+
	FC1EBYZutK6P7M/Uv99FUTpLGjAzF1z+ZDKxHHovSd02zPXGLAfXoetysXkjSNrTk7n4JiOOYrsW4
	ybI9F+pJrJWBbKoYUUmjcm07eFXzrrq+ft4asru2j6NBZ23vbAdwaDK79CVOLOq0EdxB8R0HWSBFb
	SOvp2wdFLg6OcCbslnYBQeNDI/TcWeXgYChN0nBrq9h4EqiT7ts6T8A+u3avzOhmdIawfFik6NNeF
	Hs4tK1xPZGKokNz25Uyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4GIh-00GRxl-0E;
	Wed, 31 May 2023 07:31:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4GIe-00GRvl-0v
	for kexec@lists.infradead.org;
	Wed, 31 May 2023 07:31:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685518270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xgdLJ8iH5oaqpzGT2VDUPLqR1HXU87CsPuv2JR9kJ1k=;
	b=VmjdWosse65P/mOn3a96FTLFTuPkLeUwB4hQGxZ9j+HLL+sJU745YbgUJzPHyRxd/roZ4p
	o21yauvIeyivaUUxn7yIvbCQOMf5icE23d0tEPrz6OL7i8eeU3T9EZtAHEm/TfGfzN0iRi
	PFKoPvYO+AgFXKY63jG1egFl55X23L4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-379-gbwutGR5OXqtxdF2C-E10A-1; Wed, 31 May 2023 03:31:07 -0400
X-MC-Unique: gbwutGR5OXqtxdF2C-E10A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6A101C068CF;
	Wed, 31 May 2023 07:31:06 +0000 (UTC)
Received: from localhost (ovpn-12-54.pek2.redhat.com [10.72.12.54])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DE373492B00;
	Wed, 31 May 2023 07:31:05 +0000 (UTC)
Date: Wed, 31 May 2023 15:31:01 +0800
From: Baoquan He <bhe@redhat.com>
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc: Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michael Holzheu <holzheu@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/6] kexec: fix a memory leak in crash_shrink_memory()
Message-ID: <ZHb3tVHVV2l1BJBl@MiWiFi-R3L-srv>
References: <20230527123439.772-1-thunder.leizhen@huawei.com>
 <20230527123439.772-2-thunder.leizhen@huawei.com>
 <ZHaQ7qRYWX9FETu6@MiWiFi-R3L-srv>
 <5232350c-7529-eece-c9cb-8a8bbc83a81a@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5232350c-7529-eece-c9cb-8a8bbc83a81a@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_003116_398330_FD13E148 
X-CRM114-Status: GOOD (  30.59  )
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

On 05/31/23 at 09:16am, Leizhen (ThunderTown) wrote:
> 
> 
> On 2023/5/31 8:13, Baoquan He wrote:
> > On 05/27/23 at 08:34pm, Zhen Lei wrote:
> >> If the value of parameter 'new_size' is in the semi-open and semi-closed
> >> interval (crashk_res.end - KEXEC_CRASH_MEM_ALIGN + 1, crashk_res.end], the
> >> calculation result of ram_res is:
> >> 	ram_res->start = crashk_res.end + 1
> >> 	ram_res->end   = crashk_res.end
> > 
> > If the new_size is smaller than KEXEC_CRASH_MEM_ALIGN, does it make
> > any sense except of testing purpose? Do we need to fail this kind of
> > shrinking, or just shrink all the left crash memory?

OK, I misread your log. You are saying the new_size is close to
crashk_res.end but has a tiny difference in your example, I
thought the new_size is smaller than KEXEC_CRASH_MEM_ALIGN which is just
in the opposite direction.

Yea, it does have the possibility to waste a ram_res but does nothing
even though the chance is very small.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> We can't give a fixed value, that is, how much crash memory is reserved to
> ensure that the capture kernel runs. The size of KEXEC_CRASH_MEM_ALIGN is
> only one page on non-s390 platforms. So, it's better to keep the code simple,
> and let the user(administrator) shrink the crash memory reasonably.
> 
> include/linux/kexec.h
> #define KEXEC_CRASH_MEM_ALIGN	PAGE_SIZE

> 
> > 
> >> The operation of function insert_resource() fails, and ram_res is not
> >> added to iomem_resource. As a result, the memory of the control block
> >> ram_res is leaked.
> >>
> >> In fact, on all architectures, the start address and size of crashk_res
> >> are already aligned by KEXEC_CRASH_MEM_ALIGN. Therefore, we do not need to
> >> round up crashk_res.start again. Instead, we should round up 'new_size'
> >> in advance.
> >>
> >> Fixes: 6480e5a09237 ("kdump: add missing RAM resource in crash_shrink_memory()")
> >> Fixes: 06a7f711246b ("kexec: premit reduction of the reserved memory size")
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >> ---
> >>  kernel/kexec_core.c | 5 ++---
> >>  1 file changed, 2 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> >> index 3d578c6fefee385..22acee18195a591 100644
> >> --- a/kernel/kexec_core.c
> >> +++ b/kernel/kexec_core.c
> >> @@ -1122,6 +1122,7 @@ int crash_shrink_memory(unsigned long new_size)
> >>  	start = crashk_res.start;
> >>  	end = crashk_res.end;
> >>  	old_size = (end == 0) ? 0 : end - start + 1;
> >> +	new_size = roundup(new_size, KEXEC_CRASH_MEM_ALIGN);
> >>  	if (new_size >= old_size) {
> >>  		ret = (new_size == old_size) ? 0 : -EINVAL;
> >>  		goto unlock;
> >> @@ -1133,9 +1134,7 @@ int crash_shrink_memory(unsigned long new_size)
> >>  		goto unlock;
> >>  	}
> >>  
> >> -	start = roundup(start, KEXEC_CRASH_MEM_ALIGN);
> >> -	end = roundup(start + new_size, KEXEC_CRASH_MEM_ALIGN);
> >> -
> >> +	end = start + new_size;
> >>  	crash_free_reserved_phys_range(end, crashk_res.end);
> >>  
> >>  	if ((start == end) && (crashk_res.parent != NULL))
> >> -- 
> >> 2.25.1
> >>
> > 
> > .
> > 
> 
> -- 
> Regards,
>   Zhen Lei
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

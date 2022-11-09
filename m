Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9E6C433FE
	for <kexec@archiver.kernel.org>; Wed,  9 Nov 2022 01:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q8lyrFzYNRz+cYiuqeT8D+ZJU/igxz91nfX6Xqg+Fd4=; b=1sAPgzidE+E9Gg
	koVb3KGs8DNygRua5B/WvGoXs5K7m6DGruEMyJKnM3nX/Eb7u+wSubwdVHR6WkiFtcnSE4ZVWFrWb
	ntLpWLvSILZZJNBTvmP6/WiemL15R6iWFFszKzJSBsS8ml/HKWKqiFTakrI2ykwgP+Mj816IG2aeM
	1YSkMEQ0sJ8xyl+vOJHrnis6lfv2RxmyPeuOzUQE615qwHFfEJ/s4JaTSRs/xZ1KxuiXtK0+ltH0g
	dSJQNhzLGuVmNVBfwPPvk1wEfFvWz7qYpTGzZYtQEFiBnwr7SaweAZ0E0wPccyQw1noO9QUoroYZn
	phs7E8kEChLv+CflPPyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osZW5-009Wib-S9; Wed, 09 Nov 2022 01:04:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osZVz-009Whu-Ez
	for kexec@lists.infradead.org; Wed, 09 Nov 2022 01:04:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1667955866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eZkmt97VpqvS5xcPVLVRJGY6/QQzPHRetf9QxFFBydg=;
	b=gcSxPhHslI6u4Vvj6433avj+cKzz0JRrX6J2ai0PWGbau+iwAajnWRH5951+umt5K7cpOC
	ufWuwN31QIwuOY90qey52TvyVphlOYZKOecmLYdwMqYG1B3OHiBSjDgAsxhlL2NHgXZPvT
	3wOI66shuIBOevPBEfmqLTiIAaKoj6I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-NK3vfayPPYianvDJCSSdgg-1; Tue, 08 Nov 2022 20:04:24 -0500
X-MC-Unique: NK3vfayPPYianvDJCSSdgg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E209185A7AA;
	Wed,  9 Nov 2022 01:04:20 +0000 (UTC)
Received: from localhost (ovpn-12-86.pek2.redhat.com [10.72.12.86])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BAC114B3FC6;
	Wed,  9 Nov 2022 01:04:19 +0000 (UTC)
Date: Wed, 9 Nov 2022 09:04:16 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>,
	Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] vmcoreinfo: Warn if we exceed vmcoreinfo data size
Message-ID: <Y2r8kFZVZP1ou1qZ@MiWiFi-R3L-srv>
References: <20221027205008.312534-1-stephen.s.brennan@oracle.com>
 <20221108154846.11584119794413c7682280fc@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221108154846.11584119794413c7682280fc@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_170427_600133_3B451C3C 
X-CRM114-Status: GOOD (  23.85  )
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

On 11/08/22 at 03:48pm, Andrew Morton wrote:
> On Thu, 27 Oct 2022 13:50:08 -0700 Stephen Brennan <stephen.s.brennan@oracle.com> wrote:
> 
> > Though vmcoreinfo is intended to be small, at just one page, useful
> > information is still added to it, so we risk running out of space.
> > Currently there is no runtime check to see whether the vmcoreinfo buffer
> > has been exhausted. Add a warning for this case.
> > 
> > Currently, my static checking tool[1] indicates that a good upper bound
> > for vmcoreinfo size is currently 3415 bytes, but the best time to add
> > warnings is before the risk becomes too high.
> > 
> > ...
> >
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -383,6 +383,9 @@ void vmcoreinfo_append_str(const char *fmt, ...)
> >  	memcpy(&vmcoreinfo_data[vmcoreinfo_size], buf, r);
> >  
> >  	vmcoreinfo_size += r;
> > +
> > +	WARN_ONCE(vmcoreinfo_size == VMCOREINFO_BYTES,
> > +		  "vmcoreinfo data exceeds allocated size, truncating");
> >  }
> 
> Seems that vmcoreinfo_append_str() will truncate (ie: corrupt) the
> final entry when limiting the overall data size to VMCOREINFO_BYTES. 
> And that final entry will be missing any terminating \n or \0.
> 
> Is all this desirable, or should we be checking for (and warning about)
> sufficient space _before_ appending this string?


Hmm, once we really reach that point, truncated vmcoreinfo should not be
useful for later vmcore dumping and analyzing. As we can see, the
arch_crash_save_vmcoreinfo() is called at the end of
crash_save_vmcoreinfo_init(). E.g on x86_64, the phys_base,
init_top_pgt, etc are very important for memory layout analyzing.
Fortunatly this insufficient vmcoreinfo page won't impact the normal
kernel running.

So, the current change looks good to me.

My further thinking is if we should print the truncated or first skipped
entry in the warning so that people know better what's happening, even
though whatever we will do is to increase one page for vmcoreinfo buffer.
Not strong opinion though.


diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index a0eb4d5cf557..8ba4dd90694d 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -383,6 +383,9 @@ void vmcoreinfo_append_str(const char *fmt, ...)
 	memcpy(&vmcoreinfo_data[vmcoreinfo_size], buf, r);
 
 	vmcoreinfo_size += r;
+
+	WARN_ONCE(vmcoreinfo_size == VMCOREINFO_BYTES,
+		  "vmcoreinfo data exceeds allocated size when adding: %s\n", buf);
 }
 
 /*


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

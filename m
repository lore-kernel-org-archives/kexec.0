Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6770CA0FE1
	for <kexec@archiver.kernel.org>; Fri,  1 Sep 2023 09:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R/cfDnnghFvL2VKeoknpecGeNml3teX9HnRfMr6mACY=; b=i8vNpcN0WVi7yT
	DpItvsVSK5z1OdDF1APnvlVQUwOef/Wj8tz7Zym16Cohsl8uxP6bPETB1o3HjRiY0emPupbdaqyEx
	HwZ1eEhGXVv3YgQ1qKomFPJgjRCZUlkHbdMZ9i5ETVydc063jvDFrom7nVxcnW/9jVEkeEiP3fy+4
	v98vp8jjbDBK8IvRU/zItAldlbm213oXTf24+cuPr+ZpzMuYv9k9Tt5q1q/FMC/x1H7A5hRezafAv
	YxYRkt8JXKUX01ehc/XIG+toJffMFr6pB7Oxr0HnjG/KhAvVM6ilwp4gCt8BmTG4H2JH4Fe1yKV5U
	vjBgqJQ3yIhqG5bzOgVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qc0mL-00GmRs-0e;
	Fri, 01 Sep 2023 09:49:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qc0mI-00GmQO-1E
	for kexec@lists.infradead.org;
	Fri, 01 Sep 2023 09:49:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693561757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bcExDhghP5q2uMrkxwwq4cXddfl7pnt3QkGDEdgHPBI=;
	b=F5U8+N2Xt5pqZ4WWaPWLnG0inevpczz8T60tOnSRdDWKnexeasyyPVICpoBWvIyezeGAq4
	bqoTRD7o3HO/naKNDvwrGa2NKztqXxW09+Q7DK4MVn1LC2S8O/f+Sqff8vlz05WbCzUd8R
	jO6lMG07MRbd0psB4fw5+o5vXngy11c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-94-dqSyZhw4NUq7agicu0a-mg-1; Fri, 01 Sep 2023 05:49:12 -0400
X-MC-Unique: dqSyZhw4NUq7agicu0a-mg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 518D23C17126;
	Fri,  1 Sep 2023 09:49:12 +0000 (UTC)
Received: from localhost (unknown [10.72.113.156])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 70A1540C6F4C;
	Fri,  1 Sep 2023 09:49:11 +0000 (UTC)
Date: Fri, 1 Sep 2023 17:49:08 +0800
From: Baoquan He <bhe@redhat.com>
To: "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	catalin.marinas@arm.com, thunder.leizhen@huawei.com,
	dyoung@redhat.com, prudo@redhat.com, samuel.holland@sifive.com,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	x86@kernel.org
Subject: Re: [PATCH v2 3/8] crash_core: change parse_crashkernel() to support
 crashkernel=,high|low parsing
Message-ID: <ZPGzlIkXqVThTwjg@MiWiFi-R3L-srv>
References: <20230829121610.138107-1-bhe@redhat.com>
 <20230829121610.138107-4-bhe@redhat.com>
 <c4a1f96e-2c8d-a496-61f3-0299d77c5c84@huaweicloud.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c4a1f96e-2c8d-a496-61f3-0299d77c5c84@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230901_024922_503975_FF6A5E71 
X-CRM114-Status: GOOD (  33.57  )
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

On 08/31/23 at 10:56am, Leizhen (ThunderTown) wrote:
> 
> 
> On 2023/8/29 20:16, Baoquan He wrote:
> > Now parse_crashkernel() is a real entry point for all kinds of
> > crahskernel parsing on any architecture.
> > 
> > And wrap the crahskernel=,high|low handling inside
> > CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION ifdeffery scope.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  include/linux/crash_core.h |  6 ++++++
> >  kernel/crash_core.c        | 28 +++++++++++++++++++++++++++-
> >  2 files changed, 33 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> > index 2e76289699ff..85260bf4a734 100644
> > --- a/include/linux/crash_core.h
> > +++ b/include/linux/crash_core.h
> > @@ -77,6 +77,12 @@ Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
> >  			  void *data, size_t data_len);
> >  void final_note(Elf_Word *buf);
> >  
> > +#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> > +#ifndef DEFAULT_CRASH_KERNEL_LOW_SIZE
> > +#define DEFAULT_CRASH_KERNEL_LOW_SIZE  (128UL << 20)
> > +#endif
> > +#endif
> > +
> >  int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
> >  		unsigned long long *crash_size, unsigned long long *crash_base,
> >  		unsigned long long *low_size, bool *high);
> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > index f6a5c219e2e1..355b0ab5189c 100644
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -276,6 +276,9 @@ static int __init __parse_crashkernel(char *cmdline,
> >  /*
> >   * That function is the entry point for command line parsing and should be
> >   * called from the arch-specific code.
> > + *
> > + * If crashkernel=,high|low is supported on architecture, non-NULL values
> > + * should be passed to parameters 'low_size' and 'high'.
> >   */
> >  int __init parse_crashkernel(char *cmdline,
> >  			     unsigned long long system_ram,
> > @@ -291,7 +294,30 @@ int __init parse_crashkernel(char *cmdline,
> >  				crash_base, NULL);
> >  	if (!high)
> >  		return ret;
> > -
> > +#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> > +	else if (ret == -ENOENT) {
> > +		ret = __parse_crashkernel(cmdline, 0, crash_size,
> > +				crash_base, suffix_tbl[SUFFIX_HIGH]);
> > +		if (ret || !*crash_size)
> > +			return -1;
> 
> Change -1 to -EINVAL?

Thanks a lot for careful reviewing, Zhen Lei.

Here, it's fine to me, parse_crashkernel() returns 0 on success, other value
on failure. '-1' or '-EINVAL' is not different to me in this case. I can
update if you think '-EINVAL' is better.

> 
> > +
> > +		/*
> > +		 * crashkernel=Y,low can be specified or not, but invalid value
> > +		 * is not allowed.
> > +		 */
> > +		ret = __parse_crashkernel(cmdline, 0, low_size,
> > +				crash_base, suffix_tbl[SUFFIX_LOW]);
> > +		if (ret == -ENOENT)
> > +			*low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> > +		else if (ret)
> > +			return -1;
> 
> return ret;

Ditto.

> 
> > +
> > +		*high = true;
> > +	} else if (ret || !*crash_size) {
> 
> This check can be moved outside of #ifdef. Because even '!high', it's completely
> applicable. The overall adjustment is as follows:

Hmm, the current logic is much easier to understand. However, I may not
100% get your suggestion. Can you paste the complete code in your
suggested way? Do not need 100% correct code, just the skeleton of code logic
so that I can better understand it and add inline comment.

> 
> -  	if (!high)
> -  		return ret;
> 
> #ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> 	if (high && ret == -ENOENT) {
> 		... ...
> 		if (ret || !*crash_size)	//parse HIGH
> 		... ...
> 	}
> 
> 	//At this point, *crash_size is not 0 and ret is 0.
> 	//We can also delete if (!*crash_size) above because it will be checked later.
> #endif
> 
> 	if (!*crash_size)
> 		ret = -EINVAL;
> 
> 	return ret;

When crashkernel=,high is specified while crashkernel=,low is omitted,
the ret==-ENOENT, but we can't return ret directly. That is still an
acceptable way.

> 
> -  	return 0;
> 
> > +		/* The specified value is invalid */
> > +		return -1;
> > +	}
> > +#endif
> >  	return 0;
> >  }
> >  
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

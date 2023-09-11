Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB230EE7FF4
	for <kexec@archiver.kernel.org>; Mon, 11 Sep 2023 10:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z7OulugWIsWrwPaJ5z28rXkTvj7AWBHFuqrCPjnKvV4=; b=Rn+U2+ns0N2ujL
	V+t1bJr5mbByo23OLpBX1RvblRTFRdxfXopvtxyLp5RdNnOE/+ICDibHw718cyprXOHP4FJzVGb6H
	hr9+W3yvAbpxV9W7xlIyoQ9JS3370ACL/nsmzZ0h/RKpv6q7jiMssEmpZ+miqhYZWU+3KFNqrmhlD
	TmD4ikdRXW3hwdwGsU/+gf6kJyHUWdDcFtAa6J9/p9YG3GGzXhgj6nvVSHU4DcjaYQ3Sc/huTKLS7
	h5Yn+iQcJiYnLCad0K7XkhHwBQ6+jYwO3M0Zaj7oY0kwDgvHe9unDhQ2WBLvRzSY4hHdYL/mnbimo
	AoLT45PUutnfbf/IcOGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfeCu-000DfP-19;
	Mon, 11 Sep 2023 10:31:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfeCr-000Dcx-1b
	for kexec@lists.infradead.org;
	Mon, 11 Sep 2023 10:31:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694428308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=scL+PN7rvFW0rRtuvyrop8LP1MAlxFU5fgMf6KSanRA=;
	b=PtnrUy/RT/Ry654TiqlfuZ+dkS0/197mKmSvLNZK1QMLpLsR07wFpE3oIjovdTyxR44yzt
	JpVzPvoF5RPNrrcmmy2DG/eruXposjMKxI9EXD0C3d7K7sZvDsLIXR1w7NU637RnWwdfrI
	sSFV1iJ8GVl9qaDLwTUXdLA1toP4IZw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-bOa0vEtiPUa0zpz8zjb7vQ-1; Mon, 11 Sep 2023 06:31:44 -0400
X-MC-Unique: bOa0vEtiPUa0zpz8zjb7vQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 662A5382254A;
	Mon, 11 Sep 2023 10:31:44 +0000 (UTC)
Received: from localhost (unknown [10.72.112.35])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FB1F40C200A;
	Mon, 11 Sep 2023 10:31:42 +0000 (UTC)
Date: Mon, 11 Sep 2023 18:31:39 +0800
From: Baoquan He <bhe@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Hari Bathini <hbathini@linux.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Kexec-ml <kexec@lists.infradead.org>,
	Dave Young <dyoung@redhat.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v2 2/3] vmcore: allow fadump to export vmcore even if
 is_kdump_kernel() is false
Message-ID: <ZP7si3UMVpPfYV+w@MiWiFi-R3L-srv>
References: <20230905183604.568996-1-hbathini@linux.ibm.com>
 <20230905183604.568996-2-hbathini@linux.ibm.com>
 <8734zltc6z.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8734zltc6z.fsf@mail.lhotse>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_033149_604416_867B93BC 
X-CRM114-Status: GOOD (  28.74  )
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

On 09/11/23 at 05:13pm, Michael Ellerman wrote:
> Hari Bathini <hbathini@linux.ibm.com> writes:
> > Currently, is_kdump_kernel() returns true when elfcorehdr_addr is set.
> > While elfcorehdr_addr is set for kexec based kernel dump mechanism,
> > alternate dump capturing methods like fadump [1] also set it to export
> > the vmcore. Since, is_kdump_kernel() is used to restrict resources in
> > crash dump capture kernel and such restrictions are not desirable for
> > fadump, allow is_kdump_kernel() to be defined differently for fadump
> > case. With that change, include is_fadump_active() check in functions
> > is_vmcore_usable() & vmcore_unusable() to be able to export vmcore for
> > fadump case too.
> ...
> > diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
> > index 0f3a656293b0..de8a9fabfb6f 100644
> > --- a/include/linux/crash_dump.h
> > +++ b/include/linux/crash_dump.h
> > @@ -50,6 +50,7 @@ void vmcore_cleanup(void);
> >  #define vmcore_elf64_check_arch(x) (elf_check_arch(x) || vmcore_elf_check_arch_cross(x))
> >  #endif
> >  
> > +#ifndef is_kdump_kernel
> >  /*
> >   * is_kdump_kernel() checks whether this kernel is booting after a panic of
> >   * previous kernel or not. This is determined by checking if previous kernel
> > @@ -64,6 +65,19 @@ static inline bool is_kdump_kernel(void)
> >  {
> >  	return elfcorehdr_addr != ELFCORE_ADDR_MAX;
> >  }
> > +#endif
> > +
> > +#ifndef is_fadump_active
> > +/*
> > + * If f/w assisted dump capturing mechanism (fadump), instead of kexec based
> > + * dump capturing mechanism (kdump) is exporting the vmcore, then this function
> > + * will be defined in arch specific code to return true, when appropriate.
> > + */
> > +static inline bool is_fadump_active(void)
> > +{
> > +	return false;
> > +}
> > +#endif
> >  
> >  /* is_vmcore_usable() checks if the kernel is booting after a panic and
> >   * the vmcore region is usable.
> > @@ -75,7 +89,8 @@ static inline bool is_kdump_kernel(void)
> >  
> >  static inline int is_vmcore_usable(void)
> >  {
> > -	return is_kdump_kernel() && elfcorehdr_addr != ELFCORE_ADDR_ERR ? 1 : 0;
> > +	return (is_kdump_kernel() || is_fadump_active())
> > +		&& elfcorehdr_addr != ELFCORE_ADDR_ERR ? 1 : 0;
> >  }
> >  
> >  /* vmcore_unusable() marks the vmcore as unusable,
> > @@ -84,7 +99,7 @@ static inline int is_vmcore_usable(void)
> >  
> >  static inline void vmcore_unusable(void)
> >  {
> > -	if (is_kdump_kernel())
> > +	if (is_kdump_kernel() || is_fadump_active())
> >  		elfcorehdr_addr = ELFCORE_ADDR_ERR;
> >  }
> 
> I think it would be cleaner to decouple is_vmcore_usable() and
> vmcore_usable() from is_kdump_kernel().
> 
> ie, make them operate solely based on the value of elforehdr_addr:
> 
> static inline int is_vmcore_usable(void)
> {
> 	elfcorehdr_addr != ELFCORE_ADDR_ERR && \
> 		elfcorehdr_addr != ELFCORE_ADDR_MAX;

Agree. I fell into the blind corner of thinking earlier. Above change
is better.

> }
> 
> static inline void vmcore_unusable(void)
> {
> 	elfcorehdr_addr = ELFCORE_ADDR_ERR;
> }
> 
> 
> Then all we need on powerpc is a way to override is_kdump_kernel().
> 
> cheers
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

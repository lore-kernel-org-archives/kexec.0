Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE8EE6FE2B
	for <kexec@archiver.kernel.org>; Fri,  6 Sep 2024 15:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tTe9SgwWRGgoXnwJZVhGegxX6QYef3CvDWiVPvynmyY=; b=FS+QeuXFwUajE6
	x7ZbkwYqD/f/EtTHpd3A6ex+JAp1ExHhN+VrRL7olIm6gwLLkkPmpL/b+40dFUhItv+EdTSYqjBxu
	XXBI36LmpTTewIi9XmbZRrqdz+TVi7XtKF/yVtw4TOub9LSmI5qFEny+tkJuZyJYXNekB+JS71l0w
	jMsNaZdcrSehmtO0ixIpuK7eZpDxEdmh/Y3DOMTtMVpToNH6f36EaMRczJMFA5mqDOoyVzpZGlv5g
	9SRfvn8jjarudQkXs364Byj82Hlvh7XcDuqiiZrU6d5+wf6sO/qNfioMv3UqS2LT+MDAZCw/zVixA
	jckcg+0XhI3UG7DqeKew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smapp-0000000Cl58-2jS0;
	Fri, 06 Sep 2024 15:25:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smadP-0000000CiUP-1OzR
	for kexec@lists.infradead.org;
	Fri, 06 Sep 2024 15:12:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725635546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IaED0rfT7hp/guMNdzwjFCAkdhigHeJsVEwtYNenMDg=;
	b=XOkkGSGoz2g9pzQWFI5duZsPAZOHQSuyOfpjQu8mlMTpiUJDJjYoVt+sTl5u9CVuF77eRm
	TdHTm230J/Wvib3ehLYgSfxpo57ObmQS1EAzQ1gx9ofrKB0mzI5K+3hyJmW7/sx8tI5ULh
	tippewQdd7iixLS5isCzhzy+uKkAvGE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-I2FF9BmbMRiyi1wTHOn4Tw-1; Fri,
 06 Sep 2024 11:12:23 -0400
X-MC-Unique: I2FF9BmbMRiyi1wTHOn4Tw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 917551955DDC;
	Fri,  6 Sep 2024 15:12:21 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.193.186])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6B04619560AA;
	Fri,  6 Sep 2024 15:12:18 +0000 (UTC)
Date: Fri, 6 Sep 2024 17:12:14 +0200
From: Philipp Rudo <prudo@redhat.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Masamitsu Yamazaki <yamazaki-msmt@nec.com>, Kazuhito Hagio
 <k-hagio-ab@nec.com>, kexec@lists.infradead.org
Subject: Re: [RFA] makedumpfile: fix access to os_info for /proc/kcore
Message-ID: <20240906171214.116763f7@rotkaeppchen>
In-Reply-To: <ZtsTRgzbnFZhkNmV@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240904181259.1bb5483e@rotkaeppchen>
	<ZtsTRgzbnFZhkNmV@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Organization: Red Hat inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240906_081227_480453_D0067A4F 
X-CRM114-Status: GOOD (  32.19  )
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

Hi Alex,

On Fri, 6 Sep 2024 16:35:50 +0200
Alexander Gordeev <agordeev@linux.ibm.com> wrote:

> On Wed, Sep 04, 2024 at 06:12:59PM +0200, Philipp Rudo wrote:
> 
> Hi Philipp,
> 
> > Hi Alex,
> > 
> > our QE found a problem when trying to run makedumpfile with /proc/kcore
> > on s390. For example
> > 
> > 	# makedumpfile --mem-usage /proc/kcore
> > 	s390x_init_vm: Can't get s390x os_info ptr.
> > 
> > The exact options passed to makedumpfile don't matter. The error is
> > always the same. Trying the same on a dump file created from
> > /proc/vmcore works fine. As the function in question was introduced
> > with you commit 6f8325d ("[PATCH v2 2/2] s390x: uncouple virtual and
> > physical address spaces") I'm reaching out to you.
> > 
> > Looking at /proc/kcore with crash I noticed that
> > abs_lowcore->os_info (aka. address 0xe18) is zero. Hence the check
> > 
> > 	if (!readmem(PADDR, S390X_LC_OS_INFO, &addr,
> > 			sizeof(addr)) || !addr) {
> > 		ERRMSG("Can't get s390x os_info ptr.\n");
> > 		return FALSE;
> > 	}
> > 
> > at the beginning of s390x_init_vm fails. My theory is that when trying
> > to access the absolute lowcore via /proc/kcore the read gets prefixed
> > and thus ends up in the per-cpu lowcore. As the os_info field isn't set
> > in the per-cpu lowcore the read returns 0, triggering the error.  
> 
> Yes, I think your analysis is correct.

\o/ I haven't lost all my s390 skills, yet.

> > I played around with crash trying to access the absolute lowcore via
> > __abs_lowcore and lowcore_ptr but failed. I always ended up in the
> > per-cpu lowcore. I also tried to get the address of os_info from the
> > dwarf information but that only returnes a virtual address which cannot
> > be used in the function that sets up vm...
> > 
> > Any idea how this problem could be fixed?  
> 
> I will take a deeper look at it.

Thanks!

> 
> > Thanks
> > Philipp  
> 
> Thanks for reporting!
> 
> > P.S. While looking at the function I found one nit. Right after the
> > check mentioned above there's an other check for
> > 
> > 	if (addr == 0)
> > 		return TRUE;
> > 
> > which can never be true as the !addr from above already handles this
> > case.  
> 
> It will be TRUE when readmem() succeeded and read out zero.
> In fact, || !addr condition is redundant. Do you want to send a patch?

Could you take over the patch? I'm not really sure, when addr == 0 is
expected. You are much more qualified to describe that.

Thanks
Philipp
expected. 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

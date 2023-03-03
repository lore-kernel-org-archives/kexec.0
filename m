Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C140C678D4
	for <kexec@archiver.kernel.org>; Fri,  3 Mar 2023 11:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PDQQ+rve1Ze7/UOTjlJ9wcnpFK18qiZMcBuZE3iHlA8=; b=Q8/fdFyO0ac3Ap
	JOsj0COAC4ROatJjjmb1n0HeJGZDPloP9SQsafpRY3C5RTm3Y5G7fVetpsAxmzkNmH83HGUgEWzfk
	iO78fV6lu6BlZ6j7cihsU6f2JlDFOdNnS/UnL0wesKOruu6aCJCZJM3XV31jC6vkDak6M8nOoyX6d
	4cuhFfKndaSwRnsddsVpkdrqC4YN1YL9qjPJUUQHY2rPBvS30RlLIEMoLcnvTrlXzatSK2csrcVSa
	cu54ILRbDsLXrKHqLmB/+YI6OzNc3CYjI/RZO2ts6IT9vfaobHC/o5bTLvcaHmYhvc0UTG0m941D6
	ISy4yJee3Z78cUW4oR+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pY3CH-00666c-4Y; Fri, 03 Mar 2023 11:03:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pY3CB-00665b-JW
	for kexec@lists.infradead.org; Fri, 03 Mar 2023 11:03:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677841405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cJOxOJVWERaNpomrLjL676wO2qHrDTxWkRfv67eXvdg=;
	b=M0KruDyFLkPrarFrE4ipTPReBtZmesaqvCRs7UyIRWrAjcU9/gFEgWzmb9IYQKHBXDTrGA
	8o4CUQhjmtbv1rFFtc/IrguWOqQdWhJ1SzFbd1NLRJe53zIaXjNGzMf/48OiBc+sy4pbPt
	5QaZQlD66sn+twfatATQA1VjjZ6zoWA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286-ms2hKProMgSFjxPcENEo5Q-1; Fri, 03 Mar 2023 06:03:22 -0500
X-MC-Unique: ms2hKProMgSFjxPcENEo5Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 31660882822;
	Fri,  3 Mar 2023 11:03:22 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.195.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6FC3E40C6EC4;
	Fri,  3 Mar 2023 11:03:21 +0000 (UTC)
Date: Fri, 3 Mar 2023 12:03:19 +0100
From: Philipp Rudo <prudo@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: Youling Tang <tangyouling@loongson.cn>, Simon Horman <horms@kernel.org>,
 kexec@lists.infradead.org
Subject: Re: [PATCH 1/2] kexec: Default __NR_kexec_file_load is set to
 undefined
Message-ID: <20230303120319.67307b61@rotkaeppchen>
In-Reply-To: <Y/4CaolPP0U4h6bB@MiWiFi-R3L-srv>
References: <1677232268-2451-1-git-send-email-tangyouling@loongson.cn>
	<20230227161919.7c4884cd@rotkaeppchen>
	<Y/4CaolPP0U4h6bB@MiWiFi-R3L-srv>
Organization: Red Hat inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230303_030327_767901_A4B91E55 
X-CRM114-Status: GOOD (  24.14  )
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

Hi Baoquan,

On Tue, 28 Feb 2023 21:32:26 +0800
Baoquan He <bhe@redhat.com> wrote:

> Hi Philipp,
> 
> On 02/27/23 at 04:19pm, Philipp Rudo wrote:
> ...... 
> > > diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
> > > index be6ccd5..ea77936 100644
> > > --- a/kexec/kexec-syscall.h
> > > +++ b/kexec/kexec-syscall.h
> > > @@ -59,9 +59,7 @@
> > >  #endif
> > >  #endif /*ifndef __NR_kexec_load*/
> > >  
> > > -#ifdef __arm__
> > >  #undef __NR_kexec_file_load
> > > -#endif
> > >  
> > >  #ifndef __NR_kexec_file_load  
> > 
> > I don't think this will work as intended. 
> > 
> > On the top of the file sys/syscall.h gets included. In there
> > architectures that support kexec_file_load define __NR_kexec_file_load.
> > This also means that if an architecture doesn't support kexec_file_load
> > __NR_kexec_file_load shouldn't be defined in the first place. Thus I
> > suggest that you find out why sys/syscall.h defines
> > __NR_kexec_file_load for LoongArch even when the system call is not
> > supported and fix it there.  
> 
> Checking whether LoongArch has defined __NR_kexec_file_load sounds a
> good suggestion. Wondering why we still need add __NR_kexec_file_load
> definition in kexec-tools. E.g below s390 kexec_file support you added.
> <sys/syscall.h> sometime won't be found or __NR_kexec_file_load could be
> not defined yet?
> 
> commit d4a948c268272cf37c71be820fb02bf40e56292b
> Author: Philipp Rudo <prudo@linux.ibm.com>
> Date:   Wed May 16 14:27:18 2018 +0200
> 
>     kexec/s390: Add support for kexec_file_load
> 

To be honest I don't remember why I have added it back then. Most
likely I simply copied what others have done before.

The benefit in having the extra definition I see is that you don't need
to rebuild glibc when you implement the syscall and don't use the
generic unistd.h. But that is something only few people should ever
encounter.

Thanks
Philipp


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

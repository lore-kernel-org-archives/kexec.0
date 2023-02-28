Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BC4C64EC7
	for <kexec@archiver.kernel.org>; Tue, 28 Feb 2023 13:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aEQv1ggOGEInDUoUJRPU04Bdn6IQiQtLUXGmErKWlfE=; b=4ZQsJ5cgmYknjN
	vyeIF4DNXUfVXup/oWsf80cEWccEjqraDjjvhSpaEhvCyiERZ5pV5B32vWAYB5bVbqw2Pr87MSx0O
	DoVzH0SalhVGU5E5+9YfhCR2bx43PyK00bDoChDCRt9TRxnOW4aSVwgLMU0wBfXpmq5a0rlZCK7jf
	Bk0HTooVg3mTxUzST0waEjKetfpFvdOIDHJpfOQcl3jZ3qHYZ3JS2WTFO99rqWanF1IQS5w5dQHqR
	1kgPiH56kIebgCSPWnIEbD6DEzIVcy2Asg0z5AYG+mXTc/zsA/qLM88OqOz68xyebBy30ZGRe42Z0
	ntnko27wz8UVvzHpdcCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pX05v-00DIa9-GM; Tue, 28 Feb 2023 13:32:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pX05t-00DIZU-5Q
	for kexec@lists.infradead.org; Tue, 28 Feb 2023 13:32:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677591155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yd9PK9Z45cRctfXmIRpsrDOFqbDF59rDyQpubjdFEB0=;
	b=ZzKpGAUAa7y4jfmauMI6VxeRzX9wcmB5tZokXwV/GFezvPQ5d8AkpBuKdb6PwYTjCevWFY
	RqIUJlqhkQrAjRoQjS1DwAQgrLHr5GfK+jo+nJV+DCMXKLUnNbKPaewXcfgs+cAc7flUHL
	rur+y5q+/J0faxyxuOwXTDZKNYtx+eE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-OjDFL2Y7My6pla9d1iYGkg-1; Tue, 28 Feb 2023 08:32:32 -0500
X-MC-Unique: OjDFL2Y7My6pla9d1iYGkg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AD78380671C;
	Tue, 28 Feb 2023 13:32:32 +0000 (UTC)
Received: from localhost (ovpn-13-194.pek2.redhat.com [10.72.13.194])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 460FD1415117;
	Tue, 28 Feb 2023 13:32:29 +0000 (UTC)
Date: Tue, 28 Feb 2023 21:32:26 +0800
From: Baoquan He <bhe@redhat.com>
To: Philipp Rudo <prudo@redhat.com>
Cc: Youling Tang <tangyouling@loongson.cn>, Simon Horman <horms@kernel.org>,
	kexec@lists.infradead.org
Subject: Re: [PATCH 1/2] kexec: Default __NR_kexec_file_load is set to
 undefined
Message-ID: <Y/4CaolPP0U4h6bB@MiWiFi-R3L-srv>
References: <1677232268-2451-1-git-send-email-tangyouling@loongson.cn>
 <20230227161919.7c4884cd@rotkaeppchen>
MIME-Version: 1.0
In-Reply-To: <20230227161919.7c4884cd@rotkaeppchen>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230228_053237_298596_FBEFEBC3 
X-CRM114-Status: GOOD (  17.93  )
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

Hi Philipp,

On 02/27/23 at 04:19pm, Philipp Rudo wrote:
...... 
> > diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
> > index be6ccd5..ea77936 100644
> > --- a/kexec/kexec-syscall.h
> > +++ b/kexec/kexec-syscall.h
> > @@ -59,9 +59,7 @@
> >  #endif
> >  #endif /*ifndef __NR_kexec_load*/
> >  
> > -#ifdef __arm__
> >  #undef __NR_kexec_file_load
> > -#endif
> >  
> >  #ifndef __NR_kexec_file_load
> 
> I don't think this will work as intended. 
> 
> On the top of the file sys/syscall.h gets included. In there
> architectures that support kexec_file_load define __NR_kexec_file_load.
> This also means that if an architecture doesn't support kexec_file_load
> __NR_kexec_file_load shouldn't be defined in the first place. Thus I
> suggest that you find out why sys/syscall.h defines
> __NR_kexec_file_load for LoongArch even when the system call is not
> supported and fix it there.

Checking whether LoongArch has defined __NR_kexec_file_load sounds a
good suggestion. Wondering why we still need add __NR_kexec_file_load
definition in kexec-tools. E.g below s390 kexec_file support you added.
<sys/syscall.h> sometime won't be found or __NR_kexec_file_load could be
not defined yet?

commit d4a948c268272cf37c71be820fb02bf40e56292b
Author: Philipp Rudo <prudo@linux.ibm.com>
Date:   Wed May 16 14:27:18 2018 +0200

    kexec/s390: Add support for kexec_file_load


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

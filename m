Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEB4C433FE
	for <kexec@archiver.kernel.org>; Fri, 25 Nov 2022 07:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sTo6vMnd/W6kFO86Fr6SDp4QvCr08qBpg9kF9cmlzEM=; b=FKgIiYkptzEEoR
	sLHilOwU9E5d9y7ZWDXm21wUVdmD65Dz9kB9xVKBWvFQZcBR/AEnf/g4n5gThsTKf3MEzu+c8Uhuh
	nu7MVQYD7h9vVdhXnA3OWOuf6fYqcwkY9Ng81R0icCt8HGkHIS1XM8cn5AxoRUeiSxe+U/LvShJTQ
	EyntxwEfqHzcnrv/ong7U/xP3q1yZEIsTyZGpdO1znkq8N5+zK7w+hLD6YESOBKTKiAo8faZuzOLM
	opAZzlr32KWcfTf62/Exun+dOod9IJA99itffSykAoqxsh6kKUqBJPIogFysmU1NNJYtfy9UahA2A
	CoEp7JQymjIVSoqiRcxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oyT7u-00E4Q1-23; Fri, 25 Nov 2022 07:27:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oyT7r-00E4NX-8Q
	for kexec@lists.infradead.org; Fri, 25 Nov 2022 07:27:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669361271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Or7i4dKnedRAsO/2QFJniL+oZldKo89g5PbGYo46z1g=;
	b=X+5RFDtkL1DDhzxTesDVskT0bvDX6I0a25K5eMrA5eBMtJ+9NmjqjFpXv3PjOA1emz7FP0
	sYR4355rUaR7+zRrXrDL+PVAMd1hMCwqgz65jG3jdLxEYEY8g5QCsj5qXgG4kDX2VyNRK6
	+F/CBwHeJ3d67+4QBixlH+CtxJkg1vw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-MXX8RZuaNa--9zDbsU2MtA-1; Fri, 25 Nov 2022 02:27:46 -0500
X-MC-Unique: MXX8RZuaNa--9zDbsU2MtA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 936F53C0F7E7;
	Fri, 25 Nov 2022 07:27:45 +0000 (UTC)
Received: from localhost (ovpn-12-208.pek2.redhat.com [10.72.12.208])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B9DD82028E94;
	Fri, 25 Nov 2022 07:27:44 +0000 (UTC)
Date: Fri, 25 Nov 2022 15:27:40 +0800
From: Baoquan He <bhe@redhat.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Eric Biederman <ebiederm@xmission.com>, Philipp Rudo <prudo@redhat.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Ross Zwisler <zwisler@kernel.org>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: Enable runtime allocation of crash_image
Message-ID: <Y4BubEVKt78k8xaC@MiWiFi-R3L-srv>
References: <20221124-kexec-noalloc-v1-0-d78361e99aec@chromium.org>
 <Y4AvTEZiNXfFU1Wv@MiWiFi-R3L-srv>
 <CANiDSCsgFYvShoTo9xAPe0wqSJgTnB7ZgzXmNqD+L2cKdsVoRg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANiDSCsgFYvShoTo9xAPe0wqSJgTnB7ZgzXmNqD+L2cKdsVoRg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221124_232755_432094_0862252B 
X-CRM114-Status: GOOD (  23.04  )
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

On 11/25/22 at 06:52am, Ricardo Ribalda wrote:
> Hi Baoquan
> 
> Thanks for your review!
> 
> On Fri, 25 Nov 2022 at 03:58, Baoquan He <bhe@redhat.com> wrote:
> >
> > On 11/24/22 at 11:23pm, Ricardo Ribalda wrote:
> > > Usually crash_image is defined statically via the crashkernel parameter
> > > or DT.
> > >
> > > But if the crash kernel is not used, or is smaller than then
> > > area pre-allocated that memory is wasted.
> > >
> > > Also, if the crash kernel was not defined at bootime, there is no way to
> > > use the crash kernel.
> > >
> > > Enable runtime allocation of the crash_image if the crash_image is not
> > > defined statically. Following the same memory allocation/validation path
> > > that for the reboot kexec kernel.
> >
> > We don't check if the crashkernel memory region is valid in kernel, but
> > we do have done the check in kexec-tools utility. Since both kexec_load and
> > kexec_file_load need go through path of kexec-tools loading, we haven't
> > got problem with lack of the checking in kernel.
> 
> Not sure if I follow you.
> 
> We currently check if the crash kernel is in the right place at
> sanity_check_segment_list()
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/kexec_core.c#n239

And it's not checking if crashkernel memory is valid in
sanity_check_segment_list(), right? It's checking if the segments 
are placed correctly.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

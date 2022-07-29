Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A63FC00140
	for <kexec@archiver.kernel.org>; Fri, 29 Jul 2022 01:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DgiUu3trl34TfOJoJNtGf/zPCaqBSRJfLlFo9B02FlU=; b=ADtln0zdi9mvRS
	e22wUqGB8XmifxDdV008Ku0QfOoy0+cSSWm0+/HkfcC4l2dXlaYVL52RIIJESgifD1IC/vBEbgLmW
	YXWJJ0eWzCtD9eGIc5L98aO7Gw0MpclFell0Qoht/ZDPpdS0H5C/s5ZRd3RusTMyz+NPwesfAeYBO
	DtPRP7V6QxxLrDZjfWfJeAzgP/8nIO/EBo2WmpkCH2VPpRY6rOtFXLC+JPtA5G0Z6HP8VWGpdrILm
	JPxrOzzL0Hgw4pMNP6h6pMxWFdPxcpF6fQHD7iICDlkWJ7tchBxhZHzBe+QGis+L31bAm0iPHPOoP
	bwwhgtorTuENiyyc1eSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHEUg-00Gg11-7J; Fri, 29 Jul 2022 01:08:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHEUd-00GfzQ-T0
	for kexec@lists.infradead.org; Fri, 29 Jul 2022 01:08:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1659056918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UjK8WA9LgJeF558MQ4KdA6R8ULeQdKQ4U739a03eHPA=;
	b=HivwTJ8dJ9XE/ctdoOhKx4iU66bX7Gp97cZivvzXcjUTsz4JM3GtE0KLtXj1HRr4XQQFac
	AcEWqDcKscAS8vI+1gQclSQHuNIlBt/idfge7nZztotidfKtE82pJC+/6Q5m348hggUx/p
	BJXS7JXGuVrJPPkBd90zHAcot/rRXMU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-182-KERh3ai6P0WoM82ksuelGw-1; Thu, 28 Jul 2022 21:08:33 -0400
X-MC-Unique: KERh3ai6P0WoM82ksuelGw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39BCA85A588;
	Fri, 29 Jul 2022 01:08:32 +0000 (UTC)
Received: from localhost (ovpn-13-195.pek2.redhat.com [10.72.13.195])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 13655492C3B;
	Fri, 29 Jul 2022 01:08:31 +0000 (UTC)
Date: Fri, 29 Jul 2022 09:08:26 +0800
From: Baoquan He <bhe@redhat.com>
To: Slark Xiao <slark_xiao@163.com>
Cc: David Howells <dhowells@redhat.com>, corbet@lwn.net, vgoyal@redhat.com,
	dyoung@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, jolsa@kernel.org,
	william.gray@linaro.org, peterz@infradead.org, mingo@redhat.com,
	will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
	tglx@linutronix.de, bigeasy@linutronix.de,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-cachefs@redhat.com
Subject: Re: [PATCH v2] docs: Fix typo in comment
Message-ID: <YuMzClsPIl47Ox5/@MiWiFi-R3L-srv>
References: <YtlyDZEsOZHt6tRs@MiWiFi-R3L-srv>
 <20220721015605.20651-1-slark_xiao@163.com>
 <2778505.1658746506@warthog.procyon.org.uk>
 <Yt6bVIoRa0nIvxei@MiWiFi-R3L-srv>
 <55d366e4.486.1823808de32.Coremail.slark_xiao@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55d366e4.486.1823808de32.Coremail.slark_xiao@163.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220728_180844_050178_D2B9C5CD 
X-CRM114-Status: GOOD (  16.89  )
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

On 07/26/22 at 09:04am, Slark Xiao wrote:
> At 2022-07-25 21:32:04, "Baoquan He" <bhe@redhat.com> wrote:
> >On 07/25/22 at 11:55am, David Howells wrote:
> >> Baoquan He <bhe@redhat.com> wrote:
> >> 
> >> > sed -i "s/the the /the /g" `git grep -l "the the "`
> >> 
> >> You might want to clarify the first "the" with a preceding boundary marker.
> >> There are some English words ending in "the" that can be used as verbs, though
> >> I'm not sure you'd find any of them here - clothe for example.
> >
> >Right. I plan to split this big one into patches corresponding to
> >different component as Jonathan suggested, and will consider how to mark
> >the first 'the' as you suggested, and wrap Slark's pathces which
> >includes typo fix of "then the".
> >
> >Thanks
> >Baoquan
> 
> Actually I have committed all changes which were listed in your previous list.
> I committed it one by one and checked if any other typo is included.
> If possible, you can try other double typo issue like "and and " or "or or" or something else.

That's good, I take leave this week to be babysitter, please go ahead to
handle all of them you found out.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

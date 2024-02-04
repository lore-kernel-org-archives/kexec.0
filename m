Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30712C4828F
	for <kexec@archiver.kernel.org>; Sun,  4 Feb 2024 09:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2JQzkZN0f3JZd5olpU/vKeDvxalOiasrqXfTT5DKPvo=; b=FqBPSmEYqIF99F
	p6ILri7N3ZlMneqEAuHMaXzAyQ/E6FLJ/6TfK9+DfkgDVp4Lj1HPI+M7tgNodxf7hQ3gsAezPY6uy
	sUZHCsPOPONWa0spRNqDgBawYO42rB+8rdWOSk27270PidaERy/x+vdmO7ffNS9GAOnrlQNiCTYEc
	NAD2rnSEVkVt8H+0Iai3eH6sjRLbXyMKjkO+3cLRO310AOCLZtRSYHmfCll6dW7aiRdmUU0JmyPTE
	zzVzkea6ANFgT8ah3CggJe4tQCp7ClXtugvD8YwkGbTnIVNZf6IPjBgLOu1CA6x26o9hBmT0O3vJn
	WYHRsUSiIj7+kM1iuG4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWYTA-00000000SZG-04eL;
	Sun, 04 Feb 2024 09:07:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWYT7-00000000SYe-37wF
	for kexec@lists.infradead.org;
	Sun, 04 Feb 2024 09:07:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707037629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yB3iTu3G76TJ6aoK4HUnVWCg5d/mMSXt76kmkvTxWSs=;
	b=OGnwms92rW9ynUd78CdVcOHnaPy0FzIHtMX+/bycws+SkPDZrGxq1gwv8Cp+7NB4lTYlAa
	DaYmRAnCv+Y3T0iMiNxYyMHjuwfT2mpWqy59trFMyCWhRz1uNV7xZMrUO7K6wGT9PnYZwQ
	wuQJO6RKKPZc443qfGgzNIrvI4RmLFo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-E5_hZ9rQMi6iP8BUkMk40A-1; Sun, 04 Feb 2024 04:07:06 -0500
X-MC-Unique: E5_hZ9rQMi6iP8BUkMk40A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59FF18350E1;
	Sun,  4 Feb 2024 09:07:06 +0000 (UTC)
Received: from localhost (unknown [10.72.116.13])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 08E32C15D7E;
	Sun,  4 Feb 2024 09:07:03 +0000 (UTC)
Date: Sun, 4 Feb 2024 17:07:01 +0800
From: Baoquan He <bhe@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: Coiby Xu <coxu@redhat.com>, Michel Lind <salimma@fedoraproject.org>,
	Sergei Trofimovich <slyich@gmail.com>, kexec@lists.infradead.org,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] kexec-tools: purgatory: fix build on `binutils-2.42`
Message-ID: <Zb9TtfGOtstr3aTj@MiWiFi-R3L-srv>
References: <20240131100508.2013016-1-slyich@gmail.com>
 <ZbopWV9qrxMME2hU@MiWiFi-R3L-srv>
 <ok66kbhzu2xczopdsjhjuedt2h3snt3omjc3jlzbs3ujo6ra75@bu3mvwtuveck>
 <ZbxspulHDxpmHs0W@MiWiFi-R3L-srv>
 <20240202085727.GJ530335@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240202085727.GJ530335@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240204_010717_884335_8881403A 
X-CRM114-Status: GOOD (  16.31  )
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

On 02/02/24 at 09:57am, Simon Horman wrote:
> On Fri, Feb 02, 2024 at 12:16:38PM +0800, Baoquan He wrote:
> > On 02/02/24 at 11:01am, Coiby Xu wrote:
> > > Hi,
> > > 
> > > FYI, before this patch, Michel already sent "[PATCH] Fix building on x86_64
> > > with binutils 2.41" to address the same issue. Currently I almost know
> > > nothing about
> > > assembly but Michel's patch seems to be more complete because two more
> > > files are touched.
> > 
> > Thanks for telling, I didn't notice that one. I didn't know these
> > either, leave them to Sergei and Michel to decide what is the
> > appropriate solution.
> 
> Hi,
> 
> I did go ahead and apply Michael's patch.
> Let's follow-up with incremental changes if necessary.

Sounds great, thanks.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

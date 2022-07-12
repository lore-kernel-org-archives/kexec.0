Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884F3C433EF
	for <kexec@archiver.kernel.org>; Tue, 12 Jul 2022 02:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RtZKpXLyg7vg2xJBcm+IOCx9A5FyYDf5NWpKPsp0n6E=; b=NpTmMmM4SPPMCz
	W+LUuaGZNG6MzWUOvy87vUIfdGED1gkhbXa6sN5INGyL10BWksQZ8wIxrlVYLLrl2wI0JdJaJupfs
	aYjLfqEnaFMFHlHtdQFSTqnV0rZ6VPxpp0Bs4U97DqfJrJ7XWGj9krxAfcwtIQGHjTGgkl0v2LRNN
	G7qh4nmZUKvYNWsrPS5Rv5M/5dFE7SFSyiiD4eSHsIP1RQIoAvCfp+IhbXd7XGQ/3QB635XWnaRC6
	H893x9ASBN+wj9nGyIbvDViZoiBDPg8CfqF+zbEYxPR+WYqnzCVJxPLEouvnlX0frZt9Z20KSzpTj
	Rgm+61q1P6FHt2Hha+aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oB5wP-006obG-HK; Tue, 12 Jul 2022 02:48:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oB5wM-006oZz-V1
	for kexec@lists.infradead.org; Tue, 12 Jul 2022 02:48:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1657594076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=12wGSW3GBIcCSvXMpbrL7TAhlYbxIoDoPrgWaf/PtnE=;
	b=XCnEDO/H59F8S+pNzlMdqfgGRbzg9mio1z8ojaHSD5gZBvAOyGw5sZolBCxtxNDfUaLCqJ
	Fl1IKZpnWdLhZhCZenD7H5zaE2Ut3KUk5hxomAIpWgaUpog6HjqbJw14qec0RDpyQylXQd
	GcKZdwHtDxqARVWUxkyXqlP7Okk4wKA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-6piqHaa4OMa_kqmEWLGK-w-1; Mon, 11 Jul 2022 22:47:48 -0400
X-MC-Unique: 6piqHaa4OMa_kqmEWLGK-w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5BCF9803520;
	Tue, 12 Jul 2022 02:47:48 +0000 (UTC)
Received: from localhost (ovpn-12-173.pek2.redhat.com [10.72.12.173])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3857240B40C8;
	Tue, 12 Jul 2022 02:47:46 +0000 (UTC)
Date: Tue, 12 Jul 2022 10:47:43 +0800
From: Baoquan He <bhe@redhat.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: kexec@lists.infradead.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Juri Lelli <jlelli@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	akpm@linux-foundation.org
Subject: Re: [PATCH v4 0/2] kexec, panic: Making crash_kexec() NMI safe
Message-ID: <Yszgzwnk2Y+4ki58@MiWiFi-R3L-srv>
References: <20220630223258.4144112-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220630223258.4144112-1-vschneid@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220711_194759_114288_BD96ABC6 
X-CRM114-Status: GOOD (  17.86  )
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

Hi,

On 06/30/22 at 11:32pm, Valentin Schneider wrote:
> Hi folks,
> 
> Here's ~v3~ v4 where we now completely get rid of kexec_mutex.
> 
> o Patch 1 makes sure all kexec_mutex acquisitions are trylocks. This prevents
>   having to add any while(atomic_cmpxchg()) loops which I'd really hate to see
>   here. If that can't be done then I think we're better off with the combined
>   mutex+atomic var approach.
> o Patch 2 does the mutex -> atomic var switch.

This series looks good, has it been taken into any tree?

Thanks
Baoquan

> 
> Revisions
> =========
> 
> v3 -> v4
> ++++++++
> 
> o Someone forgot to Cc LKML on v3...
> 
> v2 -> v3
> ++++++++
> 
> o Dropped kexec_mutex entirely and made the atomic variable the one true lock
>   for kexec (Eric)
> 
> v1 -> v2
> ++++++++
> 
> o Changed from Peterson-like synchronization to simpler atomic_cmpxchg
>   (Petr)
> o Slightly reworded changelog
> o Added Fixes: tag. Technically should be up to since kexec can happen
>   in an NMI, but that isn't such a clear target
> 
> Cheers,
> Valentin
> 
> Valentin Schneider (2):
>   kexec: Turn all kexec_mutex acquisitions into trylocks
>   panic, kexec: Make __crash_kexec() NMI safe
> 
>  include/linux/kexec.h   |  2 +-
>  kernel/kexec.c          | 11 ++++-------
>  kernel/kexec_core.c     | 28 ++++++++++++++++------------
>  kernel/kexec_file.c     |  4 ++--
>  kernel/kexec_internal.h | 15 ++++++++++++++-
>  kernel/ksysfs.c         |  7 ++++++-
>  6 files changed, 43 insertions(+), 24 deletions(-)
> 
> --
> 2.31.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

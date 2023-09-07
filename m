Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E047DEE14AA
	for <kexec@archiver.kernel.org>; Thu,  7 Sep 2023 02:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GE6Cgta7xXxFOXapA4pcszb4e3RPVgWBiSxha80Eq4I=; b=E0O3UsXCz86ypd
	v1QUaHOjOG/XMeNNTAPy/x3/IgoDc/+YEoE2QNOuobRqK+VKxG2J2cyaayqmiJFF2WOUocRnQOoRX
	r+yo3svphQ9nL9uyItIsRV53kBaLYfwB6idtwDG6Q2tKgyd/i/3Z+V3baJ8A9weofXSeXEasgw4Iz
	LgudUN0EAVwr0+bruroHZLxK8lvghjHQjiJEVM5tG8tfa0h2hWuSq5fy81QXu4Nw0VakRd/gJiijx
	ky2tbAtMFDnDiRVe7FBjuBrZ67ljlMkni07H/hU/Jr/cswqONSPCBRvtJ6yamu/87ypITIYcAVt9A
	YodOkqB5HSV89bHsdWOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qe4ad-00BBDu-1t;
	Thu, 07 Sep 2023 02:17:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qe4ab-00BBD5-05
	for kexec@lists.infradead.org;
	Thu, 07 Sep 2023 02:17:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694053068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eNUh+ilmidts82zkL3kEJ0JI8XOX1rnGdxOPQB5E6Bc=;
	b=h2zhwgi/SlhBbMLfi4xAmAwJ0ZiGjjapBUlrum1e3mAMQtQe+VK6PfHJuj0+yjKjhDH0Y0
	UchvMBkHxQZVjuz7tZeC2jPtmzxuAdzm7EylLapCbKwsiNrP0jsqiA4YlNJLJ1I3FOU45i
	YsLkgPkprJ0xu0J78bFNdQIHPluRPaI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-7ehbO9zbOZO0TtB0S7UNvQ-1; Wed, 06 Sep 2023 22:17:44 -0400
X-MC-Unique: 7ehbO9zbOZO0TtB0S7UNvQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33725101A529;
	Thu,  7 Sep 2023 02:17:43 +0000 (UTC)
Received: from localhost (unknown [10.72.112.68])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 52EB9404119;
	Thu,  7 Sep 2023 02:17:42 +0000 (UTC)
Date: Thu, 7 Sep 2023 10:17:39 +0800
From: Baoquan He <bhe@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, k-hagio-ab@nec.com,
	lijiang@redhat.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Dave Chinner <david@fromorbit.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	kexec@lists.infradead.org
Subject: Re: [PATCH v2 4/9] mm: vmalloc: Remove global vmap_area_root rb-tree
Message-ID: <ZPkyw0nAQSQWj5H1@MiWiFi-R3L-srv>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-5-urezki@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230829081142.3619-5-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230906_191749_130391_B9BF064E 
X-CRM114-Status: GOOD (  17.92  )
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

Add Kazu and Lianbo to CC, and kexec mailing list

On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
> Store allocated objects in a separate nodes. A va->va_start
> address is converted into a correct node where it should
> be placed and resided. An addr_to_node() function is used
> to do a proper address conversion to determine a node that
> contains a VA.
> 
> Such approach balances VAs across nodes as a result an access
> becomes scalable. Number of nodes in a system depends on number
> of CPUs divided by two. The density factor in this case is 1/2.
> 
> Please note:
> 
> 1. As of now allocated VAs are bound to a node-0. It means the
>    patch does not give any difference comparing with a current
>    behavior;
> 
> 2. The global vmap_area_lock, vmap_area_root are removed as there
>    is no need in it anymore. The vmap_area_list is still kept and
>    is _empty_. It is exported for a kexec only;

I haven't taken a test, while accessing all nodes' busy tree to get
va of the lowest address could severely impact kcore reading efficiency
on system with many vmap nodes. People doing live debugging via
/proc/kcore will get a little surprise.

Empty vmap_area_list will break makedumpfile utility, Crash utility
could be impactd too. I checked makedumpfile code, it relys on
vmap_area_list to deduce the vmalloc_start value. 

> 
> 3. The vmallocinfo and vread() have to be reworked to be able to
>    handle multiple nodes.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

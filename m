Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7196BEE14D3
	for <kexec@archiver.kernel.org>; Thu,  7 Sep 2023 09:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uYfUwxUwEXvY8ZTFEvP6UxdZHokyjkymhyheSsiunlA=; b=pppFEm5P1F7Va3
	lIszHvBadAEBBLqZDkVoV36gEvdrGd2XvriEO9yJjpNyTfTcYILRhC3pseUHjPP8TFFKifA1KtU7Q
	4Wp3YjYxSMRuvmHcI8aRc7qNEgRzWscxoxkOX+EoqNTj0qC6d3pIh5m/rmN4GjFRdYJgzZxQY8ZVy
	leKSTfZZV/+6SY8CkU6n0GyPvMhcAvbRXCcBWbsbcrnvK+UEJY74AR4e4juvzdh4CrTFSC6fWHQRL
	yYJDfEs3lhmpkiR+sH+jB8tMv6YzwswLZYJmD/jG4nE5CusyhhAuGXFDjCDWCvwn5F1vSk+RSTlP0
	touQyHewLI68OEqZhj7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeBSt-00BhIT-11;
	Thu, 07 Sep 2023 09:38:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeBSr-00BhHR-0l
	for kexec@lists.infradead.org;
	Thu, 07 Sep 2023 09:38:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694079495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=euSESbGnOpxGG/an0+tjKSmmMkLR8E9KsUE2opfoBz4=;
	b=excSXbyJlGbX6pAc33Ge9NN6EDo2zxteKV7vQwsKT+quExSXCimXATWKj78GYssm/Z5W+z
	whxjjbt7mkqn36HpnfhgYNNbMNvMbI9BTjixPlAY2oJQReU6k6PAyA86jAdU+jAC1EyGyM
	mtMyfZXFqB87pCyZOSTVJy6OAW2fLCs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-b4LufIMuOiuXJ0blwuhkkQ-1; Thu, 07 Sep 2023 05:38:12 -0400
X-MC-Unique: b4LufIMuOiuXJ0blwuhkkQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F9AF8001EA;
	Thu,  7 Sep 2023 09:38:11 +0000 (UTC)
Received: from localhost (unknown [10.72.112.68])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EDFBC03293;
	Thu,  7 Sep 2023 09:38:10 +0000 (UTC)
Date: Thu, 7 Sep 2023 17:38:07 +0800
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
Message-ID: <ZPmZ/8CLpKHEZvQY@MiWiFi-R3L-srv>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-5-urezki@gmail.com>
 <ZPkyw0nAQSQWj5H1@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZPkyw0nAQSQWj5H1@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_023817_361955_9F68CB64 
X-CRM114-Status: GOOD (  25.43  )
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

On 09/07/23 at 10:17am, Baoquan He wrote:
> Add Kazu and Lianbo to CC, and kexec mailing list
> 
> On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
> > Store allocated objects in a separate nodes. A va->va_start
> > address is converted into a correct node where it should
> > be placed and resided. An addr_to_node() function is used
> > to do a proper address conversion to determine a node that
> > contains a VA.
> > 
> > Such approach balances VAs across nodes as a result an access
> > becomes scalable. Number of nodes in a system depends on number
> > of CPUs divided by two. The density factor in this case is 1/2.
> > 
> > Please note:
> > 
> > 1. As of now allocated VAs are bound to a node-0. It means the
> >    patch does not give any difference comparing with a current
> >    behavior;
> > 
> > 2. The global vmap_area_lock, vmap_area_root are removed as there
> >    is no need in it anymore. The vmap_area_list is still kept and
> >    is _empty_. It is exported for a kexec only;
> 
> I haven't taken a test, while accessing all nodes' busy tree to get
> va of the lowest address could severely impact kcore reading efficiency
> on system with many vmap nodes. People doing live debugging via
> /proc/kcore will get a little surprise.
> 
> Empty vmap_area_list will break makedumpfile utility, Crash utility
> could be impactd too. I checked makedumpfile code, it relys on
> vmap_area_list to deduce the vmalloc_start value. 

Except of the empty vmap_area_list, this patch looks good to me.

We may need think of another way to export the vmalloc_start value or
deduce it in makedumpfile/Crash utility. And then remove the useless
vmap_area_list. I am not sure if we should remove vmap_area_list in this
patch because the empty value will cause breakage anyway. Otherwise,

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> > 
> > 3. The vmallocinfo and vread() have to be reworked to be able to
> >    handle multiple nodes.
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

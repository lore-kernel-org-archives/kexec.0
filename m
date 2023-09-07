Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C59EE14D4
	for <kexec@archiver.kernel.org>; Thu,  7 Sep 2023 09:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pgJohFlITWkBEXBJZlt2UTHtaSbHvRNy77r+wHNTo6E=; b=DxFjEijhcsH7vg
	K6Xa0MBiu06Fz6eMyVIJ3ev9+SDRPK/kEeSNNnCnwmq6rrHt1ECJw/hEzq2NA6tWQnPtrS/zEO22o
	yW3/Zcs5tw+4WC1Ly84H9Pu7M8SZ+1FQHOVjnj9btPtcNSAyfTQkroL5/MGARqVn6IHFSThPJ09bl
	k9m65SKnFlr3MAIHsSc1aiyGselBv5g827oM9oPowo7paLksfwlQ+aepv+QMUQejlohjo9v536HGr
	4kL6asthGmrXA99RyQiGC9QeNUaaV3Yzx1JLlhN1JKitVm1NWHhncVxyNH89OKTwCErCELzrLpYnO
	jL6zmf99qxi6H1joEseQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeBmL-00Bjdi-2z;
	Thu, 07 Sep 2023 09:58:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeBmI-00BjcR-2S
	for kexec@lists.infradead.org;
	Thu, 07 Sep 2023 09:58:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694080700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+YZnY8Y16y63bpnKa1LB+Dq6TqgHlqb2M3cQd5Vbeeg=;
	b=Dm9lYZt6+rWWBGxgs1RoCWNXBKWGGPQUs7A8NJ5RFJtLad+ukL37y0jGg8cTscmv0xIxZl
	LDCQcjchUCYL/ZPSSAS9iZ8KHxBIg+paF3NBG5Kx/lJOL++CoBou/qh5jozdT4aAMrQGg/
	5WhmcYtjTQae1ZZ/Ipq/37MV4sp78TE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-bRJDmM7BNXioUhRM5aC-Og-1; Thu, 07 Sep 2023 05:58:16 -0400
X-MC-Unique: bRJDmM7BNXioUhRM5aC-Og-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79102801FA9;
	Thu,  7 Sep 2023 09:58:15 +0000 (UTC)
Received: from localhost (unknown [10.72.112.68])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 399E2493112;
	Thu,  7 Sep 2023 09:58:13 +0000 (UTC)
Date: Thu, 7 Sep 2023 17:58:09 +0800
From: Baoquan He <bhe@redhat.com>
To: Uladzislau Rezki <urezki@gmail.com>, k-hagio-ab@nec.com
Cc: lijiang@redhat.com, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <ZPmesS66PTl+1Mdz@MiWiFi-R3L-srv>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-5-urezki@gmail.com>
 <ZPkyw0nAQSQWj5H1@MiWiFi-R3L-srv>
 <ZPmaYgsT5EdLVUyO@pc636>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZPmaYgsT5EdLVUyO@pc636>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_025822_872658_37E12B5D 
X-CRM114-Status: GOOD (  30.39  )
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

On 09/07/23 at 11:39am, Uladzislau Rezki wrote:
> On Thu, Sep 07, 2023 at 10:17:39AM +0800, Baoquan He wrote:
> > Add Kazu and Lianbo to CC, and kexec mailing list
> > 
> > On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
> > > Store allocated objects in a separate nodes. A va->va_start
> > > address is converted into a correct node where it should
> > > be placed and resided. An addr_to_node() function is used
> > > to do a proper address conversion to determine a node that
> > > contains a VA.
> > > 
> > > Such approach balances VAs across nodes as a result an access
> > > becomes scalable. Number of nodes in a system depends on number
> > > of CPUs divided by two. The density factor in this case is 1/2.
> > > 
> > > Please note:
> > > 
> > > 1. As of now allocated VAs are bound to a node-0. It means the
> > >    patch does not give any difference comparing with a current
> > >    behavior;
> > > 
> > > 2. The global vmap_area_lock, vmap_area_root are removed as there
> > >    is no need in it anymore. The vmap_area_list is still kept and
> > >    is _empty_. It is exported for a kexec only;
> > 
> > I haven't taken a test, while accessing all nodes' busy tree to get
> > va of the lowest address could severely impact kcore reading efficiency
> > on system with many vmap nodes. People doing live debugging via
> > /proc/kcore will get a little surprise.
> > 
> >
> > Empty vmap_area_list will break makedumpfile utility, Crash utility
> > could be impactd too. I checked makedumpfile code, it relys on
> > vmap_area_list to deduce the vmalloc_start value. 
> >
> It is left part and i hope i fix it in v3. The problem here is
> we can not give an opportunity to access to vmap internals from
> outside. This is just not correct, i.e. you are not allowed to
> access the list directly.

Right. Thanks for the fix in v3, that is a relief of makedumpfile and
crash.

Hi Kazu,

Meanwhile, I am thinking if we should evaluate the necessity of
vmap_area_list in makedumpfile and Crash. In makedumpfile, we just use
vmap_area_list to deduce VMALLOC_START. Wondering if we can export
VMALLOC_START directly. Surely, the lowest va->va_start in vmap_area_list
is a tighter low boundary of vmalloc area and can reduce unnecessary
scanning below the lowest va. Not sure if this is the reason people
decided to export vmap_area_list.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

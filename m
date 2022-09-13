Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0673C54EE9
	for <kexec@archiver.kernel.org>; Tue, 13 Sep 2022 10:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IBo/qmcfpssLCq4nkk5PE935q7k32b6h4uazsOhW1rI=; b=unZmkYlHMRMYKB
	lbTkPUFJTGyTrWHO3oykAGPE4go4P5fmToRnJKY7+hL4JKQcN8+ovyJpwmloyNZPqS4l8WyD6WtDG
	tKpK5AFqSAIb1WKG428MZtoFOUJsQ/vwZ8U7+cZpTmiFsML6jREpqVr864aaIPLYLcH6qWHsFihGe
	mm7MHSrhugNVvzs8P5imrri8r/bfE8lNvv6u+wOy5HevZHjrgj9I3XMKnmXnRyx65/C8IcXbeiHdu
	sTte+LyaFskiRlOWy9fY07y9S17bexhEoAdnJTZf4lNHXbSLqYb4d3oa04rG6JOhJ3vWOG6KCGW3M
	mYTYOZYXhMSkb/VA8p4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oY3D6-006c0Y-Qd; Tue, 13 Sep 2022 10:32:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oY37K-006VEn-GI
	for kexec@lists.infradead.org; Tue, 13 Sep 2022 10:26:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663064767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=haJLEkgrl6AF0f2+tq8m7Wz5y9BoDUUF75cEpjza7qM=;
	b=QuFqQWu0jUmY0HnWSN+FDD4ozqNFL8cViZ8/z/jl49fWYGa1OUoJ2DMtng0q9evglE1aTC
	V24nRm3COcjl0pgzIUA7yQwe/gemdj/81oJU9qDArusO3MFfxLqOk/q+Xlo4UNnxgjRXNJ
	LT9IN98M1NFeDtzg2k4TdxyEX9Syj6M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635--orak3MgMIiwkt3zC2ek5w-1; Tue, 13 Sep 2022 06:26:04 -0400
X-MC-Unique: -orak3MgMIiwkt3zC2ek5w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCD048037AC;
	Tue, 13 Sep 2022 10:26:03 +0000 (UTC)
Received: from localhost (ovpn-13-136.pek2.redhat.com [10.72.13.136])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 174751121314;
	Tue, 13 Sep 2022 10:26:02 +0000 (UTC)
Date: Tue, 13 Sep 2022 18:25:59 +0800
From: Baoquan He <bhe@redhat.com>
To: Matthew Wilcox <willy@infradead.org>,
	Jianglei Nie <niejianglei2021@163.com>
Cc: vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc/vmcore: fix potential memory leak in vmcore_init()
Message-ID: <YyBat53TZUK9trX/@MiWiFi-R3L-srv>
References: <20220913062501.82546-1-niejianglei2021@163.com>
 <YyAkpQNWXrkMGdYr@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YyAkpQNWXrkMGdYr@casper.infradead.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220913_032610_734364_6DC4801D 
X-CRM114-Status: GOOD (  13.34  )
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

On 09/13/22 at 07:35am, Matthew Wilcox wrote:
> On Tue, Sep 13, 2022 at 02:25:01PM +0800, Jianglei Nie wrote:
> >  	}
> > -	elfcorehdr_free(elfcorehdr_addr);
> >  	elfcorehdr_addr = ELFCORE_ADDR_ERR;
> >  
> >  	proc_vmcore = proc_create("vmcore", S_IRUSR, NULL, &vmcore_proc_ops);
> >  	if (proc_vmcore)
> >  		proc_vmcore->size = vmcore_size;
> > -	return 0;
> > +
> > +fail:
> > +	elfcorehdr_free(elfcorehdr_addr);
> > +	return rc;
> >  }
> 
> Did you test this?  It looks like you now call
> elfcorehdr_free(ELFCORE_ADDR_ERR) if 'rc' is 0.

Right, that will cause problem. It's my fault since I suggested
the current change.

Jianglei, please use your v1 change and post again. Sorry for the
incorrect suggestion.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0891C10DC3
	for <kexec@archiver.kernel.org>; Fri,  8 Dec 2023 02:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RA0sL8vv5wFuB/wlku5/nx6JwpTR479CJJ6hg3wcbRo=; b=D/nKRH3muMPrZQ
	Wr0wyJY3kj0qZtm+DQ+iCZBsnoayPjynk851mao1O97Tm0dsmhJwAFncdlcUM/Op6leCkpYX+K+rC
	/kVVAWUna6F1fcOLe14gl/ydZSrDYVvxxRn2XF4F4RFN+MqfAwy5TN8i/QxpInwezOwoUbZpjZ+Uo
	1dgOt0lPdyqyLPqHZ7JWvHk5xi/VL8jwmAKxkuY7YYETvCUg38RKrQknF2AWP1vclgetXDol4ZbOf
	dvucGT/LtrmAilWTMNk5WLpDv9yspJCXy/MBLIbpZoF5TfhLu9JfmWKyF6KF69yihhHJ8wpgZWgyf
	9aZIYb3IsaAG77wRb8FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBQKQ-00EWOM-24;
	Fri, 08 Dec 2023 02:10:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBQKN-00EWNx-2l
	for kexec@lists.infradead.org;
	Fri, 08 Dec 2023 02:10:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702001454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Il5oopo58FBky7wapbSa4VtHGAOr6/LyABJzUA84HrQ=;
	b=iflY99DwMp5u1Q4CJvgBb9xFfoamXNKGk25eNwU9ce10WGWdRLR+mCIgAf9vWcfOG1KD3m
	jpLbbSrqJVeWcA0UVwi+Ir+tZELyYJ1GBkmWlG6J0xYd/uBhZl4cdHgjVxkNuNn5X0ZgCV
	BzsVlzREaBP4xmpA9+87PqZx41qtdB8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-1J2f_jeiOX62oP58qsBoLQ-1; Thu, 07 Dec 2023 21:10:51 -0500
X-MC-Unique: 1J2f_jeiOX62oP58qsBoLQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95D37881DF1;
	Fri,  8 Dec 2023 02:10:50 +0000 (UTC)
Received: from localhost (unknown [10.72.113.121])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D71DE40C6EB9;
	Fri,  8 Dec 2023 02:10:49 +0000 (UTC)
Date: Fri, 8 Dec 2023 10:10:46 +0800
From: Baoquan He <bhe@redhat.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZXJ7JpcZALSeFvox@MiWiFi-R3L-srv>
References: <ZWiQ-II9CvGv8EWK@tiehlicka>
 <20231201123353.2b3db7fa@rotkaeppchen>
 <ZWnJyArAmFo_uYPA@tiehlicka>
 <20231201165113.43211a48@rotkaeppchen>
 <ZWoQ1k2AikSiMjys@tiehlicka>
 <20231206120805.4fdcb8ab@rotkaeppchen>
 <ZXB7_rbC0GAkIp7p@tiehlicka>
 <ZXCRF-bvm8ijXxr4@tiehlicka>
 <ZXFIsZ+0GmUZMFk3@MiWiFi-R3L-srv>
 <ZXGIeAgCcatUDa2h@tiehlicka>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZXGIeAgCcatUDa2h@tiehlicka>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231207_181055_980945_8F6D79A0 
X-CRM114-Status: GOOD (  20.69  )
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

On 12/07/23 at 09:55am, Michal Hocko wrote:
> On Thu 07-12-23 12:23:13, Baoquan He wrote:
> [...]
> > We can't guarantee how swift the DMA transfer could be in the cma, case,
> > it will be a venture.
> 
> We can't guarantee this of course but AFAIK the DMA shouldn't take
> minutes, right? While not perfect, waiting for some time before jumping
> into the crash kernel should be acceptable from user POV and it should
> work around most of those potential lingering programmed DMA transfers.
> 
> So I guess what we would like to hear from you as kdump maintainers is
> this. Is it absolutely imperative that these issue must be proven
> impossible or is a best effort approach something worth investing time
> into? Because if the requirement is an absolute guarantee then I simply
> do not see any feasible way to achieve the goal of reusable memory.

Honestly, I think all the discussions and proof have told clearly it's
not a good idea. This is not about who wants this, who doesn't. So
far, this is an objective fact that taking ,cma area for crashkernel= is
not a good idea, it's very risky.

We don't deny this at the beginning. I tried to present all what I know,
we have experienced, we have investigated, we have tried. I wanted to
see if this time we can clarify some concerns may be mistaken. But it's
not. The risk is obvious and very likely happen.

> 
> Let me reiterate that the existing reservation mechanism is showing its
> limits for production systems and I strongly believe this is something
> that needs addressing because crash dumps are very often the only tool
> to investigate complex issues.

Yes, I admit that. But it haven't got to the point that it's too bad to
bear so that we have to take the risk to take ,cma instead.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

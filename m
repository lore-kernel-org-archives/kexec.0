Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73823CE7A88
	for <kexec@archiver.kernel.org>; Sun, 24 Sep 2023 00:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8vr1fEVcq+Z+ssQl1AQqKfaHV1mejwAfTK5YpVs4pEw=; b=RqxGaSqMc1rrPA
	ttyxznwJeDN6eKLesNMXbCU32ydRDnkfSUJfZwzNmmzz4PPlWzXJwGUcZKY+d1I32z3PXMOPY4VuL
	ajnI4vZX7OJPlCsNvF7m1Als1b3wViu75w001LwRAW6vKDBrHG9tV4UtkoSVtRXwU2o3frlt4G+Ml
	FzPYDBCnEaE5BQ4L34AzaIP6uvFI7TrdKFPrZzgAewf5R8QZF8EOpExliIf0Svy9i4Hh59tc9G8k9
	ojHm/U+L7CY9pFfmug9DQI1aNMO6q5biks3/L5yFM/snIgBA/81wgoGexGBi1Z9UjCtU6E70sD3NJ
	ef+zXC89gBoF67zXyzNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qkDMy-00BcBG-2p;
	Sun, 24 Sep 2023 00:53:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qkDMv-00BcAl-3B
	for kexec@lists.infradead.org;
	Sun, 24 Sep 2023 00:53:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695516784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DTFrEa7vKTqj7wXo0iZDISbSz3Y6un7zOPt1IkyamfI=;
	b=RyObW98E7xUtfcvd4f4XJ6SVZrMF66YOgGojj0kXfLYaVRKvmt6FbKkImPCZ2XfuJhrXN7
	eWaguII8xK4eKHJAg1NYB5CLdi4NY4wGXpOwlpOc6szlB6/LvWKY0P/BAyvnKTCpmnAWSZ
	tYC9hYTImLzmnwojH0F0I+ynzVr7P6o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-sP602GgzNLKaiZQK_BLycg-1; Sat, 23 Sep 2023 20:53:00 -0400
X-MC-Unique: sP602GgzNLKaiZQK_BLycg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7FC43806712;
	Sun, 24 Sep 2023 00:52:59 +0000 (UTC)
Received: from localhost (unknown [10.72.112.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D4E512156701;
	Sun, 24 Sep 2023 00:52:58 +0000 (UTC)
Date: Sun, 24 Sep 2023 08:52:55 +0800
From: Baoquan He <bhe@redhat.com>
To: Kees Cook <keescook@chromium.org>
Cc: Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
	Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH] kexec: Annotate struct crash_mem with __counted_by
Message-ID: <ZQ+IZxPy7qCT83OQ@MiWiFi-R3L-srv>
References: <20230922175224.work.712-kees@kernel.org>
 <ZQ41d5majBepW48Z@MiWiFi-R3L-srv>
 <202309222012.49E3C0AA@keescook>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202309222012.49E3C0AA@keescook>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230923_175306_118022_99D68E46 
X-CRM114-Status: GOOD (  34.66  )
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

On 09/22/23 at 08:25pm, Kees Cook wrote:
> On Sat, Sep 23, 2023 at 08:46:47AM +0800, Baoquan He wrote:
> > On 09/22/23 at 10:52am, Kees Cook wrote:
> > > Prepare for the coming implementation by GCC and Clang of the __counted_by
> > > attribute. Flexible array members annotated with __counted_by can have
> > > their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> > > (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> > > functions).
> > > 
> > > As found with Coccinelle[1], add __counted_by for struct crash_mem.
> > > 
> > > [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> > > 
> > > Cc: Eric Biederman <ebiederm@xmission.com>
> > > Cc: kexec@lists.infradead.org
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  include/linux/crash_core.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> > > index 3426f6eef60b..5126a4fecb44 100644
> > > --- a/include/linux/crash_core.h
> > > +++ b/include/linux/crash_core.h
> > > @@ -131,7 +131,7 @@ static inline void __init reserve_crashkernel_generic(char *cmdline,
> > >  struct crash_mem {
> > >  	unsigned int max_nr_ranges;
> > >  	unsigned int nr_ranges;
> > > -	struct range ranges[];
> > > +	struct range ranges[] __counted_by(max_nr_ranges);
> > 
> > This __counted_by() only makes sense when there's a obvious upper
> > boundary, max_nr_ranges in this case.
> 
> Yes; it's designed to be the array element count used for the
> allocation. For example with the above case:
> 
>         nr_ranges += 2;
>         cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
>         if (!cmem)
>                 return NULL;
> 
>         cmem->max_nr_ranges = nr_ranges;
>         cmem->nr_ranges = 0;
> 
> nr_ranges is the max count of the elements.
> 
> _However_, if a structure (like this one) has _two_ counters, one for
> "in use" and another for "max available", __counted_by could specify the
> "in use" case, as long as array indexing only happens when that "in use"
> has been updated. So, if it were:
> 
> struct crash_mem {
>     unsigned int max_nr_ranges;
>     unsigned int nr_ranges;
>     struct range ranges[] __counted_by(nr_ranges);
> };
> 
> then this would trigger the bounds checking:
> 
> 	cmem->ranges[0] = some_range;	/* "nr_ranges" is still 0 so index 0 isn't allowed */
> 	cmem->nr_ranges ++;
> 
> but this would not:
> 
> 	cmem->nr_ranges ++;		/* index 0 is now available for use. */
> 	cmem->ranges[0] = some_range;
> 
> > This heavily depends and isn't much in kernel?
> 
> Which "this" do you mean? The tracking of max allocation is common.
> Tracking max and "in use" happens in some places (like here), but is
> less common.

I thought usually it may not have a max counter of the variable length
array embeded in struct, seems I was wrong. Here 'this' means the
__counted_by() adding for the variable length array.

> 
> > E.g struct swap_info_struct->avail_lists[].
> 
> This is even less common: tracking the count externally from the struct,
> as done there with nr_node_ids. Shakeel asked a very similar question
> and also pointed out nr_node_ids:
> https://lore.kernel.org/all/202309221128.6AC35E3@keescook/
> 
> > Just curious, not related to this patch though.
> 
> I'm happy to answer questions! Yeah, as I said in the above thread,
> I expect to expand what __counted_by can use, and I suspect (hope)
> a global would be easier to add than an arbitrary expression. :)

Thanks a lot for these explanation, Kees.

LGTM,
Acked-by: Baoquan He <bhe@redhat.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

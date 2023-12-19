Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021D3C41535
	for <kexec@archiver.kernel.org>; Tue, 19 Dec 2023 14:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GvnorfsD6LQBfHDQu9dcdiyluYjgFgLNfxlTRcVWtDY=; b=4bfamZxVvwTRQo
	EJe2xGWTz1T0u2mlRbEZhqzdcfGuHK4a45SxlKXoVNM5c9jPXEXY/TS++ycRjF3H/eNeZPj0MdCMh
	ziX+VGfALsjrStqS9UuVA0+930lV4Rh++E058+Q7AY+TyPHCzkhS5ZvKOvv4plAvxMkfB2m3r6ex1
	Lotq9OBHtJ7iPmhSSoWZ7Xz8e30Q8irZ2baiWgtU5kmrWyzerbFJ4l+Y3xlXMWYK5vpFRwN5QtZCv
	Gv9malrhkbqRVZA8P+J9qtldwHb9WGAbI8X3ooXZvivJEe5TjGkusNWkBbQ46XrenOcvD/ulKdCu4
	dfR6YToASHc5Jdv+QTlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFazw-00ELBE-26;
	Tue, 19 Dec 2023 14:23:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFazs-00ELAK-1q
	for kexec@lists.infradead.org;
	Tue, 19 Dec 2023 14:23:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702995777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T73/UIMzWHn6HnuNFK61H/99zWj4Spshz34rsfXU2I0=;
	b=KZMjax26fz1KhhhDm2XayPRM6YrJVcuqAkOS6OGZXSD6B67a3rQnA0OgXrgS8y8XEm/XvM
	YIVIV3B6zGOqSrdJOqd0ve+e/Uayh+RkRtmVZlITP31uAucCbCfVGJlFHwtmnny06E78o5
	pV4cheetG2h+K0oR8D6UrBkcHWU7QRU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-sqhyZlJEOn6OOveDK5Umfw-1; Tue,
 19 Dec 2023 09:22:53 -0500
X-MC-Unique: sqhyZlJEOn6OOveDK5Umfw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D40491C06900;
	Tue, 19 Dec 2023 14:22:52 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 699902026D6F;
	Tue, 19 Dec 2023 14:22:51 +0000 (UTC)
Date: Tue, 19 Dec 2023 22:22:47 +0800
From: Baoquan He <bhe@redhat.com>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
	dyoung@redhat.com, hbathini@linux.ibm.com, hpa@zytor.com,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	mingo@redhat.com, seanjc@google.com, tglx@linutronix.de,
	tiwai@suse.de, vgoyal@redhat.com, x86@kernel.org
Subject: Re: [PATCH 2/2] crash_core: fix out-of-bounds access check in
 crash_exclude_mem_range()
Message-ID: <ZYGnN2hKuXGbusNV@MiWiFi-R3L-srv>
References: <ZYEOshALGbDKwSdc@MiWiFi-R3L-srv>
 <20231219043129.38841-1-ytcoode@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231219043129.38841-1-ytcoode@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_062300_706860_6BB48EE8 
X-CRM114-Status: GOOD (  51.40  )
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

On 12/19/23 at 12:31pm, Yuntao Wang wrote:
> On Tue, 19 Dec 2023 11:32:02 +0800, Baoquan He <bhe@redhat.com> wrote:
> > Hi Yuntao,
> > 
> > On 12/19/23 at 10:02am, Yuntao Wang wrote:
> > > On Mon, 18 Dec 2023 09:29:02 -0800, Andrew Morton <akpm@linux-foundation.org> wrote:
> > > 
> > > > On Mon, 18 Dec 2023 16:19:15 +0800 Yuntao Wang <ytcoode@gmail.com> wrote:
> > > > 
> > > > > mem->nr_ranges represents the current number of elements stored in
> > > > > the mem->ranges array, and mem->max_nr_ranges represents the maximum number
> > > > > of elements that the mem->ranges array can hold. Therefore, the correct
> > > > > array out-of-bounds check should be mem->nr_ranges >= mem->max_nr_ranges.
> > > > > 
> > > > 
> > > > This does not apply after your own "crash_core: fix and simplify the
> > > > logic of crash_exclude_mem_range()".  What should be done?
> > > 
> > > Hi Andrew,
> > > 
> > > I actually prefer the "crash_core: fix and simplify the logic of
> > > crash_exclude_mem_range()" patch as it makes the final code more concise and
> > > clear, and less prone to errors.
> > > 
> > > The current code is too strange, I guess no one can understand why there is
> > > a break in the for loop when they read this code for the first time.
> > > 
> > > Moreover, I think the current code is too fragile, it relies on callers using
> > > this function correctly to ensure its correctness, rather than being able to
> > > guarantee the correctness on its own. I even feel that this function is very
> > > likely to have bugs again as the code evolves.
> > > 
> > > However, Baoquan also has his own considerations, he suggests keeping the code
> > > as it is.
> > > 
> > > The link below is our detailed discussion on this issue:
> > 
> > There's misunderstanding here.
> > 
> > Firstly I said I have concern about the patch, I didn't NACK or reject the patch.
> > 
> > [PATCH 3/3] crash_core: fix and simplify the logic of crash_exclude_mem_range()
> > 
> > Usually, when people said he/she had concern, you may need to
> > investigate and resolve it or explain why it's not need be cared about.
> > 
> > E.g on above [PATCH 3/3], we can add below code change to stop scanning
> > when the left ranges are all above the excluded range, assume the passed
> > in cmem has a ascending order of ranges. Say so because I checked code
> > and found that crash_exclude_mem_range() is called in arch arm64, ppc,
> > riscv and x86. Among them, arm64 and ppc create the cmem from memblock,
> > riscv and x86 create cmem from iomem. All of them should be in ascending
> > ordr. The below code change based on your patch 3/3 looks safe to me.
> > What do you think?
> > 
> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > index aab342c2a5ee..39b6c149dc80 100644
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -574,9 +574,12 @@ int crash_exclude_mem_range(struct crash_mem *mem,
> >  		p_start = mstart;
> >  		p_end = mend;
> >  
> > -		if (p_start > end || p_end < start)
> > +		if (p_start > end)
> >  			continue;
> >  
> > +		if (p_end < start)
> > +			break;
> > +
> >  		/* Truncate any area outside of range */
> >  		if (p_start < start)
> >  			p_start = start;
> > 
> > Secondly, I welcome people who are interested kexec/kdump code, and raise
> > issues or post patches to fix bug, clean up code. I like these patches.
> > They can help improve kexec/kdump code and solve problem in advance.
> > I would like to review and make the patches acceptable and merged
> > inally. And I also hope people can follow the later issue reported by
> > other people or LKP if their merged patch caused that.
> > 
> > Lastly, people are encouraged to help review other people's patch
> > and give suggestes to improve the code change. If patch author don't
> > respond for a long while or the work has been suspended for long time, we
> > can add comment to tell and take over the work to continue.
> > 
> > These are my personal understanding and thought about kexec/kdump patch
> > reviewing and maintance. So cheer up.
> > 
> > > 
> > > https://lore.kernel.org/lkml/20231214163842.129139-3-ytcoode@gmail.com/t/#mfd78a97e16251bcb190b0957a0b6cb4b0a096b54
> > > 
> > > The final decision on whether to apply that patch is up to you and Baoquan, if
> > > you choose to apply that patch, this patch can be ignored. But if you decide not
> > > to apply that patch, then this patch must be applied, as it fixes a bug in the
> > > crash_exclude_mem_range() function.
> > > 
> > > Sincerely,
> > > Yuntao
> 
> Hi Baoquan,
> 
> I must clarify that I was not complaining about you. On the contrary, I am
> grateful to everyone who takes time to review code for others, because I know
> it is a lot of work.
> 
> I'm relatively new to the Linux community and still learning the various rules
> of the community. I'm very sorry that I didn't fully grasp your previous intention.
> 
> Regarding the method you suggested to add a 'break', I did consider it initially
> but later decided against it because the memory ranges obtained from iomem may
> overlap, so I chose a safer way instead.

In iomem, parent range includes children's range, while
walk_system_ram_res() traverses ranges not overlapped with each otehr.
From code in __walk_iomem_res_desc() and find_next_iomem_res(), it
clearly shows that.

walk_system_ram_res()
  -->__walk_iomem_res_desc()
     -->find_next_iomem_res()


> 
> Finally, I would like to apologize again if my previous response offended you.
> That was not my intention.

No offence felt at all, and no worry about this. In upstream, argument
is normal, it's fine as long as your intention is making things better,
not against person. Meantime, let's be kind and friendly to each other,
we will have a great time.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

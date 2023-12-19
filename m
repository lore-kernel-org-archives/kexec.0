Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CFAC46CA2
	for <kexec@archiver.kernel.org>; Tue, 19 Dec 2023 16:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LbFNfuAQldi2aHFZcW3K8PMUtQRkdoeVfZ2RfVEzh4Q=; b=omNYHsuEMx4z+H
	XNbCUJ5AGWioSt7pFVgR3xvOIWViHko+t0yBqW6dmFTd7vpS6/fT3noRbth0SjCa19DOzKapWrauQ
	+egfnHO3lI6oOICkNOkd6EZom9XnluKg28UJiy7uDJX9HPMV9JeCtbv9ruKjnxmZIPWjupzxl+1YY
	WU+MsPEj67vVFDjvLZnvklHxndaUud1yLTp5CVva9xoioZhFm2afhYEuggcE14luDpaVO/ISZHqek
	CgIUOggKEznYid9t83hoLEkeKd9fJyi71GmHVfmAKNQj8DBrk9eaRvvMbAGPLbzC1ypiR9rrGB3e/
	ajqog1ZRfYek6h0opIDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFcWY-00EcjB-3C;
	Tue, 19 Dec 2023 16:00:51 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFcWV-00EciW-2W
	for kexec@lists.infradead.org;
	Tue, 19 Dec 2023 16:00:49 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d04c097e34so32592955ad.0
        for <kexec@lists.infradead.org>; Tue, 19 Dec 2023 08:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703001646; x=1703606446; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lU/xIQD40Nx1IILlXSAWoTy6NdNE76mzC5mKDdKyu0A=;
        b=h27i3vZX3bMLSdIo5mu0f1autAf9JO/wTtROQRs9jNv8ECqrxFr5AkiNA8Cgi+DZX9
         22quTbdgZZompNY1nV7ZSa46RKTjkFg+ophQgKRAF752YT+BnBknXrUw4nuV6LBzTBJB
         qxtWkiUQ7XhyYN2Y7H9dv2utUtnUnx+iU0wUaEmvqFRzZ8RtIokqPIpmbiCTXcuq+kh9
         HYRKeR+a1GuMRNJn780zdq2QWvA50ymSPAX5T2LKpN35Xxnw6MnENoX/99g5yp+UXLEt
         JyqWSA69fwsH6KvwWh32Iun4zYlDiXEsLw0HM7wPQCXsDQxJAFyVjQ7J00Tu/hf08/1o
         TR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703001646; x=1703606446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lU/xIQD40Nx1IILlXSAWoTy6NdNE76mzC5mKDdKyu0A=;
        b=wTruKFEmZkEOsXaLNs5mKpL3h3fYwOSGlxDQ/9bGZYvBliArarBubW0nJhkCh3k/Kj
         YGPCHwvFy/PLyCW6SLXF2sQa7p55FrcGbgn9t0bEEEmnbxZz56YAEIsZ5vcUigEl7Opy
         apgiDVQ6BC+Dxe+hTKVG3+AV8eNolBPBdVGWxvETpT4hLjb4wcBSZv9gQHNs+SIy9k/+
         9LKb4sOpL29SMHsq+KVJ4pHLA9st8ggdTeZTTrb74KqiY/CtN9uelB/3FE5RLjIm22s3
         /VGiLbICYq6CRE5VUy4cd2FUvtxgiCm9yQoFrfIzq6rI9hq9HjvzWlJub/6UmSx2Xhd5
         uA3A==
X-Gm-Message-State: AOJu0Yxctk1lgS/ZeCRBFeP4r6rEXyNfAJLQzQ1oKYhNfdlxgZX1Ak90
	41tkDrqLXlFQlofMSQ5I5Tw=
X-Google-Smtp-Source: AGHT+IFaCR+UxMW1GwIzY4Cf0e5DLDTY/2Ufuz/6B18FozvWEa28zS8ChjlUDWe4vZSx7YdngezoDw==
X-Received: by 2002:a17:903:41c6:b0:1d0:6ffd:611c with SMTP id u6-20020a17090341c600b001d06ffd611cmr1790831ple.62.1703001645772;
        Tue, 19 Dec 2023 08:00:45 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id v23-20020a170902e8d700b001d08e080042sm21181544plg.43.2023.12.19.08.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 08:00:45 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: bhe@redhat.com
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	dyoung@redhat.com,
	hbathini@linux.ibm.com,
	hpa@zytor.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	seanjc@google.com,
	tglx@linutronix.de,
	tiwai@suse.de,
	vgoyal@redhat.com,
	x86@kernel.org,
	ytcoode@gmail.com
Subject: Re: [PATCH 2/2] crash_core: fix out-of-bounds access check in crash_exclude_mem_range()
Date: Wed, 20 Dec 2023 00:00:35 +0800
Message-ID: <20231219160035.104391-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZYGnN2hKuXGbusNV@MiWiFi-R3L-srv>
References: <ZYGnN2hKuXGbusNV@MiWiFi-R3L-srv>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_080047_816496_5F75854B 
X-CRM114-Status: GOOD (  56.64  )
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

On Tue, 19 Dec 2023 22:22:47 +0800, Baoquan He <bhe@redhat.com> wrote:

> On 12/19/23 at 12:31pm, Yuntao Wang wrote:
> > On Tue, 19 Dec 2023 11:32:02 +0800, Baoquan He <bhe@redhat.com> wrote:
> > > Hi Yuntao,
> > > 
> > > On 12/19/23 at 10:02am, Yuntao Wang wrote:
> > > > On Mon, 18 Dec 2023 09:29:02 -0800, Andrew Morton <akpm@linux-foundation.org> wrote:
> > > > 
> > > > > On Mon, 18 Dec 2023 16:19:15 +0800 Yuntao Wang <ytcoode@gmail.com> wrote:
> > > > > 
> > > > > > mem->nr_ranges represents the current number of elements stored in
> > > > > > the mem->ranges array, and mem->max_nr_ranges represents the maximum number
> > > > > > of elements that the mem->ranges array can hold. Therefore, the correct
> > > > > > array out-of-bounds check should be mem->nr_ranges >= mem->max_nr_ranges.
> > > > > > 
> > > > > 
> > > > > This does not apply after your own "crash_core: fix and simplify the
> > > > > logic of crash_exclude_mem_range()".  What should be done?
> > > > 
> > > > Hi Andrew,
> > > > 
> > > > I actually prefer the "crash_core: fix and simplify the logic of
> > > > crash_exclude_mem_range()" patch as it makes the final code more concise and
> > > > clear, and less prone to errors.
> > > > 
> > > > The current code is too strange, I guess no one can understand why there is
> > > > a break in the for loop when they read this code for the first time.
> > > > 
> > > > Moreover, I think the current code is too fragile, it relies on callers using
> > > > this function correctly to ensure its correctness, rather than being able to
> > > > guarantee the correctness on its own. I even feel that this function is very
> > > > likely to have bugs again as the code evolves.
> > > > 
> > > > However, Baoquan also has his own considerations, he suggests keeping the code
> > > > as it is.
> > > > 
> > > > The link below is our detailed discussion on this issue:
> > > 
> > > There's misunderstanding here.
> > > 
> > > Firstly I said I have concern about the patch, I didn't NACK or reject the patch.
> > > 
> > > [PATCH 3/3] crash_core: fix and simplify the logic of crash_exclude_mem_range()
> > > 
> > > Usually, when people said he/she had concern, you may need to
> > > investigate and resolve it or explain why it's not need be cared about.
> > > 
> > > E.g on above [PATCH 3/3], we can add below code change to stop scanning
> > > when the left ranges are all above the excluded range, assume the passed
> > > in cmem has a ascending order of ranges. Say so because I checked code
> > > and found that crash_exclude_mem_range() is called in arch arm64, ppc,
> > > riscv and x86. Among them, arm64 and ppc create the cmem from memblock,
> > > riscv and x86 create cmem from iomem. All of them should be in ascending
> > > ordr. The below code change based on your patch 3/3 looks safe to me.
> > > What do you think?
> > > 
> > > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > > index aab342c2a5ee..39b6c149dc80 100644
> > > --- a/kernel/crash_core.c
> > > +++ b/kernel/crash_core.c
> > > @@ -574,9 +574,12 @@ int crash_exclude_mem_range(struct crash_mem *mem,
> > >  		p_start = mstart;
> > >  		p_end = mend;
> > >  
> > > -		if (p_start > end || p_end < start)
> > > +		if (p_start > end)
> > >  			continue;
> > >  
> > > +		if (p_end < start)
> > > +			break;
> > > +
> > >  		/* Truncate any area outside of range */
> > >  		if (p_start < start)
> > >  			p_start = start;
> > > 
> > > Secondly, I welcome people who are interested kexec/kdump code, and raise
> > > issues or post patches to fix bug, clean up code. I like these patches.
> > > They can help improve kexec/kdump code and solve problem in advance.
> > > I would like to review and make the patches acceptable and merged
> > > inally. And I also hope people can follow the later issue reported by
> > > other people or LKP if their merged patch caused that.
> > > 
> > > Lastly, people are encouraged to help review other people's patch
> > > and give suggestes to improve the code change. If patch author don't
> > > respond for a long while or the work has been suspended for long time, we
> > > can add comment to tell and take over the work to continue.
> > > 
> > > These are my personal understanding and thought about kexec/kdump patch
> > > reviewing and maintance. So cheer up.
> > > 
> > > > 
> > > > https://lore.kernel.org/lkml/20231214163842.129139-3-ytcoode@gmail.com/t/#mfd78a97e16251bcb190b0957a0b6cb4b0a096b54
> > > > 
> > > > The final decision on whether to apply that patch is up to you and Baoquan, if
> > > > you choose to apply that patch, this patch can be ignored. But if you decide not
> > > > to apply that patch, then this patch must be applied, as it fixes a bug in the
> > > > crash_exclude_mem_range() function.
> > > > 
> > > > Sincerely,
> > > > Yuntao
> > 
> > Hi Baoquan,
> > 
> > I must clarify that I was not complaining about you. On the contrary, I am
> > grateful to everyone who takes time to review code for others, because I know
> > it is a lot of work.
> > 
> > I'm relatively new to the Linux community and still learning the various rules
> > of the community. I'm very sorry that I didn't fully grasp your previous intention.
> > 
> > Regarding the method you suggested to add a 'break', I did consider it initially
> > but later decided against it because the memory ranges obtained from iomem may
> > overlap, so I chose a safer way instead.
> 
> In iomem, parent range includes children's range, while
> walk_system_ram_res() traverses ranges not overlapped with each otehr.
> From code in __walk_iomem_res_desc() and find_next_iomem_res(), it
> clearly shows that.
> 
> walk_system_ram_res()
>   -->__walk_iomem_res_desc()
>      -->find_next_iomem_res()
> 

I revisited the relevant code, and yes, you are correct. The memory ranges
obtained from iomem do not overlap.

The reason why I thought these memory ranges would overlap was that I saw
that in the find_next_iomem_res() function, after traversing a parent node,
it starts to traverse its child nodes. If all these nodes meet our
requirements, then the memory ranges they represent will overlap.

However, I overlooked a very important point, which is that after finding a
valid node, the __walk_iomem_res_desc() function will update the start value.
This means that if a parent node is a valid node, all of its child nodes
will be skipped. This ultimately ensures that the memory ranges obtained
from iomem will not overlap.

I will post another patch later, optimizing crash_exclude_mem_range() using
your approach.

> 
> > 
> > Finally, I would like to apologize again if my previous response offended you.
> > That was not my intention.
> 
> No offence felt at all, and no worry about this. In upstream, argument
> is normal, it's fine as long as your intention is making things better,
> not against person. Meantime, let's be kind and friendly to each other,
> we will have a great time.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

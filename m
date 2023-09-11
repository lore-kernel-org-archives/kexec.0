Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86ACEE49A4
	for <kexec@archiver.kernel.org>; Mon, 11 Sep 2023 02:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DmUQQRwQn+sr6cRAmUiWPSLHm3u6R28X9DacIiQy/NY=; b=s2724nkreCv0ru
	aCV1FV0YaxcNlUtP/+03H25cpotPCHPQjmccXtahlectfBZKFYJhYmbvAtZHEpRgg3VVah16cnscH
	0n7kGg2KUT0vCFuvfoziDdunoVOIckorypSVBOGH/0jrmEU8U934FbjjXsGihBOAwlt6Q5ecARe+f
	jyuRbxqsl7kax/S8G0jVcFbXGptqW4nXyUvEURzXA4695Ujpb1zR8wt5/4mDd0n+bR4i90GtPl62t
	zfmL9QYO0cns6OTx4y+a8VRFm9/7NkdQU8VzTuxgzrr3rzSCuwcvJBHCZYle8FKa6ohpKa2I69LNV
	V0zi364BKCpdtNYZnVKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfWOi-00H56X-1Q;
	Mon, 11 Sep 2023 02:11:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfWOc-00H55p-2t
	for kexec@lists.infradead.org;
	Mon, 11 Sep 2023 02:11:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694398286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mjb3hdzORQdy0trp+gr35cXqM14i405hB8hckdOimd4=;
	b=IA/d8zg1P3H2tyogdZr5NMrXJDhYRzazHQtxaK4Mzm6HjpE46MoKZ8n0BBBsDi6RiZYApL
	GAuHvluD/LxAhpgypVVYLomGCBE9hugXWefnP0yLxhWjgyYGEwskLKhm2nk7XJkFCxKWrt
	diSQ8D7RTP1lgPPqXq+V195mIJkdEVQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-ysgnE0wQPCqLPd2fK3TVMw-1; Sun, 10 Sep 2023 22:11:21 -0400
X-MC-Unique: ysgnE0wQPCqLPd2fK3TVMw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF9DD29AB3FF;
	Mon, 11 Sep 2023 02:11:20 +0000 (UTC)
Received: from localhost (unknown [10.72.112.35])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AAE5C2015CFF;
	Mon, 11 Sep 2023 02:11:19 +0000 (UTC)
Date: Mon, 11 Sep 2023 10:11:16 +0800
From: Baoquan He <bhe@redhat.com>
To: "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	catalin.marinas@arm.com, thunder.leizhen@huawei.com,
	dyoung@redhat.com, prudo@redhat.com, samuel.holland@sifive.com,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	x86@kernel.org
Subject: Re: [PATCH v2 3/8] crash_core: change parse_crashkernel() to support
 crashkernel=,high|low parsing
Message-ID: <ZP53RL/6PdxLLh7a@MiWiFi-R3L-srv>
References: <20230829121610.138107-1-bhe@redhat.com>
 <20230829121610.138107-4-bhe@redhat.com>
 <c4a1f96e-2c8d-a496-61f3-0299d77c5c84@huaweicloud.com>
 <ZPGzlIkXqVThTwjg@MiWiFi-R3L-srv>
 <2b9af1b7-8d80-46b7-d582-156a97456a36@huaweicloud.com>
 <ZPbm5SwHOhiAtG7w@MiWiFi-R3L-srv>
 <58a0c4be-0302-04e0-8723-df37407884a8@huaweicloud.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <58a0c4be-0302-04e0-8723-df37407884a8@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230910_191127_007037_FFF2E6E5 
X-CRM114-Status: GOOD (  30.40  )
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

On 09/06/23 at 05:07pm, Leizhen (ThunderTown) wrote:
> 
> 
> On 2023/9/5 16:29, Baoquan He wrote:
> > On 09/04/23 at 10:47am, Leizhen (ThunderTown) wrote:
> >>
> >>
> >> On 2023/9/1 17:49, Baoquan He wrote:
> >>>>> +
> >>>>> +		*high = true;
> >>>>> +	} else if (ret || !*crash_size) {
> >>>> This check can be moved outside of #ifdef. Because even '!high', it's completely
> >>>> applicable. The overall adjustment is as follows:
> >>> Hmm, the current logic is much easier to understand. However, I may not
> >>> 100% get your suggestion. Can you paste the complete code in your
> >>> suggested way? Do not need 100% correct code, just the skeleton of code logic
> >>> so that I can better understand it and add inline comment.
> >>
> >> int __init parse_crashkernel(...)
> >> {
> >> 	int ret;
> >>
> >> 	/* crashkernel=X[@offset] */
> >> 	ret = __parse_crashkernel(cmdline, system_ram, crash_size,
> >> 				crash_base, NULL);
> >>
> >> #ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> >> 	if (high && ret == -ENOENT) {
> >> 		... ...		//The code for your original branch "else if (ret == -ENOENT) {"
> >> 		ret = 0;	//Added based on the next discussion
> >> 	}
> >> +#endif
> >>
> >>  	if (!*crash_size)
> >> 		ret = -EINVAL;
> >>
> >> 	return ret;
> >> }
> >>
> > Thanks, Zhen Lei.
> > 
> > I paste the whole parse_crashkernel() as you suggested at bottom. Please
> > check if it's what you want. 
> 
> Yes.
> 
> > To me, both is fine to me. I have two minor
> > concerns to your suggested way.
> > 
> > 1)
> > I took the "if (!high) return" way because except of x86/arm64, all
> > other architectures will call parse_crashkerne() and check
> > if *crash_size ==0. Please try 'git grep "parse_crashkernel(" arch'
> > and check those call sites. With that, we will have duplicated checking.
> 
> Add some patches to remove the duplicated checking of other ARCHs? After this
> patch series upstreamed.

I resisted this in the first place, after rethinking, it makes sense.
parse_crashkernel() returning 0 indicates a meaningful crashkernel vlaue
parsed, otherwise non-zero. I will go with this.

> 
> > 
> >         ret = __parse_crashkernel(cmdline, system_ram, crash_size,
> >                                 crash_base, NULL);
> >         if (!high)
> >                 return ret;
> > 2)
> > I actually like below branch and the code comment. It can give people
> > hint about what's going on in that case. Discarding it is a little pity.
> 
> Except that "!*crash_size" and "(high && ret == -ENOENT)" needs special comments,
> other common errors do not need to be described, I think. Even if some is required,
> it should be placed in function __parse_crashkernel().

Hmm, I will consider how to comment these better, will update and post
v3.

Thanks, Lei.

> 
> > 
> >         } else if (ret || !*crash_size) {
> >                 /* The specified value is invalid */
> >                 return -1;
> >         }
> > 
> > int __init parse_crashkernel(...)
> > {
> > 	int ret;
> > 
> > 	/* crashkernel=X[@offset] */
> > 	ret = __parse_crashkernel(cmdline, system_ram, crash_size,
> > 				crash_base, NULL);
> > #ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> > 	if (high && ret == -ENOENT) {
> > 		ret = __parse_crashkernel(cmdline, 0, crash_size,
> > 				crash_base, suffix_tbl[SUFFIX_HIGH]);
> > 		if (ret || !*crash_size)
> > 			return -EINVAL;
> > 
> > 		/*
> > 		 * crashkernel=Y,low can be specified or not, but invalid value
> > 		 * is not allowed.
> > 		 */
> > 		ret = __parse_crashkernel(cmdline, 0, low_size,
> > 				crash_base, suffix_tbl[SUFFIX_LOW]);
> > 		if (ret == -ENOENT) {
> > 			*low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> > 			ret = 0;
> > 		} else if (ret) {
> > 			return ret;
> > 		}
> > 
> > 		*high = true;
> > 	}
> > #endif
> > 
> > 	if (!*crash_size)
> > 		ret = -EINVAL;
> > 
> > 	return ret;
> > }
> > 
> > .
> > 
> 
> -- 
> Regards,
>   Zhen Lei
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

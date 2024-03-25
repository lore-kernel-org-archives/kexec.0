Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19261C47DD9
	for <kexec@archiver.kernel.org>; Mon, 25 Mar 2024 01:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KlsilFs53e3oqCSQUBlucoiNzkFUjqp9UiRCo0xs7uE=; b=MbT9xrK5t60xhx
	eqXYrAm+X5NEmrJx13lHGa00uTrij47pxwzzT3FEaZiiTIuHnmxJbAZVkyn9y93v1Uj56rKatV7SI
	Du8M3zIytIL04XdyDNmqZXp5k0I3tZj/5VScAAonheDUxfT7dhvNgIeyeJXnjCfPKy+i2XHqf+618
	6WmOuev/b0Km1GSLi1td3Gwd6YzIK/Z2fiY0NmEku6BPpuqMHMqrTQk9Jkx40LUFL8nd6bAb8Ek0a
	e9QFpgrbXZcgU+mswFe7/KYTo06BAnE4oKBSx/GbaPCj3dc5E+SWl/q8hoHLlHTYWifq/vaZF7WAd
	OkhDMgdd/pv60mF2Qmnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roZMJ-0000000ESf2-1Yi5;
	Mon, 25 Mar 2024 01:42:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roZMC-0000000ESaG-3zIf
	for kexec@lists.infradead.org;
	Mon, 25 Mar 2024 01:42:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711330955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HJ+1YtdvUOwXvTS2idsRTnR4T3Z82MELgPYzRzwYWno=;
	b=ONbvOa8cuoTzj1hmmSu002E6PdC+Q7UUH3h0ZROUvql/IFQS+8dLRW/f3j207b0oq+tjND
	haFIvehmWN9ZmG2t4Vzvd6QGVUmlykqTd5AIQYELY/o4AnWgaW8/ZjYQ0hy76nvHHgH1fP
	mgJ6sfoOLQNLADUBVhqXNAr6S1uqm5Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-7B4C85FnPf2LuTKx9ZHYvQ-1; Sun,
 24 Mar 2024 21:42:29 -0400
X-MC-Unique: 7B4C85FnPf2LuTKx9ZHYvQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F2253802AC6;
	Mon, 25 Mar 2024 01:42:29 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BE7361121313;
	Mon, 25 Mar 2024 01:42:27 +0000 (UTC)
Date: Mon, 25 Mar 2024 09:42:20 +0800
From: Baoquan He <bhe@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	akpm@linux-foundation.org, chenhuacai@loongson.cn,
	dyoung@redhat.com, jbohac@suse.cz, lihuafei1@huawei.com,
	chenhaixiang3@huawei.com
Subject: Re: [PATCH] crash: use macro to add crashk_res into iomem early for
 specific arch
Message-ID: <ZgDWfMctnoLfAUa3@MiWiFi-R3L-srv>
References: <20240324033513.1027427-1-bhe@redhat.com>
 <Zf+m4YtKtmdrjw4Q@gmail.com>
 <Zf/51a+QonYj6sI7@MiWiFi-R3L-srv>
 <ZgAAIB6H+7+t7YpW@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZgAAIB6H+7+t7YpW@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240324_184237_679066_A2C0198A 
X-CRM114-Status: GOOD (  21.81  )
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

On 03/24/24 at 11:27am, Ingo Molnar wrote:
> 
> * Baoquan He <bhe@redhat.com> wrote:
> 
> > On 03/24/24 at 05:06am, Ingo Molnar wrote:
> > > 
> > > * Baoquan He <bhe@redhat.com> wrote:
> > > 
> > ......snip
> > > > ---
> > > >  arch/x86/include/asm/crash_reserve.h | 2 ++
> > > >  kernel/crash_reserve.c               | 7 +++++++
> > > >  2 files changed, 9 insertions(+)
> > > > 
> > > > diff --git a/arch/x86/include/asm/crash_reserve.h b/arch/x86/include/asm/crash_reserve.h
> > > > index 152239f95541..4681a543eba3 100644
> > > > --- a/arch/x86/include/asm/crash_reserve.h
> > > > +++ b/arch/x86/include/asm/crash_reserve.h
> > > > @@ -39,4 +39,6 @@ static inline unsigned long crash_low_size_default(void)
> > > >  #endif
> > > >  }
> > > >  
> > > > +# define HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
> > > > +
> > > 
> > > Any reason for that stray space?
> > 
> > No clear reason. I saw stray space was added for macro definning when my
> > below patch was merged, not sure if this is preferred.
> 
> No, it's not preferred - and I don't see any stray spaces added in the 
> code added by:
> 
> > commit 85fcde402db1 ("kexec: split crashkernel reservation code out from crash_core.c")

Ah, the stray spaces are added in below macros defining, I thought they
are all the same. I didn't know nested/conditional defines and
standalone defines are different. Thanks for careful checking and telling.

arch/x86/include/asm/crash_reserve.h:
#ifdef CONFIG_X86_32
# define CRASH_ADDR_LOW_MAX     SZ_512M
# define CRASH_ADDR_HIGH_MAX    SZ_512M
#else
# define CRASH_ADDR_LOW_MAX     SZ_4G
# define CRASH_ADDR_HIGH_MAX    SZ_64T
#endif

> 
> Anyway, please just remove it.

Sure, will update and v2.

> 
> > And there are a lot of "# define " when searching with 'git grep "# 
> > define " arch/x86/include/'.
> 
> The overwhelming majority of those are not standalone defines like 
> yours, but nested/conditional defines where the space is justified:
> 
> #ifdef CONFIG_X86_32
> # define MAX_IO_APICS 64
> # define MAX_LOCAL_APIC 256
> #else
> # define MAX_IO_APICS 128
> # define MAX_LOCAL_APIC 32768
> #endif
> 
> Thanks,
> 
> 	Ingo
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

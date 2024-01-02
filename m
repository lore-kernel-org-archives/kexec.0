Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5440DC46CD2
	for <kexec@archiver.kernel.org>; Tue,  2 Jan 2024 08:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LPu6j07kDras0U2BN0MwLXEEJjxX+wnVGwLMigv/PVQ=; b=f3vZjsvxKMxdRA
	w6HIiqnIY8bp3J0pQ36OHdNSGQsGnWv35m0L9NX3Jyh7W2RHwlPitNcCfh1tbtNXAcDggTlykjhTS
	zB/wCgFfV+oDBP+v965guFkzmu0NJbgjUMBuv9jIMcDbW8QCUePo44iMv6tV+5b23Tqdv4wE6Y6XS
	bWGGsykHPhL2s5GzFEJLvgF4YaZKNTMHdTiEGHFlx72d5uYzL0O1bGXuMesFl9+xZDNniBZsIbC6w
	c0V/+BhE9r0JwIQ6ZdjW+bMF6z/9ah8Kb0AZSteAEBq+fYGHeCvjNkHSjW4R4Fqtj0JoqMh+azGyU
	22Yw4p2EJTb9zh24sKPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKaLA-007Mew-0l;
	Tue, 02 Jan 2024 08:41:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKaL4-007MeQ-2z
	for kexec@lists.infradead.org;
	Tue, 02 Jan 2024 08:41:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704184886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9deNeZJNUQtUZJSaXTSS5TWxhTaiDOSx9nA+IbokTkw=;
	b=JSz+CKa1SMpYiK2DT1syCeZwpHGJiGYt/5r9WN9HVTPWAGgpyUC26vaU51SIuAijIDN39F
	hhRLmTy0q2AFstmJUAX4GneZGtkIFBVlQo69lE12OiK+aEBgeeuK8wd5my7XyjDx3YUoFw
	/EDOSLMWWw7SEgSEGFZWyXddpdY4tXU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-v1563Ci_PTOWBkrNbLVl9Q-1; Tue, 02 Jan 2024 03:41:23 -0500
X-MC-Unique: v1563Ci_PTOWBkrNbLVl9Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42B8A80BEC1;
	Tue,  2 Jan 2024 08:41:22 +0000 (UTC)
Received: from localhost (unknown [10.72.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 796031121306;
	Tue,  2 Jan 2024 08:41:20 +0000 (UTC)
Date: Tue, 2 Jan 2024 16:41:17 +0800
From: Baoquan He <bhe@redhat.com>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, bp@alien8.de,
	dave.hansen@linux.intel.com, dyoung@redhat.com,
	eric.devolder@oracle.com, hbathini@linux.ibm.com, hpa@zytor.com,
	kexec@lists.infradead.org, lijiang@redhat.com,
	linux-kernel@vger.kernel.org, mingo@redhat.com, seanjc@google.com,
	sourabhjain@linux.ibm.com, tglx@linutronix.de, tiwai@suse.de,
	vgoyal@redhat.com, x86@kernel.org
Subject: Re: [PATCH 3/3] crash_core: fix and simplify the logic of
 crash_exclude_mem_range()
Message-ID: <ZZPMLextp0n3lwbD@MiWiFi-R3L-srv>
References: <ZXxtfpXpuFXLd+ge@MiWiFi-R3L-srv>
 <20231216015410.188924-1-ytcoode@gmail.com>
 <ZX0Z+IyaAX9lNSok@MiWiFi-R3L-srv>
 <20231229121052.cac37914c7a051b829fcf933@linux-foundation.org>
 <ZY/uBJmpG14Ogvet@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZY/uBJmpG14Ogvet@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240102_004131_042353_F42BE57B 
X-CRM114-Status: GOOD (  30.82  )
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

Hi Yuntao,

On 12/30/23 at 06:16pm, Baoquan He wrote:
> On 12/29/23 at 12:10pm, Andrew Morton wrote:
> > On Sat, 16 Dec 2023 11:31:04 +0800 Baoquan He <bhe@redhat.com> wrote:
> > 
> > > > > Imagine we have a crashkernel region 256M reserved under 4G, say [2G, 2G+256M].
> > > > > Then after excluding the 256M from a region, it should stop. But now, this patch
> > > > > will make it continue scanning. Not sure if it's all in my mind.
> > > > 
> > > > Hi Baoquan,
> > > > 
> > > > Thank you for such a detailed reply. Now I finally understand why the code is
> > > > written this way.
> > > > 
> > > > However, if we can guarantee its correctness, wouldn't it be better to use the
> > > > generic region removing logic? At least it is more concise and clear, and other
> > > > people reading this code for the first time wouldn't get confused like me.
> > > > 
> > > > As for your concern about the while loop, I think it wouldn't affect performance
> > > > much because the total number of loops is small.
> > > 
> > > Well, see below kexec-tools commit, you wouldn't say that. And when you
> > > understand the code, you will feel a little uncomfortable about the
> > > sustaining useless scanning. At least, we should stop scanning after
> > > needed exluding is done.
> > > 
> > > Or, we may need add a generic region removing function so that it
> > > can be shared, e.g e820 memory region removing, memblock region removing.
> > > Otherwise, I can't see why a specific region excluding need a generic 
> > > region removing function.
> > 
> > So where do we now stand on this patchset?
> 
> The patch 1 and 2 are good clean up. The patch 3 plus below one, the
> entire is a good code improvement patch.
> 
> [PATCH] crash_core: optimize crash_exclude_mem_range()
> https://lore.kernel.org/all/20231219163418.108591-1-ytcoode@gmail.com/T/#u

Can you repost this patchset with some updating, e.g adding ack in patch
1 and 2, and squash below patch into patch 3? This will be easier for
patch merging.

[PATCH] crash_core: optimize crash_exclude_mem_range()
https://lore.kernel.org/all/20231219163418.108591-1-ytcoode@gmail.com/T/#u

And, you may need to drop below patchset since patch 2 conflicts with
this patchset, and patch 1 is conflicting with fuqiang's patch.

[PATCH 0/2] crash: fix potential cmem->ranges array overflow

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

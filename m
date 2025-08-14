Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A371CA0EE9
	for <kexec@archiver.kernel.org>; Thu, 14 Aug 2025 09:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e46B2FI/PagtxjUFemCdMQXhTSnu4yC2Ildyjyftxdo=; b=CExNjtbuAvXCbQNHeuJ4QXdS7B
	1dXbGCtwfEHTjyvlQJ/fnl4oQnTo5jyR7prInvCF5OikfY1uA53FWejN0+GxtLhlYSFUPATDfDg2o
	vAE2Tm0vayLkrX20NeS0QV9Q5MgLnu8d79hm5hTSEqzLULCPLzCKPhcyAN2bSPyKBh1FVyHMDbsuE
	k+YQKIbOKO5hRmzMQtoKalUiVnqcMuvnXi5zgrxYSyzRmJMElLygPAi1T5O0L3G/qPt5P6H2CP5Rl
	yA+QZ+E9epg6K/EzbOaRjM4B91VDBn/qBgG8DYCqUIkHSYaoFuCMXiN/X4KZ+UNrYqlJbwUxO8BQI
	vVF7+RZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umUUR-0000000GRQf-3gGE;
	Thu, 14 Aug 2025 09:43:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umTkx-0000000GJcb-3UVG
	for kexec@lists.infradead.org;
	Thu, 14 Aug 2025 08:56:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755161778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e46B2FI/PagtxjUFemCdMQXhTSnu4yC2Ildyjyftxdo=;
	b=TIGQNDNhiEkeQLSjQkA1iXb6ZfO1w/Te5oFDCpL4V160bKnf52vu45rglzNwPDqQuGTpRo
	PGhz8SEPYypyP3KDVtIR+Rh2qPEviAe00c5iw9TXJJTcPTTfY7PuxUMivVYvWtKNONgiqv
	H0yYrEhqxkTE666ZBK7pVj5X7pnEG/M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-3SOjFLgDMcqA9Xa_jao8Yg-1; Thu,
 14 Aug 2025 04:56:13 -0400
X-MC-Unique: 3SOjFLgDMcqA9Xa_jao8Yg-1
X-Mimecast-MFC-AGG-ID: 3SOjFLgDMcqA9Xa_jao8Yg_1755161771
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EEB141956060;
	Thu, 14 Aug 2025 08:56:10 +0000 (UTC)
Received: from localhost (unknown [10.72.112.89])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B73811800446;
	Thu, 14 Aug 2025 08:56:08 +0000 (UTC)
Date: Thu, 14 Aug 2025 16:56:04 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com,
	dvyukov@google.com, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	sj@kernel.org, lorenzo.stoakes@oracle.com, elver@google.com,
	snovitoll@gmail.com
Subject: Re: [PATCH v2 00/12] mm/kasan: make kasan=on|off work for all three
 modes
Message-ID: <aJ2kpEVB4Anyyo/K@MiWiFi-R3L-srv>
References: <20250812124941.69508-1-bhe@redhat.com>
 <CA+fCnZcAa62uXqnUwxFmDYh1xPqKBOQqOT55kU8iY_pgQg2+NA@mail.gmail.com>
 <CA+fCnZdKy-AQr+L3w=gfaw9EnFvKd0Gz4LtAZciYDP_SiWrL2A@mail.gmail.com>
 <aJxzehJYKez5Q1v2@MiWiFi-R3L-srv>
 <CA+fCnZfv9sbHuRVy8G9QdbKaaeO-Vguf7b2Atc5WXEs+uJx0YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZfv9sbHuRVy8G9QdbKaaeO-Vguf7b2Atc5WXEs+uJx0YQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250814_015619_938946_E2185AC8 
X-CRM114-Status: GOOD (  23.81  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 08/14/25 at 07:23am, Andrey Konovalov wrote:
> On Wed, Aug 13, 2025 at 1:14 PM 'Baoquan He' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > > I'm not familiar with the internals of kdump, but would it be
> > > possible/reasonable to teach kdump to ignore the KASAN shadow region?
> >
> > Yes, we can teach kdump to do that. Then people may hate those conditional
> > check "if (is_kdump_kernel())" being added in kasan code. E.g even
> > though we skip kasan_init(), we still need to check is_kdump_kernel()
> > in kasan_populate_vmalloc(), right?
> >
> > Combined with the existing kasan_arch_is_ready(), it will make kasan code
> > ugly. I planned to add kasan_enabled() via static key
> > kasan_flag_enabled, then it can also easily remove kasan_arch_is_ready()
> > cleanly.
> 
> What I had in mind was something different: into the kdump code, we
> add a check whether the region of memory it's trying to dump is the
> KASAN shadow, and make kdump not to dump this region.

Ah, I got what you mean. We probably are saying different things.

In order to record memory content of a corrupted kernel, we need reserve
a memory region during bootup of a normal kernel (usually called 1st
kernel) via kernel parameter crashkernel=nMB in advance. Then load
kernel into the crashkernel memory region, that means the region is not
usable for 1st kernel. When 1st kernel collapsed, we stop the 1st kernel
cpu/irq and warmly switch to the loaded kernel in the crashkernel memory
region (usually called kdump kernel). In kdump kernel, it boots up and
enable necessary features to read out the 1st kernel's memory content,
we usually use user space tool like makeudmpfile to filter out unwanted
memory content.

So this patchset intends to disable KASAN to decrease the crashkernel
meomry value because crashkernel is not usable for 1st kernel. As for
shadow memory of 1st kernel, we need recognize it and filter it away
in makedumpfile. 

> 
> Would this work? Would this help with the issue you have?
> 
> (I assume the problem is with the virtual region that is the shadow
> memory, as kdump would dump all RAM either way? If not, please clarify
> what how does the "heavy burden" that the shadow memory causes
> manifests.)
> 
> Thank you!
> 



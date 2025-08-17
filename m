Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88917CA0EDC
	for <kexec@archiver.kernel.org>; Sun, 17 Aug 2025 03:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Y0oXgvbJlVAXUapKet03fj1MIE/RRaWOW5OiNzH2oU=; b=H/47hoFcFzP07fnE0mtJIymVkb
	5f9fFZHUA1UDWOEwy1Ix0u//W28gTMmmfQPfmNJRME3oauWdPuXZ2Cb1vqsu0KxzyPjsBi7UfNiyr
	01XTp0iFt1+e2hDNjCaOyuGqwYvg0LRlJMMe8DxT9nhNDsID2wIC75R9WXS4BXqLNtjvUXqDgJYFh
	IRAhQ5ffZ5riZMxD1E/Jd4Nl24NeRs53W4fjGqNIwPsQeOAq1vEtnfPYLD/Kez4pJzgdlpKWHjr/7
	ElWVWsp/ufgChtvPsd/8C42WvO9zA9f4wBJtu+1rrjGdrHm5Mp+iGfM+BffJsFWarBahkB17I+uBp
	ZtVwxKHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unUGe-00000005JkT-0ztK;
	Sun, 17 Aug 2025 03:41:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unUGV-00000005Jjg-18wR
	for kexec@lists.infradead.org;
	Sun, 17 Aug 2025 03:41:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755402059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Y0oXgvbJlVAXUapKet03fj1MIE/RRaWOW5OiNzH2oU=;
	b=bqGCi7HMHwUIpZfRR0NB4O3GcNfFZ5RpdRpK0CGGv2FrdZTeT1tG6/wCmtO0YeuUSHbLXp
	Apt773qQbJXOd2C3ElM0IPsvgqq++W0SdKzULU+xzVk052Obtw8gsWBG8yZJupq4TvrXZD
	VnRZimggtjHIqaSfthlBDnmLtRnOYWc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-PkT_4EHSPaqREfWT33cFVQ-1; Sat,
 16 Aug 2025 23:40:55 -0400
X-MC-Unique: PkT_4EHSPaqREfWT33cFVQ-1
X-Mimecast-MFC-AGG-ID: PkT_4EHSPaqREfWT33cFVQ_1755402053
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 544231800340;
	Sun, 17 Aug 2025 03:40:53 +0000 (UTC)
Received: from localhost (unknown [10.72.112.34])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5A23180044F;
	Sun, 17 Aug 2025 03:40:50 +0000 (UTC)
Date: Sun, 17 Aug 2025 11:40:46 +0800
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
Message-ID: <aKFPPi2sti7+3JZ9@MiWiFi-R3L-srv>
References: <20250812124941.69508-1-bhe@redhat.com>
 <CA+fCnZcAa62uXqnUwxFmDYh1xPqKBOQqOT55kU8iY_pgQg2+NA@mail.gmail.com>
 <CA+fCnZdKy-AQr+L3w=gfaw9EnFvKd0Gz4LtAZciYDP_SiWrL2A@mail.gmail.com>
 <aJxzehJYKez5Q1v2@MiWiFi-R3L-srv>
 <CA+fCnZfv9sbHuRVy8G9QdbKaaeO-Vguf7b2Atc5WXEs+uJx0YQ@mail.gmail.com>
 <aJ2kpEVB4Anyyo/K@MiWiFi-R3L-srv>
 <CA+fCnZcdSDEZvRSxEnogBMCFg1f-PK7PKx0KB_1SA0saY6-21g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZcdSDEZvRSxEnogBMCFg1f-PK7PKx0KB_1SA0saY6-21g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250816_204103_697916_3E75C77A 
X-CRM114-Status: GOOD (  19.38  )
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

On 08/16/25 at 06:50am, Andrey Konovalov wrote:
> On Thu, Aug 14, 2025 at 10:56 AM Baoquan He <bhe@redhat.com> wrote:
> >
> > Ah, I got what you mean. We probably are saying different things.
> >
> > In order to record memory content of a corrupted kernel, we need reserve
> > a memory region during bootup of a normal kernel (usually called 1st
> > kernel) via kernel parameter crashkernel=nMB in advance. Then load
> > kernel into the crashkernel memory region, that means the region is not
> > usable for 1st kernel. When 1st kernel collapsed, we stop the 1st kernel
> > cpu/irq and warmly switch to the loaded kernel in the crashkernel memory
> > region (usually called kdump kernel). In kdump kernel, it boots up and
> > enable necessary features to read out the 1st kernel's memory content,
> > we usually use user space tool like makeudmpfile to filter out unwanted
> > memory content.
> >
> > So this patchset intends to disable KASAN to decrease the crashkernel
> > meomry value because crashkernel is not usable for 1st kernel. As for
> > shadow memory of 1st kernel, we need recognize it and filter it away
> > in makedumpfile.
> 
> Ah, I see, thank you for the explanation!
> 
> So kdump kernel runs with the amount of RAM specified by crashkernel=.
> And KASAN's shadow memory increases RAM usage, which means
> crashkernel= needs to be set to a higher value for KASAN kernels. Is
> my understanding of the problem correct?

Yeah, you are quite right.

When I tested it, on x86_64 and arm64, usually I set crashkernel=256M
and it's sufficient. However, when KASAN is enabled and generic mode is
taken, I need set crashkernel=768M to make vmcore dumping succeed. In
kdump kernel, read_vmcore() uses ioremap to map the old memory of
collapsed kernel for reading out, those vmalloc-ed areas are lazily
freed and cause more shadow memory than what we usually think shadow
memory only costs 1/8 of physical RAM.



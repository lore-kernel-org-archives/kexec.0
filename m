Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C7A9C4167B
	for <kexec@archiver.kernel.org>; Wed, 13 Dec 2023 00:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1EVlHV+5O9ttJqHjTIcr9VBvoTVviLi2mk0Wa4mxtIo=; b=ELUvOq/AuVd9Zm
	e6aUUMU7FerX/h29r0opnHx/z/Eds3do4LkyOWgx3vLSpVwfJJGLT6LJpN29b9Hh+um3L059d9F9G
	7Fg8UzO+MpsssVWWlPFu+NwoO6Pvear4fcBn0yfk009EaMx1TYIStBmXSrsC88t0mol1Xm+WmErvd
	e9zWV7gJzKZ4Nw6eJLtNTdDIJZgt8cFuKEOncQKjw7F2lNtpgFKVv6xmdvAeDiSR4Y0fcRewcvmky
	M6/8836gffU+JGHIFrIlBBmJvfDpNGY145wnUgkHfhV79OmqFTG+KUOLwV5f1avXcFwXAq7YQp6l3
	i4CrYulqW9uKUpIHbTcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDDM7-00DDbB-2p;
	Wed, 13 Dec 2023 00:44:07 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDDM5-00DDZO-0O;
	Wed, 13 Dec 2023 00:44:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 93A08CE1C64;
	Wed, 13 Dec 2023 00:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D94C433C8;
	Wed, 13 Dec 2023 00:43:58 +0000 (UTC)
Date: Tue, 12 Dec 2023 19:44:41 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexander Graf <graf@amazon.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <kexec@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <x86@kernel.org>, Eric Biederman
 <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rob Herring
 <robh+dt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mark
 Rutland <mark.rutland@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>,
 "Stanislav Kinsburskii" <skinsburskii@linux.microsoft.com>,
 <arnd@arndb.de>, <pbonzini@redhat.com>, <madvenka@linux.microsoft.com>,
 Anthony Yznaga <anthony.yznaga@oracle.com>, Usama Arif
 <usama.arif@bytedance.com>, "David Woodhouse" <dwmw@amazon.co.uk>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 08/15] tracing: Introduce names for ring buffers
Message-ID: <20231212194441.2701c48b@gandalf.local.home>
In-Reply-To: <eb567d99-e03b-4718-9cc9-e27c5e408ea2@amazon.com>
References: <20231213000452.88295-1-graf@amazon.com>
	<20231213000452.88295-9-graf@amazon.com>
	<20231212191546.603c0703@gandalf.local.home>
	<eb567d99-e03b-4718-9cc9-e27c5e408ea2@amazon.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231212_164405_381623_0EBB28E1 
X-CRM114-Status: GOOD (  20.10  )
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

On Wed, 13 Dec 2023 01:35:16 +0100
Alexander Graf <graf@amazon.com> wrote:

> > The trace_array is the structure that represents each tracing instance. And
> > it already has a name field. And if you can get the associated ring buffer
> > from that too.
> >
> > struct trace_array *tr;
> >
> >          tr->array_buffer.buffer
> >
> >          tr->name
> >
> > When you do: mkdir /sys/kernel/tracing/instance/foo
> >
> > You create a new trace_array instance where tr->name = "foo" and allocates
> > the buffer for it as well.  
> 
> The name in the ring buffer is pretty much just a copy of the trace 
> array name. I use it to reconstruct which buffer we're actually 
> referring to inside __ring_buffer_alloc().

No, I rather not tie the ring buffer to the trace_array.

> 
> I'm all ears for alternative suggestions. I suppose we could pass tr as 
> argument to ring_buffer_alloc() instead of the name?

I'll have to spend some time (that I don't currently have :-( ) on looking
at this more. I really don't like the copying of the name into the ring
buffer allocation, as it may be an unneeded burden to maintain, not to
mention the duplicate field.

-- Steve

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

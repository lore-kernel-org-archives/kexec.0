Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF05C4167D
	for <kexec@archiver.kernel.org>; Wed, 13 Dec 2023 00:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eYn1yEjLq3UTTkVXWTDgNSzs/FOKHTVFAhuVkWD3iBQ=; b=Kpzz5wkx2x2D1j
	TATs8LrQOIHtCnubBqVGv2f8RcBQfU4lrJnaeXFuZjm7bucvDirbtQmSyBHe2VMFwH971PCQ39A0Y
	8ZV3Gn4rld8juPZAjo+vr0uoq+l23gIU0lPnUpEXbtrZcBEssGiB8jAqyfotHe3ux7C9IA5kgN98x
	utL1y+KahpT64Ua67XryF8cpjtNp2Zdr09lQTqiYQGufkhgXhVrMJxieVPPZF9MB+OYg6l/c+UfvL
	wz+Liy7uPiUfFHPV4YdhVcaEsheGXl08kB+6PI7GNdduQ+HUiGsRrYC8BdeXC5k01b4p5VggatqI2
	YIZNt19XHx1PkpkjhdTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDDR7-00DEKw-0Q;
	Wed, 13 Dec 2023 00:49:17 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDDR4-00DEJg-2U;
	Wed, 13 Dec 2023 00:49:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id EE2BCB81A2B;
	Wed, 13 Dec 2023 00:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864EEC433C8;
	Wed, 13 Dec 2023 00:49:09 +0000 (UTC)
Date: Tue, 12 Dec 2023 19:49:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexander Graf <graf@amazon.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <kexec@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <x86@kernel.org>, Eric Biederman
 <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rob Herring"
 <robh+dt@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, Mark
 Rutland <mark.rutland@arm.com>, "Tom Lendacky" <thomas.lendacky@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
 <pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
 <anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, David
 Woodhouse <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: Re: [PATCH 09/15] tracing: Introduce names for events
Message-ID: <20231212194952.5f6d599b@gandalf.local.home>
In-Reply-To: <20231213000452.88295-10-graf@amazon.com>
References: <20231213000452.88295-1-graf@amazon.com>
	<20231213000452.88295-10-graf@amazon.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231212_164914_960008_1FC20CD6 
X-CRM114-Status: GOOD (  25.31  )
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

On Wed, 13 Dec 2023 00:04:46 +0000
Alexander Graf <graf@amazon.com> wrote:

> With KHO (Kexec HandOver), we want to preserve trace buffers. To parse
> them, we need to ensure that all trace events that exist in the logs are
> identical to the ones we parse as. That means we need to match the
> events before and after kexec.
> 
> As a first step towards that, let's give every event a unique name. That
> way we can clearly identify the event before and after kexec and restore
> its ID post-kexec.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>  include/linux/trace_events.h         |  1 +
>  include/trace/trace_events.h         |  2 ++
>  kernel/trace/blktrace.c              |  1 +
>  kernel/trace/trace_branch.c          |  1 +
>  kernel/trace/trace_events.c          |  3 +++
>  kernel/trace/trace_functions_graph.c |  4 +++-
>  kernel/trace/trace_output.c          | 13 +++++++++++++
>  kernel/trace/trace_probe.c           |  3 +++
>  kernel/trace/trace_syscalls.c        | 29 ++++++++++++++++++++++++++++
>  9 files changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index d68ff9b1247f..7670224aa92d 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -149,6 +149,7 @@ struct trace_event {
>  	struct hlist_node		node;
>  	int				type;
>  	struct trace_event_functions	*funcs;
> +	const char			*name;
>  };

OK, this is a hard no. We definitely need to find a different way to do
this. I'm trying hard to lower the footprint of tracing, and this just
added 8 bytes to every event on a 64 bit machine.

On my box I have 1953 events, and they are constantly growing. This just
added 15,624 bytes of tracing overhead to that machine.

That may not sound like much, but as this is only for this feature, it just
added 15K to the overhead for the majority of users.

I'm not sure how easy it is to make this a config option that takes away
that field when not set. But I would need that at a minimum.

-- Steve


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE63AD15DA8
	for <kexec@archiver.kernel.org>; Mon, 21 Oct 2024 14:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:
	In-Reply-To:Date:References:Cc:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=UWaP1AKlhe2GGgJ20fPpI2X2DAJOebMX22Gq77BSvsM=; b=LGsaNME5+ej4UwX0UdvugOHIVT
	Gg7SNPt9ijvpuOV6bDvaBBre6SvPdf9+cbxZueNGhrL4b14KyDPIDPku68qvwZsBlNzB8Z+cFmkGw
	p89SNUHWaspWYxq3YiMUmJl8o0uiaS6v9sOt3mnUwewOyu0N7JmckRMwe1ImmGnP6Qu/jRAj3EZs8
	OF9THZlwlRbW7sbQg7E6BW165VUc+qrWHB0JRI1KUZQ/PPy7UA+Nn0O01axjqVqZrfnDwI7ZUZix1
	dZPrUSMhKhYttegkTiOt4MKNNXPAcOnopB8qoT3ultlTc3C3DFX1kWl6ucBVuNaMRxwlx0JmUTXUb
	MxPONUHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2trx-00000007hYH-2IMe;
	Mon, 21 Oct 2024 14:58:53 +0000
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2tU2-00000007dEf-0Ebn
	for kexec@lists.infradead.org;
	Mon, 21 Oct 2024 14:34:11 +0000
Received: from in01.mta.xmission.com ([166.70.13.51]:39828)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1t2tTi-00D8Vo-2W; Mon, 21 Oct 2024 08:33:51 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:56464 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1t2tTg-007PNk-VZ; Mon, 21 Oct 2024 08:33:49 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: kexec@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-coco@lists.linux.dev,  x86@kernel.org,  rick.p.edgecombe@intel.com,
  kirill.shutemov@linux.intel.com
References: <20241021034553.18824-1-yan.y.zhao@intel.com>
Date: Mon, 21 Oct 2024 09:33:17 -0500
In-Reply-To: <20241021034553.18824-1-yan.y.zhao@intel.com> (Yan Zhao's message
	of "Mon, 21 Oct 2024 11:45:53 +0800")
Message-ID: <87frop8r0y.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1t2tTg-007PNk-VZ;;;mid=<87frop8r0y.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19A3UgQ6OIzwbePtgXVLHKHHilNY2diWnM=
Subject: Re: [PATCH] kexec_core: Accept unaccepted kexec destination addresses
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: kirill.shutemov@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, yan.y.zhao@intel.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_073410_105408_361738CC 
X-CRM114-Status: GOOD (  30.41  )
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

Yan Zhao <yan.y.zhao@intel.com> writes:

> The kexec destination addresses (incluing those for purgatory, the new
> kernel, boot params/cmdline, and initrd) are searched from the free area of
> memblock or RAM resources. Since they are not allocated by the currently
> running kernel, it is not guaranteed that they are accepted before
> relocating the new kernel.
>
> Accept the destination addresses for the new kernel, as the new kernel may
> not be able to or may not accept them by itself.
>
> Place the "accept" code immediately after the destination addresses pass
> sanity checks, so the code can be shared by both users of the kexec_load
> and kexec_file_load system calls.

I am not at all certain this is sufficient, and I am a bit flummoxed
about the need to ever ``accept'' memory lazily.

In a past life I wrote bootup firmware, and as part of that was the code
to initialize the contents of memory.  When properly tuned and setup it
would never take more than a second to just blast initial values into
memory.  That is because the ratio of memory per memory controller to
memory bandwidth stayed roughly constant while I was paying attention.
I expect that ratio to continue staying roughly constant or systems
will quickly start developing unacceptable boot times.

As I recall Intel TDX is where the contents of memory are encrypted per
virtual machine.  Which implies that you have the same challenge as
bootup initializing memory, and that is what ``accepting'' memory is.

I am concerned that an unfiltered accept_memory may result in memory
that has already been ``accepted'' being accepted again.  This has
the potential to be wasteful in the best case, and the potential to
cause memory that is in use to be reinitialized losing the values
that are currently stored there.

I am concerned that the target kernel won't know about about accepting
memory, or might not perform the work early enough and try to use memory
without accepting it first.

I would much prefer if getting into kexec_load would force the memory
acceptance out of lazy mode (or possibly not even work in lazy mode).
That keeps things simple for now.

Once enough people have machines requiring the use of accept_memory
we can worry about optimizing things and pushing the accept_memory call
down into kexec_load.



Ugh.  I just noticed another issue.  Unless the memory we are talking
about is the memory reserved for kexec on panic kernels the memory needs
struct pages and everything setup so it can be allocated from anyway.

Which is to say I think this is has the potential to conflict with
the accounting in try_to_accept_memory.

Please just make memory acceptance ``eager'' non-lazy when using kexec.
Unless someone has messed their implementation badly it won't be a
significant amount of time in human terms, and it makes the code
so much easier to understand and think about.

Eric


> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
>  kernel/kexec_core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index c0caa14880c3..d97376eafc1a 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -210,6 +210,16 @@ int sanity_check_segment_list(struct kimage *image)
>  	}
>  #endif
>  
> +	/*
> +	 * The destination addresses are searched from free memory ranges rather
> +	 * than being allocated from the current kernel, so they are not
> +	 * guaranteed to be accepted by the current kernel.
> +	 * Accept those initial pages for the new kernel since it may not be
> +	 * able to accept them by itself.
> +	 */
> +	for (i = 0; i < nr_segments; i++)
> +		accept_memory(image->segment[i].mem, image->segment[i].memsz);
> +
>  	return 0;
>  }
>  
> base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

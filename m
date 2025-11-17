Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8186DCE8D6B
	for <kexec@archiver.kernel.org>; Mon, 17 Nov 2025 17:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V09tqgio/5WQGP8FSY1WM0juAmErgLmMVoa8McDMUog=; b=TELK7V8rV/lWF7NeTzklTl2e7A
	dmgkP+3hCP5Ly6ibg5cJhYdmyAikzf2+BBNueGqJaGEVOCxTLJ+KE0DPDg3xKrjZ11u2wjaXnMJ8P
	1HtM1TsSKR0kmxaQRlz0EpI0yRYz609A9Cc/Mpk058d32EOVUOG4KJl2FfNC+anIpCocq6U2o/pHC
	N1ARPqin23McwIDkTzjlivbErO9ntqYD8JBRIpXAkrcWwek7Knf4IRf0Ucx5hHU6N9lI7MhzBmKt0
	JyP0DmLJKuatl2ax7uJcFTfEhqcO7Tnxzr5Yc41F4df6XAmcmspyMbZJBzilXETuiQPbgNdxSS+qT
	4tAFO4pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL3F7-0000000GYVG-2DTH;
	Mon, 17 Nov 2025 17:42:21 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL3F2-0000000GYUM-0izr
	for kexec@lists.infradead.org;
	Mon, 17 Nov 2025 17:42:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 02D5F43994;
	Mon, 17 Nov 2025 17:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5508DC2BC86;
	Mon, 17 Nov 2025 17:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1763401334;
	bh=w0p1v++RTpuyBAjT0eUWhhxTf67ilWlrGRyoUiKT4a4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DQoXvktmxAfHjyepWEkf5wYROY3GpQZtVzvErgZ/AJQSG7rh1jsQznTG7YG2Q3RHC
	 bupEyUy+IQIVzIsm/v6tS8YHFuEDcXkb4xmOZZTGkw2MZIGsRhKxLj+Z4JzNHd4y8C
	 iuT1falMSc5bBEIunhrDSUIPbV14qD+H/leqNoa0=
Date: Mon, 17 Nov 2025 09:42:11 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Aditya Gupta <adityag@linux.ibm.com>,
 Baoquan he <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Hari Bathini
 <hbathini@linux.ibm.com>, Jiri Bohac <jbohac@suse.cz>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Pingfan
 Liu <piliu@redhat.com>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>, Vivek Goyal <vgoyal@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org
Subject: Re: [PATCH v5] crash: export crashkernel CMA reservation to
 userspace
Message-Id: <20251117094211.f8b4426ddda3bc0db5a62624@linux-foundation.org>
In-Reply-To: <20251117041905.1277801-1-sourabhjain@linux.ibm.com>
References: <20251117041905.1277801-1-sourabhjain@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251117_094216_244544_1B04F2A0 
X-CRM114-Status: GOOD (  12.90  )
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

On Mon, 17 Nov 2025 09:49:05 +0530 Sourabh Jain <sourabhjain@linux.ibm.com> wrote:

> Add a sysfs entry /sys/kernel/kexec/crash_cma_ranges to expose all
> CMA crashkernel ranges.
> 
> This allows userspace tools configuring kdump to determine how much
> memory is reserved for crashkernel. If CMA is used, tools can warn
> users when attempting to capture user pages with CMA reservation.
> 
> The new sysfs hold the CMA ranges in below format:
> 
> cat /sys/kernel/kexec/crash_cma_ranges
> 100000000-10c7fffff
> 
> There are already four kexec and kdump sysfs entries under /sys/kernel.
> Adding more entries there would clutter the directory. To avoid this,
> the new crash_cma_ranges sysfs entry is placed in a new kexec node under
> /sys/kernel/.

I suggest not creating /sys/kernel/kexec in this patch.

Moving everything into a new /sys/kernel/kexec is a separate patchset
and a separate concept and it might never be merged - it changes ABI!

So let's put crash_cma_ranges in /sys/kernel and move it to
/sys/kernel/kexec within the other patchset.




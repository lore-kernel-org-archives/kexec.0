Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2532C021B8
	for <kexec@archiver.kernel.org>; Tue,  4 Mar 2025 23:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2vxobnsA6CY2dMVlDe8j0acYq7pZ6YDVxvZLJBE0Jmk=; b=xSb1JU3wCdSxRN3TKDjXE79Lo3
	8CIpX8/C1/qINOkJpVGEWbX6SDgGaaTi1XnBs8bK8MLvvUsNZAASQ3kC2QkT95ktcnEFKoU8ibKG9
	lKrUYYD70Zs18OdfRKBn8tpfEZ/B6NACBbgLGY4I4iEVMTb3s3z5PicON9HXGuqL93NjLFGuGVDQA
	6U6KjS9wKM2RoCVujwXs/XQD9XmHYwOQc7q5PyLUORNcPysYUV4/vAozCfToXc5sH8IcnptZfx582
	MSQ/HRKLhwX/aEk4EbTB8ck9XkqOkyJFIB4OhAdYrOwtpGEtu6+GT9rDRSRed7Q6Y0zfiPIpLM1T5
	rqfc8hig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpbvb-00000006YFP-1hhD;
	Tue, 04 Mar 2025 23:43:59 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpbvX-00000006YEQ-3o0r
	for kexec@lists.infradead.org;
	Tue, 04 Mar 2025 23:43:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 013335C028E;
	Tue,  4 Mar 2025 23:41:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3185BC4CEE5;
	Tue,  4 Mar 2025 23:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741131834;
	bh=KJTrKAUFeXqKd7gJGLa34anESOCeXSsRQo75HdiIUuc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n5Dvx1amUKlj7tZ5ib0hANnaD0kL4bR5H++aFlnZlMavfGt2NvSv6biQs+v5UsvXU
	 qTBHf4/fEDaPUrfNWTEj2itQHGutHHiZOgCv7mvYnRX1j2oTx9CSeqItjR3GkL8Kqz
	 5OpDEIdQBk+dgK8S/UPygPvRVQMGSres/aTiqcsk=
Date: Tue, 4 Mar 2025 15:43:53 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, ebiederm@xmission.com,
 kexec@lists.infradead.org, Yan Zhao <yan.y.zhao@intel.com>,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, x86@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v2 0/1] Accept unaccepted kexec segments' destination
 addresses
Message-Id: <20250304154353.a79c330bffb4d21dce2dad9c@linux-foundation.org>
In-Reply-To: <Z4T1G4dwzo7qdwSP@MiWiFi-R3L-srv>
References: <20241213094930.748-1-yan.y.zhao@intel.com>
	<xgycziy2o56hnom3oau7sbqed3meoni3razc6njj7ujatldnmm@s7odbl4splbn>
	<Z4T1G4dwzo7qdwSP@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250304_154355_978399_C9DA9E01 
X-CRM114-Status: GOOD (  16.53  )
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

On Mon, 13 Jan 2025 19:12:27 +0800 Baoquan He <bhe@redhat.com> wrote:

> On 01/13/25 at 12:01pm, Kirill A. Shutemov wrote:
> > On Fri, Dec 13, 2024 at 05:49:30PM +0800, Yan Zhao wrote:
> > > Hi Eric,
> > > 
> > > This is a repost of the patch "kexec_core: Accept unaccepted kexec
> > > destination addresses" [1], rebased to v6.13-rc2.
> > 
> > Can we get this patch applied?
> 
> This looks good to me. In v1, we have analyzed all other possible
> solutions, however change in this patch seems the simplest and most
> accepatable one. 
> 
> If Eric has no objection, maybe Andrew can help pick this into his tree.

OK, but that patch is the only thing in the world which is older than me.

Yan, can you please refresh, retest and resend?

Also, please consolidate the changelogging into a single email -
a single-patch series with a coverletter is just weird.

Putting the [0/n] info into the singleton patch's changelog is more
reader-friendly, and that's what counts, no?

Thanks.


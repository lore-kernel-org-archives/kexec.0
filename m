Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E49ECAAA2
	for <kexec@archiver.kernel.org>; Fri, 26 Aug 2022 01:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KLc5H1xGlG9Wend/m93TEeiS6HsBo0kDVHcjMQKpwM0=; b=snRSQkA5/xzG5h
	j5GSxM3ZRVYDwVzoOZHT5pQOiKmI7CTEDLbz0fHgfS00bp/zT5eEa785uYiVm/j9aLMN9pJ9dI9Ov
	alkRY0AonyEkPcZEfYOsauXSvEh5j5TySwsBsP2zShPRgV/yC8RQQ44An7uT/tSvMZgH7tiBfidTt
	DtRf/SGBMWmZOtugFfgDziS2kvCNtuR+o8qbPy+mAOzb3SVgH8EmqseS/pzSWNa4dUO3tLRzHnx/V
	9tbIMkd7eLMVJEs+sp2s4rHO8mViQ0B40xMXFAtvtZiaSbjiSp8sd8pB8cCNnGI/B+DvsXGHyqtbg
	rVcP2KgqvQzYMJvxAF6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRNzG-004ngY-9w; Fri, 26 Aug 2022 01:18:18 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRNzD-004nex-PI
	for kexec@lists.infradead.org; Fri, 26 Aug 2022 01:18:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id DB7D761D90;
	Fri, 26 Aug 2022 01:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7ACC433D6;
	Fri, 26 Aug 2022 01:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1661476694;
	bh=xAL9DV0Gl9UV41+zmuVYq/S955LLBpe4w8CM7IzMAPw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2Rhulgtr8+DE/T+bEgl2/HeE7PC5m3vSZh+0tX0rK4WlUdfCduqjcebXZy7tdIdgw
	 Y59oDFrYFn3w5YMOezN+4WYo0s2Z++LnVRF4OcpjFnfPMGa7q0eMf53ls6WLhsyMHl
	 c+8vmCzc6eOOKKyL9eXqCI/Mbw34QTxwkYfKJ8gs=
Date: Thu, 25 Aug 2022 18:18:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
 linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>,
 kexec@lists.infradead.org
Subject: Re: [PATCH] vmcoreinfo: add kallsyms_num_syms symbol
Message-Id: <20220825181813.7a83043882be706bc8391c99@linux-foundation.org>
In-Reply-To: <a151e3d3-db1d-c3ad-dcd5-3f758b4138ab@oracle.com>
References: <20220808205410.18590-1-stephen.s.brennan@oracle.com>
	<a151e3d3-db1d-c3ad-dcd5-3f758b4138ab@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220825_181815_887241_330AC790 
X-CRM114-Status: GOOD (  16.42  )
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

On Thu, 25 Aug 2022 10:27:04 -0700 Stephen Brennan <stephen.s.brennan@oracle.com> wrote:

> I just wanted to check on the status of this. I got your email about it 
> being added to mm-hotfixes-unstable, and I do still see it in the quilt 
> patches set:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/vmcoreinfo-add-kallsyms_num_syms-symbol.patch
> 
> I see the patch in mm-everything-2022-08-15-02-47 but it seems to have 
> dropped out in mm-everything-2022-08-17-20-59 and later tags. As a 
> result, it no longer shows up in linux-next.
> 
> Please excuse me if I'm ignorant of part of your process here, I know 
> you handle a huge volume of patches!

Thanks for noticing this - I appear to have messed up a rebase and lost
a batch of hotfixes :(

I readded

mm-hugetlb-avoid-corrupting-page-mapping-in-hugetlb_mcopy_atomic_pte.patch
shmem-update-folio-if-shmem_replace_page-updates-the-page.patch
writeback-avoid-use-after-free-after-removing-device.patch
mailmap-update-guilherme-g-piccolis-email-addresses.patch
vmcoreinfo-add-kallsyms_num_syms-symbol.patch
mm-re-allow-pinning-of-zero-pfns-again.patch

to the hotfixes queue.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

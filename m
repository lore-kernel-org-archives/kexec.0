Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B89C4167B
	for <kexec@archiver.kernel.org>; Sat, 25 Nov 2023 21:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+nJJLNKg1rG4HY+s9KMK1TJgRoCz5Jfp/9/abLLufsg=; b=BVkRm50jJlFSmB
	/72n4XdbYiHWHmODsp46SXBYAa2ni+LjBRk8TysPNE2w3hE34dOrlNvfqtILbKcISy39dNWsvqGwf
	+u4X26MzbPhakOy0iSQWaojvUcO1smw7uMECaTe9hoQlqxNCTLRDGjyEZyhjAKfDOhht14OnjeWwx
	MFZVzHoi+GS82ujPkdVP2U13OdbtBcRk8jC2SR0rVFj7Hacpc++6Sq1beGIlaG/q9lkXf9NQGrwf8
	zPXjapwX0xSevmmP+YYVXVcaUuSxwMRx2DDivetf53dg8iMMEa871CgI3gwqUUd5bMHHSgEuEo/xh
	jzGtw1mspYvRuTJ55WbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r706o-009p8M-0h;
	Sat, 25 Nov 2023 21:22:38 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r706k-009p58-0z
	for kexec@lists.infradead.org;
	Sat, 25 Nov 2023 21:22:36 +0000
Received: from relay2.suse.de (unknown [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 180801FD26;
	Sat, 25 Nov 2023 21:22:30 +0000 (UTC)
Received: from localhost (dwarf.suse.cz [10.100.12.32])
	by relay2.suse.de (Postfix) with ESMTP id 3868B2C142;
	Sat, 25 Nov 2023 21:22:29 +0000 (UTC)
Date: Sat, 25 Nov 2023 22:22:29 +0100
From: Jiri Bohac <jbohac@suse.cz>
To: Tao Liu <ltao@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, mhocko@suse.cz
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZWJllXCN0SDIELrX@dwarf.suse.cz>
References: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
 <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: 180801FD26
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231125_132234_516110_AE932152 
X-CRM114-Status: GOOD (  12.87  )
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

Hi Tao, 

On Sat, Nov 25, 2023 at 09:51:54AM +0800, Tao Liu wrote:
> Thanks for the idea of using CMA as part of memory for the 2nd kernel.
> However I have a question:
> 
> What if there is on-going DMA/RDMA access on the CMA range when 1st
> kernel crash? There might be data corruption when 2nd kernel and
> DMA/RDMA write to the same place, how to address such an issue?

The crash kernel CMA area(s) registered via
cma_declare_contiguous() are distinct from the
dma_contiguous_default_area or device-specific CMA areas that
dma_alloc_contiguous() would use to reserve memory for DMA.

Kernel pages will not be allocated from the crash kernel CMA
area(s), because they are not GFP_MOVABLE. The CMA area will only
be used for user pages. 

User pages for RDMA, should be pinned with FOLL_LONGTERM and that
would migrate them away from the CMA area.

But you're right that DMA to user pages pinned without
FOLL_LONGTERM would still be possible. Would this be a problem in
practice? Do you see any way around it?

Thanks,

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

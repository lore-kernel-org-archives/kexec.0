Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38269C4332F
	for <kexec@archiver.kernel.org>; Sat, 17 Dec 2022 15:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=EjrjZMZzxyu6ZW18tUsM/RXLE99A1ta4ujBmGg/GAKk=; b=KTEabdK5jLnnci
	l9lW3hT6U/XA0Dk4SHMohzfZLl11yxk8KQ/OiQDqR/E74ZRakwX3pamB9xh9H56wxU2cZyhpM6BIn
	wWTUgppV/h9jKfOXZjQ4wywq0CGEklUaDu452nYNkV5GHrvMwWrWXYC7LwS1YBVf6wl6HHN8KsY5S
	mW03o7fsATjb27qlGqpDvSEIN3EsByP9EgRu2E20qf4wwarARCQx5Kq4UHQhWaPfa/1jhUk7ciUNQ
	7IIuA5t+jRT4B8wRRmxfE1pqEmpn5/hDBJop3vVifHyTBaisjuDkjXXgld2KR4FSzYO3uIpDKl5Vm
	Hid/asCGwxWzryWf+3Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6ZaM-00AgiD-Su; Sat, 17 Dec 2022 15:58:50 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6ZaJ-00AghM-Ov
	for kexec@lists.infradead.org; Sat, 17 Dec 2022 15:58:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 2ECADB80139;
	Sat, 17 Dec 2022 15:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A67C433D2;
	Sat, 17 Dec 2022 15:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671292723;
	bh=0SWU9xGA4GT0P8n+P8Hu88az0XrllApnKjpIJZPfI6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XnN2aKjICo0GvkdUazSQ2jmJaoJ2C1FSTVpRoP4SN0crKqSmV0v4ZlGh5x2jXYra7
	 /t2Qks3AmvR+uri2OMeXWCeiCiQNQWjZCrmb/fuSim9MmgUXt8JgmDgQ0uQYRRSs/T
	 aVBOVdzT8Dh411yZ7fKdJxFux0Yo09QLu/rX4dBT4Ur9swiVSYwKY05XfTYhnkKoq5
	 E6+MCKwJSb4JNYV/+uxOvQI8oA5Y7IsuoI1AO1UVltLQKNctFGNc97FPDwqUicC37m
	 g/XQjEKmj7R/sI79ineVDreqH8+KqgFfTvsgGQDaUqy5OrjzZLlqwaP+FiR89fshjq
	 UE1CVe1VNmdag==
Date: Sat, 17 Dec 2022 09:58:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] kexec: Remove unnecessary arch hook
Message-ID: <20221217155842.GA389338@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y52Qg8OvU1UsGZGC@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221217_075848_001639_4D81F585 
X-CRM114-Status: GOOD (  15.60  )
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

On Sat, Dec 17, 2022 at 05:48:51PM +0800, Baoquan He wrote:
> On 12/15/22 at 12:23pm, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > There are no arch-specific things in arch_kexec_kernel_image_load(), so
> > remove it and just use the generic version.
> 
> I ever posted below patch to do the same thing, Andrew only picked the
> memory leak fixing patch.
> 
> [PATCH v2 2/2] kexec_file: clean up arch_kexec_kernel_image_load
> https://lore.kernel.org/all/20220223113225.63106-3-bhe@redhat.com/T/#u

Indeed!  Sorry, I wasn't aware of your previous work.  If you repost
it, cc me and I'll be glad to help review it.

> > Bjorn Helgaas (2):
> >   x86/kexec: Remove unnecessary arch_kexec_kernel_image_load()
> >   kexec: Remove unnecessary arch_kexec_kernel_image_load()
> > 
> >  arch/x86/include/asm/kexec.h       |  3 ---
> >  arch/x86/kernel/machine_kexec_64.c | 11 -----------
> >  include/linux/kexec.h              |  8 --------
> >  kernel/kexec_file.c                |  6 +++---
> >  4 files changed, 3 insertions(+), 25 deletions(-)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

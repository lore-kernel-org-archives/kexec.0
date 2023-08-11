Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E03FC001DB
	for <kexec@archiver.kernel.org>; Fri, 11 Aug 2023 13:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=izb7AigFZH6AZWMT57yf8tBgTRb5LEbWTvdxHji0xpE=; b=XnjcZv4odoO2ZC
	RjpOg78Iro1DWPCDq6DELIx7jt3YlsrUPnWwYBR7kKbblAKPjtf+mDSwEacYFIdxudGai+VmZqqLI
	Sw+S8EjqHOgsyyYPawleHFXfCsHIiRmcguLuvm6dQ03EsJs+HfjWdeTq9OWojsbGIgMhLkhfv/uGY
	rIcwS6wUQDBhc+7EgtdmN8tRb5y+7vIlsqqmeIpp9iNdTaEALwRFg2N8Js8MryCV3S83s6D1sNtzr
	CA2snXAF2Ple36mRTcIi46v52vZpieKdkRvvDaO++7wq71TMF46MkVVqLtRzbDj1lz19Ue6XTa7Tn
	ytxPshz41uDP+ud2V9mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qURus-00Ah11-2a;
	Fri, 11 Aug 2023 13:10:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qURuq-00AgyY-2N;
	Fri, 11 Aug 2023 13:10:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4DD1867373; Fri, 11 Aug 2023 15:10:49 +0200 (CEST)
Date: Fri, 11 Aug 2023 15:10:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	Wen Xiong <wenxiong@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Baoquan He <bhe@redhat.com>, Pingfan Liu <piliu@redhat.com>
Subject: Re: [PATCH V3 01/14] blk-mq: add blk_mq_max_nr_hw_queues()
Message-ID: <20230811131049.GA20991@lst.de>
References: <20230808104239.146085-1-ming.lei@redhat.com> <20230808104239.146085-2-ming.lei@redhat.com> <20230809134401.GA31852@lst.de> <ZNQqt1C0pXspGl3d@fedora>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZNQqt1C0pXspGl3d@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_061056_924727_880FA0D7 
X-CRM114-Status: GOOD (  12.86  )
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

On Thu, Aug 10, 2023 at 08:09:27AM +0800, Ming Lei wrote:
> 1) some archs support 'nr_cpus=1' for kdump kernel, which is fine, since
> num_possible_cpus becomes 1.
> 
> 2) some archs do not support 'nr_cpus=1', and have to rely on
> 'max_cpus=1', so num_possible_cpus isn't changed, and kernel just boots
> with single online cpu. That causes trouble because blk-mq limits single
> queue.

And we need to fix case 2.  We need to drop the is_kdump support, and
if they want to force less cpus they need to make nr_cpus=1 work.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15081C001E0
	for <kexec@archiver.kernel.org>; Thu, 10 Aug 2023 00:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G2DvaXDYlxR62QaMncAxgVfbdRNH5zuUBI6R8px4NS0=; b=4hlwedWuUkhFw6
	tokKuVzGb80rblef8jx6SSZEAqAAl7MheXPy1AQD1FobKoUkgsqnDU6kFptOjpOBdI8Pevpf+Liwy
	U1RaNP5fE7uU+oOoU1dtE2pE9KnQg8qVTvQZw1oMeQiU2U4Z8oEUZ51Q5KNfkqXkI85uijncZgrtK
	L7twJbgpeiWy6wNcOxZYbLwwhqwjgd21hvdcwdY/bKNHfepA6xjLgkNdurF8TdQNQZcTvney+olsK
	fnt4dGa8XzMeMaCJ51i+iiF3g2htBIP6DHDVHpeCxpgvm0NLuQloitOXvi55uSjEgpJfbfCbCMEa4
	QEXBQKe75HvF94UqfIMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTtFN-0068N1-37;
	Thu, 10 Aug 2023 00:09:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTtFK-0068Lk-09
	for kexec@lists.infradead.org;
	Thu, 10 Aug 2023 00:09:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691626183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RhYjGeDQjHaify9fYveKNlg3W8+1+0vVy9IFYKIMw0M=;
	b=TmcJYfCnmq5zm2wFuGcK6rUmvlVg3sl4aFa4zHaQ07CgaJElz1jsrwAHeWA1/uDfmIMaHH
	fGArd4a4vA6Efd7mstjHs7u0Br+8rdqXQOgoElYrgCudRx+zM5HZ/JvFZ1ckxkxLYI4mh1
	ODS/lnFKoMPRb7ik0mlhQQ/hYsuCOAc=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-dBjPouXWOO-yZ4G5_5ahoA-1; Wed, 09 Aug 2023 20:09:40 -0400
X-MC-Unique: dBjPouXWOO-yZ4G5_5ahoA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0557D3802BBC;
	Thu, 10 Aug 2023 00:09:40 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EA7C02026D4B;
	Thu, 10 Aug 2023 00:09:32 +0000 (UTC)
Date: Thu, 10 Aug 2023 08:09:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	Wen Xiong <wenxiong@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Baoquan He <bhe@redhat.com>, Pingfan Liu <piliu@redhat.com>
Subject: Re: [PATCH V3 01/14] blk-mq: add blk_mq_max_nr_hw_queues()
Message-ID: <ZNQqt1C0pXspGl3d@fedora>
References: <20230808104239.146085-1-ming.lei@redhat.com>
 <20230808104239.146085-2-ming.lei@redhat.com>
 <20230809134401.GA31852@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230809134401.GA31852@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_170946_178693_3C911640 
X-CRM114-Status: GOOD (  15.58  )
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

On Wed, Aug 09, 2023 at 03:44:01PM +0200, Christoph Hellwig wrote:
> I'm starting to sound like a broken record, but we can't just do random
> is_kdump checks, and it's not going to get better by resending it again and
> again.  If kdump kernels limit the number of possible CPUs, it needs to
> reflected in cpu_possible_map and we need to use that information.
> 

Can you look at previous kdump/arch guys' comment about kdump usage &
num_possible_cpus?

    https://lore.kernel.org/linux-block/CAF+s44RuqswbosY9kMDx35crviQnxOeuvgNsuE75Bb0Y2Jg2uw@mail.gmail.com/
    https://lore.kernel.org/linux-block/ZKz912KyFQ7q9qwL@MiWiFi-R3L-srv/

The point is that kdump kernels does not limit the number of possible CPUs.

1) some archs support 'nr_cpus=1' for kdump kernel, which is fine, since
num_possible_cpus becomes 1.

2) some archs do not support 'nr_cpus=1', and have to rely on
'max_cpus=1', so num_possible_cpus isn't changed, and kernel just boots
with single online cpu. That causes trouble because blk-mq limits single
queue.

Documentation/admin-guide/kdump/kdump.rst

Thanks, 
Ming


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

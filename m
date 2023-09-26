Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0752DE7F128
	for <kexec@archiver.kernel.org>; Tue, 26 Sep 2023 20:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h5kfW98V73Y2hSVp9twyda2TigDrasDvrNQaQIj+xe8=; b=TQCC3UsCuOucUT
	6yY3eFQWxMBmEObyyhuMjRm4nEtdBW8KZET4oK6J52PGNhS/vKQtWB5lLneHHqYZaHa1JyjSeVflK
	OkTNrr4z/Arvba1ocpQWIdCPmb7nDdQ5EdGFdqtcrtJNC/ThHPA6JKuS2FzOVecLgJPmQGhddml85
	UUOnRIU3P8ANp1k1Csv+TAKYaEwa+QFhCo7ZBfLKZV3pNKBoz2UFWtDproH2m1lwQPCf3znLILOcI
	0h2hPXxqQcoMqRxUyrdZ0MmttR5HnL+2QNvEqu+l1GGyTbBvrUCkPC/PB32vG4uPoRq/iioHdJP0I
	jjco5zKQKqav3GDZxKNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlF0R-00H1LD-2E;
	Tue, 26 Sep 2023 20:50:07 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlF0P-00H1Kl-0S
	for kexec@lists.infradead.org;
	Tue, 26 Sep 2023 20:50:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 9C201B8122A;
	Tue, 26 Sep 2023 20:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68ABC433C8;
	Tue, 26 Sep 2023 20:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1695761403;
	bh=3JVXHD4B9lMQRBYG5Ho/Z5uxFJWNJxBVMuf0sevF2J4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RWRsX3qiHSw6hR4nQ9wbTQVNU0jSRV+75d5aaO/jzTRu8c5lur3hZ2UzAZDoFIiNZ
	 zpuFiT9MT9ftLv2uzzpMc+mc1DTI8o2AKeS5qBOS544wlV9tjy1af8BQzBAlzCTu8z
	 /6fqkgwwz4jw0WHOV3Un5z31k/rNg/YUT4s/IYRA=
Date: Tue, 26 Sep 2023 13:50:01 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 eric.devolder@oracle.com, vschneid@redhat.com, sourabhjain@linux.ibm.com
Subject: Re: [PATCH v3] Crash: add lock to serialize crash hotplug handling
Message-Id: <20230926135001.4eb6ca73b1a4aa6224355ad1@linux-foundation.org>
In-Reply-To: <20230926120905.392903-1-bhe@redhat.com>
References: <20230926120905.392903-1-bhe@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230926_135005_345291_8A4E262A 
X-CRM114-Status: UNSURE (   8.26  )
X-CRM114-Notice: Please train this message.
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

On Tue, 26 Sep 2023 20:09:05 +0800 Baoquan He <bhe@redhat.com> wrote:

> Eric reported that handling corresponding crash hotplug event can be
> failed easily when many memory hotplug event are notified in a short
> period. They failed because failing to take __kexec_lock.

I'm assuming that this failure is sufficiently likely so as to  justify a -stable
backport of the fix.   Please let me know if this is incorrect.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

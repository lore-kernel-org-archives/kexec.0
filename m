Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E60C00144
	for <kexec@archiver.kernel.org>; Mon,  1 Aug 2022 08:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=blG6kwcFrmv8CdNpfIcl871Z6JCLK1D101tTSlfMXPo=; b=mvmvJNp0Zla6KQ
	qeCAG7wKJxqflM7lDnxD6GWZEJOecZm0kvSNqsqxmYPGGzvg+un+0qFh/0Oc1Tr74fvdJa9DgcMx0
	acpzgyHzozCe0yrv65Jf/Vex6Lgavym607brkDhIuoLn54mSucYGjdanufCkjN+WtYBKug5bPAxb+
	+6EPVCzTNB/oh97pUAXiBhwAaBOgPhz7r7o7e5uDl545uICmswncLQ2tnybyOF4yKmPKuWJq95s9I
	AB7yUo5IetH7heZgzJopPCSWPZcq/xbDZqt8BPsVHD59BqcOY8NHRaXBBlypNUOeAhYQcUIvV1cc5
	XUufKHaR9clNyrYujnEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIQgs-003udW-KX; Mon, 01 Aug 2022 08:22:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIQfE-003ta0-L9
	for kexec@lists.infradead.org; Mon, 01 Aug 2022 08:20:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1659342033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pJH07x8QvE4r/0Wcvdf2EaLzPedOQZnkWNurVPoZ0fI=;
	b=IRp9bzVrgUC+IB0fzcAve03sGU1JKCEeud/BY9HZXVOoRo9OtKv+aCPUd4OgvS9YP6weUy
	+P51Hz28OHIWUubQMVKU/2sB+wIM83TJvvjezQvrqIsteUHVc/PDN9IQdHN9BDFQa7dFuB
	GyezDTSvGByte15v4lLFtrPiSd0wf9M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-wsEDCQC2NEKteI_g3du0kQ-1; Mon, 01 Aug 2022 04:20:32 -0400
X-MC-Unique: wsEDCQC2NEKteI_g3du0kQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9434B1C14488;
	Mon,  1 Aug 2022 08:20:31 +0000 (UTC)
Received: from localhost (ovpn-12-103.pek2.redhat.com [10.72.12.103])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 10BDE492C3B;
	Mon,  1 Aug 2022 08:20:29 +0000 (UTC)
Date: Mon, 1 Aug 2022 16:20:25 +0800
From: Baoquan He <bhe@redhat.com>
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Feng Zhou <zhoufeng.zf@bytedance.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Chen Zhou <dingguo.cz@antgroup.com>,
	John Donnelly <John.p.donnelly@oracle.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH v3 0/2] arm64: kdump: Function supplement and performance
 optimization
Message-ID: <YueMyUqannVg7l9v@MiWiFi-R3L-srv>
References: <20220711090319.1604-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220711090319.1604-1-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220801_012036_868292_C36A9DC2 
X-CRM114-Status: GOOD (  22.37  )
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

Hi Catalin,

On 07/11/22 at 05:03pm, Zhen Lei wrote:
> v2 --> v3:
> 1. Discard patch 3 in v2, a cleanup patch.
> 
> v1 --> v2:
> 1. Update the commit message of Patch 1, explicitly indicates that "crashkernel=X,high"
>    is specified but "crashkernel=Y,low" is not specified.
> 2. Drop Patch 4-5. Currently, focus on function integrity, performance optimization
>    will be considered in later versions.
> 3. Patch 3 is not mandatory, it's just a cleanup now, although it is a must for patch 4-5.
>    But to avoid subsequent duplication of effort, I'm glad it was accepted.
> 
> 
> v1:
> After the basic functions of "support reserving crashkernel above 4G on arm64
> kdump"(see https://lkml.org/lkml/2022/5/6/428) are implemented, we still have
> three features to be improved.
> 1. When crashkernel=X,high is specified but crashkernel=Y,low is not specified,
>    the default crash low memory size is provided.
> 2. For crashkernel=X without '@offset', if the low memory fails to be allocated,
>    fall back to reserve region from high memory(above DMA zones).
> 3. If crashkernel=X,high is used, page mapping is performed only for the crash
>    high memory, and block mapping is still used for other linear address spaces.
>    Compared to the previous version:
>    (1) For crashkernel=X[@offset], the memory above 4G is not changed to block
>        mapping, leave it to the next time.
>    (2) The implementation method is modified. Now the implementation is simpler
>        and clearer.

Do you have plan to pick this series so that it can be taken into 5.20
rc-1~3?

We have back ported the basic crashkernel=high, low, support into our
distros and have taken wide testing on arm64 servers, need this patchset
to back port for more testing. 

Thanks
Baoquan

> 
> Zhen Lei (2):
>   arm64: kdump: Provide default size when crashkernel=Y,low is not
>     specified
>   arm64: kdump: Support crashkernel=X fall back to reserve region above
>     DMA zones
> 
>  .../admin-guide/kernel-parameters.txt         | 10 ++-----
>  arch/arm64/mm/init.c                          | 28 +++++++++++++++++--
>  2 files changed, 28 insertions(+), 10 deletions(-)
> 
> -- 
> 2.25.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

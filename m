Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7635DC001DE
	for <kexec@archiver.kernel.org>; Mon, 24 Jul 2023 13:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WfTp4oNA49//GSeJ4IFbgS82yUAnWriOMhxf8bcgRAY=; b=wmXpwGbxw565+1
	t6rsnjGDO2VxtCIpqMxueci1uBOKis6iMXwYlhj/7B8mYP6yokZq8UnQn6Ej+wqlJubfEWPEJkTal
	0ccKrg4UGpf3jI4zhqpGQkVQSgEOLOHTw1He+meoU+yBu/FxngXXEy6M96kdwcdek2CqbbvIsMq2U
	sgfQsQHxd/C31yABlpc5Bmdl4r78DQWv7qpx40qLwVb0aTEEyBG7uGimRPW4+BZ4OfAOfrR2se1JF
	kuG0AJjeD/Y9/Qn9uZmJUwjclCBte5pk//Y8BYS9EU6+9MdHiW/TNqSvaHjobQfhKy72glYxmxMDL
	SdOMjcHC0MALGkK5Xlww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNvhz-004T9W-1b;
	Mon, 24 Jul 2023 13:34:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNvhx-004T7P-0q
	for kexec@lists.infradead.org;
	Mon, 24 Jul 2023 13:34:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690205680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nlp127bLQT9/IdMnc0IeGz9d5IiRzXNJt1iTm1vMsCQ=;
	b=V6SKp3hlvJDymOEpOrOOwShhVRM0V/VWVhKi9dkniKsGdX3mD8A6mdgUn5SAwTo2nKFKdM
	PpvoKe9KCCu9MvOkWLViNaMv5cojOAyxaG6NN7NODB5d35llMZ8rl1U/i7ARpwUvakTHsM
	GGkZkZU8YCCCLYJ3sQADhj+8Q4MovKk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-7njwa9GAOLizVthp8haMkg-1; Mon, 24 Jul 2023 09:34:36 -0400
X-MC-Unique: 7njwa9GAOLizVthp8haMkg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F2DB8030AC;
	Mon, 24 Jul 2023 13:34:35 +0000 (UTC)
Received: from localhost (unknown [10.72.112.67])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 76E6540C6F4F;
	Mon, 24 Jul 2023 13:34:33 +0000 (UTC)
Date: Mon, 24 Jul 2023 21:34:29 +0800
From: Baoquan He <bhe@redhat.com>
To: thunder.leizhen@huaweicloud.com
Cc: Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 0/3] arm64: kdump: Restore the write protection for the
 crashkernel memory region
Message-ID: <ZL595WtNlLnvtnJl@MiWiFi-R3L-srv>
References: <20230721081726.882-1-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230721081726.882-1-thunder.leizhen@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_063441_374523_C6DA4864 
X-CRM114-Status: GOOD (  18.16  )
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

Hi,

On 07/21/23 at 04:17pm, thunder.leizhen@huaweicloud.com wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Unlike in the past, the low memory allocation direction of the crashkernel is
> changed from top-down to bottom-up. As long as the DMA zone has sufficient
> continuous free memory, the allocated crashkernel low memory must meet the
> requirements. The allocation direction of crashkernel high memory remains
> unchanged, that is, top-down. As long as the high memory(above DMA zone) has
> sufficient continuous free memory, the allocated crashkernel high memory must
> meet the requirements. In this way, with the restoration of the original
> page-level mapping and the implementation of the arch_kexec_protect_crashkres()
> function, write protection for the crashkernel memory region can be supported.
> 
> Of course, if the high memory or low memory cannot meet the initial requirements,
> that is, fall back is required. In this case, write protection is not supported
> because the newly allocated memory is not page-level mapped.
> 
> Because the original retry process is eliminated, the new process looks clearer
> and is a simple sequential flow.

Thanks, but no.

The pure semantics and the corresponding implementation have been 
complicated, it's not worth adding so much more complication to it
just because of one inessential feature.

If stomp really happened and destroy the loaded kdump kernel, the write
protection truly can save kdump to make vmcore dumping succeed. While
without write protection, we at least know that stomp happened by the
later checksum verifycation. That's an advantage over write protection
which silently ignores the stomp, right?

So, due to the low cost performance, from people maintaining and
understanding the code point of view, I would like to NACK this series.
BUT since all these code changes are added into arm64 arch, I won't
object if arm64 maintainers wants to pikc them up.

By the way, as we have talked before, arm64 lacks the loaded kernel
checksum storing and verifying, would you like to add that?

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

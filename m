Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3932EEB582
	for <kexec@archiver.kernel.org>; Thu, 12 Sep 2024 09:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pfNk+WVmiN4attJM6e+waIC7dZ3EzOpJpX2/IufLyuo=; b=0fPubdZh8A2/ba
	RLoHMaTtClA+NKR2f33itWv88mZpxVCMKV4P5ANb3PQ6PZMDzzszjCIdBOvVPvPTjuMNuPSqMnP1k
	xuvFaaC6YySidiDjzP6Ypb5b/wR1LYkx+ojHSnSfLEBySXga+Go6xPSII0FnobhlIboIQi7n34ATM
	TyBE7XqBhifRz8S/O5C920HZM8V9VVtJPdPf10PRCrH4sSoHlJ0aMwnBaKWQZKsVRCEg5wTOEJzBJ
	ZcTc2xS/u2iCnuUlRuhO/b/CtChyxfKSmID4aS93bljrpJcVqy7AH3PwUeczjqAWKKuh5qrhbZB4s
	GPHs9FHmNWl02A6VWqMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sogXV-0000000Cbhx-0MPb;
	Thu, 12 Sep 2024 09:55:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sogXR-0000000CbfN-2ruZ
	for kexec@lists.infradead.org;
	Thu, 12 Sep 2024 09:54:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726134896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rqxoiqw+842QliGENKyve7P0iOszesu17qVHDOSZ6q4=;
	b=CVxHfCKDHXNKCTZrS39UiEVdI5kYVoySE0ZP9uoI4JZz1BMtPos64IUHGhV1bnL0lxw9Nh
	oeNO8UQSIvgscmYXtmXAw+ARjMNQA8C9fYANoiShIyL/8Z16bRNFYodDfUesGMFYm0y9TN
	C57slUZnKC779/aaGsUsqT+DAPo+PNQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-9kmFCzvVMbmuyadkSLFFog-1; Thu,
 12 Sep 2024 05:54:53 -0400
X-MC-Unique: 9kmFCzvVMbmuyadkSLFFog-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F26A81958B3E;
	Thu, 12 Sep 2024 09:54:50 +0000 (UTC)
Received: from localhost (unknown [10.72.112.58])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D03B19560AB;
	Thu, 12 Sep 2024 09:54:47 +0000 (UTC)
Date: Thu, 12 Sep 2024 17:54:43 +0800
From: Baoquan He <bhe@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Petr Tesarik <petr.tesarik@suse.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric DeVolder <eric.devolder@oracle.com>,
	"open list:KEXEC" <kexec@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	Petr Tesarik <ptesarik@suse.com>, stable@kernel.org
Subject: Re: [PATCH 1/1] kexec_file: fix elfcorehdr digest exclusion when
 CONFIG_CRASH_HOTPLUG=y
Message-ID: <ZuK6Y1+Z5x4Hvt4P@MiWiFi-R3L-srv>
References: <20240805150750.170739-1-petr.tesarik@suse.com>
 <871q2oy6eb.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <871q2oy6eb.fsf@email.froward.int.ebiederm.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_025457_840685_9FCD2BFC 
X-CRM114-Status: GOOD (  22.52  )
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

Hi Eric,

On 08/16/24 at 07:54am, Eric W. Biederman wrote:
> Petr Tesarik <petr.tesarik@suse.com> writes:
> 
> > From: Petr Tesarik <ptesarik@suse.com>
> >
> > Fix the condition to exclude the elfcorehdr segment from the SHA digest
> > calculation.
> >
> > The j iterator is an index into the output sha_regions[] array, not into
> > the input image->segment[] array. Once it reaches image->elfcorehdr_index,
> > all subsequent segments are excluded. Besides, if the purgatory segment
> > precedes the elfcorehdr segment, the elfcorehdr may be wrongly included in
> > the calculation.
> 
> I would rather make CONFIG_CRASH_HOTPLUG depend on broken.
> 
> The hash is supposed to include everything we depend upon so when
> a borken machine corrupts something we can detect that corruption
> and not attempt to take a crash dump.
> 
> The elfcorehdr is definitely something that needs to be part of the
> hash.
> 
> So please go back to the drawing board and find a way to include the
> program header in the hash even with CONFIG_CRASH_HOTPLUG.

Thanks for checking this and adding your advice, and sorry for late
reply.

It's me who suggested Eric DeVolder not adding elfcorehdr into kdump
kernel iamge hash during reviewing his patch. I need explain this if
people has concern. When I suggested this, what I considered are:

1) The code change will be much simpler. As you can see, later Eric
   DeVolder's patchset experienced rounds of reviewing and finally
   merged. Below is his final round:

   - [PATCH v28 0/8] crash: Kernel handling of CPU and memory hot un/plug

2) The efficiency will be improved very much relative to adding
   elfcorehdr to the entire hash. When cpu/mem hotplug triggered,
   we only touch elfcorehdr area, but don't need access the entire
   loading segments.

3) The elfcorehdr size is very tiny relative to kernel image and initrd.
   E.g on x86, it's less than 1M, which is tiny relative to dozens of 
   kernel image and initrd.

Surely, adding all loading segments into hash is the best. While
attracted by above benefits, I tend to not add for the time being. I am
open to this, if anyone has concern about the security and is interested
in the adding as a kernel project practice in the future, it's welcomed.

Here I'd like to request comment from Sourabh since he and other IBM dev 
added the support to ppc too. Different than generic ARCH, IBM dev can
be seen as a end user, maybe we can hear how they evaluate the balance
between the risk and benefit.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

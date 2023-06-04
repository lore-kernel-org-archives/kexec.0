Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49494C77B73
	for <kexec@archiver.kernel.org>; Sun,  4 Jun 2023 13:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=soklRILTpEw9+CebuId7eI97tl+UgTXZdzqdIC/tKYE=; b=XWbWnf2D5p65ce
	DyysEepzr62uPWkHc6UdadMnGO43c2/BJhL1oLXjncHqwm6s8dYygB+DYRbBidOrl3p3AhMHyQwLn
	UfC0uw/yow6zGoXQRXYb0yTu95Q5le+A5Svvq+gamPb+7fqc5OdiPdi+ctme1V+SWmXiFRQg0oxcS
	uUcC0HsIq/z6HBQ0Uy1HH/pSZrQ0A2wfPc658swAwnHyDMAMKIo2Ox8rSrWyD31/8RfONGzZjLHGA
	Sp1O0J1Ey/dF2VLMynSQdo1OoQn2t7nfOLnkwwPlzkFSOTiw6fVh3bkJfQIDsSWJ8g234A3CxtcKv
	Pw8XVtzJ0n9sOQVsY8Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q5nL5-00CBf5-2y;
	Sun, 04 Jun 2023 13:00:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q5nL3-00CBe4-09
	for kexec@lists.infradead.org;
	Sun, 04 Jun 2023 13:00:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685883604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OeMePCjN4P2ymC2CrBoEd8HNclMVWoMJVZ9Ma4h8Q+4=;
	b=HONN0B4HvrdFxOt2PqGXdlAiWXggBnJ96pIG8tikiQ8iAWx4YwPIVAwhpxDQGaMnKjsnvA
	ygA+fVhgV1ze6Mgrn9ZQHWd9j+5VRGHEFdUtObPMkO3TvDHzJitwSd62BBI60BnWLhlF0C
	I+A7xPJ8yU29NQDxFyyt8C7xlqYFBKk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592--Vh0TdJLOgG9xAeBLXaJIA-1; Sun, 04 Jun 2023 09:00:00 -0400
X-MC-Unique: -Vh0TdJLOgG9xAeBLXaJIA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22711811E78;
	Sun,  4 Jun 2023 12:59:59 +0000 (UTC)
Received: from localhost (ovpn-12-83.pek2.redhat.com [10.72.12.83])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E445C1121314;
	Sun,  4 Jun 2023 12:59:55 +0000 (UTC)
Date: Sun, 4 Jun 2023 20:59:52 +0800
From: Baoquan He <bhe@redhat.com>
To: Li Zhijian <lizhijian@fujitsu.com>, dan.j.williams@intel.com
Cc: kexec@lists.infradead.org, nvdimm@lists.linux.dev,
	Kazuhito Hagio <k-hagio-ab@nec.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	dan.j.williams@intel.com, ruansy.fnst@fujitsu.com,
	y-goto@fujitsu.com, yangx.jy@fujitsu.com,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Dave Young <dyoung@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Vivek Goyal <vgoyal@redhat.com>, x86@kernel.org
Subject: Re: [RFC PATCH v3 0/3] pmem memmap dump support
Message-ID: <ZHyKyHiTYH80HUjF@MiWiFi-R3L-srv>
References: <20230602102656.131654-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230602102656.131654-1-lizhijian@fujitsu.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230604_060005_159647_EB8E3228 
X-CRM114-Status: GOOD (  13.16  )
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

Hi Zhijian,

On 06/02/23 at 06:26pm, Li Zhijian wrote:
> Hello folks,
> 
> After sending out the previous version of the patch set, we received some comments,
> and we really appreciate your input. However, as you can see, the current patch
> set is still in its early stages, especially in terms of the solution selection,
> which may still undergo changes.

Thanks for the effort to make it and improve. And add Kazu and Simon to
the CC because they maintain kexec-tools and makedumpfile utility.

For better reviewing, I would suggest splitting the patches into
differet patchset for different component or repo. Here, it's obviouly
has kernel patchset, kexec-tools patch and makedumpfile patchset.

For the kernel patches, it looks straightforward and clear, if Dan can
approve it from nvdimm side, everything should be fine. Then next we can
focus on the relevant kexec-tools and makedumpfile utility support.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

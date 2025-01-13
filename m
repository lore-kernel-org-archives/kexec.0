Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845D1E7719E
	for <kexec@archiver.kernel.org>; Mon, 13 Jan 2025 11:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GvZ5YyOZqS4qQ+IVt/QwWmi22IObMOtrbJQs16hBmp4=; b=YQ0o5HlFiKfvdzl0Xf2iGKQW8G
	EbmJuN6TQVPI3k7qWXjkhR+21DsT4/eGnRkFn1YGvxYdsxn1cBNOnljdGb/Gw8W6Vu2P4j0Gz2SyK
	pp5mv6YEvK3Bdl+DPyYA5ZwYpWpx8EwLbQ8ZFSV8pJLx0bi3XL3Y7rKEzaNRYOYxHOv/wPXrnVTW7
	Qs4lqsdJW/N178duXATgUg00gFQopCe4NvQKABZ8msv+JoFVssTLqd/irGfrEzmdNPU8jNk5f04BY
	QO+Tgc+yHaE2EthQdH/+IbewiIdd8ZbZ7qTAdIMWoxQLtStsSLH3MF17+FS7lyh/S7s3Yht7GSbPB
	N7GN3B5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXIND-00000004rui-1elZ;
	Mon, 13 Jan 2025 11:12:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXIN9-00000004rtf-0JzJ
	for kexec@lists.infradead.org;
	Mon, 13 Jan 2025 11:12:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736766760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GvZ5YyOZqS4qQ+IVt/QwWmi22IObMOtrbJQs16hBmp4=;
	b=SnXlsTKhTWKPHVatQawj3sSHba7eJanJWPyn2BLjcU4qL5uksnWeID26wyNJzjze46U+cO
	TS6YlsGrHofekoq7k2jUEwRkiGUxT3p3CmcWUobCBOw9qyaHTCMwpfy+hBoOGZ4CXHwEdL
	cLZjTY+zt5tIccyL7vAo1OFuMi7AxgU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-2hCAAAdcPNi7lMRFz6b6gw-1; Mon,
 13 Jan 2025 06:12:37 -0500
X-MC-Unique: 2hCAAAdcPNi7lMRFz6b6gw-1
X-Mimecast-MFC-AGG-ID: 2hCAAAdcPNi7lMRFz6b6gw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F018B19560B1;
	Mon, 13 Jan 2025 11:12:34 +0000 (UTC)
Received: from localhost (unknown [10.72.112.156])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C217D195E3D9;
	Mon, 13 Jan 2025 11:12:32 +0000 (UTC)
Date: Mon, 13 Jan 2025 19:12:27 +0800
From: Baoquan He <bhe@redhat.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>, ebiederm@xmission.com,
	akpm@linux-foundation.org
Cc: kexec@lists.infradead.org, Yan Zhao <yan.y.zhao@intel.com>,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	x86@kernel.org, rick.p.edgecombe@intel.com,
	kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v2 0/1] Accept unaccepted kexec segments' destination
 addresses
Message-ID: <Z4T1G4dwzo7qdwSP@MiWiFi-R3L-srv>
References: <20241213094930.748-1-yan.y.zhao@intel.com>
 <xgycziy2o56hnom3oau7sbqed3meoni3razc6njj7ujatldnmm@s7odbl4splbn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xgycziy2o56hnom3oau7sbqed3meoni3razc6njj7ujatldnmm@s7odbl4splbn>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_031243_188528_8C805EF6 
X-CRM114-Status: GOOD (  10.94  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 01/13/25 at 12:01pm, Kirill A. Shutemov wrote:
> On Fri, Dec 13, 2024 at 05:49:30PM +0800, Yan Zhao wrote:
> > Hi Eric,
> > 
> > This is a repost of the patch "kexec_core: Accept unaccepted kexec
> > destination addresses" [1], rebased to v6.13-rc2.
> 
> Can we get this patch applied?

This looks good to me. In v1, we have analyzed all other possible
solutions, however change in this patch seems the simplest and most
accepatable one. 

If Eric has no objection, maybe Andrew can help pick this into his tree.

Thanks
Baoquan



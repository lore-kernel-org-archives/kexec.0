Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667FED6207F
	for <kexec@archiver.kernel.org>; Wed, 20 Nov 2024 09:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BtnWcCy/RhXE31KVrvFbhBplS1bhLk3pDVg35AMkfJY=; b=CWoi+E/X4W01a5lae1mc3GuoMf
	W5iDbAunwxJ1QuAGrfPQCG4vjAeeIKYYNpxt3sJBIVWcUg2C1yl1hhGESw2e8Q55SmlDY9KhDXOo0
	uF5DWSuLiX2zOBX7/w+GDLvoNArP/MhvjsqPriEXHHnQN+r07ymYsPl4KRangwkbFdxWPWYFkwCiM
	IFOnP2+u1N9+ZAGrGjTV4S+mxzlJKuw1mNxgcYg7SUBbEW4eYr5pJpVG4kT2kX+VGW5FAwfnGOgaQ
	X95GV7e/RZvN59suIern9PU82e3NAI+9pPqE4MgZB+3uURVlJBuuAIuGdgmHTHItZNhjQuy+0ruQo
	9ktIlLHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDhEM-0000000Ewkt-4BcK;
	Wed, 20 Nov 2024 09:42:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDhEJ-0000000Ewjx-1rIa
	for kexec@lists.infradead.org;
	Wed, 20 Nov 2024 09:42:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732095754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BtnWcCy/RhXE31KVrvFbhBplS1bhLk3pDVg35AMkfJY=;
	b=XOsi9M8Q6vqpUdgLOuhBEacNJfYu/agcZ5jBVuyDqNrkdtL+C5wM/eK65os10uo6TFci6c
	hIA14gYRFLEla+GvOhQ9grNbDs2CqQ52AKAxINzXGa1QHJy4MsX4Gx0zC/zKggMe8IDp+U
	UD/CvUV2xAzBU0xPdtrXc/cUWbjnjdY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-MR-qE1QFOU6higATofrtoA-1; Wed,
 20 Nov 2024 04:42:30 -0500
X-MC-Unique: MR-qE1QFOU6higATofrtoA-1
X-Mimecast-MFC-AGG-ID: MR-qE1QFOU6higATofrtoA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B67019560BA;
	Wed, 20 Nov 2024 09:42:27 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5BE5319560A3;
	Wed, 20 Nov 2024 09:42:25 +0000 (UTC)
Date: Wed, 20 Nov 2024 17:42:19 +0800
From: Baoquan He <bhe@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 04/11] fs/proc/vmcore: move vmcore definitions from
 kcore.h to crash_dump.h
Message-ID: <Zz2u+2abswlwVcer@MiWiFi-R3L-srv>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-5-david@redhat.com>
 <ZzcYEQwLuLnGQM1y@MiWiFi-R3L-srv>
 <ca0dd4a7-e007-4092-8f46-446fba26c672@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca0dd4a7-e007-4092-8f46-446fba26c672@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241120_014235_554332_D0490B8D 
X-CRM114-Status: GOOD (  27.46  )
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

On 11/15/24 at 10:59am, David Hildenbrand wrote:
> On 15.11.24 10:44, Baoquan He wrote:
> > On 10/25/24 at 05:11pm, David Hildenbrand wrote:
> > > These defines are not related to /proc/kcore, move them to crash_dump.h
> > > instead. While at it, rename "struct vmcore" to "struct
> > > vmcore_mem_node", which is a more fitting name.
> > 
> > Agree it's inappropriate to put the defintions in kcore.h. However for
> > 'struct vmcore', it's only used in fs/proc/vmcore.c from my code
> > serching, do you think if we can put it in fs/proc/vmcore.c directly?
> > And 'struct vmcoredd_node' too.
> 
> See the next patches and how virtio-mem will make use of the feactored out
> functions. Not putting them as inline functions into a header will require
> exporting symbols just do add a vmcore memory node to the list, which I want
> to avoid -- overkill for these simple helpers.

I see. It makes sense to put them in crash_dump.h. Thanks for
explanation.

> 
> > 
> > And about the renaming, with my understanding each instance of struct
> > vmcore represents one memory region, isn't it a little confusing to be
> > called vmcore_mem_node? I understand you probablly want to unify the
> > vmcore and vmcoredd's naming. I have to admit I don't know vmcoredd well
> > and its naming, while most of people have been knowing vmcore representing
> > memory region very well.
> 
> I chose "vmcore_mem_node" because it is a memory range stored in a list.
> Note the symmetry with "vmcoredd_node"

I would say the justification of naming "vmcore_mem_node" is to keep
symmetry with "vmcoredd_node". If because it is a memory range, it really
should not be called vmcore_mem_node. As we know, memory node has
specific meaning in kernel, it's the memory range existing on a NUMA node.

And vmcoredd is not a widely used feature. At least in fedora/RHEL, we
leave it to customers themselves to use and handle, we don't support it.
And we add 'novmcoredd' to kdump kernel cmdline by default to disable it
in fedora/RHEL. So a rarely used feature should not be taken to decide
the naming of a mature and and widely used feature's name. My personal
opinion.

> 
> If there are strong feelings I can use a different name, but

Yes, I would suggest we better keep the old name or take a more
appropriate one if have to change.

> "vmcore_mem_node" really describes what it actually is. Especially now that
> we have different vmcore nodes.
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 



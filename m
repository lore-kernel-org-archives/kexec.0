Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D75C54E41
	for <kexec@archiver.kernel.org>; Thu, 29 Feb 2024 13:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TkYSW1izkIZqpWjeYUtHfXTVjyWyBcLoNKguGTF0b8E=; b=rzJh+riALsS6KW
	unXqHP81pGgewZFapb0R16BEefgb9w5+5EtW+TFoxGHvuHBnb37lwPYBHVySMcU/1wgxFuCW/Z0/W
	pLX+I6FK5vPOdRqmmza1DSbnVFv77TOLNkpAAJ2TuARW1mKTl5kJ1UswZwTChHNcvZjfBFXhkKAoY
	KUfmMdVrhfpqSdyJPduWRrWvPQ93aTCgGOm0pn0t6Ut0Lq7AxEdulr3bNMA4vyeeqGg+K8oEkqQSJ
	bSfSgFnClxe5hbhP06h6RMPtaIt8ZvgCGw4TP+euFWp/utLwOhek8dY6w7Q0PVmc3pWqcC3KE0G4R
	7ew9prciTw1u6olpkpdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfgoy-0000000DkLI-0aeq;
	Thu, 29 Feb 2024 13:51:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfgov-0000000DkJt-02eu
	for kexec@lists.infradead.org;
	Thu, 29 Feb 2024 13:51:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709214690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TN5YIBmif3fbyLCeCp8gDWRAz2xzCvRK6VuSUZrtJCQ=;
	b=SDmTCDztzQzceLulWcpM4vsCrswzSub11XT2A5qeFX1la9SLxM0MQ1btcx0mUZNesxjyN1
	IW95XBcFflTGWnVNdnegOmRsKNC58FFHJ7l8Vrq6FwLYUzODdAUN3+pK5s2LoEoHhyKkGn
	45uykrKv38oGKSji1HbAy8OFocNN9vc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-K3mSyQKKOb23YbUfw6MCSA-1; Thu, 29 Feb 2024 08:51:27 -0500
X-MC-Unique: K3mSyQKKOb23YbUfw6MCSA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52EBD1020200;
	Thu, 29 Feb 2024 13:51:26 +0000 (UTC)
Received: from localhost (unknown [10.72.116.6])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A415140C6EBA;
	Thu, 29 Feb 2024 13:51:24 +0000 (UTC)
Date: Thu, 29 Feb 2024 21:51:16 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Akhil Raj <lf32.dev@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Young <dyoung@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Laurent Dufour <laurent.dufour@fr.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mimi Zohar <zohar@linux.ibm.com>, Naveen N Rao <naveen@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
	x86@kernel.org
Subject: Re: [PATCH v17 0/6] powerpc/crash: Kernel handling of CPU and memory
 hotplug
Message-ID: <ZeCL1EsQ/vLojCYs@MiWiFi-R3L-srv>
References: <20240226084118.16310-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20240226084118.16310-1-sourabhjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240229_055133_148800_918335B8 
X-CRM114-Status: GOOD (  14.47  )
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

Hi Sourabh,

On 02/26/24 at 02:11pm, Sourabh Jain wrote:
> Commit 247262756121 ("crash: add generic infrastructure for crash
> hotplug support") added a generic infrastructure that allows
> architectures to selectively update the kdump image component during CPU
> or memory add/remove events within the kernel itself.
> 
> This patch series adds crash hotplug handler for PowerPC and enable
> support to update the kdump image on CPU/Memory add/remove events.
> 
> Among the 5 patches in this series, the first two patches make changes
> to the generic crash hotplug handler to assist PowerPC in adding support
> for this feature. The last three patches add support for this feature.

The whole series looks good to me. I have acked patch 1 and 2. Leave
those three ppc patches to ppc expert to review and approve. Thanks a
lot for your great work.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

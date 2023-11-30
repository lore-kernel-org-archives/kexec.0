Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E53C07CA9
	for <kexec@archiver.kernel.org>; Thu, 30 Nov 2023 12:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Fmyp/2WkGXH2fJW6nP4xc4+5zYgA5zwW+rA5VOP8ecU=; b=wZFvZH5w3Vedmm
	kv8wySl9MkA221D9rvmoHpfX1efs4RTbtHf7NJtTtEmhL/zAtDZWGV/WtUTI3n5w+98K6MbAzNBk3
	1Tv+l1Xmvw9tmu1NHggGFYYe4rcUmZVMIdjwG2x8FiYqj9FSfrAN8E5h2DiivDWtGDijCIi8x+nBv
	KaWOMdgdrjVx2xulqnYeEt867OlZ2GtbXYn8wmNqqq6E6WzU14mwH0ABKBeWiFG3HJCECOpDUumS2
	GO44vjyN1bN1yDwrPg52btunNPN2HDbvz6H0VNB14Y/5XozcdkSzlmlvdDqSiazp80gO4BUQAympt
	APe8HytrkoMEGEA+psCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8gCx-00ArV4-1b;
	Thu, 30 Nov 2023 12:31:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8gCv-00ArUD-15
	for kexec@lists.infradead.org;
	Thu, 30 Nov 2023 12:31:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701347511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rb8IOIu/t/qR1ytNoPyJ1c9zi9oIBJiXlmkbGz0coSs=;
	b=TojzbhA6Vz7/Aj9A7wV6up1SO8j3kokrWHVbw23XBlb16h3WAVJWrPMFndc6i9YxffmmR1
	XER80jvU4i6LJJciAEUA6OGG3pXwvXHcUN0z8Eq9gM0CGuXL3KKWjsP300pSaFCI8XdNXk
	Pno1Ae/3MkhUx6DAT0CgmSOk8gu1jO0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-z1SPdZvmN6qOwz4QTIffsA-1; Thu,
 30 Nov 2023 07:31:48 -0500
X-MC-Unique: z1SPdZvmN6qOwz4QTIffsA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 254401C07580;
	Thu, 30 Nov 2023 12:31:48 +0000 (UTC)
Received: from localhost (unknown [10.72.113.121])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E58C1C060BB;
	Thu, 30 Nov 2023 12:31:47 +0000 (UTC)
Date: Thu, 30 Nov 2023 20:31:44 +0800
From: Baoquan He <bhe@redhat.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Donald Dutile <ddutile@redhat.com>, Jiri Bohac <jbohac@suse.cz>,
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZWiAsJlLookvCI+h@MiWiFi-R3L-srv>
References: <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
 <ZWJllXCN0SDIELrX@dwarf.suse.cz>
 <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
 <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv>
 <ZWWuBSiZZdF2W12j@tiehlicka>
 <ZWbyDx3TJ7zo3jCw@MiWiFi-R3L-srv>
 <91a31ce5-63d1-7470-18f7-92b039fda8e6@redhat.com>
 <ZWf64BowWrYqA2Rf@MiWiFi-R3L-srv>
 <ZWhg_b3O6piZtkQ-@tiehlicka>
 <ZWh6ax8YmkhxAzIf@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZWh6ax8YmkhxAzIf@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231130_043153_446000_FE6F8EDE 
X-CRM114-Status: GOOD (  36.11  )
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

Hi Michal,

On 11/30/23 at 08:04pm, Baoquan He wrote:
> On 11/30/23 at 11:16am, Michal Hocko wrote:
> > On Thu 30-11-23 11:00:48, Baoquan He wrote:
> > [...]
> > > Now, we are worried if there's risk if the CMA area is retaken into kdump
> > > kernel as system RAM. E.g is it possible that 1st kernel's ongoing RDMA
> > > or DMA will interfere with kdump kernel's normal memory accessing?
> > > Because kdump kernel usually only reset and initialize the needed
> > > device, e.g dump target. Those unneeded devices will be unshutdown and
> > > let go. 


Re-read your mail, we are saying the same thing, Please ignore the
words at bottom from my last mail.

> > 
> > I do not really want to discount your concerns but I am bit confused why
> > this matters so much. First of all, if there is a buggy RDMA driver

Not buggy DMA or RDMA driver. This is decided by kdump mechanism. When
we do kexec reboot, we shutdown cpu, interrupt, all devicees. When we do
kdump, we only shutdown cpu, interrupt.

> > which doesn't use the proper pinning API (which would migrate away from
> > the CMA) then what is the worst case? We will get crash kernel corrupted
> > potentially and fail to take a proper kernel crash, right? Is this
> > worrisome? Yes. Is it a real roadblock? I do not think so. The problem

We may fail to take a proper kernel crash, why isn't it a roadblock? We
have stable way with a little more memory, why would we take risk to
take another way, just for saving memory? Usually only high end server
needs the big memory for crashkernel and the big end server usually have
huge system ram. The big memory will be a very small percentage relative
to huge system RAM.

> > seems theoretical to me and it is not CMA usage at fault here IMHO. It
> > is the said theoretical driver that needs fixing anyway.

Now, what we want to make clear is if it's a theoretical possibility, or
very likely happen. We have met several on-flight DMA stomping into
kexec kernel's initrd in the past two years because device driver didn't
provide shutdown() methor properly. For kdump, once it happen, the pain
is we don't know how to debug. For kexec reboot, customer allows to
login their system to reproduce and figure out the stomping. For kdump,
the system corruption rarely happend, and the stomping could rarely
happen too.

The code change looks simple and the benefit is very attractive. I
surely like it if finally people confirm there's no risk. As I said, we
can't afford to take the risk if it possibly happen. But I don't object
if other people would rather take risk, we can let it land in kernel.

My personal opinion, thanks for sharing your thought.

> > 
> > Now, it is really fair to mention that CMA backed crash kernel memory
> > has some limitations
> > 	- CMA reservation can only be used by the userspace in the
> > 	  primary kernel. If the size is overshot this might have
> > 	  negative impact on kernel allocations
> > 	- userspace memory dumping in the crash kernel is fundamentally
> > 	  incomplete.
> 
> I am not sure if we are talking about the same thing. My concern is:
> ====================================================================
> 1) system corrutption happened, crash dumping is prepared, cpu and
> interrupt controllers are shutdown;
> 2) all pci devices are kept alive;
> 3) kdump kernel boot up, initialization is only done on those devices
> which drivers are added into kdump kernel's initrd;
> 4) those on-flight DMA engine could be still working if their kernel
> module is not loaded;
> 
> In this case, if the DMA's destination is located in crashkernel=,cma
> region, the DMA writting could continue even when kdump kernel has put
> important kernel data into the area. Is this possible or absolutely not
> possible with DMA, RDMA, or any other stuff which could keep accessing
> that area?
> 
> The existing crashkernel= syntax can gurantee the reserved crashkernel
> area for kdump kernel is safe.
> =======================================================================
> 
> The 1st kernel's data in the ,cma area is ignored once crashkernel=,cma
> is taken.
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

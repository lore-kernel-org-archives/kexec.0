Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F03CCFA05
	for <kexec@archiver.kernel.org>; Fri,  7 Nov 2025 09:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qRBkHJa4BRGFROBjttcbTKceSh4EPFClBc48CB54JR8=; b=5B3iFsGMPU666lY/NElj1wYFHV
	O/GRYwJHV3Zqyaj4UifSy+pHIJZtHcmln15iLv9CCJzSxMpZRaRFkNvnP/KwXMQ/gBv8JiN3GgkzO
	xPOVDVP9Sn/ccOFnZQBrtGFnOb1XWxbvB/IqgdD9NFO9pDCESy0k6+TnjsSA8f5t4tlzXunxgwPAb
	tlZMQhzfTg5Vv2gBFoMb85ybduHD4+rWmL2U8vBR+9uzxhLXcIJEhbc9XyPoD+KhAyObUSseyvf2O
	Ad+cLxf2OF+CKJHq/kNy+zEjITlcv/4C3xdlCTGNfs/SoR6KlmCCK9tGYvDeiki+v6am5ccv3FxDw
	38scblSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHIot-0000000Gxi0-2uYq;
	Fri, 07 Nov 2025 09:31:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHIor-0000000GxhT-1sdS
	for kexec@lists.infradead.org;
	Fri, 07 Nov 2025 09:31:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762507904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qRBkHJa4BRGFROBjttcbTKceSh4EPFClBc48CB54JR8=;
	b=E1V/eJDx39d8W4nikfEMSpa1R5VSgeGViAjdfNu2zvNW15l3NMt3MNZStvmKwJONkUEjND
	veiYjTPulDi7bpNcat+uviUVcx15Q8rFdffrKKsjnT3pmgq1PGUgT9IYGf83vrBiN/UjRV
	RyURo4MEH6u50R/4k5uWn/2zKT9QYG4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-kc5534LfMnGD2FHOmi4G9A-1; Fri,
 07 Nov 2025 04:31:42 -0500
X-MC-Unique: kc5534LfMnGD2FHOmi4G9A-1
X-Mimecast-MFC-AGG-ID: kc5534LfMnGD2FHOmi4G9A_1762507901
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 717D619560B5;
	Fri,  7 Nov 2025 09:31:39 +0000 (UTC)
Received: from localhost (unknown [10.72.112.190])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE3161800346;
	Fri,  7 Nov 2025 09:31:37 +0000 (UTC)
Date: Fri, 7 Nov 2025 17:31:32 +0800
From: Baoquan He <bhe@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Alexander Graf <graf@amazon.com>,
	Steven Chen <chenste@linux.microsoft.com>, stable@vger.kernel.org
Subject: Re: [PATCHv2 2/2] kernel/kexec: Fix IMA when allocation happens in
 CMA area
Message-ID: <aQ28dGVP4UqsoIzI@MiWiFi-R3L-srv>
References: <20251106065904.10772-1-piliu@redhat.com>
 <20251106065904.10772-2-piliu@redhat.com>
 <aQxV2ULFzG/xrl7/@MiWiFi-R3L-srv>
 <CAF+s44TyM7sBVmGn7kn5Cw+Ygm02F93hchiSBN0Q_qR=oA+DLg@mail.gmail.com>
 <aQ1QiLGXWRsZbiYo@MiWiFi-R3L-srv>
 <CAF+s44TOt+EwGi9VDES9PC+VaGZoDCw6rbyRv_mnb0xbaLScbg@mail.gmail.com>
 <aQ2C1UyJoyyuC/ZK@MiWiFi-R3L-srv>
 <aQ21GVR1pEjzWvw1@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQ21GVR1pEjzWvw1@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251107_013145_565697_95793051 
X-CRM114-Status: GOOD (  34.75  )
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

On 11/07/25 at 05:00pm, Pingfan Liu wrote:
> On Fri, Nov 07, 2025 at 01:25:41PM +0800, Baoquan He wrote:
> > On 11/07/25 at 01:13pm, Pingfan Liu wrote:
> > > On Fri, Nov 7, 2025 at 9:51 AM Baoquan He <bhe@redhat.com> wrote:
> > > >
> > > > On 11/06/25 at 06:01pm, Pingfan Liu wrote:
> > > > > On Thu, Nov 6, 2025 at 4:01 PM Baoquan He <bhe@redhat.com> wrote:
> > > > > >
> > > > > > On 11/06/25 at 02:59pm, Pingfan Liu wrote:
> > > > > > > When I tested kexec with the latest kernel, I ran into the following warning:
> > > > > > >
> > > > > > > [   40.712410] ------------[ cut here ]------------
> > > > > > > [   40.712576] WARNING: CPU: 2 PID: 1562 at kernel/kexec_core.c:1001 kimage_map_segment+0x144/0x198
> > > > > > > [...]
> > > > > > > [   40.816047] Call trace:
> > > > > > > [   40.818498]  kimage_map_segment+0x144/0x198 (P)
> > > > > > > [   40.823221]  ima_kexec_post_load+0x58/0xc0
> > > > > > > [   40.827246]  __do_sys_kexec_file_load+0x29c/0x368
> > > > > > > [...]
> > > > > > > [   40.855423] ---[ end trace 0000000000000000 ]---
> > > > > > >
> > > > > > > This is caused by the fact that kexec allocates the destination directly
> > > > > > > in the CMA area. In that case, the CMA kernel address should be exported
> > > > > > > directly to the IMA component, instead of using the vmalloc'd address.
> > > > > >
> > > > > > Well, you didn't update the log accordingly.
> > > > > >
> > > > >
> > > > > I am not sure what you mean. Do you mean the earlier content which I
> > > > > replied to you?
> > > >
> > > > No. In v1, you return cma directly. But in v2, you return its direct
> > > > mapping address, isnt' it?
> > > >
> > > 
> > > Yes. But I think it is a fault in the code, which does not convey the
> > > expression in the commit log. Do you think I should rephrase the words
> > > "the CMA kernel address" as "the CMA kernel direct mapping address"?
> > 
> > That's fine to me.
> > 
> > > 
> > > > >
> > > > > > Do you know why cma area can't be mapped into vmalloc?
> > > > > >
> > > > > Should not the kernel direct mapping be used?
> > > >
> > > > When image->segment_cma[i] has value, image->ima_buffer_addr also
> > > > contains the physical address of the cma area, why cma physical address
> > > > can't be mapped into vmalloc and cause the failure and call trace?
> > > >
> > > 
> > > It could be done using the vmalloc approach, but it's unnecessary.
> > > IIUC, kimage_map_segment() was introduced to provide a contiguous
> > > virtual address for IMA access, since the IND_SRC pages are scattered
> > > throughout the kernel. However, in the CMA case, there is already a
> > > contiguous virtual address in the kernel direct mapping range.
> > > Normally, when we have a physical address, we simply use
> > > phys_to_virt() to get its corresponding kernel virtual address.
> > 
> > OK, I understand cma area is contiguous, and no need to map into
> > vmalloc. I am wondering why in the old code mapping cma addrss into 
> > vmalloc cause the warning which you said is a IMA problem. 
> > 
> 
> It doesn't go that far. The old code doesn't map CMA into vmalloc'd
> area.
> 
> void *kimage_map_segment(struct kimage *image, int idx)
> {
> 	...
>         for_each_kimage_entry(image, ptr, entry) {
>                 if (entry & IND_DESTINATION) {
>                         dest_page_addr = entry & PAGE_MASK;
>                 } else if (entry & IND_SOURCE) {
>                         if (dest_page_addr >= addr && dest_page_addr < eaddr) {
>                                 src_page_addr = entry & PAGE_MASK;
>                                 src_pages[i++] =
>                                         virt_to_page(__va(src_page_addr));
>                                 if (i == npages)
>                                         break;
>                                 dest_page_addr += PAGE_SIZE;
>                         }
>                 }
>         }
> 
>         /* Sanity check. */
>         WARN_ON(i < npages);     //--> This is the warning thrown by kernel
> 
>         vaddr = vmap(src_pages, npages, VM_MAP, PAGE_KERNEL);
>         kfree(src_pages);
> 
>         if (!vaddr)
>                 pr_err("Could not map ima buffer.\n");
> 
>         return vaddr;
> }
> 
> When CMA is used, there is no IND_SOURCE, so we have i=0 < npages.
> Now, I see how my words ("In that case, the CMA kernel address should be
> exported directly to the IMA component, instead of using the vmalloc'd
> address.") confused you. As for "instead of using the vmalloc'd
> address", I meant to mention "vmap()" approach.

Ok, I got it. It's truly a bug because if image->segment_cma[idx] is
valid, the current kimage_map_segment() can't collect the source pages
at all since they are not marked with IND_DESTINATION|IND_SOURCE as
normal segment does. In that situation, we can take the direct mapping
address of image->segment_cma[idx] which is more efficient, instead of
collecting source pages and vmap().



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140FBE69E9D
	for <kexec@archiver.kernel.org>; Tue,  3 Dec 2024 10:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xnrtD1CQI4UR1z9IWtbJHJhqD1dW84dYt1dsSz0U8Bw=; b=3L2mQ33Z8u9Tjv710FYkGvvzeE
	STLJ66ftMOFYs8f+exwvpORlP0p2/AVICyHy4Zw+3ap0h80t0xk/elj+XgUqkzFwyocnwpdzHWgKA
	WUoI699omQpIDhCt8lPwOpnhdIcjbPQUx7T3rXuTddgRR2gxQEok9PC9t1CF8Qg3UVdLt7/S6VxXM
	J0IaESgremki/hQnoleR5pfvR+6uN0JbDJv2RrgdXj/1yt3i5+D05RH1rd7ollICqUzZNzQW8srMp
	12Esx0UrdxyUCrs/VprCtPz8M/SptqEthrbc09VYPYx8iSZonwHpdA/fv+ZTMa+Z7LGNsQUTREG6o
	+kZMgfNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIQBB-000000094bu-1OxV;
	Tue, 03 Dec 2024 10:30:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIQB8-000000094bU-0fBo
	for kexec@lists.infradead.org;
	Tue, 03 Dec 2024 10:30:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733221849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xnrtD1CQI4UR1z9IWtbJHJhqD1dW84dYt1dsSz0U8Bw=;
	b=KJKQCNP2OA8kz6o8IXE8xHqbRy/8zvqmlukWyLJISybobu6Vz5DxtOvn2NO3Nhtx9N5FAn
	YY6BLgrBc5RMhc8RunKlx2XTc1Wr+eHIMTTRF/9lq2dD3DpOzp8LcJims1FYlHLwk4qObO
	7pgTpQzDrBwPGCzwj57DAGvb55uee08=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-D3Q6V3QqOVefF15VLWutmQ-1; Tue,
 03 Dec 2024 05:30:44 -0500
X-MC-Unique: D3Q6V3QqOVefF15VLWutmQ-1
X-Mimecast-MFC-AGG-ID: D3Q6V3QqOVefF15VLWutmQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C83861955D83;
	Tue,  3 Dec 2024 10:30:42 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 208F01956054;
	Tue,  3 Dec 2024 10:30:40 +0000 (UTC)
Date: Tue, 3 Dec 2024 18:30:36 +0800
From: Baoquan He <bhe@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	"Kirill A. Shutemov" <kirill@shutemov.name>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, x86@kernel.org,
	rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH] kexec_core: Accept unaccepted kexec destination addresses
Message-ID: <Z07dzP6ZdW3sNahj@MiWiFi-R3L-srv>
References: <87frop8r0y.fsf@email.froward.int.ebiederm.org>
 <tpbcun3d4wrnbtsvx3b3hjpdl47f2zuxvx6zqsjoelazdt3eyv@kgqnedtcejta>
 <87cyjq7rjo.fsf@email.froward.int.ebiederm.org>
 <ZxmRkUNmx863Po2U@yzhao56-desk.sh.intel.com>
 <Z0WzHZ+fNn6WuH/E@MiWiFi-R3L-srv>
 <Z0bt4HXAKqM3C1ZW@yzhao56-desk.sh.intel.com>
 <Z0iJ+DTPA2IkVDx7@MiWiFi-R3L-srv>
 <Z0lWkrsXSpDVfW72@yzhao56-desk.sh.intel.com>
 <Z03BbH5PgNrE81dz@MiWiFi-R3L-srv>
 <Z07YJlxK9/piXLhK@yzhao56-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z07YJlxK9/piXLhK@yzhao56-desk.sh.intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241203_023050_272893_0BF16119 
X-CRM114-Status: GOOD (  62.54  )
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

On 12/03/24 at 06:06pm, Yan Zhao wrote:
> On Mon, Dec 02, 2024 at 10:17:16PM +0800, Baoquan He wrote:
> > On 11/29/24 at 01:52pm, Yan Zhao wrote:
> > > On Thu, Nov 28, 2024 at 11:19:20PM +0800, Baoquan He wrote:
> > > > On 11/27/24 at 06:01pm, Yan Zhao wrote:
> > > > > On Tue, Nov 26, 2024 at 07:38:05PM +0800, Baoquan He wrote:
> > > > > > On 10/24/24 at 08:15am, Yan Zhao wrote:
> > > > > > > On Wed, Oct 23, 2024 at 10:44:11AM -0500, Eric W. Biederman wrote:
> > > > > > > > "Kirill A. Shutemov" <kirill@shutemov.name> writes:
> > > > > > > > 
> > > > > > > > > Waiting minutes to get VM booted to shell is not feasible for most
> > > > > > > > > deployments. Lazy is sane default to me.
> > > > > > > > 
> > > > > > > > Huh?
> > > > > > > > 
> > > > > > > > Unless my guesses about what is happening are wrong lazy is hiding
> > > > > > > > a serious implementation deficiency.  From all hardware I have seen
> > > > > > > > taking minutes is absolutely ridiculous.
> > > > > > > > 
> > > > > > > > Does writing to all of memory at full speed take minutes?  How can such
> > > > > > > > a system be functional?
> > > > > > > > 
> > > > > > > > If you don't actually have to write to the pages and it is just some
> > > > > > > > accounting function it is even more ridiculous.
> > > > > > > > 
> > > > > > > > 
> > > > > > > > I had previously thought that accept_memory was the firmware call.
> > > > > > > > Now that I see that it is just a wrapper for some hardware specific
> > > > > > > > calls I am even more perplexed.
> > > > > > > > 
> > > > > > > > 
> > > > > > > > Quite honestly what this looks like to me is that someone failed to
> > > > > > > > enable write-combining or write-back caching when writing to memory
> > > > > > > > when initializing the protected memory.  With the result that everything
> > > > > > > > is moving dog slow, and people are introducing complexity left and write
> > > > > > > > to avoid that bad implementation.
> > > > > > > > 
> > > > > > > > 
> > > > > > > > Can someone please explain to me why this accept_memory stuff has to be
> > > > > > > > slow, why it has to take minutes to do it's job.
> > > > > > > This kexec patch is a fix to a guest(TD)'s kexce failure.
> > > > > > > 
> > > > > > > For a linux guest, the accept_memory() happens before the guest accesses a page.
> > > > > > > It will (if the guest is a TD)
> > > > > > > (1) trigger the host to allocate the physical page on host to map the accessed
> > > > > > >     guest page, which might be slow with wait and sleep involved, depending on
> > > > > > >     the memory pressure on host.
> > > > > > > (2) initializing the protected page.
> > > > > > > 
> > > > > > > Actually most of guest memory are not accessed by guest during the guest life
> > > > > > > cycle. accept_memory() may cause the host to commit a never-to-be-used page,
> > > > > > > with the host physical page not even being able to get swapped out.
> > > > > > 
> > > > > > So this sounds to me more like a business requirement on cloud platform,
> > > > > > e.g if one customer books a guest instance with 60G memory, while the
> > > > > > customer actually always only cost 20G memory at most. Then the 40G memory
> > > > > > can be saved to reduce pressure for host.
> > > > > Yes.
> > > > 
> > > > That's very interesting, thanks for confirming.
> > > > 
> > > > > 
> > > > > > I could be shallow, just a wild guess.
> > > > > > If my guess is right, at least those cloud service providers must like this
> > > > > > accept_memory feature very much.
> > > > > > 
> > > > > > > 
> > > > > > > That's why we need a lazy accept, which does not accept_memory() until after a
> > > > > > > page is allocated by the kernel (in alloc_page(s)).
> > > > > > 
> > > > > > By the way, I have two questions, maybe very shallow.
> > > > > > 
> > > > > > 1) why can't we only find those already accepted memory to put kexec
> > > > > > kernel/initrd/bootparam/purgatory?
> > > > > 
> > > > > Currently, the first kernel only accepts memory during the memory allocation in
> > > > > a lazy accept mode. Besides reducing boot time, it's also good for memory
> > > > > over-commitment as you mentioned above.
> > > > > 
> > > > > My understanding of why the memory for the kernel/initrd/bootparam/purgatory is
> > > > > not allocated from the first kernel is that this memory usually needs to be
> > > > > physically contiguous. Since this memory will not be used by the first kernel,
> > > > > looking up from free RAM has a lower chance of failure compared to allocating it
> > > > 
> > > > Well, there could be misunderstanding here.The final loaded position of
> > > > kernel/initrd/bootparam/purgatory is not searched from free RAM, it's
> > > Oh, by free RAM, I mean system RAM that is marked as
> > > IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY, but not marked as
> > > IORESOURCE_SYSRAM_DRIVER_MANAGED.
> > > 
> > > 
> > > > just from RAM on x86. Means it possibly have been allocated and being
> > > > used by other component of 1st kernel. Not like kdump, the 2nd kernel of
> > > Yes, it's entirely possible that the destination address being searched out has
> > > already been allocated and is in use by the 1st kernel. e.g. for
> > > KEXEC_TYPE_DEFAULT, the source page for each segment is allocated from the 1st
> > > kernel, and it is allowed to have the same address as its corresponding
> > > destination address.
> > > 
> > > However, it's not guaranteed that the destination address must have been
> > > allocated by the 1st kernel.
> > > 
> > > > kexec reboot doesn't care about 1st kernel's memory usage. We will copy
> > > > them from intermediat position to the designated location when jumping.
> > > Right. If it's not guaranteed that the destination address has been accepted
> > > before this copying, the copying could trigger an error due to accessing an
> > > unaccepted page, which could be fatal for a linux TDX guest.
> > 
> > Oh, I just said the opposite. I meant we could search according to the
> > current unaccepted->bitmap to make sure the destination area definitely
> > have been accepted. This is the best if doable, while I know it's not
> > easy.
> Well, this sounds like introducing a new constraint in addition to the current
> checking of !kimage_is_destination_range() in locate_mem_hole_top_down() or
> locate_mem_hole_bottom_up(). (powerpc also has a different implementation).
> 
> This could make the success unpredictable, depending on how many pages have
> been accepted by the 1st kernel and the layout of the accepted pages(e.g.,
> whether they are physically contiguous). The 1st kernel would also have no
> reliable way to ensure success except by accepting all the guest pages.

Yeah, when I finished reading accept_memory code, this is the first idea
which come up into my mind. If it can be made, it's the most ideal. When
I tried to make a draft change, it does introduce a lot of code change and
add very much complication and I just gave up.

Maybe this can be added to cover-letter too to tell this possible path we
explored.



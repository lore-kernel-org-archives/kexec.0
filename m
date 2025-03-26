Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A600C36008
	for <kexec@archiver.kernel.org>; Wed, 26 Mar 2025 16:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cryOLtlUv/wnK3wghrxUGzQFVc+vixpm5OncZRYmfY0=; b=bnDFA1FjnMTANOSmaN2S9Mscea
	YM3U6KiGp3jwRLH+reDIIhv+pDlAAkYOlfuCz6bgmXWbe4xWp/QD7WG1ZV9i4jqQdEXy/W28e/TSz
	9ZYNGyTmf27a0zHz2jLUUgCKNdSr1unoYgYq1ixgOfKwewXS7/P1+og32mttlJwFjHDtiQOFEfMsi
	ONto7uQHEEB9nJxrdyg/+99EdvH3ymvEY+LT6dwun12SBfASjFxk5Bzusoyo8n65ED/O2kOiezwTA
	ffA47VRTdoXtbezhSEI45UDVz6frucJXED7e2Mjq0BzV9V4+dH5G16NNrYIpB5k41ovhxKlILp4YA
	0+w1NwEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txTSh-00000008zmz-0vLc;
	Wed, 26 Mar 2025 16:18:39 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txTSd-00000008zmq-3G5f
	for kexec@lists.infradead.org;
	Wed, 26 Mar 2025 16:18:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2A6946115A;
	Wed, 26 Mar 2025 16:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCB3C4CEE2;
	Wed, 26 Mar 2025 16:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743005913;
	bh=62UK7sgqLy7YlWGLIBWH0rQyGMv0oNWe5Wt7OkG2t2o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LdR103iIgMle3veCG5V4CzGebSd89g32/pXSAVfRo0VtzYkq549g6URwrOkAOoMTp
	 ZNz9gVD6klRNX6tPCqdnyua9NDkzPvB5i5TX7icqz62+gERX61O5MwWASeAokKPmSg
	 IBoKfCRXBjo6J3bIdmWdI/ng4e05Y04Pa/auc91ohtFbQR8WjixNnuH21lmrX05eig
	 8ZlDmEoIvsFD1gf0ksYdPaBa3g8DdAQ3J8swuXuls1/BaC6DPxcB7iecUNO0ZHwccO
	 pJNCcu832sqa5MuG7poxR/cUHswABVzUPNiRRoCcbyesdTSbL/69UEjph0YWiw58OX
	 YAF2ZRD++0lrQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  David Rientjes
 <rientjes@google.com>,  Alexander Graf <graf@amazon.com>,  Anthony Yznaga
 <anthony.yznaga@oracle.com>,  Dave Hansen <dave.hansen@intel.com>,  David
 Hildenbrand <david@redhat.com>,  Frank van der Linden <fvdl@google.com>,
  James Gowans <jgowans@amazon.com>,  Junaid Shahid <junaids@google.com>,
  Matthew Wilcox <willy@infradead.org>,  Mike Rapoport <rppt@kernel.org>,
  Pankaj Gupta <pankaj.gupta.linux@gmail.com>,  Pasha Tatashin
 <tatashin@google.com>,  Vipin Sharma <vipinsh@google.com>,  Vishal
 Annapurve <vannapurve@google.com>,  "Woodhouse, David"
 <dwmw@amazon.co.uk>,  linux-mm@kvack.org,  kexec@lists.infradead.org
Subject: Re: [Hypervisor Live Update] Notes from March 10, 2025
In-Reply-To: <20250320122303.GT9311@nvidia.com>
References: <a350f3e5-e764-4ba6-f871-da7252f314da@google.com>
	<20250317172255.GO9311@nvidia.com>
	<755e80a2-60a7-4a04-9eb2-714e89ea34c5@app.fastmail.com>
	<20250320122303.GT9311@nvidia.com>
Date: Wed, 26 Mar 2025 16:18:29 +0000
Message-ID: <mafs0a597sr3e.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Thu, Mar 20 2025, Jason Gunthorpe wrote:

>> I didn't mean the exact flags value, but the ability to have
>> per-folio flags. The exact bits and their meaning would of course
>> need to be part of the ABI. Shmem uses the dirty and uptodate flags
>> to track some state on the folios, and the flags can affect it's
>> behavior (lazily zeroing out falloc-ed pages for example). I am
>> assuming other FD types or drivers might also want to store
>> per-folio information. Having KHO core provide this facility can
>> avoid duplicating the logic in each subsystem.
>
> For something simple like shmem I'd probably just suggest a side car bitmap
> array or something?
>
> The trouble with trying to feed flags through the xarray thing is that
> the memory holding that pfn data across the kexec is not itself
> preserved memory so it is all blown away once the allocator starts.
>
> Any data that needs to be preserved further has to be copied into the
> frozen struct page, which is pretty limiting in terms of what you
> could preserve. A few bits could maybe work out but not alot of data.

Right, that makes sense. I can live with a sidecar bitmap then.

[...]

-- 
Regards,
Pratyush Yadav


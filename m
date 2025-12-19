Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A992BD70E0C
	for <kexec@archiver.kernel.org>; Fri, 19 Dec 2025 02:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R8WSwda8aCwUFMf9p9V9U8flnGon/LLI3QQDyLCvne4=; b=z3DFi52l9MqckYB48hsrwzq2Bx
	I9L3Z8BgBB7o5Aj6bum2jA7cwigsXIu7sSyw0YVa8iCvU0FrFEbbXiBLNcGE+Rc55jL8hbX2Ru6OI
	gFjgEQqenab/dZf9aRyhun7pkAzrbhlrNl+lpjkpiJfqFNqfRrawBySUfp+Gpg01yneII2W03HiOd
	TfoJrm81mmMjrs2rAdy7nNpdCJl7VFrWjC6Waiz64kgSvXSiBQvjW6JaUwRL3FuLXCkr5nL42HiVs
	HVgiQMskjbFPZ6eHe/fZ8ognwQtCuW0CC+Ay7zvYpK3LaZwExn6HLFboq2/S8nPYtwenxSaRsvPwZ
	LNIWxylw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWQMa-00000009VDz-0beD;
	Fri, 19 Dec 2025 02:37:04 +0000
Received: from mgamail.intel.com ([198.175.65.11])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWQMY-00000009VDe-0hcI
	for kexec@lists.infradead.org;
	Fri, 19 Dec 2025 02:37:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766111822; x=1797647822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=X+YwzWCOh60oHo8bc6TUp/24v2nNpKPQBBb0/fSOWYQ=;
  b=n0GgV8P88vTc/CtNooGuGnZs0MRG0T1h4H30ISPMpKLSObfgw5jGXjBA
   dgiqYrj0ZZfJ7QS2hBmIi1IZG/MfVoFk+7GH9qOkm39g3nljCOmNIcvpl
   2j5s8HoPKDpRm8ykKFBPWs9KMAMIUBau6pKIxOmenJqP0QDlwEwbzxTtc
   eG2nacED+WVcTM6j/nSugzAHHylqwWL6KM8HEQW/7TLKKy6+VMP6KhvgZ
   v2hLSpmnWE1iWntbA2qOhitXX83fHXkJ9K7uAY6a6xPC33yFYBjh535t4
   n+8DAX69i0YjRzWambIqjn2wy7KhDQfYAePeugQ+0e7gn0WYAlbOocw6o
   w==;
X-CSE-ConnectionGUID: hXIgD3fyTfC4KHraEd5sPw==
X-CSE-MsgGUID: gKnl9HzLSJOQY4kI+a1hLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="78390942"
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="78390942"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 18:37:02 -0800
X-CSE-ConnectionGUID: be/p+YKgQL22VTnvotngOg==
X-CSE-MsgGUID: TDawHjBaRnSr63HrEZjweA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="202918593"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 18:37:01 -0800
Date: Thu, 18 Dec 2025 18:43:41 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, bhe@redhat.com, rppt@kernel.org,
	jasonmiu@google.com, arnd@arndb.de, coxu@redhat.com,
	dave@vasilevsky.ca, ebiggers@google.com, graf@amazon.com,
	kees@kernel.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	ricardo.neri@intel.com
Subject: Re: [PATCH v2 11/13] kho: Allow kexec load before KHO finalization
Message-ID: <20251219024341.GC17600@ranerica-svr.sc.intel.com>
References: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
 <20251114190002.3311679-12-pasha.tatashin@soleen.com>
 <20251218215613.GA17304@ranerica-svr.sc.intel.com>
 <CA+CK2bDucySNG7QqE87bZndgjKH-QCw61romZVExD63S2iM6og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bDucySNG7QqE87bZndgjKH-QCw61romZVExD63S2iM6og@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251218_183702_248552_CBE0AD0A 
X-CRM114-Status: GOOD (  28.78  )
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

On Thu, Dec 18, 2025 at 07:26:19PM -0500, Pasha Tatashin wrote:
> On Thu, Dec 18, 2025 at 4:49 PM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > On Fri, Nov 14, 2025 at 02:00:00PM -0500, Pasha Tatashin wrote:
> > > Currently, kho_fill_kimage() checks kho_out.finalized and returns
> > > early if KHO is not yet finalized. This enforces a strict ordering where
> > > userspace must finalize KHO *before* loading the kexec image.
> > >
> > > This is restrictive, as standard workflows often involve loading the
> > > target kernel early in the lifecycle and finalizing the state (FDT)
> > > only immediately before the reboot.
> > >
> > > Since the KHO FDT resides at a physical address allocated during boot
> > > (kho_init), its location is stable. We can attach this stable address
> > > to the kimage regardless of whether the content has been finalized yet.
> > >
> > > Relax the check to only require kho_enable, allowing kexec_file_load
> > > to proceed at any time.
> > >
> > > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> > > ---
> > >  kernel/liveupdate/kexec_handover.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> > > index 461d96084c12..4596e67de832 100644
> > > --- a/kernel/liveupdate/kexec_handover.c
> > > +++ b/kernel/liveupdate/kexec_handover.c
> > > @@ -1550,7 +1550,7 @@ int kho_fill_kimage(struct kimage *image)
> > >       int err = 0;
> > >       struct kexec_buf scratch;
> > >
> > > -     if (!kho_out.finalized)
> > > +     if (!kho_enable)
> > >               return 0;
> >
> > Hi Pasha,
> >
> > Using v6.19-rc1 (which has this changeset) and with:
> >
> > CONFIG_KEXEC_HANDOVER=y
> > CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT=y
> > CONFIG_LIVEUPDATE=n (i.e., nobody calling kho_finalize())
> > no reserve_mem= entries in the kernel command line
> >
> > I omit doing
> >
> > echo 1 > /sys/kernel/debug/kho/out/finalize
> >
> > before doing
> >
> > kexec -l <kernel> --initrd=<initrd> --commandline="$(cat /proc/cmdline)"
> > kexec -e
> 
> Hi Ricardo,
> 
> Thank you for reporting this bug. I created a fix here:
> https://lore.kernel.org/lkml/20251219002355.3323896-1-pasha.tatashin@soleen.com
> 
> Please let me know if it works.

Thanks for the quick reply, Pasha. Your patch does work for me (I saw you
will post a v2).

From this patchset, I gather that kho_finalize() can be called multiple
times and in-kernel users of KHO should call it when done preparing their
subrees. Is that correct?


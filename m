Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D3EC54791
	for <kexec@archiver.kernel.org>; Wed, 13 Mar 2024 12:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:
	In-Reply-To:Date:References:Cc:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=iRHQvZFaY37pcrg1AUGS9ps8oI42qqLkrTh8BkCEWAc=; b=rOrbZPOua0dF91zWEatRy7WYkv
	SqJaQtGmxUNiakje1VlOmbueCJPpH28pyeTpwVmtN+ILBFAb74rRWzPsQZkHLtttCGcrkQIC1VGiO
	TjRd4VZiE/+IFqs+kGiFg634S5bGyJzfJack2PTohQHAv6/fZjCF0JkjwHubHthtfOP5ZV7LpzbVe
	CMsaHbjNz1KpCrOrkoU6lHbOYVlY+HgrWple0kxrGNULSfV+H0UidWvUZEWUefPD/0tnbIqG1ebnQ
	CaFTHrPVSsGmloFfZOok7jm9UviNgYWPTU70IXEaLYIdD9MLdAUgemmA7gCqd/qMGfwG4Og0BFH49
	/9j0968g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkNXu-0000000A2ai-2Amh;
	Wed, 13 Mar 2024 12:17:22 +0000
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkNXc-0000000A2Ml-3abx
	for kexec@lists.infradead.org;
	Wed, 13 Mar 2024 12:17:20 +0000
Received: from in02.mta.xmission.com ([166.70.13.52]:39550)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rkNXJ-00H1bY-N3; Wed, 13 Mar 2024 06:16:45 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:46688 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rkNXI-004qp3-Ax; Wed, 13 Mar 2024 06:16:45 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Pavin Joseph <me@pavinjoseph.com>,  Simon Horman <horms@verge.net.au>,
  kexec@lists.infradead.org,  Eric Hagberg <ehagberg@gmail.com>,
  dave.hansen@linux.intel.com,  regressions@lists.linux.dev,
  stable@vger.kernel.org
References: <CAJbxNHe3EJ88ABB1aZ8bYZq=a36F0TFST1Fqu4fkugvyU_fjhw@mail.gmail.com>
	<ZensTNC72DJeaYMo@swahl-home.5wahls.com>
	<CAJbxNHfPHpbzRwfuFw6j7SxR1OsgBH2VJFPnchBHTtRueJna4A@mail.gmail.com>
	<ZfBxIykq3LwPq34M@swahl-home.5wahls.com>
	<42e3e931-2883-4faf-8a15-2d7660120381@pavinjoseph.com>
	<ZfDQ3j6lOf9xgC04@swahl-home.5wahls.com>
Date: Wed, 13 Mar 2024 07:16:23 -0500
In-Reply-To: <ZfDQ3j6lOf9xgC04@swahl-home.5wahls.com> (Steve Wahl's message of
	"Tue, 12 Mar 2024 17:02:06 -0500")
Message-ID: <87cyryxr6w.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1rkNXI-004qp3-Ax;;;mid=<87cyryxr6w.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18sVY/cAP35iOPKjLWyn/7yGz20+NXnxZQ=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [REGRESSION] kexec does firmware reboot in kernel v6.7.6
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240313_051705_418639_1CAF1247 
X-CRM114-Status: GOOD (  45.78  )
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

Steve Wahl <steve.wahl@hpe.com> writes:

> [*really* added kexec maintainers this time.]
>
> Full thread starts here:
> https://lore.kernel.org/all/3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com/
>
> On Wed, Mar 13, 2024 at 12:12:31AM +0530, Pavin Joseph wrote:
>> On 3/12/24 20:43, Steve Wahl wrote:
>> > But I don't want to introduce a new command line parameter if the
>> > actual problem can be understood and fixed.  The question is how much
>> > time do I have to persue a direct fix before some other action needs
>> > to be taken?
>> 
>> Perhaps the kexec maintainers [0] can be made aware of this and you could
>> coordinate with them on a potential fix?
>> 
>> Currently maintained by
>> P:      Simon Horman
>> M:      horms@verge.net.au
>> L:      kexec@lists.infradead.org
>
> Probably a good idea to add kexec people to the list, so I've added
> them to this email.
>
> Everyone, my recent patch to the kernel that changed identity mapping:
>
> 7143c5f4cf2073193 x86/mm/ident_map: Use gbpages only where full GB page should be mapped.
>
> ... has broken kexec on a few machines.  The symptom is they do a full
> BIOS reboot instead of a kexec of the new kernel.  Seems to be limited
> to AMD processors, but it's not all AMD processors, probably just some
> characteristic that they happen to share.
>
> The same machines that are broken by my patch, are also broken in
> previous kernels if you add "nogbpages" to the kernel command line
> (which makes the identity map bigger, "nogbpages" doing for all parts
> of the identity map what my patch does only for some parts of it).
>
> I'm still hoping to find a machine I can reproduce this on to try and
> debug it myself.
>
> If any of you have any assistance or advice to offer, it would be most
> welcome!

Kexec happens on identity mapped page tables.

The files of interest are machine_kexec_64.c and relocate_kernel_64.S

I suspect either the building of the identity mappged page table in
machine_kexec_prepare, or the switching to the page table in
identity_mapped in relocate_kernel_64.S is where something goes wrong.

Probably in kernel_ident_mapping_init as that code is directly used
to build the identity mapped page tables.

Hmm.

Your change is commit d794734c9bbf ("x86/mm/ident_map: Use gbpages only
where full GB page should be mapped.")

Given the simplicity of that change itself my guess is that somewhere in
the first 1Gb there are pages that needed to be mapped like the idt at 0
that are not getting mapped.

Reading through the changelog:
>   x86/mm/ident_map: Use gbpages only where full GB page should be mapped.
>    
>    When ident_pud_init() uses only gbpages to create identity maps, large
>    ranges of addresses not actually requested can be included in the
>    resulting table; a 4K request will map a full GB.  On UV systems, this
>    ends up including regions that will cause hardware to halt the system
>    if accessed (these are marked "reserved" by BIOS).  Even processor
>    speculation into these regions is enough to trigger the system halt.
>    
>    Only use gbpages when map creation requests include the full GB page
>    of space.  Fall back to using smaller 2M pages when only portions of a
>    GB page are included in the request.
>    
>    No attempt is made to coalesce mapping requests. If a request requires
>    a map entry at the 2M (pmd) level, subsequent mapping requests within
>    the same 1G region will also be at the pmd level, even if adjacent or
>    overlapping such requests could have been combined to map a full
>    gbpage.  Existing usage starts with larger regions and then adds
>    smaller regions, so this should not have any great consequence.
>    
>    [ dhansen: fix up comment formatting, simplifty changelog ]
>    
>    Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
>    Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
>    Cc: stable@vger.kernel.org
>    Link: https://lore.kernel.org/all/20240126164841.170866-1-steve.wahl%40hpe.com

I know historically that fixed mtrrs were used so that the first 1GiB
could be covered with page tables and cause problems.

I suspect whatever those UV systems are more targeted solution would be
to use the fixed mtrrs to disable caching and speculation on the
problematic ranges rather than completely changing the fundamental logic
of how pages are mapped.

Right now it looks like you get to play a game of whack-a-mole with
firmware/BIOS tables that don't mention something important, and
ensuring the kernel maps everything important in the first 1GiB.

It might be worth setting up early printk on some of these systems
and seeing if the failure is in early boot up of the new kernel (that is
using kexec supplied identity mapped pages) rather than in kexec per-se.

But that is just my guess at the moment.

Eric




>> I hope the root cause can be fixed instead of patching it over with a flag
>> to suppress the problem, but I don't know how regressions are handled here.
>
> That would be my preference as well.
>
> Thanks,
>
> --> Steve Wahl

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

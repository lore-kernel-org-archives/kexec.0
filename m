Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96EC3C77B71
	for <kexec@archiver.kernel.org>; Sat, 15 Apr 2023 00:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QwoJffPV+R+ca2qIlwevrHyKi104KhfIvl+rDMwFNwI=; b=YzQBozbpfsoX2S
	roibCUHKz2M65Y1MAf7ki/t3ba1Uxix268y5sUvgNvS187ptPbGwyFUCF0gqPyMBY36WqJL8UG4lW
	hbnHy36dKcOA2oKIJwa2WF6UFS6UNCA3TOFt0eQ2Cs9FFRNYWWdWtHkzeI3lT32vvJaFRirhr6JTv
	8B+wXprLVtlgKdd44g6FDdZQKy6j1RKy45Eg+lETMKSFIrrNtgJg6Iho1/MqgW/+QNUJRQyKzrVWJ
	XDsiIXuA73pAnSwhjQdD0ZXz2QuqwDAIsjpnvYNrJY9q5Dl9UHsZDZoZ3MiKnQAdAXL0DmkpGRY2g
	ocOHsf2X5RUA6KBC3GkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pnU0v-00Av6L-2p;
	Sat, 15 Apr 2023 00:43:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pnU0q-00Av5S-2k
	for kexec@lists.infradead.org;
	Sat, 15 Apr 2023 00:43:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1681519410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jLzcmt6yXFfM7kna/P8KGa04zAmCOpl3/oE8xB2gQTc=;
	b=XB3qPf6OetSzbtDFwLsSEx0Jcw3AhCe06kYPIf3SgiNWkfFkoiyXCktMYN2DvTfd1DmXa0
	U6lHU6KBrwueLTgpBrivN8a0x/0ukn/tpLidPz2HjVNjAkxw4gf3PAWL95ltGYF0aJ3/79
	/tjH9fCWUEeIlo51S8ewniU56wTMFDI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-2cQ0V8l1PEOwMptCbG6fhg-1; Fri, 14 Apr 2023 20:43:24 -0400
X-MC-Unique: 2cQ0V8l1PEOwMptCbG6fhg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2B792823815;
	Sat, 15 Apr 2023 00:43:23 +0000 (UTC)
Received: from localhost (ovpn-12-58.pek2.redhat.com [10.72.12.58])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 91CDE1121320;
	Sat, 15 Apr 2023 00:43:22 +0000 (UTC)
Date: Sat, 15 Apr 2023 08:43:17 +0800
From: Baoquan He <bhe@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, catalin.marinas@arm.com, horms@kernel.org,
	thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <ZDnzJaqQLkllQox1@MiWiFi-R3L-srv>
References: <20230407022419.19412-1-bhe@redhat.com>
 <20230414143413.GA27911@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230414143413.GA27911@willie-the-truck>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230414_174333_040833_7D494E25 
X-CRM114-Status: GOOD (  27.94  )
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

On 04/14/23 at 03:34pm, Will Deacon wrote:
> Hi,
> 
> On Fri, Apr 07, 2023 at 10:24:19AM +0800, Baoquan He wrote:
> > On arm64, reservation for 'crashkernel=xM,high' is taken by searching for
> > suitable memory region top down. If the 'xM' of crashkernel high memory
> > is reserved from high memory successfully, it will try to reserve
> > crashkernel low memory later accoringly. Otherwise, it will try to search
> > low memory area for the 'xM' suitable region. Please see the details in
> > Documentation/admin-guide/kernel-parameters.txt.
> 
> [...]
> 
> >  arch/arm64/mm/init.c | 44 ++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 34 insertions(+), 10 deletions(-)
> 
> I tried to apply this, but smatch is unhappy with the result:
> 
>   | arch/arm64/mm/init.c:153 reserve_crashkernel() error: uninitialized symbol 'search_base'.
> 
> I _think_ this is a false positive, but I must say that the control flow
> in reserve_crashkernel() is extremely hard to follow so I couldn't be
> sure. If the static checker is struggling, then so will humans!
> 
> Ideally, this would all be restructured to make it easier to follow,
> but in the short term we need something to squash the warning.

Sorry for that, I didn't run static checker. We should do initialization
as below to fix the warning. Below code can be added into this v5 patch,
or I can post v6 with Catalin's Reviewed-by tag.

Yes, about restructuring, I can think about it later. The added corner
cases handling specific for arm64 makes the flow a little harder to
flow. I will consider if adding document in arm64 is better.

From 3575571ab9614c31f30933148a8693924a30321c Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Sat, 15 Apr 2023 08:35:08 +0800
Subject: [PATCH] arm64: kdump: fix warning reported by static checker
Content-type: text/plain

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/arm64/mm/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 13750b0548da..bfc117cefcd5 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -128,9 +128,9 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
  */
 static void __init reserve_crashkernel(void)
 {
-	unsigned long long crash_base, crash_size, search_base;
+	unsigned long long crash_low_size = 0, search_base = 0;
 	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
-	unsigned long long crash_low_size = 0;
+	unsigned long long crash_base, crash_size;
 	char *cmdline = boot_command_line;
 	bool fixed_base = false;
 	bool high = false;
-- 
2.34.1



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

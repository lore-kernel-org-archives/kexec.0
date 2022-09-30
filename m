Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D01EC433FE
	for <kexec@archiver.kernel.org>; Fri, 30 Sep 2022 09:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xtd1adCwtXQXSy3LTrlbgZ7qg0qc6Z1jJez4xsbO/OI=; b=tC7E56ZBX647uG
	kPzSocyjG+6sx+sgMxNbu3JHprK6lsNi4GLXBOpTpZF8cuWPdSHUMjOElZH0N056fGglUd2LLZ6S3
	Y92YQJw8wRnJ1xK0Ser2zJVPyOeXkg0lSWnuJSS/qVZKsbhABmXrLhPYP9RZ2lno1tiO1CAuA/MVd
	n5VnTWD02256yN2pu5CmPPXc5jcYNPoYGEiMio+p9vyun4pr8A9R9nUBP7OVwLrCC4f9gdnTSLnqP
	RibeuIJLso1zwUY9OZT4dCp7hlbXYXonrAXHyHQjAcCc3NfL38zkmJ2+xwW5lDvVCIyQDUy1XVOiY
	nZLTwHaNG7ZDnRjXjoHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeCGX-008L6W-J6; Fri, 30 Sep 2022 09:25:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeCGV-008L4D-DA
	for kexec@lists.infradead.org; Fri, 30 Sep 2022 09:25:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664529900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L1SJANDr5slVxmH6M0J7RBmBMz9Cu2VImN3b1/69eLw=;
	b=VdpMjzDQoRigyzxiXJChIEX0Mkcdn3eNvi6GbZ7HKW5LHAGJMkgJ943XOyF4TkTZvfRK4g
	JD+/NHvR7qYhqYX6eIJtfT72+ElP1agEJEH2shAYL+U4cJfRInguaJl5gkEqPaORcyFkeX
	ubGe3UVbniZexHFv5lg9p/SuJtFGZJA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-HRAnQ8q2MTqo1Wm3tV42Tg-1; Fri, 30 Sep 2022 05:24:54 -0400
X-MC-Unique: HRAnQ8q2MTqo1Wm3tV42Tg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EAB6C804184;
	Fri, 30 Sep 2022 09:24:53 +0000 (UTC)
Received: from localhost (ovpn-12-133.pek2.redhat.com [10.72.12.133])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id ACE17492CA2;
	Fri, 30 Sep 2022 09:24:52 +0000 (UTC)
Date: Fri, 30 Sep 2022 17:24:48 +0800
From: Baoquan He <bhe@redhat.com>
To: Mike Rapoport <rppt@kernel.org>, Chao Ye <cye@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	guanghuifeng@linux.alibaba.com, mark.rutland@arm.com,
	will@kernel.org, linux-mm@kvack.org, thunder.leizhen@huawei.com,
	wangkefeng.wang@huawei.com, kexec@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64, kdump: enforce to take 4G as the crashkernel
 low memory end
Message-ID: <Yza14IroN9Ke/3uN@MiWiFi-R3L-srv>
References: <20220828005545.94389-2-bhe@redhat.com>
 <Yw8PvF5d2uuWy6Cl@kernel.org>
 <Yw9wU/S8cP0ntR3g@MiWiFi-R3L-srv>
 <YxBeS0G+F+fsBgod@kernel.org>
 <YxCk0mX5IzhvK9Pv@MiWiFi-R3L-srv>
 <YxXPannyTqBZInAt@kernel.org>
 <YxXmsKYGTd1+/U12@MiWiFi-R3L-srv>
 <CAMj1kXFDhbMPNcFnogyi7RXATqyHpqJLK9wiz=djRM3g65J8Zg@mail.gmail.com>
 <YyrBFvD2ID8sqhEK@kernel.org>
 <YzaU99WgKFzpSN4P@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YzaU99WgKFzpSN4P@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220930_022503_529184_38243291 
X-CRM114-Status: GOOD (  29.55  )
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

On 09/30/22 at 03:04pm, Baoquan He wrote:
> Hi Mike,
> 
> On 09/21/22 at 10:45am, Mike Rapoport wrote:
> > On Tue, Sep 06, 2022 at 03:05:57PM +0200, Ard Biesheuvel wrote:
> > > 
> > > While I appreciate the effort that has gone into solving this problem,
> > > I don't think there is any consensus that an elaborate fix is required
> > > to ensure that the crash kernel can be unmapped from the linear map at
> > > all cost. In fact, I personally think we shouldn't bother, and IIRC,
> > > Will made a remark along the same lines back when the Huawei engineers
> > > were still driving this effort.
> > > 
> > > So perhaps we could align on that before doing yet another version of this?
> > 
> > I suggest to start with disabling crash kernel protection when its memory
> > reservation is deferred and then Baoquan and kdump folks can take it from
> > here.
> 
> Thanks for the attempt, really appreciated. We all tried and all see
> everybody's effort on this issue.
> 
> If disabling protection is chosen, I would suggest disable it at all.
> The system w/o having CONFIG_ZONE_DMA|32 is rarely seen, I don't think
> we need do the protection for it specifically to make code inconsistent
> and could confuse people. We can revert below commit and its later
> change do to that.
> 
> commit 98d2e1539b84 ("arm64: kdump: protect crash dump kernel memory")
> 
> For RPi4, I tried to find one to test and figure out if it can do crash
> dumping with buffer above 1G. However, nobody care about kdump when I
> asked people around who have one at hand for testing, hobby, or
> developping. Since they are not familiar with kdump setting and not so
> eager to get to know, and I don't want to take up too much time, finally
> I just give up.

Finally, I got help from Chao who is team lead of our kernel QE. Chao
has a RPi4 and he tested different cases of kdump, now we can confirm
that on RPi4 the TF card and usb disk are all 30bit DMA addressing
limited. Just FYI. And thanks again to Chao for his help and patience.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

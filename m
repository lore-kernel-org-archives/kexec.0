Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D70BC43458
	for <kexec@archiver.kernel.org>; Mon, 13 Jul 2026 10:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gD3A9pJWmGNBEpcGuAJUTYfdEqwu/kB9DlQTnjeCkJU=; b=VUH3eDaEBB5z3nrgQiJGVHqFu0
	TNKaPezTI80hKzVmcac6QDaQyejf5xS2yximeqgrMHtWLJUiauyvCMlxO4fMNRl/aBOyWwe7ATRIB
	V1DI5jTuIuCVydRwfjv0juT7TI6Vgj34QRV2HR8e2D8a3crtKu2cMR5IR7W9JOFyJLHs3zbnhQyUb
	OXZ/19K5T+CQVhDrnUASL1FPn9MsI+zwoA9azG5cGDHLzrJoxCMJ3v6vSXoGvp7yCNROErKEzhwZD
	aa2I9zGNYxqgeqKqiOtayNDzKzJ1zMCYdoulNLrBJ00KB6xcCFqCzkhkF4qTaX7Mb5O1ee88hplh7
	RtmS/xLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjEG5-00000008vkz-2VhT;
	Mon, 13 Jul 2026 10:51:33 +0000
Received: from out-182.mta1.migadu.com ([95.215.58.182])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjEG1-00000008vjy-3Si6;
	Mon, 13 Jul 2026 10:51:32 +0000
Date: Mon, 13 Jul 2026 18:51:15 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783939886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gD3A9pJWmGNBEpcGuAJUTYfdEqwu/kB9DlQTnjeCkJU=;
	b=PbACmgzyg49Tkt0MnyM5u8X5Npc6gqSDxGyrXUuvFQftDo4XLRDP4h/5xfXzgVqm95CVPW
	KZABNZjNng9M8/0G9vdNu7G8AgDqhTdFwj1LWFKBKru/YE0uToUtZW3lVP7FftA86r5DX3
	aIXLrXciYsHVhutR0ciWNRoPO6oOFAs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Baoquan He <baoquan.he@linux.dev>
To: Breno Leitao <leitao@debian.org>
Cc: Baoquan He <bhe@redhat.com>, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	dyoung@redhat.com, tony.luck@intel.com, xueshuai@linux.alibaba.com,
	vgoyal@redhat.com, zhiquan1.li@intel.com, olja@meta.com,
	kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] vmcoreinfo: expose hardware error recovery
 statistics via sysfs
Message-ID: <alTDI53vd4u_YY_G@MiWiFi-R3L-srv>
References: <20260202-vmcoreinfo_sysfs-v2-0-8f3b5308b894@debian.org>
 <20260202-vmcoreinfo_sysfs-v2-1-8f3b5308b894@debian.org>
 <aYvi4Y_HNqk_u1-v@fedora>
 <ak0JSScR3EYgLEf9@gmail.com>
 <alDRawveM-auCHwB@MiWiFi-R3L-srv>
 <alSqd2U9zhqYz1Wn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alSqd2U9zhqYz1Wn@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_035130_079787_27551774 
X-CRM114-Status: GOOD (  10.81  )
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

On 07/13/26 at 02:08am, Breno Leitao wrote:
> On Fri, Jul 10, 2026 at 07:03:07PM +0800, Baoquan He wrote:
> 
> > Anyway, I am glad to see it's been taken out of vmcoreinfo.c,
> > which is going in the right way from kdump side. For its migrating
> > into driver folder, leave it to the relevant reviewer to review and
> > decide.
> 
> On that patch, If you could confirm that moving it away from vmcoreinfo
> is the preferred approach, that would help establish consensus around
> the right direction.

Yes, I can confirm moving it away from vmcoreinfo is expected.



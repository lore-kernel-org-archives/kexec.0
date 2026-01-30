Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6885D61037
	for <kexec@archiver.kernel.org>; Fri, 30 Jan 2026 11:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RWrHjYgZgg+KSNMmeqGnhJJifZmxh3jh3m1lxZ6fpOk=; b=Jff2YpmYAmklcQ7cGwq7layBVS
	19b4l5QVQTBHMTVoWViZBj8t8iJ3okqcfPY4qNu2hjT6pBmCCXLmbEII+im/JsEHICskwa8Rc/TKI
	9vI9qJSQl1SoswWWdJA++qPCCneyCI5JcGU9UleMCOE4uN+XMwdzfqhQo6d3f7NJVfAkjGgP6oA03
	oWWeEMWfnvxNNwszcxVNlG4PQo6RTtgN4PW9jbJxGIq0XFpSB1pk6oDgZ6KmFAtZUXxXJlUp0eGYz
	Ia82Fuf8HyEBnyoy5u9I2ybpNUH9efP7lGyr2vw1+2DHRVr88p1CdiN8UbkaQGKrWz1La/A+ZeCo3
	h+XpHgvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlmML-00000001Oz3-1zOA;
	Fri, 30 Jan 2026 11:08:17 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlmMJ-00000001OyR-1WB3
	for kexec@lists.infradead.org;
	Fri, 30 Jan 2026 11:08:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RWrHjYgZgg+KSNMmeqGnhJJifZmxh3jh3m1lxZ6fpOk=; b=Dn10uzU8MbHOCG9+efqNiLQwpI
	KxN6uS/lHev3RV0mXNRHRWpBzdwR851sKMQ+M8w1R+/Rkac/c9kseeDYEQh0mQD0QXQhuX2E18kyO
	C3/OhTYf+36LyCtIjevNIK4qahd4AT//uTyezbgGynPz8bqsNh1oHuJRQSnmOQML/kd0V7VE3RuEA
	pjzZf4Ho2ebtGP2Xt6h7EK0asm+sUJ8t9M9X7hA5DMrEdMt+bUePmtwKl8sFEz3dqmj604tm+EoCJ
	avWXVknQOILA0isw8XZO8SwyfqZHw4UJbHCO5EWz8cDWDpMoWBD4IqSV0+apMcjcChYr4rmB4xOQR
	AZhFtwpA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vlmM1-001fbJ-Tc; Fri, 30 Jan 2026 11:07:58 +0000
Date: Fri, 30 Jan 2026 03:07:52 -0800
From: Breno Leitao <leitao@debian.org>
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, kexec@lists.infradead.org, dyoung@redhat.com, 
	tony.luck@intel.com, xueshuai@linux.alibaba.com, vgoyal@redhat.com, 
	zhiquan1.li@intel.com, olja@meta.com
Subject: Re: [PATCH] vmcore_info: expose hardware error recovery statistics
 via sysfs
Message-ID: <aXyOsFomVyQNlMof@gmail.com>
References: <20260129-vmcoreinfo_sysfs-v1-1-164c1fe1fe07@debian.org>
 <aXwQngYZx9Nk7hbv@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXwQngYZx9Nk7hbv@fedora>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260130_030815_403230_8B995C53 
X-CRM114-Status: GOOD (  12.06  )
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

On Fri, Jan 30, 2026 at 09:59:58AM +0800, Baoquan He wrote:
> On 01/29/26 at 05:34am, Breno Leitao wrote:
> > Add a sysfs file at /sys/kernel/vmcore_stats and expose hardware error
> > recovery statistics that are already tracked by the kernel. This allows
> > userspace monitoring tools to track recovered hardware errors without
> > requiring kernel crashes.
>
> I don't understand. If w/o requring kernel crashes, why do you call it
> vmcore_stats? It's a normal showing of hardware error recovery
> statistics tracked by kernel, can we name it /sys/kernel/hwerr_stats?

Agreed, /sys/kernel/hwerr_stats is a much better name. Thank you for the
suggestion!

> It's obviously having nothiing to do with vmcore, isn't it?

You're correct. The only connection is that this functionality currently
resides in kernel/vmcore_info.c. I initially thought it would make sense
to create a generic sysfs entry for vmcore, but I can see now that this
caused more confusion than clarification.

I'll update the patch accordingly.

Thanks,
--breno


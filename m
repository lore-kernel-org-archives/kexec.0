Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A842EF41986
	for <kexec@archiver.kernel.org>; Wed, 15 Apr 2026 11:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0deT5nTzAZM9jwtgeU6/XSQTQUWcP+shdfcj+l+woP8=; b=rDnRFcQSf1F5tUXRrbpvUaJ6uE
	ffccjNS4T9eI5QIsyvUDhR80/tCybinAvkeR/HbOY/7yYBXuE56aaVQeluGKK5rLdKrp1KtezUZYP
	+60w6dimG21tFpscTQrM3+pR82yDPbsc6vod+oY4BwFVm/USjO5DeCz/4s6qnvQ+iuXcsluKUFmQY
	5rSRMvD3yTgQNKHsrjjFvg5kH3yd36oGtHki9lnmE7G0uXXOAwSJiyc0Ri3qwolCeZDwtTXtTtxQu
	RRuXjs+hne5L6Wc0geEyzlNRk71b7Mit7I6evS6MHnmfwkZDhLlShlQCXpwY6d0KNX69LODQPK4Ux
	JEoZrWhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCyR0-000000012ld-2OK8;
	Wed, 15 Apr 2026 11:29:30 +0000
Received: from out-183.mta0.migadu.com ([91.218.175.183])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCyQy-000000012kf-08sa
	for kexec@lists.infradead.org;
	Wed, 15 Apr 2026 11:29:29 +0000
Date: Wed, 15 Apr 2026 19:29:15 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776252562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0deT5nTzAZM9jwtgeU6/XSQTQUWcP+shdfcj+l+woP8=;
	b=NrkZgIDmFnexpGPLRTk6BGtBWHW+Nb5UsUyG0DU10dMiXW5WGKh2aHVUOBLAYK5wwK/FW3
	IrB3+fqJBc8gShpkGXjIZDErEC5gTkzlLA2fl3HZDYDFbSjCo1VMtpYF06kjOEBzVbU4Q6
	Y/8Psk1bmkdXqLuNNvCqTft106v+OO4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Baoquan He <baoquan.he@linux.dev>
To: Youling Tang <youling.tang@linux.dev>
Cc: Baoquan He <bhe@redhat.com>, Sourabh Jain <sourabhjain@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH] crash: Support high memory reservation for range syntax
Message-ID: <ad92ix7d7I8jsykV@MiWiFi-R3L-srv>
References: <20260404074103.506793-1-youling.tang@linux.dev>
 <d584d383-1862-417d-9251-153d9bcf5626@linux.ibm.com>
 <adZYpnwOxgvFMLaT@MiWiFi-R3L-srv>
 <ea389ca2-8980-4022-a7d0-d96c913f671c@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea389ca2-8980-4022-a7d0-d96c913f671c@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_042928_227557_F71CAA7D 
X-CRM114-Status: GOOD (  26.51  )
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

On 04/09/26 at 09:55am, Youling Tang wrote:
> Hi, Baoquan
> 
> On 4/8/26 21:32, Baoquan He wrote:
> > On 04/08/26 at 10:01am, Sourabh Jain wrote:
> > > Hello Youling,
> > > 
> > > On 04/04/26 13:11, Youling Tang wrote:
> > > > From: Youling Tang <tangyouling@kylinos.cn>
> > > > 
> > > > The crashkernel range syntax (range1:size1[,range2:size2,...]) allows
> > > > automatic size selection based on system RAM, but it always reserves
> > > > from low memory. When a large crashkernel is selected, this can
> > > > consume most of the low memory, causing subsequent hardware
> > > > hotplug or drivers requiring low memory to fail due to allocation
> > > > failures.
> > > 
> > > Support for high crashkernel reservation has been added to
> > > address the above problem.
> > > 
> > > However, high crashkernel reservation is not supported with
> > > range-based crashkernel kernel command-line arguments.
> > > For example: crashkernel=0M-1G:100M,1G-4G:160M,4G-8G:192M
> > > 
> > > Many users, including some distributions, use range-based
> > > crashkernel configuration. So, adding support for high crashkernel
> > > reservation with range-based configuration would be useful.
> > Sorry for late response. And I have to say sorry because I have some
> > negative tendency on this change.
> > 
> > We use crashkernel=xM|G and crashkernel=range1:size1[,range2:size2,...]
> > as default setting, so that people only need to set suggested amount
> > of memory. While crashkernel=,high|low is for advanced user to customize
> > their crashkernel value. In that case, user knows what's high memory and
> > low memory, and how much is needed separately to achieve their goal, e.g
> > saving low memory, taking away more high memory.
> > 
> > To be honest, above grammers sounds simple, right? I believe both of you
> > know very well how complicated the current crashkernel code is. I would
> > suggest not letting them becomre more and more complicated by extending
> > the grammer further and further. Unless you meet unavoidable issue with
> > the existing grammer.
> > 
> > Here comes my question, do you meet unavoidable issue with the existing
> > grammer when you use crashkernel=range1:size1[,range2:size2,...] and
> > think it's not satisfactory, and at the same time crashkernel=,high|low
> > can't meet your demand either?
> 
> Yes, regular users generally don't know about high memory and low memory,
> and probably don't know how much crashkernel memory should be reserved
> either. They mostly just use the default crashkernel parameters configured
> by the distribution.
> 
> For advanced users, the current grammar is sufficient, because
> 'crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset],>boundary'
> can definitely be replaced with 'crashkernel=size,high'.
> 
> The main purpose of this patch is to provide distributions with a more
> reasonable default parameter configuration (satisfying most requirements),
> without having to set different distribution default parameters for
> different
> scenarios (physical machines, virtual machines) and different machine
> models.

OK, do you have a concrete case? e.g in your distros, what will you set
with this patchset applied? Let's see if it can cover all cases with one
simple and satisfying parameter.


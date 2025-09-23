Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FE3CAC5A7
	for <kexec@archiver.kernel.org>; Tue, 23 Sep 2025 13:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CF1w1tB7AX8W93nv4m6JdkaoLtcqErW1ZVVfNtO6E+o=; b=pGnQDpQqHq6ofXgC9MEs1AL7fQ
	LrYYdO+75CbScLskwspKx4YDAXSfZOzT/foA/cZg+PBUq5jTkhq9UMg7Fl6dQ0gkao0hrIEOJ46jU
	a/ckNCzIDmFYI4W0VSIn92tbkfgWnoCqotA+YUW7Q/WbCv700woRCJhgJsMHdxggXX2U16mnrMOP7
	8/4fNE3fceYI9iRyZnbwTf/EHFT1FjI9zoZdu8lzWB45ZcKSpd9pHl7J+/SthX9bpgSO1rug9Xlue
	4zMH88LmVKJiJSfeo/m7N41h9pu/CncUO8KCQ5lEyqUellw16svkKnY3mPPEgxaqpmgUBuOJrSEAM
	3f5D2teg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v13Vd-0000000DcP1-42yZ;
	Tue, 23 Sep 2025 13:56:45 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v13Vc-0000000DcOQ-0IjJ
	for kexec@lists.infradead.org;
	Tue, 23 Sep 2025 13:56:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7FCE36024D;
	Tue, 23 Sep 2025 13:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A6EC4CEF5;
	Tue, 23 Sep 2025 13:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758635803;
	bh=3zNG1VCnUeJ4Ybzc3kBTwVMsoJggsdS9/3RSWxB0cVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bv7HWdsFe/Qt/ot9I2lTupAKrmE/X+vlhq/lbKPebqEwPqlq1cx2bfcVOqUR989ZL
	 vZf6CdweZlNI7AJOiCYYyaLi+5U/PToTo5u6MtuOY0kHQa3/j9nyqg9i1j8Qo1GPAR
	 UNjOXmd2wuYLnfXmn2iKLdJXJVKf/9/9GeVlDerNfCV/LVPnaKR7Q5Te/PSHt6Ceg5
	 FOqk3oVE8Y+vq88zGqVfboAx6ewXI10b8OSPleIteDTuxydfpLkDDaWsGTT0fLBOoP
	 wnVMqxZYDg0/UbbvgBtkWZdnZtWyG6IRRcSwEhvBMtLd/c3/hkpLljD6EimLNlIZZP
	 0oubweu+S3UUQ==
Date: Tue, 23 Sep 2025 14:56:39 +0100
From: Simon Horman <horms@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: Askar Safin <safinaskar@zohomail.com>,
	Jeremy Linton <jeremy.linton@arm.com>,
	kexec <kexec@lists.infradead.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 0/6] Fix printf string specifiers, otherwise kexec
 doesn't work on my laptop
Message-ID: <20250923135639.GA1084957@horms.kernel.org>
References: <20250819213014.908757-1-safinaskar@zohomail.com>
 <19972b2566e.1115458b7339833.495097856732093802@zohomail.com>
 <aNICt3e3Fg0iwxvv@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNICt3e3Fg0iwxvv@MiWiFi-R3L-srv>
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

On Tue, Sep 23, 2025 at 10:15:19AM +0800, Baoquan He wrote:
> On 09/22/25 at 10:31pm, Askar Safin wrote:
> > Simon Horman, so what? This patchset is still not merged.
> 
> Not sure if Simon minds the patch log, especially in patch 1. I saw the
> 'TL;DR' first time in a patch log.
> 
> For a problem solving patch, we better provide information like
> 
> -what is the problem;
> -why it's caused;
> -how you fix it;
> 
> Don't tell too long story out of the space. Refering to other already
> merged commit's log is also a good way to learn that.
> 
> The fix is absolutely a great one.

Sorry for the extended delay.
I am looking over this now.


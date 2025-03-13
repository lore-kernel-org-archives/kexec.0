Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774EAC282DE
	for <kexec@archiver.kernel.org>; Thu, 13 Mar 2025 12:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pw7snbHlUXnOvVBBpmxnOrHQzZwQkBpDkVZGxBYLKUU=; b=hicBRqvhP4mhdHtpI92jqG1qB2
	hCAKYpMeaH8zsH+VDfj1I4CVZMUNbJvOYnrv1You/Xl1kYMWz+n51RMg4cJC4PxMPjENUVlq9Ukmb
	V2NMhiVYNfN5nAGTaPKCrDA9n2U/SElk5m+LpTe9GbscaerYv/3l2deT4WQVXWf33syM74J6QejZt
	Rb1c7Qi6KWy7dqt832KRj+NayfxRMAyxol5CISZkRSBZ6VY1ZZk0LLVGMdVqgjsWsdXozHxBH7rQs
	9ccBlz18b/kl7X5HuxO9Kq5IbffUPR2yY4QFza4Gi8IeM/ErGF3V0yCOChq8gqE9ONTYiHTx7WSGa
	Wk3SXyHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tshZ4-0000000BDst-0PCZ;
	Thu, 13 Mar 2025 12:21:30 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tshKT-0000000BBN8-2ze3
	for kexec@bombadil.infradead.org;
	Thu, 13 Mar 2025 12:06:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Pw7snbHlUXnOvVBBpmxnOrHQzZwQkBpDkVZGxBYLKUU=; b=q4q8F0yDtBWxWhc7hjoCdMfOl6
	ZB/nBe0yN7Ia8FRTEsrJyaqw11lpkU1u5+TyNMc3RnWyn4xnc4zWTZ7y6Je6bQxCikgSrAkEWirKg
	BWyiNjEimSGdPvyhz0HFLyg3VLuRX/xi89eC0XONhf68BawzKMADc4GUBbx1pJioxQgsi39zU8NuU
	w1rB8bRj6o5hgX+GyKAwtljV5myoLQFz+fSyW+C/Lnhwvly+hLnAZ8diIzO/ekOzlwofXC1gNfSTh
	JTSUS9Ooz8IaczrqJbCB+hE8pxy9xzebFmVf6/cSbCJTLUjqQ6rXN2PNPNwmUNjY55ILiM+tEZXLq
	0sB/JqiA==;
Received: from mgamail.intel.com ([192.198.163.9])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tshKQ-00000002awD-0xfG
	for kexec@lists.infradead.org;
	Thu, 13 Mar 2025 12:06:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741867582; x=1773403582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8EWHkY1EdcknZHAuO+B/5Jp6uGVfXGJsqIRow7BI+fA=;
  b=ZL8oLt2J5OCOokNr27hDSbN4+lTf4+YsIgZXIoc9s8Bvg14thJWbliA3
   Te9ZKbj6Y/ILHyxdkQyFyAqkpLsmra2T4hp9porviRYIxjWkfNiHf1abk
   7dvn8Oe0hgL1Ic0E8gMqNa8iw07FO1pSDPH0g+ECfSh1ud/trOJcB8SW8
   6lHoLM4QjfL8ypAtIlPKA3rwQc1GNf4z7aZYDGu57tqb15+C+QKiX8si7
   ojQP2yf3WyOW2cs6D5ucGPT885OgIPavs8ovpimm56HM4JCg0OvdP7DT4
   cm6Xm6dHeXqre1+cWLFBx1W5w0rnQ1MORlYdBCR8WKZJ8UmcYFg7/MaqH
   Q==;
X-CSE-ConnectionGUID: 6SBmiMhLQWi1yj7g9YIIvQ==
X-CSE-MsgGUID: +oAsfCt0TnSQ/kMdeoTlxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="53617333"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="53617333"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:06:15 -0700
X-CSE-ConnectionGUID: Lqq54mWoRVCVh/5AhMopZQ==
X-CSE-MsgGUID: oUn3eD1CTkmpsTnx2xrYjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="121634489"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 13 Mar 2025 05:06:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id F23241FC; Thu, 13 Mar 2025 14:06:11 +0200 (EET)
Date: Thu, 13 Mar 2025 14:06:11 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>, 
	"Kirill A. Shutemov" <kirill@shutemov.name>, ebiederm@xmission.com, kexec@lists.infradead.org, 
	Yan Zhao <yan.y.zhao@intel.com>, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	x86@kernel.org, rick.p.edgecombe@intel.com
Subject: Re: [PATCH v2 0/1] Accept unaccepted kexec segments' destination
 addresses
Message-ID: <qj43ayg7qtdqlsi7y7c2mr3clq2tmcbvfg6e5j25liu54u7lzg@h3djemts5qro>
References: <20241213094930.748-1-yan.y.zhao@intel.com>
 <xgycziy2o56hnom3oau7sbqed3meoni3razc6njj7ujatldnmm@s7odbl4splbn>
 <Z4T1G4dwzo7qdwSP@MiWiFi-R3L-srv>
 <20250304154353.a79c330bffb4d21dce2dad9c@linux-foundation.org>
 <20250304155327.4499dcbbfa2445f76927c6c3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304155327.4499dcbbfa2445f76927c6c3@linux-foundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_120622_726464_E58094C2 
X-CRM114-Status: UNSURE (   8.09  )
X-CRM114-Notice: Please train this message.
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

On Tue, Mar 04, 2025 at 03:53:27PM -0800, Andrew Morton wrote:
> Yan, please go back through the discussion and incorporate reviewer
> feedback into the changelogs: describe the possible issues which people
> have raised and your responses to those.  Then resend and then let us
> restart the review process.  With less reviewer latency please!

Just in case it got missed, the updated patch is here:

https://lore.kernel.org/all/20250307084411.2150367-1-kirill.shutemov@linux.intel.com

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


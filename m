Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4FBC021B8
	for <kexec@archiver.kernel.org>; Tue,  4 Mar 2025 23:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:To:From:
	Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FTvOZnNOQllko25GuLzQLA1ai7hjPHLVp59wwO/6yLc=; b=ArZkOxVjHBrB4pwZqLHNRKnO07
	n6Q6ODQywzXl58f3bg0rUdh4p1tOrRs7v8MGNbkBzN8Qc77mAsA+Kh/ssywiFP/kNTGHFp9WEf06a
	f6lAA/cPY+ayAkwAh33xfquNS5UEZAxPHlhkjAnMxgFUE7GMObULa7i9XS8gCcg/2AOpf/F4gLlZA
	nmL2cbruIa+ZM27KSTQzaD3OBxUyXVQb4AxDKxKkKMoCgHX6aRjQgA7UTBPUc+QnRPPjqRILa9SC7
	tlpriC9ckvN8k1JvtAt+E3WkoN1lnL4vVqAVtqgw1G09Fw5G9jsODjBOnqTHqDnGLggLJ3TIJK2hm
	UbkSQTjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpc66-00000006ZQW-1gqC;
	Tue, 04 Mar 2025 23:54:50 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpc63-00000006ZPu-42FJ
	for kexec@lists.infradead.org;
	Tue, 04 Mar 2025 23:54:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 964435C41CC;
	Tue,  4 Mar 2025 23:52:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8225C4CEE5;
	Tue,  4 Mar 2025 23:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741132487;
	bh=JdEdu8rWm4LE7G5ugiUzr9rqHea6qEYMUFmgEv8icac=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=xy+/xgCFuxJ96sdso8AR6Gyg8pT3QxCChvG+rlLcjSLS69cjxXRELarOkPJy3y5Hf
	 4iMLA4C3CT3yfMhV+B6fFr6WzhdSHObnX7haQsIaAPYGtM0iK4+KS6kYNrikrQ73VT
	 wqYc4BoAFj+ovbK0Oa2jkBKWZxi/yekMDoaR+QRY=
Date: Tue, 4 Mar 2025 15:54:46 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>, "Kirill A. Shutemov"
 <kirill@shutemov.name>, ebiederm@xmission.com, kexec@lists.infradead.org,
 Yan Zhao <yan.y.zhao@intel.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, x86@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v2 0/1] Accept unaccepted kexec segments' destination
 addresses
Message-Id: <20250304155446.c87d23fb763e606e05344e4c@linux-foundation.org>
In-Reply-To: <20250304155327.4499dcbbfa2445f76927c6c3@linux-foundation.org>
References: <20241213094930.748-1-yan.y.zhao@intel.com>
	<xgycziy2o56hnom3oau7sbqed3meoni3razc6njj7ujatldnmm@s7odbl4splbn>
	<Z4T1G4dwzo7qdwSP@MiWiFi-R3L-srv>
	<20250304154353.a79c330bffb4d21dce2dad9c@linux-foundation.org>
	<20250304155327.4499dcbbfa2445f76927c6c3@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250304_155448_052725_88B2FDEC 
X-CRM114-Status: UNSURE (   8.44  )
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

On Tue, 4 Mar 2025 15:53:27 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> Yan, please go back through the discussion and incorporate reviewer
> feedback into the changelogs: describe the possible issues which people
> have raised and your responses to those.  Then resend and then let us
> restart the review process.  With less reviewer latency please!

Meanwhile, I'll add this old patch to mm.git to get some testing coverage.


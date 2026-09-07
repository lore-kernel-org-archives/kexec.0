Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF665C79F9E
	for <kexec@archiver.kernel.org>; Mon,  7 Sep 2026 10:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qdrm4DNBYm5dX7L6mU3n6kjCzAA9iq8Muamy4PiEFn8=; b=PG79/kmHOJkhUelIJPOn4JvTgf
	wkFkCulJD8qPqEJjHovDyCry3WGAkzJsxthDUeftl0Y9jqJnWQb7byBiLvwW64p4n3WkaxGYLi2mS
	CzkmABkUMn14WLOyj9T4NQIJ15/qKd9UZGtBCcBqPpeQB/lzNWl5LKmEZGz7RE2RtxdVAHorM16wt
	TOVV5wNd5PaezZgldudPwLbnb3IRRAsF4K+4T3weWLm0WXL15lonNTQeb7ZYqLfIMDdGPZDP/YqSp
	YQ1BGDqhu286CfFAr9Wpn8Kb1iaREBhqhU+iN/lOIqSshbH0bBulVrODawqiu1Rmb/JEpXPi9VOXp
	zUy9QnqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3WWe-00000006Tea-0pJo;
	Mon, 07 Sep 2026 10:24:32 +0000
Received: from out-244.mta1.migadu.com ([2001:41d0:203:375::f4] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3WWa-00000006Tbq-1isI
	for kexec@lists.infradead.org;
	Mon, 07 Sep 2026 10:24:31 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=Qdrm4DNBYm5dX7L6mU3n6kjCzAA9iq8Muamy4PiEFn8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788776665; v=1; x=1789381465;
 b=jXPzfFxXodFwCehoxicliV7n6rXK8tL10JO3L02fST/m0SbITPVMsFqJt/5Ew+Diy0YF9swX
 LyvcK9QLMGzlnjvP4pyGEZ2TB9tZWbF7uJjRGRHogD6/4UgJ7dYgzPY3XXtlCW+3qbXDG17P3FK
 +CE472NHNPt7+m/y2R31wvR8=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 06a3db8f22e82ea6;
	Mon, 07 Sep 2026 10:24:25 +0000
X-Mizu-Trace-ID: 06a3db8f22e82ea6
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	changyuanl@google.com,
	akpm@linux-foundation.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Kexin Liu <liukexin@kylinos.cn>,
	guodongtai@kylinos.cn,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] liveupdate: kho: calculate per-node scratch sizes before allocation
Date: Mon,  7 Sep 2026 18:24:14 +0800
Message-ID: <20260907102414.18958-1-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ap3IFd2FVvfKkHkV@kernel.org>
References: <20260904025101.9959-1-dongtai.guo@linux.dev> <ap3IFd2FVvfKkHkV@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_032428_657351_EBDAB0F6 
X-CRM114-Status: UNSURE (   5.98  )
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

Hi Mike,

> This reads as LLM-generated text. Please add LLM attribution as per
>
> https://docs.kernel.org/process/coding-assistants.html#attribution

I'll add the Assisted-by tag.

> Can't we just calculated all the sizes first and than do the allocations?

Yes, I'll rework this to calculate all scratch sizes together before
allocating the scratch areas.

Adding Sourabh to Cc, since this relates to the scratch-sizing discussion
in the PowerPC KHO thread.

Sourabh, this patch prevents newly allocated scratch areas from being
counted in the per-node baseline. It does not address the overlap between
global and per-node accounting. Could you review this approach as well?

Thanks,
George


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DF5D46BF4
	for <kexec@archiver.kernel.org>; Wed, 28 Jan 2026 19:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ZCcoDQNhfDeGg3fDFRS9sST9IJ06YlTwD5B19aHjp8=; b=MHyakmfExiGwNxW5h8XkJBzdiI
	aizYpyBmIWovFwZVquyFYRaxK6FkrpRsnWlTYkPq4ALN9FZQM1aLSNy855QkTbLbPRVVdEeCwUxT9
	VybIkktu8uyDvOSxNka6mjyDPr1NVI0FarmcW/of5WFhsmfcfZp67l+Ee7JghcOnMAfOqFbs6vaUO
	ia1OftOFa9gH/ZyxI+ABrKdOgHw6LaBXBq1wbodbuwsXw4gcKUc9alzOC0ioFLT4CsDOX1AJ8QgVJ
	bxOU8/S4XgzBzch37KEtd8vToZYUvBcLwbmyuXmX17MFTI2JSPXXPfbAfi13zLSr4iitE6vfDEwgF
	hQi3XEVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlB4f-0000000GfsY-1nOb;
	Wed, 28 Jan 2026 19:19:33 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlB4e-0000000GfsR-0VOM
	for kexec@lists.infradead.org;
	Wed, 28 Jan 2026 19:19:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A755F60007;
	Wed, 28 Jan 2026 19:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E379FC4CEF1;
	Wed, 28 Jan 2026 19:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769627970;
	bh=fnVrY/VJt1XOxXtUPFuhYIKdfkyVGkWAoedb2W8TjOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TZjPbYgw8N/uC8YyD5VB2MGQnv5UPJAeHl2j+dVsVFgPzn5gKHCBwhRGA1ouhPIZM
	 Y6QHFbt3W0tu2LBc0xTlis3eEPXl9JsJ3cPvVZWFSfpbkwrHflIpTfHdFOBFaw3aIW
	 4jwroAj9qmlrnaiGPQ5aN2GYteZUnvayFkLMkuY0=
Date: Wed, 28 Jan 2026 11:19:29 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>
Cc: Li Chen <me@linux.beauty>, Mimi Zohar <zohar@linux.ibm.com>, Tushar
 Sugandhi <tusharsu@linux.microsoft.com>, Eric Biggers
 <ebiggers@kernel.org>, Alexander Graf <graf@amazon.com>, Steven Chen
 <chenste@linux.microsoft.com>, Coiby Xu <coxu@redhat.com>, Sourabh Jain
 <sourabhjain@linux.ibm.com>, Philipp Rudo <prudo@redhat.com>, Ricardo
 Ribalda <ribalda@chromium.org>, "Steven Rostedt (Google)"
 <rostedt@goodmis.org>, Ross Zwisler <zwisler@google.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kexec: derive purgatory entry from symbol
Message-Id: <20260128111929.73a13cc2d51ef113a586993e@linux-foundation.org>
In-Reply-To: <aXnWMmyUMdbrqAiu@MiWiFi-R3L-srv>
References: <20260128043511.316860-1-me@linux.beauty>
	<aXnWMmyUMdbrqAiu@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 28 Jan 2026 17:26:10 +0800 Baoquan He <bhe@redhat.com> wrote:

> On 01/28/26 at 12:35pm, Li Chen wrote:
> > kexec_load_purgatory() derives image->start by locating e_entry inside an
> > SHF_EXECINSTR section. If the purgatory object contains multiple executable
> > sections with overlapping sh_addr, the entrypoint check can match more than
> > once and trigger a WARN.
> > 
> > Derive the entry section from the purgatory_start symbol when present and
> > compute image->start from its final placement. Keep the existing e_entry
> > fallback for purgatories that do not expose the symbol.
> > 
> > WARNING: kernel/kexec_file.c:1009 at kexec_load_purgatory+0x395/0x3c0, CPU#10: kexec/1784
> > Call Trace:
> >  <TASK>
> >  bzImage64_load+0x133/0xa00
> >  __do_sys_kexec_file_load+0x2b3/0x5c0
> >  do_syscall_64+0x81/0x610
> >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > 
> > Fixes: 8652d44f466a ("kexec: support purgatories with .text.hot sections")
> > Signed-off-by: Li Chen <me@linux.beauty>
> 
> LGTM,
> 
> Acked-by: Baoquan He <bhe@redhat.com>

Thanks.

> By the way, a warning need be 'Fixes' tag and back ported to stable
> kernel?

Yup.  I added the cc:stable.


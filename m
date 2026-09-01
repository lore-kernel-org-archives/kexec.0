Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71279C624D6
	for <kexec@archiver.kernel.org>; Tue,  1 Sep 2026 15:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PMQPDVPJ0tCxO93gmrhVyeG5Oa0anovLBVYtrsBizkA=; b=qBo9ukZNqUN8yaN2TF/Ks/jR55
	16cjW6kKvEIxueJ4wJSBJFNwPWD0fsXk2x3LZvID3XliPHdmH7vU+6WYzDqtuLtoqKXKQqj+3Z9Za
	eRvFOx4GMhRDHWKSI4Ny8niUR51f3M7Zjm0deMmSyluuAvUzdbpWUo6mrjsM322n2L8Pzn3B24w5f
	StsM+ybiwEXFH6rlupDlfKgsIBHC/03KGy2tLonKXA9DtUQWIjk5QsyoDMdGkixYU2xRFwRYGu0Nk
	bdZhstyHGekpV+AjNr/HsouKKGvX16BB5vVdeq1n91LftFbcJboZ1aFDVlWazhWMt6jtH1RVsQ4N9
	5DtwIt2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1QpH-0000000Cb1M-1JQB;
	Tue, 01 Sep 2026 15:55:07 +0000
Received: from smtprelay0015.hostedemail.com ([216.40.44.15] helo=relay.hostedemail.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1QpA-0000000Cb0d-1fF1
	for kexec@lists.infradead.org;
	Tue, 01 Sep 2026 15:55:01 +0000
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id C29301A0469;
	Tue,  1 Sep 2026 15:54:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 8E80930;
	Tue,  1 Sep 2026 15:54:43 +0000 (UTC)
Date: Tue, 1 Sep 2026 11:55:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@kernel.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Muchun
 Song <muchun.song@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Nico
 Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain
 <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Lance Yang
 <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, Gregory Price
 <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, Alistair
 Popple <apopple@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng
 <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Kairui Song
 <kasong@tencent.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Baoquan He <baoquan.he@linux.dev>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, Jan Kara <jack@suse.cz>, Masami Hiramatsu
 <mhiramat@kernel.org>, Dave Young <ruirui.yang@linux.dev>, Shuah Khan
 <skhan@linuxfoundation.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, kexec@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/14] mm/page-flags: remove PG_private
Message-ID: <20260901115542.35cf337f@gandalf.local.home>
In-Reply-To: <20260831-remove-pg_private-v2-14-3668159cd9e8@nvidia.com>
References: <20260831-remove-pg_private-v2-0-3668159cd9e8@nvidia.com>
	<20260831-remove-pg_private-v2-14-3668159cd9e8@nvidia.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: b6ytfgjtokst1jc1aabs95dwf5ejwe1f
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 8E80930
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/zWbvIDz+3Hi5z7GDK/fNqzAPKpw/khW4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=PMQPDVPJ0tCxO93gmrhVyeG5Oa0anovLBVYtrsBizkA=; b=tGc4Z9sCnIntcGcWtJ1kOvYe5256jqS1DsWodW2sqCKQLdl8Y8nHkKMI+/bZHJCQztdMhcSkJj8YVjXCQshVK+Dgc2EYzxp1kQ+nPt/MKxXAHxYAr/fN2B+/kb850ZrxY0100q3DUUBwY4s7EFwq4xvvaRIiE/XmnNIq0jxhRxw=
X-HE-Tag: 1788278083-807407
X-HE-Meta: U2FsdGVkX1+zDlnR6QN6MUglWJjwZx5iCWUM+krVLXlc2zuUtd2IG2DLx1JPwqlTPq6HywJagZIVfhFWq44D2aDRr8CqPASzgDg55B72H7mSnF5ikilDHz6BwtU39295NFtcyv6lgavetSPz7y1L0g1K1zuV3ydBJ2a0X+t/9iTl4lf+jI9pSLCyfw2TQI05jjgMqbeUDhSMlamHBWoJCJ9h/PNz2A75JPoGpqGqH4tC/s8xhJUmsTXFGe6/YTY1Ki/+liODnEmp1JpspQt4nrByo2d4u2HwgRpO1hcQFU+FSiTYj5enzhApbGNiHUuTn+pvjGsLrpU3m7+D/3dcDhPAQVDdzRzZ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260901_085500_634135_C2FCBCFC 
X-CRM114-Status: GOOD (  11.71  )
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

On Mon, 31 Aug 2026 15:25:37 -0400
Zi Yan <ziy@nvidia.com> wrote:

> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
> index 935893e5ea53b..caf090cd6f85e 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -144,7 +144,7 @@ TRACE_DEFINE_ENUM(___GFP_LAST_BIT);
>  	DEF_PAGEFLAG_NAME(owner_2),					\
>  	DEF_PAGEFLAG_NAME(arch_1),					\
>  	DEF_PAGEFLAG_NAME(reserved),					\
> -	DEF_PAGEFLAG_NAME(private),					\
> +	{ 1UL << __PG_folio, "folio" },					\
>  	DEF_PAGEFLAG_NAME(private_2),					\
>  	DEF_PAGEFLAG_NAME(writeback),					\
>  	DEF_PAGEFLAG_NAME(head),					\

Hmm, just for consistency sake, can we create a:

 #define __DEF_PAGEFLAG_NAME(_name) { 1UL <<  __PG_##_name, __stringify(_name) }

Which is similar to:

 #define DEF_PAGEFLAG_NAME(_name) { 1UL <<  PG_##_name, __stringify(_name) }

But adds the "__" to the name. Then the above would look like:

	DEF_PAGEFLAG_NAME(reserved),					\
	__DEF_PAGEFLAG_NAME(folio),					\
	DEF_PAGEFLAG_NAME(private_2),					\
	DEF_PAGEFLAG_NAME(writeback),					\

Where the __DEF_PAGEFLAG_NAME() with the "__" still stands out, but the
code looks better than open coding it in the middle and making one wonder
why it was open coded. (It took me a bit to noticed the "__" difference.)

-- Steve


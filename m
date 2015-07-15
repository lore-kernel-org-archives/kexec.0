Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwkm03.jp.fujitsu.com ([202.219.69.170])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZFCU2-0001ve-FR
 for kexec@lists.infradead.org; Wed, 15 Jul 2015 02:31:43 +0000
Received: from m3051.s.css.fujitsu.com (m3051.s.css.fujitsu.com
 [10.134.21.209])
 by kw-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id 330B7AC03DA
 for <kexec@lists.infradead.org>; Wed, 15 Jul 2015 11:31:15 +0900 (JST)
Date: Wed, 15 Jul 2015 11:31:08 +0900 (JST)
Message-Id: <20150715.113108.82220331.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v1 0/4] makedumpfile: optimize the way of generating
 incomplete kdump core
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <1436495333-22892-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1436495333-22892-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: zhouwj-fnst@cn.fujitsu.com
Cc: kexec@lists.infradead.org

From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH v1 0/4] makedumpfile: optimize the way of generating incomplete kdump core
Date: Fri, 10 Jul 2015 10:28:49 +0800

I don't think this subject is good. This seems a bugfix patch set for
ENOSPC issue, not an optimization.

> 
> In current implementation, when generating kdump core,
> it behaves as the following logic.
> 
> 1. Write page header into the buffer cd_header.
> 2. If buffer is full, flush the buffer.
> 3. Write page data into the buffer cd_page.
> 4. If buffer is full, flush the buffer.
> 
> When enospc occurs in flushing cd_page, it always still
> has much data in cd_header. The size of page data is 170
> times the size of page header. It leads to that quite a
> lot of page data been written into file can't be used.
> 

Do you mean like this?

  When ENOSPC occurs in flushing cd_page, there's still data left in
  cd_header. We cannot read page data corresponding to the page
  headers in the cd_header even if the page data has been flushed into
  disk. The size of page data is 170 times larger than the size of
  page header per a single page frame. The difference becomes bigger
  if we use compression.

> The page header may also meet that. The page data can be
> compressed, so the size of page data can also be much smaller
> than the size of page header.
> 

Compression doesn't always reduce size of data. So writing this
doesn't make sense in general because.

> This patch set changes the logic of generating kdump core.
> The new logic is:

The below doesn't explain why this new logic makes sense.

> 
> 1. Before writing page header and data into buffer, if the buffer
>    will be full, write the data of the buffer into file.

                             This "the buffer" means cd_page, right?

> 2. Then, write the page header and data info buffer.

It's better to write cd_header and cd_page for clarity. "the buffer"
seems ambiguous.

> 
> When enospc occurs in writing the cd_header into file, fill the
> cd_header with zero and re-write the cd_header.
> When enospc occurs in writing the cd_page into file, fill part
> of the cd_header with zero according to how many pages in cd_page
> have been written. 
> 

> Zhou Wenjian (4):
>   Add write_cd_buf
>   Add get_pfn_offset
>   Add write_kdump_page
>   Use write_kdump_page instead of write_cache in
>     write_kdump_pages_cyclic
> 
>  makedumpfile.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 96 insertions(+), 11 deletions(-)
> 
> -- 
> 1.8.3.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
--
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

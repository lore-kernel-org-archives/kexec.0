Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KiEou-0008ET-3I
	for kexec@lists.infradead.org; Tue, 23 Sep 2008 20:49:17 +0000
Message-ID: <48D955F5.5050508@redhat.com>
Date: Tue, 23 Sep 2008 16:47:49 -0400
From: Dave Anderson <anderson@redhat.com>
MIME-Version: 1.0
Subject: Re: the exiting makedumpfile is almost there... :)
References: <48C85836.8080606@sgi.com> <20080911143226.GT29908@sgi.com>
	<48C9D22A.5010404@mxs.nes.nec.co.jp> <48CA70CD.2090500@sgi.com>
	<48CAC7DB.4090904@sgi.com> <48CAD340.7000701@redhat.com>
	<48CAEB6A.8080405@sgi.com> <48D77E05.30504@mxs.nes.nec.co.jp>
	<48D94F89.5010607@sgi.com>
In-Reply-To: <48D94F89.5010607@sgi.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1482109185=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jay Lan <jlan@sgi.com>
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, kexec@lists.infradead.org, Hedi Berriche <hedi@sgi.com>

--===============1482109185==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Jay Lan wrote:
> Ken'ichi Ohmichi wrote:
> 
>>Hi Jay,
> 
> 
> Hi Ken'ichi,
> 
> 
>>My IA64 linux-2.6.27-rc7 kernel could boot by your patches and its kdump
>>succeeded, thanks. But I cannot reproduce this problem unfortunately.
>>Could you send me your kernel .config file to reproduce it ?
> 
> 
> 
> I just emailed you my .config.
> 
> 
>>And could you please research the reason why the page of virtual address
>>0xe0000060031417a8 is excluded ?  This patch is for researching it.
>>Please apply it against makedumpfile-1.2.9, and create a dump file
>>by makedumpfile with "-e 0xe0000060031417a8" option. The reason why
>>excluding the page is printed like the following:
> 
> 
> The excluded page moved. It is at at e0000060030f0000 type: "pmd page".
> The change that Dave said helped him did not help me though.

Did you initialize the reset_cache variable to 1 at the top of the function?
I forgot to put that in my post.

In any case, you still want to debug that function.  Since you know what
the target pfn being skipped is: 60030f0000 >> PAGE_SHIFT, you can
dump out the page->flags field in exclude_unnecessary_pages() when it
comes up in the loop.  Then when you run crash on the "cp" dumpfile,
do a "kmem -p 60030f0000", which will show the associated page struct
address and a few fields within it.  My guess is that the page->flags
field that you saw in makedumpfile's exclude_unnecessary_pages() will
not be the same as what you see running crash.

Dave


Dave


--===============1482109185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1482109185==--

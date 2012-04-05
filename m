Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SFnlt-0001ew-IE
 for kexec@lists.infradead.org; Thu, 05 Apr 2012 14:34:46 +0000
Date: Thu, 5 Apr 2012 10:34:39 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: makedumpfile memory usage grows with system memory size
Message-ID: <20120405143439.GA23999@redhat.com>
References: <20120329132533.GM18218@redhat.com>
 <20120330.095143.347147805.d.hatayama@jp.fujitsu.com>
 <20120402164651.6c2b1ae7.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120405.155211.347142878.d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120405.155211.347142878.d.hatayama@jp.fujitsu.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: dzickus@redhat.com, oomichi@mxs.nes.nec.co.jp, kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org

On Thu, Apr 05, 2012 at 03:52:11PM +0900, HATAYAMA Daisuke wrote:

[..]
>   * Bad performance is free pages only. Cache, cache private, user and
>     zero pages are processed per range of memory in good performance.

Hi Daisuke-san,

I am wondering why can't we walk through the memmap array and look into
struct page for figuring out if page is free or not. Looks like that
in the past we used to have PG_buddy flag and same information possibly
could be retrieved by looking at page->_count field. 

So I am just curious that why do we walk through free pages list to figure
out free pages instead of looking at "struct page".

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

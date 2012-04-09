Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SHJpg-00042N-D9
 for kexec@lists.infradead.org; Mon, 09 Apr 2012 19:00:57 +0000
Date: Mon, 9 Apr 2012 15:00:10 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: makedumpfile memory usage grows with system memory size
Message-ID: <20120409190010.GI1645@redhat.com>
References: <20120402164651.6c2b1ae7.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120405.155211.347142878.d.hatayama@jp.fujitsu.com>
 <20120405143439.GA23999@redhat.com>
 <20120406.101212.193682065.d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120406.101212.193682065.d.hatayama@jp.fujitsu.com>
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

On Fri, Apr 06, 2012 at 10:12:12AM +0900, HATAYAMA Daisuke wrote:

[..]
> So now we can walk on the memmap array also for free pages like other
> kinds of memory. The question I have now is why the current
> implementation was chosen. Is there any difference between two ways?

I don't know but I am guessing may be going through buddy allocator
data structures is faster when there is tons of memory in the system and
number of free pages is less.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

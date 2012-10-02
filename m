Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TIuYe-0006oc-1I
 for kexec@lists.infradead.org; Tue, 02 Oct 2012 04:58:14 +0000
Date: Tue, 2 Oct 2012 13:55:17 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: Query about cyclic buffer size
Message-Id: <20121002135517.b963ab90594d18d3396f24a8@mxc.nes.nec.co.jp>
In-Reply-To: <20120920131241.GA4681@redhat.com>
References: <20120913141018.GG4396@redhat.com>
 <20120920162535.63048af2d22e607a8f809133@mxc.nes.nec.co.jp>
 <20120920131241.GA4681@redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: vgoyal@redhat.com
Cc: kexec@lists.infradead.org, dyoung@redhat.com, chaowang@redhat.com

Hello Vivek,

On Thu, 20 Sep 2012 09:12:41 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:
 
> > Now, I think makedumpfile should automatically choose the lesser of the two below
> > as the size of cyclic buffer when the size isn't specified:
> > 
> >   a. the size enough for storing the 1st/2nd bitmap for the whole of vmcore
> >   b. the limit size (e.g. 70-80% of free memory)
> > 
> > However, I don't have a good idea how to determine the appropriate size
> > for the case of "b". 
> > If someone have a idea for the limit size, please let me know.
> 
> May be just look at "free" output or "cat /proc/meminfo" and grep for
> "MemFree" calculate the size of buffer.

Thank you for your answer, but what I minded was to allocate most of 
free memory is safe or not.
But now, I think it may be safe because processes which need some memory
will not be created while makedumpfile is running.

So, I will try to implement the above idea for v1.5.1.
When I make the patch, I will post them.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

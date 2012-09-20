Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TEgYo-0005DY-Pe
 for kexec@lists.infradead.org; Thu, 20 Sep 2012 13:12:56 +0000
Date: Thu, 20 Sep 2012 09:12:41 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Query about cyclic buffer size
Message-ID: <20120920131241.GA4681@redhat.com>
References: <20120913141018.GG4396@redhat.com>
 <20120920162535.63048af2d22e607a8f809133@mxc.nes.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120920162535.63048af2d22e607a8f809133@mxc.nes.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: kexec@lists.infradead.org, dyoung@redhat.com, chaowang@redhat.com

On Thu, Sep 20, 2012 at 04:25:35PM +0900, Atsushi Kumagai wrote:
> Hello Vivek,
> 
> On Thu, 13 Sep 2012 10:10:18 -0400
> Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > Hi Atsushi-san,
> > 
> > How is size of cyclic buffer decided with 1.5.0? In practice I don't think
> > asking user for the size is a good idea as user does not know how much
> > memory will be left after kernel boot.
> 
> As you said, I don't think asking user for the size is a smart way, either.
> So, I agree with your basic idea explained in below.
> 
> > Will it make sense for makedumpfile to automatically determine the buffer
> > size based on amount of free memory available in the system. Something
> > like use 70-80% of free memory as cyclic buffer.
> 
> Now, I think makedumpfile should automatically choose the lesser of the two below
> as the size of cyclic buffer when the size isn't specified:
> 
>   a. the size enough for storing the 1st/2nd bitmap for the whole of vmcore
>   b. the limit size (e.g. 70-80% of free memory)
> 
> However, I don't have a good idea how to determine the appropriate size
> for the case of "b". 
> If someone have a idea for the limit size, please let me know.

May be just look at "free" output or "cat /proc/meminfo" and grep for
"MemFree" calculate the size of buffer.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

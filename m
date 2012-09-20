Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TEbBN-0007dO-LD
 for kexec@lists.infradead.org; Thu, 20 Sep 2012 07:28:24 +0000
Date: Thu, 20 Sep 2012 16:25:35 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: Query about cyclic buffer size
Message-Id: <20120920162535.63048af2d22e607a8f809133@mxc.nes.nec.co.jp>
In-Reply-To: <20120913141018.GG4396@redhat.com>
References: <20120913141018.GG4396@redhat.com>
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

On Thu, 13 Sep 2012 10:10:18 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> Hi Atsushi-san,
> 
> How is size of cyclic buffer decided with 1.5.0? In practice I don't think
> asking user for the size is a good idea as user does not know how much
> memory will be left after kernel boot.

As you said, I don't think asking user for the size is a smart way, either.
So, I agree with your basic idea explained in below.

> Will it make sense for makedumpfile to automatically determine the buffer
> size based on amount of free memory available in the system. Something
> like use 70-80% of free memory as cyclic buffer.

Now, I think makedumpfile should automatically choose the lesser of the two below
as the size of cyclic buffer when the size isn't specified:

  a. the size enough for storing the 1st/2nd bitmap for the whole of vmcore
  b. the limit size (e.g. 70-80% of free memory)

However, I don't have a good idea how to determine the appropriate size
for the case of "b". 
If someone have a idea for the limit size, please let me know.


By the way, I'll be on long vacation until Sep 30, so I can't reply.

Thanks
Atsushi kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

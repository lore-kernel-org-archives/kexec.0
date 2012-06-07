Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1ScVsI-0004Zx-7E
 for kexec@lists.infradead.org; Thu, 07 Jun 2012 06:07:17 +0000
Date: Thu, 7 Jun 2012 15:04:36 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [RFC PATCH 2/4] makedumpfile: Add partial bitmap for cyclic.
Message-Id: <20120607150436.4c1d35cb.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120604.121957.454958033.d.hatayama@jp.fujitsu.com>
References: <20120531140103.264cc0c4.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120604.121957.454958033.d.hatayama@jp.fujitsu.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: d.hatayama@jp.fujitsu.com
Cc: kexec@lists.infradead.org

Hello HATAYAMA-san,

On Mon, 04 Jun 2012 12:19:57 +0900 (JST)
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> > + */
> > +#define BUFSIZE_CYCLIC	        (8192)
> > +#define PFN_CYCLIC		(BUFSIZE_CYCLIC * BITPERBYTE)
> > +
> > +
> > +/*
> >   * Minimam vmcore has 2 ProgramHeaderTables(PT_NOTE and PT_LOAD).
> 
> How did you choose this buffer size? Best performance? I think the
> performacne varies according to this buffer size, and to evaluate it,
> it's useful to be able to specify the size through command-line.

Honestly, the buffer size has no means, I defined it without a specific reason
at first.

However, it's understandable that the size is important key for performance and
I agree with your opinion that enabling to specify the size is useful.

But, I noticed just now, prototype with increased buffer size isn't work correctly.

 - BUFSIZE_CYCLIC = 8192:

    $ makedumpfile -Kcd31 vmcore testdump.Kcd31
    ...
    The dumpfile is saved to testdump.Kcd31.

    makedumpfile Completed.
    $ ls -l testdump.*
    -rw------- 1 kumagai kumagai 21167309  6月  7 13:55 testdump.Kcd31
    -rw------- 1 kumagai kumagai 21167309  6月  7 13:28 testdump.cd31
    $

 - BUFSIZE_CYCLIC = 16384:

    $ makedumpfile -Kcd31 vmcore testdump.Kcd31
    ...
    The dumpfile is saved to testdump.Kcd31.

    makedumpfile Completed.
    $ ls -l testdump.*
    -rw------- 1 kumagai kumagai 18836948  6月  7 13:59 testdump.Kcd31
    -rw------- 1 kumagai kumagai 21167309  6月  7 13:28 testdump.cd31
    $


I must review my code quickly.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

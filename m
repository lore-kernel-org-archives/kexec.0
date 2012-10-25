Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TREqB-0006jl-Ek
 for kexec@lists.infradead.org; Thu, 25 Oct 2012 04:14:47 +0000
Date: Thu, 25 Oct 2012 13:07:36 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: cyclic makedumpfile
Message-Id: <20121025130736.77765a435b25ebc6878ef2f7@mxc.nes.nec.co.jp>
In-Reply-To: <E1TQnJR-000146-BZ@eag09.americas.sgi.com>
References: <E1TQnJR-000146-BZ@eag09.americas.sgi.com>
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
To: cpw@sgi.com
Cc: kexec@lists.infradead.org

Hello Cliff,

On Tue, 23 Oct 2012 17:51:05 -0500
Cliff Wickman <cpw@sgi.com> wrote:

> Hello Mr. Kumagai,
> 
>   I was looking for some information about the "cyclic" processing in 
>   makedumpfile, and came upon this:
>      http://lists.infradead.org/pipermail/kexec/2012-July/006480.html
>   That's why I'm sending this question to you.

Thank you for your suggestion for improvement.

>   I work on the Linux kernel here at SGI.  We are trying to dump some very
>   large memories, and so we are very interested in this cyclic feature.
> 
>   I built makedumpfile-1.5.0 and tried it out.
>   It seems to work fine, but does spend a lot of time building bitmaps.
>   
>   If I set the cyclic-buffer value to create 3 cycles, then
>   exclude_unneccessary_pages_cyclic() is entered 6 times:
>   - 3 times from get_num_dumpable_cyclic() (via update_region_cyclic())
>   - 3 times from write_kdump_pages_and_bitmap_cyclic()
>     (also via update_region_cyclic())
>
>   These page structure scans of /proc/vmcore for terabytes of memory can
>   take a long time, and so I think something might be done to remove the
>   redundant scans.
>
>   Could it not be possible to save the bitmaps created during the
>   get_num_dumpable_cyclic() pass?  And then retrieve them for the
>   write_kdump_pages_and_bitmap_cyclic() pass?  I think this could save
>   literally hours on a very large memory.
>
>   Perhaps they could be written to a file, or files.

makedumpfile should work also on the environment which doesn't mount a root
filesystem when 2nd-kernel is running. In such environments, writing to a file
isn't the solution because the bitmap file is created on 2nd-kernel's memory.
This is the starting point of our discussion.

Therefore, we can save only a chunk of bitmap at a time, so we have to scan
each region twice.

>   But I'm sure you understand the logic of makedumpfile much better than I.
>   Do you think such an enhancement is possible?
>   Or perhaps you already have another workaround?

Now, I plan to do the two enhancement for performance, please see below.

  in v1.5.1:
    - Minimaize the number of cycle
      http://lists.infradead.org/pipermail/kexec/2012-October/006864.html

  in v1.5.2:
    - Improve the filtering logic
      http://lists.infradead.org/pipermail/kexec/2012-June/006441.html


Thanks
Atsushi Kumagai

> 
> Thanks much.
> -Cliff Wickman

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

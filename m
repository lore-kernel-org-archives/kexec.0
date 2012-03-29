Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SDAlE-00086I-SA
 for kexec@lists.infradead.org; Thu, 29 Mar 2012 08:31:15 +0000
Date: Thu, 29 Mar 2012 17:09:18 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: makedumpfile memory usage grows with system memory size
Message-Id: <20120329170918.4223e816.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <20120328212204.GI18218@redhat.com>
References: <20120328212204.GI18218@redhat.com>
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
To: Don Zickus <dzickus@redhat.com>
Cc: kexec@lists.infradead.org


Hi Don-san,

On Wed, 28 Mar 2012 17:22:04 -0400
Don Zickus <dzickus@redhat.com> wrote:
> 
> I was talking to Vivek about kdump memory requirements and he mentioned
> that they vary based on how much system memory is used.
> 
> I was interested in knowing why that was and again he mentioned that
> makedumpfile needed lots of memory if it was running on a large machine
> (for example 1TB of system memory).
> 
> Looking through the makedumpfile README and using what Vivek remembered of
> makedumpfile, we gathered that as the number of pages grows, the more
> makedumpfile has to temporarily store the information in memory.  The
> possible reason was to calculate the size of the file before it was copied
> to its final destination?

makedumpfile uses the system memory of 2nd-kernel for a bitmap if RHEL.
The bitmap represents each page of 1st-kernel is excluded or not.
So the bitmap size depends on 1st-kernel's system memory.

makedumpfile creates a file /tmp/kdump_bitmapXXXXXX as the bitmap,
and the file is created on 2nd-kernel's memory if RHEL, because
RHEL does not mount a root filesystem when 2nd-kernel is running.


> I was curious if that was true and if it was, would it be possible to only
> process memory in chunks instead of all at once.
> 
> The idea is that a machine with 4Gigs of memory should consume the same
> the amount of kdump runtime memory as a 1TB memory system.
> 
> Just trying to research ways to keep the memory requirements consistent
> across all memory ranges.

I think the above purpose is good, and I don't have any idea for reducing
the bitmap size. And now I am out of makedumpfile development.
Kumagai-san is the makedumpfile maintainer now, and he will help you.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

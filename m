Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SDYOR-0007G8-1y
 for kexec@lists.infradead.org; Fri, 30 Mar 2012 09:45:17 +0000
Date: Fri, 30 Mar 2012 18:43:34 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: makedumpfile memory usage grows with system memory size
Message-Id: <20120330184334.bb285f91.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120329130514.GK18218@redhat.com>
References: <20120328212204.GI18218@redhat.com>
 <20120329170918.4223e816.oomichi@mxs.nes.nec.co.jp>
 <20120329130514.GK18218@redhat.com>
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
To: dzickus@redhat.com
Cc: oomichi@mxs.nes.nec.co.jp, kexec@lists.infradead.org

Hello Don,
 
> > On Thu, 29 Mar 2012 09:05:14 -0400
> > Don Zickus <dzickus@redhat.com> wrote:
> > 
> > > Hi Ken'ichi-san,
> > > 
> > > On Thu, Mar 29, 2012 at 05:09:18PM +0900, Ken'ichi Ohmichi wrote:
> > > > 
> > > > Hi Don-san,
> > > > 
> > > > On Wed, 28 Mar 2012 17:22:04 -0400
> > > > Don Zickus <dzickus@redhat.com> wrote:
> > > > > 
> > > > > I was talking to Vivek about kdump memory requirements and he mentioned
> > > > > that they vary based on how much system memory is used.
> > > > > 
> > > > > I was interested in knowing why that was and again he mentioned that
> > > > > makedumpfile needed lots of memory if it was running on a large machine
> > > > > (for example 1TB of system memory).
> > > > > 
> > > > > Looking through the makedumpfile README and using what Vivek remembered of
> > > > > makedumpfile, we gathered that as the number of pages grows, the more
> > > > > makedumpfile has to temporarily store the information in memory.  The
> > > > > possible reason was to calculate the size of the file before it was copied
> > > > > to its final destination?
> > > > 
> > > > makedumpfile uses the system memory of 2nd-kernel for a bitmap if RHEL.
> > > > The bitmap represents each page of 1st-kernel is excluded or not.
> > > > So the bitmap size depends on 1st-kernel's system memory.
> > > > 
> > > > makedumpfile creates a file /tmp/kdump_bitmapXXXXXX as the bitmap,
> > > > and the file is created on 2nd-kernel's memory if RHEL, because
> > > > RHEL does not mount a root filesystem when 2nd-kernel is running.
> > > 
> > > Ok.

Does setting TMPDIR solve your problem ? Please refer to the man page.


    ENVIRONMENT VARIABLES
           TMPDIR  This  environment  variable  is  for  a temporary memory bitmap
                   file.  If your machine has a lots of memory and you  use  tmpfs
                   on  /tmp,  makedumpfile can fail for a little memory in the 2nd
                   kernel because makedumpfile makes a very large temporary memory
                   bitmap  file in this case. To avoid this failure, you can set a
                   TMPDIR environment variable. If you do not set a  TMPDIR  envi-
                   ronment variable, makedumpfile uses /tmp directory for a tempo-
                   rary bitmap file as a default.


On the other hand, I'm considering the enhancement suggested by Hatayama-san now.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

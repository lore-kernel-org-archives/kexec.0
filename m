Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SEbE2-0004cV-Aa
 for kexec@lists.infradead.org; Mon, 02 Apr 2012 06:58:53 +0000
Subject: Re: makedumpfile memory usage grows with system memory size
Message-Id: <20120402155353tachibana@mail.jp.nec.com>
Mime-Version: 1.0
From: tachibana@mxm.nes.nec.co.jp
Date: Mon, 2 Apr 2012 15:53:53 +0900
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

Hi Don,

On 2012/03/30 09:19:16 -0400, Don Zickus <dzickus@redhat.com> wrote:
> On Fri, Mar 30, 2012 at 06:43:34PM +0900, Atsushi Kumagai wrote:
> > Hello Don,
> > Does setting TMPDIR solve your problem ? Please refer to the man page.
> > 
> > 
> >     ENVIRONMENT VARIABLES
> >            TMPDIR  This  environment  variable  is  for  a temporary memory bitmap
> >                    file.  If your machine has a lots of memory and you  use  tmpfs
> >                    on  /tmp,  makedumpfile can fail for a little memory in the 2nd
> >                    kernel because makedumpfile makes a very large temporary memory
> >                    bitmap  file in this case. To avoid this failure, you can set a
> >                    TMPDIR environment variable. If you do not set a  TMPDIR  envi-
> >                    ronment variable, makedumpfile uses /tmp directory for a tempo-
> >                    rary bitmap file as a default.
> 
> I do not think it will because we run the second kernel inside the
> initramfs and do not mount any extra disks.  So the only location available
> for the temporary memory bitmap would be memory either tmpfs or something
> else.  Regardless the file ends up in memory.

If a file system for a dump file is on the local system, it is effective that
we specify a directory as TMPDIR in the same file system, isn't it?


Thanks
tachibana

> 
> > 
> > 
> > On the other hand, I'm considering the enhancement suggested by Hatayama-san now.
> 
> His idea looks interesting if it works.  Thanks.
> 
> Cheers,
> Don
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

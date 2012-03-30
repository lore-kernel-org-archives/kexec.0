Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SDbje-00073b-3L
 for kexec@lists.infradead.org; Fri, 30 Mar 2012 13:19:23 +0000
Date: Fri, 30 Mar 2012 09:19:16 -0400
From: Don Zickus <dzickus@redhat.com>
Subject: Re: makedumpfile memory usage grows with system memory size
Message-ID: <20120330131916.GV18218@redhat.com>
References: <20120328212204.GI18218@redhat.com>
 <20120329170918.4223e816.oomichi@mxs.nes.nec.co.jp>
 <20120329130514.GK18218@redhat.com>
 <20120330184334.bb285f91.kumagai-atsushi@mxc.nes.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120330184334.bb285f91.kumagai-atsushi@mxc.nes.nec.co.jp>
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
Cc: oomichi@mxs.nes.nec.co.jp, kexec@lists.infradead.org

On Fri, Mar 30, 2012 at 06:43:34PM +0900, Atsushi Kumagai wrote:
> Hello Don,
> Does setting TMPDIR solve your problem ? Please refer to the man page.
> 
> 
>     ENVIRONMENT VARIABLES
>            TMPDIR  This  environment  variable  is  for  a temporary memory bitmap
>                    file.  If your machine has a lots of memory and you  use  tmpfs
>                    on  /tmp,  makedumpfile can fail for a little memory in the 2nd
>                    kernel because makedumpfile makes a very large temporary memory
>                    bitmap  file in this case. To avoid this failure, you can set a
>                    TMPDIR environment variable. If you do not set a  TMPDIR  envi-
>                    ronment variable, makedumpfile uses /tmp directory for a tempo-
>                    rary bitmap file as a default.

I do not think it will because we run the second kernel inside the
initramfs and do not mount any extra disks.  So the only location available
for the temporary memory bitmap would be memory either tmpfs or something
else.  Regardless the file ends up in memory.

> 
> 
> On the other hand, I'm considering the enhancement suggested by Hatayama-san now.

His idea looks interesting if it works.  Thanks.

Cheers,
Don

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

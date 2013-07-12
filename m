Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UxgQP-0004B7-Vj
 for kexec@lists.infradead.org; Fri, 12 Jul 2013 16:42:30 +0000
Date: Fri, 12 Jul 2013 12:42:02 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: makedumpfile 1.5.4, 734G kdump tests
Message-ID: <20130712164202.GG2272@redhat.com>
References: <20130709162403.GA25441@sgi.com>
 <20130711130647.GA20962@redhat.com>
 <20130712161427.GA13876@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130712161427.GA13876@sgi.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Cliff Wickman <cpw@sgi.com>
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, d.hatayama@jp.fujitsu.com, kexec@lists.infradead.org

On Fri, Jul 12, 2013 at 11:14:27AM -0500, Cliff Wickman wrote:
> On Thu, Jul 11, 2013 at 09:06:47AM -0400, Vivek Goyal wrote:
> > On Tue, Jul 09, 2013 at 11:24:03AM -0500, Cliff Wickman wrote:
> > 
> > [..]
> > > UV2000   memory: 734G
> > > makedumpfile: makedumpfile-1.5.4
> > > kexec:   git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> > > booted with   crashkernel=1G,high crashkernel=192M,low
> > > non-cyclic mode
> > > 
> > > write to       option            init&scan sec.   copy sec.  dump size
> > > -------------  -----------------           ----   ---------  ---------
> > > megaraid disk  no compression                19          91      11.7G
> > > megaraid disk  zlib compression              20         209       1.4G
> > > megaraid disk  snappy compression            20          46       2.4G
> > > megaraid disk  snappy compression no mmap    30          72       2.4G
> > > /dev/null      no compression                19          28          -
> > > /dev/null      zlib compression              19         206          -
> > > /dev/null      snappy compression            19          41          -
> > > 
> > > Notes and observations
> > > - Snappy compression is a big win over zlib compression; over 4 times faster
> > >   with a cost of relatively little disk space.
> > 
> > Thanks for the results Cliff. If it is not too much of trouble, can you
> > please also test with lzo compression on same configuration. I am 
> > curious to know how much better snappy performs as compared to lzo.
> > 
> > Thanks
> > Vivek
> 
> Ok.  I repeated the tests and included LZO compression.
> 
> UV2000   memory: 734G
> makedumpfile: makedumpfile-1.5.4     non-cyclic mode
> kexec: git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> 3.10 kernel with vmcore mmap patches
> booted with   crashkernel=1G,high crashkernel=192M,low
> 
> write to       compression       init&scan sec.   copy sec.  dump size
> -------------  -----------------           ----   ---------  ---------
> megaraid disk  no compression                20          86      11.6G
> megaraid disk  zlib compression              19         209       1.4G
> megaraid disk  snappy compression            20          47       2.4G
> megaraid disk  lzo compression               19          54       2.8G
> 
> /dev/null      no compression                19          28          -
> /dev/null      zlib compression              20         206          -
> /dev/null      snappy compression            19          42          -
> /dev/null      lzo compression               20          47          -
> 
> Notes:
> - Snappy compression is still be fastest (and more compressed than LZO),
>   but LZO is close.
> - Compression and I/O seem pretty well overlapped, so I am not sure that
>   multithreading the crash kernel (to speed compression) will speed the
>   dump as much I was hoping, unless perhaps the I/O device is an SSD.

Thanks Cliff. So LZO is pretty close to snappy in this case.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Td18w-0001BU-17
 for kexec@lists.infradead.org; Mon, 26 Nov 2012 16:02:47 +0000
Date: Mon, 26 Nov 2012 11:02:38 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC] makedumpfile-1.5.1 RC
Message-ID: <20121126160237.GA2301@redhat.com>
References: <20121116171539.152467f3611c12fbd6b6be0d@mxc.nes.nec.co.jp>
 <1353413695.13097.131.camel@lisamlinux.fc.hp.com>
 <20121120163545.GC30248@redhat.com>
 <1353416600.13097.152.camel@lisamlinux.fc.hp.com>
 <20121120214606.GB3823@redhat.com>
 <1353438341.13097.187.camel@lisamlinux.fc.hp.com>
 <20121121135421.GA13114@redhat.com>
 <33710E6CAA200E4583255F4FB666C4E20AB0B3EE@G01JPEXMBYT03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <33710E6CAA200E4583255F4FB666C4E20AB0B3EE@G01JPEXMBYT03>
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
To: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Cc: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Hoemann,
 Jerry" <jerry.hoemann@hp.com>, Lisa Mitchell <lisa.mitchell@hp.com>, Cliff Wickman <cpw@sgi.com>

On Thu, Nov 22, 2012 at 12:49:35AM +0000, Hatayama, Daisuke wrote:
> > -----Original Message-----
> > From: kexec-bounces@lists.infradead.org
> > [mailto:kexec-bounces@lists.infradead.org] On Behalf Of Vivek Goyal
> > Sent: Wednesday, November 21, 2012 10:54 PM
> > To: Lisa Mitchell
> > Cc: kexec@lists.infradead.org; Atsushi Kumagai; Hoemann, Jerry; Cliff
> > Wickman
> > Subject: Re: [RFC] makedumpfile-1.5.1 RC
> [...]
> > > The changes proposed by Ciff Wickman in
> > > http://lists.infradead.org/pipermail/kexec/2012-November/007178.html
> > > sound like they could bring big improvements in performance, so these
> > > should be investigated.  I would like to try a version of them built on
> > > top of makedumpfile v1.5.1-rc, to try on our 4 TB system, to see what
> > > performance gains we can get, as an experiment.
> > 
> > I am wondering if it is time to look into parallel processing. Somebody
> > was working on bringing up more cpus in kdump kernel. If that works, the
> > probably multiple makedumpfile threads can try to filter out different
> > sections of physical memory.
> > 
> 
> Makedumpfile has already had such parallel processing feature:
> 
> $ ./makedumpfile --help
> ...
>   [--split]:
>       Split the dump data to multiple DUMPFILEs in parallel. If specifying
>       DUMPFILEs on different storage devices, a device can share I/O load with
>       other devices and it reduces time for saving the dump data. The file size
>       of each DUMPFILE is smaller than the system memory size which is divided
>       by the number of DUMPFILEs.
>       This feature supports only the kdump-compressed format.
> 
> Doing makedumpfile like:
> 
>   $ makedumpfile --split dumpfile vmcore1 vmcore2 [vmcore3 ... vmcore_n]
> 

Ok, this is interesting. So reassembling of various vmcore fragments
happen later and user needs to explicitly do that?


> original dumpfile are splitted into n vmcores of kdump-compressed formats, each of
> which has the same size basically and where n processes are used, not threads.
> (The author told me the reason why process was chosen that he didn't want to put
> relatively large libc library in the 2nd kernel at that time. But recently, libc library is
> present on the 2nd kernel as scp needs to use it. This might no longer pointless.)
> 
> I think Cliff's idea works orthogonally to parallel processing. I'll also test it on our
> machine.
> 
> Also, sorry for delaying the work on multiple cpus in the 2nd kernel. Posting new
> version of the patch set is delayed a few weeks more. But it's possible to wake up
> AP cpus in the 2nd kernel safely if BIOS always assigns 0 lapicid to BSP since
> then if kexec enteres 2nd kernel with some AP lcpu, kernel always assigns 1 lcpu
> number to BSP lcpu. So, maxcpus=1 and waking up cpus except for 1 lcpu works
> as a workaround. If anyone wants to bench with parallel processing, please do it
> like this.

Thanks. If you happen to do some benchmarking, please do share the
numebrs. I am really curious to know if this parallel processing will
speed up the things enough to have reasonable dump times on multi tera
byte machines.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

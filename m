Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tawvy-0005no-Tm
 for kexec@lists.infradead.org; Tue, 20 Nov 2012 23:08:51 +0000
Subject: Re: [RFC] makedumpfile-1.5.1 RC
From: Lisa Mitchell <lisa.mitchell@hp.com>
In-Reply-To: <20121120214606.GB3823@redhat.com>
References: <20121116171539.152467f3611c12fbd6b6be0d@mxc.nes.nec.co.jp>
 <1353413695.13097.131.camel@lisamlinux.fc.hp.com>
 <20121120163545.GC30248@redhat.com>
 <1353416600.13097.152.camel@lisamlinux.fc.hp.com>
 <20121120214606.GB3823@redhat.com>
Date: Tue, 20 Nov 2012 12:05:41 -0700
Message-ID: <1353438341.13097.187.camel@lisamlinux.fc.hp.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, "Hoemann,
 Jerry" <jerry.hoemann@hp.com>, Cliff Wickman <cpw@sgi.com>

On Tue, 2012-11-20 at 21:46 +0000, Vivek Goyal wrote:
> On Tue, Nov 20, 2012 at 06:03:20AM -0700, Lisa Mitchell wrote:
> > On Tue, 2012-11-20 at 16:35 +0000, Vivek Goyal wrote:
> > > On Tue, Nov 20, 2012 at 05:14:55AM -0700, Lisa Mitchell wrote:
> > > 
> > > [..]
> > > > I tested this makedumpfile v1.5.1-rc on a 4 TB DL980, on 2.6.32 based
> > > > kernel, and got good results. With crashkernel=256M, and default
> > > > settings (i.e. no cyclic buffer option selected), the dump successfully
> > > > completed in about 2 hours, 40 minutes, and then I specified a cyclic
> > > > buffer size of 48 M, and the dump completed in the same time, no
> > > > measurable differences within the accuracy of our measurements. 
> > > 
> > > This sounds little odd to me.
> > > 
> > > - With smaller buffer size of 48M, it should have taken much more time
> > >   to finish the dump as compared to when no restriction was put on
> > >   buffer size. I am assuming that out of 256M reserved, say around 128MB
> > >   was available for makedumpfile to use.
> > > 
> > > - Also 2 hours 40 minutes sounds a lot. Is it practical to wait that
> > >   long for a machine to dump before it can be brought into service
> > >   again? Do you have any data w.r.t older makedumpfile (which did not
> > >   have cyclic buffer logic).
> > > 
> > > I have some data which I collected in 2008. 128GB system took roughly
> > > 4 minutes to filter and save dumpfile. So if we scale it linearly
> > > then it should take around 32minutes per TB. Hence around 2 hours
> > > 8 minutes for a 4TB systems. Your numbers do seems to be in roughly
> > > inline.
> > > 
> > > Still 2-2.5 hours seems too long to be able to filter and save core of a
> > > 4TB system. We will probably need to figure out what's taking so much of
> > > time. May be we need to look into cliff wickman's idea of kernel returning
> > > list of pfns to dump and make dump 20 time faster. I will love to have 4TB
> > > system dumped in 6 minutes as opposed to 2 hrs. :-)
> > > 
> > > Thanks
> > > Vivek
> > 
> > As I stated, I don't really have precise performance data here, but the
> > time I got was comparable to the rough 3-4 hours with a larger
> > crashkernel size that I got a successful dump on this same system with a
> > makedumpfile v1.4.  We haven't made a good apples-apples comparison
> > between the two at this point, but this is how long this 4 TB system has
> > been taking to dump, dump level =31, so we feel we are in the same
> > ballpark with makedumpfile v1.5.1.  
> > 
> > It does seem that the "Excluding pages" parts take up a lot of the time
> > in the dump, as opposed to the copying, but I don't have a good
> > breakdown.  
> > 
> > I have added the debug mem_level 3 to kdump.conf file, and have seen
> > used memory on this machine  recorded right before makedumpfile creates
> > the bitmap and starts filtering be around 140 MB, and have seen
> > makedumpfile fail, with OOM killer active after this point with a
> > crashkernel size of 256 MB or 384 MB using makedumpfile v1.4.  
> 
> That's sounds right. makedumpfile requires roughly 64MB of memory per TB.
> So to be able to filter out 4TB, one needs 256MB of free memory. So no
> wonder makedumpfile v1.4 will fail with 140MB free.
> 
> > 
> > So makedumpfile v1.5.1 solves the above problem, and allows us to
> > successfully dump a 4 TB system with these smaller crashkernel sizes.
> 
> Ok, great. Good to know v1.5.1 is atleast allowing dumping higher memory
> systems with smaller reserved amount of memory.
> 
> > 
> > We do need much better performance numbers  to insure no regression from
> > makedumpfile v1.4, but I wanted you to get the feedback at least of what
> > testing we had done, and that it appears it is solving the primary
> > problem we were interested in, that we could dump many terabytes of
> > memory with crashkernel sizes fixed at 384 MB or below. 
> 
> Fair enough.
> 
> Thanks
> Vivek

That said, I am very interested in seeing any changes to makedumpfile or
anywhere in the kexec/kdump code that promise substantial improvements
for dump performance, especially to the multi TB systems.  The dump time
currently is very long for these systems, and the customers for these
large systems want minimum downtime, so improving the current status quo
is a high priority. 

The changes proposed by Ciff Wickman in
http://lists.infradead.org/pipermail/kexec/2012-November/007178.html
sound like they could bring big improvements in performance, so these
should be investigated.  I would like to try a version of them built on
top of makedumpfile v1.5.1-rc, to try on our 4 TB system, to see what
performance gains we can get, as an experiment. 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Taqne-0005h0-48
 for kexec@lists.infradead.org; Tue, 20 Nov 2012 16:35:52 +0000
Date: Tue, 20 Nov 2012 11:35:45 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC] makedumpfile-1.5.1 RC
Message-ID: <20121120163545.GC30248@redhat.com>
References: <20121116171539.152467f3611c12fbd6b6be0d@mxc.nes.nec.co.jp>
 <1353413695.13097.131.camel@lisamlinux.fc.hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1353413695.13097.131.camel@lisamlinux.fc.hp.com>
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
To: Lisa Mitchell <lisa.mitchell@hp.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, jerry.hoemann@hp.com, Cliff Wickman <cpw@sgi.com>

On Tue, Nov 20, 2012 at 05:14:55AM -0700, Lisa Mitchell wrote:

[..]
> I tested this makedumpfile v1.5.1-rc on a 4 TB DL980, on 2.6.32 based
> kernel, and got good results. With crashkernel=256M, and default
> settings (i.e. no cyclic buffer option selected), the dump successfully
> completed in about 2 hours, 40 minutes, and then I specified a cyclic
> buffer size of 48 M, and the dump completed in the same time, no
> measurable differences within the accuracy of our measurements. 

This sounds little odd to me.

- With smaller buffer size of 48M, it should have taken much more time
  to finish the dump as compared to when no restriction was put on
  buffer size. I am assuming that out of 256M reserved, say around 128MB
  was available for makedumpfile to use.

- Also 2 hours 40 minutes sounds a lot. Is it practical to wait that
  long for a machine to dump before it can be brought into service
  again? Do you have any data w.r.t older makedumpfile (which did not
  have cyclic buffer logic).

I have some data which I collected in 2008. 128GB system took roughly
4 minutes to filter and save dumpfile. So if we scale it linearly
then it should take around 32minutes per TB. Hence around 2 hours
8 minutes for a 4TB systems. Your numbers do seems to be in roughly
inline.

Still 2-2.5 hours seems too long to be able to filter and save core of a
4TB system. We will probably need to figure out what's taking so much of
time. May be we need to look into cliff wickman's idea of kernel returning
list of pfns to dump and make dump 20 time faster. I will love to have 4TB
system dumped in 6 minutes as opposed to 2 hrs. :-)

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

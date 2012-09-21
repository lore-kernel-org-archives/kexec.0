Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TF3LT-0008It-3Z
 for kexec@lists.infradead.org; Fri, 21 Sep 2012 13:32:40 +0000
Date: Fri, 21 Sep 2012 09:32:32 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: makedumpfile 1.5.0 takes much more time to dump
Message-ID: <20120921133232.GC15909@redhat.com>
References: <20120920200633.GL4681@redhat.com>
 <20120921.092357.94103398.d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120921.092357.94103398.d.hatayama@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: dyoung@redhat.com, kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, chaowang@redhat.com

On Fri, Sep 21, 2012 at 09:23:57AM +0900, HATAYAMA Daisuke wrote:
> From: Vivek Goyal <vgoyal@redhat.com>
> Subject: makedumpfile 1.5.0 takes much more time to dump
> Date: Thu, 20 Sep 2012 16:06:34 -0400
> 
> > Hi Atsushi san,
> > 
> > We tried makedumpfile 1.5.0 on a 1TB machine and it seems to regress
> > badly. We reserved 192MB of memory and following are test results.
> > 
> > #1. makedumpfile-1.4.2 -E --message-level 1 -d 31
> > real     3m47.520s
> > user     0m56.543s
> > sys	 2m41.631s
> > 
> > #2. makedumpfile-1.5.0 -E --message-level 1 -d 31
> > real     52m25.262s
> > user     32m51.310s
> > sys	 18m53.265s
> > 
> > #3. makedumpfile-1.4.2 -c --message-level 1 -d 31
> > real     8m49.107s
> > user     4m34.180s
> > sys	 4m8.691s
> > 
> > #4. makedumpfile-1.5.0 -c --message-level 1 -d 31
> > real     46m48.985s
> > user     29m35.203s
> > sys	 16m43.149s
> > 
> 
> Hello Vivek,
> 
> On v1.5.0 we cannot filter free pages in constant space becuase we
> have yet to test it. Instead, the existing method is used here, which
> repeats walking on a whole page frames the number of cycles times.
> 
> As Kumagai-san explains, the number of cycles can be calculated by the
> following expression:
> 
>   N = physical memory size / (page size * bit per byte(8) * BUFSIZE_CYCLIC)
> 
> So,
> 
>   N = 2TB / (4KB * 8 * 1MB) = 64 cycles.
> 
> I guess on this environment, it took about 50 seconds to filter free
> pages in one cycle.

Ok, so once we have your walking through page struct patches in, hopefully
this problem will be gone?

If that's going to take time, can we make using of new logic conditional
on a command line option. So that user has the option of using old
logic.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

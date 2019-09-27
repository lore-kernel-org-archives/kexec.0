Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iDx2P-0007lq-Ck
 for kexec@lists.infradead.org; Fri, 27 Sep 2019 20:40:26 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: makedumpfile: Fix divide by zero in print_report()
Date: Fri, 27 Sep 2019 20:39:04 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC035909ED@BPXM09GP.gisp.nec.co.jp>
References: <20190924194005.GA7666@codemonkey.org.uk>
 <4AE2DC15AC0B8543882A74EA0D43DBEC0359079B@BPXM09GP.gisp.nec.co.jp>
 <20190926193253.GA10258@codemonkey.org.uk>
In-Reply-To: <20190926193253.GA10258@codemonkey.org.uk>
Content-Language: en-US
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Jones <davej@codemonkey.org.uk>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

> -----Original Message-----
> On Thu, Sep 26, 2019 at 06:41:48PM +0000, Kazuhito Hagio wrote:
> 
>  > > -----Original Message-----
>  > > If info->max_mapnr and pfn_memhole are equal, we divide by zero when
>  > > trying determine the 'shrinking' value.
>  > >
>  > > On the system I saw this error, we arrived at this function with
>  > > info->max_mapnr:0x0000000001080000 pfn_memhole:0x0000000001080000
>  >
>  > Thank you for the patch.
>  > I suppose that you see the error with the -E option, right?
>  >
>  > It seems that the -E option has some problems with its statistics,
>  > so I'm checking whether there is a better way to fix this.
> 
> Yes, we use the -E option.
> We manage to get useful info from the generated dump after this fix, so
> it seems it only affects the statistics output.

OK, the statistics in cyclic mode with the -E option is completely wrong
but a possible fix is likely to affect the whole of cyclic processing, so
I just cover the hole with your patch and leave the statistics problem as
a known issue at this time.  I would revisit it when I have time.

The patch was applied to the devel branch.

Thanks,
Kazu



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

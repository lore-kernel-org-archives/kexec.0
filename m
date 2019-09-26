Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from scorn.kernelslacker.org ([2600:3c03:e000:2fb::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iDZVc-0004W2-E4
 for kexec@lists.infradead.org; Thu, 26 Sep 2019 19:33:02 +0000
Date: Thu, 26 Sep 2019 15:32:53 -0400
From: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: makedumpfile: Fix divide by zero in print_report()
Message-ID: <20190926193253.GA10258@codemonkey.org.uk>
References: <20190924194005.GA7666@codemonkey.org.uk>
 <4AE2DC15AC0B8543882A74EA0D43DBEC0359079B@BPXM09GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC0359079B@BPXM09GP.gisp.nec.co.jp>
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
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Thu, Sep 26, 2019 at 06:41:48PM +0000, Kazuhito Hagio wrote:

 > > -----Original Message-----
 > > If info->max_mapnr and pfn_memhole are equal, we divide by zero when
 > > trying determine the 'shrinking' value.
 > > 
 > > On the system I saw this error, we arrived at this function with
 > > info->max_mapnr:0x0000000001080000 pfn_memhole:0x0000000001080000
 > 
 > Thank you for the patch.
 > I suppose that you see the error with the -E option, right?
 > 
 > It seems that the -E option has some problems with its statistics,
 > so I'm checking whether there is a better way to fix this.

Yes, we use the -E option.
We manage to get useful info from the generated dump after this fix, so
it seems it only affects the statistics output.

thanks,
	Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

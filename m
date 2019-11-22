Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from scorn.kernelslacker.org ([2600:3c03:e000:2fb::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iYFfu-0008EO-TF
 for kexec@lists.infradead.org; Fri, 22 Nov 2019 20:37:08 +0000
Date: Fri, 22 Nov 2019 15:37:02 -0500
From: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: makedumpfile: ELF format issues (RE: makedumpfile: Fix divide by
 zero in print_report())
Message-ID: <20191122203702.GA4615@codemonkey.org.uk>
References: <4AE2DC15AC0B8543882A74EA0D43DBEC03591761@BPXM09GP.gisp.nec.co.jp>
 <20191009213855.GA14574@codemonkey.org.uk>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03593DA7@BPXM09GP.gisp.nec.co.jp>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035949A4@BPXM09GP.gisp.nec.co.jp>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03595014@BPXM09GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC03595014@BPXM09GP.gisp.nec.co.jp>
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

On Wed, Nov 13, 2019 at 07:36:01PM +0000, Kazuhito Hagio wrote:

 > I think I've fixed the ELF issues which I could reproduce:
 > - wrong statistics
 > - e_phnum overflow
 > 
 > If you still see any problems with the latest makedumpfile,
 > please let me know.
 > 
 > Thanks,
 > Kazu

It's taken me a little while to get this stuff into our production
systems, but things are looking much better so far.  Since I pushed out
the fixes, I've seen no new corrupted dumps.  I'll keep an eye on things
and let you know if anything new comes up.

thanks!

	Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

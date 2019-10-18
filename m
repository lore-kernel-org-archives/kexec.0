Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from scorn.kernelslacker.org ([2600:3c03:e000:2fb::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iLK0D-0003fd-Rn
 for kexec@lists.infradead.org; Fri, 18 Oct 2019 04:36:39 +0000
Date: Fri, 18 Oct 2019 00:36:24 -0400
From: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: makedumpfile: ELF format issues (RE: makedumpfile: Fix divide by
 zero in print_report())
Message-ID: <20191018043624.GA28930@codemonkey.org.uk>
References: <4AE2DC15AC0B8543882A74EA0D43DBEC03591761@BPXM09GP.gisp.nec.co.jp>
 <20191016152932.GA25107@codemonkey.org.uk>
 <4AE2DC15AC0B8543882A74EA0D43DBEC0359244C@BPXM09GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC0359244C@BPXM09GP.gisp.nec.co.jp>
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

On Thu, Oct 17, 2019 at 08:55:54PM +0000, Kazuhito Hagio wrote:

 > > I'll rework things so that it redirects to a file instead of dmesg, but
 > > it's going to take me a while to get that deployed and tested.
 > 
 > If your hosts have a big space enough, thare is another way that
 > you use cp for /proc/vmcore and use makedumpfile after reboot.
 > For example:
 > 
 >   # cp --sparse=always /proc/vmcore vmcore.cp
 >   reboot
 >   # makedumpfile -E -d 31 --message-level 31 --cyclic-buffer 4096 vmcore.cp dump.Ed31

I did try something like this (but without --sparse flag).
It took around 90 minutes to dump a 256GB core in my test, which isn't going
to be viable for our production hosts where I'm seeing the corruption
problems.

I've also been trying unsuccessfully to try and replicate it on an
isolated machine with similar specifications.

I'll give the sparse flag a try, though if memory is full enough to
panic-on-oom (Which seems to be one common trigger for this issue),
things might not be quite as sparse as I hope.

 > where the --cyclic-buffer option is needed to behave like in 2nd kernrel
 > on the one of your hosts:
 >   [   13.341818] Buffer size for the cyclic mode: 4194304
 > 
 > The captured vmcore.cp may be useful for trying a next patch first.

We had similar thoughts ;)

	Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

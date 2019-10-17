Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iLCqo-0008C1-7i
 for kexec@lists.infradead.org; Thu, 17 Oct 2019 20:58:27 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: makedumpfile: ELF format issues (RE: makedumpfile: Fix divide
 by zero in print_report())
Date: Thu, 17 Oct 2019 20:55:54 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC0359244C@BPXM09GP.gisp.nec.co.jp>
References: <4AE2DC15AC0B8543882A74EA0D43DBEC03591761@BPXM09GP.gisp.nec.co.jp>
 <20191016152932.GA25107@codemonkey.org.uk>
In-Reply-To: <20191016152932.GA25107@codemonkey.org.uk>
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
> On Wed, Oct 09, 2019 at 08:03:51PM +0000, Kazuhito Hagio wrote:
> 
>  > In this case, was the "makedumpfile Completed." message emitted?
>  > It looks like the buffer of program headers was not written to the file..
>  >
>  > Anyway, a debugging patch attached below.
> 
> Our kdump tooling redirects makedumpfile output to dmesg, and unfortunately this debug
> patch produces so much info it filled the ring buffer, so we didn't
> catch the beginning.

ah, if makedumpfile makes more than 64k program headers, the debug log
will be more than 8MB.  I should have told you this..

> I'll rework things so that it redirects to a file instead of dmesg, but
> it's going to take me a while to get that deployed and tested.

If your hosts have a big space enough, thare is another way that
you use cp for /proc/vmcore and use makedumpfile after reboot.
For example:

  # cp --sparse=always /proc/vmcore vmcore.cp
  reboot
  # makedumpfile -E -d 31 --message-level 31 --cyclic-buffer 4096 vmcore.cp dump.Ed31

where the --cyclic-buffer option is needed to behave like in 2nd kernrel
on the one of your hosts:
  [   13.341818] Buffer size for the cyclic mode: 4194304

The captured vmcore.cp may be useful for trying a next patch first.

Thanks,
Kazu



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

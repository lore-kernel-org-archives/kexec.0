Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from scorn.kernelslacker.org ([2600:3c03:e000:2fb::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iKlF6-0008LK-Fg
 for kexec@lists.infradead.org; Wed, 16 Oct 2019 15:29:46 +0000
Date: Wed, 16 Oct 2019 11:29:32 -0400
From: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: makedumpfile: ELF format issues (RE: makedumpfile: Fix divide by
 zero in print_report())
Message-ID: <20191016152932.GA25107@codemonkey.org.uk>
References: <4AE2DC15AC0B8543882A74EA0D43DBEC03591761@BPXM09GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC03591761@BPXM09GP.gisp.nec.co.jp>
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

On Wed, Oct 09, 2019 at 08:03:51PM +0000, Kazuhito Hagio wrote:

 > In this case, was the "makedumpfile Completed." message emitted?
 > It looks like the buffer of program headers was not written to the file..
 > 
 > Anyway, a debugging patch attached below.

Our kdump tooling redirects makedumpfile output to dmesg, and unfortunately this debug
patch produces so much info it filled the ring buffer, so we didn't
catch the beginning.

I'll rework things so that it redirects to a file instead of dmesg, but
it's going to take me a while to get that deployed and tested.

	Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

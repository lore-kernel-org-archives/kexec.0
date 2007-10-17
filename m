Return-path: <kexec-bounces@lists.infradead.org>
Received: from tyo200.gate.nec.co.jp ([210.143.35.50])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Ii1LA-0002e9-6W
	for kexec@lists.infradead.org; Wed, 17 Oct 2007 06:21:10 +0100
Received: from tyo202.gate.nec.co.jp ([10.7.69.202])
	by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l9H5J2YR017690
	for <kexec@lists.infradead.org>; Wed, 17 Oct 2007 14:19:02 +0900 (JST)
Message-Id: <47159AA3.10305@mxs.nes.nec.co.jp>
Date: Wed, 17 Oct 2007 14:16:19 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] [kexec-tools] Pass vmcoreinfo's address and size
References: <20070822210838oomichi@mail.jp.nec.com>
	<20070822211339oomichi@mail.jp.nec.com>
	<20071017023305.GC6709@verge.net.au>
In-Reply-To: <20071017023305.GC6709@verge.net.au>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Don Zickus <dzickus@redhat.com>, Neil Horman <nhorman@redhat.com>, Dan Aloni <da-x@monatomic.org>, Bernhard Walle <bwalle@suse.de>, kexec-ml <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>


Hi Simon,

Simon Horman wrote:
> On Wed, Aug 22, 2007 at 09:13:39PM +0900, Ken'ichi Ohmichi wrote:
>> [2/3] [kexec-tools] Pass vmcoreinfo's address and size
>> The patch is for kexec-tools-testing-20070330.
>> (http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/)
>> kexec command gets the address and size of the vmcoreinfo data from
>> /sys/kernel/vmcoreinfo, and passes them to the second kernel through
>> ELF header of /proc/vmcore. When the second kernel is booting, the
>> kernel gets them from the ELF header and creates vmcoreinfo's PT_NOTE
>> segment into /proc/vmcore.
> 
> Sorry for the long delay, I completely missed this patch.
> 
> The kexec-tools change seems ok to me. What is the status of
> the kernel portion of the change?

The kernel portion is merged into linux-2.6.23-mm1.
According to Andrew's mail "-mm merge plans for 2.6.24",  its status is
"The infamous misc.  Will re-review and will merge basically all of them".

http://www.ussg.iu.edu/hypermail/linux/kernel/0710.0/0313.html


> Do you still want the kexec-tools portion applied?

Yes, I hope so.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

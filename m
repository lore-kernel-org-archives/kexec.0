Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from www.linutronix.de ([62.245.132.108] helo=Galois.linutronix.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TvWoz-0007Y7-Sx
 for kexec@lists.infradead.org; Wed, 16 Jan 2013 17:30:42 +0000
Date: Wed, 16 Jan 2013 18:30:34 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 3/3] ppc/uImage: Add support for RAM Disks
Message-ID: <20130116173034.GC20369@linutronix.de>
References: <20130111063547.11490.28174.stgit@suzukikp.in.ibm.com>
 <20130111064203.11490.72998.stgit@suzukikp.in.ibm.com>
 <70CC66F5C30A414DADDA6973E4CA391A820296@039-SN1MPN1-002.039d.mgd.msft.net>
 <50F3944D.7080506@in.ibm.com>
 <70CC66F5C30A414DADDA6973E4CA391A83353D@039-SN1MPN1-001.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <70CC66F5C30A414DADDA6973E4CA391A83353D@039-SN1MPN1-001.039d.mgd.msft.net>
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
To: McClintock Matthew-B29882 <B29882@freescale.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "lethal@linux-sh.org" <lethal@linux-sh.org>, "Suzuki K. Poulose" <suzuki@in.ibm.com>, "horms@verge.net.au" <horms@verge.net.au>, "mat@brain-dump.org" <mat@brain-dump.org>

* McClintock Matthew-B29882 | 2013-01-14 15:14:16 [+0000]:

>On Sun, Jan 13, 2013 at 11:14 PM, Suzuki K. Poulose <suzuki@in.ibm.com> wrote:
>> On 01/11/2013 12:41 PM, McClintock Matthew-B29882 wrote:
>>>
>>> On Fri, Jan 11, 2013 at 12:42 AM, Suzuki K. Poulose <suzuki@in.ibm.com>
>>> wrote:
>>>>
>>>> From: Suzuki K. Poulose <suzuki@in.ibm.com>
>>>>
>>>> Handle the RAM Disks in uImage format
>>>
>>>
>>> As opposed to simple ext2.gz ramdisk?
>
>OK - it's been a while but we only supported uImage for kernel image
>not ramdisk. That's what threw me off when I wrote this email I
>believe.

Who is "we"? Did you use kexec and pass ext2.gz as a ramdisk?

u-boot supports this like for ever. You start the kernel via
 bootm x y z

where y is the address of the ramdisk / initrd. passing the address the
ext2.gz files does not work.
As an alternative to this you can only pass x to bootm and the image has
the "uImage.FIT" format which can contain the kernel, device tree and a
ramdisk in one piece.

>-M

Sebastian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

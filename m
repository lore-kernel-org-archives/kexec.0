Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]
 helo=va3outboundpool.messaging.microsoft.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TvWwn-0000ot-EY
 for kexec@lists.infradead.org; Wed, 16 Jan 2013 17:38:46 +0000
From: McClintock Matthew-B29882 <B29882@freescale.com>
Subject: Re: [PATCH 3/3] ppc/uImage: Add support for RAM Disks
Date: Wed, 16 Jan 2013 17:37:45 +0000
Message-ID: <70CC66F5C30A414DADDA6973E4CA391A83F787@039-SN1MPN1-001.039d.mgd.msft.net>
References: <20130111063547.11490.28174.stgit@suzukikp.in.ibm.com>
 <20130111064203.11490.72998.stgit@suzukikp.in.ibm.com>
 <70CC66F5C30A414DADDA6973E4CA391A820296@039-SN1MPN1-002.039d.mgd.msft.net>
 <50F3944D.7080506@in.ibm.com>
 <70CC66F5C30A414DADDA6973E4CA391A83353D@039-SN1MPN1-001.039d.mgd.msft.net>
 <20130116173034.GC20369@linutronix.de>
In-Reply-To: <20130116173034.GC20369@linutronix.de>
Content-Language: en-US
Content-ID: <1A17697BEB2D3B40937350E5271C580C@mgd.freescale.com>
MIME-Version: 1.0
Reply-To: McClintock Matthew-B29882 <B29882@freescale.com>
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
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "horms@verge.net.au" <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "lethal@linux-sh.org" <lethal@linux-sh.org>, "Suzuki K. Poulose" <suzuki@in.ibm.com>, "mat@brain-dump.org" <mat@brain-dump.org>, McClintock Matthew-B29882 <B29882@freescale.com>

On Wed, Jan 16, 2013 at 11:30 AM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> Who is "we"? Did you use kexec and pass ext2.gz as a ramdisk?

We = me for the most part.

Yes, that's what I did, I never passed in a uboot wrapped image.

-M

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

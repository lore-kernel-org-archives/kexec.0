Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UCh3R-0006vg-TR
 for kexec@lists.infradead.org; Tue, 05 Mar 2013 01:52:34 +0000
Date: Tue, 5 Mar 2013 10:52:31 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: include reserved e820 sections in crash kernel
Message-ID: <20130305015231.GB28547@verge.net.au>
References: <E1U2S76-00057L-Kp@eag09.americas.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1U2S76-00057L-Kp@eag09.americas.sgi.com>
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
To: Cliff Wickman <cpw@sgi.com>
Cc: kexec@lists.infradead.org

On Mon, Feb 04, 2013 at 01:54:00PM -0600, Cliff Wickman wrote:
> From: Cliff Wickman <cpw@sgi.com>
> 
> The crash kernel is not able to find its root device if that device is not
> on PCI 0.
> 
> This is because it is booted with the command line option memmap=exactmap
> which currently clears the e820 table and does not restore reserved spaces.
> 
> This works for a device on PCI 0 because ACPI falls back to a legacy mode.
> But the error message " [Firmware Bug]: PCI: MMCONFIG at
>  [mem 0x80000000-0x80cfffff] not reserved in ACPI motherboard resources"
> is written to the log even in this functioning case.
> 
> It fails for some devices on UV2, and only for UV2, because SGI seems to
> be the only manufacturer currently using the extended PCI(>0).
> 
> The fix is simple, as long as the command line is long enough to include
> all the reserved spaces.
> The command line may have to be lengthened. See
>   [PATCH] kexec: lengthen the kernel command line image

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

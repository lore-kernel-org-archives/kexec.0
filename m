Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TZ1nT-0000pT-53
 for kexec@lists.infradead.org; Thu, 15 Nov 2012 15:56:09 +0000
Date: Thu, 15 Nov 2012 10:55:57 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 0/7] makedumpfile security key filtering with eppic
Message-ID: <20121115155557.GF2529@redhat.com>
References: <50A4E524.8020702@linux.vnet.ibm.com>
 <348117236.32179739.1352989665917.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <348117236.32179739.1352989665917.JavaMail.root@redhat.com>
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
To: Dave Anderson <anderson@redhat.com>
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, kumagai-atsushi@mxc.nes.nec.co.jp, Aravinda Prasad <aravinda@linux.vnet.ibm.com>, buendgen@de.ibm.com

On Thu, Nov 15, 2012 at 09:27:45AM -0500, Dave Anderson wrote:

[..]
> > Yes, makedumpfile needs to be linked against eppic library for filtering
> > data and this will increase makedumpfile size and initramfs size too.
> 
> Just to clarify -- your example indicates that the vmlinux file is required
> for this facility to work, correct?
>  
> > makedumpfile -c -d 31 -x vmlinux --eppic key.c vmcore filtered_vmcore
> 
> Clearly distros won't be putting the vmlinux file in the initramfs -- that's
> the whole reasoning behind vmcoreinfo.  So the 99% of users that aren't
> interested in scrubbing will have to pay the penalty of the larger makedumpfile
> binary.

That's a good point Dave. We will never put debug compiled vmlinux in 
initramfs. Following two alternatives come to my mind.

- Either makedumpfile provides some kind of library to parse/read/write
  dump files and we can write another stand alone utility for scrubbing
  dump files (say, scrub-vmcore),  and it can link against makedumpfile
  libraries to take advantage of existing code.

- Or, we just identify what we want to scrube and make that code part
  of makedumpfile. Export relevant data structures from kernel using
  vmcoreinfo.

I prefer to keep things simple and like second option better.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

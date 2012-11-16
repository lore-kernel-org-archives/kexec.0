Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZIYH-0002KV-SV
 for kexec@lists.infradead.org; Fri, 16 Nov 2012 09:49:36 +0000
Received: from /spool/local
 by e5.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Fri, 16 Nov 2012 04:49:31 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 6B78238C803F
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 04:49:11 -0500 (EST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qAG9nAhW251172
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 04:49:11 -0500
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qAG9n9ia015960
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 02:49:10 -0700
Message-ID: <50A60C11.80406@linux.vnet.ibm.com>
Date: Fri, 16 Nov 2012 15:19:05 +0530
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/7] makedumpfile security key filtering with eppic
References: <348117236.32179739.1352989665917.JavaMail.root@redhat.com>
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
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, kumagai-atsushi@mxc.nes.nec.co.jp, Vivek Goyal <vgoyal@redhat.com>, buendgen@de.ibm.com



On 2012-11-15 19:57, Dave Anderson wrote:
...

>>> Again, how distributions will handle it. If it is being integrated
>>> makedumpfile, as opposed to an stand alone utility, that means it
>>> makedumpfile needs to link against this library so that somebody can
>>> later filter out the symbols. And that means initramfs size bloat
>>> too?
>>
>> Yes, makedumpfile needs to be linked against eppic library for filtering
>> data and this will increase makedumpfile size and initramfs size too.
> 
> Just to clarify -- your example indicates that the vmlinux file is required
> for this facility to work, correct?


Yes vmlinux file is required

> 
>> makedumpfile -c -d 31 -x vmlinux --eppic key.c vmcore filtered_vmcore
> 
> Clearly distros won't be putting the vmlinux file in the initramfs -- that's
> the whole reasoning behind vmcoreinfo.  So the 99% of users that aren't
> interested in scrubbing will have to pay the penalty of the larger makedumpfile
> binary.


vmlinux is not required in intitramfs as the filtering is done during
post processing i.e., after the the dump ia saved

> 
> Dave
> 


-- 
Regards,
Aravinda


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

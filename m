Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K69Zb-00014x-7G
	for kexec@lists.infradead.org; Tue, 10 Jun 2008 19:32:03 +0000
Date: Tue, 10 Jun 2008 21:31:58 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] Implement support for mem command line parameter
Message-ID: <20080610213158.44e2139c@kopernikus.site>
In-Reply-To: <20080610030051.GB25390@redhat.com>
References: <1212449384-22819-1-git-send-email-bwalle@suse.de>
	<20080603030440.GC32687@redhat.com>
	<20080609235729.43e38e2f@kopernikus.site>
	<20080610030051.GB25390@redhat.com>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org

* Vivek Goyal <vgoyal@redhat.com> [2008-06-09 23:00]:
>
> > Right. I just checked with 2.6.22.5 (openSUSE 10.3 kernel), and
> > 
> >   - i386: /proc/iomem contains full memory
> >   - x86_64: /proc/iomem contains truncated memory
> > 
> > After the x86 merge, x86_64 now has the behaviour of i386.
> >   
> 
> Cool. Now atleast behavior across x86 and x86_64 is same.

After studying the code, well, that was wrong. I tested again:

 - i386: /proc/iomem contains truncated memory
 - x86_64: /proc/iomem contains full memroy

And after the merge, it stays the same, i.e. /proc/iomem in i386 is
truncated.

Sorry for the confusion. :-|

The question is: Is that "accidentally" or by design. The file
Documentation/kernel-parameters.txt:

        [X86-32] Use together with memmap= to avoid physical
        address space collisions. Without memmap= PCI devices
        could be placed at addresses belonging to unused RAM.

implies that it's "by design".

(And EFI code might be different again. However, I have no non-IA64
EFI machine to test.)


Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

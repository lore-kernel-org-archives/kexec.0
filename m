Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from lo.gmane.org ([80.91.229.12])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NdhA6-0002xa-Hj
	for kexec@lists.infradead.org; Sat, 06 Feb 2010 09:41:15 +0000
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkk-kexec@m.gmane.org>) id 1Ndh9n-0004rf-NA
	for kexec@lists.infradead.org; Sat, 06 Feb 2010 10:40:51 +0100
Received: from dsl01.83.171.174.205.ip-pool.nefkom.net ([83.171.174.205])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Sat, 06 Feb 2010 10:40:51 +0100
Received: from bernhard by dsl01.83.171.174.205.ip-pool.nefkom.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Sat, 06 Feb 2010 10:40:51 +0100
From: Bernhard Walle <bernhard@bwalle.de>
Subject: Re: kdump cp /proc/vmcore exiting with "Invalid Argument" Error
Date: Sat, 06 Feb 2010 10:41:14 +0100
Message-ID: <4B6D393A.7060103@bwalle.de>
References: <74ae4f6a1002051845i6a2787deve82963c5d258eda4@mail.gmail.com>
Mime-Version: 1.0
In-Reply-To: <74ae4f6a1002051845i6a2787deve82963c5d258eda4@mail.gmail.com>
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
To: kexec@lists.infradead.org
Cc: public-fastboot-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@lo.gmane.org, public-kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@lo.gmane.org

Am 06.02.2010 03:45, schrieb Sujit V:
> I have integrated the kdump in our linux 2.6.23 based kernel. If I do
> echo c > /proc/sysrq-trigger then it boots the kdump kernel & I use
> the cp /proc/vmcore /local/crash/vmcore-incomplete
> 
> On a new x86 based hardware (32 bit PAE kernel)  the "cp /proc/vmcore
> " command exits prematurely.
> 
> cp -v /proc/vmcore /local/crash/vmcore-incomplete
>       cp: reading `/proc/vmcore': Invalid argument  >>> Error >>
> 
> ls -l /local/crash/
> total 115588
> -r--------    1 0        0        2526724096 Feb  5 03:09 vmcore-incomplete
> 
> ls -l /proc/vmcore
> -r--------    1 0        0        4153763584 Feb  5 03:16 /proc/vmcore
> 
> 
> Every time I trigger kdump the cp command exits after copying
> 2526724096 bytes. So I thought it might be a file size issue.
> Googling pointed out a patch in include/linux/proc_fs.h

I would compare 'readelf -l /proc/vmcore' (ELF program headers) and map
the file offset 2526724096 to the physical memory that belongs to that
file offset. Maybe accessing that physical memory fails for some reason.

> struct vmcore {
> struct list_head list;
> unsigned long long paddr;
> - unsigned long size;
> + unsigned long long size;
> loff_t offset;
> 
> I checked my kernel & it already has this patch.

I don't think that this is the problem because 2526724096 is between 2G
and 4G, so it doesn't point to some "magic border".


Regards,
Bernhard


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from willeweb.com ([166.70.233.13] helo=mail.willeweb.com)
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Pg1aR-0000AC-Hy
	for kexec@lists.infradead.org; Thu, 20 Jan 2011 20:58:32 +0000
From: wille <junk@willeweb.com>
Subject: Re: Re: kexec: Overlapping memory segments error
Date: Thu, 20 Jan 2011 13:40:46 -0700
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <201101201340.46996.junk@willeweb.com>
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
Cc: cpw@sgi.com

Yes, the git tree, which I built, includes your patch:
  kexec: fix /sys/firmware/memmap memory range overlaps

I thought this patch would fix my problem, but it didn't seem to help.  
Perhaps the list of memory ranges gets added to after 
fixup_memory_ranges_sysfs() is called.  Could the --initrd option do this?  
I wonder, because the error disappears when I don't include the 
kexec --initrd option.

-wille

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

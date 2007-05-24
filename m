Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from netops-testserver-4-out.sgi.com ([192.48.171.29]
	helo=relay.sgi.com)
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HrJEv-0003Qm-2G
	for kexec@lists.infradead.org; Thu, 24 May 2007 20:44:51 +0100
Message-ID: <4655EB1A.3000704@sgi.com>
Date: Thu, 24 May 2007 12:44:26 -0700
From: Jay Lan <jlan@sgi.com>
MIME-Version: 1.0
Subject: Re: [PATCH] [makedumpfile] Follow debuginfo link of vmlinux file
References: <20070501133912.GA8247@suse.de>	<20070524093556oomichi@mail.jp.nec.com>	<4655C9B3.7060903@sgi.com>
	<4655D9EA.8020601@redhat.com> <20070524192139.GA4160@suse.de>
In-Reply-To: <20070524192139.GA4160@suse.de>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Dave Anderson <anderson@redhat.com>, Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

Bernhard Walle wrote:
> Hello,
> 
> * Dave Anderson <anderson@redhat.com> [2007-05-24 20:31]:
>> The crash utility hides the details of there being a separate debug
>> file in the same way the gdb does when working with a binary executable
>> that has a separate debuginfo file.  It tries *not* to be ambiguous,
>> i.e., the point is to stay true to the "crash vmlinux vmcore" model.
> 
> It's documented in the GDB documentation:
> http://sourceware.org/gdb/current/onlinedocs/gdb_16.html#SEC154

Thanks for the pointer, Bernhard. I installed kernel-debuginfo rpm
but crash still failed to find the debug information... I had to
copy the kernel-<version>.debug to /boot for it to work.

So, i think it is a good idea for makedumpfile to follow the same
convension as crash and gdb, Ken'ichi?

Thanks,
 - jay

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

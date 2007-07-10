Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1I86A0-0007DE-Tc
	for kexec@lists.infradead.org; Mon, 09 Jul 2007 23:13:10 -0400
Subject: Re: Determine version of kernel that produced vmcore
In-reply-to: <20070706132814.GA7079@suse.de>
Message-Id: <20070710121315oomichi@mail.jp.nec.com>
References: <20070706132814.GA7079@suse.de>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Tue, 10 Jul 2007 12:13:15 +0900
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
To: Bernhard Walle <bwalle@suse.de>
Cc: Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org


Hi,

On Fri, 6 Jul 2007 17:58:04 +0300, Dan Aloni <da-x@monatomic.org> wrote:
> On Fri, Jul 06, 2007 at 03:28:14PM +0200, Bernhard Walle wrote:
> > Hello,
> > 
> > does anybody know a _reliable_ way to determine the version the kernel
> > that produced a vmcore file? This means not scanning for a specific
> > string or something like that which can fail on random memory.
> > 
> > Would it make sense to add a ELF PT_NOTE section in the vmcore?
> > 
> > Thanks for input!

(CONFIGFILE means makedumpfile's config file.)

makedumpfile checks kernel version by reading system_utsname.release
from /proc/vmcore, as you know. If the release and OSRELEASE in CONFIGFILE
don't match, makedumpfile fails.

Besides Dan's plan, I'm planning the change of CONFIGFILE for distributors.
In the kernel building process, distributors need to make CONFIGFILE
on an older kernel (ex. RHEL5 kernel is built on RHEL4), and OSRELEASE
may be an older kernel. So OSRELEASE should be modified to the building
kernel version by hand, but it is not smart.

To solve this problem, I'm proposing 2 plans.
Could you give me your opinion ?

Plan 1:
  A new option [--osrelease="string"] is added.
  The OSRELEASE of CONFIGFILE is overwritten by "string".
  In the kernel building process, distributors should specify "string"
  as the building kernel version.

Plan2:
  Remove the OSRELEASE from CONFIGFILE.
  Instead of checking the OSRELEASE, makedumpfile only checks whether the
  area of /proc/vmcore specified by the symbol "system_utsname" in CONFIGFILE
  is the string "2.6.". If CONFIGFILE and /proc/vmcore don't match, the
  "system_utsname" must not point to the correct area in most cases.
  Old makedumpfile needs OSRELEASE, and it cannot work by new CONFIGFILE.
  But I think there are not any problems because old makedumpfile will not
  read new CONFIGFILE. Now, CONFIGFILE is used only by RHEL5's kdump initramfs,
  the CONFIGFILE is generated during 1st-kernel running. Even if CONFIGFILE
  will be updated, makedumpfile can read the CONFIGFILE because makedumpfile
  should be updated with CONFIGFILE.


I'd like to change the name of CONFIGFILE to mkdfinfo.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

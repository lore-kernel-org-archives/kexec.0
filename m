Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1I8FD6-0000sw-P1
	for kexec@lists.infradead.org; Tue, 10 Jul 2007 08:54:30 -0400
Date: Tue, 10 Jul 2007 14:52:46 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: Determine version of kernel that produced vmcore
Message-ID: <20070710125245.GB22862@suse.de>
References: <20070706132814.GA7079@suse.de>
	<20070710121315oomichi@mail.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070710121315oomichi@mail.jp.nec.com>
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
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Hi,

* Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp> [2007-07-10 05:13]:
> Plan 1:
>   A new option [--osrelease="string"] is added.
>   The OSRELEASE of CONFIGFILE is overwritten by "string".
>   In the kernel building process, distributors should specify "string"
>   as the building kernel version.
> 
> Plan2:
>   Remove the OSRELEASE from CONFIGFILE.
>   Instead of checking the OSRELEASE, makedumpfile only checks whether the
>   area of /proc/vmcore specified by the symbol "system_utsname" in CONFIGFILE
>   is the string "2.6.". If CONFIGFILE and /proc/vmcore don't match, the
>   "system_utsname" must not point to the correct area in most cases.
>   Old makedumpfile needs OSRELEASE, and it cannot work by new CONFIGFILE.
>   But I think there are not any problems because old makedumpfile will not
>   read new CONFIGFILE. Now, CONFIGFILE is used only by RHEL5's kdump initramfs,
>   the CONFIGFILE is generated during 1st-kernel running. Even if CONFIGFILE
>   will be updated, makedumpfile can read the CONFIGFILE because makedumpfile
>   should be updated with CONFIGFILE.

I would propose a third method. Some information cannot be extracted
from the vmlinux file, even with debugging information. That is
currently the page size.

So why not adding an option to makedumpfile which specifies the
.config of the kernel? If the .config is available, it can extract the
missing information (page size) from the .config and also use the
kernel version from this file.

If no config is available, the current process is right since using
the version of the running kernel ensures to some degree (not 100 %)
that the page size is correct.


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

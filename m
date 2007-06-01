Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Hu35z-0000fw-TC
	for kexec@lists.infradead.org; Fri, 01 Jun 2007 05:07:20 -0400
Subject: Re: [makedumpfile] config file -- OSRELEASE
In-reply-to: <m1d50g3iwj.fsf@ebiederm.dsl.xmission.com>
Message-Id: <20070601180704oomichi@mail.jp.nec.com>
References: <m1d50g3iwj.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Fri, 1 Jun 2007 18:07:04 +0900
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: jlan@sgi.com, Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org


Hi Eric,

2007/05/31 13:14:20 -0600, ebiederm@xmission.com (Eric W. Biederman) wrote:
>> * Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp> [2007-05-30 13:13]:
>>> 2007/05/29 21:30:58 +0200, Bernhard Walle <bwalle@suse.de> wrote:
>>> >is there any reason why the kernel version saved in the configuration
>>> >file is the version of the running kernel and not the version for
>>> >which the config file is for?
>>> 
>>> The reason is that makedumpfile gets a running kernel's page_size as
>>> a 1st-kernel's page_size. If they are different, makedumpfile cannot
>>> analyze /proc/vmcore and it fails. So I think a configuration file
>>> should be created while 1st-kernel is running.
>>
>> I also didn't find a possibility to get the page size from a kernel
>> image without running the executable.
>>
>>> >It's a big problem because my plan was to ship the configuration files
>>> >with the kernel RPMs in SLES. However, we don't build the kernels on
>>> >systems which run the kernel that is just built -- so that's not
>>> >possible.
>>> 
>>> It is a good idea to ship the configuration files with the kernel RPMs. 
>>> I think you can do it with current implementation, because you need
>>> only one configuration file for one kernel image.
>>> 
>>> I think you can ship configuration files as follows:
>>> 
>>> 1. Build a kernel file and a debuginfo file.
>>> 2. Boot the system with the above kernel file.
>>> 3. Generate a configration file from a debuginfo file.
>>> 4. Ship the configration file with the kernel RPM.
>>> 
>>> Any problem to follow the method above ?
>>
>> No, that's not possible because it would change our whole build
>> process. However, I just replace the OSRELEASE now after generating
>> the config file with the kernel that's built and change the page size
>> according to the .config on IA64. That works for now. I know it's not
>> the best solution, but the only practicable for now.
>
>Do we need more information in vmlinux to make it more amenable to
>automatic processing?  version and page size for example.

Now, the items makedumpfile cannot get from vmlinux statically are
only version and page size. Do you have any idea for getting them
from vmlinux ?


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

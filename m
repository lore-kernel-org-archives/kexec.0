Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1I9Ixc-0007PJ-5f
	for kexec@lists.infradead.org; Fri, 13 Jul 2007 07:05:21 -0400
Subject: Re: Determine version of kernel that produced vmcore
In-reply-to: <20070710120243.GA10121@hmsendeavour.rdu.redhat.com>
Message-Id: <20070713200533oomichi@mail.jp.nec.com>
References: <20070710120243.GA10121@hmsendeavour.rdu.redhat.com>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Fri, 13 Jul 2007 20:05:33 +0900
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
To: Neil Horman <nhorman@redhat.com>
Cc: Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org


Hi all,

2007/07/10 08:02:43 -0400, Neil Horman <nhorman@redhat.com> wrote:
>> Besides Dan's plan, I'm planning the change of CONFIGFILE for distributors.
>> In the kernel building process, distributors need to make CONFIGFILE
>> on an older kernel (ex. RHEL5 kernel is built on RHEL4), and OSRELEASE
>> may be an older kernel. So OSRELEASE should be modified to the building
>> kernel version by hand, but it is not smart.
>> 
>> To solve this problem, I'm proposing 2 plans.
>> Could you give me your opinion ?
>> 
>> Plan 1:
>>   A new option [--osrelease="string"] is added.
>>   The OSRELEASE of CONFIGFILE is overwritten by "string".
>>   In the kernel building process, distributors should specify "string"
>>   as the building kernel version.
>> 
>> Plan2:
>>   Remove the OSRELEASE from CONFIGFILE.
>>   Instead of checking the OSRELEASE, makedumpfile only checks whether the
>>   area of /proc/vmcore specified by the symbol "system_utsname" in CONFIGFILE
>>   is the string "2.6.". If CONFIGFILE and /proc/vmcore don't match, the
>>   "system_utsname" must not point to the correct area in most cases.
>>   Old makedumpfile needs OSRELEASE, and it cannot work by new CONFIGFILE.
>>   But I think there are not any problems because old makedumpfile will not
>>   read new CONFIGFILE. Now, CONFIGFILE is used only by RHEL5's kdump initramfs,
>>   the CONFIGFILE is generated during 1st-kernel running. Even if CONFIGFILE
>>   will be updated, makedumpfile can read the CONFIGFILE because makedumpfile
>>   should be updated with CONFIGFILE.
>> 
>> 
>> I'd like to change the name of CONFIGFILE to mkdfinfo.
>> 
>Why not, instead of either plan above, just redefine OSRELEASE to be the version
>of the kernel the config file was built against?  i.e. when you build a config
>file, you need to specify a kernel to extract symbol information from, why not
>grab the utsname from that kernel and use that to set OSRELEASE?  When you're
>building a config file the running kernel on the system isn't really relevent
>anyway.

Did you say "makedumpfile should get OSRELEASE from a vmlinux file,
and output it to a mkdfinfo file", right ?
If so, you are right. I'm creating the patch for it.

BTW, I'd like to remove PAGESIZE from a mkdfinfo file.
While 2nd-kernel is running, new makedumpfile comes to consider
2nd-kernel PAGESIZE as 1st-kernel PAGESIZE without getting PAGESIZE
from a mkdfinfo file.

In current implementation, makedumpfile considers 2nd-kernel PAGESIZE
as 1st-kernel PAGESIZE if a vmlinux file is specified instead of a
mkdfinfo file. On the other hand, makedumpfile can get 1st-kernel
PAGESIZE correctly if a mkdfinfo file is specified, because there
is the rule that a mkdfinfo file should be generated on 1st-kernel.

Now, I will change this rule for generating a mkdfinfo file on the
kernel-building environment. I feel considering 2nd-kernel PAGESIZE
as 1st-kernel PAGESIZE is better than considering the PAGESIZE of
kernel-building environment, because 1st-kernel and 2nd-kernel have
the same PAGESIZE in most cases such as relocatable kernel.


Please let me know your opinion.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

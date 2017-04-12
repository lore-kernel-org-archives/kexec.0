Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cyHm5-0001dP-50
 for kexec@lists.infradead.org; Wed, 12 Apr 2017 12:53:29 +0000
From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: KASLR causes intermittent boot failures on some systems
References: <x49shlk700k.fsf@segfault.boston.devel.redhat.com>
 <20170412082433.GA3546@dhcp-128-65.nay.redhat.com>
 <20170412084037.GA3894@dhcp-128-65.nay.redhat.com>
Date: Wed, 12 Apr 2017 08:52:36 -0400
In-Reply-To: <20170412084037.GA3894@dhcp-128-65.nay.redhat.com> (Dave Young's
 message of "Wed, 12 Apr 2017 16:40:37 +0800")
Message-ID: <x49tw5t6b57.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: bhe@redhat.com, linux-nvdimm@lists.01.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@kernel.org, dan.j.williams@intel.com, thgarnie@google.com

Dave Young <dyoung@redhat.com> writes:

> On 04/12/17 at 04:24pm, Dave Young wrote:
>> I did some tests about emulated pmem via memmap=, kdump kernel hangs or
>> just reboots early during compressing kernel, no clue how to handle it.
>> Since for kdump kernel kaslr is pointless a workaround is use "nokaslr"
>> 
>> In Fedora or RHEL, just add "nokaslr" in KDUMP_COMMANDLINE_APPEND
>> in /etc/sysconfig/kdump 
>> 
>> Can you try if this works?
>
> Oops, your problem is normal boot instead of kdump so this is two
> different problems. Seems we have not met your bug yet..

Correct.

-Jeff

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

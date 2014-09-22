Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XVzb0-0005dL-TS
 for kexec@lists.infradead.org; Mon, 22 Sep 2014 09:07:47 +0000
Date: Mon, 22 Sep 2014 17:07:16 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [RFC] autokdump - automated kdump testsuite
Message-ID: <20140922090716.GA23854@darkstar.nay.redhat.com>
References: <145412866.25258463.1411119061796.JavaMail.zimbra@redhat.com>
 <293476264.25264480.1411120345360.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <293476264.25264480.1411120345360.JavaMail.zimbra@redhat.com>
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
To: CAI Qian <caiqian@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, kexec kdump redhat mailing list <kexec-kdump-list@redhat.com>, kexec <kexec@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, crash-utility <crash-utility@redhat.com>

Hi,

On 09/19/14 at 05:52am, CAI Qian wrote:
> I plan to release an automated kdump testsuite that will be
> focus on testing kernel and the crash utility. It should work
> for all major distros since it will use none of distro-specific
> stuff, and also support different arches including x86, ARM,
> PPC64 and s390x.

It's a good idea to create a kdump test project. Maybe you can consider to
test kexec as well.

> 
> It does the following:
> 1) check if there is a memory reserved for kdump. If not,
>    reserve the memory and reboot the system.
> 2) once the system is back, load kexec on panic and
>    prepare a separate initramfs that including needed
>    modules to load a local filesystem and necessary utilities
>    in order to analyse /proc/vmcore in the 2nd kernel.
> 3) trigger the system crash using methods like sysrq-c, NMI,
>    and panic_on_hung_task etc.
> 4) in the 2nd kernel, mount a filesystem and use the crash
>    utility to analyse /proc/vmcore. Then, gather the analyse
>    logs, serial console output, dmesg etc into the filesystem.
> 5) reboot back into the 1st kernel.
> 
> implementation:
> It will setup a daemon to handle reboots.
> 
> plan:
> I might also to test the makedumpfile all together later.

For makedumpfile, IMO you can add several test cases and collect the dump
time, vmcore size data as test results besides of the dump status.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JzhoQ-0003m3-Br
	for kexec@lists.infradead.org; Sat, 24 May 2008 00:40:42 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <4836AC3C.3090005@in.ibm.com> <m1ve144w25.fsf@frodo.ebiederm.org>
	<20080523233348.13fe0c63@kopernikus.site>
Date: Fri, 23 May 2008 17:36:26 -0700
In-Reply-To: <20080523233348.13fe0c63@kopernikus.site> (Bernhard Walle's
	message of "Fri, 23 May 2008 23:33:48 +0200")
Message-ID: <m1od6w4jxx.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: correction to compat_sys_kexec_load
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
To: Bernhard Walle <bwalle@suse.de>
Cc: akpm@osdl.org, Sharyathi Nagesh <sharyath@in.ibm.com>, sachinp@in.ibm.com, mohd.omar@in.ibm.com, Kexec Mailing List <kexec@lists.infradead.org>, fastboot@lists.osdl.org, linux-kernel@vger.kernel.org, mohan@in.ibm.com, IndhuDurai@in.ibm.com

Bernhard Walle <bwalle@suse.de> writes:

> * ebiederm@xmission.com (Eric W. Biederman) [2008-05-23 13:14]:
>>
>> What we need to do is fix /sbin/kexec to pass in the correct
>> architecture of the kernel for unload as it does for load.
>
> How should it know that it unloads a 32 bit kernel on a 64 bit system?
> It doesn't have access to the kernel any more once it has been loaded.

The architecture parameter is the architecture of the running kernel
that implements sys_kexec_load.

Because it is a pain for testing and in general impossible we don't
change cpu modes during a kexec.  So a 32bit caller of sys_kexec_load
will need to passing in different code if it is running on a 32bit or
a 64bit kernel.

The trampoline code in /sbin/kexec does change modes on x86 when
appropriate.

Caring if you know the architecture in the unload case is a bit
silly. As there is no real justification for it.  At this
point getting user space fixed so that it works on older kernels
seems important. 

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

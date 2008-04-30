Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp01.au.ibm.com ([202.81.18.162])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Jr4Dv-0005cW-S8
	for kexec@lists.infradead.org; Wed, 30 Apr 2008 04:47:20 +0000
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id m3U4m1ST029640
	for <kexec@lists.infradead.org>; Wed, 30 Apr 2008 14:48:01 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3U4pGLI219598
	for <kexec@lists.infradead.org>; Wed, 30 Apr 2008 14:51:16 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3U4lGej012085
	for <kexec@lists.infradead.org>; Wed, 30 Apr 2008 14:47:16 +1000
Message-ID: <4817F9D1.9010709@in.ibm.com>
Date: Wed, 30 Apr 2008 10:17:13 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
Subject: Re: kexec/ kdump setup problem
References: <c62583fb0804282045w757bba55v5515bdbb37d5f18c@mail.gmail.com>
	<481702DA.3000009@in.ibm.com>
	<c62583fb0804291540o25e4b865j35c4e9b87aa016ea@mail.gmail.com>
	<20080430001738.GA28606@hmsendeavour.rdu.redhat.com>
	<c62583fb0804291914o6d245e64v168dc51be7a2fd80@mail.gmail.com>
In-Reply-To: <c62583fb0804291914o6d245e64v168dc51be7a2fd80@mail.gmail.com>
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
To: Mrunal Gawade <mrunal.gawade@gmail.com>
Cc: kexec@lists.infradead.org

Mrunal Gawade wrote:
> Hi,
>
> I just checked /sys/kernel/kexec_crash_loaded file after giving the 
> kexec -p command for loading panic kernel. And the value was 1. So it 
> was loaded successfully. I then crashed kernel and it hanged. I 
> rebooted manually and checked the value in the file again and it was 
> "0". So across reboot it got reset. So if I assume that the kernel 
> loading was successful, the question remains if it got loaded 
> successfully at the designated space 65M@16M. How do I know that? 
The file /sys/kernel/kexec_crash_loaded will have value 1 if the kdump kernel has been
loaded successfully. In your case when you executed kexec -p the kernel was loaded at
the designated space and value 1 in kexec_crash_loaded reflects that. This value won't
be retained across reboots. One will have to again execute the kexec -p command to
load the kdump kernel after reboot. [ If kdump service is enabled (chkconfig kdump on)
kexec -p will get executed after every reboot. ]

I think in your case the problem is that after a successful load, the kdump kernel
does not boot on a system crash.[alt-sysrq-c]. you could try adding console
related options to the kexec command and see if that will give some information
on where the kernel hangs.

Thanks
-Sachin


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

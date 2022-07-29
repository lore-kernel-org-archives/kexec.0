Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD61C00144
	for <kexec@archiver.kernel.org>; Fri, 29 Jul 2022 10:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MAfRfwejbcoDegByIX3RvDJdI1zAafMDM9nMY4OxKKg=; b=TNVWV4gP2v8dBv
	GOdOr8YDVL695BaWNOU03BN+Qa9nfaUoPDMeeKNxhJdDa6z5RL9D+gYSEcrTBJQOvtpHWLdgSHPKo
	CPVsCDX3+GVXXzVWOFD54h2TBs1ARj81lo82hoE21aJyC84mqy3jVtkbE2jU7Ph6B5XRI2ipmklGo
	I/2jOMMDwxkdBg5ePIn1Dx+G/8h3Ibnp4ji9uE6WcFX/anZw5mYmbI6mdibUsS7au/lw7EmXh2GJv
	1upZDwZAz2k3da3Yufx84ZBoS1EPN0Q4FdwlmE+T9K3j8IWqJdTS1LX5Z/YqjqI3He2URGgAcsCls
	a64DpdSLL7JigxbKpmJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHNES-0045bX-N1; Fri, 29 Jul 2022 10:28:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHNEM-0045XK-GF
	for kexec@lists.infradead.org; Fri, 29 Jul 2022 10:28:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1659090504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=as0dSaDJ9Kz1ka/wV5ZX8Zqed6rUUwP8w5uBz6jTo54=;
	b=Cx4FItA8GTlzS2V+4B/VuSwlcaJ32WcyUZnb2BGIjaiNm3flr6y5sS0/Qu20BV7OqM/kJc
	YiDfAhx4eFMeusDEqKdbMIsRKiy/D1EUgCaRjQCX2p8xemTHVTCkk6t6yqs7DVzfWX0Sit
	TNLgsihCjE4LWGD7ycp4Pgr0YEkyPXI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-5MG5wAL0NP-Fqgmm6ptShw-1; Fri, 29 Jul 2022 06:28:23 -0400
X-MC-Unique: 5MG5wAL0NP-Fqgmm6ptShw-1
Received: by mail-pl1-f197.google.com with SMTP id p8-20020a170902e74800b0016d5e43bd99so2766743plf.16
        for <kexec@lists.infradead.org>; Fri, 29 Jul 2022 03:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=as0dSaDJ9Kz1ka/wV5ZX8Zqed6rUUwP8w5uBz6jTo54=;
        b=oCgW/OAqa97hq9BkIEQk9pQgYIcmz5ODN9jwlu402z+EF0EnvSadaIcGU0W5uIUBRE
         d1JdM8xriYgKKBhxqZq4B36Q6DimeF2EpWUuApAzEravDr6L10P0Kv6VnaQb/MWF4eqp
         qJnQPEAac2x+o0FJLYcfEZTUgWPG+pHMo1HSIQGvj5tVtjbaJsBP4Bu5anzn6uQFHWk/
         Y4uReWyDyMxLk4/xs3OPTCNC1dxoB2zG9aXnvvX1zUHzJwV1hEjW8ypk+T1ZMgV8GzmC
         84Fy0pa5L+PmV/mXy4CGll+IbyWdwLHDevv1S+OP4dgowdJCnZHXzCmIgSrPPpG10nYY
         Boiw==
X-Gm-Message-State: ACgBeo0TJqmJhnM4vdNjmdoW4Up11ou8FWgJOEPaOmWyTRc/HrvU5oEe
	OuXQeGpPJe2JyNq1eK0Rh83aBeR1PYYVPvpkMis2pJ7/zxQke+EHT6Y84+oh2kDLtZlSHP5WLl1
	oIFTjXXhDA9MZprmxEk03
X-Received: by 2002:a17:902:b948:b0:16d:93c8:403a with SMTP id h8-20020a170902b94800b0016d93c8403amr3216205pls.45.1659090501907;
        Fri, 29 Jul 2022 03:28:21 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5hAd0t3DvlQMWZfOHeSmTJlLymjssvgghLzSj+panQJWzipIbxqyehtkXAIZsMvvBYYnvbCA==
X-Received: by 2002:a17:902:b948:b0:16d:93c8:403a with SMTP id h8-20020a170902b94800b0016d93c8403amr3216163pls.45.1659090501513;
        Fri, 29 Jul 2022 03:28:21 -0700 (PDT)
Received: from localhost.localdomain ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d14-20020aa797ae000000b005289eafbd08sm2618289pfq.18.2022.07.29.03.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 03:28:20 -0700 (PDT)
Date: Fri, 29 Jul 2022 18:28:09 +0800
From: Tao Liu <ltao@redhat.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, kvm@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	virtualization@lists.linux-foundation.org,
	Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
	Jiri Slaby <jslaby@suse.cz>, David Rientjes <rientjes@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Martin Radev <martin.b.radev@gmail.com>,
	Joerg Roedel <jroedel@suse.de>, Kees Cook <keescook@chromium.org>,
	Cfir Cohen <cfir@google.com>, linux-coco@lists.linux.dev,
	Andy Lutomirski <luto@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Juergen Gross <jgross@suse.com>, Mike Stunes <mstunes@vmware.com>,
	Sean Christopherson <seanjc@google.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	Erdem Aktas <erdemaktas@google.com>
Subject: Re: [PATCH v3 00/10] x86/sev: KEXEC/KDUMP support for SEV-ES guests
Message-ID: <YuO2OUp4OmnXoqUa@localhost.localdomain>
References: <20220127101044.13803-1-joro@8bytes.org>
 <YmuqifsJltdh7rpv@localhost.localdomain>
 <46b27b72-aabf-f37d-7304-29debeefd8ae@amd.com>
MIME-Version: 1.0
In-Reply-To: <46b27b72-aabf-f37d-7304-29debeefd8ae@amd.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ltao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220729_032830_624328_969CEF30 
X-CRM114-Status: GOOD (  38.42  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Tom,

On Fri, Apr 29, 2022 at 08:08:28AM -0500, Tom Lendacky wrote:
> On 4/29/22 04:06, Tao Liu wrote:
> > On Thu, Jan 27, 2022 at 11:10:34AM +0100, Joerg Roedel wrote:
> 
> > 
> > Hi Joerg,
> > 
> > I tried the patch set with 5.17.0-rc1 kernel, and I have a few questions:
> > 
> > 1) Is it a bug or should qemu-kvm 6.2.0 be patched with specific patch? Because
> >     I found it will exit with 0 when I tried to reboot the VM with sev-es enabled.
> >     However with only sev enabled, the VM can do reboot with no problem:
> 
> Qemu was specifically patched to exit on reboot with SEV-ES guests. Qemu
> performs a reboot by resetting the vCPU state, which can't be done with an
> SEV-ES guest because the vCPU state is encrypted.
> 

Sorry for the late response, and thank you for the explanation!

> > 
> > [root@dell-per7525-03 ~]# virsh start TW-SEV-ES --console
> > ....
> > Fedora Linux 35 (Server Edition)
> > Kernel 5.17.0-rc1 on an x86_64 (ttyS0)
> > ....
> > [root@fedora ~]# reboot
> > .....
> > [   48.077682] reboot: Restarting system
> > [   48.078109] reboot: machine restart
> >                         ^^^^^^^^^^^^^^^ guest vm reached restart
> > [root@dell-per7525-03 ~]# echo $?
> > 0
> > ^^^ qemu-kvm exit with 0, no reboot back to normal VM kernel
> > [root@dell-per7525-03 ~]#
> > 
> > 2) With sev-es enabled and the 2 patch sets applied: A) [PATCH v3 00/10] x86/sev:
> > KEXEC/KDUMP support for SEV-ES guests, and B) [PATCH v6 0/7] KVM: SVM: Add initial
> > GHCB protocol version 2 support. I can enable kdump and have vmcore generated:
> > 
> > [root@fedora ~]# dmesg|grep -i sev
> > [    0.030600] SEV: Hypervisor GHCB protocol version support: min=1 max=2
> > [    0.030602] SEV: Using GHCB protocol version 2
> > [    0.296144] AMD Memory Encryption Features active: SEV SEV-ES
> > [    0.450991] SEV: AP jump table Blob successfully set up
> > [root@fedora ~]# kdumpctl status
> > kdump: Kdump is operational
> > 
> > However without the 2 patch sets, I can also enable kdump and have vmcore generated:
> > 
> > [root@fedora ~]# dmesg|grep -i sev
> > [    0.295754] AMD Memory Encryption Features active: SEV SEV-ES
> >                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ patch set A & B
> > 	       not applied, so only have this string.
> > [root@fedora ~]# echo c > /proc/sysrq-trigger
> > ...
> > [    2.759403] kdump[549]: saving vmcore-dmesg.txt to /sysroot/var/crash/127.0.0.1-2022-04-18-05:58:50/
> > [    2.804355] kdump[555]: saving vmcore-dmesg.txt complete
> > [    2.806915] kdump[557]: saving vmcore
> >                             ^^^^^^^^^^^^^ vmcore can still be generated
> > ...
> > [    7.068981] reboot: Restarting system
> > [    7.069340] reboot: machine restart
> > 
> > [root@dell-per7525-03 ~]# echo $?
> > 0
> > ^^^ same exit issue as question 1.
> > 
> > I doesn't have a complete technical background of the patch set, but isn't
> > it the issue which this patch set is trying to solve? Or I missed something?
> 
> The main goal of this patch set is to really to solve the ability to perform
> a kexec. I would expect kdump to work since kdump shuts down all but the
> executing vCPU and performs its operations before "rebooting" (which will
> exit Qemu as I mentioned above). But kexec requires the need to restart the
> APs from within the guest after they have been stopped. That requires
> specific support and actions on the part of the guest kernel in how the APs
> are stopped and restarted.

Recently I got one sev-es flaged machine borrowed and retested the patch, which
worked fine for kexec when sev-es enabled. With the patchset applied in 5.17.0-rc1, 
kexec'ed kernel can bring up all APs with no problem.

However as for kdump, I find one issue. Although kdump kernel can work well on one
cpu, but we can still enable multi-cpus by removing the "nr_cpus=1" kernel parameter
in kdump sysconfig. I was expecting kdump kernel can bring up all APs as kexec did,
however:

[    0.000000] Command line: elfcorehdr=0x5b000000 BOOT_IMAGE=(hd0,gpt2)/vmlinuz-5.17.0-rc1+ ro resume=/dev/mapper/rhel-swap biosdevname=0 net.ifnames=0 console=ttyS0 irqpoll reset_devices cgroup_disable=memory mce=off numa=off udev.children-max=2 panic=10 rootflags=nofail acpi_no_memhotplug transparent_hugepage=never nokaslr novmcoredd hest_disable disable_cpu_apicid=0 iTCO_wdt.pretimeout=0
...
[    0.376663] smp: Bringing up secondary CPUs ...
[    0.377599] x86: Booting SMP configuration:
[    0.378342] .... node  #0, CPUs:      #1
[   10.377698] smpboot: do_boot_cpu failed(-1) to wakeup CPU#1
[   10.379882]  #2
[   20.379645] smpboot: do_boot_cpu failed(-1) to wakeup CPU#2
[   20.380648] smp: Brought up 1 node, 1 CPU
[   20.381600] smpboot: Max logical packages: 4
[   20.382597] smpboot: Total of 1 processors activated (4192.00 BogoMIPS)

Turns out for kdump, the APs were not stopped properly, so I modified the following code:

--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -26,6 +26,7 @@
 #include <asm/cpu.h>
 #include <asm/nmi.h>
 #include <asm/smp.h>
+#include <asm/sev.h>
 
 #include <linux/ctype.h>
 #include <linux/mc146818rtc.h>
@@ -821,6 +822,7 @@ static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
 
        atomic_dec(&waiting_for_crash_ipi);
        /* Assume hlt works */
+       sev_es_stop_this_cpu();
        halt();
        for (;;)
                cpu_relax();

[    0.000000] Command line: elfcorehdr=0x5b000000 BOOT_IMAGE=(hd0,gpt2)/vmlinuz-5.17.0-rc1-hack+ ro resume=/dev/mapper/rhel-swap biosdevname=0 net.ifnames=0 console=ttyS0 irqpoll reset_devices cgroup_disable=memory mce=off numa=off udev.children-max=2 panic=10 rootflags=nofail acpi_no_memhotplug transparent_hugepage=never nokaslr novmcoredd hest_disable disable_cpu_apicid=0 iTCO_wdt.pretimeout=0
...
[    0.402618] smp: Bringing up secondary CPUs ...
[    0.403308] x86: Booting SMP configuration:
[    0.404171] .... node  #0, CPUs:      #1 #2 #3
[    0.407362] smp: Brought up 1 node, 4 CPUs
[    0.408907] smpboot: Max logical packages: 4
[    0.409172] smpboot: Total of 4 processors activated (16768.01 BogoMIPS)

Now all APs can work in kdump kernel.

Thanks,
Tao Liu

> 
> Thanks,
> Tom
> 
> > 
> > Thanks,
> > Tao Liu
> > > _______________________________________________
> > > Virtualization mailing list
> > > Virtualization@lists.linux-foundation.org
> > > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> > 
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

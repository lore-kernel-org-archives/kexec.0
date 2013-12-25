Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vveqy-0008P7-1X
 for kexec@lists.infradead.org; Wed, 25 Dec 2013 03:09:49 +0000
Date: Wed, 25 Dec 2013 11:09:01 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v7 00/12] kexec kernel efi runtime support
Message-ID: <20131225030901.GA6333@dhcp-16-126.nay.redhat.com>
References: <1387533742-18018-1-git-send-email-dyoung@redhat.com>
 <20131221173515.GE29501@console-pimps.org>
 <1387747621.1848.2.camel@misato.fc.hp.com>
 <20131223073641.GA28919@console-pimps.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131223073641.GA28919@console-pimps.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Matt Fleming <matt@console-pimps.org>
Cc: "mjg59@srcf.ucam.org" <mjg59@srcf.ucam.org>, "msalter@redhat.com" <msalter@redhat.com>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Toshi Kani <toshi.kani@hp.com>, "greg@kroah.com" <greg@kroah.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "leif.lindholm@linaro.org" <leif.lindholm@linaro.org>, "James.Bottomley@HansenPartnership.com" <James.Bottomley@HansenPartnership.com>, "horms@verge.net.au" <horms@verge.net.au>, "bp@alien8.de" <bp@alien8.de>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "hpa@zytor.com" <hpa@zytor.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mingo@kernel.org" <mingo@kernel.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On 12/23/13 at 07:36am, Matt Fleming wrote:
> On Sun, 22 Dec, at 02:27:01PM, Toshi Kani wrote:
> > 
> > The kexec branch is missing the following change, which is required for
> > fast reboot with multi-cpus.
> > 
> >    commit 279f1df915c3a6ed3075d98a849705bf53851f99
> >    Author: Vivek Goyal <vgoyal@redhat.com>
> >    Date:   Tue Nov 26 10:25:28 2013 +0800
> > 
> >        kexec: migrate to reboot cpu
> > 
> > With this change added, I confirmed that the branch kernel works fine.
>  
> I can't find that commit in Linus' tree. Where is it from?

Previously it was in Andrew's mm tree, currently it's below commit in linus tree:

commit c97102ba96324da330078ad8619ba4dfe840dbe3
Author: Vivek Goyal <vgoyal@redhat.com>
Date:   Wed Dec 18 17:08:31 2013 -0800

    kexec: migrate to reboot cpu
    
    Commit 1b3a5d02ee07 ("reboot: move arch/x86 reboot= handling to generic
    kernel") moved reboot= handling to generic code.  In the process it also
    removed the code in native_machine_shutdown() which are moving reboot
    process to reboot_cpu/cpu0.
    
    I guess that thought must have been that all reboot paths are calling
    migrate_to_reboot_cpu(), so we don't need this special handling.  But
    kexec reboot path (kernel_kexec()) is not calling
    migrate_to_reboot_cpu() so above change broke kexec.  Now reboot can
    happen on non-boot cpu and when INIT is sent in second kerneo to bring
    up BP, it brings down the machine.
    
    So start calling migrate_to_reboot_cpu() in kexec reboot path to avoid
    this problem.
    
    Bisected by WANG Chao.
    
    Reported-by: Matthew Whitehead <mwhitehe@redhat.com>
    Reported-by: Dave Young <dyoung@redhat.com>
    Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
    Tested-by: Baoquan He <bhe@redhat.com>
    Tested-by: WANG Chao <chaowang@redhat.com>
    Acked-by: H. Peter Anvin <hpa@linux.intel.com>
    Cc: <stable@vger.kernel.org>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guKRi-0001nR-F5
 for kexec@lists.infradead.org; Thu, 14 Feb 2019 17:05:12 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH] makedumpfile/arm64: Add support for ARMv8.2-LPA (52-bit
 PA support)
Date: Thu, 14 Feb 2019 17:03:27 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC035685CE@BPXM09GP.gisp.nec.co.jp>
References: <1549484034-17027-1-git-send-email-bhsharma@redhat.com>
 <CACi5LpNYCY0_0zOCd=7fQ=cLZdinM8Z9xPtmKr5WMmvJruE-6A@mail.gmail.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03567FF6@BPXM09GP.gisp.nec.co.jp>
 <887cb122-0c2e-5fdd-ea54-ecf8adf3cd79@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035682A9@BPXM09GP.gisp.nec.co.jp>
 <0b95bba3-11ab-0bb7-df0a-67ddc0150548@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03568377@BPXM09GP.gisp.nec.co.jp>
 <4a1c4de9-004f-98b2-ca51-b6d60928ddbc@redhat.com>
In-Reply-To: <4a1c4de9-004f-98b2-ca51-b6d60928ddbc@redhat.com>
Content-Language: en-US
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: kexec mailing list <kexec@lists.infradead.org>

Hi Bhupesh,

-----Original Message-----
> >> Yes, the ARMv8 simulator can support both ARMv8.2 LPA and LVA features
> >> and I tested the above suggestion earlier also on the same and landed
> >> into incorrect paddress calculation issues.
> >>
> >> Since the simulator is slow and its time taking to insert rebuilt
> >> user-space components in the Linaro initramfs being used on the same, I
> >> would suggest that we go ahead with the above code for now and later
> >> when I have more results from the simulator/real hardware, I will send
> >> out a follow-up patch (if needed) to fix the paddress calculation.
> >
> > Hmm, it theoretically needs __pte_to_phys(), right?
> > So if you have an issue with it, there may be a bug somewhere
> > and need to debug it. Do you have the detailed information?
> 
> Its not very easy to get the detailed UART console logs from the
> simulator, so it is hard to get all the debug logs from makedumpfile, so
> I am trying debugging the issue via 'gdb' by adding it to the initramfs.

I don't know what environment the simulater is, but you cannot
capture a vmcore with cp or something? then debug makedumpfile
with it on a real arm64 machine. I usually do like this.

  # cp --sparse=always /proc/vmcore vmcore

I'm willing to debug it if you would send me the vmcore and vmlinux.

> 
> However till then to fix the regression reported with upstream
> makedumpfile on arm64 platforms which don't support ARMv8.2-LPA
> extensions (e.g. Cortex-A57) and run a newer kernel with PA=52-bit
> configuration, we can apply this patch for now.
> 
> I have tested this on non-ARMv8.2-LPA platforms like apm-osprey and
> huwaei-taishan and the makedumpfile can work fine.
> 
> I will come back with a follow-up patch (if needed) after some checks on
> the ARMv8 Simulator for the __pte_to_phys() part.
> 
> Thanks,
> Bhupesh
> 
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

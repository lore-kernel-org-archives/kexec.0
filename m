Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iT71M-0003fN-6D
 for kexec@lists.infradead.org; Fri, 08 Nov 2019 16:22:01 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: makedumpfile: ELF format issues
Date: Fri, 8 Nov 2019 16:19:11 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03594B01@BPXM09GP.gisp.nec.co.jp>
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
To: Dave Anderson <anderson@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi Dave,

> -----Original Message-----
> > > It is possible that the issue occurs on general systems if they have
> > > large memory, so I'm going to proceed with those patches.
> >
> > Hi Kazu,
> >
> > Do you want me to go ahead with the crash utility patch?  It looks
> > safe enough to apply, and I did test it to make sure there were no
> > ill-effects with sample ELF dumpfiles.
> 
> Oh, thank you for your attention and testing.
> 
> I'm dropping the ELF32 parts of them, because I think they will not be
> used in the future.  (I estimate the theoretical minimum memory size
> that makedumpfile could use the extended numbering is 64GB+256MB on
> 4k page system.)

I dropped the ELF32 part from the crash patch, could you check this?
https://github.com/k-hagio/crash/tree/support-extended-elf.v2

This is for makedumpfile:
https://github.com/k-hagio/makedumpfile/tree/support-extended-elf.v2

I will post the updated makedumpfile patch later for public review,
and would like to apply it next week.

Thanks,
Kazu



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

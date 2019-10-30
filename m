Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPrMT-0000en-Cc
 for kexec@lists.infradead.org; Wed, 30 Oct 2019 17:02:23 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: Makedumpfile help for 5.4.0.rc3 : Arm
Date: Wed, 30 Oct 2019 17:01:20 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC0359418B@BPXM09GP.gisp.nec.co.jp>
References: <1C379272-3B10-432C-8A83-8F3008CEE87F@oracle.com>
 <CACi5LpM9eN7XuFRi-BapvGNSfu8GgDPTi0BRG9WT4E_nJkzwfw@mail.gmail.com>
 <B641BD39-6FA8-4382-AA04-D83CDCF5D278@oracle.com>
 <CACi5LpPRFi4BoyDp4dBDROJ48r6oZnenTJ_CE=MMefYnVnZ0ZA@mail.gmail.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03593E47@BPXM09GP.gisp.nec.co.jp>
 <CACi5LpOexc5ss6DRHOSWJeSAwwGPQ55z1XiFqenGzY1rLkzeqA@mail.gmail.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03594125@BPXM09GP.gisp.nec.co.jp>
 <d913b734-3896-9211-acc3-8be21f15ed1f@Oracle.com>
In-Reply-To: <d913b734-3896-9211-acc3-8be21f15ed1f@Oracle.com>
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
To: John Donnelly <John.P.Donnelly@Oracle.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>, kexec mailing list <kexec@lists.infradead.org>


> -----Original Message----- 
>     If there are corresponding kernel patches being considered to make
> makedumpfile work  on v8 and v8.x  systems I would be interesting in
> testing those also.
> 
> 
> makedumpfile should be able to work with a variety of VAbits as 48, or
> 52 settings.

Yes, Bhupesh will post his patches to do so.

The v3 patchset that was mentioned earlier is this:
https://lore.kernel.org/linux-arm-kernel/1553058574-18606-1-git-send-email-bhsharma@redhat.com/

We have to export things that we need and arm maintainers can export
to vmcoreinfo.

Thanks,
Kazu

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

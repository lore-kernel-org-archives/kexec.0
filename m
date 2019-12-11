Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1if631-00035C-36
 for kexec@lists.infradead.org; Wed, 11 Dec 2019 17:45:16 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH] makedumpfile: assign bitmap2 fd for sub process during
 refiltering
Date: Wed, 11 Dec 2019 17:44:09 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03597DC4@BPXM09GP.gisp.nec.co.jp>
References: <1575358627-17152-1-git-send-email-piliu@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035977E6@BPXM09GP.gisp.nec.co.jp>
 <0d793e2d-6698-6543-13de-a3de8732df75@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03597A16@BPXM09GP.gisp.nec.co.jp>
 <22c89e8b-49ab-0cd2-2e63-9e380ad4ba8a@redhat.com>
In-Reply-To: <22c89e8b-49ab-0cd2-2e63-9e380ad4ba8a@redhat.com>
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
To: piliu <piliu@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi Pingfan,

> -----Original Message-----
> > Reading the code, I think
> > - the issue might occur not only in refiltering, but also the first filtering
> >   with --split and --work-dir option (forced non-cyclic mode).
> > - pefer to gather things for --split option into writeout_multiple_dumpfiles()
> >   if we can, for readability.
> Yes, all of the cases suffer from sharing fd across processes
> >
> > So does the following patch work for you and your test?
> > I could not have reproduced the issue yet.
> I tried to fetch a machine to test. It pass 50 times test with your
> patch. While if without this patch, it failed about 1 out of 4 times.

Good. Thank you for testing.

> > BTW, what do you see when the issue occurs? an error or broken dump?
> The test case is refiltering, "makedumpfile --split  -d 31
> /root/vmcore-p9b-21 dumpfile_{1,2,3} 2>&1"
> And it can not complete the dump.

Ah, I got it. I probably could reproduce the issue:
---
Excluding unnecessary pages                       : [100.0 %] \
readpage_kdump_compressed: pfn(2fc1000) is excluded from vmcore.
readmem: type_addr: 1, addr:2fc1000000, size:4096
read_pfn: Can't get the page data.
...
writeout_multiple_dumpfiles: Child process(30993) finished incompletely.(256)

makedumpfile Failed.
---

Refiltering was the factor that makedumpfile failed, but I think this bug
also can break the dumpfile silently by excluding pages wrongly even in
first filtering.

I guess this bug was hard to debug. Thank you so much for working on this!
Modified your patch and pushed.
https://sourceforge.net/p/makedumpfile/code/ci/5519b3eba68544dc484d85e9540d440d93f8c924/

Thanks,
Kazu




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

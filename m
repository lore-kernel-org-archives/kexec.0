Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h3Nzr-0003zA-Sv
 for kexec@lists.infradead.org; Mon, 11 Mar 2019 16:41:53 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH v2] makedumpfile: exclude pages that are logically offline
Date: Mon, 11 Mar 2019 16:40:30 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03569C9C@BPXM09GP.gisp.nec.co.jp>
References: <20181122100627.5189-1-david@redhat.com>
 <20181122100938.5567-1-david@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03561800@BPXM09GP.gisp.nec.co.jp>
 <7c9d6d5c-d6cf-00a7-7f23-bf28cbb382af@redhat.com>
In-Reply-To: <7c9d6d5c-d6cf-00a7-7f23-bf28cbb382af@redhat.com>
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
To: David Hildenbrand <david@redhat.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "pv-drivers@vmware.com" <pv-drivers@vmware.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, kexec-ml <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>

-----Original Message-----
> On 27.11.18 17:32, Kazuhito Hagio wrote:
> >> Linux marks pages that are logically offline via a page flag (map count).
> >> Such pages e.g. include pages infated as part of a balloon driver or
> >> pages that were not actually onlined when onlining the whole section.
> >>
> >> While the hypervisor usually allows to read such inflated memory, we
> >> basically read and dump data that is completely irrelevant. Also, this
> >> might result in quite some overhead in the hypervisor. In addition,
> >> we saw some problems under Hyper-V, whereby we can crash the kernel by
> >> dumping, when reading memory of a partially onlined memory segment
> >> (for memory added by the Hyper-V balloon driver).
> >>
> >> Therefore, don't read and dump pages that are marked as being logically
> >> offline.
> >>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >
> > Thanks for the v2 update.
> > I'm going to merge this patch after the kernel patches are merged
> > and it tests fine with the kernel.
> >
> > Kazu
> 
> Hi Kazu,
> 
> the patches are now upstream. Thanks!

Tested OK at my end, too. Applied to the devel branch.

    Offline pages           : 0x0000000000002400

Thank you!
Kazu

> 
> --
> 
> Thanks,
> 
> David / dhildenb

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

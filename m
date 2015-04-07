Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YfKXF-0000AL-3B
 for kexec@lists.infradead.org; Tue, 07 Apr 2015 03:50:45 +0000
Date: Tue, 7 Apr 2015 11:49:57 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v9 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
Message-ID: <20150407034957.GC7213@localhost.localdomain>
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
 <20150403084031.GF22579@dhcp-128-53.nay.redhat.com>
 <551E56F6.60503@hp.com>
 <20150403092111.GG22579@dhcp-128-53.nay.redhat.com>
 <534F7596-2172-4BE1-B374-4D18D2DA5110@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <534F7596-2172-4BE1-B374-4D18D2DA5110@hp.com>
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
To: "Li, Zhen-Hua" <zhen-hual@hp.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "indou.takao@jp.fujitsu.com" <indou.takao@jp.fujitsu.com>, "bhe@redhat.com" <bhe@redhat.com>, "Vaden,
 Tom (HP Server OS Architecture)" <tom.vaden@hp.com>, "Wright,
 Randy (HP Servers Linux)" <rwright@hp.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "joro@8bytes.org" <joro@8bytes.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mitchell,
 Lisa (MCLinux in Fort Collins)" <lisa.mitchell@hp.com>, "Hoemann,
 Jerry" <jerry.hoemann@hp.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "ddutile@redhat.com" <ddutile@redhat.com>, "Hatch,
 Douglas B (HPS Linux PM)" <doug.hatch@hp.com>, "ishii.hironobu@jp.fujitsu.com" <ishii.hironobu@jp.fujitsu.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "billsumnerlinux@gmail.com" <billsumnerlinux@gmail.com>, "Zhang,
 Li (Zoe@HPservers-Core-OE-PSC)" <li.zhang6@hp.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On 04/03/15 at 02:05pm, Li, Zhen-Hua wrote:
> The hardware will do some verification, but not completely.  If people think the OS should also do this, then it should be another patchset, I think.

If there is chance to corrupt more memory I think it is not a right way.
We should think about a better solution instead of fix it later.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

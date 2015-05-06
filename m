Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t3427.houston.hp.com ([15.201.208.55])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YppE6-0002o5-NC
 for kexec@lists.infradead.org; Wed, 06 May 2015 02:38:23 +0000
Message-ID: <55497E4D.6020202@hp.com>
Date: Wed, 06 May 2015 10:37:01 +0800
From: "Li, ZhenHua" <zhen-hual@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH v10 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
References: <20150415005731.GC19051@localhost.localdomain>
 <552DFB56.1070600@hp.com> <20150415064803.GF19051@localhost.localdomain>
 <20150424080147.GC4458@dhcp-16-116.nay.redhat.com>
 <20150424082528.GA23912@dhcp-128-91.nay.redhat.com>
 <20150424083530.GD4458@dhcp-16-116.nay.redhat.com>
 <20150424084957.GC23912@dhcp-128-91.nay.redhat.com>
 <20150504162318.GH15736@8bytes.org>
 <20150505061423.GC31063@dhcp-128-4.nay.redhat.com>
 <20150505153157.GQ15736@8bytes.org>
 <20150506015135.GB14065@dhcp-128-4.nay.redhat.com>
In-Reply-To: <20150506015135.GB14065@dhcp-128-4.nay.redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: alex.williamson@redhat.com, indou.takao@jp.fujitsu.com, Baoquan He <bhe@redhat.com>, tom.vaden@hp.com, rwright@hp.com, linux-pci@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, iommu@lists.linux-foundation.org, "Li,
 ZhenHua" <zhen-hual@hp.com>, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com, dwmw2@infradead.org, vgoyal@redhat.com

Dave,
This patchset will only write root tables in old kernel,  if it is 
corrupted, faults will also happen in old kernel, and hardware would 
mark it. So things will not go worse..

Thanks
Zhenhua
On 05/06/2015 09:51 AM, Dave Young wrote:
> On 05/05/15 at 05:31pm, Joerg Roedel wrote:
>> On Tue, May 05, 2015 at 02:14:23PM +0800, Dave Young wrote:
>>> The failure is nothing different, but as I said in another reply the
>>> difference is we could use corrupted data to possiblly cause more failure.
>>
>> I still fail to see how things can get more worse than they already are
>> by reusing the old data (we just reuse it, we do not modify anything
>
> DMA write will modify system ram, if the old data is corrupted  it is possible
> that DMA operation modify wrong ram regions because of wrong mapping.
> Am I missing something and is it not possible?
>
> Thanks
> Dave
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WXb0D-0006LT-TM
 for kexec@lists.infradead.org; Tue, 08 Apr 2014 18:44:10 +0000
Message-ID: <53444330.2030606@redhat.com>
Date: Tue, 08 Apr 2014 14:42:56 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCHv3 0/6] Crashdump Accepting Active IOMMU
References: <1389391652-52422-1-git-send-email-bill.sumner@hp.com>
 <53430DE9.9080303@redhat.com> <1396973686.25235.36.camel@i7.infradead.org>
In-Reply-To: <1396973686.25235.36.camel@i7.infradead.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: indou.takao@jp.fujitsu.com, bhe@redhat.com, linux-pci@vger.kernel.org, joro@8bytes.org, kexec@lists.infradead.org, alex.williamson@redhat.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, zhenhua@hp.com, Bill Sumner <bill.sumner@hp.com>

On 04/08/2014 12:14 PM, David Woodhouse wrote:
> On Mon, 2014-04-07 at 16:43 -0400, Don Dutile wrote:
>>
>> Additionally, a tidbit of information like "some servers force NMI's
>> on DMAR faults,
>> and cause a system reset, thereby, preventing a kdump to occur"
>> should have been included as one reason to stop DMAR faults from
>> occurring on kexec-boot,
>> in addition to the fact that a flood of them can lock up a system.
>
> How about allocating a physical scratch page, and setting up a mapping
> for each device such that *every* virtual address (apart from those
> listed in RMRRs, perhaps) is mapped to that same scratch page?
>
> That way you avoid the faults, but you also avoid stray DMA to parts of
> the system that you don't want to get corrupted.
>
+1... more isolation as second kernel booting sounds good.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from 8bytes.org ([2a01:238:4242:f000:64f:6c43:3523:e535]
 helo=mail.8bytes.org)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WKqva-0007DV-LM
 for kexec@lists.infradead.org; Tue, 04 Mar 2014 15:06:43 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.8bytes.org (Postfix) with SMTP id 7C64912B223
 for <kexec@lists.infradead.org>; Tue,  4 Mar 2014 16:06:21 +0100 (CET)
Date: Tue, 4 Mar 2014 16:06:17 +0100
From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCHv3 0/6] Crashdump Accepting Active IOMMU
Message-ID: <20140304150611.GE2799@8bytes.org>
References: <1389391652-52422-1-git-send-email-bill.sumner@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1389391652-52422-1-git-send-email-bill.sumner@hp.com>
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
To: Bill Sumner <bill.sumner@hp.com>
Cc: indou.takao@jp.fujitsu.com, bhe@redhat.com, linux-pci@vger.kernel.org, kexec@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, zhenhua@hp.com, dwmw2@infradead.org

Hi Bill,

On Fri, Jan 10, 2014 at 03:07:26PM -0700, Bill Sumner wrote:
> Bill Sumner (6):
>   Crashdump-Accepting-Active-IOMMU-Flags-and-Prototype
>   Crashdump-Accepting-Active-IOMMU-Utility-functions
>   Crashdump-Accepting-Active-IOMMU-Domain-Interfaces
>   Crashdump-Accepting-Active-IOMMU-Copy-Translations
>   Crashdump-Accepting-Active-IOMMU-Debug-Print-IOMMU
>   Crashdump-Accepting-Active-IOMMU-Call-From-Mainline
> 
>  drivers/iommu/intel-iommu.c | 1293 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 1225 insertions(+), 68 deletions(-)

This is a pretty big change, before merging I would like to get more
eyes on it. Please make sure you get more reviews on the code and the
general concept. A few things I noticed while looking at it:

* You put a lot of code into #define CONFIG_CRASH_DUMP. Isn't the same
  approach necessary to for KEXEC?

* Please get rid of all the pr_debug stuff.

* I think it makes sense to put the functions to access the IOMMU
  configuration values of the old kernel into a new file. This is better
  than adding over 1000 new lines to intel-iommu.c

* I have seen your new single-patch for this change. A single patch with
  more than 1200 changed lines is not something anyone is willing to
  review. Please split the patches again in a meaningful and bisectable
  way.


Thanks,

	Joerg



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

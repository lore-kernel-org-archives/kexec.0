Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g4t3425.houston.hp.com ([15.201.208.53])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WN5cN-0000by-DM
 for kexec@lists.infradead.org; Mon, 10 Mar 2014 19:12:08 +0000
From: "Sumner, William" <bill.sumner@hp.com>
Subject: RE: [PATCHv3 0/6] Crashdump Accepting Active IOMMU
Date: Mon, 10 Mar 2014 19:10:17 +0000
Message-ID: <875D89B79D1D86448A583A7302C022A066E08AFE@G4W3212.americas.hpqcorp.net>
References: <1389391652-52422-1-git-send-email-bill.sumner@hp.com>
 <20140304150611.GE2799@8bytes.org>
In-Reply-To: <20140304150611.GE2799@8bytes.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "indou.takao@jp.fujitsu.com" <indou.takao@jp.fujitsu.com>, "bhe@redhat.com" <bhe@redhat.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Li,
 Zhen-Hua" <zhen-hual@hp.com>, "ddutile@redhat.com" <ddutile@redhat.com>, "Hatch, Douglas B (HPS Linux PM)" <doug.hatch@hp.com>, "ishii.hironobu@jp.fujitsu.com" <ishii.hironobu@jp.fujitsu.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>

Hi Joerg,

On Tue 3/4/2014 9:06 AM, Joerg Roedel wrote:
>
>On Fri, Jan 10, 2014 at 03:07:26PM -0700, Bill Sumner wrote:
>> Bill Sumner (6):
>>   Crashdump-Accepting-Active-IOMMU-Flags-and-Prototype
>>   Crashdump-Accepting-Active-IOMMU-Utility-functions
>>   Crashdump-Accepting-Active-IOMMU-Domain-Interfaces
>>   Crashdump-Accepting-Active-IOMMU-Copy-Translations
>>   Crashdump-Accepting-Active-IOMMU-Debug-Print-IOMMU
>>   Crashdump-Accepting-Active-IOMMU-Call-From-Mainline
>>
>>  drivers/iommu/intel-iommu.c | 1293
>> ++++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 1225 insertions(+), 68 deletions(-)
>
>This is a pretty big change, before merging I would like to get more eyes on it. Please make sure you get more reviews on the code and the general concept. A few things I noticed while looking at it:
Yes, as I was developing this, I realized that it is far more code than most Linux submissions.  In addition to more eyes reviewing the code, I hope to see additional members of the community trying it out -- testing it on a wide variety of system configurations.  Let me encourage additional reviewers and testers to look at this fix to crashdump.
>
>* You put a lot of code into #define CONFIG_CRASH_DUMP. Isn't the same approach necessary to for KEXEC?
Until I saw your email, I had been focused only on the immediate problem of fixing crashdump and had not considered using this approach in the more-general context of KEXEC.  It certainly looks like it could be useful with KEXEC as well.  

I would like to take-on the effort of expanding this technique into KEXEC as a separate follow-on project so that the original "fix crashdump" project is not delayed.  On a quick look, I believe that the amount of additional code would be minimal; but the expansion of the testing matrix might be quite large.
>
>* Please get rid of all the pr_debug stuff.
Will do.
>
>* I think it makes sense to put the functions to access the IOMMU
>  configuration values of the old kernel into a new file. This is better
>  than adding over 1000 new lines to intel-iommu.c
Sounds good.  I will move these functions into a new file.
>
>* I have seen your new single-patch for this change. A single patch with
>  more than 1200 changed lines is not something anyone is willing to
>  review. Please split the patches again in a meaningful and bisectable
>  way.
I will return to a multiple-patch set for future submissions.


-- Bill

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

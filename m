Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TMXrs-00028h-9x
 for kexec@lists.infradead.org; Fri, 12 Oct 2012 05:33:05 +0000
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 12 Oct 2012 15:31:06 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q9C5WiDt31260850
 for <kexec@lists.infradead.org>; Fri, 12 Oct 2012 16:32:44 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q9C5WhHE024001
 for <kexec@lists.infradead.org>; Fri, 12 Oct 2012 16:32:44 +1100
Message-ID: <5077AAAD.9060400@linux.vnet.ibm.com>
Date: Fri, 12 Oct 2012 10:59:17 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/7] makedumpfile security key filtering with eppic
References: <20120606095709.12534.63967.stgit@aravinda>
 <20120611174432.114cdead.kumagai-atsushi@mxc.nes.nec.co.jp>
 <502C9273.30504@linux.vnet.ibm.com>
 <20120817131637.804c9194d21e7e44133f63f9@mxc.nes.nec.co.jp>
In-Reply-To: <20120817131637.804c9194d21e7e44133f63f9@mxc.nes.nec.co.jp>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: aravinda@linux.vnet.ibm.com, tachibana@mxm.nes.nec.co.jp, kexec@lists.infradead.org, ananth@in.ibm.com, buendgen@de.ibm.com

On 08/17/2012 09:46 AM, Atsushi Kumagai wrote:
> Hello Aravinda,
> 
> On Thu, 16 Aug 2012 11:55:55 +0530
> Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:
> 
>> Hello Kumagai-san,
>>
>> Did you get a chance to review the makedumpfile security key enhancement
>> patches?
>>
>> - Aravinda
> 
> Sorry for not responding.
> 
> I'm afraid that I can't start to review them yet.
> I've been working on the cyclic mode feature for a few months,
> and I'm now preparing the next release including the feature.
> 
> I'll release the next version soon, I'll review your patches after that.
> 

Hi Atsushi,

Did you get chance to review these patches?

Thanks,
-Mahesh.

>>
>>>
>>>
>>> Thanks
>>> Atsushi Kumagai
>>>
>>>> TODO:
>>>>
>>>>   - Currently, works only for symbols in vmlinux, extend it to module
>>>>     symbols
>>>>   - Functionality support:
>>>>     - Implement the following callback functions.
>>>>       - apialignment
>>>>       - apigetenum
>>>>       - apigetdefs
>>>>     - Other functionalities specified in the code with TODO tag
>>>>   - Support specifying eppic macros in makedumpfile.conf file
>>>>   - Update erase info
>>>>
>>>> ---
>>>>
>>>> Aravinda Prasad (7):
>>>>       Initialize and setup eppic
>>>>       makedumpfile and eppic interface layer
>>>>       Eppic call back functions to query a dump image
>>>>       Implement apigetctype call back function
>>>>       Implement apimember and apigetrtype call back functions
>>>>       Extend eppic built-in functions to include memset function
>>>>       Support fully typed symbol access mode
>>>>
>>>>
>>>>  Makefile          |    6 -
>>>>  dwarf_info.c      |  338 ++++++++++++++++++++++++++++++++++++++++
>>>>  dwarf_info.h      |   18 ++
>>>>  erase_info.c      |   72 ++++++++-
>>>>  erase_info.h      |    3 
>>>>  extension_eppic.c |  446 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  extension_eppic.h |   78 +++++++++
>>>>  makedumpfile.c    |    7 +
>>>>  makedumpfile.h    |    6 +
>>>>  9 files changed, 967 insertions(+), 7 deletions(-)
>>>>  create mode 100644 extension_eppic.c
>>>>  create mode 100644 extension_eppic.h
>>>>
>>>> -- 
>>>> Aravinda Prasad
>>>
>>
>>
>> -- 
>> Regards,
>> Aravinda
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

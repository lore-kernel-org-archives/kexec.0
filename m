Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dIsWz-0001Q9-QI
 for kexec@lists.infradead.org; Thu, 08 Jun 2017 08:11:03 +0000
Received: by mail-pf0-f174.google.com with SMTP id l89so14580614pfi.2
 for <kexec@lists.infradead.org>; Thu, 08 Jun 2017 01:10:41 -0700 (PDT)
Subject: Re: [Makedumpfile PATCH v4 1/2] makedumpfile: add runtime kaslr
 offset if it exists
References: <cover.1495767738.git.panand@redhat.com>
 <302c16ede3723264ca0abb5eef9c9f553ffcfbd7.1495767738.git.panand@redhat.com>
 <f603a814-d112-fa67-ac89-0b9173b4ed7c@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EDF05E@BPXM01GP.gisp.nec.co.jp>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <ea6e024e-c5ce-739a-7b4b-aa2e0af7fbc2@redhat.com>
Date: Thu, 8 Jun 2017 13:40:36 +0530
MIME-Version: 1.0
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701EDF05E@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "dyoung@redhat.com" <dyoung@redhat.com>, "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "xlpang@redhat.com" <xlpang@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "bhe@redhat.com" <bhe@redhat.com>



On Thursday 08 June 2017 01:29 PM, Atsushi Kumagai wrote:
>> Hi Atsushi,
>>
>> On Friday 26 May 2017 08:36 AM, Pratyush Anand wrote:
>>> +#define get_kaslr_offset(X)	FALSE
>>>  #define get_xen_basic_info_arch(X) get_xen_basic_info_arm64(X)
>>>  #define get_xen_info_arch(X) get_xen_info_arm64(X)
>>>  #define is_phys_addr(X)		stub_true_ul(X)
>>> @@ -851,6 +857,7 @@ unsigned long long vaddr_to_paddr_arm(unsigned long vaddr);
>>>  #define get_phys_base()		get_phys_base_arm()
>>>  #define get_machdep_info()	get_machdep_info_arm()
>>>  #define get_versiondep_info()	stub_true()
>>> +#define get_kaslr_offset(X)	FALSE
>>
>>
>> It seems that using stub_false() would be better than FALSE.
>>
>> I see, its not yet in upstream/devel branch.
>> So, Either you can edit them before applying or may be I can send v5.
>>
>> Please let me know.
>
> I'll fix it and push it to the devel branch.

Thanks :-)

> Thanks for your pointing out.


~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

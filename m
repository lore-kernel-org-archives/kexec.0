Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dIsPg-0005It-KH
 for kexec@lists.infradead.org; Thu, 08 Jun 2017 08:03:30 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [Makedumpfile PATCH v4 1/2] makedumpfile: add runtime kaslr
 offset if it exists
Date: Thu, 8 Jun 2017 07:59:21 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701EDF05E@BPXM01GP.gisp.nec.co.jp>
References: <cover.1495767738.git.panand@redhat.com>
 <302c16ede3723264ca0abb5eef9c9f553ffcfbd7.1495767738.git.panand@redhat.com>
 <f603a814-d112-fa67-ac89-0b9173b4ed7c@redhat.com>
In-Reply-To: <f603a814-d112-fa67-ac89-0b9173b4ed7c@redhat.com>
Content-Language: ja-JP
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
To: Pratyush Anand <panand@redhat.com>
Cc: "xlpang@redhat.com" <xlpang@redhat.com>, "dyoung@redhat.com" <dyoung@redhat.com>, "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "bhe@redhat.com" <bhe@redhat.com>

>Hi Atsushi,
>
>On Friday 26 May 2017 08:36 AM, Pratyush Anand wrote:
>> +#define get_kaslr_offset(X)	FALSE
>>  #define get_xen_basic_info_arch(X) get_xen_basic_info_arm64(X)
>>  #define get_xen_info_arch(X) get_xen_info_arm64(X)
>>  #define is_phys_addr(X)		stub_true_ul(X)
>> @@ -851,6 +857,7 @@ unsigned long long vaddr_to_paddr_arm(unsigned long vaddr);
>>  #define get_phys_base()		get_phys_base_arm()
>>  #define get_machdep_info()	get_machdep_info_arm()
>>  #define get_versiondep_info()	stub_true()
>> +#define get_kaslr_offset(X)	FALSE
>
>
>It seems that using stub_false() would be better than FALSE.
>
>I see, its not yet in upstream/devel branch.
>So, Either you can edit them before applying or may be I can send v5.
>
>Please let me know.

I'll fix it and push it to the devel branch.
Thanks for your pointing out.

Regards,
Atsushi Kumagai


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

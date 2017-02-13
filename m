Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cdB9o-0004uH-2S
 for kexec@lists.infradead.org; Mon, 13 Feb 2017 07:34:49 +0000
Received: by mail-qk0-f169.google.com with SMTP id 11so86041630qkl.3
 for <kexec@lists.infradead.org>; Sun, 12 Feb 2017 23:34:23 -0800 (PST)
Subject: Re: [Makedumpfile Patch 0/6] Fix --mem-usage /proc/kcore
References: <cover.1486381805.git.panand@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EA4B89@BPXM01GP.gisp.nec.co.jp>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <db956357-414f-0efc-10b8-7864b88f5e00@redhat.com>
Date: Mon, 13 Feb 2017 13:04:16 +0530
MIME-Version: 1.0
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701EA4B89@BPXM01GP.gisp.nec.co.jp>
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "dyoung@redhat.com" <dyoung@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>



On Monday 13 February 2017 11:56 AM, Atsushi Kumagai wrote:
> Hello Pratyush,
>
>> `makedumpfile --mem-usage /proc/kcore` has been broken after kaslr specific
>> modifications. I have proposed a kernel patch [0] which has been ACKed by
>> Andrew Morton and is available in next-2017020 now. Hopefully, it should be
>> part of upstream in v4.10 release. This kernel patch helps to fix this
>> issue for both the case of kaslr enabled and disabled.
>>
>> To seek other's feedback, I am sending makedumpfile patches before kernel
>> patch hits upstream.
>
> Thanks for taking care of this feature.
> I understand that the problem is:
>
>  - phys_base is necessary for VtoP, but:
>    - SYMBOL(phys_base) is unavailable since /proc/kcore doesn't export VMCOREINFO.
>    - get_phys_base() doesn't work well since current PT_LOAD doesn't have valid p_paddr.

Yes, this is what the problem is.

>
> The new makedumpfile with this patches can show unexpected behavior since it
> will refer to invalid p_paddr(always 0). Of course, also current makedumpfile cannot
> work if phys_base isn't 0.
>
> If we don't have any way to get phys_base in 1st kernel environment,
> I think we should disable this feature in older kernel (e.g. by checking kernel version).

Hummm..I had thought that distros with old kernel will backport kernel 
patch and then can use this feature. If we disable it for older kernel, 
then they will not be able to do it.

would it be fine if I cc kernel patch to stable mailing list? It seems 
that patch can be easily applied all older kernel.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

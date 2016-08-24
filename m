Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ua0-x243.google.com ([2607:f8b0:400c:c08::243])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bcMjn-0007pH-Rn
 for kexec@lists.infradead.org; Wed, 24 Aug 2016 01:12:17 +0000
Received: by mail-ua0-x243.google.com with SMTP id 74so145007uau.3
 for <kexec@lists.infradead.org>; Tue, 23 Aug 2016 18:11:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160817082034.GA11837@dhcp-128-65.nay.redhat.com>
References: <1471398657-20237-1-git-send-email-xlpang@redhat.com>
 <20160817082034.GA11837@dhcp-128-65.nay.redhat.com>
From: Yinghai Lu <yinghai@kernel.org>
Date: Tue, 23 Aug 2016 18:11:52 -0700
Message-ID: <CAE9FiQViQiNzz4h=CmeC-KHr9Rf0f_7eR2PMSPs_QChthRd6pg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kexec: Introduce "/sys/kernel/kexec_crash_low_size"
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
To: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Xunlei Pang <xlpang@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

On Wed, Aug 17, 2016 at 1:20 AM, Dave Young <dyoung@redhat.com> wrote:
> On 08/17/16 at 09:50am, Xunlei Pang wrote:
>> "/sys/kernel/kexec_crash_size" only handles crashk_res, it
>> is fine in most cases, but sometimes we have crashk_low_res.
>> For example, when "crashkernel=size[KMG],high" combined with
>> "crashkernel=size[KMG],low" is used for 64-bit x86.
>>
>> Like crashk_res, we introduce the corresponding sysfs file
>> "/sys/kernel/kexec_crash_low_size" for crashk_low_res.
>>
>> So, the exact total reserved memory is the sum of the two.
>>
>> crashk_low_res can also be shrunk via this new interface,
>> and users should be aware of what they are doing.
...
>> @@ -218,6 +238,7 @@ static struct attribute * kernel_attrs[] = {
>>  #ifdef CONFIG_KEXEC_CORE
>>       &kexec_loaded_attr.attr,
>>       &kexec_crash_loaded_attr.attr,
>> +     &kexec_crash_low_size_attr.attr,
>>       &kexec_crash_size_attr.attr,
>>       &vmcoreinfo_attr.attr,
>>  #endif

would be better if you can use attribute_group .is_visible to control showing of
crash_low_size only when the crash_base is above 4G.

Thanks

Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bcWUa-0006pb-2i
 for kexec@lists.infradead.org; Wed, 24 Aug 2016 11:37:12 +0000
Subject: Re: [PATCH v2 1/2] kexec: Introduce "/sys/kernel/kexec_crash_low_size"
References: <1471398657-20237-1-git-send-email-xlpang@redhat.com>
 <20160817082034.GA11837@dhcp-128-65.nay.redhat.com>
 <CAE9FiQViQiNzz4h=CmeC-KHr9Rf0f_7eR2PMSPs_QChthRd6pg@mail.gmail.com>
 <20160824082031.GA13889@dhcp-128-65.nay.redhat.com>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <57BD86E5.30704@redhat.com>
Date: Wed, 24 Aug 2016 19:37:09 +0800
MIME-Version: 1.0
In-Reply-To: <20160824082031.GA13889@dhcp-128-65.nay.redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: xlpang@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>, Yinghai Lu <yinghai@kernel.org>
Cc: Baoquan He <bhe@redhat.com>, Xunlei Pang <xlpang@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

On 2016/08/24 at 16:20, Dave Young wrote:
> On 08/23/16 at 06:11pm, Yinghai Lu wrote:
>> On Wed, Aug 17, 2016 at 1:20 AM, Dave Young <dyoung@redhat.com> wrote:
>>> On 08/17/16 at 09:50am, Xunlei Pang wrote:
>>>> "/sys/kernel/kexec_crash_size" only handles crashk_res, it
>>>> is fine in most cases, but sometimes we have crashk_low_res.
>>>> For example, when "crashkernel=size[KMG],high" combined with
>>>> "crashkernel=size[KMG],low" is used for 64-bit x86.
>>>>
>>>> Like crashk_res, we introduce the corresponding sysfs file
>>>> "/sys/kernel/kexec_crash_low_size" for crashk_low_res.
>>>>
>>>> So, the exact total reserved memory is the sum of the two.
>>>>
>>>> crashk_low_res can also be shrunk via this new interface,
>>>> and users should be aware of what they are doing.
>> ...
>>>> @@ -218,6 +238,7 @@ static struct attribute * kernel_attrs[] = {
>>>>  #ifdef CONFIG_KEXEC_CORE
>>>>       &kexec_loaded_attr.attr,
>>>>       &kexec_crash_loaded_attr.attr,
>>>> +     &kexec_crash_low_size_attr.attr,
>>>>       &kexec_crash_size_attr.attr,
>>>>       &vmcoreinfo_attr.attr,
>>>>  #endif
>> would be better if you can use attribute_group .is_visible to control showing of
>> crash_low_size only when the crash_base is above 4G.
> I have same feeling that it looks odd to show low in sysfs in case no
> crashkernel=,high being used. Even if crashkernel=,high is used only in
> x86 the resource crashk_low is in common code. What do you think to move
> it to x86?

If want to put some restriction on it, I'd prefer to move crashk_low to arch x86, to make
it x86-specific.

We can show the interface unconditionally. If it isn't used, its size is 0, it doesn't matter.

Regards,
Xunlei

>
> Thanks
> Dave
>
>> Thanks
>>
>> Yinghai
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

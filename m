Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf1-f68.google.com ([209.85.167.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fs4ja-0000Vj-OJ
 for kexec@lists.infradead.org; Tue, 21 Aug 2018 11:22:06 +0000
Received: by mail-lf1-f68.google.com with SMTP id f135-v6so13274985lfg.10
 for <kexec@lists.infradead.org>; Tue, 21 Aug 2018 04:21:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <aabec0ea-6611-dc95-3f12-391469790d53@googlemail.com>
References: <e590dc81-7df7-746d-98f2-710f85e03467@googlemail.com>
 <20180820083718.GZ4113@MiWiFi-R3L-srv>
 <cbf043a7-8e95-9486-3441-07ef8f2f86f5@googlemail.com>
 <20180820121721.GA4113@MiWiFi-R3L-srv> <20180820122131.GB4113@MiWiFi-R3L-srv>
 <aabec0ea-6611-dc95-3f12-391469790d53@googlemail.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Tue, 21 Aug 2018 16:51:49 +0530
Message-ID: <CACi5LpP3mVre_uNAGaHFaSzRKAk2BKoRNC-vpvkkt-Yf8zYujA@mail.gmail.com>
Subject: Re: kexec: fix for "Unhandled rela relocation: R_X86_64_PLT32" error
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
To: Chris Clayton <chris2553@googlemail.com>, Simon Horman <horms@verge.net.au>
Cc: Bhupesh SHARMA <bhupesh.linux@gmail.com>, kexec mailing list <kexec@lists.infradead.org>, Baoquan He <bhe@redhat.com>

Thanks for this fix Chris,

I have tested this fix on Fedora 29 and it works fine.

On Mon, Aug 20, 2018 at 8:42 PM, Chris Clayton <chris2553@googlemail.com> wrote:
>
>
> On 20/08/2018 13:21, Baoquan He wrote:
>> Hi Chris,
>>
>> On 08/20/18 at 08:17pm, Baoquan He wrote:
>>> In response to a change in binutils, commit b21ebf2fb4c
>>> (x86: Treat R_X86_64_PLT32 as R_X86_64_PC32) was applied to
>>> the linux kernel during the 4.16 development cycle and has
>>> since been backported to earlier stable kernel series. The
>>> change results in the failure message in $SUBJECT when
>>> rebooting via kexec.
>>>
>>> Fix this by replicating the change in kexec.
>>>
>
> OK.
>
>>> Signed-off-by: Chris Clayton <chris2553@googlemail.com>
>>
>> I adjusted the patch log a little bit, you have tested it on upstream
>> kernel, right?
>>
>
> At the time of my original message (25 July 2018), 4.18.0-rc6+ was the latest upstream. I tested my change on that and
> on the latest stable 4.14 series kernel, which was 4.14.57. I've just tested it with 4.18.3 and 4.14.65 and it works
> fine. I don't have a 4.19 development kernel installed at the moment - I'm busy with other stuff.
>
> Chris
>
>
>> Thanks
>> Baoquan
>>
>>> ---
>>>  kexec/arch/x86_64/kexec-elf-rel-x86_64.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/kexec/arch/x86_64/kexec-elf-rel-x86_64.c b/kexec/arch/x86_64/kexec-elf-rel-x86_64.c
>>> index 7fdde73..db85b44 100644
>>> --- a/kexec/arch/x86_64/kexec-elf-rel-x86_64.c
>>> +++ b/kexec/arch/x86_64/kexec-elf-rel-x86_64.c
>>> @@ -79,6 +79,7 @@ void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr),
>>>                      goto overflow;
>>>              break;
>>>      case R_X86_64_PC32:
>>> +    case R_X86_64_PLT32:
>>>              *(uint32_t *)location = value - address;
>>>              break;
>>>      default:
>>> --
>>> 2.13.6
>>>
>>>

Hi Simon,

This patch fixes an important issue because of which both kdump and
kexec have become non-operational with newer kernels (> 4.18)

We are seeing this issue with newer Fedora versions (for e.g. Fedora
29, please see <https://bugzilla.redhat.com/show_bug.cgi?id=1619122>
for details), so would request you to apply this as an 'urgent' fix to
make sure that the kexec/kdump code keeps working fine with newer
kernel versions as well.

I have tested this on a Fedora 29 x86_64 host and I no longer
encounter the 'Unhandled rela relocation: R_X86_64_PLT32' error.

Please feel free to add to this patch:
Tested-by and Acked-by: Bhupesh Sharma <bhsharma@redhat.com>

Thanks,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

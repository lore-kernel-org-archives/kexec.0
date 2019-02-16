Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gv6a9-0001zt-D1
 for kexec@lists.infradead.org; Sat, 16 Feb 2019 20:29:07 +0000
Received: by mail-pg1-f193.google.com with SMTP id r124so6471979pgr.3
 for <kexec@lists.infradead.org>; Sat, 16 Feb 2019 12:29:05 -0800 (PST)
Subject: Re: [PATCH] makedumpfile/arm64: Add support for ARMv8.2-LPA (52-bit
 PA support)
References: <1549484034-17027-1-git-send-email-bhsharma@redhat.com>
 <CACi5LpNYCY0_0zOCd=7fQ=cLZdinM8Z9xPtmKr5WMmvJruE-6A@mail.gmail.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03567FF6@BPXM09GP.gisp.nec.co.jp>
 <887cb122-0c2e-5fdd-ea54-ecf8adf3cd79@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035682A9@BPXM09GP.gisp.nec.co.jp>
 <0b95bba3-11ab-0bb7-df0a-67ddc0150548@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03568377@BPXM09GP.gisp.nec.co.jp>
 <4a1c4de9-004f-98b2-ca51-b6d60928ddbc@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035685CE@BPXM09GP.gisp.nec.co.jp>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <2618e46c-4406-e322-8d7d-4f11a8fa02ad@redhat.com>
Date: Sun, 17 Feb 2019 01:58:59 +0530
MIME-Version: 1.0
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC035685CE@BPXM09GP.gisp.nec.co.jp>
Content-Language: en-US
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
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: kexec mailing list <kexec@lists.infradead.org>

Hi Kazu,

On 02/14/2019 10:33 PM, Kazuhito Hagio wrote:
> Hi Bhupesh,
> 
> -----Original Message-----
>>>> Yes, the ARMv8 simulator can support both ARMv8.2 LPA and LVA features
>>>> and I tested the above suggestion earlier also on the same and landed
>>>> into incorrect paddress calculation issues.
>>>>
>>>> Since the simulator is slow and its time taking to insert rebuilt
>>>> user-space components in the Linaro initramfs being used on the same, I
>>>> would suggest that we go ahead with the above code for now and later
>>>> when I have more results from the simulator/real hardware, I will send
>>>> out a follow-up patch (if needed) to fix the paddress calculation.
>>>
>>> Hmm, it theoretically needs __pte_to_phys(), right?
>>> So if you have an issue with it, there may be a bug somewhere
>>> and need to debug it. Do you have the detailed information?
>>
>> Its not very easy to get the detailed UART console logs from the
>> simulator, so it is hard to get all the debug logs from makedumpfile, so
>> I am trying debugging the issue via 'gdb' by adding it to the initramfs.
> 
> I don't know what environment the simulater is, but you cannot
> capture a vmcore with cp or something? then debug makedumpfile
> with it on a real arm64 machine. I usually do like this.
> 
>    # cp --sparse=always /proc/vmcore vmcore
> 
> I'm willing to debug it if you would send me the vmcore and vmlinux.

Yes, unfortunately its a very restrictive environment and I cannot get 
network to work on it at my end :(, so its not easy to test new kenrel + 
user-space changes and also to export vmcore or dump logs outside the 
simulator.

However, I was able to create a new simulator vm-image today with the 
required changes and test your suggestions.

Thanks for sharing your  inputs. Accordingly I have incorporated your 
suggestions and have sent a v2 patchset today, merging the LPA and LVA 
makedumpfile changes into a single patchset for easier review.

Please see the same here: 
<http://lists.infradead.org/pipermail/kexec/2019-February/022456.html>

Thanks,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

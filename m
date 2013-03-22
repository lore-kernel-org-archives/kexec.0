Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ia0-x22d.google.com ([2607:f8b0:4001:c02::22d])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UJ9cX-0001J2-UF
 for kexec@lists.infradead.org; Fri, 22 Mar 2013 21:35:30 +0000
Received: by mail-ia0-f173.google.com with SMTP id h37so3960657iak.32
 for <kexec@lists.infradead.org>; Fri, 22 Mar 2013 14:35:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <514CCCB8.4000108@zytor.com>
References: <20130320163131.GE2273@redhat.com>
 <1363807494-25127-1-git-send-email-yinghai@kernel.org>
 <20130322175925.GA10004@redhat.com>
 <CAE9FiQXZP0zbGA=nTg6bHG29sJJRvzNHHbBi1WUsO60cksSUSQ@mail.gmail.com>
 <20130322212104.GI4544@redhat.com> <514CCCB8.4000108@zytor.com>
Date: Fri, 22 Mar 2013 14:35:28 -0700
Message-ID: <CAE9FiQVS+wVzLfe3t4nA7M8wUDGhX073aFvR4Lzh2dz49xdzuw@mail.gmail.com>
Subject: Re: [PATCH] kdump, x86: Process multiple Crash kernel in /proc/iomem
From: Yinghai Lu <yinghai@kernel.org>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On Fri, Mar 22, 2013 at 2:27 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 03/22/2013 02:21 PM, Vivek Goyal wrote:
>>
>> BTW, I had a query about loading 64bit entry point bzImage. In 32bit
>> bzImage entry point logic, we used to load bzImage at the beginning
>> of memory hole and initrd at the end of memory hole. So that bzImage
>> and initramfs are as far as possible and initramfs decompression does
>> not overwrite anything or for that matter setting bss are does not
>> spill over into initramfs.
>>
>> In new code, It looks like we seem to be loading kernel towards the end
>> of the hole.
>>
>>        addr = add_buffer(info, kernel + kern16_size, k_size,
>>                           size, align, 0x100000, -1, -1);
>>
>> IIUC, this has potential that new kernel can overwrite some of the old
>> kernel's data structure while setting up bss. Shouldn't we do it 32bit
>> entry code way where bzImage is loaded towards the beginning of hole and
>> initramfs is loaded towards the end of the hole.
>>
>
> Since boot protocol 2.10+ the kernel actively exports how much memory it
> needs during its setup phase.
>

yes, we got that size that kernel needed from hdr. more lines from the new code.

        /* need to use run-time size for buffer searching */
        dbgprintf("kernel init_size 0x%x\n", real_mode->init_size);
        size = _ALIGN(real_mode->init_size, 4096);
        align = real_mode->kernel_alignment;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

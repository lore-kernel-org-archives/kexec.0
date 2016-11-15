Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it0-f48.google.com ([209.85.214.48])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c6XKJ-0006NF-6x
 for kexec@lists.infradead.org; Tue, 15 Nov 2016 06:34:41 +0000
Received: by mail-it0-f48.google.com with SMTP id q124so173333801itd.1
 for <kexec@lists.infradead.org>; Mon, 14 Nov 2016 22:34:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701E7BD77@BPXM01GP.gisp.nec.co.jp>
References: <cover.1477378297.git.panand@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E7BD77@BPXM01GP.gisp.nec.co.jp>
From: Pratyush Anand <panand@redhat.com>
Date: Tue, 15 Nov 2016 12:04:14 +0530
Message-ID: <CAHB_GuobH3=4_84D-DxcDRyXiV6WNWqQtMKTkKq+nn7vmGXyyA@mail.gmail.com>
Subject: Re: [PATCH Makedumpfile 00/10] arm64 cleanup and kaslr support
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "sgoel@codeaurora.org" <sgoel@codeaurora.org>, "mansip@codeaurora.org" <mansip@codeaurora.org>, "asamson@codeaurora.org" <asamson@codeaurora.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi Atsushi,

There would be a conflict because of following patch while applying
these patches. Other than that I also see a an issue with --config
option. So I will fix that as well and repost the series soon.

0068010b9b83 [PATCH v2 2/2] Clean up unused KERNEL_IMAGE_SIZE

~Pratyush

On Tue, Nov 1, 2016 at 2:41 PM, Atsushi Kumagai
<ats-kumagai@wm.jp.nec.com> wrote:
> Hello Pratyush,
>
>>These patches were lying in my tree for quite some time now. VMCOREINFO
>>numbers/symbols used in these patches have been made part of kdump kernel
>>patches for last few versions including v26. So, there seems no contention
>>on embedding VA_BITS, kimage_voffset and PHYS_OFFSET into vmcore.
>>
>>These patches cleans up a lot arm64 code and also immunize it with many
>>kernel changes. Additionally,it adds 4 level 4K page support and support for
>>KASLR enabled kernel.
>>
>>Azriel Samson (1):
>>  arm64: Add support for 4level 4K page translations table
>>
>>Pratyush Anand (9):
>>  arm64: cleanup code, comment, blank space, blank lines etc
>>  read_vmcoreinfo_long: Allow to read hex values as well
>>  Introduce read_vmcoreinfo_ulong()
>>  arm64: use already available PAGESIZE() and PAGESHIFT() macros
>>  arm64: fix page_offset definition
>>  arm64: fix re-filtering
>>  arm64: use value of VA_BITS and PHYS_OFFSET embedded into vmcore
>>  arm64: immunize identity mapped address finding w.r.t. kernel changes
>>  arm64: fix memory layout as per changes in v4.6 kernel
>>
>> arch/arm64.c   | 245 ++++++++++++++++++++++-----------------------------------
>> makedumpfile.c |  46 +++++++++++
>> makedumpfile.h |  28 +++++--
>> 3 files changed, 162 insertions(+), 157 deletions(-)
>
> Thanks always for your work for arm64, I've reviewed this patch set.
> I'll merge them into v1.6.1.
>
> Regards,
> Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1byz4e-00084t-Eg
 for kexec@lists.infradead.org; Tue, 25 Oct 2016 10:35:17 +0000
Received: by mail-qk0-f180.google.com with SMTP id d23so5401012qke.7
 for <kexec@lists.infradead.org>; Tue, 25 Oct 2016 03:34:56 -0700 (PDT)
Subject: Re: [PATCH Makedumpfile 00/10] arm64 cleanup and kaslr support
References: <cover.1477378297.git.panand@redhat.com>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <ebbc4d83-2b62-80a0-b729-20e04b230d47@redhat.com>
Date: Tue, 25 Oct 2016 16:04:50 +0530
MIME-Version: 1.0
In-Reply-To: <cover.1477378297.git.panand@redhat.com>
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
To: sgoel@codeaurora.org
Cc: ats-kumagai@wm.jp.nec.com, asamson@codeaurora.org, kexec@lists.infradead.org, mansip@codeaurora.org

Hi Sameer,

Although you had already tested my tree on your platform in past. 
However, it would be nice if you can test these posted versions of 
patches just for sanity and provide your tested-by.

~Pratyush

On Tuesday 25 October 2016 12:52 PM, Pratyush Anand wrote:
> These patches were lying in my tree for quite some time now. VMCOREINFO
> numbers/symbols used in these patches have been made part of kdump kernel
> patches for last few versions including v26. So, there seems no contention
> on embedding VA_BITS, kimage_voffset and PHYS_OFFSET into vmcore.
>
> These patches cleans up a lot arm64 code and also immunize it with many
> kernel changes. Additionally,it adds 4 level 4K page support and support for
> KASLR enabled kernel.
>
> Azriel Samson (1):
>   arm64: Add support for 4level 4K page translations table
>
> Pratyush Anand (9):
>   arm64: cleanup code, comment, blank space, blank lines etc
>   read_vmcoreinfo_long: Allow to read hex values as well
>   Introduce read_vmcoreinfo_ulong()
>   arm64: use already available PAGESIZE() and PAGESHIFT() macros
>   arm64: fix page_offset definition
>   arm64: fix re-filtering
>   arm64: use value of VA_BITS and PHYS_OFFSET embedded into vmcore
>   arm64: immunize identity mapped address finding w.r.t. kernel changes
>   arm64: fix memory layout as per changes in v4.6 kernel
>
>  arch/arm64.c   | 245 ++++++++++++++++++++++-----------------------------------
>  makedumpfile.c |  46 +++++++++++
>  makedumpfile.h |  28 +++++--
>  3 files changed, 162 insertions(+), 157 deletions(-)
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
